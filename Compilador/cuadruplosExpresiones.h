#include <stdio.h>

//Las pilas de Operandos y Operadores son usadas para la generacion de cuadruplos de expresiones
int pilaOperandos [200];
int pilaOperadores[200];

//La pila de llamadas es utilizada para almacenar las llamadas que se generan en los metodos
int pilaLlamadas[200];
int filaParams[55];

//Los siguientes indices se utilizan para llevar el control de las pilas
int indexOperandos=0;
int indexOperadores=0;
int indexLlamadas=0;

/*
En este archivo solo se manejan las pilas mencionadas anteriormente.
Los metodos que se encuentran aqui son metodos clasicos del manejo de pilas como
el push, pop y peek.
*/

void pushPilaOperandos(int x){
	if(x>=0){
		pilaOperandos[indexOperandos]=x;
		indexOperandos++;
	}
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
