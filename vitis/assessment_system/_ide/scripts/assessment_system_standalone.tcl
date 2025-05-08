# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/tomster12/files/EMBS/vitis/assessment_system/_ide/scripts/assessment_system_standalone.tcl
# 
# 
# Usage with xsct:
# In an external shell use the below command and launch symbol server.
# symbol_server -S -s tcp::1534
# To debug using xsct, launch xsct and run below command
# source /home/tomster12/files/EMBS/vitis/assessment_system/_ide/scripts/assessment_system_standalone.tcl
# 
connect -path [list tcp::1534 tcp:localhost:12345]
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351A780DAA" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351A780DAA-13722093-0"}
fpga -file /home/tomster12/files/EMBS/vitis/assessment/_ide/bitstream/zybo_design_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/tomster12/files/EMBS/vitis/zybo_design_wrapper/export/zybo_design_wrapper/hw/zybo_design_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/tomster12/files/EMBS/vitis/assessment/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/tomster12/files/EMBS/vitis/assessment/Release/assessment.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
