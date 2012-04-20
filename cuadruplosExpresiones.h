#include <stdio.h>

int pilaOperandos [200];
int pilaOperadores[200];
int filaParams[55];

int indexOperandos=0;
int indexOperadores=0;

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
