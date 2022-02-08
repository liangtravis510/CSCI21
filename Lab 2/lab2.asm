#
# lab2.asm
#
# Travis Liang
# 02/04/2022
# Program to check lab answers
#

	.text
	.globl	main

main:	
	#
	# Start with 0x1234 and 0xFFFF
	# and check for or, and, xor and nor 
	# on the bit pattern
	#

	ori	$t0, $zero, 0x1234
	ori 	$t1, $zero, 0xFFFF
	or	$t2, $t1, $t0		# $t2 = 0xFFFF
	and	$t2, $t1, $t0		# $t2 = 0x1234
	xor	$t2, $t1, $t0		# $t2 = 0xEDCB
	nor	$t2, $t1, $t0		# $t2 = 0xFFFF0000

	#
	# Verifiying NORing a value with 0 is
	# the same as Noting the value
	#

	not	$t2, $t0		# $t2 = 0xFFFFEDCB
	nor	$t2, $t0, $zero		# $t2 = 0xFFFFEDCB
	not	$t2, $t1		# $t2 = 0xFFFF0000
	nor	$t2, $t1, $zero		# $t2 = 0xFFFF0000
	

	#
	# Start with 0xFEDC and  0x5678
	# and check for or, and, xor and nor 
	# on the bit pattern
	#
	
	ori	$t0, $zero, 0xFEDC
	ori 	$t1, $zero, 0x5678
	or	$t2, $t1, $t0		# $t2 = 0xFEFC
	and	$t2, $t1, $t0		# $t2 = 0x5658
	xor	$t2, $t1, $t0		# $t2 = 0xA8A4
	nor	$t2, $t1, $t0		# $t2 = 0xFFFF0103

	#
	# Verifiying NORing a value with 0 is
	# the same as Noting the value
	#

	not	$t2, $t0		# $t2 = 0xFFFF0123
	nor	$t2, $t0, $zero		# $t2 = 0xFFFF0123
	not	$t2, $t1		# $t2 = 0xFFFFA987
	nor	$t2, $t1, $zero		# $t2 = 0xFFFFA987

	#
	# Results of sll, srl and sra
	# for bit pattern 0xFFFFFFFF
	#

	li 	$t0, 0xffffffff
	sll 	$t1, $t0, 2		# $t1 = 0xFFFFFFFC		
	sll 	$t1, $t0, 3		# $t1 = 0xFFFFFFF8
	sll 	$t1, $t0, 4		# $t1 = 0xFFFFFFF8
	sll 	$t1, $t0, 5		# $t1 = 0xFFFFFFE0

	srl	$t1, $t0, 2		# $t1 = 0x3FFFFFFF
	srl 	$t1, $t0, 3		# $t1 = 0x1FFFFFFF
	srl 	$t1, $t0, 4		# $t1 = 0xFFFFFFF
	srl 	$t1, $t0, 5		# $t1 = 0x7FFFFFF

	sra	$t1, $t0, 2		# $t1 = 0xFFFFFFFF
	sra 	$t1, $t0, 3		# $t1 = 0xFFFFFFFF
	sra 	$t1, $t0, 4		# $t1 = 0xFFFFFFFF
	sra 	$t1, $t0, 5		# $t1 = 0xFFFFFFFF

	#
	# Results of sll, srl and sra
	# for bit pattern 0x96969696
	#

	li 	$t0, 0x96969696		
	sll 	$t1, $t0, 2		# $t1 = 0x5A5A5A58
	sll 	$t1, $t0, 3		# $t1 = 0xB4B4B4B0
	sll 	$t1, $t0, 4		# $t1 = 0x69696960
	sll 	$t1, $t0, 5		# $t1 = 0xD2D2D2C0
	
	srl	$t1, $t0, 2		# $t1 = 0x25A5A5A5
	srl 	$t1, $t0, 3		# $t1 = 0x12D2D2D2
	srl 	$t1, $t0, 4		# $t1 = 0x9696969
	srl 	$t1, $t0, 5		# $t1 = 0x4B4B4B4

	sra	$t1, $t0, 2		# $t1 = 0xE5A5A5A5
	sra 	$t1, $t0, 3		# $t1 = 0xF2D2D2D2
	sra 	$t1, $t0, 4		# $t1 = 0xF9696969
	sra 	$t1, $t0, 5		# $t1 = 0xFCB4B4B4

	#
	# Results of sll, srl and sra
	# for bit pattern 0x87654321
	#

	li 	$t0, 0x87654321
	sll 	$t1, $t0, 2		# $t1 = 0xFCB4B4B4	
	sll 	$t1, $t0, 3		# $t1 = 0x1D950C84
	sll 	$t1, $t0, 4		# $t1 = 0x76543210
	sll 	$t1, $t0, 5		# $t1 = 0xECA86420

	srl	$t1, $t0, 2		# $t1 = 0x21D950C8
	srl 	$t1, $t0, 3		# $t1 = 0x10ECA864
	srl 	$t1, $t0, 4		# $t1 = 0x8765432
	srl 	$t1, $t0, 5		# $t1 = 0x43B2A19

	sra	$t1, $t0, 2		# $t1 = 0xELD950c8
	sra 	$t1, $t0, 3		# $t1 = 0xF0ECA864
	sra 	$t1, $t0, 4		# $t1 = 0xF8765432
	sra 	$t1, $t0, 5		# $t1 = 0xFC3B2A19
	


## End of file