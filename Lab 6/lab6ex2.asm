#
# lab6ex2.asm
#
# Travis Liang, Kyle Yu
# Date: 4/14/2022
# 
# Program calls square function which calls Triangle
# twice using frame based linkage convention
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
	jal	Square	
	nop

	move	$a0, $v0		
	li	$v0, 1			# print result
	syscall
	
	li	$v0, 10			# exit
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
	addiu	$sp, $fp, 0		# $sp = $fp + space_for_variables
	lw	$s1, ($sp)		# pop $s1
	addiu	$sp, $sp, 4		
	lw	$fp, ($sp)		# pop $fp
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# pop $ra
	addiu	$sp, $sp, 4
	jr	$ra
	nop


Square:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)		# push return address
	addiu	$sp, $sp, -4		
	sw	$fp, ($sp)		# push frame pointer
	addiu	$sp, $sp, -4
	sw	$s0, ($sp)		# push $s0
	addiu	$fp, $sp, -8		# $fp = $sp + space_for_variables	
	move	$sp, $fp		# $sp = $fp

					# Base Case
	move	$s0, $a0		# $s0 = n
	li	$s1, 1			
	bgt	$s0, $s1, doIf	
	nop

	li	$v0, 1
	b	epilog2
	nop

doIf:
	jal	Triangle		
	nop
	move	$t2, $v0
	sw	$t2, ($fp)		# b = Triangle(n)

	addiu	$a0, $s0, -1		# compute n - 1
	lw	$t2, ($fp)		

	jal	Triangle
	nop	
	move	$t3, $v0
	sw	$t3, 4($fp)		# c = Triangle(n - 1)

	lw	$t3, 4($fp)

	addu	$v0, $t2, $t3		# $v0 = b + c

	b	epilog2
	nop

epilog2:
	addiu	$sp, $fp, 8		# $sp = $fp + space_for_variables
	lw	$s0, ($sp)		# pop $s1
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)		# pop $fp
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# pop $ra
	addiu	$sp, $sp, 4
	jr	$ra			# return to caller
	nop
	

# END OF PROGRAM
	

