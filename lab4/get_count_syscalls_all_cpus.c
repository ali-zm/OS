#include "user.h"
#include "types.h"

int main(void)
{
    int count = count_syscalls_all_cpus();
    printf(1, "Total system calls: %d\n", count);

    // Test by making some system calls
    printf(1, "Hello, world!\n");
    count_syscalls_all_cpus(); // Call the system call again
    
    count = count_syscalls_all_cpus();
    printf(1, "Total system calls after test: %d\n", count);

    exit();
}