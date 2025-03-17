library verilog;
use verilog.vl_types.all;
entity FSM_sequence_detactor_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        letstart        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FSM_sequence_detactor_vlg_sample_tst;
