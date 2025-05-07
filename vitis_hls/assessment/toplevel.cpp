#include "toplevel.h"
#include <string.h> // For memcpy, memset

// ================================= DECLARATION =================================

#define WORLD_MAX_WAYPOINTS 16
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 2
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS)
#define HW_WORLD_OFFSET (HW_META_WORDS + HW_WAYPOINT_WORDS)
#define INF UINT16_MAX
#define MAX_OPEN_SET_SIZE 40000 // 8 bytes per node, 1KB per 128 nodes, 1000 nodes ~~ 8KB
#define MAX_TRIPS (WORLD_MAX_WAYPOINTS - 1)
#define MAX_AS_ITERATIONS (WORLD_MAX_SIZE * WORLD_MAX_SIZE)

// #define DEBUG_PRINTF
// #define DEBUG_LIST
#ifdef DEBUG_PRINTF
	#include <iostream>
    #define dbg_printf(...) printf(__VA_ARGS__)
#else
    #define dbg_printf(...) ((void)0)
#endif
#ifdef DEBUG_LIST
	#define DBG_LIST_MAX 3000
	static uint32_t dbg_list[DBG_LIST_MAX];
	static uint16_t dbg_list_counter;
	#define dbg_list_write(x) dbg_list[dbg_list_counter++] = x;
#else
	#define dbg_list_write(x) ((void)0)
#endif

struct Coord {
    uint16_t x;
    uint16_t y;
};

struct ASNode {
    uint16_t f_score;
    uint16_t g_score;
    uint16_t x;
    uint16_t y;
};

static ASNode open_set_heap[MAX_OPEN_SET_SIZE]; // Min-Heap using an array ordered by f_score
static uint32_t closed_set[HW_WORLD_WORDS]; // Bitmask for closed set, 0=open, 1=closed
static uint32_t local_ram[HW_MAX_WORDS];
static uint32_t open_set_size;
static uint32_t *world_ram_ptr;
static uint16_t world_size;
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

void copy_as_node(ASNode *a, ASNode *b) {
	#pragma HLS INLINE
	a->f_score = b->f_score;
	a->g_score = b->g_score;
	a->x = b->x;
	a->y = b->y;
}

void dump_os_to_dbg_list() {
	dbg_list_write(4050);
	for (uint16_t i = 0; i < open_set_size; ++i) {
		dbg_list_write(open_set_heap[i].x);
		dbg_list_write(open_set_heap[i].y);
		dbg_list_write(open_set_heap[i].f_score);
	}
}

void os_sift_down(uint16_t idx) {
	#pragma HLS INLINE

	uint16_t previous = idx;
	ASNode node;
	copy_as_node(&node, &open_set_heap[idx]);
	uint16_t node_f = node.f_score;

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_DOWN_LOOP: for (uint8_t depth = 0; depth < 16; ++depth) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16

		// Read left and right child nodes
		uint16_t smallest = idx;
		uint16_t left = 2 * idx + 1;
		uint16_t right = 2 * idx + 2;
		uint16_t left_f = INF;
		uint16_t right_f = INF;
		if (left < open_set_size) left_f = open_set_heap[left].f_score;
		if (right < open_set_size) right_f = open_set_heap[right].f_score;

		// Node is smallest so stop sifting down
		if (node_f < left_f && node_f < right_f) {
			if (idx != previous) {
				copy_as_node(&open_set_heap[idx], &node);
			}
			dbg_printf("(OS) S_DOWN, current %lu(%lu) is smaller than %lu(%lu) and %lu(%lu), stopping\r\n", idx, node_f, left, left_f, right, left_f);
		    dump_os_to_dbg_list();
			break;
		}

		// Left or right is smaller so sift down
		else if (left_f < right_f) {
			copy_as_node(&open_set_heap[idx], &open_set_heap[left]);
			dbg_printf("(OS) S_DOWN, left %lu(%lu) is smaller than %lu(%lu) and %lu(%lu), sitfing to %lu\r\n", left, left_f, idx, node_f, right, right_f, idx);
		    dbg_list_write(4001);
		    dbg_list_write(left);
		    dbg_list_write(idx);
			idx = left;
		}
		else {
			copy_as_node(&open_set_heap[idx], &open_set_heap[right]);
			dbg_printf("(OS) S_DOWN, right %lu(%lu) is smaller than %lu(%lu) and %lu(%lu), sitfing to %lu\r\n", right, right_f, idx, node_f, left, left_f, idx);
		    dbg_list_write(4001);
			dbg_list_write(right);
			dbg_list_write(idx);
			idx = right;
		}
	}
}

void os_sift_up(uint16_t idx) {
	#pragma HLS INLINE

	uint16_t previous = idx;
	ASNode node;
	copy_as_node(&node, &open_set_heap[idx]);
	uint16_t node_f = node.f_score;

    dbg_list_write(4021);
    dbg_list_write(idx);
	dbg_list_write(node.x);
	dbg_list_write(node.y);
	dbg_list_write(node.f_score);

	// Loop limit of ceil(log2(MAX_OPEN_SET_SIZE)) = 16 for MAX_OPEN_SET_SIZE=65536
	SIFT_UP_LOOP: for (uint8_t depth = 0; depth < 16; depth++) {
		#pragma HLS LOOP_TRIPCOUNT min=1 max=16
		#pragma HLS PIPELINE II=1

		// Reached root so stop sifting
		if (idx == 0) {
			if (idx != previous) {
			    dbg_list_write(4022);
				dbg_list_write(idx);
				dbg_list_write(node.x);
				dbg_list_write(node.y);
				dbg_list_write(node.f_score);
				copy_as_node(&open_set_heap[idx], &node);
				dump_os_to_dbg_list();
			}
			dbg_printf("(OS) S_UP, sifted to the root with f %ul\r\n", node_f);
			break;
		}

        uint16_t parent = (idx - 1) / 2;
        ASNode parent_node = open_set_heap[parent];

        // Parent is smaller so stop sifting
        if (parent_node.f_score < node_f) {
			if (idx != previous) {
			    dbg_list_write(4022);
				dbg_list_write(idx);
				dbg_list_write(node.x);
				dbg_list_write(node.y);
				dbg_list_write(node.f_score);
				copy_as_node(&open_set_heap[idx], &node);
				dump_os_to_dbg_list();
			}
        	dbg_printf("    [OS] S_UP, parent %lu(%lu) is smaller than %lu(%lu), stopping\r\n", parent, parent_node.f_score, idx, node_f);
        	break;
        }

        // Otherwise we are smaller so sift up
    	dbg_printf("    [OS] S_UP, parent %lu(%lu) is bigger than %lu(%lu), sifting\r\n", parent, parent_node.f_score, idx, node_f);
	    dbg_list_write(4002);
		dbg_list_write(parent);
		dbg_list_write(idx);
		copy_as_node(&open_set_heap[idx], &parent_node);
		idx = parent;
	}
}

void os_heap_push(ASNode node) {
	#pragma HLS INLINE

	// Stop once the heap is full
    if (open_set_size >= MAX_OPEN_SET_SIZE) {
    	error_flag = 20000;
    	return;
    }

    // Add a node to the end then recursively sift upwards
    open_set_heap[open_set_size] = node;
    open_set_size++;
    dbg_printf("    [OS] PUSH { %lu, %lu, %lu, %lu }, size=%lu\r\n", node.f_score, node.g_score, node.x, node.y, open_set_size);
    dbg_list_write(4000);
	dbg_list_write(open_set_size);
    dbg_list_write(node.x);
    dbg_list_write(node.y);
    dbg_list_write(node.f_score);

    if (open_set_size > 1) {
        os_sift_up(open_set_size - 1);
    }

    dump_os_to_dbg_list();
}

ASNode os_heap_pop() {
	#pragma HLS INLINE

	// Grab the top node to be returned
    ASNode min_node = open_set_heap[0];

	// Move last node to start then recursively sift downwards
    open_set_heap[0] = open_set_heap[open_set_size - 1];
    open_set_size--;

	dbg_printf("    [OS] POP { %lu, %lu, %lu, %lu }, size=%lu\r\n", min_node.f_score, min_node.g_score, min_node.x, min_node.y, open_set_size);
    dbg_list_write(4003);
	dbg_list_write(open_set_size);

	if (open_set_size > 1) {
	    os_sift_down(0);
	}

    dump_os_to_dbg_list();

    return min_node;
}

// ================================= DEFINITION/MAIN =================================

int a_star_len(Coord start, Coord goal) {
	#pragma HLS INLINE off

    // Clear the closed set and open set
    uint32_t closed_words = (world_size * world_size + 31) / 32;
    memset(closed_set, 0, HW_WORLD_WORDS * sizeof(uint32_t));
    memset(open_set_heap, 0, MAX_OPEN_SET_SIZE * sizeof(ASNode));
    open_set_size = 0;

    // Initialize start node and add to open set
    uint16_t h_start = heuristic(start, goal);
    ASNode start_node = {h_start, 0, start.x, start.y};
    os_heap_push(start_node);
    if (error_flag != 0) return INF;

    // Start the A* loop with a semi-informed arbitrary limit on iterations
    const uint32_t iteration_limit = (uint32_t)(world_size * world_size * 2);
    uint32_t iteration_count = 0;
    AS_SEARCH_LOOP: while (open_set_size > 0 && iteration_count < iteration_limit) {

        // Get node with lowest f_score
        ASNode current = os_heap_pop();

        dbg_printf("[I%lu] Current node: { %lu, %lu, %lu, %lu }\r\n", iteration_count, current.f_score, current.g_score, current.x, current.y);
        dbg_list_write(2000 + iteration_count);
        dbg_list_write(current.x);
        dbg_list_write(current.y);
        dbg_list_write(current.f_score);

        // If this node is the goal return the path length
        if (current.x == goal.x && current.y == goal.y) return current.g_score;

        // Skip previously closed set nodes (e.g. multiple entries placed into open before processing)
        if (is_closed(current.x, current.y)) {
    		dbg_list_write(2500 + iteration_count);
        	dbg_printf("Current is closed { %lu, %lu }\r\n", current.x, current.y);
        	continue;
        }

        // Add current node to the closed set
        set_closed(current.x, current.y);

        // Visit each neighbour
        dbg_printf("Exploring current neighbours\r\n");
        const int dx[] = {0, 0, -1, 1};
        const int dy[] = {-1, 1, 0, 0};
        EXPLORE_NEIGHBORS_LOOP: for (uint8_t i = 0; i < 4; ++i) {

        	// Check the position is in the world, not blocked, and not closed
        	if ((current.x == 0 && dx[i] < 0) || (current.y == 0 && dy[i] < 0)) {
        		dbg_printf("Neighbour %lu (%d, %d), out of bottom bounds\r\n", i, dx[i], dy[i]);
        		dbg_list_write(3010 + i + 1);
        		continue;
        	}

            uint16_t n_x = current.x + dx[i];
            uint16_t n_y = current.y + dy[i];

            if (n_x >= world_size || n_y >= world_size) {
        		dbg_printf("Neighbour %lu (%d, %d), out of top bounds\r\n", i, dx[i], dy[i]);
        		dbg_list_write(3020 + i + 1);
            	continue;
            }
            if (get_world_bit(n_x, n_y)) {
        		dbg_printf("Neighbour %lu (%d, %d), blocked\r\n", i, dx[i], dy[i]);
        		dbg_list_write(3030 + i + 1);
            	continue;
            }
            if (is_closed(n_x, n_y)) {
        		dbg_printf("Neighbour %lu (%d, %d), closed\r\n", i, dx[i], dy[i]);
        		dbg_list_write(3040 + i + 1);
            	continue;
            }

            // Calculate scores for the new neighbour
            Coord n_pos = {n_x, n_y};
            uint16_t n_g_score_tentative = current.g_score + 1;
            uint16_t n_h_score = heuristic(n_pos, goal);
            uint16_t n_f_score = n_g_score_tentative + n_h_score;

            dbg_printf("Neighbour %lu (%d, %d), pos (%lu, %lu)\r\n", i, dx[i], dy[i], n_x, n_y);
            dbg_list_write(3000 + i + 1);

            // The heap handles preferring paths to a node via a lower f_score
            ASNode neighbour_node = {n_f_score, n_g_score_tentative, n_x, n_y};
            os_heap_push(neighbour_node);
            if (error_flag != 0) return INF;
        }

        iteration_count++;
    }

    // Error has occured if this is reached
    if (open_set_size == 0) {
    	error_flag = 30000;
    } else if (iteration_count >= iteration_limit) {
    	error_flag = 40000;
    } else {
    	error_flag = 50000;
    }
    return INF;
}

void toplevel(uint32_t *ram, uint32_t *code) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI max_widen_bitwidth=32 depth=7827 // <- Match HW_MAX_WORDS
	#pragma HLS INTERFACE s_axilite port=code bundle=AXILiteS
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS
	#pragma HLS BIND_STORAGE variable=closed_set type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=open_set_heap type=RAM_2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=local_ram type=RAM_T2P impl=BRAM

	dbg_printf("Starting toplevel\r\n");

	// Initialize all the variables
    *code = 0;
    error_flag = 0;
    open_set_size = 0;
    world_size = 0;

#ifdef DEBUG_LIST
    dbg_list_counter = 0;
    DBG_LIST_CLEAR_LOOP: for (uint16_t i = 0; i < 400; ++i) {
    	dbg_list[i] = 0;
    }
#endif

    // Copy RAM, extract data, and perform sanity checks
    COPY_LOOP: for (uint16_t i = 0; i < HW_MAX_WORDS; ++i) {
    	local_ram[i] = ram[i];
    }
    world_size = (uint16_t) local_ram[0];
    uint16_t waypoint_count = (uint16_t) local_ram[1];
    if (world_size == 0 || world_size > WORLD_MAX_SIZE || waypoint_count < 2 || waypoint_count > WORLD_MAX_WAYPOINTS) {
    	ram[0] = INF;
    	*code = 10000;
    	return;
    }
    Coord waypoints[WORLD_MAX_WAYPOINTS];
    WAYPOINT_EXTRACT_LOOP: for (uint8_t i = 0; i < waypoint_count; ++i) {
        uint32_t wp = local_ram[HW_META_WORDS + i];
        waypoints[i].x = (wp >> 16) & 0xFFFF;
        waypoints[i].y = wp & 0xFFFF;
    }

    dbg_printf("World size: %lu, waypoint count: %lu\r\n", world_size, waypoint_count);
    dbg_printf("HW_META_WORDS: %lu, HW_WAYPOINT_WORDS: %lu, HW_WORLD_WORDS: %lu, HW_MAX_WORDS: %lu, HW_WORLD_OFFSET: %lu\r\n",
    		HW_META_WORDS, HW_WAYPOINT_WORDS, HW_WORLD_WORDS, HW_MAX_WORDS, HW_WORLD_OFFSET);
    for (uint8_t i = 0; i < (world_size * world_size + 31) / 32; ++i) {
    	dbg_printf("Ram word %lu: %lu\r\n", HW_WORLD_OFFSET + i, local_ram[HW_WORLD_OFFSET + i]);
    }

    // Perform A* between each consecutive waypoint pair and sum length
    uint32_t total_len = 0;
    PATHFINDING_LOOP: for (uint8_t i = 0; i < waypoint_count - 1; ++i) {
    	dbg_printf("Pathfinding %lu to %lu\r\n", i, i + 1);
        dbg_list_write(1000 + i);
        int ret = a_star_len(waypoints[i], waypoints[i + 1]);
        if (error_flag != 0) {
        	error_flag += (i + 1) * 1000;
            break;
        }
        total_len += ret;
    }

    // Write final values
#ifdef DEBUG_LIST
    DBG_LIST_WRITE_LOOP: for (uint16_t i = 0; i < DBG_LIST_MAX; ++i) {
    	ram[HW_MAX_WORDS - DBG_LIST_MAX + i] = dbg_list[i];
    }
#endif

    ram[0] = total_len;
    *code = error_flag;
}



