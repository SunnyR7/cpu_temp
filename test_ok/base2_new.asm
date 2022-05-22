.data 0x0000
	buf: .word 0x0000 # 0
	order: .word 0x100000 # 4 
	first: .word 0x100000  # 8
	second: .word 0x300000  # 12
	third: .word 0x500000 # 16
	fourth: .word 0x700000 #20
	fifth: .word 0x900000 #24
	sixth: .word 0xB00000 #28
	seventh: .word 0xD00000 #32
	eighth: .word 0xF00000 #36
	c0: .word 0x80000 #40
	c1: .word 0x40000 #44
	c2: .word 0x8000 #48
	c3: .word 0x4000 # 52
	c4: .word 0x2000 # 56
	c5: .word 0x1000 # 60
	c6: .word 0x800 #64
	c7: .word 0x400 #68
	c8: .word 0x200 #72
	c9: .word 0x100 #76
	c1_0: .word 0x300 #80
.text 0x0000

start:
	lui $4, 0xFFFF
	ori $28, $4, 0xF000
	lw $5, 0xC70($28) 
	andi $27, $27, 0x0000
	lw $26, 4($27)
	and $6, $5, $26 
	beq $6, $26, cs
	j start


cs: 


	lw $6, 8($27)
	beq $6, $5, Q1
	lw $6, 12($27)
	beq $6, $5, Q2
	lw $6, 16($27)
	beq $6, $5, Q3
	lw $6, 20($27)
	beq $6, $5, Q4
	lw $6, 24($27)
	beq $6, $5, Q5
	lw $6, 28($27)
	beq $6, $5, Q6
	lw $6, 32($27)
	beq $6, $5, Q7
	j Q8

Q1:
	lw $22, 0($27)
	sw $22, 0xC60($28)
	
	lw $5, 0xC70($28) 
	lw $7, 40($27)
	and $8, $7, $5
	beq $8, $7, num
j Q1

num:
	xor $25, $5, $7
	lw $24, 0($27)
	add $24, $24, $25
	lw $22, 0($27)
	addi $21, $22, 44
	addi $20, $22, 84
	addi $19, $22, 84


read:

	beq $24, $22, start

wait:	
	lw $5, 0xC70($28)
	lw $7, 0($21)
	and $8, $7, $5
	beq $8, $7, write
	j wait
write:
	addi $24, $24, -1
	xor $5, $5, $7
	sw $5, 0($20)
	addi $20,$20, 4
	addi $21,$21, 4
	sw $5, 0xC60($28)
	j read

Q2:

	sw $25, 0xC60($28)

	addi $18, $20,0 
	addi $17, $19, 0

fuzhi1:

	beq $24, $25, maol
	addi $24, $24, 1
	lw $16, 0($17)
	sw $16, 0($18)
	addi $18, $18, 4
	addi $17, $17, 4
	j fuzhi1

maol:
	
	add $13, $18, $22

mao:
	beq $24, $22, start
	addi $24, $24, -1
	
	add $17, $20, $22
	addi $18, $25, -1
xiaomao:	beq $18, $22, mao
	addi $17, $17, 4
	addi $18, $18, -1
	lw $16, -4($17)
	lw $15, 0($17)
	sltu $14, $16, $15
	bne $14, $22, xiaomao
	sw $16, 0($17)
	sw $15, -4($17)
	j xiaomao

	
j start
Q3:
	lw $22, 0($27)
	sw $22, 0xC60($28)

	add $17, $19, $22
	add $18, $13, $22
	add $24, $22, $25
Q3Z:
	beq $24, $22, start
	addi $24, $24, -1
	lw $16, 0($17)
	
	ori $15, $22, 0x80
	sltu $14, $15, $16
	bne $14, $22, bian
	sw $16, 0($18)
	addi $18, $18, 4
	addi $17, $17, 4
	j Q3Z

bian:
	addi $14, $22, 0x7F
	xor $16, $16, $14
	addi $16, $16, 1
	sw $16, 0($18)
	addi $18, $18, 4
	addi $17, $17, 4
	j Q3Z
j start
Q4:

	
	
	addi $9, $18, 0
	addi $2, $18, 0
	addi $17, $13, 0
	addi $24, $22, 0

zhifu:
	beq $24, $25, map
	addi $24, $24, 1
	lw $16, 0($17)
	sw $16, 0($2)
	addi $2, $2, 4
	addi $17, $17, 4
	j zhifu


map:
	add $1, $0, $2 
	
mc:
	beq $24, $0, start 
	addi $24, $24, -1 
	
	add $17, $9, $22
	addi $4, $25, -1 
xiao:	beq $4, $22, mc 
	addi $17, $17, 4
	addi $4, $4, -1
	lw $16, -4($17)
	lw $15, 0($17)
	addi $11,$0,0x80
	sltu $14,$16,$11 
	bne $14, $0, zheng
	sltu $14,$15,$11 
	bne $14, $0, xiao
	sltu $14,$15,$16
	bne $14, $0, change
	j xiao

zheng:
	sltu $14,$15,$11 
	beq $14, $0, change
	sltu $14,$15,$16
	bne $14, $0, change
	j xiao

change:
	sw $16, 0($17)
	sw $15, -4($17)
	j xiao
j start


Q5:
	
	lw $22, 0($27)
	sw $22, 0xC60($28)

	lw $17, -4($13)
	lw $18, 0($20)
	sub $15, $17, $18
	sw $15, 0xC60($28)

j start
Q6:
	
	lw $22, 0($27)
	sw $22, 0xC60($28)

	lw $17, -4($1)
	lw $18, 0($9)
	sll $17, $17, 24
	sll $18, $18, 24
	sub $15, $17, $18
	srl $15, $15, 24

	addi $17, $0, 0xFF
	and $15, $15, $17

	sw $15, 0xC60($28)
j start
Q7:
	lw $22, 0($27)
	sw $22, 0xC60($28)
	
	lw $4, 0xC70($28)
	lw $7, 40($27)
	and $8, $7, $4
	beq $8, $7, check7
	j Q7
check7:
	xor $4, $4, $7
	add $17, $22, $22
	lui $17, 0xE0
	and $16, $4, $17
	xor $4, $4, $16
	lui $17, 0x20
	beq $17, $16, diyige
	lui $17, 0x40
	beq $17, $16, dierge
	j disange


diyige:
	add $16, $22, $20
	add $17, $22, $22
f1:	beq $17, $4, yicheck
	addi $17, $17, 1
	addi $16, $16, 4
	j f1
yicheck:
	lw $16, 0($16)
	sw $16, 0xC60($28)
j start

dierge:
	add $16, $22, $13
	add $17, $22, $22
f2:	beq $17, $4, ercheck
	addi $17, $17, 1
	addi $16, $16, 4
	j f2
ercheck:
	lw $16, 0($16)
	sw $16, 0xC60($28)
j start

disange:
	add $16, $22, $9
	add $17, $22, $22
f3:	beq $17, $4, sancheck
	addi $17, $17, 1
	addi $16, $16, 4
	j f3
sancheck:
	lw $16, 0($16)
	sw $16, 0xC60($28)
j start
Q8:
	lw $22, 0($27)
	sw $22, 0xC60($28)
	
	lw $4, 0xC70($28)
	lw $7, 40($27)
	and $8, $7, $4
	beq $8, $7, check8
	j Q8

check8:
	xor $4, $4, $7
	add $16, $22, $19
	add $17, $22, $22
Q8I:	beq $17, $4, go8
	addi $17, $17, 1
	addi $16, $16, 4
	j Q8I
go8:
	
	add $11, $22, $22
	add $11, $16, $11
	add $17, $22, $22
	add $16, $22, $22
	add $15, $22, $22
	add $14, $22, $22
	add $12, $22, $22
	lui $10, 0x23F

round2:
	beq $15, $10, rr
	addi $15, $15, 1
	j round2	
rr:
	
	sw $4, 0xC60($28)

round3:
	beq $14, $10, ss
	addi $14, $14, 1
	j round3
ss:

	lw $16, 0($11)
	sw $16, 0xC60($28)


round1:
	beq $17, $10, tt
	addi $17, $17, 1
	j round1

tt:
	addi $17, $0, 2
	sw $17, 0xC60($28)

	addi $14, $0, 0
round4:
	beq $14, $10, ff
	addi $14, $14, 1
	j round4
ff:
	sw $4, 0xC60($28)
	addi $14, $0, 0
round5:
	beq $14, $10, exit
	addi $14, $14, 1
	j round5

exit:
	add $17, $22, $22
	add $16, $22, $13
Q8P: beq $17, $4, goo
	addi $17, $17, 1
	addi $16, $16, 4
	j Q8P
goo:
	lw $16, 0($16)
	sw $16, 0xC60($28)
j start
	
	
	
	
	
	
	