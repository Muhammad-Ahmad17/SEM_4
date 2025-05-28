library ieee;
use ieee.std_logic_1164.all;

package my_components is
component fetch
        port (
            PC_out          : out std_logic_vector(31 downto 0);
            instruction     : out std_logic_vector(31 downto 0);
            branch_addr     : in std_logic_vector(31 downto 0);
            jump_addr       : in std_logic_vector(31 downto 0);
            branch_decision : in std_logic;
            jump_decision   : in std_logic;
            reset           : in std_logic;
            clock           : in std_logic
        );
end component;

component SSD
        port (
            bininput : in std_logic_vector(3 downto 0);
            cathodes : out std_logic_vector(6 downto 0)
        );
end component;

component decode
        port (
            instruction  : in std_logic_vector(31 downto 0);
            memory_data  : in std_logic_vector(31 downto 0);
            Alu_result   : in std_logic_vector(31 downto 0);
            reset        : in std_logic;
            clock        : in std_logic;
            RegDst       : in std_logic;
            RegWrite     : in std_logic;
            MemToReg     : in std_logic;
            register_rs  : out std_logic_vector(31 downto 0);
            register_rt  : out std_logic_vector(31 downto 0);
            register_rd  : out std_logic_vector(31 downto 0);
            jump_addr    : out std_logic_vector(31 downto 0);
            immediate    : out std_logic_vector(31 downto 0)
        );
end component;

component control
	port(
	pc: out std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	reset : in std_logic;
	jump: out std_logic;
	RegDst: out std_logic;
	RegWrite : out std_logic;
	MemToReg: out std_logic;
	ALUOp: out std_logic_vector(1 downto 0);
	ALUSrc: out std_logic;
	beq_control: out std_logic;
	MemRead: out std_logic;
	MemWrite: out std_logic
);
end component;

component memory 
	port (
    address    : in std_logic_vector(31 downto 0);
    write_data : in std_logic_vector(31 downto 0);
    MemWrite   : in std_logic;
    MemRead    : in std_logic;
    read_data  : out std_logic_vector(31 downto 0)
);
end component;
end my_components;

