#
# lab4ex1.asm
#
# Travis Liang, Kyle Yu
# Date: 3/1/2022
# If statement translation
#

	.data
	.text
	.globl main
main:
	li	$t0, 11			# a = 0
	li 	$t1, 11			# b = 0
	
	bge	$t0, $t1, exit		# if statement
	li	$t1, 10			# b = 10 

exit:
	li	$v0, 10			# exit program
	syscall

# End of file
	