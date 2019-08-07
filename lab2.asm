# Sort integers
.data
    vals: .space 4000
    msg_loop: .asciiz "\nPlease enter an integer, then type 9999 to start sorting: "
    msg_out: .asciiz "\nThe sorted array is:"
    line: .asciiz "\n"

.text
.globl main
    main:
        la $a1, vals 
        li $a2, 9

        li $t0, 0
        li $t1,9999
    loop:

        la $a0, msg_loop
        li $v0, 4
        syscall
        li $v0, 5
        syscall
        beq $v0,$t1,sort
        addi $t0,$t0,4
        sw $v0, ($a1)
        addi $a1, $a1, 4
        j loop

    sort:

        la $t4, vals 
        la $t1, vals 
        addi $t1,$t1,4
        la $t8,vals
        add $t8,$t0,$t8
        la $t9,vals
        add $t9,$t0,$t9
        addi $t9,$t9,-4
    loops: 
        lw $t2,($t4) 
        lw $t3,($t1) 
        blt $t2,$t3,next 
        sw $t3,($t4)
        sw $t2,($t1)
    next: 
        addi $t1,$t1,4
        blt $t1,$t8,loops 
        addi $t4,$t4,4 
        move $t1,$t4
        addi $t1,$t1,4
        blt $t4,$t9,loops 

    print_out:
        la $a1,vals

        la $a0, msg_out
        li $v0, 4
        syscall
        loop1:
        blez $t0, done
        li $v0, 1
        lw $a0, 0($a1)
        syscall
        la $a0, line
        li $v0, 4
        syscall
        addi $a1, $a1, 4
        addi $t0, $t0, -4
        j loop1
    done:
        j done