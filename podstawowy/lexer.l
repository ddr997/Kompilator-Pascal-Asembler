%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
%}

%option noyywrap

IGNORES         [ \t\r\n]+
LETTER          [a-zA-z]
NUM             [0-9]+
ID	            {LETTER}({NUM}|{LETTER})*

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
                    yylval.index = SYMTABLE.insert_to_table(yytext, Input_type::NUMBER);
                    SYMTABLE.table[yylval.index].value = stoi(yytext);
                    SYMTABLE.table[yylval.index].type = VarType::INTEGER;
                }
                else{ yylval.index = check_if_exists; }
                return NUM;
                }

{ID}	        {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                { 
                    yylval.index = SYMTABLE.insert_to_table(yytext, Input_type::IDENTIFIER);
                }
                else{ yylval.index = check_if_exists; }
                return ID;
                }

.	            {return yytext[0];}

%%