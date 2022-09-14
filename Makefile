all:
	@flex lexer/lexer.l
	@bison -d -Wconflicts-sr -Wcounterexamples parser/parser.y
	@gcc lex.yy.c parser.tab.c table/table.c main.c -o main.out
	@clear
clean:
	@rm *.yy.c *.tab.* *.out