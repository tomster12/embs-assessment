#include "toplevel.h"
#include <iostream>
#include <cstring>
#include <cassert>

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 1
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS + 1)

void check(uint32_t result, uint32_t expected) {
    std::cout << "Total Path Length: " << result << std::endl;
    assert(result == expected);
    std::cout << "? Test Passed." << std::endl;
}

int main() {

    uint32_t ram[HW_MAX_WORDS];

    // Test: 10x10, 2 waypoints, 0 walls
    memset(ram, 0, sizeof(ram));
    ram[0] = 10;
    ram[1] = 2;
    ram[2] = (0 << 16) | 0;
    ram[3] = (9 << 16) | 9;
    toplevel(ram);
    check(ram[0], 18);

    // Test: 15x15, 3 waypoints, 0 walls
    memset(ram, 0, sizeof(ram));
    ram[0] = 15;
    ram[1] = 3;
    ram[2] = (0 << 16) | 0;
    ram[3] = (9 << 16) | 9;
    ram[4] = (10 << 16) | 2;
    toplevel(ram);
    check(ram[0], 26);

    return 0;
}
