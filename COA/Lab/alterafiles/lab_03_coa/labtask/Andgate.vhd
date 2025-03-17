library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Andgate is
    port(
        and_in1, and_in2 : in STD_LOGIC;
        and_out : out STD_LOGIC
    );
end Andgate;

architecture bhv of Andgate is
begin
    and_out <= and_in1 AND and_in2;
end bhv;
