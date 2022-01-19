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



compound_statement: T_BEGIN statement_list T_END '.'

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {
                                  SYMTABLE.table[$1].value = SYMTABLE.table[$3].value;
                                  }

expression: expression '+' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      }
          | expression '*' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value * SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      }
          | '-' expression {
                           int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                           SYMTABLE.table[newtemp].value = SYMTABLE.table[$2].value * (-1);
                           $$ = newtemp;
                           }
          | '(' expression ')' {$$ = $2;}
          | ID {$$ = $1;} //zawiera miejsce w tablicy symboli
          | NUM {$$ = $1;} //tutaj tez bedzie chyba

%%



void yyerror(char const *s)
{
  printf("%s\n",s);
};

int main()
{
  yyparse();
};

