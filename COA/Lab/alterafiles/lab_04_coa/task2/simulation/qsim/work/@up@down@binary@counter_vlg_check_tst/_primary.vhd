library verilog;
use verilog.vl_types.all;
entity UpDownBinaryCounter_vlg_check_tst is
    port(
        binOut          : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end UpDownBinaryCounter_vlg_check_tst;
