#ifndef __CONN_H__
#define __CONN_H__

extern int max_fds;

typedef struct conn conn;
struct conn {
    int sfd;
    int state;
    //Buffer *buf;
    struct event_base *ev_base;
    struct event ev;
    short ev_flags;
    //ProtocolHandle *handler;
};
void conn_init(void);

#endif
