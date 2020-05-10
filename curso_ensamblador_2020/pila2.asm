%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data

mensaje db "el numero de argumentos es: "
lonmensaje equ $-mensaje

texto db "el argumento es: "
lontexto equ $-texto

ln db 0xa, 0xd
lonln equ $-ln

section .bss
datos resb 1

section .text
global _start
_start:

pop eax
add eax,48
mov [datos], eax

imprime mensaje, lonmensaje
imprime datos, 1
imprime ln, lonln

pop ebx

imprime texto, lontexto

mov eax, 4
mov ebx, 0
pop ecx
mov edx, 1
int 0x80

imprime ln, lonln

mov eax,1
mov ebx,0
int 0x80




