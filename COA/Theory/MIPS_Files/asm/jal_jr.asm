main:
li $t0 , 5
li $t1 , 15
jal add_number
move $s0 , $v0

add_number:
add $v0 ,$t0 ,$t1
jr $ra
