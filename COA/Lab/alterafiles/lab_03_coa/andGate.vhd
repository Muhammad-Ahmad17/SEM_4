library ieee;
use ieee.std_logic_1164.all;

entity andGate is 
	port (
		A,B : in std_logic; 
		X : out std_logic	
	);
end andGate;

architecture bhv of andGate is 
begin 
	X <= A AND B ;
end bhv;