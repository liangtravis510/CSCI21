#
# assignment4E1.asm
#
# Travis Liang
# 03/28/2022
# CS21 Assignment 4 Exercise 1
#
# This program converts a string to all lowercase characters
# assuming a given string of all uppercase characters.
#

		.data
string:	.asciiz "ABCDEFG"
nL:		.asciiz "\n"

		.text
		.globl main


main:
	li	$v0, 4
	la	$a0, string
	syscall

	la	$t0, string

while:
	lbu	$t1, ($t0)
	nop
	beq	$t1, $zero, end
	nop
	addiu	$t1, $t1, 0x20
	sb	$t1, ($t0)
	addiu	$t0, $t0, 1
	j 	while
	nop

end:
	li	$v0, 4
	la	$a0, string
	syscall

	li	$v0, 10
	syscall

# End of Program
	