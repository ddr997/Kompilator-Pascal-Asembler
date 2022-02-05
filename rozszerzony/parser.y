%{
#include "global.h"
#define YYERROR_VERBOSE 1
#define JUMP -99
extern int yylineno;
Symtable SYMTABLE;
vector <int> id_vector; //sluzy do przypisywania typow przy deklaracji
vector <int> parameter_vector; //wektor parametrow procedury/funkcji
vector <int> func_result; //wektor parametrow procedury/funkcji
vector <int> parameter_memory; //wektor parametrow procedury/funkcji
Scope actual_scope = Scope::GLOBAL; //okresla w ktorej czesci gramatyki jestesmy
stringstream codeStream; //stringstream do wypisywania kodu
ofstream myfile;

int relop_true, relop_false = 0; //wpisuje do tablicy 0 i 1
int labCounter = 0; //zmienna do numerowania labeli

%}

%union{
  int index; //indeks w tablicy symboli
  char operation; //arytmetyczne
  VarType variable_type; //typ zmiennych
  const char* relop; //relacyjne
}

%token T_PROGRAM
%token T_VAR
%token <index> T_BEGIN
%token <index> T_END
%token T_WRITE
%token T_READ
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
%nterm <index> identifier_list expression statement compound_statement procedure_statement expression_list
%left '+' '-'
%left T_MULOP
%left T_NOT
%left T_RELOP



%%
start: program {SYMTABLE.print_table(); 
                myfile.close();
                }

program: T_PROGRAM ID '(' program_identifier_list ')' ';'
         declarations  {
                       myfile.open ("output.asm");
                       actual_scope = Scope::LOCAL; //scope dla funkcji i procedur
                       SYMTABLE.global_variables_memory = SYMTABLE.table;
                      //  cout << "\n\tjump.i #lab0" << endl;
                       myfile << "\tjump.i #lab0" << endl;
                       labCounter += 1; //kolejny label od 0
                       relop_false = SYMTABLE.insert_to_table("0", InputType::NUMBER, VarType::INTEGER);
                       relop_true = SYMTABLE.insert_to_table("1", InputType::NUMBER, VarType::INTEGER);
                       }
        subprogram_declarations {
                                actual_scope = Scope::GLOBAL; //po wyjsciu z subprogramow
                                //cout << "lab0:" << endl;
                                myfile << "lab0:" << endl;
                                SYMTABLE.refresh_symtable();
                                }
        compound_statement 
        '.' {
            // cout << codeStream.str();
            myfile << codeStream.str();
            codeStream.str("");
            //cout << "\texit\n\n\n" << endl;
            myfile << "\texit" << endl;
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
                                          // cout << "\tenter.i #" + to_string(-1*SYMTABLE.next_local_address) << endl; //negujemy. bo next_local idzie w dol
                                          // cout << codeStream.str();
                                          // cout << "\tleave" << endl;
                                          // cout << "\treturn" << endl;
                                          myfile << "\tenter.i #" + to_string(-1*SYMTABLE.next_local_address) << endl; //negujemy. bo next_local idzie w dol
                                          myfile << codeStream.str();
                                          myfile << "\tleave" << endl;
                                          myfile << "\treturn" << endl;
                                          SYMTABLE.next_local_address = 0; //reset adresu lokalnego
                                          codeStream.str(""); //czyszczenie streamu
                                          SYMTABLE.refresh_symtable();
                                          }

subprogram_head: T_PROCEDURE ID arguments ';'{
                                             SYMTABLE.table[$2].input_type = InputType::PROCEDURE;
                                            //  cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta procedury
                                             myfile << SYMTABLE.table[$2].name + ":" <<endl; //etykieta procedury

                                             SYMTABLE.next_parameter_address = (int) parameter_vector.size()*4 + 4; //BP+4 dla adresu powrotu
                                             for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                             {
                                               SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address; //ustawia adresy parametrow
                                               SYMTABLE.next_parameter_address -= 4;
                                               SYMTABLE.table[$2].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype); //zapisz jakie typy
                                             }
                                             SYMTABLE.next_parameter_address = 0;
                                             parameter_vector.clear();
                                             id_vector.clear();
                                             }

              | T_FUNCTION ID arguments ':' standard_type ';' {
                                                              SYMTABLE.table[$2].input_type = InputType::FUNCTION;
                                                              SYMTABLE.table[$2].vartype = $5; //typ zwracany przez funkcje
                                                              // cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta funkcji
                                                              myfile << SYMTABLE.table[$2].name + ":" <<endl; //etykieta funkcji
                                                              SYMTABLE.next_parameter_address = parameter_vector.size()*4 + 8; //BP+8, dla adresu zmiennej tymczasowej wyniku funkcji
                                                              for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                                              {
                                                                SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address;
                                                                SYMTABLE.next_parameter_address -= 4;
                                                                SYMTABLE.table[$2].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype);
                                                              }
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
                                    }
                                    if(SYMTABLE.table[$3].vartype == VarType::REAL) //jezeli jest real, to zamien na int
                                    {
                                      gencode("realtoint", $3, newtemp, -1);
                                    }
                                    $3 = newtemp; //przypisz adres nowej zmiennej do atrybutu expression
                                  }
                                  gencode("mov", $3, $1, -1);
                                  }

          | T_WRITE '(' expression_list ')' {
                                for(int i = 0; i<parameter_vector.size(); i++)
                                {
                                  gencode("write", parameter_vector[i], -1, -1);
                                }
                                parameter_vector.clear();
                               }

          | T_READ '(' expression_list ')' {
                                for(int i = 0; i<parameter_vector.size(); i++)
                                {
                                  gencode("read", parameter_vector[i], -1, -1);
                                }
                                parameter_vector.clear();
                               }
          
          | procedure_statement

          | compound_statement

          | T_IF {
                 $<index>$ = labCounter; //zapisz wejsciowy label (default 1)
                 }
            expression
            T_THEN {
                   gencode("je", $3, relop_false, JUMP);
                   $<index>$ = labCounter; //label wyjsciowy z relopa, labCounter po wyjsciu z expression oznacza nastepny wolny label
                   labCounter += 2; //dodajemy dla nastepnego porownania (expression obsluguje kod dla 2 labeli w przod)
                   }
            statement {
                      codeStream << "\tjump.i #lab" + to_string($<index>5+1) << endl; //skok do wyjscia ze statementu
                      $<index>$ = $<index>5; //wartosc labelu z else
                      }
            T_ELSE {
                   codeStream << "lab" + to_string($<index>7) + ":" << endl;
                   $<index>$ = $<index>7 + 1; //wartosc labelu wyjscia
                   }
            statement {
                      codeStream << "lab" + to_string($<index>9) + ":" << endl; //label wyjsciowy
                      }



          | T_WHILE{
                    codeStream << "lab" + to_string(labCounter+1) + ":" << endl; //label warunku
                    $<index>$ = labCounter; //d2 przekazuje label wejsciowy (defaultowo 1 po lab0)
                    labCounter += 2; //wyprowadzone dla ifa
                   }
            expression
            T_DO  {
                  int temp = labCounter; //odwolanie do labela wejsciowego, bo gencode wykorzystuje labCounter
                  labCounter = $<index>2;
                  gencode("je", $3, relop_false, JUMP);
                  labCounter = temp;
                  $<index>$ = $<index>2; //label wyjsciowy z petli
                  }
            statement {
                      codeStream << "\tjump.i #lab" + to_string($<index>5+1) << endl;
                      codeStream << "lab" + to_string($<index>5) + ":" << endl;
                      }








procedure_statement: ID {
                        if(SYMTABLE.table[$1].input_type == InputType::PROCEDURE) //wywolanie procedury bez parametrow
                          codeStream << "\tcall.i #" + SYMTABLE.table[$1].name << endl;
                        else //w przypadku wywolania funkcji
                        {
                          int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype);
                          codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                          codeStream << "\tcall.i #" + SYMTABLE.table[$1].name << endl;
                        }
                        } 

                   | ID '(' {
                    parameter_memory = parameter_vector;
                    //for(int i = 0; i< memory.size(); i++){codeStream << " " + SYMTABLE.table[memory[i]].name << endl;}
                    parameter_vector.clear();
                   }
                   
                   expression_list ')' {
                                                for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow oraz sprawdzanie ich typow
                                                {
                                                  if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                                  {
                                                    int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype_vector[i]); //stworz zmienna ktora przechowa
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[$1].vartype_vector[i] == VarType::INTEGER)
                                                      parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                                      SYMTABLE.table[parameter_vector[i]].vartype = VarType::INTEGER;
                                                    gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                                    parameter_vector[i] = newtemp; //zamien adresy
                                                  }
                                                  if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[$1].vartype_vector[i]) //jezeli sa takiego samego typu
                                                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                                  else
                                                  {
                                                    int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                                  }
                                                }
                                                codeStream << "\tcall.i #" + SYMTABLE.table[$1].name << endl; //wywolanie procedury
                                                codeStream << "\tincsp.i #" + to_string(parameter_vector.size()*4) << endl; //podnosimy ze stosu tyle ile push 
                                                parameter_vector = parameter_memory;
                                                parameter_memory.clear();
                                                }









expression_list: expression {
                            //codeStream << "single"<< endl;
                            parameter_vector.push_back($1); //zbiera indeksy z tablicy parametrow
                            $$ = $1;
                            }
               | expression_list ',' expression { 
                                                  //codeStream << "multiple"<< endl; //+ to_string($1 )
                                                  parameter_vector.push_back($3);
                                                  $$ = $3;
                                                } 

expression: expression '+' expression {
                                      if(SYMTABLE.table[$1].vartype != SYMTABLE.table[$3].vartype) //jezeli sa roznego typu
                                      {
                                        if(SYMTABLE.table[$1].vartype == VarType::INTEGER) {$1 = type_conversion($1);} //jezeli 1 jest integerem, to zamien to zmienna temp
                                        if(SYMTABLE.table[$3].vartype == VarType::INTEGER) {$3 = type_conversion($3);} //jezeli 3, to to samo
                                      }
                                      int newtemp = expression_result_temp_gen($1, $3);
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
                                          $$ = newtemp;
                                          gencode("mul", $1, $3, newtemp);
                                         }

                                         if ($2 == '/')
                                         {
                                          $$ = newtemp;
                                          gencode("div", $1, $3, newtemp);
                                         }

                                         if ($2 == 'm')
                                         {
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
                           $$ = newtemp;
                           gencode("negation", 0, $2, newtemp);
                           }

          | '(' expression ')' {$$ = $2;}



          | ID '(' {
            parameter_memory = parameter_vector;
            //for(int i = 0; i< parameter_memory.size(); i++){codeStream << " " + SYMTABLE.table[parameter_memory[i]].name << endl;}
            parameter_vector.clear();
            }
          
            expression_list ')' {
                                        for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow
                                        {
                                          int newtemp = 0;
                                          if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                          {
                                            if(actual_scope == Scope::GLOBAL)
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype_vector[i]); //stworz zmienna ktora przechowa
                                            else
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[$1].vartype_vector[i]); //stworz zmienna ktora przechowa
                                              
                                             //sprawdzenie typow argumentow 
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[$1].vartype_vector[i] == VarType::INTEGER)
                                              parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                              SYMTABLE.table[parameter_vector[i]].vartype = VarType::INTEGER;
                                            gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                            parameter_vector[i] = newtemp; //zamien adresy
                                          }
                                          //dla zmiennych
                                          if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[$1].vartype_vector[i]) //jezeli sa takiego samego typu
                                            if(actual_scope == Scope::GLOBAL)
                                              codeStream << "\tpush.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                            else
                                              if(SYMTABLE.table[parameter_vector[i]].address > 0)
                                                codeStream << "\tpush.i BP+" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                              else
                                                codeStream << "\tpush.i #BP" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                          else
                                          {
                                            int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                            if(actual_scope == Scope::GLOBAL)
                                              codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                            else
                                              codeStream << "\tpush.i #BP" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                          }
                                        }

                                        int newtemp = 0;
                                        if(SYMTABLE.table[$1].input_type == InputType::FUNCTION) //jezeli jest funkcja to stworz zmienna do ktorej wrzuci wynik
                                        {
                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype); //nowa zmienna wynika z typu funkcji
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[$1].vartype); //nowa zmienna wynika z typu funkcji
                                        }
                                        else
                                        {
                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //dla procedur zawsze real
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL); //dla procedur zawsze real
                                        }

                                        if(actual_scope == Scope::GLOBAL)
                                          codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                                        else
                                          codeStream << " \tpush.i #BP" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                                        codeStream << "\tcall.i #" + SYMTABLE.table[$1].name << endl; //wywolanie funkcji
                                        codeStream << "\tincsp.i #" + to_string(parameter_vector.size()*4 + 4) << endl; //podnosimy ze stosu tyle ile push + 4 dla wyniku

                                        SYMTABLE.table[$1].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                                        SYMTABLE.table[$1].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                                        //for(int i = 0; i< parameter_vector.size(); i++){codeStream << " " + SYMTABLE.table[parameter_vector[i]].name << endl;}
                                        parameter_vector = parameter_memory;
                                        parameter_memory.clear();
                                        $$ = newtemp; //przekaz dalej adres przechowujacy wynik
                                        //$$ = $1;

                                       }



          | ID  {
                if(SYMTABLE.table[$1].input_type == InputType::FUNCTION) //jezeli wywolujemy funkcje bez argumentu
                { 
                  int newtemp = 0;
                  if(actual_scope == Scope::GLOBAL)
                  {
                    newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[$1].vartype); //nowa zmienna przechowujaca wynika z typu funkcji
                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                    codeStream << "\tcall.i #" + SYMTABLE.table[$1].name << endl; //wywolanie funkcji
                    codeStream << "\tincsp.i #4" << endl;
                    SYMTABLE.table[$1].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                    SYMTABLE.table[$1].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                  }
                }
                $$ = $1;
                }

          | NUM {$$ = $1;}

          | expression T_RELOP expression {
                                          int newtemp = 0;
                                          gencode($2,$1,$3,JUMP); //instrukcja relop i ponizej wariant false; pobiera globalnie labCounter
                                          labCounter -= 2;

                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje wartosc logiczna
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
                                          gencode("mov", relop_false, newtemp, -1);

                                          codeStream << "\tjump.i #lab" + to_string(labCounter+3) << endl; 
                                          //wariant true
                                          codeStream << "lab" + to_string(labCounter+2) + ":" << endl;
                                          gencode("mov", relop_true, newtemp, -1);

                                          codeStream << "lab" + to_string(labCounter+3) + ":" << endl;
                                          labCounter += 4; //nastepny wolny, relop zajmuje 3 labele, wiec musimy podniesc
                                          $$ = newtemp; //przekazujemy adres wyniku dalej
                                          }


          | T_NOT expression  {
                              int newtemp = 0;
                              gencode("je", $2, relop_false, JUMP);
                              if(actual_scope == Scope::GLOBAL)
                                newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje true albo False
                              else
                                newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
                              gencode("mov", relop_false, newtemp, -1);
                              codeStream << "\tjump.i #lab" + to_string(labCounter+1) << endl;

                              //wariant true
                              codeStream << "lab" + to_string(labCounter) + ":" << endl;
                              gencode("mov", relop_true, newtemp, -1);

                              codeStream << "lab" + to_string(labCounter+1) + ":" << endl;
                              
                              labCounter += 2; //not zajmuje 1 label, wiec trzeba podniesc
                              $$ = newtemp;
                              }
%%



void yyerror(char const *s)
{
  fprintf(stderr,"\x1B[35mLine number %d : \x1B[37m%s\n",yylineno,s);
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
    codeStream << "\t" << command+type_postfix << var1 << var2 << var3 << endl;
  if(actual_scope == Scope::LOCAL)
  {
    if(var1 != "" && var1[0] != '#' ) if(var1[0] == '-') var1.insert(0,"BP"); else var1.insert(0,"*BP+");
    if(var2 != "" && var2[1] != '#' ) if(var2[1] == '-') var2.insert(1,"BP"); else var2.insert(1,"*BP+");
    if(var3 != "" && var3[1] != '#') if(var3[1] == '-') var3.insert(1,"BP"); else var3.insert(1,"*BP+");
    codeStream << "\t" << command+type_postfix << var1 << var2 << var3 << endl;
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
    gencode("inttoreal", i1, newtemp, -1);
  }

  if(SYMTABLE.table[i1].vartype == VarType::REAL)
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
    gencode("realtoint", i1, newtemp, -1);
  }
  return newtemp;
}

int expression_result_temp_gen(int i1, int i3) //generator tempa dla expression
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
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
    if (SYMTABLE.table[i1].vartype == VarType::REAL)
      if(actual_scope == Scope::GLOBAL)
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //stworz zmienna na wynik typu real
      else
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL);
  }
  return newtemp;
}


void destroy()
{
  yylex_destroy();
}