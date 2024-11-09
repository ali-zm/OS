#include "types.h"
#include "stat.h"
#include "user.h"
#define MAX_SYSCALLS 26

int main(void) {
    
    printf(1, "first write system call\n");  // This calls write

    int pid = getpid();
    if (fork() == 0) 
    {
        printf(1, "In child process\n");
        exit();
    } 
    else 
        wait();
    sleep(10);

    if (sort_syscalls(pid) < 0) {
        printf(1, "Error: Failed to retrieve syscall counts\n");
        exit();
    }

    exit();
}