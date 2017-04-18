#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>

#include "parser.h"

#define DEFAULT_CONFILE_PATH "conf/server.conf"
int portint			= 9999;
int threadnumint	= 2;
int daemonizeint    = 0;
char *teststr 		= 0;


static void sig_handler(const int sig) {
    printf("Signal handled: %s.\n", strsignal(sig));
    exit(EXIT_SUCCESS);
}

int main(int argc, char *argv[])
{
    int fd;
    int ret;

    if (argc == 1) {
        fd = open (DEFAULT_CONFILE_PATH, O_RDONLY);
    } else if (argc == 2) {
        fd = open (argv[1], O_RDONLY);
    } else {
        printf("USAGE: %s <conf>\n", argv[0]);
        exit(1);
    }
    if (fd < 0) {
        perror(argv[1]);
        exit(1);
    }
    dup2 (fd, 0);
    yyparse ();


    /* handle SIGINT and SIGTERM */
    signal(SIGINT, sig_handler);
    signal(SIGTERM, sig_handler);

    /* set stderr non-buffering (for running under, say, daemontools) */
    setbuf(stderr, NULL);

    if (daemonizeint) {
        /** TODO **/
    }

    /* initialize main thread libevent instance */
    main_base = event_init();

    /* initialize other stuff */
    /** logger_init(); **/
    conn_init();
    return 0;
}

