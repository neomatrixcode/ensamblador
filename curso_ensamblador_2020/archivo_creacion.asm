section .data
msgerror db "se produjo un error",0xa,0xd
lon equ $-msgerror

msgexito db "archivo creado con exito",0xa,0xd
lonexito equ $-msgexito

archivo db "/code/prueba.txt",0

section .bss
idarchivo resd 1

section .text
global _start
_start:

mov eax, 8
mov ebx, archivo
mov ecx, 640q
int 0x80

cmp eax, 0
jl error

mov dword[idarchivo], eax

mov eax, 4
mov ebx,1
mov ecx, msgexito
mov edx, lonexito
int 0x80

mov eax, 6
mov ebx, [idarchivo]
int 0x80

jmp salir

error:
mov eax, 4
mov ebx, 1
mov ecx, msgexito
mov edx, lon
int 0x80

salir:
mov eax,1
mov ebx,0
int 0x80

