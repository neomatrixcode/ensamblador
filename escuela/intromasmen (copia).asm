SYS_SALIDA equ 1
SYS_LEE equ 3
STDIN equ 0
SYS_PRINT equ 4
STDOUT equ 1

segment .data 
	msg1 db "dame un numero", 0xA
	len1 equ $- msg1 
	msg2 db 0xA,"dame otro numero", 0xA
	len2 equ $- msg2 
	msg3 db  0xA,0x9,"los numeros son igules "
	len3 equ $- msg3

	msg4 db  0xA,0x9,"el mayor es:  "
	len4 equ $- msg4

segment .bss
	num1 resb 2
	num2 resb 2
	res resb 1


segment .text
	global _start  
_start:  
	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg1 
	mov edx, len1 
	int 0x80

	mov eax, SYS_LEE 
	mov ebx, STDIN 
	mov ecx, num1 
	mov edx, 2
	int 0x80

	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg2 
	mov edx, len2 
	int 0x80

	mov eax, SYS_LEE 
	mov ebx, STDIN 
	mov ecx, num2 
	mov edx, 2
	int 0x80

	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg4
	mov edx, len4 
	int 0x80


	mov ax, [num1]
	sub ax, '0'	
	mov bx, [num2]
	sub bx, '0'

	cmp ax, bx
	ja mayor
	je salir

	add bx, '0'
	mov [res], bx
	jmp imp

mayor:
	add ax, '0'
	mov [res], ax

imp:
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80
	jmp salir


salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80
