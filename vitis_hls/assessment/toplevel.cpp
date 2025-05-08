#include "toplevel.h"
#include <ap_int.h>

// ================================= DECLARATION =================================

// Coordinates are 9 bytes for a maximum of 500
// Scores are 11 bytes for a maximum of 2000 (500 * 4 for manhattan)

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 1
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS)
#define HW_WORLD_OFFSET (HW_META_WORDS + HW_WAYPOINT_WORDS)
#define INF_U11 ((2 << 10) - 1)
#define MAX_OPEN_SET_SIZE 25000 // 40 bits bytes per node, 1KB per 204 nodes, 1000 nodes ~~ 5KB
#define MAX_TRIPS (WORLD_MAX_WAYPOINTS - 1)
#define MAX_AS_ITERATIONS (WORLD_MAX_SIZE * WORLD_MAX_SIZE)

// #define DEBUG_PRINTF
#ifdef DEBUG_PRINTF
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
	ap_uint<2> from;
};

struct MoveAction {
	ASNode node;
	uint16_t target;
};

static Coord waypoints[WORLD_MAX_WAYPOINTS];
static ASNode open_set_heap[MAX_OPEN_SET_SIZE]; // Min-Heap using an array ordered by f_score
static uint32_t closed_set[HW_WORLD_WORDS]; // Bitmask for closed set, 0=open, 1=closed
static uint32_t local_ram[HW_MAX_WORDS];
static uint16_t open_set_size;
static uint16_t world_size;
static uint8_t waypoint_count;
static int error_flag;

// ================================= DEFINITION/HELPERS =================================

int get_world_bit(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    uint32_t idx = x + y * world_size;
    uint32_t word_idx = idx / 32;
    uint32_t bit_idx = idx % 32;
    return (local_ram[HW_WORLD_OFFSET + word_idx] >> bit_idx) & 1;
}

int is_closed(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    uint32_t idx = x + y * world_size;
    uint32_t word_idx = idx / 32;
    uint32_t bit_idx = idx % 32;
    return (closed_set[word_idx] >> bit_idx) & 1;
}

void set_closed(uint16_t x, uint16_t y) {
	#pragma HLS INLINE
    uint32_t idx = x + y * world_size;
    uint32_t word_idx = idx / 32;
    uint32_t bit_idx = idx % 32;
    closed_set[word_idx] |= (1U << bit_idx);
}

static inline uint16_t abs_sub(uint16_t a, uint16_t b) {
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
	a->from = b->from;
}

void os_sift_down(uint16_t idx) {
	#pragma HLS INLINE

	ASNode node = open_set_heap[idx];
	MoveAction moves[16];
	uint8_t move_count = 0;

	for (uint8_t i = 0; i < 16; i++) {
	    moves[i].node.f_score = 0;
	    moves[i].node.g_score = 0;
	    moves[i].node.x = 0;
	    moves[i].node.y = 0;
	    moves[i].node.from = 0;
	    moves[i].target = 0;
	}

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_DOWN_LOOP: for (uint8_t depth = 0; depth < 16; ++depth) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16
		#pragma HLS PIPELINE II=1

		uint16_t left = 2 * idx + 1;
		uint16_t right = 2 * idx + 2;
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
        	dbg_printf("    [OS] S_DOWN, left %lu(%lu) is smaller than %lu(%lu), sifting\r\n", left, (uint16_t)left_f, idx, (uint16_t)node_f);
			copy_asnode(&moves[move_count].node, &open_set_heap[left]);
			moves[move_count].target = idx;
			move_count++;
			idx = left;
		}
		else {
        	dbg_printf("    [OS] S_DOWN, right %lu(%lu) is smaller than %lu(%lu), sifting\r\n", right, (uint16_t)right_f, idx, (uint16_t)node_f);
			copy_asnode(&moves[move_count].node, &open_set_heap[right]);
			moves[move_count].target = idx;
			move_count++;
			idx = right;
		}
	}

	// Perform each of the moves then finally move the node
	if (move_count > 0) {
		SIFT_DOWN_COPY_LOOP: for (uint8_t i = 0; i < move_count; ++i) {
			#pragma HLS LOOP_TRIPCOUNT min=1 max=16
			copy_asnode(&open_set_heap[moves[i].target], &moves[i].node);
		}
		copy_asnode(&open_set_heap[idx], &node);
	}
}

void os_sift_up(uint16_t idx) {
	#pragma HLS INLINE

	ASNode node = open_set_heap[idx];
	MoveAction moves[16];
	uint8_t move_count = 0;

	for (uint8_t i = 0; i < 16; i++) {
	    moves[i].node.f_score = 0;
	    moves[i].node.g_score = 0;
	    moves[i].node.x = 0;
	    moves[i].node.y = 0;
	    moves[i].node.from = 0;
	    moves[i].target = 0;
	}

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_UP_LOOP: for (uint8_t depth = 0; depth < 16; depth++) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16

		// Reached root so stop
		if (idx == 0) {
			dbg_printf("    [OS] S_UP, sifted to the root with f_score %lu\r\n", (uint16_t)node_f);
			break;
		}

        // Parent is smaller so stop
        uint16_t parent = (idx - 1) / 2;
        ASNode parent_node = open_set_heap[parent];
        if (parent_node.f_score < node.f_score) {
        	dbg_printf("    [OS] S_UP, parent %lu(%lu) is smaller than %lu(%lu), stopping\r\n", parent, (uint16_t)parent_node.f_score, idx, (uint16_t)node_f);
        	break;
        }

        // Parent is larger so sift up
    	dbg_printf("    [OS] S_UP, parent %lu(%lu) is bigger than %lu(%lu), sifting\r\n", parent, (uint16_t)parent_node.f_score, idx, (uint16_t)node_f);
		copy_asnode(&moves[move_count].node, &parent_node);
		moves[move_count].target = idx;
		move_count++;
		idx = parent;
	}

	// Perform each of the moves then finally move the node
	if (move_count > 0) {
		SIFT_UP_COPY_LOOP: for (uint8_t i = 0; i < move_count; ++i) {
			#pragma HLS LOOP_TRIPCOUNT min=1 max=16
			copy_asnode(&open_set_heap[moves[i].target], &moves[i].node);
		}
		copy_asnode(&open_set_heap[idx], &node);
	}
}

void os_heap_push(ASNode node) {
	// #pragma HLS INLINE

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
	// #pragma HLS INLINE

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

// ================================= DEFINITION/MAIN =================================

int a_star(Coord start, Coord goal) {
	#pragma HLS INLINE

    EMPTY_CLOSED_SET_LOOP: for (uint16_t i = 0; i < HW_WORLD_WORDS; ++i) {
    	closed_set[i] = 0;
    }

    open_set_size = 0;

    ap_uint<11> h_start = heuristic(start, goal);
    ASNode start_node = {h_start, 0, start.x, start.y, 0};
    os_heap_push(start_node);
    if (error_flag != 0) {
    	return 0;
    }

    // We do not check that any node already exists in the open set when we add it
    // This speeds it all up a lot, but means duplicated entries and therefore:
    // - Iteration limit needs to be bigger than size * size
    // - We need to always check is_closed() on each node

    const uint32_t iteration_limit = (uint32_t)(world_size * world_size * 2);
    uint32_t iteration = 0;
    AS_SEARCH_LOOP: for (; iteration < iteration_limit; ++iteration) {
		#pragma HLS PIPELINE

    	if (open_set_size == 0) {
    		break;
    	}

        ASNode current = os_heap_pop();

        dbg_printf("[I%lu] Current node: { %lu, %lu, %lu, %lu }\r\n", iteration, (uint16_t)current.f_score, (uint16_t)current.g_score, (uint16_t)current.x, (uint16_t)current.y);

        if (current.x == goal.x && current.y == goal.y) {
        	return current.g_score;
        }

        if (is_closed(current.x, current.y)) {
        	dbg_printf("Current is closed { %lu, %lu }\r\n", (uint16_t)current.x, (uint16_t)current.y);
        	continue;
        }

        set_closed(current.x, current.y);

        dbg_printf("Exploring current neighbours\r\n");
        const int8_t dx[] = {0, -1, 0, 1};
        const int8_t dy[] = {-1, 0, 1, 0};
        EXPLORE_NEIGHBORS_LOOP: for (uint8_t i = 0; i < 4; ++i) {
			#pragma HLS UNROLL

        	if ((current.x == 0 && dx[i] < 0) || (current.y == 0 && dy[i] < 0)) {
        		continue;
        	}

        	ap_uint<9> n_x = current.x + dx[i];
        	ap_uint<9> n_y = current.y + dy[i];

            if (n_x >= world_size || n_y >= world_size) {
        		dbg_printf("Neighbour %lu (%d, %d), out of top bounds\r\n", i, dx[i], dy[i]);
            	continue;
            }

            if (get_world_bit(n_x, n_y)) {
        		dbg_printf("Neighbour %lu (%d, %d), blocked\r\n", i, dx[i], dy[i]);
            	continue;
            }

            if (is_closed(n_x, n_y)) {
        		dbg_printf("Neighbour %lu (%d, %d), closed\r\n", i, dx[i], dy[i]);
            	continue;
            }

            Coord n_pos = {n_x, n_y};
            uint16_t n_g_score_tentative = current.g_score + 1;
            uint16_t n_h_score = heuristic(n_pos, goal);
            uint16_t n_f_score = n_g_score_tentative + n_h_score;

            dbg_printf("Neighbour %lu (%d, %d), pos (%lu, %lu)\r\n", i, dx[i], dy[i], (uint16_t)n_x, (uint16_t)n_y);

            ASNode neighbour_node = {n_f_score, n_g_score_tentative, n_x, n_y, (i + 2) % 4};
            os_heap_push(neighbour_node);
            if (error_flag != 0) {
            	return 0;
            }
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
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI max_widen_bitwidth=32 depth=7827 // <- Match HW_MAX_WORDS
	#pragma HLS INTERFACE s_axilite port=code bundle=AXILiteS
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS

	#pragma HLS BIND_STORAGE variable=local_ram type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=closed_set type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=open_set_heap type=RAM_T2P impl=BRAM

	dbg_printf("Starting toplevel\r\n");

    *code = 0;
    error_flag = 0;
    open_set_size = 0;

    COPY_RAM_LOOP: for (uint16_t i = 0; i < HW_MAX_WORDS; ++i) {
    	local_ram[i] = ram[i];
    }

    world_size = (local_ram[0] >> 16) & 0xFFFF;
    waypoint_count = local_ram[0] & 0xFFFF;

    if (world_size == 0 || world_size > WORLD_MAX_SIZE || waypoint_count < 2 || waypoint_count > WORLD_MAX_WAYPOINTS) {
    	ram[0] = 0;
    	*code = 10000;
    	return;
    }

    WAYPOINT_EXTRACT_LOOP: for (uint8_t i = 0; i < waypoint_count; ++i) {
        uint32_t wp = local_ram[HW_META_WORDS + i];
        waypoints[i].x = (wp >> 16) & 0xFFFF;
        waypoints[i].y = wp & 0xFFFF;
    }

    dbg_printf("World size: %lu, waypoint count: %lu\r\n", world_size, waypoint_count);
    dbg_printf("HW_META_WORDS: %lu, HW_WAYPOINT_WORDS: %lu, HW_WORLD_WORDS: %lu, HW_MAX_WORDS: %lu, HW_WORLD_OFFSET: %lu\r\n",
    		HW_META_WORDS, HW_WAYPOINT_WORDS, HW_WORLD_WORDS, HW_MAX_WORDS, HW_WORLD_OFFSET);

    uint32_t total_length = 0;

    WAYPOINT_LOOP: for (uint8_t i = 0; i < waypoint_count - 1; ++i) {
    	dbg_printf("Pathfinding %lu to %lu\r\n", i, i + 1);

        total_length += a_star(waypoints[i], waypoints[i + 1]);

        if (error_flag != 0) {
        	error_flag += (i + 1) * 1;
            break;
        }
    }

    ram[0] = total_length;
    *code = error_flag;
}


