IDEN		[a-z][_a-zA-Z0-9]*
DIGIT		[0-9]
HEX			[a-fA-F]
WHITE		[ \t\n<<EOF>>]
DEL			[ \t\n,;\+\-!=\/\(\)\{\}\[\]\<\>#]

	int line_num = 1;
	
%%

	/* Palabras reservadas */
(drawing)					{printf("DRAWING \n");}

	/* Tipos de dato */
(int)						{printf("INT \n");}
(float)						{printf("FLOAT \n");}
(coord)						{printf("COORD \n");}
(color)						{printf("COLOR \n");}

	/* Constantes enteras */
{DIGIT}+					{printf("CTE ENTERA \n");}

	/* Constantes flotantes */
{DIGIT}+\.{DIGIT}+			{printf("CTE FLOTANTE  \n");}

	/* Constantes hexadecimales */
#({DIGIT}|{HEX}){6}			{printf("Hex number\n");}

	/* Constantes globales, siempre accesibles */
(_POINTER)					{printf("POINTER  \n");}
(_POINTERX)					{printf("POINTER X  \n");}
(_POINTERY)					{printf("POINTER Y  \n");}
(_WIDTH)					{printf("WIDTHHH  \n");}
(_HEIGHT)					{printf("HEIGHTT  \n");}

	/* Metodos predefinidos */
(trans)						{printf("TRANS  \n");}
(rotate)					{printf("ROTATE  \n");}
(push)						{printf("PUSH  \n");}
(pop)						{printf("POP  \n");}
(pop_origin)				{printf("POP ORIGIN  \n");}
(pointer)					{printf("POINTERMETHOD  \n");}
(set_color)					{printf("COLORMETHOD  \n");}

	/* Metodos para crear figuras */
(triangle)					{printf("TRIANGULO  \n");}
(tetragon)					{printf("TETRA  \n");}
(circle)					{printf("CIRCLE  \n");}
(line)						{printf("LINE  \n");}
	
	/* Condicional if */
(if)						{printf("IF \n");}
(else)						{printf("ELSE \n");}

	/* Ciclo for */
(for)						{printf("FOR \n");}

	/* Identificadores */
{IDEN}						{printf("ID \n");}

	/* Caracteres terminales */
(;)							{}
(,)							{}
(\+)						{}
(\-)						{}
(=)							{}
(!=)						{printf("DIFERENTE  \n");}
(\*)						{}
(\/)						{}
(\()						{}
(\))						{}
(\{)						{}
(\})						{}
(\<)						{}
(\>)						{}


	/* Lo que se ignora */
	/*(\/\*)[a-zA-Z0-9{DEL}]*(\*\/)	{}*/
	
{WHITE}+					{}


%%
