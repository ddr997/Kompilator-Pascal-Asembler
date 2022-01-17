#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>

using namespace std;

enum vartype {none, integer, real}; //0 - none; 1 - integerl 2 - real
struct entry {
std::string name; //nazwa
vartype type; //typ (0,1,2)
unsigned address; //adres
};

typedef vector<entry> symtable_t; //wektor typu entry)struktury o nazwie symtable_t - _t to konwencja nazywana typow danych

extern symtable_t symtable; //deklaracja zmiennej symtable (nie definicja)

int addtotable(const string& s);
int findintable(const string& s);

int yylex();
void yyerror(char const *);
