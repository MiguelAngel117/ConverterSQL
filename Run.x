rm syntactic.tab.* lex.yy.c SQL.exe

bison -d syntactic.y
flex lexical.l
gcc syntactic.tab.c lex.yy.c -lfl -o SQL.exe

./SQL.exe  Texto.txt Query.sql

python3 main.py

http://127.0.0.1:5000/ejecutar_consultas