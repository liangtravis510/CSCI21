#
# assignment2e4.asm
#
# Travis Liang
# 2/20/2022
# CS21 Assignment 2
#
# This program evaluates the expression (x*y)/z
# with the values given in Exercise 4.
#


	.data
	.text

main:

	ori	$t0, $0, 0x0018		# Loading upper 16 bits because
	ori	$t1, $0, 0x0001		# ORI can only hold immediate 16 bits
	ori	$t2, $0, 0x0006

	sll	$t0, $t0, 16		# Shift to preparing loading lower 16 bits
	sll	$t1, $t1, 16		
	sll	$t2, $t2, 16

	ori	$t0, $t0, 0x6a00	# $t0 = 0x00186A00
	ori	$t1, $t1, 0x3880	# $t1 = 0x00013880
	ori	$t2, $t2, 0x1a80	# $t2 = 0x00061A80

	divu	$t0, $t2		# Divide first to maintain significant 
	mflo	$t0			# bits in order to multiply
	or	$0, $0, $0		
	or	$0, $0, $0

	multu	$t0, $t1		# $t2 = 0x0004E200
	mflo	$t2

	
	ori $v0, $0, 0x0a		# Program terminates
	syscall
	
# END OF PROGRAM