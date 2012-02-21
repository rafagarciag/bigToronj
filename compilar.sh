#!/bin/bash
bison -d bisoner.y
flex lexer.l
g++ bisoner.tab.c lex.yy.c -lfl -o analizador
clear
