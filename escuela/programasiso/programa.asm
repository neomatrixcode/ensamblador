	;;----------------------DATOS----TODO EN MAYUSCULAS!!!!
%macro ve 2
	; el TAMAÑO MAXIMO DE LA PANTALLA ES DE 24X79
	mov dh, $1 ;renglon
	mov dl, $2 ;columna
	mov ah, 02h
	mov bh, 00h
	int 10h 
%endmacro

	;;----------------------ARRANQUE-------------------------------
USE16
ORG	0x7C00	
	jmp	inicio

inicio:
	
	call clr

 	mov cx,0000H  ;superior izquierda menos 1 fila 1 renglon
  	mov dx,0001H   ;inferior derecha menos 1 fila 1 renglon
	
	call color
 
ciclo:	
	add cl, 3
	add ch, 1
	add dl, 3
	add dh, 1
	call color
	cmp dh, 18h
	je ov
ov: cmp dl, 4fh	
	jne ciclo 

ve 0,0

;;----------------------PROCEDIMIENTOS-----------------------------------

goto_x_y :
	; el TAMAÑO MAXIMO DE LA PANTALLA ES DE 24X79
	mov ah, 02h
	mov bh, 00h
	int 10h 
ret


color:
   mov ax,0600h
   mov bh,20H  ; color fondo, letra
   ;mov cx, 0000H ;superior izquierda
   ;mov cx,0001H  ;superior izquierda menos 1 fila 1 renglon
   ;mov dx,184FH ; inferior derecha
   ;mov dx,174eH   ;inferior derecha menos 1 fila 1 renglon
   int 0x10
   ret

clr:
   mov ax,0600h
   mov bh,70H  ; color fondo, letra
   mov cx, 0000H ;superior izquierda
   ;mov cx,0101H  ;superior izquierda menos 1 fila 1 renglon
   mov dx,184FH ; inferior derecha
   ;mov dx,174eH   ;inferior derecha menos 1 fila 1 renglon
   int 0x10
   ret

imprime:	
	cld         
	lodsb	 ; Cargar 'ax' con 'ds:si' e incrementar 'si' en 1 
	or      al, al                  ; Verificar si 'al' es cero (fin de la cadena ASCIIZ) 
	jz      listo	 ; Si 'al' es cero salir de la rutina 
	mov     ah, 0x0E                ; Servicio 
	int     0x10                    ; Exhibición de video 
	jmp     imprime	 ; Siguiente caracter 
listo:	 ret	



	;; -----------------------Estructura MBR----------------------------------	
	hlt			;Coloco la CPU en HALT.	
TIMES	510 - ($-$$) db	0	;Completo el archivo con ceros hasta 2 bytes antes
				;del final. Para representar el sector boot (MBR).
dw	0xAA55			;Firma de MBR Booteable.
	
	
	
	
