#include "toplevel.h"

void toplevel(uint32 *ram) {
	#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI
	#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS

	ram[0] = ram[1] + ram[2];
}
