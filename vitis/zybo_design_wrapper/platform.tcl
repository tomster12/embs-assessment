# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/tomster12/files/EMBS/vitis/zybo_design_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/tomster12/files/EMBS/vitis/zybo_design_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zybo_design_wrapper}\
-hw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {/home/tomster12/files/EMBS/vitis}

platform write
domain create -name {freertos10_xilinx_ps7_cortexa9_0} -display-name {freertos10_xilinx_ps7_cortexa9_0} -os {freertos10_xilinx} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {zybo_design_wrapper}
domain active {zynq_fsbl}
domain active {freertos10_xilinx_ps7_cortexa9_0}
platform generate -quick
bsp reload
bsp setlib -name lwip211 -ver 1.3
bsp config api_mode "SOCKET_API"
bsp config lwip_dhcp "true"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
bsp reload
domain active {zynq_fsbl}
bsp reload
bsp reload
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform generate -domains freertos10_xilinx_ps7_cortexa9_0 
platform active {zybo_design_wrapper}
bsp reload
bsp reload
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
bsp reload
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
bsp reload
platform generate
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
bsp reload
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
bsp reload
platform generate
platform generate -domains freertos10_xilinx_ps7_cortexa9_0,zynq_fsbl 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate
platform generate -domains freertos10_xilinx_ps7_cortexa9_0,zynq_fsbl 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform generate -domains freertos10_xilinx_ps7_cortexa9_0,zynq_fsbl 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform active {zybo_design_wrapper}
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/tomster12/files/EMBS/vivado/zybo_design_wrapper.xsa}
platform generate -domains 
