#include "kern.h"
#include <stddef.h>

int _write(int fd, const void *buf, size_t count);

int _kill(int pid, int sig);

void _exit(int status);

int posix_memalign(void **memptr, size_t alignment, size_t size);

int _getpid(void);

extern int putchar(int c);

extern	intmask	disable(void);
extern	void	enable(void);
extern	void	restore(intmask);
