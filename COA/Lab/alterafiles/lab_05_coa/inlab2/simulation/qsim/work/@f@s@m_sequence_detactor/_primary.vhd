library verilog;
use verilog.vl_types.all;
entity FSM_sequence_detactor is
    port(
        clk             : in     vl_logic;
        letstart        : in     vl_logic;
        y               : out    vl_logic
    );
end FSM_sequence_detactor;
