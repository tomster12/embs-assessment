// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu May  8 18:20:23 2025
// Host        : DESKTOP-Q62E4QT running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zybo_design_toplevel_0_1_stub.v
// Design      : zybo_design_toplevel_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "toplevel,Vivado 2020.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_AXILiteS_AWADDR, 
  s_axi_AXILiteS_AWVALID, s_axi_AXILiteS_AWREADY, s_axi_AXILiteS_WDATA, 
  s_axi_AXILiteS_WSTRB, s_axi_AXILiteS_WVALID, s_axi_AXILiteS_WREADY, 
  s_axi_AXILiteS_BRESP, s_axi_AXILiteS_BVALID, s_axi_AXILiteS_BREADY, 
  s_axi_AXILiteS_ARADDR, s_axi_AXILiteS_ARVALID, s_axi_AXILiteS_ARREADY, 
  s_axi_AXILiteS_RDATA, s_axi_AXILiteS_RRESP, s_axi_AXILiteS_RVALID, 
  s_axi_AXILiteS_RREADY, s_axi_control_AWADDR, s_axi_control_AWVALID, 
  s_axi_control_AWREADY, s_axi_control_WDATA, s_axi_control_WSTRB, s_axi_control_WVALID, 
  s_axi_control_WREADY, s_axi_control_BRESP, s_axi_control_BVALID, s_axi_control_BREADY, 
  s_axi_control_ARADDR, s_axi_control_ARVALID, s_axi_control_ARREADY, 
  s_axi_control_RDATA, s_axi_control_RRESP, s_axi_control_RVALID, s_axi_control_RREADY, 
  ap_clk, ap_rst_n, interrupt, m_axi_MAXI_AWADDR, m_axi_MAXI_AWLEN, m_axi_MAXI_AWSIZE, 
  m_axi_MAXI_AWBURST, m_axi_MAXI_AWLOCK, m_axi_MAXI_AWREGION, m_axi_MAXI_AWCACHE, 
  m_axi_MAXI_AWPROT, m_axi_MAXI_AWQOS, m_axi_MAXI_AWVALID, m_axi_MAXI_AWREADY, 
  m_axi_MAXI_WDATA, m_axi_MAXI_WSTRB, m_axi_MAXI_WLAST, m_axi_MAXI_WVALID, 
  m_axi_MAXI_WREADY, m_axi_MAXI_BRESP, m_axi_MAXI_BVALID, m_axi_MAXI_BREADY, 
  m_axi_MAXI_ARADDR, m_axi_MAXI_ARLEN, m_axi_MAXI_ARSIZE, m_axi_MAXI_ARBURST, 
  m_axi_MAXI_ARLOCK, m_axi_MAXI_ARREGION, m_axi_MAXI_ARCACHE, m_axi_MAXI_ARPROT, 
  m_axi_MAXI_ARQOS, m_axi_MAXI_ARVALID, m_axi_MAXI_ARREADY, m_axi_MAXI_RDATA, 
  m_axi_MAXI_RRESP, m_axi_MAXI_RLAST, m_axi_MAXI_RVALID, m_axi_MAXI_RREADY)
/* synthesis syn_black_box black_box_pad_pin="s_axi_AXILiteS_AWADDR[4:0],s_axi_AXILiteS_AWVALID,s_axi_AXILiteS_AWREADY,s_axi_AXILiteS_WDATA[31:0],s_axi_AXILiteS_WSTRB[3:0],s_axi_AXILiteS_WVALID,s_axi_AXILiteS_WREADY,s_axi_AXILiteS_BRESP[1:0],s_axi_AXILiteS_BVALID,s_axi_AXILiteS_BREADY,s_axi_AXILiteS_ARADDR[4:0],s_axi_AXILiteS_ARVALID,s_axi_AXILiteS_ARREADY,s_axi_AXILiteS_RDATA[31:0],s_axi_AXILiteS_RRESP[1:0],s_axi_AXILiteS_RVALID,s_axi_AXILiteS_RREADY,s_axi_control_AWADDR[4:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[4:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_MAXI_AWADDR[63:0],m_axi_MAXI_AWLEN[7:0],m_axi_MAXI_AWSIZE[2:0],m_axi_MAXI_AWBURST[1:0],m_axi_MAXI_AWLOCK[1:0],m_axi_MAXI_AWREGION[3:0],m_axi_MAXI_AWCACHE[3:0],m_axi_MAXI_AWPROT[2:0],m_axi_MAXI_AWQOS[3:0],m_axi_MAXI_AWVALID,m_axi_MAXI_AWREADY,m_axi_MAXI_WDATA[31:0],m_axi_MAXI_WSTRB[3:0],m_axi_MAXI_WLAST,m_axi_MAXI_WVALID,m_axi_MAXI_WREADY,m_axi_MAXI_BRESP[1:0],m_axi_MAXI_BVALID,m_axi_MAXI_BREADY,m_axi_MAXI_ARADDR[63:0],m_axi_MAXI_ARLEN[7:0],m_axi_MAXI_ARSIZE[2:0],m_axi_MAXI_ARBURST[1:0],m_axi_MAXI_ARLOCK[1:0],m_axi_MAXI_ARREGION[3:0],m_axi_MAXI_ARCACHE[3:0],m_axi_MAXI_ARPROT[2:0],m_axi_MAXI_ARQOS[3:0],m_axi_MAXI_ARVALID,m_axi_MAXI_ARREADY,m_axi_MAXI_RDATA[31:0],m_axi_MAXI_RRESP[1:0],m_axi_MAXI_RLAST,m_axi_MAXI_RVALID,m_axi_MAXI_RREADY" */;
  input [4:0]s_axi_AXILiteS_AWADDR;
  input s_axi_AXILiteS_AWVALID;
  output s_axi_AXILiteS_AWREADY;
  input [31:0]s_axi_AXILiteS_WDATA;
  input [3:0]s_axi_AXILiteS_WSTRB;
  input s_axi_AXILiteS_WVALID;
  output s_axi_AXILiteS_WREADY;
  output [1:0]s_axi_AXILiteS_BRESP;
  output s_axi_AXILiteS_BVALID;
  input s_axi_AXILiteS_BREADY;
  input [4:0]s_axi_AXILiteS_ARADDR;
  input s_axi_AXILiteS_ARVALID;
  output s_axi_AXILiteS_ARREADY;
  output [31:0]s_axi_AXILiteS_RDATA;
  output [1:0]s_axi_AXILiteS_RRESP;
  output s_axi_AXILiteS_RVALID;
  input s_axi_AXILiteS_RREADY;
  input [4:0]s_axi_control_AWADDR;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  output [1:0]s_axi_control_BRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  input [4:0]s_axi_control_ARADDR;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  output [31:0]s_axi_control_RDATA;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  output [63:0]m_axi_MAXI_AWADDR;
  output [7:0]m_axi_MAXI_AWLEN;
  output [2:0]m_axi_MAXI_AWSIZE;
  output [1:0]m_axi_MAXI_AWBURST;
  output [1:0]m_axi_MAXI_AWLOCK;
  output [3:0]m_axi_MAXI_AWREGION;
  output [3:0]m_axi_MAXI_AWCACHE;
  output [2:0]m_axi_MAXI_AWPROT;
  output [3:0]m_axi_MAXI_AWQOS;
  output m_axi_MAXI_AWVALID;
  input m_axi_MAXI_AWREADY;
  output [31:0]m_axi_MAXI_WDATA;
  output [3:0]m_axi_MAXI_WSTRB;
  output m_axi_MAXI_WLAST;
  output m_axi_MAXI_WVALID;
  input m_axi_MAXI_WREADY;
  input [1:0]m_axi_MAXI_BRESP;
  input m_axi_MAXI_BVALID;
  output m_axi_MAXI_BREADY;
  output [63:0]m_axi_MAXI_ARADDR;
  output [7:0]m_axi_MAXI_ARLEN;
  output [2:0]m_axi_MAXI_ARSIZE;
  output [1:0]m_axi_MAXI_ARBURST;
  output [1:0]m_axi_MAXI_ARLOCK;
  output [3:0]m_axi_MAXI_ARREGION;
  output [3:0]m_axi_MAXI_ARCACHE;
  output [2:0]m_axi_MAXI_ARPROT;
  output [3:0]m_axi_MAXI_ARQOS;
  output m_axi_MAXI_ARVALID;
  input m_axi_MAXI_ARREADY;
  input [31:0]m_axi_MAXI_RDATA;
  input [1:0]m_axi_MAXI_RRESP;
  input m_axi_MAXI_RLAST;
  input m_axi_MAXI_RVALID;
  output m_axi_MAXI_RREADY;
endmodule
