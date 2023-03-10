library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity MIPS_Procesador is
	port (
        -- INPUT
        clk		: in std_logic;
		-- OUTPUT
		Memory_Out_cero	    : out std_logic_vector(0 downto 0);
		Memory_Out_ident	: out std_logic_vector(0 downto 0);
		Memory_Out_incomp	: out std_logic_vector(0 downto 0);
		Result_0 : out std_logic_vector (31 downto 0);
		Result_1 : out std_logic_vector (31 downto 0);
		Result_2 : out std_logic_vector (31 downto 0);
		Result_3 : out std_logic_vector (31 downto 0);
		Result_4 : out std_logic_vector (31 downto 0);
		Result_5 : out std_logic_vector (31 downto 0);
		Result_6 : out std_logic_vector (31 downto 0);
		Result_7 : out std_logic_vector (31 downto 0);
		Result_8 : out std_logic_vector (31 downto 0)
    );
end MIPS_Procesador;

architecture Behavioral of MIPS_Procesador is

-- COMPONENTS
-- PROGRAM COUNTER
component Program_Counter_PC is
	port (
	    clk       : in STD_LOGIC;
		PC_in     : in STD_LOGIC_VECTOR (31 downto 0);
		PC_out    : out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

-- CONTROL ALU
component Control_ALU_CA is
port (
		Function_Code  : in std_logic_vector(5 downto 0);
		ALUOp          : in std_logic_vector(1 downto 0);
		ALUCtrl        : out std_logic_vector(3 downto 0)
	);
end component;

-- ALU
component ALUU is 
	port (
		A, B      : in std_logic_vector(31 downto 0);
		ALUCtrl   : in std_logic_vector(3 downto 0);
		Zero      : out std_logic;
		ALUOut    : out std_logic_vector(31 downto 0)
	);
end component;

-- INSTRUCTION MEMORY
component Instruction_Memory_IM is
port (
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction: out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

-- DATA MEMORY
component Data_Memory_DM is
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
end component;

-- REGISTER FILE
component Register_File_RF is
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
end component;

-- SIGN EXTEND
component Sign_Extend_SE is
port (
		ext_in    : in std_logic_vector(15 downto 0);
		ext_out   : out std_logic_vector(31 downto 0)
	);
end component;

-- CONTROL UNIT
component Control_Unit_CU is
port (   
        ins		:	in std_logic_vector(5 downto 0);
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
end component;

-- SIGNALS
-- PROGRAM COUNTER
signal PC_s : std_logic_vector(31 downto 0):=x"00000000";

-- INSTRUCTION MEMORY
signal ins_s: std_logic_vector(31 downto 0):=x"00000000";

-- DATA MEMORY
signal data_s: std_logic_vector(31 downto 0):=x"00000000";

-- SIGN EXTEND
signal ext_s: std_logic_vector(31 downto 0):=x"00000000";

-- ALU
signal A_s  : std_logic_vector(31 downto 0):=x"00000000";
signal B_s  : std_logic_vector(31 downto 0):=x"00000000";
signal ALU_s: std_logic_vector(31 downto 0):=x"00000000";
signal Zero_s: std_logic:='0';

-- CONTROL ALU
signal ALUCtrl_s: std_logic_vector(3 downto 0):="0000";

-- SHIFT
signal shift_s1: std_logic_vector(31 downto 0):=x"00000000";
signal shift_s2: std_logic_vector(27 downto 0):=x"0000000";

-- ADDERS
signal adder_s1: std_logic_vector(31 downto 0):=x"00000000";
signal adder_s2: std_logic_vector(31 downto 0):=x"00000000";

-- CONTROL UNIT
signal RegDst_s : std_logic:='0';
signal Jump_s   : std_logic:='0';
signal Branch_s : std_logic:='0';
signal MemRead_s: std_logic:='0';
signal MemtoReg_s: std_logic:='0';
signal ALUOp_s  : std_logic_vector(1 downto 0):="00";
signal MemWrite_s: std_logic:='0';
signal ALUSrc_s : std_logic:='0';
signal RegWrite_s: std_logic:='0';

--CONTROL and
signal and_s    : std_logic:='0';

--JUMP
signal jump_address_s : std_logic_vector(31 downto 0):=x"00000000";

-- MUXs
signal mux_s1: std_logic_vector(4 downto 0):="00000"; --To Reg (Write Reg)
signal mux_s2: std_logic_vector(31 downto 0):=x"00000000"; --To ALU
signal mux_s3: std_logic_vector(31 downto 0):=x"00000000"; --To Reg (Write Data)
signal mux_s4: std_logic_vector(31 downto 0):=x"00000000"; --To Mux 5
signal mux_s5: std_logic_vector(31 downto 0):=x"00000000"; --To PC

begin

-- MUX PART
    mux_s1 <= ins_s(15 downto 11) when RegDst_s = '1'
            else ins_s(20 downto 16);
    mux_s2 <= ext_s when ALUSrc_s = '1'
            else B_s;
    mux_s3 <= data_s when MemtoReg_s = '1'
            else ALU_s;
    mux_s4 <= adder_s2 when and_s = '1'
            else adder_s1;
    mux_s5 <= jump_address_s when Jump_s = '1'
            else mux_s4;

-- ADDER PART
    adder_s1 <= std_logic_vector(unsigned(PC_s) + 4);
    adder_s2 <= std_logic_vector(unsigned(shift_s1) + unsigned(adder_s1));
    
-- SHIFT PART
    shift_s1 <= ext_s(29 downto 0)&"00";
    shift_s2 <= ins_s(25 downto 0)&"00";

-- AND PART
    AND_s <= Branch_s and Zero_s;

-- JUMP PART
    jump_address_s <= adder_s1(31 downto 28) & shift_s2;
    
-- COMPONENT CONECTIONS
-- PROGRAM COUNTER
U1 : Program_Counter_PC port map(
        clk => clk,
		PC_in => mux_s5,
		PC_out => PC_s
    );
    
-- INSTRUCTION MEMORY
U2 : Instruction_Memory_IM port map(
        read_address => PC_s,
		instruction => ins_s
	);

-- DATA MEMORY
U3 : Data_Memory_DM port map(
        address => ALU_s,
		write_data => B_s,
		MemWrite => MemWrite_s,
		MemRead => MemRead_s,
		clk => clk,
		read_data => data_s,
		Memory_Out_cero => Memory_Out_cero,
		Memory_Out_ident => Memory_Out_ident,
		Memory_Out_incomp => Memory_Out_incomp,
		R0=> Result_0,
		R1=> Result_1,
		R2=> Result_2,
		R3=> Result_3,
		R4=> Result_4,
		R5=> Result_5,
		R6=> Result_6,
		R7=> Result_7,
		R8=> Result_8
	);

-- REGISTER FILE
U4 : Register_File_RF port map(
		clk => clk,
		RegWrite => RegWrite_s,
		read_register_1 => ins_s(25 downto 21),
		read_register_2 => ins_s(20 downto 16),
		write_register => mux_s1,
		write_data => mux_s3,
		read_data_1 => A_s,
		read_data_2 => B_s
	);

-- ALU
U5 : ALUU port map(
        A => A_s,
		B => mux_s2,
		ALUCtrl => ALUCtrl_s,
		Zero => Zero_s,
		ALUOut => ALU_s
	);
	
-- SIGN EXTEND
U6 : Sign_Extend_SE port map(
        ext_in => ins_s(15 downto 0),
		ext_out => ext_s
	);

-- CONTROL ALU
U7 : Control_ALU_CA port map(
        Function_Code => ins_s(5 downto 0),
		ALUOp => ALUOp_s,
		ALUCtrl => ALUCtrl_s
	);

-- CONTROL UNIT
U8 : Control_Unit_CU port map(
        ins => ins_s(31 downto 26),
        RegDst => RegDst_s,
		Jump => Jump_s,
		RegWrite => RegWrite_s,
		Branch => Branch_s,
		MemRead => MemRead_s,
		MemtoReg => MemtoReg_s,
		ALUOp => ALUOp_s,
		MemWrite => MemWrite_s,
		ALUSrc => ALUSrc_s
	);
	


end Behavioral;