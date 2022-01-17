#include "global.h"
char lexbuf[BSIZE]; //bufor, przechowuje ciag znakow
int lineno = 1; 
int tokenval = NONE;

int lexan () { //Funkcja analizatora leksykalnego, na wyjsciu zwraca kod tokenu (token), a w zmiennej globalnej przechowuje atrybut tego tokenu. Wywoluje go parser zeby pobrac tokeny z wejscia i atrybut tego tokenu
 	int t; //przechowuje kolejny znak z wejscia, musi być zmienna int bo w innym wypadku nie rozrozni znaku konca pliku od jednego z analizowanych znaków
	while (1){
    	t = getchar (); //pobieramy kolejny znak z wejscia / na początku pierwszy znak z wejscia. Caly string jest pobierany z buffora wejsciowego, dlatego mozemy wszystko robic na buforze bez zadnych iteracji.
    	if (t == ' ' || t == '\t'); //jezeli ten znak jest pusty lub jest tabulacja, to nie robi nic
      
    	else if (t == '\n') //jezeli jest znakiem nowej linii, to zwiekszamy znacznik nowej linii
			lineno++; 

    	else if (isdigit (t)){ //jezeli jest cyfra
			ungetc (t, stdin); //oddaj znak na wejscie, zeby pobrac cala cyfre scanf'em!!!
			scanf ("%d", &tokenval); //wczytujemy ta cyfre do zmiennej tokenval (potrzebna do atrybutu, w niej zachowa liczbe ktora zczytal)
			return NUM; //zwracamy kod NUM i w atrybucie tokenu będzie liczba wielocyfrowa którą napotkał
		}
    	else if (isalpha (t)){ //jezeli jest litera
			int p, b = 0; //zmienne potrzebne do bufora
			while (isalnum (t)){ //dopoki napotkamy cyfry i litery
				lexbuf[b] = t; //dopisuj je do bufora
	    		t = getchar (); //pobierz kolejny znak
	    		b++; //zwieksz indeks bufora
	    		if (b >= BSIZE) //error jezeli przekroczy sie rozmiar buffora (domyslnie 128)
					error ("compiler error");
	    }
			lexbuf[b] = EOS; //na koncu bufora wpisuje sie znak 0, oznaczajacy koniec sekwencji
			if (t != EOF) //jezeli nie zakonczyl sie ciag wejsciowy
	    		ungetc (t, stdin); //no to oddajemy nadmiarowo przeczytany znak ponownie na wejscie
	  		p = lookup (lexbuf); //ta linijka odpowiada za znalezienie zapisanego ciagu w tablicy symboli
	  		if (p == 0) //jezeli nie znalazl takiego ciagu w tablicy symboli
	    		p = insert (lexbuf, ID); //to wpisujemy go to tablicy symboli jako identyfikator
	  		tokenval = p; //wpisujemy do atrybutu indeks z tablicy symboli.
	  		return symtable[p].token; //zwracamy token danej krotki, ktora jest juz zapisana w tablicy symboli - moze zwrocic ID,DIV lub MOD. W zmiennej p znajduje sie indeks w tablicy symboli.
		}

    	else if (t == EOF) //przy napotkaniu konca pliku zwraca token DONE
			return DONE;
    
		else{
	  	tokenval = NONE; //w pozostalym przypadku ustawia tokenval NONE i zwraca kod pojedynczego znaku
	  	return t;
		}
    }
}


