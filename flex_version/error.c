#include "global.h"
//obsluga bledu - wskazuje linie w ktorej wystapil blad
void error (char *m){
  fprintf (stderr, "line%d:%s\n", lineno, m);
  exit (1);
}


