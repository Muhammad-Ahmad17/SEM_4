
.data 
	a : .word 10
	b : .word 15
	c : .word 20
	
.text
	lw $t0,a
	lw $t1,b
	lw $t2,c
	
	add $s0,$t0,$t1
	sub $s1,$s0,$t2
	
	
	lw $v0,1
	lw $a0,($s1)
	syscall