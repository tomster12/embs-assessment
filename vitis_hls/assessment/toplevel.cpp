#include "toplevel.h"
#include <string.h> // For memcpy, memset

// ================================= DECLARATION =================================

#define WORLD_MAX_WAYPOINTS 12
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 2
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS)
#define HW_WORLD_OFFSET (HW_META_WORDS + HW_WAYPOINT_WORDS)
#define INF UINT16_MAX
#define MAX_OPEN_SET_SIZE 8192 // Arbitrary: 8192 nodes x 8 bytes / node = 64KB
#define MAX_TRIPS (WORLD_MAX_WAYPOINTS - 1)
#define MAX_AS_ITERATIONS (WORLD_MAX_SIZE * WORLD_MAX_SIZE)

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
static uint32_t world_size;
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

void os_sift_down(uint16_t idx) {
	#pragma HLS INLINE

	SIFT_DOWN_LOOP: while (true) {
		// #pragma HLS LOOP_TRIPCOUNT min=0 max=13 // max = approx log2(MAX_OPEN_SET_SIZE) because it is a heap

        uint16_t smallest = idx;
        uint16_t left = 2 * idx + 1;
        uint16_t right = 2 * idx + 2;

        // Find smallest among node and its children, otherwise quit out
        if (left < open_set_size && open_set_heap[left].f_score < open_set_heap[smallest].f_score) smallest = left;
        else if (right < open_set_size && open_set_heap[right].f_score < open_set_heap[smallest].f_score) smallest = right;
        else return;

        // Current is larger than children, so swap and continue
        ASNode temp = open_set_heap[idx];
		open_set_heap[idx] = open_set_heap[smallest];
		open_set_heap[smallest] = temp;
		idx = smallest;
    }
}

void os_sift_up(uint16_t idx) {
	#pragma HLS INLINE

    SIFT_UP_LOOP: while (idx > 0) {
		// #pragma HLS LOOP_TRIPCOUNT min=0 max=13 // max = approx log2(MAX_OPEN_SET_SIZE) because it is a heap

        // We are biggest, no need to move up, heap is locally satisfied
        uint16_t parent = (idx - 1) / 2;
        if (open_set_heap[idx].f_score >= open_set_heap[parent].f_score) return;

        // Current is smaller than parent, so swap and continue
		ASNode temp = open_set_heap[idx];
		open_set_heap[idx] = open_set_heap[parent];
		open_set_heap[parent] = temp;
		idx = parent;
    }
}

void os_heap_push(ASNode node) {
	#pragma HLS INLINE

	// Stop once the heap is full
    if (open_set_size >= MAX_OPEN_SET_SIZE) {
    	error_flag = 200;
    	return;
    }

    // Add a node to the end then recursively sift upwards
    open_set_heap[open_set_size] = node;
    open_set_size++;
    os_sift_up(open_set_size - 1);
}

ASNode os_heap_pop() {
	#pragma HLS INLINE

	// Grab the top node to be returned
    ASNode min_node = open_set_heap[0];

	// Move last node to start then recursively sift downwards
    open_set_heap[0] = open_set_heap[open_set_size - 1];
    open_set_size--;
    os_sift_down(0);
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

        // If this node is the goal return the path length
        if (current.x == goal.x && current.y == goal.y) return current.g_score;

        // Skip closed set nodes in the case of multiple entries in the list
        if (is_closed(current.x, current.y)) continue;

        // Add current node to the closed set
        set_closed(current.x, current.y);

        // Visit each neighbour
        const int dx[] = {0, 0, -1, 1};
        const int dy[] = {-1, 1, 0, 0};
        EXPLORE_NEIGHBORS_LOOP: for (uint8_t i = 0; i < 4; ++i) {

        	// Check the position is in the world, not blocked, and not closed
        	if ((current.x == 0 && dx[i] < 0) || (current.y == 0 && dy[i] < 0)) continue;
            uint16_t n_x = current.x + dx[i];
            uint16_t n_y = current.y + dy[i];
            if (n_x >= world_size || n_y >= world_size) continue;
            if (get_world_bit(n_x, n_y)) continue;
            if (is_closed(n_x, n_y)) continue;

            // Calculate scores for the new neighbour
            Coord n_pos = {n_x, n_y};
            uint16_t n_g_score_tentative = current.g_score + 1;
            uint16_t n_h_score = heuristic(n_pos, goal);
            uint16_t n_f_score = n_g_score_tentative + n_h_score;

            // The heap handles preferring paths to a node via a lower f_score
            ASNode neighbour_node = {n_f_score, n_g_score_tentative, n_x, n_y};
            os_heap_push(neighbour_node);
            if (error_flag != 0) return INF;
        }

        iteration_count++;
    }

    // Error has occured if this is reached
    if (open_set_size == 0) {
    	error_flag = 300 + iteration_count;
    } else if (iteration_count >= iteration_limit) {
    	error_flag = 400;
    } else {
    	error_flag = 500;
    }
    return INF;
}

void toplevel(uint32_t *ram, volatile uint32_t *code) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI max_widen_bitwidth=32 depth=7827 // <- Match HW_MAX_WORDS
	#pragma HLS INTERFACE s_axilite port=code bundle=AXILiteS
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS
	#pragma HLS BIND_STORAGE variable=closed_set type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=open_set_heap type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=local_ram type=RAM_T2P impl=BRAM

	// Initialize variables
    *code = 0;
    error_flag = 0;
    open_set_size = 0;
    world_size = 0;

	// Copy from RAM into local BRAM memory
    memcpy(local_ram, ram, HW_MAX_WORDS * sizeof(uint32_t));

    // Extract meta from RAM
    world_size = local_ram[0];
    uint32_t waypoint_count = local_ram[1];

    // Early sanity checks
    if (world_size == 0 || world_size > WORLD_MAX_SIZE || waypoint_count < 2 || waypoint_count > WORLD_MAX_WAYPOINTS) {
    	ram[0] = INF;
    	*code = 100;
    	return;
    }

    // Extract waypoints from RAM
    Coord waypoints[WORLD_MAX_WAYPOINTS];
    WAYPOINT_EXTRACT_LOOP: for (uint8_t i = 0; i < waypoint_count; ++i) {
        uint32_t wp = local_ram[HW_META_WORDS + i];
        waypoints[i].x = (wp >> 16) & 0xFFFF;
        waypoints[i].y = wp & 0xFFFF;
    }

    // Perform A* between each consecutive waypoint pair and sum length
    uint32_t total_len = 0;
    PATHFINDING_LOOP: for (uint8_t i = 0; i < waypoint_count - 1; ++i) {
        int ret = a_star_len(waypoints[i], waypoints[i + 1]);
        if (error_flag != 0) {
        	error_flag += i * 1000;
            break;
        }
        total_len += ret;
    }

    // Write the total length back and return
    ram[0] = total_len;
    *code = error_flag;
}






