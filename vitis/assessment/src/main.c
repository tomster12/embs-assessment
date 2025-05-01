// ---- Platform
#include "xil_printf.h"
#include "FreeRTOS.h"
#include "task.h"

// ---- Networking
#include "netif/xadapter.h"
#include "lwip/dhcp.h"
#include "lwip/sockets.h"
// #include "lwip/inet.h"
// #include "lwip/err.h"
// #include "lwip/sys.h"
#include "lwipopts.h" // Also needed by FreeRTOS

// ---- Graphics
#include "xil_cache.h"
#include "zybo_z7_hdmi/display_ctrl.h"

// ================================= DECLARATION =================================

// ---- Platform
#define THREAD_STACKSIZE 1024
TaskHandle_t h_nw_startup_task, h_nw_dhcp_task, h_nw_rcv_task, h_app_task;

// ---- Networking
#define RECV_PORT 51050
#define WS_PORT 51050
#define WS_IP4_ADDR(v) \
    IP4_ADDR(&(v), 192, 168, 10, 1)
unsigned char mac_addr[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x52 };
struct netif server_netif;
struct netif *echo_netif;
struct udp_pcb *udp_pcb;
ip_addr_t ws_ip;

// ---- Graphics
#define MAX_FRAME (1440*900) // 1440x800 based on 4x8 bits for 32-bit colours
#define FRAME_STRIDE (1440*4)
u32 frameBuf[DISPLAY_NUM_FRAMES][MAX_FRAME] __attribute__((aligned(0x20))); // 2 frame buffers of size MAX_FRAME aligned to 32-bits + pointers
void *pFrames[DISPLAY_NUM_FRAMES];
DisplayCtrl disp_ctrl;

// ---- Source
void lwip_init();
void nw_startup_task();
void nw_dhcp_task();
void print_ip(const char *msg, const ip_addr_t *ip);
void app_task();
void udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, u16_t port, uint8_t *msg, unsigned int len);
void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);
void display_example();

// ================================= DEFINITION/MAIN =================================

int main(void) {
	xil_printf("Assessment app started\n\r");

	// Start nw_startup_task which will startup nw_main_task and app_task
	xTaskCreate(nw_startup_task, "nw_startup_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_nw_startup_task);

	// Then start scheduler and run until finished
	vTaskStartScheduler();

	xil_printf("Assessment app finished\n\r");
	return 0;
}

// ================================= DEFINITION/NETWORKING =================================

void nw_startup_task()
{
	xil_printf("nw_startup_task started\n\r");

	// Initialize LWIP
    lwip_init();

    // Set my network interface as default
    ip_addr_t ipaddr, netmask, gw;
	ipaddr.addr = 0;
	netmask.addr = 0;
	gw.addr = 0;

	if (!xemac_add(&server_netif, &ipaddr, &netmask, &gw, mac_addr, XPAR_XEMACPS_0_BASEADDR)) {
    	xil_printf("Error adding network interface\n\r");
    	return;
    }

    netif_set_default(&server_netif);
    netif_set_up(&server_netif);

    // Start LWIP input task
    xTaskCreate((void(*)(void*))xemacif_input_thread, "xemacif_nw_recv_thread", THREAD_STACKSIZE, &server_netif, DEFAULT_THREAD_PRIO, &h_nw_rcv_task);

    // Start DHCP task
    xTaskCreate(nw_dhcp_task, "nw_dhcp_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_nw_dhcp_task);

    // Wait until we get an IP address
    while (server_netif.ip_addr.addr == 0) {
    	vTaskDelay(DHCP_FINE_TIMER_MSECS / portTICK_RATE_MS);
	}

	xil_printf("DHCP request success\n\r");
	print_ip("Board IP: ", &server_netif.ip_addr);
	print_ip("Netmask : ", &server_netif.netmask);
	print_ip("Gateway : ", &server_netif.gw);

	// Start app task and close this task
	xTaskCreate(app_task, "app_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_app_task);

    vTaskDelete(NULL);
}

void nw_dhcp_task()
{
    // DCHP upkeep with periodic dhcp_fine_tmr and dhcp_coars_tmr
	xil_printf("nw_dhcp_task started\n\r");

    dhcp_start(&server_netif);

    int mscnt = 0;
    while (1) {
		vTaskDelay(DHCP_FINE_TIMER_MSECS / portTICK_RATE_MS);
		dhcp_fine_tmr();
		mscnt += DHCP_FINE_TIMER_MSECS;
		if (mscnt >= DHCP_COARSE_TIMER_SECS*1000) {
			dhcp_coarse_tmr();
			mscnt = 0;
		}
	}
}

void print_ip(const char *msg, const ip_addr_t *ip)
{
	xil_printf(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip), ip4_addr3(ip), ip4_addr4(ip));
}

// ================================= DEFINITION/APP =================================

void app_task() {
	xil_printf("app_task started\n");

	// Setup the main UDP PCB
	udp_pcb = udp_new();
	if (!udp_pcb) {
		xil_printf("Error creating UDP PCB\r\n");
		return;
	}
	udp_bind(udp_pcb, IP_ADDR_ANY, RECV_PORT);
	udp_recv(udp_pcb, udp_recv_msg, NULL);
	xil_printf("Listening on *:%d\r\n", RECV_PORT);

	// Send a message to the server
	WS_IP4_ADDR(ws_ip);
	uint8_t data[7] = { 0x01, 0x01, 0x02, 0x03, 0x04, 0x01, 0x00 };
	udp_send_msg(udp_pcb, &ws_ip, WS_PORT, data, sizeof(data));
	xil_printf("Sent message to server\r\n");

	// Finally free up this task
	vTaskDelete(NULL);
}

void udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, u16_t port, uint8_t *msg, unsigned int len) {
	// Put message into a pbuf, send it across, then free pbuf
	struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
    if (p == NULL) return;
    memcpy(p->payload, msg, len);
	udp_sendto(pcb, p, ip, port);
	pbuf_free(p);
}

void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {
    if (p == NULL) return;

    // Read in a pbuf and attempt to parse
    //uint8_t *buf = (uint8_t *)p->payload;
    //uint16_t len = p->len;

    char msg[p->len + 1];
    memcpy(msg, p->payload, p->len);
    msg[p->len] = '\0';
    printf("Message: %s\n", msg);

    pbuf_free(p);
}

// ================================= DEFINITION/GRAPHICS =================================

void display_example() {
	// Initialize an array of pointers to the 2 frame buffers
	for (int i = 0; i < DISPLAY_NUM_FRAMES; i++)
		pFrames[i] = frameBuf[i];

	// Initialize, set to frame 0, set resolution, start output
	DisplayInitialize(&disp_ctrl, XPAR_AXIVDMA_0_DEVICE_ID, XPAR_VTC_0_DEVICE_ID, XPAR_HDMI_AXI_DYNCLK_0_BASEADDR, pFrames, FRAME_STRIDE);
	DisplayChangeFrame(&disp_ctrl, 0);
	DisplaySetMode(&disp_ctrl, &VMODE_1440x900);
	DisplayStart(&disp_ctrl);

	printf("\n\r");
	printf("HDMI output enabled\n\r");
	printf("Current Resolution: %s\n\r", disp_ctrl.vMode.label);
	printf("Pixel Clock Frequency: %.3fMHz\n\r", disp_ctrl.pxlFreq);
	printf("Drawing gradient pattern to screen...\n\r");

	// Get parameters from display controller struct
	u32 stride = disp_ctrl.stride / 4;
	u32 width = disp_ctrl.vMode.width;
	u32 height = disp_ctrl.vMode.height;
	u32 *frame = (u32 *)disp_ctrl.framePtr[disp_ctrl.curFrame];
	u32 red, green, blue;

	// Fill the screen with a nice gradient pattern
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			green = (x*0xFF) / width;
			blue = 0xFF - ((x*0xFF) / width);
			red = (y*0xFF) / height;
			frame[y*stride + x] = (red << BIT_DISPLAY_RED) | (green << BIT_DISPLAY_GREEN) | (blue << BIT_DISPLAY_BLUE);
		}
	}

	// Flush the cache, so the Video DMA core can pick up our frame buffer changes.
	// Flushing the entire cache (rather than a subset of cache lines) makes sense as our buffer is so big
	Xil_DCacheFlush();
	printf("Done.\n\r");
}

































