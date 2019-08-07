# Write a MIPS Assembly program to accept three numbers from the user and print the largest number.
.data
	msg1: .asciiz "\nThis program takes three integers and returns the largest one.\n Enter the first integer: "
	msg2: .asciiz "Enter the second integer: "
	msg3: .asciiz "Enter the third integer: "
	msg4: .asciiz "The largest integer is: "

.text
	li $v0, 4 # print msg1
	la $a0, msg1
	syscall

	li $v0, 5 # read the first integer to $t0
	syscall
	move $t0, $v0

	li $v0, 4 # print msg2
	la $a0, msg2
	syscall

	li $v0, 5 # read the second integer to $t1
	syscall
	move $t1, $v0
	
	li $v0, 4 # print ms3
	la $a0, msg3
	syscall
	
	li $v0, 5 # read the second integer to $t2
	syscall
	move $t2, $v0

	
	CMP1:
	# the following lines perform this: $t1 = max($t0, $t1)
	bge $t1, $t0, CMP2
	move $t1, $t0

	CMP2:
	# the following lines perform this: $t1 = max($t2, $t1)
	bge $t1, $t2, L1 
	move $t1, $t2

	L1:
	li $v0, 4 #print mg4
	la $a0, msg4 
	syscall
			
	li $v0, 1 #print the larger int number
	move $a0, $t1
	syscall

	li $v0, 10 # system call for exit
	syscall	