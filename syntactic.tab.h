/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SYNTACTIC_TAB_H_INCLUDED
# define YY_YY_SYNTACTIC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    FIELD = 258,                   /* FIELD  */
    TABLE = 259,                   /* TABLE  */
    STRING = 260,                  /* STRING  */
    FLOAT = 261,                   /* FLOAT  */
    NUMBER = 262,                  /* NUMBER  */
    NEWLINE = 263,                 /* NEWLINE  */
    SELECT = 264,                  /* SELECT  */
    ALL = 265,                     /* ALL  */
    INSERT = 266,                  /* INSERT  */
    INTO = 267,                    /* INTO  */
    UPDATE = 268,                  /* UPDATE  */
    DELETE = 269,                  /* DELETE  */
    WHERE = 270,                   /* WHERE  */
    SET = 271,                     /* SET  */
    VALUE = 272,                   /* VALUE  */
    EQUAL = 273,                   /* EQUAL  */
    FROM = 274,                    /* FROM  */
    THE = 275,                     /* THE  */
    JOIN = 276,                    /* JOIN  */
    ORDER_BY = 277,                /* ORDER_BY  */
    GROUP_BY = 278,                /* GROUP_BY  */
    DIFERENT = 279,                /* DIFERENT  */
    MAYEQUAL = 280,                /* MAYEQUAL  */
    TO = 281,                      /* TO  */
    WITH = 282,                    /* WITH  */
    MALE = 283,                    /* MALE  */
    FEMALE = 284,                  /* FEMALE  */
    ASC = 285,                     /* ASC  */
    DESC = 286,                    /* DESC  */
    AND = 287,                     /* AND  */
    OR = 288,                      /* OR  */
    TAB = 289,                     /* TAB  */
    FOR = 290,                     /* FOR  */
    PLACE = 291,                   /* PLACE  */
    SHOW = 292,                    /* SHOW  */
    DIST = 293,                    /* DIST  */
    THAT = 294                     /* THAT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "syntactic.y"

    char* str;
    int num;
    float flo;

#line 109 "syntactic.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNTACTIC_TAB_H_INCLUDED  */
