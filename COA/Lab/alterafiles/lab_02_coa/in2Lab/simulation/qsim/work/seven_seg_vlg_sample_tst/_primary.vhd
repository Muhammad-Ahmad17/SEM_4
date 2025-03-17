library verilog;
use verilog.vl_types.all;
entity seven_seg_vlg_sample_tst is
    port(
        bininput        : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end seven_seg_vlg_sample_tst;
