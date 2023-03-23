.data
	mensajeUsuario: .asciiz ", "
	mensajePedirFil: .asciiz "Ingrese el tamanio horizontal de la matriz: "
	mensajePedirCol: .asciiz "Ingrese el tamanio vertical de la matriz: "
	mensajePedirNum: .asciiz "Ingrese el numero matriz uno: "
	mensajePedirNumDos: .asciiz "Ingrese el numero matriz dos: "
	matrizUno: .space 128
	matrizDos: .space 128
	filas: .word 4
	columnas: .word 4
	contFilas: .word 4
	contColumas: .word 4
	numero: .word 16
	saltoDeLinea: .asciiz "\n"
		.text
main:
	la $a0, mensajePedirFil
	add $v0, $0, 4
	syscall
	
	la $a0, filas
	add $v0, $0, 5
	syscall
	
	add $t1, $t1, $v0 
	la $a0, mensajePedirCol
	add $v0, $0, 4
	syscall
	
	add $s4, $s4, $t1
	
	
	la $a0, columnas
	add $v0, $0, 5
	syscall
	
	add $t2, $t2, $v0 
	add $t5, $t5, $0
	
	mul $t1, $t1, $t2
	
	la $a1, matrizUno
	add $s1, $0, $a1
	
	jal ingresarMatrizUno
	
	la $a2, matrizDos
	add $s2, $0, $a2
	
	jal ingresarMatrizDos
	
	add $a1, $0, $s1
	add $a2, $0, $s2
	
	jal sumarMatrices
	
	add	$v0,$0,10
	syscall
	.end
	
ingresarMatrizUno:
	
	repetir:
		beq $t5, $t1, finalizarCiclo
		la $a0, mensajePedirNum
		add $v0, $0, 4
		syscall

		la $a0, numero
		add $v0, $0, 5
		syscall
		
		sb $v0, 0($a1)
		addi $a1, $a1, 4
		addi $t5, $t5, 1
		j repetir
	finalizarCiclo:
		jr $ra


ingresarMatrizDos:
	
	repetirDos:
		beq $t4, $t1, finalizarCicloDos
		la $a0, mensajePedirNumDos
		add $v0, $0, 4
		syscall

		la $a0, numero
		add $v0, $0, 5
		syscall
		
		sb $v0, 0($a2)
		addi $a2, $a2, 4
		addi $t4, $t4, 1
		j repetirDos
		
	finalizarCicloDos:
		jr $ra
		
sumarMatrices:
	
	repetirTres:
		beq $t7, $t1, finalizarCicloTres
		
		
		lb $t0, 0($a1)
		lb $t3, 0($a2)
		add $t4, $t0, $t3
		
		addi $a0, $t4, 0
		add $v0, $0, 1
		syscall
		
		addi $a1, $a1, 4
		addi $a2, $a2, 4
		addi $t7, $t7, 1
		addi $s0, $s0, 1
		addi $s5, $s5, 1
	
		beq $s0, $s4, saltarLinea
		
		la $a0, mensajeUsuario
		add $v0, $0, 4
		syscall
		
		j repetirTres
		
	finalizarCicloTres:
		jr $ra
	
	saltarLinea:
		la $a0, saltoDeLinea
		add $v0, $0, 4
		syscall
		add $s0, $0, $0
		j repetirTres