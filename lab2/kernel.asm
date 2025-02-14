
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 98 11 80       	mov    $0x80119870,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 3d 10 80       	mov    $0x80103d80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb b4 c5 10 80       	mov    $0x8010c5b4,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 20 85 10 80       	push   $0x80108520
80100051:	68 80 c5 10 80       	push   $0x8010c580
80100056:	e8 75 52 00 00       	call   801052d0 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 7c 0c 11 80       	mov    $0x80110c7c,%eax
80100063:	c7 05 cc 0c 11 80 7c 	movl   $0x80110c7c,0x80110ccc
8010006a:	0c 11 80 
8010006d:	c7 05 d0 0c 11 80 7c 	movl   $0x80110c7c,0x80110cd0
80100074:	0c 11 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%ebx)
80100092:	68 27 85 10 80       	push   $0x80108527
80100097:	50                   	push   %eax
80100098:	e8 03 51 00 00       	call   801051a0 <initsleeplock>
8010009d:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d d0 0c 11 80    	mov    %ebx,0x80110cd0
801000b6:	81 fb 20 0a 11 80    	cmp    $0x80110a20,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 80 c5 10 80       	push   $0x8010c580
801000e4:	e8 b7 53 00 00       	call   801054a0 <acquire>
801000e9:	8b 1d d0 0c 11 80    	mov    0x80110cd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100120:	8b 1d cc 0c 11 80    	mov    0x80110ccc,%ebx
80100126:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 c5 10 80       	push   $0x8010c580
80100162:	e8 d9 52 00 00       	call   80105440 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 50 00 00       	call   801051e0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 8f 2e 00 00       	call   80103020 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 2e 85 10 80       	push   $0x8010852e
801001a6:	e8 45 03 00 00       	call   801004f0 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 bd 50 00 00       	call   80105280 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 47 2e 00 00       	jmp    80103020 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 3f 85 10 80       	push   $0x8010853f
801001e1:	e8 0a 03 00 00       	call   801004f0 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 50 00 00       	call   80105280 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 50 00 00       	call   80105240 <releasesleep>
80100214:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
8010021b:	e8 80 52 00 00       	call   801054a0 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
8010023f:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
80100244:	c7 43 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%ebx)
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
8010024e:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
80100256:	89 1d d0 0c 11 80    	mov    %ebx,0x80110cd0
8010025c:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
80100269:	e9 d2 51 00 00       	jmp    80105440 <release>
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 46 85 10 80       	push   $0x80108546
80100276:	e8 75 02 00 00       	call   801004f0 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <int_to_str>:




static int int_to_str(int num, char str[]) 
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 04             	sub    $0x4,%esp
80100289:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
    int i = 0;
    int is_negative = 0;
8010028f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (num < 0) {
80100296:	85 c9                	test   %ecx,%ecx
80100298:	0f 88 82 00 00 00    	js     80100320 <int_to_str+0xa0>
        is_negative = 1;
8010029e:	31 ff                	xor    %edi,%edi
        num = -num;
    }
    do {
        str[i++] = (num % 10) + '0';
801002a0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
801002a5:	89 fb                	mov    %edi,%ebx
801002a7:	83 c7 01             	add    $0x1,%edi
801002aa:	f7 e1                	mul    %ecx
801002ac:	c1 ea 03             	shr    $0x3,%edx
801002af:	8d 04 92             	lea    (%edx,%edx,4),%eax
801002b2:	01 c0                	add    %eax,%eax
801002b4:	29 c1                	sub    %eax,%ecx
801002b6:	83 c1 30             	add    $0x30,%ecx
801002b9:	88 4c 3e ff          	mov    %cl,-0x1(%esi,%edi,1)
        num /= 10;
801002bd:	89 d1                	mov    %edx,%ecx
    } while (num != 0);
801002bf:	85 d2                	test   %edx,%edx
801002c1:	75 dd                	jne    801002a0 <int_to_str+0x20>
    if (is_negative) {
801002c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
        str[i++] = '-';
801002c6:	8d 04 3e             	lea    (%esi,%edi,1),%eax
    if (is_negative) {
801002c9:	85 d2                	test   %edx,%edx
801002cb:	74 3b                	je     80100308 <int_to_str+0x88>
        str[i++] = '-';
801002cd:	8d 53 02             	lea    0x2(%ebx),%edx
801002d0:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    str[i] = '\0';
801002d3:	c6 44 1e 02 00       	movb   $0x0,0x2(%esi,%ebx,1)
        str[i++] = (num % 10) + '0';
801002d8:	89 fb                	mov    %edi,%ebx
        str[i++] = '-';
801002da:	89 d7                	mov    %edx,%edi
801002dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          char temp = str[start];
801002e0:	0f b6 14 0e          	movzbl (%esi,%ecx,1),%edx
          str[start] = str[end];
801002e4:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801002e8:	88 04 0e             	mov    %al,(%esi,%ecx,1)
          start++;
801002eb:	83 c1 01             	add    $0x1,%ecx
          str[end] = temp;
801002ee:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
          end--;
801002f1:	83 eb 01             	sub    $0x1,%ebx
      while (start < end) 
801002f4:	39 d9                	cmp    %ebx,%ecx
801002f6:	7c e8                	jl     801002e0 <int_to_str+0x60>
    reverse(str, i);
    return i;
}
801002f8:	83 c4 04             	add    $0x4,%esp
801002fb:	89 f8                	mov    %edi,%eax
801002fd:	5b                   	pop    %ebx
801002fe:	5e                   	pop    %esi
801002ff:	5f                   	pop    %edi
80100300:	5d                   	pop    %ebp
80100301:	c3                   	ret    
80100302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    str[i] = '\0';
80100308:	c6 00 00             	movb   $0x0,(%eax)
      while (start < end) 
8010030b:	85 db                	test   %ebx,%ebx
8010030d:	75 d1                	jne    801002e0 <int_to_str+0x60>
}
8010030f:	83 c4 04             	add    $0x4,%esp
80100312:	89 f8                	mov    %edi,%eax
80100314:	5b                   	pop    %ebx
80100315:	5e                   	pop    %esi
80100316:	5f                   	pop    %edi
80100317:	5d                   	pop    %ebp
80100318:	c3                   	ret    
80100319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        is_negative = 1;
80100320:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        num = -num;
80100327:	f7 d9                	neg    %ecx
80100329:	e9 70 ff ff ff       	jmp    8010029e <int_to_str+0x1e>
8010032e:	66 90                	xchg   %ax,%ax

80100330 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100330:	55                   	push   %ebp
80100331:	89 e5                	mov    %esp,%ebp
80100333:	57                   	push   %edi
80100334:	56                   	push   %esi
80100335:	53                   	push   %ebx
80100336:	83 ec 18             	sub    $0x18,%esp
80100339:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010033c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010033f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100342:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100344:	e8 47 22 00 00       	call   80102590 <iunlock>
  acquire(&cons.lock);
80100349:	c7 04 24 c0 15 11 80 	movl   $0x801115c0,(%esp)
80100350:	e8 4b 51 00 00       	call   801054a0 <acquire>
  while(n > 0){
80100355:	83 c4 10             	add    $0x10,%esp
80100358:	85 db                	test   %ebx,%ebx
8010035a:	0f 8e 9c 00 00 00    	jle    801003fc <consoleread+0xcc>
    while(input.r == input.w){
80100360:	a1 a0 15 11 80       	mov    0x801115a0,%eax
80100365:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
8010036b:	74 25                	je     80100392 <consoleread+0x62>
8010036d:	eb 61                	jmp    801003d0 <consoleread+0xa0>
8010036f:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100370:	83 ec 08             	sub    $0x8,%esp
80100373:	68 c0 15 11 80       	push   $0x801115c0
80100378:	68 a0 15 11 80       	push   $0x801115a0
8010037d:	e8 0e 4b 00 00       	call   80104e90 <sleep>
    while(input.r == input.w){
80100382:	a1 a0 15 11 80       	mov    0x801115a0,%eax
80100387:	83 c4 10             	add    $0x10,%esp
8010038a:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
80100390:	75 3e                	jne    801003d0 <consoleread+0xa0>
      if(myproc()->killed){
80100392:	e8 39 43 00 00       	call   801046d0 <myproc>
80100397:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010039d:	85 c9                	test   %ecx,%ecx
8010039f:	74 cf                	je     80100370 <consoleread+0x40>
        release(&cons.lock);
801003a1:	83 ec 0c             	sub    $0xc,%esp
801003a4:	68 c0 15 11 80       	push   $0x801115c0
801003a9:	e8 92 50 00 00       	call   80105440 <release>
        ilock(ip);
801003ae:	5a                   	pop    %edx
801003af:	ff 75 08             	push   0x8(%ebp)
801003b2:	e8 f9 20 00 00       	call   801024b0 <ilock>
        return -1;
801003b7:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801003ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
801003bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801003c2:	5b                   	pop    %ebx
801003c3:	5e                   	pop    %esi
801003c4:	5f                   	pop    %edi
801003c5:	5d                   	pop    %ebp
801003c6:	c3                   	ret    
801003c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003ce:	66 90                	xchg   %ax,%ax
    c = input.buf[input.r++ % INPUT_BUF];
801003d0:	8d 50 01             	lea    0x1(%eax),%edx
801003d3:	89 15 a0 15 11 80    	mov    %edx,0x801115a0
801003d9:	89 c2                	mov    %eax,%edx
801003db:	83 e2 7f             	and    $0x7f,%edx
801003de:	0f be 8a 20 15 11 80 	movsbl -0x7feeeae0(%edx),%ecx
    if(c == C('D')){  // EOF
801003e5:	80 f9 04             	cmp    $0x4,%cl
801003e8:	74 37                	je     80100421 <consoleread+0xf1>
    *dst++ = c;
801003ea:	83 c6 01             	add    $0x1,%esi
    --n;
801003ed:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
801003f0:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801003f3:	83 f9 0a             	cmp    $0xa,%ecx
801003f6:	0f 85 5c ff ff ff    	jne    80100358 <consoleread+0x28>
  release(&cons.lock);
801003fc:	83 ec 0c             	sub    $0xc,%esp
801003ff:	68 c0 15 11 80       	push   $0x801115c0
80100404:	e8 37 50 00 00       	call   80105440 <release>
  ilock(ip);
80100409:	58                   	pop    %eax
8010040a:	ff 75 08             	push   0x8(%ebp)
8010040d:	e8 9e 20 00 00       	call   801024b0 <ilock>
  return target - n;
80100412:	89 f8                	mov    %edi,%eax
80100414:	83 c4 10             	add    $0x10,%esp
}
80100417:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010041a:	29 d8                	sub    %ebx,%eax
}
8010041c:	5b                   	pop    %ebx
8010041d:	5e                   	pop    %esi
8010041e:	5f                   	pop    %edi
8010041f:	5d                   	pop    %ebp
80100420:	c3                   	ret    
      if(n < target){
80100421:	39 fb                	cmp    %edi,%ebx
80100423:	73 d7                	jae    801003fc <consoleread+0xcc>
        input.r--;
80100425:	a3 a0 15 11 80       	mov    %eax,0x801115a0
8010042a:	eb d0                	jmp    801003fc <consoleread+0xcc>
8010042c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100430 <read_num.constprop.0>:
static int read_num(int start_index,int *end_index)
80100430:	55                   	push   %ebp
80100431:	89 e5                	mov    %esp,%ebp
80100433:	57                   	push   %edi
  int num = 0;
80100434:	31 ff                	xor    %edi,%edi
static int read_num(int start_index,int *end_index)
80100436:	56                   	push   %esi
80100437:	89 c6                	mov    %eax,%esi
80100439:	53                   	push   %ebx
8010043a:	83 ec 08             	sub    $0x8,%esp
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
8010043d:	a1 a4 15 11 80       	mov    0x801115a4,%eax
static int read_num(int start_index,int *end_index)
80100442:	89 55 ec             	mov    %edx,-0x14(%ebp)
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
80100445:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100448:	39 c6                	cmp    %eax,%esi
8010044a:	7c 46                	jl     80100492 <read_num.constprop.0+0x62>
  int count = 0;
8010044c:	31 c9                	xor    %ecx,%ecx
8010044e:	66 90                	xchg   %ax,%ax
    if(input.buf[i]>=48 && input.buf[i]<=57)
80100450:	0f b6 9e 20 15 11 80 	movzbl -0x7feeeae0(%esi),%ebx
80100457:	8d 43 d0             	lea    -0x30(%ebx),%eax
8010045a:	3c 09                	cmp    $0x9,%al
8010045c:	77 49                	ja     801004a7 <read_num.constprop.0+0x77>
  for(int i=0 ; i<y ; i++)
8010045e:	85 c9                	test   %ecx,%ecx
80100460:	74 3e                	je     801004a0 <read_num.constprop.0+0x70>
80100462:	31 d2                	xor    %edx,%edx
  int result = 1;
80100464:	b8 01 00 00 00       	mov    $0x1,%eax
80100469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    result *= x;
80100470:	8d 04 80             	lea    (%eax,%eax,4),%eax
  for(int i=0 ; i<y ; i++)
80100473:	83 c2 01             	add    $0x1,%edx
    result *= x;
80100476:	01 c0                	add    %eax,%eax
  for(int i=0 ; i<y ; i++)
80100478:	39 ca                	cmp    %ecx,%edx
8010047a:	75 f4                	jne    80100470 <read_num.constprop.0+0x40>
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
8010047c:	83 eb 30             	sub    $0x30,%ebx
      count++;
8010047f:	83 c1 01             	add    $0x1,%ecx
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
80100482:	83 ee 01             	sub    $0x1,%esi
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
80100485:	0f be db             	movsbl %bl,%ebx
80100488:	0f af d8             	imul   %eax,%ebx
8010048b:	01 df                	add    %ebx,%edi
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
8010048d:	3b 75 f0             	cmp    -0x10(%ebp),%esi
80100490:	7d be                	jge    80100450 <read_num.constprop.0+0x20>
}
80100492:	83 c4 08             	add    $0x8,%esp
80100495:	89 f8                	mov    %edi,%eax
80100497:	5b                   	pop    %ebx
80100498:	5e                   	pop    %esi
80100499:	5f                   	pop    %edi
8010049a:	5d                   	pop    %ebp
8010049b:	c3                   	ret    
8010049c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int result = 1;
801004a0:	b8 01 00 00 00       	mov    $0x1,%eax
801004a5:	eb d5                	jmp    8010047c <read_num.constprop.0+0x4c>
    else if ((input.buf[i]==45) && ((input.buf[i-1]==42) || (input.buf[i-1]==43) ||(input.buf[i-1]==45) ||(input.buf[i-1]==47)))
801004a7:	80 fb 2d             	cmp    $0x2d,%bl
801004aa:	74 12                	je     801004be <read_num.constprop.0+0x8e>
      *end_index = i+1;
801004ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004af:	83 c6 01             	add    $0x1,%esi
801004b2:	89 30                	mov    %esi,(%eax)
}
801004b4:	83 c4 08             	add    $0x8,%esp
801004b7:	89 f8                	mov    %edi,%eax
801004b9:	5b                   	pop    %ebx
801004ba:	5e                   	pop    %esi
801004bb:	5f                   	pop    %edi
801004bc:	5d                   	pop    %ebp
801004bd:	c3                   	ret    
    else if ((input.buf[i]==45) && ((input.buf[i-1]==42) || (input.buf[i-1]==43) ||(input.buf[i-1]==45) ||(input.buf[i-1]==47)))
801004be:	0f b6 86 1f 15 11 80 	movzbl -0x7feeeae1(%esi),%eax
801004c5:	8d 50 d6             	lea    -0x2a(%eax),%edx
801004c8:	80 fa 01             	cmp    $0x1,%dl
801004cb:	76 0f                	jbe    801004dc <read_num.constprop.0+0xac>
801004cd:	83 e0 fd             	and    $0xfffffffd,%eax
801004d0:	3c 2d                	cmp    $0x2d,%al
801004d2:	74 08                	je     801004dc <read_num.constprop.0+0xac>
    else if ((input.buf[i]==45) && (i==(int)input.r))
801004d4:	39 35 a0 15 11 80    	cmp    %esi,0x801115a0
801004da:	75 d0                	jne    801004ac <read_num.constprop.0+0x7c>
      *end_index = i;
801004dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
      num = -num;
801004df:	f7 df                	neg    %edi
      *end_index = i;
801004e1:	89 30                	mov    %esi,(%eax)
}
801004e3:	83 c4 08             	add    $0x8,%esp
801004e6:	89 f8                	mov    %edi,%eax
801004e8:	5b                   	pop    %ebx
801004e9:	5e                   	pop    %esi
801004ea:	5f                   	pop    %edi
801004eb:	5d                   	pop    %ebp
801004ec:	c3                   	ret    
801004ed:	8d 76 00             	lea    0x0(%esi),%esi

801004f0 <panic>:
{
801004f0:	55                   	push   %ebp
801004f1:	89 e5                	mov    %esp,%ebp
801004f3:	56                   	push   %esi
801004f4:	53                   	push   %ebx
801004f5:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801004f8:	fa                   	cli    
  cons.locking = 0;
801004f9:	c7 05 f4 15 11 80 00 	movl   $0x0,0x801115f4
80100500:	00 00 00 
  getcallerpcs(&s, pcs);
80100503:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100506:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100509:	e8 12 31 00 00       	call   80103620 <lapicid>
8010050e:	83 ec 08             	sub    $0x8,%esp
80100511:	50                   	push   %eax
80100512:	68 4d 85 10 80       	push   $0x8010854d
80100517:	e8 54 05 00 00       	call   80100a70 <cprintf>
  cprintf(s);
8010051c:	58                   	pop    %eax
8010051d:	ff 75 08             	push   0x8(%ebp)
80100520:	e8 4b 05 00 00       	call   80100a70 <cprintf>
  cprintf("\n");
80100525:	c7 04 24 d3 8f 10 80 	movl   $0x80108fd3,(%esp)
8010052c:	e8 3f 05 00 00       	call   80100a70 <cprintf>
  getcallerpcs(&s, pcs);
80100531:	8d 45 08             	lea    0x8(%ebp),%eax
80100534:	5a                   	pop    %edx
80100535:	59                   	pop    %ecx
80100536:	53                   	push   %ebx
80100537:	50                   	push   %eax
80100538:	e8 b3 4d 00 00       	call   801052f0 <getcallerpcs>
  for(i=0; i<10; i++)
8010053d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100540:	83 ec 08             	sub    $0x8,%esp
80100543:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100545:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100548:	68 61 85 10 80       	push   $0x80108561
8010054d:	e8 1e 05 00 00       	call   80100a70 <cprintf>
  for(i=0; i<10; i++)
80100552:	83 c4 10             	add    $0x10,%esp
80100555:	39 f3                	cmp    %esi,%ebx
80100557:	75 e7                	jne    80100540 <panic+0x50>
  panicked = 1; // freeze other CPU
80100559:	c7 05 fc 15 11 80 01 	movl   $0x1,0x801115fc
80100560:	00 00 00 
  for(;;)
80100563:	eb fe                	jmp    80100563 <panic+0x73>
80100565:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010056c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100570 <cgaputc>:
{
80100570:	55                   	push   %ebp
80100571:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100573:	b8 0e 00 00 00       	mov    $0xe,%eax
80100578:	89 e5                	mov    %esp,%ebp
8010057a:	57                   	push   %edi
8010057b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100580:	56                   	push   %esi
80100581:	89 fa                	mov    %edi,%edx
80100583:	53                   	push   %ebx
80100584:	83 ec 1c             	sub    $0x1c,%esp
80100587:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100588:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010058d:	89 da                	mov    %ebx,%edx
8010058f:	ec                   	in     (%dx),%al
  position = inb(CRTPORT+1) << 8;
80100590:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100593:	89 fa                	mov    %edi,%edx
80100595:	b8 0f 00 00 00       	mov    $0xf,%eax
8010059a:	c1 e6 08             	shl    $0x8,%esi
8010059d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010059e:	89 da                	mov    %ebx,%edx
801005a0:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT+1);
801005a1:	0f b6 d8             	movzbl %al,%ebx
801005a4:	09 f3                	or     %esi,%ebx
  if(c == '\n')
801005a6:	83 f9 0a             	cmp    $0xa,%ecx
801005a9:	0f 84 21 01 00 00    	je     801006d0 <cgaputc+0x160>
  else if(c == BACKSPACE){
801005af:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
801005b5:	0f 84 3d 01 00 00    	je     801006f8 <cgaputc+0x188>
  else if(c==RIGHT_ARROW)
801005bb:	81 f9 e5 00 00 00    	cmp    $0xe5,%ecx
801005c1:	0f 85 89 00 00 00    	jne    80100650 <cgaputc+0xe0>
  if(position < 0 || position > 25*80)
801005c7:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801005cd:	0f 8f bb 01 00 00    	jg     8010078e <cgaputc+0x21e>
  outb(CRTPORT+1, position>>8);
801005d3:	0f b6 f7             	movzbl %bh,%esi
  if((position/80) >= 24){  // Scroll up.
801005d6:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801005dc:	7e 3e                	jle    8010061c <cgaputc+0xac>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005de:	83 ec 04             	sub    $0x4,%esp
    position -= 80;
801005e1:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, position);
801005e4:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005e9:	68 60 0e 00 00       	push   $0xe60
801005ee:	68 a0 80 0b 80       	push   $0x800b80a0
801005f3:	68 00 80 0b 80       	push   $0x800b8000
801005f8:	e8 f3 4f 00 00       	call   801055f0 <memmove>
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
801005fd:	b8 80 07 00 00       	mov    $0x780,%eax
80100602:	83 c4 0c             	add    $0xc,%esp
80100605:	29 d8                	sub    %ebx,%eax
80100607:	01 c0                	add    %eax,%eax
80100609:	50                   	push   %eax
8010060a:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100611:	6a 00                	push   $0x0
80100613:	50                   	push   %eax
80100614:	e8 47 4f 00 00       	call   80105560 <memset>
  outb(CRTPORT+1, position);
80100619:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010061c:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100621:	b8 0e 00 00 00       	mov    $0xe,%eax
80100626:	89 fa                	mov    %edi,%edx
80100628:	ee                   	out    %al,(%dx)
80100629:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010062e:	89 f0                	mov    %esi,%eax
80100630:	89 ca                	mov    %ecx,%edx
80100632:	ee                   	out    %al,(%dx)
80100633:	b8 0f 00 00 00       	mov    $0xf,%eax
80100638:	89 fa                	mov    %edi,%edx
8010063a:	ee                   	out    %al,(%dx)
8010063b:	89 d8                	mov    %ebx,%eax
8010063d:	89 ca                	mov    %ecx,%edx
8010063f:	ee                   	out    %al,(%dx)
}
80100640:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100643:	5b                   	pop    %ebx
80100644:	5e                   	pop    %esi
80100645:	5f                   	pop    %edi
80100646:	5d                   	pop    %ebp
80100647:	c3                   	ret    
80100648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010064f:	90                   	nop
  for (int i = position + backs; i > position; i--)
80100650:	8b 15 f8 15 11 80    	mov    0x801115f8,%edx
80100656:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80100659:	39 c3                	cmp    %eax,%ebx
8010065b:	7d 21                	jge    8010067e <cgaputc+0x10e>
8010065d:	8d 84 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%eax
80100664:	8d bc 1b fe 7f 0b 80 	lea    -0x7ff48002(%ebx,%ebx,1),%edi
8010066b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010066f:	90                   	nop
    crt[i] = crt[i - 1]; // shift to right all letters after cursor position
80100670:	0f b7 30             	movzwl (%eax),%esi
  for (int i = position + backs; i > position; i--)
80100673:	83 e8 02             	sub    $0x2,%eax
    crt[i] = crt[i - 1]; // shift to right all letters after cursor position
80100676:	66 89 70 04          	mov    %si,0x4(%eax)
  for (int i = position + backs; i > position; i--)
8010067a:	39 c7                	cmp    %eax,%edi
8010067c:	75 f2                	jne    80100670 <cgaputc+0x100>
  char last = input.buf[input.e-1];
8010067e:	a1 a8 15 11 80       	mov    0x801115a8,%eax
80100683:	8d 70 ff             	lea    -0x1(%eax),%esi
80100686:	0f b6 b8 1f 15 11 80 	movzbl -0x7feeeae1(%eax),%edi
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
8010068d:	29 d6                	sub    %edx,%esi
8010068f:	39 c6                	cmp    %eax,%esi
80100691:	73 19                	jae    801006ac <cgaputc+0x13c>
80100693:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100697:	90                   	nop
    input.buf[i] = input.buf[i - 1]; // shift to right all letters in buffer
80100698:	0f b6 90 1f 15 11 80 	movzbl -0x7feeeae1(%eax),%edx
8010069f:	83 e8 01             	sub    $0x1,%eax
801006a2:	88 90 21 15 11 80    	mov    %dl,-0x7feeeadf(%eax)
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
801006a8:	39 c6                	cmp    %eax,%esi
801006aa:	72 ec                	jb     80100698 <cgaputc+0x128>
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006ac:	0f b6 c9             	movzbl %cl,%ecx
  input.buf[input.e-backs-1] = last;
801006af:	89 f8                	mov    %edi,%eax
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006b1:	80 cd 07             	or     $0x7,%ch
  input.buf[input.e-backs-1] = last;
801006b4:	88 86 20 15 11 80    	mov    %al,-0x7feeeae0(%esi)
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006ba:	66 89 8c 1b 00 80 0b 	mov    %cx,-0x7ff48000(%ebx,%ebx,1)
801006c1:	80 
801006c2:	83 c3 01             	add    $0x1,%ebx
801006c5:	e9 fd fe ff ff       	jmp    801005c7 <cgaputc+0x57>
801006ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    position += 80 - position%80;
801006d0:	89 d8                	mov    %ebx,%eax
801006d2:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    backs = 0; //(jadid) by going to next the line, back variable resets 
801006d7:	c7 05 f8 15 11 80 00 	movl   $0x0,0x801115f8
801006de:	00 00 00 
    position += 80 - position%80;
801006e1:	f7 e2                	mul    %edx
801006e3:	c1 ea 06             	shr    $0x6,%edx
801006e6:	8d 04 92             	lea    (%edx,%edx,4),%eax
801006e9:	c1 e0 04             	shl    $0x4,%eax
801006ec:	8d 58 50             	lea    0x50(%eax),%ebx
    backs = 0; //(jadid) by going to next the line, back variable resets 
801006ef:	e9 d3 fe ff ff       	jmp    801005c7 <cgaputc+0x57>
801006f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (int i = position - 1; i < position + backs; i++)
801006f8:	8b 35 f8 15 11 80    	mov    0x801115f8,%esi
801006fe:	8d 7b ff             	lea    -0x1(%ebx),%edi
80100701:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100708:	89 fa                	mov    %edi,%edx
8010070a:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
8010070d:	85 f6                	test   %esi,%esi
8010070f:	78 1b                	js     8010072c <cgaputc+0x1bc>
80100711:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    crt[i] = crt[i + 1]; // shift to left all letters after cursor position
80100718:	0f b7 18             	movzwl (%eax),%ebx
  for (int i = position - 1; i < position + backs; i++)
8010071b:	83 c2 01             	add    $0x1,%edx
8010071e:	83 c0 02             	add    $0x2,%eax
    crt[i] = crt[i + 1]; // shift to left all letters after cursor position
80100721:	66 89 58 fc          	mov    %bx,-0x4(%eax)
  for (int i = position - 1; i < position + backs; i++)
80100725:	39 ca                	cmp    %ecx,%edx
80100727:	7c ef                	jl     80100718 <cgaputc+0x1a8>
80100729:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  for (int i = input.e - backs; i < input.e; i++ )// jadid
8010072c:	8b 15 a8 15 11 80    	mov    0x801115a8,%edx
80100732:	89 d1                	mov    %edx,%ecx
80100734:	29 f1                	sub    %esi,%ecx
80100736:	89 ce                	mov    %ecx,%esi
80100738:	39 ca                	cmp    %ecx,%edx
8010073a:	76 49                	jbe    80100785 <cgaputc+0x215>
8010073c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010073f:	90                   	nop
    input.buf[i] = input.buf[i + 1]; // shift to left all letters in buffer
80100740:	0f b6 86 21 15 11 80 	movzbl -0x7feeeadf(%esi),%eax
80100747:	83 c6 01             	add    $0x1,%esi
8010074a:	88 86 1f 15 11 80    	mov    %al,-0x7feeeae1(%esi)
  for (int i = input.e - backs; i < input.e; i++ )// jadid
80100750:	39 f2                	cmp    %esi,%edx
80100752:	75 ec                	jne    80100740 <cgaputc+0x1d0>
    saveInp.copybuf[input.e-backs] = '\0';
80100754:	c6 81 80 14 11 80 00 	movb   $0x0,-0x7feeeb80(%ecx)
8010075b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010075e:	66 90                	xchg   %ax,%ax
      saveInp.copybuf[i] = saveInp.copybuf[i + 1];
80100760:	0f b6 88 81 14 11 80 	movzbl -0x7feeeb7f(%eax),%ecx
80100767:	83 c0 01             	add    $0x1,%eax
8010076a:	88 88 7f 14 11 80    	mov    %cl,-0x7feeeb81(%eax)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
80100770:	39 d0                	cmp    %edx,%eax
80100772:	75 ec                	jne    80100760 <cgaputc+0x1f0>
    if(position > 0) 
80100774:	31 f6                	xor    %esi,%esi
80100776:	85 db                	test   %ebx,%ebx
80100778:	0f 84 9e fe ff ff    	je     8010061c <cgaputc+0xac>
8010077e:	89 fb                	mov    %edi,%ebx
80100780:	e9 42 fe ff ff       	jmp    801005c7 <cgaputc+0x57>
    saveInp.copybuf[input.e-backs] = '\0';
80100785:	c6 81 80 14 11 80 00 	movb   $0x0,-0x7feeeb80(%ecx)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010078c:	eb e6                	jmp    80100774 <cgaputc+0x204>
    panic("pos under/overflow");
8010078e:	83 ec 0c             	sub    $0xc,%esp
80100791:	68 65 85 10 80       	push   $0x80108565
80100796:	e8 55 fd ff ff       	call   801004f0 <panic>
8010079b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010079f:	90                   	nop

801007a0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801007a0:	55                   	push   %ebp
801007a1:	89 e5                	mov    %esp,%ebp
801007a3:	57                   	push   %edi
801007a4:	56                   	push   %esi
801007a5:	53                   	push   %ebx
801007a6:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
801007a9:	ff 75 08             	push   0x8(%ebp)
{
801007ac:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801007af:	e8 dc 1d 00 00       	call   80102590 <iunlock>
  acquire(&cons.lock);
801007b4:	c7 04 24 c0 15 11 80 	movl   $0x801115c0,(%esp)
801007bb:	e8 e0 4c 00 00       	call   801054a0 <acquire>
  for(i = 0; i < n; i++)
801007c0:	83 c4 10             	add    $0x10,%esp
801007c3:	85 f6                	test   %esi,%esi
801007c5:	7e 37                	jle    801007fe <consolewrite+0x5e>
801007c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801007ca:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801007cd:	8b 15 fc 15 11 80    	mov    0x801115fc,%edx
    consputc(buf[i] & 0xff);
801007d3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801007d6:	85 d2                	test   %edx,%edx
801007d8:	74 06                	je     801007e0 <consolewrite+0x40>
  asm volatile("cli");
801007da:	fa                   	cli    
    for(;;)
801007db:	eb fe                	jmp    801007db <consolewrite+0x3b>
801007dd:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < n; i++)
801007e6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801007e9:	50                   	push   %eax
801007ea:	e8 41 68 00 00       	call   80107030 <uartputc>
  cgaputc(c);
801007ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007f2:	e8 79 fd ff ff       	call   80100570 <cgaputc>
  for(i = 0; i < n; i++)
801007f7:	83 c4 10             	add    $0x10,%esp
801007fa:	39 df                	cmp    %ebx,%edi
801007fc:	75 cf                	jne    801007cd <consolewrite+0x2d>
  release(&cons.lock);
801007fe:	83 ec 0c             	sub    $0xc,%esp
80100801:	68 c0 15 11 80       	push   $0x801115c0
80100806:	e8 35 4c 00 00       	call   80105440 <release>
  ilock(ip);
8010080b:	58                   	pop    %eax
8010080c:	ff 75 08             	push   0x8(%ebp)
8010080f:	e8 9c 1c 00 00       	call   801024b0 <ilock>

  return n;
}
80100814:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100817:	89 f0                	mov    %esi,%eax
80100819:	5b                   	pop    %ebx
8010081a:	5e                   	pop    %esi
8010081b:	5f                   	pop    %edi
8010081c:	5d                   	pop    %ebp
8010081d:	c3                   	ret    
8010081e:	66 90                	xchg   %ax,%ax

80100820 <printint>:
{
80100820:	55                   	push   %ebp
80100821:	89 e5                	mov    %esp,%ebp
80100823:	57                   	push   %edi
80100824:	56                   	push   %esi
80100825:	53                   	push   %ebx
80100826:	83 ec 2c             	sub    $0x2c,%esp
80100829:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010082c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010082f:	85 c9                	test   %ecx,%ecx
80100831:	74 04                	je     80100837 <printint+0x17>
80100833:	85 c0                	test   %eax,%eax
80100835:	78 7e                	js     801008b5 <printint+0x95>
    x = xx;
80100837:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010083e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100840:	31 db                	xor    %ebx,%ebx
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100848:	89 c8                	mov    %ecx,%eax
8010084a:	31 d2                	xor    %edx,%edx
8010084c:	89 de                	mov    %ebx,%esi
8010084e:	89 cf                	mov    %ecx,%edi
80100850:	f7 75 d4             	divl   -0x2c(%ebp)
80100853:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100856:	0f b6 92 d8 85 10 80 	movzbl -0x7fef7a28(%edx),%edx
  }while((x /= base) != 0);
8010085d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010085f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100863:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100866:	73 e0                	jae    80100848 <printint+0x28>
  if(sign)
80100868:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010086b:	85 c9                	test   %ecx,%ecx
8010086d:	74 0c                	je     8010087b <printint+0x5b>
    buf[i++] = '-';
8010086f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100874:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100876:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010087b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
8010087f:	a1 fc 15 11 80       	mov    0x801115fc,%eax
80100884:	85 c0                	test   %eax,%eax
80100886:	74 08                	je     80100890 <printint+0x70>
80100888:	fa                   	cli    
    for(;;)
80100889:	eb fe                	jmp    80100889 <printint+0x69>
8010088b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010088f:	90                   	nop
    consputc(buf[i]);
80100890:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100893:	83 ec 0c             	sub    $0xc,%esp
80100896:	56                   	push   %esi
80100897:	e8 94 67 00 00       	call   80107030 <uartputc>
  cgaputc(c);
8010089c:	89 f0                	mov    %esi,%eax
8010089e:	e8 cd fc ff ff       	call   80100570 <cgaputc>
  while(--i >= 0)
801008a3:	8d 45 d7             	lea    -0x29(%ebp),%eax
801008a6:	83 c4 10             	add    $0x10,%esp
801008a9:	39 d8                	cmp    %ebx,%eax
801008ab:	74 0e                	je     801008bb <printint+0x9b>
    consputc(buf[i]);
801008ad:	0f b6 13             	movzbl (%ebx),%edx
801008b0:	83 eb 01             	sub    $0x1,%ebx
801008b3:	eb ca                	jmp    8010087f <printint+0x5f>
    x = -xx;
801008b5:	f7 d8                	neg    %eax
801008b7:	89 c1                	mov    %eax,%ecx
801008b9:	eb 85                	jmp    80100840 <printint+0x20>
}
801008bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008be:	5b                   	pop    %ebx
801008bf:	5e                   	pop    %esi
801008c0:	5f                   	pop    %edi
801008c1:	5d                   	pop    %ebp
801008c2:	c3                   	ret    
801008c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008d0 <handle_up_down_arrow>:
static void handle_up_down_arrow(enum Arrow arrow){ //jadid
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
801008d5:	53                   	push   %ebx
801008d6:	83 ec 1c             	sub    $0x1c,%esp
801008d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for (int i= 0 ; i < backs ; i ++){ //move cursor into later of current line
801008dc:	a1 f8 15 11 80       	mov    0x801115f8,%eax
801008e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801008e4:	85 c0                	test   %eax,%eax
801008e6:	7e 58                	jle    80100940 <handle_up_down_arrow+0x70>
801008e8:	31 ff                	xor    %edi,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008ea:	be d4 03 00 00       	mov    $0x3d4,%esi
801008ef:	90                   	nop
801008f0:	b8 0e 00 00 00       	mov    $0xe,%eax
801008f5:	89 f2                	mov    %esi,%edx
801008f7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008f8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801008fd:	89 da                	mov    %ebx,%edx
801008ff:	ec                   	in     (%dx),%al
  position = inb(CRTPORT + 1) << 8;
80100900:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100903:	89 f2                	mov    %esi,%edx
80100905:	b8 0f 00 00 00       	mov    $0xf,%eax
8010090a:	c1 e1 08             	shl    $0x8,%ecx
8010090d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010090e:	89 da                	mov    %ebx,%edx
80100910:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT + 1);
80100911:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100914:	89 f2                	mov    %esi,%edx
80100916:	09 c1                	or     %eax,%ecx
80100918:	b8 0e 00 00 00       	mov    $0xe,%eax
    position++;
8010091d:	83 c1 01             	add    $0x1,%ecx
80100920:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, position >> 8);
80100921:	89 ca                	mov    %ecx,%edx
80100923:	c1 fa 08             	sar    $0x8,%edx
80100926:	89 d0                	mov    %edx,%eax
80100928:	89 da                	mov    %ebx,%edx
8010092a:	ee                   	out    %al,(%dx)
8010092b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100930:	89 f2                	mov    %esi,%edx
80100932:	ee                   	out    %al,(%dx)
80100933:	89 c8                	mov    %ecx,%eax
80100935:	89 da                	mov    %ebx,%edx
80100937:	ee                   	out    %al,(%dx)
  for (int i= 0 ; i < backs ; i ++){ //move cursor into later of current line
80100938:	83 c7 01             	add    $0x1,%edi
8010093b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010093e:	75 b0                	jne    801008f0 <handle_up_down_arrow+0x20>
  backs = 0;
80100940:	c7 05 f8 15 11 80 00 	movl   $0x0,0x801115f8
80100947:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
8010094a:	8b 1d a8 15 11 80    	mov    0x801115a8,%ebx
80100950:	3b 1d a4 15 11 80    	cmp    0x801115a4,%ebx
80100956:	76 57                	jbe    801009af <handle_up_down_arrow+0xdf>
    if (input.buf[i - 1] != '\n'){
80100958:	83 eb 01             	sub    $0x1,%ebx
8010095b:	80 bb 20 15 11 80 0a 	cmpb   $0xa,-0x7feeeae0(%ebx)
80100962:	74 43                	je     801009a7 <handle_up_down_arrow+0xd7>
  if(panicked){
80100964:	8b 0d fc 15 11 80    	mov    0x801115fc,%ecx
8010096a:	85 c9                	test   %ecx,%ecx
8010096c:	74 0a                	je     80100978 <handle_up_down_arrow+0xa8>
  asm volatile("cli");
8010096e:	fa                   	cli    
    for(;;)
8010096f:	eb fe                	jmp    8010096f <handle_up_down_arrow+0x9f>
80100971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100978:	83 ec 0c             	sub    $0xc,%esp
8010097b:	6a 08                	push   $0x8
8010097d:	e8 ae 66 00 00       	call   80107030 <uartputc>
80100982:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100989:	e8 a2 66 00 00       	call   80107030 <uartputc>
8010098e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100995:	e8 96 66 00 00       	call   80107030 <uartputc>
  cgaputc(c);
8010099a:	b8 00 01 00 00       	mov    $0x100,%eax
8010099f:	e8 cc fb ff ff       	call   80100570 <cgaputc>
}
801009a4:	83 c4 10             	add    $0x10,%esp
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
801009a7:	39 1d a4 15 11 80    	cmp    %ebx,0x801115a4
801009ad:	72 a9                	jb     80100958 <handle_up_down_arrow+0x88>
  if ((arrow == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
801009af:	83 7d e0 03          	cmpl   $0x3,-0x20(%ebp)
801009b3:	a1 58 14 11 80       	mov    0x80111458,%eax
801009b8:	75 10                	jne    801009ca <handle_up_down_arrow+0xfa>
801009ba:	83 f8 08             	cmp    $0x8,%eax
801009bd:	7f 0b                	jg     801009ca <handle_up_down_arrow+0xfa>
801009bf:	8d 50 01             	lea    0x1(%eax),%edx
801009c2:	3b 15 5c 14 11 80    	cmp    0x8011145c,%edx
801009c8:	7c 7f                	jl     80100a49 <handle_up_down_arrow+0x179>
    input = history.instructions[history.index--];
801009ca:	8d 50 ff             	lea    -0x1(%eax),%edx
801009cd:	69 c0 8c 00 00 00    	imul   $0x8c,%eax,%eax
801009d3:	89 15 58 14 11 80    	mov    %edx,0x80111458
801009d9:	8d b0 e0 0e 11 80    	lea    -0x7feef120(%eax),%esi
801009df:	b8 20 15 11 80       	mov    $0x80111520,%eax
801009e4:	b9 23 00 00 00       	mov    $0x23,%ecx
801009e9:	89 c7                	mov    %eax,%edi
801009eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.buf[--input.e] = '\0';
801009ed:	8b 15 a8 15 11 80    	mov    0x801115a8,%edx
801009f3:	8d 42 ff             	lea    -0x1(%edx),%eax
801009f6:	a3 a8 15 11 80       	mov    %eax,0x801115a8
801009fb:	c6 82 1f 15 11 80 00 	movb   $0x0,-0x7feeeae1(%edx)
  for (int i = input.w ; i < input.e; i++)
80100a02:	8b 1d a4 15 11 80    	mov    0x801115a4,%ebx
80100a08:	39 c3                	cmp    %eax,%ebx
80100a0a:	73 35                	jae    80100a41 <handle_up_down_arrow+0x171>
  if(panicked){
80100a0c:	8b 15 fc 15 11 80    	mov    0x801115fc,%edx
    consputc(input.buf[i]);
80100a12:	0f b6 83 20 15 11 80 	movzbl -0x7feeeae0(%ebx),%eax
  if(panicked){
80100a19:	85 d2                	test   %edx,%edx
80100a1b:	74 03                	je     80100a20 <handle_up_down_arrow+0x150>
80100a1d:	fa                   	cli    
    for(;;)
80100a1e:	eb fe                	jmp    80100a1e <handle_up_down_arrow+0x14e>
    uartputc(c);
80100a20:	83 ec 0c             	sub    $0xc,%esp
    consputc(input.buf[i]);
80100a23:	0f be f0             	movsbl %al,%esi
  for (int i = input.w ; i < input.e; i++)
80100a26:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100a29:	56                   	push   %esi
80100a2a:	e8 01 66 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100a2f:	89 f0                	mov    %esi,%eax
80100a31:	e8 3a fb ff ff       	call   80100570 <cgaputc>
  for (int i = input.w ; i < input.e; i++)
80100a36:	83 c4 10             	add    $0x10,%esp
80100a39:	39 1d a8 15 11 80    	cmp    %ebx,0x801115a8
80100a3f:	77 cb                	ja     80100a0c <handle_up_down_arrow+0x13c>
}
80100a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a44:	5b                   	pop    %ebx
80100a45:	5e                   	pop    %esi
80100a46:	5f                   	pop    %edi
80100a47:	5d                   	pop    %ebp
80100a48:	c3                   	ret    
    input = history.instructions[history.index + 1 ];
80100a49:	8d 70 02             	lea    0x2(%eax),%esi
    history.index ++ ;
80100a4c:	89 15 58 14 11 80    	mov    %edx,0x80111458
    input = history.instructions[history.index + 1 ];
80100a52:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
80100a58:	81 c6 e0 0e 11 80    	add    $0x80110ee0,%esi
80100a5e:	e9 7c ff ff ff       	jmp    801009df <handle_up_down_arrow+0x10f>
80100a63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100a70 <cprintf>:
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	57                   	push   %edi
80100a74:	56                   	push   %esi
80100a75:	53                   	push   %ebx
80100a76:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100a79:	a1 f4 15 11 80       	mov    0x801115f4,%eax
80100a7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100a81:	85 c0                	test   %eax,%eax
80100a83:	0f 85 37 01 00 00    	jne    80100bc0 <cprintf+0x150>
  if (fmt == 0)
80100a89:	8b 75 08             	mov    0x8(%ebp),%esi
80100a8c:	85 f6                	test   %esi,%esi
80100a8e:	0f 84 3d 02 00 00    	je     80100cd1 <cprintf+0x261>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a94:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100a97:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100a9a:	31 db                	xor    %ebx,%ebx
80100a9c:	85 c0                	test   %eax,%eax
80100a9e:	74 56                	je     80100af6 <cprintf+0x86>
    if(c != '%'){
80100aa0:	83 f8 25             	cmp    $0x25,%eax
80100aa3:	0f 85 d7 00 00 00    	jne    80100b80 <cprintf+0x110>
    c = fmt[++i] & 0xff;
80100aa9:	83 c3 01             	add    $0x1,%ebx
80100aac:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100ab0:	85 d2                	test   %edx,%edx
80100ab2:	74 42                	je     80100af6 <cprintf+0x86>
    switch(c){
80100ab4:	83 fa 70             	cmp    $0x70,%edx
80100ab7:	0f 84 94 00 00 00    	je     80100b51 <cprintf+0xe1>
80100abd:	7f 51                	jg     80100b10 <cprintf+0xa0>
80100abf:	83 fa 25             	cmp    $0x25,%edx
80100ac2:	0f 84 48 01 00 00    	je     80100c10 <cprintf+0x1a0>
80100ac8:	83 fa 64             	cmp    $0x64,%edx
80100acb:	0f 85 04 01 00 00    	jne    80100bd5 <cprintf+0x165>
      printint(*argp++, 10, 1);
80100ad1:	8d 47 04             	lea    0x4(%edi),%eax
80100ad4:	b9 01 00 00 00       	mov    $0x1,%ecx
80100ad9:	ba 0a 00 00 00       	mov    $0xa,%edx
80100ade:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ae1:	8b 07                	mov    (%edi),%eax
80100ae3:	e8 38 fd ff ff       	call   80100820 <printint>
80100ae8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100aeb:	83 c3 01             	add    $0x1,%ebx
80100aee:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100af2:	85 c0                	test   %eax,%eax
80100af4:	75 aa                	jne    80100aa0 <cprintf+0x30>
  if(locking)
80100af6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100af9:	85 c0                	test   %eax,%eax
80100afb:	0f 85 b3 01 00 00    	jne    80100cb4 <cprintf+0x244>
}
80100b01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b04:	5b                   	pop    %ebx
80100b05:	5e                   	pop    %esi
80100b06:	5f                   	pop    %edi
80100b07:	5d                   	pop    %ebp
80100b08:	c3                   	ret    
80100b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100b10:	83 fa 73             	cmp    $0x73,%edx
80100b13:	75 33                	jne    80100b48 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100b15:	8d 47 04             	lea    0x4(%edi),%eax
80100b18:	8b 3f                	mov    (%edi),%edi
80100b1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b1d:	85 ff                	test   %edi,%edi
80100b1f:	0f 85 33 01 00 00    	jne    80100c58 <cprintf+0x1e8>
        s = "(null)";
80100b25:	bf 78 85 10 80       	mov    $0x80108578,%edi
      for(; *s; s++)
80100b2a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100b2d:	b8 28 00 00 00       	mov    $0x28,%eax
80100b32:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100b34:	8b 15 fc 15 11 80    	mov    0x801115fc,%edx
80100b3a:	85 d2                	test   %edx,%edx
80100b3c:	0f 84 27 01 00 00    	je     80100c69 <cprintf+0x1f9>
80100b42:	fa                   	cli    
    for(;;)
80100b43:	eb fe                	jmp    80100b43 <cprintf+0xd3>
80100b45:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100b48:	83 fa 78             	cmp    $0x78,%edx
80100b4b:	0f 85 84 00 00 00    	jne    80100bd5 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100b51:	8d 47 04             	lea    0x4(%edi),%eax
80100b54:	31 c9                	xor    %ecx,%ecx
80100b56:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b5b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
80100b5e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b61:	8b 07                	mov    (%edi),%eax
80100b63:	e8 b8 fc ff ff       	call   80100820 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b68:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100b6c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b6f:	85 c0                	test   %eax,%eax
80100b71:	0f 85 29 ff ff ff    	jne    80100aa0 <cprintf+0x30>
80100b77:	e9 7a ff ff ff       	jmp    80100af6 <cprintf+0x86>
80100b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100b80:	8b 0d fc 15 11 80    	mov    0x801115fc,%ecx
80100b86:	85 c9                	test   %ecx,%ecx
80100b88:	74 06                	je     80100b90 <cprintf+0x120>
80100b8a:	fa                   	cli    
    for(;;)
80100b8b:	eb fe                	jmp    80100b8b <cprintf+0x11b>
80100b8d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100b90:	83 ec 0c             	sub    $0xc,%esp
80100b93:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b96:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100b99:	50                   	push   %eax
80100b9a:	e8 91 64 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100b9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ba2:	e8 c9 f9 ff ff       	call   80100570 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100ba7:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
80100bab:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bae:	85 c0                	test   %eax,%eax
80100bb0:	0f 85 ea fe ff ff    	jne    80100aa0 <cprintf+0x30>
80100bb6:	e9 3b ff ff ff       	jmp    80100af6 <cprintf+0x86>
80100bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100bbf:	90                   	nop
    acquire(&cons.lock);
80100bc0:	83 ec 0c             	sub    $0xc,%esp
80100bc3:	68 c0 15 11 80       	push   $0x801115c0
80100bc8:	e8 d3 48 00 00       	call   801054a0 <acquire>
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	e9 b4 fe ff ff       	jmp    80100a89 <cprintf+0x19>
  if(panicked){
80100bd5:	8b 0d fc 15 11 80    	mov    0x801115fc,%ecx
80100bdb:	85 c9                	test   %ecx,%ecx
80100bdd:	75 71                	jne    80100c50 <cprintf+0x1e0>
    uartputc(c);
80100bdf:	83 ec 0c             	sub    $0xc,%esp
80100be2:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100be5:	6a 25                	push   $0x25
80100be7:	e8 44 64 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100bec:	b8 25 00 00 00       	mov    $0x25,%eax
80100bf1:	e8 7a f9 ff ff       	call   80100570 <cgaputc>
  if(panicked){
80100bf6:	8b 15 fc 15 11 80    	mov    0x801115fc,%edx
80100bfc:	83 c4 10             	add    $0x10,%esp
80100bff:	85 d2                	test   %edx,%edx
80100c01:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100c04:	0f 84 8e 00 00 00    	je     80100c98 <cprintf+0x228>
80100c0a:	fa                   	cli    
    for(;;)
80100c0b:	eb fe                	jmp    80100c0b <cprintf+0x19b>
80100c0d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100c10:	a1 fc 15 11 80       	mov    0x801115fc,%eax
80100c15:	85 c0                	test   %eax,%eax
80100c17:	74 07                	je     80100c20 <cprintf+0x1b0>
80100c19:	fa                   	cli    
    for(;;)
80100c1a:	eb fe                	jmp    80100c1a <cprintf+0x1aa>
80100c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100c20:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c23:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100c26:	6a 25                	push   $0x25
80100c28:	e8 03 64 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100c2d:	b8 25 00 00 00       	mov    $0x25,%eax
80100c32:	e8 39 f9 ff ff       	call   80100570 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c37:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
80100c3b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c3e:	85 c0                	test   %eax,%eax
80100c40:	0f 85 5a fe ff ff    	jne    80100aa0 <cprintf+0x30>
80100c46:	e9 ab fe ff ff       	jmp    80100af6 <cprintf+0x86>
80100c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c4f:	90                   	nop
80100c50:	fa                   	cli    
    for(;;)
80100c51:	eb fe                	jmp    80100c51 <cprintf+0x1e1>
80100c53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c57:	90                   	nop
      for(; *s; s++)
80100c58:	0f b6 07             	movzbl (%edi),%eax
80100c5b:	84 c0                	test   %al,%al
80100c5d:	74 6a                	je     80100cc9 <cprintf+0x259>
80100c5f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100c62:	89 fb                	mov    %edi,%ebx
80100c64:	e9 cb fe ff ff       	jmp    80100b34 <cprintf+0xc4>
    uartputc(c);
80100c69:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
80100c6c:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
80100c6f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100c72:	57                   	push   %edi
80100c73:	e8 b8 63 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100c78:	89 f8                	mov    %edi,%eax
80100c7a:	e8 f1 f8 ff ff       	call   80100570 <cgaputc>
      for(; *s; s++)
80100c7f:	0f b6 03             	movzbl (%ebx),%eax
80100c82:	83 c4 10             	add    $0x10,%esp
80100c85:	84 c0                	test   %al,%al
80100c87:	0f 85 a7 fe ff ff    	jne    80100b34 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
80100c8d:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80100c90:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100c93:	e9 53 fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    uartputc(c);
80100c98:	83 ec 0c             	sub    $0xc,%esp
80100c9b:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100c9e:	52                   	push   %edx
80100c9f:	e8 8c 63 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100ca4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca7:	e8 c4 f8 ff ff       	call   80100570 <cgaputc>
}
80100cac:	83 c4 10             	add    $0x10,%esp
80100caf:	e9 37 fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    release(&cons.lock);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
80100cb7:	68 c0 15 11 80       	push   $0x801115c0
80100cbc:	e8 7f 47 00 00       	call   80105440 <release>
80100cc1:	83 c4 10             	add    $0x10,%esp
}
80100cc4:	e9 38 fe ff ff       	jmp    80100b01 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100cc9:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100ccc:	e9 1a fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    panic("null fmt");
80100cd1:	83 ec 0c             	sub    $0xc,%esp
80100cd4:	68 7f 85 10 80       	push   $0x8010857f
80100cd9:	e8 12 f8 ff ff       	call   801004f0 <panic>
80100cde:	66 90                	xchg   %ax,%ax

80100ce0 <delete_letters>:
{
80100ce0:	55                   	push   %ebp
80100ce1:	89 e5                	mov    %esp,%ebp
80100ce3:	53                   	push   %ebx
80100ce4:	83 ec 04             	sub    $0x4,%esp
80100ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(int i=end_index; i<input.e ; i++)
80100cea:	39 1d a8 15 11 80    	cmp    %ebx,0x801115a8
80100cf0:	76 48                	jbe    80100d3a <delete_letters+0x5a>
  if(panicked){
80100cf2:	a1 fc 15 11 80       	mov    0x801115fc,%eax
80100cf7:	85 c0                	test   %eax,%eax
80100cf9:	74 05                	je     80100d00 <delete_letters+0x20>
80100cfb:	fa                   	cli    
    for(;;)
80100cfc:	eb fe                	jmp    80100cfc <delete_letters+0x1c>
80100cfe:	66 90                	xchg   %ax,%ax
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100d00:	83 ec 0c             	sub    $0xc,%esp
  for(int i=end_index; i<input.e ; i++)
80100d03:	83 c3 01             	add    $0x1,%ebx
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100d06:	6a 08                	push   $0x8
80100d08:	e8 23 63 00 00       	call   80107030 <uartputc>
80100d0d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d14:	e8 17 63 00 00       	call   80107030 <uartputc>
80100d19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d20:	e8 0b 63 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100d25:	b8 00 01 00 00       	mov    $0x100,%eax
80100d2a:	e8 41 f8 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80100d2f:	83 c4 10             	add    $0x10,%esp
80100d32:	39 1d a8 15 11 80    	cmp    %ebx,0x801115a8
80100d38:	77 b8                	ja     80100cf2 <delete_letters+0x12>
}
80100d3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d3d:	c9                   	leave  
80100d3e:	c3                   	ret    
80100d3f:	90                   	nop

80100d40 <consoleintr>:
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	57                   	push   %edi
80100d44:	56                   	push   %esi
80100d45:	53                   	push   %ebx
80100d46:	81 ec 48 02 00 00    	sub    $0x248,%esp
80100d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
80100d4f:	68 c0 15 11 80       	push   $0x801115c0
{
80100d54:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
  acquire(&cons.lock);
80100d5a:	e8 41 47 00 00       	call   801054a0 <acquire>
  char *buf_value = &input.buf[input.w];
80100d5f:	a1 a4 15 11 80       	mov    0x801115a4,%eax
  while((c = getc()) >= 0){
80100d64:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100d67:	c7 85 cc fd ff ff 00 	movl   $0x0,-0x234(%ebp)
80100d6e:	00 00 00 
  char *buf_value = &input.buf[input.w];
80100d71:	89 85 c8 fd ff ff    	mov    %eax,-0x238(%ebp)
80100d77:	05 20 15 11 80       	add    $0x80111520,%eax
80100d7c:	89 85 c4 fd ff ff    	mov    %eax,-0x23c(%ebp)
  while((c = getc()) >= 0){
80100d82:	8b 85 d0 fd ff ff    	mov    -0x230(%ebp),%eax
80100d88:	ff d0                	call   *%eax
80100d8a:	89 c3                	mov    %eax,%ebx
80100d8c:	85 c0                	test   %eax,%eax
80100d8e:	0f 88 cc 00 00 00    	js     80100e60 <consoleintr+0x120>
    switch(c){
80100d94:	83 fb 3f             	cmp    $0x3f,%ebx
80100d97:	0f 84 33 04 00 00    	je     801011d0 <consoleintr+0x490>
80100d9d:	7f 19                	jg     80100db8 <consoleintr+0x78>
80100d9f:	8d 43 fa             	lea    -0x6(%ebx),%eax
80100da2:	83 f8 0f             	cmp    $0xf,%eax
80100da5:	0f 87 2d 01 00 00    	ja     80100ed8 <consoleintr+0x198>
80100dab:	ff 24 85 98 85 10 80 	jmp    *-0x7fef7a68(,%eax,4)
80100db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100db8:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100dbe:	0f 84 dc 03 00 00    	je     801011a0 <consoleintr+0x460>
80100dc4:	0f 8e c6 00 00 00    	jle    80100e90 <consoleintr+0x150>
80100dca:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100dd0:	0f 84 a2 04 00 00    	je     80101278 <consoleintr+0x538>
80100dd6:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100ddc:	0f 85 fe 00 00 00    	jne    80100ee0 <consoleintr+0x1a0>
      if (backs > 0) // ensure back value stays positive
80100de2:	8b 1d f8 15 11 80    	mov    0x801115f8,%ebx
80100de8:	85 db                	test   %ebx,%ebx
80100dea:	7e 96                	jle    80100d82 <consoleintr+0x42>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100dec:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100df1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100df6:	89 fa                	mov    %edi,%edx
80100df8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100df9:	be d5 03 00 00       	mov    $0x3d5,%esi
80100dfe:	89 f2                	mov    %esi,%edx
80100e00:	ec                   	in     (%dx),%al
  position = inb(CRTPORT + 1) << 8;
80100e01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e04:	89 fa                	mov    %edi,%edx
80100e06:	89 c1                	mov    %eax,%ecx
80100e08:	b8 0f 00 00 00       	mov    $0xf,%eax
80100e0d:	c1 e1 08             	shl    $0x8,%ecx
80100e10:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100e11:	89 f2                	mov    %esi,%edx
80100e13:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT + 1);
80100e14:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e17:	89 fa                	mov    %edi,%edx
80100e19:	09 c1                	or     %eax,%ecx
80100e1b:	b8 0e 00 00 00       	mov    $0xe,%eax
    position++;
80100e20:	83 c1 01             	add    $0x1,%ecx
80100e23:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, position >> 8);
80100e24:	89 ca                	mov    %ecx,%edx
80100e26:	c1 fa 08             	sar    $0x8,%edx
80100e29:	89 d0                	mov    %edx,%eax
80100e2b:	89 f2                	mov    %esi,%edx
80100e2d:	ee                   	out    %al,(%dx)
80100e2e:	b8 0f 00 00 00       	mov    $0xf,%eax
80100e33:	89 fa                	mov    %edi,%edx
80100e35:	ee                   	out    %al,(%dx)
80100e36:	89 c8                	mov    %ecx,%eax
80100e38:	89 f2                	mov    %esi,%edx
80100e3a:	ee                   	out    %al,(%dx)
        backs--;
80100e3b:	83 eb 01             	sub    $0x1,%ebx
  while((c = getc()) >= 0){
80100e3e:	8b 85 d0 fd ff ff    	mov    -0x230(%ebp),%eax
        backs--;
80100e44:	89 1d f8 15 11 80    	mov    %ebx,0x801115f8
  while((c = getc()) >= 0){
80100e4a:	ff d0                	call   *%eax
80100e4c:	89 c3                	mov    %eax,%ebx
80100e4e:	85 c0                	test   %eax,%eax
80100e50:	0f 89 3e ff ff ff    	jns    80100d94 <consoleintr+0x54>
80100e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e5d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
80100e63:	68 c0 15 11 80       	push   $0x801115c0
80100e68:	e8 d3 45 00 00       	call   80105440 <release>
  if(doprocdump) {
80100e6d:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
80100e73:	83 c4 10             	add    $0x10,%esp
80100e76:	85 c0                	test   %eax,%eax
80100e78:	0f 85 c2 04 00 00    	jne    80101340 <consoleintr+0x600>
}
80100e7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e81:	5b                   	pop    %ebx
80100e82:	5e                   	pop    %esi
80100e83:	5f                   	pop    %edi
80100e84:	5d                   	pop    %ebp
80100e85:	c3                   	ret    
80100e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e8d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100e90:	83 fb 7f             	cmp    $0x7f,%ebx
80100e93:	0f 84 d7 01 00 00    	je     80101070 <consoleintr+0x330>
80100e99:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100e9f:	75 3f                	jne    80100ee0 <consoleintr+0x1a0>
      if ((history.count != 0)  && (history.last - history.index < history.count))
80100ea1:	a1 60 14 11 80       	mov    0x80111460,%eax
80100ea6:	85 c0                	test   %eax,%eax
80100ea8:	0f 84 d4 fe ff ff    	je     80100d82 <consoleintr+0x42>
80100eae:	8b 15 5c 14 11 80    	mov    0x8011145c,%edx
80100eb4:	2b 15 58 14 11 80    	sub    0x80111458,%edx
80100eba:	39 d0                	cmp    %edx,%eax
80100ebc:	0f 8e c0 fe ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(UP);
80100ec2:	b8 02 00 00 00       	mov    $0x2,%eax
80100ec7:	e8 04 fa ff ff       	call   801008d0 <handle_up_down_arrow>
80100ecc:	e9 b1 fe ff ff       	jmp    80100d82 <consoleintr+0x42>
80100ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100ed8:	85 db                	test   %ebx,%ebx
80100eda:	0f 84 a2 fe ff ff    	je     80100d82 <consoleintr+0x42>
80100ee0:	a1 a8 15 11 80       	mov    0x801115a8,%eax
80100ee5:	89 c2                	mov    %eax,%edx
80100ee7:	2b 15 a0 15 11 80    	sub    0x801115a0,%edx
80100eed:	83 fa 7f             	cmp    $0x7f,%edx
80100ef0:	0f 87 8c fe ff ff    	ja     80100d82 <consoleintr+0x42>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
80100ef6:	89 da                	mov    %ebx,%edx
        c = (c == '\r') ? '\n' : c;
80100ef8:	83 fb 0d             	cmp    $0xd,%ebx
80100efb:	75 0a                	jne    80100f07 <consoleintr+0x1c7>
80100efd:	ba 0a 00 00 00       	mov    $0xa,%edx
80100f02:	bb 0a 00 00 00       	mov    $0xa,%ebx
        if (saveInp.active == 1)
80100f07:	83 3d 08 15 11 80 01 	cmpl   $0x1,0x80111508
80100f0e:	0f 84 b9 04 00 00    	je     801013cd <consoleintr+0x68d>
  if(panicked){
80100f14:	8b 35 fc 15 11 80    	mov    0x801115fc,%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100f1a:	8d 48 01             	lea    0x1(%eax),%ecx
80100f1d:	83 e0 7f             	and    $0x7f,%eax
80100f20:	89 0d a8 15 11 80    	mov    %ecx,0x801115a8
80100f26:	88 90 20 15 11 80    	mov    %dl,-0x7feeeae0(%eax)
  if(panicked){
80100f2c:	85 f6                	test   %esi,%esi
80100f2e:	0f 85 4c 04 00 00    	jne    80101380 <consoleintr+0x640>
  if(c == BACKSPACE){
80100f34:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100f3a:	0f 84 10 05 00 00    	je     80101450 <consoleintr+0x710>
    uartputc(c);
80100f40:	83 ec 0c             	sub    $0xc,%esp
80100f43:	53                   	push   %ebx
80100f44:	e8 e7 60 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80100f49:	89 d8                	mov    %ebx,%eax
80100f4b:	e8 20 f6 ff ff       	call   80100570 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
80100f50:	83 c4 10             	add    $0x10,%esp
80100f53:	83 fb 0a             	cmp    $0xa,%ebx
80100f56:	74 09                	je     80100f61 <consoleintr+0x221>
80100f58:	83 fb 04             	cmp    $0x4,%ebx
80100f5b:	0f 85 1e 05 00 00    	jne    8010147f <consoleintr+0x73f>
  while (word[i]!='\0' && word[i]!='\n')
80100f61:	8b 85 c8 fd ff ff    	mov    -0x238(%ebp),%eax
80100f67:	0f b6 80 20 15 11 80 	movzbl -0x7feeeae0(%eax),%eax
80100f6e:	84 c0                	test   %al,%al
80100f70:	74 38                	je     80100faa <consoleintr+0x26a>
80100f72:	8b 9d c4 fd ff ff    	mov    -0x23c(%ebp),%ebx
80100f78:	31 d2                	xor    %edx,%edx
80100f7a:	b9 68 00 00 00       	mov    $0x68,%ecx
80100f7f:	3c 0a                	cmp    $0xa,%al
80100f81:	75 23                	jne    80100fa6 <consoleintr+0x266>
80100f83:	eb 25                	jmp    80100faa <consoleintr+0x26a>
80100f85:	8d 76 00             	lea    0x0(%esi),%esi
    i++;
80100f88:	83 c2 01             	add    $0x1,%edx
  while (word[i]!='\0' && word[i]!='\n')
80100f8b:	0f b6 04 13          	movzbl (%ebx,%edx,1),%eax
80100f8f:	84 c0                	test   %al,%al
80100f91:	0f 84 01 05 00 00    	je     80101498 <consoleintr+0x758>
80100f97:	3c 0a                	cmp    $0xa,%al
80100f99:	0f 84 f9 04 00 00    	je     80101498 <consoleintr+0x758>
    if(word[i]!=h[i])
80100f9f:	0f b6 8a 88 85 10 80 	movzbl -0x7fef7a78(%edx),%ecx
80100fa6:	38 c8                	cmp    %cl,%al
80100fa8:	74 de                	je     80100f88 <consoleintr+0x248>
            if (history.count < 9){
80100faa:	8b 1d 60 14 11 80    	mov    0x80111460,%ebx
80100fb0:	83 fb 08             	cmp    $0x8,%ebx
80100fb3:	0f 8f 43 05 00 00    	jg     801014fc <consoleintr+0x7bc>
            history.instructions[history.last + 1] = input;
80100fb9:	a1 5c 14 11 80       	mov    0x8011145c,%eax
80100fbe:	be 20 15 11 80       	mov    $0x80111520,%esi
80100fc3:	b9 23 00 00 00       	mov    $0x23,%ecx
            history.count ++ ;
80100fc8:	83 c3 01             	add    $0x1,%ebx
80100fcb:	89 1d 60 14 11 80    	mov    %ebx,0x80111460
            history.instructions[history.last + 1] = input;
80100fd1:	8d 50 01             	lea    0x1(%eax),%edx
80100fd4:	69 c2 8c 00 00 00    	imul   $0x8c,%edx,%eax
            history.last ++ ;
80100fda:	89 15 5c 14 11 80    	mov    %edx,0x8011145c
            history.index = history.last;
80100fe0:	89 15 58 14 11 80    	mov    %edx,0x80111458
            history.instructions[history.last + 1] = input;
80100fe6:	05 e0 0e 11 80       	add    $0x80110ee0,%eax
80100feb:	89 c7                	mov    %eax,%edi
80100fed:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
          wakeup(&input.r);
80100fef:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ff2:	a1 a8 15 11 80       	mov    0x801115a8,%eax
          backs = 0;
80100ff7:	c7 05 f8 15 11 80 00 	movl   $0x0,0x801115f8
80100ffe:	00 00 00 
          wakeup(&input.r);
80101001:	68 a0 15 11 80       	push   $0x801115a0
          input.w = input.e;
80101006:	a3 a4 15 11 80       	mov    %eax,0x801115a4
          wakeup(&input.r);
8010100b:	e8 50 3f 00 00       	call   80104f60 <wakeup>
80101010:	83 c4 10             	add    $0x10,%esp
80101013:	e9 6a fd ff ff       	jmp    80100d82 <consoleintr+0x42>
80101018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010101f:	90                   	nop
    switch(c){
80101020:	c7 85 cc fd ff ff 01 	movl   $0x1,-0x234(%ebp)
80101027:	00 00 00 
8010102a:	e9 53 fd ff ff       	jmp    80100d82 <consoleintr+0x42>
8010102f:	90                   	nop
      while(input.e != input.w &&
80101030:	a1 a8 15 11 80       	mov    0x801115a8,%eax
80101035:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
8010103b:	0f 84 41 fd ff ff    	je     80100d82 <consoleintr+0x42>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101041:	83 e8 01             	sub    $0x1,%eax
80101044:	89 c2                	mov    %eax,%edx
80101046:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101049:	80 ba 20 15 11 80 0a 	cmpb   $0xa,-0x7feeeae0(%edx)
80101050:	0f 84 2c fd ff ff    	je     80100d82 <consoleintr+0x42>
  if(panicked){
80101056:	8b 35 fc 15 11 80    	mov    0x801115fc,%esi
        input.e--;
8010105c:	a3 a8 15 11 80       	mov    %eax,0x801115a8
  if(panicked){
80101061:	85 f6                	test   %esi,%esi
80101063:	0f 84 85 02 00 00    	je     801012ee <consoleintr+0x5ae>
  asm volatile("cli");
80101069:	fa                   	cli    
    for(;;)
8010106a:	eb fe                	jmp    8010106a <consoleintr+0x32a>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((input.e - backs )> input.w){
80101070:	a1 a8 15 11 80       	mov    0x801115a8,%eax
80101075:	89 c2                	mov    %eax,%edx
80101077:	2b 15 f8 15 11 80    	sub    0x801115f8,%edx
8010107d:	3b 15 a4 15 11 80    	cmp    0x801115a4,%edx
80101083:	0f 86 f9 fc ff ff    	jbe    80100d82 <consoleintr+0x42>
  if(panicked){
80101089:	8b 1d fc 15 11 80    	mov    0x801115fc,%ebx
        input.e--;
8010108f:	83 e8 01             	sub    $0x1,%eax
80101092:	a3 a8 15 11 80       	mov    %eax,0x801115a8
  if(panicked){
80101097:	85 db                	test   %ebx,%ebx
80101099:	0f 84 ad 02 00 00    	je     8010134c <consoleintr+0x60c>
8010109f:	fa                   	cli    
    for(;;)
801010a0:	eb fe                	jmp    801010a0 <consoleintr+0x360>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(saveInp.active == 1)
801010a8:	83 3d 08 15 11 80 01 	cmpl   $0x1,0x80111508
801010af:	0f 85 cd fc ff ff    	jne    80100d82 <consoleintr+0x42>
      saveInp.end = input.e-backs;
801010b5:	8b 35 a8 15 11 80    	mov    0x801115a8,%esi
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010bb:	8b 15 00 15 11 80    	mov    0x80111500,%edx
      int count = 0;
801010c1:	31 db                	xor    %ebx,%ebx
      saveInp.end = input.e-backs;
801010c3:	89 f1                	mov    %esi,%ecx
801010c5:	2b 0d f8 15 11 80    	sub    0x801115f8,%ecx
      for (int j = input.e; j >= saveInp.end; j--){// jadid
801010cb:	89 f0                	mov    %esi,%eax
      saveInp.end = input.e-backs;
801010cd:	89 0d 04 15 11 80    	mov    %ecx,0x80111504
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010d3:	83 fa 7f             	cmp    $0x7f,%edx
801010d6:	0f 8f ac 02 00 00    	jg     80101388 <consoleintr+0x648>
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (saveInp.copybuf[i] != '\0'){
801010e0:	80 ba 80 14 11 80 00 	cmpb   $0x0,-0x7feeeb80(%edx)
801010e7:	74 0a                	je     801010f3 <consoleintr+0x3b3>
          arr[count] = i;
801010e9:	89 94 9d e8 fd ff ff 	mov    %edx,-0x218(%ebp,%ebx,4)
          count++;
801010f0:	83 c3 01             	add    $0x1,%ebx
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010f3:	83 c2 01             	add    $0x1,%edx
801010f6:	81 fa 80 00 00 00    	cmp    $0x80,%edx
801010fc:	75 e2                	jne    801010e0 <consoleintr+0x3a0>
      input.e = input.e + count;
801010fe:	01 de                	add    %ebx,%esi
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101100:	39 c1                	cmp    %eax,%ecx
80101102:	7f 19                	jg     8010111d <consoleintr+0x3dd>
80101104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[j + count] = input.buf[j];
80101108:	0f b6 90 20 15 11 80 	movzbl -0x7feeeae0(%eax),%edx
8010110f:	88 94 03 20 15 11 80 	mov    %dl,-0x7feeeae0(%ebx,%eax,1)
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101116:	83 e8 01             	sub    $0x1,%eax
80101119:	39 c1                	cmp    %eax,%ecx
8010111b:	7e eb                	jle    80101108 <consoleintr+0x3c8>
      input.e = input.e + count;
8010111d:	89 35 a8 15 11 80    	mov    %esi,0x801115a8
      for (int i=0; i<count ; i++)
80101123:	85 db                	test   %ebx,%ebx
80101125:	0f 84 57 fc ff ff    	je     80100d82 <consoleintr+0x42>
8010112b:	31 f6                	xor    %esi,%esi
8010112d:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101133:	89 da                	mov    %ebx,%edx
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
80101135:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80101138:	0f be 98 80 14 11 80 	movsbl -0x7feeeb80(%eax),%ebx
8010113f:	88 9c 31 20 15 11 80 	mov    %bl,-0x7feeeae0(%ecx,%esi,1)
  if(panicked){
80101146:	8b 0d fc 15 11 80    	mov    0x801115fc,%ecx
8010114c:	85 c9                	test   %ecx,%ecx
8010114e:	0f 84 44 02 00 00    	je     80101398 <consoleintr+0x658>
80101154:	fa                   	cli    
    for(;;)
80101155:	eb fe                	jmp    80101155 <consoleintr+0x415>
80101157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010115e:	66 90                	xchg   %ax,%ax
      saveInp.active = 1;
80101160:	c7 05 08 15 11 80 01 	movl   $0x1,0x80111508
80101167:	00 00 00 
      saveInp.start = input.e-backs;
8010116a:	a1 a8 15 11 80       	mov    0x801115a8,%eax
8010116f:	2b 05 f8 15 11 80    	sub    0x801115f8,%eax
80101175:	a3 00 15 11 80       	mov    %eax,0x80111500
      for (int i = 0; i < 128; i++)
8010117a:	31 c0                	xor    %eax,%eax
8010117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        saveInp.copybuf[i] = '\0';
80101180:	c6 80 80 14 11 80 00 	movb   $0x0,-0x7feeeb80(%eax)
      for (int i = 0; i < 128; i++)
80101187:	83 c0 01             	add    $0x1,%eax
8010118a:	3d 80 00 00 00       	cmp    $0x80,%eax
8010118f:	75 ef                	jne    80101180 <consoleintr+0x440>
80101191:	e9 ec fb ff ff       	jmp    80100d82 <consoleintr+0x42>
80101196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
      if ((history.count != 0 ) && (history.last - history.index  - 1 > 0))
801011a0:	a1 60 14 11 80       	mov    0x80111460,%eax
801011a5:	85 c0                	test   %eax,%eax
801011a7:	0f 84 d5 fb ff ff    	je     80100d82 <consoleintr+0x42>
801011ad:	a1 5c 14 11 80       	mov    0x8011145c,%eax
801011b2:	2b 05 58 14 11 80    	sub    0x80111458,%eax
801011b8:	83 f8 01             	cmp    $0x1,%eax
801011bb:	0f 8e c1 fb ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(DOWN);
801011c1:	b8 03 00 00 00       	mov    $0x3,%eax
801011c6:	e8 05 f7 ff ff       	call   801008d0 <handle_up_down_arrow>
801011cb:	e9 b2 fb ff ff       	jmp    80100d82 <consoleintr+0x42>
  if(panicked){
801011d0:	a1 fc 15 11 80       	mov    0x801115fc,%eax
801011d5:	85 c0                	test   %eax,%eax
801011d7:	0f 85 5b 01 00 00    	jne    80101338 <consoleintr+0x5f8>
    uartputc(c);
801011dd:	83 ec 0c             	sub    $0xc,%esp
801011e0:	6a 3f                	push   $0x3f
801011e2:	e8 49 5e 00 00       	call   80107030 <uartputc>
  cgaputc(c);
801011e7:	b8 3f 00 00 00       	mov    $0x3f,%eax
801011ec:	e8 7f f3 ff ff       	call   80100570 <cgaputc>
  if(input.buf[input.e-1] == 61)
801011f1:	8b 3d a8 15 11 80    	mov    0x801115a8,%edi
801011f7:	83 c4 10             	add    $0x10,%esp
801011fa:	80 bf 1f 15 11 80 3d 	cmpb   $0x3d,-0x7feeeae1(%edi)
80101201:	0f 85 7b fb ff ff    	jne    80100d82 <consoleintr+0x42>
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101207:	0f b6 87 1e 15 11 80 	movzbl -0x7feeeae2(%edi),%eax
8010120e:	8d 4f fe             	lea    -0x2(%edi),%ecx
    int first_num_index=0;
80101211:	c7 85 e0 fd ff ff 00 	movl   $0x0,-0x220(%ebp)
80101218:	00 00 00 
    int second_num_index=0;
8010121b:	c7 85 e4 fd ff ff 00 	movl   $0x0,-0x21c(%ebp)
80101222:	00 00 00 
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101225:	83 e8 30             	sub    $0x30,%eax
80101228:	3c 09                	cmp    $0x9,%al
8010122a:	0f 87 52 fb ff ff    	ja     80100d82 <consoleintr+0x42>
    int first_num=read_num(input.e-2, &first_num_index);
80101230:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
80101236:	89 c8                	mov    %ecx,%eax
80101238:	e8 f3 f1 ff ff       	call   80100430 <read_num.constprop.0>
    int second_num = read_num(first_num_index-2, &second_num_index);
8010123d:	8d 95 e4 fd ff ff    	lea    -0x21c(%ebp),%edx
    int first_num=read_num(input.e-2, &first_num_index);
80101243:	89 c3                	mov    %eax,%ebx
    int second_num = read_num(first_num_index-2, &second_num_index);
80101245:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
8010124b:	83 e8 02             	sub    $0x2,%eax
8010124e:	e8 dd f1 ff ff       	call   80100430 <read_num.constprop.0>
    delete_letters(second_num_index);
80101253:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    int second_num = read_num(first_num_index-2, &second_num_index);
80101259:	89 c6                	mov    %eax,%esi
  for(int i=end_index; i<input.e ; i++)
8010125b:	39 d7                	cmp    %edx,%edi
8010125d:	0f 86 cd 01 00 00    	jbe    80101430 <consoleintr+0x6f0>
80101263:	89 d7                	mov    %edx,%edi
  if(panicked){
80101265:	a1 fc 15 11 80       	mov    0x801115fc,%eax
8010126a:	85 c0                	test   %eax,%eax
8010126c:	0f 84 80 01 00 00    	je     801013f2 <consoleintr+0x6b2>
80101272:	fa                   	cli    
    for(;;)
80101273:	eb fe                	jmp    80101273 <consoleintr+0x533>
80101275:	8d 76 00             	lea    0x0(%esi),%esi
      if ((input.e - backs) > input.w) //ensure cursor position stays in valid bounds
80101278:	8b 0d f8 15 11 80    	mov    0x801115f8,%ecx
8010127e:	a1 a8 15 11 80       	mov    0x801115a8,%eax
80101283:	29 c8                	sub    %ecx,%eax
80101285:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
8010128b:	0f 86 f1 fa ff ff    	jbe    80100d82 <consoleintr+0x42>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101291:	bf d4 03 00 00       	mov    $0x3d4,%edi
80101296:	b8 0e 00 00 00       	mov    $0xe,%eax
8010129b:	89 fa                	mov    %edi,%edx
8010129d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010129e:	be d5 03 00 00       	mov    $0x3d5,%esi
801012a3:	89 f2                	mov    %esi,%edx
801012a5:	ec                   	in     (%dx),%al
  position = inb(CRTPORT + 1) << 8;
801012a6:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	89 c3                	mov    %eax,%ebx
801012ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801012b2:	c1 e3 08             	shl    $0x8,%ebx
801012b5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801012b6:	89 f2                	mov    %esi,%edx
801012b8:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT + 1);
801012b9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801012bc:	89 fa                	mov    %edi,%edx
801012be:	09 c3                	or     %eax,%ebx
801012c0:	b8 0e 00 00 00       	mov    $0xe,%eax
    position--;
801012c5:	83 eb 01             	sub    $0x1,%ebx
801012c8:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, position >> 8);
801012c9:	89 da                	mov    %ebx,%edx
801012cb:	c1 fa 08             	sar    $0x8,%edx
801012ce:	89 d0                	mov    %edx,%eax
801012d0:	89 f2                	mov    %esi,%edx
801012d2:	ee                   	out    %al,(%dx)
801012d3:	b8 0f 00 00 00       	mov    $0xf,%eax
801012d8:	89 fa                	mov    %edi,%edx
801012da:	ee                   	out    %al,(%dx)
801012db:	89 d8                	mov    %ebx,%eax
801012dd:	89 f2                	mov    %esi,%edx
801012df:	ee                   	out    %al,(%dx)
        backs++;
801012e0:	83 c1 01             	add    $0x1,%ecx
801012e3:	89 0d f8 15 11 80    	mov    %ecx,0x801115f8
801012e9:	e9 94 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	6a 08                	push   $0x8
801012f3:	e8 38 5d 00 00       	call   80107030 <uartputc>
801012f8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801012ff:	e8 2c 5d 00 00       	call   80107030 <uartputc>
80101304:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010130b:	e8 20 5d 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80101310:	b8 00 01 00 00       	mov    $0x100,%eax
80101315:	e8 56 f2 ff ff       	call   80100570 <cgaputc>
      while(input.e != input.w &&
8010131a:	a1 a8 15 11 80       	mov    0x801115a8,%eax
8010131f:	83 c4 10             	add    $0x10,%esp
80101322:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
80101328:	0f 85 13 fd ff ff    	jne    80101041 <consoleintr+0x301>
8010132e:	e9 4f fa ff ff       	jmp    80100d82 <consoleintr+0x42>
80101333:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101337:	90                   	nop
  asm volatile("cli");
80101338:	fa                   	cli    
    for(;;)
80101339:	eb fe                	jmp    80101339 <consoleintr+0x5f9>
8010133b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010133f:	90                   	nop
}
80101340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101343:	5b                   	pop    %ebx
80101344:	5e                   	pop    %esi
80101345:	5f                   	pop    %edi
80101346:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80101347:	e9 f4 3c 00 00       	jmp    80105040 <procdump>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	6a 08                	push   $0x8
80101351:	e8 da 5c 00 00       	call   80107030 <uartputc>
80101356:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010135d:	e8 ce 5c 00 00       	call   80107030 <uartputc>
80101362:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101369:	e8 c2 5c 00 00       	call   80107030 <uartputc>
  cgaputc(c);
8010136e:	b8 00 01 00 00       	mov    $0x100,%eax
80101373:	e8 f8 f1 ff ff       	call   80100570 <cgaputc>
}
80101378:	83 c4 10             	add    $0x10,%esp
8010137b:	e9 02 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
80101380:	fa                   	cli    
    for(;;)
80101381:	eb fe                	jmp    80101381 <consoleintr+0x641>
80101383:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101387:	90                   	nop
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101388:	39 f1                	cmp    %esi,%ecx
8010138a:	0f 8e 78 fd ff ff    	jle    80101108 <consoleintr+0x3c8>
80101390:	e9 ed f9 ff ff       	jmp    80100d82 <consoleintr+0x42>
80101395:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80101398:	83 ec 0c             	sub    $0xc,%esp
8010139b:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
      for (int i=0; i<count ; i++)
801013a1:	83 c6 01             	add    $0x1,%esi
    uartputc(c);
801013a4:	53                   	push   %ebx
801013a5:	e8 86 5c 00 00       	call   80107030 <uartputc>
  cgaputc(c);
801013aa:	89 d8                	mov    %ebx,%eax
801013ac:	e8 bf f1 ff ff       	call   80100570 <cgaputc>
      for (int i=0; i<count ; i++)
801013b1:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
801013b7:	83 c4 10             	add    $0x10,%esp
801013ba:	39 d6                	cmp    %edx,%esi
801013bc:	0f 84 c0 f9 ff ff    	je     80100d82 <consoleintr+0x42>
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
801013c2:	8b 0d 04 15 11 80    	mov    0x80111504,%ecx
801013c8:	e9 68 fd ff ff       	jmp    80101135 <consoleintr+0x3f5>
          if (saveInp.copybuf[(input.e-backs)%INPUT_BUF] == '\0')
801013cd:	89 c7                	mov    %eax,%edi
801013cf:	2b 3d f8 15 11 80    	sub    0x801115f8,%edi
801013d5:	89 fe                	mov    %edi,%esi
801013d7:	83 e6 7f             	and    $0x7f,%esi
801013da:	80 be 80 14 11 80 00 	cmpb   $0x0,-0x7feeeb80(%esi)
801013e1:	0f 85 6a 01 00 00    	jne    80101551 <consoleintr+0x811>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
801013e7:	88 96 80 14 11 80    	mov    %dl,-0x7feeeb80(%esi)
801013ed:	e9 22 fb ff ff       	jmp    80100f14 <consoleintr+0x1d4>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f2:	83 ec 0c             	sub    $0xc,%esp
  for(int i=end_index; i<input.e ; i++)
801013f5:	83 c7 01             	add    $0x1,%edi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f8:	6a 08                	push   $0x8
801013fa:	e8 31 5c 00 00       	call   80107030 <uartputc>
801013ff:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101406:	e8 25 5c 00 00       	call   80107030 <uartputc>
8010140b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101412:	e8 19 5c 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80101417:	b8 00 01 00 00       	mov    $0x100,%eax
8010141c:	e8 4f f1 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80101421:	83 c4 10             	add    $0x10,%esp
80101424:	3b 3d a8 15 11 80    	cmp    0x801115a8,%edi
8010142a:	0f 82 35 fe ff ff    	jb     80101265 <consoleintr+0x525>
  if(panicked){
80101430:	a1 fc 15 11 80       	mov    0x801115fc,%eax
80101435:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
8010143b:	85 c0                	test   %eax,%eax
8010143d:	0f 84 3d 01 00 00    	je     80101580 <consoleintr+0x840>
80101443:	fa                   	cli    
    for(;;)
80101444:	eb fe                	jmp    80101444 <consoleintr+0x704>
80101446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010144d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101450:	83 ec 0c             	sub    $0xc,%esp
80101453:	6a 08                	push   $0x8
80101455:	e8 d6 5b 00 00       	call   80107030 <uartputc>
8010145a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101461:	e8 ca 5b 00 00       	call   80107030 <uartputc>
80101466:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010146d:	e8 be 5b 00 00       	call   80107030 <uartputc>
  cgaputc(c);
80101472:	b8 00 01 00 00       	mov    $0x100,%eax
80101477:	e8 f4 f0 ff ff       	call   80100570 <cgaputc>
8010147c:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
8010147f:	a1 a0 15 11 80       	mov    0x801115a0,%eax
80101484:	83 e8 80             	sub    $0xffffff80,%eax
80101487:	39 05 a8 15 11 80    	cmp    %eax,0x801115a8
8010148d:	0f 85 ef f8 ff ff    	jne    80100d82 <consoleintr+0x42>
80101493:	e9 c9 fa ff ff       	jmp    80100f61 <consoleintr+0x221>
  if(i!=7)
80101498:	83 fa 07             	cmp    $0x7,%edx
8010149b:	0f 85 09 fb ff ff    	jne    80100faa <consoleintr+0x26a>
            release(&cons.lock);
801014a1:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014a4:	31 db                	xor    %ebx,%ebx
            release(&cons.lock);
801014a6:	68 c0 15 11 80       	push   $0x801115c0
801014ab:	e8 90 3f 00 00       	call   80105440 <release>
            for(int i=0 ; i<history.count+1 ; i++)
801014b0:	8b 15 60 14 11 80    	mov    0x80111460,%edx
801014b6:	83 c4 10             	add    $0x10,%esp
801014b9:	85 d2                	test   %edx,%edx
801014bb:	78 2a                	js     801014e7 <consoleintr+0x7a7>
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014bd:	8b 83 64 0f 11 80    	mov    -0x7feef09c(%ebx),%eax
801014c3:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014c6:	83 c6 01             	add    $0x1,%esi
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014c9:	01 d8                	add    %ebx,%eax
            for(int i=0 ; i<history.count+1 ; i++)
801014cb:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014d1:	05 e0 0e 11 80       	add    $0x80110ee0,%eax
801014d6:	50                   	push   %eax
801014d7:	e8 94 f5 ff ff       	call   80100a70 <cprintf>
            for(int i=0 ; i<history.count+1 ; i++)
801014dc:	83 c4 10             	add    $0x10,%esp
801014df:	39 35 60 14 11 80    	cmp    %esi,0x80111460
801014e5:	7d d6                	jge    801014bd <consoleintr+0x77d>
            acquire(&cons.lock);
801014e7:	83 ec 0c             	sub    $0xc,%esp
801014ea:	68 c0 15 11 80       	push   $0x801115c0
801014ef:	e8 ac 3f 00 00       	call   801054a0 <acquire>
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	e9 f3 fa ff ff       	jmp    80100fef <consoleintr+0x2af>
801014fc:	ba cc 13 11 80       	mov    $0x801113cc,%edx
80101501:	b8 e0 0e 11 80       	mov    $0x80110ee0,%eax
80101506:	89 d3                	mov    %edx,%ebx
                history.instructions[i] = history.instructions[i+1]; 
80101508:	8d b0 8c 00 00 00    	lea    0x8c(%eax),%esi
8010150e:	89 c7                	mov    %eax,%edi
              for (int i = 0; i < 9; i++) {
80101510:	05 8c 00 00 00       	add    $0x8c,%eax
                history.instructions[i] = history.instructions[i+1]; 
80101515:	b9 23 00 00 00       	mov    $0x23,%ecx
8010151a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              for (int i = 0; i < 9; i++) {
8010151c:	39 c3                	cmp    %eax,%ebx
8010151e:	75 e8                	jne    80101508 <consoleintr+0x7c8>
              history.instructions[9] = input;
80101520:	be 20 15 11 80       	mov    $0x80111520,%esi
80101525:	b9 23 00 00 00       	mov    $0x23,%ecx
8010152a:	89 d7                	mov    %edx,%edi
              history.index = 9;
8010152c:	c7 05 58 14 11 80 09 	movl   $0x9,0x80111458
80101533:	00 00 00 
              history.instructions[9] = input;
80101536:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              history.last = 9;
80101538:	c7 05 5c 14 11 80 09 	movl   $0x9,0x8011145c
8010153f:	00 00 00 
              history.count = 10;
80101542:	c7 05 60 14 11 80 0a 	movl   $0xa,0x80111460
80101549:	00 00 00 
8010154c:	e9 9e fa ff ff       	jmp    80100fef <consoleintr+0x2af>
            for (int i = input.e; i > input.e - backs; i--)
80101551:	89 c1                	mov    %eax,%ecx
80101553:	39 f8                	cmp    %edi,%eax
80101555:	0f 86 8c fe ff ff    	jbe    801013e7 <consoleintr+0x6a7>
8010155b:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
              saveInp.copybuf[i] = saveInp.copybuf[i - 1]; // shift to right all letters in buffer
80101561:	0f b6 81 7f 14 11 80 	movzbl -0x7feeeb81(%ecx),%eax
80101568:	83 e9 01             	sub    $0x1,%ecx
8010156b:	88 81 81 14 11 80    	mov    %al,-0x7feeeb7f(%ecx)
            for (int i = input.e; i > input.e - backs; i--)
80101571:	39 cf                	cmp    %ecx,%edi
80101573:	72 ec                	jb     80101561 <consoleintr+0x821>
80101575:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
8010157b:	e9 67 fe ff ff       	jmp    801013e7 <consoleintr+0x6a7>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101580:	83 ec 0c             	sub    $0xc,%esp
80101583:	6a 08                	push   $0x8
80101585:	e8 a6 5a 00 00       	call   80107030 <uartputc>
8010158a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101591:	e8 9a 5a 00 00       	call   80107030 <uartputc>
80101596:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010159d:	e8 8e 5a 00 00       	call   80107030 <uartputc>
  cgaputc(c);
801015a2:	b8 00 01 00 00       	mov    $0x100,%eax
801015a7:	e8 c4 ef ff ff       	call   80100570 <cgaputc>
    switch (input.buf[first_num_index-1])
801015ac:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
801015b2:	83 c4 10             	add    $0x10,%esp
801015b5:	0f b6 80 1f 15 11 80 	movzbl -0x7feeeae1(%eax),%eax
801015bc:	3c 2d                	cmp    $0x2d,%al
801015be:	0f 84 a2 01 00 00    	je     80101766 <consoleintr+0xa26>
801015c4:	0f 8f a5 00 00 00    	jg     8010166f <consoleintr+0x92f>
801015ca:	3c 2a                	cmp    $0x2a,%al
801015cc:	0f 84 37 01 00 00    	je     80101709 <consoleintr+0x9c9>
801015d2:	3c 2b                	cmp    $0x2b,%al
801015d4:	0f 85 81 01 00 00    	jne    8010175b <consoleintr+0xa1b>
      int_to_str(first_num + second_num, result);
801015da:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
801015e0:	01 f3                	add    %esi,%ebx
801015e2:	50                   	push   %eax
801015e3:	50                   	push   %eax
801015e4:	57                   	push   %edi
801015e5:	53                   	push   %ebx
801015e6:	e8 95 ec ff ff       	call   80100280 <int_to_str>
      break;
801015eb:	83 c4 10             	add    $0x10,%esp
    release(&cons.lock);
801015ee:	83 ec 0c             	sub    $0xc,%esp
801015f1:	68 c0 15 11 80       	push   $0x801115c0
801015f6:	e8 45 3e 00 00       	call   80105440 <release>
    cprintf(result);
801015fb:	89 3c 24             	mov    %edi,(%esp)
801015fe:	e8 6d f4 ff ff       	call   80100a70 <cprintf>
    update_input(second_num_index, result);
80101603:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
  while (new_string[j]!='\0')
80101609:	0f b6 9d e8 fd ff ff 	movzbl -0x218(%ebp),%ebx
80101610:	83 c4 10             	add    $0x10,%esp
  int i = update_index;
80101613:	89 c8                	mov    %ecx,%eax
  while (new_string[j]!='\0')
80101615:	84 db                	test   %bl,%bl
80101617:	74 2c                	je     80101645 <consoleintr+0x905>
  int i = update_index;
80101619:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
    j++;
8010161f:	83 c2 01             	add    $0x1,%edx
    input.buf[i] = new_string[j];
80101622:	88 98 20 15 11 80    	mov    %bl,-0x7feeeae0(%eax)
    i++;
80101628:	83 c0 01             	add    $0x1,%eax
  while (new_string[j]!='\0')
8010162b:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
8010162f:	84 db                	test   %bl,%bl
80101631:	75 ec                	jne    8010161f <consoleintr+0x8df>
80101633:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
80101639:	eb 0a                	jmp    80101645 <consoleintr+0x905>
    input.buf[i] = '\0';
8010163b:	c6 80 20 15 11 80 00 	movb   $0x0,-0x7feeeae0(%eax)
    i++;
80101642:	83 c0 01             	add    $0x1,%eax
  while (input.buf[i]!='\0')
80101645:	80 b8 20 15 11 80 00 	cmpb   $0x0,-0x7feeeae0(%eax)
8010164c:	75 ed                	jne    8010163b <consoleintr+0x8fb>
    acquire(&cons.lock);
8010164e:	83 ec 0c             	sub    $0xc,%esp
  input.e = update_index+j;
80101651:	03 8d c0 fd ff ff    	add    -0x240(%ebp),%ecx
    acquire(&cons.lock);
80101657:	68 c0 15 11 80       	push   $0x801115c0
  input.e = update_index+j;
8010165c:	89 0d a8 15 11 80    	mov    %ecx,0x801115a8
    acquire(&cons.lock);
80101662:	e8 39 3e 00 00       	call   801054a0 <acquire>
80101667:	83 c4 10             	add    $0x10,%esp
8010166a:	e9 13 f7 ff ff       	jmp    80100d82 <consoleintr+0x42>
    switch (input.buf[first_num_index-1])
8010166f:	3c 2f                	cmp    $0x2f,%al
80101671:	0f 85 e4 00 00 00    	jne    8010175b <consoleintr+0xa1b>
    int int_part = (int)num;
80101677:	d9 bd d6 fd ff ff    	fnstcw -0x22a(%ebp)
      float_to_str((float)second_num / (float)first_num, result);
8010167d:	89 b5 bc fd ff ff    	mov    %esi,-0x244(%ebp)
80101683:	db 85 bc fd ff ff    	fildl  -0x244(%ebp)
80101689:	89 9d bc fd ff ff    	mov    %ebx,-0x244(%ebp)
8010168f:	db 85 bc fd ff ff    	fildl  -0x244(%ebp)
    int int_part = (int)num;
80101695:	0f b7 85 d6 fd ff ff 	movzwl -0x22a(%ebp),%eax
      float_to_str((float)second_num / (float)first_num, result);
8010169c:	de f9                	fdivrp %st,%st(1)
    int int_part = (int)num;
8010169e:	80 cc 0c             	or     $0xc,%ah
801016a1:	66 89 85 d4 fd ff ff 	mov    %ax,-0x22c(%ebp)
801016a8:	d9 ad d4 fd ff ff    	fldcw  -0x22c(%ebp)
801016ae:	db 95 bc fd ff ff    	fistl  -0x244(%ebp)
801016b4:	d9 ad d6 fd ff ff    	fldcw  -0x22a(%ebp)
    int fractional_part = (int)((num - int_part) * 10);
801016ba:	db 85 bc fd ff ff    	fildl  -0x244(%ebp)
    int int_part = (int)num;
801016c0:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
    int fractional_part = (int)((num - int_part) * 10);
801016c6:	de e9                	fsubrp %st,%st(1)
801016c8:	d8 0d ec 85 10 80    	fmuls  0x801085ec
801016ce:	d9 ad d4 fd ff ff    	fldcw  -0x22c(%ebp)
801016d4:	db 9d bc fd ff ff    	fistpl -0x244(%ebp)
801016da:	d9 ad d6 fd ff ff    	fldcw  -0x22a(%ebp)
801016e0:	8b 9d bc fd ff ff    	mov    -0x244(%ebp),%ebx
    if (fractional_part == 0)
801016e6:	85 db                	test   %ebx,%ebx
801016e8:	75 39                	jne    80101723 <consoleintr+0x9e3>
      int index = int_to_str(int_part, str);
801016ea:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
801016f0:	53                   	push   %ebx
801016f1:	53                   	push   %ebx
801016f2:	57                   	push   %edi
801016f3:	50                   	push   %eax
801016f4:	e8 87 eb ff ff       	call   80100280 <int_to_str>
      str[index++] = '\0';
801016f9:	83 c4 10             	add    $0x10,%esp
801016fc:	c6 84 05 e8 fd ff ff 	movb   $0x0,-0x218(%ebp,%eax,1)
80101703:	00 
80101704:	e9 e5 fe ff ff       	jmp    801015ee <consoleintr+0x8ae>
      int_to_str(first_num * second_num, result);
80101709:	0f af de             	imul   %esi,%ebx
8010170c:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101712:	50                   	push   %eax
80101713:	50                   	push   %eax
80101714:	57                   	push   %edi
80101715:	53                   	push   %ebx
80101716:	e8 65 eb ff ff       	call   80100280 <int_to_str>
      break;
8010171b:	83 c4 10             	add    $0x10,%esp
8010171e:	e9 cb fe ff ff       	jmp    801015ee <consoleintr+0x8ae>
      int index = int_to_str(int_part, str);
80101723:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101729:	51                   	push   %ecx
8010172a:	51                   	push   %ecx
8010172b:	57                   	push   %edi
8010172c:	50                   	push   %eax
8010172d:	e8 4e eb ff ff       	call   80100280 <int_to_str>
      str[index++] = fractional_part + '0';
80101732:	89 d9                	mov    %ebx,%ecx
80101734:	f7 d9                	neg    %ecx
      str[index++] = '.';
80101736:	c6 84 05 e8 fd ff ff 	movb   $0x2e,-0x218(%ebp,%eax,1)
8010173d:	2e 
      str[index++] = fractional_part + '0';
8010173e:	0f 48 cb             	cmovs  %ebx,%ecx
      str[index] = '\0';
80101741:	c6 84 05 ea fd ff ff 	movb   $0x0,-0x216(%ebp,%eax,1)
80101748:	00 
80101749:	83 c4 10             	add    $0x10,%esp
      str[index++] = fractional_part + '0';
8010174c:	83 c1 30             	add    $0x30,%ecx
8010174f:	88 8c 05 e9 fd ff ff 	mov    %cl,-0x217(%ebp,%eax,1)
      str[index] = '\0';
80101756:	e9 93 fe ff ff       	jmp    801015ee <consoleintr+0x8ae>
8010175b:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101761:	e9 88 fe ff ff       	jmp    801015ee <consoleintr+0x8ae>
      int_to_str(second_num - first_num, result);
80101766:	29 de                	sub    %ebx,%esi
80101768:	57                   	push   %edi
80101769:	57                   	push   %edi
8010176a:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101770:	57                   	push   %edi
80101771:	56                   	push   %esi
80101772:	e8 09 eb ff ff       	call   80100280 <int_to_str>
      break;
80101777:	83 c4 10             	add    $0x10,%esp
8010177a:	e9 6f fe ff ff       	jmp    801015ee <consoleintr+0x8ae>
8010177f:	90                   	nop

80101780 <consoleinit>:

void
consoleinit(void)
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101786:	68 90 85 10 80       	push   $0x80108590
8010178b:	68 c0 15 11 80       	push   $0x801115c0
80101790:	e8 3b 3b 00 00       	call   801052d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101795:	58                   	pop    %eax
80101796:	5a                   	pop    %edx
80101797:	6a 00                	push   $0x0
80101799:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010179b:	c7 05 ac 1f 11 80 a0 	movl   $0x801007a0,0x80111fac
801017a2:	07 10 80 
  devsw[CONSOLE].read = consoleread;
801017a5:	c7 05 a8 1f 11 80 30 	movl   $0x80100330,0x80111fa8
801017ac:	03 10 80 
  cons.locking = 1;
801017af:	c7 05 f4 15 11 80 01 	movl   $0x1,0x801115f4
801017b6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801017b9:	e8 f2 19 00 00       	call   801031b0 <ioapicenable>
}
801017be:	83 c4 10             	add    $0x10,%esp
801017c1:	c9                   	leave  
801017c2:	c3                   	ret    
801017c3:	66 90                	xchg   %ax,%ax
801017c5:	66 90                	xchg   %ax,%ax
801017c7:	66 90                	xchg   %ax,%ax
801017c9:	66 90                	xchg   %ax,%ax
801017cb:	66 90                	xchg   %ax,%ax
801017cd:	66 90                	xchg   %ax,%ax
801017cf:	90                   	nop

801017d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801017dc:	e8 ef 2e 00 00       	call   801046d0 <myproc>
801017e1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801017e7:	e8 a4 22 00 00       	call   80103a90 <begin_op>

  if((ip = namei(path)) == 0){
801017ec:	83 ec 0c             	sub    $0xc,%esp
801017ef:	ff 75 08             	push   0x8(%ebp)
801017f2:	e8 e9 15 00 00       	call   80102de0 <namei>
801017f7:	83 c4 10             	add    $0x10,%esp
801017fa:	85 c0                	test   %eax,%eax
801017fc:	0f 84 0b 03 00 00    	je     80101b0d <exec+0x33d>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101802:	83 ec 0c             	sub    $0xc,%esp
80101805:	89 c3                	mov    %eax,%ebx
80101807:	50                   	push   %eax
80101808:	e8 a3 0c 00 00       	call   801024b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010180d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101813:	6a 34                	push   $0x34
80101815:	6a 00                	push   $0x0
80101817:	50                   	push   %eax
80101818:	53                   	push   %ebx
80101819:	e8 a2 0f 00 00       	call   801027c0 <readi>
8010181e:	83 c4 20             	add    $0x20,%esp
80101821:	83 f8 34             	cmp    $0x34,%eax
80101824:	74 22                	je     80101848 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101826:	83 ec 0c             	sub    $0xc,%esp
80101829:	53                   	push   %ebx
8010182a:	e8 11 0f 00 00       	call   80102740 <iunlockput>
    end_op();
8010182f:	e8 cc 22 00 00       	call   80103b00 <end_op>
80101834:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101837:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010183c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183f:	5b                   	pop    %ebx
80101840:	5e                   	pop    %esi
80101841:	5f                   	pop    %edi
80101842:	5d                   	pop    %ebp
80101843:	c3                   	ret    
80101844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80101848:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010184f:	45 4c 46 
80101852:	75 d2                	jne    80101826 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101854:	e8 67 69 00 00       	call   801081c0 <setupkvm>
80101859:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
8010185f:	85 c0                	test   %eax,%eax
80101861:	74 c3                	je     80101826 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101863:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010186a:	00 
8010186b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101871:	0f 84 b5 02 00 00    	je     80101b2c <exec+0x35c>
  sz = 0;
80101877:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010187e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101881:	31 ff                	xor    %edi,%edi
80101883:	e9 8e 00 00 00       	jmp    80101916 <exec+0x146>
80101888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010188f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101890:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101897:	75 6c                	jne    80101905 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101899:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010189f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801018a5:	0f 82 87 00 00 00    	jb     80101932 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801018ab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801018b1:	72 7f                	jb     80101932 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801018b3:	83 ec 04             	sub    $0x4,%esp
801018b6:	50                   	push   %eax
801018b7:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
801018bd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018c3:	e8 18 67 00 00       	call   80107fe0 <allocuvm>
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801018d1:	85 c0                	test   %eax,%eax
801018d3:	74 5d                	je     80101932 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
801018d5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018db:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018e0:	75 50                	jne    80101932 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801018e2:	83 ec 0c             	sub    $0xc,%esp
801018e5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801018eb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801018f1:	53                   	push   %ebx
801018f2:	50                   	push   %eax
801018f3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018f9:	e8 f2 65 00 00       	call   80107ef0 <loaduvm>
801018fe:	83 c4 20             	add    $0x20,%esp
80101901:	85 c0                	test   %eax,%eax
80101903:	78 2d                	js     80101932 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101905:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010190c:	83 c7 01             	add    $0x1,%edi
8010190f:	83 c6 20             	add    $0x20,%esi
80101912:	39 f8                	cmp    %edi,%eax
80101914:	7e 3a                	jle    80101950 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101916:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010191c:	6a 20                	push   $0x20
8010191e:	56                   	push   %esi
8010191f:	50                   	push   %eax
80101920:	53                   	push   %ebx
80101921:	e8 9a 0e 00 00       	call   801027c0 <readi>
80101926:	83 c4 10             	add    $0x10,%esp
80101929:	83 f8 20             	cmp    $0x20,%eax
8010192c:	0f 84 5e ff ff ff    	je     80101890 <exec+0xc0>
    freevm(pgdir);
80101932:	83 ec 0c             	sub    $0xc,%esp
80101935:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010193b:	e8 00 68 00 00       	call   80108140 <freevm>
  if(ip){
80101940:	83 c4 10             	add    $0x10,%esp
80101943:	e9 de fe ff ff       	jmp    80101826 <exec+0x56>
80101948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010194f:	90                   	nop
  sz = PGROUNDUP(sz);
80101950:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101956:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010195c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101962:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101968:	83 ec 0c             	sub    $0xc,%esp
8010196b:	53                   	push   %ebx
8010196c:	e8 cf 0d 00 00       	call   80102740 <iunlockput>
  end_op();
80101971:	e8 8a 21 00 00       	call   80103b00 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101976:	83 c4 0c             	add    $0xc,%esp
80101979:	56                   	push   %esi
8010197a:	57                   	push   %edi
8010197b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101981:	57                   	push   %edi
80101982:	e8 59 66 00 00       	call   80107fe0 <allocuvm>
80101987:	83 c4 10             	add    $0x10,%esp
8010198a:	89 c6                	mov    %eax,%esi
8010198c:	85 c0                	test   %eax,%eax
8010198e:	0f 84 94 00 00 00    	je     80101a28 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101994:	83 ec 08             	sub    $0x8,%esp
80101997:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010199d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010199f:	50                   	push   %eax
801019a0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
801019a1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801019a3:	e8 b8 68 00 00       	call   80108260 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
801019a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801019ab:	83 c4 10             	add    $0x10,%esp
801019ae:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801019b4:	8b 00                	mov    (%eax),%eax
801019b6:	85 c0                	test   %eax,%eax
801019b8:	0f 84 8b 00 00 00    	je     80101a49 <exec+0x279>
801019be:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
801019c4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801019ca:	eb 23                	jmp    801019ef <exec+0x21f>
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
801019d3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
801019da:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
801019dd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
801019e3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801019e6:	85 c0                	test   %eax,%eax
801019e8:	74 59                	je     80101a43 <exec+0x273>
    if(argc >= MAXARG)
801019ea:	83 ff 20             	cmp    $0x20,%edi
801019ed:	74 39                	je     80101a28 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019ef:	83 ec 0c             	sub    $0xc,%esp
801019f2:	50                   	push   %eax
801019f3:	e8 58 3d 00 00       	call   80105750 <strlen>
801019f8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801019fa:	58                   	pop    %eax
801019fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019fe:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101a01:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101a04:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101a07:	e8 44 3d 00 00       	call   80105750 <strlen>
80101a0c:	83 c0 01             	add    $0x1,%eax
80101a0f:	50                   	push   %eax
80101a10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a13:	ff 34 b8             	push   (%eax,%edi,4)
80101a16:	53                   	push   %ebx
80101a17:	56                   	push   %esi
80101a18:	e8 13 6a 00 00       	call   80108430 <copyout>
80101a1d:	83 c4 20             	add    $0x20,%esp
80101a20:	85 c0                	test   %eax,%eax
80101a22:	79 ac                	jns    801019d0 <exec+0x200>
80101a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a31:	e8 0a 67 00 00       	call   80108140 <freevm>
80101a36:	83 c4 10             	add    $0x10,%esp
  return -1;
80101a39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a3e:	e9 f9 fd ff ff       	jmp    8010183c <exec+0x6c>
80101a43:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a49:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101a50:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101a52:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101a59:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a5d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80101a5f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101a62:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101a68:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a6a:	50                   	push   %eax
80101a6b:	52                   	push   %edx
80101a6c:	53                   	push   %ebx
80101a6d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101a73:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a7a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a7d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a83:	e8 a8 69 00 00       	call   80108430 <copyout>
80101a88:	83 c4 10             	add    $0x10,%esp
80101a8b:	85 c0                	test   %eax,%eax
80101a8d:	78 99                	js     80101a28 <exec+0x258>
  for(last=s=path; *s; s++)
80101a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a92:	8b 55 08             	mov    0x8(%ebp),%edx
80101a95:	0f b6 00             	movzbl (%eax),%eax
80101a98:	84 c0                	test   %al,%al
80101a9a:	74 13                	je     80101aaf <exec+0x2df>
80101a9c:	89 d1                	mov    %edx,%ecx
80101a9e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101aa0:	83 c1 01             	add    $0x1,%ecx
80101aa3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101aa5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101aa8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80101aab:	84 c0                	test   %al,%al
80101aad:	75 f1                	jne    80101aa0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101aaf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101ab5:	83 ec 04             	sub    $0x4,%esp
80101ab8:	6a 18                	push   $0x18
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	52                   	push   %edx
80101abd:	05 d8 00 00 00       	add    $0xd8,%eax
80101ac2:	50                   	push   %eax
80101ac3:	e8 48 3c 00 00       	call   80105710 <safestrcpy>
  curproc->pgdir = pgdir;
80101ac8:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80101ace:	89 f8                	mov    %edi,%eax
80101ad0:	8b 7f 70             	mov    0x70(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80101ad3:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  curproc->sz = sz;
80101ad9:	89 70 6c             	mov    %esi,0x6c(%eax)
  curproc->pgdir = pgdir;
80101adc:	89 48 70             	mov    %ecx,0x70(%eax)
  curproc->tf->eip = elf.entry;  // main
80101adf:	89 c1                	mov    %eax,%ecx
80101ae1:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80101ae7:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101aea:	8b 81 84 00 00 00    	mov    0x84(%ecx),%eax
80101af0:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101af3:	89 0c 24             	mov    %ecx,(%esp)
80101af6:	e8 65 62 00 00       	call   80107d60 <switchuvm>
  freevm(oldpgdir);
80101afb:	89 3c 24             	mov    %edi,(%esp)
80101afe:	e8 3d 66 00 00       	call   80108140 <freevm>
  return 0;
80101b03:	83 c4 10             	add    $0x10,%esp
80101b06:	31 c0                	xor    %eax,%eax
80101b08:	e9 2f fd ff ff       	jmp    8010183c <exec+0x6c>
    end_op();
80101b0d:	e8 ee 1f 00 00       	call   80103b00 <end_op>
    cprintf("exec: fail\n");
80101b12:	83 ec 0c             	sub    $0xc,%esp
80101b15:	68 f0 85 10 80       	push   $0x801085f0
80101b1a:	e8 51 ef ff ff       	call   80100a70 <cprintf>
    return -1;
80101b1f:	83 c4 10             	add    $0x10,%esp
80101b22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b27:	e9 10 fd ff ff       	jmp    8010183c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101b2c:	be 00 20 00 00       	mov    $0x2000,%esi
80101b31:	31 ff                	xor    %edi,%edi
80101b33:	e9 30 fe ff ff       	jmp    80101968 <exec+0x198>
80101b38:	66 90                	xchg   %ax,%ax
80101b3a:	66 90                	xchg   %ax,%ax
80101b3c:	66 90                	xchg   %ax,%ax
80101b3e:	66 90                	xchg   %ax,%ax

80101b40 <fileinit>:
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	83 ec 10             	sub    $0x10,%esp
80101b46:	68 fc 85 10 80       	push   $0x801085fc
80101b4b:	68 00 16 11 80       	push   $0x80111600
80101b50:	e8 7b 37 00 00       	call   801052d0 <initlock>
80101b55:	83 c4 10             	add    $0x10,%esp
80101b58:	c9                   	leave  
80101b59:	c3                   	ret    
80101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b60 <filealloc>:
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	53                   	push   %ebx
80101b64:	bb 34 16 11 80       	mov    $0x80111634,%ebx
80101b69:	83 ec 10             	sub    $0x10,%esp
80101b6c:	68 00 16 11 80       	push   $0x80111600
80101b71:	e8 2a 39 00 00       	call   801054a0 <acquire>
80101b76:	83 c4 10             	add    $0x10,%esp
80101b79:	eb 10                	jmp    80101b8b <filealloc+0x2b>
80101b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b80:	83 c3 18             	add    $0x18,%ebx
80101b83:	81 fb 94 1f 11 80    	cmp    $0x80111f94,%ebx
80101b89:	74 25                	je     80101bb0 <filealloc+0x50>
80101b8b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b8e:	85 c0                	test   %eax,%eax
80101b90:	75 ee                	jne    80101b80 <filealloc+0x20>
80101b92:	83 ec 0c             	sub    $0xc,%esp
80101b95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80101b9c:	68 00 16 11 80       	push   $0x80111600
80101ba1:	e8 9a 38 00 00       	call   80105440 <release>
80101ba6:	89 d8                	mov    %ebx,%eax
80101ba8:	83 c4 10             	add    $0x10,%esp
80101bab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bae:	c9                   	leave  
80101baf:	c3                   	ret    
80101bb0:	83 ec 0c             	sub    $0xc,%esp
80101bb3:	31 db                	xor    %ebx,%ebx
80101bb5:	68 00 16 11 80       	push   $0x80111600
80101bba:	e8 81 38 00 00       	call   80105440 <release>
80101bbf:	89 d8                	mov    %ebx,%eax
80101bc1:	83 c4 10             	add    $0x10,%esp
80101bc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bc7:	c9                   	leave  
80101bc8:	c3                   	ret    
80101bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bd0 <filedup>:
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	53                   	push   %ebx
80101bd4:	83 ec 10             	sub    $0x10,%esp
80101bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bda:	68 00 16 11 80       	push   $0x80111600
80101bdf:	e8 bc 38 00 00       	call   801054a0 <acquire>
80101be4:	8b 43 04             	mov    0x4(%ebx),%eax
80101be7:	83 c4 10             	add    $0x10,%esp
80101bea:	85 c0                	test   %eax,%eax
80101bec:	7e 1a                	jle    80101c08 <filedup+0x38>
80101bee:	83 c0 01             	add    $0x1,%eax
80101bf1:	83 ec 0c             	sub    $0xc,%esp
80101bf4:	89 43 04             	mov    %eax,0x4(%ebx)
80101bf7:	68 00 16 11 80       	push   $0x80111600
80101bfc:	e8 3f 38 00 00       	call   80105440 <release>
80101c01:	89 d8                	mov    %ebx,%eax
80101c03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c06:	c9                   	leave  
80101c07:	c3                   	ret    
80101c08:	83 ec 0c             	sub    $0xc,%esp
80101c0b:	68 03 86 10 80       	push   $0x80108603
80101c10:	e8 db e8 ff ff       	call   801004f0 <panic>
80101c15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c1c:	00 
80101c1d:	8d 76 00             	lea    0x0(%esi),%esi

80101c20 <fileclose>:
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	83 ec 28             	sub    $0x28,%esp
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c2c:	68 00 16 11 80       	push   $0x80111600
80101c31:	e8 6a 38 00 00       	call   801054a0 <acquire>
80101c36:	8b 53 04             	mov    0x4(%ebx),%edx
80101c39:	83 c4 10             	add    $0x10,%esp
80101c3c:	85 d2                	test   %edx,%edx
80101c3e:	0f 8e a5 00 00 00    	jle    80101ce9 <fileclose+0xc9>
80101c44:	83 ea 01             	sub    $0x1,%edx
80101c47:	89 53 04             	mov    %edx,0x4(%ebx)
80101c4a:	75 44                	jne    80101c90 <fileclose+0x70>
80101c4c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80101c50:	83 ec 0c             	sub    $0xc,%esp
80101c53:	8b 3b                	mov    (%ebx),%edi
80101c55:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101c5b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101c5e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c61:	8b 43 10             	mov    0x10(%ebx),%eax
80101c64:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c67:	68 00 16 11 80       	push   $0x80111600
80101c6c:	e8 cf 37 00 00       	call   80105440 <release>
80101c71:	83 c4 10             	add    $0x10,%esp
80101c74:	83 ff 01             	cmp    $0x1,%edi
80101c77:	74 57                	je     80101cd0 <fileclose+0xb0>
80101c79:	83 ff 02             	cmp    $0x2,%edi
80101c7c:	74 2a                	je     80101ca8 <fileclose+0x88>
80101c7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c81:	5b                   	pop    %ebx
80101c82:	5e                   	pop    %esi
80101c83:	5f                   	pop    %edi
80101c84:	5d                   	pop    %ebp
80101c85:	c3                   	ret    
80101c86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c8d:	00 
80101c8e:	66 90                	xchg   %ax,%ax
80101c90:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
80101c97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9a:	5b                   	pop    %ebx
80101c9b:	5e                   	pop    %esi
80101c9c:	5f                   	pop    %edi
80101c9d:	5d                   	pop    %ebp
80101c9e:	e9 9d 37 00 00       	jmp    80105440 <release>
80101ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ca8:	e8 e3 1d 00 00       	call   80103a90 <begin_op>
80101cad:	83 ec 0c             	sub    $0xc,%esp
80101cb0:	ff 75 e0             	push   -0x20(%ebp)
80101cb3:	e8 28 09 00 00       	call   801025e0 <iput>
80101cb8:	83 c4 10             	add    $0x10,%esp
80101cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cbe:	5b                   	pop    %ebx
80101cbf:	5e                   	pop    %esi
80101cc0:	5f                   	pop    %edi
80101cc1:	5d                   	pop    %ebp
80101cc2:	e9 39 1e 00 00       	jmp    80103b00 <end_op>
80101cc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cce:	00 
80101ccf:	90                   	nop
80101cd0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101cd4:	83 ec 08             	sub    $0x8,%esp
80101cd7:	53                   	push   %ebx
80101cd8:	56                   	push   %esi
80101cd9:	e8 72 25 00 00       	call   80104250 <pipeclose>
80101cde:	83 c4 10             	add    $0x10,%esp
80101ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce4:	5b                   	pop    %ebx
80101ce5:	5e                   	pop    %esi
80101ce6:	5f                   	pop    %edi
80101ce7:	5d                   	pop    %ebp
80101ce8:	c3                   	ret    
80101ce9:	83 ec 0c             	sub    $0xc,%esp
80101cec:	68 0b 86 10 80       	push   $0x8010860b
80101cf1:	e8 fa e7 ff ff       	call   801004f0 <panic>
80101cf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cfd:	00 
80101cfe:	66 90                	xchg   %ax,%ax

80101d00 <filestat>:
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	53                   	push   %ebx
80101d04:	83 ec 04             	sub    $0x4,%esp
80101d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101d0d:	75 31                	jne    80101d40 <filestat+0x40>
80101d0f:	83 ec 0c             	sub    $0xc,%esp
80101d12:	ff 73 10             	push   0x10(%ebx)
80101d15:	e8 96 07 00 00       	call   801024b0 <ilock>
80101d1a:	58                   	pop    %eax
80101d1b:	5a                   	pop    %edx
80101d1c:	ff 75 0c             	push   0xc(%ebp)
80101d1f:	ff 73 10             	push   0x10(%ebx)
80101d22:	e8 69 0a 00 00       	call   80102790 <stati>
80101d27:	59                   	pop    %ecx
80101d28:	ff 73 10             	push   0x10(%ebx)
80101d2b:	e8 60 08 00 00       	call   80102590 <iunlock>
80101d30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d33:	83 c4 10             	add    $0x10,%esp
80101d36:	31 c0                	xor    %eax,%eax
80101d38:	c9                   	leave  
80101d39:	c3                   	ret    
80101d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d48:	c9                   	leave  
80101d49:	c3                   	ret    
80101d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d50 <fileread>:
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	56                   	push   %esi
80101d55:	53                   	push   %ebx
80101d56:	83 ec 0c             	sub    $0xc,%esp
80101d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d5f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101d62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d66:	74 60                	je     80101dc8 <fileread+0x78>
80101d68:	8b 03                	mov    (%ebx),%eax
80101d6a:	83 f8 01             	cmp    $0x1,%eax
80101d6d:	74 41                	je     80101db0 <fileread+0x60>
80101d6f:	83 f8 02             	cmp    $0x2,%eax
80101d72:	75 5b                	jne    80101dcf <fileread+0x7f>
80101d74:	83 ec 0c             	sub    $0xc,%esp
80101d77:	ff 73 10             	push   0x10(%ebx)
80101d7a:	e8 31 07 00 00       	call   801024b0 <ilock>
80101d7f:	57                   	push   %edi
80101d80:	ff 73 14             	push   0x14(%ebx)
80101d83:	56                   	push   %esi
80101d84:	ff 73 10             	push   0x10(%ebx)
80101d87:	e8 34 0a 00 00       	call   801027c0 <readi>
80101d8c:	83 c4 20             	add    $0x20,%esp
80101d8f:	89 c6                	mov    %eax,%esi
80101d91:	85 c0                	test   %eax,%eax
80101d93:	7e 03                	jle    80101d98 <fileread+0x48>
80101d95:	01 43 14             	add    %eax,0x14(%ebx)
80101d98:	83 ec 0c             	sub    $0xc,%esp
80101d9b:	ff 73 10             	push   0x10(%ebx)
80101d9e:	e8 ed 07 00 00       	call   80102590 <iunlock>
80101da3:	83 c4 10             	add    $0x10,%esp
80101da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da9:	89 f0                	mov    %esi,%eax
80101dab:	5b                   	pop    %ebx
80101dac:	5e                   	pop    %esi
80101dad:	5f                   	pop    %edi
80101dae:	5d                   	pop    %ebp
80101daf:	c3                   	ret    
80101db0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101db3:	89 45 08             	mov    %eax,0x8(%ebp)
80101db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db9:	5b                   	pop    %ebx
80101dba:	5e                   	pop    %esi
80101dbb:	5f                   	pop    %edi
80101dbc:	5d                   	pop    %ebp
80101dbd:	e9 2e 26 00 00       	jmp    801043f0 <piperead>
80101dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101dc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dcd:	eb d7                	jmp    80101da6 <fileread+0x56>
80101dcf:	83 ec 0c             	sub    $0xc,%esp
80101dd2:	68 15 86 10 80       	push   $0x80108615
80101dd7:	e8 14 e7 ff ff       	call   801004f0 <panic>
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101de0 <filewrite>:
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	57                   	push   %edi
80101de4:	56                   	push   %esi
80101de5:	53                   	push   %ebx
80101de6:	83 ec 1c             	sub    $0x1c,%esp
80101de9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dec:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101def:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101df2:	8b 45 10             	mov    0x10(%ebp),%eax
80101df5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80101df9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101dfc:	0f 84 bb 00 00 00    	je     80101ebd <filewrite+0xdd>
80101e02:	8b 03                	mov    (%ebx),%eax
80101e04:	83 f8 01             	cmp    $0x1,%eax
80101e07:	0f 84 bf 00 00 00    	je     80101ecc <filewrite+0xec>
80101e0d:	83 f8 02             	cmp    $0x2,%eax
80101e10:	0f 85 c8 00 00 00    	jne    80101ede <filewrite+0xfe>
80101e16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e19:	31 f6                	xor    %esi,%esi
80101e1b:	85 c0                	test   %eax,%eax
80101e1d:	7f 30                	jg     80101e4f <filewrite+0x6f>
80101e1f:	e9 94 00 00 00       	jmp    80101eb8 <filewrite+0xd8>
80101e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e28:	01 43 14             	add    %eax,0x14(%ebx)
80101e2b:	83 ec 0c             	sub    $0xc,%esp
80101e2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e31:	ff 73 10             	push   0x10(%ebx)
80101e34:	e8 57 07 00 00       	call   80102590 <iunlock>
80101e39:	e8 c2 1c 00 00       	call   80103b00 <end_op>
80101e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e41:	83 c4 10             	add    $0x10,%esp
80101e44:	39 c7                	cmp    %eax,%edi
80101e46:	75 5c                	jne    80101ea4 <filewrite+0xc4>
80101e48:	01 fe                	add    %edi,%esi
80101e4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101e4d:	7e 69                	jle    80101eb8 <filewrite+0xd8>
80101e4f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e52:	b8 00 06 00 00       	mov    $0x600,%eax
80101e57:	29 f7                	sub    %esi,%edi
80101e59:	39 c7                	cmp    %eax,%edi
80101e5b:	0f 4f f8             	cmovg  %eax,%edi
80101e5e:	e8 2d 1c 00 00       	call   80103a90 <begin_op>
80101e63:	83 ec 0c             	sub    $0xc,%esp
80101e66:	ff 73 10             	push   0x10(%ebx)
80101e69:	e8 42 06 00 00       	call   801024b0 <ilock>
80101e6e:	57                   	push   %edi
80101e6f:	ff 73 14             	push   0x14(%ebx)
80101e72:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e75:	01 f0                	add    %esi,%eax
80101e77:	50                   	push   %eax
80101e78:	ff 73 10             	push   0x10(%ebx)
80101e7b:	e8 40 0a 00 00       	call   801028c0 <writei>
80101e80:	83 c4 20             	add    $0x20,%esp
80101e83:	85 c0                	test   %eax,%eax
80101e85:	7f a1                	jg     80101e28 <filewrite+0x48>
80101e87:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e8a:	83 ec 0c             	sub    $0xc,%esp
80101e8d:	ff 73 10             	push   0x10(%ebx)
80101e90:	e8 fb 06 00 00       	call   80102590 <iunlock>
80101e95:	e8 66 1c 00 00       	call   80103b00 <end_op>
80101e9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e9d:	83 c4 10             	add    $0x10,%esp
80101ea0:	85 c0                	test   %eax,%eax
80101ea2:	75 14                	jne    80101eb8 <filewrite+0xd8>
80101ea4:	83 ec 0c             	sub    $0xc,%esp
80101ea7:	68 1e 86 10 80       	push   $0x8010861e
80101eac:	e8 3f e6 ff ff       	call   801004f0 <panic>
80101eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101ebb:	74 05                	je     80101ec2 <filewrite+0xe2>
80101ebd:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec5:	89 f0                	mov    %esi,%eax
80101ec7:	5b                   	pop    %ebx
80101ec8:	5e                   	pop    %esi
80101ec9:	5f                   	pop    %edi
80101eca:	5d                   	pop    %ebp
80101ecb:	c3                   	ret    
80101ecc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ecf:	89 45 08             	mov    %eax,0x8(%ebp)
80101ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed5:	5b                   	pop    %ebx
80101ed6:	5e                   	pop    %esi
80101ed7:	5f                   	pop    %edi
80101ed8:	5d                   	pop    %ebp
80101ed9:	e9 12 24 00 00       	jmp    801042f0 <pipewrite>
80101ede:	83 ec 0c             	sub    $0xc,%esp
80101ee1:	68 24 86 10 80       	push   $0x80108624
80101ee6:	e8 05 e6 ff ff       	call   801004f0 <panic>
80101eeb:	66 90                	xchg   %ax,%ax
80101eed:	66 90                	xchg   %ax,%ax
80101eef:	90                   	nop

80101ef0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101ef3:	89 d0                	mov    %edx,%eax
80101ef5:	c1 e8 0c             	shr    $0xc,%eax
80101ef8:	03 05 6c 3c 11 80    	add    0x80113c6c,%eax
{
80101efe:	89 e5                	mov    %esp,%ebp
80101f00:	56                   	push   %esi
80101f01:	53                   	push   %ebx
80101f02:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101f04:	83 ec 08             	sub    $0x8,%esp
80101f07:	50                   	push   %eax
80101f08:	51                   	push   %ecx
80101f09:	e8 c2 e1 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101f0e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101f10:	c1 fb 03             	sar    $0x3,%ebx
80101f13:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101f16:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101f18:	83 e1 07             	and    $0x7,%ecx
80101f1b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101f20:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101f26:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101f28:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101f2d:	85 c1                	test   %eax,%ecx
80101f2f:	74 23                	je     80101f54 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101f31:	f7 d0                	not    %eax
  log_write(bp);
80101f33:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101f36:	21 c8                	and    %ecx,%eax
80101f38:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101f3c:	56                   	push   %esi
80101f3d:	e8 2e 1d 00 00       	call   80103c70 <log_write>
  brelse(bp);
80101f42:	89 34 24             	mov    %esi,(%esp)
80101f45:	e8 a6 e2 ff ff       	call   801001f0 <brelse>
}
80101f4a:	83 c4 10             	add    $0x10,%esp
80101f4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f50:	5b                   	pop    %ebx
80101f51:	5e                   	pop    %esi
80101f52:	5d                   	pop    %ebp
80101f53:	c3                   	ret    
    panic("freeing free block");
80101f54:	83 ec 0c             	sub    $0xc,%esp
80101f57:	68 2e 86 10 80       	push   $0x8010862e
80101f5c:	e8 8f e5 ff ff       	call   801004f0 <panic>
80101f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f6f:	90                   	nop

80101f70 <balloc>:
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	57                   	push   %edi
80101f74:	56                   	push   %esi
80101f75:	53                   	push   %ebx
80101f76:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101f79:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
{
80101f7f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101f82:	85 c9                	test   %ecx,%ecx
80101f84:	0f 84 87 00 00 00    	je     80102011 <balloc+0xa1>
80101f8a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101f91:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101f94:	83 ec 08             	sub    $0x8,%esp
80101f97:	89 f0                	mov    %esi,%eax
80101f99:	c1 f8 0c             	sar    $0xc,%eax
80101f9c:	03 05 6c 3c 11 80    	add    0x80113c6c,%eax
80101fa2:	50                   	push   %eax
80101fa3:	ff 75 d8             	push   -0x28(%ebp)
80101fa6:	e8 25 e1 ff ff       	call   801000d0 <bread>
80101fab:	83 c4 10             	add    $0x10,%esp
80101fae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101fb1:	a1 54 3c 11 80       	mov    0x80113c54,%eax
80101fb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101fb9:	31 c0                	xor    %eax,%eax
80101fbb:	eb 2f                	jmp    80101fec <balloc+0x7c>
80101fbd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101fc0:	89 c1                	mov    %eax,%ecx
80101fc2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101fc7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101fca:	83 e1 07             	and    $0x7,%ecx
80101fcd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101fcf:	89 c1                	mov    %eax,%ecx
80101fd1:	c1 f9 03             	sar    $0x3,%ecx
80101fd4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101fd9:	89 fa                	mov    %edi,%edx
80101fdb:	85 df                	test   %ebx,%edi
80101fdd:	74 41                	je     80102020 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101fdf:	83 c0 01             	add    $0x1,%eax
80101fe2:	83 c6 01             	add    $0x1,%esi
80101fe5:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101fea:	74 05                	je     80101ff1 <balloc+0x81>
80101fec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101fef:	77 cf                	ja     80101fc0 <balloc+0x50>
    brelse(bp);
80101ff1:	83 ec 0c             	sub    $0xc,%esp
80101ff4:	ff 75 e4             	push   -0x1c(%ebp)
80101ff7:	e8 f4 e1 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101ffc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80102003:	83 c4 10             	add    $0x10,%esp
80102006:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102009:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
8010200f:	77 80                	ja     80101f91 <balloc+0x21>
  panic("balloc: out of blocks");
80102011:	83 ec 0c             	sub    $0xc,%esp
80102014:	68 41 86 10 80       	push   $0x80108641
80102019:	e8 d2 e4 ff ff       	call   801004f0 <panic>
8010201e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80102020:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80102023:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80102026:	09 da                	or     %ebx,%edx
80102028:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010202c:	57                   	push   %edi
8010202d:	e8 3e 1c 00 00       	call   80103c70 <log_write>
        brelse(bp);
80102032:	89 3c 24             	mov    %edi,(%esp)
80102035:	e8 b6 e1 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010203a:	58                   	pop    %eax
8010203b:	5a                   	pop    %edx
8010203c:	56                   	push   %esi
8010203d:	ff 75 d8             	push   -0x28(%ebp)
80102040:	e8 8b e0 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80102045:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80102048:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010204a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010204d:	68 00 02 00 00       	push   $0x200
80102052:	6a 00                	push   $0x0
80102054:	50                   	push   %eax
80102055:	e8 06 35 00 00       	call   80105560 <memset>
  log_write(bp);
8010205a:	89 1c 24             	mov    %ebx,(%esp)
8010205d:	e8 0e 1c 00 00       	call   80103c70 <log_write>
  brelse(bp);
80102062:	89 1c 24             	mov    %ebx,(%esp)
80102065:	e8 86 e1 ff ff       	call   801001f0 <brelse>
}
8010206a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010206d:	89 f0                	mov    %esi,%eax
8010206f:	5b                   	pop    %ebx
80102070:	5e                   	pop    %esi
80102071:	5f                   	pop    %edi
80102072:	5d                   	pop    %ebp
80102073:	c3                   	ret    
80102074:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010207b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010207f:	90                   	nop

80102080 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	89 c7                	mov    %eax,%edi
80102086:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80102087:	31 f6                	xor    %esi,%esi
{
80102089:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010208a:	bb 34 20 11 80       	mov    $0x80112034,%ebx
{
8010208f:	83 ec 28             	sub    $0x28,%esp
80102092:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102095:	68 00 20 11 80       	push   $0x80112000
8010209a:	e8 01 34 00 00       	call   801054a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010209f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801020a2:	83 c4 10             	add    $0x10,%esp
801020a5:	eb 1b                	jmp    801020c2 <iget+0x42>
801020a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020ae:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801020b0:	39 3b                	cmp    %edi,(%ebx)
801020b2:	74 6c                	je     80102120 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801020b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020ba:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801020c0:	73 26                	jae    801020e8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801020c2:	8b 43 08             	mov    0x8(%ebx),%eax
801020c5:	85 c0                	test   %eax,%eax
801020c7:	7f e7                	jg     801020b0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801020c9:	85 f6                	test   %esi,%esi
801020cb:	75 e7                	jne    801020b4 <iget+0x34>
801020cd:	85 c0                	test   %eax,%eax
801020cf:	75 76                	jne    80102147 <iget+0xc7>
801020d1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801020d3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020d9:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801020df:	72 e1                	jb     801020c2 <iget+0x42>
801020e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801020e8:	85 f6                	test   %esi,%esi
801020ea:	74 79                	je     80102165 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801020ec:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801020ef:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801020f1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801020f4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801020fb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80102102:	68 00 20 11 80       	push   $0x80112000
80102107:	e8 34 33 00 00       	call   80105440 <release>

  return ip;
8010210c:	83 c4 10             	add    $0x10,%esp
}
8010210f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102112:	89 f0                	mov    %esi,%eax
80102114:	5b                   	pop    %ebx
80102115:	5e                   	pop    %esi
80102116:	5f                   	pop    %edi
80102117:	5d                   	pop    %ebp
80102118:	c3                   	ret    
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102120:	39 53 04             	cmp    %edx,0x4(%ebx)
80102123:	75 8f                	jne    801020b4 <iget+0x34>
      release(&icache.lock);
80102125:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80102128:	83 c0 01             	add    $0x1,%eax
      return ip;
8010212b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010212d:	68 00 20 11 80       	push   $0x80112000
      ip->ref++;
80102132:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102135:	e8 06 33 00 00       	call   80105440 <release>
      return ip;
8010213a:	83 c4 10             	add    $0x10,%esp
}
8010213d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102140:	89 f0                	mov    %esi,%eax
80102142:	5b                   	pop    %ebx
80102143:	5e                   	pop    %esi
80102144:	5f                   	pop    %edi
80102145:	5d                   	pop    %ebp
80102146:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102147:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010214d:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80102153:	73 10                	jae    80102165 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102155:	8b 43 08             	mov    0x8(%ebx),%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 8f 50 ff ff ff    	jg     801020b0 <iget+0x30>
80102160:	e9 68 ff ff ff       	jmp    801020cd <iget+0x4d>
    panic("iget: no inodes");
80102165:	83 ec 0c             	sub    $0xc,%esp
80102168:	68 57 86 10 80       	push   $0x80108657
8010216d:	e8 7e e3 ff ff       	call   801004f0 <panic>
80102172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102180 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	57                   	push   %edi
80102184:	56                   	push   %esi
80102185:	89 c6                	mov    %eax,%esi
80102187:	53                   	push   %ebx
80102188:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010218b:	83 fa 0b             	cmp    $0xb,%edx
8010218e:	0f 86 8c 00 00 00    	jbe    80102220 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102194:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102197:	83 fb 7f             	cmp    $0x7f,%ebx
8010219a:	0f 87 a2 00 00 00    	ja     80102242 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801021a0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801021a6:	85 c0                	test   %eax,%eax
801021a8:	74 5e                	je     80102208 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801021aa:	83 ec 08             	sub    $0x8,%esp
801021ad:	50                   	push   %eax
801021ae:	ff 36                	push   (%esi)
801021b0:	e8 1b df ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801021b5:	83 c4 10             	add    $0x10,%esp
801021b8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801021bc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801021be:	8b 3b                	mov    (%ebx),%edi
801021c0:	85 ff                	test   %edi,%edi
801021c2:	74 1c                	je     801021e0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801021c4:	83 ec 0c             	sub    $0xc,%esp
801021c7:	52                   	push   %edx
801021c8:	e8 23 e0 ff ff       	call   801001f0 <brelse>
801021cd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801021d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021d3:	89 f8                	mov    %edi,%eax
801021d5:	5b                   	pop    %ebx
801021d6:	5e                   	pop    %esi
801021d7:	5f                   	pop    %edi
801021d8:	5d                   	pop    %ebp
801021d9:	c3                   	ret    
801021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801021e3:	8b 06                	mov    (%esi),%eax
801021e5:	e8 86 fd ff ff       	call   80101f70 <balloc>
      log_write(bp);
801021ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021ed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801021f0:	89 03                	mov    %eax,(%ebx)
801021f2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801021f4:	52                   	push   %edx
801021f5:	e8 76 1a 00 00       	call   80103c70 <log_write>
801021fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021fd:	83 c4 10             	add    $0x10,%esp
80102200:	eb c2                	jmp    801021c4 <bmap+0x44>
80102202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102208:	8b 06                	mov    (%esi),%eax
8010220a:	e8 61 fd ff ff       	call   80101f70 <balloc>
8010220f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102215:	eb 93                	jmp    801021aa <bmap+0x2a>
80102217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010221e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80102220:	8d 5a 14             	lea    0x14(%edx),%ebx
80102223:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102227:	85 ff                	test   %edi,%edi
80102229:	75 a5                	jne    801021d0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010222b:	8b 00                	mov    (%eax),%eax
8010222d:	e8 3e fd ff ff       	call   80101f70 <balloc>
80102232:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102236:	89 c7                	mov    %eax,%edi
}
80102238:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010223b:	5b                   	pop    %ebx
8010223c:	89 f8                	mov    %edi,%eax
8010223e:	5e                   	pop    %esi
8010223f:	5f                   	pop    %edi
80102240:	5d                   	pop    %ebp
80102241:	c3                   	ret    
  panic("bmap: out of range");
80102242:	83 ec 0c             	sub    $0xc,%esp
80102245:	68 67 86 10 80       	push   $0x80108667
8010224a:	e8 a1 e2 ff ff       	call   801004f0 <panic>
8010224f:	90                   	nop

80102250 <readsb>:
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	56                   	push   %esi
80102254:	53                   	push   %ebx
80102255:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102258:	83 ec 08             	sub    $0x8,%esp
8010225b:	6a 01                	push   $0x1
8010225d:	ff 75 08             	push   0x8(%ebp)
80102260:	e8 6b de ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102265:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102268:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010226a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010226d:	6a 1c                	push   $0x1c
8010226f:	50                   	push   %eax
80102270:	56                   	push   %esi
80102271:	e8 7a 33 00 00       	call   801055f0 <memmove>
  brelse(bp);
80102276:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102279:	83 c4 10             	add    $0x10,%esp
}
8010227c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010227f:	5b                   	pop    %ebx
80102280:	5e                   	pop    %esi
80102281:	5d                   	pop    %ebp
  brelse(bp);
80102282:	e9 69 df ff ff       	jmp    801001f0 <brelse>
80102287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010228e:	66 90                	xchg   %ax,%ax

80102290 <iinit>:
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	53                   	push   %ebx
80102294:	bb 40 20 11 80       	mov    $0x80112040,%ebx
80102299:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010229c:	68 7a 86 10 80       	push   $0x8010867a
801022a1:	68 00 20 11 80       	push   $0x80112000
801022a6:	e8 25 30 00 00       	call   801052d0 <initlock>
  for(i = 0; i < NINODE; i++) {
801022ab:	83 c4 10             	add    $0x10,%esp
801022ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801022b0:	83 ec 08             	sub    $0x8,%esp
801022b3:	68 81 86 10 80       	push   $0x80108681
801022b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801022b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801022bf:	e8 dc 2e 00 00       	call   801051a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801022c4:	83 c4 10             	add    $0x10,%esp
801022c7:	81 fb 60 3c 11 80    	cmp    $0x80113c60,%ebx
801022cd:	75 e1                	jne    801022b0 <iinit+0x20>
  bp = bread(dev, 1);
801022cf:	83 ec 08             	sub    $0x8,%esp
801022d2:	6a 01                	push   $0x1
801022d4:	ff 75 08             	push   0x8(%ebp)
801022d7:	e8 f4 dd ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801022dc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801022df:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801022e1:	8d 40 5c             	lea    0x5c(%eax),%eax
801022e4:	6a 1c                	push   $0x1c
801022e6:	50                   	push   %eax
801022e7:	68 54 3c 11 80       	push   $0x80113c54
801022ec:	e8 ff 32 00 00       	call   801055f0 <memmove>
  brelse(bp);
801022f1:	89 1c 24             	mov    %ebx,(%esp)
801022f4:	e8 f7 de ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801022f9:	ff 35 6c 3c 11 80    	push   0x80113c6c
801022ff:	ff 35 68 3c 11 80    	push   0x80113c68
80102305:	ff 35 64 3c 11 80    	push   0x80113c64
8010230b:	ff 35 60 3c 11 80    	push   0x80113c60
80102311:	ff 35 5c 3c 11 80    	push   0x80113c5c
80102317:	ff 35 58 3c 11 80    	push   0x80113c58
8010231d:	ff 35 54 3c 11 80    	push   0x80113c54
80102323:	68 e4 86 10 80       	push   $0x801086e4
80102328:	e8 43 e7 ff ff       	call   80100a70 <cprintf>
}
8010232d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102330:	83 c4 30             	add    $0x30,%esp
80102333:	c9                   	leave  
80102334:	c3                   	ret    
80102335:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010233c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102340 <ialloc>:
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	57                   	push   %edi
80102344:	56                   	push   %esi
80102345:	53                   	push   %ebx
80102346:	83 ec 1c             	sub    $0x1c,%esp
80102349:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010234c:	83 3d 5c 3c 11 80 01 	cmpl   $0x1,0x80113c5c
{
80102353:	8b 75 08             	mov    0x8(%ebp),%esi
80102356:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102359:	0f 86 91 00 00 00    	jbe    801023f0 <ialloc+0xb0>
8010235f:	bf 01 00 00 00       	mov    $0x1,%edi
80102364:	eb 21                	jmp    80102387 <ialloc+0x47>
80102366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010236d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102370:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102373:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102376:	53                   	push   %ebx
80102377:	e8 74 de ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010237c:	83 c4 10             	add    $0x10,%esp
8010237f:	3b 3d 5c 3c 11 80    	cmp    0x80113c5c,%edi
80102385:	73 69                	jae    801023f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102387:	89 f8                	mov    %edi,%eax
80102389:	83 ec 08             	sub    $0x8,%esp
8010238c:	c1 e8 03             	shr    $0x3,%eax
8010238f:	03 05 68 3c 11 80    	add    0x80113c68,%eax
80102395:	50                   	push   %eax
80102396:	56                   	push   %esi
80102397:	e8 34 dd ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010239c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010239f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801023a1:	89 f8                	mov    %edi,%eax
801023a3:	83 e0 07             	and    $0x7,%eax
801023a6:	c1 e0 06             	shl    $0x6,%eax
801023a9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801023ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801023b1:	75 bd                	jne    80102370 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801023b3:	83 ec 04             	sub    $0x4,%esp
801023b6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801023b9:	6a 40                	push   $0x40
801023bb:	6a 00                	push   $0x0
801023bd:	51                   	push   %ecx
801023be:	e8 9d 31 00 00       	call   80105560 <memset>
      dip->type = type;
801023c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801023c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801023ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801023cd:	89 1c 24             	mov    %ebx,(%esp)
801023d0:	e8 9b 18 00 00       	call   80103c70 <log_write>
      brelse(bp);
801023d5:	89 1c 24             	mov    %ebx,(%esp)
801023d8:	e8 13 de ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801023dd:	83 c4 10             	add    $0x10,%esp
}
801023e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801023e3:	89 fa                	mov    %edi,%edx
}
801023e5:	5b                   	pop    %ebx
      return iget(dev, inum);
801023e6:	89 f0                	mov    %esi,%eax
}
801023e8:	5e                   	pop    %esi
801023e9:	5f                   	pop    %edi
801023ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801023eb:	e9 90 fc ff ff       	jmp    80102080 <iget>
  panic("ialloc: no inodes");
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	68 87 86 10 80       	push   $0x80108687
801023f8:	e8 f3 e0 ff ff       	call   801004f0 <panic>
801023fd:	8d 76 00             	lea    0x0(%esi),%esi

80102400 <iupdate>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
80102405:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102408:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010240b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010240e:	83 ec 08             	sub    $0x8,%esp
80102411:	c1 e8 03             	shr    $0x3,%eax
80102414:	03 05 68 3c 11 80    	add    0x80113c68,%eax
8010241a:	50                   	push   %eax
8010241b:	ff 73 a4             	push   -0x5c(%ebx)
8010241e:	e8 ad dc ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102423:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102427:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010242a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010242c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010242f:	83 e0 07             	and    $0x7,%eax
80102432:	c1 e0 06             	shl    $0x6,%eax
80102435:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102439:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010243c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102440:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102443:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102447:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010244b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010244f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102453:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102457:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010245a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010245d:	6a 34                	push   $0x34
8010245f:	53                   	push   %ebx
80102460:	50                   	push   %eax
80102461:	e8 8a 31 00 00       	call   801055f0 <memmove>
  log_write(bp);
80102466:	89 34 24             	mov    %esi,(%esp)
80102469:	e8 02 18 00 00       	call   80103c70 <log_write>
  brelse(bp);
8010246e:	89 75 08             	mov    %esi,0x8(%ebp)
80102471:	83 c4 10             	add    $0x10,%esp
}
80102474:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102477:	5b                   	pop    %ebx
80102478:	5e                   	pop    %esi
80102479:	5d                   	pop    %ebp
  brelse(bp);
8010247a:	e9 71 dd ff ff       	jmp    801001f0 <brelse>
8010247f:	90                   	nop

80102480 <idup>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 10             	sub    $0x10,%esp
80102487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010248a:	68 00 20 11 80       	push   $0x80112000
8010248f:	e8 0c 30 00 00       	call   801054a0 <acquire>
  ip->ref++;
80102494:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102498:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
8010249f:	e8 9c 2f 00 00       	call   80105440 <release>
}
801024a4:	89 d8                	mov    %ebx,%eax
801024a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024a9:	c9                   	leave  
801024aa:	c3                   	ret    
801024ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024af:	90                   	nop

801024b0 <ilock>:
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	56                   	push   %esi
801024b4:	53                   	push   %ebx
801024b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801024b8:	85 db                	test   %ebx,%ebx
801024ba:	0f 84 b7 00 00 00    	je     80102577 <ilock+0xc7>
801024c0:	8b 53 08             	mov    0x8(%ebx),%edx
801024c3:	85 d2                	test   %edx,%edx
801024c5:	0f 8e ac 00 00 00    	jle    80102577 <ilock+0xc7>
  acquiresleep(&ip->lock);
801024cb:	83 ec 0c             	sub    $0xc,%esp
801024ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801024d1:	50                   	push   %eax
801024d2:	e8 09 2d 00 00       	call   801051e0 <acquiresleep>
  if(ip->valid == 0){
801024d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801024da:	83 c4 10             	add    $0x10,%esp
801024dd:	85 c0                	test   %eax,%eax
801024df:	74 0f                	je     801024f0 <ilock+0x40>
}
801024e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e4:	5b                   	pop    %ebx
801024e5:	5e                   	pop    %esi
801024e6:	5d                   	pop    %ebp
801024e7:	c3                   	ret    
801024e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024ef:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024f0:	8b 43 04             	mov    0x4(%ebx),%eax
801024f3:	83 ec 08             	sub    $0x8,%esp
801024f6:	c1 e8 03             	shr    $0x3,%eax
801024f9:	03 05 68 3c 11 80    	add    0x80113c68,%eax
801024ff:	50                   	push   %eax
80102500:	ff 33                	push   (%ebx)
80102502:	e8 c9 db ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102507:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010250a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010250c:	8b 43 04             	mov    0x4(%ebx),%eax
8010250f:	83 e0 07             	and    $0x7,%eax
80102512:	c1 e0 06             	shl    $0x6,%eax
80102515:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102519:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010251c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010251f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102523:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102527:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010252b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010252f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102533:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102537:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010253b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010253e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102541:	6a 34                	push   $0x34
80102543:	50                   	push   %eax
80102544:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102547:	50                   	push   %eax
80102548:	e8 a3 30 00 00       	call   801055f0 <memmove>
    brelse(bp);
8010254d:	89 34 24             	mov    %esi,(%esp)
80102550:	e8 9b dc ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102555:	83 c4 10             	add    $0x10,%esp
80102558:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010255d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102564:	0f 85 77 ff ff ff    	jne    801024e1 <ilock+0x31>
      panic("ilock: no type");
8010256a:	83 ec 0c             	sub    $0xc,%esp
8010256d:	68 9f 86 10 80       	push   $0x8010869f
80102572:	e8 79 df ff ff       	call   801004f0 <panic>
    panic("ilock");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 99 86 10 80       	push   $0x80108699
8010257f:	e8 6c df ff ff       	call   801004f0 <panic>
80102584:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010258f:	90                   	nop

80102590 <iunlock>:
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	56                   	push   %esi
80102594:	53                   	push   %ebx
80102595:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102598:	85 db                	test   %ebx,%ebx
8010259a:	74 28                	je     801025c4 <iunlock+0x34>
8010259c:	83 ec 0c             	sub    $0xc,%esp
8010259f:	8d 73 0c             	lea    0xc(%ebx),%esi
801025a2:	56                   	push   %esi
801025a3:	e8 d8 2c 00 00       	call   80105280 <holdingsleep>
801025a8:	83 c4 10             	add    $0x10,%esp
801025ab:	85 c0                	test   %eax,%eax
801025ad:	74 15                	je     801025c4 <iunlock+0x34>
801025af:	8b 43 08             	mov    0x8(%ebx),%eax
801025b2:	85 c0                	test   %eax,%eax
801025b4:	7e 0e                	jle    801025c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801025b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801025b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025bc:	5b                   	pop    %ebx
801025bd:	5e                   	pop    %esi
801025be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801025bf:	e9 7c 2c 00 00       	jmp    80105240 <releasesleep>
    panic("iunlock");
801025c4:	83 ec 0c             	sub    $0xc,%esp
801025c7:	68 ae 86 10 80       	push   $0x801086ae
801025cc:	e8 1f df ff ff       	call   801004f0 <panic>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025df:	90                   	nop

801025e0 <iput>:
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	57                   	push   %edi
801025e4:	56                   	push   %esi
801025e5:	53                   	push   %ebx
801025e6:	83 ec 28             	sub    $0x28,%esp
801025e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801025ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801025ef:	57                   	push   %edi
801025f0:	e8 eb 2b 00 00       	call   801051e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801025f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801025f8:	83 c4 10             	add    $0x10,%esp
801025fb:	85 d2                	test   %edx,%edx
801025fd:	74 07                	je     80102606 <iput+0x26>
801025ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102604:	74 32                	je     80102638 <iput+0x58>
  releasesleep(&ip->lock);
80102606:	83 ec 0c             	sub    $0xc,%esp
80102609:	57                   	push   %edi
8010260a:	e8 31 2c 00 00       	call   80105240 <releasesleep>
  acquire(&icache.lock);
8010260f:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
80102616:	e8 85 2e 00 00       	call   801054a0 <acquire>
  ip->ref--;
8010261b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010261f:	83 c4 10             	add    $0x10,%esp
80102622:	c7 45 08 00 20 11 80 	movl   $0x80112000,0x8(%ebp)
}
80102629:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010262c:	5b                   	pop    %ebx
8010262d:	5e                   	pop    %esi
8010262e:	5f                   	pop    %edi
8010262f:	5d                   	pop    %ebp
  release(&icache.lock);
80102630:	e9 0b 2e 00 00       	jmp    80105440 <release>
80102635:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102638:	83 ec 0c             	sub    $0xc,%esp
8010263b:	68 00 20 11 80       	push   $0x80112000
80102640:	e8 5b 2e 00 00       	call   801054a0 <acquire>
    int r = ip->ref;
80102645:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102648:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
8010264f:	e8 ec 2d 00 00       	call   80105440 <release>
    if(r == 1){
80102654:	83 c4 10             	add    $0x10,%esp
80102657:	83 fe 01             	cmp    $0x1,%esi
8010265a:	75 aa                	jne    80102606 <iput+0x26>
8010265c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102662:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102665:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102668:	89 cf                	mov    %ecx,%edi
8010266a:	eb 0b                	jmp    80102677 <iput+0x97>
8010266c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102670:	83 c6 04             	add    $0x4,%esi
80102673:	39 fe                	cmp    %edi,%esi
80102675:	74 19                	je     80102690 <iput+0xb0>
    if(ip->addrs[i]){
80102677:	8b 16                	mov    (%esi),%edx
80102679:	85 d2                	test   %edx,%edx
8010267b:	74 f3                	je     80102670 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010267d:	8b 03                	mov    (%ebx),%eax
8010267f:	e8 6c f8 ff ff       	call   80101ef0 <bfree>
      ip->addrs[i] = 0;
80102684:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010268a:	eb e4                	jmp    80102670 <iput+0x90>
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102690:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102696:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102699:	85 c0                	test   %eax,%eax
8010269b:	75 2d                	jne    801026ca <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010269d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801026a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801026a7:	53                   	push   %ebx
801026a8:	e8 53 fd ff ff       	call   80102400 <iupdate>
      ip->type = 0;
801026ad:	31 c0                	xor    %eax,%eax
801026af:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801026b3:	89 1c 24             	mov    %ebx,(%esp)
801026b6:	e8 45 fd ff ff       	call   80102400 <iupdate>
      ip->valid = 0;
801026bb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801026c2:	83 c4 10             	add    $0x10,%esp
801026c5:	e9 3c ff ff ff       	jmp    80102606 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801026ca:	83 ec 08             	sub    $0x8,%esp
801026cd:	50                   	push   %eax
801026ce:	ff 33                	push   (%ebx)
801026d0:	e8 fb d9 ff ff       	call   801000d0 <bread>
801026d5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801026d8:	83 c4 10             	add    $0x10,%esp
801026db:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801026e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801026e4:	8d 70 5c             	lea    0x5c(%eax),%esi
801026e7:	89 cf                	mov    %ecx,%edi
801026e9:	eb 0c                	jmp    801026f7 <iput+0x117>
801026eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026ef:	90                   	nop
801026f0:	83 c6 04             	add    $0x4,%esi
801026f3:	39 f7                	cmp    %esi,%edi
801026f5:	74 0f                	je     80102706 <iput+0x126>
      if(a[j])
801026f7:	8b 16                	mov    (%esi),%edx
801026f9:	85 d2                	test   %edx,%edx
801026fb:	74 f3                	je     801026f0 <iput+0x110>
        bfree(ip->dev, a[j]);
801026fd:	8b 03                	mov    (%ebx),%eax
801026ff:	e8 ec f7 ff ff       	call   80101ef0 <bfree>
80102704:	eb ea                	jmp    801026f0 <iput+0x110>
    brelse(bp);
80102706:	83 ec 0c             	sub    $0xc,%esp
80102709:	ff 75 e4             	push   -0x1c(%ebp)
8010270c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010270f:	e8 dc da ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102714:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010271a:	8b 03                	mov    (%ebx),%eax
8010271c:	e8 cf f7 ff ff       	call   80101ef0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102721:	83 c4 10             	add    $0x10,%esp
80102724:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010272b:	00 00 00 
8010272e:	e9 6a ff ff ff       	jmp    8010269d <iput+0xbd>
80102733:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102740 <iunlockput>:
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	56                   	push   %esi
80102744:	53                   	push   %ebx
80102745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102748:	85 db                	test   %ebx,%ebx
8010274a:	74 34                	je     80102780 <iunlockput+0x40>
8010274c:	83 ec 0c             	sub    $0xc,%esp
8010274f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102752:	56                   	push   %esi
80102753:	e8 28 2b 00 00       	call   80105280 <holdingsleep>
80102758:	83 c4 10             	add    $0x10,%esp
8010275b:	85 c0                	test   %eax,%eax
8010275d:	74 21                	je     80102780 <iunlockput+0x40>
8010275f:	8b 43 08             	mov    0x8(%ebx),%eax
80102762:	85 c0                	test   %eax,%eax
80102764:	7e 1a                	jle    80102780 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102766:	83 ec 0c             	sub    $0xc,%esp
80102769:	56                   	push   %esi
8010276a:	e8 d1 2a 00 00       	call   80105240 <releasesleep>
  iput(ip);
8010276f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102772:	83 c4 10             	add    $0x10,%esp
}
80102775:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102778:	5b                   	pop    %ebx
80102779:	5e                   	pop    %esi
8010277a:	5d                   	pop    %ebp
  iput(ip);
8010277b:	e9 60 fe ff ff       	jmp    801025e0 <iput>
    panic("iunlock");
80102780:	83 ec 0c             	sub    $0xc,%esp
80102783:	68 ae 86 10 80       	push   $0x801086ae
80102788:	e8 63 dd ff ff       	call   801004f0 <panic>
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	8b 55 08             	mov    0x8(%ebp),%edx
80102796:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102799:	8b 0a                	mov    (%edx),%ecx
8010279b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010279e:	8b 4a 04             	mov    0x4(%edx),%ecx
801027a1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801027a4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801027a8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801027ab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801027af:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801027b3:	8b 52 58             	mov    0x58(%edx),%edx
801027b6:	89 50 10             	mov    %edx,0x10(%eax)
}
801027b9:	5d                   	pop    %ebp
801027ba:	c3                   	ret    
801027bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027bf:	90                   	nop

801027c0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	57                   	push   %edi
801027c4:	56                   	push   %esi
801027c5:	53                   	push   %ebx
801027c6:	83 ec 1c             	sub    $0x1c,%esp
801027c9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801027cc:	8b 45 08             	mov    0x8(%ebp),%eax
801027cf:	8b 75 10             	mov    0x10(%ebp),%esi
801027d2:	89 7d e0             	mov    %edi,-0x20(%ebp)
801027d5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801027d8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801027dd:	89 45 d8             	mov    %eax,-0x28(%ebp)
801027e0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801027e3:	0f 84 a7 00 00 00    	je     80102890 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801027e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801027ec:	8b 40 58             	mov    0x58(%eax),%eax
801027ef:	39 c6                	cmp    %eax,%esi
801027f1:	0f 87 ba 00 00 00    	ja     801028b1 <readi+0xf1>
801027f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801027fa:	31 c9                	xor    %ecx,%ecx
801027fc:	89 da                	mov    %ebx,%edx
801027fe:	01 f2                	add    %esi,%edx
80102800:	0f 92 c1             	setb   %cl
80102803:	89 cf                	mov    %ecx,%edi
80102805:	0f 82 a6 00 00 00    	jb     801028b1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010280b:	89 c1                	mov    %eax,%ecx
8010280d:	29 f1                	sub    %esi,%ecx
8010280f:	39 d0                	cmp    %edx,%eax
80102811:	0f 43 cb             	cmovae %ebx,%ecx
80102814:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102817:	85 c9                	test   %ecx,%ecx
80102819:	74 67                	je     80102882 <readi+0xc2>
8010281b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010281f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102820:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102823:	89 f2                	mov    %esi,%edx
80102825:	c1 ea 09             	shr    $0x9,%edx
80102828:	89 d8                	mov    %ebx,%eax
8010282a:	e8 51 f9 ff ff       	call   80102180 <bmap>
8010282f:	83 ec 08             	sub    $0x8,%esp
80102832:	50                   	push   %eax
80102833:	ff 33                	push   (%ebx)
80102835:	e8 96 d8 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010283a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010283d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102842:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102844:	89 f0                	mov    %esi,%eax
80102846:	25 ff 01 00 00       	and    $0x1ff,%eax
8010284b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010284d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102850:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102852:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102856:	39 d9                	cmp    %ebx,%ecx
80102858:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010285b:	83 c4 0c             	add    $0xc,%esp
8010285e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010285f:	01 df                	add    %ebx,%edi
80102861:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102863:	50                   	push   %eax
80102864:	ff 75 e0             	push   -0x20(%ebp)
80102867:	e8 84 2d 00 00       	call   801055f0 <memmove>
    brelse(bp);
8010286c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010286f:	89 14 24             	mov    %edx,(%esp)
80102872:	e8 79 d9 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102877:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010287a:	83 c4 10             	add    $0x10,%esp
8010287d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102880:	77 9e                	ja     80102820 <readi+0x60>
  }
  return n;
80102882:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102885:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102888:	5b                   	pop    %ebx
80102889:	5e                   	pop    %esi
8010288a:	5f                   	pop    %edi
8010288b:	5d                   	pop    %ebp
8010288c:	c3                   	ret    
8010288d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102890:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102894:	66 83 f8 09          	cmp    $0x9,%ax
80102898:	77 17                	ja     801028b1 <readi+0xf1>
8010289a:	8b 04 c5 a0 1f 11 80 	mov    -0x7feee060(,%eax,8),%eax
801028a1:	85 c0                	test   %eax,%eax
801028a3:	74 0c                	je     801028b1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801028a5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801028a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028ab:	5b                   	pop    %ebx
801028ac:	5e                   	pop    %esi
801028ad:	5f                   	pop    %edi
801028ae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801028af:	ff e0                	jmp    *%eax
      return -1;
801028b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028b6:	eb cd                	jmp    80102885 <readi+0xc5>
801028b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028bf:	90                   	nop

801028c0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	57                   	push   %edi
801028c4:	56                   	push   %esi
801028c5:	53                   	push   %ebx
801028c6:	83 ec 1c             	sub    $0x1c,%esp
801028c9:	8b 45 08             	mov    0x8(%ebp),%eax
801028cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801028cf:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801028d2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801028d7:	89 75 dc             	mov    %esi,-0x24(%ebp)
801028da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028dd:	8b 75 10             	mov    0x10(%ebp),%esi
801028e0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
801028e3:	0f 84 b7 00 00 00    	je     801029a0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801028e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801028ec:	3b 70 58             	cmp    0x58(%eax),%esi
801028ef:	0f 87 e7 00 00 00    	ja     801029dc <writei+0x11c>
801028f5:	8b 7d e0             	mov    -0x20(%ebp),%edi
801028f8:	31 d2                	xor    %edx,%edx
801028fa:	89 f8                	mov    %edi,%eax
801028fc:	01 f0                	add    %esi,%eax
801028fe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102901:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102906:	0f 87 d0 00 00 00    	ja     801029dc <writei+0x11c>
8010290c:	85 d2                	test   %edx,%edx
8010290e:	0f 85 c8 00 00 00    	jne    801029dc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102914:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010291b:	85 ff                	test   %edi,%edi
8010291d:	74 72                	je     80102991 <writei+0xd1>
8010291f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102920:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102923:	89 f2                	mov    %esi,%edx
80102925:	c1 ea 09             	shr    $0x9,%edx
80102928:	89 f8                	mov    %edi,%eax
8010292a:	e8 51 f8 ff ff       	call   80102180 <bmap>
8010292f:	83 ec 08             	sub    $0x8,%esp
80102932:	50                   	push   %eax
80102933:	ff 37                	push   (%edi)
80102935:	e8 96 d7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010293a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010293f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102942:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102945:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102947:	89 f0                	mov    %esi,%eax
80102949:	25 ff 01 00 00       	and    $0x1ff,%eax
8010294e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102950:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102954:	39 d9                	cmp    %ebx,%ecx
80102956:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102959:	83 c4 0c             	add    $0xc,%esp
8010295c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010295d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
8010295f:	ff 75 dc             	push   -0x24(%ebp)
80102962:	50                   	push   %eax
80102963:	e8 88 2c 00 00       	call   801055f0 <memmove>
    log_write(bp);
80102968:	89 3c 24             	mov    %edi,(%esp)
8010296b:	e8 00 13 00 00       	call   80103c70 <log_write>
    brelse(bp);
80102970:	89 3c 24             	mov    %edi,(%esp)
80102973:	e8 78 d8 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102978:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010297b:	83 c4 10             	add    $0x10,%esp
8010297e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102981:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102984:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102987:	77 97                	ja     80102920 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010298c:	3b 70 58             	cmp    0x58(%eax),%esi
8010298f:	77 37                	ja     801029c8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102991:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102994:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102997:	5b                   	pop    %ebx
80102998:	5e                   	pop    %esi
80102999:	5f                   	pop    %edi
8010299a:	5d                   	pop    %ebp
8010299b:	c3                   	ret    
8010299c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801029a0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801029a4:	66 83 f8 09          	cmp    $0x9,%ax
801029a8:	77 32                	ja     801029dc <writei+0x11c>
801029aa:	8b 04 c5 a4 1f 11 80 	mov    -0x7feee05c(,%eax,8),%eax
801029b1:	85 c0                	test   %eax,%eax
801029b3:	74 27                	je     801029dc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
801029b5:	89 55 10             	mov    %edx,0x10(%ebp)
}
801029b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029bb:	5b                   	pop    %ebx
801029bc:	5e                   	pop    %esi
801029bd:	5f                   	pop    %edi
801029be:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801029bf:	ff e0                	jmp    *%eax
801029c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801029c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801029cb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801029ce:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
801029d1:	50                   	push   %eax
801029d2:	e8 29 fa ff ff       	call   80102400 <iupdate>
801029d7:	83 c4 10             	add    $0x10,%esp
801029da:	eb b5                	jmp    80102991 <writei+0xd1>
      return -1;
801029dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801029e1:	eb b1                	jmp    80102994 <writei+0xd4>
801029e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029f0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801029f6:	6a 0e                	push   $0xe
801029f8:	ff 75 0c             	push   0xc(%ebp)
801029fb:	ff 75 08             	push   0x8(%ebp)
801029fe:	e8 5d 2c 00 00       	call   80105660 <strncmp>
}
80102a03:	c9                   	leave  
80102a04:	c3                   	ret    
80102a05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a10 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102a10:	55                   	push   %ebp
80102a11:	89 e5                	mov    %esp,%ebp
80102a13:	57                   	push   %edi
80102a14:	56                   	push   %esi
80102a15:	53                   	push   %ebx
80102a16:	83 ec 1c             	sub    $0x1c,%esp
80102a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102a1c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102a21:	0f 85 85 00 00 00    	jne    80102aac <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102a27:	8b 53 58             	mov    0x58(%ebx),%edx
80102a2a:	31 ff                	xor    %edi,%edi
80102a2c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102a2f:	85 d2                	test   %edx,%edx
80102a31:	74 3e                	je     80102a71 <dirlookup+0x61>
80102a33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a37:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a38:	6a 10                	push   $0x10
80102a3a:	57                   	push   %edi
80102a3b:	56                   	push   %esi
80102a3c:	53                   	push   %ebx
80102a3d:	e8 7e fd ff ff       	call   801027c0 <readi>
80102a42:	83 c4 10             	add    $0x10,%esp
80102a45:	83 f8 10             	cmp    $0x10,%eax
80102a48:	75 55                	jne    80102a9f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102a4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102a4f:	74 18                	je     80102a69 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102a51:	83 ec 04             	sub    $0x4,%esp
80102a54:	8d 45 da             	lea    -0x26(%ebp),%eax
80102a57:	6a 0e                	push   $0xe
80102a59:	50                   	push   %eax
80102a5a:	ff 75 0c             	push   0xc(%ebp)
80102a5d:	e8 fe 2b 00 00       	call   80105660 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102a62:	83 c4 10             	add    $0x10,%esp
80102a65:	85 c0                	test   %eax,%eax
80102a67:	74 17                	je     80102a80 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102a69:	83 c7 10             	add    $0x10,%edi
80102a6c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102a6f:	72 c7                	jb     80102a38 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102a71:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102a74:	31 c0                	xor    %eax,%eax
}
80102a76:	5b                   	pop    %ebx
80102a77:	5e                   	pop    %esi
80102a78:	5f                   	pop    %edi
80102a79:	5d                   	pop    %ebp
80102a7a:	c3                   	ret    
80102a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a7f:	90                   	nop
      if(poff)
80102a80:	8b 45 10             	mov    0x10(%ebp),%eax
80102a83:	85 c0                	test   %eax,%eax
80102a85:	74 05                	je     80102a8c <dirlookup+0x7c>
        *poff = off;
80102a87:	8b 45 10             	mov    0x10(%ebp),%eax
80102a8a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102a8c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102a90:	8b 03                	mov    (%ebx),%eax
80102a92:	e8 e9 f5 ff ff       	call   80102080 <iget>
}
80102a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9a:	5b                   	pop    %ebx
80102a9b:	5e                   	pop    %esi
80102a9c:	5f                   	pop    %edi
80102a9d:	5d                   	pop    %ebp
80102a9e:	c3                   	ret    
      panic("dirlookup read");
80102a9f:	83 ec 0c             	sub    $0xc,%esp
80102aa2:	68 c8 86 10 80       	push   $0x801086c8
80102aa7:	e8 44 da ff ff       	call   801004f0 <panic>
    panic("dirlookup not DIR");
80102aac:	83 ec 0c             	sub    $0xc,%esp
80102aaf:	68 b6 86 10 80       	push   $0x801086b6
80102ab4:	e8 37 da ff ff       	call   801004f0 <panic>
80102ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ac0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	57                   	push   %edi
80102ac4:	56                   	push   %esi
80102ac5:	53                   	push   %ebx
80102ac6:	89 c3                	mov    %eax,%ebx
80102ac8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102acb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102ace:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102ad1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102ad4:	0f 84 74 01 00 00    	je     80102c4e <namex+0x18e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102ada:	e8 f1 1b 00 00       	call   801046d0 <myproc>
  acquire(&icache.lock);
80102adf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102ae2:	8b b0 d4 00 00 00    	mov    0xd4(%eax),%esi
  acquire(&icache.lock);
80102ae8:	68 00 20 11 80       	push   $0x80112000
80102aed:	e8 ae 29 00 00       	call   801054a0 <acquire>
  ip->ref++;
80102af2:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102af6:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
80102afd:	e8 3e 29 00 00       	call   80105440 <release>
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	eb 0c                	jmp    80102b13 <namex+0x53>
80102b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b0e:	66 90                	xchg   %ax,%ax
    path++;
80102b10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102b13:	0f b6 03             	movzbl (%ebx),%eax
80102b16:	3c 2f                	cmp    $0x2f,%al
80102b18:	74 f6                	je     80102b10 <namex+0x50>
  if(*path == 0)
80102b1a:	84 c0                	test   %al,%al
80102b1c:	0f 84 0e 01 00 00    	je     80102c30 <namex+0x170>
  while(*path != '/' && *path != 0)
80102b22:	0f b6 03             	movzbl (%ebx),%eax
80102b25:	84 c0                	test   %al,%al
80102b27:	0f 84 18 01 00 00    	je     80102c45 <namex+0x185>
80102b2d:	89 df                	mov    %ebx,%edi
80102b2f:	3c 2f                	cmp    $0x2f,%al
80102b31:	0f 84 0e 01 00 00    	je     80102c45 <namex+0x185>
80102b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b3e:	66 90                	xchg   %ax,%ax
80102b40:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102b44:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102b47:	3c 2f                	cmp    $0x2f,%al
80102b49:	74 04                	je     80102b4f <namex+0x8f>
80102b4b:	84 c0                	test   %al,%al
80102b4d:	75 f1                	jne    80102b40 <namex+0x80>
  len = path - s;
80102b4f:	89 f8                	mov    %edi,%eax
80102b51:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102b53:	83 f8 0d             	cmp    $0xd,%eax
80102b56:	0f 8e ac 00 00 00    	jle    80102c08 <namex+0x148>
    memmove(name, s, DIRSIZ);
80102b5c:	83 ec 04             	sub    $0x4,%esp
80102b5f:	6a 0e                	push   $0xe
80102b61:	53                   	push   %ebx
    path++;
80102b62:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80102b64:	ff 75 e4             	push   -0x1c(%ebp)
80102b67:	e8 84 2a 00 00       	call   801055f0 <memmove>
80102b6c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102b6f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102b72:	75 0c                	jne    80102b80 <namex+0xc0>
80102b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102b78:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102b7b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102b7e:	74 f8                	je     80102b78 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102b80:	83 ec 0c             	sub    $0xc,%esp
80102b83:	56                   	push   %esi
80102b84:	e8 27 f9 ff ff       	call   801024b0 <ilock>
    if(ip->type != T_DIR){
80102b89:	83 c4 10             	add    $0x10,%esp
80102b8c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102b91:	0f 85 cd 00 00 00    	jne    80102c64 <namex+0x1a4>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102b97:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102b9a:	85 c0                	test   %eax,%eax
80102b9c:	74 09                	je     80102ba7 <namex+0xe7>
80102b9e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102ba1:	0f 84 22 01 00 00    	je     80102cc9 <namex+0x209>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102ba7:	83 ec 04             	sub    $0x4,%esp
80102baa:	6a 00                	push   $0x0
80102bac:	ff 75 e4             	push   -0x1c(%ebp)
80102baf:	56                   	push   %esi
80102bb0:	e8 5b fe ff ff       	call   80102a10 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102bb5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102bb8:	83 c4 10             	add    $0x10,%esp
80102bbb:	89 c7                	mov    %eax,%edi
80102bbd:	85 c0                	test   %eax,%eax
80102bbf:	0f 84 e1 00 00 00    	je     80102ca6 <namex+0x1e6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102bc5:	83 ec 0c             	sub    $0xc,%esp
80102bc8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102bcb:	52                   	push   %edx
80102bcc:	e8 af 26 00 00       	call   80105280 <holdingsleep>
80102bd1:	83 c4 10             	add    $0x10,%esp
80102bd4:	85 c0                	test   %eax,%eax
80102bd6:	0f 84 30 01 00 00    	je     80102d0c <namex+0x24c>
80102bdc:	8b 56 08             	mov    0x8(%esi),%edx
80102bdf:	85 d2                	test   %edx,%edx
80102be1:	0f 8e 25 01 00 00    	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102be7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102bea:	83 ec 0c             	sub    $0xc,%esp
80102bed:	52                   	push   %edx
80102bee:	e8 4d 26 00 00       	call   80105240 <releasesleep>
  iput(ip);
80102bf3:	89 34 24             	mov    %esi,(%esp)
80102bf6:	89 fe                	mov    %edi,%esi
80102bf8:	e8 e3 f9 ff ff       	call   801025e0 <iput>
80102bfd:	83 c4 10             	add    $0x10,%esp
80102c00:	e9 0e ff ff ff       	jmp    80102b13 <namex+0x53>
80102c05:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102c08:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102c0b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80102c0e:	83 ec 04             	sub    $0x4,%esp
80102c11:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102c14:	50                   	push   %eax
80102c15:	53                   	push   %ebx
    name[len] = 0;
80102c16:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102c18:	ff 75 e4             	push   -0x1c(%ebp)
80102c1b:	e8 d0 29 00 00       	call   801055f0 <memmove>
    name[len] = 0;
80102c20:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102c23:	83 c4 10             	add    $0x10,%esp
80102c26:	c6 02 00             	movb   $0x0,(%edx)
80102c29:	e9 41 ff ff ff       	jmp    80102b6f <namex+0xaf>
80102c2e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102c30:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c33:	85 c0                	test   %eax,%eax
80102c35:	0f 85 be 00 00 00    	jne    80102cf9 <namex+0x239>
    iput(ip);
    return 0;
  }
  return ip;
}
80102c3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c3e:	89 f0                	mov    %esi,%eax
80102c40:	5b                   	pop    %ebx
80102c41:	5e                   	pop    %esi
80102c42:	5f                   	pop    %edi
80102c43:	5d                   	pop    %ebp
80102c44:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102c45:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102c48:	89 df                	mov    %ebx,%edi
80102c4a:	31 c0                	xor    %eax,%eax
80102c4c:	eb c0                	jmp    80102c0e <namex+0x14e>
    ip = iget(ROOTDEV, ROOTINO);
80102c4e:	ba 01 00 00 00       	mov    $0x1,%edx
80102c53:	b8 01 00 00 00       	mov    $0x1,%eax
80102c58:	e8 23 f4 ff ff       	call   80102080 <iget>
80102c5d:	89 c6                	mov    %eax,%esi
80102c5f:	e9 af fe ff ff       	jmp    80102b13 <namex+0x53>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102c64:	83 ec 0c             	sub    $0xc,%esp
80102c67:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c6a:	53                   	push   %ebx
80102c6b:	e8 10 26 00 00       	call   80105280 <holdingsleep>
80102c70:	83 c4 10             	add    $0x10,%esp
80102c73:	85 c0                	test   %eax,%eax
80102c75:	0f 84 91 00 00 00    	je     80102d0c <namex+0x24c>
80102c7b:	8b 46 08             	mov    0x8(%esi),%eax
80102c7e:	85 c0                	test   %eax,%eax
80102c80:	0f 8e 86 00 00 00    	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102c86:	83 ec 0c             	sub    $0xc,%esp
80102c89:	53                   	push   %ebx
80102c8a:	e8 b1 25 00 00       	call   80105240 <releasesleep>
  iput(ip);
80102c8f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102c92:	31 f6                	xor    %esi,%esi
  iput(ip);
80102c94:	e8 47 f9 ff ff       	call   801025e0 <iput>
      return 0;
80102c99:	83 c4 10             	add    $0x10,%esp
}
80102c9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c9f:	89 f0                	mov    %esi,%eax
80102ca1:	5b                   	pop    %ebx
80102ca2:	5e                   	pop    %esi
80102ca3:	5f                   	pop    %edi
80102ca4:	5d                   	pop    %ebp
80102ca5:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102ca6:	83 ec 0c             	sub    $0xc,%esp
80102ca9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102cac:	52                   	push   %edx
80102cad:	e8 ce 25 00 00       	call   80105280 <holdingsleep>
80102cb2:	83 c4 10             	add    $0x10,%esp
80102cb5:	85 c0                	test   %eax,%eax
80102cb7:	74 53                	je     80102d0c <namex+0x24c>
80102cb9:	8b 4e 08             	mov    0x8(%esi),%ecx
80102cbc:	85 c9                	test   %ecx,%ecx
80102cbe:	7e 4c                	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102cc0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102cc3:	83 ec 0c             	sub    $0xc,%esp
80102cc6:	52                   	push   %edx
80102cc7:	eb c1                	jmp    80102c8a <namex+0x1ca>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102cc9:	83 ec 0c             	sub    $0xc,%esp
80102ccc:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102ccf:	53                   	push   %ebx
80102cd0:	e8 ab 25 00 00       	call   80105280 <holdingsleep>
80102cd5:	83 c4 10             	add    $0x10,%esp
80102cd8:	85 c0                	test   %eax,%eax
80102cda:	74 30                	je     80102d0c <namex+0x24c>
80102cdc:	8b 7e 08             	mov    0x8(%esi),%edi
80102cdf:	85 ff                	test   %edi,%edi
80102ce1:	7e 29                	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102ce3:	83 ec 0c             	sub    $0xc,%esp
80102ce6:	53                   	push   %ebx
80102ce7:	e8 54 25 00 00       	call   80105240 <releasesleep>
}
80102cec:	83 c4 10             	add    $0x10,%esp
}
80102cef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cf2:	89 f0                	mov    %esi,%eax
80102cf4:	5b                   	pop    %ebx
80102cf5:	5e                   	pop    %esi
80102cf6:	5f                   	pop    %edi
80102cf7:	5d                   	pop    %ebp
80102cf8:	c3                   	ret    
    iput(ip);
80102cf9:	83 ec 0c             	sub    $0xc,%esp
80102cfc:	56                   	push   %esi
    return 0;
80102cfd:	31 f6                	xor    %esi,%esi
    iput(ip);
80102cff:	e8 dc f8 ff ff       	call   801025e0 <iput>
    return 0;
80102d04:	83 c4 10             	add    $0x10,%esp
80102d07:	e9 2f ff ff ff       	jmp    80102c3b <namex+0x17b>
    panic("iunlock");
80102d0c:	83 ec 0c             	sub    $0xc,%esp
80102d0f:	68 ae 86 10 80       	push   $0x801086ae
80102d14:	e8 d7 d7 ff ff       	call   801004f0 <panic>
80102d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d20 <dirlink>:
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	57                   	push   %edi
80102d24:	56                   	push   %esi
80102d25:	53                   	push   %ebx
80102d26:	83 ec 20             	sub    $0x20,%esp
80102d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102d2c:	6a 00                	push   $0x0
80102d2e:	ff 75 0c             	push   0xc(%ebp)
80102d31:	53                   	push   %ebx
80102d32:	e8 d9 fc ff ff       	call   80102a10 <dirlookup>
80102d37:	83 c4 10             	add    $0x10,%esp
80102d3a:	85 c0                	test   %eax,%eax
80102d3c:	75 67                	jne    80102da5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102d3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102d41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d44:	85 ff                	test   %edi,%edi
80102d46:	74 29                	je     80102d71 <dirlink+0x51>
80102d48:	31 ff                	xor    %edi,%edi
80102d4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d4d:	eb 09                	jmp    80102d58 <dirlink+0x38>
80102d4f:	90                   	nop
80102d50:	83 c7 10             	add    $0x10,%edi
80102d53:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102d56:	73 19                	jae    80102d71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d58:	6a 10                	push   $0x10
80102d5a:	57                   	push   %edi
80102d5b:	56                   	push   %esi
80102d5c:	53                   	push   %ebx
80102d5d:	e8 5e fa ff ff       	call   801027c0 <readi>
80102d62:	83 c4 10             	add    $0x10,%esp
80102d65:	83 f8 10             	cmp    $0x10,%eax
80102d68:	75 4e                	jne    80102db8 <dirlink+0x98>
    if(de.inum == 0)
80102d6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102d6f:	75 df                	jne    80102d50 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102d71:	83 ec 04             	sub    $0x4,%esp
80102d74:	8d 45 da             	lea    -0x26(%ebp),%eax
80102d77:	6a 0e                	push   $0xe
80102d79:	ff 75 0c             	push   0xc(%ebp)
80102d7c:	50                   	push   %eax
80102d7d:	e8 2e 29 00 00       	call   801056b0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d82:	6a 10                	push   $0x10
  de.inum = inum;
80102d84:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d87:	57                   	push   %edi
80102d88:	56                   	push   %esi
80102d89:	53                   	push   %ebx
  de.inum = inum;
80102d8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d8e:	e8 2d fb ff ff       	call   801028c0 <writei>
80102d93:	83 c4 20             	add    $0x20,%esp
80102d96:	83 f8 10             	cmp    $0x10,%eax
80102d99:	75 2a                	jne    80102dc5 <dirlink+0xa5>
  return 0;
80102d9b:	31 c0                	xor    %eax,%eax
}
80102d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102da0:	5b                   	pop    %ebx
80102da1:	5e                   	pop    %esi
80102da2:	5f                   	pop    %edi
80102da3:	5d                   	pop    %ebp
80102da4:	c3                   	ret    
    iput(ip);
80102da5:	83 ec 0c             	sub    $0xc,%esp
80102da8:	50                   	push   %eax
80102da9:	e8 32 f8 ff ff       	call   801025e0 <iput>
    return -1;
80102dae:	83 c4 10             	add    $0x10,%esp
80102db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102db6:	eb e5                	jmp    80102d9d <dirlink+0x7d>
      panic("dirlink read");
80102db8:	83 ec 0c             	sub    $0xc,%esp
80102dbb:	68 d7 86 10 80       	push   $0x801086d7
80102dc0:	e8 2b d7 ff ff       	call   801004f0 <panic>
    panic("dirlink");
80102dc5:	83 ec 0c             	sub    $0xc,%esp
80102dc8:	68 12 8d 10 80       	push   $0x80108d12
80102dcd:	e8 1e d7 ff ff       	call   801004f0 <panic>
80102dd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102de0 <namei>:

struct inode*
namei(char *path)
{
80102de0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102de1:	31 d2                	xor    %edx,%edx
{
80102de3:	89 e5                	mov    %esp,%ebp
80102de5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102de8:	8b 45 08             	mov    0x8(%ebp),%eax
80102deb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102dee:	e8 cd fc ff ff       	call   80102ac0 <namex>
}
80102df3:	c9                   	leave  
80102df4:	c3                   	ret    
80102df5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102e00:	55                   	push   %ebp
  return namex(path, 1, name);
80102e01:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102e06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102e08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102e0e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102e0f:	e9 ac fc ff ff       	jmp    80102ac0 <namex>
80102e14:	66 90                	xchg   %ax,%ax
80102e16:	66 90                	xchg   %ax,%ax
80102e18:	66 90                	xchg   %ax,%ax
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	57                   	push   %edi
80102e24:	56                   	push   %esi
80102e25:	53                   	push   %ebx
80102e26:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102e29:	85 c0                	test   %eax,%eax
80102e2b:	0f 84 b4 00 00 00    	je     80102ee5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102e31:	8b 70 08             	mov    0x8(%eax),%esi
80102e34:	89 c3                	mov    %eax,%ebx
80102e36:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102e3c:	0f 87 96 00 00 00    	ja     80102ed8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e42:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e4e:	66 90                	xchg   %ax,%ax
80102e50:	89 ca                	mov    %ecx,%edx
80102e52:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e53:	83 e0 c0             	and    $0xffffffc0,%eax
80102e56:	3c 40                	cmp    $0x40,%al
80102e58:	75 f6                	jne    80102e50 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e5a:	31 ff                	xor    %edi,%edi
80102e5c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102e61:	89 f8                	mov    %edi,%eax
80102e63:	ee                   	out    %al,(%dx)
80102e64:	b8 01 00 00 00       	mov    $0x1,%eax
80102e69:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102e6e:	ee                   	out    %al,(%dx)
80102e6f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102e74:	89 f0                	mov    %esi,%eax
80102e76:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102e77:	89 f0                	mov    %esi,%eax
80102e79:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102e7e:	c1 f8 08             	sar    $0x8,%eax
80102e81:	ee                   	out    %al,(%dx)
80102e82:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102e87:	89 f8                	mov    %edi,%eax
80102e89:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102e8a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102e8e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e93:	c1 e0 04             	shl    $0x4,%eax
80102e96:	83 e0 10             	and    $0x10,%eax
80102e99:	83 c8 e0             	or     $0xffffffe0,%eax
80102e9c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102e9d:	f6 03 04             	testb  $0x4,(%ebx)
80102ea0:	75 16                	jne    80102eb8 <idestart+0x98>
80102ea2:	b8 20 00 00 00       	mov    $0x20,%eax
80102ea7:	89 ca                	mov    %ecx,%edx
80102ea9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ead:	5b                   	pop    %ebx
80102eae:	5e                   	pop    %esi
80102eaf:	5f                   	pop    %edi
80102eb0:	5d                   	pop    %ebp
80102eb1:	c3                   	ret    
80102eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102eb8:	b8 30 00 00 00       	mov    $0x30,%eax
80102ebd:	89 ca                	mov    %ecx,%edx
80102ebf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102ec0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102ec5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102ec8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102ecd:	fc                   	cld    
80102ece:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102ed0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ed3:	5b                   	pop    %ebx
80102ed4:	5e                   	pop    %esi
80102ed5:	5f                   	pop    %edi
80102ed6:	5d                   	pop    %ebp
80102ed7:	c3                   	ret    
    panic("incorrect blockno");
80102ed8:	83 ec 0c             	sub    $0xc,%esp
80102edb:	68 40 87 10 80       	push   $0x80108740
80102ee0:	e8 0b d6 ff ff       	call   801004f0 <panic>
    panic("idestart");
80102ee5:	83 ec 0c             	sub    $0xc,%esp
80102ee8:	68 37 87 10 80       	push   $0x80108737
80102eed:	e8 fe d5 ff ff       	call   801004f0 <panic>
80102ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f00 <ideinit>:
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102f06:	68 52 87 10 80       	push   $0x80108752
80102f0b:	68 a0 3c 11 80       	push   $0x80113ca0
80102f10:	e8 bb 23 00 00       	call   801052d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102f15:	58                   	pop    %eax
80102f16:	a1 24 3e 11 80       	mov    0x80113e24,%eax
80102f1b:	5a                   	pop    %edx
80102f1c:	83 e8 01             	sub    $0x1,%eax
80102f1f:	50                   	push   %eax
80102f20:	6a 0e                	push   $0xe
80102f22:	e8 89 02 00 00       	call   801031b0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102f27:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f2a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f2f:	90                   	nop
80102f30:	ec                   	in     (%dx),%al
80102f31:	83 e0 c0             	and    $0xffffffc0,%eax
80102f34:	3c 40                	cmp    $0x40,%al
80102f36:	75 f8                	jne    80102f30 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f38:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102f3d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f42:	ee                   	out    %al,(%dx)
80102f43:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f48:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f4d:	eb 06                	jmp    80102f55 <ideinit+0x55>
80102f4f:	90                   	nop
  for(i=0; i<1000; i++){
80102f50:	83 e9 01             	sub    $0x1,%ecx
80102f53:	74 0f                	je     80102f64 <ideinit+0x64>
80102f55:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102f56:	84 c0                	test   %al,%al
80102f58:	74 f6                	je     80102f50 <ideinit+0x50>
      havedisk1 = 1;
80102f5a:	c7 05 80 3c 11 80 01 	movl   $0x1,0x80113c80
80102f61:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f64:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102f69:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f6e:	ee                   	out    %al,(%dx)
}
80102f6f:	c9                   	leave  
80102f70:	c3                   	ret    
80102f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f7f:	90                   	nop

80102f80 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	57                   	push   %edi
80102f84:	56                   	push   %esi
80102f85:	53                   	push   %ebx
80102f86:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102f89:	68 a0 3c 11 80       	push   $0x80113ca0
80102f8e:	e8 0d 25 00 00       	call   801054a0 <acquire>

  if((b = idequeue) == 0){
80102f93:	8b 1d 84 3c 11 80    	mov    0x80113c84,%ebx
80102f99:	83 c4 10             	add    $0x10,%esp
80102f9c:	85 db                	test   %ebx,%ebx
80102f9e:	74 63                	je     80103003 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102fa0:	8b 43 58             	mov    0x58(%ebx),%eax
80102fa3:	a3 84 3c 11 80       	mov    %eax,0x80113c84

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102fa8:	8b 33                	mov    (%ebx),%esi
80102faa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102fb0:	75 2f                	jne    80102fe1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fb2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fbe:	66 90                	xchg   %ax,%ax
80102fc0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102fc1:	89 c1                	mov    %eax,%ecx
80102fc3:	83 e1 c0             	and    $0xffffffc0,%ecx
80102fc6:	80 f9 40             	cmp    $0x40,%cl
80102fc9:	75 f5                	jne    80102fc0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102fcb:	a8 21                	test   $0x21,%al
80102fcd:	75 12                	jne    80102fe1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102fcf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102fd2:	b9 80 00 00 00       	mov    $0x80,%ecx
80102fd7:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102fdc:	fc                   	cld    
80102fdd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102fdf:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102fe1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102fe4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102fe7:	83 ce 02             	or     $0x2,%esi
80102fea:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102fec:	53                   	push   %ebx
80102fed:	e8 6e 1f 00 00       	call   80104f60 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102ff2:	a1 84 3c 11 80       	mov    0x80113c84,%eax
80102ff7:	83 c4 10             	add    $0x10,%esp
80102ffa:	85 c0                	test   %eax,%eax
80102ffc:	74 05                	je     80103003 <ideintr+0x83>
    idestart(idequeue);
80102ffe:	e8 1d fe ff ff       	call   80102e20 <idestart>
    release(&idelock);
80103003:	83 ec 0c             	sub    $0xc,%esp
80103006:	68 a0 3c 11 80       	push   $0x80113ca0
8010300b:	e8 30 24 00 00       	call   80105440 <release>

  release(&idelock);
}
80103010:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103013:	5b                   	pop    %ebx
80103014:	5e                   	pop    %esi
80103015:	5f                   	pop    %edi
80103016:	5d                   	pop    %ebp
80103017:	c3                   	ret    
80103018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010301f:	90                   	nop

80103020 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	53                   	push   %ebx
80103024:	83 ec 10             	sub    $0x10,%esp
80103027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010302a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010302d:	50                   	push   %eax
8010302e:	e8 4d 22 00 00       	call   80105280 <holdingsleep>
80103033:	83 c4 10             	add    $0x10,%esp
80103036:	85 c0                	test   %eax,%eax
80103038:	0f 84 c3 00 00 00    	je     80103101 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010303e:	8b 03                	mov    (%ebx),%eax
80103040:	83 e0 06             	and    $0x6,%eax
80103043:	83 f8 02             	cmp    $0x2,%eax
80103046:	0f 84 a8 00 00 00    	je     801030f4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010304c:	8b 53 04             	mov    0x4(%ebx),%edx
8010304f:	85 d2                	test   %edx,%edx
80103051:	74 0d                	je     80103060 <iderw+0x40>
80103053:	a1 80 3c 11 80       	mov    0x80113c80,%eax
80103058:	85 c0                	test   %eax,%eax
8010305a:	0f 84 87 00 00 00    	je     801030e7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103060:	83 ec 0c             	sub    $0xc,%esp
80103063:	68 a0 3c 11 80       	push   $0x80113ca0
80103068:	e8 33 24 00 00       	call   801054a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010306d:	a1 84 3c 11 80       	mov    0x80113c84,%eax
  b->qnext = 0;
80103072:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103079:	83 c4 10             	add    $0x10,%esp
8010307c:	85 c0                	test   %eax,%eax
8010307e:	74 60                	je     801030e0 <iderw+0xc0>
80103080:	89 c2                	mov    %eax,%edx
80103082:	8b 40 58             	mov    0x58(%eax),%eax
80103085:	85 c0                	test   %eax,%eax
80103087:	75 f7                	jne    80103080 <iderw+0x60>
80103089:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010308c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010308e:	39 1d 84 3c 11 80    	cmp    %ebx,0x80113c84
80103094:	74 3a                	je     801030d0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103096:	8b 03                	mov    (%ebx),%eax
80103098:	83 e0 06             	and    $0x6,%eax
8010309b:	83 f8 02             	cmp    $0x2,%eax
8010309e:	74 1b                	je     801030bb <iderw+0x9b>
    sleep(b, &idelock);
801030a0:	83 ec 08             	sub    $0x8,%esp
801030a3:	68 a0 3c 11 80       	push   $0x80113ca0
801030a8:	53                   	push   %ebx
801030a9:	e8 e2 1d 00 00       	call   80104e90 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801030ae:	8b 03                	mov    (%ebx),%eax
801030b0:	83 c4 10             	add    $0x10,%esp
801030b3:	83 e0 06             	and    $0x6,%eax
801030b6:	83 f8 02             	cmp    $0x2,%eax
801030b9:	75 e5                	jne    801030a0 <iderw+0x80>
  }


  release(&idelock);
801030bb:	c7 45 08 a0 3c 11 80 	movl   $0x80113ca0,0x8(%ebp)
}
801030c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030c5:	c9                   	leave  
  release(&idelock);
801030c6:	e9 75 23 00 00       	jmp    80105440 <release>
801030cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030cf:	90                   	nop
    idestart(b);
801030d0:	89 d8                	mov    %ebx,%eax
801030d2:	e8 49 fd ff ff       	call   80102e20 <idestart>
801030d7:	eb bd                	jmp    80103096 <iderw+0x76>
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801030e0:	ba 84 3c 11 80       	mov    $0x80113c84,%edx
801030e5:	eb a5                	jmp    8010308c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801030e7:	83 ec 0c             	sub    $0xc,%esp
801030ea:	68 81 87 10 80       	push   $0x80108781
801030ef:	e8 fc d3 ff ff       	call   801004f0 <panic>
    panic("iderw: nothing to do");
801030f4:	83 ec 0c             	sub    $0xc,%esp
801030f7:	68 6c 87 10 80       	push   $0x8010876c
801030fc:	e8 ef d3 ff ff       	call   801004f0 <panic>
    panic("iderw: buf not locked");
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	68 56 87 10 80       	push   $0x80108756
80103109:	e8 e2 d3 ff ff       	call   801004f0 <panic>
8010310e:	66 90                	xchg   %ax,%ax

80103110 <ioapicinit>:
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	56                   	push   %esi
80103114:	53                   	push   %ebx
80103115:	c7 05 d4 3c 11 80 00 	movl   $0xfec00000,0x80113cd4
8010311c:	00 c0 fe 
8010311f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103126:	00 00 00 
80103129:	8b 15 d4 3c 11 80    	mov    0x80113cd4,%edx
8010312f:	8b 72 10             	mov    0x10(%edx),%esi
80103132:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103138:	8b 1d d4 3c 11 80    	mov    0x80113cd4,%ebx
8010313e:	0f b6 15 20 3e 11 80 	movzbl 0x80113e20,%edx
80103145:	c1 ee 10             	shr    $0x10,%esi
80103148:	89 f0                	mov    %esi,%eax
8010314a:	0f b6 f0             	movzbl %al,%esi
8010314d:	8b 43 10             	mov    0x10(%ebx),%eax
80103150:	c1 e8 18             	shr    $0x18,%eax
80103153:	39 c2                	cmp    %eax,%edx
80103155:	74 16                	je     8010316d <ioapicinit+0x5d>
80103157:	83 ec 0c             	sub    $0xc,%esp
8010315a:	68 a0 87 10 80       	push   $0x801087a0
8010315f:	e8 0c d9 ff ff       	call   80100a70 <cprintf>
80103164:	8b 1d d4 3c 11 80    	mov    0x80113cd4,%ebx
8010316a:	83 c4 10             	add    $0x10,%esp
8010316d:	ba 10 00 00 00       	mov    $0x10,%edx
80103172:	31 c0                	xor    %eax,%eax
80103174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103178:	89 13                	mov    %edx,(%ebx)
8010317a:	8d 48 20             	lea    0x20(%eax),%ecx
8010317d:	8b 1d d4 3c 11 80    	mov    0x80113cd4,%ebx
80103183:	83 c0 01             	add    $0x1,%eax
80103186:	81 c9 00 00 01 00    	or     $0x10000,%ecx
8010318c:	89 4b 10             	mov    %ecx,0x10(%ebx)
8010318f:	8d 4a 01             	lea    0x1(%edx),%ecx
80103192:	83 c2 02             	add    $0x2,%edx
80103195:	89 0b                	mov    %ecx,(%ebx)
80103197:	8b 1d d4 3c 11 80    	mov    0x80113cd4,%ebx
8010319d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
801031a4:	39 c6                	cmp    %eax,%esi
801031a6:	7d d0                	jge    80103178 <ioapicinit+0x68>
801031a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031ab:	5b                   	pop    %ebx
801031ac:	5e                   	pop    %esi
801031ad:	5d                   	pop    %ebp
801031ae:	c3                   	ret    
801031af:	90                   	nop

801031b0 <ioapicenable>:
801031b0:	55                   	push   %ebp
801031b1:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
801031b7:	89 e5                	mov    %esp,%ebp
801031b9:	8b 45 08             	mov    0x8(%ebp),%eax
801031bc:	8d 50 20             	lea    0x20(%eax),%edx
801031bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
801031c3:	89 01                	mov    %eax,(%ecx)
801031c5:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
801031cb:	83 c0 01             	add    $0x1,%eax
801031ce:	89 51 10             	mov    %edx,0x10(%ecx)
801031d1:	8b 55 0c             	mov    0xc(%ebp),%edx
801031d4:	89 01                	mov    %eax,(%ecx)
801031d6:	a1 d4 3c 11 80       	mov    0x80113cd4,%eax
801031db:	c1 e2 18             	shl    $0x18,%edx
801031de:	89 50 10             	mov    %edx,0x10(%eax)
801031e1:	5d                   	pop    %ebp
801031e2:	c3                   	ret    
801031e3:	66 90                	xchg   %ax,%ax
801031e5:	66 90                	xchg   %ax,%ax
801031e7:	66 90                	xchg   %ax,%ax
801031e9:	66 90                	xchg   %ax,%ax
801031eb:	66 90                	xchg   %ax,%ax
801031ed:	66 90                	xchg   %ax,%ax
801031ef:	90                   	nop

801031f0 <kfree>:
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	53                   	push   %ebx
801031f4:	83 ec 04             	sub    $0x4,%esp
801031f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801031fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103200:	75 76                	jne    80103278 <kfree+0x88>
80103202:	81 fb 70 98 11 80    	cmp    $0x80119870,%ebx
80103208:	72 6e                	jb     80103278 <kfree+0x88>
8010320a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103210:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103215:	77 61                	ja     80103278 <kfree+0x88>
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	68 00 10 00 00       	push   $0x1000
8010321f:	6a 01                	push   $0x1
80103221:	53                   	push   %ebx
80103222:	e8 39 23 00 00       	call   80105560 <memset>
80103227:	8b 15 14 3d 11 80    	mov    0x80113d14,%edx
8010322d:	83 c4 10             	add    $0x10,%esp
80103230:	85 d2                	test   %edx,%edx
80103232:	75 1c                	jne    80103250 <kfree+0x60>
80103234:	a1 18 3d 11 80       	mov    0x80113d18,%eax
80103239:	89 03                	mov    %eax,(%ebx)
8010323b:	a1 14 3d 11 80       	mov    0x80113d14,%eax
80103240:	89 1d 18 3d 11 80    	mov    %ebx,0x80113d18
80103246:	85 c0                	test   %eax,%eax
80103248:	75 1e                	jne    80103268 <kfree+0x78>
8010324a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010324d:	c9                   	leave  
8010324e:	c3                   	ret    
8010324f:	90                   	nop
80103250:	83 ec 0c             	sub    $0xc,%esp
80103253:	68 e0 3c 11 80       	push   $0x80113ce0
80103258:	e8 43 22 00 00       	call   801054a0 <acquire>
8010325d:	83 c4 10             	add    $0x10,%esp
80103260:	eb d2                	jmp    80103234 <kfree+0x44>
80103262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103268:	c7 45 08 e0 3c 11 80 	movl   $0x80113ce0,0x8(%ebp)
8010326f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103272:	c9                   	leave  
80103273:	e9 c8 21 00 00       	jmp    80105440 <release>
80103278:	83 ec 0c             	sub    $0xc,%esp
8010327b:	68 d2 87 10 80       	push   $0x801087d2
80103280:	e8 6b d2 ff ff       	call   801004f0 <panic>
80103285:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010328c:	00 
8010328d:	8d 76 00             	lea    0x0(%esi),%esi

80103290 <freerange>:
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	56                   	push   %esi
80103294:	53                   	push   %ebx
80103295:	8b 45 08             	mov    0x8(%ebp),%eax
80103298:	8b 75 0c             	mov    0xc(%ebp),%esi
8010329b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801032a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032ad:	39 de                	cmp    %ebx,%esi
801032af:	72 23                	jb     801032d4 <freerange+0x44>
801032b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b8:	83 ec 0c             	sub    $0xc,%esp
801032bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801032c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032c7:	50                   	push   %eax
801032c8:	e8 23 ff ff ff       	call   801031f0 <kfree>
801032cd:	83 c4 10             	add    $0x10,%esp
801032d0:	39 de                	cmp    %ebx,%esi
801032d2:	73 e4                	jae    801032b8 <freerange+0x28>
801032d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032d7:	5b                   	pop    %ebx
801032d8:	5e                   	pop    %esi
801032d9:	5d                   	pop    %ebp
801032da:	c3                   	ret    
801032db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801032e0 <kinit2>:
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	56                   	push   %esi
801032e4:	53                   	push   %ebx
801032e5:	8b 45 08             	mov    0x8(%ebp),%eax
801032e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801032eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801032f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032fd:	39 de                	cmp    %ebx,%esi
801032ff:	72 23                	jb     80103324 <kinit2+0x44>
80103301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103308:	83 ec 0c             	sub    $0xc,%esp
8010330b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103311:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80103317:	50                   	push   %eax
80103318:	e8 d3 fe ff ff       	call   801031f0 <kfree>
8010331d:	83 c4 10             	add    $0x10,%esp
80103320:	39 de                	cmp    %ebx,%esi
80103322:	73 e4                	jae    80103308 <kinit2+0x28>
80103324:	c7 05 14 3d 11 80 01 	movl   $0x1,0x80113d14
8010332b:	00 00 00 
8010332e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103331:	5b                   	pop    %ebx
80103332:	5e                   	pop    %esi
80103333:	5d                   	pop    %ebp
80103334:	c3                   	ret    
80103335:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010333c:	00 
8010333d:	8d 76 00             	lea    0x0(%esi),%esi

80103340 <kinit1>:
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	56                   	push   %esi
80103344:	53                   	push   %ebx
80103345:	8b 75 0c             	mov    0xc(%ebp),%esi
80103348:	83 ec 08             	sub    $0x8,%esp
8010334b:	68 d8 87 10 80       	push   $0x801087d8
80103350:	68 e0 3c 11 80       	push   $0x80113ce0
80103355:	e8 76 1f 00 00       	call   801052d0 <initlock>
8010335a:	8b 45 08             	mov    0x8(%ebp),%eax
8010335d:	83 c4 10             	add    $0x10,%esp
80103360:	c7 05 14 3d 11 80 00 	movl   $0x0,0x80113d14
80103367:	00 00 00 
8010336a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103370:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80103376:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010337c:	39 de                	cmp    %ebx,%esi
8010337e:	72 1c                	jb     8010339c <kinit1+0x5c>
80103380:	83 ec 0c             	sub    $0xc,%esp
80103383:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103389:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010338f:	50                   	push   %eax
80103390:	e8 5b fe ff ff       	call   801031f0 <kfree>
80103395:	83 c4 10             	add    $0x10,%esp
80103398:	39 de                	cmp    %ebx,%esi
8010339a:	73 e4                	jae    80103380 <kinit1+0x40>
8010339c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010339f:	5b                   	pop    %ebx
801033a0:	5e                   	pop    %esi
801033a1:	5d                   	pop    %ebp
801033a2:	c3                   	ret    
801033a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033aa:	00 
801033ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801033b0 <kalloc>:
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	53                   	push   %ebx
801033b4:	83 ec 04             	sub    $0x4,%esp
801033b7:	a1 14 3d 11 80       	mov    0x80113d14,%eax
801033bc:	85 c0                	test   %eax,%eax
801033be:	75 20                	jne    801033e0 <kalloc+0x30>
801033c0:	8b 1d 18 3d 11 80    	mov    0x80113d18,%ebx
801033c6:	85 db                	test   %ebx,%ebx
801033c8:	74 07                	je     801033d1 <kalloc+0x21>
801033ca:	8b 03                	mov    (%ebx),%eax
801033cc:	a3 18 3d 11 80       	mov    %eax,0x80113d18
801033d1:	89 d8                	mov    %ebx,%eax
801033d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033d6:	c9                   	leave  
801033d7:	c3                   	ret    
801033d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033df:	00 
801033e0:	83 ec 0c             	sub    $0xc,%esp
801033e3:	68 e0 3c 11 80       	push   $0x80113ce0
801033e8:	e8 b3 20 00 00       	call   801054a0 <acquire>
801033ed:	8b 1d 18 3d 11 80    	mov    0x80113d18,%ebx
801033f3:	a1 14 3d 11 80       	mov    0x80113d14,%eax
801033f8:	83 c4 10             	add    $0x10,%esp
801033fb:	85 db                	test   %ebx,%ebx
801033fd:	74 08                	je     80103407 <kalloc+0x57>
801033ff:	8b 13                	mov    (%ebx),%edx
80103401:	89 15 18 3d 11 80    	mov    %edx,0x80113d18
80103407:	85 c0                	test   %eax,%eax
80103409:	74 c6                	je     801033d1 <kalloc+0x21>
8010340b:	83 ec 0c             	sub    $0xc,%esp
8010340e:	68 e0 3c 11 80       	push   $0x80113ce0
80103413:	e8 28 20 00 00       	call   80105440 <release>
80103418:	89 d8                	mov    %ebx,%eax
8010341a:	83 c4 10             	add    $0x10,%esp
8010341d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103420:	c9                   	leave  
80103421:	c3                   	ret    
80103422:	66 90                	xchg   %ax,%ax
80103424:	66 90                	xchg   %ax,%ax
80103426:	66 90                	xchg   %ax,%ax
80103428:	66 90                	xchg   %ax,%ax
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <kbdgetc>:
80103430:	ba 64 00 00 00       	mov    $0x64,%edx
80103435:	ec                   	in     (%dx),%al
80103436:	a8 01                	test   $0x1,%al
80103438:	0f 84 c2 00 00 00    	je     80103500 <kbdgetc+0xd0>
8010343e:	55                   	push   %ebp
8010343f:	ba 60 00 00 00       	mov    $0x60,%edx
80103444:	89 e5                	mov    %esp,%ebp
80103446:	53                   	push   %ebx
80103447:	ec                   	in     (%dx),%al
80103448:	8b 1d 1c 3d 11 80    	mov    0x80113d1c,%ebx
8010344e:	0f b6 c8             	movzbl %al,%ecx
80103451:	3c e0                	cmp    $0xe0,%al
80103453:	74 5b                	je     801034b0 <kbdgetc+0x80>
80103455:	89 da                	mov    %ebx,%edx
80103457:	83 e2 40             	and    $0x40,%edx
8010345a:	84 c0                	test   %al,%al
8010345c:	78 62                	js     801034c0 <kbdgetc+0x90>
8010345e:	85 d2                	test   %edx,%edx
80103460:	74 09                	je     8010346b <kbdgetc+0x3b>
80103462:	83 c8 80             	or     $0xffffff80,%eax
80103465:	83 e3 bf             	and    $0xffffffbf,%ebx
80103468:	0f b6 c8             	movzbl %al,%ecx
8010346b:	0f b6 91 00 89 10 80 	movzbl -0x7fef7700(%ecx),%edx
80103472:	0f b6 81 00 88 10 80 	movzbl -0x7fef7800(%ecx),%eax
80103479:	09 da                	or     %ebx,%edx
8010347b:	31 c2                	xor    %eax,%edx
8010347d:	89 d0                	mov    %edx,%eax
8010347f:	89 15 1c 3d 11 80    	mov    %edx,0x80113d1c
80103485:	83 e0 03             	and    $0x3,%eax
80103488:	83 e2 08             	and    $0x8,%edx
8010348b:	8b 04 85 e0 87 10 80 	mov    -0x7fef7820(,%eax,4),%eax
80103492:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80103496:	74 0b                	je     801034a3 <kbdgetc+0x73>
80103498:	8d 50 9f             	lea    -0x61(%eax),%edx
8010349b:	83 fa 19             	cmp    $0x19,%edx
8010349e:	77 48                	ja     801034e8 <kbdgetc+0xb8>
801034a0:	83 e8 20             	sub    $0x20,%eax
801034a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034a6:	c9                   	leave  
801034a7:	c3                   	ret    
801034a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034af:	00 
801034b0:	83 cb 40             	or     $0x40,%ebx
801034b3:	31 c0                	xor    %eax,%eax
801034b5:	89 1d 1c 3d 11 80    	mov    %ebx,0x80113d1c
801034bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034be:	c9                   	leave  
801034bf:	c3                   	ret    
801034c0:	83 e0 7f             	and    $0x7f,%eax
801034c3:	85 d2                	test   %edx,%edx
801034c5:	0f 44 c8             	cmove  %eax,%ecx
801034c8:	0f b6 81 00 89 10 80 	movzbl -0x7fef7700(%ecx),%eax
801034cf:	83 c8 40             	or     $0x40,%eax
801034d2:	0f b6 c0             	movzbl %al,%eax
801034d5:	f7 d0                	not    %eax
801034d7:	21 d8                	and    %ebx,%eax
801034d9:	a3 1c 3d 11 80       	mov    %eax,0x80113d1c
801034de:	31 c0                	xor    %eax,%eax
801034e0:	eb d9                	jmp    801034bb <kbdgetc+0x8b>
801034e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801034e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
801034eb:	8d 50 20             	lea    0x20(%eax),%edx
801034ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034f1:	c9                   	leave  
801034f2:	83 f9 1a             	cmp    $0x1a,%ecx
801034f5:	0f 42 c2             	cmovb  %edx,%eax
801034f8:	c3                   	ret    
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103505:	c3                   	ret    
80103506:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010350d:	00 
8010350e:	66 90                	xchg   %ax,%ax

80103510 <kbdintr>:
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	83 ec 14             	sub    $0x14,%esp
80103516:	68 30 34 10 80       	push   $0x80103430
8010351b:	e8 20 d8 ff ff       	call   80100d40 <consoleintr>
80103520:	83 c4 10             	add    $0x10,%esp
80103523:	c9                   	leave  
80103524:	c3                   	ret    
80103525:	66 90                	xchg   %ax,%ax
80103527:	66 90                	xchg   %ax,%ax
80103529:	66 90                	xchg   %ax,%ax
8010352b:	66 90                	xchg   %ax,%ax
8010352d:	66 90                	xchg   %ax,%ax
8010352f:	90                   	nop

80103530 <lapicinit>:
80103530:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103535:	85 c0                	test   %eax,%eax
80103537:	0f 84 c3 00 00 00    	je     80103600 <lapicinit+0xd0>
8010353d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103544:	01 00 00 
80103547:	8b 50 20             	mov    0x20(%eax),%edx
8010354a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103551:	00 00 00 
80103554:	8b 50 20             	mov    0x20(%eax),%edx
80103557:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010355e:	00 02 00 
80103561:	8b 50 20             	mov    0x20(%eax),%edx
80103564:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010356b:	96 98 00 
8010356e:	8b 50 20             	mov    0x20(%eax),%edx
80103571:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103578:	00 01 00 
8010357b:	8b 50 20             	mov    0x20(%eax),%edx
8010357e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103585:	00 01 00 
80103588:	8b 50 20             	mov    0x20(%eax),%edx
8010358b:	8b 50 30             	mov    0x30(%eax),%edx
8010358e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103594:	75 72                	jne    80103608 <lapicinit+0xd8>
80103596:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010359d:	00 00 00 
801035a0:	8b 50 20             	mov    0x20(%eax),%edx
801035a3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801035aa:	00 00 00 
801035ad:	8b 50 20             	mov    0x20(%eax),%edx
801035b0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801035b7:	00 00 00 
801035ba:	8b 50 20             	mov    0x20(%eax),%edx
801035bd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801035c4:	00 00 00 
801035c7:	8b 50 20             	mov    0x20(%eax),%edx
801035ca:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801035d1:	00 00 00 
801035d4:	8b 50 20             	mov    0x20(%eax),%edx
801035d7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801035de:	85 08 00 
801035e1:	8b 50 20             	mov    0x20(%eax),%edx
801035e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035e8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801035ee:	80 e6 10             	and    $0x10,%dh
801035f1:	75 f5                	jne    801035e8 <lapicinit+0xb8>
801035f3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801035fa:	00 00 00 
801035fd:	8b 40 20             	mov    0x20(%eax),%eax
80103600:	c3                   	ret    
80103601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103608:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010360f:	00 01 00 
80103612:	8b 50 20             	mov    0x20(%eax),%edx
80103615:	e9 7c ff ff ff       	jmp    80103596 <lapicinit+0x66>
8010361a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103620 <lapicid>:
80103620:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103625:	85 c0                	test   %eax,%eax
80103627:	74 07                	je     80103630 <lapicid+0x10>
80103629:	8b 40 20             	mov    0x20(%eax),%eax
8010362c:	c1 e8 18             	shr    $0x18,%eax
8010362f:	c3                   	ret    
80103630:	31 c0                	xor    %eax,%eax
80103632:	c3                   	ret    
80103633:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363a:	00 
8010363b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103640 <lapiceoi>:
80103640:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103645:	85 c0                	test   %eax,%eax
80103647:	74 0d                	je     80103656 <lapiceoi+0x16>
80103649:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103650:	00 00 00 
80103653:	8b 40 20             	mov    0x20(%eax),%eax
80103656:	c3                   	ret    
80103657:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010365e:	00 
8010365f:	90                   	nop

80103660 <microdelay>:
80103660:	c3                   	ret    
80103661:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103668:	00 
80103669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103670 <lapicstartap>:
80103670:	55                   	push   %ebp
80103671:	b8 0f 00 00 00       	mov    $0xf,%eax
80103676:	ba 70 00 00 00       	mov    $0x70,%edx
8010367b:	89 e5                	mov    %esp,%ebp
8010367d:	53                   	push   %ebx
8010367e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103681:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103684:	ee                   	out    %al,(%dx)
80103685:	b8 0a 00 00 00       	mov    $0xa,%eax
8010368a:	ba 71 00 00 00       	mov    $0x71,%edx
8010368f:	ee                   	out    %al,(%dx)
80103690:	31 c0                	xor    %eax,%eax
80103692:	c1 e3 18             	shl    $0x18,%ebx
80103695:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010369b:	89 c8                	mov    %ecx,%eax
8010369d:	c1 e9 0c             	shr    $0xc,%ecx
801036a0:	89 da                	mov    %ebx,%edx
801036a2:	c1 e8 04             	shr    $0x4,%eax
801036a5:	80 cd 06             	or     $0x6,%ch
801036a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
801036ae:	a1 20 3d 11 80       	mov    0x80113d20,%eax
801036b3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
801036b9:	8b 58 20             	mov    0x20(%eax),%ebx
801036bc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801036c3:	c5 00 00 
801036c6:	8b 58 20             	mov    0x20(%eax),%ebx
801036c9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801036d0:	85 00 00 
801036d3:	8b 58 20             	mov    0x20(%eax),%ebx
801036d6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801036dc:	8b 58 20             	mov    0x20(%eax),%ebx
801036df:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801036e5:	8b 58 20             	mov    0x20(%eax),%ebx
801036e8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801036ee:	8b 50 20             	mov    0x20(%eax),%edx
801036f1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801036f7:	8b 40 20             	mov    0x20(%eax),%eax
801036fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036fd:	c9                   	leave  
801036fe:	c3                   	ret    
801036ff:	90                   	nop

80103700 <cmostime>:
80103700:	55                   	push   %ebp
80103701:	b8 0b 00 00 00       	mov    $0xb,%eax
80103706:	ba 70 00 00 00       	mov    $0x70,%edx
8010370b:	89 e5                	mov    %esp,%ebp
8010370d:	57                   	push   %edi
8010370e:	56                   	push   %esi
8010370f:	53                   	push   %ebx
80103710:	83 ec 4c             	sub    $0x4c,%esp
80103713:	ee                   	out    %al,(%dx)
80103714:	ba 71 00 00 00       	mov    $0x71,%edx
80103719:	ec                   	in     (%dx),%al
8010371a:	83 e0 04             	and    $0x4,%eax
8010371d:	bf 70 00 00 00       	mov    $0x70,%edi
80103722:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103725:	8d 76 00             	lea    0x0(%esi),%esi
80103728:	31 c0                	xor    %eax,%eax
8010372a:	89 fa                	mov    %edi,%edx
8010372c:	ee                   	out    %al,(%dx)
8010372d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103732:	89 ca                	mov    %ecx,%edx
80103734:	ec                   	in     (%dx),%al
80103735:	88 45 b7             	mov    %al,-0x49(%ebp)
80103738:	89 fa                	mov    %edi,%edx
8010373a:	b8 02 00 00 00       	mov    $0x2,%eax
8010373f:	ee                   	out    %al,(%dx)
80103740:	89 ca                	mov    %ecx,%edx
80103742:	ec                   	in     (%dx),%al
80103743:	88 45 b6             	mov    %al,-0x4a(%ebp)
80103746:	89 fa                	mov    %edi,%edx
80103748:	b8 04 00 00 00       	mov    $0x4,%eax
8010374d:	ee                   	out    %al,(%dx)
8010374e:	89 ca                	mov    %ecx,%edx
80103750:	ec                   	in     (%dx),%al
80103751:	88 45 b5             	mov    %al,-0x4b(%ebp)
80103754:	89 fa                	mov    %edi,%edx
80103756:	b8 07 00 00 00       	mov    $0x7,%eax
8010375b:	ee                   	out    %al,(%dx)
8010375c:	89 ca                	mov    %ecx,%edx
8010375e:	ec                   	in     (%dx),%al
8010375f:	88 45 b4             	mov    %al,-0x4c(%ebp)
80103762:	89 fa                	mov    %edi,%edx
80103764:	b8 08 00 00 00       	mov    $0x8,%eax
80103769:	ee                   	out    %al,(%dx)
8010376a:	89 ca                	mov    %ecx,%edx
8010376c:	ec                   	in     (%dx),%al
8010376d:	89 c6                	mov    %eax,%esi
8010376f:	89 fa                	mov    %edi,%edx
80103771:	b8 09 00 00 00       	mov    $0x9,%eax
80103776:	ee                   	out    %al,(%dx)
80103777:	89 ca                	mov    %ecx,%edx
80103779:	ec                   	in     (%dx),%al
8010377a:	0f b6 d8             	movzbl %al,%ebx
8010377d:	89 fa                	mov    %edi,%edx
8010377f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103784:	ee                   	out    %al,(%dx)
80103785:	89 ca                	mov    %ecx,%edx
80103787:	ec                   	in     (%dx),%al
80103788:	84 c0                	test   %al,%al
8010378a:	78 9c                	js     80103728 <cmostime+0x28>
8010378c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103790:	89 f2                	mov    %esi,%edx
80103792:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103795:	0f b6 f2             	movzbl %dl,%esi
80103798:	89 fa                	mov    %edi,%edx
8010379a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010379d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801037a1:	89 75 c8             	mov    %esi,-0x38(%ebp)
801037a4:	89 45 bc             	mov    %eax,-0x44(%ebp)
801037a7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801037ab:	89 45 c0             	mov    %eax,-0x40(%ebp)
801037ae:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801037b2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801037b5:	31 c0                	xor    %eax,%eax
801037b7:	ee                   	out    %al,(%dx)
801037b8:	89 ca                	mov    %ecx,%edx
801037ba:	ec                   	in     (%dx),%al
801037bb:	0f b6 c0             	movzbl %al,%eax
801037be:	89 fa                	mov    %edi,%edx
801037c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801037c3:	b8 02 00 00 00       	mov    $0x2,%eax
801037c8:	ee                   	out    %al,(%dx)
801037c9:	89 ca                	mov    %ecx,%edx
801037cb:	ec                   	in     (%dx),%al
801037cc:	0f b6 c0             	movzbl %al,%eax
801037cf:	89 fa                	mov    %edi,%edx
801037d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801037d4:	b8 04 00 00 00       	mov    $0x4,%eax
801037d9:	ee                   	out    %al,(%dx)
801037da:	89 ca                	mov    %ecx,%edx
801037dc:	ec                   	in     (%dx),%al
801037dd:	0f b6 c0             	movzbl %al,%eax
801037e0:	89 fa                	mov    %edi,%edx
801037e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801037e5:	b8 07 00 00 00       	mov    $0x7,%eax
801037ea:	ee                   	out    %al,(%dx)
801037eb:	89 ca                	mov    %ecx,%edx
801037ed:	ec                   	in     (%dx),%al
801037ee:	0f b6 c0             	movzbl %al,%eax
801037f1:	89 fa                	mov    %edi,%edx
801037f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801037f6:	b8 08 00 00 00       	mov    $0x8,%eax
801037fb:	ee                   	out    %al,(%dx)
801037fc:	89 ca                	mov    %ecx,%edx
801037fe:	ec                   	in     (%dx),%al
801037ff:	0f b6 c0             	movzbl %al,%eax
80103802:	89 fa                	mov    %edi,%edx
80103804:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103807:	b8 09 00 00 00       	mov    $0x9,%eax
8010380c:	ee                   	out    %al,(%dx)
8010380d:	89 ca                	mov    %ecx,%edx
8010380f:	ec                   	in     (%dx),%al
80103810:	0f b6 c0             	movzbl %al,%eax
80103813:	83 ec 04             	sub    $0x4,%esp
80103816:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103819:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010381c:	6a 18                	push   $0x18
8010381e:	50                   	push   %eax
8010381f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103822:	50                   	push   %eax
80103823:	e8 78 1d 00 00       	call   801055a0 <memcmp>
80103828:	83 c4 10             	add    $0x10,%esp
8010382b:	85 c0                	test   %eax,%eax
8010382d:	0f 85 f5 fe ff ff    	jne    80103728 <cmostime+0x28>
80103833:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80103837:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010383a:	89 f0                	mov    %esi,%eax
8010383c:	84 c0                	test   %al,%al
8010383e:	75 78                	jne    801038b8 <cmostime+0x1b8>
80103840:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103843:	89 c2                	mov    %eax,%edx
80103845:	83 e0 0f             	and    $0xf,%eax
80103848:	c1 ea 04             	shr    $0x4,%edx
8010384b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010384e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103851:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103854:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103857:	89 c2                	mov    %eax,%edx
80103859:	83 e0 0f             	and    $0xf,%eax
8010385c:	c1 ea 04             	shr    $0x4,%edx
8010385f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103862:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103865:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103868:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010386b:	89 c2                	mov    %eax,%edx
8010386d:	83 e0 0f             	and    $0xf,%eax
80103870:	c1 ea 04             	shr    $0x4,%edx
80103873:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103876:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103879:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010387c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010387f:	89 c2                	mov    %eax,%edx
80103881:	83 e0 0f             	and    $0xf,%eax
80103884:	c1 ea 04             	shr    $0x4,%edx
80103887:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010388a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010388d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103890:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103893:	89 c2                	mov    %eax,%edx
80103895:	83 e0 0f             	and    $0xf,%eax
80103898:	c1 ea 04             	shr    $0x4,%edx
8010389b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010389e:	8d 04 50             	lea    (%eax,%edx,2),%eax
801038a1:	89 45 c8             	mov    %eax,-0x38(%ebp)
801038a4:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038a7:	89 c2                	mov    %eax,%edx
801038a9:	83 e0 0f             	and    $0xf,%eax
801038ac:	c1 ea 04             	shr    $0x4,%edx
801038af:	8d 14 92             	lea    (%edx,%edx,4),%edx
801038b2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801038b5:	89 45 cc             	mov    %eax,-0x34(%ebp)
801038b8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801038bb:	89 03                	mov    %eax,(%ebx)
801038bd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801038c0:	89 43 04             	mov    %eax,0x4(%ebx)
801038c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801038c6:	89 43 08             	mov    %eax,0x8(%ebx)
801038c9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801038cc:	89 43 0c             	mov    %eax,0xc(%ebx)
801038cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
801038d2:	89 43 10             	mov    %eax,0x10(%ebx)
801038d5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038d8:	89 43 14             	mov    %eax,0x14(%ebx)
801038db:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
801038e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038e5:	5b                   	pop    %ebx
801038e6:	5e                   	pop    %esi
801038e7:	5f                   	pop    %edi
801038e8:	5d                   	pop    %ebp
801038e9:	c3                   	ret    
801038ea:	66 90                	xchg   %ax,%ax
801038ec:	66 90                	xchg   %ax,%ax
801038ee:	66 90                	xchg   %ax,%ax

801038f0 <install_trans>:
801038f0:	8b 0d 88 3d 11 80    	mov    0x80113d88,%ecx
801038f6:	85 c9                	test   %ecx,%ecx
801038f8:	0f 8e 8a 00 00 00    	jle    80103988 <install_trans+0x98>
801038fe:	55                   	push   %ebp
801038ff:	89 e5                	mov    %esp,%ebp
80103901:	57                   	push   %edi
80103902:	31 ff                	xor    %edi,%edi
80103904:	56                   	push   %esi
80103905:	53                   	push   %ebx
80103906:	83 ec 0c             	sub    $0xc,%esp
80103909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103910:	a1 74 3d 11 80       	mov    0x80113d74,%eax
80103915:	83 ec 08             	sub    $0x8,%esp
80103918:	01 f8                	add    %edi,%eax
8010391a:	83 c0 01             	add    $0x1,%eax
8010391d:	50                   	push   %eax
8010391e:	ff 35 84 3d 11 80    	push   0x80113d84
80103924:	e8 a7 c7 ff ff       	call   801000d0 <bread>
80103929:	89 c6                	mov    %eax,%esi
8010392b:	58                   	pop    %eax
8010392c:	5a                   	pop    %edx
8010392d:	ff 34 bd 8c 3d 11 80 	push   -0x7feec274(,%edi,4)
80103934:	ff 35 84 3d 11 80    	push   0x80113d84
8010393a:	83 c7 01             	add    $0x1,%edi
8010393d:	e8 8e c7 ff ff       	call   801000d0 <bread>
80103942:	83 c4 0c             	add    $0xc,%esp
80103945:	89 c3                	mov    %eax,%ebx
80103947:	8d 46 5c             	lea    0x5c(%esi),%eax
8010394a:	68 00 02 00 00       	push   $0x200
8010394f:	50                   	push   %eax
80103950:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103953:	50                   	push   %eax
80103954:	e8 97 1c 00 00       	call   801055f0 <memmove>
80103959:	89 1c 24             	mov    %ebx,(%esp)
8010395c:	e8 4f c8 ff ff       	call   801001b0 <bwrite>
80103961:	89 34 24             	mov    %esi,(%esp)
80103964:	e8 87 c8 ff ff       	call   801001f0 <brelse>
80103969:	89 1c 24             	mov    %ebx,(%esp)
8010396c:	e8 7f c8 ff ff       	call   801001f0 <brelse>
80103971:	83 c4 10             	add    $0x10,%esp
80103974:	39 3d 88 3d 11 80    	cmp    %edi,0x80113d88
8010397a:	7f 94                	jg     80103910 <install_trans+0x20>
8010397c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010397f:	5b                   	pop    %ebx
80103980:	5e                   	pop    %esi
80103981:	5f                   	pop    %edi
80103982:	5d                   	pop    %ebp
80103983:	c3                   	ret    
80103984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103988:	c3                   	ret    
80103989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103990 <write_head>:
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 0c             	sub    $0xc,%esp
80103997:	ff 35 74 3d 11 80    	push   0x80113d74
8010399d:	ff 35 84 3d 11 80    	push   0x80113d84
801039a3:	e8 28 c7 ff ff       	call   801000d0 <bread>
801039a8:	83 c4 10             	add    $0x10,%esp
801039ab:	89 c3                	mov    %eax,%ebx
801039ad:	a1 88 3d 11 80       	mov    0x80113d88,%eax
801039b2:	89 43 5c             	mov    %eax,0x5c(%ebx)
801039b5:	85 c0                	test   %eax,%eax
801039b7:	7e 19                	jle    801039d2 <write_head+0x42>
801039b9:	31 d2                	xor    %edx,%edx
801039bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801039c0:	8b 0c 95 8c 3d 11 80 	mov    -0x7feec274(,%edx,4),%ecx
801039c7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
801039cb:	83 c2 01             	add    $0x1,%edx
801039ce:	39 d0                	cmp    %edx,%eax
801039d0:	75 ee                	jne    801039c0 <write_head+0x30>
801039d2:	83 ec 0c             	sub    $0xc,%esp
801039d5:	53                   	push   %ebx
801039d6:	e8 d5 c7 ff ff       	call   801001b0 <bwrite>
801039db:	89 1c 24             	mov    %ebx,(%esp)
801039de:	e8 0d c8 ff ff       	call   801001f0 <brelse>
801039e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039e6:	83 c4 10             	add    $0x10,%esp
801039e9:	c9                   	leave  
801039ea:	c3                   	ret    
801039eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039f0 <initlog>:
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
801039f4:	83 ec 2c             	sub    $0x2c,%esp
801039f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039fa:	68 00 8a 10 80       	push   $0x80108a00
801039ff:	68 40 3d 11 80       	push   $0x80113d40
80103a04:	e8 c7 18 00 00       	call   801052d0 <initlock>
80103a09:	58                   	pop    %eax
80103a0a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103a0d:	5a                   	pop    %edx
80103a0e:	50                   	push   %eax
80103a0f:	53                   	push   %ebx
80103a10:	e8 3b e8 ff ff       	call   80102250 <readsb>
80103a15:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103a18:	59                   	pop    %ecx
80103a19:	89 1d 84 3d 11 80    	mov    %ebx,0x80113d84
80103a1f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103a22:	a3 74 3d 11 80       	mov    %eax,0x80113d74
80103a27:	89 15 78 3d 11 80    	mov    %edx,0x80113d78
80103a2d:	5a                   	pop    %edx
80103a2e:	50                   	push   %eax
80103a2f:	53                   	push   %ebx
80103a30:	e8 9b c6 ff ff       	call   801000d0 <bread>
80103a35:	83 c4 10             	add    $0x10,%esp
80103a38:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103a3b:	89 1d 88 3d 11 80    	mov    %ebx,0x80113d88
80103a41:	85 db                	test   %ebx,%ebx
80103a43:	7e 1d                	jle    80103a62 <initlog+0x72>
80103a45:	31 d2                	xor    %edx,%edx
80103a47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a4e:	00 
80103a4f:	90                   	nop
80103a50:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a54:	89 0c 95 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%edx,4)
80103a5b:	83 c2 01             	add    $0x1,%edx
80103a5e:	39 d3                	cmp    %edx,%ebx
80103a60:	75 ee                	jne    80103a50 <initlog+0x60>
80103a62:	83 ec 0c             	sub    $0xc,%esp
80103a65:	50                   	push   %eax
80103a66:	e8 85 c7 ff ff       	call   801001f0 <brelse>
80103a6b:	e8 80 fe ff ff       	call   801038f0 <install_trans>
80103a70:	c7 05 88 3d 11 80 00 	movl   $0x0,0x80113d88
80103a77:	00 00 00 
80103a7a:	e8 11 ff ff ff       	call   80103990 <write_head>
80103a7f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a82:	83 c4 10             	add    $0x10,%esp
80103a85:	c9                   	leave  
80103a86:	c3                   	ret    
80103a87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a8e:	00 
80103a8f:	90                   	nop

80103a90 <begin_op>:
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 14             	sub    $0x14,%esp
80103a96:	68 40 3d 11 80       	push   $0x80113d40
80103a9b:	e8 00 1a 00 00       	call   801054a0 <acquire>
80103aa0:	83 c4 10             	add    $0x10,%esp
80103aa3:	eb 18                	jmp    80103abd <begin_op+0x2d>
80103aa5:	8d 76 00             	lea    0x0(%esi),%esi
80103aa8:	83 ec 08             	sub    $0x8,%esp
80103aab:	68 40 3d 11 80       	push   $0x80113d40
80103ab0:	68 40 3d 11 80       	push   $0x80113d40
80103ab5:	e8 d6 13 00 00       	call   80104e90 <sleep>
80103aba:	83 c4 10             	add    $0x10,%esp
80103abd:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80103ac2:	85 c0                	test   %eax,%eax
80103ac4:	75 e2                	jne    80103aa8 <begin_op+0x18>
80103ac6:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
80103acb:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
80103ad1:	83 c0 01             	add    $0x1,%eax
80103ad4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103ad7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103ada:	83 fa 1e             	cmp    $0x1e,%edx
80103add:	7f c9                	jg     80103aa8 <begin_op+0x18>
80103adf:	83 ec 0c             	sub    $0xc,%esp
80103ae2:	a3 7c 3d 11 80       	mov    %eax,0x80113d7c
80103ae7:	68 40 3d 11 80       	push   $0x80113d40
80103aec:	e8 4f 19 00 00       	call   80105440 <release>
80103af1:	83 c4 10             	add    $0x10,%esp
80103af4:	c9                   	leave  
80103af5:	c3                   	ret    
80103af6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103afd:	00 
80103afe:	66 90                	xchg   %ax,%ax

80103b00 <end_op>:
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	57                   	push   %edi
80103b04:	56                   	push   %esi
80103b05:	53                   	push   %ebx
80103b06:	83 ec 18             	sub    $0x18,%esp
80103b09:	68 40 3d 11 80       	push   $0x80113d40
80103b0e:	e8 8d 19 00 00       	call   801054a0 <acquire>
80103b13:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
80103b18:	8b 35 80 3d 11 80    	mov    0x80113d80,%esi
80103b1e:	83 c4 10             	add    $0x10,%esp
80103b21:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103b24:	89 1d 7c 3d 11 80    	mov    %ebx,0x80113d7c
80103b2a:	85 f6                	test   %esi,%esi
80103b2c:	0f 85 22 01 00 00    	jne    80103c54 <end_op+0x154>
80103b32:	85 db                	test   %ebx,%ebx
80103b34:	0f 85 f6 00 00 00    	jne    80103c30 <end_op+0x130>
80103b3a:	c7 05 80 3d 11 80 01 	movl   $0x1,0x80113d80
80103b41:	00 00 00 
80103b44:	83 ec 0c             	sub    $0xc,%esp
80103b47:	68 40 3d 11 80       	push   $0x80113d40
80103b4c:	e8 ef 18 00 00       	call   80105440 <release>
80103b51:	8b 0d 88 3d 11 80    	mov    0x80113d88,%ecx
80103b57:	83 c4 10             	add    $0x10,%esp
80103b5a:	85 c9                	test   %ecx,%ecx
80103b5c:	7f 42                	jg     80103ba0 <end_op+0xa0>
80103b5e:	83 ec 0c             	sub    $0xc,%esp
80103b61:	68 40 3d 11 80       	push   $0x80113d40
80103b66:	e8 35 19 00 00       	call   801054a0 <acquire>
80103b6b:	c7 05 80 3d 11 80 00 	movl   $0x0,0x80113d80
80103b72:	00 00 00 
80103b75:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103b7c:	e8 df 13 00 00       	call   80104f60 <wakeup>
80103b81:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103b88:	e8 b3 18 00 00       	call   80105440 <release>
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b93:	5b                   	pop    %ebx
80103b94:	5e                   	pop    %esi
80103b95:	5f                   	pop    %edi
80103b96:	5d                   	pop    %ebp
80103b97:	c3                   	ret    
80103b98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b9f:	00 
80103ba0:	a1 74 3d 11 80       	mov    0x80113d74,%eax
80103ba5:	83 ec 08             	sub    $0x8,%esp
80103ba8:	01 d8                	add    %ebx,%eax
80103baa:	83 c0 01             	add    $0x1,%eax
80103bad:	50                   	push   %eax
80103bae:	ff 35 84 3d 11 80    	push   0x80113d84
80103bb4:	e8 17 c5 ff ff       	call   801000d0 <bread>
80103bb9:	89 c6                	mov    %eax,%esi
80103bbb:	58                   	pop    %eax
80103bbc:	5a                   	pop    %edx
80103bbd:	ff 34 9d 8c 3d 11 80 	push   -0x7feec274(,%ebx,4)
80103bc4:	ff 35 84 3d 11 80    	push   0x80113d84
80103bca:	83 c3 01             	add    $0x1,%ebx
80103bcd:	e8 fe c4 ff ff       	call   801000d0 <bread>
80103bd2:	83 c4 0c             	add    $0xc,%esp
80103bd5:	89 c7                	mov    %eax,%edi
80103bd7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103bda:	68 00 02 00 00       	push   $0x200
80103bdf:	50                   	push   %eax
80103be0:	8d 46 5c             	lea    0x5c(%esi),%eax
80103be3:	50                   	push   %eax
80103be4:	e8 07 1a 00 00       	call   801055f0 <memmove>
80103be9:	89 34 24             	mov    %esi,(%esp)
80103bec:	e8 bf c5 ff ff       	call   801001b0 <bwrite>
80103bf1:	89 3c 24             	mov    %edi,(%esp)
80103bf4:	e8 f7 c5 ff ff       	call   801001f0 <brelse>
80103bf9:	89 34 24             	mov    %esi,(%esp)
80103bfc:	e8 ef c5 ff ff       	call   801001f0 <brelse>
80103c01:	83 c4 10             	add    $0x10,%esp
80103c04:	3b 1d 88 3d 11 80    	cmp    0x80113d88,%ebx
80103c0a:	7c 94                	jl     80103ba0 <end_op+0xa0>
80103c0c:	e8 7f fd ff ff       	call   80103990 <write_head>
80103c11:	e8 da fc ff ff       	call   801038f0 <install_trans>
80103c16:	c7 05 88 3d 11 80 00 	movl   $0x0,0x80113d88
80103c1d:	00 00 00 
80103c20:	e8 6b fd ff ff       	call   80103990 <write_head>
80103c25:	e9 34 ff ff ff       	jmp    80103b5e <end_op+0x5e>
80103c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c30:	83 ec 0c             	sub    $0xc,%esp
80103c33:	68 40 3d 11 80       	push   $0x80113d40
80103c38:	e8 23 13 00 00       	call   80104f60 <wakeup>
80103c3d:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103c44:	e8 f7 17 00 00       	call   80105440 <release>
80103c49:	83 c4 10             	add    $0x10,%esp
80103c4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c4f:	5b                   	pop    %ebx
80103c50:	5e                   	pop    %esi
80103c51:	5f                   	pop    %edi
80103c52:	5d                   	pop    %ebp
80103c53:	c3                   	ret    
80103c54:	83 ec 0c             	sub    $0xc,%esp
80103c57:	68 04 8a 10 80       	push   $0x80108a04
80103c5c:	e8 8f c8 ff ff       	call   801004f0 <panic>
80103c61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c68:	00 
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c70 <log_write>:
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	53                   	push   %ebx
80103c74:	83 ec 04             	sub    $0x4,%esp
80103c77:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
80103c7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103c80:	83 fa 1d             	cmp    $0x1d,%edx
80103c83:	7f 7d                	jg     80103d02 <log_write+0x92>
80103c85:	a1 78 3d 11 80       	mov    0x80113d78,%eax
80103c8a:	83 e8 01             	sub    $0x1,%eax
80103c8d:	39 c2                	cmp    %eax,%edx
80103c8f:	7d 71                	jge    80103d02 <log_write+0x92>
80103c91:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
80103c96:	85 c0                	test   %eax,%eax
80103c98:	7e 75                	jle    80103d0f <log_write+0x9f>
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 40 3d 11 80       	push   $0x80113d40
80103ca2:	e8 f9 17 00 00       	call   801054a0 <acquire>
80103ca7:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103caa:	83 c4 10             	add    $0x10,%esp
80103cad:	31 c0                	xor    %eax,%eax
80103caf:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
80103cb5:	85 d2                	test   %edx,%edx
80103cb7:	7f 0e                	jg     80103cc7 <log_write+0x57>
80103cb9:	eb 15                	jmp    80103cd0 <log_write+0x60>
80103cbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cc0:	83 c0 01             	add    $0x1,%eax
80103cc3:	39 c2                	cmp    %eax,%edx
80103cc5:	74 29                	je     80103cf0 <log_write+0x80>
80103cc7:	39 0c 85 8c 3d 11 80 	cmp    %ecx,-0x7feec274(,%eax,4)
80103cce:	75 f0                	jne    80103cc0 <log_write+0x50>
80103cd0:	89 0c 85 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%eax,4)
80103cd7:	39 c2                	cmp    %eax,%edx
80103cd9:	74 1c                	je     80103cf7 <log_write+0x87>
80103cdb:	83 0b 04             	orl    $0x4,(%ebx)
80103cde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ce1:	c7 45 08 40 3d 11 80 	movl   $0x80113d40,0x8(%ebp)
80103ce8:	c9                   	leave  
80103ce9:	e9 52 17 00 00       	jmp    80105440 <release>
80103cee:	66 90                	xchg   %ax,%ax
80103cf0:	89 0c 95 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%edx,4)
80103cf7:	83 c2 01             	add    $0x1,%edx
80103cfa:	89 15 88 3d 11 80    	mov    %edx,0x80113d88
80103d00:	eb d9                	jmp    80103cdb <log_write+0x6b>
80103d02:	83 ec 0c             	sub    $0xc,%esp
80103d05:	68 13 8a 10 80       	push   $0x80108a13
80103d0a:	e8 e1 c7 ff ff       	call   801004f0 <panic>
80103d0f:	83 ec 0c             	sub    $0xc,%esp
80103d12:	68 29 8a 10 80       	push   $0x80108a29
80103d17:	e8 d4 c7 ff ff       	call   801004f0 <panic>
80103d1c:	66 90                	xchg   %ax,%ax
80103d1e:	66 90                	xchg   %ax,%ax

80103d20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	53                   	push   %ebx
80103d24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103d27:	e8 84 09 00 00       	call   801046b0 <cpuid>
80103d2c:	89 c3                	mov    %eax,%ebx
80103d2e:	e8 7d 09 00 00       	call   801046b0 <cpuid>
80103d33:	83 ec 04             	sub    $0x4,%esp
80103d36:	53                   	push   %ebx
80103d37:	50                   	push   %eax
80103d38:	68 44 8a 10 80       	push   $0x80108a44
80103d3d:	e8 2e cd ff ff       	call   80100a70 <cprintf>
  idtinit();       // load idt register
80103d42:	e8 f9 2e 00 00       	call   80106c40 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103d47:	e8 04 09 00 00       	call   80104650 <mycpu>
80103d4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103d4e:	b8 01 00 00 00       	mov    $0x1,%eax
80103d53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103d5a:	e8 e1 0c 00 00       	call   80104a40 <scheduler>
80103d5f:	90                   	nop

80103d60 <mpenter>:
{
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103d66:	e8 e5 3f 00 00       	call   80107d50 <switchkvm>
  seginit();
80103d6b:	e8 50 3f 00 00       	call   80107cc0 <seginit>
  lapicinit();
80103d70:	e8 bb f7 ff ff       	call   80103530 <lapicinit>
  mpmain();
80103d75:	e8 a6 ff ff ff       	call   80103d20 <mpmain>
80103d7a:	66 90                	xchg   %ax,%ax
80103d7c:	66 90                	xchg   %ax,%ax
80103d7e:	66 90                	xchg   %ax,%ax

80103d80 <main>:
{
80103d80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103d84:	83 e4 f0             	and    $0xfffffff0,%esp
80103d87:	ff 71 fc             	push   -0x4(%ecx)
80103d8a:	55                   	push   %ebp
80103d8b:	89 e5                	mov    %esp,%ebp
80103d8d:	53                   	push   %ebx
80103d8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103d8f:	83 ec 08             	sub    $0x8,%esp
80103d92:	68 00 00 40 80       	push   $0x80400000
80103d97:	68 70 98 11 80       	push   $0x80119870
80103d9c:	e8 9f f5 ff ff       	call   80103340 <kinit1>
  kvmalloc();      // kernel page table
80103da1:	e8 9a 44 00 00       	call   80108240 <kvmalloc>
  mpinit();        // detect other processors
80103da6:	e8 85 01 00 00       	call   80103f30 <mpinit>
  lapicinit();     // interrupt controller
80103dab:	e8 80 f7 ff ff       	call   80103530 <lapicinit>
  seginit();       // segment descriptors
80103db0:	e8 0b 3f 00 00       	call   80107cc0 <seginit>
  picinit();       // disable pic
80103db5:	e8 76 03 00 00       	call   80104130 <picinit>
  ioapicinit();    // another interrupt controller
80103dba:	e8 51 f3 ff ff       	call   80103110 <ioapicinit>
  consoleinit();   // console hardware
80103dbf:	e8 bc d9 ff ff       	call   80101780 <consoleinit>
  uartinit();      // serial port
80103dc4:	e8 87 31 00 00       	call   80106f50 <uartinit>
  pinit();         // process table
80103dc9:	e8 62 08 00 00       	call   80104630 <pinit>
  tvinit();        // trap vectors
80103dce:	e8 ed 2d 00 00       	call   80106bc0 <tvinit>
  binit();         // buffer cache
80103dd3:	e8 68 c2 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103dd8:	e8 63 dd ff ff       	call   80101b40 <fileinit>
  ideinit();       // disk 
80103ddd:	e8 1e f1 ff ff       	call   80102f00 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103de2:	83 c4 0c             	add    $0xc,%esp
80103de5:	68 8a 00 00 00       	push   $0x8a
80103dea:	68 ec c4 10 80       	push   $0x8010c4ec
80103def:	68 00 70 00 80       	push   $0x80007000
80103df4:	e8 f7 17 00 00       	call   801055f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	69 05 24 3e 11 80 b0 	imul   $0xb0,0x80113e24,%eax
80103e03:	00 00 00 
80103e06:	05 40 3e 11 80       	add    $0x80113e40,%eax
80103e0b:	3d 40 3e 11 80       	cmp    $0x80113e40,%eax
80103e10:	76 7e                	jbe    80103e90 <main+0x110>
80103e12:	bb 40 3e 11 80       	mov    $0x80113e40,%ebx
80103e17:	eb 20                	jmp    80103e39 <main+0xb9>
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e20:	69 05 24 3e 11 80 b0 	imul   $0xb0,0x80113e24,%eax
80103e27:	00 00 00 
80103e2a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103e30:	05 40 3e 11 80       	add    $0x80113e40,%eax
80103e35:	39 c3                	cmp    %eax,%ebx
80103e37:	73 57                	jae    80103e90 <main+0x110>
    if(c == mycpu())  // We've started already.
80103e39:	e8 12 08 00 00       	call   80104650 <mycpu>
80103e3e:	39 c3                	cmp    %eax,%ebx
80103e40:	74 de                	je     80103e20 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103e42:	e8 69 f5 ff ff       	call   801033b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103e47:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103e4a:	c7 05 f8 6f 00 80 60 	movl   $0x80103d60,0x80006ff8
80103e51:	3d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103e54:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103e5b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e5e:	05 00 10 00 00       	add    $0x1000,%eax
80103e63:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103e68:	0f b6 03             	movzbl (%ebx),%eax
80103e6b:	68 00 70 00 00       	push   $0x7000
80103e70:	50                   	push   %eax
80103e71:	e8 fa f7 ff ff       	call   80103670 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e76:	83 c4 10             	add    $0x10,%esp
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e80:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103e86:	85 c0                	test   %eax,%eax
80103e88:	74 f6                	je     80103e80 <main+0x100>
80103e8a:	eb 94                	jmp    80103e20 <main+0xa0>
80103e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103e90:	83 ec 08             	sub    $0x8,%esp
80103e93:	68 00 00 00 8e       	push   $0x8e000000
80103e98:	68 00 00 40 80       	push   $0x80400000
80103e9d:	e8 3e f4 ff ff       	call   801032e0 <kinit2>
  userinit();      // first user process
80103ea2:	e8 c9 08 00 00       	call   80104770 <userinit>
  mpmain();        // finish this processor's setup
80103ea7:	e8 74 fe ff ff       	call   80103d20 <mpmain>
80103eac:	66 90                	xchg   %ax,%ax
80103eae:	66 90                	xchg   %ax,%ax

80103eb0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	57                   	push   %edi
80103eb4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103eb5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103ebb:	53                   	push   %ebx
  e = addr+len;
80103ebc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103ebf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103ec2:	39 de                	cmp    %ebx,%esi
80103ec4:	72 10                	jb     80103ed6 <mpsearch1+0x26>
80103ec6:	eb 50                	jmp    80103f18 <mpsearch1+0x68>
80103ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ecf:	90                   	nop
80103ed0:	89 fe                	mov    %edi,%esi
80103ed2:	39 fb                	cmp    %edi,%ebx
80103ed4:	76 42                	jbe    80103f18 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103ed6:	83 ec 04             	sub    $0x4,%esp
80103ed9:	8d 7e 10             	lea    0x10(%esi),%edi
80103edc:	6a 04                	push   $0x4
80103ede:	68 58 8a 10 80       	push   $0x80108a58
80103ee3:	56                   	push   %esi
80103ee4:	e8 b7 16 00 00       	call   801055a0 <memcmp>
80103ee9:	83 c4 10             	add    $0x10,%esp
80103eec:	85 c0                	test   %eax,%eax
80103eee:	75 e0                	jne    80103ed0 <mpsearch1+0x20>
80103ef0:	89 f2                	mov    %esi,%edx
80103ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103ef8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103efb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103efe:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103f00:	39 fa                	cmp    %edi,%edx
80103f02:	75 f4                	jne    80103ef8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f04:	84 c0                	test   %al,%al
80103f06:	75 c8                	jne    80103ed0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103f08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f0b:	89 f0                	mov    %esi,%eax
80103f0d:	5b                   	pop    %ebx
80103f0e:	5e                   	pop    %esi
80103f0f:	5f                   	pop    %edi
80103f10:	5d                   	pop    %ebp
80103f11:	c3                   	ret    
80103f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f18:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103f1b:	31 f6                	xor    %esi,%esi
}
80103f1d:	5b                   	pop    %ebx
80103f1e:	89 f0                	mov    %esi,%eax
80103f20:	5e                   	pop    %esi
80103f21:	5f                   	pop    %edi
80103f22:	5d                   	pop    %ebp
80103f23:	c3                   	ret    
80103f24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f2f:	90                   	nop

80103f30 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	57                   	push   %edi
80103f34:	56                   	push   %esi
80103f35:	53                   	push   %ebx
80103f36:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103f39:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103f40:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103f47:	c1 e0 08             	shl    $0x8,%eax
80103f4a:	09 d0                	or     %edx,%eax
80103f4c:	c1 e0 04             	shl    $0x4,%eax
80103f4f:	75 1b                	jne    80103f6c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103f51:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f58:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f5f:	c1 e0 08             	shl    $0x8,%eax
80103f62:	09 d0                	or     %edx,%eax
80103f64:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103f67:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103f6c:	ba 00 04 00 00       	mov    $0x400,%edx
80103f71:	e8 3a ff ff ff       	call   80103eb0 <mpsearch1>
80103f76:	89 c3                	mov    %eax,%ebx
80103f78:	85 c0                	test   %eax,%eax
80103f7a:	0f 84 40 01 00 00    	je     801040c0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f80:	8b 73 04             	mov    0x4(%ebx),%esi
80103f83:	85 f6                	test   %esi,%esi
80103f85:	0f 84 25 01 00 00    	je     801040b0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
80103f8b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103f8e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103f94:	6a 04                	push   $0x4
80103f96:	68 5d 8a 10 80       	push   $0x80108a5d
80103f9b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103f9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103f9f:	e8 fc 15 00 00       	call   801055a0 <memcmp>
80103fa4:	83 c4 10             	add    $0x10,%esp
80103fa7:	85 c0                	test   %eax,%eax
80103fa9:	0f 85 01 01 00 00    	jne    801040b0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103faf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103fb6:	3c 01                	cmp    $0x1,%al
80103fb8:	74 08                	je     80103fc2 <mpinit+0x92>
80103fba:	3c 04                	cmp    $0x4,%al
80103fbc:	0f 85 ee 00 00 00    	jne    801040b0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103fc2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103fc9:	66 85 d2             	test   %dx,%dx
80103fcc:	74 22                	je     80103ff0 <mpinit+0xc0>
80103fce:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103fd1:	89 f0                	mov    %esi,%eax
  sum = 0;
80103fd3:	31 d2                	xor    %edx,%edx
80103fd5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103fd8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103fdf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103fe2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103fe4:	39 c7                	cmp    %eax,%edi
80103fe6:	75 f0                	jne    80103fd8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103fe8:	84 d2                	test   %dl,%dl
80103fea:	0f 85 c0 00 00 00    	jne    801040b0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103ff0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103ff6:	a3 20 3d 11 80       	mov    %eax,0x80113d20
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ffb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80104002:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80104008:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010400d:	03 55 e4             	add    -0x1c(%ebp),%edx
80104010:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80104013:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104017:	90                   	nop
80104018:	39 d0                	cmp    %edx,%eax
8010401a:	73 15                	jae    80104031 <mpinit+0x101>
    switch(*p){
8010401c:	0f b6 08             	movzbl (%eax),%ecx
8010401f:	80 f9 02             	cmp    $0x2,%cl
80104022:	74 4c                	je     80104070 <mpinit+0x140>
80104024:	77 3a                	ja     80104060 <mpinit+0x130>
80104026:	84 c9                	test   %cl,%cl
80104028:	74 56                	je     80104080 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010402a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010402d:	39 d0                	cmp    %edx,%eax
8010402f:	72 eb                	jb     8010401c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104031:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104034:	85 f6                	test   %esi,%esi
80104036:	0f 84 d9 00 00 00    	je     80104115 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010403c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104040:	74 15                	je     80104057 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104042:	b8 70 00 00 00       	mov    $0x70,%eax
80104047:	ba 22 00 00 00       	mov    $0x22,%edx
8010404c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010404d:	ba 23 00 00 00       	mov    $0x23,%edx
80104052:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104053:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104056:	ee                   	out    %al,(%dx)
  }
}
80104057:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010405a:	5b                   	pop    %ebx
8010405b:	5e                   	pop    %esi
8010405c:	5f                   	pop    %edi
8010405d:	5d                   	pop    %ebp
8010405e:	c3                   	ret    
8010405f:	90                   	nop
    switch(*p){
80104060:	83 e9 03             	sub    $0x3,%ecx
80104063:	80 f9 01             	cmp    $0x1,%cl
80104066:	76 c2                	jbe    8010402a <mpinit+0xfa>
80104068:	31 f6                	xor    %esi,%esi
8010406a:	eb ac                	jmp    80104018 <mpinit+0xe8>
8010406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80104070:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104074:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104077:	88 0d 20 3e 11 80    	mov    %cl,0x80113e20
      continue;
8010407d:	eb 99                	jmp    80104018 <mpinit+0xe8>
8010407f:	90                   	nop
      if(ncpu < NCPU) {
80104080:	8b 0d 24 3e 11 80    	mov    0x80113e24,%ecx
80104086:	83 f9 07             	cmp    $0x7,%ecx
80104089:	7f 19                	jg     801040a4 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010408b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80104091:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104095:	83 c1 01             	add    $0x1,%ecx
80104098:	89 0d 24 3e 11 80    	mov    %ecx,0x80113e24
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010409e:	88 9f 40 3e 11 80    	mov    %bl,-0x7feec1c0(%edi)
      p += sizeof(struct mpproc);
801040a4:	83 c0 14             	add    $0x14,%eax
      continue;
801040a7:	e9 6c ff ff ff       	jmp    80104018 <mpinit+0xe8>
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	68 62 8a 10 80       	push   $0x80108a62
801040b8:	e8 33 c4 ff ff       	call   801004f0 <panic>
801040bd:	8d 76 00             	lea    0x0(%esi),%esi
{
801040c0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801040c5:	eb 13                	jmp    801040da <mpinit+0x1aa>
801040c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ce:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801040d0:	89 f3                	mov    %esi,%ebx
801040d2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801040d8:	74 d6                	je     801040b0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801040da:	83 ec 04             	sub    $0x4,%esp
801040dd:	8d 73 10             	lea    0x10(%ebx),%esi
801040e0:	6a 04                	push   $0x4
801040e2:	68 58 8a 10 80       	push   $0x80108a58
801040e7:	53                   	push   %ebx
801040e8:	e8 b3 14 00 00       	call   801055a0 <memcmp>
801040ed:	83 c4 10             	add    $0x10,%esp
801040f0:	85 c0                	test   %eax,%eax
801040f2:	75 dc                	jne    801040d0 <mpinit+0x1a0>
801040f4:	89 da                	mov    %ebx,%edx
801040f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104100:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80104103:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80104106:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104108:	39 d6                	cmp    %edx,%esi
8010410a:	75 f4                	jne    80104100 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010410c:	84 c0                	test   %al,%al
8010410e:	75 c0                	jne    801040d0 <mpinit+0x1a0>
80104110:	e9 6b fe ff ff       	jmp    80103f80 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80104115:	83 ec 0c             	sub    $0xc,%esp
80104118:	68 7c 8a 10 80       	push   $0x80108a7c
8010411d:	e8 ce c3 ff ff       	call   801004f0 <panic>
80104122:	66 90                	xchg   %ax,%ax
80104124:	66 90                	xchg   %ax,%ax
80104126:	66 90                	xchg   %ax,%ax
80104128:	66 90                	xchg   %ax,%ax
8010412a:	66 90                	xchg   %ax,%ax
8010412c:	66 90                	xchg   %ax,%ax
8010412e:	66 90                	xchg   %ax,%ax

80104130 <picinit>:
80104130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104135:	ba 21 00 00 00       	mov    $0x21,%edx
8010413a:	ee                   	out    %al,(%dx)
8010413b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104140:	ee                   	out    %al,(%dx)
80104141:	c3                   	ret    
80104142:	66 90                	xchg   %ax,%ax
80104144:	66 90                	xchg   %ax,%ax
80104146:	66 90                	xchg   %ax,%ax
80104148:	66 90                	xchg   %ax,%ax
8010414a:	66 90                	xchg   %ax,%ax
8010414c:	66 90                	xchg   %ax,%ax
8010414e:	66 90                	xchg   %ax,%ax

80104150 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 0c             	sub    $0xc,%esp
80104159:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010415c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010415f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104165:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010416b:	e8 f0 d9 ff ff       	call   80101b60 <filealloc>
80104170:	89 03                	mov    %eax,(%ebx)
80104172:	85 c0                	test   %eax,%eax
80104174:	0f 84 a8 00 00 00    	je     80104222 <pipealloc+0xd2>
8010417a:	e8 e1 d9 ff ff       	call   80101b60 <filealloc>
8010417f:	89 06                	mov    %eax,(%esi)
80104181:	85 c0                	test   %eax,%eax
80104183:	0f 84 87 00 00 00    	je     80104210 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104189:	e8 22 f2 ff ff       	call   801033b0 <kalloc>
8010418e:	89 c7                	mov    %eax,%edi
80104190:	85 c0                	test   %eax,%eax
80104192:	0f 84 b0 00 00 00    	je     80104248 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80104198:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010419f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801041a2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801041a5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801041ac:	00 00 00 
  p->nwrite = 0;
801041af:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801041b6:	00 00 00 
  p->nread = 0;
801041b9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801041c0:	00 00 00 
  initlock(&p->lock, "pipe");
801041c3:	68 9b 8a 10 80       	push   $0x80108a9b
801041c8:	50                   	push   %eax
801041c9:	e8 02 11 00 00       	call   801052d0 <initlock>
  (*f0)->type = FD_PIPE;
801041ce:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801041d0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801041d3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801041d9:	8b 03                	mov    (%ebx),%eax
801041db:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801041df:	8b 03                	mov    (%ebx),%eax
801041e1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801041e5:	8b 03                	mov    (%ebx),%eax
801041e7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801041ea:	8b 06                	mov    (%esi),%eax
801041ec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801041f2:	8b 06                	mov    (%esi),%eax
801041f4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801041f8:	8b 06                	mov    (%esi),%eax
801041fa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801041fe:	8b 06                	mov    (%esi),%eax
80104200:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104203:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104206:	31 c0                	xor    %eax,%eax
}
80104208:	5b                   	pop    %ebx
80104209:	5e                   	pop    %esi
8010420a:	5f                   	pop    %edi
8010420b:	5d                   	pop    %ebp
8010420c:	c3                   	ret    
8010420d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80104210:	8b 03                	mov    (%ebx),%eax
80104212:	85 c0                	test   %eax,%eax
80104214:	74 1e                	je     80104234 <pipealloc+0xe4>
    fileclose(*f0);
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	50                   	push   %eax
8010421a:	e8 01 da ff ff       	call   80101c20 <fileclose>
8010421f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104222:	8b 06                	mov    (%esi),%eax
80104224:	85 c0                	test   %eax,%eax
80104226:	74 0c                	je     80104234 <pipealloc+0xe4>
    fileclose(*f1);
80104228:	83 ec 0c             	sub    $0xc,%esp
8010422b:	50                   	push   %eax
8010422c:	e8 ef d9 ff ff       	call   80101c20 <fileclose>
80104231:	83 c4 10             	add    $0x10,%esp
}
80104234:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104237:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010423c:	5b                   	pop    %ebx
8010423d:	5e                   	pop    %esi
8010423e:	5f                   	pop    %edi
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104248:	8b 03                	mov    (%ebx),%eax
8010424a:	85 c0                	test   %eax,%eax
8010424c:	75 c8                	jne    80104216 <pipealloc+0xc6>
8010424e:	eb d2                	jmp    80104222 <pipealloc+0xd2>

80104250 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
80104255:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104258:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010425b:	83 ec 0c             	sub    $0xc,%esp
8010425e:	53                   	push   %ebx
8010425f:	e8 3c 12 00 00       	call   801054a0 <acquire>
  if(writable){
80104264:	83 c4 10             	add    $0x10,%esp
80104267:	85 f6                	test   %esi,%esi
80104269:	74 65                	je     801042d0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010426b:	83 ec 0c             	sub    $0xc,%esp
8010426e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104274:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010427b:	00 00 00 
    wakeup(&p->nread);
8010427e:	50                   	push   %eax
8010427f:	e8 dc 0c 00 00       	call   80104f60 <wakeup>
80104284:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104287:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010428d:	85 d2                	test   %edx,%edx
8010428f:	75 0a                	jne    8010429b <pipeclose+0x4b>
80104291:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104297:	85 c0                	test   %eax,%eax
80104299:	74 15                	je     801042b0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010429b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010429e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042a1:	5b                   	pop    %ebx
801042a2:	5e                   	pop    %esi
801042a3:	5d                   	pop    %ebp
    release(&p->lock);
801042a4:	e9 97 11 00 00       	jmp    80105440 <release>
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801042b0:	83 ec 0c             	sub    $0xc,%esp
801042b3:	53                   	push   %ebx
801042b4:	e8 87 11 00 00       	call   80105440 <release>
    kfree((char*)p);
801042b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801042bc:	83 c4 10             	add    $0x10,%esp
}
801042bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c2:	5b                   	pop    %ebx
801042c3:	5e                   	pop    %esi
801042c4:	5d                   	pop    %ebp
    kfree((char*)p);
801042c5:	e9 26 ef ff ff       	jmp    801031f0 <kfree>
801042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801042d0:	83 ec 0c             	sub    $0xc,%esp
801042d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801042d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801042e0:	00 00 00 
    wakeup(&p->nwrite);
801042e3:	50                   	push   %eax
801042e4:	e8 77 0c 00 00       	call   80104f60 <wakeup>
801042e9:	83 c4 10             	add    $0x10,%esp
801042ec:	eb 99                	jmp    80104287 <pipeclose+0x37>
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	83 ec 28             	sub    $0x28,%esp
801042f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801042fc:	53                   	push   %ebx
801042fd:	e8 9e 11 00 00       	call   801054a0 <acquire>
  for(i = 0; i < n; i++){
80104302:	8b 45 10             	mov    0x10(%ebp),%eax
80104305:	83 c4 10             	add    $0x10,%esp
80104308:	85 c0                	test   %eax,%eax
8010430a:	0f 8e c0 00 00 00    	jle    801043d0 <pipewrite+0xe0>
80104310:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104313:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104319:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010431f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104322:	03 45 10             	add    0x10(%ebp),%eax
80104325:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104328:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010432e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104334:	89 ca                	mov    %ecx,%edx
80104336:	05 00 02 00 00       	add    $0x200,%eax
8010433b:	39 c1                	cmp    %eax,%ecx
8010433d:	74 42                	je     80104381 <pipewrite+0x91>
8010433f:	eb 67                	jmp    801043a8 <pipewrite+0xb8>
80104341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104348:	e8 83 03 00 00       	call   801046d0 <myproc>
8010434d:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
80104353:	85 c9                	test   %ecx,%ecx
80104355:	75 34                	jne    8010438b <pipewrite+0x9b>
      wakeup(&p->nread);
80104357:	83 ec 0c             	sub    $0xc,%esp
8010435a:	57                   	push   %edi
8010435b:	e8 00 0c 00 00       	call   80104f60 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104360:	58                   	pop    %eax
80104361:	5a                   	pop    %edx
80104362:	53                   	push   %ebx
80104363:	56                   	push   %esi
80104364:	e8 27 0b 00 00       	call   80104e90 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104369:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010436f:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104375:	83 c4 10             	add    $0x10,%esp
80104378:	05 00 02 00 00       	add    $0x200,%eax
8010437d:	39 c2                	cmp    %eax,%edx
8010437f:	75 27                	jne    801043a8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80104381:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104387:	85 c0                	test   %eax,%eax
80104389:	75 bd                	jne    80104348 <pipewrite+0x58>
        release(&p->lock);
8010438b:	83 ec 0c             	sub    $0xc,%esp
8010438e:	53                   	push   %ebx
8010438f:	e8 ac 10 00 00       	call   80105440 <release>
        return -1;
80104394:	83 c4 10             	add    $0x10,%esp
80104397:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010439c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010439f:	5b                   	pop    %ebx
801043a0:	5e                   	pop    %esi
801043a1:	5f                   	pop    %edi
801043a2:	5d                   	pop    %ebp
801043a3:	c3                   	ret    
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801043a8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801043ab:	8d 4a 01             	lea    0x1(%edx),%ecx
801043ae:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801043b4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801043ba:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801043bd:	83 c6 01             	add    $0x1,%esi
801043c0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801043c3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801043c7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801043ca:	0f 85 58 ff ff ff    	jne    80104328 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801043d0:	83 ec 0c             	sub    $0xc,%esp
801043d3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801043d9:	50                   	push   %eax
801043da:	e8 81 0b 00 00       	call   80104f60 <wakeup>
  release(&p->lock);
801043df:	89 1c 24             	mov    %ebx,(%esp)
801043e2:	e8 59 10 00 00       	call   80105440 <release>
  return n;
801043e7:	8b 45 10             	mov    0x10(%ebp),%eax
801043ea:	83 c4 10             	add    $0x10,%esp
801043ed:	eb ad                	jmp    8010439c <pipewrite+0xac>
801043ef:	90                   	nop

801043f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	57                   	push   %edi
801043f4:	56                   	push   %esi
801043f5:	53                   	push   %ebx
801043f6:	83 ec 18             	sub    $0x18,%esp
801043f9:	8b 75 08             	mov    0x8(%ebp),%esi
801043fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801043ff:	56                   	push   %esi
80104400:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104406:	e8 95 10 00 00       	call   801054a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010440b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104411:	83 c4 10             	add    $0x10,%esp
80104414:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010441a:	74 32                	je     8010444e <piperead+0x5e>
8010441c:	eb 3a                	jmp    80104458 <piperead+0x68>
8010441e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104420:	e8 ab 02 00 00       	call   801046d0 <myproc>
80104425:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010442b:	85 c9                	test   %ecx,%ecx
8010442d:	0f 85 8d 00 00 00    	jne    801044c0 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104433:	83 ec 08             	sub    $0x8,%esp
80104436:	56                   	push   %esi
80104437:	53                   	push   %ebx
80104438:	e8 53 0a 00 00       	call   80104e90 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010443d:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104443:	83 c4 10             	add    $0x10,%esp
80104446:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
8010444c:	75 0a                	jne    80104458 <piperead+0x68>
8010444e:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104454:	85 c0                	test   %eax,%eax
80104456:	75 c8                	jne    80104420 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104458:	8b 55 10             	mov    0x10(%ebp),%edx
8010445b:	31 db                	xor    %ebx,%ebx
8010445d:	85 d2                	test   %edx,%edx
8010445f:	7f 25                	jg     80104486 <piperead+0x96>
80104461:	eb 31                	jmp    80104494 <piperead+0xa4>
80104463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104467:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104468:	8d 48 01             	lea    0x1(%eax),%ecx
8010446b:	25 ff 01 00 00       	and    $0x1ff,%eax
80104470:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80104476:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
8010447b:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010447e:	83 c3 01             	add    $0x1,%ebx
80104481:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80104484:	74 0e                	je     80104494 <piperead+0xa4>
    if(p->nread == p->nwrite)
80104486:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010448c:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104492:	75 d4                	jne    80104468 <piperead+0x78>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104494:	83 ec 0c             	sub    $0xc,%esp
80104497:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
8010449d:	50                   	push   %eax
8010449e:	e8 bd 0a 00 00       	call   80104f60 <wakeup>
  release(&p->lock);
801044a3:	89 34 24             	mov    %esi,(%esp)
801044a6:	e8 95 0f 00 00       	call   80105440 <release>
  return i;
801044ab:	83 c4 10             	add    $0x10,%esp
}
801044ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044b1:	89 d8                	mov    %ebx,%eax
801044b3:	5b                   	pop    %ebx
801044b4:	5e                   	pop    %esi
801044b5:	5f                   	pop    %edi
801044b6:	5d                   	pop    %ebp
801044b7:	c3                   	ret    
801044b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044bf:	90                   	nop
      release(&p->lock);
801044c0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801044c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801044c8:	56                   	push   %esi
801044c9:	e8 72 0f 00 00       	call   80105440 <release>
      return -1;
801044ce:	83 c4 10             	add    $0x10,%esp
}
801044d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044d4:	89 d8                	mov    %ebx,%eax
801044d6:	5b                   	pop    %ebx
801044d7:	5e                   	pop    %esi
801044d8:	5f                   	pop    %edi
801044d9:	5d                   	pop    %ebp
801044da:	c3                   	ret    
801044db:	66 90                	xchg   %ax,%ax
801044dd:	66 90                	xchg   %ax,%ax
801044df:	90                   	nop

801044e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	53                   	push   %ebx
  char *sp;
  
  acquire(&ptable.lock);
  

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044e4:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
{
801044e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801044ec:	68 c0 43 11 80       	push   $0x801143c0
801044f1:	e8 aa 0f 00 00       	call   801054a0 <acquire>
801044f6:	83 c4 10             	add    $0x10,%esp
801044f9:	eb 17                	jmp    80104512 <allocproc+0x32>
801044fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044ff:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104500:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
80104506:	81 fb f4 7f 11 80    	cmp    $0x80117ff4,%ebx
8010450c:	0f 84 96 00 00 00    	je     801045a8 <allocproc+0xc8>
    if(p->state == UNUSED)
80104512:	8b 43 78             	mov    0x78(%ebx),%eax
80104515:	85 c0                	test   %eax,%eax
80104517:	75 e7                	jne    80104500 <allocproc+0x20>
80104519:	89 d8                	mov    %ebx,%eax
8010451b:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010451e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
  return 0;

found:
  for(int i=0; i<MAX_SYSCALLS; i++)
    p->syscalls[i]=0;
80104520:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(int i=0; i<MAX_SYSCALLS; i++)
80104526:	83 c0 04             	add    $0x4,%eax
80104529:	39 c2                	cmp    %eax,%edx
8010452b:	75 f3                	jne    80104520 <allocproc+0x40>
  p->state = EMBRYO;
  p->pid = nextpid++;
8010452d:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80104532:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80104535:	c7 43 78 01 00 00 00 	movl   $0x1,0x78(%ebx)
  p->pid = nextpid++;
8010453c:	89 43 7c             	mov    %eax,0x7c(%ebx)
8010453f:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104542:	68 c0 43 11 80       	push   $0x801143c0
  p->pid = nextpid++;
80104547:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
8010454d:	e8 ee 0e 00 00       	call   80105440 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104552:	e8 59 ee ff ff       	call   801033b0 <kalloc>
80104557:	83 c4 10             	add    $0x10,%esp
8010455a:	89 43 74             	mov    %eax,0x74(%ebx)
8010455d:	85 c0                	test   %eax,%eax
8010455f:	74 60                	je     801045c1 <allocproc+0xe1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104561:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104567:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010456a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010456f:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
  *(uint*)sp = (uint)trapret;
80104575:	c7 40 14 a7 6b 10 80 	movl   $0x80106ba7,0x14(%eax)
  p->context = (struct context*)sp;
8010457c:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104582:	6a 14                	push   $0x14
80104584:	6a 00                	push   $0x0
80104586:	50                   	push   %eax
80104587:	e8 d4 0f 00 00       	call   80105560 <memset>
  p->context->eip = (uint)forkret;
8010458c:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax

  return p;
80104592:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104595:	c7 40 10 e0 45 10 80 	movl   $0x801045e0,0x10(%eax)
}
8010459c:	89 d8                	mov    %ebx,%eax
8010459e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045a1:	c9                   	leave  
801045a2:	c3                   	ret    
801045a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a7:	90                   	nop
  release(&ptable.lock);
801045a8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801045ab:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801045ad:	68 c0 43 11 80       	push   $0x801143c0
801045b2:	e8 89 0e 00 00       	call   80105440 <release>
}
801045b7:	89 d8                	mov    %ebx,%eax
  return 0;
801045b9:	83 c4 10             	add    $0x10,%esp
}
801045bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045bf:	c9                   	leave  
801045c0:	c3                   	ret    
    p->state = UNUSED;
801045c1:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return 0;
801045c8:	31 db                	xor    %ebx,%ebx
}
801045ca:	89 d8                	mov    %ebx,%eax
801045cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045cf:	c9                   	leave  
801045d0:	c3                   	ret    
801045d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045df:	90                   	nop

801045e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801045e6:	68 c0 43 11 80       	push   $0x801143c0
801045eb:	e8 50 0e 00 00       	call   80105440 <release>

  if (first) {
801045f0:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801045f5:	83 c4 10             	add    $0x10,%esp
801045f8:	85 c0                	test   %eax,%eax
801045fa:	75 04                	jne    80104600 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801045fc:	c9                   	leave  
801045fd:	c3                   	ret    
801045fe:	66 90                	xchg   %ax,%ax
    first = 0;
80104600:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80104607:	00 00 00 
    iinit(ROOTDEV);
8010460a:	83 ec 0c             	sub    $0xc,%esp
8010460d:	6a 01                	push   $0x1
8010460f:	e8 7c dc ff ff       	call   80102290 <iinit>
    initlog(ROOTDEV);
80104614:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010461b:	e8 d0 f3 ff ff       	call   801039f0 <initlog>
}
80104620:	83 c4 10             	add    $0x10,%esp
80104623:	c9                   	leave  
80104624:	c3                   	ret    
80104625:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104630 <pinit>:
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104636:	68 a0 8a 10 80       	push   $0x80108aa0
8010463b:	68 c0 43 11 80       	push   $0x801143c0
80104640:	e8 8b 0c 00 00       	call   801052d0 <initlock>
}
80104645:	83 c4 10             	add    $0x10,%esp
80104648:	c9                   	leave  
80104649:	c3                   	ret    
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104650 <mycpu>:
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104655:	9c                   	pushf  
80104656:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104657:	f6 c4 02             	test   $0x2,%ah
8010465a:	75 46                	jne    801046a2 <mycpu+0x52>
  apicid = lapicid();
8010465c:	e8 bf ef ff ff       	call   80103620 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104661:	8b 35 24 3e 11 80    	mov    0x80113e24,%esi
80104667:	85 f6                	test   %esi,%esi
80104669:	7e 2a                	jle    80104695 <mycpu+0x45>
8010466b:	31 d2                	xor    %edx,%edx
8010466d:	eb 08                	jmp    80104677 <mycpu+0x27>
8010466f:	90                   	nop
80104670:	83 c2 01             	add    $0x1,%edx
80104673:	39 f2                	cmp    %esi,%edx
80104675:	74 1e                	je     80104695 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104677:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010467d:	0f b6 99 40 3e 11 80 	movzbl -0x7feec1c0(%ecx),%ebx
80104684:	39 c3                	cmp    %eax,%ebx
80104686:	75 e8                	jne    80104670 <mycpu+0x20>
}
80104688:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010468b:	8d 81 40 3e 11 80    	lea    -0x7feec1c0(%ecx),%eax
}
80104691:	5b                   	pop    %ebx
80104692:	5e                   	pop    %esi
80104693:	5d                   	pop    %ebp
80104694:	c3                   	ret    
  panic("unknown apicid\n");
80104695:	83 ec 0c             	sub    $0xc,%esp
80104698:	68 a7 8a 10 80       	push   $0x80108aa7
8010469d:	e8 4e be ff ff       	call   801004f0 <panic>
    panic("mycpu called with interrupts enabled\n");
801046a2:	83 ec 0c             	sub    $0xc,%esp
801046a5:	68 ac 8b 10 80       	push   $0x80108bac
801046aa:	e8 41 be ff ff       	call   801004f0 <panic>
801046af:	90                   	nop

801046b0 <cpuid>:
cpuid() {
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801046b6:	e8 95 ff ff ff       	call   80104650 <mycpu>
}
801046bb:	c9                   	leave  
  return mycpu()-cpus;
801046bc:	2d 40 3e 11 80       	sub    $0x80113e40,%eax
801046c1:	c1 f8 04             	sar    $0x4,%eax
801046c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801046ca:	c3                   	ret    
801046cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046cf:	90                   	nop

801046d0 <myproc>:
myproc(void) {
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	53                   	push   %ebx
801046d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801046d7:	e8 74 0c 00 00       	call   80105350 <pushcli>
  c = mycpu();
801046dc:	e8 6f ff ff ff       	call   80104650 <mycpu>
  p = c->proc;
801046e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046e7:	e8 b4 0c 00 00       	call   801053a0 <popcli>
}
801046ec:	89 d8                	mov    %ebx,%eax
801046ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046f1:	c9                   	leave  
801046f2:	c3                   	ret    
801046f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104700 <findproc>:
struct proc* findproc(int pid) {
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	8b 75 08             	mov    0x8(%ebp),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104708:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
    acquire(&ptable.lock);
8010470d:	83 ec 0c             	sub    $0xc,%esp
80104710:	68 c0 43 11 80       	push   $0x801143c0
80104715:	e8 86 0d 00 00       	call   801054a0 <acquire>
8010471a:	83 c4 10             	add    $0x10,%esp
8010471d:	eb 0f                	jmp    8010472e <findproc+0x2e>
8010471f:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104720:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
80104726:	81 fb f4 7f 11 80    	cmp    $0x80117ff4,%ebx
8010472c:	74 22                	je     80104750 <findproc+0x50>
        if (p->pid == pid) {
8010472e:	39 73 7c             	cmp    %esi,0x7c(%ebx)
80104731:	75 ed                	jne    80104720 <findproc+0x20>
            release(&ptable.lock);  // Release the lock before returning.
80104733:	83 ec 0c             	sub    $0xc,%esp
80104736:	68 c0 43 11 80       	push   $0x801143c0
8010473b:	e8 00 0d 00 00       	call   80105440 <release>
            return p;
80104740:	83 c4 10             	add    $0x10,%esp
}
80104743:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104746:	89 d8                	mov    %ebx,%eax
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104750:	83 ec 0c             	sub    $0xc,%esp
    return 0;
80104753:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80104755:	68 c0 43 11 80       	push   $0x801143c0
8010475a:	e8 e1 0c 00 00       	call   80105440 <release>
    return 0;
8010475f:	83 c4 10             	add    $0x10,%esp
}
80104762:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104765:	89 d8                	mov    %ebx,%eax
80104767:	5b                   	pop    %ebx
80104768:	5e                   	pop    %esi
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010476f:	90                   	nop

80104770 <userinit>:
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104777:	e8 64 fd ff ff       	call   801044e0 <allocproc>
8010477c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010477e:	a3 f4 7f 11 80       	mov    %eax,0x80117ff4
  if((p->pgdir = setupkvm()) == 0)
80104783:	e8 38 3a 00 00       	call   801081c0 <setupkvm>
80104788:	89 43 70             	mov    %eax,0x70(%ebx)
8010478b:	85 c0                	test   %eax,%eax
8010478d:	0f 84 dc 00 00 00    	je     8010486f <userinit+0xff>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104793:	83 ec 04             	sub    $0x4,%esp
80104796:	68 2c 00 00 00       	push   $0x2c
8010479b:	68 c0 c4 10 80       	push   $0x8010c4c0
801047a0:	50                   	push   %eax
801047a1:	e8 ca 36 00 00       	call   80107e70 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801047a6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801047a9:	c7 43 6c 00 10 00 00 	movl   $0x1000,0x6c(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801047b0:	6a 4c                	push   $0x4c
801047b2:	6a 00                	push   $0x0
801047b4:	ff b3 84 00 00 00    	push   0x84(%ebx)
801047ba:	e8 a1 0d 00 00       	call   80105560 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801047bf:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801047c5:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801047ca:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801047cd:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801047d2:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801047d6:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801047dc:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801047e0:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801047e6:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801047ea:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801047ee:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801047f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801047f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801047fc:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104802:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104809:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010480f:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104816:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010481c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104823:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
80104829:	6a 18                	push   $0x18
8010482b:	68 d0 8a 10 80       	push   $0x80108ad0
80104830:	50                   	push   %eax
80104831:	e8 da 0e 00 00       	call   80105710 <safestrcpy>
  p->cwd = namei("/");
80104836:	c7 04 24 d9 8a 10 80 	movl   $0x80108ad9,(%esp)
8010483d:	e8 9e e5 ff ff       	call   80102de0 <namei>
80104842:	89 83 d4 00 00 00    	mov    %eax,0xd4(%ebx)
  acquire(&ptable.lock);
80104848:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
8010484f:	e8 4c 0c 00 00       	call   801054a0 <acquire>
  p->state = RUNNABLE;
80104854:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  release(&ptable.lock);
8010485b:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104862:	e8 d9 0b 00 00       	call   80105440 <release>
}
80104867:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010486a:	83 c4 10             	add    $0x10,%esp
8010486d:	c9                   	leave  
8010486e:	c3                   	ret    
    panic("userinit: out of memory?");
8010486f:	83 ec 0c             	sub    $0xc,%esp
80104872:	68 b7 8a 10 80       	push   $0x80108ab7
80104877:	e8 74 bc ff ff       	call   801004f0 <panic>
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <growproc>:
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104888:	e8 c3 0a 00 00       	call   80105350 <pushcli>
  c = mycpu();
8010488d:	e8 be fd ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104892:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104898:	e8 03 0b 00 00       	call   801053a0 <popcli>
  sz = curproc->sz;
8010489d:	8b 43 6c             	mov    0x6c(%ebx),%eax
  if(n > 0){
801048a0:	85 f6                	test   %esi,%esi
801048a2:	7f 1c                	jg     801048c0 <growproc+0x40>
  } else if(n < 0){
801048a4:	75 3a                	jne    801048e0 <growproc+0x60>
  switchuvm(curproc);
801048a6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801048a9:	89 43 6c             	mov    %eax,0x6c(%ebx)
  switchuvm(curproc);
801048ac:	53                   	push   %ebx
801048ad:	e8 ae 34 00 00       	call   80107d60 <switchuvm>
  return 0;
801048b2:	83 c4 10             	add    $0x10,%esp
801048b5:	31 c0                	xor    %eax,%eax
}
801048b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048ba:	5b                   	pop    %ebx
801048bb:	5e                   	pop    %esi
801048bc:	5d                   	pop    %ebp
801048bd:	c3                   	ret    
801048be:	66 90                	xchg   %ax,%ax
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801048c0:	83 ec 04             	sub    $0x4,%esp
801048c3:	01 c6                	add    %eax,%esi
801048c5:	56                   	push   %esi
801048c6:	50                   	push   %eax
801048c7:	ff 73 70             	push   0x70(%ebx)
801048ca:	e8 11 37 00 00       	call   80107fe0 <allocuvm>
801048cf:	83 c4 10             	add    $0x10,%esp
801048d2:	85 c0                	test   %eax,%eax
801048d4:	75 d0                	jne    801048a6 <growproc+0x26>
      return -1;
801048d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048db:	eb da                	jmp    801048b7 <growproc+0x37>
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801048e0:	83 ec 04             	sub    $0x4,%esp
801048e3:	01 c6                	add    %eax,%esi
801048e5:	56                   	push   %esi
801048e6:	50                   	push   %eax
801048e7:	ff 73 70             	push   0x70(%ebx)
801048ea:	e8 21 38 00 00       	call   80108110 <deallocuvm>
801048ef:	83 c4 10             	add    $0x10,%esp
801048f2:	85 c0                	test   %eax,%eax
801048f4:	75 b0                	jne    801048a6 <growproc+0x26>
801048f6:	eb de                	jmp    801048d6 <growproc+0x56>
801048f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ff:	90                   	nop

80104900 <fork>:
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	56                   	push   %esi
80104905:	53                   	push   %ebx
80104906:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104909:	e8 42 0a 00 00       	call   80105350 <pushcli>
  c = mycpu();
8010490e:	e8 3d fd ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104913:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104919:	e8 82 0a 00 00       	call   801053a0 <popcli>
  if((np = allocproc()) == 0){
8010491e:	e8 bd fb ff ff       	call   801044e0 <allocproc>
80104923:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104926:	85 c0                	test   %eax,%eax
80104928:	0f 84 d9 00 00 00    	je     80104a07 <fork+0x107>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010492e:	83 ec 08             	sub    $0x8,%esp
80104931:	ff 73 6c             	push   0x6c(%ebx)
80104934:	89 c7                	mov    %eax,%edi
80104936:	ff 73 70             	push   0x70(%ebx)
80104939:	e8 72 39 00 00       	call   801082b0 <copyuvm>
8010493e:	83 c4 10             	add    $0x10,%esp
80104941:	89 47 70             	mov    %eax,0x70(%edi)
80104944:	85 c0                	test   %eax,%eax
80104946:	0f 84 c2 00 00 00    	je     80104a0e <fork+0x10e>
  np->sz = curproc->sz;
8010494c:	8b 43 6c             	mov    0x6c(%ebx),%eax
8010494f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104952:	89 41 6c             	mov    %eax,0x6c(%ecx)
  *np->tf = *curproc->tf;
80104955:	8b b9 84 00 00 00    	mov    0x84(%ecx),%edi
  np->parent = curproc;
8010495b:	89 c8                	mov    %ecx,%eax
8010495d:	89 99 80 00 00 00    	mov    %ebx,0x80(%ecx)
  *np->tf = *curproc->tf;
80104963:	b9 13 00 00 00       	mov    $0x13,%ecx
80104968:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
8010496e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104970:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104972:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104978:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
8010497f:	90                   	nop
    if(curproc->ofile[i])
80104980:	8b 84 b3 94 00 00 00 	mov    0x94(%ebx,%esi,4),%eax
80104987:	85 c0                	test   %eax,%eax
80104989:	74 16                	je     801049a1 <fork+0xa1>
      np->ofile[i] = filedup(curproc->ofile[i]);
8010498b:	83 ec 0c             	sub    $0xc,%esp
8010498e:	50                   	push   %eax
8010498f:	e8 3c d2 ff ff       	call   80101bd0 <filedup>
80104994:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104997:	83 c4 10             	add    $0x10,%esp
8010499a:	89 84 b2 94 00 00 00 	mov    %eax,0x94(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801049a1:	83 c6 01             	add    $0x1,%esi
801049a4:	83 fe 10             	cmp    $0x10,%esi
801049a7:	75 d7                	jne    80104980 <fork+0x80>
  np->cwd = idup(curproc->cwd);
801049a9:	83 ec 0c             	sub    $0xc,%esp
801049ac:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049b2:	81 c3 d8 00 00 00    	add    $0xd8,%ebx
  np->cwd = idup(curproc->cwd);
801049b8:	e8 c3 da ff ff       	call   80102480 <idup>
801049bd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049c0:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801049c3:	89 87 d4 00 00 00    	mov    %eax,0xd4(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049c9:	8d 87 d8 00 00 00    	lea    0xd8(%edi),%eax
801049cf:	6a 18                	push   $0x18
801049d1:	53                   	push   %ebx
801049d2:	50                   	push   %eax
801049d3:	e8 38 0d 00 00       	call   80105710 <safestrcpy>
  pid = np->pid;
801049d8:	8b 5f 7c             	mov    0x7c(%edi),%ebx
  acquire(&ptable.lock);
801049db:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
801049e2:	e8 b9 0a 00 00       	call   801054a0 <acquire>
  np->state = RUNNABLE;
801049e7:	c7 47 78 03 00 00 00 	movl   $0x3,0x78(%edi)
  release(&ptable.lock);
801049ee:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
801049f5:	e8 46 0a 00 00       	call   80105440 <release>
  return pid;
801049fa:	83 c4 10             	add    $0x10,%esp
}
801049fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a00:	89 d8                	mov    %ebx,%eax
80104a02:	5b                   	pop    %ebx
80104a03:	5e                   	pop    %esi
80104a04:	5f                   	pop    %edi
80104a05:	5d                   	pop    %ebp
80104a06:	c3                   	ret    
    return -1;
80104a07:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104a0c:	eb ef                	jmp    801049fd <fork+0xfd>
    kfree(np->kstack);
80104a0e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104a11:	83 ec 0c             	sub    $0xc,%esp
80104a14:	ff 73 74             	push   0x74(%ebx)
80104a17:	e8 d4 e7 ff ff       	call   801031f0 <kfree>
    np->kstack = 0;
80104a1c:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
    return -1;
80104a23:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104a26:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return -1;
80104a2d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104a32:	eb c9                	jmp    801049fd <fork+0xfd>
80104a34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a3f:	90                   	nop

80104a40 <scheduler>:
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	57                   	push   %edi
80104a44:	56                   	push   %esi
80104a45:	53                   	push   %ebx
80104a46:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104a49:	e8 02 fc ff ff       	call   80104650 <mycpu>
  c->proc = 0;
80104a4e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104a55:	00 00 00 
  struct cpu *c = mycpu();
80104a58:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104a5a:	8d 78 04             	lea    0x4(%eax),%edi
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104a60:	fb                   	sti    
    acquire(&ptable.lock);
80104a61:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a64:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
    acquire(&ptable.lock);
80104a69:	68 c0 43 11 80       	push   $0x801143c0
80104a6e:	e8 2d 0a 00 00       	call   801054a0 <acquire>
80104a73:	83 c4 10             	add    $0x10,%esp
80104a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80104a80:	83 7b 78 03          	cmpl   $0x3,0x78(%ebx)
80104a84:	75 36                	jne    80104abc <scheduler+0x7c>
      switchuvm(p);
80104a86:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104a89:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104a8f:	53                   	push   %ebx
80104a90:	e8 cb 32 00 00       	call   80107d60 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104a95:	58                   	pop    %eax
80104a96:	5a                   	pop    %edx
80104a97:	ff b3 88 00 00 00    	push   0x88(%ebx)
80104a9d:	57                   	push   %edi
      p->state = RUNNING;
80104a9e:	c7 43 78 04 00 00 00 	movl   $0x4,0x78(%ebx)
      swtch(&(c->scheduler), p->context);
80104aa5:	e8 c1 0c 00 00       	call   8010576b <swtch>
      switchkvm();
80104aaa:	e8 a1 32 00 00       	call   80107d50 <switchkvm>
      c->proc = 0;
80104aaf:	83 c4 10             	add    $0x10,%esp
80104ab2:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104ab9:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104abc:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
80104ac2:	81 fb f4 7f 11 80    	cmp    $0x80117ff4,%ebx
80104ac8:	75 b6                	jne    80104a80 <scheduler+0x40>
    release(&ptable.lock);
80104aca:	83 ec 0c             	sub    $0xc,%esp
80104acd:	68 c0 43 11 80       	push   $0x801143c0
80104ad2:	e8 69 09 00 00       	call   80105440 <release>
    sti();
80104ad7:	83 c4 10             	add    $0x10,%esp
80104ada:	eb 84                	jmp    80104a60 <scheduler+0x20>
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ae0 <sched>:
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
  pushcli();
80104ae5:	e8 66 08 00 00       	call   80105350 <pushcli>
  c = mycpu();
80104aea:	e8 61 fb ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104aef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104af5:	e8 a6 08 00 00       	call   801053a0 <popcli>
  if(!holding(&ptable.lock))
80104afa:	83 ec 0c             	sub    $0xc,%esp
80104afd:	68 c0 43 11 80       	push   $0x801143c0
80104b02:	e8 f9 08 00 00       	call   80105400 <holding>
80104b07:	83 c4 10             	add    $0x10,%esp
80104b0a:	85 c0                	test   %eax,%eax
80104b0c:	74 52                	je     80104b60 <sched+0x80>
  if(mycpu()->ncli != 1)
80104b0e:	e8 3d fb ff ff       	call   80104650 <mycpu>
80104b13:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104b1a:	75 6b                	jne    80104b87 <sched+0xa7>
  if(p->state == RUNNING)
80104b1c:	83 7b 78 04          	cmpl   $0x4,0x78(%ebx)
80104b20:	74 58                	je     80104b7a <sched+0x9a>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b22:	9c                   	pushf  
80104b23:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b24:	f6 c4 02             	test   $0x2,%ah
80104b27:	75 44                	jne    80104b6d <sched+0x8d>
  intena = mycpu()->intena;
80104b29:	e8 22 fb ff ff       	call   80104650 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104b2e:	81 c3 88 00 00 00    	add    $0x88,%ebx
  intena = mycpu()->intena;
80104b34:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104b3a:	e8 11 fb ff ff       	call   80104650 <mycpu>
80104b3f:	83 ec 08             	sub    $0x8,%esp
80104b42:	ff 70 04             	push   0x4(%eax)
80104b45:	53                   	push   %ebx
80104b46:	e8 20 0c 00 00       	call   8010576b <swtch>
  mycpu()->intena = intena;
80104b4b:	e8 00 fb ff ff       	call   80104650 <mycpu>
}
80104b50:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104b53:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104b59:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b5c:	5b                   	pop    %ebx
80104b5d:	5e                   	pop    %esi
80104b5e:	5d                   	pop    %ebp
80104b5f:	c3                   	ret    
    panic("sched ptable.lock");
80104b60:	83 ec 0c             	sub    $0xc,%esp
80104b63:	68 db 8a 10 80       	push   $0x80108adb
80104b68:	e8 83 b9 ff ff       	call   801004f0 <panic>
    panic("sched interruptible");
80104b6d:	83 ec 0c             	sub    $0xc,%esp
80104b70:	68 07 8b 10 80       	push   $0x80108b07
80104b75:	e8 76 b9 ff ff       	call   801004f0 <panic>
    panic("sched running");
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	68 f9 8a 10 80       	push   $0x80108af9
80104b82:	e8 69 b9 ff ff       	call   801004f0 <panic>
    panic("sched locks");
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 ed 8a 10 80       	push   $0x80108aed
80104b8f:	e8 5c b9 ff ff       	call   801004f0 <panic>
80104b94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b9f:	90                   	nop

80104ba0 <exit>:
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	57                   	push   %edi
80104ba4:	56                   	push   %esi
80104ba5:	53                   	push   %ebx
80104ba6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104ba9:	e8 22 fb ff ff       	call   801046d0 <myproc>
  if(curproc == initproc)
80104bae:	39 05 f4 7f 11 80    	cmp    %eax,0x80117ff4
80104bb4:	0f 84 22 01 00 00    	je     80104cdc <exit+0x13c>
80104bba:	89 c3                	mov    %eax,%ebx
80104bbc:	8d b0 94 00 00 00    	lea    0x94(%eax),%esi
80104bc2:	8d b8 d4 00 00 00    	lea    0xd4(%eax),%edi
80104bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcf:	90                   	nop
    if(curproc->ofile[fd]){
80104bd0:	8b 06                	mov    (%esi),%eax
80104bd2:	85 c0                	test   %eax,%eax
80104bd4:	74 12                	je     80104be8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104bd6:	83 ec 0c             	sub    $0xc,%esp
80104bd9:	50                   	push   %eax
80104bda:	e8 41 d0 ff ff       	call   80101c20 <fileclose>
      curproc->ofile[fd] = 0;
80104bdf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104be5:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104be8:	83 c6 04             	add    $0x4,%esi
80104beb:	39 f7                	cmp    %esi,%edi
80104bed:	75 e1                	jne    80104bd0 <exit+0x30>
  begin_op();
80104bef:	e8 9c ee ff ff       	call   80103a90 <begin_op>
  iput(curproc->cwd);
80104bf4:	83 ec 0c             	sub    $0xc,%esp
80104bf7:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
80104bfd:	e8 de d9 ff ff       	call   801025e0 <iput>
  end_op();
80104c02:	e8 f9 ee ff ff       	call   80103b00 <end_op>
  curproc->cwd = 0;
80104c07:	c7 83 d4 00 00 00 00 	movl   $0x0,0xd4(%ebx)
80104c0e:	00 00 00 
  acquire(&ptable.lock);
80104c11:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104c18:	e8 83 08 00 00       	call   801054a0 <acquire>
  wakeup1(curproc->parent);
80104c1d:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
80104c23:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c26:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
80104c2b:	eb 0f                	jmp    80104c3c <exit+0x9c>
80104c2d:	8d 76 00             	lea    0x0(%esi),%esi
80104c30:	05 f0 00 00 00       	add    $0xf0,%eax
80104c35:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104c3a:	74 21                	je     80104c5d <exit+0xbd>
    if(p->state == SLEEPING && p->chan == chan)
80104c3c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80104c40:	75 ee                	jne    80104c30 <exit+0x90>
80104c42:	3b 90 8c 00 00 00    	cmp    0x8c(%eax),%edx
80104c48:	75 e6                	jne    80104c30 <exit+0x90>
      p->state = RUNNABLE;
80104c4a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c51:	05 f0 00 00 00       	add    $0xf0,%eax
80104c56:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104c5b:	75 df                	jne    80104c3c <exit+0x9c>
      p->parent = initproc;
80104c5d:	8b 0d f4 7f 11 80    	mov    0x80117ff4,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c63:	ba f4 43 11 80       	mov    $0x801143f4,%edx
80104c68:	eb 14                	jmp    80104c7e <exit+0xde>
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c70:	81 c2 f0 00 00 00    	add    $0xf0,%edx
80104c76:	81 fa f4 7f 11 80    	cmp    $0x80117ff4,%edx
80104c7c:	74 45                	je     80104cc3 <exit+0x123>
    if(p->parent == curproc){
80104c7e:	39 9a 80 00 00 00    	cmp    %ebx,0x80(%edx)
80104c84:	75 ea                	jne    80104c70 <exit+0xd0>
      if(p->state == ZOMBIE)
80104c86:	83 7a 78 05          	cmpl   $0x5,0x78(%edx)
      p->parent = initproc;
80104c8a:	89 8a 80 00 00 00    	mov    %ecx,0x80(%edx)
      if(p->state == ZOMBIE)
80104c90:	75 de                	jne    80104c70 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c92:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
80104c97:	eb 13                	jmp    80104cac <exit+0x10c>
80104c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ca0:	05 f0 00 00 00       	add    $0xf0,%eax
80104ca5:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104caa:	74 c4                	je     80104c70 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80104cac:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80104cb0:	75 ee                	jne    80104ca0 <exit+0x100>
80104cb2:	3b 88 8c 00 00 00    	cmp    0x8c(%eax),%ecx
80104cb8:	75 e6                	jne    80104ca0 <exit+0x100>
      p->state = RUNNABLE;
80104cba:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
80104cc1:	eb dd                	jmp    80104ca0 <exit+0x100>
  curproc->state = ZOMBIE;
80104cc3:	c7 43 78 05 00 00 00 	movl   $0x5,0x78(%ebx)
  sched();
80104cca:	e8 11 fe ff ff       	call   80104ae0 <sched>
  panic("zombie exit");
80104ccf:	83 ec 0c             	sub    $0xc,%esp
80104cd2:	68 28 8b 10 80       	push   $0x80108b28
80104cd7:	e8 14 b8 ff ff       	call   801004f0 <panic>
    panic("init exiting");
80104cdc:	83 ec 0c             	sub    $0xc,%esp
80104cdf:	68 1b 8b 10 80       	push   $0x80108b1b
80104ce4:	e8 07 b8 ff ff       	call   801004f0 <panic>
80104ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104cf0 <wait>:
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  pushcli();
80104cf5:	e8 56 06 00 00       	call   80105350 <pushcli>
  c = mycpu();
80104cfa:	e8 51 f9 ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104cff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104d05:	e8 96 06 00 00       	call   801053a0 <popcli>
  acquire(&ptable.lock);
80104d0a:	83 ec 0c             	sub    $0xc,%esp
80104d0d:	68 c0 43 11 80       	push   $0x801143c0
80104d12:	e8 89 07 00 00       	call   801054a0 <acquire>
80104d17:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104d1a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d1c:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
80104d21:	eb 13                	jmp    80104d36 <wait+0x46>
80104d23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d27:	90                   	nop
80104d28:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
80104d2e:	81 fb f4 7f 11 80    	cmp    $0x80117ff4,%ebx
80104d34:	74 21                	je     80104d57 <wait+0x67>
      if(p->parent != curproc)
80104d36:	39 b3 80 00 00 00    	cmp    %esi,0x80(%ebx)
80104d3c:	75 ea                	jne    80104d28 <wait+0x38>
      if(p->state == ZOMBIE){
80104d3e:	83 7b 78 05          	cmpl   $0x5,0x78(%ebx)
80104d42:	74 6c                	je     80104db0 <wait+0xc0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d44:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
      havekids = 1;
80104d4a:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d4f:	81 fb f4 7f 11 80    	cmp    $0x80117ff4,%ebx
80104d55:	75 df                	jne    80104d36 <wait+0x46>
    if(!havekids || curproc->killed){
80104d57:	85 c0                	test   %eax,%eax
80104d59:	0f 84 b0 00 00 00    	je     80104e0f <wait+0x11f>
80104d5f:	8b 86 90 00 00 00    	mov    0x90(%esi),%eax
80104d65:	85 c0                	test   %eax,%eax
80104d67:	0f 85 a2 00 00 00    	jne    80104e0f <wait+0x11f>
  pushcli();
80104d6d:	e8 de 05 00 00       	call   80105350 <pushcli>
  c = mycpu();
80104d72:	e8 d9 f8 ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104d77:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d7d:	e8 1e 06 00 00       	call   801053a0 <popcli>
  if(p == 0)
80104d82:	85 db                	test   %ebx,%ebx
80104d84:	0f 84 9c 00 00 00    	je     80104e26 <wait+0x136>
  p->chan = chan;
80104d8a:	89 b3 8c 00 00 00    	mov    %esi,0x8c(%ebx)
  p->state = SLEEPING;
80104d90:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
80104d97:	e8 44 fd ff ff       	call   80104ae0 <sched>
  p->chan = 0;
80104d9c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80104da3:	00 00 00 
}
80104da6:	e9 6f ff ff ff       	jmp    80104d1a <wait+0x2a>
80104dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104daf:	90                   	nop
        kfree(p->kstack);
80104db0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104db3:	8b 73 7c             	mov    0x7c(%ebx),%esi
        kfree(p->kstack);
80104db6:	ff 73 74             	push   0x74(%ebx)
80104db9:	e8 32 e4 ff ff       	call   801031f0 <kfree>
        p->kstack = 0;
80104dbe:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
        freevm(p->pgdir);
80104dc5:	5a                   	pop    %edx
80104dc6:	ff 73 70             	push   0x70(%ebx)
80104dc9:	e8 72 33 00 00       	call   80108140 <freevm>
        p->pid = 0;
80104dce:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
        p->parent = 0;
80104dd5:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80104ddc:	00 00 00 
        p->name[0] = 0;
80104ddf:	c6 83 d8 00 00 00 00 	movb   $0x0,0xd8(%ebx)
        p->killed = 0;
80104de6:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80104ded:	00 00 00 
        p->state = UNUSED;
80104df0:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
        release(&ptable.lock);
80104df7:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104dfe:	e8 3d 06 00 00       	call   80105440 <release>
        return pid;
80104e03:	83 c4 10             	add    $0x10,%esp
}
80104e06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e09:	89 f0                	mov    %esi,%eax
80104e0b:	5b                   	pop    %ebx
80104e0c:	5e                   	pop    %esi
80104e0d:	5d                   	pop    %ebp
80104e0e:	c3                   	ret    
      release(&ptable.lock);
80104e0f:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104e12:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104e17:	68 c0 43 11 80       	push   $0x801143c0
80104e1c:	e8 1f 06 00 00       	call   80105440 <release>
      return -1;
80104e21:	83 c4 10             	add    $0x10,%esp
80104e24:	eb e0                	jmp    80104e06 <wait+0x116>
    panic("sleep");
80104e26:	83 ec 0c             	sub    $0xc,%esp
80104e29:	68 34 8b 10 80       	push   $0x80108b34
80104e2e:	e8 bd b6 ff ff       	call   801004f0 <panic>
80104e33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e40 <yield>:
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104e47:	68 c0 43 11 80       	push   $0x801143c0
80104e4c:	e8 4f 06 00 00       	call   801054a0 <acquire>
  pushcli();
80104e51:	e8 fa 04 00 00       	call   80105350 <pushcli>
  c = mycpu();
80104e56:	e8 f5 f7 ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104e5b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e61:	e8 3a 05 00 00       	call   801053a0 <popcli>
  myproc()->state = RUNNABLE;
80104e66:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  sched();
80104e6d:	e8 6e fc ff ff       	call   80104ae0 <sched>
  release(&ptable.lock);
80104e72:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104e79:	e8 c2 05 00 00       	call   80105440 <release>
}
80104e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e81:	83 c4 10             	add    $0x10,%esp
80104e84:	c9                   	leave  
80104e85:	c3                   	ret    
80104e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e8d:	8d 76 00             	lea    0x0(%esi),%esi

80104e90 <sleep>:
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	56                   	push   %esi
80104e95:	53                   	push   %ebx
80104e96:	83 ec 0c             	sub    $0xc,%esp
80104e99:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104e9f:	e8 ac 04 00 00       	call   80105350 <pushcli>
  c = mycpu();
80104ea4:	e8 a7 f7 ff ff       	call   80104650 <mycpu>
  p = c->proc;
80104ea9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104eaf:	e8 ec 04 00 00       	call   801053a0 <popcli>
  if(p == 0)
80104eb4:	85 db                	test   %ebx,%ebx
80104eb6:	0f 84 95 00 00 00    	je     80104f51 <sleep+0xc1>
  if(lk == 0)
80104ebc:	85 f6                	test   %esi,%esi
80104ebe:	0f 84 80 00 00 00    	je     80104f44 <sleep+0xb4>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104ec4:	81 fe c0 43 11 80    	cmp    $0x801143c0,%esi
80104eca:	74 54                	je     80104f20 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104ecc:	83 ec 0c             	sub    $0xc,%esp
80104ecf:	68 c0 43 11 80       	push   $0x801143c0
80104ed4:	e8 c7 05 00 00       	call   801054a0 <acquire>
    release(lk);
80104ed9:	89 34 24             	mov    %esi,(%esp)
80104edc:	e8 5f 05 00 00       	call   80105440 <release>
  p->chan = chan;
80104ee1:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
80104ee7:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
80104eee:	e8 ed fb ff ff       	call   80104ae0 <sched>
  p->chan = 0;
80104ef3:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80104efa:	00 00 00 
    release(&ptable.lock);
80104efd:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104f04:	e8 37 05 00 00       	call   80105440 <release>
    acquire(lk);
80104f09:	89 75 08             	mov    %esi,0x8(%ebp)
80104f0c:	83 c4 10             	add    $0x10,%esp
}
80104f0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f12:	5b                   	pop    %ebx
80104f13:	5e                   	pop    %esi
80104f14:	5f                   	pop    %edi
80104f15:	5d                   	pop    %ebp
    acquire(lk);
80104f16:	e9 85 05 00 00       	jmp    801054a0 <acquire>
80104f1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f1f:	90                   	nop
  p->chan = chan;
80104f20:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
80104f26:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
80104f2d:	e8 ae fb ff ff       	call   80104ae0 <sched>
  p->chan = 0;
80104f32:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80104f39:	00 00 00 
}
80104f3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f3f:	5b                   	pop    %ebx
80104f40:	5e                   	pop    %esi
80104f41:	5f                   	pop    %edi
80104f42:	5d                   	pop    %ebp
80104f43:	c3                   	ret    
    panic("sleep without lk");
80104f44:	83 ec 0c             	sub    $0xc,%esp
80104f47:	68 3a 8b 10 80       	push   $0x80108b3a
80104f4c:	e8 9f b5 ff ff       	call   801004f0 <panic>
    panic("sleep");
80104f51:	83 ec 0c             	sub    $0xc,%esp
80104f54:	68 34 8b 10 80       	push   $0x80108b34
80104f59:	e8 92 b5 ff ff       	call   801004f0 <panic>
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	53                   	push   %ebx
80104f64:	83 ec 10             	sub    $0x10,%esp
80104f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f6a:	68 c0 43 11 80       	push   $0x801143c0
80104f6f:	e8 2c 05 00 00       	call   801054a0 <acquire>
80104f74:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f77:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
80104f7c:	eb 0e                	jmp    80104f8c <wakeup+0x2c>
80104f7e:	66 90                	xchg   %ax,%ax
80104f80:	05 f0 00 00 00       	add    $0xf0,%eax
80104f85:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104f8a:	74 21                	je     80104fad <wakeup+0x4d>
    if(p->state == SLEEPING && p->chan == chan)
80104f8c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80104f90:	75 ee                	jne    80104f80 <wakeup+0x20>
80104f92:	3b 98 8c 00 00 00    	cmp    0x8c(%eax),%ebx
80104f98:	75 e6                	jne    80104f80 <wakeup+0x20>
      p->state = RUNNABLE;
80104f9a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fa1:	05 f0 00 00 00       	add    $0xf0,%eax
80104fa6:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104fab:	75 df                	jne    80104f8c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
80104fad:	c7 45 08 c0 43 11 80 	movl   $0x801143c0,0x8(%ebp)
}
80104fb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb7:	c9                   	leave  
  release(&ptable.lock);
80104fb8:	e9 83 04 00 00       	jmp    80105440 <release>
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi

80104fc0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	53                   	push   %ebx
80104fc4:	83 ec 10             	sub    $0x10,%esp
80104fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104fca:	68 c0 43 11 80       	push   $0x801143c0
80104fcf:	e8 cc 04 00 00       	call   801054a0 <acquire>
80104fd4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fd7:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
80104fdc:	eb 0e                	jmp    80104fec <kill+0x2c>
80104fde:	66 90                	xchg   %ax,%ax
80104fe0:	05 f0 00 00 00       	add    $0xf0,%eax
80104fe5:	3d f4 7f 11 80       	cmp    $0x80117ff4,%eax
80104fea:	74 34                	je     80105020 <kill+0x60>
    if(p->pid == pid){
80104fec:	39 58 7c             	cmp    %ebx,0x7c(%eax)
80104fef:	75 ef                	jne    80104fe0 <kill+0x20>
      p->killed = 1;
80104ff1:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
80104ff8:	00 00 00 
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104ffb:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80104fff:	75 07                	jne    80105008 <kill+0x48>
        p->state = RUNNABLE;
80105001:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
      release(&ptable.lock);
80105008:	83 ec 0c             	sub    $0xc,%esp
8010500b:	68 c0 43 11 80       	push   $0x801143c0
80105010:	e8 2b 04 00 00       	call   80105440 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80105015:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80105018:	83 c4 10             	add    $0x10,%esp
8010501b:	31 c0                	xor    %eax,%eax
}
8010501d:	c9                   	leave  
8010501e:	c3                   	ret    
8010501f:	90                   	nop
  release(&ptable.lock);
80105020:	83 ec 0c             	sub    $0xc,%esp
80105023:	68 c0 43 11 80       	push   $0x801143c0
80105028:	e8 13 04 00 00       	call   80105440 <release>
}
8010502d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80105030:	83 c4 10             	add    $0x10,%esp
80105033:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105038:	c9                   	leave  
80105039:	c3                   	ret    
8010503a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105040 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	57                   	push   %edi
80105044:	56                   	push   %esi
80105045:	8d 75 e8             	lea    -0x18(%ebp),%esi
80105048:	53                   	push   %ebx
80105049:	bb cc 44 11 80       	mov    $0x801144cc,%ebx
8010504e:	83 ec 3c             	sub    $0x3c,%esp
80105051:	eb 27                	jmp    8010507a <procdump+0x3a>
80105053:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105057:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105058:	83 ec 0c             	sub    $0xc,%esp
8010505b:	68 d3 8f 10 80       	push   $0x80108fd3
80105060:	e8 0b ba ff ff       	call   80100a70 <cprintf>
80105065:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105068:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
8010506e:	81 fb cc 80 11 80    	cmp    $0x801180cc,%ebx
80105074:	0f 84 7e 00 00 00    	je     801050f8 <procdump+0xb8>
    if(p->state == UNUSED)
8010507a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010507d:	85 c0                	test   %eax,%eax
8010507f:	74 e7                	je     80105068 <procdump+0x28>
      state = "???";
80105081:	ba 4b 8b 10 80       	mov    $0x80108b4b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105086:	83 f8 05             	cmp    $0x5,%eax
80105089:	77 11                	ja     8010509c <procdump+0x5c>
8010508b:	8b 14 85 f4 8b 10 80 	mov    -0x7fef740c(,%eax,4),%edx
      state = "???";
80105092:	b8 4b 8b 10 80       	mov    $0x80108b4b,%eax
80105097:	85 d2                	test   %edx,%edx
80105099:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010509c:	53                   	push   %ebx
8010509d:	52                   	push   %edx
8010509e:	ff 73 a4             	push   -0x5c(%ebx)
801050a1:	68 4f 8b 10 80       	push   $0x80108b4f
801050a6:	e8 c5 b9 ff ff       	call   80100a70 <cprintf>
    if(p->state == SLEEPING){
801050ab:	83 c4 10             	add    $0x10,%esp
801050ae:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801050b2:	75 a4                	jne    80105058 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801050b4:	83 ec 08             	sub    $0x8,%esp
801050b7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801050ba:	8d 7d c0             	lea    -0x40(%ebp),%edi
801050bd:	50                   	push   %eax
801050be:	8b 43 b0             	mov    -0x50(%ebx),%eax
801050c1:	8b 40 0c             	mov    0xc(%eax),%eax
801050c4:	83 c0 08             	add    $0x8,%eax
801050c7:	50                   	push   %eax
801050c8:	e8 23 02 00 00       	call   801052f0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801050cd:	83 c4 10             	add    $0x10,%esp
801050d0:	8b 17                	mov    (%edi),%edx
801050d2:	85 d2                	test   %edx,%edx
801050d4:	74 82                	je     80105058 <procdump+0x18>
        cprintf(" %p", pc[i]);
801050d6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801050d9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801050dc:	52                   	push   %edx
801050dd:	68 61 85 10 80       	push   $0x80108561
801050e2:	e8 89 b9 ff ff       	call   80100a70 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801050e7:	83 c4 10             	add    $0x10,%esp
801050ea:	39 fe                	cmp    %edi,%esi
801050ec:	75 e2                	jne    801050d0 <procdump+0x90>
801050ee:	e9 65 ff ff ff       	jmp    80105058 <procdump+0x18>
801050f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050f7:	90                   	nop
  }
}
801050f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050fb:	5b                   	pop    %ebx
801050fc:	5e                   	pop    %esi
801050fd:	5f                   	pop    %edi
801050fe:	5d                   	pop    %ebp
801050ff:	c3                   	ret    

80105100 <list_active_processes>:


int list_active_processes(void) {
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	53                   	push   %ebx
80105104:	bb 60 44 11 80       	mov    $0x80114460,%ebx
80105109:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;
    acquire(&ptable.lock);
8010510c:	68 c0 43 11 80       	push   $0x801143c0
80105111:	e8 8a 03 00 00       	call   801054a0 <acquire>

    cprintf("PID\tName\t\tNumber of syscalls:\n");
80105116:	c7 04 24 d4 8b 10 80 	movl   $0x80108bd4,(%esp)
8010511d:	e8 4e b9 ff ff       	call   80100a70 <cprintf>
    cprintf("---------------------------\n");
80105122:	c7 04 24 58 8b 10 80 	movl   $0x80108b58,(%esp)
80105129:	e8 42 b9 ff ff       	call   80100a70 <cprintf>

    // Iterate over the process table
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010512e:	83 c4 10             	add    $0x10,%esp
80105131:	eb 13                	jmp    80105146 <list_active_processes+0x46>
80105133:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105137:	90                   	nop
80105138:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
8010513e:	81 fb 60 80 11 80    	cmp    $0x80118060,%ebx
80105144:	74 41                	je     80105187 <list_active_processes+0x87>
        if (p->state != UNUSED) {  // Only list active processes
80105146:	8b 43 0c             	mov    0xc(%ebx),%eax
80105149:	85 c0                	test   %eax,%eax
8010514b:	74 eb                	je     80105138 <list_active_processes+0x38>
8010514d:	8d 43 94             	lea    -0x6c(%ebx),%eax
            int num_of_syscalls = 0;
80105150:	31 d2                	xor    %edx,%edx
80105152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            for(int i=0; i<MAX_SYSCALLS; i++)
              num_of_syscalls+=p->syscalls[i];
80105158:	03 10                	add    (%eax),%edx
            for(int i=0; i<MAX_SYSCALLS; i++)
8010515a:	83 c0 04             	add    $0x4,%eax
8010515d:	39 d8                	cmp    %ebx,%eax
8010515f:	75 f7                	jne    80105158 <list_active_processes+0x58>
            cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
80105161:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105164:	52                   	push   %edx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105165:	81 c3 f0 00 00 00    	add    $0xf0,%ebx
            cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
8010516b:	50                   	push   %eax
8010516c:	ff b3 20 ff ff ff    	push   -0xe0(%ebx)
80105172:	68 75 8b 10 80       	push   $0x80108b75
80105177:	e8 f4 b8 ff ff       	call   80100a70 <cprintf>
8010517c:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010517f:	81 fb 60 80 11 80    	cmp    $0x80118060,%ebx
80105185:	75 bf                	jne    80105146 <list_active_processes+0x46>
        }
    }

    // Release the process table lock
    release(&ptable.lock);
80105187:	83 ec 0c             	sub    $0xc,%esp
8010518a:	68 c0 43 11 80       	push   $0x801143c0
8010518f:	e8 ac 02 00 00       	call   80105440 <release>

    return 0;  // Return 0 to indicate success
80105194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105197:	31 c0                	xor    %eax,%eax
80105199:	c9                   	leave  
8010519a:	c3                   	ret    
8010519b:	66 90                	xchg   %ax,%ax
8010519d:	66 90                	xchg   %ax,%ax
8010519f:	90                   	nop

801051a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	53                   	push   %ebx
801051a4:	83 ec 0c             	sub    $0xc,%esp
801051a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801051aa:	68 0c 8c 10 80       	push   $0x80108c0c
801051af:	8d 43 04             	lea    0x4(%ebx),%eax
801051b2:	50                   	push   %eax
801051b3:	e8 18 01 00 00       	call   801052d0 <initlock>
  lk->name = name;
801051b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801051bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801051c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801051c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801051cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801051ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051d1:	c9                   	leave  
801051d2:	c3                   	ret    
801051d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	56                   	push   %esi
801051e4:	53                   	push   %ebx
801051e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801051e8:	8d 73 04             	lea    0x4(%ebx),%esi
801051eb:	83 ec 0c             	sub    $0xc,%esp
801051ee:	56                   	push   %esi
801051ef:	e8 ac 02 00 00       	call   801054a0 <acquire>
  while (lk->locked) {
801051f4:	8b 13                	mov    (%ebx),%edx
801051f6:	83 c4 10             	add    $0x10,%esp
801051f9:	85 d2                	test   %edx,%edx
801051fb:	74 16                	je     80105213 <acquiresleep+0x33>
801051fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105200:	83 ec 08             	sub    $0x8,%esp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
80105205:	e8 86 fc ff ff       	call   80104e90 <sleep>
  while (lk->locked) {
8010520a:	8b 03                	mov    (%ebx),%eax
8010520c:	83 c4 10             	add    $0x10,%esp
8010520f:	85 c0                	test   %eax,%eax
80105211:	75 ed                	jne    80105200 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105213:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105219:	e8 b2 f4 ff ff       	call   801046d0 <myproc>
8010521e:	8b 40 7c             	mov    0x7c(%eax),%eax
80105221:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105224:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105227:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010522a:	5b                   	pop    %ebx
8010522b:	5e                   	pop    %esi
8010522c:	5d                   	pop    %ebp
  release(&lk->lk);
8010522d:	e9 0e 02 00 00       	jmp    80105440 <release>
80105232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105240 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	56                   	push   %esi
80105244:	53                   	push   %ebx
80105245:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105248:	8d 73 04             	lea    0x4(%ebx),%esi
8010524b:	83 ec 0c             	sub    $0xc,%esp
8010524e:	56                   	push   %esi
8010524f:	e8 4c 02 00 00       	call   801054a0 <acquire>
  lk->locked = 0;
80105254:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010525a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105261:	89 1c 24             	mov    %ebx,(%esp)
80105264:	e8 f7 fc ff ff       	call   80104f60 <wakeup>
  release(&lk->lk);
80105269:	89 75 08             	mov    %esi,0x8(%ebp)
8010526c:	83 c4 10             	add    $0x10,%esp
}
8010526f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105272:	5b                   	pop    %ebx
80105273:	5e                   	pop    %esi
80105274:	5d                   	pop    %ebp
  release(&lk->lk);
80105275:	e9 c6 01 00 00       	jmp    80105440 <release>
8010527a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105280 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	57                   	push   %edi
80105284:	31 ff                	xor    %edi,%edi
80105286:	56                   	push   %esi
80105287:	53                   	push   %ebx
80105288:	83 ec 18             	sub    $0x18,%esp
8010528b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010528e:	8d 73 04             	lea    0x4(%ebx),%esi
80105291:	56                   	push   %esi
80105292:	e8 09 02 00 00       	call   801054a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105297:	8b 03                	mov    (%ebx),%eax
80105299:	83 c4 10             	add    $0x10,%esp
8010529c:	85 c0                	test   %eax,%eax
8010529e:	75 18                	jne    801052b8 <holdingsleep+0x38>
  release(&lk->lk);
801052a0:	83 ec 0c             	sub    $0xc,%esp
801052a3:	56                   	push   %esi
801052a4:	e8 97 01 00 00       	call   80105440 <release>
  return r;
}
801052a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052ac:	89 f8                	mov    %edi,%eax
801052ae:	5b                   	pop    %ebx
801052af:	5e                   	pop    %esi
801052b0:	5f                   	pop    %edi
801052b1:	5d                   	pop    %ebp
801052b2:	c3                   	ret    
801052b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052b7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
801052b8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801052bb:	e8 10 f4 ff ff       	call   801046d0 <myproc>
801052c0:	39 58 7c             	cmp    %ebx,0x7c(%eax)
801052c3:	0f 94 c0             	sete   %al
801052c6:	0f b6 c0             	movzbl %al,%eax
801052c9:	89 c7                	mov    %eax,%edi
801052cb:	eb d3                	jmp    801052a0 <holdingsleep+0x20>
801052cd:	66 90                	xchg   %ax,%ax
801052cf:	90                   	nop

801052d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801052d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801052d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801052df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801052e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801052e9:	5d                   	pop    %ebp
801052ea:	c3                   	ret    
801052eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052ef:	90                   	nop

801052f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801052f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801052f1:	31 d2                	xor    %edx,%edx
{
801052f3:	89 e5                	mov    %esp,%ebp
801052f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801052f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801052f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801052fc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801052ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105300:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105306:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010530c:	77 1a                	ja     80105328 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010530e:	8b 58 04             	mov    0x4(%eax),%ebx
80105311:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105314:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105317:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105319:	83 fa 0a             	cmp    $0xa,%edx
8010531c:	75 e2                	jne    80105300 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010531e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105321:	c9                   	leave  
80105322:	c3                   	ret    
80105323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105327:	90                   	nop
  for(; i < 10; i++)
80105328:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010532b:	8d 51 28             	lea    0x28(%ecx),%edx
8010532e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105330:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105336:	83 c0 04             	add    $0x4,%eax
80105339:	39 d0                	cmp    %edx,%eax
8010533b:	75 f3                	jne    80105330 <getcallerpcs+0x40>
}
8010533d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105340:	c9                   	leave  
80105341:	c3                   	ret    
80105342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105350 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	53                   	push   %ebx
80105354:	83 ec 04             	sub    $0x4,%esp
80105357:	9c                   	pushf  
80105358:	5b                   	pop    %ebx
  asm volatile("cli");
80105359:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010535a:	e8 f1 f2 ff ff       	call   80104650 <mycpu>
8010535f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105365:	85 c0                	test   %eax,%eax
80105367:	74 17                	je     80105380 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105369:	e8 e2 f2 ff ff       	call   80104650 <mycpu>
8010536e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105378:	c9                   	leave  
80105379:	c3                   	ret    
8010537a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105380:	e8 cb f2 ff ff       	call   80104650 <mycpu>
80105385:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010538b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105391:	eb d6                	jmp    80105369 <pushcli+0x19>
80105393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010539a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801053a0 <popcli>:

void
popcli(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801053a6:	9c                   	pushf  
801053a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801053a8:	f6 c4 02             	test   $0x2,%ah
801053ab:	75 35                	jne    801053e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801053ad:	e8 9e f2 ff ff       	call   80104650 <mycpu>
801053b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801053b9:	78 34                	js     801053ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801053bb:	e8 90 f2 ff ff       	call   80104650 <mycpu>
801053c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801053c6:	85 d2                	test   %edx,%edx
801053c8:	74 06                	je     801053d0 <popcli+0x30>
    sti();
}
801053ca:	c9                   	leave  
801053cb:	c3                   	ret    
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801053d0:	e8 7b f2 ff ff       	call   80104650 <mycpu>
801053d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801053db:	85 c0                	test   %eax,%eax
801053dd:	74 eb                	je     801053ca <popcli+0x2a>
  asm volatile("sti");
801053df:	fb                   	sti    
}
801053e0:	c9                   	leave  
801053e1:	c3                   	ret    
    panic("popcli - interruptible");
801053e2:	83 ec 0c             	sub    $0xc,%esp
801053e5:	68 17 8c 10 80       	push   $0x80108c17
801053ea:	e8 01 b1 ff ff       	call   801004f0 <panic>
    panic("popcli");
801053ef:	83 ec 0c             	sub    $0xc,%esp
801053f2:	68 2e 8c 10 80       	push   $0x80108c2e
801053f7:	e8 f4 b0 ff ff       	call   801004f0 <panic>
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105400 <holding>:
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
80105405:	8b 75 08             	mov    0x8(%ebp),%esi
80105408:	31 db                	xor    %ebx,%ebx
  pushcli();
8010540a:	e8 41 ff ff ff       	call   80105350 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010540f:	8b 06                	mov    (%esi),%eax
80105411:	85 c0                	test   %eax,%eax
80105413:	75 0b                	jne    80105420 <holding+0x20>
  popcli();
80105415:	e8 86 ff ff ff       	call   801053a0 <popcli>
}
8010541a:	89 d8                	mov    %ebx,%eax
8010541c:	5b                   	pop    %ebx
8010541d:	5e                   	pop    %esi
8010541e:	5d                   	pop    %ebp
8010541f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105420:	8b 5e 08             	mov    0x8(%esi),%ebx
80105423:	e8 28 f2 ff ff       	call   80104650 <mycpu>
80105428:	39 c3                	cmp    %eax,%ebx
8010542a:	0f 94 c3             	sete   %bl
  popcli();
8010542d:	e8 6e ff ff ff       	call   801053a0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105432:	0f b6 db             	movzbl %bl,%ebx
}
80105435:	89 d8                	mov    %ebx,%eax
80105437:	5b                   	pop    %ebx
80105438:	5e                   	pop    %esi
80105439:	5d                   	pop    %ebp
8010543a:	c3                   	ret    
8010543b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010543f:	90                   	nop

80105440 <release>:
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	56                   	push   %esi
80105444:	53                   	push   %ebx
80105445:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105448:	e8 03 ff ff ff       	call   80105350 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010544d:	8b 03                	mov    (%ebx),%eax
8010544f:	85 c0                	test   %eax,%eax
80105451:	75 15                	jne    80105468 <release+0x28>
  popcli();
80105453:	e8 48 ff ff ff       	call   801053a0 <popcli>
    panic("release");
80105458:	83 ec 0c             	sub    $0xc,%esp
8010545b:	68 35 8c 10 80       	push   $0x80108c35
80105460:	e8 8b b0 ff ff       	call   801004f0 <panic>
80105465:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105468:	8b 73 08             	mov    0x8(%ebx),%esi
8010546b:	e8 e0 f1 ff ff       	call   80104650 <mycpu>
80105470:	39 c6                	cmp    %eax,%esi
80105472:	75 df                	jne    80105453 <release+0x13>
  popcli();
80105474:	e8 27 ff ff ff       	call   801053a0 <popcli>
  lk->pcs[0] = 0;
80105479:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105480:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105487:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010548c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105492:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105495:	5b                   	pop    %ebx
80105496:	5e                   	pop    %esi
80105497:	5d                   	pop    %ebp
  popcli();
80105498:	e9 03 ff ff ff       	jmp    801053a0 <popcli>
8010549d:	8d 76 00             	lea    0x0(%esi),%esi

801054a0 <acquire>:
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801054a7:	e8 a4 fe ff ff       	call   80105350 <pushcli>
  if(holding(lk))
801054ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801054af:	e8 9c fe ff ff       	call   80105350 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801054b4:	8b 03                	mov    (%ebx),%eax
801054b6:	85 c0                	test   %eax,%eax
801054b8:	75 7e                	jne    80105538 <acquire+0x98>
  popcli();
801054ba:	e8 e1 fe ff ff       	call   801053a0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801054bf:	b9 01 00 00 00       	mov    $0x1,%ecx
801054c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
801054c8:	8b 55 08             	mov    0x8(%ebp),%edx
801054cb:	89 c8                	mov    %ecx,%eax
801054cd:	f0 87 02             	lock xchg %eax,(%edx)
801054d0:	85 c0                	test   %eax,%eax
801054d2:	75 f4                	jne    801054c8 <acquire+0x28>
  __sync_synchronize();
801054d4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801054d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801054dc:	e8 6f f1 ff ff       	call   80104650 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801054e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
801054e4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801054e6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801054e9:	31 c0                	xor    %eax,%eax
801054eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801054f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801054f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801054fc:	77 1a                	ja     80105518 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801054fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80105501:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105505:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105508:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010550a:	83 f8 0a             	cmp    $0xa,%eax
8010550d:	75 e1                	jne    801054f0 <acquire+0x50>
}
8010550f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105512:	c9                   	leave  
80105513:	c3                   	ret    
80105514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105518:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010551c:	8d 51 34             	lea    0x34(%ecx),%edx
8010551f:	90                   	nop
    pcs[i] = 0;
80105520:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105526:	83 c0 04             	add    $0x4,%eax
80105529:	39 c2                	cmp    %eax,%edx
8010552b:	75 f3                	jne    80105520 <acquire+0x80>
}
8010552d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105530:	c9                   	leave  
80105531:	c3                   	ret    
80105532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105538:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010553b:	e8 10 f1 ff ff       	call   80104650 <mycpu>
80105540:	39 c3                	cmp    %eax,%ebx
80105542:	0f 85 72 ff ff ff    	jne    801054ba <acquire+0x1a>
  popcli();
80105548:	e8 53 fe ff ff       	call   801053a0 <popcli>
    panic("acquire");
8010554d:	83 ec 0c             	sub    $0xc,%esp
80105550:	68 3d 8c 10 80       	push   $0x80108c3d
80105555:	e8 96 af ff ff       	call   801004f0 <panic>
8010555a:	66 90                	xchg   %ax,%ax
8010555c:	66 90                	xchg   %ax,%ax
8010555e:	66 90                	xchg   %ax,%ax

80105560 <memset>:
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	8b 55 08             	mov    0x8(%ebp),%edx
80105567:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010556a:	89 d0                	mov    %edx,%eax
8010556c:	09 c8                	or     %ecx,%eax
8010556e:	a8 03                	test   $0x3,%al
80105570:	75 1e                	jne    80105590 <memset+0x30>
80105572:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
80105576:	c1 e9 02             	shr    $0x2,%ecx
80105579:	89 d7                	mov    %edx,%edi
8010557b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80105581:	fc                   	cld    
80105582:	f3 ab                	rep stos %eax,%es:(%edi)
80105584:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105587:	89 d0                	mov    %edx,%eax
80105589:	c9                   	leave  
8010558a:	c3                   	ret    
8010558b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105590:	8b 45 0c             	mov    0xc(%ebp),%eax
80105593:	89 d7                	mov    %edx,%edi
80105595:	fc                   	cld    
80105596:	f3 aa                	rep stos %al,%es:(%edi)
80105598:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010559b:	89 d0                	mov    %edx,%eax
8010559d:	c9                   	leave  
8010559e:	c3                   	ret    
8010559f:	90                   	nop

801055a0 <memcmp>:
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	56                   	push   %esi
801055a4:	8b 75 10             	mov    0x10(%ebp),%esi
801055a7:	8b 45 08             	mov    0x8(%ebp),%eax
801055aa:	53                   	push   %ebx
801055ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801055ae:	85 f6                	test   %esi,%esi
801055b0:	74 2e                	je     801055e0 <memcmp+0x40>
801055b2:	01 c6                	add    %eax,%esi
801055b4:	eb 14                	jmp    801055ca <memcmp+0x2a>
801055b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055bd:	00 
801055be:	66 90                	xchg   %ax,%ax
801055c0:	83 c0 01             	add    $0x1,%eax
801055c3:	83 c2 01             	add    $0x1,%edx
801055c6:	39 f0                	cmp    %esi,%eax
801055c8:	74 16                	je     801055e0 <memcmp+0x40>
801055ca:	0f b6 08             	movzbl (%eax),%ecx
801055cd:	0f b6 1a             	movzbl (%edx),%ebx
801055d0:	38 d9                	cmp    %bl,%cl
801055d2:	74 ec                	je     801055c0 <memcmp+0x20>
801055d4:	0f b6 c1             	movzbl %cl,%eax
801055d7:	29 d8                	sub    %ebx,%eax
801055d9:	5b                   	pop    %ebx
801055da:	5e                   	pop    %esi
801055db:	5d                   	pop    %ebp
801055dc:	c3                   	ret    
801055dd:	8d 76 00             	lea    0x0(%esi),%esi
801055e0:	5b                   	pop    %ebx
801055e1:	31 c0                	xor    %eax,%eax
801055e3:	5e                   	pop    %esi
801055e4:	5d                   	pop    %ebp
801055e5:	c3                   	ret    
801055e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055ed:	00 
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <memmove>:
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	8b 55 08             	mov    0x8(%ebp),%edx
801055f7:	8b 45 10             	mov    0x10(%ebp),%eax
801055fa:	56                   	push   %esi
801055fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801055fe:	39 d6                	cmp    %edx,%esi
80105600:	73 26                	jae    80105628 <memmove+0x38>
80105602:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105605:	39 ca                	cmp    %ecx,%edx
80105607:	73 1f                	jae    80105628 <memmove+0x38>
80105609:	85 c0                	test   %eax,%eax
8010560b:	74 0f                	je     8010561c <memmove+0x2c>
8010560d:	83 e8 01             	sub    $0x1,%eax
80105610:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105614:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80105617:	83 e8 01             	sub    $0x1,%eax
8010561a:	73 f4                	jae    80105610 <memmove+0x20>
8010561c:	5e                   	pop    %esi
8010561d:	89 d0                	mov    %edx,%eax
8010561f:	5f                   	pop    %edi
80105620:	5d                   	pop    %ebp
80105621:	c3                   	ret    
80105622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105628:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010562b:	89 d7                	mov    %edx,%edi
8010562d:	85 c0                	test   %eax,%eax
8010562f:	74 eb                	je     8010561c <memmove+0x2c>
80105631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105638:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105639:	39 ce                	cmp    %ecx,%esi
8010563b:	75 fb                	jne    80105638 <memmove+0x48>
8010563d:	5e                   	pop    %esi
8010563e:	89 d0                	mov    %edx,%eax
80105640:	5f                   	pop    %edi
80105641:	5d                   	pop    %ebp
80105642:	c3                   	ret    
80105643:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010564a:	00 
8010564b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105650 <memcpy>:
80105650:	eb 9e                	jmp    801055f0 <memmove>
80105652:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105659:	00 
8010565a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105660 <strncmp>:
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	53                   	push   %ebx
80105664:	8b 55 10             	mov    0x10(%ebp),%edx
80105667:	8b 45 08             	mov    0x8(%ebp),%eax
8010566a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010566d:	85 d2                	test   %edx,%edx
8010566f:	75 16                	jne    80105687 <strncmp+0x27>
80105671:	eb 2d                	jmp    801056a0 <strncmp+0x40>
80105673:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105678:	3a 19                	cmp    (%ecx),%bl
8010567a:	75 12                	jne    8010568e <strncmp+0x2e>
8010567c:	83 c0 01             	add    $0x1,%eax
8010567f:	83 c1 01             	add    $0x1,%ecx
80105682:	83 ea 01             	sub    $0x1,%edx
80105685:	74 19                	je     801056a0 <strncmp+0x40>
80105687:	0f b6 18             	movzbl (%eax),%ebx
8010568a:	84 db                	test   %bl,%bl
8010568c:	75 ea                	jne    80105678 <strncmp+0x18>
8010568e:	0f b6 00             	movzbl (%eax),%eax
80105691:	0f b6 11             	movzbl (%ecx),%edx
80105694:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105697:	c9                   	leave  
80105698:	29 d0                	sub    %edx,%eax
8010569a:	c3                   	ret    
8010569b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801056a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056a3:	31 c0                	xor    %eax,%eax
801056a5:	c9                   	leave  
801056a6:	c3                   	ret    
801056a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056ae:	00 
801056af:	90                   	nop

801056b0 <strncpy>:
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	57                   	push   %edi
801056b4:	56                   	push   %esi
801056b5:	8b 75 08             	mov    0x8(%ebp),%esi
801056b8:	53                   	push   %ebx
801056b9:	8b 55 10             	mov    0x10(%ebp),%edx
801056bc:	89 f0                	mov    %esi,%eax
801056be:	eb 15                	jmp    801056d5 <strncpy+0x25>
801056c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801056c4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801056c7:	83 c0 01             	add    $0x1,%eax
801056ca:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801056ce:	88 48 ff             	mov    %cl,-0x1(%eax)
801056d1:	84 c9                	test   %cl,%cl
801056d3:	74 13                	je     801056e8 <strncpy+0x38>
801056d5:	89 d3                	mov    %edx,%ebx
801056d7:	83 ea 01             	sub    $0x1,%edx
801056da:	85 db                	test   %ebx,%ebx
801056dc:	7f e2                	jg     801056c0 <strncpy+0x10>
801056de:	5b                   	pop    %ebx
801056df:	89 f0                	mov    %esi,%eax
801056e1:	5e                   	pop    %esi
801056e2:	5f                   	pop    %edi
801056e3:	5d                   	pop    %ebp
801056e4:	c3                   	ret    
801056e5:	8d 76 00             	lea    0x0(%esi),%esi
801056e8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801056eb:	83 e9 01             	sub    $0x1,%ecx
801056ee:	85 d2                	test   %edx,%edx
801056f0:	74 ec                	je     801056de <strncpy+0x2e>
801056f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056f8:	83 c0 01             	add    $0x1,%eax
801056fb:	89 ca                	mov    %ecx,%edx
801056fd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
80105701:	29 c2                	sub    %eax,%edx
80105703:	85 d2                	test   %edx,%edx
80105705:	7f f1                	jg     801056f8 <strncpy+0x48>
80105707:	5b                   	pop    %ebx
80105708:	89 f0                	mov    %esi,%eax
8010570a:	5e                   	pop    %esi
8010570b:	5f                   	pop    %edi
8010570c:	5d                   	pop    %ebp
8010570d:	c3                   	ret    
8010570e:	66 90                	xchg   %ax,%ax

80105710 <safestrcpy>:
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	56                   	push   %esi
80105714:	8b 55 10             	mov    0x10(%ebp),%edx
80105717:	8b 75 08             	mov    0x8(%ebp),%esi
8010571a:	53                   	push   %ebx
8010571b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010571e:	85 d2                	test   %edx,%edx
80105720:	7e 25                	jle    80105747 <safestrcpy+0x37>
80105722:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105726:	89 f2                	mov    %esi,%edx
80105728:	eb 16                	jmp    80105740 <safestrcpy+0x30>
8010572a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105730:	0f b6 08             	movzbl (%eax),%ecx
80105733:	83 c0 01             	add    $0x1,%eax
80105736:	83 c2 01             	add    $0x1,%edx
80105739:	88 4a ff             	mov    %cl,-0x1(%edx)
8010573c:	84 c9                	test   %cl,%cl
8010573e:	74 04                	je     80105744 <safestrcpy+0x34>
80105740:	39 d8                	cmp    %ebx,%eax
80105742:	75 ec                	jne    80105730 <safestrcpy+0x20>
80105744:	c6 02 00             	movb   $0x0,(%edx)
80105747:	89 f0                	mov    %esi,%eax
80105749:	5b                   	pop    %ebx
8010574a:	5e                   	pop    %esi
8010574b:	5d                   	pop    %ebp
8010574c:	c3                   	ret    
8010574d:	8d 76 00             	lea    0x0(%esi),%esi

80105750 <strlen>:
80105750:	55                   	push   %ebp
80105751:	31 c0                	xor    %eax,%eax
80105753:	89 e5                	mov    %esp,%ebp
80105755:	8b 55 08             	mov    0x8(%ebp),%edx
80105758:	80 3a 00             	cmpb   $0x0,(%edx)
8010575b:	74 0c                	je     80105769 <strlen+0x19>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi
80105760:	83 c0 01             	add    $0x1,%eax
80105763:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105767:	75 f7                	jne    80105760 <strlen+0x10>
80105769:	5d                   	pop    %ebp
8010576a:	c3                   	ret    

8010576b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010576b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010576f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105773:	55                   	push   %ebp
  pushl %ebx
80105774:	53                   	push   %ebx
  pushl %esi
80105775:	56                   	push   %esi
  pushl %edi
80105776:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105777:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105779:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010577b:	5f                   	pop    %edi
  popl %esi
8010577c:	5e                   	pop    %esi
  popl %ebx
8010577d:	5b                   	pop    %ebx
  popl %ebp
8010577e:	5d                   	pop    %ebp
  ret
8010577f:	c3                   	ret    

80105780 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
80105784:	83 ec 04             	sub    $0x4,%esp
80105787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010578a:	e8 41 ef ff ff       	call   801046d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010578f:	8b 40 6c             	mov    0x6c(%eax),%eax
80105792:	39 d8                	cmp    %ebx,%eax
80105794:	76 1a                	jbe    801057b0 <fetchint+0x30>
80105796:	8d 53 04             	lea    0x4(%ebx),%edx
80105799:	39 d0                	cmp    %edx,%eax
8010579b:	72 13                	jb     801057b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010579d:	8b 45 0c             	mov    0xc(%ebp),%eax
801057a0:	8b 13                	mov    (%ebx),%edx
801057a2:	89 10                	mov    %edx,(%eax)
  return 0;
801057a4:	31 c0                	xor    %eax,%eax
}
801057a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057a9:	c9                   	leave  
801057aa:	c3                   	ret    
801057ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057af:	90                   	nop
    return -1;
801057b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057b5:	eb ef                	jmp    801057a6 <fetchint+0x26>
801057b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057be:	66 90                	xchg   %ax,%ax

801057c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
801057c4:	83 ec 04             	sub    $0x4,%esp
801057c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801057ca:	e8 01 ef ff ff       	call   801046d0 <myproc>

  if(addr >= curproc->sz)
801057cf:	39 58 6c             	cmp    %ebx,0x6c(%eax)
801057d2:	76 2c                	jbe    80105800 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801057d4:	8b 55 0c             	mov    0xc(%ebp),%edx
801057d7:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801057d9:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
801057dc:	39 d3                	cmp    %edx,%ebx
801057de:	73 20                	jae    80105800 <fetchstr+0x40>
801057e0:	89 d8                	mov    %ebx,%eax
801057e2:	eb 0b                	jmp    801057ef <fetchstr+0x2f>
801057e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057e8:	83 c0 01             	add    $0x1,%eax
801057eb:	39 c2                	cmp    %eax,%edx
801057ed:	76 11                	jbe    80105800 <fetchstr+0x40>
    if(*s == 0)
801057ef:	80 38 00             	cmpb   $0x0,(%eax)
801057f2:	75 f4                	jne    801057e8 <fetchstr+0x28>
      return s - *pp;
801057f4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801057f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f9:	c9                   	leave  
801057fa:	c3                   	ret    
801057fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057ff:	90                   	nop
80105800:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105808:	c9                   	leave  
80105809:	c3                   	ret    
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105810 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	56                   	push   %esi
80105814:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105815:	e8 b6 ee ff ff       	call   801046d0 <myproc>
8010581a:	8b 55 08             	mov    0x8(%ebp),%edx
8010581d:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80105823:	8b 40 44             	mov    0x44(%eax),%eax
80105826:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105829:	e8 a2 ee ff ff       	call   801046d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010582e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105831:	8b 40 6c             	mov    0x6c(%eax),%eax
80105834:	39 c6                	cmp    %eax,%esi
80105836:	73 18                	jae    80105850 <argint+0x40>
80105838:	8d 53 08             	lea    0x8(%ebx),%edx
8010583b:	39 d0                	cmp    %edx,%eax
8010583d:	72 11                	jb     80105850 <argint+0x40>
  *ip = *(int*)(addr);
8010583f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105842:	8b 53 04             	mov    0x4(%ebx),%edx
80105845:	89 10                	mov    %edx,(%eax)
  return 0;
80105847:	31 c0                	xor    %eax,%eax
}
80105849:	5b                   	pop    %ebx
8010584a:	5e                   	pop    %esi
8010584b:	5d                   	pop    %ebp
8010584c:	c3                   	ret    
8010584d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105855:	eb f2                	jmp    80105849 <argint+0x39>
80105857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585e:	66 90                	xchg   %ax,%ax

80105860 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
80105865:	53                   	push   %ebx
80105866:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105869:	e8 62 ee ff ff       	call   801046d0 <myproc>
8010586e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105870:	e8 5b ee ff ff       	call   801046d0 <myproc>
80105875:	8b 55 08             	mov    0x8(%ebp),%edx
80105878:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
8010587e:	8b 40 44             	mov    0x44(%eax),%eax
80105881:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105884:	e8 47 ee ff ff       	call   801046d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105889:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010588c:	8b 40 6c             	mov    0x6c(%eax),%eax
8010588f:	39 c7                	cmp    %eax,%edi
80105891:	73 35                	jae    801058c8 <argptr+0x68>
80105893:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105896:	39 c8                	cmp    %ecx,%eax
80105898:	72 2e                	jb     801058c8 <argptr+0x68>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010589a:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
8010589d:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801058a0:	85 d2                	test   %edx,%edx
801058a2:	78 24                	js     801058c8 <argptr+0x68>
801058a4:	8b 56 6c             	mov    0x6c(%esi),%edx
801058a7:	39 c2                	cmp    %eax,%edx
801058a9:	76 1d                	jbe    801058c8 <argptr+0x68>
801058ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
801058ae:	01 c3                	add    %eax,%ebx
801058b0:	39 da                	cmp    %ebx,%edx
801058b2:	72 14                	jb     801058c8 <argptr+0x68>
    return -1;
  *pp = (char*)i;
801058b4:	8b 55 0c             	mov    0xc(%ebp),%edx
801058b7:	89 02                	mov    %eax,(%edx)
  return 0;
801058b9:	31 c0                	xor    %eax,%eax
}
801058bb:	83 c4 0c             	add    $0xc,%esp
801058be:	5b                   	pop    %ebx
801058bf:	5e                   	pop    %esi
801058c0:	5f                   	pop    %edi
801058c1:	5d                   	pop    %ebp
801058c2:	c3                   	ret    
801058c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058c7:	90                   	nop
    return -1;
801058c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058cd:	eb ec                	jmp    801058bb <argptr+0x5b>
801058cf:	90                   	nop

801058d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	56                   	push   %esi
801058d4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801058d5:	e8 f6 ed ff ff       	call   801046d0 <myproc>
801058da:	8b 55 08             	mov    0x8(%ebp),%edx
801058dd:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801058e3:	8b 40 44             	mov    0x44(%eax),%eax
801058e6:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801058e9:	e8 e2 ed ff ff       	call   801046d0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801058ee:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801058f1:	8b 40 6c             	mov    0x6c(%eax),%eax
801058f4:	39 c6                	cmp    %eax,%esi
801058f6:	73 40                	jae    80105938 <argstr+0x68>
801058f8:	8d 53 08             	lea    0x8(%ebx),%edx
801058fb:	39 d0                	cmp    %edx,%eax
801058fd:	72 39                	jb     80105938 <argstr+0x68>
  *ip = *(int*)(addr);
801058ff:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80105902:	e8 c9 ed ff ff       	call   801046d0 <myproc>
  if(addr >= curproc->sz)
80105907:	3b 58 6c             	cmp    0x6c(%eax),%ebx
8010590a:	73 2c                	jae    80105938 <argstr+0x68>
  *pp = (char*)addr;
8010590c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010590f:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105911:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
80105914:	39 d3                	cmp    %edx,%ebx
80105916:	73 20                	jae    80105938 <argstr+0x68>
80105918:	89 d8                	mov    %ebx,%eax
8010591a:	eb 0b                	jmp    80105927 <argstr+0x57>
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105920:	83 c0 01             	add    $0x1,%eax
80105923:	39 c2                	cmp    %eax,%edx
80105925:	76 11                	jbe    80105938 <argstr+0x68>
    if(*s == 0)
80105927:	80 38 00             	cmpb   $0x0,(%eax)
8010592a:	75 f4                	jne    80105920 <argstr+0x50>
      return s - *pp;
8010592c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010592e:	5b                   	pop    %ebx
8010592f:	5e                   	pop    %esi
80105930:	5d                   	pop    %ebp
80105931:	c3                   	ret    
80105932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105938:	5b                   	pop    %ebx
    return -1;
80105939:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010593e:	5e                   	pop    %esi
8010593f:	5d                   	pop    %ebp
80105940:	c3                   	ret    
80105941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594f:	90                   	nop

80105950 <syscall>:
[SYS_create_palindrome] sys_create_palindrome,
};

void
syscall(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	53                   	push   %ebx
80105954:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105957:	e8 74 ed ff ff       	call   801046d0 <myproc>
8010595c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax; //define syscall number
8010595e:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80105964:	8b 40 1c             	mov    0x1c(%eax),%eax

  if(num<MAX_SYSCALLS && num>0)
80105967:	8d 50 ff             	lea    -0x1(%eax),%edx
8010596a:	83 fa 19             	cmp    $0x19,%edx
8010596d:	77 21                	ja     80105990 <syscall+0x40>
    curproc->syscalls[num]++;
    
  
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010596f:	8b 14 85 80 8c 10 80 	mov    -0x7fef7380(,%eax,4),%edx
    curproc->syscalls[num]++;
80105976:	83 04 83 01          	addl   $0x1,(%ebx,%eax,4)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010597a:	85 d2                	test   %edx,%edx
8010597c:	74 12                	je     80105990 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010597e:	ff d2                	call   *%edx
80105980:	89 c2                	mov    %eax,%edx
80105982:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80105988:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010598b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010598e:	c9                   	leave  
8010598f:	c3                   	ret    
    cprintf("%d %s: unknown sys call %d\n",
80105990:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105991:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105997:	50                   	push   %eax
80105998:	ff 73 7c             	push   0x7c(%ebx)
8010599b:	68 45 8c 10 80       	push   $0x80108c45
801059a0:	e8 cb b0 ff ff       	call   80100a70 <cprintf>
    curproc->tf->eax = -1;
801059a5:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801059ab:	83 c4 10             	add    $0x10,%esp
801059ae:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801059b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b8:	c9                   	leave  
801059b9:	c3                   	ret    
801059ba:	66 90                	xchg   %ax,%ax
801059bc:	66 90                	xchg   %ax,%ax
801059be:	66 90                	xchg   %ax,%ax

801059c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	57                   	push   %edi
801059c4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801059c5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801059c8:	53                   	push   %ebx
801059c9:	83 ec 34             	sub    $0x34,%esp
801059cc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801059cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801059d2:	57                   	push   %edi
801059d3:	50                   	push   %eax
{
801059d4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801059d7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801059da:	e8 21 d4 ff ff       	call   80102e00 <nameiparent>
801059df:	83 c4 10             	add    $0x10,%esp
801059e2:	85 c0                	test   %eax,%eax
801059e4:	0f 84 46 01 00 00    	je     80105b30 <create+0x170>
    return 0;
  ilock(dp);
801059ea:	83 ec 0c             	sub    $0xc,%esp
801059ed:	89 c3                	mov    %eax,%ebx
801059ef:	50                   	push   %eax
801059f0:	e8 bb ca ff ff       	call   801024b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801059f5:	83 c4 0c             	add    $0xc,%esp
801059f8:	6a 00                	push   $0x0
801059fa:	57                   	push   %edi
801059fb:	53                   	push   %ebx
801059fc:	e8 0f d0 ff ff       	call   80102a10 <dirlookup>
80105a01:	83 c4 10             	add    $0x10,%esp
80105a04:	89 c6                	mov    %eax,%esi
80105a06:	85 c0                	test   %eax,%eax
80105a08:	74 56                	je     80105a60 <create+0xa0>
    iunlockput(dp);
80105a0a:	83 ec 0c             	sub    $0xc,%esp
80105a0d:	53                   	push   %ebx
80105a0e:	e8 2d cd ff ff       	call   80102740 <iunlockput>
    ilock(ip);
80105a13:	89 34 24             	mov    %esi,(%esp)
80105a16:	e8 95 ca ff ff       	call   801024b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105a1b:	83 c4 10             	add    $0x10,%esp
80105a1e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105a23:	75 1b                	jne    80105a40 <create+0x80>
80105a25:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105a2a:	75 14                	jne    80105a40 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a2f:	89 f0                	mov    %esi,%eax
80105a31:	5b                   	pop    %ebx
80105a32:	5e                   	pop    %esi
80105a33:	5f                   	pop    %edi
80105a34:	5d                   	pop    %ebp
80105a35:	c3                   	ret    
80105a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105a40:	83 ec 0c             	sub    $0xc,%esp
80105a43:	56                   	push   %esi
    return 0;
80105a44:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105a46:	e8 f5 cc ff ff       	call   80102740 <iunlockput>
    return 0;
80105a4b:	83 c4 10             	add    $0x10,%esp
}
80105a4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a51:	89 f0                	mov    %esi,%eax
80105a53:	5b                   	pop    %ebx
80105a54:	5e                   	pop    %esi
80105a55:	5f                   	pop    %edi
80105a56:	5d                   	pop    %ebp
80105a57:	c3                   	ret    
80105a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105a60:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105a64:	83 ec 08             	sub    $0x8,%esp
80105a67:	50                   	push   %eax
80105a68:	ff 33                	push   (%ebx)
80105a6a:	e8 d1 c8 ff ff       	call   80102340 <ialloc>
80105a6f:	83 c4 10             	add    $0x10,%esp
80105a72:	89 c6                	mov    %eax,%esi
80105a74:	85 c0                	test   %eax,%eax
80105a76:	0f 84 cd 00 00 00    	je     80105b49 <create+0x189>
  ilock(ip);
80105a7c:	83 ec 0c             	sub    $0xc,%esp
80105a7f:	50                   	push   %eax
80105a80:	e8 2b ca ff ff       	call   801024b0 <ilock>
  ip->major = major;
80105a85:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105a89:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105a8d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105a91:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105a95:	b8 01 00 00 00       	mov    $0x1,%eax
80105a9a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80105a9e:	89 34 24             	mov    %esi,(%esp)
80105aa1:	e8 5a c9 ff ff       	call   80102400 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105aae:	74 30                	je     80105ae0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105ab0:	83 ec 04             	sub    $0x4,%esp
80105ab3:	ff 76 04             	push   0x4(%esi)
80105ab6:	57                   	push   %edi
80105ab7:	53                   	push   %ebx
80105ab8:	e8 63 d2 ff ff       	call   80102d20 <dirlink>
80105abd:	83 c4 10             	add    $0x10,%esp
80105ac0:	85 c0                	test   %eax,%eax
80105ac2:	78 78                	js     80105b3c <create+0x17c>
  iunlockput(dp);
80105ac4:	83 ec 0c             	sub    $0xc,%esp
80105ac7:	53                   	push   %ebx
80105ac8:	e8 73 cc ff ff       	call   80102740 <iunlockput>
  return ip;
80105acd:	83 c4 10             	add    $0x10,%esp
}
80105ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ad3:	89 f0                	mov    %esi,%eax
80105ad5:	5b                   	pop    %ebx
80105ad6:	5e                   	pop    %esi
80105ad7:	5f                   	pop    %edi
80105ad8:	5d                   	pop    %ebp
80105ad9:	c3                   	ret    
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105ae0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105ae3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105ae8:	53                   	push   %ebx
80105ae9:	e8 12 c9 ff ff       	call   80102400 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105aee:	83 c4 0c             	add    $0xc,%esp
80105af1:	ff 76 04             	push   0x4(%esi)
80105af4:	68 08 8d 10 80       	push   $0x80108d08
80105af9:	56                   	push   %esi
80105afa:	e8 21 d2 ff ff       	call   80102d20 <dirlink>
80105aff:	83 c4 10             	add    $0x10,%esp
80105b02:	85 c0                	test   %eax,%eax
80105b04:	78 18                	js     80105b1e <create+0x15e>
80105b06:	83 ec 04             	sub    $0x4,%esp
80105b09:	ff 73 04             	push   0x4(%ebx)
80105b0c:	68 07 8d 10 80       	push   $0x80108d07
80105b11:	56                   	push   %esi
80105b12:	e8 09 d2 ff ff       	call   80102d20 <dirlink>
80105b17:	83 c4 10             	add    $0x10,%esp
80105b1a:	85 c0                	test   %eax,%eax
80105b1c:	79 92                	jns    80105ab0 <create+0xf0>
      panic("create dots");
80105b1e:	83 ec 0c             	sub    $0xc,%esp
80105b21:	68 fb 8c 10 80       	push   $0x80108cfb
80105b26:	e8 c5 a9 ff ff       	call   801004f0 <panic>
80105b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b2f:	90                   	nop
}
80105b30:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105b33:	31 f6                	xor    %esi,%esi
}
80105b35:	5b                   	pop    %ebx
80105b36:	89 f0                	mov    %esi,%eax
80105b38:	5e                   	pop    %esi
80105b39:	5f                   	pop    %edi
80105b3a:	5d                   	pop    %ebp
80105b3b:	c3                   	ret    
    panic("create: dirlink");
80105b3c:	83 ec 0c             	sub    $0xc,%esp
80105b3f:	68 0a 8d 10 80       	push   $0x80108d0a
80105b44:	e8 a7 a9 ff ff       	call   801004f0 <panic>
    panic("create: ialloc");
80105b49:	83 ec 0c             	sub    $0xc,%esp
80105b4c:	68 ec 8c 10 80       	push   $0x80108cec
80105b51:	e8 9a a9 ff ff       	call   801004f0 <panic>
80105b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b5d:	8d 76 00             	lea    0x0(%esi),%esi

80105b60 <sys_dup>:
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	56                   	push   %esi
80105b64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105b65:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105b6b:	50                   	push   %eax
80105b6c:	6a 00                	push   $0x0
80105b6e:	e8 9d fc ff ff       	call   80105810 <argint>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 c0                	test   %eax,%eax
80105b78:	78 39                	js     80105bb3 <sys_dup+0x53>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105b7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b7e:	77 33                	ja     80105bb3 <sys_dup+0x53>
80105b80:	e8 4b eb ff ff       	call   801046d0 <myproc>
80105b85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b88:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80105b8f:	85 f6                	test   %esi,%esi
80105b91:	74 20                	je     80105bb3 <sys_dup+0x53>
  struct proc *curproc = myproc();
80105b93:	e8 38 eb ff ff       	call   801046d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b98:	31 db                	xor    %ebx,%ebx
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105ba0:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
80105ba7:	85 d2                	test   %edx,%edx
80105ba9:	74 1d                	je     80105bc8 <sys_dup+0x68>
  for(fd = 0; fd < NOFILE; fd++){
80105bab:	83 c3 01             	add    $0x1,%ebx
80105bae:	83 fb 10             	cmp    $0x10,%ebx
80105bb1:	75 ed                	jne    80105ba0 <sys_dup+0x40>
}
80105bb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105bb6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105bbb:	89 d8                	mov    %ebx,%eax
80105bbd:	5b                   	pop    %ebx
80105bbe:	5e                   	pop    %esi
80105bbf:	5d                   	pop    %ebp
80105bc0:	c3                   	ret    
80105bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80105bc8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105bcb:	89 b4 98 94 00 00 00 	mov    %esi,0x94(%eax,%ebx,4)
  filedup(f);
80105bd2:	56                   	push   %esi
80105bd3:	e8 f8 bf ff ff       	call   80101bd0 <filedup>
  return fd;
80105bd8:	83 c4 10             	add    $0x10,%esp
}
80105bdb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bde:	89 d8                	mov    %ebx,%eax
80105be0:	5b                   	pop    %ebx
80105be1:	5e                   	pop    %esi
80105be2:	5d                   	pop    %ebp
80105be3:	c3                   	ret    
80105be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bef:	90                   	nop

80105bf0 <sys_read>:
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	56                   	push   %esi
80105bf4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105bf5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105bf8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105bfb:	53                   	push   %ebx
80105bfc:	6a 00                	push   $0x0
80105bfe:	e8 0d fc ff ff       	call   80105810 <argint>
80105c03:	83 c4 10             	add    $0x10,%esp
80105c06:	85 c0                	test   %eax,%eax
80105c08:	78 66                	js     80105c70 <sys_read+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c0e:	77 60                	ja     80105c70 <sys_read+0x80>
80105c10:	e8 bb ea ff ff       	call   801046d0 <myproc>
80105c15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c18:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80105c1f:	85 f6                	test   %esi,%esi
80105c21:	74 4d                	je     80105c70 <sys_read+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105c23:	83 ec 08             	sub    $0x8,%esp
80105c26:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c29:	50                   	push   %eax
80105c2a:	6a 02                	push   $0x2
80105c2c:	e8 df fb ff ff       	call   80105810 <argint>
80105c31:	83 c4 10             	add    $0x10,%esp
80105c34:	85 c0                	test   %eax,%eax
80105c36:	78 38                	js     80105c70 <sys_read+0x80>
80105c38:	83 ec 04             	sub    $0x4,%esp
80105c3b:	ff 75 f0             	push   -0x10(%ebp)
80105c3e:	53                   	push   %ebx
80105c3f:	6a 01                	push   $0x1
80105c41:	e8 1a fc ff ff       	call   80105860 <argptr>
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	78 23                	js     80105c70 <sys_read+0x80>
  return fileread(f, p, n);
80105c4d:	83 ec 04             	sub    $0x4,%esp
80105c50:	ff 75 f0             	push   -0x10(%ebp)
80105c53:	ff 75 f4             	push   -0xc(%ebp)
80105c56:	56                   	push   %esi
80105c57:	e8 f4 c0 ff ff       	call   80101d50 <fileread>
80105c5c:	83 c4 10             	add    $0x10,%esp
}
80105c5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c62:	5b                   	pop    %ebx
80105c63:	5e                   	pop    %esi
80105c64:	5d                   	pop    %ebp
80105c65:	c3                   	ret    
80105c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c75:	eb e8                	jmp    80105c5f <sys_read+0x6f>
80105c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7e:	66 90                	xchg   %ax,%ax

80105c80 <sys_write>:
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	56                   	push   %esi
80105c84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105c85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105c88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105c8b:	53                   	push   %ebx
80105c8c:	6a 00                	push   $0x0
80105c8e:	e8 7d fb ff ff       	call   80105810 <argint>
80105c93:	83 c4 10             	add    $0x10,%esp
80105c96:	85 c0                	test   %eax,%eax
80105c98:	78 66                	js     80105d00 <sys_write+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c9e:	77 60                	ja     80105d00 <sys_write+0x80>
80105ca0:	e8 2b ea ff ff       	call   801046d0 <myproc>
80105ca5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ca8:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80105caf:	85 f6                	test   %esi,%esi
80105cb1:	74 4d                	je     80105d00 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105cb3:	83 ec 08             	sub    $0x8,%esp
80105cb6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cb9:	50                   	push   %eax
80105cba:	6a 02                	push   $0x2
80105cbc:	e8 4f fb ff ff       	call   80105810 <argint>
80105cc1:	83 c4 10             	add    $0x10,%esp
80105cc4:	85 c0                	test   %eax,%eax
80105cc6:	78 38                	js     80105d00 <sys_write+0x80>
80105cc8:	83 ec 04             	sub    $0x4,%esp
80105ccb:	ff 75 f0             	push   -0x10(%ebp)
80105cce:	53                   	push   %ebx
80105ccf:	6a 01                	push   $0x1
80105cd1:	e8 8a fb ff ff       	call   80105860 <argptr>
80105cd6:	83 c4 10             	add    $0x10,%esp
80105cd9:	85 c0                	test   %eax,%eax
80105cdb:	78 23                	js     80105d00 <sys_write+0x80>
  return filewrite(f, p, n);
80105cdd:	83 ec 04             	sub    $0x4,%esp
80105ce0:	ff 75 f0             	push   -0x10(%ebp)
80105ce3:	ff 75 f4             	push   -0xc(%ebp)
80105ce6:	56                   	push   %esi
80105ce7:	e8 f4 c0 ff ff       	call   80101de0 <filewrite>
80105cec:	83 c4 10             	add    $0x10,%esp
}
80105cef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105cf2:	5b                   	pop    %ebx
80105cf3:	5e                   	pop    %esi
80105cf4:	5d                   	pop    %ebp
80105cf5:	c3                   	ret    
80105cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d05:	eb e8                	jmp    80105cef <sys_write+0x6f>
80105d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d0e:	66 90                	xchg   %ax,%ax

80105d10 <sys_close>:
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	56                   	push   %esi
80105d14:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105d15:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105d18:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105d1b:	50                   	push   %eax
80105d1c:	6a 00                	push   $0x0
80105d1e:	e8 ed fa ff ff       	call   80105810 <argint>
80105d23:	83 c4 10             	add    $0x10,%esp
80105d26:	85 c0                	test   %eax,%eax
80105d28:	78 3e                	js     80105d68 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105d2a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105d2e:	77 38                	ja     80105d68 <sys_close+0x58>
80105d30:	e8 9b e9 ff ff       	call   801046d0 <myproc>
80105d35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d38:	8d 5a 24             	lea    0x24(%edx),%ebx
80105d3b:	8b 74 98 04          	mov    0x4(%eax,%ebx,4),%esi
80105d3f:	85 f6                	test   %esi,%esi
80105d41:	74 25                	je     80105d68 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105d43:	e8 88 e9 ff ff       	call   801046d0 <myproc>
  fileclose(f);
80105d48:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105d4b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
80105d52:	00 
  fileclose(f);
80105d53:	56                   	push   %esi
80105d54:	e8 c7 be ff ff       	call   80101c20 <fileclose>
  return 0;
80105d59:	83 c4 10             	add    $0x10,%esp
80105d5c:	31 c0                	xor    %eax,%eax
}
80105d5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d61:	5b                   	pop    %ebx
80105d62:	5e                   	pop    %esi
80105d63:	5d                   	pop    %ebp
80105d64:	c3                   	ret    
80105d65:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d6d:	eb ef                	jmp    80105d5e <sys_close+0x4e>
80105d6f:	90                   	nop

80105d70 <sys_fstat>:
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	56                   	push   %esi
80105d74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105d75:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105d78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105d7b:	53                   	push   %ebx
80105d7c:	6a 00                	push   $0x0
80105d7e:	e8 8d fa ff ff       	call   80105810 <argint>
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	85 c0                	test   %eax,%eax
80105d88:	78 46                	js     80105dd0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105d8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105d8e:	77 40                	ja     80105dd0 <sys_fstat+0x60>
80105d90:	e8 3b e9 ff ff       	call   801046d0 <myproc>
80105d95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d98:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80105d9f:	85 f6                	test   %esi,%esi
80105da1:	74 2d                	je     80105dd0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105da3:	83 ec 04             	sub    $0x4,%esp
80105da6:	6a 14                	push   $0x14
80105da8:	53                   	push   %ebx
80105da9:	6a 01                	push   $0x1
80105dab:	e8 b0 fa ff ff       	call   80105860 <argptr>
80105db0:	83 c4 10             	add    $0x10,%esp
80105db3:	85 c0                	test   %eax,%eax
80105db5:	78 19                	js     80105dd0 <sys_fstat+0x60>
  return filestat(f, st);
80105db7:	83 ec 08             	sub    $0x8,%esp
80105dba:	ff 75 f4             	push   -0xc(%ebp)
80105dbd:	56                   	push   %esi
80105dbe:	e8 3d bf ff ff       	call   80101d00 <filestat>
80105dc3:	83 c4 10             	add    $0x10,%esp
}
80105dc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105dc9:	5b                   	pop    %ebx
80105dca:	5e                   	pop    %esi
80105dcb:	5d                   	pop    %ebp
80105dcc:	c3                   	ret    
80105dcd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd5:	eb ef                	jmp    80105dc6 <sys_fstat+0x56>
80105dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dde:	66 90                	xchg   %ax,%ax

80105de0 <sys_link>:
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	57                   	push   %edi
80105de4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105de5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105de8:	53                   	push   %ebx
80105de9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105dec:	50                   	push   %eax
80105ded:	6a 00                	push   $0x0
80105def:	e8 dc fa ff ff       	call   801058d0 <argstr>
80105df4:	83 c4 10             	add    $0x10,%esp
80105df7:	85 c0                	test   %eax,%eax
80105df9:	0f 88 fb 00 00 00    	js     80105efa <sys_link+0x11a>
80105dff:	83 ec 08             	sub    $0x8,%esp
80105e02:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105e05:	50                   	push   %eax
80105e06:	6a 01                	push   $0x1
80105e08:	e8 c3 fa ff ff       	call   801058d0 <argstr>
80105e0d:	83 c4 10             	add    $0x10,%esp
80105e10:	85 c0                	test   %eax,%eax
80105e12:	0f 88 e2 00 00 00    	js     80105efa <sys_link+0x11a>
  begin_op();
80105e18:	e8 73 dc ff ff       	call   80103a90 <begin_op>
  if((ip = namei(old)) == 0){
80105e1d:	83 ec 0c             	sub    $0xc,%esp
80105e20:	ff 75 d4             	push   -0x2c(%ebp)
80105e23:	e8 b8 cf ff ff       	call   80102de0 <namei>
80105e28:	83 c4 10             	add    $0x10,%esp
80105e2b:	89 c3                	mov    %eax,%ebx
80105e2d:	85 c0                	test   %eax,%eax
80105e2f:	0f 84 e4 00 00 00    	je     80105f19 <sys_link+0x139>
  ilock(ip);
80105e35:	83 ec 0c             	sub    $0xc,%esp
80105e38:	50                   	push   %eax
80105e39:	e8 72 c6 ff ff       	call   801024b0 <ilock>
  if(ip->type == T_DIR){
80105e3e:	83 c4 10             	add    $0x10,%esp
80105e41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105e46:	0f 84 b5 00 00 00    	je     80105f01 <sys_link+0x121>
  iupdate(ip);
80105e4c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105e4f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105e54:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105e57:	53                   	push   %ebx
80105e58:	e8 a3 c5 ff ff       	call   80102400 <iupdate>
  iunlock(ip);
80105e5d:	89 1c 24             	mov    %ebx,(%esp)
80105e60:	e8 2b c7 ff ff       	call   80102590 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105e65:	58                   	pop    %eax
80105e66:	5a                   	pop    %edx
80105e67:	57                   	push   %edi
80105e68:	ff 75 d0             	push   -0x30(%ebp)
80105e6b:	e8 90 cf ff ff       	call   80102e00 <nameiparent>
80105e70:	83 c4 10             	add    $0x10,%esp
80105e73:	89 c6                	mov    %eax,%esi
80105e75:	85 c0                	test   %eax,%eax
80105e77:	74 5b                	je     80105ed4 <sys_link+0xf4>
  ilock(dp);
80105e79:	83 ec 0c             	sub    $0xc,%esp
80105e7c:	50                   	push   %eax
80105e7d:	e8 2e c6 ff ff       	call   801024b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105e82:	8b 03                	mov    (%ebx),%eax
80105e84:	83 c4 10             	add    $0x10,%esp
80105e87:	39 06                	cmp    %eax,(%esi)
80105e89:	75 3d                	jne    80105ec8 <sys_link+0xe8>
80105e8b:	83 ec 04             	sub    $0x4,%esp
80105e8e:	ff 73 04             	push   0x4(%ebx)
80105e91:	57                   	push   %edi
80105e92:	56                   	push   %esi
80105e93:	e8 88 ce ff ff       	call   80102d20 <dirlink>
80105e98:	83 c4 10             	add    $0x10,%esp
80105e9b:	85 c0                	test   %eax,%eax
80105e9d:	78 29                	js     80105ec8 <sys_link+0xe8>
  iunlockput(dp);
80105e9f:	83 ec 0c             	sub    $0xc,%esp
80105ea2:	56                   	push   %esi
80105ea3:	e8 98 c8 ff ff       	call   80102740 <iunlockput>
  iput(ip);
80105ea8:	89 1c 24             	mov    %ebx,(%esp)
80105eab:	e8 30 c7 ff ff       	call   801025e0 <iput>
  end_op();
80105eb0:	e8 4b dc ff ff       	call   80103b00 <end_op>
  return 0;
80105eb5:	83 c4 10             	add    $0x10,%esp
80105eb8:	31 c0                	xor    %eax,%eax
}
80105eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ebd:	5b                   	pop    %ebx
80105ebe:	5e                   	pop    %esi
80105ebf:	5f                   	pop    %edi
80105ec0:	5d                   	pop    %ebp
80105ec1:	c3                   	ret    
80105ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105ec8:	83 ec 0c             	sub    $0xc,%esp
80105ecb:	56                   	push   %esi
80105ecc:	e8 6f c8 ff ff       	call   80102740 <iunlockput>
    goto bad;
80105ed1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105ed4:	83 ec 0c             	sub    $0xc,%esp
80105ed7:	53                   	push   %ebx
80105ed8:	e8 d3 c5 ff ff       	call   801024b0 <ilock>
  ip->nlink--;
80105edd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ee2:	89 1c 24             	mov    %ebx,(%esp)
80105ee5:	e8 16 c5 ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
80105eea:	89 1c 24             	mov    %ebx,(%esp)
80105eed:	e8 4e c8 ff ff       	call   80102740 <iunlockput>
  end_op();
80105ef2:	e8 09 dc ff ff       	call   80103b00 <end_op>
  return -1;
80105ef7:	83 c4 10             	add    $0x10,%esp
80105efa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eff:	eb b9                	jmp    80105eba <sys_link+0xda>
    iunlockput(ip);
80105f01:	83 ec 0c             	sub    $0xc,%esp
80105f04:	53                   	push   %ebx
80105f05:	e8 36 c8 ff ff       	call   80102740 <iunlockput>
    end_op();
80105f0a:	e8 f1 db ff ff       	call   80103b00 <end_op>
    return -1;
80105f0f:	83 c4 10             	add    $0x10,%esp
80105f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f17:	eb a1                	jmp    80105eba <sys_link+0xda>
    end_op();
80105f19:	e8 e2 db ff ff       	call   80103b00 <end_op>
    return -1;
80105f1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f23:	eb 95                	jmp    80105eba <sys_link+0xda>
80105f25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f30 <sys_unlink>:
{
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	57                   	push   %edi
80105f34:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105f35:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105f38:	53                   	push   %ebx
80105f39:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105f3c:	50                   	push   %eax
80105f3d:	6a 00                	push   $0x0
80105f3f:	e8 8c f9 ff ff       	call   801058d0 <argstr>
80105f44:	83 c4 10             	add    $0x10,%esp
80105f47:	85 c0                	test   %eax,%eax
80105f49:	0f 88 7a 01 00 00    	js     801060c9 <sys_unlink+0x199>
  begin_op();
80105f4f:	e8 3c db ff ff       	call   80103a90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105f54:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105f57:	83 ec 08             	sub    $0x8,%esp
80105f5a:	53                   	push   %ebx
80105f5b:	ff 75 c0             	push   -0x40(%ebp)
80105f5e:	e8 9d ce ff ff       	call   80102e00 <nameiparent>
80105f63:	83 c4 10             	add    $0x10,%esp
80105f66:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	0f 84 62 01 00 00    	je     801060d3 <sys_unlink+0x1a3>
  ilock(dp);
80105f71:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105f74:	83 ec 0c             	sub    $0xc,%esp
80105f77:	57                   	push   %edi
80105f78:	e8 33 c5 ff ff       	call   801024b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105f7d:	58                   	pop    %eax
80105f7e:	5a                   	pop    %edx
80105f7f:	68 08 8d 10 80       	push   $0x80108d08
80105f84:	53                   	push   %ebx
80105f85:	e8 66 ca ff ff       	call   801029f0 <namecmp>
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	85 c0                	test   %eax,%eax
80105f8f:	0f 84 fb 00 00 00    	je     80106090 <sys_unlink+0x160>
80105f95:	83 ec 08             	sub    $0x8,%esp
80105f98:	68 07 8d 10 80       	push   $0x80108d07
80105f9d:	53                   	push   %ebx
80105f9e:	e8 4d ca ff ff       	call   801029f0 <namecmp>
80105fa3:	83 c4 10             	add    $0x10,%esp
80105fa6:	85 c0                	test   %eax,%eax
80105fa8:	0f 84 e2 00 00 00    	je     80106090 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105fae:	83 ec 04             	sub    $0x4,%esp
80105fb1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105fb4:	50                   	push   %eax
80105fb5:	53                   	push   %ebx
80105fb6:	57                   	push   %edi
80105fb7:	e8 54 ca ff ff       	call   80102a10 <dirlookup>
80105fbc:	83 c4 10             	add    $0x10,%esp
80105fbf:	89 c3                	mov    %eax,%ebx
80105fc1:	85 c0                	test   %eax,%eax
80105fc3:	0f 84 c7 00 00 00    	je     80106090 <sys_unlink+0x160>
  ilock(ip);
80105fc9:	83 ec 0c             	sub    $0xc,%esp
80105fcc:	50                   	push   %eax
80105fcd:	e8 de c4 ff ff       	call   801024b0 <ilock>
  if(ip->nlink < 1)
80105fd2:	83 c4 10             	add    $0x10,%esp
80105fd5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105fda:	0f 8e 1c 01 00 00    	jle    801060fc <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105fe0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105fe5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105fe8:	74 66                	je     80106050 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105fea:	83 ec 04             	sub    $0x4,%esp
80105fed:	6a 10                	push   $0x10
80105fef:	6a 00                	push   $0x0
80105ff1:	57                   	push   %edi
80105ff2:	e8 69 f5 ff ff       	call   80105560 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ff7:	6a 10                	push   $0x10
80105ff9:	ff 75 c4             	push   -0x3c(%ebp)
80105ffc:	57                   	push   %edi
80105ffd:	ff 75 b4             	push   -0x4c(%ebp)
80106000:	e8 bb c8 ff ff       	call   801028c0 <writei>
80106005:	83 c4 20             	add    $0x20,%esp
80106008:	83 f8 10             	cmp    $0x10,%eax
8010600b:	0f 85 de 00 00 00    	jne    801060ef <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80106011:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106016:	0f 84 94 00 00 00    	je     801060b0 <sys_unlink+0x180>
  iunlockput(dp);
8010601c:	83 ec 0c             	sub    $0xc,%esp
8010601f:	ff 75 b4             	push   -0x4c(%ebp)
80106022:	e8 19 c7 ff ff       	call   80102740 <iunlockput>
  ip->nlink--;
80106027:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010602c:	89 1c 24             	mov    %ebx,(%esp)
8010602f:	e8 cc c3 ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
80106034:	89 1c 24             	mov    %ebx,(%esp)
80106037:	e8 04 c7 ff ff       	call   80102740 <iunlockput>
  end_op();
8010603c:	e8 bf da ff ff       	call   80103b00 <end_op>
  return 0;
80106041:	83 c4 10             	add    $0x10,%esp
80106044:	31 c0                	xor    %eax,%eax
}
80106046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106049:	5b                   	pop    %ebx
8010604a:	5e                   	pop    %esi
8010604b:	5f                   	pop    %edi
8010604c:	5d                   	pop    %ebp
8010604d:	c3                   	ret    
8010604e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106050:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106054:	76 94                	jbe    80105fea <sys_unlink+0xba>
80106056:	be 20 00 00 00       	mov    $0x20,%esi
8010605b:	eb 0b                	jmp    80106068 <sys_unlink+0x138>
8010605d:	8d 76 00             	lea    0x0(%esi),%esi
80106060:	83 c6 10             	add    $0x10,%esi
80106063:	3b 73 58             	cmp    0x58(%ebx),%esi
80106066:	73 82                	jae    80105fea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106068:	6a 10                	push   $0x10
8010606a:	56                   	push   %esi
8010606b:	57                   	push   %edi
8010606c:	53                   	push   %ebx
8010606d:	e8 4e c7 ff ff       	call   801027c0 <readi>
80106072:	83 c4 10             	add    $0x10,%esp
80106075:	83 f8 10             	cmp    $0x10,%eax
80106078:	75 68                	jne    801060e2 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010607a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010607f:	74 df                	je     80106060 <sys_unlink+0x130>
    iunlockput(ip);
80106081:	83 ec 0c             	sub    $0xc,%esp
80106084:	53                   	push   %ebx
80106085:	e8 b6 c6 ff ff       	call   80102740 <iunlockput>
    goto bad;
8010608a:	83 c4 10             	add    $0x10,%esp
8010608d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80106090:	83 ec 0c             	sub    $0xc,%esp
80106093:	ff 75 b4             	push   -0x4c(%ebp)
80106096:	e8 a5 c6 ff ff       	call   80102740 <iunlockput>
  end_op();
8010609b:	e8 60 da ff ff       	call   80103b00 <end_op>
  return -1;
801060a0:	83 c4 10             	add    $0x10,%esp
801060a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060a8:	eb 9c                	jmp    80106046 <sys_unlink+0x116>
801060aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801060b0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801060b3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801060b6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801060bb:	50                   	push   %eax
801060bc:	e8 3f c3 ff ff       	call   80102400 <iupdate>
801060c1:	83 c4 10             	add    $0x10,%esp
801060c4:	e9 53 ff ff ff       	jmp    8010601c <sys_unlink+0xec>
    return -1;
801060c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060ce:	e9 73 ff ff ff       	jmp    80106046 <sys_unlink+0x116>
    end_op();
801060d3:	e8 28 da ff ff       	call   80103b00 <end_op>
    return -1;
801060d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060dd:	e9 64 ff ff ff       	jmp    80106046 <sys_unlink+0x116>
      panic("isdirempty: readi");
801060e2:	83 ec 0c             	sub    $0xc,%esp
801060e5:	68 2c 8d 10 80       	push   $0x80108d2c
801060ea:	e8 01 a4 ff ff       	call   801004f0 <panic>
    panic("unlink: writei");
801060ef:	83 ec 0c             	sub    $0xc,%esp
801060f2:	68 3e 8d 10 80       	push   $0x80108d3e
801060f7:	e8 f4 a3 ff ff       	call   801004f0 <panic>
    panic("unlink: nlink < 1");
801060fc:	83 ec 0c             	sub    $0xc,%esp
801060ff:	68 1a 8d 10 80       	push   $0x80108d1a
80106104:	e8 e7 a3 ff ff       	call   801004f0 <panic>
80106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106110 <sys_open>:

int
sys_open(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	57                   	push   %edi
80106114:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106115:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106118:	53                   	push   %ebx
80106119:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010611c:	50                   	push   %eax
8010611d:	6a 00                	push   $0x0
8010611f:	e8 ac f7 ff ff       	call   801058d0 <argstr>
80106124:	83 c4 10             	add    $0x10,%esp
80106127:	85 c0                	test   %eax,%eax
80106129:	0f 88 a1 00 00 00    	js     801061d0 <sys_open+0xc0>
8010612f:	83 ec 08             	sub    $0x8,%esp
80106132:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106135:	50                   	push   %eax
80106136:	6a 01                	push   $0x1
80106138:	e8 d3 f6 ff ff       	call   80105810 <argint>
8010613d:	83 c4 10             	add    $0x10,%esp
80106140:	85 c0                	test   %eax,%eax
80106142:	0f 88 88 00 00 00    	js     801061d0 <sys_open+0xc0>
    return -1;

  begin_op();
80106148:	e8 43 d9 ff ff       	call   80103a90 <begin_op>

  if(omode & O_CREATE){
8010614d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106151:	0f 85 89 00 00 00    	jne    801061e0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106157:	83 ec 0c             	sub    $0xc,%esp
8010615a:	ff 75 e0             	push   -0x20(%ebp)
8010615d:	e8 7e cc ff ff       	call   80102de0 <namei>
80106162:	83 c4 10             	add    $0x10,%esp
80106165:	89 c6                	mov    %eax,%esi
80106167:	85 c0                	test   %eax,%eax
80106169:	0f 84 8e 00 00 00    	je     801061fd <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010616f:	83 ec 0c             	sub    $0xc,%esp
80106172:	50                   	push   %eax
80106173:	e8 38 c3 ff ff       	call   801024b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106178:	83 c4 10             	add    $0x10,%esp
8010617b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106180:	0f 84 da 00 00 00    	je     80106260 <sys_open+0x150>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106186:	e8 d5 b9 ff ff       	call   80101b60 <filealloc>
8010618b:	89 c7                	mov    %eax,%edi
8010618d:	85 c0                	test   %eax,%eax
8010618f:	74 2e                	je     801061bf <sys_open+0xaf>
  struct proc *curproc = myproc();
80106191:	e8 3a e5 ff ff       	call   801046d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106196:	31 db                	xor    %ebx,%ebx
80106198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010619f:	90                   	nop
    if(curproc->ofile[fd] == 0){
801061a0:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
801061a7:	85 d2                	test   %edx,%edx
801061a9:	74 65                	je     80106210 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
801061ab:	83 c3 01             	add    $0x1,%ebx
801061ae:	83 fb 10             	cmp    $0x10,%ebx
801061b1:	75 ed                	jne    801061a0 <sys_open+0x90>
    if(f)
      fileclose(f);
801061b3:	83 ec 0c             	sub    $0xc,%esp
801061b6:	57                   	push   %edi
801061b7:	e8 64 ba ff ff       	call   80101c20 <fileclose>
801061bc:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801061bf:	83 ec 0c             	sub    $0xc,%esp
801061c2:	56                   	push   %esi
801061c3:	e8 78 c5 ff ff       	call   80102740 <iunlockput>
    end_op();
801061c8:	e8 33 d9 ff ff       	call   80103b00 <end_op>
    return -1;
801061cd:	83 c4 10             	add    $0x10,%esp
801061d0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801061d5:	eb 75                	jmp    8010624c <sys_open+0x13c>
801061d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061de:	66 90                	xchg   %ax,%ax
    ip = create(path, T_FILE, 0, 0);
801061e0:	83 ec 0c             	sub    $0xc,%esp
801061e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801061e6:	31 c9                	xor    %ecx,%ecx
801061e8:	ba 02 00 00 00       	mov    $0x2,%edx
801061ed:	6a 00                	push   $0x0
801061ef:	e8 cc f7 ff ff       	call   801059c0 <create>
    if(ip == 0){
801061f4:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801061f7:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801061f9:	85 c0                	test   %eax,%eax
801061fb:	75 89                	jne    80106186 <sys_open+0x76>
      end_op();
801061fd:	e8 fe d8 ff ff       	call   80103b00 <end_op>
      return -1;
80106202:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106207:	eb 43                	jmp    8010624c <sys_open+0x13c>
80106209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106210:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106213:	89 bc 98 94 00 00 00 	mov    %edi,0x94(%eax,%ebx,4)
  iunlock(ip);
8010621a:	56                   	push   %esi
8010621b:	e8 70 c3 ff ff       	call   80102590 <iunlock>
  end_op();
80106220:	e8 db d8 ff ff       	call   80103b00 <end_op>

  f->type = FD_INODE;
80106225:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010622b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010622e:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106231:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106234:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106236:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010623d:	f7 d0                	not    %eax
8010623f:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106242:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106245:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106248:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010624c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010624f:	89 d8                	mov    %ebx,%eax
80106251:	5b                   	pop    %ebx
80106252:	5e                   	pop    %esi
80106253:	5f                   	pop    %edi
80106254:	5d                   	pop    %ebp
80106255:	c3                   	ret    
80106256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010625d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106260:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106263:	85 c9                	test   %ecx,%ecx
80106265:	0f 84 1b ff ff ff    	je     80106186 <sys_open+0x76>
8010626b:	e9 4f ff ff ff       	jmp    801061bf <sys_open+0xaf>

80106270 <sys_mkdir>:

int
sys_mkdir(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106276:	e8 15 d8 ff ff       	call   80103a90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010627b:	83 ec 08             	sub    $0x8,%esp
8010627e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106281:	50                   	push   %eax
80106282:	6a 00                	push   $0x0
80106284:	e8 47 f6 ff ff       	call   801058d0 <argstr>
80106289:	83 c4 10             	add    $0x10,%esp
8010628c:	85 c0                	test   %eax,%eax
8010628e:	78 30                	js     801062c0 <sys_mkdir+0x50>
80106290:	83 ec 0c             	sub    $0xc,%esp
80106293:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106296:	31 c9                	xor    %ecx,%ecx
80106298:	ba 01 00 00 00       	mov    $0x1,%edx
8010629d:	6a 00                	push   $0x0
8010629f:	e8 1c f7 ff ff       	call   801059c0 <create>
801062a4:	83 c4 10             	add    $0x10,%esp
801062a7:	85 c0                	test   %eax,%eax
801062a9:	74 15                	je     801062c0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801062ab:	83 ec 0c             	sub    $0xc,%esp
801062ae:	50                   	push   %eax
801062af:	e8 8c c4 ff ff       	call   80102740 <iunlockput>
  end_op();
801062b4:	e8 47 d8 ff ff       	call   80103b00 <end_op>
  return 0;
801062b9:	83 c4 10             	add    $0x10,%esp
801062bc:	31 c0                	xor    %eax,%eax
}
801062be:	c9                   	leave  
801062bf:	c3                   	ret    
    end_op();
801062c0:	e8 3b d8 ff ff       	call   80103b00 <end_op>
    return -1;
801062c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062ca:	c9                   	leave  
801062cb:	c3                   	ret    
801062cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062d0 <sys_mknod>:

int
sys_mknod(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801062d6:	e8 b5 d7 ff ff       	call   80103a90 <begin_op>
  if((argstr(0, &path)) < 0 ||
801062db:	83 ec 08             	sub    $0x8,%esp
801062de:	8d 45 ec             	lea    -0x14(%ebp),%eax
801062e1:	50                   	push   %eax
801062e2:	6a 00                	push   $0x0
801062e4:	e8 e7 f5 ff ff       	call   801058d0 <argstr>
801062e9:	83 c4 10             	add    $0x10,%esp
801062ec:	85 c0                	test   %eax,%eax
801062ee:	78 60                	js     80106350 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801062f0:	83 ec 08             	sub    $0x8,%esp
801062f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062f6:	50                   	push   %eax
801062f7:	6a 01                	push   $0x1
801062f9:	e8 12 f5 ff ff       	call   80105810 <argint>
  if((argstr(0, &path)) < 0 ||
801062fe:	83 c4 10             	add    $0x10,%esp
80106301:	85 c0                	test   %eax,%eax
80106303:	78 4b                	js     80106350 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106305:	83 ec 08             	sub    $0x8,%esp
80106308:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010630b:	50                   	push   %eax
8010630c:	6a 02                	push   $0x2
8010630e:	e8 fd f4 ff ff       	call   80105810 <argint>
     argint(1, &major) < 0 ||
80106313:	83 c4 10             	add    $0x10,%esp
80106316:	85 c0                	test   %eax,%eax
80106318:	78 36                	js     80106350 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010631a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010631e:	83 ec 0c             	sub    $0xc,%esp
80106321:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106325:	ba 03 00 00 00       	mov    $0x3,%edx
8010632a:	50                   	push   %eax
8010632b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010632e:	e8 8d f6 ff ff       	call   801059c0 <create>
     argint(2, &minor) < 0 ||
80106333:	83 c4 10             	add    $0x10,%esp
80106336:	85 c0                	test   %eax,%eax
80106338:	74 16                	je     80106350 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010633a:	83 ec 0c             	sub    $0xc,%esp
8010633d:	50                   	push   %eax
8010633e:	e8 fd c3 ff ff       	call   80102740 <iunlockput>
  end_op();
80106343:	e8 b8 d7 ff ff       	call   80103b00 <end_op>
  return 0;
80106348:	83 c4 10             	add    $0x10,%esp
8010634b:	31 c0                	xor    %eax,%eax
}
8010634d:	c9                   	leave  
8010634e:	c3                   	ret    
8010634f:	90                   	nop
    end_op();
80106350:	e8 ab d7 ff ff       	call   80103b00 <end_op>
    return -1;
80106355:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010635a:	c9                   	leave  
8010635b:	c3                   	ret    
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106360 <sys_chdir>:

int
sys_chdir(void)
{
80106360:	55                   	push   %ebp
80106361:	89 e5                	mov    %esp,%ebp
80106363:	56                   	push   %esi
80106364:	53                   	push   %ebx
80106365:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106368:	e8 63 e3 ff ff       	call   801046d0 <myproc>
8010636d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010636f:	e8 1c d7 ff ff       	call   80103a90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106374:	83 ec 08             	sub    $0x8,%esp
80106377:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010637a:	50                   	push   %eax
8010637b:	6a 00                	push   $0x0
8010637d:	e8 4e f5 ff ff       	call   801058d0 <argstr>
80106382:	83 c4 10             	add    $0x10,%esp
80106385:	85 c0                	test   %eax,%eax
80106387:	78 77                	js     80106400 <sys_chdir+0xa0>
80106389:	83 ec 0c             	sub    $0xc,%esp
8010638c:	ff 75 f4             	push   -0xc(%ebp)
8010638f:	e8 4c ca ff ff       	call   80102de0 <namei>
80106394:	83 c4 10             	add    $0x10,%esp
80106397:	89 c3                	mov    %eax,%ebx
80106399:	85 c0                	test   %eax,%eax
8010639b:	74 63                	je     80106400 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010639d:	83 ec 0c             	sub    $0xc,%esp
801063a0:	50                   	push   %eax
801063a1:	e8 0a c1 ff ff       	call   801024b0 <ilock>
  if(ip->type != T_DIR){
801063a6:	83 c4 10             	add    $0x10,%esp
801063a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801063ae:	75 30                	jne    801063e0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801063b0:	83 ec 0c             	sub    $0xc,%esp
801063b3:	53                   	push   %ebx
801063b4:	e8 d7 c1 ff ff       	call   80102590 <iunlock>
  iput(curproc->cwd);
801063b9:	58                   	pop    %eax
801063ba:	ff b6 d4 00 00 00    	push   0xd4(%esi)
801063c0:	e8 1b c2 ff ff       	call   801025e0 <iput>
  end_op();
801063c5:	e8 36 d7 ff ff       	call   80103b00 <end_op>
  curproc->cwd = ip;
801063ca:	89 9e d4 00 00 00    	mov    %ebx,0xd4(%esi)
  return 0;
801063d0:	83 c4 10             	add    $0x10,%esp
801063d3:	31 c0                	xor    %eax,%eax
}
801063d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801063d8:	5b                   	pop    %ebx
801063d9:	5e                   	pop    %esi
801063da:	5d                   	pop    %ebp
801063db:	c3                   	ret    
801063dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801063e0:	83 ec 0c             	sub    $0xc,%esp
801063e3:	53                   	push   %ebx
801063e4:	e8 57 c3 ff ff       	call   80102740 <iunlockput>
    end_op();
801063e9:	e8 12 d7 ff ff       	call   80103b00 <end_op>
    return -1;
801063ee:	83 c4 10             	add    $0x10,%esp
801063f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063f6:	eb dd                	jmp    801063d5 <sys_chdir+0x75>
801063f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ff:	90                   	nop
    end_op();
80106400:	e8 fb d6 ff ff       	call   80103b00 <end_op>
    return -1;
80106405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010640a:	eb c9                	jmp    801063d5 <sys_chdir+0x75>
8010640c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106410 <sys_exec>:

int
sys_exec(void)
{
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	57                   	push   %edi
80106414:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106415:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010641b:	53                   	push   %ebx
8010641c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106422:	50                   	push   %eax
80106423:	6a 00                	push   $0x0
80106425:	e8 a6 f4 ff ff       	call   801058d0 <argstr>
8010642a:	83 c4 10             	add    $0x10,%esp
8010642d:	85 c0                	test   %eax,%eax
8010642f:	0f 88 87 00 00 00    	js     801064bc <sys_exec+0xac>
80106435:	83 ec 08             	sub    $0x8,%esp
80106438:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010643e:	50                   	push   %eax
8010643f:	6a 01                	push   $0x1
80106441:	e8 ca f3 ff ff       	call   80105810 <argint>
80106446:	83 c4 10             	add    $0x10,%esp
80106449:	85 c0                	test   %eax,%eax
8010644b:	78 6f                	js     801064bc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010644d:	83 ec 04             	sub    $0x4,%esp
80106450:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106456:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106458:	68 80 00 00 00       	push   $0x80
8010645d:	6a 00                	push   $0x0
8010645f:	56                   	push   %esi
80106460:	e8 fb f0 ff ff       	call   80105560 <memset>
80106465:	83 c4 10             	add    $0x10,%esp
80106468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010646f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106470:	83 ec 08             	sub    $0x8,%esp
80106473:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106479:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106480:	50                   	push   %eax
80106481:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106487:	01 f8                	add    %edi,%eax
80106489:	50                   	push   %eax
8010648a:	e8 f1 f2 ff ff       	call   80105780 <fetchint>
8010648f:	83 c4 10             	add    $0x10,%esp
80106492:	85 c0                	test   %eax,%eax
80106494:	78 26                	js     801064bc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106496:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010649c:	85 c0                	test   %eax,%eax
8010649e:	74 30                	je     801064d0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801064a0:	83 ec 08             	sub    $0x8,%esp
801064a3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801064a6:	52                   	push   %edx
801064a7:	50                   	push   %eax
801064a8:	e8 13 f3 ff ff       	call   801057c0 <fetchstr>
801064ad:	83 c4 10             	add    $0x10,%esp
801064b0:	85 c0                	test   %eax,%eax
801064b2:	78 08                	js     801064bc <sys_exec+0xac>
  for(i=0;; i++){
801064b4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801064b7:	83 fb 20             	cmp    $0x20,%ebx
801064ba:	75 b4                	jne    80106470 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801064bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801064bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064c4:	5b                   	pop    %ebx
801064c5:	5e                   	pop    %esi
801064c6:	5f                   	pop    %edi
801064c7:	5d                   	pop    %ebp
801064c8:	c3                   	ret    
801064c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801064d0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801064d7:	00 00 00 00 
  return exec(path, argv);
801064db:	83 ec 08             	sub    $0x8,%esp
801064de:	56                   	push   %esi
801064df:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801064e5:	e8 e6 b2 ff ff       	call   801017d0 <exec>
801064ea:	83 c4 10             	add    $0x10,%esp
}
801064ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064f0:	5b                   	pop    %ebx
801064f1:	5e                   	pop    %esi
801064f2:	5f                   	pop    %edi
801064f3:	5d                   	pop    %ebp
801064f4:	c3                   	ret    
801064f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106500 <sys_pipe>:

int
sys_pipe(void)
{
80106500:	55                   	push   %ebp
80106501:	89 e5                	mov    %esp,%ebp
80106503:	57                   	push   %edi
80106504:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106505:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106508:	53                   	push   %ebx
80106509:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010650c:	6a 08                	push   $0x8
8010650e:	50                   	push   %eax
8010650f:	6a 00                	push   $0x0
80106511:	e8 4a f3 ff ff       	call   80105860 <argptr>
80106516:	83 c4 10             	add    $0x10,%esp
80106519:	85 c0                	test   %eax,%eax
8010651b:	78 4d                	js     8010656a <sys_pipe+0x6a>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010651d:	83 ec 08             	sub    $0x8,%esp
80106520:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106523:	50                   	push   %eax
80106524:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106527:	50                   	push   %eax
80106528:	e8 23 dc ff ff       	call   80104150 <pipealloc>
8010652d:	83 c4 10             	add    $0x10,%esp
80106530:	85 c0                	test   %eax,%eax
80106532:	78 36                	js     8010656a <sys_pipe+0x6a>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106534:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106537:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106539:	e8 92 e1 ff ff       	call   801046d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010653e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106540:	8b b4 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%esi
80106547:	85 f6                	test   %esi,%esi
80106549:	74 2d                	je     80106578 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
8010654b:	83 c3 01             	add    $0x1,%ebx
8010654e:	83 fb 10             	cmp    $0x10,%ebx
80106551:	75 ed                	jne    80106540 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106553:	83 ec 0c             	sub    $0xc,%esp
80106556:	ff 75 e0             	push   -0x20(%ebp)
80106559:	e8 c2 b6 ff ff       	call   80101c20 <fileclose>
    fileclose(wf);
8010655e:	58                   	pop    %eax
8010655f:	ff 75 e4             	push   -0x1c(%ebp)
80106562:	e8 b9 b6 ff ff       	call   80101c20 <fileclose>
    return -1;
80106567:	83 c4 10             	add    $0x10,%esp
8010656a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010656f:	eb 5b                	jmp    801065cc <sys_pipe+0xcc>
80106571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106578:	8d 73 24             	lea    0x24(%ebx),%esi
8010657b:	89 7c b0 04          	mov    %edi,0x4(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010657f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106582:	e8 49 e1 ff ff       	call   801046d0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106587:	31 d2                	xor    %edx,%edx
80106589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106590:	8b 8c 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%ecx
80106597:	85 c9                	test   %ecx,%ecx
80106599:	74 1d                	je     801065b8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
8010659b:	83 c2 01             	add    $0x1,%edx
8010659e:	83 fa 10             	cmp    $0x10,%edx
801065a1:	75 ed                	jne    80106590 <sys_pipe+0x90>
      myproc()->ofile[fd0] = 0;
801065a3:	e8 28 e1 ff ff       	call   801046d0 <myproc>
801065a8:	c7 44 b0 04 00 00 00 	movl   $0x0,0x4(%eax,%esi,4)
801065af:	00 
801065b0:	eb a1                	jmp    80106553 <sys_pipe+0x53>
801065b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801065b8:	89 bc 90 94 00 00 00 	mov    %edi,0x94(%eax,%edx,4)
  }
  fd[0] = fd0;
801065bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
801065c2:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801065c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801065c7:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801065ca:	31 c0                	xor    %eax,%eax
}
801065cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065cf:	5b                   	pop    %ebx
801065d0:	5e                   	pop    %esi
801065d1:	5f                   	pop    %edi
801065d2:	5d                   	pop    %ebp
801065d3:	c3                   	ret    
801065d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065df:	90                   	nop

801065e0 <sys_move_file>:

int
sys_move_file(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	57                   	push   %edi
801065e4:	56                   	push   %esi
  char *src_file, *dest_dir;
  struct dirent de;
  uint  offset;
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
801065e5:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
{
801065eb:	53                   	push   %ebx
801065ec:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
801065f2:	50                   	push   %eax
801065f3:	6a 00                	push   $0x0
801065f5:	e8 d6 f2 ff ff       	call   801058d0 <argstr>
801065fa:	83 c4 10             	add    $0x10,%esp
801065fd:	85 c0                	test   %eax,%eax
801065ff:	0f 88 6c 01 00 00    	js     80106771 <sys_move_file+0x191>
80106605:	83 ec 08             	sub    $0x8,%esp
80106608:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
8010660e:	50                   	push   %eax
8010660f:	6a 01                	push   $0x1
80106611:	e8 ba f2 ff ff       	call   801058d0 <argstr>
80106616:	83 c4 10             	add    $0x10,%esp
80106619:	85 c0                	test   %eax,%eax
8010661b:	0f 88 50 01 00 00    	js     80106771 <sys_move_file+0x191>
  {
    return -1;
  }
  begin_op();
80106621:	e8 6a d4 ff ff       	call   80103a90 <begin_op>

  struct inode *src_ip = namei(src_file);
80106626:	83 ec 0c             	sub    $0xc,%esp
80106629:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
8010662f:	e8 ac c7 ff ff       	call   80102de0 <namei>
  if (src_ip == 0)
80106634:	83 c4 10             	add    $0x10,%esp
  struct inode *src_ip = namei(src_file);
80106637:	89 c6                	mov    %eax,%esi
  if (src_ip == 0)
80106639:	85 c0                	test   %eax,%eax
8010663b:	0f 84 45 01 00 00    	je     80106786 <sys_move_file+0x1a6>
  {
    cprintf("File not found: %s\n", src_file);
    end_op();
    return -1;
  }
  ilock(src_ip);
80106641:	83 ec 0c             	sub    $0xc,%esp
80106644:	50                   	push   %eax
80106645:	e8 66 be ff ff       	call   801024b0 <ilock>
  
  struct inode *dir_ip = namei(dest_dir);
8010664a:	58                   	pop    %eax
8010664b:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80106651:	e8 8a c7 ff ff       	call   80102de0 <namei>
  if (dir_ip== 0)
80106656:	83 c4 10             	add    $0x10,%esp
  struct inode *dir_ip = namei(dest_dir);
80106659:	89 c7                	mov    %eax,%edi
  if (dir_ip== 0)
8010665b:	85 c0                	test   %eax,%eax
8010665d:	0f 84 45 01 00 00    	je     801067a8 <sys_move_file+0x1c8>
    cprintf("Directory not found: %s\n", dest_dir);
    iunlockput(src_ip);
    end_op();
    return -1;
  }
  ilock(dir_ip);
80106663:	83 ec 0c             	sub    $0xc,%esp
80106666:	50                   	push   %eax
80106667:	e8 44 be ff ff       	call   801024b0 <ilock>

  char filename[128];
  safestrcpy(filename, src_file, sizeof(filename));
8010666c:	83 c4 0c             	add    $0xc,%esp
8010666f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106675:	68 80 00 00 00       	push   $0x80
8010667a:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106680:	50                   	push   %eax
80106681:	e8 8a f0 ff ff       	call   80105710 <safestrcpy>
   
  if (dirlink(dir_ip, filename, src_ip->inum) < 0)
80106686:	83 c4 0c             	add    $0xc,%esp
80106689:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010668f:	ff 76 04             	push   0x4(%esi)
80106692:	50                   	push   %eax
80106693:	57                   	push   %edi
80106694:	e8 87 c6 ff ff       	call   80102d20 <dirlink>
80106699:	83 c4 10             	add    $0x10,%esp
8010669c:	85 c0                	test   %eax,%eax
8010669e:	0f 88 dc 00 00 00    	js     80106780 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *dp_parent = nameiparent(src_file,  filename);
801066a4:	83 ec 08             	sub    $0x8,%esp
801066a7:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801066ad:	50                   	push   %eax
801066ae:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
801066b4:	e8 47 c7 ff ff       	call   80102e00 <nameiparent>
  if (dp_parent == 0)
801066b9:	83 c4 10             	add    $0x10,%esp
  struct inode *dp_parent = nameiparent(src_file,  filename);
801066bc:	89 c3                	mov    %eax,%ebx
  if (dp_parent == 0)
801066be:	85 c0                	test   %eax,%eax
801066c0:	0f 84 ba 00 00 00    	je     80106780 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *ip = dirlookup(dp_parent, filename, &offset);
801066c6:	83 ec 04             	sub    $0x4,%esp
801066c9:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
801066cf:	50                   	push   %eax
801066d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801066d6:	50                   	push   %eax
801066d7:	53                   	push   %ebx
801066d8:	e8 33 c3 ff ff       	call   80102a10 <dirlookup>
  if (ip == 0)
801066dd:	83 c4 10             	add    $0x10,%esp
801066e0:	85 c0                	test   %eax,%eax
801066e2:	0f 84 98 00 00 00    	je     80106780 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  memset(&de, 0, sizeof(de));
801066e8:	83 ec 04             	sub    $0x4,%esp
801066eb:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801066f1:	6a 10                	push   $0x10
801066f3:	6a 00                	push   $0x0
801066f5:	52                   	push   %edx
801066f6:	e8 65 ee ff ff       	call   80105560 <memset>
  ilock(dp_parent);
801066fb:	89 1c 24             	mov    %ebx,(%esp)
801066fe:	e8 ad bd ff ff       	call   801024b0 <ilock>
  if (writei(dp_parent, (char*)&de, offset, sizeof(de)) != sizeof(de))
80106703:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80106709:	6a 10                	push   $0x10
8010670b:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
80106711:	52                   	push   %edx
80106712:	53                   	push   %ebx
80106713:	e8 a8 c1 ff ff       	call   801028c0 <writei>
80106718:	83 c4 20             	add    $0x20,%esp
8010671b:	83 f8 10             	cmp    $0x10,%eax
8010671e:	75 30                	jne    80106750 <sys_move_file+0x170>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  iunlockput(src_ip);
80106720:	83 ec 0c             	sub    $0xc,%esp
80106723:	56                   	push   %esi
80106724:	e8 17 c0 ff ff       	call   80102740 <iunlockput>
  iunlockput(dir_ip);
80106729:	89 3c 24             	mov    %edi,(%esp)
8010672c:	e8 0f c0 ff ff       	call   80102740 <iunlockput>
  iunlockput(dp_parent);
80106731:	89 1c 24             	mov    %ebx,(%esp)
80106734:	e8 07 c0 ff ff       	call   80102740 <iunlockput>
  end_op();
80106739:	e8 c2 d3 ff ff       	call   80103b00 <end_op>
  return 0;
8010673e:	83 c4 10             	add    $0x10,%esp
80106741:	31 c0                	xor    %eax,%eax
80106743:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106746:	5b                   	pop    %ebx
80106747:	5e                   	pop    %esi
80106748:	5f                   	pop    %edi
80106749:	5d                   	pop    %ebp
8010674a:	c3                   	ret    
8010674b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010674f:	90                   	nop
    iunlockput(dp_parent);
80106750:	83 ec 0c             	sub    $0xc,%esp
80106753:	53                   	push   %ebx
80106754:	e8 e7 bf ff ff       	call   80102740 <iunlockput>
    iunlockput(dir_ip);
80106759:	89 3c 24             	mov    %edi,(%esp)
8010675c:	e8 df bf ff ff       	call   80102740 <iunlockput>
    iunlockput(src_ip);
80106761:	89 34 24             	mov    %esi,(%esp)
80106764:	e8 d7 bf ff ff       	call   80102740 <iunlockput>
    end_op();
80106769:	e8 92 d3 ff ff       	call   80103b00 <end_op>
    return -1;
8010676e:	83 c4 10             	add    $0x10,%esp
80106771:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106776:	eb cb                	jmp    80106743 <sys_move_file+0x163>
80106778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010677f:	90                   	nop
    iunlockput(dir_ip);
80106780:	83 ec 0c             	sub    $0xc,%esp
80106783:	57                   	push   %edi
80106784:	eb d6                	jmp    8010675c <sys_move_file+0x17c>
    cprintf("File not found: %s\n", src_file);
80106786:	83 ec 08             	sub    $0x8,%esp
80106789:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
8010678f:	68 4d 8d 10 80       	push   $0x80108d4d
80106794:	e8 d7 a2 ff ff       	call   80100a70 <cprintf>
    end_op();
80106799:	e8 62 d3 ff ff       	call   80103b00 <end_op>
    return -1;
8010679e:	83 c4 10             	add    $0x10,%esp
801067a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067a6:	eb 9b                	jmp    80106743 <sys_move_file+0x163>
    cprintf("Directory not found: %s\n", dest_dir);
801067a8:	83 ec 08             	sub    $0x8,%esp
801067ab:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
801067b1:	68 61 8d 10 80       	push   $0x80108d61
801067b6:	e8 b5 a2 ff ff       	call   80100a70 <cprintf>
    iunlockput(src_ip);
801067bb:	eb a4                	jmp    80106761 <sys_move_file+0x181>
801067bd:	66 90                	xchg   %ax,%ax
801067bf:	90                   	nop

801067c0 <create_palindrome_num>:

#include "syscall.h"
#include "traps.h"


int create_palindrome_num(int num) {
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
801067c6:	83 ec 4c             	sub    $0x4c,%esp
801067c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    //(20 digits to handle large integers)
    int length = 0;

    // Converting our integer to string
    int temp = num;
    while (temp > 0) {
801067cc:	85 c9                	test   %ecx,%ecx
801067ce:	0f 8e 9c 00 00 00    	jle    80106870 <create_palindrome_num+0xb0>
    int length = 0;
801067d4:	31 f6                	xor    %esi,%esi
801067d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067dd:	8d 76 00             	lea    0x0(%esi),%esi
        str[length++] = (temp % 10) + '0';
801067e0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
801067e5:	89 f3                	mov    %esi,%ebx
801067e7:	8d 76 01             	lea    0x1(%esi),%esi
801067ea:	f7 e1                	mul    %ecx
801067ec:	89 c8                	mov    %ecx,%eax
801067ee:	c1 ea 03             	shr    $0x3,%edx
801067f1:	8d 3c 92             	lea    (%edx,%edx,4),%edi
801067f4:	01 ff                	add    %edi,%edi
801067f6:	29 f8                	sub    %edi,%eax
801067f8:	83 c0 30             	add    $0x30,%eax
801067fb:	88 44 35 ab          	mov    %al,-0x55(%ebp,%esi,1)
        temp /= 10;
801067ff:	89 c8                	mov    %ecx,%eax
80106801:	89 d1                	mov    %edx,%ecx
    while (temp > 0) {
80106803:	83 f8 09             	cmp    $0x9,%eax
80106806:	7f d8                	jg     801067e0 <create_palindrome_num+0x20>
    }
    str[length] = '\0'; 
80106808:	8d 45 ac             	lea    -0x54(%ebp),%eax
8010680b:	c6 44 35 ac 00       	movb   $0x0,-0x54(%ebp,%esi,1)

    char palindrome_str[40];  // 2x length buffer to handle the palindrome
    int i, j;
    for (i = 0; i < length; i++) {
80106810:	8d 75 c0             	lea    -0x40(%ebp),%esi
80106813:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80106816:	8d 7c 1d c1          	lea    -0x3f(%ebp,%ebx,1),%edi
8010681a:	89 f0                	mov    %esi,%eax
8010681c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80106820:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < length; i++) {
80106823:	83 c0 01             	add    $0x1,%eax
80106826:	83 ea 01             	sub    $0x1,%edx
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80106829:	88 48 ff             	mov    %cl,-0x1(%eax)
    for (i = 0; i < length; i++) {
8010682c:	39 f8                	cmp    %edi,%eax
8010682e:	75 f0                	jne    80106820 <create_palindrome_num+0x60>
80106830:	31 c0                	xor    %eax,%eax
    }
    for (j = 0; j < length; j++) {
        palindrome_str[i++] = str[j];  // Copying the original part
80106832:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
80106835:	8d 76 00             	lea    0x0(%esi),%esi
80106838:	0f b6 4c 05 ac       	movzbl -0x54(%ebp,%eax,1),%ecx
8010683d:	89 c2                	mov    %eax,%edx
8010683f:	88 4c 07 01          	mov    %cl,0x1(%edi,%eax,1)
    for (j = 0; j < length; j++) {
80106843:	83 c0 01             	add    $0x1,%eax
80106846:	39 d3                	cmp    %edx,%ebx
80106848:	75 ee                	jne    80106838 <create_palindrome_num+0x78>
        palindrome_str[i++] = str[j];  // Copying the original part
8010684a:	8d 44 1b 02          	lea    0x2(%ebx,%ebx,1),%eax
    }
    palindrome_str[i] = '\0';

    cprintf("%s\n", palindrome_str);
8010684e:	83 ec 08             	sub    $0x8,%esp
    palindrome_str[i] = '\0';
80106851:	c6 44 05 c0 00       	movb   $0x0,-0x40(%ebp,%eax,1)
    cprintf("%s\n", palindrome_str);
80106856:	56                   	push   %esi
80106857:	68 5d 8d 10 80       	push   $0x80108d5d
8010685c:	e8 0f a2 ff ff       	call   80100a70 <cprintf>

    return 0;
}
80106861:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106864:	31 c0                	xor    %eax,%eax
80106866:	5b                   	pop    %ebx
80106867:	5e                   	pop    %esi
80106868:	5f                   	pop    %edi
80106869:	5d                   	pop    %ebp
8010686a:	c3                   	ret    
8010686b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010686f:	90                   	nop
    for (i = 0; i < length; i++) {
80106870:	31 c0                	xor    %eax,%eax
80106872:	8d 75 c0             	lea    -0x40(%ebp),%esi
80106875:	eb d7                	jmp    8010684e <create_palindrome_num+0x8e>
80106877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010687e:	66 90                	xchg   %ax,%ax

80106880 <sys_create_palindrome>:

int sys_create_palindrome(void) {
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	83 ec 20             	sub    $0x20,%esp
    int num;

    // Receive the integer argument from the REGISTERS
    if (argint(0, &num) < 0)
80106886:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106889:	50                   	push   %eax
8010688a:	6a 00                	push   $0x0
8010688c:	e8 7f ef ff ff       	call   80105810 <argint>
80106891:	83 c4 10             	add    $0x10,%esp
80106894:	85 c0                	test   %eax,%eax
80106896:	78 18                	js     801068b0 <sys_create_palindrome+0x30>
        return -1;

    // Generate and print the palindrome in kernel level
    create_palindrome_num(num);
80106898:	83 ec 0c             	sub    $0xc,%esp
8010689b:	ff 75 f4             	push   -0xc(%ebp)
8010689e:	e8 1d ff ff ff       	call   801067c0 <create_palindrome_num>

    return 0;
801068a3:	83 c4 10             	add    $0x10,%esp
801068a6:	31 c0                	xor    %eax,%eax
}
801068a8:	c9                   	leave  
801068a9:	c3                   	ret    
801068aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801068b0:	c9                   	leave  
        return -1;
801068b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068b6:	c3                   	ret    
801068b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068be:	66 90                	xchg   %ax,%ax

801068c0 <sys_fork>:
};

int
sys_fork(void)
{
  return fork();
801068c0:	e9 3b e0 ff ff       	jmp    80104900 <fork>
801068c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068d0 <sys_exit>:
}

int
sys_exit(void)
{
801068d0:	55                   	push   %ebp
801068d1:	89 e5                	mov    %esp,%ebp
801068d3:	83 ec 08             	sub    $0x8,%esp
  exit();
801068d6:	e8 c5 e2 ff ff       	call   80104ba0 <exit>
  return 0;  // not reached
}
801068db:	31 c0                	xor    %eax,%eax
801068dd:	c9                   	leave  
801068de:	c3                   	ret    
801068df:	90                   	nop

801068e0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801068e0:	e9 0b e4 ff ff       	jmp    80104cf0 <wait>
801068e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068f0 <sys_kill>:
}

int
sys_kill(void)
{
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801068f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068f9:	50                   	push   %eax
801068fa:	6a 00                	push   $0x0
801068fc:	e8 0f ef ff ff       	call   80105810 <argint>
80106901:	83 c4 10             	add    $0x10,%esp
80106904:	85 c0                	test   %eax,%eax
80106906:	78 18                	js     80106920 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106908:	83 ec 0c             	sub    $0xc,%esp
8010690b:	ff 75 f4             	push   -0xc(%ebp)
8010690e:	e8 ad e6 ff ff       	call   80104fc0 <kill>
80106913:	83 c4 10             	add    $0x10,%esp
}
80106916:	c9                   	leave  
80106917:	c3                   	ret    
80106918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010691f:	90                   	nop
80106920:	c9                   	leave  
    return -1;
80106921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106926:	c3                   	ret    
80106927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010692e:	66 90                	xchg   %ax,%ax

80106930 <sys_getpid>:

int
sys_getpid(void)
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106936:	e8 95 dd ff ff       	call   801046d0 <myproc>
8010693b:	8b 40 7c             	mov    0x7c(%eax),%eax
}
8010693e:	c9                   	leave  
8010693f:	c3                   	ret    

80106940 <sys_sbrk>:

int
sys_sbrk(void)
{
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106944:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106947:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010694a:	50                   	push   %eax
8010694b:	6a 00                	push   $0x0
8010694d:	e8 be ee ff ff       	call   80105810 <argint>
80106952:	83 c4 10             	add    $0x10,%esp
80106955:	85 c0                	test   %eax,%eax
80106957:	78 27                	js     80106980 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106959:	e8 72 dd ff ff       	call   801046d0 <myproc>
  if(growproc(n) < 0)
8010695e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106961:	8b 58 6c             	mov    0x6c(%eax),%ebx
  if(growproc(n) < 0)
80106964:	ff 75 f4             	push   -0xc(%ebp)
80106967:	e8 14 df ff ff       	call   80104880 <growproc>
8010696c:	83 c4 10             	add    $0x10,%esp
8010696f:	85 c0                	test   %eax,%eax
80106971:	78 0d                	js     80106980 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106973:	89 d8                	mov    %ebx,%eax
80106975:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106978:	c9                   	leave  
80106979:	c3                   	ret    
8010697a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106980:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106985:	eb ec                	jmp    80106973 <sys_sbrk+0x33>
80106987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010698e:	66 90                	xchg   %ax,%ax

80106990 <sys_sleep>:

int
sys_sleep(void)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106994:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106997:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010699a:	50                   	push   %eax
8010699b:	6a 00                	push   $0x0
8010699d:	e8 6e ee ff ff       	call   80105810 <argint>
801069a2:	83 c4 10             	add    $0x10,%esp
801069a5:	85 c0                	test   %eax,%eax
801069a7:	0f 88 8a 00 00 00    	js     80106a37 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801069ad:	83 ec 0c             	sub    $0xc,%esp
801069b0:	68 20 80 11 80       	push   $0x80118020
801069b5:	e8 e6 ea ff ff       	call   801054a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801069ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801069bd:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
801069c3:	83 c4 10             	add    $0x10,%esp
801069c6:	85 d2                	test   %edx,%edx
801069c8:	75 27                	jne    801069f1 <sys_sleep+0x61>
801069ca:	eb 54                	jmp    80106a20 <sys_sleep+0x90>
801069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801069d0:	83 ec 08             	sub    $0x8,%esp
801069d3:	68 20 80 11 80       	push   $0x80118020
801069d8:	68 00 80 11 80       	push   $0x80118000
801069dd:	e8 ae e4 ff ff       	call   80104e90 <sleep>
  while(ticks - ticks0 < n){
801069e2:	a1 00 80 11 80       	mov    0x80118000,%eax
801069e7:	83 c4 10             	add    $0x10,%esp
801069ea:	29 d8                	sub    %ebx,%eax
801069ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801069ef:	73 2f                	jae    80106a20 <sys_sleep+0x90>
    if(myproc()->killed){
801069f1:	e8 da dc ff ff       	call   801046d0 <myproc>
801069f6:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801069fc:	85 c0                	test   %eax,%eax
801069fe:	74 d0                	je     801069d0 <sys_sleep+0x40>
      release(&tickslock);
80106a00:	83 ec 0c             	sub    $0xc,%esp
80106a03:	68 20 80 11 80       	push   $0x80118020
80106a08:	e8 33 ea ff ff       	call   80105440 <release>
  }
  release(&tickslock);
  return 0;
}
80106a0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80106a10:	83 c4 10             	add    $0x10,%esp
80106a13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a18:	c9                   	leave  
80106a19:	c3                   	ret    
80106a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&tickslock);
80106a20:	83 ec 0c             	sub    $0xc,%esp
80106a23:	68 20 80 11 80       	push   $0x80118020
80106a28:	e8 13 ea ff ff       	call   80105440 <release>
  return 0;
80106a2d:	83 c4 10             	add    $0x10,%esp
80106a30:	31 c0                	xor    %eax,%eax
}
80106a32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a35:	c9                   	leave  
80106a36:	c3                   	ret    
    return -1;
80106a37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a3c:	eb f4                	jmp    80106a32 <sys_sleep+0xa2>
80106a3e:	66 90                	xchg   %ax,%ax

80106a40 <sys_sort_syscalls>:

int sys_sort_syscalls(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
  int pid;
  int counts[MAX_SYSCALLS];
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
80106a45:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
{
80106a4b:	53                   	push   %ebx
80106a4c:	81 ec 84 00 00 00    	sub    $0x84,%esp
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
80106a52:	50                   	push   %eax
80106a53:	6a 00                	push   $0x0
80106a55:	e8 b6 ed ff ff       	call   80105810 <argint>
80106a5a:	83 c4 10             	add    $0x10,%esp
80106a5d:	85 c0                	test   %eax,%eax
80106a5f:	78 71                	js     80106ad2 <sys_sort_syscalls+0x92>
80106a61:	83 ec 04             	sub    $0x4,%esp
80106a64:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
80106a6a:	6a 00                	push   $0x0
80106a6c:	50                   	push   %eax
80106a6d:	6a 00                	push   $0x0
80106a6f:	e8 ec ed ff ff       	call   80105860 <argptr>
80106a74:	83 c4 10             	add    $0x10,%esp
80106a77:	89 c7                	mov    %eax,%edi
80106a79:	85 c0                	test   %eax,%eax
80106a7b:	75 55                	jne    80106ad2 <sys_sort_syscalls+0x92>
    return -1;
  
  struct proc *p = findproc(pid);
80106a7d:	83 ec 0c             	sub    $0xc,%esp
80106a80:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
80106a86:	e8 75 dc ff ff       	call   80104700 <findproc>
  if(p==0) return -1;
80106a8b:	83 c4 10             	add    $0x10,%esp
  struct proc *p = findproc(pid);
80106a8e:	89 c6                	mov    %eax,%esi
  if(p==0) return -1;
80106a90:	85 c0                	test   %eax,%eax
80106a92:	74 3e                	je     80106ad2 <sys_sort_syscalls+0x92>
  for(int i=0; i<MAX_SYSCALLS; i++)
80106a94:	31 db                	xor    %ebx,%ebx
80106a96:	eb 10                	jmp    80106aa8 <sys_sort_syscalls+0x68>
80106a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a9f:	90                   	nop
80106aa0:	83 c3 01             	add    $0x1,%ebx
80106aa3:	83 fb 1b             	cmp    $0x1b,%ebx
80106aa6:	74 20                	je     80106ac8 <sys_sort_syscalls+0x88>
  {
    if(p->syscalls[i] != 0)
80106aa8:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
80106aab:	85 c0                	test   %eax,%eax
80106aad:	74 f1                	je     80106aa0 <sys_sort_syscalls+0x60>
      cprintf("%d\n", i);
80106aaf:	83 ec 08             	sub    $0x8,%esp
80106ab2:	53                   	push   %ebx
  for(int i=0; i<MAX_SYSCALLS; i++)
80106ab3:	83 c3 01             	add    $0x1,%ebx
      cprintf("%d\n", i);
80106ab6:	68 7c 8b 10 80       	push   $0x80108b7c
80106abb:	e8 b0 9f ff ff       	call   80100a70 <cprintf>
80106ac0:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<MAX_SYSCALLS; i++)
80106ac3:	83 fb 1b             	cmp    $0x1b,%ebx
80106ac6:	75 e0                	jne    80106aa8 <sys_sort_syscalls+0x68>

  }
  return 0;
}
80106ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106acb:	89 f8                	mov    %edi,%eax
80106acd:	5b                   	pop    %ebx
80106ace:	5e                   	pop    %esi
80106acf:	5f                   	pop    %edi
80106ad0:	5d                   	pop    %ebp
80106ad1:	c3                   	ret    
    return -1;
80106ad2:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106ad7:	eb ef                	jmp    80106ac8 <sys_sort_syscalls+0x88>
80106ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ae0 <sys_get_most_syscalls>:

int sys_get_most_syscalls(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid)<0 , sizeof(int)*MAX_SYSCALLS<0)
80106ae6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ae9:	50                   	push   %eax
80106aea:	6a 00                	push   $0x0
80106aec:	e8 1f ed ff ff       	call   80105810 <argint>
    return -1;
  
  struct proc *p = findproc(pid);
80106af1:	58                   	pop    %eax
80106af2:	ff 75 f4             	push   -0xc(%ebp)
80106af5:	e8 06 dc ff ff       	call   80104700 <findproc>
  if(p==0) return -1;
80106afa:	83 c4 10             	add    $0x10,%esp
80106afd:	85 c0                	test   %eax,%eax
80106aff:	74 3f                	je     80106b40 <sys_get_most_syscalls+0x60>
  int syscall_most_invoked = -1;
  for(int i=0; i<MAX_SYSCALLS; i++)
80106b01:	31 d2                	xor    %edx,%edx
  int syscall_most_invoked = -1;
80106b03:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b0f:	90                   	nop
    if(p->syscalls[i] > syscall_most_invoked)
80106b10:	39 0c 90             	cmp    %ecx,(%eax,%edx,4)
80106b13:	0f 4f ca             	cmovg  %edx,%ecx
  for(int i=0; i<MAX_SYSCALLS; i++)
80106b16:	83 c2 01             	add    $0x1,%edx
80106b19:	83 fa 1b             	cmp    $0x1b,%edx
80106b1c:	75 f2                	jne    80106b10 <sys_get_most_syscalls+0x30>
      syscall_most_invoked = i;
  if(syscall_most_invoked<0) return -1;
80106b1e:	85 c9                	test   %ecx,%ecx
80106b20:	78 1e                	js     80106b40 <sys_get_most_syscalls+0x60>
  cprintf("System call been most invoked: %s - %d times", syscall_names[syscall_most_invoked], p->syscalls[syscall_most_invoked]);
80106b22:	83 ec 04             	sub    $0x4,%esp
80106b25:	ff 34 88             	push   (%eax,%ecx,4)
80106b28:	ff 34 8d 20 c0 10 80 	push   -0x7fef3fe0(,%ecx,4)
80106b2f:	68 cc 8d 10 80       	push   $0x80108dcc
80106b34:	e8 37 9f ff ff       	call   80100a70 <cprintf>
  return 0;
80106b39:	83 c4 10             	add    $0x10,%esp
80106b3c:	31 c0                	xor    %eax,%eax
}
80106b3e:	c9                   	leave  
80106b3f:	c3                   	ret    
80106b40:	c9                   	leave  
  if(p==0) return -1;
80106b41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b46:	c3                   	ret    
80106b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b4e:	66 90                	xchg   %ax,%ax

80106b50 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	53                   	push   %ebx
80106b54:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106b57:	68 20 80 11 80       	push   $0x80118020
80106b5c:	e8 3f e9 ff ff       	call   801054a0 <acquire>
  xticks = ticks;
80106b61:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106b67:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
80106b6e:	e8 cd e8 ff ff       	call   80105440 <release>
  return xticks;
}
80106b73:	89 d8                	mov    %ebx,%eax
80106b75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b78:	c9                   	leave  
80106b79:	c3                   	ret    
80106b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b80 <sys_list_active_processes>:


int sys_list_active_processes(void) {
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	83 ec 08             	sub    $0x8,%esp
    list_active_processes();
80106b86:	e8 75 e5 ff ff       	call   80105100 <list_active_processes>
    return 0;  // Return 0 to indicate success
}
80106b8b:	31 c0                	xor    %eax,%eax
80106b8d:	c9                   	leave  
80106b8e:	c3                   	ret    

80106b8f <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106b8f:	1e                   	push   %ds
  pushl %es
80106b90:	06                   	push   %es
  pushl %fs
80106b91:	0f a0                	push   %fs
  pushl %gs
80106b93:	0f a8                	push   %gs
  pushal
80106b95:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106b96:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106b9a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106b9c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106b9e:	54                   	push   %esp
  call trap
80106b9f:	e8 cc 00 00 00       	call   80106c70 <trap>
  addl $4, %esp
80106ba4:	83 c4 04             	add    $0x4,%esp

80106ba7 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106ba7:	61                   	popa   
  popl %gs
80106ba8:	0f a9                	pop    %gs
  popl %fs
80106baa:	0f a1                	pop    %fs
  popl %es
80106bac:	07                   	pop    %es
  popl %ds
80106bad:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106bae:	83 c4 08             	add    $0x8,%esp
  iret
80106bb1:	cf                   	iret   
80106bb2:	66 90                	xchg   %ax,%ax
80106bb4:	66 90                	xchg   %ax,%ax
80106bb6:	66 90                	xchg   %ax,%ax
80106bb8:	66 90                	xchg   %ax,%ax
80106bba:	66 90                	xchg   %ax,%ax
80106bbc:	66 90                	xchg   %ax,%ax
80106bbe:	66 90                	xchg   %ax,%ax

80106bc0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106bc0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106bc1:	31 c0                	xor    %eax,%eax
{
80106bc3:	89 e5                	mov    %esp,%ebp
80106bc5:	83 ec 08             	sub    $0x8,%esp
80106bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bcf:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106bd0:	8b 14 85 78 c0 10 80 	mov    -0x7fef3f88(,%eax,4),%edx
80106bd7:	c7 04 c5 62 80 11 80 	movl   $0x8e000008,-0x7fee7f9e(,%eax,8)
80106bde:	08 00 00 8e 
80106be2:	66 89 14 c5 60 80 11 	mov    %dx,-0x7fee7fa0(,%eax,8)
80106be9:	80 
80106bea:	c1 ea 10             	shr    $0x10,%edx
80106bed:	66 89 14 c5 66 80 11 	mov    %dx,-0x7fee7f9a(,%eax,8)
80106bf4:	80 
  for(i = 0; i < 256; i++)
80106bf5:	83 c0 01             	add    $0x1,%eax
80106bf8:	3d 00 01 00 00       	cmp    $0x100,%eax
80106bfd:	75 d1                	jne    80106bd0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106bff:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c02:	a1 78 c1 10 80       	mov    0x8010c178,%eax
80106c07:	c7 05 62 82 11 80 08 	movl   $0xef000008,0x80118262
80106c0e:	00 00 ef 
  initlock(&tickslock, "time");
80106c11:	68 ad 8d 10 80       	push   $0x80108dad
80106c16:	68 20 80 11 80       	push   $0x80118020
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106c1b:	66 a3 60 82 11 80    	mov    %ax,0x80118260
80106c21:	c1 e8 10             	shr    $0x10,%eax
80106c24:	66 a3 66 82 11 80    	mov    %ax,0x80118266
  initlock(&tickslock, "time");
80106c2a:	e8 a1 e6 ff ff       	call   801052d0 <initlock>
}
80106c2f:	83 c4 10             	add    $0x10,%esp
80106c32:	c9                   	leave  
80106c33:	c3                   	ret    
80106c34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c3f:	90                   	nop

80106c40 <idtinit>:

void
idtinit(void)
{
80106c40:	55                   	push   %ebp
  pd[0] = size-1;
80106c41:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106c46:	89 e5                	mov    %esp,%ebp
80106c48:	83 ec 10             	sub    $0x10,%esp
80106c4b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106c4f:	b8 60 80 11 80       	mov    $0x80118060,%eax
80106c54:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106c58:	c1 e8 10             	shr    $0x10,%eax
80106c5b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106c5f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106c62:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106c65:	c9                   	leave  
80106c66:	c3                   	ret    
80106c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c6e:	66 90                	xchg   %ax,%ax

80106c70 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106c70:	55                   	push   %ebp
80106c71:	89 e5                	mov    %esp,%ebp
80106c73:	57                   	push   %edi
80106c74:	56                   	push   %esi
80106c75:	53                   	push   %ebx
80106c76:	83 ec 1c             	sub    $0x1c,%esp
80106c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106c7c:	8b 43 30             	mov    0x30(%ebx),%eax
80106c7f:	83 f8 40             	cmp    $0x40,%eax
80106c82:	0f 84 78 01 00 00    	je     80106e00 <trap+0x190>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106c88:	83 e8 20             	sub    $0x20,%eax
80106c8b:	83 f8 1f             	cmp    $0x1f,%eax
80106c8e:	0f 87 8c 00 00 00    	ja     80106d20 <trap+0xb0>
80106c94:	ff 24 85 9c 8e 10 80 	jmp    *-0x7fef7164(,%eax,4)
80106c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c9f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106ca0:	e8 db c2 ff ff       	call   80102f80 <ideintr>
    lapiceoi();
80106ca5:	e8 96 c9 ff ff       	call   80103640 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106caa:	e8 21 da ff ff       	call   801046d0 <myproc>
80106caf:	85 c0                	test   %eax,%eax
80106cb1:	74 20                	je     80106cd3 <trap+0x63>
80106cb3:	e8 18 da ff ff       	call   801046d0 <myproc>
80106cb8:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
80106cbe:	85 d2                	test   %edx,%edx
80106cc0:	74 11                	je     80106cd3 <trap+0x63>
80106cc2:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106cc6:	83 e0 03             	and    $0x3,%eax
80106cc9:	66 83 f8 03          	cmp    $0x3,%ax
80106ccd:	0f 84 fd 01 00 00    	je     80106ed0 <trap+0x260>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106cd3:	e8 f8 d9 ff ff       	call   801046d0 <myproc>
80106cd8:	85 c0                	test   %eax,%eax
80106cda:	74 0f                	je     80106ceb <trap+0x7b>
80106cdc:	e8 ef d9 ff ff       	call   801046d0 <myproc>
80106ce1:	83 78 78 04          	cmpl   $0x4,0x78(%eax)
80106ce5:	0f 84 c5 00 00 00    	je     80106db0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ceb:	e8 e0 d9 ff ff       	call   801046d0 <myproc>
80106cf0:	85 c0                	test   %eax,%eax
80106cf2:	74 20                	je     80106d14 <trap+0xa4>
80106cf4:	e8 d7 d9 ff ff       	call   801046d0 <myproc>
80106cf9:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106cff:	85 c0                	test   %eax,%eax
80106d01:	74 11                	je     80106d14 <trap+0xa4>
80106d03:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106d07:	83 e0 03             	and    $0x3,%eax
80106d0a:	66 83 f8 03          	cmp    $0x3,%ax
80106d0e:	0f 84 22 01 00 00    	je     80106e36 <trap+0x1c6>
    exit();
}
80106d14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d17:	5b                   	pop    %ebx
80106d18:	5e                   	pop    %esi
80106d19:	5f                   	pop    %edi
80106d1a:	5d                   	pop    %ebp
80106d1b:	c3                   	ret    
80106d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106d20:	e8 ab d9 ff ff       	call   801046d0 <myproc>
80106d25:	8b 7b 38             	mov    0x38(%ebx),%edi
80106d28:	85 c0                	test   %eax,%eax
80106d2a:	0f 84 ba 01 00 00    	je     80106eea <trap+0x27a>
80106d30:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106d34:	0f 84 b0 01 00 00    	je     80106eea <trap+0x27a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106d3a:	0f 20 d1             	mov    %cr2,%ecx
80106d3d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d40:	e8 6b d9 ff ff       	call   801046b0 <cpuid>
80106d45:	8b 73 30             	mov    0x30(%ebx),%esi
80106d48:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d4b:	8b 43 34             	mov    0x34(%ebx),%eax
80106d4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106d51:	e8 7a d9 ff ff       	call   801046d0 <myproc>
80106d56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d59:	e8 72 d9 ff ff       	call   801046d0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d5e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106d61:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106d64:	51                   	push   %ecx
80106d65:	57                   	push   %edi
80106d66:	52                   	push   %edx
80106d67:	ff 75 e4             	push   -0x1c(%ebp)
80106d6a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106d6b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106d6e:	81 c6 d8 00 00 00    	add    $0xd8,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d74:	56                   	push   %esi
80106d75:	ff 70 7c             	push   0x7c(%eax)
80106d78:	68 58 8e 10 80       	push   $0x80108e58
80106d7d:	e8 ee 9c ff ff       	call   80100a70 <cprintf>
    myproc()->killed = 1;
80106d82:	83 c4 20             	add    $0x20,%esp
80106d85:	e8 46 d9 ff ff       	call   801046d0 <myproc>
80106d8a:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
80106d91:	00 00 00 
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d94:	e8 37 d9 ff ff       	call   801046d0 <myproc>
80106d99:	85 c0                	test   %eax,%eax
80106d9b:	0f 85 12 ff ff ff    	jne    80106cb3 <trap+0x43>
80106da1:	e9 2d ff ff ff       	jmp    80106cd3 <trap+0x63>
80106da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dad:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106db0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106db4:	0f 85 31 ff ff ff    	jne    80106ceb <trap+0x7b>
    yield();
80106dba:	e8 81 e0 ff ff       	call   80104e40 <yield>
80106dbf:	e9 27 ff ff ff       	jmp    80106ceb <trap+0x7b>
80106dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106dc8:	8b 7b 38             	mov    0x38(%ebx),%edi
80106dcb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106dcf:	e8 dc d8 ff ff       	call   801046b0 <cpuid>
80106dd4:	57                   	push   %edi
80106dd5:	56                   	push   %esi
80106dd6:	50                   	push   %eax
80106dd7:	68 00 8e 10 80       	push   $0x80108e00
80106ddc:	e8 8f 9c ff ff       	call   80100a70 <cprintf>
    lapiceoi();
80106de1:	e8 5a c8 ff ff       	call   80103640 <lapiceoi>
    break;
80106de6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106de9:	e8 e2 d8 ff ff       	call   801046d0 <myproc>
80106dee:	85 c0                	test   %eax,%eax
80106df0:	0f 85 bd fe ff ff    	jne    80106cb3 <trap+0x43>
80106df6:	e9 d8 fe ff ff       	jmp    80106cd3 <trap+0x63>
80106dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106dff:	90                   	nop
    if(myproc()->killed)
80106e00:	e8 cb d8 ff ff       	call   801046d0 <myproc>
80106e05:	8b b0 90 00 00 00    	mov    0x90(%eax),%esi
80106e0b:	85 f6                	test   %esi,%esi
80106e0d:	0f 85 cd 00 00 00    	jne    80106ee0 <trap+0x270>
    myproc()->tf = tf;
80106e13:	e8 b8 d8 ff ff       	call   801046d0 <myproc>
80106e18:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
80106e1e:	e8 2d eb ff ff       	call   80105950 <syscall>
    if(myproc()->killed)
80106e23:	e8 a8 d8 ff ff       	call   801046d0 <myproc>
80106e28:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
80106e2e:	85 c9                	test   %ecx,%ecx
80106e30:	0f 84 de fe ff ff    	je     80106d14 <trap+0xa4>
}
80106e36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e39:	5b                   	pop    %ebx
80106e3a:	5e                   	pop    %esi
80106e3b:	5f                   	pop    %edi
80106e3c:	5d                   	pop    %ebp
      exit();
80106e3d:	e9 5e dd ff ff       	jmp    80104ba0 <exit>
80106e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartintr();
80106e48:	e8 43 02 00 00       	call   80107090 <uartintr>
    lapiceoi();
80106e4d:	e8 ee c7 ff ff       	call   80103640 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e52:	e8 79 d8 ff ff       	call   801046d0 <myproc>
80106e57:	85 c0                	test   %eax,%eax
80106e59:	0f 85 54 fe ff ff    	jne    80106cb3 <trap+0x43>
80106e5f:	e9 6f fe ff ff       	jmp    80106cd3 <trap+0x63>
80106e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106e68:	e8 a3 c6 ff ff       	call   80103510 <kbdintr>
    lapiceoi();
80106e6d:	e8 ce c7 ff ff       	call   80103640 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e72:	e8 59 d8 ff ff       	call   801046d0 <myproc>
80106e77:	85 c0                	test   %eax,%eax
80106e79:	0f 85 34 fe ff ff    	jne    80106cb3 <trap+0x43>
80106e7f:	e9 4f fe ff ff       	jmp    80106cd3 <trap+0x63>
80106e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106e88:	e8 23 d8 ff ff       	call   801046b0 <cpuid>
80106e8d:	85 c0                	test   %eax,%eax
80106e8f:	0f 85 10 fe ff ff    	jne    80106ca5 <trap+0x35>
      acquire(&tickslock);
80106e95:	83 ec 0c             	sub    $0xc,%esp
80106e98:	68 20 80 11 80       	push   $0x80118020
80106e9d:	e8 fe e5 ff ff       	call   801054a0 <acquire>
      wakeup(&ticks);
80106ea2:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
      ticks++;
80106ea9:	83 05 00 80 11 80 01 	addl   $0x1,0x80118000
      wakeup(&ticks);
80106eb0:	e8 ab e0 ff ff       	call   80104f60 <wakeup>
      release(&tickslock);
80106eb5:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
80106ebc:	e8 7f e5 ff ff       	call   80105440 <release>
80106ec1:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106ec4:	e9 dc fd ff ff       	jmp    80106ca5 <trap+0x35>
80106ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106ed0:	e8 cb dc ff ff       	call   80104ba0 <exit>
80106ed5:	e9 f9 fd ff ff       	jmp    80106cd3 <trap+0x63>
80106eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106ee0:	e8 bb dc ff ff       	call   80104ba0 <exit>
80106ee5:	e9 29 ff ff ff       	jmp    80106e13 <trap+0x1a3>
80106eea:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106eed:	e8 be d7 ff ff       	call   801046b0 <cpuid>
80106ef2:	83 ec 0c             	sub    $0xc,%esp
80106ef5:	56                   	push   %esi
80106ef6:	57                   	push   %edi
80106ef7:	50                   	push   %eax
80106ef8:	ff 73 30             	push   0x30(%ebx)
80106efb:	68 24 8e 10 80       	push   $0x80108e24
80106f00:	e8 6b 9b ff ff       	call   80100a70 <cprintf>
      panic("trap");
80106f05:	83 c4 14             	add    $0x14,%esp
80106f08:	68 f9 8d 10 80       	push   $0x80108df9
80106f0d:	e8 de 95 ff ff       	call   801004f0 <panic>
80106f12:	66 90                	xchg   %ax,%ax
80106f14:	66 90                	xchg   %ax,%ax
80106f16:	66 90                	xchg   %ax,%ax
80106f18:	66 90                	xchg   %ax,%ax
80106f1a:	66 90                	xchg   %ax,%ax
80106f1c:	66 90                	xchg   %ax,%ax
80106f1e:	66 90                	xchg   %ax,%ax

80106f20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106f20:	a1 60 88 11 80       	mov    0x80118860,%eax
80106f25:	85 c0                	test   %eax,%eax
80106f27:	74 17                	je     80106f40 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f29:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106f2e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106f2f:	a8 01                	test   $0x1,%al
80106f31:	74 0d                	je     80106f40 <uartgetc+0x20>
80106f33:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f38:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106f39:	0f b6 c0             	movzbl %al,%eax
80106f3c:	c3                   	ret    
80106f3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f45:	c3                   	ret    
80106f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f4d:	8d 76 00             	lea    0x0(%esi),%esi

80106f50 <uartinit>:
{
80106f50:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106f51:	31 c9                	xor    %ecx,%ecx
80106f53:	89 c8                	mov    %ecx,%eax
80106f55:	89 e5                	mov    %esp,%ebp
80106f57:	57                   	push   %edi
80106f58:	bf fa 03 00 00       	mov    $0x3fa,%edi
80106f5d:	56                   	push   %esi
80106f5e:	89 fa                	mov    %edi,%edx
80106f60:	53                   	push   %ebx
80106f61:	83 ec 1c             	sub    $0x1c,%esp
80106f64:	ee                   	out    %al,(%dx)
80106f65:	be fb 03 00 00       	mov    $0x3fb,%esi
80106f6a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106f6f:	89 f2                	mov    %esi,%edx
80106f71:	ee                   	out    %al,(%dx)
80106f72:	b8 0c 00 00 00       	mov    $0xc,%eax
80106f77:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f7c:	ee                   	out    %al,(%dx)
80106f7d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106f82:	89 c8                	mov    %ecx,%eax
80106f84:	89 da                	mov    %ebx,%edx
80106f86:	ee                   	out    %al,(%dx)
80106f87:	b8 03 00 00 00       	mov    $0x3,%eax
80106f8c:	89 f2                	mov    %esi,%edx
80106f8e:	ee                   	out    %al,(%dx)
80106f8f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106f94:	89 c8                	mov    %ecx,%eax
80106f96:	ee                   	out    %al,(%dx)
80106f97:	b8 01 00 00 00       	mov    $0x1,%eax
80106f9c:	89 da                	mov    %ebx,%edx
80106f9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f9f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106fa4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106fa5:	3c ff                	cmp    $0xff,%al
80106fa7:	74 78                	je     80107021 <uartinit+0xd1>
  uart = 1;
80106fa9:	c7 05 60 88 11 80 01 	movl   $0x1,0x80118860
80106fb0:	00 00 00 
80106fb3:	89 fa                	mov    %edi,%edx
80106fb5:	ec                   	in     (%dx),%al
80106fb6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106fbb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106fbc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106fbf:	bf 1c 8f 10 80       	mov    $0x80108f1c,%edi
80106fc4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106fc9:	6a 00                	push   $0x0
80106fcb:	6a 04                	push   $0x4
80106fcd:	e8 de c1 ff ff       	call   801031b0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106fd2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106fd6:	83 c4 10             	add    $0x10,%esp
80106fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106fe0:	a1 60 88 11 80       	mov    0x80118860,%eax
80106fe5:	bb 80 00 00 00       	mov    $0x80,%ebx
80106fea:	85 c0                	test   %eax,%eax
80106fec:	75 14                	jne    80107002 <uartinit+0xb2>
80106fee:	eb 23                	jmp    80107013 <uartinit+0xc3>
    microdelay(10);
80106ff0:	83 ec 0c             	sub    $0xc,%esp
80106ff3:	6a 0a                	push   $0xa
80106ff5:	e8 66 c6 ff ff       	call   80103660 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106ffa:	83 c4 10             	add    $0x10,%esp
80106ffd:	83 eb 01             	sub    $0x1,%ebx
80107000:	74 07                	je     80107009 <uartinit+0xb9>
80107002:	89 f2                	mov    %esi,%edx
80107004:	ec                   	in     (%dx),%al
80107005:	a8 20                	test   $0x20,%al
80107007:	74 e7                	je     80106ff0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107009:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010700d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107012:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80107013:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80107017:	83 c7 01             	add    $0x1,%edi
8010701a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010701d:	84 c0                	test   %al,%al
8010701f:	75 bf                	jne    80106fe0 <uartinit+0x90>
}
80107021:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107024:	5b                   	pop    %ebx
80107025:	5e                   	pop    %esi
80107026:	5f                   	pop    %edi
80107027:	5d                   	pop    %ebp
80107028:	c3                   	ret    
80107029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107030 <uartputc>:
  if(!uart)
80107030:	a1 60 88 11 80       	mov    0x80118860,%eax
80107035:	85 c0                	test   %eax,%eax
80107037:	74 47                	je     80107080 <uartputc+0x50>
{
80107039:	55                   	push   %ebp
8010703a:	89 e5                	mov    %esp,%ebp
8010703c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010703d:	be fd 03 00 00       	mov    $0x3fd,%esi
80107042:	53                   	push   %ebx
80107043:	bb 80 00 00 00       	mov    $0x80,%ebx
80107048:	eb 18                	jmp    80107062 <uartputc+0x32>
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80107050:	83 ec 0c             	sub    $0xc,%esp
80107053:	6a 0a                	push   $0xa
80107055:	e8 06 c6 ff ff       	call   80103660 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010705a:	83 c4 10             	add    $0x10,%esp
8010705d:	83 eb 01             	sub    $0x1,%ebx
80107060:	74 07                	je     80107069 <uartputc+0x39>
80107062:	89 f2                	mov    %esi,%edx
80107064:	ec                   	in     (%dx),%al
80107065:	a8 20                	test   $0x20,%al
80107067:	74 e7                	je     80107050 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107069:	8b 45 08             	mov    0x8(%ebp),%eax
8010706c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107071:	ee                   	out    %al,(%dx)
}
80107072:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107075:	5b                   	pop    %ebx
80107076:	5e                   	pop    %esi
80107077:	5d                   	pop    %ebp
80107078:	c3                   	ret    
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107080:	c3                   	ret    
80107081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010708f:	90                   	nop

80107090 <uartintr>:

void
uartintr(void)
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107096:	68 20 6f 10 80       	push   $0x80106f20
8010709b:	e8 a0 9c ff ff       	call   80100d40 <consoleintr>
}
801070a0:	83 c4 10             	add    $0x10,%esp
801070a3:	c9                   	leave  
801070a4:	c3                   	ret    

801070a5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801070a5:	6a 00                	push   $0x0
  pushl $0
801070a7:	6a 00                	push   $0x0
  jmp alltraps
801070a9:	e9 e1 fa ff ff       	jmp    80106b8f <alltraps>

801070ae <vector1>:
.globl vector1
vector1:
  pushl $0
801070ae:	6a 00                	push   $0x0
  pushl $1
801070b0:	6a 01                	push   $0x1
  jmp alltraps
801070b2:	e9 d8 fa ff ff       	jmp    80106b8f <alltraps>

801070b7 <vector2>:
.globl vector2
vector2:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $2
801070b9:	6a 02                	push   $0x2
  jmp alltraps
801070bb:	e9 cf fa ff ff       	jmp    80106b8f <alltraps>

801070c0 <vector3>:
.globl vector3
vector3:
  pushl $0
801070c0:	6a 00                	push   $0x0
  pushl $3
801070c2:	6a 03                	push   $0x3
  jmp alltraps
801070c4:	e9 c6 fa ff ff       	jmp    80106b8f <alltraps>

801070c9 <vector4>:
.globl vector4
vector4:
  pushl $0
801070c9:	6a 00                	push   $0x0
  pushl $4
801070cb:	6a 04                	push   $0x4
  jmp alltraps
801070cd:	e9 bd fa ff ff       	jmp    80106b8f <alltraps>

801070d2 <vector5>:
.globl vector5
vector5:
  pushl $0
801070d2:	6a 00                	push   $0x0
  pushl $5
801070d4:	6a 05                	push   $0x5
  jmp alltraps
801070d6:	e9 b4 fa ff ff       	jmp    80106b8f <alltraps>

801070db <vector6>:
.globl vector6
vector6:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $6
801070dd:	6a 06                	push   $0x6
  jmp alltraps
801070df:	e9 ab fa ff ff       	jmp    80106b8f <alltraps>

801070e4 <vector7>:
.globl vector7
vector7:
  pushl $0
801070e4:	6a 00                	push   $0x0
  pushl $7
801070e6:	6a 07                	push   $0x7
  jmp alltraps
801070e8:	e9 a2 fa ff ff       	jmp    80106b8f <alltraps>

801070ed <vector8>:
.globl vector8
vector8:
  pushl $8
801070ed:	6a 08                	push   $0x8
  jmp alltraps
801070ef:	e9 9b fa ff ff       	jmp    80106b8f <alltraps>

801070f4 <vector9>:
.globl vector9
vector9:
  pushl $0
801070f4:	6a 00                	push   $0x0
  pushl $9
801070f6:	6a 09                	push   $0x9
  jmp alltraps
801070f8:	e9 92 fa ff ff       	jmp    80106b8f <alltraps>

801070fd <vector10>:
.globl vector10
vector10:
  pushl $10
801070fd:	6a 0a                	push   $0xa
  jmp alltraps
801070ff:	e9 8b fa ff ff       	jmp    80106b8f <alltraps>

80107104 <vector11>:
.globl vector11
vector11:
  pushl $11
80107104:	6a 0b                	push   $0xb
  jmp alltraps
80107106:	e9 84 fa ff ff       	jmp    80106b8f <alltraps>

8010710b <vector12>:
.globl vector12
vector12:
  pushl $12
8010710b:	6a 0c                	push   $0xc
  jmp alltraps
8010710d:	e9 7d fa ff ff       	jmp    80106b8f <alltraps>

80107112 <vector13>:
.globl vector13
vector13:
  pushl $13
80107112:	6a 0d                	push   $0xd
  jmp alltraps
80107114:	e9 76 fa ff ff       	jmp    80106b8f <alltraps>

80107119 <vector14>:
.globl vector14
vector14:
  pushl $14
80107119:	6a 0e                	push   $0xe
  jmp alltraps
8010711b:	e9 6f fa ff ff       	jmp    80106b8f <alltraps>

80107120 <vector15>:
.globl vector15
vector15:
  pushl $0
80107120:	6a 00                	push   $0x0
  pushl $15
80107122:	6a 0f                	push   $0xf
  jmp alltraps
80107124:	e9 66 fa ff ff       	jmp    80106b8f <alltraps>

80107129 <vector16>:
.globl vector16
vector16:
  pushl $0
80107129:	6a 00                	push   $0x0
  pushl $16
8010712b:	6a 10                	push   $0x10
  jmp alltraps
8010712d:	e9 5d fa ff ff       	jmp    80106b8f <alltraps>

80107132 <vector17>:
.globl vector17
vector17:
  pushl $17
80107132:	6a 11                	push   $0x11
  jmp alltraps
80107134:	e9 56 fa ff ff       	jmp    80106b8f <alltraps>

80107139 <vector18>:
.globl vector18
vector18:
  pushl $0
80107139:	6a 00                	push   $0x0
  pushl $18
8010713b:	6a 12                	push   $0x12
  jmp alltraps
8010713d:	e9 4d fa ff ff       	jmp    80106b8f <alltraps>

80107142 <vector19>:
.globl vector19
vector19:
  pushl $0
80107142:	6a 00                	push   $0x0
  pushl $19
80107144:	6a 13                	push   $0x13
  jmp alltraps
80107146:	e9 44 fa ff ff       	jmp    80106b8f <alltraps>

8010714b <vector20>:
.globl vector20
vector20:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $20
8010714d:	6a 14                	push   $0x14
  jmp alltraps
8010714f:	e9 3b fa ff ff       	jmp    80106b8f <alltraps>

80107154 <vector21>:
.globl vector21
vector21:
  pushl $0
80107154:	6a 00                	push   $0x0
  pushl $21
80107156:	6a 15                	push   $0x15
  jmp alltraps
80107158:	e9 32 fa ff ff       	jmp    80106b8f <alltraps>

8010715d <vector22>:
.globl vector22
vector22:
  pushl $0
8010715d:	6a 00                	push   $0x0
  pushl $22
8010715f:	6a 16                	push   $0x16
  jmp alltraps
80107161:	e9 29 fa ff ff       	jmp    80106b8f <alltraps>

80107166 <vector23>:
.globl vector23
vector23:
  pushl $0
80107166:	6a 00                	push   $0x0
  pushl $23
80107168:	6a 17                	push   $0x17
  jmp alltraps
8010716a:	e9 20 fa ff ff       	jmp    80106b8f <alltraps>

8010716f <vector24>:
.globl vector24
vector24:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $24
80107171:	6a 18                	push   $0x18
  jmp alltraps
80107173:	e9 17 fa ff ff       	jmp    80106b8f <alltraps>

80107178 <vector25>:
.globl vector25
vector25:
  pushl $0
80107178:	6a 00                	push   $0x0
  pushl $25
8010717a:	6a 19                	push   $0x19
  jmp alltraps
8010717c:	e9 0e fa ff ff       	jmp    80106b8f <alltraps>

80107181 <vector26>:
.globl vector26
vector26:
  pushl $0
80107181:	6a 00                	push   $0x0
  pushl $26
80107183:	6a 1a                	push   $0x1a
  jmp alltraps
80107185:	e9 05 fa ff ff       	jmp    80106b8f <alltraps>

8010718a <vector27>:
.globl vector27
vector27:
  pushl $0
8010718a:	6a 00                	push   $0x0
  pushl $27
8010718c:	6a 1b                	push   $0x1b
  jmp alltraps
8010718e:	e9 fc f9 ff ff       	jmp    80106b8f <alltraps>

80107193 <vector28>:
.globl vector28
vector28:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $28
80107195:	6a 1c                	push   $0x1c
  jmp alltraps
80107197:	e9 f3 f9 ff ff       	jmp    80106b8f <alltraps>

8010719c <vector29>:
.globl vector29
vector29:
  pushl $0
8010719c:	6a 00                	push   $0x0
  pushl $29
8010719e:	6a 1d                	push   $0x1d
  jmp alltraps
801071a0:	e9 ea f9 ff ff       	jmp    80106b8f <alltraps>

801071a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801071a5:	6a 00                	push   $0x0
  pushl $30
801071a7:	6a 1e                	push   $0x1e
  jmp alltraps
801071a9:	e9 e1 f9 ff ff       	jmp    80106b8f <alltraps>

801071ae <vector31>:
.globl vector31
vector31:
  pushl $0
801071ae:	6a 00                	push   $0x0
  pushl $31
801071b0:	6a 1f                	push   $0x1f
  jmp alltraps
801071b2:	e9 d8 f9 ff ff       	jmp    80106b8f <alltraps>

801071b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $32
801071b9:	6a 20                	push   $0x20
  jmp alltraps
801071bb:	e9 cf f9 ff ff       	jmp    80106b8f <alltraps>

801071c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801071c0:	6a 00                	push   $0x0
  pushl $33
801071c2:	6a 21                	push   $0x21
  jmp alltraps
801071c4:	e9 c6 f9 ff ff       	jmp    80106b8f <alltraps>

801071c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801071c9:	6a 00                	push   $0x0
  pushl $34
801071cb:	6a 22                	push   $0x22
  jmp alltraps
801071cd:	e9 bd f9 ff ff       	jmp    80106b8f <alltraps>

801071d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801071d2:	6a 00                	push   $0x0
  pushl $35
801071d4:	6a 23                	push   $0x23
  jmp alltraps
801071d6:	e9 b4 f9 ff ff       	jmp    80106b8f <alltraps>

801071db <vector36>:
.globl vector36
vector36:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $36
801071dd:	6a 24                	push   $0x24
  jmp alltraps
801071df:	e9 ab f9 ff ff       	jmp    80106b8f <alltraps>

801071e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801071e4:	6a 00                	push   $0x0
  pushl $37
801071e6:	6a 25                	push   $0x25
  jmp alltraps
801071e8:	e9 a2 f9 ff ff       	jmp    80106b8f <alltraps>

801071ed <vector38>:
.globl vector38
vector38:
  pushl $0
801071ed:	6a 00                	push   $0x0
  pushl $38
801071ef:	6a 26                	push   $0x26
  jmp alltraps
801071f1:	e9 99 f9 ff ff       	jmp    80106b8f <alltraps>

801071f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801071f6:	6a 00                	push   $0x0
  pushl $39
801071f8:	6a 27                	push   $0x27
  jmp alltraps
801071fa:	e9 90 f9 ff ff       	jmp    80106b8f <alltraps>

801071ff <vector40>:
.globl vector40
vector40:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $40
80107201:	6a 28                	push   $0x28
  jmp alltraps
80107203:	e9 87 f9 ff ff       	jmp    80106b8f <alltraps>

80107208 <vector41>:
.globl vector41
vector41:
  pushl $0
80107208:	6a 00                	push   $0x0
  pushl $41
8010720a:	6a 29                	push   $0x29
  jmp alltraps
8010720c:	e9 7e f9 ff ff       	jmp    80106b8f <alltraps>

80107211 <vector42>:
.globl vector42
vector42:
  pushl $0
80107211:	6a 00                	push   $0x0
  pushl $42
80107213:	6a 2a                	push   $0x2a
  jmp alltraps
80107215:	e9 75 f9 ff ff       	jmp    80106b8f <alltraps>

8010721a <vector43>:
.globl vector43
vector43:
  pushl $0
8010721a:	6a 00                	push   $0x0
  pushl $43
8010721c:	6a 2b                	push   $0x2b
  jmp alltraps
8010721e:	e9 6c f9 ff ff       	jmp    80106b8f <alltraps>

80107223 <vector44>:
.globl vector44
vector44:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $44
80107225:	6a 2c                	push   $0x2c
  jmp alltraps
80107227:	e9 63 f9 ff ff       	jmp    80106b8f <alltraps>

8010722c <vector45>:
.globl vector45
vector45:
  pushl $0
8010722c:	6a 00                	push   $0x0
  pushl $45
8010722e:	6a 2d                	push   $0x2d
  jmp alltraps
80107230:	e9 5a f9 ff ff       	jmp    80106b8f <alltraps>

80107235 <vector46>:
.globl vector46
vector46:
  pushl $0
80107235:	6a 00                	push   $0x0
  pushl $46
80107237:	6a 2e                	push   $0x2e
  jmp alltraps
80107239:	e9 51 f9 ff ff       	jmp    80106b8f <alltraps>

8010723e <vector47>:
.globl vector47
vector47:
  pushl $0
8010723e:	6a 00                	push   $0x0
  pushl $47
80107240:	6a 2f                	push   $0x2f
  jmp alltraps
80107242:	e9 48 f9 ff ff       	jmp    80106b8f <alltraps>

80107247 <vector48>:
.globl vector48
vector48:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $48
80107249:	6a 30                	push   $0x30
  jmp alltraps
8010724b:	e9 3f f9 ff ff       	jmp    80106b8f <alltraps>

80107250 <vector49>:
.globl vector49
vector49:
  pushl $0
80107250:	6a 00                	push   $0x0
  pushl $49
80107252:	6a 31                	push   $0x31
  jmp alltraps
80107254:	e9 36 f9 ff ff       	jmp    80106b8f <alltraps>

80107259 <vector50>:
.globl vector50
vector50:
  pushl $0
80107259:	6a 00                	push   $0x0
  pushl $50
8010725b:	6a 32                	push   $0x32
  jmp alltraps
8010725d:	e9 2d f9 ff ff       	jmp    80106b8f <alltraps>

80107262 <vector51>:
.globl vector51
vector51:
  pushl $0
80107262:	6a 00                	push   $0x0
  pushl $51
80107264:	6a 33                	push   $0x33
  jmp alltraps
80107266:	e9 24 f9 ff ff       	jmp    80106b8f <alltraps>

8010726b <vector52>:
.globl vector52
vector52:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $52
8010726d:	6a 34                	push   $0x34
  jmp alltraps
8010726f:	e9 1b f9 ff ff       	jmp    80106b8f <alltraps>

80107274 <vector53>:
.globl vector53
vector53:
  pushl $0
80107274:	6a 00                	push   $0x0
  pushl $53
80107276:	6a 35                	push   $0x35
  jmp alltraps
80107278:	e9 12 f9 ff ff       	jmp    80106b8f <alltraps>

8010727d <vector54>:
.globl vector54
vector54:
  pushl $0
8010727d:	6a 00                	push   $0x0
  pushl $54
8010727f:	6a 36                	push   $0x36
  jmp alltraps
80107281:	e9 09 f9 ff ff       	jmp    80106b8f <alltraps>

80107286 <vector55>:
.globl vector55
vector55:
  pushl $0
80107286:	6a 00                	push   $0x0
  pushl $55
80107288:	6a 37                	push   $0x37
  jmp alltraps
8010728a:	e9 00 f9 ff ff       	jmp    80106b8f <alltraps>

8010728f <vector56>:
.globl vector56
vector56:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $56
80107291:	6a 38                	push   $0x38
  jmp alltraps
80107293:	e9 f7 f8 ff ff       	jmp    80106b8f <alltraps>

80107298 <vector57>:
.globl vector57
vector57:
  pushl $0
80107298:	6a 00                	push   $0x0
  pushl $57
8010729a:	6a 39                	push   $0x39
  jmp alltraps
8010729c:	e9 ee f8 ff ff       	jmp    80106b8f <alltraps>

801072a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801072a1:	6a 00                	push   $0x0
  pushl $58
801072a3:	6a 3a                	push   $0x3a
  jmp alltraps
801072a5:	e9 e5 f8 ff ff       	jmp    80106b8f <alltraps>

801072aa <vector59>:
.globl vector59
vector59:
  pushl $0
801072aa:	6a 00                	push   $0x0
  pushl $59
801072ac:	6a 3b                	push   $0x3b
  jmp alltraps
801072ae:	e9 dc f8 ff ff       	jmp    80106b8f <alltraps>

801072b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $60
801072b5:	6a 3c                	push   $0x3c
  jmp alltraps
801072b7:	e9 d3 f8 ff ff       	jmp    80106b8f <alltraps>

801072bc <vector61>:
.globl vector61
vector61:
  pushl $0
801072bc:	6a 00                	push   $0x0
  pushl $61
801072be:	6a 3d                	push   $0x3d
  jmp alltraps
801072c0:	e9 ca f8 ff ff       	jmp    80106b8f <alltraps>

801072c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801072c5:	6a 00                	push   $0x0
  pushl $62
801072c7:	6a 3e                	push   $0x3e
  jmp alltraps
801072c9:	e9 c1 f8 ff ff       	jmp    80106b8f <alltraps>

801072ce <vector63>:
.globl vector63
vector63:
  pushl $0
801072ce:	6a 00                	push   $0x0
  pushl $63
801072d0:	6a 3f                	push   $0x3f
  jmp alltraps
801072d2:	e9 b8 f8 ff ff       	jmp    80106b8f <alltraps>

801072d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $64
801072d9:	6a 40                	push   $0x40
  jmp alltraps
801072db:	e9 af f8 ff ff       	jmp    80106b8f <alltraps>

801072e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801072e0:	6a 00                	push   $0x0
  pushl $65
801072e2:	6a 41                	push   $0x41
  jmp alltraps
801072e4:	e9 a6 f8 ff ff       	jmp    80106b8f <alltraps>

801072e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801072e9:	6a 00                	push   $0x0
  pushl $66
801072eb:	6a 42                	push   $0x42
  jmp alltraps
801072ed:	e9 9d f8 ff ff       	jmp    80106b8f <alltraps>

801072f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801072f2:	6a 00                	push   $0x0
  pushl $67
801072f4:	6a 43                	push   $0x43
  jmp alltraps
801072f6:	e9 94 f8 ff ff       	jmp    80106b8f <alltraps>

801072fb <vector68>:
.globl vector68
vector68:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $68
801072fd:	6a 44                	push   $0x44
  jmp alltraps
801072ff:	e9 8b f8 ff ff       	jmp    80106b8f <alltraps>

80107304 <vector69>:
.globl vector69
vector69:
  pushl $0
80107304:	6a 00                	push   $0x0
  pushl $69
80107306:	6a 45                	push   $0x45
  jmp alltraps
80107308:	e9 82 f8 ff ff       	jmp    80106b8f <alltraps>

8010730d <vector70>:
.globl vector70
vector70:
  pushl $0
8010730d:	6a 00                	push   $0x0
  pushl $70
8010730f:	6a 46                	push   $0x46
  jmp alltraps
80107311:	e9 79 f8 ff ff       	jmp    80106b8f <alltraps>

80107316 <vector71>:
.globl vector71
vector71:
  pushl $0
80107316:	6a 00                	push   $0x0
  pushl $71
80107318:	6a 47                	push   $0x47
  jmp alltraps
8010731a:	e9 70 f8 ff ff       	jmp    80106b8f <alltraps>

8010731f <vector72>:
.globl vector72
vector72:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $72
80107321:	6a 48                	push   $0x48
  jmp alltraps
80107323:	e9 67 f8 ff ff       	jmp    80106b8f <alltraps>

80107328 <vector73>:
.globl vector73
vector73:
  pushl $0
80107328:	6a 00                	push   $0x0
  pushl $73
8010732a:	6a 49                	push   $0x49
  jmp alltraps
8010732c:	e9 5e f8 ff ff       	jmp    80106b8f <alltraps>

80107331 <vector74>:
.globl vector74
vector74:
  pushl $0
80107331:	6a 00                	push   $0x0
  pushl $74
80107333:	6a 4a                	push   $0x4a
  jmp alltraps
80107335:	e9 55 f8 ff ff       	jmp    80106b8f <alltraps>

8010733a <vector75>:
.globl vector75
vector75:
  pushl $0
8010733a:	6a 00                	push   $0x0
  pushl $75
8010733c:	6a 4b                	push   $0x4b
  jmp alltraps
8010733e:	e9 4c f8 ff ff       	jmp    80106b8f <alltraps>

80107343 <vector76>:
.globl vector76
vector76:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $76
80107345:	6a 4c                	push   $0x4c
  jmp alltraps
80107347:	e9 43 f8 ff ff       	jmp    80106b8f <alltraps>

8010734c <vector77>:
.globl vector77
vector77:
  pushl $0
8010734c:	6a 00                	push   $0x0
  pushl $77
8010734e:	6a 4d                	push   $0x4d
  jmp alltraps
80107350:	e9 3a f8 ff ff       	jmp    80106b8f <alltraps>

80107355 <vector78>:
.globl vector78
vector78:
  pushl $0
80107355:	6a 00                	push   $0x0
  pushl $78
80107357:	6a 4e                	push   $0x4e
  jmp alltraps
80107359:	e9 31 f8 ff ff       	jmp    80106b8f <alltraps>

8010735e <vector79>:
.globl vector79
vector79:
  pushl $0
8010735e:	6a 00                	push   $0x0
  pushl $79
80107360:	6a 4f                	push   $0x4f
  jmp alltraps
80107362:	e9 28 f8 ff ff       	jmp    80106b8f <alltraps>

80107367 <vector80>:
.globl vector80
vector80:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $80
80107369:	6a 50                	push   $0x50
  jmp alltraps
8010736b:	e9 1f f8 ff ff       	jmp    80106b8f <alltraps>

80107370 <vector81>:
.globl vector81
vector81:
  pushl $0
80107370:	6a 00                	push   $0x0
  pushl $81
80107372:	6a 51                	push   $0x51
  jmp alltraps
80107374:	e9 16 f8 ff ff       	jmp    80106b8f <alltraps>

80107379 <vector82>:
.globl vector82
vector82:
  pushl $0
80107379:	6a 00                	push   $0x0
  pushl $82
8010737b:	6a 52                	push   $0x52
  jmp alltraps
8010737d:	e9 0d f8 ff ff       	jmp    80106b8f <alltraps>

80107382 <vector83>:
.globl vector83
vector83:
  pushl $0
80107382:	6a 00                	push   $0x0
  pushl $83
80107384:	6a 53                	push   $0x53
  jmp alltraps
80107386:	e9 04 f8 ff ff       	jmp    80106b8f <alltraps>

8010738b <vector84>:
.globl vector84
vector84:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $84
8010738d:	6a 54                	push   $0x54
  jmp alltraps
8010738f:	e9 fb f7 ff ff       	jmp    80106b8f <alltraps>

80107394 <vector85>:
.globl vector85
vector85:
  pushl $0
80107394:	6a 00                	push   $0x0
  pushl $85
80107396:	6a 55                	push   $0x55
  jmp alltraps
80107398:	e9 f2 f7 ff ff       	jmp    80106b8f <alltraps>

8010739d <vector86>:
.globl vector86
vector86:
  pushl $0
8010739d:	6a 00                	push   $0x0
  pushl $86
8010739f:	6a 56                	push   $0x56
  jmp alltraps
801073a1:	e9 e9 f7 ff ff       	jmp    80106b8f <alltraps>

801073a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801073a6:	6a 00                	push   $0x0
  pushl $87
801073a8:	6a 57                	push   $0x57
  jmp alltraps
801073aa:	e9 e0 f7 ff ff       	jmp    80106b8f <alltraps>

801073af <vector88>:
.globl vector88
vector88:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $88
801073b1:	6a 58                	push   $0x58
  jmp alltraps
801073b3:	e9 d7 f7 ff ff       	jmp    80106b8f <alltraps>

801073b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801073b8:	6a 00                	push   $0x0
  pushl $89
801073ba:	6a 59                	push   $0x59
  jmp alltraps
801073bc:	e9 ce f7 ff ff       	jmp    80106b8f <alltraps>

801073c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801073c1:	6a 00                	push   $0x0
  pushl $90
801073c3:	6a 5a                	push   $0x5a
  jmp alltraps
801073c5:	e9 c5 f7 ff ff       	jmp    80106b8f <alltraps>

801073ca <vector91>:
.globl vector91
vector91:
  pushl $0
801073ca:	6a 00                	push   $0x0
  pushl $91
801073cc:	6a 5b                	push   $0x5b
  jmp alltraps
801073ce:	e9 bc f7 ff ff       	jmp    80106b8f <alltraps>

801073d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $92
801073d5:	6a 5c                	push   $0x5c
  jmp alltraps
801073d7:	e9 b3 f7 ff ff       	jmp    80106b8f <alltraps>

801073dc <vector93>:
.globl vector93
vector93:
  pushl $0
801073dc:	6a 00                	push   $0x0
  pushl $93
801073de:	6a 5d                	push   $0x5d
  jmp alltraps
801073e0:	e9 aa f7 ff ff       	jmp    80106b8f <alltraps>

801073e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801073e5:	6a 00                	push   $0x0
  pushl $94
801073e7:	6a 5e                	push   $0x5e
  jmp alltraps
801073e9:	e9 a1 f7 ff ff       	jmp    80106b8f <alltraps>

801073ee <vector95>:
.globl vector95
vector95:
  pushl $0
801073ee:	6a 00                	push   $0x0
  pushl $95
801073f0:	6a 5f                	push   $0x5f
  jmp alltraps
801073f2:	e9 98 f7 ff ff       	jmp    80106b8f <alltraps>

801073f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $96
801073f9:	6a 60                	push   $0x60
  jmp alltraps
801073fb:	e9 8f f7 ff ff       	jmp    80106b8f <alltraps>

80107400 <vector97>:
.globl vector97
vector97:
  pushl $0
80107400:	6a 00                	push   $0x0
  pushl $97
80107402:	6a 61                	push   $0x61
  jmp alltraps
80107404:	e9 86 f7 ff ff       	jmp    80106b8f <alltraps>

80107409 <vector98>:
.globl vector98
vector98:
  pushl $0
80107409:	6a 00                	push   $0x0
  pushl $98
8010740b:	6a 62                	push   $0x62
  jmp alltraps
8010740d:	e9 7d f7 ff ff       	jmp    80106b8f <alltraps>

80107412 <vector99>:
.globl vector99
vector99:
  pushl $0
80107412:	6a 00                	push   $0x0
  pushl $99
80107414:	6a 63                	push   $0x63
  jmp alltraps
80107416:	e9 74 f7 ff ff       	jmp    80106b8f <alltraps>

8010741b <vector100>:
.globl vector100
vector100:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $100
8010741d:	6a 64                	push   $0x64
  jmp alltraps
8010741f:	e9 6b f7 ff ff       	jmp    80106b8f <alltraps>

80107424 <vector101>:
.globl vector101
vector101:
  pushl $0
80107424:	6a 00                	push   $0x0
  pushl $101
80107426:	6a 65                	push   $0x65
  jmp alltraps
80107428:	e9 62 f7 ff ff       	jmp    80106b8f <alltraps>

8010742d <vector102>:
.globl vector102
vector102:
  pushl $0
8010742d:	6a 00                	push   $0x0
  pushl $102
8010742f:	6a 66                	push   $0x66
  jmp alltraps
80107431:	e9 59 f7 ff ff       	jmp    80106b8f <alltraps>

80107436 <vector103>:
.globl vector103
vector103:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $103
80107438:	6a 67                	push   $0x67
  jmp alltraps
8010743a:	e9 50 f7 ff ff       	jmp    80106b8f <alltraps>

8010743f <vector104>:
.globl vector104
vector104:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $104
80107441:	6a 68                	push   $0x68
  jmp alltraps
80107443:	e9 47 f7 ff ff       	jmp    80106b8f <alltraps>

80107448 <vector105>:
.globl vector105
vector105:
  pushl $0
80107448:	6a 00                	push   $0x0
  pushl $105
8010744a:	6a 69                	push   $0x69
  jmp alltraps
8010744c:	e9 3e f7 ff ff       	jmp    80106b8f <alltraps>

80107451 <vector106>:
.globl vector106
vector106:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $106
80107453:	6a 6a                	push   $0x6a
  jmp alltraps
80107455:	e9 35 f7 ff ff       	jmp    80106b8f <alltraps>

8010745a <vector107>:
.globl vector107
vector107:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $107
8010745c:	6a 6b                	push   $0x6b
  jmp alltraps
8010745e:	e9 2c f7 ff ff       	jmp    80106b8f <alltraps>

80107463 <vector108>:
.globl vector108
vector108:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $108
80107465:	6a 6c                	push   $0x6c
  jmp alltraps
80107467:	e9 23 f7 ff ff       	jmp    80106b8f <alltraps>

8010746c <vector109>:
.globl vector109
vector109:
  pushl $0
8010746c:	6a 00                	push   $0x0
  pushl $109
8010746e:	6a 6d                	push   $0x6d
  jmp alltraps
80107470:	e9 1a f7 ff ff       	jmp    80106b8f <alltraps>

80107475 <vector110>:
.globl vector110
vector110:
  pushl $0
80107475:	6a 00                	push   $0x0
  pushl $110
80107477:	6a 6e                	push   $0x6e
  jmp alltraps
80107479:	e9 11 f7 ff ff       	jmp    80106b8f <alltraps>

8010747e <vector111>:
.globl vector111
vector111:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $111
80107480:	6a 6f                	push   $0x6f
  jmp alltraps
80107482:	e9 08 f7 ff ff       	jmp    80106b8f <alltraps>

80107487 <vector112>:
.globl vector112
vector112:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $112
80107489:	6a 70                	push   $0x70
  jmp alltraps
8010748b:	e9 ff f6 ff ff       	jmp    80106b8f <alltraps>

80107490 <vector113>:
.globl vector113
vector113:
  pushl $0
80107490:	6a 00                	push   $0x0
  pushl $113
80107492:	6a 71                	push   $0x71
  jmp alltraps
80107494:	e9 f6 f6 ff ff       	jmp    80106b8f <alltraps>

80107499 <vector114>:
.globl vector114
vector114:
  pushl $0
80107499:	6a 00                	push   $0x0
  pushl $114
8010749b:	6a 72                	push   $0x72
  jmp alltraps
8010749d:	e9 ed f6 ff ff       	jmp    80106b8f <alltraps>

801074a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $115
801074a4:	6a 73                	push   $0x73
  jmp alltraps
801074a6:	e9 e4 f6 ff ff       	jmp    80106b8f <alltraps>

801074ab <vector116>:
.globl vector116
vector116:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $116
801074ad:	6a 74                	push   $0x74
  jmp alltraps
801074af:	e9 db f6 ff ff       	jmp    80106b8f <alltraps>

801074b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801074b4:	6a 00                	push   $0x0
  pushl $117
801074b6:	6a 75                	push   $0x75
  jmp alltraps
801074b8:	e9 d2 f6 ff ff       	jmp    80106b8f <alltraps>

801074bd <vector118>:
.globl vector118
vector118:
  pushl $0
801074bd:	6a 00                	push   $0x0
  pushl $118
801074bf:	6a 76                	push   $0x76
  jmp alltraps
801074c1:	e9 c9 f6 ff ff       	jmp    80106b8f <alltraps>

801074c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $119
801074c8:	6a 77                	push   $0x77
  jmp alltraps
801074ca:	e9 c0 f6 ff ff       	jmp    80106b8f <alltraps>

801074cf <vector120>:
.globl vector120
vector120:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $120
801074d1:	6a 78                	push   $0x78
  jmp alltraps
801074d3:	e9 b7 f6 ff ff       	jmp    80106b8f <alltraps>

801074d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801074d8:	6a 00                	push   $0x0
  pushl $121
801074da:	6a 79                	push   $0x79
  jmp alltraps
801074dc:	e9 ae f6 ff ff       	jmp    80106b8f <alltraps>

801074e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801074e1:	6a 00                	push   $0x0
  pushl $122
801074e3:	6a 7a                	push   $0x7a
  jmp alltraps
801074e5:	e9 a5 f6 ff ff       	jmp    80106b8f <alltraps>

801074ea <vector123>:
.globl vector123
vector123:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $123
801074ec:	6a 7b                	push   $0x7b
  jmp alltraps
801074ee:	e9 9c f6 ff ff       	jmp    80106b8f <alltraps>

801074f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $124
801074f5:	6a 7c                	push   $0x7c
  jmp alltraps
801074f7:	e9 93 f6 ff ff       	jmp    80106b8f <alltraps>

801074fc <vector125>:
.globl vector125
vector125:
  pushl $0
801074fc:	6a 00                	push   $0x0
  pushl $125
801074fe:	6a 7d                	push   $0x7d
  jmp alltraps
80107500:	e9 8a f6 ff ff       	jmp    80106b8f <alltraps>

80107505 <vector126>:
.globl vector126
vector126:
  pushl $0
80107505:	6a 00                	push   $0x0
  pushl $126
80107507:	6a 7e                	push   $0x7e
  jmp alltraps
80107509:	e9 81 f6 ff ff       	jmp    80106b8f <alltraps>

8010750e <vector127>:
.globl vector127
vector127:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $127
80107510:	6a 7f                	push   $0x7f
  jmp alltraps
80107512:	e9 78 f6 ff ff       	jmp    80106b8f <alltraps>

80107517 <vector128>:
.globl vector128
vector128:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $128
80107519:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010751e:	e9 6c f6 ff ff       	jmp    80106b8f <alltraps>

80107523 <vector129>:
.globl vector129
vector129:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $129
80107525:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010752a:	e9 60 f6 ff ff       	jmp    80106b8f <alltraps>

8010752f <vector130>:
.globl vector130
vector130:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $130
80107531:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107536:	e9 54 f6 ff ff       	jmp    80106b8f <alltraps>

8010753b <vector131>:
.globl vector131
vector131:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $131
8010753d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107542:	e9 48 f6 ff ff       	jmp    80106b8f <alltraps>

80107547 <vector132>:
.globl vector132
vector132:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $132
80107549:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010754e:	e9 3c f6 ff ff       	jmp    80106b8f <alltraps>

80107553 <vector133>:
.globl vector133
vector133:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $133
80107555:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010755a:	e9 30 f6 ff ff       	jmp    80106b8f <alltraps>

8010755f <vector134>:
.globl vector134
vector134:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $134
80107561:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107566:	e9 24 f6 ff ff       	jmp    80106b8f <alltraps>

8010756b <vector135>:
.globl vector135
vector135:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $135
8010756d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107572:	e9 18 f6 ff ff       	jmp    80106b8f <alltraps>

80107577 <vector136>:
.globl vector136
vector136:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $136
80107579:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010757e:	e9 0c f6 ff ff       	jmp    80106b8f <alltraps>

80107583 <vector137>:
.globl vector137
vector137:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $137
80107585:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010758a:	e9 00 f6 ff ff       	jmp    80106b8f <alltraps>

8010758f <vector138>:
.globl vector138
vector138:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $138
80107591:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107596:	e9 f4 f5 ff ff       	jmp    80106b8f <alltraps>

8010759b <vector139>:
.globl vector139
vector139:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $139
8010759d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801075a2:	e9 e8 f5 ff ff       	jmp    80106b8f <alltraps>

801075a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $140
801075a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801075ae:	e9 dc f5 ff ff       	jmp    80106b8f <alltraps>

801075b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $141
801075b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801075ba:	e9 d0 f5 ff ff       	jmp    80106b8f <alltraps>

801075bf <vector142>:
.globl vector142
vector142:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $142
801075c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801075c6:	e9 c4 f5 ff ff       	jmp    80106b8f <alltraps>

801075cb <vector143>:
.globl vector143
vector143:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $143
801075cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801075d2:	e9 b8 f5 ff ff       	jmp    80106b8f <alltraps>

801075d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $144
801075d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801075de:	e9 ac f5 ff ff       	jmp    80106b8f <alltraps>

801075e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $145
801075e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801075ea:	e9 a0 f5 ff ff       	jmp    80106b8f <alltraps>

801075ef <vector146>:
.globl vector146
vector146:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $146
801075f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801075f6:	e9 94 f5 ff ff       	jmp    80106b8f <alltraps>

801075fb <vector147>:
.globl vector147
vector147:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $147
801075fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107602:	e9 88 f5 ff ff       	jmp    80106b8f <alltraps>

80107607 <vector148>:
.globl vector148
vector148:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $148
80107609:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010760e:	e9 7c f5 ff ff       	jmp    80106b8f <alltraps>

80107613 <vector149>:
.globl vector149
vector149:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $149
80107615:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010761a:	e9 70 f5 ff ff       	jmp    80106b8f <alltraps>

8010761f <vector150>:
.globl vector150
vector150:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $150
80107621:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107626:	e9 64 f5 ff ff       	jmp    80106b8f <alltraps>

8010762b <vector151>:
.globl vector151
vector151:
  pushl $0
8010762b:	6a 00                	push   $0x0
  pushl $151
8010762d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107632:	e9 58 f5 ff ff       	jmp    80106b8f <alltraps>

80107637 <vector152>:
.globl vector152
vector152:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $152
80107639:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010763e:	e9 4c f5 ff ff       	jmp    80106b8f <alltraps>

80107643 <vector153>:
.globl vector153
vector153:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $153
80107645:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010764a:	e9 40 f5 ff ff       	jmp    80106b8f <alltraps>

8010764f <vector154>:
.globl vector154
vector154:
  pushl $0
8010764f:	6a 00                	push   $0x0
  pushl $154
80107651:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107656:	e9 34 f5 ff ff       	jmp    80106b8f <alltraps>

8010765b <vector155>:
.globl vector155
vector155:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $155
8010765d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107662:	e9 28 f5 ff ff       	jmp    80106b8f <alltraps>

80107667 <vector156>:
.globl vector156
vector156:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $156
80107669:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010766e:	e9 1c f5 ff ff       	jmp    80106b8f <alltraps>

80107673 <vector157>:
.globl vector157
vector157:
  pushl $0
80107673:	6a 00                	push   $0x0
  pushl $157
80107675:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010767a:	e9 10 f5 ff ff       	jmp    80106b8f <alltraps>

8010767f <vector158>:
.globl vector158
vector158:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $158
80107681:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107686:	e9 04 f5 ff ff       	jmp    80106b8f <alltraps>

8010768b <vector159>:
.globl vector159
vector159:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $159
8010768d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107692:	e9 f8 f4 ff ff       	jmp    80106b8f <alltraps>

80107697 <vector160>:
.globl vector160
vector160:
  pushl $0
80107697:	6a 00                	push   $0x0
  pushl $160
80107699:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010769e:	e9 ec f4 ff ff       	jmp    80106b8f <alltraps>

801076a3 <vector161>:
.globl vector161
vector161:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $161
801076a5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801076aa:	e9 e0 f4 ff ff       	jmp    80106b8f <alltraps>

801076af <vector162>:
.globl vector162
vector162:
  pushl $0
801076af:	6a 00                	push   $0x0
  pushl $162
801076b1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801076b6:	e9 d4 f4 ff ff       	jmp    80106b8f <alltraps>

801076bb <vector163>:
.globl vector163
vector163:
  pushl $0
801076bb:	6a 00                	push   $0x0
  pushl $163
801076bd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801076c2:	e9 c8 f4 ff ff       	jmp    80106b8f <alltraps>

801076c7 <vector164>:
.globl vector164
vector164:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $164
801076c9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801076ce:	e9 bc f4 ff ff       	jmp    80106b8f <alltraps>

801076d3 <vector165>:
.globl vector165
vector165:
  pushl $0
801076d3:	6a 00                	push   $0x0
  pushl $165
801076d5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801076da:	e9 b0 f4 ff ff       	jmp    80106b8f <alltraps>

801076df <vector166>:
.globl vector166
vector166:
  pushl $0
801076df:	6a 00                	push   $0x0
  pushl $166
801076e1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801076e6:	e9 a4 f4 ff ff       	jmp    80106b8f <alltraps>

801076eb <vector167>:
.globl vector167
vector167:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $167
801076ed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801076f2:	e9 98 f4 ff ff       	jmp    80106b8f <alltraps>

801076f7 <vector168>:
.globl vector168
vector168:
  pushl $0
801076f7:	6a 00                	push   $0x0
  pushl $168
801076f9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801076fe:	e9 8c f4 ff ff       	jmp    80106b8f <alltraps>

80107703 <vector169>:
.globl vector169
vector169:
  pushl $0
80107703:	6a 00                	push   $0x0
  pushl $169
80107705:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010770a:	e9 80 f4 ff ff       	jmp    80106b8f <alltraps>

8010770f <vector170>:
.globl vector170
vector170:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $170
80107711:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107716:	e9 74 f4 ff ff       	jmp    80106b8f <alltraps>

8010771b <vector171>:
.globl vector171
vector171:
  pushl $0
8010771b:	6a 00                	push   $0x0
  pushl $171
8010771d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107722:	e9 68 f4 ff ff       	jmp    80106b8f <alltraps>

80107727 <vector172>:
.globl vector172
vector172:
  pushl $0
80107727:	6a 00                	push   $0x0
  pushl $172
80107729:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010772e:	e9 5c f4 ff ff       	jmp    80106b8f <alltraps>

80107733 <vector173>:
.globl vector173
vector173:
  pushl $0
80107733:	6a 00                	push   $0x0
  pushl $173
80107735:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010773a:	e9 50 f4 ff ff       	jmp    80106b8f <alltraps>

8010773f <vector174>:
.globl vector174
vector174:
  pushl $0
8010773f:	6a 00                	push   $0x0
  pushl $174
80107741:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107746:	e9 44 f4 ff ff       	jmp    80106b8f <alltraps>

8010774b <vector175>:
.globl vector175
vector175:
  pushl $0
8010774b:	6a 00                	push   $0x0
  pushl $175
8010774d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107752:	e9 38 f4 ff ff       	jmp    80106b8f <alltraps>

80107757 <vector176>:
.globl vector176
vector176:
  pushl $0
80107757:	6a 00                	push   $0x0
  pushl $176
80107759:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010775e:	e9 2c f4 ff ff       	jmp    80106b8f <alltraps>

80107763 <vector177>:
.globl vector177
vector177:
  pushl $0
80107763:	6a 00                	push   $0x0
  pushl $177
80107765:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010776a:	e9 20 f4 ff ff       	jmp    80106b8f <alltraps>

8010776f <vector178>:
.globl vector178
vector178:
  pushl $0
8010776f:	6a 00                	push   $0x0
  pushl $178
80107771:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107776:	e9 14 f4 ff ff       	jmp    80106b8f <alltraps>

8010777b <vector179>:
.globl vector179
vector179:
  pushl $0
8010777b:	6a 00                	push   $0x0
  pushl $179
8010777d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107782:	e9 08 f4 ff ff       	jmp    80106b8f <alltraps>

80107787 <vector180>:
.globl vector180
vector180:
  pushl $0
80107787:	6a 00                	push   $0x0
  pushl $180
80107789:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010778e:	e9 fc f3 ff ff       	jmp    80106b8f <alltraps>

80107793 <vector181>:
.globl vector181
vector181:
  pushl $0
80107793:	6a 00                	push   $0x0
  pushl $181
80107795:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010779a:	e9 f0 f3 ff ff       	jmp    80106b8f <alltraps>

8010779f <vector182>:
.globl vector182
vector182:
  pushl $0
8010779f:	6a 00                	push   $0x0
  pushl $182
801077a1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801077a6:	e9 e4 f3 ff ff       	jmp    80106b8f <alltraps>

801077ab <vector183>:
.globl vector183
vector183:
  pushl $0
801077ab:	6a 00                	push   $0x0
  pushl $183
801077ad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801077b2:	e9 d8 f3 ff ff       	jmp    80106b8f <alltraps>

801077b7 <vector184>:
.globl vector184
vector184:
  pushl $0
801077b7:	6a 00                	push   $0x0
  pushl $184
801077b9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801077be:	e9 cc f3 ff ff       	jmp    80106b8f <alltraps>

801077c3 <vector185>:
.globl vector185
vector185:
  pushl $0
801077c3:	6a 00                	push   $0x0
  pushl $185
801077c5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801077ca:	e9 c0 f3 ff ff       	jmp    80106b8f <alltraps>

801077cf <vector186>:
.globl vector186
vector186:
  pushl $0
801077cf:	6a 00                	push   $0x0
  pushl $186
801077d1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801077d6:	e9 b4 f3 ff ff       	jmp    80106b8f <alltraps>

801077db <vector187>:
.globl vector187
vector187:
  pushl $0
801077db:	6a 00                	push   $0x0
  pushl $187
801077dd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801077e2:	e9 a8 f3 ff ff       	jmp    80106b8f <alltraps>

801077e7 <vector188>:
.globl vector188
vector188:
  pushl $0
801077e7:	6a 00                	push   $0x0
  pushl $188
801077e9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801077ee:	e9 9c f3 ff ff       	jmp    80106b8f <alltraps>

801077f3 <vector189>:
.globl vector189
vector189:
  pushl $0
801077f3:	6a 00                	push   $0x0
  pushl $189
801077f5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801077fa:	e9 90 f3 ff ff       	jmp    80106b8f <alltraps>

801077ff <vector190>:
.globl vector190
vector190:
  pushl $0
801077ff:	6a 00                	push   $0x0
  pushl $190
80107801:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107806:	e9 84 f3 ff ff       	jmp    80106b8f <alltraps>

8010780b <vector191>:
.globl vector191
vector191:
  pushl $0
8010780b:	6a 00                	push   $0x0
  pushl $191
8010780d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107812:	e9 78 f3 ff ff       	jmp    80106b8f <alltraps>

80107817 <vector192>:
.globl vector192
vector192:
  pushl $0
80107817:	6a 00                	push   $0x0
  pushl $192
80107819:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010781e:	e9 6c f3 ff ff       	jmp    80106b8f <alltraps>

80107823 <vector193>:
.globl vector193
vector193:
  pushl $0
80107823:	6a 00                	push   $0x0
  pushl $193
80107825:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010782a:	e9 60 f3 ff ff       	jmp    80106b8f <alltraps>

8010782f <vector194>:
.globl vector194
vector194:
  pushl $0
8010782f:	6a 00                	push   $0x0
  pushl $194
80107831:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107836:	e9 54 f3 ff ff       	jmp    80106b8f <alltraps>

8010783b <vector195>:
.globl vector195
vector195:
  pushl $0
8010783b:	6a 00                	push   $0x0
  pushl $195
8010783d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107842:	e9 48 f3 ff ff       	jmp    80106b8f <alltraps>

80107847 <vector196>:
.globl vector196
vector196:
  pushl $0
80107847:	6a 00                	push   $0x0
  pushl $196
80107849:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010784e:	e9 3c f3 ff ff       	jmp    80106b8f <alltraps>

80107853 <vector197>:
.globl vector197
vector197:
  pushl $0
80107853:	6a 00                	push   $0x0
  pushl $197
80107855:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010785a:	e9 30 f3 ff ff       	jmp    80106b8f <alltraps>

8010785f <vector198>:
.globl vector198
vector198:
  pushl $0
8010785f:	6a 00                	push   $0x0
  pushl $198
80107861:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107866:	e9 24 f3 ff ff       	jmp    80106b8f <alltraps>

8010786b <vector199>:
.globl vector199
vector199:
  pushl $0
8010786b:	6a 00                	push   $0x0
  pushl $199
8010786d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107872:	e9 18 f3 ff ff       	jmp    80106b8f <alltraps>

80107877 <vector200>:
.globl vector200
vector200:
  pushl $0
80107877:	6a 00                	push   $0x0
  pushl $200
80107879:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010787e:	e9 0c f3 ff ff       	jmp    80106b8f <alltraps>

80107883 <vector201>:
.globl vector201
vector201:
  pushl $0
80107883:	6a 00                	push   $0x0
  pushl $201
80107885:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010788a:	e9 00 f3 ff ff       	jmp    80106b8f <alltraps>

8010788f <vector202>:
.globl vector202
vector202:
  pushl $0
8010788f:	6a 00                	push   $0x0
  pushl $202
80107891:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107896:	e9 f4 f2 ff ff       	jmp    80106b8f <alltraps>

8010789b <vector203>:
.globl vector203
vector203:
  pushl $0
8010789b:	6a 00                	push   $0x0
  pushl $203
8010789d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801078a2:	e9 e8 f2 ff ff       	jmp    80106b8f <alltraps>

801078a7 <vector204>:
.globl vector204
vector204:
  pushl $0
801078a7:	6a 00                	push   $0x0
  pushl $204
801078a9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801078ae:	e9 dc f2 ff ff       	jmp    80106b8f <alltraps>

801078b3 <vector205>:
.globl vector205
vector205:
  pushl $0
801078b3:	6a 00                	push   $0x0
  pushl $205
801078b5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801078ba:	e9 d0 f2 ff ff       	jmp    80106b8f <alltraps>

801078bf <vector206>:
.globl vector206
vector206:
  pushl $0
801078bf:	6a 00                	push   $0x0
  pushl $206
801078c1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801078c6:	e9 c4 f2 ff ff       	jmp    80106b8f <alltraps>

801078cb <vector207>:
.globl vector207
vector207:
  pushl $0
801078cb:	6a 00                	push   $0x0
  pushl $207
801078cd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801078d2:	e9 b8 f2 ff ff       	jmp    80106b8f <alltraps>

801078d7 <vector208>:
.globl vector208
vector208:
  pushl $0
801078d7:	6a 00                	push   $0x0
  pushl $208
801078d9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801078de:	e9 ac f2 ff ff       	jmp    80106b8f <alltraps>

801078e3 <vector209>:
.globl vector209
vector209:
  pushl $0
801078e3:	6a 00                	push   $0x0
  pushl $209
801078e5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801078ea:	e9 a0 f2 ff ff       	jmp    80106b8f <alltraps>

801078ef <vector210>:
.globl vector210
vector210:
  pushl $0
801078ef:	6a 00                	push   $0x0
  pushl $210
801078f1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801078f6:	e9 94 f2 ff ff       	jmp    80106b8f <alltraps>

801078fb <vector211>:
.globl vector211
vector211:
  pushl $0
801078fb:	6a 00                	push   $0x0
  pushl $211
801078fd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107902:	e9 88 f2 ff ff       	jmp    80106b8f <alltraps>

80107907 <vector212>:
.globl vector212
vector212:
  pushl $0
80107907:	6a 00                	push   $0x0
  pushl $212
80107909:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010790e:	e9 7c f2 ff ff       	jmp    80106b8f <alltraps>

80107913 <vector213>:
.globl vector213
vector213:
  pushl $0
80107913:	6a 00                	push   $0x0
  pushl $213
80107915:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010791a:	e9 70 f2 ff ff       	jmp    80106b8f <alltraps>

8010791f <vector214>:
.globl vector214
vector214:
  pushl $0
8010791f:	6a 00                	push   $0x0
  pushl $214
80107921:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107926:	e9 64 f2 ff ff       	jmp    80106b8f <alltraps>

8010792b <vector215>:
.globl vector215
vector215:
  pushl $0
8010792b:	6a 00                	push   $0x0
  pushl $215
8010792d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107932:	e9 58 f2 ff ff       	jmp    80106b8f <alltraps>

80107937 <vector216>:
.globl vector216
vector216:
  pushl $0
80107937:	6a 00                	push   $0x0
  pushl $216
80107939:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010793e:	e9 4c f2 ff ff       	jmp    80106b8f <alltraps>

80107943 <vector217>:
.globl vector217
vector217:
  pushl $0
80107943:	6a 00                	push   $0x0
  pushl $217
80107945:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010794a:	e9 40 f2 ff ff       	jmp    80106b8f <alltraps>

8010794f <vector218>:
.globl vector218
vector218:
  pushl $0
8010794f:	6a 00                	push   $0x0
  pushl $218
80107951:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107956:	e9 34 f2 ff ff       	jmp    80106b8f <alltraps>

8010795b <vector219>:
.globl vector219
vector219:
  pushl $0
8010795b:	6a 00                	push   $0x0
  pushl $219
8010795d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107962:	e9 28 f2 ff ff       	jmp    80106b8f <alltraps>

80107967 <vector220>:
.globl vector220
vector220:
  pushl $0
80107967:	6a 00                	push   $0x0
  pushl $220
80107969:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010796e:	e9 1c f2 ff ff       	jmp    80106b8f <alltraps>

80107973 <vector221>:
.globl vector221
vector221:
  pushl $0
80107973:	6a 00                	push   $0x0
  pushl $221
80107975:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010797a:	e9 10 f2 ff ff       	jmp    80106b8f <alltraps>

8010797f <vector222>:
.globl vector222
vector222:
  pushl $0
8010797f:	6a 00                	push   $0x0
  pushl $222
80107981:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107986:	e9 04 f2 ff ff       	jmp    80106b8f <alltraps>

8010798b <vector223>:
.globl vector223
vector223:
  pushl $0
8010798b:	6a 00                	push   $0x0
  pushl $223
8010798d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107992:	e9 f8 f1 ff ff       	jmp    80106b8f <alltraps>

80107997 <vector224>:
.globl vector224
vector224:
  pushl $0
80107997:	6a 00                	push   $0x0
  pushl $224
80107999:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010799e:	e9 ec f1 ff ff       	jmp    80106b8f <alltraps>

801079a3 <vector225>:
.globl vector225
vector225:
  pushl $0
801079a3:	6a 00                	push   $0x0
  pushl $225
801079a5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801079aa:	e9 e0 f1 ff ff       	jmp    80106b8f <alltraps>

801079af <vector226>:
.globl vector226
vector226:
  pushl $0
801079af:	6a 00                	push   $0x0
  pushl $226
801079b1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801079b6:	e9 d4 f1 ff ff       	jmp    80106b8f <alltraps>

801079bb <vector227>:
.globl vector227
vector227:
  pushl $0
801079bb:	6a 00                	push   $0x0
  pushl $227
801079bd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801079c2:	e9 c8 f1 ff ff       	jmp    80106b8f <alltraps>

801079c7 <vector228>:
.globl vector228
vector228:
  pushl $0
801079c7:	6a 00                	push   $0x0
  pushl $228
801079c9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801079ce:	e9 bc f1 ff ff       	jmp    80106b8f <alltraps>

801079d3 <vector229>:
.globl vector229
vector229:
  pushl $0
801079d3:	6a 00                	push   $0x0
  pushl $229
801079d5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801079da:	e9 b0 f1 ff ff       	jmp    80106b8f <alltraps>

801079df <vector230>:
.globl vector230
vector230:
  pushl $0
801079df:	6a 00                	push   $0x0
  pushl $230
801079e1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801079e6:	e9 a4 f1 ff ff       	jmp    80106b8f <alltraps>

801079eb <vector231>:
.globl vector231
vector231:
  pushl $0
801079eb:	6a 00                	push   $0x0
  pushl $231
801079ed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801079f2:	e9 98 f1 ff ff       	jmp    80106b8f <alltraps>

801079f7 <vector232>:
.globl vector232
vector232:
  pushl $0
801079f7:	6a 00                	push   $0x0
  pushl $232
801079f9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801079fe:	e9 8c f1 ff ff       	jmp    80106b8f <alltraps>

80107a03 <vector233>:
.globl vector233
vector233:
  pushl $0
80107a03:	6a 00                	push   $0x0
  pushl $233
80107a05:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107a0a:	e9 80 f1 ff ff       	jmp    80106b8f <alltraps>

80107a0f <vector234>:
.globl vector234
vector234:
  pushl $0
80107a0f:	6a 00                	push   $0x0
  pushl $234
80107a11:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107a16:	e9 74 f1 ff ff       	jmp    80106b8f <alltraps>

80107a1b <vector235>:
.globl vector235
vector235:
  pushl $0
80107a1b:	6a 00                	push   $0x0
  pushl $235
80107a1d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107a22:	e9 68 f1 ff ff       	jmp    80106b8f <alltraps>

80107a27 <vector236>:
.globl vector236
vector236:
  pushl $0
80107a27:	6a 00                	push   $0x0
  pushl $236
80107a29:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107a2e:	e9 5c f1 ff ff       	jmp    80106b8f <alltraps>

80107a33 <vector237>:
.globl vector237
vector237:
  pushl $0
80107a33:	6a 00                	push   $0x0
  pushl $237
80107a35:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107a3a:	e9 50 f1 ff ff       	jmp    80106b8f <alltraps>

80107a3f <vector238>:
.globl vector238
vector238:
  pushl $0
80107a3f:	6a 00                	push   $0x0
  pushl $238
80107a41:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107a46:	e9 44 f1 ff ff       	jmp    80106b8f <alltraps>

80107a4b <vector239>:
.globl vector239
vector239:
  pushl $0
80107a4b:	6a 00                	push   $0x0
  pushl $239
80107a4d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107a52:	e9 38 f1 ff ff       	jmp    80106b8f <alltraps>

80107a57 <vector240>:
.globl vector240
vector240:
  pushl $0
80107a57:	6a 00                	push   $0x0
  pushl $240
80107a59:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107a5e:	e9 2c f1 ff ff       	jmp    80106b8f <alltraps>

80107a63 <vector241>:
.globl vector241
vector241:
  pushl $0
80107a63:	6a 00                	push   $0x0
  pushl $241
80107a65:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107a6a:	e9 20 f1 ff ff       	jmp    80106b8f <alltraps>

80107a6f <vector242>:
.globl vector242
vector242:
  pushl $0
80107a6f:	6a 00                	push   $0x0
  pushl $242
80107a71:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107a76:	e9 14 f1 ff ff       	jmp    80106b8f <alltraps>

80107a7b <vector243>:
.globl vector243
vector243:
  pushl $0
80107a7b:	6a 00                	push   $0x0
  pushl $243
80107a7d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107a82:	e9 08 f1 ff ff       	jmp    80106b8f <alltraps>

80107a87 <vector244>:
.globl vector244
vector244:
  pushl $0
80107a87:	6a 00                	push   $0x0
  pushl $244
80107a89:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107a8e:	e9 fc f0 ff ff       	jmp    80106b8f <alltraps>

80107a93 <vector245>:
.globl vector245
vector245:
  pushl $0
80107a93:	6a 00                	push   $0x0
  pushl $245
80107a95:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107a9a:	e9 f0 f0 ff ff       	jmp    80106b8f <alltraps>

80107a9f <vector246>:
.globl vector246
vector246:
  pushl $0
80107a9f:	6a 00                	push   $0x0
  pushl $246
80107aa1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107aa6:	e9 e4 f0 ff ff       	jmp    80106b8f <alltraps>

80107aab <vector247>:
.globl vector247
vector247:
  pushl $0
80107aab:	6a 00                	push   $0x0
  pushl $247
80107aad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107ab2:	e9 d8 f0 ff ff       	jmp    80106b8f <alltraps>

80107ab7 <vector248>:
.globl vector248
vector248:
  pushl $0
80107ab7:	6a 00                	push   $0x0
  pushl $248
80107ab9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107abe:	e9 cc f0 ff ff       	jmp    80106b8f <alltraps>

80107ac3 <vector249>:
.globl vector249
vector249:
  pushl $0
80107ac3:	6a 00                	push   $0x0
  pushl $249
80107ac5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107aca:	e9 c0 f0 ff ff       	jmp    80106b8f <alltraps>

80107acf <vector250>:
.globl vector250
vector250:
  pushl $0
80107acf:	6a 00                	push   $0x0
  pushl $250
80107ad1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107ad6:	e9 b4 f0 ff ff       	jmp    80106b8f <alltraps>

80107adb <vector251>:
.globl vector251
vector251:
  pushl $0
80107adb:	6a 00                	push   $0x0
  pushl $251
80107add:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107ae2:	e9 a8 f0 ff ff       	jmp    80106b8f <alltraps>

80107ae7 <vector252>:
.globl vector252
vector252:
  pushl $0
80107ae7:	6a 00                	push   $0x0
  pushl $252
80107ae9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107aee:	e9 9c f0 ff ff       	jmp    80106b8f <alltraps>

80107af3 <vector253>:
.globl vector253
vector253:
  pushl $0
80107af3:	6a 00                	push   $0x0
  pushl $253
80107af5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107afa:	e9 90 f0 ff ff       	jmp    80106b8f <alltraps>

80107aff <vector254>:
.globl vector254
vector254:
  pushl $0
80107aff:	6a 00                	push   $0x0
  pushl $254
80107b01:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107b06:	e9 84 f0 ff ff       	jmp    80106b8f <alltraps>

80107b0b <vector255>:
.globl vector255
vector255:
  pushl $0
80107b0b:	6a 00                	push   $0x0
  pushl $255
80107b0d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107b12:	e9 78 f0 ff ff       	jmp    80106b8f <alltraps>
80107b17:	66 90                	xchg   %ax,%ax
80107b19:	66 90                	xchg   %ax,%ax
80107b1b:	66 90                	xchg   %ax,%ax
80107b1d:	66 90                	xchg   %ax,%ax
80107b1f:	90                   	nop

80107b20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107b20:	55                   	push   %ebp
80107b21:	89 e5                	mov    %esp,%ebp
80107b23:	57                   	push   %edi
80107b24:	56                   	push   %esi
80107b25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107b26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80107b2c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107b32:	83 ec 1c             	sub    $0x1c,%esp
80107b35:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107b38:	39 d3                	cmp    %edx,%ebx
80107b3a:	73 49                	jae    80107b85 <deallocuvm.part.0+0x65>
80107b3c:	89 c7                	mov    %eax,%edi
80107b3e:	eb 0c                	jmp    80107b4c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107b40:	83 c0 01             	add    $0x1,%eax
80107b43:	c1 e0 16             	shl    $0x16,%eax
80107b46:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107b48:	39 da                	cmp    %ebx,%edx
80107b4a:	76 39                	jbe    80107b85 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80107b4c:	89 d8                	mov    %ebx,%eax
80107b4e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107b51:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107b54:	f6 c1 01             	test   $0x1,%cl
80107b57:	74 e7                	je     80107b40 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107b59:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b5b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107b61:	c1 ee 0a             	shr    $0xa,%esi
80107b64:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80107b6a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107b71:	85 f6                	test   %esi,%esi
80107b73:	74 cb                	je     80107b40 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107b75:	8b 06                	mov    (%esi),%eax
80107b77:	a8 01                	test   $0x1,%al
80107b79:	75 15                	jne    80107b90 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80107b7b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107b81:	39 da                	cmp    %ebx,%edx
80107b83:	77 c7                	ja     80107b4c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107b85:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b8b:	5b                   	pop    %ebx
80107b8c:	5e                   	pop    %esi
80107b8d:	5f                   	pop    %edi
80107b8e:	5d                   	pop    %ebp
80107b8f:	c3                   	ret    
      if(pa == 0)
80107b90:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b95:	74 25                	je     80107bbc <deallocuvm.part.0+0x9c>
      kfree(v);
80107b97:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107b9a:	05 00 00 00 80       	add    $0x80000000,%eax
80107b9f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107ba2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107ba8:	50                   	push   %eax
80107ba9:	e8 42 b6 ff ff       	call   801031f0 <kfree>
      *pte = 0;
80107bae:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107bb4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107bb7:	83 c4 10             	add    $0x10,%esp
80107bba:	eb 8c                	jmp    80107b48 <deallocuvm.part.0+0x28>
        panic("kfree");
80107bbc:	83 ec 0c             	sub    $0xc,%esp
80107bbf:	68 d2 87 10 80       	push   $0x801087d2
80107bc4:	e8 27 89 ff ff       	call   801004f0 <panic>
80107bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107bd0 <mappages>:
{
80107bd0:	55                   	push   %ebp
80107bd1:	89 e5                	mov    %esp,%ebp
80107bd3:	57                   	push   %edi
80107bd4:	56                   	push   %esi
80107bd5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107bd6:	89 d3                	mov    %edx,%ebx
80107bd8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107bde:	83 ec 1c             	sub    $0x1c,%esp
80107be1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107be4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107be8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107bed:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80107bf3:	29 d8                	sub    %ebx,%eax
80107bf5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107bf8:	eb 3d                	jmp    80107c37 <mappages+0x67>
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107c00:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107c07:	c1 ea 0a             	shr    $0xa,%edx
80107c0a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c10:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107c17:	85 c0                	test   %eax,%eax
80107c19:	74 75                	je     80107c90 <mappages+0xc0>
    if(*pte & PTE_P)
80107c1b:	f6 00 01             	testb  $0x1,(%eax)
80107c1e:	0f 85 86 00 00 00    	jne    80107caa <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107c24:	0b 75 0c             	or     0xc(%ebp),%esi
80107c27:	83 ce 01             	or     $0x1,%esi
80107c2a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107c2c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80107c2f:	74 6f                	je     80107ca0 <mappages+0xd0>
    a += PGSIZE;
80107c31:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107c37:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80107c3a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107c3d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107c40:	89 d8                	mov    %ebx,%eax
80107c42:	c1 e8 16             	shr    $0x16,%eax
80107c45:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107c48:	8b 07                	mov    (%edi),%eax
80107c4a:	a8 01                	test   $0x1,%al
80107c4c:	75 b2                	jne    80107c00 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107c4e:	e8 5d b7 ff ff       	call   801033b0 <kalloc>
80107c53:	85 c0                	test   %eax,%eax
80107c55:	74 39                	je     80107c90 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107c57:	83 ec 04             	sub    $0x4,%esp
80107c5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107c5d:	68 00 10 00 00       	push   $0x1000
80107c62:	6a 00                	push   $0x0
80107c64:	50                   	push   %eax
80107c65:	e8 f6 d8 ff ff       	call   80105560 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107c6a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80107c6d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107c70:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107c76:	83 c8 07             	or     $0x7,%eax
80107c79:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107c7b:	89 d8                	mov    %ebx,%eax
80107c7d:	c1 e8 0a             	shr    $0xa,%eax
80107c80:	25 fc 0f 00 00       	and    $0xffc,%eax
80107c85:	01 d0                	add    %edx,%eax
80107c87:	eb 92                	jmp    80107c1b <mappages+0x4b>
80107c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c98:	5b                   	pop    %ebx
80107c99:	5e                   	pop    %esi
80107c9a:	5f                   	pop    %edi
80107c9b:	5d                   	pop    %ebp
80107c9c:	c3                   	ret    
80107c9d:	8d 76 00             	lea    0x0(%esi),%esi
80107ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107ca3:	31 c0                	xor    %eax,%eax
}
80107ca5:	5b                   	pop    %ebx
80107ca6:	5e                   	pop    %esi
80107ca7:	5f                   	pop    %edi
80107ca8:	5d                   	pop    %ebp
80107ca9:	c3                   	ret    
      panic("remap");
80107caa:	83 ec 0c             	sub    $0xc,%esp
80107cad:	68 24 8f 10 80       	push   $0x80108f24
80107cb2:	e8 39 88 ff ff       	call   801004f0 <panic>
80107cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cbe:	66 90                	xchg   %ax,%ax

80107cc0 <seginit>:
{
80107cc0:	55                   	push   %ebp
80107cc1:	89 e5                	mov    %esp,%ebp
80107cc3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107cc6:	e8 e5 c9 ff ff       	call   801046b0 <cpuid>
  pd[0] = size-1;
80107ccb:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107cd0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107cd6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107cda:	c7 80 b8 3e 11 80 ff 	movl   $0xffff,-0x7feec148(%eax)
80107ce1:	ff 00 00 
80107ce4:	c7 80 bc 3e 11 80 00 	movl   $0xcf9a00,-0x7feec144(%eax)
80107ceb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107cee:	c7 80 c0 3e 11 80 ff 	movl   $0xffff,-0x7feec140(%eax)
80107cf5:	ff 00 00 
80107cf8:	c7 80 c4 3e 11 80 00 	movl   $0xcf9200,-0x7feec13c(%eax)
80107cff:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d02:	c7 80 c8 3e 11 80 ff 	movl   $0xffff,-0x7feec138(%eax)
80107d09:	ff 00 00 
80107d0c:	c7 80 cc 3e 11 80 00 	movl   $0xcffa00,-0x7feec134(%eax)
80107d13:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107d16:	c7 80 d0 3e 11 80 ff 	movl   $0xffff,-0x7feec130(%eax)
80107d1d:	ff 00 00 
80107d20:	c7 80 d4 3e 11 80 00 	movl   $0xcff200,-0x7feec12c(%eax)
80107d27:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107d2a:	05 b0 3e 11 80       	add    $0x80113eb0,%eax
  pd[1] = (uint)p;
80107d2f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107d33:	c1 e8 10             	shr    $0x10,%eax
80107d36:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107d3a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107d3d:	0f 01 10             	lgdtl  (%eax)
}
80107d40:	c9                   	leave  
80107d41:	c3                   	ret    
80107d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107d50 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d50:	a1 64 88 11 80       	mov    0x80118864,%eax
80107d55:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107d5a:	0f 22 d8             	mov    %eax,%cr3
}
80107d5d:	c3                   	ret    
80107d5e:	66 90                	xchg   %ax,%ax

80107d60 <switchuvm>:
{
80107d60:	55                   	push   %ebp
80107d61:	89 e5                	mov    %esp,%ebp
80107d63:	57                   	push   %edi
80107d64:	56                   	push   %esi
80107d65:	53                   	push   %ebx
80107d66:	83 ec 1c             	sub    $0x1c,%esp
80107d69:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107d6c:	85 f6                	test   %esi,%esi
80107d6e:	0f 84 cb 00 00 00    	je     80107e3f <switchuvm+0xdf>
  if(p->kstack == 0)
80107d74:	8b 46 74             	mov    0x74(%esi),%eax
80107d77:	85 c0                	test   %eax,%eax
80107d79:	0f 84 da 00 00 00    	je     80107e59 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107d7f:	8b 46 70             	mov    0x70(%esi),%eax
80107d82:	85 c0                	test   %eax,%eax
80107d84:	0f 84 c2 00 00 00    	je     80107e4c <switchuvm+0xec>
  pushcli();
80107d8a:	e8 c1 d5 ff ff       	call   80105350 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107d8f:	e8 bc c8 ff ff       	call   80104650 <mycpu>
80107d94:	89 c3                	mov    %eax,%ebx
80107d96:	e8 b5 c8 ff ff       	call   80104650 <mycpu>
80107d9b:	89 c7                	mov    %eax,%edi
80107d9d:	e8 ae c8 ff ff       	call   80104650 <mycpu>
80107da2:	83 c7 08             	add    $0x8,%edi
80107da5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107da8:	e8 a3 c8 ff ff       	call   80104650 <mycpu>
80107dad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107db0:	ba 67 00 00 00       	mov    $0x67,%edx
80107db5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107dbc:	83 c0 08             	add    $0x8,%eax
80107dbf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107dc6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107dcb:	83 c1 08             	add    $0x8,%ecx
80107dce:	c1 e8 18             	shr    $0x18,%eax
80107dd1:	c1 e9 10             	shr    $0x10,%ecx
80107dd4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107dda:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107de0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107de5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107dec:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107df1:	e8 5a c8 ff ff       	call   80104650 <mycpu>
80107df6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107dfd:	e8 4e c8 ff ff       	call   80104650 <mycpu>
80107e02:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107e06:	8b 5e 74             	mov    0x74(%esi),%ebx
80107e09:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e0f:	e8 3c c8 ff ff       	call   80104650 <mycpu>
80107e14:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107e17:	e8 34 c8 ff ff       	call   80104650 <mycpu>
80107e1c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107e20:	b8 28 00 00 00       	mov    $0x28,%eax
80107e25:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107e28:	8b 46 70             	mov    0x70(%esi),%eax
80107e2b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107e30:	0f 22 d8             	mov    %eax,%cr3
}
80107e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e36:	5b                   	pop    %ebx
80107e37:	5e                   	pop    %esi
80107e38:	5f                   	pop    %edi
80107e39:	5d                   	pop    %ebp
  popcli();
80107e3a:	e9 61 d5 ff ff       	jmp    801053a0 <popcli>
    panic("switchuvm: no process");
80107e3f:	83 ec 0c             	sub    $0xc,%esp
80107e42:	68 2a 8f 10 80       	push   $0x80108f2a
80107e47:	e8 a4 86 ff ff       	call   801004f0 <panic>
    panic("switchuvm: no pgdir");
80107e4c:	83 ec 0c             	sub    $0xc,%esp
80107e4f:	68 55 8f 10 80       	push   $0x80108f55
80107e54:	e8 97 86 ff ff       	call   801004f0 <panic>
    panic("switchuvm: no kstack");
80107e59:	83 ec 0c             	sub    $0xc,%esp
80107e5c:	68 40 8f 10 80       	push   $0x80108f40
80107e61:	e8 8a 86 ff ff       	call   801004f0 <panic>
80107e66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e6d:	8d 76 00             	lea    0x0(%esi),%esi

80107e70 <inituvm>:
{
80107e70:	55                   	push   %ebp
80107e71:	89 e5                	mov    %esp,%ebp
80107e73:	57                   	push   %edi
80107e74:	56                   	push   %esi
80107e75:	53                   	push   %ebx
80107e76:	83 ec 1c             	sub    $0x1c,%esp
80107e79:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e7c:	8b 75 10             	mov    0x10(%ebp),%esi
80107e7f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107e82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107e85:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107e8b:	77 4b                	ja     80107ed8 <inituvm+0x68>
  mem = kalloc();
80107e8d:	e8 1e b5 ff ff       	call   801033b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107e92:	83 ec 04             	sub    $0x4,%esp
80107e95:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80107e9a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107e9c:	6a 00                	push   $0x0
80107e9e:	50                   	push   %eax
80107e9f:	e8 bc d6 ff ff       	call   80105560 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107ea4:	58                   	pop    %eax
80107ea5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107eab:	5a                   	pop    %edx
80107eac:	6a 06                	push   $0x6
80107eae:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107eb3:	31 d2                	xor    %edx,%edx
80107eb5:	50                   	push   %eax
80107eb6:	89 f8                	mov    %edi,%eax
80107eb8:	e8 13 fd ff ff       	call   80107bd0 <mappages>
  memmove(mem, init, sz);
80107ebd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ec0:	89 75 10             	mov    %esi,0x10(%ebp)
80107ec3:	83 c4 10             	add    $0x10,%esp
80107ec6:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107ec9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ecf:	5b                   	pop    %ebx
80107ed0:	5e                   	pop    %esi
80107ed1:	5f                   	pop    %edi
80107ed2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107ed3:	e9 18 d7 ff ff       	jmp    801055f0 <memmove>
    panic("inituvm: more than a page");
80107ed8:	83 ec 0c             	sub    $0xc,%esp
80107edb:	68 69 8f 10 80       	push   $0x80108f69
80107ee0:	e8 0b 86 ff ff       	call   801004f0 <panic>
80107ee5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107ef0 <loaduvm>:
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	57                   	push   %edi
80107ef4:	56                   	push   %esi
80107ef5:	53                   	push   %ebx
80107ef6:	83 ec 1c             	sub    $0x1c,%esp
80107ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107efc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107eff:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107f04:	0f 85 bb 00 00 00    	jne    80107fc5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80107f0a:	01 f0                	add    %esi,%eax
80107f0c:	89 f3                	mov    %esi,%ebx
80107f0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f11:	8b 45 14             	mov    0x14(%ebp),%eax
80107f14:	01 f0                	add    %esi,%eax
80107f16:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107f19:	85 f6                	test   %esi,%esi
80107f1b:	0f 84 87 00 00 00    	je     80107fa8 <loaduvm+0xb8>
80107f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107f28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80107f2b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107f2e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107f30:	89 c2                	mov    %eax,%edx
80107f32:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107f35:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107f38:	f6 c2 01             	test   $0x1,%dl
80107f3b:	75 13                	jne    80107f50 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80107f3d:	83 ec 0c             	sub    $0xc,%esp
80107f40:	68 83 8f 10 80       	push   $0x80108f83
80107f45:	e8 a6 85 ff ff       	call   801004f0 <panic>
80107f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107f50:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107f53:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107f59:	25 fc 0f 00 00       	and    $0xffc,%eax
80107f5e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107f65:	85 c0                	test   %eax,%eax
80107f67:	74 d4                	je     80107f3d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107f69:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f6b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107f6e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107f73:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107f78:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107f7e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f81:	29 d9                	sub    %ebx,%ecx
80107f83:	05 00 00 00 80       	add    $0x80000000,%eax
80107f88:	57                   	push   %edi
80107f89:	51                   	push   %ecx
80107f8a:	50                   	push   %eax
80107f8b:	ff 75 10             	push   0x10(%ebp)
80107f8e:	e8 2d a8 ff ff       	call   801027c0 <readi>
80107f93:	83 c4 10             	add    $0x10,%esp
80107f96:	39 f8                	cmp    %edi,%eax
80107f98:	75 1e                	jne    80107fb8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107f9a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107fa0:	89 f0                	mov    %esi,%eax
80107fa2:	29 d8                	sub    %ebx,%eax
80107fa4:	39 c6                	cmp    %eax,%esi
80107fa6:	77 80                	ja     80107f28 <loaduvm+0x38>
}
80107fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107fab:	31 c0                	xor    %eax,%eax
}
80107fad:	5b                   	pop    %ebx
80107fae:	5e                   	pop    %esi
80107faf:	5f                   	pop    %edi
80107fb0:	5d                   	pop    %ebp
80107fb1:	c3                   	ret    
80107fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107fbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107fc0:	5b                   	pop    %ebx
80107fc1:	5e                   	pop    %esi
80107fc2:	5f                   	pop    %edi
80107fc3:	5d                   	pop    %ebp
80107fc4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107fc5:	83 ec 0c             	sub    $0xc,%esp
80107fc8:	68 24 90 10 80       	push   $0x80109024
80107fcd:	e8 1e 85 ff ff       	call   801004f0 <panic>
80107fd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107fe0 <allocuvm>:
{
80107fe0:	55                   	push   %ebp
80107fe1:	89 e5                	mov    %esp,%ebp
80107fe3:	57                   	push   %edi
80107fe4:	56                   	push   %esi
80107fe5:	53                   	push   %ebx
80107fe6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107fe9:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107fec:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107fef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ff2:	85 c0                	test   %eax,%eax
80107ff4:	0f 88 b6 00 00 00    	js     801080b0 <allocuvm+0xd0>
  if(newsz < oldsz)
80107ffa:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107ffd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80108000:	0f 82 9a 00 00 00    	jb     801080a0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80108006:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010800c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80108012:	39 75 10             	cmp    %esi,0x10(%ebp)
80108015:	77 44                	ja     8010805b <allocuvm+0x7b>
80108017:	e9 87 00 00 00       	jmp    801080a3 <allocuvm+0xc3>
8010801c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80108020:	83 ec 04             	sub    $0x4,%esp
80108023:	68 00 10 00 00       	push   $0x1000
80108028:	6a 00                	push   $0x0
8010802a:	50                   	push   %eax
8010802b:	e8 30 d5 ff ff       	call   80105560 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108030:	58                   	pop    %eax
80108031:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108037:	5a                   	pop    %edx
80108038:	6a 06                	push   $0x6
8010803a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010803f:	89 f2                	mov    %esi,%edx
80108041:	50                   	push   %eax
80108042:	89 f8                	mov    %edi,%eax
80108044:	e8 87 fb ff ff       	call   80107bd0 <mappages>
80108049:	83 c4 10             	add    $0x10,%esp
8010804c:	85 c0                	test   %eax,%eax
8010804e:	78 78                	js     801080c8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80108050:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108056:	39 75 10             	cmp    %esi,0x10(%ebp)
80108059:	76 48                	jbe    801080a3 <allocuvm+0xc3>
    mem = kalloc();
8010805b:	e8 50 b3 ff ff       	call   801033b0 <kalloc>
80108060:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80108062:	85 c0                	test   %eax,%eax
80108064:	75 ba                	jne    80108020 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108066:	83 ec 0c             	sub    $0xc,%esp
80108069:	68 a1 8f 10 80       	push   $0x80108fa1
8010806e:	e8 fd 89 ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
80108073:	8b 45 0c             	mov    0xc(%ebp),%eax
80108076:	83 c4 10             	add    $0x10,%esp
80108079:	39 45 10             	cmp    %eax,0x10(%ebp)
8010807c:	74 32                	je     801080b0 <allocuvm+0xd0>
8010807e:	8b 55 10             	mov    0x10(%ebp),%edx
80108081:	89 c1                	mov    %eax,%ecx
80108083:	89 f8                	mov    %edi,%eax
80108085:	e8 96 fa ff ff       	call   80107b20 <deallocuvm.part.0>
      return 0;
8010808a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108091:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108094:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108097:	5b                   	pop    %ebx
80108098:	5e                   	pop    %esi
80108099:	5f                   	pop    %edi
8010809a:	5d                   	pop    %ebp
8010809b:	c3                   	ret    
8010809c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801080a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801080a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080a9:	5b                   	pop    %ebx
801080aa:	5e                   	pop    %esi
801080ab:	5f                   	pop    %edi
801080ac:	5d                   	pop    %ebp
801080ad:	c3                   	ret    
801080ae:	66 90                	xchg   %ax,%ax
    return 0;
801080b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801080b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080bd:	5b                   	pop    %ebx
801080be:	5e                   	pop    %esi
801080bf:	5f                   	pop    %edi
801080c0:	5d                   	pop    %ebp
801080c1:	c3                   	ret    
801080c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801080c8:	83 ec 0c             	sub    $0xc,%esp
801080cb:	68 b9 8f 10 80       	push   $0x80108fb9
801080d0:	e8 9b 89 ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
801080d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801080d8:	83 c4 10             	add    $0x10,%esp
801080db:	39 45 10             	cmp    %eax,0x10(%ebp)
801080de:	74 0c                	je     801080ec <allocuvm+0x10c>
801080e0:	8b 55 10             	mov    0x10(%ebp),%edx
801080e3:	89 c1                	mov    %eax,%ecx
801080e5:	89 f8                	mov    %edi,%eax
801080e7:	e8 34 fa ff ff       	call   80107b20 <deallocuvm.part.0>
      kfree(mem);
801080ec:	83 ec 0c             	sub    $0xc,%esp
801080ef:	53                   	push   %ebx
801080f0:	e8 fb b0 ff ff       	call   801031f0 <kfree>
      return 0;
801080f5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801080fc:	83 c4 10             	add    $0x10,%esp
}
801080ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108102:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108105:	5b                   	pop    %ebx
80108106:	5e                   	pop    %esi
80108107:	5f                   	pop    %edi
80108108:	5d                   	pop    %ebp
80108109:	c3                   	ret    
8010810a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108110 <deallocuvm>:
{
80108110:	55                   	push   %ebp
80108111:	89 e5                	mov    %esp,%ebp
80108113:	8b 55 0c             	mov    0xc(%ebp),%edx
80108116:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108119:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010811c:	39 d1                	cmp    %edx,%ecx
8010811e:	73 10                	jae    80108130 <deallocuvm+0x20>
}
80108120:	5d                   	pop    %ebp
80108121:	e9 fa f9 ff ff       	jmp    80107b20 <deallocuvm.part.0>
80108126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010812d:	8d 76 00             	lea    0x0(%esi),%esi
80108130:	89 d0                	mov    %edx,%eax
80108132:	5d                   	pop    %ebp
80108133:	c3                   	ret    
80108134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010813b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010813f:	90                   	nop

80108140 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108140:	55                   	push   %ebp
80108141:	89 e5                	mov    %esp,%ebp
80108143:	57                   	push   %edi
80108144:	56                   	push   %esi
80108145:	53                   	push   %ebx
80108146:	83 ec 0c             	sub    $0xc,%esp
80108149:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010814c:	85 f6                	test   %esi,%esi
8010814e:	74 59                	je     801081a9 <freevm+0x69>
  if(newsz >= oldsz)
80108150:	31 c9                	xor    %ecx,%ecx
80108152:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108157:	89 f0                	mov    %esi,%eax
80108159:	89 f3                	mov    %esi,%ebx
8010815b:	e8 c0 f9 ff ff       	call   80107b20 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108160:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108166:	eb 0f                	jmp    80108177 <freevm+0x37>
80108168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010816f:	90                   	nop
80108170:	83 c3 04             	add    $0x4,%ebx
80108173:	39 df                	cmp    %ebx,%edi
80108175:	74 23                	je     8010819a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108177:	8b 03                	mov    (%ebx),%eax
80108179:	a8 01                	test   $0x1,%al
8010817b:	74 f3                	je     80108170 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010817d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108182:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108185:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108188:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010818d:	50                   	push   %eax
8010818e:	e8 5d b0 ff ff       	call   801031f0 <kfree>
80108193:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108196:	39 df                	cmp    %ebx,%edi
80108198:	75 dd                	jne    80108177 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010819a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010819d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081a0:	5b                   	pop    %ebx
801081a1:	5e                   	pop    %esi
801081a2:	5f                   	pop    %edi
801081a3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801081a4:	e9 47 b0 ff ff       	jmp    801031f0 <kfree>
    panic("freevm: no pgdir");
801081a9:	83 ec 0c             	sub    $0xc,%esp
801081ac:	68 d5 8f 10 80       	push   $0x80108fd5
801081b1:	e8 3a 83 ff ff       	call   801004f0 <panic>
801081b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081bd:	8d 76 00             	lea    0x0(%esi),%esi

801081c0 <setupkvm>:
{
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	56                   	push   %esi
801081c4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801081c5:	e8 e6 b1 ff ff       	call   801033b0 <kalloc>
801081ca:	89 c6                	mov    %eax,%esi
801081cc:	85 c0                	test   %eax,%eax
801081ce:	74 42                	je     80108212 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801081d0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801081d3:	bb 80 c4 10 80       	mov    $0x8010c480,%ebx
  memset(pgdir, 0, PGSIZE);
801081d8:	68 00 10 00 00       	push   $0x1000
801081dd:	6a 00                	push   $0x0
801081df:	50                   	push   %eax
801081e0:	e8 7b d3 ff ff       	call   80105560 <memset>
801081e5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801081e8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801081eb:	83 ec 08             	sub    $0x8,%esp
801081ee:	8b 4b 08             	mov    0x8(%ebx),%ecx
801081f1:	ff 73 0c             	push   0xc(%ebx)
801081f4:	8b 13                	mov    (%ebx),%edx
801081f6:	50                   	push   %eax
801081f7:	29 c1                	sub    %eax,%ecx
801081f9:	89 f0                	mov    %esi,%eax
801081fb:	e8 d0 f9 ff ff       	call   80107bd0 <mappages>
80108200:	83 c4 10             	add    $0x10,%esp
80108203:	85 c0                	test   %eax,%eax
80108205:	78 19                	js     80108220 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108207:	83 c3 10             	add    $0x10,%ebx
8010820a:	81 fb c0 c4 10 80    	cmp    $0x8010c4c0,%ebx
80108210:	75 d6                	jne    801081e8 <setupkvm+0x28>
}
80108212:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108215:	89 f0                	mov    %esi,%eax
80108217:	5b                   	pop    %ebx
80108218:	5e                   	pop    %esi
80108219:	5d                   	pop    %ebp
8010821a:	c3                   	ret    
8010821b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010821f:	90                   	nop
      freevm(pgdir);
80108220:	83 ec 0c             	sub    $0xc,%esp
80108223:	56                   	push   %esi
      return 0;
80108224:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108226:	e8 15 ff ff ff       	call   80108140 <freevm>
      return 0;
8010822b:	83 c4 10             	add    $0x10,%esp
}
8010822e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108231:	89 f0                	mov    %esi,%eax
80108233:	5b                   	pop    %ebx
80108234:	5e                   	pop    %esi
80108235:	5d                   	pop    %ebp
80108236:	c3                   	ret    
80108237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010823e:	66 90                	xchg   %ax,%ax

80108240 <kvmalloc>:
{
80108240:	55                   	push   %ebp
80108241:	89 e5                	mov    %esp,%ebp
80108243:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108246:	e8 75 ff ff ff       	call   801081c0 <setupkvm>
8010824b:	a3 64 88 11 80       	mov    %eax,0x80118864
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108250:	05 00 00 00 80       	add    $0x80000000,%eax
80108255:	0f 22 d8             	mov    %eax,%cr3
}
80108258:	c9                   	leave  
80108259:	c3                   	ret    
8010825a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108260 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108260:	55                   	push   %ebp
80108261:	89 e5                	mov    %esp,%ebp
80108263:	83 ec 08             	sub    $0x8,%esp
80108266:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108269:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010826c:	89 c1                	mov    %eax,%ecx
8010826e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108271:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108274:	f6 c2 01             	test   $0x1,%dl
80108277:	75 17                	jne    80108290 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80108279:	83 ec 0c             	sub    $0xc,%esp
8010827c:	68 e6 8f 10 80       	push   $0x80108fe6
80108281:	e8 6a 82 ff ff       	call   801004f0 <panic>
80108286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010828d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108290:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108293:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108299:	25 fc 0f 00 00       	and    $0xffc,%eax
8010829e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801082a5:	85 c0                	test   %eax,%eax
801082a7:	74 d0                	je     80108279 <clearpteu+0x19>
  *pte &= ~PTE_U;
801082a9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801082ac:	c9                   	leave  
801082ad:	c3                   	ret    
801082ae:	66 90                	xchg   %ax,%ax

801082b0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801082b0:	55                   	push   %ebp
801082b1:	89 e5                	mov    %esp,%ebp
801082b3:	57                   	push   %edi
801082b4:	56                   	push   %esi
801082b5:	53                   	push   %ebx
801082b6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801082b9:	e8 02 ff ff ff       	call   801081c0 <setupkvm>
801082be:	89 45 e0             	mov    %eax,-0x20(%ebp)
801082c1:	85 c0                	test   %eax,%eax
801082c3:	0f 84 bd 00 00 00    	je     80108386 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801082c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801082cc:	85 c9                	test   %ecx,%ecx
801082ce:	0f 84 b2 00 00 00    	je     80108386 <copyuvm+0xd6>
801082d4:	31 f6                	xor    %esi,%esi
801082d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082dd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
801082e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801082e3:	89 f0                	mov    %esi,%eax
801082e5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801082e8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801082eb:	a8 01                	test   $0x1,%al
801082ed:	75 11                	jne    80108300 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801082ef:	83 ec 0c             	sub    $0xc,%esp
801082f2:	68 f0 8f 10 80       	push   $0x80108ff0
801082f7:	e8 f4 81 ff ff       	call   801004f0 <panic>
801082fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80108300:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108302:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108307:	c1 ea 0a             	shr    $0xa,%edx
8010830a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108310:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108317:	85 c0                	test   %eax,%eax
80108319:	74 d4                	je     801082ef <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010831b:	8b 00                	mov    (%eax),%eax
8010831d:	a8 01                	test   $0x1,%al
8010831f:	0f 84 9f 00 00 00    	je     801083c4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108325:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108327:	25 ff 0f 00 00       	and    $0xfff,%eax
8010832c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010832f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108335:	e8 76 b0 ff ff       	call   801033b0 <kalloc>
8010833a:	89 c3                	mov    %eax,%ebx
8010833c:	85 c0                	test   %eax,%eax
8010833e:	74 64                	je     801083a4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108340:	83 ec 04             	sub    $0x4,%esp
80108343:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108349:	68 00 10 00 00       	push   $0x1000
8010834e:	57                   	push   %edi
8010834f:	50                   	push   %eax
80108350:	e8 9b d2 ff ff       	call   801055f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108355:	58                   	pop    %eax
80108356:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010835c:	5a                   	pop    %edx
8010835d:	ff 75 e4             	push   -0x1c(%ebp)
80108360:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108365:	89 f2                	mov    %esi,%edx
80108367:	50                   	push   %eax
80108368:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010836b:	e8 60 f8 ff ff       	call   80107bd0 <mappages>
80108370:	83 c4 10             	add    $0x10,%esp
80108373:	85 c0                	test   %eax,%eax
80108375:	78 21                	js     80108398 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80108377:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010837d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108380:	0f 87 5a ff ff ff    	ja     801082e0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108386:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108389:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010838c:	5b                   	pop    %ebx
8010838d:	5e                   	pop    %esi
8010838e:	5f                   	pop    %edi
8010838f:	5d                   	pop    %ebp
80108390:	c3                   	ret    
80108391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108398:	83 ec 0c             	sub    $0xc,%esp
8010839b:	53                   	push   %ebx
8010839c:	e8 4f ae ff ff       	call   801031f0 <kfree>
      goto bad;
801083a1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801083a4:	83 ec 0c             	sub    $0xc,%esp
801083a7:	ff 75 e0             	push   -0x20(%ebp)
801083aa:	e8 91 fd ff ff       	call   80108140 <freevm>
  return 0;
801083af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801083b6:	83 c4 10             	add    $0x10,%esp
}
801083b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801083bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083bf:	5b                   	pop    %ebx
801083c0:	5e                   	pop    %esi
801083c1:	5f                   	pop    %edi
801083c2:	5d                   	pop    %ebp
801083c3:	c3                   	ret    
      panic("copyuvm: page not present");
801083c4:	83 ec 0c             	sub    $0xc,%esp
801083c7:	68 0a 90 10 80       	push   $0x8010900a
801083cc:	e8 1f 81 ff ff       	call   801004f0 <panic>
801083d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083df:	90                   	nop

801083e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801083e0:	55                   	push   %ebp
801083e1:	89 e5                	mov    %esp,%ebp
801083e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801083e6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801083e9:	89 c1                	mov    %eax,%ecx
801083eb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801083ee:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801083f1:	f6 c2 01             	test   $0x1,%dl
801083f4:	0f 84 00 01 00 00    	je     801084fa <uva2ka.cold>
  return &pgtab[PTX(va)];
801083fa:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801083fd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108403:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80108404:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80108409:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80108410:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108412:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108417:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010841a:	05 00 00 00 80       	add    $0x80000000,%eax
8010841f:	83 fa 05             	cmp    $0x5,%edx
80108422:	ba 00 00 00 00       	mov    $0x0,%edx
80108427:	0f 45 c2             	cmovne %edx,%eax
}
8010842a:	c3                   	ret    
8010842b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010842f:	90                   	nop

80108430 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108430:	55                   	push   %ebp
80108431:	89 e5                	mov    %esp,%ebp
80108433:	57                   	push   %edi
80108434:	56                   	push   %esi
80108435:	53                   	push   %ebx
80108436:	83 ec 0c             	sub    $0xc,%esp
80108439:	8b 75 14             	mov    0x14(%ebp),%esi
8010843c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010843f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108442:	85 f6                	test   %esi,%esi
80108444:	75 51                	jne    80108497 <copyout+0x67>
80108446:	e9 a5 00 00 00       	jmp    801084f0 <copyout+0xc0>
8010844b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010844f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80108450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108456:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010845c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80108462:	74 75                	je     801084d9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80108464:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108466:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80108469:	29 c3                	sub    %eax,%ebx
8010846b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108471:	39 f3                	cmp    %esi,%ebx
80108473:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80108476:	29 f8                	sub    %edi,%eax
80108478:	83 ec 04             	sub    $0x4,%esp
8010847b:	01 c1                	add    %eax,%ecx
8010847d:	53                   	push   %ebx
8010847e:	52                   	push   %edx
8010847f:	51                   	push   %ecx
80108480:	e8 6b d1 ff ff       	call   801055f0 <memmove>
    len -= n;
    buf += n;
80108485:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108488:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010848e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108491:	01 da                	add    %ebx,%edx
  while(len > 0){
80108493:	29 de                	sub    %ebx,%esi
80108495:	74 59                	je     801084f0 <copyout+0xc0>
  if(*pde & PTE_P){
80108497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010849a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010849c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010849e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801084a1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801084a7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801084aa:	f6 c1 01             	test   $0x1,%cl
801084ad:	0f 84 4e 00 00 00    	je     80108501 <copyout.cold>
  return &pgtab[PTX(va)];
801084b3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801084b5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801084bb:	c1 eb 0c             	shr    $0xc,%ebx
801084be:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801084c4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801084cb:	89 d9                	mov    %ebx,%ecx
801084cd:	83 e1 05             	and    $0x5,%ecx
801084d0:	83 f9 05             	cmp    $0x5,%ecx
801084d3:	0f 84 77 ff ff ff    	je     80108450 <copyout+0x20>
  }
  return 0;
}
801084d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801084dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801084e1:	5b                   	pop    %ebx
801084e2:	5e                   	pop    %esi
801084e3:	5f                   	pop    %edi
801084e4:	5d                   	pop    %ebp
801084e5:	c3                   	ret    
801084e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084ed:	8d 76 00             	lea    0x0(%esi),%esi
801084f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801084f3:	31 c0                	xor    %eax,%eax
}
801084f5:	5b                   	pop    %ebx
801084f6:	5e                   	pop    %esi
801084f7:	5f                   	pop    %edi
801084f8:	5d                   	pop    %ebp
801084f9:	c3                   	ret    

801084fa <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801084fa:	a1 00 00 00 00       	mov    0x0,%eax
801084ff:	0f 0b                	ud2    

80108501 <copyout.cold>:
80108501:	a1 00 00 00 00       	mov    0x0,%eax
80108506:	0f 0b                	ud2    
