#include "toplevel.h"
#include <iostream>
#include <cstring>
#include <cassert>

#define MAX_WORLD_WAYPOINTS 16
#define MAX_WORLD_SIZE 500
#define PACKED_WORLD_WORDS ((MAX_WORLD_SIZE * MAX_WORLD_SIZE + 31) / 32)
#define RAM_META_WORDS 2
#define RAM_WAYPOINT_WORDS MAX_WORLD_WAYPOINTS
#define HW_RAM_DATA_WORDS 8000 // Needs to be > PACKED_WORLD_WORDS and > biggest path
#define RAM_MAX_WORDS (RAM_META_WORDS + RAM_WAYPOINT_WORDS + HW_RAM_DATA_WORDS)
#define MAX_OUTPUT_WORLD_SIZE 100

uint8_t get_world_closed(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y) {
    if (x >= world_size || y >= world_size) {
    	printf("Error: get_world_closed coord out of bounds, %lu, %lu outside world of size %lu\r\n", x, y, world_size);
    }
    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    return (world[word] >> bit) & 1;
}

void set_world_closed(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y, uint8_t value) {
    if (x >= world_size || y >= world_size) printf("Failed to set %lu, %lu\r\n", x, y);
    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    world[word] |= (value << bit);
}

void update_char_world(uint32_t *hw_ram, char *char_world, uint8_t type) {
	uint16_t world_size = (hw_ram[0] >> 16) & 0xFFFF;
	uint16_t num_waypoints = hw_ram[0] & 0xFFFF;
	uint16_t path_length = hw_ram[1];

    uint32_t *hw_ram_wp = &hw_ram[RAM_META_WORDS];
    uint32_t *hw_ram_data = &hw_ram[RAM_META_WORDS + RAM_WAYPOINT_WORDS];

    if (type == 0) {
        for (uint16_t y = 0; y < world_size; ++y) {
            for (uint16_t x = 0; x < world_size; ++x) {
                int world_bit = get_world_closed(hw_ram_data, world_size, x, y);
                char_world[x + y * world_size] = world_bit == 1 ? 'O' : ' ';
            }
        }
    }
    else if (type == 1) {
        for (uint32_t i = 0; i < path_length; ++i) {
        	uint16_t x = (hw_ram_data[i] >> 16) & 0xFFFF;
        	uint16_t y = (hw_ram_data[i]) & 0xFFFF;
			char_world[x + y * world_size] = '.';
        }
    }
    for (uint8_t i = 0; i < num_waypoints; ++i) {
    	uint16_t x = (hw_ram_wp[i] >> 16) & 0xFFFF;
    	uint16_t y = hw_ram_wp[i] & 0xFFFF;
    	char_world[x + y * world_size] = 'x';
    }
}

void print_char_world(uint32_t *hw_ram, char *char_world) {
	uint16_t world_size = (hw_ram[0] >> 16) & 0xFFFF;
	uint16_t num_waypoints = hw_ram[0] & 0xFFFF;
	uint16_t path_length = hw_ram[1];

	printf("World: size=%u, waypoints=%lu, length=%lu.\r\n", world_size, num_waypoints, path_length);

	printf("Waypoints: ");
	uint32_t *hw_ram_waypoints = &hw_ram[RAM_META_WORDS];
	for (uint8_t i = 0; i < num_waypoints; ++i) {
		uint16_t x = (hw_ram_waypoints[i] >> 16) & 0xFFFF;
		uint16_t y = (hw_ram_waypoints[i]) & 0xFFFF;
		printf("%lu:(%lu, %lu) ", i, x, y);
	}
	printf("\r\n");

	if (world_size > MAX_OUTPUT_WORLD_SIZE) {
		printf("Not drawing world because it is too big (%lu > %lu)\r\n", world_size, MAX_OUTPUT_WORLD_SIZE);
	} else {
		printf("   |");
		for (uint16_t x = 0; x < world_size; ++x) {
			printf("%lu", x % 10);
		}
		printf("\r\n");
		for (uint16_t x = 0; x < world_size + 4; ++x) {
			if (x == 3) printf("+");
			else printf("-");
		}
		printf("\r\n");
		for (uint16_t y = 0; y < world_size; ++y) {
			printf("  %lu|", y % 10);
			for (uint16_t x = 0; x < world_size; ++x) {
				printf("%c", char_world[x + y * world_size]);
			}
			printf("\r\n");
		}
	}
}

int main() {
    printf("Starting testbench\r\n");

    uint32_t code;
    char char_world[MAX_WORLD_SIZE * MAX_WORLD_SIZE];
    uint32_t hw_ram[RAM_MAX_WORDS] = {0x00640010,0x00000000,0x00160017,0x00530039,0x002F0044,0x0062000D,0x001A0031,0x00030030,0x00010025,0x004A005E,0x002C000B,0x0016001D,0x00320038,0x001C005D,0x00020008,0x00110047,0x005D0021,0x000F0058,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xFFFFC000,0x00000007,0x00000000,0x00000FFC,0x00000000,0x00007FC0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x007FFF80,0xFC000000,0x0007FFFF,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xFFFFFFF0,0x00000007,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xF8000000,0x00000FFF,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x3FFFFFFF,0xFFE00000,0x000007FF,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x02000000,0x00000000,0x00000000,0x20000000,0x00000000,0x00000000,0x7F000000,0x00000002,0x00000000,0x00000000,0x00000020,0x00000000,0x00000000,0x00000200,0x00000000,0x00000000,0x00002000,0x00000000,0x00000000,0x00020000,0x00000000,0xFF000000,0x002001FF,0x00000000,0x00000200,0x02010000,0x00000001,0x00002000,0x20100000,0x00000010,0xC0020000,0x013FFFFF,0x00000102,0x00200000,0x10000000,0x00001000,0x02000000,0x00000000,0x00010071,0x20000000,0x00000000,0x00100010,0x00000000,0x00000002,0x01100100,0x00000000,0x00000020,0x11001000,0x00000000,0x00000200,0x10010000,0x00000001,0x00002000,0x20100000,0x00000091,0xFF820000,0x013FFFFF,0x01000912,0x00200000,0x10000000,0x10009120,0x02000000,0x00000000,0x00091201,0x20000001,0x00000000,0x00912010,0x00000010,0x00000002,0x09120100,0x00000100,0x00000020,0x91201000,0x00001000,0x00000000,0x12790000,0x00010009,0x00000000,0x20100000,0x00100091,0x00000000,0x00020000,0x01000912,0x00000000,0x00200000,0x10009120,0x00000000,0x02000000,0x00091200,0x00000001,0x20000000,0x00912000,0x00000010,0x00000000,0x09120002,0x00000100,0x00000000,0x91210020,0x00001000,0x00000000,0x12100200,0x00010009,0xFFFFC000,0x210027FF,0x00100091,0x00000000,0x10020000,0x01000912,0x00000002,0x00200000,0x10009121,0x00000020,0x02000000,0x00091210,0x00000201,0x20000000,0x00902100,0xFF002010,0x003FFFFF,0x09021002,0x00020100,0x00000000,0x90210020,0x00201000,0x00000000,0x02100200,0x02010008,0x00000000,0x21002000,0x20100080,0x00000000,0x10020000,0x41000002,0x01FFFFF2,0x00000000,0x10000021,0xFFFF8024,0x0000007F,0x00000210,0xFFC00240,0x0003FFFF,0x00002100,0x00002400,0x40000000,0x00021000,0x00024000,0x7FFC0000,0x00210004,0x00240001,0x1FF80000,0x02100040,0x02400010,0x00000000,0x03000400,0x24000100,0x00000000,0x30004000,0x40001000,0x00000002,0x00040000,0x00010003,0x00000024,0x00400000,0x00100030,0x00000240,0x04000000,0x01000300,0x00002400,0x40007FF0,0x10003000,0x80024000,0x00000000,0x00030004,0x00240001,0x00000009,0x00300040,0x02400010,0x007FFC90,0x03000400,0x24100100,0x00000900,0x30004000,0x41001000,0x00009002,0x00000000,0x10010003,0x00090020,0x00000000,0x00100030,0x00900201,0x00000000,0x01000300,0x09002010,0x00000000,0x10003000,0x90020100,0x00000000,0x00020000,0x00001000,0x00000009,0x00200000,0x00010000,0x00000090,0x02000000,0x00100000,0x00000900,0x20000000,0x01020000,0x00009000,0x00200000,0x50200002,0x00090000,0x02000000,0x02000020,0x0090000D,0x20000000,0x20000000,0x090000D0,0x00000000,0x00000002,0xB0000D02,0x3FFFF800,0x00000020,0x0000C020,0x0000000B,0x00000200,0x000C0200,0x000000B0,0x00002000,0x00C02000,0xF8000B00,0x00021FFF,0x0C020000,0x0000A000,0x00200000,0xC0200000,0x00020000,0x02000000,0x02000020,0x0020000C,0x20000000,0x00000200,0x00000000,0x00000000,0x00000000};

    printf("Running toplevel from testbench\r\n");

    update_char_world(hw_ram, char_world, 0);
    toplevel(hw_ram, &code);
    update_char_world(hw_ram, char_world, 1);
    print_char_world(hw_ram, char_world);

    return 0;
}

