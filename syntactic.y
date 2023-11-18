%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex();

extern FILE *yyin, *yyout;  // Declara yyin y yyout como externos
%}

%token SELECT ALL THE EMPLOYEES

%%

query:
    SELECT ALL THE EMPLOYEES { fprintf(yyout, "SELECT * FROM empleados;\n"); }
    ;

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

    yyin = entrada;  // Asigna el archivo de entrada a yyin
    yyout = salida;  // Asigna el archivo de salida a yyout

    yyparse();  // Inicia el análisis sintáctico

    fclose(entrada);
    fclose(salida);
    return 0;
}
