#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "syscall.h"

struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int cpuid()
{
  return mycpu() - cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void)
{
  int apicid, i;

  if (readeflags() & FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
  {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

struct proc *findproc(int pid)
{
  struct proc *p;

  // Acquire the process table lock to ensure thread safety.
  acquire(&ptable.lock);

  // Iterate over the process table to find the process with the matching pid.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      release(&ptable.lock); // Release the lock before returning.
      return p;
    }
  }

  // Release the lock if no process with the given pid is found.
  release(&ptable.lock);
  return 0;
}

// PAGEBREAK: 32
//  Look in the process table for an UNUSED proc.
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  for (int i = 0; i < MAX_SYSCALLS; i++)
    p->syscalls[i] = 0;
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
  {
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe *)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  p->sched_info.burst_time = 2;
  p->sched_info.confidence = 50;
  p->sched_info.creation_time = ticks;
  p->sched_info.enter_level_time = ticks;
  p->sched_info.last_exe_time = 0;
  p->sched_info.level = FCFS;
  p->sched_info.num_of_cycles = 0;
  


  return p;
}

// PAGEBREAK: 32
//  Set up first user process.
void userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();

  initproc = p;
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0; // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
  set_level(p->pid, ROUND_ROBIN);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if (n > 0)
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  else if (n < 0)
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
  {
    return -1;
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
  {
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;


  release(&ptable.lock);

  if(pid==2)
    set_level(pid, ROUND_ROBIN);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if (curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
  {
    if (curproc->ofile[fd])
    {
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == curproc)
    {
      p->parent = initproc;
      if (p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    {
      if (p->parent != curproc)
        continue;
      havekids = 1;
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
    {
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
  }
}

// PAGEBREAK: 42
//  Per-CPU process scheduler.
//  Each CPU calls scheduler() after setting itself up.
//  Scheduler never returns.  It loops, doing:
//   - choose a process to run
//   - swtch to start running that process
//   - eventually that process transfers control
//       via swtch back to the scheduler.

int create_rand_num(int seed)
{
  return (ticks*ticks*ticks)%seed;
}

struct proc* short_job_first()
{
  struct proc* res=0;
  struct proc* p;
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
  {
    if((p->state != RUNNABLE) || (p->sched_info.level!=SJF))
      continue;
    if(res == 0)
      res = p;
    if(p->sched_info.confidence > create_rand_num(100))
    {
      if(p->sched_info.burst_time < res->sched_info.burst_time)
        res = p;
    }
  }
  return res;
}

struct proc* first_come_first_service()
{
  struct proc* res=0;
  struct proc* p;
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
  {
    if((p->state != RUNNABLE) || (p->sched_info.level!=FCFS))
      continue;
    if(res == 0)
      res = p;
    else if(p->sched_info.enter_level_time<res->sched_info.enter_level_time)
      res = p;
  }
  return res;
}

int set_level(int pid, int target_level)
{
  struct proc *p = findproc(pid);
  acquire(&ptable.lock);

  int old_queue = p->sched_info.level;
  p->sched_info.level = target_level;
  p->sched_info.enter_level_time = ticks;

  release(&ptable.lock);
  return old_queue;
}

void aging()
{
  struct proc *p;
  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == RUNNABLE)
    {
      if( p->sched_info.level == ROUND_ROBIN)
        continue;
      if ((ticks - p->sched_info.last_exe_time > STARVATION_THRESHOLD) &&
         (ticks - p->sched_info.enter_level_time > STARVATION_THRESHOLD))
      {
        {
          release(&ptable.lock);
          if(p->sched_info.level == SJF)
            set_level(p->pid, ROUND_ROBIN);
          else if(p->sched_info.level == FCFS)
            set_level(p->pid, SJF);
          cprintf("pid: %d starved!\n", p->pid);
          acquire(&ptable.lock);
        }
      }  
      
    }
  }
  release(&ptable.lock);
}

struct proc *
round_robin(struct proc *last_scheduled)
{
  struct proc *p = last_scheduled;
  for (;;)
  {
    p++;
    if (p >= &ptable.proc[NPROC])
      p = ptable.proc;
    if (p->state == RUNNABLE && p->sched_info.level == ROUND_ROBIN)
      return p;

    if (p == last_scheduled)
      return 0;
  }
  return 0;
}

void scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  struct proc *last_scheduled_RR = &ptable.proc[NPROC - 1];
  c->proc = 0;
  for (;;)
  {
    sti();
    p = 0;
    acquire(&ptable.lock);
    if(mycpu()->rr>0)
      p = round_robin(last_scheduled_RR);
    if (p)
      last_scheduled_RR = p;
    else
    {
      if(mycpu()->sjf>0)
        p = short_job_first();
      if (!p)
      {
        if(mycpu()->fcfs>0)
          p = first_come_first_service();
        if (!p)
        {
          mycpu()->rr = 30;
          mycpu()->sjf = 20;
          mycpu()->fcfs = 10;
          release(&ptable.lock);
          continue;
        }
      }
    }
    c->proc = p;
    switchuvm(p);
    p->state = RUNNING;
    p->sched_info.last_exe_time = ticks;
    swtch(&(c->scheduler), p->context);
    switchkvm();
    c->proc = 0;
  release(&ptable.lock);
  }
}
// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void yield(void)
{
  acquire(&ptable.lock); // DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first)
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if (p == 0)
    panic("sleep");

  if (lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
  {                        // DOC: sleeplock0
    acquire(&ptable.lock); // DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if (lk != &ptable.lock)
  { // DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

// PAGEBREAK!
//  Wake up all processes sleeping on chan.
//  The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
  static char *states[] = {
      [UNUSED] "unused",
      [EMBRYO] "embryo",
      [SLEEPING] "sleep ",
      [RUNNABLE] "runble",
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if (p->state == SLEEPING)
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

int list_active_processes(void)
{
  struct proc *p;
  acquire(&ptable.lock);

  cprintf("PID\tName\t\tNumber of syscalls:\n");
  cprintf("---------------------------\n");

  // Iterate over the process table
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state != UNUSED)
    { // Only list active processes
      int num_of_syscalls = 0;
      for (int i = 0; i < MAX_SYSCALLS; i++)
        num_of_syscalls += p->syscalls[i];
      cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
    }
  }

  // Release the process table lock
  release(&ptable.lock);

  return 0; // Return 0 to indicate success
}


void
space(int count)
{
  for(int i = 0; i < count; ++i)
    cprintf(" ");
}

int num_digits(int n) {
  int num = 0;
  while(n!= 0) {
    n/=10;
    num += 1;
  }
  return num;
}

void show_process_info()
{

  static char *states[] = {
      [UNUSED] "unused",
      [EMBRYO] "embryo",
      [SLEEPING] "sleeping",
      [RUNNABLE] "runnable",
      [RUNNING] "running",
      [ZOMBIE] "zombie"};

  static int columns[] = {24, 10, 10, 10, 10, 10, 15, 12, 12};
  cprintf("Process_Name            PID     State    Queue   Burst_time   waiting   Enterance_time   confidence    consecutive_run\n"
          "----------------------------------------------------------------------------------------\n");

  struct proc *p;
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;

    const char *state;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "unknown state";

    cprintf("%s", p->name);
    space(columns[0] - strlen(p->name));

    cprintf("%d", p->pid);
    space(columns[1] - num_digits(p->pid));

    cprintf("%s", state);
    space(columns[2] - strlen(state));

    cprintf("%d", p->sched_info.level);
    space(columns[3] - num_digits(p->sched_info.level));

    cprintf("%d", (int)p->sched_info.burst_time);
    space(columns[4] - num_digits((int)p->sched_info.burst_time));

    cprintf("%d", ticks - p->sched_info.last_exe_time);
    space(columns[5] - num_digits(ticks - p->sched_info.last_exe_time));

    cprintf("%d", p->sched_info.enter_level_time);
    space(columns[6] - num_digits(p->sched_info.enter_level_time));

    cprintf("%d", (int)p->sched_info.confidence);
    space(columns[7] - num_digits((int)p->sched_info.confidence));

    cprintf("%d", (int)p->sched_info.num_of_cycles);
    space(columns[7] - num_digits((int)p->sched_info.num_of_cycles));
    cprintf("\n");
  }
}

void set_burst_confidence(int pid, int burst, int conf)
{
  struct proc *p = findproc(pid);
  p->sched_info.burst_time = burst;
  p->sched_info.confidence = conf;
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
  return 0;
}

void add_cpu_syscalls(uint my_eax)
{
  if(my_eax == SYS_open)
    mycpu()->count_syscalls += 3;
  if(my_eax == SYS_write)
    mycpu()->count_syscalls += 2;
  else
    mycpu()->count_syscalls += 1;

}

int sum_all_cpus_syscalls()
{
  int count = 0;
  for(int i=0; i<NCPU; i++)
    count += cpus[i].count_syscalls;
  return count;
}