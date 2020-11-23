.data
	myArray: .space 24			# DEFINE ARRAY DE TAMANHO 6
	prompt: .asciiz "Insira 6 numeros: "
	traco: .ascii " / "
.text
	
	li $v0, 4
	la $a0, prompt				# PRINT PROMPT
	syscall
	
	addi $t0, $zero, 0					# CRIA PONTEIRO EM 0
	
	addi $t1, $zero, 24					# LIMITANTE DO PRIMEIRO FOR
	
	for1: beq $t0, $t1, done1
		li $v0, 5
		syscall
		
		sw $v0, myArray($t0)				# GUARDA VALORES LIDOS NO ARRAY
		
		addi $t0, $t0, 4
		addi $t2, $t2, 4				# $t2 = SIZE
		j for1
	done1:
					
	subi $t2, $t2, 4					# SIZE - 1				
	do: 							# do
		sub $t0, $t0, $t0				# PONTEIRO VOLTA A ZERO
		sub $t4, $t4, $t4
		addi $t4, $zero, 4				# Ponteiro [i+1]
		sub $t7, $t7, $t7				# houveTroca = FALSE;
		
		for2: beq $t0, $t2, done2			# for (i = 0; i < SIZE -1; i++)
		
			lw $s1, myArray($t0)			# loads lista[i] em $s1
			lw $s2, myArray($t4)			# loads lista[i + 1] em $s2
			
			if: bgt $s2, $s1, done3			# if ( lista[i + 1] > lista [i] ) jump
			ifeq: beq $s2, $s1, done3
			
				sub $s0, $s0, $s0
				add $s0, $zero, $s1		# aux = lista[i]
				sw $s2, myArray($t0)		# lista[i] = lista[i + 1]
				sw $s0, myArray($t4)		# lista[i + 1] = aux
				addi $t7, $zero, 1		# houveTroca = TRUE 
			
			done3:	
			
			add $t0, $t0, 4				# atualiza ponteiro lista[i]
			add $t4, $t4, 4				# atualiza ponteiro lista[i + 1]
			j for2			
		done2:
		
		bgtz $t7, do
		beqz $t7, while			 		# while (houveTroca == TRUE)
	while:
	
	sub $t0, $t0, $t0					# sets pointer back to 0
	
	addi $t2, $zero, 24
	
	for4: beq $t0, $t2, done4
		
		lw $t6, myArray($t0)
		li $v0, 1
		move $a0, $t6
		syscall
		li $v0, 4
		la $a0, traco
		syscall
		addi $t0, $t0, 4
		
		j for4
	
	done4:
		
	
	