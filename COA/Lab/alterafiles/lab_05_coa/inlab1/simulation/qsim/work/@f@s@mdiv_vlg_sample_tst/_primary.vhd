library verilog;
use verilog.vl_types.all;
entity FSMdiv_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        letstart        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FSMdiv_vlg_sample_tst;
