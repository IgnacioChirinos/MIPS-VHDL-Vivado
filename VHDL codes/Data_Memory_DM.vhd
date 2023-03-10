library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Data_Memory_DM is
	port (
	   -- INPUTS
		address       : in STD_LOGIC_VECTOR (31 downto 0);
		write_data    : in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite      : in STD_LOGIC;
		MemRead       : in STD_LOGIC;
		clk           : in STD_LOGIC;
	
	    -- OUTPUTS
		read_data     : out std_logic_vector(31 downto 0);
		Memory_Out_cero    : out std_logic_vector(0 downto 0);
		Memory_Out_ident    : out std_logic_vector(0 downto 0);
		Memory_Out_incomp    : out std_logic_vector(0 downto 0);
		R0 : out std_logic_vector(31 downto 0);
		R1 : out std_logic_vector(31 downto 0);
		R2 : out std_logic_vector(31 downto 0);
		R3 : out std_logic_vector(31 downto 0);
		R4 : out std_logic_vector(31 downto 0);
		R5 : out std_logic_vector(31 downto 0);
		R6 : out std_logic_vector(31 downto 0);
		R7 : out std_logic_vector(31 downto 0);
		R8 : out std_logic_vector(31 downto 0)
	);
end Data_Memory_DM;

architecture Behavioral of Data_Memory_DM is

type memory is array(0 to 128) of STD_LOGIC_VECTOR (7 downto 0);
signal datamem: memory := (

--    3 => x"00",
--    4 => x"00",
--    5 => x"00",
--    6 => x"00",
    others => x"00"
);

begin

--READ
read_data <= datamem(to_integer(unsigned(address(5 downto 0))))&
             datamem(to_integer(unsigned(address(5 downto 0)))+1)&
             datamem(to_integer(unsigned(address(5 downto 0)))+2)&
             datamem(to_integer(unsigned(address(5 downto 0)))+3) when MemRead = '1' else X"00000000";

process(address, write_data, clk)
begin
    if (rising_edge (clk)) then
        if MemWrite = '1' then --WRITE
            datamem(to_integer(unsigned(address(5 downto 0)))) <= write_data(31 downto 24);
            datamem(to_integer(unsigned(address(5 downto 0)))+1) <= write_data(23 downto 16);
            datamem(to_integer(unsigned(address(5 downto 0)))+2) <= write_data(15 downto 8);
            datamem(to_integer(unsigned(address(5 downto 0)))+3) <= write_data(7 downto 0);
        end if;
    end if;
end process;




Memory_Out_cero <= datamem(60)(0 downto 0);
Memory_Out_ident <= datamem(56)(0 downto 0);
Memory_Out_incomp <= datamem(52)(0 downto 0);
R0 <= datamem(0)&datamem(1)&datamem(2)&datamem(3);
R1 <= datamem(12)&datamem(13)&datamem(14)&datamem(15);
R2 <= datamem(24)&datamem(25)&datamem(26)&datamem(27);
R3 <= datamem(4)&datamem(5)&datamem(6)&datamem(7);
R4 <= datamem(16)&datamem(17)&datamem(18)&datamem(19);
R5 <= datamem(28)&datamem(29)&datamem(30)&datamem(31);
R6 <= datamem(8)&datamem(9)&datamem(10)&datamem(11);
R7 <= datamem(20)&datamem(21)&datamem(22)&datamem(23);
R8 <= datamem(32)&datamem(33)&datamem(34)&datamem(35);
end Behavioral;