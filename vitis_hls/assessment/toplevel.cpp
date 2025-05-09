#include "toplevel.h"
#include <string.h> // For memcpy
#include <ap_int.h>

// ================================= DECLARATION =================================

// change WORLD_MAX_SIZE: Coordinates are 9 bytes for a maximum of 500
// change WORLD_MAX_SIZE: Scores are 11 bytes for a maximum of 2000, 500 * 4 for manhattan
// change MAX_OPEN_SET_SIZE: (if big) Update SIFT_DOWN_LOOP and SIFT_UP_LOOP LOOP_TRIPCOUNT
// change MAX_OPEN_SET_SIZE: if safe) Update OS_FIND_LOOP
// change RAM_MAX_WORDS: Update RAM port

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define MAX_OUTPUT_PATH_LENGTH 2000
#define RAM_META_WORDS 2
#define RAM_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define RAM_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define RAM_PATH_WORDS (MAX_OUTPUT_PATH_LENGTH)
#define RAM_MAX_WORDS (RAM_META_WORDS + RAM_WAYPOINT_WORDS + RAM_WORLD_WORDS + RAM_PATH_WORDS)
#define INF_U11 ((1 << 11) - 1)
#define MAX_OPEN_SET_SIZE 5000
#define UNSAFE_SEARCH 0
#define DEBUG_PRINTF 1

#if DEBUG_PRINTF == 1
	#include <iostream>
    #define dbg_printf(...) printf(__VA_ARGS__)
#else
    #define dbg_printf(...) ((void)0)
#endif

struct Coord {
    ap_uint<9> x;
    ap_uint<9> y;
};

struct ASNode {
	ap_uint<11> f_score;
	ap_uint<11> g_score;
	ap_uint<9> x;
	ap_uint<9> y;
};

struct MoveAction {
	ASNode node;
	uint16_t target;
};

static Coord waypoints[WORLD_MAX_WAYPOINTS];
static ASNode open_set_heap[MAX_OPEN_SET_SIZE]; // Min-Heap using an array ordered by f_score
static ap_uint<3> grid_info[WORLD_MAX_SIZE * WORLD_MAX_SIZE]; // (xxx1=open, 00xx->11xx=dir)
static uint32_t local_world[RAM_WORLD_WORDS];
static uint16_t open_set_size;
static uint16_t world_size;
static uint8_t waypoint_count;
static uint32_t error_flag;
const int8_t dx[] = {0, -1, 0, 1};
const int8_t dy[] = {-1, 0, 1, 0};

// ================================= DEFINITION/HELPERS =================================

uint8_t get_world_bit(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    uint32_t idx = x + y * world_size;
    uint32_t word = idx / 32;
    uint32_t bit = idx % 32;
    return (local_world[word] >> bit) & 1;
}

void set_world_bit(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    uint32_t idx = x + y * world_size;
    uint32_t word = idx / 32;
    uint32_t bit = idx % 32;
    local_world[word] |= 1 << bit;
}

uint8_t get_open(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
	return grid_info[x + y * world_size] & 0b001;
}

void set_open(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    grid_info[x + y * world_size] |= 0b001;
}

uint8_t get_dir(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
	return (grid_info[x + y * world_size] & 0b110) >> 1;
}

void set_dir(uint16_t x, uint16_t y, uint8_t dir) {
	#pragma HLS INLINE
    grid_info[x + y * world_size] |= (dir << 1) & 0b110;
}

inline uint16_t abs_sub(uint16_t a, uint16_t b) {
	#pragma HLS INLINE
    return (a > b) ? (a - b) : (b - a);
}

uint16_t heuristic(Coord node, Coord goal) {
	#pragma HLS INLINE
    return abs_sub(node.x, goal.x) + abs_sub(node.y, goal.y);
}

// ================================= DEFINITION/MIN HEAP =================================

void copy_asnode(ASNode *a, ASNode *b) {
	#pragma HLS INLINE
	// This is needed when a and b are lvalues (i think)
	a->f_score = b->f_score;
	a->g_score = b->g_score;
	a->x = b->x;
	a->y = b->y;
}

void os_sift_down(uint16_t idx) {
	#pragma HLS INLINE

	uint16_t current = idx;
	ASNode node = open_set_heap[current];
	MoveAction moves[16];
	uint8_t move_count = 0;

	for (uint8_t i = 0; i < 16; i++) {
	    moves[i].node.f_score = 0;
	    moves[i].node.g_score = 0;
	    moves[i].node.x = 0;
	    moves[i].node.y = 0;
	    moves[i].target = 0;
	}

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_DOWN_LOOP: for (uint8_t depth = 0; depth < 16; ++depth) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16
		#pragma HLS PIPELINE II=1

		uint16_t left = 2 * current + 1;
		uint16_t right = 2 * current + 2;
		ap_uint<11> left_f = INF_U11;
		ap_uint<11> right_f = INF_U11;

		if (left < open_set_size) left_f = open_set_heap[left].f_score;
		if (right < open_set_size) right_f = open_set_heap[right].f_score;

		// Node is smallest so stop
		if (node.f_score < left_f && node.f_score < right_f) {
			break;
		}

		// Left or right is smaller so sift down
		else if (left_f < right_f) {
        	dbg_printf("    [OS] S_DOWN, left %lu(%lu) is smaller than %lu(%lu), sifting\r\n", left, (uint16_t)left_f, current, (uint16_t)node.f_score);
			copy_asnode(&moves[move_count].node, &open_set_heap[left]);
			moves[move_count].target = current;
			move_count++;
			current = left;
		}
		else {
        	dbg_printf("    [OS] S_DOWN, right %lu(%lu) is smaller than %lu(%lu), sifting\r\n", right, (uint16_t)right_f, current, (uint16_t)node.f_score);
			copy_asnode(&moves[move_count].node, &open_set_heap[right]);
			moves[move_count].target = current;
			move_count++;
			current = right;
		}
	}

	// Perform each of the moves then finally move the node
	if (move_count > 0) {
		SIFT_DOWN_COPY_LOOP: for (uint8_t i = 0; i < move_count; ++i) {
			#pragma HLS LOOP_TRIPCOUNT min=1 max=16
			copy_asnode(&open_set_heap[moves[i].target], &moves[i].node);
		}
		copy_asnode(&open_set_heap[current], &node);
	}
}

void os_sift_up(uint16_t idx) {
	#pragma HLS INLINE off

	uint16_t current = idx;
	ASNode node = open_set_heap[current];
	MoveAction moves[16];
	uint8_t move_count = 0;

	for (uint8_t i = 0; i < 16; i++) {
	    moves[i].node.f_score = 0;
	    moves[i].node.g_score = 0;
	    moves[i].node.x = 0;
	    moves[i].node.y = 0;
	    moves[i].target = 0;
	}

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_UP_LOOP: for (uint8_t depth = 0; depth < 16; depth++) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16
		#pragma HLS PIPELINE II=1

		// Reached root so stop
		if (current == 0) {
			dbg_printf("    [OS] S_UP, sifted to the root with f_score %lu\r\n", (uint16_t)node.f_score);
			break;
		}

        // Parent is smaller so stop
        uint16_t parent = (current - 1) / 2;
        if (open_set_heap[parent].f_score < node.f_score) {
        	dbg_printf("    [OS] S_UP, parent %lu(%lu) is smaller than %lu(%lu), stopping\r\n", parent, (uint16_t)open_set_heap[parent].f_score, current, (uint16_t)node.f_score);
        	break;
        }

        // Parent is larger so sift up
    	dbg_printf("    [OS] S_UP, parent %lu(%lu) is bigger than %lu(%lu), sifting\r\n", parent, (uint16_t)open_set_heap[parent].f_score, current, (uint16_t)node.f_score);
		copy_asnode(&moves[move_count].node, &open_set_heap[parent]);
		moves[move_count].target = current;
		move_count++;
		current = parent;
	}

	// Perform each of the moves then finally move the node
	if (move_count > 0) {
		SIFT_UP_COPY_LOOP: for (uint8_t i = 0; i < move_count; ++i) {
			#pragma HLS LOOP_TRIPCOUNT min=1 max=16
			#pragma HLS PIPELINE II=1
			copy_asnode(&open_set_heap[moves[i].target], &moves[i].node);
		}
		copy_asnode(&open_set_heap[current], &node);
	}
}

void os_heap_push(ASNode node) {
	#pragma HLS INLINE

	// Handle max size open set size
    if (open_set_size >= MAX_OPEN_SET_SIZE) {
        open_set_heap[open_set_size - 1] = node;
        error_flag = 20000;
    }

    // Add node to end, then sift up
    else {
        open_set_heap[open_set_size] = node;
        open_set_size++;
    }

    dbg_printf("    [OS] PUSH { %lu, %lu, %lu, %lu }, size=%lu\r\n", (uint16_t)node.f_score, (uint16_t)node.g_score, (uint16_t)node.x, (uint16_t)node.y, open_set_size);

    if (open_set_size > 1) {
        os_sift_up(open_set_size - 1);
    }
}

ASNode os_heap_pop() {
	#pragma HLS INLINE

	// Take first node, move last to start, then sift it down
    ASNode min_node = open_set_heap[0];
    open_set_heap[0] = open_set_heap[open_set_size - 1];
    open_set_size--;

    dbg_printf("    [OS] POP { %lu, %lu, %lu, %lu }, size=%lu\r\n", (uint16_t)min_node.f_score, (uint16_t)min_node.g_score, (uint16_t)min_node.x, (uint16_t)min_node.y, open_set_size);

	if (open_set_size > 1) {
	    os_sift_down(0);
	}

    return min_node;
}

#if UNSAFE_SEARCH == 0
uint16_t os_find(ap_uint<11> x, ap_uint<11> y) {
	#pragma HLS INLINE

	// Return the index matching (x, y)
	OS_FIND_LOOP: for (uint16_t i = 0; i < open_set_size; ++i) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=5000
		if (open_set_heap[i].x == x && open_set_heap[i].y == y) {
			return i;
		}
	}
	return open_set_size;
}
#endif

// ================================= DEFINITION/MAIN =================================

int a_star(Coord start, Coord goal) {
	#pragma HLS INLINE

    ap_uint<11> h_start = heuristic(start, goal);
    ASNode start_node = {h_start, 0, start.x, start.y};
    os_heap_push(start_node);
    if (error_flag != 0) {
    	return 0;
    }

    // if using UNSAFE_SEARCH do not check that any node already exists in the open
    // set when we add it which speeds it all up but means duplication, and therefore:
    //   - Iteration limit needs to be bigger than size * size
    //   - We need to always check get_closed() on each node

#if UNSAFE_SEARCH == 1
    const uint32_t iteration_limit = (uint32_t)(world_size * world_size * 2);
#else
    const uint32_t iteration_limit = world_size * world_size;
#endif

    uint32_t iteration = 0;
    AS_SEARCH_LOOP: for (; iteration < iteration_limit; ++iteration) {
		#pragma HLS PIPELINE

    	if (open_set_size == 0) break;

        ASNode current = os_heap_pop();
        dbg_printf("[I%lu] Current node: { %lu, %lu, %lu, %lu }\r\n", iteration, (uint16_t)current.f_score, (uint16_t)current.g_score, (uint16_t)current.x, (uint16_t)current.y);

        if (current.x == goal.x && current.y == goal.y) {
        	return current.g_score;
        }

#if UNSAFE_SEARCH == 1
        if (get_closed(current.x, current.y)) {
        	dbg_printf("Current is closed { %lu, %lu }\r\n", (uint16_t)current.x, (uint16_t)current.y);
        	continue;
        }
#endif

        set_world_bit(current.x, current.y);

        dbg_printf("Exploring current neighbours\r\n");
        EXPLORE_NEIGHBORS_LOOP: for (uint8_t dir = 0; dir < 4; ++dir) {
			#pragma HLS UNROLL

        	if ((current.x == 0 && dx[dir] < 0) || (current.y == 0 && dy[dir] < 0)) {
        		continue;
        	}

        	ap_uint<9> n_x = current.x + dx[dir];
        	ap_uint<9> n_y = current.y + dy[dir];

            if (n_x >= world_size || n_y >= world_size) {
        		dbg_printf("Neighbour %lu (%d, %d), out of top bounds\r\n", dir, dx[dir], dy[dir]);
            	continue;
            }

            if (get_world_bit(n_x, n_y) == 1) {
        		dbg_printf("Neighbour %lu (%d, %d), blocked\r\n", dir, dx[dir], dy[dir]);
            	continue;
            }

            Coord n_pos = {n_x, n_y};
            ap_uint<11> n_h_score = heuristic(n_pos, goal);
            ap_uint<11> n_g_score = current.g_score + 1;
            ap_uint<11> n_f_score = n_g_score + n_h_score;

#if UNSAFE_SEARCH == 0
            uint8_t to_add = 1;
            uint8_t n_open = get_open(n_x, n_y);
            if (n_open == 1) {
                uint16_t existing_idx = os_find(n_x, n_y);
                if (existing_idx < open_set_size) {

                	// Was found and this is a better route, so update node
                	if (n_f_score < open_set_heap[existing_idx].f_score) {
                    	to_add = 0;
                        dbg_printf("Updating neighbour %lu (%d, %d), pos (%lu, %lu)\r\n", dir, dx[dir], dy[dir], (uint16_t)n_x, (uint16_t)n_y);

                    	open_set_heap[existing_idx].f_score = n_f_score;
                    	open_set_heap[existing_idx].g_score = n_g_score;
                    	set_dir(n_x, n_y, dir);
                    	os_sift_up(existing_idx);
                	}

                	// Was found but this is a worse route, so leave it alone
                	else {
                    	to_add = 0;
                        dbg_printf("Neighbour %lu (%d, %d), pos (%lu, %lu) already exists\r\n", dir, dx[dir], dy[dir], (uint16_t)n_x, (uint16_t)n_y);
                	}
                }
            }

            // Was not found, so add neighbour as new node
            if (to_add == 1) {
                dbg_printf("Adding neighbour %lu (%d, %d), pos (%lu, %lu)\r\n", dir, dx[dir], dy[dir], (uint16_t)n_x, (uint16_t)n_y);

                ASNode neighbour_node = {n_f_score, n_g_score, n_x, n_y};
                set_open(n_x, n_y);
            	set_dir(n_x, n_y, dir);
                os_heap_push(neighbour_node);
                if (error_flag != 0) {
                	return 0;
                }
            }
#else
            // Blindly add the node to the open set
            dbg_printf("Adding neighbour %lu (%d, %d), pos (%lu, %lu)\r\n", dir, dx[dir], dy[dir], (uint16_t)n_x, (uint16_t)n_y);
            ASNode neighbour_node = {n_f_score, n_g_score, n_x, n_y};
            set_open(n_x, n_y);
        	set_dir(n_x, n_y, dir);
            os_heap_push(neighbour_node);
            if (error_flag != 0) {
            	return 0;
            }
#endif
        }
    }

    if (open_set_size == 0) {
    	error_flag = 30000;
    } else {
    	error_flag = 40000;
    }

    return 0;
}

void toplevel(uint32_t *ram, uint32_t *code) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI max_widen_bitwidth=32 depth=9813
	#pragma HLS INTERFACE s_axilite port=code bundle=AXILiteS
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS

	#pragma HLS BIND_STORAGE variable=local_world type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=grid_info type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=open_set_heap type=RAM_1P impl=LUTRAM

	dbg_printf("Starting toplevel\r\n");

    *code = 0;
    error_flag = 0;
    open_set_size = 0;

    COPY_RAM_LOOP: for (uint16_t i = 0; i < RAM_WORLD_WORDS; ++i) {
    	local_world[i] = ram[RAM_META_WORDS + RAM_WAYPOINT_WORDS + i];
    }

    world_size = (ram[0] >> 16) & 0xFFFF;
    waypoint_count = ram[0] & 0xFFFF;

    if (world_size == 0 || world_size > WORLD_MAX_SIZE || waypoint_count < 2 || waypoint_count > WORLD_MAX_WAYPOINTS) {
    	ram[1] = 0;
    	*code = 10000;
    	return;
    }

    WAYPOINT_EXTRACT_LOOP: for (uint8_t i = 0; i < waypoint_count; ++i) {
        uint32_t wp = ram[RAM_META_WORDS + i];
        waypoints[i].x = (wp >> 16) & 0xFFFF;
        waypoints[i].y = wp & 0xFFFF;
    }

    dbg_printf("World size: %lu, waypoint count: %lu\r\n", world_size, waypoint_count);
    dbg_printf("RAM_META_WORDS: %lu, RAM_WAYPOINT_WORDS: %lu, RAM_WORLD_WORDS: %lu, RAM_MAX_WORDS: %lu, RAM_WORLD_OFFSET: %lu, RAM_WORLD_PATH_OFFSET: %lu\r\n",
    		RAM_META_WORDS, RAM_WAYPOINT_WORDS, RAM_WORLD_WORDS, RAM_MAX_WORDS, RAM_META_WORDS + RAM_WAYPOINT_WORDS, RAM_META_WORDS + RAM_WAYPOINT_WORDS + RAM_WORLD_WORDS);

    uint32_t total_length = 0;

    WAYPOINT_LOOP: for (uint8_t i = 0; i < waypoint_count - 1; ++i) {
    	dbg_printf("Pathfinding %lu to %lu\r\n", i, i + 1);

        EMPTY_GRID_INFO_LOOP: for (uint32_t i = 0; i < world_size * world_size; i++) {
    		#pragma HLS LOOP_TRIPCOUNT min=1 max=250000
            #pragma HLS PIPELINE
            grid_info[i] = 0;
        }

        RESET_WORLD_LOOP: for (uint16_t i = 0; i < RAM_WORLD_WORDS; ++i) {
    		#pragma HLS LOOP_TRIPCOUNT min=1 max=7813
    		#pragma HLS PIPELINE
        	local_world[i] = ram[RAM_META_WORDS + RAM_WAYPOINT_WORDS + i];
        }

        open_set_size = 0;

        uint32_t length = a_star(waypoints[i], waypoints[i + 1]);
        total_length += length;

        if (error_flag != 0) {
        	error_flag += (i + 1) * 1;
            break;
        }

        // Write the calculated path to the world path bitmask
        if (total_length < MAX_OUTPUT_PATH_LENGTH) {
            Coord current = waypoints[i + 1];
            MAKE_PATH_LOOP: for (uint32_t i = 0; i <= length; ++i) {
    			#pragma HLS PIPELINE OFF
            	uint32_t node_index = RAM_META_WORDS + RAM_WAYPOINT_WORDS + RAM_WORLD_WORDS + (total_length - i);
            	dbg_printf("Setting path position %lu, %lu at %lu\r\n", (uint16_t)current.x, (uint16_t)current.y, i);
            	ram[node_index] = (current.x << 16) | current.y;
    			uint8_t back_dir = (get_dir(current.x, current.y) + 2) % 4;
    			current.x += dx[back_dir];
    			current.y += dy[back_dir];
            }
        }
    }

    ram[1] = total_length;

    if (total_length > MAX_OUTPUT_PATH_LENGTH) {
    	error_flag += 500;
    }

    *code = error_flag;
}

