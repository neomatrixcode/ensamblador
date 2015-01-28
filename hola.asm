section .data 
	msg	db "Hola, Mundo!!!",0x0a
	len equ $ - msg  ;longitus de msg

section .text
	global _start       ;para el linker
_start:		    ;marca la entrada
	   mov eax, 4		;llamada al sistema (sys_write)
	   mov ebx, 1		;descripcion de archivo (stdout)
	   mov ecx, msg		;msg a escribir
	   mov edx, len		;longitud del mensage
	   int 0x80			;llama al sistema interrucciones
	   mov eax, 1		;llamada al sistema (sys_exit)
	   int 0x80
	





