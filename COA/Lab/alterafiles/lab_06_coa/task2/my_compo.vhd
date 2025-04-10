LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---
package my_compo is 
	procedure seven_seg (signal bininput: IN std_logic_vector(3 DOWNTO 0);
							signal cathodes : OUT std_logic_vector(6 DOWNTO 0));
end package my_compo;
---

package body my_compo is

---
	procedure seven_seg (signal bininput: IN std_logic_vector(3 DOWNTO 0); signal cathodes : OUT std_logic_vector(6 DOWNTO 0)) is
	begin
		case bininput is
			when "0000" => cathodes <= "1000000";
			when "0001" => cathodes <= "1111001";
			when "0010" => cathodes <= "0100100";
			when "0011" => cathodes <= "0110000";
			when "0100" => cathodes <= "0011001";
			when "0101" => cathodes <= "0010010";
			when "0110" => cathodes <= "0000010";
			when "0111" => cathodes <= "1111000";
			when "1000" => cathodes <= "0000000";
			when "1001" => cathodes <= "0010000";
			when "1010" => cathodes <= "0001000";
			when "1011" => cathodes <= "0000011";
			when "1100" => cathodes <= "1000110";
			when "1101" => cathodes <= "0100001";
			when "1110" => cathodes <= "0000110";
			when "1111" => cathodes <= "0001110";
			when others  => cathodes <= "1111111";
		end case;
	end procedure seven_seg;
---
end package body my_compo;
