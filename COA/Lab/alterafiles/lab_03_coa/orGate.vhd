library ieee;
use ieee.std_logic_1164.all;

entity orGate is 
	port (
		A,B : in std_logic; 
		X : out std_logic	
	);
end orGate;

architecture bhv of orGate is 
begin 
	X <= A OR B ;
end bhv;