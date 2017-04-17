all: server
SRC = src/main.c


server: src/main.c
	yacc --defines=obj/parser.h tool/parser.y -o obj/parser.tab.c
	lex --outfile=obj/parser.lex.c tool/parser.l
	gcc -Wall -o server -g3 src/main.c -Itool -Isrc -Iobj\
		obj/parser.lex.c obj/parser.tab.c 



clean:
	rm -rf obj/*
	rm -rf server


