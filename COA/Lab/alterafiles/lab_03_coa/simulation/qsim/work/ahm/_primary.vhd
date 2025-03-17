library verilog;
use verilog.vl_types.all;
entity ahm is
    port(
        in1             : in     vl_logic;
        in2             : in     vl_logic;
        Cin             : in     vl_logic;
        selector        : in     vl_logic_vector(1 downto 0);
        result          : out    vl_logic;
        cout            : out    vl_logic
    );
end ahm;
