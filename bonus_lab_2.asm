#mise a 0 du registre compteur
addi $2 $0 0

#mise en place de l'addresse memoire de base
addi $3 $0 0#0x10010000 #pour simu, changer a 0 pour reel

#mise en place des valeurs pour verifier quand incrementer les compteurs
addi $4 $0 5000000#compteur de base (cpu freq/10)
addi $5 $0 10	#secondes (sont tous des multiples de 10)
addi $8 $0 6	#minutes

#mise en place des cases memoires pour les valeurs qui seront stockees dans la ram (evide de toujours avoir a recharger)
addi $9 $0 0	#dixieme de seconde
addi $10 $0 0	#secondes
addi $11 $0 0	#10 seconde
addi $12 $0 0	#minutes

#mise a 0 des cases memoires
j updatemem


compte: #si temps ecoule, on ajoute 1 dixieme
addi $2 $2 1
beq $2 $4 incr_100ms 
j compte


incr_100ms: #si 10 ms, on ajoute 1 secone
addi $2 $0 0 #reset compteur de base
addi $9 $9 1
beq $9 $5 incr_sec
j updatemem


incr_sec: 
addi $9 $0 0 #reset compteur de 10ms
addi $10 $10 1 # ajoute 1 sec
beq $10 $5 incr_10sec #ajoute 10 sec
j updatemem


incr_10sec:
addi $10 $0 0 #re:set compteur de 1 sec
addi $11 $11 1 # ajoute 10 sec
beq $11 $8 incr_min #ajoute 1 minute
j updatemem

incr_min:
addi $11 $0 0 #re:set compteur de 1 sec
addi $12 $12 1
j updatemem

updatemem:
sw $9  0x0($3)
sw $10 0x4($3)
sw $11 0x8($3)
sw $12 0xC($3)
j compte
