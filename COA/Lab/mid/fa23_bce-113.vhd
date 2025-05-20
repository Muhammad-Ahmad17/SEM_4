library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity mid is
	port(
		sw  : in std_logic_vector(2 downto 0);
		clk : in std_logic;
		ledout : out std_logic_vector(3 downto 0)
	);

end mid;

architecture bhv of mid is
-- signal
	signal count   : std_logic_vector(31 downto 0) := X"00000000"; -- for clk partition
	signal clk_0 , clk_1 , clk_2 , clk_3  : std_logic;
	--signal ledout  : std_logic_vector(3 downto 0) := "0000";   

begin

--
-- clk distribution
process (clk)
	begin
	if rising_edge (clk) then 
		count <= count + '1';
		clk_0 <= count(20);
		clk_1 <= count(25);
		clk_2 <= count(15);
		clk_3 <= count(20); -- 2 sec
	end if;
end process;



--switch :	210
------------
--mode_1 : 000
--mode_2 : 001
--mode_3 : 010
--mode_4 : 100




-- mode 0;

process (clk_0)
	begin
	if sw = "001" then
		if rising_edge (clk_0) then 
			ledout <= not ledout;
		end if;
	end if;
end process;


-- mode 1;

process (clk_1)
	begin
	if sw = "001" then 
		ledout <= "0001";                           -- first set first led on 
		ledout <= ledout(3 downto 1) & ledout(0);   -- shift left logical for blinking in seq.
	end if;
end process;


-- mode 2;

process (clk_2)
	begin
	if sw = "010" then 
		if rising_edge (clk_2) then 
			ledout <= "1010" ;
		else 
			ledout <= "0101" ;
		end if;
	end if;
		
end process;

-- mode 3;

process (clk_3) -- 2 sec ka estimate clk set karna ha
	begin
	if sw = "001" then
		if rising_edge (clk_3) then 
			ledout <= not ledout;
		end if;
	end if;
end process;


end bhv;



