LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.My_Package.ALL;

ENTITY FourBitCounter IS
    PORT (
        o_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
        clk    : IN  STD_LOGIC
    );
END FourBitCounter;

ARCHITECTURE bhv OF FourBitCounter IS
    SIGNAL q    : STD_LOGIC_VECTOR(3 DOWNTO 0);  
    SIGNAL qnot : STD_LOGIC_VECTOR(3 DOWNTO 0);  
    SIGNAL d    : STD_LOGIC_VECTOR(3 DOWNTO 0);  
BEGIN
    U1 : myDLatch PORT MAP (clk, d(0), q(0), qnot(0)); 
    U2 : myDLatch PORT MAP (clk, d(1), q(1), qnot(1));
    U3 : myDLatch PORT MAP (clk, d(2), q(2), qnot(2));
    U4 : myDLatch PORT MAP (clk, d(3), q(3), qnot(3));  

    d(0) <= NOT q(0);  
    d(1) <= q(1) XOR q(0);
    d(2) <= q(2) XOR (q(1) AND q(0));
    d(3) <= q(3) XOR (q(2) AND q(1) AND q(0));

    o_output <= q;

END bhv;
