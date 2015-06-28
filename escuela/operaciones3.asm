SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	msg7 db  0x9,"(b+((c*d)/m))= "
	len7 equ $- msg7
	msg8 db  0xA,0xD,"La operacion no se puede realizar el divisor es cero", 0xA,0xD
	len8 equ $- msg8

segment .bss
	res resb 1


section  .text

write:
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	int 0x80
	ret
	

	global _start
_start:  ;tell linker entry point



	mov ax, 4 ; b=4
	mov bx, 3 ; c=3

	mul bx

	mov bx, 2 ; m=2

	cmp bx, 0
	je escero

	div bx

	mov bx, 3 ; a=3

	add ax, bx

	add ax, '0'
	mov [res], ax

	
	mov ecx, msg7
	mov edx, len7
	call write


	mov ecx, res 
	mov edx, 1
	call write


	jmp salir

escero:						
	
	mov ecx, msg8 
	mov edx, len8
	call write

salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80