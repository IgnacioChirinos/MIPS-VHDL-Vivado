library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUU is 
	port (
		A, B      : in std_logic_vector(31 downto 0);
		ALUCtrl   : in std_logic_vector(3 downto 0);
		Zero      : out std_logic;
		ALUOut    : out std_logic_vector(31 downto 0)
	);
end ALUU;

architecture Behavioral of ALUU is

signal ALUOut_S      : std_logic_vector(31 downto 0);

begin

    ALUOut_S <=	std_logic_vector(unsigned(A(15 downto 0)) * unsigned(B(15 downto 0))) when ALUCtrl = "0000" else  --AND
                A or B when ALUCtrl = "0001" else   --OR
                
                std_logic_vector(unsigned(A) + unsigned(B)) when ALUCtrl = "0010" else    --ADD
				std_logic_vector(unsigned(A) - unsigned(B)) when ALUCtrl = "0110" else    --SUBSTRACT
				
				x"00000001" when (ALUCtrl = "0111" and A < B) else --SET ON LESS THAN
				x"00000000" when (ALUCtrl = "0111" and A > B) else
				
				A nor B when ALUCtrl = "1100" else  --NOR
				B(31 downto 16) & x"0000" when ALUCtrl = "0101" else --SHIFT
				x"10000000";
                --x"FFFFFFFF" when ALUCtrl = "1111" else --Error Code 1 ALUControl
				--x"0000FFFF" when ALUCtrl = "0011" else --Error Code 2 ALUControl
				--x"0F0F0F0F"; -- Error Code Unknown

	--temp <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
	
    ALUOut <= ALUOut_S;
    
    Zero     <= '1' when (ALUOut_S = x"00000000") else '0'; --ZERO
	
end Behavioral;