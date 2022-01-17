#include "global.h"

#define STRMAX 999
#define SYMMAX 100
char lexemes[STRMAX];
int lastchar = -1;
struct entry symtable[SYMMAX];
int lastentry = 0;
int
lookup (char s[]) //przeszukuje tablice symboli, zeby znalezc czy jest juz taki wejsciowy ciag znakow w tablicy
{
  int p;
  for (p = lastentry; p > 0; p--)
    if (strcmp (symtable[p].lexptr, s) == 0)
      return p;
  return 0;
}
int
insert (char s[], int tok) //funkcja odpowiada za wpisywanie ciagu znakow do tablicy symboli
{
  int len;
  len = strlen (s); //dlugosc stringu
  if (lastentry + 1 >= SYMMAX) //ogranicza dlugosc tablicy symboli
    error ("symbol table full");
  if (lastchar + len + 1 >= STRMAX) //przepelnienie tablicy tokenow
    error ("lexemes array full");
  lastentry++; //zlicza liczbe wpisow
  symtable[lastentry].token = tok; //wpisz token jako drugi argument tego wpisu
  symtable[lastentry].lexptr = &lexemes[lastchar + 1]; //tworzy miejsce w tablicy w strukturze na stringa
  lastchar += len + 1; 
  strcpy (symtable[lastentry].lexptr, s); //wpisz string s jako pierwszy argument tego wpisu
  return lastentry;
}


