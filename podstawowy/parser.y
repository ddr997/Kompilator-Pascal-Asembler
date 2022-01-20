%{
#include "global.h"
#define YYERROR_VERBOSE 1
Symtable SYMTABLE;
extern string operation;
vector <int> id_vector;
%}

%token T_PROGRAM
%token T_VAR
%token T_BEGIN
%token T_END
%token T_WRITE
%token T_ASSIGN
%token T_INTEGER
%token T_REAL
%token T_MULOP
%token ID
%token NUM
%left '+' '-'
%left T_MULOP

%%
start: program { SYMTABLE.print_table(); }

program: T_PROGRAM ID '(' program_identifier_list ')' ';'
        declarations
        compound_statement

program_identifier_list: ID | program_identifier_list ',' ID

identifier_list: ID {id_vector.push_back($1);} //niesie 
               | identifier_list ',' ID {id_vector.push_back($3);}

declarations: declarations T_VAR identifier_list ':' type ';' {
                                                              for(int i=0; i< (int) id_vector.size(); i++)
                                                              {
                                                                //printf("%d , %d\n", id_vector[i], i);
                                                                SYMTABLE.table[id_vector[i]].type = (VarType)$5;
                                                                SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_address;
                                                                if($5 == integer)
                                                                {
                                                                  SYMTABLE.next_address += 4;
                                                                }
                                                              }
                                                              id_vector.clear();
                                                              }
            |

type: standard_type {$$ = $1;}

standard_type: T_INTEGER {$$ = integer;}
             | T_REAL {$$ = real;}




compound_statement: T_BEGIN statement_list T_END '.'

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {
                                  SYMTABLE.table[$1].value = SYMTABLE.table[$3].value;
                                  gencode("mov.i", $3, $1, 0);
                                  }
          | T_WRITE '(' ID ')' {
                                gencode("write.i", $3, 0, 0);
                               }

expression: expression '+' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("add.i", $1, $3, newtemp);
                                      }

          | expression '-' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value - SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("sub.i", $1, $3, newtemp);
                                      }

          | expression T_MULOP expression{
                                         if(operation == "*")
                                         {
                                         int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                         SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value * SYMTABLE.table[$3].value;
                                         $$ = newtemp;
                                         gencode(operation, $1, $3, newtemp);
                                         }
                                         if (operation == "/" || operation == "div")
                                         {
                                         int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                         SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value / SYMTABLE.table[$3].value;
                                         $$ = newtemp;
                                         gencode(operation, $1, $3, newtemp);
                                         }
                                         if (operation == "mod")
                                         {
                                         int newtemp = SYMTABLE.insert_to_table("$t", temporary);
                                         SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[$1].value % (int) SYMTABLE.table[$3].value;
                                         $$ = newtemp;
                                         gencode(operation, $1, $3, newtemp);
                                         }
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
  string var1 = to_string(SYMTABLE.table[i1].address); //adresy w stringach
  string var2 = to_string(SYMTABLE.table[i2].address);
  string var3 = to_string(SYMTABLE.table[i3].address);
  if (isdigit(SYMTABLE.table[i1].name[0])){ var1 = "#" + SYMTABLE.table[i1].name; } //przypisywanie posrednie, bez adresu
  if (isdigit(SYMTABLE.table[i2].name[0])){ var2 = "#" + SYMTABLE.table[i2].name; }
  if (isdigit(SYMTABLE.table[i3].name[0])){ var3 = "#" + SYMTABLE.table[i3].name; }

  if(operation == "mov.i") //mamy z hashem i bez hasha, przesylamy adresy w tablicy symboli, jezeli bedzie z num to z # powinno printowac
  {
    cout << "mov.i " << var1 << "," << var2 << endl;
  }

  if(operation == "add.i")
  {
    cout << "add.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "sub.i"){
    cout << "sub.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "*")
  {
    cout << "mul.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "/")
  {
    cout << "div.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "div")
  {
    cout << "div.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "mod")
  {
    cout << "mod.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "write.i")
  {
    cout << "write.i " << var1 <<endl;
  }
}