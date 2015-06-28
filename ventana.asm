%macro escribe 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

segment .data
msg2 db  0x1b,"[42;32m","-------",0x1b,"[45;35m","-------",0xA,0x1b,"[40;37m"
len2 equ $-msg2

msg3 db 0x1b,"[45;35m","-------",0x1b,"[42;32m","-------",0xA,0x1b,"[40;37m"
len3 equ $-msg3




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


escribe msg2, len2
escribe msg3, len3


salir:
 mov eax, 1
 xor ebx, ebx
 int 0x80






