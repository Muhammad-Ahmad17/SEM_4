library verilog;
use verilog.vl_types.all;
entity FSMdiv is
    port(
        clk             : in     vl_logic;
        letstart        : in     vl_logic;
        remaind         : out    vl_logic_vector(3 downto 0);
        quot            : out    vl_logic_vector(3 downto 0)
    );
end FSMdiv;
