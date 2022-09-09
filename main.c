#include <stdio.h>
#include <string.h>
#include "lexer/lexer.h"

// some lex stuff
extern int yylex();
extern int yylineno;
extern char *yytext;
extern FILE *yyin;

// the tokens be like :moyai:
char *tokens[] = {NULL, "INTEGER", "STRING", "FLOAT", "IDENTIFIER", "ASIGN", "ADD", "SUBTRACT", "MULTIPLY", "DIVIDE", "INVALID", "MODULO"};

// Main method be like :moyai:
int main(int argc, char *argv[])
{
    // Check if they provided filename
    if (argv[1] == NULL)
    {
        printf("you must provide filename\n");
        return 1;
    }

    // open file
    yyin = fopen(argv[1], "r");

    // If file = null it means it doesnt exist bruhh
    if (yyin == NULL)
    {
        printf("File %s not found!\n(Skill issue get good at typing)\n", argv[1]);
        return 1;
    }

    // if you have a variable name bigger than 69 GO FUCK YOURSELF
    char variable_name[69];

    // Declare name and value token
    // Value token is like a backup thing where i go a couple tokens into the future with
    int name_token, value_token;

    // Get first token
    name_token = yylex();

    // Keep going till no more tokens (or error)
    while (name_token)
    {
        // token with the value of 10 is you guessed it - INVALID. So if you get an error thats a #moyai_moment ngl
        if (name_token == INVALID)
        {
            // error
            printf("\nInvalid Character (line %i):\n    %s\nsyntax error be like :moyai:\n\n", yylineno, yytext);
            fclose(yyin);
            return 1;
        }

        // switch the token
        switch (name_token)
        {
        // If the token is an IDENTIFIER which means if it is a variable name
        case IDENTIFIER:
            // copy variable name into the variable_name var
            strcpy(variable_name, yytext);

            // Get the nex token WHICH SHOULD BE AN EQUALS SIGN
            value_token = yylex();
            // Check if token after variable name is an = sign if not BAD
            if (value_token != ASIGN)
            {
                printf("\nSyntax Error (line %i):\n    Expected asignment operator ('=') after variable name ('%s') but got '%s' instead.\nsyntax error be like :moyai:\n\n", yylineno, variable_name, yytext);
                fclose(yyin);
                return 1;
            }
            // go to the next token which will be the value and set the var to that
            value_token = yylex();

            // No vars yet so just print
            printf("Variable Created!\t%s has been set to %s with type of %s\n", variable_name, yytext, tokens[value_token]);
            break;
        }
        printf("%s\t%s\n", yytext, tokens[name_token]);

        // Get next token
        name_token = yylex();
    }
    // Close the file once we done
    fclose(yyin);
    return 0;
}
