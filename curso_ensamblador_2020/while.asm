section .bss
resultado resb 1

section .text
	global _start
_start:
mov eax,3
mov ebx,0

while:
add ebx,2
sub eax,1
cmp eax,0
ja while


salidawhile:

add ebx, 48
mov [resultado], ebx

mov eax, 4
mov ebx, 1
mov ecx, resultado
mov edx, 1
int 0x80

mov eax, 1
mov ebx, 0
int 0x80

