CC=gcc
CFLAGS= -O3 -s

NAME = prec
Test: parse lexer
	$(CC) *.c $(CFLAGS) -o $(NAME)
parse: $(NAME).y
	bison -dv $^
lexer: $(NAME).l
	flex -I --header-file=lex.h $^
