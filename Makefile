all:
	@flex lexer/lexer.l
	@bison -d -Wconflicts-sr -Wcounterexamples parser/parser.y
	@gcc lex.yy.c parser.tab.c transpiler/convert_to_c.c main.c -o main.out
clean:
	@rm *.yy.c *.tab.* *.out