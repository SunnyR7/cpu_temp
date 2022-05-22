.data 0x0000
	buf: .word 0x0000 
	co: .word 0x0020 #4
	one: .word 0x80000000 #8
	two: .word 0x0001 #12
	this: .word 0x00100000 #16
	second: .word 0x300000 #20
	third: .word 0x500000 #24
	fourth: .word 0x700000 #28
	fifth: .word 0x900000 #32
	sixth: .word 0xB00000 #36
	seventh: .word 0xD00000 #40
	eighth: .word 0xF00000 #44
	checka: .word 0x80000 #48
	checkb: .word 0x40000 #52
	light: .word 0x20000 #56
	bug: .word 0x800000 #60
	bug2: .word 0x400000 #64
	panduan: .word 0xF00000
	jc: .word 0x0000FFFF
.text 0x0000
start:
	lui $4, 0xFFFF
	andi $27, $27, 0x0000
	ori $28, $4, 0xF000
	lw $5, 0xC70($28)
	lw $26, 16($27)
	and $3, $5, $26
	lw $4, 16($27)
	beq $3, $4, cs
	
j start


cs:
	lw $20, 68($27)
	and $5, $5, $20
	
	lw $6, 16($27)
	beq $6, $5, Q1
	lw $6, 20($27)
	beq $6, $5, Q2
	lw $6, 24($27)
	beq $6, $5, Q3
	lw $6, 28($27)
	beq $6, $5, Q4
	lw $6, 32($27)
	beq $6, $5, Q5
	lw $6, 36($27)
	beq $6, $5, Q6
	lw $6, 40($27)
	beq $6, $5, Q7
	j Q8

Q1:
	lw $1, 0($27)
	sw $1, 0xC60($28)

Q1l: 
	lw $5, 0xC70($28)
	lw $6, 48($27)
	lw $26, 48($27)
	and $3, $5, $26
	beq $3, $6, Q1r
	j Q1l


Q1r: 
	addi $1, $5, 0
	andi $1, $1, 0xFFFF #1存初始值
	addi $2, $1, 0 #用来存移位的
	addi $3, $0, 0 #3存反过来的
	addi $4, $0,1 #每次$2与$4做与存5中，然后5与3加
loop:
	beq $2,$0,ffff
	and $5,$4,$2
	sll $3,$3,1
	add $3,$3,$5
	srl $2,$2,1
	j loop
ffff:
	addi $4,$1,0
	bne $4,$3,okk
	lw $2, 56($27)#加上回文点灯的值
	add $4,$4,$2
okk:
	sw $4, 0xC60($28)
	j start	

Q2:
	lw $1, 0($27)
	sw $1, 0xC60($28)

Q2l:
	lw $5, 0xC70($28)
	lw $6, 48($27)
	lw $26, 48($27)
	and $3, $5, $26
	beq $3, $6, Q2ra
	j Q2l

Q2ra:
	addi $1, $5, 0
	xor $1, $1, $6
	lw $10, 72($27)
	and $1, $1, $10
	sw $1, 0xC60($28)

Q2r:
	
	lw $5, 0xC70($28)
	lw $6, 52($27)
	lw $26, 52($27)
	and $3, $5, $26
	beq $3, $6, Q2rb
	j Q2r

Q2rb:
	addi $2, $5, 0
	xor $2, $2, $6
	lw $10, 72($27)
	and $2, $2, $10
	sw $2, 0xC60($28)
j start

Q3:
	lw $3, 0($27)
	sw $3, 0xC60($28)
	and $3, $1, $2
j show

Q4:
	lw $3, 0($27)
	sw $3, 0xC60($28)
	or $3, $1, $2
j show

Q5:
	lw $3, 0($27)
	sw $3, 0xC60($28)
	xor $3, $1, $2
j show

Q6:
	addi $3,$0,0
	sllv $3, $1, $2
	andi $3, $3, 0xFFFF
j show

Q7:
	lw $3, 0($27)
	sw $3, 0xC60($28)
	srlv $3, $1, $2
j show

Q8:
	add $3, $0,$0
	sll $3, $1, 16
	srav $3, $3, $2
	sra $3, $3, 16
	andi $3, $3, 0xFFFF
j show

show:
	sw $3, 0xC60($28)
j start