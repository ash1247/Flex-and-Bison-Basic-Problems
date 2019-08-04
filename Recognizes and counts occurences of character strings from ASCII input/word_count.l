/* even more like Unix wc */
%option noyywrap
%{
int words = 0;

%}
%%

[a-zA-Z]+ { words++; 
	printf("Found %s\n", yytext); 

}
\n 	  { }
. 	  { }
%%
 int main( int argc, char **argv )

{
	if(argc > 1) {
		if(!(yyin = fopen(argv[1], "r"))) {
		perror(argv[1]);
		return (1);
		}
	}
	yylex();
	printf("Total %d\n",  words);
}

