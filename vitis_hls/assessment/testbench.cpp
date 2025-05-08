#include "toplevel.h"
#include <iostream>
#include <cstring>
#include <cassert>

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 2
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS * 2)

void check(uint32_t result, uint32_t expected, uint32_t code) {
    std::cout << "Total Path Length: " << result << ", code: " << code << std::endl;
    assert(result == expected);
    std::cout << "Test Passed." << std::endl;
}

uint8_t get_world_bit(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y) {
    if (x >= world_size || y >= world_size) {
    	printf("Error: get_world_bit coord out of bounds, %lu, %lu outside world of size %lu\r\n", x, y, world_size);
    }
    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    return (world[word] >> bit) & 1;
}

void set_world_bit(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y, uint8_t value) {
    if (x >= world_size || y >= world_size) printf("Failed to set %lu, %lu\r\n", x, y);
    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    world[word] |= (value << bit);
}

void debug_print_world_bitmap(uint32_t *ram) {
	uint16_t world_size = (ram[0] >> 16) & 0xFFFF;
	uint16_t num_waypoints = ram[0] & 0xFFFF;
	uint16_t path_length = ram[1];

    printf("World Bitmap (%u x %u), waypoints=%lu, length=%lu\r\n", world_size, world_size, num_waypoints, path_length);

    // Print waypoint locations
    uint32_t *ram_waypoints = &ram[HW_META_WORDS];
	for (uint8_t i = 0; i < num_waypoints; ++i) {
        uint16_t x = (ram_waypoints[i] >> 16) & 0xFFFF;
        uint16_t y = (ram_waypoints[i]) & 0xFFFF;
        printf("Waypoint %lu at %lu, %lu\r\n", i, x, y);
	}

    // Draw world and path to output
	char output[WORLD_MAX_SIZE * WORLD_MAX_SIZE];
    uint32_t *ram_world = &ram[HW_META_WORDS + HW_WAYPOINT_WORDS];
    for (uint16_t y = 0; y < world_size; ++y) {
        for (uint16_t x = 0; x < world_size; ++x) {
            int world_bit = get_world_bit(ram_world, world_size, x, y);
            output[x + y * world_size] = world_bit == 1 ? 'O' : ' ';
        }
    }
    uint32_t *ram_path = &ram[HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS];
    for (uint32_t i = 0; i < path_length; ++i) {
    	uint16_t x = (ram_path[i] >> 16) & 0xFFFF;
    	uint16_t y = (ram_path[i]) & 0xFFFF;
    	output[x + y * world_size] = '.';
    }

    // Draw output to screen with printf
    for (uint16_t y = 0; y < world_size; ++y) {
        for (uint16_t x = 0; x < world_size; ++x) {
        	printf("%c", output[x + y * world_size]);
        }
        printf("\r\n");
    }
}

int main() {
    uint32_t ram[HW_MAX_WORDS];
    uint32_t code;

    printf("Starting testbench\r\n");

    // Test: 10x10, 8 waypoints, walls (seed=1)
    memset(ram, 0, sizeof(ram));
    ram[0] = (10 << 16) | 8;
    ram[2] = (3 << 16) | 3;
    ram[3] = (7 << 16) | 1;
    ram[4] = (7 << 16) | 5;
    ram[5] = (5 << 16) | 7;
    ram[6] = (1 << 16) | 7;
    ram[7] = (1 << 16) | 0;
    ram[8] = (0 << 16) | 0;
    ram[9] = (0 << 16) | 0;

    uint32_t *ram_world = &ram[HW_META_WORDS + HW_WAYPOINT_WORDS];
    set_world_bit(ram_world, 10, 2, 1, 1);
    set_world_bit(ram_world, 10, 2, 2, 1);
    set_world_bit(ram_world, 10, 2, 3, 1);
    set_world_bit(ram_world, 10, 2, 4, 1);
    set_world_bit(ram_world, 10, 2, 5, 1);
    set_world_bit(ram_world, 10, 2, 6, 1);
    set_world_bit(ram_world, 10, 2, 7, 1);
    set_world_bit(ram_world, 10, 2, 8, 1);
    set_world_bit(ram_world, 10, 4, 8, 1);
    set_world_bit(ram_world, 10, 6, 8, 1);
    set_world_bit(ram_world, 10, 6, 7, 1);
    set_world_bit(ram_world, 10, 6, 6, 1);
    set_world_bit(ram_world, 10, 6, 5, 1);
    set_world_bit(ram_world, 10, 6, 4, 1);
    set_world_bit(ram_world, 10, 6, 3, 1);
    set_world_bit(ram_world, 10, 6, 2, 1);
    set_world_bit(ram_world, 10, 6, 1, 1);
    set_world_bit(ram_world, 10, 8, 2, 1);
    set_world_bit(ram_world, 10, 8, 6, 1);
    set_world_bit(ram_world, 10, 8, 7, 1);
    set_world_bit(ram_world, 10, 8, 8, 1);

    printf("Test: %lu\r\n", ram[0]);
    printf("Test: %lu\r\n", ram[1]);
    printf("Test: %lu\r\n", ram[2]);
    printf("Test: %lu\r\n", ram[3]);
    printf("Test: %lu\r\n", ram[4]);

    printf("Running toplevel from testbench\r\n");
    toplevel(ram, &code);

    debug_print_world_bitmap(ram);
    check(ram[1], 36, code);

    return 0;
}

