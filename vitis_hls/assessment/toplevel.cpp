#include "toplevel.h"
#include <string.h> // For memcpy, memset

// ================================= DECLARATION =================================

#define WORLD_MAX_WAYPOINTS 12
#define WORLD_MAX_SIZE 500
#define HW_META_WORDS 2
#define HW_WAYPOINT_WORDS WORLD_MAX_WAYPOINTS
#define HW_WORLD_WORDS ((WORLD_MAX_SIZE * WORLD_MAX_SIZE + 31) / 32)
#define HW_MAX_WORDS (HW_META_WORDS + HW_WAYPOINT_WORDS + HW_WORLD_WORDS + 1)
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

static uint32_t closed_set[HW_WORLD_WORDS]; // Bitmask for closed set, 0=open, 1=closed
static ASNode open_set_heap[MAX_OPEN_SET_SIZE]; // Min-Heap using an array ordered by f_score
static uint32_t local_ram[HW_MAX_WORDS];
static uint16_t open_set_size;
static uint32_t *world_ram_ptr;
static uint16_t world_size;

// ================================= DEFINITION/HELPERS =================================

int get_world_bit(uint16_t x, uint16_t y) {
	#pragma HLS INLINE

	// Out of bounds is an obstacle
    if (x >= world_size || y >= world_size) return 1;

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
		#pragma HLS LOOP_TRIPCOUNT min=0 max=13 // max = approx log2(MAX_OPEN_SET_SIZE) because it is a heap

        uint16_t smallest = idx;
        uint16_t left = 2 * idx + 1;
        uint16_t right = 2 * idx + 2;

        // Find smallest among node and its children
        if (left < open_set_size && open_set_heap[left].f_score < open_set_heap[smallest].f_score) smallest = left;
        if (right < open_set_size && open_set_heap[right].f_score < open_set_heap[smallest].f_score) smallest = right;

        // We are smallest, no need to move down, heap is locally satisfied
        if (smallest == idx) break;

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
		#pragma HLS LOOP_TRIPCOUNT min=0 max=13 // max = approx log2(MAX_OPEN_SET_SIZE) because it is a heap

        uint16_t parent = (idx - 1) / 2;

        // We are biggest, no need to move up, heap is locally satisfied
        if (open_set_heap[idx].f_score >= open_set_heap[parent].f_score) break;

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
    if (open_set_size >= MAX_OPEN_SET_SIZE) return;

    // Add a node to the end then recursively sift upwards
    open_set_heap[open_set_size] = node;
    open_set_size++;
    os_sift_up(open_set_size - 1);
}

ASNode os_heap_pop() {
	#pragma HLS INLINE

	// Grab the top node to be returned
    ASNode minNode = open_set_heap[0];

	// Move last node to start then recursively sift downwards
    open_set_heap[0] = open_set_heap[open_set_size - 1];
    open_set_size--;
    os_sift_down(0);
    return minNode;
}

// ================================= DEFINITION/MAIN =================================

int a_star_len(Coord start, Coord goal) {
	#pragma HLS INLINE off

    // Clear the closed set and open set
    uint32_t closed_words = (world_size * world_size + 31) / 32;
    memset(closed_set, 0, closed_words * sizeof(uint32_t));
    open_set_size = 0;

    // Initialize start node and add to open set
    uint16_t h_start = heuristic(start, goal);
    ASNode start_node = {h_start, 0, start.x, start.y};
    os_heap_push(start_node);

    // Start the A* loop with a semi-informed arbitrary limit on iterations
    const uint32_t iteration_limit = (uint32_t)(world_size * world_size * 2);
    uint32_t iteration_count = 0;
    AS_SEARCH_LOOP: while (open_set_size > 0 && iteration_count < iteration_limit) {
		#pragma HLS PIPELINE

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
        const int num_neighbors = 4;
        EXPLORE_NEIGHBORS_LOOP: for (int i = 0; i < num_neighbors; ++i) {
			#pragma HLS UNROLL

        	// Check the position is in the world, not blocked, and not closed
            uint16_t neighbor_x = current.x + dx[i];
            uint16_t neighbor_y = current.y + dy[i];
            if (get_world_bit(neighbor_x, neighbor_y)) continue;
            if (is_closed(neighbor_x, neighbor_y)) continue;

            // Calculate scores for the new neighbour
            Coord neighborCoord = {neighbor_x, neighbor_y};
            uint16_t tentative_g_score = current.g_score + 1;
            uint16_t h_neighbor = heuristic(neighborCoord, goal);
            uint16_t new_f_score = tentative_g_score + h_neighbor;

            // The heap handles preferring paths to a node via a lower f_score
            ASNode neighborNode = {new_f_score, tentative_g_score, neighbor_x, neighbor_y};
            os_heap_push(neighborNode);
        }

        iteration_count++;
    }

    // Error has occured if this is reached
    return INF;
}

void toplevel(uint32_t *ram) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI depth=8400 // <- Match HW_MAX_WORDS
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS
	#pragma HLS BIND_STORAGE variable=closed_set type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=open_set_heap type=RAM_T2P impl=BRAM
	#pragma HLS BIND_STORAGE variable=local_ram type=RAM_T2P impl=BRAM

	// Copy from RAM into local BRAM memory
    memcpy(local_ram, ram, HW_MAX_WORDS * sizeof(uint32_t));

    // Extract meta from RAM
    world_size = local_ram[0];
    uint16_t waypoint_count = local_ram[1];

    // Early sanity checks
    if (world_size == 0 || world_size > WORLD_MAX_SIZE || waypoint_count < 2 || waypoint_count > WORLD_MAX_WAYPOINTS) {
    	ram[0] = INF;
    	return;
    }

    // Extract waypoints from RAM
    Coord waypoints[WORLD_MAX_WAYPOINTS];
    WAYPOINT_EXTRACT_LOOP: for (int i = 0; i < waypoint_count; ++i) {
		#pragma HLS PIPELINE

        uint32_t wp = local_ram[HW_META_WORDS + i];
        waypoints[i].x = (wp >> 16) & 0xFFFF;
        waypoints[i].y = wp & 0xFFFF;
    }

    // Perform A* between each consecutive waypoint pair and sum length
    uint32_t total_len = 0;
    PATHFINDING_LOOP: for (int i = 0; i < waypoint_count - 1; ++i) {

		// Perform pathfinding on the current 2 waypoints
        int segment_len = a_star_len(waypoints[i], waypoints[i + 1]);

        // If a segment fails then the whole search fails otherwise sum
        if (segment_len == INF) {
            total_len = INF;
            break;
        } else {
        	total_len += segment_len;
        }

    }

    // Write the total length back and return
    ram[0] = total_len;
}










