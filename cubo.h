#include <stdio.h>

//	Tipos de datos
int	_INT=		0;
int	_FLOAT=		1;
int	_COLOR=		2;
int	_STRING=	3;

//	Operadores 
int _SUMA=		0;
int _RESTA=		1;
int _MULT=		2;
int _DIVI=		3;
int _MENOR=		4;
int _MAYOR=		5;
int _IGUALDAD=	6;
int _DIFF=		7;
int _MAYORI=		8;
int _MENORI=		9;
int _AND=		10;
int _OR=			11;
int _IGUAL=		12;

int tempInt = 0;
int tempFloat = 0;
int tempColor = 0;
int tempString = 0;


char cubo[4][4][13];

void inicializaCubo(){

//	===========================
//	Operaciones aritmeticas
//	===========================
cubo[_INT][_INT][_SUMA]	=	'i';
cubo[_INT][_FLOAT][_SUMA]	=	'f';	
cubo[_INT][_COLOR][_SUMA]	=	'w';	//error
cubo[_INT][_STRING][_SUMA]	=	'w';	//error
cubo[_INT][_INT][_RESTA]	=	'i';
cubo[_INT][_FLOAT][_RESTA]	=	'f';	
cubo[_INT][_COLOR][_RESTA]	=	'w';	//error	
cubo[_INT][_STRING][_RESTA]=	'w';	//error
cubo[_INT][_INT][_MULT]	=	'i';
cubo[_INT][_FLOAT][_MULT]	=	'f';	
cubo[_INT][_COLOR][_MULT]	=	'w';	//error	
cubo[_INT][_STRING][_MULT]	=	'w';	//error
cubo[_INT][_INT][_DIVI]	=	'i';
cubo[_INT][_FLOAT][_DIVI]	=	'f';	
cubo[_INT][_COLOR][_DIVI]	=	'w';	//error
cubo[_INT][_STRING][_DIVI]	=	'w';	//error

cubo[_FLOAT][_INT][_SUMA]	=	'f';
cubo[_FLOAT][_FLOAT][_SUMA]=	'f';	
cubo[_FLOAT][_COLOR][_SUMA]=	'w';	//error
cubo[_FLOAT][_STRING][_SUMA]=	'w';	//error
cubo[_FLOAT][_INT][_RESTA]	=	'f';
cubo[_FLOAT][_FLOAT][_RESTA]=	'f';	
cubo[_FLOAT][_COLOR][_RESTA]=	'w';	//error	
cubo[_FLOAT][_STRING][_RESTA]=	'w';	//error
cubo[_FLOAT][_INT][_MULT]	=	'f';
cubo[_FLOAT][_FLOAT][_MULT]=	'f';	
cubo[_FLOAT][_COLOR][_MULT]=	'w';	//error	
cubo[_FLOAT][_STRING][_MULT]=	'w';	//error
cubo[_FLOAT][_INT][_DIVI]	=	'f';
cubo[_FLOAT][_FLOAT][_DIVI]=	'f';	
cubo[_FLOAT][_COLOR][_DIVI]=	'w';	//error
cubo[_FLOAT][_STRING][_DIVI]=	'w';	//error

cubo[_COLOR][_INT][_SUMA]	=	'w';	//error
cubo[_COLOR][_FLOAT][_SUMA]=	'w';	//error	
cubo[_COLOR][_COLOR][_SUMA]=	'w';	//error
cubo[_COLOR][_STRING][_SUMA]=	'w';	//error
cubo[_COLOR][_INT][_RESTA]	=	'w';	//error
cubo[_COLOR][_FLOAT][_RESTA]=	'w';	//error	
cubo[_COLOR][_COLOR][_RESTA]=	'w';	//error	
cubo[_COLOR][_STRING][_RESTA]=	'w';	//error
cubo[_COLOR][_INT][_MULT]	=	'w';	//error
cubo[_COLOR][_FLOAT][_MULT]=	'w';	//error	
cubo[_COLOR][_COLOR][_MULT]=	'w';	//error	
cubo[_COLOR][_STRING][_MULT]=	'w';	//error
cubo[_COLOR][_INT][_DIVI]	=	'w';	//error
cubo[_COLOR][_FLOAT][_DIVI]=	'w';	//error	
cubo[_COLOR][_COLOR][_DIVI]=	'w';	//error
cubo[_COLOR][_STRING][_DIVI]=	'w';	//error

cubo[_STRING][_INT][_SUMA]	=	'w';	//error
cubo[_STRING][_FLOAT][_SUMA]=	'w';	//error	
cubo[_STRING][_COLOR][_SUMA]=	'w';	//error
cubo[_STRING][_STRING][_SUMA]=	's';
cubo[_STRING][_INT][_RESTA]=	'w';	//error
cubo[_STRING][_FLOAT][_RESTA]=	'w';	//error	
cubo[_STRING][_COLOR][_RESTA]=	'w';	//error	
cubo[_STRING][_STRING][_RESTA]='w';	//error
cubo[_STRING][_INT][_MULT]	=	'w';	//error
cubo[_STRING][_FLOAT][_MULT]=	'w';	//error	
cubo[_STRING][_COLOR][_MULT]=	'w';	//error	
cubo[_STRING][_STRING][_MULT]=	'w';	//error
cubo[_STRING][_INT][_DIVI]	=	'w';	//error
cubo[_STRING][_FLOAT][_DIVI]=	'w';	//error	
cubo[_STRING][_COLOR][_DIVI]=	'w';	//error
cubo[_STRING][_STRING][_DIVI]=	'w';	//error


//	Comparaciones
cubo[_INT][_INT][_MENOR]	=	'i';
cubo[_INT][_FLOAT][_MENOR]	=	'i';	
cubo[_INT][_COLOR][_MENOR]	=	'w';	//error
cubo[_INT][_STRING][_MENOR]=	'w';	//error
cubo[_INT][_INT][_MAYOR]	=	'i';
cubo[_INT][_FLOAT][_MAYOR]	=	'i';	
cubo[_INT][_COLOR][_MAYOR]	=	'w';	//error
cubo[_INT][_STRING][_MAYOR]=	'w';	//error
cubo[_INT][_INT][_IGUALDAD]	=	'i';
cubo[_INT][_FLOAT][_IGUALDAD]	=	'i';
cubo[_INT][_COLOR][_IGUALDAD]	=	'w';	//error
cubo[_INT][_STRING][_IGUALDAD]	=	'w';	//error
cubo[_INT][_INT][_DIFF]	=	'i';
cubo[_INT][_FLOAT][_DIFF]	=	'i';	
cubo[_INT][_COLOR][_DIFF]	=	'w';	//error
cubo[_INT][_STRING][_DIFF]	=	'w';	//error
cubo[_INT][_INT][_MAYORI]	=	'i';
cubo[_INT][_FLOAT][_MAYORI]=	'i';	
cubo[_INT][_COLOR][_MAYORI]=	'w';	//error
cubo[_INT][_STRING][_MAYORI]=	'w';	//error
cubo[_INT][_INT][_MENORI]	=	'i';
cubo[_INT][_FLOAT][_MENORI]=	'i';	
cubo[_INT][_COLOR][_MENORI]=	'w';	//error
cubo[_INT][_STRING][_MENORI]=	'w';	//error
cubo[_INT][_INT][_AND]	=		'i';
cubo[_INT][_FLOAT][_AND]	=	'i';
cubo[_INT][_COLOR][_AND]	=	'w';	//error
cubo[_INT][_STRING][_AND]=		'w';	//error
cubo[_INT][_INT][_OR]	=		'i';
cubo[_INT][_FLOAT][_OR]	=	'i';
cubo[_INT][_COLOR][_OR]	=	'w';	//error
cubo[_INT][_STRING][_OR]=		'w';	//error

cubo[_FLOAT][_INT][_MENOR]	=	'i';
cubo[_FLOAT][_FLOAT][_MENOR]	=	'i';	
cubo[_FLOAT][_COLOR][_MENOR]	=	'w';	//error
cubo[_FLOAT][_STRING][_MENOR]=	'w';	//error
cubo[_FLOAT][_INT][_MAYOR]	=	'i';
cubo[_FLOAT][_FLOAT][_MAYOR]	=	'i';	
cubo[_FLOAT][_COLOR][_MAYOR]	=	'w';	//error
cubo[_FLOAT][_STRING][_MAYOR]	=	'w';	//error
cubo[_FLOAT][_INT][_IGUALDAD]	=	'i';
cubo[_FLOAT][_FLOAT][_IGUALDAD]	=	'i';
cubo[_FLOAT][_COLOR][_IGUALDAD]	=	'w';	//error
cubo[_FLOAT][_STRING][_IGUALDAD]	=	'w';	//error
cubo[_FLOAT][_INT][_DIFF]	=	'i';
cubo[_FLOAT][_FLOAT][_DIFF]	=	'i';	
cubo[_FLOAT][_COLOR][_DIFF]	=	'w';	//error
cubo[_FLOAT][_STRING][_DIFF]	=	'w';	//error
cubo[_FLOAT][_INT][_MAYORI]	=	'i';
cubo[_FLOAT][_FLOAT][_MAYORI]=	'i';	
cubo[_FLOAT][_COLOR][_MAYORI]=	'w';	//error
cubo[_FLOAT][_STRING][_MAYORI]=	'w';	//error
cubo[_FLOAT][_INT][_MENORI]	=	'i';
cubo[_FLOAT][_FLOAT][_MENORI]=	'i';	
cubo[_FLOAT][_COLOR][_MENORI]=	'w';	//error
cubo[_FLOAT][_STRING][_MENORI]=	'w';	//error
cubo[_FLOAT][_INT][_AND]	=		'i';
cubo[_FLOAT][_FLOAT][_AND]	=	'i';
cubo[_FLOAT][_COLOR][_AND]	=	'w';	//error
cubo[_FLOAT][_STRING][_AND]=		'w';	//error
cubo[_FLOAT][_INT][_OR]	=		'i';
cubo[_FLOAT][_FLOAT][_OR]	=	'i';
cubo[_FLOAT][_COLOR][_OR]	=	'w';	//error
cubo[_FLOAT][_STRING][_OR]=		'w';	//error

cubo[_COLOR][_INT][_MENOR]	=		'w';	//error
cubo[_COLOR][_FLOAT][_MENOR]	=	'w';	//error
cubo[_COLOR][_COLOR][_MENOR]	=	'w';	//error
cubo[_COLOR][_STRING][_MENOR]=		'w';	//error
cubo[_COLOR][_INT][_MAYOR]	=		'w';	//error
cubo[_COLOR][_FLOAT][_MAYOR]	=	'w';	//error
cubo[_COLOR][_COLOR][_MAYOR]	=	'w';	//error
cubo[_COLOR][_STRING][_MAYOR]	=	'w';	//error
cubo[_COLOR][_INT][_IGUALDAD]	=	'w';	//error
cubo[_COLOR][_FLOAT][_IGUALDAD]=	'w';	//error
cubo[_COLOR][_COLOR][_IGUALDAD]=	'w';	//error
cubo[_COLOR][_STRING][_IGUALDAD]=	'w';	//error
cubo[_COLOR][_INT][_DIFF]	=		'w';	//error
cubo[_COLOR][_FLOAT][_DIFF]	=	'w';	//error
cubo[_COLOR][_COLOR][_DIFF]	=	'w';	//error
cubo[_COLOR][_STRING][_DIFF]	=	'w';	//error
cubo[_COLOR][_INT][_MAYORI]	=	'w';	//error
cubo[_COLOR][_FLOAT][_MAYORI]=		'w';	//error
cubo[_COLOR][_COLOR][_MAYORI]=		'w';	//error
cubo[_COLOR][_STRING][_MAYORI]=	'w';	//error
cubo[_COLOR][_INT][_MENORI]	=	'w';	//error
cubo[_COLOR][_FLOAT][_MENORI]=		'w';	//error
cubo[_COLOR][_COLOR][_MENORI]=		'w';	//error
cubo[_COLOR][_STRING][_MENORI]=	'w';	//error
cubo[_COLOR][_INT][_AND]	=		'w';	//error
cubo[_COLOR][_FLOAT][_AND]	=		'w';	//error
cubo[_COLOR][_COLOR][_AND]	=		'w';	//error
cubo[_COLOR][_STRING][_AND]=		'w';	//error
cubo[_COLOR][_INT][_OR]	=		'w';	//error
cubo[_COLOR][_FLOAT][_OR]	=		'w';	//error
cubo[_COLOR][_COLOR][_OR]	=		'w';	//error
cubo[_COLOR][_STRING][_OR]=		'w';	//error

cubo[_STRING][_INT][_MENOR]	=	'w';	//error
cubo[_STRING][_FLOAT][_MENOR]	=	'w';	//error
cubo[_STRING][_COLOR][_MENOR]	=	'w';	//error
cubo[_STRING][_STRING][_MENOR]=	'w';	//error
cubo[_STRING][_INT][_MAYOR]	=	'w';	//error
cubo[_STRING][_FLOAT][_MAYOR]	=	'w';	//error
cubo[_STRING][_COLOR][_MAYOR]	=	'w';	//error
cubo[_STRING][_STRING][_MAYOR]	=	'w';	//error
cubo[_STRING][_INT][_IGUALDAD]	=	'w';	//error
cubo[_STRING][_FLOAT][_IGUALDAD]=	'w';	//error
cubo[_STRING][_COLOR][_IGUALDAD]=	'w';	//error
cubo[_STRING][_STRING][_IGUALDAD]=	'i';	
cubo[_STRING][_INT][_DIFF]	=		'w';	//error
cubo[_STRING][_FLOAT][_DIFF]	=	'w';	//error
cubo[_STRING][_COLOR][_DIFF]	=	'w';	//error
cubo[_STRING][_STRING][_DIFF]	=	'i';
cubo[_STRING][_INT][_MAYORI]	=	'w';	//error
cubo[_STRING][_FLOAT][_MAYORI]=	'w';	//error
cubo[_STRING][_COLOR][_MAYORI]=	'w';	//error
cubo[_STRING][_STRING][_MAYORI]=	'w';	//error
cubo[_STRING][_INT][_MENORI]	=	'w';	//error
cubo[_STRING][_FLOAT][_MENORI]=	'w';	//error
cubo[_STRING][_COLOR][_MENORI]=	'w';	//error
cubo[_STRING][_STRING][_MENORI]=	'w';	//error
cubo[_STRING][_INT][_AND]	=		'w';	//error
cubo[_STRING][_FLOAT][_AND]	=	'w';	//error
cubo[_STRING][_COLOR][_AND]	=	'w';	//error
cubo[_STRING][_STRING][_AND]=		'w';	//error
cubo[_STRING][_INT][_OR]	=		'w';	//error
cubo[_STRING][_FLOAT][_OR]	=		'w';	//error
cubo[_STRING][_COLOR][_OR]	=		'w';	//error
cubo[_STRING][_STRING][_OR]=		'w';	//error

//Asignacion
cubo[_INT][_INT][_IGUAL]	=	'i';
cubo[_INT][_FLOAT][_IGUAL]	=	'w';	//error
cubo[_INT][_COLOR][_IGUAL]	=	'w';	//error
cubo[_INT][_STRING][_IGUAL]=	'w';	//error
cubo[_FLOAT][_INT][_IGUAL]	=	'f';
cubo[_FLOAT][_FLOAT][_IGUAL]=	'f';
cubo[_FLOAT][_COLOR][_IGUAL]=	'w';	//error
cubo[_FLOAT][_STRING][_IGUAL]=	'w';	//error
cubo[_COLOR][_INT][_IGUAL]	=	'w';	//error
cubo[_COLOR][_FLOAT][_IGUAL]=	'w';	//error
cubo[_COLOR][_COLOR][_IGUAL]=	'c';
cubo[_COLOR][_STRING][_IGUAL]=	'w';	//error
cubo[_STRING][_INT][_IGUAL]=	'w';	//error
cubo[_STRING][_FLOAT][_IGUAL]=	'w';	//error
cubo[_STRING][_COLOR][_IGUAL]=	'w';	//error
cubo[_STRING][_STRING][_IGUAL]='s';	//error
}

int getDirTemp(char tipo){
	int dir;
	switch(tipo){
		case 'i':
			dir = 4000+tempInt;
			tempInt++;
			return dir; 
			break;
		case 'f':
			dir = 6000 + tempFloat; 
			tempFloat++;
			return dir;
			break;
		case 'c':
			dir = 8000 + tempColor; 
			tempColor++;
			return dir;
			break;
		case 's':
			dir = 10000 + tempString; 
			tempString++;
			return dir;
			break;
	}
}

int getDirTempInt(int tipo){
	int dir;
	switch(tipo){
		case 0:
			dir = 4000+tempInt;
			tempInt++;
			return dir; 
			break;
		case 1:
			dir = 6000 + tempFloat; 
			tempFloat++;
			return dir;
			break;
		case 2:
			dir = 8000 + tempColor; 
			tempColor++;
			return dir;
			break;
		case 3:
			dir = 10000 + tempString; 
			tempString++;
			return dir;
			break;
	}
}

int getTipo(int x){
	/*
	Scope		|	Rango de direcciones
	-------------------------------------
	Globales	|	0		-	1999
		int		|	0		-	499
		float	|	500		-	999
		color	|	1000	-	1499
		string	|	1500	-	1999
		
	Locales		|	2000	-	3999
		int		|	2000	-	2499
		float	|	2500	-	2999
		color	|	3000	-	3499
		string	|	3500	-	3999
	
	Temporales	|	4000	-	11999
		int		|	4000	-	5999
		float	|	6000	-	7999
		color	|	8000	-	9999
		string	|	10000	-	11999
	
	Constantes	|	12000	-	13999
		int		|	12000	-	12499
		float	|	12500	-	12999
		color	|	13000	-	13499
		string	|	13500	-	13999
		
	*/
	int scope = x/2000;
	int mod = 0;
	switch(scope){
		//Globales, locales 
		case 0:
		case 1:
		case 6:
			return (x%2000)/500;
			break;
			
		//Las temporales
		case 2:
		case 3:
		case 4:
		case 5:
			return ((x-4000)%8000)/2000;
			break;
	}
	
	return -1;
}

char cuboSyn(int tipo1, int tipo2, int op){
	int operador=0;
	switch(op){
		//Suma 
		case 100:
			operador = 0; break;
		//Resta
		case 101:
			operador = 1; break;
		//Multiplicacion
		case 102:
			operador = 2; break;
		//Division
		case 103:
			operador = 3; break;
		//Igual
		case 150:
			operador = 12; break;
		//And
		case 200:
			operador = 10; break;
		//Or
		case 201:
			operador = 11; break;
		//Menor
		case 202:
			operador = 4; break;
		//Menor o igual
		case 203:
			operador = 9; break;
		//Mayor
		case 204:
			operador = 0; break;
		//Mayor o igual
		case 205:
			operador = 5; break;
		//Igualdad
		case 206:
			operador = 6; break;
		//Diferente
		case 207:
			operador = 7; break;
	}
	
	int t1 = getTipo(tipo1);
	int t2 = getTipo(tipo2);
	
	if( (t1>=0 && t1<=3) && (t2>=0 && t2<=3)){
		return cubo[t1][t2][operador];
	}
	else{
		return 'w';
	}
}

void imprimeTotalTemporales(char* nombre){
	FILE *ovejota;
	ovejota=fopen(nombre,"a+");
	fprintf(ovejota,"%d\n%d\n%d\n%d\n",tempInt,tempFloat,tempColor,tempString);
	fclose(ovejota);
}

