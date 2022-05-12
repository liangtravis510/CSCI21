		.data
prompt: 	.asciiz "Enter an integer :  "
result:	.asciiz "product :"

		.text
		.globl main
main:
	la	$a0, prompt
	jal	getInt
	nop
	move	$s0, $v0

	la	$a0, prompt
	jal	getInt
	nop
	move	$a1, $v0
	move	$a0, $s0
	jal	calc
	nop

	move	$a0, $v0



getInt: 	
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	jr	$ra
	nop

calc: 	
	mult	$a0, $a1
	mflo	$v0
	jr	$ra
	nop

prtRes:
	move	$t0, $a0
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 5
	syscall