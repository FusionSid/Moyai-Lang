#include "table.h"

struct SymbolTable {
    char *data_type;
    char *value;
    char *type;
    int line_no;
};

int counter = 0;
struct SymbolTable symbol_table[69];

void insert_into_table(char *data_type, char *value, char *type, int line_no)
{
    symbol_table[counter].data_type = data_type;
    symbol_table[counter].value = value;
    symbol_table[counter].type = type;
    symbol_table[counter].line_no = line_no;
    
    counter++;
}