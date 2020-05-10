# include <stdio.h>
# include <stdlib.h>



unsigned short word = 0x1234; /* se asume sizeof ( short ) == 2 segmentos de numeros (12h 34h)*/
unsigned char * p = (unsigned char *) &word;

main(){

	if ( p[0] == 0x12 )
		printf ("Maquina Big Endian\n el numero 12345678 (16) lo almacena como:\n    12 34 56 78 (16)\n");
	else
		printf ("Maquina Little Endian\n el numero 12345678 (16) lo almacena como:\n    87 65 43 21 (16)\n");

system("pause"); 
}
