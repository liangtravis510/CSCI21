#
# lab4ex2.asm
#
# Travis Liang, Kyle Yu
# Date: 3/1/2022
# if else statement translation
#

	.data
	.text
	.globl main

main:
	li	$t0, 0
	li	$t1, 0

	bgt	$t0, $t1, else
	li	$t1, 10
	b	exit

else:
	li	$t0, 20
exit:
	li	$v0, 10
	syscall

# End of file