section .data

msg db "Hola Mundo!!!!",0xA,0xD
len equ $ - msg 


section .text
	global _start

_start:
	
	mov eax, 4   ; llama al sistema (sys_write)
	;eax = 4
	mov ebx, 1	 ;stdout
	mov ecx, msg ;msg pantalla
	mov edx, len ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones
	
	mov eax, 1 ;(system("pause"),exit, sys_exit)
	int 0x80


	





