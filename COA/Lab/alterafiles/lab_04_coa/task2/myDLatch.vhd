LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY myDLatch is port (
	clk   : in std_logic;
	D     : in std_logic;
	Q     : out std_logic;
	Q_not : out std_logic
);

end myDLatch;

architecture bhv of myDLatch is 
begin
	process (clk)
		begin 
			if clk = '1' then 
			Q <= D;
			Q_not <= not D ;
			end if;
	end process;
end bhv;