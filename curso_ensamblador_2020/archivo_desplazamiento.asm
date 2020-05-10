section .data
msgerror db "se produjo un error",0xa,0xd
lon equ $-msgerror

mensajearchivo db "hola archivo"
lonmensaje equ $-mensajearchivo

msgexito db "archivo abierto con exito",0xa,0xd
lonexito equ $-msgexito

archivo db "/code/prueba.txt",0

section .bss
idarchivo resd 1

section .text
global _start
_start:

mov eax, 5
mov ebx, archivo
mov ecx, 0002h
int 0x80

cmp eax, 0
jl error

mov dword[idarchivo], eax

mov eax, 4
mov ebx, 1
mov ecx, msgexito
mov edx, lonexito
int 0x80

mov eax, 19
mov ebx, [idarchivo]
mov ecx, 8
mov edx, 0
int 0x80

mov eax, 4
mov ebx, [idarchivo]
mov ecx, mensajearchivo
mov edx, lonmensaje
int 0x80

mov eax, 6
mov ebx, [idarchivo]
int 0x80

jmp salir

error:
mov eax, 4
mov ebx, 1
mov ecx, msgerror
mov edx, lon
int 0x80

salir:
mov eax,1
mov ebx,0
int 0x80

