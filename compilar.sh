#!/bin/bash
bison -d bisoner.y
flex lexer.l
gcc bisoner.tab.c lex.yy.c -lfl -o analizador
