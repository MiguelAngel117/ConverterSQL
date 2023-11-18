/** Seccion de definiciones**/
%{
#include "syntactic.tab.h"
void yyerror(char *);
%}

%option noyywrap

%%

[ \t\n]+             { /* Ignorar espacios en blanco */ }

"Seleccionar"        { return SELECT; }
"todos"              { return ALL; }
"los"                { return THE; }
"empleados"          { return EMPLOYEES; }

.                    { /* Caracteres no reconocidos */ }

%%