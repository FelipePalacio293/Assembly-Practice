.data
    mensajeResistencia: .asciiz "Ingrese la cantidad de resistencias del circuito: "
    mensajeResistenciaDos: .asciiz "Ingrese la resistencia: "
	mensajeVoltaje: .asciiz "Ingrese el voltaje del circuito: "
    mensajeMostrar: .asciiz "La intensidad que pasa por esta resistencia es: "
    mensajeTipoCircuito: .asciiz "El circuito es: 1. Serie 2. Paraleo "
    mensajeEquivalente: .asciiz "La resistencia equivalente del circuito es: "
    mensajeReqSer: .asciiz "La intensidad de la corriente por cada resistencia es: "
    mostrarReqSer: .asciiz "La resistencia equivalente del circuito en serie es: "
    mensajeUno: .asciiz "Ingrese 1 para iniciar: "
    mensajeVacio: .asciiz ""
    saltoLinea: .asciiz "\n"
    resistencia: .word 4
    voltaje: .word 4
    tipo: .word 4
.text
main:
    la $a0, mensajeUno
	add $v0, $0, 4
	syscall

    add $v0, $0, 7
	syscall
    mov.d $f10, $f0

    jal pedirDatos


    beq $t2, 1, calcularIntensidadesSerie
    beq $t2, 2, calcularIntensidadesParalelo


pedirDatos:
    la $a0, mensajeResistencia
	add $v0, $0, 4
	syscall

    la $a0, resistencia
    add $v0, $0, 5
	syscall

    add $t1, $t1, $v0 

    la $a0, mensajeTipoCircuito
	add $v0, $0, 4
	syscall

    la $a0, tipo
    add $v0, $0, 5
	syscall

    add $t2, $t2, $v0 

    la $a0, mensajeVoltaje
	add $v0, $0, 4
	syscall

    add $v0, $0, 7
	syscall

    mov.d $f2, $f0 

    jr $ra

calcularIntensidadesSerie:
    cicloDos:
        beq $t1, $t4, finalizarCicloDos
        addi $t4, $t4, 1 

        la $a0, mensajeResistenciaDos
		add $v0, $0, 4
		syscall

        la $a0, mensajeVacio

		add $v0, $0, 7
		syscall

        mov.d $f4, $f0

        add.d $f6, $f6, $f4

        j cicloDos
finalizarCicloDos: 
    div.d $f8, $f2, $f6

    la $a0, mensajeReqSer
	add $v0, $0, 4
	syscall

    mov.d $f12, $f8
    add $v0, $0, 3
    syscall

    la $a0, saltoLinea
	add $v0, $0, 4
	syscall

    la $a0, mostrarReqSer
	add $v0, $0, 4
	syscall

    mov.d $f12, $f6
    add $v0, $0, 3
    syscall

    jal finalizar

calcularIntensidadesParalelo:
    add $t4, $t4, $0
    cicloUno:
        beq $t1, $t4, finalizarCicloUno
        addi $t4, $t4, 1

        la $a0, mensajeResistenciaDos
		add $v0, $0, 4
		syscall

        la $a0, mensajeVacio

		add $v0, $0, 7
		syscall

        mov.d $f4, $f0

        div.d $f8, $f2, $f4

        div.d $f14, $f10, $f4
        add.d $f6, $f6, $f14

        la $a0, mensajeMostrar
	    add $v0, $0, 4
	    syscall

        la $a0, mensajeVacio

        mov.d $f12, $f8
        add $v0, $0, 3
        syscall

        la $a0, saltoLinea
	    add $v0, $0, 4
	    syscall

        j cicloUno
    finalizarCicloUno:
        jal resistenciaEquivalenteParalelo

resistenciaEquivalenteParalelo:
    div.d $f10, $f10, $f6
    
    la $a0, mensajeEquivalente
	add $v0, $0, 4
	syscall

    mov.d $f12, $f10
    add $v0, $0, 3
    syscall

    jal finalizar
finalizar:
    add	$v0, $0, 10
	syscall
	.end
    