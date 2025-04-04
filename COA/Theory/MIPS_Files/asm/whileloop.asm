.data
msg: .asciiz "\nNumber: "

.text
.globl main
main:
    # Initialize counter (i = 1)
    li $t0, 1          # $t0 = i (counter = 1)

loop_condition:
    # Check if i <= 5
    li $t1, 5          # Load 5 into $t1
    bgt $t0, $t1, end_loop  # if i > 5, exit the loop

    # Print number (text)
    li $v0, 4           # syscall for print_string
    la $a0, msg         # load address of msg into $a0
    syscall             # execute syscall to print the string

    # Print the value of i (number)
    li $v0, 1           # syscall for print_int
    move $a0, $t0       # move i (counter) into $a0 for printing
    syscall             # execute syscall to print the number

    # Increment counter i (i = i + 1)
    addi $t0, $t0, 1    # $t0 = $t0 + 1 (i++)

    # Go back to the loop condition
    j loop_condition

end_loop:
    # Exit program
    li $v0, 10          # syscall code for program exit
    syscall
