%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "transpiler/convert_to_c.h"

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

%token <string_value> STRING_LITERAL IDENTIFIER
%token <char_value> CHAR_LITERAL
%token <integer_value> INTEGER_LITERAL 
%token <float_value> FLOAT_LITERAL 

%token <string_value> INTEGER_VAR FLOAT_VAR STRING_VAR CHAR_VAR

%token <char_value> ASIGN EOL

%token <char_value> CURLY_BRACE_OPEN CURLY_BRACE_CLOSE SQUARE_BRACKET_OPEN SQUARE_BRACKET_CLOSE

%type <string_value> VARIABLE_NAME
%type <integer_value> INTEGER_TERM 
%type <float_value> FLOAT_TERM EXPRESSION
%type <string_value> LINE

%left ADD SUBTRACT BRACKET_OPEN BRACKET_CLOSE
%left DIVIDE MULTIPLY MODULO
%%

LINE : ASSIGNMENT EOL {;}
     | PRINT EXPRESSION EOL {
                                char line[100]; 
                                sprintf(line, "printf(\"%g\\n\");\n", $2);
                                add_line(line);
                                printf("%g\n", $2);
                            }
     | PRINT STRING_LITERAL EOL {
                                    char line[(10 + strlen($2))]; 
                                    sprintf(line, "printf(\"%s\\n\");\n", $2);
                                    add_line(line);
                                    printf("%s\n", $2);
                                }
     | PRINT CHAR_LITERAL EOL {
                                char line[25]; 
                                sprintf(line, "printf(\"%c\\n\");\n", $2);
                                add_line(line);
                                printf("%c\n", $2);
                            }
     | EXIT_PROGRAM INTEGER_LITERAL EOL {
                                            char line[25]; 
                                            sprintf(line, "\nexit(%i);\n", $2);
                                            add_line(line);
                                        }

     | LINE ASSIGNMENT EOL {;}
     | LINE PRINT EXPRESSION EOL {
                                char line[100]; 
                                sprintf(line, "printf(\"%g\\n\");\n", $3);
                                add_line(line);
                                printf("%g\n", $3);
                            }
     | LINE PRINT STRING_LITERAL EOL {
                                    char line[(10 + strlen($3))]; 
                                    sprintf(line, "printf(\"%s\\n\");\n", $3);
                                    add_line(line);
                                    printf("%s\n", $3);
                                }
     | LINE PRINT CHAR_LITERAL EOL  {
                                char line[25]; 
                                sprintf(line, "printf(\"%c\\n\");\n", $3);
                                add_line(line);
                                printf("%c\n", $3);
                            }
     | LINE EXIT_PROGRAM INTEGER_LITERAL EOL {
                            char line[25]; 
                            sprintf(line, "\nexit(%i);\n", $3);
                            add_line(line);
                        }
     ;


ASSIGNMENT : INTEGER_VAR VARIABLE_NAME ASIGN EXPRESSION {
                                                            char *data_type = "INTEGER";
                                                            char *variable_name = strtok($2, " ");
                                                            int variable_value = $4;

                                                            char line[(25 + strlen(variable_name))]; 
                                                            sprintf(line, "int %s = %i;\n", variable_name, variable_value);
                                                            add_line(line);
                                                            printf("%s(%s = %i)\n", data_type, variable_name, variable_value);
                                                    }
           | FLOAT_VAR VARIABLE_NAME ASIGN EXPRESSION {
                                                        char *data_type = "FLOAT";
                                                        char *variable_name = strtok($2, " ");
                                                        double variable_value = $4;

                                                        char line[(75 + strlen(variable_name))]; 
                                                        sprintf(line, "double %s = %g;\n", variable_name, variable_value);
                                                        add_line(line);
                                                        printf("%s(%s = %g)\n", data_type, variable_name, variable_value);
                                                    }
           | STRING_VAR VARIABLE_NAME ASIGN STRING_LITERAL {
                                                            char *data_type = "STRING";
                                                            char *variable_name = strtok($2, " ");
                                                            char *variable_value = $4;

                                                            char line[(25 + strlen(variable_name) + strlen(variable_value))]; 
                                                            sprintf(line, "char %s[] = \"%s\";\n", variable_name, variable_value);
                                                            add_line(line);
                                                            printf("%s(%s = %s)\n", data_type, variable_name, variable_value);
                                                        }
           | CHAR_VAR VARIABLE_NAME ASIGN CHAR_LITERAL {
                                                        char *data_type = "CHAR";
                                                        char *variable_name = strtok($2, " ");
                                                        char variable_value = $4;

                                                        char line[(30 + strlen(variable_name))]; 
                                                        sprintf(line, "char %s = '%c';\n", variable_name, variable_value);
                                                        add_line(line);
                                                        printf("%s(%s = %c)\n", data_type, variable_name, variable_value);
                                                    }

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


VARIABLE_NAME : IDENTIFIER {$$ = $1;}
INTEGER_TERM : INTEGER_LITERAL {$$ = $1;}
FLOAT_TERM : FLOAT_LITERAL {$$ = $1;}
%%

void yyerror (char *s) 
{
    fprintf(stderr,"\n%s (line %i):\n    %s\nerrors be like :moyai:\n\n", s, yylineno, yytext);
}