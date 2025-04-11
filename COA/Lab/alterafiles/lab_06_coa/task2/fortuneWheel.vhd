--------------SEVEN SEGMENT DISPLAY
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_compo.all;

entity fortuneWheel is 
	port (
        fpga_clk    : in  std_logic;								-- clk
		  reset  : in std_logic;									-- reset
        start_sw : in  std_logic;									-- start
		  led    : out std_logic_vector(7 downto 0);				-- led
        ssd0, ssd1, ssd2, ssd3 : out std_logic_vector(6 downto 0)	-- ssd
    );
end fortuneWheel;

architecture bhv of fortuneWheel is 
	--signals
   signal sclk, fclk : std_logic;
	signal ledout  : std_logic_vector(7 downto 0) := "00000001"; -- 8-B number to blink on led
	signal ssdout  : std_logic_vector(6 downto 0) := "0000000";
	signal count   : std_logic_vector(31 downto 0) := X"00000000"; -- for clk distribution 
   signal input   : std_logic_vector(15 downto 0) := X"0000";  -- 16-B number to display on ssd 
		
begin 




	-- fpga default clk ko hum nay 
	-- 		: fclk 
	--		: sclk
	-- me derive kar lia jis ko hum agy use kary gay
	---
	process (fpga_clk,start_sw)
	begin
		if (rising_edge(fpga_clk) and start_sw = '1') then 
		count <= count + 1;
		end if;
		
		fclk <= count(8);
		sclk <= count(22);
	end process;
	--- 
	
	
	
	
	
	--Slow Clock
    process (sclk,reset) is
    begin
			if reset = '1' then 
				ledout <=  "00000001";
			else
            ledout <= ledout(6 downto 0) & ledout(7);   --rotate
        end if;
    end process;
	---



	
	---Fast Counter
    process (fclk,reset)
    begin
			if reset='1' then 
				input <= "0000000000000000"; -- X:0000
        else
            input <= input + 1;		--increment
        end if;
    end process;
	 ---
	 
	 
	 
	 ----
	 
-- ledout signal led port par map kr di
process(input)
begin
    seven_seg(input(15 downto 12), ssd3);
    seven_seg(input(11 downto 8), ssd2);
    seven_seg(input(7 downto 4), ssd1);
    seven_seg(input(3 downto 0), ssd0);
end process;
	----
	
	
	-- ledout signal led port par map kr di
	led <= ledout;
end bhv;