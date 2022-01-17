#include "global.h"
int lookahead;

void parse () {
  lookahead = lexan (); //An. leksykalny moze zwrócić tokeny: NUM (atrybut zawiera liczbe, ktora przeczytal), ID(identyfikator, inaczej zmienna, tokenval zawiera numer wiersza w tablicy symboli) MOD, DIV(wystepujace juz w tablicy), DONE (koniec pliku), NONE (pozostale przypadki, zwraca kod pojedynczego znaku)
  while (lookahead != DONE){ //jezeli otrzymany token nie jest znakiem konca pliku
      expr (); //rozpocznij parsowanie
      match (';'); //jezeli kolejny symbol jest ';', to pobieramy kolejny symbol z wejscia 
    }
}

void expr () { //Parser predykcyjny zamieniajacy notacje infixowa na postfixowa, korzen ma postac 'expr -> term rest'.     
  int t;
  term ();
  while (1)
    switch (lookahead){ //odpowiada za produkcje rest. Produkcja ma postac 'rest -> + term rest | - term rest'. Jezeli kolejny symbol z wejscia zaczyna sie od + lub -, to wywolujemy match, wywolujemy term, wypisujemy
      case '+': // + albo - i powinnismy ponownie wywolac rest(), gdyz mamy rekursje koncowa, ale zamieniona jest tutaj na iteracje a nie wywolanie. Czyli wywolanie na koncu resta() zamieniono na petle while(1)
      case '-':
	      t = lookahead;
	      match (lookahead); //przejdz do kolejnego znaku
	      term (); //wywolaj term
	      emit (t, NONE); //ekwiwalent printa
	      continue;
      default:
	      return;
    }
}

void term () {
  int t;
  factor ();
  while (1)
    switch (lookahead){
      case '*':
      case '/':
      case DIV:
      case MOD:
	      t = lookahead;
	      match (lookahead); //przejdz do kolejnego znaku
	      factor ();
	      emit (t, NONE);
	      continue;
      default:
	      return;
    }
}

void factor () {
  switch (lookahead){
    case '(':
      match ('(');
      expr ();
      match (')');
      break;
    case NUM:
      emit (NUM, tokenval);
      match (NUM); //przejdz do kolejnego znaku
      break;
    case ID:
      emit (ID, tokenval);
      match (ID);
      break;
    default:
      error ("syntax error (factor)");
    }
}

void match (int t) { //jezeli kolejny symbol to 't', to lookahead jest kolejnym znakiem z wejscia, czyli oczekujemy np. ";", znajdujemy to ustawiamy lookahead o jeden symbol z wejscia dalej
  //printf("co jest w lookahead?: %d\n",lookahead);
  if (lookahead == t)
    lookahead = lexan ();
  else
    error ("syntax error (match)");
}


