
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 55 02 00 00       	call   26b <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 df 02 00 00       	call   303 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 47 02 00 00       	call   273 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  51:	89 c8                	mov    %ecx,%eax
  53:	c9                   	leave
  54:	c3                   	ret
  55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  5c:	00 
  5d:	8d 76 00             	lea    0x0(%esi),%esi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 17                	jne    88 <strcmp+0x28>
  71:	eb 3a                	jmp    ad <strcmp+0x4d>
  73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  7c:	83 c2 01             	add    $0x1,%edx
  7f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  82:	84 c0                	test   %al,%al
  84:	74 1a                	je     a0 <strcmp+0x40>
  86:	89 d9                	mov    %ebx,%ecx
  88:	0f b6 19             	movzbl (%ecx),%ebx
  8b:	38 c3                	cmp    %al,%bl
  8d:	74 e9                	je     78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  8f:	29 d8                	sub    %ebx,%eax
}
  91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  94:	c9                   	leave
  95:	c3                   	ret
  96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9d:	00 
  9e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  a4:	31 c0                	xor    %eax,%eax
  a6:	29 d8                	sub    %ebx,%eax
}
  a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ab:	c9                   	leave
  ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	31 c0                	xor    %eax,%eax
  b2:	eb db                	jmp    8f <strcmp+0x2f>
  b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bb:	00 
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  c6:	80 3a 00             	cmpb   $0x0,(%edx)
  c9:	74 15                	je     e0 <strlen+0x20>
  cb:	31 c0                	xor    %eax,%eax
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c0 01             	add    $0x1,%eax
  d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  d7:	89 c1                	mov    %eax,%ecx
  d9:	75 f5                	jne    d0 <strlen+0x10>
    ;
  return n;
}
  db:	89 c8                	mov    %ecx,%eax
  dd:	5d                   	pop    %ebp
  de:	c3                   	ret
  df:	90                   	nop
  for(n = 0; s[n]; n++)
  e0:	31 c9                	xor    %ecx,%ecx
}
  e2:	5d                   	pop    %ebp
  e3:	89 c8                	mov    %ecx,%eax
  e5:	c3                   	ret
  e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ed:	00 
  ee:	66 90                	xchg   %ax,%ax

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	8b 7d fc             	mov    -0x4(%ebp),%edi
 105:	89 d0                	mov    %edx,%eax
 107:	c9                   	leave
 108:	c3                   	ret
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	75 12                	jne    133 <strchr+0x23>
 121:	eb 1d                	jmp    140 <strchr+0x30>
 123:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 128:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 12c:	83 c0 01             	add    $0x1,%eax
 12f:	84 d2                	test   %dl,%dl
 131:	74 0d                	je     140 <strchr+0x30>
    if(*s == c)
 133:	38 d1                	cmp    %dl,%cl
 135:	75 f1                	jne    128 <strchr+0x18>
      return (char*)s;
  return 0;
}
 137:	5d                   	pop    %ebp
 138:	c3                   	ret
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 140:	31 c0                	xor    %eax,%eax
}
 142:	5d                   	pop    %ebp
 143:	c3                   	ret
 144:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14b:	00 
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 155:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 158:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 159:	31 db                	xor    %ebx,%ebx
{
 15b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 15e:	eb 27                	jmp    187 <gets+0x37>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	56                   	push   %esi
 166:	6a 00                	push   $0x0
 168:	e8 1e 01 00 00       	call   28b <read>
    if(cc < 1)
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	7e 1d                	jle    191 <gets+0x41>
      break;
    buf[i++] = c;
 174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 178:	8b 55 08             	mov    0x8(%ebp),%edx
 17b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 17f:	3c 0a                	cmp    $0xa,%al
 181:	74 10                	je     193 <gets+0x43>
 183:	3c 0d                	cmp    $0xd,%al
 185:	74 0c                	je     193 <gets+0x43>
  for(i=0; i+1 < max; ){
 187:	89 df                	mov    %ebx,%edi
 189:	83 c3 01             	add    $0x1,%ebx
 18c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 18f:	7c cf                	jl     160 <gets+0x10>
 191:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 19a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19d:	5b                   	pop    %ebx
 19e:	5e                   	pop    %esi
 19f:	5f                   	pop    %edi
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret
 1a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a9:	00 
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	push   0x8(%ebp)
 1bd:	e8 f1 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	push   0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f4 00 00 00       	call   2cb <fstat>
  close(fd);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1da:	89 c6                	mov    %eax,%esi
  close(fd);
 1dc:	e8 ba 00 00 00       	call   29b <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
}
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 20d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 210:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 215:	77 1e                	ja     235 <atoi+0x35>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 238:	89 c8                	mov    %ecx,%eax
 23a:	c9                   	leave
 23b:	c3                   	ret
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	8b 55 08             	mov    0x8(%ebp),%edx
 24a:	56                   	push   %esi
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <uptime>:
SYSCALL(uptime)
<<<<<<< HEAD
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <move_file>:
SYSCALL(move_file)
 313:	b8 17 00 00 00       	mov    $0x17,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <printint>:
=======
 31b:	b8 0e 00 00 00       	mov    $0xe,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <sort_syscalls>:
SYSCALL(sort_syscalls)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 32b:	b8 19 00 00 00       	mov    $0x19,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <list_active_processes>:
SYSCALL(list_active_processes)
 333:	b8 1a 00 00 00       	mov    $0x1a,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    
 33b:	66 90                	xchg   %ax,%ax
 33d:	66 90                	xchg   %ax,%ax
 33f:	90                   	nop

00000340 <printint>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
<<<<<<< HEAD
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	89 cb                	mov    %ecx,%ebx
=======
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 3c             	sub    $0x3c,%esp
 349:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
<<<<<<< HEAD
 328:	89 d1                	mov    %edx,%ecx
{
 32a:	83 ec 3c             	sub    $0x3c,%esp
 32d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 330:	85 d2                	test   %edx,%edx
 332:	0f 89 80 00 00 00    	jns    3b8 <printint+0x98>
 338:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 33c:	74 7a                	je     3b8 <printint+0x98>
    x = -xx;
 33e:	f7 d9                	neg    %ecx
    neg = 1;
 340:	b8 01 00 00 00       	mov    $0x1,%eax
=======
 34c:	89 d1                	mov    %edx,%ecx
{
 34e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 351:	85 d2                	test   %edx,%edx
 353:	0f 89 7f 00 00 00    	jns    3d8 <printint+0x98>
 359:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 35d:	74 79                	je     3d8 <printint+0x98>
    neg = 1;
 35f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 366:	f7 d9                	neg    %ecx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else {
    x = xx;
  }

  i = 0;
<<<<<<< HEAD
 345:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 348:	31 f6                	xor    %esi,%esi
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 350:	89 c8                	mov    %ecx,%eax
 352:	31 d2                	xor    %edx,%edx
 354:	89 f7                	mov    %esi,%edi
 356:	f7 f3                	div    %ebx
 358:	8d 76 01             	lea    0x1(%esi),%esi
 35b:	0f b6 92 28 07 00 00 	movzbl 0x728(%edx),%edx
 362:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 366:	89 ca                	mov    %ecx,%edx
 368:	89 c1                	mov    %eax,%ecx
 36a:	39 da                	cmp    %ebx,%edx
 36c:	73 e2                	jae    350 <printint+0x30>
  if(neg)
 36e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 371:	85 c0                	test   %eax,%eax
 373:	74 07                	je     37c <printint+0x5c>
    buf[i++] = '-';
 375:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 37a:	89 f7                	mov    %esi,%edi
 37c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 37f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 382:	01 df                	add    %ebx,%edi
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 388:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 38b:	83 ec 04             	sub    $0x4,%esp
 38e:	88 45 d7             	mov    %al,-0x29(%ebp)
 391:	8d 45 d7             	lea    -0x29(%ebp),%eax
 394:	6a 01                	push   $0x1
 396:	50                   	push   %eax
 397:	56                   	push   %esi
 398:	e8 f6 fe ff ff       	call   293 <write>
  while(--i >= 0)
 39d:	89 f8                	mov    %edi,%eax
 39f:	83 c4 10             	add    $0x10,%esp
 3a2:	83 ef 01             	sub    $0x1,%edi
 3a5:	39 c3                	cmp    %eax,%ebx
 3a7:	75 df                	jne    388 <printint+0x68>
}
 3a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3b8:	31 c0                	xor    %eax,%eax
 3ba:	eb 89                	jmp    345 <printint+0x25>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <printf>:
=======
 368:	31 db                	xor    %ebx,%ebx
 36a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 36d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 370:	89 c8                	mov    %ecx,%eax
 372:	31 d2                	xor    %edx,%edx
 374:	89 cf                	mov    %ecx,%edi
 376:	f7 75 c4             	divl   -0x3c(%ebp)
 379:	0f b6 92 78 07 00 00 	movzbl 0x778(%edx),%edx
 380:	89 45 c0             	mov    %eax,-0x40(%ebp)
 383:	89 d8                	mov    %ebx,%eax
 385:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 388:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 38b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 38e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 391:	76 dd                	jbe    370 <printint+0x30>
  if(neg)
 393:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 396:	85 c9                	test   %ecx,%ecx
 398:	74 0c                	je     3a6 <printint+0x66>
    buf[i++] = '-';
 39a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 39f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 3a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 3a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3ad:	eb 07                	jmp    3b6 <printint+0x76>
 3af:	90                   	nop
    putc(fd, buf[i]);
 3b0:	0f b6 13             	movzbl (%ebx),%edx
 3b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 3b6:	83 ec 04             	sub    $0x4,%esp
 3b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3bc:	6a 01                	push   $0x1
 3be:	56                   	push   %esi
 3bf:	57                   	push   %edi
 3c0:	e8 de fe ff ff       	call   2a3 <write>
  while(--i >= 0)
 3c5:	83 c4 10             	add    $0x10,%esp
 3c8:	39 de                	cmp    %ebx,%esi
 3ca:	75 e4                	jne    3b0 <printint+0x70>
}
 3cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5f                   	pop    %edi
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3df:	eb 87                	jmp    368 <printint+0x28>
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop

000003f0 <printf>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
<<<<<<< HEAD
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 2c             	sub    $0x2c,%esp
=======
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 2c             	sub    $0x2c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
<<<<<<< HEAD
 3c9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 3cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 3cf:	0f b6 1e             	movzbl (%esi),%ebx
 3d2:	83 c6 01             	add    $0x1,%esi
 3d5:	84 db                	test   %bl,%bl
 3d7:	74 67                	je     440 <printf+0x80>
 3d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3dc:	31 d2                	xor    %edx,%edx
 3de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 3e1:	eb 34                	jmp    417 <printf+0x57>
 3e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
=======
 3f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 3fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 3ff:	0f b6 13             	movzbl (%ebx),%edx
 402:	84 d2                	test   %dl,%dl
 404:	74 6a                	je     470 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 406:	8d 45 10             	lea    0x10(%ebp),%eax
 409:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 40c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 40f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 411:	89 45 d0             	mov    %eax,-0x30(%ebp)
 414:	eb 36                	jmp    44c <printf+0x5c>
 416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
<<<<<<< HEAD
 3eb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	74 18                	je     40d <printf+0x4d>
  write(fd, &c, 1);
 3f5:	83 ec 04             	sub    $0x4,%esp
 3f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 3fe:	6a 01                	push   $0x1
 400:	50                   	push   %eax
 401:	57                   	push   %edi
 402:	e8 8c fe ff ff       	call   293 <write>
 407:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 40a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 40d:	0f b6 1e             	movzbl (%esi),%ebx
 410:	83 c6 01             	add    $0x1,%esi
 413:	84 db                	test   %bl,%bl
 415:	74 29                	je     440 <printf+0x80>
    c = fmt[i] & 0xff;
 417:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 41a:	85 d2                	test   %edx,%edx
 41c:	74 ca                	je     3e8 <printf+0x28>
      }
    } else if(state == '%'){
 41e:	83 fa 25             	cmp    $0x25,%edx
 421:	75 ea                	jne    40d <printf+0x4d>
      if(c == 'd'){
 423:	83 f8 25             	cmp    $0x25,%eax
 426:	0f 84 04 01 00 00    	je     530 <printf+0x170>
 42c:	83 e8 63             	sub    $0x63,%eax
 42f:	83 f8 15             	cmp    $0x15,%eax
 432:	77 1c                	ja     450 <printf+0x90>
 434:	ff 24 85 d0 06 00 00 	jmp    *0x6d0(,%eax,4)
 43b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
=======
 423:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 428:	83 f8 25             	cmp    $0x25,%eax
 42b:	74 15                	je     442 <printf+0x52>
  write(fd, &c, 1);
 42d:	83 ec 04             	sub    $0x4,%esp
 430:	88 55 e7             	mov    %dl,-0x19(%ebp)
 433:	6a 01                	push   $0x1
 435:	57                   	push   %edi
 436:	56                   	push   %esi
 437:	e8 67 fe ff ff       	call   2a3 <write>
 43c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 43f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 442:	0f b6 13             	movzbl (%ebx),%edx
 445:	83 c3 01             	add    $0x1,%ebx
 448:	84 d2                	test   %dl,%dl
 44a:	74 24                	je     470 <printf+0x80>
    c = fmt[i] & 0xff;
 44c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 44f:	85 c9                	test   %ecx,%ecx
 451:	74 cd                	je     420 <printf+0x30>
      }
    } else if(state == '%'){
 453:	83 f9 25             	cmp    $0x25,%ecx
 456:	75 ea                	jne    442 <printf+0x52>
      if(c == 'd'){
 458:	83 f8 25             	cmp    $0x25,%eax
 45b:	0f 84 07 01 00 00    	je     568 <printf+0x178>
 461:	83 e8 63             	sub    $0x63,%eax
 464:	83 f8 15             	cmp    $0x15,%eax
 467:	77 17                	ja     480 <printf+0x90>
 469:	ff 24 85 20 07 00 00 	jmp    *0x720(,%eax,4)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        putc(fd, c);
      }
      state = 0;
    }
  }
}
<<<<<<< HEAD
 440:	8d 65 f4             	lea    -0xc(%ebp),%esp
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5f                   	pop    %edi
 446:	5d                   	pop    %ebp
 447:	c3                   	ret
 448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44f:	00 
  write(fd, &c, 1);
 450:	83 ec 04             	sub    $0x4,%esp
 453:	8d 55 e7             	lea    -0x19(%ebp),%edx
 456:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 45a:	6a 01                	push   $0x1
 45c:	52                   	push   %edx
 45d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 460:	57                   	push   %edi
 461:	e8 2d fe ff ff       	call   293 <write>
 466:	83 c4 0c             	add    $0xc,%esp
 469:	88 5d e7             	mov    %bl,-0x19(%ebp)
 46c:	6a 01                	push   $0x1
 46e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 471:	52                   	push   %edx
 472:	57                   	push   %edi
 473:	e8 1b fe ff ff       	call   293 <write>
        putc(fd, c);
 478:	83 c4 10             	add    $0x10,%esp
      state = 0;
 47b:	31 d2                	xor    %edx,%edx
 47d:	eb 8e                	jmp    40d <printf+0x4d>
 47f:	90                   	nop
        printint(fd, *ap, 16, 0);
 480:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 483:	83 ec 0c             	sub    $0xc,%esp
 486:	b9 10 00 00 00       	mov    $0x10,%ecx
 48b:	8b 13                	mov    (%ebx),%edx
 48d:	6a 00                	push   $0x0
 48f:	89 f8                	mov    %edi,%eax
        ap++;
 491:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 494:	e8 87 fe ff ff       	call   320 <printint>
        ap++;
 499:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 49c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 49f:	31 d2                	xor    %edx,%edx
 4a1:	e9 67 ff ff ff       	jmp    40d <printf+0x4d>
        s = (char*)*ap;
 4a6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4a9:	8b 18                	mov    (%eax),%ebx
        ap++;
 4ab:	83 c0 04             	add    $0x4,%eax
 4ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4b1:	85 db                	test   %ebx,%ebx
 4b3:	0f 84 87 00 00 00    	je     540 <printf+0x180>
        while(*s != 0){
 4b9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 4bc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 4be:	84 c0                	test   %al,%al
 4c0:	0f 84 47 ff ff ff    	je     40d <printf+0x4d>
 4c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4c9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4cc:	89 de                	mov    %ebx,%esi
 4ce:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 4d6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4d9:	6a 01                	push   $0x1
 4db:	53                   	push   %ebx
 4dc:	57                   	push   %edi
 4dd:	e8 b1 fd ff ff       	call   293 <write>
        while(*s != 0){
 4e2:	0f b6 06             	movzbl (%esi),%eax
 4e5:	83 c4 10             	add    $0x10,%esp
 4e8:	84 c0                	test   %al,%al
 4ea:	75 e4                	jne    4d0 <printf+0x110>
      state = 0;
 4ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 4ef:	31 d2                	xor    %edx,%edx
 4f1:	e9 17 ff ff ff       	jmp    40d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 4f6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4f9:	83 ec 0c             	sub    $0xc,%esp
 4fc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 501:	8b 13                	mov    (%ebx),%edx
 503:	6a 01                	push   $0x1
 505:	eb 88                	jmp    48f <printf+0xcf>
        putc(fd, *ap);
 507:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 50a:	83 ec 04             	sub    $0x4,%esp
 50d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 510:	8b 03                	mov    (%ebx),%eax
        ap++;
 512:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 515:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 518:	6a 01                	push   $0x1
 51a:	52                   	push   %edx
 51b:	57                   	push   %edi
 51c:	e8 72 fd ff ff       	call   293 <write>
        ap++;
 521:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 524:	83 c4 10             	add    $0x10,%esp
      state = 0;
 527:	31 d2                	xor    %edx,%edx
 529:	e9 df fe ff ff       	jmp    40d <printf+0x4d>
 52e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 530:	83 ec 04             	sub    $0x4,%esp
 533:	88 5d e7             	mov    %bl,-0x19(%ebp)
 536:	8d 55 e7             	lea    -0x19(%ebp),%edx
 539:	6a 01                	push   $0x1
 53b:	e9 31 ff ff ff       	jmp    471 <printf+0xb1>
 540:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 545:	bb c8 06 00 00       	mov    $0x6c8,%ebx
 54a:	e9 77 ff ff ff       	jmp    4c6 <printf+0x106>
 54f:	90                   	nop

00000550 <free>:
=======
 470:	8d 65 f4             	lea    -0xc(%ebp),%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop
  write(fd, &c, 1);
 480:	83 ec 04             	sub    $0x4,%esp
 483:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 486:	6a 01                	push   $0x1
 488:	57                   	push   %edi
 489:	56                   	push   %esi
 48a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 48e:	e8 10 fe ff ff       	call   2a3 <write>
        putc(fd, c);
 493:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 497:	83 c4 0c             	add    $0xc,%esp
 49a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 49d:	6a 01                	push   $0x1
 49f:	57                   	push   %edi
 4a0:	56                   	push   %esi
 4a1:	e8 fd fd ff ff       	call   2a3 <write>
        putc(fd, c);
 4a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4a9:	31 c9                	xor    %ecx,%ecx
 4ab:	eb 95                	jmp    442 <printf+0x52>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4b0:	83 ec 0c             	sub    $0xc,%esp
 4b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4b8:	6a 00                	push   $0x0
 4ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4bd:	8b 10                	mov    (%eax),%edx
 4bf:	89 f0                	mov    %esi,%eax
 4c1:	e8 7a fe ff ff       	call   340 <printint>
        ap++;
 4c6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 4ca:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4cd:	31 c9                	xor    %ecx,%ecx
 4cf:	e9 6e ff ff ff       	jmp    442 <printf+0x52>
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 4d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4db:	8b 10                	mov    (%eax),%edx
        ap++;
 4dd:	83 c0 04             	add    $0x4,%eax
 4e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4e3:	85 d2                	test   %edx,%edx
 4e5:	0f 84 8d 00 00 00    	je     578 <printf+0x188>
        while(*s != 0){
 4eb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 4ee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 4f0:	84 c0                	test   %al,%al
 4f2:	0f 84 4a ff ff ff    	je     442 <printf+0x52>
 4f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4fb:	89 d3                	mov    %edx,%ebx
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 500:	83 ec 04             	sub    $0x4,%esp
          s++;
 503:	83 c3 01             	add    $0x1,%ebx
 506:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 509:	6a 01                	push   $0x1
 50b:	57                   	push   %edi
 50c:	56                   	push   %esi
 50d:	e8 91 fd ff ff       	call   2a3 <write>
        while(*s != 0){
 512:	0f b6 03             	movzbl (%ebx),%eax
 515:	83 c4 10             	add    $0x10,%esp
 518:	84 c0                	test   %al,%al
 51a:	75 e4                	jne    500 <printf+0x110>
      state = 0;
 51c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 51f:	31 c9                	xor    %ecx,%ecx
 521:	e9 1c ff ff ff       	jmp    442 <printf+0x52>
 526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	b9 0a 00 00 00       	mov    $0xa,%ecx
 538:	6a 01                	push   $0x1
 53a:	e9 7b ff ff ff       	jmp    4ba <printf+0xca>
 53f:	90                   	nop
        putc(fd, *ap);
 540:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 543:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 546:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 548:	6a 01                	push   $0x1
 54a:	57                   	push   %edi
 54b:	56                   	push   %esi
        putc(fd, *ap);
 54c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 54f:	e8 4f fd ff ff       	call   2a3 <write>
        ap++;
 554:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 558:	83 c4 10             	add    $0x10,%esp
      state = 0;
 55b:	31 c9                	xor    %ecx,%ecx
 55d:	e9 e0 fe ff ff       	jmp    442 <printf+0x52>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 568:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 56b:	83 ec 04             	sub    $0x4,%esp
 56e:	e9 2a ff ff ff       	jmp    49d <printf+0xad>
 573:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 577:	90                   	nop
          s = "(null)";
 578:	ba 18 07 00 00       	mov    $0x718,%edx
        while(*s != 0){
 57d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 580:	b8 28 00 00 00       	mov    $0x28,%eax
 585:	89 d3                	mov    %edx,%ebx
 587:	e9 74 ff ff ff       	jmp    500 <printf+0x110>
 58c:	66 90                	xchg   %ax,%ax
 58e:	66 90                	xchg   %ax,%ax

00000590 <free>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
static Header base;
static Header *freep;

void
free(void *ap)
{
<<<<<<< HEAD
 550:	55                   	push   %ebp
=======
 590:	55                   	push   %ebp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
<<<<<<< HEAD
 551:	a1 c4 09 00 00       	mov    0x9c4,%eax
{
 556:	89 e5                	mov    %esp,%ebp
 558:	57                   	push   %edi
 559:	56                   	push   %esi
 55a:	53                   	push   %ebx
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 55e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 568:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 56a:	39 c8                	cmp    %ecx,%eax
 56c:	73 32                	jae    5a0 <free+0x50>
 56e:	39 d1                	cmp    %edx,%ecx
 570:	72 04                	jb     576 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 572:	39 d0                	cmp    %edx,%eax
 574:	72 32                	jb     5a8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 576:	8b 73 fc             	mov    -0x4(%ebx),%esi
 579:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 57c:	39 fa                	cmp    %edi,%edx
 57e:	74 30                	je     5b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 580:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 583:	8b 50 04             	mov    0x4(%eax),%edx
 586:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 589:	39 f1                	cmp    %esi,%ecx
 58b:	74 3a                	je     5c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 58d:	89 08                	mov    %ecx,(%eax)
=======
 591:	a1 20 0a 00 00       	mov    0xa20,%eax
{
 596:	89 e5                	mov    %esp,%ebp
 598:	57                   	push   %edi
 599:	56                   	push   %esi
 59a:	53                   	push   %ebx
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 59e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a8:	89 c2                	mov    %eax,%edx
 5aa:	8b 00                	mov    (%eax),%eax
 5ac:	39 ca                	cmp    %ecx,%edx
 5ae:	73 30                	jae    5e0 <free+0x50>
 5b0:	39 c1                	cmp    %eax,%ecx
 5b2:	72 04                	jb     5b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	39 c2                	cmp    %eax,%edx
 5b6:	72 f0                	jb     5a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5be:	39 f8                	cmp    %edi,%eax
 5c0:	74 30                	je     5f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5c5:	8b 42 04             	mov    0x4(%edx),%eax
 5c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5cb:	39 f1                	cmp    %esi,%ecx
 5cd:	74 3a                	je     609 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5cf:	89 0a                	mov    %ecx,(%edx)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else
    p->s.ptr = bp;
  freep = p;
}
<<<<<<< HEAD
 58f:	5b                   	pop    %ebx
  freep = p;
 590:	a3 c4 09 00 00       	mov    %eax,0x9c4
}
 595:	5e                   	pop    %esi
 596:	5f                   	pop    %edi
 597:	5d                   	pop    %ebp
 598:	c3                   	ret
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a0:	39 d0                	cmp    %edx,%eax
 5a2:	72 04                	jb     5a8 <free+0x58>
 5a4:	39 d1                	cmp    %edx,%ecx
 5a6:	72 ce                	jb     576 <free+0x26>
{
 5a8:	89 d0                	mov    %edx,%eax
 5aa:	eb bc                	jmp    568 <free+0x18>
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 5b0:	03 72 04             	add    0x4(%edx),%esi
 5b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5b6:	8b 10                	mov    (%eax),%edx
 5b8:	8b 12                	mov    (%edx),%edx
 5ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5bd:	8b 50 04             	mov    0x4(%eax),%edx
 5c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c3:	39 f1                	cmp    %esi,%ecx
 5c5:	75 c6                	jne    58d <free+0x3d>
    p->s.size += bp->s.size;
 5c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 5ca:	a3 c4 09 00 00       	mov    %eax,0x9c4
    p->s.size += bp->s.size;
 5cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5d2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5d5:	89 08                	mov    %ecx,(%eax)
}
 5d7:	5b                   	pop    %ebx
 5d8:	5e                   	pop    %esi
 5d9:	5f                   	pop    %edi
 5da:	5d                   	pop    %ebp
 5db:	c3                   	ret
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005e0 <malloc>:
=======
 5d1:	5b                   	pop    %ebx
  freep = p;
 5d2:	89 15 20 0a 00 00    	mov    %edx,0xa20
}
 5d8:	5e                   	pop    %esi
 5d9:	5f                   	pop    %edi
 5da:	5d                   	pop    %ebp
 5db:	c3                   	ret    
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e0:	39 c2                	cmp    %eax,%edx
 5e2:	72 c4                	jb     5a8 <free+0x18>
 5e4:	39 c1                	cmp    %eax,%ecx
 5e6:	73 c0                	jae    5a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 5e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ee:	39 f8                	cmp    %edi,%eax
 5f0:	75 d0                	jne    5c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 5f2:	03 70 04             	add    0x4(%eax),%esi
 5f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f8:	8b 02                	mov    (%edx),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5ff:	8b 42 04             	mov    0x4(%edx),%eax
 602:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 605:	39 f1                	cmp    %esi,%ecx
 607:	75 c6                	jne    5cf <free+0x3f>
    p->s.size += bp->s.size;
 609:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 60c:	89 15 20 0a 00 00    	mov    %edx,0xa20
    p->s.size += bp->s.size;
 612:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 615:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 618:	89 0a                	mov    %ecx,(%edx)
}
 61a:	5b                   	pop    %ebx
 61b:	5e                   	pop    %esi
 61c:	5f                   	pop    %edi
 61d:	5d                   	pop    %ebp
 61e:	c3                   	ret    
 61f:	90                   	nop

00000620 <malloc>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  return freep;
}

void*
malloc(uint nbytes)
{
<<<<<<< HEAD
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 0c             	sub    $0xc,%esp
=======
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 1c             	sub    $0x1c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
<<<<<<< HEAD
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5ec:	8b 15 c4 09 00 00    	mov    0x9c4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f2:	8d 78 07             	lea    0x7(%eax),%edi
 5f5:	c1 ef 03             	shr    $0x3,%edi
 5f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 5fb:	85 d2                	test   %edx,%edx
 5fd:	0f 84 8d 00 00 00    	je     690 <malloc+0xb0>
=======
 629:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 62c:	8b 3d 20 0a 00 00    	mov    0xa20,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 632:	8d 70 07             	lea    0x7(%eax),%esi
 635:	c1 ee 03             	shr    $0x3,%esi
 638:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 63b:	85 ff                	test   %edi,%edi
 63d:	0f 84 9d 00 00 00    	je     6e0 <malloc+0xc0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
<<<<<<< HEAD
 603:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 605:	8b 48 04             	mov    0x4(%eax),%ecx
 608:	39 f9                	cmp    %edi,%ecx
 60a:	73 64                	jae    670 <malloc+0x90>
  if(nu < 4096)
 60c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 611:	39 df                	cmp    %ebx,%edi
 613:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 616:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 61d:	eb 0a                	jmp    629 <malloc+0x49>
 61f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 620:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 622:	8b 48 04             	mov    0x4(%eax),%ecx
 625:	39 f9                	cmp    %edi,%ecx
 627:	73 47                	jae    670 <malloc+0x90>
=======
 643:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 645:	8b 4a 04             	mov    0x4(%edx),%ecx
 648:	39 f1                	cmp    %esi,%ecx
 64a:	73 6a                	jae    6b6 <malloc+0x96>
 64c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 651:	39 de                	cmp    %ebx,%esi
 653:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 656:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 65d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 660:	eb 17                	jmp    679 <malloc+0x59>
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 668:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 66a:	8b 48 04             	mov    0x4(%eax),%ecx
 66d:	39 f1                	cmp    %esi,%ecx
 66f:	73 4f                	jae    6c0 <malloc+0xa0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
<<<<<<< HEAD
 629:	89 c2                	mov    %eax,%edx
 62b:	3b 05 c4 09 00 00    	cmp    0x9c4,%eax
 631:	75 ed                	jne    620 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 633:	83 ec 0c             	sub    $0xc,%esp
 636:	56                   	push   %esi
 637:	e8 bf fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 63c:	83 c4 10             	add    $0x10,%esp
 63f:	83 f8 ff             	cmp    $0xffffffff,%eax
 642:	74 1c                	je     660 <malloc+0x80>
  hp->s.size = nu;
 644:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 647:	83 ec 0c             	sub    $0xc,%esp
 64a:	83 c0 08             	add    $0x8,%eax
 64d:	50                   	push   %eax
 64e:	e8 fd fe ff ff       	call   550 <free>
  return freep;
 653:	8b 15 c4 09 00 00    	mov    0x9c4,%edx
      if((p = morecore(nunits)) == 0)
 659:	83 c4 10             	add    $0x10,%esp
 65c:	85 d2                	test   %edx,%edx
 65e:	75 c0                	jne    620 <malloc+0x40>
        return 0;
  }
}
 660:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 663:	31 c0                	xor    %eax,%eax
}
 665:	5b                   	pop    %ebx
 666:	5e                   	pop    %esi
 667:	5f                   	pop    %edi
 668:	5d                   	pop    %ebp
 669:	c3                   	ret
 66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 670:	39 cf                	cmp    %ecx,%edi
 672:	74 4c                	je     6c0 <malloc+0xe0>
        p->s.size -= nunits;
 674:	29 f9                	sub    %edi,%ecx
 676:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 679:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 67c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 67f:	89 15 c4 09 00 00    	mov    %edx,0x9c4
}
 685:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 688:	83 c0 08             	add    $0x8,%eax
}
 68b:	5b                   	pop    %ebx
 68c:	5e                   	pop    %esi
 68d:	5f                   	pop    %edi
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 690:	c7 05 c4 09 00 00 c8 	movl   $0x9c8,0x9c4
 697:	09 00 00 
    base.s.size = 0;
 69a:	b8 c8 09 00 00       	mov    $0x9c8,%eax
    base.s.ptr = freep = prevp = &base;
 69f:	c7 05 c8 09 00 00 c8 	movl   $0x9c8,0x9c8
 6a6:	09 00 00 
    base.s.size = 0;
 6a9:	c7 05 cc 09 00 00 00 	movl   $0x0,0x9cc
 6b0:	00 00 00 
    if(p->s.size >= nunits){
 6b3:	e9 54 ff ff ff       	jmp    60c <malloc+0x2c>
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
        prevp->s.ptr = p->s.ptr;
 6c0:	8b 08                	mov    (%eax),%ecx
 6c2:	89 0a                	mov    %ecx,(%edx)
 6c4:	eb b9                	jmp    67f <malloc+0x9f>
=======
 671:	8b 3d 20 0a 00 00    	mov    0xa20,%edi
 677:	89 c2                	mov    %eax,%edx
 679:	39 d7                	cmp    %edx,%edi
 67b:	75 eb                	jne    668 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 67d:	83 ec 0c             	sub    $0xc,%esp
 680:	ff 75 e4             	push   -0x1c(%ebp)
 683:	e8 83 fc ff ff       	call   30b <sbrk>
  if(p == (char*)-1)
 688:	83 c4 10             	add    $0x10,%esp
 68b:	83 f8 ff             	cmp    $0xffffffff,%eax
 68e:	74 1c                	je     6ac <malloc+0x8c>
  hp->s.size = nu;
 690:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	83 c0 08             	add    $0x8,%eax
 699:	50                   	push   %eax
 69a:	e8 f1 fe ff ff       	call   590 <free>
  return freep;
 69f:	8b 15 20 0a 00 00    	mov    0xa20,%edx
      if((p = morecore(nunits)) == 0)
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	85 d2                	test   %edx,%edx
 6aa:	75 bc                	jne    668 <malloc+0x48>
        return 0;
  }
}
 6ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6af:	31 c0                	xor    %eax,%eax
}
 6b1:	5b                   	pop    %ebx
 6b2:	5e                   	pop    %esi
 6b3:	5f                   	pop    %edi
 6b4:	5d                   	pop    %ebp
 6b5:	c3                   	ret    
    if(p->s.size >= nunits){
 6b6:	89 d0                	mov    %edx,%eax
 6b8:	89 fa                	mov    %edi,%edx
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 6c0:	39 ce                	cmp    %ecx,%esi
 6c2:	74 4c                	je     710 <malloc+0xf0>
        p->s.size -= nunits;
 6c4:	29 f1                	sub    %esi,%ecx
 6c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6cc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6cf:	89 15 20 0a 00 00    	mov    %edx,0xa20
}
 6d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 6d8:	83 c0 08             	add    $0x8,%eax
}
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 6e0:	c7 05 20 0a 00 00 24 	movl   $0xa24,0xa20
 6e7:	0a 00 00 
    base.s.size = 0;
 6ea:	bf 24 0a 00 00       	mov    $0xa24,%edi
    base.s.ptr = freep = prevp = &base;
 6ef:	c7 05 24 0a 00 00 24 	movl   $0xa24,0xa24
 6f6:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 6fb:	c7 05 28 0a 00 00 00 	movl   $0x0,0xa28
 702:	00 00 00 
    if(p->s.size >= nunits){
 705:	e9 42 ff ff ff       	jmp    64c <malloc+0x2c>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 710:	8b 08                	mov    (%eax),%ecx
 712:	89 0a                	mov    %ecx,(%edx)
 714:	eb b9                	jmp    6cf <malloc+0xaf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
