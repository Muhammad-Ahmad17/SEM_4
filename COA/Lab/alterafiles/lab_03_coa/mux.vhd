library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxx is
    port(
        D0,D1,D2,D3 : in STD_LOGIC;
		  S: in STD_LOGIC_VECTOR(1 downto 0);
        X : out STD_LOGIC
    );
end muxx;

architecture bhv of muxx is
begin
	X <= D0 WHEN S = "00" ELSE
		  D1 WHEN S = "01" ELSE
		  D2 WHEN S = "10" ELSE
		  D3;
end bhv;
