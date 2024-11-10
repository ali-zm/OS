
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 28                	jg     51 <main+0x51>
  29:	eb 54                	jmp    7f <main+0x7f>
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  30:	83 ec 08             	sub    $0x8,%esp
  33:	ff 33                	push   (%ebx)
  for(i = 1; i < argc; i++){
  35:	83 c6 01             	add    $0x1,%esi
  38:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  3b:	50                   	push   %eax
  3c:	e8 5f 00 00 00       	call   a0 <wc>
    close(fd);
  41:	89 3c 24             	mov    %edi,(%esp)
  44:	e8 a2 03 00 00       	call   3eb <close>
  for(i = 1; i < argc; i++){
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4f:	74 29                	je     7a <main+0x7a>
    if((fd = open(argv[i], 0)) < 0){
  51:	83 ec 08             	sub    $0x8,%esp
  54:	6a 00                	push   $0x0
  56:	ff 33                	push   (%ebx)
  58:	e8 a6 03 00 00       	call   403 <open>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 c7                	mov    %eax,%edi
  62:	85 c0                	test   %eax,%eax
  64:	79 ca                	jns    30 <main+0x30>
      printf(1, "wc: cannot open %s\n", argv[i]);
  66:	50                   	push   %eax
  67:	ff 33                	push   (%ebx)
  69:	68 3b 08 00 00       	push   $0x83b
  6e:	6a 01                	push   $0x1
  70:	e8 9b 04 00 00       	call   510 <printf>
      exit();
  75:	e8 49 03 00 00       	call   3c3 <exit>
  }
  exit();
<<<<<<< HEAD
  7a:	e8 44 03 00 00       	call   3c3 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 2d 08 00 00       	push   $0x82d
=======
  66:	e8 68 03 00 00       	call   3d3 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	push   (%ebx)
  6e:	68 8b 08 00 00       	push   $0x88b
  73:	6a 01                	push   $0x1
  75:	e8 c6 04 00 00       	call   540 <printf>
      exit();
  7a:	e8 54 03 00 00       	call   3d3 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 7d 08 00 00       	push   $0x87d
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 31 03 00 00       	call   3c3 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  l = w = c = 0;
  a1:	31 d2                	xor    %edx,%edx
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	57                   	push   %edi
  a6:	56                   	push   %esi
  inword = 0;
  a7:	31 f6                	xor    %esi,%esi
{
  a9:	53                   	push   %ebx
  l = w = c = 0;
  aa:	31 db                	xor    %ebx,%ebx
{
  ac:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
<<<<<<< HEAD
  c8:	68 a0 0b 00 00       	push   $0xba0
=======
  c8:	68 00 0c 00 00       	push   $0xc00
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  cd:	ff 75 08             	push   0x8(%ebp)
  d0:	e8 06 03 00 00       	call   3db <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	89 c1                	mov    %eax,%ecx
  da:	85 c0                	test   %eax,%eax
  dc:	7e 62                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  de:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  e1:	31 ff                	xor    %edi,%edi
  e3:	eb 0d                	jmp    f2 <wc+0x52>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3e                	je     130 <wc+0x90>
      if(buf[i] == '\n')
<<<<<<< HEAD
  f2:	0f be 87 a0 0b 00 00 	movsbl 0xba0(%edi),%eax
=======
  f6:	0f be 87 00 0c 00 00 	movsbl 0xc00(%edi),%eax
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
        l++;
 104:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
<<<<<<< HEAD
 106:	68 18 08 00 00       	push   $0x818
 10b:	e8 50 01 00 00       	call   260 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
=======
 10a:	68 68 08 00 00       	push   $0x868
 10f:	e8 4c 01 00 00       	call   260 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      else if(!inword){
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
        w++;
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
 11f:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 124:	83 c7 01             	add    $0x1,%edi
 127:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 133:	01 4d dc             	add    %ecx,-0x24(%ebp)
 136:	eb 88                	jmp    c0 <wc+0x20>
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 22                	jne    167 <wc+0xc7>
  printf(1, "%d %d %d %s\n", l, w, c, name);
<<<<<<< HEAD
 145:	83 ec 08             	sub    $0x8,%esp
 148:	ff 75 0c             	push   0xc(%ebp)
 14b:	52                   	push   %edx
 14c:	ff 75 e0             	push   -0x20(%ebp)
 14f:	53                   	push   %ebx
 150:	68 2e 08 00 00       	push   $0x82e
 155:	6a 01                	push   $0x1
 157:	e8 b4 03 00 00       	call   510 <printf>
=======
 142:	83 ec 08             	sub    $0x8,%esp
 145:	ff 75 0c             	push   0xc(%ebp)
 148:	ff 75 dc             	push   -0x24(%ebp)
 14b:	ff 75 e0             	push   -0x20(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 7e 08 00 00       	push   $0x87e
 154:	6a 01                	push   $0x1
 156:	e8 e5 03 00 00       	call   540 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 162:	5b                   	pop    %ebx
 163:	5e                   	pop    %esi
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
    printf(1, "wc: read error\n");
 167:	50                   	push   %eax
<<<<<<< HEAD
 168:	50                   	push   %eax
 169:	68 1e 08 00 00       	push   $0x81e
 16e:	6a 01                	push   $0x1
 170:	e8 9b 03 00 00       	call   510 <printf>
=======
 168:	68 6e 08 00 00       	push   $0x86e
 16d:	6a 01                	push   $0x1
 16f:	e8 cc 03 00 00       	call   540 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
 175:	e8 49 02 00 00       	call   3c3 <exit>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ac:	00 
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 17                	jne    1d8 <strcmp+0x28>
 1c1:	eb 3a                	jmp    1fd <strcmp+0x4d>
 1c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1cc:	83 c2 01             	add    $0x1,%edx
 1cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1d2:	84 c0                	test   %al,%al
 1d4:	74 1a                	je     1f0 <strcmp+0x40>
 1d6:	89 d9                	mov    %ebx,%ecx
 1d8:	0f b6 19             	movzbl (%ecx),%ebx
 1db:	38 c3                	cmp    %al,%bl
 1dd:	74 e9                	je     1c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1df:	29 d8                	sub    %ebx,%eax
}
 1e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e4:	c9                   	leave
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1f4:	31 c0                	xor    %eax,%eax
 1f6:	29 d8                	sub    %ebx,%eax
}
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave
 1fc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1fd:	0f b6 19             	movzbl (%ecx),%ebx
 200:	31 c0                	xor    %eax,%eax
 202:	eb db                	jmp    1df <strcmp+0x2f>
 204:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20b:	00 
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c0 01             	add    $0x1,%eax
 223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 227:	89 c1                	mov    %eax,%ecx
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	89 c8                	mov    %ecx,%eax
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret
 22f:	90                   	nop
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret
 236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23d:	00 
 23e:	66 90                	xchg   %ax,%ax

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	8b 7d fc             	mov    -0x4(%ebp),%edi
 255:	89 d0                	mov    %edx,%eax
 257:	c9                   	leave
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 12                	jne    283 <strchr+0x23>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	84 d2                	test   %dl,%dl
 281:	74 0d                	je     290 <strchr+0x30>
    if(*s == c)
 283:	38 d1                	cmp    %dl,%cl
 285:	75 f1                	jne    278 <strchr+0x18>
      return (char*)s;
  return 0;
}
 287:	5d                   	pop    %ebp
 288:	c3                   	ret
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 290:	31 c0                	xor    %eax,%eax
}
 292:	5d                   	pop    %ebp
 293:	c3                   	ret
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2a5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2a9:	31 db                	xor    %ebx,%ebx
{
 2ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2ae:	eb 27                	jmp    2d7 <gets+0x37>
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	6a 01                	push   $0x1
 2b5:	56                   	push   %esi
 2b6:	6a 00                	push   $0x0
 2b8:	e8 1e 01 00 00       	call   3db <read>
    if(cc < 1)
 2bd:	83 c4 10             	add    $0x10,%esp
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7e 1d                	jle    2e1 <gets+0x41>
      break;
    buf[i++] = c;
 2c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cf:	3c 0a                	cmp    $0xa,%al
 2d1:	74 10                	je     2e3 <gets+0x43>
 2d3:	3c 0d                	cmp    $0xd,%al
 2d5:	74 0c                	je     2e3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2d7:	89 df                	mov    %ebx,%edi
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2df:	7c cf                	jl     2b0 <gets+0x10>
 2e1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ed:	5b                   	pop    %ebx
 2ee:	5e                   	pop    %esi
 2ef:	5f                   	pop    %edi
 2f0:	5d                   	pop    %ebp
 2f1:	c3                   	ret
 2f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2f9:	00 
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	push   0x8(%ebp)
 30d:	e8 f1 00 00 00       	call   403 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	push   0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 f4 00 00 00       	call   41b <fstat>
  close(fd);
 327:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 32a:	89 c6                	mov    %eax,%esi
  close(fd);
 32c:	e8 ba 00 00 00       	call   3eb <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
}
 334:	8d 65 f8             	lea    -0x8(%ebp),%esp
 337:	89 f0                	mov    %esi,%eax
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb ed                	jmp    334 <stat+0x34>
 347:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34e:	00 
 34f:	90                   	nop

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 02             	movsbl (%edx),%eax
 35a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 35d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 360:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 365:	77 1e                	ja     385 <atoi+0x35>
 367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36e:	00 
 36f:	90                   	nop
    n = n*10 + *s++ - '0';
 370:	83 c2 01             	add    $0x1,%edx
 373:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 376:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 37a:	0f be 02             	movsbl (%edx),%eax
 37d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
  return n;
}
 385:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 388:	89 c8                	mov    %ecx,%eax
 38a:	c9                   	leave
 38b:	c3                   	ret
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000390 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	8b 45 10             	mov    0x10(%ebp),%eax
 397:	8b 55 08             	mov    0x8(%ebp),%edx
 39a:	56                   	push   %esi
 39b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 c0                	test   %eax,%eax
 3a0:	7e 13                	jle    3b5 <memmove+0x25>
 3a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3a4:	89 d7                	mov    %edx,%edi
 3a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ad:	00 
 3ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 3b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3b1:	39 f8                	cmp    %edi,%eax
 3b3:	75 fb                	jne    3b0 <memmove+0x20>
  return vdst;
}
 3b5:	5e                   	pop    %esi
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret

000003bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3bb:	b8 01 00 00 00       	mov    $0x1,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <exit>:
SYSCALL(exit)
 3c3:	b8 02 00 00 00       	mov    $0x2,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <wait>:
SYSCALL(wait)
 3cb:	b8 03 00 00 00       	mov    $0x3,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <pipe>:
SYSCALL(pipe)
 3d3:	b8 04 00 00 00       	mov    $0x4,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <read>:
SYSCALL(read)
 3db:	b8 05 00 00 00       	mov    $0x5,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <write>:
SYSCALL(write)
 3e3:	b8 10 00 00 00       	mov    $0x10,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <close>:
SYSCALL(close)
 3eb:	b8 15 00 00 00       	mov    $0x15,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <kill>:
SYSCALL(kill)
 3f3:	b8 06 00 00 00       	mov    $0x6,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <exec>:
SYSCALL(exec)
 3fb:	b8 07 00 00 00       	mov    $0x7,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <open>:
SYSCALL(open)
 403:	b8 0f 00 00 00       	mov    $0xf,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <mknod>:
SYSCALL(mknod)
 40b:	b8 11 00 00 00       	mov    $0x11,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <unlink>:
SYSCALL(unlink)
 413:	b8 12 00 00 00       	mov    $0x12,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <fstat>:
SYSCALL(fstat)
 41b:	b8 08 00 00 00       	mov    $0x8,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <link>:
SYSCALL(link)
 423:	b8 13 00 00 00       	mov    $0x13,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <mkdir>:
SYSCALL(mkdir)
 42b:	b8 14 00 00 00       	mov    $0x14,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <chdir>:
SYSCALL(chdir)
 433:	b8 09 00 00 00       	mov    $0x9,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <dup>:
SYSCALL(dup)
 43b:	b8 0a 00 00 00       	mov    $0xa,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <getpid>:
SYSCALL(getpid)
 443:	b8 0b 00 00 00       	mov    $0xb,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <sbrk>:
SYSCALL(sbrk)
 44b:	b8 0c 00 00 00       	mov    $0xc,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <sleep>:
SYSCALL(sleep)
 453:	b8 0d 00 00 00       	mov    $0xd,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <uptime>:
SYSCALL(uptime)
<<<<<<< HEAD
 45b:	b8 0e 00 00 00       	mov    $0xe,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <move_file>:
SYSCALL(move_file)
 463:	b8 17 00 00 00       	mov    $0x17,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret
 46b:	66 90                	xchg   %ax,%ax
 46d:	66 90                	xchg   %ax,%ax
 46f:	90                   	nop

00000470 <printint>:
=======
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sort_syscalls>:
SYSCALL(sort_syscalls)
 473:	b8 18 00 00 00       	mov    $0x18,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 47b:	b8 19 00 00 00       	mov    $0x19,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <list_active_processes>:
SYSCALL(list_active_processes)
 483:	b8 1a 00 00 00       	mov    $0x1a,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
<<<<<<< HEAD
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
 476:	89 cb                	mov    %ecx,%ebx
=======
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
 499:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
<<<<<<< HEAD
 478:	89 d1                	mov    %edx,%ecx
{
 47a:	83 ec 3c             	sub    $0x3c,%esp
 47d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 480:	85 d2                	test   %edx,%edx
 482:	0f 89 80 00 00 00    	jns    508 <printint+0x98>
 488:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 48c:	74 7a                	je     508 <printint+0x98>
    x = -xx;
 48e:	f7 d9                	neg    %ecx
    neg = 1;
 490:	b8 01 00 00 00       	mov    $0x1,%eax
=======
 49c:	89 d1                	mov    %edx,%ecx
{
 49e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4a1:	85 d2                	test   %edx,%edx
 4a3:	0f 89 7f 00 00 00    	jns    528 <printint+0x98>
 4a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ad:	74 79                	je     528 <printint+0x98>
    neg = 1;
 4af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4b6:	f7 d9                	neg    %ecx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else {
    x = xx;
  }

  i = 0;
<<<<<<< HEAD
 495:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 498:	31 f6                	xor    %esi,%esi
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	89 f7                	mov    %esi,%edi
 4a6:	f7 f3                	div    %ebx
 4a8:	8d 76 01             	lea    0x1(%esi),%esi
 4ab:	0f b6 92 b0 08 00 00 	movzbl 0x8b0(%edx),%edx
 4b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4b6:	89 ca                	mov    %ecx,%edx
 4b8:	89 c1                	mov    %eax,%ecx
 4ba:	39 da                	cmp    %ebx,%edx
 4bc:	73 e2                	jae    4a0 <printint+0x30>
  if(neg)
 4be:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4c1:	85 c0                	test   %eax,%eax
 4c3:	74 07                	je     4cc <printint+0x5c>
    buf[i++] = '-';
 4c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 4ca:	89 f7                	mov    %esi,%edi
 4cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4d2:	01 df                	add    %ebx,%edi
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4d8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4db:	83 ec 04             	sub    $0x4,%esp
 4de:	88 45 d7             	mov    %al,-0x29(%ebp)
 4e1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4e4:	6a 01                	push   $0x1
 4e6:	50                   	push   %eax
 4e7:	56                   	push   %esi
 4e8:	e8 f6 fe ff ff       	call   3e3 <write>
  while(--i >= 0)
 4ed:	89 f8                	mov    %edi,%eax
 4ef:	83 c4 10             	add    $0x10,%esp
 4f2:	83 ef 01             	sub    $0x1,%edi
 4f5:	39 c3                	cmp    %eax,%ebx
 4f7:	75 df                	jne    4d8 <printint+0x68>
}
 4f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4fc:	5b                   	pop    %ebx
 4fd:	5e                   	pop    %esi
 4fe:	5f                   	pop    %edi
 4ff:	5d                   	pop    %ebp
 500:	c3                   	ret
 501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 508:	31 c0                	xor    %eax,%eax
 50a:	eb 89                	jmp    495 <printint+0x25>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000510 <printf>:
=======
 4b8:	31 db                	xor    %ebx,%ebx
 4ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 cf                	mov    %ecx,%edi
 4c6:	f7 75 c4             	divl   -0x3c(%ebp)
 4c9:	0f b6 92 00 09 00 00 	movzbl 0x900(%edx),%edx
 4d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4d3:	89 d8                	mov    %ebx,%eax
 4d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4e1:	76 dd                	jbe    4c0 <printint+0x30>
  if(neg)
 4e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4e6:	85 c9                	test   %ecx,%ecx
 4e8:	74 0c                	je     4f6 <printint+0x66>
    buf[i++] = '-';
 4ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4fd:	eb 07                	jmp    506 <printint+0x76>
 4ff:	90                   	nop
    putc(fd, buf[i]);
 500:	0f b6 13             	movzbl (%ebx),%edx
 503:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 506:	83 ec 04             	sub    $0x4,%esp
 509:	88 55 d7             	mov    %dl,-0x29(%ebp)
 50c:	6a 01                	push   $0x1
 50e:	56                   	push   %esi
 50f:	57                   	push   %edi
 510:	e8 de fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 515:	83 c4 10             	add    $0x10,%esp
 518:	39 de                	cmp    %ebx,%esi
 51a:	75 e4                	jne    500 <printint+0x70>
}
 51c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51f:	5b                   	pop    %ebx
 520:	5e                   	pop    %esi
 521:	5f                   	pop    %edi
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 528:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 52f:	eb 87                	jmp    4b8 <printint+0x28>
 531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop

00000540 <printf>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
<<<<<<< HEAD
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 2c             	sub    $0x2c,%esp
=======
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 2c             	sub    $0x2c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
<<<<<<< HEAD
 519:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 51c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 51f:	0f b6 1e             	movzbl (%esi),%ebx
 522:	83 c6 01             	add    $0x1,%esi
 525:	84 db                	test   %bl,%bl
 527:	74 67                	je     590 <printf+0x80>
 529:	8d 4d 10             	lea    0x10(%ebp),%ecx
 52c:	31 d2                	xor    %edx,%edx
 52e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 531:	eb 34                	jmp    567 <printf+0x57>
 533:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 538:	89 55 d4             	mov    %edx,-0x2c(%ebp)
=======
 549:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 54c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 54f:	0f b6 13             	movzbl (%ebx),%edx
 552:	84 d2                	test   %dl,%dl
 554:	74 6a                	je     5c0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 556:	8d 45 10             	lea    0x10(%ebp),%eax
 559:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 55c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 55f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 561:	89 45 d0             	mov    %eax,-0x30(%ebp)
 564:	eb 36                	jmp    59c <printf+0x5c>
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
<<<<<<< HEAD
 53b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 540:	83 f8 25             	cmp    $0x25,%eax
 543:	74 18                	je     55d <printf+0x4d>
  write(fd, &c, 1);
 545:	83 ec 04             	sub    $0x4,%esp
 548:	8d 45 e7             	lea    -0x19(%ebp),%eax
 54b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 54e:	6a 01                	push   $0x1
 550:	50                   	push   %eax
 551:	57                   	push   %edi
 552:	e8 8c fe ff ff       	call   3e3 <write>
 557:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 55a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 55d:	0f b6 1e             	movzbl (%esi),%ebx
 560:	83 c6 01             	add    $0x1,%esi
 563:	84 db                	test   %bl,%bl
 565:	74 29                	je     590 <printf+0x80>
    c = fmt[i] & 0xff;
 567:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 56a:	85 d2                	test   %edx,%edx
 56c:	74 ca                	je     538 <printf+0x28>
      }
    } else if(state == '%'){
 56e:	83 fa 25             	cmp    $0x25,%edx
 571:	75 ea                	jne    55d <printf+0x4d>
      if(c == 'd'){
 573:	83 f8 25             	cmp    $0x25,%eax
 576:	0f 84 04 01 00 00    	je     680 <printf+0x170>
 57c:	83 e8 63             	sub    $0x63,%eax
 57f:	83 f8 15             	cmp    $0x15,%eax
 582:	77 1c                	ja     5a0 <printf+0x90>
 584:	ff 24 85 58 08 00 00 	jmp    *0x858(,%eax,4)
 58b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
=======
 573:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	74 15                	je     592 <printf+0x52>
  write(fd, &c, 1);
 57d:	83 ec 04             	sub    $0x4,%esp
 580:	88 55 e7             	mov    %dl,-0x19(%ebp)
 583:	6a 01                	push   $0x1
 585:	57                   	push   %edi
 586:	56                   	push   %esi
 587:	e8 67 fe ff ff       	call   3f3 <write>
 58c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 58f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 592:	0f b6 13             	movzbl (%ebx),%edx
 595:	83 c3 01             	add    $0x1,%ebx
 598:	84 d2                	test   %dl,%dl
 59a:	74 24                	je     5c0 <printf+0x80>
    c = fmt[i] & 0xff;
 59c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 59f:	85 c9                	test   %ecx,%ecx
 5a1:	74 cd                	je     570 <printf+0x30>
      }
    } else if(state == '%'){
 5a3:	83 f9 25             	cmp    $0x25,%ecx
 5a6:	75 ea                	jne    592 <printf+0x52>
      if(c == 'd'){
 5a8:	83 f8 25             	cmp    $0x25,%eax
 5ab:	0f 84 07 01 00 00    	je     6b8 <printf+0x178>
 5b1:	83 e8 63             	sub    $0x63,%eax
 5b4:	83 f8 15             	cmp    $0x15,%eax
 5b7:	77 17                	ja     5d0 <printf+0x90>
 5b9:	ff 24 85 a8 08 00 00 	jmp    *0x8a8(,%eax,4)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        putc(fd, c);
      }
      state = 0;
    }
  }
}
<<<<<<< HEAD
 590:	8d 65 f4             	lea    -0xc(%ebp),%esp
 593:	5b                   	pop    %ebx
 594:	5e                   	pop    %esi
 595:	5f                   	pop    %edi
 596:	5d                   	pop    %ebp
 597:	c3                   	ret
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5aa:	6a 01                	push   $0x1
 5ac:	52                   	push   %edx
 5ad:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5b0:	57                   	push   %edi
 5b1:	e8 2d fe ff ff       	call   3e3 <write>
 5b6:	83 c4 0c             	add    $0xc,%esp
 5b9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5bc:	6a 01                	push   $0x1
 5be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5c1:	52                   	push   %edx
 5c2:	57                   	push   %edi
 5c3:	e8 1b fe ff ff       	call   3e3 <write>
        putc(fd, c);
 5c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cb:	31 d2                	xor    %edx,%edx
 5cd:	eb 8e                	jmp    55d <printf+0x4d>
 5cf:	90                   	nop
        printint(fd, *ap, 16, 0);
 5d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5d3:	83 ec 0c             	sub    $0xc,%esp
 5d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5db:	8b 13                	mov    (%ebx),%edx
 5dd:	6a 00                	push   $0x0
 5df:	89 f8                	mov    %edi,%eax
        ap++;
 5e1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5e4:	e8 87 fe ff ff       	call   470 <printint>
        ap++;
 5e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 67 ff ff ff       	jmp    55d <printf+0x4d>
        s = (char*)*ap;
 5f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5f9:	8b 18                	mov    (%eax),%ebx
        ap++;
 5fb:	83 c0 04             	add    $0x4,%eax
 5fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 601:	85 db                	test   %ebx,%ebx
 603:	0f 84 87 00 00 00    	je     690 <printf+0x180>
        while(*s != 0){
 609:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 60c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 60e:	84 c0                	test   %al,%al
 610:	0f 84 47 ff ff ff    	je     55d <printf+0x4d>
 616:	8d 55 e7             	lea    -0x19(%ebp),%edx
 619:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 61c:	89 de                	mov    %ebx,%esi
 61e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 620:	83 ec 04             	sub    $0x4,%esp
 623:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 626:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 629:	6a 01                	push   $0x1
 62b:	53                   	push   %ebx
 62c:	57                   	push   %edi
 62d:	e8 b1 fd ff ff       	call   3e3 <write>
        while(*s != 0){
 632:	0f b6 06             	movzbl (%esi),%eax
 635:	83 c4 10             	add    $0x10,%esp
 638:	84 c0                	test   %al,%al
 63a:	75 e4                	jne    620 <printf+0x110>
      state = 0;
 63c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 63f:	31 d2                	xor    %edx,%edx
 641:	e9 17 ff ff ff       	jmp    55d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 646:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 649:	83 ec 0c             	sub    $0xc,%esp
 64c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 651:	8b 13                	mov    (%ebx),%edx
 653:	6a 01                	push   $0x1
 655:	eb 88                	jmp    5df <printf+0xcf>
        putc(fd, *ap);
 657:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 65a:	83 ec 04             	sub    $0x4,%esp
 65d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 660:	8b 03                	mov    (%ebx),%eax
        ap++;
 662:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 665:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 668:	6a 01                	push   $0x1
 66a:	52                   	push   %edx
 66b:	57                   	push   %edi
 66c:	e8 72 fd ff ff       	call   3e3 <write>
        ap++;
 671:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 674:	83 c4 10             	add    $0x10,%esp
      state = 0;
 677:	31 d2                	xor    %edx,%edx
 679:	e9 df fe ff ff       	jmp    55d <printf+0x4d>
 67e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e7             	mov    %bl,-0x19(%ebp)
 686:	8d 55 e7             	lea    -0x19(%ebp),%edx
 689:	6a 01                	push   $0x1
 68b:	e9 31 ff ff ff       	jmp    5c1 <printf+0xb1>
 690:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 695:	bb 4f 08 00 00       	mov    $0x84f,%ebx
 69a:	e9 77 ff ff ff       	jmp    616 <printf+0x106>
 69f:	90                   	nop

000006a0 <free>:
=======
 5c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    
 5c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 5d6:	6a 01                	push   $0x1
 5d8:	57                   	push   %edi
 5d9:	56                   	push   %esi
 5da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5de:	e8 10 fe ff ff       	call   3f3 <write>
        putc(fd, c);
 5e3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 5e7:	83 c4 0c             	add    $0xc,%esp
 5ea:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5ed:	6a 01                	push   $0x1
 5ef:	57                   	push   %edi
 5f0:	56                   	push   %esi
 5f1:	e8 fd fd ff ff       	call   3f3 <write>
        putc(fd, c);
 5f6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f9:	31 c9                	xor    %ecx,%ecx
 5fb:	eb 95                	jmp    592 <printf+0x52>
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	6a 00                	push   $0x0
 60a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 60d:	8b 10                	mov    (%eax),%edx
 60f:	89 f0                	mov    %esi,%eax
 611:	e8 7a fe ff ff       	call   490 <printint>
        ap++;
 616:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 61a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 61d:	31 c9                	xor    %ecx,%ecx
 61f:	e9 6e ff ff ff       	jmp    592 <printf+0x52>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 628:	8b 45 d0             	mov    -0x30(%ebp),%eax
 62b:	8b 10                	mov    (%eax),%edx
        ap++;
 62d:	83 c0 04             	add    $0x4,%eax
 630:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 633:	85 d2                	test   %edx,%edx
 635:	0f 84 8d 00 00 00    	je     6c8 <printf+0x188>
        while(*s != 0){
 63b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 63e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 640:	84 c0                	test   %al,%al
 642:	0f 84 4a ff ff ff    	je     592 <printf+0x52>
 648:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 64b:	89 d3                	mov    %edx,%ebx
 64d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
          s++;
 653:	83 c3 01             	add    $0x1,%ebx
 656:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 659:	6a 01                	push   $0x1
 65b:	57                   	push   %edi
 65c:	56                   	push   %esi
 65d:	e8 91 fd ff ff       	call   3f3 <write>
        while(*s != 0){
 662:	0f b6 03             	movzbl (%ebx),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x110>
      state = 0;
 66c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 66f:	31 c9                	xor    %ecx,%ecx
 671:	e9 1c ff ff ff       	jmp    592 <printf+0x52>
 676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	b9 0a 00 00 00       	mov    $0xa,%ecx
 688:	6a 01                	push   $0x1
 68a:	e9 7b ff ff ff       	jmp    60a <printf+0xca>
 68f:	90                   	nop
        putc(fd, *ap);
 690:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 693:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 696:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 698:	6a 01                	push   $0x1
 69a:	57                   	push   %edi
 69b:	56                   	push   %esi
        putc(fd, *ap);
 69c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 69f:	e8 4f fd ff ff       	call   3f3 <write>
        ap++;
 6a4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ab:	31 c9                	xor    %ecx,%ecx
 6ad:	e9 e0 fe ff ff       	jmp    592 <printf+0x52>
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 6b8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6bb:	83 ec 04             	sub    $0x4,%esp
 6be:	e9 2a ff ff ff       	jmp    5ed <printf+0xad>
 6c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6c7:	90                   	nop
          s = "(null)";
 6c8:	ba 9f 08 00 00       	mov    $0x89f,%edx
        while(*s != 0){
 6cd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6d0:	b8 28 00 00 00       	mov    $0x28,%eax
 6d5:	89 d3                	mov    %edx,%ebx
 6d7:	e9 74 ff ff ff       	jmp    650 <printf+0x110>
 6dc:	66 90                	xchg   %ax,%ax
 6de:	66 90                	xchg   %ax,%ax

000006e0 <free>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
static Header base;
static Header *freep;

void
free(void *ap)
{
<<<<<<< HEAD
 6a0:	55                   	push   %ebp
=======
 6e0:	55                   	push   %ebp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
<<<<<<< HEAD
 6a1:	a1 a0 0d 00 00       	mov    0xda0,%eax
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
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	39 c8                	cmp    %ecx,%eax
 6bc:	73 32                	jae    6f0 <free+0x50>
 6be:	39 d1                	cmp    %edx,%ecx
 6c0:	72 04                	jb     6c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c2:	39 d0                	cmp    %edx,%eax
 6c4:	72 32                	jb     6f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6cc:	39 fa                	cmp    %edi,%edx
 6ce:	74 30                	je     700 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6d3:	8b 50 04             	mov    0x4(%eax),%edx
 6d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d9:	39 f1                	cmp    %esi,%ecx
 6db:	74 3a                	je     717 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6dd:	89 08                	mov    %ecx,(%eax)
=======
 6e1:	a1 00 0e 00 00       	mov    0xe00,%eax
{
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	57                   	push   %edi
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f8:	89 c2                	mov    %eax,%edx
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	39 ca                	cmp    %ecx,%edx
 6fe:	73 30                	jae    730 <free+0x50>
 700:	39 c1                	cmp    %eax,%ecx
 702:	72 04                	jb     708 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	39 c2                	cmp    %eax,%edx
 706:	72 f0                	jb     6f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 708:	8b 73 fc             	mov    -0x4(%ebx),%esi
 70b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 70e:	39 f8                	cmp    %edi,%eax
 710:	74 30                	je     742 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 712:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 715:	8b 42 04             	mov    0x4(%edx),%eax
 718:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 71b:	39 f1                	cmp    %esi,%ecx
 71d:	74 3a                	je     759 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 71f:	89 0a                	mov    %ecx,(%edx)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else
    p->s.ptr = bp;
  freep = p;
}
<<<<<<< HEAD
 6df:	5b                   	pop    %ebx
  freep = p;
 6e0:	a3 a0 0d 00 00       	mov    %eax,0xda0
}
 6e5:	5e                   	pop    %esi
 6e6:	5f                   	pop    %edi
 6e7:	5d                   	pop    %ebp
 6e8:	c3                   	ret
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 04                	jb     6f8 <free+0x58>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	72 ce                	jb     6c6 <free+0x26>
{
 6f8:	89 d0                	mov    %edx,%eax
 6fa:	eb bc                	jmp    6b8 <free+0x18>
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 700:	03 72 04             	add    0x4(%edx),%esi
 703:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 706:	8b 10                	mov    (%eax),%edx
 708:	8b 12                	mov    (%edx),%edx
 70a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 50 04             	mov    0x4(%eax),%edx
 710:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	75 c6                	jne    6dd <free+0x3d>
    p->s.size += bp->s.size;
 717:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 71a:	a3 a0 0d 00 00       	mov    %eax,0xda0
    p->s.size += bp->s.size;
 71f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 722:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 725:	89 08                	mov    %ecx,(%eax)
}
 727:	5b                   	pop    %ebx
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000730 <malloc>:
=======
 721:	5b                   	pop    %ebx
  freep = p;
 722:	89 15 00 0e 00 00    	mov    %edx,0xe00
}
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret    
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	39 c2                	cmp    %eax,%edx
 732:	72 c4                	jb     6f8 <free+0x18>
 734:	39 c1                	cmp    %eax,%ecx
 736:	73 c0                	jae    6f8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 738:	8b 73 fc             	mov    -0x4(%ebx),%esi
 73b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 73e:	39 f8                	cmp    %edi,%eax
 740:	75 d0                	jne    712 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 742:	03 70 04             	add    0x4(%eax),%esi
 745:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 748:	8b 02                	mov    (%edx),%eax
 74a:	8b 00                	mov    (%eax),%eax
 74c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 74f:	8b 42 04             	mov    0x4(%edx),%eax
 752:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 755:	39 f1                	cmp    %esi,%ecx
 757:	75 c6                	jne    71f <free+0x3f>
    p->s.size += bp->s.size;
 759:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 75c:	89 15 00 0e 00 00    	mov    %edx,0xe00
    p->s.size += bp->s.size;
 762:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 765:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 768:	89 0a                	mov    %ecx,(%edx)
}
 76a:	5b                   	pop    %ebx
 76b:	5e                   	pop    %esi
 76c:	5f                   	pop    %edi
 76d:	5d                   	pop    %ebp
 76e:	c3                   	ret    
 76f:	90                   	nop

00000770 <malloc>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  return freep;
}

void*
malloc(uint nbytes)
{
<<<<<<< HEAD
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 0c             	sub    $0xc,%esp
=======
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 1c             	sub    $0x1c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
<<<<<<< HEAD
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 15 a0 0d 00 00    	mov    0xda0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 78 07             	lea    0x7(%eax),%edi
 745:	c1 ef 03             	shr    $0x3,%edi
 748:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 74b:	85 d2                	test   %edx,%edx
 74d:	0f 84 8d 00 00 00    	je     7e0 <malloc+0xb0>
=======
 779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 77c:	8b 3d 00 0e 00 00    	mov    0xe00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8d 70 07             	lea    0x7(%eax),%esi
 785:	c1 ee 03             	shr    $0x3,%esi
 788:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 78b:	85 ff                	test   %edi,%edi
 78d:	0f 84 9d 00 00 00    	je     830 <malloc+0xc0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
<<<<<<< HEAD
 753:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 755:	8b 48 04             	mov    0x4(%eax),%ecx
 758:	39 f9                	cmp    %edi,%ecx
 75a:	73 64                	jae    7c0 <malloc+0x90>
  if(nu < 4096)
 75c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 761:	39 df                	cmp    %ebx,%edi
 763:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 766:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 76d:	eb 0a                	jmp    779 <malloc+0x49>
 76f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 772:	8b 48 04             	mov    0x4(%eax),%ecx
 775:	39 f9                	cmp    %edi,%ecx
 777:	73 47                	jae    7c0 <malloc+0x90>
=======
 793:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 795:	8b 4a 04             	mov    0x4(%edx),%ecx
 798:	39 f1                	cmp    %esi,%ecx
 79a:	73 6a                	jae    806 <malloc+0x96>
 79c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7a1:	39 de                	cmp    %ebx,%esi
 7a3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7a6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7b0:	eb 17                	jmp    7c9 <malloc+0x59>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ba:	8b 48 04             	mov    0x4(%eax),%ecx
 7bd:	39 f1                	cmp    %esi,%ecx
 7bf:	73 4f                	jae    810 <malloc+0xa0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
<<<<<<< HEAD
 779:	89 c2                	mov    %eax,%edx
 77b:	3b 05 a0 0d 00 00    	cmp    0xda0,%eax
 781:	75 ed                	jne    770 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	56                   	push   %esi
 787:	e8 bf fc ff ff       	call   44b <sbrk>
  if(p == (char*)-1)
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	83 f8 ff             	cmp    $0xffffffff,%eax
 792:	74 1c                	je     7b0 <malloc+0x80>
  hp->s.size = nu;
 794:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 797:	83 ec 0c             	sub    $0xc,%esp
 79a:	83 c0 08             	add    $0x8,%eax
 79d:	50                   	push   %eax
 79e:	e8 fd fe ff ff       	call   6a0 <free>
  return freep;
 7a3:	8b 15 a0 0d 00 00    	mov    0xda0,%edx
      if((p = morecore(nunits)) == 0)
 7a9:	83 c4 10             	add    $0x10,%esp
 7ac:	85 d2                	test   %edx,%edx
 7ae:	75 c0                	jne    770 <malloc+0x40>
        return 0;
  }
}
 7b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b3:	31 c0                	xor    %eax,%eax
}
 7b5:	5b                   	pop    %ebx
 7b6:	5e                   	pop    %esi
 7b7:	5f                   	pop    %edi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7c0:	39 cf                	cmp    %ecx,%edi
 7c2:	74 4c                	je     810 <malloc+0xe0>
        p->s.size -= nunits;
 7c4:	29 f9                	sub    %edi,%ecx
 7c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7cc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7cf:	89 15 a0 0d 00 00    	mov    %edx,0xda0
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
 7e0:	c7 05 a0 0d 00 00 a4 	movl   $0xda4,0xda0
 7e7:	0d 00 00 
    base.s.size = 0;
 7ea:	b8 a4 0d 00 00       	mov    $0xda4,%eax
    base.s.ptr = freep = prevp = &base;
 7ef:	c7 05 a4 0d 00 00 a4 	movl   $0xda4,0xda4
 7f6:	0d 00 00 
    base.s.size = 0;
 7f9:	c7 05 a8 0d 00 00 00 	movl   $0x0,0xda8
 800:	00 00 00 
    if(p->s.size >= nunits){
 803:	e9 54 ff ff ff       	jmp    75c <malloc+0x2c>
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb b9                	jmp    7cf <malloc+0x9f>
=======
 7c1:	8b 3d 00 0e 00 00    	mov    0xe00,%edi
 7c7:	89 c2                	mov    %eax,%edx
 7c9:	39 d7                	cmp    %edx,%edi
 7cb:	75 eb                	jne    7b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7cd:	83 ec 0c             	sub    $0xc,%esp
 7d0:	ff 75 e4             	push   -0x1c(%ebp)
 7d3:	e8 83 fc ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 7d8:	83 c4 10             	add    $0x10,%esp
 7db:	83 f8 ff             	cmp    $0xffffffff,%eax
 7de:	74 1c                	je     7fc <malloc+0x8c>
  hp->s.size = nu;
 7e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7e3:	83 ec 0c             	sub    $0xc,%esp
 7e6:	83 c0 08             	add    $0x8,%eax
 7e9:	50                   	push   %eax
 7ea:	e8 f1 fe ff ff       	call   6e0 <free>
  return freep;
 7ef:	8b 15 00 0e 00 00    	mov    0xe00,%edx
      if((p = morecore(nunits)) == 0)
 7f5:	83 c4 10             	add    $0x10,%esp
 7f8:	85 d2                	test   %edx,%edx
 7fa:	75 bc                	jne    7b8 <malloc+0x48>
        return 0;
  }
}
 7fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7ff:	31 c0                	xor    %eax,%eax
}
 801:	5b                   	pop    %ebx
 802:	5e                   	pop    %esi
 803:	5f                   	pop    %edi
 804:	5d                   	pop    %ebp
 805:	c3                   	ret    
    if(p->s.size >= nunits){
 806:	89 d0                	mov    %edx,%eax
 808:	89 fa                	mov    %edi,%edx
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 810:	39 ce                	cmp    %ecx,%esi
 812:	74 4c                	je     860 <malloc+0xf0>
        p->s.size -= nunits;
 814:	29 f1                	sub    %esi,%ecx
 816:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 819:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 81c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 81f:	89 15 00 0e 00 00    	mov    %edx,0xe00
}
 825:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 828:	83 c0 08             	add    $0x8,%eax
}
 82b:	5b                   	pop    %ebx
 82c:	5e                   	pop    %esi
 82d:	5f                   	pop    %edi
 82e:	5d                   	pop    %ebp
 82f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 830:	c7 05 00 0e 00 00 04 	movl   $0xe04,0xe00
 837:	0e 00 00 
    base.s.size = 0;
 83a:	bf 04 0e 00 00       	mov    $0xe04,%edi
    base.s.ptr = freep = prevp = &base;
 83f:	c7 05 04 0e 00 00 04 	movl   $0xe04,0xe04
 846:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 849:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 84b:	c7 05 08 0e 00 00 00 	movl   $0x0,0xe08
 852:	00 00 00 
    if(p->s.size >= nunits){
 855:	e9 42 ff ff ff       	jmp    79c <malloc+0x2c>
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 860:	8b 08                	mov    (%eax),%ecx
 862:	89 0a                	mov    %ecx,(%edx)
 864:	eb b9                	jmp    81f <malloc+0xaf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
