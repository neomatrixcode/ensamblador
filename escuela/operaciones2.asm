SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	msg1 db "ingrese b", 0xA,0xD
	len1 equ $- msg1 
	msg2 db "ingrese c", 0xA,0xD
	len2 equ $- msg2 
	msg3 db "ingrese d", 0xA,0xD
	len3 equ $- msg3
	msg4 db "ingrese m = 2", 0xA,0xD
	len4 equ $- msg4 
	msg7 db  0x9,"(b+((c*d)/m)):"
	len7 equ $- msg7
	msg8 db  0xA,0xD,"La operacion no se puede realizar el divisor es cero", 0xA,0xD
	len8 equ $- msg8

segment .bss
	num1 resb 2
	num2 resb 2
	num3 resb 2
	num4 resb 2
	res resb 1


section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point
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
	mov ecx, msg3 
	mov edx, len3 
	int 0x80

	mov eax, SYS_LEE 
	mov ebx, STDIN 
	mov ecx, num3 
	mov edx, 2
	int 0x80

	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg4 
	mov edx, len4 
	int 0x80

	;mov eax, SYS_LEE 
	;mov ebx, STDIN 
	;mov ecx, num4 
	;mov edx, 2
	;int 0x80


;--------------------<multiplicacion>----------------------------------
	mov ax, [num2]
	sub ax, '0'	
	mov bx, [num3]
	sub bx, '0'

	mul bx
;--------------------<division>----------------------------------
	mov dx, 0
	mov cx, 2
	cmp cx, 0  ;compara si ecx con cero 
	je  escero  ;si ebx es igual cero, entonces salta a escero

	div cx
;--------------------<(suma)>----------------------------------
	mov bx, [num1]
	sub bx, '0'	

	add ax, bx

	add ax, '0'
	mov [res], ax

	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, msg7 
	mov edx, len7
	int 0x80

	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80


	jmp salir ;salta automaticamente a salir para no ejecutar las
			  ;instrucciones en escero


escero:						
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, msg8 
	mov edx, len8
	int 0x80

salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80