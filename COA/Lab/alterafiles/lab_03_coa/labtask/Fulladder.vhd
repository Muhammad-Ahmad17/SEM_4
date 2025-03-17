library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fulladder is
    port(
        adder_inA, adder_inB, adder_inC : in STD_LOGIC;
        adder_outS, adder_outC : out STD_LOGIC
    );
end Fulladder;

architecture bhv of Fulladder is
begin
    adder_outS <= (adder_inA XOR adder_inB) XOR adder_inC;
    adder_outC <= (adder_inA AND adder_inB) OR (adder_inC AND (adder_inA XOR adder_inB));
end bhv;
