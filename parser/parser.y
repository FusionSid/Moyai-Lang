%{
#include <stdio.h>
#include <stdlib.h>

extern void yyerror();
extern int yylex();
extern char* yytext;
extern int yylineno;

%}

%define parse.lac full
%define parse.error verbose

%union {
    char* string_value;
    char char_value;
    int integer_value;
    float float_value;
}

%start LINE
%token PRINT 
%token EXIT_PROGRAM

%token <string_value> STRING_LITERAL
%token <char_value> CHAR_LITERAL
%token <integer_value> INTEGER_LITERAL 
%token <float_value> FLOAT_LITERAL 

%token <char_value> ASIGN EOL
%token <string_value> IDENTIFIER

%token <char_value> CURLY_BRACE_OPEN CURLY_BRACE_CLOSE SQUARE_BRACKET_OPEN SQUARE_BRACKET_CLOSE

%type <integer_value> INTEGER_TERM 
%type <float_value> FLOAT_TERM EXPRESSION
%type <string_value> LINE

%left ADD SUBTRACT BRACKET_OPEN BRACKET_CLOSE
%left DIVIDE MULTIPLY MODULO
%%

LINE : ASSIGNMENT EOL {;}
     | PRINT EXPRESSION EOL {printf("%g\n", $2);}
     | PRINT STRING_LITERAL EOL {printf("%s\n", $2);}
     | PRINT CHAR_LITERAL EOL {printf("%c\n", $2);}
     | EXIT_PROGRAM EOL {exit(0);}

     | LINE ASSIGNMENT EOL {;}
     | LINE PRINT EXPRESSION EOL {printf("%g\n", $3);}
     | LINE PRINT STRING_LITERAL EOL {printf("%s\n", $3);}
     | LINE PRINT CHAR_LITERAL EOL {printf("%c\n", $3);}
     | LINE EXIT_PROGRAM EOL {exit(0);}
     ;


ASSIGNMENT : IDENTIFIER ASIGN EXPRESSION {printf("MAKING VAR: %s = %g\n", $1, $3);}

EXPRESSION : INTEGER_TERM {$$ = $1;}
           | FLOAT_TERM {$$ = $1;}

           | EXPRESSION DIVIDE EXPRESSION  {$$ = $1 / (double) $3;}
           | EXPRESSION MULTIPLY EXPRESSION {$$ = $1 * (double) $3;}
           | EXPRESSION ADD EXPRESSION {$$ = $1 + $3;}
           | EXPRESSION SUBTRACT EXPRESSION {$$ = $1 - $3;}

           | EXPRESSION ADD EXPRESSION {$$ = $1 + $3;}
           | EXPRESSION SUBTRACT EXPRESSION {$$ = $1 - $3;}
           | EXPRESSION MULTIPLY EXPRESSION{$$ = $1 * $3;}
           | EXPRESSION DIVIDE EXPRESSION {$$ = $1 / $3;}
           
           | BRACKET_OPEN EXPRESSION BRACKET_CLOSE {$$ = $2;}
           ;


INTEGER_TERM : INTEGER_LITERAL {$$ = $1;}
FLOAT_TERM : FLOAT_LITERAL {$$ = $1;}
%%

void yyerror (char *s) 
{
    fprintf(stderr,"\n%s (line %i):\n    %s\nerrors be like :moyai:\n\n", s, yylineno, yytext);
}