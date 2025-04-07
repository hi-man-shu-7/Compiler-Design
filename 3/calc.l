
%{
#include "calc.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%

[0-9]+(\.[0-9]+)?  { yylval.dval = atof(yytext); return NUMBER; }
"log10"            { return LOG10; }
"log"              { return LOG; }
"log2"             { return LOG2; }
"abs"              { return ABS; }
"("                { return '('; }
")"                { return ')'; }
"-"                { return '-'; }  /* Fix: Allow '-' to be recognized properly */
[ \t]              { /* Ignore whitespace */ }
\n                 { return '\n'; }
.                  { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
