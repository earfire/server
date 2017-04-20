#ifndef __THREAD_H__
#define __THREAD_H__

#include <pthread.h>
#include <event.h>


typedef struct {
    pthread_t thread_id;        /* unique ID of this thread */
    struct event_base *base;    /* libevent handle this thread uses */
    struct event notify_event;  /* listen event for notify pipe */
    int notify_receive_fd;      /* receiving end of notify pipe */
    int notify_send_fd;         /* sending end of notify pipe */
#if 0
    struct thread_stats stats;  /* Stats generated by this thread */
    struct conn_queue *new_conn_queue; /* queue of new connections to handle */
    cache_t *suffix_cache;      /* suffix cache */
    logger *l;                  /* logger buffer */
    void *lru_bump_buf;         /* async LRU bump buffer */
#endif
} LIBEVENT_THREAD;


void thread_init(int nthreads);
#endif