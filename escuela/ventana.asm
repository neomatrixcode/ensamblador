%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
%macro espera 2
	mov dword [tv_sec], %1
  	mov dword [tv_usec], %2
  	mov eax, 162
  	mov ebx, timeval
  	mov ecx, 0
  	int 0x80
%endmacro
segment .data 
	msg db 0x1b, "[5;30f",0x1b, "[44;34m", "_____",0x1b, "[43;33m", "_____",0x1b, "[6;30f",0x1b, "[42;32m", "_____",0x1b,"[45;35m", "_____",0x1b, "[7;30f",0x1b, "[41;31m", "_____",0x1b, "[46;36m", "_____"
	len equ $- msg

	msg1 db 0x1b, "[5;30f",0x1b, "[43;33m", "_____",0x1b, "[42;32m", "_____",0x1b, "[6;30f",0x1b, "[45;35m", "_____",0x1b,"[41;31m", "_____",0x1b, "[7;30f",0x1b, "[46;36m", "_____",0x1b, "[44;34m", "_____"
	len1 equ $- msg1

	msg2 db 0x1b, "[5;30f",0x1b, "[42;32m", "_____",0x1b, "[45;35m", "_____",0x1b, "[6;30f",0x1b, "[41;31m", "_____",0x1b,"[46;36m", "_____",0x1b, "[7;30f",0x1b, "[44;34m", "_____",0x1b, "[43;33m", "_____"
	len2 equ $- msg2
	
	msg3 db 0x1b, "[5;30f",0x1b, "[45;35m", "_____",0x1b, "[41;31m", "_____",0x1b, "[6;30f",0x1b, "[46;36m", "_____",0x1b,"[44;34m", "_____",0x1b, "[7;30f",0x1b, "[43;33m", "_____",0x1b, "[42;32m", "_____"
	len3 equ $- msg3

	msg4 db 0x1b, "[5;30f",0x1b, "[41;31m", "_____",0x1b, "[46;36m", "_____",0x1b, "[6;30f",0x1b, "[44;34m", "_____",0x1b,"[43;33m", "_____",0x1b, "[7;30f",0x1b, "[42;32m", "_____",0x1b, "[45;35m", "_____"
	len4 equ $- msg4

	msg5 db 0x1b, "[5;30f",0x1b, "[46;36m", "_____",0x1b, "[44;34m", "_____",0x1b, "[6;30f",0x1b, "[43;33m", "_____",0x1b,"[42;32m", "_____",0x1b, "[7;30f",0x1b, "[45;35m", "_____",0x1b, "[41;31m", "_____"
	len5 equ $- msg5

	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr
 	pos  db 0x1b, "[10;10f", 0x1b, "[30;47;3m"
	lpos equ $ - pos
timeval:
	tv_sec  dd 0
    tv_usec dd 0

segment .bss
	num1 resb 2
	
segment .text

lee:
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

clrscr:
   escribe clr,clrlen
   RET


	global _start  
_start:  


	Call clrscr
    escribe msg, len

    mov ecx, num1
    mov edx, 1
    call lee

mover:
    escribe msg, len
    espera 1, 0
	escribe msg1, len1
	espera 1, 0
	escribe msg2, len2
	espera 1, 0
	escribe msg3, len3
	espera 1, 0
	escribe msg4, len4
	espera 1, 0
	escribe msg5, len5
	espera 1, 0
	jmp mover
	


salir:
	
	mov eax, 1  
	xor ebx, ebx 
	int 0x80
