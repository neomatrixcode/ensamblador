extern printf

section .data
mensaje db "hola mundo",0xa,0xd,0

section .text
global main

main:
push mensaje
call printf
add esp, 4

ret