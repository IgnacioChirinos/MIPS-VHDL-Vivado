library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit_CU is
    port (   ins		:	in std_logic_vector(5 downto 0);
             RegDst		:	out std_logic;
             ALUSrc		:  out std_logic;
             MemtoReg	:	out std_logic;
             RegWrite	:	out std_logic;
             MemRead    :	out std_logic;
             MemWrite	:	out std_logic;
             Branch		:	out std_logic;
             ALUOp		:	out std_logic_vector(1 downto 0);
             Jump		:	out std_logic
    );
end Control_Unit_CU;

architecture Behavioral of Control_Unit_CU is

begin

	with ins select
		RegDst <= '1' when "000000",
		          '0' when others;
	with ins select
		ALUSrc <= '1' when "100011" | "101011" | "001000",
		          '0' when others;
	with ins select
		MemtoReg <= '1' when "100011",
						'0' when others;
	with ins select
		RegWrite <= '1' when "000000" | "100011" | "001000",
						'0' when others;
	with ins select
		MemRead <= '1' when "100011",
					  '0' when others;
	with ins select
		MemWrite <= '1' when "101011",
						'0' when others;
	with ins select
		Branch <= '1' when "000100",
		          '0' when others;
	with ins select
		ALUOp <= "00" when "100011" | "101011" | "000010" | "001000",
					"01" when "000100",
					"10" when "000000",
		         "11" when others;
	with ins select
		Jump <= '1' when "000010",
		        '0' when others;
				  
end Behavioral;