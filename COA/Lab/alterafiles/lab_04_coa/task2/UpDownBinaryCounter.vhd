LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.My_Package.ALL;

ENTITY UpDownBinaryCounter IS
    PORT (
        binOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); 
        opcode : IN  STD_LOGIC;
        clk    : IN  STD_LOGIC     
    );
END UpDownBinaryCounter;

ARCHITECTURE bhv OF UpDownBinaryCounter IS

    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL qnot : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL d : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

    U1 : myDLatch PORT MAP ( clk, d(0), q(0), qnot(0));
    U2 : myDLatch PORT MAP ( clk, d(1), q(1), qnot(1));
    U3 : myDLatch PORT MAP ( clk, d(2), q(2), qnot(2));

    d(0) <= NOT q(0); 
    d(1) <= (q(1) XOR q(0)) WHEN opcode = '0' ELSE (q(1) XOR qnot(0));
    d(2) <= (q(2) XOR (q(1) AND q(0))) WHEN opcode = '0' ELSE (q(2) XOR (qnot(1) AND qnot(0)));


    binOut <= q;  

END bhv;
