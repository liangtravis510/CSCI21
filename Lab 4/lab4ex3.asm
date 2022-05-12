#
# lab4ex3.asm
#
# Travis Liang, Kyle Yu
# Date: 3/1/2022
# while loop translation
#

	.data
	.text
	.globl	main

main:

	li	$t0, 0		# a = 0
	li	$t1, 0		# b = 0

loop:
	bgeu	$t0, 10, exit
	addu	$t1, $t0, $t1	# b += a
	addiu	$t0, $t0, 1	# a++
	b	loop
exit:
	li	$v0, 10		# exit
	syscall

## End of file