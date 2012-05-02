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

				//EN caso se que la compilacion sea exitosa se despliega el mensaje correspondiente y se genera el archivo objeto
				if(error==0){
					printf("\n===========================\n");
					printf("\nCompilación exitosa\n");
					printf("\n===========================\n");
					imprimeTotalGlobales(nombre);
					imprimeTotalTemporales(nombre);
					imprimeConstantes(nombre);
					imprimeProcedimientos(nombre,indexProc+1);
					imprimeCuadruplos(nombre);
				}
				//De lo contrario no se genera el archivo y se muestra el total de errores.
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
					//Rellena el primer cuadruplo con el indice donde comienza el main
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
				//Indice de offsets utilizados para asignar una variable apropiada a cada llamada a un metodo
				int offsets[4];
				offsets[0]=2000;
				offsets[1]=2500;
				offsets[2]=3000;
				offsets[3]=3500;
				
				//Se incrementan los indices de cada tipo de offset segun el tipo de llamada que haga el usuario.
				int indices[4];
				indices[0]=0;
				indices[1]=0;
				indices[2]=0;
				indices[3]=0;
				
				if(i>0){
					//se valida que el numero de parametros de la llamada sea igual que los de la firma del procedimiento
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
					//empujarla a la pila
					dir_ret_local=agregaVariable(indexProc, procedimientos[i].tipo, "retorno111222333", lineNumber);
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
							//Se introduce un fondo falso a la pila de operadores con cada llamada para evaular las expresiones entro de los parametros
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
						contParam++;
					}
					else{
						error++;
						printf("Error en línea %d. Parámetros enviados a método no corresponden al tipo esperado\n", lineNumber);
					}
				}
			;

func_usuario11:	/*vacio*/
			| COMA func_usuario1
			;
func_usuario111	:	{
						//Remover fondo falso
						popPilaOperadores();
					}	
				;

//Estatutos
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
//Ingresa el indice acual a la pila de saltos
if_paso_1	:	{
					pushPilaSaltos(0);
					//GOTOF
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
				}
			;
//Se rellena el GoToF de la posicion de la expresion con el indice de cuadruplos actual
if_paso_2	:	{
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
				}
			;


else		: /*vacio*/ if_paso_2
			| ELSE else_paso_1 bloque else_paso_2
			;
//Se genera un GoTo vacio que va a contener a donde se ira el pointer en caso de haber pasado por el if
else_paso_1 :	{
					//GOTO
					generaCuadruplo(300, -1, -1, 0);
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
					pushPilaSaltos(-1);
				}
			;
//Rellenga el GoTo creado en el paso 2 del if para indicar a donde ir al final de la ejecucion del estatuto else.
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
/*
Push a pila de saltos el valor actual del índice de cuádruplos
b = Pop a pila de operandos
genera GOTOF(b, ) con el resultado de la expresion
Push a pila de saltos el valor actual del índice de cuádruplos
genera GOTO()
*/
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
/*
temp = popPilaSaltos
rellenaGOTO(popPilaSaltos)
push a pila de saltos con el índice en variable temp
temp2 = popPilaSaltos
temp3 = popPilaSaltos
genera GOTO (popPilaSaltos)
push a pila de saltos con el índice en variable temp3
push a pila de saltos con el índice en variable temp2
*/
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
//Genera GOTO (popPilaSaltos)
//rellenaGOTOF(popPilaSaltos)
for_paso_5	:	{
					//GOTO
					generaCuadruplo(300, -1, -1, popPilaSaltos());
					rellenaGoToF(popPilaSaltos(), getPointerCuadruplos());
				}
			;


while 		: WHILE PARENI while_paso_1 expresion PAREND while_paso_2 bloque while_paso_3
			;
//Introduce el indice actual a la pila de saltos
while_paso_1:	{
					pushPilaSaltos(0);
				}
			;
//Introduce el cuadruplo al que se va a regresar el while despues de cada vuelta
while_paso_2:	{
					pushPilaSaltos(0);
					//GOTOF
					generaCuadruplo(302, popPilaOperandos(), -1, 0);
				}
			;
//En este paso se rellenan los goto necesarios para completar la generacion de los cuadruplos de control del while
while_paso_3:	{
					falso=popPilaSaltos();
					retorno=popPilaSaltos();
					//GOTO
					generaCuadruplo(300,-1,-1,retorno);
					rellenaGoToF(falso, getPointerCuadruplos());
				}
			;

//Metodos de  pila de transformaciones
met_bt_or	: met_bt_or1 PARENI PAREND PUNCOMA
			;
met_bt_or1	: PUSH			{generaCuadruplo(500,-1,-1,-1);}
			| POP			{generaCuadruplo(501,-1,-1,-1);}
			| POP_ORIGIN	{generaCuadruplo(502,-1,-1,-1);}
			;

//Metodos de transformaciones
met_bt		: trans
			| rotate
			| color_method
			;

//Los cuadruplos de transformaciones se generan al extraer los resultados de las expresiones que esten gardafas en la pila de operandos
trans		: TRANS PARENI exp COMA exp PAREND PUNCOMA	{
					generaCuadruplo(450,popPilaOperandos(),popPilaOperandos(),-1);
					
			}
			;
rotate		: ROTATE PARENI exp PAREND PUNCOMA			{generaCuadruplo(451,popPilaOperandos(),-1,-1);	}
			;

color_method	: COLOR_METHOD PARENI exp PAREND PUNCOMA {generaCuadruplo(452,popPilaOperandos(),-1,-1);}
				;

//METODOS DE DIBUJO
dibujo		: line
			| triangle
			| tetragon
			| circle
			;

/*
Se generan los cuadruplos de dibujo segun las expresiones que se encuentren guardadas en la pila de operadores.
*/
line		: LINE PARENI exp COMA exp PAREND PUNCOMA		{generaCuadruplo(400,popPilaOperandos(),popPilaOperandos(),-1);	}
			;

triangle	: TRIANGLE PARENI exp COMA exp COMA exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(401,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());generaCuadruplo(401,popPilaOperandos(),popPilaOperandos(),-1);}
			;

tetragon	: TETRAGON PARENI exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(402,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());}
			;

circle		: CIRCLE PARENI exp COMA exp COMA exp PAREND PUNCOMA	{generaCuadruplo(403,popPilaOperandos(),popPilaOperandos(),popPilaOperandos());}
			;


//Las reglas de las expresiones aritmeticas siguen la gramatica al pie de la letra
//Para realizar alguna accion en estas reglas se utilizan reglas vacias auxiliares
//Facilitando asi la generacion de los cuadruplos
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

//Segun el numero de veces que se incremento el bit negativo el compilador genera o no
//un cuadruplo que transforma el resultado de una expresion a su equivalente negativo		
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

//De la misma forma que el negativo de genera un cuadruplo que ivnierte el resultado de una expresion logica
negacion	: /*vacio*/
			| NOT	{
						pushPilaOperadores(208);
						bit_negacion++;
					}
			;
			
//Reset negacion funciona para volver a empezar el conteo de negaciones que puede tener una expresion logica.
reset_negacion	:	{
						if(bit_negacion%2!=0){
							int aux_dir = getDirTemp('i');
							
							generaCuadruplo(208, -1, -1, popPilaOperandos());
							pushPilaOperandos(aux_dir);
						}
						bit_negacion=0;
					}
				;

/*
En este paso se genran los cuadruplos para las operaciones AND y OR las cuales tienen mayor prioridad que las demas
expresiones logicas.
EN caso de que se tenga una de estas dos operaciones pendientes se hacen las validaciones semanticas correspondientes
y se genera el cuadruplo para su evaluacion.
*/
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
								printf("\nError de mezcla de tipos en la operacion logica, línea número %d\n  [%d %d %d]", lineNumber, aux1, op, aux2);
							}
						}
					}
				;
			
/*
En este paso se generan los cuadruplos de expresiones logicas
Se obtiene el codigo de operacion segun el rango en el que se encuentra
Si se aprueban las validaciones semanticas se genera el cuadruplo y el resultado se
almacenaria en una variable temporal entera.
*/
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
								printf("\nError de mezcla de tipos en la operacion logica, línea número %d\n", lineNumber);
							}
						}
					}
				;

//Varias reglas llegan a la regla tipo la cual se encarga de modificar la variable glbal tipo
//que es utilizada en diferentes ocaciones para la generacion de cuadruplos
tipo		: INT		{tipo=$1;}
			| FLOAT		{tipo=$1;}
			| COLOR		{tipo=$1;}
			| STRING	{tipo=$1;}
			;
/*
Esta es la ultima regla a la que puede entrar el compilador en caso de estar analizando una expresion
En esta ultima regla se determina la constante que sera utilizada en una operacion y se push de su direccion correspondiente
a la pila de operandos
*/
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

//La variable operando recibe un valor cuando las reglas de expresion llegan hasta una constante
//Una vez que se llega a este paso cuando operando ha recibido un valor este es agregado a la pila de operandos
exp_paso_1	:	{pushPilaOperandos(operando)}
			;
/*
Este paso de las expresiones se encarga de generar el cuadruplo de las sumas.
SOlamente se genera un cuadruplo de suma cuando en efecto hay una suma pendiente en la pila de operadores
de lo contrario se procede al siguiente paso de la expresion
*/
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

/*
En esta parte se generan los cuadruplos de multiplicacion y division. 
Se generan en caso de que se tenga una multiplicacion o division pendiente.
Ademas se hace una validacion semantica de mezcla de tipos y en caso de no pasar la validacion se imprime el error correspondiente
*/
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

//Se agrega un fondo falso en caso de que la expresion tenga un parentesis
exp_paso_4	:	{pushPilaOperadores(9999);}
			;
//Se elmina el fondo falso que se agrega por un parentesis izquierdo
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
					//Se genera un cuadruplo read para almacenar la lectura en la variable que se indica entre los parentesis
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

	//Se agregan las variables POINTERX y POINTERY al scope global
	agregaVariable(indexProc, 0, "_POINTERX", lineNumber);
	agregaVariable(indexProc, 0, "_POINTERY", lineNumber);
	agregaConstante(0,"1",-1);
	//Inicializacion del cubo semantico
	inicializaCubo();
	yyparse();
	exit(0);
}
