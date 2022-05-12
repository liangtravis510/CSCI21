#
# lab8Changes.asm
#
# Travis Liang, Kyle Yu, Dylan Olivares
# 05/08/2022
# CS21 Lab 8 Major Changes for testing/implementing for
# turning in assignment
# Turn on memory-mappped IO and pseudoinstructions
# Turn off load exception handler
#

	.data
source:	.asciiz	"I like working 20hrs. I also like swimming!\n"
display:
	.space	64
	.text
	.globl main

main:	
	# Caller Prolog
	la	$s0, source
	addiu	$sp, $sp, -4		# Aalocate space for source
	sw	$s0, ($sp)
	la	$s0, display
	addiu	$sp, $sp, -4		# allocate space for display
	sw	$s0, ($sp)
	jal	copy
	nop
	
	# Caller Epilog
	addiu	$sp, $sp, 8		# deallocate space for parameters
	la	$a1, display
while:
	li	$a0, 0xffff0000		# base address of memory-mapped IO area
	lw	$t1, 0($a0)		
	andi	$t1, $t1, 1		# mask ready bit
	beqz	$t1, print		# not set? go to check for display
	lw	$s0, 4($a0)		# extract character (as a word)

	# all inputs 
	li	$s1, 97			# load ASCII 'a'
	beq	$s0, $s1, a		# if q pressed, copy source to display
	li	$s1, 114		# load ASCII 'r'
	beq	$s0, $s1, r		# if r pressed, reverse display string
	li	$s1, 115		# load ASCII 's'
	beq	$s0, $s1, s		# if s pressed, sort the display string
	li	$s1, 116		# load ASCII t
	beq	$s0, $s1, t		# if t pressed, toggle capitalize/uncapitalize char
	li	$s1, 113		# load ASCII q
	beq	$s0, $s1, q		# if q pressed, exit() with syscall 10
	nop

print:
	lw	$t1, 8($a0)		# extract transmitter control
	nop
	andi	$t1, $t1, 1		# mask ready bit
	beqz	$t1, while		# not set? reloop
	nop
	lb	$t1, ($a1)		# load next character from display
	nop
	beqz	$t1, reset		# if 0 byte? reset address 
	nop
	sw	$t1, 12($a0)		# write character to display
	addiu	$a1, $a1, 1		# advance to next char
doWh:
	j	while			# reloop

reset:
	la	$a1, display		
	j	while
	
q:	li	$v0, 10			# exit() 
	syscall

t:	la	$s0, display
	li	$s1, 33			# $s2 = '!'
	li	$s2, 64			# $s3 = '@'
	li	$s3, 0x041		# $s5 = 'A'
	li	$s4, 0x05a		# $s6 = 'Z'
	
toggleL:
	lbu	$s5, 0($s0)		# load chararacter from display
	beq	$s5, 0x0a, endToggleL	# if ($s5 == '\n'), end loop
	beq	$s5, 0x20, increment	# if($s5 == space), increment pointer
	sle	$t0, $s1, $s5		# set if('!' <= $s5)
	sle	$t1, $s5, $s2		# set if($s5 <= '@')
	and	$t0, $t0, $t1		# is $s5 in range 
	bnez	$t0, increment		# if('!' <= $s5 <= '@'), increment
	sle	$t0, $s3, $s5		# set if('A' <= $s5)
	sle	$t1, $s5, $s4		# set if($s5 <= 'Z')
	and	$t0, $t0, $t1		# determine if $s5 is in range
	bnez	$t0, isUpper		# if('A' <= $s5 <= 'Z'), un-capitalize
	addiu	$s5, $s5, -32		# else lowercase
	j	store			# skip 
isUpper:
	addiu	$s5, $s5, 32		# Un-capitalize the value
store:	sb	$s5, 0($s0)
increment:
	addiu	$s0, $s0, 1		# Move to next byte
	j	toggleL			# Reloop
endToggleL:
	j	print	
		
s:
	li	$s0, 0			# intialize size
	li	$s1, 10			# load ASCII '\n'
	la	$s2, display		# load display string address
sLoop:
	lbu	$s3, ($s2)		# load ASCII value at pointer
	beq	$s3, $s1, EndSLoop	# if (char == '\n') exit sLoop
	addiu	$s0, $s0, 1		# size++
	addiu	$s2, $s2, 1		# point to next char
	j	sLoop			# reloop
EndSLoop:
	li	$s1, 0			# intialize index
iLoop:
	beq	$s1, $s0, endILoop	# if (i == size), end iLoop
	subu	$s2, $s0, $s1		# size - i
	addiu	$s2, $s2, -1		# size - i - 1
	li	$s3, 0			# intialize j
jLoop:
	beq	$s3, $s2, endJLoop	# if (j == size - i - 1), exit jLoop
	la	$s4, display		# get display address
	addu	$s5, $s4, $s3		# add offset J
	lbu	$s6, ($s5)		# load index dis[j]
	lbu	$s7, 1($s5)		# load index dis[j+1]
	sgt	$t0, $s6, $s7		# set if (dis[j] > dis[j + 1])
	beqz	$t0, noSwap		# if false, don't swap
	sb	$s7, ($s5)		# store j+1 in j
	sb	$s6, 1($s5)		# store j in j+1
noSwap:
	addiu	$s3, $s3, 1		# j++
	j	jLoop
endJLoop:
	addiu	$s1, $s1, 1		# i++
	j	iLoop
endILoop:
	j	print			

a:
	la	$s0, source
	la	$s1, display
	lbu	$s2, 0($s0)
copy2:
	sb	$s2, ($s1)
	beqz	$s2, endCopy2
	addiu	$s0, $s0, 1
	addiu	$s1, $s1, 1
	lbu	$s2, ($s0)
	j	copy2
endCopy2:
	j	print

r:	la	$s0, display
	la	$s1, display
	li	$s2, 10			# load ASCII '\n'

getEnd:	lbu	$s3, 0($s1)
	beq	$s3, $s2, endGetEnd
	addiu	$s1, $s1, 1
	j	getEnd
endGetEnd:
	addiu	$s1, $s1, -1
reverse:
	bgeu	$s0, $s1, endRev
	lbu	$s3, ($s0)
	lbu	$s4, ($s1)
	move	$s5, $s4
	move	$s4, $s3
	move	$s3, $s5
	sb	$s3, 0($s0)
	sb	$s4, 0($s1)
	addiu	$s0, $s0, 1
	addiu	$s1, $s1, -1
	j	reverse
endRev:	
	j	print
		
# copy subroutine using real based linkage
# t0 = source
# t1 = display
copy:
	# Subroutine Prolog
	addiu	$sp, $sp, -4	
	sw	$ra, ($sp)		# push $ra
	addiu	$sp, $sp, -4		
	sw	$fp, ($sp)		# push $fp
	move	$fp, $sp		# no variables, $fp = $sp
	
	# Subroutine Body
	lw	$t0, 12($fp)		# get source
	lw	$t1, 8($fp)		# get display
	lbu	$t2, 0($t0)		# load char from source
cLoop:
	sb	$t2, ($t1)		# copy char to display
	beqz	$t2, epilog		# if ($t2 == NULL), exit
	addiu	$t0, $t0, 1		# advance next byte in source
	addiu	$t1, $t1, 1		# advance next byte in display
	lbu	$t2, 0($t0)		# load char from source
	j	cLoop			# reloop
epilog:
	# Subroutine Epilog		# $sp = $fp + space_for_variables
	move	$sp, $fp	
	lw	$fp, ($sp)		# pop $fp
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# pop $ra
	addiu	$sp, $sp, 4
	jr	$ra			# return to coller
	
	
	
