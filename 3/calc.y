%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex();
%}

/* Define token types */
%union {
    double dval;  /* Store all values as double */
}

%token <dval> NUMBER
%token LOG10 LOG LOG2 ABS
%left '(' ')'
%right '-'  /* Fix: Allow unary minus */

%type <dval> expression

%%

equation:
    expression '\n' { printf("Result: %lf\n", $1); }
;

expression:
    LOG10 '(' expression ')' { 
        if ($3 <= 0) {
            yyerror("log10 undefined for non-positive values");
            $$ = 0;
        } else {
            $$ = log10($3);
        }
    }
  | LOG '(' expression ')' { 
        if ($3 <= 0) {
            yyerror("log undefined for non-positive values");
            $$ = 0;
        } else {
            $$ = log($3);
        }
    }
  | LOG2 '(' expression ')' { 
        if ($3 <= 0) {
            yyerror("log2 undefined for non-positive values");
            $$ = 0;
        } else {
            $$ = log2($3);
        }
    }
  | ABS '(' expression ')' { $$ = fabs($3); }
  | '(' expression ')' { $$ = $2; }
  | '-' expression %prec '-' { $$ = -$2; }  /* Fix: Allow negative numbers */
  | NUMBER { $$ = $1; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an expression:\n");
    yyparse();
    return 0;
}
