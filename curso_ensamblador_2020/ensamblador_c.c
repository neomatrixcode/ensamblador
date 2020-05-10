#include <stdio.h>
#include <stdint.h>

int suma(int dato,int dato2){
	int salida;

	asm volatile(
		"addl %%ebx, %%eax"
		:"=a" (salida)
		:"a" (dato), "b" (dato2)
	);

	return salida;
}

int main(){
	int resultado = 0;
	resultado = suma(2,2);
	printf("el resultado es: %d\n",resultado );
	return 0;
}