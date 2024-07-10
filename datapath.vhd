--datapath
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_misc.ALL;

library work;
use work.all;


entity datapath is
    port(
        clock,Reset,MemtoReg,Branch,AluSrc,RegDst,
		  RegWrite,Jump,MemReadIn,MemWriteIn: in std_logic;
        AluControl : in std_logic_vector(3 downto 0);
        
        Instruction,ReadData : in std_logic_vector(31 downto 0);
		  
        MemReadOut,MemWriteOut : out std_logic;
      
        PC,AluResult,WriteData : out std_logic_vector(31 downto 0)
    );
end entity;

architecture datapath_Arc of datapath is
--------------------
signal  ual_srcA :   std_logic_vector(31 DOWNTO 0);
signal  ual_srcB :   std_logic_vector(31 DOWNTO 0);
signal  ual_result:  std_logic_vector(31 DOWNTO 0);
signal  ual_zero :   std_logic;
------------
signal reg_wa:std_logic_vector(4 DOWNTO 0);
signal resultat:std_logic_vector(31 DOWNTO 0);
signal reg_rd2:std_logic_vector(31 DOWNTO 0);
--------------
signal signImm:std_logic_vector(31 DOWNTO 0);
signal pcPlus4:std_logic_vector(31 DOWNTO 0);
signal adresse:std_logic_vector(25 DOWNTO 0);
signal pcJump:std_logic_vector(31 DOWNTO 0);
signal signImmSh:std_logic_vector(31 DOWNTO 0);
signal pcBranch: std_logic_vector(31 DOWNTO 0);
signal pcSrc:std_logic;
signal pcNextBr:std_logic_vector(31 DOWNTO 0);
signal pcNext:std_logic_vector(31 DOWNTO 0);
signal signal_pc:std_logic_vector(31 downto 0);

begin




registre : ENTITY work.RegFile(RegFile_arch)
port map(
	clk=>clock,
	we=>RegWrite,
	ra1=>Instruction(25 downto 21),
	ra2=>Instruction(20 downto 16),
	wa=>reg_wa,
	wd=>resultat,
	rd1=>ual_srcA,
	rd2=>reg_rd2
);

operation : ENTITY work.UAL(rtl)
port map(
	ualControl=>AluControl,
	srcA=>ual_srcA, 
	srcB=>ual_srcB, 
	result=>ual_result,
	zero=>ual_zero	
);
--------
process(RegDst,instruction)
begin
	if RegDst ='1' then
		reg_wa<=Instruction(15 downto 11);
	else
		reg_wa<=Instruction(20 downto 16);
	end if;
end process;
--------
process(AluSrc,signImm,reg_rd2)
begin
	if AluSrc ='1' then
		ual_srcB<=signImm;
	else
		ual_srcB<=reg_rd2;
	end if;
end process;
----------
process(MemtoReg,ReadData,ual_result)
begin
	if MemtoReg ='1' then
		resultat<=ReadData;
	else
		resultat<=ual_result;
	end if;
end process;
------------
process(pcSrc,pcBranch,pcPlus4)
begin
	if pcSrc ='1' then
		pcNextBr<=pcBranch;
	else
		pcNextBr<=pcPlus4;
	end if;
end process;
-------------
process(Jump,pcJump, pcNExtBr)
begin
	if Jump ='1' then
		pcNext<=pcJump;
	else
		pcNext<=pcNextBr;
	end if;
end process;
-------------
process(clock,reset)
begin
	if reset = '1' then
		signal_pc <=(others => '0');  
	elsif rising_edge(clock) then
		signal_pc<=pcNext;  
	end if;
end process;
-------------
pc<= "00" & signal_pc(31 downto 2);
AluResult<=ual_result;
WriteData<=reg_rd2;
pcSrc<=Branch AND  ual_zero;
pcPlus4<=std_logic_vector(unsigned( signal_pc ) + 4);
pcBranch<=std_logic_vector(unsigned( pcPlus4 ) + unsigned(signImmSh));
signImmSh<=std_logic_vector(resize(unsigned(signImm), 30)) &"00";

--pcPlus 4 (chemin normal du pc) OU (4 bit supperieurs de PcPlus4 avec l'addresse contenue dans l'instruction multipliee par 2)
pcJump<=(pcPlus4(31 downto 28) & (instruction(25 downto 0) & "00"));


signImm<=std_logic_vector(resize(signed(instruction(15 downto 0)), 32));
MemReadOut<=MemReadIn;
MemWriteOut<=MemWriteIn;

end architecture;
