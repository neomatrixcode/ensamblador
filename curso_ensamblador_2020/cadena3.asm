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

ln db 0xa,0xd
lenln equ $-ln

encontrado db 'letra encontrada'
lnencontrada equ $-encontrado

noencontrado db 'letra no encontrada'
lnnoencontrado equ $-noencontrado

section .text
	global _start
_start:

cld
mov ecx, len
mov edi, string1
mov al, 'z'

repne scasb

je si_esta

imprime noencontrado,lnnoencontrado
imprime ln, lenln
jmp salir
si_esta:
imprime encontrado, lnencontrada
imprime ln, lenln
salir:
mov eax, 1
mov ebx, 0
int 0x80