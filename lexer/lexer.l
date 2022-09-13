%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
":moyai:"                                                     {return EOL;}
"dontbegreedy"                                                {return EXIT_PROGRAM;}

"iwant69"                                                     {return INTEGER_VAR;}
"sussysentence"                                               {return STRING_VAR;}
"imaginefloat"                                                {return FLOAT_VAR;}
"sussyletter"                                                 {return CHAR_VAR;}


"belikemoyai"                                                 {return PRINT;}

[a-zA-Z_$][a-zA-Z_0-9]*                                       {
                                                                yylval.string_value = strtok(yytext, " ");
                                                                return IDENTIFIER;
                                                              }

[-+]?[0-9]*                                                   {yylval.integer_value = atoi(yytext); return INTEGER_LITERAL;}
[0-9]+[\.][0-9]+                                              {yylval.float_value = atof(yytext); return FLOAT_LITERAL;}
[\'][a-zA-Z][\']                                              {yylval.char_value = yytext[1]; return CHAR_LITERAL;}
["]([^"\\\n]|\\(.|\n))*["]                                    {
                                                                char* value = strdup(yytext);
                                                                value++;
                                                                value[strlen(value)-1] = 0;
                                                                yylval.string_value = value;
                                                                return STRING_LITERAL;
                                                              }

"("                                                           {return BRACKET_OPEN;}
")"                                                           {return BRACKET_CLOSE;}
"{"                                                           {return CURLY_BRACE_OPEN;}
"}"                                                           {return CURLY_BRACE_CLOSE;}
"["                                                           {return SQUARE_BRACKET_OPEN;}
"]"                                                           {return SQUARE_BRACKET_CLOSE;}

(\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/)|(\/\/.*)        yylineno++;;
{newline}                                                     {yylineno++;}
{whitespace}                                                  ;
.                                                             {invalid_token();};
%%

int yywrap(void) {
  return 1;
}

void invalid_token() {
  fprintf(stderr, "\nInvalid Character (line %i):\n    %s\ntoken parsing error be like :moyai:\n\n", yylineno, yytext);
  exit(0);
}
