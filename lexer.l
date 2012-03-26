%{
#include <stdio.h>
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
(global)					{return GLOBAL;}
(drawing)					{return DRAWING;}

	/* Tipos de dato */
(int)						{yylval.number=0;return INT;}
(float)						{yylval.number=1;return FLOAT;}
(color)						{yylval.number=2;return COLOR;}
(string)					{yylval.number=3;return STRING;}
(void)						{return VOID;}

	/* Constantes enteras */
{DIGIT}+					{printf("CTE_I \n");yylval.string=strdup(yytext);return CTE_I;}

	/* Constantes flotantes */
{DIGIT}+\.{DIGIT}+			{printf("CTE_F \n");yylval.string=strdup(yytext);return CTE_F;}

	/* Constantes hexadecimales */
#({DIGIT}|{HEX}){6}			{printf("CTE_HEX \n");yylval.string=strdup(yytext);return CTE_HEX;}

	/* Constantes strings */
(\".+\")					{printf("CTE_STRING \n");yylval.string=strdup(yytext);return CTE_STRING; }

	/* Constantes globales, siempre accesibles */
(_POINTER)					{return POINTER;}
(_POINTERX)					{return POINTER_X;}
(_POINTERY)					{return POINTER_Y;}
(_WIDTH)					{return WIDTH;}
(_HEIGHT)					{return HEIGHT;}

	/* Metodos predefinidos */
(trans)						{return TRANS;}
(scale)						{return SCALE;}
(rotate_in_place)			{return ROTATE_PLACE;}
(rotate)					{return ROTATE;}
(push)						{return PUSH;}
(pop)						{return POP;}
(pop_origin)				{return POP_ORIGIN;}
(set_color)					{return COLOR_METHOD;}

	/* Metodos para crear figuras */
(triangle)					{return TRIANGLE;}
(tetragon)					{return TETRAGON;}
(circle)					{return CIRCLE;}
(line)						{return LINE;}

	/* Metodos del usuario */
(function)					{return FUNCTION;}
(return)					{return RETURN;}

	/* Condicional if */
(if)						{return IF;}
(else)						{return ELSE;}

	/* Ciclo for */
(for)						{return FOR;}

	/* Ciclo while */
(while)						{return WHILE;}

	/* Identificadores */
{IDEN}						{printf("ID\n");yylval.string=strdup(yytext);return ID;}

	/* Caracteres terminales */
";"							{return PUNCOMA;}
","							{return COMA;}
"{"							{return LLAVEI;}
"}"							{return LLAVED;}
"("							{return PARENI;}
")"							{return PAREND;}
"="							{return IGUAL;}
"=="						{return IGUALDAD;}
"<"							{return MENOR;}
"<="						{return MENORI;}
">"							{return MAYOR;}
">="						{return MAYORI;}
"!="						{return DIFF;}
"&&"						{return AND;}
"||"						{return OR;}
"+"							{return SUMA;}
"-"							{return RESTA;}
"*"							{return MULT;}
"/"							{return DIVI;}

	/* Lo que se ignora */
	/*(\/\*)[a-zA-Z0-9{DEL}]*(\*\/)	{}*/

{WHITE}					{if(!strcmp(yytext,"\n")) lineNumber++; }


%%