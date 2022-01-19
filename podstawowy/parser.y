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
%token NUM

%%
start: program {
                SYMTABLE.print_table();
               }

program: T_PROGRAM ID '(' identifier_list ')' ';'
        declarations
        compound_statement

identifier_list: ID
               | identifier_list ',' ID

declarations: declarations T_VAR identifier_list ':' type ';'
            | %empty

type: standard_type

standard_type: T_INTEGER {$$ = integer;}
    | T_REAL {$$ = real;}



compound_statement: T_BEGIN statement_list T_END 

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {}

expression: expression '+' expression {}
          | expression '*' expression {}
          | '-' expression {}
          | '(' expression ')' {}
          | ID {} //zawiera miejsce w tablicy symboli
          | NUM {} //tutaj tez bedzie chyba

%%



void yyerror(char const *s)
{
  printf("%s\n",s);
};

int main()
{
  yyparse();
};

