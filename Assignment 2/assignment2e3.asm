#
# assignment2e3.asm
#
# Travis Liang
# 2/20/2022
# CS21 Assignment 2
#
# This program demonstrates difference between
# ADDU and ADD instruction using values given in 
# Exercise 2
#

	.data
	.text

main:

	ori	$t1, $zero, 0x7000
	ori	$t2, $zero, 0x7000

	sll	$t1, $t1, 16		# $t1 = 0x70000000

	addu	$t1, $t1, $t1		# $t1 = 0xE0000000, correct for unsigned
	

	# 
	# Start with given pattern but now add itself using ADD
	#

	sll	$t2, $t2, 16		# t2 = 0x70000000
	add	$t2, $t2, $t2		# t2 = ?
	
	li $v0, 10			# exit program
	syscall	
	
# END OF PROGRAM