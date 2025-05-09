# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/assessment_system/_ide/scripts/assessment_system_(local)_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/assessment_system/_ide/scripts/assessment_system_(local)_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351A78039A" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351A78039A-13722093-0"}
fpga -file /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/assessment/_ide/bitstream/zybo_design_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/zybo_design_wrapper/export/zybo_design_wrapper/hw/zybo_design_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/assessment/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/userfs/t/tb1262/Files/EMBS/embs-assessment/vitis/assessment/Release/assessment.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
