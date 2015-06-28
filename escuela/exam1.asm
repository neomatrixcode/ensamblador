%macro escribe 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

segment .data 
	clr    db 0x1b, "[34;47;3m",0x1b, "[2J"
 	clrlen equ $ - clr

	npos db 0x1b, "[1;1f",0x1b, "[44;34m", "__",0x1b, "[2;2f", "_",0x1b,"[3;3f", "_",0x1b, "[4;4f", "_"
	lnpos equ $- npos

segment .text
	global _start  
_start: 

	escribe clr, clrlen
	escribe npos, lnpos

salir:
	mov eax, 1  
	xor ebx, ebx 
	int 0x80