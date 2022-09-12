%{
#include "lexer/tokens.h"

void invalid_token();
%}

newline \n
whitespace [ \t:]

%% 
"+"                                                           {return ADD;}
"-"                                                           {return SUBTRACT;}
"/"                                                           {return DIVIDE;}
"*"                                                           {return MULTIPLY;}
"%"                                                           {return MODULO;}
"="                                                           {return ASIGN;}

^[a-zA-Z_$][a-zA-Z_0-9]*                                      {return IDENTIFIER;}

[-+]?[0-9]*                                                   {return INTEGER_LITERAL;}
[0-9]+[\.][0-9]+                                              {return FLOAT_LITERAL;}
[\'][a-zA-Z][\']                                              {return CHAR_LITERAL;}
["]([^"\\\n]|\\(.|\n))*["]                                    {return STRING_LITERAL;}

"("                                                           {return BRACKET_OPEN;}
")"                                                           {return BRACKET_CLOSE;}
"{"                                                           {return CURLY_BRACE_OPEN;}
"}"                                                           {return CURLY_BRACE_CLOSE;}
"["                                                           {return SQUARE_BRACKET_OPEN;}
"]"                                                           {return SQUARE_BRACKET_CLOSE;}

(\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/)|(\/\/.*)        ;
{newline}                                                     {yylineno++;}
{whitespace}                                                  ;
.                                                             {invalid_token();};
%%

int yywrap(void) {
  return 1;
}

void invalid_token() {
  printf("\nInvalid Character (line %i):\n    %s\ntoken parsing error be like :moyai:\n\n", yylineno, yytext);
  exit(0);
}