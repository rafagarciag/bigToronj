%{
#include <stdio.h>
#include <stdlib.h>
#include "tablas.h"
#include "cuadruplosExpresiones.h"

extern int lineNumber;
int yyerror(char *s);

int indexProc=0;
int tipo=1000;

//agregaProcedimiento(indexProc, tipo,"global");

%}

//DECLARACION DE TOKENS
%union 
{
        int number;
        char *string;
}

%token	DRAWING
%token	GLOBAL
%token	<number> INT
%token	<number> FLOAT
%token	<number> COLOR
%token	<number> STRING
%token	VOID
%token	CTE_I
%token	CTE_F
%token	CTE_HEX
%token	CTE_STRING
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
%token	COLOR_METHOD
%token	TRIANGLE
%token	TETRAGON
%token	CIRCLE
%token	LINE
%token	FUNCTION
%token	RETURN
%token	IF
%token	ELSE
%token	FOR
%token	WHILE
%token	<string> ID
%token	PUNCOMA
%token	COMA
%token	LLAVEI
%token	LLAVED
%token	PARENI
%token	PAREND
%token	IGUAL
%token	MENOR
%token	MAYOR
%token	IGUALDAD
%token	MENORI
%token	MAYORI
%token	DIFF
%token	AND
%token	OR
%token	SUMA
%token	RESTA
%token	MULT
%token	DIVI

%%

//GRAMATICA!

programa	: global functions DRAWING canvas bloque {agregaProcedimiento(indexProc, tipo, "drawing", lineNumber); printf("\nCompilación exitosa\n");}
			;
			
global	: /*vacio*/				{agregaProcedimiento(indexProc, 1000, "global", lineNumber); indexProc++;}
		| GLOBAL declaracion global
		;
			
functions	:
			| function functions
			;
			
function	: FUNCTION tipo ID PARENI function1 PAREND LLAVEI bloque_fun return LLAVED	{agregaProcedimiento(indexProc, tipo, $3, lineNumber); indexProc++;}
			| FUNCTION VOID ID PARENI function1 PAREND bloque							{agregaProcedimiento(indexProc, 1000, $3, lineNumber); indexProc++;}
			;
function1	: tipo ids_fun function11
			;
ids_fun		: ID	{{agregaVariable(indexProc, tipo, $1, lineNumber);}}
			;
			
function11	:
			| COMA function1
			;

canvas		: PARENI CTE_I COMA CTE_I COMA CTE_HEX PAREND
			;
		
bloque		: LLAVEI bloque1 LLAVED
			;
bloque1		: /*vacio*/
			| estatuto bloque1
			;
			
bloque_fun	: bloque1
			;
			
estatuto	: asignacion
			| declaracion
			| if
			| for
			| while
			| met_bt_or
			| met_bt
			| dibujo
			;

return		: RETURN exp PUNCOMA
			;

asignacion	: ID IGUAL exp PUNCOMA
			;

declaracion	: tipo ids PUNCOMA 
			;
ids 		: ids_var declaracion1 ids1 
			;
ids_var		: ID 	{
						if(existeVariable(indexProc, $1)==-1000)	
							agregaVariable(indexProc, tipo, $1, lineNumber);
						else
							printf("Error en linea: %d. Variable '%s' ya fue declarada anteriormente.\n",lineNumber,$1);
					}
			;
ids1		: /*vacio*/
			| COMA ids
			;
declaracion1: /*vacio*/
			| IGUAL exp
			;

if			: IF PARENI expresion PAREND bloque else
			;
else		: /*vacio*/
			| ELSE bloque 
			;
			
asignacion_in_line	: ID IGUAL exp
					;

for			: FOR PARENI asignacion_in_line PUNCOMA expresion PUNCOMA asignacion_in_line PAREND bloque
			;

while 		: WHILE PARENI expresion PAREND bloque
			;
			
met_bt_or	: met_bt_or1 PARENI PAREND PUNCOMA
			;
met_bt_or1	: PUSH
			| POP
			| POP_ORIGIN
			;
			
met_bt		: trans
			| rotate
			| scale
			| rotate_place
			| color_method
			;

trans		: TRANS PARENI exp COMA exp PAREND PUNCOMA
			;
rotate		: ROTATE PARENI exp PAREND PUNCOMA
			;
rotate_place: ROTATE_PLACE PARENI exp PAREND PUNCOMA
			;
scale		: SCALE PARENI exp PAREND PUNCOMA
			;

color_method	: COLOR_METHOD PARENI exp PAREND PUNCOMA
				;
			
dibujo		: line
			| triangle
			| tetragon
			| circle
			;

line		: LINE PARENI exp COMA exp PAREND PUNCOMA
			;

triangle	: TRIANGLE PARENI exp COMA exp COMA exp COMA exp PAREND PUNCOMA
			;
			
tetragon	: TETRAGON PARENI exp COMA exp PAREND PUNCOMA
			;
			
circle		: CIRCLE PARENI exp PAREND PUNCOMA
			;
			
exp			: elem exp1
			;
exp1		: /*vacio*/
			| SUMA exp
			| RESTA exp
			;

elem		: factor elem1
			;
elem1		: /*vacio*/
			| MULT elem
			| DIVI elem
			;
			
factor		: PARENI exp PAREND
			| negativo constante
			;
negativo	: /*vacio*/
			| RESTA
			;

expresion	: exp expresion1 expresion11
			;
expresion1	: /*vacio*/
			| MAYOR exp
			| MENOR exp
			| DIFF exp
			| IGUALDAD exp
			| MAYORI exp
			| MENORI exp
			;
			
expresion11	: /*vacio*/
			| AND expresion
			| OR expresion
			;

tipo		: INT		{tipo=$1;}
			| FLOAT		{tipo=$1;}
			| COLOR		{tipo=$1;}
			| STRING	{tipo=$1;}
			;

constante	: ID
			| CTE_I		
			| CTE_F
			| CTE_HEX
			| CTE_STRING
			| WIDTH
			| HEIGHT
			| POINTER
			| POINTER_X
			| POINTER_Y
			;

%%
int yyerror(char *s) {
	printf("Compilation error, line #%d\n", lineNumber);
	
	return (0);
}

int main(void){
	yyparse();
	exit(0);
}


