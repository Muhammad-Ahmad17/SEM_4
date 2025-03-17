library verilog;
use verilog.vl_types.all;
entity dec3to8_vlg_check_tst is
    port(
        signal_out      : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end dec3to8_vlg_check_tst;
