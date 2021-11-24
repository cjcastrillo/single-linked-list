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

	.text
main:

puts:					#Parameters: a0-cstring
	li	$v0, 4
	syscall
	jr	$ra

strdup:					#Parameters: a0-cstring
	move	$s7, $a0
	subu	$sp, $sp, 4
	sw	$ra, ($sp)
	jal	strlen
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	move	$a0, $v0
	addi	$a0, $a0, 1
	subu	$sp, $sp, 4
	sw	$ra, ($sp)
	jal	malloc
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	move	$s1, $v0
	move	$s2, $zero
dowhile:
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

malloc:					#Parameters: a0-int
	li	$v0, 9
	addi	$a0, $a0, 3
	srl	$a0, $a0, 2
	sll	$a0, $a0, 2
	syscall
	jr	$ra

strlen:					#Parameters: a0-cstring
	move	$s0, $zero
while:
	add		$s3, $a0, $s0
	lb		$s2, ($s3)
	beqz	$s2, endwhile
	addi	$s0, $s0, 1
	b		while
endwhile:
	move	$v0, $s0
	jr		$ra