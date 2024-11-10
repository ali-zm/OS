
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
   f:	53                   	push   %ebx
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 1f                	jle    42 <main+0x42>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  31:	e8 ca 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  36:	83 c4 10             	add    $0x10,%esp
  39:	39 de                	cmp    %ebx,%esi
  3b:	75 eb                	jne    28 <main+0x28>
  exit();
  3d:	e8 31 05 00 00       	call   573 <exit>
    ls(".");
  42:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
  45:	68 10 0a 00 00       	push   $0xa10
=======
  45:	68 70 0a 00 00       	push   $0xa70
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  4a:	e8 b1 00 00 00       	call   100 <ls>
    exit();
  4f:	e8 1f 05 00 00       	call   573 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	56                   	push   %esi
  6c:	e8 4f 03 00 00       	call   3c0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 f0                	add    %esi,%eax
  76:	89 c3                	mov    %eax,%ebx
  78:	73 0f                	jae    89 <fmtname+0x29>
  7a:	eb 12                	jmp    8e <fmtname+0x2e>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  83:	39 f0                	cmp    %esi,%eax
  85:	72 0a                	jb     91 <fmtname+0x31>
  87:	89 c3                	mov    %eax,%ebx
  89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  8c:	75 f2                	jne    80 <fmtname+0x20>
  p++;
  8e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  91:	83 ec 0c             	sub    $0xc,%esp
  94:	53                   	push   %ebx
  95:	e8 26 03 00 00       	call   3c0 <strlen>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 f8 0d             	cmp    $0xd,%eax
  a0:	77 4a                	ja     ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	53                   	push   %ebx
  a6:	e8 15 03 00 00       	call   3c0 <strlen>
  ab:	83 c4 0c             	add    $0xc,%esp
  ae:	50                   	push   %eax
  af:	53                   	push   %ebx
<<<<<<< HEAD
  b0:	68 98 0d 00 00       	push   $0xd98
  b5:	e8 86 04 00 00       	call   540 <memmove>
=======
  b0:	68 04 0e 00 00       	push   $0xe04
  b5:	e8 a6 04 00 00       	call   560 <memmove>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ba:	89 1c 24             	mov    %ebx,(%esp)
  bd:	e8 fe 02 00 00       	call   3c0 <strlen>
  c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
<<<<<<< HEAD
  c5:	bb 98 0d 00 00       	mov    $0xd98,%ebx
=======
  c5:	bb 04 0e 00 00       	mov    $0xe04,%ebx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	89 c6                	mov    %eax,%esi
  cc:	e8 ef 02 00 00       	call   3c0 <strlen>
  d1:	ba 0e 00 00 00       	mov    $0xe,%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	29 f2                	sub    %esi,%edx
<<<<<<< HEAD
  db:	05 98 0d 00 00       	add    $0xd98,%eax
=======
  db:	05 04 0e 00 00       	add    $0xe04,%eax
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  e0:	52                   	push   %edx
  e1:	6a 20                	push   $0x20
  e3:	50                   	push   %eax
  e4:	e8 07 03 00 00       	call   3f0 <memset>
  return buf;
  e9:	83 c4 10             	add    $0x10,%esp
}
  ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5e                   	pop    %esi
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret
  f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fc:	00 
  fd:	8d 76 00             	lea    0x0(%esi),%esi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 9c 04 00 00       	call   5b3 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 8e 01 00 00    	js     2b0 <ls+0x1b0>
  if(fstat(fd, &st) < 0){
 122:	83 ec 08             	sub    $0x8,%esp
 125:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12b:	89 c3                	mov    %eax,%ebx
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 97 04 00 00       	call   5cb <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 b1 01 00 00    	js     2f0 <ls+0x1f0>
  switch(st.type){
 13f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 146:	66 83 f8 01          	cmp    $0x1,%ax
 14a:	74 54                	je     1a0 <ls+0xa0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	75 37                	jne    189 <ls+0x89>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
<<<<<<< HEAD
 152:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 161:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 167:	57                   	push   %edi
 168:	e8 f3 fe ff ff       	call   60 <fmtname>
 16d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 173:	59                   	pop    %ecx
 174:	5f                   	pop    %edi
 175:	52                   	push   %edx
 176:	56                   	push   %esi
 177:	6a 02                	push   $0x2
 179:	50                   	push   %eax
 17a:	68 f0 09 00 00       	push   $0x9f0
 17f:	6a 01                	push   $0x1
 181:	e8 3a 05 00 00       	call   6c0 <printf>
=======
 170:	83 ec 0c             	sub    $0xc,%esp
 173:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 179:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 17f:	57                   	push   %edi
 180:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 186:	e8 d5 fe ff ff       	call   60 <fmtname>
 18b:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 191:	59                   	pop    %ecx
 192:	5f                   	pop    %edi
 193:	52                   	push   %edx
 194:	56                   	push   %esi
 195:	6a 02                	push   $0x2
 197:	50                   	push   %eax
 198:	68 50 0a 00 00       	push   $0xa50
 19d:	6a 01                	push   $0x1
 19f:	e8 5c 05 00 00       	call   700 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    break;
 186:	83 c4 20             	add    $0x20,%esp
  close(fd);
 189:	83 ec 0c             	sub    $0xc,%esp
 18c:	53                   	push   %ebx
 18d:	e8 09 04 00 00       	call   59b <close>
 192:	83 c4 10             	add    $0x10,%esp
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	83 ec 0c             	sub    $0xc,%esp
 1a3:	57                   	push   %edi
 1a4:	e8 17 02 00 00       	call   3c0 <strlen>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	83 c0 10             	add    $0x10,%eax
 1af:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b4:	0f 87 16 01 00 00    	ja     2d0 <ls+0x1d0>
    strcpy(buf, path);
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	57                   	push   %edi
 1be:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c4:	57                   	push   %edi
 1c5:	e8 66 01 00 00       	call   330 <strcpy>
    p = buf+strlen(buf);
 1ca:	89 3c 24             	mov    %edi,(%esp)
 1cd:	e8 ee 01 00 00       	call   3c0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1d7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1da:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1e0:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1e6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 1f9:	6a 10                	push   $0x10
 1fb:	50                   	push   %eax
 1fc:	53                   	push   %ebx
 1fd:	e8 89 03 00 00       	call   58b <read>
 202:	83 c4 10             	add    $0x10,%esp
 205:	83 f8 10             	cmp    $0x10,%eax
 208:	0f 85 7b ff ff ff    	jne    189 <ls+0x89>
      if(de.inum == 0)
 20e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 215:	00 
 216:	74 d8                	je     1f0 <ls+0xf0>
      memmove(p, de.name, DIRSIZ);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 221:	6a 0e                	push   $0xe
 223:	50                   	push   %eax
 224:	ff b5 a4 fd ff ff    	push   -0x25c(%ebp)
 22a:	e8 11 03 00 00       	call   540 <memmove>
      p[DIRSIZ] = 0;
 22f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 235:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 239:	58                   	pop    %eax
 23a:	5a                   	pop    %edx
 23b:	56                   	push   %esi
 23c:	57                   	push   %edi
 23d:	e8 6e 02 00 00       	call   4b0 <stat>
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	0f 88 cb 00 00 00    	js     318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
<<<<<<< HEAD
 24d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 253:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 259:	83 ec 0c             	sub    $0xc,%esp
 25c:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 263:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 269:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 26f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 275:	57                   	push   %edi
 276:	e8 e5 fd ff ff       	call   60 <fmtname>
 27b:	5a                   	pop    %edx
 27c:	59                   	pop    %ecx
 27d:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 283:	51                   	push   %ecx
 284:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 28a:	52                   	push   %edx
 28b:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 291:	50                   	push   %eax
 292:	68 f0 09 00 00       	push   $0x9f0
 297:	6a 01                	push   $0x1
 299:	e8 22 04 00 00       	call   6c0 <printf>
 29e:	83 c4 20             	add    $0x20,%esp
 2a1:	e9 4a ff ff ff       	jmp    1f0 <ls+0xf0>
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot open %s\n", path);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	57                   	push   %edi
 2b4:	68 c8 09 00 00       	push   $0x9c8
 2b9:	6a 02                	push   $0x2
 2bb:	e8 00 04 00 00       	call   6c0 <printf>
=======
 25d:	83 ec 0c             	sub    $0xc,%esp
 260:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 266:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 26c:	57                   	push   %edi
 26d:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 274:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 27a:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 280:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 286:	e8 d5 fd ff ff       	call   60 <fmtname>
 28b:	5a                   	pop    %edx
 28c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 292:	59                   	pop    %ecx
 293:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 299:	51                   	push   %ecx
 29a:	52                   	push   %edx
 29b:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 2a1:	50                   	push   %eax
 2a2:	68 50 0a 00 00       	push   $0xa50
 2a7:	6a 01                	push   $0x1
 2a9:	e8 52 04 00 00       	call   700 <printf>
 2ae:	83 c4 20             	add    $0x20,%esp
 2b1:	e9 4a ff ff ff       	jmp    200 <ls+0x100>
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	57                   	push   %edi
 2c4:	68 28 0a 00 00       	push   $0xa28
 2c9:	6a 02                	push   $0x2
 2cb:	e8 30 04 00 00       	call   700 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    return;
 2c0:	83 c4 10             	add    $0x10,%esp
}
 2c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret
 2cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
<<<<<<< HEAD
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	68 fd 09 00 00       	push   $0x9fd
 2d8:	6a 01                	push   $0x1
 2da:	e8 e1 03 00 00       	call   6c0 <printf>
=======
 2e0:	83 ec 08             	sub    $0x8,%esp
 2e3:	68 5d 0a 00 00       	push   $0xa5d
 2e8:	6a 01                	push   $0x1
 2ea:	e8 11 04 00 00       	call   700 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      break;
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	e9 a2 fe ff ff       	jmp    189 <ls+0x89>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
<<<<<<< HEAD
 2f0:	83 ec 04             	sub    $0x4,%esp
 2f3:	57                   	push   %edi
 2f4:	68 dc 09 00 00       	push   $0x9dc
 2f9:	6a 02                	push   $0x2
 2fb:	e8 c0 03 00 00       	call   6c0 <printf>
=======
 300:	83 ec 04             	sub    $0x4,%esp
 303:	57                   	push   %edi
 304:	68 3c 0a 00 00       	push   $0xa3c
 309:	6a 02                	push   $0x2
 30b:	e8 f0 03 00 00       	call   700 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    close(fd);
 300:	89 1c 24             	mov    %ebx,(%esp)
 303:	e8 93 02 00 00       	call   59b <close>
    return;
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret
 313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
<<<<<<< HEAD
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	57                   	push   %edi
 31c:	68 dc 09 00 00       	push   $0x9dc
 321:	6a 01                	push   $0x1
 323:	e8 98 03 00 00       	call   6c0 <printf>
=======
 328:	83 ec 04             	sub    $0x4,%esp
 32b:	57                   	push   %edi
 32c:	68 3c 0a 00 00       	push   $0xa3c
 331:	6a 01                	push   $0x1
 333:	e8 c8 03 00 00       	call   700 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        continue;
 328:	83 c4 10             	add    $0x10,%esp
 32b:	e9 c0 fe ff ff       	jmp    1f0 <ls+0xf0>

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 331:	31 c0                	xor    %eax,%eax
{
 333:	89 e5                	mov    %esp,%ebp
 335:	53                   	push   %ebx
 336:	8b 4d 08             	mov    0x8(%ebp),%ecx
 339:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 340:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 344:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 347:	83 c0 01             	add    $0x1,%eax
 34a:	84 d2                	test   %dl,%dl
 34c:	75 f2                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 351:	89 c8                	mov    %ecx,%eax
 353:	c9                   	leave
 354:	c3                   	ret
 355:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35c:	00 
 35d:	8d 76 00             	lea    0x0(%esi),%esi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	84 c0                	test   %al,%al
 36f:	75 17                	jne    388 <strcmp+0x28>
 371:	eb 3a                	jmp    3ad <strcmp+0x4d>
 373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 378:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 37c:	83 c2 01             	add    $0x1,%edx
 37f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 382:	84 c0                	test   %al,%al
 384:	74 1a                	je     3a0 <strcmp+0x40>
 386:	89 d9                	mov    %ebx,%ecx
 388:	0f b6 19             	movzbl (%ecx),%ebx
 38b:	38 c3                	cmp    %al,%bl
 38d:	74 e9                	je     378 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 38f:	29 d8                	sub    %ebx,%eax
}
 391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 394:	c9                   	leave
 395:	c3                   	ret
 396:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39d:	00 
 39e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 3a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3a4:	31 c0                	xor    %eax,%eax
 3a6:	29 d8                	sub    %ebx,%eax
}
 3a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ab:	c9                   	leave
 3ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3ad:	0f b6 19             	movzbl (%ecx),%ebx
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	eb db                	jmp    38f <strcmp+0x2f>
 3b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bb:	00 
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 3a 00             	cmpb   $0x0,(%edx)
 3c9:	74 15                	je     3e0 <strlen+0x20>
 3cb:	31 c0                	xor    %eax,%eax
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	83 c0 01             	add    $0x1,%eax
 3d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3d7:	89 c1                	mov    %eax,%ecx
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	89 c8                	mov    %ecx,%eax
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret
 3df:	90                   	nop
  for(n = 0; s[n]; n++)
 3e0:	31 c9                	xor    %ecx,%ecx
}
 3e2:	5d                   	pop    %ebp
 3e3:	89 c8                	mov    %ecx,%eax
 3e5:	c3                   	ret
 3e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ed:	00 
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	8b 7d fc             	mov    -0x4(%ebp),%edi
 405:	89 d0                	mov    %edx,%eax
 407:	c9                   	leave
 408:	c3                   	ret
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 12                	jne    433 <strchr+0x23>
 421:	eb 1d                	jmp    440 <strchr+0x30>
 423:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 428:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 42c:	83 c0 01             	add    $0x1,%eax
 42f:	84 d2                	test   %dl,%dl
 431:	74 0d                	je     440 <strchr+0x30>
    if(*s == c)
 433:	38 d1                	cmp    %dl,%cl
 435:	75 f1                	jne    428 <strchr+0x18>
      return (char*)s;
  return 0;
}
 437:	5d                   	pop    %ebp
 438:	c3                   	ret
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 440:	31 c0                	xor    %eax,%eax
}
 442:	5d                   	pop    %ebp
 443:	c3                   	ret
 444:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44b:	00 
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 455:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 458:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 459:	31 db                	xor    %ebx,%ebx
{
 45b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 45e:	eb 27                	jmp    487 <gets+0x37>
    cc = read(0, &c, 1);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	6a 01                	push   $0x1
 465:	56                   	push   %esi
 466:	6a 00                	push   $0x0
 468:	e8 1e 01 00 00       	call   58b <read>
    if(cc < 1)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	85 c0                	test   %eax,%eax
 472:	7e 1d                	jle    491 <gets+0x41>
      break;
    buf[i++] = c;
 474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 478:	8b 55 08             	mov    0x8(%ebp),%edx
 47b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 47f:	3c 0a                	cmp    $0xa,%al
 481:	74 10                	je     493 <gets+0x43>
 483:	3c 0d                	cmp    $0xd,%al
 485:	74 0c                	je     493 <gets+0x43>
  for(i=0; i+1 < max; ){
 487:	89 df                	mov    %ebx,%edi
 489:	83 c3 01             	add    $0x1,%ebx
 48c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48f:	7c cf                	jl     460 <gets+0x10>
 491:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 49a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49d:	5b                   	pop    %ebx
 49e:	5e                   	pop    %esi
 49f:	5f                   	pop    %edi
 4a0:	5d                   	pop    %ebp
 4a1:	c3                   	ret
 4a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4a9:	00 
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	6a 00                	push   $0x0
 4ba:	ff 75 08             	push   0x8(%ebp)
 4bd:	e8 f1 00 00 00       	call   5b3 <open>
  if(fd < 0)
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	85 c0                	test   %eax,%eax
 4c7:	78 27                	js     4f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	push   0xc(%ebp)
 4cf:	89 c3                	mov    %eax,%ebx
 4d1:	50                   	push   %eax
 4d2:	e8 f4 00 00 00       	call   5cb <fstat>
  close(fd);
 4d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4da:	89 c6                	mov    %eax,%esi
  close(fd);
 4dc:	e8 ba 00 00 00       	call   59b <close>
  return r;
 4e1:	83 c4 10             	add    $0x10,%esp
}
 4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4e7:	89 f0                	mov    %esi,%eax
 4e9:	5b                   	pop    %ebx
 4ea:	5e                   	pop    %esi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb ed                	jmp    4e4 <stat+0x34>
 4f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4fe:	00 
 4ff:	90                   	nop

00000500 <atoi>:

int
atoi(const char *s)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 507:	0f be 02             	movsbl (%edx),%eax
 50a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 50d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 510:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 515:	77 1e                	ja     535 <atoi+0x35>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop
    n = n*10 + *s++ - '0';
 520:	83 c2 01             	add    $0x1,%edx
 523:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 526:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 52a:	0f be 02             	movsbl (%edx),%eax
 52d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 530:	80 fb 09             	cmp    $0x9,%bl
 533:	76 eb                	jbe    520 <atoi+0x20>
  return n;
}
 535:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 538:	89 c8                	mov    %ecx,%eax
 53a:	c9                   	leave
 53b:	c3                   	ret
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	8b 45 10             	mov    0x10(%ebp),%eax
 547:	8b 55 08             	mov    0x8(%ebp),%edx
 54a:	56                   	push   %esi
 54b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 54e:	85 c0                	test   %eax,%eax
 550:	7e 13                	jle    565 <memmove+0x25>
 552:	01 d0                	add    %edx,%eax
  dst = vdst;
 554:	89 d7                	mov    %edx,%edi
 556:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55d:	00 
 55e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 560:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 561:	39 f8                	cmp    %edi,%eax
 563:	75 fb                	jne    560 <memmove+0x20>
  return vdst;
}
 565:	5e                   	pop    %esi
 566:	89 d0                	mov    %edx,%eax
 568:	5f                   	pop    %edi
 569:	5d                   	pop    %ebp
 56a:	c3                   	ret

0000056b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 56b:	b8 01 00 00 00       	mov    $0x1,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret

00000573 <exit>:
SYSCALL(exit)
 573:	b8 02 00 00 00       	mov    $0x2,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret

0000057b <wait>:
SYSCALL(wait)
 57b:	b8 03 00 00 00       	mov    $0x3,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret

00000583 <pipe>:
SYSCALL(pipe)
 583:	b8 04 00 00 00       	mov    $0x4,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret

0000058b <read>:
SYSCALL(read)
 58b:	b8 05 00 00 00       	mov    $0x5,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret

00000593 <write>:
SYSCALL(write)
 593:	b8 10 00 00 00       	mov    $0x10,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret

0000059b <close>:
SYSCALL(close)
 59b:	b8 15 00 00 00       	mov    $0x15,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret

000005a3 <kill>:
SYSCALL(kill)
 5a3:	b8 06 00 00 00       	mov    $0x6,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret

000005ab <exec>:
SYSCALL(exec)
 5ab:	b8 07 00 00 00       	mov    $0x7,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <open>:
SYSCALL(open)
 5b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <mknod>:
SYSCALL(mknod)
 5bb:	b8 11 00 00 00       	mov    $0x11,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <unlink>:
SYSCALL(unlink)
 5c3:	b8 12 00 00 00       	mov    $0x12,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <fstat>:
SYSCALL(fstat)
 5cb:	b8 08 00 00 00       	mov    $0x8,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <link>:
SYSCALL(link)
 5d3:	b8 13 00 00 00       	mov    $0x13,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <mkdir>:
SYSCALL(mkdir)
 5db:	b8 14 00 00 00       	mov    $0x14,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <chdir>:
SYSCALL(chdir)
 5e3:	b8 09 00 00 00       	mov    $0x9,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <dup>:
SYSCALL(dup)
 5eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <getpid>:
SYSCALL(getpid)
 5f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <sbrk>:
SYSCALL(sbrk)
 5fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <sleep>:
SYSCALL(sleep)
 603:	b8 0d 00 00 00       	mov    $0xd,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <uptime>:
SYSCALL(uptime)
<<<<<<< HEAD
 60b:	b8 0e 00 00 00       	mov    $0xe,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <move_file>:
SYSCALL(move_file)
 613:	b8 17 00 00 00       	mov    $0x17,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret
 61b:	66 90                	xchg   %ax,%ax
 61d:	66 90                	xchg   %ax,%ax
 61f:	90                   	nop

00000620 <printint>:
=======
 62b:	b8 0e 00 00 00       	mov    $0xe,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <sort_syscalls>:
SYSCALL(sort_syscalls)
 633:	b8 18 00 00 00       	mov    $0x18,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <get_most_syscalls>:
SYSCALL(get_most_syscalls)
 63b:	b8 19 00 00 00       	mov    $0x19,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <list_active_processes>:
SYSCALL(list_active_processes)
 643:	b8 1a 00 00 00       	mov    $0x1a,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    
 64b:	66 90                	xchg   %ax,%ax
 64d:	66 90                	xchg   %ax,%ax
 64f:	90                   	nop

00000650 <printint>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
<<<<<<< HEAD
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	89 cb                	mov    %ecx,%ebx
=======
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 3c             	sub    $0x3c,%esp
 659:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
<<<<<<< HEAD
 628:	89 d1                	mov    %edx,%ecx
{
 62a:	83 ec 3c             	sub    $0x3c,%esp
 62d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 630:	85 d2                	test   %edx,%edx
 632:	0f 89 80 00 00 00    	jns    6b8 <printint+0x98>
 638:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 63c:	74 7a                	je     6b8 <printint+0x98>
    x = -xx;
 63e:	f7 d9                	neg    %ecx
    neg = 1;
 640:	b8 01 00 00 00       	mov    $0x1,%eax
=======
 65c:	89 d1                	mov    %edx,%ecx
{
 65e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 661:	85 d2                	test   %edx,%edx
 663:	0f 89 7f 00 00 00    	jns    6e8 <printint+0x98>
 669:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 66d:	74 79                	je     6e8 <printint+0x98>
    neg = 1;
 66f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 676:	f7 d9                	neg    %ecx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else {
    x = xx;
  }

  i = 0;
<<<<<<< HEAD
 645:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 648:	31 f6                	xor    %esi,%esi
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 650:	89 c8                	mov    %ecx,%eax
 652:	31 d2                	xor    %edx,%edx
 654:	89 f7                	mov    %esi,%edi
 656:	f7 f3                	div    %ebx
 658:	8d 76 01             	lea    0x1(%esi),%esi
 65b:	0f b6 92 74 0a 00 00 	movzbl 0xa74(%edx),%edx
 662:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 666:	89 ca                	mov    %ecx,%edx
 668:	89 c1                	mov    %eax,%ecx
 66a:	39 da                	cmp    %ebx,%edx
 66c:	73 e2                	jae    650 <printint+0x30>
  if(neg)
 66e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 671:	85 c0                	test   %eax,%eax
 673:	74 07                	je     67c <printint+0x5c>
    buf[i++] = '-';
 675:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 67a:	89 f7                	mov    %esi,%edi
 67c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 67f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 682:	01 df                	add    %ebx,%edi
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 688:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 68b:	83 ec 04             	sub    $0x4,%esp
 68e:	88 45 d7             	mov    %al,-0x29(%ebp)
 691:	8d 45 d7             	lea    -0x29(%ebp),%eax
 694:	6a 01                	push   $0x1
 696:	50                   	push   %eax
 697:	56                   	push   %esi
 698:	e8 f6 fe ff ff       	call   593 <write>
  while(--i >= 0)
 69d:	89 f8                	mov    %edi,%eax
 69f:	83 c4 10             	add    $0x10,%esp
 6a2:	83 ef 01             	sub    $0x1,%edi
 6a5:	39 c3                	cmp    %eax,%ebx
 6a7:	75 df                	jne    688 <printint+0x68>
}
 6a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ac:	5b                   	pop    %ebx
 6ad:	5e                   	pop    %esi
 6ae:	5f                   	pop    %edi
 6af:	5d                   	pop    %ebp
 6b0:	c3                   	ret
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6b8:	31 c0                	xor    %eax,%eax
 6ba:	eb 89                	jmp    645 <printint+0x25>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <printf>:
=======
 678:	31 db                	xor    %ebx,%ebx
 67a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 680:	89 c8                	mov    %ecx,%eax
 682:	31 d2                	xor    %edx,%edx
 684:	89 cf                	mov    %ecx,%edi
 686:	f7 75 c4             	divl   -0x3c(%ebp)
 689:	0f b6 92 d4 0a 00 00 	movzbl 0xad4(%edx),%edx
 690:	89 45 c0             	mov    %eax,-0x40(%ebp)
 693:	89 d8                	mov    %ebx,%eax
 695:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 698:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 69b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 69e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 6a1:	76 dd                	jbe    680 <printint+0x30>
  if(neg)
 6a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 6a6:	85 c9                	test   %ecx,%ecx
 6a8:	74 0c                	je     6b6 <printint+0x66>
    buf[i++] = '-';
 6aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 6af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 6b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 6b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 6b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 6bd:	eb 07                	jmp    6c6 <printint+0x76>
 6bf:	90                   	nop
    putc(fd, buf[i]);
 6c0:	0f b6 13             	movzbl (%ebx),%edx
 6c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 6c6:	83 ec 04             	sub    $0x4,%esp
 6c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 6cc:	6a 01                	push   $0x1
 6ce:	56                   	push   %esi
 6cf:	57                   	push   %edi
 6d0:	e8 de fe ff ff       	call   5b3 <write>
  while(--i >= 0)
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	39 de                	cmp    %ebx,%esi
 6da:	75 e4                	jne    6c0 <printint+0x70>
}
 6dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 6ef:	eb 87                	jmp    678 <printint+0x28>
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop

00000700 <printf>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
<<<<<<< HEAD
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 2c             	sub    $0x2c,%esp
=======
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 2c             	sub    $0x2c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
<<<<<<< HEAD
 6c9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 6cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 6cf:	0f b6 1e             	movzbl (%esi),%ebx
 6d2:	83 c6 01             	add    $0x1,%esi
 6d5:	84 db                	test   %bl,%bl
 6d7:	74 67                	je     740 <printf+0x80>
 6d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6dc:	31 d2                	xor    %edx,%edx
 6de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6e1:	eb 34                	jmp    717 <printf+0x57>
 6e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 6e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
=======
 709:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 70c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 70f:	0f b6 13             	movzbl (%ebx),%edx
 712:	84 d2                	test   %dl,%dl
 714:	74 6a                	je     780 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 716:	8d 45 10             	lea    0x10(%ebp),%eax
 719:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 71c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 71f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 721:	89 45 d0             	mov    %eax,-0x30(%ebp)
 724:	eb 36                	jmp    75c <printf+0x5c>
 726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72d:	8d 76 00             	lea    0x0(%esi),%esi
 730:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
<<<<<<< HEAD
 6eb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6f0:	83 f8 25             	cmp    $0x25,%eax
 6f3:	74 18                	je     70d <printf+0x4d>
  write(fd, &c, 1);
 6f5:	83 ec 04             	sub    $0x4,%esp
 6f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6fe:	6a 01                	push   $0x1
 700:	50                   	push   %eax
 701:	57                   	push   %edi
 702:	e8 8c fe ff ff       	call   593 <write>
 707:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 70a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 70d:	0f b6 1e             	movzbl (%esi),%ebx
 710:	83 c6 01             	add    $0x1,%esi
 713:	84 db                	test   %bl,%bl
 715:	74 29                	je     740 <printf+0x80>
    c = fmt[i] & 0xff;
 717:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 71a:	85 d2                	test   %edx,%edx
 71c:	74 ca                	je     6e8 <printf+0x28>
      }
    } else if(state == '%'){
 71e:	83 fa 25             	cmp    $0x25,%edx
 721:	75 ea                	jne    70d <printf+0x4d>
      if(c == 'd'){
 723:	83 f8 25             	cmp    $0x25,%eax
 726:	0f 84 04 01 00 00    	je     830 <printf+0x170>
 72c:	83 e8 63             	sub    $0x63,%eax
 72f:	83 f8 15             	cmp    $0x15,%eax
 732:	77 1c                	ja     750 <printf+0x90>
 734:	ff 24 85 1c 0a 00 00 	jmp    *0xa1c(,%eax,4)
 73b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
=======
 733:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 738:	83 f8 25             	cmp    $0x25,%eax
 73b:	74 15                	je     752 <printf+0x52>
  write(fd, &c, 1);
 73d:	83 ec 04             	sub    $0x4,%esp
 740:	88 55 e7             	mov    %dl,-0x19(%ebp)
 743:	6a 01                	push   $0x1
 745:	57                   	push   %edi
 746:	56                   	push   %esi
 747:	e8 67 fe ff ff       	call   5b3 <write>
 74c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 74f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 752:	0f b6 13             	movzbl (%ebx),%edx
 755:	83 c3 01             	add    $0x1,%ebx
 758:	84 d2                	test   %dl,%dl
 75a:	74 24                	je     780 <printf+0x80>
    c = fmt[i] & 0xff;
 75c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 75f:	85 c9                	test   %ecx,%ecx
 761:	74 cd                	je     730 <printf+0x30>
      }
    } else if(state == '%'){
 763:	83 f9 25             	cmp    $0x25,%ecx
 766:	75 ea                	jne    752 <printf+0x52>
      if(c == 'd'){
 768:	83 f8 25             	cmp    $0x25,%eax
 76b:	0f 84 07 01 00 00    	je     878 <printf+0x178>
 771:	83 e8 63             	sub    $0x63,%eax
 774:	83 f8 15             	cmp    $0x15,%eax
 777:	77 17                	ja     790 <printf+0x90>
 779:	ff 24 85 7c 0a 00 00 	jmp    *0xa7c(,%eax,4)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        putc(fd, c);
      }
      state = 0;
    }
  }
}
<<<<<<< HEAD
 740:	8d 65 f4             	lea    -0xc(%ebp),%esp
 743:	5b                   	pop    %ebx
 744:	5e                   	pop    %esi
 745:	5f                   	pop    %edi
 746:	5d                   	pop    %ebp
 747:	c3                   	ret
 748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 74f:	00 
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
 753:	8d 55 e7             	lea    -0x19(%ebp),%edx
 756:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 75a:	6a 01                	push   $0x1
 75c:	52                   	push   %edx
 75d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 760:	57                   	push   %edi
 761:	e8 2d fe ff ff       	call   593 <write>
 766:	83 c4 0c             	add    $0xc,%esp
 769:	88 5d e7             	mov    %bl,-0x19(%ebp)
 76c:	6a 01                	push   $0x1
 76e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 771:	52                   	push   %edx
 772:	57                   	push   %edi
 773:	e8 1b fe ff ff       	call   593 <write>
        putc(fd, c);
 778:	83 c4 10             	add    $0x10,%esp
      state = 0;
 77b:	31 d2                	xor    %edx,%edx
 77d:	eb 8e                	jmp    70d <printf+0x4d>
 77f:	90                   	nop
        printint(fd, *ap, 16, 0);
 780:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	b9 10 00 00 00       	mov    $0x10,%ecx
 78b:	8b 13                	mov    (%ebx),%edx
 78d:	6a 00                	push   $0x0
 78f:	89 f8                	mov    %edi,%eax
        ap++;
 791:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 794:	e8 87 fe ff ff       	call   620 <printint>
        ap++;
 799:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 79c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 79f:	31 d2                	xor    %edx,%edx
 7a1:	e9 67 ff ff ff       	jmp    70d <printf+0x4d>
        s = (char*)*ap;
 7a6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7a9:	8b 18                	mov    (%eax),%ebx
        ap++;
 7ab:	83 c0 04             	add    $0x4,%eax
 7ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7b1:	85 db                	test   %ebx,%ebx
 7b3:	0f 84 87 00 00 00    	je     840 <printf+0x180>
        while(*s != 0){
 7b9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 7bc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 7be:	84 c0                	test   %al,%al
 7c0:	0f 84 47 ff ff ff    	je     70d <printf+0x4d>
 7c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 7c9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7cc:	89 de                	mov    %ebx,%esi
 7ce:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 7d6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 7d9:	6a 01                	push   $0x1
 7db:	53                   	push   %ebx
 7dc:	57                   	push   %edi
 7dd:	e8 b1 fd ff ff       	call   593 <write>
        while(*s != 0){
 7e2:	0f b6 06             	movzbl (%esi),%eax
 7e5:	83 c4 10             	add    $0x10,%esp
 7e8:	84 c0                	test   %al,%al
 7ea:	75 e4                	jne    7d0 <printf+0x110>
      state = 0;
 7ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 7ef:	31 d2                	xor    %edx,%edx
 7f1:	e9 17 ff ff ff       	jmp    70d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 7f6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7f9:	83 ec 0c             	sub    $0xc,%esp
 7fc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 801:	8b 13                	mov    (%ebx),%edx
 803:	6a 01                	push   $0x1
 805:	eb 88                	jmp    78f <printf+0xcf>
        putc(fd, *ap);
 807:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 80a:	83 ec 04             	sub    $0x4,%esp
 80d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 810:	8b 03                	mov    (%ebx),%eax
        ap++;
 812:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 815:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 818:	6a 01                	push   $0x1
 81a:	52                   	push   %edx
 81b:	57                   	push   %edi
 81c:	e8 72 fd ff ff       	call   593 <write>
        ap++;
 821:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 824:	83 c4 10             	add    $0x10,%esp
      state = 0;
 827:	31 d2                	xor    %edx,%edx
 829:	e9 df fe ff ff       	jmp    70d <printf+0x4d>
 82e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 830:	83 ec 04             	sub    $0x4,%esp
 833:	88 5d e7             	mov    %bl,-0x19(%ebp)
 836:	8d 55 e7             	lea    -0x19(%ebp),%edx
 839:	6a 01                	push   $0x1
 83b:	e9 31 ff ff ff       	jmp    771 <printf+0xb1>
 840:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 845:	bb 12 0a 00 00       	mov    $0xa12,%ebx
 84a:	e9 77 ff ff ff       	jmp    7c6 <printf+0x106>
 84f:	90                   	nop

00000850 <free>:
=======
 780:	8d 65 f4             	lea    -0xc(%ebp),%esp
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
  write(fd, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 796:	6a 01                	push   $0x1
 798:	57                   	push   %edi
 799:	56                   	push   %esi
 79a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 79e:	e8 10 fe ff ff       	call   5b3 <write>
        putc(fd, c);
 7a3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 7a7:	83 c4 0c             	add    $0xc,%esp
 7aa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7ad:	6a 01                	push   $0x1
 7af:	57                   	push   %edi
 7b0:	56                   	push   %esi
 7b1:	e8 fd fd ff ff       	call   5b3 <write>
        putc(fd, c);
 7b6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7b9:	31 c9                	xor    %ecx,%ecx
 7bb:	eb 95                	jmp    752 <printf+0x52>
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7c8:	6a 00                	push   $0x0
 7ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7cd:	8b 10                	mov    (%eax),%edx
 7cf:	89 f0                	mov    %esi,%eax
 7d1:	e8 7a fe ff ff       	call   650 <printint>
        ap++;
 7d6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 7da:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7dd:	31 c9                	xor    %ecx,%ecx
 7df:	e9 6e ff ff ff       	jmp    752 <printf+0x52>
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7eb:	8b 10                	mov    (%eax),%edx
        ap++;
 7ed:	83 c0 04             	add    $0x4,%eax
 7f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7f3:	85 d2                	test   %edx,%edx
 7f5:	0f 84 8d 00 00 00    	je     888 <printf+0x188>
        while(*s != 0){
 7fb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 7fe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 800:	84 c0                	test   %al,%al
 802:	0f 84 4a ff ff ff    	je     752 <printf+0x52>
 808:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 80b:	89 d3                	mov    %edx,%ebx
 80d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 810:	83 ec 04             	sub    $0x4,%esp
          s++;
 813:	83 c3 01             	add    $0x1,%ebx
 816:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 819:	6a 01                	push   $0x1
 81b:	57                   	push   %edi
 81c:	56                   	push   %esi
 81d:	e8 91 fd ff ff       	call   5b3 <write>
        while(*s != 0){
 822:	0f b6 03             	movzbl (%ebx),%eax
 825:	83 c4 10             	add    $0x10,%esp
 828:	84 c0                	test   %al,%al
 82a:	75 e4                	jne    810 <printf+0x110>
      state = 0;
 82c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 82f:	31 c9                	xor    %ecx,%ecx
 831:	e9 1c ff ff ff       	jmp    752 <printf+0x52>
 836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 840:	83 ec 0c             	sub    $0xc,%esp
 843:	b9 0a 00 00 00       	mov    $0xa,%ecx
 848:	6a 01                	push   $0x1
 84a:	e9 7b ff ff ff       	jmp    7ca <printf+0xca>
 84f:	90                   	nop
        putc(fd, *ap);
 850:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 853:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 856:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 858:	6a 01                	push   $0x1
 85a:	57                   	push   %edi
 85b:	56                   	push   %esi
        putc(fd, *ap);
 85c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 85f:	e8 4f fd ff ff       	call   5b3 <write>
        ap++;
 864:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 868:	83 c4 10             	add    $0x10,%esp
      state = 0;
 86b:	31 c9                	xor    %ecx,%ecx
 86d:	e9 e0 fe ff ff       	jmp    752 <printf+0x52>
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 878:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 87b:	83 ec 04             	sub    $0x4,%esp
 87e:	e9 2a ff ff ff       	jmp    7ad <printf+0xad>
 883:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 887:	90                   	nop
          s = "(null)";
 888:	ba 72 0a 00 00       	mov    $0xa72,%edx
        while(*s != 0){
 88d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 890:	b8 28 00 00 00       	mov    $0x28,%eax
 895:	89 d3                	mov    %edx,%ebx
 897:	e9 74 ff ff ff       	jmp    810 <printf+0x110>
 89c:	66 90                	xchg   %ax,%ax
 89e:	66 90                	xchg   %ax,%ax

000008a0 <free>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
static Header base;
static Header *freep;

void
free(void *ap)
{
<<<<<<< HEAD
 850:	55                   	push   %ebp
=======
 8a0:	55                   	push   %ebp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
<<<<<<< HEAD
 851:	a1 a8 0d 00 00       	mov    0xda8,%eax
{
 856:	89 e5                	mov    %esp,%ebp
 858:	57                   	push   %edi
 859:	56                   	push   %esi
 85a:	53                   	push   %ebx
 85b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 85e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 868:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86a:	39 c8                	cmp    %ecx,%eax
 86c:	73 32                	jae    8a0 <free+0x50>
 86e:	39 d1                	cmp    %edx,%ecx
 870:	72 04                	jb     876 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 872:	39 d0                	cmp    %edx,%eax
 874:	72 32                	jb     8a8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 876:	8b 73 fc             	mov    -0x4(%ebx),%esi
 879:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 87c:	39 fa                	cmp    %edi,%edx
 87e:	74 30                	je     8b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 880:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 883:	8b 50 04             	mov    0x4(%eax),%edx
 886:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 889:	39 f1                	cmp    %esi,%ecx
 88b:	74 3a                	je     8c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 88d:	89 08                	mov    %ecx,(%eax)
=======
 8a1:	a1 14 0e 00 00       	mov    0xe14,%eax
{
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	57                   	push   %edi
 8a9:	56                   	push   %esi
 8aa:	53                   	push   %ebx
 8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 8ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8b8:	89 c2                	mov    %eax,%edx
 8ba:	8b 00                	mov    (%eax),%eax
 8bc:	39 ca                	cmp    %ecx,%edx
 8be:	73 30                	jae    8f0 <free+0x50>
 8c0:	39 c1                	cmp    %eax,%ecx
 8c2:	72 04                	jb     8c8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	39 c2                	cmp    %eax,%edx
 8c6:	72 f0                	jb     8b8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ce:	39 f8                	cmp    %edi,%eax
 8d0:	74 30                	je     902 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8d2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8d5:	8b 42 04             	mov    0x4(%edx),%eax
 8d8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8db:	39 f1                	cmp    %esi,%ecx
 8dd:	74 3a                	je     919 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8df:	89 0a                	mov    %ecx,(%edx)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else
    p->s.ptr = bp;
  freep = p;
}
<<<<<<< HEAD
 88f:	5b                   	pop    %ebx
  freep = p;
 890:	a3 a8 0d 00 00       	mov    %eax,0xda8
}
 895:	5e                   	pop    %esi
 896:	5f                   	pop    %edi
 897:	5d                   	pop    %ebp
 898:	c3                   	ret
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	39 d0                	cmp    %edx,%eax
 8a2:	72 04                	jb     8a8 <free+0x58>
 8a4:	39 d1                	cmp    %edx,%ecx
 8a6:	72 ce                	jb     876 <free+0x26>
{
 8a8:	89 d0                	mov    %edx,%eax
 8aa:	eb bc                	jmp    868 <free+0x18>
 8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8b0:	03 72 04             	add    0x4(%edx),%esi
 8b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	8b 10                	mov    (%eax),%edx
 8b8:	8b 12                	mov    (%edx),%edx
 8ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8bd:	8b 50 04             	mov    0x4(%eax),%edx
 8c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8c3:	39 f1                	cmp    %esi,%ecx
 8c5:	75 c6                	jne    88d <free+0x3d>
    p->s.size += bp->s.size;
 8c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8ca:	a3 a8 0d 00 00       	mov    %eax,0xda8
    p->s.size += bp->s.size;
 8cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8d2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 8d5:	89 08                	mov    %ecx,(%eax)
}
 8d7:	5b                   	pop    %ebx
 8d8:	5e                   	pop    %esi
 8d9:	5f                   	pop    %edi
 8da:	5d                   	pop    %ebp
 8db:	c3                   	ret
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008e0 <malloc>:
=======
 8e1:	5b                   	pop    %ebx
  freep = p;
 8e2:	89 15 14 0e 00 00    	mov    %edx,0xe14
}
 8e8:	5e                   	pop    %esi
 8e9:	5f                   	pop    %edi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f0:	39 c2                	cmp    %eax,%edx
 8f2:	72 c4                	jb     8b8 <free+0x18>
 8f4:	39 c1                	cmp    %eax,%ecx
 8f6:	73 c0                	jae    8b8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 8f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8fe:	39 f8                	cmp    %edi,%eax
 900:	75 d0                	jne    8d2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 902:	03 70 04             	add    0x4(%eax),%esi
 905:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 908:	8b 02                	mov    (%edx),%eax
 90a:	8b 00                	mov    (%eax),%eax
 90c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 90f:	8b 42 04             	mov    0x4(%edx),%eax
 912:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 915:	39 f1                	cmp    %esi,%ecx
 917:	75 c6                	jne    8df <free+0x3f>
    p->s.size += bp->s.size;
 919:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 91c:	89 15 14 0e 00 00    	mov    %edx,0xe14
    p->s.size += bp->s.size;
 922:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 925:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 928:	89 0a                	mov    %ecx,(%edx)
}
 92a:	5b                   	pop    %ebx
 92b:	5e                   	pop    %esi
 92c:	5f                   	pop    %edi
 92d:	5d                   	pop    %ebp
 92e:	c3                   	ret    
 92f:	90                   	nop

00000930 <malloc>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  return freep;
}

void*
malloc(uint nbytes)
{
<<<<<<< HEAD
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
 8e6:	83 ec 0c             	sub    $0xc,%esp
=======
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 1c             	sub    $0x1c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
<<<<<<< HEAD
 8e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ec:	8b 15 a8 0d 00 00    	mov    0xda8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	8d 78 07             	lea    0x7(%eax),%edi
 8f5:	c1 ef 03             	shr    $0x3,%edi
 8f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8fb:	85 d2                	test   %edx,%edx
 8fd:	0f 84 8d 00 00 00    	je     990 <malloc+0xb0>
=======
 939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 93c:	8b 3d 14 0e 00 00    	mov    0xe14,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	8d 70 07             	lea    0x7(%eax),%esi
 945:	c1 ee 03             	shr    $0x3,%esi
 948:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 94b:	85 ff                	test   %edi,%edi
 94d:	0f 84 9d 00 00 00    	je     9f0 <malloc+0xc0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
<<<<<<< HEAD
 903:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 905:	8b 48 04             	mov    0x4(%eax),%ecx
 908:	39 f9                	cmp    %edi,%ecx
 90a:	73 64                	jae    970 <malloc+0x90>
  if(nu < 4096)
 90c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 911:	39 df                	cmp    %ebx,%edi
 913:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 916:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 91d:	eb 0a                	jmp    929 <malloc+0x49>
 91f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 920:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 922:	8b 48 04             	mov    0x4(%eax),%ecx
 925:	39 f9                	cmp    %edi,%ecx
 927:	73 47                	jae    970 <malloc+0x90>
=======
 953:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 955:	8b 4a 04             	mov    0x4(%edx),%ecx
 958:	39 f1                	cmp    %esi,%ecx
 95a:	73 6a                	jae    9c6 <malloc+0x96>
 95c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 961:	39 de                	cmp    %ebx,%esi
 963:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 966:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 96d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 970:	eb 17                	jmp    989 <malloc+0x59>
 972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 978:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 97a:	8b 48 04             	mov    0x4(%eax),%ecx
 97d:	39 f1                	cmp    %esi,%ecx
 97f:	73 4f                	jae    9d0 <malloc+0xa0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
<<<<<<< HEAD
 929:	89 c2                	mov    %eax,%edx
 92b:	3b 05 a8 0d 00 00    	cmp    0xda8,%eax
 931:	75 ed                	jne    920 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 933:	83 ec 0c             	sub    $0xc,%esp
 936:	56                   	push   %esi
 937:	e8 bf fc ff ff       	call   5fb <sbrk>
  if(p == (char*)-1)
 93c:	83 c4 10             	add    $0x10,%esp
 93f:	83 f8 ff             	cmp    $0xffffffff,%eax
 942:	74 1c                	je     960 <malloc+0x80>
  hp->s.size = nu;
 944:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 947:	83 ec 0c             	sub    $0xc,%esp
 94a:	83 c0 08             	add    $0x8,%eax
 94d:	50                   	push   %eax
 94e:	e8 fd fe ff ff       	call   850 <free>
  return freep;
 953:	8b 15 a8 0d 00 00    	mov    0xda8,%edx
      if((p = morecore(nunits)) == 0)
 959:	83 c4 10             	add    $0x10,%esp
 95c:	85 d2                	test   %edx,%edx
 95e:	75 c0                	jne    920 <malloc+0x40>
        return 0;
  }
}
 960:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 963:	31 c0                	xor    %eax,%eax
}
 965:	5b                   	pop    %ebx
 966:	5e                   	pop    %esi
 967:	5f                   	pop    %edi
 968:	5d                   	pop    %ebp
 969:	c3                   	ret
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 970:	39 cf                	cmp    %ecx,%edi
 972:	74 4c                	je     9c0 <malloc+0xe0>
        p->s.size -= nunits;
 974:	29 f9                	sub    %edi,%ecx
 976:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 979:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 97c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 97f:	89 15 a8 0d 00 00    	mov    %edx,0xda8
}
 985:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 988:	83 c0 08             	add    $0x8,%eax
}
 98b:	5b                   	pop    %ebx
 98c:	5e                   	pop    %esi
 98d:	5f                   	pop    %edi
 98e:	5d                   	pop    %ebp
 98f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 990:	c7 05 a8 0d 00 00 ac 	movl   $0xdac,0xda8
 997:	0d 00 00 
    base.s.size = 0;
 99a:	b8 ac 0d 00 00       	mov    $0xdac,%eax
    base.s.ptr = freep = prevp = &base;
 99f:	c7 05 ac 0d 00 00 ac 	movl   $0xdac,0xdac
 9a6:	0d 00 00 
    base.s.size = 0;
 9a9:	c7 05 b0 0d 00 00 00 	movl   $0x0,0xdb0
 9b0:	00 00 00 
    if(p->s.size >= nunits){
 9b3:	e9 54 ff ff ff       	jmp    90c <malloc+0x2c>
 9b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9bf:	00 
        prevp->s.ptr = p->s.ptr;
 9c0:	8b 08                	mov    (%eax),%ecx
 9c2:	89 0a                	mov    %ecx,(%edx)
 9c4:	eb b9                	jmp    97f <malloc+0x9f>
=======
 981:	8b 3d 14 0e 00 00    	mov    0xe14,%edi
 987:	89 c2                	mov    %eax,%edx
 989:	39 d7                	cmp    %edx,%edi
 98b:	75 eb                	jne    978 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 98d:	83 ec 0c             	sub    $0xc,%esp
 990:	ff 75 e4             	push   -0x1c(%ebp)
 993:	e8 83 fc ff ff       	call   61b <sbrk>
  if(p == (char*)-1)
 998:	83 c4 10             	add    $0x10,%esp
 99b:	83 f8 ff             	cmp    $0xffffffff,%eax
 99e:	74 1c                	je     9bc <malloc+0x8c>
  hp->s.size = nu;
 9a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 9a3:	83 ec 0c             	sub    $0xc,%esp
 9a6:	83 c0 08             	add    $0x8,%eax
 9a9:	50                   	push   %eax
 9aa:	e8 f1 fe ff ff       	call   8a0 <free>
  return freep;
 9af:	8b 15 14 0e 00 00    	mov    0xe14,%edx
      if((p = morecore(nunits)) == 0)
 9b5:	83 c4 10             	add    $0x10,%esp
 9b8:	85 d2                	test   %edx,%edx
 9ba:	75 bc                	jne    978 <malloc+0x48>
        return 0;
  }
}
 9bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9bf:	31 c0                	xor    %eax,%eax
}
 9c1:	5b                   	pop    %ebx
 9c2:	5e                   	pop    %esi
 9c3:	5f                   	pop    %edi
 9c4:	5d                   	pop    %ebp
 9c5:	c3                   	ret    
    if(p->s.size >= nunits){
 9c6:	89 d0                	mov    %edx,%eax
 9c8:	89 fa                	mov    %edi,%edx
 9ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9d0:	39 ce                	cmp    %ecx,%esi
 9d2:	74 4c                	je     a20 <malloc+0xf0>
        p->s.size -= nunits;
 9d4:	29 f1                	sub    %esi,%ecx
 9d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9dc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 9df:	89 15 14 0e 00 00    	mov    %edx,0xe14
}
 9e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9e8:	83 c0 08             	add    $0x8,%eax
}
 9eb:	5b                   	pop    %ebx
 9ec:	5e                   	pop    %esi
 9ed:	5f                   	pop    %edi
 9ee:	5d                   	pop    %ebp
 9ef:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 9f0:	c7 05 14 0e 00 00 18 	movl   $0xe18,0xe14
 9f7:	0e 00 00 
    base.s.size = 0;
 9fa:	bf 18 0e 00 00       	mov    $0xe18,%edi
    base.s.ptr = freep = prevp = &base;
 9ff:	c7 05 18 0e 00 00 18 	movl   $0xe18,0xe18
 a06:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a09:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 a0b:	c7 05 1c 0e 00 00 00 	movl   $0x0,0xe1c
 a12:	00 00 00 
    if(p->s.size >= nunits){
 a15:	e9 42 ff ff ff       	jmp    95c <malloc+0x2c>
 a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a20:	8b 08                	mov    (%eax),%ecx
 a22:	89 0a                	mov    %ecx,(%edx)
 a24:	eb b9                	jmp    9df <malloc+0xaf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
