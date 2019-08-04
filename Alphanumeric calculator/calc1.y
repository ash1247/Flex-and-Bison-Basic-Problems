%{
    #include <stdio.h>
    #include <ctype.h>
    extern char *yytext;
    int yylex(void);
    void yyerror(char *s);
    int capital = 0;
    char array[27] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
                            'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                            'Y', 'Z' };

    char alphanumeric_calculation(char input, int capital, int value) {
        int result = 0;
        int ans = 0;
        int i = 0;
        for(i = 0; i < 27; i++) {
            if(toupper(input) == array[i]) {
                result = i;
                break;
            }
        }
        ans = (result + value) % 26;
        return capital == 1 ? array[ans] : tolower(array[ans]);
}
        
%}

%union {
  int i;
  char c;
}
%token<i> INTEGER
%token<c> CAPITAL SMALLER

%%

program: program expr '\n'         { printf("=> %c\n", $<c>2); }
        | 
        ;

expr: INTEGER 
    | letter 
	| expr '+' INTEGER { char ans = alphanumeric_calculation($<c>1, capital, $<i>3);
                         $<c>$ = ans; }
	;

letter: CAPITAL { capital = 1; }
    | SMALLER { capital = 0; }
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n %s\n", s, yytext);
}

int main(void) {
    yyparse();
    return 0;
}
