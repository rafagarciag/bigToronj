#include <stdio.h>

struct var{
	int tipo;
	char* id;
	int dv;
};

struct proc{
	int tipo;
	char* id;
	int index;
	int totalInt;
	int totalFlo;
	int totalCol;
	int totalStr;
};

struct proc procedimientos[100];
struct var variables[100];

void imprimeProcs(int x){
	int j;
	for(j=0;j<procedimientos[x].index;j++)
		printf("VAR/ tipo: %d, id: %s, dv: %d\n", variables[j].tipo, variables[j].id,variables[j].dv);

}

void agregaProcedimiento(int indexProc, int tipo, char* id, int linea){
	procedimientos[indexProc].id=id;
	procedimientos[indexProc].tipo=tipo;
	imprimeProcs(indexProc);
}

void agregaVariable(int indexProc, int tipo, char* id, int linea){
	variables[procedimientos[indexProc].index].id=id;
	variables[procedimientos[indexProc].index].tipo=tipo;
	switch (tipo){
		case 0:
			variables[procedimientos[indexProc].index].dv=procedimientos[indexProc].totalInt;
			procedimientos[indexProc].totalInt++;
			break;
		case 1:
			variables[procedimientos[indexProc].index].dv=procedimientos[indexProc].totalFlo+100;
			procedimientos[indexProc].totalFlo++;
			break;
		case 2:
			variables[procedimientos[indexProc].index].dv=procedimientos[indexProc].totalCol+200;
			procedimientos[indexProc].totalCol++;
			break;
		case 3:
			variables[procedimientos[indexProc].index].dv=procedimientos[indexProc].totalStr+300;
			procedimientos[indexProc].totalStr++;
			break;
	}
	
	procedimientos[indexProc].index++;
}
