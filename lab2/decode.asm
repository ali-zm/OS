
_decode:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 28             	sub    $0x28,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 d0             	mov    %eax,-0x30(%ebp)
  19:	8b 41 04             	mov    0x4(%ecx),%eax
    int i=0;
    int flag = 0;
    char *h = "decode";
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  1c:	8b 08                	mov    (%eax),%ecx
{
  1e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  21:	0f b6 01             	movzbl (%ecx),%eax
  24:	84 c0                	test   %al,%al
  26:	74 1f                	je     47 <main+0x47>
  28:	3c 0a                	cmp    $0xa,%al
  2a:	74 1b                	je     47 <main+0x47>
    int i=0;
  2c:	31 d2                	xor    %edx,%edx
  2e:	eb 0f                	jmp    3f <main+0x3f>
        if(argv[0][i]!=h[i])
        {
            flag = 1;
            break;
        }
        i++;
  30:	83 c2 01             	add    $0x1,%edx
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  33:	0f b6 04 11          	movzbl (%ecx,%edx,1),%eax
  37:	84 c0                	test   %al,%al
  39:	74 58                	je     93 <main+0x93>
  3b:	3c 0a                	cmp    $0xa,%al
  3d:	74 54                	je     93 <main+0x93>
        if(argv[0][i]!=h[i])
  3f:	38 82 48 08 00 00    	cmp    %al,0x848(%edx)
  45:	74 e9                	je     30 <main+0x30>
    }
    if(i!=6)
        flag = 1;
    unlink("result.txt");
  47:	83 ec 0c             	sub    $0xc,%esp
  4a:	68 4f 08 00 00       	push   $0x84f
  4f:	e8 ef 03 00 00       	call   443 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  54:	58                   	pop    %eax
  55:	5a                   	pop    %edx
  56:	68 02 02 00 00       	push   $0x202
  5b:	68 4f 08 00 00       	push   $0x84f
  60:	e8 ce 03 00 00       	call   433 <open>
  65:	83 c4 10             	add    $0x10,%esp
  68:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    if (flag == 0) //key 2
  6b:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
            space[1] = '\0';
            write(fd, space, 1);
        }
    }
    char arr[2];
    arr[0] = '\n';
  6e:	be 0a 00 00 00       	mov    $0xa,%esi
    arr[1] = '\0';
    write(fd, arr, 1);
  73:	83 ec 04             	sub    $0x4,%esp
    arr[0] = '\n';
  76:	66 89 75 e4          	mov    %si,-0x1c(%ebp)
    write(fd, arr, 1);
  7a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  7d:	6a 01                	push   $0x1
  7f:	53                   	push   %ebx
  80:	56                   	push   %esi
  81:	e8 8d 03 00 00       	call   413 <write>
    close(fd);
  86:	89 34 24             	mov    %esi,(%esp)
  89:	e8 8d 03 00 00       	call   41b <close>
    exit();
  8e:	e8 60 03 00 00       	call   3f3 <exit>
    if(i!=6)
  93:	83 fa 06             	cmp    $0x6,%edx
  96:	75 af                	jne    47 <main+0x47>
    unlink("result.txt");
  98:	83 ec 0c             	sub    $0xc,%esp
        for (int i = 1; i < argc; i++)
  9b:	be 01 00 00 00       	mov    $0x1,%esi
    unlink("result.txt");
  a0:	68 4f 08 00 00       	push   $0x84f
  a5:	e8 99 03 00 00       	call   443 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  aa:	59                   	pop    %ecx
  ab:	5b                   	pop    %ebx
  ac:	68 02 02 00 00       	push   $0x202
  b1:	68 4f 08 00 00       	push   $0x84f
  b6:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
  b9:	e8 75 03 00 00       	call   433 <open>
        for (int i = 1; i < argc; i++)
  be:	83 c4 10             	add    $0x10,%esp
  c1:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
    int fd = open("result.txt", O_CREATE | O_RDWR);
  c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 1; i < argc; i++)
  c8:	7e a1                	jle    6b <main+0x6b>
            while (argv[i][j] != '\0')
  ca:	8b 45 cc             	mov    -0x34(%ebp),%eax
            int j = 0;
  cd:	31 c9                	xor    %ecx,%ecx
            while (argv[i][j] != '\0')
  cf:	8b 3c b0             	mov    (%eax,%esi,4),%edi
  d2:	0f b6 07             	movzbl (%edi),%eax
  d5:	84 c0                	test   %al,%al
  d7:	0f 84 9d 00 00 00    	je     17a <main+0x17a>
  dd:	8d 76 00             	lea    0x0(%esi),%esi
                if ((argv[i][j] > 66)&&(argv[i][j] < 91) || (argv[i][j] > 98)&&(argv[i][j] < 123))
  e0:	8d 50 bf             	lea    -0x41(%eax),%edx
  e3:	80 fa 39             	cmp    $0x39,%dl
  e6:	77 13                	ja     fb <main+0xfb>
  e8:	0f b6 d2             	movzbl %dl,%edx
  eb:	ff 24 95 64 08 00 00 	jmp    *0x864(,%edx,4)
  f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                    arr[j] = argv[i][j] - 2;
  f8:	83 e8 02             	sub    $0x2,%eax
  fb:	88 04 0b             	mov    %al,(%ebx,%ecx,1)
            while (argv[i][j] != '\0')
  fe:	0f b6 44 0f 01       	movzbl 0x1(%edi,%ecx,1),%eax
                j++;
 103:	8d 51 01             	lea    0x1(%ecx),%edx
            while (argv[i][j] != '\0')
 106:	84 c0                	test   %al,%al
 108:	74 1e                	je     128 <main+0x128>
 10a:	89 d1                	mov    %edx,%ecx
 10c:	eb d2                	jmp    e0 <main+0xe0>
 10e:	66 90                	xchg   %ax,%ax
                    arr[j] = 'z';
 110:	b8 7a 00 00 00       	mov    $0x7a,%eax
                j++;
 115:	8d 51 01             	lea    0x1(%ecx),%edx
                    arr[j] = argv[i][j] - 2;
 118:	88 04 0b             	mov    %al,(%ebx,%ecx,1)
            while (argv[i][j] != '\0')
 11b:	0f b6 44 0f 01       	movzbl 0x1(%edi,%ecx,1),%eax
 120:	84 c0                	test   %al,%al
 122:	75 e6                	jne    10a <main+0x10a>
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            arr[last+1] = '\0';
 128:	83 c1 02             	add    $0x2,%ecx
            write(fd, arr, last);
 12b:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 12e:	83 ec 04             	sub    $0x4,%esp
            arr[last+1] = '\0';
 131:	c6 44 0d e4 00       	movb   $0x0,-0x1c(%ebp,%ecx,1)
        for (int i = 1; i < argc; i++)
 136:	83 c6 01             	add    $0x1,%esi
            write(fd, arr, last);
 139:	52                   	push   %edx
 13a:	53                   	push   %ebx
 13b:	57                   	push   %edi
 13c:	e8 d2 02 00 00       	call   413 <write>
            space[0] = ' ';
 141:	0f b7 05 4c 09 00 00 	movzwl 0x94c,%eax
            write(fd, space, 1);
 148:	83 c4 0c             	add    $0xc,%esp
 14b:	6a 01                	push   $0x1
            space[0] = ' ';
 14d:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
            write(fd, space, 1);
 151:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 154:	50                   	push   %eax
 155:	57                   	push   %edi
 156:	e8 b8 02 00 00       	call   413 <write>
        for (int i = 1; i < argc; i++)
 15b:	83 c4 10             	add    $0x10,%esp
 15e:	39 75 d0             	cmp    %esi,-0x30(%ebp)
 161:	0f 84 07 ff ff ff    	je     6e <main+0x6e>
            while (argv[i][j] != '\0')
 167:	8b 45 cc             	mov    -0x34(%ebp),%eax
            int j = 0;
 16a:	31 c9                	xor    %ecx,%ecx
            while (argv[i][j] != '\0')
 16c:	8b 3c b0             	mov    (%eax,%esi,4),%edi
 16f:	0f b6 07             	movzbl (%edi),%eax
 172:	84 c0                	test   %al,%al
 174:	0f 85 66 ff ff ff    	jne    e0 <main+0xe0>
 17a:	b9 01 00 00 00       	mov    $0x1,%ecx
            int j = 0;
 17f:	31 d2                	xor    %edx,%edx
 181:	eb a8                	jmp    12b <main+0x12b>
 183:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                    arr[j] = 'y';
 188:	b8 79 00 00 00       	mov    $0x79,%eax
 18d:	e9 69 ff ff ff       	jmp    fb <main+0xfb>
            int j = 0;
 192:	b8 59 00 00 00       	mov    $0x59,%eax
 197:	e9 5f ff ff ff       	jmp    fb <main+0xfb>
 19c:	b8 5a 00 00 00       	mov    $0x5a,%eax
 1a1:	e9 55 ff ff ff       	jmp    fb <main+0xfb>
 1a6:	66 90                	xchg   %ax,%ax
 1a8:	66 90                	xchg   %ax,%ax
 1aa:	66 90                	xchg   %ax,%ax
 1ac:	66 90                	xchg   %ax,%ax
 1ae:	66 90                	xchg   %ax,%ax

000001b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1b0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b1:	31 c0                	xor    %eax,%eax
{
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	53                   	push   %ebx
 1b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1c0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1c4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1c7:	83 c0 01             	add    $0x1,%eax
 1ca:	84 d2                	test   %dl,%dl
 1cc:	75 f2                	jne    1c0 <strcpy+0x10>
    ;
  return os;
}
 1ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1d1:	89 c8                	mov    %ecx,%eax
 1d3:	c9                   	leave
 1d4:	c3                   	ret
 1d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1dc:	00 
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
 1e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ea:	0f b6 02             	movzbl (%edx),%eax
 1ed:	84 c0                	test   %al,%al
 1ef:	75 17                	jne    208 <strcmp+0x28>
 1f1:	eb 3a                	jmp    22d <strcmp+0x4d>
 1f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1fc:	83 c2 01             	add    $0x1,%edx
 1ff:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 202:	84 c0                	test   %al,%al
 204:	74 1a                	je     220 <strcmp+0x40>
 206:	89 d9                	mov    %ebx,%ecx
 208:	0f b6 19             	movzbl (%ecx),%ebx
 20b:	38 c3                	cmp    %al,%bl
 20d:	74 e9                	je     1f8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 20f:	29 d8                	sub    %ebx,%eax
}
 211:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 214:	c9                   	leave
 215:	c3                   	ret
 216:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21d:	00 
 21e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 220:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 224:	31 c0                	xor    %eax,%eax
 226:	29 d8                	sub    %ebx,%eax
}
 228:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 22b:	c9                   	leave
 22c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 22d:	0f b6 19             	movzbl (%ecx),%ebx
 230:	31 c0                	xor    %eax,%eax
 232:	eb db                	jmp    20f <strcmp+0x2f>
 234:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23b:	00 
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <strlen>:

uint
strlen(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 246:	80 3a 00             	cmpb   $0x0,(%edx)
 249:	74 15                	je     260 <strlen+0x20>
 24b:	31 c0                	xor    %eax,%eax
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	83 c0 01             	add    $0x1,%eax
 253:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 257:	89 c1                	mov    %eax,%ecx
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	89 c8                	mov    %ecx,%eax
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret
 25f:	90                   	nop
  for(n = 0; s[n]; n++)
 260:	31 c9                	xor    %ecx,%ecx
}
 262:	5d                   	pop    %ebp
 263:	89 c8                	mov    %ecx,%eax
 265:	c3                   	ret
 266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26d:	00 
 26e:	66 90                	xchg   %ax,%ax

00000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 277:	8b 4d 10             	mov    0x10(%ebp),%ecx
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 d7                	mov    %edx,%edi
 27f:	fc                   	cld
 280:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 282:	8b 7d fc             	mov    -0x4(%ebp),%edi
 285:	89 d0                	mov    %edx,%eax
 287:	c9                   	leave
 288:	c3                   	ret
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 29a:	0f b6 10             	movzbl (%eax),%edx
 29d:	84 d2                	test   %dl,%dl
 29f:	75 12                	jne    2b3 <strchr+0x23>
 2a1:	eb 1d                	jmp    2c0 <strchr+0x30>
 2a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2ac:	83 c0 01             	add    $0x1,%eax
 2af:	84 d2                	test   %dl,%dl
 2b1:	74 0d                	je     2c0 <strchr+0x30>
    if(*s == c)
 2b3:	38 d1                	cmp    %dl,%cl
 2b5:	75 f1                	jne    2a8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2b7:	5d                   	pop    %ebp
 2b8:	c3                   	ret
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2c0:	31 c0                	xor    %eax,%eax
}
 2c2:	5d                   	pop    %ebp
 2c3:	c3                   	ret
 2c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cb:	00 
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2d5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2d8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2d9:	31 db                	xor    %ebx,%ebx
{
 2db:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2de:	eb 27                	jmp    307 <gets+0x37>
    cc = read(0, &c, 1);
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	6a 01                	push   $0x1
 2e5:	56                   	push   %esi
 2e6:	6a 00                	push   $0x0
 2e8:	e8 1e 01 00 00       	call   40b <read>
    if(cc < 1)
 2ed:	83 c4 10             	add    $0x10,%esp
 2f0:	85 c0                	test   %eax,%eax
 2f2:	7e 1d                	jle    311 <gets+0x41>
      break;
    buf[i++] = c;
 2f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2f8:	8b 55 08             	mov    0x8(%ebp),%edx
 2fb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2ff:	3c 0a                	cmp    $0xa,%al
 301:	74 10                	je     313 <gets+0x43>
 303:	3c 0d                	cmp    $0xd,%al
 305:	74 0c                	je     313 <gets+0x43>
  for(i=0; i+1 < max; ){
 307:	89 df                	mov    %ebx,%edi
 309:	83 c3 01             	add    $0x1,%ebx
 30c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 30f:	7c cf                	jl     2e0 <gets+0x10>
 311:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 31a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31d:	5b                   	pop    %ebx
 31e:	5e                   	pop    %esi
 31f:	5f                   	pop    %edi
 320:	5d                   	pop    %ebp
 321:	c3                   	ret
 322:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 329:	00 
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <stat>:

int
stat(const char *n, struct stat *st)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 335:	83 ec 08             	sub    $0x8,%esp
 338:	6a 00                	push   $0x0
 33a:	ff 75 08             	push   0x8(%ebp)
 33d:	e8 f1 00 00 00       	call   433 <open>
  if(fd < 0)
 342:	83 c4 10             	add    $0x10,%esp
 345:	85 c0                	test   %eax,%eax
 347:	78 27                	js     370 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	ff 75 0c             	push   0xc(%ebp)
 34f:	89 c3                	mov    %eax,%ebx
 351:	50                   	push   %eax
 352:	e8 f4 00 00 00       	call   44b <fstat>
  close(fd);
 357:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 35a:	89 c6                	mov    %eax,%esi
  close(fd);
 35c:	e8 ba 00 00 00       	call   41b <close>
  return r;
 361:	83 c4 10             	add    $0x10,%esp
}
 364:	8d 65 f8             	lea    -0x8(%ebp),%esp
 367:	89 f0                	mov    %esi,%eax
 369:	5b                   	pop    %ebx
 36a:	5e                   	pop    %esi
 36b:	5d                   	pop    %ebp
 36c:	c3                   	ret
 36d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 370:	be ff ff ff ff       	mov    $0xffffffff,%esi
 375:	eb ed                	jmp    364 <stat+0x34>
 377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37e:	00 
 37f:	90                   	nop

00000380 <atoi>:

int
atoi(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	53                   	push   %ebx
 384:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 387:	0f be 02             	movsbl (%edx),%eax
 38a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 38d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 390:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 395:	77 1e                	ja     3b5 <atoi+0x35>
 397:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39e:	00 
 39f:	90                   	nop
    n = n*10 + *s++ - '0';
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3aa:	0f be 02             	movsbl (%edx),%eax
 3ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
  return n;
}
 3b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3b8:	89 c8                	mov    %ecx,%eax
 3ba:	c9                   	leave
 3bb:	c3                   	ret
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	8b 45 10             	mov    0x10(%ebp),%eax
 3c7:	8b 55 08             	mov    0x8(%ebp),%edx
 3ca:	56                   	push   %esi
 3cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ce:	85 c0                	test   %eax,%eax
 3d0:	7e 13                	jle    3e5 <memmove+0x25>
 3d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3d4:	89 d7                	mov    %edx,%edi
 3d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3dd:	00 
 3de:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 3e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3e1:	39 f8                	cmp    %edi,%eax
 3e3:	75 fb                	jne    3e0 <memmove+0x20>
  return vdst;
}
 3e5:	5e                   	pop    %esi
 3e6:	89 d0                	mov    %edx,%eax
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret

000003eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <exit>:
SYSCALL(exit)
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <wait>:
SYSCALL(wait)
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <pipe>:
SYSCALL(pipe)
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <read>:
SYSCALL(read)
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <write>:
SYSCALL(write)
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <close>:
SYSCALL(close)
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <kill>:
SYSCALL(kill)
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <exec>:
SYSCALL(exec)
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <open>:
SYSCALL(open)
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mknod>:
SYSCALL(mknod)
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <unlink>:
SYSCALL(unlink)
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <fstat>:
SYSCALL(fstat)
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <link>:
SYSCALL(link)
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <mkdir>:
SYSCALL(mkdir)
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <chdir>:
SYSCALL(chdir)
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <dup>:
SYSCALL(dup)
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <getpid>:
SYSCALL(getpid)
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <sbrk>:
SYSCALL(sbrk)
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <sleep>:
SYSCALL(sleep)
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <uptime>:
SYSCALL(uptime)
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <move_file>:
SYSCALL(move_file)
 493:	b8 17 00 00 00       	mov    $0x17,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret
 49b:	66 90                	xchg   %ax,%ax
 49d:	66 90                	xchg   %ax,%ax
 49f:	90                   	nop

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4a8:	89 d1                	mov    %edx,%ecx
{
 4aa:	83 ec 3c             	sub    $0x3c,%esp
 4ad:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 4b0:	85 d2                	test   %edx,%edx
 4b2:	0f 89 80 00 00 00    	jns    538 <printint+0x98>
 4b8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4bc:	74 7a                	je     538 <printint+0x98>
    x = -xx;
 4be:	f7 d9                	neg    %ecx
    neg = 1;
 4c0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4c5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4c8:	31 f6                	xor    %esi,%esi
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4d0:	89 c8                	mov    %ecx,%eax
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	89 f7                	mov    %esi,%edi
 4d6:	f7 f3                	div    %ebx
 4d8:	8d 76 01             	lea    0x1(%esi),%esi
 4db:	0f b6 92 a8 09 00 00 	movzbl 0x9a8(%edx),%edx
 4e2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4e6:	89 ca                	mov    %ecx,%edx
 4e8:	89 c1                	mov    %eax,%ecx
 4ea:	39 da                	cmp    %ebx,%edx
 4ec:	73 e2                	jae    4d0 <printint+0x30>
  if(neg)
 4ee:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4f1:	85 c0                	test   %eax,%eax
 4f3:	74 07                	je     4fc <printint+0x5c>
    buf[i++] = '-';
 4f5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 4fa:	89 f7                	mov    %esi,%edi
 4fc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4ff:	8b 75 c0             	mov    -0x40(%ebp),%esi
 502:	01 df                	add    %ebx,%edi
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 508:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 50b:	83 ec 04             	sub    $0x4,%esp
 50e:	88 45 d7             	mov    %al,-0x29(%ebp)
 511:	8d 45 d7             	lea    -0x29(%ebp),%eax
 514:	6a 01                	push   $0x1
 516:	50                   	push   %eax
 517:	56                   	push   %esi
 518:	e8 f6 fe ff ff       	call   413 <write>
  while(--i >= 0)
 51d:	89 f8                	mov    %edi,%eax
 51f:	83 c4 10             	add    $0x10,%esp
 522:	83 ef 01             	sub    $0x1,%edi
 525:	39 c3                	cmp    %eax,%ebx
 527:	75 df                	jne    508 <printint+0x68>
}
 529:	8d 65 f4             	lea    -0xc(%ebp),%esp
 52c:	5b                   	pop    %ebx
 52d:	5e                   	pop    %esi
 52e:	5f                   	pop    %edi
 52f:	5d                   	pop    %ebp
 530:	c3                   	ret
 531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 538:	31 c0                	xor    %eax,%eax
 53a:	eb 89                	jmp    4c5 <printint+0x25>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 54c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 54f:	0f b6 1e             	movzbl (%esi),%ebx
 552:	83 c6 01             	add    $0x1,%esi
 555:	84 db                	test   %bl,%bl
 557:	74 67                	je     5c0 <printf+0x80>
 559:	8d 4d 10             	lea    0x10(%ebp),%ecx
 55c:	31 d2                	xor    %edx,%edx
 55e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 561:	eb 34                	jmp    597 <printf+0x57>
 563:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 568:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 56b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 570:	83 f8 25             	cmp    $0x25,%eax
 573:	74 18                	je     58d <printf+0x4d>
  write(fd, &c, 1);
 575:	83 ec 04             	sub    $0x4,%esp
 578:	8d 45 e7             	lea    -0x19(%ebp),%eax
 57b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 57e:	6a 01                	push   $0x1
 580:	50                   	push   %eax
 581:	57                   	push   %edi
 582:	e8 8c fe ff ff       	call   413 <write>
 587:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 58a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 58d:	0f b6 1e             	movzbl (%esi),%ebx
 590:	83 c6 01             	add    $0x1,%esi
 593:	84 db                	test   %bl,%bl
 595:	74 29                	je     5c0 <printf+0x80>
    c = fmt[i] & 0xff;
 597:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 59a:	85 d2                	test   %edx,%edx
 59c:	74 ca                	je     568 <printf+0x28>
      }
    } else if(state == '%'){
 59e:	83 fa 25             	cmp    $0x25,%edx
 5a1:	75 ea                	jne    58d <printf+0x4d>
      if(c == 'd'){
 5a3:	83 f8 25             	cmp    $0x25,%eax
 5a6:	0f 84 04 01 00 00    	je     6b0 <printf+0x170>
 5ac:	83 e8 63             	sub    $0x63,%eax
 5af:	83 f8 15             	cmp    $0x15,%eax
 5b2:	77 1c                	ja     5d0 <printf+0x90>
 5b4:	ff 24 85 50 09 00 00 	jmp    *0x950(,%eax,4)
 5bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret
 5c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cf:	00 
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5d6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5da:	6a 01                	push   $0x1
 5dc:	52                   	push   %edx
 5dd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5e0:	57                   	push   %edi
 5e1:	e8 2d fe ff ff       	call   413 <write>
 5e6:	83 c4 0c             	add    $0xc,%esp
 5e9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5ec:	6a 01                	push   $0x1
 5ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5f1:	52                   	push   %edx
 5f2:	57                   	push   %edi
 5f3:	e8 1b fe ff ff       	call   413 <write>
        putc(fd, c);
 5f8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5fb:	31 d2                	xor    %edx,%edx
 5fd:	eb 8e                	jmp    58d <printf+0x4d>
 5ff:	90                   	nop
        printint(fd, *ap, 16, 0);
 600:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 603:	83 ec 0c             	sub    $0xc,%esp
 606:	b9 10 00 00 00       	mov    $0x10,%ecx
 60b:	8b 13                	mov    (%ebx),%edx
 60d:	6a 00                	push   $0x0
 60f:	89 f8                	mov    %edi,%eax
        ap++;
 611:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 614:	e8 87 fe ff ff       	call   4a0 <printint>
        ap++;
 619:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 61c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 61f:	31 d2                	xor    %edx,%edx
 621:	e9 67 ff ff ff       	jmp    58d <printf+0x4d>
        s = (char*)*ap;
 626:	8b 45 d0             	mov    -0x30(%ebp),%eax
 629:	8b 18                	mov    (%eax),%ebx
        ap++;
 62b:	83 c0 04             	add    $0x4,%eax
 62e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 631:	85 db                	test   %ebx,%ebx
 633:	0f 84 87 00 00 00    	je     6c0 <printf+0x180>
        while(*s != 0){
 639:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 63c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 63e:	84 c0                	test   %al,%al
 640:	0f 84 47 ff ff ff    	je     58d <printf+0x4d>
 646:	8d 55 e7             	lea    -0x19(%ebp),%edx
 649:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64c:	89 de                	mov    %ebx,%esi
 64e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 656:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 659:	6a 01                	push   $0x1
 65b:	53                   	push   %ebx
 65c:	57                   	push   %edi
 65d:	e8 b1 fd ff ff       	call   413 <write>
        while(*s != 0){
 662:	0f b6 06             	movzbl (%esi),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x110>
      state = 0;
 66c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 17 ff ff ff       	jmp    58d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 676:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 679:	83 ec 0c             	sub    $0xc,%esp
 67c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 681:	8b 13                	mov    (%ebx),%edx
 683:	6a 01                	push   $0x1
 685:	eb 88                	jmp    60f <printf+0xcf>
        putc(fd, *ap);
 687:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 68a:	83 ec 04             	sub    $0x4,%esp
 68d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 690:	8b 03                	mov    (%ebx),%eax
        ap++;
 692:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 695:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 698:	6a 01                	push   $0x1
 69a:	52                   	push   %edx
 69b:	57                   	push   %edi
 69c:	e8 72 fd ff ff       	call   413 <write>
        ap++;
 6a1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6a4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6a7:	31 d2                	xor    %edx,%edx
 6a9:	e9 df fe ff ff       	jmp    58d <printf+0x4d>
 6ae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6b6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6b9:	6a 01                	push   $0x1
 6bb:	e9 31 ff ff ff       	jmp    5f1 <printf+0xb1>
 6c0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6c5:	bb 5a 08 00 00       	mov    $0x85a,%ebx
 6ca:	e9 77 ff ff ff       	jmp    646 <printf+0x106>
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 50 0c 00 00       	mov    0xc50,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	39 c8                	cmp    %ecx,%eax
 6ec:	73 32                	jae    720 <free+0x50>
 6ee:	39 d1                	cmp    %edx,%ecx
 6f0:	72 04                	jb     6f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f2:	39 d0                	cmp    %edx,%eax
 6f4:	72 32                	jb     728 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fc:	39 fa                	cmp    %edi,%edx
 6fe:	74 30                	je     730 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 700:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 703:	8b 50 04             	mov    0x4(%eax),%edx
 706:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 709:	39 f1                	cmp    %esi,%ecx
 70b:	74 3a                	je     747 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 70d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 70f:	5b                   	pop    %ebx
  freep = p;
 710:	a3 50 0c 00 00       	mov    %eax,0xc50
}
 715:	5e                   	pop    %esi
 716:	5f                   	pop    %edi
 717:	5d                   	pop    %ebp
 718:	c3                   	ret
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	39 d0                	cmp    %edx,%eax
 722:	72 04                	jb     728 <free+0x58>
 724:	39 d1                	cmp    %edx,%ecx
 726:	72 ce                	jb     6f6 <free+0x26>
{
 728:	89 d0                	mov    %edx,%eax
 72a:	eb bc                	jmp    6e8 <free+0x18>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 730:	03 72 04             	add    0x4(%edx),%esi
 733:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 736:	8b 10                	mov    (%eax),%edx
 738:	8b 12                	mov    (%edx),%edx
 73a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 73d:	8b 50 04             	mov    0x4(%eax),%edx
 740:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	75 c6                	jne    70d <free+0x3d>
    p->s.size += bp->s.size;
 747:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 74a:	a3 50 0c 00 00       	mov    %eax,0xc50
    p->s.size += bp->s.size;
 74f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 752:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 755:	89 08                	mov    %ecx,(%eax)
}
 757:	5b                   	pop    %ebx
 758:	5e                   	pop    %esi
 759:	5f                   	pop    %edi
 75a:	5d                   	pop    %ebp
 75b:	c3                   	ret
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 50 0c 00 00    	mov    0xc50,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 8d 00 00 00    	je     810 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 785:	8b 48 04             	mov    0x4(%eax),%ecx
 788:	39 f9                	cmp    %edi,%ecx
 78a:	73 64                	jae    7f0 <malloc+0x90>
  if(nu < 4096)
 78c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 791:	39 df                	cmp    %ebx,%edi
 793:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 796:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 79d:	eb 0a                	jmp    7a9 <malloc+0x49>
 79f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 48 04             	mov    0x4(%eax),%ecx
 7a5:	39 f9                	cmp    %edi,%ecx
 7a7:	73 47                	jae    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a9:	89 c2                	mov    %eax,%edx
 7ab:	3b 05 50 0c 00 00    	cmp    0xc50,%eax
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7b3:	83 ec 0c             	sub    $0xc,%esp
 7b6:	56                   	push   %esi
 7b7:	e8 bf fc ff ff       	call   47b <sbrk>
  if(p == (char*)-1)
 7bc:	83 c4 10             	add    $0x10,%esp
 7bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c2:	74 1c                	je     7e0 <malloc+0x80>
  hp->s.size = nu;
 7c4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7c7:	83 ec 0c             	sub    $0xc,%esp
 7ca:	83 c0 08             	add    $0x8,%eax
 7cd:	50                   	push   %eax
 7ce:	e8 fd fe ff ff       	call   6d0 <free>
  return freep;
 7d3:	8b 15 50 0c 00 00    	mov    0xc50,%edx
      if((p = morecore(nunits)) == 0)
 7d9:	83 c4 10             	add    $0x10,%esp
 7dc:	85 d2                	test   %edx,%edx
 7de:	75 c0                	jne    7a0 <malloc+0x40>
        return 0;
  }
}
 7e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e3:	31 c0                	xor    %eax,%eax
}
 7e5:	5b                   	pop    %ebx
 7e6:	5e                   	pop    %esi
 7e7:	5f                   	pop    %edi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 4c                	je     840 <malloc+0xe0>
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ff:	89 15 50 0c 00 00    	mov    %edx,0xc50
}
 805:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 808:	83 c0 08             	add    $0x8,%eax
}
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 810:	c7 05 50 0c 00 00 54 	movl   $0xc54,0xc50
 817:	0c 00 00 
    base.s.size = 0;
 81a:	b8 54 0c 00 00       	mov    $0xc54,%eax
    base.s.ptr = freep = prevp = &base;
 81f:	c7 05 54 0c 00 00 54 	movl   $0xc54,0xc54
 826:	0c 00 00 
    base.s.size = 0;
 829:	c7 05 58 0c 00 00 00 	movl   $0x0,0xc58
 830:	00 00 00 
    if(p->s.size >= nunits){
 833:	e9 54 ff ff ff       	jmp    78c <malloc+0x2c>
 838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83f:	00 
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b9                	jmp    7ff <malloc+0x9f>
