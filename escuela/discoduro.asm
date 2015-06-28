%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
segment .data 
	msg db 0xA,0xA,0x9,"ESPACIO LIBRE EN DISCO DURO"
	len equ $- msg
	

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr

 	archivo db "/home/neomatrix/c0de/assescuela/cadena.txt",0


segment .bss
	cadena resb 20

segment .text
lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start:  

	escribe clr, clrlen
	escribe msg,len
	


	;mov eax, 4
	;mov ebx, [idarchivo]
	;mov ecx, cadena
	;mov edx, 20
	;int 80h



salir:
	;mov eax, 6
	;mov ebx, [idarchivo]
	;mov ecx, 0
	;mov edx, 0
	;int 80h

	mov eax, 1  
	xor ebx, ebx 
	int 0x80
