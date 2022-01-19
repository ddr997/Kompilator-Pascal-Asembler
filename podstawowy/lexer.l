%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
%}

%option noyywrap

IGNORES       [ \t\r\n]+
LETTER [a-zA-z]
NUM [0-9]+
ID	{LETTER}({NUM}|{LETTER})*


%%
{IGNORES}       {}
begin           {return T_BEGIN;}
end             {return T_END;}
program         {return T_PROGRAM;}
var             {return T_VAR;}
integer	        {return T_INTEGER;}
real	        {return T_REAL;}
":="            {return T_ASSIGN;}
{NUM}           {
                yylval = SYMTABLE.insert_to_table(yytext);
                SYMTABLE.table[yylval].value = stoi(yytext);
                return NUM;
                }
{ID}	        {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0){ yylval = SYMTABLE.insert_to_table(yytext); }
                else{ yylval = check_if_exists; }
                return ID;
                }
.	            {return yytext[0];}

%%
//STD:string(yytext,yyleng) - stworz string z yytext i wez z niego yyleng znakow. Bez yyleng tez dziala