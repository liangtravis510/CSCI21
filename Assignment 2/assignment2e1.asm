#
# assignment2e1.asm
#
# Travis Liang
# 2/20/2022
# CS21 Assignment 2
#
# This program adds up the integers as given
# in Exercise 1, leaving the answer in register $t0.
#


	.data				# data declaration
	.text



main:

	li	$t0 456			# pseudoinstruction turned into an ORI instruciton
	li	$t1 -229		# LUI then ORI
	li	$t2 325			# ORI
	li	$t3 -552		# LUI then ORI. All can be found in Qtspim text tab
	
	addu	$t0, $t0, $t1		

	addu	$t0, $t0, $t2

	addu 	$t0, $t0, $t3		# Result of zero placed in $t0

	li $v0, 10			# exit program
	syscall	

# END OF PROGRAM	