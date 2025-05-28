library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned;

entity decode is port(
	instruction : in std_logic_vector(31 downto 0);
	memory_data : in std_logic_vector(31 downto 0);
	Alu_result : in std_logic_vector(31 downto 0);
	reset : in std_logic;
	clock : in std_logic;
	RegDst : in std_logic;
	RegWrite : in std_logic;
	MemToReg  : in std_logic;
	register_rs : out std_logic_vector(31 downto 0);
	register_rt : out std_logic_vector(31 downto 0);
	register_rd : out std_logic_vector(31 downto 0);
	jump_addr : out std_logic_vector(31 downto 0);
	immediate : out std_logic_vector(31 downto 0)
);
end decode;

architecture behavioral of decode is 
type reg_array is array(0 to 15) of std_logic_vector(31 downto 0);
shared variable RegFile : reg_array := (
	X"00000000", X"11111111", X"22222222",X"33333333",X"44444444",
	others => X"01010101");
begin
reg_write: process (clock, reset)
		variable write_value : std_logic_vector (31 downto 0);
		variable rd,rtype,itype : std_logic_vector (4 downto 0);
		variable index : integer range 0 to 31;
	begin
			if reset ='1' then
			RegFile := (
			X"00000000", X"11111111", X"22222222",X"33333333",X"44444444",			
			others => X"01010101");
			
			elsif(rising_edge(clock)) then
				itype := instruction(20 downto 16);
				rtype := instruction(15 downto 11);
				if RegDst = '0' then
					rd := itype;
				else 
					rd := rtype;
				end if;				
				if MemToReg ='0' then
					write_value := memory_data;
				else
					write_value	:= alu_result;
				end if;
				if regWrite ='1' then
					index :=to_integer(unsigned(rd));
			
				RegFile(index) :=write_value;
			end if;
		end if;
end process reg_write;
	
reg_read : process(instruction)
variable index_rs,index_rt,index_rd : integer range 0 to 31;

begin

	index_rs := to_integer(unsigned ( instruction (25 downto 21)));
	index_rt := to_integer(unsigned ( instruction (20 downto 16)));
	index_rd := to_integer(unsigned ( instruction (15 downto 11)));
	
	
	register_rs <= RegFile(index_rs);
	register_rt <= RegFile(index_rt);
	register_rd <= RegFile(index_rd);
	
	
	immediate(15 downto 0) <= instruction(15 downto 0);
	if instruction(15) = '1' then
		immediate(31 downto 16) <= x"ffff";
	else
		immediate(31 downto 16) <= x"0000";
	end if;
	jump_addr(31 downto 0) <="000000" & instruction(25 downto 0); 
	
end process reg_read;
end behavioral;