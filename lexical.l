/** Seccion de definiciones**/
%{
#include "syntactic.tab.h"
void yyerror(char *);
%}

%%

[ \t\n]+             { /* Ignorar espacios en blanco */ }
"Seleccionar"        { return SELECT; }
"Selecciona"         { return SELECT; }
"todos"              { return ALL; }
"los"                { return THE; }
"empleados"          { return EMPLOYEES; }
.                    { /* Caracteres no reconocidos */ }

%%
int yywrap(){return 1;}