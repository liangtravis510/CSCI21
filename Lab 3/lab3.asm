#
# lab3.asm
#
# Travis Liang, Kyle Yu, Dylan Olivares
# 02/14/2022
# 
# Program to evaluate polynomial using Horner's method, 4x^3 + 2x^2 - 5x + 3
#
# Horner's: x(x(4x + 2)- 5) + 3

	.data				# Symbolic addressing begins at 0x10010000
x:	.word 1				# x at 0x10010000, can change initlized interger to any value
y:	.word 0				# answer at 0x10010004
promptResult:	.asciiz "The result = "

	.text
	.globl	main
main:
	lw	$t1, x			# $t1 = x, begin load delay
	
	ori	$t2, $zero, 4
		
	multu	$t1, $t2		# $t2 = 4x + 2
	mflo	$t2

	addiu	$t2, $t2, 2
	or	$0, $0, $0

	
	multu	$t1, $t2		# $t2 = x(4x + 2)- 5
	mflo	$t2

	addiu	$t2, $t2, -5
	or	$0, $0, $0

	multu	$t1, $t2		# $t2 = x(x(4x + 2)- 5) + 3
	mflo	$t2

	addiu	$t2, $t2, 3
	sw	$t2, y			# Final result is in "answer", end delay slot

	li	$v0, 4			# Print ASCII: The result = 
	la 	$a0, promptResult	
	syscall

	li 	$v0, 1			# Prints value of polynomial
	move	$a0, $t2
	syscall
	
	li $v0, 10			# exit program
	syscall	

# END OF FILE