#
# assignment2e2.asm
#
# Travis Liang
# 2/20/2022
# CS21 Assignment 2
#
# This program performs shifting and adding
# as explained in Exercise 2 instruction
#


	.data
	.text

main:

	ori	$t0, $zero, 0

	addiu	$t0, $t0, 0x1000	# 0x10000 will display in $t0.
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000

	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000

	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000

	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000
	addiu	$t0, $t0, 0x1000

	#
	# This part of the program initilizes
	# $t1 to 0x1000 and uses SLL to produce
	# the same bit pattern as $t0
	#

	ori	$t1, $zero, 0x1000
	sll	$t1, $t1, 4

	#
	# This part of the program initilizes
	# $t2 to 0x1000 and adds $t2 to itself an appropriate amount
	# to produce the same bit pattern as $t0
	#

	ori	$t2, $zero, 0x1000
	addu	$t2, $t2, $t2
	addu	$t2, $t2, $t2
	addu	$t2, $t2, $t2

	li $v0, 10			# exit program
	syscall	

# END OF PROGRAM