LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_misc.ALL;

ENTITY controller_tb IS
end controlleur_tb;


architecture controlleur_test of controlleur_tb is
		--signaux in/out du controlleur
        SIGNAL OP 			: in std_logic_vector(5 DOWNTO 0);
		SIGNAL Funct 		: in std_logic_vector(5 DOWNTO 0);
        SIGNAL regDst		: out std_logic;
        SIGNAL jump			: out std_logic;
        SIGNAL branch		: out std_logic;
        SIGNAL memRead		: out std_logic;
        SIGNAL memToReg		: out std_logic;
        SIGNAL memWrite		: out std_logic;
		SIGNAL ALUSrc		: out std_logic;
		SIGNAL regWrite		: out std_logic;
		SIGNAL ALUControl	: out std_logic_vector (1 DOWNTO 0));

		CONSTANT PERIODE : time := 20 ns;



BEGIN
	--instanciation du controlleur et port mappings
	CONTROLLER : ENTITY work.controller(control);
	PORT MAP (OP, Funct, regDst, jump, branch, memRead, memToReg, memWrite ALUSrc, regWrite, aluControl);
	
	test : process
	
	OP <= "100011" -- LW
	wait for (PERIODE);
	
	OP <= "101011" -- SW
	wait for (PERIODE);
	
	OP <= "000100" -- BEQ
	wait for (PERIODE);

	OP <= "001000" -- ADDI
	wait for (PERIODE);
	
	OP <= "000010" -- J
	wait for (PERIODE);
	
	end test;
end controlleur_test;

