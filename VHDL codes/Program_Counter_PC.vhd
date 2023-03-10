
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter_PC is
	port (
	    clk   : in STD_LOGIC;
		PC_in : in STD_LOGIC_VECTOR (31 downto 0);
		PC_out: out STD_LOGIC_VECTOR (31 downto 0)
	);
end Program_Counter_PC;

architecture Behavioral of Program_Counter_PC is

signal PC_sig : STD_LOGIC_VECTOR(31 downto 0):=x"00000000";--:=x"0000001c";

begin

    process(clk)
    begin
        if clk = '1' and clk'event then
            PC_sig <= PC_in;
        end if;
    end process;
    
    PC_out <= PC_sig;

end Behavioral;