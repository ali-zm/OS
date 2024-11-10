
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	push   -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
  1a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
  1b:	31 db                	xor    %ebx,%ebx
{
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  printf(1, "stressfs starting\n");
<<<<<<< HEAD
  2b:	68 b8 07 00 00       	push   $0x7b8
=======
  2b:	68 28 08 00 00       	push   $0x828
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  30:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  32:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  39:	74 72 65 
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
<<<<<<< HEAD
  46:	e8 65 04 00 00       	call   4b0 <printf>
=======
  46:	e8 b5 04 00 00       	call   500 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 85 01 00 00       	call   1e0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 f8 02 00 00       	call   35b <fork>
  63:	85 c0                	test   %eax,%eax
  65:	7f 08                	jg     6f <main+0x6f>
  for(i = 0; i < 4; i++)
  67:	83 c3 01             	add    $0x1,%ebx
  6a:	83 fb 04             	cmp    $0x4,%ebx
  6d:	75 ef                	jne    5e <main+0x5e>
      break;

  printf(1, "write %d\n", i);
  6f:	83 ec 04             	sub    $0x4,%esp
  72:	53                   	push   %ebx
  73:	68 cb 07 00 00       	push   $0x7cb
  78:	6a 01                	push   $0x1
  7a:	e8 31 04 00 00       	call   4b0 <printf>

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
<<<<<<< HEAD
  7f:	5f                   	pop    %edi
  80:	58                   	pop    %eax
  81:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  87:	68 02 02 00 00       	push   $0x202
  8c:	50                   	push   %eax
=======
  7c:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  81:	68 3b 08 00 00       	push   $0x83b
  86:	6a 01                	push   $0x1
  88:	e8 73 04 00 00       	call   500 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  path[8] += i;
  8d:	00 9d e6 fd ff ff    	add    %bl,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  93:	bb 14 00 00 00       	mov    $0x14,%ebx
  98:	e8 06 03 00 00       	call   3a3 <open>
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  a8:	83 ec 04             	sub    $0x4,%esp
  ab:	68 00 02 00 00       	push   $0x200
  b0:	56                   	push   %esi
  b1:	57                   	push   %edi
  b2:	e8 cc 02 00 00       	call   383 <write>
  for(i = 0; i < 20; i++)
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	83 eb 01             	sub    $0x1,%ebx
  bd:	75 e9                	jne    a8 <main+0xa8>
  close(fd);
  bf:	83 ec 0c             	sub    $0xc,%esp
  c2:	57                   	push   %edi
  c3:	e8 c3 02 00 00       	call   38b <close>

  printf(1, "read\n");
<<<<<<< HEAD
  c8:	58                   	pop    %eax
  c9:	5a                   	pop    %edx
  ca:	68 d5 07 00 00       	push   $0x7d5
  cf:	6a 01                	push   $0x1
  d1:	e8 da 03 00 00       	call   4b0 <printf>
=======
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 45 08 00 00       	push   $0x845
  d7:	6a 01                	push   $0x1
  d9:	e8 22 04 00 00       	call   500 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

  fd = open(path, O_RDONLY);
  d6:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  dc:	59                   	pop    %ecx
  dd:	5b                   	pop    %ebx
  de:	6a 00                	push   $0x0
  e0:	bb 14 00 00 00       	mov    $0x14,%ebx
  e5:	50                   	push   %eax
  e6:	e8 b8 02 00 00       	call   3a3 <open>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  f0:	83 ec 04             	sub    $0x4,%esp
  f3:	68 00 02 00 00       	push   $0x200
  f8:	56                   	push   %esi
  f9:	57                   	push   %edi
  fa:	e8 7c 02 00 00       	call   37b <read>
  for (i = 0; i < 20; i++)
  ff:	83 c4 10             	add    $0x10,%esp
 102:	83 eb 01             	sub    $0x1,%ebx
 105:	75 e9                	jne    f0 <main+0xf0>
  close(fd);
 107:	83 ec 0c             	sub    $0xc,%esp
 10a:	57                   	push   %edi
 10b:	e8 7b 02 00 00       	call   38b <close>

  wait();
 110:	e8 56 02 00 00       	call   36b <wait>

  exit();
 115:	e8 49 02 00 00       	call   363 <exit>
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 17                	jne    178 <strcmp+0x28>
 161:	eb 3a                	jmp    19d <strcmp+0x4d>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 16c:	83 c2 01             	add    $0x1,%edx
 16f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 172:	84 c0                	test   %al,%al
 174:	74 1a                	je     190 <strcmp+0x40>
 176:	89 d9                	mov    %ebx,%ecx
 178:	0f b6 19             	movzbl (%ecx),%ebx
 17b:	38 c3                	cmp    %al,%bl
 17d:	74 e9                	je     168 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 17f:	29 d8                	sub    %ebx,%eax
}
 181:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 184:	c9                   	leave
 185:	c3                   	ret
 186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18d:	00 
 18e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 190:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 194:	31 c0                	xor    %eax,%eax
 196:	29 d8                	sub    %ebx,%eax
}
 198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19b:	c9                   	leave
 19c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 19d:	0f b6 19             	movzbl (%ecx),%ebx
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	eb db                	jmp    17f <strcmp+0x2f>
 1a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ab:	00 
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c0 01             	add    $0x1,%eax
 1c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c7:	89 c1                	mov    %eax,%ecx
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	89 c8                	mov    %ecx,%eax
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret
 1cf:	90                   	nop
  for(n = 0; s[n]; n++)
 1d0:	31 c9                	xor    %ecx,%ecx
}
 1d2:	5d                   	pop    %ebp
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	c3                   	ret
 1d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1dd:	00 
 1de:	66 90                	xchg   %ax,%ax

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c9                   	leave
 1f8:	c3                   	ret
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 12                	jne    223 <strchr+0x23>
 211:	eb 1d                	jmp    230 <strchr+0x30>
 213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	84 d2                	test   %dl,%dl
 221:	74 0d                	je     230 <strchr+0x30>
    if(*s == c)
 223:	38 d1                	cmp    %dl,%cl
 225:	75 f1                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 227:	5d                   	pop    %ebp
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 230:	31 c0                	xor    %eax,%eax
}
 232:	5d                   	pop    %ebp
 233:	c3                   	ret
 234:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23b:	00 
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 245:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 248:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 249:	31 db                	xor    %ebx,%ebx
{
 24b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 24e:	eb 27                	jmp    277 <gets+0x37>
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	6a 01                	push   $0x1
 255:	56                   	push   %esi
 256:	6a 00                	push   $0x0
 258:	e8 1e 01 00 00       	call   37b <read>
    if(cc < 1)
 25d:	83 c4 10             	add    $0x10,%esp
 260:	85 c0                	test   %eax,%eax
 262:	7e 1d                	jle    281 <gets+0x41>
      break;
    buf[i++] = c;
 264:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 26f:	3c 0a                	cmp    $0xa,%al
 271:	74 10                	je     283 <gets+0x43>
 273:	3c 0d                	cmp    $0xd,%al
 275:	74 0c                	je     283 <gets+0x43>
  for(i=0; i+1 < max; ){
 277:	89 df                	mov    %ebx,%edi
 279:	83 c3 01             	add    $0x1,%ebx
 27c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 27f:	7c cf                	jl     250 <gets+0x10>
 281:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 28a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28d:	5b                   	pop    %ebx
 28e:	5e                   	pop    %esi
 28f:	5f                   	pop    %edi
 290:	5d                   	pop    %ebp
 291:	c3                   	ret
 292:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 299:	00 
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	push   0x8(%ebp)
 2ad:	e8 f1 00 00 00       	call   3a3 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	push   0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 f4 00 00 00       	call   3bb <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 ba 00 00 00       	call   38b <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 02             	movsbl (%edx),%eax
 2fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 300:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 305:	77 1e                	ja     325 <atoi+0x35>
 307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30e:	00 
 30f:	90                   	nop
    n = n*10 + *s++ - '0';
 310:	83 c2 01             	add    $0x1,%edx
 313:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 316:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 31a:	0f be 02             	movsbl (%edx),%eax
 31d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 328:	89 c8                	mov    %ecx,%eax
 32a:	c9                   	leave
 32b:	c3                   	ret
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 45 10             	mov    0x10(%ebp),%eax
 337:	8b 55 08             	mov    0x8(%ebp),%edx
 33a:	56                   	push   %esi
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c0                	test   %eax,%eax
 340:	7e 13                	jle    355 <memmove+0x25>
 342:	01 d0                	add    %edx,%eax
  dst = vdst;
 344:	89 d7                	mov    %edx,%edi
 346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34d:	00 
 34e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 351:	39 f8                	cmp    %edi,%eax
 353:	75 fb                	jne    350 <memmove+0x20>
  return vdst;
}
 355:	5e                   	pop    %esi
 356:	89 d0                	mov    %edx,%eax
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret

0000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <uptime>:
SYSCALL(uptime)
<<<<<<< HEAD
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <move_file>:
SYSCALL(move_file)
 403:	b8 17 00 00 00       	mov    $0x17,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
=======
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <sort_syscalls>:
SYSCALL(sort_syscalls)
 433:	b8 18 00 00 00       	mov    $0x18,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 43b:	b8 19 00 00 00       	mov    $0x19,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <list_active_processes>:
SYSCALL(list_active_processes)
 443:	b8 1a 00 00 00       	mov    $0x1a,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	90                   	nop

00000450 <printint>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
<<<<<<< HEAD
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 cb                	mov    %ecx,%ebx
=======
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 3c             	sub    $0x3c,%esp
 459:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
<<<<<<< HEAD
 418:	89 d1                	mov    %edx,%ecx
{
 41a:	83 ec 3c             	sub    $0x3c,%esp
 41d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 420:	85 d2                	test   %edx,%edx
 422:	0f 89 80 00 00 00    	jns    4a8 <printint+0x98>
 428:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 42c:	74 7a                	je     4a8 <printint+0x98>
    x = -xx;
 42e:	f7 d9                	neg    %ecx
    neg = 1;
 430:	b8 01 00 00 00       	mov    $0x1,%eax
=======
 45c:	89 d1                	mov    %edx,%ecx
{
 45e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 461:	85 d2                	test   %edx,%edx
 463:	0f 89 7f 00 00 00    	jns    4e8 <printint+0x98>
 469:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 46d:	74 79                	je     4e8 <printint+0x98>
    neg = 1;
 46f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 476:	f7 d9                	neg    %ecx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else {
    x = xx;
  }

  i = 0;
<<<<<<< HEAD
 435:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 438:	31 f6                	xor    %esi,%esi
 43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 f7                	mov    %esi,%edi
 446:	f7 f3                	div    %ebx
 448:	8d 76 01             	lea    0x1(%esi),%esi
 44b:	0f b6 92 3c 08 00 00 	movzbl 0x83c(%edx),%edx
 452:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 456:	89 ca                	mov    %ecx,%edx
 458:	89 c1                	mov    %eax,%ecx
 45a:	39 da                	cmp    %ebx,%edx
 45c:	73 e2                	jae    440 <printint+0x30>
  if(neg)
 45e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 461:	85 c0                	test   %eax,%eax
 463:	74 07                	je     46c <printint+0x5c>
    buf[i++] = '-';
 465:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 46a:	89 f7                	mov    %esi,%edi
 46c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 46f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 472:	01 df                	add    %ebx,%edi
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 478:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 47b:	83 ec 04             	sub    $0x4,%esp
 47e:	88 45 d7             	mov    %al,-0x29(%ebp)
 481:	8d 45 d7             	lea    -0x29(%ebp),%eax
 484:	6a 01                	push   $0x1
 486:	50                   	push   %eax
 487:	56                   	push   %esi
 488:	e8 f6 fe ff ff       	call   383 <write>
  while(--i >= 0)
 48d:	89 f8                	mov    %edi,%eax
 48f:	83 c4 10             	add    $0x10,%esp
 492:	83 ef 01             	sub    $0x1,%edi
 495:	39 c3                	cmp    %eax,%ebx
 497:	75 df                	jne    478 <printint+0x68>
}
 499:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49c:	5b                   	pop    %ebx
 49d:	5e                   	pop    %esi
 49e:	5f                   	pop    %edi
 49f:	5d                   	pop    %ebp
 4a0:	c3                   	ret
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4a8:	31 c0                	xor    %eax,%eax
 4aa:	eb 89                	jmp    435 <printint+0x25>
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004b0 <printf>:
=======
 478:	31 db                	xor    %ebx,%ebx
 47a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 47d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 480:	89 c8                	mov    %ecx,%eax
 482:	31 d2                	xor    %edx,%edx
 484:	89 cf                	mov    %ecx,%edi
 486:	f7 75 c4             	divl   -0x3c(%ebp)
 489:	0f b6 92 ac 08 00 00 	movzbl 0x8ac(%edx),%edx
 490:	89 45 c0             	mov    %eax,-0x40(%ebp)
 493:	89 d8                	mov    %ebx,%eax
 495:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 498:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 49b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 49e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4a1:	76 dd                	jbe    480 <printint+0x30>
  if(neg)
 4a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4a6:	85 c9                	test   %ecx,%ecx
 4a8:	74 0c                	je     4b6 <printint+0x66>
    buf[i++] = '-';
 4aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4bd:	eb 07                	jmp    4c6 <printint+0x76>
 4bf:	90                   	nop
    putc(fd, buf[i]);
 4c0:	0f b6 13             	movzbl (%ebx),%edx
 4c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4c6:	83 ec 04             	sub    $0x4,%esp
 4c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4cc:	6a 01                	push   $0x1
 4ce:	56                   	push   %esi
 4cf:	57                   	push   %edi
 4d0:	e8 de fe ff ff       	call   3b3 <write>
  while(--i >= 0)
 4d5:	83 c4 10             	add    $0x10,%esp
 4d8:	39 de                	cmp    %ebx,%esi
 4da:	75 e4                	jne    4c0 <printint+0x70>
}
 4dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5f                   	pop    %edi
 4e2:	5d                   	pop    %ebp
 4e3:	c3                   	ret    
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4ef:	eb 87                	jmp    478 <printint+0x28>
 4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ff:	90                   	nop

00000500 <printf>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
<<<<<<< HEAD
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
=======
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 2c             	sub    $0x2c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
<<<<<<< HEAD
 4b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4bf:	0f b6 1e             	movzbl (%esi),%ebx
 4c2:	83 c6 01             	add    $0x1,%esi
 4c5:	84 db                	test   %bl,%bl
 4c7:	74 67                	je     530 <printf+0x80>
 4c9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4cc:	31 d2                	xor    %edx,%edx
 4ce:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4d1:	eb 34                	jmp    507 <printf+0x57>
 4d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
=======
 509:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 50c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 50f:	0f b6 13             	movzbl (%ebx),%edx
 512:	84 d2                	test   %dl,%dl
 514:	74 6a                	je     580 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 516:	8d 45 10             	lea    0x10(%ebp),%eax
 519:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 51c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 51f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 521:	89 45 d0             	mov    %eax,-0x30(%ebp)
 524:	eb 36                	jmp    55c <printf+0x5c>
 526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
<<<<<<< HEAD
 4db:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4e0:	83 f8 25             	cmp    $0x25,%eax
 4e3:	74 18                	je     4fd <printf+0x4d>
  write(fd, &c, 1);
 4e5:	83 ec 04             	sub    $0x4,%esp
 4e8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4eb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4ee:	6a 01                	push   $0x1
 4f0:	50                   	push   %eax
 4f1:	57                   	push   %edi
 4f2:	e8 8c fe ff ff       	call   383 <write>
 4f7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4fa:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4fd:	0f b6 1e             	movzbl (%esi),%ebx
 500:	83 c6 01             	add    $0x1,%esi
 503:	84 db                	test   %bl,%bl
 505:	74 29                	je     530 <printf+0x80>
    c = fmt[i] & 0xff;
 507:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 50a:	85 d2                	test   %edx,%edx
 50c:	74 ca                	je     4d8 <printf+0x28>
      }
    } else if(state == '%'){
 50e:	83 fa 25             	cmp    $0x25,%edx
 511:	75 ea                	jne    4fd <printf+0x4d>
      if(c == 'd'){
 513:	83 f8 25             	cmp    $0x25,%eax
 516:	0f 84 04 01 00 00    	je     620 <printf+0x170>
 51c:	83 e8 63             	sub    $0x63,%eax
 51f:	83 f8 15             	cmp    $0x15,%eax
 522:	77 1c                	ja     540 <printf+0x90>
 524:	ff 24 85 e4 07 00 00 	jmp    *0x7e4(,%eax,4)
 52b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
=======
 533:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 538:	83 f8 25             	cmp    $0x25,%eax
 53b:	74 15                	je     552 <printf+0x52>
  write(fd, &c, 1);
 53d:	83 ec 04             	sub    $0x4,%esp
 540:	88 55 e7             	mov    %dl,-0x19(%ebp)
 543:	6a 01                	push   $0x1
 545:	57                   	push   %edi
 546:	56                   	push   %esi
 547:	e8 67 fe ff ff       	call   3b3 <write>
 54c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 54f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 552:	0f b6 13             	movzbl (%ebx),%edx
 555:	83 c3 01             	add    $0x1,%ebx
 558:	84 d2                	test   %dl,%dl
 55a:	74 24                	je     580 <printf+0x80>
    c = fmt[i] & 0xff;
 55c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 55f:	85 c9                	test   %ecx,%ecx
 561:	74 cd                	je     530 <printf+0x30>
      }
    } else if(state == '%'){
 563:	83 f9 25             	cmp    $0x25,%ecx
 566:	75 ea                	jne    552 <printf+0x52>
      if(c == 'd'){
 568:	83 f8 25             	cmp    $0x25,%eax
 56b:	0f 84 07 01 00 00    	je     678 <printf+0x178>
 571:	83 e8 63             	sub    $0x63,%eax
 574:	83 f8 15             	cmp    $0x15,%eax
 577:	77 17                	ja     590 <printf+0x90>
 579:	ff 24 85 54 08 00 00 	jmp    *0x854(,%eax,4)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        putc(fd, c);
      }
      state = 0;
    }
  }
}
<<<<<<< HEAD
 530:	8d 65 f4             	lea    -0xc(%ebp),%esp
 533:	5b                   	pop    %ebx
 534:	5e                   	pop    %esi
 535:	5f                   	pop    %edi
 536:	5d                   	pop    %ebp
 537:	c3                   	ret
 538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53f:	00 
  write(fd, &c, 1);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	8d 55 e7             	lea    -0x19(%ebp),%edx
 546:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 54a:	6a 01                	push   $0x1
 54c:	52                   	push   %edx
 54d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 550:	57                   	push   %edi
 551:	e8 2d fe ff ff       	call   383 <write>
 556:	83 c4 0c             	add    $0xc,%esp
 559:	88 5d e7             	mov    %bl,-0x19(%ebp)
 55c:	6a 01                	push   $0x1
 55e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 561:	52                   	push   %edx
 562:	57                   	push   %edi
 563:	e8 1b fe ff ff       	call   383 <write>
        putc(fd, c);
 568:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56b:	31 d2                	xor    %edx,%edx
 56d:	eb 8e                	jmp    4fd <printf+0x4d>
 56f:	90                   	nop
        printint(fd, *ap, 16, 0);
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 573:	83 ec 0c             	sub    $0xc,%esp
 576:	b9 10 00 00 00       	mov    $0x10,%ecx
 57b:	8b 13                	mov    (%ebx),%edx
 57d:	6a 00                	push   $0x0
 57f:	89 f8                	mov    %edi,%eax
        ap++;
 581:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 584:	e8 87 fe ff ff       	call   410 <printint>
        ap++;
 589:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 58c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 67 ff ff ff       	jmp    4fd <printf+0x4d>
        s = (char*)*ap;
 596:	8b 45 d0             	mov    -0x30(%ebp),%eax
 599:	8b 18                	mov    (%eax),%ebx
        ap++;
 59b:	83 c0 04             	add    $0x4,%eax
 59e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5a1:	85 db                	test   %ebx,%ebx
 5a3:	0f 84 87 00 00 00    	je     630 <printf+0x180>
        while(*s != 0){
 5a9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5ac:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5ae:	84 c0                	test   %al,%al
 5b0:	0f 84 47 ff ff ff    	je     4fd <printf+0x4d>
 5b6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5b9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5bc:	89 de                	mov    %ebx,%esi
 5be:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5c6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5c9:	6a 01                	push   $0x1
 5cb:	53                   	push   %ebx
 5cc:	57                   	push   %edi
 5cd:	e8 b1 fd ff ff       	call   383 <write>
        while(*s != 0){
 5d2:	0f b6 06             	movzbl (%esi),%eax
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	84 c0                	test   %al,%al
 5da:	75 e4                	jne    5c0 <printf+0x110>
      state = 0;
 5dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5df:	31 d2                	xor    %edx,%edx
 5e1:	e9 17 ff ff ff       	jmp    4fd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 5e6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5e9:	83 ec 0c             	sub    $0xc,%esp
 5ec:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5f1:	8b 13                	mov    (%ebx),%edx
 5f3:	6a 01                	push   $0x1
 5f5:	eb 88                	jmp    57f <printf+0xcf>
        putc(fd, *ap);
 5f7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5fa:	83 ec 04             	sub    $0x4,%esp
 5fd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 600:	8b 03                	mov    (%ebx),%eax
        ap++;
 602:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 605:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 608:	6a 01                	push   $0x1
 60a:	52                   	push   %edx
 60b:	57                   	push   %edi
 60c:	e8 72 fd ff ff       	call   383 <write>
        ap++;
 611:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 614:	83 c4 10             	add    $0x10,%esp
      state = 0;
 617:	31 d2                	xor    %edx,%edx
 619:	e9 df fe ff ff       	jmp    4fd <printf+0x4d>
 61e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 620:	83 ec 04             	sub    $0x4,%esp
 623:	88 5d e7             	mov    %bl,-0x19(%ebp)
 626:	8d 55 e7             	lea    -0x19(%ebp),%edx
 629:	6a 01                	push   $0x1
 62b:	e9 31 ff ff ff       	jmp    561 <printf+0xb1>
 630:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 635:	bb db 07 00 00       	mov    $0x7db,%ebx
 63a:	e9 77 ff ff ff       	jmp    5b6 <printf+0x106>
 63f:	90                   	nop

00000640 <free>:
=======
 580:	8d 65 f4             	lea    -0xc(%ebp),%esp
 583:	5b                   	pop    %ebx
 584:	5e                   	pop    %esi
 585:	5f                   	pop    %edi
 586:	5d                   	pop    %ebp
 587:	c3                   	ret    
 588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 596:	6a 01                	push   $0x1
 598:	57                   	push   %edi
 599:	56                   	push   %esi
 59a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 59e:	e8 10 fe ff ff       	call   3b3 <write>
        putc(fd, c);
 5a3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 5a7:	83 c4 0c             	add    $0xc,%esp
 5aa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5ad:	6a 01                	push   $0x1
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	e8 fd fd ff ff       	call   3b3 <write>
        putc(fd, c);
 5b6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b9:	31 c9                	xor    %ecx,%ecx
 5bb:	eb 95                	jmp    552 <printf+0x52>
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5c8:	6a 00                	push   $0x0
 5ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5cd:	8b 10                	mov    (%eax),%edx
 5cf:	89 f0                	mov    %esi,%eax
 5d1:	e8 7a fe ff ff       	call   450 <printint>
        ap++;
 5d6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5da:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5dd:	31 c9                	xor    %ecx,%ecx
 5df:	e9 6e ff ff ff       	jmp    552 <printf+0x52>
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5eb:	8b 10                	mov    (%eax),%edx
        ap++;
 5ed:	83 c0 04             	add    $0x4,%eax
 5f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5f3:	85 d2                	test   %edx,%edx
 5f5:	0f 84 8d 00 00 00    	je     688 <printf+0x188>
        while(*s != 0){
 5fb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 5fe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 600:	84 c0                	test   %al,%al
 602:	0f 84 4a ff ff ff    	je     552 <printf+0x52>
 608:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 60b:	89 d3                	mov    %edx,%ebx
 60d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
          s++;
 613:	83 c3 01             	add    $0x1,%ebx
 616:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 619:	6a 01                	push   $0x1
 61b:	57                   	push   %edi
 61c:	56                   	push   %esi
 61d:	e8 91 fd ff ff       	call   3b3 <write>
        while(*s != 0){
 622:	0f b6 03             	movzbl (%ebx),%eax
 625:	83 c4 10             	add    $0x10,%esp
 628:	84 c0                	test   %al,%al
 62a:	75 e4                	jne    610 <printf+0x110>
      state = 0;
 62c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 62f:	31 c9                	xor    %ecx,%ecx
 631:	e9 1c ff ff ff       	jmp    552 <printf+0x52>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 0a 00 00 00       	mov    $0xa,%ecx
 648:	6a 01                	push   $0x1
 64a:	e9 7b ff ff ff       	jmp    5ca <printf+0xca>
 64f:	90                   	nop
        putc(fd, *ap);
 650:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 653:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 656:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 658:	6a 01                	push   $0x1
 65a:	57                   	push   %edi
 65b:	56                   	push   %esi
        putc(fd, *ap);
 65c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 65f:	e8 4f fd ff ff       	call   3b3 <write>
        ap++;
 664:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 668:	83 c4 10             	add    $0x10,%esp
      state = 0;
 66b:	31 c9                	xor    %ecx,%ecx
 66d:	e9 e0 fe ff ff       	jmp    552 <printf+0x52>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 678:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 67b:	83 ec 04             	sub    $0x4,%esp
 67e:	e9 2a ff ff ff       	jmp    5ad <printf+0xad>
 683:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 687:	90                   	nop
          s = "(null)";
 688:	ba 4b 08 00 00       	mov    $0x84b,%edx
        while(*s != 0){
 68d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 690:	b8 28 00 00 00       	mov    $0x28,%eax
 695:	89 d3                	mov    %edx,%ebx
 697:	e9 74 ff ff ff       	jmp    610 <printf+0x110>
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
static Header base;
static Header *freep;

void
free(void *ap)
{
<<<<<<< HEAD
 640:	55                   	push   %ebp
=======
 6a0:	55                   	push   %ebp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
<<<<<<< HEAD
 641:	a1 e8 0a 00 00       	mov    0xae8,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 658:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65a:	39 c8                	cmp    %ecx,%eax
 65c:	73 32                	jae    690 <free+0x50>
 65e:	39 d1                	cmp    %edx,%ecx
 660:	72 04                	jb     666 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	39 d0                	cmp    %edx,%eax
 664:	72 32                	jb     698 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 666:	8b 73 fc             	mov    -0x4(%ebx),%esi
 669:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 66c:	39 fa                	cmp    %edi,%edx
 66e:	74 30                	je     6a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 670:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 673:	8b 50 04             	mov    0x4(%eax),%edx
 676:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 679:	39 f1                	cmp    %esi,%ecx
 67b:	74 3a                	je     6b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 67d:	89 08                	mov    %ecx,(%eax)
=======
 6a1:	a1 64 0b 00 00       	mov    0xb64,%eax
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b8:	89 c2                	mov    %eax,%edx
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	39 ca                	cmp    %ecx,%edx
 6be:	73 30                	jae    6f0 <free+0x50>
 6c0:	39 c1                	cmp    %eax,%ecx
 6c2:	72 04                	jb     6c8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	39 c2                	cmp    %eax,%edx
 6c6:	72 f0                	jb     6b8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 f8                	cmp    %edi,%eax
 6d0:	74 30                	je     702 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6d5:	8b 42 04             	mov    0x4(%edx),%eax
 6d8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 3a                	je     719 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6df:	89 0a                	mov    %ecx,(%edx)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else
    p->s.ptr = bp;
  freep = p;
}
<<<<<<< HEAD
 67f:	5b                   	pop    %ebx
  freep = p;
 680:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 685:	5e                   	pop    %esi
 686:	5f                   	pop    %edi
 687:	5d                   	pop    %ebp
 688:	c3                   	ret
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	39 d0                	cmp    %edx,%eax
 692:	72 04                	jb     698 <free+0x58>
 694:	39 d1                	cmp    %edx,%ecx
 696:	72 ce                	jb     666 <free+0x26>
{
 698:	89 d0                	mov    %edx,%eax
 69a:	eb bc                	jmp    658 <free+0x18>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6a0:	03 72 04             	add    0x4(%edx),%esi
 6a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a6:	8b 10                	mov    (%eax),%edx
 6a8:	8b 12                	mov    (%edx),%edx
 6aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b3:	39 f1                	cmp    %esi,%ecx
 6b5:	75 c6                	jne    67d <free+0x3d>
    p->s.size += bp->s.size;
 6b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ba:	a3 e8 0a 00 00       	mov    %eax,0xae8
    p->s.size += bp->s.size;
 6bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6c5:	89 08                	mov    %ecx,(%eax)
}
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	5d                   	pop    %ebp
 6cb:	c3                   	ret
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006d0 <malloc>:
=======
 6e1:	5b                   	pop    %ebx
  freep = p;
 6e2:	89 15 64 0b 00 00    	mov    %edx,0xb64
}
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret    
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 c2                	cmp    %eax,%edx
 6f2:	72 c4                	jb     6b8 <free+0x18>
 6f4:	39 c1                	cmp    %eax,%ecx
 6f6:	73 c0                	jae    6b8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 f8                	cmp    %edi,%eax
 700:	75 d0                	jne    6d2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 702:	03 70 04             	add    0x4(%eax),%esi
 705:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 708:	8b 02                	mov    (%edx),%eax
 70a:	8b 00                	mov    (%eax),%eax
 70c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 70f:	8b 42 04             	mov    0x4(%edx),%eax
 712:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 715:	39 f1                	cmp    %esi,%ecx
 717:	75 c6                	jne    6df <free+0x3f>
    p->s.size += bp->s.size;
 719:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 71c:	89 15 64 0b 00 00    	mov    %edx,0xb64
    p->s.size += bp->s.size;
 722:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 725:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 728:	89 0a                	mov    %ecx,(%edx)
}
 72a:	5b                   	pop    %ebx
 72b:	5e                   	pop    %esi
 72c:	5f                   	pop    %edi
 72d:	5d                   	pop    %ebp
 72e:	c3                   	ret    
 72f:	90                   	nop

00000730 <malloc>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  return freep;
}

void*
malloc(uint nbytes)
{
<<<<<<< HEAD
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 0c             	sub    $0xc,%esp
=======
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 1c             	sub    $0x1c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
<<<<<<< HEAD
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 15 e8 0a 00 00    	mov    0xae8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 78 07             	lea    0x7(%eax),%edi
 6e5:	c1 ef 03             	shr    $0x3,%edi
 6e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6eb:	85 d2                	test   %edx,%edx
 6ed:	0f 84 8d 00 00 00    	je     780 <malloc+0xb0>
=======
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 3d 64 0b 00 00    	mov    0xb64,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 70 07             	lea    0x7(%eax),%esi
 745:	c1 ee 03             	shr    $0x3,%esi
 748:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 74b:	85 ff                	test   %edi,%edi
 74d:	0f 84 9d 00 00 00    	je     7f0 <malloc+0xc0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
<<<<<<< HEAD
 6f3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f5:	8b 48 04             	mov    0x4(%eax),%ecx
 6f8:	39 f9                	cmp    %edi,%ecx
 6fa:	73 64                	jae    760 <malloc+0x90>
  if(nu < 4096)
 6fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 701:	39 df                	cmp    %ebx,%edi
 703:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 706:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 70d:	eb 0a                	jmp    719 <malloc+0x49>
 70f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 712:	8b 48 04             	mov    0x4(%eax),%ecx
 715:	39 f9                	cmp    %edi,%ecx
 717:	73 47                	jae    760 <malloc+0x90>
=======
 753:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 755:	8b 4a 04             	mov    0x4(%edx),%ecx
 758:	39 f1                	cmp    %esi,%ecx
 75a:	73 6a                	jae    7c6 <malloc+0x96>
 75c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 761:	39 de                	cmp    %ebx,%esi
 763:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 766:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 76d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 770:	eb 17                	jmp    789 <malloc+0x59>
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 77a:	8b 48 04             	mov    0x4(%eax),%ecx
 77d:	39 f1                	cmp    %esi,%ecx
 77f:	73 4f                	jae    7d0 <malloc+0xa0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
<<<<<<< HEAD
 719:	89 c2                	mov    %eax,%edx
 71b:	3b 05 e8 0a 00 00    	cmp    0xae8,%eax
 721:	75 ed                	jne    710 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 723:	83 ec 0c             	sub    $0xc,%esp
 726:	56                   	push   %esi
 727:	e8 bf fc ff ff       	call   3eb <sbrk>
  if(p == (char*)-1)
 72c:	83 c4 10             	add    $0x10,%esp
 72f:	83 f8 ff             	cmp    $0xffffffff,%eax
 732:	74 1c                	je     750 <malloc+0x80>
  hp->s.size = nu;
 734:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 737:	83 ec 0c             	sub    $0xc,%esp
 73a:	83 c0 08             	add    $0x8,%eax
 73d:	50                   	push   %eax
 73e:	e8 fd fe ff ff       	call   640 <free>
  return freep;
 743:	8b 15 e8 0a 00 00    	mov    0xae8,%edx
      if((p = morecore(nunits)) == 0)
 749:	83 c4 10             	add    $0x10,%esp
 74c:	85 d2                	test   %edx,%edx
 74e:	75 c0                	jne    710 <malloc+0x40>
        return 0;
  }
}
 750:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 753:	31 c0                	xor    %eax,%eax
}
 755:	5b                   	pop    %ebx
 756:	5e                   	pop    %esi
 757:	5f                   	pop    %edi
 758:	5d                   	pop    %ebp
 759:	c3                   	ret
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 760:	39 cf                	cmp    %ecx,%edi
 762:	74 4c                	je     7b0 <malloc+0xe0>
        p->s.size -= nunits;
 764:	29 f9                	sub    %edi,%ecx
 766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 76c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 76f:	89 15 e8 0a 00 00    	mov    %edx,0xae8
}
 775:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 778:	83 c0 08             	add    $0x8,%eax
}
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 e8 0a 00 00 ec 	movl   $0xaec,0xae8
 787:	0a 00 00 
    base.s.size = 0;
 78a:	b8 ec 0a 00 00       	mov    $0xaec,%eax
    base.s.ptr = freep = prevp = &base;
 78f:	c7 05 ec 0a 00 00 ec 	movl   $0xaec,0xaec
 796:	0a 00 00 
    base.s.size = 0;
 799:	c7 05 f0 0a 00 00 00 	movl   $0x0,0xaf0
 7a0:	00 00 00 
    if(p->s.size >= nunits){
 7a3:	e9 54 ff ff ff       	jmp    6fc <malloc+0x2c>
 7a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7af:	00 
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b9                	jmp    76f <malloc+0x9f>
=======
 781:	8b 3d 64 0b 00 00    	mov    0xb64,%edi
 787:	89 c2                	mov    %eax,%edx
 789:	39 d7                	cmp    %edx,%edi
 78b:	75 eb                	jne    778 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 78d:	83 ec 0c             	sub    $0xc,%esp
 790:	ff 75 e4             	push   -0x1c(%ebp)
 793:	e8 83 fc ff ff       	call   41b <sbrk>
  if(p == (char*)-1)
 798:	83 c4 10             	add    $0x10,%esp
 79b:	83 f8 ff             	cmp    $0xffffffff,%eax
 79e:	74 1c                	je     7bc <malloc+0x8c>
  hp->s.size = nu;
 7a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7a3:	83 ec 0c             	sub    $0xc,%esp
 7a6:	83 c0 08             	add    $0x8,%eax
 7a9:	50                   	push   %eax
 7aa:	e8 f1 fe ff ff       	call   6a0 <free>
  return freep;
 7af:	8b 15 64 0b 00 00    	mov    0xb64,%edx
      if((p = morecore(nunits)) == 0)
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	85 d2                	test   %edx,%edx
 7ba:	75 bc                	jne    778 <malloc+0x48>
        return 0;
  }
}
 7bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7bf:	31 c0                	xor    %eax,%eax
}
 7c1:	5b                   	pop    %ebx
 7c2:	5e                   	pop    %esi
 7c3:	5f                   	pop    %edi
 7c4:	5d                   	pop    %ebp
 7c5:	c3                   	ret    
    if(p->s.size >= nunits){
 7c6:	89 d0                	mov    %edx,%eax
 7c8:	89 fa                	mov    %edi,%edx
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7d0:	39 ce                	cmp    %ecx,%esi
 7d2:	74 4c                	je     820 <malloc+0xf0>
        p->s.size -= nunits;
 7d4:	29 f1                	sub    %esi,%ecx
 7d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7dc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7df:	89 15 64 0b 00 00    	mov    %edx,0xb64
}
 7e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7e8:	83 c0 08             	add    $0x8,%eax
}
 7eb:	5b                   	pop    %ebx
 7ec:	5e                   	pop    %esi
 7ed:	5f                   	pop    %edi
 7ee:	5d                   	pop    %ebp
 7ef:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 64 0b 00 00 68 	movl   $0xb68,0xb64
 7f7:	0b 00 00 
    base.s.size = 0;
 7fa:	bf 68 0b 00 00       	mov    $0xb68,%edi
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 68 0b 00 00 68 	movl   $0xb68,0xb68
 806:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 80b:	c7 05 6c 0b 00 00 00 	movl   $0x0,0xb6c
 812:	00 00 00 
    if(p->s.size >= nunits){
 815:	e9 42 ff ff ff       	jmp    75c <malloc+0x2c>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb b9                	jmp    7df <malloc+0xaf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
