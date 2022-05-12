#
# arraySum.asm
#
#
# Keith Mehl
# 4/18/22
# CS-21 example program
#
# illustrate a recursive subroutine to return the sum of
# the first n elements of an array. For simplicity the array
# is fixed and the number of elements is required to be less than 21
# subroutine takes the base of the current array and the number
# of elements remaining in the array
#
	.text
	.globl	main
main:	li	$v0, 4		# prompt use for size
	la	$a0, prmpt
	syscall
	li	$v0, 5
	syscall
	li	$s0, 21		# if illegal entry, give up
	ble	$s0, $v0, error	# print an error message
	nop			# and give up
	li	$s0, 0
	bge	$s0, $v0, error
	nop
	addiu	$sp, $sp, -4	# push parameters
	la	$s0, array
	sw	$s0, ($sp)	# first, base of array
	addiu	$sp, $sp, -4
	sw	$v0, ($sp)	# second, number of elements to sum
	jal	sumIt
	nop
	addiu	$sp, $sp, 8	# pop parameters
	move	$s0, $v0	# save sum someplace safe
	li	$v0, 4
	la	$a0, summsg
	syscall
	move	$a0, $s0	# print result
	li	$v0, 1
	syscall
done:	li	$v0, 10		# end program
	syscall

error:	li	$v0, 4		# error message, give up
	la	$a0, ermsg
	syscall
	j	done
	nop

# sumIt subroutine register use
# $t0 holds base of (rest of) array
# $t1 holds number of elements (remaining) to sum
sumIt:	addiu	$sp, $sp, -4	# push $ra and $fp
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	move	$fp, $sp	# no local variables
	lw	$t0, 12($fp)	# base of array
	lw	$t1, 8($fp)	# num remaining elements to sum
	li	$v0, 0		# use $v0 here so I don't have to set $v0 later
	ble	$t1, $v0, eplog	# base case, nothing else to add in
	nop
	addiu	$t0, $t0, 4	# next element is at new base
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# base of rest of array
	addiu	$t1, $t1, -1	# one fewer element to sum
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)	# number of elements remaining
	jal	sumIt		# recursive call
	nop
	addiu	$sp, $sp, 8	# pop both recursive call parameters
	lw	$t0, 12($fp)	# reload base of array
	nop
	lw	$t2, ($t0)	# get the element at the base
	nop
	addu	$v0, $v0, $t2	# add them up
eplog:	lw	$fp, ($sp)
	addiu	$sp, $sp, 4	# pop $fp and $ra
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

	.data
array:	.word	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
prmpt:	.asciiz	"Enter 1 <= n <= 20 "
summsg:	.asciiz	"\nsum is "
ermsg:	.asciiz	"\nError - enter a legal value\n"


