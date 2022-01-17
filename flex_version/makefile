objects = emitter.o error.o init.o lexer.o main.o parser.o symbol.o

compilator : $(objects)
	@echo Zakonczono tworzenie makefile
	gcc $(objects) -o compilator

main.o : main.c global.h
	gcc -c main.c 

emitter.o : emitter.c global.h
	gcc -c emitter.c

error.o : error.c global.h
	gcc -c error.c 

init.o : init.c global.h
	gcc -c init.c

lexer.o : lexer.c global.h
	gcc -c lexer.c

parser.o : parser.c global.h
	gcc -c parser.c
	
symbol.o : symbol.c global.h
	gcc -c symbol.c

lexer.c: lexer.l
	flex -o lexer.c lexer.l

clean:
	@echo Usuwam gotowe pliki
	rm -f *.o compilator
