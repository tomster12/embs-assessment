set moduleName os_heap_pop
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
set C_modelName {os_heap_pop}
set C_modelType { int 29 }
set C_modelArgList {
	{ open_set_size int 16 regular {pointer 2} {global 2}  }
	{ open_set_heap_f_score_V int 11 regular {array 25000 { 2 2 } 1 1 } {global 2}  }
	{ open_set_heap_g_score_V int 11 regular {array 25000 { 2 2 } 1 1 } {global 2}  }
	{ open_set_heap_x_V int 9 regular {array 25000 { 2 2 } 1 1 } {global 2}  }
	{ open_set_heap_y_V int 9 regular {array 25000 { 2 2 } 1 1 } {global 2}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "open_set_size", "interface" : "wire", "bitwidth" : 16, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_f_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_g_score_V", "interface" : "memory", "bitwidth" : 11, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_x_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "open_set_heap_y_V", "interface" : "memory", "bitwidth" : 9, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 29} ]}
# RTL Port declarations: 
set portNum 52
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ open_set_size_i sc_in sc_lv 16 signal 0 } 
	{ open_set_size_o sc_out sc_lv 16 signal 0 } 
	{ open_set_size_o_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ open_set_heap_f_score_V_address0 sc_out sc_lv 15 signal 1 } 
	{ open_set_heap_f_score_V_ce0 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_we0 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_d0 sc_out sc_lv 11 signal 1 } 
	{ open_set_heap_f_score_V_q0 sc_in sc_lv 11 signal 1 } 
	{ open_set_heap_f_score_V_address1 sc_out sc_lv 15 signal 1 } 
	{ open_set_heap_f_score_V_ce1 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_we1 sc_out sc_logic 1 signal 1 } 
	{ open_set_heap_f_score_V_d1 sc_out sc_lv 11 signal 1 } 
	{ open_set_heap_f_score_V_q1 sc_in sc_lv 11 signal 1 } 
	{ open_set_heap_g_score_V_address0 sc_out sc_lv 15 signal 2 } 
	{ open_set_heap_g_score_V_ce0 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_we0 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_d0 sc_out sc_lv 11 signal 2 } 
	{ open_set_heap_g_score_V_q0 sc_in sc_lv 11 signal 2 } 
	{ open_set_heap_g_score_V_address1 sc_out sc_lv 15 signal 2 } 
	{ open_set_heap_g_score_V_ce1 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_we1 sc_out sc_logic 1 signal 2 } 
	{ open_set_heap_g_score_V_d1 sc_out sc_lv 11 signal 2 } 
	{ open_set_heap_g_score_V_q1 sc_in sc_lv 11 signal 2 } 
	{ open_set_heap_x_V_address0 sc_out sc_lv 15 signal 3 } 
	{ open_set_heap_x_V_ce0 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_we0 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_d0 sc_out sc_lv 9 signal 3 } 
	{ open_set_heap_x_V_q0 sc_in sc_lv 9 signal 3 } 
	{ open_set_heap_x_V_address1 sc_out sc_lv 15 signal 3 } 
	{ open_set_heap_x_V_ce1 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_we1 sc_out sc_logic 1 signal 3 } 
	{ open_set_heap_x_V_d1 sc_out sc_lv 9 signal 3 } 
	{ open_set_heap_x_V_q1 sc_in sc_lv 9 signal 3 } 
	{ open_set_heap_y_V_address0 sc_out sc_lv 15 signal 4 } 
	{ open_set_heap_y_V_ce0 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_we0 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_d0 sc_out sc_lv 9 signal 4 } 
	{ open_set_heap_y_V_q0 sc_in sc_lv 9 signal 4 } 
	{ open_set_heap_y_V_address1 sc_out sc_lv 15 signal 4 } 
	{ open_set_heap_y_V_ce1 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_we1 sc_out sc_logic 1 signal 4 } 
	{ open_set_heap_y_V_d1 sc_out sc_lv 9 signal 4 } 
	{ open_set_heap_y_V_q1 sc_in sc_lv 9 signal 4 } 
	{ ap_return_0 sc_out sc_lv 11 signal -1 } 
	{ ap_return_1 sc_out sc_lv 9 signal -1 } 
	{ ap_return_2 sc_out sc_lv 9 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "open_set_size_i", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "open_set_size", "role": "i" }} , 
 	{ "name": "open_set_size_o", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "open_set_size", "role": "o" }} , 
 	{ "name": "open_set_size_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "open_set_size", "role": "o_ap_vld" }} , 
 	{ "name": "open_set_heap_f_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_f_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_f_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_f_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_f_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_f_score_V_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "address1" }} , 
 	{ "name": "open_set_heap_f_score_V_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "ce1" }} , 
 	{ "name": "open_set_heap_f_score_V_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "we1" }} , 
 	{ "name": "open_set_heap_f_score_V_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "d1" }} , 
 	{ "name": "open_set_heap_f_score_V_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_f_score_V", "role": "q1" }} , 
 	{ "name": "open_set_heap_g_score_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_g_score_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_g_score_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_g_score_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_g_score_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_g_score_V_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "address1" }} , 
 	{ "name": "open_set_heap_g_score_V_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "ce1" }} , 
 	{ "name": "open_set_heap_g_score_V_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "we1" }} , 
 	{ "name": "open_set_heap_g_score_V_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "d1" }} , 
 	{ "name": "open_set_heap_g_score_V_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "open_set_heap_g_score_V", "role": "q1" }} , 
 	{ "name": "open_set_heap_x_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_x_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_x_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_x_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_x_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_x_V_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "address1" }} , 
 	{ "name": "open_set_heap_x_V_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "ce1" }} , 
 	{ "name": "open_set_heap_x_V_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "we1" }} , 
 	{ "name": "open_set_heap_x_V_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "d1" }} , 
 	{ "name": "open_set_heap_x_V_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_x_V", "role": "q1" }} , 
 	{ "name": "open_set_heap_y_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "address0" }} , 
 	{ "name": "open_set_heap_y_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "ce0" }} , 
 	{ "name": "open_set_heap_y_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "we0" }} , 
 	{ "name": "open_set_heap_y_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "d0" }} , 
 	{ "name": "open_set_heap_y_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "q0" }} , 
 	{ "name": "open_set_heap_y_V_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "address1" }} , 
 	{ "name": "open_set_heap_y_V_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "ce1" }} , 
 	{ "name": "open_set_heap_y_V_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "we1" }} , 
 	{ "name": "open_set_heap_y_V_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "d1" }} , 
 	{ "name": "open_set_heap_y_V_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "open_set_heap_y_V", "role": "q1" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5"],
		"CDFG" : "os_heap_pop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "104",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "open_set_size", "Type" : "OVld", "Direction" : "IO"},
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
	os_heap_pop {
		open_set_size {Type IO LastRead 0 FirstWrite 1}
		open_set_heap_f_score_V {Type IO LastRead 67 FirstWrite 1}
		open_set_heap_g_score_V {Type IO LastRead 69 FirstWrite 1}
		open_set_heap_x_V {Type IO LastRead 69 FirstWrite 1}
		open_set_heap_y_V {Type IO LastRead 69 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "104"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "104"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	open_set_size { ap_ovld {  { open_set_size_i in_data 0 16 }  { open_set_size_o out_data 1 16 }  { open_set_size_o_ap_vld out_vld 1 1 } } }
	open_set_heap_f_score_V { ap_memory {  { open_set_heap_f_score_V_address0 mem_address 1 15 }  { open_set_heap_f_score_V_ce0 mem_ce 1 1 }  { open_set_heap_f_score_V_we0 mem_we 1 1 }  { open_set_heap_f_score_V_d0 mem_din 1 11 }  { open_set_heap_f_score_V_q0 mem_dout 0 11 }  { open_set_heap_f_score_V_address1 MemPortADDR2 1 15 }  { open_set_heap_f_score_V_ce1 MemPortCE2 1 1 }  { open_set_heap_f_score_V_we1 MemPortWE2 1 1 }  { open_set_heap_f_score_V_d1 MemPortDIN2 1 11 }  { open_set_heap_f_score_V_q1 MemPortDOUT2 0 11 } } }
	open_set_heap_g_score_V { ap_memory {  { open_set_heap_g_score_V_address0 mem_address 1 15 }  { open_set_heap_g_score_V_ce0 mem_ce 1 1 }  { open_set_heap_g_score_V_we0 mem_we 1 1 }  { open_set_heap_g_score_V_d0 mem_din 1 11 }  { open_set_heap_g_score_V_q0 mem_dout 0 11 }  { open_set_heap_g_score_V_address1 MemPortADDR2 1 15 }  { open_set_heap_g_score_V_ce1 MemPortCE2 1 1 }  { open_set_heap_g_score_V_we1 MemPortWE2 1 1 }  { open_set_heap_g_score_V_d1 MemPortDIN2 1 11 }  { open_set_heap_g_score_V_q1 MemPortDOUT2 0 11 } } }
	open_set_heap_x_V { ap_memory {  { open_set_heap_x_V_address0 mem_address 1 15 }  { open_set_heap_x_V_ce0 mem_ce 1 1 }  { open_set_heap_x_V_we0 mem_we 1 1 }  { open_set_heap_x_V_d0 mem_din 1 9 }  { open_set_heap_x_V_q0 mem_dout 0 9 }  { open_set_heap_x_V_address1 MemPortADDR2 1 15 }  { open_set_heap_x_V_ce1 MemPortCE2 1 1 }  { open_set_heap_x_V_we1 MemPortWE2 1 1 }  { open_set_heap_x_V_d1 MemPortDIN2 1 9 }  { open_set_heap_x_V_q1 MemPortDOUT2 0 9 } } }
	open_set_heap_y_V { ap_memory {  { open_set_heap_y_V_address0 mem_address 1 15 }  { open_set_heap_y_V_ce0 mem_ce 1 1 }  { open_set_heap_y_V_we0 mem_we 1 1 }  { open_set_heap_y_V_d0 mem_din 1 9 }  { open_set_heap_y_V_q0 mem_dout 0 9 }  { open_set_heap_y_V_address1 MemPortADDR2 1 15 }  { open_set_heap_y_V_ce1 MemPortCE2 1 1 }  { open_set_heap_y_V_we1 MemPortWE2 1 1 }  { open_set_heap_y_V_d1 MemPortDIN2 1 9 }  { open_set_heap_y_V_q1 MemPortDOUT2 0 9 } } }
}
