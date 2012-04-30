#!/bin/bash
bison -d bisoner.y
flex lexer.l
gcc -g bisoner.tab.c lex.yy.c -lfl -o bTc
