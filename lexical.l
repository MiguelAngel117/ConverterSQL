/** Sección de definiciones **/
%{
#include "syntactic.tab.h"
void yyerror(char *);
%}
field [a-zA-Z]+
table [a-z]+(_[a-z]+)?
number -?[0-9]+
float -?[0-9]+\.[0-9]*
%%

\n                   { return NEWLINE; }
"Seleccionar"        { return SELECT; }
"Selecciona"         { return SELECT; }
"todos"              { return ALL; }
"los"                { return FROM; }
"de"                 { return FROM; }
"el"                 { return THE; }
"Insertar"           { return INSERT; }
"en"                 { return INTO; }
"Actualizar"         { return UPDATE; }
"Eliminar"           { return DELETE; }
"donde"              { return WHERE; }
"establecer"         { return SET; }
"valor"              { return VALUE; }
"igual"              { return EQUAL; }
{float}              { yylval.flo = atof(yytext); return FLOAT; }
{number}             { yylval.num = atoi(yytext); return NUMBER; }
{field}              { yylval.str = strdup(yytext); return FIELD; }
{table}              { yylval.str = strdup(yytext); return TABLE; }
[ \t]+               { /* Ignorar espacios en blanco */ }
.                    { /* Caracteres no reconocidos */ }

%%
int yywrap(){return 1;}
