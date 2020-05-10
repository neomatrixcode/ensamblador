%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data
string1 db 'texto de prueba'
len equ $-string1

string2 db 'texto dz prueba'
len2 equ $-string2

ln db 0xa,0xd
lenln equ $-ln

iguales db 'las dos cadenas son iguales'
lniguales equ $-iguales

noiguales db 'las dos cadenas NO son iguales'
lnnoiguales equ $-noiguales

section .text
	global _start
_start:

cld
mov ecx, len
mov esi, string1
mov edi, string2

repe cmpsb

jne son_diferentes

imprime iguales,lniguales
imprime ln, lenln
jmp salir
son_diferentes:
imprime noiguales, lnnoiguales
imprime ln, lenln
salir:
mov eax, 1
mov ebx, 0
int 0x80