#include "user.h"

#define SHARED_MEM_ID 1

void factorial_child(int n) {
    int *shared_mem = (int *)open_sharedmem(SHARED_MEM_ID);
    int result = shared_mem[0] * (n + 1);
    shared_mem[0] = result;
    printf(1, "Child %d: factorial(%d) = %d\n", getpid(), n + 1, result);

    close_sharedmem(SHARED_MEM_ID);
}

int main() {
    int *shared_mem = (int *)open_sharedmem(SHARED_MEM_ID);
    shared_mem[0] = 1; 

    int n = 5; 
    for (int i = 0; i < n; i++) {
        if (fork() == 0) {
            // Child process
            factorial_child(i);
            exit();
        }
        wait(); 
    }

    printf(1, "Final Result: factorial(%d) = %d\n", n, shared_mem[0]);

    close_sharedmem(SHARED_MEM_ID);
    exit();
}