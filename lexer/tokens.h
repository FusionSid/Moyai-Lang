#ifndef TOKENS_H
#define TOKENS_H

/*
 * Tokens be like :moyai:
 * Anyways this is just the file where i define what value the tokens are
 * So like INTEGER = 1 so if I get a value of 1 from yylex then i know its an int
 */

// Operators
#define ADD 1
#define SUBTRACT 2
#define DIVIDE 3
#define MULTIPLY 4
#define MODULO 5

// brackets
#define BRACKET_OPEN 6
#define BRACKET_CLOSE 7
#define CURLY_BRACE_OPEN 8
#define CURLY_BRACE_CLOSE 9
#define SQUARE_BRACKET_OPEN 10
#define SQUARE_BRACKET_CLOSE 11

// Variable stuff
#define ASIGN 12
#define IDENTIFIER 13

// Data types
#define INTEGER_LITERAL 14
#define FLOAT_LITERAL 15
#define STRING_LITERAL 16
#define CHAR_LITERAL 17

#endif