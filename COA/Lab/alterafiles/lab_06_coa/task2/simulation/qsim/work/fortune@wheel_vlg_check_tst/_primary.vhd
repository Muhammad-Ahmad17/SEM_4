library verilog;
use verilog.vl_types.all;
entity fortuneWheel_vlg_check_tst is
    port(
        led             : in     vl_logic_vector(7 downto 0);
        ssd0            : in     vl_logic_vector(6 downto 0);
        ssd1            : in     vl_logic_vector(6 downto 0);
        ssd2            : in     vl_logic_vector(6 downto 0);
        ssd3            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end fortuneWheel_vlg_check_tst;
