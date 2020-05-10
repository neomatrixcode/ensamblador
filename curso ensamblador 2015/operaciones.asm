SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	msg1 db "ingrese numero1", 0xA,0xD
	len1 equ $- msg1 
	msg2 db "ingrese numero2", 0xA,0xD
	len2 equ $- msg2 
	msg3 db  0xA,0xD,"la suma es: "
	len3 equ $- msg3
	msg4 db  0xA,0xD,"la resta es: "
	len4 equ $- msg4 
	msg5 db  0xA,0xD,"la multiplicacion es: "
	len5 equ $- msg5 
	msg6 db  0xA,0xD,"la division de numero1/2 es: "
	len6 equ $- msg6
	msg7 db  0xA,0xD,"la division no se puede realizar ecx es cero", 0xA,0xD
	len7 equ $- msg7
	msg8 db  0xA,0xD,"----------------<>---------------------------", 0xA,0xD
	len8 equ $- msg8

segment .bss
	num1 resb 2
	num2 resb 2
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

;--------------------<suma>----------------------------------
	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg3 
	mov edx, len3 
	int 0x80

	mov eax, [num1]
	sub eax, '0'	
	mov ebx, [num2]
	sub ebx, '0'

	add eax, ebx

	add eax, '0'
	mov [res], eax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

;--------------------<resta>----------------------------------
	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg4 
	mov edx, len4 
	int 0x80

	mov eax, [num1]
	sub eax, '0'	
	mov ebx, [num2]
	sub ebx, '0'

	sub eax, ebx

	add eax, '0'
	mov [res], eax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

;--------------------<multiplicacion>----------------------------------
	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg5 
	mov edx, len5 
	int 0x80

	mov eax, [num1]
	sub eax, '0'	
	mov ebx, [num2]
	sub ebx, '0'

	mul ebx

	add eax, '0'
	mov [res], eax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

;--------------------<division>----------------------------------
	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg6 
	mov edx, len6 
	int 0x80

	mov eax, [num1]
	sub eax, '0'
	xor edx,edx	
	mov ecx, 2; pueba con el valor 2
	;sub ecx, '0'

	cmp ecx, 0  ;compara si ecx con cero 
	je  escero  ;si ebx es igual cero, entonces salta a escero

	div ecx

	add eax, '0'
	mov [res], eax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

	mov eax, SYS_PRINT 
	mov ebx, STDOUT 
	mov ecx, msg8 
	mov edx, len8 
	int 0x80

	jmp salir ;salta automaticamente a salir para no ejecutar las
			  ;instrucciones en escero

escero:						
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, msg7 
	mov edx, len7
	int 0x80

salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80