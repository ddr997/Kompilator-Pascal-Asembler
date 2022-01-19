%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
%}

%option noyywrap

IGNORES       [ \t\r\n]+
LETTER [a-zA-z]
NUMBER [0-9]+
ID	{LETTER}({NUMBER}|{LETTER})*


%%
{IGNORES}       {}
begin           {return T_BEGIN;}
end             {return T_END;}
program         {return T_PROGRAM;}
var             {return T_VAR;}
integer	        {return T_INTEGER;}
real	        {return T_REAL;}
":="            {return T_ASSIGN;}
{NUMBER}        {yylval = SYMTABLE.insert_to_table(yytext);
                return NUMBER;
                }
{ID}	        {yylval = SYMTABLE.insert_to_table(yytext);
                return ID;}
.	            {return yytext[0];}

%%
//STD:string(yytext,yyleng) - stworz string z yytext i wez z niego yyleng znakow. Bez yyleng tez dziala