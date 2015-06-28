%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
segment .data 
	msg1 db 0xA,0xA,0x9,"INTRODUZCA UNA CADENA: "
	len1 equ $- msg1 
	msg db 0xA,0x9,"INTRODUZCA CARACTER A BUSCAR: "
	len equ $- msg
	msg4 db  0xA,0x9,"EL CARACTER NO EXISTE"
	len4 equ $- msg4
	
	msg5 db  0xA,0x9,"EL CARACTER EXISTE EN LA POSISION: "
	len5 equ $- msg5

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr

 	archivo db "/home/neomatrix/c0de/assescuela/cadena.txt",0


segment .bss
	cadena resb 20
	idarchivo resd 1
	car resb 2
	pos resb 2
segment .text
lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start:  

	mov eax,8         ; the number of the syscall 'open'
	mov ebx,archivo
	mov ecx, 2  		;lect
	;mov edx,7777h     ; all file permissions flags
	mov edx, 7777h
	int 80h              ; interrupt 80h

	test eax,eax
	jz salir
	mov dword[idarchivo] , eax


	escribe clr, clrlen
	escribe msg1,len1
	
	mov ecx, cadena  
	mov edx, 20
	call lee

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, cadena
	mov edx, 20
	int 80h


	escribe msg,len
	mov ecx, car  
	mov edx, 2
	call lee


	cld
	mov edi, cadena
	mov ecx, 20
	mov eax, [car]

	repne SCASB
	jne noesta

	escribe msg5, len5

	;sub edi, 100
	;sub edi, 49
	sub edi, '0'

	mov [pos], edi

	escribe pos, 1

	jmp salir

noesta:
	escribe msg4, len4

salir:
	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0
	int 80h

	mov eax, 1  
	xor ebx, ebx 
	int 0x80
