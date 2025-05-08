set moduleName os_heap_push
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
set C_modelName {os_heap_push}
set C_modelType { void 0 }
set C_modelArgList {
	{ node_f_score int 11 regular  }
	{ node_g_score int 11 regular  }
	{ node_x int 9 regular  }
	{ node_y int 9 regular  }
	{ open_set_size int 16 regular {pointer 2} {global 2}  }
	{ open_set_heap_f_score_V int 11 regular {array 25000 { 2 3 } 1 1 } {global 2}  }
	{ open_set_heap_g_score_V int 11 regular {array 25000 { 2 3 } 1 1 } {global 2}  }
	{ open_set_heap_x_V int 9 regular {array 25000 { 2 3 } 1 1 } {global 2}  }
	{ open_set_heap_y_V int 9 regular {array 25000 { 2 3 } 1 1 } {global 2}  }
	{ error_flag int 32 regular {pointer 1} {global 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "node_f_score", "interface" : "wire", "bitwidth" : 11, "direction" : "READONLY"} , 
 	{ "Name" : "node_g_score", "interface" : "wire", "bitwidth" : 11, "direction" : "READONLY"} , 
 	{ "Name" : "node_x", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "node_y", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "open_set_size", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_f_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_g_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_x_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_y_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "error_flag", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 35
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ node_f_score sc_in sc_lv 11 signal 0 } 
	{ node_g_score sc_in sc_lv 11 signal 1 } 
	{ node_x sc_in sc_lv 9 signal 2 } 
	{ node_y sc_in sc_lv 9 signal 3 } 
	{ open_set_size_i sc_in sc_lv 16 signal 4 } 
	{ open_set_size_o sc_out sc_lv 16 signal 4 } 
	{ open_set_size_o_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ open_set_heap_f_score_V_address0 sc_out sc_lv 15 signal 5 } 
	{ open_set_heap_f_score_V_ce0 sc_out sc_logic 1 signal 5 } 
	{ open_set_heap_f_score_V_we0 sc_out sc_logic 1 signal 5 } 
	{ open_set_heap_f_score_V_d0 sc_out sc_lv 11 signal 5 } 
	{ open_set_heap_f_score_V_q0 sc_in sc_lv 11 signal 5 } 
	{ open_set_heap_g_score_V_address0 sc_out sc_lv 15 signal 6 } 
	{ open_set_heap_g_score_V_ce0 sc_out sc_logic 1 signal 6 } 
	{ open_set_heap_g_score_V_we0 sc_out sc_logic 1 signal 6 } 
	{ open_set_heap_g_score_V_d0 sc_out sc_lv 11 signal 6 } 
	{ open_set_heap_g_score_V_q0 sc_in sc_lv 11 signal 6 } 
	{ open_set_heap_x_V_address0 sc_out sc_lv 15 signal 7 } 
	{ open_set_heap_x_V_ce0 sc_out sc_logic 1 signal 7 } 
	{ open_set_heap_x_V_we0 sc_out sc_logic 1 signal 7 } 
	{ open_set_heap_x_V_d0 sc_out sc_lv 9 signal 7 } 
	{ open_set_heap_x_V_q0 sc_in sc_lv 9 signal 7 } 
	{ open_set_heap_y_V_address0 sc_out sc_lv 15 signal 8 } 
	{ open_set_heap_y_V_ce0 sc_out sc_logic 1 signal 8 } 
	{ open_set_heap_y_V_we0 sc_out sc_logic 1 signal 8 } 
	{ open_set_heap_y_V_d0 sc_out sc_lv 9 signal 8 } 
	{ open_set_heap_y_V_q0 sc_in sc_lv 9 signal 8 } 
	{ error_flag sc_out sc_lv 32 signal 9 } 
	{ error_flag_ap_vld sc_out sc_logic 1 outvld 9 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "node_f_score", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "node_f_score", "role": "default" }} , 
 	{ "name": "node_g_score", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "node_g_score", "role": "default" }} , 
 	{ "name": "node_x", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "node_x", "role": "default" }} , 
 	{ "name": "node_y", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "node_y", "role": "default" }} , 
 	{ "name": "open_set_size_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "open_set_size", "role": "i" }} , 
 	{ "name": "open_set_size_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "open_set_size", "role": "o" }} , 
 	{ "name": "open_set_size_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "open_set_size", "role": "o_ap_vld" }} , 
 	{ "name": "open_set_heap_f_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_f_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_f_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_f_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_f_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_g_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_g_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_g_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_g_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_g_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_x_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_x_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_x_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_x_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_x_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_y_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_y_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_y_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_y_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_y_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "q0" }} , 
 	{ "name": "error_flag", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "error_flag", "role": "default" }} , 
 	{ "name": "error_flag_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error_flag", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5"],
		"CDFG" : "os_heap_push",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "90",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "node_f_score", "Type" : "None", "Direction" : "I"},
			{"Name" : "node_g_score", "Type" : "None", "Direction" : "I"},
			{"Name" : "node_x", "Type" : "None", "Direction" : "I"},
			{"Name" : "node_y", "Type" : "None", "Direction" : "I"},
			{"Name" : "open_set_size", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "open_set_heap_f_score_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_g_score_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_x_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "open_set_heap_y_V", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "error_flag", "Type" : "Vld", "Direction" : "O"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_f_score_V_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_g_score_V_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_x_V_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_node_y_V_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.moves_target_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	os_heap_push {
		node_f_score {Type I LastRead 0 FirstWrite -1}
		node_g_score {Type I LastRead 0 FirstWrite -1}
		node_x {Type I LastRead 0 FirstWrite -1}
		node_y {Type I LastRead 0 FirstWrite -1}
		open_set_size {Type IO LastRead 0 FirstWrite 0}
		open_set_heap_f_score_V {Type IO LastRead 54 FirstWrite 0}
		open_set_heap_g_score_V {Type IO LastRead 54 FirstWrite 0}
		open_set_heap_x_V {Type IO LastRead 54 FirstWrite 0}
		open_set_heap_y_V {Type IO LastRead 54 FirstWrite 0}
		error_flag {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "90"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "90"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	node_f_score { ap_none {  { node_f_score in_data 0 11 } } }
	node_g_score { ap_none {  { node_g_score in_data 0 11 } } }
	node_x { ap_none {  { node_x in_data 0 9 } } }
	node_y { ap_none {  { node_y in_data 0 9 } } }
	open_set_size { ap_ovld {  { open_set_size_i in_data 0 16 }  { open_set_size_o out_data 1 16 }  { open_set_size_o_ap_vld out_vld 1 1 } } }
	open_set_heap_f_score_V { ap_memory {  { open_set_heap_f_score_V_address0 mem_address 1 15 }  { open_set_heap_f_score_V_ce0 mem_ce 1 1 }  { open_set_heap_f_score_V_we0 mem_we 1 1 }  { open_set_heap_f_score_V_d0 mem_din 1 11 }  { open_set_heap_f_score_V_q0 mem_dout 0 11 } } }
	open_set_heap_g_score_V { ap_memory {  { open_set_heap_g_score_V_address0 mem_address 1 15 }  { open_set_heap_g_score_V_ce0 mem_ce 1 1 }  { open_set_heap_g_score_V_we0 mem_we 1 1 }  { open_set_heap_g_score_V_d0 mem_din 1 11 }  { open_set_heap_g_score_V_q0 mem_dout 0 11 } } }
	open_set_heap_x_V { ap_memory {  { open_set_heap_x_V_address0 mem_address 1 15 }  { open_set_heap_x_V_ce0 mem_ce 1 1 }  { open_set_heap_x_V_we0 mem_we 1 1 }  { open_set_heap_x_V_d0 mem_din 1 9 }  { open_set_heap_x_V_q0 mem_dout 0 9 } } }
	open_set_heap_y_V { ap_memory {  { open_set_heap_y_V_address0 mem_address 1 15 }  { open_set_heap_y_V_ce0 mem_ce 1 1 }  { open_set_heap_y_V_we0 mem_we 1 1 }  { open_set_heap_y_V_d0 mem_din 1 9 }  { open_set_heap_y_V_q0 mem_dout 0 9 } } }
	error_flag { ap_vld {  { error_flag out_data 1 32 }  { error_flag_ap_vld out_vld 1 1 } } }
}
