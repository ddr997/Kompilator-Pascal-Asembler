%{
#include "global.h"
#include <math.h>
int lineno = 1; 
int tokenval = NONE;
int p;
%}
%option noyywrap
%%
[ \t]+  /*Skip whitespaces and tabs*/
[ \t]+$ /* End of line whitespaces */
\n      {++lineno;}
[0-9]+  {tokenval = atoi(yytext); return NUM;}
div     {tokenval = NONE; return DIV;}
mod     {tokenval = NONE; return MOD;}
[A-Za-z][A-Za-z0-9]+    {p = insert(yytext, ID); tokenval = p; return symtable[p].token;}
<<EOF>> {return DONE;}
.       {tokenval = NONE; return yytext[0];} 
%%
int lexan()
{
yylex();
}