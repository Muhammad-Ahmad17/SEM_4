library verilog;
use verilog.vl_types.all;
entity seven_seg is
    port(
        bininput        : in     vl_logic_vector(3 downto 0);
        cathodes        : out    vl_logic_vector(6 downto 0)
    );
end seven_seg;
