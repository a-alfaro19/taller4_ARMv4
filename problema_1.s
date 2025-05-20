.global _start

.section .data
array: .word 3, 10, 5 ,7, 2, 8, 11, 6, 1, 4 @ arreglo de 10 elementos
lenght: .word 10 @ tamaño del arreglo
constant: .word 5 @ constante K = 5

.section .text
_start:
	LDR R0, =array @ R0: puntero al arreglo
	LDR R1, =constant  @ R1: puntero a la constante
	LDR R2, [R1] @ R2: valor de la constante (k)
	MOV R3, #0 @ index = 0
	
loop:
	CMP R3, #10 @ ¿Se ha recorrido todo el arreglo?
	BEQ end @ Si sí, terminar el loop
	
	LDR R4, [R0, R3, LSL #2] @ R4 = array[i] 
	
	CMP R4, R2 @ array[i] >= k?
	BGE multiply
	
add:
	ADD R4, R4, R2 @ array[i] = array[i] + k
	B store_result
	
multiply:
	MUL R4, R4, R2 @ array[i] = array[i] * k
	
store_result:
	STR R4, [R0, R3, LSL #2] @ guardar el nuevo valor en array[i]
	ADD R3, R3, #1 @ i++
	
	B loop
	
end:
	B end
	
	