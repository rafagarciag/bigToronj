%{
#include <string.h>
#include "bisoner.tab.h"
extern YYSTYPE yylval;
%}
	int lineNumber=1;
IDEN		[a-z][_a-zA-Z0-9]*
DIGIT		[0-9]
HEX			[a-fA-F]
WHITE		[ \t\n<<EOF>>]
DEL			[ \t\n,;\+\-!=\/\(\)\{\}\[\]\<\>#]
	
%%

	/* Palabras reservadas */
(drawing)					{printf("DRAWING \n");return DRAWING;}

	/* Tipos de dato */
(int)						{printf("INT \n");return INT;}
(float)						{printf("FLOAT \n");return FLOAT;}
(color)						{printf("COLOR \n");return COLOR;}
(string)					{printf("STRING \n");return STRING;}
(void)						{printf("VOID \n");return VOID;}

	/* Constantes enteras */
{DIGIT}+					{printf("CTE_I \n");return CTE_I;}

	/* Constantes flotantes */
{DIGIT}+\.{DIGIT}+			{printf("CTE_F \n");return CTE_F;}

	/* Constantes hexadecimales */
#({DIGIT}|{HEX}){6}			{printf("CTE_HEX \n");return CTE_HEX;}

	/* Constantes strings */
(\".+\")					{printf("CTE_STRING \n");return CTE_STRING; }

	/* Constantes globales, siempre accesibles */
(_POINTER)					{return POINTER;}
(_POINTERX)					{return POINTER_X;}
(_POINTERY)					{return POINTER_Y;}
(_WIDTH)					{printf("WIDTH \n");return WIDTH;}
(_HEIGHT)					{printf("HEIGHT \n");return HEIGHT;}

	/* Metodos predefinidos */
(trans)						{printf("TRANS \n");return TRANS;}
(scale)						{return SCALE;}
(rotate_in_place)			{return ROTATE_PLACE;}
(rotate)					{return ROTATE;}
(push)						{return PUSH;}
(pop)						{return POP;}
(pop_origin)				{return POP_ORIGIN;}
(set_color)					{printf("COLOR_METHOD \n");return COLOR_METHOD;}

	/* Metodos para crear figuras */
(triangle)					{return TRIANGLE;}
(tetragon)					{return TETRAGON;}
(circle)					{return CIRCLE;}
(line)						{return LINE;}

	/* Metodos del usuario */
(function)					{printf("FUNCTION \n");return FUNCTION;}
	
	/* Condicional if */
(if)						{return IF;}
(else)						{return ELSE;}

	/* Ciclo for */
(for)						{return FOR;}

	/* Ciclo while */
(while)						{return WHILE;}

	/* Identificadores */
{IDEN}						{return ID;}

	/* Caracteres terminales */
";"							{printf("PUNCOMA \n");return PUNCOMA;}
","							{printf("COMA \n");return COMA;}
"{"							{printf("LLAVEI \n");return LLAVEI;}
"}"							{printf("LLAVED \n");return LLAVED;}
"("							{printf("PARENI \n");return PARENI;}
")"							{printf("PAREND \n");return PAREND;}
"="							{return IGUAL;}
"=="						{printf("IGUALIGUAL \n");return IGUALDAD;}
"<"							{return MENOR;}
"<="						{return MENORI;}
">"							{return MAYOR;}
">="						{return MAYORI;}
"!="						{return DIFF;}
"&&"						{printf("AND \n"); return AND;}
"||"						{printf("OR \n"); return OR;}
"+"							{return SUMA;}
"-"							{return RESTA;}
"*"							{return MULT;}
"/"							{printf("SLASH \n");return DIVI;}

	/* Lo que se ignora */
	/*(\/\*)[a-zA-Z0-9{DEL}]*(\*\/)	{}*/
	
{WHITE}					{if(!strcmp(yytext,"\n")) lineNumber++; }


%%
