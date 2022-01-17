%{
#include "global.h"
#include <math.h>
int lineno = 1; 
int p;
%}
%option noyywrap
%%
[ \t]+  /*Skip whitespaces and tabs*/
[ \t]+$ /* End of line whitespaces */
\n      {++lineno;}
[0-9]+  {yylval = atoi(yytext); return NUM;}
div     {yylval = NONE; return DIV;}
mod     {yylval = NONE; return MOD;}
[A-Za-z][A-Za-z0-9]+    {p = insert(yytext, ID); yylval = p; return symtable[p].token;}
<<EOF>> {return DONE;}
.       {yylval = NONE; return yytext[0];} 
%%
void lexan()
{
yylex();
}