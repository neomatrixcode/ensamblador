section .bss
resultado resb 1

section .text
	global _start
_start:

mov bx, 2

mov dx, 0
mov ax, 8

div bx

add ax, 48

mov [resultado], ax

mov eax, 4
mov ebx, 1
mov ecx, resultado
mov edx, 1
int 0x80

mov eax, 1
mov ebx, 0
int 0x80
