#
# lab5ex1.asm
#
# Travis Liang, Kyle Yu
# Date: 3/27/2022
# Reversing string without copying in another place
# in RAM
#

	.data
str: 	.asciiz "The quick brown fox jumps over a lazy dog\n"
	.text
	.globl main

main:
	# Create 2 pointers, here called s and t (use registers)
	# Set pointer s to the start of the string.
	# Set pointer t to the end of the string, minus the newline (scan for the
	# newline ('\n'), then back up one place).
	# while( s < t )
 	# 	swap *s and *t
 	#	increment s
 	#	decrement t
	# end loop

	# Swap Routine
	# c = *t
	# *t = *s
	# *s = c

	li	$v0, 4
	la	$a0, str
	syscall

	la	$t0, str		# pointer s
	la 	$t1, str		# pointer t

readStr:
	lb	$t2, ($t1)
	li	$t4, 10			# ascii for '\n'
	beq 	$t2, $t4, sub1
	nop
	add 	$t1, $t1, 1
	b	readStr
	nop

sub1:
	sub	$t1, $t1, 1		
	
while:
	bge	$t0, $t1, end		# while (s < t)
	lb	$t2, ($t0)		
	lb	$t3, ($t1)
	sb	$t2, ($t1)
	sb	$t3, ($t0)
	addu	$t0, $t0, 1
	addiu	$t1, $t1, -1
	b	while


end:
	li	$v0, 4
	la	$a0, str
	syscall				# print new reversed string
	
	li	$v0, 10
	syscall

# End of file
	
	
	