// Platform
#include <stdint.h>
#include "xil_printf.h" // xil_printf
#include "xil_cache.h" // Needed for Graphics + Hardware
#include "xtoplevel.h"
#include "xuartps_hw.h"
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

// Networking
#include "netif/xadapter.h"
#include "lwip/dhcp.h"
#include "lwip/sockets.h"
#include "lwipopts.h" // Also needed by FreeRTOS

// Graphics
#include "zybo_z7_hdmi/display_ctrl.h"

// ================================= DECLARATION =================================

// Platform
#define THREAD_STACKSIZE 1024
TaskHandle_t h_lwip_startup_task, h_lwip_dhcp_task, h_lwip_input_task, h_app_task;

// Networking
uint8_t nw_mac_addr[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x52 };
struct netif nw_server_netif;
struct udp_pcb *nw_udp_pcb;
ip_addr_t nw_ws_ip;

// Graphics
#define MAX_FRAME (1440*900) // 1440x800 based on 4x8 bits for 32-bit colours
#define FRAME_STRIDE (1440*4)
uint32_t gx_frame_buf[DISPLAY_NUM_FRAMES][MAX_FRAME] __attribute__((aligned(0x20))); // 2 frame buffers of size MAX_FRAME aligned to 32-bits + pointers
void *gx_frame_ptrs[DISPLAY_NUM_FRAMES];
DisplayCtrl gx_dsp_ctrl;

// App
#define MAX_UDP_RES_BUF (1 << 12) // 4096 bytes (max response is 8 + 240 * 6 = 1448 bytes)
#define MAX_UART_IN_BUF (1 << 10) // 1024 bytes
SemaphoreHandle_t udp_res_sem;
uint8_t udp_res_buf[MAX_UDP_RES_BUF];
uint16_t udp_res_buf_len;
char uart_in_buf[MAX_UART_IN_BUF];
uint16_t uart_in_buf_len;

#define RECV_PORT 51050
#define WS_PORT 51050
#define WS_IPV4_ADDR(v) IP4_ADDR(&(v), 192, 168, 10, 1)
#define WORLD_MAX_WALLS 240
#define WORLD_MAX_WAYPOINTS 16
typedef struct __attribute__((packed)) { uint8_t type; uint32_t seed; uint16_t size; } WorldRequest;
typedef struct __attribute__((packed)) { uint16_t x; uint16_t y; uint8_t length; uint8_t direction; } WorldWall;
typedef struct __attribute__((packed)) { uint16_t x; uint16_t y; } WorldWaypoint;
typedef struct __attribute__((packed)) { uint8_t type; uint32_t seed; uint16_t size; uint8_t num_walls; WorldWall walls[WORLD_MAX_WALLS]; } WorldWalls;
typedef struct __attribute__((packed)) { uint8_t type; uint32_t seed; uint16_t size; uint8_t num_waypoints; WorldWaypoint waypoints[WORLD_MAX_WAYPOINTS]; } WorldWaypoints;
typedef struct __attribute__((packed)) { uint8_t type; uint32_t seed; uint16_t size; uint32_t answer; } SolutionAttempt;
typedef struct __attribute__((packed)) { uint8_t type; uint32_t seed; uint16_t size; uint8_t answer; } SolutionResponse;
WorldRequest world_request;
WorldWalls world_walls;
WorldWaypoints world_waypoints;

// Hardware
#define MAX_HW_MEM 5
uint32_t hw_mem[MAX_HW_MEM];

// Functions
void lwip_init();
void lwip_startup_task();
void lwip_dhcp_task();
void print_ip(const char *msg, const ip_addr_t *ip);

void app_task();
void read_uart_line(char *msg);
int parse_world_walls(uint8_t *data, uint8_t data_len, WorldWalls *res);
int parse_world_waypoints(uint8_t *data, uint8_t data_len, WorldWaypoints *res);
int udp_recv_block(uint16_t time);
int udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, uint16_t port, void *msg, uint16_t len);
void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, uint16_t port);

// ================================= DEFINITION/MAIN =================================

int main(void) {
	xil_printf("\r\n==== Assessment program started ====\r\n");

	// Start lwip_startup_task which will startup lwip_main_task and app_task
	xTaskCreate(lwip_startup_task, "lwip_startup_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_lwip_startup_task);

	// Then start scheduler and run until finished
	vTaskStartScheduler();

	xil_printf("====Assessment program finished ====\r\n");
	return 0;
}

// ================================= DEFINITION/NETWORK =================================

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
	if (!xemac_add(&nw_server_netif, &ipaddr, &netmask, &gw, nw_mac_addr, XPAR_XEMACPS_0_BASEADDR)) {
    	xil_printf("Error adding network interface\n\r");
    	return;
    }
    netif_set_default(&nw_server_netif);
    netif_set_up(&nw_server_netif);

    // Start LWIP input task
    xTaskCreate((void(*)(void*))xemacif_input_thread, "xemacif_lwip_input_task", THREAD_STACKSIZE, &nw_server_netif, DEFAULT_THREAD_PRIO, &h_lwip_input_task);

    // Start DHCP task
    dhcp_start(&nw_server_netif);
    xTaskCreate(lwip_dhcp_task, "lwip_dhcp_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_lwip_dhcp_task);

    // Wait until we get an IP address
    while (nw_server_netif.ip_addr.addr == 0) {
    	vTaskDelay(DHCP_FINE_TIMER_MSECS / portTICK_RATE_MS);
	}

	xil_printf("DHCP request success\n\r");
	print_ip("Board IP: ", &nw_server_netif.ip_addr);
	print_ip("Netmask : ", &nw_server_netif.netmask);
	print_ip("Gateway : ", &nw_server_netif.gw);

	// Start app task and close this task
	xTaskCreate(app_task, "app_task", THREAD_STACKSIZE, NULL, DEFAULT_THREAD_PRIO, &h_app_task);

    vTaskDelete(NULL);
}

void lwip_dhcp_task()
{
    // DCHP with periodic dhcp_fine_tmr and dhcp_coars_tmr
	xil_printf("lwip_dhcp_task started\n\r");

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
	nw_udp_pcb = udp_new();
	if (!nw_udp_pcb) {
		xil_printf("Error creating UDP PCB\r\n");
		return;
	}
	WS_IPV4_ADDR(nw_ws_ip);
	udp_bind(nw_udp_pcb, IP_ADDR_ANY, RECV_PORT);
	udp_recv(nw_udp_pcb, udp_recv_msg, NULL);
	udp_res_sem = xSemaphoreCreateBinary();
	xil_printf("App communicating over port %d\r\n", RECV_PORT);

	while (1) {
		// Prompt the user for world params
		xil_printf("\r\n-- Starting World Request --\r\n");
		read_uart_line("Seed: ");
		uint32_t world_seed = (uint32_t)strtoul((char *)uart_in_buf, NULL, 10);
		read_uart_line("World Size: ");
		uint16_t world_size = (uint16_t)strtoul((char *)uart_in_buf, NULL, 10);

		// Send world request for walls
		world_request.type = 0x01;
		world_request.seed = htonl(world_seed);
		world_request.size = htons(world_size);
		if (udp_send_msg(nw_udp_pcb, &nw_ws_ip, WS_PORT, &world_request, sizeof(world_request)) == -1) continue;
		if (udp_recv_block(5000) == 1) continue;
		if (parse_world_walls(udp_res_buf, udp_res_buf_len, &world_walls) == -1) continue;

		// Send world request for waypoints
		world_request.type = 0x03;
		if (udp_send_msg(nw_udp_pcb, &nw_ws_ip, WS_PORT, &world_request, sizeof(world_request)) == -1) continue;
		if (udp_recv_block(5000) == 1) continue;
		if (parse_world_waypoints(udp_res_buf, udp_res_buf_len, &world_waypoints) == -1) continue;
	}

	// Finally free up this task
	vTaskDelete(NULL);
}

void read_uart_line(char *msg)
{
	xil_printf("%s", msg);
    uart_in_buf_len = 0;
    while (uart_in_buf_len < MAX_UART_IN_BUF)
    {
        if (XUartPs_IsReceiveData(STDIN_BASEADDRESS)) {
        	uint8_t c = XUartPs_RecvByte(STDIN_BASEADDRESS);
            if (c == '\r' || c == '\n') break;
			xil_printf("%c", c);
			uart_in_buf[uart_in_buf_len++] = c;
        }
    }
    uart_in_buf[uart_in_buf_len] = '\0';
    xil_printf("\r\n");
}

int parse_world_walls(uint8_t *data, uint8_t data_len, WorldWalls *res) {
	xil_printf("Parsing walls...\r\n");

	if (data_len < 8) {
    	xil_printf("Error: parse_world_walls data_len < 8, actual = %lu\r\n", data_len);
		return -1;
	}
	if (data[0] != 2) {
    	xil_printf("Error: parse_world_walls type != 2, actual = %lu\r\n", data[0]);
		return -1;
	}

	res->type = data[0];
    res->seed = ntohl(*(uint32_t *)(data + 1)); // Dereference data[1] as a uint32_t then flip endian-ness
    res->size = ntohs(*(uint16_t *)(data + 5)); // Dereference data[5] as a uint16_t then flip endian-ness
	res->num_walls = data[7];

	xil_printf("World walls parsed: { %lu, %lu, %lu, %lu }\r\n", res->type, res->seed, res->size, res->num_walls);
	return 0;
}

int parse_world_waypoints(uint8_t *data, uint8_t data_len, WorldWaypoints *res) {
	xil_printf("Parsing waypoints...\r\n");

	if (data_len < 8) {
    	xil_printf("Error: parse_world_waypoints data_len < 8, actual = %lu\r\n", data_len);
		return -1;
	}
	if (data[0] != 4) {
    	xil_printf("Error: parse_world_waypoints type != 4, actual = %lu\r\n", data[0]);
		return -1;
	}

	res->type = data[0];
    res->seed = ntohl(*(uint32_t *)(data + 1)); // Dereference data[1] as a uint32_t then flip endian-ness
    res->size = ntohs(*(uint16_t *)(data + 5)); // Dereference data[5] as a uint16_t then flip endian-ness
	res->num_waypoints = data[7];

	xil_printf("World waypoints parsed: { %lu, %lu, %lu, %lu }\r\n", res->type, res->seed, res->size, res->num_waypoints);
	return 0;
}

int udp_recv_block(uint16_t time) {
	if (xSemaphoreTake(udp_res_sem, pdMS_TO_TICKS(time)) != pdTRUE) {
		xil_printf("Error: Semamphore timeout (%us)\r\n", time);
		return -1;
	}
	return 0;
}

int udp_send_msg(struct udp_pcb *pcb, ip_addr_t *ip, uint16_t port, void *msg, u16_t len) {
	struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
    if (p == NULL) {
    	xil_printf("Error: udp_send_msg pbuf == NULL");
    	return -1;
    }
    memcpy(p->payload, msg, len);
	udp_sendto(pcb, p, ip, port);
	pbuf_free(p);
    xil_printf("(->) Sent %u bytes\r\n", len);
    return 0;
}

void udp_recv_msg(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, uint16_t port) {
    if (p == NULL) {
    	xil_printf("Error: udp_recv_msg pbuf == NULL");
    	return;
    }
    udp_res_buf_len = p->len > MAX_UDP_RES_BUF ? MAX_UDP_RES_BUF : p->len;
    memcpy(udp_res_buf, p->payload, udp_res_buf_len);
    pbuf_free(p);
    xil_printf("(<-) Received %lu bytes\r\n", udp_res_buf_len);
    xSemaphoreGiveFromISR(udp_res_sem, NULL);
}

// ================================= DEFINITION/GRAPHICS =================================

// ================================= EXAMPLES =================================

void hw_example() {
	XToplevel hls;
    Xil_DCacheDisable();
    XToplevel_Initialize(&hls, XPAR_TOPLEVEL_0_DEVICE_ID);

    hw_mem[0] = 0;
    hw_mem[1] = 5;
    hw_mem[2] = 7;
    XToplevel_Set_ram(&hls, (uint32_t) hw_mem);
    XToplevel_Start(&hls);
    while(!XToplevel_IsDone(&hls));
    printf("hw_mem[0]=%lu, hw_mem[1]=%lu, hw_mem[2]=%lu\r\n", hw_mem[0], hw_mem[1], hw_mem[2]);
}

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
	uint32_t stride = gx_dsp_ctrl.stride / 4;
	uint32_t width = gx_dsp_ctrl.vMode.width;
	uint32_t height = gx_dsp_ctrl.vMode.height;
	uint32_t *frame = (uint32_t *)gx_dsp_ctrl.framePtr[gx_dsp_ctrl.curFrame];
	uint32_t red, green, blue;

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
