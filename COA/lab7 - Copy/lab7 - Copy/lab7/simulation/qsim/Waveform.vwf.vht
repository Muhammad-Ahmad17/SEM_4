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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/08/2025 10:30:08"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Wrapper
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Wrapper_vhd_vec_tst IS
END Wrapper_vhd_vec_tst;
ARCHITECTURE Wrapper_arch OF Wrapper_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL branch_decision : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL hex0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex6 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL jump_decision : STD_LOGIC;
SIGNAL leds : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
COMPONENT Wrapper
	PORT (
	branch_decision : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	jump_decision : IN STD_LOGIC;
	leds : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Wrapper
	PORT MAP (
-- list connections between master ports and signals
	branch_decision => branch_decision,
	clk => clk,
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2,
	hex3 => hex3,
	hex4 => hex4,
	hex5 => hex5,
	hex6 => hex6,
	hex7 => hex7,
	jump_decision => jump_decision,
	leds => leds,
	reset => reset
	);

-- branch_decision
t_prcs_branch_decision: PROCESS
BEGIN
	branch_decision <= '0';
WAIT;
END PROCESS t_prcs_branch_decision;

-- clk
t_prcs_clk: PROCESS
BEGIN
	clk <= '1';
WAIT;
END PROCESS t_prcs_clk;

-- jump_decision
t_prcs_jump_decision: PROCESS
BEGIN
	jump_decision <= '0';
WAIT;
END PROCESS t_prcs_jump_decision;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '0';
WAIT;
END PROCESS t_prcs_reset;
END Wrapper_arch;
