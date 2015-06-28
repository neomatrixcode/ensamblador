%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
segment .data 
	msg1 db 0xA,0xA,"menu:", 0xA,0x9, "1)mostrar en pantalla", 0xA,0x9, "2)no mostar en pantalla", 0xA,0x9, "3)salir",0xA,0xA,0x9
	len1 equ $- msg1 
	msg db 0xA,0x9,"CONTRASEÑA:  "
	len equ $- msg
	msg4 db  0xA,0x9,"saliendo... "
	len4 equ $- msg4

	nm  db 0x1b, "[37;47;3m"
	lnm equ $- nm

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr

 	archivo db "/home/neomatrix/c0de/assescuela/contrasenas/contrasenas.txt",0


segment .bss
	pass resb 10
	idarchivo resd 1
	id resb 1
	Contenido resb 16384

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
	add eax, '0'
	mov [id], eax


menu:
	escribe clr, clrlen
	escribe msg1,len1
	mov ecx, pass  
	mov edx, 2
	call lee
	mov al, [pass]
	sub al, '0'
	cmp al, 2
	jb mos
	ja salir 
	je nmos
	jmp menu

mos:
	escribe clr, clrlen
	escribe msg,len
	
	mov ecx, pass  
	mov edx, 10
	call lee

	escribe pass, 10

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, pass
	mov edx, 10
	int 80h

	jmp menu

nmos:
	escribe clr, clrlen
	
	escribe msg,len

	escribe nm,lnm
	
	mov ecx, pass  
	mov edx, 10
	call lee

	escribe pass, 10

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, pass
	mov edx, 10
	int 80h

	jmp menu

	



salir:
	escribe msg4, len4

	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0
	int 80h

	mov eax, 1  
	xor ebx, ebx 
	int 0x80
