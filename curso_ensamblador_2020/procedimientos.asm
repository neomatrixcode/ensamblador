section .data
msg1 db "mensaje1",0xA,0xD
len1 equ $-msg1

msg2 db "mensaje2",0xA,0xD
len2 equ $-msg2

section .text

imprime:
mov eax, 4
mov ebx, 1
int 0x80
ret
global _start
_start:
mov ecx,msg1
mov edx,len1
call imprime

mov ecx,msg2
mov edx,len2
call imprime


mov eax, 1
mov ebx, 0
int 0x80