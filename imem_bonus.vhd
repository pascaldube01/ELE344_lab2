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

  CONSTANT TAILLE_ROM : positive := 37;  -- taille de la rom (modifier au besoin)
  TYPE romtype IS ARRAY (0 TO TAILLE_ROM) OF std_logic_vector(31 DOWNTO 0);

  CONSTANT Rom : romtype := (
    0  => x"20020000",
    1  => x"20030000",
    2  => x"20042710",
    3  => x"20100064",
    4  => x"2005000a",
    5  => x"20080006",
    6  => x"20090000",
    7  => x"200a0000",
    8  => x"200b0000",
    9  => x"200c0000",
    10  => x"08000021",
    11  => x"20420001",
    12  => x"10440001",
    13  => x"0800000b",
    14  => x"20020000",
    15  => x"21290001",
    16  => x"11250001",
    17  => x"08000021",
    18  => x"20100000",
    19  => x"21290001",
    20  => x"11250001",
    21  => x"08000021",
    22  => x"20090000",
    23  => x"214a0001",
    24  => x"11450001",
    25  => x"08000021",
    26  => x"200a0000",
    27  => x"216b0001",
    28  => x"11680001",
    29  => x"08000021",
    30  => x"200b0000",
    31  => x"218c0001",
    32  => x"08000021",
    33  => x"ac690000",
    34  => x"ac6a0004",
    35  => x"ac6b0008",
    36  => x"ac6c000c",
    37  => x"0800000b");
BEGIN
  PROCESS (adresse)
  BEGIN
    data <= Rom(to_integer(unsigned((adresse))));
  END PROCESS;
END imem_arch;

