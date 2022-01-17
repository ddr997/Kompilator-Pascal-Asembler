#include "global.h"
void destroy()
{
  yylex_destroy();
}

int main () 
{
  init ();
  atexit(destroy);
  parse ();
  exit (0);
}


