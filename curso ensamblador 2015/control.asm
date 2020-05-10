SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	msg1 db "HALLAR NUMEROS PRIMOS HASTA:", 0xA,0xD
	len1 equ $- msg1 
	msg2 db "2, 3", 0xA,0xD
	len2 equ $- msg2 
	msg3 db "la suma es: "
	len3 equ $- msg3
	msg4 db "la resta es: "
	len4 equ $- msg4 
	msg5 db "la multiplicacion es: "
	len5 equ $- msg5 
	msg6 db "la division es: "
	len6 equ $- msg6
	msg7 db "la division no se puede realizar ebx es cero", 0xA,0xD
	len7 equ $- msg7

segment .bss
	num1 resb 2
	num2 resb 2
	res resb 1
	Limit resb 1
	Guess resb 1

section  .text
	global main  ;must be declared for using gcc
main:  ;tell linker entry point
	

	

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

;--------------------<numeros_primos>----------------------------------
	mov eax, SYS_PRINT 
	mov ebx, STDOUT  ;IMPRIME HALLAR NUMEROS PRIMOS HASTA
	mov ecx, msg1 
	mov edx, len1 
	int 0x80

	mov eax, SYS_LEE  ;lee el primer numero
	mov ebx, STDIN 
	mov ecx, num1 
	mov edx, 2
	int 0x80

	mov [Limit], ecx

	mov eax, SYS_PRINT 
	mov ebx, STDOUT  ;IMPRIME 2,3 los primeros primos
	mov ecx, msg2 
	mov edx, len2 
	int 0x80

	mov dword [Guess], 5 ; Guess = 5;

while_limit: ; while ( Guess <= Limit )
	mov eax,[Guess]
	cmp eax, [Limit]
	jnbe end_while_limit ; se usa jnbe ya que los numeros son sin signo
	mov ebx, 3 ; ebx es factor = 3;

while_factor:
	mov eax,ebx
	mov edx,0
	mul eax ; edx:eax = eax*eax
	jo end_while_factor ; Si la respuesta no cabe en eax

	cmp eax, [Guess]
	jnb end_while_factor ; if !(factor*factor < guess)

	mov eax,[Guess]
	mov edx,0
	div ebx ; edx = edx:eax % ebx
	cmp edx, 0
	je end_while_factor ; if !(guess % factor != 0)

	add ebx,2 ; factor += 2;
	jmp while_factor

end_while_factor:
	je end_if ; if !(guess % factor != 0)
	
	mov eax,[Guess] ; printf("%u\n")
	add eax, '0'
	mov [res], eax
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80

end_if:
	add dword [Guess], 2 ; guess += 2
	jmp while_limit


end_while_limit:
	mov eax, SYS_SALIDA  
	int 0x80