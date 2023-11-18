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
}
%token <str> FIELD
%token NEWLINE SELECT ALL THE INSERT INTO UPDATE DELETE WHERE SET VALUE EQUAL FROM


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

select: SELECT ALL THE FIELD { fprintf(yyout, "SELECT * FROM %s;\n", $4); }

insert: INSERT INTO FIELD VALUE { fprintf(yyout, "INSERT INTO %s VALUES ();\n", $3);}

delete: DELETE FROM FIELD WHERE { fprintf(yyout, "DELETE FROM %s WHERE id = 5;\n", $3); }

update: UPDATE FIELD SET { fprintf(yyout, "UPDATE %s SET nombre = 'Juan';\n", $2); }

condition: SELECT

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
