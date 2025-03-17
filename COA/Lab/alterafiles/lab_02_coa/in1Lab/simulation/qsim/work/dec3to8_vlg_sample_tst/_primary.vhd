library verilog;
use verilog.vl_types.all;
entity dec3to8_vlg_sample_tst is
    port(
        signal_in       : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end dec3to8_vlg_sample_tst;
