%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
%}

%option yylineno
%option noyywrap

IGNORES             [ \t\r]+
LETTER              [a-zA-z]
NUM                 [0-9]+
ID	                {LETTER}({NUM}|{LETTER})*
OPTIONAL_FRACTION   {NUM}(\.{NUM})?

%%
{IGNORES}       {}
\n              {}
begin           {return T_BEGIN;}
end             {return T_END;}
program         {return T_PROGRAM;}
read            {return T_READ;}
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
"<"			                        {yylval.relop = "jl"; return T_RELOP;}
">"			                        {yylval.relop = "jg"; return T_RELOP;}
"<="			                    {yylval.relop = "jle"; return T_RELOP;}
">="			                    {yylval.relop = "jge"; return T_RELOP;}
"="			                        {yylval.relop = "je"; return T_RELOP;}
"<>"			                    {yylval.relop = "jne"; return T_RELOP;}

                   
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
                }
                return ID;
                }

{OPTIONAL_FRACTION} {
                    int check_if_exists = SYMTABLE.find_in_table(yytext);
                    if(check_if_exists < 0)
                    { 
                        yylval.index = SYMTABLE.insert_to_table(yytext, InputType::NUMBER, VarType::REAL);
                    }
                    else{ yylval.index = check_if_exists; }
                    return NUM;
                    }

.	            {return yytext[0];}

%%