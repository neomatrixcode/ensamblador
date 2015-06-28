segment .data 
	msg1 db  0xA,0x9,"ingrese un numero y presione enter, 5 veces: $",0xA
	len1 equ $- msg1

	msg3 db  0xA,0x9,"los numeros ordenados son: "
	len3 equ $- msg3

	arre db 0, 0, 0, 0, 0
	la equ $- arre

segment .bss
	res resb 2


segment .text
	global _start  
_start: 
	
	mov eax, 4 
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80 


mov esi, arre
MOV edi , 0
lee:
	mov eax, 3
	mov ebx, 0 
	mov ecx, res
	mov edx, 2
	int 0x80 
	
	mov al, [res]
	sub al, '0'

	mov [esi], al

	add esi, 1
	add edi, 1
	cmp edi, la
	jb lee	
	
	mov edx, 0
le:
	mov ecx, 0
lp:
	mov al, [arre+ecx] 
	mov bl, [arre+(ecx+1)] 
	cmp al, bl
	ja reg

	mov [arre+ecx], bl	
	mov [arre+(ecx+1)], al 

reg:
	inc ecx
	cmp ecx, la
	jb lp
	
	inc edx
	cmp edx, la
	jb le



	mov ecx, 0
	
lm:
	mov al, [arre+ecx]
	add al, '0'
	mov [arre+ecx], al
	inc ecx
	cmp ecx, la
	jb lm


imprimir:
	mov eax, 4 
	mov ebx, 1
	mov ecx, msg3 
	mov edx, len3
	int 0x80



	mov eax, 4
	mov ebx, 1
	mov ecx, arre
	mov edx, la
	int 0x80

salir:
	mov eax, 1  
	xor ebx, ebx 
	int 0x80