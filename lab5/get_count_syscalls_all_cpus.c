#include "user.h"
#include "types.h"

int main(void)
{
    int count = count_syscalls_all_cpus();
    int count2 = sum_all_cpus_syscalls();
    printf(1, "Total system calls: %d, %d\n", count, count2);

    // Test by making some system calls
    printf(1, "Hello, world!\n");
    count_syscalls_all_cpus(); // Call the system call again
    
    count = count_syscalls_all_cpus();
    count2 = sum_all_cpus_syscalls();
    printf(1, "Total system calls after test: %d, %d\n", count, count2);

    exit();
}