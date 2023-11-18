%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex();

extern FILE *yyin, *yyout;
%}

%token NEWLINE SELECT ALL THE EMPLOYEES INSERT INTO UPDATE DELETE WHERE SET VALUE EQUAL FROM

%%

input:  line
        | input line

line:   query
        | query NEWLINE
        | error NEWLINE { yyerror("Error en la entrada"); yyclearin; }

query:
    SELECT ALL THE EMPLOYEES { fprintf(yyout, "SELECT * FROM empleados;\n"); }
  | INSERT INTO EMPLOYEES VALUE { fprintf(yyout, "INSERT INTO empleados VALUES ();\n"); }
  | UPDATE EMPLOYEES SET { fprintf(yyout, "UPDATE empleados SET nombre = 'Juan';\n"); }
  | DELETE FROM EMPLOYEES WHERE { fprintf(yyout, "DELETE FROM empleados WHERE id = 5;\n"); }
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

    yyin = entrada;
    yyout = salida;

    yyparse();  // Inicia el análisis sintáctico

    fclose(entrada);
    fclose(salida);
    return 0;
}
