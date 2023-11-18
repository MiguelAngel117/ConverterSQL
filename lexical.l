/** Sección de definiciones **/
%{
#include "syntactic.tab.h"
void yyerror(char *);
%}
field [a-zA-Z]+
%%

\n                   { return NEWLINE; }
"Seleccionar"        { return SELECT; }
"Selecciona"         { return SELECT; }
"todos"              { return ALL; }
"los"                { return THE; }
"de"                 { return FROM; }
"Insertar"           { return INSERT; }
"en"                 { return INTO; }
"Actualizar"         { return UPDATE; }
"Eliminar"           { return DELETE; }
"donde"              { return WHERE; }
"establecer"         { return SET; }
"valor"              { return VALUE; }
"igual"              { return EQUAL; }
{field}              {yylval.str = strdup(yytext); return FIELD;}
[ \t]+               { /* Ignorar espacios en blanco */ }
.                    { /* Caracteres no reconocidos */ }

%%
int yywrap(){return 1;}
