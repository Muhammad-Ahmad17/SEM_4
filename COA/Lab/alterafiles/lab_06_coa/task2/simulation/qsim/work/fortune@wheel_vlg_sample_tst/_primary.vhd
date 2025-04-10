library verilog;
use verilog.vl_types.all;
entity fortuneWheel_vlg_sample_tst is
    port(
        fpga_clk        : in     vl_logic;
        reset           : in     vl_logic;
        start_sw        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end fortuneWheel_vlg_sample_tst;
