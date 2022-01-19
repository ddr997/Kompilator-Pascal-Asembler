%{
#include "global.h"
#define YYERROR_VERBOSE 1
Symtable SYMTABLE;
%}

%token T_PROGRAM
%token T_VAR
%token T_BEGIN
%token T_END
%token T_ASSIGN
%token T_INTEGER
%token T_REAL
%token ID
%token NUMBER

%%
start: program {
                SYMTABLE.print_table();
               }

program: declarations ';' program
       | declarations ';'

declarations: ID list {
                      SYMTABLE.table[$1].type_of_variable = (VariableType)$2;
                      }

list: ',' ID list {
                  $$=$3;
                  SYMTABLE.table[$2].type_of_variable = (VariableType)$3;
                  }
    | ':' type {$$=$2;}

type: T_INTEGER {$$ = integer;}
    | T_REAL {$$ = real;}
%%



void yyerror(char const *s)
{
  printf("%s\n",s);
};

int main()
{
  yyparse();
};

