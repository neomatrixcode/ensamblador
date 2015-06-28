; Constantes de modo de apertura
;0_RDONLY equ 00000000h
;0_WRONLY equ 00000001h
;0_RDWR equ 00002h
;0_APPEND equ 02000h
;0_CREAT equ 00100h
; Y permisos
S_IRUSR equ 00400h
S_IWUSR equ 00200h
; Constantes para movernos
SEEK_SET equ 0
SEEK_CUR equ 1
SEEK_END equ 2

segment .data

MsgError db "Se produce un error",0
lon equ $ -MsgError
;archivo db "/home/neomatrix/c0de/tarea/nuevo/prueba.txt",0
archivo db "/dev/vcs2",0
;archivo db "/dev/pts/0"


segment .bss
idarchivo resd 1
id resb 1
Contenido resb 16384



segment .text
	global _start  
_start:  

; Abrimos el archivo de destino
mov eax,5         ; the number of the syscall 'open'
mov ebx,archivo
;mov ecx,2         ; read and write file access flags
mov ecx, 0  		;solo lectura
;mov edx,7777h     ; all file permissions flags
mov edx, 0
int 80h              ; interrupt 80h

test eax,eax
jz Error

mov dword[idarchivo] , eax
add eax, '0'
mov [id], eax


;lectura del contenido del archivo
mov eax, 3
mov ebx, [idarchivo]
mov ecx, Contenido
mov edx, 16384
int 80h

;test eax,eax
;jz Error

;impresion del contenido
mov eax, 4
mov ebx, 1 
mov ecx, Contenido
mov edx, 16384
int 80h


;escritura en el archivo
;mov eax, 4
;mov ebx, [idarchivo]
;mov ecx, MsgError
;mov edx, lon
;int 80h


;cierre
mov eax, 6
mov ebx, [idarchivo]
mov ecx, 0
mov edx, 0
int 80h



jmp Salir ; terminar

Error:
; Mostramos el mensaje de error
mov eax, 4
mov ebx, 1
mov ecx, MsgError
mov edx, lon
int 80h

Salir:
; Devolvemos el control al sistema
mov eax, 1
xor ebx,ebx
int 0x80


