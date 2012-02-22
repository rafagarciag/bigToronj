%{
#include <cstdio>
#include <iostream>
using namespace std;

/*Los siguientes metodos y la variable linea
se obtienen desde flex.
*/
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int lineNumber;

void yyerror(const char *s);

%}

//DECLARACION DE TOKENS


%token	DRAWING
%token	INT
%token	FLOAT
%token	COORD
%token	COLOR
%token	CTE_ENTERA
%token	CTE_FLOTANTE
%token	CTE_HEXADECIMAL
%token	POINTER
%token	POINTER_X
%token	POINTER_Y
%token	WIDTH
%token	HEIGHT
%token	TRANS
%token	SCALE
%token	ROTATE_PLACE
%token	ROTATE
%token	PUSH
%token	POP
%token	POP_ORIGIN
%token	POINTER_METHOD
%token	COLOR_METHOD
%token	TRIANGULO
%token	TETRA
%token	CIRCLE
%token	LINE
%token	IF
%token	ELSE
%token	FOR
%token	ID
%token	PUNCOMA
%token	COMA
%token	LLAVEI
%token	LLAVED
%token	PARENI
%token	PAREND
%token	IGUAL
%token	MENOR
%token	MAYOR
%token	DIFF
%token	SUMA
%token	RESTA
%token	MULT
%token	DIVI

%%

//GRAMATICA!

programa	: DRAWING canvas LLAVEI bloque LLAVED {cout << "Un programa" << endl }
			;

canvas		: PARENI CTE_ENTERA COMA CTE_ENTERA COMA CTE_HEXADECIMAL PAREND
			;
		
bloque		:
			| estatuto bloque
			;
			
estatuto	:
			| asignacion
			;

asignacion	:
			|
			;

%%

main(int argc, char* argv[]){
	FILE *dibujo = fopen(argv[1],"r");
	if(!dibujo){
		printf("No existe el archivo");
		return -1;
	}
	yyin = dibujo;
	
	do {
		yyparse();
	} while (!feof(yyin));
}

void yyerror(const char *s) {
	cout << "ERROR DE COMPILACION EN LA LINEA: " << lineNumber << endl;
	// might as well halt now:
	exit(-1);
}
