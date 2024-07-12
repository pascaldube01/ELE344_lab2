--========================= imem.vhd ============================
-- ELE-343 Conception des syst�mes ordin�s
-- HIVER 2017, Ecole de technologie sup�rieure
-- Auteur : Chakib Tadj, Vincent Trudel-Lapierre, Yves Blaqui�re
-- =============================================================
-- Description: imem        
-- =============================================================

LIBRARY ieee;
LIBRARY std;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY imem_bonus IS -- Memoire d'instructions
  PORT (adresse : IN  std_logic_vector(31 DOWNTO 0); -- Taille a modifier
                                                    -- selon le programme 
        data : OUT std_logic_vector(31 DOWNTO 0));
END;  -- imem;

ARCHITECTURE imem_arch OF imem_bonus IS

  CONSTANT TAILLE_ROM : positive := 34;  -- taille de la rom (modifier au besoin)
  TYPE romtype IS ARRAY (0 TO TAILLE_ROM) OF std_logic_vector(31 DOWNTO 0);

  CONSTANT Rom : romtype := (
    0  => x"20020000",
    1  => x"20030000",
    2  => x"3c01004c",
    3  => x"34214b40",
    4  => x"00012020",
    5  => x"2005000a",
    6  => x"20080006",
    7  => x"20090000",
    8  => x"200a0000",
    9  => x"200b0000",
    10  => x"200c0000",
    11  => x"0800001e",
    12  => x"20420001",
    13  => x"10440001",
    14  => x"0800000c",
    15  => x"20020000",
    16  => x"21290001",
    17  => x"11250001",
    18  => x"0800001e",
    19  => x"20090000",
    20  => x"214a0001",
    21  => x"11450001",
    22  => x"0800001e",
    23  => x"200a0000",
    24  => x"216b0001",
    25  => x"11680001",
    26  => x"0800001e",
    27  => x"200b0000",
    28  => x"218c0001",
    29  => x"0800001e",
    30  => x"ac690000",
    31  => x"ac6a0004",
    32  => x"ac6b0008",
    33  => x"ac6c000c",
    34  => x"0800000c");
BEGIN
  PROCESS (adresse)
  BEGIN
    data <= Rom(to_integer(unsigned((adresse))));
  END PROCESS;
END imem_arch;

