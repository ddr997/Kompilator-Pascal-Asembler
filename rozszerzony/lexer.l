%{
#include "global.h"
#include "parser.hpp"
extern Symtable SYMTABLE;
string operation;
%}

%option noyywrap

IGNORES         [ \t\r\n]+
LETTER          [a-zA-z]
NUM             [0-9]+
ID	            {LETTER}({NUM}|{LETTER})*
OPTIONAL_DIGIT  {NUM}(.{NUM})?

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

[\/\*]|(div)|(mod) {
                   operation = yytext;
                   return T_MULOP;
                   }

{NUM}           {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0)
                {
                    yylval = SYMTABLE.insert_to_table(yytext, number);
                    SYMTABLE.table[yylval].value = stoi(yytext);
                    SYMTABLE.table[yylval].type = (VarType) integer;
                    SYMTABLE.table[yylval].address = SYMTABLE.next_address;
                    SYMTABLE.next_address += 4;
                }
                else{ yylval = check_if_exists; }
                return NUM;
                }

{OPTIONAL_DIGIT} {
                 int check_if_exists = SYMTABLE.find_in_table(yytext);
                 if(check_if_exists < 0)
                 {
                    yylval = SYMTABLE.insert_to_table(yytext, number);
                    SYMTABLE.table[yylval].value = stof(yytext);
                    SYMTABLE.table[yylval].type = (VarType) real;
                    SYMTABLE.table[yylval].address = SYMTABLE.next_address;
                    SYMTABLE.next_address += 8;
                 }
                 else{ yylval = check_if_exists; }
                 return NUM;
                 }                

{ID}	        {
                int check_if_exists = SYMTABLE.find_in_table(yytext);
                if(check_if_exists < 0){ yylval = SYMTABLE.insert_to_table(yytext, identifier); }
                else{ yylval = check_if_exists; }
                return ID;
                }

.	            {return yytext[0];}

%%