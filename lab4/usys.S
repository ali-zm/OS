#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(sort_syscalls)
SYSCALL(get_most_syscalls)
SYSCALL(list_active_processes)
SYSCALL(move_file)
SYSCALL(create_palindrome)
SYSCALL(set_level)
SYSCALL(show_process_info)
SYSCALL(set_burst_confidence)
SYSCALL(count_syscalls_all_cpus)
SYSCALL(sum_all_cpus_syscalls)


