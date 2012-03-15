#include <stdio.h>

struct var{
	char* id;
	int tipo;
	int dv;
};

struct proc{
	char* id;
	int tipo;
	int total=0;
	struct var variables[100];
};

struct proc procedimientos[100];

void agregaProcedimiento(int indexProc, int tipo, char* id){
	procedimientos[indexProc].id=id;
	procedimientos[indexProc].tipo=tipo;
}

void agregaVariable(int indexProc, int indexVar, char* id, int tipo, int dv){
	procedimientos[indexProc].total++;
	procedimientos[indexProc].variables[indexVar].id=id;
	procedimientos[indexProc].variables[indexVar].tipo=tipo;
	procedimientos[indexProc].variables[indexVar].dv=dv;
}

int main(){
	
	
	
	
	
	procedimientos[0].id = "Primer Proc";
	procedimientos[0].tipo = 0;
	
	procedimientos[0].variables[0].id = "primer variable";
	procedimientos[0].variables[0].tipo = 0;
	procedimientos[0].variables[0].dv=0;
	
	procedimientos[0].variables[1].id="Segunda variable";
	procedimientos[0].variables[1].tipo=1;
	procedimientos[0].variables[1].dv=1;
	
	procedimientos[1].id = "Segundo Proc";
	procedimientos[1].tipo = 0;
	
	procedimientos[1].variables[0].id = "primer variable";
	procedimientos[1].variables[0].tipo = 0;
	procedimientos[1].variables[0].dv=0;
	
	procedimientos[1].variables[1].id="Segunda variable";
	procedimientos[1].variables[1].tipo=1;
	procedimientos[1].variables[1].dv=1;
	
	printf("primer proc, segunda variable, TIPO: %d", procedimientos[0].variables[1].tipo);

	return 0;
}
