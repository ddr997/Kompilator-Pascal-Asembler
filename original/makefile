objects = emitter.o error.o init.o lexer.o main.o parser.o symbol.o

compilator.exe : $(objects)
	@echo Zakonczono tworzenie makefile
	gcc -o compilator $(objects)

# mymake : main.o emitter.o error.o init.o lexer.o parser.o symbol.o
# 	gcc main.o emitter.o error.o init.o lexer.o parser.o symbol.o -o makefile

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

clean:
	@echo Usuwam gotowe pliki
	del /f *.o mymake