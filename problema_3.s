.global _start

.section .data
    simulated_keys:  .word 0xE048, 0xE050, 0x1234, 0xE048, 0xE050   @ 5 teclas simuladas
    key_index:       .word 0                                       @ índice actual de tecla simulada
    total_keys:      .word 5                                       @ total de teclas

.section .bss
    .align 4
    teclado:          .space 4      @ Simula la dirección 0x1000
    contador:         .space 4      @ Simula la dirección 0x2000

.section .text
_start:
    LDR R10, =simulated_keys   @ R10 apunta al arreglo de teclas
    LDR R11, =key_index        @ R11 apunta al índice actual
    LDR R12, =total_keys       @ R12 apunta al total de teclas

    LDR R8, =teclado           @ Simula 0x1000
    LDR R9, =contador          @ Simula 0x2000
    MOV R4, #0
    STR R4, [R9]               @ Inicializa contador en 0

loop:
    LDR R3, [R11]              @ Cargar índice
    LDR R5, [R12]              @ Cargar total de teclas
    CMP R3, R5
    BEQ end_program            @ Si ya se leyeron todas las teclas, termina

    ADD R6, R10, R3, LSL #2    @ Dirección de simulated_keys[index]
    LDR R7, [R6]               @ R7 = tecla simulada
    STR R7, [R8]               @ Escribir en dirección simulada de teclado (0x1000)

    @ Leer tecla desde "teclado"
    LDR R1, [R8]               @ R1 = tecla presionada
    LDR R2, [R9]               @ R2 = contador actual

    LDR R6, =0xE048            @ Flecha arriba
    CMP R1, R6
    BEQ inc_counter

    LDR R6, =0xE050            @ Flecha abajo
    CMP R1, R6
    BEQ dec_counter

    B skip_update              @ No hacer nada si la tecla no es válida

inc_counter:
    ADD R2, R2, #1
    B store_and_continue

dec_counter:
    SUB R2, R2, #1
    B store_and_continue

skip_update:
    B continue_loop

store_and_continue:
    STR R2, [R9]               @ Guardar nuevo valor del contador

continue_loop:
    ADD R3, R3, #1             @ index++
    STR R3, [R11]
    B loop

end_program:
    B end_program              @ Bucle infinito para terminar el programa