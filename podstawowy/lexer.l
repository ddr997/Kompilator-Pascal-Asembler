%{
#include "symtable.h"
#include "parser.hpp"
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
{NUMBER}        {yylval=addtotable(std::string(yytext,yyleng));
                return NUMBER;
                }
{ID}	        {yylval=addtotable(std::string(yytext,yyleng));
                return ID;}
.	        {return yytext[0];}

%%
//STD:string(yytext,yyleng) - stworz string z yytext i wez z niego yyleng znakow. Bez yyleng tez dziala