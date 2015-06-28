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
	msg db 0x1b, "[1;30f",0x1b, "[44;34m", "___",0x1b, "[1;70f",0x1b, "[43;33m", "___",0x1b, "[2;10f",0x1b,"[45;35m", "___",0x1b, "[6;30f",0x1b, "[41;31m", "___",0x1b, "[46;36m", "___",0x1b, "[34;47m",0x1b, "[10;10f"
	len equ $- msg


	clr    db 0x1b, "[34;47;3m",0x1b, "[2J",0x1b, "[5;20f"
 	clrlen equ $ - clr


 	avd  db 0x1b, "[32;42m",0x1b, "I"
	lavd equ $ - avd

	avi  db 0x1b, "[32;42m", 0x1b, "[D"
	lavi equ $ - avi

	ava  db 0x1b,"[32;42m",0x1b, "I", 0x1b, "[A"
	lava equ $ - ava

	avb  db 0x1b,"[32;42m",0x1b, "I", 0x1b, "[B"
	lavb equ $ - avb

timeval:
	tv_sec  dd 0
    tv_usec dd 0

segment .bss
	num1 resb 2
	
segment .text



clrscr:
   escribe clr,clrlen
   RET


	global _start  
_start:  


	Call clrscr
    escribe msg, len

mover:
    ;escribe avi, lavi
    ;escribe avd, lavd
    escribe ava, lava
    espera 1, 0
    escribe avb, lavb
    espera 1, 0

	jmp mover
	


salir:
	
	mov eax, 1  
	xor ebx, ebx 
	int 0x80
