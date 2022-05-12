#
# mid2fib.asm
# solution for programming problem on second midterm
# comments are not required on the midterm
#

	.data
in_str:	.asciiz		"Input a non-negative integer: "
out_str1:
	.asciiz		"\nFibonacci( "
out_str2:
	.asciiz		" ) is: "
usern:	.word	0	# for user entry (you could use a safe register)
fibn:	.word	0	# to store result of fib(n) (again, a register was OK)

	.text
	.globl	main
main:
	li	$v0, 4
	la	$a0, in_str
	syscall
	li	$v0, 5
	syscall
	sw	$v0, usern
	addiu	$sp, $sp, -4
	sw	$v0,($sp)
	jal	Fib
	nop
	addi	$sp, $sp, 4
	sw	$v0, fibn
	la	$a0, out_str1
	li	$v0, 4
	syscall
	lw	$a0, usern
	li	$v0, 1
	syscall
	la	$a0, out_str2
	li	$v0, 4
	syscall
	lw	$a0, fibn
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall

Fib:	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$fp, $sp, -8
	move	$sp, $fp
	lw	$v0, 16($fp)
	li	$t1, 1
	ble	$v0, $t1, epilogue
	nop
	addiu	$v0, $v0, -1
	addiu	$sp, $sp, -4
	sw	$v0, ($sp)
	jal	Fib
	nop
	addiu	$sp, $sp, 4
	sw	$v0, 4($fp)
	lw	$v0, 16($fp)
	nop
	addiu	$v0, $v0, -2
	addiu	$sp, $sp, -4
	sw	$v0, ($sp)
	jal	Fib
	nop
	addiu	$sp, $sp, 4
	sw	$v0, ($fp)
	lw	$t0, 4($fp)
	lw	$t1, ($fp)
	nop
	addu	$v0, $t0, $t1
epilogue:
	addiu	$sp, $sp, 8
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

