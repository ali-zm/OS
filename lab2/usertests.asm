
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
<<<<<<< HEAD
      11:	68 16 4d 00 00       	push   $0x4d16
      16:	6a 01                	push   $0x1
      18:	e8 03 3a 00 00       	call   3a20 <printf>
=======
      11:	68 56 4d 00 00       	push   $0x4d56
      16:	6a 01                	push   $0x1
      18:	e8 23 3a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
<<<<<<< HEAD
      21:	68 2a 4d 00 00       	push   $0x4d2a
=======
      21:	68 6a 4d 00 00       	push   $0x4d6a
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      26:	e8 e8 38 00 00       	call   3913 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
<<<<<<< HEAD
      34:	68 9c 54 00 00       	push   $0x549c
      39:	6a 01                	push   $0x1
      3b:	e8 e0 39 00 00       	call   3a20 <printf>
=======
      34:	68 d4 54 00 00       	push   $0x54d4
      39:	6a 01                	push   $0x1
      3b:	e8 00 3a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
      40:	e8 8e 38 00 00       	call   38d3 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
<<<<<<< HEAD
      4c:	68 2a 4d 00 00       	push   $0x4d2a
=======
      4c:	68 6a 4d 00 00       	push   $0x4d6a
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      51:	e8 bd 38 00 00       	call   3913 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 9d 38 00 00       	call   38fb <close>

  argptest();
      5e:	e8 9d 35 00 00       	call   3600 <argptest>
  createdelete();
      63:	e8 c8 11 00 00       	call   1230 <createdelete>
  linkunlink();
      68:	e8 63 1a 00 00       	call   1ad0 <linkunlink>
  concreate();
      6d:	e8 5e 17 00 00       	call   17d0 <concreate>
  fourfiles();
      72:	e8 b9 0f 00 00       	call   1030 <fourfiles>
  sharedfd();
      77:	e8 f4 0d 00 00       	call   e70 <sharedfd>

  bigargtest();
      7c:	e8 1f 32 00 00       	call   32a0 <bigargtest>
  bigwrite();
      81:	e8 6a 23 00 00       	call   23f0 <bigwrite>
  bigargtest();
      86:	e8 15 32 00 00       	call   32a0 <bigargtest>
  bsstest();
      8b:	e8 a0 31 00 00       	call   3230 <bsstest>
  sbrktest();
      90:	e8 9b 2c 00 00       	call   2d30 <sbrktest>
  validatetest();
      95:	e8 e6 30 00 00       	call   3180 <validatetest>

  opentest();
      9a:	e8 61 03 00 00       	call   400 <opentest>
  writetest();
      9f:	e8 ec 03 00 00       	call   490 <writetest>
  writetest1();
      a4:	e8 c7 05 00 00       	call   670 <writetest1>
  createtest();
      a9:	e8 92 07 00 00       	call   840 <createtest>

  openiputtest();
      ae:	e8 4d 02 00 00       	call   300 <openiputtest>
  exitiputtest();
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
  iputtest();
      b8:	e8 63 00 00 00       	call   120 <iputtest>

  mem();
      bd:	e8 de 0c 00 00       	call   da0 <mem>
  pipe1();
      c2:	e8 59 09 00 00       	call   a20 <pipe1>
  preempt();
      c7:	e8 f4 0a 00 00       	call   bc0 <preempt>
  exitwait();
      cc:	e8 4f 0c 00 00       	call   d20 <exitwait>

  rmdot();
      d1:	e8 0a 27 00 00       	call   27e0 <rmdot>
  fourteen();
      d6:	e8 c5 25 00 00       	call   26a0 <fourteen>
  bigfile();
      db:	e8 f0 23 00 00       	call   24d0 <bigfile>
  subdir();
      e0:	e8 2b 1c 00 00       	call   1d10 <subdir>
  linktest();
      e5:	e8 d6 14 00 00       	call   15c0 <linktest>
  unlinkread();
      ea:	e8 41 13 00 00       	call   1430 <unlinkread>
  dirfile();
      ef:	e8 6c 28 00 00       	call   2960 <dirfile>
  iref();
      f4:	e8 67 2a 00 00       	call   2b60 <iref>
  forktest();
      f9:	e8 82 2b 00 00       	call   2c80 <forktest>
  bigdir(); // slow
      fe:	e8 dd 1a 00 00       	call   1be0 <bigdir>

  uio();
     103:	e8 88 34 00 00       	call   3590 <uio>

  exectest();
     108:	e8 c3 08 00 00       	call   9d0 <exectest>

  exit();
     10d:	e8 c1 37 00 00       	call   38d3 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
<<<<<<< HEAD
     126:	68 bc 3d 00 00       	push   $0x3dbc
     12b:	ff 35 08 5e 00 00    	push   0x5e08
     131:	e8 ea 38 00 00       	call   3a20 <printf>
  if(mkdir("iputdir") < 0){
     136:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
=======
     126:	68 fc 3d 00 00       	push   $0x3dfc
     12b:	ff 35 58 5e 00 00    	push   0x5e58
     131:	e8 0a 39 00 00       	call   3a40 <printf>
  if(mkdir("iputdir") < 0){
     136:	c7 04 24 8f 3d 00 00 	movl   $0x3d8f,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     13d:	e8 f9 37 00 00       	call   393b <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     14c:	68 4f 3d 00 00       	push   $0x3d4f
=======
     14c:	68 8f 3d 00 00       	push   $0x3d8f
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     151:	e8 ed 37 00 00       	call   3943 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     164:	68 4c 3d 00 00       	push   $0x3d4c
=======
     164:	68 8c 3d 00 00       	push   $0x3d8c
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     169:	e8 b5 37 00 00       	call   3923 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     178:	68 71 3d 00 00       	push   $0x3d71
=======
     178:	68 b1 3d 00 00       	push   $0x3db1
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     17d:	e8 c1 37 00 00       	call   3943 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     18c:	68 f4 3d 00 00       	push   $0x3df4
     191:	ff 35 08 5e 00 00    	push   0x5e08
     197:	e8 84 38 00 00       	call   3a20 <printf>
=======
     18c:	68 34 3e 00 00       	push   $0x3e34
     191:	ff 35 58 5e 00 00    	push   0x5e58
     197:	e8 a4 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave
     1a0:	c3                   	ret
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
<<<<<<< HEAD
     1a3:	68 28 3d 00 00       	push   $0x3d28
     1a8:	ff 35 08 5e 00 00    	push   0x5e08
     1ae:	e8 6d 38 00 00       	call   3a20 <printf>
=======
     1a3:	68 68 3d 00 00       	push   $0x3d68
     1a8:	ff 35 58 5e 00 00    	push   0x5e58
     1ae:	e8 8d 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     1b3:	e8 1b 37 00 00       	call   38d3 <exit>
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
<<<<<<< HEAD
     1ba:	68 73 3d 00 00       	push   $0x3d73
     1bf:	ff 35 08 5e 00 00    	push   0x5e08
     1c5:	e8 56 38 00 00       	call   3a20 <printf>
=======
     1ba:	68 b3 3d 00 00       	push   $0x3db3
     1bf:	ff 35 58 5e 00 00    	push   0x5e58
     1c5:	e8 76 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     1ca:	e8 04 37 00 00       	call   38d3 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
<<<<<<< HEAD
     1d1:	68 57 3d 00 00       	push   $0x3d57
     1d6:	ff 35 08 5e 00 00    	push   0x5e08
     1dc:	e8 3f 38 00 00       	call   3a20 <printf>
=======
     1d1:	68 97 3d 00 00       	push   $0x3d97
     1d6:	ff 35 58 5e 00 00    	push   0x5e58
     1dc:	e8 5f 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     1e1:	e8 ed 36 00 00       	call   38d3 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
<<<<<<< HEAD
     1e8:	68 36 3d 00 00       	push   $0x3d36
     1ed:	ff 35 08 5e 00 00    	push   0x5e08
     1f3:	e8 28 38 00 00       	call   3a20 <printf>
=======
     1e8:	68 76 3d 00 00       	push   $0x3d76
     1ed:	ff 35 58 5e 00 00    	push   0x5e58
     1f3:	e8 48 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     1f8:	e8 d6 36 00 00       	call   38d3 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
<<<<<<< HEAD
     206:	68 83 3d 00 00       	push   $0x3d83
     20b:	ff 35 08 5e 00 00    	push   0x5e08
     211:	e8 0a 38 00 00       	call   3a20 <printf>
=======
     206:	68 c3 3d 00 00       	push   $0x3dc3
     20b:	ff 35 58 5e 00 00    	push   0x5e58
     211:	e8 2a 38 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  pid = fork();
     216:	e8 b0 36 00 00       	call   38cb <fork>
  if(pid < 0){
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
  if(pid == 0){
     226:	75 50                	jne    278 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     228:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     22b:	68 4f 3d 00 00       	push   $0x3d4f
=======
     22b:	68 8f 3d 00 00       	push   $0x3d8f
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     230:	e8 06 37 00 00       	call   393b <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     240:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     243:	68 4f 3d 00 00       	push   $0x3d4f
=======
     243:	68 8f 3d 00 00       	push   $0x3d8f
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     248:	e8 f6 36 00 00       	call   3943 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     258:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     25b:	68 4c 3d 00 00       	push   $0x3d4c
=======
     25b:	68 8c 3d 00 00       	push   $0x3d8c
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     260:	e8 be 36 00 00       	call   3923 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
    exit();
     26c:	e8 62 36 00 00       	call   38d3 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     278:	e8 5e 36 00 00       	call   38db <wait>
  printf(stdout, "exitiput test ok\n");
     27d:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     280:	68 a6 3d 00 00       	push   $0x3da6
     285:	ff 35 08 5e 00 00    	push   0x5e08
     28b:	e8 90 37 00 00       	call   3a20 <printf>
=======
     280:	68 e6 3d 00 00       	push   $0x3de6
     285:	ff 35 58 5e 00 00    	push   0x5e58
     28b:	e8 b0 37 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave
     294:	c3                   	ret
     295:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     29b:	68 57 3d 00 00       	push   $0x3d57
     2a0:	ff 35 08 5e 00 00    	push   0x5e08
     2a6:	e8 75 37 00 00       	call   3a20 <printf>
=======
     29b:	68 97 3d 00 00       	push   $0x3d97
     2a0:	ff 35 58 5e 00 00    	push   0x5e58
     2a6:	e8 95 37 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     2ab:	e8 23 36 00 00       	call   38d3 <exit>
    printf(stdout, "fork failed\n");
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
<<<<<<< HEAD
     2b2:	68 69 4c 00 00       	push   $0x4c69
     2b7:	ff 35 08 5e 00 00    	push   0x5e08
     2bd:	e8 5e 37 00 00       	call   3a20 <printf>
=======
     2b2:	68 a9 4c 00 00       	push   $0x4ca9
     2b7:	ff 35 58 5e 00 00    	push   0x5e58
     2bd:	e8 7e 37 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     2c2:	e8 0c 36 00 00       	call   38d3 <exit>
      printf(stdout, "mkdir failed\n");
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
<<<<<<< HEAD
     2c9:	68 28 3d 00 00       	push   $0x3d28
     2ce:	ff 35 08 5e 00 00    	push   0x5e08
     2d4:	e8 47 37 00 00       	call   3a20 <printf>
=======
     2c9:	68 68 3d 00 00       	push   $0x3d68
     2ce:	ff 35 58 5e 00 00    	push   0x5e58
     2d4:	e8 67 37 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     2d9:	e8 f5 35 00 00       	call   38d3 <exit>
      printf(stdout, "child chdir failed\n");
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
<<<<<<< HEAD
     2e0:	68 92 3d 00 00       	push   $0x3d92
     2e5:	ff 35 08 5e 00 00    	push   0x5e08
     2eb:	e8 30 37 00 00       	call   3a20 <printf>
=======
     2e0:	68 d2 3d 00 00       	push   $0x3dd2
     2e5:	ff 35 58 5e 00 00    	push   0x5e58
     2eb:	e8 50 37 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     2f0:	e8 de 35 00 00       	call   38d3 <exit>
     2f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     2fc:	00 
     2fd:	8d 76 00             	lea    0x0(%esi),%esi

00000300 <openiputtest>:
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
<<<<<<< HEAD
     306:	68 b8 3d 00 00       	push   $0x3db8
     30b:	ff 35 08 5e 00 00    	push   0x5e08
     311:	e8 0a 37 00 00       	call   3a20 <printf>
  if(mkdir("oidir") < 0){
     316:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
=======
     306:	68 f8 3d 00 00       	push   $0x3df8
     30b:	ff 35 58 5e 00 00    	push   0x5e58
     311:	e8 2a 37 00 00       	call   3a40 <printf>
  if(mkdir("oidir") < 0){
     316:	c7 04 24 07 3e 00 00 	movl   $0x3e07,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     31d:	e8 19 36 00 00       	call   393b <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
  pid = fork();
     32d:	e8 99 35 00 00       	call   38cb <fork>
  if(pid < 0){
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
  if(pid == 0){
     336:	75 38                	jne    370 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
<<<<<<< HEAD
     33d:	68 c7 3d 00 00       	push   $0x3dc7
=======
     33d:	68 07 3e 00 00       	push   $0x3e07
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     342:	e8 cc 35 00 00       	call   3913 <open>
    if(fd >= 0){
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     34e:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     351:	68 50 4d 00 00       	push   $0x4d50
     356:	ff 35 08 5e 00 00    	push   0x5e08
     35c:	e8 bf 36 00 00       	call   3a20 <printf>
=======
     351:	68 8c 4d 00 00       	push   $0x4d8c
     356:	ff 35 58 5e 00 00    	push   0x5e58
     35c:	e8 df 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     361:	e8 6d 35 00 00       	call   38d3 <exit>
     366:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     36d:	00 
     36e:	66 90                	xchg   %ax,%ax
  sleep(1);
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 e9 35 00 00       	call   3963 <sleep>
  if(unlink("oidir") != 0){
<<<<<<< HEAD
     37a:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
=======
     37a:	c7 04 24 07 3e 00 00 	movl   $0x3e07,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     381:	e8 9d 35 00 00       	call   3923 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
  wait();
     38d:	e8 49 35 00 00       	call   38db <wait>
  printf(stdout, "openiput test ok\n");
     392:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     395:	68 f0 3d 00 00       	push   $0x3df0
     39a:	ff 35 08 5e 00 00    	push   0x5e08
     3a0:	e8 7b 36 00 00       	call   3a20 <printf>
=======
     395:	68 30 3e 00 00       	push   $0x3e30
     39a:	ff 35 58 5e 00 00    	push   0x5e58
     3a0:	e8 9b 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     3a5:	83 c4 10             	add    $0x10,%esp
     3a8:	c9                   	leave
     3a9:	c3                   	ret
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3b0:	e8 1e 35 00 00       	call   38d3 <exit>
    printf(stdout, "fork failed\n");
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
<<<<<<< HEAD
     3b7:	68 69 4c 00 00       	push   $0x4c69
     3bc:	ff 35 08 5e 00 00    	push   0x5e08
     3c2:	e8 59 36 00 00       	call   3a20 <printf>
=======
     3b7:	68 a9 4c 00 00       	push   $0x4ca9
     3bc:	ff 35 58 5e 00 00    	push   0x5e58
     3c2:	e8 79 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     3c7:	e8 07 35 00 00       	call   38d3 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
<<<<<<< HEAD
     3ce:	68 cd 3d 00 00       	push   $0x3dcd
     3d3:	ff 35 08 5e 00 00    	push   0x5e08
     3d9:	e8 42 36 00 00       	call   3a20 <printf>
=======
     3ce:	68 0d 3e 00 00       	push   $0x3e0d
     3d3:	ff 35 58 5e 00 00    	push   0x5e58
     3d9:	e8 62 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     3de:	e8 f0 34 00 00       	call   38d3 <exit>
    printf(stdout, "unlink failed\n");
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
<<<<<<< HEAD
     3e5:	68 e1 3d 00 00       	push   $0x3de1
     3ea:	ff 35 08 5e 00 00    	push   0x5e08
     3f0:	e8 2b 36 00 00       	call   3a20 <printf>
=======
     3e5:	68 21 3e 00 00       	push   $0x3e21
     3ea:	ff 35 58 5e 00 00    	push   0x5e58
     3f0:	e8 4b 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     3f5:	e8 d9 34 00 00       	call   38d3 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
<<<<<<< HEAD
     406:	68 02 3e 00 00       	push   $0x3e02
     40b:	ff 35 08 5e 00 00    	push   0x5e08
     411:	e8 0a 36 00 00       	call   3a20 <printf>
=======
     406:	68 42 3e 00 00       	push   $0x3e42
     40b:	ff 35 58 5e 00 00    	push   0x5e58
     411:	e8 2a 36 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  fd = open("echo", 0);
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
<<<<<<< HEAD
     41a:	68 0d 3e 00 00       	push   $0x3e0d
=======
     41a:	68 4d 3e 00 00       	push   $0x3e4d
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     41f:	e8 ef 34 00 00       	call   3913 <open>
  if(fd < 0){
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
  close(fd);
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 c7 34 00 00       	call   38fb <close>
  fd = open("doesnotexist", 0);
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
<<<<<<< HEAD
     438:	68 25 3e 00 00       	push   $0x3e25
=======
     438:	68 65 3e 00 00       	push   $0x3e65
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     43d:	e8 d1 34 00 00       	call   3913 <open>
  if(fd >= 0){
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
  printf(stdout, "open test ok\n");
     449:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     44c:	68 50 3e 00 00       	push   $0x3e50
     451:	ff 35 08 5e 00 00    	push   0x5e08
     457:	e8 c4 35 00 00       	call   3a20 <printf>
=======
     44c:	68 90 3e 00 00       	push   $0x3e90
     451:	ff 35 58 5e 00 00    	push   0x5e58
     457:	e8 e4 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave
     460:	c3                   	ret
    printf(stdout, "open echo failed!\n");
     461:	50                   	push   %eax
     462:	50                   	push   %eax
<<<<<<< HEAD
     463:	68 12 3e 00 00       	push   $0x3e12
     468:	ff 35 08 5e 00 00    	push   0x5e08
     46e:	e8 ad 35 00 00       	call   3a20 <printf>
=======
     463:	68 52 3e 00 00       	push   $0x3e52
     468:	ff 35 58 5e 00 00    	push   0x5e58
     46e:	e8 cd 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     473:	e8 5b 34 00 00       	call   38d3 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     478:	50                   	push   %eax
     479:	50                   	push   %eax
<<<<<<< HEAD
     47a:	68 32 3e 00 00       	push   $0x3e32
     47f:	ff 35 08 5e 00 00    	push   0x5e08
     485:	e8 96 35 00 00       	call   3a20 <printf>
=======
     47a:	68 72 3e 00 00       	push   $0x3e72
     47f:	ff 35 58 5e 00 00    	push   0x5e58
     485:	e8 b6 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     48a:	e8 44 34 00 00       	call   38d3 <exit>
     48f:	90                   	nop

00000490 <writetest>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     495:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     498:	68 5e 3e 00 00       	push   $0x3e5e
     49d:	ff 35 08 5e 00 00    	push   0x5e08
     4a3:	e8 78 35 00 00       	call   3a20 <printf>
=======
     498:	68 9e 3e 00 00       	push   $0x3e9e
     49d:	ff 35 58 5e 00 00    	push   0x5e58
     4a3:	e8 98 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  fd = open("small", O_CREATE|O_RDWR);
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
<<<<<<< HEAD
     4af:	68 6f 3e 00 00       	push   $0x3e6f
=======
     4af:	68 af 3e 00 00       	push   $0x3eaf
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     4b4:	e8 5a 34 00 00       	call   3913 <open>
  if(fd >= 0){
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4c9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
<<<<<<< HEAD
     4cb:	68 75 3e 00 00       	push   $0x3e75
     4d0:	ff 35 08 5e 00 00    	push   0x5e08
     4d6:	e8 45 35 00 00       	call   3a20 <printf>
=======
     4cb:	68 b5 3e 00 00       	push   $0x3eb5
     4d0:	ff 35 58 5e 00 00    	push   0x5e58
     4d6:	e8 65 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
<<<<<<< HEAD
     4e5:	68 ac 3e 00 00       	push   $0x3eac
=======
     4e5:	68 ec 3e 00 00       	push   $0x3eec
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     4ea:	56                   	push   %esi
     4eb:	e8 03 34 00 00       	call   38f3 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
<<<<<<< HEAD
     501:	68 b7 3e 00 00       	push   $0x3eb7
=======
     501:	68 f7 3e 00 00       	push   $0x3ef7
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     506:	56                   	push   %esi
     507:	e8 e7 33 00 00       	call   38f3 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
  for(i = 0; i < 100; i++){
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     520:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     523:	68 c2 3e 00 00       	push   $0x3ec2
     528:	ff 35 08 5e 00 00    	push   0x5e08
     52e:	e8 ed 34 00 00       	call   3a20 <printf>
=======
     523:	68 02 3f 00 00       	push   $0x3f02
     528:	ff 35 58 5e 00 00    	push   0x5e58
     52e:	e8 0d 35 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 c0 33 00 00       	call   38fb <close>
  fd = open("small", O_RDONLY);
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
<<<<<<< HEAD
     53f:	68 6f 3e 00 00       	push   $0x3e6f
=======
     53f:	68 af 3e 00 00       	push   $0x3eaf
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     544:	e8 ca 33 00 00       	call   3913 <open>
  if(fd >= 0){
     549:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     54c:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     556:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     559:	68 cd 3e 00 00       	push   $0x3ecd
     55e:	ff 35 08 5e 00 00    	push   0x5e08
     564:	e8 b7 34 00 00       	call   3a20 <printf>
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 40 85 00 00       	push   $0x8540
=======
     559:	68 0d 3f 00 00       	push   $0x3f0d
     55e:	ff 35 58 5e 00 00    	push   0x5e58
     564:	e8 d7 34 00 00       	call   3a40 <printf>
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 a0 85 00 00       	push   $0x85a0
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     576:	53                   	push   %ebx
     577:	e8 6f 33 00 00       	call   38eb <read>
  if(i == 2000){
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     58d:	68 01 3f 00 00       	push   $0x3f01
     592:	ff 35 08 5e 00 00    	push   0x5e08
     598:	e8 83 34 00 00       	call   3a20 <printf>
=======
     58d:	68 41 3f 00 00       	push   $0x3f41
     592:	ff 35 58 5e 00 00    	push   0x5e58
     598:	e8 a3 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 56 33 00 00       	call   38fb <close>
  if(unlink("small") < 0){
<<<<<<< HEAD
     5a5:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
=======
     5a5:	c7 04 24 af 3e 00 00 	movl   $0x3eaf,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     5ac:	e8 72 33 00 00       	call   3923 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     5bb:	68 29 3f 00 00       	push   $0x3f29
     5c0:	ff 35 08 5e 00 00    	push   0x5e08
     5c6:	e8 55 34 00 00       	call   3a20 <printf>
=======
     5bb:	68 69 3f 00 00       	push   $0x3f69
     5c0:	ff 35 58 5e 00 00    	push   0x5e58
     5c6:	e8 75 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret
      printf(stdout, "error: write aa %d new file failed\n", i);
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
<<<<<<< HEAD
     5d9:	68 74 4d 00 00       	push   $0x4d74
     5de:	ff 35 08 5e 00 00    	push   0x5e08
     5e4:	e8 37 34 00 00       	call   3a20 <printf>
=======
     5d9:	68 b0 4d 00 00       	push   $0x4db0
     5de:	ff 35 58 5e 00 00    	push   0x5e58
     5e4:	e8 57 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     5e9:	e8 e5 32 00 00       	call   38d3 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
<<<<<<< HEAD
     5f2:	68 98 4d 00 00       	push   $0x4d98
     5f7:	ff 35 08 5e 00 00    	push   0x5e08
     5fd:	e8 1e 34 00 00       	call   3a20 <printf>
=======
     5f2:	68 d4 4d 00 00       	push   $0x4dd4
     5f7:	ff 35 58 5e 00 00    	push   0x5e58
     5fd:	e8 3e 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     602:	e8 cc 32 00 00       	call   38d3 <exit>
    printf(stdout, "error: open small failed!\n");
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
<<<<<<< HEAD
     609:	68 e6 3e 00 00       	push   $0x3ee6
     60e:	ff 35 08 5e 00 00    	push   0x5e08
     614:	e8 07 34 00 00       	call   3a20 <printf>
=======
     609:	68 26 3f 00 00       	push   $0x3f26
     60e:	ff 35 58 5e 00 00    	push   0x5e58
     614:	e8 27 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     619:	e8 b5 32 00 00       	call   38d3 <exit>
    printf(stdout, "read failed\n");
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
<<<<<<< HEAD
     620:	68 2d 42 00 00       	push   $0x422d
     625:	ff 35 08 5e 00 00    	push   0x5e08
     62b:	e8 f0 33 00 00       	call   3a20 <printf>
=======
     620:	68 6d 42 00 00       	push   $0x426d
     625:	ff 35 58 5e 00 00    	push   0x5e58
     62b:	e8 10 34 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     630:	e8 9e 32 00 00       	call   38d3 <exit>
    printf(stdout, "unlink small failed\n");
     635:	50                   	push   %eax
     636:	50                   	push   %eax
<<<<<<< HEAD
     637:	68 14 3f 00 00       	push   $0x3f14
     63c:	ff 35 08 5e 00 00    	push   0x5e08
     642:	e8 d9 33 00 00       	call   3a20 <printf>
=======
     637:	68 54 3f 00 00       	push   $0x3f54
     63c:	ff 35 58 5e 00 00    	push   0x5e58
     642:	e8 f9 33 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     647:	e8 87 32 00 00       	call   38d3 <exit>
    printf(stdout, "error: creat small failed!\n");
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
<<<<<<< HEAD
     64e:	68 90 3e 00 00       	push   $0x3e90
     653:	ff 35 08 5e 00 00    	push   0x5e08
     659:	e8 c2 33 00 00       	call   3a20 <printf>
=======
     64e:	68 d0 3e 00 00       	push   $0x3ed0
     653:	ff 35 58 5e 00 00    	push   0x5e58
     659:	e8 e2 33 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     65e:	e8 70 32 00 00       	call   38d3 <exit>
     663:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     66a:	00 
     66b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000670 <writetest1>:
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     675:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     678:	68 3d 3f 00 00       	push   $0x3f3d
     67d:	ff 35 08 5e 00 00    	push   0x5e08
     683:	e8 98 33 00 00       	call   3a20 <printf>
=======
     678:	68 7d 3f 00 00       	push   $0x3f7d
     67d:	ff 35 58 5e 00 00    	push   0x5e58
     683:	e8 b8 33 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  fd = open("big", O_CREATE|O_RDWR);
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
<<<<<<< HEAD
     68f:	68 b7 3f 00 00       	push   $0x3fb7
=======
     68f:	68 f7 3f 00 00       	push   $0x3ff7
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     694:	e8 7a 32 00 00       	call   3913 <open>
  if(fd < 0){
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6af:	00 
    if(write(fd, buf, 512) != 512){
     6b0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
<<<<<<< HEAD
     6b3:	89 1d 40 85 00 00    	mov    %ebx,0x8540
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 40 85 00 00       	push   $0x8540
=======
     6b3:	89 1d a0 85 00 00    	mov    %ebx,0x85a0
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 a0 85 00 00       	push   $0x85a0
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     6c3:	56                   	push   %esi
     6c4:	e8 2a 32 00 00       	call   38f3 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
  close(fd);
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 10 32 00 00       	call   38fb <close>
  fd = open("big", O_RDONLY);
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
<<<<<<< HEAD
     6ef:	68 b7 3f 00 00       	push   $0x3fb7
=======
     6ef:	68 f7 3f 00 00       	push   $0x3ff7
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     6f4:	e8 1a 32 00 00       	call   3913 <open>
  if(fd < 0){
     6f9:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     6fc:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
  n = 0;
     706:	31 f6                	xor    %esi,%esi
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
    if(((int*)buf)[0] != n){
<<<<<<< HEAD
     71b:	a1 40 85 00 00       	mov    0x8540,%eax
=======
     71b:	a1 a0 85 00 00       	mov    0x85a0,%eax
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     720:	39 f0                	cmp    %esi,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
    n++;
     724:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
<<<<<<< HEAD
     72f:	68 40 85 00 00       	push   $0x8540
=======
     72f:	68 a0 85 00 00       	push   $0x85a0
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     734:	53                   	push   %ebx
     735:	e8 b1 31 00 00       	call   38eb <read>
    if(i == 0){
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     741:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
  close(fd);
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	53                   	push   %ebx
     751:	e8 a5 31 00 00       	call   38fb <close>
  if(unlink("big") < 0){
<<<<<<< HEAD
     756:	c7 04 24 b7 3f 00 00 	movl   $0x3fb7,(%esp)
=======
     756:	c7 04 24 f7 3f 00 00 	movl   $0x3ff7,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     75d:	e8 c1 31 00 00       	call   3923 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     76d:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     770:	68 de 3f 00 00       	push   $0x3fde
     775:	ff 35 08 5e 00 00    	push   0x5e08
     77b:	e8 a0 32 00 00       	call   3a20 <printf>
=======
     770:	68 1e 40 00 00       	push   $0x401e
     775:	ff 35 58 5e 00 00    	push   0x5e58
     77b:	e8 c0 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret
      printf(stdout, "error: write big file failed\n", i);
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
<<<<<<< HEAD
     78e:	68 67 3f 00 00       	push   $0x3f67
     793:	ff 35 08 5e 00 00    	push   0x5e08
     799:	e8 82 32 00 00       	call   3a20 <printf>
=======
     78e:	68 a7 3f 00 00       	push   $0x3fa7
     793:	ff 35 58 5e 00 00    	push   0x5e58
     799:	e8 a2 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     79e:	e8 30 31 00 00       	call   38d3 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7a3:	50                   	push   %eax
     7a4:	56                   	push   %esi
<<<<<<< HEAD
     7a5:	68 bc 4d 00 00       	push   $0x4dbc
     7aa:	ff 35 08 5e 00 00    	push   0x5e08
     7b0:	e8 6b 32 00 00       	call   3a20 <printf>
=======
     7a5:	68 f8 4d 00 00       	push   $0x4df8
     7aa:	ff 35 58 5e 00 00    	push   0x5e58
     7b0:	e8 8b 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     7b5:	e8 19 31 00 00       	call   38d3 <exit>
      printf(stdout, "read failed %d\n", i);
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
<<<<<<< HEAD
     7be:	68 bb 3f 00 00       	push   $0x3fbb
     7c3:	ff 35 08 5e 00 00    	push   0x5e08
     7c9:	e8 52 32 00 00       	call   3a20 <printf>
=======
     7be:	68 fb 3f 00 00       	push   $0x3ffb
     7c3:	ff 35 58 5e 00 00    	push   0x5e58
     7c9:	e8 72 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     7ce:	e8 00 31 00 00       	call   38d3 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
<<<<<<< HEAD
     7d9:	68 9e 3f 00 00       	push   $0x3f9e
     7de:	ff 35 08 5e 00 00    	push   0x5e08
     7e4:	e8 37 32 00 00       	call   3a20 <printf>
=======
     7d9:	68 de 3f 00 00       	push   $0x3fde
     7de:	ff 35 58 5e 00 00    	push   0x5e58
     7e4:	e8 57 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
     7e9:	e8 e5 30 00 00       	call   38d3 <exit>
    printf(stdout, "error: open big failed!\n");
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
<<<<<<< HEAD
     7f0:	68 85 3f 00 00       	push   $0x3f85
     7f5:	ff 35 08 5e 00 00    	push   0x5e08
     7fb:	e8 20 32 00 00       	call   3a20 <printf>
=======
     7f0:	68 c5 3f 00 00       	push   $0x3fc5
     7f5:	ff 35 58 5e 00 00    	push   0x5e58
     7fb:	e8 40 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     800:	e8 ce 30 00 00       	call   38d3 <exit>
    printf(stdout, "error: creat big failed!\n");
     805:	50                   	push   %eax
     806:	50                   	push   %eax
<<<<<<< HEAD
     807:	68 4d 3f 00 00       	push   $0x3f4d
     80c:	ff 35 08 5e 00 00    	push   0x5e08
     812:	e8 09 32 00 00       	call   3a20 <printf>
=======
     807:	68 8d 3f 00 00       	push   $0x3f8d
     80c:	ff 35 58 5e 00 00    	push   0x5e58
     812:	e8 29 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     817:	e8 b7 30 00 00       	call   38d3 <exit>
    printf(stdout, "unlink big failed\n");
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
<<<<<<< HEAD
     81e:	68 cb 3f 00 00       	push   $0x3fcb
     823:	ff 35 08 5e 00 00    	push   0x5e08
     829:	e8 f2 31 00 00       	call   3a20 <printf>
=======
     81e:	68 0b 40 00 00       	push   $0x400b
     823:	ff 35 58 5e 00 00    	push   0x5e58
     829:	e8 12 32 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     82e:	e8 a0 30 00 00       	call   38d3 <exit>
     833:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     83a:	00 
     83b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000840 <createtest>:
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
  name[2] = '\0';
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     849:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
<<<<<<< HEAD
     84c:	68 dc 4d 00 00       	push   $0x4ddc
     851:	ff 35 08 5e 00 00    	push   0x5e08
     857:	e8 c4 31 00 00       	call   3a20 <printf>
  name[0] = 'a';
     85c:	c6 05 30 85 00 00 61 	movb   $0x61,0x8530
  name[2] = '\0';
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 32 85 00 00 00 	movb   $0x0,0x8532
=======
     84c:	68 18 4e 00 00       	push   $0x4e18
     851:	ff 35 58 5e 00 00    	push   0x5e58
     857:	e8 e4 31 00 00       	call   3a40 <printf>
  name[0] = 'a';
     85c:	c6 05 90 85 00 00 61 	movb   $0x61,0x8590
  name[2] = '\0';
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 92 85 00 00 00 	movb   $0x0,0x8592
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 52; i++){
     86d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     870:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
<<<<<<< HEAD
     873:	88 1d 31 85 00 00    	mov    %bl,0x8531
=======
     873:	88 1d 91 85 00 00    	mov    %bl,0x8591
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 52; i++){
     879:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     87c:	68 02 02 00 00       	push   $0x202
<<<<<<< HEAD
     881:	68 30 85 00 00       	push   $0x8530
=======
     881:	68 90 85 00 00       	push   $0x8590
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     886:	e8 88 30 00 00       	call   3913 <open>
    close(fd);
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 68 30 00 00       	call   38fb <close>
  for(i = 0; i < 52; i++){
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
  name[0] = 'a';
<<<<<<< HEAD
     89b:	c6 05 30 85 00 00 61 	movb   $0x61,0x8530
  name[2] = '\0';
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 32 85 00 00 00 	movb   $0x0,0x8532
=======
     89b:	c6 05 90 85 00 00 61 	movb   $0x61,0x8590
  name[2] = '\0';
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 92 85 00 00 00 	movb   $0x0,0x8592
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 52; i++){
     8ae:	66 90                	xchg   %ax,%ax
    unlink(name);
     8b0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
<<<<<<< HEAD
     8b3:	88 1d 31 85 00 00    	mov    %bl,0x8531
  for(i = 0; i < 52; i++){
     8b9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8bc:	68 30 85 00 00       	push   $0x8530
=======
     8b3:	88 1d 91 85 00 00    	mov    %bl,0x8591
  for(i = 0; i < 52; i++){
     8b9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8bc:	68 90 85 00 00       	push   $0x8590
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     8c1:	e8 5d 30 00 00       	call   3923 <unlink>
  for(i = 0; i < 52; i++){
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ce:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     8d1:	68 08 4e 00 00       	push   $0x4e08
     8d6:	ff 35 08 5e 00 00    	push   0x5e08
     8dc:	e8 3f 31 00 00       	call   3a20 <printf>
=======
     8d1:	68 40 4e 00 00       	push   $0x4e40
     8d6:	ff 35 58 5e 00 00    	push   0x5e58
     8dc:	e8 5f 31 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     8e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	c9                   	leave
     8e8:	c3                   	ret
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
<<<<<<< HEAD
     8f6:	68 ec 3f 00 00       	push   $0x3fec
     8fb:	ff 35 08 5e 00 00    	push   0x5e08
     901:	e8 1a 31 00 00       	call   3a20 <printf>
  if(mkdir("dir0") < 0){
     906:	c7 04 24 f8 3f 00 00 	movl   $0x3ff8,(%esp)
=======
     8f6:	68 2c 40 00 00       	push   $0x402c
     8fb:	ff 35 58 5e 00 00    	push   0x5e58
     901:	e8 3a 31 00 00       	call   3a40 <printf>
  if(mkdir("dir0") < 0){
     906:	c7 04 24 38 40 00 00 	movl   $0x4038,(%esp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     90d:	e8 29 30 00 00       	call   393b <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
  if(chdir("dir0") < 0){
     919:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     91c:	68 f8 3f 00 00       	push   $0x3ff8
=======
     91c:	68 38 40 00 00       	push   $0x4038
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     921:	e8 1d 30 00 00       	call   3943 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
  if(chdir("..") < 0){
     931:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     934:	68 9d 45 00 00       	push   $0x459d
=======
     934:	68 dd 45 00 00       	push   $0x45dd
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     939:	e8 05 30 00 00       	call   3943 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     945:	83 ec 0c             	sub    $0xc,%esp
<<<<<<< HEAD
     948:	68 f8 3f 00 00       	push   $0x3ff8
=======
     948:	68 38 40 00 00       	push   $0x4038
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     94d:	e8 d1 2f 00 00       	call   3923 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     959:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
     95c:	68 35 40 00 00       	push   $0x4035
     961:	ff 35 08 5e 00 00    	push   0x5e08
     967:	e8 b4 30 00 00       	call   3a20 <printf>
=======
     95c:	68 75 40 00 00       	push   $0x4075
     961:	ff 35 58 5e 00 00    	push   0x5e58
     967:	e8 d4 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave
     970:	c3                   	ret
    printf(stdout, "mkdir failed\n");
     971:	50                   	push   %eax
     972:	50                   	push   %eax
<<<<<<< HEAD
     973:	68 28 3d 00 00       	push   $0x3d28
     978:	ff 35 08 5e 00 00    	push   0x5e08
     97e:	e8 9d 30 00 00       	call   3a20 <printf>
=======
     973:	68 68 3d 00 00       	push   $0x3d68
     978:	ff 35 58 5e 00 00    	push   0x5e58
     97e:	e8 bd 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     983:	e8 4b 2f 00 00       	call   38d3 <exit>
    printf(stdout, "unlink dir0 failed\n");
     988:	50                   	push   %eax
     989:	50                   	push   %eax
<<<<<<< HEAD
     98a:	68 21 40 00 00       	push   $0x4021
     98f:	ff 35 08 5e 00 00    	push   0x5e08
     995:	e8 86 30 00 00       	call   3a20 <printf>
=======
     98a:	68 61 40 00 00       	push   $0x4061
     98f:	ff 35 58 5e 00 00    	push   0x5e58
     995:	e8 a6 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     99a:	e8 34 2f 00 00       	call   38d3 <exit>
    printf(stdout, "chdir .. failed\n");
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
<<<<<<< HEAD
     9a1:	68 10 40 00 00       	push   $0x4010
     9a6:	ff 35 08 5e 00 00    	push   0x5e08
     9ac:	e8 6f 30 00 00       	call   3a20 <printf>
=======
     9a1:	68 50 40 00 00       	push   $0x4050
     9a6:	ff 35 58 5e 00 00    	push   0x5e58
     9ac:	e8 8f 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     9b1:	e8 1d 2f 00 00       	call   38d3 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
<<<<<<< HEAD
     9b8:	68 fd 3f 00 00       	push   $0x3ffd
     9bd:	ff 35 08 5e 00 00    	push   0x5e08
     9c3:	e8 58 30 00 00       	call   3a20 <printf>
=======
     9b8:	68 3d 40 00 00       	push   $0x403d
     9bd:	ff 35 58 5e 00 00    	push   0x5e58
     9c3:	e8 78 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     9c8:	e8 06 2f 00 00       	call   38d3 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
<<<<<<< HEAD
     9d6:	68 44 40 00 00       	push   $0x4044
     9db:	ff 35 08 5e 00 00    	push   0x5e08
     9e1:	e8 3a 30 00 00       	call   3a20 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 0c 5e 00 00       	push   $0x5e0c
     9ed:	68 0d 3e 00 00       	push   $0x3e0d
=======
     9d6:	68 84 40 00 00       	push   $0x4084
     9db:	ff 35 58 5e 00 00    	push   0x5e58
     9e1:	e8 5a 30 00 00       	call   3a40 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 5c 5e 00 00       	push   $0x5e5c
     9ed:	68 4d 3e 00 00       	push   $0x3e4d
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
     9f2:	e8 14 2f 00 00       	call   390b <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
}
     9fe:	c9                   	leave
     9ff:	c3                   	ret
    printf(stdout, "exec echo failed\n");
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
<<<<<<< HEAD
     a02:	68 4f 40 00 00       	push   $0x404f
     a07:	ff 35 08 5e 00 00    	push   0x5e08
     a0d:	e8 0e 30 00 00       	call   3a20 <printf>
=======
     a02:	68 8f 40 00 00       	push   $0x408f
     a07:	ff 35 58 5e 00 00    	push   0x5e58
     a0d:	e8 2e 30 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     a12:	e8 bc 2e 00 00       	call   38d3 <exit>
     a17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a1e:	00 
     a1f:	90                   	nop

00000a20 <pipe1>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
  if(pipe(fds) != 0){
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a28:	53                   	push   %ebx
     a29:	83 ec 28             	sub    $0x28,%esp
  if(pipe(fds) != 0){
     a2c:	50                   	push   %eax
     a2d:	e8 b1 2e 00 00       	call   38e3 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 41 01 00 00    	jne    b7e <pipe1+0x15e>
     a3d:	89 c6                	mov    %eax,%esi
  pid = fork();
     a3f:	e8 87 2e 00 00       	call   38cb <fork>
  if(pid == 0){
     a44:	85 c0                	test   %eax,%eax
     a46:	0f 84 92 00 00 00    	je     ade <pipe1+0xbe>
  } else if(pid > 0){
     a4c:	0f 8e 3f 01 00 00    	jle    b91 <pipe1+0x171>
    close(fds[1]);
     a52:	83 ec 0c             	sub    $0xc,%esp
     a55:	ff 75 e4             	push   -0x1c(%ebp)
    total = 0;
     a58:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a5a:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a5f:	e8 97 2e 00 00       	call   38fb <close>
    while((n = read(fds[0], buf, cc)) > 0){
<<<<<<< HEAD
     a64:	83 c4 10             	add    $0x10,%esp
     a67:	83 ec 04             	sub    $0x4,%esp
     a6a:	57                   	push   %edi
     a6b:	68 40 85 00 00       	push   $0x8540
     a70:	ff 75 e0             	push   -0x20(%ebp)
     a73:	e8 73 2e 00 00       	call   38eb <read>
     a78:	83 c4 10             	add    $0x10,%esp
     a7b:	89 c1                	mov    %eax,%ecx
     a7d:	85 c0                	test   %eax,%eax
     a7f:	0f 8e b8 00 00 00    	jle    b3d <pipe1+0x11d>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a85:	89 f0                	mov    %esi,%eax
     a87:	32 05 40 85 00 00    	xor    0x8540,%al
     a8d:	0f b6 c0             	movzbl %al,%eax
     a90:	85 c0                	test   %eax,%eax
     a92:	75 30                	jne    ac4 <pipe1+0xa4>
     a94:	83 c6 01             	add    $0x1,%esi
     a97:	eb 0f                	jmp    aa8 <pipe1+0x88>
     a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aa0:	38 90 40 85 00 00    	cmp    %dl,0x8540(%eax)
     aa6:	75 1c                	jne    ac4 <pipe1+0xa4>
     aa8:	8d 14 06             	lea    (%esi,%eax,1),%edx
=======
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	56                   	push   %esi
     a70:	68 a0 85 00 00       	push   $0x85a0
     a75:	ff 75 e0             	push   -0x20(%ebp)
     a78:	e8 6e 2e 00 00       	call   38eb <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 c7                	mov    %eax,%edi
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 8e a3 00 00 00    	jle    b2d <pipe1+0x10d>
     a8a:	8d 0c 1f             	lea    (%edi,%ebx,1),%ecx
      for(i = 0; i < n; i++){
     a8d:	31 c0                	xor    %eax,%eax
     a8f:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a90:	89 da                	mov    %ebx,%edx
     a92:	83 c3 01             	add    $0x1,%ebx
     a95:	38 90 a0 85 00 00    	cmp    %dl,0x85a0(%eax)
     a9b:	75 18                	jne    ab5 <pipe1+0x95>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      for(i = 0; i < n; i++){
     aab:	83 c0 01             	add    $0x1,%eax
     aae:	39 c1                	cmp    %eax,%ecx
     ab0:	75 ee                	jne    aa0 <pipe1+0x80>
      cc = cc * 2;
     ab2:	01 ff                	add    %edi,%edi
      if(cc > sizeof(buf))
     ab4:	b8 00 20 00 00       	mov    $0x2000,%eax
      total += n;
     ab9:	01 cb                	add    %ecx,%ebx
      if(cc > sizeof(buf))
     abb:	89 d6                	mov    %edx,%esi
     abd:	39 c7                	cmp    %eax,%edi
     abf:	0f 4f f8             	cmovg  %eax,%edi
     ac2:	eb a3                	jmp    a67 <pipe1+0x47>
          printf(1, "pipe1 oops 2\n");
<<<<<<< HEAD
     ac4:	83 ec 08             	sub    $0x8,%esp
     ac7:	68 7e 40 00 00       	push   $0x407e
     acc:	6a 01                	push   $0x1
     ace:	e8 4d 2f 00 00       	call   3a20 <printf>
     ad3:	83 c4 10             	add    $0x10,%esp
=======
     ab5:	83 ec 08             	sub    $0x8,%esp
     ab8:	68 be 40 00 00       	push   $0x40be
     abd:	6a 01                	push   $0x1
     abf:	e8 7c 2f 00 00       	call   3a40 <printf>
     ac4:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     ad6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ad9:	5b                   	pop    %ebx
     ada:	5e                   	pop    %esi
     adb:	5f                   	pop    %edi
     adc:	5d                   	pop    %ebp
     add:	c3                   	ret
    close(fds[0]);
     ade:	83 ec 0c             	sub    $0xc,%esp
     ae1:	ff 75 e0             	push   -0x20(%ebp)
  seq = 0;
     ae4:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     ae6:	e8 10 2e 00 00       	call   38fb <close>
     aeb:	83 c4 10             	add    $0x10,%esp
     aee:	66 90                	xchg   %ax,%ax
      for(i = 0; i < 1033; i++)
     af0:	31 c0                	xor    %eax,%eax
     af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        buf[i] = seq++;
     af8:	8d 14 03             	lea    (%ebx,%eax,1),%edx
      for(i = 0; i < 1033; i++)
     afb:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
<<<<<<< HEAD
     afe:	88 90 3f 85 00 00    	mov    %dl,0x853f(%eax)
=======
     aee:	88 90 9f 85 00 00    	mov    %dl,0x859f(%eax)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      for(i = 0; i < 1033; i++)
     b04:	3d 09 04 00 00       	cmp    $0x409,%eax
     b09:	75 ed                	jne    af8 <pipe1+0xd8>
      if(write(fds[1], buf, 1033) != 1033){
<<<<<<< HEAD
     b0b:	83 ec 04             	sub    $0x4,%esp
     b0e:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b14:	68 09 04 00 00       	push   $0x409
     b19:	68 40 85 00 00       	push   $0x8540
     b1e:	ff 75 e4             	push   -0x1c(%ebp)
     b21:	e8 cd 2d 00 00       	call   38f3 <write>
     b26:	83 c4 10             	add    $0x10,%esp
     b29:	3d 09 04 00 00       	cmp    $0x409,%eax
     b2e:	75 74                	jne    ba4 <pipe1+0x184>
=======
     afb:	83 ec 04             	sub    $0x4,%esp
        buf[i] = seq++;
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 a0 85 00 00       	push   $0x85a0
     b0e:	ff 75 e4             	push   -0x1c(%ebp)
     b11:	e8 dd 2d 00 00       	call   38f3 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    for(n = 0; n < 5; n++){
     b30:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b36:	75 b8                	jne    af0 <pipe1+0xd0>
    exit();
     b38:	e8 96 2d 00 00       	call   38d3 <exit>
    if(total != 5 * 1033){
     b3d:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b43:	75 26                	jne    b6b <pipe1+0x14b>
    close(fds[0]);
     b45:	83 ec 0c             	sub    $0xc,%esp
     b48:	ff 75 e0             	push   -0x20(%ebp)
     b4b:	e8 ab 2d 00 00       	call   38fb <close>
    wait();
     b50:	e8 86 2d 00 00       	call   38db <wait>
  printf(1, "pipe1 ok\n");
<<<<<<< HEAD
     b55:	5a                   	pop    %edx
     b56:	59                   	pop    %ecx
     b57:	68 a3 40 00 00       	push   $0x40a3
     b5c:	6a 01                	push   $0x1
     b5e:	e8 bd 2e 00 00       	call   3a20 <printf>
     b63:	83 c4 10             	add    $0x10,%esp
     b66:	e9 6b ff ff ff       	jmp    ad6 <pipe1+0xb6>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b6b:	56                   	push   %esi
     b6c:	53                   	push   %ebx
     b6d:	68 8c 40 00 00       	push   $0x408c
     b72:	6a 01                	push   $0x1
     b74:	e8 a7 2e 00 00       	call   3a20 <printf>
=======
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 e3 40 00 00       	push   $0x40e3
     b4d:	6a 01                	push   $0x1
     b4f:	e8 ec 2e 00 00       	call   3a40 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6b ff ff ff       	jmp    ac7 <pipe1+0xa7>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	push   -0x2c(%ebp)
     b60:	68 cc 40 00 00       	push   $0x40cc
     b65:	6a 01                	push   $0x1
     b67:	e8 d4 2e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
     b79:	e8 55 2d 00 00       	call   38d3 <exit>
    printf(1, "pipe() failed\n");
<<<<<<< HEAD
     b7e:	50                   	push   %eax
     b7f:	50                   	push   %eax
     b80:	68 61 40 00 00       	push   $0x4061
     b85:	6a 01                	push   $0x1
     b87:	e8 94 2e 00 00       	call   3a20 <printf>
=======
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 a1 40 00 00       	push   $0x40a1
     b78:	6a 01                	push   $0x1
     b7a:	e8 c1 2e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     b8c:	e8 42 2d 00 00       	call   38d3 <exit>
    printf(1, "fork() failed\n");
<<<<<<< HEAD
     b91:	50                   	push   %eax
     b92:	50                   	push   %eax
     b93:	68 ad 40 00 00       	push   $0x40ad
     b98:	6a 01                	push   $0x1
     b9a:	e8 81 2e 00 00       	call   3a20 <printf>
=======
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 ed 40 00 00       	push   $0x40ed
     b8b:	6a 01                	push   $0x1
     b8d:	e8 ae 2e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     b9f:	e8 2f 2d 00 00       	call   38d3 <exit>
        printf(1, "pipe1 oops 1\n");
<<<<<<< HEAD
     ba4:	57                   	push   %edi
     ba5:	57                   	push   %edi
     ba6:	68 70 40 00 00       	push   $0x4070
     bab:	6a 01                	push   $0x1
     bad:	e8 6e 2e 00 00       	call   3a20 <printf>
=======
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 b0 40 00 00       	push   $0x40b0
     b9e:	6a 01                	push   $0x1
     ba0:	e8 9b 2e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
     bb2:	e8 1c 2d 00 00       	call   38d3 <exit>
     bb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bbe:	00 
     bbf:	90                   	nop

00000bc0 <preempt>:
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	57                   	push   %edi
     bc4:	56                   	push   %esi
     bc5:	53                   	push   %ebx
     bc6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
<<<<<<< HEAD
     bc9:	68 bc 40 00 00       	push   $0x40bc
     bce:	6a 01                	push   $0x1
     bd0:	e8 4b 2e 00 00       	call   3a20 <printf>
=======
     bb9:	68 fc 40 00 00       	push   $0x40fc
     bbe:	6a 01                	push   $0x1
     bc0:	e8 7b 2e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  pid1 = fork();
     bd5:	e8 f1 2c 00 00       	call   38cb <fork>
  if(pid1 == 0)
     bda:	83 c4 10             	add    $0x10,%esp
     bdd:	85 c0                	test   %eax,%eax
     bdf:	75 07                	jne    be8 <preempt+0x28>
    for(;;)
     be1:	eb fe                	jmp    be1 <preempt+0x21>
     be3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     be8:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     bea:	e8 dc 2c 00 00       	call   38cb <fork>
     bef:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bf1:	85 c0                	test   %eax,%eax
     bf3:	75 0b                	jne    c00 <preempt+0x40>
    for(;;)
     bf5:	eb fe                	jmp    bf5 <preempt+0x35>
     bf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bfe:	00 
     bff:	90                   	nop
  pipe(pfds);
     c00:	83 ec 0c             	sub    $0xc,%esp
     c03:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c06:	50                   	push   %eax
     c07:	e8 d7 2c 00 00       	call   38e3 <pipe>
  pid3 = fork();
     c0c:	e8 ba 2c 00 00       	call   38cb <fork>
  if(pid3 == 0){
     c11:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     c14:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     c16:	85 c0                	test   %eax,%eax
     c18:	75 3e                	jne    c58 <preempt+0x98>
    close(pfds[0]);
     c1a:	83 ec 0c             	sub    $0xc,%esp
     c1d:	ff 75 e0             	push   -0x20(%ebp)
     c20:	e8 d6 2c 00 00       	call   38fb <close>
    if(write(pfds[1], "x", 1) != 1)
<<<<<<< HEAD
     c25:	83 c4 0c             	add    $0xc,%esp
     c28:	6a 01                	push   $0x1
     c2a:	68 81 46 00 00       	push   $0x4681
     c2f:	ff 75 e4             	push   -0x1c(%ebp)
     c32:	e8 bc 2c 00 00       	call   38f3 <write>
     c37:	83 c4 10             	add    $0x10,%esp
     c3a:	83 f8 01             	cmp    $0x1,%eax
     c3d:	0f 85 b8 00 00 00    	jne    cfb <preempt+0x13b>
=======
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 c1 46 00 00       	push   $0x46c1
     c1f:	ff 75 e4             	push   -0x1c(%ebp)
     c22:	e8 cc 2c 00 00       	call   38f3 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 b8 00 00 00    	jne    ceb <preempt+0x13b>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    close(pfds[1]);
     c43:	83 ec 0c             	sub    $0xc,%esp
     c46:	ff 75 e4             	push   -0x1c(%ebp)
     c49:	e8 ad 2c 00 00       	call   38fb <close>
     c4e:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c51:	eb fe                	jmp    c51 <preempt+0x91>
     c53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  close(pfds[1]);
     c58:	83 ec 0c             	sub    $0xc,%esp
     c5b:	ff 75 e4             	push   -0x1c(%ebp)
     c5e:	e8 98 2c 00 00       	call   38fb <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
<<<<<<< HEAD
     c63:	83 c4 0c             	add    $0xc,%esp
     c66:	68 00 20 00 00       	push   $0x2000
     c6b:	68 40 85 00 00       	push   $0x8540
     c70:	ff 75 e0             	push   -0x20(%ebp)
     c73:	e8 73 2c 00 00       	call   38eb <read>
     c78:	83 c4 10             	add    $0x10,%esp
     c7b:	83 f8 01             	cmp    $0x1,%eax
     c7e:	75 67                	jne    ce7 <preempt+0x127>
=======
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 a0 85 00 00       	push   $0x85a0
     c60:	ff 75 e0             	push   -0x20(%ebp)
     c63:	e8 83 2c 00 00       	call   38eb <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 67                	jne    cd7 <preempt+0x127>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(pfds[0]);
     c80:	83 ec 0c             	sub    $0xc,%esp
     c83:	ff 75 e0             	push   -0x20(%ebp)
     c86:	e8 70 2c 00 00       	call   38fb <close>
  printf(1, "kill... ");
<<<<<<< HEAD
     c8b:	58                   	pop    %eax
     c8c:	5a                   	pop    %edx
     c8d:	68 ed 40 00 00       	push   $0x40ed
     c92:	6a 01                	push   $0x1
     c94:	e8 87 2d 00 00       	call   3a20 <printf>
=======
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 2d 41 00 00       	push   $0x412d
     c82:	6a 01                	push   $0x1
     c84:	e8 b7 2d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  kill(pid1);
     c99:	89 1c 24             	mov    %ebx,(%esp)
     c9c:	e8 62 2c 00 00       	call   3903 <kill>
  kill(pid2);
     ca1:	89 34 24             	mov    %esi,(%esp)
     ca4:	e8 5a 2c 00 00       	call   3903 <kill>
  kill(pid3);
     ca9:	89 3c 24             	mov    %edi,(%esp)
     cac:	e8 52 2c 00 00       	call   3903 <kill>
  printf(1, "wait... ");
<<<<<<< HEAD
     cb1:	59                   	pop    %ecx
     cb2:	5b                   	pop    %ebx
     cb3:	68 f6 40 00 00       	push   $0x40f6
     cb8:	6a 01                	push   $0x1
     cba:	e8 61 2d 00 00       	call   3a20 <printf>
=======
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 36 41 00 00       	push   $0x4136
     ca8:	6a 01                	push   $0x1
     caa:	e8 91 2d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  wait();
     cbf:	e8 17 2c 00 00       	call   38db <wait>
  wait();
     cc4:	e8 12 2c 00 00       	call   38db <wait>
  wait();
     cc9:	e8 0d 2c 00 00       	call   38db <wait>
  printf(1, "preempt ok\n");
<<<<<<< HEAD
     cce:	5e                   	pop    %esi
     ccf:	5f                   	pop    %edi
     cd0:	68 ff 40 00 00       	push   $0x40ff
     cd5:	6a 01                	push   $0x1
     cd7:	e8 44 2d 00 00       	call   3a20 <printf>
     cdc:	83 c4 10             	add    $0x10,%esp
=======
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 3f 41 00 00       	push   $0x413f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 74 2d 00 00       	call   3a40 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     cdf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ce2:	5b                   	pop    %ebx
     ce3:	5e                   	pop    %esi
     ce4:	5f                   	pop    %edi
     ce5:	5d                   	pop    %ebp
     ce6:	c3                   	ret
    printf(1, "preempt read error");
<<<<<<< HEAD
     ce7:	83 ec 08             	sub    $0x8,%esp
     cea:	68 da 40 00 00       	push   $0x40da
     cef:	6a 01                	push   $0x1
     cf1:	e8 2a 2d 00 00       	call   3a20 <printf>
     cf6:	83 c4 10             	add    $0x10,%esp
     cf9:	eb e4                	jmp    cdf <preempt+0x11f>
      printf(1, "preempt write error");
     cfb:	83 ec 08             	sub    $0x8,%esp
     cfe:	68 c6 40 00 00       	push   $0x40c6
     d03:	6a 01                	push   $0x1
     d05:	e8 16 2d 00 00       	call   3a20 <printf>
     d0a:	83 c4 10             	add    $0x10,%esp
     d0d:	e9 31 ff ff ff       	jmp    c43 <preempt+0x83>
     d12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d19:	00 
     d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
=======
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 1a 41 00 00       	push   $0x411a
     cdf:	6a 01                	push   $0x1
     ce1:	e8 5a 2d 00 00       	call   3a40 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	eb e4                	jmp    ccf <preempt+0x11f>
      printf(1, "preempt write error");
     ceb:	83 ec 08             	sub    $0x8,%esp
     cee:	68 06 41 00 00       	push   $0x4106
     cf3:	6a 01                	push   $0x1
     cf5:	e8 46 2d 00 00       	call   3a40 <printf>
     cfa:	83 c4 10             	add    $0x10,%esp
     cfd:	e9 31 ff ff ff       	jmp    c33 <preempt+0x83>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

00000d20 <exitwait>:
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	56                   	push   %esi
     d24:	be 64 00 00 00       	mov    $0x64,%esi
     d29:	53                   	push   %ebx
     d2a:	eb 14                	jmp    d40 <exitwait+0x20>
     d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d30:	74 68                	je     d9a <exitwait+0x7a>
      if(wait() != pid){
     d32:	e8 a4 2b 00 00       	call   38db <wait>
     d37:	39 d8                	cmp    %ebx,%eax
     d39:	75 2d                	jne    d68 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d3b:	83 ee 01             	sub    $0x1,%esi
     d3e:	74 41                	je     d81 <exitwait+0x61>
    pid = fork();
     d40:	e8 86 2b 00 00       	call   38cb <fork>
     d45:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d47:	85 c0                	test   %eax,%eax
     d49:	79 e5                	jns    d30 <exitwait+0x10>
      printf(1, "fork failed\n");
<<<<<<< HEAD
     d4b:	83 ec 08             	sub    $0x8,%esp
     d4e:	68 69 4c 00 00       	push   $0x4c69
     d53:	6a 01                	push   $0x1
     d55:	e8 c6 2c 00 00       	call   3a20 <printf>
=======
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 a9 4c 00 00       	push   $0x4ca9
     d43:	6a 01                	push   $0x1
     d45:	e8 f6 2c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      return;
     d5a:	83 c4 10             	add    $0x10,%esp
}
     d5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d60:	5b                   	pop    %ebx
     d61:	5e                   	pop    %esi
     d62:	5d                   	pop    %ebp
     d63:	c3                   	ret
     d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
<<<<<<< HEAD
     d68:	83 ec 08             	sub    $0x8,%esp
     d6b:	68 0b 41 00 00       	push   $0x410b
     d70:	6a 01                	push   $0x1
     d72:	e8 a9 2c 00 00       	call   3a20 <printf>
=======
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 4b 41 00 00       	push   $0x414b
     d60:	6a 01                	push   $0x1
     d62:	e8 d9 2c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        return;
     d77:	83 c4 10             	add    $0x10,%esp
}
     d7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d7d:	5b                   	pop    %ebx
     d7e:	5e                   	pop    %esi
     d7f:	5d                   	pop    %ebp
     d80:	c3                   	ret
  printf(1, "exitwait ok\n");
<<<<<<< HEAD
     d81:	83 ec 08             	sub    $0x8,%esp
     d84:	68 1b 41 00 00       	push   $0x411b
     d89:	6a 01                	push   $0x1
     d8b:	e8 90 2c 00 00       	call   3a20 <printf>
     d90:	83 c4 10             	add    $0x10,%esp
=======
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 5b 41 00 00       	push   $0x415b
     d79:	6a 01                	push   $0x1
     d7b:	e8 c0 2c 00 00       	call   3a40 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     d93:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d96:	5b                   	pop    %ebx
     d97:	5e                   	pop    %esi
     d98:	5d                   	pop    %ebp
     d99:	c3                   	ret
      exit();
     d9a:	e8 34 2b 00 00       	call   38d3 <exit>
     d9f:	90                   	nop

00000da0 <mem>:
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	56                   	push   %esi
     da4:	31 f6                	xor    %esi,%esi
     da6:	53                   	push   %ebx
  printf(1, "mem test\n");
<<<<<<< HEAD
     da7:	83 ec 08             	sub    $0x8,%esp
     daa:	68 28 41 00 00       	push   $0x4128
     daf:	6a 01                	push   $0x1
     db1:	e8 6a 2c 00 00       	call   3a20 <printf>
=======
     d97:	83 ec 08             	sub    $0x8,%esp
     d9a:	68 68 41 00 00       	push   $0x4168
     d9f:	6a 01                	push   $0x1
     da1:	e8 9a 2c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  ppid = getpid();
     db6:	e8 98 2b 00 00       	call   3953 <getpid>
     dbb:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     dbd:	e8 09 2b 00 00       	call   38cb <fork>
     dc2:	83 c4 10             	add    $0x10,%esp
     dc5:	85 c0                	test   %eax,%eax
     dc7:	74 0b                	je     dd4 <mem+0x34>
     dc9:	e9 8a 00 00 00       	jmp    e58 <mem+0xb8>
     dce:	66 90                	xchg   %ax,%ax
      *(char**)m2 = m1;
     dd0:	89 30                	mov    %esi,(%eax)
      m1 = m2;
     dd2:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
<<<<<<< HEAD
     dd4:	83 ec 0c             	sub    $0xc,%esp
     dd7:	68 11 27 00 00       	push   $0x2711
     ddc:	e8 5f 2e 00 00       	call   3c40 <malloc>
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	85 c0                	test   %eax,%eax
     de6:	75 e8                	jne    dd0 <mem+0x30>
=======
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 9f 2e 00 00       	call   3c70 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    while(m1){
     de8:	85 f6                	test   %esi,%esi
     dea:	74 18                	je     e04 <mem+0x64>
     dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     df0:	89 f0                	mov    %esi,%eax
      free(m1);
     df2:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     df5:	8b 36                	mov    (%esi),%esi
      free(m1);
<<<<<<< HEAD
     df7:	50                   	push   %eax
     df8:	e8 b3 2d 00 00       	call   3bb0 <free>
=======
     de7:	50                   	push   %eax
     de8:	e8 f3 2d 00 00       	call   3be0 <free>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    while(m1){
     dfd:	83 c4 10             	add    $0x10,%esp
     e00:	85 f6                	test   %esi,%esi
     e02:	75 ec                	jne    df0 <mem+0x50>
    m1 = malloc(1024*20);
<<<<<<< HEAD
     e04:	83 ec 0c             	sub    $0xc,%esp
     e07:	68 00 50 00 00       	push   $0x5000
     e0c:	e8 2f 2e 00 00       	call   3c40 <malloc>
=======
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 6f 2e 00 00       	call   3c70 <malloc>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(m1 == 0){
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	85 c0                	test   %eax,%eax
     e16:	74 20                	je     e38 <mem+0x98>
    free(m1);
<<<<<<< HEAD
     e18:	83 ec 0c             	sub    $0xc,%esp
     e1b:	50                   	push   %eax
     e1c:	e8 8f 2d 00 00       	call   3bb0 <free>
    printf(1, "mem ok\n");
     e21:	58                   	pop    %eax
     e22:	5a                   	pop    %edx
     e23:	68 4c 41 00 00       	push   $0x414c
     e28:	6a 01                	push   $0x1
     e2a:	e8 f1 2b 00 00       	call   3a20 <printf>
=======
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 cf 2d 00 00       	call   3be0 <free>
    printf(1, "mem ok\n");
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 8c 41 00 00       	push   $0x418c
     e18:	6a 01                	push   $0x1
     e1a:	e8 21 2c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
     e2f:	e8 9f 2a 00 00       	call   38d3 <exit>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
<<<<<<< HEAD
     e38:	83 ec 08             	sub    $0x8,%esp
     e3b:	68 32 41 00 00       	push   $0x4132
     e40:	6a 01                	push   $0x1
     e42:	e8 d9 2b 00 00       	call   3a20 <printf>
=======
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 72 41 00 00       	push   $0x4172
     e30:	6a 01                	push   $0x1
     e32:	e8 09 2c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      kill(ppid);
     e47:	89 1c 24             	mov    %ebx,(%esp)
     e4a:	e8 b4 2a 00 00       	call   3903 <kill>
      exit();
     e4f:	e8 7f 2a 00 00       	call   38d3 <exit>
     e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e58:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e5b:	5b                   	pop    %ebx
     e5c:	5e                   	pop    %esi
     e5d:	5d                   	pop    %ebp
    wait();
     e5e:	e9 78 2a 00 00       	jmp    38db <wait>
     e63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e6a:	00 
     e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000e70 <sharedfd>:
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
     e76:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
<<<<<<< HEAD
     e79:	68 54 41 00 00       	push   $0x4154
     e7e:	6a 01                	push   $0x1
     e80:	e8 9b 2b 00 00       	call   3a20 <printf>
  unlink("sharedfd");
     e85:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     e8c:	e8 92 2a 00 00       	call   3923 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e91:	5b                   	pop    %ebx
     e92:	5e                   	pop    %esi
     e93:	68 02 02 00 00       	push   $0x202
     e98:	68 63 41 00 00       	push   $0x4163
     e9d:	e8 71 2a 00 00       	call   3913 <open>
=======
     e69:	68 94 41 00 00       	push   $0x4194
     e6e:	6a 01                	push   $0x1
     e70:	e8 cb 2b 00 00       	call   3a40 <printf>
  unlink("sharedfd");
     e75:	c7 04 24 a3 41 00 00 	movl   $0x41a3,(%esp)
     e7c:	e8 a2 2a 00 00       	call   3923 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 a3 41 00 00       	push   $0x41a3
     e8d:	e8 81 2a 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	85 c0                	test   %eax,%eax
     ea7:	0f 88 2a 01 00 00    	js     fd7 <sharedfd+0x167>
     ead:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eaf:	8d 75 de             	lea    -0x22(%ebp),%esi
     eb2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     eb7:	e8 0f 2a 00 00       	call   38cb <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ebc:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     ebf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ec2:	19 c0                	sbb    %eax,%eax
     ec4:	83 ec 04             	sub    $0x4,%esp
     ec7:	83 e0 f3             	and    $0xfffffff3,%eax
     eca:	6a 0a                	push   $0xa
     ecc:	83 c0 70             	add    $0x70,%eax
     ecf:	50                   	push   %eax
     ed0:	56                   	push   %esi
     ed1:	e8 7a 28 00 00       	call   3750 <memset>
     ed6:	83 c4 10             	add    $0x10,%esp
     ed9:	eb 0a                	jmp    ee5 <sharedfd+0x75>
     edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     ee0:	83 eb 01             	sub    $0x1,%ebx
     ee3:	74 26                	je     f0b <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ee5:	83 ec 04             	sub    $0x4,%esp
     ee8:	6a 0a                	push   $0xa
     eea:	56                   	push   %esi
     eeb:	57                   	push   %edi
     eec:	e8 02 2a 00 00       	call   38f3 <write>
     ef1:	83 c4 10             	add    $0x10,%esp
     ef4:	83 f8 0a             	cmp    $0xa,%eax
     ef7:	74 e7                	je     ee0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
<<<<<<< HEAD
     ef9:	83 ec 08             	sub    $0x8,%esp
     efc:	68 5c 4e 00 00       	push   $0x4e5c
     f01:	6a 01                	push   $0x1
     f03:	e8 18 2b 00 00       	call   3a20 <printf>
=======
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 94 4e 00 00       	push   $0x4e94
     ef1:	6a 01                	push   $0x1
     ef3:	e8 48 2b 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      break;
     f08:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     f0b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f0e:	85 c9                	test   %ecx,%ecx
     f10:	0f 84 f5 00 00 00    	je     100b <sharedfd+0x19b>
    wait();
     f16:	e8 c0 29 00 00       	call   38db <wait>
  close(fd);
     f1b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f1e:	31 db                	xor    %ebx,%ebx
  close(fd);
     f20:	57                   	push   %edi
     f21:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f24:	e8 d2 29 00 00       	call   38fb <close>
  fd = open("sharedfd", 0);
<<<<<<< HEAD
     f29:	58                   	pop    %eax
     f2a:	5a                   	pop    %edx
     f2b:	6a 00                	push   $0x0
     f2d:	68 63 41 00 00       	push   $0x4163
     f32:	e8 dc 29 00 00       	call   3913 <open>
=======
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 a3 41 00 00       	push   $0x41a3
     f22:	e8 ec 29 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
     f37:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f3a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f3f:	85 c0                	test   %eax,%eax
     f41:	0f 88 aa 00 00 00    	js     ff1 <sharedfd+0x181>
     f47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f4e:	00 
     f4f:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f56:	6a 0a                	push   $0xa
     f58:	56                   	push   %esi
     f59:	ff 75 d0             	push   -0x30(%ebp)
     f5c:	e8 8a 29 00 00       	call   38eb <read>
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	85 c0                	test   %eax,%eax
     f66:	7e 28                	jle    f90 <sharedfd+0x120>
     f68:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f6b:	89 f0                	mov    %esi,%eax
     f6d:	eb 13                	jmp    f82 <sharedfd+0x112>
     f6f:	90                   	nop
        np++;
     f70:	80 f9 70             	cmp    $0x70,%cl
     f73:	0f 94 c1             	sete   %cl
     f76:	0f b6 c9             	movzbl %cl,%ecx
     f79:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
     f7b:	83 c0 01             	add    $0x1,%eax
     f7e:	39 c7                	cmp    %eax,%edi
     f80:	74 ce                	je     f50 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f82:	0f b6 08             	movzbl (%eax),%ecx
     f85:	80 f9 63             	cmp    $0x63,%cl
     f88:	75 e6                	jne    f70 <sharedfd+0x100>
        nc++;
     f8a:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     f8d:	eb ec                	jmp    f7b <sharedfd+0x10b>
     f8f:	90                   	nop
  close(fd);
     f90:	83 ec 0c             	sub    $0xc,%esp
     f93:	ff 75 d0             	push   -0x30(%ebp)
     f96:	e8 60 29 00 00       	call   38fb <close>
  unlink("sharedfd");
<<<<<<< HEAD
     f9b:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     fa2:	e8 7c 29 00 00       	call   3923 <unlink>
=======
     f8b:	c7 04 24 a3 41 00 00 	movl   $0x41a3,(%esp)
     f92:	e8 8c 29 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(nc == 10000 && np == 10000){
     fa7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     faa:	83 c4 10             	add    $0x10,%esp
     fad:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fb3:	75 5b                	jne    1010 <sharedfd+0x1a0>
     fb5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fbb:	75 53                	jne    1010 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
<<<<<<< HEAD
     fbd:	83 ec 08             	sub    $0x8,%esp
     fc0:	68 6c 41 00 00       	push   $0x416c
     fc5:	6a 01                	push   $0x1
     fc7:	e8 54 2a 00 00       	call   3a20 <printf>
     fcc:	83 c4 10             	add    $0x10,%esp
=======
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 ac 41 00 00       	push   $0x41ac
     fb5:	6a 01                	push   $0x1
     fb7:	e8 84 2a 00 00       	call   3a40 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
     fcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fd2:	5b                   	pop    %ebx
     fd3:	5e                   	pop    %esi
     fd4:	5f                   	pop    %edi
     fd5:	5d                   	pop    %ebp
     fd6:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for writing");
<<<<<<< HEAD
     fd7:	83 ec 08             	sub    $0x8,%esp
     fda:	68 30 4e 00 00       	push   $0x4e30
     fdf:	6a 01                	push   $0x1
     fe1:	e8 3a 2a 00 00       	call   3a20 <printf>
=======
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 68 4e 00 00       	push   $0x4e68
     fcf:	6a 01                	push   $0x1
     fd1:	e8 6a 2a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    return;
     fe6:	83 c4 10             	add    $0x10,%esp
}
     fe9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fec:	5b                   	pop    %ebx
     fed:	5e                   	pop    %esi
     fee:	5f                   	pop    %edi
     fef:	5d                   	pop    %ebp
     ff0:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for reading\n");
<<<<<<< HEAD
     ff1:	83 ec 08             	sub    $0x8,%esp
     ff4:	68 7c 4e 00 00       	push   $0x4e7c
     ff9:	6a 01                	push   $0x1
     ffb:	e8 20 2a 00 00       	call   3a20 <printf>
=======
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 b4 4e 00 00       	push   $0x4eb4
     fe9:	6a 01                	push   $0x1
     feb:	e8 50 2a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    return;
    1000:	83 c4 10             	add    $0x10,%esp
}
    1003:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1006:	5b                   	pop    %ebx
    1007:	5e                   	pop    %esi
    1008:	5f                   	pop    %edi
    1009:	5d                   	pop    %ebp
    100a:	c3                   	ret
    exit();
    100b:	e8 c3 28 00 00       	call   38d3 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
<<<<<<< HEAD
    1010:	53                   	push   %ebx
    1011:	52                   	push   %edx
    1012:	68 79 41 00 00       	push   $0x4179
    1017:	6a 01                	push   $0x1
    1019:	e8 02 2a 00 00       	call   3a20 <printf>
=======
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 b9 41 00 00       	push   $0x41b9
    1007:	6a 01                	push   $0x1
    1009:	e8 32 2a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    101e:	e8 b0 28 00 00       	call   38d3 <exit>
    1023:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    102a:	00 
    102b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00001030 <fourfiles>:
{
<<<<<<< HEAD
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
=======
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1025:	be ce 41 00 00       	mov    $0x41ce,%esi
{
    102a:	53                   	push   %ebx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(pi = 0; pi < 4; pi++){
    1036:	31 db                	xor    %ebx,%ebx
{
    1038:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
<<<<<<< HEAD
    103b:	c7 45 d8 8e 41 00 00 	movl   $0x418e,-0x28(%ebp)
    1042:	c7 45 dc d7 42 00 00 	movl   $0x42d7,-0x24(%ebp)
    1049:	c7 45 e0 db 42 00 00 	movl   $0x42db,-0x20(%ebp)
    1050:	c7 45 e4 91 41 00 00 	movl   $0x4191,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1057:	68 94 41 00 00       	push   $0x4194
    105c:	6a 01                	push   $0x1
    105e:	e8 bd 29 00 00       	call   3a20 <printf>
    1063:	83 c4 10             	add    $0x10,%esp
    fname = names[pi];
    1066:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
    106a:	83 ec 0c             	sub    $0xc,%esp
    106d:	56                   	push   %esi
    106e:	e8 b0 28 00 00       	call   3923 <unlink>
=======
    1030:	c7 45 d8 ce 41 00 00 	movl   $0x41ce,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    1037:	68 d4 41 00 00       	push   $0x41d4
    103c:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    103e:	c7 45 dc 17 43 00 00 	movl   $0x4317,-0x24(%ebp)
    1045:	c7 45 e0 1b 43 00 00 	movl   $0x431b,-0x20(%ebp)
    104c:	c7 45 e4 d1 41 00 00 	movl   $0x41d1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1053:	e8 e8 29 00 00       	call   3a40 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 bf 28 00 00       	call   3923 <unlink>
    pid = fork();
    1064:	e8 62 28 00 00       	call   38cb <fork>
    if(pid < 0){
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 64 01 00 00    	js     11d8 <fourfiles+0x1b8>
    if(pid == 0){
    1074:	0f 84 e9 00 00 00    	je     1163 <fourfiles+0x143>
  for(pi = 0; pi < 4; pi++){
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    fname = names[pi];
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    wait();
    1088:	e8 4e 28 00 00       	call   38db <wait>
  for(i = 0; i < 2; i++){
    108d:	31 f6                	xor    %esi,%esi
    wait();
    108f:	e8 47 28 00 00       	call   38db <wait>
    1094:	e8 42 28 00 00       	call   38db <wait>
    1099:	e8 3d 28 00 00       	call   38db <wait>
    fname = names[i];
    109e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    10a2:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10a5:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10a7:	6a 00                	push   $0x0
    10a9:	50                   	push   %eax
    fname = names[i];
    10aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    10ad:	e8 61 28 00 00       	call   3913 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b2:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 a0 85 00 00       	push   $0x85a0
    10cd:	ff 75 d4             	push   -0x2c(%ebp)
    10d0:	e8 16 28 00 00       	call   38eb <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	89 c7                	mov    %eax,%edi
    10da:	85 c0                	test   %eax,%eax
    10dc:	7e 20                	jle    10fe <fourfiles+0xde>
      for(j = 0; j < n; j++){
    10de:	31 c0                	xor    %eax,%eax
        if(buf[j] != '0'+i){
    10e0:	83 fe 01             	cmp    $0x1,%esi
    10e3:	0f be 88 a0 85 00 00 	movsbl 0x85a0(%eax),%ecx
    10ea:	19 d2                	sbb    %edx,%edx
    10ec:	83 c2 31             	add    $0x31,%edx
    10ef:	39 d1                	cmp    %edx,%ecx
    10f1:	75 5c                	jne    114f <fourfiles+0x12f>
      for(j = 0; j < n; j++){
    10f3:	83 c0 01             	add    $0x1,%eax
    10f6:	39 c7                	cmp    %eax,%edi
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
      total += n;
    10fa:	01 fb                	add    %edi,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    close(fd);
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	push   -0x2c(%ebp)
    1104:	e8 f2 27 00 00       	call   38fb <close>
    if(total != 12*500){
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 d4 00 00 00    	jne    11ec <fourfiles+0x1cc>
    unlink(fname);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	push   -0x30(%ebp)
    111e:	e8 00 28 00 00       	call   3923 <unlink>
  for(i = 0; i < 2; i++){
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 fe 01             	cmp    $0x1,%esi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 12 42 00 00       	push   $0x4212
    1133:	6a 01                	push   $0x1
    1135:	e8 06 29 00 00       	call   3a40 <printf>
}
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	be 01 00 00 00       	mov    $0x1,%esi
    114a:	e9 4f ff ff ff       	jmp    109e <fourfiles+0x7e>
          printf(1, "wrong char\n");
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	68 f5 41 00 00       	push   $0x41f5
    1157:	6a 01                	push   $0x1
    1159:	e8 e2 28 00 00       	call   3a40 <printf>
          exit();
    115e:	e8 70 27 00 00       	call   38d3 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	68 02 02 00 00       	push   $0x202
    116b:	56                   	push   %esi
    116c:	e8 a2 27 00 00       	call   3913 <open>
      if(fd < 0){
    1171:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    1174:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1176:	85 c0                	test   %eax,%eax
    1178:	78 45                	js     11bf <fourfiles+0x19f>
      memset(buf, '0'+pi, 512);
    117a:	83 ec 04             	sub    $0x4,%esp
    117d:	83 c3 30             	add    $0x30,%ebx
    1180:	68 00 02 00 00       	push   $0x200
    1185:	53                   	push   %ebx
    1186:	bb 0c 00 00 00       	mov    $0xc,%ebx
    118b:	68 a0 85 00 00       	push   $0x85a0
    1190:	e8 ab 25 00 00       	call   3740 <memset>
    1195:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	68 f4 01 00 00       	push   $0x1f4
    11a0:	68 a0 85 00 00       	push   $0x85a0
    11a5:	56                   	push   %esi
    11a6:	e8 48 27 00 00       	call   38f3 <write>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b3:	75 4a                	jne    11ff <fourfiles+0x1df>
      for(i = 0; i < 12; i++){
    11b5:	83 eb 01             	sub    $0x1,%ebx
    11b8:	75 de                	jne    1198 <fourfiles+0x178>
      exit();
    11ba:	e8 14 27 00 00       	call   38d3 <exit>
        printf(1, "create failed\n");
    11bf:	51                   	push   %ecx
    11c0:	51                   	push   %ecx
    11c1:	68 6f 44 00 00       	push   $0x446f
    11c6:	6a 01                	push   $0x1
    11c8:	e8 73 28 00 00       	call   3a40 <printf>
        exit();
    11cd:	e8 01 27 00 00       	call   38d3 <exit>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
    11d8:	83 ec 08             	sub    $0x8,%esp
    11db:	68 a9 4c 00 00       	push   $0x4ca9
    11e0:	6a 01                	push   $0x1
    11e2:	e8 59 28 00 00       	call   3a40 <printf>
      exit();
    11e7:	e8 e7 26 00 00       	call   38d3 <exit>
      printf(1, "wrong length %d\n", total);
    11ec:	50                   	push   %eax
    11ed:	53                   	push   %ebx
    11ee:	68 01 42 00 00       	push   $0x4201
    11f3:	6a 01                	push   $0x1
    11f5:	e8 46 28 00 00       	call   3a40 <printf>
      exit();
    11fa:	e8 d4 26 00 00       	call   38d3 <exit>
          printf(1, "write failed %d\n", n);
    11ff:	52                   	push   %edx
    1200:	50                   	push   %eax
    1201:	68 e4 41 00 00       	push   $0x41e4
    1206:	6a 01                	push   $0x1
    1208:	e8 33 28 00 00       	call   3a40 <printf>
          exit();
    120d:	e8 c1 26 00 00       	call   38d3 <exit>
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <createdelete>:
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1226:	31 db                	xor    %ebx,%ebx
{
    1228:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    122b:	68 20 42 00 00       	push   $0x4220
    1230:	6a 01                	push   $0x1
    1232:	e8 09 28 00 00       	call   3a40 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    pid = fork();
    1073:	e8 53 28 00 00       	call   38cb <fork>
    if(pid < 0){
    1078:	83 c4 10             	add    $0x10,%esp
    107b:	85 c0                	test   %eax,%eax
    107d:	0f 88 6d 01 00 00    	js     11f0 <fourfiles+0x1c0>
    if(pid == 0){
    1083:	0f 84 f0 00 00 00    	je     1179 <fourfiles+0x149>
  for(pi = 0; pi < 4; pi++){
    1089:	83 c3 01             	add    $0x1,%ebx
    108c:	83 fb 04             	cmp    $0x4,%ebx
    108f:	75 d5                	jne    1066 <fourfiles+0x36>
    wait();
    1091:	e8 45 28 00 00       	call   38db <wait>
    1096:	31 f6                	xor    %esi,%esi
    1098:	e8 3e 28 00 00       	call   38db <wait>
    109d:	e8 39 28 00 00       	call   38db <wait>
    10a2:	e8 34 28 00 00       	call   38db <wait>
    fname = names[i];
    10a7:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    10ab:	83 ec 08             	sub    $0x8,%esp
    10ae:	89 f3                	mov    %esi,%ebx
    total = 0;
    10b0:	31 ff                	xor    %edi,%edi
    10b2:	83 f3 01             	xor    $0x1,%ebx
    fname = names[i];
    10b5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    10b8:	6a 00                	push   $0x0
    10ba:	50                   	push   %eax
    10bb:	e8 53 28 00 00       	call   3913 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10c0:	89 75 cc             	mov    %esi,-0x34(%ebp)
    10c3:	83 c4 10             	add    $0x10,%esp
    10c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10d0:	83 ec 04             	sub    $0x4,%esp
    10d3:	68 00 20 00 00       	push   $0x2000
    10d8:	68 40 85 00 00       	push   $0x8540
    10dd:	ff 75 d4             	push   -0x2c(%ebp)
    10e0:	e8 06 28 00 00       	call   38eb <read>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	89 c6                	mov    %eax,%esi
    10ea:	85 c0                	test   %eax,%eax
    10ec:	7e 23                	jle    1111 <fourfiles+0xe1>
      for(j = 0; j < n; j++){
    10ee:	31 d2                	xor    %edx,%edx
        if(buf[j] != '0'+i){
    10f0:	89 d8                	mov    %ebx,%eax
    10f2:	0f be 8a 40 85 00 00 	movsbl 0x8540(%edx),%ecx
    10f9:	c1 e0 1f             	shl    $0x1f,%eax
    10fc:	c1 f8 1f             	sar    $0x1f,%eax
    10ff:	83 c0 31             	add    $0x31,%eax
    1102:	39 c1                	cmp    %eax,%ecx
    1104:	75 5f                	jne    1165 <fourfiles+0x135>
      for(j = 0; j < n; j++){
    1106:	83 c2 01             	add    $0x1,%edx
    1109:	39 d6                	cmp    %edx,%esi
    110b:	75 e3                	jne    10f0 <fourfiles+0xc0>
      total += n;
    110d:	01 f7                	add    %esi,%edi
    110f:	eb bf                	jmp    10d0 <fourfiles+0xa0>
    close(fd);
    1111:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1114:	83 ec 0c             	sub    $0xc,%esp
    1117:	8b 75 cc             	mov    -0x34(%ebp),%esi
    111a:	51                   	push   %ecx
    111b:	e8 db 27 00 00       	call   38fb <close>
    if(total != 12*500){
    1120:	83 c4 10             	add    $0x10,%esp
    1123:	81 ff 70 17 00 00    	cmp    $0x1770,%edi
    1129:	0f 85 d5 00 00 00    	jne    1204 <fourfiles+0x1d4>
    unlink(fname);
    112f:	83 ec 0c             	sub    $0xc,%esp
    1132:	ff 75 d0             	push   -0x30(%ebp)
    1135:	e8 e9 27 00 00       	call   3923 <unlink>
  for(i = 0; i < 2; i++){
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	85 f6                	test   %esi,%esi
    113f:	75 0a                	jne    114b <fourfiles+0x11b>
    1141:	be 01 00 00 00       	mov    $0x1,%esi
    1146:	e9 5c ff ff ff       	jmp    10a7 <fourfiles+0x77>
  printf(1, "fourfiles ok\n");
    114b:	83 ec 08             	sub    $0x8,%esp
    114e:	68 d2 41 00 00       	push   $0x41d2
    1153:	6a 01                	push   $0x1
    1155:	e8 c6 28 00 00       	call   3a20 <printf>
}
    115a:	83 c4 10             	add    $0x10,%esp
    115d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1160:	5b                   	pop    %ebx
    1161:	5e                   	pop    %esi
    1162:	5f                   	pop    %edi
    1163:	5d                   	pop    %ebp
    1164:	c3                   	ret
          printf(1, "wrong char\n");
    1165:	83 ec 08             	sub    $0x8,%esp
    1168:	68 b5 41 00 00       	push   $0x41b5
    116d:	6a 01                	push   $0x1
    116f:	e8 ac 28 00 00       	call   3a20 <printf>
          exit();
    1174:	e8 5a 27 00 00       	call   38d3 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1179:	83 ec 08             	sub    $0x8,%esp
    117c:	68 02 02 00 00       	push   $0x202
    1181:	56                   	push   %esi
    1182:	e8 8c 27 00 00       	call   3913 <open>
      if(fd < 0){
    1187:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    118a:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    118c:	85 c0                	test   %eax,%eax
    118e:	78 45                	js     11d5 <fourfiles+0x1a5>
      memset(buf, '0'+pi, 512);
    1190:	83 ec 04             	sub    $0x4,%esp
    1193:	83 c3 30             	add    $0x30,%ebx
    1196:	68 00 02 00 00       	push   $0x200
    119b:	53                   	push   %ebx
    119c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    11a1:	68 40 85 00 00       	push   $0x8540
    11a6:	e8 a5 25 00 00       	call   3750 <memset>
    11ab:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    11ae:	83 ec 04             	sub    $0x4,%esp
    11b1:	68 f4 01 00 00       	push   $0x1f4
    11b6:	68 40 85 00 00       	push   $0x8540
    11bb:	56                   	push   %esi
    11bc:	e8 32 27 00 00       	call   38f3 <write>
    11c1:	83 c4 10             	add    $0x10,%esp
    11c4:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11c9:	75 4c                	jne    1217 <fourfiles+0x1e7>
      for(i = 0; i < 12; i++){
    11cb:	83 eb 01             	sub    $0x1,%ebx
    11ce:	75 de                	jne    11ae <fourfiles+0x17e>
      exit();
    11d0:	e8 fe 26 00 00       	call   38d3 <exit>
        printf(1, "create failed\n");
    11d5:	51                   	push   %ecx
    11d6:	51                   	push   %ecx
    11d7:	68 2f 44 00 00       	push   $0x442f
    11dc:	6a 01                	push   $0x1
    11de:	e8 3d 28 00 00       	call   3a20 <printf>
        exit();
    11e3:	e8 eb 26 00 00       	call   38d3 <exit>
    11e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    11ef:	00 
      printf(1, "fork failed\n");
    11f0:	83 ec 08             	sub    $0x8,%esp
    11f3:	68 69 4c 00 00       	push   $0x4c69
    11f8:	6a 01                	push   $0x1
    11fa:	e8 21 28 00 00       	call   3a20 <printf>
      exit();
    11ff:	e8 cf 26 00 00       	call   38d3 <exit>
      printf(1, "wrong length %d\n", total);
    1204:	50                   	push   %eax
    1205:	57                   	push   %edi
    1206:	68 c1 41 00 00       	push   $0x41c1
    120b:	6a 01                	push   $0x1
    120d:	e8 0e 28 00 00       	call   3a20 <printf>
      exit();
    1212:	e8 bc 26 00 00       	call   38d3 <exit>
          printf(1, "write failed %d\n", n);
    1217:	52                   	push   %edx
    1218:	50                   	push   %eax
    1219:	68 a4 41 00 00       	push   $0x41a4
    121e:	6a 01                	push   $0x1
    1220:	e8 fb 27 00 00       	call   3a20 <printf>
          exit();
    1225:	e8 a9 26 00 00       	call   38d3 <exit>
    122a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001230 <createdelete>:
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
  for(pi = 0; pi < 4; pi++){
    1235:	31 f6                	xor    %esi,%esi
{
    1237:	53                   	push   %ebx
    1238:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    123b:	68 e0 41 00 00       	push   $0x41e0
    1240:	6a 01                	push   $0x1
    1242:	e8 d9 27 00 00       	call   3a20 <printf>
    1247:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    124a:	e8 7c 26 00 00       	call   38cb <fork>
    124f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1251:	85 c0                	test   %eax,%eax
    1253:	0f 88 ac 01 00 00    	js     1405 <createdelete+0x1d5>
    if(pid == 0){
    1259:	0f 84 01 01 00 00    	je     1360 <createdelete+0x130>
  for(pi = 0; pi < 4; pi++){
    125f:	83 c6 01             	add    $0x1,%esi
    1262:	83 fe 04             	cmp    $0x4,%esi
    1265:	75 e3                	jne    124a <createdelete+0x1a>
    wait();
    1267:	e8 6f 26 00 00       	call   38db <wait>
  for(i = 0; i < N; i++){
    126c:	31 ff                	xor    %edi,%edi
    126e:	8d 75 c8             	lea    -0x38(%ebp),%esi
    wait();
    1271:	e8 65 26 00 00       	call   38db <wait>
    1276:	e8 60 26 00 00       	call   38db <wait>
    127b:	e8 5b 26 00 00       	call   38db <wait>
  name[0] = name[1] = name[2] = 0;
    1280:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((i == 0 || i >= N/2) && fd < 0){
    1288:	85 ff                	test   %edi,%edi
      name[1] = '0' + i;
    128a:	8d 47 30             	lea    0x30(%edi),%eax
      if((i == 0 || i >= N/2) && fd < 0){
    128d:	bb 70 00 00 00       	mov    $0x70,%ebx
    1292:	0f 94 c2             	sete   %dl
    1295:	83 ff 09             	cmp    $0x9,%edi
      name[1] = '0' + i;
    1298:	88 45 c6             	mov    %al,-0x3a(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    129b:	0f 9f c0             	setg   %al
    129e:	09 c2                	or     %eax,%edx
    12a0:	88 55 c7             	mov    %dl,-0x39(%ebp)
      name[1] = '0' + i;
    12a3:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
      fd = open(name, 0);
    12a7:	83 ec 08             	sub    $0x8,%esp
      name[0] = 'p' + pi;
    12aa:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    12ad:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12b0:	6a 00                	push   $0x0
    12b2:	56                   	push   %esi
    12b3:	e8 5b 26 00 00       	call   3913 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12b8:	83 c4 10             	add    $0x10,%esp
    12bb:	80 7d c7 00          	cmpb   $0x0,-0x39(%ebp)
    12bf:	74 7f                	je     1340 <createdelete+0x110>
    12c1:	85 c0                	test   %eax,%eax
    12c3:	0f 88 27 01 00 00    	js     13f0 <createdelete+0x1c0>
        close(fd);
    12c9:	83 ec 0c             	sub    $0xc,%esp
    12cc:	50                   	push   %eax
    12cd:	e8 29 26 00 00       	call   38fb <close>
    12d2:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    12d5:	83 c3 01             	add    $0x1,%ebx
    12d8:	80 fb 74             	cmp    $0x74,%bl
    12db:	75 c6                	jne    12a3 <createdelete+0x73>
  for(i = 0; i < N; i++){
    12dd:	83 c7 01             	add    $0x1,%edi
    12e0:	83 ff 14             	cmp    $0x14,%edi
    12e3:	75 a3                	jne    1288 <createdelete+0x58>
    12e5:	bf 70 00 00 00       	mov    $0x70,%edi
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[1] = '0' + i;
    12f0:	8d 47 c0             	lea    -0x40(%edi),%eax
    12f3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12f8:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    12fb:	89 f8                	mov    %edi,%eax
      unlink(name);
    12fd:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    1300:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1303:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1307:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    130a:	56                   	push   %esi
    130b:	e8 13 26 00 00       	call   3923 <unlink>
    for(pi = 0; pi < 4; pi++){
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	83 eb 01             	sub    $0x1,%ebx
    1316:	75 e3                	jne    12fb <createdelete+0xcb>
  for(i = 0; i < N; i++){
    1318:	83 c7 01             	add    $0x1,%edi
    131b:	89 f8                	mov    %edi,%eax
    131d:	3c 84                	cmp    $0x84,%al
    131f:	75 cf                	jne    12f0 <createdelete+0xc0>
  printf(1, "createdelete ok\n");
    1321:	83 ec 08             	sub    $0x8,%esp
<<<<<<< HEAD
    1324:	68 f3 41 00 00       	push   $0x41f3
    1329:	6a 01                	push   $0x1
    132b:	e8 f0 26 00 00       	call   3a20 <printf>
=======
    1324:	68 33 42 00 00       	push   $0x4233
    1329:	6a 01                	push   $0x1
    132b:	e8 10 27 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1336:	5b                   	pop    %ebx
    1337:	5e                   	pop    %esi
    1338:	5f                   	pop    %edi
    1339:	5d                   	pop    %ebp
    133a:	c3                   	ret
    133b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1340:	85 c0                	test   %eax,%eax
    1342:	78 91                	js     12d5 <createdelete+0xa5>
        printf(1, "oops createdelete %s did exist\n", name);
    1344:	50                   	push   %eax
<<<<<<< HEAD
    1345:	56                   	push   %esi
    1346:	68 cc 4e 00 00       	push   $0x4ecc
    134b:	6a 01                	push   $0x1
    134d:	e8 ce 26 00 00       	call   3a20 <printf>
=======
    1345:	57                   	push   %edi
    1346:	68 04 4f 00 00       	push   $0x4f04
    134b:	6a 01                	push   $0x1
    134d:	e8 ee 26 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
    1352:	e8 7c 25 00 00       	call   38d3 <exit>
    1357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    135e:	00 
    135f:	90                   	nop
      name[0] = 'p' + pi;
    1360:	8d 46 70             	lea    0x70(%esi),%eax
      name[2] = '\0';
    1363:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1367:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[0] = 'p' + pi;
    136a:	88 45 c8             	mov    %al,-0x38(%ebp)
      for(i = 0; i < N; i++){
    136d:	8d 76 00             	lea    0x0(%esi),%esi
        fd = open(name, O_CREATE | O_RDWR);
    1370:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    1373:	8d 43 30             	lea    0x30(%ebx),%eax
    1376:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1379:	68 02 02 00 00       	push   $0x202
    137e:	56                   	push   %esi
    137f:	e8 8f 25 00 00       	call   3913 <open>
        if(fd < 0){
    1384:	83 c4 10             	add    $0x10,%esp
    1387:	85 c0                	test   %eax,%eax
    1389:	0f 88 8a 00 00 00    	js     1419 <createdelete+0x1e9>
        close(fd);
    138f:	83 ec 0c             	sub    $0xc,%esp
    1392:	50                   	push   %eax
    1393:	e8 63 25 00 00       	call   38fb <close>
        if(i > 0 && (i % 2 ) == 0){
    1398:	83 c4 10             	add    $0x10,%esp
    139b:	85 db                	test   %ebx,%ebx
    139d:	74 19                	je     13b8 <createdelete+0x188>
    139f:	f6 c3 01             	test   $0x1,%bl
    13a2:	74 1b                	je     13bf <createdelete+0x18f>
      for(i = 0; i < N; i++){
    13a4:	83 c3 01             	add    $0x1,%ebx
    13a7:	83 fb 14             	cmp    $0x14,%ebx
    13aa:	75 c4                	jne    1370 <createdelete+0x140>
      exit();
    13ac:	e8 22 25 00 00       	call   38d3 <exit>
    13b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    13b8:	bb 01 00 00 00       	mov    $0x1,%ebx
    13bd:	eb b1                	jmp    1370 <createdelete+0x140>
          name[1] = '0' + (i / 2);
    13bf:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    13c1:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13c4:	d1 f8                	sar    $1,%eax
    13c6:	83 c0 30             	add    $0x30,%eax
    13c9:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13cc:	56                   	push   %esi
    13cd:	e8 51 25 00 00       	call   3923 <unlink>
    13d2:	83 c4 10             	add    $0x10,%esp
    13d5:	85 c0                	test   %eax,%eax
    13d7:	79 cb                	jns    13a4 <createdelete+0x174>
            printf(1, "unlink failed\n");
<<<<<<< HEAD
    13d9:	52                   	push   %edx
    13da:	52                   	push   %edx
    13db:	68 e1 3d 00 00       	push   $0x3de1
    13e0:	6a 01                	push   $0x1
    13e2:	e8 39 26 00 00       	call   3a20 <printf>
=======
    13d5:	52                   	push   %edx
    13d6:	52                   	push   %edx
    13d7:	68 21 3e 00 00       	push   $0x3e21
    13dc:	6a 01                	push   $0x1
    13de:	e8 5d 26 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
            exit();
    13e7:	e8 e7 24 00 00       	call   38d3 <exit>
    13ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "oops createdelete %s didn't exist\n", name);
<<<<<<< HEAD
    13f0:	83 ec 04             	sub    $0x4,%esp
    13f3:	56                   	push   %esi
    13f4:	68 a8 4e 00 00       	push   $0x4ea8
    13f9:	6a 01                	push   $0x1
    13fb:	e8 20 26 00 00       	call   3a20 <printf>
=======
    13f5:	83 ec 04             	sub    $0x4,%esp
    13f8:	57                   	push   %edi
    13f9:	68 e0 4e 00 00       	push   $0x4ee0
    13fe:	6a 01                	push   $0x1
    1400:	e8 3b 26 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
    1400:	e8 ce 24 00 00       	call   38d3 <exit>
      printf(1, "fork failed\n");
<<<<<<< HEAD
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 69 4c 00 00       	push   $0x4c69
    140d:	6a 01                	push   $0x1
    140f:	e8 0c 26 00 00       	call   3a20 <printf>
=======
    140a:	83 ec 08             	sub    $0x8,%esp
    140d:	68 a9 4c 00 00       	push   $0x4ca9
    1412:	6a 01                	push   $0x1
    1414:	e8 27 26 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    1414:	e8 ba 24 00 00       	call   38d3 <exit>
          printf(1, "create failed\n");
<<<<<<< HEAD
    1419:	83 ec 08             	sub    $0x8,%esp
    141c:	68 2f 44 00 00       	push   $0x442f
    1421:	6a 01                	push   $0x1
    1423:	e8 f8 25 00 00       	call   3a20 <printf>
=======
    141e:	83 ec 08             	sub    $0x8,%esp
    1421:	68 6f 44 00 00       	push   $0x446f
    1426:	6a 01                	push   $0x1
    1428:	e8 13 26 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
          exit();
    1428:	e8 a6 24 00 00       	call   38d3 <exit>
    142d:	8d 76 00             	lea    0x0(%esi),%esi

00001430 <unlinkread>:
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
<<<<<<< HEAD
    1435:	83 ec 08             	sub    $0x8,%esp
    1438:	68 04 42 00 00       	push   $0x4204
    143d:	6a 01                	push   $0x1
    143f:	e8 dc 25 00 00       	call   3a20 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1444:	5b                   	pop    %ebx
    1445:	5e                   	pop    %esi
    1446:	68 02 02 00 00       	push   $0x202
    144b:	68 15 42 00 00       	push   $0x4215
    1450:	e8 be 24 00 00       	call   3913 <open>
=======
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	68 44 42 00 00       	push   $0x4244
    144d:	6a 01                	push   $0x1
    144f:	e8 ec 25 00 00       	call   3a40 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1454:	5b                   	pop    %ebx
    1455:	5e                   	pop    %esi
    1456:	68 02 02 00 00       	push   $0x202
    145b:	68 55 42 00 00       	push   $0x4255
    1460:	e8 ae 24 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1455:	83 c4 10             	add    $0x10,%esp
    1458:	85 c0                	test   %eax,%eax
    145a:	0f 88 e6 00 00 00    	js     1546 <unlinkread+0x116>
  write(fd, "hello", 5);
<<<<<<< HEAD
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	89 c3                	mov    %eax,%ebx
    1465:	6a 05                	push   $0x5
    1467:	68 3a 42 00 00       	push   $0x423a
    146c:	50                   	push   %eax
    146d:	e8 81 24 00 00       	call   38f3 <write>
=======
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	89 c3                	mov    %eax,%ebx
    1475:	6a 05                	push   $0x5
    1477:	68 7a 42 00 00       	push   $0x427a
    147c:	50                   	push   %eax
    147d:	e8 71 24 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1472:	89 1c 24             	mov    %ebx,(%esp)
    1475:	e8 81 24 00 00       	call   38fb <close>
  fd = open("unlinkread", O_RDWR);
<<<<<<< HEAD
    147a:	58                   	pop    %eax
    147b:	5a                   	pop    %edx
    147c:	6a 02                	push   $0x2
    147e:	68 15 42 00 00       	push   $0x4215
    1483:	e8 8b 24 00 00       	call   3913 <open>
=======
    148a:	58                   	pop    %eax
    148b:	5a                   	pop    %edx
    148c:	6a 02                	push   $0x2
    148e:	68 55 42 00 00       	push   $0x4255
    1493:	e8 7b 24 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1488:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    148b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    148d:	85 c0                	test   %eax,%eax
    148f:	0f 88 10 01 00 00    	js     15a5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
<<<<<<< HEAD
    1495:	83 ec 0c             	sub    $0xc,%esp
    1498:	68 15 42 00 00       	push   $0x4215
    149d:	e8 81 24 00 00       	call   3923 <unlink>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	85 c0                	test   %eax,%eax
    14a7:	0f 85 e5 00 00 00    	jne    1592 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14ad:	83 ec 08             	sub    $0x8,%esp
    14b0:	68 02 02 00 00       	push   $0x202
    14b5:	68 15 42 00 00       	push   $0x4215
    14ba:	e8 54 24 00 00       	call   3913 <open>
=======
    14a5:	83 ec 0c             	sub    $0xc,%esp
    14a8:	68 55 42 00 00       	push   $0x4255
    14ad:	e8 71 24 00 00       	call   3923 <unlink>
    14b2:	83 c4 10             	add    $0x10,%esp
    14b5:	85 c0                	test   %eax,%eax
    14b7:	0f 85 e5 00 00 00    	jne    15a2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14bd:	83 ec 08             	sub    $0x8,%esp
    14c0:	68 02 02 00 00       	push   $0x202
    14c5:	68 55 42 00 00       	push   $0x4255
    14ca:	e8 44 24 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  write(fd1, "yyy", 3);
    14bf:	83 c4 0c             	add    $0xc,%esp
    14c2:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14c4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
<<<<<<< HEAD
    14c6:	68 72 42 00 00       	push   $0x4272
    14cb:	50                   	push   %eax
    14cc:	e8 22 24 00 00       	call   38f3 <write>
=======
    14d6:	68 b2 42 00 00       	push   $0x42b2
    14db:	50                   	push   %eax
    14dc:	e8 12 24 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd1);
    14d1:	89 34 24             	mov    %esi,(%esp)
    14d4:	e8 22 24 00 00       	call   38fb <close>
  if(read(fd, buf, sizeof(buf)) != 5){
<<<<<<< HEAD
    14d9:	83 c4 0c             	add    $0xc,%esp
    14dc:	68 00 20 00 00       	push   $0x2000
    14e1:	68 40 85 00 00       	push   $0x8540
    14e6:	53                   	push   %ebx
    14e7:	e8 ff 23 00 00       	call   38eb <read>
    14ec:	83 c4 10             	add    $0x10,%esp
    14ef:	83 f8 05             	cmp    $0x5,%eax
    14f2:	0f 85 87 00 00 00    	jne    157f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    14f8:	80 3d 40 85 00 00 68 	cmpb   $0x68,0x8540
    14ff:	75 6b                	jne    156c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1501:	83 ec 04             	sub    $0x4,%esp
    1504:	6a 0a                	push   $0xa
    1506:	68 40 85 00 00       	push   $0x8540
    150b:	53                   	push   %ebx
    150c:	e8 e2 23 00 00       	call   38f3 <write>
    1511:	83 c4 10             	add    $0x10,%esp
    1514:	83 f8 0a             	cmp    $0xa,%eax
    1517:	75 40                	jne    1559 <unlinkread+0x129>
=======
    14e9:	83 c4 0c             	add    $0xc,%esp
    14ec:	68 00 20 00 00       	push   $0x2000
    14f1:	68 a0 85 00 00       	push   $0x85a0
    14f6:	53                   	push   %ebx
    14f7:	e8 ef 23 00 00       	call   38eb <read>
    14fc:	83 c4 10             	add    $0x10,%esp
    14ff:	83 f8 05             	cmp    $0x5,%eax
    1502:	0f 85 87 00 00 00    	jne    158f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1508:	80 3d a0 85 00 00 68 	cmpb   $0x68,0x85a0
    150f:	75 6b                	jne    157c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1511:	83 ec 04             	sub    $0x4,%esp
    1514:	6a 0a                	push   $0xa
    1516:	68 a0 85 00 00       	push   $0x85a0
    151b:	53                   	push   %ebx
    151c:	e8 d2 23 00 00       	call   38f3 <write>
    1521:	83 c4 10             	add    $0x10,%esp
    1524:	83 f8 0a             	cmp    $0xa,%eax
    1527:	75 40                	jne    1569 <unlinkread+0x129>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1519:	83 ec 0c             	sub    $0xc,%esp
    151c:	53                   	push   %ebx
    151d:	e8 d9 23 00 00       	call   38fb <close>
  unlink("unlinkread");
<<<<<<< HEAD
    1522:	c7 04 24 15 42 00 00 	movl   $0x4215,(%esp)
    1529:	e8 f5 23 00 00       	call   3923 <unlink>
  printf(1, "unlinkread ok\n");
    152e:	58                   	pop    %eax
    152f:	5a                   	pop    %edx
    1530:	68 bd 42 00 00       	push   $0x42bd
    1535:	6a 01                	push   $0x1
    1537:	e8 e4 24 00 00       	call   3a20 <printf>
=======
    1532:	c7 04 24 55 42 00 00 	movl   $0x4255,(%esp)
    1539:	e8 e5 23 00 00       	call   3923 <unlink>
  printf(1, "unlinkread ok\n");
    153e:	58                   	pop    %eax
    153f:	5a                   	pop    %edx
    1540:	68 fd 42 00 00       	push   $0x42fd
    1545:	6a 01                	push   $0x1
    1547:	e8 f4 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    153c:	83 c4 10             	add    $0x10,%esp
    153f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5d                   	pop    %ebp
    1545:	c3                   	ret
    printf(1, "create unlinkread failed\n");
<<<<<<< HEAD
    1546:	51                   	push   %ecx
    1547:	51                   	push   %ecx
    1548:	68 20 42 00 00       	push   $0x4220
    154d:	6a 01                	push   $0x1
    154f:	e8 cc 24 00 00       	call   3a20 <printf>
=======
    1556:	51                   	push   %ecx
    1557:	51                   	push   %ecx
    1558:	68 60 42 00 00       	push   $0x4260
    155d:	6a 01                	push   $0x1
    155f:	e8 dc 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1554:	e8 7a 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread write failed\n");
<<<<<<< HEAD
    1559:	51                   	push   %ecx
    155a:	51                   	push   %ecx
    155b:	68 a4 42 00 00       	push   $0x42a4
    1560:	6a 01                	push   $0x1
    1562:	e8 b9 24 00 00       	call   3a20 <printf>
=======
    1569:	51                   	push   %ecx
    156a:	51                   	push   %ecx
    156b:	68 e4 42 00 00       	push   $0x42e4
    1570:	6a 01                	push   $0x1
    1572:	e8 c9 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1567:	e8 67 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread wrong data\n");
<<<<<<< HEAD
    156c:	53                   	push   %ebx
    156d:	53                   	push   %ebx
    156e:	68 8d 42 00 00       	push   $0x428d
    1573:	6a 01                	push   $0x1
    1575:	e8 a6 24 00 00       	call   3a20 <printf>
=======
    157c:	53                   	push   %ebx
    157d:	53                   	push   %ebx
    157e:	68 cd 42 00 00       	push   $0x42cd
    1583:	6a 01                	push   $0x1
    1585:	e8 b6 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    157a:	e8 54 23 00 00       	call   38d3 <exit>
    printf(1, "unlinkread read failed");
<<<<<<< HEAD
    157f:	56                   	push   %esi
    1580:	56                   	push   %esi
    1581:	68 76 42 00 00       	push   $0x4276
    1586:	6a 01                	push   $0x1
    1588:	e8 93 24 00 00       	call   3a20 <printf>
=======
    158f:	56                   	push   %esi
    1590:	56                   	push   %esi
    1591:	68 b6 42 00 00       	push   $0x42b6
    1596:	6a 01                	push   $0x1
    1598:	e8 a3 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    158d:	e8 41 23 00 00       	call   38d3 <exit>
    printf(1, "unlink unlinkread failed\n");
<<<<<<< HEAD
    1592:	50                   	push   %eax
    1593:	50                   	push   %eax
    1594:	68 58 42 00 00       	push   $0x4258
    1599:	6a 01                	push   $0x1
    159b:	e8 80 24 00 00       	call   3a20 <printf>
=======
    15a2:	50                   	push   %eax
    15a3:	50                   	push   %eax
    15a4:	68 98 42 00 00       	push   $0x4298
    15a9:	6a 01                	push   $0x1
    15ab:	e8 90 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    15a0:	e8 2e 23 00 00       	call   38d3 <exit>
    printf(1, "open unlinkread failed\n");
<<<<<<< HEAD
    15a5:	50                   	push   %eax
    15a6:	50                   	push   %eax
    15a7:	68 40 42 00 00       	push   $0x4240
    15ac:	6a 01                	push   $0x1
    15ae:	e8 6d 24 00 00       	call   3a20 <printf>
=======
    15b5:	50                   	push   %eax
    15b6:	50                   	push   %eax
    15b7:	68 80 42 00 00       	push   $0x4280
    15bc:	6a 01                	push   $0x1
    15be:	e8 7d 24 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    15b3:	e8 1b 23 00 00       	call   38d3 <exit>
    15b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    15bf:	00 

000015c0 <linktest>:
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	53                   	push   %ebx
    15c4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
<<<<<<< HEAD
    15c7:	68 cc 42 00 00       	push   $0x42cc
    15cc:	6a 01                	push   $0x1
    15ce:	e8 4d 24 00 00       	call   3a20 <printf>
  unlink("lf1");
    15d3:	c7 04 24 d6 42 00 00 	movl   $0x42d6,(%esp)
    15da:	e8 44 23 00 00       	call   3923 <unlink>
  unlink("lf2");
    15df:	c7 04 24 da 42 00 00 	movl   $0x42da,(%esp)
    15e6:	e8 38 23 00 00       	call   3923 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15eb:	58                   	pop    %eax
    15ec:	5a                   	pop    %edx
    15ed:	68 02 02 00 00       	push   $0x202
    15f2:	68 d6 42 00 00       	push   $0x42d6
    15f7:	e8 17 23 00 00       	call   3913 <open>
=======
    15d7:	68 0c 43 00 00       	push   $0x430c
    15dc:	6a 01                	push   $0x1
    15de:	e8 5d 24 00 00       	call   3a40 <printf>
  unlink("lf1");
    15e3:	c7 04 24 16 43 00 00 	movl   $0x4316,(%esp)
    15ea:	e8 34 23 00 00       	call   3923 <unlink>
  unlink("lf2");
    15ef:	c7 04 24 1a 43 00 00 	movl   $0x431a,(%esp)
    15f6:	e8 28 23 00 00       	call   3923 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15fb:	58                   	pop    %eax
    15fc:	5a                   	pop    %edx
    15fd:	68 02 02 00 00       	push   $0x202
    1602:	68 16 43 00 00       	push   $0x4316
    1607:	e8 07 23 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    15fc:	83 c4 10             	add    $0x10,%esp
    15ff:	85 c0                	test   %eax,%eax
    1601:	0f 88 1e 01 00 00    	js     1725 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
<<<<<<< HEAD
    1607:	83 ec 04             	sub    $0x4,%esp
    160a:	89 c3                	mov    %eax,%ebx
    160c:	6a 05                	push   $0x5
    160e:	68 3a 42 00 00       	push   $0x423a
    1613:	50                   	push   %eax
    1614:	e8 da 22 00 00       	call   38f3 <write>
    1619:	83 c4 10             	add    $0x10,%esp
    161c:	83 f8 05             	cmp    $0x5,%eax
    161f:	0f 85 98 01 00 00    	jne    17bd <linktest+0x1fd>
=======
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	89 c3                	mov    %eax,%ebx
    161c:	6a 05                	push   $0x5
    161e:	68 7a 42 00 00       	push   $0x427a
    1623:	50                   	push   %eax
    1624:	e8 ca 22 00 00       	call   38f3 <write>
    1629:	83 c4 10             	add    $0x10,%esp
    162c:	83 f8 05             	cmp    $0x5,%eax
    162f:	0f 85 98 01 00 00    	jne    17cd <linktest+0x1fd>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1625:	83 ec 0c             	sub    $0xc,%esp
    1628:	53                   	push   %ebx
    1629:	e8 cd 22 00 00       	call   38fb <close>
  if(link("lf1", "lf2") < 0){
<<<<<<< HEAD
    162e:	5b                   	pop    %ebx
    162f:	58                   	pop    %eax
    1630:	68 da 42 00 00       	push   $0x42da
    1635:	68 d6 42 00 00       	push   $0x42d6
    163a:	e8 f4 22 00 00       	call   3933 <link>
    163f:	83 c4 10             	add    $0x10,%esp
    1642:	85 c0                	test   %eax,%eax
    1644:	0f 88 60 01 00 00    	js     17aa <linktest+0x1ea>
  unlink("lf1");
    164a:	83 ec 0c             	sub    $0xc,%esp
    164d:	68 d6 42 00 00       	push   $0x42d6
    1652:	e8 cc 22 00 00       	call   3923 <unlink>
  if(open("lf1", 0) >= 0){
    1657:	58                   	pop    %eax
    1658:	5a                   	pop    %edx
    1659:	6a 00                	push   $0x0
    165b:	68 d6 42 00 00       	push   $0x42d6
    1660:	e8 ae 22 00 00       	call   3913 <open>
    1665:	83 c4 10             	add    $0x10,%esp
    1668:	85 c0                	test   %eax,%eax
    166a:	0f 89 27 01 00 00    	jns    1797 <linktest+0x1d7>
  fd = open("lf2", 0);
    1670:	83 ec 08             	sub    $0x8,%esp
    1673:	6a 00                	push   $0x0
    1675:	68 da 42 00 00       	push   $0x42da
    167a:	e8 94 22 00 00       	call   3913 <open>
=======
    163e:	5b                   	pop    %ebx
    163f:	58                   	pop    %eax
    1640:	68 1a 43 00 00       	push   $0x431a
    1645:	68 16 43 00 00       	push   $0x4316
    164a:	e8 e4 22 00 00       	call   3933 <link>
    164f:	83 c4 10             	add    $0x10,%esp
    1652:	85 c0                	test   %eax,%eax
    1654:	0f 88 60 01 00 00    	js     17ba <linktest+0x1ea>
  unlink("lf1");
    165a:	83 ec 0c             	sub    $0xc,%esp
    165d:	68 16 43 00 00       	push   $0x4316
    1662:	e8 bc 22 00 00       	call   3923 <unlink>
  if(open("lf1", 0) >= 0){
    1667:	58                   	pop    %eax
    1668:	5a                   	pop    %edx
    1669:	6a 00                	push   $0x0
    166b:	68 16 43 00 00       	push   $0x4316
    1670:	e8 9e 22 00 00       	call   3913 <open>
    1675:	83 c4 10             	add    $0x10,%esp
    1678:	85 c0                	test   %eax,%eax
    167a:	0f 89 27 01 00 00    	jns    17a7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1680:	83 ec 08             	sub    $0x8,%esp
    1683:	6a 00                	push   $0x0
    1685:	68 1a 43 00 00       	push   $0x431a
    168a:	e8 84 22 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    167f:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    1682:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1684:	85 c0                	test   %eax,%eax
    1686:	0f 88 f8 00 00 00    	js     1784 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
<<<<<<< HEAD
    168c:	83 ec 04             	sub    $0x4,%esp
    168f:	68 00 20 00 00       	push   $0x2000
    1694:	68 40 85 00 00       	push   $0x8540
    1699:	50                   	push   %eax
    169a:	e8 4c 22 00 00       	call   38eb <read>
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	83 f8 05             	cmp    $0x5,%eax
    16a5:	0f 85 c6 00 00 00    	jne    1771 <linktest+0x1b1>
=======
    169c:	83 ec 04             	sub    $0x4,%esp
    169f:	68 00 20 00 00       	push   $0x2000
    16a4:	68 a0 85 00 00       	push   $0x85a0
    16a9:	50                   	push   %eax
    16aa:	e8 3c 22 00 00       	call   38eb <read>
    16af:	83 c4 10             	add    $0x10,%esp
    16b2:	83 f8 05             	cmp    $0x5,%eax
    16b5:	0f 85 c6 00 00 00    	jne    1781 <linktest+0x1b1>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	53                   	push   %ebx
    16af:	e8 47 22 00 00       	call   38fb <close>
  if(link("lf2", "lf2") >= 0){
<<<<<<< HEAD
    16b4:	58                   	pop    %eax
    16b5:	5a                   	pop    %edx
    16b6:	68 da 42 00 00       	push   $0x42da
    16bb:	68 da 42 00 00       	push   $0x42da
    16c0:	e8 6e 22 00 00       	call   3933 <link>
    16c5:	83 c4 10             	add    $0x10,%esp
    16c8:	85 c0                	test   %eax,%eax
    16ca:	0f 89 8e 00 00 00    	jns    175e <linktest+0x19e>
  unlink("lf2");
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	68 da 42 00 00       	push   $0x42da
    16d8:	e8 46 22 00 00       	call   3923 <unlink>
  if(link("lf2", "lf1") >= 0){
    16dd:	59                   	pop    %ecx
    16de:	5b                   	pop    %ebx
    16df:	68 d6 42 00 00       	push   $0x42d6
    16e4:	68 da 42 00 00       	push   $0x42da
    16e9:	e8 45 22 00 00       	call   3933 <link>
    16ee:	83 c4 10             	add    $0x10,%esp
    16f1:	85 c0                	test   %eax,%eax
    16f3:	79 56                	jns    174b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    16f5:	83 ec 08             	sub    $0x8,%esp
    16f8:	68 d6 42 00 00       	push   $0x42d6
    16fd:	68 9e 45 00 00       	push   $0x459e
    1702:	e8 2c 22 00 00       	call   3933 <link>
    1707:	83 c4 10             	add    $0x10,%esp
    170a:	85 c0                	test   %eax,%eax
    170c:	79 2a                	jns    1738 <linktest+0x178>
  printf(1, "linktest ok\n");
    170e:	83 ec 08             	sub    $0x8,%esp
    1711:	68 74 43 00 00       	push   $0x4374
    1716:	6a 01                	push   $0x1
    1718:	e8 03 23 00 00       	call   3a20 <printf>
=======
    16c4:	58                   	pop    %eax
    16c5:	5a                   	pop    %edx
    16c6:	68 1a 43 00 00       	push   $0x431a
    16cb:	68 1a 43 00 00       	push   $0x431a
    16d0:	e8 5e 22 00 00       	call   3933 <link>
    16d5:	83 c4 10             	add    $0x10,%esp
    16d8:	85 c0                	test   %eax,%eax
    16da:	0f 89 8e 00 00 00    	jns    176e <linktest+0x19e>
  unlink("lf2");
    16e0:	83 ec 0c             	sub    $0xc,%esp
    16e3:	68 1a 43 00 00       	push   $0x431a
    16e8:	e8 36 22 00 00       	call   3923 <unlink>
  if(link("lf2", "lf1") >= 0){
    16ed:	59                   	pop    %ecx
    16ee:	5b                   	pop    %ebx
    16ef:	68 16 43 00 00       	push   $0x4316
    16f4:	68 1a 43 00 00       	push   $0x431a
    16f9:	e8 35 22 00 00       	call   3933 <link>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	85 c0                	test   %eax,%eax
    1703:	79 56                	jns    175b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1705:	83 ec 08             	sub    $0x8,%esp
    1708:	68 16 43 00 00       	push   $0x4316
    170d:	68 de 45 00 00       	push   $0x45de
    1712:	e8 1c 22 00 00       	call   3933 <link>
    1717:	83 c4 10             	add    $0x10,%esp
    171a:	85 c0                	test   %eax,%eax
    171c:	79 2a                	jns    1748 <linktest+0x178>
  printf(1, "linktest ok\n");
    171e:	83 ec 08             	sub    $0x8,%esp
    1721:	68 b4 43 00 00       	push   $0x43b4
    1726:	6a 01                	push   $0x1
    1728:	e8 13 23 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    171d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1720:	83 c4 10             	add    $0x10,%esp
    1723:	c9                   	leave
    1724:	c3                   	ret
    printf(1, "create lf1 failed\n");
<<<<<<< HEAD
    1725:	50                   	push   %eax
    1726:	50                   	push   %eax
    1727:	68 de 42 00 00       	push   $0x42de
    172c:	6a 01                	push   $0x1
    172e:	e8 ed 22 00 00       	call   3a20 <printf>
=======
    1735:	50                   	push   %eax
    1736:	50                   	push   %eax
    1737:	68 1e 43 00 00       	push   $0x431e
    173c:	6a 01                	push   $0x1
    173e:	e8 fd 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1733:	e8 9b 21 00 00       	call   38d3 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
<<<<<<< HEAD
    1738:	50                   	push   %eax
    1739:	50                   	push   %eax
    173a:	68 58 43 00 00       	push   $0x4358
    173f:	6a 01                	push   $0x1
    1741:	e8 da 22 00 00       	call   3a20 <printf>
=======
    1748:	50                   	push   %eax
    1749:	50                   	push   %eax
    174a:	68 98 43 00 00       	push   $0x4398
    174f:	6a 01                	push   $0x1
    1751:	e8 ea 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1746:	e8 88 21 00 00       	call   38d3 <exit>
    printf(1, "link non-existant succeeded! oops\n");
<<<<<<< HEAD
    174b:	52                   	push   %edx
    174c:	52                   	push   %edx
    174d:	68 14 4f 00 00       	push   $0x4f14
    1752:	6a 01                	push   $0x1
    1754:	e8 c7 22 00 00       	call   3a20 <printf>
=======
    175b:	52                   	push   %edx
    175c:	52                   	push   %edx
    175d:	68 4c 4f 00 00       	push   $0x4f4c
    1762:	6a 01                	push   $0x1
    1764:	e8 d7 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1759:	e8 75 21 00 00       	call   38d3 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
<<<<<<< HEAD
    175e:	50                   	push   %eax
    175f:	50                   	push   %eax
    1760:	68 3a 43 00 00       	push   $0x433a
    1765:	6a 01                	push   $0x1
    1767:	e8 b4 22 00 00       	call   3a20 <printf>
=======
    176e:	50                   	push   %eax
    176f:	50                   	push   %eax
    1770:	68 7a 43 00 00       	push   $0x437a
    1775:	6a 01                	push   $0x1
    1777:	e8 c4 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    176c:	e8 62 21 00 00       	call   38d3 <exit>
    printf(1, "read lf2 failed\n");
<<<<<<< HEAD
    1771:	51                   	push   %ecx
    1772:	51                   	push   %ecx
    1773:	68 29 43 00 00       	push   $0x4329
    1778:	6a 01                	push   $0x1
    177a:	e8 a1 22 00 00       	call   3a20 <printf>
=======
    1781:	51                   	push   %ecx
    1782:	51                   	push   %ecx
    1783:	68 69 43 00 00       	push   $0x4369
    1788:	6a 01                	push   $0x1
    178a:	e8 b1 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    177f:	e8 4f 21 00 00       	call   38d3 <exit>
    printf(1, "open lf2 failed\n");
<<<<<<< HEAD
    1784:	53                   	push   %ebx
    1785:	53                   	push   %ebx
    1786:	68 18 43 00 00       	push   $0x4318
    178b:	6a 01                	push   $0x1
    178d:	e8 8e 22 00 00       	call   3a20 <printf>
=======
    1794:	53                   	push   %ebx
    1795:	53                   	push   %ebx
    1796:	68 58 43 00 00       	push   $0x4358
    179b:	6a 01                	push   $0x1
    179d:	e8 9e 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1792:	e8 3c 21 00 00       	call   38d3 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
<<<<<<< HEAD
    1797:	50                   	push   %eax
    1798:	50                   	push   %eax
    1799:	68 ec 4e 00 00       	push   $0x4eec
    179e:	6a 01                	push   $0x1
    17a0:	e8 7b 22 00 00       	call   3a20 <printf>
=======
    17a7:	50                   	push   %eax
    17a8:	50                   	push   %eax
    17a9:	68 24 4f 00 00       	push   $0x4f24
    17ae:	6a 01                	push   $0x1
    17b0:	e8 8b 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    17a5:	e8 29 21 00 00       	call   38d3 <exit>
    printf(1, "link lf1 lf2 failed\n");
<<<<<<< HEAD
    17aa:	51                   	push   %ecx
    17ab:	51                   	push   %ecx
    17ac:	68 03 43 00 00       	push   $0x4303
    17b1:	6a 01                	push   $0x1
    17b3:	e8 68 22 00 00       	call   3a20 <printf>
=======
    17ba:	51                   	push   %ecx
    17bb:	51                   	push   %ecx
    17bc:	68 43 43 00 00       	push   $0x4343
    17c1:	6a 01                	push   $0x1
    17c3:	e8 78 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    17b8:	e8 16 21 00 00       	call   38d3 <exit>
    printf(1, "write lf1 failed\n");
<<<<<<< HEAD
    17bd:	50                   	push   %eax
    17be:	50                   	push   %eax
    17bf:	68 f1 42 00 00       	push   $0x42f1
    17c4:	6a 01                	push   $0x1
    17c6:	e8 55 22 00 00       	call   3a20 <printf>
=======
    17cd:	50                   	push   %eax
    17ce:	50                   	push   %eax
    17cf:	68 31 43 00 00       	push   $0x4331
    17d4:	6a 01                	push   $0x1
    17d6:	e8 65 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    17cb:	e8 03 21 00 00       	call   38d3 <exit>

000017d0 <concreate>:
{
    17d0:	55                   	push   %ebp
    17d1:	89 e5                	mov    %esp,%ebp
    17d3:	57                   	push   %edi
    17d4:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    17d5:	31 f6                	xor    %esi,%esi
{
    17d7:	53                   	push   %ebx
    17d8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17db:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
<<<<<<< HEAD
    17de:	68 81 43 00 00       	push   $0x4381
    17e3:	6a 01                	push   $0x1
    17e5:	e8 36 22 00 00       	call   3a20 <printf>
=======
    17ee:	68 c1 43 00 00       	push   $0x43c1
    17f3:	6a 01                	push   $0x1
    17f5:	e8 46 22 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  file[0] = 'C';
    17ea:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17ee:	83 c4 10             	add    $0x10,%esp
    17f1:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    17f5:	eb 4c                	jmp    1843 <concreate+0x73>
    17f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    17fe:	00 
    17ff:	90                   	nop
    1800:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    1806:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    180b:	0f 83 8f 00 00 00    	jae    18a0 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    1811:	83 ec 08             	sub    $0x8,%esp
    1814:	68 02 02 00 00       	push   $0x202
    1819:	53                   	push   %ebx
    181a:	e8 f4 20 00 00       	call   3913 <open>
      if(fd < 0){
    181f:	83 c4 10             	add    $0x10,%esp
    1822:	85 c0                	test   %eax,%eax
    1824:	78 63                	js     1889 <concreate+0xb9>
      close(fd);
    1826:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1829:	83 c6 01             	add    $0x1,%esi
      close(fd);
    182c:	50                   	push   %eax
    182d:	e8 c9 20 00 00       	call   38fb <close>
    1832:	83 c4 10             	add    $0x10,%esp
      wait();
    1835:	e8 a1 20 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    183a:	83 fe 28             	cmp    $0x28,%esi
    183d:	0f 84 7f 00 00 00    	je     18c2 <concreate+0xf2>
    unlink(file);
    1843:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    1846:	8d 46 30             	lea    0x30(%esi),%eax
    1849:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    184c:	53                   	push   %ebx
    184d:	e8 d1 20 00 00       	call   3923 <unlink>
    pid = fork();
    1852:	e8 74 20 00 00       	call   38cb <fork>
    if(pid && (i % 3) == 1){
    1857:	83 c4 10             	add    $0x10,%esp
    185a:	85 c0                	test   %eax,%eax
    185c:	75 a2                	jne    1800 <concreate+0x30>
      link("C0", file);
    185e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    1864:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    186a:	0f 83 d0 00 00 00    	jae    1940 <concreate+0x170>
      fd = open(file, O_CREATE | O_RDWR);
    1870:	83 ec 08             	sub    $0x8,%esp
    1873:	68 02 02 00 00       	push   $0x202
    1878:	53                   	push   %ebx
    1879:	e8 95 20 00 00       	call   3913 <open>
      if(fd < 0){
    187e:	83 c4 10             	add    $0x10,%esp
    1881:	85 c0                	test   %eax,%eax
    1883:	0f 89 ea 01 00 00    	jns    1a73 <concreate+0x2a3>
        printf(1, "concreate create %s failed\n", file);
<<<<<<< HEAD
    1889:	83 ec 04             	sub    $0x4,%esp
    188c:	53                   	push   %ebx
    188d:	68 94 43 00 00       	push   $0x4394
    1892:	6a 01                	push   $0x1
    1894:	e8 87 21 00 00       	call   3a20 <printf>
=======
    1895:	83 ec 04             	sub    $0x4,%esp
    1898:	53                   	push   %ebx
    1899:	68 d4 43 00 00       	push   $0x43d4
    189e:	6a 01                	push   $0x1
    18a0:	e8 9b 21 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
    1899:	e8 35 20 00 00       	call   38d3 <exit>
    189e:	66 90                	xchg   %ax,%ax
      link("C0", file);
<<<<<<< HEAD
    18a0:	83 ec 08             	sub    $0x8,%esp
=======
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	53                   	push   %ebx
    18b4:	68 d1 43 00 00       	push   $0x43d1
    18b9:	e8 75 20 00 00       	call   3933 <link>
    18be:	83 c4 10             	add    $0x10,%esp
      exit();
    18c1:	e8 0d 20 00 00       	call   38d3 <exit>
    18c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18cd:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    18d0:	83 ec 08             	sub    $0x8,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 40; i++){
    18a3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
<<<<<<< HEAD
    18a6:	53                   	push   %ebx
    18a7:	68 91 43 00 00       	push   $0x4391
    18ac:	e8 82 20 00 00       	call   3933 <link>
    18b1:	83 c4 10             	add    $0x10,%esp
=======
    18d6:	53                   	push   %ebx
    18d7:	68 d1 43 00 00       	push   $0x43d1
    18dc:	e8 52 20 00 00       	call   3933 <link>
    18e1:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      wait();
    18b4:	e8 22 20 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    18b9:	83 fe 28             	cmp    $0x28,%esi
    18bc:	0f 85 81 ff ff ff    	jne    1843 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    18c2:	83 ec 04             	sub    $0x4,%esp
    18c5:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18c8:	6a 28                	push   $0x28
    18ca:	6a 00                	push   $0x0
    18cc:	50                   	push   %eax
    18cd:	e8 7e 1e 00 00       	call   3750 <memset>
  fd = open(".", 0);
<<<<<<< HEAD
    18d2:	5e                   	pop    %esi
    18d3:	5f                   	pop    %edi
    18d4:	6a 00                	push   $0x0
    18d6:	68 9e 45 00 00       	push   $0x459e
    18db:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18de:	e8 30 20 00 00       	call   3913 <open>
=======
    1902:	5e                   	pop    %esi
    1903:	5f                   	pop    %edi
    1904:	6a 00                	push   $0x0
    1906:	68 de 45 00 00       	push   $0x45de
    190b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    190e:	e8 00 20 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  n = 0;
    18e3:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    18ea:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    18ed:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    18ef:	90                   	nop
    18f0:	83 ec 04             	sub    $0x4,%esp
    18f3:	6a 10                	push   $0x10
    18f5:	57                   	push   %edi
    18f6:	56                   	push   %esi
    18f7:	e8 ef 1f 00 00       	call   38eb <read>
    18fc:	83 c4 10             	add    $0x10,%esp
    18ff:	85 c0                	test   %eax,%eax
    1901:	7e 5d                	jle    1960 <concreate+0x190>
    if(de.inum == 0)
    1903:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1908:	74 e6                	je     18f0 <concreate+0x120>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    190a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    190e:	75 e0                	jne    18f0 <concreate+0x120>
    1910:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1914:	75 da                	jne    18f0 <concreate+0x120>
      i = de.name[1] - '0';
    1916:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    191a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    191d:	83 f8 27             	cmp    $0x27,%eax
    1920:	0f 87 5e 01 00 00    	ja     1a84 <concreate+0x2b4>
      if(fa[i]){
    1926:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    192b:	0f 85 7e 01 00 00    	jne    1aaf <concreate+0x2df>
      n++;
    1931:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    1935:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    193a:	eb b4                	jmp    18f0 <concreate+0x120>
    193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1940:	83 ec 08             	sub    $0x8,%esp
    1943:	53                   	push   %ebx
    1944:	68 91 43 00 00       	push   $0x4391
    1949:	e8 e5 1f 00 00       	call   3933 <link>
    194e:	83 c4 10             	add    $0x10,%esp
      exit();
    1951:	e8 7d 1f 00 00       	call   38d3 <exit>
    1956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    195d:	00 
    195e:	66 90                	xchg   %ax,%ax
  close(fd);
    1960:	83 ec 0c             	sub    $0xc,%esp
    1963:	56                   	push   %esi
    1964:	e8 92 1f 00 00       	call   38fb <close>
  if(n != 40){
    1969:	83 c4 10             	add    $0x10,%esp
    196c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1970:	0f 85 26 01 00 00    	jne    1a9c <concreate+0x2cc>
  for(i = 0; i < 40; i++){
    1976:	31 f6                	xor    %esi,%esi
    1978:	eb 48                	jmp    19c2 <concreate+0x1f2>
    197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    1980:	83 f8 01             	cmp    $0x1,%eax
    1983:	75 04                	jne    1989 <concreate+0x1b9>
    1985:	85 ff                	test   %edi,%edi
    1987:	75 68                	jne    19f1 <concreate+0x221>
      unlink(file);
    1989:	83 ec 0c             	sub    $0xc,%esp
    198c:	53                   	push   %ebx
    198d:	e8 91 1f 00 00       	call   3923 <unlink>
      unlink(file);
    1992:	89 1c 24             	mov    %ebx,(%esp)
    1995:	e8 89 1f 00 00       	call   3923 <unlink>
      unlink(file);
    199a:	89 1c 24             	mov    %ebx,(%esp)
    199d:	e8 81 1f 00 00       	call   3923 <unlink>
      unlink(file);
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 79 1f 00 00       	call   3923 <unlink>
    19aa:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19ad:	85 ff                	test   %edi,%edi
    19af:	74 a0                	je     1951 <concreate+0x181>
      wait();
    19b1:	e8 25 1f 00 00       	call   38db <wait>
  for(i = 0; i < 40; i++){
    19b6:	83 c6 01             	add    $0x1,%esi
    19b9:	83 fe 28             	cmp    $0x28,%esi
    19bc:	0f 84 86 00 00 00    	je     1a48 <concreate+0x278>
    file[1] = '0' + i;
    19c2:	8d 46 30             	lea    0x30(%esi),%eax
    19c5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19c8:	e8 fe 1e 00 00       	call   38cb <fork>
    19cd:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19cf:	85 c0                	test   %eax,%eax
    19d1:	0f 88 88 00 00 00    	js     1a5f <concreate+0x28f>
    if(((i % 3) == 0 && pid == 0) ||
    19d7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19dc:	f7 e6                	mul    %esi
    19de:	89 d0                	mov    %edx,%eax
    19e0:	83 e2 fe             	and    $0xfffffffe,%edx
    19e3:	d1 e8                	shr    $1,%eax
    19e5:	01 c2                	add    %eax,%edx
    19e7:	89 f0                	mov    %esi,%eax
    19e9:	29 d0                	sub    %edx,%eax
    19eb:	89 c1                	mov    %eax,%ecx
    19ed:	09 f9                	or     %edi,%ecx
    19ef:	75 8f                	jne    1980 <concreate+0x1b0>
      close(open(file, 0));
    19f1:	83 ec 08             	sub    $0x8,%esp
    19f4:	6a 00                	push   $0x0
    19f6:	53                   	push   %ebx
    19f7:	e8 17 1f 00 00       	call   3913 <open>
    19fc:	89 04 24             	mov    %eax,(%esp)
    19ff:	e8 f7 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a04:	58                   	pop    %eax
    1a05:	5a                   	pop    %edx
    1a06:	6a 00                	push   $0x0
    1a08:	53                   	push   %ebx
    1a09:	e8 05 1f 00 00       	call   3913 <open>
    1a0e:	89 04 24             	mov    %eax,(%esp)
    1a11:	e8 e5 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a16:	59                   	pop    %ecx
    1a17:	58                   	pop    %eax
    1a18:	6a 00                	push   $0x0
    1a1a:	53                   	push   %ebx
    1a1b:	e8 f3 1e 00 00       	call   3913 <open>
    1a20:	89 04 24             	mov    %eax,(%esp)
    1a23:	e8 d3 1e 00 00       	call   38fb <close>
      close(open(file, 0));
    1a28:	58                   	pop    %eax
    1a29:	5a                   	pop    %edx
    1a2a:	6a 00                	push   $0x0
    1a2c:	53                   	push   %ebx
    1a2d:	e8 e1 1e 00 00       	call   3913 <open>
    1a32:	89 04 24             	mov    %eax,(%esp)
    1a35:	e8 c1 1e 00 00       	call   38fb <close>
    1a3a:	83 c4 10             	add    $0x10,%esp
    1a3d:	e9 6b ff ff ff       	jmp    19ad <concreate+0x1dd>
    1a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
<<<<<<< HEAD
    1a48:	83 ec 08             	sub    $0x8,%esp
    1a4b:	68 e6 43 00 00       	push   $0x43e6
    1a50:	6a 01                	push   $0x1
    1a52:	e8 c9 1f 00 00       	call   3a20 <printf>
=======
    1a60:	83 ec 08             	sub    $0x8,%esp
    1a63:	68 26 44 00 00       	push   $0x4426
    1a68:	6a 01                	push   $0x1
    1a6a:	e8 d1 1f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    1a57:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a5a:	5b                   	pop    %ebx
    1a5b:	5e                   	pop    %esi
    1a5c:	5f                   	pop    %edi
    1a5d:	5d                   	pop    %ebp
    1a5e:	c3                   	ret
      printf(1, "fork failed\n");
<<<<<<< HEAD
    1a5f:	83 ec 08             	sub    $0x8,%esp
    1a62:	68 69 4c 00 00       	push   $0x4c69
    1a67:	6a 01                	push   $0x1
    1a69:	e8 b2 1f 00 00       	call   3a20 <printf>
      exit();
    1a6e:	e8 60 1e 00 00       	call   38d3 <exit>
      close(fd);
    1a73:	83 ec 0c             	sub    $0xc,%esp
    1a76:	50                   	push   %eax
    1a77:	e8 7f 1e 00 00       	call   38fb <close>
    1a7c:	83 c4 10             	add    $0x10,%esp
    1a7f:	e9 cd fe ff ff       	jmp    1951 <concreate+0x181>
        printf(1, "concreate weird file %s\n", de.name);
    1a84:	83 ec 04             	sub    $0x4,%esp
    1a87:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a8a:	50                   	push   %eax
    1a8b:	68 b0 43 00 00       	push   $0x43b0
    1a90:	6a 01                	push   $0x1
    1a92:	e8 89 1f 00 00       	call   3a20 <printf>
=======
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	68 a9 4c 00 00       	push   $0x4ca9
    1a7f:	6a 01                	push   $0x1
    1a81:	e8 ba 1f 00 00       	call   3a40 <printf>
      exit();
    1a86:	e8 48 1e 00 00       	call   38d3 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a8b:	51                   	push   %ecx
    1a8c:	51                   	push   %ecx
    1a8d:	68 70 4f 00 00       	push   $0x4f70
    1a92:	6a 01                	push   $0x1
    1a94:	e8 a7 1f 00 00       	call   3a40 <printf>
    exit();
    1a99:	e8 35 1e 00 00       	call   38d3 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a9e:	83 ec 04             	sub    $0x4,%esp
    1aa1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aa4:	50                   	push   %eax
    1aa5:	68 09 44 00 00       	push   $0x4409
    1aaa:	6a 01                	push   $0x1
    1aac:	e8 8f 1f 00 00       	call   3a40 <printf>
        exit();
    1ab1:	e8 1d 1e 00 00       	call   38d3 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1ab6:	83 ec 04             	sub    $0x4,%esp
    1ab9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1abc:	50                   	push   %eax
    1abd:	68 f0 43 00 00       	push   $0x43f0
    1ac2:	6a 01                	push   $0x1
    1ac4:	e8 77 1f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
    1a97:	e8 37 1e 00 00       	call   38d3 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a9c:	51                   	push   %ecx
    1a9d:	51                   	push   %ecx
    1a9e:	68 38 4f 00 00       	push   $0x4f38
    1aa3:	6a 01                	push   $0x1
    1aa5:	e8 76 1f 00 00       	call   3a20 <printf>
    exit();
    1aaa:	e8 24 1e 00 00       	call   38d3 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1aaf:	83 ec 04             	sub    $0x4,%esp
    1ab2:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ab5:	50                   	push   %eax
    1ab6:	68 c9 43 00 00       	push   $0x43c9
    1abb:	6a 01                	push   $0x1
    1abd:	e8 5e 1f 00 00       	call   3a20 <printf>
        exit();
    1ac2:	e8 0c 1e 00 00       	call   38d3 <exit>
    1ac7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1ace:	00 
    1acf:	90                   	nop

00001ad0 <linkunlink>:
{
    1ad0:	55                   	push   %ebp
    1ad1:	89 e5                	mov    %esp,%ebp
    1ad3:	57                   	push   %edi
    1ad4:	56                   	push   %esi
    1ad5:	53                   	push   %ebx
    1ad6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
<<<<<<< HEAD
    1ad9:	68 f4 43 00 00       	push   $0x43f4
    1ade:	6a 01                	push   $0x1
    1ae0:	e8 3b 1f 00 00       	call   3a20 <printf>
  unlink("x");
    1ae5:	c7 04 24 81 46 00 00 	movl   $0x4681,(%esp)
    1aec:	e8 32 1e 00 00       	call   3923 <unlink>
=======
    1ae9:	68 34 44 00 00       	push   $0x4434
    1aee:	6a 01                	push   $0x1
    1af0:	e8 4b 1f 00 00       	call   3a40 <printf>
  unlink("x");
    1af5:	c7 04 24 c1 46 00 00 	movl   $0x46c1,(%esp)
    1afc:	e8 22 1e 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  pid = fork();
    1af1:	e8 d5 1d 00 00       	call   38cb <fork>
  if(pid < 0){
    1af6:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1af9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1afc:	85 c0                	test   %eax,%eax
    1afe:	0f 88 b6 00 00 00    	js     1bba <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b04:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b08:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b0d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b12:	19 ff                	sbb    %edi,%edi
    1b14:	83 e7 60             	and    $0x60,%edi
    1b17:	83 c7 01             	add    $0x1,%edi
    1b1a:	eb 1e                	jmp    1b3a <linkunlink+0x6a>
    1b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b20:	83 f8 01             	cmp    $0x1,%eax
    1b23:	74 7b                	je     1ba0 <linkunlink+0xd0>
      unlink("x");
<<<<<<< HEAD
    1b25:	83 ec 0c             	sub    $0xc,%esp
    1b28:	68 81 46 00 00       	push   $0x4681
    1b2d:	e8 f1 1d 00 00       	call   3923 <unlink>
    1b32:	83 c4 10             	add    $0x10,%esp
=======
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	68 c1 46 00 00       	push   $0x46c1
    1b3d:	e8 e1 1d 00 00       	call   3923 <unlink>
    1b42:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 100; i++){
    1b35:	83 eb 01             	sub    $0x1,%ebx
    1b38:	74 41                	je     1b7b <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    1b3a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b40:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b46:	89 f8                	mov    %edi,%eax
    1b48:	f7 e6                	mul    %esi
    1b4a:	89 d0                	mov    %edx,%eax
    1b4c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b4f:	d1 e8                	shr    $1,%eax
    1b51:	01 c2                	add    %eax,%edx
    1b53:	89 f8                	mov    %edi,%eax
    1b55:	29 d0                	sub    %edx,%eax
    1b57:	75 c7                	jne    1b20 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
<<<<<<< HEAD
    1b59:	83 ec 08             	sub    $0x8,%esp
    1b5c:	68 02 02 00 00       	push   $0x202
    1b61:	68 81 46 00 00       	push   $0x4681
    1b66:	e8 a8 1d 00 00       	call   3913 <open>
    1b6b:	89 04 24             	mov    %eax,(%esp)
    1b6e:	e8 88 1d 00 00       	call   38fb <close>
    1b73:	83 c4 10             	add    $0x10,%esp
=======
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 02 02 00 00       	push   $0x202
    1b71:	68 c1 46 00 00       	push   $0x46c1
    1b76:	e8 98 1d 00 00       	call   3913 <open>
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 78 1d 00 00       	call   38fb <close>
    1b83:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 100; i++){
    1b76:	83 eb 01             	sub    $0x1,%ebx
    1b79:	75 bf                	jne    1b3a <linkunlink+0x6a>
  if(pid)
    1b7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7e:	85 c0                	test   %eax,%eax
    1b80:	74 4b                	je     1bcd <linkunlink+0xfd>
    wait();
    1b82:	e8 54 1d 00 00       	call   38db <wait>
  printf(1, "linkunlink ok\n");
<<<<<<< HEAD
    1b87:	83 ec 08             	sub    $0x8,%esp
    1b8a:	68 09 44 00 00       	push   $0x4409
    1b8f:	6a 01                	push   $0x1
    1b91:	e8 8a 1e 00 00       	call   3a20 <printf>
=======
    1b97:	83 ec 08             	sub    $0x8,%esp
    1b9a:	68 49 44 00 00       	push   $0x4449
    1b9f:	6a 01                	push   $0x1
    1ba1:	e8 9a 1e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    1b96:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b99:	5b                   	pop    %ebx
    1b9a:	5e                   	pop    %esi
    1b9b:	5f                   	pop    %edi
    1b9c:	5d                   	pop    %ebp
    1b9d:	c3                   	ret
    1b9e:	66 90                	xchg   %ax,%ax
      link("cat", "x");
<<<<<<< HEAD
    1ba0:	83 ec 08             	sub    $0x8,%esp
    1ba3:	68 81 46 00 00       	push   $0x4681
    1ba8:	68 05 44 00 00       	push   $0x4405
    1bad:	e8 81 1d 00 00       	call   3933 <link>
    1bb2:	83 c4 10             	add    $0x10,%esp
    1bb5:	e9 7b ff ff ff       	jmp    1b35 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bba:	52                   	push   %edx
    1bbb:	52                   	push   %edx
    1bbc:	68 69 4c 00 00       	push   $0x4c69
    1bc1:	6a 01                	push   $0x1
    1bc3:	e8 58 1e 00 00       	call   3a20 <printf>
=======
    1bb0:	83 ec 08             	sub    $0x8,%esp
    1bb3:	68 c1 46 00 00       	push   $0x46c1
    1bb8:	68 45 44 00 00       	push   $0x4445
    1bbd:	e8 71 1d 00 00       	call   3933 <link>
    1bc2:	83 c4 10             	add    $0x10,%esp
    1bc5:	e9 7b ff ff ff       	jmp    1b45 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bca:	52                   	push   %edx
    1bcb:	52                   	push   %edx
    1bcc:	68 a9 4c 00 00       	push   $0x4ca9
    1bd1:	6a 01                	push   $0x1
    1bd3:	e8 68 1e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1bc8:	e8 06 1d 00 00       	call   38d3 <exit>
    exit();
    1bcd:	e8 01 1d 00 00       	call   38d3 <exit>
    1bd2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1bd9:	00 
    1bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001be0 <bigdir>:
{
    1be0:	55                   	push   %ebp
    1be1:	89 e5                	mov    %esp,%ebp
    1be3:	57                   	push   %edi
    1be4:	56                   	push   %esi
    1be5:	53                   	push   %ebx
    1be6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
<<<<<<< HEAD
    1be9:	68 18 44 00 00       	push   $0x4418
    1bee:	6a 01                	push   $0x1
    1bf0:	e8 2b 1e 00 00       	call   3a20 <printf>
  unlink("bd");
    1bf5:	c7 04 24 25 44 00 00 	movl   $0x4425,(%esp)
    1bfc:	e8 22 1d 00 00       	call   3923 <unlink>
  fd = open("bd", O_CREATE);
    1c01:	5a                   	pop    %edx
    1c02:	59                   	pop    %ecx
    1c03:	68 00 02 00 00       	push   $0x200
    1c08:	68 25 44 00 00       	push   $0x4425
    1c0d:	e8 01 1d 00 00       	call   3913 <open>
=======
    1bf9:	68 58 44 00 00       	push   $0x4458
    1bfe:	6a 01                	push   $0x1
    1c00:	e8 3b 1e 00 00       	call   3a40 <printf>
  unlink("bd");
    1c05:	c7 04 24 65 44 00 00 	movl   $0x4465,(%esp)
    1c0c:	e8 12 1d 00 00       	call   3923 <unlink>
  fd = open("bd", O_CREATE);
    1c11:	5a                   	pop    %edx
    1c12:	59                   	pop    %ecx
    1c13:	68 00 02 00 00       	push   $0x200
    1c18:	68 65 44 00 00       	push   $0x4465
    1c1d:	e8 f1 1c 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1c12:	83 c4 10             	add    $0x10,%esp
    1c15:	85 c0                	test   %eax,%eax
    1c17:	0f 88 de 00 00 00    	js     1cfb <bigdir+0x11b>
  close(fd);
    1c1d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c20:	31 f6                	xor    %esi,%esi
    1c22:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c25:	50                   	push   %eax
    1c26:	e8 d0 1c 00 00       	call   38fb <close>
    1c2b:	83 c4 10             	add    $0x10,%esp
    1c2e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c30:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c32:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c35:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
<<<<<<< HEAD
    1c39:	c1 f8 06             	sar    $0x6,%eax
=======
    1c49:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c4c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c4d:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1c50:	68 65 44 00 00       	push   $0x4465
    name[1] = '0' + (i / 64);
    1c55:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c58:	89 f0                	mov    %esi,%eax
    1c5a:	83 e0 3f             	and    $0x3f,%eax
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    name[3] = '\0';
    1c3c:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c40:	83 c0 30             	add    $0x30,%eax
    1c43:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c46:	89 f0                	mov    %esi,%eax
    1c48:	83 e0 3f             	and    $0x3f,%eax
    1c4b:	83 c0 30             	add    $0x30,%eax
    1c4e:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c51:	57                   	push   %edi
    1c52:	68 25 44 00 00       	push   $0x4425
    1c57:	e8 d7 1c 00 00       	call   3933 <link>
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	89 c3                	mov    %eax,%ebx
    1c61:	85 c0                	test   %eax,%eax
    1c63:	75 6e                	jne    1cd3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c65:	83 c6 01             	add    $0x1,%esi
    1c68:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c6e:	75 c0                	jne    1c30 <bigdir+0x50>
  unlink("bd");
<<<<<<< HEAD
    1c70:	83 ec 0c             	sub    $0xc,%esp
    1c73:	68 25 44 00 00       	push   $0x4425
    1c78:	e8 a6 1c 00 00       	call   3923 <unlink>
    1c7d:	83 c4 10             	add    $0x10,%esp
=======
    1c80:	83 ec 0c             	sub    $0xc,%esp
    1c83:	68 65 44 00 00       	push   $0x4465
    1c88:	e8 96 1c 00 00       	call   3923 <unlink>
    1c8d:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    name[1] = '0' + (i / 64);
    1c80:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c82:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c85:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c89:	c1 f8 06             	sar    $0x6,%eax
    name[3] = '\0';
    1c8c:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c90:	83 c0 30             	add    $0x30,%eax
    1c93:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c96:	89 d8                	mov    %ebx,%eax
    1c98:	83 e0 3f             	and    $0x3f,%eax
    1c9b:	83 c0 30             	add    $0x30,%eax
    1c9e:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1ca1:	57                   	push   %edi
    1ca2:	e8 7c 1c 00 00       	call   3923 <unlink>
    1ca7:	83 c4 10             	add    $0x10,%esp
    1caa:	85 c0                	test   %eax,%eax
    1cac:	75 39                	jne    1ce7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cae:	83 c3 01             	add    $0x1,%ebx
    1cb1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cb7:	75 c7                	jne    1c80 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
<<<<<<< HEAD
    1cb9:	83 ec 08             	sub    $0x8,%esp
    1cbc:	68 67 44 00 00       	push   $0x4467
    1cc1:	6a 01                	push   $0x1
    1cc3:	e8 58 1d 00 00       	call   3a20 <printf>
    1cc8:	83 c4 10             	add    $0x10,%esp
=======
    1cc9:	83 ec 08             	sub    $0x8,%esp
    1ccc:	68 a7 44 00 00       	push   $0x44a7
    1cd1:	6a 01                	push   $0x1
    1cd3:	e8 68 1d 00 00       	call   3a40 <printf>
    1cd8:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    1ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cce:	5b                   	pop    %ebx
    1ccf:	5e                   	pop    %esi
    1cd0:	5f                   	pop    %edi
    1cd1:	5d                   	pop    %ebp
    1cd2:	c3                   	ret
      printf(1, "bigdir link failed\n");
<<<<<<< HEAD
    1cd3:	83 ec 08             	sub    $0x8,%esp
    1cd6:	68 3e 44 00 00       	push   $0x443e
    1cdb:	6a 01                	push   $0x1
    1cdd:	e8 3e 1d 00 00       	call   3a20 <printf>
=======
    1ce3:	83 ec 08             	sub    $0x8,%esp
    1ce6:	68 7e 44 00 00       	push   $0x447e
    1ceb:	6a 01                	push   $0x1
    1ced:	e8 4e 1d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    1ce2:	e8 ec 1b 00 00       	call   38d3 <exit>
      printf(1, "bigdir unlink failed");
<<<<<<< HEAD
    1ce7:	83 ec 08             	sub    $0x8,%esp
    1cea:	68 52 44 00 00       	push   $0x4452
    1cef:	6a 01                	push   $0x1
    1cf1:	e8 2a 1d 00 00       	call   3a20 <printf>
=======
    1cf7:	83 ec 08             	sub    $0x8,%esp
    1cfa:	68 92 44 00 00       	push   $0x4492
    1cff:	6a 01                	push   $0x1
    1d01:	e8 3a 1d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    1cf6:	e8 d8 1b 00 00       	call   38d3 <exit>
    printf(1, "bigdir create failed\n");
<<<<<<< HEAD
    1cfb:	50                   	push   %eax
    1cfc:	50                   	push   %eax
    1cfd:	68 28 44 00 00       	push   $0x4428
    1d02:	6a 01                	push   $0x1
    1d04:	e8 17 1d 00 00       	call   3a20 <printf>
=======
    1d0b:	50                   	push   %eax
    1d0c:	50                   	push   %eax
    1d0d:	68 68 44 00 00       	push   $0x4468
    1d12:	6a 01                	push   $0x1
    1d14:	e8 27 1d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    1d09:	e8 c5 1b 00 00       	call   38d3 <exit>
    1d0e:	66 90                	xchg   %ax,%ax

00001d10 <subdir>:
{
    1d10:	55                   	push   %ebp
    1d11:	89 e5                	mov    %esp,%ebp
    1d13:	53                   	push   %ebx
    1d14:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
<<<<<<< HEAD
    1d17:	68 72 44 00 00       	push   $0x4472
    1d1c:	6a 01                	push   $0x1
    1d1e:	e8 fd 1c 00 00       	call   3a20 <printf>
  unlink("ff");
    1d23:	c7 04 24 fb 44 00 00 	movl   $0x44fb,(%esp)
    1d2a:	e8 f4 1b 00 00       	call   3923 <unlink>
  if(mkdir("dd") != 0){
    1d2f:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d36:	e8 00 1c 00 00       	call   393b <mkdir>
    1d3b:	83 c4 10             	add    $0x10,%esp
    1d3e:	85 c0                	test   %eax,%eax
    1d40:	0f 85 b3 05 00 00    	jne    22f9 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d46:	83 ec 08             	sub    $0x8,%esp
    1d49:	68 02 02 00 00       	push   $0x202
    1d4e:	68 d1 44 00 00       	push   $0x44d1
    1d53:	e8 bb 1b 00 00       	call   3913 <open>
=======
    1d27:	68 b2 44 00 00       	push   $0x44b2
    1d2c:	6a 01                	push   $0x1
    1d2e:	e8 0d 1d 00 00       	call   3a40 <printf>
  unlink("ff");
    1d33:	c7 04 24 3b 45 00 00 	movl   $0x453b,(%esp)
    1d3a:	e8 e4 1b 00 00       	call   3923 <unlink>
  if(mkdir("dd") != 0){
    1d3f:	c7 04 24 d8 45 00 00 	movl   $0x45d8,(%esp)
    1d46:	e8 f0 1b 00 00       	call   393b <mkdir>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	85 c0                	test   %eax,%eax
    1d50:	0f 85 b3 05 00 00    	jne    2309 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 02 02 00 00       	push   $0x202
    1d5e:	68 11 45 00 00       	push   $0x4511
    1d63:	e8 ab 1b 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1d58:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d5b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d5d:	85 c0                	test   %eax,%eax
    1d5f:	0f 88 81 05 00 00    	js     22e6 <subdir+0x5d6>
  write(fd, "ff", 2);
<<<<<<< HEAD
    1d65:	83 ec 04             	sub    $0x4,%esp
    1d68:	6a 02                	push   $0x2
    1d6a:	68 fb 44 00 00       	push   $0x44fb
    1d6f:	50                   	push   %eax
    1d70:	e8 7e 1b 00 00       	call   38f3 <write>
=======
    1d75:	83 ec 04             	sub    $0x4,%esp
    1d78:	6a 02                	push   $0x2
    1d7a:	68 3b 45 00 00       	push   $0x453b
    1d7f:	50                   	push   %eax
    1d80:	e8 6e 1b 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1d75:	89 1c 24             	mov    %ebx,(%esp)
    1d78:	e8 7e 1b 00 00       	call   38fb <close>
  if(unlink("dd") >= 0){
<<<<<<< HEAD
    1d7d:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d84:	e8 9a 1b 00 00       	call   3923 <unlink>
    1d89:	83 c4 10             	add    $0x10,%esp
    1d8c:	85 c0                	test   %eax,%eax
    1d8e:	0f 89 3f 05 00 00    	jns    22d3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1d94:	83 ec 0c             	sub    $0xc,%esp
    1d97:	68 ac 44 00 00       	push   $0x44ac
    1d9c:	e8 9a 1b 00 00       	call   393b <mkdir>
    1da1:	83 c4 10             	add    $0x10,%esp
    1da4:	85 c0                	test   %eax,%eax
    1da6:	0f 85 14 05 00 00    	jne    22c0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dac:	83 ec 08             	sub    $0x8,%esp
    1daf:	68 02 02 00 00       	push   $0x202
    1db4:	68 ce 44 00 00       	push   $0x44ce
    1db9:	e8 55 1b 00 00       	call   3913 <open>
=======
    1d8d:	c7 04 24 d8 45 00 00 	movl   $0x45d8,(%esp)
    1d94:	e8 8a 1b 00 00       	call   3923 <unlink>
    1d99:	83 c4 10             	add    $0x10,%esp
    1d9c:	85 c0                	test   %eax,%eax
    1d9e:	0f 89 3f 05 00 00    	jns    22e3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1da4:	83 ec 0c             	sub    $0xc,%esp
    1da7:	68 ec 44 00 00       	push   $0x44ec
    1dac:	e8 8a 1b 00 00       	call   393b <mkdir>
    1db1:	83 c4 10             	add    $0x10,%esp
    1db4:	85 c0                	test   %eax,%eax
    1db6:	0f 85 14 05 00 00    	jne    22d0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dbc:	83 ec 08             	sub    $0x8,%esp
    1dbf:	68 02 02 00 00       	push   $0x202
    1dc4:	68 0e 45 00 00       	push   $0x450e
    1dc9:	e8 45 1b 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1dbe:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dc1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dc3:	85 c0                	test   %eax,%eax
    1dc5:	0f 88 24 04 00 00    	js     21ef <subdir+0x4df>
  write(fd, "FF", 2);
<<<<<<< HEAD
    1dcb:	83 ec 04             	sub    $0x4,%esp
    1dce:	6a 02                	push   $0x2
    1dd0:	68 ef 44 00 00       	push   $0x44ef
    1dd5:	50                   	push   %eax
    1dd6:	e8 18 1b 00 00       	call   38f3 <write>
=======
    1ddb:	83 ec 04             	sub    $0x4,%esp
    1dde:	6a 02                	push   $0x2
    1de0:	68 2f 45 00 00       	push   $0x452f
    1de5:	50                   	push   %eax
    1de6:	e8 08 1b 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1ddb:	89 1c 24             	mov    %ebx,(%esp)
    1dde:	e8 18 1b 00 00       	call   38fb <close>
  fd = open("dd/dd/../ff", 0);
<<<<<<< HEAD
    1de3:	58                   	pop    %eax
    1de4:	5a                   	pop    %edx
    1de5:	6a 00                	push   $0x0
    1de7:	68 f2 44 00 00       	push   $0x44f2
    1dec:	e8 22 1b 00 00       	call   3913 <open>
=======
    1df3:	58                   	pop    %eax
    1df4:	5a                   	pop    %edx
    1df5:	6a 00                	push   $0x0
    1df7:	68 32 45 00 00       	push   $0x4532
    1dfc:	e8 12 1b 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1df1:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1df4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1df6:	85 c0                	test   %eax,%eax
    1df8:	0f 88 de 03 00 00    	js     21dc <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
<<<<<<< HEAD
    1dfe:	83 ec 04             	sub    $0x4,%esp
    1e01:	68 00 20 00 00       	push   $0x2000
    1e06:	68 40 85 00 00       	push   $0x8540
    1e0b:	50                   	push   %eax
    1e0c:	e8 da 1a 00 00       	call   38eb <read>
  if(cc != 2 || buf[0] != 'f'){
    1e11:	83 c4 10             	add    $0x10,%esp
    1e14:	83 f8 02             	cmp    $0x2,%eax
    1e17:	0f 85 3a 03 00 00    	jne    2157 <subdir+0x447>
    1e1d:	80 3d 40 85 00 00 66 	cmpb   $0x66,0x8540
    1e24:	0f 85 2d 03 00 00    	jne    2157 <subdir+0x447>
=======
    1e0e:	83 ec 04             	sub    $0x4,%esp
    1e11:	68 00 20 00 00       	push   $0x2000
    1e16:	68 a0 85 00 00       	push   $0x85a0
    1e1b:	50                   	push   %eax
    1e1c:	e8 ca 1a 00 00       	call   38eb <read>
  if(cc != 2 || buf[0] != 'f'){
    1e21:	83 c4 10             	add    $0x10,%esp
    1e24:	83 f8 02             	cmp    $0x2,%eax
    1e27:	0f 85 3a 03 00 00    	jne    2167 <subdir+0x447>
    1e2d:	80 3d a0 85 00 00 66 	cmpb   $0x66,0x85a0
    1e34:	0f 85 2d 03 00 00    	jne    2167 <subdir+0x447>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1e2a:	83 ec 0c             	sub    $0xc,%esp
    1e2d:	53                   	push   %ebx
    1e2e:	e8 c8 1a 00 00       	call   38fb <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
<<<<<<< HEAD
    1e33:	59                   	pop    %ecx
    1e34:	5b                   	pop    %ebx
    1e35:	68 32 45 00 00       	push   $0x4532
    1e3a:	68 ce 44 00 00       	push   $0x44ce
    1e3f:	e8 ef 1a 00 00       	call   3933 <link>
    1e44:	83 c4 10             	add    $0x10,%esp
    1e47:	85 c0                	test   %eax,%eax
    1e49:	0f 85 c6 03 00 00    	jne    2215 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e4f:	83 ec 0c             	sub    $0xc,%esp
    1e52:	68 ce 44 00 00       	push   $0x44ce
    1e57:	e8 c7 1a 00 00       	call   3923 <unlink>
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	0f 85 16 03 00 00    	jne    217d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e67:	83 ec 08             	sub    $0x8,%esp
    1e6a:	6a 00                	push   $0x0
    1e6c:	68 ce 44 00 00       	push   $0x44ce
    1e71:	e8 9d 1a 00 00       	call   3913 <open>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	85 c0                	test   %eax,%eax
    1e7b:	0f 89 2c 04 00 00    	jns    22ad <subdir+0x59d>
  if(chdir("dd") != 0){
    1e81:	83 ec 0c             	sub    $0xc,%esp
    1e84:	68 98 45 00 00       	push   $0x4598
    1e89:	e8 b5 1a 00 00       	call   3943 <chdir>
    1e8e:	83 c4 10             	add    $0x10,%esp
    1e91:	85 c0                	test   %eax,%eax
    1e93:	0f 85 01 04 00 00    	jne    229a <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1e99:	83 ec 0c             	sub    $0xc,%esp
    1e9c:	68 66 45 00 00       	push   $0x4566
    1ea1:	e8 9d 1a 00 00       	call   3943 <chdir>
    1ea6:	83 c4 10             	add    $0x10,%esp
    1ea9:	85 c0                	test   %eax,%eax
    1eab:	0f 85 b9 02 00 00    	jne    216a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1eb1:	83 ec 0c             	sub    $0xc,%esp
    1eb4:	68 8c 45 00 00       	push   $0x458c
    1eb9:	e8 85 1a 00 00       	call   3943 <chdir>
    1ebe:	83 c4 10             	add    $0x10,%esp
    1ec1:	85 c0                	test   %eax,%eax
    1ec3:	0f 85 a1 02 00 00    	jne    216a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ec9:	83 ec 0c             	sub    $0xc,%esp
    1ecc:	68 9b 45 00 00       	push   $0x459b
    1ed1:	e8 6d 1a 00 00       	call   3943 <chdir>
    1ed6:	83 c4 10             	add    $0x10,%esp
    1ed9:	85 c0                	test   %eax,%eax
    1edb:	0f 85 21 03 00 00    	jne    2202 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ee1:	83 ec 08             	sub    $0x8,%esp
    1ee4:	6a 00                	push   $0x0
    1ee6:	68 32 45 00 00       	push   $0x4532
    1eeb:	e8 23 1a 00 00       	call   3913 <open>
=======
    1e43:	59                   	pop    %ecx
    1e44:	5b                   	pop    %ebx
    1e45:	68 72 45 00 00       	push   $0x4572
    1e4a:	68 0e 45 00 00       	push   $0x450e
    1e4f:	e8 df 1a 00 00       	call   3933 <link>
    1e54:	83 c4 10             	add    $0x10,%esp
    1e57:	85 c0                	test   %eax,%eax
    1e59:	0f 85 c6 03 00 00    	jne    2225 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e5f:	83 ec 0c             	sub    $0xc,%esp
    1e62:	68 0e 45 00 00       	push   $0x450e
    1e67:	e8 b7 1a 00 00       	call   3923 <unlink>
    1e6c:	83 c4 10             	add    $0x10,%esp
    1e6f:	85 c0                	test   %eax,%eax
    1e71:	0f 85 16 03 00 00    	jne    218d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e77:	83 ec 08             	sub    $0x8,%esp
    1e7a:	6a 00                	push   $0x0
    1e7c:	68 0e 45 00 00       	push   $0x450e
    1e81:	e8 8d 1a 00 00       	call   3913 <open>
    1e86:	83 c4 10             	add    $0x10,%esp
    1e89:	85 c0                	test   %eax,%eax
    1e8b:	0f 89 2c 04 00 00    	jns    22bd <subdir+0x59d>
  if(chdir("dd") != 0){
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	68 d8 45 00 00       	push   $0x45d8
    1e99:	e8 a5 1a 00 00       	call   3943 <chdir>
    1e9e:	83 c4 10             	add    $0x10,%esp
    1ea1:	85 c0                	test   %eax,%eax
    1ea3:	0f 85 01 04 00 00    	jne    22aa <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1ea9:	83 ec 0c             	sub    $0xc,%esp
    1eac:	68 a6 45 00 00       	push   $0x45a6
    1eb1:	e8 8d 1a 00 00       	call   3943 <chdir>
    1eb6:	83 c4 10             	add    $0x10,%esp
    1eb9:	85 c0                	test   %eax,%eax
    1ebb:	0f 85 b9 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	68 cc 45 00 00       	push   $0x45cc
    1ec9:	e8 75 1a 00 00       	call   3943 <chdir>
    1ece:	83 c4 10             	add    $0x10,%esp
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	0f 85 a1 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ed9:	83 ec 0c             	sub    $0xc,%esp
    1edc:	68 db 45 00 00       	push   $0x45db
    1ee1:	e8 5d 1a 00 00       	call   3943 <chdir>
    1ee6:	83 c4 10             	add    $0x10,%esp
    1ee9:	85 c0                	test   %eax,%eax
    1eeb:	0f 85 21 03 00 00    	jne    2212 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ef1:	83 ec 08             	sub    $0x8,%esp
    1ef4:	6a 00                	push   $0x0
    1ef6:	68 72 45 00 00       	push   $0x4572
    1efb:	e8 13 1a 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    1ef0:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1ef3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ef5:	85 c0                	test   %eax,%eax
    1ef7:	0f 88 e0 04 00 00    	js     23dd <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
<<<<<<< HEAD
    1efd:	83 ec 04             	sub    $0x4,%esp
    1f00:	68 00 20 00 00       	push   $0x2000
    1f05:	68 40 85 00 00       	push   $0x8540
    1f0a:	50                   	push   %eax
    1f0b:	e8 db 19 00 00       	call   38eb <read>
    1f10:	83 c4 10             	add    $0x10,%esp
    1f13:	83 f8 02             	cmp    $0x2,%eax
    1f16:	0f 85 ae 04 00 00    	jne    23ca <subdir+0x6ba>
=======
    1f0d:	83 ec 04             	sub    $0x4,%esp
    1f10:	68 00 20 00 00       	push   $0x2000
    1f15:	68 a0 85 00 00       	push   $0x85a0
    1f1a:	50                   	push   %eax
    1f1b:	e8 cb 19 00 00       	call   38eb <read>
    1f20:	83 c4 10             	add    $0x10,%esp
    1f23:	83 f8 02             	cmp    $0x2,%eax
    1f26:	0f 85 ae 04 00 00    	jne    23da <subdir+0x6ba>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    1f1c:	83 ec 0c             	sub    $0xc,%esp
    1f1f:	53                   	push   %ebx
    1f20:	e8 d6 19 00 00       	call   38fb <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
<<<<<<< HEAD
    1f25:	58                   	pop    %eax
    1f26:	5a                   	pop    %edx
    1f27:	6a 00                	push   $0x0
    1f29:	68 ce 44 00 00       	push   $0x44ce
    1f2e:	e8 e0 19 00 00       	call   3913 <open>
    1f33:	83 c4 10             	add    $0x10,%esp
    1f36:	85 c0                	test   %eax,%eax
    1f38:	0f 89 65 02 00 00    	jns    21a3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f3e:	83 ec 08             	sub    $0x8,%esp
    1f41:	68 02 02 00 00       	push   $0x202
    1f46:	68 e6 45 00 00       	push   $0x45e6
    1f4b:	e8 c3 19 00 00       	call   3913 <open>
    1f50:	83 c4 10             	add    $0x10,%esp
    1f53:	85 c0                	test   %eax,%eax
    1f55:	0f 89 35 02 00 00    	jns    2190 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f5b:	83 ec 08             	sub    $0x8,%esp
    1f5e:	68 02 02 00 00       	push   $0x202
    1f63:	68 0b 46 00 00       	push   $0x460b
    1f68:	e8 a6 19 00 00       	call   3913 <open>
    1f6d:	83 c4 10             	add    $0x10,%esp
    1f70:	85 c0                	test   %eax,%eax
    1f72:	0f 89 0f 03 00 00    	jns    2287 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f78:	83 ec 08             	sub    $0x8,%esp
    1f7b:	68 00 02 00 00       	push   $0x200
    1f80:	68 98 45 00 00       	push   $0x4598
    1f85:	e8 89 19 00 00       	call   3913 <open>
    1f8a:	83 c4 10             	add    $0x10,%esp
    1f8d:	85 c0                	test   %eax,%eax
    1f8f:	0f 89 df 02 00 00    	jns    2274 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1f95:	83 ec 08             	sub    $0x8,%esp
    1f98:	6a 02                	push   $0x2
    1f9a:	68 98 45 00 00       	push   $0x4598
    1f9f:	e8 6f 19 00 00       	call   3913 <open>
    1fa4:	83 c4 10             	add    $0x10,%esp
    1fa7:	85 c0                	test   %eax,%eax
    1fa9:	0f 89 b2 02 00 00    	jns    2261 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1faf:	83 ec 08             	sub    $0x8,%esp
    1fb2:	6a 01                	push   $0x1
    1fb4:	68 98 45 00 00       	push   $0x4598
    1fb9:	e8 55 19 00 00       	call   3913 <open>
    1fbe:	83 c4 10             	add    $0x10,%esp
    1fc1:	85 c0                	test   %eax,%eax
    1fc3:	0f 89 85 02 00 00    	jns    224e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fc9:	83 ec 08             	sub    $0x8,%esp
    1fcc:	68 7a 46 00 00       	push   $0x467a
    1fd1:	68 e6 45 00 00       	push   $0x45e6
    1fd6:	e8 58 19 00 00       	call   3933 <link>
    1fdb:	83 c4 10             	add    $0x10,%esp
    1fde:	85 c0                	test   %eax,%eax
    1fe0:	0f 84 55 02 00 00    	je     223b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1fe6:	83 ec 08             	sub    $0x8,%esp
    1fe9:	68 7a 46 00 00       	push   $0x467a
    1fee:	68 0b 46 00 00       	push   $0x460b
    1ff3:	e8 3b 19 00 00       	call   3933 <link>
    1ff8:	83 c4 10             	add    $0x10,%esp
    1ffb:	85 c0                	test   %eax,%eax
    1ffd:	0f 84 25 02 00 00    	je     2228 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2003:	83 ec 08             	sub    $0x8,%esp
    2006:	68 32 45 00 00       	push   $0x4532
    200b:	68 d1 44 00 00       	push   $0x44d1
    2010:	e8 1e 19 00 00       	call   3933 <link>
    2015:	83 c4 10             	add    $0x10,%esp
    2018:	85 c0                	test   %eax,%eax
    201a:	0f 84 a9 01 00 00    	je     21c9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2020:	83 ec 0c             	sub    $0xc,%esp
    2023:	68 e6 45 00 00       	push   $0x45e6
    2028:	e8 0e 19 00 00       	call   393b <mkdir>
    202d:	83 c4 10             	add    $0x10,%esp
    2030:	85 c0                	test   %eax,%eax
    2032:	0f 84 7e 01 00 00    	je     21b6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2038:	83 ec 0c             	sub    $0xc,%esp
    203b:	68 0b 46 00 00       	push   $0x460b
    2040:	e8 f6 18 00 00       	call   393b <mkdir>
    2045:	83 c4 10             	add    $0x10,%esp
    2048:	85 c0                	test   %eax,%eax
    204a:	0f 84 67 03 00 00    	je     23b7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2050:	83 ec 0c             	sub    $0xc,%esp
    2053:	68 32 45 00 00       	push   $0x4532
    2058:	e8 de 18 00 00       	call   393b <mkdir>
    205d:	83 c4 10             	add    $0x10,%esp
    2060:	85 c0                	test   %eax,%eax
    2062:	0f 84 3c 03 00 00    	je     23a4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2068:	83 ec 0c             	sub    $0xc,%esp
    206b:	68 0b 46 00 00       	push   $0x460b
    2070:	e8 ae 18 00 00       	call   3923 <unlink>
    2075:	83 c4 10             	add    $0x10,%esp
    2078:	85 c0                	test   %eax,%eax
    207a:	0f 84 11 03 00 00    	je     2391 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2080:	83 ec 0c             	sub    $0xc,%esp
    2083:	68 e6 45 00 00       	push   $0x45e6
    2088:	e8 96 18 00 00       	call   3923 <unlink>
    208d:	83 c4 10             	add    $0x10,%esp
    2090:	85 c0                	test   %eax,%eax
    2092:	0f 84 e6 02 00 00    	je     237e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    2098:	83 ec 0c             	sub    $0xc,%esp
    209b:	68 d1 44 00 00       	push   $0x44d1
    20a0:	e8 9e 18 00 00       	call   3943 <chdir>
    20a5:	83 c4 10             	add    $0x10,%esp
    20a8:	85 c0                	test   %eax,%eax
    20aa:	0f 84 bb 02 00 00    	je     236b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20b0:	83 ec 0c             	sub    $0xc,%esp
    20b3:	68 7d 46 00 00       	push   $0x467d
    20b8:	e8 86 18 00 00       	call   3943 <chdir>
    20bd:	83 c4 10             	add    $0x10,%esp
    20c0:	85 c0                	test   %eax,%eax
    20c2:	0f 84 90 02 00 00    	je     2358 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20c8:	83 ec 0c             	sub    $0xc,%esp
    20cb:	68 32 45 00 00       	push   $0x4532
    20d0:	e8 4e 18 00 00       	call   3923 <unlink>
    20d5:	83 c4 10             	add    $0x10,%esp
    20d8:	85 c0                	test   %eax,%eax
    20da:	0f 85 9d 00 00 00    	jne    217d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20e0:	83 ec 0c             	sub    $0xc,%esp
    20e3:	68 d1 44 00 00       	push   $0x44d1
    20e8:	e8 36 18 00 00       	call   3923 <unlink>
    20ed:	83 c4 10             	add    $0x10,%esp
    20f0:	85 c0                	test   %eax,%eax
    20f2:	0f 85 4d 02 00 00    	jne    2345 <subdir+0x635>
  if(unlink("dd") == 0){
    20f8:	83 ec 0c             	sub    $0xc,%esp
    20fb:	68 98 45 00 00       	push   $0x4598
    2100:	e8 1e 18 00 00       	call   3923 <unlink>
    2105:	83 c4 10             	add    $0x10,%esp
    2108:	85 c0                	test   %eax,%eax
    210a:	0f 84 22 02 00 00    	je     2332 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2110:	83 ec 0c             	sub    $0xc,%esp
    2113:	68 ad 44 00 00       	push   $0x44ad
    2118:	e8 06 18 00 00       	call   3923 <unlink>
    211d:	83 c4 10             	add    $0x10,%esp
    2120:	85 c0                	test   %eax,%eax
    2122:	0f 88 f7 01 00 00    	js     231f <subdir+0x60f>
  if(unlink("dd") < 0){
    2128:	83 ec 0c             	sub    $0xc,%esp
    212b:	68 98 45 00 00       	push   $0x4598
    2130:	e8 ee 17 00 00       	call   3923 <unlink>
    2135:	83 c4 10             	add    $0x10,%esp
    2138:	85 c0                	test   %eax,%eax
    213a:	0f 88 cc 01 00 00    	js     230c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2140:	83 ec 08             	sub    $0x8,%esp
    2143:	68 7a 47 00 00       	push   $0x477a
    2148:	6a 01                	push   $0x1
    214a:	e8 d1 18 00 00       	call   3a20 <printf>
=======
    1f35:	58                   	pop    %eax
    1f36:	5a                   	pop    %edx
    1f37:	6a 00                	push   $0x0
    1f39:	68 0e 45 00 00       	push   $0x450e
    1f3e:	e8 d0 19 00 00       	call   3913 <open>
    1f43:	83 c4 10             	add    $0x10,%esp
    1f46:	85 c0                	test   %eax,%eax
    1f48:	0f 89 65 02 00 00    	jns    21b3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f4e:	83 ec 08             	sub    $0x8,%esp
    1f51:	68 02 02 00 00       	push   $0x202
    1f56:	68 26 46 00 00       	push   $0x4626
    1f5b:	e8 b3 19 00 00       	call   3913 <open>
    1f60:	83 c4 10             	add    $0x10,%esp
    1f63:	85 c0                	test   %eax,%eax
    1f65:	0f 89 35 02 00 00    	jns    21a0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f6b:	83 ec 08             	sub    $0x8,%esp
    1f6e:	68 02 02 00 00       	push   $0x202
    1f73:	68 4b 46 00 00       	push   $0x464b
    1f78:	e8 96 19 00 00       	call   3913 <open>
    1f7d:	83 c4 10             	add    $0x10,%esp
    1f80:	85 c0                	test   %eax,%eax
    1f82:	0f 89 0f 03 00 00    	jns    2297 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f88:	83 ec 08             	sub    $0x8,%esp
    1f8b:	68 00 02 00 00       	push   $0x200
    1f90:	68 d8 45 00 00       	push   $0x45d8
    1f95:	e8 79 19 00 00       	call   3913 <open>
    1f9a:	83 c4 10             	add    $0x10,%esp
    1f9d:	85 c0                	test   %eax,%eax
    1f9f:	0f 89 df 02 00 00    	jns    2284 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1fa5:	83 ec 08             	sub    $0x8,%esp
    1fa8:	6a 02                	push   $0x2
    1faa:	68 d8 45 00 00       	push   $0x45d8
    1faf:	e8 5f 19 00 00       	call   3913 <open>
    1fb4:	83 c4 10             	add    $0x10,%esp
    1fb7:	85 c0                	test   %eax,%eax
    1fb9:	0f 89 b2 02 00 00    	jns    2271 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1fbf:	83 ec 08             	sub    $0x8,%esp
    1fc2:	6a 01                	push   $0x1
    1fc4:	68 d8 45 00 00       	push   $0x45d8
    1fc9:	e8 45 19 00 00       	call   3913 <open>
    1fce:	83 c4 10             	add    $0x10,%esp
    1fd1:	85 c0                	test   %eax,%eax
    1fd3:	0f 89 85 02 00 00    	jns    225e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fd9:	83 ec 08             	sub    $0x8,%esp
    1fdc:	68 ba 46 00 00       	push   $0x46ba
    1fe1:	68 26 46 00 00       	push   $0x4626
    1fe6:	e8 48 19 00 00       	call   3933 <link>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	85 c0                	test   %eax,%eax
    1ff0:	0f 84 55 02 00 00    	je     224b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1ff6:	83 ec 08             	sub    $0x8,%esp
    1ff9:	68 ba 46 00 00       	push   $0x46ba
    1ffe:	68 4b 46 00 00       	push   $0x464b
    2003:	e8 2b 19 00 00       	call   3933 <link>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	85 c0                	test   %eax,%eax
    200d:	0f 84 25 02 00 00    	je     2238 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2013:	83 ec 08             	sub    $0x8,%esp
    2016:	68 72 45 00 00       	push   $0x4572
    201b:	68 11 45 00 00       	push   $0x4511
    2020:	e8 0e 19 00 00       	call   3933 <link>
    2025:	83 c4 10             	add    $0x10,%esp
    2028:	85 c0                	test   %eax,%eax
    202a:	0f 84 a9 01 00 00    	je     21d9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2030:	83 ec 0c             	sub    $0xc,%esp
    2033:	68 26 46 00 00       	push   $0x4626
    2038:	e8 fe 18 00 00       	call   393b <mkdir>
    203d:	83 c4 10             	add    $0x10,%esp
    2040:	85 c0                	test   %eax,%eax
    2042:	0f 84 7e 01 00 00    	je     21c6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2048:	83 ec 0c             	sub    $0xc,%esp
    204b:	68 4b 46 00 00       	push   $0x464b
    2050:	e8 e6 18 00 00       	call   393b <mkdir>
    2055:	83 c4 10             	add    $0x10,%esp
    2058:	85 c0                	test   %eax,%eax
    205a:	0f 84 67 03 00 00    	je     23c7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2060:	83 ec 0c             	sub    $0xc,%esp
    2063:	68 72 45 00 00       	push   $0x4572
    2068:	e8 ce 18 00 00       	call   393b <mkdir>
    206d:	83 c4 10             	add    $0x10,%esp
    2070:	85 c0                	test   %eax,%eax
    2072:	0f 84 3c 03 00 00    	je     23b4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2078:	83 ec 0c             	sub    $0xc,%esp
    207b:	68 4b 46 00 00       	push   $0x464b
    2080:	e8 9e 18 00 00       	call   3923 <unlink>
    2085:	83 c4 10             	add    $0x10,%esp
    2088:	85 c0                	test   %eax,%eax
    208a:	0f 84 11 03 00 00    	je     23a1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2090:	83 ec 0c             	sub    $0xc,%esp
    2093:	68 26 46 00 00       	push   $0x4626
    2098:	e8 86 18 00 00       	call   3923 <unlink>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	85 c0                	test   %eax,%eax
    20a2:	0f 84 e6 02 00 00    	je     238e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    20a8:	83 ec 0c             	sub    $0xc,%esp
    20ab:	68 11 45 00 00       	push   $0x4511
    20b0:	e8 8e 18 00 00       	call   3943 <chdir>
    20b5:	83 c4 10             	add    $0x10,%esp
    20b8:	85 c0                	test   %eax,%eax
    20ba:	0f 84 bb 02 00 00    	je     237b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20c0:	83 ec 0c             	sub    $0xc,%esp
    20c3:	68 bd 46 00 00       	push   $0x46bd
    20c8:	e8 76 18 00 00       	call   3943 <chdir>
    20cd:	83 c4 10             	add    $0x10,%esp
    20d0:	85 c0                	test   %eax,%eax
    20d2:	0f 84 90 02 00 00    	je     2368 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20d8:	83 ec 0c             	sub    $0xc,%esp
    20db:	68 72 45 00 00       	push   $0x4572
    20e0:	e8 3e 18 00 00       	call   3923 <unlink>
    20e5:	83 c4 10             	add    $0x10,%esp
    20e8:	85 c0                	test   %eax,%eax
    20ea:	0f 85 9d 00 00 00    	jne    218d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20f0:	83 ec 0c             	sub    $0xc,%esp
    20f3:	68 11 45 00 00       	push   $0x4511
    20f8:	e8 26 18 00 00       	call   3923 <unlink>
    20fd:	83 c4 10             	add    $0x10,%esp
    2100:	85 c0                	test   %eax,%eax
    2102:	0f 85 4d 02 00 00    	jne    2355 <subdir+0x635>
  if(unlink("dd") == 0){
    2108:	83 ec 0c             	sub    $0xc,%esp
    210b:	68 d8 45 00 00       	push   $0x45d8
    2110:	e8 0e 18 00 00       	call   3923 <unlink>
    2115:	83 c4 10             	add    $0x10,%esp
    2118:	85 c0                	test   %eax,%eax
    211a:	0f 84 22 02 00 00    	je     2342 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2120:	83 ec 0c             	sub    $0xc,%esp
    2123:	68 ed 44 00 00       	push   $0x44ed
    2128:	e8 f6 17 00 00       	call   3923 <unlink>
    212d:	83 c4 10             	add    $0x10,%esp
    2130:	85 c0                	test   %eax,%eax
    2132:	0f 88 f7 01 00 00    	js     232f <subdir+0x60f>
  if(unlink("dd") < 0){
    2138:	83 ec 0c             	sub    $0xc,%esp
    213b:	68 d8 45 00 00       	push   $0x45d8
    2140:	e8 de 17 00 00       	call   3923 <unlink>
    2145:	83 c4 10             	add    $0x10,%esp
    2148:	85 c0                	test   %eax,%eax
    214a:	0f 88 cc 01 00 00    	js     231c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	68 ba 47 00 00       	push   $0x47ba
    2158:	6a 01                	push   $0x1
    215a:	e8 e1 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    214f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2152:	83 c4 10             	add    $0x10,%esp
    2155:	c9                   	leave
    2156:	c3                   	ret
    printf(1, "dd/dd/../ff wrong content\n");
<<<<<<< HEAD
    2157:	50                   	push   %eax
    2158:	50                   	push   %eax
    2159:	68 17 45 00 00       	push   $0x4517
    215e:	6a 01                	push   $0x1
    2160:	e8 bb 18 00 00       	call   3a20 <printf>
=======
    2167:	50                   	push   %eax
    2168:	50                   	push   %eax
    2169:	68 57 45 00 00       	push   $0x4557
    216e:	6a 01                	push   $0x1
    2170:	e8 cb 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2165:	e8 69 17 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/../../dd failed\n");
<<<<<<< HEAD
    216a:	50                   	push   %eax
    216b:	50                   	push   %eax
    216c:	68 72 45 00 00       	push   $0x4572
    2171:	6a 01                	push   $0x1
    2173:	e8 a8 18 00 00       	call   3a20 <printf>
=======
    217a:	50                   	push   %eax
    217b:	50                   	push   %eax
    217c:	68 b2 45 00 00       	push   $0x45b2
    2181:	6a 01                	push   $0x1
    2183:	e8 b8 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2178:	e8 56 17 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
<<<<<<< HEAD
    217d:	50                   	push   %eax
    217e:	50                   	push   %eax
    217f:	68 3d 45 00 00       	push   $0x453d
    2184:	6a 01                	push   $0x1
    2186:	e8 95 18 00 00       	call   3a20 <printf>
=======
    218d:	50                   	push   %eax
    218e:	50                   	push   %eax
    218f:	68 7d 45 00 00       	push   $0x457d
    2194:	6a 01                	push   $0x1
    2196:	e8 a5 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    218b:	e8 43 17 00 00       	call   38d3 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
<<<<<<< HEAD
    2190:	51                   	push   %ecx
    2191:	51                   	push   %ecx
    2192:	68 ef 45 00 00       	push   $0x45ef
    2197:	6a 01                	push   $0x1
    2199:	e8 82 18 00 00       	call   3a20 <printf>
=======
    21a0:	51                   	push   %ecx
    21a1:	51                   	push   %ecx
    21a2:	68 2f 46 00 00       	push   $0x462f
    21a7:	6a 01                	push   $0x1
    21a9:	e8 92 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    219e:	e8 30 17 00 00       	call   38d3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
<<<<<<< HEAD
    21a3:	53                   	push   %ebx
    21a4:	53                   	push   %ebx
    21a5:	68 dc 4f 00 00       	push   $0x4fdc
    21aa:	6a 01                	push   $0x1
    21ac:	e8 6f 18 00 00       	call   3a20 <printf>
=======
    21b3:	53                   	push   %ebx
    21b4:	53                   	push   %ebx
    21b5:	68 14 50 00 00       	push   $0x5014
    21ba:	6a 01                	push   $0x1
    21bc:	e8 7f 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    21b1:	e8 1d 17 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
<<<<<<< HEAD
    21b6:	51                   	push   %ecx
    21b7:	51                   	push   %ecx
    21b8:	68 83 46 00 00       	push   $0x4683
    21bd:	6a 01                	push   $0x1
    21bf:	e8 5c 18 00 00       	call   3a20 <printf>
=======
    21c6:	51                   	push   %ecx
    21c7:	51                   	push   %ecx
    21c8:	68 c3 46 00 00       	push   $0x46c3
    21cd:	6a 01                	push   $0x1
    21cf:	e8 6c 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    21c4:	e8 0a 17 00 00       	call   38d3 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
<<<<<<< HEAD
    21c9:	53                   	push   %ebx
    21ca:	53                   	push   %ebx
    21cb:	68 4c 50 00 00       	push   $0x504c
    21d0:	6a 01                	push   $0x1
    21d2:	e8 49 18 00 00       	call   3a20 <printf>
=======
    21d9:	53                   	push   %ebx
    21da:	53                   	push   %ebx
    21db:	68 84 50 00 00       	push   $0x5084
    21e0:	6a 01                	push   $0x1
    21e2:	e8 59 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    21d7:	e8 f7 16 00 00       	call   38d3 <exit>
    printf(1, "open dd/dd/../ff failed\n");
<<<<<<< HEAD
    21dc:	50                   	push   %eax
    21dd:	50                   	push   %eax
    21de:	68 fe 44 00 00       	push   $0x44fe
    21e3:	6a 01                	push   $0x1
    21e5:	e8 36 18 00 00       	call   3a20 <printf>
=======
    21ec:	50                   	push   %eax
    21ed:	50                   	push   %eax
    21ee:	68 3e 45 00 00       	push   $0x453e
    21f3:	6a 01                	push   $0x1
    21f5:	e8 46 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    21ea:	e8 e4 16 00 00       	call   38d3 <exit>
    printf(1, "create dd/dd/ff failed\n");
<<<<<<< HEAD
    21ef:	51                   	push   %ecx
    21f0:	51                   	push   %ecx
    21f1:	68 d7 44 00 00       	push   $0x44d7
    21f6:	6a 01                	push   $0x1
    21f8:	e8 23 18 00 00       	call   3a20 <printf>
=======
    21ff:	51                   	push   %ecx
    2200:	51                   	push   %ecx
    2201:	68 17 45 00 00       	push   $0x4517
    2206:	6a 01                	push   $0x1
    2208:	e8 33 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    21fd:	e8 d1 16 00 00       	call   38d3 <exit>
    printf(1, "chdir ./.. failed\n");
<<<<<<< HEAD
    2202:	50                   	push   %eax
    2203:	50                   	push   %eax
    2204:	68 a0 45 00 00       	push   $0x45a0
    2209:	6a 01                	push   $0x1
    220b:	e8 10 18 00 00       	call   3a20 <printf>
=======
    2212:	50                   	push   %eax
    2213:	50                   	push   %eax
    2214:	68 e0 45 00 00       	push   $0x45e0
    2219:	6a 01                	push   $0x1
    221b:	e8 20 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2210:	e8 be 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
<<<<<<< HEAD
    2215:	52                   	push   %edx
    2216:	52                   	push   %edx
    2217:	68 94 4f 00 00       	push   $0x4f94
    221c:	6a 01                	push   $0x1
    221e:	e8 fd 17 00 00       	call   3a20 <printf>
=======
    2225:	52                   	push   %edx
    2226:	52                   	push   %edx
    2227:	68 cc 4f 00 00       	push   $0x4fcc
    222c:	6a 01                	push   $0x1
    222e:	e8 0d 18 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2223:	e8 ab 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
<<<<<<< HEAD
    2228:	50                   	push   %eax
    2229:	50                   	push   %eax
    222a:	68 28 50 00 00       	push   $0x5028
    222f:	6a 01                	push   $0x1
    2231:	e8 ea 17 00 00       	call   3a20 <printf>
=======
    2238:	50                   	push   %eax
    2239:	50                   	push   %eax
    223a:	68 60 50 00 00       	push   $0x5060
    223f:	6a 01                	push   $0x1
    2241:	e8 fa 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2236:	e8 98 16 00 00       	call   38d3 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
<<<<<<< HEAD
    223b:	50                   	push   %eax
    223c:	50                   	push   %eax
    223d:	68 04 50 00 00       	push   $0x5004
    2242:	6a 01                	push   $0x1
    2244:	e8 d7 17 00 00       	call   3a20 <printf>
=======
    224b:	50                   	push   %eax
    224c:	50                   	push   %eax
    224d:	68 3c 50 00 00       	push   $0x503c
    2252:	6a 01                	push   $0x1
    2254:	e8 e7 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2249:	e8 85 16 00 00       	call   38d3 <exit>
    printf(1, "open dd wronly succeeded!\n");
<<<<<<< HEAD
    224e:	50                   	push   %eax
    224f:	50                   	push   %eax
    2250:	68 5f 46 00 00       	push   $0x465f
    2255:	6a 01                	push   $0x1
    2257:	e8 c4 17 00 00       	call   3a20 <printf>
=======
    225e:	50                   	push   %eax
    225f:	50                   	push   %eax
    2260:	68 9f 46 00 00       	push   $0x469f
    2265:	6a 01                	push   $0x1
    2267:	e8 d4 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    225c:	e8 72 16 00 00       	call   38d3 <exit>
    printf(1, "open dd rdwr succeeded!\n");
<<<<<<< HEAD
    2261:	50                   	push   %eax
    2262:	50                   	push   %eax
    2263:	68 46 46 00 00       	push   $0x4646
    2268:	6a 01                	push   $0x1
    226a:	e8 b1 17 00 00       	call   3a20 <printf>
=======
    2271:	50                   	push   %eax
    2272:	50                   	push   %eax
    2273:	68 86 46 00 00       	push   $0x4686
    2278:	6a 01                	push   $0x1
    227a:	e8 c1 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    226f:	e8 5f 16 00 00       	call   38d3 <exit>
    printf(1, "create dd succeeded!\n");
<<<<<<< HEAD
    2274:	50                   	push   %eax
    2275:	50                   	push   %eax
    2276:	68 30 46 00 00       	push   $0x4630
    227b:	6a 01                	push   $0x1
    227d:	e8 9e 17 00 00       	call   3a20 <printf>
=======
    2284:	50                   	push   %eax
    2285:	50                   	push   %eax
    2286:	68 70 46 00 00       	push   $0x4670
    228b:	6a 01                	push   $0x1
    228d:	e8 ae 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2282:	e8 4c 16 00 00       	call   38d3 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
<<<<<<< HEAD
    2287:	52                   	push   %edx
    2288:	52                   	push   %edx
    2289:	68 14 46 00 00       	push   $0x4614
    228e:	6a 01                	push   $0x1
    2290:	e8 8b 17 00 00       	call   3a20 <printf>
=======
    2297:	52                   	push   %edx
    2298:	52                   	push   %edx
    2299:	68 54 46 00 00       	push   $0x4654
    229e:	6a 01                	push   $0x1
    22a0:	e8 9b 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2295:	e8 39 16 00 00       	call   38d3 <exit>
    printf(1, "chdir dd failed\n");
<<<<<<< HEAD
    229a:	50                   	push   %eax
    229b:	50                   	push   %eax
    229c:	68 55 45 00 00       	push   $0x4555
    22a1:	6a 01                	push   $0x1
    22a3:	e8 78 17 00 00       	call   3a20 <printf>
=======
    22aa:	50                   	push   %eax
    22ab:	50                   	push   %eax
    22ac:	68 95 45 00 00       	push   $0x4595
    22b1:	6a 01                	push   $0x1
    22b3:	e8 88 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    22a8:	e8 26 16 00 00       	call   38d3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
<<<<<<< HEAD
    22ad:	50                   	push   %eax
    22ae:	50                   	push   %eax
    22af:	68 b8 4f 00 00       	push   $0x4fb8
    22b4:	6a 01                	push   $0x1
    22b6:	e8 65 17 00 00       	call   3a20 <printf>
=======
    22bd:	50                   	push   %eax
    22be:	50                   	push   %eax
    22bf:	68 f0 4f 00 00       	push   $0x4ff0
    22c4:	6a 01                	push   $0x1
    22c6:	e8 75 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    22bb:	e8 13 16 00 00       	call   38d3 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
<<<<<<< HEAD
    22c0:	53                   	push   %ebx
    22c1:	53                   	push   %ebx
    22c2:	68 b3 44 00 00       	push   $0x44b3
    22c7:	6a 01                	push   $0x1
    22c9:	e8 52 17 00 00       	call   3a20 <printf>
=======
    22d0:	53                   	push   %ebx
    22d1:	53                   	push   %ebx
    22d2:	68 f3 44 00 00       	push   $0x44f3
    22d7:	6a 01                	push   $0x1
    22d9:	e8 62 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    22ce:	e8 00 16 00 00       	call   38d3 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
<<<<<<< HEAD
    22d3:	50                   	push   %eax
    22d4:	50                   	push   %eax
    22d5:	68 6c 4f 00 00       	push   $0x4f6c
    22da:	6a 01                	push   $0x1
    22dc:	e8 3f 17 00 00       	call   3a20 <printf>
=======
    22e3:	50                   	push   %eax
    22e4:	50                   	push   %eax
    22e5:	68 a4 4f 00 00       	push   $0x4fa4
    22ea:	6a 01                	push   $0x1
    22ec:	e8 4f 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    22e1:	e8 ed 15 00 00       	call   38d3 <exit>
    printf(1, "create dd/ff failed\n");
<<<<<<< HEAD
    22e6:	50                   	push   %eax
    22e7:	50                   	push   %eax
    22e8:	68 97 44 00 00       	push   $0x4497
    22ed:	6a 01                	push   $0x1
    22ef:	e8 2c 17 00 00       	call   3a20 <printf>
=======
    22f6:	50                   	push   %eax
    22f7:	50                   	push   %eax
    22f8:	68 d7 44 00 00       	push   $0x44d7
    22fd:	6a 01                	push   $0x1
    22ff:	e8 3c 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    22f4:	e8 da 15 00 00       	call   38d3 <exit>
    printf(1, "subdir mkdir dd failed\n");
<<<<<<< HEAD
    22f9:	50                   	push   %eax
    22fa:	50                   	push   %eax
    22fb:	68 7f 44 00 00       	push   $0x447f
    2300:	6a 01                	push   $0x1
    2302:	e8 19 17 00 00       	call   3a20 <printf>
=======
    2309:	50                   	push   %eax
    230a:	50                   	push   %eax
    230b:	68 bf 44 00 00       	push   $0x44bf
    2310:	6a 01                	push   $0x1
    2312:	e8 29 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2307:	e8 c7 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd failed\n");
<<<<<<< HEAD
    230c:	50                   	push   %eax
    230d:	50                   	push   %eax
    230e:	68 68 47 00 00       	push   $0x4768
    2313:	6a 01                	push   $0x1
    2315:	e8 06 17 00 00       	call   3a20 <printf>
=======
    231c:	50                   	push   %eax
    231d:	50                   	push   %eax
    231e:	68 a8 47 00 00       	push   $0x47a8
    2323:	6a 01                	push   $0x1
    2325:	e8 16 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    231a:	e8 b4 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/dd failed\n");
<<<<<<< HEAD
    231f:	52                   	push   %edx
    2320:	52                   	push   %edx
    2321:	68 53 47 00 00       	push   $0x4753
    2326:	6a 01                	push   $0x1
    2328:	e8 f3 16 00 00       	call   3a20 <printf>
=======
    232f:	52                   	push   %edx
    2330:	52                   	push   %edx
    2331:	68 93 47 00 00       	push   $0x4793
    2336:	6a 01                	push   $0x1
    2338:	e8 03 17 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    232d:	e8 a1 15 00 00       	call   38d3 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
<<<<<<< HEAD
    2332:	51                   	push   %ecx
    2333:	51                   	push   %ecx
    2334:	68 70 50 00 00       	push   $0x5070
    2339:	6a 01                	push   $0x1
    233b:	e8 e0 16 00 00       	call   3a20 <printf>
=======
    2342:	51                   	push   %ecx
    2343:	51                   	push   %ecx
    2344:	68 a8 50 00 00       	push   $0x50a8
    2349:	6a 01                	push   $0x1
    234b:	e8 f0 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2340:	e8 8e 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/ff failed\n");
<<<<<<< HEAD
    2345:	53                   	push   %ebx
    2346:	53                   	push   %ebx
    2347:	68 3e 47 00 00       	push   $0x473e
    234c:	6a 01                	push   $0x1
    234e:	e8 cd 16 00 00       	call   3a20 <printf>
=======
    2355:	53                   	push   %ebx
    2356:	53                   	push   %ebx
    2357:	68 7e 47 00 00       	push   $0x477e
    235c:	6a 01                	push   $0x1
    235e:	e8 dd 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2353:	e8 7b 15 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
<<<<<<< HEAD
    2358:	50                   	push   %eax
    2359:	50                   	push   %eax
    235a:	68 26 47 00 00       	push   $0x4726
    235f:	6a 01                	push   $0x1
    2361:	e8 ba 16 00 00       	call   3a20 <printf>
=======
    2368:	50                   	push   %eax
    2369:	50                   	push   %eax
    236a:	68 66 47 00 00       	push   $0x4766
    236f:	6a 01                	push   $0x1
    2371:	e8 ca 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2366:	e8 68 15 00 00       	call   38d3 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
<<<<<<< HEAD
    236b:	50                   	push   %eax
    236c:	50                   	push   %eax
    236d:	68 0e 47 00 00       	push   $0x470e
    2372:	6a 01                	push   $0x1
    2374:	e8 a7 16 00 00       	call   3a20 <printf>
=======
    237b:	50                   	push   %eax
    237c:	50                   	push   %eax
    237d:	68 4e 47 00 00       	push   $0x474e
    2382:	6a 01                	push   $0x1
    2384:	e8 b7 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2379:	e8 55 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
<<<<<<< HEAD
    237e:	50                   	push   %eax
    237f:	50                   	push   %eax
    2380:	68 f2 46 00 00       	push   $0x46f2
    2385:	6a 01                	push   $0x1
    2387:	e8 94 16 00 00       	call   3a20 <printf>
=======
    238e:	50                   	push   %eax
    238f:	50                   	push   %eax
    2390:	68 32 47 00 00       	push   $0x4732
    2395:	6a 01                	push   $0x1
    2397:	e8 a4 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    238c:	e8 42 15 00 00       	call   38d3 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
<<<<<<< HEAD
    2391:	50                   	push   %eax
    2392:	50                   	push   %eax
    2393:	68 d6 46 00 00       	push   $0x46d6
    2398:	6a 01                	push   $0x1
    239a:	e8 81 16 00 00       	call   3a20 <printf>
=======
    23a1:	50                   	push   %eax
    23a2:	50                   	push   %eax
    23a3:	68 16 47 00 00       	push   $0x4716
    23a8:	6a 01                	push   $0x1
    23aa:	e8 91 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    239f:	e8 2f 15 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
<<<<<<< HEAD
    23a4:	50                   	push   %eax
    23a5:	50                   	push   %eax
    23a6:	68 b9 46 00 00       	push   $0x46b9
    23ab:	6a 01                	push   $0x1
    23ad:	e8 6e 16 00 00       	call   3a20 <printf>
=======
    23b4:	50                   	push   %eax
    23b5:	50                   	push   %eax
    23b6:	68 f9 46 00 00       	push   $0x46f9
    23bb:	6a 01                	push   $0x1
    23bd:	e8 7e 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    23b2:	e8 1c 15 00 00       	call   38d3 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
<<<<<<< HEAD
    23b7:	52                   	push   %edx
    23b8:	52                   	push   %edx
    23b9:	68 9e 46 00 00       	push   $0x469e
    23be:	6a 01                	push   $0x1
    23c0:	e8 5b 16 00 00       	call   3a20 <printf>
=======
    23c7:	52                   	push   %edx
    23c8:	52                   	push   %edx
    23c9:	68 de 46 00 00       	push   $0x46de
    23ce:	6a 01                	push   $0x1
    23d0:	e8 6b 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    23c5:	e8 09 15 00 00       	call   38d3 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
<<<<<<< HEAD
    23ca:	51                   	push   %ecx
    23cb:	51                   	push   %ecx
    23cc:	68 cb 45 00 00       	push   $0x45cb
    23d1:	6a 01                	push   $0x1
    23d3:	e8 48 16 00 00       	call   3a20 <printf>
=======
    23da:	51                   	push   %ecx
    23db:	51                   	push   %ecx
    23dc:	68 0b 46 00 00       	push   $0x460b
    23e1:	6a 01                	push   $0x1
    23e3:	e8 58 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    23d8:	e8 f6 14 00 00       	call   38d3 <exit>
    printf(1, "open dd/dd/ffff failed\n");
<<<<<<< HEAD
    23dd:	53                   	push   %ebx
    23de:	53                   	push   %ebx
    23df:	68 b3 45 00 00       	push   $0x45b3
    23e4:	6a 01                	push   $0x1
    23e6:	e8 35 16 00 00       	call   3a20 <printf>
=======
    23ed:	53                   	push   %ebx
    23ee:	53                   	push   %ebx
    23ef:	68 f3 45 00 00       	push   $0x45f3
    23f4:	6a 01                	push   $0x1
    23f6:	e8 45 16 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    23eb:	e8 e3 14 00 00       	call   38d3 <exit>

000023f0 <bigwrite>:
{
    23f0:	55                   	push   %ebp
    23f1:	89 e5                	mov    %esp,%ebp
    23f3:	56                   	push   %esi
    23f4:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    23f5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
<<<<<<< HEAD
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 85 47 00 00       	push   $0x4785
    2402:	6a 01                	push   $0x1
    2404:	e8 17 16 00 00       	call   3a20 <printf>
  unlink("bigwrite");
    2409:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    2410:	e8 0e 15 00 00       	call   3923 <unlink>
    2415:	83 c4 10             	add    $0x10,%esp
    2418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    241f:	00 
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2420:	83 ec 08             	sub    $0x8,%esp
    2423:	68 02 02 00 00       	push   $0x202
    2428:	68 94 47 00 00       	push   $0x4794
    242d:	e8 e1 14 00 00       	call   3913 <open>
=======
    240a:	83 ec 08             	sub    $0x8,%esp
    240d:	68 c5 47 00 00       	push   $0x47c5
    2412:	6a 01                	push   $0x1
    2414:	e8 27 16 00 00       	call   3a40 <printf>
  unlink("bigwrite");
    2419:	c7 04 24 d4 47 00 00 	movl   $0x47d4,(%esp)
    2420:	e8 fe 14 00 00       	call   3923 <unlink>
    2425:	83 c4 10             	add    $0x10,%esp
    2428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    242f:	90                   	nop
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 02 02 00 00       	push   $0x202
    2438:	68 d4 47 00 00       	push   $0x47d4
    243d:	e8 d1 14 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(fd < 0){
    2432:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2435:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2437:	85 c0                	test   %eax,%eax
    2439:	78 7e                	js     24b9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
<<<<<<< HEAD
    243b:	83 ec 04             	sub    $0x4,%esp
    243e:	53                   	push   %ebx
    243f:	68 40 85 00 00       	push   $0x8540
    2444:	50                   	push   %eax
    2445:	e8 a9 14 00 00       	call   38f3 <write>
=======
    244b:	83 ec 04             	sub    $0x4,%esp
    244e:	53                   	push   %ebx
    244f:	68 a0 85 00 00       	push   $0x85a0
    2454:	50                   	push   %eax
    2455:	e8 99 14 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      if(cc != sz){
    244a:	83 c4 10             	add    $0x10,%esp
    244d:	39 c3                	cmp    %eax,%ebx
    244f:	75 55                	jne    24a6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
<<<<<<< HEAD
    2451:	83 ec 04             	sub    $0x4,%esp
    2454:	53                   	push   %ebx
    2455:	68 40 85 00 00       	push   $0x8540
    245a:	56                   	push   %esi
    245b:	e8 93 14 00 00       	call   38f3 <write>
=======
    2461:	83 ec 04             	sub    $0x4,%esp
    2464:	53                   	push   %ebx
    2465:	68 a0 85 00 00       	push   $0x85a0
    246a:	56                   	push   %esi
    246b:	e8 83 14 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      if(cc != sz){
    2460:	83 c4 10             	add    $0x10,%esp
    2463:	39 c3                	cmp    %eax,%ebx
    2465:	75 3f                	jne    24a6 <bigwrite+0xb6>
    close(fd);
    2467:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    246a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2470:	56                   	push   %esi
    2471:	e8 85 14 00 00       	call   38fb <close>
    unlink("bigwrite");
<<<<<<< HEAD
    2476:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    247d:	e8 a1 14 00 00       	call   3923 <unlink>
=======
    2486:	c7 04 24 d4 47 00 00 	movl   $0x47d4,(%esp)
    248d:	e8 91 14 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(sz = 499; sz < 12*512; sz += 471){
    2482:	83 c4 10             	add    $0x10,%esp
    2485:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    248b:	75 93                	jne    2420 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
<<<<<<< HEAD
    248d:	83 ec 08             	sub    $0x8,%esp
    2490:	68 c7 47 00 00       	push   $0x47c7
    2495:	6a 01                	push   $0x1
    2497:	e8 84 15 00 00       	call   3a20 <printf>
=======
    249d:	83 ec 08             	sub    $0x8,%esp
    24a0:	68 07 48 00 00       	push   $0x4807
    24a5:	6a 01                	push   $0x1
    24a7:	e8 94 15 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    249c:	83 c4 10             	add    $0x10,%esp
    249f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24a2:	5b                   	pop    %ebx
    24a3:	5e                   	pop    %esi
    24a4:	5d                   	pop    %ebp
    24a5:	c3                   	ret
        printf(1, "write(%d) ret %d\n", sz, cc);
<<<<<<< HEAD
    24a6:	50                   	push   %eax
    24a7:	53                   	push   %ebx
    24a8:	68 b5 47 00 00       	push   $0x47b5
    24ad:	6a 01                	push   $0x1
    24af:	e8 6c 15 00 00       	call   3a20 <printf>
=======
    24b6:	50                   	push   %eax
    24b7:	53                   	push   %ebx
    24b8:	68 f5 47 00 00       	push   $0x47f5
    24bd:	6a 01                	push   $0x1
    24bf:	e8 7c 15 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        exit();
    24b4:	e8 1a 14 00 00       	call   38d3 <exit>
      printf(1, "cannot create bigwrite\n");
<<<<<<< HEAD
    24b9:	83 ec 08             	sub    $0x8,%esp
    24bc:	68 9d 47 00 00       	push   $0x479d
    24c1:	6a 01                	push   $0x1
    24c3:	e8 58 15 00 00       	call   3a20 <printf>
=======
    24c9:	83 ec 08             	sub    $0x8,%esp
    24cc:	68 dd 47 00 00       	push   $0x47dd
    24d1:	6a 01                	push   $0x1
    24d3:	e8 68 15 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    24c8:	e8 06 14 00 00       	call   38d3 <exit>
    24cd:	8d 76 00             	lea    0x0(%esi),%esi

000024d0 <bigfile>:
{
    24d0:	55                   	push   %ebp
    24d1:	89 e5                	mov    %esp,%ebp
    24d3:	57                   	push   %edi
    24d4:	56                   	push   %esi
    24d5:	53                   	push   %ebx
    24d6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
<<<<<<< HEAD
    24d9:	68 d4 47 00 00       	push   $0x47d4
    24de:	6a 01                	push   $0x1
    24e0:	e8 3b 15 00 00       	call   3a20 <printf>
  unlink("bigfile");
    24e5:	c7 04 24 f0 47 00 00 	movl   $0x47f0,(%esp)
    24ec:	e8 32 14 00 00       	call   3923 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    24f1:	58                   	pop    %eax
    24f2:	5a                   	pop    %edx
    24f3:	68 02 02 00 00       	push   $0x202
    24f8:	68 f0 47 00 00       	push   $0x47f0
    24fd:	e8 11 14 00 00       	call   3913 <open>
=======
    24e9:	68 14 48 00 00       	push   $0x4814
    24ee:	6a 01                	push   $0x1
    24f0:	e8 4b 15 00 00       	call   3a40 <printf>
  unlink("bigfile");
    24f5:	c7 04 24 30 48 00 00 	movl   $0x4830,(%esp)
    24fc:	e8 22 14 00 00       	call   3923 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2501:	58                   	pop    %eax
    2502:	5a                   	pop    %edx
    2503:	68 02 02 00 00       	push   $0x202
    2508:	68 30 48 00 00       	push   $0x4830
    250d:	e8 01 14 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    2502:	83 c4 10             	add    $0x10,%esp
    2505:	85 c0                	test   %eax,%eax
    2507:	0f 88 5e 01 00 00    	js     266b <bigfile+0x19b>
    250d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    250f:	31 db                	xor    %ebx,%ebx
    2511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
<<<<<<< HEAD
    2518:	83 ec 04             	sub    $0x4,%esp
    251b:	68 58 02 00 00       	push   $0x258
    2520:	53                   	push   %ebx
    2521:	68 40 85 00 00       	push   $0x8540
    2526:	e8 25 12 00 00       	call   3750 <memset>
    if(write(fd, buf, 600) != 600){
    252b:	83 c4 0c             	add    $0xc,%esp
    252e:	68 58 02 00 00       	push   $0x258
    2533:	68 40 85 00 00       	push   $0x8540
    2538:	56                   	push   %esi
    2539:	e8 b5 13 00 00       	call   38f3 <write>
    253e:	83 c4 10             	add    $0x10,%esp
    2541:	3d 58 02 00 00       	cmp    $0x258,%eax
    2546:	0f 85 f8 00 00 00    	jne    2644 <bigfile+0x174>
=======
    2528:	83 ec 04             	sub    $0x4,%esp
    252b:	68 58 02 00 00       	push   $0x258
    2530:	53                   	push   %ebx
    2531:	68 a0 85 00 00       	push   $0x85a0
    2536:	e8 05 12 00 00       	call   3740 <memset>
    if(write(fd, buf, 600) != 600){
    253b:	83 c4 0c             	add    $0xc,%esp
    253e:	68 58 02 00 00       	push   $0x258
    2543:	68 a0 85 00 00       	push   $0x85a0
    2548:	56                   	push   %esi
    2549:	e8 a5 13 00 00       	call   38f3 <write>
    254e:	83 c4 10             	add    $0x10,%esp
    2551:	3d 58 02 00 00       	cmp    $0x258,%eax
    2556:	0f 85 f8 00 00 00    	jne    2654 <bigfile+0x174>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 20; i++){
    254c:	83 c3 01             	add    $0x1,%ebx
    254f:	83 fb 14             	cmp    $0x14,%ebx
    2552:	75 c4                	jne    2518 <bigfile+0x48>
  close(fd);
    2554:	83 ec 0c             	sub    $0xc,%esp
    2557:	56                   	push   %esi
    2558:	e8 9e 13 00 00       	call   38fb <close>
  fd = open("bigfile", 0);
<<<<<<< HEAD
    255d:	5e                   	pop    %esi
    255e:	5f                   	pop    %edi
    255f:	6a 00                	push   $0x0
    2561:	68 f0 47 00 00       	push   $0x47f0
    2566:	e8 a8 13 00 00       	call   3913 <open>
=======
    256d:	5e                   	pop    %esi
    256e:	5f                   	pop    %edi
    256f:	6a 00                	push   $0x0
    2571:	68 30 48 00 00       	push   $0x4830
    2576:	e8 98 13 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    256b:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    256e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2570:	85 c0                	test   %eax,%eax
    2572:	0f 88 e0 00 00 00    	js     2658 <bigfile+0x188>
  total = 0;
    2578:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    257a:	31 ff                	xor    %edi,%edi
    257c:	eb 30                	jmp    25ae <bigfile+0xde>
    257e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2580:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2585:	0f 85 91 00 00 00    	jne    261c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
<<<<<<< HEAD
    258b:	89 fa                	mov    %edi,%edx
    258d:	0f be 05 40 85 00 00 	movsbl 0x8540,%eax
    2594:	d1 fa                	sar    $1,%edx
    2596:	39 d0                	cmp    %edx,%eax
    2598:	75 6e                	jne    2608 <bigfile+0x138>
    259a:	0f be 15 6b 86 00 00 	movsbl 0x866b,%edx
    25a1:	39 d0                	cmp    %edx,%eax
    25a3:	75 63                	jne    2608 <bigfile+0x138>
=======
    259b:	89 fa                	mov    %edi,%edx
    259d:	0f be 05 a0 85 00 00 	movsbl 0x85a0,%eax
    25a4:	d1 fa                	sar    %edx
    25a6:	39 d0                	cmp    %edx,%eax
    25a8:	75 6e                	jne    2618 <bigfile+0x138>
    25aa:	0f be 15 cb 86 00 00 	movsbl 0x86cb,%edx
    25b1:	39 d0                	cmp    %edx,%eax
    25b3:	75 63                	jne    2618 <bigfile+0x138>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    total += cc;
    25a5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25ab:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
<<<<<<< HEAD
    25ae:	83 ec 04             	sub    $0x4,%esp
    25b1:	68 2c 01 00 00       	push   $0x12c
    25b6:	68 40 85 00 00       	push   $0x8540
    25bb:	56                   	push   %esi
    25bc:	e8 2a 13 00 00       	call   38eb <read>
=======
    25be:	83 ec 04             	sub    $0x4,%esp
    25c1:	68 2c 01 00 00       	push   $0x12c
    25c6:	68 a0 85 00 00       	push   $0x85a0
    25cb:	56                   	push   %esi
    25cc:	e8 1a 13 00 00       	call   38eb <read>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(cc < 0){
    25c1:	83 c4 10             	add    $0x10,%esp
    25c4:	85 c0                	test   %eax,%eax
    25c6:	78 68                	js     2630 <bigfile+0x160>
    if(cc == 0)
    25c8:	75 b6                	jne    2580 <bigfile+0xb0>
  close(fd);
    25ca:	83 ec 0c             	sub    $0xc,%esp
    25cd:	56                   	push   %esi
    25ce:	e8 28 13 00 00       	call   38fb <close>
  if(total != 20*600){
    25d3:	83 c4 10             	add    $0x10,%esp
    25d6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25dc:	0f 85 9c 00 00 00    	jne    267e <bigfile+0x1ae>
  unlink("bigfile");
<<<<<<< HEAD
    25e2:	83 ec 0c             	sub    $0xc,%esp
    25e5:	68 f0 47 00 00       	push   $0x47f0
    25ea:	e8 34 13 00 00       	call   3923 <unlink>
  printf(1, "bigfile test ok\n");
    25ef:	58                   	pop    %eax
    25f0:	5a                   	pop    %edx
    25f1:	68 7f 48 00 00       	push   $0x487f
    25f6:	6a 01                	push   $0x1
    25f8:	e8 23 14 00 00       	call   3a20 <printf>
=======
    25f2:	83 ec 0c             	sub    $0xc,%esp
    25f5:	68 30 48 00 00       	push   $0x4830
    25fa:	e8 24 13 00 00       	call   3923 <unlink>
  printf(1, "bigfile test ok\n");
    25ff:	58                   	pop    %eax
    2600:	5a                   	pop    %edx
    2601:	68 bf 48 00 00       	push   $0x48bf
    2606:	6a 01                	push   $0x1
    2608:	e8 33 14 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2603:	5b                   	pop    %ebx
    2604:	5e                   	pop    %esi
    2605:	5f                   	pop    %edi
    2606:	5d                   	pop    %ebp
    2607:	c3                   	ret
      printf(1, "read bigfile wrong data\n");
<<<<<<< HEAD
    2608:	83 ec 08             	sub    $0x8,%esp
    260b:	68 4c 48 00 00       	push   $0x484c
    2610:	6a 01                	push   $0x1
    2612:	e8 09 14 00 00       	call   3a20 <printf>
=======
    2618:	83 ec 08             	sub    $0x8,%esp
    261b:	68 8c 48 00 00       	push   $0x488c
    2620:	6a 01                	push   $0x1
    2622:	e8 19 14 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    2617:	e8 b7 12 00 00       	call   38d3 <exit>
      printf(1, "short read bigfile\n");
<<<<<<< HEAD
    261c:	83 ec 08             	sub    $0x8,%esp
    261f:	68 38 48 00 00       	push   $0x4838
    2624:	6a 01                	push   $0x1
    2626:	e8 f5 13 00 00       	call   3a20 <printf>
=======
    262c:	83 ec 08             	sub    $0x8,%esp
    262f:	68 78 48 00 00       	push   $0x4878
    2634:	6a 01                	push   $0x1
    2636:	e8 05 14 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    262b:	e8 a3 12 00 00       	call   38d3 <exit>
      printf(1, "read bigfile failed\n");
<<<<<<< HEAD
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 23 48 00 00       	push   $0x4823
    2638:	6a 01                	push   $0x1
    263a:	e8 e1 13 00 00       	call   3a20 <printf>
=======
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 63 48 00 00       	push   $0x4863
    2648:	6a 01                	push   $0x1
    264a:	e8 f1 13 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    263f:	e8 8f 12 00 00       	call   38d3 <exit>
      printf(1, "write bigfile failed\n");
<<<<<<< HEAD
    2644:	83 ec 08             	sub    $0x8,%esp
    2647:	68 f8 47 00 00       	push   $0x47f8
    264c:	6a 01                	push   $0x1
    264e:	e8 cd 13 00 00       	call   3a20 <printf>
=======
    2654:	83 ec 08             	sub    $0x8,%esp
    2657:	68 38 48 00 00       	push   $0x4838
    265c:	6a 01                	push   $0x1
    265e:	e8 dd 13 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    2653:	e8 7b 12 00 00       	call   38d3 <exit>
    printf(1, "cannot open bigfile\n");
<<<<<<< HEAD
    2658:	53                   	push   %ebx
    2659:	53                   	push   %ebx
    265a:	68 0e 48 00 00       	push   $0x480e
    265f:	6a 01                	push   $0x1
    2661:	e8 ba 13 00 00       	call   3a20 <printf>
=======
    2668:	53                   	push   %ebx
    2669:	53                   	push   %ebx
    266a:	68 4e 48 00 00       	push   $0x484e
    266f:	6a 01                	push   $0x1
    2671:	e8 ca 13 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2666:	e8 68 12 00 00       	call   38d3 <exit>
    printf(1, "cannot create bigfile");
<<<<<<< HEAD
    266b:	50                   	push   %eax
    266c:	50                   	push   %eax
    266d:	68 e2 47 00 00       	push   $0x47e2
    2672:	6a 01                	push   $0x1
    2674:	e8 a7 13 00 00       	call   3a20 <printf>
=======
    267b:	50                   	push   %eax
    267c:	50                   	push   %eax
    267d:	68 22 48 00 00       	push   $0x4822
    2682:	6a 01                	push   $0x1
    2684:	e8 b7 13 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2679:	e8 55 12 00 00       	call   38d3 <exit>
    printf(1, "read bigfile wrong total\n");
<<<<<<< HEAD
    267e:	51                   	push   %ecx
    267f:	51                   	push   %ecx
    2680:	68 65 48 00 00       	push   $0x4865
    2685:	6a 01                	push   $0x1
    2687:	e8 94 13 00 00       	call   3a20 <printf>
=======
    268e:	51                   	push   %ecx
    268f:	51                   	push   %ecx
    2690:	68 a5 48 00 00       	push   $0x48a5
    2695:	6a 01                	push   $0x1
    2697:	e8 a4 13 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    268c:	e8 42 12 00 00       	call   38d3 <exit>
    2691:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2698:	00 
    2699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000026a0 <fourteen>:
{
    26a0:	55                   	push   %ebp
    26a1:	89 e5                	mov    %esp,%ebp
    26a3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
<<<<<<< HEAD
    26a6:	68 90 48 00 00       	push   $0x4890
    26ab:	6a 01                	push   $0x1
    26ad:	e8 6e 13 00 00       	call   3a20 <printf>
  if(mkdir("12345678901234") != 0){
    26b2:	c7 04 24 cb 48 00 00 	movl   $0x48cb,(%esp)
    26b9:	e8 7d 12 00 00       	call   393b <mkdir>
    26be:	83 c4 10             	add    $0x10,%esp
    26c1:	85 c0                	test   %eax,%eax
    26c3:	0f 85 97 00 00 00    	jne    2760 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26c9:	83 ec 0c             	sub    $0xc,%esp
    26cc:	68 90 50 00 00       	push   $0x5090
    26d1:	e8 65 12 00 00       	call   393b <mkdir>
    26d6:	83 c4 10             	add    $0x10,%esp
    26d9:	85 c0                	test   %eax,%eax
    26db:	0f 85 de 00 00 00    	jne    27bf <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26e1:	83 ec 08             	sub    $0x8,%esp
    26e4:	68 00 02 00 00       	push   $0x200
    26e9:	68 e0 50 00 00       	push   $0x50e0
    26ee:	e8 20 12 00 00       	call   3913 <open>
=======
    26b6:	68 d0 48 00 00       	push   $0x48d0
    26bb:	6a 01                	push   $0x1
    26bd:	e8 7e 13 00 00       	call   3a40 <printf>
  if(mkdir("12345678901234") != 0){
    26c2:	c7 04 24 0b 49 00 00 	movl   $0x490b,(%esp)
    26c9:	e8 6d 12 00 00       	call   393b <mkdir>
    26ce:	83 c4 10             	add    $0x10,%esp
    26d1:	85 c0                	test   %eax,%eax
    26d3:	0f 85 97 00 00 00    	jne    2770 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26d9:	83 ec 0c             	sub    $0xc,%esp
    26dc:	68 c8 50 00 00       	push   $0x50c8
    26e1:	e8 55 12 00 00       	call   393b <mkdir>
    26e6:	83 c4 10             	add    $0x10,%esp
    26e9:	85 c0                	test   %eax,%eax
    26eb:	0f 85 de 00 00 00    	jne    27cf <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26f1:	83 ec 08             	sub    $0x8,%esp
    26f4:	68 00 02 00 00       	push   $0x200
    26f9:	68 18 51 00 00       	push   $0x5118
    26fe:	e8 10 12 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    26f3:	83 c4 10             	add    $0x10,%esp
    26f6:	85 c0                	test   %eax,%eax
    26f8:	0f 88 ae 00 00 00    	js     27ac <fourteen+0x10c>
  close(fd);
    26fe:	83 ec 0c             	sub    $0xc,%esp
    2701:	50                   	push   %eax
    2702:	e8 f4 11 00 00       	call   38fb <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
<<<<<<< HEAD
    2707:	58                   	pop    %eax
    2708:	5a                   	pop    %edx
    2709:	6a 00                	push   $0x0
    270b:	68 50 51 00 00       	push   $0x5150
    2710:	e8 fe 11 00 00       	call   3913 <open>
=======
    2717:	58                   	pop    %eax
    2718:	5a                   	pop    %edx
    2719:	6a 00                	push   $0x0
    271b:	68 88 51 00 00       	push   $0x5188
    2720:	e8 ee 11 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    2715:	83 c4 10             	add    $0x10,%esp
    2718:	85 c0                	test   %eax,%eax
    271a:	78 7d                	js     2799 <fourteen+0xf9>
  close(fd);
    271c:	83 ec 0c             	sub    $0xc,%esp
    271f:	50                   	push   %eax
    2720:	e8 d6 11 00 00       	call   38fb <close>
  if(mkdir("12345678901234/12345678901234") == 0){
<<<<<<< HEAD
    2725:	c7 04 24 bc 48 00 00 	movl   $0x48bc,(%esp)
    272c:	e8 0a 12 00 00       	call   393b <mkdir>
    2731:	83 c4 10             	add    $0x10,%esp
    2734:	85 c0                	test   %eax,%eax
    2736:	74 4e                	je     2786 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2738:	83 ec 0c             	sub    $0xc,%esp
    273b:	68 ec 51 00 00       	push   $0x51ec
    2740:	e8 f6 11 00 00       	call   393b <mkdir>
    2745:	83 c4 10             	add    $0x10,%esp
    2748:	85 c0                	test   %eax,%eax
    274a:	74 27                	je     2773 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    274c:	83 ec 08             	sub    $0x8,%esp
    274f:	68 da 48 00 00       	push   $0x48da
    2754:	6a 01                	push   $0x1
    2756:	e8 c5 12 00 00       	call   3a20 <printf>
=======
    2735:	c7 04 24 fc 48 00 00 	movl   $0x48fc,(%esp)
    273c:	e8 fa 11 00 00       	call   393b <mkdir>
    2741:	83 c4 10             	add    $0x10,%esp
    2744:	85 c0                	test   %eax,%eax
    2746:	74 4e                	je     2796 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2748:	83 ec 0c             	sub    $0xc,%esp
    274b:	68 24 52 00 00       	push   $0x5224
    2750:	e8 e6 11 00 00       	call   393b <mkdir>
    2755:	83 c4 10             	add    $0x10,%esp
    2758:	85 c0                	test   %eax,%eax
    275a:	74 27                	je     2783 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    275c:	83 ec 08             	sub    $0x8,%esp
    275f:	68 1a 49 00 00       	push   $0x491a
    2764:	6a 01                	push   $0x1
    2766:	e8 d5 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    275b:	83 c4 10             	add    $0x10,%esp
    275e:	c9                   	leave
    275f:	c3                   	ret
    printf(1, "mkdir 12345678901234 failed\n");
<<<<<<< HEAD
    2760:	50                   	push   %eax
    2761:	50                   	push   %eax
    2762:	68 9f 48 00 00       	push   $0x489f
    2767:	6a 01                	push   $0x1
    2769:	e8 b2 12 00 00       	call   3a20 <printf>
=======
    2770:	50                   	push   %eax
    2771:	50                   	push   %eax
    2772:	68 df 48 00 00       	push   $0x48df
    2777:	6a 01                	push   $0x1
    2779:	e8 c2 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    276e:	e8 60 11 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
<<<<<<< HEAD
    2773:	50                   	push   %eax
    2774:	50                   	push   %eax
    2775:	68 0c 52 00 00       	push   $0x520c
    277a:	6a 01                	push   $0x1
    277c:	e8 9f 12 00 00       	call   3a20 <printf>
=======
    2783:	50                   	push   %eax
    2784:	50                   	push   %eax
    2785:	68 44 52 00 00       	push   $0x5244
    278a:	6a 01                	push   $0x1
    278c:	e8 af 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2781:	e8 4d 11 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
<<<<<<< HEAD
    2786:	52                   	push   %edx
    2787:	52                   	push   %edx
    2788:	68 bc 51 00 00       	push   $0x51bc
    278d:	6a 01                	push   $0x1
    278f:	e8 8c 12 00 00       	call   3a20 <printf>
=======
    2796:	52                   	push   %edx
    2797:	52                   	push   %edx
    2798:	68 f4 51 00 00       	push   $0x51f4
    279d:	6a 01                	push   $0x1
    279f:	e8 9c 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2794:	e8 3a 11 00 00       	call   38d3 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
<<<<<<< HEAD
    2799:	51                   	push   %ecx
    279a:	51                   	push   %ecx
    279b:	68 80 51 00 00       	push   $0x5180
    27a0:	6a 01                	push   $0x1
    27a2:	e8 79 12 00 00       	call   3a20 <printf>
=======
    27a9:	51                   	push   %ecx
    27aa:	51                   	push   %ecx
    27ab:	68 b8 51 00 00       	push   $0x51b8
    27b0:	6a 01                	push   $0x1
    27b2:	e8 89 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    27a7:	e8 27 11 00 00       	call   38d3 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
<<<<<<< HEAD
    27ac:	51                   	push   %ecx
    27ad:	51                   	push   %ecx
    27ae:	68 10 51 00 00       	push   $0x5110
    27b3:	6a 01                	push   $0x1
    27b5:	e8 66 12 00 00       	call   3a20 <printf>
=======
    27bc:	51                   	push   %ecx
    27bd:	51                   	push   %ecx
    27be:	68 48 51 00 00       	push   $0x5148
    27c3:	6a 01                	push   $0x1
    27c5:	e8 76 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    27ba:	e8 14 11 00 00       	call   38d3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
<<<<<<< HEAD
    27bf:	50                   	push   %eax
    27c0:	50                   	push   %eax
    27c1:	68 b0 50 00 00       	push   $0x50b0
    27c6:	6a 01                	push   $0x1
    27c8:	e8 53 12 00 00       	call   3a20 <printf>
=======
    27cf:	50                   	push   %eax
    27d0:	50                   	push   %eax
    27d1:	68 e8 50 00 00       	push   $0x50e8
    27d6:	6a 01                	push   $0x1
    27d8:	e8 63 12 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    27cd:	e8 01 11 00 00       	call   38d3 <exit>
    27d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    27d9:	00 
    27da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000027e0 <rmdot>:
{
    27e0:	55                   	push   %ebp
    27e1:	89 e5                	mov    %esp,%ebp
    27e3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
<<<<<<< HEAD
    27e6:	68 e7 48 00 00       	push   $0x48e7
    27eb:	6a 01                	push   $0x1
    27ed:	e8 2e 12 00 00       	call   3a20 <printf>
  if(mkdir("dots") != 0){
    27f2:	c7 04 24 f3 48 00 00 	movl   $0x48f3,(%esp)
    27f9:	e8 3d 11 00 00       	call   393b <mkdir>
    27fe:	83 c4 10             	add    $0x10,%esp
    2801:	85 c0                	test   %eax,%eax
    2803:	0f 85 b0 00 00 00    	jne    28b9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2809:	83 ec 0c             	sub    $0xc,%esp
    280c:	68 f3 48 00 00       	push   $0x48f3
    2811:	e8 2d 11 00 00       	call   3943 <chdir>
    2816:	83 c4 10             	add    $0x10,%esp
    2819:	85 c0                	test   %eax,%eax
    281b:	0f 85 1d 01 00 00    	jne    293e <rmdot+0x15e>
  if(unlink(".") == 0){
    2821:	83 ec 0c             	sub    $0xc,%esp
    2824:	68 9e 45 00 00       	push   $0x459e
    2829:	e8 f5 10 00 00       	call   3923 <unlink>
    282e:	83 c4 10             	add    $0x10,%esp
    2831:	85 c0                	test   %eax,%eax
    2833:	0f 84 f2 00 00 00    	je     292b <rmdot+0x14b>
  if(unlink("..") == 0){
    2839:	83 ec 0c             	sub    $0xc,%esp
    283c:	68 9d 45 00 00       	push   $0x459d
    2841:	e8 dd 10 00 00       	call   3923 <unlink>
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	85 c0                	test   %eax,%eax
    284b:	0f 84 c7 00 00 00    	je     2918 <rmdot+0x138>
  if(chdir("/") != 0){
    2851:	83 ec 0c             	sub    $0xc,%esp
    2854:	68 71 3d 00 00       	push   $0x3d71
    2859:	e8 e5 10 00 00       	call   3943 <chdir>
    285e:	83 c4 10             	add    $0x10,%esp
    2861:	85 c0                	test   %eax,%eax
    2863:	0f 85 9c 00 00 00    	jne    2905 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2869:	83 ec 0c             	sub    $0xc,%esp
    286c:	68 3b 49 00 00       	push   $0x493b
    2871:	e8 ad 10 00 00       	call   3923 <unlink>
    2876:	83 c4 10             	add    $0x10,%esp
    2879:	85 c0                	test   %eax,%eax
    287b:	74 75                	je     28f2 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    287d:	83 ec 0c             	sub    $0xc,%esp
    2880:	68 59 49 00 00       	push   $0x4959
    2885:	e8 99 10 00 00       	call   3923 <unlink>
    288a:	83 c4 10             	add    $0x10,%esp
    288d:	85 c0                	test   %eax,%eax
    288f:	74 4e                	je     28df <rmdot+0xff>
  if(unlink("dots") != 0){
    2891:	83 ec 0c             	sub    $0xc,%esp
    2894:	68 f3 48 00 00       	push   $0x48f3
    2899:	e8 85 10 00 00       	call   3923 <unlink>
    289e:	83 c4 10             	add    $0x10,%esp
    28a1:	85 c0                	test   %eax,%eax
    28a3:	75 27                	jne    28cc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28a5:	83 ec 08             	sub    $0x8,%esp
    28a8:	68 8e 49 00 00       	push   $0x498e
    28ad:	6a 01                	push   $0x1
    28af:	e8 6c 11 00 00       	call   3a20 <printf>
=======
    27f6:	68 27 49 00 00       	push   $0x4927
    27fb:	6a 01                	push   $0x1
    27fd:	e8 3e 12 00 00       	call   3a40 <printf>
  if(mkdir("dots") != 0){
    2802:	c7 04 24 33 49 00 00 	movl   $0x4933,(%esp)
    2809:	e8 2d 11 00 00       	call   393b <mkdir>
    280e:	83 c4 10             	add    $0x10,%esp
    2811:	85 c0                	test   %eax,%eax
    2813:	0f 85 b0 00 00 00    	jne    28c9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2819:	83 ec 0c             	sub    $0xc,%esp
    281c:	68 33 49 00 00       	push   $0x4933
    2821:	e8 1d 11 00 00       	call   3943 <chdir>
    2826:	83 c4 10             	add    $0x10,%esp
    2829:	85 c0                	test   %eax,%eax
    282b:	0f 85 1d 01 00 00    	jne    294e <rmdot+0x15e>
  if(unlink(".") == 0){
    2831:	83 ec 0c             	sub    $0xc,%esp
    2834:	68 de 45 00 00       	push   $0x45de
    2839:	e8 e5 10 00 00       	call   3923 <unlink>
    283e:	83 c4 10             	add    $0x10,%esp
    2841:	85 c0                	test   %eax,%eax
    2843:	0f 84 f2 00 00 00    	je     293b <rmdot+0x14b>
  if(unlink("..") == 0){
    2849:	83 ec 0c             	sub    $0xc,%esp
    284c:	68 dd 45 00 00       	push   $0x45dd
    2851:	e8 cd 10 00 00       	call   3923 <unlink>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	0f 84 c7 00 00 00    	je     2928 <rmdot+0x138>
  if(chdir("/") != 0){
    2861:	83 ec 0c             	sub    $0xc,%esp
    2864:	68 b1 3d 00 00       	push   $0x3db1
    2869:	e8 d5 10 00 00       	call   3943 <chdir>
    286e:	83 c4 10             	add    $0x10,%esp
    2871:	85 c0                	test   %eax,%eax
    2873:	0f 85 9c 00 00 00    	jne    2915 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2879:	83 ec 0c             	sub    $0xc,%esp
    287c:	68 7b 49 00 00       	push   $0x497b
    2881:	e8 9d 10 00 00       	call   3923 <unlink>
    2886:	83 c4 10             	add    $0x10,%esp
    2889:	85 c0                	test   %eax,%eax
    288b:	74 75                	je     2902 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    288d:	83 ec 0c             	sub    $0xc,%esp
    2890:	68 99 49 00 00       	push   $0x4999
    2895:	e8 89 10 00 00       	call   3923 <unlink>
    289a:	83 c4 10             	add    $0x10,%esp
    289d:	85 c0                	test   %eax,%eax
    289f:	74 4e                	je     28ef <rmdot+0xff>
  if(unlink("dots") != 0){
    28a1:	83 ec 0c             	sub    $0xc,%esp
    28a4:	68 33 49 00 00       	push   $0x4933
    28a9:	e8 75 10 00 00       	call   3923 <unlink>
    28ae:	83 c4 10             	add    $0x10,%esp
    28b1:	85 c0                	test   %eax,%eax
    28b3:	75 27                	jne    28dc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28b5:	83 ec 08             	sub    $0x8,%esp
    28b8:	68 ce 49 00 00       	push   $0x49ce
    28bd:	6a 01                	push   $0x1
    28bf:	e8 7c 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    28b4:	83 c4 10             	add    $0x10,%esp
    28b7:	c9                   	leave
    28b8:	c3                   	ret
    printf(1, "mkdir dots failed\n");
<<<<<<< HEAD
    28b9:	50                   	push   %eax
    28ba:	50                   	push   %eax
    28bb:	68 f8 48 00 00       	push   $0x48f8
    28c0:	6a 01                	push   $0x1
    28c2:	e8 59 11 00 00       	call   3a20 <printf>
=======
    28c9:	50                   	push   %eax
    28ca:	50                   	push   %eax
    28cb:	68 38 49 00 00       	push   $0x4938
    28d0:	6a 01                	push   $0x1
    28d2:	e8 69 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    28c7:	e8 07 10 00 00       	call   38d3 <exit>
    printf(1, "unlink dots failed!\n");
<<<<<<< HEAD
    28cc:	50                   	push   %eax
    28cd:	50                   	push   %eax
    28ce:	68 79 49 00 00       	push   $0x4979
    28d3:	6a 01                	push   $0x1
    28d5:	e8 46 11 00 00       	call   3a20 <printf>
=======
    28dc:	50                   	push   %eax
    28dd:	50                   	push   %eax
    28de:	68 b9 49 00 00       	push   $0x49b9
    28e3:	6a 01                	push   $0x1
    28e5:	e8 56 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    28da:	e8 f4 0f 00 00       	call   38d3 <exit>
    printf(1, "unlink dots/.. worked!\n");
<<<<<<< HEAD
    28df:	52                   	push   %edx
    28e0:	52                   	push   %edx
    28e1:	68 61 49 00 00       	push   $0x4961
    28e6:	6a 01                	push   $0x1
    28e8:	e8 33 11 00 00       	call   3a20 <printf>
=======
    28ef:	52                   	push   %edx
    28f0:	52                   	push   %edx
    28f1:	68 a1 49 00 00       	push   $0x49a1
    28f6:	6a 01                	push   $0x1
    28f8:	e8 43 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    28ed:	e8 e1 0f 00 00       	call   38d3 <exit>
    printf(1, "unlink dots/. worked!\n");
<<<<<<< HEAD
    28f2:	51                   	push   %ecx
    28f3:	51                   	push   %ecx
    28f4:	68 42 49 00 00       	push   $0x4942
    28f9:	6a 01                	push   $0x1
    28fb:	e8 20 11 00 00       	call   3a20 <printf>
=======
    2902:	51                   	push   %ecx
    2903:	51                   	push   %ecx
    2904:	68 82 49 00 00       	push   $0x4982
    2909:	6a 01                	push   $0x1
    290b:	e8 30 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2900:	e8 ce 0f 00 00       	call   38d3 <exit>
    printf(1, "chdir / failed\n");
<<<<<<< HEAD
    2905:	50                   	push   %eax
    2906:	50                   	push   %eax
    2907:	68 73 3d 00 00       	push   $0x3d73
    290c:	6a 01                	push   $0x1
    290e:	e8 0d 11 00 00       	call   3a20 <printf>
=======
    2915:	50                   	push   %eax
    2916:	50                   	push   %eax
    2917:	68 b3 3d 00 00       	push   $0x3db3
    291c:	6a 01                	push   $0x1
    291e:	e8 1d 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2913:	e8 bb 0f 00 00       	call   38d3 <exit>
    printf(1, "rm .. worked!\n");
<<<<<<< HEAD
    2918:	50                   	push   %eax
    2919:	50                   	push   %eax
    291a:	68 2c 49 00 00       	push   $0x492c
    291f:	6a 01                	push   $0x1
    2921:	e8 fa 10 00 00       	call   3a20 <printf>
=======
    2928:	50                   	push   %eax
    2929:	50                   	push   %eax
    292a:	68 6c 49 00 00       	push   $0x496c
    292f:	6a 01                	push   $0x1
    2931:	e8 0a 11 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2926:	e8 a8 0f 00 00       	call   38d3 <exit>
    printf(1, "rm . worked!\n");
<<<<<<< HEAD
    292b:	50                   	push   %eax
    292c:	50                   	push   %eax
    292d:	68 1e 49 00 00       	push   $0x491e
    2932:	6a 01                	push   $0x1
    2934:	e8 e7 10 00 00       	call   3a20 <printf>
=======
    293b:	50                   	push   %eax
    293c:	50                   	push   %eax
    293d:	68 5e 49 00 00       	push   $0x495e
    2942:	6a 01                	push   $0x1
    2944:	e8 f7 10 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2939:	e8 95 0f 00 00       	call   38d3 <exit>
    printf(1, "chdir dots failed\n");
<<<<<<< HEAD
    293e:	50                   	push   %eax
    293f:	50                   	push   %eax
    2940:	68 0b 49 00 00       	push   $0x490b
    2945:	6a 01                	push   $0x1
    2947:	e8 d4 10 00 00       	call   3a20 <printf>
=======
    294e:	50                   	push   %eax
    294f:	50                   	push   %eax
    2950:	68 4b 49 00 00       	push   $0x494b
    2955:	6a 01                	push   $0x1
    2957:	e8 e4 10 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    294c:	e8 82 0f 00 00       	call   38d3 <exit>
    2951:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2958:	00 
    2959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002960 <dirfile>:
{
    2960:	55                   	push   %ebp
    2961:	89 e5                	mov    %esp,%ebp
    2963:	53                   	push   %ebx
    2964:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
<<<<<<< HEAD
    2967:	68 98 49 00 00       	push   $0x4998
    296c:	6a 01                	push   $0x1
    296e:	e8 ad 10 00 00       	call   3a20 <printf>
  fd = open("dirfile", O_CREATE);
    2973:	5b                   	pop    %ebx
    2974:	58                   	pop    %eax
    2975:	68 00 02 00 00       	push   $0x200
    297a:	68 a5 49 00 00       	push   $0x49a5
    297f:	e8 8f 0f 00 00       	call   3913 <open>
=======
    2977:	68 d8 49 00 00       	push   $0x49d8
    297c:	6a 01                	push   $0x1
    297e:	e8 bd 10 00 00       	call   3a40 <printf>
  fd = open("dirfile", O_CREATE);
    2983:	5b                   	pop    %ebx
    2984:	58                   	pop    %eax
    2985:	68 00 02 00 00       	push   $0x200
    298a:	68 e5 49 00 00       	push   $0x49e5
    298f:	e8 7f 0f 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    2984:	83 c4 10             	add    $0x10,%esp
    2987:	85 c0                	test   %eax,%eax
    2989:	0f 88 43 01 00 00    	js     2ad2 <dirfile+0x172>
  close(fd);
    298f:	83 ec 0c             	sub    $0xc,%esp
    2992:	50                   	push   %eax
    2993:	e8 63 0f 00 00       	call   38fb <close>
  if(chdir("dirfile") == 0){
<<<<<<< HEAD
    2998:	c7 04 24 a5 49 00 00 	movl   $0x49a5,(%esp)
    299f:	e8 9f 0f 00 00       	call   3943 <chdir>
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 84 10 01 00 00    	je     2abf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29af:	83 ec 08             	sub    $0x8,%esp
    29b2:	6a 00                	push   $0x0
    29b4:	68 de 49 00 00       	push   $0x49de
    29b9:	e8 55 0f 00 00       	call   3913 <open>
=======
    29a8:	c7 04 24 e5 49 00 00 	movl   $0x49e5,(%esp)
    29af:	e8 8f 0f 00 00       	call   3943 <chdir>
    29b4:	83 c4 10             	add    $0x10,%esp
    29b7:	85 c0                	test   %eax,%eax
    29b9:	0f 84 10 01 00 00    	je     2acf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29bf:	83 ec 08             	sub    $0x8,%esp
    29c2:	6a 00                	push   $0x0
    29c4:	68 1e 4a 00 00       	push   $0x4a1e
    29c9:	e8 45 0f 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd >= 0){
    29be:	83 c4 10             	add    $0x10,%esp
    29c1:	85 c0                	test   %eax,%eax
    29c3:	0f 89 e3 00 00 00    	jns    2aac <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
<<<<<<< HEAD
    29c9:	83 ec 08             	sub    $0x8,%esp
    29cc:	68 00 02 00 00       	push   $0x200
    29d1:	68 de 49 00 00       	push   $0x49de
    29d6:	e8 38 0f 00 00       	call   3913 <open>
=======
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 00 02 00 00       	push   $0x200
    29e1:	68 1e 4a 00 00       	push   $0x4a1e
    29e6:	e8 28 0f 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd >= 0){
    29db:	83 c4 10             	add    $0x10,%esp
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 89 c6 00 00 00    	jns    2aac <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
<<<<<<< HEAD
    29e6:	83 ec 0c             	sub    $0xc,%esp
    29e9:	68 de 49 00 00       	push   $0x49de
    29ee:	e8 48 0f 00 00       	call   393b <mkdir>
    29f3:	83 c4 10             	add    $0x10,%esp
    29f6:	85 c0                	test   %eax,%eax
    29f8:	0f 84 46 01 00 00    	je     2b44 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    29fe:	83 ec 0c             	sub    $0xc,%esp
    2a01:	68 de 49 00 00       	push   $0x49de
    2a06:	e8 18 0f 00 00       	call   3923 <unlink>
    2a0b:	83 c4 10             	add    $0x10,%esp
    2a0e:	85 c0                	test   %eax,%eax
    2a10:	0f 84 1b 01 00 00    	je     2b31 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a16:	83 ec 08             	sub    $0x8,%esp
    2a19:	68 de 49 00 00       	push   $0x49de
    2a1e:	68 42 4a 00 00       	push   $0x4a42
    2a23:	e8 0b 0f 00 00       	call   3933 <link>
    2a28:	83 c4 10             	add    $0x10,%esp
    2a2b:	85 c0                	test   %eax,%eax
    2a2d:	0f 84 eb 00 00 00    	je     2b1e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a33:	83 ec 0c             	sub    $0xc,%esp
    2a36:	68 a5 49 00 00       	push   $0x49a5
    2a3b:	e8 e3 0e 00 00       	call   3923 <unlink>
    2a40:	83 c4 10             	add    $0x10,%esp
    2a43:	85 c0                	test   %eax,%eax
    2a45:	0f 85 c0 00 00 00    	jne    2b0b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a4b:	83 ec 08             	sub    $0x8,%esp
    2a4e:	6a 02                	push   $0x2
    2a50:	68 9e 45 00 00       	push   $0x459e
    2a55:	e8 b9 0e 00 00       	call   3913 <open>
=======
    29f6:	83 ec 0c             	sub    $0xc,%esp
    29f9:	68 1e 4a 00 00       	push   $0x4a1e
    29fe:	e8 38 0f 00 00       	call   393b <mkdir>
    2a03:	83 c4 10             	add    $0x10,%esp
    2a06:	85 c0                	test   %eax,%eax
    2a08:	0f 84 46 01 00 00    	je     2b54 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    2a0e:	83 ec 0c             	sub    $0xc,%esp
    2a11:	68 1e 4a 00 00       	push   $0x4a1e
    2a16:	e8 08 0f 00 00       	call   3923 <unlink>
    2a1b:	83 c4 10             	add    $0x10,%esp
    2a1e:	85 c0                	test   %eax,%eax
    2a20:	0f 84 1b 01 00 00    	je     2b41 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a26:	83 ec 08             	sub    $0x8,%esp
    2a29:	68 1e 4a 00 00       	push   $0x4a1e
    2a2e:	68 82 4a 00 00       	push   $0x4a82
    2a33:	e8 fb 0e 00 00       	call   3933 <link>
    2a38:	83 c4 10             	add    $0x10,%esp
    2a3b:	85 c0                	test   %eax,%eax
    2a3d:	0f 84 eb 00 00 00    	je     2b2e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a43:	83 ec 0c             	sub    $0xc,%esp
    2a46:	68 e5 49 00 00       	push   $0x49e5
    2a4b:	e8 d3 0e 00 00       	call   3923 <unlink>
    2a50:	83 c4 10             	add    $0x10,%esp
    2a53:	85 c0                	test   %eax,%eax
    2a55:	0f 85 c0 00 00 00    	jne    2b1b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a5b:	83 ec 08             	sub    $0x8,%esp
    2a5e:	6a 02                	push   $0x2
    2a60:	68 de 45 00 00       	push   $0x45de
    2a65:	e8 a9 0e 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd >= 0){
    2a5a:	83 c4 10             	add    $0x10,%esp
    2a5d:	85 c0                	test   %eax,%eax
    2a5f:	0f 89 93 00 00 00    	jns    2af8 <dirfile+0x198>
  fd = open(".", 0);
<<<<<<< HEAD
    2a65:	83 ec 08             	sub    $0x8,%esp
    2a68:	6a 00                	push   $0x0
    2a6a:	68 9e 45 00 00       	push   $0x459e
    2a6f:	e8 9f 0e 00 00       	call   3913 <open>
=======
    2a75:	83 ec 08             	sub    $0x8,%esp
    2a78:	6a 00                	push   $0x0
    2a7a:	68 de 45 00 00       	push   $0x45de
    2a7f:	e8 8f 0e 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(write(fd, "x", 1) > 0){
    2a74:	83 c4 0c             	add    $0xc,%esp
    2a77:	6a 01                	push   $0x1
  fd = open(".", 0);
    2a79:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
<<<<<<< HEAD
    2a7b:	68 81 46 00 00       	push   $0x4681
    2a80:	50                   	push   %eax
    2a81:	e8 6d 0e 00 00       	call   38f3 <write>
    2a86:	83 c4 10             	add    $0x10,%esp
    2a89:	85 c0                	test   %eax,%eax
    2a8b:	7f 58                	jg     2ae5 <dirfile+0x185>
=======
    2a8b:	68 c1 46 00 00       	push   $0x46c1
    2a90:	50                   	push   %eax
    2a91:	e8 5d 0e 00 00       	call   38f3 <write>
    2a96:	83 c4 10             	add    $0x10,%esp
    2a99:	85 c0                	test   %eax,%eax
    2a9b:	7f 58                	jg     2af5 <dirfile+0x185>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  close(fd);
    2a8d:	83 ec 0c             	sub    $0xc,%esp
    2a90:	53                   	push   %ebx
    2a91:	e8 65 0e 00 00       	call   38fb <close>
  printf(1, "dir vs file OK\n");
<<<<<<< HEAD
    2a96:	58                   	pop    %eax
    2a97:	5a                   	pop    %edx
    2a98:	68 75 4a 00 00       	push   $0x4a75
    2a9d:	6a 01                	push   $0x1
    2a9f:	e8 7c 0f 00 00       	call   3a20 <printf>
=======
    2aa6:	58                   	pop    %eax
    2aa7:	5a                   	pop    %edx
    2aa8:	68 b5 4a 00 00       	push   $0x4ab5
    2aad:	6a 01                	push   $0x1
    2aaf:	e8 8c 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    2aa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aa7:	83 c4 10             	add    $0x10,%esp
    2aaa:	c9                   	leave
    2aab:	c3                   	ret
    printf(1, "create dirfile/xx succeeded!\n");
<<<<<<< HEAD
    2aac:	50                   	push   %eax
    2aad:	50                   	push   %eax
    2aae:	68 e9 49 00 00       	push   $0x49e9
    2ab3:	6a 01                	push   $0x1
    2ab5:	e8 66 0f 00 00       	call   3a20 <printf>
=======
    2abc:	50                   	push   %eax
    2abd:	50                   	push   %eax
    2abe:	68 29 4a 00 00       	push   $0x4a29
    2ac3:	6a 01                	push   $0x1
    2ac5:	e8 76 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2aba:	e8 14 0e 00 00       	call   38d3 <exit>
    printf(1, "chdir dirfile succeeded!\n");
<<<<<<< HEAD
    2abf:	52                   	push   %edx
    2ac0:	52                   	push   %edx
    2ac1:	68 c4 49 00 00       	push   $0x49c4
    2ac6:	6a 01                	push   $0x1
    2ac8:	e8 53 0f 00 00       	call   3a20 <printf>
=======
    2acf:	52                   	push   %edx
    2ad0:	52                   	push   %edx
    2ad1:	68 04 4a 00 00       	push   $0x4a04
    2ad6:	6a 01                	push   $0x1
    2ad8:	e8 63 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2acd:	e8 01 0e 00 00       	call   38d3 <exit>
    printf(1, "create dirfile failed\n");
<<<<<<< HEAD
    2ad2:	51                   	push   %ecx
    2ad3:	51                   	push   %ecx
    2ad4:	68 ad 49 00 00       	push   $0x49ad
    2ad9:	6a 01                	push   $0x1
    2adb:	e8 40 0f 00 00       	call   3a20 <printf>
=======
    2ae2:	51                   	push   %ecx
    2ae3:	51                   	push   %ecx
    2ae4:	68 ed 49 00 00       	push   $0x49ed
    2ae9:	6a 01                	push   $0x1
    2aeb:	e8 50 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2ae0:	e8 ee 0d 00 00       	call   38d3 <exit>
    printf(1, "write . succeeded!\n");
<<<<<<< HEAD
    2ae5:	51                   	push   %ecx
    2ae6:	51                   	push   %ecx
    2ae7:	68 61 4a 00 00       	push   $0x4a61
    2aec:	6a 01                	push   $0x1
    2aee:	e8 2d 0f 00 00       	call   3a20 <printf>
=======
    2af5:	51                   	push   %ecx
    2af6:	51                   	push   %ecx
    2af7:	68 a1 4a 00 00       	push   $0x4aa1
    2afc:	6a 01                	push   $0x1
    2afe:	e8 3d 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2af3:	e8 db 0d 00 00       	call   38d3 <exit>
    printf(1, "open . for writing succeeded!\n");
<<<<<<< HEAD
    2af8:	53                   	push   %ebx
    2af9:	53                   	push   %ebx
    2afa:	68 60 52 00 00       	push   $0x5260
    2aff:	6a 01                	push   $0x1
    2b01:	e8 1a 0f 00 00       	call   3a20 <printf>
=======
    2b08:	53                   	push   %ebx
    2b09:	53                   	push   %ebx
    2b0a:	68 98 52 00 00       	push   $0x5298
    2b0f:	6a 01                	push   $0x1
    2b11:	e8 2a 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2b06:	e8 c8 0d 00 00       	call   38d3 <exit>
    printf(1, "unlink dirfile failed!\n");
<<<<<<< HEAD
    2b0b:	50                   	push   %eax
    2b0c:	50                   	push   %eax
    2b0d:	68 49 4a 00 00       	push   $0x4a49
    2b12:	6a 01                	push   $0x1
    2b14:	e8 07 0f 00 00       	call   3a20 <printf>
=======
    2b1b:	50                   	push   %eax
    2b1c:	50                   	push   %eax
    2b1d:	68 89 4a 00 00       	push   $0x4a89
    2b22:	6a 01                	push   $0x1
    2b24:	e8 17 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2b19:	e8 b5 0d 00 00       	call   38d3 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
<<<<<<< HEAD
    2b1e:	50                   	push   %eax
    2b1f:	50                   	push   %eax
    2b20:	68 40 52 00 00       	push   $0x5240
    2b25:	6a 01                	push   $0x1
    2b27:	e8 f4 0e 00 00       	call   3a20 <printf>
=======
    2b2e:	50                   	push   %eax
    2b2f:	50                   	push   %eax
    2b30:	68 78 52 00 00       	push   $0x5278
    2b35:	6a 01                	push   $0x1
    2b37:	e8 04 0f 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2b2c:	e8 a2 0d 00 00       	call   38d3 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
<<<<<<< HEAD
    2b31:	50                   	push   %eax
    2b32:	50                   	push   %eax
    2b33:	68 24 4a 00 00       	push   $0x4a24
    2b38:	6a 01                	push   $0x1
    2b3a:	e8 e1 0e 00 00       	call   3a20 <printf>
=======
    2b41:	50                   	push   %eax
    2b42:	50                   	push   %eax
    2b43:	68 64 4a 00 00       	push   $0x4a64
    2b48:	6a 01                	push   $0x1
    2b4a:	e8 f1 0e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2b3f:	e8 8f 0d 00 00       	call   38d3 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
<<<<<<< HEAD
    2b44:	50                   	push   %eax
    2b45:	50                   	push   %eax
    2b46:	68 07 4a 00 00       	push   $0x4a07
    2b4b:	6a 01                	push   $0x1
    2b4d:	e8 ce 0e 00 00       	call   3a20 <printf>
=======
    2b54:	50                   	push   %eax
    2b55:	50                   	push   %eax
    2b56:	68 47 4a 00 00       	push   $0x4a47
    2b5b:	6a 01                	push   $0x1
    2b5d:	e8 de 0e 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2b52:	e8 7c 0d 00 00       	call   38d3 <exit>
    2b57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2b5e:	00 
    2b5f:	90                   	nop

00002b60 <iref>:
{
    2b60:	55                   	push   %ebp
    2b61:	89 e5                	mov    %esp,%ebp
    2b63:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b64:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b69:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
<<<<<<< HEAD
    2b6c:	68 85 4a 00 00       	push   $0x4a85
    2b71:	6a 01                	push   $0x1
    2b73:	e8 a8 0e 00 00       	call   3a20 <printf>
    2b78:	83 c4 10             	add    $0x10,%esp
    2b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	68 96 4a 00 00       	push   $0x4a96
    2b88:	e8 ae 0d 00 00       	call   393b <mkdir>
    2b8d:	83 c4 10             	add    $0x10,%esp
    2b90:	85 c0                	test   %eax,%eax
    2b92:	0f 85 bb 00 00 00    	jne    2c53 <iref+0xf3>
    if(chdir("irefd") != 0){
    2b98:	83 ec 0c             	sub    $0xc,%esp
    2b9b:	68 96 4a 00 00       	push   $0x4a96
    2ba0:	e8 9e 0d 00 00       	call   3943 <chdir>
    2ba5:	83 c4 10             	add    $0x10,%esp
    2ba8:	85 c0                	test   %eax,%eax
    2baa:	0f 85 b7 00 00 00    	jne    2c67 <iref+0x107>
    mkdir("");
    2bb0:	83 ec 0c             	sub    $0xc,%esp
    2bb3:	68 4b 41 00 00       	push   $0x414b
    2bb8:	e8 7e 0d 00 00       	call   393b <mkdir>
    link("README", "");
    2bbd:	59                   	pop    %ecx
    2bbe:	58                   	pop    %eax
    2bbf:	68 4b 41 00 00       	push   $0x414b
    2bc4:	68 42 4a 00 00       	push   $0x4a42
    2bc9:	e8 65 0d 00 00       	call   3933 <link>
    fd = open("", O_CREATE);
    2bce:	58                   	pop    %eax
    2bcf:	5a                   	pop    %edx
    2bd0:	68 00 02 00 00       	push   $0x200
    2bd5:	68 4b 41 00 00       	push   $0x414b
    2bda:	e8 34 0d 00 00       	call   3913 <open>
=======
    2b7c:	68 c5 4a 00 00       	push   $0x4ac5
    2b81:	6a 01                	push   $0x1
    2b83:	e8 b8 0e 00 00       	call   3a40 <printf>
    2b88:	83 c4 10             	add    $0x10,%esp
    2b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b8f:	90                   	nop
    if(mkdir("irefd") != 0){
    2b90:	83 ec 0c             	sub    $0xc,%esp
    2b93:	68 d6 4a 00 00       	push   $0x4ad6
    2b98:	e8 9e 0d 00 00       	call   393b <mkdir>
    2b9d:	83 c4 10             	add    $0x10,%esp
    2ba0:	85 c0                	test   %eax,%eax
    2ba2:	0f 85 bb 00 00 00    	jne    2c63 <iref+0xf3>
    if(chdir("irefd") != 0){
    2ba8:	83 ec 0c             	sub    $0xc,%esp
    2bab:	68 d6 4a 00 00       	push   $0x4ad6
    2bb0:	e8 8e 0d 00 00       	call   3943 <chdir>
    2bb5:	83 c4 10             	add    $0x10,%esp
    2bb8:	85 c0                	test   %eax,%eax
    2bba:	0f 85 b7 00 00 00    	jne    2c77 <iref+0x107>
    mkdir("");
    2bc0:	83 ec 0c             	sub    $0xc,%esp
    2bc3:	68 8b 41 00 00       	push   $0x418b
    2bc8:	e8 6e 0d 00 00       	call   393b <mkdir>
    link("README", "");
    2bcd:	59                   	pop    %ecx
    2bce:	58                   	pop    %eax
    2bcf:	68 8b 41 00 00       	push   $0x418b
    2bd4:	68 82 4a 00 00       	push   $0x4a82
    2bd9:	e8 55 0d 00 00       	call   3933 <link>
    fd = open("", O_CREATE);
    2bde:	58                   	pop    %eax
    2bdf:	5a                   	pop    %edx
    2be0:	68 00 02 00 00       	push   $0x200
    2be5:	68 8b 41 00 00       	push   $0x418b
    2bea:	e8 24 0d 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(fd >= 0)
    2bdf:	83 c4 10             	add    $0x10,%esp
    2be2:	85 c0                	test   %eax,%eax
    2be4:	78 0c                	js     2bf2 <iref+0x92>
      close(fd);
    2be6:	83 ec 0c             	sub    $0xc,%esp
    2be9:	50                   	push   %eax
    2bea:	e8 0c 0d 00 00       	call   38fb <close>
    2bef:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
<<<<<<< HEAD
    2bf2:	83 ec 08             	sub    $0x8,%esp
    2bf5:	68 00 02 00 00       	push   $0x200
    2bfa:	68 80 46 00 00       	push   $0x4680
    2bff:	e8 0f 0d 00 00       	call   3913 <open>
=======
    2c02:	83 ec 08             	sub    $0x8,%esp
    2c05:	68 00 02 00 00       	push   $0x200
    2c0a:	68 c0 46 00 00       	push   $0x46c0
    2c0f:	e8 ff 0c 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(fd >= 0)
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	85 c0                	test   %eax,%eax
    2c09:	78 0c                	js     2c17 <iref+0xb7>
      close(fd);
    2c0b:	83 ec 0c             	sub    $0xc,%esp
    2c0e:	50                   	push   %eax
    2c0f:	e8 e7 0c 00 00       	call   38fb <close>
    2c14:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
<<<<<<< HEAD
    2c17:	83 ec 0c             	sub    $0xc,%esp
    2c1a:	68 80 46 00 00       	push   $0x4680
    2c1f:	e8 ff 0c 00 00       	call   3923 <unlink>
=======
    2c27:	83 ec 0c             	sub    $0xc,%esp
    2c2a:	68 c0 46 00 00       	push   $0x46c0
    2c2f:	e8 ef 0c 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < 50 + 1; i++){
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	83 eb 01             	sub    $0x1,%ebx
    2c2a:	0f 85 50 ff ff ff    	jne    2b80 <iref+0x20>
  chdir("/");
<<<<<<< HEAD
    2c30:	83 ec 0c             	sub    $0xc,%esp
    2c33:	68 71 3d 00 00       	push   $0x3d71
    2c38:	e8 06 0d 00 00       	call   3943 <chdir>
  printf(1, "empty file name OK\n");
    2c3d:	58                   	pop    %eax
    2c3e:	5a                   	pop    %edx
    2c3f:	68 c4 4a 00 00       	push   $0x4ac4
    2c44:	6a 01                	push   $0x1
    2c46:	e8 d5 0d 00 00       	call   3a20 <printf>
=======
    2c40:	83 ec 0c             	sub    $0xc,%esp
    2c43:	68 b1 3d 00 00       	push   $0x3db1
    2c48:	e8 f6 0c 00 00       	call   3943 <chdir>
  printf(1, "empty file name OK\n");
    2c4d:	58                   	pop    %eax
    2c4e:	5a                   	pop    %edx
    2c4f:	68 04 4b 00 00       	push   $0x4b04
    2c54:	6a 01                	push   $0x1
    2c56:	e8 e5 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    2c4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c4e:	83 c4 10             	add    $0x10,%esp
    2c51:	c9                   	leave
    2c52:	c3                   	ret
      printf(1, "mkdir irefd failed\n");
<<<<<<< HEAD
    2c53:	83 ec 08             	sub    $0x8,%esp
    2c56:	68 9c 4a 00 00       	push   $0x4a9c
    2c5b:	6a 01                	push   $0x1
    2c5d:	e8 be 0d 00 00       	call   3a20 <printf>
=======
    2c63:	83 ec 08             	sub    $0x8,%esp
    2c66:	68 dc 4a 00 00       	push   $0x4adc
    2c6b:	6a 01                	push   $0x1
    2c6d:	e8 ce 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    2c62:	e8 6c 0c 00 00       	call   38d3 <exit>
      printf(1, "chdir irefd failed\n");
<<<<<<< HEAD
    2c67:	83 ec 08             	sub    $0x8,%esp
    2c6a:	68 b0 4a 00 00       	push   $0x4ab0
    2c6f:	6a 01                	push   $0x1
    2c71:	e8 aa 0d 00 00       	call   3a20 <printf>
=======
    2c77:	83 ec 08             	sub    $0x8,%esp
    2c7a:	68 f0 4a 00 00       	push   $0x4af0
    2c7f:	6a 01                	push   $0x1
    2c81:	e8 ba 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    2c76:	e8 58 0c 00 00       	call   38d3 <exit>
    2c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00002c80 <forktest>:
{
    2c80:	55                   	push   %ebp
    2c81:	89 e5                	mov    %esp,%ebp
    2c83:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2c84:	31 db                	xor    %ebx,%ebx
{
    2c86:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
<<<<<<< HEAD
    2c89:	68 d8 4a 00 00       	push   $0x4ad8
    2c8e:	6a 01                	push   $0x1
    2c90:	e8 8b 0d 00 00       	call   3a20 <printf>
    2c95:	83 c4 10             	add    $0x10,%esp
    2c98:	eb 13                	jmp    2cad <forktest+0x2d>
    2c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
=======
    2c99:	68 18 4b 00 00       	push   $0x4b18
    2c9e:	6a 01                	push   $0x1
    2ca0:	e8 9b 0d 00 00       	call   3a40 <printf>
    2ca5:	83 c4 10             	add    $0x10,%esp
    2ca8:	eb 13                	jmp    2cbd <forktest+0x2d>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if(pid == 0)
    2ca0:	74 4a                	je     2cec <forktest+0x6c>
  for(n=0; n<1000; n++){
    2ca2:	83 c3 01             	add    $0x1,%ebx
    2ca5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cab:	74 6b                	je     2d18 <forktest+0x98>
    pid = fork();
    2cad:	e8 19 0c 00 00       	call   38cb <fork>
    if(pid < 0)
    2cb2:	85 c0                	test   %eax,%eax
    2cb4:	79 ea                	jns    2ca0 <forktest+0x20>
  for(; n > 0; n--){
    2cb6:	85 db                	test   %ebx,%ebx
    2cb8:	74 14                	je     2cce <forktest+0x4e>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2cc0:	e8 16 0c 00 00       	call   38db <wait>
    2cc5:	85 c0                	test   %eax,%eax
    2cc7:	78 28                	js     2cf1 <forktest+0x71>
  for(; n > 0; n--){
    2cc9:	83 eb 01             	sub    $0x1,%ebx
    2ccc:	75 f2                	jne    2cc0 <forktest+0x40>
  if(wait() != -1){
    2cce:	e8 08 0c 00 00       	call   38db <wait>
    2cd3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cd6:	75 2d                	jne    2d05 <forktest+0x85>
  printf(1, "fork test OK\n");
<<<<<<< HEAD
    2cd8:	83 ec 08             	sub    $0x8,%esp
    2cdb:	68 0a 4b 00 00       	push   $0x4b0a
    2ce0:	6a 01                	push   $0x1
    2ce2:	e8 39 0d 00 00       	call   3a20 <printf>
=======
    2ce8:	83 ec 08             	sub    $0x8,%esp
    2ceb:	68 4a 4b 00 00       	push   $0x4b4a
    2cf0:	6a 01                	push   $0x1
    2cf2:	e8 49 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    2ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cea:	c9                   	leave
    2ceb:	c3                   	ret
      exit();
    2cec:	e8 e2 0b 00 00       	call   38d3 <exit>
      printf(1, "wait stopped early\n");
<<<<<<< HEAD
    2cf1:	83 ec 08             	sub    $0x8,%esp
    2cf4:	68 e3 4a 00 00       	push   $0x4ae3
    2cf9:	6a 01                	push   $0x1
    2cfb:	e8 20 0d 00 00       	call   3a20 <printf>
=======
    2d01:	83 ec 08             	sub    $0x8,%esp
    2d04:	68 23 4b 00 00       	push   $0x4b23
    2d09:	6a 01                	push   $0x1
    2d0b:	e8 30 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    2d00:	e8 ce 0b 00 00       	call   38d3 <exit>
    printf(1, "wait got too many\n");
<<<<<<< HEAD
    2d05:	52                   	push   %edx
    2d06:	52                   	push   %edx
    2d07:	68 f7 4a 00 00       	push   $0x4af7
    2d0c:	6a 01                	push   $0x1
    2d0e:	e8 0d 0d 00 00       	call   3a20 <printf>
=======
    2d15:	52                   	push   %edx
    2d16:	52                   	push   %edx
    2d17:	68 37 4b 00 00       	push   $0x4b37
    2d1c:	6a 01                	push   $0x1
    2d1e:	e8 1d 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2d13:	e8 bb 0b 00 00       	call   38d3 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
<<<<<<< HEAD
    2d18:	50                   	push   %eax
    2d19:	50                   	push   %eax
    2d1a:	68 80 52 00 00       	push   $0x5280
    2d1f:	6a 01                	push   $0x1
    2d21:	e8 fa 0c 00 00       	call   3a20 <printf>
=======
    2d28:	50                   	push   %eax
    2d29:	50                   	push   %eax
    2d2a:	68 b8 52 00 00       	push   $0x52b8
    2d2f:	6a 01                	push   $0x1
    2d31:	e8 0a 0d 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    2d26:	e8 a8 0b 00 00       	call   38d3 <exit>
    2d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00002d30 <sbrktest>:
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
  for(i = 0; i < 5000; i++){
    2d35:	31 f6                	xor    %esi,%esi
{
    2d37:	53                   	push   %ebx
    2d38:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
<<<<<<< HEAD
    2d3b:	68 18 4b 00 00       	push   $0x4b18
    2d40:	ff 35 08 5e 00 00    	push   0x5e08
    2d46:	e8 d5 0c 00 00       	call   3a20 <printf>
=======
    2d4b:	68 58 4b 00 00       	push   $0x4b58
    2d50:	ff 35 58 5e 00 00    	push   0x5e58
    2d56:	e8 e5 0c 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  oldbrk = sbrk(0);
    2d4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d52:	e8 04 0c 00 00       	call   395b <sbrk>
    2d57:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2d5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d61:	e8 f5 0b 00 00       	call   395b <sbrk>
    2d66:	83 c4 10             	add    $0x10,%esp
    2d69:	89 c3                	mov    %eax,%ebx
  for(i = 0; i < 5000; i++){
    2d6b:	eb 05                	jmp    2d72 <sbrktest+0x42>
    2d6d:	8d 76 00             	lea    0x0(%esi),%esi
    2d70:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	6a 01                	push   $0x1
    2d77:	e8 df 0b 00 00       	call   395b <sbrk>
    if(b != a){
    2d7c:	83 c4 10             	add    $0x10,%esp
    2d7f:	39 d8                	cmp    %ebx,%eax
    2d81:	0f 85 9c 02 00 00    	jne    3023 <sbrktest+0x2f3>
  for(i = 0; i < 5000; i++){
    2d87:	83 c6 01             	add    $0x1,%esi
    *b = 1;
    2d8a:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2d8d:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2d90:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2d96:	75 d8                	jne    2d70 <sbrktest+0x40>
  pid = fork();
    2d98:	e8 2e 0b 00 00       	call   38cb <fork>
    2d9d:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2d9f:	85 c0                	test   %eax,%eax
    2da1:	0f 88 02 03 00 00    	js     30a9 <sbrktest+0x379>
  c = sbrk(1);
    2da7:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2daa:	83 c3 02             	add    $0x2,%ebx
  c = sbrk(1);
    2dad:	6a 01                	push   $0x1
    2daf:	e8 a7 0b 00 00       	call   395b <sbrk>
  c = sbrk(1);
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 9b 0b 00 00       	call   395b <sbrk>
  if(c != a + 1){
    2dc0:	83 c4 10             	add    $0x10,%esp
    2dc3:	39 c3                	cmp    %eax,%ebx
    2dc5:	0f 85 3b 03 00 00    	jne    3106 <sbrktest+0x3d6>
  if(pid == 0)
    2dcb:	85 f6                	test   %esi,%esi
    2dcd:	0f 84 2e 03 00 00    	je     3101 <sbrktest+0x3d1>
  wait();
    2dd3:	e8 03 0b 00 00       	call   38db <wait>
  a = sbrk(0);
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	6a 00                	push   $0x0
    2ddd:	e8 79 0b 00 00       	call   395b <sbrk>
    2de2:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2de4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2de9:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2deb:	89 04 24             	mov    %eax,(%esp)
    2dee:	e8 68 0b 00 00       	call   395b <sbrk>
  if (p != a) {
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	39 c3                	cmp    %eax,%ebx
    2df8:	0f 85 94 02 00 00    	jne    3092 <sbrktest+0x362>
  a = sbrk(0);
    2dfe:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2e01:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2e08:	6a 00                	push   $0x0
    2e0a:	e8 4c 0b 00 00       	call   395b <sbrk>
  c = sbrk(-4096);
    2e0f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e16:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2e18:	e8 3e 0b 00 00       	call   395b <sbrk>
  if(c == (char*)0xffffffff){
    2e1d:	83 c4 10             	add    $0x10,%esp
    2e20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e23:	0f 84 22 03 00 00    	je     314b <sbrktest+0x41b>
  c = sbrk(0);
    2e29:	83 ec 0c             	sub    $0xc,%esp
    2e2c:	6a 00                	push   $0x0
    2e2e:	e8 28 0b 00 00       	call   395b <sbrk>
  if(c != a - 4096){
    2e33:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	39 d0                	cmp    %edx,%eax
    2e3e:	0f 85 f0 02 00 00    	jne    3134 <sbrktest+0x404>
  a = sbrk(0);
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 0d 0b 00 00       	call   395b <sbrk>
  c = sbrk(4096);
    2e4e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    2e55:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2e57:	e8 ff 0a 00 00       	call   395b <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e5c:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    2e5f:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2e61:	39 c3                	cmp    %eax,%ebx
    2e63:	0f 85 b4 02 00 00    	jne    311d <sbrktest+0x3ed>
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	6a 00                	push   $0x0
    2e6e:	e8 e8 0a 00 00       	call   395b <sbrk>
    2e73:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	39 c2                	cmp    %eax,%edx
    2e7e:	0f 85 99 02 00 00    	jne    311d <sbrktest+0x3ed>
  if(*lastaddr == 99){
    2e84:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e8b:	0f 84 2f 02 00 00    	je     30c0 <sbrktest+0x390>
  a = sbrk(0);
    2e91:	83 ec 0c             	sub    $0xc,%esp
    2e94:	6a 00                	push   $0x0
    2e96:	e8 c0 0a 00 00       	call   395b <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2ea2:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2ea4:	e8 b2 0a 00 00       	call   395b <sbrk>
    2ea9:	89 c2                	mov    %eax,%edx
    2eab:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2eae:	29 d0                	sub    %edx,%eax
    2eb0:	89 04 24             	mov    %eax,(%esp)
    2eb3:	e8 a3 0a 00 00       	call   395b <sbrk>
  if(c != a){
    2eb8:	83 c4 10             	add    $0x10,%esp
    2ebb:	39 c3                	cmp    %eax,%ebx
    2ebd:	0f 85 b8 01 00 00    	jne    307b <sbrktest+0x34b>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ec3:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ec8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2ecf:	00 
    ppid = getpid();
    2ed0:	e8 7e 0a 00 00       	call   3953 <getpid>
    2ed5:	89 c6                	mov    %eax,%esi
    pid = fork();
    2ed7:	e8 ef 09 00 00       	call   38cb <fork>
    if(pid < 0){
    2edc:	85 c0                	test   %eax,%eax
    2ede:	0f 88 5d 01 00 00    	js     3041 <sbrktest+0x311>
    if(pid == 0){
    2ee4:	0f 84 6f 01 00 00    	je     3059 <sbrktest+0x329>
    wait();
    2eea:	e8 ec 09 00 00       	call   38db <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eef:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2ef5:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2efb:	75 d3                	jne    2ed0 <sbrktest+0x1a0>
  if(pipe(fds) != 0){
    2efd:	83 ec 0c             	sub    $0xc,%esp
    2f00:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f03:	50                   	push   %eax
    2f04:	e8 da 09 00 00       	call   38e3 <pipe>
    2f09:	83 c4 10             	add    $0x10,%esp
    2f0c:	85 c0                	test   %eax,%eax
    2f0e:	0f 85 da 01 00 00    	jne    30ee <sbrktest+0x3be>
    2f14:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2f17:	8d 75 e8             	lea    -0x18(%ebp),%esi
    2f1a:	89 df                	mov    %ebx,%edi
    2f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((pids[i] = fork()) == 0){
    2f20:	e8 a6 09 00 00       	call   38cb <fork>
    2f25:	89 07                	mov    %eax,(%edi)
    2f27:	85 c0                	test   %eax,%eax
    2f29:	0f 84 91 00 00 00    	je     2fc0 <sbrktest+0x290>
    if(pids[i] != -1)
    2f2f:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f32:	74 14                	je     2f48 <sbrktest+0x218>
      read(fds[0], &scratch, 1);
    2f34:	83 ec 04             	sub    $0x4,%esp
    2f37:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f3a:	6a 01                	push   $0x1
    2f3c:	50                   	push   %eax
    2f3d:	ff 75 b8             	push   -0x48(%ebp)
    2f40:	e8 a6 09 00 00       	call   38eb <read>
    2f45:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f48:	83 c7 04             	add    $0x4,%edi
    2f4b:	39 f7                	cmp    %esi,%edi
    2f4d:	75 d1                	jne    2f20 <sbrktest+0x1f0>
  c = sbrk(4096);
    2f4f:	83 ec 0c             	sub    $0xc,%esp
    2f52:	68 00 10 00 00       	push   $0x1000
    2f57:	e8 ff 09 00 00       	call   395b <sbrk>
    2f5c:	83 c4 10             	add    $0x10,%esp
    2f5f:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pids[i] == -1)
    2f68:	8b 03                	mov    (%ebx),%eax
    2f6a:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f6d:	74 11                	je     2f80 <sbrktest+0x250>
    kill(pids[i]);
    2f6f:	83 ec 0c             	sub    $0xc,%esp
    2f72:	50                   	push   %eax
    2f73:	e8 8b 09 00 00       	call   3903 <kill>
    wait();
    2f78:	e8 5e 09 00 00       	call   38db <wait>
    2f7d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f80:	83 c3 04             	add    $0x4,%ebx
    2f83:	39 f3                	cmp    %esi,%ebx
    2f85:	75 e1                	jne    2f68 <sbrktest+0x238>
  if(c == (char*)0xffffffff){
    2f87:	83 ff ff             	cmp    $0xffffffff,%edi
    2f8a:	0f 84 47 01 00 00    	je     30d7 <sbrktest+0x3a7>
  if(sbrk(0) > oldbrk)
    2f90:	83 ec 0c             	sub    $0xc,%esp
    2f93:	6a 00                	push   $0x0
    2f95:	e8 c1 09 00 00       	call   395b <sbrk>
    2f9a:	83 c4 10             	add    $0x10,%esp
    2f9d:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2fa0:	72 60                	jb     3002 <sbrktest+0x2d2>
  printf(stdout, "sbrk test OK\n");
<<<<<<< HEAD
    2fa2:	83 ec 08             	sub    $0x8,%esp
    2fa5:	68 c0 4b 00 00       	push   $0x4bc0
    2faa:	ff 35 08 5e 00 00    	push   0x5e08
    2fb0:	e8 6b 0a 00 00       	call   3a20 <printf>
=======
    2fb2:	83 ec 08             	sub    $0x8,%esp
    2fb5:	68 00 4c 00 00       	push   $0x4c00
    2fba:	ff 35 58 5e 00 00    	push   0x5e58
    2fc0:	e8 7b 0a 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    2fb5:	83 c4 10             	add    $0x10,%esp
    2fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fbb:	5b                   	pop    %ebx
    2fbc:	5e                   	pop    %esi
    2fbd:	5f                   	pop    %edi
    2fbe:	5d                   	pop    %ebp
    2fbf:	c3                   	ret
      sbrk(BIG - (uint)sbrk(0));
    2fc0:	83 ec 0c             	sub    $0xc,%esp
    2fc3:	6a 00                	push   $0x0
    2fc5:	e8 91 09 00 00       	call   395b <sbrk>
    2fca:	89 c2                	mov    %eax,%edx
    2fcc:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fd1:	29 d0                	sub    %edx,%eax
    2fd3:	89 04 24             	mov    %eax,(%esp)
    2fd6:	e8 80 09 00 00       	call   395b <sbrk>
      write(fds[1], "x", 1);
<<<<<<< HEAD
    2fdb:	83 c4 0c             	add    $0xc,%esp
    2fde:	6a 01                	push   $0x1
    2fe0:	68 81 46 00 00       	push   $0x4681
    2fe5:	ff 75 bc             	push   -0x44(%ebp)
    2fe8:	e8 06 09 00 00       	call   38f3 <write>
    2fed:	83 c4 10             	add    $0x10,%esp
=======
    2feb:	83 c4 0c             	add    $0xc,%esp
    2fee:	6a 01                	push   $0x1
    2ff0:	68 c1 46 00 00       	push   $0x46c1
    2ff5:	ff 75 bc             	push   -0x44(%ebp)
    2ff8:	e8 f6 08 00 00       	call   38f3 <write>
    2ffd:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      for(;;) sleep(1000);
    2ff0:	83 ec 0c             	sub    $0xc,%esp
    2ff3:	68 e8 03 00 00       	push   $0x3e8
    2ff8:	e8 66 09 00 00       	call   3963 <sleep>
    2ffd:	83 c4 10             	add    $0x10,%esp
    3000:	eb ee                	jmp    2ff0 <sbrktest+0x2c0>
    sbrk(-(sbrk(0) - oldbrk));
    3002:	83 ec 0c             	sub    $0xc,%esp
    3005:	6a 00                	push   $0x0
    3007:	e8 4f 09 00 00       	call   395b <sbrk>
    300c:	89 c2                	mov    %eax,%edx
    300e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3011:	29 d0                	sub    %edx,%eax
    3013:	89 04 24             	mov    %eax,(%esp)
    3016:	e8 40 09 00 00       	call   395b <sbrk>
    301b:	83 c4 10             	add    $0x10,%esp
    301e:	e9 7f ff ff ff       	jmp    2fa2 <sbrktest+0x272>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
<<<<<<< HEAD
    3023:	83 ec 0c             	sub    $0xc,%esp
    3026:	50                   	push   %eax
    3027:	53                   	push   %ebx
    3028:	56                   	push   %esi
    3029:	68 23 4b 00 00       	push   $0x4b23
    302e:	ff 35 08 5e 00 00    	push   0x5e08
    3034:	e8 e7 09 00 00       	call   3a20 <printf>
=======
    3033:	83 ec 0c             	sub    $0xc,%esp
    3036:	50                   	push   %eax
    3037:	53                   	push   %ebx
    3038:	56                   	push   %esi
    3039:	68 63 4b 00 00       	push   $0x4b63
    303e:	ff 35 58 5e 00 00    	push   0x5e58
    3044:	e8 f7 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    3039:	83 c4 20             	add    $0x20,%esp
    303c:	e8 92 08 00 00       	call   38d3 <exit>
      printf(stdout, "fork failed\n");
<<<<<<< HEAD
    3041:	83 ec 08             	sub    $0x8,%esp
    3044:	68 69 4c 00 00       	push   $0x4c69
    3049:	ff 35 08 5e 00 00    	push   0x5e08
    304f:	e8 cc 09 00 00       	call   3a20 <printf>
=======
    3051:	83 ec 08             	sub    $0x8,%esp
    3054:	68 a9 4c 00 00       	push   $0x4ca9
    3059:	ff 35 58 5e 00 00    	push   0x5e58
    305f:	e8 dc 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    3054:	e8 7a 08 00 00       	call   38d3 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
<<<<<<< HEAD
    3059:	0f be 03             	movsbl (%ebx),%eax
    305c:	50                   	push   %eax
    305d:	53                   	push   %ebx
    305e:	68 8c 4b 00 00       	push   $0x4b8c
    3063:	ff 35 08 5e 00 00    	push   0x5e08
    3069:	e8 b2 09 00 00       	call   3a20 <printf>
=======
    3069:	0f be 03             	movsbl (%ebx),%eax
    306c:	50                   	push   %eax
    306d:	53                   	push   %ebx
    306e:	68 cc 4b 00 00       	push   $0x4bcc
    3073:	ff 35 58 5e 00 00    	push   0x5e58
    3079:	e8 c2 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      kill(ppid);
    306e:	89 34 24             	mov    %esi,(%esp)
    3071:	e8 8d 08 00 00       	call   3903 <kill>
      exit();
    3076:	e8 58 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
<<<<<<< HEAD
    307b:	50                   	push   %eax
    307c:	53                   	push   %ebx
    307d:	68 74 53 00 00       	push   $0x5374
    3082:	ff 35 08 5e 00 00    	push   0x5e08
    3088:	e8 93 09 00 00       	call   3a20 <printf>
=======
    308b:	50                   	push   %eax
    308c:	53                   	push   %ebx
    308d:	68 ac 53 00 00       	push   $0x53ac
    3092:	ff 35 58 5e 00 00    	push   0x5e58
    3098:	e8 a3 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    308d:	e8 41 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
<<<<<<< HEAD
    3092:	56                   	push   %esi
    3093:	56                   	push   %esi
    3094:	68 a4 52 00 00       	push   $0x52a4
    3099:	ff 35 08 5e 00 00    	push   0x5e08
    309f:	e8 7c 09 00 00       	call   3a20 <printf>
=======
    30a2:	56                   	push   %esi
    30a3:	56                   	push   %esi
    30a4:	68 dc 52 00 00       	push   $0x52dc
    30a9:	ff 35 58 5e 00 00    	push   0x5e58
    30af:	e8 8c 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    30a4:	e8 2a 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test fork failed\n");
<<<<<<< HEAD
    30a9:	50                   	push   %eax
    30aa:	50                   	push   %eax
    30ab:	68 3e 4b 00 00       	push   $0x4b3e
    30b0:	ff 35 08 5e 00 00    	push   0x5e08
    30b6:	e8 65 09 00 00       	call   3a20 <printf>
=======
    30b9:	50                   	push   %eax
    30ba:	50                   	push   %eax
    30bb:	68 7e 4b 00 00       	push   $0x4b7e
    30c0:	ff 35 58 5e 00 00    	push   0x5e58
    30c6:	e8 75 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    30bb:	e8 13 08 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
<<<<<<< HEAD
    30c0:	51                   	push   %ecx
    30c1:	51                   	push   %ecx
    30c2:	68 44 53 00 00       	push   $0x5344
    30c7:	ff 35 08 5e 00 00    	push   0x5e08
    30cd:	e8 4e 09 00 00       	call   3a20 <printf>
=======
    30d0:	51                   	push   %ecx
    30d1:	51                   	push   %ecx
    30d2:	68 7c 53 00 00       	push   $0x537c
    30d7:	ff 35 58 5e 00 00    	push   0x5e58
    30dd:	e8 5e 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    30d2:	e8 fc 07 00 00       	call   38d3 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
<<<<<<< HEAD
    30d7:	50                   	push   %eax
    30d8:	50                   	push   %eax
    30d9:	68 a5 4b 00 00       	push   $0x4ba5
    30de:	ff 35 08 5e 00 00    	push   0x5e08
    30e4:	e8 37 09 00 00       	call   3a20 <printf>
=======
    30e7:	50                   	push   %eax
    30e8:	50                   	push   %eax
    30e9:	68 e5 4b 00 00       	push   $0x4be5
    30ee:	ff 35 58 5e 00 00    	push   0x5e58
    30f4:	e8 47 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    30e9:	e8 e5 07 00 00       	call   38d3 <exit>
    printf(1, "pipe() failed\n");
<<<<<<< HEAD
    30ee:	52                   	push   %edx
    30ef:	52                   	push   %edx
    30f0:	68 61 40 00 00       	push   $0x4061
    30f5:	6a 01                	push   $0x1
    30f7:	e8 24 09 00 00       	call   3a20 <printf>
=======
    30fe:	52                   	push   %edx
    30ff:	52                   	push   %edx
    3100:	68 a1 40 00 00       	push   $0x40a1
    3105:	6a 01                	push   $0x1
    3107:	e8 34 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    30fc:	e8 d2 07 00 00       	call   38d3 <exit>
    exit();
    3101:	e8 cd 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
<<<<<<< HEAD
    3106:	57                   	push   %edi
    3107:	57                   	push   %edi
    3108:	68 55 4b 00 00       	push   $0x4b55
    310d:	ff 35 08 5e 00 00    	push   0x5e08
    3113:	e8 08 09 00 00       	call   3a20 <printf>
=======
    3116:	57                   	push   %edi
    3117:	57                   	push   %edi
    3118:	68 95 4b 00 00       	push   $0x4b95
    311d:	ff 35 58 5e 00 00    	push   0x5e58
    3123:	e8 18 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    3118:	e8 b6 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
<<<<<<< HEAD
    311d:	56                   	push   %esi
    311e:	53                   	push   %ebx
    311f:	68 1c 53 00 00       	push   $0x531c
    3124:	ff 35 08 5e 00 00    	push   0x5e08
    312a:	e8 f1 08 00 00       	call   3a20 <printf>
=======
    312d:	56                   	push   %esi
    312e:	53                   	push   %ebx
    312f:	68 54 53 00 00       	push   $0x5354
    3134:	ff 35 58 5e 00 00    	push   0x5e58
    313a:	e8 01 09 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    312f:	e8 9f 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
<<<<<<< HEAD
    3134:	50                   	push   %eax
    3135:	53                   	push   %ebx
    3136:	68 e4 52 00 00       	push   $0x52e4
    313b:	ff 35 08 5e 00 00    	push   0x5e08
    3141:	e8 da 08 00 00       	call   3a20 <printf>
=======
    3144:	50                   	push   %eax
    3145:	53                   	push   %ebx
    3146:	68 1c 53 00 00       	push   $0x531c
    314b:	ff 35 58 5e 00 00    	push   0x5e58
    3151:	e8 ea 08 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    3146:	e8 88 07 00 00       	call   38d3 <exit>
    printf(stdout, "sbrk could not deallocate\n");
<<<<<<< HEAD
    314b:	53                   	push   %ebx
    314c:	53                   	push   %ebx
    314d:	68 71 4b 00 00       	push   $0x4b71
    3152:	ff 35 08 5e 00 00    	push   0x5e08
    3158:	e8 c3 08 00 00       	call   3a20 <printf>
=======
    315b:	53                   	push   %ebx
    315c:	53                   	push   %ebx
    315d:	68 b1 4b 00 00       	push   $0x4bb1
    3162:	ff 35 58 5e 00 00    	push   0x5e58
    3168:	e8 d3 08 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    315d:	e8 71 07 00 00       	call   38d3 <exit>
    3162:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3169:	00 
    316a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003170 <validateint>:
}
    3170:	c3                   	ret
    3171:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3178:	00 
    3179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003180 <validatetest>:
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    3184:	31 f6                	xor    %esi,%esi
{
    3186:	53                   	push   %ebx
  printf(stdout, "validate test\n");
<<<<<<< HEAD
    3187:	83 ec 08             	sub    $0x8,%esp
    318a:	68 ce 4b 00 00       	push   $0x4bce
    318f:	ff 35 08 5e 00 00    	push   0x5e08
    3195:	e8 86 08 00 00       	call   3a20 <printf>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	8d 76 00             	lea    0x0(%esi),%esi
=======
    3197:	83 ec 08             	sub    $0x8,%esp
    319a:	68 0e 4c 00 00       	push   $0x4c0e
    319f:	ff 35 58 5e 00 00    	push   0x5e58
    31a5:	e8 96 08 00 00       	call   3a40 <printf>
    31aa:	83 c4 10             	add    $0x10,%esp
    31ad:	8d 76 00             	lea    0x0(%esi),%esi
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    if((pid = fork()) == 0){
    31a0:	e8 26 07 00 00       	call   38cb <fork>
    31a5:	89 c3                	mov    %eax,%ebx
    31a7:	85 c0                	test   %eax,%eax
    31a9:	74 63                	je     320e <validatetest+0x8e>
    sleep(0);
    31ab:	83 ec 0c             	sub    $0xc,%esp
    31ae:	6a 00                	push   $0x0
    31b0:	e8 ae 07 00 00       	call   3963 <sleep>
    sleep(0);
    31b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31bc:	e8 a2 07 00 00       	call   3963 <sleep>
    kill(pid);
    31c1:	89 1c 24             	mov    %ebx,(%esp)
    31c4:	e8 3a 07 00 00       	call   3903 <kill>
    wait();
    31c9:	e8 0d 07 00 00       	call   38db <wait>
    if(link("nosuchfile", (char*)p) != -1){
<<<<<<< HEAD
    31ce:	58                   	pop    %eax
    31cf:	5a                   	pop    %edx
    31d0:	56                   	push   %esi
    31d1:	68 dd 4b 00 00       	push   $0x4bdd
    31d6:	e8 58 07 00 00       	call   3933 <link>
    31db:	83 c4 10             	add    $0x10,%esp
    31de:	83 f8 ff             	cmp    $0xffffffff,%eax
    31e1:	75 30                	jne    3213 <validatetest+0x93>
=======
    31de:	58                   	pop    %eax
    31df:	5a                   	pop    %edx
    31e0:	56                   	push   %esi
    31e1:	68 1d 4c 00 00       	push   $0x4c1d
    31e6:	e8 48 07 00 00       	call   3933 <link>
    31eb:	83 c4 10             	add    $0x10,%esp
    31ee:	83 f8 ff             	cmp    $0xffffffff,%eax
    31f1:	75 30                	jne    3223 <validatetest+0x93>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(p = 0; p <= (uint)hi; p += 4096){
    31e3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31e9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31ef:	75 af                	jne    31a0 <validatetest+0x20>
  printf(stdout, "validate ok\n");
<<<<<<< HEAD
    31f1:	83 ec 08             	sub    $0x8,%esp
    31f4:	68 01 4c 00 00       	push   $0x4c01
    31f9:	ff 35 08 5e 00 00    	push   0x5e08
    31ff:	e8 1c 08 00 00       	call   3a20 <printf>
=======
    3201:	83 ec 08             	sub    $0x8,%esp
    3204:	68 41 4c 00 00       	push   $0x4c41
    3209:	ff 35 58 5e 00 00    	push   0x5e58
    320f:	e8 2c 08 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	8d 65 f8             	lea    -0x8(%ebp),%esp
    320a:	5b                   	pop    %ebx
    320b:	5e                   	pop    %esi
    320c:	5d                   	pop    %ebp
    320d:	c3                   	ret
      exit();
    320e:	e8 c0 06 00 00       	call   38d3 <exit>
      printf(stdout, "link should not succeed\n");
<<<<<<< HEAD
    3213:	83 ec 08             	sub    $0x8,%esp
    3216:	68 e8 4b 00 00       	push   $0x4be8
    321b:	ff 35 08 5e 00 00    	push   0x5e08
    3221:	e8 fa 07 00 00       	call   3a20 <printf>
=======
    3223:	83 ec 08             	sub    $0x8,%esp
    3226:	68 28 4c 00 00       	push   $0x4c28
    322b:	ff 35 58 5e 00 00    	push   0x5e58
    3231:	e8 0a 08 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    3226:	e8 a8 06 00 00       	call   38d3 <exit>
    322b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003230 <bsstest>:
{
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
<<<<<<< HEAD
    3236:	68 0e 4c 00 00       	push   $0x4c0e
    323b:	ff 35 08 5e 00 00    	push   0x5e08
    3241:	e8 da 07 00 00       	call   3a20 <printf>
    3246:	83 c4 10             	add    $0x10,%esp
=======
    3246:	68 4e 4c 00 00       	push   $0x4c4e
    324b:	ff 35 58 5e 00 00    	push   0x5e58
    3251:	e8 ea 07 00 00       	call   3a40 <printf>
    3256:	83 c4 10             	add    $0x10,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < sizeof(uninit); i++){
    3249:	31 c0                	xor    %eax,%eax
    324b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(uninit[i] != '\0'){
<<<<<<< HEAD
    3250:	80 b8 20 5e 00 00 00 	cmpb   $0x0,0x5e20(%eax)
    3257:	75 22                	jne    327b <bsstest+0x4b>
=======
    3260:	80 b8 80 5e 00 00 00 	cmpb   $0x0,0x5e80(%eax)
    3267:	75 22                	jne    328b <bsstest+0x4b>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  for(i = 0; i < sizeof(uninit); i++){
    3259:	83 c0 01             	add    $0x1,%eax
    325c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3261:	75 ed                	jne    3250 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
<<<<<<< HEAD
    3263:	83 ec 08             	sub    $0x8,%esp
    3266:	68 29 4c 00 00       	push   $0x4c29
    326b:	ff 35 08 5e 00 00    	push   0x5e08
    3271:	e8 aa 07 00 00       	call   3a20 <printf>
=======
    3273:	83 ec 08             	sub    $0x8,%esp
    3276:	68 69 4c 00 00       	push   $0x4c69
    327b:	ff 35 58 5e 00 00    	push   0x5e58
    3281:	e8 ba 07 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	c9                   	leave
    327a:	c3                   	ret
      printf(stdout, "bss test failed\n");
<<<<<<< HEAD
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 18 4c 00 00       	push   $0x4c18
    3283:	ff 35 08 5e 00 00    	push   0x5e08
    3289:	e8 92 07 00 00       	call   3a20 <printf>
=======
    328b:	83 ec 08             	sub    $0x8,%esp
    328e:	68 58 4c 00 00       	push   $0x4c58
    3293:	ff 35 58 5e 00 00    	push   0x5e58
    3299:	e8 a2 07 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      exit();
    328e:	e8 40 06 00 00       	call   38d3 <exit>
    3293:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    329a:	00 
    329b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000032a0 <bigargtest>:
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
<<<<<<< HEAD
    32a6:	68 36 4c 00 00       	push   $0x4c36
    32ab:	e8 73 06 00 00       	call   3923 <unlink>
=======
    32b6:	68 76 4c 00 00       	push   $0x4c76
    32bb:	e8 63 06 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  pid = fork();
    32b0:	e8 16 06 00 00       	call   38cb <fork>
  if(pid == 0){
    32b5:	83 c4 10             	add    $0x10,%esp
    32b8:	85 c0                	test   %eax,%eax
    32ba:	74 3f                	je     32fb <bigargtest+0x5b>
  } else if(pid < 0){
    32bc:	0f 88 d9 00 00 00    	js     339b <bigargtest+0xfb>
  wait();
    32c2:	e8 14 06 00 00       	call   38db <wait>
  fd = open("bigarg-ok", 0);
<<<<<<< HEAD
    32c7:	83 ec 08             	sub    $0x8,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	68 36 4c 00 00       	push   $0x4c36
    32d1:	e8 3d 06 00 00       	call   3913 <open>
=======
    32d7:	83 ec 08             	sub    $0x8,%esp
    32da:	6a 00                	push   $0x0
    32dc:	68 76 4c 00 00       	push   $0x4c76
    32e1:	e8 2d 06 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if(fd < 0){
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	85 c0                	test   %eax,%eax
    32db:	0f 88 a3 00 00 00    	js     3384 <bigargtest+0xe4>
  close(fd);
    32e1:	83 ec 0c             	sub    $0xc,%esp
    32e4:	50                   	push   %eax
    32e5:	e8 11 06 00 00       	call   38fb <close>
  unlink("bigarg-ok");
<<<<<<< HEAD
    32ea:	c7 04 24 36 4c 00 00 	movl   $0x4c36,(%esp)
    32f1:	e8 2d 06 00 00       	call   3923 <unlink>
=======
    32fa:	c7 04 24 76 4c 00 00 	movl   $0x4c76,(%esp)
    3301:	e8 1d 06 00 00       	call   3923 <unlink>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	c9                   	leave
    32fa:	c3                   	ret
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
<<<<<<< HEAD
    32fb:	c7 04 85 40 a5 00 00 	movl   $0x5398,0xa540(,%eax,4)
    3302:	98 53 00 00 
=======
    3310:	c7 04 85 a0 a5 00 00 	movl   $0x53d0,0xa5a0(,%eax,4)
    3317:	d0 53 00 00 
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    for(i = 0; i < MAXARG-1; i++)
    3306:	b8 01 00 00 00       	mov    $0x1,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    330b:	c7 04 85 40 a5 00 00 	movl   $0x5398,0xa540(,%eax,4)
    3312:	98 53 00 00 
    3316:	c7 04 85 44 a5 00 00 	movl   $0x5398,0xa544(,%eax,4)
    331d:	98 53 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3321:	83 c0 02             	add    $0x2,%eax
    3324:	83 f8 1f             	cmp    $0x1f,%eax
    3327:	75 e2                	jne    330b <bigargtest+0x6b>
    printf(stdout, "bigarg test\n");
<<<<<<< HEAD
    3329:	50                   	push   %eax
    args[MAXARG-1] = 0;
    332a:	31 c9                	xor    %ecx,%ecx
    printf(stdout, "bigarg test\n");
    332c:	50                   	push   %eax
    332d:	68 40 4c 00 00       	push   $0x4c40
    3332:	ff 35 08 5e 00 00    	push   0x5e08
    args[MAXARG-1] = 0;
    3338:	89 0d bc a5 00 00    	mov    %ecx,0xa5bc
    printf(stdout, "bigarg test\n");
    333e:	e8 dd 06 00 00       	call   3a20 <printf>
    exec("echo", args);
    3343:	58                   	pop    %eax
    3344:	5a                   	pop    %edx
    3345:	68 40 a5 00 00       	push   $0xa540
    334a:	68 0d 3e 00 00       	push   $0x3e0d
    334f:	e8 b7 05 00 00       	call   390b <exec>
    printf(stdout, "bigarg test ok\n");
    3354:	59                   	pop    %ecx
    3355:	58                   	pop    %eax
    3356:	68 4d 4c 00 00       	push   $0x4c4d
    335b:	ff 35 08 5e 00 00    	push   0x5e08
    3361:	e8 ba 06 00 00       	call   3a20 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3366:	58                   	pop    %eax
    3367:	5a                   	pop    %edx
    3368:	68 00 02 00 00       	push   $0x200
    336d:	68 36 4c 00 00       	push   $0x4c36
    3372:	e8 9c 05 00 00       	call   3913 <open>
=======
    3323:	51                   	push   %ecx
    3324:	51                   	push   %ecx
    3325:	68 80 4c 00 00       	push   $0x4c80
    332a:	ff 35 58 5e 00 00    	push   0x5e58
    args[MAXARG-1] = 0;
    3330:	c7 05 1c a6 00 00 00 	movl   $0x0,0xa61c
    3337:	00 00 00 
    printf(stdout, "bigarg test\n");
    333a:	e8 01 07 00 00       	call   3a40 <printf>
    exec("echo", args);
    333f:	58                   	pop    %eax
    3340:	5a                   	pop    %edx
    3341:	68 a0 a5 00 00       	push   $0xa5a0
    3346:	68 4d 3e 00 00       	push   $0x3e4d
    334b:	e8 bb 05 00 00       	call   390b <exec>
    printf(stdout, "bigarg test ok\n");
    3350:	59                   	pop    %ecx
    3351:	58                   	pop    %eax
    3352:	68 8d 4c 00 00       	push   $0x4c8d
    3357:	ff 35 58 5e 00 00    	push   0x5e58
    335d:	e8 de 06 00 00       	call   3a40 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3362:	58                   	pop    %eax
    3363:	5a                   	pop    %edx
    3364:	68 00 02 00 00       	push   $0x200
    3369:	68 76 4c 00 00       	push   $0x4c76
    336e:	e8 a0 05 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    close(fd);
    3377:	89 04 24             	mov    %eax,(%esp)
    337a:	e8 7c 05 00 00       	call   38fb <close>
    exit();
    337f:	e8 4f 05 00 00       	call   38d3 <exit>
    printf(stdout, "bigarg test failed!\n");
<<<<<<< HEAD
    3384:	50                   	push   %eax
    3385:	50                   	push   %eax
    3386:	68 76 4c 00 00       	push   $0x4c76
    338b:	ff 35 08 5e 00 00    	push   0x5e08
    3391:	e8 8a 06 00 00       	call   3a20 <printf>
=======
    3380:	50                   	push   %eax
    3381:	50                   	push   %eax
    3382:	68 b6 4c 00 00       	push   $0x4cb6
    3387:	ff 35 58 5e 00 00    	push   0x5e58
    338d:	e8 ae 06 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    3396:	e8 38 05 00 00       	call   38d3 <exit>
    printf(stdout, "bigargtest: fork failed\n");
<<<<<<< HEAD
    339b:	52                   	push   %edx
    339c:	52                   	push   %edx
    339d:	68 5d 4c 00 00       	push   $0x4c5d
    33a2:	ff 35 08 5e 00 00    	push   0x5e08
    33a8:	e8 73 06 00 00       	call   3a20 <printf>
=======
    3397:	52                   	push   %edx
    3398:	52                   	push   %edx
    3399:	68 9d 4c 00 00       	push   $0x4c9d
    339e:	ff 35 58 5e 00 00    	push   0x5e58
    33a4:	e8 97 06 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    33ad:	e8 21 05 00 00       	call   38d3 <exit>
    33b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    33b9:	00 
    33ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000033c0 <fsfull>:
{
    33c0:	55                   	push   %ebp
    33c1:	89 e5                	mov    %esp,%ebp
    33c3:	57                   	push   %edi
    33c4:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    33c5:	31 f6                	xor    %esi,%esi
{
    33c7:	53                   	push   %ebx
    33c8:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
<<<<<<< HEAD
    33cb:	68 8b 4c 00 00       	push   $0x4c8b
    33d0:	6a 01                	push   $0x1
    33d2:	e8 49 06 00 00       	call   3a20 <printf>
    33d7:	83 c4 10             	add    $0x10,%esp
    33da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
=======
    33bb:	68 cb 4c 00 00       	push   $0x4ccb
    33c0:	6a 01                	push   $0x1
    33c2:	e8 79 06 00 00       	call   3a40 <printf>
    33c7:	83 c4 10             	add    $0x10,%esp
    33ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    name[1] = '0' + nfiles / 1000;
    33e0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33e5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    33ea:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    33ed:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    33f1:	f7 e6                	mul    %esi
    name[5] = '\0';
    33f3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33f7:	c1 ea 06             	shr    $0x6,%edx
    33fa:	8d 42 30             	lea    0x30(%edx),%eax
    33fd:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3400:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    3406:	89 f2                	mov    %esi,%edx
    3408:	29 c2                	sub    %eax,%edx
    340a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    340f:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    3411:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3416:	c1 ea 05             	shr    $0x5,%edx
    3419:	83 c2 30             	add    $0x30,%edx
    341c:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    341f:	f7 e6                	mul    %esi
    3421:	c1 ea 05             	shr    $0x5,%edx
    3424:	6b c2 64             	imul   $0x64,%edx,%eax
    3427:	89 f2                	mov    %esi,%edx
    3429:	29 c2                	sub    %eax,%edx
    342b:	89 d0                	mov    %edx,%eax
    342d:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    342f:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3431:	c1 ea 03             	shr    $0x3,%edx
    3434:	83 c2 30             	add    $0x30,%edx
    3437:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    343a:	f7 e1                	mul    %ecx
    343c:	89 f0                	mov    %esi,%eax
    343e:	c1 ea 03             	shr    $0x3,%edx
    3441:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3444:	01 d2                	add    %edx,%edx
    3446:	29 d0                	sub    %edx,%eax
    3448:	83 c0 30             	add    $0x30,%eax
    344b:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
<<<<<<< HEAD
    344e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3451:	50                   	push   %eax
    3452:	68 98 4c 00 00       	push   $0x4c98
    3457:	6a 01                	push   $0x1
    3459:	e8 c2 05 00 00       	call   3a20 <printf>
=======
    343e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3441:	50                   	push   %eax
    3442:	68 d8 4c 00 00       	push   $0x4cd8
    3447:	6a 01                	push   $0x1
    3449:	e8 f2 05 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    int fd = open(name, O_CREATE|O_RDWR);
    345e:	58                   	pop    %eax
    345f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3462:	5a                   	pop    %edx
    3463:	68 02 02 00 00       	push   $0x202
    3468:	50                   	push   %eax
    3469:	e8 a5 04 00 00       	call   3913 <open>
    if(fd < 0){
    346e:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3471:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3473:	85 c0                	test   %eax,%eax
    3475:	78 4f                	js     34c6 <fsfull+0x106>
    int total = 0;
    3477:	31 db                	xor    %ebx,%ebx
    3479:	eb 07                	jmp    3482 <fsfull+0xc2>
    347b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      total += cc;
    3480:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
<<<<<<< HEAD
    3482:	83 ec 04             	sub    $0x4,%esp
    3485:	68 00 02 00 00       	push   $0x200
    348a:	68 40 85 00 00       	push   $0x8540
    348f:	57                   	push   %edi
    3490:	e8 5e 04 00 00       	call   38f3 <write>
=======
    3472:	83 ec 04             	sub    $0x4,%esp
    3475:	68 00 02 00 00       	push   $0x200
    347a:	68 a0 85 00 00       	push   $0x85a0
    347f:	57                   	push   %edi
    3480:	e8 6e 04 00 00       	call   38f3 <write>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      if(cc < 512)
    3495:	83 c4 10             	add    $0x10,%esp
    3498:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    349d:	7f e1                	jg     3480 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
<<<<<<< HEAD
    349f:	83 ec 04             	sub    $0x4,%esp
    34a2:	53                   	push   %ebx
    34a3:	68 b4 4c 00 00       	push   $0x4cb4
    34a8:	6a 01                	push   $0x1
    34aa:	e8 71 05 00 00       	call   3a20 <printf>
=======
    348f:	83 ec 04             	sub    $0x4,%esp
    3492:	53                   	push   %ebx
    3493:	68 f4 4c 00 00       	push   $0x4cf4
    3498:	6a 01                	push   $0x1
    349a:	e8 a1 05 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    close(fd);
    34af:	89 3c 24             	mov    %edi,(%esp)
    34b2:	e8 44 04 00 00       	call   38fb <close>
    if(total == 0)
    34b7:	83 c4 10             	add    $0x10,%esp
    34ba:	85 db                	test   %ebx,%ebx
    34bc:	74 1e                	je     34dc <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    34be:	83 c6 01             	add    $0x1,%esi
    34c1:	e9 1a ff ff ff       	jmp    33e0 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
<<<<<<< HEAD
    34c6:	83 ec 04             	sub    $0x4,%esp
    34c9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34cc:	50                   	push   %eax
    34cd:	68 a4 4c 00 00       	push   $0x4ca4
    34d2:	6a 01                	push   $0x1
    34d4:	e8 47 05 00 00       	call   3a20 <printf>
=======
    34b6:	83 ec 04             	sub    $0x4,%esp
    34b9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34bc:	50                   	push   %eax
    34bd:	68 e4 4c 00 00       	push   $0x4ce4
    34c2:	6a 01                	push   $0x1
    34c4:	e8 77 05 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
      break;
    34d9:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    34dc:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    34e1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    34ed:	00 
    34ee:	66 90                	xchg   %ax,%ax
    name[1] = '0' + nfiles / 1000;
    34f0:	89 f0                	mov    %esi,%eax
    unlink(name);
    34f2:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    34f5:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    34f9:	f7 e7                	mul    %edi
    name[5] = '\0';
    34fb:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34ff:	c1 ea 06             	shr    $0x6,%edx
    3502:	8d 42 30             	lea    0x30(%edx),%eax
    3505:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3508:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    350e:	89 f2                	mov    %esi,%edx
    3510:	29 c2                	sub    %eax,%edx
    3512:	89 d0                	mov    %edx,%eax
    3514:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    3516:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3518:	c1 ea 05             	shr    $0x5,%edx
    351b:	83 c2 30             	add    $0x30,%edx
    351e:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3521:	f7 e3                	mul    %ebx
    3523:	c1 ea 05             	shr    $0x5,%edx
    3526:	6b ca 64             	imul   $0x64,%edx,%ecx
    3529:	89 f2                	mov    %esi,%edx
    352b:	29 ca                	sub    %ecx,%edx
    352d:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    3532:	89 d0                	mov    %edx,%eax
    3534:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3536:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3538:	c1 ea 03             	shr    $0x3,%edx
    353b:	83 c2 30             	add    $0x30,%edx
    353e:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3541:	f7 e1                	mul    %ecx
    3543:	89 f0                	mov    %esi,%eax
    nfiles--;
    3545:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3548:	c1 ea 03             	shr    $0x3,%edx
    354b:	8d 14 92             	lea    (%edx,%edx,4),%edx
    354e:	01 d2                	add    %edx,%edx
    3550:	29 d0                	sub    %edx,%eax
    3552:	83 c0 30             	add    $0x30,%eax
    3555:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3558:	8d 45 a8             	lea    -0x58(%ebp),%eax
    355b:	50                   	push   %eax
    355c:	e8 c2 03 00 00       	call   3923 <unlink>
  while(nfiles >= 0){
    3561:	83 c4 10             	add    $0x10,%esp
    3564:	83 fe ff             	cmp    $0xffffffff,%esi
    3567:	75 87                	jne    34f0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
<<<<<<< HEAD
    3569:	83 ec 08             	sub    $0x8,%esp
    356c:	68 c4 4c 00 00       	push   $0x4cc4
    3571:	6a 01                	push   $0x1
    3573:	e8 a8 04 00 00       	call   3a20 <printf>
=======
    3559:	83 ec 08             	sub    $0x8,%esp
    355c:	68 04 4d 00 00       	push   $0x4d04
    3561:	6a 01                	push   $0x1
    3563:	e8 d8 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    3578:	83 c4 10             	add    $0x10,%esp
    357b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    357e:	5b                   	pop    %ebx
    357f:	5e                   	pop    %esi
    3580:	5f                   	pop    %edi
    3581:	5d                   	pop    %ebp
    3582:	c3                   	ret
    3583:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    358a:	00 
    358b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003590 <uio>:
{
    3590:	55                   	push   %ebp
    3591:	89 e5                	mov    %esp,%ebp
    3593:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
<<<<<<< HEAD
    3596:	68 da 4c 00 00       	push   $0x4cda
    359b:	6a 01                	push   $0x1
    359d:	e8 7e 04 00 00       	call   3a20 <printf>
=======
    3586:	68 1a 4d 00 00       	push   $0x4d1a
    358b:	6a 01                	push   $0x1
    358d:	e8 ae 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  pid = fork();
    35a2:	e8 24 03 00 00       	call   38cb <fork>
  if(pid == 0){
    35a7:	83 c4 10             	add    $0x10,%esp
    35aa:	85 c0                	test   %eax,%eax
    35ac:	74 1b                	je     35c9 <uio+0x39>
  } else if(pid < 0){
    35ae:	78 3d                	js     35ed <uio+0x5d>
  wait();
    35b0:	e8 26 03 00 00       	call   38db <wait>
  printf(1, "uio test done\n");
<<<<<<< HEAD
    35b5:	83 ec 08             	sub    $0x8,%esp
    35b8:	68 e4 4c 00 00       	push   $0x4ce4
    35bd:	6a 01                	push   $0x1
    35bf:	e8 5c 04 00 00       	call   3a20 <printf>
=======
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 24 4d 00 00       	push   $0x4d24
    35ad:	6a 01                	push   $0x1
    35af:	e8 8c 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    35c4:	83 c4 10             	add    $0x10,%esp
    35c7:	c9                   	leave
    35c8:	c3                   	ret
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    35c9:	b8 09 00 00 00       	mov    $0x9,%eax
    35ce:	ba 70 00 00 00       	mov    $0x70,%edx
    35d3:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    35d4:	ba 71 00 00 00       	mov    $0x71,%edx
    35d9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
<<<<<<< HEAD
    35da:	52                   	push   %edx
    35db:	52                   	push   %edx
    35dc:	68 78 54 00 00       	push   $0x5478
    35e1:	6a 01                	push   $0x1
    35e3:	e8 38 04 00 00       	call   3a20 <printf>
=======
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 b0 54 00 00       	push   $0x54b0
    35d1:	6a 01                	push   $0x1
    35d3:	e8 68 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    35e8:	e8 e6 02 00 00       	call   38d3 <exit>
    printf (1, "fork failed\n");
<<<<<<< HEAD
    35ed:	50                   	push   %eax
    35ee:	50                   	push   %eax
    35ef:	68 69 4c 00 00       	push   $0x4c69
    35f4:	6a 01                	push   $0x1
    35f6:	e8 25 04 00 00       	call   3a20 <printf>
=======
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 a9 4c 00 00       	push   $0x4ca9
    35e4:	6a 01                	push   $0x1
    35e6:	e8 55 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    35fb:	e8 d3 02 00 00       	call   38d3 <exit>

00003600 <argptest>:
{
    3600:	55                   	push   %ebp
    3601:	89 e5                	mov    %esp,%ebp
    3603:	53                   	push   %ebx
    3604:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
<<<<<<< HEAD
    3607:	6a 00                	push   $0x0
    3609:	68 f3 4c 00 00       	push   $0x4cf3
    360e:	e8 00 03 00 00       	call   3913 <open>
=======
    35f7:	6a 00                	push   $0x0
    35f9:	68 33 4d 00 00       	push   $0x4d33
    35fe:	e8 10 03 00 00       	call   3913 <open>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  if (fd < 0) {
    3613:	83 c4 10             	add    $0x10,%esp
    3616:	85 c0                	test   %eax,%eax
    3618:	78 39                	js     3653 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    361a:	83 ec 0c             	sub    $0xc,%esp
    361d:	89 c3                	mov    %eax,%ebx
    361f:	6a 00                	push   $0x0
    3621:	e8 35 03 00 00       	call   395b <sbrk>
    3626:	83 c4 0c             	add    $0xc,%esp
    3629:	83 e8 01             	sub    $0x1,%eax
    362c:	6a ff                	push   $0xffffffff
    362e:	50                   	push   %eax
    362f:	53                   	push   %ebx
    3630:	e8 b6 02 00 00       	call   38eb <read>
  close(fd);
    3635:	89 1c 24             	mov    %ebx,(%esp)
    3638:	e8 be 02 00 00       	call   38fb <close>
  printf(1, "arg test passed\n");
<<<<<<< HEAD
    363d:	58                   	pop    %eax
    363e:	5a                   	pop    %edx
    363f:	68 05 4d 00 00       	push   $0x4d05
    3644:	6a 01                	push   $0x1
    3646:	e8 d5 03 00 00       	call   3a20 <printf>
=======
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 45 4d 00 00       	push   $0x4d45
    3634:	6a 01                	push   $0x1
    3636:	e8 05 04 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    364b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    364e:	83 c4 10             	add    $0x10,%esp
    3651:	c9                   	leave
    3652:	c3                   	ret
    printf(2, "open failed\n");
<<<<<<< HEAD
    3653:	51                   	push   %ecx
    3654:	51                   	push   %ecx
    3655:	68 f8 4c 00 00       	push   $0x4cf8
    365a:	6a 02                	push   $0x2
    365c:	e8 bf 03 00 00       	call   3a20 <printf>
=======
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 38 4d 00 00       	push   $0x4d38
    364a:	6a 02                	push   $0x2
    364c:	e8 ef 03 00 00       	call   3a40 <printf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    exit();
    3661:	e8 6d 02 00 00       	call   38d3 <exit>
    3666:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    366d:	00 
    366e:	66 90                	xchg   %ax,%ax

00003670 <rand>:
  randstate = randstate * 1664525 + 1013904223;
<<<<<<< HEAD
    3670:	69 05 04 5e 00 00 0d 	imul   $0x19660d,0x5e04,%eax
    3677:	66 19 00 
    367a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    367f:	a3 04 5e 00 00       	mov    %eax,0x5e04
=======
    3660:	69 05 54 5e 00 00 0d 	imul   $0x19660d,0x5e54,%eax
    3667:	66 19 00 
    366a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    366f:	a3 54 5e 00 00       	mov    %eax,0x5e54
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
}
    3684:	c3                   	ret
    3685:	66 90                	xchg   %ax,%ax
    3687:	66 90                	xchg   %ax,%ax
    3689:	66 90                	xchg   %ax,%ax
    368b:	66 90                	xchg   %ax,%ax
    368d:	66 90                	xchg   %ax,%ax
    368f:	90                   	nop

00003690 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3690:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3691:	31 c0                	xor    %eax,%eax
{
    3693:	89 e5                	mov    %esp,%ebp
    3695:	53                   	push   %ebx
    3696:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3699:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    36a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    36a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    36a7:	83 c0 01             	add    $0x1,%eax
    36aa:	84 d2                	test   %dl,%dl
    36ac:	75 f2                	jne    36a0 <strcpy+0x10>
    ;
  return os;
}
    36ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36b1:	89 c8                	mov    %ecx,%eax
    36b3:	c9                   	leave
    36b4:	c3                   	ret
    36b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    36bc:	00 
    36bd:	8d 76 00             	lea    0x0(%esi),%esi

000036c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36c0:	55                   	push   %ebp
    36c1:	89 e5                	mov    %esp,%ebp
    36c3:	53                   	push   %ebx
    36c4:	8b 55 08             	mov    0x8(%ebp),%edx
    36c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    36ca:	0f b6 02             	movzbl (%edx),%eax
    36cd:	84 c0                	test   %al,%al
    36cf:	75 17                	jne    36e8 <strcmp+0x28>
    36d1:	eb 3a                	jmp    370d <strcmp+0x4d>
    36d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    36d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    36dc:	83 c2 01             	add    $0x1,%edx
    36df:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    36e2:	84 c0                	test   %al,%al
    36e4:	74 1a                	je     3700 <strcmp+0x40>
    36e6:	89 d9                	mov    %ebx,%ecx
    36e8:	0f b6 19             	movzbl (%ecx),%ebx
    36eb:	38 c3                	cmp    %al,%bl
    36ed:	74 e9                	je     36d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    36ef:	29 d8                	sub    %ebx,%eax
}
    36f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36f4:	c9                   	leave
    36f5:	c3                   	ret
    36f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    36fd:	00 
    36fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
    3700:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3704:	31 c0                	xor    %eax,%eax
    3706:	29 d8                	sub    %ebx,%eax
}
    3708:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    370b:	c9                   	leave
    370c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
    370d:	0f b6 19             	movzbl (%ecx),%ebx
    3710:	31 c0                	xor    %eax,%eax
    3712:	eb db                	jmp    36ef <strcmp+0x2f>
    3714:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    371b:	00 
    371c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003720 <strlen>:

uint
strlen(const char *s)
{
    3720:	55                   	push   %ebp
    3721:	89 e5                	mov    %esp,%ebp
    3723:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3726:	80 3a 00             	cmpb   $0x0,(%edx)
    3729:	74 15                	je     3740 <strlen+0x20>
    372b:	31 c0                	xor    %eax,%eax
    372d:	8d 76 00             	lea    0x0(%esi),%esi
    3730:	83 c0 01             	add    $0x1,%eax
    3733:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3737:	89 c1                	mov    %eax,%ecx
    3739:	75 f5                	jne    3730 <strlen+0x10>
    ;
  return n;
}
    373b:	89 c8                	mov    %ecx,%eax
    373d:	5d                   	pop    %ebp
    373e:	c3                   	ret
    373f:	90                   	nop
  for(n = 0; s[n]; n++)
    3740:	31 c9                	xor    %ecx,%ecx
}
    3742:	5d                   	pop    %ebp
    3743:	89 c8                	mov    %ecx,%eax
    3745:	c3                   	ret
    3746:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    374d:	00 
    374e:	66 90                	xchg   %ax,%ax

00003750 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	57                   	push   %edi
    3754:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3757:	8b 4d 10             	mov    0x10(%ebp),%ecx
    375a:	8b 45 0c             	mov    0xc(%ebp),%eax
    375d:	89 d7                	mov    %edx,%edi
    375f:	fc                   	cld
    3760:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3762:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3765:	89 d0                	mov    %edx,%eax
    3767:	c9                   	leave
    3768:	c3                   	ret
    3769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003770 <strchr>:

char*
strchr(const char *s, char c)
{
    3770:	55                   	push   %ebp
    3771:	89 e5                	mov    %esp,%ebp
    3773:	8b 45 08             	mov    0x8(%ebp),%eax
    3776:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    377a:	0f b6 10             	movzbl (%eax),%edx
    377d:	84 d2                	test   %dl,%dl
    377f:	75 12                	jne    3793 <strchr+0x23>
    3781:	eb 1d                	jmp    37a0 <strchr+0x30>
    3783:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    3788:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    378c:	83 c0 01             	add    $0x1,%eax
    378f:	84 d2                	test   %dl,%dl
    3791:	74 0d                	je     37a0 <strchr+0x30>
    if(*s == c)
    3793:	38 d1                	cmp    %dl,%cl
    3795:	75 f1                	jne    3788 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3797:	5d                   	pop    %ebp
    3798:	c3                   	ret
    3799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    37a0:	31 c0                	xor    %eax,%eax
}
    37a2:	5d                   	pop    %ebp
    37a3:	c3                   	ret
    37a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    37ab:	00 
    37ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000037b0 <gets>:

char*
gets(char *buf, int max)
{
    37b0:	55                   	push   %ebp
    37b1:	89 e5                	mov    %esp,%ebp
    37b3:	57                   	push   %edi
    37b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    37b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
    37b8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    37b9:	31 db                	xor    %ebx,%ebx
{
    37bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    37be:	eb 27                	jmp    37e7 <gets+0x37>
    cc = read(0, &c, 1);
    37c0:	83 ec 04             	sub    $0x4,%esp
    37c3:	6a 01                	push   $0x1
    37c5:	56                   	push   %esi
    37c6:	6a 00                	push   $0x0
    37c8:	e8 1e 01 00 00       	call   38eb <read>
    if(cc < 1)
    37cd:	83 c4 10             	add    $0x10,%esp
    37d0:	85 c0                	test   %eax,%eax
    37d2:	7e 1d                	jle    37f1 <gets+0x41>
      break;
    buf[i++] = c;
    37d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37d8:	8b 55 08             	mov    0x8(%ebp),%edx
    37db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    37df:	3c 0a                	cmp    $0xa,%al
    37e1:	74 10                	je     37f3 <gets+0x43>
    37e3:	3c 0d                	cmp    $0xd,%al
    37e5:	74 0c                	je     37f3 <gets+0x43>
  for(i=0; i+1 < max; ){
    37e7:	89 df                	mov    %ebx,%edi
    37e9:	83 c3 01             	add    $0x1,%ebx
    37ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37ef:	7c cf                	jl     37c0 <gets+0x10>
    37f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    37f3:	8b 45 08             	mov    0x8(%ebp),%eax
    37f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    37fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37fd:	5b                   	pop    %ebx
    37fe:	5e                   	pop    %esi
    37ff:	5f                   	pop    %edi
    3800:	5d                   	pop    %ebp
    3801:	c3                   	ret
    3802:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3809:	00 
    380a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003810 <stat>:

int
stat(const char *n, struct stat *st)
{
    3810:	55                   	push   %ebp
    3811:	89 e5                	mov    %esp,%ebp
    3813:	56                   	push   %esi
    3814:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3815:	83 ec 08             	sub    $0x8,%esp
    3818:	6a 00                	push   $0x0
    381a:	ff 75 08             	push   0x8(%ebp)
    381d:	e8 f1 00 00 00       	call   3913 <open>
  if(fd < 0)
    3822:	83 c4 10             	add    $0x10,%esp
    3825:	85 c0                	test   %eax,%eax
    3827:	78 27                	js     3850 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3829:	83 ec 08             	sub    $0x8,%esp
    382c:	ff 75 0c             	push   0xc(%ebp)
    382f:	89 c3                	mov    %eax,%ebx
    3831:	50                   	push   %eax
    3832:	e8 f4 00 00 00       	call   392b <fstat>
  close(fd);
    3837:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    383a:	89 c6                	mov    %eax,%esi
  close(fd);
    383c:	e8 ba 00 00 00       	call   38fb <close>
  return r;
    3841:	83 c4 10             	add    $0x10,%esp
}
    3844:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3847:	89 f0                	mov    %esi,%eax
    3849:	5b                   	pop    %ebx
    384a:	5e                   	pop    %esi
    384b:	5d                   	pop    %ebp
    384c:	c3                   	ret
    384d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3850:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3855:	eb ed                	jmp    3844 <stat+0x34>
    3857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    385e:	00 
    385f:	90                   	nop

00003860 <atoi>:

int
atoi(const char *s)
{
    3860:	55                   	push   %ebp
    3861:	89 e5                	mov    %esp,%ebp
    3863:	53                   	push   %ebx
    3864:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3867:	0f be 02             	movsbl (%edx),%eax
    386a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    386d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3870:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3875:	77 1e                	ja     3895 <atoi+0x35>
    3877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    387e:	00 
    387f:	90                   	nop
    n = n*10 + *s++ - '0';
    3880:	83 c2 01             	add    $0x1,%edx
    3883:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3886:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    388a:	0f be 02             	movsbl (%edx),%eax
    388d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3890:	80 fb 09             	cmp    $0x9,%bl
    3893:	76 eb                	jbe    3880 <atoi+0x20>
  return n;
}
    3895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3898:	89 c8                	mov    %ecx,%eax
    389a:	c9                   	leave
    389b:	c3                   	ret
    389c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000038a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
    38a3:	57                   	push   %edi
    38a4:	8b 45 10             	mov    0x10(%ebp),%eax
    38a7:	8b 55 08             	mov    0x8(%ebp),%edx
    38aa:	56                   	push   %esi
    38ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    38ae:	85 c0                	test   %eax,%eax
    38b0:	7e 13                	jle    38c5 <memmove+0x25>
    38b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    38b4:	89 d7                	mov    %edx,%edi
    38b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    38bd:	00 
    38be:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    38c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    38c1:	39 f8                	cmp    %edi,%eax
    38c3:	75 fb                	jne    38c0 <memmove+0x20>
  return vdst;
}
    38c5:	5e                   	pop    %esi
    38c6:	89 d0                	mov    %edx,%eax
    38c8:	5f                   	pop    %edi
    38c9:	5d                   	pop    %ebp
    38ca:	c3                   	ret

000038cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    38cb:	b8 01 00 00 00       	mov    $0x1,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret

000038d3 <exit>:
SYSCALL(exit)
    38d3:	b8 02 00 00 00       	mov    $0x2,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret

000038db <wait>:
SYSCALL(wait)
    38db:	b8 03 00 00 00       	mov    $0x3,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret

000038e3 <pipe>:
SYSCALL(pipe)
    38e3:	b8 04 00 00 00       	mov    $0x4,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret

000038eb <read>:
SYSCALL(read)
    38eb:	b8 05 00 00 00       	mov    $0x5,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret

000038f3 <write>:
SYSCALL(write)
    38f3:	b8 10 00 00 00       	mov    $0x10,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret

000038fb <close>:
SYSCALL(close)
    38fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret

00003903 <kill>:
SYSCALL(kill)
    3903:	b8 06 00 00 00       	mov    $0x6,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret

0000390b <exec>:
SYSCALL(exec)
    390b:	b8 07 00 00 00       	mov    $0x7,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret

00003913 <open>:
SYSCALL(open)
    3913:	b8 0f 00 00 00       	mov    $0xf,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret

0000391b <mknod>:
SYSCALL(mknod)
    391b:	b8 11 00 00 00       	mov    $0x11,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret

00003923 <unlink>:
SYSCALL(unlink)
    3923:	b8 12 00 00 00       	mov    $0x12,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret

0000392b <fstat>:
SYSCALL(fstat)
    392b:	b8 08 00 00 00       	mov    $0x8,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret

00003933 <link>:
SYSCALL(link)
    3933:	b8 13 00 00 00       	mov    $0x13,%eax
    3938:	cd 40                	int    $0x40
    393a:	c3                   	ret

0000393b <mkdir>:
SYSCALL(mkdir)
    393b:	b8 14 00 00 00       	mov    $0x14,%eax
    3940:	cd 40                	int    $0x40
    3942:	c3                   	ret

00003943 <chdir>:
SYSCALL(chdir)
    3943:	b8 09 00 00 00       	mov    $0x9,%eax
    3948:	cd 40                	int    $0x40
    394a:	c3                   	ret

0000394b <dup>:
SYSCALL(dup)
    394b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3950:	cd 40                	int    $0x40
    3952:	c3                   	ret

00003953 <getpid>:
SYSCALL(getpid)
    3953:	b8 0b 00 00 00       	mov    $0xb,%eax
    3958:	cd 40                	int    $0x40
    395a:	c3                   	ret

0000395b <sbrk>:
SYSCALL(sbrk)
    395b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3960:	cd 40                	int    $0x40
    3962:	c3                   	ret

00003963 <sleep>:
SYSCALL(sleep)
    3963:	b8 0d 00 00 00       	mov    $0xd,%eax
    3968:	cd 40                	int    $0x40
    396a:	c3                   	ret

0000396b <uptime>:
SYSCALL(uptime)
    396b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3970:	cd 40                	int    $0x40
<<<<<<< HEAD
    3972:	c3                   	ret

00003973 <move_file>:
SYSCALL(move_file)
    3973:	b8 17 00 00 00       	mov    $0x17,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret
    397b:	66 90                	xchg   %ax,%ax
    397d:	66 90                	xchg   %ax,%ax
    397f:	90                   	nop
=======
    3972:	c3                   	ret    
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

00003973 <sort_syscalls>:
SYSCALL(sort_syscalls)
    3973:	b8 18 00 00 00       	mov    $0x18,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret    

0000397b <get_most_syscalls>:
SYSCALL(get_most_syscalls)
    397b:	b8 19 00 00 00       	mov    $0x19,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <list_active_processes>:
SYSCALL(list_active_processes)
    3983:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    
    398b:	66 90                	xchg   %ax,%ax
    398d:	66 90                	xchg   %ax,%ax
    398f:	90                   	nop

00003990 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
<<<<<<< HEAD
    3980:	55                   	push   %ebp
    3981:	89 e5                	mov    %esp,%ebp
    3983:	57                   	push   %edi
    3984:	56                   	push   %esi
    3985:	53                   	push   %ebx
    3986:	89 cb                	mov    %ecx,%ebx
=======
    3990:	55                   	push   %ebp
    3991:	89 e5                	mov    %esp,%ebp
    3993:	57                   	push   %edi
    3994:	56                   	push   %esi
    3995:	53                   	push   %ebx
    3996:	83 ec 3c             	sub    $0x3c,%esp
    3999:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
<<<<<<< HEAD
    3988:	89 d1                	mov    %edx,%ecx
{
    398a:	83 ec 3c             	sub    $0x3c,%esp
    398d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    3990:	85 d2                	test   %edx,%edx
    3992:	0f 89 80 00 00 00    	jns    3a18 <printint+0x98>
    3998:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    399c:	74 7a                	je     3a18 <printint+0x98>
    x = -xx;
    399e:	f7 d9                	neg    %ecx
    neg = 1;
    39a0:	b8 01 00 00 00       	mov    $0x1,%eax
=======
    399c:	89 d1                	mov    %edx,%ecx
{
    399e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    39a1:	85 d2                	test   %edx,%edx
    39a3:	0f 89 7f 00 00 00    	jns    3a28 <printint+0x98>
    39a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    39ad:	74 79                	je     3a28 <printint+0x98>
    neg = 1;
    39af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    39b6:	f7 d9                	neg    %ecx
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else {
    x = xx;
  }

  i = 0;
<<<<<<< HEAD
    39a5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    39a8:	31 f6                	xor    %esi,%esi
    39aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    39b0:	89 c8                	mov    %ecx,%eax
    39b2:	31 d2                	xor    %edx,%edx
    39b4:	89 f7                	mov    %esi,%edi
    39b6:	f7 f3                	div    %ebx
    39b8:	8d 76 01             	lea    0x1(%esi),%esi
    39bb:	0f b6 92 20 55 00 00 	movzbl 0x5520(%edx),%edx
    39c2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    39c6:	89 ca                	mov    %ecx,%edx
    39c8:	89 c1                	mov    %eax,%ecx
    39ca:	39 da                	cmp    %ebx,%edx
    39cc:	73 e2                	jae    39b0 <printint+0x30>
  if(neg)
    39ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    39d1:	85 c0                	test   %eax,%eax
    39d3:	74 07                	je     39dc <printint+0x5c>
    buf[i++] = '-';
    39d5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    39da:	89 f7                	mov    %esi,%edi
    39dc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    39df:	8b 75 c0             	mov    -0x40(%ebp),%esi
    39e2:	01 df                	add    %ebx,%edi
    39e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    39e8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    39eb:	83 ec 04             	sub    $0x4,%esp
    39ee:	88 45 d7             	mov    %al,-0x29(%ebp)
    39f1:	8d 45 d7             	lea    -0x29(%ebp),%eax
    39f4:	6a 01                	push   $0x1
    39f6:	50                   	push   %eax
    39f7:	56                   	push   %esi
    39f8:	e8 f6 fe ff ff       	call   38f3 <write>
  while(--i >= 0)
    39fd:	89 f8                	mov    %edi,%eax
    39ff:	83 c4 10             	add    $0x10,%esp
    3a02:	83 ef 01             	sub    $0x1,%edi
    3a05:	39 c3                	cmp    %eax,%ebx
    3a07:	75 df                	jne    39e8 <printint+0x68>
}
    3a09:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a0c:	5b                   	pop    %ebx
    3a0d:	5e                   	pop    %esi
    3a0e:	5f                   	pop    %edi
    3a0f:	5d                   	pop    %ebp
    3a10:	c3                   	ret
    3a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a18:	31 c0                	xor    %eax,%eax
    3a1a:	eb 89                	jmp    39a5 <printint+0x25>
    3a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003a20 <printf>:
=======
    39b8:	31 db                	xor    %ebx,%ebx
    39ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
    39bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    39c0:	89 c8                	mov    %ecx,%eax
    39c2:	31 d2                	xor    %edx,%edx
    39c4:	89 cf                	mov    %ecx,%edi
    39c6:	f7 75 c4             	divl   -0x3c(%ebp)
    39c9:	0f b6 92 60 55 00 00 	movzbl 0x5560(%edx),%edx
    39d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    39d3:	89 d8                	mov    %ebx,%eax
    39d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    39d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    39db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    39de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    39e1:	76 dd                	jbe    39c0 <printint+0x30>
  if(neg)
    39e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    39e6:	85 c9                	test   %ecx,%ecx
    39e8:	74 0c                	je     39f6 <printint+0x66>
    buf[i++] = '-';
    39ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    39ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    39f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    39f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    39f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    39fd:	eb 07                	jmp    3a06 <printint+0x76>
    39ff:	90                   	nop
    putc(fd, buf[i]);
    3a00:	0f b6 13             	movzbl (%ebx),%edx
    3a03:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3a06:	83 ec 04             	sub    $0x4,%esp
    3a09:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3a0c:	6a 01                	push   $0x1
    3a0e:	56                   	push   %esi
    3a0f:	57                   	push   %edi
    3a10:	e8 de fe ff ff       	call   38f3 <write>
  while(--i >= 0)
    3a15:	83 c4 10             	add    $0x10,%esp
    3a18:	39 de                	cmp    %ebx,%esi
    3a1a:	75 e4                	jne    3a00 <printint+0x70>
}
    3a1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a1f:	5b                   	pop    %ebx
    3a20:	5e                   	pop    %esi
    3a21:	5f                   	pop    %edi
    3a22:	5d                   	pop    %ebp
    3a23:	c3                   	ret    
    3a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a28:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3a2f:	eb 87                	jmp    39b8 <printint+0x28>
    3a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a3f:	90                   	nop

00003a40 <printf>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
<<<<<<< HEAD
    3a20:	55                   	push   %ebp
    3a21:	89 e5                	mov    %esp,%ebp
    3a23:	57                   	push   %edi
    3a24:	56                   	push   %esi
    3a25:	53                   	push   %ebx
    3a26:	83 ec 2c             	sub    $0x2c,%esp
=======
    3a40:	55                   	push   %ebp
    3a41:	89 e5                	mov    %esp,%ebp
    3a43:	57                   	push   %edi
    3a44:	56                   	push   %esi
    3a45:	53                   	push   %ebx
    3a46:	83 ec 2c             	sub    $0x2c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
<<<<<<< HEAD
    3a29:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    3a2c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    3a2f:	0f b6 1e             	movzbl (%esi),%ebx
    3a32:	83 c6 01             	add    $0x1,%esi
    3a35:	84 db                	test   %bl,%bl
    3a37:	74 67                	je     3aa0 <printf+0x80>
    3a39:	8d 4d 10             	lea    0x10(%ebp),%ecx
    3a3c:	31 d2                	xor    %edx,%edx
    3a3e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    3a41:	eb 34                	jmp    3a77 <printf+0x57>
    3a43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    3a48:	89 55 d4             	mov    %edx,-0x2c(%ebp)
=======
    3a49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3a4c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3a4f:	0f b6 13             	movzbl (%ebx),%edx
    3a52:	84 d2                	test   %dl,%dl
    3a54:	74 6a                	je     3ac0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3a56:	8d 45 10             	lea    0x10(%ebp),%eax
    3a59:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3a5c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a5f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3a61:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a64:	eb 36                	jmp    3a9c <printf+0x5c>
    3a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a6d:	8d 76 00             	lea    0x0(%esi),%esi
    3a70:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
<<<<<<< HEAD
    3a4b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3a50:	83 f8 25             	cmp    $0x25,%eax
    3a53:	74 18                	je     3a6d <printf+0x4d>
  write(fd, &c, 1);
    3a55:	83 ec 04             	sub    $0x4,%esp
    3a58:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3a5b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3a5e:	6a 01                	push   $0x1
    3a60:	50                   	push   %eax
    3a61:	57                   	push   %edi
    3a62:	e8 8c fe ff ff       	call   38f3 <write>
    3a67:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3a6a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a6d:	0f b6 1e             	movzbl (%esi),%ebx
    3a70:	83 c6 01             	add    $0x1,%esi
    3a73:	84 db                	test   %bl,%bl
    3a75:	74 29                	je     3aa0 <printf+0x80>
    c = fmt[i] & 0xff;
    3a77:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a7a:	85 d2                	test   %edx,%edx
    3a7c:	74 ca                	je     3a48 <printf+0x28>
      }
    } else if(state == '%'){
    3a7e:	83 fa 25             	cmp    $0x25,%edx
    3a81:	75 ea                	jne    3a6d <printf+0x4d>
      if(c == 'd'){
    3a83:	83 f8 25             	cmp    $0x25,%eax
    3a86:	0f 84 04 01 00 00    	je     3b90 <printf+0x170>
    3a8c:	83 e8 63             	sub    $0x63,%eax
    3a8f:	83 f8 15             	cmp    $0x15,%eax
    3a92:	77 1c                	ja     3ab0 <printf+0x90>
    3a94:	ff 24 85 c8 54 00 00 	jmp    *0x54c8(,%eax,4)
    3a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
=======
    3a73:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3a78:	83 f8 25             	cmp    $0x25,%eax
    3a7b:	74 15                	je     3a92 <printf+0x52>
  write(fd, &c, 1);
    3a7d:	83 ec 04             	sub    $0x4,%esp
    3a80:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3a83:	6a 01                	push   $0x1
    3a85:	57                   	push   %edi
    3a86:	56                   	push   %esi
    3a87:	e8 67 fe ff ff       	call   38f3 <write>
    3a8c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3a8f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a92:	0f b6 13             	movzbl (%ebx),%edx
    3a95:	83 c3 01             	add    $0x1,%ebx
    3a98:	84 d2                	test   %dl,%dl
    3a9a:	74 24                	je     3ac0 <printf+0x80>
    c = fmt[i] & 0xff;
    3a9c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3a9f:	85 c9                	test   %ecx,%ecx
    3aa1:	74 cd                	je     3a70 <printf+0x30>
      }
    } else if(state == '%'){
    3aa3:	83 f9 25             	cmp    $0x25,%ecx
    3aa6:	75 ea                	jne    3a92 <printf+0x52>
      if(c == 'd'){
    3aa8:	83 f8 25             	cmp    $0x25,%eax
    3aab:	0f 84 07 01 00 00    	je     3bb8 <printf+0x178>
    3ab1:	83 e8 63             	sub    $0x63,%eax
    3ab4:	83 f8 15             	cmp    $0x15,%eax
    3ab7:	77 17                	ja     3ad0 <printf+0x90>
    3ab9:	ff 24 85 08 55 00 00 	jmp    *0x5508(,%eax,4)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        putc(fd, c);
      }
      state = 0;
    }
  }
}
<<<<<<< HEAD
    3aa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3aa3:	5b                   	pop    %ebx
    3aa4:	5e                   	pop    %esi
    3aa5:	5f                   	pop    %edi
    3aa6:	5d                   	pop    %ebp
    3aa7:	c3                   	ret
    3aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3aaf:	00 
  write(fd, &c, 1);
    3ab0:	83 ec 04             	sub    $0x4,%esp
    3ab3:	8d 55 e7             	lea    -0x19(%ebp),%edx
    3ab6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3aba:	6a 01                	push   $0x1
    3abc:	52                   	push   %edx
    3abd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    3ac0:	57                   	push   %edi
    3ac1:	e8 2d fe ff ff       	call   38f3 <write>
    3ac6:	83 c4 0c             	add    $0xc,%esp
    3ac9:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3acc:	6a 01                	push   $0x1
    3ace:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3ad1:	52                   	push   %edx
    3ad2:	57                   	push   %edi
    3ad3:	e8 1b fe ff ff       	call   38f3 <write>
        putc(fd, c);
    3ad8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3adb:	31 d2                	xor    %edx,%edx
    3add:	eb 8e                	jmp    3a6d <printf+0x4d>
    3adf:	90                   	nop
        printint(fd, *ap, 16, 0);
    3ae0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3ae3:	83 ec 0c             	sub    $0xc,%esp
    3ae6:	b9 10 00 00 00       	mov    $0x10,%ecx
    3aeb:	8b 13                	mov    (%ebx),%edx
    3aed:	6a 00                	push   $0x0
    3aef:	89 f8                	mov    %edi,%eax
        ap++;
    3af1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    3af4:	e8 87 fe ff ff       	call   3980 <printint>
        ap++;
    3af9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3afc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3aff:	31 d2                	xor    %edx,%edx
    3b01:	e9 67 ff ff ff       	jmp    3a6d <printf+0x4d>
        s = (char*)*ap;
    3b06:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b09:	8b 18                	mov    (%eax),%ebx
        ap++;
    3b0b:	83 c0 04             	add    $0x4,%eax
    3b0e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3b11:	85 db                	test   %ebx,%ebx
    3b13:	0f 84 87 00 00 00    	je     3ba0 <printf+0x180>
        while(*s != 0){
    3b19:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    3b1c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    3b1e:	84 c0                	test   %al,%al
    3b20:	0f 84 47 ff ff ff    	je     3a6d <printf+0x4d>
    3b26:	8d 55 e7             	lea    -0x19(%ebp),%edx
    3b29:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3b2c:	89 de                	mov    %ebx,%esi
    3b2e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    3b30:	83 ec 04             	sub    $0x4,%esp
    3b33:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    3b36:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3b39:	6a 01                	push   $0x1
    3b3b:	53                   	push   %ebx
    3b3c:	57                   	push   %edi
    3b3d:	e8 b1 fd ff ff       	call   38f3 <write>
        while(*s != 0){
    3b42:	0f b6 06             	movzbl (%esi),%eax
    3b45:	83 c4 10             	add    $0x10,%esp
    3b48:	84 c0                	test   %al,%al
    3b4a:	75 e4                	jne    3b30 <printf+0x110>
      state = 0;
    3b4c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    3b4f:	31 d2                	xor    %edx,%edx
    3b51:	e9 17 ff ff ff       	jmp    3a6d <printf+0x4d>
        printint(fd, *ap, 10, 1);
    3b56:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3b59:	83 ec 0c             	sub    $0xc,%esp
    3b5c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b61:	8b 13                	mov    (%ebx),%edx
    3b63:	6a 01                	push   $0x1
    3b65:	eb 88                	jmp    3aef <printf+0xcf>
        putc(fd, *ap);
    3b67:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    3b6a:	83 ec 04             	sub    $0x4,%esp
    3b6d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    3b70:	8b 03                	mov    (%ebx),%eax
        ap++;
    3b72:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    3b75:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b78:	6a 01                	push   $0x1
    3b7a:	52                   	push   %edx
    3b7b:	57                   	push   %edi
    3b7c:	e8 72 fd ff ff       	call   38f3 <write>
        ap++;
    3b81:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3b84:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b87:	31 d2                	xor    %edx,%edx
    3b89:	e9 df fe ff ff       	jmp    3a6d <printf+0x4d>
    3b8e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    3b90:	83 ec 04             	sub    $0x4,%esp
    3b93:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3b96:	8d 55 e7             	lea    -0x19(%ebp),%edx
    3b99:	6a 01                	push   $0x1
    3b9b:	e9 31 ff ff ff       	jmp    3ad1 <printf+0xb1>
    3ba0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    3ba5:	bb 49 4d 00 00       	mov    $0x4d49,%ebx
    3baa:	e9 77 ff ff ff       	jmp    3b26 <printf+0x106>
    3baf:	90                   	nop

00003bb0 <free>:
=======
    3ac0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3ac3:	5b                   	pop    %ebx
    3ac4:	5e                   	pop    %esi
    3ac5:	5f                   	pop    %edi
    3ac6:	5d                   	pop    %ebp
    3ac7:	c3                   	ret    
    3ac8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3acf:	90                   	nop
  write(fd, &c, 1);
    3ad0:	83 ec 04             	sub    $0x4,%esp
    3ad3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3ad6:	6a 01                	push   $0x1
    3ad8:	57                   	push   %edi
    3ad9:	56                   	push   %esi
    3ada:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3ade:	e8 10 fe ff ff       	call   38f3 <write>
        putc(fd, c);
    3ae3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3ae7:	83 c4 0c             	add    $0xc,%esp
    3aea:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3aed:	6a 01                	push   $0x1
    3aef:	57                   	push   %edi
    3af0:	56                   	push   %esi
    3af1:	e8 fd fd ff ff       	call   38f3 <write>
        putc(fd, c);
    3af6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3af9:	31 c9                	xor    %ecx,%ecx
    3afb:	eb 95                	jmp    3a92 <printf+0x52>
    3afd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3b00:	83 ec 0c             	sub    $0xc,%esp
    3b03:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b08:	6a 00                	push   $0x0
    3b0a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b0d:	8b 10                	mov    (%eax),%edx
    3b0f:	89 f0                	mov    %esi,%eax
    3b11:	e8 7a fe ff ff       	call   3990 <printint>
        ap++;
    3b16:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3b1a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b1d:	31 c9                	xor    %ecx,%ecx
    3b1f:	e9 6e ff ff ff       	jmp    3a92 <printf+0x52>
    3b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3b28:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b2b:	8b 10                	mov    (%eax),%edx
        ap++;
    3b2d:	83 c0 04             	add    $0x4,%eax
    3b30:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3b33:	85 d2                	test   %edx,%edx
    3b35:	0f 84 8d 00 00 00    	je     3bc8 <printf+0x188>
        while(*s != 0){
    3b3b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3b3e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3b40:	84 c0                	test   %al,%al
    3b42:	0f 84 4a ff ff ff    	je     3a92 <printf+0x52>
    3b48:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3b4b:	89 d3                	mov    %edx,%ebx
    3b4d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b50:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b53:	83 c3 01             	add    $0x1,%ebx
    3b56:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b59:	6a 01                	push   $0x1
    3b5b:	57                   	push   %edi
    3b5c:	56                   	push   %esi
    3b5d:	e8 91 fd ff ff       	call   38f3 <write>
        while(*s != 0){
    3b62:	0f b6 03             	movzbl (%ebx),%eax
    3b65:	83 c4 10             	add    $0x10,%esp
    3b68:	84 c0                	test   %al,%al
    3b6a:	75 e4                	jne    3b50 <printf+0x110>
      state = 0;
    3b6c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3b6f:	31 c9                	xor    %ecx,%ecx
    3b71:	e9 1c ff ff ff       	jmp    3a92 <printf+0x52>
    3b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b7d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3b80:	83 ec 0c             	sub    $0xc,%esp
    3b83:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b88:	6a 01                	push   $0x1
    3b8a:	e9 7b ff ff ff       	jmp    3b0a <printf+0xca>
    3b8f:	90                   	nop
        putc(fd, *ap);
    3b90:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3b93:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b96:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3b98:	6a 01                	push   $0x1
    3b9a:	57                   	push   %edi
    3b9b:	56                   	push   %esi
        putc(fd, *ap);
    3b9c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b9f:	e8 4f fd ff ff       	call   38f3 <write>
        ap++;
    3ba4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3ba8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3bab:	31 c9                	xor    %ecx,%ecx
    3bad:	e9 e0 fe ff ff       	jmp    3a92 <printf+0x52>
    3bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3bb8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3bbb:	83 ec 04             	sub    $0x4,%esp
    3bbe:	e9 2a ff ff ff       	jmp    3aed <printf+0xad>
    3bc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3bc7:	90                   	nop
          s = "(null)";
    3bc8:	ba fe 54 00 00       	mov    $0x54fe,%edx
        while(*s != 0){
    3bcd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3bd0:	b8 28 00 00 00       	mov    $0x28,%eax
    3bd5:	89 d3                	mov    %edx,%ebx
    3bd7:	e9 74 ff ff ff       	jmp    3b50 <printf+0x110>
    3bdc:	66 90                	xchg   %ax,%ax
    3bde:	66 90                	xchg   %ax,%ax

00003be0 <free>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
static Header base;
static Header *freep;

void
free(void *ap)
{
<<<<<<< HEAD
    3bb0:	55                   	push   %ebp
=======
    3be0:	55                   	push   %ebp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
<<<<<<< HEAD
    3bb1:	a1 c0 a5 00 00       	mov    0xa5c0,%eax
{
    3bb6:	89 e5                	mov    %esp,%ebp
    3bb8:	57                   	push   %edi
    3bb9:	56                   	push   %esi
    3bba:	53                   	push   %ebx
    3bbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bc8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bca:	39 c8                	cmp    %ecx,%eax
    3bcc:	73 32                	jae    3c00 <free+0x50>
    3bce:	39 d1                	cmp    %edx,%ecx
    3bd0:	72 04                	jb     3bd6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bd2:	39 d0                	cmp    %edx,%eax
    3bd4:	72 32                	jb     3c08 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3bd6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3bd9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bdc:	39 fa                	cmp    %edi,%edx
    3bde:	74 30                	je     3c10 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3be0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3be3:	8b 50 04             	mov    0x4(%eax),%edx
    3be6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3be9:	39 f1                	cmp    %esi,%ecx
    3beb:	74 3a                	je     3c27 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3bed:	89 08                	mov    %ecx,(%eax)
=======
    3be1:	a1 20 a6 00 00       	mov    0xa620,%eax
{
    3be6:	89 e5                	mov    %esp,%ebp
    3be8:	57                   	push   %edi
    3be9:	56                   	push   %esi
    3bea:	53                   	push   %ebx
    3beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bf8:	89 c2                	mov    %eax,%edx
    3bfa:	8b 00                	mov    (%eax),%eax
    3bfc:	39 ca                	cmp    %ecx,%edx
    3bfe:	73 30                	jae    3c30 <free+0x50>
    3c00:	39 c1                	cmp    %eax,%ecx
    3c02:	72 04                	jb     3c08 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c04:	39 c2                	cmp    %eax,%edx
    3c06:	72 f0                	jb     3bf8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c08:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c0b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c0e:	39 f8                	cmp    %edi,%eax
    3c10:	74 30                	je     3c42 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3c12:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3c15:	8b 42 04             	mov    0x4(%edx),%eax
    3c18:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c1b:	39 f1                	cmp    %esi,%ecx
    3c1d:	74 3a                	je     3c59 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3c1f:	89 0a                	mov    %ecx,(%edx)
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  } else
    p->s.ptr = bp;
  freep = p;
}
<<<<<<< HEAD
    3bef:	5b                   	pop    %ebx
  freep = p;
    3bf0:	a3 c0 a5 00 00       	mov    %eax,0xa5c0
}
    3bf5:	5e                   	pop    %esi
    3bf6:	5f                   	pop    %edi
    3bf7:	5d                   	pop    %ebp
    3bf8:	c3                   	ret
    3bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c00:	39 d0                	cmp    %edx,%eax
    3c02:	72 04                	jb     3c08 <free+0x58>
    3c04:	39 d1                	cmp    %edx,%ecx
    3c06:	72 ce                	jb     3bd6 <free+0x26>
{
    3c08:	89 d0                	mov    %edx,%eax
    3c0a:	eb bc                	jmp    3bc8 <free+0x18>
    3c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    3c10:	03 72 04             	add    0x4(%edx),%esi
    3c13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c16:	8b 10                	mov    (%eax),%edx
    3c18:	8b 12                	mov    (%edx),%edx
    3c1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c1d:	8b 50 04             	mov    0x4(%eax),%edx
    3c20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c23:	39 f1                	cmp    %esi,%ecx
    3c25:	75 c6                	jne    3bed <free+0x3d>
    p->s.size += bp->s.size;
    3c27:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3c2a:	a3 c0 a5 00 00       	mov    %eax,0xa5c0
    p->s.size += bp->s.size;
    3c2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3c32:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3c35:	89 08                	mov    %ecx,(%eax)
}
    3c37:	5b                   	pop    %ebx
    3c38:	5e                   	pop    %esi
    3c39:	5f                   	pop    %edi
    3c3a:	5d                   	pop    %ebp
    3c3b:	c3                   	ret
    3c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c40 <malloc>:
=======
    3c21:	5b                   	pop    %ebx
  freep = p;
    3c22:	89 15 20 a6 00 00    	mov    %edx,0xa620
}
    3c28:	5e                   	pop    %esi
    3c29:	5f                   	pop    %edi
    3c2a:	5d                   	pop    %ebp
    3c2b:	c3                   	ret    
    3c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c30:	39 c2                	cmp    %eax,%edx
    3c32:	72 c4                	jb     3bf8 <free+0x18>
    3c34:	39 c1                	cmp    %eax,%ecx
    3c36:	73 c0                	jae    3bf8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3c38:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c3b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c3e:	39 f8                	cmp    %edi,%eax
    3c40:	75 d0                	jne    3c12 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3c42:	03 70 04             	add    0x4(%eax),%esi
    3c45:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c48:	8b 02                	mov    (%edx),%eax
    3c4a:	8b 00                	mov    (%eax),%eax
    3c4c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c4f:	8b 42 04             	mov    0x4(%edx),%eax
    3c52:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c55:	39 f1                	cmp    %esi,%ecx
    3c57:	75 c6                	jne    3c1f <free+0x3f>
    p->s.size += bp->s.size;
    3c59:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3c5c:	89 15 20 a6 00 00    	mov    %edx,0xa620
    p->s.size += bp->s.size;
    3c62:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3c65:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3c68:	89 0a                	mov    %ecx,(%edx)
}
    3c6a:	5b                   	pop    %ebx
    3c6b:	5e                   	pop    %esi
    3c6c:	5f                   	pop    %edi
    3c6d:	5d                   	pop    %ebp
    3c6e:	c3                   	ret    
    3c6f:	90                   	nop

00003c70 <malloc>:
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  return freep;
}

void*
malloc(uint nbytes)
{
<<<<<<< HEAD
    3c40:	55                   	push   %ebp
    3c41:	89 e5                	mov    %esp,%ebp
    3c43:	57                   	push   %edi
    3c44:	56                   	push   %esi
    3c45:	53                   	push   %ebx
    3c46:	83 ec 0c             	sub    $0xc,%esp
=======
    3c70:	55                   	push   %ebp
    3c71:	89 e5                	mov    %esp,%ebp
    3c73:	57                   	push   %edi
    3c74:	56                   	push   %esi
    3c75:	53                   	push   %ebx
    3c76:	83 ec 1c             	sub    $0x1c,%esp
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
<<<<<<< HEAD
    3c49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c4c:	8b 15 c0 a5 00 00    	mov    0xa5c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c52:	8d 78 07             	lea    0x7(%eax),%edi
    3c55:	c1 ef 03             	shr    $0x3,%edi
    3c58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3c5b:	85 d2                	test   %edx,%edx
    3c5d:	0f 84 8d 00 00 00    	je     3cf0 <malloc+0xb0>
=======
    3c79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c7c:	8b 3d 20 a6 00 00    	mov    0xa620,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c82:	8d 70 07             	lea    0x7(%eax),%esi
    3c85:	c1 ee 03             	shr    $0x3,%esi
    3c88:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3c8b:	85 ff                	test   %edi,%edi
    3c8d:	0f 84 9d 00 00 00    	je     3d30 <malloc+0xc0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
<<<<<<< HEAD
    3c63:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3c65:	8b 48 04             	mov    0x4(%eax),%ecx
    3c68:	39 f9                	cmp    %edi,%ecx
    3c6a:	73 64                	jae    3cd0 <malloc+0x90>
  if(nu < 4096)
    3c6c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c71:	39 df                	cmp    %ebx,%edi
    3c73:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    3c76:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3c7d:	eb 0a                	jmp    3c89 <malloc+0x49>
    3c7f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c80:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3c82:	8b 48 04             	mov    0x4(%eax),%ecx
    3c85:	39 f9                	cmp    %edi,%ecx
    3c87:	73 47                	jae    3cd0 <malloc+0x90>
=======
    3c93:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3c95:	8b 4a 04             	mov    0x4(%edx),%ecx
    3c98:	39 f1                	cmp    %esi,%ecx
    3c9a:	73 6a                	jae    3d06 <malloc+0x96>
    3c9c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3ca1:	39 de                	cmp    %ebx,%esi
    3ca3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3ca6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3cad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3cb0:	eb 17                	jmp    3cc9 <malloc+0x59>
    3cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3cb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3cba:	8b 48 04             	mov    0x4(%eax),%ecx
    3cbd:	39 f1                	cmp    %esi,%ecx
    3cbf:	73 4f                	jae    3d10 <malloc+0xa0>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
<<<<<<< HEAD
    3c89:	89 c2                	mov    %eax,%edx
    3c8b:	3b 05 c0 a5 00 00    	cmp    0xa5c0,%eax
    3c91:	75 ed                	jne    3c80 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    3c93:	83 ec 0c             	sub    $0xc,%esp
    3c96:	56                   	push   %esi
    3c97:	e8 bf fc ff ff       	call   395b <sbrk>
  if(p == (char*)-1)
    3c9c:	83 c4 10             	add    $0x10,%esp
    3c9f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3ca2:	74 1c                	je     3cc0 <malloc+0x80>
  hp->s.size = nu;
    3ca4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3ca7:	83 ec 0c             	sub    $0xc,%esp
    3caa:	83 c0 08             	add    $0x8,%eax
    3cad:	50                   	push   %eax
    3cae:	e8 fd fe ff ff       	call   3bb0 <free>
  return freep;
    3cb3:	8b 15 c0 a5 00 00    	mov    0xa5c0,%edx
      if((p = morecore(nunits)) == 0)
    3cb9:	83 c4 10             	add    $0x10,%esp
    3cbc:	85 d2                	test   %edx,%edx
    3cbe:	75 c0                	jne    3c80 <malloc+0x40>
        return 0;
  }
}
    3cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3cc3:	31 c0                	xor    %eax,%eax
}
    3cc5:	5b                   	pop    %ebx
    3cc6:	5e                   	pop    %esi
    3cc7:	5f                   	pop    %edi
    3cc8:	5d                   	pop    %ebp
    3cc9:	c3                   	ret
    3cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3cd0:	39 cf                	cmp    %ecx,%edi
    3cd2:	74 4c                	je     3d20 <malloc+0xe0>
        p->s.size -= nunits;
    3cd4:	29 f9                	sub    %edi,%ecx
    3cd6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3cd9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3cdc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3cdf:	89 15 c0 a5 00 00    	mov    %edx,0xa5c0
}
    3ce5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3ce8:	83 c0 08             	add    $0x8,%eax
}
    3ceb:	5b                   	pop    %ebx
    3cec:	5e                   	pop    %esi
    3ced:	5f                   	pop    %edi
    3cee:	5d                   	pop    %ebp
    3cef:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    3cf0:	c7 05 c0 a5 00 00 c4 	movl   $0xa5c4,0xa5c0
    3cf7:	a5 00 00 
    base.s.size = 0;
    3cfa:	b8 c4 a5 00 00       	mov    $0xa5c4,%eax
    base.s.ptr = freep = prevp = &base;
    3cff:	c7 05 c4 a5 00 00 c4 	movl   $0xa5c4,0xa5c4
    3d06:	a5 00 00 
    base.s.size = 0;
    3d09:	c7 05 c8 a5 00 00 00 	movl   $0x0,0xa5c8
    3d10:	00 00 00 
    if(p->s.size >= nunits){
    3d13:	e9 54 ff ff ff       	jmp    3c6c <malloc+0x2c>
    3d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3d1f:	00 
        prevp->s.ptr = p->s.ptr;
    3d20:	8b 08                	mov    (%eax),%ecx
    3d22:	89 0a                	mov    %ecx,(%edx)
    3d24:	eb b9                	jmp    3cdf <malloc+0x9f>
=======
    3cc1:	8b 3d 20 a6 00 00    	mov    0xa620,%edi
    3cc7:	89 c2                	mov    %eax,%edx
    3cc9:	39 d7                	cmp    %edx,%edi
    3ccb:	75 eb                	jne    3cb8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3ccd:	83 ec 0c             	sub    $0xc,%esp
    3cd0:	ff 75 e4             	push   -0x1c(%ebp)
    3cd3:	e8 83 fc ff ff       	call   395b <sbrk>
  if(p == (char*)-1)
    3cd8:	83 c4 10             	add    $0x10,%esp
    3cdb:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cde:	74 1c                	je     3cfc <malloc+0x8c>
  hp->s.size = nu;
    3ce0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3ce3:	83 ec 0c             	sub    $0xc,%esp
    3ce6:	83 c0 08             	add    $0x8,%eax
    3ce9:	50                   	push   %eax
    3cea:	e8 f1 fe ff ff       	call   3be0 <free>
  return freep;
    3cef:	8b 15 20 a6 00 00    	mov    0xa620,%edx
      if((p = morecore(nunits)) == 0)
    3cf5:	83 c4 10             	add    $0x10,%esp
    3cf8:	85 d2                	test   %edx,%edx
    3cfa:	75 bc                	jne    3cb8 <malloc+0x48>
        return 0;
  }
}
    3cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3cff:	31 c0                	xor    %eax,%eax
}
    3d01:	5b                   	pop    %ebx
    3d02:	5e                   	pop    %esi
    3d03:	5f                   	pop    %edi
    3d04:	5d                   	pop    %ebp
    3d05:	c3                   	ret    
    if(p->s.size >= nunits){
    3d06:	89 d0                	mov    %edx,%eax
    3d08:	89 fa                	mov    %edi,%edx
    3d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3d10:	39 ce                	cmp    %ecx,%esi
    3d12:	74 4c                	je     3d60 <malloc+0xf0>
        p->s.size -= nunits;
    3d14:	29 f1                	sub    %esi,%ecx
    3d16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3d19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3d1c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    3d1f:	89 15 20 a6 00 00    	mov    %edx,0xa620
}
    3d25:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d28:	83 c0 08             	add    $0x8,%eax
}
    3d2b:	5b                   	pop    %ebx
    3d2c:	5e                   	pop    %esi
    3d2d:	5f                   	pop    %edi
    3d2e:	5d                   	pop    %ebp
    3d2f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3d30:	c7 05 20 a6 00 00 24 	movl   $0xa624,0xa620
    3d37:	a6 00 00 
    base.s.size = 0;
    3d3a:	bf 24 a6 00 00       	mov    $0xa624,%edi
    base.s.ptr = freep = prevp = &base;
    3d3f:	c7 05 24 a6 00 00 24 	movl   $0xa624,0xa624
    3d46:	a6 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d49:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    3d4b:	c7 05 28 a6 00 00 00 	movl   $0x0,0xa628
    3d52:	00 00 00 
    if(p->s.size >= nunits){
    3d55:	e9 42 ff ff ff       	jmp    3c9c <malloc+0x2c>
    3d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3d60:	8b 08                	mov    (%eax),%ecx
    3d62:	89 0a                	mov    %ecx,(%edx)
    3d64:	eb b9                	jmp    3d1f <malloc+0xaf>
>>>>>>> 0c92ca4dcf5535cd18046519fa90238b0fce8398
