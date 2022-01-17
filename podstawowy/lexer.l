%{
#include "symtable.h"
#include "parser.hpp"
%}

%option noyywrap

LETTER [a-zA-z]
DIGIT [0-9]
DIGITS DIGIT+
ID	{LETTER}({DIGIT}|{LETTER})*


%%
[ \n\t] {}
program {return T_PROGRAM;}
var     {return T_VAR;}
integer	{return T_INTEGER;}
real	{return T_REAL;}
{ID}	{yylval=addtotable(std::string(yytext,yyleng));
        return ID;} 
.	    {return yytext[0];}

%%
//STD:string(yytext,yyleng) - stworz string z yytext i wez z niego yyleng znakow. Bez yyleng tez dziala