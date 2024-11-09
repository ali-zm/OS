
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
  47:	0f b6 8a b8 08 00 00 	movzbl 0x8b8(%edx),%ecx
  4e:	38 c1                	cmp    %al,%cl
  50:	74 e6                	je     38 <main+0x38>
    }
    if(i!=6)
        flag = 1;
    unlink("result.txt");
  52:	83 ec 0c             	sub    $0xc,%esp
  55:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
  58:	68 bf 08 00 00       	push   $0x8bf
  5d:	e8 21 04 00 00       	call   483 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  62:	58                   	pop    %eax
  63:	5a                   	pop    %edx
  64:	68 02 02 00 00       	push   $0x202
  69:	68 bf 08 00 00       	push   $0x8bf
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
  a9:	68 bf 08 00 00       	push   $0x8bf
  ae:	e8 d0 03 00 00       	call   483 <unlink>
    int fd = open("result.txt", O_CREATE | O_RDWR);
  b3:	58                   	pop    %eax
  b4:	5a                   	pop    %edx
  b5:	68 02 02 00 00       	push   $0x202
  ba:	68 bf 08 00 00       	push   $0x8bf
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
 1e0:	55                   	push   %ebp
 1e1:	31 c0                	xor    %eax,%eax
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	53                   	push   %ebx
 1e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strcpy+0x10>
 1fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 201:	89 c8                	mov    %ecx,%eax
 203:	c9                   	leave  
 204:	c3                   	ret    
 205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <strcmp>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 17                	jne    238 <strcmp+0x28>
 221:	eb 3a                	jmp    25d <strcmp+0x4d>
 223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 227:	90                   	nop
 228:	0f b6 42 01          	movzbl 0x1(%edx),%eax
 22c:	83 c2 01             	add    $0x1,%edx
 22f:	8d 59 01             	lea    0x1(%ecx),%ebx
 232:	84 c0                	test   %al,%al
 234:	74 1a                	je     250 <strcmp+0x40>
 236:	89 d9                	mov    %ebx,%ecx
 238:	0f b6 19             	movzbl (%ecx),%ebx
 23b:	38 c3                	cmp    %al,%bl
 23d:	74 e9                	je     228 <strcmp+0x18>
 23f:	29 d8                	sub    %ebx,%eax
 241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 244:	c9                   	leave  
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 254:	31 c0                	xor    %eax,%eax
 256:	29 d8                	sub    %ebx,%eax
 258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 25b:	c9                   	leave  
 25c:	c3                   	ret    
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <strcmp+0x2f>
 264:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop

00000270 <strlen>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
 276:	80 3a 00             	cmpb   $0x0,(%edx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 c0                	xor    %eax,%eax
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c0 01             	add    $0x1,%eax
 283:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 287:	89 c1                	mov    %eax,%ecx
 289:	75 f5                	jne    280 <strlen+0x10>
 28b:	89 c8                	mov    %ecx,%eax
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret    
 28f:	90                   	nop
 290:	31 c9                	xor    %ecx,%ecx
 292:	5d                   	pop    %ebp
 293:	89 c8                	mov    %ecx,%eax
 295:	c3                   	ret    
 296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29d:	8d 76 00             	lea    0x0(%esi),%esi

000002a0 <memset>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld    
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
 2b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	c9                   	leave  
 2b8:	c3                   	ret    
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strchr>:
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
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
 2e3:	38 d1                	cmp    %dl,%cl
 2e5:	75 f1                	jne    2d8 <strchr+0x18>
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	31 c0                	xor    %eax,%eax
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop

00000300 <gets>:
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	8d 7d e7             	lea    -0x19(%ebp),%edi
 308:	53                   	push   %ebx
 309:	31 db                	xor    %ebx,%ebx
 30b:	83 ec 1c             	sub    $0x1c,%esp
 30e:	eb 27                	jmp    337 <gets+0x37>
 310:	83 ec 04             	sub    $0x4,%esp
 313:	6a 01                	push   $0x1
 315:	57                   	push   %edi
 316:	6a 00                	push   $0x0
 318:	e8 2e 01 00 00       	call   44b <read>
 31d:	83 c4 10             	add    $0x10,%esp
 320:	85 c0                	test   %eax,%eax
 322:	7e 1d                	jle    341 <gets+0x41>
 324:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 32f:	3c 0a                	cmp    $0xa,%al
 331:	74 1d                	je     350 <gets+0x50>
 333:	3c 0d                	cmp    $0xd,%al
 335:	74 19                	je     350 <gets+0x50>
 337:	89 de                	mov    %ebx,%esi
 339:	83 c3 01             	add    $0x1,%ebx
 33c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33f:	7c cf                	jl     310 <gets+0x10>
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 348:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34b:	5b                   	pop    %ebx
 34c:	5e                   	pop    %esi
 34d:	5f                   	pop    %edi
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    
 350:	8b 45 08             	mov    0x8(%ebp),%eax
 353:	89 de                	mov    %ebx,%esi
 355:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
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
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
 375:	83 ec 08             	sub    $0x8,%esp
 378:	6a 00                	push   $0x0
 37a:	ff 75 08             	push   0x8(%ebp)
 37d:	e8 f1 00 00 00       	call   473 <open>
 382:	83 c4 10             	add    $0x10,%esp
 385:	85 c0                	test   %eax,%eax
 387:	78 27                	js     3b0 <stat+0x40>
 389:	83 ec 08             	sub    $0x8,%esp
 38c:	ff 75 0c             	push   0xc(%ebp)
 38f:	89 c3                	mov    %eax,%ebx
 391:	50                   	push   %eax
 392:	e8 f4 00 00 00       	call   48b <fstat>
 397:	89 1c 24             	mov    %ebx,(%esp)
 39a:	89 c6                	mov    %eax,%esi
 39c:	e8 ba 00 00 00       	call   45b <close>
 3a1:	83 c4 10             	add    $0x10,%esp
 3a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3a7:	89 f0                	mov    %esi,%eax
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3b5:	eb ed                	jmp    3a4 <stat+0x34>
 3b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3be:	66 90                	xchg   %ax,%ax

000003c0 <atoi>:
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 55 08             	mov    0x8(%ebp),%edx
 3c7:	0f be 02             	movsbl (%edx),%eax
 3ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3cd:	80 f9 09             	cmp    $0x9,%cl
 3d0:	b9 00 00 00 00       	mov    $0x0,%ecx
 3d5:	77 1e                	ja     3f5 <atoi+0x35>
 3d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3de:	66 90                	xchg   %ax,%ax
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 3ea:	0f be 02             	movsbl (%edx),%eax
 3ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f0:	80 fb 09             	cmp    $0x9,%bl
 3f3:	76 eb                	jbe    3e0 <atoi+0x20>
 3f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f8:	89 c8                	mov    %ecx,%eax
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <memmove>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	8b 45 10             	mov    0x10(%ebp),%eax
 407:	8b 55 08             	mov    0x8(%ebp),%edx
 40a:	56                   	push   %esi
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
 40e:	85 c0                	test   %eax,%eax
 410:	7e 13                	jle    425 <memmove+0x25>
 412:	01 d0                	add    %edx,%eax
 414:	89 d7                	mov    %edx,%edi
 416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 421:	39 f8                	cmp    %edi,%eax
 423:	75 fb                	jne    420 <memmove+0x20>
 425:	5e                   	pop    %esi
 426:	89 d0                	mov    %edx,%eax
 428:	5f                   	pop    %edi
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret    

0000042b <fork>:
 42b:	b8 01 00 00 00       	mov    $0x1,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <exit>:
 433:	b8 02 00 00 00       	mov    $0x2,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <wait>:
 43b:	b8 03 00 00 00       	mov    $0x3,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <pipe>:
 443:	b8 04 00 00 00       	mov    $0x4,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <read>:
 44b:	b8 05 00 00 00       	mov    $0x5,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <write>:
 453:	b8 10 00 00 00       	mov    $0x10,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <close>:
 45b:	b8 15 00 00 00       	mov    $0x15,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <kill>:
 463:	b8 06 00 00 00       	mov    $0x6,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <exec>:
 46b:	b8 07 00 00 00       	mov    $0x7,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <open>:
 473:	b8 0f 00 00 00       	mov    $0xf,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <mknod>:
 47b:	b8 11 00 00 00       	mov    $0x11,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <unlink>:
 483:	b8 12 00 00 00       	mov    $0x12,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <fstat>:
 48b:	b8 08 00 00 00       	mov    $0x8,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <link>:
 493:	b8 13 00 00 00       	mov    $0x13,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <mkdir>:
 49b:	b8 14 00 00 00       	mov    $0x14,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <chdir>:
 4a3:	b8 09 00 00 00       	mov    $0x9,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <dup>:
 4ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getpid>:
 4b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <sbrk>:
 4bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <sleep>:
 4c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <uptime>:
 4cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    
 4d3:	66 90                	xchg   %ax,%ax
 4d5:	66 90                	xchg   %ax,%ax
 4d7:	66 90                	xchg   %ax,%ax
 4d9:	66 90                	xchg   %ax,%ax
 4db:	66 90                	xchg   %ax,%ax
 4dd:	66 90                	xchg   %ax,%ax
 4df:	90                   	nop

000004e0 <printint>:
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 3c             	sub    $0x3c,%esp
 4e9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 4ec:	89 d1                	mov    %edx,%ecx
 4ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4f1:	85 d2                	test   %edx,%edx
 4f3:	0f 89 7f 00 00 00    	jns    578 <printint+0x98>
 4f9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4fd:	74 79                	je     578 <printint+0x98>
 4ff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 506:	f7 d9                	neg    %ecx
 508:	31 db                	xor    %ebx,%ebx
 50a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
 510:	89 c8                	mov    %ecx,%eax
 512:	31 d2                	xor    %edx,%edx
 514:	89 cf                	mov    %ecx,%edi
 516:	f7 75 c4             	divl   -0x3c(%ebp)
 519:	0f b6 92 2c 09 00 00 	movzbl 0x92c(%edx),%edx
 520:	89 45 c0             	mov    %eax,-0x40(%ebp)
 523:	89 d8                	mov    %ebx,%eax
 525:	8d 5b 01             	lea    0x1(%ebx),%ebx
 528:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 52b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 52e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 531:	76 dd                	jbe    510 <printint+0x30>
 533:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 536:	85 c9                	test   %ecx,%ecx
 538:	74 0c                	je     546 <printint+0x66>
 53a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 53f:	89 d8                	mov    %ebx,%eax
 541:	ba 2d 00 00 00       	mov    $0x2d,%edx
 546:	8b 7d b8             	mov    -0x48(%ebp),%edi
 549:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 54d:	eb 07                	jmp    556 <printint+0x76>
 54f:	90                   	nop
 550:	0f b6 13             	movzbl (%ebx),%edx
 553:	83 eb 01             	sub    $0x1,%ebx
 556:	83 ec 04             	sub    $0x4,%esp
 559:	88 55 d7             	mov    %dl,-0x29(%ebp)
 55c:	6a 01                	push   $0x1
 55e:	56                   	push   %esi
 55f:	57                   	push   %edi
 560:	e8 ee fe ff ff       	call   453 <write>
 565:	83 c4 10             	add    $0x10,%esp
 568:	39 de                	cmp    %ebx,%esi
 56a:	75 e4                	jne    550 <printint+0x70>
 56c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56f:	5b                   	pop    %ebx
 570:	5e                   	pop    %esi
 571:	5f                   	pop    %edi
 572:	5d                   	pop    %ebp
 573:	c3                   	ret    
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 578:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 57f:	eb 87                	jmp    508 <printint+0x28>
 581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop

00000590 <printf>:
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 2c             	sub    $0x2c,%esp
 599:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 59c:	8b 75 08             	mov    0x8(%ebp),%esi
 59f:	0f b6 13             	movzbl (%ebx),%edx
 5a2:	84 d2                	test   %dl,%dl
 5a4:	74 6a                	je     610 <printf+0x80>
 5a6:	8d 45 10             	lea    0x10(%ebp),%eax
 5a9:	83 c3 01             	add    $0x1,%ebx
 5ac:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5af:	31 c9                	xor    %ecx,%ecx
 5b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b4:	eb 36                	jmp    5ec <printf+0x5c>
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
 5c0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5c3:	b9 25 00 00 00       	mov    $0x25,%ecx
 5c8:	83 f8 25             	cmp    $0x25,%eax
 5cb:	74 15                	je     5e2 <printf+0x52>
 5cd:	83 ec 04             	sub    $0x4,%esp
 5d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5d3:	6a 01                	push   $0x1
 5d5:	57                   	push   %edi
 5d6:	56                   	push   %esi
 5d7:	e8 77 fe ff ff       	call   453 <write>
 5dc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5df:	83 c4 10             	add    $0x10,%esp
 5e2:	0f b6 13             	movzbl (%ebx),%edx
 5e5:	83 c3 01             	add    $0x1,%ebx
 5e8:	84 d2                	test   %dl,%dl
 5ea:	74 24                	je     610 <printf+0x80>
 5ec:	0f b6 c2             	movzbl %dl,%eax
 5ef:	85 c9                	test   %ecx,%ecx
 5f1:	74 cd                	je     5c0 <printf+0x30>
 5f3:	83 f9 25             	cmp    $0x25,%ecx
 5f6:	75 ea                	jne    5e2 <printf+0x52>
 5f8:	83 f8 25             	cmp    $0x25,%eax
 5fb:	0f 84 07 01 00 00    	je     708 <printf+0x178>
 601:	83 e8 63             	sub    $0x63,%eax
 604:	83 f8 15             	cmp    $0x15,%eax
 607:	77 17                	ja     620 <printf+0x90>
 609:	ff 24 85 d4 08 00 00 	jmp    *0x8d4(,%eax,4)
 610:	8d 65 f4             	lea    -0xc(%ebp),%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
 618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
 620:	83 ec 04             	sub    $0x4,%esp
 623:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 626:	6a 01                	push   $0x1
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 62e:	e8 20 fe ff ff       	call   453 <write>
 633:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 637:	83 c4 0c             	add    $0xc,%esp
 63a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 63d:	6a 01                	push   $0x1
 63f:	57                   	push   %edi
 640:	56                   	push   %esi
 641:	e8 0d fe ff ff       	call   453 <write>
 646:	83 c4 10             	add    $0x10,%esp
 649:	31 c9                	xor    %ecx,%ecx
 64b:	eb 95                	jmp    5e2 <printf+0x52>
 64d:	8d 76 00             	lea    0x0(%esi),%esi
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 10 00 00 00       	mov    $0x10,%ecx
 658:	6a 00                	push   $0x0
 65a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 65d:	8b 10                	mov    (%eax),%edx
 65f:	89 f0                	mov    %esi,%eax
 661:	e8 7a fe ff ff       	call   4e0 <printint>
 666:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 66a:	83 c4 10             	add    $0x10,%esp
 66d:	31 c9                	xor    %ecx,%ecx
 66f:	e9 6e ff ff ff       	jmp    5e2 <printf+0x52>
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 678:	8b 45 d0             	mov    -0x30(%ebp),%eax
 67b:	8b 10                	mov    (%eax),%edx
 67d:	83 c0 04             	add    $0x4,%eax
 680:	89 45 d0             	mov    %eax,-0x30(%ebp)
 683:	85 d2                	test   %edx,%edx
 685:	0f 84 8d 00 00 00    	je     718 <printf+0x188>
 68b:	0f b6 02             	movzbl (%edx),%eax
 68e:	31 c9                	xor    %ecx,%ecx
 690:	84 c0                	test   %al,%al
 692:	0f 84 4a ff ff ff    	je     5e2 <printf+0x52>
 698:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 69b:	89 d3                	mov    %edx,%ebx
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	83 c3 01             	add    $0x1,%ebx
 6a6:	88 45 e7             	mov    %al,-0x19(%ebp)
 6a9:	6a 01                	push   $0x1
 6ab:	57                   	push   %edi
 6ac:	56                   	push   %esi
 6ad:	e8 a1 fd ff ff       	call   453 <write>
 6b2:	0f b6 03             	movzbl (%ebx),%eax
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	84 c0                	test   %al,%al
 6ba:	75 e4                	jne    6a0 <printf+0x110>
 6bc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 6bf:	31 c9                	xor    %ecx,%ecx
 6c1:	e9 1c ff ff ff       	jmp    5e2 <printf+0x52>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	6a 01                	push   $0x1
 6da:	e9 7b ff ff ff       	jmp    65a <printf+0xca>
 6df:	90                   	nop
 6e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6e3:	83 ec 04             	sub    $0x4,%esp
 6e6:	8b 00                	mov    (%eax),%eax
 6e8:	6a 01                	push   $0x1
 6ea:	57                   	push   %edi
 6eb:	56                   	push   %esi
 6ec:	88 45 e7             	mov    %al,-0x19(%ebp)
 6ef:	e8 5f fd ff ff       	call   453 <write>
 6f4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6f8:	83 c4 10             	add    $0x10,%esp
 6fb:	31 c9                	xor    %ecx,%ecx
 6fd:	e9 e0 fe ff ff       	jmp    5e2 <printf+0x52>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 708:	88 55 e7             	mov    %dl,-0x19(%ebp)
 70b:	83 ec 04             	sub    $0x4,%esp
 70e:	e9 2a ff ff ff       	jmp    63d <printf+0xad>
 713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 717:	90                   	nop
 718:	ba ca 08 00 00       	mov    $0x8ca,%edx
 71d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 720:	b8 28 00 00 00       	mov    $0x28,%eax
 725:	89 d3                	mov    %edx,%ebx
 727:	e9 74 ff ff ff       	jmp    6a0 <printf+0x110>
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
 730:	55                   	push   %ebp
 731:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 748:	89 c2                	mov    %eax,%edx
 74a:	8b 00                	mov    (%eax),%eax
 74c:	39 ca                	cmp    %ecx,%edx
 74e:	73 30                	jae    780 <free+0x50>
 750:	39 c1                	cmp    %eax,%ecx
 752:	72 04                	jb     758 <free+0x28>
 754:	39 c2                	cmp    %eax,%edx
 756:	72 f0                	jb     748 <free+0x18>
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 f8                	cmp    %edi,%eax
 760:	74 30                	je     792 <free+0x62>
 762:	89 43 f8             	mov    %eax,-0x8(%ebx)
 765:	8b 42 04             	mov    0x4(%edx),%eax
 768:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 76b:	39 f1                	cmp    %esi,%ecx
 76d:	74 3a                	je     7a9 <free+0x79>
 76f:	89 0a                	mov    %ecx,(%edx)
 771:	5b                   	pop    %ebx
 772:	89 15 e0 0b 00 00    	mov    %edx,0xbe0
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 780:	39 c2                	cmp    %eax,%edx
 782:	72 c4                	jb     748 <free+0x18>
 784:	39 c1                	cmp    %eax,%ecx
 786:	73 c0                	jae    748 <free+0x18>
 788:	8b 73 fc             	mov    -0x4(%ebx),%esi
 78b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78e:	39 f8                	cmp    %edi,%eax
 790:	75 d0                	jne    762 <free+0x32>
 792:	03 70 04             	add    0x4(%eax),%esi
 795:	89 73 fc             	mov    %esi,-0x4(%ebx)
 798:	8b 02                	mov    (%edx),%eax
 79a:	8b 00                	mov    (%eax),%eax
 79c:	89 43 f8             	mov    %eax,-0x8(%ebx)
 79f:	8b 42 04             	mov    0x4(%edx),%eax
 7a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	75 c6                	jne    76f <free+0x3f>
 7a9:	03 43 fc             	add    -0x4(%ebx),%eax
 7ac:	89 15 e0 0b 00 00    	mov    %edx,0xbe0
 7b2:	89 42 04             	mov    %eax,0x4(%edx)
 7b5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7b8:	89 0a                	mov    %ecx,(%edx)
 7ba:	5b                   	pop    %ebx
 7bb:	5e                   	pop    %esi
 7bc:	5f                   	pop    %edi
 7bd:	5d                   	pop    %ebp
 7be:	c3                   	ret    
 7bf:	90                   	nop

000007c0 <malloc>:
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 1c             	sub    $0x1c,%esp
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
 7cc:	8b 3d e0 0b 00 00    	mov    0xbe0,%edi
 7d2:	8d 70 07             	lea    0x7(%eax),%esi
 7d5:	c1 ee 03             	shr    $0x3,%esi
 7d8:	83 c6 01             	add    $0x1,%esi
 7db:	85 ff                	test   %edi,%edi
 7dd:	0f 84 9d 00 00 00    	je     880 <malloc+0xc0>
 7e3:	8b 17                	mov    (%edi),%edx
 7e5:	8b 4a 04             	mov    0x4(%edx),%ecx
 7e8:	39 f1                	cmp    %esi,%ecx
 7ea:	73 6a                	jae    856 <malloc+0x96>
 7ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f1:	39 de                	cmp    %ebx,%esi
 7f3:	0f 43 de             	cmovae %esi,%ebx
 7f6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 800:	eb 17                	jmp    819 <malloc+0x59>
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 808:	8b 02                	mov    (%edx),%eax
 80a:	8b 48 04             	mov    0x4(%eax),%ecx
 80d:	39 f1                	cmp    %esi,%ecx
 80f:	73 4f                	jae    860 <malloc+0xa0>
 811:	8b 3d e0 0b 00 00    	mov    0xbe0,%edi
 817:	89 c2                	mov    %eax,%edx
 819:	39 d7                	cmp    %edx,%edi
 81b:	75 eb                	jne    808 <malloc+0x48>
 81d:	83 ec 0c             	sub    $0xc,%esp
 820:	ff 75 e4             	push   -0x1c(%ebp)
 823:	e8 93 fc ff ff       	call   4bb <sbrk>
 828:	83 c4 10             	add    $0x10,%esp
 82b:	83 f8 ff             	cmp    $0xffffffff,%eax
 82e:	74 1c                	je     84c <malloc+0x8c>
 830:	89 58 04             	mov    %ebx,0x4(%eax)
 833:	83 ec 0c             	sub    $0xc,%esp
 836:	83 c0 08             	add    $0x8,%eax
 839:	50                   	push   %eax
 83a:	e8 f1 fe ff ff       	call   730 <free>
 83f:	8b 15 e0 0b 00 00    	mov    0xbe0,%edx
 845:	83 c4 10             	add    $0x10,%esp
 848:	85 d2                	test   %edx,%edx
 84a:	75 bc                	jne    808 <malloc+0x48>
 84c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 84f:	31 c0                	xor    %eax,%eax
 851:	5b                   	pop    %ebx
 852:	5e                   	pop    %esi
 853:	5f                   	pop    %edi
 854:	5d                   	pop    %ebp
 855:	c3                   	ret    
 856:	89 d0                	mov    %edx,%eax
 858:	89 fa                	mov    %edi,%edx
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 860:	39 ce                	cmp    %ecx,%esi
 862:	74 4c                	je     8b0 <malloc+0xf0>
 864:	29 f1                	sub    %esi,%ecx
 866:	89 48 04             	mov    %ecx,0x4(%eax)
 869:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 86c:	89 70 04             	mov    %esi,0x4(%eax)
 86f:	89 15 e0 0b 00 00    	mov    %edx,0xbe0
 875:	8d 65 f4             	lea    -0xc(%ebp),%esp
 878:	83 c0 08             	add    $0x8,%eax
 87b:	5b                   	pop    %ebx
 87c:	5e                   	pop    %esi
 87d:	5f                   	pop    %edi
 87e:	5d                   	pop    %ebp
 87f:	c3                   	ret    
 880:	c7 05 e0 0b 00 00 e4 	movl   $0xbe4,0xbe0
 887:	0b 00 00 
 88a:	bf e4 0b 00 00       	mov    $0xbe4,%edi
 88f:	c7 05 e4 0b 00 00 e4 	movl   $0xbe4,0xbe4
 896:	0b 00 00 
 899:	89 fa                	mov    %edi,%edx
 89b:	c7 05 e8 0b 00 00 00 	movl   $0x0,0xbe8
 8a2:	00 00 00 
 8a5:	e9 42 ff ff ff       	jmp    7ec <malloc+0x2c>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8b0:	8b 08                	mov    (%eax),%ecx
 8b2:	89 0a                	mov    %ecx,(%edx)
 8b4:	eb b9                	jmp    86f <malloc+0xaf>
