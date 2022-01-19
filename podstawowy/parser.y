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
                                  gencode("mov.i", $3, $1, -1);
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

void gencode(string operation, int i1, int i2, int i3)
{
  string var1 = to_string(SYMTABLE.table[i1].address);
  string var2 = to_string(SYMTABLE.table[i2].address);
  string var3 = to_string(SYMTABLE.table[i3].address);
  if (isdigit(SYMTABLE.table[i1].name[0])){ var1 = "#" + SYMTABLE.table[i1].name; }
  if (isdigit(SYMTABLE.table[i2].name[0])){ var2 = "#" + SYMTABLE.table[i2].name; }
  if (isdigit(SYMTABLE.table[i3].name[0])){ var3 = "#" + SYMTABLE.table[i3].name; }

  if(operation == "mov.i") //mamy z hashem i bez hasha, przesylamy adresy w tablicy symboli, jezeli bedzie z num to z # powinno printowac
  {
    cout << "mov.i " << var1 << "," << var2 << endl;
  }

  if(operation == "add.i"){
    cout << "add.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "mul.i"){
    cout << "mul.i " << var1 << "," << var2 << "," << var3 << endl;
  }
}
