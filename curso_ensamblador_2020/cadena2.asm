%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data
string1 db 'HOLA MUNDO'
len equ $-string1

ln db 0xa,0xd
lenln equ $-ln

string2 db '          '

section .text
	global _start
_start:

cld
mov ecx, len
mov esi, string1
mov edi, string2

rep movsb

imprime string2, len
imprime ln, lenln

mov eax, 1
mov ebx, 0
int 0x80