#include "proto.h"


int _kill(int pid, int sig) {
    return 0;
}

int _write(int fd, const void *buf, size_t count)
{
    return 0;
}

void _exit(int status) {
    while (1) {
        ;
    }
}

int _getpid(void) {
    return 0;
}


void *_sbrk(int incr) {
  extern char _end;

  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) heap = (unsigned char *) &_end;

  prev_heap = heap;
  heap += incr;

  return prev_heap;
}



