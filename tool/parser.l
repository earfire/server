%option nounput
%{
#include <stdio.h>
#include <string.h>
#include "parser.h"
#define YY_NO_INPUT
%}
%x comment
%%
^#							BEGIN(comment);
<comment>[^\n]*
<comment>\n {yylineno++;	BEGIN(INITIAL);}
#							return SHARP;
[0-9]+						yylval.number=atoi(yytext); return NUMBER;
test						return TEST;
port						return PORT;
threadnum					return THREADNUM;
=							return EQUAL;
[a-zA-Z:\\\?/\*\._0-9\[\-\]]+	yylval.string=strdup(yytext);return WORD;
\n							yylineno++; /* ignore end of line */;
[ \t]+ /* ignore whitespace */;
%%

