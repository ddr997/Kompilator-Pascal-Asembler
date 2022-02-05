#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
#include <sstream>
#include <fstream>
#include "tabulate.h"
using namespace std;
using namespace tabulate;

void destroy();
int yylex_destroy();
int yylex();
int type_conversion(int);
int expression_result_temp_gen(int, int);
void yyerror(char const *);
void gencode(string, int, int, int);
enum class VarType {NONE = -1, INTEGER = 0, REAL = 1};
enum class InputType {NONE = -1, IDENTIFIER = 0, NUMBER = 1, TEMPORARY = 2, TEMPORARY_LOCAL = 3, PROCEDURE = 4, FUNCTION = 5};
enum class Scope {GLOBAL = 0, LOCAL = 1};
struct Record{
    string name;
    InputType input_type = InputType::NONE;
    VarType vartype = VarType::NONE;
    Scope scope = Scope::GLOBAL;
    int address = -1;
    vector <VarType> vartype_vector; //lista typow dla referencji
};
class Symtable{
    public:
        Symtable();
        vector<Record> table;
        vector<Record> global_variables_memory; //nadpisywanie zmiennej globalnej przez zmienna lokalna
        int next_address = 0; //adresy dla zmiennych globalnych
        int next_temp = 0;
        int next_local_address = 0; //adresowanie dla zmiennych lokalnych
        int next_parameter_address = 0; //adresy dla parametrów w funkcjach/procedurach
        int insert_to_table(string, InputType, VarType);
        int find_in_table(string);
        void refresh_symtable();
        void print_table();
};