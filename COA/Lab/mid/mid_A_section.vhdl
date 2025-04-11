/*Design a digital system that:
•	Rotates a single active digit across a 2 digit seven segment display
•	Counts up using 8 leds
•	switch the system off using a push button

Seven Segment display rotation:
Only one digit is active at a time.The active digit rotates from right to left across 2 digit ssd(like moving cursor or light).the active digit shows the digit 0 just for visibility.the rotation speed should bu moderate and clearly visible.

LED count up:
8 leds represent 8 bit counter. The led counts up from 0 to 255,incrementing once a second.Once it reaches 255(11111111),it wraps around to 0.

Button Control:
When the button is pressed,the system freezes, 
SSD stops rotating and led count freezes.*/



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity mid is 
	port (
		clk : in std_logic ;  -- fpga's clk
		button : in std_logic ; -- for on off
		reset : in std_logic; -- reset 
		led : out std_logic_vector(7 downto 0); -- led 
		ssd_0 : out std_logic_vector(6 downto 0);
		ssd_1 : out std_logic_vector(6 downto 0)	
	);

end mid; 



architecture bhv of mid is 

-- signals
	signal led_clk : std_logic ;  -- led_clk
	signal ssd_clk : std_logic ;  -- std_clk
	signal count   : std_logic_vector(31 downto 0) := X"00000000"; -- for clk partition
	signal ledout  : std_logic_vector(7 downto 0) := "00000000";   -- 8-bit counter
	signal active_digit : std_logic := '0'; -- active digit
	signal toggle  : std_logic := '0'; -- toggel , working at '0'
	signal button_prev, button_curr : std_logic := '0'; -- Button edge detection


begin

	
-- deriving clk

	process (clk)
	begin
		if rising_edge(clk) then 
			count <= count + 1;
			led_clk <= count(10);  -- fast  
			ssd_clk <= count(22);	 -- slow
		end if;	
	end process;

	
-- led_clk
	process(led_clk,reset)
	begin
		if reset = '1' then        -- reset 
			ledout <= "00000000";
		else
			if toggle = '0' then    -- increment the led
				ledout <= ledout + '1';
			end if;
		end if;
	end process;
	
	
-- ssd_clk
	process(ssd_clk,reset)
	begin
		if reset = '1' then        -- reset 
			active_digit <= '0';
		else
			if toggle = '0' then    -- increment the led
				active_digit <= not active_digit; -- toggling 0 and 1 
			end if;
		end if;

	end process;
	
-- ssd signal maping
	process(active_digit)
	begin
			if active_digit = '0' then 
				ssd_0 <= "0000000";
				ssd_1 <= "1111111";
			else
				ssd_0 <= "1111111";
				ssd_1 <= "0000000";
			end if;
	end process;
	
-- led signal maping
	 led <= ledout;
	
-- button
	process(button)
	begin 
		button_prev <= button_curr;
		button_curr <= button;
		
		if (button_curr = '1' AND button_prev = '0') then 
			toggle <= not toggle;
		end if;
	end process;

end bhv;