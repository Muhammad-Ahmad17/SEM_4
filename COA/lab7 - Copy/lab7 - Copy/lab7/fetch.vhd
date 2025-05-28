LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity fetch is
    port ( 
				PC_OUT      											 : OUT STD_LOGIC_VECTOR(31 downto 0);
				instruction 											 : OUT STD_LOGIC_VECTOR(31 downto 0);
				branch_addr, jump_addr 								 : in std_logic_vector(31 downto 0);
				branch_decision, jump_decision, reset , clock   : in std_logic
         );
    END fetch;

architecture bhv of fetch is
 type mem_array is array(0 to 16) of std_logic_vector(31 downto 0);
begin
   process (clock, reset)	 
    variable mem : mem_array := (
      
    );										
				variable PC : std_logic_vector(31 downto 0);
				variable index: integer := 0;
				begin
					if reset ='1' then
						PC := X"00000000";
						instruction <= X"00000000";
						
					else	
						if (clock'event and clock ='1') then
							if (branch_decision='1') then
								PC := branch_addr;
								
							elsif ( jump_decision='1') then
								PC := jump_addr;
								
							end if;
								index := to_integer(unsigned(PC(3 downto 0)));
								PC := PC + X"1";
								PC_out <= PC;
								instruction <= mem(index);
							
						end if;
					end if;
				end process;
				
    end bhv;
