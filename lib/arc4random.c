#include <stdint.h>
#include <time.h>


static uint32_t simple_rand(void) {
    static uint32_t seed = 0;
    seed = (seed * 1103515245 + 12345) & 0x7FFFFFFF;
    return seed;
}

void arc4random_buf(void *buf, size_t nbytes) {
    uint8_t *ptr = buf;
    size_t i;

    for (i = 0; i < nbytes; i++) {
        ptr[i] = simple_rand() & 0xFF;
    }
}