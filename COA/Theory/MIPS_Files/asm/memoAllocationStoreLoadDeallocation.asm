.data
.text
.globl main

main:
    # Step 1: Set up the stack pointer
    addi $sp, $sp, -4      # Allocate 4 bytes on stack (stack grow downward) 

    # Step 2: Put a value into a register
    li $t0, 42             # Load immediate value 42 into $t0

    # Step 3: Store that value on the stack
    sw $t0, 0($sp)         # Store word at top of stack  {offset is 0}

    # Step 4: Load the value back from the stack
    lw $t1, 0($sp)         # Load word into $t1 from stack

    # Step 5: Clean up stack
    addi $sp, $sp, 4       # Deallocate the 4 bytes

    # Exit program
    li $v0, 10
    syscall
