#xor/sra/srav
#lb/lh/lbu/lhu/sb/sh

addi $8, $0, 114514
addi $9, $0, 1919810
xor  $3, $8, $9
sw   $3, 0($0)
addi $8, $0, -114514
addi $9, $0, 3
sra  $3, $8, 3
sw   $3, 4($0)
srav $3, $8, $9
sw   $3, 8($0)
addi $3, $0, 1919810
sw   $3, 12($0)
addi $3, $0, -7
sb   $3, 16($0)
lb   $4, 16($0)
lbu  $5, 16($0)
sw   $4, 20($0)
sw   $5, 24($0)
sh   $3, 28($0)
lh   $4, 28($0)
lhu  $5, 28($0)
sw   $4, 32($0)
sw   $5, 36($0)




