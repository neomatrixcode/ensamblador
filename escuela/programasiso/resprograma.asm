	;;----------------------DATOS----TODO EN MAYUSCULAS!!!!
	dias  db "LUNES       ",0xA,0xD,"MARTES    ",0xA,0xD,"MIERCOLES ",0xA,0xD,"JUEVES    ",0xA,0xD,"VIERNES   "
	nl db 0xA
	arre db 0, 0, 0, 0, 0

	res resb 2
	ubi resb 2
	
	;;----------------------ARRANQUE-------------------------------
USE16
ORG	0x7C00	
	jmp	inicio

inicio:
	;mov eax, 4
	;mov ebx, 5
	;add eax, ebx
	;add eax, 30h
	;mov [salida],eax


	call clr

	mov dh, 10 ;renglon
	mov dl, 00 ;columna
	call goto_x_y
    

	mov	esi, dias
	call imprime       

	;call leer
	
	mov al, [arre+2]
	mov ah, 0x0E         
	int 0x10

	mov esi, arre
	MOV edi , 0

	mov dh, 10 ;renglon
	mov dl, 10 ;columna
	call goto_x_y

leee:
	call leer
	mov [esi], al

	mov al, [esi]
	add al, 30h
	mov ah , 0x0E                
	int 0x10

	mov al, 0xA
	mov ah , 0x0E                
	int 0x10
	
	add esi, 1
	add edi, 1
	cmp edi, 5
	jb leee

	mov ecx, 0
	mov bl, 0

lp:
	mov al, [arre+ecx] 
	cmp al, bl
	jb reg
	mov bl, al
	;add ecx, 30h
	;mov [ubi], ecx
	;sub ecx, 30h
reg:
	inc ecx
	cmp ecx, 5
	jb lp


    add bl, 30h
    mov [res], bl

    mov dh, 20 ;renglon
	mov dl, 10 ;columna
	call goto_x_y

	mov	esi, res
	call imprime  


	;mov eax, [ubi]
	;sub eax, 30h
	;mov ecx, 10
	;mul ecx
	;mov ebx, dias
	;add ebx, eax
	;mov [ubi], ebx

	;mov	esi, [ubi]
	;call imprime 


;	mov dh, 24 ;renglon    
;	mov dl, 00;columna
;	call goto_x_y

;;----------------------PROCEDIMIENTOS-----------------------------------
leer:
	mov ah, 00h
	int 16h  ; AL ALMACENA EL CARACTER ASCII, AH ALMACENA EL SCAN-CODE
	sub al, 30h
ret 

goto_x_y :
	; el TAMAÑO MAXIMO DE LA PANTALLA ES DE 24X79
	mov ah, 02h
	mov bh, 00h
	int 10h 
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
	
	
	
	
