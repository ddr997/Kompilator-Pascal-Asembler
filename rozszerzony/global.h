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
enum class VarType {NONE = -1, INTEGER = 0, REAL = 1};
enum class InputType {NONE = -1, IDENTIFIER = 0, NUMBER = 1, TEMPORARY = 2, PROCEDURE = 3};
enum class Scope {GLOBAL = 0, LOCAL = 1};
struct Record{
    string name;
    InputType input_type = InputType::NONE;
    VarType vartype = VarType::NONE;
    Scope scope = Scope::GLOBAL;
    float value = 0;
    int address = -1;
};
class Symtable{
    public:
        Symtable();
        vector<Record> table;
        int next_address = 0;
        int next_temp = 0;
        int next_local_address = 0;
        int next_parameter_address = 0;
        int insert_to_table(string, InputType, VarType);
        int find_in_table(string);
        void print_table();
};