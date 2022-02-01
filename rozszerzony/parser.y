%{
#include "global.h"
#define YYERROR_VERBOSE 1
Symtable SYMTABLE;
vector <int> id_vector;
vector <int> parameter_vector;
Scope actual_scope = Scope::GLOBAL;

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

%token T_PROCEDURE

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
         declarations  {
                       actual_scope = Scope::LOCAL; //dla subprogramow
                       printf("jump.i #lab0\n");
                       }
        subprogram_declarations {
                                actual_scope = Scope::GLOBAL; //po wyjsciu z subprogramow
                                cout << "lab0:" << endl;
                                }
        compound_statement
        '.'

program_identifier_list: ID | program_identifier_list ',' ID

identifier_list: ID {id_vector.push_back($1);}
               | identifier_list ',' ID {id_vector.push_back($3);}

declarations: declarations T_VAR identifier_list ':' type ';' {
                                                              for(int i=0; i< (int) id_vector.size(); i++)
                                                              {
                                                                //printf("%d , %d\n", id_vector[i], i);
                                                                SYMTABLE.table[id_vector[i]].vartype = $5;
                                                                SYMTABLE.table[id_vector[i]].scope = actual_scope;

                                                                if (actual_scope == Scope::GLOBAL){
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_address;
                                                                  if($5 == VarType::INTEGER)
                                                                    SYMTABLE.next_address += 4;
                                                                  if($5 == VarType::REAL)
                                                                    SYMTABLE.next_address += 8;
                                                                }
                                                                else
                                                                {
                                                                  if($5 == VarType::INTEGER)
                                                                    {SYMTABLE.next_local_address -= 4;}
                                                                  if($5 == VarType::REAL)
                                                                    {SYMTABLE.next_local_address -= 8;}
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_local_address;
                                                                }

                                                              }
                                                              id_vector.clear();
                                                              }
            | /* empty */

type: standard_type {$$ = $1;}

standard_type: T_INTEGER {$$ = VarType::INTEGER;}
             | T_REAL {$$ = VarType::REAL;}







subprogram_declarations: subprogram_declarations subprogram_declaration ';'
                       | /* empty */

subprogram_declaration: subprogram_head 
                        declarations
                        compound_statement{
                                          cout << "leave" << endl;
                                          cout << "return" << endl;
                                          }

subprogram_head: T_PROCEDURE ID arguments ';'{
                                             SYMTABLE.table[$2].input_type = InputType::PROCEDURE;
                                             cout << SYMTABLE.table[$2].name + ":" <<endl;
                                             

                                             SYMTABLE.next_parameter_address = (int) parameter_vector.size()*4 + 4; //BP+4 dla adresu powrotu, w odwrotnej kolejnosci
                                             //cout << SYMTABLE.next_parameter_address << endl;
                                             for (int i = 0; i< (int) parameter_vector.size(); i++)
                                             {
                                               SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address;
                                               SYMTABLE.next_parameter_address -= 4;
                                             }
                                             SYMTABLE.next_parameter_address = 0;
                                             id_vector.clear();
                                             }

arguments: '(' parameter_list ')'
         | /* empty */

parameter_list: identifier_list ':' type  {
                                          for(int i=0; i< (int) id_vector.size(); i++)
                                          {
                                            cout << "tutaj nie wszedlem" << endl;
                                            SYMTABLE.table[id_vector[i]].vartype = $3;
                                            SYMTABLE.table[id_vector[i]].scope = actual_scope;
                                            parameter_vector.push_back(id_vector[i]);
                                          }
                                          id_vector.clear(); //potrzeba czyszczenia po, dlatego dodatkowy wektor
                                          }

              | parameter_list ';' identifier_list ':' type {
                                                            for(int i=0; i< (int) id_vector.size(); i++)
                                                            {
                                                              SYMTABLE.table[id_vector[i]].vartype = $5;
                                                              SYMTABLE.table[id_vector[i]].scope = Scope::LOCAL;
                                                              parameter_vector.push_back(id_vector[i]);
                                                            }
                                                            id_vector.clear();
                                                            } 










compound_statement: T_BEGIN optional_statements T_END

optional_statements: statement_list
                   | /* empty */ 

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {
                                  if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                  {
                                    int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype);
                                    if(SYMTABLE.table[$3].vartype == VarType::INTEGER)
                                    {
                                      gencode("inttoreal", $3, newtemp, -1);
                                      SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[$3].value;
                                    }
                                    if(SYMTABLE.table[$3].vartype == VarType::REAL)
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
          
          | procedure_statement

procedure_statement: ID
                   | ID '(' expression_list ')'

expression_list: expression
               | expression_list ',' expression









expression: expression '+' expression {
                                      int newtemp = 0;
                                      if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                      {
                                        if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);}
                                        if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);}
                                        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
                                      }
                                      else
                                      {
                                        if (SYMTABLE.table[$1].vartype == VarType::INTEGER)
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
                                        if (SYMTABLE.table[$1].vartype == VarType::REAL)
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
                                      }
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("add", $1, $3, newtemp);
                                      }

          | expression '-' expression {
                                      int newtemp = 0;
                                      if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                      {
                                        if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);}
                                        if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);}
                                        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
                                      }
                                      else
                                      {
                                        if (SYMTABLE.table[$1].vartype == VarType::INTEGER)
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
                                        if (SYMTABLE.table[$1].vartype == VarType::REAL)
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
                                      }
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value - SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("sub", $1, $3, newtemp);
                                      }

          | expression T_MULOP expression{
                                          int newtemp = 0;
                                          if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                          {
                                            if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);}
                                            if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);}
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
                                          }
                                          else
                                          {
                                            if (SYMTABLE.table[$1].vartype == VarType::INTEGER)
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
                                            if (SYMTABLE.table[$1].vartype == VarType::REAL)
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
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
                           int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::NONE);
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
  string type_postfix = SYMTABLE.table[i1].vartype == VarType::INTEGER ? ".i " : ".r ";
  ////
  cout << command+type_postfix << var1 << var2 << var3 << endl;
}

int type_conversion(int i1)
{
  int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
  SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[i1].value;
  gencode("inttoreal", i1, newtemp, -1);
  return newtemp;
}

void destroy()
{
  yylex_destroy();
}