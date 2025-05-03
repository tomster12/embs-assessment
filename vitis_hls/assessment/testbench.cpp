#include "toplevel.h"

// RAM format
// 00 -> 16: num_waypoints
// 16 -> 32: size
// 32 -> XX: world bits
// XX -> YY: waypoint positions

#define RAM_WORDS 4096
uint32_t ram[RAM_WORDS];

int main() {
	return 0;
}
