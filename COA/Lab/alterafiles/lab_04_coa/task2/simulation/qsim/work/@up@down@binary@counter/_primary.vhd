library verilog;
use verilog.vl_types.all;
entity UpDownBinaryCounter is
    port(
        binOut          : out    vl_logic_vector(2 downto 0);
        opcode          : in     vl_logic;
        clk             : in     vl_logic
    );
end UpDownBinaryCounter;
