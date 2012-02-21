%{
	#include <iostream>
	using namespace std;
	#define YY_DECL extern "C" int yylex()
	#include "bisoner.tab.h"
	
	int lineNumber=0;
%}

IDEN		[a-z][_a-zA-Z0-9]*
DIGIT		[0-9]
HEX			[a-fA-F]
WHITE		[ \t\n<<EOF>>]
DEL			[ \t\n,;\+\-!=\/\(\)\{\}\[\]\<\>#]
	
%%

	/* Palabras reservadas */
(drawing)					{return DRAWING;}

	/* Tipos de dato */
(int)						{return INT;}
(float)						{return FLOAT;}
(coord)						{return COORD;}
(color)						{return COLOR;}

	/* Constantes enteras */
{DIGIT}+					{return CTE_ENTERA;}

	/* Constantes flotantes */
{DIGIT}+\.{DIGIT}+			{return CTE_FLOTANTE;}

	/* Constantes hexadecimales */
#({DIGIT}|{HEX}){6}			{return CTE_HEXADECIMAL;}

	/* Constantes globales, siempre accesibles */
(_POINTER)					{return POINTER;}
(_POINTERX)					{return POINTER_X;}
(_POINTERY)					{return POINTER_Y;}
(_WIDTH)					{return WIDTH;}
(_HEIGHT)					{return HEIGHT;}

	/* Metodos predefinidos */
(trans)						{return TRANS;}
(rotate)					{return ROTATE;}
(push)						{return PUSH;}
(pop)						{return POP;}
(pop_origin)				{return POP_ORIGIN;}
(pointer)					{return POINTER_METHOD;}
(set_color)					{return COLOR_METHOD;}

	/* Metodos para crear figuras */
(triangle)					{return TRIANGULO;}
(tetragon)					{return TETRA;}
(circle)					{return CIRCLE;}
(line)						{return LINE;}
	
	/* Condicional if */
(if)						{return IF;}
(else)						{return ELSE;}

	/* Ciclo for */
(for)						{return FOR;}

	/* Identificadores */
{IDEN}						{return ID;}

	/* Caracteres terminales */
";"							{return PUNCOMA;}
","							{return COMA;}
"{"							{return LLAVEI;}
"}"							{return LLAVED;}
"("							{return PARENI;}
")"							{return PAREND;}
"="							{return IGUAL;}
"<"							{return MENOR;}
">"							{return MAYOR;}
"!="						{return DIFF;}
"+"							{return SUMA;}
"-"							{return RESTA;}
"*"							{return MULT;}
"/"							{return DIVI;}

	/* Lo que se ignora */
	/*(\/\*)[a-zA-Z0-9{DEL}]*(\*\/)	{}*/
	
{WHITE}+					{}


%%
