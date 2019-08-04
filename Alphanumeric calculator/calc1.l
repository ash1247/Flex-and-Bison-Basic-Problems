%{
    #include "calc1.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[0-9]+  { yylval.i = atoi(yytext);
          return INTEGER;
        }
[A-Z]+  { yylval.c = yytext[0]; return CAPITAL; }
[a-z]+  { yylval.c = yytext[0]; return SMALLER; }
[+\n]   { return *yytext; }

[ \t]   ;       /* skip whitespace */

.       yyerror("Unknown character encountered");

%%

int yywrap(void) {
    return 1;
}


