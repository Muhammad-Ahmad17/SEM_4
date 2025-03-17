library verilog;
use verilog.vl_types.all;
entity ahm_vlg_sample_tst is
    port(
        Cin             : in     vl_logic;
        in1             : in     vl_logic;
        in2             : in     vl_logic;
        selector        : in     vl_logic_vector(1 downto 0);
        sampler_tx      : out    vl_logic
    );
end ahm_vlg_sample_tst;
