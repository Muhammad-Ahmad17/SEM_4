###########################
.data
even_msg: .asciiz "Even\n"
odd_msg:  .asciiz "Odd\n"


.text
.globl main
main:
    # --- Get input from user ---
    li $v0, 5          # syscall for read_int
    syscall
    move $t0, $v0      # store input in $t0

    # --- Check if even ---
    li $t1, 2
    rem $t2, $t0, $t1  # $t2 = $t0 % 2

    beq $t2, $zero, is_even  # if remainder == 0 ? even
    j is_odd                 # else ? odd /jump

is_even:
    li $v0, 4 		  # syscall for printing a string
    la $a0, even_msg
    syscall
    j exit		# j = jump

is_odd:
    li $v0, 4		# syscall for printing a string
    la $a0, odd_msg
    syscall

exit:
    li $v0, 10		# syscall for program exit
    syscall
