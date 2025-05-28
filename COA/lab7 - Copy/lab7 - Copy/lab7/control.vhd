library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned;

entity control is port(
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
end control;
architecture behv of control is 
begin
	process(instruction,reset)
		variable rformat,lw,sw,beq,jmp,addi : std_logic;
		variable opcode : std_logic_vector(5 downto 0);
	begin
		opcode (5 downto 0) := instruction (31 downto 26);
		if reset = '1' then			
				RegDst <= '0';
				ALUSrc <= '0';
				MemToReg <= '0';
				RegWrite <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				ALUOP <= "00";
				jump <= '0';
				beq_control <= '0';
		else
	case opcode is
         when "000000" => -- R-type
             RegDst <= '1';
             RegWrite <= '1';
             MemtoReg <= '0';
             ALUOp <= "10";
             ALUSrc <= '0';
             beq_control <= '0';
             MemRead <= '0';
             MemWrite <= '0';            
         when "100011" => -- lw
             RegDst <= '0';
             ALUSrc <= '1';
             MemtoReg <= '1';
             RegWrite <= '1';
             MemRead <= '1';
             MemWrite <= '0';
             beq_control <= '0';
             ALUOp <= "00";				 
         when "101011" => -- sw
             RegDst <= '0'; 
             ALUSrc <= '1';
             MemtoReg <= '0';
             RegWrite <= '0';
             MemRead <= '0';
             MemWrite <= '1';
             beq_control <= '0';
             ALUOp <= "00";
         when "000100" => -- beq
             RegDst <= '0'; 
             ALUSrc <= '0';
             MemtoReg <= '0'; 
             RegWrite <= '0';
             MemRead <= '0';
             MemWrite <= '0';
             beq_control <= '1';
             ALUOp <= "01";
			when others => 
             RegDst <= '0';
             ALUSrc <= '0';
             MemtoReg <= '0';
             RegWrite <= '0';
             MemRead <= '0';
             MemWrite <= '0';
             beq_control <= '0';
             ALUOp <= "00";
        end case;
		end if;
	end process;
end behv;