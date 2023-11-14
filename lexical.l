/** Seccion de definiciones**/
%{
#include "syntactic.tab.h"
%}

identiVar [a-z]+[0-9]+
float -?[0-9]+\.[0-9]*
int -?[0-9]+ 
string \"[^(\n|\")]*\"
param \(("var v"[0-9]+" "?)*\)
argumento \[("[0-9]+"?)*\]
/** Seccion de reglas**/
%%
\;                              {return PYC;}
"var"                           {return VAR;}
"funcion"                       {return FUN;}
{identiVar}                     {yylval.sval = strdup(yytext); return IVR;}
{string}                        {yylval.sval = strdup(yytext); return STR;}
{float}                         {yylval.fval = atof(yytext); return FLO;}
{int}                           {yylval.ival = atoi(yytext); return INT;}
=                               {return IGU;}
\+                              {return MAS;}
\*                              {return MUL;}
\-                              {return RES;}
\/                              {return DIV;}
"<"                             {return MEN;}
"<="                            {return MEI;}
">"                             {return MAY;}
">="                            {return MAI;}
"=="                            {return EQU;}
"/="                            {return DIF;}
"sii"                           {return SII;}
"("                             {return PIZ;}
")"                             {return PDE;}
"fin"                           {return FIN;}
"no"                            {return NOO;}
"mientras"                      {return HAS;}
{param}                         {return PAR;}
{argumento}                     {return ARG;}
"retorno"                       {return RTN;}
"intentar"                      {return ITR;}
"funcEnd"                       {return FUE;}
"atrapar"                       {return ATP;}
"imprimir"                      {return PRINT;}
[ \t\n]                         {/* ignorar espacios */}
.                               {printf("Error léxico: %s\n", yytext);}
%%
/**Seccion de codigo de usuario**/
int yywrap(){return 1;}