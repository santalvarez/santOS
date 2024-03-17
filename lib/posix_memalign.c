#include <stdlib.h>
#include <errno.h>
#include <stdint.h>


int posix_memalign(void **memptr, size_t alignment, size_t size) {

    if (alignment % sizeof(void *) != 0 || (alignment & (alignment - 1)) != 0) {
        // Alignment must be a power of two and a multiple of sizeof(void *)
        return EINVAL; // Invalid argument
    }

    // Allocate memory with extra space for alignment adjustment
    void *ptr = malloc(size + alignment - 1);
    if (ptr == NULL) {
        return ENOMEM; // Memory allocation failed
    }

    // Adjust the pointer for alignment
    uintptr_t misalignment = (uintptr_t)ptr % alignment;
    void *aligned_ptr = (misalignment == 0) ? ptr : ptr + (alignment - misalignment);

    // Store the aligned pointer
    *memptr = aligned_ptr;

    return 0; // Success
}

