.data
.text
.globl main
main:
    addi $t1, $zero, 1
    addi $t2, $zero, 2
    # Instruction 1
    nop

    #distance of 2 (from $t2 write to read)
    add $zero, $t1, $t2

    # Instruction 1
    nop
    #distance of 2 (from $zero write to read)
    add $zero, $t1, $zero

    halt

