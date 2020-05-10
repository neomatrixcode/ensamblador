section .data
resultado db '0'

section .bss
resultado2 resb 1

section .text
	global _start
_start:

mov eax, 2
mov ebx, 3

add eax, ebx

add eax, 48
mov [resultado], eax

mov eax, 4
mov ebx, 1
mov ecx, resultado
mov edx, 1
int 0x80


mov eax, 8
mov ebx, 1

sub eax, ebx

add eax, 48
mov [resultado2], eax

mov eax, 4
mov ebx, 1
mov ecx, resultado2
mov edx, 1
int 0x80

mov eax, 1
mov ebx, 0
int 0x80