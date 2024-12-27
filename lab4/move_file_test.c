#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf(2, "Error: Incorrect arguments\n");
        exit();
    }
    int a = move_file(argv[1], argv[2]);
    if (a == -1)
        printf(2, "Not successful\n");
    exit();
}