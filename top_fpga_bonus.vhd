--========================= top_fpga.vhd ============================
-- ELE-343 Conception des syst�mes ordin�s
-- HIVER 2017, Ecole de technologie sup�rieure
-- Auteur : Yves Blaqui�re
-- =============================================================
-- Description: top_fpga
--              Enveloppe (wrapper) pour le top du MIPS qui
--              Nomme les ports en fonction du fichier des pins
--              du FPGA, tel que d�crit dans le fichier
--              DE2_pin_assignments.csv du DE2
--              Ajoute des afficheurs 7-segment sur les ports de
--              sortie du top
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_fpga_bonus IS
  PORT (KEY  : IN  std_logic_vector (0 TO 1);   -- KEY[0]=reset, KEY[1]=clock
        HEX0 : OUT std_logic_vector (0 TO 6);   -- PC(3 downto 0) 
        HEX1 : OUT std_logic_vector (0 TO 6);   -- PC(7 downto 4) 
        HEX4 : OUT std_logic_vector (0 TO 6);   -- DataAddress(3 downto 0) 
        HEX5 : OUT std_logic_vector (0 TO 6);   -- DataAddress(7 downto 4) 
        HEX6 : OUT std_logic_vector (0 TO 6);   -- WriteData(3 downto 0) 
        HEX7 : OUT std_logic_vector (0 TO 6));
END ENTITY top_fpga_bonus;

ARCHITECTURE rtl OF top_fpga_bonus IS
  SIGNAL Memwrite               : std_logic;
  SIGNAL PC                     : std_logic_vector (31 DOWNTO 0);
  SIGNAL WriteData, DataAddress : std_logic_vector (31 DOWNTO 0);

	--signaux pour les decodeurs 7 segments, on en a besoin pour garder les valeurs quand on a autre chose sur DataAddress
  SIGNAL dixiemeSecondes		: std_logic_vector (3 downto 0);
  SIGNAL secondes				: std_logic_vector (3 downto 0);
  SIGNAL dixSecondes			: std_logic_vector (3 downto 0);
  SIGNAL minutes				: std_logic_vector (3 downto 0);
BEGIN  -- ARCHITECTURE tb
  -- Instantiation du top
  DUT : ENTITY work.top
    PORT MAP (Reset       => KEY(0),
              clk       => KEY(1),
              PC          => PC,
              WriteData   => WriteData,
              AluResult => DataAddress,
              Memwrite => memWrite);


  
  
--on a besoin de savoir si on a modifie la ram
affichage : process (memwrite, DataAddress)
begin
	if(memWrite = '1') then
		if(dataAddress = "00000000000000000000000000000000") then
			dixiemeSecondes <= WriteData(3 downto 0);
		elsif (dataAddress = "00000000000000000000000000000100") then
			secondes <= WriteData(3 downto 0);
		elsif (dataAddress = "00000000000000000000000000001000") then
			dixSecondes <= WriteData(3 downto 0);
		elsif (dataAddress = "00000000000000000000000000001100") then
			minutes <= WriteData(3 downto 0);
		end if;
		
	end if;

end process;



  -- Afficheurs 7-segments pour les ports de sortie
  dec7seg_0 : ENTITY work.dec7seg PORT MAP (HEX0, dixiemeSecondes);
  dec7seg_1 : ENTITY work.dec7seg PORT MAP (HEX1, secondes);
  dec7seg_4 : ENTITY work.dec7seg PORT MAP (HEX4, dixSecondes);
  dec7seg_5 : ENTITY work.dec7seg PORT MAP (HEX5, minutes);
END ARCHITECTURE rtl;

