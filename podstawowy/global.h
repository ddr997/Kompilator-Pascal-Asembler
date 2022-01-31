#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
using namespace std;

void destroy();
int yylex_destroy();
int yylex();
int type_conversion(int);
void yyerror(char const *);
void gencode(string, int, int, int);
enum class VarType {NONE, INTEGER, REAL};
enum class Input_type {IDENTIFIER = 0, NUMBER = 1, TEMPORARY = 2};
struct Record{
    VarType type = VarType::NONE;
    string name;
    float value = 0;
    int address = -1;
};
class Symtable{
    public:
        Symtable();
        vector<Record> table;
        int next_address = 0;
        int next_temp = 0;
        int insert_to_table(string, Input_type, VarType);
        int find_in_table(string);
        void print_table();
};