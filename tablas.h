#include <stdio.h>
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
	int totalInt;
	int totalFlo;
	int totalCol;
	int totalStr;
};

struct proc procedimientos[100];
struct var globales[100];
struct var variables[100][2];

void imprimeProcs(int x){
	int j;
	for(j=0;j<procedimientos[x].index;j++){
		if(x==0)
			printf("VAR/ tipo: %d, id: %s, dv: %d\n", variables[j][0].tipo, variables[j][0].id,variables[j][0].dv);
		else
			printf("VAR/ tipo: %d, id: %s, dv: %d\n", variables[j][1].tipo, variables[j][1].id,variables[j][1].dv);
	}
}

void agregaProcedimiento(int indexProc, int tipo, char* id, int linea){
	procedimientos[indexProc].id=id;
	procedimientos[indexProc].tipo=tipo;
	imprimeProcs(indexProc);
}

void agregaVariable(int indexProc, int tipo, char* id, int linea){
	int offset=0, tabla=0;
	if (indexProc > 0){
		offset=200;
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
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalFlo+50;
			procedimientos[indexProc].totalFlo++;
			break;
		case 2:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalCol+100;
			procedimientos[indexProc].totalCol++;
			break;
		case 3:
			variables[procedimientos[indexProc].index][tabla].dv=offset+procedimientos[indexProc].totalStr+150;
			procedimientos[indexProc].totalStr++;
			break;
	}
	
	procedimientos[indexProc].index++;
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
















