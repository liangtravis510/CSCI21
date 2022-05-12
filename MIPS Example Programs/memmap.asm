# 
# memMap.asm
# Adapted from Michigan Technical University CS 341 example program
# Memory mapped I/O
# Interrupts used for input
#
# Sample program - count until the user hits a non-space character key
# Turn off delayed loads and branches
# Turn on pseudoinstructions
# Do not load exception file
#
	.data
dnmsg:	.asciiz	"Done!\n"
nl:	.asciiz	"\n"
letter:	.word	0
flag:	.word	0

	.text
	.align	4
	.globl main

main:				# set up (enable) interrupts
	li	$s0, 0x0801 	# set status register (32-bit machine's value)
	# li	$s0, 0x0301 	# set status register (64-bit machine's value)
	mtc0	$s0, $12	# set coprocessor register 12 to interrupt mask
	nop
	li	$s0, 2 		# set receiver control
	sw	$s0, 0xffff0000	# receiver control (enable device interrupt)
	nop
	move	$s0, $zero
loop:
				# increment the counter
	addu	$s0, $s0, 1
				# wait a bit - kill some time
	li	$t0, 250
nop1:
	li	$t1, 250
nop2:
				# the non-existant body of the inner loop
	sub	$t1, $t1, 1	# inner delay loop
	bnez	$t1, nop2
	nop
	sub	$t0, $t0, 1	# outer delay loop
	bnez	$t0, nop1
	nop

	move	$a0, $s0	# print the counter
	li	$v0, 1		# print integer command
	syscall
				# print a newline
	la	$a0, nl
	li	$v0, 4
	syscall

	lw	$t0, flag	# check to see if there has been input
	nop
	beqz	$t0, loop 	# branch on no input to print next value
	nop
				# input is present
	sw	$zero, flag	# clear flag
	nop
	lw	$t0, letter	# ignore space bar, quit on any other
	nop
	andi	$t0, $t0, 0x7F	# mask off unecessary high-order bits
	li	$t1, 0x20 	# ASCII for space is 0x20
	beq	$t0, $t1, loop	# if space, ignore, otherwise exit program
	nop
done:
	la	$a0, dnmsg	# tell user we're done
	li	$v0, 4		# print string
	syscall
	li	$v0, 10
	syscall

#--------------------------------------------

# interrupt handler - uses the kernel segment
# prolog

      #	.ktext	0x80000080	# kernel entry point actual 32-bit MIPS machines
	.ktext	0x80000180	# kernel entry point for 32-bit SPIM simulator
	.set	noat
	move	$k0, $at
	.set	at
	sw	$k0, saveat
	sw	$a0, save0	# save register used here (assumes no macros!)
	mfc0	$k1, $14	# exception program counter from coprocessor 0 reg $14
	lw	$a0, 0xffff0004	# get data typed in
	nop
	sw	$a0, letter	# store in letter for use by main prog.
	li	$a0, 1		# set a flag to 1 to indicate that
	sw	$a0, flag	# the main program should rotate the array
				# interrupt routine epilog
intex:
	lw	$a0, save0	# restore saved registers
	lw	$k0, saveat
	nop
	.set	noat
	move	$at, $k0
	.set	at
#	addiu	$k1, $k1, 4	# do not reexecute faulting instruction
#				# (advance PC)
	eret
#	rfe			# or do this: reset interrupt state
#	jr	$k1		# jump back to interrupted program

	.kdata			# kernel data segment
	.align	4
saveat:	.space	4
save0:	.space	4
save1:	.space	4
