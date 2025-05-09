#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vitis/2020.2/bin:/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vivado/2020.2/ids_lite/ISE/bin/lin64:/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vivado/2020.2/bin
else
  PATH=/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vitis/2020.2/bin:/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vivado/2020.2/ids_lite/ISE/bin/lin64:/opt/york/cs/net/xilinx_vivado-2020.2_ise-14.7_x86-64-1/Vivado/2020.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/userfs/t/tb1262/Files/EMBS/embs-assessment/vivado/vivado.runs/zybo_design_auto_us_0_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log zybo_design_auto_us_0.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source zybo_design_auto_us_0.tcl
