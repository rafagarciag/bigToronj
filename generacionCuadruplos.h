#include <stdio.h>
int pointer=0;

int getPointerCuadruplos(){
	return pointer;
}

int pilaSaltos [200];
int indexSaltos=0;

void pushPilaSaltos(int offset){
	pilaSaltos[indexSaltos]=pointer+offset;
	indexSaltos++;
}

int popPilaSaltos(){
	indexSaltos--;
	return pilaSaltos[indexSaltos];
}

int peekPilaSaltos(){
	return pilaSaltos[indexSaltos-1];
}

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

void rellenaGoTo(int index, int valor){
	cuadruplos[index].resultado=valor;
}

void rellenaGoToF(int index, int valor){
	cuadruplos[index].resultado=valor;
}

void imprimeCuadruplos(){
	int i;
	for(i=0;i<pointer;i++)
		printf("%d: (%d, %d ,%d ,%d)\n",i, cuadruplos[i].operador,cuadruplos[i].operando1,cuadruplos[i].operando2,cuadruplos[i].resultado);
}
