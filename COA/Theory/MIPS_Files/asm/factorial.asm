fact:
	# allocating space on stack
    addi $sp, $sp, -8            # Make space on stack
    sw   $ra, 4($sp)             # Save return address
    sw   $a0, 0($sp)             # Save n

    li	  $s0 , 2                # s0 = 2
    ble  $a0, $s0 , base_case    # if n <= 1 → also return 1 (optional)

    jal  recursive_case          # handle recursion separately

	# deallocating space from stack
    lw   $a0, 0($sp)             # restore n
    lw   $ra, 4($sp)             # restore return address
    addi $sp, $sp, 8             # clean up stack
    jr   $ra                     # return

# the resultant factorial store in $vo

base_case:
    li   $v0, 1                  # return 1
    addi $sp, $sp, 8             # deallocating in base case too
    jr   $ra                     # return
	
recursive_case:
    addi $a0, $a0, -1            # n = n - 1
    jal  fact                    # call fact(n - 1)

    lw   $t0, 0($sp)             # load original n from stack
    mul  $v0, $t0, $v0           # n * fact(n - 1)
    jr   $ra                     # return to fact, not main
