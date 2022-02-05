compiler: parser.o lexer.o symtable.o
	g++ -g parser.o lexer.o symtable.o -o compiler

parser.o: parser.cpp global.h
	g++ -c -g parser.cpp

lexer.o : lexer.cpp parser.hpp global.h
	g++ -c -g lexer.cpp

symtable.o: symtable.cpp global.h
	g++ -c -g symtable.cpp

parser.cpp parser.hpp: parser.y
	bison -d -v -o parser.cpp parser.y

lexer.cpp : lexer.l
	flex -o lexer.cpp lexer.l

clean:
	-rm *.o
	-rm parser.cpp
	-rm parser.hpp
	-rm parser.output
	-rm lexer.cpp
	-rm compiler