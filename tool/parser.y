%{
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
extern int yylineno;
extern char *yytext;
extern int yylex();
int logyes = 0;
void yyerror(const char *str)
{
    fprintf(stderr,"error: %s %d: %s\n",str, yylineno, yytext);
}

int yywrap()
{
    return 1;
}


extern char *teststr;
extern int portint;
extern int threadnumint;
extern int daemonizeint;
%}

%token	SHARP EQUAL TEST PORT THREADNUM DAEMONIZE

%union
{
    int number;
    char *string;
}

%token <number> STATE
%token <number> NUMBER
%token <string> WORD

%%

commands:
    | commands command
    ;


command:
    testassign | portassign | threadnumassign | daemonizeassign

testassign:
    TEST EQUAL WORD
    {
        printf("test is %s\n", $3);
        teststr = strdup($3);
    }
    ;

portassign:
    PORT EQUAL NUMBER
    {
        printf("port is %d\n", $3);
        portint = $3;
    }
    ;

threadnumassign:
    THREADNUM EQUAL NUMBER
    {
        printf("threadnum is %d\n", $3);
        threadnumint = $3;
    }
    ;

daemonizeassign:
    DAEMONIZE EQUAL NUMBER
    {
        printf("daemonize is %d\n", $3);
        daemonizeint = $3;
    }
    ;
