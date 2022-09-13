/*
Run interpreter (or compiler when I make it):
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// external things ill need
extern int yyparse();
extern int yylineno;
extern char *yytext;
extern FILE *yyin;

// Main method be like :moyai:
int main(int argc, char *argv[])
{
    // Check if they provided filename, if they didnt FUCK em
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

    // Parse
    yyparse();

    // CLOSE FILE
    fclose(yyin);
    return 0;
}