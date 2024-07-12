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

  CONSTANT TAILLE_ROM : positive := 32;  -- taille de la rom (modifier au besoin)
  TYPE romtype IS ARRAY (0 TO TAILLE_ROM) OF std_logic_vector(31 DOWNTO 0);

  CONSTANT Rom : romtype := (
    0  => x"20020000",
    1  => x"20030000",
    2  => x"20042710",
    3  => x"2005000a",
    4  => x"20080006",
    5  => x"20090000",
    6  => x"200a0000",
    7  => x"200b0000",
    8  => x"200c0000",
    9  => x"0800001c",
    10  => x"20420001",
    11  => x"10440001",
    12  => x"0800000a",
    13  => x"20020000",
    14  => x"21290001",
    15  => x"11250001",
    16  => x"0800001c",
    17  => x"20090000",
    18  => x"214a0001",
    19  => x"11450001",
    20  => x"0800001c",
    21  => x"200a0000",
    22  => x"216b0001",
    23  => x"11680001",
    24  => x"0800001c",
    25  => x"200b0000",
    26  => x"218c0001",
    27  => x"0800001c",
    28  => x"ac690000",
    29  => x"ac6a0004",
    30  => x"ac6b0008",
    31  => x"ac6c000c",
    32  => x"0800000a");
BEGIN
  PROCESS (adresse)
  BEGIN
    data <= Rom(to_integer(unsigned((adresse))));
  END PROCESS;
END imem_arch;

