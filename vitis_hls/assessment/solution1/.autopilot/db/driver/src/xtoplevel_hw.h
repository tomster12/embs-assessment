// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2.2 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// AXILiteS
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x10 : Data signal of code
//        bit 31~0 - code[31:0] (Read)
// 0x14 : Control signal of code
//        bit 0  - code_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTOPLEVEL_AXILITES_ADDR_AP_CTRL   0x00
#define XTOPLEVEL_AXILITES_ADDR_GIE       0x04
#define XTOPLEVEL_AXILITES_ADDR_IER       0x08
#define XTOPLEVEL_AXILITES_ADDR_ISR       0x0c
#define XTOPLEVEL_AXILITES_ADDR_CODE_DATA 0x10
#define XTOPLEVEL_AXILITES_BITS_CODE_DATA 32
#define XTOPLEVEL_AXILITES_ADDR_CODE_CTRL 0x14

// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of ram
//        bit 31~0 - ram[31:0] (Read/Write)
// 0x14 : Data signal of ram
//        bit 31~0 - ram[63:32] (Read/Write)
// 0x18 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTOPLEVEL_CONTROL_ADDR_RAM_DATA 0x10
#define XTOPLEVEL_CONTROL_BITS_RAM_DATA 64

