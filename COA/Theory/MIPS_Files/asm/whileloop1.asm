.data
newline: .asciiz "\n"

.text
.globl main

main:
    li $t0, 1         # i = 1
    li $t1, 5         # limit = 5

loop:
    bgt $t0, $t1, end_loop  # if i > 5, exit loop

    move $a0, $t0     # move i to $a0 (argument for submodule)
    jal print_num_and_newline  # call submodule

    addi $t0, $t0, 1  # i++

    j loop

end_loop:
    li $v0, 10        # syscall: exit
    syscall

# --------------------------------------
# Submodule: print_num_and_newline
# Expects: number in $a0
# Prints: number followed by newline
# --------------------------------------
print_num_and_newline:
    # Print the number
    li $v0, 1          # syscall: print integer
    syscall

    # Print newline
    li $v0, 4          # syscall: print string
    la $a0, newline    # load newline string
    syscall

    jr $ra             # return to caller
