library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
    port(
        A, B, Cin : in STD_LOGIC;
        S, C : out STD_LOGIC
    );
end fullAdder;

architecture bhv of fullAdder is
begin
    S <= (A XOR B) XOR Cin;
    C <= (A AND B) OR (Cin AND (A XOR B));
end bhv;
