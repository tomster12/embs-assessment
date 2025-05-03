#include "toplevel.h"

#define INF 0xFFFFFFFF

void toplevel(uint32_t *ram) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS
    ram[0] = INF;
    return;
}
