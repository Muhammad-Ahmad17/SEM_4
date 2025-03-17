Library IEEE; 
Use IEEE.STD_LOGIC_1164.all;

Entity circuit is  
Port( 
		A, B , C: IN bit;      
		Y : OUT bit
	  ); 
End circuit; 
 
Architecture struct of circuit is  
Begin  
	Y<= (A AND B) OR (NOT C);  
End struct;