set moduleName toplevel
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {toplevel}
set C_modelType { void 0 }
set C_modelArgList {
	{ MAXI int 32 regular {axi_master 2}  }
	{ ram int 64 regular {axi_slave 0}  }
	{ code int 32 regular {axi_slave 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "MAXI", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "ram","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "ram","bundle": "control"},"direction": "READWRITE","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "ram", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "code", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_vld","bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "code","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"out":16}, "offset_end" : {"out":23}} ]}
# RTL Port declarations: 
set portNum 82
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_MAXI_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_MAXI_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_MAXI_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_MAXI_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_MAXI_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_MAXI_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_MAXI_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_MAXI_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_MAXI_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_BUSER sc_in sc_lv 1 signal 0 } 
	{ s_axi_AXILiteS_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_AXILiteS_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_AXILiteS_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_AXILiteS_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_AXILiteS_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_AXILiteS_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWADDR" },"address":[{"name":"toplevel","role":"start","value":"0","valid_bit":"0"},{"name":"toplevel","role":"continue","value":"0","valid_bit":"4"},{"name":"toplevel","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_AXILiteS_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWVALID" } },
	{ "name": "s_axi_AXILiteS_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWREADY" } },
	{ "name": "s_axi_AXILiteS_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WVALID" } },
	{ "name": "s_axi_AXILiteS_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WREADY" } },
	{ "name": "s_axi_AXILiteS_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WDATA" } },
	{ "name": "s_axi_AXILiteS_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WSTRB" } },
	{ "name": "s_axi_AXILiteS_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARADDR" },"address":[{"name":"toplevel","role":"start","value":"0","valid_bit":"0"},{"name":"toplevel","role":"done","value":"0","valid_bit":"1"},{"name":"toplevel","role":"idle","value":"0","valid_bit":"2"},{"name":"toplevel","role":"ready","value":"0","valid_bit":"3"},{"name":"toplevel","role":"auto_start","value":"0","valid_bit":"7"},{"name":"code","role":"data","value":"16"}, {"name":"code","role":"valid","value":"20","valid_bit":"0"}] },
	{ "name": "s_axi_AXILiteS_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARVALID" } },
	{ "name": "s_axi_AXILiteS_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARREADY" } },
	{ "name": "s_axi_AXILiteS_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RVALID" } },
	{ "name": "s_axi_AXILiteS_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RREADY" } },
	{ "name": "s_axi_AXILiteS_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RDATA" } },
	{ "name": "s_axi_AXILiteS_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RRESP" } },
	{ "name": "s_axi_AXILiteS_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BVALID" } },
	{ "name": "s_axi_AXILiteS_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BREADY" } },
	{ "name": "s_axi_AXILiteS_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "interrupt" } },
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"ram","role":"data","value":"16"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_MAXI_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWVALID" }} , 
 	{ "name": "m_axi_MAXI_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWREADY" }} , 
 	{ "name": "m_axi_MAXI_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "MAXI", "role": "AWADDR" }} , 
 	{ "name": "m_axi_MAXI_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWID" }} , 
 	{ "name": "m_axi_MAXI_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "MAXI", "role": "AWLEN" }} , 
 	{ "name": "m_axi_MAXI_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_MAXI_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "AWBURST" }} , 
 	{ "name": "m_axi_MAXI_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_MAXI_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_MAXI_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "AWPROT" }} , 
 	{ "name": "m_axi_MAXI_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWQOS" }} , 
 	{ "name": "m_axi_MAXI_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWREGION" }} , 
 	{ "name": "m_axi_MAXI_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWUSER" }} , 
 	{ "name": "m_axi_MAXI_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WVALID" }} , 
 	{ "name": "m_axi_MAXI_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WREADY" }} , 
 	{ "name": "m_axi_MAXI_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "WDATA" }} , 
 	{ "name": "m_axi_MAXI_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "WSTRB" }} , 
 	{ "name": "m_axi_MAXI_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WLAST" }} , 
 	{ "name": "m_axi_MAXI_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WID" }} , 
 	{ "name": "m_axi_MAXI_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WUSER" }} , 
 	{ "name": "m_axi_MAXI_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARVALID" }} , 
 	{ "name": "m_axi_MAXI_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARREADY" }} , 
 	{ "name": "m_axi_MAXI_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "MAXI", "role": "ARADDR" }} , 
 	{ "name": "m_axi_MAXI_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARID" }} , 
 	{ "name": "m_axi_MAXI_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "MAXI", "role": "ARLEN" }} , 
 	{ "name": "m_axi_MAXI_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_MAXI_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "ARBURST" }} , 
 	{ "name": "m_axi_MAXI_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_MAXI_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_MAXI_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "ARPROT" }} , 
 	{ "name": "m_axi_MAXI_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARQOS" }} , 
 	{ "name": "m_axi_MAXI_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARREGION" }} , 
 	{ "name": "m_axi_MAXI_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARUSER" }} , 
 	{ "name": "m_axi_MAXI_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RVALID" }} , 
 	{ "name": "m_axi_MAXI_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RREADY" }} , 
 	{ "name": "m_axi_MAXI_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "RDATA" }} , 
 	{ "name": "m_axi_MAXI_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RLAST" }} , 
 	{ "name": "m_axi_MAXI_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RID" }} , 
 	{ "name": "m_axi_MAXI_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RUSER" }} , 
 	{ "name": "m_axi_MAXI_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "RRESP" }} , 
 	{ "name": "m_axi_MAXI_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BVALID" }} , 
 	{ "name": "m_axi_MAXI_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BREADY" }} , 
 	{ "name": "m_axi_MAXI_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "BRESP" }} , 
 	{ "name": "m_axi_MAXI_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BID" }} , 
 	{ "name": "m_axi_MAXI_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "18"],
		"CDFG" : "toplevel",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "MAXI", "Type" : "MAXI", "Direction" : "IO",
				"BlockSignal" : [
					{"Name" : "MAXI_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "MAXI_blk_n_R", "Type" : "RtlSignal"},
					{"Name" : "MAXI_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "MAXI_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "MAXI_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "ram", "Type" : "None", "Direction" : "I"},
			{"Name" : "code", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "error_flag", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "error_flag"}]},
			{"Name" : "local_ram", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "local_ram"}]},
			{"Name" : "world_size", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "world_size"}]},
			{"Name" : "closed_set", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "closed_set"}]},
			{"Name" : "open_set_heap_f_score", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "open_set_heap_f_score"}]},
			{"Name" : "open_set_heap_g_score", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "open_set_heap_g_score"}]},
			{"Name" : "open_set_heap_x", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "open_set_heap_x"}]},
			{"Name" : "open_set_heap_y", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "grp_a_star_len_fu_372", "Port" : "open_set_heap_y"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.local_ram_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.AXILiteS_s_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.MAXI_m_axi_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.waypoints_x_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.waypoints_y_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372", "Parent" : "0", "Child" : ["8", "9", "10", "11", "12", "13", "14", "15", "16", "17"],
		"CDFG" : "a_star_len",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "start_x", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_y", "Type" : "None", "Direction" : "I"},
			{"Name" : "goal_x", "Type" : "None", "Direction" : "I"},
			{"Name" : "goal_y", "Type" : "None", "Direction" : "I"},
			{"Name" : "closed_set", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_f_score", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_g_score", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_x", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_y", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "error_flag", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "world_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "local_ram", "Type" : "Memory", "Direction" : "I"}]},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.closed_set_U", "Parent" : "7"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.open_set_heap_f_score_U", "Parent" : "7"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.open_set_heap_g_score_U", "Parent" : "7"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.open_set_heap_x_U", "Parent" : "7"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.open_set_heap_y_U", "Parent" : "7"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.mux_42_32_1_1_U1", "Parent" : "7"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.mux_42_32_1_1_U2", "Parent" : "7"},
	{"ID" : "15", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.mul_mul_16ns_16ns_31_4_1_U3", "Parent" : "7"},
	{"ID" : "16", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.mac_muladd_16ns_16ns_16ns_18_4_1_U4", "Parent" : "7"},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_a_star_len_fu_372.mac_muladd_16ns_16ns_16ns_18_4_1_U5", "Parent" : "7"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_8ns_11ns_32ns_32_4_1_U19", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	toplevel {
		MAXI {Type IO LastRead 22 FirstWrite 21}
		ram {Type I LastRead 0 FirstWrite -1}
		code {Type O LastRead -1 FirstWrite 21}
		error_flag {Type IO LastRead -1 FirstWrite -1}
		local_ram {Type IO LastRead -1 FirstWrite -1}
		world_size {Type IO LastRead -1 FirstWrite -1}
		closed_set {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_f_score {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_g_score {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_x {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_y {Type IO LastRead -1 FirstWrite -1}}
	a_star_len {
		start_x {Type I LastRead 0 FirstWrite -1}
		start_y {Type I LastRead 0 FirstWrite -1}
		goal_x {Type I LastRead 0 FirstWrite -1}
		goal_y {Type I LastRead 0 FirstWrite -1}
		closed_set {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_f_score {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_g_score {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_x {Type IO LastRead -1 FirstWrite -1}
		open_set_heap_y {Type IO LastRead -1 FirstWrite -1}
		error_flag {Type IO LastRead 5 FirstWrite 11}
		world_size {Type I LastRead 5 FirstWrite -1}
		local_ram {Type I LastRead 23 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
	{"Pipeline" : "1", "EnableSignal" : "ap_enable_pp1"}
]}

set Spec2ImplPortList { 
	MAXI { m_axi {  { m_axi_MAXI_AWVALID VALID 1 1 }  { m_axi_MAXI_AWREADY READY 0 1 }  { m_axi_MAXI_AWADDR ADDR 1 64 }  { m_axi_MAXI_AWID ID 1 1 }  { m_axi_MAXI_AWLEN LEN 1 8 }  { m_axi_MAXI_AWSIZE SIZE 1 3 }  { m_axi_MAXI_AWBURST BURST 1 2 }  { m_axi_MAXI_AWLOCK LOCK 1 2 }  { m_axi_MAXI_AWCACHE CACHE 1 4 }  { m_axi_MAXI_AWPROT PROT 1 3 }  { m_axi_MAXI_AWQOS QOS 1 4 }  { m_axi_MAXI_AWREGION REGION 1 4 }  { m_axi_MAXI_AWUSER USER 1 1 }  { m_axi_MAXI_WVALID VALID 1 1 }  { m_axi_MAXI_WREADY READY 0 1 }  { m_axi_MAXI_WDATA DATA 1 32 }  { m_axi_MAXI_WSTRB STRB 1 4 }  { m_axi_MAXI_WLAST LAST 1 1 }  { m_axi_MAXI_WID ID 1 1 }  { m_axi_MAXI_WUSER USER 1 1 }  { m_axi_MAXI_ARVALID VALID 1 1 }  { m_axi_MAXI_ARREADY READY 0 1 }  { m_axi_MAXI_ARADDR ADDR 1 64 }  { m_axi_MAXI_ARID ID 1 1 }  { m_axi_MAXI_ARLEN LEN 1 8 }  { m_axi_MAXI_ARSIZE SIZE 1 3 }  { m_axi_MAXI_ARBURST BURST 1 2 }  { m_axi_MAXI_ARLOCK LOCK 1 2 }  { m_axi_MAXI_ARCACHE CACHE 1 4 }  { m_axi_MAXI_ARPROT PROT 1 3 }  { m_axi_MAXI_ARQOS QOS 1 4 }  { m_axi_MAXI_ARREGION REGION 1 4 }  { m_axi_MAXI_ARUSER USER 1 1 }  { m_axi_MAXI_RVALID VALID 0 1 }  { m_axi_MAXI_RREADY READY 1 1 }  { m_axi_MAXI_RDATA DATA 0 32 }  { m_axi_MAXI_RLAST LAST 0 1 }  { m_axi_MAXI_RID ID 0 1 }  { m_axi_MAXI_RUSER USER 0 1 }  { m_axi_MAXI_RRESP RESP 0 2 }  { m_axi_MAXI_BVALID VALID 0 1 }  { m_axi_MAXI_BREADY READY 1 1 }  { m_axi_MAXI_BRESP RESP 0 2 }  { m_axi_MAXI_BID ID 0 1 }  { m_axi_MAXI_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ MAXI { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ MAXI 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ MAXI 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
