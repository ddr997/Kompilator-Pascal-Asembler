%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
%}

%option noyywrap

IGNORES             [ \t\r\n]+
LETTER              [a-zA-z]
NUM                 [0-9]+
ID	                {LETTER}({NUM}|{LETTER})*
OPTIONAL_FRACTION   {NUM}(\.{NUM})?

%%
{IGNORES}       {}
begin           {return T_BEGIN;}
end             {return T_END;}
program         {return T_PROGRAM;}
write           {return T_WRITE;}
var             {return T_VAR;}
integer	        {return T_INTEGER;}
real	        {return T_REAL;}
":="            {return T_ASSIGN;}

procedure       {return T_PROCEDURE;}
function        {return T_FUNCTION;}

if                                  {return T_IF;}
then                                {return T_THEN;}
else                                {return T_ELSE;}
"<"			                        {yylval.relop = (char*) "jl"; return T_RELOP;}
">"			                        {yylval.relop = (char*) "jg"; return T_RELOP;}
"<="			                    {yylval.relop = (char*) "jle"; return T_RELOP;}
">="			                    {yylval.relop = (char*) "jge"; return T_RELOP;}
"="			                        {yylval.relop = (char*) "je"; return T_RELOP;}
"<>"			                    {yylval.relop = (char*) "jne"; return T_RELOP;}

                   
"/"|div         {
                yylval.operation = '/';
                return T_MULOP;
                }

"*"             {
                yylval.operation = '*';
                return T_MULOP;
                }

mod|"%"         {
                yylval.operation = 'm';
                return T_MULOP;
                }

and             {
                yylval.operation = '&';
                return T_MULOP;
                }

or              {
                yylval.operation = '|';
                return T_MULOP;
                }

not             {return T_NOT;}

while           {return T_WHILE;}
do              {return T_DO;}

{NUM}           {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                {
                    yylval.index = SYMTABLE.insert_to_table(yytext, InputType::NUMBER, VarType::INTEGER);
                    SYMTABLE.table[yylval.index].value = stoi(yytext);
                }
                else{ yylval.index = check_if_exists; }
                return NUM;
                }

{ID}	        {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                {
                    yylval.index = SYMTABLE.insert_to_table(yytext, InputType::IDENTIFIER, VarType::NONE);
                }
                else
                { 
                    yylval.index = check_if_exists;
                    //SYMTABLE.global_variables_memory.push_back(SYMTABLE.table[check_if_exists]);
                    //cout << "wpisano " + SYMTABLE.global_variables_memory[SYMTABLE.global_variables_memory.size()-1].name << endl;
                }
                return ID;
                }

{OPTIONAL_FRACTION} {
                    int check_if_exists = SYMTABLE.find_in_table(yytext);
                    if(check_if_exists < 0)
                    { 
                        yylval.index = SYMTABLE.insert_to_table(yytext, InputType::NUMBER, VarType::REAL);
                        SYMTABLE.table[yylval.index].value = stof(yytext);
                    }
                    else{ yylval.index = check_if_exists; }
                    return NUM;
                    }

.	            {return yytext[0];}

%%