library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control_ALU_CA is
	port (
		Function_Code  : in std_logic_vector(5 downto 0);
		ALUOp     : in std_logic_vector(1 downto 0);
		ALUCtrl   : out std_logic_vector(3 downto 0)
	);
end Control_ALU_CA;

architecture Behavioral of Control_ALU_CA is
begin	

    ALUCtrl <= "0010" when (ALUOp = "00" or (ALUOp = "10" and Function_Code(3 downto 0) = "0000")) else --SUMA
               "0110" when (ALUOp = "01" or (ALUOp = "10" and Function_Code(3 downto 0) = "0010")) else --RESTA
               "0000" when (ALUOp = "10" and Function_Code(3 downto 0) = "0100") else --AND
               "0001" when (ALUOp = "10" and Function_Code(3 downto 0) = "0101") else --OR
               "0111" when (ALUOp = "10" and Function_Code(3 downto 0) = "1010") else --SOLT
			   "1000";
			   --"1111" when ALUOp = "11" else --Error code 1
               --"0011"; --Error Code 2
               
end Behavioral;

