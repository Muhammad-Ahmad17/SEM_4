library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.alu_components.ALL;  -- Import our custom components

entity ALU is
    port (
        a, b, Cin : in STD_LOGIC;
        Sel : in STD_LOGIC_VECTOR(1 downto 0);
        Result, Cout : out STD_LOGIC
    );
end ALU;

architecture struct of ALU is
    -- Internal signals to connect components
    signal and_out, or_out, nand_out, sum_out, carry_out: STD_LOGIC;
begin
    -- Instantiate AND Gate
    U1: Andgate port map(and_in1 => a, and_in2 => b, and_out => and_out);

    -- Instantiate OR Gate
    U2: Orgate port map(or_in1 => a, or_in2 => b, or_out => or_out);

    -- Instantiate NAND Gate
    U3: Nandgate port map(nand_in1 => a, nand_in2 => b, nand_out => nand_out);

    -- Instantiate Full Adder
    U4: Fulladder port map(adder_inA => a, adder_inB => b, adder_inC => Cin, adder_outS => sum_out, adder_outC => carry_out);

    -- Instantiate 4-to-1 MUX
    U5: Mux port map(
        mux_inI0 => and_out,
        mux_inI1 => or_out,
        mux_inI2 => nand_out,
        mux_inI3 => sum_out,
        mux_Sel => Sel,
        mux_outY => Result
    );

    -- Assign Carry Out
    Cout <= carry_out;
end struct;
