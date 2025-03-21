library verilog;
use verilog.vl_types.all;
entity ledBlinking is
    port(
        fpga_clk        : in     vl_logic;
        switch          : in     vl_logic_vector(2 downto 0);
        led             : out    vl_logic_vector(3 downto 0)
    );
end ledBlinking;
