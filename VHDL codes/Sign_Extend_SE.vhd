library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sign_Extend_SE is
	port (
		ext_in    : in std_logic_vector(15 downto 0);
		ext_out   : out std_logic_vector(31 downto 0)
	);
end Sign_Extend_SE;

architecture Behavioral of Sign_Extend_SE is
begin
ext_out <= std_logic_vector(resize(signed(ext_in), ext_out'length));
end Behavioral;
