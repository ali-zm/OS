#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sharedMemory.h"


struct{
    struct shared_page table[NUM_OF_SHARED_PAGES];
    struct spinlock lock;
} shared_memory;

void
init_sharedmem(){
    acquire(&shared_memory.lock);
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
        shared_memory.table[i].num_of_refs = 0;
    }
    release(&shared_memory.lock);
}

int
find_shared_page(int id){
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
        if (shared_memory.table[i].id == id){
            return i;
        }
    }
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
        if (shared_memory.table[i].num_of_refs == 0){
            shared_memory.table[i].id = id;
            return i;
        }
    }
    return -1;
}

char*
open_sharedmem(int id){
    struct proc* proc = myproc();
    pde_t *pgdir = proc->pgdir;
    if (proc->shmem != 0){
        return 0;
    }
    acquire(&shared_memory.lock);
    int index = find_shared_page(id);
    if (index == -1){
        release(&shared_memory.lock);
        return 0;
    }
    if (shared_memory.table[index].num_of_refs == 0){
        shared_memory.table[index].frame = kalloc();
        memset(shared_memory.table[index].frame, 0, PGSIZE);
    }
    char* start_mem = (char*)PGROUNDUP(proc->sz);
    //cprintf("start_mem: %d\n", start_mem);

    mappages(pgdir, start_mem, PGSIZE, V2P(shared_memory.table[index].frame), PTE_W|PTE_U);
    shared_memory.table[index].num_of_refs++;
    shared_memory.table[index].id = id;
    proc->shmem = start_mem;
    proc->shmem_id = id;

    release(&shared_memory.lock);
    return start_mem;
}

void
close_sharedmem(int id){
    struct proc* proc = myproc();
    pde_t *pgdir = proc->pgdir;
    if (proc->shmem_id != id || proc->shmem_id == 0){
        return;
    }
    acquire(&shared_memory.lock);
    int index = find_shared_page(id);
    shared_memory.table[index].num_of_refs--;

    //delete from proc's page table
    uint a = PGROUNDUP((uint)proc->shmem);
    pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
        a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
        *pte = 0;
    }

    proc->shmem = 0;
    proc->shmem_id = 0;
    
    if (shared_memory.table[index].num_of_refs == 0){
        kfree(shared_memory.table[index].frame);
        
    }

    release(&shared_memory.lock);
}