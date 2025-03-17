library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSMdiv is
    port (
        clk      : in std_logic;
        letstart : in std_logic;
        remaind  : out std_logic_vector(3 downto 0);
        quot     : out std_logic_vector(3 downto 0)
    );
end FSMdiv;

architecture behav of FSMdiv is
    signal x : std_logic_vector(3 downto 0) := "1000"; -- 8
    signal y : std_logic_vector(3 downto 0) := "0011"; -- 3
    signal q : std_logic_vector(3 downto 0) := "0000"; -- For Quotient

	 --define state using one hot coding
    constant initial : std_logic_vector(2 downto 0) := "001";
    constant compute : std_logic_vector(2 downto 0) := "010";
    constant done : std_logic_vector(2 downto 0)    := "100";

    -- State Memory
    signal mystate : std_logic_vector(2 downto 0) := initial;
begin
    process (clk)
    begin
        if (clk'event and clk = '1') then
            case mystate is
				------
                when initial =>
                    -- Initialization of signals
                    x <= "1000"; -- 8
                    y <= "0011"; -- 3
                    q <= "0000"; -- Reset quotient

                    if (letstart = '1') then
                        mystate <= compute;
                    else
                        mystate <= initial;
                    end if;
				------
                when compute =>
                    -- Perform subtraction and increment quotient
                    if (x >= y) then
                        x <= x - y;
                        q <= q + 1;
                    end if;

                    -- Check if we can continue subtracting
                    if (x >= y) then
                        mystate <= compute;
                    else
                        mystate <= done;
                    end if;
				------
                when done =>
                    -- Output remainder and quotient
                    remaind <= x;
                    quot <= q;

                    -- Go back to initial state
                    mystate <= initial;
				------
                when others =>
                    mystate <= initial;
				------
            end case;
        end if;
    end process;
end behav;