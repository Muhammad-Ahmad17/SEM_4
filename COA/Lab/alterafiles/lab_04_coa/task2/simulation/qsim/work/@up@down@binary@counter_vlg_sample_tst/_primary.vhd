library verilog;
use verilog.vl_types.all;
entity UpDownBinaryCounter_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        opcode          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end UpDownBinaryCounter_vlg_sample_tst;
