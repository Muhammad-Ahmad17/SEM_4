library verilog;
use verilog.vl_types.all;
entity ledBlinking_vlg_sample_tst is
    port(
        fpga_clk        : in     vl_logic;
        switch          : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end ledBlinking_vlg_sample_tst;
