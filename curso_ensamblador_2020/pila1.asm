%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

section .data
mensaje db "El registro eax contiene el valor: "
lonmensaje equ $-mensaje

ln db 0xa,0xd
lonln equ $-ln

section .bss
datos resb 1

section .text
	global _start
_start:

mov ax,'0'

push ax

mov ax, '9'

mov [datos], ax

imprime mensaje, lonmensaje
imprime datos, 1
imprime ln, lonln

pop ax

mov [datos], ax

imprime mensaje, lonmensaje
imprime datos, 1
imprime ln, lonln

mov eax,1
mov ebx,0
int 0x80

