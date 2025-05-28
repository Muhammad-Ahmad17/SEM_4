-- Copyright (C) 2024  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"

-- DATE "05/08/2025 10:30:10"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_P28,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Wrapper IS
    PORT (
	leds : OUT std_logic_vector(3 DOWNTO 0);
	branch_decision : IN std_logic;
	jump_decision : IN std_logic;
	reset : IN std_logic;
	clk : IN std_logic;
	hex0 : OUT std_logic_vector(6 DOWNTO 0);
	hex1 : OUT std_logic_vector(6 DOWNTO 0);
	hex2 : OUT std_logic_vector(6 DOWNTO 0);
	hex3 : OUT std_logic_vector(6 DOWNTO 0);
	hex4 : OUT std_logic_vector(6 DOWNTO 0);
	hex5 : OUT std_logic_vector(6 DOWNTO 0);
	hex6 : OUT std_logic_vector(6 DOWNTO 0);
	hex7 : OUT std_logic_vector(6 DOWNTO 0)
	);
END Wrapper;

-- Design Ports Information
-- leds[0]	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[1]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[2]	=>  Location: PIN_G8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[3]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[0]	=>  Location: PIN_H8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[1]	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[2]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[3]	=>  Location: PIN_E7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[4]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[5]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[6]	=>  Location: PIN_G7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[0]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[1]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[2]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[3]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[4]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[5]	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[6]	=>  Location: PIN_E11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[0]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[1]	=>  Location: PIN_H7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[2]	=>  Location: PIN_E4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[3]	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[4]	=>  Location: PIN_C5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[5]	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[6]	=>  Location: PIN_E5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[0]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[1]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[2]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[3]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[4]	=>  Location: PIN_J12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[5]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[6]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[0]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[1]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[2]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[3]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[4]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[5]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[6]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[0]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[1]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[2]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[3]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[4]	=>  Location: PIN_G11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[5]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[6]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[0]	=>  Location: PIN_A3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[1]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[2]	=>  Location: PIN_D5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[3]	=>  Location: PIN_D4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[4]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[5]	=>  Location: PIN_C4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex6[6]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[0]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[1]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[2]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[3]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[4]	=>  Location: PIN_C7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[5]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex7[6]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- branch_decision	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- jump_decision	=>  Location: PIN_F8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Wrapper IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_leds : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_branch_decision : std_logic;
SIGNAL ww_jump_decision : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_hex0 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex4 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex5 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex6 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex7 : std_logic_vector(6 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \leds[0]~output_o\ : std_logic;
SIGNAL \leds[1]~output_o\ : std_logic;
SIGNAL \leds[2]~output_o\ : std_logic;
SIGNAL \leds[3]~output_o\ : std_logic;
SIGNAL \hex0[0]~output_o\ : std_logic;
SIGNAL \hex0[1]~output_o\ : std_logic;
SIGNAL \hex0[2]~output_o\ : std_logic;
SIGNAL \hex0[3]~output_o\ : std_logic;
SIGNAL \hex0[4]~output_o\ : std_logic;
SIGNAL \hex0[5]~output_o\ : std_logic;
SIGNAL \hex0[6]~output_o\ : std_logic;
SIGNAL \hex1[0]~output_o\ : std_logic;
SIGNAL \hex1[1]~output_o\ : std_logic;
SIGNAL \hex1[2]~output_o\ : std_logic;
SIGNAL \hex1[3]~output_o\ : std_logic;
SIGNAL \hex1[4]~output_o\ : std_logic;
SIGNAL \hex1[5]~output_o\ : std_logic;
SIGNAL \hex1[6]~output_o\ : std_logic;
SIGNAL \hex2[0]~output_o\ : std_logic;
SIGNAL \hex2[1]~output_o\ : std_logic;
SIGNAL \hex2[2]~output_o\ : std_logic;
SIGNAL \hex2[3]~output_o\ : std_logic;
SIGNAL \hex2[4]~output_o\ : std_logic;
SIGNAL \hex2[5]~output_o\ : std_logic;
SIGNAL \hex2[6]~output_o\ : std_logic;
SIGNAL \hex3[0]~output_o\ : std_logic;
SIGNAL \hex3[1]~output_o\ : std_logic;
SIGNAL \hex3[2]~output_o\ : std_logic;
SIGNAL \hex3[3]~output_o\ : std_logic;
SIGNAL \hex3[4]~output_o\ : std_logic;
SIGNAL \hex3[5]~output_o\ : std_logic;
SIGNAL \hex3[6]~output_o\ : std_logic;
SIGNAL \hex4[0]~output_o\ : std_logic;
SIGNAL \hex4[1]~output_o\ : std_logic;
SIGNAL \hex4[2]~output_o\ : std_logic;
SIGNAL \hex4[3]~output_o\ : std_logic;
SIGNAL \hex4[4]~output_o\ : std_logic;
SIGNAL \hex4[5]~output_o\ : std_logic;
SIGNAL \hex4[6]~output_o\ : std_logic;
SIGNAL \hex5[0]~output_o\ : std_logic;
SIGNAL \hex5[1]~output_o\ : std_logic;
SIGNAL \hex5[2]~output_o\ : std_logic;
SIGNAL \hex5[3]~output_o\ : std_logic;
SIGNAL \hex5[4]~output_o\ : std_logic;
SIGNAL \hex5[5]~output_o\ : std_logic;
SIGNAL \hex5[6]~output_o\ : std_logic;
SIGNAL \hex6[0]~output_o\ : std_logic;
SIGNAL \hex6[1]~output_o\ : std_logic;
SIGNAL \hex6[2]~output_o\ : std_logic;
SIGNAL \hex6[3]~output_o\ : std_logic;
SIGNAL \hex6[4]~output_o\ : std_logic;
SIGNAL \hex6[5]~output_o\ : std_logic;
SIGNAL \hex6[6]~output_o\ : std_logic;
SIGNAL \hex7[0]~output_o\ : std_logic;
SIGNAL \hex7[1]~output_o\ : std_logic;
SIGNAL \hex7[2]~output_o\ : std_logic;
SIGNAL \hex7[3]~output_o\ : std_logic;
SIGNAL \hex7[4]~output_o\ : std_logic;
SIGNAL \hex7[5]~output_o\ : std_logic;
SIGNAL \hex7[6]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \branch_decision~input_o\ : std_logic;
SIGNAL \jump_decision~input_o\ : std_logic;
SIGNAL \U1|PC~0_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \U1|Add0~0_combout\ : std_logic;
SIGNAL \U1|PC[1]~feeder_combout\ : std_logic;
SIGNAL \U1|Add0~1\ : std_logic;
SIGNAL \U1|Add0~2_combout\ : std_logic;
SIGNAL \U1|mem.raddr_a[2]~0_combout\ : std_logic;
SIGNAL \U1|Add0~3\ : std_logic;
SIGNAL \U1|Add0~4_combout\ : std_logic;
SIGNAL \U1|Add0~5\ : std_logic;
SIGNAL \U1|Add0~6_combout\ : std_logic;
SIGNAL \U1|mem.raddr_a[3]~3_combout\ : std_logic;
SIGNAL \U1|instruction[3]~0_combout\ : std_logic;
SIGNAL \U1|mem.raddr_a[1]~2_combout\ : std_logic;
SIGNAL \U1|mem.raddr_a[0]~1_combout\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \U1|instruction[12]~1_combout\ : std_logic;
SIGNAL \U1|instruction[10]~3_combout\ : std_logic;
SIGNAL \U1|instruction[11]~feeder_combout\ : std_logic;
SIGNAL \U1|instruction[21]~2_combout\ : std_logic;
SIGNAL \Mux13~0_combout\ : std_logic;
SIGNAL \Mux12~0_combout\ : std_logic;
SIGNAL \Mux11~0_combout\ : std_logic;
SIGNAL \Mux10~0_combout\ : std_logic;
SIGNAL \Mux9~0_combout\ : std_logic;
SIGNAL \Mux8~0_combout\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Mux20~0_combout\ : std_logic;
SIGNAL \Mux19~0_combout\ : std_logic;
SIGNAL \Mux18~0_combout\ : std_logic;
SIGNAL \Mux17~0_combout\ : std_logic;
SIGNAL \Mux16~0_combout\ : std_logic;
SIGNAL \Mux15~0_combout\ : std_logic;
SIGNAL \Mux14~0_combout\ : std_logic;
SIGNAL \Mux27~0_combout\ : std_logic;
SIGNAL \Mux26~0_combout\ : std_logic;
SIGNAL \Mux25~0_combout\ : std_logic;
SIGNAL \Mux24~0_combout\ : std_logic;
SIGNAL \Mux23~0_combout\ : std_logic;
SIGNAL \Mux22~0_combout\ : std_logic;
SIGNAL \Mux21~0_combout\ : std_logic;
SIGNAL \Mux34~0_combout\ : std_logic;
SIGNAL \Mux33~0_combout\ : std_logic;
SIGNAL \Mux32~0_combout\ : std_logic;
SIGNAL \Mux31~0_combout\ : std_logic;
SIGNAL \Mux30~0_combout\ : std_logic;
SIGNAL \Mux29~0_combout\ : std_logic;
SIGNAL \Mux28~0_combout\ : std_logic;
SIGNAL \Mux41~0_combout\ : std_logic;
SIGNAL \Mux40~0_combout\ : std_logic;
SIGNAL \Mux39~0_combout\ : std_logic;
SIGNAL \Mux38~0_combout\ : std_logic;
SIGNAL \Mux37~0_combout\ : std_logic;
SIGNAL \Mux36~0_combout\ : std_logic;
SIGNAL \Mux35~0_combout\ : std_logic;
SIGNAL \Mux48~0_combout\ : std_logic;
SIGNAL \Mux47~0_combout\ : std_logic;
SIGNAL \Mux46~0_combout\ : std_logic;
SIGNAL \Mux45~0_combout\ : std_logic;
SIGNAL \Mux44~0_combout\ : std_logic;
SIGNAL \Mux43~0_combout\ : std_logic;
SIGNAL \Mux42~0_combout\ : std_logic;
SIGNAL \Mux55~0_combout\ : std_logic;
SIGNAL \Mux54~0_combout\ : std_logic;
SIGNAL \Mux53~0_combout\ : std_logic;
SIGNAL \Mux52~0_combout\ : std_logic;
SIGNAL \Mux51~0_combout\ : std_logic;
SIGNAL \Mux50~0_combout\ : std_logic;
SIGNAL \Mux49~0_combout\ : std_logic;
SIGNAL \U1|PC_OUT\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \U1|instruction\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \U1|PC\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \ALT_INV_reset~input_o\ : std_logic;
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux14~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux7~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux49~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux21~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux42~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux35~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux28~0_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

leds <= ww_leds;
ww_branch_decision <= branch_decision;
ww_jump_decision <= jump_decision;
ww_reset <= reset;
ww_clk <= clk;
hex0 <= ww_hex0;
hex1 <= ww_hex1;
hex2 <= ww_hex2;
hex3 <= ww_hex3;
hex4 <= ww_hex4;
hex5 <= ww_hex5;
hex6 <= ww_hex6;
hex7 <= ww_hex7;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\ALT_INV_reset~input_o\ <= NOT \reset~input_o\;
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
\ALT_INV_Mux14~0_combout\ <= NOT \Mux14~0_combout\;
\ALT_INV_Mux7~0_combout\ <= NOT \Mux7~0_combout\;
\ALT_INV_Mux49~0_combout\ <= NOT \Mux49~0_combout\;
\ALT_INV_Mux21~0_combout\ <= NOT \Mux21~0_combout\;
\ALT_INV_Mux42~0_combout\ <= NOT \Mux42~0_combout\;
\ALT_INV_Mux35~0_combout\ <= NOT \Mux35~0_combout\;
\ALT_INV_Mux28~0_combout\ <= NOT \Mux28~0_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X13_Y73_N23
\leds[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U1|PC_OUT\(0),
	devoe => ww_devoe,
	o => \leds[0]~output_o\);

-- Location: IOOBUF_X13_Y73_N16
\leds[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U1|PC_OUT\(1),
	devoe => ww_devoe,
	o => \leds[1]~output_o\);

-- Location: IOOBUF_X11_Y73_N16
\leds[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U1|PC_OUT\(2),
	devoe => ww_devoe,
	o => \leds[2]~output_o\);

-- Location: IOOBUF_X9_Y73_N9
\leds[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U1|PC_OUT\(3),
	devoe => ww_devoe,
	o => \leds[3]~output_o\);

-- Location: IOOBUF_X11_Y73_N23
\hex0[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~0_combout\,
	devoe => ww_devoe,
	o => \hex0[0]~output_o\);

-- Location: IOOBUF_X7_Y73_N16
\hex0[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux5~0_combout\,
	devoe => ww_devoe,
	o => \hex0[1]~output_o\);

-- Location: IOOBUF_X20_Y73_N23
\hex0[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux4~0_combout\,
	devoe => ww_devoe,
	o => \hex0[2]~output_o\);

-- Location: IOOBUF_X13_Y73_N9
\hex0[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux3~0_combout\,
	devoe => ww_devoe,
	o => \hex0[3]~output_o\);

-- Location: IOOBUF_X18_Y73_N23
\hex0[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux2~0_combout\,
	devoe => ww_devoe,
	o => \hex0[4]~output_o\);

-- Location: IOOBUF_X16_Y73_N2
\hex0[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux1~0_combout\,
	devoe => ww_devoe,
	o => \hex0[5]~output_o\);

-- Location: IOOBUF_X9_Y73_N2
\hex0[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => \hex0[6]~output_o\);

-- Location: IOOBUF_X20_Y73_N2
\hex1[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux13~0_combout\,
	devoe => ww_devoe,
	o => \hex1[0]~output_o\);

-- Location: IOOBUF_X23_Y73_N9
\hex1[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux12~0_combout\,
	devoe => ww_devoe,
	o => \hex1[1]~output_o\);

-- Location: IOOBUF_X25_Y73_N23
\hex1[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux11~0_combout\,
	devoe => ww_devoe,
	o => \hex1[2]~output_o\);

-- Location: IOOBUF_X23_Y73_N23
\hex1[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux10~0_combout\,
	devoe => ww_devoe,
	o => \hex1[3]~output_o\);

-- Location: IOOBUF_X27_Y73_N9
\hex1[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux9~0_combout\,
	devoe => ww_devoe,
	o => \hex1[4]~output_o\);

-- Location: IOOBUF_X29_Y73_N9
\hex1[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux8~0_combout\,
	devoe => ww_devoe,
	o => \hex1[5]~output_o\);

-- Location: IOOBUF_X31_Y73_N2
\hex1[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux7~0_combout\,
	devoe => ww_devoe,
	o => \hex1[6]~output_o\);

-- Location: IOOBUF_X0_Y68_N9
\hex2[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux20~0_combout\,
	devoe => ww_devoe,
	o => \hex2[0]~output_o\);

-- Location: IOOBUF_X0_Y68_N16
\hex2[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux19~0_combout\,
	devoe => ww_devoe,
	o => \hex2[1]~output_o\);

-- Location: IOOBUF_X1_Y73_N9
\hex2[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux18~0_combout\,
	devoe => ww_devoe,
	o => \hex2[2]~output_o\);

-- Location: IOOBUF_X7_Y73_N23
\hex2[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux17~0_combout\,
	devoe => ww_devoe,
	o => \hex2[3]~output_o\);

-- Location: IOOBUF_X3_Y73_N9
\hex2[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux16~0_combout\,
	devoe => ww_devoe,
	o => \hex2[4]~output_o\);

-- Location: IOOBUF_X5_Y73_N2
\hex2[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~0_combout\,
	devoe => ww_devoe,
	o => \hex2[5]~output_o\);

-- Location: IOOBUF_X1_Y73_N16
\hex2[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux14~0_combout\,
	devoe => ww_devoe,
	o => \hex2[6]~output_o\);

-- Location: IOOBUF_X42_Y73_N2
\hex3[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux27~0_combout\,
	devoe => ww_devoe,
	o => \hex3[0]~output_o\);

-- Location: IOOBUF_X35_Y73_N23
\hex3[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux26~0_combout\,
	devoe => ww_devoe,
	o => \hex3[1]~output_o\);

-- Location: IOOBUF_X45_Y73_N9
\hex3[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux25~0_combout\,
	devoe => ww_devoe,
	o => \hex3[2]~output_o\);

-- Location: IOOBUF_X33_Y73_N2
\hex3[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux24~0_combout\,
	devoe => ww_devoe,
	o => \hex3[3]~output_o\);

-- Location: IOOBUF_X40_Y73_N9
\hex3[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~0_combout\,
	devoe => ww_devoe,
	o => \hex3[4]~output_o\);

-- Location: IOOBUF_X35_Y73_N16
\hex3[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux22~0_combout\,
	devoe => ww_devoe,
	o => \hex3[5]~output_o\);

-- Location: IOOBUF_X38_Y73_N16
\hex3[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux21~0_combout\,
	devoe => ww_devoe,
	o => \hex3[6]~output_o\);

-- Location: IOOBUF_X40_Y73_N2
\hex4[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux34~0_combout\,
	devoe => ww_devoe,
	o => \hex4[0]~output_o\);

-- Location: IOOBUF_X38_Y73_N2
\hex4[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux33~0_combout\,
	devoe => ww_devoe,
	o => \hex4[1]~output_o\);

-- Location: IOOBUF_X38_Y73_N9
\hex4[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux32~0_combout\,
	devoe => ww_devoe,
	o => \hex4[2]~output_o\);

-- Location: IOOBUF_X38_Y73_N23
\hex4[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux31~0_combout\,
	devoe => ww_devoe,
	o => \hex4[3]~output_o\);

-- Location: IOOBUF_X33_Y73_N9
\hex4[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux30~0_combout\,
	devoe => ww_devoe,
	o => \hex4[4]~output_o\);

-- Location: IOOBUF_X42_Y73_N9
\hex4[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux29~0_combout\,
	devoe => ww_devoe,
	o => \hex4[5]~output_o\);

-- Location: IOOBUF_X45_Y73_N2
\hex4[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux28~0_combout\,
	devoe => ww_devoe,
	o => \hex4[6]~output_o\);

-- Location: IOOBUF_X31_Y73_N9
\hex5[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux41~0_combout\,
	devoe => ww_devoe,
	o => \hex5[0]~output_o\);

-- Location: IOOBUF_X23_Y73_N2
\hex5[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux40~0_combout\,
	devoe => ww_devoe,
	o => \hex5[1]~output_o\);

-- Location: IOOBUF_X29_Y73_N2
\hex5[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux39~0_combout\,
	devoe => ww_devoe,
	o => \hex5[2]~output_o\);

-- Location: IOOBUF_X27_Y73_N16
\hex5[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux38~0_combout\,
	devoe => ww_devoe,
	o => \hex5[3]~output_o\);

-- Location: IOOBUF_X25_Y73_N16
\hex5[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux37~0_combout\,
	devoe => ww_devoe,
	o => \hex5[4]~output_o\);

-- Location: IOOBUF_X23_Y73_N16
\hex5[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux36~0_combout\,
	devoe => ww_devoe,
	o => \hex5[5]~output_o\);

-- Location: IOOBUF_X27_Y73_N23
\hex5[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux35~0_combout\,
	devoe => ww_devoe,
	o => \hex5[6]~output_o\);

-- Location: IOOBUF_X5_Y73_N9
\hex6[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux48~0_combout\,
	devoe => ww_devoe,
	o => \hex6[0]~output_o\);

-- Location: IOOBUF_X0_Y69_N9
\hex6[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux47~0_combout\,
	devoe => ww_devoe,
	o => \hex6[1]~output_o\);

-- Location: IOOBUF_X3_Y73_N2
\hex6[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux46~0_combout\,
	devoe => ww_devoe,
	o => \hex6[2]~output_o\);

-- Location: IOOBUF_X1_Y73_N2
\hex6[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux45~0_combout\,
	devoe => ww_devoe,
	o => \hex6[3]~output_o\);

-- Location: IOOBUF_X5_Y73_N23
\hex6[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux44~0_combout\,
	devoe => ww_devoe,
	o => \hex6[4]~output_o\);

-- Location: IOOBUF_X3_Y73_N23
\hex6[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux43~0_combout\,
	devoe => ww_devoe,
	o => \hex6[5]~output_o\);

-- Location: IOOBUF_X1_Y73_N23
\hex6[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux42~0_combout\,
	devoe => ww_devoe,
	o => \hex6[6]~output_o\);

-- Location: IOOBUF_X20_Y73_N16
\hex7[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux55~0_combout\,
	devoe => ww_devoe,
	o => \hex7[0]~output_o\);

-- Location: IOOBUF_X20_Y73_N9
\hex7[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux54~0_combout\,
	devoe => ww_devoe,
	o => \hex7[1]~output_o\);

-- Location: IOOBUF_X16_Y73_N9
\hex7[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux53~0_combout\,
	devoe => ww_devoe,
	o => \hex7[2]~output_o\);

-- Location: IOOBUF_X18_Y73_N16
\hex7[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux52~0_combout\,
	devoe => ww_devoe,
	o => \hex7[3]~output_o\);

-- Location: IOOBUF_X16_Y73_N23
\hex7[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux51~0_combout\,
	devoe => ww_devoe,
	o => \hex7[4]~output_o\);

-- Location: IOOBUF_X16_Y73_N16
\hex7[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux50~0_combout\,
	devoe => ww_devoe,
	o => \hex7[5]~output_o\);

-- Location: IOOBUF_X13_Y73_N2
\hex7[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux49~0_combout\,
	devoe => ww_devoe,
	o => \hex7[6]~output_o\);

-- Location: IOIBUF_X0_Y36_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G2
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X11_Y73_N1
\branch_decision~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_branch_decision,
	o => \branch_decision~input_o\);

-- Location: IOIBUF_X11_Y73_N8
\jump_decision~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_jump_decision,
	o => \jump_decision~input_o\);

-- Location: LCCOMB_X11_Y72_N10
\U1|PC~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|PC~0_combout\ = (\branch_decision~input_o\) # (\jump_decision~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \branch_decision~input_o\,
	datad => \jump_decision~input_o\,
	combout => \U1|PC~0_combout\);

-- Location: IOIBUF_X0_Y36_N15
\reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G4
\reset~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: FF_X11_Y72_N17
\U1|PC[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC\(0));

-- Location: LCCOMB_X11_Y72_N18
\U1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|Add0~0_combout\ = (((\U1|PC~0_combout\) # (\U1|PC\(0))))
-- \U1|Add0~1\ = CARRY((\U1|PC~0_combout\) # (\U1|PC\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|PC~0_combout\,
	datab => \U1|PC\(0),
	datad => VCC,
	combout => \U1|Add0~0_combout\,
	cout => \U1|Add0~1\);

-- Location: FF_X11_Y72_N23
\U1|PC_OUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~0_combout\,
	sload => VCC,
	ena => \ALT_INV_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC_OUT\(0));

-- Location: LCCOMB_X11_Y72_N28
\U1|PC[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|PC[1]~feeder_combout\ = \U1|Add0~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|Add0~2_combout\,
	combout => \U1|PC[1]~feeder_combout\);

-- Location: FF_X11_Y72_N29
\U1|PC[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|PC[1]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC\(1));

-- Location: LCCOMB_X11_Y72_N20
\U1|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|Add0~2_combout\ = (\U1|PC~0_combout\ & (((!\U1|Add0~1\)))) # (!\U1|PC~0_combout\ & ((\U1|PC\(1) & (!\U1|Add0~1\)) # (!\U1|PC\(1) & ((\U1|Add0~1\) # (GND)))))
-- \U1|Add0~3\ = CARRY(((!\U1|PC~0_combout\ & !\U1|PC\(1))) # (!\U1|Add0~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111000011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U1|PC~0_combout\,
	datab => \U1|PC\(1),
	datad => VCC,
	cin => \U1|Add0~1\,
	combout => \U1|Add0~2_combout\,
	cout => \U1|Add0~3\);

-- Location: FF_X11_Y72_N9
\U1|PC_OUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~2_combout\,
	sload => VCC,
	ena => \ALT_INV_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC_OUT\(1));

-- Location: FF_X11_Y72_N7
\U1|PC[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~4_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC\(2));

-- Location: LCCOMB_X11_Y72_N12
\U1|mem.raddr_a[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|mem.raddr_a[2]~0_combout\ = (!\branch_decision~input_o\ & ((\jump_decision~input_o\) # (\U1|PC\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \jump_decision~input_o\,
	datac => \branch_decision~input_o\,
	datad => \U1|PC\(2),
	combout => \U1|mem.raddr_a[2]~0_combout\);

-- Location: LCCOMB_X11_Y72_N22
\U1|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|Add0~4_combout\ = (\U1|mem.raddr_a[2]~0_combout\ & (\U1|Add0~3\ $ (GND))) # (!\U1|mem.raddr_a[2]~0_combout\ & (!\U1|Add0~3\ & VCC))
-- \U1|Add0~5\ = CARRY((\U1|mem.raddr_a[2]~0_combout\ & !\U1|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U1|mem.raddr_a[2]~0_combout\,
	datad => VCC,
	cin => \U1|Add0~3\,
	combout => \U1|Add0~4_combout\,
	cout => \U1|Add0~5\);

-- Location: FF_X11_Y72_N21
\U1|PC_OUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~4_combout\,
	sload => VCC,
	ena => \ALT_INV_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC_OUT\(2));

-- Location: FF_X11_Y72_N11
\U1|PC[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|Add0~6_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC\(3));

-- Location: LCCOMB_X11_Y72_N24
\U1|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|Add0~6_combout\ = \U1|Add0~5\ $ (((!\U1|PC~0_combout\ & \U1|PC\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U1|PC~0_combout\,
	datad => \U1|PC\(3),
	cin => \U1|Add0~5\,
	combout => \U1|Add0~6_combout\);

-- Location: FF_X11_Y72_N25
\U1|PC_OUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|Add0~6_combout\,
	ena => \ALT_INV_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|PC_OUT\(3));

-- Location: LCCOMB_X11_Y72_N8
\U1|mem.raddr_a[3]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|mem.raddr_a[3]~3_combout\ = (!\branch_decision~input_o\ & (!\jump_decision~input_o\ & \U1|PC\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \branch_decision~input_o\,
	datab => \jump_decision~input_o\,
	datad => \U1|PC\(3),
	combout => \U1|mem.raddr_a[3]~3_combout\);

-- Location: LCCOMB_X11_Y72_N26
\U1|instruction[3]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|instruction[3]~0_combout\ = !\U1|mem.raddr_a[3]~3_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|mem.raddr_a[3]~3_combout\,
	combout => \U1|instruction[3]~0_combout\);

-- Location: FF_X11_Y72_N27
\U1|instruction[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|instruction[3]~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(3));

-- Location: FF_X11_Y72_N13
\U1|instruction[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|mem.raddr_a[2]~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(22));

-- Location: LCCOMB_X11_Y72_N16
\U1|mem.raddr_a[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|mem.raddr_a[1]~2_combout\ = (\branch_decision~input_o\) # ((\jump_decision~input_o\) # (\U1|PC\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \branch_decision~input_o\,
	datab => \jump_decision~input_o\,
	datad => \U1|PC\(1),
	combout => \U1|mem.raddr_a[1]~2_combout\);

-- Location: FF_X11_Y72_N3
\U1|instruction[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|mem.raddr_a[1]~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(13));

-- Location: LCCOMB_X11_Y72_N6
\U1|mem.raddr_a[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|mem.raddr_a[0]~1_combout\ = (\branch_decision~input_o\) # ((\jump_decision~input_o\) # (\U1|PC\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \branch_decision~input_o\,
	datab => \jump_decision~input_o\,
	datad => \U1|PC\(0),
	combout => \U1|mem.raddr_a[0]~1_combout\);

-- Location: FF_X11_Y72_N19
\U1|instruction[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \U1|mem.raddr_a[0]~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(0));

-- Location: LCCOMB_X11_Y72_N2
\Mux6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (\U1|instruction\(3) & (!\U1|instruction\(13) & (\U1|instruction\(22) $ (\U1|instruction\(0))))) # (!\U1|instruction\(3) & (\U1|instruction\(0) & (\U1|instruction\(22) $ (\U1|instruction\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001011000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(3),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(0),
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X11_Y72_N0
\Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (\U1|instruction\(3) & (\U1|instruction\(22) & (\U1|instruction\(0) $ (\U1|instruction\(13))))) # (!\U1|instruction\(3) & ((\U1|instruction\(0) & ((\U1|instruction\(13)))) # (!\U1|instruction\(0) & (\U1|instruction\(22)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010010010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(3),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(22),
	datad => \U1|instruction\(13),
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X17_Y72_N20
\Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (\U1|instruction\(22) & (!\U1|instruction\(3) & ((\U1|instruction\(13)) # (!\U1|instruction\(0))))) # (!\U1|instruction\(22) & (!\U1|instruction\(0) & (\U1|instruction\(13) & \U1|instruction\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(3),
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X17_Y72_N22
\Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(22) & (\U1|instruction\(0))) # (!\U1|instruction\(22) & (!\U1|instruction\(0) & !\U1|instruction\(3))))) # (!\U1|instruction\(13) & (\U1|instruction\(3) & (\U1|instruction\(22) $ 
-- (\U1|instruction\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000011010010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(3),
	combout => \Mux3~0_combout\);

-- Location: LCCOMB_X17_Y72_N0
\Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = (\U1|instruction\(13) & (((\U1|instruction\(0) & \U1|instruction\(3))))) # (!\U1|instruction\(13) & ((\U1|instruction\(22) & ((\U1|instruction\(3)))) # (!\U1|instruction\(22) & (\U1|instruction\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(3),
	combout => \Mux2~0_combout\);

-- Location: LCCOMB_X17_Y72_N2
\Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(0) & (\U1|instruction\(13) $ (!\U1|instruction\(3))))) # (!\U1|instruction\(22) & (\U1|instruction\(3) & ((\U1|instruction\(0)) # (\U1|instruction\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(3),
	combout => \Mux1~0_combout\);

-- Location: LCCOMB_X11_Y72_N14
\Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (\U1|instruction\(0) & ((\U1|instruction\(22) $ (\U1|instruction\(13))) # (!\U1|instruction\(3)))) # (!\U1|instruction\(0) & ((\U1|instruction\(13)) # (\U1|instruction\(3) $ (!\U1|instruction\(22)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111100101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(3),
	datab => \U1|instruction\(0),
	datac => \U1|instruction\(22),
	datad => \U1|instruction\(13),
	combout => \Mux0~0_combout\);

-- Location: LCCOMB_X11_Y72_N4
\U1|instruction[12]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|instruction[12]~1_combout\ = !\U1|mem.raddr_a[0]~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U1|mem.raddr_a[0]~1_combout\,
	combout => \U1|instruction[12]~1_combout\);

-- Location: FF_X11_Y72_N5
\U1|instruction[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|instruction[12]~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(12));

-- Location: LCCOMB_X12_Y72_N24
\U1|instruction[10]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|instruction[10]~3_combout\ = !\U1|mem.raddr_a[2]~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|mem.raddr_a[2]~0_combout\,
	combout => \U1|instruction[10]~3_combout\);

-- Location: FF_X12_Y72_N25
\U1|instruction[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|instruction[10]~3_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(10));

-- Location: LCCOMB_X12_Y72_N26
\U1|instruction[11]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|instruction[11]~feeder_combout\ = \U1|mem.raddr_a[3]~3_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|mem.raddr_a[3]~3_combout\,
	combout => \U1|instruction[11]~feeder_combout\);

-- Location: FF_X12_Y72_N27
\U1|instruction[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|instruction[11]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(11));

-- Location: LCCOMB_X11_Y72_N30
\U1|instruction[21]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|instruction[21]~2_combout\ = !\U1|mem.raddr_a[1]~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U1|mem.raddr_a[1]~2_combout\,
	combout => \U1|instruction[21]~2_combout\);

-- Location: FF_X11_Y72_N31
\U1|instruction[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \U1|instruction[21]~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|instruction\(21));

-- Location: LCCOMB_X24_Y72_N0
\Mux13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux13~0_combout\ = (\U1|instruction\(10) & (!\U1|instruction\(12) & (\U1|instruction\(11) $ (\U1|instruction\(21))))) # (!\U1|instruction\(10) & (\U1|instruction\(21) & (\U1|instruction\(12) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001011001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux13~0_combout\);

-- Location: LCCOMB_X24_Y72_N2
\Mux12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux12~0_combout\ = (\U1|instruction\(11) & ((\U1|instruction\(12) & (!\U1|instruction\(10))) # (!\U1|instruction\(12) & ((!\U1|instruction\(21)))))) # (!\U1|instruction\(11) & (!\U1|instruction\(10) & (\U1|instruction\(12) $ (\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000101110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux12~0_combout\);

-- Location: LCCOMB_X24_Y72_N8
\Mux11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux11~0_combout\ = (\U1|instruction\(10) & (\U1|instruction\(12) & (!\U1|instruction\(11) & !\U1|instruction\(21)))) # (!\U1|instruction\(10) & (\U1|instruction\(11) & ((\U1|instruction\(12)) # (!\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux11~0_combout\);

-- Location: LCCOMB_X24_Y72_N10
\Mux10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux10~0_combout\ = (\U1|instruction\(21) & (!\U1|instruction\(11) & (\U1|instruction\(12) $ (\U1|instruction\(10))))) # (!\U1|instruction\(21) & ((\U1|instruction\(12) & (\U1|instruction\(10) & \U1|instruction\(11))) # (!\U1|instruction\(12) & 
-- (!\U1|instruction\(10)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011010010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux10~0_combout\);

-- Location: LCCOMB_X24_Y72_N24
\Mux9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux9~0_combout\ = (\U1|instruction\(21) & ((\U1|instruction\(10) & (!\U1|instruction\(12))) # (!\U1|instruction\(10) & ((!\U1|instruction\(11)))))) # (!\U1|instruction\(21) & (!\U1|instruction\(12) & ((!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100011100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux9~0_combout\);

-- Location: LCCOMB_X24_Y72_N6
\Mux8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux8~0_combout\ = (\U1|instruction\(12) & (\U1|instruction\(10) & (!\U1|instruction\(11) & !\U1|instruction\(21)))) # (!\U1|instruction\(12) & (\U1|instruction\(11) $ (((\U1|instruction\(10)) # (!\U1|instruction\(21))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010000001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux8~0_combout\);

-- Location: LCCOMB_X24_Y72_N28
\Mux7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = (\U1|instruction\(12) & ((\U1|instruction\(10) $ (!\U1|instruction\(11))) # (!\U1|instruction\(21)))) # (!\U1|instruction\(12) & ((\U1|instruction\(11)) # (\U1|instruction\(10) $ (\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux7~0_combout\);

-- Location: LCCOMB_X5_Y72_N24
\Mux20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux20~0_combout\ = (\U1|instruction\(10) & (\U1|instruction\(0) & (\U1|instruction\(21) $ (\U1|instruction\(11))))) # (!\U1|instruction\(10) & (\U1|instruction\(21) & (\U1|instruction\(0) $ (!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux20~0_combout\);

-- Location: LCCOMB_X5_Y72_N30
\Mux19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux19~0_combout\ = (\U1|instruction\(21) & (!\U1|instruction\(10) & (\U1|instruction\(0) $ (\U1|instruction\(11))))) # (!\U1|instruction\(21) & ((\U1|instruction\(0) & ((\U1|instruction\(11)))) # (!\U1|instruction\(0) & (!\U1|instruction\(10)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001101100100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux19~0_combout\);

-- Location: LCCOMB_X5_Y72_N16
\Mux18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux18~0_combout\ = (\U1|instruction\(10) & (!\U1|instruction\(0) & (!\U1|instruction\(21) & !\U1|instruction\(11)))) # (!\U1|instruction\(10) & (\U1|instruction\(11) & ((!\U1|instruction\(21)) # (!\U1|instruction\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux18~0_combout\);

-- Location: LCCOMB_X5_Y72_N14
\Mux17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux17~0_combout\ = (\U1|instruction\(21) & (!\U1|instruction\(11) & (\U1|instruction\(0) $ (!\U1|instruction\(10))))) # (!\U1|instruction\(21) & ((\U1|instruction\(0) & (!\U1|instruction\(10))) # (!\U1|instruction\(0) & (\U1|instruction\(10) & 
-- \U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011010010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux17~0_combout\);

-- Location: LCCOMB_X5_Y72_N0
\Mux16~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux16~0_combout\ = (\U1|instruction\(21) & ((\U1|instruction\(10) & (\U1|instruction\(0))) # (!\U1|instruction\(10) & ((!\U1|instruction\(11)))))) # (!\U1|instruction\(21) & (\U1|instruction\(0) & ((!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux16~0_combout\);

-- Location: LCCOMB_X5_Y72_N18
\Mux15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux15~0_combout\ = (\U1|instruction\(0) & (\U1|instruction\(11) $ (((\U1|instruction\(10)) # (!\U1|instruction\(21)))))) # (!\U1|instruction\(0) & (\U1|instruction\(10) & (!\U1|instruction\(21) & !\U1|instruction\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux15~0_combout\);

-- Location: LCCOMB_X5_Y72_N12
\Mux14~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux14~0_combout\ = (\U1|instruction\(0) & ((\U1|instruction\(11)) # (\U1|instruction\(10) $ (\U1|instruction\(21))))) # (!\U1|instruction\(0) & ((\U1|instruction\(10) $ (!\U1|instruction\(11))) # (!\U1|instruction\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111100111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(0),
	datab => \U1|instruction\(10),
	datac => \U1|instruction\(21),
	datad => \U1|instruction\(11),
	combout => \Mux14~0_combout\);

-- Location: LCCOMB_X38_Y72_N28
\Mux27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux27~0_combout\ = (\U1|instruction\(10) & (!\U1|instruction\(12) & (\U1|instruction\(13) $ (!\U1|instruction\(11))))) # (!\U1|instruction\(10) & (!\U1|instruction\(13) & (\U1|instruction\(12) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100100010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux27~0_combout\);

-- Location: LCCOMB_X38_Y72_N26
\Mux26~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux26~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(12) & (!\U1|instruction\(10))) # (!\U1|instruction\(12) & ((\U1|instruction\(11)))))) # (!\U1|instruction\(13) & (!\U1|instruction\(10) & (\U1|instruction\(12) $ (!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110001000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux26~0_combout\);

-- Location: LCCOMB_X38_Y72_N20
\Mux25~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux25~0_combout\ = (\U1|instruction\(10) & (\U1|instruction\(13) & (\U1|instruction\(12) & !\U1|instruction\(11)))) # (!\U1|instruction\(10) & (\U1|instruction\(11) & ((\U1|instruction\(13)) # (\U1|instruction\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux25~0_combout\);

-- Location: LCCOMB_X38_Y72_N30
\Mux24~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux24~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(10) & (\U1|instruction\(12) & \U1|instruction\(11))) # (!\U1|instruction\(10) & (!\U1|instruction\(12))))) # (!\U1|instruction\(13) & (!\U1|instruction\(11) & (\U1|instruction\(10) $ 
-- (\U1|instruction\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux24~0_combout\);

-- Location: LCCOMB_X38_Y72_N24
\Mux23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux23~0_combout\ = (\U1|instruction\(13) & (((!\U1|instruction\(12) & !\U1|instruction\(11))))) # (!\U1|instruction\(13) & ((\U1|instruction\(10) & (!\U1|instruction\(12))) # (!\U1|instruction\(10) & ((!\U1|instruction\(11))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux23~0_combout\);

-- Location: LCCOMB_X38_Y72_N22
\Mux22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux22~0_combout\ = (\U1|instruction\(10) & (!\U1|instruction\(11) & ((\U1|instruction\(13)) # (!\U1|instruction\(12))))) # (!\U1|instruction\(10) & (!\U1|instruction\(12) & (\U1|instruction\(13) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000110001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux22~0_combout\);

-- Location: LCCOMB_X38_Y72_N0
\Mux21~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux21~0_combout\ = (\U1|instruction\(12) & ((\U1|instruction\(13)) # (\U1|instruction\(10) $ (!\U1|instruction\(11))))) # (!\U1|instruction\(12) & ((\U1|instruction\(11)) # (\U1|instruction\(10) $ (!\U1|instruction\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111011001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(12),
	datad => \U1|instruction\(11),
	combout => \Mux21~0_combout\);

-- Location: LCCOMB_X38_Y72_N18
\Mux34~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux34~0_combout\ = (\U1|instruction\(10) & (\U1|instruction\(0) & (\U1|instruction\(13) $ (!\U1|instruction\(11))))) # (!\U1|instruction\(10) & (!\U1|instruction\(13) & (\U1|instruction\(0) $ (!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux34~0_combout\);

-- Location: LCCOMB_X38_Y72_N16
\Mux33~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux33~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(0) & ((\U1|instruction\(11)))) # (!\U1|instruction\(0) & (!\U1|instruction\(10))))) # (!\U1|instruction\(13) & (!\U1|instruction\(10) & (\U1|instruction\(0) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010100010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux33~0_combout\);

-- Location: LCCOMB_X38_Y72_N14
\Mux32~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux32~0_combout\ = (\U1|instruction\(10) & (\U1|instruction\(13) & (!\U1|instruction\(0) & !\U1|instruction\(11)))) # (!\U1|instruction\(10) & (\U1|instruction\(11) & ((\U1|instruction\(13)) # (!\U1|instruction\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux32~0_combout\);

-- Location: LCCOMB_X38_Y72_N12
\Mux31~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux31~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(10) & (!\U1|instruction\(0) & \U1|instruction\(11))) # (!\U1|instruction\(10) & (\U1|instruction\(0))))) # (!\U1|instruction\(13) & (!\U1|instruction\(11) & (\U1|instruction\(10) $ 
-- (!\U1|instruction\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100001100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux31~0_combout\);

-- Location: LCCOMB_X38_Y72_N10
\Mux30~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux30~0_combout\ = (\U1|instruction\(13) & (((\U1|instruction\(0) & !\U1|instruction\(11))))) # (!\U1|instruction\(13) & ((\U1|instruction\(10) & (\U1|instruction\(0))) # (!\U1|instruction\(10) & ((!\U1|instruction\(11))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000011110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux30~0_combout\);

-- Location: LCCOMB_X38_Y72_N8
\Mux29~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux29~0_combout\ = (\U1|instruction\(10) & (!\U1|instruction\(11) & ((\U1|instruction\(13)) # (\U1|instruction\(0))))) # (!\U1|instruction\(10) & (\U1|instruction\(0) & (\U1|instruction\(13) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux29~0_combout\);

-- Location: LCCOMB_X38_Y72_N2
\Mux28~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux28~0_combout\ = (\U1|instruction\(0) & ((\U1|instruction\(11)) # (\U1|instruction\(10) $ (!\U1|instruction\(13))))) # (!\U1|instruction\(0) & ((\U1|instruction\(13)) # (\U1|instruction\(10) $ (!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111010011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(10),
	datab => \U1|instruction\(13),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux28~0_combout\);

-- Location: LCCOMB_X24_Y72_N30
\Mux41~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux41~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(21) & (\U1|instruction\(12) $ (\U1|instruction\(11))))) # (!\U1|instruction\(22) & (!\U1|instruction\(12) & (\U1|instruction\(11) $ (\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux41~0_combout\);

-- Location: LCCOMB_X24_Y72_N16
\Mux40~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux40~0_combout\ = (\U1|instruction\(11) & ((\U1|instruction\(12) & (\U1|instruction\(22))) # (!\U1|instruction\(12) & ((!\U1|instruction\(21)))))) # (!\U1|instruction\(11) & (\U1|instruction\(22) & (\U1|instruction\(12) $ (\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux40~0_combout\);

-- Location: LCCOMB_X24_Y72_N18
\Mux39~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux39~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(11) & ((\U1|instruction\(12)) # (!\U1|instruction\(21))))) # (!\U1|instruction\(22) & (\U1|instruction\(12) & (!\U1|instruction\(11) & !\U1|instruction\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux39~0_combout\);

-- Location: LCCOMB_X24_Y72_N20
\Mux38~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux38~0_combout\ = (\U1|instruction\(21) & (!\U1|instruction\(11) & (\U1|instruction\(12) $ (!\U1|instruction\(22))))) # (!\U1|instruction\(21) & ((\U1|instruction\(12) & (!\U1|instruction\(22) & \U1|instruction\(11))) # (!\U1|instruction\(12) & 
-- (\U1|instruction\(22)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100101100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux38~0_combout\);

-- Location: LCCOMB_X24_Y72_N26
\Mux37~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux37~0_combout\ = (\U1|instruction\(21) & ((\U1|instruction\(22) & ((!\U1|instruction\(11)))) # (!\U1|instruction\(22) & (!\U1|instruction\(12))))) # (!\U1|instruction\(21) & (!\U1|instruction\(12) & ((!\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001110100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux37~0_combout\);

-- Location: LCCOMB_X24_Y72_N12
\Mux36~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux36~0_combout\ = (\U1|instruction\(12) & (!\U1|instruction\(22) & (!\U1|instruction\(11) & !\U1|instruction\(21)))) # (!\U1|instruction\(12) & (\U1|instruction\(11) $ (((!\U1|instruction\(21)) # (!\U1|instruction\(22))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux36~0_combout\);

-- Location: LCCOMB_X24_Y72_N14
\Mux35~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux35~0_combout\ = (\U1|instruction\(12) & ((\U1|instruction\(22) $ (\U1|instruction\(11))) # (!\U1|instruction\(21)))) # (!\U1|instruction\(12) & ((\U1|instruction\(11)) # (\U1|instruction\(22) $ (!\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111110011111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(12),
	datab => \U1|instruction\(22),
	datac => \U1|instruction\(11),
	datad => \U1|instruction\(21),
	combout => \Mux35~0_combout\);

-- Location: LCCOMB_X5_Y72_N6
\Mux48~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux48~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(21) & (\U1|instruction\(0) $ (!\U1|instruction\(11))))) # (!\U1|instruction\(22) & (\U1|instruction\(0) & (\U1|instruction\(21) $ (\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux48~0_combout\);

-- Location: LCCOMB_X5_Y72_N20
\Mux47~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux47~0_combout\ = (\U1|instruction\(21) & (\U1|instruction\(22) & (\U1|instruction\(0) $ (\U1|instruction\(11))))) # (!\U1|instruction\(21) & ((\U1|instruction\(0) & ((\U1|instruction\(11)))) # (!\U1|instruction\(0) & (\U1|instruction\(22)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101010000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux47~0_combout\);

-- Location: LCCOMB_X5_Y72_N22
\Mux46~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux46~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(11) & ((!\U1|instruction\(0)) # (!\U1|instruction\(21))))) # (!\U1|instruction\(22) & (!\U1|instruction\(21) & (!\U1|instruction\(0) & !\U1|instruction\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux46~0_combout\);

-- Location: LCCOMB_X5_Y72_N28
\Mux45~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux45~0_combout\ = (\U1|instruction\(21) & (!\U1|instruction\(11) & (\U1|instruction\(22) $ (\U1|instruction\(0))))) # (!\U1|instruction\(21) & ((\U1|instruction\(22) & (\U1|instruction\(0))) # (!\U1|instruction\(22) & (!\U1|instruction\(0) & 
-- \U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000101101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux45~0_combout\);

-- Location: LCCOMB_X5_Y72_N10
\Mux44~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux44~0_combout\ = (\U1|instruction\(21) & ((\U1|instruction\(22) & ((!\U1|instruction\(11)))) # (!\U1|instruction\(22) & (\U1|instruction\(0))))) # (!\U1|instruction\(21) & (((\U1|instruction\(0) & !\U1|instruction\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux44~0_combout\);

-- Location: LCCOMB_X5_Y72_N4
\Mux43~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux43~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(0) & (\U1|instruction\(21) $ (!\U1|instruction\(11))))) # (!\U1|instruction\(22) & (!\U1|instruction\(11) & ((\U1|instruction\(0)) # (!\U1|instruction\(21)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000001110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux43~0_combout\);

-- Location: LCCOMB_X5_Y72_N2
\Mux42~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux42~0_combout\ = (\U1|instruction\(0) & ((\U1|instruction\(11)) # (\U1|instruction\(22) $ (!\U1|instruction\(21))))) # (!\U1|instruction\(0) & ((\U1|instruction\(22) $ (\U1|instruction\(11))) # (!\U1|instruction\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011110011011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(21),
	datac => \U1|instruction\(0),
	datad => \U1|instruction\(11),
	combout => \Mux42~0_combout\);

-- Location: LCCOMB_X17_Y72_N24
\Mux55~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux55~0_combout\ = (\U1|instruction\(22) & (!\U1|instruction\(13) & (\U1|instruction\(11) $ (\U1|instruction\(12))))) # (!\U1|instruction\(22) & (!\U1|instruction\(12) & (\U1|instruction\(11) $ (!\U1|instruction\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001001001001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux55~0_combout\);

-- Location: LCCOMB_X17_Y72_N14
\Mux54~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux54~0_combout\ = (\U1|instruction\(11) & ((\U1|instruction\(12) & (\U1|instruction\(22))) # (!\U1|instruction\(12) & ((\U1|instruction\(13)))))) # (!\U1|instruction\(11) & (\U1|instruction\(22) & (\U1|instruction\(13) $ (!\U1|instruction\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux54~0_combout\);

-- Location: LCCOMB_X17_Y72_N8
\Mux53~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux53~0_combout\ = (\U1|instruction\(22) & (\U1|instruction\(11) & ((\U1|instruction\(13)) # (\U1|instruction\(12))))) # (!\U1|instruction\(22) & (!\U1|instruction\(11) & (\U1|instruction\(13) & \U1|instruction\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux53~0_combout\);

-- Location: LCCOMB_X17_Y72_N18
\Mux52~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux52~0_combout\ = (\U1|instruction\(13) & ((\U1|instruction\(22) & ((!\U1|instruction\(12)))) # (!\U1|instruction\(22) & (\U1|instruction\(11) & \U1|instruction\(12))))) # (!\U1|instruction\(13) & (!\U1|instruction\(11) & (\U1|instruction\(22) $ 
-- (!\U1|instruction\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100001010100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux52~0_combout\);

-- Location: LCCOMB_X17_Y72_N28
\Mux51~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux51~0_combout\ = (\U1|instruction\(13) & (((!\U1|instruction\(11) & !\U1|instruction\(12))))) # (!\U1|instruction\(13) & ((\U1|instruction\(22) & (!\U1|instruction\(11))) # (!\U1|instruction\(22) & ((!\U1|instruction\(12))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux51~0_combout\);

-- Location: LCCOMB_X17_Y72_N10
\Mux50~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux50~0_combout\ = (\U1|instruction\(22) & (!\U1|instruction\(12) & (\U1|instruction\(11) $ (\U1|instruction\(13))))) # (!\U1|instruction\(22) & (!\U1|instruction\(11) & ((\U1|instruction\(13)) # (!\U1|instruction\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000111001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux50~0_combout\);

-- Location: LCCOMB_X17_Y72_N12
\Mux49~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux49~0_combout\ = (\U1|instruction\(12) & ((\U1|instruction\(13)) # (\U1|instruction\(22) $ (\U1|instruction\(11))))) # (!\U1|instruction\(12) & ((\U1|instruction\(11)) # (\U1|instruction\(22) $ (\U1|instruction\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011011011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|instruction\(22),
	datab => \U1|instruction\(11),
	datac => \U1|instruction\(13),
	datad => \U1|instruction\(12),
	combout => \Mux49~0_combout\);

ww_leds(0) <= \leds[0]~output_o\;

ww_leds(1) <= \leds[1]~output_o\;

ww_leds(2) <= \leds[2]~output_o\;

ww_leds(3) <= \leds[3]~output_o\;

ww_hex0(0) <= \hex0[0]~output_o\;

ww_hex0(1) <= \hex0[1]~output_o\;

ww_hex0(2) <= \hex0[2]~output_o\;

ww_hex0(3) <= \hex0[3]~output_o\;

ww_hex0(4) <= \hex0[4]~output_o\;

ww_hex0(5) <= \hex0[5]~output_o\;

ww_hex0(6) <= \hex0[6]~output_o\;

ww_hex1(0) <= \hex1[0]~output_o\;

ww_hex1(1) <= \hex1[1]~output_o\;

ww_hex1(2) <= \hex1[2]~output_o\;

ww_hex1(3) <= \hex1[3]~output_o\;

ww_hex1(4) <= \hex1[4]~output_o\;

ww_hex1(5) <= \hex1[5]~output_o\;

ww_hex1(6) <= \hex1[6]~output_o\;

ww_hex2(0) <= \hex2[0]~output_o\;

ww_hex2(1) <= \hex2[1]~output_o\;

ww_hex2(2) <= \hex2[2]~output_o\;

ww_hex2(3) <= \hex2[3]~output_o\;

ww_hex2(4) <= \hex2[4]~output_o\;

ww_hex2(5) <= \hex2[5]~output_o\;

ww_hex2(6) <= \hex2[6]~output_o\;

ww_hex3(0) <= \hex3[0]~output_o\;

ww_hex3(1) <= \hex3[1]~output_o\;

ww_hex3(2) <= \hex3[2]~output_o\;

ww_hex3(3) <= \hex3[3]~output_o\;

ww_hex3(4) <= \hex3[4]~output_o\;

ww_hex3(5) <= \hex3[5]~output_o\;

ww_hex3(6) <= \hex3[6]~output_o\;

ww_hex4(0) <= \hex4[0]~output_o\;

ww_hex4(1) <= \hex4[1]~output_o\;

ww_hex4(2) <= \hex4[2]~output_o\;

ww_hex4(3) <= \hex4[3]~output_o\;

ww_hex4(4) <= \hex4[4]~output_o\;

ww_hex4(5) <= \hex4[5]~output_o\;

ww_hex4(6) <= \hex4[6]~output_o\;

ww_hex5(0) <= \hex5[0]~output_o\;

ww_hex5(1) <= \hex5[1]~output_o\;

ww_hex5(2) <= \hex5[2]~output_o\;

ww_hex5(3) <= \hex5[3]~output_o\;

ww_hex5(4) <= \hex5[4]~output_o\;

ww_hex5(5) <= \hex5[5]~output_o\;

ww_hex5(6) <= \hex5[6]~output_o\;

ww_hex6(0) <= \hex6[0]~output_o\;

ww_hex6(1) <= \hex6[1]~output_o\;

ww_hex6(2) <= \hex6[2]~output_o\;

ww_hex6(3) <= \hex6[3]~output_o\;

ww_hex6(4) <= \hex6[4]~output_o\;

ww_hex6(5) <= \hex6[5]~output_o\;

ww_hex6(6) <= \hex6[6]~output_o\;

ww_hex7(0) <= \hex7[0]~output_o\;

ww_hex7(1) <= \hex7[1]~output_o\;

ww_hex7(2) <= \hex7[2]~output_o\;

ww_hex7(3) <= \hex7[3]~output_o\;

ww_hex7(4) <= \hex7[4]~output_o\;

ww_hex7(5) <= \hex7[5]~output_o\;

ww_hex7(6) <= \hex7[6]~output_o\;
END structure;


