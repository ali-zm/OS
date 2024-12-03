#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    int i=0;
    int flag = 0;
    char *h = "decode";
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
    {
        if(argv[0][i]!=h[i])
        {
            flag = 1;
            break;
        }
        i++;
    }
    if(i!=6)
        flag = 1;
    unlink("result.txt");
    int fd = open("result.txt", O_CREATE | O_RDWR);
    if (flag == 0) //key 2
    {
        for (int i = 1; i < argc; i++)
        {
            int j = 0;
            char arr[sizeof(argv[i])];
            int last = 0;
            while (argv[i][j] != '\0')
            {
                if ((argv[i][j] > 66)&&(argv[i][j] < 91) || (argv[i][j] > 98)&&(argv[i][j] < 123))
                {
                    arr[j] = argv[i][j] - 2;
                }
                else if (argv[i][j] == 65)
                {
                    arr[j] = 'Y';
                }
                else if (argv[i][j] == 66)
                {
                    arr[j] = 'Z';
                }
                else if (argv[i][j] == 97)
                {
                    arr[j] = 'y';
                }
                else if (argv[i][j] == 98)
                {
                    arr[j] = 'z';
                }
                else
                {
                    arr[j] = argv[i][j];
                }
                j++;
                last = j;
            }
            arr[last+1] = '\0';
            write(fd, arr, last);
            char space[2];
            space[0] = ' ';
            space[1] = '\0';
            write(fd, space, 1);
        }
    }
    char arr[2];
    arr[0] = '\n';
    arr[1] = '\0';
    write(fd, arr, 1);
    close(fd);
    exit();
}