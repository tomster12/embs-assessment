
�
�The XPM instance: <%s> is part of IP: <%s>. This XPM instance will be excluded from the .mmi because updatemem is prohibited from making changes to an XPM that is part of an IP.
136*memdata2�
�zybo_design_i/hdmi/v_axi4s_vid_out_0/inst/COUPLER_INST/generate_async_fifo.FIFO_INST/XPM_FIFO_ASYNC_INST/gnuram_async_fifo.xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst2default:default28
$zybo_design_i/hdmi/v_axi4s_vid_out_02default:defaultZ28-208h px� 
�
�The XPM instance: <%s> is part of IP: <%s>. This XPM instance will be excluded from the .mmi because updatemem is prohibited from making changes to an XPM that is part of an IP.
136*memdata2�
�zybo_design_i/hdmi/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_MM2S_FULL.I_MM2S_FULL_WRAPPER/GEN_INCLUDE_MM2S_SF.I_RD_SF/I_DATA_FIFO/BLK_MEM.I_SYNC_FIFOGEN_FIFO/xpm_fifo_instance.xpm_fifo_sync_inst/xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst2default:default21
zybo_design_i/hdmi/axi_vdma_02default:defaultZ28-208h px� 
�
�The XPM instance: <%s> is part of IP: <%s>. This XPM instance will be excluded from the .mmi because updatemem is prohibited from making changes to an XPM that is part of an IP.
136*memdata2�
�zybo_design_i/hdmi/axi_vdma_0/U0/GEN_SPRT_FOR_MM2S.MM2S_LINEBUFFER_I/GEN_LINEBUF_NO_SOF.GEN_LINEBUFFER.GEN_SYNC_FIFO.I_LINEBUFFER_FIFO/xpm_fifo_sync_inst/xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst2default:default21
zybo_design_i/hdmi/axi_vdma_02default:defaultZ28-208h px� 
s
Command: %s
53*	vivadotcl2B
.write_bitstream -force zybo_design_wrapper.bit2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-349h px� 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[10]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[10]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[5]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[5]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[10]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[10]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[5]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[5]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[11]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[11]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[6]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[6]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[11]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[11]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[6]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[6]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[12]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[12]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[7]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[7]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[12]Wzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[12]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[7]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[7]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[5]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[5]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[0]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[0]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[5]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[5]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[0]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[0]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[6]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[6]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[1]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[1]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[6]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[6]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[1]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[1]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[7]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[7]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[2]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[2]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[7]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[7]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[2]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[2]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[8]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[8]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[3]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[3]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[8]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[8]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[3]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[3]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[9]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[9]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[4]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[4]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�
�RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2�
 "�
Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg	Gzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg2default:default2default:default2�
 "�
Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[9]Vzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/mem_reg/ADDRARDADDR[9]2default:default2default:default2�
 "�
Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[4]Hzybo_design_i/toplevel_0/inst/MAXI_m_axi_U/bus_write/buff_wdata/rnext[4]2default:default2default:default2�
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg	�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/empty_fwft_i_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px� 
�>
`No routable loads: 66 net(s) have no routable loads. The problem bus(es) and/or net(s) are %s.%s*DRC2�<
 "�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_B_CHANNEL.cmd_b_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_fb2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i2default:default"�
�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i�zybo_design_i/axi_mem_intercon/m00_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_READ.USE_SPLIT_R.read_addr_inst/USE_R_CHANNEL.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i2default:default"�
�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i�zybo_design_i/axi_mem_intercon/m01_couplers/auto_pc/inst/gen_axi4_axi3.axi3_conv_inst/USE_WRITE.write_addr_inst/USE_BURSTS.cmd_queue/inst/fifo_gen_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwss.wsts/ram_afull_i2default:..."/
(the first 15 of 42 listed)2default:default2default:default2=
 %DRC|Implementation|Routing|Chip Level2default:default8Z	RTSTAT-10h px� 
�
�writefirst: Synchronous clocking is detected for BRAM (%s) in SDP mode with WRITE_FIRST write-mode. This is the preferred mode for best power characteristics, however it may exhibit address collisions if the same address appears on both read and write ports resulting in unknown or corrupted read data. It is suggested to confirm via simulation that an address collision never occurs and if so it is suggested to try and avoid this situation. If address collisions cannot be avoided, the write-mode may be set to READ_FIRST which guarantees that the read data is the prior contents of the memory at the cost of additional power in the design. See the FPGA Memory Resources User Guide for additional information.%s*DRC2�
 "�
�zybo_design_i/hdmi/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_MM2S_FULL.I_MM2S_FULL_WRAPPER/GEN_INCLUDE_MM2S_SF.I_RD_SF/I_DATA_FIFO/BLK_MEM.I_SYNC_FIFOGEN_FIFO/xpm_fifo_instance.xpm_fifo_sync_inst/xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst/gen_wr_a.gen_word_narrow.mem_reg	�zybo_design_i/hdmi/axi_vdma_0/U0/I_PRMRY_DATAMOVER/GEN_MM2S_FULL.I_MM2S_FULL_WRAPPER/GEN_INCLUDE_MM2S_SF.I_RD_SF/I_DATA_FIFO/BLK_MEM.I_SYNC_FIFOGEN_FIFO/xpm_fifo_instance.xpm_fifo_sync_inst/xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst/gen_wr_a.gen_word_narrow.mem_reg2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB36E12default:default8ZREQP-181h px� 
u
DRC finished with %s
1905*	planAhead27
#0 Errors, 17 Warnings, 1 Advisories2default:defaultZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
i
)Running write_bitstream with %s threads.
1750*designutils2
82default:defaultZ20-2272h px� 
?
Loading data files...
1271*designutilsZ12-1165h px� 
>
Loading site data...
1273*designutilsZ12-1167h px� 
?
Loading route data...
1272*designutilsZ12-1166h px� 
?
Processing options...
1362*designutilsZ12-1514h px� 
<
Creating bitmap...
1249*designutilsZ12-1141h px� 
7
Creating bitstream...
7*	bitstreamZ40-7h px� 
j
Writing bitstream %s...
11*	bitstream2-
./zybo_design_wrapper.bit2default:defaultZ40-11h px� 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px� 
�
�WebTalk data collection is mandatory when using a WebPACK part without a full Vivado license. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.
120*projectZ1-120h px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
162default:default2
172default:default2
02default:default2
02default:defaultZ4-41h px� 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2%
write_bitstream: 2default:default2
00:00:192default:default2
00:00:202default:default2
3624.1372default:default2
253.6952default:default2
5152default:default2
45052default:defaultZ17-722h px� 


End Record