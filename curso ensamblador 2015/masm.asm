
;masm

--------------------------------------------------------------------------------
.model small ;se define el tipo de modelo, corto (64 kb)

.data ;aquí se definen las variables que se van a ocupar, es el segmento de datos

mensaje db 'hola, este es un ejemplo en ensamblador$'


.code
empieza: ;se define un comienzo del cuerpo del programa

mov ax,@data ;movemos al registro dx, los datos a utilizar
mov ds,ax

             ;en ah siempre se cargan las funciones, en este caso la 09h, permite desplegar un mensaje en pantalla
mov ah,09h  
mov dx,offset mensaje ;movemos al registro dx el contenido de mensaje

; se llama a la interrupcion 21h
int 21h 

; con esta instruccion terminamos el programa 
mov ax, 4c00h
int 21h
 
.stack ;segmento de pila

end empieza ;termina el segmento definido como empieza