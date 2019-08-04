calculator: calc1.l calc1.y
			bison -d calc1.y
			flex calc1.l
			cc -o $@ calc1.tab.c lex.yy.c -lfl
