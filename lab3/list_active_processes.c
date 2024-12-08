#include "types.h"
#include "stat.h"
#include "user.h"
#define MAX_SYSCALLS 27

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

    list_active_processes();

    exit();
}