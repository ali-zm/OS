
_encode:     file format elf32-i386


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
    char *h = "encode";
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  1c:	8b 18                	mov    (%eax),%ebx
{
  1e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  21:	0f b6 03             	movzbl (%ebx),%eax
  24:	3c 0a                	cmp    $0xa,%al
  26:	74 2a                	je     52 <main+0x52>
  28:	84 c0                	test   %al,%al
  2a:	74 26                	je     52 <main+0x52>
  2c:	b9 65 00 00 00       	mov    $0x65,%ecx
    int i=0;
  31:	31 d2                	xor    %edx,%edx
  33:	eb 19                	jmp    4e <main+0x4e>
  35:	8d 76 00             	lea    0x0(%esi),%esi
        if(argv[0][i]!=h[i])
        {
            flag = 1;
            break;
        }
        i++;
  38:	83 c2 01             	add    $0x1,%edx
    while (argv[0][i]!='\0' && argv[0][i]!='\n')
  3b:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
  3f:	84 c0                	test   %al,%al
  41:	74 5b                	je     9e <main+0x9e>
  43:	3c 0a                	cmp    $0xa,%al
  45:	74 57                	je     9e <main+0x9e>
        if(argv[0][i]!=h[i])
  47:	0f b6 8a 08 09 00 00 	movzbl 0x908(%edx),%ecx
  4e:	38 c1                	cmp    %al,%cl
  50:	74 e6                	je     38 <main+0x38>
    }
    if(i!=6)
        flag = 1;
    unlink("result.txt");
  52:	83 ec 0c             	sub    $0xc,%esp
  55:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
  58:	68 0f 09 00 00       	push   $0x90f
  5d:	e8 21 04 00 00       	call   483 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  62:	58                   	pop    %eax
  63:	5a                   	pop    %edx
  64:	68 02 02 00 00       	push   $0x202
  69:	68 0f 09 00 00       	push   $0x90f
  6e:	e8 00 04 00 00       	call   473 <open>
  73:	83 c4 10             	add    $0x10,%esp
  76:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        }
    }
    char arr[2];
    arr[0] = '\n';
    arr[1] = '\0';
    write(fd, arr, 1);
  79:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  7c:	83 ec 04             	sub    $0x4,%esp
    arr[0] = '\n';
  7f:	b9 0a 00 00 00       	mov    $0xa,%ecx
    write(fd, arr, 1);
  84:	6a 01                	push   $0x1
  86:	53                   	push   %ebx
  87:	56                   	push   %esi
    arr[0] = '\n';
  88:	66 89 4d e4          	mov    %cx,-0x1c(%ebp)
    write(fd, arr, 1);
  8c:	e8 c2 03 00 00       	call   453 <write>
    close(fd);
  91:	89 34 24             	mov    %esi,(%esp)
  94:	e8 c2 03 00 00       	call   45b <close>
    exit();
  99:	e8 95 03 00 00       	call   433 <exit>
    if(i!=6)
  9e:	83 fa 06             	cmp    $0x6,%edx
  a1:	75 af                	jne    52 <main+0x52>
    unlink("result.txt");
  a3:	83 ec 0c             	sub    $0xc,%esp
  a6:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
  a9:	68 0f 09 00 00       	push   $0x90f
  ae:	e8 d0 03 00 00       	call   483 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  b3:	58                   	pop    %eax
  b4:	5a                   	pop    %edx
  b5:	68 02 02 00 00       	push   $0x202
  ba:	68 0f 09 00 00       	push   $0x90f
  bf:	e8 af 03 00 00       	call   473 <open>
        for (int i = 1; i < argc; i++)
  c4:	83 c4 10             	add    $0x10,%esp
  c7:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
    int fd = open("result.txt", O_CREATE | O_RDWR);
  cb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 1; i < argc; i++)
  ce:	7e a9                	jle    79 <main+0x79>
            while (argv[i][j] != '\0')
  d0:	8b 45 cc             	mov    -0x34(%ebp),%eax
        for (int i = 1; i < argc; i++)
  d3:	be 01 00 00 00       	mov    $0x1,%esi
            while (argv[i][j] != '\0')
  d8:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
            int j = 0;
  db:	31 d2                	xor    %edx,%edx
            while (argv[i][j] != '\0')
  dd:	8b 3c b0             	mov    (%eax,%esi,4),%edi
  e0:	0f b6 07             	movzbl (%edi),%eax
  e3:	84 c0                	test   %al,%al
  e5:	0f 84 b5 00 00 00    	je     1a0 <main+0x1a0>
  eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop
                if ((argv[i][j] > 64)&&(argv[i][j] < 89) || (argv[i][j] > 96)&&(argv[i][j] < 121))
  f0:	89 c1                	mov    %eax,%ecx
  f2:	83 e1 df             	and    $0xffffffdf,%ecx
  f5:	83 e9 41             	sub    $0x41,%ecx
  f8:	80 f9 17             	cmp    $0x17,%cl
  fb:	77 21                	ja     11e <main+0x11e>
                    arr[j] = argv[i][j] + 2;
  fd:	83 c0 02             	add    $0x2,%eax
 100:	88 04 13             	mov    %al,(%ebx,%edx,1)
            while (argv[i][j] != '\0')
 103:	0f b6 44 17 01       	movzbl 0x1(%edi,%edx,1),%eax
                j++;
 108:	8d 4a 01             	lea    0x1(%edx),%ecx
            while (argv[i][j] != '\0')
 10b:	84 c0                	test   %al,%al
 10d:	74 41                	je     150 <main+0x150>
                j++;
 10f:	89 ca                	mov    %ecx,%edx
                if ((argv[i][j] > 64)&&(argv[i][j] < 89) || (argv[i][j] > 96)&&(argv[i][j] < 121))
 111:	89 c1                	mov    %eax,%ecx
 113:	83 e1 df             	and    $0xffffffdf,%ecx
 116:	83 e9 41             	sub    $0x41,%ecx
 119:	80 f9 17             	cmp    $0x17,%cl
 11c:	76 df                	jbe    fd <main+0xfd>
                else if (argv[i][j] == 89)
 11e:	3c 59                	cmp    $0x59,%al
 120:	0f 84 8a 00 00 00    	je     1b0 <main+0x1b0>
                else if (argv[i][j] == 90)
 126:	3c 5a                	cmp    $0x5a,%al
 128:	0f 84 92 00 00 00    	je     1c0 <main+0x1c0>
                else if (argv[i][j] == 121)
 12e:	3c 79                	cmp    $0x79,%al
 130:	0f 84 9a 00 00 00    	je     1d0 <main+0x1d0>
                else if (argv[i][j] == 122)
 136:	b9 62 00 00 00       	mov    $0x62,%ecx
 13b:	3c 7a                	cmp    $0x7a,%al
 13d:	0f 44 c1             	cmove  %ecx,%eax
                j++;
 140:	8d 4a 01             	lea    0x1(%edx),%ecx
                    arr[j] = argv[i][j] + 2;
 143:	88 04 13             	mov    %al,(%ebx,%edx,1)
            while (argv[i][j] != '\0')
 146:	0f b6 44 17 01       	movzbl 0x1(%edi,%edx,1),%eax
 14b:	84 c0                	test   %al,%al
 14d:	75 c0                	jne    10f <main+0x10f>
 14f:	90                   	nop
            arr[last+1] = '\0';
 150:	83 c2 02             	add    $0x2,%edx
            write(fd, arr, last);
 153:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 156:	83 ec 04             	sub    $0x4,%esp
            arr[last+1] = '\0';
 159:	c6 44 15 e4 00       	movb   $0x0,-0x1c(%ebp,%edx,1)
        for (int i = 1; i < argc; i++)
 15e:	83 c6 01             	add    $0x1,%esi
            write(fd, arr, last);
 161:	51                   	push   %ecx
 162:	53                   	push   %ebx
 163:	57                   	push   %edi
 164:	e8 ea 02 00 00       	call   453 <write>
            space[0] = ' ';
 169:	b8 20 00 00 00       	mov    $0x20,%eax
            write(fd, space, 1);
 16e:	83 c4 0c             	add    $0xc,%esp
            space[0] = ' ';
 171:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
            write(fd, space, 1);
 175:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 178:	6a 01                	push   $0x1
 17a:	50                   	push   %eax
 17b:	57                   	push   %edi
 17c:	e8 d2 02 00 00       	call   453 <write>
        for (int i = 1; i < argc; i++)
 181:	83 c4 10             	add    $0x10,%esp
 184:	39 75 d0             	cmp    %esi,-0x30(%ebp)
 187:	0f 84 ec fe ff ff    	je     79 <main+0x79>
            while (argv[i][j] != '\0')
 18d:	8b 45 cc             	mov    -0x34(%ebp),%eax
            int j = 0;
 190:	31 d2                	xor    %edx,%edx
            while (argv[i][j] != '\0')
 192:	8b 3c b0             	mov    (%eax,%esi,4),%edi
 195:	0f b6 07             	movzbl (%edi),%eax
 198:	84 c0                	test   %al,%al
 19a:	0f 85 50 ff ff ff    	jne    f0 <main+0xf0>
 1a0:	ba 01 00 00 00       	mov    $0x1,%edx
            int j = 0;
 1a5:	31 c9                	xor    %ecx,%ecx
 1a7:	eb aa                	jmp    153 <main+0x153>
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	b8 41 00 00 00       	mov    $0x41,%eax
 1b5:	e9 46 ff ff ff       	jmp    100 <main+0x100>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	b8 42 00 00 00       	mov    $0x42,%eax
 1c5:	e9 36 ff ff ff       	jmp    100 <main+0x100>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	b8 61 00 00 00       	mov    $0x61,%eax
 1d5:	e9 26 ff ff ff       	jmp    100 <main+0x100>
 1da:	66 90                	xchg   %ax,%ax
 1dc:	66 90                	xchg   %ax,%ax
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	53                   	push   %ebx
 1e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 1fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 201:	89 c8                	mov    %ecx,%eax
 203:	c9                   	leave  
 204:	c3                   	ret    
 205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 17                	jne    238 <strcmp+0x28>
 221:	eb 3a                	jmp    25d <strcmp+0x4d>
 223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 227:	90                   	nop
 228:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 22c:	83 c2 01             	add    $0x1,%edx
 22f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 232:	84 c0                	test   %al,%al
 234:	74 1a                	je     250 <strcmp+0x40>
    p++, q++;
 236:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 238:	0f b6 19             	movzbl (%ecx),%ebx
 23b:	38 c3                	cmp    %al,%bl
 23d:	74 e9                	je     228 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 23f:	29 d8                	sub    %ebx,%eax
}
 241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 244:	c9                   	leave  
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 250:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 254:	31 c0                	xor    %eax,%eax
 256:	29 d8                	sub    %ebx,%eax
}
 258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 25b:	c9                   	leave  
 25c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <strcmp+0x2f>
 264:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop

00000270 <strlen>:

uint
strlen(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 276:	80 3a 00             	cmpb   $0x0,(%edx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 c0                	xor    %eax,%eax
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c0 01             	add    $0x1,%eax
 283:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 287:	89 c1                	mov    %eax,%ecx
 289:	75 f5                	jne    280 <strlen+0x10>
    ;
  return n;
}
 28b:	89 c8                	mov    %ecx,%eax
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret    
 28f:	90                   	nop
  for(n = 0; s[n]; n++)
 290:	31 c9                	xor    %ecx,%ecx
}
 292:	5d                   	pop    %ebp
 293:	89 c8                	mov    %ecx,%eax
 295:	c3                   	ret    
 296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29d:	8d 76 00             	lea    0x0(%esi),%esi

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld    
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	c9                   	leave  
 2b8:	c3                   	ret    
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ca:	0f b6 10             	movzbl (%eax),%edx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	75 12                	jne    2e3 <strchr+0x23>
 2d1:	eb 1d                	jmp    2f0 <strchr+0x30>
 2d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d7:	90                   	nop
 2d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2dc:	83 c0 01             	add    $0x1,%eax
 2df:	84 d2                	test   %dl,%dl
 2e1:	74 0d                	je     2f0 <strchr+0x30>
    if(*s == c)
 2e3:	38 d1                	cmp    %dl,%cl
 2e5:	75 f1                	jne    2d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2f0:	31 c0                	xor    %eax,%eax
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop

00000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 305:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 308:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 309:	31 db                	xor    %ebx,%ebx
{
 30b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 30e:	eb 27                	jmp    337 <gets+0x37>
    cc = read(0, &c, 1);
 310:	83 ec 04             	sub    $0x4,%esp
 313:	6a 01                	push   $0x1
 315:	57                   	push   %edi
 316:	6a 00                	push   $0x0
 318:	e8 2e 01 00 00       	call   44b <read>
    if(cc < 1)
 31d:	83 c4 10             	add    $0x10,%esp
 320:	85 c0                	test   %eax,%eax
 322:	7e 1d                	jle    341 <gets+0x41>
      break;
    buf[i++] = c;
 324:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32f:	3c 0a                	cmp    $0xa,%al
 331:	74 1d                	je     350 <gets+0x50>
 333:	3c 0d                	cmp    $0xd,%al
 335:	74 19                	je     350 <gets+0x50>
  for(i=0; i+1 < max; ){
 337:	89 de                	mov    %ebx,%esi
 339:	83 c3 01             	add    $0x1,%ebx
 33c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33f:	7c cf                	jl     310 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 348:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34b:	5b                   	pop    %ebx
 34c:	5e                   	pop    %esi
 34d:	5f                   	pop    %edi
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    
  buf[i] = '\0';
 350:	8b 45 08             	mov    0x8(%ebp),%eax
 353:	89 de                	mov    %ebx,%esi
 355:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 359:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35c:	5b                   	pop    %ebx
 35d:	5e                   	pop    %esi
 35e:	5f                   	pop    %edi
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36f:	90                   	nop

00000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 375:	83 ec 08             	sub    $0x8,%esp
 378:	6a 00                	push   $0x0
 37a:	ff 75 08             	push   0x8(%ebp)
 37d:	e8 f1 00 00 00       	call   473 <open>
  if(fd < 0)
 382:	83 c4 10             	add    $0x10,%esp
 385:	85 c0                	test   %eax,%eax
 387:	78 27                	js     3b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 389:	83 ec 08             	sub    $0x8,%esp
 38c:	ff 75 0c             	push   0xc(%ebp)
 38f:	89 c3                	mov    %eax,%ebx
 391:	50                   	push   %eax
 392:	e8 f4 00 00 00       	call   48b <fstat>
  close(fd);
 397:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 39a:	89 c6                	mov    %eax,%esi
  close(fd);
 39c:	e8 ba 00 00 00       	call   45b <close>
  return r;
 3a1:	83 c4 10             	add    $0x10,%esp
}
 3a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3a7:	89 f0                	mov    %esi,%eax
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3b5:	eb ed                	jmp    3a4 <stat+0x34>
 3b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3be:	66 90                	xchg   %ax,%ax

000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	0f be 02             	movsbl (%edx),%eax
 3ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3d5:	77 1e                	ja     3f5 <atoi+0x35>
 3d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3de:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3ea:	0f be 02             	movsbl (%edx),%eax
 3ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f0:	80 fb 09             	cmp    $0x9,%bl
 3f3:	76 eb                	jbe    3e0 <atoi+0x20>
  return n;
}
 3f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f8:	89 c8                	mov    %ecx,%eax
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	8b 45 10             	mov    0x10(%ebp),%eax
 407:	8b 55 08             	mov    0x8(%ebp),%edx
 40a:	56                   	push   %esi
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	85 c0                	test   %eax,%eax
 410:	7e 13                	jle    425 <memmove+0x25>
 412:	01 d0                	add    %edx,%eax
  dst = vdst;
 414:	89 d7                	mov    %edx,%edi
 416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 420:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 421:	39 f8                	cmp    %edi,%eax
 423:	75 fb                	jne    420 <memmove+0x20>
  return vdst;
}
 425:	5e                   	pop    %esi
 426:	89 d0                	mov    %edx,%eax
 428:	5f                   	pop    %edi
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret    

0000042b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42b:	b8 01 00 00 00       	mov    $0x1,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <exit>:
SYSCALL(exit)
 433:	b8 02 00 00 00       	mov    $0x2,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <wait>:
SYSCALL(wait)
 43b:	b8 03 00 00 00       	mov    $0x3,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <pipe>:
SYSCALL(pipe)
 443:	b8 04 00 00 00       	mov    $0x4,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <read>:
SYSCALL(read)
 44b:	b8 05 00 00 00       	mov    $0x5,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <write>:
SYSCALL(write)
 453:	b8 10 00 00 00       	mov    $0x10,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <close>:
SYSCALL(close)
 45b:	b8 15 00 00 00       	mov    $0x15,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <kill>:
SYSCALL(kill)
 463:	b8 06 00 00 00       	mov    $0x6,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <exec>:
SYSCALL(exec)
 46b:	b8 07 00 00 00       	mov    $0x7,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <open>:
SYSCALL(open)
 473:	b8 0f 00 00 00       	mov    $0xf,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <mknod>:
SYSCALL(mknod)
 47b:	b8 11 00 00 00       	mov    $0x11,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <unlink>:
SYSCALL(unlink)
 483:	b8 12 00 00 00       	mov    $0x12,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <fstat>:
SYSCALL(fstat)
 48b:	b8 08 00 00 00       	mov    $0x8,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <link>:
SYSCALL(link)
 493:	b8 13 00 00 00       	mov    $0x13,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <mkdir>:
SYSCALL(mkdir)
 49b:	b8 14 00 00 00       	mov    $0x14,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <chdir>:
SYSCALL(chdir)
 4a3:	b8 09 00 00 00       	mov    $0x9,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <dup>:
SYSCALL(dup)
 4ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getpid>:
SYSCALL(getpid)
 4b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <sbrk>:
SYSCALL(sbrk)
 4bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <sleep>:
SYSCALL(sleep)
 4c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <uptime>:
SYSCALL(uptime)
 4cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <sort_syscalls>:
SYSCALL(sort_syscalls)
 4d3:	b8 18 00 00 00       	mov    $0x18,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 4db:	b8 19 00 00 00       	mov    $0x19,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <list_active_processes>:
SYSCALL(list_active_processes)
 4e3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <move_file>:
SYSCALL(move_file)
 4eb:	b8 17 00 00 00       	mov    $0x17,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <create_palindrome>:
SYSCALL(create_palindrome)
 4f3:	b8 16 00 00 00       	mov    $0x16,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <set_level>:
SYSCALL(set_level)
 4fb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <show_process_info>:
SYSCALL(show_process_info)
 503:	b8 1c 00 00 00       	mov    $0x1c,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <set_burst_confidence>:
SYSCALL(set_burst_confidence)
 50b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <count_syscalls_all_cpus>:
SYSCALL(count_syscalls_all_cpus)
 513:	b8 1e 00 00 00       	mov    $0x1e,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <sum_all_cpus_syscalls>:
SYSCALL(sum_all_cpus_syscalls)
 51b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    
 523:	66 90                	xchg   %ax,%ax
 525:	66 90                	xchg   %ax,%ax
 527:	66 90                	xchg   %ax,%ax
 529:	66 90                	xchg   %ax,%ax
 52b:	66 90                	xchg   %ax,%ax
 52d:	66 90                	xchg   %ax,%ax
 52f:	90                   	nop

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 3c             	sub    $0x3c,%esp
 539:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 53c:	89 d1                	mov    %edx,%ecx
{
 53e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 541:	85 d2                	test   %edx,%edx
 543:	0f 89 7f 00 00 00    	jns    5c8 <printint+0x98>
 549:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 54d:	74 79                	je     5c8 <printint+0x98>
    neg = 1;
 54f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 556:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 558:	31 db                	xor    %ebx,%ebx
 55a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 560:	89 c8                	mov    %ecx,%eax
 562:	31 d2                	xor    %edx,%edx
 564:	89 cf                	mov    %ecx,%edi
 566:	f7 75 c4             	divl   -0x3c(%ebp)
 569:	0f b6 92 7c 09 00 00 	movzbl 0x97c(%edx),%edx
 570:	89 45 c0             	mov    %eax,-0x40(%ebp)
 573:	89 d8                	mov    %ebx,%eax
 575:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 578:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 57b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 57e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 581:	76 dd                	jbe    560 <printint+0x30>
  if(neg)
 583:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 586:	85 c9                	test   %ecx,%ecx
 588:	74 0c                	je     596 <printint+0x66>
    buf[i++] = '-';
 58a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 58f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 591:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 596:	8b 7d b8             	mov    -0x48(%ebp),%edi
 599:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 59d:	eb 07                	jmp    5a6 <printint+0x76>
 59f:	90                   	nop
    putc(fd, buf[i]);
 5a0:	0f b6 13             	movzbl (%ebx),%edx
 5a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 5a6:	83 ec 04             	sub    $0x4,%esp
 5a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 5ac:	6a 01                	push   $0x1
 5ae:	56                   	push   %esi
 5af:	57                   	push   %edi
 5b0:	e8 9e fe ff ff       	call   453 <write>
  while(--i >= 0)
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	39 de                	cmp    %ebx,%esi
 5ba:	75 e4                	jne    5a0 <printint+0x70>
}
 5bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bf:	5b                   	pop    %ebx
 5c0:	5e                   	pop    %esi
 5c1:	5f                   	pop    %edi
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 5cf:	eb 87                	jmp    558 <printint+0x28>
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop

000005e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 5ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 5ef:	0f b6 13             	movzbl (%ebx),%edx
 5f2:	84 d2                	test   %dl,%dl
 5f4:	74 6a                	je     660 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 5f6:	8d 45 10             	lea    0x10(%ebp),%eax
 5f9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5ff:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 601:	89 45 d0             	mov    %eax,-0x30(%ebp)
 604:	eb 36                	jmp    63c <printf+0x5c>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
 610:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 613:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 618:	83 f8 25             	cmp    $0x25,%eax
 61b:	74 15                	je     632 <printf+0x52>
  write(fd, &c, 1);
 61d:	83 ec 04             	sub    $0x4,%esp
 620:	88 55 e7             	mov    %dl,-0x19(%ebp)
 623:	6a 01                	push   $0x1
 625:	57                   	push   %edi
 626:	56                   	push   %esi
 627:	e8 27 fe ff ff       	call   453 <write>
 62c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 62f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 632:	0f b6 13             	movzbl (%ebx),%edx
 635:	83 c3 01             	add    $0x1,%ebx
 638:	84 d2                	test   %dl,%dl
 63a:	74 24                	je     660 <printf+0x80>
    c = fmt[i] & 0xff;
 63c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 63f:	85 c9                	test   %ecx,%ecx
 641:	74 cd                	je     610 <printf+0x30>
      }
    } else if(state == '%'){
 643:	83 f9 25             	cmp    $0x25,%ecx
 646:	75 ea                	jne    632 <printf+0x52>
      if(c == 'd'){
 648:	83 f8 25             	cmp    $0x25,%eax
 64b:	0f 84 07 01 00 00    	je     758 <printf+0x178>
 651:	83 e8 63             	sub    $0x63,%eax
 654:	83 f8 15             	cmp    $0x15,%eax
 657:	77 17                	ja     670 <printf+0x90>
 659:	ff 24 85 24 09 00 00 	jmp    *0x924(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 660:	8d 65 f4             	lea    -0xc(%ebp),%esp
 663:	5b                   	pop    %ebx
 664:	5e                   	pop    %esi
 665:	5f                   	pop    %edi
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
 668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66f:	90                   	nop
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 676:	6a 01                	push   $0x1
 678:	57                   	push   %edi
 679:	56                   	push   %esi
 67a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 67e:	e8 d0 fd ff ff       	call   453 <write>
        putc(fd, c);
 683:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 687:	83 c4 0c             	add    $0xc,%esp
 68a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 68d:	6a 01                	push   $0x1
 68f:	57                   	push   %edi
 690:	56                   	push   %esi
 691:	e8 bd fd ff ff       	call   453 <write>
        putc(fd, c);
 696:	83 c4 10             	add    $0x10,%esp
      state = 0;
 699:	31 c9                	xor    %ecx,%ecx
 69b:	eb 95                	jmp    632 <printf+0x52>
 69d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6a0:	83 ec 0c             	sub    $0xc,%esp
 6a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6a8:	6a 00                	push   $0x0
 6aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6ad:	8b 10                	mov    (%eax),%edx
 6af:	89 f0                	mov    %esi,%eax
 6b1:	e8 7a fe ff ff       	call   530 <printint>
        ap++;
 6b6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6ba:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6bd:	31 c9                	xor    %ecx,%ecx
 6bf:	e9 6e ff ff ff       	jmp    632 <printf+0x52>
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6cb:	8b 10                	mov    (%eax),%edx
        ap++;
 6cd:	83 c0 04             	add    $0x4,%eax
 6d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6d3:	85 d2                	test   %edx,%edx
 6d5:	0f 84 8d 00 00 00    	je     768 <printf+0x188>
        while(*s != 0){
 6db:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 6de:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 6e0:	84 c0                	test   %al,%al
 6e2:	0f 84 4a ff ff ff    	je     632 <printf+0x52>
 6e8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6eb:	89 d3                	mov    %edx,%ebx
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6f3:	83 c3 01             	add    $0x1,%ebx
 6f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6f9:	6a 01                	push   $0x1
 6fb:	57                   	push   %edi
 6fc:	56                   	push   %esi
 6fd:	e8 51 fd ff ff       	call   453 <write>
        while(*s != 0){
 702:	0f b6 03             	movzbl (%ebx),%eax
 705:	83 c4 10             	add    $0x10,%esp
 708:	84 c0                	test   %al,%al
 70a:	75 e4                	jne    6f0 <printf+0x110>
      state = 0;
 70c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 70f:	31 c9                	xor    %ecx,%ecx
 711:	e9 1c ff ff ff       	jmp    632 <printf+0x52>
 716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 720:	83 ec 0c             	sub    $0xc,%esp
 723:	b9 0a 00 00 00       	mov    $0xa,%ecx
 728:	6a 01                	push   $0x1
 72a:	e9 7b ff ff ff       	jmp    6aa <printf+0xca>
 72f:	90                   	nop
        putc(fd, *ap);
 730:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 733:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 736:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 738:	6a 01                	push   $0x1
 73a:	57                   	push   %edi
 73b:	56                   	push   %esi
        putc(fd, *ap);
 73c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 73f:	e8 0f fd ff ff       	call   453 <write>
        ap++;
 744:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 748:	83 c4 10             	add    $0x10,%esp
      state = 0;
 74b:	31 c9                	xor    %ecx,%ecx
 74d:	e9 e0 fe ff ff       	jmp    632 <printf+0x52>
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 758:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 75b:	83 ec 04             	sub    $0x4,%esp
 75e:	e9 2a ff ff ff       	jmp    68d <printf+0xad>
 763:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 767:	90                   	nop
          s = "(null)";
 768:	ba 1a 09 00 00       	mov    $0x91a,%edx
        while(*s != 0){
 76d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 770:	b8 28 00 00 00       	mov    $0x28,%eax
 775:	89 d3                	mov    %edx,%ebx
 777:	e9 74 ff ff ff       	jmp    6f0 <printf+0x110>
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	a1 30 0c 00 00       	mov    0xc30,%eax
{
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 78e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 798:	89 c2                	mov    %eax,%edx
 79a:	8b 00                	mov    (%eax),%eax
 79c:	39 ca                	cmp    %ecx,%edx
 79e:	73 30                	jae    7d0 <free+0x50>
 7a0:	39 c1                	cmp    %eax,%ecx
 7a2:	72 04                	jb     7a8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	39 c2                	cmp    %eax,%edx
 7a6:	72 f0                	jb     798 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ae:	39 f8                	cmp    %edi,%eax
 7b0:	74 30                	je     7e2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7b5:	8b 42 04             	mov    0x4(%edx),%eax
 7b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7bb:	39 f1                	cmp    %esi,%ecx
 7bd:	74 3a                	je     7f9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7bf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7c1:	5b                   	pop    %ebx
  freep = p;
 7c2:	89 15 30 0c 00 00    	mov    %edx,0xc30
}
 7c8:	5e                   	pop    %esi
 7c9:	5f                   	pop    %edi
 7ca:	5d                   	pop    %ebp
 7cb:	c3                   	ret    
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 c2                	cmp    %eax,%edx
 7d2:	72 c4                	jb     798 <free+0x18>
 7d4:	39 c1                	cmp    %eax,%ecx
 7d6:	73 c0                	jae    798 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 7d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7de:	39 f8                	cmp    %edi,%eax
 7e0:	75 d0                	jne    7b2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 7e2:	03 70 04             	add    0x4(%eax),%esi
 7e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e8:	8b 02                	mov    (%edx),%eax
 7ea:	8b 00                	mov    (%eax),%eax
 7ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ef:	8b 42 04             	mov    0x4(%edx),%eax
 7f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7f5:	39 f1                	cmp    %esi,%ecx
 7f7:	75 c6                	jne    7bf <free+0x3f>
    p->s.size += bp->s.size;
 7f9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7fc:	89 15 30 0c 00 00    	mov    %edx,0xc30
    p->s.size += bp->s.size;
 802:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 805:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 808:	89 0a                	mov    %ecx,(%edx)
}
 80a:	5b                   	pop    %ebx
 80b:	5e                   	pop    %esi
 80c:	5f                   	pop    %edi
 80d:	5d                   	pop    %ebp
 80e:	c3                   	ret    
 80f:	90                   	nop

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 3d 30 0c 00 00    	mov    0xc30,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 70 07             	lea    0x7(%eax),%esi
 825:	c1 ee 03             	shr    $0x3,%esi
 828:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 82b:	85 ff                	test   %edi,%edi
 82d:	0f 84 9d 00 00 00    	je     8d0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 833:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 835:	8b 4a 04             	mov    0x4(%edx),%ecx
 838:	39 f1                	cmp    %esi,%ecx
 83a:	73 6a                	jae    8a6 <malloc+0x96>
 83c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 841:	39 de                	cmp    %ebx,%esi
 843:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 846:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 84d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 850:	eb 17                	jmp    869 <malloc+0x59>
 852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 85a:	8b 48 04             	mov    0x4(%eax),%ecx
 85d:	39 f1                	cmp    %esi,%ecx
 85f:	73 4f                	jae    8b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	8b 3d 30 0c 00 00    	mov    0xc30,%edi
 867:	89 c2                	mov    %eax,%edx
 869:	39 d7                	cmp    %edx,%edi
 86b:	75 eb                	jne    858 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 86d:	83 ec 0c             	sub    $0xc,%esp
 870:	ff 75 e4             	push   -0x1c(%ebp)
 873:	e8 43 fc ff ff       	call   4bb <sbrk>
  if(p == (char*)-1)
 878:	83 c4 10             	add    $0x10,%esp
 87b:	83 f8 ff             	cmp    $0xffffffff,%eax
 87e:	74 1c                	je     89c <malloc+0x8c>
  hp->s.size = nu;
 880:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 883:	83 ec 0c             	sub    $0xc,%esp
 886:	83 c0 08             	add    $0x8,%eax
 889:	50                   	push   %eax
 88a:	e8 f1 fe ff ff       	call   780 <free>
  return freep;
 88f:	8b 15 30 0c 00 00    	mov    0xc30,%edx
      if((p = morecore(nunits)) == 0)
 895:	83 c4 10             	add    $0x10,%esp
 898:	85 d2                	test   %edx,%edx
 89a:	75 bc                	jne    858 <malloc+0x48>
        return 0;
  }
}
 89c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 89f:	31 c0                	xor    %eax,%eax
}
 8a1:	5b                   	pop    %ebx
 8a2:	5e                   	pop    %esi
 8a3:	5f                   	pop    %edi
 8a4:	5d                   	pop    %ebp
 8a5:	c3                   	ret    
    if(p->s.size >= nunits){
 8a6:	89 d0                	mov    %edx,%eax
 8a8:	89 fa                	mov    %edi,%edx
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8b0:	39 ce                	cmp    %ecx,%esi
 8b2:	74 4c                	je     900 <malloc+0xf0>
        p->s.size -= nunits;
 8b4:	29 f1                	sub    %esi,%ecx
 8b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8bc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8bf:	89 15 30 0c 00 00    	mov    %edx,0xc30
}
 8c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8c8:	83 c0 08             	add    $0x8,%eax
}
 8cb:	5b                   	pop    %ebx
 8cc:	5e                   	pop    %esi
 8cd:	5f                   	pop    %edi
 8ce:	5d                   	pop    %ebp
 8cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 30 0c 00 00 34 	movl   $0xc34,0xc30
 8d7:	0c 00 00 
    base.s.size = 0;
 8da:	bf 34 0c 00 00       	mov    $0xc34,%edi
    base.s.ptr = freep = prevp = &base;
 8df:	c7 05 34 0c 00 00 34 	movl   $0xc34,0xc34
 8e6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 8eb:	c7 05 38 0c 00 00 00 	movl   $0x0,0xc38
 8f2:	00 00 00 
    if(p->s.size >= nunits){
 8f5:	e9 42 ff ff ff       	jmp    83c <malloc+0x2c>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb b9                	jmp    8bf <malloc+0xaf>
