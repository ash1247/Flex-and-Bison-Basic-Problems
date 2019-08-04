%{
    #include <stdio.h>
    int yylex(void);
    void yyerror(char *);

int BaseConversion(int n, int pastBase, int futureBase)
{
    int Number = 0;
    int remainder, i = 1, step = 1;

    while (n!=0)
    {
        remainder = n%futureBase;
        n /= futureBase;
        Number += remainder*i;
        i *= pastBase;
    }
    return Number;
}
%}

%token INTEGER

%%

program:
        program expr '\n'         { printf("=> %d\n", $2); }
        | 
        ;

expr:
        INTEGER                   
        | expr '+' expr           { int x=BaseConversion($1 , 2,10); int y=BaseConversion($3,2,10); int z=x+y;
				    int k=BaseConversion(z,10,2); $$ = k; }
        | expr '-' expr           { int x=BaseConversion($1 , 2,10); int y=BaseConversion($3,2,10); int z=x-y;
				    int k=BaseConversion(z,10,2); $$ = k; }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
