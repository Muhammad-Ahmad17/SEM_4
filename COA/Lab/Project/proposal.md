code
```c 
if (a < b) {
    var = 4 * (a + b);
} else {
    var = a + 10;
}
```

code
```asm
# Assembly code implementation of the given logic

lw   $2, 0($1)       # Load a into $2
lw   $4, 1($3)       # Load b into $4

slt  $5, $2, $4      # if a < b {$5 = 1} else {$5 = 0}
beq  $5, $0, ELSE    # if $5 == 0, jump to ELSE

# IF block
add  $6, $2, $4      # $6 = a + b
sll  $6, $6, 2       # $6 = (a + b) * 4
j    END             # Jump to END

ELSE:
addi $6, $2, 10      # $6 = a + 10

END:
sw   $6, 0($7)       # Store var in memory at address in $7
```