#
# lab4ex5.asm
#
# Travis Liang, Kyle Yu
# Date: 3/1/2022
# for loop translation
#

	.data

	.text
	.globl	main

main:
	li	$t0, 0		# a = 0
	li	$t1, 0		# b = 0

loop:
	add	$t1, $t0, $t1	# b += a
	addiu	$t0, $t0, 1
	blt 	$t0, 10	loop

	li	$v0, 10
	syscall

## End of file