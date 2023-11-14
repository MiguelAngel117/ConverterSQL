//sh ./Run.x
rm syntactic.tab.* lex.yy.c Vick.exe

bison -d syntactic.y
flex lexical.l
gcc syntactic.tab.c lex.yy.c -lfl -o Vick.exe

./Vick.exe  Prueba.x