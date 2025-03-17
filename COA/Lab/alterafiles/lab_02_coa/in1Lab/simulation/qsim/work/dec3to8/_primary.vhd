library verilog;
use verilog.vl_types.all;
entity dec3to8 is
    port(
        signal_in       : in     vl_logic_vector(2 downto 0);
        signal_out      : out    vl_logic_vector(7 downto 0)
    );
end dec3to8;
