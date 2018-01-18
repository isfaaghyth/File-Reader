.text
main:
	addi $a, $zero, 2		# $a = 2;
	addi $b, $zero, 4		# $b = 4;
	add $c, $a, $b		# $c = a + b;
	
	li $v0, 1
	move $a0, $c
	syscall
	
	li $v0, 10
	syscall
