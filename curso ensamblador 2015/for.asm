section .data
	userMsg db "la suma del 3 al 0 es:",0xA,0xD
	lenUserMsg equ $ - userMsg
	

section .bss
	num resb 2

section .text
	global _start
_start:
	mov eax, 4 ; llama al sistema (sys_write)
	mov ebx, 1	;stdout
	mov ecx, userMsg ;msg pantalla
	mov edx, lenUserMsg ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones
	

	mov eax, 0
	mov ecx, 3

loop_for:
	add eax, ecx
	loop loop_for

	add eax,'0'

	mov [num], eax

	mov eax, 4 ; llama al sistema (sys_write)
	mov ebx, 1	;stdout
	mov ecx, num ;msg pantalla
	mov edx, 2 ;longitud del mensaje
	int 0x80

	mov eax, 1 ;(system("pause"),exit, sys_exit)
	int 0x80
 
