all:
	@lex */*.l
	@gcc main.c lex.yy.c -o main.out
clean:
	@rm *.yy.c *.out