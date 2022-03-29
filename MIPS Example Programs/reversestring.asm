#
# reverseString.asm
#
# Keith Mehl
# 10/21/08
# CSCI-21 example program
# Reverse a user-supplied string using the stack, and output the resulting string
# notice the string doesn't appear on the console as it is entered!
#
# Settings: Load delays ON; Branch delays ON, Pseudoinstructions ON   
#
# register use
# $t0 --- character pushed or popped
# $t1 --- index into string buffer str
#

	.data
pr1:	.asciiz	"Enter a string\n"	# prompt
lf:	.asciiz	"\n"			# linefeed
str:	.space	128			# character buffer, bigger than any input

	.text
	.globl  main

main:	li	$v0, 4		# print string service code
	la	$a0, pr1	# address of prompt message
	syscall			# print the string

				# get input string from user
	li	$v0, 8		# read string service code
	la	$a0, str	# address of buffer
	li	$a1, 100	# buffer length ( < 128 size of empty space for string )
	syscall
				# echo-print the string since it's not visible as entered
	li	$v0, 4		# print string service code
	la	$a0, str	# address of string
	syscall
				# initialize the stack:
	addiu	$sp, $sp, -4	# push a NUL byte onto the stack to signal its bottom
	sw	$zero, ($sp)	# remember, always access the stact using words, not bytes!
	li	$t1, 0		# index of first char in str buffer
				# (in load delay slot)

	# loop, pushing each character onto the stack until end of string
pushl:
	lbu	$t0, str($t1)	# get current char into a full word
	nop			# load delay
	beqz	$t0, stend	# NUL byte = end of string
	nop			# branch delay slot
	addiu	$sp, $sp, -4	# push the full word
	sw	$t0, ($sp)	# holding the character onto the stack
	addiu	$t1, $t1, 1	# increment the index into the string
				# (in the store delay slot)
	j	pushl		# loop
	nop			# branch delay slot

				# pop chars from stack back into the buffer
stend:	li	$t1, 0		# index of first byte of str buffer 
popl:
	lw	$t0, ($sp)	# pop a char off the stack
	addiu	$sp, $sp, 4	# adjust $sp in load delay slot
	beqz	$t0, done	# NUL byte means empty stack
	nop			# branch delay slot

	sb	$t0, str($t1)	# store at string[$t1]
	addiu	$t1, $t1, 1	# increment the index (in load delay slot)
	j	popl		# loop
	nop			# branch delay slot

				# print the reversed string
done:	li	$v0, 4		# print string service code
	la	$a0, str	# address of string
	syscall
				# print newline
	li	$v0, 4		# print string service code
	la	$a0, lf		# address of newline atring
	syscall

	li	$v0, 10		# exit program
	syscall

## end of program

