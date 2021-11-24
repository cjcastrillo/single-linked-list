#
#	Name:		Carlos Castrillo
#	Project:	4
#	Due:		11/24/2021
#	Course:		cs-2640-02-f21
#
#	Description:
#				Use single list link to store input text
#

	.data
intro:
	.asciiz	"Link List by C. Castrillo\n\n"
prompt:
	.asciiz	"Enter text? "
head:
	.word	0
input:
	.space	30

	.text
main:

print:					#Parameters: a0-cstring
	li	$v0, 4			#Prints out a given string
	syscall
	jr	$ra

strdup:					#Parameters: a0-cstring
	move	$s7, $a0	#Duplicates a string into the heap
	subu	$sp, $sp, 4
	sw	$ra, ($sp)
	jal	strlen
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	move	$a0, $v0
	addi	$a0, $a0, 1	#Include the null byte of the string
	li	$v0, 9
	addi	$a0, $a0, 3
	srl	$a0, $a0, 2
	sll	$a0, $a0, 2		#Convert the length into a multiple of 4 to make space on heap
	syscall
	move	$s1, $v0
	move	$s2, $zero
dowhile:				#Copy the string character by character into the heap
	add	$s3, $s2, $s7 
	lb	$s4, ($s3)
	add	$s5, $s2, $s1
	sb	$s4, ($s5)
	addi	$s2, $s2, 1
	beqz	$s4, enddw
	b	dowhile
enddw:
	move	$v0, $s1
	jr	$ra

strlen:					#Parameters: a0-cstring
	move	$s0, $zero	#Returns the number of characters up to the null byte
while:
	add	$s3, $a0, $s0
	lb	$s2, ($s3)
	beqz	$s2, endwhile
	addi	$s0, $s0, 1
	b	while
endwhile:
	move	$v0, $s0
	jr	$ra

traverse:				#Parameters: address-list, address-proc
	jr $ra

addnode:				#Parameters: address-data, address-next
	jr $ra