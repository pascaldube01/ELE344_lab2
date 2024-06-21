# Exemple simple de fichier .do
#
# Fonction: Genere toutes les combinaisons d'entr�e
#           sur les ports a, b et c
#
# Auteur: Yves Blaqui�re
#
# ----------------------------------------------------
# 1) Cr�er la librarie work
vlib work

# 2) Compiler exemple.vhd avec VHDL 1993
vcom -93 -work work exemple.vhd

# 3) D�marrer la simulation avec le design
#    "exemple" defini dans exemple.vhd
vsim exemple

# 4) Ouvrir certaines fen�tres pour visualiser
view structure
view signals
view wave
view list

# 5) Montrer tous les signaux dans la fen�tre wave
add wave -r *
add list -r *

# 6) G�n�rer les patrons d'entr�e et ex�cuter pour 20 ns
force a 0 0, 1 4 ns -repeat 8 ns
force b 0 0, 1 2 ns -repeat 4 ns
force c 0 0, 1 1 ns -repeat 2 ns
run 20 ns

# REMARQUE: la commande � force a_i 0 0, 1 4 ns -repeat 8 ns �
#   force '0' sur le signal a � 0 ns
#   force '1' sur le signal a � 4 ns
#   et r�p�te cette s�quence � toutes les 8 ns
