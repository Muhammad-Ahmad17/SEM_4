library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.myCompo.ALL;

entity ahm is
    port(
        in1,in2,Cin : in std_logic;
		  selector : in std_logic_vector(1 downto 0);
		  result,cout : out std_logic
    );
end ahm;

architecture bhv of ahm is
    signal and_out, or_out, nand_out, sum_out : std_logic; 

begin

	U1: andGate port map (in1,in2,and_out);
	
	U2: orGate port map (in1,in2,or_out);
	
	U3: nandGate port map (in1,in2,nand_out);
	
	U4: fullAdder port map (in1,in2,Cin,sum_out,cout);
	
	U5: muxx port map (and_out,or_out,nand_out,sum_out,selector,result);
	
	 
end bhv;
