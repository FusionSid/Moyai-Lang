#include <stdio.h>
#include <stdlib.h>

void add_line(char *line)
{
    FILE *fptr;
    fptr = fopen("out.c", "a");
    fprintf(fptr, "%s", line);
    fclose(fptr);
}
