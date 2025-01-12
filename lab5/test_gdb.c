#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
    printf(1,"getting pid...\n");
    int pid = getpid();
    printf(1,"pid:%d", pid);
    exit();
}