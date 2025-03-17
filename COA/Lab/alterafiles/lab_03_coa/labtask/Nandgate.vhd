library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nandgate is
    port(
        nand_in1, nand_in2 : in STD_LOGIC;
        nand_out : out STD_LOGIC
    );
end Nandgate;

architecture bhv of Nandgate is
begin
    nand_out <= NOT (nand_in1 AND nand_in2);
end bhv;
