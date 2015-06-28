%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
segment .data 
	msg1 db 0xA,0xA,"menu:", 0xA,0x9, "1)suma", 0xA,0x9, "2)resta", 0xA,0x9, "3)salir",0xA,0xA,0x9
	len1 equ $- msg1 
	msg db 0xA,0x9,"numero:  "
	len equ $- msg
	msg4 db  0xA,0x9,"saliendo... "
	len4 equ $- msg4
segment .bss
	num1 resb 2
	num2 resb 2
segment .text
lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start:  

menu:
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

	escribe num1,1

	jmp menu

resta:
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
	escribe num1,1
	jmp menu
	



salir:
	escribe msg4, len4
	mov eax, 1  
	xor ebx, ebx 
	int 0x80
