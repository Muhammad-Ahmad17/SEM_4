addi $2, $0, 0        # $2 = 0           ; sum = 0
addi $3, $0, 1        # $3 = 1           ; counter = 1
addi $4, $0, 5        # $4 = 5           ; limit = 5

loop:
add  $3, $2, $3       # $2 = $2 + $3     ; sum = sum + counter
addi $3, $3, 1        # $3 = $3 + 1      ; counter = counter + 1
sub  $4, $3, $4       # $4 = $3 - $4     ; temp = counter - limit
beq  $4, $0, exit     # if temp == 0, exit loop
j    loop             # jump to loop

exit:
sw   $2, 0($0)        # store sum at memory[0]
lw   $5, 0($0)        # load sum into $5
sll  $6, $5, 2        # $6 = $5 << 2     ; sum * 4
sw   $6, 4($0)        # store result at memory[1]
nop
nop
