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

char cubo[100][100][100];
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
cubo[INT][FLOAT][IGUALDAD]	=	'i';			//duda
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
cubo[INT][FLOAT][AND]	=	'w';	//error		duda
cubo[INT][COLOR][AND]	=	'w';	//error
cubo[INT][STRING][AND]=		'w';	//error
cubo[INT][INT][OR]	=		'i';
cubo[INT][FLOAT][OR]	=	'w';	//error		duda
cubo[INT][COLOR][OR]	=	'w';	//error
cubo[INT][STRING][OR]=		'w';	//error

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

