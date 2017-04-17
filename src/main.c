#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "parser.h"

int portint			= 9999;
int threadnumint	= 2;
char *teststr 		= 0;


int main(int argc, char *argv[])
{
	int fd;
	if (argc != 2) {
		printf("USAGE: %s <conf>\n", argv[0]);
		exit(1);
	}
	fd = open (argv[1], O_RDONLY);
	if (fd < 0) {
		perror(argv[1]);
		exit(1);
	}
	dup2 (fd, 0);
	yyparse ();
	return 0;
}

