library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ledBlinking is 
	port(
		fpga_clk : in std_logic;
		switch   : in std_logic_vector(2 downto 0);
		led      : out std_logic_vector(3 downto 0)
	);
end ledBlinking;

architecture bhv of ledBlinking is 
	--signals
	signal count    : std_logic_vector(31 downto 0) := X"00000000";
	signal top_clk  : std_logic;
	signal ledout	 : std_logic_vector(3 downto 0);
	 
begin 
	---
	process (fpga_clk)
	begin
		if (fpga_clk 'event and fpga_clk = '1') then
		count <= count + 1;
		end if;
	end process;
	---
	process (fpga_clk , count)
	begin 
		if (fpga_clk 'event and fpga_clk = '1') then 
			case switch is 
				when "000" => top_clk <= count(20);
				when "100" => top_clk <= count(31);
				when "010" => top_clk <= count(15);
				when "001" => top_clk <= count(2);
				when others => top_clk <= count(2);
			end case;
		end if;
	end process;
	---	
	process(top_clk)
	begin
		if (top_clk 'event and top_clk = '1') then 
			ledout <= not ledout;
		end if;
	end process;
	---
	led <= ledout;
end bhv;