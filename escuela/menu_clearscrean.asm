%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
segment .data 
	msg1 db "menu:",0x1b, "[6;20f", "1)suma",0x1b, "[7;20f", "2)resta",0x1b, "[8;20f", "3)salir",0xA,0xA,0x9
	len1 equ $- msg1 
	msg db 0x1b, "[E",0x1b, "[20C", "numero:  "
	len equ $- msg
	msg4 db 0x1b, "[14;20f", "saliendo... "
	len4 equ $- msg4
	msg5 db 0x1b, "[E",0x1b, "[20C"
	len5 equ $- msg5

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr
 	pos  db 0x1b, "[10;10f", 0x1b, "[30;47;3m"
	lpos equ $ - pos


segment .bss
	num1 resb 2
	num2 resb 2
segment .text

lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

clrscr:
   escribe clr,clrlen
   RET


	global _start  
_start:  



menu:
	CALL clrscr
	escribe msg1,len1
	mov ecx, num1 
	mov edx, 2
	call lee
	mov al, [num1]
	sub al, '0'
	cmp al, 2
	jb suma
	ja salir 
	je resta
	jmp menu

suma:
	Call clrscr
	escribe msg,len
	mov ecx, num1 
	mov edx, 2
	call lee
	escribe msg,len
	mov ecx, num2 
	mov edx, 2
	call lee

	mov al, [num1]
	sub al,'0'
	mov bl, [num2]
	sub bl,'0'

	add al, bl

	add al, '0'
	mov [num1], al

	escribe msg5, len5

	escribe num1,1

	escribe msg5, len5
	mov ecx, num1 
	mov edx, 2
	call lee
	jmp menu

resta:
	Call clrscr
	escribe msg,len
	mov ecx, num1 
	mov edx, 2
	call lee

	escribe msg,len
	mov ecx, num2 
	mov edx, 2
	call lee

	mov al, [num1]
	sub al,'0'
	mov bl, [num2]
	sub bl,'0'

	cmp al, bl
	ja  sigue

	mov cl, al
	mov al, bl
	mov bl, cl

sigue:
	sub al, bl
	add al, '0'
	mov [num1], al
	escribe msg5, len5
	escribe num1,1
	escribe msg5, len5
	mov ecx, num1 
	mov edx, 2
	call lee
	jmp menu
	



salir:
	escribe msg4, len4
	mov eax, 1  
	xor ebx, ebx 
	int 0x80
