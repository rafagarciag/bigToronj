#include <stdio.h>
//Pointer del cuadruplo actual
int pointer=0;

//Metodo usado para obtener el pointer del cuadruploa ctual
int getPointerCuadruplos(){
	return pointer;
}

//La estructura cuadruplo almacena la informacion de cada cuadruplo generado por el compilador
struct cuadruplo{
	int operador;
	int operando1;
	int operando2;
	int resultado;
};

//La pila de saltos es utilizada cuando se manejan cuadruplos con codigos Go To
struct cuadruplo cuadruplos[10000];

int pilaSaltos [200];
int indexSaltos=0;
//Metodos se control de la pila se saltos.
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


//Este metodo se encarga de generar un cuadruplo nuevo y guardarlo en el arreglo de cuadruplos
void generaCuadruplo(int operador, int operando1, int operando2, int resultado){
	cuadruplos[pointer].operador=operador;
	cuadruplos[pointer].operando1=operando1;
	cuadruplos[pointer].operando2=operando2;
	cuadruplos[pointer].resultado=resultado;
	pointer++;
}


//Este metodo es llamado cuando se necesita rellenar un cuadriplo GoTo que tiene pendiente su cuadruplo destino
void rellenaGoTo(int index, int valor){
	cuadruplos[index].resultado=valor;
}

//Este metodo es llamado cuando se necesita rellenar un cuadriplo GoTo  en falso que tiene pendiente su cuadruplo destino
void rellenaGoToF(int index, int valor){
	cuadruplos[index].resultado=valor;
}

//Este metodo se encarga de guardar los cuadruplos que se generaron al momento de compilacion en el archivo objeto resultante.
void imprimeCuadruplos(char* nombre){
	FILE *ovejota;
	ovejota=fopen(nombre,"a+");
	
	fprintf(ovejota,"%d\n", pointer);
	int i;
	for(i=0;i<pointer;i++){
		fprintf(ovejota,"%d,%d,%d,%d\n",cuadruplos[i].operador,cuadruplos[i].operando1,cuadruplos[i].operando2,cuadruplos[i].resultado);	
	}
	fclose(ovejota);
}
