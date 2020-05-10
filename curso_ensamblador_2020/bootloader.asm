USE16

ORG 0X7C00

JMP INICIO

INICIO:
mov al, "h"
mov ah, 0x0e
int 0x10

mov al, "o"
mov ah, 0x0e
int 0x10

mov al, "l"
mov ah, 0x0e
int 0x10

mov al, "a"
mov ah, 0x0e
int 0x10

mov al, "-"
mov ah, 0x0e
int 0x10

mov al, "m"
mov ah, 0x0e
int 0x10

mov al, "u"
mov ah, 0x0e
int 0x10

mov al, "n"
mov ah, 0x0e
int 0x10

mov al, "d"
mov ah, 0x0e
int 0x10

mov al, "o"
mov ah, 0x0e
int 0x10

hlt

times 510-($-$$) db 0
dw 0xaa55