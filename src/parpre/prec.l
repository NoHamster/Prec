%{
	#include <stdio.h>
	#include <string.h>
	#include "prec.tab.h"
	int yyerror(const char *r);
	#define CMT_SAVE
	size_t lineno=1;
%}

name ([[:alpha:]_]+[[:alnum:]_]*)
slcmt (\/\/[^\n])
stmt (#[a-z]+)
esclbrk1 ("\\\n")
esclbrk2 ("\\\r\n")
%x STMT
%x MLCMT
%%

{stmt} 		{BEGIN(STMT);yyless(1);}
<STMT>{
			"define"	{return (DEF);}
			"pragma"	{return (PRA);}
			"include"	{return (INC);}
			"ifdef"		{return (IFDEF);}
			"ifndef"	{return (IFNDEF);}
			"if"			{return (IF);}
			"endif"		{return (ENDIF);}
			"elif"		{return (ELIF);}
			"else"		{return (ELSE);}
			{esclbrk1}	{lineno++; yyless(2);}
			{esclbrk2}	{lineno++; yyless(3);}
			\n 				{lineno++;BEGIN(INITIAL);}
			\r
			" "
			. 				{ECHO; yyerror("Invalid Input");return (OTH);}
}

"#"

"/*" 	BEGIN(MLCMT);
<MLCMT>{
			\n lineno++;
			[^*\n]+
			"*"
			"*/" BEGIN(INITIAL);
}

{slcmt} {
			#ifdef CMT_SAVE
			int len = strlen(yytext)-2;
			yylval.str=malloc(len+1);
			strcpy(yylval.str,yytext+2);
			#endif
			return (COMMENT);
}

\n 	lineno++;
. 		{
			int len = strlen(yytext);
			yylval.str=malloc(len+1);
			strcpy(yylval.str,yytext);
			return (CONTENT);
}

%%
int yywrap()
{
	return 1;
}
int yyerror(const char *r){
	printf("Error: %s\n", r);
}


