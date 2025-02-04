#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    int i=0;
    int flag = 0;
    char *h = "encode";
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
                if ((argv[i][j] > 64)&&(argv[i][j] < 89) || (argv[i][j] > 96)&&(argv[i][j] < 121))
                {
                    arr[j] = argv[i][j] + 2;
                }
                else if (argv[i][j] == 89)
                {
                    arr[j] = 'A';
                }
                else if (argv[i][j] == 90)
                {
                    arr[j] = 'B';
                }
                else if (argv[i][j] == 121)
                {
                    arr[j] = 'a';
                }
                else if (argv[i][j] == 122)
                {
                    arr[j] = 'b';
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