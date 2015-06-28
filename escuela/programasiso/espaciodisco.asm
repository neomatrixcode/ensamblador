	;;----------------------DATOS----TODO EN MAYUSCULAS!!!!
	let  db "ESPACIO LIBRE EN:",0xA," "
	Sectores db 'sectores', 13, 10
	Caras db 'caras', 13, 10
	Cilindros db 'cilindros', 13, 10

	nl db 0xA
	res resb 10
	
	;;----------------------ARRANQUE-------------------------------
USE16
ORG	0x7C00	
	jmp	inicio

inicio:


	;call clr    

	mov	esi, let
	call imprime   

	mov AH, 8h	    
	mov DL, 80h
	INT 13h

	; comenzamos con las caras
	; que vienen en DH
	mov al, dh
	inc al ; incrementamos

	; convertimos a cadena
mov di, res
call EnteroCadena
; y las mostramos
mov al, di
mov ah, 0x0E                ; Servicio 
int     0x10  

; el número de sectores está,- en los bits 0 a 5 de CL
mov al, cl
and al, 3Fh
; convertimos a cadena
mov di, res
call EnteroCadena

; y mostramos los sectores
mov al, di
mov ah, 0x0E                ; Servicio 
int     0x10  
; el número de mayor cilindro
; está en el registro CH
mov al, ch
inc ai ; incrementamos
; io convertimos
mov di, res
call EnteroCadena


mov al, di
mov ah, 0x0E                ; Servicio 
int     0x10  







;;----------------------PROCEDIMIENTOS-----------------------------------
EnteroCadena:
; establecemos valor inicial
mov byte [di], '0'
; comprobamos si AL es cero
or al , al
; de ser así, no hay más
; que hacer
jz FinConversion
push bx ; guardamos bx
; y establecemos el divisor
mov bl, 10
Bucle:
; vamos dividiendo por 10
div bl
; quedándonos con el resto
; que convertimos a ASCII
add ah, '0'
; y guardamos
mov [di], ah
; retrocediendo al dígito anterior
dec di
; eliminamos el contenido
; de AH para quedarnos con
; el cociente de Al.
xor ah, ah
; si el cociente es mayor que 9
cmp al, 9
; seguimos dividiendo
jg Bucle
; en caso contrario guardamos
add al, '0'
mov [di], al
pop bx ; recuperamos BX
FinConversion:
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
	
	
	
	
