.data
	number1: .word 20
	number2: .word 8
.text 
	lw $s0 , number1		# load word number1 in register $s0
	lw $s1 , number2
	
	sub $t0 , $s0 , $s1  	# $t0 = $s0 subtract $s1  
	 

	move $a0 , $t0
	
