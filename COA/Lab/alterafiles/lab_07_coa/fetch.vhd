library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
use ieee.std_logic_unsigned.all; 
use work.MyPackage.all;


entity fetch is
    port (
        PC_out         												: out STD_LOGIC_VECTOR (31 downto 0);
        instruction    												: out STD_LOGIC_VECTOR (31 downto 0);
        branch_addr,jump_addr      								: in STD_LOGIC_VECTOR (31 downto 0);
        branch_decision,jump_decision,reset,clock        : in std_logic
    );
end fetch;

architecture bhv of fetch is
    -- Define instruction memory array type
    type mem_array is array(0 to 15) of std_logic_vector(31 downto 0);

begin
    -- Process for handling the fetch operation
    process(clock, reset)
        -- Define variables inside the process
        variable pc     : std_logic_vector(31 downto 0) ;
        variable index  : integer range 0 to 15 := 0;

        -- Initialize the instruction memory with machine code
        variable mem    : mem_array := (
            X"8c220000", -- lw $2, 0($1)     -- Load word		-- 1
            X"8c640001", -- lw $4, 1($3)     -- Load word		-- 2
            X"00822022", -- sub $4, $4, $3   -- Subtract			-- 3
            X"ac400000", -- sw $4, 0($3)     -- Store word		-- 4
            X"1022fffa", -- beq $1, $2, L    -- Branch if equal-- 5
            X"00612024", -- and $4, $3, $1   -- AND operation	-- 6
            X"08000000", -- j L              -- Jump				-- 7
            X"00000000", -- NO               -- No operation	-- 8
            others => X"00000000"  -- Initialize remaining locations
        );
    begin

		-- fetch Process
		

        -- Check if reset signal is active
			if reset = '1' then
            pc := (others => '0');
            instruction <= (others => '0');
            PC_out <= (others => '0');
			elsif rising_edge(clock) then
            -- Handle branch/jump
            if branch_decision = '1' then
                pc := branch_addr;
            elsif jump_decision = '1' then
                pc := jump_addr;
				end if;
			end if;
				
            -- Calculate memory index from PC (using word alignment)
            index := to_integer(unsigned(pc(3 downto 0)));
            -- Increment PC by 1(4-bit) (after fetching)
            pc := pc + "1";
				
			
            -- Fetch instruction from memory
            instruction <= mem(index);
				-- Featch program counter wrt 
            PC_out <= pc;
				
    end process;

end bhv;