section  .data ;Data segment
	userMsg db 'ingrese un numero: ' 
	lenUserMsg equ $-userMsg  ;longitud de userMsg
	dispMsg db 'el numero ingresado es: '
	lenDispMsg equ $-dispMsg 

section .bss  ;dato en dondee almacenara los numero a ingresar
	num resb 5

section .text  ;Code Segment
	global _start
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg   
	mov edx, lenUserMsg 
	int 80h    ;imprime ingrese un numero en la pantalla
	

	mov eax, 3
	mov ebx, 2
	mov ecx, num;en donde almacenar los numeros 
	mov edx, 5  ;almacenara un numero de 5 elementos 
	int 80h


	mov eax, 4
	mov ebx, 1
	mov ecx, dispMsg
	mov edx, lenDispMsg
	int 80h ;imprime el numero en la pantalla es: en la pantalla


	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 5
	int 80h ;imprime el contenido de num en pantalla que es de tamañano 5


	; codigo de salida
	mov eax, 1
	mov ebx, 0
	int 80h