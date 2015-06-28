mask dw 0000000000000000b 
dw 0000000000000000b 
dw 0000111111110000b 
dw 0001111111111000b 
dw 0011000111110000b 
dw 0011000111100000b 
dw 0011111111000000b 
dw 0011111111100000b 
dw 0011111111110000b 
dw 0001111111111000b 
dw 0000111111110000b 
dw 0000000000000000b 
dw 0000000000000000b 
dw 0000000000000000b 
dw 0000000000000000b 
dw 0000000000000000b 

dw 0000000000000000b 
dw 0000111111111000b 
dw 0001000000001000b 
dw 0010000000001000b 
dw 0100111000010000b 
dw 0100111000100000b 
dw 0100000000100000b 
dw 0100000000010000b 
dw 0100000000001000b 
dw 0010000000000100b 
dw 0001000000001000b 
dw 0000111111110000b 
dw 0000000000000000b 
dw 0000000000000000b 
dw 0000000000000000b 
dw 0000000000000000b 
;si quieres invierte el orden de los arreglos 
;.....coordenadas iniciales de posicion para el raton.......................... 
x dw 000 
y dw 000 

USE16
ORG	0x7C00	
	jmp	inicio

inicio:
mov ah,00h ;......establece modo gráfico 640x480 pixeles 
mov al,12h 
mov bh,00 ;pagina 0, color negro 
int 10h 
mov ah, 0bh 
mov bh, 00h 
mov bl, 01h	; color fondo 
int 10h 

mov ax,00h ;peticion para habilitar mouse 
int 33h 

cmp al,00h ;si no encontró driver se sale del programa 
je salir 

mov ax,01h ;muestra el puntero 
int 33h 

mov ax,09h ;con la forma personalizada (es que la flecha se me hace muy simple) 
xor bx,bx 
xor cx,cx 
lea dx,tmask 
int 33h 

mov ax,04h ;y lo pone en la esquina superior izquierda 
mov cx,x 
mov dx,y 
int 33h 

curs: 
mov ax,03h ;se quda sin hacer nada 
int 33h 
cmp bx,2 ;hasta que presiones clic derecho,sales del programa 
je salir 
jmp curs 

salir: ;para salir.... 
mov ax,02h ;oculto el raton 
int 33h 
mov ah,00h ;regreso al modo de video por default (modo texto) 
mov al,03h 
int 10h 


	;; -----------------------Estructura MBR----------------------------------	
	hlt			;Coloco la CPU en HALT.	
TIMES	510 - ($-$$) db	0	;Completo el archivo con ceros hasta 2 bytes antes
				;del final. Para representar el sector boot (MBR).
dw	0xAA55			;Firma de MBR Booteable.
	
	
	
	
