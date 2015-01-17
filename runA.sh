#!/bin/bash
gnome-terminal -e "/bin/bash -c 'sudo nasm -f elf  $1; ld -m elf_i386 -s -o $2 $2.o;./$2; echo; read -p 'Pulse_intro_pasa_salir...'; exit; exec /bin/bash'; &"
