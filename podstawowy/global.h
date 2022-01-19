#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
using namespace std;

int yylex();
void yyerror(char const *);

enum VariableType {none, integer, real};
struct Record{
    VariableType type_of_variable;
    string name;
    int value = 0;
    unsigned address;
};

class Symtable{
    public:
        Symtable();
        vector<Record> table;
        int next_address;
        int insert_to_table(string);
        int find_in_table(string);
        void print_table();
};