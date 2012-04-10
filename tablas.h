//ES MEJOR TENER UNA TABLA DE FIRMAS DE PARAMS Y A CADA PROCEIMIENTO QUE SI TENGA PARAMS LE PONEMOS EL INDICE
//DE LA FIRMA QUE LE CORRESPONDE

//HAY QUE CAMBIAR EL NUMERO DE LAS VARIABLES Y CONSTANTES
//ES MEJOR QUE SEAN UN VERGO!!!!!!



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct var{
	int tipo;
	char* id;
	int dv;
};

struct proc{
	int tipo;
	char* id;
	int index;
	int index_params;
	int totalInt;
	int totalFlo;
	int totalCol;
	int totalStr;
	int params[55];
	int cuadruploInicio;
};


//Almacenan las CONSTANTES enteras, flotantes, hexadecimales y string
struct cteInt{
	int valor;
	int dv;
};
struct cteFloat{
	float valor;
	int dv;
};
struct cteHex{
	char* valor;
	int dv;
};
struct cteString{
	char *valor;
	int dv;
};

struct proc procedimientos[100];
struct var variables[2000][2];

//CONSTANTES
int offsetConstantes = 12000;

struct cteInt constantesInt[50];
int offsetInt = 0; //Casillas 0 y 1 se reservan para _WIDTH y _HEIGHT
int i_cteInt = 2;

struct cteFloat constantesFloat[50];
int offsetFloat = 500;
int i_cteFloat = 0;

struct cteHex constantesHex[50];
int offsetHex = 1000;
int i_cteHex = 0;

struct cteString constantesString[50];
int i_cteString = 0;
int offsetString = 1500;

void imprimeProcs(int x){
	int j;
	printf("\nProc %s\n", procedimientos[x].id);
	
	//La firma
	printf("Firma: ");
	for(j=0; j<procedimientos[x].index_params; j++){
		switch (procedimientos[x].params[j]){
			case 0:
				printf("int  ");
				break;
			case 1:
				printf("float  ");
				break;
			case 2:
				printf("color  ");
				break;
			case 3:
				printf("string  ");
				break;
			default:
				printf("tipo de dato irreconocible e irreconciliable");
		}
	}
	printf("\n");
	
	//Cuadruplo de inicio
	printf("Cuadruplo de inicio: %d\n", procedimientos[x].cuadruploInicio);
	
	for(j=0;j<procedimientos[x].index;j++){
		if(x==0)
			printf("VAR/ tipo: %d, id: %s, dv: %d\n", variables[j][0].tipo, variables[j][0].id,variables[j][0].dv);
		else
			printf("VAR/ tipo: %d, id: %s, dv: %d\n", variables[j][1].tipo, variables[j][1].id,variables[j][1].dv);
	}
}

void imprimeConstantes(char* nombre){

	FILE *ovejota;
	ovejota=fopen(nombre,"w+");

	int i;
	printf("\nLAS CONSTANTES\n");

	printf("ENTEROS\n");
	for(i=0; i<i_cteInt; i++){
		fprintf(ovejota,"%d,%d\n",constantesInt[i].dv, constantesInt[i].valor);
		printf("Constante %d con valor: %d\n", constantesInt[i].dv, constantesInt[i].valor);
	}

	printf("FLOTANTES\n");
	for(i=0; i<i_cteFloat; i++){
		fprintf(ovejota,"%d,%f\n",constantesFloat[i].dv, constantesFloat[i].valor);
		printf("Constante %d con valor: %f\n", constantesFloat[i].dv, constantesFloat[i].valor);
	}

	printf("HEX\n");
	for(i=0; i<i_cteHex; i++){
		fprintf(ovejota,"%d,%s\n",constantesHex[i].dv, constantesHex[i].valor);
		printf("Constante %d con valor: %s\n", constantesHex[i].dv, constantesHex[i].valor);
	}

	printf("STRING\n");
	for(i=0; i<i_cteString; i++){
		fprintf(ovejota,"%d,%s\n",constantesString[i].dv, constantesString[i].valor);
		printf("Constante %d con valor: %s\n", constantesString[i].dv, constantesString[i].valor);
	}
	fprintf(ovejota,"##\n");
	fclose(ovejota);
}

void agregaProcedimiento(int indexProc, int indexParams, int tipo, char* id, int linea){
	procedimientos[indexProc].id=id;
	procedimientos[indexProc].tipo=tipo;
	procedimientos[indexProc].index_params = indexParams;
	imprimeProcs(indexProc);
}

int existeVariable(int indexProc, char* id){
	int i;
	if(indexProc>0){
		for(i=0;i<procedimientos[indexProc].index;i++)
			if(!strcmp(variables[i][1].id, id))
				return variables[i][1].dv;
	}
	for(i=0;i<procedimientos[0].index;i++)
		if(!strcmp(variables[i][0].id, id))
			return variables[i][0].dv;
	return -1000;
}

int existeProcedimiento(int indexProc, char*id){
	int i;
	int cmp;
	for(i=0; i <indexProc; i++){
		cmp = strcmp(procedimientos[i].id, id);
		if(cmp==0){
			return i;
		}
	}
	return -1;
}

void agregaVariable(int indexProc, int tipo, char* id, int linea){
	int offset=0, tabla=0;
	if (indexProc > 0){
		offset=2000;
		tabla=1;
	}

	variables[procedimientos[indexProc].index][tabla].id=id;
	variables[procedimientos[indexProc].index][tabla].tipo=tipo;
	switch (tipo){
		case 0:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalInt;
			procedimientos[indexProc].totalInt++;
			break;
		case 1:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalFlo+500;
			procedimientos[indexProc].totalFlo++;
			break;
		case 2:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalCol+1000;
			procedimientos[indexProc].totalCol++;
			break;
		case 3:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalStr+1500;
			procedimientos[indexProc].totalStr++;
			break;
	}

	procedimientos[indexProc].index++;
}

void agregaParams(int indexProc, int tipo, int index){
	procedimientos[indexProc].params[index] = tipo;
}

void agregaCuadruploInicio(int indexProc, int inicio){
	procedimientos[indexProc].cuadruploInicio=inicio;
}

int existeCteInt(char* x){
	int i;
	int y = atoi(x);
	for(i=0;i<i_cteInt;i++)
		if(constantesInt[i].valor==y)
			return constantesInt[i].dv;
	return -1000;
}

int existeCteFloat(char* x){
	int i;
	float y = atof(x);
	for(i=0;i<i_cteFloat;i++)
		if(constantesFloat[i].valor==y)
			return constantesFloat[i].dv;
	return -1000;
}

int existeCteHex(char* x){
	int i;
	for(i=0;i<i_cteHex;i++)
		if(!strcmp(constantesHex[i].valor, x))
			return constantesHex[i].dv;
	return -1000;
}

int existeCteString(char* x){
	int i;
	for(i=0;i<i_cteString;i++)
		if(!strcmp(constantesString[i].valor, x))
			return constantesString[i].dv;
	return -1000;
}

void agregaConstante(int tipo, char* valor){
	switch(tipo){
		//INT
		case 0:
			if(existeCteInt(valor)==-1000){
				constantesInt[i_cteInt].valor = atoi(valor);
				constantesInt[i_cteInt].dv = offsetConstantes + offsetInt + i_cteInt;
				i_cteInt++;
			}
			break;

		//FLOAT
		case 1:
			if(existeCteFloat(valor)==-1000){
				constantesFloat[i_cteFloat].valor = atof(valor);
				constantesFloat[i_cteFloat].dv = offsetConstantes + offsetFloat + i_cteFloat;
				i_cteFloat++;
			}
			break;

		//HEX
		case 2:
			if(existeCteHex(valor)==-1000){
				constantesHex[i_cteHex].valor = valor;
				constantesHex[i_cteHex].dv = offsetConstantes + offsetHex+ i_cteHex;
				i_cteHex++;
			}
			break;

		//STRING
		case 3:
			if(existeCteString(valor)==-1000){
				constantesString[i_cteString].valor = valor;
				constantesString[i_cteString].dv = offsetConstantes + offsetString +i_cteString;
				i_cteString++;
			}
			break;

		//Constante _WIDTH
		case 100:
			constantesInt[0].valor = atoi(valor);
			constantesInt[0].dv = offsetConstantes;
			break;

		//Constante _HEIGHT
		case 101:
			constantesInt[1].valor = atoi(valor);
			constantesInt[1].dv = offsetConstantes+1;
			break;
	}
}
