# Calculate C(n,r)
.data
    string: .asciiz "\n[ ERROR ] n must be greater than or equal to r. "
	msg1: .asciiz "\n This program calculates the total outcomes of an event C(n, r),  where order of events does not matter.\n\nn =  "
	msg2: .asciiz "\nr = "
    msg3: .asciiz "\nn! = "
    msg4: .asciiz "\nr! = "
    msg5: .asciiz "\nn - r = "
    msg6:     .asciiz "\nr!(n - r)! = "
    msg7:      .asciiz "\nn!/(r!(n - r)!) = "

.text

	li $v0,  4 # print msg1
	la $a0,  msg1
	syscall

    li $v0,  5 # read n = s0
    syscall
    move $s0, $v0 

	li $v0,  4 # print msg1
	la $a0,  msg2
	syscall

    li $v0,  5 # read r = s1
    syscall
    move $s1, $v0 

    blt $s0, $0, is_negative 
    blt $s1, $0, is_negative 
    blt $s0, $s1, is_negative 
   
    move $a0, $s0
    jal factorial # calc n! = t3
    move $t3, $v0 

    la $a0, msg3 # print n! = t3
    li $v0, 4 
    syscall
    li $v0, 1 
    move $a0, $t3
    syscall


    move $a0,$s1
    jal factorial # calc r! = t5
    move $t5, $v0

    la $a0, msg4 # print r! = t5
    li $v0, 4 
    syscall
    li $v0, 1
    move $a0, $t5
    syscall

    sub $s2, $s0, $s1 # calc n - r = s2
    
    li $v0, 4 # print n - r = s2
    la $a0, msg5
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    
    move $a0, $s2
    jal factorial # calc (n - r)! = t3
    move $t4, $v0 


    mul $s3, $t4, $t5 # calc r!(n - r)! = s2 * t3
 
    li $v0, 4 # print n - r! = s2
    la $a0, msg6
    syscall
	li $v0,1
	move $a0, $s3
	syscall

    div $t1, $t3, $s3  # calc  n!/(r!(n - r!))

    li $v0, 4 # print n!/(r!(n - r!))
    la $a0, msg7
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 10  # exit
    syscall


    is_negative: # check if n is less than r 
        la $a0, string 
        li $v0, 4
        syscall
        li $v0, 10 # exit
        syscall

    factorial:
        addiu $sp,  $sp, -8 
        sw $a0, 4($sp) 
        sw $ra, 0($sp)
        addiu $t0, $0, 2
        slt $t0, $a0, $t0 
        beq $t0, $0, else
        addiu $v0, $0, 1 
        addiu $sp, $sp, 8 
        jr $ra 

    else:
        addi $a0, $a0 -1 
        jal factorial 
      
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8
        mul $v0, $a0, $v0 

    jr $ra 

