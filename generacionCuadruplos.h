#include <stdio.h>
int pointer=0;

struct cuadruplo{
	int operador;
	int operando1;
	int operando2;
	int resultado;
};

struct cuadruplo cuadruplos[10000];

void generaCuadruplo(int operador, int operando1, int operando2, int resultado){
	cuadruplos[pointer].operador=operador;
	cuadruplos[pointer].operando1=operando1;
	cuadruplos[pointer].operando2=operando2;
	cuadruplos[pointer].resultado=resultado;
	pointer++;
}

void imprimeCuadruplos(){
	int i;
	for(i=0;i<pointer;i++)
		printf("%d, %d ,%d ,%d\n",cuadruplos[i].operador,cuadruplos[i].operando1,cuadruplos[i].operando2,cuadruplos[i].resultado);
}
