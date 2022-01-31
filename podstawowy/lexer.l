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

{NUM}           {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                {
                    yylval.index = SYMTABLE.insert_to_table(yytext, Input_type::NUMBER, VarType::INTEGER);
                    SYMTABLE.table[yylval.index].value = stoi(yytext);
                }
                else{ yylval.index = check_if_exists; }
                return NUM;
                }

{ID}	        {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                { 
                    yylval.index = SYMTABLE.insert_to_table(yytext, Input_type::IDENTIFIER, VarType::NONE);
                }
                else{ yylval.index = check_if_exists; }
                return ID;
                }

{OPTIONAL_FRACTION} {
                    int check_if_exists = SYMTABLE.find_in_table(yytext);
                    if(check_if_exists < 0)
                    { 
                        yylval.index = SYMTABLE.insert_to_table(yytext, Input_type::NUMBER, VarType::REAL);
                        SYMTABLE.table[yylval.index].value = stof(yytext);
                    }
                    else{ yylval.index = check_if_exists; }
                    return NUM;
                    }

.	            {return yytext[0];}

%%