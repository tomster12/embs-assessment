set moduleName a_star_len
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {a_star_len}
set C_modelType { int 16 }
set C_modelArgList {
	{ start_x int 16 regular  }
	{ start_y int 16 regular  }
	{ goal_x int 16 regular  }
	{ goal_y int 16 regular  }
	{ error_flag int 32 regular {pointer 2} {global 2}  }
	{ world_size int 32 regular {pointer 0} {global 0}  }
	{ local_ram int 32 regular {array 7827 { 1 3 } 1 1 } {global 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "start_x", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "start_y", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "goal_x", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "goal_y", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "error_flag", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "world_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "local_ram", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 16} ]}
# RTL Port declarations: 
set portNum 18
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ start_x sc_in sc_lv 16 signal 0 } 
	{ start_y sc_in sc_lv 16 signal 1 } 
	{ goal_x sc_in sc_lv 16 signal 2 } 
	{ goal_y sc_in sc_lv 16 signal 3 } 
	{ error_flag_i sc_in sc_lv 32 signal 4 } 
	{ error_flag_o sc_out sc_lv 32 signal 4 } 
	{ error_flag_o_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ world_size sc_in sc_lv 32 signal 5 } 
	{ local_ram_address0 sc_out sc_lv 13 signal 6 } 
	{ local_ram_ce0 sc_out sc_logic 1 signal 6 } 
	{ local_ram_q0 sc_in sc_lv 32 signal 6 } 
	{ ap_return sc_out sc_lv 16 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "start_x", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "start_x", "role": "default" }} , 
 	{ "name": "start_y", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "start_y", "role": "default" }} , 
 	{ "name": "goal_x", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "goal_x", "role": "default" }} , 
 	{ "name": "goal_y", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "goal_y", "role": "default" }} , 
 	{ "name": "error_flag_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "error_flag", "role": "i" }} , 
 	{ "name": "error_flag_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "error_flag", "role": "o" }} , 
 	{ "name": "error_flag_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error_flag", "role": "o_ap_vld" }} , 
 	{ "name": "world_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "world_size", "role": "default" }} , 
 	{ "name": "local_ram_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "local_ram", "role": "address0" }} , 
 	{ "name": "local_ram_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "local_ram", "role": "ce0" }} , 
 	{ "name": "local_ram_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "local_ram", "role": "q0" }} , 
 	{ "name": "ap_return", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "ap_return", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
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
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.closed_set_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.open_set_heap_f_score_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.open_set_heap_g_score_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.open_set_heap_x_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.open_set_heap_y_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_32s_32_2_1_U1", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_42_32_1_1_U2", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_42_32_1_1_U3", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_18s_16ns_16ns_18_4_1_U4", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_18s_16ns_16ns_18_4_1_U5", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
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
		error_flag {Type IO LastRead 5 FirstWrite 8}
		world_size {Type I LastRead 5 FirstWrite -1}
		local_ram {Type I LastRead 24 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "3", "EnableSignal" : "ap_enable_pp3"}
]}

set Spec2ImplPortList { 
	start_x { ap_none {  { start_x in_data 0 16 } } }
	start_y { ap_none {  { start_y in_data 0 16 } } }
	goal_x { ap_none {  { goal_x in_data 0 16 } } }
	goal_y { ap_none {  { goal_y in_data 0 16 } } }
	error_flag { ap_ovld {  { error_flag_i in_data 0 32 }  { error_flag_o out_data 1 32 }  { error_flag_o_ap_vld out_vld 1 1 } } }
	world_size { ap_none {  { world_size in_data 0 32 } } }
	local_ram { ap_memory {  { local_ram_address0 mem_address 1 13 }  { local_ram_ce0 mem_ce 1 1 }  { local_ram_q0 mem_dout 0 32 } } }
}
