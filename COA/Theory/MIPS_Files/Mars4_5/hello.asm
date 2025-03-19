	# Simple MIPS Program to Print "Hello, World!"
.data
message: .asciiz "Hello, World!\n"  # Define string in data segment

.text
.globl main
main:
    li $v0, 4         # Load syscall code for print_string
    la $a0, message   # Load address of the string
    syscall           # Make system call to print

    li $v0, 10        # Load syscall code for exit
    syscall           # Exit program
