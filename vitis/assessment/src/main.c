// Platform
#include "xil_printf.h"
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

// Networking
#include "netif/xadapter.h"
#include "lwip/dhcp.h"
#include "lwip/sockets.h"
#include "lwipopts.h" // Also needed by FreeRTOS

// Graphics
#include "xil_cache.h"
#include "zybo_z7_hdmi/display_ctrl.h"

// ================================= DECLARATION =================================

// Platform
#define THREAD_STACKSIZE 1024
TaskHandle_t h_lwip_startup_task, h_lwip_dhcp_task, h_lwip_input_task, h_app_task;

// Networking
#define RECV_PORT 51050
#define WS_PORT 51050
#define WS_IP4_ADDR(v) IP4_ADDR(&(v), 192, 168, 10, 1)
unsigned char mac_addr[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x52 };
struct netif server_netif;
struct udp_pcb *udp_pcb;
ip_addr_t ws_ip;

// Graphics
#define MAX_FRAME (1440*900) // 1440x800 based on 4x8 bits for 32-bit colours
#define FRAME_STRIDE (1440*4)
u32 gx_frame_buf[DISPLAY_NUM_FRAMES][MAX_FRAME] __attribute__((aligned(0x20))); // 2 frame buffers of size MAX_FRAME aligned to 32-bits + pointers
void *gx_frame_ptrs[DISPLAY_NUM_FRAMES];
DisplayCtrl gx_dsp_ctrl;

// App
#define WS_RES_BUF_SIZE 1024 * 8
SemaphoreHandle_t ws_res_sem;
uint8_t ws_res_buf[WS_RES_BUF_SIZE];
size_t ws_res_len;

// Functions
void lwip_init();
void lwip_startup_task();
void lwip_dhcp_task();
void print_ip(const char *msg, const ip_addr_t *ip);
void app_task();
int block_until_recv(u16_t time);
void udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, u16_t port, uint8_t *msg, u16_t len);
void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);
void handle_wall_response(uint8_t *data, int len);
void handle_waypoint_response(uint8_t *data, int len);
void display_example();

// ================================= DEFINITION/MAIN =================================

int main(void) {
	xil_printf("\nAssessment program started\n\r");

	// Start lwip_startup_task which will startup lwip_main_task and app_task
	xTaskCreate(lwip_startup_task, "lwip_startup_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_lwip_startup_task);

	// Then start scheduler and run until finished
	vTaskStartScheduler();

	xil_printf("Assessment program finished\n\r");
	return 0;
}

// ================================= DEFINITION/NETWORKING =================================

void lwip_startup_task()
{
	xil_printf("lwip_startup_task started\n\r");

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
    xTaskCreate((void(*)(void*))xemacif_input_thread, "xemacif_lwip_input_task", THREAD_STACKSIZE, &server_netif, DEFAULT_THREAD_PRIO, &h_lwip_input_task);

    // Start DHCP task
    xTaskCreate(lwip_dhcp_task, "lwip_dhcp_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_lwip_dhcp_task);

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

void lwip_dhcp_task()
{
    // DCHP upkeep with periodic dhcp_fine_tmr and dhcp_coars_tmr
	xil_printf("lwip_dhcp_task started\n\r");

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
	xil_printf("app_task started\r\n");

	// Setup the main UDP PCB, server IP, and semaphores
	udp_pcb = udp_new();
	if (!udp_pcb) {
		xil_printf("Error creating UDP PCB\r\n");
		return;
	}
	udp_bind(udp_pcb, IP_ADDR_ANY, RECV_PORT);
	udp_recv(udp_pcb, udp_recv_msg, NULL);
	WS_IP4_ADDR(ws_ip);
	ws_res_sem = xSemaphoreCreateBinary();
	xil_printf("App communicating over port %d\r\n", RECV_PORT);

	// Request and receive walls
	uint8_t data[7] = { 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x10 };
	udp_send_msg(udp_pcb, &ws_ip, WS_PORT, data, sizeof(data));
	if (block_until_recv(5000) == 1) return;
	handle_wall_response(ws_res_buf, ws_res_len);

	// Request and receive waypoints
	data[0] = 0x03;
	udp_send_msg(udp_pcb, &ws_ip, WS_PORT, data, sizeof(data));
	if (block_until_recv(5000) == 1) return;
	handle_waypoint_response(ws_res_buf, ws_res_len);

	// Finally free up this task
	vTaskDelete(NULL);
}

void handle_wall_response(uint8_t *data, int len) {
    if (len < 8 || data[0] != 0x02) {
        xil_printf("Invalid wall response: len=%u, data[0]=%u\r\n", len, data[0]);
        return;
    }

    uint32_t seed = (data[1] << 24) | (data[2] << 16) | (data[3] << 8) | data[4];
    uint16_t size = (data[5] << 8) | data[6];
    uint8_t num_walls = data[7];

    xil_printf("Wall response\r\n");
    xil_printf("- Seed: %lu\r\n", seed);
    xil_printf("- Size: %u\r\n", size);
    xil_printf("- Num walls: %u\r\n", num_walls);

    if (len < 8 + num_walls * 6) {
        xil_printf("- Incomplete wall data\r\n");
        return;
    }

	for (int i = 0; i < num_walls; i++) {
		int offset = 8 + i * 6;
		uint16_t x = (data[offset] << 8) | data[offset + 1];
		uint16_t y = (data[offset + 2] << 8) | data[offset + 3];
		uint8_t length = data[offset + 4];
		uint8_t direction = data[offset + 5];

		xil_printf("- Wall %d: x=%u, y=%u, len=%u, dir=%s\r\n", i,
			x, y, length, direction == 0 ? "vertical" : "horizontal");
	}
}

void handle_waypoint_response(uint8_t *data, int len) {
    if (len < 8 || data[0] != 0x04) {
        xil_printf("Invalid waypoint response: len=%u, data[0]=%u\r\n", len, data[0]);
        return;
    }

    uint32_t seed = (data[1] << 24) | (data[2] << 16) | (data[3] << 8) | data[4];
    uint16_t size = (data[5] << 8) | data[6];
    uint8_t num_waypoints = data[7];

    xil_printf("Waypoint response\r\n");
    xil_printf("- Seed: %lu\r\n", seed);
    xil_printf("- Size: %u\r\n", size);
    xil_printf("- Num waypoints: %u\r\n", num_waypoints);

    if (len < 8 + num_waypoints * 4) {
        xil_printf("- Incomplete waypoint data\r\n");
        return;
    }

	for (int i = 0; i < num_waypoints; i++) {
		int offset = 8 + i * 4;
		uint16_t x = (data[offset] << 8) | data[offset + 1];
		uint16_t y = (data[offset + 2] << 8) | data[offset + 3];
		xil_printf("- Waypoint %d: x=%u, y=%u\r\n", i, x, y);
	}
}

int block_until_recv(u16_t time) {
	if (xSemaphoreTake(ws_res_sem, pdMS_TO_TICKS(time)) == pdTRUE) {
		xil_printf("Semaphore wait success\r\n");
		return 0;
	} else {
		xil_printf("Semamphore wait timeout (%us)\r\n", time);
		return 1;
	}
}

void udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, u16_t port, uint8_t *msg, u16_t len) {
	struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
    if (p == NULL) return;

    memcpy(p->payload, msg, len);
	udp_sendto(pcb, p, ip, port);
	pbuf_free(p);
    xil_printf("Sent %u bytes\r\n", len);
}

void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {
    if (p == NULL) return;

    xil_printf("Received %u bytes\r\n", p->len);
    ws_res_len = p->len > WS_RES_BUF_SIZE ? WS_RES_BUF_SIZE : p->len;
    memcpy(ws_res_buf, p->payload, ws_res_len);
    pbuf_free(p);
    xSemaphoreGiveFromISR(ws_res_sem, NULL);
}

// ================================= DEFINITION/GRAPHICS =================================

void display_example() {
	// Initialize an array of pointers to the 2 frame buffers
	for (int i = 0; i < DISPLAY_NUM_FRAMES; i++)
		gx_frame_ptrs[i] = gx_frame_buf[i];

	// Initialize, set to frame 0, set resolution, start output
	DisplayInitialize(&gx_dsp_ctrl, XPAR_AXIVDMA_0_DEVICE_ID, XPAR_VTC_0_DEVICE_ID, XPAR_HDMI_AXI_DYNCLK_0_BASEADDR, gx_frame_ptrs, FRAME_STRIDE);
	DisplayChangeFrame(&gx_dsp_ctrl, 0);
	DisplaySetMode(&gx_dsp_ctrl, &VMODE_1440x900);
	DisplayStart(&gx_dsp_ctrl);

	printf("\n\r");
	printf("HDMI output enabled\n\r");
	printf("Current Resolution: %s\n\r", gx_dsp_ctrl.vMode.label);
	printf("Pixel Clock Frequency: %.3fMHz\n\r", gx_dsp_ctrl.pxlFreq);
	printf("Drawing gradient pattern to screen...\n\r");

	// Get parameters from display controller struct
	u32 stride = gx_dsp_ctrl.stride / 4;
	u32 width = gx_dsp_ctrl.vMode.width;
	u32 height = gx_dsp_ctrl.vMode.height;
	u32 *frame = (u32 *)gx_dsp_ctrl.framePtr[gx_dsp_ctrl.curFrame];
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
