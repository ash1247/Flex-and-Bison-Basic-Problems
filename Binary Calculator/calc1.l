    /* calculator #1 */
%{
    #include "calc1.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[0-1]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[-+\n]      { return *yytext; }

[ \t]       ;       /* skip whitespace */

.           yyerror("Unknown character encountered ");

%%

int yywrap(void) {
    return 1;
}


