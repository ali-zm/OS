#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"


#include "syscall.h"
#include "traps.h"


int create_palindrome_num(int num) {
    char str[20];  // Buffer to hold the original number as a string 
    //(20 digits to handle large integers)
    int length = 0;

    // Converting our integer to string
    int temp = num;
    while (temp > 0) {
        str[length++] = (temp % 10) + '0';
        temp /= 10;
    }
    str[length] = '\0'; 

    char palindrome_str[40];  // 2x length buffer to handle the palindrome
    int i, j;
    for (i = 0; i < length; i++) {
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
    }
    for (j = 0; j < length; j++) {
        palindrome_str[i++] = str[j];  // Copying the original part
    }
    palindrome_str[i] = '\0';

    cprintf("%s\n", palindrome_str);

    return 0;
}

int sys_create_palindrome(void) {
    int num;

    // Receive the integer argument from the REGISTERS
    if (argint(0, &num) < 0)
        return -1;

    // Generate and print the palindrome in kernel level
    create_palindrome_num(num);

    return 0;
}




const char* syscall_names [] ={
  "none",
  "fork",
  "exit",
  "wait",
  "read",
  "pipe",
  "kill",
  "exec",
  "fstat",
  "chdir",
  "dup",
  "getpid",
  "sbrk",
  "sleep",
  "uptime",
  "open",
  "write",
  "mknod",
  "unlink",
  "link",
  "mkdir",
  "close"
};

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

int sys_sort_syscalls(void)
{
  int pid;
  int counts[MAX_SYSCALLS];
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
    return -1;
  
  struct proc *p = findproc(pid);
  if(p==0) return -1;
  for(int i=0; i<MAX_SYSCALLS; i++)
  {
    if(p->syscalls[i] != 0)
      cprintf("%d\n", i);

  }
  return 0;
}

int sys_get_most_syscalls(void)
{
  int pid;
  if(argint(0, &pid)<0 , sizeof(int)*MAX_SYSCALLS<0)
    return -1;
  
  struct proc *p = findproc(pid);
  if(p==0) return -1;
  int syscall_most_invoked = -1;
  for(int i=0; i<MAX_SYSCALLS; i++)
    if(p->syscalls[i] > syscall_most_invoked)
      syscall_most_invoked = i;
  if(syscall_most_invoked<0) return -1;
  cprintf("System call been most invoked: %s - %d times", syscall_names[syscall_most_invoked], p->syscalls[syscall_most_invoked]);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


int sys_list_active_processes(void) {
    list_active_processes();
    return 0;  // Return 0 to indicate success
}

int sys_set_level(void)
{
  int pid, level;
  if(argint(0,&pid)<0||argint(1,&level)<0)
    return;
  int res = set_level(pid,level);
  return res;
}

void sys_show_process_info()
{
  show_process_info();
}

void sys_set_burst_confidence(void)
{
  int pid, burst, conf;
  if(argint(0,&pid)<0||argint(1,&burst)<0|| argint(2,&conf)<0)
    return;
  set_burst_confidence(pid, burst, conf);
}

int sys_count_syscalls_all_cpus(void)
{
  int count;

  acquire(&syscallslock);
  count = syscalls_count;
  release(&syscallslock);

  return count;

}

int sys_sum_all_cpus_syscalls(void)
{
  return sum_all_cpus_syscalls();
}

int sys_test_reentrantlock()
{
  int num;
  if(argint(0, &num) < 0)
  {
    return -1;
  }
  return test_reentrantlock(num);
}