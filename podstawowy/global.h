#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
using namespace std;

int yylex();
void yyerror(char const *);
void gencode(string, int, int, int);

enum Variable_type {integer, real};
enum Input_type {identifier, number, temporary};
struct Record{
    Variable_type type_of_variable = integer;
    string name;
    int value = 0;
    int address = -1;
};

class Symtable{
    public:
        Symtable();
        vector<Record> table;
        int next_address = 0;
        int next_temp = 0;
        int insert_to_table(string, Input_type);
        int find_in_table(string);
        void print_table();
};