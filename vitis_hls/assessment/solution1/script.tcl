############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project assessment
set_top toplevel
add_files assessment/toplevel.cpp
add_files assessment/toplevel.h
add_files -tb assessment/testbench.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z010-clg400-1}
create_clock -period 10 -name default
config_export -format sysgen -rtl verilog
source "./assessment/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format sysgen
