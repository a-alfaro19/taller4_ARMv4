.global _start

.section .data
n: .word 5 @ n = 5
result: .word 0 @ result = n!

.section .text
_start:
	LDR R0, =n @ R0: puntero a n
	LDR R1, [R0]  @ R1: valor de n
	MOV R2, #1 @ R2 = resultado inicial (factorial acumulado)
	MOV R3, #1 @ R3 -> contador i = 1
	
loop:
	CMP R3, R1 @ ¿i > n?
	BEQ done @ Si sí, terminar el loop
	
	MUL R2, R2, R3 @ resultado *= i
	ADD R3, R3, #1 @ i++
	
	B loop @ Repetir
	
done:
	LDR R0, =result @ Dirección para gaurdar el resultado
	STR R2, [R0] @ Guardar el resultado en memoria

halt:
	B halt
	
	
