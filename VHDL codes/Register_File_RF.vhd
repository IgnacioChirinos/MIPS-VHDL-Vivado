library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Register_File_RF is 
	port (
	    -- INPUTS
		clk               : in std_logic;
		RegWrite          : in std_logic;
		read_register_1   : in std_logic_vector(4 downto 0);
		read_register_2   : in std_logic_vector(4 downto 0);
		write_register    : in std_logic_vector(4 downto 0);
		write_data        : in std_logic_vector(31 downto 0);
		
		-- OUTPUTS
		read_data_1       : out std_logic_vector(31 downto 0);
		read_data_2       : out std_logic_vector(31 downto 0)
	);
end Register_File_RF;

architecture Behavioral of Register_File_RF is

 type memory is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal registers: memory := (
    
        "00000000000000000000000000000000", -- $0 $zero
        "00000000000000000000000000000000", -- $1 $at
        "00000000000000000000000000000000", -- $2 $v0
        "00000000000000000000000000000000", -- $3 $v1
        "00000000000000000000000000000000", -- $4 $a0
        "00000000000000000000000000000000", -- $5 $a1
        "00000000000000000000000000000000", -- $6 $a2
		"00000000000000000000000000000000", -- $7 $a3
        "00000000000000000000000000000000", -- $8 $t0
        "00000000000000000000000000000000", -- $9 $t1
        "00000000000000000000000000000000", -- $10 $t2
        "00000000000000000000000000000000", -- $11 $t3
        "00000000000000000000000000000000", -- $12 $t4
        "00000000000000000000000000000000", -- $13 $t5
        "00000000000000000000000000000000", -- $14 $t6
        "00000000000000000000000000000000", -- $15 $t7
        "00000000000000000000000000000000", -- $16 $s0
        "00000000000000000000000000000000", -- $17 $s1
        "00000000000000000000000000000000", -- $18 $s2
        "00000000000000000000000000000000", -- $19 $s3
        "00000000000000000000000000000000", -- $20 $s4
        "00000000000000000000000000000000", -- $21 $s5
        "00000000000000000000000000000000", -- $22 $s6
        "00000000000000000000000000000000", -- $23 $s7
        "00000000000000000000000000000000", -- $24 $t8
        "00000000000000000000000000000000", -- $25 $t9
        "00000000000000000000000000000000", -- $26 $k0
        "00000000000000000000000000000000", -- $27 $k1
        "00000000000000000000000000000000", -- $28 $gp
        "00000000000000000000000000000000", -- $29 $sp
        "00000000000000000000000000000000", -- $30 $fp
        "00000000000000000000000000000000"  -- $31 $ra
    );
    
begin

 read_data_1 <= registers(to_integer(unsigned(read_register_1)));
 read_data_2 <= registers(to_integer(unsigned(read_register_2)));
 

 process(clk, RegWrite)
        begin
        if (rising_edge (clk)) then
            if RegWrite = '1' then
                -- write to reg. mem. when the RegWrite flag is set and on a clock edge
                registers(to_integer(unsigned(write_register))) <= write_data;
            end if;
        end if;
    end process;
end Behavioral;