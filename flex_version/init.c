#include "global.h"
struct entry keywords[] = { //stworzenie instancji struktury, który wysyla sie na poczatku programu do tablicy symboli. Pierwszy argument to ciag znakow tworzacy ten wpis, a drugi to token
  {0, 0} 
};
void init () 
{
  struct entry *p; //defines a variable named p that can store an address of a variable of the type struct entry.
  for (p = keywords; p->token; p++) //to iteruje 2 razy, p wskazuje na adres kolejnej krotki struktury, warunek pętli to dopóki spotyka jakiś identyfikator pola "token"
    insert (p->lexptr, p->token); //funkcja wpisania do tablicy znakow, zwraca numer wpisu do tablicy symboli 
}