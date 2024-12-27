
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 18 08 00 00       	push   $0x818
  19:	e8 75 03 00 00       	call   393 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 a7 00 00 00    	js     d0 <main+0xd0>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 98 03 00 00       	call   3cb <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 8c 03 00 00       	call   3cb <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 20 08 00 00       	push   $0x820
  50:	6a 01                	push   $0x1
  52:	e8 99 04 00 00       	call   4f0 <printf>
    printf(1, "Ali Zamani \t Nima Khanjari \t Borna Foroohari\n");
  57:	58                   	pop    %eax
  58:	5a                   	pop    %edx
  59:	68 68 08 00 00       	push   $0x868
  5e:	6a 01                	push   $0x1
  60:	e8 8b 04 00 00       	call   4f0 <printf>
    pid = fork();
  65:	e8 e1 02 00 00       	call   34b <fork>
    if(pid < 0){
  6a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  6d:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  6f:	85 c0                	test   %eax,%eax
  71:	78 26                	js     99 <main+0x99>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  73:	74 37                	je     ac <main+0xac>
  75:	8d 76 00             	lea    0x0(%esi),%esi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  78:	e8 de 02 00 00       	call   35b <wait>
  7d:	85 c0                	test   %eax,%eax
  7f:	78 c7                	js     48 <main+0x48>
  81:	39 c3                	cmp    %eax,%ebx
  83:	74 c3                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  85:	83 ec 08             	sub    $0x8,%esp
  88:	68 5f 08 00 00       	push   $0x85f
  8d:	6a 01                	push   $0x1
  8f:	e8 5c 04 00 00       	call   4f0 <printf>
  94:	83 c4 10             	add    $0x10,%esp
  97:	eb df                	jmp    78 <main+0x78>
      printf(1, "init: fork failed\n");
  99:	53                   	push   %ebx
  9a:	53                   	push   %ebx
  9b:	68 33 08 00 00       	push   $0x833
  a0:	6a 01                	push   $0x1
  a2:	e8 49 04 00 00       	call   4f0 <printf>
      exit();
  a7:	e8 a7 02 00 00       	call   353 <exit>
      exec("sh", argv);
  ac:	50                   	push   %eax
  ad:	50                   	push   %eax
  ae:	68 a4 0b 00 00       	push   $0xba4
  b3:	68 46 08 00 00       	push   $0x846
  b8:	e8 ce 02 00 00       	call   38b <exec>
      printf(1, "init: exec sh failed\n");
  bd:	5a                   	pop    %edx
  be:	59                   	pop    %ecx
  bf:	68 49 08 00 00       	push   $0x849
  c4:	6a 01                	push   $0x1
  c6:	e8 25 04 00 00       	call   4f0 <printf>
      exit();
  cb:	e8 83 02 00 00       	call   353 <exit>
    mknod("console", 1, 1);
  d0:	51                   	push   %ecx
  d1:	6a 01                	push   $0x1
  d3:	6a 01                	push   $0x1
  d5:	68 18 08 00 00       	push   $0x818
  da:	e8 bc 02 00 00       	call   39b <mknod>
    open("console", O_RDWR);
  df:	5b                   	pop    %ebx
  e0:	58                   	pop    %eax
  e1:	6a 02                	push   $0x2
  e3:	68 18 08 00 00       	push   $0x818
  e8:	e8 a6 02 00 00       	call   393 <open>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	e9 34 ff ff ff       	jmp    29 <main+0x29>
  f5:	66 90                	xchg   %ax,%ax
  f7:	66 90                	xchg   %ax,%ax
  f9:	66 90                	xchg   %ax,%ax
  fb:	66 90                	xchg   %ax,%ax
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	53                   	push   %ebx
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 110:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 114:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 117:	83 c0 01             	add    $0x1,%eax
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 121:	89 c8                	mov    %ecx,%eax
 123:	c9                   	leave  
 124:	c3                   	ret    
 125:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 17                	jne    158 <strcmp+0x28>
 141:	eb 3a                	jmp    17d <strcmp+0x4d>
 143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 147:	90                   	nop
 148:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 14c:	83 c2 01             	add    $0x1,%edx
 14f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 152:	84 c0                	test   %al,%al
 154:	74 1a                	je     170 <strcmp+0x40>
    p++, q++;
 156:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 158:	0f b6 19             	movzbl (%ecx),%ebx
 15b:	38 c3                	cmp    %al,%bl
 15d:	74 e9                	je     148 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 15f:	29 d8                	sub    %ebx,%eax
}
 161:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 164:	c9                   	leave  
 165:	c3                   	ret    
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 170:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 174:	31 c0                	xor    %eax,%eax
 176:	29 d8                	sub    %ebx,%eax
}
 178:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 17b:	c9                   	leave  
 17c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	31 c0                	xor    %eax,%eax
 182:	eb db                	jmp    15f <strcmp+0x2f>
 184:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 3a 00             	cmpb   $0x0,(%edx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 c0                	xor    %eax,%eax
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1a7:	89 c1                	mov    %eax,%ecx
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	89 c8                	mov    %ecx,%eax
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
  for(n = 0; s[n]; n++)
 1b0:	31 c9                	xor    %ecx,%ecx
}
 1b2:	5d                   	pop    %ebp
 1b3:	89 c8                	mov    %ecx,%eax
 1b5:	c3                   	ret    
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1d5:	89 d0                	mov    %edx,%eax
 1d7:	c9                   	leave  
 1d8:	c3                   	ret    
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 12                	jne    203 <strchr+0x23>
 1f1:	eb 1d                	jmp    210 <strchr+0x30>
 1f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f7:	90                   	nop
 1f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1fc:	83 c0 01             	add    $0x1,%eax
 1ff:	84 d2                	test   %dl,%dl
 201:	74 0d                	je     210 <strchr+0x30>
    if(*s == c)
 203:	38 d1                	cmp    %dl,%cl
 205:	75 f1                	jne    1f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 210:	31 c0                	xor    %eax,%eax
}
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    
 214:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 225:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 228:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 229:	31 db                	xor    %ebx,%ebx
{
 22b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 22e:	eb 27                	jmp    257 <gets+0x37>
    cc = read(0, &c, 1);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	6a 01                	push   $0x1
 235:	57                   	push   %edi
 236:	6a 00                	push   $0x0
 238:	e8 2e 01 00 00       	call   36b <read>
    if(cc < 1)
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	7e 1d                	jle    261 <gets+0x41>
      break;
    buf[i++] = c;
 244:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 1d                	je     270 <gets+0x50>
 253:	3c 0d                	cmp    $0xd,%al
 255:	74 19                	je     270 <gets+0x50>
  for(i=0; i+1 < max; ){
 257:	89 de                	mov    %ebx,%esi
 259:	83 c3 01             	add    $0x1,%ebx
 25c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 25f:	7c cf                	jl     230 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 268:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26b:	5b                   	pop    %ebx
 26c:	5e                   	pop    %esi
 26d:	5f                   	pop    %edi
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    
  buf[i] = '\0';
 270:	8b 45 08             	mov    0x8(%ebp),%eax
 273:	89 de                	mov    %ebx,%esi
 275:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 279:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5f                   	pop    %edi
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28f:	90                   	nop

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	push   0x8(%ebp)
 29d:	e8 f1 00 00 00       	call   393 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	push   0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f4 00 00 00       	call   3ab <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 ba 00 00 00       	call   37b <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2de:	66 90                	xchg   %ax,%ax

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave  
 31b:	c3                   	ret    
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	8b 55 08             	mov    0x8(%ebp),%edx
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <sort_syscalls>:
SYSCALL(sort_syscalls)
 3f3:	b8 18 00 00 00       	mov    $0x18,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 3fb:	b8 19 00 00 00       	mov    $0x19,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <list_active_processes>:
SYSCALL(list_active_processes)
 403:	b8 1a 00 00 00       	mov    $0x1a,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <move_file>:
SYSCALL(move_file)
 40b:	b8 17 00 00 00       	mov    $0x17,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <create_palindrome>:
SYSCALL(create_palindrome)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <set_level>:
SYSCALL(set_level)
 41b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <show_process_info>:
SYSCALL(show_process_info)
 423:	b8 1c 00 00 00       	mov    $0x1c,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <set_burst_confidence>:
SYSCALL(set_burst_confidence)
 42b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <count_syscalls_all_cpus>:
SYSCALL(count_syscalls_all_cpus)
 433:	b8 1e 00 00 00       	mov    $0x1e,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 3c             	sub    $0x3c,%esp
 449:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 44c:	89 d1                	mov    %edx,%ecx
{
 44e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 451:	85 d2                	test   %edx,%edx
 453:	0f 89 7f 00 00 00    	jns    4d8 <printint+0x98>
 459:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 45d:	74 79                	je     4d8 <printint+0x98>
    neg = 1;
 45f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 466:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 468:	31 db                	xor    %ebx,%ebx
 46a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 470:	89 c8                	mov    %ecx,%eax
 472:	31 d2                	xor    %edx,%edx
 474:	89 cf                	mov    %ecx,%edi
 476:	f7 75 c4             	divl   -0x3c(%ebp)
 479:	0f b6 92 f8 08 00 00 	movzbl 0x8f8(%edx),%edx
 480:	89 45 c0             	mov    %eax,-0x40(%ebp)
 483:	89 d8                	mov    %ebx,%eax
 485:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 488:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 48b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 48e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 491:	76 dd                	jbe    470 <printint+0x30>
  if(neg)
 493:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 496:	85 c9                	test   %ecx,%ecx
 498:	74 0c                	je     4a6 <printint+0x66>
    buf[i++] = '-';
 49a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 49f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4ad:	eb 07                	jmp    4b6 <printint+0x76>
 4af:	90                   	nop
    putc(fd, buf[i]);
 4b0:	0f b6 13             	movzbl (%ebx),%edx
 4b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4b6:	83 ec 04             	sub    $0x4,%esp
 4b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	56                   	push   %esi
 4bf:	57                   	push   %edi
 4c0:	e8 ae fe ff ff       	call   373 <write>
  while(--i >= 0)
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	39 de                	cmp    %ebx,%esi
 4ca:	75 e4                	jne    4b0 <printint+0x70>
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4df:	eb 87                	jmp    468 <printint+0x28>
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 13             	movzbl (%ebx),%edx
 502:	84 d2                	test   %dl,%dl
 504:	74 6a                	je     570 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 506:	8d 45 10             	lea    0x10(%ebp),%eax
 509:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 50c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 50f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 511:	89 45 d0             	mov    %eax,-0x30(%ebp)
 514:	eb 36                	jmp    54c <printf+0x5c>
 516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
 520:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 523:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	74 15                	je     542 <printf+0x52>
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	88 55 e7             	mov    %dl,-0x19(%ebp)
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	56                   	push   %esi
 537:	e8 37 fe ff ff       	call   373 <write>
 53c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 53f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 542:	0f b6 13             	movzbl (%ebx),%edx
 545:	83 c3 01             	add    $0x1,%ebx
 548:	84 d2                	test   %dl,%dl
 54a:	74 24                	je     570 <printf+0x80>
    c = fmt[i] & 0xff;
 54c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 54f:	85 c9                	test   %ecx,%ecx
 551:	74 cd                	je     520 <printf+0x30>
      }
    } else if(state == '%'){
 553:	83 f9 25             	cmp    $0x25,%ecx
 556:	75 ea                	jne    542 <printf+0x52>
      if(c == 'd'){
 558:	83 f8 25             	cmp    $0x25,%eax
 55b:	0f 84 07 01 00 00    	je     668 <printf+0x178>
 561:	83 e8 63             	sub    $0x63,%eax
 564:	83 f8 15             	cmp    $0x15,%eax
 567:	77 17                	ja     580 <printf+0x90>
 569:	ff 24 85 a0 08 00 00 	jmp    *0x8a0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 570:	8d 65 f4             	lea    -0xc(%ebp),%esp
 573:	5b                   	pop    %ebx
 574:	5e                   	pop    %esi
 575:	5f                   	pop    %edi
 576:	5d                   	pop    %ebp
 577:	c3                   	ret    
 578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 586:	6a 01                	push   $0x1
 588:	57                   	push   %edi
 589:	56                   	push   %esi
 58a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58e:	e8 e0 fd ff ff       	call   373 <write>
        putc(fd, c);
 593:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 597:	83 c4 0c             	add    $0xc,%esp
 59a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 59d:	6a 01                	push   $0x1
 59f:	57                   	push   %edi
 5a0:	56                   	push   %esi
 5a1:	e8 cd fd ff ff       	call   373 <write>
        putc(fd, c);
 5a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5a9:	31 c9                	xor    %ecx,%ecx
 5ab:	eb 95                	jmp    542 <printf+0x52>
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5b8:	6a 00                	push   $0x0
 5ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5bd:	8b 10                	mov    (%eax),%edx
 5bf:	89 f0                	mov    %esi,%eax
 5c1:	e8 7a fe ff ff       	call   440 <printint>
        ap++;
 5c6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5ca:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cd:	31 c9                	xor    %ecx,%ecx
 5cf:	e9 6e ff ff ff       	jmp    542 <printf+0x52>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5db:	8b 10                	mov    (%eax),%edx
        ap++;
 5dd:	83 c0 04             	add    $0x4,%eax
 5e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5e3:	85 d2                	test   %edx,%edx
 5e5:	0f 84 8d 00 00 00    	je     678 <printf+0x188>
        while(*s != 0){
 5eb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 5ee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 5f0:	84 c0                	test   %al,%al
 5f2:	0f 84 4a ff ff ff    	je     542 <printf+0x52>
 5f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 5fb:	89 d3                	mov    %edx,%ebx
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
          s++;
 603:	83 c3 01             	add    $0x1,%ebx
 606:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 609:	6a 01                	push   $0x1
 60b:	57                   	push   %edi
 60c:	56                   	push   %esi
 60d:	e8 61 fd ff ff       	call   373 <write>
        while(*s != 0){
 612:	0f b6 03             	movzbl (%ebx),%eax
 615:	83 c4 10             	add    $0x10,%esp
 618:	84 c0                	test   %al,%al
 61a:	75 e4                	jne    600 <printf+0x110>
      state = 0;
 61c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 61f:	31 c9                	xor    %ecx,%ecx
 621:	e9 1c ff ff ff       	jmp    542 <printf+0x52>
 626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 630:	83 ec 0c             	sub    $0xc,%esp
 633:	b9 0a 00 00 00       	mov    $0xa,%ecx
 638:	6a 01                	push   $0x1
 63a:	e9 7b ff ff ff       	jmp    5ba <printf+0xca>
 63f:	90                   	nop
        putc(fd, *ap);
 640:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 646:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 648:	6a 01                	push   $0x1
 64a:	57                   	push   %edi
 64b:	56                   	push   %esi
        putc(fd, *ap);
 64c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 64f:	e8 1f fd ff ff       	call   373 <write>
        ap++;
 654:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 658:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65b:	31 c9                	xor    %ecx,%ecx
 65d:	e9 e0 fe ff ff       	jmp    542 <printf+0x52>
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 668:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 66b:	83 ec 04             	sub    $0x4,%esp
 66e:	e9 2a ff ff ff       	jmp    59d <printf+0xad>
 673:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 677:	90                   	nop
          s = "(null)";
 678:	ba 96 08 00 00       	mov    $0x896,%edx
        while(*s != 0){
 67d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 680:	b8 28 00 00 00       	mov    $0x28,%eax
 685:	89 d3                	mov    %edx,%ebx
 687:	e9 74 ff ff ff       	jmp    600 <printf+0x110>
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 ac 0b 00 00       	mov    0xbac,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a8:	89 c2                	mov    %eax,%edx
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	39 ca                	cmp    %ecx,%edx
 6ae:	73 30                	jae    6e0 <free+0x50>
 6b0:	39 c1                	cmp    %eax,%ecx
 6b2:	72 04                	jb     6b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 c2                	cmp    %eax,%edx
 6b6:	72 f0                	jb     6a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6be:	39 f8                	cmp    %edi,%eax
 6c0:	74 30                	je     6f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c5:	8b 42 04             	mov    0x4(%edx),%eax
 6c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6cb:	39 f1                	cmp    %esi,%ecx
 6cd:	74 3a                	je     709 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6cf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6d1:	5b                   	pop    %ebx
  freep = p;
 6d2:	89 15 ac 0b 00 00    	mov    %edx,0xbac
}
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	39 c2                	cmp    %eax,%edx
 6e2:	72 c4                	jb     6a8 <free+0x18>
 6e4:	39 c1                	cmp    %eax,%ecx
 6e6:	73 c0                	jae    6a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 6e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ee:	39 f8                	cmp    %edi,%eax
 6f0:	75 d0                	jne    6c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 6f2:	03 70 04             	add    0x4(%eax),%esi
 6f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f8:	8b 02                	mov    (%edx),%eax
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ff:	8b 42 04             	mov    0x4(%edx),%eax
 702:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 705:	39 f1                	cmp    %esi,%ecx
 707:	75 c6                	jne    6cf <free+0x3f>
    p->s.size += bp->s.size;
 709:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 70c:	89 15 ac 0b 00 00    	mov    %edx,0xbac
    p->s.size += bp->s.size;
 712:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 715:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 718:	89 0a                	mov    %ecx,(%edx)
}
 71a:	5b                   	pop    %ebx
 71b:	5e                   	pop    %esi
 71c:	5f                   	pop    %edi
 71d:	5d                   	pop    %ebp
 71e:	c3                   	ret    
 71f:	90                   	nop

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 70 07             	lea    0x7(%eax),%esi
 735:	c1 ee 03             	shr    $0x3,%esi
 738:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 73b:	85 ff                	test   %edi,%edi
 73d:	0f 84 9d 00 00 00    	je     7e0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 745:	8b 4a 04             	mov    0x4(%edx),%ecx
 748:	39 f1                	cmp    %esi,%ecx
 74a:	73 6a                	jae    7b6 <malloc+0x96>
 74c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 751:	39 de                	cmp    %ebx,%esi
 753:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 756:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 75d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 760:	eb 17                	jmp    779 <malloc+0x59>
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 76a:	8b 48 04             	mov    0x4(%eax),%ecx
 76d:	39 f1                	cmp    %esi,%ecx
 76f:	73 4f                	jae    7c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
 777:	89 c2                	mov    %eax,%edx
 779:	39 d7                	cmp    %edx,%edi
 77b:	75 eb                	jne    768 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 77d:	83 ec 0c             	sub    $0xc,%esp
 780:	ff 75 e4             	push   -0x1c(%ebp)
 783:	e8 53 fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 788:	83 c4 10             	add    $0x10,%esp
 78b:	83 f8 ff             	cmp    $0xffffffff,%eax
 78e:	74 1c                	je     7ac <malloc+0x8c>
  hp->s.size = nu;
 790:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 793:	83 ec 0c             	sub    $0xc,%esp
 796:	83 c0 08             	add    $0x8,%eax
 799:	50                   	push   %eax
 79a:	e8 f1 fe ff ff       	call   690 <free>
  return freep;
 79f:	8b 15 ac 0b 00 00    	mov    0xbac,%edx
      if((p = morecore(nunits)) == 0)
 7a5:	83 c4 10             	add    $0x10,%esp
 7a8:	85 d2                	test   %edx,%edx
 7aa:	75 bc                	jne    768 <malloc+0x48>
        return 0;
  }
}
 7ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7af:	31 c0                	xor    %eax,%eax
}
 7b1:	5b                   	pop    %ebx
 7b2:	5e                   	pop    %esi
 7b3:	5f                   	pop    %edi
 7b4:	5d                   	pop    %ebp
 7b5:	c3                   	ret    
    if(p->s.size >= nunits){
 7b6:	89 d0                	mov    %edx,%eax
 7b8:	89 fa                	mov    %edi,%edx
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7c0:	39 ce                	cmp    %ecx,%esi
 7c2:	74 4c                	je     810 <malloc+0xf0>
        p->s.size -= nunits;
 7c4:	29 f1                	sub    %esi,%ecx
 7c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7cc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7cf:	89 15 ac 0b 00 00    	mov    %edx,0xbac
}
 7d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7d8:	83 c0 08             	add    $0x8,%eax
}
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7e0:	c7 05 ac 0b 00 00 b0 	movl   $0xbb0,0xbac
 7e7:	0b 00 00 
    base.s.size = 0;
 7ea:	bf b0 0b 00 00       	mov    $0xbb0,%edi
    base.s.ptr = freep = prevp = &base;
 7ef:	c7 05 b0 0b 00 00 b0 	movl   $0xbb0,0xbb0
 7f6:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 7fb:	c7 05 b4 0b 00 00 00 	movl   $0x0,0xbb4
 802:	00 00 00 
    if(p->s.size >= nunits){
 805:	e9 42 ff ff ff       	jmp    74c <malloc+0x2c>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb b9                	jmp    7cf <malloc+0xaf>
