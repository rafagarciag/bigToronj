#include <stdio.h>
//	Operadores 
#define SUMA		0
#define RESTA		1
#define MULT		2
#define DIVI		3
#define MENOR		4
#define MAYOR		5
#define IGUALDAD	6
#define DIFF		7
#define MAYORI		8
#define MENORI		9
#define AND			10
#define OR			11
#define IGUAL		12

//	Tipos de datos
#define	INT			0
#define	FLOAT		1
#define	COLOR		2
#define	STRING		3


int main(){
	char cubo[4][4][13];
//	===========================
//	Operaciones aritmeticas
//	===========================
cubo[INT][INT][SUMA]	=	'i';
cubo[INT][FLOAT][SUMA]	=	'f';	
cubo[INT][COLOR][SUMA]	=	'w';	//error
cubo[INT][STRING][SUMA]	=	'w';	//error
cubo[INT][INT][RESTA]	=	'i';
cubo[INT][FLOAT][RESTA]	=	'f';	
cubo[INT][COLOR][RESTA]	=	'w';	//error	
cubo[INT][STRING][RESTA]=	'w';	//error
cubo[INT][INT][MULT]	=	'i';
cubo[INT][FLOAT][MULT]	=	'f';	
cubo[INT][COLOR][MULT]	=	'w';	//error	
cubo[INT][STRING][MULT]	=	'w';	//error
cubo[INT][INT][DIVI]	=	'i';
cubo[INT][FLOAT][DIVI]	=	'f';	
cubo[INT][COLOR][DIVI]	=	'w';	//error
cubo[INT][STRING][DIVI]	=	'w';	//error

cubo[FLOAT][INT][SUMA]	=	'f';
cubo[FLOAT][FLOAT][SUMA]=	'f';	
cubo[FLOAT][COLOR][SUMA]=	'w';	//error
cubo[FLOAT][STRING][SUMA]=	'w';	//error
cubo[FLOAT][INT][RESTA]	=	'f';
cubo[FLOAT][FLOAT][RESTA]=	'f';	
cubo[FLOAT][COLOR][RESTA]=	'w';	//error	
cubo[FLOAT][STRING][RESTA]=	'w';	//error
cubo[FLOAT][INT][MULT]	=	'f';
cubo[FLOAT][FLOAT][MULT]=	'f';	
cubo[FLOAT][COLOR][MULT]=	'w';	//error	
cubo[FLOAT][STRING][MULT]=	'w';	//error
cubo[FLOAT][INT][DIVI]	=	'f';
cubo[FLOAT][FLOAT][DIVI]=	'f';	
cubo[FLOAT][COLOR][DIVI]=	'w';	//error
cubo[FLOAT][STRING][DIVI]=	'w';	//error

cubo[COLOR][INT][SUMA]	=	'w';	//error
cubo[COLOR][FLOAT][SUMA]=	'w';	//error	
cubo[COLOR][COLOR][SUMA]=	'w';	//error
cubo[COLOR][STRING][SUMA]=	'w';	//error
cubo[COLOR][INT][RESTA]	=	'w';	//error
cubo[COLOR][FLOAT][RESTA]=	'w';	//error	
cubo[COLOR][COLOR][RESTA]=	'w';	//error	
cubo[COLOR][STRING][RESTA]=	'w';	//error
cubo[COLOR][INT][MULT]	=	'w';	//error
cubo[COLOR][FLOAT][MULT]=	'w';	//error	
cubo[COLOR][COLOR][MULT]=	'w';	//error	
cubo[COLOR][STRING][MULT]=	'w';	//error
cubo[COLOR][INT][DIVI]	=	'w';	//error
cubo[COLOR][FLOAT][DIVI]=	'w';	//error	
cubo[COLOR][COLOR][DIVI]=	'w';	//error
cubo[COLOR][STRING][DIVI]=	'w';	//error

cubo[STRING][INT][SUMA]	=	'w';	//error
cubo[STRING][FLOAT][SUMA]=	'w';	//error	
cubo[STRING][COLOR][SUMA]=	'w';	//error
cubo[STRING][STRING][SUMA]=	's';
cubo[STRING][INT][RESTA]=	'w';	//error
cubo[STRING][FLOAT][RESTA]=	'w';	//error	
cubo[STRING][COLOR][RESTA]=	'w';	//error	
cubo[STRING][STRING][RESTA]='w';	//error
cubo[STRING][INT][MULT]	=	'w';	//error
cubo[STRING][FLOAT][MULT]=	'w';	//error	
cubo[STRING][COLOR][MULT]=	'w';	//error	
cubo[STRING][STRING][MULT]=	'w';	//error
cubo[STRING][INT][DIVI]	=	'w';	//error
cubo[STRING][FLOAT][DIVI]=	'w';	//error	
cubo[STRING][COLOR][DIVI]=	'w';	//error
cubo[STRING][STRING][DIVI]=	'w';	//error


//	Comparaciones
cubo[INT][INT][MENOR]	=	'i';
cubo[INT][FLOAT][MENOR]	=	'i';	
cubo[INT][COLOR][MENOR]	=	'w';	//error
cubo[INT][STRING][MENOR]=	'w';	//error
cubo[INT][INT][MAYOR]	=	'i';
cubo[INT][FLOAT][MAYOR]	=	'i';	
cubo[INT][COLOR][MAYOR]	=	'w';	//error
cubo[INT][STRING][MAYOR]=	'w';	//error
cubo[INT][INT][IGUALDAD]	=	'i';
cubo[INT][FLOAT][IGUALDAD]	=	'i';
cubo[INT][COLOR][IGUALDAD]	=	'w';	//error
cubo[INT][STRING][IGUALDAD]	=	'w';	//error
cubo[INT][INT][DIFF]	=	'i';
cubo[INT][FLOAT][DIFF]	=	'i';	
cubo[INT][COLOR][DIFF]	=	'w';	//error
cubo[INT][STRING][DIFF]	=	'w';	//error
cubo[INT][INT][MAYORI]	=	'i';
cubo[INT][FLOAT][MAYORI]=	'i';	
cubo[INT][COLOR][MAYORI]=	'w';	//error
cubo[INT][STRING][MAYORI]=	'w';	//error
cubo[INT][INT][MENORI]	=	'i';
cubo[INT][FLOAT][MENORI]=	'i';	
cubo[INT][COLOR][MENORI]=	'w';	//error
cubo[INT][STRING][MENORI]=	'w';	//error
cubo[INT][INT][AND]	=		'i';
cubo[INT][FLOAT][AND]	=	'i';
cubo[INT][COLOR][AND]	=	'w';	//error
cubo[INT][STRING][AND]=		'w';	//error
cubo[INT][INT][OR]	=		'i';
cubo[INT][FLOAT][OR]	=	'i';
cubo[INT][COLOR][OR]	=	'w';	//error
cubo[INT][STRING][OR]=		'w';	//error

cubo[FLOAT][INT][MENOR]	=	'i';
cubo[FLOAT][FLOAT][MENOR]	=	'i';	
cubo[FLOAT][COLOR][MENOR]	=	'w';	//error
cubo[FLOAT][STRING][MENOR]=	'w';	//error
cubo[FLOAT][INT][MAYOR]	=	'i';
cubo[FLOAT][FLOAT][MAYOR]	=	'i';	
cubo[FLOAT][COLOR][MAYOR]	=	'w';	//error
cubo[FLOAT][STRING][MAYOR]	=	'w';	//error
cubo[FLOAT][INT][IGUALDAD]	=	'i';
cubo[FLOAT][FLOAT][IGUALDAD]	=	'i';
cubo[FLOAT][COLOR][IGUALDAD]	=	'w';	//error
cubo[FLOAT][STRING][IGUALDAD]	=	'w';	//error
cubo[FLOAT][INT][DIFF]	=	'i';
cubo[FLOAT][FLOAT][DIFF]	=	'i';	
cubo[FLOAT][COLOR][DIFF]	=	'w';	//error
cubo[FLOAT][STRING][DIFF]	=	'w';	//error
cubo[FLOAT][INT][MAYORI]	=	'i';
cubo[FLOAT][FLOAT][MAYORI]=	'i';	
cubo[FLOAT][COLOR][MAYORI]=	'w';	//error
cubo[FLOAT][STRING][MAYORI]=	'w';	//error
cubo[FLOAT][INT][MENORI]	=	'i';
cubo[FLOAT][FLOAT][MENORI]=	'i';	
cubo[FLOAT][COLOR][MENORI]=	'w';	//error
cubo[FLOAT][STRING][MENORI]=	'w';	//error
cubo[FLOAT][INT][AND]	=		'i';
cubo[FLOAT][FLOAT][AND]	=	'i';
cubo[FLOAT][COLOR][AND]	=	'w';	//error
cubo[FLOAT][STRING][AND]=		'w';	//error
cubo[FLOAT][INT][OR]	=		'i';
cubo[FLOAT][FLOAT][OR]	=	'i';
cubo[FLOAT][COLOR][OR]	=	'w';	//error
cubo[FLOAT][STRING][OR]=		'w';	//error

cubo[COLOR][INT][MENOR]	=		'w';	//error
cubo[COLOR][FLOAT][MENOR]	=	'w';	//error
cubo[COLOR][COLOR][MENOR]	=	'w';	//error
cubo[COLOR][STRING][MENOR]=		'w';	//error
cubo[COLOR][INT][MAYOR]	=		'w';	//error
cubo[COLOR][FLOAT][MAYOR]	=	'w';	//error
cubo[COLOR][COLOR][MAYOR]	=	'w';	//error
cubo[COLOR][STRING][MAYOR]	=	'w';	//error
cubo[COLOR][INT][IGUALDAD]	=	'w';	//error
cubo[COLOR][FLOAT][IGUALDAD]=	'w';	//error
cubo[COLOR][COLOR][IGUALDAD]=	'w';	//error
cubo[COLOR][STRING][IGUALDAD]=	'w';	//error
cubo[COLOR][INT][DIFF]	=		'w';	//error
cubo[COLOR][FLOAT][DIFF]	=	'w';	//error
cubo[COLOR][COLOR][DIFF]	=	'w';	//error
cubo[COLOR][STRING][DIFF]	=	'w';	//error
cubo[COLOR][INT][MAYORI]	=	'w';	//error
cubo[COLOR][FLOAT][MAYORI]=		'w';	//error
cubo[COLOR][COLOR][MAYORI]=		'w';	//error
cubo[COLOR][STRING][MAYORI]=	'w';	//error
cubo[COLOR][INT][MENORI]	=	'w';	//error
cubo[COLOR][FLOAT][MENORI]=		'w';	//error
cubo[COLOR][COLOR][MENORI]=		'w';	//error
cubo[COLOR][STRING][MENORI]=	'w';	//error
cubo[COLOR][INT][AND]	=		'w';	//error
cubo[COLOR][FLOAT][AND]	=		'w';	//error
cubo[COLOR][COLOR][AND]	=		'w';	//error
cubo[COLOR][STRING][AND]=		'w';	//error
cubo[COLOR][INT][OR]	=		'w';	//error
cubo[COLOR][FLOAT][OR]	=		'w';	//error
cubo[COLOR][COLOR][OR]	=		'w';	//error
cubo[COLOR][STRING][OR]=		'w';	//error

cubo[STRING][INT][MENOR]	=	'w';	//error
cubo[STRING][FLOAT][MENOR]	=	'w';	//error
cubo[STRING][COLOR][MENOR]	=	'w';	//error
cubo[STRING][STRING][MENOR]=	'w';	//error
cubo[STRING][INT][MAYOR]	=	'w';	//error
cubo[STRING][FLOAT][MAYOR]	=	'w';	//error
cubo[STRING][COLOR][MAYOR]	=	'w';	//error
cubo[STRING][STRING][MAYOR]	=	'w';	//error
cubo[STRING][INT][IGUALDAD]	=	'w';	//error
cubo[STRING][FLOAT][IGUALDAD]=	'w';	//error
cubo[STRING][COLOR][IGUALDAD]=	'w';	//error
cubo[STRING][STRING][IGUALDAD]=	'i';	
cubo[STRING][INT][DIFF]	=		'w';	//error
cubo[STRING][FLOAT][DIFF]	=	'w';	//error
cubo[STRING][COLOR][DIFF]	=	'w';	//error
cubo[STRING][STRING][DIFF]	=	'i';
cubo[STRING][INT][MAYORI]	=	'w';	//error
cubo[STRING][FLOAT][MAYORI]=	'w';	//error
cubo[STRING][COLOR][MAYORI]=	'w';	//error
cubo[STRING][STRING][MAYORI]=	'w';	//error
cubo[STRING][INT][MENORI]	=	'w';	//error
cubo[STRING][FLOAT][MENORI]=	'w';	//error
cubo[STRING][COLOR][MENORI]=	'w';	//error
cubo[STRING][STRING][MENORI]=	'w';	//error
cubo[STRING][INT][AND]	=		'w';	//error
cubo[STRING][FLOAT][AND]	=	'w';	//error
cubo[STRING][COLOR][AND]	=	'w';	//error
cubo[STRING][STRING][AND]=		'w';	//error
cubo[STRING][INT][OR]	=		'w';	//error
cubo[STRING][FLOAT][OR]	=		'w';	//error
cubo[STRING][COLOR][OR]	=		'w';	//error
cubo[STRING][STRING][OR]=		'w';	//error

//Asignacion
cubo[INT][INT][IGUAL]	=	'i';
cubo[INT][FLOAT][IGUAL]	=	'w';	//error
cubo[INT][COLOR][IGUAL]	=	'w';	//error
cubo[INT][STRING][IGUAL]=	'w';	//error
cubo[FLOAT][INT][IGUAL]	=	'f';
cubo[FLOAT][FLOAT][IGUAL]=	'f';
cubo[FLOAT][COLOR][IGUAL]=	'w';	//error
cubo[FLOAT][STRING][IGUAL]=	'w';	//error
cubo[COLOR][INT][IGUAL]	=	'w';	//error
cubo[COLOR][FLOAT][IGUAL]=	'w';	//error
cubo[COLOR][COLOR][IGUAL]=	'c';
cubo[COLOR][STRING][IGUAL]=	'w';	//error
cubo[STRING][INT][IGUAL]=	'w';	//error
cubo[STRING][FLOAT][IGUAL]=	'w';	//error
cubo[STRING][COLOR][IGUAL]=	'w';	//error
cubo[STRING][STRING][IGUAL]='s';	//error
 	
 	printf("%c \n", cubo[0][0][0]);
 	return 0;
}


