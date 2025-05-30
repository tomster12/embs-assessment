// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XTOPLEVEL_H
#define XTOPLEVEL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xtoplevel_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Axilites_BaseAddress;
    u32 Control_BaseAddress;
} XToplevel_Config;
#endif

typedef struct {
    u64 Axilites_BaseAddress;
    u64 Control_BaseAddress;
    u32 IsReady;
} XToplevel;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XToplevel_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XToplevel_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XToplevel_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XToplevel_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XToplevel_Initialize(XToplevel *InstancePtr, u16 DeviceId);
XToplevel_Config* XToplevel_LookupConfig(u16 DeviceId);
int XToplevel_CfgInitialize(XToplevel *InstancePtr, XToplevel_Config *ConfigPtr);
#else
int XToplevel_Initialize(XToplevel *InstancePtr, const char* InstanceName);
int XToplevel_Release(XToplevel *InstancePtr);
#endif

void XToplevel_Start(XToplevel *InstancePtr);
u32 XToplevel_IsDone(XToplevel *InstancePtr);
u32 XToplevel_IsIdle(XToplevel *InstancePtr);
u32 XToplevel_IsReady(XToplevel *InstancePtr);
void XToplevel_EnableAutoRestart(XToplevel *InstancePtr);
void XToplevel_DisableAutoRestart(XToplevel *InstancePtr);

u32 XToplevel_Get_code(XToplevel *InstancePtr);
u32 XToplevel_Get_code_vld(XToplevel *InstancePtr);
void XToplevel_Set_ram(XToplevel *InstancePtr, u64 Data);
u64 XToplevel_Get_ram(XToplevel *InstancePtr);

void XToplevel_InterruptGlobalEnable(XToplevel *InstancePtr);
void XToplevel_InterruptGlobalDisable(XToplevel *InstancePtr);
void XToplevel_InterruptEnable(XToplevel *InstancePtr, u32 Mask);
void XToplevel_InterruptDisable(XToplevel *InstancePtr, u32 Mask);
void XToplevel_InterruptClear(XToplevel *InstancePtr, u32 Mask);
u32 XToplevel_InterruptGetEnabled(XToplevel *InstancePtr);
u32 XToplevel_InterruptGetStatus(XToplevel *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
