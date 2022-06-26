%{
	#include <stdbool.h>
	#include <stdio.h>
	#include "List.h"

	int yyerror(const char*);
	int yylex();


	#define MAX_DEPTH 1024


	union Type{
		char *str;
		unsigned long long int _uint;
		long long int _int;
		long double _float;
	};

	enum element_type{
		E_WORD,
		E_IF,
		E_DEF,
		E_INC,
	};

	struct stmt_if
	{
		size_t line;
		char *condition;
		char *success;
		char *fail;
	};

	struct stmt_def
	{
		size_t line;
		char *name;
		char *opt_replace;
		bool undefine;
	};

	struct stmt_inc
	{
		size_t line;
		char *name;
	};

	struct element
	{
		enum element_type type;
		union{
			struct stmt_if *stmt_if;
			struct stmt_def *stmt_def;
			struct stmt_inc *stmt_inc;
		};
	};
	struct source_file{
		char *name;
		List *elements;
		List *defines;
		bool included;
	};
	typedef struct source_file SFile;
	// Thread data
	SFile *parrent[MAX_DEPTH];
	int parrent_index;
	
	// global data
	List *Files;

	// TODO: HashTable

	// search functions 
	bool is_file(char *name);
	bool is_defined(char *name);

	// get functions
	SFile *get_file(char *name);
	char *get_defined(SFile *file, char *name);

	bool eval_condition(SFile *file, char *condition);
	extern size_t lineno;
%}

%token DEF PRA IFDEF IFNDEF IF ENDIF ELIF ELSE OTH INC COMMENT CONTENT

%union{
	char *str;
}
%define parse.error detailed
%type <str> CONTENT COMMENT

%%

prg:
	stmts
stmts:
     	%empty | stmt stmts
stmt:
		  COMMENT{
				printf($1);
			}
			| DEF{
				printf("DEFINING SMTH at %d\n", lineno);
			}
			| CONTENT{
				printf($1);
			}
%%

// search functions 
bool is_file(char *name)
{
	
	//for(; 
}
bool is_defined(char *name);


// get functions
SFile *get_file(char *name);
char *get_defined(SFile *file, char *name);

bool eval_condition(SFile *file, char *condition);

