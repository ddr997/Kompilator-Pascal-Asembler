%{
#include <stdio.h>
#include <ctype.h>
#include "global.h"
#define YYERROR_VERBOSE 1

int yylex();
void yyerror(const char *s);
%}

%token NUM DIV MOD ID DONE

%%
start: 
    list DONE
    ;

list:
      expr ';' list
    | /* empty */
    ;

expr: 
      expr '+' term     { emit('+', NONE); }
    | expr '-' term     { emit('-', NONE); }
    | term
    ;

term: 
      term '*' factor   { emit('*', NONE); }
    | term '/' factor   { emit('/', NONE); }
    | term DIV factor   { emit(DIV, NONE); }
    | term MOD factor   { emit(MOD, NONE); }
    | factor
    ;

factor: 
      '(' expr ')'
    | ID                { emit(ID, $1); }
    | NUM               { emit(NUM, $1); }
    ;
%%
void parse(){
    yyparse();
}

void yyerror (const char *s) {
	error((char *)s);
}