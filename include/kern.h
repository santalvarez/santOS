#include <stdint.h>


typedef int syscall;
typedef uint32_t intmask;




// Syscall return
#define OK	( 1)
// Syscall error
#define	SYSERR	(-1)
// End of file
#define	EOF	(-2)
// Syscall timeout
#define	TIMEOUT	(-3)
