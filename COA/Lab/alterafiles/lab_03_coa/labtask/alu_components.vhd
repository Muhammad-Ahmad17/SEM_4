library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package alu_components is
    -- OR Gate
    component Orgate
        port ( or_in1, or_in2 : in STD_LOGIC;
               or_out : out STD_LOGIC);
    end component;

    -- AND Gate
    component Andgate
        port ( and_in1, and_in2 : in STD_LOGIC;
               and_out : out STD_LOGIC);
    end component;

    -- NAND Gate
    component Nandgate
        port ( nand_in1, nand_in2 : in STD_LOGIC;
               nand_out : out STD_LOGIC);
    end component;

    -- Full Adder
    component Fulladder
        port ( adder_inA, adder_inB, adder_inC : in STD_LOGIC;
               adder_outS, adder_outC : out STD_LOGIC);
    end component;

    -- 4-to-1 Multiplexer
    component Mux
        port ( mux_inI0, mux_inI1, mux_inI2, mux_inI3 : in STD_LOGIC;
               mux_Sel : in STD_LOGIC_VECTOR(1 downto 0);
               mux_outY : out STD_LOGIC);
    end component;
end alu_components;
