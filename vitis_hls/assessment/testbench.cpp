#include "toplevel.h"
#include <iostream>
#include <cstring>
#include <cassert>

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 2
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS)
#define HW_WORLD_OFFSET (HW_META_WORDS + HW_WAYPOINT_WORDS)
#define DBG_LIST_MAX 3000

void check(uint32_t result, uint32_t expected, uint32_t code) {
    std::cout << "Total Path Length: " << result << ", code: " << code << std::endl;
    assert(result == expected);
    std::cout << "Test Passed." << std::endl;
}

int get_world_bit(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y) {
    if (x >= world_size || y >= world_size) {
    	printf("Error: get_world_bit coord out of bounds, %lu, %lu outside world of size %lu\r\n", x, y, world_size);
    	return 1;
    }

    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    return (world[word] >> bit) & 1;
}

int set_world_bit(uint32_t *world, uint16_t world_size, uint16_t x, uint16_t y, uint8_t value) {
	// This is an expected error case
    if (x >= world_size || y >= world_size) {
    	printf("Failed to set %lu, %lu\r\n", x, y);
		return 1;
    }

    uint32_t idx = x + y * world_size;
    uint16_t word = idx / 32;
    uint8_t bit = idx % 32;
    world[word] |= (value << bit);
    return 0;
}

void debug_print_world_bitmap(uint32_t *ram) {
	uint16_t world_size = ram[0];
	uint16_t num_waypoints = ram[1];

    printf("World Bitmap (%u x %u)\r\n", world_size, world_size);

    // Print waypoint locations
    uint32_t *ram_waypoints = &ram[HW_META_WORDS];
	for (uint8_t i = 0; i < num_waypoints; ++i) {
        uint16_t x = (ram_waypoints[i] >> 16) & 0xFFFF;
        uint16_t y = (ram_waypoints[i]) & 0xFFFF;
        printf("Waypoint %lu at %lu, %lu\r\n", i, x, y);
	}

    // Iterate over each row of the world bitmap
    uint32_t *ram_world = &ram[HW_META_WORDS + HW_WAYPOINT_WORDS];
    for (uint16_t y = 0; y < world_size; ++y) {
        for (uint16_t x = 0; x < world_size; ++x) {
            int bit = get_world_bit(ram_world, world_size, x, y);
            if (bit == -1) {
                printf("Error reading world bit at (%u, %u)\n", x, y);
                return;
            }
            printf("%c", bit == 1 ? 'X' : '.');
        }
        printf("\r\n");
    }
}

int main() {
    uint32_t ram[HW_MAX_WORDS];
    uint32_t code;

    // Test: 10x10, 8 waypoints, walls (seed=1)
    memset(ram, 0, sizeof(ram));
    ram[0] = 10;
    ram[1] = 8;
    ram[2] = (3 << 16) | 3;
    ram[3] = (7 << 16) | 1;
    ram[4] = (7 << 16) | 5;
    ram[5] = (5 << 16) | 7;
    ram[6] = (1 << 16) | 7;
    ram[7] = (1 << 16) | 0;
    ram[8] = (0 << 16) | 0;
    ram[9] = (0 << 16) | 0;
    uint32_t *ram_world = &ram[HW_WORLD_OFFSET];
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
    debug_print_world_bitmap(ram);

    toplevel(ram, &code);

    check(ram[0], 36, code);

//    printf("dbg_list");
//    for (uint16_t i = 0; i < DBG_LIST_MAX; ++i) {
//    	if (ram[HW_MAX_WORDS - DBG_LIST_MAX + i] >= 1000) printf("\r\n");
//    	printf("%lu ", ram[HW_MAX_WORDS - DBG_LIST_MAX + i]);
//    }
//    printf("\r\n");

    return 0;
}

