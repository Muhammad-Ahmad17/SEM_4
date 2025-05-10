library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ledBlinking is 
    port(
        fpga_clk : in std_logic;
        switch   : in std_logic_vector(2 downto 0);
        led      : out std_logic_vector(3 downto 0)
    );
end ledBlinking;

architecture bhv of ledBlinking is 
    signal count      : std_logic_vector(31 downto 0) := (others => '0');
    signal ledout     : std_logic_vector(3 downto 0) := (others => '0');
    signal seq_index  : integer range 0 to 3 := 0;
    signal top_clk    : std_logic := '0';
begin 

    -- Main Clock Counter
    process (fpga_clk)
    begin
        if rising_edge(fpga_clk) then 
            count <= count + 1;
        end if;
    end process;

    -- Mode selection and LED behavior
    process(fpga_clk)
    begin
        if rising_edge(fpga_clk) then
            case switch is
                when "000" =>  -- Mode 0: All LEDs blink together at count(20)
                    if count(20) = '1' then
                        ledout <= not ledout;
                    end if;

                when "001" =>  -- Mode 1: Blink LEDs in sequence (one-by-one)
                    if count(25) = '1' then
                        ledout <= (others => '0');
                        ledout(seq_index) <= '1';
                        if seq_index = 3 then
                            seq_index <= 0;
                        else
                            seq_index <= seq_index + 1;
                        end if;
                    end if;

                when "010" | "011" =>  -- Mode 2: Blink LEDs alternately
                    if count(15) = '1' then
                        ledout <= not ledout;
                    end if;

                when others =>  -- Mode 3: All LEDs ON for 2s, OFF for 2s
                    if count(31) = '1' then
                        ledout <= not ledout;
                    end if;
            end case;
        end if;
    end process;

    -- Output to LEDs
    led <= ledout;

end bhv;




