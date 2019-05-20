# Jason Durant
# add6.s - add six arguments

.data
    int1: .word 1
    int2: .word 2
    int3: .word 3
    int4: .word 4
    int5: .word 5
    int6: .word 6

.text
    .globl main

    main:
        lw $a0, int1
        lw $a1, int2
        lw $a2, int3, 
        lw $a3, int4
        
        lw $t0, int5
        lw $t1, int6
        sw $t0, 16($sp)
        sw $t1, 20($sp)
        jal add6
        
        move $a0, $v0
        li $v0, 1
        syscall

    li $v0 10
    syscall


    add6:
        add $a0, $a0, $a1
        add $a0, $a0, $a2
        add $a0, $a0, $a3
        lw $t0, 16($sp)
        add $a0, $a0, $t0
        lw $t1, 20($sp)
        add $a0, $a0, $t1
        sw $a0, 0($sp)

        lw $v0, 0($sp)
        jr $ra
