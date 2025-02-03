%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h> // Needed for atof
%}

DIGIT   [0-9]
ID      [a-zA-Z][a-zA-Z0-9]*

%%
{DIGIT}+                { printf("An integer: %s (%d)\n", yytext, atoi(yytext)); }
{DIGIT}+"."{DIGIT}+     { printf("A float: %s (%g)\n", yytext, atof(yytext)); }
int|main|return|if|then|begin|end|procedure|function { printf("A keyword: %s\n", yytext); }
{ID}                    { printf("An identifier: %s\n", yytext); }
"+"|"-"|"*"|"/"         { printf("An operator: %s\n", yytext); }
"//".*                  { /* Eat up one-line comments */ }
[ \t\n]+                { /* Eat up whitespace */ }
.                       { printf("Unrecognized character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    FILE *fp;
    char filename[50];

    printf("Enter the filename: \n");
    scanf("%s", filename);

    fp = fopen(filename, "r");
    if (!fp) {
        perror("Error opening file");
        return 1;
    }

    yyin = fp;
    yylex();

    fclose(fp);
    return 0;
}
