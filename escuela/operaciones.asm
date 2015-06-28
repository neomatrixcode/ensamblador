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
	msg5 db  0xA,0xD,"la multiplicacion(c*d) es: "
	len5 equ $- msg5 
	msg6 db  0xA,0xD,"la division (c*d)/m entre 2 es: "
	len6 equ $- msg6
	msg7 db  0xA,0xD,"la suma es (b+((c*d)/m)):"
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
write:
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	int 0x80
	ret
	
lee:
	mov eax, SYS_LEE 
	mov ebx, STDIN
	int 0x80
	ret
	
%macro escribe 2
	mov eax, 4 
	mov ebx, 0
	mov ecx, %1 
	mov edx, %2
	
	int 0x80
%endmacro

	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point
	
	escribe msg1,len1

	mov ecx, num1 
	mov edx, 2
	call lee

	escribe msg2, len2

	mov ecx, num2 
	mov edx, 2
	call lee
	
	escribe msg3, len3


	mov ecx, num3 
	mov edx, 2
	call lee

	mov ecx, msg4 
	mov edx, len4 
	call write

	;mov eax, SYS_LEE 
	;mov ebx, STDIN 
	;mov ecx, num4 
	;mov edx, 2
	;int 0x80


;--------------------<multiplicacion>----------------------------------
	
	mov ecx, msg5 
	mov edx, len5 
	call write

	mov ax, [num2]
	sub ax, '0'	
	mov bx, [num3]
	sub bx, '0'

	mul bx

	add ax, '0'
	mov [res], ax

	mov ecx, res 
	mov edx, 1
	call write

;--------------------<division>----------------------------------

	mov ecx, msg6 
	mov edx, len6 
	call write
	
	mov edx, 0	
	mov eax, [res]
	sub eax, '0'
	mov cx, 2
	;mov cx, [num4]
	;sub cx, '0'
	cmp cx, 0  ;compara si ecx con cero 
	je  escero  ;si ebx es igual cero, entonces salta a escero

	div cx
    
	add eax, '0'
	mov [res], eax
	
	;movzx ecx, cx
	mov ecx, res
	mov edx, 1
	call write

	

	
;--------------------<(suma)>----------------------------------
	mov ecx, msg7 
	mov edx, len7 
	call write

	mov ax, [num1]
	sub ax, '0'	
	mov bx, [res]
	sub bx, '0'

	add ax, bx

	add ax, '0'
	mov [res], ax

	mov ecx, res 
	mov edx, 1
	call write


	jmp salir ;salta automaticamente a salir para no ejecutar las
			  ;instrucciones en escero


escero:						
	mov ecx, msg8 
	mov edx, len8
	call write

salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80