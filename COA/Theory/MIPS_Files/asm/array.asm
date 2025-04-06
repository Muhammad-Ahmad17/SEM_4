.data
array:    .space 20         # 5 words = 20 bytes
len:      .word 5
newline:  .asciiz "\n"
prompt:   .asciiz "Enter number: "

.text
.globl main

main:
    la $t0, array           # $t0 = base pointer for storing
    lw $t1, len             # $t1 = array length
    li $t2, 0               # i = 0

# ---------- Input Loop with Auto-Offset ----------
input_loop:
    bge $t2, $t1, done_input

    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read number
    li $v0, 5
    syscall
    move $t3, $v0

    # Store with auto-offset
    sw $t3, 0($t0)
    addi $t0, $t0, 4         # move to next word (offset of 4 added)

    addi $t2, $t2, 1	# increment
    j input_loop

done_input:
    la $t0, array            # reset base pointer to array start
    li $t2, 0                # reset index

# ---------- Output Loop with Auto-Offset ----------
output_loop:
    bge $t2, $t1, end_main

    lw $a0, 0($t0)           # load array[i]
    jal print_num_and_newline

    addi $t0, $t0, 4         # move to next word
    addi $t2, $t2, 1
    j output_loop

end_main:
    li $v0, 10
    syscall

# ---------- submodule ----------
print_num_and_newline:
## printing
    li $v0, 1
    syscall
## writing
    li $v0, 4
    la $a0, newline
    syscall

    jr $ra
