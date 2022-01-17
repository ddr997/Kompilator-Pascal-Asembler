#include "global.h" 
void emit (int t, int tval) { //funckja wysyla na wyjscie odpowiedni znak w zaleznosci od otrzymanego tokenu lub numeru reprezentujacego token
  switch (t){
    case '+':
    case '-':
    case '*':
    case '/':
      printf ("%c\n", t);
      break;
    case DIV:
      printf ("DIV\n");
      break;
    case MOD:
      printf ("MOD\n");
      break;
    case NUM:
      printf ("%d\n", tval);
      break;
    case ID:
      printf ("%s\n", symtable[tval].lexptr);
      break;
    default:
      printf ("token %d , tokenval %d\n", t, tval);
    }
}


