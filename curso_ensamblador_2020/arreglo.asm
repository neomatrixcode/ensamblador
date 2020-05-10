%macro imprime 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 0x80
%endmacro

%macro lee 2
mov eax, 3
mov ebx, 0
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

section .data
datos db '0','0','0','0','0','0'
len equ $-datos

ln db 0xA,0xD
lenln equ $-ln

section .text
global _start
_start:

mov ebp, datos
mov edi,0

ciclo_lectura:
lee ebp, 1
add ebp, 1
add edi, 1
cmp edi,len
jb ciclo_lectura

mov ebp, datos
mov edi,0

ciclo_impresion:
imprime ebp, 1
imprime ln, lenln
add ebp, 1
add edi, 1
cmp edi,len
jb ciclo_impresion

mov eax,1
mov ebx,0
int 0x80