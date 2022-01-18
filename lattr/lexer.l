%{
#include "symtable.h"
#include "parser.hpp"
%}

%option noyywrap

ID	[a-z][a-z0-9]*

%%
[ \n\t] {}
[ \t]+$ {}/* End of line whitespaces */
int	{return INT;}
real	{return REAL;}
{ID}	{yylval=addtotable(string(yytext,yyleng));return ID;}
.	{return yytext[0];}

%%