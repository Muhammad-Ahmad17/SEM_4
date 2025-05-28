library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_components.all;

entity Wrapper is
    port (
        hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 : out std_logic_vector(6 downto 0);
        topclock, topreset                             : in std_logic;
		  leds 														 : out std_logic_vector(8 downto 0);
        RegWRT                                         : in std_logic;
        sw                                             : in std_logic_vector(4 downto 0)
    );
end Wrapper;

architecture structural of Wrapper is
    signal top_pcout       : std_logic_vector(31 downto 0);
    signal top_instruction : std_logic_vector(31 downto 0);
    signal zero_addr       : std_logic_vector(31 downto 0) := (others => '0');
    signal zero_ctrl       : std_logic := '0';

    signal reg_rs, reg_rt, reg_rd     : std_logic_vector(31 downto 0);
    signal j_addr, immediate          : std_logic_vector(31 downto 0);
    signal hexout                     : std_logic_vector(31 downto 0);
	 signal jump, RegDst, RegWrite, MemToReg, ALUSrc, beq_control, MemRead, MemWrite : std_logic;
    signal ALUOp : std_logic_vector(1 downto 0);
	 signal read_data : std_logic_vector(31 downto 0);
	 signal address : std_logic_vector(31 downto 0);	
	 signal opcode : std_logic_vector(5 downto 0);
 
begin
    u_fetch: fetch
        port map (
            PC_out           => top_pcout,
            instruction      => top_instruction,
            branch_addr      => zero_addr,
            jump_addr        => zero_addr,
            branch_decision  => zero_ctrl,
            jump_decision    => jump,
            reset            => topreset,
            clock            => topclock
        );
		  
	u_control: control
		port map (
			pc => top_pcout,
			instruction => top_instruction,
			reset => topreset,
			jump => jump,
			RegDst => RegDst,
			RegWrite => RegWrite,
			MemToReg => MemToReg,
			ALUOp => ALUOp,
			ALUSrc => ALUSrc,
			beq_control => beq_control,
			MemRead => MemRead,
			MemWrite => MemWrite
		);
		
    u_decode: decode
        port map (
            instruction   => top_instruction,
            memory_data   => read_data,
            Alu_result    => x"00000000",
            reset         => topreset,
            clock         => topclock,
            RegDst        => RegDst,
            RegWrite      => RegWrite,
            MemToReg      => MemToReg,
            register_rs   => reg_rs,
            register_rt   => reg_rt,
            register_rd   => reg_rd,
            jump_addr     => j_addr,
            immediate     => immediate
        );
	u_memory: memory
		port map(
		address => reg_rs,
		 write_data => reg_rt,
		 MemWrite => MemWrite,
		 MemRead => MemRead,
		 read_data => read_data
		);
	 opcode <= top_instruction(31 downto 26);
	 
    hexout <= 	top_instruction when (sw ="00000")else
				reg_rs 			when (sw ="00001")else
				reg_rt			when (sw ="00010") else
				reg_rd			when (sw ="00100") else
				immediate		when (sw ="01000") else
				j_addr			when (sw ="10000") 
				;
    u_hex0: SSD port map (bininput => hexout(3 downto 0),     cathodes => hex0);
    u_hex1: SSD port map (bininput => hexout(7 downto 4),     cathodes => hex1);
    u_hex2: SSD port map (bininput => hexout(11 downto 8),    cathodes => hex2);
    u_hex3: SSD port map (bininput => hexout(15 downto 12),   cathodes => hex3);
    u_hex4: SSD port map (bininput => hexout(19 downto 16),     cathodes => hex4);
    u_hex5: SSD port map (bininput => hexout(23 downto 20),     cathodes => hex5);
    u_hex6: SSD port map (bininput => hexout(27 downto 24),    cathodes => hex6);
    u_hex7: SSD port map (bininput => hexout(31 downto 28),   cathodes => hex7);
	 
	with opcode select leds <=
    "100100010" when "000000", -- R-type
    "011110000" when "100011",  -- lw
    "010001000" when "101011",  -- sw
    "000000101" when "000100",  -- beq
    "000000000" when others;
end structural;
