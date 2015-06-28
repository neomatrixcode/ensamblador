segment .data 
	let1 db "Hola primer programa en ensamblador", 0xA
	len1 equ $- let1 
	

section  .text
	global _start  
_start: 
	mov eax, 4
	mov ebx, 1 
	mov ecx, let1 
	mov edx, len1 
	int 0x80

salir:
	mov eax, 1 
	xor ebx, ebx 
	int 0x80