SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	msg1 db "ingrese el numero1 (0..9)", 0xA,0xD
	len1 equ $ - msg1 
	msg2 db "ingrese el numero2 (0..9)", 0xA,0xD
	len2 equ $ - msg2 
	msg3 db "lasuma es: "
	len3 equ $ - msg3
	msg4 db "<--",0xA,0xD
	len4 equ $ - msg4

segment .bss
	num1 resb 2
	num2 resb 2
	res resb 1


section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point
	mov eax, SYS_WRITE 
	mov ebx, STDOUT 
	mov ecx, msg1 
	mov edx, len1 
	int 0x80

	mov eax, SYS_READ 
	mov ebx, STDIN 
	mov ecx, num1 
	mov edx, 2
	int 0x80

	mov eax, SYS_WRITE 
	mov ebx, STDOUT 
	mov ecx, msg2 
	mov edx, len2 
	int 0x80

	mov eax, SYS_READ 
	mov ebx, STDIN 
	mov ecx, num2 
	mov edx, 2
	int 0x80

	mov eax, SYS_WRITE 
	mov ebx, STDOUT 
	mov ecx, msg3 
	mov edx, len3 
	int 0x80

;--------------------------------------<>------------------------------------	
;muve el primer numero introducido al registtro eax y el segundo a ebx y le quita "0" 
;para pasar el ASCII a un numero decimal

	
	mov eax, [num1]
	sub eax, '0'	
	mov ebx, [num2]
	sub ebx, '0'

; hace la suma eax += ebx
	
	add eax, ebx

; para pasar el resultado en eax a ASCII se le agrega un "0"
	
	add eax, '0'

; ubica el dato ASCII en eax en la variable res o ubucacion de memoria res
	
	mov [res], eax

; imprime el resultado de la suma
 
	mov eax, SYS_WRITE 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

	mov eax, SYS_WRITE 
	mov ebx, STDOUT
	mov ecx, msg4 
	mov edx, len4
	int 0x80

salida:
	mov eax, SYS_EXIT 
	xor ebx, ebx  ;EBX=0 INDICA EL CODIGO DE RETORNO (0=SIN ERRORES)
	int 0x80
