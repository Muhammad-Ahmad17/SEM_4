.text
.globl main

main:
    # Load values into registers using addi (no pseudo-instructions)
    addi $t0, $zero, 5   # $t0 = 5
    addi $t1, $zero, 3   # $t1 = 3

    # Perform addition
    add  $t2, $t0, $t1   # $t2 = $t0 + $t1

    # End program (exit syscall)
    addi $v0, $zero, 10  # Exit syscall number
    syscall
