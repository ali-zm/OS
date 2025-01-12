#include "user.h"
#include "types.h"
#include "stat.h"
// #include "defs.h"

int main()
{
    int num = 5;
    for(int i = 0; i < 5; i ++)
    {
        int pid = fork();
        if(!pid)
        {
            test_reentrantlock(num);
            exit();
        }
        printf(1, "xxx %d\n", pid);
    } 
    for(int i = 0; i < 5; i ++)
        wait();
    printf(1, "DONE\n");
}