#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
using namespace std;

extern string operation;
int yylex();
void yyerror(char const *);
void gencode(string, int, int, int);
enum VarType {none=0, integer=1, real=2};
enum Input_type {identifier, number, temporary};
struct Record{
    VarType type = none;
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