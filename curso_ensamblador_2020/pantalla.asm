%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data
texto db "---------------texto-----------"
lontexto equ $-texto

codigo db 0x1b,"[33;40m",0x1b,"[2j",0x1b,"[5;20f"
lncodigo equ $-codigo

codigo2 db 0x1b,"[33;43m"
lncodigo2 equ $-codigo2

section .text
global _start
_start:

imprime codigo, lncodigo
imprime texto, lontexto
imprime codigo2, lncodigo2
imprime texto, lontexto

mov eax,1
mov ebx,0
int 0x80
