/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "parser.y"

#include "global.h"
#define YYERROR_VERBOSE 1
#define JUMP -99
extern int yylineno;
Symtable SYMTABLE;
vector <int> id_vector; //sluzy do przypisywania typow przy deklaracji
vector <int> parameter_vector; //wektor parametrow procedury/funkcji
vector <int> func_result; //wektor parametrow procedury/funkcji
vector <int> parameter_memory; //wektor parametrow procedury/funkcji
Scope actual_scope = Scope::GLOBAL; //okresla w ktorej czesci gramatyki jestesmy
stringstream codeStream; //stringstream do wypisywania kodu
ofstream myfile;

int relop_true, relop_false = 0; //wpisuje do tablicy 0 i 1
int labCounter = 0; //zmienna do numerowania labeli


#line 89 "parser.cpp"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_PARSER_HPP_INCLUDED
# define YY_YY_PARSER_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_PROGRAM = 258,
    T_VAR = 259,
    T_BEGIN = 260,
    T_END = 261,
    T_WRITE = 262,
    T_READ = 263,
    T_ASSIGN = 264,
    T_PROCEDURE = 265,
    T_FUNCTION = 266,
    T_IF = 267,
    T_THEN = 268,
    T_ELSE = 269,
    T_RELOP = 270,
    T_WHILE = 271,
    T_DO = 272,
    T_NOT = 273,
    T_INTEGER = 274,
    T_REAL = 275,
    T_MULOP = 276,
    ID = 277,
    NUM = 278
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 20 "parser.y"

  int index; //indeks w tablicy symboli
  char operation; //arytmetyczne
  VarType variable_type; //typ zmiennych
  const char* relop; //relacyjne

#line 172 "parser.cpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   116

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  32
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  30
/* YYNRULES -- Number of rules.  */
#define YYNRULES  57
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  119

#define YYUNDEFTOK  2
#define YYMAXUTOK   278


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      26,    27,     2,    24,    30,    25,    29,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    31,    28,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    62,    62,    67,    77,    66,    92,    92,    94,    95,
      97,   124,   126,   128,   129,   142,   143,   145,   161,   178,
     196,   197,   199,   209,   228,   232,   233,   235,   236,   238,
     260,   268,   276,   278,   280,   284,   289,   293,   280,   303,
     309,   303,   328,   339,   339,   380,   385,   391,   402,   413,
     453,   459,   463,   463,   542,   559,   561,   583
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_PROGRAM", "T_VAR", "T_BEGIN", "T_END",
  "T_WRITE", "T_READ", "T_ASSIGN", "T_PROCEDURE", "T_FUNCTION", "T_IF",
  "T_THEN", "T_ELSE", "T_RELOP", "T_WHILE", "T_DO", "T_NOT", "T_INTEGER",
  "T_REAL", "T_MULOP", "ID", "NUM", "'+'", "'-'", "'('", "')'", "';'",
  "'.'", "','", "':'", "$accept", "standard_type", "type",
  "identifier_list", "expression", "statement", "compound_statement",
  "procedure_statement", "expression_list", "start", "program", "$@1",
  "$@2", "program_identifier_list", "declarations",
  "subprogram_declarations", "subprogram_declaration", "subprogram_head",
  "arguments", "parameter_list", "optional_statements", "statement_list",
  "@3", "@4", "@5", "@6", "@7", "@8", "$@9", "$@10", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,    43,    45,    40,    41,    59,    46,
      44,    58
};
# endif

#define YYPACT_NINF (-65)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      -1,     2,    17,   -65,     3,   -65,    27,   -65,    32,    59,
      66,   -65,   -65,    85,    68,   -65,   -65,   -17,    47,    69,
      58,    70,    71,    89,    67,   -65,   -65,   -65,   -65,   -65,
      72,    73,    73,     4,    74,   -65,    75,   -65,    68,    76,
      65,    79,    80,   -65,   -65,    -5,   -65,   -65,   -65,    91,
      81,   -65,   -65,    51,    56,   -65,    58,    43,    43,    43,
      43,    43,   -65,   -65,     4,    58,   -65,    68,    82,    43,
      86,   -65,    43,    43,    39,    40,    44,    26,    31,    39,
      43,   -65,   -65,    55,   -65,    83,   -65,    12,     7,    43,
      43,    43,    43,   -65,    43,   -65,   -65,   -65,    45,    58,
      43,   -65,   -65,    83,    12,    12,    39,     4,     4,   -65,
     -65,    46,   -65,   -65,   -65,    87,   -65,     4,   -65
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     2,     0,     1,     0,     6,     0,     0,
       0,    11,     7,     3,     0,    16,     8,     0,     4,     0,
       0,     0,     0,     0,     0,    11,     9,    13,    14,    12,
       0,    21,    21,    26,     0,    15,     0,    10,     0,     0,
       0,     0,     0,    34,    39,    42,    27,    33,    32,     0,
      25,     5,    17,     0,     0,    18,     0,     0,     0,     0,
       0,     0,    43,    24,     0,     0,    20,     0,     0,     0,
      54,    55,     0,     0,    45,     0,     0,     0,     0,    29,
       0,    28,    22,     0,    19,    57,    52,    50,     0,     0,
       0,     0,     0,    30,     0,    31,    35,    40,     0,     0,
       0,    51,    56,    49,    47,    48,    46,     0,     0,    44,
      23,     0,    36,    41,    53,     0,    37,     0,    38
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -65,    52,   -57,   -37,   -54,   -64,   -13,   -65,   -55,   -65,
     -65,   -65,   -65,   -65,    77,   -65,   -65,   -65,    84,   -65,
     -65,   -65,   -65,   -65,   -65,   -65,   -65,   -65,   -65,   -65
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    29,    30,    17,    74,    46,    47,    48,    75,     2,
       3,    15,    23,     8,    13,    18,    24,    25,    39,    54,
      49,    50,    59,   107,   115,   117,    60,   108,    80,   100
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      81,    53,     1,    76,    61,    77,    78,    79,    82,    33,
      34,    41,    42,    19,    20,    85,    43,     5,    87,    88,
      44,    62,    89,    52,     4,    98,    45,    89,    90,     6,
      83,    91,    92,    90,   101,   102,   103,   104,   105,    96,
     106,    89,   110,   112,   113,   111,    89,    90,    97,     7,
      91,    92,    90,   118,    89,    91,    92,    21,    22,     9,
      90,    69,    10,    91,    92,    70,    71,    93,    72,    73,
      94,    95,   109,   114,    94,    94,    94,    27,    28,    14,
      33,    19,    65,    66,    67,    19,    99,    11,    12,    14,
      16,    26,    31,    32,    33,    35,    56,    63,    89,    38,
      37,   116,    36,    51,    55,    57,    58,     0,    68,    64,
      84,     0,    86,     0,     0,     0,    40
};

static const yytype_int8 yycheck[] =
{
      64,    38,     3,    58,     9,    59,    60,    61,    65,     5,
      23,     7,     8,    30,    31,    69,    12,     0,    72,    73,
      16,    26,    15,    36,    22,    80,    22,    15,    21,    26,
      67,    24,    25,    21,    27,    89,    90,    91,    92,    13,
      94,    15,    99,   107,   108,   100,    15,    21,    17,    22,
      24,    25,    21,   117,    15,    24,    25,    10,    11,    27,
      21,    18,    30,    24,    25,    22,    23,    27,    25,    26,
      30,    27,    27,    27,    30,    30,    30,    19,    20,     4,
       5,    30,    31,    27,    28,    30,    31,    28,    22,     4,
      22,    22,    22,    22,     5,    28,    31,     6,    15,    26,
      28,    14,    25,    29,    28,    26,    26,    -1,    56,    28,
      28,    -1,    26,    -1,    -1,    -1,    32
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     3,    41,    42,    22,     0,    26,    22,    45,    27,
      30,    28,    22,    46,     4,    43,    22,    35,    47,    30,
      31,    10,    11,    44,    48,    49,    22,    19,    20,    33,
      34,    22,    22,     5,    38,    28,    46,    28,    26,    50,
      50,     7,     8,    12,    16,    22,    37,    38,    39,    52,
      53,    29,    38,    35,    51,    28,    31,    26,    26,    54,
      58,     9,    26,     6,    28,    31,    27,    28,    33,    18,
      22,    23,    25,    26,    36,    40,    40,    36,    36,    36,
      60,    37,    34,    35,    28,    36,    26,    36,    36,    15,
      21,    24,    25,    27,    30,    27,    13,    17,    40,    31,
      61,    27,    36,    36,    36,    36,    36,    55,    59,    27,
      34,    40,    37,    37,    27,    56,    14,    57,    37
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    32,    41,    43,    44,    42,    45,    45,    35,    35,
      46,    46,    34,    33,    33,    47,    47,    48,    49,    49,
      50,    50,    51,    51,    38,    52,    52,    53,    53,    37,
      37,    37,    37,    37,    54,    55,    56,    57,    37,    58,
      59,    37,    39,    60,    39,    40,    40,    36,    36,    36,
      36,    36,    61,    36,    36,    36,    36,    36
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     0,     0,    12,     1,     3,     1,     3,
       6,     0,     1,     1,     1,     3,     0,     3,     4,     6,
       3,     0,     3,     5,     3,     1,     0,     1,     3,     3,
       4,     4,     1,     1,     0,     0,     0,     0,    10,     0,
       0,     6,     1,     0,     5,     1,     3,     3,     3,     3,
       2,     3,     0,     5,     1,     1,     3,     2
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 62 "parser.y"
               {SYMTABLE.print_table(); 
                myfile.close();
                }
#line 1424 "parser.cpp"
    break;

  case 3:
#line 67 "parser.y"
                       {
                       myfile.open ("output.asm");
                       actual_scope = Scope::LOCAL; //scope dla funkcji i procedur
                       SYMTABLE.global_variables_memory = SYMTABLE.table;
                      //  cout << "\n\tjump.i #lab0" << endl;
                       myfile << "\tjump.i #lab0" << endl;
                       labCounter += 1; //kolejny label od 0
                       relop_false = SYMTABLE.insert_to_table("0", InputType::NUMBER, VarType::INTEGER);
                       relop_true = SYMTABLE.insert_to_table("1", InputType::NUMBER, VarType::INTEGER);
                       }
#line 1439 "parser.cpp"
    break;

  case 4:
#line 77 "parser.y"
                                {
                                actual_scope = Scope::GLOBAL; //po wyjsciu z subprogramow
                                //cout << "lab0:" << endl;
                                myfile << "lab0:" << endl;
                                SYMTABLE.refresh_symtable();
                                }
#line 1450 "parser.cpp"
    break;

  case 5:
#line 84 "parser.y"
            {
            // cout << codeStream.str();
            myfile << codeStream.str();
            codeStream.str("");
            //cout << "\texit\n\n\n" << endl;
            myfile << "\texit" << endl;
            }
#line 1462 "parser.cpp"
    break;

  case 8:
#line 94 "parser.y"
                    {id_vector.push_back((yyvsp[0].index));}
#line 1468 "parser.cpp"
    break;

  case 9:
#line 95 "parser.y"
                                        {id_vector.push_back((yyvsp[0].index));}
#line 1474 "parser.cpp"
    break;

  case 10:
#line 97 "parser.y"
                                                              {
                                                              for(int i=0; i< (int) id_vector.size(); i++)
                                                              {
                                                                //printf("%d , %d\n", id_vector[i], i);
                                                                SYMTABLE.table[id_vector[i]].vartype = (yyvsp[-1].variable_type);
                                                                SYMTABLE.table[id_vector[i]].scope = actual_scope;

                                                                if (actual_scope == Scope::GLOBAL)
                                                                {
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_address;
                                                                  if((yyvsp[-1].variable_type) == VarType::INTEGER)
                                                                    SYMTABLE.next_address += 4;
                                                                  if((yyvsp[-1].variable_type) == VarType::REAL)
                                                                    SYMTABLE.next_address += 8;
                                                                }
                                                                else //jest lokalne
                                                                {
                                                                  if((yyvsp[-1].variable_type) == VarType::INTEGER)
                                                                    {SYMTABLE.next_local_address -= 4;}
                                                                  if((yyvsp[-1].variable_type) == VarType::REAL)
                                                                    {SYMTABLE.next_local_address -= 8;}
                                                                  SYMTABLE.table[id_vector[i]].address = SYMTABLE.next_local_address;
                                                                }

                                                              }
                                                              id_vector.clear();
                                                              }
#line 1506 "parser.cpp"
    break;

  case 12:
#line 126 "parser.y"
                    {(yyval.variable_type) = (yyvsp[0].variable_type);}
#line 1512 "parser.cpp"
    break;

  case 13:
#line 128 "parser.y"
                         {(yyval.variable_type) = VarType::INTEGER;}
#line 1518 "parser.cpp"
    break;

  case 14:
#line 129 "parser.y"
                      {(yyval.variable_type) = VarType::REAL;}
#line 1524 "parser.cpp"
    break;

  case 17:
#line 147 "parser.y"
                                          {
                                          // cout << "\tenter.i #" + to_string(-1*SYMTABLE.next_local_address) << endl; //negujemy. bo next_local idzie w dol
                                          // cout << codeStream.str();
                                          // cout << "\tleave" << endl;
                                          // cout << "\treturn" << endl;
                                          myfile << "\tenter.i #" + to_string(-1*SYMTABLE.next_local_address) << endl; //negujemy. bo next_local idzie w dol
                                          myfile << codeStream.str();
                                          myfile << "\tleave" << endl;
                                          myfile << "\treturn" << endl;
                                          SYMTABLE.next_local_address = 0; //reset adresu lokalnego
                                          codeStream.str(""); //czyszczenie streamu
                                          SYMTABLE.refresh_symtable();
                                          }
#line 1542 "parser.cpp"
    break;

  case 18:
#line 161 "parser.y"
                                             {
                                             SYMTABLE.table[(yyvsp[-2].index)].input_type = InputType::PROCEDURE;
                                            //  cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta procedury
                                             myfile << SYMTABLE.table[(yyvsp[-2].index)].name + ":" <<endl; //etykieta procedury

                                             SYMTABLE.next_parameter_address = (int) parameter_vector.size()*4 + 4; //BP+4 dla adresu powrotu
                                             for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                             {
                                               SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address; //ustawia adresy parametrow
                                               SYMTABLE.next_parameter_address -= 4;
                                               SYMTABLE.table[(yyvsp[-2].index)].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype); //zapisz jakie typy
                                             }
                                             SYMTABLE.next_parameter_address = 0;
                                             parameter_vector.clear();
                                             id_vector.clear();
                                             }
#line 1563 "parser.cpp"
    break;

  case 19:
#line 178 "parser.y"
                                                              {
                                                              SYMTABLE.table[(yyvsp[-4].index)].input_type = InputType::FUNCTION;
                                                              SYMTABLE.table[(yyvsp[-4].index)].vartype = (yyvsp[-1].variable_type); //typ zwracany przez funkcje
                                                              // cout << SYMTABLE.table[$2].name + ":" <<endl; //etykieta funkcji
                                                              myfile << SYMTABLE.table[(yyvsp[-4].index)].name + ":" <<endl; //etykieta funkcji
                                                              SYMTABLE.next_parameter_address = parameter_vector.size()*4 + 8; //BP+8, dla adresu zmiennej tymczasowej wyniku funkcji
                                                              for (int i = 0; i< parameter_vector.size(); i++) //petla adresujaca adresy pushniete
                                                              {
                                                                SYMTABLE.table[parameter_vector[i]].address = SYMTABLE.next_parameter_address;
                                                                SYMTABLE.next_parameter_address -= 4;
                                                                SYMTABLE.table[(yyvsp[-4].index)].vartype_vector.push_back(SYMTABLE.table[parameter_vector[i]].vartype);
                                                              }
                                                              SYMTABLE.next_parameter_address = 0;
                                                              SYMTABLE.table[(yyvsp[-4].index)].address = 8; //przypisujemy adres powrotu do funkcji
                                                              parameter_vector.clear();
                                                              id_vector.clear();
                                                              }
#line 1585 "parser.cpp"
    break;

  case 22:
#line 199 "parser.y"
                                          {
                                          for(int i=0; i< (int) id_vector.size(); i++)
                                          {
                                            SYMTABLE.table[id_vector[i]].vartype = (yyvsp[0].variable_type);
                                            SYMTABLE.table[id_vector[i]].scope = actual_scope;
                                            parameter_vector.push_back(id_vector[i]);
                                          }
                                          id_vector.clear(); //potrzeba czyszczenia po, dlatego dodatkowy wektor ktory sumuje dla parametrow lokalnych
                                          }
#line 1599 "parser.cpp"
    break;

  case 23:
#line 209 "parser.y"
                                                            {
                                                            for(int i=0; i< (int) id_vector.size(); i++)
                                                            {
                                                              SYMTABLE.table[id_vector[i]].vartype = (yyvsp[0].variable_type);
                                                              SYMTABLE.table[id_vector[i]].scope = actual_scope;
                                                              parameter_vector.push_back(id_vector[i]);
                                                            }
                                                            id_vector.clear();
                                                            }
#line 1613 "parser.cpp"
    break;

  case 29:
#line 238 "parser.y"
                                  {
                                  if(SYMTABLE.table[(yyvsp[-2].index)].vartype != SYMTABLE.table[(yyvsp[0].index)].vartype) //jezeli sa roznego typu
                                  {
                                    int newtemp = 0;
                                    if(actual_scope == Scope::GLOBAL)
                                      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[-2].index)].vartype); //stworz nowa zmienna temp globalna
                                    else
                                      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[(yyvsp[-2].index)].vartype); //lokalna

                                    if(SYMTABLE.table[(yyvsp[0].index)].vartype == VarType::INTEGER) //jezeli jest int, to zamien na real
                                    {
                                      gencode("inttoreal", (yyvsp[0].index), newtemp, -1);
                                    }
                                    if(SYMTABLE.table[(yyvsp[0].index)].vartype == VarType::REAL) //jezeli jest real, to zamien na int
                                    {
                                      gencode("realtoint", (yyvsp[0].index), newtemp, -1);
                                    }
                                    (yyvsp[0].index) = newtemp; //przypisz adres nowej zmiennej do atrybutu expression
                                  }
                                  gencode("mov", (yyvsp[0].index), (yyvsp[-2].index), -1);
                                  }
#line 1639 "parser.cpp"
    break;

  case 30:
#line 260 "parser.y"
                                            {
                                for(int i = 0; i<parameter_vector.size(); i++)
                                {
                                  gencode("write", parameter_vector[i], -1, -1);
                                }
                                parameter_vector.clear();
                               }
#line 1651 "parser.cpp"
    break;

  case 31:
#line 268 "parser.y"
                                           {
                                for(int i = 0; i<parameter_vector.size(); i++)
                                {
                                  gencode("read", parameter_vector[i], -1, -1);
                                }
                                parameter_vector.clear();
                               }
#line 1663 "parser.cpp"
    break;

  case 34:
#line 280 "parser.y"
                 {
                 (yyval.index) = labCounter; //zapisz wejsciowy label (default 1)
                 }
#line 1671 "parser.cpp"
    break;

  case 35:
#line 284 "parser.y"
                   {
                   gencode("je", (yyvsp[-1].index), relop_false, JUMP);
                   (yyval.index) = labCounter; //label wyjsciowy z relopa, labCounter po wyjsciu z expression oznacza nastepny wolny label
                   labCounter += 2; //dodajemy dla nastepnego porownania (expression obsluguje kod dla 2 labeli w przod)
                   }
#line 1681 "parser.cpp"
    break;

  case 36:
#line 289 "parser.y"
                      {
                      codeStream << "\tjump.i #lab" + to_string((yyvsp[-1].index)+1) << endl; //skok do wyjscia ze statementu
                      (yyval.index) = (yyvsp[-1].index); //wartosc labelu z else
                      }
#line 1690 "parser.cpp"
    break;

  case 37:
#line 293 "parser.y"
                   {
                   codeStream << "lab" + to_string((yyvsp[-1].index)) + ":" << endl;
                   (yyval.index) = (yyvsp[-1].index) + 1; //wartosc labelu wyjscia
                   }
#line 1699 "parser.cpp"
    break;

  case 38:
#line 297 "parser.y"
                      {
                      codeStream << "lab" + to_string((yyvsp[-1].index)) + ":" << endl; //label wyjsciowy
                      }
#line 1707 "parser.cpp"
    break;

  case 39:
#line 303 "parser.y"
                   {
                    codeStream << "lab" + to_string(labCounter+1) + ":" << endl; //label warunku
                    (yyval.index) = labCounter; //d2 przekazuje label wejsciowy (defaultowo 1 po lab0)
                    labCounter += 2; //wyprowadzone dla ifa
                   }
#line 1717 "parser.cpp"
    break;

  case 40:
#line 309 "parser.y"
                  {
                  int temp = labCounter; //odwolanie do labela wejsciowego, bo gencode wykorzystuje labCounter
                  labCounter = (yyvsp[-2].index);
                  gencode("je", (yyvsp[-1].index), relop_false, JUMP);
                  labCounter = temp;
                  (yyval.index) = (yyvsp[-2].index); //label wyjsciowy z petli
                  }
#line 1729 "parser.cpp"
    break;

  case 41:
#line 316 "parser.y"
                      {
                      codeStream << "\tjump.i #lab" + to_string((yyvsp[-1].index)+1) << endl;
                      codeStream << "lab" + to_string((yyvsp[-1].index)) + ":" << endl;
                      }
#line 1738 "parser.cpp"
    break;

  case 42:
#line 328 "parser.y"
                        {
                        if(SYMTABLE.table[(yyvsp[0].index)].input_type == InputType::PROCEDURE) //wywolanie procedury bez parametrow
                          codeStream << "\tcall.i #" + SYMTABLE.table[(yyvsp[0].index)].name << endl;
                        else //w przypadku wywolania funkcji
                        {
                          int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[0].index)].vartype);
                          codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                          codeStream << "\tcall.i #" + SYMTABLE.table[(yyvsp[0].index)].name << endl;
                        }
                        }
#line 1753 "parser.cpp"
    break;

  case 43:
#line 339 "parser.y"
                            {
                    parameter_memory = parameter_vector;
                    //for(int i = 0; i< memory.size(); i++){codeStream << " " + SYMTABLE.table[memory[i]].name << endl;}
                    parameter_vector.clear();
                   }
#line 1763 "parser.cpp"
    break;

  case 44:
#line 345 "parser.y"
                                       {
                                                for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow oraz sprawdzanie ich typow
                                                {
                                                  if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                                  {
                                                    int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i]); //stworz zmienna ktora przechowa
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i] == VarType::INTEGER)
                                                      parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                                    if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                                      SYMTABLE.table[parameter_vector[i]].vartype = VarType::INTEGER;
                                                    gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                                    parameter_vector[i] = newtemp; //zamien adresy
                                                  }
                                                  if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i]) //jezeli sa takiego samego typu
                                                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                                  else
                                                  {
                                                    int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                                  }
                                                }
                                                codeStream << "\tcall.i #" + SYMTABLE.table[(yyvsp[-4].index)].name << endl; //wywolanie procedury
                                                codeStream << "\tincsp.i #" + to_string(parameter_vector.size()*4) << endl; //podnosimy ze stosu tyle ile push 
                                                parameter_vector = parameter_memory;
                                                parameter_memory.clear();
                                                }
#line 1794 "parser.cpp"
    break;

  case 45:
#line 380 "parser.y"
                            {
                            //codeStream << "single"<< endl;
                            parameter_vector.push_back((yyvsp[0].index)); //zbiera indeksy z tablicy parametrow
                            (yyval.index) = (yyvsp[0].index);
                            }
#line 1804 "parser.cpp"
    break;

  case 46:
#line 385 "parser.y"
                                                { 
                                                  //codeStream << "multiple"<< endl; //+ to_string($1 )
                                                  parameter_vector.push_back((yyvsp[0].index));
                                                  (yyval.index) = (yyvsp[0].index);
                                                }
#line 1814 "parser.cpp"
    break;

  case 47:
#line 391 "parser.y"
                                      {
                                      if(SYMTABLE.table[(yyvsp[-2].index)].vartype != SYMTABLE.table[(yyvsp[0].index)].vartype) //jezeli sa roznego typu
                                      {
                                        if(SYMTABLE.table[(yyvsp[-2].index)].vartype == VarType::INTEGER) {(yyvsp[-2].index) = type_conversion((yyvsp[-2].index));} //jezeli 1 jest integerem, to zamien to zmienna temp
                                        if(SYMTABLE.table[(yyvsp[0].index)].vartype == VarType::INTEGER) {(yyvsp[0].index) = type_conversion((yyvsp[0].index));} //jezeli 3, to to samo
                                      }
                                      int newtemp = expression_result_temp_gen((yyvsp[-2].index), (yyvsp[0].index));
                                      (yyval.index) = newtemp; //przekaz dalej indeks wyniku
                                      gencode("add", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                      }
#line 1829 "parser.cpp"
    break;

  case 48:
#line 402 "parser.y"
                                      {
                                      if(SYMTABLE.table[(yyvsp[-2].index)].vartype != SYMTABLE.table[(yyvsp[0].index)].vartype)
                                      {
                                        if(SYMTABLE.table[(yyvsp[-2].index)].vartype == VarType::INTEGER) {(yyvsp[-2].index) = type_conversion((yyvsp[-2].index));}
                                        if(SYMTABLE.table[(yyvsp[0].index)].vartype == VarType::INTEGER) {(yyvsp[0].index) = type_conversion((yyvsp[0].index));}
                                      }
                                      int newtemp = expression_result_temp_gen((yyvsp[-2].index), (yyvsp[0].index));
                                      (yyval.index) = newtemp;
                                      gencode("sub", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                      }
#line 1844 "parser.cpp"
    break;

  case 49:
#line 413 "parser.y"
                                         {
                                         if(SYMTABLE.table[(yyvsp[-2].index)].vartype != SYMTABLE.table[(yyvsp[0].index)].vartype)
                                         {
                                            if(SYMTABLE.table[(yyvsp[-2].index)].vartype == VarType::INTEGER) {(yyvsp[-2].index) = type_conversion((yyvsp[-2].index));}
                                            if(SYMTABLE.table[(yyvsp[0].index)].vartype == VarType::INTEGER) {(yyvsp[0].index) = type_conversion((yyvsp[0].index));}
                                         }
                                         int newtemp = expression_result_temp_gen((yyvsp[-2].index), (yyvsp[0].index));
                                  
                                         if((yyvsp[-1].operation) == '*')
                                         {
                                          (yyval.index) = newtemp;
                                          gencode("mul", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                         }

                                         if ((yyvsp[-1].operation) == '/')
                                         {
                                          (yyval.index) = newtemp;
                                          gencode("div", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                         }

                                         if ((yyvsp[-1].operation) == 'm')
                                         {
                                          (yyval.index) = newtemp;
                                          gencode("mod", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                         }

                                         if ((yyvsp[-1].operation) == '&')
                                         { 
                                           gencode("and", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                           (yyval.index) = newtemp;
                                         }

                                         if ((yyvsp[-1].operation) == '|')
                                         {
                                           gencode("or", (yyvsp[-2].index), (yyvsp[0].index), newtemp);
                                           (yyval.index) = newtemp;
                                         }

                                         }
#line 1888 "parser.cpp"
    break;

  case 50:
#line 453 "parser.y"
                           {
                           int newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[0].index)].vartype);
                           (yyval.index) = newtemp;
                           gencode("negation", 0, (yyvsp[0].index), newtemp);
                           }
#line 1898 "parser.cpp"
    break;

  case 51:
#line 459 "parser.y"
                               {(yyval.index) = (yyvsp[-1].index);}
#line 1904 "parser.cpp"
    break;

  case 52:
#line 463 "parser.y"
                   {
            parameter_memory = parameter_vector;
            //for(int i = 0; i< parameter_memory.size(); i++){codeStream << " " + SYMTABLE.table[parameter_memory[i]].name << endl;}
            parameter_vector.clear();
            }
#line 1914 "parser.cpp"
    break;

  case 53:
#line 469 "parser.y"
                                {
                                        for(int i = 0; i<parameter_vector.size(); i++) //odkladanie na stosie adresow parametrow
                                        {
                                          int newtemp = 0;
                                          if(SYMTABLE.table[parameter_vector[i]].input_type == InputType::NUMBER) //jezeli parametrem jest czyta liczba
                                          {
                                            if(actual_scope == Scope::GLOBAL)
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i]); //stworz zmienna ktora przechowa
                                            else
                                              newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i]); //stworz zmienna ktora przechowa
                                              
                                             //sprawdzenie typow argumentow 
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::REAL && SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i] == VarType::INTEGER)
                                              parameter_vector[i] = SYMTABLE.insert_to_table(to_string((int)stof(SYMTABLE.table[parameter_vector[i]].name)), InputType::NUMBER, SYMTABLE.table[parameter_vector[i]].vartype);
                                            if(SYMTABLE.table[parameter_vector[i]].vartype == VarType::INTEGER)
                                              SYMTABLE.table[parameter_vector[i]].vartype = VarType::INTEGER;
                                            gencode("mov", parameter_vector[i], newtemp, -1); //nowa cyfra do zmiennej tymczasowej
                                            parameter_vector[i] = newtemp; //zamien adresy
                                          }
                                          //dla zmiennych
                                          if(SYMTABLE.table[parameter_vector[i]].vartype == SYMTABLE.table[(yyvsp[-4].index)].vartype_vector[i]) //jezeli sa takiego samego typu
                                            if(actual_scope == Scope::GLOBAL)
                                              codeStream << "\tpush.i #" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                            else
                                              if(SYMTABLE.table[parameter_vector[i]].address > 0)
                                                codeStream << "\tpush.i BP+" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                              else
                                                codeStream << "\tpush.i #BP" + to_string(SYMTABLE.table[parameter_vector[i]].address) << endl; //pushuj bezposrednio ten adres
                                          else
                                          {
                                            int newtemp = type_conversion(parameter_vector[i]); //jezeli sa innego typu, to najpierw trzeba konwersje i push nowego
                                            if(actual_scope == Scope::GLOBAL)
                                              codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                            else
                                              codeStream << "\tpush.i #BP" + to_string(SYMTABLE.table[newtemp].address) << endl;
                                          }
                                        }

                                        int newtemp = 0;
                                        if(SYMTABLE.table[(yyvsp[-4].index)].input_type == InputType::FUNCTION) //jezeli jest funkcja to stworz zmienna do ktorej wrzuci wynik
                                        {
                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[-4].index)].vartype); //nowa zmienna wynika z typu funkcji
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, SYMTABLE.table[(yyvsp[-4].index)].vartype); //nowa zmienna wynika z typu funkcji
                                        }
                                        else
                                        {
                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //dla procedur zawsze real
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL); //dla procedur zawsze real
                                        }

                                        if(actual_scope == Scope::GLOBAL)
                                          codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                                        else
                                          codeStream << " \tpush.i #BP" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                                        codeStream << "\tcall.i #" + SYMTABLE.table[(yyvsp[-4].index)].name << endl; //wywolanie funkcji
                                        codeStream << "\tincsp.i #" + to_string(parameter_vector.size()*4 + 4) << endl; //podnosimy ze stosu tyle ile push + 4 dla wyniku

                                        SYMTABLE.table[(yyvsp[-4].index)].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                                        SYMTABLE.table[(yyvsp[-4].index)].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                                        //for(int i = 0; i< parameter_vector.size(); i++){codeStream << " " + SYMTABLE.table[parameter_vector[i]].name << endl;}
                                        parameter_vector = parameter_memory;
                                        parameter_memory.clear();
                                        (yyval.index) = newtemp; //przekaz dalej adres przechowujacy wynik
                                        //$$ = $1;

                                       }
#line 1989 "parser.cpp"
    break;

  case 54:
#line 542 "parser.y"
                {
                if(SYMTABLE.table[(yyvsp[0].index)].input_type == InputType::FUNCTION) //jezeli wywolujemy funkcje bez argumentu
                { 
                  int newtemp = 0;
                  if(actual_scope == Scope::GLOBAL)
                  {
                    newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, SYMTABLE.table[(yyvsp[0].index)].vartype); //nowa zmienna przechowujaca wynika z typu funkcji
                    codeStream << "\tpush.i #" + to_string(SYMTABLE.table[newtemp].address) << endl; //pushujemy ta zmienna
                    codeStream << "\tcall.i #" + SYMTABLE.table[(yyvsp[0].index)].name << endl; //wywolanie funkcji
                    codeStream << "\tincsp.i #4" << endl;
                    SYMTABLE.table[(yyvsp[0].index)].address = SYMTABLE.table[newtemp].address; //przypisujemy tej funkcji adres wyniku
                    SYMTABLE.table[(yyvsp[0].index)].vartype = SYMTABLE.table[newtemp].vartype; //i typ wyniku
                  }
                }
                (yyval.index) = (yyvsp[0].index);
                }
#line 2010 "parser.cpp"
    break;

  case 55:
#line 559 "parser.y"
                {(yyval.index) = (yyvsp[0].index);}
#line 2016 "parser.cpp"
    break;

  case 56:
#line 561 "parser.y"
                                          {
                                          int newtemp = 0;
                                          gencode((yyvsp[-1].relop),(yyvsp[-2].index),(yyvsp[0].index),JUMP); //instrukcja relop i ponizej wariant false; pobiera globalnie labCounter
                                          labCounter -= 2;

                                          if(actual_scope == Scope::GLOBAL)
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje wartosc logiczna
                                          else
                                            newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
                                          gencode("mov", relop_false, newtemp, -1);

                                          codeStream << "\tjump.i #lab" + to_string(labCounter+3) << endl; 
                                          //wariant true
                                          codeStream << "lab" + to_string(labCounter+2) + ":" << endl;
                                          gencode("mov", relop_true, newtemp, -1);

                                          codeStream << "lab" + to_string(labCounter+3) + ":" << endl;
                                          labCounter += 4; //nastepny wolny, relop zajmuje 3 labele, wiec musimy podniesc
                                          (yyval.index) = newtemp; //przekazujemy adres wyniku dalej
                                          }
#line 2041 "parser.cpp"
    break;

  case 57:
#line 583 "parser.y"
                              {
                              int newtemp = 0;
                              gencode("je", (yyvsp[0].index), relop_false, JUMP);
                              if(actual_scope == Scope::GLOBAL)
                                newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //przechowuje true albo False
                              else
                                newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
                              gencode("mov", relop_false, newtemp, -1);
                              codeStream << "\tjump.i #lab" + to_string(labCounter+1) << endl;

                              //wariant true
                              codeStream << "lab" + to_string(labCounter) + ":" << endl;
                              gencode("mov", relop_true, newtemp, -1);

                              codeStream << "lab" + to_string(labCounter+1) + ":" << endl;
                              
                              labCounter += 2; //not zajmuje 1 label, wiec trzeba podniesc
                              (yyval.index) = newtemp;
                              }
#line 2065 "parser.cpp"
    break;


#line 2069 "parser.cpp"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 602 "parser.y"




void yyerror(char const *s)
{
  fprintf(stderr,"\x1B[35mLine number %d : \x1B[37m%s\n",yylineno,s);
};

int main()
{
  atexit(destroy);
  yyparse();
  exit(0);
};

void gencode(string command, int i1, int i2, int i3) //przekazuje indeksy w tablicy symboli
{
  string var1 = "", var2 = "", var3 = "";
  if(i1 >= 0)
    var1 = isdigit(SYMTABLE.table[i1].name[0]) ? "#" + SYMTABLE.table[i1].name : to_string(SYMTABLE.table[i1].address);
  if(i2 >= 0)
    var2 = isdigit(SYMTABLE.table[i2].name[0]) ? ",#" + SYMTABLE.table[i2].name : "," + to_string(SYMTABLE.table[i2].address);
  if(i3 == JUMP)
    {var3 = ",#lab" + to_string(labCounter);}
  else
    if(i3 >= 0)
      var3 = isdigit(SYMTABLE.table[i3].name[0]) ? ",#" + SYMTABLE.table[i3].name : "," + to_string(SYMTABLE.table[i3].address);
  string type_postfix = SYMTABLE.table[i1].vartype == VarType::INTEGER ? ".i " : ".r ";
  ////
  if(actual_scope == Scope::GLOBAL)
    codeStream << "\t" << command+type_postfix << var1 << var2 << var3 << endl;
  if(actual_scope == Scope::LOCAL)
  {
    if(var1 != "" && var1[0] != '#' ) if(var1[0] == '-') var1.insert(0,"BP"); else var1.insert(0,"*BP+");
    if(var2 != "" && var2[1] != '#' ) if(var2[1] == '-') var2.insert(1,"BP"); else var2.insert(1,"*BP+");
    if(var3 != "" && var3[1] != '#') if(var3[1] == '-') var3.insert(1,"BP"); else var3.insert(1,"*BP+");
    codeStream << "\t" << command+type_postfix << var1 << var2 << var3 << endl;
  }
}

int type_conversion(int i1)
{
  int newtemp = 0;
  if(SYMTABLE.table[i1].vartype == VarType::INTEGER)
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL);
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL);
    gencode("inttoreal", i1, newtemp, -1);
  }

  if(SYMTABLE.table[i1].vartype == VarType::REAL)
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER);
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
    gencode("realtoint", i1, newtemp, -1);
  }
  return newtemp;
}

int expression_result_temp_gen(int i1, int i3) //generator tempa dla expression
{
  int newtemp = 0;
  if(SYMTABLE.table[i1].vartype != SYMTABLE.table[i3].vartype) //jezeli sa roznego typu
  {
    if(actual_scope == Scope::GLOBAL)
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //stworz nowa zmienna na wynik operacji
    else
      newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL); //stworz nowa zmienna lokalna na wynik operacji
  }
  else //jezeli sa tego samego typu
  {
    if (SYMTABLE.table[i1].vartype == VarType::INTEGER)
      if(actual_scope == Scope::GLOBAL)
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::INTEGER); //stworz zmienna na wynik typu int
      else
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::INTEGER);
    if (SYMTABLE.table[i1].vartype == VarType::REAL)
      if(actual_scope == Scope::GLOBAL)
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY, VarType::REAL); //stworz zmienna na wynik typu real
      else
        newtemp = SYMTABLE.insert_to_table("$t", InputType::TEMPORARY_LOCAL, VarType::REAL);
  }
  return newtemp;
}


void destroy()
{
  yylex_destroy();
}
