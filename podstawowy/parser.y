%{
#include "global.h"
#define YYERROR_VERBOSE 1
Symtable SYMTABLE;
vector <int> id_vector;

%}
%union{
  int index;
  char operation;
  VarType variable_type;
}

%token T_PROGRAM
%token T_VAR
%token T_BEGIN
%token T_END
%token T_WRITE
%token T_ASSIGN
%token <variable_type> T_INTEGER
%token <variable_type> T_REAL
%token <operation> T_MULOP
%token <index> ID
%token <index> NUM
%nterm <variable_type> standard_type type
%nterm <index> identifier_list statement expression
%left '+' '-'
%left T_MULOP


%%
start: program {printf("exit\n"); SYMTABLE.print_table(); }

program: T_PROGRAM ID '(' program_identifier_list ')' ';'
        declarations {
                     printf("jump.i #lab0\nlab0:\n");
                     }
        compound_statement 

program_identifier_list: ID | program_identifier_list ',' ID

identifier_list: ID {id_vector.push_back($1);}
               | identifier_list ',' ID {id_vector.push_back($3);}

declarations: declarations T_VAR identifier_list ':' type ';' {
                                                              for(int i=0; i< (int) id_vector.size(); i++)
                                                              {
                                                                //printf("%d , %d\n", id_vector[i], i);
                                                                SYMTABLE.table[id_vector[i]].type = $5;
                                                                SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_address;
                                                                if($5 == VarType::INTEGER)
                                                                  SYMTABLE.next_address += 4;
                                                                if($5 == VarType::REAL)
                                                                  SYMTABLE.next_address += 8;
                                                              }
                                                              id_vector.clear();
                                                              }
            | /* empty */

type: standard_type {$$ = $1;}

standard_type: T_INTEGER {$$ = VarType::INTEGER;}
             | T_REAL {$$ = VarType::REAL;}




compound_statement: T_BEGIN statement_list T_END '.'

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {
                                  if(SYMTABLE.table[$1].type != SYMTABLE.table[$3].type)
                                  {
                                    int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, SYMTABLE.table[$1].type);
                                    if(SYMTABLE.table[$3].type == VarType::INTEGER)
                                    {
                                      gencode("inttoreal", $3, newtemp, -1);
                                      SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[$3].value;
                                    }
                                    if(SYMTABLE.table[$3].type == VarType::REAL)
                                    {
                                      gencode("realtoint", $3, newtemp, -1);
                                      SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[$3].value;
                                    }
                                    $3 = newtemp;
                                  }
                                  SYMTABLE.table[$1].value = SYMTABLE.table[$3].value;
                                  gencode("mov", $3, $1, -1);
                                  }
          | T_WRITE '(' ID ')' {
                                gencode("write", $3, -1, -1);
                               }

expression: expression '+' expression {
                                      int newtemp = 0;
                                      if(SYMTABLE.table[$1].type != SYMTABLE.table[$3].type)
                                      {
                                        if(SYMTABLE.table[$1].type == VarType::INTEGER) {$1 = type_conversion($1);}
                                        if(SYMTABLE.table[$3].type == VarType::INTEGER) {$3 = type_conversion($3);}
                                        newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                      }
                                      else
                                      {
                                        if (SYMTABLE.table[$1].type == VarType::INTEGER)
                                          newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::INTEGER);
                                        if (SYMTABLE.table[$1].type == VarType::REAL)
                                          newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                      }
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("add", $1, $3, newtemp);
                                      }

          | expression '-' expression {
                                      int newtemp = 0;
                                      if(SYMTABLE.table[$1].type != SYMTABLE.table[$3].type)
                                      {
                                        if(SYMTABLE.table[$1].type == VarType::INTEGER) {$1 = type_conversion($1);}
                                        if(SYMTABLE.table[$3].type == VarType::INTEGER) {$3 = type_conversion($3);}
                                        newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                      }
                                      else
                                      {
                                        if (SYMTABLE.table[$1].type == VarType::INTEGER)
                                          newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::INTEGER);
                                        if (SYMTABLE.table[$1].type == VarType::REAL)
                                          newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                      }
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value - SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("sub", $1, $3, newtemp);
                                      }

          | expression T_MULOP expression{
                                          int newtemp = 0;
                                          if(SYMTABLE.table[$1].type != SYMTABLE.table[$3].type)
                                          {
                                            if(SYMTABLE.table[$1].type == VarType::INTEGER) {$1 = type_conversion($1);}
                                            if(SYMTABLE.table[$3].type == VarType::INTEGER) {$3 = type_conversion($3);}
                                            newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                          }
                                          else
                                          {
                                            if (SYMTABLE.table[$1].type == VarType::INTEGER)
                                              newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::INTEGER);
                                            if (SYMTABLE.table[$1].type == VarType::REAL)
                                              newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
                                          }

                                         if($2 == '*')
                                         {
                                          SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value * SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("mul", $1, $3, newtemp);
                                         }

                                         if ($2 == '/')
                                         {
                                          SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value / SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("div", $1, $3, newtemp);
                                         }
                                         
                                         if ($2 == 'm')
                                         {
                                          SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[$1].value % (int) SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("mod", $1, $3, newtemp);
                                         }
                                         }

          | '-' expression {
                           int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::NONE);
                           //SYMTABLE.table[newtemp].value = SYMTABLE.table[$2].value * (-1);
                           $$ = newtemp;
                           gencode("negation", 0, $2, newtemp);
                           }

          | '(' expression ')' {$$ = $2;}
          | ID {$$ = $1;}
          | NUM {$$ = $1;}

%%



void yyerror(char const *s)
{
  printf("%s\n",s);
};

int main()
{
  atexit(destroy);
  yyparse();
  exit(0);
};

void gencode(string command, int i1, int i2, int i3) //przekazuje indeksy w tablicy symboli
{
  string var1 = "", var2 = "", var3 = "";
  if(i1 >= 0)
  var1 = isdigit(SYMTABLE.table[i1].name[0]) ? "#" + SYMTABLE.table[i1].name : to_string(SYMTABLE.table[i1].address);
  if(i2 >= 0)
  var2 = isdigit(SYMTABLE.table[i2].name[0]) ? ",#" + SYMTABLE.table[i2].name : "," + to_string(SYMTABLE.table[i2].address);
  if(i3 >= 0)
  var3 = isdigit(SYMTABLE.table[i3].name[0]) ? ",#" + SYMTABLE.table[i3].name : "," + to_string(SYMTABLE.table[i3].address);
  string type_postfix = SYMTABLE.table[i1].type == VarType::INTEGER ? ".i " : ".r ";
  ////
  cout << command+type_postfix << var1 << var2 << var3 << endl;
}

int type_conversion(int i1)
{
  int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY, VarType::REAL);
  SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[i1].value;
  gencode("inttoreal", i1, newtemp, -1);
  return newtemp;
}

void destroy()
{
  yylex_destroy();
}