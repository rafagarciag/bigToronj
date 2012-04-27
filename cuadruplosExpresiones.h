#include <stdio.h>

int pilaOperandos [200];
int pilaOperadores[200];
int pilaLlamadas[200];
int filaParams[55];

int indexOperandos=0;
int indexOperadores=0;
int indexLlamadas=0;

void pushPilaOperandos(int x){
	pilaOperandos[indexOperandos]=x;
	indexOperandos++;
}

int popPilaOperandos(){
	indexOperandos--;
	return pilaOperandos[indexOperandos];
}

int peekPilaOperandos(){
	return pilaOperandos[indexOperandos-1];
}

void pushPilaOperadores(int x){
	pilaOperadores[indexOperadores]=x;
	indexOperadores++;
}

int popPilaOperadores(){
	indexOperadores--;
	return pilaOperadores[indexOperadores];
}

int peekPilaOperadores(){
	return pilaOperadores[indexOperadores-1];
}


//Pilas que almacenan los índices de las llamadas a métodos
void pushPilaLlamadas(int x){
	pilaLlamadas[indexLlamadas]=x;
	indexLlamadas++;
}

int popPilaLlamadas(){
	indexLlamadas--;
	return pilaLlamadas[indexLlamadas];
}

int peekPilaLlamadas(){
	return pilaLlamadas[indexLlamadas-1];
}

void imprimePila(){
	int i;
	printf("\nPila operandos\n");
	printf("-------------------\n");
	for(i=0; i<indexOperandos; i++){
		printf("%d\n", pilaOperandos[i]);	
	}
	
}
