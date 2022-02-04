%{
#include "global.h"
#define YYERROR_VERBOSE 1
#define JUMP -99
Symtable SYMTABLE;
vector <int> id_vector; //sluzy do przypisywania typow przy deklaracji
vector <int> parameter_vector; //wektor parametrow procedury/funkcji
//vector <string> local_variables; // sluzy do usuwania zmiennych tymczasowych
Scope actual_scope = Scope::GLOBAL; //okresla w ktorej czesci gramatyki jestesmy
stringstream codeStream; //stringstream do wypisywania kodu

int relop_true, relop_false = 0;
int labCounter = 0;
int while_entry_label, relop_counter = 0;

%}

%union{
  int index;
  char operation;
  VarType variable_type;
  char* relop;
}

%token T_PROGRAM
%token T_VAR
%token T_BEGIN
%token T_END
%token T_WRITE
%token T_ASSIGN

%token T_PROCEDURE
%token T_FUNCTION

%token T_IF
%token T_THEN
%token T_ELSE
%token <relop> T_RELOP

%token T_WHILE
%token T_DO
%token T_NOT

%token <variable_type> T_INTEGER
%token <variable_type> T_REAL
%token <operation> T_MULOP
%token <index> ID
%token <index> NUM
%nterm <variable_type> standard_type type
%nterm <index> identifier_list expression statement procedure_statement expression_list
%left T_MULOP
%left '+' '-'
%left T_RELOP
%left T_NOT



%%
start: program {SYMTABLE.print_table();}

program: T_PROGRAM ID '(' program_identifier_list ')' ';'
         declarations  {
                       actual_scope = Scope::LOCAL; //dla subprogramow
                       SYMTABLE.global_variables_memory = SYMTABLE.table;
                       codeStream << "jump.i #lab0" << endl;
                       labCounter += 1;
                      //  for(int i = 0; i<SYMTABLE.global_variables_memory.size();i++)
                      //   {cout << "wpisano " + SYMTABLE.global_variables_memory[i].name << endl;}
                       }
        subprogram_declarations {
                                actual_scope = Scope::GLOBAL; //po wyjsciu z subprogramow
                                codeStream << "lab0:" << endl;
                                }
        compound_statement 
        '.' {
            cout << codeStream.str();
            codeStream.str("");
            printf("exit\n\n\n");
            }

program_identifier_list: ID | program_identifier_list ',' ID

identifier_list: ID {id_vector.push_back($1);}
               | identifier_list ',' ID {id_vector.push_back($3);}

declarations: declarations T_VAR identifier_list ':' type ';' {
                                                              for(int i=0; i< (int) id_vector.size(); i++)
                                                              {
                                                                //printf("%d , %d\n", id_vector[i], i);
                                                                SYMTABLE.table[id_vector[i]].vartype = $5;
                                                                SYMTABLE.table[id_vector[i]].scope = actual_scope;

                                                                if (actual_scope == Scope::GLOBAL)
                                                                {
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_address;
                                                                  if($5 == VarType::INTEGER)
                                                                    SYMTABLE.next_address += 4;
                                                                  if($5 == VarType::REAL)
                                                                    SYMTABLE.next_address += 8;
                                                                }
                                                                else //jest lokalne
                                                                {
                                                                  if($5 == VarType::INTEGER)
                                                                    {SYMTABLE.next_local_address -= 4;}
                                                                  if($5 == VarType::REAL)
                                                                    {SYMTABLE.next_local_address -= 8;}
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_local_address;
                                                                  //dodaj do wektora usuwajacego zmienne lokalne indeks dla temp
                                                                  //local_variables.push_back(SYMTABLE.table[id_vector[i]].name); 
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
                                          cout << "enter.i #" + to_string(-1*SYMTABLE.next_local_address) << endl; //negujemy. bo next_local idzie w dol
                                          cout << codeStream.str();
                                          cout << "leave" << endl;
                                          cout << "return" << endl;
                                          SYMTABLE.next_local_address = 0; //reset adresu lokalnego
                                          codeStream.str(""); //czyszczenie streamu

                                          //czyszczenie tablicy symboli ze zmiennych tymczasowych
                                          // for(int i = 0; i < local_variables.size(); i++)
                                          // {
                                          //   cout << "\t" + local_variables[i] << endl;
                                          //   for(int j = 0; j < SYMTABLE.table.size(); j++)
                                          //   {
                                          //     if(local_variables[i] == SYMTABLE.table[j].name) SYMTABLE.table.erase(SYMTABLE.table.begin()+j);
                                          //   }
                                          // }
                                          
                                          //czyszczenie pamieci zmiennych lokalnych do zmiennych globalnych
                                          for(int i = 0; i < SYMTABLE.global_variables_memory.size(); i++)
                                          {
                                            for(int j = 0; j < SYMTABLE.table.size(); j++)
                                            {
                                              if(SYMTABLE.global_variables_memory[i].name == SYMTABLE.table[j].name)
                                                SYMTABLE.table[j] = SYMTABLE.global_variables_memory[i];
                                            }
                                          }
                                          }

subprogram_head: T_PROCEDURE ID arguments ';'{
                                             SYMTABLE.table[$2].input_type = InputType::PROCEDURE;
                                             cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta procedury

                                             SYMTABLE.next_parameter_address = (int) parameter_vector.size()*4 + 4; //BP+4 dla adresu powrotu, w odwrotnej kolejnosci na stosie
                                             //cout << SYMTABLE.next_parameter_address << endl;
                                             for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                             {
                                               SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address;
                                               SYMTABLE.next_parameter_address -= 4;
                                               //local_variables.push_back(SYMTABLE.table[parameter_vector[i]].name); //dodawaj te zmienne do usuniecia po procedurze
                                               SYMTABLE.table[$2].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype);
                                             }
                                             SYMTABLE.next_parameter_address = 0;
                                             parameter_vector.clear();
                                             id_vector.clear();
                                             }

              | T_FUNCTION ID arguments ':' standard_type ';' {
                                                              SYMTABLE.table[$2].input_type = InputType::FUNCTION;
                                                              SYMTABLE.table[$2].vartype = $5; //typ zwracany przez funkcje
                                                              cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta funkcji
                                                              SYMTABLE.next_parameter_address = parameter_vector.size()*4 + 8; //BP+8, dla adresu zmiennej tymczasowej wyniku funkcji
                                                              for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                                              {
                                                                SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address;
                                                                SYMTABLE.next_parameter_address -= 4;
                                                                SYMTABLE.table[$2].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype);
                                                              }
                                                              //cout << to_string(parameter_vector.size()) << endl;
                                                              SYMTABLE.next_parameter_address = 0;
                                                              SYMTABLE.table[$2].address = 8; //przypisujemy adres powrotu do funkcji
                                                              parameter_vector.clear();
                                                              id_vector.clear();
                                                              }

arguments: '(' parameter_list ')'
         | /* empty */

parameter_list: identifier_list ':' type  {
                                          for(int i=0; i< (int) id_vector.size(); i++)
                                          {
                                            SYMTABLE.table[id_vector[i]].vartype = $3;
                                            SYMTABLE.table[id_vector[i]].scope = actual_scope;
                                            parameter_vector.push_back(id_vector[i]);
                                          }
                                          id_vector.clear(); //potrzeba czyszczenia po, dlatego dodatkowy wektor ktory sumuje dla parametrow lokalnych
                                          }

              | parameter_list ';' identifier_list ':' type {
                                                            for(int i=0; i< (int) id_vector.size(); i++)
                                                            {
                                                              SYMTABLE.table[id_vector[i]].vartype = $5;
                                                              SYMTABLE.table[id_vector[i]].scope = actual_scope;
                                                              parameter_vector.push_back(id_vector[i]);
                                                            }
                                                            id_vector.clear();
                                                            } 










compound_statement: T_BEGIN  
                    optional_statements
                    T_END

optional_statements: statement_list
                   | /* empty */ 

statement_list: statement
              | statement_list ';' statement

statement: ID T_ASSIGN expression {
                                  if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype) //jezeli sa roznego typu
                                  {
                                    int newtemp = 0;
                                    if(actual_scope == Scope::GLOBAL)
                                      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype); //stworz nowa zmienna temp globalna
                                    else
                                      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[$1].vartype); //lokalna

                                    if(SYMTABLE.table[$3].vartype == VarType::INTEGER) //jezeli jest int, to zamien na real
                                    {
                                      gencode("inttoreal", $3, newtemp, -1);
                                      SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[$3].value;
                                    }
                                    if(SYMTABLE.table[$3].vartype == VarType::REAL) //jezeli jest real, to zamien na int
                                    {
                                      gencode("realtoint", $3, newtemp, -1);
                                      SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[$3].value;
                                    }
                                    $3 = newtemp; //przypisz adres nowej zmiennej do atrybutu expression
                                  }
                                  SYMTABLE.table[$1].value = SYMTABLE.table[$3].value; //przypisz wartosc do id
                                  gencode("mov", $3, $1, -1);
                                  }

          | T_WRITE '(' expression_list ')' {
                                gencode("write", $3, -1, -1);
                               }
          
          | procedure_statement



          | T_IF {
                  relop_false = SYMTABLE.insert_to_table("0", InputType::NUMBER, VarType::INTEGER);
                  relop_true = SYMTABLE.insert_to_table("1", InputType::NUMBER, VarType::INTEGER);
                 }
            expression
            T_THEN {
                   gencode("je", $3, relop_false, JUMP);
                   }
            statement {codeStream << "jump.i #lab" + to_string(labCounter+1) << endl;}//tutaj musi byc jump;
            T_ELSE {
                   codeStream << "lab" + to_string(labCounter) + ":" << endl;
                   labCounter += 1;
                   }
            statement {
                      codeStream << "lab" + to_string(labCounter) + ":" << endl;
                      labCounter += 1;
                      //codeStream << "nastepny wolny: " + to_string(labCounter) << endl;
                      }



          | T_WHILE{
                    while_entry_label = labCounter;
                    relop_false = SYMTABLE.insert_to_table("0", InputType::NUMBER, VarType::INTEGER);
                    relop_true = SYMTABLE.insert_to_table("1", InputType::NUMBER, VarType::INTEGER);
                    codeStream << "lab" + to_string(labCounter+1) + ":" << endl; //label sprawdzajacy 1 wyzej od wejsciowego
                    labCounter += 2; //z 1 do 3
                   }
            expression
            T_DO  {labCounter -= 2*relop_counter; //expression zwieksza o 2*relop_counter petle, wiec musimy sie confac o ilosc expression *2
                  //codeStream << "zmniejsza o: " + to_string(labCounter) << endl;
                  labCounter = while_entry_label;
                  gencode("je", $3, relop_false, JUMP); 
                  }
            statement {
                      codeStream << "jump.i #lab" + to_string(while_entry_label+1) << endl;
                      codeStream << "lab" + to_string(while_entry_label) + ":" << endl;
                      labCounter += 2*relop_counter + 2;
                      //codeStream << "nastepy wolny label: " + to_string(labCounter) << endl;
                      relop_counter = 0;
                      }



procedure_statement: ID {
                        if(SYMTABLE.table[$1].input_type == InputType::PROCEDURE) //wywolanie procedury bez parametrow
                          codeStream << "call.i #" + SYMTABLE.table[$1].name << endl;
                        else
                        {
                          cout << "imhere" << endl;
                          int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype);
                          codeStream << "push.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                          codeStream << "call.i #" + SYMTABLE.table[$1].name << endl;
                        }
                        } 

                   | ID '(' expression_list ')' {
                                                for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow oraz sprawdzanie ich typow
                                                {
                                                  if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                                  {
                                                    int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype_vector[i]); //stworz zmienna ktora przechowa
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[$1].vartype_vector[i] == VarType::INTEGER)
                                                      parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                                      SYMTABLE.table[parameter_vector[i]].vartype = VarType::REAL;
                                                    gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                                    parameter_vector[i] = newtemp; //zamien adresy
                                                  }
                                                  if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[$1].vartype_vector[i]) //jezeli sa takiego samego typu
                                                    codeStream << "push.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                                  else
                                                  {
                                                    int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                                    codeStream << "push.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                                  }
                                                }
                                                codeStream << "call.i #" + SYMTABLE.table[$1].name << endl; //wywolanie procedury
                                                codeStream << "incsp.i #" + to_string(parameter_vector.size()*4) << endl; //podnosimy ze stosu tyle ile push 
                                                parameter_vector.clear();
                                                }

expression_list: expression {
                            parameter_vector.push_back($1); //zbiera indeksy parametrow
                            $$ = $1; //do write'a
                            }
               | expression_list ',' expression {parameter_vector.push_back($3);} //to samo









expression: expression '+' expression {
                                      if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype) //jezeli sa roznego typu
                                      {
                                        if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);} //jezeli 1 jest integerem, to zamien to zmienna temp
                                        if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);} //jezeli 3, to to samo
                                      }
                                      int newtemp = expression_result_temp_gen($1, $3);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value + SYMTABLE.table[$3].value; //przypisz tam wartosc
                                      $$ = newtemp; //przekaz dalej indeks wyniku
                                      gencode("add", $1, $3, newtemp);
                                      }

          | expression '-' expression {
                                      if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                      {
                                        if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);}
                                        if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);}
                                      }
                                      int newtemp = expression_result_temp_gen($1, $3);
                                      SYMTABLE.table[newtemp].value = SYMTABLE.table[$1].value - SYMTABLE.table[$3].value;
                                      $$ = newtemp;
                                      gencode("sub", $1, $3, newtemp);
                                      }

          | expression T_MULOP expression{
                                         if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype)
                                         {
                                            if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);}
                                            if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);}
                                         }
                                         int newtemp = expression_result_temp_gen($1, $3);
                                  
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

                                         if ($2 == '&')
                                         { 
                                           gencode("and", $1, $3, newtemp);
                                           $$ = newtemp;
                                         }

                                         if ($2 == '|')
                                         {
                                           gencode("or", $1, $3, newtemp);
                                           $$ = newtemp;
                                         }

                                         }

          | '-' expression {
                           int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$2].vartype);
                           //SYMTABLE.table[newtemp].value = SYMTABLE.table[$2].value * (-1);
                           $$ = newtemp;
                           gencode("negation", 0, $2, newtemp);
                           }

          | '(' expression ')' {$$ = $2;}
          | ID '(' expression_list ')' {
                                        for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow
                                        {
                                          if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                          {
                                            int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype_vector[i]); //stworz zmienna ktora przechowa
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[$1].vartype_vector[i] == VarType::INTEGER)
                                              parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                              SYMTABLE.table[parameter_vector[i]].vartype = VarType::REAL;
                                            gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                            parameter_vector[i] = newtemp; //zamien adresy
                                          }
                                          if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[$1].vartype_vector[i]) //jezeli sa takiego samego typu
                                            codeStream << "push.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                          else
                                          {
                                            int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                            codeStream << "push.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                          }
                                        }
                                        int newtemp = 0;
                                        if(SYMTABLE.table[$1].input_type == InputType::FUNCTION) //jezeli jest funkcja do dostosuj zmienna zwracajaca do typu funkcji
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype); //nowa zmienna wynika z typu funkcji
                                        else
                                          newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //dla procedur zawsze real
                                        codeStream << "push.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                                        codeStream << "call.i #" + SYMTABLE.table[$1].name << endl; //wywolanie funkcji
                                        codeStream << "incsp.i #" + to_string(parameter_vector.size()*4 + 4) << endl; //podnosimy ze stosu tyle ile push + 4 dla wyniku
                                        SYMTABLE.table[$1].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                                        SYMTABLE.table[$1].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                                        parameter_vector.clear();
                                        $$ = $1;
                                       }
          | ID  {
                if(SYMTABLE.table[$1].input_type == InputType::FUNCTION)
                {
                  int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype); //nowa zmienna wynika z typu funkcji
                  codeStream << "push.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                  codeStream << "call.i #" + SYMTABLE.table[$1].name << endl; //wywolanie funkcji
                  codeStream << "incsp.i #4" << endl;
                  SYMTABLE.table[$1].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                  SYMTABLE.table[$1].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                }
                $$ = $1;
                }

          | NUM {$$ = $1;}

          | expression T_RELOP expression {
                                          //codeStream << "lab" + to_string(labCounter) + ":" << endl;
                                          gencode($2,$1,$3,JUMP); //instrukcja relop + wariant false
                                          int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje true albo False
                                          gencode("mov", relop_false, newtemp, -1);
                                          codeStream << "jump.i #lab" + to_string(labCounter+1) << endl; // aktualnie 1 + 1

                                          //wariant true
                                          codeStream << "lab" + to_string(labCounter) + ":" << endl; //1
                                          gencode("mov", relop_true, newtemp, -1);
                                          labCounter += 1; //zwiekszamy do 2

                                          //zwiekszamy tutaj dla wiekszej ilosci relopow
                                          codeStream << "lab" + to_string(labCounter) + ":" << endl; //printujemy 2
                                          labCounter += 1; //zwiekszamy do 3
                                          
                                          relop_counter += 1;
                                          $$ = newtemp;
                                          }


          | T_NOT expression  { //trzeba na koncu przesunac o 2 w tyl
                              gencode("je", $2, relop_false, JUMP);
                              int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje true albo False
                              gencode("mov", relop_false, newtemp, -1);
                              codeStream << "jump.i #lab" + to_string(labCounter+1) << endl; // aktualnie 1 + 1

                              //wariant true
                              codeStream << "lab" + to_string(labCounter) + ":" << endl; //1
                              gencode("mov", relop_true, newtemp, -1);
                              labCounter += 1; //zwiekszamy do 2

                              //zwiekszamy tutaj dla wiekszej ilosci relopow
                              codeStream << "lab" + to_string(labCounter) + ":" << endl; //printujemy 2
                              labCounter += 1; //zwiekszamy do 3

                              relop_counter += 1;
                              $$ = newtemp;
                              }
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
  if(i3 == JUMP)
    {var3 = ",#lab" + to_string(labCounter);}
  else
    if(i3 >= 0)
      var3 = isdigit(SYMTABLE.table[i3].name[0]) ? ",#" + SYMTABLE.table[i3].name : "," + to_string(SYMTABLE.table[i3].address);
  string type_postfix = SYMTABLE.table[i1].vartype == VarType::INTEGER ? ".i " : ".r ";
  ////
  if(actual_scope == Scope::GLOBAL)
    codeStream << command+type_postfix << var1 << var2 << var3 << endl;
  if(actual_scope == Scope::LOCAL)
  {
    if(var1[0] != '#' && var1 != "") if(var1[0] == '-') var1.insert(0,"BP"); else var1.insert(0,"*BP+");
    if(var2[1] != '#' && var2 != "") if(var2[1] == '-') var2.insert(1,"BP"); else var2.insert(1,"*BP+");
    if(var3[1] != '#' && var3 != "") if(var3[1] == '-') var3.insert(1,"BP"); else var3.insert(1,"*BP+");
    codeStream << command+type_postfix << var1 << var2 << var3 << endl;
  }
}

int type_conversion(int i1)
{
  int newtemp = 0;
  if(SYMTABLE.table[i1].vartype == VarType::INTEGER)
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL);
    SYMTABLE.table[newtemp].value = (float) SYMTABLE.table[i1].value;
    gencode("inttoreal", i1, newtemp, -1);
  }

  if(SYMTABLE.table[i1].vartype == VarType::REAL)
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
    SYMTABLE.table[newtemp].value = (int) SYMTABLE.table[i1].value;
    gencode("realtoint", i1, newtemp, -1);
  }
  return newtemp;
}

int expression_result_temp_gen(int i1, int i3)
{
  int newtemp = 0;
  if(SYMTABLE.table[i1].vartype != SYMTABLE.table[i3].vartype) //jezeli sa roznego typu
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //stworz nowa zmienna na wynik operacji
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL); //stworz nowa zmienna lokalna na wynik operacji
  }
  else //jezeli sa tego samego typu
  {
    if (SYMTABLE.table[i1].vartype == VarType::INTEGER)
      if(actual_scope == Scope::GLOBAL)
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //stworz zmienna na wynik typu int
      else
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER); //stworz zmienna na wynik typu in
    if (SYMTABLE.table[i1].vartype == VarType::REAL)
      if(actual_scope == Scope::GLOBAL)
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //stworz zmienna na wynik typu real
      else
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL); //stworz zmienna na wynik typu real
  }
  return newtemp;
}



void destroy()
{
  yylex_destroy();
}