%option noyywrap

%{
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int cnt=0;

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

int deci(char *s)
{
	int n=strlen(s);
	char c[1000]="";
	int i;
	for( i=0; i<n; i++){
		if(s[i]=='1' || s[i]=='l'){
			strcat(c,"1");
		}
		else if(s[i]=='0' || s[i]=='O'){
			strcat(c,"0");
		}
	}
	int x=atoi(c);
	int y=BaseConversion(x,2,10);
	return y;
}

%}



%%

b*[01Ol]+   {   cnt++;
				int x=deci(yytext);
			    printf( "Found %s (Decimal value = %d)\n", yytext,x);
			}     

[\n]      	{ 	printf("Total %d\n",cnt);
				cnt=0; 
		   	}
.           

%%
          
int main( int argc, char **argv )
{
	++argv, --argc;  /* skip over program name */
	if ( argc > 0 )
	yyin = fopen( argv[0], "r" );
	else
	yyin = stdin;
   
	yylex();
}

