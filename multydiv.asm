

section .data

msg1 db "la multiplicacion de 2*2 es: ",0xA,0xD
len1 equ $ - msg1 
msg2 db 0xA,0xD,"la multiplicacion de -2*-2 es: ",0xA,0xD
len2 equ $ - msg2
msg3 db 0xA,0xD,"la division de 4/2 es: ",0xA,0xD
len3 equ $ - msg3  
msg4 db 0xA,0xD,"la division de -4/-2 es: ",0xA,0xD
len4 equ $ - msg4  

section  .bss
res resb 1

section .text
	global _start

_start:
	
	
	;---------------<imprime los mensajes---------------------
	mov eax, 4   ; llama al sistema (sys_write)
	;eax = 4
	mov ebx, 1	 ;stdout
	mov ecx, msg1 ;msg pantalla
	mov edx, len1 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones

	mov eax, 2
	mov ebx, 2
	
	
	mul ebx
	add eax, '0'
	mov [res], eax


	mov eax, 4   ; llama al sistema (sys_write)
	mov ebx, 1	 ;stdout
	mov ecx, res ;msg pantalla
	mov edx, 1 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones



	;---------------<imprime los mensajes---------------------
	mov eax, 4   ; llama al sistema (sys_write)
	;eax = 4
	mov ebx, 1	 ;stdout
	mov ecx, msg2 ;msg pantalla
	mov edx, len2 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones



	mov eax, -2
	mov ebx, -2
	
	imul ebx
	add eax, '0'
	mov [res], eax


	mov eax, 4   ; llama al sistema (sys_write)
	mov ebx, 1	 ;stdout
	mov ecx, res ;msg pantalla
	mov edx, 1 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones


;---------------<imprime los mensajes---------------------
	mov eax, 4   ; llama al sistema (sys_write)
	;eax = 4
	mov ebx, 1	 ;stdout
	mov ecx, msg3 ;msg pantalla
	mov edx, len3 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones



	mov eax, 4
	mov ebx, 2
	mov edx, 0

	div ebx
	add eax, '0'
	mov [res], eax

	mov eax, 4   ; llama al sistema (sys_write)
	mov ebx, 1	 ;stdout
	mov ecx, res ;msg pantalla
	mov edx, 1 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones

;---------------<imprime los mensajes---------------------
	mov eax, 4   ; llama al sistema (sys_write)
	mov ebx, 1	 ;stdout
	mov ecx, msg4 ;msg pantalla
	mov edx, len4 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones


	mov eax, -4
	mov ebx, -2
	mov edx, 0

	idiv ebx
	add eax, '0'
	mov [res], eax

	mov eax, 4   ; llama al sistema (sys_write)
	mov ebx, 1	 ;stdout
	mov ecx, res ;msg pantalla
	mov edx, 1 ;longitud del mensaje
	int 0x80	;lamada al sistema de interrucciones




	mov eax, 1   ; llama al sistema (sys_write)
	int 0x80	;lamada al sistema de interrucciones













