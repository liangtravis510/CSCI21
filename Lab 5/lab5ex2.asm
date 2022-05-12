#
# lab5ex2.asm
#
# Travis Liang, Kyle Yu
# Date: 3/27/2022
# 
# The programing processes an array and apply an 
# average filter to it by taking average of of the three indexes;
# j, j+1, j-1
#

	.data
size:	.word 12
array:
	.word 50, 53, 52, 49, 48, 51, 99, 45, 53, 47 , 47, 50
result:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
tab:	.asciiz	"\t"
	.text
	.globl main

main:
	la	$s0, size
	lw	$t0, ($s0)		# $t0 = size
	li	$t5, 11			
	li	$t6, 1

	la	$s1, array		
	lw	$t1, ($s1)		# $t1 = array[0]
	
	la	$s2, result
	lw	$t2, ($s2)		# $t2 = result[0]

	li	$s3, 0			# $s3 = average
	li	$t4, 3			# $t4 = 3 (for dividing)

	or	$t2, $zero, $t1
	sw	$t2, ($s2)
	
	addiu	$s1, $s1, 4
	addiu	$s2, $s2, 4

for:	bge	$t6, $t5, endL		# for (int i = 1; i < 11; i++)
	nop
	
	lw	$t1, ($s1)
	nop
	li	$s3, 0			# $s3 = average

	addu	$s3, $s3, $t1		# average = average + array[i]

	lw	$t1, 4($s1)
	nop
	
	addu	$s3, $s3, $t1		# average = average + array[i - 1]

	
	lw	$t1, -4($s1)
	nop

	
	addu	$s3, $s3, $t1		# average = average + array[i + 1]
	
	div	$s3, $t4
	mflo	$s3

	sw	$s3, ($s2)		# result[i] = average
	
	addiu	$s1, $s1, 4
	addiu	$s2, $s2, 4
	addiu	$t6, $t6, 1
	
	j	for
	nop

endL:
	lw	$t1, 4($s1)
	nop
	sw	$t1, ($s2)
	li	$t6, 0
	la	$s2, result
	
	
forL:	bge	$t6, $t0, exit		# for loop to check result array
	nop
	
	lw	$t2, ($s2)	
	nop
	
	li	$v0, 1
	move	$a0, $t2
	syscall
	
	li	$v0, 4
	la	$a0, tab
	syscall
	
	addiu	$t6, $t6, 1
	addiu	$s2, $s2, 4
	
	j	forL
	nop


exit:
	li	$v0, 10			# exit program
	syscall
		
# END OF PROGRAM
	
	

	
	
	