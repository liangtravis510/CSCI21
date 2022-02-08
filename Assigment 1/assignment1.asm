#
# assignment1.asm
# 
# Travis Liang
# Date: 2/5/2022
# CS21 Assignment 1
#

	.data
	.text
main:
	#
	# Start with the given pattern and use only
	# shift logical instructions and register to
	# register instructions to place the solution
	# in 0x99999999  into $t1.
	#

	ori	$t0, $zero, 0x01 	# $t0 = 1
	sll 	$t1, $t0, 3		# $t1 = 0x8
	or	$t2, $t1, $t0		# $t2 = 0x9
	sll	$t0, $t2, 4		# $t0 = 0x90
	or 	$t1, $t0, $t2		# $t1 = 0x99
	sll 	$t0, $t1, 8		# $t0 = 0x9900
	or	$t2, $t0, $t1		# $t2 = 0x9999
	sll	$t1, $t2, 16		# $t1 = 0x99990000
	or	$t1, $t1, $t2		# $t0 = 0x99999999

	#
	# Start with the given pattern and use only
	# shift logical instructions and register to
	# register instructions to place the solution
	# in 0xA5A5A5A5  into $t1.
	#
	
	ori	$t0, $zero, 0x01 	# $t0 = 0x01
	sll	$t1, $t0, 2		# $t1 = 0x04
	or 	$t2, $t1, $t0		# $t2 = 0x05
	sll	$t0, $t2, 5		# $t0 = 0xA0
	or	$t1, $t0, $t2		# $t1 = 0xA5
	sll	$t2, $t1, 8		# $t2 = 0xA500
	or	$t0, $t2, $t1		# $t0 = 0xA5A5
	sll	$t2, $t0, 16		# $t2 = 0xA5A50000
	or 	$t1, $t2, $t0		# $t1 = 0xA5A5A5A5

	#
	# Start with the given pattern and use only
	# shift logical instructions and register to
	# register instructions to place the solution
	# in 0xFFFFFFFF into $t1.
	#
	
	ori	$t0, $zero, 0x01 	# $t0 = 0x01
	nor	$t2, $t0, $t0,		# $t2 = 0xFFFFFFFE
	or	$t1, $t2, $t0 		# $t1 = 0xFFFFFFFF

	#
	# Exit the program.
	# Found in http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
	#
	ori	$v0, $zero, 0xA		# $v0 = 10
	syscall

# end of program
	
	

	