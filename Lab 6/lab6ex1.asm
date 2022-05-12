#
# lab6ex1.asm
#
# Travis Liang, Kyle Yu
# Date: 4/14/2022
# 
# Program computes result of function
# int Triangle(n) using frame based
# linkage convension
#
	.data
pmt:	.asciiz	"Enter an integer n: "
nl:	.asciiz	"\n"

	.text
	.globl main

main:
	li	$v0, 4
	la	$a0, pmt
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0		# $s0 = n

	move	$a0, $s0		# $a0 = n
	jal	Triangle	
	nop

	move	$a0, $v0
	li	$v0, 1
	syscall
	
	li	$v0, 10
	syscall

Triangle:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)		# push return address
	addiu	$sp, $sp, -4		
	sw	$fp, ($sp)		# push frame pointer
	addiu	$sp, $sp, -4
	sw	$s1, ($sp)		# push $s1
	addiu	$fp, $sp, 0		# $fp = $sp + space_for_variables	
	move	$sp, $fp		# $sp = $fp


					# Base Case
	move	$s1, $a0		
	li	$t0, 1			
	bgt	$s1, $t0, recur		# if (n <=1 )
	nop

	move	$v0, $t0
	b	epilog
	nop

recur:
	addiu	$a0, $s1, -1
	jal	Triangle
	nop
	
	addu	$v0, $v0, $s1		# n + Triangle(n-1)

epilog:
	addiu	$sp, $fp, 0
	lw	$s1, ($sp)
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop


# END OF PROGRAM