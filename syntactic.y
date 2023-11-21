%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
int yylex();

extern FILE *yyin, *yyout;
%}

%union {
    char* str;
    int num;
    float flo;
}
%token <str> FIELD TABLE STRING
%token <flo> FLOAT
%token <num> NUMBER
%token NEWLINE SELECT ALL INSERT INTO UPDATE DELETE WHERE SET VALUE EQUAL FROM THE JOIN ORDER_BY GROUP_BY


/** Sección de reglas**/
%%

input:  line
        | input line

line:   query
        | query NEWLINE
        | error NEWLINE { yyerror("Error en la entrada"); yyclearin; }

query: select
       | insert
       | update
       | delete
       | join
       | order_by
       | 

select: SELECT ALL FROM TABLE { fprintf(yyout, "SELECT * FROM %s;\n", $4); }
      | SELECT ALL FROM FIELD WHERE THE FIELD { fprintf(yyout, "SELECT * FROM %s WHERE %s = 1;\n", $4, $7); }
      | SELECT ALL FROM TABLE join order_by group_by
      | SELECT FIELD FROM TABLE WHERE

insert: INSERT INTO FIELD VALUE FIELD{ fprintf(yyout, "INSERT INTO %s VALUES ('%s');\n", $3, $5);}

delete: DELETE FROM FIELD WHERE { fprintf(yyout, "DELETE FROM %s WHERE id = 5;\n", $3); }

update: UPDATE FIELD SET { fprintf(yyout, "UPDATE %s SET nombre = 'Juan';\n", $2); }

join: JOIN TABLE { fprintf(yyout, " JOIN %s", $2); }

order_by: ORDER_BY FIELD { fprintf(yyout, " ORDER BY %s", $2); }

group_by: GROUP_BY FIELD { fprintf(yyout, " GROUP BY %s", $2); }

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Uso: %s archivo_entrada archivo_salida\n", argv[0]);
        return 1;
    }

    FILE *entrada = fopen(argv[1], "r");
    FILE *salida = fopen(argv[2], "w");

    if (!entrada) {
        fprintf(stderr, "No se pudo abrir el archivo de entrada\n");
        return 1;
    }

    if (!salida) {
        fprintf(stderr, "No se pudo abrir el archivo de salida\n");
        fclose(entrada);
        return 1;
    }

    yyin = entrada;
    yyout = salida;

    yyparse();  // Inicia el análisis sintáctico

    fclose(entrada);
    fclose(salida);
    return 0;
}
