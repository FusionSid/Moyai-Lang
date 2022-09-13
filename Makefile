all:
	@flex lexer/lexer.l
	@/opt/homebrew/opt/bison/bin/bison -d -Wconflicts-sr -Wcounterexamples parser/parser.y
	@gcc lex.yy.c parser.tab.c main.c -o main.out
	@clear
clean:
	@rm *.yy.c *.tab.* *.out