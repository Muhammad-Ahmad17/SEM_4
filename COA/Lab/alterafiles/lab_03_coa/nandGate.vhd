library ieee;
use ieee.std_logic_1164.all;

entity nandGate is 
	port (
		A,B : in std_logic; 
		X : out std_logic	
	);
end nandGate;

architecture bhv of nandGate is 
begin 
	X <= NOT ( A AND B );
end bhv;