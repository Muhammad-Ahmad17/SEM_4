.data
x: .word 0        # reserve a word for variable x

.text
.globl main
main:
    # Initialize a and b
    li $t0, 5          # a = 5
    li $t1, 10         # b = 10

    # if (a < b)
    blt $t0, $t1, if_block

else_block:
    li $t2, 2          # x = 2
    sw $t2, x          # store x into memory
    j end_if           # jump to end of if-else

if_block:
    li $t2, 1          # x = 1
    sw $t2, x          # store x into memory

end_if:
    # Load x and print it
    lw $a0, x          # load x into $a0
    li $v0, 1          # syscall code for print_int
    syscall

    # Exit
    li $v0, 10
    syscall



#############################################################################
#if (a < b) {
#    x = 1;
#} else {
#    x = 2;
#}
