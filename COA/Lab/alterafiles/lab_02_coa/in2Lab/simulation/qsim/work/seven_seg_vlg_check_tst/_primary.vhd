library verilog;
use verilog.vl_types.all;
entity seven_seg_vlg_check_tst is
    port(
        cathodes        : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end seven_seg_vlg_check_tst;
