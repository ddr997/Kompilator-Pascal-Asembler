%{
#include "symtable.h"
#define YYERROR_VERBOSE 1
unsigned next_adress = 0;
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
               for(int i=0;i<symtable.size();i++){
               cout << symtable[i].name<< " " <<symtable[i].type<< " " <<symtable[i].address <<endl;}
               }

program: declarations ';' program
       | declarations ';'

declarations: ID list {
                      symtable[$1].type=(vartype)$2;
                      symtable[$1].address=next_adress;
                      if($2 == integer){
                        next_adress += 4;}
                      if($2 == real){
                        next_adress += 8;}
                      }

list: ',' ID list {
                  $$=$3;
                  symtable[$2].type=(vartype)$3;
                  symtable[$2].address=next_adress;
                  if($3 == integer){
                    next_adress += 4;}
                  if($3 == real){
                    next_adress += 8;}
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

symtable_t symtable;

int addtotable(const string& s)
{
  int i;
  for(i=0;i<symtable.size();i++) //przeszukaj tablice symboli
    if(symtable[i].name==s) // jezeli podana nazwa juz jest w tablicy
      return i; //zwroc indeks tablicy
  entry d; //ze struktury entry
  d.name=s; //nazwa identyfikatora
  d.type=none; //typ bedzie 0
  symtable.push_back(d); //dodaje na koniec wektora nowy element
  return i; //zwroc indeks z tablicy, jezeli nie znalazlo to bedzie na koncu?
};

int findintable(const string& s)
{
  int i;
  for(i=0;i<symtable.size();i++)
    if(symtable[i].name==s)
      return i;
  return -1; //w innym wypadku nie ma jej w tablicy symboli
};

void gencode(const string& m, int i1, int i2, int i3){
}

