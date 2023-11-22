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
[Mm]asculino         { return MALE; }
[Ff]emenino          { return FEMALE; }
[Ss]eleccionar       { return SELECT; }
[Aa]                 { return TO; }
[Ss]elecciona        { return SELECT; }
[Ss]eleccione        { return SELECT; }
[Tt]odos             { return ALL; }
[Ll]os               { return FROM; }
[Dd]e                { return FROM; }
[Ee]l                { return THE; }
[Cc]on               { return WITH; }
[Ii]nsertar          { return INSERT; }
[Ee]n                { return INTO; }
[Aa]ctualizar        { return UPDATE; }
[Ee]liminar          { return DELETE; }
[Dd]onde             { return WHERE; }
[Ee]stablecer        { return SET; }
[Vv]alor             { return VALUE; }
[Ss]ea[ \t]igual     { return EQUAL; }
[Ii]gual             { return EQUAL; }
[Dd]iferente         { return DIFERENT; }
[Mm]ayor[ \t]+o[ \t]+igual        { return MAYEQUAL; }
[Uu]nir              { return JOIN; }
[Aa]grupar[ \t]+por  { return GROUP_BY; }
[Oo]rdenar[ \t]+por  { return ORDER_BY; }
\"[^\"]+\"           { yylval.str = strdup(yytext); return STRING; }
{float}              { yylval.flo = atof(yytext); return FLOAT; }
{number}             { yylval.num = atoi(yytext); return NUMBER; }
{field}              { yylval.str = strdup(yytext); return FIELD; }
{table}              { yylval.str = strdup(yytext); return TABLE; }
[ \t]+               { /* Ignorar espacios en blanco */ }
.                    { /* Caracteres no reconocidos */ }

%%
int yywrap(){return 1;}
