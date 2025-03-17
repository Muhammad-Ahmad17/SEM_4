library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Orgate is
    port(
        or_in1, or_in2 : in STD_LOGIC;
        or_out : out STD_LOGIC
    );
end Orgate;

architecture bhv of Orgate is
begin
    or_out <= or_in1 OR or_in2;
end bhv;
