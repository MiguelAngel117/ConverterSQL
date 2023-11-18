/** Sección de definiciones **/
%{
#include "syntactic.tab.h"
void yyerror(char *);
%}

%%

[ \t]+               { /* Ignorar espacios en blanco */ }
\n                   { return NEWLINE; }
"Seleccionar"        { return SELECT; }
"Selecciona"         { return SELECT; }
"todos"              { return ALL; }
"los"                { return THE; }
"de"                 { return FROM; }
"empleados"          { return EMPLOYEES; }
"Insertar"           { return INSERT; }
"en"                 { return INTO; }
"Actualizar"         { return UPDATE; }
"Eliminar"           { return DELETE; }
"donde"              { return WHERE; }
"establecer"         { return SET; }
"valor"              { return VALUE; }
"igual"              { return EQUAL; }
.                    { /* Caracteres no reconocidos */ }

%%
int yywrap(){return 1;}
