

#include "types.h"
#include "user.h"
#include "stat.h"


#define PROCS_NUM 5

void test()
{
    int count = 0;
    while(count<100000000) //for test FCFS and sjf and multilevel
    {
        count++;
        printf(1,"");
    }
    count = 0;
    // while(count<100000000000000) //for test round_robin
    // {
    //     count++;
    //     printf(1,"");
    // }

}

int main()
{
    for (int i = 0; i < PROCS_NUM; ++i)
    {
        int pid = fork();
        // if(pid==6)  //check SJF
        //     set_burst_confidence(pid,1,99);
        // if(pid==7)  //check SJF note : change all procresses confidence to 99 so burst time will show itself
        //     set_burst_confidence(pid,3,99);
        if(pid==6)  //check multilevel time slicing
            set_level(pid,0);

        if (pid == 0)
        {
            
            test();
            exit();
        }
    }
    show_process_info();
    for (int i = 0; i < PROCS_NUM; i++)
        wait();
    show_process_info();
    exit();
}