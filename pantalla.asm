%macro escribe 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

segment .data
msg1 db "ingrese cinco numeros y presione enter:", 0xA
len1 equ $-msg1

msg3 db "el mayor de estos numeros es: "
len3 equ $-msg3

arre db 0,0,0,0,0
la equ $-arre

msg2 db  0xA
lm2 equ $-msg2


segment .bss
res resb 2

segment .text

leetecla:
	mov eax, 3
	mov ebx, 0
	mov edx, 2
	int 0x80
ret

global _start

_start:

escribe msg1, len1

mov esi, arre
mov edi, 0

lee:
mov ecx, res

call leetecla


mov al, [res]
sub al, '0'

mov [esi], al
 
add esi, 1
add edi, 1

cmp edi, la
jb lee


mov ecx, 0
mov bl, 0   


lp:
mov al, [arre+ecx]
cmp al, bl
jb reg
mov bl, al

reg:
inc ecx
cmp ecx, la
jb lp

imprimir:
	add bl, '0'
	mov [res], bl

escribe msg3, len3

escribe res, 1

escribe msg2, lm2

salir:
 mov eax, 1
 xor ebx, ebx
 int 0x80






