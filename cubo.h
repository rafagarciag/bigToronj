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

void cuboSyn(int tipo1, int tipo2, int op){

char cubo[4][4][13];
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

	printf("%c \n", cubo[tipo1][tipo2][op]);
}

