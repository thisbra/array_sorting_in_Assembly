# array_sorting_in_Assembly
Sorting by comparison algorithm on assembly using memory registers. 

```
.data
	myArray: .space 24			                          # DECLARES ARRAY OF 24 BYTES (6 ints)
	prompt: .asciiz "Insert 6 numbers: "
	traco: .ascii " / "
.text
	
	li $v0, 4
  la $a0, prompt				                            # PRINT PROMPT
	syscall
	
	addi $t0, $zero, 0					                      # DECLARES POINTER AT 0
	
	addi $t1, $zero, 24					                      # DECLARES FIRST for END
	
	for1: beq $t0, $t1, done1
		li $v0, 5
		syscall
		
		sw $v0, myArray($t0)				                    # SAVES ARRAY VALUE ON VARIABLE
		
		addi $t0, $t0, 4
		addi $t2, $t2, 4				                        # $t2 = SIZE
		j for1
	done1:
					
	subi $t2, $t2, 4					                        # SIZE - 1				
	do: 							# do
		sub $t0, $t0, $t0				                        # POINTER SET AT 0 AGAIN
		sub $t4, $t4, $t4
		addi $t4, $zero, 4				                      # POINTER [i+1]
		sub $t7, $t7, $t7				                        # changed = FALSE;
		
		for2: beq $t0, $t2, done2			                  # for (i = 0; i < SIZE -1; i++)
		
			lw $s1, myArray($t0)			                    # loads list[i] in $s1
			lw $s2, myArray($t4)			                    # loads list[i + 1] in $s2
			
			if: bgt $s2, $s1, done3			                  # if ( lista[i + 1] > lista [i] ) jump
			ifeq: beq $s2, $s1, done3
			
				sub $s0, $s0, $s0
				add $s0, $zero, $s1		                      # aux = list[i]
				sw $s2, myArray($t0)		                    # list[i] = lista[i + 1]
				sw $s0, myArray($t4)		                    # list[i + 1] = aux
				addi $t7, $zero, 1		                      # changed = TRUE 
			
			done3:	
			
			add $t0, $t0, 4				                        # UPDATES POINTER list[i]
			add $t4, $t4, 4				                        # UPDATES POINTER list[i + 1]
			j for2			
		done2:
		
		bgtz $t7, do
		beqz $t7, while			 		                        # while (changed == TRUE)
	while:
	
	sub $t0, $t0, $t0					                        # sets pointer back to 0
	
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
		