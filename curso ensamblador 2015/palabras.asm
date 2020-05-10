%macro escribe 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

segment .data
msg2 db "leyendo desde un archivo :",0xA
len2 equ $-msg2

archivo db "/home/neomatrix/ensamblador/archivo.txt",0



segment .bss
texto resb 10
idarchivo resd 1

segment .text

leetecla:
	mov eax, 3
	mov ebx, 0
	mov edx, 10
	int 0x80
ret

global _start

_start:



mov eax, 5
mov ebx, archivo
mov ecx, 0
mov edx, 0
int 0x80

test eax, eax
jz salir
mov dword[idarchivo], eax

escribe msg2, len2


mov eax, 3
mov ebx, [idarchivo]
mov ecx, texto
mov edx, 10
int 0x80

escribe texto, 10

mov eax, 6
mov ebx, [idarchivo]
mov ecx, 0
mov edx, 0
int 0x80


salir:
 mov eax, 1
 xor ebx, ebx
 int 0x80






