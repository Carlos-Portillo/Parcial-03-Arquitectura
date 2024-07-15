org 100h

section .data
    mensaje db 'Digite una opcion correcta$'                          ; Mensaje de error
    opcion db 'Parcial final de arquitectura de computadoras$'       
    opcionMensaje db 'Carlos Cesar Portillo Mendoza 00155321$'       
    opcion1 db '1. Dibujar un triangulo$'                            
    opcion2 db '2. Dibujar una figura$'                              
    opcion3 db '3. Salir$'                                           
    mensajeError db 'Digite una opcion correcta$'                    ; Mensaje de error al seleccionar opción incorrecta
    mensajeFin db 'Fin del programa$'                                ; Mensaje de fin del programa
    mensajeSalida db 'Gracias por usar el programa. Presione cualquier tecla para salir.$' ; Mensaje de salida
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
    call IniciarModoTexto  ; Inicializa el modo texto
    call print_menu        ; Imprime el menú principal
    call EsperarTecla      ; Espera a que el usuario presione una tecla
    call CompararNumero    ; Compara la opción seleccionada por el usuario
    jmp main  ; Vuelve al inicio si no se elige salir

CentrarCursor:
    mov ah, 02h           ; Función para mover el cursor
    mov dh, [fila_central]  ; Fila central
    mov dl, [columna_central] ; Columna central
    int 10h               ; Interrupción de BIOS para mover el cursor
    ret

print_menu:
    mov byte [fila_central], 10      ; Fila inicial
    mov byte [columna_central], 25   ; Columna inicial
    mov ah, 09h                      ; Función de DOS para mostrar cadena
    lea dx, [opcion]                 ; Dirección del título del programa
    int 21h                          ; Interrupción de DOS para mostrar cadena
    
    call CentrarCursor              ; Centrar cursor para siguiente línea
    mov ah, 02h                     ; Función de DOS para mover el cursor
    mov dl, 0Ah                     ; Salto de línea
    int 21h                         ; Interrupción de DOS para mover el cursor
    mov dl, 0Dh                     ; Retorno de carro
    int 21h                         ; Interrupción de DOS para mover el cursor
    
    add byte [fila_central], 1       ; Incrementa la fila
    call CentrarCursor               ; Centra el cursor
    lea dx, [opcionMensaje]          ; Dirección del mensaje de información del estudiante
    mov ah, 09h                      ; Función de DOS para mostrar cadena
    int 21h                          ; Interrupción de DOS para mostrar cadena
    
    mov ah, 02h                     
    mov dl, 0Ah                     
    int 21h                         
    mov dl, 0Dh                     
    int 21h                         
    
    add byte [fila_central], 1      
    call CentrarCursor              
    lea dx, [opcion1]               
    mov ah, 09h                     
    int 21h                         
    
    mov ah, 02h                     
    mov dl, 0Ah                     
    int 21h                         
    mov dl, 0Dh                     
    int 21h                         
    
    add byte [fila_central], 1      
    call CentrarCursor              
    lea dx, [opcion2]               
    mov ah, 09h                     
    int 21h                         
    
    mov ah, 02h                    
    mov dl, 0Ah                    
    int 21h                        
    mov dl, 0Dh                    
    int 21h                        
    
    add byte [fila_central], 1       
    call CentrarCursor               
    lea dx, [opcion3]                
    mov ah, 09h                      
    int 21h                          
    
    ret

CompararNumero:
    cmp al, '1'          ; Compara la opción seleccionada con '1'
    je opcion_triangulo  ; Salta a la etiqueta opcion_triangulo si es igual
    cmp al, '2'          ; Compara la opción seleccionada con '2'
    je opcion_figura ; Salta a la etiqueta opcion_figura si es igual
    cmp al, '3'          ; Compara la opción seleccionada con '3'
    je salir             ; Salta a la etiqueta salir si es igual
    call mostrar_error   ; Llama a la función mostrar_error si no es ninguna de las anteriores
    ret

opcion_triangulo:
    call set_video_mode   ; Cambia al modo gráfico
    ; Aquí iría el código para dibujar el triángulo
    call EsperarTeclaS    
    call mostrar_menu_secundario 
    ret

opcion_figura:
    call set_video_mode   ; Cambia al modo gráfico
    ; Aquí iría el código para dibujar el rectángulo
    call EsperarTeclaS   
    call mostrar_menu_secundario 
    ret

mostrar_error:
    mov ah, 09h           ; Función de DOS para mostrar cadena
    lea dx, [mensajeError] ; Dirección del mensaje de error
    int 21h               ; Interrupción de DOS para mostrar cadena
    ret

salir:
    call IniciarModoTexto 
    mov ah, 09h           
    lea dx, [mensajeFin]  
    int 21h               
    mov ah, 4Ch           
    int 21h               

EsperarTeclaS:
    mov ah, 00h           
    int 16h               
    cmp al, 's'           ; Compara la tecla presionada con 's'
    jne EsperarTeclaS     ; Si no es 's', espera otra vez
    ret

mostrar_menu_secundario:
    call IniciarModoTexto  ; Cambia al modo texto

    add byte [fila_central], 1 
    call CentrarCursor         
    mov ah, 09h                
    lea dx, [menuSecundario]   
    int 21h                    
    
    mov ah, 02h                ; Función de DOS para mover el cursor
    mov dl, 0Ah                ; Salto de línea
    int 21h                    ; Interrupción de DOS para mover el cursor
    mov dl, 0Dh                ; Retorno de carro
    int 21h                    ; Interrupción de DOS para mover el cursor
    
    add byte [fila_central], 1 ; Incrementa la fila
    call CentrarCursor         ; Centra el cursor
    lea dx, [menuSecundarioSalir] ; Dirección de la opción para salir
    mov ah, 09h                ; Función de DOS para mostrar cadena
    int 21h                    ; Interrupción de DOS para mostrar cadena
    
    call EsperarTecla          ; Espera a que el usuario presione una tecla
    cmp al, '1'                ; Compara la opción seleccionada con '1'
    je main                    ; Salta a la etiqueta main si es igual
    cmp al, '3'                ; Compara la opción seleccionada con '3'
    je salir                   ; Salta a la etiqueta salir si es igual
    jmp mostrar_menu_secundario ; Vuelve a mostrar el menú secundario si no es ninguna de las anteriores

EsperarTecla:
    mov ah, 00h           
    int 16h               
    ret

IniciarModoTexto:
    mov ah, 0
    mov al, 3  
    int 10h    
    ret

set_video_mode:
    mov ax, 0x0012 
    int 10h        
    ret
