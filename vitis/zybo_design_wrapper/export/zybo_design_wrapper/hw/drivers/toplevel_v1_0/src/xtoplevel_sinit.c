// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xtoplevel.h"

extern XToplevel_Config XToplevel_ConfigTable[];

XToplevel_Config *XToplevel_LookupConfig(u16 DeviceId) {
	XToplevel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XTOPLEVEL_NUM_INSTANCES; Index++) {
		if (XToplevel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XToplevel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XToplevel_Initialize(XToplevel *InstancePtr, u16 DeviceId) {
	XToplevel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XToplevel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XToplevel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

