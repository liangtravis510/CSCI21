#
# assignment2e5.asm
#
# Travis Liang
# 2/20/2020
# CS21 Assignment 2
#
# This program evaluates the polynomial
# 2x^3 - 3x^2 + 5x + 12, using
# Horner's method.
#
# Horner's: x(x(2x - 3)+ 5)+ 12
#

	.data
x: 	.word	1		# x at 0x10010000
answer:	.word	0		# answer at 0x1001004


	.text

main:

	lui	$t0, 0x1001	# $t0 wil serve as the base register pointer,
	lw	$t1, 0($t0)	# $t1 = x, begin load delay
	
	ori	$t2, $0, 2	# Load in the coefficient 2, end delay
	
	multu	$t1, $t2	# $t2 = 2x,
	mflo	$t2		# begin delay
	
	addiu	$t2, $t2, -3	# $t2 = 2x - 3,
	or	$0, $0, $0	# end delay
	
	multu	$t1, $t2	# $t2 = x(2x - 3),
	mflo	$t2		# begin delay slot
	
	addiu	$t2, $t2, 5	# $t2 = x(2x - 3)+ 5, 
	or	$0, $0, $0	# end delay slot
	
	multu	$t1, $t2	# $t2 = x(x(2x - 3)+ 5),
	mflo	$t2		# begin delay slot
	
	addiu	$t2, $t2, 12	# $t2 = x(x(2x - 3)+ 5)+ 12
	
	sw	$t2, 4($t0)	# Final result is in "answer", end delay slot
	
	li $v0, 10		# exit program
	syscall	

# END OF PROGRAM