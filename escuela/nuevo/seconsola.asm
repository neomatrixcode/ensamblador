;segment .data

MsgError db "Se produce un error",0
lon equ $ -MsgError
;archivo db "/home/neomatrix/c0de/tarea/nuevo/prueba.txt",0
;archivo db "/dev/vcs2",0
 clr    db 0x1b, "[30;47;3m",0x1b, "[2J"
 clrlen equ $ - clr
 pos  db 0x1b, "[10;10f", 0x1b, "[30;47;3m"
 ;[2J : borra todos los caracteres desde su posision actual
 ;    hasta el final de la pantalla
 ;"[x;yH" :mueve el cursor a x y,
 ;"[x;yf" :mueve el cursor a x y, 
 ;"[nA" : mueve el cursor n lineas hacia arriba
 ;"[nB" : mueve el cursor n lineas hacia abajo
 ;"[nC" : mueve el cursor n lineas hacia adelante
 ;"[nD" : mueve el cursor n lineas hacia atras
 ;"[3m" : italico
 ;
lpos equ $ - pos

archivo db "/dev/pts/0",0


segment .bss
idarchivo resd 1
id resb 1
Contenido resb 16384



segment .text
	global _start  
_start:  


; Abrimos el archivo de destino
mov eax,5         ; the number of the syscall 'open'
mov ebx,archivo
mov ecx,2         ; read and write file access flags
;mov ecx, 0  		;solo lectura
mov edx,7777h     ; all file permissions flags
;mov edx, 0
int 80h              ; interrupt 80h

test eax,eax
jz Error

mov dword[idarchivo] , eax
add eax, '0'
mov [id], eax


;lectura del contenido del archivo
;mov eax, 3
;mov ebx, [idarchivo]
;mov ecx, Contenido
;mov edx, 16384
;int 80h

;test eax,eax
;jz Error

;impresion del contenido
mov eax, 4
mov ebx, [idarchivo]
mov ecx, clr
mov edx, clrlen
int 80h

mov eax, 4
mov ebx, [idarchivo]
mov ecx, pos
mov edx, lpos
int 80h

mov eax, 4
mov ebx, [idarchivo]
mov ecx, MsgError
mov edx, lon
int 80h

;escritura en el archivo
;mov eax, 4
;mov ebx, [idarchivo]
;mov ecx, MsgError
;mov edx, lon
;int 80h


;cierre
mov eax, 6
mov ebx, [idarchivo]
mov ecx, 0
mov edx, 0
int 80h



jmp Salir ; terminar

Error:
; Mostramos el mensaje de error
mov eax, 4
mov ebx, 1
mov ecx, MsgError
mov edx, lon
int 80h

Salir:
; Devolvemos el control al sistema
mov eax, 1
xor ebx,ebx
int 0x80