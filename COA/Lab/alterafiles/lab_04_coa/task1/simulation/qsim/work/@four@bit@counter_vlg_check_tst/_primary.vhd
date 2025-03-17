library verilog;
use verilog.vl_types.all;
entity FourBitCounter_vlg_check_tst is
    port(
        o_output        : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end FourBitCounter_vlg_check_tst;
