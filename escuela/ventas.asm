%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

segment .data 
	msg1 db  0xA,0x9,"ingrese el valor de las ventas",0xA
	len1 equ $- msg1

	msg3 db  0xA,0x9,"la mayor venta es de:"
	len3 equ $- msg3

	msg4 db  0xA,0x9,"la menor venta es de:"
	len4 equ $- msg4

	dias db "lunes    ",0xA,"martes   ",0xA,"miercoles",0xA,"jueves   ",0xA,"viernes  ",0xA ;cada letrero posee 10 carateres
	ldias equ $- dias

	arre db 0, 0, 0, 0, 0
	la equ $- arre

	msf db 0xA,"El dia: "
	lmsf equ $-msf

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[3;20f"
 	clrlen equ $ - clr

	pos db 0x1b, "[5;0f"
	lpos equ $- pos

	npos db 0x1b, "[12C"
	lnpos equ $- npos

segment .bss
	res resb 2
	ubi resb 2
	dia resb 10

segment .text
lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start: 

	escribe clr, clrlen

	escribe msg1, len1
	escribe dias,ldias
	escribe pos, lpos

mov esi, arre
MOV edi , 0
leee:
	
	escribe npos, lnpos
	mov ecx, res
	mov edx, 2
	call lee


	mov al, [res]
	sub al, '0'

	mov [esi], al

	add esi, 1
	add edi, 1
	cmp edi, la
	jb leee

	mov ecx, 0
	mov bl, 0
lp:
	mov al, [arre+ecx] 
	
	cmp al, bl
	jb reg
	mov bl, al
	add ecx, '0'
	mov [ubi], ecx
	sub ecx, '0'
	
reg:
	inc ecx
	cmp ecx, la
	jb lp



imprimir:
    add bl, '0'
    mov [res], bl

	escribe msg3, len3

	escribe res, 1
	escribe msf, lmsf

	mov eax, [ubi]
	sub eax, '0'
	mov ecx, 10
	mul ecx
	;add eax, 1
	mov ebx, dias
	add ebx, eax
	mov [ubi], ebx

	escribe [ubi], 10


	mov ecx, 0
	mov bl, 9
lp2:
	mov al, [arre+ecx] 
	cmp al, bl
	ja reg2
	mov bl, al
	add ecx, '0'
	mov [ubi], ecx
	sub ecx, '0'
reg2:
	inc ecx
	cmp ecx, la
	jb lp2

imprimir2:
    add bl, '0'
    mov [res], bl

	escribe msg4, len4

	escribe res, 1
	escribe msf, lmsf

	mov eax, [ubi]
	sub eax, '0'
	mov ecx, 10
	mul ecx
	;add eax, 1
	mov ebx, dias
	add ebx, eax
	mov [ubi], ebx

	escribe [ubi], 10
salir:
	mov eax, 1  
	xor ebx, ebx 
	int 0x80