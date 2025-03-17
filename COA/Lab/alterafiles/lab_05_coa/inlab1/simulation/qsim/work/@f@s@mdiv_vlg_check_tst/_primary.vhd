library verilog;
use verilog.vl_types.all;
entity FSMdiv_vlg_check_tst is
    port(
        quot            : in     vl_logic_vector(3 downto 0);
        remaind         : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end FSMdiv_vlg_check_tst;
