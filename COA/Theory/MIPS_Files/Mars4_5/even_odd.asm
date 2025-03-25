addi $t0, $zero, 10021   # $t0 = 10021 (number to check)
addi $t1, $zero, 1       # $t1 = 1 (for AND operation)
and  $t8, $t0, $t1       # $t8 = $t0 & $t1 (extract LSB)
beq  $t8, $zero, lbleven # If $t8 == 0, jump to lbleven (Even case)

	addi $s0, $zero, 2       # If Odd, set $s0 = 2
    	j exit_              # Jump to exit

lbleven:
    addi $s0, $zero, 1   # Set $s0 = 1 for even
    j exit_              # Jump to exit

exit_:
