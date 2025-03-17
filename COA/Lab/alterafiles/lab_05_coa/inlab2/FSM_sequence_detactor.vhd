library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM_sequence_detactor is
    port (
        clk      : in std_logic;
        letstart : in std_logic;
        y   	  : out std_logic
    );
end FSM_sequence_detactor;

architecture bhv of FSM_sequence_detactor is

	 --define state using one hot coding
    constant state0 : std_logic_vector(4 downto 0) := "00001";
    constant state1 : std_logic_vector(4 downto 0) := "00010";
    constant state2 : std_logic_vector(4 downto 0) := "00100";
    constant state3 : std_logic_vector(4 downto 0) := "01000";
    constant state4 : std_logic_vector(4 downto 0) := "10000";

    -- State Memory
    signal mystate : std_logic_vector(4 downto 0) := state0;  -- 00001
	
begin
    process (clk)
    begin
        if (clk'event and clk = '1') then   -- positive edge sensitive
            case mystate is
				------
                when state0 =>
					y <= '0';	
                     if (letstart = '1') then
                        mystate <= state1;
                    else -- 0
                        mystate <= state0;
                    end if;
				------
                when state1 =>
					 y <= '0';
						 if (letstart = '0') then
                        mystate <= state2;
                    else -- 1
                        mystate <= state1;
                    end if;
				------
                when state2 =>
					 y <= '0';
						 if (letstart = '1') then
                        mystate <= state3;
                    else --0
                        mystate <= state0;
                    end if;
				------
                when state3 =>
					 y <= '1';
						 if (letstart = '1') then
                        mystate <= state4;
                    else -- 0
                        mystate <= state2;
                    end if;
				------
                when state4 =>
					 y <= '1';
						 if (letstart = '1') then
                        mystate <= state0;
                    else -- 0
                        mystate <= state0;
                    end if;
				------
                when others =>
                    mystate <= state0;
				------
            end case;
        end if;
    end process;
end bhv;