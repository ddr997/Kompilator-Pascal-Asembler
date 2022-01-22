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
%left '+' '-'
%left T_MULOP

%nterm <variable_type> standard_type type
%nterm <index> identifier_list statement expression

%%
start: program { SYMTABLE.print_table(); }

program: T_PROGRAM ID '(' program_identifier_list ')' ';'
        declarations
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
                                                                SYMTABLE.next_address += 4;
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
                                  SYMTABLE.table[$1].value = SYMTABLE.table[$3].value;
                                  gencode("mov", $3, $1, 0);
                                  }
          | T_WRITE '(' ID ')' {
                                gencode("write", $3, 0, 0);
                               }

expression: expression '+' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("add", $1, $3, newtemp);
                                      }

          | expression '-' expression {
                                      int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value - SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("sub", $1, $3, newtemp);
                                      }

          | expression T_MULOP expression{
                                         if($2 == '*')
                                         {
                                          int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                                          SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value * SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("mul", $1, $3, newtemp);
                                         }
                                         if ($2 == '/')
                                         {
                                          int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                                          SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value / SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("div", $1, $3, newtemp);
                                         }
                                         if ($2 == 'm')
                                         {
                                          int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                                          SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[$1].value % (int) SYMTABLE.table[$3].value;
                                          $$ = newtemp;
                                          gencode("mod", $1, $3, newtemp);
                                         }
                                         }

          | '-' expression {
                           int newtemp = SYMTABLE.insert_to_table("$t", Input_type::TEMPORARY);
                           SYMTABLE.table[newtemp].value = SYMTABLE.table[$2].value * (-1);
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

void gencode(string operation, int i1, int i2, int i3) //przekazuje indeksy w tablicy symboli
{
  string var1 = to_string(SYMTABLE.table[i1].address); //adresy w stringach
  string var2 = to_string(SYMTABLE.table[i2].address);
  string var3 = to_string(SYMTABLE.table[i3].address);
  if (isdigit(SYMTABLE.table[i1].name[0])){ var1 = "#" + SYMTABLE.table[i1].name; } //przypisywanie posrednie, bez adresu
  if (isdigit(SYMTABLE.table[i2].name[0])){ var2 = "#" + SYMTABLE.table[i2].name; }
  if (isdigit(SYMTABLE.table[i3].name[0])){ var3 = "#" + SYMTABLE.table[i3].name; }

  if(operation == "mov") //mamy z hashem i bez hasha, przesylamy adresy w tablicy symboli, jezeli bedzie z num to z # powinno printowac
  {
    cout << "mov.i " << var1 << "," << var2 << endl;
  }

  if(operation == "add")
  {
    cout << "add.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "sub"){
    cout << "sub.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "mul")
  {
    cout << "mul.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "div")
  {
    cout << "div.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "mod")
  {
    cout << "mod.i " << var1 << "," << var2 << "," << var3 << endl;
  }

  if(operation == "negation")
  {
    cout << "sub.i " << "#0" << "," << var2 << "," << var3 << endl;
  }

  if(operation == "write")
  {
    cout << "write.i " << var1 <<endl;
  }
}

void destroy()
{
  yylex_destroy();
}