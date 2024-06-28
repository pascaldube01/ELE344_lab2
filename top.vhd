LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_misc.ALL;

ENTITY top is
	port(
		reset 		: in std_logic;
		clock 		: in std_logic;
		
		PC			: out std_logic_vector (31 downto 0);
		WriteData	: out std_logic_vector (31 downto 0);
		AluResult	: out std_logic_vector (31 downto 0));
end top;


architecture run of top is
	SIGNAL PC_s 			: std_logic_vector (31 downto 0);
	SIGNAL Instruction_s	: std_logic_vector (31 downto 0);
	SIGNAL WriteData_s 		: std_logic_vector (31 downto 0);
	SIGNAL AluResult_s 		: std_logic_vector (31 downto 0);
	SIGNAL ReadData_s 		: std_logic_vector (31 downto 0);		
	SIGNAL MemRead_s		: std_logic;
	SIGNAL MemWrite_s		: std_logic;

begin

	-- instanciation de la memoire d'instruction
	IMEM : ENTITY work.imem(imem_arch)
	PORT MAP(	addresse => PC_s,
				data => Instruction_s);
 			
 			
 	--instanciation du mips
 	MIPS : ENTITY work.mips(cpu)
 	PORT MAP(	-- entrees
 				Instruction => instruction_s,
 				reset => reset,
 				clock => clock,
 				ReadData => ReadDAta_s,
 				--sorties
 				PC => PC_s,
 				WriteData => WriteData_s,
 				AluResult => AluResult_s,
 				memRead => memRead_s,
 				memWrite => memWrite_s);
 			
 			
 	-- instanciaiton de la memoire de donnees
	DMEM: ENTITY work.dmem(dmem_arch)
	PORT MAP(	-- entrees
				clk => clock,
				memWrite => memWrite_S,
				addresse => aluResult_S,
				writeData_writeData_S,
				--sortie
				readData => ReadData_S );

--mise des signaus en sortie du top
PC <= PC_s;
WriteData <= WriteData_s;
AluResult <= AluResult_s;

end run;
