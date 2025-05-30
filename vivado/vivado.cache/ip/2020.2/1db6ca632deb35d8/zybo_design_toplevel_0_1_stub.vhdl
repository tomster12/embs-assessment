-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Thu May  8 18:20:23 2025
-- Host        : DESKTOP-Q62E4QT running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zybo_design_toplevel_0_1_stub.vhdl
-- Design      : zybo_design_toplevel_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    s_axi_AXILiteS_AWADDR : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_AXILiteS_AWVALID : in STD_LOGIC;
    s_axi_AXILiteS_AWREADY : out STD_LOGIC;
    s_axi_AXILiteS_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_AXILiteS_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_AXILiteS_WVALID : in STD_LOGIC;
    s_axi_AXILiteS_WREADY : out STD_LOGIC;
    s_axi_AXILiteS_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_AXILiteS_BVALID : out STD_LOGIC;
    s_axi_AXILiteS_BREADY : in STD_LOGIC;
    s_axi_AXILiteS_ARADDR : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_AXILiteS_ARVALID : in STD_LOGIC;
    s_axi_AXILiteS_ARREADY : out STD_LOGIC;
    s_axi_AXILiteS_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_AXILiteS_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_AXILiteS_RVALID : out STD_LOGIC;
    s_axi_AXILiteS_RREADY : in STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    m_axi_MAXI_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_MAXI_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_MAXI_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_MAXI_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_MAXI_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_AWVALID : out STD_LOGIC;
    m_axi_MAXI_AWREADY : in STD_LOGIC;
    m_axi_MAXI_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_MAXI_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_WLAST : out STD_LOGIC;
    m_axi_MAXI_WVALID : out STD_LOGIC;
    m_axi_MAXI_WREADY : in STD_LOGIC;
    m_axi_MAXI_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_BVALID : in STD_LOGIC;
    m_axi_MAXI_BREADY : out STD_LOGIC;
    m_axi_MAXI_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_MAXI_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_MAXI_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_MAXI_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_MAXI_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_MAXI_ARVALID : out STD_LOGIC;
    m_axi_MAXI_ARREADY : in STD_LOGIC;
    m_axi_MAXI_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_MAXI_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_MAXI_RLAST : in STD_LOGIC;
    m_axi_MAXI_RVALID : in STD_LOGIC;
    m_axi_MAXI_RREADY : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_AXILiteS_AWADDR[4:0],s_axi_AXILiteS_AWVALID,s_axi_AXILiteS_AWREADY,s_axi_AXILiteS_WDATA[31:0],s_axi_AXILiteS_WSTRB[3:0],s_axi_AXILiteS_WVALID,s_axi_AXILiteS_WREADY,s_axi_AXILiteS_BRESP[1:0],s_axi_AXILiteS_BVALID,s_axi_AXILiteS_BREADY,s_axi_AXILiteS_ARADDR[4:0],s_axi_AXILiteS_ARVALID,s_axi_AXILiteS_ARREADY,s_axi_AXILiteS_RDATA[31:0],s_axi_AXILiteS_RRESP[1:0],s_axi_AXILiteS_RVALID,s_axi_AXILiteS_RREADY,s_axi_control_AWADDR[4:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[4:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_MAXI_AWADDR[63:0],m_axi_MAXI_AWLEN[7:0],m_axi_MAXI_AWSIZE[2:0],m_axi_MAXI_AWBURST[1:0],m_axi_MAXI_AWLOCK[1:0],m_axi_MAXI_AWREGION[3:0],m_axi_MAXI_AWCACHE[3:0],m_axi_MAXI_AWPROT[2:0],m_axi_MAXI_AWQOS[3:0],m_axi_MAXI_AWVALID,m_axi_MAXI_AWREADY,m_axi_MAXI_WDATA[31:0],m_axi_MAXI_WSTRB[3:0],m_axi_MAXI_WLAST,m_axi_MAXI_WVALID,m_axi_MAXI_WREADY,m_axi_MAXI_BRESP[1:0],m_axi_MAXI_BVALID,m_axi_MAXI_BREADY,m_axi_MAXI_ARADDR[63:0],m_axi_MAXI_ARLEN[7:0],m_axi_MAXI_ARSIZE[2:0],m_axi_MAXI_ARBURST[1:0],m_axi_MAXI_ARLOCK[1:0],m_axi_MAXI_ARREGION[3:0],m_axi_MAXI_ARCACHE[3:0],m_axi_MAXI_ARPROT[2:0],m_axi_MAXI_ARQOS[3:0],m_axi_MAXI_ARVALID,m_axi_MAXI_ARREADY,m_axi_MAXI_RDATA[31:0],m_axi_MAXI_RRESP[1:0],m_axi_MAXI_RLAST,m_axi_MAXI_RVALID,m_axi_MAXI_RREADY";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "toplevel,Vivado 2020.2";
begin
end;
