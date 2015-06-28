SYS_SALIDA equ 1
SYS_LEE equ 3
STDIN equ 0
SYS_PRINT equ 4
STDOUT equ 1


%macro escribe 2
	mov eax, 4 
	mov ebx, 0
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro
%macro comp 2
	mov ax, [%1]
	sub ax, '0'	
	mov bx, [%2]
	sub bx, '0'

	cmp ax, bx
	jb menor 
	je salir

mayor:
	add ax, '0'
	mov [res], ax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80
	jmp salir

menor:
	add bx, '0'
	mov [res], bx
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80
	jmp salir

%endmacro

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

lee:
	mov eax, SYS_LEE 
	mov ebx, STDIN
	int 0x80
	ret



	global _start  
_start:  

	escribe msg1,len1

	
	mov ecx, num1 
	mov edx, 2
	call lee


	escribe msg2, len2

	mov ecx, num2 
	mov edx, 2
	call lee 

	escribe msg4, len4


	comp num1, num2



salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80
