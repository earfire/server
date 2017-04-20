#include "conn.h"

void conn_init(void)
{
    int next_fd = dup(1);
    int headroom = 10;
    struct rlimit rl;
   
    /* todo */

    close(next_fd);
    
}
