org 100h

section .data
    mensaje db 'Digite una opcion correcta$'
    opcion db 'Parcial final de arquitectura de computadoras$'
    opcionMensaje db 'Carlos Cesar Portillo Mendoza 00155321$'
    opcion1 db '1. Dibujar un triangulo$'
    opcion2 db '2. Dibujar una figura$'
    opcion3 db '3. Salir$'
    mensajeError db 'Digite una opcion correcta$'
    mensajeFin db 'Fin del programa$'
    mensajeSalida db 'Gracias por usar el programa. Presione cualquier tecla para salir.$'
    menuSecundario db '1. Regresar a menu principal$'
    menuSecundarioSalir db '3. Salir$'
    color db 0x02 ; Color for the line (green)
    pos_init_x dw 10d
    pos_init_y dw 10d
    pos_x dw 100d
    pos_y dw 100d
    fila_central db 10
    columna_central db 25

section .text
global main

main:
    call IniciarModoTexto
    call print_menu
    call EsperarTecla
    call CompararNumero
    jmp main  ; Volver al inicio si no se elige salir

CentrarCursor:
    MOV AH, 02h
    MOV DH, [fila_central]
    MOV DL, [columna_central]
    INT 10h
    RET

print_menu:
    MOV BYTE[fila_central], 10
    MOV BYTE[columna_central], 25
    
    CALL CentrarCursor
    mov ah, 09h
    mov dx, opcion
    int 21h
    
    ADD BYTE[fila_central], 2
    CALL CentrarCursor
    mov dx, opcionMensaje
    mov ah, 09h
    int 21h
    
    ADD BYTE[fila_central], 2
    CALL CentrarCursor
    mov dx, opcion1
    mov ah, 09h
    int 21h
    
    ADD BYTE[fila_central], 1
    CALL CentrarCursor
    mov dx, opcion2
    mov ah, 09h
    int 21h
    
    ADD BYTE[fila_central], 1
    CALL CentrarCursor
    mov dx, opcion3
    mov ah, 09h
    int 21h
    
    ret

CompararNumero:
    cmp al, '1'
    je opcion_triangulo
    cmp al, '2'
    je opcion_rectangulo
    cmp al, '3'
    je salir
    call mostrar_error
    ret

opcion_triangulo:
    call set_video_mode
    call set_initial_position
    MOV AL, 2h
    MOV DWORD[pos_init_x], 100d
    MOV DWORD[pos_init_y], 0d
    MOV DWORD[pos_x], 100d
    MOV DWORD[pos_y], 100d
    call draw_triangle
    call EsperarTeclaS
    call mostrar_menu_secundario
    ret

opcion_rectangulo:
    call set_video_mode
    call set_initial_position
    MOV AL, 1h
    call draw_rectangle
    call EsperarTeclaS
    call mostrar_menu_secundario
    ret

mostrar_error:
    mov ah, 09h
    mov dx, mensajeError
    int 21h
    ret

salir:
    call IniciarModoTexto
    mov ah, 09h
    mov dx, mensajeFin
    int 21h
    mov ah, 4Ch
    int 21h

EsperarTeclaS:
    mov ah, 00h
    int 16h
    cmp al, 's'
    jne EsperarTeclaS
    ret

mostrar_menu_secundario:
    call IniciarModoTexto

    MOV BYTE[fila_central], 10
    CALL CentrarCursor
    mov ah, 09h
    mov dx, menuSecundario
    int 21h
    
    ADD BYTE[fila_central], 2
    CALL CentrarCursor
    mov dx, menuSecundarioSalir
    mov ah, 09h
    int 21h
    
    call EsperarTecla
    cmp al, '1'
    je main
    cmp al, '3'
    je salir
    jmp mostrar_menu_secundario

EsperarTecla:
    mov ah, 00h
    int 16h
    ret

IniciarModoTexto:
    mov ah, 0
    mov al, 3  ; Modo texto 80x25
    int 10h
    ret

set_video_mode:
    mov ax, 12h  ; Modo gráfico VGA 640x480
    int 10h
    ret

set_initial_position:
    MOV CX, [pos_init_x]
    MOV DX, [pos_init_y]
    MOV DI, [pos_x]
    RET

draw_line:
    MOV AH, 0CH
    MOV AL, [color]
    INT 10H
    INC CX
    CMP CX, DI
    JLE draw_line
    RET

draw_triangle:
    MOV AL, 1d
    CALL set_initial_position
    CALL draw_line
    INC WORD[pos_init_y]
    INC WORD[pos_x]
    MOV SI, [pos_init_y]
    CMP SI, [pos_y]
    JL draw_triangle
    RET

draw_rectangle:
    MOV AL, 0d
    CALL set_initial_position
    CALL draw_line
    INC WORD[pos_init_y]
    MOV SI, [pos_init_y]
    CMP SI, [pos_y]
    JL draw_rectangle
    RET