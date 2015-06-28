segment .data 
	msg1 db  0xA,0x9,"escriba una cadena",0xA
	len1 equ $- msg1

	msg2 db  0xA,0x9,"escriba una cadena",0xA
	len2 equ $- msg2

	msg3 db  0xA,0x9,"las cadenas no son igualess",0xA
	len3 equ $- msg3
	msg4 db  0xA,0x9,"las cadenas Son igualess",0xA
	len4 equ $- msg4
	msg5 db  0xA,0x9,"copiando cad1 a cad2",0xA
	len5 equ $- msg5

	espacio db  0xA
	lespacio equ $- espacio

	;res db "         "
	;lenr equ $- res

	;res2 db "         "
	;lenr2 equ $- res2 

segment .bss
	res resb 10
	res2 resb 10


segment .text

lee:
	mov eax, 3
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start: 
	
	mov eax, 4 
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80 

	mov ecx, res 
	mov edx, 10
	call lee	

	mov eax, 4 
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80 

	mov ecx, res2 
	mov edx, 10
	call lee

	cld
	;std
	mov esi, res
	mov edi, res2
	mov ecx, 10

	repe CMPSB
	jne noiguales
	
 
 iguales:   
	mov eax, 4 
	mov ebx, 1
	mov ecx, msg4
	mov edx, len4
	int 0x80 

    jmp salir

;___________________________________________
noiguales:
	mov eax, 4 
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 0x80 


salir:
	
	mov esi, res
	mov edi, res2
	mov ecx, 10

	repe MOVSB

	mov eax, 4 
	mov ebx, 1
	mov ecx, msg5
	mov edx, len5
	int 0x80 

	mov eax, 4 
	mov ebx, 1
	mov ecx, res
	mov edx, 10
	int 0x80 

	mov eax, 4 
	mov ebx, 1
	mov ecx, espacio
	mov edx, lespacio
	int 0x80 

	mov eax, 4 
	mov ebx, 1
	mov ecx, res2
	mov edx, 10
	int 0x80 


	mov eax, 1  
	xor ebx, ebx 
	int 0x80