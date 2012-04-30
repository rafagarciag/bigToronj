%{
#include <stdio.h>
#include <stdlib.h>
#include "cubo.h"
#include "tablas.h"
#include "cuadruplosExpresiones.h"
#include "generacionCuadruplos.h"

extern int lineNumber;
extern FILE *yyin;
int yyerror(char *s);

int indexProc=0;
int indexParams=0;
int tipo=1000;
int tipo_ret = 1000;
int llamada;
char* id_func;
int cuad_main;

//Errores de compilacion
int error=0;

//Variables temporales
int temporales=8000;

//////////////////////

//Cuadruplos expresiones
int operando;
int operador;
int aux_negativo=1;
//Bandera para variables negativas
int bit_negativo=0;
//Bandera para expresiones lógicas negadas
int bit_negacion=0;
////////////////////////

//Cuadruplos while
int falso;
int retorno;
//////////////////

char* aux_asignacion;

//String con el nombre del programa
char nombre[256];

//Número de parámetro al llamar una funcion del usuario
int contParam = 0;

//Incremental cuando se llama a un return
int dir=1;
int dirTemp=0;


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
%token	<number> VOID
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
%token	MODULO
%token 	PRINT
%token	PRINTL
%token	READ

%%

//GRAMATICA!


programa	: global programa_paso1 functions DRAWING canvas programa_paso2 bloque {
				agregaProcedimiento(indexProc, 3, tipo, "drawing", lineNumber); 

				if(error==0){
					printf("\n===========================\n");
					printf("\nCompilación exitosa\n");
					printf("\n===========================\n");
					imprimeTotalGlobales(nombre);
					imprimeTotalTemporales(nombre);
					imprimeConstantes(nombre);
					imprimeProcedimientos(nombre,indexProc+1);
					imprimeCuadruplos(nombre);
					imprimePila();
					imprimePilaSaltos();
				}
				else{
					printf("\n=============================================\n");
					printf("\nSe detectaron %d error(es) de compilación\n", error);
					printf("\n=============================================\n");
				}
				
			}
			;
programa_paso1:	{
					//GOTO al Main
					generaCuadruplo(300, -1, -1, 0);
				}
			 ;
programa_paso2: {
					rellenaGoTo(cuad_main, getPointerCuadruplos());
				}
			;
global	: /*vacio*/	{
						agregaProcedimiento(indexProc, 3, 1000, "global", lineNumber); 
						cuad_main = getPointerCuadruplos();
						indexProc++;
					}
		| GLOBAL declaracion global
		;

functions	:
			| function functions
			;

function	: FUNCTION tipo_ret id_func PARENI function1 PAREND cuadruplo_inicio LLAVEI bloque_fun return ret LLAVED	{
				int indice = existeProcedimiento(indexProc, id_func);
				if(indice<0 || indice == indexProc){
					agregaProcedimiento(indexProc, indexParams, tipo_ret, id_func, lineNumber); 
					indexProc++;
					indexParams=0;
				}
				else{
					error++;
					printf("¡Error!, función '%s' ha sido definida múltiples veces\n", id_func);
				}
			}
			| FUNCTION voiding id_func PARENI function1 PAREND cuadruplo_inicio bloque ret	{
				int indice = existeProcedimiento(indexProc, id_func);
				if(indice<0 || indice == indexProc){
					
					agregaProcedimiento(indexProc, indexParams, tipo_ret, id_func, lineNumber);
					procedimientos[indexProc].retorno = -99;
					indexProc++;
					indexParams=0;
				}
				else{
					error++;
					printf("¡Error!, función '%s' ha sido definida múltiples veces\n", id_func);
				}
			}
			;
voiding		: VOID		{tipo_ret=$1;procedimientos[indexProc].tipo=tipo_ret;}
			;
tipo_ret	: INT		{tipo_ret=$1;procedimientos[indexProc].tipo=tipo_ret;}
			| FLOAT		{tipo_ret=$1;procedimientos[indexProc].tipo=tipo_ret;}
			| COLOR		{tipo_ret=$1;procedimientos[indexProc].tipo=tipo_ret;}
			| STRING	{tipo_ret=$1;procedimientos[indexProc].tipo=tipo_ret;}
			;
id_func		: ID	{ 
						procedimientos[indexProc].id = $1; id_func=$1; 
						
						//Variable global de la funcion
						agregaVariable(0,tipo_ret,$1,lineNumber);
						
						

						//Asignar a una temporal el valor de retorno
						dirTemp = getDirTempInt(getTipoProc(indexProc));
						agregaReturn(indexProc, dirTemp);
						
					}
			;

cuadruplo_inicio	:	{	//Guardar el numero de cuadrupo en el que inicia la funcion
							agregaIndexParams(indexProc,indexParams);
							agregaCuadruploInicio(indexProc, getPointerCuadruplos());
						}
					;
ret			:	{
					generaCuadruplo(600, -1, -1, -1);
				}
			;
function1	:	 
			|	param_paso1 ids_fun function11
			;
param_paso1	: INT	{
				tipo=0;
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| FLOAT	{
				tipo=1;
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| COLOR	{
				tipo=2;
				agregaParams(indexProc, $1, indexParams); 
				indexParams++;
			}
			| STRING	{
				tipo=3;
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
				//_WIDTH
				agregaConstante(100, $2, 0);
				//_HEIGHT
				agregaConstante(101, $4, 0);
				//-_WIDTH
				agregaConstante(102, $2, 0);
				//-_HEIGHT
				agregaConstante(103, $4, 0);
				//Color de fondo
				agregaConstante(104, $6, 0);
			}
			;

bloque		: LLAVEI bloque1 LLAVED
			;
bloque1		: /*vacio*/
			| estatuto bloque1
			;

bloque_fun	: bloque1
			;

func_usuario_void	: func_usuario PUNCOMA
					;
func_usuario: id_func_usuario PARENI func_usuario1 PAREND func_usuario111 {
				//ERA
				int i = existeProcedimiento(indexProc, id_func);
				int x;
				int direccion;
				int dir_ret_local;
				char nombre_ret[10];
				int offsets[4];
				offsets[0]=2000;
				offsets[1]=2500;
				offsets[2]=3000;
				offsets[3]=3500;
				int indices[4];
				indices[0]=0;
				indices[1]=0;
				indices[2]=0;
				indices[3]=0;
				if(i>0){
					printf("Chedando numero de params contParam=%d, index_params=%d\n", contParam, procedimientos[i].index_params);
					if(contParam==procedimientos[i].index_params){
						//ERA
						generaCuadruplo(999, -1, -1, i);
						for(x=0; x<contParam; x++){
							direccion=offsets[procedimientos[i].params[x]]+indices[procedimientos[i].params[x]];
							generaCuadruplo(602, filaParams[x], -1, direccion);
							indices[procedimientos[i].params[x]]+=1;
						}
					}
					else{
						error++;
						printf("Error en línea: %d. Número de parámetros inválido para llamada a función %s\n", lineNumber, id_func);
					}
										
					contParam=0;
					
					//gosub
					generaCuadruplo(601, -1, -1, i);
					
					//Generar una variable local donde se guardará el return y
					//	empujarla a la pila
					dir_ret_local=agregaVariable(indexProc, procedimientos[i].tipo, "retorno111222333", lineNumber);
					printf("Imprimiendo indice de cosa= %d %s retorno=%d\n", i, procedimientos[i].id, procedimientos[i].retorno);
					generaCuadruplo(150, getDirReturn(i), -1, dir_ret_local);
					pushPilaOperandos(dir_ret_local);
					//operador=dir_ret_local;

				}
				else{
					error++;
					printf("La función %s no ha sido definida anteriormente", id_func);
				}
			}
			;
id_func_usuario	:	ID	{
							id_func=$1;
							//fondo falso
							pushPilaOperadores(9999);
						}
				;
func_usuario1	: 
				| param func_usuario11
				;
				
param		:	exp	{
					//Parámetros
					int p = popPilaOperandos();
					
					//Validación semántica con la firma del procedimiento
					
					if(getTipo(p)==procedimientos[existeProcedimiento(indexProc,id_func)].params[contParam]){
						filaParams[contParam] = p;
						printf("Incrementando contParam\n");
						contParam++;
					}
					else{
						error++;
						printf("Error en línea %d. Parámetros enviados a método no corresponden al tipo esperado\n", lineNumber);
						printf("Validacion semantica de firma %d == %d\n", getTipo(p), procedimientos[existeProcedimiento(indexProc,id_func)].params[contParam]);
					}
					
					//generaCuadruplo(602, popPilaOperandos(), -1, 666);
				}
			;

func_usuario11:	/*vacio*/
			| COMA func_usuario1
			;
func_usuario111	:	{
						//Remover fondo falso
						popPilaOperadores();
					}	
				

estatuto	: asignacion
			| declaracion
			| if
			| for
			| while
			| met_bt_or
			| met_bt
			| dibujo
			| func_usuario_void
			| print
			| printl
			| read
			;

return		: RETURN exp PUNCOMA	{
				//printf("\nRETURN %d  == %d\n", getTipo(peekPilaOperandos()), getTipoProc(indexProc));
				//imprimePila();
				printf("Peek = %d\n", getTipo(peekPilaOperandos()));
				printf("Tipo proc = %d\n", tipo_ret);
				
				//Validación semántica
				if(getTipo(peekPilaOperandos())==tipo_ret){
					
					int valor = popPilaOperandos();
					//Asignar a una temporal el valor de retorno
					//int dirTemp = getDirTempInt(getTipoProc(indexProc));
					generaCuadruplo(150, valor, -1, dirTemp);
					//agregaReturn(indexProc, dirTemp);
					llamada = indexProc;
					//Antiguo return
					//generaCuadruplo(603, -1, -1, valor);
					
				}
				else{
					error++;
					printf("Error en línea: %d. Tipo de retorno inválido\n", lineNumber);
				}
				/*
				if(getTipo(peekPilaOperandos())==getTipoProc(indexProc)){
					//cuadruplo return
					generaCuadruplo(603, -1, -1, peekPilaOperandos());
				}
				*/
			}
			;

asignacion	: ID IGUAL exp PUNCOMA	{
										int dv = existeVariable(indexProc, $1);
										if(dv==-1000){
											error++;
											printf("Error en línea: %d. Variable '%s' no existe.\n",lineNumber,$1);
										}
										else{
											int aux1 = popPilaOperandos();
											char tipo = cuboSyn(dv, aux1, 150);
											if(tipo != 'w'){
												generaCuadruplo(150,aux1,-1,dv);
											}
											else{
												error++;
												printf("\nError de mezcla de tipos en asignación, línea número %d\n", lineNumber);
											}
										}
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
						else{
							error++;
							printf("Error en línea: %d. Variable '%s' ya fue declarada anteriormente.\n",lineNumber,$1);
						}
					}
			;
ids1		: /*vacio*/
			| COMA ids
			;
declaracion1: /*vacio*/
			| IGUAL exp	{
					int aux1 = popPilaOperandos();
					int dv = existeVariable(indexProc, aux_asignacion);
					char tipo = cuboSyn(dv,aux1,150);
					//printf("Asignación espuria (%d = %d)", dv, aux1);
					if(tipo!='w'){
						generaCuadruplo(150,aux1,-1,dv);
					}
					else{
						error++;
						printf("\nError de mezcla de tipos en declaración, línea número %d\n", lineNumber);
					}
			}
			;

if			: IF PARENI expresion PAREND if_paso_1 bloque else
			;
if_paso_1	:	{
					pushPilaSaltos(0);
					//GOTOF
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
					//GOTO
					generaCuadruplo(300, -1, -1, 0);
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
					pushPilaSaltos(-1);
				}
			;
else_paso_2 :	{
					rellenaGoTo(popPilaSaltos(), getPointerCuadruplos());
				}
			;

asignacion_in_line	: ID IGUAL exp 	{
										int dv = existeVariable(indexProc, $1);
										if(dv==-1000){
											error++;
											printf("Error en línea: %d. Variable '%s' no existe.\n",lineNumber,$1);
										}
										else{
											int aux1 = popPilaOperandos();
											char tipo = cuboSyn(dv, aux1, 150);
											if(tipo != 'w'){
												generaCuadruplo(150,aux1,-1,dv);
											}
											else{
												error++;
												printf("\nError de mezcla de tipos en asignación (in line), línea número %d\n", lineNumber);
											}
										}
									}
					;

for			: FOR PARENI asignacion_in_line PUNCOMA for_paso_1 expresion for_paso_2 PUNCOMA for_paso_3 asignacion_in_line for_paso_4 PAREND bloque for_paso_5
			;
for_paso_1	:	{ pushPilaSaltos(0); }
			;
for_paso_2	:	{ 	pushPilaSaltos(0);
					//GOTOF
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
					pushPilaSaltos(0);
					//GOTO
					generaCuadruplo(300, -1, -1, 0);
				}
			;
for_paso_3	:	{ pushPilaSaltos(0); }
			;
for_paso_4	:	{ 
					int temp = popPilaSaltos();
					rellenaGoTo(popPilaSaltos(), getPointerCuadruplos()+1);
					pushPilaSaltos(temp - getPointerCuadruplos());
					
					int temp2=popPilaSaltos();
					int temp3=popPilaSaltos();
					generaCuadruplo(300, -1, -1, popPilaSaltos());
					pushPilaSaltos(temp3-getPointerCuadruplos());
					pushPilaSaltos(temp2-getPointerCuadruplos());
				}
			;
for_paso_5	:	{
					//GOTO
					generaCuadruplo(300, -1, -1, popPilaSaltos());
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
				}
			;

while 		: WHILE PARENI while_paso_1 expresion PAREND while_paso_2 bloque while_paso_3
			;
while_paso_1:	{
					pushPilaSaltos(0);
				}
			;
while_paso_2:	{
					pushPilaSaltos(0);
					//GOTOF
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
				}
			;
while_paso_3:	{
					falso=popPilaSaltos();
					retorno=popPilaSaltos();
					//GOTO
					generaCuadruplo(300,-1,-1,retorno);
					rellenaGoToF(falso, getPointerCuadruplos());
				}
			;

met_bt_or	: met_bt_or1 PARENI PAREND PUNCOMA
			;
met_bt_or1	: PUSH			{generaCuadruplo(500,-1,-1,-1);}
			| POP			{generaCuadruplo(501,-1,-1,-1);}
			| POP_ORIGIN	{generaCuadruplo(502,-1,-1,-1);}
			;

met_bt		: trans
			| rotate
			| scale
			| rotate_place
			| color_method
			;

trans		: TRANS PARENI exp COMA exp PAREND PUNCOMA	{
					generaCuadruplo(450,popPilaOperandos(),popPilaOperandos(),-1);
					
			}
			;
rotate		: ROTATE PARENI exp PAREND PUNCOMA			{generaCuadruplo(451,popPilaOperandos(),-1,-1);	}
			;
rotate_place: ROTATE_PLACE PARENI exp PAREND PUNCOMA
			;
scale		: SCALE PARENI exp PAREND PUNCOMA
			;

color_method	: COLOR_METHOD PARENI exp PAREND PUNCOMA {generaCuadruplo(452,popPilaOperandos(),-1,-1);}
				;

dibujo		: line
			| triangle
			| tetragon
			| circle
			;

line		: LINE PARENI exp COMA exp PAREND PUNCOMA		{generaCuadruplo(400,popPilaOperandos(),popPilaOperandos(),-1);	}
			;

triangle	: TRIANGLE PARENI exp COMA exp COMA exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(401,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());generaCuadruplo(401,popPilaOperandos(),popPilaOperandos(),-1);}
			;

tetragon	: TETRAGON PARENI exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(402,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());}
			;

circle		: CIRCLE PARENI exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(403,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());}
			;

exp			: elem exp_paso_2 exp1 
			;
exp1		: /*vacio*/
			| exp11 exp
			;			
exp11		: SUMA 	{pushPilaOperadores(100);}
			| RESTA	{pushPilaOperadores(101);}
			;

elem		: factor reset_negativo exp_paso_3 elem1 
			;
elem1		: /*vacio*/
			| elem11 elem
			;
elem11		: MULT	{pushPilaOperadores(102);}
			| DIVI	{pushPilaOperadores(103);}
			;

factor		: negativo PARENI exp_paso_4 exp exp_paso_5 PAREND
			| negativo constante exp_paso_1
			;
negativo	: /*vacio*/
			| RESTA	negativo{
					//aux_negativo=-1;
					bit_negativo++;
					
				}
			;
			
reset_negativo	:	{	
						if(bit_negativo%2!=0){
							//Multiplica por (-1) el valor de la expresion
							int aux_dir=getDirTemp('i');
							generaCuadruplo(102,12004,popPilaOperandos(),aux_dir);
							pushPilaOperandos(aux_dir);
						}
						aux_negativo=1;
						bit_negativo=0;
					}	
				;

expresion	: elem_log expresion_paso1 expresion1
			;
expresion1	:
			| expresion11 expresion
			;
expresion11	: AND	{pushPilaOperadores(200);}
			| OR	{pushPilaOperadores(201);}
			;

elem_log	: factor_log expresion_paso2 elem_log1 reset_negacion
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

factor_log	: negacion PARENI expresion PAREND
			| negacion exp
			;

negacion	: /*vacio*/
			| NOT	{
						pushPilaOperadores(208);
						bit_negacion++;
					}
			;
reset_negacion	:	{
						if(bit_negacion%2!=0){
							int aux_dir = getDirTemp('i');
							
							generaCuadruplo(208, -1, -1, popPilaOperandos());
							pushPilaOperandos(aux_dir);
							printf("Haciendo push negacion de dir: %d", aux_dir);
						}
						bit_negacion=0;
					}
				;

expresion_paso1:	{
						if(peekPilaOperadores()==200||peekPilaOperadores()==201){
							int aux1=popPilaOperandos();
							int aux2=popPilaOperandos();
							int op=popPilaOperadores();
							char tipo = cuboSyn(aux2, aux1, op);
							int dir;
							if(tipo !='w'){
								dir = getDirTemp(tipo);
								generaCuadruplo(op,aux2,aux1,dir);
								pushPilaOperandos(dir);
							}
							else{
								error++;
								printf("\nError de mezcla de tipos en suma, línea número %d\n  [%d %d %d]", lineNumber, aux1, op, aux2);
							}
						}
					}
				;
expresion_paso2	: 	{
						if(peekPilaOperadores()>=202 && peekPilaOperadores()<=207){
							int aux1=popPilaOperandos();
							int aux2=popPilaOperandos();
							int op=popPilaOperadores();
							char tipo = cuboSyn(aux2, aux1, op);
							int dir;
							if(tipo !='w'){
								dir = getDirTemp(tipo);
								generaCuadruplo(op,aux2,aux1,dir);
								pushPilaOperandos(dir);
							}
							else{
								error++;
								printf("\nError de mezcla de tipos en multiplicación, línea número %d\n", lineNumber);
							}
						}
					}
				;

tipo		: INT		{tipo=$1;}
			| FLOAT		{tipo=$1;}
			| COLOR		{tipo=$1;}
			| STRING	{tipo=$1;}
			;

constante	: ID	{
						if((operando=existeVariable(indexProc, $1))==-1000){
							error++;
							printf("Error en linea: %d. Variable '%s' no existe.\n",lineNumber,$1);
						}
					}
			| CTE_I			{agregaConstante(0, $1, aux_negativo);operando=existeCteInt(atoi($1)*aux_negativo);}
			| CTE_F			{agregaConstante(1, $1, aux_negativo);operando=existeCteFloat(atof($1)*aux_negativo);}
			| CTE_HEX		{agregaConstante(2, $1, 0);operando=existeCteHex($1);}
			| CTE_STRING	{agregaConstante(3, $1, 0);operando=existeCteString($1);}
			| WIDTH			{
								if(aux_negativo!=-1)
									operando=12000;
								else
									operando=12002;
							}
			| HEIGHT		{
								if(aux_negativo!=-1)
									operando=12001;
								else
									operando=12003;
							}
			| POINTER_X		{operando=0;}
			| POINTER_Y		{operando=1;}
			| func_usuario	{
								//operando=procedimientos[llamada].retorno;
								operando=-1;
							}
			;

exp_paso_1	:	{pushPilaOperandos(operando)}
			;
exp_paso_2	:	{
					if(peekPilaOperadores()==100||peekPilaOperadores()==101){
						int aux1=popPilaOperandos();
						int aux2=popPilaOperandos();
						int op=popPilaOperadores();
						char tipo = cuboSyn(aux2, aux1, op);
						int dir;
						if(tipo !='w'){
							dir = getDirTemp(tipo);
							generaCuadruplo(op,aux2,aux1,dir);
							pushPilaOperandos(dir);
						}
						else{
							error++;
							printf("\nError de mezcla de tipos en suma, línea número %d\n  [%d %d %d]", lineNumber, aux1, op, aux2);
						}
					}
				}
			;

exp_paso_3	:	{
					if(peekPilaOperadores()==102||peekPilaOperadores()==103){
						int aux1=popPilaOperandos();
						int aux2=popPilaOperandos();
						int op=popPilaOperadores();
						char tipo = cuboSyn(aux2, aux1, op);
						int dir;
						if(tipo !='w'){
							dir = getDirTemp(tipo);
							generaCuadruplo(op,aux2,aux1,dir);
							pushPilaOperandos(dir);
						}
						else{
							error++;
							printf("\nError de mezcla de tipos en multiplicación, línea número %d\n", lineNumber);
						}
					}
				}
			;

exp_paso_4	:	{pushPilaOperadores(9999);}
			;

exp_paso_5	:	{popPilaOperadores();}
			;
			
print		:	PRINT PARENI exp PAREND PUNCOMA{
					generaCuadruplo(700, -1, -1, popPilaOperandos());
				}
			;
printl		:	PRINTL PARENI exp PAREND PUNCOMA{
					generaCuadruplo(701, -1, -1, popPilaOperandos());
				}
			;	

read		:	READ PARENI id_read PAREND PUNCOMA
			;
id_read		:	ID{
					//Validación semántica 
					int dir_id = existeVariable(indexProc, $1);
					if(dir_id>=0){
						generaCuadruplo(702, -1, -1, dir_id);
					}
					else{
						error++;
						printf("Variable %s no ha sido declarada anteriormente", $1);
					}
				}
			;

%%
int yyerror(char *s) {
	error++;
	printf("\n=============================================\n");
	printf("\nError de sintaxis, línea  #%d\n", lineNumber);
	printf("\n=============================================\n");

	return (0);
}

int main(int argc, char* argv[]){
	strcpy (nombre,argv[1]);
	strcat (nombre,"o");
	FILE *programa = fopen(argv[1],"r");
	if(!programa){
		printf("No existe el archivo");
		return -1;
	}
	yyin = programa;

	agregaVariable(indexProc, 0, "_POINTERX", lineNumber);
	agregaVariable(indexProc, 0, "_POINTERY", lineNumber);
	agregaConstante(0,"1",-1);
	inicializaCubo();
	yyparse();
	exit(0);
}
