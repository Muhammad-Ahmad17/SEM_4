library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
generic (
    module_delay : time := 10 ns
);
port (
    clk        : in std_logic;
    address    : in std_logic_vector(31 downto 0);
    write_data : in std_logic_vector(31 downto 0);
    MemWrite   : in std_logic;
    MemRead    : in std_logic;
    read_data  : out std_logic_vector(31 downto 0)
);
end memory;

architecture behavioral of memory is
    type mem_array is array(0 to 7) of std_logic_vector(31 downto 0);
    signal data_mem : mem_array := (   
        X"00000001",
        X"00000001",
        X"00000002",
        X"00000003",
        X"00000004",
        X"00000005",
        X"00000006",
        X"00000007");
begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                data_mem(to_integer(unsigned(address(2 downto 0)))) <= write_data;
            end if;
            if MemRead = '1' then
                read_data <= data_mem(to_integer(unsigned(address(2 downto 0)))) after module_delay;
            end if;
        end if;
    end process;
end behavioral;