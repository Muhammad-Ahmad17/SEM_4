library verilog;
use verilog.vl_types.all;
entity ahm_vlg_check_tst is
    port(
        cout            : in     vl_logic;
        result          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ahm_vlg_check_tst;
