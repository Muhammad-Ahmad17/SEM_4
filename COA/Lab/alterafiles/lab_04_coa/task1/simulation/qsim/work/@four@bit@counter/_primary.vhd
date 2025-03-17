library verilog;
use verilog.vl_types.all;
entity FourBitCounter is
    port(
        o_output        : out    vl_logic_vector(3 downto 0);
        clk             : in     vl_logic
    );
end FourBitCounter;
