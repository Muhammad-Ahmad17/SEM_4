library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec3to8 is
    port (
        signal_in  : in std_logic_vector(2 downto 0);  -- Renamed input
        signal_out : out std_logic_vector(7 downto 0) -- Renamed output
    );
end dec3to8;

architecture Behavioral of dec3to8 is
begin
    process(signal_in)
    begin
        case signal_in is
            when "000" => signal_out <= "00000001";
            when "001" => signal_out <= "00000010";
            when "010" => signal_out <= "00000100";
            when "011" => signal_out <= "00001000";
            when "100" => signal_out <= "00010000";
            when "101" => signal_out <= "00100000";
            when "110" => signal_out <= "01000000";
            when "111" => signal_out <= "10000000";
            when others => signal_out <= "00000000"; -- Default case to avoid latches
        end case;
    end process;
end Behavioral;
