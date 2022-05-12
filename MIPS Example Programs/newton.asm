##
## newton.asm -- compute sqrt(n) 
##
## adapted from 
## http://chortle.ccsu.edu/assemblytutorial/Chapter-32/ass32_14.html
##
## given an approximation x to sqrt(n),
## an improved approximation x' is:
##
## x' = (1/2)(x + n/x)
##
## Register use:
## $f0  ---  n
## $f12 ---  1.0
## $f2  ---  2.0
## $f4  ---  x  : current approx.
## $f6  ---  x' : next approx.
## $f8  ---  temp
## $f10 ---  1.0e-5 for accuracy limit
##
	.text
	.globl main

main:
	li	$v0, 4		# print string
	la	$a0, prompt	# address of prompt string
	syscall			# print the prompt
	li	$v0, 5		# read integer
	syscall			# get the integer
	mtc1	$v0, $f0	# move integer to coprocessor 1
	cvt.s.w	$f8, $f0	# convert entered integer to single precision float
	s.s	$f8, n		# store it in n
	nop			# store delay slot

	# start Newton's algorithm to approximate square root
	l.s	$f0, n		# get n (re-load n, which is what most compilers will do)
	li.s	$f12, 1.0	# constant 1.0
	li.s	$f2, 2.0	# constant 2.0
	li.s	$f4, 1.0	# x == first approx. (a guess, and 1.0 is close enough)
	li.s	$f10, 1.0e-5	# five figure accuracy

loop:	
	mov.s	$f6, $f0	# x' = n
	div.s	$f6, $f6, $f4	# x' = n/x
	add.s	$f6, $f4, $f6	# x' = x + n/x
	div.s	$f4, $f6, $f2	# x  = (1/2)(x + n/x)

	mul.s	$f8, $f4, $f4	# check: x^2
	div.s	$f8, $f0, $f8	# n/x^2
	sub.s	$f8, $f8, $f12	# n/x^2 - 1.0
	abs.s	$f8, $f8	# |n/x^2 - 1.0|
	c.lt.s  $f8, $f10	# |x^2 - n| < small ?
	bc1t	done		# yes: done
	nop
	j	loop		# next approximation
	nop

done:
	mov.s	$f12, $f4	# print the result
	li	$v0, 2
	syscall
	li	$v0, 10		# return to OS
	syscall
	nop

##
##  Data Segment  
##
	.data
n:	.float  5.0		# default 5, but will be changed
prompt:	.asciiz	"Enter an integer for its square root\n"
## end of file

