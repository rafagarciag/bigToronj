%{
#include <stdio.h>
#include <stdlib.h>
#include "tablas.h"
#include "cuadruplosExpresiones.h"
#include "generacionCuadruplos.h"

extern int lineNumber;
int yyerror(char *s);

int indexProc=0;
int indexParams=0;
int tipo=1000;

//Variables temporales
int temporales=400;
//////////////////////

//Cuadruplos expresiones
int operando;
int operador;
////////////////////////

//Cuadruplos while
int falso;
int retorno;
//////////////////

char* aux_asignacion;

//Agrega _PointerX y _PointerY a la tabla de globales


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
%token	<string> CTE_I
%token	<string> CTE_F
%token	<string> CTE_HEX
%token	<string> CTE_STRING
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
%token	NOT
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


programa	: a_pointers global functions DRAWING canvas bloque {
				agregaProcedimiento(indexProc, 3, tipo, "drawing", lineNumber); 
				printf("\nCompilación exitosa\n");
				imprimeConstantes();imprimeCuadruplos();
			}
			;

a_pointers	:	{agregaVariable(indexProc, 0, "_POINTERX", lineNumber);agregaVariable(indexProc, 0, "_POINTERY", lineNumber);}
			;

a_pointers	:	{agregaVariable(indexProc, 0, "_POINTERX", lineNumber);agregaVariable(indexProc, 0, "_POINTERY", lineNumber);}
			;

global	: /*vacio*/		{agregaProcedimiento(indexProc, 3, 1000, "global", lineNumber); indexProc++;}
		| GLOBAL declaracion global
		;

functions	:
			| function functions
			;

function	: FUNCTION tipo ID PARENI function1 PAREND LLAVEI bloque_fun return LLAVED	{
				agregaProcedimiento(indexProc, indexParams, tipo, $3, lineNumber); 
				indexProc++;
				indexParams=0;
			}
			| FUNCTION VOID ID PARENI function1 PAREND bloque	{
				agregaProcedimiento(indexProc, indexParams, 1000, $3, lineNumber); 
				indexProc++;
				indexParams=0;
			}
			;
function1	: param_paso1 ids_fun function11
			;
param_paso1	: INT	{ 
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| FLOAT	{ 
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| COLOR	{ 
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| STRING	{ 
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			;
			
ids_fun		: ID	{agregaVariable(indexProc, tipo, $1, lineNumber);}
			;

function11	:
			| COMA function1
			;

canvas		: PARENI CTE_I COMA CTE_I COMA CTE_HEX PAREND {
				agregaConstante(100, $2);
				agregaConstante(101, $4);
			}
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

asignacion	: ID IGUAL exp PUNCOMA	{
										if(existeVariable(indexProc, $1)==-1000)
											printf("Error en linea: %d. Variable '%s' no existe.\n",lineNumber,$1);
										else
											generaCuadruplo(150,popPilaOperandos(),-1,existeVariable(indexProc, $1));
									}
			;

declaracion	: tipo ids PUNCOMA 
			;
ids 		: ids_var declaracion1 ids1 
			;
ids_var		: ID 	{
						if(existeVariable(indexProc, $1)==-1000){
							agregaVariable(indexProc, tipo, $1, lineNumber);
							aux_asignacion=$1;
						}
						else
							printf("Error en linea: %d. Variable '%s' ya fue declarada anteriormente.\n",lineNumber,$1);
					}
			;
ids1		: /*vacio*/
			| COMA ids
			;
declaracion1: /*vacio*/
			| IGUAL exp	{generaCuadruplo(150,popPilaOperandos(),-1,existeVariable(indexProc, aux_asignacion));}
			;

if			: IF PARENI expresion PAREND if_paso_1 bloque else
			;
if_paso_1	:	{
					pushPilaSaltos(0);
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
				}
			;
if_paso_2	:	{
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
				}
			;


else		: /*vacio*/ if_paso_2
			| ELSE else_paso_1 bloque else_paso_2
			;
else_paso_1 :	{
					generaCuadruplo(300, -1, -1, 0);
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
					pushPilaSaltos(-1);
				}
			;
else_paso_2 :	{
					rellenaGoTo(popPilaSaltos(), getPointerCuadruplos());
				}
			;

asignacion_in_line	: ID IGUAL exp
					;

for			: FOR PARENI asignacion_in_line PUNCOMA expresion PUNCOMA asignacion_in_line PAREND bloque
			;

while 		: WHILE PARENI while_paso_1 expresion PAREND while_paso_2 bloque while_paso_3
			;
while_paso_1:	{
					pushPilaSaltos(0);
				}
			;
while_paso_2:	{
					pushPilaSaltos(0);
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
				}
			;
while_paso_3:	{
					falso=popPilaSaltos();
					retorno=popPilaSaltos();
					generaCuadruplo(300,-1,-1,retorno);
					rellenaGoToF(falso, getPointerCuadruplos());
				}
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

exp			: elem exp_paso_2 exp1 
			;
exp1		: /*vacio*/
			| exp11 exp
			;			
exp11		: SUMA 	{pushPilaOperadores(100);}
			| RESTA	{pushPilaOperadores(101);}
			;

elem		: factor exp_paso_3 elem1 
			;
elem1		: /*vacio*/
			| elem11 elem
			;
elem11		: MULT	{pushPilaOperadores(102);}
			| DIVI	{pushPilaOperadores(103);}
			;

factor		: PARENI exp_paso_4 exp exp_paso_5 PAREND
			| negativo constante exp_paso_1
			;
negativo	: /*vacio*/
			| RESTA	
			;

expresion	: elem_log expresion_paso1 expresion1
			;
expresion1	:
			| expresion11 expresion
			;
expresion11	: AND	{pushPilaOperadores(200);}
			| OR	{pushPilaOperadores(201);}
			;

elem_log	: factor_log expresion_paso2 elem_log1
			;
elem_log1	:
			| elem_log11 elem_log
			;
elem_log11	: MENOR		{pushPilaOperadores(202);}
			| MENORI	{pushPilaOperadores(203);}
			| MAYOR		{pushPilaOperadores(204);}
			| MAYORI	{pushPilaOperadores(205);}
			| IGUALDAD	{pushPilaOperadores(206);}
			| DIFF		{pushPilaOperadores(207);}
			;

factor_log	: PARENI expresion PAREND
			| negacion exp
			;

negacion	: /*vacio*/
			| NOT	{pushPilaOperadores(208);}
			;

expresion_paso1:	{
						if(peekPilaOperadores()==200||peekPilaOperadores()==201){
							generaCuadruplo(popPilaOperadores(), popPilaOperandos(), popPilaOperandos(), temporales);
							pushPilaOperandos(temporales++);
						}
					}
				;
expresion_paso2	: 	{
						if(peekPilaOperadores()>=202 && peekPilaOperadores()<=207){
							generaCuadruplo(popPilaOperadores(), popPilaOperandos(), popPilaOperandos(), temporales);
							pushPilaOperandos(temporales++);
						}
					}
				;

tipo		: INT		{tipo=$1;}
			| FLOAT		{tipo=$1;}
			| COLOR		{tipo=$1;}
			| STRING	{tipo=$1;}
			;

constante	: ID	{
						if((operando=existeVariable(indexProc, $1))==-1000)
							printf("Error en linea: %d. Variable '%s' no existe.\n",lineNumber,$1);
					}
			| CTE_I			{agregaConstante(0, $1);operando=existeCteInt($1);}
			| CTE_F			{agregaConstante(1, $1);operando=existeCteFloat($1);}
			| CTE_HEX		{agregaConstante(2, $1);operando=existeCteHex($1);}
			| CTE_STRING	{agregaConstante(3, $1);operando=existeCteString($1);}
			| WIDTH			{operando=1200;}
			| HEIGHT		{operando=1201;}
			| POINTER_X		{operando=0;}
			| POINTER_Y		{operando=1;}
			;

exp_paso_1	:	{pushPilaOperandos(operando)}
			;
exp_paso_2	:	{
					if(peekPilaOperadores()==100||peekPilaOperadores()==101){
						generaCuadruplo(popPilaOperadores(),popPilaOperandos(),popPilaOperandos(),temporales);
						pushPilaOperandos(temporales++);
					}
				}
			;

exp_paso_3	:	{
					if(peekPilaOperadores()==102||peekPilaOperadores()==103){
						generaCuadruplo(popPilaOperadores(),popPilaOperandos(),popPilaOperandos(),temporales);
						pushPilaOperandos(temporales++);
					}
				}
			;

exp_paso_4	:	{pushPilaOperadores(9999);}
			;

exp_paso_5	:	{popPilaOperadores();}
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
