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
%token DIFERENT MAYEQUAL TO WITH MALE FEMALE ASC DESC AND OR TAB FOR PLACE SHOW DIST THAT

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
       | group_by

select: SELECT ALL FROM FIELD { fprintf(yyout, "SELECT * FROM %s;\n", $4); }
      | SELECT FROM FIELD THAT FIELD DIST FROM FROM FIELD{ fprintf(yyout, "SELECT DISTINCT %s FROM %s;\n", $3, $9); }
      | SELECT ALL FROM FIELD WHERE THE FIELD EQUAL TO FIELD FIELD{ fprintf(yyout, "SELECT * FROM %s WHERE %s = '%s %s';\n", $4, $7, $10, $11); }
      | SELECT THE FIELD FROM FROM FIELD { fprintf(yyout, "SELECT %s FROM %s;\n", $3, $6); }
      | SELECT ALL FROM FIELD WHERE THE FIELD EQUAL TO NUMBER{ fprintf(yyout, "SELECT * FROM %s WHERE %s = %i;\n", $4, $7, $10); }
      | SELECT FIELD AND FIELD FROM FIELD ORDER_BY FIELD ASC { fprintf(yyout, "SELECT %s, %s FROM %s ORDER BY %s ASC;\n", $2, $4, $6, $8);}
      | SELECT FIELD AND FIELD FROM FIELD group_by

insert: INSERT INTO FIELD THE FIELD FIELD FIELD WITH FIELD MALE{ fprintf(yyout, "INSERT INTO %s (%s, %s) VALUES ('%s %s', 'M');\n", $3, $5, $9, $6, $7);}

delete: DELETE FROM FIELD WHERE FIELD EQUAL TO NUMBER{ fprintf(yyout, "DELETE FROM %s WHERE %s = %i;\n", $3, $5, $8); }
      | DELETE FROM FIELD WHERE FIELD EQUAL TO FIELD FIELD { fprintf(yyout, "DELETE FROM %s WHERE %s = '%s %s';\n", $3, $5, $8, $9); }
      | DELETE FROM FIELD WHERE FIELD EQUAL TO FIELD { fprintf(yyout, "DELETE FROM %s WHERE %s = '%s';\n", $3, $5, $8); }

update: UPDATE FROM FIELD SET THE FIELD TO FIELD FIELD WHERE THE FIELD EQUAL TO NUMBER{ fprintf(yyout, "UPDATE %s SET %s = '%s %s' WHERE %s = %i;\n", $3, $6, $8, $9, $12, $15); }

join: JOIN THE TAB FIELD AND THE TAB FIELD FOR FIELD { fprintf(yyout, "SELECT * FROM %s INNER JOIN %s WHERE %s.%s = %s.%s;", $4, $8, $4, $10, $8, $10); }

order_by : ORDER_BY ASC THE TAB FIELD FOR FIELD SHOW FROM PLACE FIELD AND FIELD { fprintf(yyout, "SELECT %s, %s FROM %s ORDER BY %s ASC;\n", $11, $13, $5, $7);}
         | ORDER_BY DESC THE TAB FIELD FOR FIELD SHOW FROM PLACE FIELD AND FIELD { fprintf(yyout, "SELECT %s, %s FROM %s ORDER BY %s DESC;\n", $11, $13, $5, $7);}

group_by: GROUP_BY FIELD { fprintf(yyout, "GROUP BY %s", $2); }

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
