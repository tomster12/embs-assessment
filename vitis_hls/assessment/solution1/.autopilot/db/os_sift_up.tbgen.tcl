set moduleName os_sift_up
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
set C_modelName {os_sift_up}
set C_modelType { void 0 }
set C_modelArgList {
	{ idx uint 16 regular  }
	{ open_set_heap_f_score_V int 11 regular {array 1500 { 2 } 1 1 } {global 2}  }
	{ open_set_heap_g_score_V int 11 regular {array 1500 { 2 } 1 1 } {global 2}  }
	{ open_set_heap_x_V int 9 regular {array 1500 { 2 } 1 1 } {global 2}  }
	{ open_set_heap_y_V int 9 regular {array 1500 { 2 } 1 1 } {global 2}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "idx", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "open_set_heap_f_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_g_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_x_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_y_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 27
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ idx sc_in sc_lv 16 signal 0 } 
	{ open_set_heap_f_score_V_address0 sc_out sc_lv 11 signal 1 } 
	{ open_set_heap_f_score_V_ce0 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_we0 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_d0 sc_out sc_lv 11 signal 1 } 
	{ open_set_heap_f_score_V_q0 sc_in sc_lv 11 signal 1 } 
	{ open_set_heap_g_score_V_address0 sc_out sc_lv 11 signal 2 } 
	{ open_set_heap_g_score_V_ce0 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_we0 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_d0 sc_out sc_lv 11 signal 2 } 
	{ open_set_heap_g_score_V_q0 sc_in sc_lv 11 signal 2 } 
	{ open_set_heap_x_V_address0 sc_out sc_lv 11 signal 3 } 
	{ open_set_heap_x_V_ce0 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_we0 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_d0 sc_out sc_lv 9 signal 3 } 
	{ open_set_heap_x_V_q0 sc_in sc_lv 9 signal 3 } 
	{ open_set_heap_y_V_address0 sc_out sc_lv 11 signal 4 } 
	{ open_set_heap_y_V_ce0 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_we0 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_d0 sc_out sc_lv 9 signal 4 } 
	{ open_set_heap_y_V_q0 sc_in sc_lv 9 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "idx", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "idx", "role": "default" }} , 
 	{ "name": "open_set_heap_f_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_f_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_f_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_f_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_f_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_g_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_g_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_g_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_g_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_g_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_x_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_x_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_x_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_x_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_x_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_y_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_y_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_y_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_y_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_y_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "q0" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5"],
		"CDFG" : "os_sift_up",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "9", "EstimateLatencyMax" : "58",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "open_set_heap_f_score_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_g_score_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_x_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_y_V", "Type" : "Memory", "Direction" : "IO"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_f_score_V_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_g_score_V_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_x_V_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_y_V_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_target_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	os_sift_up {
		idx {Type I LastRead 6 FirstWrite -1}
		open_set_heap_f_score_V {Type IO LastRead 37 FirstWrite 42}
		open_set_heap_g_score_V {Type IO LastRead 38 FirstWrite 42}
		open_set_heap_x_V {Type IO LastRead 38 FirstWrite 42}
		open_set_heap_y_V {Type IO LastRead 38 FirstWrite 42}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "9", "Max" : "58"}
	, {"Name" : "Interval", "Min" : "9", "Max" : "58"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	idx { ap_none {  { idx in_data 0 16 } } }
	open_set_heap_f_score_V { ap_memory {  { open_set_heap_f_score_V_address0 mem_address 1 11 }  { open_set_heap_f_score_V_ce0 mem_ce 1 1 }  { open_set_heap_f_score_V_we0 mem_we 1 1 }  { open_set_heap_f_score_V_d0 mem_din 1 11 }  { open_set_heap_f_score_V_q0 mem_dout 0 11 } } }
	open_set_heap_g_score_V { ap_memory {  { open_set_heap_g_score_V_address0 mem_address 1 11 }  { open_set_heap_g_score_V_ce0 mem_ce 1 1 }  { open_set_heap_g_score_V_we0 mem_we 1 1 }  { open_set_heap_g_score_V_d0 mem_din 1 11 }  { open_set_heap_g_score_V_q0 mem_dout 0 11 } } }
	open_set_heap_x_V { ap_memory {  { open_set_heap_x_V_address0 mem_address 1 11 }  { open_set_heap_x_V_ce0 mem_ce 1 1 }  { open_set_heap_x_V_we0 mem_we 1 1 }  { open_set_heap_x_V_d0 mem_din 1 9 }  { open_set_heap_x_V_q0 mem_dout 0 9 } } }
	open_set_heap_y_V { ap_memory {  { open_set_heap_y_V_address0 mem_address 1 11 }  { open_set_heap_y_V_ce0 mem_ce 1 1 }  { open_set_heap_y_V_we0 mem_we 1 1 }  { open_set_heap_y_V_d0 mem_din 1 9 }  { open_set_heap_y_V_q0 mem_dout 0 9 } } }
}
