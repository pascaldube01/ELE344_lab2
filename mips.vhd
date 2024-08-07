LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_misc.ALL;

ENTITY mips IS
	port(
			Instruction : in std_logic_vector (31 downto 0);
			ReadData 	: in std_logic_vector (31 downto 0);
			reset		: in std_logic;
			clock		: in std_logic;
			
			MemRead		: out std_logic;
			MemWrite	: out std_logic;
			PC			: out std_logic_vector (31 downto 0);
			WriteData	: out std_logic_vector (31 downto 0);
			AluResult	: out std_logic_vector (31 downto 0)
		);
end mips;

architecture cpu of mips is


        SIGNAL regDst_s			: std_logic;
        SIGNAL jump_s			: std_logic;
        SIGNAL branch_s			: std_logic;
        SIGNAL memRead_s		: std_logic;
        SIGNAL memToReg_s		: std_logic;
        SIGNAL memWrite_s		: std_logic;
		SIGNAL ALUSrc_s			: std_logic;
		SIGNAL regWrite_s		: std_logic;
		SIGNAL ALUControl_s		: std_logic_vector (3 DOWNTO 0);

begin

	--instanciation du controlleur
	CONTROLLEUR : ENTITY work.controlleur(control)
	PORT MAP (	--entrees provenant de l'exterieur
				OP => Instruction (31 DOWNTO 26),
				Funct => Instruction (5 DOWNTO 0),
				--sorties vers le datapath
				regWrite => regWrite_s,
				regDst => regDst_s,
				ALUSrc => ALUSrc_s,
				branch => branch_s,
				memRead => memRead_s,
				memWrite => memWrite_s,
				memToReg => memToReg_s,
				jump => jump_s,
				aluControl => ALUControl_s);
				
	--instanciation du datapath
	DATAPATH : ENTITY work.datapath(datapath_Arc)
	PORT MAP (	--entrees provenant de l'exterieur
				Instruction => Instruction,
				ReadData => ReadData,
				Reset => reset,
				clock => clock,
				--entrees provenant du controlleur
				MemtoReg => memtoReg_s,
				Branch => branch_s,
				AluSrc => AluSrc_s,
				RegDst => RegDst_s,
				RegWrite => RegWrite_s,
				Jump => Jump_s,
				MemReadIn => MemRead_s,
				MemWriteIn => MemWrite_s,
				AluControl => AluControl_s,
				--sorties vers l'exterieur
				MemReadOut => memRead,
				MemWriteOut => memWrite,
				PC => PC,
				AluResult => AluResult,
				WriteData => WriteData
				);

end cpu;
