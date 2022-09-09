%{
#include "lexer/lexer.h"
%}

%% 
"+" return ADD;
"-" return SUBTRACT;
"/" return DIVIDE;
"*" return MULTIPLY;
"=" return ASIGN;
^[a-zA-Z_$][a-zA-Z_0-9]* return IDENTIFIER;
[-+]?[0-9]* return INTEGER;
[0-9]+[\.][0-9]+ return FLOAT;
(["]([^"\\\n]|\\(.|\n))*["])|([']([^'\\\n]|\\(.|\n))*[']) return STRING;
[ \t\n] ;
. return INVALID;
%%

int yywrap(void)
{
  return 1;
}
