// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xtoplevel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XToplevel_CfgInitialize(XToplevel *InstancePtr, XToplevel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Axilites_BaseAddress = ConfigPtr->Axilites_BaseAddress;
    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XToplevel_Start(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL) & 0x80;
    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL, Data | 0x01);
}

u32 XToplevel_IsDone(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XToplevel_IsIdle(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XToplevel_IsReady(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XToplevel_EnableAutoRestart(XToplevel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL, 0x80);
}

void XToplevel_DisableAutoRestart(XToplevel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_AP_CTRL, 0);
}

u32 XToplevel_Get_code(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_CODE_DATA);
    return Data;
}

u32 XToplevel_Get_code_vld(XToplevel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_CODE_CTRL);
    return Data & 0x1;
}

void XToplevel_Set_ram(XToplevel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Control_BaseAddress, XTOPLEVEL_CONTROL_ADDR_RAM_DATA, (u32)(Data));
    XToplevel_WriteReg(InstancePtr->Control_BaseAddress, XTOPLEVEL_CONTROL_ADDR_RAM_DATA + 4, (u32)(Data >> 32));
}

u64 XToplevel_Get_ram(XToplevel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XToplevel_ReadReg(InstancePtr->Control_BaseAddress, XTOPLEVEL_CONTROL_ADDR_RAM_DATA);
    Data += (u64)XToplevel_ReadReg(InstancePtr->Control_BaseAddress, XTOPLEVEL_CONTROL_ADDR_RAM_DATA + 4) << 32;
    return Data;
}

void XToplevel_InterruptGlobalEnable(XToplevel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_GIE, 1);
}

void XToplevel_InterruptGlobalDisable(XToplevel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_GIE, 0);
}

void XToplevel_InterruptEnable(XToplevel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_IER);
    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_IER, Register | Mask);
}

void XToplevel_InterruptDisable(XToplevel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_IER);
    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_IER, Register & (~Mask));
}

void XToplevel_InterruptClear(XToplevel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XToplevel_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_ISR, Mask);
}

u32 XToplevel_InterruptGetEnabled(XToplevel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_IER);
}

u32 XToplevel_InterruptGetStatus(XToplevel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XToplevel_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPLEVEL_AXILITES_ADDR_ISR);
}

