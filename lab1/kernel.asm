
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 10 6b 11 80       	mov    $0x80116b10,%esp
8010002d:	b8 80 3d 10 80       	mov    $0x80103d80,%eax
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
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 c0 7e 10 80       	push   $0x80107ec0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 95 50 00 00       	call   801050f0 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 c7 7e 10 80       	push   $0x80107ec7
80100097:	50                   	push   %eax
80100098:	e8 23 4f 00 00       	call   80104fc0 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 d7 51 00 00       	call   801052c0 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
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
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 f9 50 00 00       	call   80105260 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 4e 00 00       	call   80105000 <acquiresleep>
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
8010018c:	e8 6f 2e 00 00       	call   80103000 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ce 7e 10 80       	push   $0x80107ece
801001a6:	e8 45 03 00 00       	call   801004f0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 dd 4e 00 00       	call   801050a0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
801001d4:	e9 27 2e 00 00       	jmp    80103000 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 df 7e 10 80       	push   $0x80107edf
801001e1:	e8 0a 03 00 00       	call   801004f0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 4e 00 00       	call   801050a0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 4c 4e 00 00       	call   80105060 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 a0 50 00 00       	call   801052c0 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
8010026c:	e9 ef 4f 00 00       	jmp    80105260 <release>
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 e6 7e 10 80       	push   $0x80107ee6
80100279:	e8 72 02 00 00       	call   801004f0 <panic>
8010027e:	66 90                	xchg   %ax,%ax

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
80100344:	e8 37 22 00 00       	call   80102580 <iunlock>
  acquire(&cons.lock);
80100349:	c7 04 24 60 05 11 80 	movl   $0x80110560,(%esp)
80100350:	e8 6b 4f 00 00       	call   801052c0 <acquire>
  while(n > 0){
80100355:	83 c4 10             	add    $0x10,%esp
80100358:	85 db                	test   %ebx,%ebx
8010035a:	0f 8e 94 00 00 00    	jle    801003f4 <consoleread+0xc4>
    while(input.r == input.w){
80100360:	a1 40 05 11 80       	mov    0x80110540,%eax
80100365:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
8010036b:	74 25                	je     80100392 <consoleread+0x62>
8010036d:	eb 59                	jmp    801003c8 <consoleread+0x98>
8010036f:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100370:	83 ec 08             	sub    $0x8,%esp
80100373:	68 60 05 11 80       	push   $0x80110560
80100378:	68 40 05 11 80       	push   $0x80110540
8010037d:	e8 de 49 00 00       	call   80104d60 <sleep>
    while(input.r == input.w){
80100382:	a1 40 05 11 80       	mov    0x80110540,%eax
80100387:	83 c4 10             	add    $0x10,%esp
8010038a:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
80100390:	75 36                	jne    801003c8 <consoleread+0x98>
      if(myproc()->killed){
80100392:	e8 f9 42 00 00       	call   80104690 <myproc>
80100397:	8b 48 24             	mov    0x24(%eax),%ecx
8010039a:	85 c9                	test   %ecx,%ecx
8010039c:	74 d2                	je     80100370 <consoleread+0x40>
        release(&cons.lock);
8010039e:	83 ec 0c             	sub    $0xc,%esp
801003a1:	68 60 05 11 80       	push   $0x80110560
801003a6:	e8 b5 4e 00 00       	call   80105260 <release>
        ilock(ip);
801003ab:	5a                   	pop    %edx
801003ac:	ff 75 08             	push   0x8(%ebp)
801003af:	e8 ec 20 00 00       	call   801024a0 <ilock>
        return -1;
801003b4:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801003b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
801003ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801003bf:	5b                   	pop    %ebx
801003c0:	5e                   	pop    %esi
801003c1:	5f                   	pop    %edi
801003c2:	5d                   	pop    %ebp
801003c3:	c3                   	ret    
801003c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
801003c8:	8d 50 01             	lea    0x1(%eax),%edx
801003cb:	89 15 40 05 11 80    	mov    %edx,0x80110540
801003d1:	89 c2                	mov    %eax,%edx
801003d3:	83 e2 7f             	and    $0x7f,%edx
801003d6:	0f be 8a c0 04 11 80 	movsbl -0x7feefb40(%edx),%ecx
    if(c == C('D')){  // EOF
801003dd:	80 f9 04             	cmp    $0x4,%cl
801003e0:	74 37                	je     80100419 <consoleread+0xe9>
    *dst++ = c;
801003e2:	83 c6 01             	add    $0x1,%esi
    --n;
801003e5:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
801003e8:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801003eb:	83 f9 0a             	cmp    $0xa,%ecx
801003ee:	0f 85 64 ff ff ff    	jne    80100358 <consoleread+0x28>
  release(&cons.lock);
801003f4:	83 ec 0c             	sub    $0xc,%esp
801003f7:	68 60 05 11 80       	push   $0x80110560
801003fc:	e8 5f 4e 00 00       	call   80105260 <release>
  ilock(ip);
80100401:	58                   	pop    %eax
80100402:	ff 75 08             	push   0x8(%ebp)
80100405:	e8 96 20 00 00       	call   801024a0 <ilock>
  return target - n;
8010040a:	89 f8                	mov    %edi,%eax
8010040c:	83 c4 10             	add    $0x10,%esp
}
8010040f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100412:	29 d8                	sub    %ebx,%eax
}
80100414:	5b                   	pop    %ebx
80100415:	5e                   	pop    %esi
80100416:	5f                   	pop    %edi
80100417:	5d                   	pop    %ebp
80100418:	c3                   	ret    
      if(n < target){
80100419:	39 fb                	cmp    %edi,%ebx
8010041b:	73 d7                	jae    801003f4 <consoleread+0xc4>
        input.r--;
8010041d:	a3 40 05 11 80       	mov    %eax,0x80110540
80100422:	eb d0                	jmp    801003f4 <consoleread+0xc4>
80100424:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010042b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010042f:	90                   	nop

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
8010043d:	a1 44 05 11 80       	mov    0x80110544,%eax
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
80100450:	0f b6 9e c0 04 11 80 	movzbl -0x7feefb40(%esi),%ebx
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
801004be:	0f b6 86 bf 04 11 80 	movzbl -0x7feefb41(%esi),%eax
801004c5:	8d 50 d6             	lea    -0x2a(%eax),%edx
801004c8:	80 fa 01             	cmp    $0x1,%dl
801004cb:	76 0f                	jbe    801004dc <read_num.constprop.0+0xac>
801004cd:	83 e0 fd             	and    $0xfffffffd,%eax
801004d0:	3c 2d                	cmp    $0x2d,%al
801004d2:	74 08                	je     801004dc <read_num.constprop.0+0xac>
    else if ((input.buf[i]==45) && (i==(int)input.r))
801004d4:	39 35 40 05 11 80    	cmp    %esi,0x80110540
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
801004f9:	c7 05 94 05 11 80 00 	movl   $0x0,0x80110594
80100500:	00 00 00 
  getcallerpcs(&s, pcs);
80100503:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100506:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100509:	e8 02 31 00 00       	call   80103610 <lapicid>
8010050e:	83 ec 08             	sub    $0x8,%esp
80100511:	50                   	push   %eax
80100512:	68 ed 7e 10 80       	push   $0x80107eed
80100517:	e8 54 05 00 00       	call   80100a70 <cprintf>
  cprintf(s);
8010051c:	58                   	pop    %eax
8010051d:	ff 75 08             	push   0x8(%ebp)
80100520:	e8 4b 05 00 00       	call   80100a70 <cprintf>
  cprintf("\n");
80100525:	c7 04 24 57 88 10 80 	movl   $0x80108857,(%esp)
8010052c:	e8 3f 05 00 00       	call   80100a70 <cprintf>
  getcallerpcs(&s, pcs);
80100531:	8d 45 08             	lea    0x8(%ebp),%eax
80100534:	5a                   	pop    %edx
80100535:	59                   	pop    %ecx
80100536:	53                   	push   %ebx
80100537:	50                   	push   %eax
80100538:	e8 d3 4b 00 00       	call   80105110 <getcallerpcs>
  for(i=0; i<10; i++)
8010053d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100540:	83 ec 08             	sub    $0x8,%esp
80100543:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100545:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100548:	68 01 7f 10 80       	push   $0x80107f01
8010054d:	e8 1e 05 00 00       	call   80100a70 <cprintf>
  for(i=0; i<10; i++)
80100552:	83 c4 10             	add    $0x10,%esp
80100555:	39 f3                	cmp    %esi,%ebx
80100557:	75 e7                	jne    80100540 <panic+0x50>
  panicked = 1; // freeze other CPU
80100559:	c7 05 9c 05 11 80 01 	movl   $0x1,0x8011059c
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
801005f8:	e8 23 4e 00 00       	call   80105420 <memmove>
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
801005fd:	b8 80 07 00 00       	mov    $0x780,%eax
80100602:	83 c4 0c             	add    $0xc,%esp
80100605:	29 d8                	sub    %ebx,%eax
80100607:	01 c0                	add    %eax,%eax
80100609:	50                   	push   %eax
8010060a:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100611:	6a 00                	push   $0x0
80100613:	50                   	push   %eax
80100614:	e8 67 4d 00 00       	call   80105380 <memset>
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
80100650:	8b 15 98 05 11 80    	mov    0x80110598,%edx
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
8010067e:	a1 48 05 11 80       	mov    0x80110548,%eax
80100683:	8d 70 ff             	lea    -0x1(%eax),%esi
80100686:	0f b6 b8 bf 04 11 80 	movzbl -0x7feefb41(%eax),%edi
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
8010068d:	29 d6                	sub    %edx,%esi
8010068f:	39 c6                	cmp    %eax,%esi
80100691:	73 19                	jae    801006ac <cgaputc+0x13c>
80100693:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100697:	90                   	nop
    input.buf[i] = input.buf[i - 1]; // shift to right all letters in buffer
80100698:	0f b6 90 bf 04 11 80 	movzbl -0x7feefb41(%eax),%edx
8010069f:	83 e8 01             	sub    $0x1,%eax
801006a2:	88 90 c1 04 11 80    	mov    %dl,-0x7feefb3f(%eax)
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
801006b4:	88 86 c0 04 11 80    	mov    %al,-0x7feefb40(%esi)
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
801006d7:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
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
801006f8:	8b 35 98 05 11 80    	mov    0x80110598,%esi
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
8010072c:	8b 15 48 05 11 80    	mov    0x80110548,%edx
80100732:	89 d1                	mov    %edx,%ecx
80100734:	29 f1                	sub    %esi,%ecx
80100736:	89 ce                	mov    %ecx,%esi
80100738:	39 ca                	cmp    %ecx,%edx
8010073a:	76 49                	jbe    80100785 <cgaputc+0x215>
8010073c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010073f:	90                   	nop
    input.buf[i] = input.buf[i + 1]; // shift to left all letters in buffer
80100740:	0f b6 86 c1 04 11 80 	movzbl -0x7feefb3f(%esi),%eax
80100747:	83 c6 01             	add    $0x1,%esi
8010074a:	88 86 bf 04 11 80    	mov    %al,-0x7feefb41(%esi)
  for (int i = input.e - backs; i < input.e; i++ )// jadid
80100750:	39 f2                	cmp    %esi,%edx
80100752:	75 ec                	jne    80100740 <cgaputc+0x1d0>
    saveInp.copybuf[input.e-backs] = '\0';
80100754:	c6 81 20 04 11 80 00 	movb   $0x0,-0x7feefbe0(%ecx)
8010075b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010075e:	66 90                	xchg   %ax,%ax
      saveInp.copybuf[i] = saveInp.copybuf[i + 1];
80100760:	0f b6 88 21 04 11 80 	movzbl -0x7feefbdf(%eax),%ecx
80100767:	83 c0 01             	add    $0x1,%eax
8010076a:	88 88 1f 04 11 80    	mov    %cl,-0x7feefbe1(%eax)
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
80100785:	c6 81 20 04 11 80 00 	movb   $0x0,-0x7feefbe0(%ecx)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010078c:	eb e6                	jmp    80100774 <cgaputc+0x204>
    panic("pos under/overflow");
8010078e:	83 ec 0c             	sub    $0xc,%esp
80100791:	68 05 7f 10 80       	push   $0x80107f05
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
801007af:	e8 cc 1d 00 00       	call   80102580 <iunlock>
  acquire(&cons.lock);
801007b4:	c7 04 24 60 05 11 80 	movl   $0x80110560,(%esp)
801007bb:	e8 00 4b 00 00       	call   801052c0 <acquire>
  for(i = 0; i < n; i++)
801007c0:	83 c4 10             	add    $0x10,%esp
801007c3:	85 f6                	test   %esi,%esi
801007c5:	7e 37                	jle    801007fe <consolewrite+0x5e>
801007c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801007ca:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801007cd:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
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
801007ea:	e8 e1 61 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
801007ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007f2:	e8 79 fd ff ff       	call   80100570 <cgaputc>
  for(i = 0; i < n; i++)
801007f7:	83 c4 10             	add    $0x10,%esp
801007fa:	39 df                	cmp    %ebx,%edi
801007fc:	75 cf                	jne    801007cd <consolewrite+0x2d>
  release(&cons.lock);
801007fe:	83 ec 0c             	sub    $0xc,%esp
80100801:	68 60 05 11 80       	push   $0x80110560
80100806:	e8 55 4a 00 00       	call   80105260 <release>
  ilock(ip);
8010080b:	58                   	pop    %eax
8010080c:	ff 75 08             	push   0x8(%ebp)
8010080f:	e8 8c 1c 00 00       	call   801024a0 <ilock>

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
80100856:	0f b6 92 78 7f 10 80 	movzbl -0x7fef8088(%edx),%edx
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
8010087f:	a1 9c 05 11 80       	mov    0x8011059c,%eax
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
80100897:	e8 34 61 00 00       	call   801069d0 <uartputc>
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
801008dc:	a1 98 05 11 80       	mov    0x80110598,%eax
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
80100940:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
80100947:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
8010094a:	8b 1d 48 05 11 80    	mov    0x80110548,%ebx
80100950:	3b 1d 44 05 11 80    	cmp    0x80110544,%ebx
80100956:	76 57                	jbe    801009af <handle_up_down_arrow+0xdf>
    if (input.buf[i - 1] != '\n'){
80100958:	83 eb 01             	sub    $0x1,%ebx
8010095b:	80 bb c0 04 11 80 0a 	cmpb   $0xa,-0x7feefb40(%ebx)
80100962:	74 43                	je     801009a7 <handle_up_down_arrow+0xd7>
  if(panicked){
80100964:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
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
8010097d:	e8 4e 60 00 00       	call   801069d0 <uartputc>
80100982:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100989:	e8 42 60 00 00       	call   801069d0 <uartputc>
8010098e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100995:	e8 36 60 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
8010099a:	b8 00 01 00 00       	mov    $0x100,%eax
8010099f:	e8 cc fb ff ff       	call   80100570 <cgaputc>
}
801009a4:	83 c4 10             	add    $0x10,%esp
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
801009a7:	39 1d 44 05 11 80    	cmp    %ebx,0x80110544
801009ad:	72 a9                	jb     80100958 <handle_up_down_arrow+0x88>
  if ((arrow == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
801009af:	83 7d e0 03          	cmpl   $0x3,-0x20(%ebp)
801009b3:	a1 f8 03 11 80       	mov    0x801103f8,%eax
801009b8:	75 10                	jne    801009ca <handle_up_down_arrow+0xfa>
801009ba:	83 f8 08             	cmp    $0x8,%eax
801009bd:	7f 0b                	jg     801009ca <handle_up_down_arrow+0xfa>
801009bf:	8d 50 01             	lea    0x1(%eax),%edx
801009c2:	3b 15 fc 03 11 80    	cmp    0x801103fc,%edx
801009c8:	7c 7f                	jl     80100a49 <handle_up_down_arrow+0x179>
    input = history.instructions[history.index--];
801009ca:	8d 50 ff             	lea    -0x1(%eax),%edx
801009cd:	69 c0 8c 00 00 00    	imul   $0x8c,%eax,%eax
801009d3:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
801009d9:	8d b0 80 fe 10 80    	lea    -0x7fef0180(%eax),%esi
801009df:	b8 c0 04 11 80       	mov    $0x801104c0,%eax
801009e4:	b9 23 00 00 00       	mov    $0x23,%ecx
801009e9:	89 c7                	mov    %eax,%edi
801009eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.buf[--input.e] = '\0';
801009ed:	8b 15 48 05 11 80    	mov    0x80110548,%edx
801009f3:	8d 42 ff             	lea    -0x1(%edx),%eax
801009f6:	a3 48 05 11 80       	mov    %eax,0x80110548
801009fb:	c6 82 bf 04 11 80 00 	movb   $0x0,-0x7feefb41(%edx)
  for (int i = input.w ; i < input.e; i++)
80100a02:	8b 1d 44 05 11 80    	mov    0x80110544,%ebx
80100a08:	39 c3                	cmp    %eax,%ebx
80100a0a:	73 35                	jae    80100a41 <handle_up_down_arrow+0x171>
  if(panicked){
80100a0c:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
    consputc(input.buf[i]);
80100a12:	0f b6 83 c0 04 11 80 	movzbl -0x7feefb40(%ebx),%eax
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
80100a2a:	e8 a1 5f 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80100a2f:	89 f0                	mov    %esi,%eax
80100a31:	e8 3a fb ff ff       	call   80100570 <cgaputc>
  for (int i = input.w ; i < input.e; i++)
80100a36:	83 c4 10             	add    $0x10,%esp
80100a39:	39 1d 48 05 11 80    	cmp    %ebx,0x80110548
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
80100a4c:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
    input = history.instructions[history.index + 1 ];
80100a52:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
80100a58:	81 c6 80 fe 10 80    	add    $0x8010fe80,%esi
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
80100a79:	a1 94 05 11 80       	mov    0x80110594,%eax
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
80100b25:	bf 18 7f 10 80       	mov    $0x80107f18,%edi
      for(; *s; s++)
80100b2a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100b2d:	b8 28 00 00 00       	mov    $0x28,%eax
80100b32:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100b34:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
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
80100b80:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
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
80100b9a:	e8 31 5e 00 00       	call   801069d0 <uartputc>
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
80100bc3:	68 60 05 11 80       	push   $0x80110560
80100bc8:	e8 f3 46 00 00       	call   801052c0 <acquire>
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	e9 b4 fe ff ff       	jmp    80100a89 <cprintf+0x19>
  if(panicked){
80100bd5:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
80100bdb:	85 c9                	test   %ecx,%ecx
80100bdd:	75 71                	jne    80100c50 <cprintf+0x1e0>
    uartputc(c);
80100bdf:	83 ec 0c             	sub    $0xc,%esp
80100be2:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100be5:	6a 25                	push   $0x25
80100be7:	e8 e4 5d 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80100bec:	b8 25 00 00 00       	mov    $0x25,%eax
80100bf1:	e8 7a f9 ff ff       	call   80100570 <cgaputc>
  if(panicked){
80100bf6:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
80100bfc:	83 c4 10             	add    $0x10,%esp
80100bff:	85 d2                	test   %edx,%edx
80100c01:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100c04:	0f 84 8e 00 00 00    	je     80100c98 <cprintf+0x228>
80100c0a:	fa                   	cli    
    for(;;)
80100c0b:	eb fe                	jmp    80100c0b <cprintf+0x19b>
80100c0d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100c10:	a1 9c 05 11 80       	mov    0x8011059c,%eax
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
80100c28:	e8 a3 5d 00 00       	call   801069d0 <uartputc>
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
80100c73:	e8 58 5d 00 00       	call   801069d0 <uartputc>
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
80100c9f:	e8 2c 5d 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80100ca4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca7:	e8 c4 f8 ff ff       	call   80100570 <cgaputc>
}
80100cac:	83 c4 10             	add    $0x10,%esp
80100caf:	e9 37 fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    release(&cons.lock);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
80100cb7:	68 60 05 11 80       	push   $0x80110560
80100cbc:	e8 9f 45 00 00       	call   80105260 <release>
80100cc1:	83 c4 10             	add    $0x10,%esp
}
80100cc4:	e9 38 fe ff ff       	jmp    80100b01 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100cc9:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100ccc:	e9 1a fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    panic("null fmt");
80100cd1:	83 ec 0c             	sub    $0xc,%esp
80100cd4:	68 1f 7f 10 80       	push   $0x80107f1f
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
80100cea:	39 1d 48 05 11 80    	cmp    %ebx,0x80110548
80100cf0:	76 48                	jbe    80100d3a <delete_letters+0x5a>
  if(panicked){
80100cf2:	a1 9c 05 11 80       	mov    0x8011059c,%eax
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
80100d08:	e8 c3 5c 00 00       	call   801069d0 <uartputc>
80100d0d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d14:	e8 b7 5c 00 00       	call   801069d0 <uartputc>
80100d19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d20:	e8 ab 5c 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80100d25:	b8 00 01 00 00       	mov    $0x100,%eax
80100d2a:	e8 41 f8 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80100d2f:	83 c4 10             	add    $0x10,%esp
80100d32:	39 1d 48 05 11 80    	cmp    %ebx,0x80110548
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
80100d4f:	68 60 05 11 80       	push   $0x80110560
{
80100d54:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
  acquire(&cons.lock);
80100d5a:	e8 61 45 00 00       	call   801052c0 <acquire>
  char *buf_value = &input.buf[input.w];
80100d5f:	a1 44 05 11 80       	mov    0x80110544,%eax
  while((c = getc()) >= 0){
80100d64:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100d67:	c7 85 cc fd ff ff 00 	movl   $0x0,-0x234(%ebp)
80100d6e:	00 00 00 
  char *buf_value = &input.buf[input.w];
80100d71:	89 85 c8 fd ff ff    	mov    %eax,-0x238(%ebp)
80100d77:	05 c0 04 11 80       	add    $0x801104c0,%eax
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
80100dab:	ff 24 85 38 7f 10 80 	jmp    *-0x7fef80c8(,%eax,4)
80100db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100db8:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100dbe:	0f 84 dc 03 00 00    	je     801011a0 <consoleintr+0x460>
80100dc4:	0f 8e c6 00 00 00    	jle    80100e90 <consoleintr+0x150>
80100dca:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100dd0:	0f 84 a2 04 00 00    	je     80101278 <consoleintr+0x538>
80100dd6:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100ddc:	0f 85 fe 00 00 00    	jne    80100ee0 <consoleintr+0x1a0>
      if (backs > 0) // ensure back value stays positive
80100de2:	8b 1d 98 05 11 80    	mov    0x80110598,%ebx
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
80100e44:	89 1d 98 05 11 80    	mov    %ebx,0x80110598
  while((c = getc()) >= 0){
80100e4a:	ff d0                	call   *%eax
80100e4c:	89 c3                	mov    %eax,%ebx
80100e4e:	85 c0                	test   %eax,%eax
80100e50:	0f 89 3e ff ff ff    	jns    80100d94 <consoleintr+0x54>
80100e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e5d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
80100e63:	68 60 05 11 80       	push   $0x80110560
80100e68:	e8 f3 43 00 00       	call   80105260 <release>
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
80100ea1:	a1 00 04 11 80       	mov    0x80110400,%eax
80100ea6:	85 c0                	test   %eax,%eax
80100ea8:	0f 84 d4 fe ff ff    	je     80100d82 <consoleintr+0x42>
80100eae:	8b 15 fc 03 11 80    	mov    0x801103fc,%edx
80100eb4:	2b 15 f8 03 11 80    	sub    0x801103f8,%edx
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
80100ee0:	a1 48 05 11 80       	mov    0x80110548,%eax
80100ee5:	89 c2                	mov    %eax,%edx
80100ee7:	2b 15 40 05 11 80    	sub    0x80110540,%edx
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
80100f07:	83 3d a8 04 11 80 01 	cmpl   $0x1,0x801104a8
80100f0e:	0f 84 b9 04 00 00    	je     801013cd <consoleintr+0x68d>
  if(panicked){
80100f14:	8b 35 9c 05 11 80    	mov    0x8011059c,%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100f1a:	8d 48 01             	lea    0x1(%eax),%ecx
80100f1d:	83 e0 7f             	and    $0x7f,%eax
80100f20:	89 0d 48 05 11 80    	mov    %ecx,0x80110548
80100f26:	88 90 c0 04 11 80    	mov    %dl,-0x7feefb40(%eax)
  if(panicked){
80100f2c:	85 f6                	test   %esi,%esi
80100f2e:	0f 85 4c 04 00 00    	jne    80101380 <consoleintr+0x640>
  if(c == BACKSPACE){
80100f34:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100f3a:	0f 84 10 05 00 00    	je     80101450 <consoleintr+0x710>
    uartputc(c);
80100f40:	83 ec 0c             	sub    $0xc,%esp
80100f43:	53                   	push   %ebx
80100f44:	e8 87 5a 00 00       	call   801069d0 <uartputc>
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
80100f67:	0f b6 80 c0 04 11 80 	movzbl -0x7feefb40(%eax),%eax
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
80100f9f:	0f b6 8a 28 7f 10 80 	movzbl -0x7fef80d8(%edx),%ecx
80100fa6:	38 c8                	cmp    %cl,%al
80100fa8:	74 de                	je     80100f88 <consoleintr+0x248>
            if (history.count < 9){
80100faa:	8b 1d 00 04 11 80    	mov    0x80110400,%ebx
80100fb0:	83 fb 08             	cmp    $0x8,%ebx
80100fb3:	0f 8f 43 05 00 00    	jg     801014fc <consoleintr+0x7bc>
            history.instructions[history.last + 1] = input;
80100fb9:	a1 fc 03 11 80       	mov    0x801103fc,%eax
80100fbe:	be c0 04 11 80       	mov    $0x801104c0,%esi
80100fc3:	b9 23 00 00 00       	mov    $0x23,%ecx
            history.count ++ ;
80100fc8:	83 c3 01             	add    $0x1,%ebx
80100fcb:	89 1d 00 04 11 80    	mov    %ebx,0x80110400
            history.instructions[history.last + 1] = input;
80100fd1:	8d 50 01             	lea    0x1(%eax),%edx
80100fd4:	69 c2 8c 00 00 00    	imul   $0x8c,%edx,%eax
            history.last ++ ;
80100fda:	89 15 fc 03 11 80    	mov    %edx,0x801103fc
            history.index = history.last;
80100fe0:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
            history.instructions[history.last + 1] = input;
80100fe6:	05 80 fe 10 80       	add    $0x8010fe80,%eax
80100feb:	89 c7                	mov    %eax,%edi
80100fed:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
          wakeup(&input.r);
80100fef:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ff2:	a1 48 05 11 80       	mov    0x80110548,%eax
          backs = 0;
80100ff7:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
80100ffe:	00 00 00 
          wakeup(&input.r);
80101001:	68 40 05 11 80       	push   $0x80110540
          input.w = input.e;
80101006:	a3 44 05 11 80       	mov    %eax,0x80110544
          wakeup(&input.r);
8010100b:	e8 10 3e 00 00       	call   80104e20 <wakeup>
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
80101030:	a1 48 05 11 80       	mov    0x80110548,%eax
80101035:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
8010103b:	0f 84 41 fd ff ff    	je     80100d82 <consoleintr+0x42>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101041:	83 e8 01             	sub    $0x1,%eax
80101044:	89 c2                	mov    %eax,%edx
80101046:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101049:	80 ba c0 04 11 80 0a 	cmpb   $0xa,-0x7feefb40(%edx)
80101050:	0f 84 2c fd ff ff    	je     80100d82 <consoleintr+0x42>
  if(panicked){
80101056:	8b 35 9c 05 11 80    	mov    0x8011059c,%esi
        input.e--;
8010105c:	a3 48 05 11 80       	mov    %eax,0x80110548
  if(panicked){
80101061:	85 f6                	test   %esi,%esi
80101063:	0f 84 85 02 00 00    	je     801012ee <consoleintr+0x5ae>
  asm volatile("cli");
80101069:	fa                   	cli    
    for(;;)
8010106a:	eb fe                	jmp    8010106a <consoleintr+0x32a>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((input.e - backs )> input.w){
80101070:	a1 48 05 11 80       	mov    0x80110548,%eax
80101075:	89 c2                	mov    %eax,%edx
80101077:	2b 15 98 05 11 80    	sub    0x80110598,%edx
8010107d:	3b 15 44 05 11 80    	cmp    0x80110544,%edx
80101083:	0f 86 f9 fc ff ff    	jbe    80100d82 <consoleintr+0x42>
  if(panicked){
80101089:	8b 1d 9c 05 11 80    	mov    0x8011059c,%ebx
        input.e--;
8010108f:	83 e8 01             	sub    $0x1,%eax
80101092:	a3 48 05 11 80       	mov    %eax,0x80110548
  if(panicked){
80101097:	85 db                	test   %ebx,%ebx
80101099:	0f 84 ad 02 00 00    	je     8010134c <consoleintr+0x60c>
8010109f:	fa                   	cli    
    for(;;)
801010a0:	eb fe                	jmp    801010a0 <consoleintr+0x360>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(saveInp.active == 1)
801010a8:	83 3d a8 04 11 80 01 	cmpl   $0x1,0x801104a8
801010af:	0f 85 cd fc ff ff    	jne    80100d82 <consoleintr+0x42>
      saveInp.end = input.e-backs;
801010b5:	8b 35 48 05 11 80    	mov    0x80110548,%esi
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010bb:	8b 15 a0 04 11 80    	mov    0x801104a0,%edx
      int count = 0;
801010c1:	31 db                	xor    %ebx,%ebx
      saveInp.end = input.e-backs;
801010c3:	89 f1                	mov    %esi,%ecx
801010c5:	2b 0d 98 05 11 80    	sub    0x80110598,%ecx
      for (int j = input.e; j >= saveInp.end; j--){// jadid
801010cb:	89 f0                	mov    %esi,%eax
      saveInp.end = input.e-backs;
801010cd:	89 0d a4 04 11 80    	mov    %ecx,0x801104a4
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010d3:	83 fa 7f             	cmp    $0x7f,%edx
801010d6:	0f 8f ac 02 00 00    	jg     80101388 <consoleintr+0x648>
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (saveInp.copybuf[i] != '\0'){
801010e0:	80 ba 20 04 11 80 00 	cmpb   $0x0,-0x7feefbe0(%edx)
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
80101108:	0f b6 90 c0 04 11 80 	movzbl -0x7feefb40(%eax),%edx
8010110f:	88 94 03 c0 04 11 80 	mov    %dl,-0x7feefb40(%ebx,%eax,1)
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101116:	83 e8 01             	sub    $0x1,%eax
80101119:	39 c1                	cmp    %eax,%ecx
8010111b:	7e eb                	jle    80101108 <consoleintr+0x3c8>
      input.e = input.e + count;
8010111d:	89 35 48 05 11 80    	mov    %esi,0x80110548
      for (int i=0; i<count ; i++)
80101123:	85 db                	test   %ebx,%ebx
80101125:	0f 84 57 fc ff ff    	je     80100d82 <consoleintr+0x42>
8010112b:	31 f6                	xor    %esi,%esi
8010112d:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101133:	89 da                	mov    %ebx,%edx
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
80101135:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80101138:	0f be 98 20 04 11 80 	movsbl -0x7feefbe0(%eax),%ebx
8010113f:	88 9c 31 c0 04 11 80 	mov    %bl,-0x7feefb40(%ecx,%esi,1)
  if(panicked){
80101146:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
8010114c:	85 c9                	test   %ecx,%ecx
8010114e:	0f 84 44 02 00 00    	je     80101398 <consoleintr+0x658>
80101154:	fa                   	cli    
    for(;;)
80101155:	eb fe                	jmp    80101155 <consoleintr+0x415>
80101157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010115e:	66 90                	xchg   %ax,%ax
      saveInp.active = 1;
80101160:	c7 05 a8 04 11 80 01 	movl   $0x1,0x801104a8
80101167:	00 00 00 
      saveInp.start = input.e-backs;
8010116a:	a1 48 05 11 80       	mov    0x80110548,%eax
8010116f:	2b 05 98 05 11 80    	sub    0x80110598,%eax
80101175:	a3 a0 04 11 80       	mov    %eax,0x801104a0
      for (int i = 0; i < 128; i++)
8010117a:	31 c0                	xor    %eax,%eax
8010117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        saveInp.copybuf[i] = '\0';
80101180:	c6 80 20 04 11 80 00 	movb   $0x0,-0x7feefbe0(%eax)
      for (int i = 0; i < 128; i++)
80101187:	83 c0 01             	add    $0x1,%eax
8010118a:	3d 80 00 00 00       	cmp    $0x80,%eax
8010118f:	75 ef                	jne    80101180 <consoleintr+0x440>
80101191:	e9 ec fb ff ff       	jmp    80100d82 <consoleintr+0x42>
80101196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
      if ((history.count != 0 ) && (history.last - history.index  - 1 > 0))
801011a0:	a1 00 04 11 80       	mov    0x80110400,%eax
801011a5:	85 c0                	test   %eax,%eax
801011a7:	0f 84 d5 fb ff ff    	je     80100d82 <consoleintr+0x42>
801011ad:	a1 fc 03 11 80       	mov    0x801103fc,%eax
801011b2:	2b 05 f8 03 11 80    	sub    0x801103f8,%eax
801011b8:	83 f8 01             	cmp    $0x1,%eax
801011bb:	0f 8e c1 fb ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(DOWN);
801011c1:	b8 03 00 00 00       	mov    $0x3,%eax
801011c6:	e8 05 f7 ff ff       	call   801008d0 <handle_up_down_arrow>
801011cb:	e9 b2 fb ff ff       	jmp    80100d82 <consoleintr+0x42>
  if(panicked){
801011d0:	a1 9c 05 11 80       	mov    0x8011059c,%eax
801011d5:	85 c0                	test   %eax,%eax
801011d7:	0f 85 5b 01 00 00    	jne    80101338 <consoleintr+0x5f8>
    uartputc(c);
801011dd:	83 ec 0c             	sub    $0xc,%esp
801011e0:	6a 3f                	push   $0x3f
801011e2:	e8 e9 57 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
801011e7:	b8 3f 00 00 00       	mov    $0x3f,%eax
801011ec:	e8 7f f3 ff ff       	call   80100570 <cgaputc>
  if(input.buf[input.e-1] == 61)
801011f1:	8b 3d 48 05 11 80    	mov    0x80110548,%edi
801011f7:	83 c4 10             	add    $0x10,%esp
801011fa:	80 bf bf 04 11 80 3d 	cmpb   $0x3d,-0x7feefb41(%edi)
80101201:	0f 85 7b fb ff ff    	jne    80100d82 <consoleintr+0x42>
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101207:	0f b6 87 be 04 11 80 	movzbl -0x7feefb42(%edi),%eax
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
80101265:	a1 9c 05 11 80       	mov    0x8011059c,%eax
8010126a:	85 c0                	test   %eax,%eax
8010126c:	0f 84 80 01 00 00    	je     801013f2 <consoleintr+0x6b2>
80101272:	fa                   	cli    
    for(;;)
80101273:	eb fe                	jmp    80101273 <consoleintr+0x533>
80101275:	8d 76 00             	lea    0x0(%esi),%esi
      if ((input.e - backs) > input.w) //ensure cursor position stays in valid bounds
80101278:	8b 0d 98 05 11 80    	mov    0x80110598,%ecx
8010127e:	a1 48 05 11 80       	mov    0x80110548,%eax
80101283:	29 c8                	sub    %ecx,%eax
80101285:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
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
801012e3:	89 0d 98 05 11 80    	mov    %ecx,0x80110598
801012e9:	e9 94 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	6a 08                	push   $0x8
801012f3:	e8 d8 56 00 00       	call   801069d0 <uartputc>
801012f8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801012ff:	e8 cc 56 00 00       	call   801069d0 <uartputc>
80101304:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010130b:	e8 c0 56 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80101310:	b8 00 01 00 00       	mov    $0x100,%eax
80101315:	e8 56 f2 ff ff       	call   80100570 <cgaputc>
      while(input.e != input.w &&
8010131a:	a1 48 05 11 80       	mov    0x80110548,%eax
8010131f:	83 c4 10             	add    $0x10,%esp
80101322:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
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
80101347:	e9 b4 3b 00 00       	jmp    80104f00 <procdump>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	6a 08                	push   $0x8
80101351:	e8 7a 56 00 00       	call   801069d0 <uartputc>
80101356:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010135d:	e8 6e 56 00 00       	call   801069d0 <uartputc>
80101362:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101369:	e8 62 56 00 00       	call   801069d0 <uartputc>
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
801013a5:	e8 26 56 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
801013aa:	89 d8                	mov    %ebx,%eax
801013ac:	e8 bf f1 ff ff       	call   80100570 <cgaputc>
      for (int i=0; i<count ; i++)
801013b1:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
801013b7:	83 c4 10             	add    $0x10,%esp
801013ba:	39 d6                	cmp    %edx,%esi
801013bc:	0f 84 c0 f9 ff ff    	je     80100d82 <consoleintr+0x42>
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
801013c2:	8b 0d a4 04 11 80    	mov    0x801104a4,%ecx
801013c8:	e9 68 fd ff ff       	jmp    80101135 <consoleintr+0x3f5>
          if (saveInp.copybuf[(input.e-backs)%INPUT_BUF] == '\0')
801013cd:	89 c7                	mov    %eax,%edi
801013cf:	2b 3d 98 05 11 80    	sub    0x80110598,%edi
801013d5:	89 fe                	mov    %edi,%esi
801013d7:	83 e6 7f             	and    $0x7f,%esi
801013da:	80 be 20 04 11 80 00 	cmpb   $0x0,-0x7feefbe0(%esi)
801013e1:	0f 85 6a 01 00 00    	jne    80101551 <consoleintr+0x811>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
801013e7:	88 96 20 04 11 80    	mov    %dl,-0x7feefbe0(%esi)
801013ed:	e9 22 fb ff ff       	jmp    80100f14 <consoleintr+0x1d4>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f2:	83 ec 0c             	sub    $0xc,%esp
  for(int i=end_index; i<input.e ; i++)
801013f5:	83 c7 01             	add    $0x1,%edi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f8:	6a 08                	push   $0x8
801013fa:	e8 d1 55 00 00       	call   801069d0 <uartputc>
801013ff:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101406:	e8 c5 55 00 00       	call   801069d0 <uartputc>
8010140b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101412:	e8 b9 55 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80101417:	b8 00 01 00 00       	mov    $0x100,%eax
8010141c:	e8 4f f1 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80101421:	83 c4 10             	add    $0x10,%esp
80101424:	3b 3d 48 05 11 80    	cmp    0x80110548,%edi
8010142a:	0f 82 35 fe ff ff    	jb     80101265 <consoleintr+0x525>
  if(panicked){
80101430:	a1 9c 05 11 80       	mov    0x8011059c,%eax
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
80101455:	e8 76 55 00 00       	call   801069d0 <uartputc>
8010145a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101461:	e8 6a 55 00 00       	call   801069d0 <uartputc>
80101466:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010146d:	e8 5e 55 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
80101472:	b8 00 01 00 00       	mov    $0x100,%eax
80101477:	e8 f4 f0 ff ff       	call   80100570 <cgaputc>
8010147c:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
8010147f:	a1 40 05 11 80       	mov    0x80110540,%eax
80101484:	83 e8 80             	sub    $0xffffff80,%eax
80101487:	39 05 48 05 11 80    	cmp    %eax,0x80110548
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
801014a6:	68 60 05 11 80       	push   $0x80110560
801014ab:	e8 b0 3d 00 00       	call   80105260 <release>
            for(int i=0 ; i<history.count+1 ; i++)
801014b0:	8b 15 00 04 11 80    	mov    0x80110400,%edx
801014b6:	83 c4 10             	add    $0x10,%esp
801014b9:	85 d2                	test   %edx,%edx
801014bb:	78 2a                	js     801014e7 <consoleintr+0x7a7>
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014bd:	8b 83 04 ff 10 80    	mov    -0x7fef00fc(%ebx),%eax
801014c3:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014c6:	83 c6 01             	add    $0x1,%esi
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014c9:	01 d8                	add    %ebx,%eax
            for(int i=0 ; i<history.count+1 ; i++)
801014cb:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014d1:	05 80 fe 10 80       	add    $0x8010fe80,%eax
801014d6:	50                   	push   %eax
801014d7:	e8 94 f5 ff ff       	call   80100a70 <cprintf>
            for(int i=0 ; i<history.count+1 ; i++)
801014dc:	83 c4 10             	add    $0x10,%esp
801014df:	39 35 00 04 11 80    	cmp    %esi,0x80110400
801014e5:	7d d6                	jge    801014bd <consoleintr+0x77d>
            acquire(&cons.lock);
801014e7:	83 ec 0c             	sub    $0xc,%esp
801014ea:	68 60 05 11 80       	push   $0x80110560
801014ef:	e8 cc 3d 00 00       	call   801052c0 <acquire>
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	e9 f3 fa ff ff       	jmp    80100fef <consoleintr+0x2af>
801014fc:	ba 6c 03 11 80       	mov    $0x8011036c,%edx
80101501:	b8 80 fe 10 80       	mov    $0x8010fe80,%eax
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
80101520:	be c0 04 11 80       	mov    $0x801104c0,%esi
80101525:	b9 23 00 00 00       	mov    $0x23,%ecx
8010152a:	89 d7                	mov    %edx,%edi
              history.index = 9;
8010152c:	c7 05 f8 03 11 80 09 	movl   $0x9,0x801103f8
80101533:	00 00 00 
              history.instructions[9] = input;
80101536:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              history.last = 9;
80101538:	c7 05 fc 03 11 80 09 	movl   $0x9,0x801103fc
8010153f:	00 00 00 
              history.count = 10;
80101542:	c7 05 00 04 11 80 0a 	movl   $0xa,0x80110400
80101549:	00 00 00 
8010154c:	e9 9e fa ff ff       	jmp    80100fef <consoleintr+0x2af>
            for (int i = input.e; i > input.e - backs; i--)
80101551:	89 c1                	mov    %eax,%ecx
80101553:	39 f8                	cmp    %edi,%eax
80101555:	0f 86 8c fe ff ff    	jbe    801013e7 <consoleintr+0x6a7>
8010155b:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
              saveInp.copybuf[i] = saveInp.copybuf[i - 1]; // shift to right all letters in buffer
80101561:	0f b6 81 1f 04 11 80 	movzbl -0x7feefbe1(%ecx),%eax
80101568:	83 e9 01             	sub    $0x1,%ecx
8010156b:	88 81 21 04 11 80    	mov    %al,-0x7feefbdf(%ecx)
            for (int i = input.e; i > input.e - backs; i--)
80101571:	39 cf                	cmp    %ecx,%edi
80101573:	72 ec                	jb     80101561 <consoleintr+0x821>
80101575:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
8010157b:	e9 67 fe ff ff       	jmp    801013e7 <consoleintr+0x6a7>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101580:	83 ec 0c             	sub    $0xc,%esp
80101583:	6a 08                	push   $0x8
80101585:	e8 46 54 00 00       	call   801069d0 <uartputc>
8010158a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101591:	e8 3a 54 00 00       	call   801069d0 <uartputc>
80101596:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010159d:	e8 2e 54 00 00       	call   801069d0 <uartputc>
  cgaputc(c);
801015a2:	b8 00 01 00 00       	mov    $0x100,%eax
801015a7:	e8 c4 ef ff ff       	call   80100570 <cgaputc>
    switch (input.buf[first_num_index-1])
801015ac:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
801015b2:	83 c4 10             	add    $0x10,%esp
801015b5:	0f b6 80 bf 04 11 80 	movzbl -0x7feefb41(%eax),%eax
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
801015f1:	68 60 05 11 80       	push   $0x80110560
801015f6:	e8 65 3c 00 00       	call   80105260 <release>
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
80101622:	88 98 c0 04 11 80    	mov    %bl,-0x7feefb40(%eax)
    i++;
80101628:	83 c0 01             	add    $0x1,%eax
  while (new_string[j]!='\0')
8010162b:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
8010162f:	84 db                	test   %bl,%bl
80101631:	75 ec                	jne    8010161f <consoleintr+0x8df>
80101633:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
80101639:	eb 0a                	jmp    80101645 <consoleintr+0x905>
    input.buf[i] = '\0';
8010163b:	c6 80 c0 04 11 80 00 	movb   $0x0,-0x7feefb40(%eax)
    i++;
80101642:	83 c0 01             	add    $0x1,%eax
  while (input.buf[i]!='\0')
80101645:	80 b8 c0 04 11 80 00 	cmpb   $0x0,-0x7feefb40(%eax)
8010164c:	75 ed                	jne    8010163b <consoleintr+0x8fb>
    acquire(&cons.lock);
8010164e:	83 ec 0c             	sub    $0xc,%esp
  input.e = update_index+j;
80101651:	03 8d c0 fd ff ff    	add    -0x240(%ebp),%ecx
    acquire(&cons.lock);
80101657:	68 60 05 11 80       	push   $0x80110560
  input.e = update_index+j;
8010165c:	89 0d 48 05 11 80    	mov    %ecx,0x80110548
    acquire(&cons.lock);
80101662:	e8 59 3c 00 00       	call   801052c0 <acquire>
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
801016c8:	d8 0d 8c 7f 10 80    	fmuls  0x80107f8c
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
80101786:	68 30 7f 10 80       	push   $0x80107f30
8010178b:	68 60 05 11 80       	push   $0x80110560
80101790:	e8 5b 39 00 00       	call   801050f0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101795:	58                   	pop    %eax
80101796:	5a                   	pop    %edx
80101797:	6a 00                	push   $0x0
80101799:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010179b:	c7 05 4c 0f 11 80 a0 	movl   $0x801007a0,0x80110f4c
801017a2:	07 10 80 
  devsw[CONSOLE].read = consoleread;
801017a5:	c7 05 48 0f 11 80 30 	movl   $0x80100330,0x80110f48
801017ac:	03 10 80 
  cons.locking = 1;
801017af:	c7 05 94 05 11 80 01 	movl   $0x1,0x80110594
801017b6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801017b9:	e8 e2 19 00 00       	call   801031a0 <ioapicenable>
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
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
801017dc:	e8 af 2e 00 00       	call   80104690 <myproc>
801017e1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
801017e7:	e8 94 22 00 00       	call   80103a80 <begin_op>
801017ec:	83 ec 0c             	sub    $0xc,%esp
801017ef:	ff 75 08             	push   0x8(%ebp)
801017f2:	e8 c9 15 00 00       	call   80102dc0 <namei>
801017f7:	83 c4 10             	add    $0x10,%esp
801017fa:	85 c0                	test   %eax,%eax
801017fc:	0f 84 02 03 00 00    	je     80101b04 <exec+0x334>
80101802:	83 ec 0c             	sub    $0xc,%esp
80101805:	89 c3                	mov    %eax,%ebx
80101807:	50                   	push   %eax
80101808:	e8 93 0c 00 00       	call   801024a0 <ilock>
8010180d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101813:	6a 34                	push   $0x34
80101815:	6a 00                	push   $0x0
80101817:	50                   	push   %eax
80101818:	53                   	push   %ebx
80101819:	e8 92 0f 00 00       	call   801027b0 <readi>
8010181e:	83 c4 20             	add    $0x20,%esp
80101821:	83 f8 34             	cmp    $0x34,%eax
80101824:	74 22                	je     80101848 <exec+0x78>
80101826:	83 ec 0c             	sub    $0xc,%esp
80101829:	53                   	push   %ebx
8010182a:	e8 01 0f 00 00       	call   80102730 <iunlockput>
8010182f:	e8 bc 22 00 00       	call   80103af0 <end_op>
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010183c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183f:	5b                   	pop    %ebx
80101840:	5e                   	pop    %esi
80101841:	5f                   	pop    %edi
80101842:	5d                   	pop    %ebp
80101843:	c3                   	ret    
80101844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101848:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010184f:	45 4c 46 
80101852:	75 d2                	jne    80101826 <exec+0x56>
80101854:	e8 07 63 00 00       	call   80107b60 <setupkvm>
80101859:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
8010185f:	85 c0                	test   %eax,%eax
80101861:	74 c3                	je     80101826 <exec+0x56>
80101863:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010186a:	00 
8010186b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101871:	0f 84 ac 02 00 00    	je     80101b23 <exec+0x353>
80101877:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010187e:	00 00 00 
80101881:	31 ff                	xor    %edi,%edi
80101883:	e9 8e 00 00 00       	jmp    80101916 <exec+0x146>
80101888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010188f:	90                   	nop
80101890:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101897:	75 6c                	jne    80101905 <exec+0x135>
80101899:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010189f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801018a5:	0f 82 87 00 00 00    	jb     80101932 <exec+0x162>
801018ab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801018b1:	72 7f                	jb     80101932 <exec+0x162>
801018b3:	83 ec 04             	sub    $0x4,%esp
801018b6:	50                   	push   %eax
801018b7:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
801018bd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018c3:	e8 b8 60 00 00       	call   80107980 <allocuvm>
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801018d1:	85 c0                	test   %eax,%eax
801018d3:	74 5d                	je     80101932 <exec+0x162>
801018d5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018db:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018e0:	75 50                	jne    80101932 <exec+0x162>
801018e2:	83 ec 0c             	sub    $0xc,%esp
801018e5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801018eb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801018f1:	53                   	push   %ebx
801018f2:	50                   	push   %eax
801018f3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018f9:	e8 92 5f 00 00       	call   80107890 <loaduvm>
801018fe:	83 c4 20             	add    $0x20,%esp
80101901:	85 c0                	test   %eax,%eax
80101903:	78 2d                	js     80101932 <exec+0x162>
80101905:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010190c:	83 c7 01             	add    $0x1,%edi
8010190f:	83 c6 20             	add    $0x20,%esi
80101912:	39 f8                	cmp    %edi,%eax
80101914:	7e 3a                	jle    80101950 <exec+0x180>
80101916:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010191c:	6a 20                	push   $0x20
8010191e:	56                   	push   %esi
8010191f:	50                   	push   %eax
80101920:	53                   	push   %ebx
80101921:	e8 8a 0e 00 00       	call   801027b0 <readi>
80101926:	83 c4 10             	add    $0x10,%esp
80101929:	83 f8 20             	cmp    $0x20,%eax
8010192c:	0f 84 5e ff ff ff    	je     80101890 <exec+0xc0>
80101932:	83 ec 0c             	sub    $0xc,%esp
80101935:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010193b:	e8 a0 61 00 00       	call   80107ae0 <freevm>
80101940:	83 c4 10             	add    $0x10,%esp
80101943:	e9 de fe ff ff       	jmp    80101826 <exec+0x56>
80101948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010194f:	90                   	nop
80101950:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101956:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010195c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80101962:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
80101968:	83 ec 0c             	sub    $0xc,%esp
8010196b:	53                   	push   %ebx
8010196c:	e8 bf 0d 00 00       	call   80102730 <iunlockput>
80101971:	e8 7a 21 00 00       	call   80103af0 <end_op>
80101976:	83 c4 0c             	add    $0xc,%esp
80101979:	56                   	push   %esi
8010197a:	57                   	push   %edi
8010197b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101981:	57                   	push   %edi
80101982:	e8 f9 5f 00 00       	call   80107980 <allocuvm>
80101987:	83 c4 10             	add    $0x10,%esp
8010198a:	89 c6                	mov    %eax,%esi
8010198c:	85 c0                	test   %eax,%eax
8010198e:	0f 84 94 00 00 00    	je     80101a28 <exec+0x258>
80101994:	83 ec 08             	sub    $0x8,%esp
80101997:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
8010199d:	89 f3                	mov    %esi,%ebx
8010199f:	50                   	push   %eax
801019a0:	57                   	push   %edi
801019a1:	31 ff                	xor    %edi,%edi
801019a3:	e8 58 62 00 00       	call   80107c00 <clearpteu>
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
801019d3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
801019da:	83 c7 01             	add    $0x1,%edi
801019dd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801019e3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801019e6:	85 c0                	test   %eax,%eax
801019e8:	74 59                	je     80101a43 <exec+0x273>
801019ea:	83 ff 20             	cmp    $0x20,%edi
801019ed:	74 39                	je     80101a28 <exec+0x258>
801019ef:	83 ec 0c             	sub    $0xc,%esp
801019f2:	50                   	push   %eax
801019f3:	e8 88 3b 00 00       	call   80105580 <strlen>
801019f8:	29 c3                	sub    %eax,%ebx
801019fa:	58                   	pop    %eax
801019fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801019fe:	83 eb 01             	sub    $0x1,%ebx
80101a01:	ff 34 b8             	push   (%eax,%edi,4)
80101a04:	83 e3 fc             	and    $0xfffffffc,%ebx
80101a07:	e8 74 3b 00 00       	call   80105580 <strlen>
80101a0c:	83 c0 01             	add    $0x1,%eax
80101a0f:	50                   	push   %eax
80101a10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a13:	ff 34 b8             	push   (%eax,%edi,4)
80101a16:	53                   	push   %ebx
80101a17:	56                   	push   %esi
80101a18:	e8 b3 63 00 00       	call   80107dd0 <copyout>
80101a1d:	83 c4 20             	add    $0x20,%esp
80101a20:	85 c0                	test   %eax,%eax
80101a22:	79 ac                	jns    801019d0 <exec+0x200>
80101a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a31:	e8 aa 60 00 00       	call   80107ae0 <freevm>
80101a36:	83 c4 10             	add    $0x10,%esp
80101a39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a3e:	e9 f9 fd ff ff       	jmp    8010183c <exec+0x6c>
80101a43:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80101a49:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101a50:	89 d9                	mov    %ebx,%ecx
80101a52:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101a59:	00 00 00 00 
80101a5d:	29 c1                	sub    %eax,%ecx
80101a5f:	83 c0 0c             	add    $0xc,%eax
80101a62:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
80101a68:	29 c3                	sub    %eax,%ebx
80101a6a:	50                   	push   %eax
80101a6b:	52                   	push   %edx
80101a6c:	53                   	push   %ebx
80101a6d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a73:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a7a:	ff ff ff 
80101a7d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
80101a83:	e8 48 63 00 00       	call   80107dd0 <copyout>
80101a88:	83 c4 10             	add    $0x10,%esp
80101a8b:	85 c0                	test   %eax,%eax
80101a8d:	78 99                	js     80101a28 <exec+0x258>
80101a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a92:	8b 55 08             	mov    0x8(%ebp),%edx
80101a95:	0f b6 00             	movzbl (%eax),%eax
80101a98:	84 c0                	test   %al,%al
80101a9a:	74 13                	je     80101aaf <exec+0x2df>
80101a9c:	89 d1                	mov    %edx,%ecx
80101a9e:	66 90                	xchg   %ax,%ax
80101aa0:	83 c1 01             	add    $0x1,%ecx
80101aa3:	3c 2f                	cmp    $0x2f,%al
80101aa5:	0f b6 01             	movzbl (%ecx),%eax
80101aa8:	0f 44 d1             	cmove  %ecx,%edx
80101aab:	84 c0                	test   %al,%al
80101aad:	75 f1                	jne    80101aa0 <exec+0x2d0>
80101aaf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101ab5:	83 ec 04             	sub    $0x4,%esp
80101ab8:	6a 10                	push   $0x10
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	52                   	push   %edx
80101abd:	83 c0 6c             	add    $0x6c,%eax
80101ac0:	50                   	push   %eax
80101ac1:	e8 7a 3a 00 00       	call   80105540 <safestrcpy>
80101ac6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80101acc:	89 f8                	mov    %edi,%eax
80101ace:	8b 7f 04             	mov    0x4(%edi),%edi
80101ad1:	89 30                	mov    %esi,(%eax)
80101ad3:	89 48 04             	mov    %ecx,0x4(%eax)
80101ad6:	89 c1                	mov    %eax,%ecx
80101ad8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101ade:	8b 40 18             	mov    0x18(%eax),%eax
80101ae1:	89 50 38             	mov    %edx,0x38(%eax)
80101ae4:	8b 41 18             	mov    0x18(%ecx),%eax
80101ae7:	89 58 44             	mov    %ebx,0x44(%eax)
80101aea:	89 0c 24             	mov    %ecx,(%esp)
80101aed:	e8 0e 5c 00 00       	call   80107700 <switchuvm>
80101af2:	89 3c 24             	mov    %edi,(%esp)
80101af5:	e8 e6 5f 00 00       	call   80107ae0 <freevm>
80101afa:	83 c4 10             	add    $0x10,%esp
80101afd:	31 c0                	xor    %eax,%eax
80101aff:	e9 38 fd ff ff       	jmp    8010183c <exec+0x6c>
80101b04:	e8 e7 1f 00 00       	call   80103af0 <end_op>
80101b09:	83 ec 0c             	sub    $0xc,%esp
80101b0c:	68 90 7f 10 80       	push   $0x80107f90
80101b11:	e8 5a ef ff ff       	call   80100a70 <cprintf>
80101b16:	83 c4 10             	add    $0x10,%esp
80101b19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b1e:	e9 19 fd ff ff       	jmp    8010183c <exec+0x6c>
80101b23:	be 00 20 00 00       	mov    $0x2000,%esi
80101b28:	31 ff                	xor    %edi,%edi
80101b2a:	e9 39 fe ff ff       	jmp    80101968 <exec+0x198>
80101b2f:	90                   	nop

80101b30 <fileinit>:
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	83 ec 10             	sub    $0x10,%esp
80101b36:	68 9c 7f 10 80       	push   $0x80107f9c
80101b3b:	68 a0 05 11 80       	push   $0x801105a0
80101b40:	e8 ab 35 00 00       	call   801050f0 <initlock>
80101b45:	83 c4 10             	add    $0x10,%esp
80101b48:	c9                   	leave  
80101b49:	c3                   	ret    
80101b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b50 <filealloc>:
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	53                   	push   %ebx
80101b54:	bb d4 05 11 80       	mov    $0x801105d4,%ebx
80101b59:	83 ec 10             	sub    $0x10,%esp
80101b5c:	68 a0 05 11 80       	push   $0x801105a0
80101b61:	e8 5a 37 00 00       	call   801052c0 <acquire>
80101b66:	83 c4 10             	add    $0x10,%esp
80101b69:	eb 10                	jmp    80101b7b <filealloc+0x2b>
80101b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b6f:	90                   	nop
80101b70:	83 c3 18             	add    $0x18,%ebx
80101b73:	81 fb 34 0f 11 80    	cmp    $0x80110f34,%ebx
80101b79:	74 25                	je     80101ba0 <filealloc+0x50>
80101b7b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b7e:	85 c0                	test   %eax,%eax
80101b80:	75 ee                	jne    80101b70 <filealloc+0x20>
80101b82:	83 ec 0c             	sub    $0xc,%esp
80101b85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80101b8c:	68 a0 05 11 80       	push   $0x801105a0
80101b91:	e8 ca 36 00 00       	call   80105260 <release>
80101b96:	89 d8                	mov    %ebx,%eax
80101b98:	83 c4 10             	add    $0x10,%esp
80101b9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b9e:	c9                   	leave  
80101b9f:	c3                   	ret    
80101ba0:	83 ec 0c             	sub    $0xc,%esp
80101ba3:	31 db                	xor    %ebx,%ebx
80101ba5:	68 a0 05 11 80       	push   $0x801105a0
80101baa:	e8 b1 36 00 00       	call   80105260 <release>
80101baf:	89 d8                	mov    %ebx,%eax
80101bb1:	83 c4 10             	add    $0x10,%esp
80101bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bb7:	c9                   	leave  
80101bb8:	c3                   	ret    
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bc0 <filedup>:
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	53                   	push   %ebx
80101bc4:	83 ec 10             	sub    $0x10,%esp
80101bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bca:	68 a0 05 11 80       	push   $0x801105a0
80101bcf:	e8 ec 36 00 00       	call   801052c0 <acquire>
80101bd4:	8b 43 04             	mov    0x4(%ebx),%eax
80101bd7:	83 c4 10             	add    $0x10,%esp
80101bda:	85 c0                	test   %eax,%eax
80101bdc:	7e 1a                	jle    80101bf8 <filedup+0x38>
80101bde:	83 c0 01             	add    $0x1,%eax
80101be1:	83 ec 0c             	sub    $0xc,%esp
80101be4:	89 43 04             	mov    %eax,0x4(%ebx)
80101be7:	68 a0 05 11 80       	push   $0x801105a0
80101bec:	e8 6f 36 00 00       	call   80105260 <release>
80101bf1:	89 d8                	mov    %ebx,%eax
80101bf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bf6:	c9                   	leave  
80101bf7:	c3                   	ret    
80101bf8:	83 ec 0c             	sub    $0xc,%esp
80101bfb:	68 a3 7f 10 80       	push   $0x80107fa3
80101c00:	e8 eb e8 ff ff       	call   801004f0 <panic>
80101c05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c10 <fileclose>:
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 28             	sub    $0x28,%esp
80101c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c1c:	68 a0 05 11 80       	push   $0x801105a0
80101c21:	e8 9a 36 00 00       	call   801052c0 <acquire>
80101c26:	8b 53 04             	mov    0x4(%ebx),%edx
80101c29:	83 c4 10             	add    $0x10,%esp
80101c2c:	85 d2                	test   %edx,%edx
80101c2e:	0f 8e a5 00 00 00    	jle    80101cd9 <fileclose+0xc9>
80101c34:	83 ea 01             	sub    $0x1,%edx
80101c37:	89 53 04             	mov    %edx,0x4(%ebx)
80101c3a:	75 44                	jne    80101c80 <fileclose+0x70>
80101c3c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80101c40:	83 ec 0c             	sub    $0xc,%esp
80101c43:	8b 3b                	mov    (%ebx),%edi
80101c45:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101c4b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101c4e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c51:	8b 43 10             	mov    0x10(%ebx),%eax
80101c54:	68 a0 05 11 80       	push   $0x801105a0
80101c59:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c5c:	e8 ff 35 00 00       	call   80105260 <release>
80101c61:	83 c4 10             	add    $0x10,%esp
80101c64:	83 ff 01             	cmp    $0x1,%edi
80101c67:	74 57                	je     80101cc0 <fileclose+0xb0>
80101c69:	83 ff 02             	cmp    $0x2,%edi
80101c6c:	74 2a                	je     80101c98 <fileclose+0x88>
80101c6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c71:	5b                   	pop    %ebx
80101c72:	5e                   	pop    %esi
80101c73:	5f                   	pop    %edi
80101c74:	5d                   	pop    %ebp
80101c75:	c3                   	ret    
80101c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c7d:	8d 76 00             	lea    0x0(%esi),%esi
80101c80:	c7 45 08 a0 05 11 80 	movl   $0x801105a0,0x8(%ebp)
80101c87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8a:	5b                   	pop    %ebx
80101c8b:	5e                   	pop    %esi
80101c8c:	5f                   	pop    %edi
80101c8d:	5d                   	pop    %ebp
80101c8e:	e9 cd 35 00 00       	jmp    80105260 <release>
80101c93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c97:	90                   	nop
80101c98:	e8 e3 1d 00 00       	call   80103a80 <begin_op>
80101c9d:	83 ec 0c             	sub    $0xc,%esp
80101ca0:	ff 75 e0             	push   -0x20(%ebp)
80101ca3:	e8 28 09 00 00       	call   801025d0 <iput>
80101ca8:	83 c4 10             	add    $0x10,%esp
80101cab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cae:	5b                   	pop    %ebx
80101caf:	5e                   	pop    %esi
80101cb0:	5f                   	pop    %edi
80101cb1:	5d                   	pop    %ebp
80101cb2:	e9 39 1e 00 00       	jmp    80103af0 <end_op>
80101cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cbe:	66 90                	xchg   %ax,%ax
80101cc0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101cc4:	83 ec 08             	sub    $0x8,%esp
80101cc7:	53                   	push   %ebx
80101cc8:	56                   	push   %esi
80101cc9:	e8 82 25 00 00       	call   80104250 <pipeclose>
80101cce:	83 c4 10             	add    $0x10,%esp
80101cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cd4:	5b                   	pop    %ebx
80101cd5:	5e                   	pop    %esi
80101cd6:	5f                   	pop    %edi
80101cd7:	5d                   	pop    %ebp
80101cd8:	c3                   	ret    
80101cd9:	83 ec 0c             	sub    $0xc,%esp
80101cdc:	68 ab 7f 10 80       	push   $0x80107fab
80101ce1:	e8 0a e8 ff ff       	call   801004f0 <panic>
80101ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ced:	8d 76 00             	lea    0x0(%esi),%esi

80101cf0 <filestat>:
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	53                   	push   %ebx
80101cf4:	83 ec 04             	sub    $0x4,%esp
80101cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101cfa:	83 3b 02             	cmpl   $0x2,(%ebx)
80101cfd:	75 31                	jne    80101d30 <filestat+0x40>
80101cff:	83 ec 0c             	sub    $0xc,%esp
80101d02:	ff 73 10             	push   0x10(%ebx)
80101d05:	e8 96 07 00 00       	call   801024a0 <ilock>
80101d0a:	58                   	pop    %eax
80101d0b:	5a                   	pop    %edx
80101d0c:	ff 75 0c             	push   0xc(%ebp)
80101d0f:	ff 73 10             	push   0x10(%ebx)
80101d12:	e8 69 0a 00 00       	call   80102780 <stati>
80101d17:	59                   	pop    %ecx
80101d18:	ff 73 10             	push   0x10(%ebx)
80101d1b:	e8 60 08 00 00       	call   80102580 <iunlock>
80101d20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d23:	83 c4 10             	add    $0x10,%esp
80101d26:	31 c0                	xor    %eax,%eax
80101d28:	c9                   	leave  
80101d29:	c3                   	ret    
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d38:	c9                   	leave  
80101d39:	c3                   	ret    
80101d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d40 <fileread>:
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d4f:	8b 7d 10             	mov    0x10(%ebp),%edi
80101d52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d56:	74 60                	je     80101db8 <fileread+0x78>
80101d58:	8b 03                	mov    (%ebx),%eax
80101d5a:	83 f8 01             	cmp    $0x1,%eax
80101d5d:	74 41                	je     80101da0 <fileread+0x60>
80101d5f:	83 f8 02             	cmp    $0x2,%eax
80101d62:	75 5b                	jne    80101dbf <fileread+0x7f>
80101d64:	83 ec 0c             	sub    $0xc,%esp
80101d67:	ff 73 10             	push   0x10(%ebx)
80101d6a:	e8 31 07 00 00       	call   801024a0 <ilock>
80101d6f:	57                   	push   %edi
80101d70:	ff 73 14             	push   0x14(%ebx)
80101d73:	56                   	push   %esi
80101d74:	ff 73 10             	push   0x10(%ebx)
80101d77:	e8 34 0a 00 00       	call   801027b0 <readi>
80101d7c:	83 c4 20             	add    $0x20,%esp
80101d7f:	89 c6                	mov    %eax,%esi
80101d81:	85 c0                	test   %eax,%eax
80101d83:	7e 03                	jle    80101d88 <fileread+0x48>
80101d85:	01 43 14             	add    %eax,0x14(%ebx)
80101d88:	83 ec 0c             	sub    $0xc,%esp
80101d8b:	ff 73 10             	push   0x10(%ebx)
80101d8e:	e8 ed 07 00 00       	call   80102580 <iunlock>
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	89 f0                	mov    %esi,%eax
80101d9b:	5b                   	pop    %ebx
80101d9c:	5e                   	pop    %esi
80101d9d:	5f                   	pop    %edi
80101d9e:	5d                   	pop    %ebp
80101d9f:	c3                   	ret    
80101da0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101da3:	89 45 08             	mov    %eax,0x8(%ebp)
80101da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da9:	5b                   	pop    %ebx
80101daa:	5e                   	pop    %esi
80101dab:	5f                   	pop    %edi
80101dac:	5d                   	pop    %ebp
80101dad:	e9 3e 26 00 00       	jmp    801043f0 <piperead>
80101db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101db8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dbd:	eb d7                	jmp    80101d96 <fileread+0x56>
80101dbf:	83 ec 0c             	sub    $0xc,%esp
80101dc2:	68 b5 7f 10 80       	push   $0x80107fb5
80101dc7:	e8 24 e7 ff ff       	call   801004f0 <panic>
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <filewrite>:
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 1c             	sub    $0x1c,%esp
80101dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ddc:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ddf:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101de2:	8b 45 10             	mov    0x10(%ebp),%eax
80101de5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80101de9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101dec:	0f 84 bd 00 00 00    	je     80101eaf <filewrite+0xdf>
80101df2:	8b 03                	mov    (%ebx),%eax
80101df4:	83 f8 01             	cmp    $0x1,%eax
80101df7:	0f 84 bf 00 00 00    	je     80101ebc <filewrite+0xec>
80101dfd:	83 f8 02             	cmp    $0x2,%eax
80101e00:	0f 85 c8 00 00 00    	jne    80101ece <filewrite+0xfe>
80101e06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e09:	31 f6                	xor    %esi,%esi
80101e0b:	85 c0                	test   %eax,%eax
80101e0d:	7f 30                	jg     80101e3f <filewrite+0x6f>
80101e0f:	e9 94 00 00 00       	jmp    80101ea8 <filewrite+0xd8>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e18:	01 43 14             	add    %eax,0x14(%ebx)
80101e1b:	83 ec 0c             	sub    $0xc,%esp
80101e1e:	ff 73 10             	push   0x10(%ebx)
80101e21:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e24:	e8 57 07 00 00       	call   80102580 <iunlock>
80101e29:	e8 c2 1c 00 00       	call   80103af0 <end_op>
80101e2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e31:	83 c4 10             	add    $0x10,%esp
80101e34:	39 c7                	cmp    %eax,%edi
80101e36:	75 5c                	jne    80101e94 <filewrite+0xc4>
80101e38:	01 fe                	add    %edi,%esi
80101e3a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101e3d:	7e 69                	jle    80101ea8 <filewrite+0xd8>
80101e3f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e42:	b8 00 06 00 00       	mov    $0x600,%eax
80101e47:	29 f7                	sub    %esi,%edi
80101e49:	39 c7                	cmp    %eax,%edi
80101e4b:	0f 4f f8             	cmovg  %eax,%edi
80101e4e:	e8 2d 1c 00 00       	call   80103a80 <begin_op>
80101e53:	83 ec 0c             	sub    $0xc,%esp
80101e56:	ff 73 10             	push   0x10(%ebx)
80101e59:	e8 42 06 00 00       	call   801024a0 <ilock>
80101e5e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e61:	57                   	push   %edi
80101e62:	ff 73 14             	push   0x14(%ebx)
80101e65:	01 f0                	add    %esi,%eax
80101e67:	50                   	push   %eax
80101e68:	ff 73 10             	push   0x10(%ebx)
80101e6b:	e8 40 0a 00 00       	call   801028b0 <writei>
80101e70:	83 c4 20             	add    $0x20,%esp
80101e73:	85 c0                	test   %eax,%eax
80101e75:	7f a1                	jg     80101e18 <filewrite+0x48>
80101e77:	83 ec 0c             	sub    $0xc,%esp
80101e7a:	ff 73 10             	push   0x10(%ebx)
80101e7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e80:	e8 fb 06 00 00       	call   80102580 <iunlock>
80101e85:	e8 66 1c 00 00       	call   80103af0 <end_op>
80101e8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e8d:	83 c4 10             	add    $0x10,%esp
80101e90:	85 c0                	test   %eax,%eax
80101e92:	75 1b                	jne    80101eaf <filewrite+0xdf>
80101e94:	83 ec 0c             	sub    $0xc,%esp
80101e97:	68 be 7f 10 80       	push   $0x80107fbe
80101e9c:	e8 4f e6 ff ff       	call   801004f0 <panic>
80101ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea8:	89 f0                	mov    %esi,%eax
80101eaa:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80101ead:	74 05                	je     80101eb4 <filewrite+0xe4>
80101eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb7:	5b                   	pop    %ebx
80101eb8:	5e                   	pop    %esi
80101eb9:	5f                   	pop    %edi
80101eba:	5d                   	pop    %ebp
80101ebb:	c3                   	ret    
80101ebc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ebf:	89 45 08             	mov    %eax,0x8(%ebp)
80101ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec5:	5b                   	pop    %ebx
80101ec6:	5e                   	pop    %esi
80101ec7:	5f                   	pop    %edi
80101ec8:	5d                   	pop    %ebp
80101ec9:	e9 22 24 00 00       	jmp    801042f0 <pipewrite>
80101ece:	83 ec 0c             	sub    $0xc,%esp
80101ed1:	68 c4 7f 10 80       	push   $0x80107fc4
80101ed6:	e8 15 e6 ff ff       	call   801004f0 <panic>
80101edb:	66 90                	xchg   %ax,%ax
80101edd:	66 90                	xchg   %ax,%ax
80101edf:	90                   	nop

80101ee0 <bfree>:
80101ee0:	55                   	push   %ebp
80101ee1:	89 c1                	mov    %eax,%ecx
80101ee3:	89 d0                	mov    %edx,%eax
80101ee5:	c1 e8 0c             	shr    $0xc,%eax
80101ee8:	03 05 0c 2c 11 80    	add    0x80112c0c,%eax
80101eee:	89 e5                	mov    %esp,%ebp
80101ef0:	56                   	push   %esi
80101ef1:	53                   	push   %ebx
80101ef2:	89 d3                	mov    %edx,%ebx
80101ef4:	83 ec 08             	sub    $0x8,%esp
80101ef7:	50                   	push   %eax
80101ef8:	51                   	push   %ecx
80101ef9:	e8 d2 e1 ff ff       	call   801000d0 <bread>
80101efe:	89 d9                	mov    %ebx,%ecx
80101f00:	c1 fb 03             	sar    $0x3,%ebx
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	89 c6                	mov    %eax,%esi
80101f08:	83 e1 07             	and    $0x7,%ecx
80101f0b:	b8 01 00 00 00       	mov    $0x1,%eax
80101f10:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101f16:	d3 e0                	shl    %cl,%eax
80101f18:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101f1d:	85 c1                	test   %eax,%ecx
80101f1f:	74 23                	je     80101f44 <bfree+0x64>
80101f21:	f7 d0                	not    %eax
80101f23:	83 ec 0c             	sub    $0xc,%esp
80101f26:	21 c8                	and    %ecx,%eax
80101f28:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
80101f2c:	56                   	push   %esi
80101f2d:	e8 2e 1d 00 00       	call   80103c60 <log_write>
80101f32:	89 34 24             	mov    %esi,(%esp)
80101f35:	e8 b6 e2 ff ff       	call   801001f0 <brelse>
80101f3a:	83 c4 10             	add    $0x10,%esp
80101f3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f40:	5b                   	pop    %ebx
80101f41:	5e                   	pop    %esi
80101f42:	5d                   	pop    %ebp
80101f43:	c3                   	ret    
80101f44:	83 ec 0c             	sub    $0xc,%esp
80101f47:	68 ce 7f 10 80       	push   $0x80107fce
80101f4c:	e8 9f e5 ff ff       	call   801004f0 <panic>
80101f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f5f:	90                   	nop

80101f60 <balloc>:
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 1c             	sub    $0x1c,%esp
80101f69:	8b 0d f4 2b 11 80    	mov    0x80112bf4,%ecx
80101f6f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f72:	85 c9                	test   %ecx,%ecx
80101f74:	0f 84 87 00 00 00    	je     80102001 <balloc+0xa1>
80101f7a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80101f81:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101f84:	83 ec 08             	sub    $0x8,%esp
80101f87:	89 f0                	mov    %esi,%eax
80101f89:	c1 f8 0c             	sar    $0xc,%eax
80101f8c:	03 05 0c 2c 11 80    	add    0x80112c0c,%eax
80101f92:	50                   	push   %eax
80101f93:	ff 75 d8             	push   -0x28(%ebp)
80101f96:	e8 35 e1 ff ff       	call   801000d0 <bread>
80101f9b:	83 c4 10             	add    $0x10,%esp
80101f9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101fa1:	a1 f4 2b 11 80       	mov    0x80112bf4,%eax
80101fa6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101fa9:	31 c0                	xor    %eax,%eax
80101fab:	eb 2f                	jmp    80101fdc <balloc+0x7c>
80101fad:	8d 76 00             	lea    0x0(%esi),%esi
80101fb0:	89 c1                	mov    %eax,%ecx
80101fb2:	bb 01 00 00 00       	mov    $0x1,%ebx
80101fb7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101fba:	83 e1 07             	and    $0x7,%ecx
80101fbd:	d3 e3                	shl    %cl,%ebx
80101fbf:	89 c1                	mov    %eax,%ecx
80101fc1:	c1 f9 03             	sar    $0x3,%ecx
80101fc4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101fc9:	89 fa                	mov    %edi,%edx
80101fcb:	85 df                	test   %ebx,%edi
80101fcd:	74 41                	je     80102010 <balloc+0xb0>
80101fcf:	83 c0 01             	add    $0x1,%eax
80101fd2:	83 c6 01             	add    $0x1,%esi
80101fd5:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101fda:	74 05                	je     80101fe1 <balloc+0x81>
80101fdc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101fdf:	77 cf                	ja     80101fb0 <balloc+0x50>
80101fe1:	83 ec 0c             	sub    $0xc,%esp
80101fe4:	ff 75 e4             	push   -0x1c(%ebp)
80101fe7:	e8 04 e2 ff ff       	call   801001f0 <brelse>
80101fec:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101ff3:	83 c4 10             	add    $0x10,%esp
80101ff6:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ff9:	39 05 f4 2b 11 80    	cmp    %eax,0x80112bf4
80101fff:	77 80                	ja     80101f81 <balloc+0x21>
80102001:	83 ec 0c             	sub    $0xc,%esp
80102004:	68 e1 7f 10 80       	push   $0x80107fe1
80102009:	e8 e2 e4 ff ff       	call   801004f0 <panic>
8010200e:	66 90                	xchg   %ax,%ax
80102010:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102013:	83 ec 0c             	sub    $0xc,%esp
80102016:	09 da                	or     %ebx,%edx
80102018:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
8010201c:	57                   	push   %edi
8010201d:	e8 3e 1c 00 00       	call   80103c60 <log_write>
80102022:	89 3c 24             	mov    %edi,(%esp)
80102025:	e8 c6 e1 ff ff       	call   801001f0 <brelse>
8010202a:	58                   	pop    %eax
8010202b:	5a                   	pop    %edx
8010202c:	56                   	push   %esi
8010202d:	ff 75 d8             	push   -0x28(%ebp)
80102030:	e8 9b e0 ff ff       	call   801000d0 <bread>
80102035:	83 c4 0c             	add    $0xc,%esp
80102038:	89 c3                	mov    %eax,%ebx
8010203a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010203d:	68 00 02 00 00       	push   $0x200
80102042:	6a 00                	push   $0x0
80102044:	50                   	push   %eax
80102045:	e8 36 33 00 00       	call   80105380 <memset>
8010204a:	89 1c 24             	mov    %ebx,(%esp)
8010204d:	e8 0e 1c 00 00       	call   80103c60 <log_write>
80102052:	89 1c 24             	mov    %ebx,(%esp)
80102055:	e8 96 e1 ff ff       	call   801001f0 <brelse>
8010205a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010205d:	89 f0                	mov    %esi,%eax
8010205f:	5b                   	pop    %ebx
80102060:	5e                   	pop    %esi
80102061:	5f                   	pop    %edi
80102062:	5d                   	pop    %ebp
80102063:	c3                   	ret    
80102064:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010206b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010206f:	90                   	nop

80102070 <iget>:
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	57                   	push   %edi
80102074:	89 c7                	mov    %eax,%edi
80102076:	56                   	push   %esi
80102077:	31 f6                	xor    %esi,%esi
80102079:	53                   	push   %ebx
8010207a:	bb d4 0f 11 80       	mov    $0x80110fd4,%ebx
8010207f:	83 ec 28             	sub    $0x28,%esp
80102082:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102085:	68 a0 0f 11 80       	push   $0x80110fa0
8010208a:	e8 31 32 00 00       	call   801052c0 <acquire>
8010208f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102092:	83 c4 10             	add    $0x10,%esp
80102095:	eb 1b                	jmp    801020b2 <iget+0x42>
80102097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010209e:	66 90                	xchg   %ax,%ax
801020a0:	39 3b                	cmp    %edi,(%ebx)
801020a2:	74 6c                	je     80102110 <iget+0xa0>
801020a4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020aa:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
801020b0:	73 26                	jae    801020d8 <iget+0x68>
801020b2:	8b 43 08             	mov    0x8(%ebx),%eax
801020b5:	85 c0                	test   %eax,%eax
801020b7:	7f e7                	jg     801020a0 <iget+0x30>
801020b9:	85 f6                	test   %esi,%esi
801020bb:	75 e7                	jne    801020a4 <iget+0x34>
801020bd:	85 c0                	test   %eax,%eax
801020bf:	75 76                	jne    80102137 <iget+0xc7>
801020c1:	89 de                	mov    %ebx,%esi
801020c3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020c9:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
801020cf:	72 e1                	jb     801020b2 <iget+0x42>
801020d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d8:	85 f6                	test   %esi,%esi
801020da:	74 79                	je     80102155 <iget+0xe5>
801020dc:	83 ec 0c             	sub    $0xc,%esp
801020df:	89 3e                	mov    %edi,(%esi)
801020e1:	89 56 04             	mov    %edx,0x4(%esi)
801020e4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
801020eb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801020f2:	68 a0 0f 11 80       	push   $0x80110fa0
801020f7:	e8 64 31 00 00       	call   80105260 <release>
801020fc:	83 c4 10             	add    $0x10,%esp
801020ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102102:	89 f0                	mov    %esi,%eax
80102104:	5b                   	pop    %ebx
80102105:	5e                   	pop    %esi
80102106:	5f                   	pop    %edi
80102107:	5d                   	pop    %ebp
80102108:	c3                   	ret    
80102109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102110:	39 53 04             	cmp    %edx,0x4(%ebx)
80102113:	75 8f                	jne    801020a4 <iget+0x34>
80102115:	83 ec 0c             	sub    $0xc,%esp
80102118:	83 c0 01             	add    $0x1,%eax
8010211b:	89 de                	mov    %ebx,%esi
8010211d:	68 a0 0f 11 80       	push   $0x80110fa0
80102122:	89 43 08             	mov    %eax,0x8(%ebx)
80102125:	e8 36 31 00 00       	call   80105260 <release>
8010212a:	83 c4 10             	add    $0x10,%esp
8010212d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102130:	89 f0                	mov    %esi,%eax
80102132:	5b                   	pop    %ebx
80102133:	5e                   	pop    %esi
80102134:	5f                   	pop    %edi
80102135:	5d                   	pop    %ebp
80102136:	c3                   	ret    
80102137:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010213d:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
80102143:	73 10                	jae    80102155 <iget+0xe5>
80102145:	8b 43 08             	mov    0x8(%ebx),%eax
80102148:	85 c0                	test   %eax,%eax
8010214a:	0f 8f 50 ff ff ff    	jg     801020a0 <iget+0x30>
80102150:	e9 68 ff ff ff       	jmp    801020bd <iget+0x4d>
80102155:	83 ec 0c             	sub    $0xc,%esp
80102158:	68 f7 7f 10 80       	push   $0x80107ff7
8010215d:	e8 8e e3 ff ff       	call   801004f0 <panic>
80102162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <bmap>:
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	57                   	push   %edi
80102174:	56                   	push   %esi
80102175:	89 c6                	mov    %eax,%esi
80102177:	53                   	push   %ebx
80102178:	83 ec 1c             	sub    $0x1c,%esp
8010217b:	83 fa 0b             	cmp    $0xb,%edx
8010217e:	0f 86 8c 00 00 00    	jbe    80102210 <bmap+0xa0>
80102184:	8d 5a f4             	lea    -0xc(%edx),%ebx
80102187:	83 fb 7f             	cmp    $0x7f,%ebx
8010218a:	0f 87 a2 00 00 00    	ja     80102232 <bmap+0xc2>
80102190:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102196:	85 c0                	test   %eax,%eax
80102198:	74 5e                	je     801021f8 <bmap+0x88>
8010219a:	83 ec 08             	sub    $0x8,%esp
8010219d:	50                   	push   %eax
8010219e:	ff 36                	push   (%esi)
801021a0:	e8 2b df ff ff       	call   801000d0 <bread>
801021a5:	83 c4 10             	add    $0x10,%esp
801021a8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
801021ac:	89 c2                	mov    %eax,%edx
801021ae:	8b 3b                	mov    (%ebx),%edi
801021b0:	85 ff                	test   %edi,%edi
801021b2:	74 1c                	je     801021d0 <bmap+0x60>
801021b4:	83 ec 0c             	sub    $0xc,%esp
801021b7:	52                   	push   %edx
801021b8:	e8 33 e0 ff ff       	call   801001f0 <brelse>
801021bd:	83 c4 10             	add    $0x10,%esp
801021c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021c3:	89 f8                	mov    %edi,%eax
801021c5:	5b                   	pop    %ebx
801021c6:	5e                   	pop    %esi
801021c7:	5f                   	pop    %edi
801021c8:	5d                   	pop    %ebp
801021c9:	c3                   	ret    
801021ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801021d3:	8b 06                	mov    (%esi),%eax
801021d5:	e8 86 fd ff ff       	call   80101f60 <balloc>
801021da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021dd:	83 ec 0c             	sub    $0xc,%esp
801021e0:	89 03                	mov    %eax,(%ebx)
801021e2:	89 c7                	mov    %eax,%edi
801021e4:	52                   	push   %edx
801021e5:	e8 76 1a 00 00       	call   80103c60 <log_write>
801021ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021ed:	83 c4 10             	add    $0x10,%esp
801021f0:	eb c2                	jmp    801021b4 <bmap+0x44>
801021f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021f8:	8b 06                	mov    (%esi),%eax
801021fa:	e8 61 fd ff ff       	call   80101f60 <balloc>
801021ff:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102205:	eb 93                	jmp    8010219a <bmap+0x2a>
80102207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010220e:	66 90                	xchg   %ax,%ax
80102210:	8d 5a 14             	lea    0x14(%edx),%ebx
80102213:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102217:	85 ff                	test   %edi,%edi
80102219:	75 a5                	jne    801021c0 <bmap+0x50>
8010221b:	8b 00                	mov    (%eax),%eax
8010221d:	e8 3e fd ff ff       	call   80101f60 <balloc>
80102222:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102226:	89 c7                	mov    %eax,%edi
80102228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222b:	5b                   	pop    %ebx
8010222c:	89 f8                	mov    %edi,%eax
8010222e:	5e                   	pop    %esi
8010222f:	5f                   	pop    %edi
80102230:	5d                   	pop    %ebp
80102231:	c3                   	ret    
80102232:	83 ec 0c             	sub    $0xc,%esp
80102235:	68 07 80 10 80       	push   $0x80108007
8010223a:	e8 b1 e2 ff ff       	call   801004f0 <panic>
8010223f:	90                   	nop

80102240 <readsb>:
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	56                   	push   %esi
80102244:	53                   	push   %ebx
80102245:	8b 75 0c             	mov    0xc(%ebp),%esi
80102248:	83 ec 08             	sub    $0x8,%esp
8010224b:	6a 01                	push   $0x1
8010224d:	ff 75 08             	push   0x8(%ebp)
80102250:	e8 7b de ff ff       	call   801000d0 <bread>
80102255:	83 c4 0c             	add    $0xc,%esp
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010225d:	6a 1c                	push   $0x1c
8010225f:	50                   	push   %eax
80102260:	56                   	push   %esi
80102261:	e8 ba 31 00 00       	call   80105420 <memmove>
80102266:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102269:	83 c4 10             	add    $0x10,%esp
8010226c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010226f:	5b                   	pop    %ebx
80102270:	5e                   	pop    %esi
80102271:	5d                   	pop    %ebp
80102272:	e9 79 df ff ff       	jmp    801001f0 <brelse>
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax

80102280 <iinit>:
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	53                   	push   %ebx
80102284:	bb e0 0f 11 80       	mov    $0x80110fe0,%ebx
80102289:	83 ec 0c             	sub    $0xc,%esp
8010228c:	68 1a 80 10 80       	push   $0x8010801a
80102291:	68 a0 0f 11 80       	push   $0x80110fa0
80102296:	e8 55 2e 00 00       	call   801050f0 <initlock>
8010229b:	83 c4 10             	add    $0x10,%esp
8010229e:	66 90                	xchg   %ax,%ax
801022a0:	83 ec 08             	sub    $0x8,%esp
801022a3:	68 21 80 10 80       	push   $0x80108021
801022a8:	53                   	push   %ebx
801022a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801022af:	e8 0c 2d 00 00       	call   80104fc0 <initsleeplock>
801022b4:	83 c4 10             	add    $0x10,%esp
801022b7:	81 fb 00 2c 11 80    	cmp    $0x80112c00,%ebx
801022bd:	75 e1                	jne    801022a0 <iinit+0x20>
801022bf:	83 ec 08             	sub    $0x8,%esp
801022c2:	6a 01                	push   $0x1
801022c4:	ff 75 08             	push   0x8(%ebp)
801022c7:	e8 04 de ff ff       	call   801000d0 <bread>
801022cc:	83 c4 0c             	add    $0xc,%esp
801022cf:	89 c3                	mov    %eax,%ebx
801022d1:	8d 40 5c             	lea    0x5c(%eax),%eax
801022d4:	6a 1c                	push   $0x1c
801022d6:	50                   	push   %eax
801022d7:	68 f4 2b 11 80       	push   $0x80112bf4
801022dc:	e8 3f 31 00 00       	call   80105420 <memmove>
801022e1:	89 1c 24             	mov    %ebx,(%esp)
801022e4:	e8 07 df ff ff       	call   801001f0 <brelse>
801022e9:	ff 35 0c 2c 11 80    	push   0x80112c0c
801022ef:	ff 35 08 2c 11 80    	push   0x80112c08
801022f5:	ff 35 04 2c 11 80    	push   0x80112c04
801022fb:	ff 35 00 2c 11 80    	push   0x80112c00
80102301:	ff 35 fc 2b 11 80    	push   0x80112bfc
80102307:	ff 35 f8 2b 11 80    	push   0x80112bf8
8010230d:	ff 35 f4 2b 11 80    	push   0x80112bf4
80102313:	68 84 80 10 80       	push   $0x80108084
80102318:	e8 53 e7 ff ff       	call   80100a70 <cprintf>
8010231d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102320:	83 c4 30             	add    $0x30,%esp
80102323:	c9                   	leave  
80102324:	c3                   	ret    
80102325:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010232c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102330 <ialloc>:
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 1c             	sub    $0x1c,%esp
80102339:	8b 45 0c             	mov    0xc(%ebp),%eax
8010233c:	83 3d fc 2b 11 80 01 	cmpl   $0x1,0x80112bfc
80102343:	8b 75 08             	mov    0x8(%ebp),%esi
80102346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102349:	0f 86 91 00 00 00    	jbe    801023e0 <ialloc+0xb0>
8010234f:	bf 01 00 00 00       	mov    $0x1,%edi
80102354:	eb 21                	jmp    80102377 <ialloc+0x47>
80102356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010235d:	8d 76 00             	lea    0x0(%esi),%esi
80102360:	83 ec 0c             	sub    $0xc,%esp
80102363:	83 c7 01             	add    $0x1,%edi
80102366:	53                   	push   %ebx
80102367:	e8 84 de ff ff       	call   801001f0 <brelse>
8010236c:	83 c4 10             	add    $0x10,%esp
8010236f:	3b 3d fc 2b 11 80    	cmp    0x80112bfc,%edi
80102375:	73 69                	jae    801023e0 <ialloc+0xb0>
80102377:	89 f8                	mov    %edi,%eax
80102379:	83 ec 08             	sub    $0x8,%esp
8010237c:	c1 e8 03             	shr    $0x3,%eax
8010237f:	03 05 08 2c 11 80    	add    0x80112c08,%eax
80102385:	50                   	push   %eax
80102386:	56                   	push   %esi
80102387:	e8 44 dd ff ff       	call   801000d0 <bread>
8010238c:	83 c4 10             	add    $0x10,%esp
8010238f:	89 c3                	mov    %eax,%ebx
80102391:	89 f8                	mov    %edi,%eax
80102393:	83 e0 07             	and    $0x7,%eax
80102396:	c1 e0 06             	shl    $0x6,%eax
80102399:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
8010239d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801023a1:	75 bd                	jne    80102360 <ialloc+0x30>
801023a3:	83 ec 04             	sub    $0x4,%esp
801023a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801023a9:	6a 40                	push   $0x40
801023ab:	6a 00                	push   $0x0
801023ad:	51                   	push   %ecx
801023ae:	e8 cd 2f 00 00       	call   80105380 <memset>
801023b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801023b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801023ba:	66 89 01             	mov    %ax,(%ecx)
801023bd:	89 1c 24             	mov    %ebx,(%esp)
801023c0:	e8 9b 18 00 00       	call   80103c60 <log_write>
801023c5:	89 1c 24             	mov    %ebx,(%esp)
801023c8:	e8 23 de ff ff       	call   801001f0 <brelse>
801023cd:	83 c4 10             	add    $0x10,%esp
801023d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023d3:	89 fa                	mov    %edi,%edx
801023d5:	5b                   	pop    %ebx
801023d6:	89 f0                	mov    %esi,%eax
801023d8:	5e                   	pop    %esi
801023d9:	5f                   	pop    %edi
801023da:	5d                   	pop    %ebp
801023db:	e9 90 fc ff ff       	jmp    80102070 <iget>
801023e0:	83 ec 0c             	sub    $0xc,%esp
801023e3:	68 27 80 10 80       	push   $0x80108027
801023e8:	e8 03 e1 ff ff       	call   801004f0 <panic>
801023ed:	8d 76 00             	lea    0x0(%esi),%esi

801023f0 <iupdate>:
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801023f8:	8b 43 04             	mov    0x4(%ebx),%eax
801023fb:	83 c3 5c             	add    $0x5c,%ebx
801023fe:	83 ec 08             	sub    $0x8,%esp
80102401:	c1 e8 03             	shr    $0x3,%eax
80102404:	03 05 08 2c 11 80    	add    0x80112c08,%eax
8010240a:	50                   	push   %eax
8010240b:	ff 73 a4             	push   -0x5c(%ebx)
8010240e:	e8 bd dc ff ff       	call   801000d0 <bread>
80102413:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80102417:	83 c4 0c             	add    $0xc,%esp
8010241a:	89 c6                	mov    %eax,%esi
8010241c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010241f:	83 e0 07             	and    $0x7,%eax
80102422:	c1 e0 06             	shl    $0x6,%eax
80102425:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102429:	66 89 10             	mov    %dx,(%eax)
8010242c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80102430:	83 c0 0c             	add    $0xc,%eax
80102433:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80102437:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010243b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
8010243f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102443:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80102447:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010244a:	89 50 fc             	mov    %edx,-0x4(%eax)
8010244d:	6a 34                	push   $0x34
8010244f:	53                   	push   %ebx
80102450:	50                   	push   %eax
80102451:	e8 ca 2f 00 00       	call   80105420 <memmove>
80102456:	89 34 24             	mov    %esi,(%esp)
80102459:	e8 02 18 00 00       	call   80103c60 <log_write>
8010245e:	89 75 08             	mov    %esi,0x8(%ebp)
80102461:	83 c4 10             	add    $0x10,%esp
80102464:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102467:	5b                   	pop    %ebx
80102468:	5e                   	pop    %esi
80102469:	5d                   	pop    %ebp
8010246a:	e9 81 dd ff ff       	jmp    801001f0 <brelse>
8010246f:	90                   	nop

80102470 <idup>:
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	53                   	push   %ebx
80102474:	83 ec 10             	sub    $0x10,%esp
80102477:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010247a:	68 a0 0f 11 80       	push   $0x80110fa0
8010247f:	e8 3c 2e 00 00       	call   801052c0 <acquire>
80102484:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80102488:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
8010248f:	e8 cc 2d 00 00       	call   80105260 <release>
80102494:	89 d8                	mov    %ebx,%eax
80102496:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102499:	c9                   	leave  
8010249a:	c3                   	ret    
8010249b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010249f:	90                   	nop

801024a0 <ilock>:
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801024a8:	85 db                	test   %ebx,%ebx
801024aa:	0f 84 b7 00 00 00    	je     80102567 <ilock+0xc7>
801024b0:	8b 53 08             	mov    0x8(%ebx),%edx
801024b3:	85 d2                	test   %edx,%edx
801024b5:	0f 8e ac 00 00 00    	jle    80102567 <ilock+0xc7>
801024bb:	83 ec 0c             	sub    $0xc,%esp
801024be:	8d 43 0c             	lea    0xc(%ebx),%eax
801024c1:	50                   	push   %eax
801024c2:	e8 39 2b 00 00       	call   80105000 <acquiresleep>
801024c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801024ca:	83 c4 10             	add    $0x10,%esp
801024cd:	85 c0                	test   %eax,%eax
801024cf:	74 0f                	je     801024e0 <ilock+0x40>
801024d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d4:	5b                   	pop    %ebx
801024d5:	5e                   	pop    %esi
801024d6:	5d                   	pop    %ebp
801024d7:	c3                   	ret    
801024d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024df:	90                   	nop
801024e0:	8b 43 04             	mov    0x4(%ebx),%eax
801024e3:	83 ec 08             	sub    $0x8,%esp
801024e6:	c1 e8 03             	shr    $0x3,%eax
801024e9:	03 05 08 2c 11 80    	add    0x80112c08,%eax
801024ef:	50                   	push   %eax
801024f0:	ff 33                	push   (%ebx)
801024f2:	e8 d9 db ff ff       	call   801000d0 <bread>
801024f7:	83 c4 0c             	add    $0xc,%esp
801024fa:	89 c6                	mov    %eax,%esi
801024fc:	8b 43 04             	mov    0x4(%ebx),%eax
801024ff:	83 e0 07             	and    $0x7,%eax
80102502:	c1 e0 06             	shl    $0x6,%eax
80102505:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102509:	0f b7 10             	movzwl (%eax),%edx
8010250c:	83 c0 0c             	add    $0xc,%eax
8010250f:	66 89 53 50          	mov    %dx,0x50(%ebx)
80102513:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102517:	66 89 53 52          	mov    %dx,0x52(%ebx)
8010251b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010251f:	66 89 53 54          	mov    %dx,0x54(%ebx)
80102523:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102527:	66 89 53 56          	mov    %dx,0x56(%ebx)
8010252b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010252e:	89 53 58             	mov    %edx,0x58(%ebx)
80102531:	6a 34                	push   $0x34
80102533:	50                   	push   %eax
80102534:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102537:	50                   	push   %eax
80102538:	e8 e3 2e 00 00       	call   80105420 <memmove>
8010253d:	89 34 24             	mov    %esi,(%esp)
80102540:	e8 ab dc ff ff       	call   801001f0 <brelse>
80102545:	83 c4 10             	add    $0x10,%esp
80102548:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010254d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80102554:	0f 85 77 ff ff ff    	jne    801024d1 <ilock+0x31>
8010255a:	83 ec 0c             	sub    $0xc,%esp
8010255d:	68 3f 80 10 80       	push   $0x8010803f
80102562:	e8 89 df ff ff       	call   801004f0 <panic>
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 39 80 10 80       	push   $0x80108039
8010256f:	e8 7c df ff ff       	call   801004f0 <panic>
80102574:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010257b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010257f:	90                   	nop

80102580 <iunlock>:
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
80102585:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102588:	85 db                	test   %ebx,%ebx
8010258a:	74 28                	je     801025b4 <iunlock+0x34>
8010258c:	83 ec 0c             	sub    $0xc,%esp
8010258f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102592:	56                   	push   %esi
80102593:	e8 08 2b 00 00       	call   801050a0 <holdingsleep>
80102598:	83 c4 10             	add    $0x10,%esp
8010259b:	85 c0                	test   %eax,%eax
8010259d:	74 15                	je     801025b4 <iunlock+0x34>
8010259f:	8b 43 08             	mov    0x8(%ebx),%eax
801025a2:	85 c0                	test   %eax,%eax
801025a4:	7e 0e                	jle    801025b4 <iunlock+0x34>
801025a6:	89 75 08             	mov    %esi,0x8(%ebp)
801025a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025ac:	5b                   	pop    %ebx
801025ad:	5e                   	pop    %esi
801025ae:	5d                   	pop    %ebp
801025af:	e9 ac 2a 00 00       	jmp    80105060 <releasesleep>
801025b4:	83 ec 0c             	sub    $0xc,%esp
801025b7:	68 4e 80 10 80       	push   $0x8010804e
801025bc:	e8 2f df ff ff       	call   801004f0 <panic>
801025c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025cf:	90                   	nop

801025d0 <iput>:
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	57                   	push   %edi
801025d4:	56                   	push   %esi
801025d5:	53                   	push   %ebx
801025d6:	83 ec 28             	sub    $0x28,%esp
801025d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801025dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801025df:	57                   	push   %edi
801025e0:	e8 1b 2a 00 00       	call   80105000 <acquiresleep>
801025e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801025e8:	83 c4 10             	add    $0x10,%esp
801025eb:	85 d2                	test   %edx,%edx
801025ed:	74 07                	je     801025f6 <iput+0x26>
801025ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801025f4:	74 32                	je     80102628 <iput+0x58>
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	57                   	push   %edi
801025fa:	e8 61 2a 00 00       	call   80105060 <releasesleep>
801025ff:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
80102606:	e8 b5 2c 00 00       	call   801052c0 <acquire>
8010260b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
8010260f:	83 c4 10             	add    $0x10,%esp
80102612:	c7 45 08 a0 0f 11 80 	movl   $0x80110fa0,0x8(%ebp)
80102619:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010261c:	5b                   	pop    %ebx
8010261d:	5e                   	pop    %esi
8010261e:	5f                   	pop    %edi
8010261f:	5d                   	pop    %ebp
80102620:	e9 3b 2c 00 00       	jmp    80105260 <release>
80102625:	8d 76 00             	lea    0x0(%esi),%esi
80102628:	83 ec 0c             	sub    $0xc,%esp
8010262b:	68 a0 0f 11 80       	push   $0x80110fa0
80102630:	e8 8b 2c 00 00       	call   801052c0 <acquire>
80102635:	8b 73 08             	mov    0x8(%ebx),%esi
80102638:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
8010263f:	e8 1c 2c 00 00       	call   80105260 <release>
80102644:	83 c4 10             	add    $0x10,%esp
80102647:	83 fe 01             	cmp    $0x1,%esi
8010264a:	75 aa                	jne    801025f6 <iput+0x26>
8010264c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102652:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102655:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102658:	89 cf                	mov    %ecx,%edi
8010265a:	eb 0b                	jmp    80102667 <iput+0x97>
8010265c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102660:	83 c6 04             	add    $0x4,%esi
80102663:	39 fe                	cmp    %edi,%esi
80102665:	74 19                	je     80102680 <iput+0xb0>
80102667:	8b 16                	mov    (%esi),%edx
80102669:	85 d2                	test   %edx,%edx
8010266b:	74 f3                	je     80102660 <iput+0x90>
8010266d:	8b 03                	mov    (%ebx),%eax
8010266f:	e8 6c f8 ff ff       	call   80101ee0 <bfree>
80102674:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010267a:	eb e4                	jmp    80102660 <iput+0x90>
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102680:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102686:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102689:	85 c0                	test   %eax,%eax
8010268b:	75 2d                	jne    801026ba <iput+0xea>
8010268d:	83 ec 0c             	sub    $0xc,%esp
80102690:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102697:	53                   	push   %ebx
80102698:	e8 53 fd ff ff       	call   801023f0 <iupdate>
8010269d:	31 c0                	xor    %eax,%eax
8010269f:	66 89 43 50          	mov    %ax,0x50(%ebx)
801026a3:	89 1c 24             	mov    %ebx,(%esp)
801026a6:	e8 45 fd ff ff       	call   801023f0 <iupdate>
801026ab:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801026b2:	83 c4 10             	add    $0x10,%esp
801026b5:	e9 3c ff ff ff       	jmp    801025f6 <iput+0x26>
801026ba:	83 ec 08             	sub    $0x8,%esp
801026bd:	50                   	push   %eax
801026be:	ff 33                	push   (%ebx)
801026c0:	e8 0b da ff ff       	call   801000d0 <bread>
801026c5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801026c8:	83 c4 10             	add    $0x10,%esp
801026cb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801026d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801026d4:	8d 70 5c             	lea    0x5c(%eax),%esi
801026d7:	89 cf                	mov    %ecx,%edi
801026d9:	eb 0c                	jmp    801026e7 <iput+0x117>
801026db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026df:	90                   	nop
801026e0:	83 c6 04             	add    $0x4,%esi
801026e3:	39 f7                	cmp    %esi,%edi
801026e5:	74 0f                	je     801026f6 <iput+0x126>
801026e7:	8b 16                	mov    (%esi),%edx
801026e9:	85 d2                	test   %edx,%edx
801026eb:	74 f3                	je     801026e0 <iput+0x110>
801026ed:	8b 03                	mov    (%ebx),%eax
801026ef:	e8 ec f7 ff ff       	call   80101ee0 <bfree>
801026f4:	eb ea                	jmp    801026e0 <iput+0x110>
801026f6:	83 ec 0c             	sub    $0xc,%esp
801026f9:	ff 75 e4             	push   -0x1c(%ebp)
801026fc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801026ff:	e8 ec da ff ff       	call   801001f0 <brelse>
80102704:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010270a:	8b 03                	mov    (%ebx),%eax
8010270c:	e8 cf f7 ff ff       	call   80101ee0 <bfree>
80102711:	83 c4 10             	add    $0x10,%esp
80102714:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010271b:	00 00 00 
8010271e:	e9 6a ff ff ff       	jmp    8010268d <iput+0xbd>
80102723:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102730 <iunlockput>:
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
80102735:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102738:	85 db                	test   %ebx,%ebx
8010273a:	74 34                	je     80102770 <iunlockput+0x40>
8010273c:	83 ec 0c             	sub    $0xc,%esp
8010273f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102742:	56                   	push   %esi
80102743:	e8 58 29 00 00       	call   801050a0 <holdingsleep>
80102748:	83 c4 10             	add    $0x10,%esp
8010274b:	85 c0                	test   %eax,%eax
8010274d:	74 21                	je     80102770 <iunlockput+0x40>
8010274f:	8b 43 08             	mov    0x8(%ebx),%eax
80102752:	85 c0                	test   %eax,%eax
80102754:	7e 1a                	jle    80102770 <iunlockput+0x40>
80102756:	83 ec 0c             	sub    $0xc,%esp
80102759:	56                   	push   %esi
8010275a:	e8 01 29 00 00       	call   80105060 <releasesleep>
8010275f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102762:	83 c4 10             	add    $0x10,%esp
80102765:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102768:	5b                   	pop    %ebx
80102769:	5e                   	pop    %esi
8010276a:	5d                   	pop    %ebp
8010276b:	e9 60 fe ff ff       	jmp    801025d0 <iput>
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	68 4e 80 10 80       	push   $0x8010804e
80102778:	e8 73 dd ff ff       	call   801004f0 <panic>
8010277d:	8d 76 00             	lea    0x0(%esi),%esi

80102780 <stati>:
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	8b 55 08             	mov    0x8(%ebp),%edx
80102786:	8b 45 0c             	mov    0xc(%ebp),%eax
80102789:	8b 0a                	mov    (%edx),%ecx
8010278b:	89 48 04             	mov    %ecx,0x4(%eax)
8010278e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102791:	89 48 08             	mov    %ecx,0x8(%eax)
80102794:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102798:	66 89 08             	mov    %cx,(%eax)
8010279b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010279f:	66 89 48 0c          	mov    %cx,0xc(%eax)
801027a3:	8b 52 58             	mov    0x58(%edx),%edx
801027a6:	89 50 10             	mov    %edx,0x10(%eax)
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret    
801027ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027af:	90                   	nop

801027b0 <readi>:
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	57                   	push   %edi
801027b4:	56                   	push   %esi
801027b5:	53                   	push   %ebx
801027b6:	83 ec 1c             	sub    $0x1c,%esp
801027b9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801027bc:	8b 45 08             	mov    0x8(%ebp),%eax
801027bf:	8b 75 10             	mov    0x10(%ebp),%esi
801027c2:	89 7d e0             	mov    %edi,-0x20(%ebp)
801027c5:	8b 7d 14             	mov    0x14(%ebp),%edi
801027c8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801027cd:	89 45 d8             	mov    %eax,-0x28(%ebp)
801027d0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801027d3:	0f 84 a7 00 00 00    	je     80102880 <readi+0xd0>
801027d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801027dc:	8b 40 58             	mov    0x58(%eax),%eax
801027df:	39 c6                	cmp    %eax,%esi
801027e1:	0f 87 ba 00 00 00    	ja     801028a1 <readi+0xf1>
801027e7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801027ea:	31 c9                	xor    %ecx,%ecx
801027ec:	89 da                	mov    %ebx,%edx
801027ee:	01 f2                	add    %esi,%edx
801027f0:	0f 92 c1             	setb   %cl
801027f3:	89 cf                	mov    %ecx,%edi
801027f5:	0f 82 a6 00 00 00    	jb     801028a1 <readi+0xf1>
801027fb:	89 c1                	mov    %eax,%ecx
801027fd:	29 f1                	sub    %esi,%ecx
801027ff:	39 d0                	cmp    %edx,%eax
80102801:	0f 43 cb             	cmovae %ebx,%ecx
80102804:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102807:	85 c9                	test   %ecx,%ecx
80102809:	74 67                	je     80102872 <readi+0xc2>
8010280b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010280f:	90                   	nop
80102810:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102813:	89 f2                	mov    %esi,%edx
80102815:	c1 ea 09             	shr    $0x9,%edx
80102818:	89 d8                	mov    %ebx,%eax
8010281a:	e8 51 f9 ff ff       	call   80102170 <bmap>
8010281f:	83 ec 08             	sub    $0x8,%esp
80102822:	50                   	push   %eax
80102823:	ff 33                	push   (%ebx)
80102825:	e8 a6 d8 ff ff       	call   801000d0 <bread>
8010282a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010282d:	b9 00 02 00 00       	mov    $0x200,%ecx
80102832:	89 c2                	mov    %eax,%edx
80102834:	89 f0                	mov    %esi,%eax
80102836:	25 ff 01 00 00       	and    $0x1ff,%eax
8010283b:	29 fb                	sub    %edi,%ebx
8010283d:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102840:	29 c1                	sub    %eax,%ecx
80102842:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80102846:	39 d9                	cmp    %ebx,%ecx
80102848:	0f 46 d9             	cmovbe %ecx,%ebx
8010284b:	83 c4 0c             	add    $0xc,%esp
8010284e:	53                   	push   %ebx
8010284f:	01 df                	add    %ebx,%edi
80102851:	01 de                	add    %ebx,%esi
80102853:	50                   	push   %eax
80102854:	ff 75 e0             	push   -0x20(%ebp)
80102857:	e8 c4 2b 00 00       	call   80105420 <memmove>
8010285c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010285f:	89 14 24             	mov    %edx,(%esp)
80102862:	e8 89 d9 ff ff       	call   801001f0 <brelse>
80102867:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010286a:	83 c4 10             	add    $0x10,%esp
8010286d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102870:	77 9e                	ja     80102810 <readi+0x60>
80102872:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102875:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102878:	5b                   	pop    %ebx
80102879:	5e                   	pop    %esi
8010287a:	5f                   	pop    %edi
8010287b:	5d                   	pop    %ebp
8010287c:	c3                   	ret    
8010287d:	8d 76 00             	lea    0x0(%esi),%esi
80102880:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102884:	66 83 f8 09          	cmp    $0x9,%ax
80102888:	77 17                	ja     801028a1 <readi+0xf1>
8010288a:	8b 04 c5 40 0f 11 80 	mov    -0x7feef0c0(,%eax,8),%eax
80102891:	85 c0                	test   %eax,%eax
80102893:	74 0c                	je     801028a1 <readi+0xf1>
80102895:	89 7d 10             	mov    %edi,0x10(%ebp)
80102898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010289b:	5b                   	pop    %ebx
8010289c:	5e                   	pop    %esi
8010289d:	5f                   	pop    %edi
8010289e:	5d                   	pop    %ebp
8010289f:	ff e0                	jmp    *%eax
801028a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028a6:	eb cd                	jmp    80102875 <readi+0xc5>
801028a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028af:	90                   	nop

801028b0 <writei>:
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	57                   	push   %edi
801028b4:	56                   	push   %esi
801028b5:	53                   	push   %ebx
801028b6:	83 ec 1c             	sub    $0x1c,%esp
801028b9:	8b 45 08             	mov    0x8(%ebp),%eax
801028bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801028bf:	8b 55 14             	mov    0x14(%ebp),%edx
801028c2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801028c7:	89 75 dc             	mov    %esi,-0x24(%ebp)
801028ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028cd:	8b 75 10             	mov    0x10(%ebp),%esi
801028d0:	89 55 e0             	mov    %edx,-0x20(%ebp)
801028d3:	0f 84 b7 00 00 00    	je     80102990 <writei+0xe0>
801028d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801028dc:	3b 70 58             	cmp    0x58(%eax),%esi
801028df:	0f 87 e7 00 00 00    	ja     801029cc <writei+0x11c>
801028e5:	8b 7d e0             	mov    -0x20(%ebp),%edi
801028e8:	31 d2                	xor    %edx,%edx
801028ea:	89 f8                	mov    %edi,%eax
801028ec:	01 f0                	add    %esi,%eax
801028ee:	0f 92 c2             	setb   %dl
801028f1:	3d 00 18 01 00       	cmp    $0x11800,%eax
801028f6:	0f 87 d0 00 00 00    	ja     801029cc <writei+0x11c>
801028fc:	85 d2                	test   %edx,%edx
801028fe:	0f 85 c8 00 00 00    	jne    801029cc <writei+0x11c>
80102904:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010290b:	85 ff                	test   %edi,%edi
8010290d:	74 72                	je     80102981 <writei+0xd1>
8010290f:	90                   	nop
80102910:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102913:	89 f2                	mov    %esi,%edx
80102915:	c1 ea 09             	shr    $0x9,%edx
80102918:	89 f8                	mov    %edi,%eax
8010291a:	e8 51 f8 ff ff       	call   80102170 <bmap>
8010291f:	83 ec 08             	sub    $0x8,%esp
80102922:	50                   	push   %eax
80102923:	ff 37                	push   (%edi)
80102925:	e8 a6 d7 ff ff       	call   801000d0 <bread>
8010292a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010292f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102932:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
80102935:	89 c7                	mov    %eax,%edi
80102937:	89 f0                	mov    %esi,%eax
80102939:	25 ff 01 00 00       	and    $0x1ff,%eax
8010293e:	29 c1                	sub    %eax,%ecx
80102940:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
80102944:	39 d9                	cmp    %ebx,%ecx
80102946:	0f 46 d9             	cmovbe %ecx,%ebx
80102949:	83 c4 0c             	add    $0xc,%esp
8010294c:	53                   	push   %ebx
8010294d:	01 de                	add    %ebx,%esi
8010294f:	ff 75 dc             	push   -0x24(%ebp)
80102952:	50                   	push   %eax
80102953:	e8 c8 2a 00 00       	call   80105420 <memmove>
80102958:	89 3c 24             	mov    %edi,(%esp)
8010295b:	e8 00 13 00 00       	call   80103c60 <log_write>
80102960:	89 3c 24             	mov    %edi,(%esp)
80102963:	e8 88 d8 ff ff       	call   801001f0 <brelse>
80102968:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010296b:	83 c4 10             	add    $0x10,%esp
8010296e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102971:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102974:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102977:	77 97                	ja     80102910 <writei+0x60>
80102979:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010297c:	3b 70 58             	cmp    0x58(%eax),%esi
8010297f:	77 37                	ja     801029b8 <writei+0x108>
80102981:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102984:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102987:	5b                   	pop    %ebx
80102988:	5e                   	pop    %esi
80102989:	5f                   	pop    %edi
8010298a:	5d                   	pop    %ebp
8010298b:	c3                   	ret    
8010298c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102990:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102994:	66 83 f8 09          	cmp    $0x9,%ax
80102998:	77 32                	ja     801029cc <writei+0x11c>
8010299a:	8b 04 c5 44 0f 11 80 	mov    -0x7feef0bc(,%eax,8),%eax
801029a1:	85 c0                	test   %eax,%eax
801029a3:	74 27                	je     801029cc <writei+0x11c>
801029a5:	89 55 10             	mov    %edx,0x10(%ebp)
801029a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029ab:	5b                   	pop    %ebx
801029ac:	5e                   	pop    %esi
801029ad:	5f                   	pop    %edi
801029ae:	5d                   	pop    %ebp
801029af:	ff e0                	jmp    *%eax
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
801029bb:	83 ec 0c             	sub    $0xc,%esp
801029be:	89 70 58             	mov    %esi,0x58(%eax)
801029c1:	50                   	push   %eax
801029c2:	e8 29 fa ff ff       	call   801023f0 <iupdate>
801029c7:	83 c4 10             	add    $0x10,%esp
801029ca:	eb b5                	jmp    80102981 <writei+0xd1>
801029cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801029d1:	eb b1                	jmp    80102984 <writei+0xd4>
801029d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029e0 <namecmp>:
801029e0:	55                   	push   %ebp
801029e1:	89 e5                	mov    %esp,%ebp
801029e3:	83 ec 0c             	sub    $0xc,%esp
801029e6:	6a 0e                	push   $0xe
801029e8:	ff 75 0c             	push   0xc(%ebp)
801029eb:	ff 75 08             	push   0x8(%ebp)
801029ee:	e8 9d 2a 00 00       	call   80105490 <strncmp>
801029f3:	c9                   	leave  
801029f4:	c3                   	ret    
801029f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a00 <dirlookup>:
80102a00:	55                   	push   %ebp
80102a01:	89 e5                	mov    %esp,%ebp
80102a03:	57                   	push   %edi
80102a04:	56                   	push   %esi
80102a05:	53                   	push   %ebx
80102a06:	83 ec 1c             	sub    $0x1c,%esp
80102a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102a11:	0f 85 85 00 00 00    	jne    80102a9c <dirlookup+0x9c>
80102a17:	8b 53 58             	mov    0x58(%ebx),%edx
80102a1a:	31 ff                	xor    %edi,%edi
80102a1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102a1f:	85 d2                	test   %edx,%edx
80102a21:	74 3e                	je     80102a61 <dirlookup+0x61>
80102a23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a27:	90                   	nop
80102a28:	6a 10                	push   $0x10
80102a2a:	57                   	push   %edi
80102a2b:	56                   	push   %esi
80102a2c:	53                   	push   %ebx
80102a2d:	e8 7e fd ff ff       	call   801027b0 <readi>
80102a32:	83 c4 10             	add    $0x10,%esp
80102a35:	83 f8 10             	cmp    $0x10,%eax
80102a38:	75 55                	jne    80102a8f <dirlookup+0x8f>
80102a3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102a3f:	74 18                	je     80102a59 <dirlookup+0x59>
80102a41:	83 ec 04             	sub    $0x4,%esp
80102a44:	8d 45 da             	lea    -0x26(%ebp),%eax
80102a47:	6a 0e                	push   $0xe
80102a49:	50                   	push   %eax
80102a4a:	ff 75 0c             	push   0xc(%ebp)
80102a4d:	e8 3e 2a 00 00       	call   80105490 <strncmp>
80102a52:	83 c4 10             	add    $0x10,%esp
80102a55:	85 c0                	test   %eax,%eax
80102a57:	74 17                	je     80102a70 <dirlookup+0x70>
80102a59:	83 c7 10             	add    $0x10,%edi
80102a5c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102a5f:	72 c7                	jb     80102a28 <dirlookup+0x28>
80102a61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a64:	31 c0                	xor    %eax,%eax
80102a66:	5b                   	pop    %ebx
80102a67:	5e                   	pop    %esi
80102a68:	5f                   	pop    %edi
80102a69:	5d                   	pop    %ebp
80102a6a:	c3                   	ret    
80102a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a6f:	90                   	nop
80102a70:	8b 45 10             	mov    0x10(%ebp),%eax
80102a73:	85 c0                	test   %eax,%eax
80102a75:	74 05                	je     80102a7c <dirlookup+0x7c>
80102a77:	8b 45 10             	mov    0x10(%ebp),%eax
80102a7a:	89 38                	mov    %edi,(%eax)
80102a7c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80102a80:	8b 03                	mov    (%ebx),%eax
80102a82:	e8 e9 f5 ff ff       	call   80102070 <iget>
80102a87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a8a:	5b                   	pop    %ebx
80102a8b:	5e                   	pop    %esi
80102a8c:	5f                   	pop    %edi
80102a8d:	5d                   	pop    %ebp
80102a8e:	c3                   	ret    
80102a8f:	83 ec 0c             	sub    $0xc,%esp
80102a92:	68 68 80 10 80       	push   $0x80108068
80102a97:	e8 54 da ff ff       	call   801004f0 <panic>
80102a9c:	83 ec 0c             	sub    $0xc,%esp
80102a9f:	68 56 80 10 80       	push   $0x80108056
80102aa4:	e8 47 da ff ff       	call   801004f0 <panic>
80102aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ab0 <namex>:
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	57                   	push   %edi
80102ab4:	56                   	push   %esi
80102ab5:	53                   	push   %ebx
80102ab6:	89 c3                	mov    %eax,%ebx
80102ab8:	83 ec 1c             	sub    $0x1c,%esp
80102abb:	80 38 2f             	cmpb   $0x2f,(%eax)
80102abe:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102ac1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102ac4:	0f 84 64 01 00 00    	je     80102c2e <namex+0x17e>
80102aca:	e8 c1 1b 00 00       	call   80104690 <myproc>
80102acf:	83 ec 0c             	sub    $0xc,%esp
80102ad2:	8b 70 68             	mov    0x68(%eax),%esi
80102ad5:	68 a0 0f 11 80       	push   $0x80110fa0
80102ada:	e8 e1 27 00 00       	call   801052c0 <acquire>
80102adf:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102ae3:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
80102aea:	e8 71 27 00 00       	call   80105260 <release>
80102aef:	83 c4 10             	add    $0x10,%esp
80102af2:	eb 07                	jmp    80102afb <namex+0x4b>
80102af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102af8:	83 c3 01             	add    $0x1,%ebx
80102afb:	0f b6 03             	movzbl (%ebx),%eax
80102afe:	3c 2f                	cmp    $0x2f,%al
80102b00:	74 f6                	je     80102af8 <namex+0x48>
80102b02:	84 c0                	test   %al,%al
80102b04:	0f 84 06 01 00 00    	je     80102c10 <namex+0x160>
80102b0a:	0f b6 03             	movzbl (%ebx),%eax
80102b0d:	84 c0                	test   %al,%al
80102b0f:	0f 84 10 01 00 00    	je     80102c25 <namex+0x175>
80102b15:	89 df                	mov    %ebx,%edi
80102b17:	3c 2f                	cmp    $0x2f,%al
80102b19:	0f 84 06 01 00 00    	je     80102c25 <namex+0x175>
80102b1f:	90                   	nop
80102b20:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80102b24:	83 c7 01             	add    $0x1,%edi
80102b27:	3c 2f                	cmp    $0x2f,%al
80102b29:	74 04                	je     80102b2f <namex+0x7f>
80102b2b:	84 c0                	test   %al,%al
80102b2d:	75 f1                	jne    80102b20 <namex+0x70>
80102b2f:	89 f8                	mov    %edi,%eax
80102b31:	29 d8                	sub    %ebx,%eax
80102b33:	83 f8 0d             	cmp    $0xd,%eax
80102b36:	0f 8e ac 00 00 00    	jle    80102be8 <namex+0x138>
80102b3c:	83 ec 04             	sub    $0x4,%esp
80102b3f:	6a 0e                	push   $0xe
80102b41:	53                   	push   %ebx
80102b42:	89 fb                	mov    %edi,%ebx
80102b44:	ff 75 e4             	push   -0x1c(%ebp)
80102b47:	e8 d4 28 00 00       	call   80105420 <memmove>
80102b4c:	83 c4 10             	add    $0x10,%esp
80102b4f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102b52:	75 0c                	jne    80102b60 <namex+0xb0>
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b58:	83 c3 01             	add    $0x1,%ebx
80102b5b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102b5e:	74 f8                	je     80102b58 <namex+0xa8>
80102b60:	83 ec 0c             	sub    $0xc,%esp
80102b63:	56                   	push   %esi
80102b64:	e8 37 f9 ff ff       	call   801024a0 <ilock>
80102b69:	83 c4 10             	add    $0x10,%esp
80102b6c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102b71:	0f 85 cd 00 00 00    	jne    80102c44 <namex+0x194>
80102b77:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102b7a:	85 c0                	test   %eax,%eax
80102b7c:	74 09                	je     80102b87 <namex+0xd7>
80102b7e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102b81:	0f 84 22 01 00 00    	je     80102ca9 <namex+0x1f9>
80102b87:	83 ec 04             	sub    $0x4,%esp
80102b8a:	6a 00                	push   $0x0
80102b8c:	ff 75 e4             	push   -0x1c(%ebp)
80102b8f:	56                   	push   %esi
80102b90:	e8 6b fe ff ff       	call   80102a00 <dirlookup>
80102b95:	8d 56 0c             	lea    0xc(%esi),%edx
80102b98:	83 c4 10             	add    $0x10,%esp
80102b9b:	89 c7                	mov    %eax,%edi
80102b9d:	85 c0                	test   %eax,%eax
80102b9f:	0f 84 e1 00 00 00    	je     80102c86 <namex+0x1d6>
80102ba5:	83 ec 0c             	sub    $0xc,%esp
80102ba8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102bab:	52                   	push   %edx
80102bac:	e8 ef 24 00 00       	call   801050a0 <holdingsleep>
80102bb1:	83 c4 10             	add    $0x10,%esp
80102bb4:	85 c0                	test   %eax,%eax
80102bb6:	0f 84 30 01 00 00    	je     80102cec <namex+0x23c>
80102bbc:	8b 56 08             	mov    0x8(%esi),%edx
80102bbf:	85 d2                	test   %edx,%edx
80102bc1:	0f 8e 25 01 00 00    	jle    80102cec <namex+0x23c>
80102bc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102bca:	83 ec 0c             	sub    $0xc,%esp
80102bcd:	52                   	push   %edx
80102bce:	e8 8d 24 00 00       	call   80105060 <releasesleep>
80102bd3:	89 34 24             	mov    %esi,(%esp)
80102bd6:	89 fe                	mov    %edi,%esi
80102bd8:	e8 f3 f9 ff ff       	call   801025d0 <iput>
80102bdd:	83 c4 10             	add    $0x10,%esp
80102be0:	e9 16 ff ff ff       	jmp    80102afb <namex+0x4b>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
80102be8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102beb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
80102bee:	83 ec 04             	sub    $0x4,%esp
80102bf1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102bf4:	50                   	push   %eax
80102bf5:	53                   	push   %ebx
80102bf6:	89 fb                	mov    %edi,%ebx
80102bf8:	ff 75 e4             	push   -0x1c(%ebp)
80102bfb:	e8 20 28 00 00       	call   80105420 <memmove>
80102c00:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102c03:	83 c4 10             	add    $0x10,%esp
80102c06:	c6 02 00             	movb   $0x0,(%edx)
80102c09:	e9 41 ff ff ff       	jmp    80102b4f <namex+0x9f>
80102c0e:	66 90                	xchg   %ax,%ax
80102c10:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c13:	85 c0                	test   %eax,%eax
80102c15:	0f 85 be 00 00 00    	jne    80102cd9 <namex+0x229>
80102c1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c1e:	89 f0                	mov    %esi,%eax
80102c20:	5b                   	pop    %ebx
80102c21:	5e                   	pop    %esi
80102c22:	5f                   	pop    %edi
80102c23:	5d                   	pop    %ebp
80102c24:	c3                   	ret    
80102c25:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102c28:	89 df                	mov    %ebx,%edi
80102c2a:	31 c0                	xor    %eax,%eax
80102c2c:	eb c0                	jmp    80102bee <namex+0x13e>
80102c2e:	ba 01 00 00 00       	mov    $0x1,%edx
80102c33:	b8 01 00 00 00       	mov    $0x1,%eax
80102c38:	e8 33 f4 ff ff       	call   80102070 <iget>
80102c3d:	89 c6                	mov    %eax,%esi
80102c3f:	e9 b7 fe ff ff       	jmp    80102afb <namex+0x4b>
80102c44:	83 ec 0c             	sub    $0xc,%esp
80102c47:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c4a:	53                   	push   %ebx
80102c4b:	e8 50 24 00 00       	call   801050a0 <holdingsleep>
80102c50:	83 c4 10             	add    $0x10,%esp
80102c53:	85 c0                	test   %eax,%eax
80102c55:	0f 84 91 00 00 00    	je     80102cec <namex+0x23c>
80102c5b:	8b 46 08             	mov    0x8(%esi),%eax
80102c5e:	85 c0                	test   %eax,%eax
80102c60:	0f 8e 86 00 00 00    	jle    80102cec <namex+0x23c>
80102c66:	83 ec 0c             	sub    $0xc,%esp
80102c69:	53                   	push   %ebx
80102c6a:	e8 f1 23 00 00       	call   80105060 <releasesleep>
80102c6f:	89 34 24             	mov    %esi,(%esp)
80102c72:	31 f6                	xor    %esi,%esi
80102c74:	e8 57 f9 ff ff       	call   801025d0 <iput>
80102c79:	83 c4 10             	add    $0x10,%esp
80102c7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c7f:	89 f0                	mov    %esi,%eax
80102c81:	5b                   	pop    %ebx
80102c82:	5e                   	pop    %esi
80102c83:	5f                   	pop    %edi
80102c84:	5d                   	pop    %ebp
80102c85:	c3                   	ret    
80102c86:	83 ec 0c             	sub    $0xc,%esp
80102c89:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102c8c:	52                   	push   %edx
80102c8d:	e8 0e 24 00 00       	call   801050a0 <holdingsleep>
80102c92:	83 c4 10             	add    $0x10,%esp
80102c95:	85 c0                	test   %eax,%eax
80102c97:	74 53                	je     80102cec <namex+0x23c>
80102c99:	8b 4e 08             	mov    0x8(%esi),%ecx
80102c9c:	85 c9                	test   %ecx,%ecx
80102c9e:	7e 4c                	jle    80102cec <namex+0x23c>
80102ca0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102ca3:	83 ec 0c             	sub    $0xc,%esp
80102ca6:	52                   	push   %edx
80102ca7:	eb c1                	jmp    80102c6a <namex+0x1ba>
80102ca9:	83 ec 0c             	sub    $0xc,%esp
80102cac:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102caf:	53                   	push   %ebx
80102cb0:	e8 eb 23 00 00       	call   801050a0 <holdingsleep>
80102cb5:	83 c4 10             	add    $0x10,%esp
80102cb8:	85 c0                	test   %eax,%eax
80102cba:	74 30                	je     80102cec <namex+0x23c>
80102cbc:	8b 7e 08             	mov    0x8(%esi),%edi
80102cbf:	85 ff                	test   %edi,%edi
80102cc1:	7e 29                	jle    80102cec <namex+0x23c>
80102cc3:	83 ec 0c             	sub    $0xc,%esp
80102cc6:	53                   	push   %ebx
80102cc7:	e8 94 23 00 00       	call   80105060 <releasesleep>
80102ccc:	83 c4 10             	add    $0x10,%esp
80102ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd2:	89 f0                	mov    %esi,%eax
80102cd4:	5b                   	pop    %ebx
80102cd5:	5e                   	pop    %esi
80102cd6:	5f                   	pop    %edi
80102cd7:	5d                   	pop    %ebp
80102cd8:	c3                   	ret    
80102cd9:	83 ec 0c             	sub    $0xc,%esp
80102cdc:	56                   	push   %esi
80102cdd:	31 f6                	xor    %esi,%esi
80102cdf:	e8 ec f8 ff ff       	call   801025d0 <iput>
80102ce4:	83 c4 10             	add    $0x10,%esp
80102ce7:	e9 2f ff ff ff       	jmp    80102c1b <namex+0x16b>
80102cec:	83 ec 0c             	sub    $0xc,%esp
80102cef:	68 4e 80 10 80       	push   $0x8010804e
80102cf4:	e8 f7 d7 ff ff       	call   801004f0 <panic>
80102cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d00 <dirlink>:
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	57                   	push   %edi
80102d04:	56                   	push   %esi
80102d05:	53                   	push   %ebx
80102d06:	83 ec 20             	sub    $0x20,%esp
80102d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d0c:	6a 00                	push   $0x0
80102d0e:	ff 75 0c             	push   0xc(%ebp)
80102d11:	53                   	push   %ebx
80102d12:	e8 e9 fc ff ff       	call   80102a00 <dirlookup>
80102d17:	83 c4 10             	add    $0x10,%esp
80102d1a:	85 c0                	test   %eax,%eax
80102d1c:	75 67                	jne    80102d85 <dirlink+0x85>
80102d1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102d21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d24:	85 ff                	test   %edi,%edi
80102d26:	74 29                	je     80102d51 <dirlink+0x51>
80102d28:	31 ff                	xor    %edi,%edi
80102d2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d2d:	eb 09                	jmp    80102d38 <dirlink+0x38>
80102d2f:	90                   	nop
80102d30:	83 c7 10             	add    $0x10,%edi
80102d33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102d36:	73 19                	jae    80102d51 <dirlink+0x51>
80102d38:	6a 10                	push   $0x10
80102d3a:	57                   	push   %edi
80102d3b:	56                   	push   %esi
80102d3c:	53                   	push   %ebx
80102d3d:	e8 6e fa ff ff       	call   801027b0 <readi>
80102d42:	83 c4 10             	add    $0x10,%esp
80102d45:	83 f8 10             	cmp    $0x10,%eax
80102d48:	75 4e                	jne    80102d98 <dirlink+0x98>
80102d4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102d4f:	75 df                	jne    80102d30 <dirlink+0x30>
80102d51:	83 ec 04             	sub    $0x4,%esp
80102d54:	8d 45 da             	lea    -0x26(%ebp),%eax
80102d57:	6a 0e                	push   $0xe
80102d59:	ff 75 0c             	push   0xc(%ebp)
80102d5c:	50                   	push   %eax
80102d5d:	e8 7e 27 00 00       	call   801054e0 <strncpy>
80102d62:	6a 10                	push   $0x10
80102d64:	8b 45 10             	mov    0x10(%ebp),%eax
80102d67:	57                   	push   %edi
80102d68:	56                   	push   %esi
80102d69:	53                   	push   %ebx
80102d6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
80102d6e:	e8 3d fb ff ff       	call   801028b0 <writei>
80102d73:	83 c4 20             	add    $0x20,%esp
80102d76:	83 f8 10             	cmp    $0x10,%eax
80102d79:	75 2a                	jne    80102da5 <dirlink+0xa5>
80102d7b:	31 c0                	xor    %eax,%eax
80102d7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d80:	5b                   	pop    %ebx
80102d81:	5e                   	pop    %esi
80102d82:	5f                   	pop    %edi
80102d83:	5d                   	pop    %ebp
80102d84:	c3                   	ret    
80102d85:	83 ec 0c             	sub    $0xc,%esp
80102d88:	50                   	push   %eax
80102d89:	e8 42 f8 ff ff       	call   801025d0 <iput>
80102d8e:	83 c4 10             	add    $0x10,%esp
80102d91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d96:	eb e5                	jmp    80102d7d <dirlink+0x7d>
80102d98:	83 ec 0c             	sub    $0xc,%esp
80102d9b:	68 77 80 10 80       	push   $0x80108077
80102da0:	e8 4b d7 ff ff       	call   801004f0 <panic>
80102da5:	83 ec 0c             	sub    $0xc,%esp
80102da8:	68 3e 86 10 80       	push   $0x8010863e
80102dad:	e8 3e d7 ff ff       	call   801004f0 <panic>
80102db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102dc0 <namei>:
80102dc0:	55                   	push   %ebp
80102dc1:	31 d2                	xor    %edx,%edx
80102dc3:	89 e5                	mov    %esp,%ebp
80102dc5:	83 ec 18             	sub    $0x18,%esp
80102dc8:	8b 45 08             	mov    0x8(%ebp),%eax
80102dcb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102dce:	e8 dd fc ff ff       	call   80102ab0 <namex>
80102dd3:	c9                   	leave  
80102dd4:	c3                   	ret    
80102dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102de0 <nameiparent>:
80102de0:	55                   	push   %ebp
80102de1:	ba 01 00 00 00       	mov    $0x1,%edx
80102de6:	89 e5                	mov    %esp,%ebp
80102de8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102deb:	8b 45 08             	mov    0x8(%ebp),%eax
80102dee:	5d                   	pop    %ebp
80102def:	e9 bc fc ff ff       	jmp    80102ab0 <namex>
80102df4:	66 90                	xchg   %ax,%ax
80102df6:	66 90                	xchg   %ax,%ax
80102df8:	66 90                	xchg   %ax,%ax
80102dfa:	66 90                	xchg   %ax,%ax
80102dfc:	66 90                	xchg   %ax,%ax
80102dfe:	66 90                	xchg   %ax,%ax

80102e00 <idestart>:
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	57                   	push   %edi
80102e04:	56                   	push   %esi
80102e05:	53                   	push   %ebx
80102e06:	83 ec 0c             	sub    $0xc,%esp
80102e09:	85 c0                	test   %eax,%eax
80102e0b:	0f 84 b4 00 00 00    	je     80102ec5 <idestart+0xc5>
80102e11:	8b 70 08             	mov    0x8(%eax),%esi
80102e14:	89 c3                	mov    %eax,%ebx
80102e16:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102e1c:	0f 87 96 00 00 00    	ja     80102eb8 <idestart+0xb8>
80102e22:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e2e:	66 90                	xchg   %ax,%ax
80102e30:	89 ca                	mov    %ecx,%edx
80102e32:	ec                   	in     (%dx),%al
80102e33:	83 e0 c0             	and    $0xffffffc0,%eax
80102e36:	3c 40                	cmp    $0x40,%al
80102e38:	75 f6                	jne    80102e30 <idestart+0x30>
80102e3a:	31 ff                	xor    %edi,%edi
80102e3c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102e41:	89 f8                	mov    %edi,%eax
80102e43:	ee                   	out    %al,(%dx)
80102e44:	b8 01 00 00 00       	mov    $0x1,%eax
80102e49:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102e4e:	ee                   	out    %al,(%dx)
80102e4f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102e54:	89 f0                	mov    %esi,%eax
80102e56:	ee                   	out    %al,(%dx)
80102e57:	89 f0                	mov    %esi,%eax
80102e59:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102e5e:	c1 f8 08             	sar    $0x8,%eax
80102e61:	ee                   	out    %al,(%dx)
80102e62:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102e67:	89 f8                	mov    %edi,%eax
80102e69:	ee                   	out    %al,(%dx)
80102e6a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102e6e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e73:	c1 e0 04             	shl    $0x4,%eax
80102e76:	83 e0 10             	and    $0x10,%eax
80102e79:	83 c8 e0             	or     $0xffffffe0,%eax
80102e7c:	ee                   	out    %al,(%dx)
80102e7d:	f6 03 04             	testb  $0x4,(%ebx)
80102e80:	75 16                	jne    80102e98 <idestart+0x98>
80102e82:	b8 20 00 00 00       	mov    $0x20,%eax
80102e87:	89 ca                	mov    %ecx,%edx
80102e89:	ee                   	out    %al,(%dx)
80102e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e8d:	5b                   	pop    %ebx
80102e8e:	5e                   	pop    %esi
80102e8f:	5f                   	pop    %edi
80102e90:	5d                   	pop    %ebp
80102e91:	c3                   	ret    
80102e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e98:	b8 30 00 00 00       	mov    $0x30,%eax
80102e9d:	89 ca                	mov    %ecx,%edx
80102e9f:	ee                   	out    %al,(%dx)
80102ea0:	b9 80 00 00 00       	mov    $0x80,%ecx
80102ea5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102ea8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102ead:	fc                   	cld    
80102eae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102eb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eb3:	5b                   	pop    %ebx
80102eb4:	5e                   	pop    %esi
80102eb5:	5f                   	pop    %edi
80102eb6:	5d                   	pop    %ebp
80102eb7:	c3                   	ret    
80102eb8:	83 ec 0c             	sub    $0xc,%esp
80102ebb:	68 e0 80 10 80       	push   $0x801080e0
80102ec0:	e8 2b d6 ff ff       	call   801004f0 <panic>
80102ec5:	83 ec 0c             	sub    $0xc,%esp
80102ec8:	68 d7 80 10 80       	push   $0x801080d7
80102ecd:	e8 1e d6 ff ff       	call   801004f0 <panic>
80102ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ee0 <ideinit>:
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 10             	sub    $0x10,%esp
80102ee6:	68 f2 80 10 80       	push   $0x801080f2
80102eeb:	68 40 2c 11 80       	push   $0x80112c40
80102ef0:	e8 fb 21 00 00       	call   801050f0 <initlock>
80102ef5:	58                   	pop    %eax
80102ef6:	a1 c4 2d 11 80       	mov    0x80112dc4,%eax
80102efb:	5a                   	pop    %edx
80102efc:	83 e8 01             	sub    $0x1,%eax
80102eff:	50                   	push   %eax
80102f00:	6a 0e                	push   $0xe
80102f02:	e8 99 02 00 00       	call   801031a0 <ioapicenable>
80102f07:	83 c4 10             	add    $0x10,%esp
80102f0a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f0f:	90                   	nop
80102f10:	ec                   	in     (%dx),%al
80102f11:	83 e0 c0             	and    $0xffffffc0,%eax
80102f14:	3c 40                	cmp    $0x40,%al
80102f16:	75 f8                	jne    80102f10 <ideinit+0x30>
80102f18:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102f1d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f22:	ee                   	out    %al,(%dx)
80102f23:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102f28:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f2d:	eb 06                	jmp    80102f35 <ideinit+0x55>
80102f2f:	90                   	nop
80102f30:	83 e9 01             	sub    $0x1,%ecx
80102f33:	74 0f                	je     80102f44 <ideinit+0x64>
80102f35:	ec                   	in     (%dx),%al
80102f36:	84 c0                	test   %al,%al
80102f38:	74 f6                	je     80102f30 <ideinit+0x50>
80102f3a:	c7 05 20 2c 11 80 01 	movl   $0x1,0x80112c20
80102f41:	00 00 00 
80102f44:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102f49:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f4e:	ee                   	out    %al,(%dx)
80102f4f:	c9                   	leave  
80102f50:	c3                   	ret    
80102f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f5f:	90                   	nop

80102f60 <ideintr>:
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	57                   	push   %edi
80102f64:	56                   	push   %esi
80102f65:	53                   	push   %ebx
80102f66:	83 ec 18             	sub    $0x18,%esp
80102f69:	68 40 2c 11 80       	push   $0x80112c40
80102f6e:	e8 4d 23 00 00       	call   801052c0 <acquire>
80102f73:	8b 1d 24 2c 11 80    	mov    0x80112c24,%ebx
80102f79:	83 c4 10             	add    $0x10,%esp
80102f7c:	85 db                	test   %ebx,%ebx
80102f7e:	74 63                	je     80102fe3 <ideintr+0x83>
80102f80:	8b 43 58             	mov    0x58(%ebx),%eax
80102f83:	a3 24 2c 11 80       	mov    %eax,0x80112c24
80102f88:	8b 33                	mov    (%ebx),%esi
80102f8a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102f90:	75 2f                	jne    80102fc1 <ideintr+0x61>
80102f92:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f9e:	66 90                	xchg   %ax,%ax
80102fa0:	ec                   	in     (%dx),%al
80102fa1:	89 c1                	mov    %eax,%ecx
80102fa3:	83 e1 c0             	and    $0xffffffc0,%ecx
80102fa6:	80 f9 40             	cmp    $0x40,%cl
80102fa9:	75 f5                	jne    80102fa0 <ideintr+0x40>
80102fab:	a8 21                	test   $0x21,%al
80102fad:	75 12                	jne    80102fc1 <ideintr+0x61>
80102faf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102fb2:	b9 80 00 00 00       	mov    $0x80,%ecx
80102fb7:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102fbc:	fc                   	cld    
80102fbd:	f3 6d                	rep insl (%dx),%es:(%edi)
80102fbf:	8b 33                	mov    (%ebx),%esi
80102fc1:	83 e6 fb             	and    $0xfffffffb,%esi
80102fc4:	83 ec 0c             	sub    $0xc,%esp
80102fc7:	83 ce 02             	or     $0x2,%esi
80102fca:	89 33                	mov    %esi,(%ebx)
80102fcc:	53                   	push   %ebx
80102fcd:	e8 4e 1e 00 00       	call   80104e20 <wakeup>
80102fd2:	a1 24 2c 11 80       	mov    0x80112c24,%eax
80102fd7:	83 c4 10             	add    $0x10,%esp
80102fda:	85 c0                	test   %eax,%eax
80102fdc:	74 05                	je     80102fe3 <ideintr+0x83>
80102fde:	e8 1d fe ff ff       	call   80102e00 <idestart>
80102fe3:	83 ec 0c             	sub    $0xc,%esp
80102fe6:	68 40 2c 11 80       	push   $0x80112c40
80102feb:	e8 70 22 00 00       	call   80105260 <release>
80102ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ff3:	5b                   	pop    %ebx
80102ff4:	5e                   	pop    %esi
80102ff5:	5f                   	pop    %edi
80102ff6:	5d                   	pop    %ebp
80102ff7:	c3                   	ret    
80102ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fff:	90                   	nop

80103000 <iderw>:
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 10             	sub    $0x10,%esp
80103007:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010300a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010300d:	50                   	push   %eax
8010300e:	e8 8d 20 00 00       	call   801050a0 <holdingsleep>
80103013:	83 c4 10             	add    $0x10,%esp
80103016:	85 c0                	test   %eax,%eax
80103018:	0f 84 c3 00 00 00    	je     801030e1 <iderw+0xe1>
8010301e:	8b 03                	mov    (%ebx),%eax
80103020:	83 e0 06             	and    $0x6,%eax
80103023:	83 f8 02             	cmp    $0x2,%eax
80103026:	0f 84 a8 00 00 00    	je     801030d4 <iderw+0xd4>
8010302c:	8b 53 04             	mov    0x4(%ebx),%edx
8010302f:	85 d2                	test   %edx,%edx
80103031:	74 0d                	je     80103040 <iderw+0x40>
80103033:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103038:	85 c0                	test   %eax,%eax
8010303a:	0f 84 87 00 00 00    	je     801030c7 <iderw+0xc7>
80103040:	83 ec 0c             	sub    $0xc,%esp
80103043:	68 40 2c 11 80       	push   $0x80112c40
80103048:	e8 73 22 00 00       	call   801052c0 <acquire>
8010304d:	a1 24 2c 11 80       	mov    0x80112c24,%eax
80103052:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80103059:	83 c4 10             	add    $0x10,%esp
8010305c:	85 c0                	test   %eax,%eax
8010305e:	74 60                	je     801030c0 <iderw+0xc0>
80103060:	89 c2                	mov    %eax,%edx
80103062:	8b 40 58             	mov    0x58(%eax),%eax
80103065:	85 c0                	test   %eax,%eax
80103067:	75 f7                	jne    80103060 <iderw+0x60>
80103069:	83 c2 58             	add    $0x58,%edx
8010306c:	89 1a                	mov    %ebx,(%edx)
8010306e:	39 1d 24 2c 11 80    	cmp    %ebx,0x80112c24
80103074:	74 3a                	je     801030b0 <iderw+0xb0>
80103076:	8b 03                	mov    (%ebx),%eax
80103078:	83 e0 06             	and    $0x6,%eax
8010307b:	83 f8 02             	cmp    $0x2,%eax
8010307e:	74 1b                	je     8010309b <iderw+0x9b>
80103080:	83 ec 08             	sub    $0x8,%esp
80103083:	68 40 2c 11 80       	push   $0x80112c40
80103088:	53                   	push   %ebx
80103089:	e8 d2 1c 00 00       	call   80104d60 <sleep>
8010308e:	8b 03                	mov    (%ebx),%eax
80103090:	83 c4 10             	add    $0x10,%esp
80103093:	83 e0 06             	and    $0x6,%eax
80103096:	83 f8 02             	cmp    $0x2,%eax
80103099:	75 e5                	jne    80103080 <iderw+0x80>
8010309b:	c7 45 08 40 2c 11 80 	movl   $0x80112c40,0x8(%ebp)
801030a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030a5:	c9                   	leave  
801030a6:	e9 b5 21 00 00       	jmp    80105260 <release>
801030ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030af:	90                   	nop
801030b0:	89 d8                	mov    %ebx,%eax
801030b2:	e8 49 fd ff ff       	call   80102e00 <idestart>
801030b7:	eb bd                	jmp    80103076 <iderw+0x76>
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030c0:	ba 24 2c 11 80       	mov    $0x80112c24,%edx
801030c5:	eb a5                	jmp    8010306c <iderw+0x6c>
801030c7:	83 ec 0c             	sub    $0xc,%esp
801030ca:	68 21 81 10 80       	push   $0x80108121
801030cf:	e8 1c d4 ff ff       	call   801004f0 <panic>
801030d4:	83 ec 0c             	sub    $0xc,%esp
801030d7:	68 0c 81 10 80       	push   $0x8010810c
801030dc:	e8 0f d4 ff ff       	call   801004f0 <panic>
801030e1:	83 ec 0c             	sub    $0xc,%esp
801030e4:	68 f6 80 10 80       	push   $0x801080f6
801030e9:	e8 02 d4 ff ff       	call   801004f0 <panic>
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <ioapicinit>:
801030f0:	55                   	push   %ebp
801030f1:	c7 05 74 2c 11 80 00 	movl   $0xfec00000,0x80112c74
801030f8:	00 c0 fe 
801030fb:	89 e5                	mov    %esp,%ebp
801030fd:	56                   	push   %esi
801030fe:	53                   	push   %ebx
801030ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103106:	00 00 00 
80103109:	8b 15 74 2c 11 80    	mov    0x80112c74,%edx
8010310f:	8b 72 10             	mov    0x10(%edx),%esi
80103112:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103118:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
8010311e:	0f b6 15 c0 2d 11 80 	movzbl 0x80112dc0,%edx
80103125:	c1 ee 10             	shr    $0x10,%esi
80103128:	89 f0                	mov    %esi,%eax
8010312a:	0f b6 f0             	movzbl %al,%esi
8010312d:	8b 41 10             	mov    0x10(%ecx),%eax
80103130:	c1 e8 18             	shr    $0x18,%eax
80103133:	39 c2                	cmp    %eax,%edx
80103135:	74 16                	je     8010314d <ioapicinit+0x5d>
80103137:	83 ec 0c             	sub    $0xc,%esp
8010313a:	68 40 81 10 80       	push   $0x80108140
8010313f:	e8 2c d9 ff ff       	call   80100a70 <cprintf>
80103144:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
8010314a:	83 c4 10             	add    $0x10,%esp
8010314d:	83 c6 21             	add    $0x21,%esi
80103150:	ba 10 00 00 00       	mov    $0x10,%edx
80103155:	b8 20 00 00 00       	mov    $0x20,%eax
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103160:	89 11                	mov    %edx,(%ecx)
80103162:	89 c3                	mov    %eax,%ebx
80103164:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
8010316a:	83 c0 01             	add    $0x1,%eax
8010316d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80103173:	89 59 10             	mov    %ebx,0x10(%ecx)
80103176:	8d 5a 01             	lea    0x1(%edx),%ebx
80103179:	83 c2 02             	add    $0x2,%edx
8010317c:	89 19                	mov    %ebx,(%ecx)
8010317e:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
80103184:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
8010318b:	39 f0                	cmp    %esi,%eax
8010318d:	75 d1                	jne    80103160 <ioapicinit+0x70>
8010318f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103192:	5b                   	pop    %ebx
80103193:	5e                   	pop    %esi
80103194:	5d                   	pop    %ebp
80103195:	c3                   	ret    
80103196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010319d:	8d 76 00             	lea    0x0(%esi),%esi

801031a0 <ioapicenable>:
801031a0:	55                   	push   %ebp
801031a1:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
801031a7:	89 e5                	mov    %esp,%ebp
801031a9:	8b 45 08             	mov    0x8(%ebp),%eax
801031ac:	8d 50 20             	lea    0x20(%eax),%edx
801031af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
801031b3:	89 01                	mov    %eax,(%ecx)
801031b5:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
801031bb:	83 c0 01             	add    $0x1,%eax
801031be:	89 51 10             	mov    %edx,0x10(%ecx)
801031c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801031c4:	89 01                	mov    %eax,(%ecx)
801031c6:	a1 74 2c 11 80       	mov    0x80112c74,%eax
801031cb:	c1 e2 18             	shl    $0x18,%edx
801031ce:	89 50 10             	mov    %edx,0x10(%eax)
801031d1:	5d                   	pop    %ebp
801031d2:	c3                   	ret    
801031d3:	66 90                	xchg   %ax,%ax
801031d5:	66 90                	xchg   %ax,%ax
801031d7:	66 90                	xchg   %ax,%ax
801031d9:	66 90                	xchg   %ax,%ax
801031db:	66 90                	xchg   %ax,%ax
801031dd:	66 90                	xchg   %ax,%ax
801031df:	90                   	nop

801031e0 <kfree>:
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	53                   	push   %ebx
801031e4:	83 ec 04             	sub    $0x4,%esp
801031e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801031ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801031f0:	75 76                	jne    80103268 <kfree+0x88>
801031f2:	81 fb 10 6b 11 80    	cmp    $0x80116b10,%ebx
801031f8:	72 6e                	jb     80103268 <kfree+0x88>
801031fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103200:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103205:	77 61                	ja     80103268 <kfree+0x88>
80103207:	83 ec 04             	sub    $0x4,%esp
8010320a:	68 00 10 00 00       	push   $0x1000
8010320f:	6a 01                	push   $0x1
80103211:	53                   	push   %ebx
80103212:	e8 69 21 00 00       	call   80105380 <memset>
80103217:	8b 15 b4 2c 11 80    	mov    0x80112cb4,%edx
8010321d:	83 c4 10             	add    $0x10,%esp
80103220:	85 d2                	test   %edx,%edx
80103222:	75 1c                	jne    80103240 <kfree+0x60>
80103224:	a1 b8 2c 11 80       	mov    0x80112cb8,%eax
80103229:	89 03                	mov    %eax,(%ebx)
8010322b:	a1 b4 2c 11 80       	mov    0x80112cb4,%eax
80103230:	89 1d b8 2c 11 80    	mov    %ebx,0x80112cb8
80103236:	85 c0                	test   %eax,%eax
80103238:	75 1e                	jne    80103258 <kfree+0x78>
8010323a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010323d:	c9                   	leave  
8010323e:	c3                   	ret    
8010323f:	90                   	nop
80103240:	83 ec 0c             	sub    $0xc,%esp
80103243:	68 80 2c 11 80       	push   $0x80112c80
80103248:	e8 73 20 00 00       	call   801052c0 <acquire>
8010324d:	83 c4 10             	add    $0x10,%esp
80103250:	eb d2                	jmp    80103224 <kfree+0x44>
80103252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103258:	c7 45 08 80 2c 11 80 	movl   $0x80112c80,0x8(%ebp)
8010325f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103262:	c9                   	leave  
80103263:	e9 f8 1f 00 00       	jmp    80105260 <release>
80103268:	83 ec 0c             	sub    $0xc,%esp
8010326b:	68 72 81 10 80       	push   $0x80108172
80103270:	e8 7b d2 ff ff       	call   801004f0 <panic>
80103275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010327c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103280 <freerange>:
80103280:	55                   	push   %ebp
80103281:	89 e5                	mov    %esp,%ebp
80103283:	56                   	push   %esi
80103284:	8b 45 08             	mov    0x8(%ebp),%eax
80103287:	8b 75 0c             	mov    0xc(%ebp),%esi
8010328a:	53                   	push   %ebx
8010328b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103291:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80103297:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010329d:	39 de                	cmp    %ebx,%esi
8010329f:	72 23                	jb     801032c4 <freerange+0x44>
801032a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032a8:	83 ec 0c             	sub    $0xc,%esp
801032ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801032b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032b7:	50                   	push   %eax
801032b8:	e8 23 ff ff ff       	call   801031e0 <kfree>
801032bd:	83 c4 10             	add    $0x10,%esp
801032c0:	39 f3                	cmp    %esi,%ebx
801032c2:	76 e4                	jbe    801032a8 <freerange+0x28>
801032c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032c7:	5b                   	pop    %ebx
801032c8:	5e                   	pop    %esi
801032c9:	5d                   	pop    %ebp
801032ca:	c3                   	ret    
801032cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032cf:	90                   	nop

801032d0 <kinit2>:
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	56                   	push   %esi
801032d4:	8b 45 08             	mov    0x8(%ebp),%eax
801032d7:	8b 75 0c             	mov    0xc(%ebp),%esi
801032da:	53                   	push   %ebx
801032db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801032e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032ed:	39 de                	cmp    %ebx,%esi
801032ef:	72 23                	jb     80103314 <kinit2+0x44>
801032f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032f8:	83 ec 0c             	sub    $0xc,%esp
801032fb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103301:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80103307:	50                   	push   %eax
80103308:	e8 d3 fe ff ff       	call   801031e0 <kfree>
8010330d:	83 c4 10             	add    $0x10,%esp
80103310:	39 de                	cmp    %ebx,%esi
80103312:	73 e4                	jae    801032f8 <kinit2+0x28>
80103314:	c7 05 b4 2c 11 80 01 	movl   $0x1,0x80112cb4
8010331b:	00 00 00 
8010331e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103321:	5b                   	pop    %ebx
80103322:	5e                   	pop    %esi
80103323:	5d                   	pop    %ebp
80103324:	c3                   	ret    
80103325:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103330 <kinit1>:
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	56                   	push   %esi
80103334:	53                   	push   %ebx
80103335:	8b 75 0c             	mov    0xc(%ebp),%esi
80103338:	83 ec 08             	sub    $0x8,%esp
8010333b:	68 78 81 10 80       	push   $0x80108178
80103340:	68 80 2c 11 80       	push   $0x80112c80
80103345:	e8 a6 1d 00 00       	call   801050f0 <initlock>
8010334a:	8b 45 08             	mov    0x8(%ebp),%eax
8010334d:	83 c4 10             	add    $0x10,%esp
80103350:	c7 05 b4 2c 11 80 00 	movl   $0x0,0x80112cb4
80103357:	00 00 00 
8010335a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103360:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80103366:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010336c:	39 de                	cmp    %ebx,%esi
8010336e:	72 1c                	jb     8010338c <kinit1+0x5c>
80103370:	83 ec 0c             	sub    $0xc,%esp
80103373:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103379:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010337f:	50                   	push   %eax
80103380:	e8 5b fe ff ff       	call   801031e0 <kfree>
80103385:	83 c4 10             	add    $0x10,%esp
80103388:	39 de                	cmp    %ebx,%esi
8010338a:	73 e4                	jae    80103370 <kinit1+0x40>
8010338c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010338f:	5b                   	pop    %ebx
80103390:	5e                   	pop    %esi
80103391:	5d                   	pop    %ebp
80103392:	c3                   	ret    
80103393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033a0 <kalloc>:
801033a0:	a1 b4 2c 11 80       	mov    0x80112cb4,%eax
801033a5:	85 c0                	test   %eax,%eax
801033a7:	75 1f                	jne    801033c8 <kalloc+0x28>
801033a9:	a1 b8 2c 11 80       	mov    0x80112cb8,%eax
801033ae:	85 c0                	test   %eax,%eax
801033b0:	74 0e                	je     801033c0 <kalloc+0x20>
801033b2:	8b 10                	mov    (%eax),%edx
801033b4:	89 15 b8 2c 11 80    	mov    %edx,0x80112cb8
801033ba:	c3                   	ret    
801033bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033bf:	90                   	nop
801033c0:	c3                   	ret    
801033c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033c8:	55                   	push   %ebp
801033c9:	89 e5                	mov    %esp,%ebp
801033cb:	83 ec 24             	sub    $0x24,%esp
801033ce:	68 80 2c 11 80       	push   $0x80112c80
801033d3:	e8 e8 1e 00 00       	call   801052c0 <acquire>
801033d8:	a1 b8 2c 11 80       	mov    0x80112cb8,%eax
801033dd:	8b 15 b4 2c 11 80    	mov    0x80112cb4,%edx
801033e3:	83 c4 10             	add    $0x10,%esp
801033e6:	85 c0                	test   %eax,%eax
801033e8:	74 08                	je     801033f2 <kalloc+0x52>
801033ea:	8b 08                	mov    (%eax),%ecx
801033ec:	89 0d b8 2c 11 80    	mov    %ecx,0x80112cb8
801033f2:	85 d2                	test   %edx,%edx
801033f4:	74 16                	je     8010340c <kalloc+0x6c>
801033f6:	83 ec 0c             	sub    $0xc,%esp
801033f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801033fc:	68 80 2c 11 80       	push   $0x80112c80
80103401:	e8 5a 1e 00 00       	call   80105260 <release>
80103406:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	c9                   	leave  
8010340d:	c3                   	ret    
8010340e:	66 90                	xchg   %ax,%ax

80103410 <kbdgetc>:
80103410:	ba 64 00 00 00       	mov    $0x64,%edx
80103415:	ec                   	in     (%dx),%al
80103416:	a8 01                	test   $0x1,%al
80103418:	0f 84 c2 00 00 00    	je     801034e0 <kbdgetc+0xd0>
8010341e:	55                   	push   %ebp
8010341f:	ba 60 00 00 00       	mov    $0x60,%edx
80103424:	89 e5                	mov    %esp,%ebp
80103426:	53                   	push   %ebx
80103427:	ec                   	in     (%dx),%al
80103428:	8b 1d bc 2c 11 80    	mov    0x80112cbc,%ebx
8010342e:	0f b6 c8             	movzbl %al,%ecx
80103431:	3c e0                	cmp    $0xe0,%al
80103433:	74 5b                	je     80103490 <kbdgetc+0x80>
80103435:	89 da                	mov    %ebx,%edx
80103437:	83 e2 40             	and    $0x40,%edx
8010343a:	84 c0                	test   %al,%al
8010343c:	78 62                	js     801034a0 <kbdgetc+0x90>
8010343e:	85 d2                	test   %edx,%edx
80103440:	74 09                	je     8010344b <kbdgetc+0x3b>
80103442:	83 c8 80             	or     $0xffffff80,%eax
80103445:	83 e3 bf             	and    $0xffffffbf,%ebx
80103448:	0f b6 c8             	movzbl %al,%ecx
8010344b:	0f b6 91 a0 82 10 80 	movzbl -0x7fef7d60(%ecx),%edx
80103452:	0f b6 81 a0 81 10 80 	movzbl -0x7fef7e60(%ecx),%eax
80103459:	09 da                	or     %ebx,%edx
8010345b:	31 c2                	xor    %eax,%edx
8010345d:	89 d0                	mov    %edx,%eax
8010345f:	89 15 bc 2c 11 80    	mov    %edx,0x80112cbc
80103465:	83 e0 03             	and    $0x3,%eax
80103468:	83 e2 08             	and    $0x8,%edx
8010346b:	8b 04 85 80 81 10 80 	mov    -0x7fef7e80(,%eax,4),%eax
80103472:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80103476:	74 0b                	je     80103483 <kbdgetc+0x73>
80103478:	8d 50 9f             	lea    -0x61(%eax),%edx
8010347b:	83 fa 19             	cmp    $0x19,%edx
8010347e:	77 48                	ja     801034c8 <kbdgetc+0xb8>
80103480:	83 e8 20             	sub    $0x20,%eax
80103483:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103486:	c9                   	leave  
80103487:	c3                   	ret    
80103488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010348f:	90                   	nop
80103490:	83 cb 40             	or     $0x40,%ebx
80103493:	31 c0                	xor    %eax,%eax
80103495:	89 1d bc 2c 11 80    	mov    %ebx,0x80112cbc
8010349b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010349e:	c9                   	leave  
8010349f:	c3                   	ret    
801034a0:	83 e0 7f             	and    $0x7f,%eax
801034a3:	85 d2                	test   %edx,%edx
801034a5:	0f 44 c8             	cmove  %eax,%ecx
801034a8:	0f b6 81 a0 82 10 80 	movzbl -0x7fef7d60(%ecx),%eax
801034af:	83 c8 40             	or     $0x40,%eax
801034b2:	0f b6 c0             	movzbl %al,%eax
801034b5:	f7 d0                	not    %eax
801034b7:	21 d8                	and    %ebx,%eax
801034b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034bc:	a3 bc 2c 11 80       	mov    %eax,0x80112cbc
801034c1:	31 c0                	xor    %eax,%eax
801034c3:	c9                   	leave  
801034c4:	c3                   	ret    
801034c5:	8d 76 00             	lea    0x0(%esi),%esi
801034c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
801034cb:	8d 50 20             	lea    0x20(%eax),%edx
801034ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034d1:	c9                   	leave  
801034d2:	83 f9 1a             	cmp    $0x1a,%ecx
801034d5:	0f 42 c2             	cmovb  %edx,%eax
801034d8:	c3                   	ret    
801034d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034e5:	c3                   	ret    
801034e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ed:	8d 76 00             	lea    0x0(%esi),%esi

801034f0 <kbdintr>:
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	83 ec 14             	sub    $0x14,%esp
801034f6:	68 10 34 10 80       	push   $0x80103410
801034fb:	e8 40 d8 ff ff       	call   80100d40 <consoleintr>
80103500:	83 c4 10             	add    $0x10,%esp
80103503:	c9                   	leave  
80103504:	c3                   	ret    
80103505:	66 90                	xchg   %ax,%ax
80103507:	66 90                	xchg   %ax,%ax
80103509:	66 90                	xchg   %ax,%ax
8010350b:	66 90                	xchg   %ax,%ax
8010350d:	66 90                	xchg   %ax,%ax
8010350f:	90                   	nop

80103510 <lapicinit>:
80103510:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
80103515:	85 c0                	test   %eax,%eax
80103517:	0f 84 cb 00 00 00    	je     801035e8 <lapicinit+0xd8>
8010351d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103524:	01 00 00 
80103527:	8b 50 20             	mov    0x20(%eax),%edx
8010352a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103531:	00 00 00 
80103534:	8b 50 20             	mov    0x20(%eax),%edx
80103537:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010353e:	00 02 00 
80103541:	8b 50 20             	mov    0x20(%eax),%edx
80103544:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010354b:	96 98 00 
8010354e:	8b 50 20             	mov    0x20(%eax),%edx
80103551:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103558:	00 01 00 
8010355b:	8b 50 20             	mov    0x20(%eax),%edx
8010355e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103565:	00 01 00 
80103568:	8b 50 20             	mov    0x20(%eax),%edx
8010356b:	8b 50 30             	mov    0x30(%eax),%edx
8010356e:	c1 ea 10             	shr    $0x10,%edx
80103571:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103577:	75 77                	jne    801035f0 <lapicinit+0xe0>
80103579:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103580:	00 00 00 
80103583:	8b 50 20             	mov    0x20(%eax),%edx
80103586:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010358d:	00 00 00 
80103590:	8b 50 20             	mov    0x20(%eax),%edx
80103593:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010359a:	00 00 00 
8010359d:	8b 50 20             	mov    0x20(%eax),%edx
801035a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801035a7:	00 00 00 
801035aa:	8b 50 20             	mov    0x20(%eax),%edx
801035ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801035b4:	00 00 00 
801035b7:	8b 50 20             	mov    0x20(%eax),%edx
801035ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801035c1:	85 08 00 
801035c4:	8b 50 20             	mov    0x20(%eax),%edx
801035c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035ce:	66 90                	xchg   %ax,%ax
801035d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801035d6:	80 e6 10             	and    $0x10,%dh
801035d9:	75 f5                	jne    801035d0 <lapicinit+0xc0>
801035db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801035e2:	00 00 00 
801035e5:	8b 40 20             	mov    0x20(%eax),%eax
801035e8:	c3                   	ret    
801035e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801035f7:	00 01 00 
801035fa:	8b 50 20             	mov    0x20(%eax),%edx
801035fd:	e9 77 ff ff ff       	jmp    80103579 <lapicinit+0x69>
80103602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103610 <lapicid>:
80103610:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
80103615:	85 c0                	test   %eax,%eax
80103617:	74 07                	je     80103620 <lapicid+0x10>
80103619:	8b 40 20             	mov    0x20(%eax),%eax
8010361c:	c1 e8 18             	shr    $0x18,%eax
8010361f:	c3                   	ret    
80103620:	31 c0                	xor    %eax,%eax
80103622:	c3                   	ret    
80103623:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010362a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103630 <lapiceoi>:
80103630:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
80103635:	85 c0                	test   %eax,%eax
80103637:	74 0d                	je     80103646 <lapiceoi+0x16>
80103639:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103640:	00 00 00 
80103643:	8b 40 20             	mov    0x20(%eax),%eax
80103646:	c3                   	ret    
80103647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010364e:	66 90                	xchg   %ax,%ax

80103650 <microdelay>:
80103650:	c3                   	ret    
80103651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010365f:	90                   	nop

80103660 <lapicstartap>:
80103660:	55                   	push   %ebp
80103661:	b8 0f 00 00 00       	mov    $0xf,%eax
80103666:	ba 70 00 00 00       	mov    $0x70,%edx
8010366b:	89 e5                	mov    %esp,%ebp
8010366d:	53                   	push   %ebx
8010366e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103671:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103674:	ee                   	out    %al,(%dx)
80103675:	b8 0a 00 00 00       	mov    $0xa,%eax
8010367a:	ba 71 00 00 00       	mov    $0x71,%edx
8010367f:	ee                   	out    %al,(%dx)
80103680:	31 c0                	xor    %eax,%eax
80103682:	c1 e3 18             	shl    $0x18,%ebx
80103685:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010368b:	89 c8                	mov    %ecx,%eax
8010368d:	c1 e9 0c             	shr    $0xc,%ecx
80103690:	89 da                	mov    %ebx,%edx
80103692:	c1 e8 04             	shr    $0x4,%eax
80103695:	80 cd 06             	or     $0x6,%ch
80103698:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010369e:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
801036a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
801036a9:	8b 58 20             	mov    0x20(%eax),%ebx
801036ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801036b3:	c5 00 00 
801036b6:	8b 58 20             	mov    0x20(%eax),%ebx
801036b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801036c0:	85 00 00 
801036c3:	8b 58 20             	mov    0x20(%eax),%ebx
801036c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801036cc:	8b 58 20             	mov    0x20(%eax),%ebx
801036cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801036d5:	8b 58 20             	mov    0x20(%eax),%ebx
801036d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801036de:	8b 50 20             	mov    0x20(%eax),%edx
801036e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801036e7:	8b 40 20             	mov    0x20(%eax),%eax
801036ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ed:	c9                   	leave  
801036ee:	c3                   	ret    
801036ef:	90                   	nop

801036f0 <cmostime>:
801036f0:	55                   	push   %ebp
801036f1:	b8 0b 00 00 00       	mov    $0xb,%eax
801036f6:	ba 70 00 00 00       	mov    $0x70,%edx
801036fb:	89 e5                	mov    %esp,%ebp
801036fd:	57                   	push   %edi
801036fe:	56                   	push   %esi
801036ff:	53                   	push   %ebx
80103700:	83 ec 4c             	sub    $0x4c,%esp
80103703:	ee                   	out    %al,(%dx)
80103704:	ba 71 00 00 00       	mov    $0x71,%edx
80103709:	ec                   	in     (%dx),%al
8010370a:	83 e0 04             	and    $0x4,%eax
8010370d:	bb 70 00 00 00       	mov    $0x70,%ebx
80103712:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103715:	8d 76 00             	lea    0x0(%esi),%esi
80103718:	31 c0                	xor    %eax,%eax
8010371a:	89 da                	mov    %ebx,%edx
8010371c:	ee                   	out    %al,(%dx)
8010371d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103722:	89 ca                	mov    %ecx,%edx
80103724:	ec                   	in     (%dx),%al
80103725:	88 45 b7             	mov    %al,-0x49(%ebp)
80103728:	89 da                	mov    %ebx,%edx
8010372a:	b8 02 00 00 00       	mov    $0x2,%eax
8010372f:	ee                   	out    %al,(%dx)
80103730:	89 ca                	mov    %ecx,%edx
80103732:	ec                   	in     (%dx),%al
80103733:	88 45 b6             	mov    %al,-0x4a(%ebp)
80103736:	89 da                	mov    %ebx,%edx
80103738:	b8 04 00 00 00       	mov    $0x4,%eax
8010373d:	ee                   	out    %al,(%dx)
8010373e:	89 ca                	mov    %ecx,%edx
80103740:	ec                   	in     (%dx),%al
80103741:	88 45 b5             	mov    %al,-0x4b(%ebp)
80103744:	89 da                	mov    %ebx,%edx
80103746:	b8 07 00 00 00       	mov    $0x7,%eax
8010374b:	ee                   	out    %al,(%dx)
8010374c:	89 ca                	mov    %ecx,%edx
8010374e:	ec                   	in     (%dx),%al
8010374f:	88 45 b4             	mov    %al,-0x4c(%ebp)
80103752:	89 da                	mov    %ebx,%edx
80103754:	b8 08 00 00 00       	mov    $0x8,%eax
80103759:	ee                   	out    %al,(%dx)
8010375a:	89 ca                	mov    %ecx,%edx
8010375c:	ec                   	in     (%dx),%al
8010375d:	89 c7                	mov    %eax,%edi
8010375f:	89 da                	mov    %ebx,%edx
80103761:	b8 09 00 00 00       	mov    $0x9,%eax
80103766:	ee                   	out    %al,(%dx)
80103767:	89 ca                	mov    %ecx,%edx
80103769:	ec                   	in     (%dx),%al
8010376a:	89 c6                	mov    %eax,%esi
8010376c:	89 da                	mov    %ebx,%edx
8010376e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103773:	ee                   	out    %al,(%dx)
80103774:	89 ca                	mov    %ecx,%edx
80103776:	ec                   	in     (%dx),%al
80103777:	84 c0                	test   %al,%al
80103779:	78 9d                	js     80103718 <cmostime+0x28>
8010377b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010377f:	89 fa                	mov    %edi,%edx
80103781:	0f b6 fa             	movzbl %dl,%edi
80103784:	89 f2                	mov    %esi,%edx
80103786:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103789:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010378d:	0f b6 f2             	movzbl %dl,%esi
80103790:	89 da                	mov    %ebx,%edx
80103792:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103795:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103798:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010379c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010379f:	89 45 c0             	mov    %eax,-0x40(%ebp)
801037a2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801037a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801037a9:	31 c0                	xor    %eax,%eax
801037ab:	ee                   	out    %al,(%dx)
801037ac:	89 ca                	mov    %ecx,%edx
801037ae:	ec                   	in     (%dx),%al
801037af:	0f b6 c0             	movzbl %al,%eax
801037b2:	89 da                	mov    %ebx,%edx
801037b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801037b7:	b8 02 00 00 00       	mov    $0x2,%eax
801037bc:	ee                   	out    %al,(%dx)
801037bd:	89 ca                	mov    %ecx,%edx
801037bf:	ec                   	in     (%dx),%al
801037c0:	0f b6 c0             	movzbl %al,%eax
801037c3:	89 da                	mov    %ebx,%edx
801037c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801037c8:	b8 04 00 00 00       	mov    $0x4,%eax
801037cd:	ee                   	out    %al,(%dx)
801037ce:	89 ca                	mov    %ecx,%edx
801037d0:	ec                   	in     (%dx),%al
801037d1:	0f b6 c0             	movzbl %al,%eax
801037d4:	89 da                	mov    %ebx,%edx
801037d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801037d9:	b8 07 00 00 00       	mov    $0x7,%eax
801037de:	ee                   	out    %al,(%dx)
801037df:	89 ca                	mov    %ecx,%edx
801037e1:	ec                   	in     (%dx),%al
801037e2:	0f b6 c0             	movzbl %al,%eax
801037e5:	89 da                	mov    %ebx,%edx
801037e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801037ea:	b8 08 00 00 00       	mov    $0x8,%eax
801037ef:	ee                   	out    %al,(%dx)
801037f0:	89 ca                	mov    %ecx,%edx
801037f2:	ec                   	in     (%dx),%al
801037f3:	0f b6 c0             	movzbl %al,%eax
801037f6:	89 da                	mov    %ebx,%edx
801037f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801037fb:	b8 09 00 00 00       	mov    $0x9,%eax
80103800:	ee                   	out    %al,(%dx)
80103801:	89 ca                	mov    %ecx,%edx
80103803:	ec                   	in     (%dx),%al
80103804:	0f b6 c0             	movzbl %al,%eax
80103807:	83 ec 04             	sub    $0x4,%esp
8010380a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010380d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103810:	6a 18                	push   $0x18
80103812:	50                   	push   %eax
80103813:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103816:	50                   	push   %eax
80103817:	e8 b4 1b 00 00       	call   801053d0 <memcmp>
8010381c:	83 c4 10             	add    $0x10,%esp
8010381f:	85 c0                	test   %eax,%eax
80103821:	0f 85 f1 fe ff ff    	jne    80103718 <cmostime+0x28>
80103827:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010382b:	75 78                	jne    801038a5 <cmostime+0x1b5>
8010382d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103830:	89 c2                	mov    %eax,%edx
80103832:	83 e0 0f             	and    $0xf,%eax
80103835:	c1 ea 04             	shr    $0x4,%edx
80103838:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010383b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010383e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103841:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103844:	89 c2                	mov    %eax,%edx
80103846:	83 e0 0f             	and    $0xf,%eax
80103849:	c1 ea 04             	shr    $0x4,%edx
8010384c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010384f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103852:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103855:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103858:	89 c2                	mov    %eax,%edx
8010385a:	83 e0 0f             	and    $0xf,%eax
8010385d:	c1 ea 04             	shr    $0x4,%edx
80103860:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103863:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103866:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103869:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010386c:	89 c2                	mov    %eax,%edx
8010386e:	83 e0 0f             	and    $0xf,%eax
80103871:	c1 ea 04             	shr    $0x4,%edx
80103874:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103877:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010387a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010387d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103880:	89 c2                	mov    %eax,%edx
80103882:	83 e0 0f             	and    $0xf,%eax
80103885:	c1 ea 04             	shr    $0x4,%edx
80103888:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010388b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010388e:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103891:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103894:	89 c2                	mov    %eax,%edx
80103896:	83 e0 0f             	and    $0xf,%eax
80103899:	c1 ea 04             	shr    $0x4,%edx
8010389c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010389f:	8d 04 50             	lea    (%eax,%edx,2),%eax
801038a2:	89 45 cc             	mov    %eax,-0x34(%ebp)
801038a5:	8b 75 08             	mov    0x8(%ebp),%esi
801038a8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801038ab:	89 06                	mov    %eax,(%esi)
801038ad:	8b 45 bc             	mov    -0x44(%ebp),%eax
801038b0:	89 46 04             	mov    %eax,0x4(%esi)
801038b3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801038b6:	89 46 08             	mov    %eax,0x8(%esi)
801038b9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801038bc:	89 46 0c             	mov    %eax,0xc(%esi)
801038bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
801038c2:	89 46 10             	mov    %eax,0x10(%esi)
801038c5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038c8:	89 46 14             	mov    %eax,0x14(%esi)
801038cb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
801038d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038d5:	5b                   	pop    %ebx
801038d6:	5e                   	pop    %esi
801038d7:	5f                   	pop    %edi
801038d8:	5d                   	pop    %ebp
801038d9:	c3                   	ret    
801038da:	66 90                	xchg   %ax,%ax
801038dc:	66 90                	xchg   %ax,%ax
801038de:	66 90                	xchg   %ax,%ax

801038e0 <install_trans>:
801038e0:	8b 0d 28 2d 11 80    	mov    0x80112d28,%ecx
801038e6:	85 c9                	test   %ecx,%ecx
801038e8:	0f 8e 8a 00 00 00    	jle    80103978 <install_trans+0x98>
801038ee:	55                   	push   %ebp
801038ef:	89 e5                	mov    %esp,%ebp
801038f1:	57                   	push   %edi
801038f2:	31 ff                	xor    %edi,%edi
801038f4:	56                   	push   %esi
801038f5:	53                   	push   %ebx
801038f6:	83 ec 0c             	sub    $0xc,%esp
801038f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103900:	a1 14 2d 11 80       	mov    0x80112d14,%eax
80103905:	83 ec 08             	sub    $0x8,%esp
80103908:	01 f8                	add    %edi,%eax
8010390a:	83 c0 01             	add    $0x1,%eax
8010390d:	50                   	push   %eax
8010390e:	ff 35 24 2d 11 80    	push   0x80112d24
80103914:	e8 b7 c7 ff ff       	call   801000d0 <bread>
80103919:	89 c6                	mov    %eax,%esi
8010391b:	58                   	pop    %eax
8010391c:	5a                   	pop    %edx
8010391d:	ff 34 bd 2c 2d 11 80 	push   -0x7feed2d4(,%edi,4)
80103924:	ff 35 24 2d 11 80    	push   0x80112d24
8010392a:	83 c7 01             	add    $0x1,%edi
8010392d:	e8 9e c7 ff ff       	call   801000d0 <bread>
80103932:	83 c4 0c             	add    $0xc,%esp
80103935:	89 c3                	mov    %eax,%ebx
80103937:	8d 46 5c             	lea    0x5c(%esi),%eax
8010393a:	68 00 02 00 00       	push   $0x200
8010393f:	50                   	push   %eax
80103940:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103943:	50                   	push   %eax
80103944:	e8 d7 1a 00 00       	call   80105420 <memmove>
80103949:	89 1c 24             	mov    %ebx,(%esp)
8010394c:	e8 5f c8 ff ff       	call   801001b0 <bwrite>
80103951:	89 34 24             	mov    %esi,(%esp)
80103954:	e8 97 c8 ff ff       	call   801001f0 <brelse>
80103959:	89 1c 24             	mov    %ebx,(%esp)
8010395c:	e8 8f c8 ff ff       	call   801001f0 <brelse>
80103961:	83 c4 10             	add    $0x10,%esp
80103964:	39 3d 28 2d 11 80    	cmp    %edi,0x80112d28
8010396a:	7f 94                	jg     80103900 <install_trans+0x20>
8010396c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010396f:	5b                   	pop    %ebx
80103970:	5e                   	pop    %esi
80103971:	5f                   	pop    %edi
80103972:	5d                   	pop    %ebp
80103973:	c3                   	ret    
80103974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103978:	c3                   	ret    
80103979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103980 <write_head>:
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 0c             	sub    $0xc,%esp
80103987:	ff 35 14 2d 11 80    	push   0x80112d14
8010398d:	ff 35 24 2d 11 80    	push   0x80112d24
80103993:	e8 38 c7 ff ff       	call   801000d0 <bread>
80103998:	83 c4 10             	add    $0x10,%esp
8010399b:	89 c3                	mov    %eax,%ebx
8010399d:	a1 28 2d 11 80       	mov    0x80112d28,%eax
801039a2:	89 43 5c             	mov    %eax,0x5c(%ebx)
801039a5:	85 c0                	test   %eax,%eax
801039a7:	7e 19                	jle    801039c2 <write_head+0x42>
801039a9:	31 d2                	xor    %edx,%edx
801039ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039af:	90                   	nop
801039b0:	8b 0c 95 2c 2d 11 80 	mov    -0x7feed2d4(,%edx,4),%ecx
801039b7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
801039bb:	83 c2 01             	add    $0x1,%edx
801039be:	39 d0                	cmp    %edx,%eax
801039c0:	75 ee                	jne    801039b0 <write_head+0x30>
801039c2:	83 ec 0c             	sub    $0xc,%esp
801039c5:	53                   	push   %ebx
801039c6:	e8 e5 c7 ff ff       	call   801001b0 <bwrite>
801039cb:	89 1c 24             	mov    %ebx,(%esp)
801039ce:	e8 1d c8 ff ff       	call   801001f0 <brelse>
801039d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039d6:	83 c4 10             	add    $0x10,%esp
801039d9:	c9                   	leave  
801039da:	c3                   	ret    
801039db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039df:	90                   	nop

801039e0 <initlog>:
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	53                   	push   %ebx
801039e4:	83 ec 2c             	sub    $0x2c,%esp
801039e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039ea:	68 a0 83 10 80       	push   $0x801083a0
801039ef:	68 e0 2c 11 80       	push   $0x80112ce0
801039f4:	e8 f7 16 00 00       	call   801050f0 <initlock>
801039f9:	58                   	pop    %eax
801039fa:	8d 45 dc             	lea    -0x24(%ebp),%eax
801039fd:	5a                   	pop    %edx
801039fe:	50                   	push   %eax
801039ff:	53                   	push   %ebx
80103a00:	e8 3b e8 ff ff       	call   80102240 <readsb>
80103a05:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103a08:	59                   	pop    %ecx
80103a09:	89 1d 24 2d 11 80    	mov    %ebx,0x80112d24
80103a0f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103a12:	a3 14 2d 11 80       	mov    %eax,0x80112d14
80103a17:	89 15 18 2d 11 80    	mov    %edx,0x80112d18
80103a1d:	5a                   	pop    %edx
80103a1e:	50                   	push   %eax
80103a1f:	53                   	push   %ebx
80103a20:	e8 ab c6 ff ff       	call   801000d0 <bread>
80103a25:	83 c4 10             	add    $0x10,%esp
80103a28:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103a2b:	89 1d 28 2d 11 80    	mov    %ebx,0x80112d28
80103a31:	85 db                	test   %ebx,%ebx
80103a33:	7e 1d                	jle    80103a52 <initlog+0x72>
80103a35:	31 d2                	xor    %edx,%edx
80103a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a3e:	66 90                	xchg   %ax,%ax
80103a40:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a44:	89 0c 95 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%edx,4)
80103a4b:	83 c2 01             	add    $0x1,%edx
80103a4e:	39 d3                	cmp    %edx,%ebx
80103a50:	75 ee                	jne    80103a40 <initlog+0x60>
80103a52:	83 ec 0c             	sub    $0xc,%esp
80103a55:	50                   	push   %eax
80103a56:	e8 95 c7 ff ff       	call   801001f0 <brelse>
80103a5b:	e8 80 fe ff ff       	call   801038e0 <install_trans>
80103a60:	c7 05 28 2d 11 80 00 	movl   $0x0,0x80112d28
80103a67:	00 00 00 
80103a6a:	e8 11 ff ff ff       	call   80103980 <write_head>
80103a6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a72:	83 c4 10             	add    $0x10,%esp
80103a75:	c9                   	leave  
80103a76:	c3                   	ret    
80103a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a7e:	66 90                	xchg   %ax,%ax

80103a80 <begin_op>:
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	83 ec 14             	sub    $0x14,%esp
80103a86:	68 e0 2c 11 80       	push   $0x80112ce0
80103a8b:	e8 30 18 00 00       	call   801052c0 <acquire>
80103a90:	83 c4 10             	add    $0x10,%esp
80103a93:	eb 18                	jmp    80103aad <begin_op+0x2d>
80103a95:	8d 76 00             	lea    0x0(%esi),%esi
80103a98:	83 ec 08             	sub    $0x8,%esp
80103a9b:	68 e0 2c 11 80       	push   $0x80112ce0
80103aa0:	68 e0 2c 11 80       	push   $0x80112ce0
80103aa5:	e8 b6 12 00 00       	call   80104d60 <sleep>
80103aaa:	83 c4 10             	add    $0x10,%esp
80103aad:	a1 20 2d 11 80       	mov    0x80112d20,%eax
80103ab2:	85 c0                	test   %eax,%eax
80103ab4:	75 e2                	jne    80103a98 <begin_op+0x18>
80103ab6:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
80103abb:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
80103ac1:	83 c0 01             	add    $0x1,%eax
80103ac4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103ac7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103aca:	83 fa 1e             	cmp    $0x1e,%edx
80103acd:	7f c9                	jg     80103a98 <begin_op+0x18>
80103acf:	83 ec 0c             	sub    $0xc,%esp
80103ad2:	a3 1c 2d 11 80       	mov    %eax,0x80112d1c
80103ad7:	68 e0 2c 11 80       	push   $0x80112ce0
80103adc:	e8 7f 17 00 00       	call   80105260 <release>
80103ae1:	83 c4 10             	add    $0x10,%esp
80103ae4:	c9                   	leave  
80103ae5:	c3                   	ret    
80103ae6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aed:	8d 76 00             	lea    0x0(%esi),%esi

80103af0 <end_op>:
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	57                   	push   %edi
80103af4:	56                   	push   %esi
80103af5:	53                   	push   %ebx
80103af6:	83 ec 18             	sub    $0x18,%esp
80103af9:	68 e0 2c 11 80       	push   $0x80112ce0
80103afe:	e8 bd 17 00 00       	call   801052c0 <acquire>
80103b03:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
80103b08:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
80103b0e:	83 c4 10             	add    $0x10,%esp
80103b11:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103b14:	89 1d 1c 2d 11 80    	mov    %ebx,0x80112d1c
80103b1a:	85 f6                	test   %esi,%esi
80103b1c:	0f 85 22 01 00 00    	jne    80103c44 <end_op+0x154>
80103b22:	85 db                	test   %ebx,%ebx
80103b24:	0f 85 f6 00 00 00    	jne    80103c20 <end_op+0x130>
80103b2a:	c7 05 20 2d 11 80 01 	movl   $0x1,0x80112d20
80103b31:	00 00 00 
80103b34:	83 ec 0c             	sub    $0xc,%esp
80103b37:	68 e0 2c 11 80       	push   $0x80112ce0
80103b3c:	e8 1f 17 00 00       	call   80105260 <release>
80103b41:	8b 0d 28 2d 11 80    	mov    0x80112d28,%ecx
80103b47:	83 c4 10             	add    $0x10,%esp
80103b4a:	85 c9                	test   %ecx,%ecx
80103b4c:	7f 42                	jg     80103b90 <end_op+0xa0>
80103b4e:	83 ec 0c             	sub    $0xc,%esp
80103b51:	68 e0 2c 11 80       	push   $0x80112ce0
80103b56:	e8 65 17 00 00       	call   801052c0 <acquire>
80103b5b:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103b62:	c7 05 20 2d 11 80 00 	movl   $0x0,0x80112d20
80103b69:	00 00 00 
80103b6c:	e8 af 12 00 00       	call   80104e20 <wakeup>
80103b71:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103b78:	e8 e3 16 00 00       	call   80105260 <release>
80103b7d:	83 c4 10             	add    $0x10,%esp
80103b80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b83:	5b                   	pop    %ebx
80103b84:	5e                   	pop    %esi
80103b85:	5f                   	pop    %edi
80103b86:	5d                   	pop    %ebp
80103b87:	c3                   	ret    
80103b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b8f:	90                   	nop
80103b90:	a1 14 2d 11 80       	mov    0x80112d14,%eax
80103b95:	83 ec 08             	sub    $0x8,%esp
80103b98:	01 d8                	add    %ebx,%eax
80103b9a:	83 c0 01             	add    $0x1,%eax
80103b9d:	50                   	push   %eax
80103b9e:	ff 35 24 2d 11 80    	push   0x80112d24
80103ba4:	e8 27 c5 ff ff       	call   801000d0 <bread>
80103ba9:	89 c6                	mov    %eax,%esi
80103bab:	58                   	pop    %eax
80103bac:	5a                   	pop    %edx
80103bad:	ff 34 9d 2c 2d 11 80 	push   -0x7feed2d4(,%ebx,4)
80103bb4:	ff 35 24 2d 11 80    	push   0x80112d24
80103bba:	83 c3 01             	add    $0x1,%ebx
80103bbd:	e8 0e c5 ff ff       	call   801000d0 <bread>
80103bc2:	83 c4 0c             	add    $0xc,%esp
80103bc5:	89 c7                	mov    %eax,%edi
80103bc7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103bca:	68 00 02 00 00       	push   $0x200
80103bcf:	50                   	push   %eax
80103bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80103bd3:	50                   	push   %eax
80103bd4:	e8 47 18 00 00       	call   80105420 <memmove>
80103bd9:	89 34 24             	mov    %esi,(%esp)
80103bdc:	e8 cf c5 ff ff       	call   801001b0 <bwrite>
80103be1:	89 3c 24             	mov    %edi,(%esp)
80103be4:	e8 07 c6 ff ff       	call   801001f0 <brelse>
80103be9:	89 34 24             	mov    %esi,(%esp)
80103bec:	e8 ff c5 ff ff       	call   801001f0 <brelse>
80103bf1:	83 c4 10             	add    $0x10,%esp
80103bf4:	3b 1d 28 2d 11 80    	cmp    0x80112d28,%ebx
80103bfa:	7c 94                	jl     80103b90 <end_op+0xa0>
80103bfc:	e8 7f fd ff ff       	call   80103980 <write_head>
80103c01:	e8 da fc ff ff       	call   801038e0 <install_trans>
80103c06:	c7 05 28 2d 11 80 00 	movl   $0x0,0x80112d28
80103c0d:	00 00 00 
80103c10:	e8 6b fd ff ff       	call   80103980 <write_head>
80103c15:	e9 34 ff ff ff       	jmp    80103b4e <end_op+0x5e>
80103c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	68 e0 2c 11 80       	push   $0x80112ce0
80103c28:	e8 f3 11 00 00       	call   80104e20 <wakeup>
80103c2d:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103c34:	e8 27 16 00 00       	call   80105260 <release>
80103c39:	83 c4 10             	add    $0x10,%esp
80103c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c3f:	5b                   	pop    %ebx
80103c40:	5e                   	pop    %esi
80103c41:	5f                   	pop    %edi
80103c42:	5d                   	pop    %ebp
80103c43:	c3                   	ret    
80103c44:	83 ec 0c             	sub    $0xc,%esp
80103c47:	68 a4 83 10 80       	push   $0x801083a4
80103c4c:	e8 9f c8 ff ff       	call   801004f0 <panic>
80103c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c5f:	90                   	nop

80103c60 <log_write>:
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	53                   	push   %ebx
80103c64:	83 ec 04             	sub    $0x4,%esp
80103c67:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
80103c6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103c70:	83 fa 1d             	cmp    $0x1d,%edx
80103c73:	0f 8f 85 00 00 00    	jg     80103cfe <log_write+0x9e>
80103c79:	a1 18 2d 11 80       	mov    0x80112d18,%eax
80103c7e:	83 e8 01             	sub    $0x1,%eax
80103c81:	39 c2                	cmp    %eax,%edx
80103c83:	7d 79                	jge    80103cfe <log_write+0x9e>
80103c85:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
80103c8a:	85 c0                	test   %eax,%eax
80103c8c:	7e 7d                	jle    80103d0b <log_write+0xab>
80103c8e:	83 ec 0c             	sub    $0xc,%esp
80103c91:	68 e0 2c 11 80       	push   $0x80112ce0
80103c96:	e8 25 16 00 00       	call   801052c0 <acquire>
80103c9b:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
80103ca1:	83 c4 10             	add    $0x10,%esp
80103ca4:	85 d2                	test   %edx,%edx
80103ca6:	7e 4a                	jle    80103cf2 <log_write+0x92>
80103ca8:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103cab:	31 c0                	xor    %eax,%eax
80103cad:	eb 08                	jmp    80103cb7 <log_write+0x57>
80103caf:	90                   	nop
80103cb0:	83 c0 01             	add    $0x1,%eax
80103cb3:	39 c2                	cmp    %eax,%edx
80103cb5:	74 29                	je     80103ce0 <log_write+0x80>
80103cb7:	39 0c 85 2c 2d 11 80 	cmp    %ecx,-0x7feed2d4(,%eax,4)
80103cbe:	75 f0                	jne    80103cb0 <log_write+0x50>
80103cc0:	89 0c 85 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%eax,4)
80103cc7:	83 0b 04             	orl    $0x4,(%ebx)
80103cca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ccd:	c7 45 08 e0 2c 11 80 	movl   $0x80112ce0,0x8(%ebp)
80103cd4:	c9                   	leave  
80103cd5:	e9 86 15 00 00       	jmp    80105260 <release>
80103cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ce0:	89 0c 95 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%edx,4)
80103ce7:	83 c2 01             	add    $0x1,%edx
80103cea:	89 15 28 2d 11 80    	mov    %edx,0x80112d28
80103cf0:	eb d5                	jmp    80103cc7 <log_write+0x67>
80103cf2:	8b 43 08             	mov    0x8(%ebx),%eax
80103cf5:	a3 2c 2d 11 80       	mov    %eax,0x80112d2c
80103cfa:	75 cb                	jne    80103cc7 <log_write+0x67>
80103cfc:	eb e9                	jmp    80103ce7 <log_write+0x87>
80103cfe:	83 ec 0c             	sub    $0xc,%esp
80103d01:	68 b3 83 10 80       	push   $0x801083b3
80103d06:	e8 e5 c7 ff ff       	call   801004f0 <panic>
80103d0b:	83 ec 0c             	sub    $0xc,%esp
80103d0e:	68 c9 83 10 80       	push   $0x801083c9
80103d13:	e8 d8 c7 ff ff       	call   801004f0 <panic>
80103d18:	66 90                	xchg   %ax,%ax
80103d1a:	66 90                	xchg   %ax,%ax
80103d1c:	66 90                	xchg   %ax,%ax
80103d1e:	66 90                	xchg   %ax,%ax

80103d20 <mpmain>:
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	53                   	push   %ebx
80103d24:	83 ec 04             	sub    $0x4,%esp
80103d27:	e8 44 09 00 00       	call   80104670 <cpuid>
80103d2c:	89 c3                	mov    %eax,%ebx
80103d2e:	e8 3d 09 00 00       	call   80104670 <cpuid>
80103d33:	83 ec 04             	sub    $0x4,%esp
80103d36:	53                   	push   %ebx
80103d37:	50                   	push   %eax
80103d38:	68 e4 83 10 80       	push   $0x801083e4
80103d3d:	e8 2e cd ff ff       	call   80100a70 <cprintf>
80103d42:	e8 b9 28 00 00       	call   80106600 <idtinit>
80103d47:	e8 c4 08 00 00       	call   80104610 <mycpu>
80103d4c:	89 c2                	mov    %eax,%edx
80103d4e:	b8 01 00 00 00       	mov    $0x1,%eax
80103d53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80103d5a:	e8 f1 0b 00 00       	call   80104950 <scheduler>
80103d5f:	90                   	nop

80103d60 <mpenter>:
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	83 ec 08             	sub    $0x8,%esp
80103d66:	e8 85 39 00 00       	call   801076f0 <switchkvm>
80103d6b:	e8 f0 38 00 00       	call   80107660 <seginit>
80103d70:	e8 9b f7 ff ff       	call   80103510 <lapicinit>
80103d75:	e8 a6 ff ff ff       	call   80103d20 <mpmain>
80103d7a:	66 90                	xchg   %ax,%ax
80103d7c:	66 90                	xchg   %ax,%ax
80103d7e:	66 90                	xchg   %ax,%ax

80103d80 <main>:
80103d80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103d84:	83 e4 f0             	and    $0xfffffff0,%esp
80103d87:	ff 71 fc             	push   -0x4(%ecx)
80103d8a:	55                   	push   %ebp
80103d8b:	89 e5                	mov    %esp,%ebp
80103d8d:	53                   	push   %ebx
80103d8e:	51                   	push   %ecx
80103d8f:	83 ec 08             	sub    $0x8,%esp
80103d92:	68 00 00 40 80       	push   $0x80400000
80103d97:	68 10 6b 11 80       	push   $0x80116b10
80103d9c:	e8 8f f5 ff ff       	call   80103330 <kinit1>
80103da1:	e8 3a 3e 00 00       	call   80107be0 <kvmalloc>
80103da6:	e8 85 01 00 00       	call   80103f30 <mpinit>
80103dab:	e8 60 f7 ff ff       	call   80103510 <lapicinit>
80103db0:	e8 ab 38 00 00       	call   80107660 <seginit>
80103db5:	e8 76 03 00 00       	call   80104130 <picinit>
80103dba:	e8 31 f3 ff ff       	call   801030f0 <ioapicinit>
80103dbf:	e8 bc d9 ff ff       	call   80101780 <consoleinit>
80103dc4:	e8 27 2b 00 00       	call   801068f0 <uartinit>
80103dc9:	e8 22 08 00 00       	call   801045f0 <pinit>
80103dce:	e8 ad 27 00 00       	call   80106580 <tvinit>
80103dd3:	e8 68 c2 ff ff       	call   80100040 <binit>
80103dd8:	e8 53 dd ff ff       	call   80101b30 <fileinit>
80103ddd:	e8 fe f0 ff ff       	call   80102ee0 <ideinit>
80103de2:	83 c4 0c             	add    $0xc,%esp
80103de5:	68 8a 00 00 00       	push   $0x8a
80103dea:	68 8c b4 10 80       	push   $0x8010b48c
80103def:	68 00 70 00 80       	push   $0x80007000
80103df4:	e8 27 16 00 00       	call   80105420 <memmove>
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	69 05 c4 2d 11 80 b0 	imul   $0xb0,0x80112dc4,%eax
80103e03:	00 00 00 
80103e06:	05 e0 2d 11 80       	add    $0x80112de0,%eax
80103e0b:	3d e0 2d 11 80       	cmp    $0x80112de0,%eax
80103e10:	76 7e                	jbe    80103e90 <main+0x110>
80103e12:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80103e17:	eb 20                	jmp    80103e39 <main+0xb9>
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e20:	69 05 c4 2d 11 80 b0 	imul   $0xb0,0x80112dc4,%eax
80103e27:	00 00 00 
80103e2a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103e30:	05 e0 2d 11 80       	add    $0x80112de0,%eax
80103e35:	39 c3                	cmp    %eax,%ebx
80103e37:	73 57                	jae    80103e90 <main+0x110>
80103e39:	e8 d2 07 00 00       	call   80104610 <mycpu>
80103e3e:	39 c3                	cmp    %eax,%ebx
80103e40:	74 de                	je     80103e20 <main+0xa0>
80103e42:	e8 59 f5 ff ff       	call   801033a0 <kalloc>
80103e47:	83 ec 08             	sub    $0x8,%esp
80103e4a:	c7 05 f8 6f 00 80 60 	movl   $0x80103d60,0x80006ff8
80103e51:	3d 10 80 
80103e54:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103e5b:	a0 10 00 
80103e5e:	05 00 10 00 00       	add    $0x1000,%eax
80103e63:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80103e68:	0f b6 03             	movzbl (%ebx),%eax
80103e6b:	68 00 70 00 00       	push   $0x7000
80103e70:	50                   	push   %eax
80103e71:	e8 ea f7 ff ff       	call   80103660 <lapicstartap>
80103e76:	83 c4 10             	add    $0x10,%esp
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e80:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103e86:	85 c0                	test   %eax,%eax
80103e88:	74 f6                	je     80103e80 <main+0x100>
80103e8a:	eb 94                	jmp    80103e20 <main+0xa0>
80103e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e90:	83 ec 08             	sub    $0x8,%esp
80103e93:	68 00 00 00 8e       	push   $0x8e000000
80103e98:	68 00 00 40 80       	push   $0x80400000
80103e9d:	e8 2e f4 ff ff       	call   801032d0 <kinit2>
80103ea2:	e8 19 08 00 00       	call   801046c0 <userinit>
80103ea7:	e8 74 fe ff ff       	call   80103d20 <mpmain>
80103eac:	66 90                	xchg   %ax,%ax
80103eae:	66 90                	xchg   %ax,%ax

80103eb0 <mpsearch1>:
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	57                   	push   %edi
80103eb4:	56                   	push   %esi
80103eb5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80103ebb:	53                   	push   %ebx
80103ebc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
80103ebf:	83 ec 0c             	sub    $0xc,%esp
80103ec2:	39 de                	cmp    %ebx,%esi
80103ec4:	72 10                	jb     80103ed6 <mpsearch1+0x26>
80103ec6:	eb 50                	jmp    80103f18 <mpsearch1+0x68>
80103ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ecf:	90                   	nop
80103ed0:	89 fe                	mov    %edi,%esi
80103ed2:	39 fb                	cmp    %edi,%ebx
80103ed4:	76 42                	jbe    80103f18 <mpsearch1+0x68>
80103ed6:	83 ec 04             	sub    $0x4,%esp
80103ed9:	8d 7e 10             	lea    0x10(%esi),%edi
80103edc:	6a 04                	push   $0x4
80103ede:	68 f8 83 10 80       	push   $0x801083f8
80103ee3:	56                   	push   %esi
80103ee4:	e8 e7 14 00 00       	call   801053d0 <memcmp>
80103ee9:	83 c4 10             	add    $0x10,%esp
80103eec:	85 c0                	test   %eax,%eax
80103eee:	75 e0                	jne    80103ed0 <mpsearch1+0x20>
80103ef0:	89 f2                	mov    %esi,%edx
80103ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ef8:	0f b6 0a             	movzbl (%edx),%ecx
80103efb:	83 c2 01             	add    $0x1,%edx
80103efe:	01 c8                	add    %ecx,%eax
80103f00:	39 fa                	cmp    %edi,%edx
80103f02:	75 f4                	jne    80103ef8 <mpsearch1+0x48>
80103f04:	84 c0                	test   %al,%al
80103f06:	75 c8                	jne    80103ed0 <mpsearch1+0x20>
80103f08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f0b:	89 f0                	mov    %esi,%eax
80103f0d:	5b                   	pop    %ebx
80103f0e:	5e                   	pop    %esi
80103f0f:	5f                   	pop    %edi
80103f10:	5d                   	pop    %ebp
80103f11:	c3                   	ret    
80103f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f1b:	31 f6                	xor    %esi,%esi
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
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	57                   	push   %edi
80103f34:	56                   	push   %esi
80103f35:	53                   	push   %ebx
80103f36:	83 ec 1c             	sub    $0x1c,%esp
80103f39:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103f40:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103f47:	c1 e0 08             	shl    $0x8,%eax
80103f4a:	09 d0                	or     %edx,%eax
80103f4c:	c1 e0 04             	shl    $0x4,%eax
80103f4f:	75 1b                	jne    80103f6c <mpinit+0x3c>
80103f51:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f58:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f5f:	c1 e0 08             	shl    $0x8,%eax
80103f62:	09 d0                	or     %edx,%eax
80103f64:	c1 e0 0a             	shl    $0xa,%eax
80103f67:	2d 00 04 00 00       	sub    $0x400,%eax
80103f6c:	ba 00 04 00 00       	mov    $0x400,%edx
80103f71:	e8 3a ff ff ff       	call   80103eb0 <mpsearch1>
80103f76:	89 c3                	mov    %eax,%ebx
80103f78:	85 c0                	test   %eax,%eax
80103f7a:	0f 84 40 01 00 00    	je     801040c0 <mpinit+0x190>
80103f80:	8b 73 04             	mov    0x4(%ebx),%esi
80103f83:	85 f6                	test   %esi,%esi
80103f85:	0f 84 25 01 00 00    	je     801040b0 <mpinit+0x180>
80103f8b:	83 ec 04             	sub    $0x4,%esp
80103f8e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103f94:	6a 04                	push   $0x4
80103f96:	68 fd 83 10 80       	push   $0x801083fd
80103f9b:	50                   	push   %eax
80103f9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103f9f:	e8 2c 14 00 00       	call   801053d0 <memcmp>
80103fa4:	83 c4 10             	add    $0x10,%esp
80103fa7:	85 c0                	test   %eax,%eax
80103fa9:	0f 85 01 01 00 00    	jne    801040b0 <mpinit+0x180>
80103faf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103fb6:	3c 01                	cmp    $0x1,%al
80103fb8:	74 08                	je     80103fc2 <mpinit+0x92>
80103fba:	3c 04                	cmp    $0x4,%al
80103fbc:	0f 85 ee 00 00 00    	jne    801040b0 <mpinit+0x180>
80103fc2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103fc9:	66 85 d2             	test   %dx,%dx
80103fcc:	74 22                	je     80103ff0 <mpinit+0xc0>
80103fce:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103fd1:	89 f0                	mov    %esi,%eax
80103fd3:	31 d2                	xor    %edx,%edx
80103fd5:	8d 76 00             	lea    0x0(%esi),%esi
80103fd8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103fdf:	83 c0 01             	add    $0x1,%eax
80103fe2:	01 ca                	add    %ecx,%edx
80103fe4:	39 c7                	cmp    %eax,%edi
80103fe6:	75 f0                	jne    80103fd8 <mpinit+0xa8>
80103fe8:	84 d2                	test   %dl,%dl
80103fea:	0f 85 c0 00 00 00    	jne    801040b0 <mpinit+0x180>
80103ff0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103ff6:	a3 c0 2c 11 80       	mov    %eax,0x80112cc0
80103ffb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80104002:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80104008:	be 01 00 00 00       	mov    $0x1,%esi
8010400d:	03 55 e4             	add    -0x1c(%ebp),%edx
80104010:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80104013:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104017:	90                   	nop
80104018:	39 d0                	cmp    %edx,%eax
8010401a:	73 15                	jae    80104031 <mpinit+0x101>
8010401c:	0f b6 08             	movzbl (%eax),%ecx
8010401f:	80 f9 02             	cmp    $0x2,%cl
80104022:	74 4c                	je     80104070 <mpinit+0x140>
80104024:	77 3a                	ja     80104060 <mpinit+0x130>
80104026:	84 c9                	test   %cl,%cl
80104028:	74 56                	je     80104080 <mpinit+0x150>
8010402a:	83 c0 08             	add    $0x8,%eax
8010402d:	39 d0                	cmp    %edx,%eax
8010402f:	72 eb                	jb     8010401c <mpinit+0xec>
80104031:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104034:	85 f6                	test   %esi,%esi
80104036:	0f 84 d9 00 00 00    	je     80104115 <mpinit+0x1e5>
8010403c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104040:	74 15                	je     80104057 <mpinit+0x127>
80104042:	b8 70 00 00 00       	mov    $0x70,%eax
80104047:	ba 22 00 00 00       	mov    $0x22,%edx
8010404c:	ee                   	out    %al,(%dx)
8010404d:	ba 23 00 00 00       	mov    $0x23,%edx
80104052:	ec                   	in     (%dx),%al
80104053:	83 c8 01             	or     $0x1,%eax
80104056:	ee                   	out    %al,(%dx)
80104057:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010405a:	5b                   	pop    %ebx
8010405b:	5e                   	pop    %esi
8010405c:	5f                   	pop    %edi
8010405d:	5d                   	pop    %ebp
8010405e:	c3                   	ret    
8010405f:	90                   	nop
80104060:	83 e9 03             	sub    $0x3,%ecx
80104063:	80 f9 01             	cmp    $0x1,%cl
80104066:	76 c2                	jbe    8010402a <mpinit+0xfa>
80104068:	31 f6                	xor    %esi,%esi
8010406a:	eb ac                	jmp    80104018 <mpinit+0xe8>
8010406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104070:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80104074:	83 c0 08             	add    $0x8,%eax
80104077:	88 0d c0 2d 11 80    	mov    %cl,0x80112dc0
8010407d:	eb 99                	jmp    80104018 <mpinit+0xe8>
8010407f:	90                   	nop
80104080:	8b 0d c4 2d 11 80    	mov    0x80112dc4,%ecx
80104086:	83 f9 07             	cmp    $0x7,%ecx
80104089:	7f 19                	jg     801040a4 <mpinit+0x174>
8010408b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80104091:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80104095:	83 c1 01             	add    $0x1,%ecx
80104098:	89 0d c4 2d 11 80    	mov    %ecx,0x80112dc4
8010409e:	88 9f e0 2d 11 80    	mov    %bl,-0x7feed220(%edi)
801040a4:	83 c0 14             	add    $0x14,%eax
801040a7:	e9 6c ff ff ff       	jmp    80104018 <mpinit+0xe8>
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	68 02 84 10 80       	push   $0x80108402
801040b8:	e8 33 c4 ff ff       	call   801004f0 <panic>
801040bd:	8d 76 00             	lea    0x0(%esi),%esi
801040c0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801040c5:	eb 13                	jmp    801040da <mpinit+0x1aa>
801040c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ce:	66 90                	xchg   %ax,%ax
801040d0:	89 f3                	mov    %esi,%ebx
801040d2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801040d8:	74 d6                	je     801040b0 <mpinit+0x180>
801040da:	83 ec 04             	sub    $0x4,%esp
801040dd:	8d 73 10             	lea    0x10(%ebx),%esi
801040e0:	6a 04                	push   $0x4
801040e2:	68 f8 83 10 80       	push   $0x801083f8
801040e7:	53                   	push   %ebx
801040e8:	e8 e3 12 00 00       	call   801053d0 <memcmp>
801040ed:	83 c4 10             	add    $0x10,%esp
801040f0:	85 c0                	test   %eax,%eax
801040f2:	75 dc                	jne    801040d0 <mpinit+0x1a0>
801040f4:	89 da                	mov    %ebx,%edx
801040f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040fd:	8d 76 00             	lea    0x0(%esi),%esi
80104100:	0f b6 0a             	movzbl (%edx),%ecx
80104103:	83 c2 01             	add    $0x1,%edx
80104106:	01 c8                	add    %ecx,%eax
80104108:	39 d6                	cmp    %edx,%esi
8010410a:	75 f4                	jne    80104100 <mpinit+0x1d0>
8010410c:	84 c0                	test   %al,%al
8010410e:	75 c0                	jne    801040d0 <mpinit+0x1a0>
80104110:	e9 6b fe ff ff       	jmp    80103f80 <mpinit+0x50>
80104115:	83 ec 0c             	sub    $0xc,%esp
80104118:	68 1c 84 10 80       	push   $0x8010841c
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
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 0c             	sub    $0xc,%esp
80104159:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010415c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010415f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104165:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010416b:	e8 e0 d9 ff ff       	call   80101b50 <filealloc>
80104170:	89 03                	mov    %eax,(%ebx)
80104172:	85 c0                	test   %eax,%eax
80104174:	0f 84 a8 00 00 00    	je     80104222 <pipealloc+0xd2>
8010417a:	e8 d1 d9 ff ff       	call   80101b50 <filealloc>
8010417f:	89 06                	mov    %eax,(%esi)
80104181:	85 c0                	test   %eax,%eax
80104183:	0f 84 87 00 00 00    	je     80104210 <pipealloc+0xc0>
80104189:	e8 12 f2 ff ff       	call   801033a0 <kalloc>
8010418e:	89 c7                	mov    %eax,%edi
80104190:	85 c0                	test   %eax,%eax
80104192:	0f 84 b0 00 00 00    	je     80104248 <pipealloc+0xf8>
80104198:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010419f:	00 00 00 
801041a2:	83 ec 08             	sub    $0x8,%esp
801041a5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801041ac:	00 00 00 
801041af:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801041b6:	00 00 00 
801041b9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801041c0:	00 00 00 
801041c3:	68 3b 84 10 80       	push   $0x8010843b
801041c8:	50                   	push   %eax
801041c9:	e8 22 0f 00 00       	call   801050f0 <initlock>
801041ce:	8b 03                	mov    (%ebx),%eax
801041d0:	83 c4 10             	add    $0x10,%esp
801041d3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801041d9:	8b 03                	mov    (%ebx),%eax
801041db:	c6 40 08 01          	movb   $0x1,0x8(%eax)
801041df:	8b 03                	mov    (%ebx),%eax
801041e1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
801041e5:	8b 03                	mov    (%ebx),%eax
801041e7:	89 78 0c             	mov    %edi,0xc(%eax)
801041ea:	8b 06                	mov    (%esi),%eax
801041ec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801041f2:	8b 06                	mov    (%esi),%eax
801041f4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
801041f8:	8b 06                	mov    (%esi),%eax
801041fa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
801041fe:	8b 06                	mov    (%esi),%eax
80104200:	89 78 0c             	mov    %edi,0xc(%eax)
80104203:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104206:	31 c0                	xor    %eax,%eax
80104208:	5b                   	pop    %ebx
80104209:	5e                   	pop    %esi
8010420a:	5f                   	pop    %edi
8010420b:	5d                   	pop    %ebp
8010420c:	c3                   	ret    
8010420d:	8d 76 00             	lea    0x0(%esi),%esi
80104210:	8b 03                	mov    (%ebx),%eax
80104212:	85 c0                	test   %eax,%eax
80104214:	74 1e                	je     80104234 <pipealloc+0xe4>
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	50                   	push   %eax
8010421a:	e8 f1 d9 ff ff       	call   80101c10 <fileclose>
8010421f:	83 c4 10             	add    $0x10,%esp
80104222:	8b 06                	mov    (%esi),%eax
80104224:	85 c0                	test   %eax,%eax
80104226:	74 0c                	je     80104234 <pipealloc+0xe4>
80104228:	83 ec 0c             	sub    $0xc,%esp
8010422b:	50                   	push   %eax
8010422c:	e8 df d9 ff ff       	call   80101c10 <fileclose>
80104231:	83 c4 10             	add    $0x10,%esp
80104234:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104237:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010423c:	5b                   	pop    %ebx
8010423d:	5e                   	pop    %esi
8010423e:	5f                   	pop    %edi
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104248:	8b 03                	mov    (%ebx),%eax
8010424a:	85 c0                	test   %eax,%eax
8010424c:	75 c8                	jne    80104216 <pipealloc+0xc6>
8010424e:	eb d2                	jmp    80104222 <pipealloc+0xd2>

80104250 <pipeclose>:
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
80104255:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104258:	8b 75 0c             	mov    0xc(%ebp),%esi
8010425b:	83 ec 0c             	sub    $0xc,%esp
8010425e:	53                   	push   %ebx
8010425f:	e8 5c 10 00 00       	call   801052c0 <acquire>
80104264:	83 c4 10             	add    $0x10,%esp
80104267:	85 f6                	test   %esi,%esi
80104269:	74 65                	je     801042d0 <pipeclose+0x80>
8010426b:	83 ec 0c             	sub    $0xc,%esp
8010426e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104274:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010427b:	00 00 00 
8010427e:	50                   	push   %eax
8010427f:	e8 9c 0b 00 00       	call   80104e20 <wakeup>
80104284:	83 c4 10             	add    $0x10,%esp
80104287:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010428d:	85 d2                	test   %edx,%edx
8010428f:	75 0a                	jne    8010429b <pipeclose+0x4b>
80104291:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104297:	85 c0                	test   %eax,%eax
80104299:	74 15                	je     801042b0 <pipeclose+0x60>
8010429b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010429e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042a1:	5b                   	pop    %ebx
801042a2:	5e                   	pop    %esi
801042a3:	5d                   	pop    %ebp
801042a4:	e9 b7 0f 00 00       	jmp    80105260 <release>
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042b0:	83 ec 0c             	sub    $0xc,%esp
801042b3:	53                   	push   %ebx
801042b4:	e8 a7 0f 00 00       	call   80105260 <release>
801042b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801042bc:	83 c4 10             	add    $0x10,%esp
801042bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c2:	5b                   	pop    %ebx
801042c3:	5e                   	pop    %esi
801042c4:	5d                   	pop    %ebp
801042c5:	e9 16 ef ff ff       	jmp    801031e0 <kfree>
801042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042d0:	83 ec 0c             	sub    $0xc,%esp
801042d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801042d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801042e0:	00 00 00 
801042e3:	50                   	push   %eax
801042e4:	e8 37 0b 00 00       	call   80104e20 <wakeup>
801042e9:	83 c4 10             	add    $0x10,%esp
801042ec:	eb 99                	jmp    80104287 <pipeclose+0x37>
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <pipewrite>:
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	83 ec 28             	sub    $0x28,%esp
801042f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042fc:	53                   	push   %ebx
801042fd:	e8 be 0f 00 00       	call   801052c0 <acquire>
80104302:	8b 45 10             	mov    0x10(%ebp),%eax
80104305:	83 c4 10             	add    $0x10,%esp
80104308:	85 c0                	test   %eax,%eax
8010430a:	0f 8e c0 00 00 00    	jle    801043d0 <pipewrite+0xe0>
80104310:	8b 45 0c             	mov    0xc(%ebp),%eax
80104313:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
80104319:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010431f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104322:	03 45 10             	add    0x10(%ebp),%eax
80104325:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104328:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010432e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80104334:	89 ca                	mov    %ecx,%edx
80104336:	05 00 02 00 00       	add    $0x200,%eax
8010433b:	39 c1                	cmp    %eax,%ecx
8010433d:	74 3f                	je     8010437e <pipewrite+0x8e>
8010433f:	eb 67                	jmp    801043a8 <pipewrite+0xb8>
80104341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104348:	e8 43 03 00 00       	call   80104690 <myproc>
8010434d:	8b 48 24             	mov    0x24(%eax),%ecx
80104350:	85 c9                	test   %ecx,%ecx
80104352:	75 34                	jne    80104388 <pipewrite+0x98>
80104354:	83 ec 0c             	sub    $0xc,%esp
80104357:	57                   	push   %edi
80104358:	e8 c3 0a 00 00       	call   80104e20 <wakeup>
8010435d:	58                   	pop    %eax
8010435e:	5a                   	pop    %edx
8010435f:	53                   	push   %ebx
80104360:	56                   	push   %esi
80104361:	e8 fa 09 00 00       	call   80104d60 <sleep>
80104366:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010436c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104372:	83 c4 10             	add    $0x10,%esp
80104375:	05 00 02 00 00       	add    $0x200,%eax
8010437a:	39 c2                	cmp    %eax,%edx
8010437c:	75 2a                	jne    801043a8 <pipewrite+0xb8>
8010437e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104384:	85 c0                	test   %eax,%eax
80104386:	75 c0                	jne    80104348 <pipewrite+0x58>
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	53                   	push   %ebx
8010438c:	e8 cf 0e 00 00       	call   80105260 <release>
80104391:	83 c4 10             	add    $0x10,%esp
80104394:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104399:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010439c:	5b                   	pop    %ebx
8010439d:	5e                   	pop    %esi
8010439e:	5f                   	pop    %edi
8010439f:	5d                   	pop    %ebp
801043a0:	c3                   	ret    
801043a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043a8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801043ab:	8d 4a 01             	lea    0x1(%edx),%ecx
801043ae:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801043b4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801043ba:	0f b6 06             	movzbl (%esi),%eax
801043bd:	83 c6 01             	add    $0x1,%esi
801043c0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801043c3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
801043c7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801043ca:	0f 85 58 ff ff ff    	jne    80104328 <pipewrite+0x38>
801043d0:	83 ec 0c             	sub    $0xc,%esp
801043d3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801043d9:	50                   	push   %eax
801043da:	e8 41 0a 00 00       	call   80104e20 <wakeup>
801043df:	89 1c 24             	mov    %ebx,(%esp)
801043e2:	e8 79 0e 00 00       	call   80105260 <release>
801043e7:	8b 45 10             	mov    0x10(%ebp),%eax
801043ea:	83 c4 10             	add    $0x10,%esp
801043ed:	eb aa                	jmp    80104399 <pipewrite+0xa9>
801043ef:	90                   	nop

801043f0 <piperead>:
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	57                   	push   %edi
801043f4:	56                   	push   %esi
801043f5:	53                   	push   %ebx
801043f6:	83 ec 18             	sub    $0x18,%esp
801043f9:	8b 75 08             	mov    0x8(%ebp),%esi
801043fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801043ff:	56                   	push   %esi
80104400:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104406:	e8 b5 0e 00 00       	call   801052c0 <acquire>
8010440b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104411:	83 c4 10             	add    $0x10,%esp
80104414:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010441a:	74 2f                	je     8010444b <piperead+0x5b>
8010441c:	eb 37                	jmp    80104455 <piperead+0x65>
8010441e:	66 90                	xchg   %ax,%ax
80104420:	e8 6b 02 00 00       	call   80104690 <myproc>
80104425:	8b 48 24             	mov    0x24(%eax),%ecx
80104428:	85 c9                	test   %ecx,%ecx
8010442a:	0f 85 80 00 00 00    	jne    801044b0 <piperead+0xc0>
80104430:	83 ec 08             	sub    $0x8,%esp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
80104435:	e8 26 09 00 00       	call   80104d60 <sleep>
8010443a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104440:	83 c4 10             	add    $0x10,%esp
80104443:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104449:	75 0a                	jne    80104455 <piperead+0x65>
8010444b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104451:	85 c0                	test   %eax,%eax
80104453:	75 cb                	jne    80104420 <piperead+0x30>
80104455:	8b 55 10             	mov    0x10(%ebp),%edx
80104458:	31 db                	xor    %ebx,%ebx
8010445a:	85 d2                	test   %edx,%edx
8010445c:	7f 20                	jg     8010447e <piperead+0x8e>
8010445e:	eb 2c                	jmp    8010448c <piperead+0x9c>
80104460:	8d 48 01             	lea    0x1(%eax),%ecx
80104463:	25 ff 01 00 00       	and    $0x1ff,%eax
80104468:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010446e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104473:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80104476:	83 c3 01             	add    $0x1,%ebx
80104479:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010447c:	74 0e                	je     8010448c <piperead+0x9c>
8010447e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104484:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010448a:	75 d4                	jne    80104460 <piperead+0x70>
8010448c:	83 ec 0c             	sub    $0xc,%esp
8010448f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104495:	50                   	push   %eax
80104496:	e8 85 09 00 00       	call   80104e20 <wakeup>
8010449b:	89 34 24             	mov    %esi,(%esp)
8010449e:	e8 bd 0d 00 00       	call   80105260 <release>
801044a3:	83 c4 10             	add    $0x10,%esp
801044a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044a9:	89 d8                	mov    %ebx,%eax
801044ab:	5b                   	pop    %ebx
801044ac:	5e                   	pop    %esi
801044ad:	5f                   	pop    %edi
801044ae:	5d                   	pop    %ebp
801044af:	c3                   	ret    
801044b0:	83 ec 0c             	sub    $0xc,%esp
801044b3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801044b8:	56                   	push   %esi
801044b9:	e8 a2 0d 00 00       	call   80105260 <release>
801044be:	83 c4 10             	add    $0x10,%esp
801044c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044c4:	89 d8                	mov    %ebx,%eax
801044c6:	5b                   	pop    %ebx
801044c7:	5e                   	pop    %esi
801044c8:	5f                   	pop    %edi
801044c9:	5d                   	pop    %ebp
801044ca:	c3                   	ret    
801044cb:	66 90                	xchg   %ax,%ax
801044cd:	66 90                	xchg   %ax,%ax
801044cf:	90                   	nop

801044d0 <allocproc>:
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	bb 94 33 11 80       	mov    $0x80113394,%ebx
801044d9:	83 ec 10             	sub    $0x10,%esp
801044dc:	68 60 33 11 80       	push   $0x80113360
801044e1:	e8 da 0d 00 00       	call   801052c0 <acquire>
801044e6:	83 c4 10             	add    $0x10,%esp
801044e9:	eb 10                	jmp    801044fb <allocproc+0x2b>
801044eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044ef:	90                   	nop
801044f0:	83 c3 7c             	add    $0x7c,%ebx
801044f3:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
801044f9:	74 75                	je     80104570 <allocproc+0xa0>
801044fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801044fe:	85 c0                	test   %eax,%eax
80104500:	75 ee                	jne    801044f0 <allocproc+0x20>
80104502:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104507:	83 ec 0c             	sub    $0xc,%esp
8010450a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80104511:	89 43 10             	mov    %eax,0x10(%ebx)
80104514:	8d 50 01             	lea    0x1(%eax),%edx
80104517:	68 60 33 11 80       	push   $0x80113360
8010451c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104522:	e8 39 0d 00 00       	call   80105260 <release>
80104527:	e8 74 ee ff ff       	call   801033a0 <kalloc>
8010452c:	83 c4 10             	add    $0x10,%esp
8010452f:	89 43 08             	mov    %eax,0x8(%ebx)
80104532:	85 c0                	test   %eax,%eax
80104534:	74 53                	je     80104589 <allocproc+0xb9>
80104536:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010453c:	83 ec 04             	sub    $0x4,%esp
8010453f:	05 9c 0f 00 00       	add    $0xf9c,%eax
80104544:	89 53 18             	mov    %edx,0x18(%ebx)
80104547:	c7 40 14 72 65 10 80 	movl   $0x80106572,0x14(%eax)
8010454e:	89 43 1c             	mov    %eax,0x1c(%ebx)
80104551:	6a 14                	push   $0x14
80104553:	6a 00                	push   $0x0
80104555:	50                   	push   %eax
80104556:	e8 25 0e 00 00       	call   80105380 <memset>
8010455b:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010455e:	83 c4 10             	add    $0x10,%esp
80104561:	c7 40 10 a0 45 10 80 	movl   $0x801045a0,0x10(%eax)
80104568:	89 d8                	mov    %ebx,%eax
8010456a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010456d:	c9                   	leave  
8010456e:	c3                   	ret    
8010456f:	90                   	nop
80104570:	83 ec 0c             	sub    $0xc,%esp
80104573:	31 db                	xor    %ebx,%ebx
80104575:	68 60 33 11 80       	push   $0x80113360
8010457a:	e8 e1 0c 00 00       	call   80105260 <release>
8010457f:	89 d8                	mov    %ebx,%eax
80104581:	83 c4 10             	add    $0x10,%esp
80104584:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104587:	c9                   	leave  
80104588:	c3                   	ret    
80104589:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104590:	31 db                	xor    %ebx,%ebx
80104592:	89 d8                	mov    %ebx,%eax
80104594:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104597:	c9                   	leave  
80104598:	c3                   	ret    
80104599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045a0 <forkret>:
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	83 ec 14             	sub    $0x14,%esp
801045a6:	68 60 33 11 80       	push   $0x80113360
801045ab:	e8 b0 0c 00 00       	call   80105260 <release>
801045b0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801045b5:	83 c4 10             	add    $0x10,%esp
801045b8:	85 c0                	test   %eax,%eax
801045ba:	75 04                	jne    801045c0 <forkret+0x20>
801045bc:	c9                   	leave  
801045bd:	c3                   	ret    
801045be:	66 90                	xchg   %ax,%ax
801045c0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801045c7:	00 00 00 
801045ca:	83 ec 0c             	sub    $0xc,%esp
801045cd:	6a 01                	push   $0x1
801045cf:	e8 ac dc ff ff       	call   80102280 <iinit>
801045d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801045db:	e8 00 f4 ff ff       	call   801039e0 <initlog>
801045e0:	83 c4 10             	add    $0x10,%esp
801045e3:	c9                   	leave  
801045e4:	c3                   	ret    
801045e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045f0 <pinit>:
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	83 ec 10             	sub    $0x10,%esp
801045f6:	68 40 84 10 80       	push   $0x80108440
801045fb:	68 60 33 11 80       	push   $0x80113360
80104600:	e8 eb 0a 00 00       	call   801050f0 <initlock>
80104605:	83 c4 10             	add    $0x10,%esp
80104608:	c9                   	leave  
80104609:	c3                   	ret    
8010460a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104610 <mycpu>:
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	56                   	push   %esi
80104614:	53                   	push   %ebx
80104615:	9c                   	pushf  
80104616:	58                   	pop    %eax
80104617:	f6 c4 02             	test   $0x2,%ah
8010461a:	75 46                	jne    80104662 <mycpu+0x52>
8010461c:	e8 ef ef ff ff       	call   80103610 <lapicid>
80104621:	8b 35 c4 2d 11 80    	mov    0x80112dc4,%esi
80104627:	85 f6                	test   %esi,%esi
80104629:	7e 2a                	jle    80104655 <mycpu+0x45>
8010462b:	31 d2                	xor    %edx,%edx
8010462d:	eb 08                	jmp    80104637 <mycpu+0x27>
8010462f:	90                   	nop
80104630:	83 c2 01             	add    $0x1,%edx
80104633:	39 f2                	cmp    %esi,%edx
80104635:	74 1e                	je     80104655 <mycpu+0x45>
80104637:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010463d:	0f b6 99 e0 2d 11 80 	movzbl -0x7feed220(%ecx),%ebx
80104644:	39 c3                	cmp    %eax,%ebx
80104646:	75 e8                	jne    80104630 <mycpu+0x20>
80104648:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010464b:	8d 81 e0 2d 11 80    	lea    -0x7feed220(%ecx),%eax
80104651:	5b                   	pop    %ebx
80104652:	5e                   	pop    %esi
80104653:	5d                   	pop    %ebp
80104654:	c3                   	ret    
80104655:	83 ec 0c             	sub    $0xc,%esp
80104658:	68 47 84 10 80       	push   $0x80108447
8010465d:	e8 8e be ff ff       	call   801004f0 <panic>
80104662:	83 ec 0c             	sub    $0xc,%esp
80104665:	68 24 85 10 80       	push   $0x80108524
8010466a:	e8 81 be ff ff       	call   801004f0 <panic>
8010466f:	90                   	nop

80104670 <cpuid>:
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	83 ec 08             	sub    $0x8,%esp
80104676:	e8 95 ff ff ff       	call   80104610 <mycpu>
8010467b:	c9                   	leave  
8010467c:	2d e0 2d 11 80       	sub    $0x80112de0,%eax
80104681:	c1 f8 04             	sar    $0x4,%eax
80104684:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
8010468a:	c3                   	ret    
8010468b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010468f:	90                   	nop

80104690 <myproc>:
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
80104697:	e8 d4 0a 00 00       	call   80105170 <pushcli>
8010469c:	e8 6f ff ff ff       	call   80104610 <mycpu>
801046a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801046a7:	e8 14 0b 00 00       	call   801051c0 <popcli>
801046ac:	89 d8                	mov    %ebx,%eax
801046ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046b1:	c9                   	leave  
801046b2:	c3                   	ret    
801046b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046c0 <userinit>:
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	53                   	push   %ebx
801046c4:	83 ec 04             	sub    $0x4,%esp
801046c7:	e8 04 fe ff ff       	call   801044d0 <allocproc>
801046cc:	89 c3                	mov    %eax,%ebx
801046ce:	a3 94 52 11 80       	mov    %eax,0x80115294
801046d3:	e8 88 34 00 00       	call   80107b60 <setupkvm>
801046d8:	89 43 04             	mov    %eax,0x4(%ebx)
801046db:	85 c0                	test   %eax,%eax
801046dd:	0f 84 bd 00 00 00    	je     801047a0 <userinit+0xe0>
801046e3:	83 ec 04             	sub    $0x4,%esp
801046e6:	68 2c 00 00 00       	push   $0x2c
801046eb:	68 60 b4 10 80       	push   $0x8010b460
801046f0:	50                   	push   %eax
801046f1:	e8 1a 31 00 00       	call   80107810 <inituvm>
801046f6:	83 c4 0c             	add    $0xc,%esp
801046f9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
801046ff:	6a 4c                	push   $0x4c
80104701:	6a 00                	push   $0x0
80104703:	ff 73 18             	push   0x18(%ebx)
80104706:	e8 75 0c 00 00       	call   80105380 <memset>
8010470b:	8b 43 18             	mov    0x18(%ebx),%eax
8010470e:	ba 1b 00 00 00       	mov    $0x1b,%edx
80104713:	83 c4 0c             	add    $0xc,%esp
80104716:	b9 23 00 00 00       	mov    $0x23,%ecx
8010471b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
8010471f:	8b 43 18             	mov    0x18(%ebx),%eax
80104722:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80104726:	8b 43 18             	mov    0x18(%ebx),%eax
80104729:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010472d:	66 89 50 28          	mov    %dx,0x28(%eax)
80104731:	8b 43 18             	mov    0x18(%ebx),%eax
80104734:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104738:	66 89 50 48          	mov    %dx,0x48(%eax)
8010473c:	8b 43 18             	mov    0x18(%ebx),%eax
8010473f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
80104746:	8b 43 18             	mov    0x18(%ebx),%eax
80104749:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
80104750:	8b 43 18             	mov    0x18(%ebx),%eax
80104753:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
8010475a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010475d:	6a 10                	push   $0x10
8010475f:	68 70 84 10 80       	push   $0x80108470
80104764:	50                   	push   %eax
80104765:	e8 d6 0d 00 00       	call   80105540 <safestrcpy>
8010476a:	c7 04 24 79 84 10 80 	movl   $0x80108479,(%esp)
80104771:	e8 4a e6 ff ff       	call   80102dc0 <namei>
80104776:	89 43 68             	mov    %eax,0x68(%ebx)
80104779:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104780:	e8 3b 0b 00 00       	call   801052c0 <acquire>
80104785:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
8010478c:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104793:	e8 c8 0a 00 00       	call   80105260 <release>
80104798:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010479b:	83 c4 10             	add    $0x10,%esp
8010479e:	c9                   	leave  
8010479f:	c3                   	ret    
801047a0:	83 ec 0c             	sub    $0xc,%esp
801047a3:	68 57 84 10 80       	push   $0x80108457
801047a8:	e8 43 bd ff ff       	call   801004f0 <panic>
801047ad:	8d 76 00             	lea    0x0(%esi),%esi

801047b0 <growproc>:
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 75 08             	mov    0x8(%ebp),%esi
801047b8:	e8 b3 09 00 00       	call   80105170 <pushcli>
801047bd:	e8 4e fe ff ff       	call   80104610 <mycpu>
801047c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801047c8:	e8 f3 09 00 00       	call   801051c0 <popcli>
801047cd:	8b 03                	mov    (%ebx),%eax
801047cf:	85 f6                	test   %esi,%esi
801047d1:	7f 1d                	jg     801047f0 <growproc+0x40>
801047d3:	75 3b                	jne    80104810 <growproc+0x60>
801047d5:	83 ec 0c             	sub    $0xc,%esp
801047d8:	89 03                	mov    %eax,(%ebx)
801047da:	53                   	push   %ebx
801047db:	e8 20 2f 00 00       	call   80107700 <switchuvm>
801047e0:	83 c4 10             	add    $0x10,%esp
801047e3:	31 c0                	xor    %eax,%eax
801047e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047e8:	5b                   	pop    %ebx
801047e9:	5e                   	pop    %esi
801047ea:	5d                   	pop    %ebp
801047eb:	c3                   	ret    
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047f0:	83 ec 04             	sub    $0x4,%esp
801047f3:	01 c6                	add    %eax,%esi
801047f5:	56                   	push   %esi
801047f6:	50                   	push   %eax
801047f7:	ff 73 04             	push   0x4(%ebx)
801047fa:	e8 81 31 00 00       	call   80107980 <allocuvm>
801047ff:	83 c4 10             	add    $0x10,%esp
80104802:	85 c0                	test   %eax,%eax
80104804:	75 cf                	jne    801047d5 <growproc+0x25>
80104806:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010480b:	eb d8                	jmp    801047e5 <growproc+0x35>
8010480d:	8d 76 00             	lea    0x0(%esi),%esi
80104810:	83 ec 04             	sub    $0x4,%esp
80104813:	01 c6                	add    %eax,%esi
80104815:	56                   	push   %esi
80104816:	50                   	push   %eax
80104817:	ff 73 04             	push   0x4(%ebx)
8010481a:	e8 91 32 00 00       	call   80107ab0 <deallocuvm>
8010481f:	83 c4 10             	add    $0x10,%esp
80104822:	85 c0                	test   %eax,%eax
80104824:	75 af                	jne    801047d5 <growproc+0x25>
80104826:	eb de                	jmp    80104806 <growproc+0x56>
80104828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482f:	90                   	nop

80104830 <fork>:
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	57                   	push   %edi
80104834:	56                   	push   %esi
80104835:	53                   	push   %ebx
80104836:	83 ec 1c             	sub    $0x1c,%esp
80104839:	e8 32 09 00 00       	call   80105170 <pushcli>
8010483e:	e8 cd fd ff ff       	call   80104610 <mycpu>
80104843:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104849:	e8 72 09 00 00       	call   801051c0 <popcli>
8010484e:	e8 7d fc ff ff       	call   801044d0 <allocproc>
80104853:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104856:	85 c0                	test   %eax,%eax
80104858:	0f 84 b7 00 00 00    	je     80104915 <fork+0xe5>
8010485e:	83 ec 08             	sub    $0x8,%esp
80104861:	ff 33                	push   (%ebx)
80104863:	89 c7                	mov    %eax,%edi
80104865:	ff 73 04             	push   0x4(%ebx)
80104868:	e8 e3 33 00 00       	call   80107c50 <copyuvm>
8010486d:	83 c4 10             	add    $0x10,%esp
80104870:	89 47 04             	mov    %eax,0x4(%edi)
80104873:	85 c0                	test   %eax,%eax
80104875:	0f 84 a1 00 00 00    	je     8010491c <fork+0xec>
8010487b:	8b 03                	mov    (%ebx),%eax
8010487d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104880:	89 01                	mov    %eax,(%ecx)
80104882:	8b 79 18             	mov    0x18(%ecx),%edi
80104885:	89 c8                	mov    %ecx,%eax
80104887:	89 59 14             	mov    %ebx,0x14(%ecx)
8010488a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010488f:	8b 73 18             	mov    0x18(%ebx),%esi
80104892:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80104894:	31 f6                	xor    %esi,%esi
80104896:	8b 40 18             	mov    0x18(%eax),%eax
80104899:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801048a0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801048a4:	85 c0                	test   %eax,%eax
801048a6:	74 13                	je     801048bb <fork+0x8b>
801048a8:	83 ec 0c             	sub    $0xc,%esp
801048ab:	50                   	push   %eax
801048ac:	e8 0f d3 ff ff       	call   80101bc0 <filedup>
801048b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801048b4:	83 c4 10             	add    $0x10,%esp
801048b7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801048bb:	83 c6 01             	add    $0x1,%esi
801048be:	83 fe 10             	cmp    $0x10,%esi
801048c1:	75 dd                	jne    801048a0 <fork+0x70>
801048c3:	83 ec 0c             	sub    $0xc,%esp
801048c6:	ff 73 68             	push   0x68(%ebx)
801048c9:	83 c3 6c             	add    $0x6c,%ebx
801048cc:	e8 9f db ff ff       	call   80102470 <idup>
801048d1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801048d4:	83 c4 0c             	add    $0xc,%esp
801048d7:	89 47 68             	mov    %eax,0x68(%edi)
801048da:	8d 47 6c             	lea    0x6c(%edi),%eax
801048dd:	6a 10                	push   $0x10
801048df:	53                   	push   %ebx
801048e0:	50                   	push   %eax
801048e1:	e8 5a 0c 00 00       	call   80105540 <safestrcpy>
801048e6:	8b 5f 10             	mov    0x10(%edi),%ebx
801048e9:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
801048f0:	e8 cb 09 00 00       	call   801052c0 <acquire>
801048f5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
801048fc:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104903:	e8 58 09 00 00       	call   80105260 <release>
80104908:	83 c4 10             	add    $0x10,%esp
8010490b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010490e:	89 d8                	mov    %ebx,%eax
80104910:	5b                   	pop    %ebx
80104911:	5e                   	pop    %esi
80104912:	5f                   	pop    %edi
80104913:	5d                   	pop    %ebp
80104914:	c3                   	ret    
80104915:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010491a:	eb ef                	jmp    8010490b <fork+0xdb>
8010491c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010491f:	83 ec 0c             	sub    $0xc,%esp
80104922:	ff 73 08             	push   0x8(%ebx)
80104925:	e8 b6 e8 ff ff       	call   801031e0 <kfree>
8010492a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104931:	83 c4 10             	add    $0x10,%esp
80104934:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010493b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104940:	eb c9                	jmp    8010490b <fork+0xdb>
80104942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104950 <scheduler>:
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	57                   	push   %edi
80104954:	56                   	push   %esi
80104955:	53                   	push   %ebx
80104956:	83 ec 0c             	sub    $0xc,%esp
80104959:	e8 b2 fc ff ff       	call   80104610 <mycpu>
8010495e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104965:	00 00 00 
80104968:	89 c6                	mov    %eax,%esi
8010496a:	8d 78 04             	lea    0x4(%eax),%edi
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
80104970:	fb                   	sti    
80104971:	83 ec 0c             	sub    $0xc,%esp
80104974:	bb 94 33 11 80       	mov    $0x80113394,%ebx
80104979:	68 60 33 11 80       	push   $0x80113360
8010497e:	e8 3d 09 00 00       	call   801052c0 <acquire>
80104983:	83 c4 10             	add    $0x10,%esp
80104986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104994:	75 33                	jne    801049c9 <scheduler+0x79>
80104996:	83 ec 0c             	sub    $0xc,%esp
80104999:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010499f:	53                   	push   %ebx
801049a0:	e8 5b 2d 00 00       	call   80107700 <switchuvm>
801049a5:	58                   	pop    %eax
801049a6:	5a                   	pop    %edx
801049a7:	ff 73 1c             	push   0x1c(%ebx)
801049aa:	57                   	push   %edi
801049ab:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
801049b2:	e8 e4 0b 00 00       	call   8010559b <swtch>
801049b7:	e8 34 2d 00 00       	call   801076f0 <switchkvm>
801049bc:	83 c4 10             	add    $0x10,%esp
801049bf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801049c6:	00 00 00 
801049c9:	83 c3 7c             	add    $0x7c,%ebx
801049cc:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
801049d2:	75 bc                	jne    80104990 <scheduler+0x40>
801049d4:	83 ec 0c             	sub    $0xc,%esp
801049d7:	68 60 33 11 80       	push   $0x80113360
801049dc:	e8 7f 08 00 00       	call   80105260 <release>
801049e1:	83 c4 10             	add    $0x10,%esp
801049e4:	eb 8a                	jmp    80104970 <scheduler+0x20>
801049e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ed:	8d 76 00             	lea    0x0(%esi),%esi

801049f0 <sched>:
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
801049f5:	e8 76 07 00 00       	call   80105170 <pushcli>
801049fa:	e8 11 fc ff ff       	call   80104610 <mycpu>
801049ff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104a05:	e8 b6 07 00 00       	call   801051c0 <popcli>
80104a0a:	83 ec 0c             	sub    $0xc,%esp
80104a0d:	68 60 33 11 80       	push   $0x80113360
80104a12:	e8 09 08 00 00       	call   80105220 <holding>
80104a17:	83 c4 10             	add    $0x10,%esp
80104a1a:	85 c0                	test   %eax,%eax
80104a1c:	74 4f                	je     80104a6d <sched+0x7d>
80104a1e:	e8 ed fb ff ff       	call   80104610 <mycpu>
80104a23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104a2a:	75 68                	jne    80104a94 <sched+0xa4>
80104a2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104a30:	74 55                	je     80104a87 <sched+0x97>
80104a32:	9c                   	pushf  
80104a33:	58                   	pop    %eax
80104a34:	f6 c4 02             	test   $0x2,%ah
80104a37:	75 41                	jne    80104a7a <sched+0x8a>
80104a39:	e8 d2 fb ff ff       	call   80104610 <mycpu>
80104a3e:	83 c3 1c             	add    $0x1c,%ebx
80104a41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
80104a47:	e8 c4 fb ff ff       	call   80104610 <mycpu>
80104a4c:	83 ec 08             	sub    $0x8,%esp
80104a4f:	ff 70 04             	push   0x4(%eax)
80104a52:	53                   	push   %ebx
80104a53:	e8 43 0b 00 00       	call   8010559b <swtch>
80104a58:	e8 b3 fb ff ff       	call   80104610 <mycpu>
80104a5d:	83 c4 10             	add    $0x10,%esp
80104a60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
80104a66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a69:	5b                   	pop    %ebx
80104a6a:	5e                   	pop    %esi
80104a6b:	5d                   	pop    %ebp
80104a6c:	c3                   	ret    
80104a6d:	83 ec 0c             	sub    $0xc,%esp
80104a70:	68 7b 84 10 80       	push   $0x8010847b
80104a75:	e8 76 ba ff ff       	call   801004f0 <panic>
80104a7a:	83 ec 0c             	sub    $0xc,%esp
80104a7d:	68 a7 84 10 80       	push   $0x801084a7
80104a82:	e8 69 ba ff ff       	call   801004f0 <panic>
80104a87:	83 ec 0c             	sub    $0xc,%esp
80104a8a:	68 99 84 10 80       	push   $0x80108499
80104a8f:	e8 5c ba ff ff       	call   801004f0 <panic>
80104a94:	83 ec 0c             	sub    $0xc,%esp
80104a97:	68 8d 84 10 80       	push   $0x8010848d
80104a9c:	e8 4f ba ff ff       	call   801004f0 <panic>
80104aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aaf:	90                   	nop

80104ab0 <exit>:
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	57                   	push   %edi
80104ab4:	56                   	push   %esi
80104ab5:	53                   	push   %ebx
80104ab6:	83 ec 0c             	sub    $0xc,%esp
80104ab9:	e8 d2 fb ff ff       	call   80104690 <myproc>
80104abe:	39 05 94 52 11 80    	cmp    %eax,0x80115294
80104ac4:	0f 84 fd 00 00 00    	je     80104bc7 <exit+0x117>
80104aca:	89 c3                	mov    %eax,%ebx
80104acc:	8d 70 28             	lea    0x28(%eax),%esi
80104acf:	8d 78 68             	lea    0x68(%eax),%edi
80104ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ad8:	8b 06                	mov    (%esi),%eax
80104ada:	85 c0                	test   %eax,%eax
80104adc:	74 12                	je     80104af0 <exit+0x40>
80104ade:	83 ec 0c             	sub    $0xc,%esp
80104ae1:	50                   	push   %eax
80104ae2:	e8 29 d1 ff ff       	call   80101c10 <fileclose>
80104ae7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104aed:	83 c4 10             	add    $0x10,%esp
80104af0:	83 c6 04             	add    $0x4,%esi
80104af3:	39 f7                	cmp    %esi,%edi
80104af5:	75 e1                	jne    80104ad8 <exit+0x28>
80104af7:	e8 84 ef ff ff       	call   80103a80 <begin_op>
80104afc:	83 ec 0c             	sub    $0xc,%esp
80104aff:	ff 73 68             	push   0x68(%ebx)
80104b02:	e8 c9 da ff ff       	call   801025d0 <iput>
80104b07:	e8 e4 ef ff ff       	call   80103af0 <end_op>
80104b0c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
80104b13:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104b1a:	e8 a1 07 00 00       	call   801052c0 <acquire>
80104b1f:	8b 53 14             	mov    0x14(%ebx),%edx
80104b22:	83 c4 10             	add    $0x10,%esp
80104b25:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104b2a:	eb 0e                	jmp    80104b3a <exit+0x8a>
80104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b30:	83 c0 7c             	add    $0x7c,%eax
80104b33:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104b38:	74 1c                	je     80104b56 <exit+0xa6>
80104b3a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b3e:	75 f0                	jne    80104b30 <exit+0x80>
80104b40:	3b 50 20             	cmp    0x20(%eax),%edx
80104b43:	75 eb                	jne    80104b30 <exit+0x80>
80104b45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104b4c:	83 c0 7c             	add    $0x7c,%eax
80104b4f:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104b54:	75 e4                	jne    80104b3a <exit+0x8a>
80104b56:	8b 0d 94 52 11 80    	mov    0x80115294,%ecx
80104b5c:	ba 94 33 11 80       	mov    $0x80113394,%edx
80104b61:	eb 10                	jmp    80104b73 <exit+0xc3>
80104b63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b67:	90                   	nop
80104b68:	83 c2 7c             	add    $0x7c,%edx
80104b6b:	81 fa 94 52 11 80    	cmp    $0x80115294,%edx
80104b71:	74 3b                	je     80104bae <exit+0xfe>
80104b73:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104b76:	75 f0                	jne    80104b68 <exit+0xb8>
80104b78:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
80104b7c:	89 4a 14             	mov    %ecx,0x14(%edx)
80104b7f:	75 e7                	jne    80104b68 <exit+0xb8>
80104b81:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104b86:	eb 12                	jmp    80104b9a <exit+0xea>
80104b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b8f:	90                   	nop
80104b90:	83 c0 7c             	add    $0x7c,%eax
80104b93:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104b98:	74 ce                	je     80104b68 <exit+0xb8>
80104b9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b9e:	75 f0                	jne    80104b90 <exit+0xe0>
80104ba0:	3b 48 20             	cmp    0x20(%eax),%ecx
80104ba3:	75 eb                	jne    80104b90 <exit+0xe0>
80104ba5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104bac:	eb e2                	jmp    80104b90 <exit+0xe0>
80104bae:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
80104bb5:	e8 36 fe ff ff       	call   801049f0 <sched>
80104bba:	83 ec 0c             	sub    $0xc,%esp
80104bbd:	68 c8 84 10 80       	push   $0x801084c8
80104bc2:	e8 29 b9 ff ff       	call   801004f0 <panic>
80104bc7:	83 ec 0c             	sub    $0xc,%esp
80104bca:	68 bb 84 10 80       	push   $0x801084bb
80104bcf:	e8 1c b9 ff ff       	call   801004f0 <panic>
80104bd4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bdf:	90                   	nop

80104be0 <wait>:
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	53                   	push   %ebx
80104be5:	e8 86 05 00 00       	call   80105170 <pushcli>
80104bea:	e8 21 fa ff ff       	call   80104610 <mycpu>
80104bef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
80104bf5:	e8 c6 05 00 00       	call   801051c0 <popcli>
80104bfa:	83 ec 0c             	sub    $0xc,%esp
80104bfd:	68 60 33 11 80       	push   $0x80113360
80104c02:	e8 b9 06 00 00       	call   801052c0 <acquire>
80104c07:	83 c4 10             	add    $0x10,%esp
80104c0a:	31 c0                	xor    %eax,%eax
80104c0c:	bb 94 33 11 80       	mov    $0x80113394,%ebx
80104c11:	eb 10                	jmp    80104c23 <wait+0x43>
80104c13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c17:	90                   	nop
80104c18:	83 c3 7c             	add    $0x7c,%ebx
80104c1b:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
80104c21:	74 1b                	je     80104c3e <wait+0x5e>
80104c23:	39 73 14             	cmp    %esi,0x14(%ebx)
80104c26:	75 f0                	jne    80104c18 <wait+0x38>
80104c28:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104c2c:	74 62                	je     80104c90 <wait+0xb0>
80104c2e:	83 c3 7c             	add    $0x7c,%ebx
80104c31:	b8 01 00 00 00       	mov    $0x1,%eax
80104c36:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
80104c3c:	75 e5                	jne    80104c23 <wait+0x43>
80104c3e:	85 c0                	test   %eax,%eax
80104c40:	0f 84 a0 00 00 00    	je     80104ce6 <wait+0x106>
80104c46:	8b 46 24             	mov    0x24(%esi),%eax
80104c49:	85 c0                	test   %eax,%eax
80104c4b:	0f 85 95 00 00 00    	jne    80104ce6 <wait+0x106>
80104c51:	e8 1a 05 00 00       	call   80105170 <pushcli>
80104c56:	e8 b5 f9 ff ff       	call   80104610 <mycpu>
80104c5b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104c61:	e8 5a 05 00 00       	call   801051c0 <popcli>
80104c66:	85 db                	test   %ebx,%ebx
80104c68:	0f 84 8f 00 00 00    	je     80104cfd <wait+0x11d>
80104c6e:	89 73 20             	mov    %esi,0x20(%ebx)
80104c71:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104c78:	e8 73 fd ff ff       	call   801049f0 <sched>
80104c7d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104c84:	eb 84                	jmp    80104c0a <wait+0x2a>
80104c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8d:	8d 76 00             	lea    0x0(%esi),%esi
80104c90:	83 ec 0c             	sub    $0xc,%esp
80104c93:	8b 73 10             	mov    0x10(%ebx),%esi
80104c96:	ff 73 08             	push   0x8(%ebx)
80104c99:	e8 42 e5 ff ff       	call   801031e0 <kfree>
80104c9e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104ca5:	5a                   	pop    %edx
80104ca6:	ff 73 04             	push   0x4(%ebx)
80104ca9:	e8 32 2e 00 00       	call   80107ae0 <freevm>
80104cae:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104cb5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80104cbc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80104cc0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104cc7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104cce:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104cd5:	e8 86 05 00 00       	call   80105260 <release>
80104cda:	83 c4 10             	add    $0x10,%esp
80104cdd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce0:	89 f0                	mov    %esi,%eax
80104ce2:	5b                   	pop    %ebx
80104ce3:	5e                   	pop    %esi
80104ce4:	5d                   	pop    %ebp
80104ce5:	c3                   	ret    
80104ce6:	83 ec 0c             	sub    $0xc,%esp
80104ce9:	be ff ff ff ff       	mov    $0xffffffff,%esi
80104cee:	68 60 33 11 80       	push   $0x80113360
80104cf3:	e8 68 05 00 00       	call   80105260 <release>
80104cf8:	83 c4 10             	add    $0x10,%esp
80104cfb:	eb e0                	jmp    80104cdd <wait+0xfd>
80104cfd:	83 ec 0c             	sub    $0xc,%esp
80104d00:	68 d4 84 10 80       	push   $0x801084d4
80104d05:	e8 e6 b7 ff ff       	call   801004f0 <panic>
80104d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d10 <yield>:
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	53                   	push   %ebx
80104d14:	83 ec 10             	sub    $0x10,%esp
80104d17:	68 60 33 11 80       	push   $0x80113360
80104d1c:	e8 9f 05 00 00       	call   801052c0 <acquire>
80104d21:	e8 4a 04 00 00       	call   80105170 <pushcli>
80104d26:	e8 e5 f8 ff ff       	call   80104610 <mycpu>
80104d2b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104d31:	e8 8a 04 00 00       	call   801051c0 <popcli>
80104d36:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80104d3d:	e8 ae fc ff ff       	call   801049f0 <sched>
80104d42:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104d49:	e8 12 05 00 00       	call   80105260 <release>
80104d4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d51:	83 c4 10             	add    $0x10,%esp
80104d54:	c9                   	leave  
80104d55:	c3                   	ret    
80104d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5d:	8d 76 00             	lea    0x0(%esi),%esi

80104d60 <sleep>:
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	56                   	push   %esi
80104d65:	53                   	push   %ebx
80104d66:	83 ec 0c             	sub    $0xc,%esp
80104d69:	8b 7d 08             	mov    0x8(%ebp),%edi
80104d6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80104d6f:	e8 fc 03 00 00       	call   80105170 <pushcli>
80104d74:	e8 97 f8 ff ff       	call   80104610 <mycpu>
80104d79:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104d7f:	e8 3c 04 00 00       	call   801051c0 <popcli>
80104d84:	85 db                	test   %ebx,%ebx
80104d86:	0f 84 87 00 00 00    	je     80104e13 <sleep+0xb3>
80104d8c:	85 f6                	test   %esi,%esi
80104d8e:	74 76                	je     80104e06 <sleep+0xa6>
80104d90:	81 fe 60 33 11 80    	cmp    $0x80113360,%esi
80104d96:	74 50                	je     80104de8 <sleep+0x88>
80104d98:	83 ec 0c             	sub    $0xc,%esp
80104d9b:	68 60 33 11 80       	push   $0x80113360
80104da0:	e8 1b 05 00 00       	call   801052c0 <acquire>
80104da5:	89 34 24             	mov    %esi,(%esp)
80104da8:	e8 b3 04 00 00       	call   80105260 <release>
80104dad:	89 7b 20             	mov    %edi,0x20(%ebx)
80104db0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104db7:	e8 34 fc ff ff       	call   801049f0 <sched>
80104dbc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104dc3:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104dca:	e8 91 04 00 00       	call   80105260 <release>
80104dcf:	89 75 08             	mov    %esi,0x8(%ebp)
80104dd2:	83 c4 10             	add    $0x10,%esp
80104dd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dd8:	5b                   	pop    %ebx
80104dd9:	5e                   	pop    %esi
80104dda:	5f                   	pop    %edi
80104ddb:	5d                   	pop    %ebp
80104ddc:	e9 df 04 00 00       	jmp    801052c0 <acquire>
80104de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104de8:	89 7b 20             	mov    %edi,0x20(%ebx)
80104deb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104df2:	e8 f9 fb ff ff       	call   801049f0 <sched>
80104df7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e01:	5b                   	pop    %ebx
80104e02:	5e                   	pop    %esi
80104e03:	5f                   	pop    %edi
80104e04:	5d                   	pop    %ebp
80104e05:	c3                   	ret    
80104e06:	83 ec 0c             	sub    $0xc,%esp
80104e09:	68 da 84 10 80       	push   $0x801084da
80104e0e:	e8 dd b6 ff ff       	call   801004f0 <panic>
80104e13:	83 ec 0c             	sub    $0xc,%esp
80104e16:	68 d4 84 10 80       	push   $0x801084d4
80104e1b:	e8 d0 b6 ff ff       	call   801004f0 <panic>

80104e20 <wakeup>:
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	53                   	push   %ebx
80104e24:	83 ec 10             	sub    $0x10,%esp
80104e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e2a:	68 60 33 11 80       	push   $0x80113360
80104e2f:	e8 8c 04 00 00       	call   801052c0 <acquire>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104e3c:	eb 0c                	jmp    80104e4a <wakeup+0x2a>
80104e3e:	66 90                	xchg   %ax,%ax
80104e40:	83 c0 7c             	add    $0x7c,%eax
80104e43:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104e48:	74 1c                	je     80104e66 <wakeup+0x46>
80104e4a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e4e:	75 f0                	jne    80104e40 <wakeup+0x20>
80104e50:	3b 58 20             	cmp    0x20(%eax),%ebx
80104e53:	75 eb                	jne    80104e40 <wakeup+0x20>
80104e55:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104e5c:	83 c0 7c             	add    $0x7c,%eax
80104e5f:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104e64:	75 e4                	jne    80104e4a <wakeup+0x2a>
80104e66:	c7 45 08 60 33 11 80 	movl   $0x80113360,0x8(%ebp)
80104e6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e70:	c9                   	leave  
80104e71:	e9 ea 03 00 00       	jmp    80105260 <release>
80104e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi

80104e80 <kill>:
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	53                   	push   %ebx
80104e84:	83 ec 10             	sub    $0x10,%esp
80104e87:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e8a:	68 60 33 11 80       	push   $0x80113360
80104e8f:	e8 2c 04 00 00       	call   801052c0 <acquire>
80104e94:	83 c4 10             	add    $0x10,%esp
80104e97:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104e9c:	eb 0c                	jmp    80104eaa <kill+0x2a>
80104e9e:	66 90                	xchg   %ax,%ax
80104ea0:	83 c0 7c             	add    $0x7c,%eax
80104ea3:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104ea8:	74 36                	je     80104ee0 <kill+0x60>
80104eaa:	39 58 10             	cmp    %ebx,0x10(%eax)
80104ead:	75 f1                	jne    80104ea0 <kill+0x20>
80104eaf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104eb3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104eba:	75 07                	jne    80104ec3 <kill+0x43>
80104ebc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104ec3:	83 ec 0c             	sub    $0xc,%esp
80104ec6:	68 60 33 11 80       	push   $0x80113360
80104ecb:	e8 90 03 00 00       	call   80105260 <release>
80104ed0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed3:	83 c4 10             	add    $0x10,%esp
80104ed6:	31 c0                	xor    %eax,%eax
80104ed8:	c9                   	leave  
80104ed9:	c3                   	ret    
80104eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ee0:	83 ec 0c             	sub    $0xc,%esp
80104ee3:	68 60 33 11 80       	push   $0x80113360
80104ee8:	e8 73 03 00 00       	call   80105260 <release>
80104eed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ef0:	83 c4 10             	add    $0x10,%esp
80104ef3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ef8:	c9                   	leave  
80104ef9:	c3                   	ret    
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f00 <procdump>:
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
80104f05:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104f08:	53                   	push   %ebx
80104f09:	bb 00 34 11 80       	mov    $0x80113400,%ebx
80104f0e:	83 ec 3c             	sub    $0x3c,%esp
80104f11:	eb 24                	jmp    80104f37 <procdump+0x37>
80104f13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f17:	90                   	nop
80104f18:	83 ec 0c             	sub    $0xc,%esp
80104f1b:	68 57 88 10 80       	push   $0x80108857
80104f20:	e8 4b bb ff ff       	call   80100a70 <cprintf>
80104f25:	83 c4 10             	add    $0x10,%esp
80104f28:	83 c3 7c             	add    $0x7c,%ebx
80104f2b:	81 fb 00 53 11 80    	cmp    $0x80115300,%ebx
80104f31:	0f 84 81 00 00 00    	je     80104fb8 <procdump+0xb8>
80104f37:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104f3a:	85 c0                	test   %eax,%eax
80104f3c:	74 ea                	je     80104f28 <procdump+0x28>
80104f3e:	ba eb 84 10 80       	mov    $0x801084eb,%edx
80104f43:	83 f8 05             	cmp    $0x5,%eax
80104f46:	77 11                	ja     80104f59 <procdump+0x59>
80104f48:	8b 14 85 4c 85 10 80 	mov    -0x7fef7ab4(,%eax,4),%edx
80104f4f:	b8 eb 84 10 80       	mov    $0x801084eb,%eax
80104f54:	85 d2                	test   %edx,%edx
80104f56:	0f 44 d0             	cmove  %eax,%edx
80104f59:	53                   	push   %ebx
80104f5a:	52                   	push   %edx
80104f5b:	ff 73 a4             	push   -0x5c(%ebx)
80104f5e:	68 ef 84 10 80       	push   $0x801084ef
80104f63:	e8 08 bb ff ff       	call   80100a70 <cprintf>
80104f68:	83 c4 10             	add    $0x10,%esp
80104f6b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104f6f:	75 a7                	jne    80104f18 <procdump+0x18>
80104f71:	83 ec 08             	sub    $0x8,%esp
80104f74:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f77:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104f7a:	50                   	push   %eax
80104f7b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104f7e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f81:	83 c0 08             	add    $0x8,%eax
80104f84:	50                   	push   %eax
80104f85:	e8 86 01 00 00       	call   80105110 <getcallerpcs>
80104f8a:	83 c4 10             	add    $0x10,%esp
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
80104f90:	8b 17                	mov    (%edi),%edx
80104f92:	85 d2                	test   %edx,%edx
80104f94:	74 82                	je     80104f18 <procdump+0x18>
80104f96:	83 ec 08             	sub    $0x8,%esp
80104f99:	83 c7 04             	add    $0x4,%edi
80104f9c:	52                   	push   %edx
80104f9d:	68 01 7f 10 80       	push   $0x80107f01
80104fa2:	e8 c9 ba ff ff       	call   80100a70 <cprintf>
80104fa7:	83 c4 10             	add    $0x10,%esp
80104faa:	39 fe                	cmp    %edi,%esi
80104fac:	75 e2                	jne    80104f90 <procdump+0x90>
80104fae:	e9 65 ff ff ff       	jmp    80104f18 <procdump+0x18>
80104fb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fb7:	90                   	nop
80104fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fbb:	5b                   	pop    %ebx
80104fbc:	5e                   	pop    %esi
80104fbd:	5f                   	pop    %edi
80104fbe:	5d                   	pop    %ebp
80104fbf:	c3                   	ret    

80104fc0 <initsleeplock>:
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	53                   	push   %ebx
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104fca:	68 64 85 10 80       	push   $0x80108564
80104fcf:	8d 43 04             	lea    0x4(%ebx),%eax
80104fd2:	50                   	push   %eax
80104fd3:	e8 18 01 00 00       	call   801050f0 <initlock>
80104fd8:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fdb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104fe1:	83 c4 10             	add    $0x10,%esp
80104fe4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104feb:	89 43 38             	mov    %eax,0x38(%ebx)
80104fee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ff1:	c9                   	leave  
80104ff2:	c3                   	ret    
80104ff3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105000 <acquiresleep>:
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
80105005:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105008:	8d 73 04             	lea    0x4(%ebx),%esi
8010500b:	83 ec 0c             	sub    $0xc,%esp
8010500e:	56                   	push   %esi
8010500f:	e8 ac 02 00 00       	call   801052c0 <acquire>
80105014:	8b 13                	mov    (%ebx),%edx
80105016:	83 c4 10             	add    $0x10,%esp
80105019:	85 d2                	test   %edx,%edx
8010501b:	74 16                	je     80105033 <acquiresleep+0x33>
8010501d:	8d 76 00             	lea    0x0(%esi),%esi
80105020:	83 ec 08             	sub    $0x8,%esp
80105023:	56                   	push   %esi
80105024:	53                   	push   %ebx
80105025:	e8 36 fd ff ff       	call   80104d60 <sleep>
8010502a:	8b 03                	mov    (%ebx),%eax
8010502c:	83 c4 10             	add    $0x10,%esp
8010502f:	85 c0                	test   %eax,%eax
80105031:	75 ed                	jne    80105020 <acquiresleep+0x20>
80105033:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80105039:	e8 52 f6 ff ff       	call   80104690 <myproc>
8010503e:	8b 40 10             	mov    0x10(%eax),%eax
80105041:	89 43 3c             	mov    %eax,0x3c(%ebx)
80105044:	89 75 08             	mov    %esi,0x8(%ebp)
80105047:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010504a:	5b                   	pop    %ebx
8010504b:	5e                   	pop    %esi
8010504c:	5d                   	pop    %ebp
8010504d:	e9 0e 02 00 00       	jmp    80105260 <release>
80105052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105060 <releasesleep>:
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	56                   	push   %esi
80105064:	53                   	push   %ebx
80105065:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105068:	8d 73 04             	lea    0x4(%ebx),%esi
8010506b:	83 ec 0c             	sub    $0xc,%esp
8010506e:	56                   	push   %esi
8010506f:	e8 4c 02 00 00       	call   801052c0 <acquire>
80105074:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010507a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80105081:	89 1c 24             	mov    %ebx,(%esp)
80105084:	e8 97 fd ff ff       	call   80104e20 <wakeup>
80105089:	89 75 08             	mov    %esi,0x8(%ebp)
8010508c:	83 c4 10             	add    $0x10,%esp
8010508f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105092:	5b                   	pop    %ebx
80105093:	5e                   	pop    %esi
80105094:	5d                   	pop    %ebp
80105095:	e9 c6 01 00 00       	jmp    80105260 <release>
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050a0 <holdingsleep>:
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	31 ff                	xor    %edi,%edi
801050a6:	56                   	push   %esi
801050a7:	53                   	push   %ebx
801050a8:	83 ec 18             	sub    $0x18,%esp
801050ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050ae:	8d 73 04             	lea    0x4(%ebx),%esi
801050b1:	56                   	push   %esi
801050b2:	e8 09 02 00 00       	call   801052c0 <acquire>
801050b7:	8b 03                	mov    (%ebx),%eax
801050b9:	83 c4 10             	add    $0x10,%esp
801050bc:	85 c0                	test   %eax,%eax
801050be:	75 18                	jne    801050d8 <holdingsleep+0x38>
801050c0:	83 ec 0c             	sub    $0xc,%esp
801050c3:	56                   	push   %esi
801050c4:	e8 97 01 00 00       	call   80105260 <release>
801050c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050cc:	89 f8                	mov    %edi,%eax
801050ce:	5b                   	pop    %ebx
801050cf:	5e                   	pop    %esi
801050d0:	5f                   	pop    %edi
801050d1:	5d                   	pop    %ebp
801050d2:	c3                   	ret    
801050d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050d7:	90                   	nop
801050d8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801050db:	e8 b0 f5 ff ff       	call   80104690 <myproc>
801050e0:	39 58 10             	cmp    %ebx,0x10(%eax)
801050e3:	0f 94 c0             	sete   %al
801050e6:	0f b6 c0             	movzbl %al,%eax
801050e9:	89 c7                	mov    %eax,%edi
801050eb:	eb d3                	jmp    801050c0 <holdingsleep+0x20>
801050ed:	66 90                	xchg   %ax,%ax
801050ef:	90                   	nop

801050f0 <initlock>:
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	8b 45 08             	mov    0x8(%ebp),%eax
801050f6:	8b 55 0c             	mov    0xc(%ebp),%edx
801050f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050ff:	89 50 04             	mov    %edx,0x4(%eax)
80105102:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80105109:	5d                   	pop    %ebp
8010510a:	c3                   	ret    
8010510b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010510f:	90                   	nop

80105110 <getcallerpcs>:
80105110:	55                   	push   %ebp
80105111:	31 d2                	xor    %edx,%edx
80105113:	89 e5                	mov    %esp,%ebp
80105115:	53                   	push   %ebx
80105116:	8b 45 08             	mov    0x8(%ebp),%eax
80105119:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010511c:	83 e8 08             	sub    $0x8,%eax
8010511f:	90                   	nop
80105120:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105126:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010512c:	77 1a                	ja     80105148 <getcallerpcs+0x38>
8010512e:	8b 58 04             	mov    0x4(%eax),%ebx
80105131:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
80105134:	83 c2 01             	add    $0x1,%edx
80105137:	8b 00                	mov    (%eax),%eax
80105139:	83 fa 0a             	cmp    $0xa,%edx
8010513c:	75 e2                	jne    80105120 <getcallerpcs+0x10>
8010513e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105141:	c9                   	leave  
80105142:	c3                   	ret    
80105143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105147:	90                   	nop
80105148:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010514b:	8d 51 28             	lea    0x28(%ecx),%edx
8010514e:	66 90                	xchg   %ax,%ax
80105150:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105156:	83 c0 04             	add    $0x4,%eax
80105159:	39 d0                	cmp    %edx,%eax
8010515b:	75 f3                	jne    80105150 <getcallerpcs+0x40>
8010515d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105160:	c9                   	leave  
80105161:	c3                   	ret    
80105162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105170 <pushcli>:
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	53                   	push   %ebx
80105174:	83 ec 04             	sub    $0x4,%esp
80105177:	9c                   	pushf  
80105178:	5b                   	pop    %ebx
80105179:	fa                   	cli    
8010517a:	e8 91 f4 ff ff       	call   80104610 <mycpu>
8010517f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105185:	85 c0                	test   %eax,%eax
80105187:	74 17                	je     801051a0 <pushcli+0x30>
80105189:	e8 82 f4 ff ff       	call   80104610 <mycpu>
8010518e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80105195:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105198:	c9                   	leave  
80105199:	c3                   	ret    
8010519a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051a0:	e8 6b f4 ff ff       	call   80104610 <mycpu>
801051a5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801051ab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801051b1:	eb d6                	jmp    80105189 <pushcli+0x19>
801051b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051c0 <popcli>:
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	83 ec 08             	sub    $0x8,%esp
801051c6:	9c                   	pushf  
801051c7:	58                   	pop    %eax
801051c8:	f6 c4 02             	test   $0x2,%ah
801051cb:	75 35                	jne    80105202 <popcli+0x42>
801051cd:	e8 3e f4 ff ff       	call   80104610 <mycpu>
801051d2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801051d9:	78 34                	js     8010520f <popcli+0x4f>
801051db:	e8 30 f4 ff ff       	call   80104610 <mycpu>
801051e0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801051e6:	85 d2                	test   %edx,%edx
801051e8:	74 06                	je     801051f0 <popcli+0x30>
801051ea:	c9                   	leave  
801051eb:	c3                   	ret    
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051f0:	e8 1b f4 ff ff       	call   80104610 <mycpu>
801051f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801051fb:	85 c0                	test   %eax,%eax
801051fd:	74 eb                	je     801051ea <popcli+0x2a>
801051ff:	fb                   	sti    
80105200:	c9                   	leave  
80105201:	c3                   	ret    
80105202:	83 ec 0c             	sub    $0xc,%esp
80105205:	68 6f 85 10 80       	push   $0x8010856f
8010520a:	e8 e1 b2 ff ff       	call   801004f0 <panic>
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	68 86 85 10 80       	push   $0x80108586
80105217:	e8 d4 b2 ff ff       	call   801004f0 <panic>
8010521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105220 <holding>:
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	56                   	push   %esi
80105224:	53                   	push   %ebx
80105225:	8b 75 08             	mov    0x8(%ebp),%esi
80105228:	31 db                	xor    %ebx,%ebx
8010522a:	e8 41 ff ff ff       	call   80105170 <pushcli>
8010522f:	8b 06                	mov    (%esi),%eax
80105231:	85 c0                	test   %eax,%eax
80105233:	75 0b                	jne    80105240 <holding+0x20>
80105235:	e8 86 ff ff ff       	call   801051c0 <popcli>
8010523a:	89 d8                	mov    %ebx,%eax
8010523c:	5b                   	pop    %ebx
8010523d:	5e                   	pop    %esi
8010523e:	5d                   	pop    %ebp
8010523f:	c3                   	ret    
80105240:	8b 5e 08             	mov    0x8(%esi),%ebx
80105243:	e8 c8 f3 ff ff       	call   80104610 <mycpu>
80105248:	39 c3                	cmp    %eax,%ebx
8010524a:	0f 94 c3             	sete   %bl
8010524d:	e8 6e ff ff ff       	call   801051c0 <popcli>
80105252:	0f b6 db             	movzbl %bl,%ebx
80105255:	89 d8                	mov    %ebx,%eax
80105257:	5b                   	pop    %ebx
80105258:	5e                   	pop    %esi
80105259:	5d                   	pop    %ebp
8010525a:	c3                   	ret    
8010525b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010525f:	90                   	nop

80105260 <release>:
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	56                   	push   %esi
80105264:	53                   	push   %ebx
80105265:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105268:	e8 03 ff ff ff       	call   80105170 <pushcli>
8010526d:	8b 03                	mov    (%ebx),%eax
8010526f:	85 c0                	test   %eax,%eax
80105271:	75 15                	jne    80105288 <release+0x28>
80105273:	e8 48 ff ff ff       	call   801051c0 <popcli>
80105278:	83 ec 0c             	sub    $0xc,%esp
8010527b:	68 8d 85 10 80       	push   $0x8010858d
80105280:	e8 6b b2 ff ff       	call   801004f0 <panic>
80105285:	8d 76 00             	lea    0x0(%esi),%esi
80105288:	8b 73 08             	mov    0x8(%ebx),%esi
8010528b:	e8 80 f3 ff ff       	call   80104610 <mycpu>
80105290:	39 c6                	cmp    %eax,%esi
80105292:	75 df                	jne    80105273 <release+0x13>
80105294:	e8 27 ff ff ff       	call   801051c0 <popcli>
80105299:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801052a0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801052a7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801052ac:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801052b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052b5:	5b                   	pop    %ebx
801052b6:	5e                   	pop    %esi
801052b7:	5d                   	pop    %ebp
801052b8:	e9 03 ff ff ff       	jmp    801051c0 <popcli>
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <acquire>:
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	53                   	push   %ebx
801052c4:	83 ec 04             	sub    $0x4,%esp
801052c7:	e8 a4 fe ff ff       	call   80105170 <pushcli>
801052cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052cf:	e8 9c fe ff ff       	call   80105170 <pushcli>
801052d4:	8b 03                	mov    (%ebx),%eax
801052d6:	85 c0                	test   %eax,%eax
801052d8:	75 7e                	jne    80105358 <acquire+0x98>
801052da:	e8 e1 fe ff ff       	call   801051c0 <popcli>
801052df:	b9 01 00 00 00       	mov    $0x1,%ecx
801052e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052e8:	8b 55 08             	mov    0x8(%ebp),%edx
801052eb:	89 c8                	mov    %ecx,%eax
801052ed:	f0 87 02             	lock xchg %eax,(%edx)
801052f0:	85 c0                	test   %eax,%eax
801052f2:	75 f4                	jne    801052e8 <acquire+0x28>
801052f4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801052f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052fc:	e8 0f f3 ff ff       	call   80104610 <mycpu>
80105301:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105304:	89 ea                	mov    %ebp,%edx
80105306:	89 43 08             	mov    %eax,0x8(%ebx)
80105309:	31 c0                	xor    %eax,%eax
8010530b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010530f:	90                   	nop
80105310:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105316:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010531c:	77 1a                	ja     80105338 <acquire+0x78>
8010531e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105321:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
80105325:	83 c0 01             	add    $0x1,%eax
80105328:	8b 12                	mov    (%edx),%edx
8010532a:	83 f8 0a             	cmp    $0xa,%eax
8010532d:	75 e1                	jne    80105310 <acquire+0x50>
8010532f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105332:	c9                   	leave  
80105333:	c3                   	ret    
80105334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105338:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010533c:	8d 51 34             	lea    0x34(%ecx),%edx
8010533f:	90                   	nop
80105340:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105346:	83 c0 04             	add    $0x4,%eax
80105349:	39 c2                	cmp    %eax,%edx
8010534b:	75 f3                	jne    80105340 <acquire+0x80>
8010534d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105350:	c9                   	leave  
80105351:	c3                   	ret    
80105352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105358:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010535b:	e8 b0 f2 ff ff       	call   80104610 <mycpu>
80105360:	39 c3                	cmp    %eax,%ebx
80105362:	0f 85 72 ff ff ff    	jne    801052da <acquire+0x1a>
80105368:	e8 53 fe ff ff       	call   801051c0 <popcli>
8010536d:	83 ec 0c             	sub    $0xc,%esp
80105370:	68 95 85 10 80       	push   $0x80108595
80105375:	e8 76 b1 ff ff       	call   801004f0 <panic>
8010537a:	66 90                	xchg   %ax,%ax
8010537c:	66 90                	xchg   %ax,%ax
8010537e:	66 90                	xchg   %ax,%ax

80105380 <memset>:
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	8b 55 08             	mov    0x8(%ebp),%edx
80105387:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010538a:	53                   	push   %ebx
8010538b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010538e:	89 d7                	mov    %edx,%edi
80105390:	09 cf                	or     %ecx,%edi
80105392:	83 e7 03             	and    $0x3,%edi
80105395:	75 29                	jne    801053c0 <memset+0x40>
80105397:	0f b6 f8             	movzbl %al,%edi
8010539a:	c1 e0 18             	shl    $0x18,%eax
8010539d:	89 fb                	mov    %edi,%ebx
8010539f:	c1 e9 02             	shr    $0x2,%ecx
801053a2:	c1 e3 10             	shl    $0x10,%ebx
801053a5:	09 d8                	or     %ebx,%eax
801053a7:	09 f8                	or     %edi,%eax
801053a9:	c1 e7 08             	shl    $0x8,%edi
801053ac:	09 f8                	or     %edi,%eax
801053ae:	89 d7                	mov    %edx,%edi
801053b0:	fc                   	cld    
801053b1:	f3 ab                	rep stos %eax,%es:(%edi)
801053b3:	5b                   	pop    %ebx
801053b4:	89 d0                	mov    %edx,%eax
801053b6:	5f                   	pop    %edi
801053b7:	5d                   	pop    %ebp
801053b8:	c3                   	ret    
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c0:	89 d7                	mov    %edx,%edi
801053c2:	fc                   	cld    
801053c3:	f3 aa                	rep stos %al,%es:(%edi)
801053c5:	5b                   	pop    %ebx
801053c6:	89 d0                	mov    %edx,%eax
801053c8:	5f                   	pop    %edi
801053c9:	5d                   	pop    %ebp
801053ca:	c3                   	ret    
801053cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053cf:	90                   	nop

801053d0 <memcmp>:
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	56                   	push   %esi
801053d4:	8b 75 10             	mov    0x10(%ebp),%esi
801053d7:	8b 55 08             	mov    0x8(%ebp),%edx
801053da:	53                   	push   %ebx
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
801053de:	85 f6                	test   %esi,%esi
801053e0:	74 2e                	je     80105410 <memcmp+0x40>
801053e2:	01 c6                	add    %eax,%esi
801053e4:	eb 14                	jmp    801053fa <memcmp+0x2a>
801053e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ed:	8d 76 00             	lea    0x0(%esi),%esi
801053f0:	83 c0 01             	add    $0x1,%eax
801053f3:	83 c2 01             	add    $0x1,%edx
801053f6:	39 f0                	cmp    %esi,%eax
801053f8:	74 16                	je     80105410 <memcmp+0x40>
801053fa:	0f b6 0a             	movzbl (%edx),%ecx
801053fd:	0f b6 18             	movzbl (%eax),%ebx
80105400:	38 d9                	cmp    %bl,%cl
80105402:	74 ec                	je     801053f0 <memcmp+0x20>
80105404:	0f b6 c1             	movzbl %cl,%eax
80105407:	29 d8                	sub    %ebx,%eax
80105409:	5b                   	pop    %ebx
8010540a:	5e                   	pop    %esi
8010540b:	5d                   	pop    %ebp
8010540c:	c3                   	ret    
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
80105410:	5b                   	pop    %ebx
80105411:	31 c0                	xor    %eax,%eax
80105413:	5e                   	pop    %esi
80105414:	5d                   	pop    %ebp
80105415:	c3                   	ret    
80105416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010541d:	8d 76 00             	lea    0x0(%esi),%esi

80105420 <memmove>:
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	57                   	push   %edi
80105424:	8b 55 08             	mov    0x8(%ebp),%edx
80105427:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010542a:	56                   	push   %esi
8010542b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010542e:	39 d6                	cmp    %edx,%esi
80105430:	73 26                	jae    80105458 <memmove+0x38>
80105432:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105435:	39 fa                	cmp    %edi,%edx
80105437:	73 1f                	jae    80105458 <memmove+0x38>
80105439:	8d 41 ff             	lea    -0x1(%ecx),%eax
8010543c:	85 c9                	test   %ecx,%ecx
8010543e:	74 0c                	je     8010544c <memmove+0x2c>
80105440:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105444:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80105447:	83 e8 01             	sub    $0x1,%eax
8010544a:	73 f4                	jae    80105440 <memmove+0x20>
8010544c:	5e                   	pop    %esi
8010544d:	89 d0                	mov    %edx,%eax
8010544f:	5f                   	pop    %edi
80105450:	5d                   	pop    %ebp
80105451:	c3                   	ret    
80105452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105458:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010545b:	89 d7                	mov    %edx,%edi
8010545d:	85 c9                	test   %ecx,%ecx
8010545f:	74 eb                	je     8010544c <memmove+0x2c>
80105461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105468:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105469:	39 c6                	cmp    %eax,%esi
8010546b:	75 fb                	jne    80105468 <memmove+0x48>
8010546d:	5e                   	pop    %esi
8010546e:	89 d0                	mov    %edx,%eax
80105470:	5f                   	pop    %edi
80105471:	5d                   	pop    %ebp
80105472:	c3                   	ret    
80105473:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010547a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105480 <memcpy>:
80105480:	eb 9e                	jmp    80105420 <memmove>
80105482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105490 <strncmp>:
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	56                   	push   %esi
80105494:	8b 75 10             	mov    0x10(%ebp),%esi
80105497:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010549a:	53                   	push   %ebx
8010549b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010549e:	85 f6                	test   %esi,%esi
801054a0:	74 2e                	je     801054d0 <strncmp+0x40>
801054a2:	01 d6                	add    %edx,%esi
801054a4:	eb 18                	jmp    801054be <strncmp+0x2e>
801054a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ad:	8d 76 00             	lea    0x0(%esi),%esi
801054b0:	38 d8                	cmp    %bl,%al
801054b2:	75 14                	jne    801054c8 <strncmp+0x38>
801054b4:	83 c2 01             	add    $0x1,%edx
801054b7:	83 c1 01             	add    $0x1,%ecx
801054ba:	39 f2                	cmp    %esi,%edx
801054bc:	74 12                	je     801054d0 <strncmp+0x40>
801054be:	0f b6 01             	movzbl (%ecx),%eax
801054c1:	0f b6 1a             	movzbl (%edx),%ebx
801054c4:	84 c0                	test   %al,%al
801054c6:	75 e8                	jne    801054b0 <strncmp+0x20>
801054c8:	29 d8                	sub    %ebx,%eax
801054ca:	5b                   	pop    %ebx
801054cb:	5e                   	pop    %esi
801054cc:	5d                   	pop    %ebp
801054cd:	c3                   	ret    
801054ce:	66 90                	xchg   %ax,%ax
801054d0:	5b                   	pop    %ebx
801054d1:	31 c0                	xor    %eax,%eax
801054d3:	5e                   	pop    %esi
801054d4:	5d                   	pop    %ebp
801054d5:	c3                   	ret    
801054d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054dd:	8d 76 00             	lea    0x0(%esi),%esi

801054e0 <strncpy>:
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	57                   	push   %edi
801054e4:	56                   	push   %esi
801054e5:	8b 75 08             	mov    0x8(%ebp),%esi
801054e8:	53                   	push   %ebx
801054e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
801054ec:	89 f0                	mov    %esi,%eax
801054ee:	eb 15                	jmp    80105505 <strncpy+0x25>
801054f0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801054f4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801054f7:	83 c0 01             	add    $0x1,%eax
801054fa:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
801054fe:	88 50 ff             	mov    %dl,-0x1(%eax)
80105501:	84 d2                	test   %dl,%dl
80105503:	74 09                	je     8010550e <strncpy+0x2e>
80105505:	89 cb                	mov    %ecx,%ebx
80105507:	83 e9 01             	sub    $0x1,%ecx
8010550a:	85 db                	test   %ebx,%ebx
8010550c:	7f e2                	jg     801054f0 <strncpy+0x10>
8010550e:	89 c2                	mov    %eax,%edx
80105510:	85 c9                	test   %ecx,%ecx
80105512:	7e 17                	jle    8010552b <strncpy+0x4b>
80105514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105518:	83 c2 01             	add    $0x1,%edx
8010551b:	89 c1                	mov    %eax,%ecx
8010551d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80105521:	29 d1                	sub    %edx,%ecx
80105523:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80105527:	85 c9                	test   %ecx,%ecx
80105529:	7f ed                	jg     80105518 <strncpy+0x38>
8010552b:	5b                   	pop    %ebx
8010552c:	89 f0                	mov    %esi,%eax
8010552e:	5e                   	pop    %esi
8010552f:	5f                   	pop    %edi
80105530:	5d                   	pop    %ebp
80105531:	c3                   	ret    
80105532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105540 <safestrcpy>:
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	56                   	push   %esi
80105544:	8b 55 10             	mov    0x10(%ebp),%edx
80105547:	8b 75 08             	mov    0x8(%ebp),%esi
8010554a:	53                   	push   %ebx
8010554b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010554e:	85 d2                	test   %edx,%edx
80105550:	7e 25                	jle    80105577 <safestrcpy+0x37>
80105552:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105556:	89 f2                	mov    %esi,%edx
80105558:	eb 16                	jmp    80105570 <safestrcpy+0x30>
8010555a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105560:	0f b6 08             	movzbl (%eax),%ecx
80105563:	83 c0 01             	add    $0x1,%eax
80105566:	83 c2 01             	add    $0x1,%edx
80105569:	88 4a ff             	mov    %cl,-0x1(%edx)
8010556c:	84 c9                	test   %cl,%cl
8010556e:	74 04                	je     80105574 <safestrcpy+0x34>
80105570:	39 d8                	cmp    %ebx,%eax
80105572:	75 ec                	jne    80105560 <safestrcpy+0x20>
80105574:	c6 02 00             	movb   $0x0,(%edx)
80105577:	89 f0                	mov    %esi,%eax
80105579:	5b                   	pop    %ebx
8010557a:	5e                   	pop    %esi
8010557b:	5d                   	pop    %ebp
8010557c:	c3                   	ret    
8010557d:	8d 76 00             	lea    0x0(%esi),%esi

80105580 <strlen>:
80105580:	55                   	push   %ebp
80105581:	31 c0                	xor    %eax,%eax
80105583:	89 e5                	mov    %esp,%ebp
80105585:	8b 55 08             	mov    0x8(%ebp),%edx
80105588:	80 3a 00             	cmpb   $0x0,(%edx)
8010558b:	74 0c                	je     80105599 <strlen+0x19>
8010558d:	8d 76 00             	lea    0x0(%esi),%esi
80105590:	83 c0 01             	add    $0x1,%eax
80105593:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105597:	75 f7                	jne    80105590 <strlen+0x10>
80105599:	5d                   	pop    %ebp
8010559a:	c3                   	ret    

8010559b <swtch>:
8010559b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010559f:	8b 54 24 08          	mov    0x8(%esp),%edx
801055a3:	55                   	push   %ebp
801055a4:	53                   	push   %ebx
801055a5:	56                   	push   %esi
801055a6:	57                   	push   %edi
801055a7:	89 20                	mov    %esp,(%eax)
801055a9:	89 d4                	mov    %edx,%esp
801055ab:	5f                   	pop    %edi
801055ac:	5e                   	pop    %esi
801055ad:	5b                   	pop    %ebx
801055ae:	5d                   	pop    %ebp
801055af:	c3                   	ret    

801055b0 <fetchint>:
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	53                   	push   %ebx
801055b4:	83 ec 04             	sub    $0x4,%esp
801055b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801055ba:	e8 d1 f0 ff ff       	call   80104690 <myproc>
801055bf:	8b 00                	mov    (%eax),%eax
801055c1:	39 d8                	cmp    %ebx,%eax
801055c3:	76 1b                	jbe    801055e0 <fetchint+0x30>
801055c5:	8d 53 04             	lea    0x4(%ebx),%edx
801055c8:	39 d0                	cmp    %edx,%eax
801055ca:	72 14                	jb     801055e0 <fetchint+0x30>
801055cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801055cf:	8b 13                	mov    (%ebx),%edx
801055d1:	89 10                	mov    %edx,(%eax)
801055d3:	31 c0                	xor    %eax,%eax
801055d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055d8:	c9                   	leave  
801055d9:	c3                   	ret    
801055da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e5:	eb ee                	jmp    801055d5 <fetchint+0x25>
801055e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <fetchstr>:
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	53                   	push   %ebx
801055f4:	83 ec 04             	sub    $0x4,%esp
801055f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801055fa:	e8 91 f0 ff ff       	call   80104690 <myproc>
801055ff:	39 18                	cmp    %ebx,(%eax)
80105601:	76 2d                	jbe    80105630 <fetchstr+0x40>
80105603:	8b 55 0c             	mov    0xc(%ebp),%edx
80105606:	89 1a                	mov    %ebx,(%edx)
80105608:	8b 10                	mov    (%eax),%edx
8010560a:	39 d3                	cmp    %edx,%ebx
8010560c:	73 22                	jae    80105630 <fetchstr+0x40>
8010560e:	89 d8                	mov    %ebx,%eax
80105610:	eb 0d                	jmp    8010561f <fetchstr+0x2f>
80105612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105618:	83 c0 01             	add    $0x1,%eax
8010561b:	39 c2                	cmp    %eax,%edx
8010561d:	76 11                	jbe    80105630 <fetchstr+0x40>
8010561f:	80 38 00             	cmpb   $0x0,(%eax)
80105622:	75 f4                	jne    80105618 <fetchstr+0x28>
80105624:	29 d8                	sub    %ebx,%eax
80105626:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105629:	c9                   	leave  
8010562a:	c3                   	ret    
8010562b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010562f:	90                   	nop
80105630:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105638:	c9                   	leave  
80105639:	c3                   	ret    
8010563a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105640 <argint>:
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	56                   	push   %esi
80105644:	53                   	push   %ebx
80105645:	e8 46 f0 ff ff       	call   80104690 <myproc>
8010564a:	8b 55 08             	mov    0x8(%ebp),%edx
8010564d:	8b 40 18             	mov    0x18(%eax),%eax
80105650:	8b 40 44             	mov    0x44(%eax),%eax
80105653:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105656:	e8 35 f0 ff ff       	call   80104690 <myproc>
8010565b:	8d 73 04             	lea    0x4(%ebx),%esi
8010565e:	8b 00                	mov    (%eax),%eax
80105660:	39 c6                	cmp    %eax,%esi
80105662:	73 1c                	jae    80105680 <argint+0x40>
80105664:	8d 53 08             	lea    0x8(%ebx),%edx
80105667:	39 d0                	cmp    %edx,%eax
80105669:	72 15                	jb     80105680 <argint+0x40>
8010566b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010566e:	8b 53 04             	mov    0x4(%ebx),%edx
80105671:	89 10                	mov    %edx,(%eax)
80105673:	31 c0                	xor    %eax,%eax
80105675:	5b                   	pop    %ebx
80105676:	5e                   	pop    %esi
80105677:	5d                   	pop    %ebp
80105678:	c3                   	ret    
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105685:	eb ee                	jmp    80105675 <argint+0x35>
80105687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568e:	66 90                	xchg   %ax,%ax

80105690 <argptr>:
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	57                   	push   %edi
80105694:	56                   	push   %esi
80105695:	53                   	push   %ebx
80105696:	83 ec 0c             	sub    $0xc,%esp
80105699:	e8 f2 ef ff ff       	call   80104690 <myproc>
8010569e:	89 c6                	mov    %eax,%esi
801056a0:	e8 eb ef ff ff       	call   80104690 <myproc>
801056a5:	8b 55 08             	mov    0x8(%ebp),%edx
801056a8:	8b 40 18             	mov    0x18(%eax),%eax
801056ab:	8b 40 44             	mov    0x44(%eax),%eax
801056ae:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801056b1:	e8 da ef ff ff       	call   80104690 <myproc>
801056b6:	8d 7b 04             	lea    0x4(%ebx),%edi
801056b9:	8b 00                	mov    (%eax),%eax
801056bb:	39 c7                	cmp    %eax,%edi
801056bd:	73 31                	jae    801056f0 <argptr+0x60>
801056bf:	8d 4b 08             	lea    0x8(%ebx),%ecx
801056c2:	39 c8                	cmp    %ecx,%eax
801056c4:	72 2a                	jb     801056f0 <argptr+0x60>
801056c6:	8b 55 10             	mov    0x10(%ebp),%edx
801056c9:	8b 43 04             	mov    0x4(%ebx),%eax
801056cc:	85 d2                	test   %edx,%edx
801056ce:	78 20                	js     801056f0 <argptr+0x60>
801056d0:	8b 16                	mov    (%esi),%edx
801056d2:	39 c2                	cmp    %eax,%edx
801056d4:	76 1a                	jbe    801056f0 <argptr+0x60>
801056d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801056d9:	01 c3                	add    %eax,%ebx
801056db:	39 da                	cmp    %ebx,%edx
801056dd:	72 11                	jb     801056f0 <argptr+0x60>
801056df:	8b 55 0c             	mov    0xc(%ebp),%edx
801056e2:	89 02                	mov    %eax,(%edx)
801056e4:	31 c0                	xor    %eax,%eax
801056e6:	83 c4 0c             	add    $0xc,%esp
801056e9:	5b                   	pop    %ebx
801056ea:	5e                   	pop    %esi
801056eb:	5f                   	pop    %edi
801056ec:	5d                   	pop    %ebp
801056ed:	c3                   	ret    
801056ee:	66 90                	xchg   %ax,%ax
801056f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056f5:	eb ef                	jmp    801056e6 <argptr+0x56>
801056f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fe:	66 90                	xchg   %ax,%ax

80105700 <argstr>:
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	56                   	push   %esi
80105704:	53                   	push   %ebx
80105705:	e8 86 ef ff ff       	call   80104690 <myproc>
8010570a:	8b 55 08             	mov    0x8(%ebp),%edx
8010570d:	8b 40 18             	mov    0x18(%eax),%eax
80105710:	8b 40 44             	mov    0x44(%eax),%eax
80105713:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105716:	e8 75 ef ff ff       	call   80104690 <myproc>
8010571b:	8d 73 04             	lea    0x4(%ebx),%esi
8010571e:	8b 00                	mov    (%eax),%eax
80105720:	39 c6                	cmp    %eax,%esi
80105722:	73 44                	jae    80105768 <argstr+0x68>
80105724:	8d 53 08             	lea    0x8(%ebx),%edx
80105727:	39 d0                	cmp    %edx,%eax
80105729:	72 3d                	jb     80105768 <argstr+0x68>
8010572b:	8b 5b 04             	mov    0x4(%ebx),%ebx
8010572e:	e8 5d ef ff ff       	call   80104690 <myproc>
80105733:	3b 18                	cmp    (%eax),%ebx
80105735:	73 31                	jae    80105768 <argstr+0x68>
80105737:	8b 55 0c             	mov    0xc(%ebp),%edx
8010573a:	89 1a                	mov    %ebx,(%edx)
8010573c:	8b 10                	mov    (%eax),%edx
8010573e:	39 d3                	cmp    %edx,%ebx
80105740:	73 26                	jae    80105768 <argstr+0x68>
80105742:	89 d8                	mov    %ebx,%eax
80105744:	eb 11                	jmp    80105757 <argstr+0x57>
80105746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574d:	8d 76 00             	lea    0x0(%esi),%esi
80105750:	83 c0 01             	add    $0x1,%eax
80105753:	39 c2                	cmp    %eax,%edx
80105755:	76 11                	jbe    80105768 <argstr+0x68>
80105757:	80 38 00             	cmpb   $0x0,(%eax)
8010575a:	75 f4                	jne    80105750 <argstr+0x50>
8010575c:	29 d8                	sub    %ebx,%eax
8010575e:	5b                   	pop    %ebx
8010575f:	5e                   	pop    %esi
80105760:	5d                   	pop    %ebp
80105761:	c3                   	ret    
80105762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105768:	5b                   	pop    %ebx
80105769:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010576e:	5e                   	pop    %esi
8010576f:	5d                   	pop    %ebp
80105770:	c3                   	ret    
80105771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010577f:	90                   	nop

80105780 <syscall>:
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
80105784:	83 ec 04             	sub    $0x4,%esp
80105787:	e8 04 ef ff ff       	call   80104690 <myproc>
8010578c:	89 c3                	mov    %eax,%ebx
8010578e:	8b 40 18             	mov    0x18(%eax),%eax
80105791:	8b 40 1c             	mov    0x1c(%eax),%eax
80105794:	8d 50 ff             	lea    -0x1(%eax),%edx
80105797:	83 fa 14             	cmp    $0x14,%edx
8010579a:	77 24                	ja     801057c0 <syscall+0x40>
8010579c:	8b 14 85 c0 85 10 80 	mov    -0x7fef7a40(,%eax,4),%edx
801057a3:	85 d2                	test   %edx,%edx
801057a5:	74 19                	je     801057c0 <syscall+0x40>
801057a7:	ff d2                	call   *%edx
801057a9:	89 c2                	mov    %eax,%edx
801057ab:	8b 43 18             	mov    0x18(%ebx),%eax
801057ae:	89 50 1c             	mov    %edx,0x1c(%eax)
801057b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b4:	c9                   	leave  
801057b5:	c3                   	ret    
801057b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bd:	8d 76 00             	lea    0x0(%esi),%esi
801057c0:	50                   	push   %eax
801057c1:	8d 43 6c             	lea    0x6c(%ebx),%eax
801057c4:	50                   	push   %eax
801057c5:	ff 73 10             	push   0x10(%ebx)
801057c8:	68 9d 85 10 80       	push   $0x8010859d
801057cd:	e8 9e b2 ff ff       	call   80100a70 <cprintf>
801057d2:	8b 43 18             	mov    0x18(%ebx),%eax
801057d5:	83 c4 10             	add    $0x10,%esp
801057d8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
801057df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e2:	c9                   	leave  
801057e3:	c3                   	ret    
801057e4:	66 90                	xchg   %ax,%ax
801057e6:	66 90                	xchg   %ax,%ax
801057e8:	66 90                	xchg   %ax,%ax
801057ea:	66 90                	xchg   %ax,%ax
801057ec:	66 90                	xchg   %ax,%ax
801057ee:	66 90                	xchg   %ax,%ax

801057f0 <create>:
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	57                   	push   %edi
801057f4:	56                   	push   %esi
801057f5:	8d 7d da             	lea    -0x26(%ebp),%edi
801057f8:	53                   	push   %ebx
801057f9:	83 ec 34             	sub    $0x34,%esp
801057fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801057ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105802:	57                   	push   %edi
80105803:	50                   	push   %eax
80105804:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105807:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010580a:	e8 d1 d5 ff ff       	call   80102de0 <nameiparent>
8010580f:	83 c4 10             	add    $0x10,%esp
80105812:	85 c0                	test   %eax,%eax
80105814:	0f 84 46 01 00 00    	je     80105960 <create+0x170>
8010581a:	83 ec 0c             	sub    $0xc,%esp
8010581d:	89 c3                	mov    %eax,%ebx
8010581f:	50                   	push   %eax
80105820:	e8 7b cc ff ff       	call   801024a0 <ilock>
80105825:	83 c4 0c             	add    $0xc,%esp
80105828:	6a 00                	push   $0x0
8010582a:	57                   	push   %edi
8010582b:	53                   	push   %ebx
8010582c:	e8 cf d1 ff ff       	call   80102a00 <dirlookup>
80105831:	83 c4 10             	add    $0x10,%esp
80105834:	89 c6                	mov    %eax,%esi
80105836:	85 c0                	test   %eax,%eax
80105838:	74 56                	je     80105890 <create+0xa0>
8010583a:	83 ec 0c             	sub    $0xc,%esp
8010583d:	53                   	push   %ebx
8010583e:	e8 ed ce ff ff       	call   80102730 <iunlockput>
80105843:	89 34 24             	mov    %esi,(%esp)
80105846:	e8 55 cc ff ff       	call   801024a0 <ilock>
8010584b:	83 c4 10             	add    $0x10,%esp
8010584e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105853:	75 1b                	jne    80105870 <create+0x80>
80105855:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010585a:	75 14                	jne    80105870 <create+0x80>
8010585c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010585f:	89 f0                	mov    %esi,%eax
80105861:	5b                   	pop    %ebx
80105862:	5e                   	pop    %esi
80105863:	5f                   	pop    %edi
80105864:	5d                   	pop    %ebp
80105865:	c3                   	ret    
80105866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010586d:	8d 76 00             	lea    0x0(%esi),%esi
80105870:	83 ec 0c             	sub    $0xc,%esp
80105873:	56                   	push   %esi
80105874:	31 f6                	xor    %esi,%esi
80105876:	e8 b5 ce ff ff       	call   80102730 <iunlockput>
8010587b:	83 c4 10             	add    $0x10,%esp
8010587e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105881:	89 f0                	mov    %esi,%eax
80105883:	5b                   	pop    %ebx
80105884:	5e                   	pop    %esi
80105885:	5f                   	pop    %edi
80105886:	5d                   	pop    %ebp
80105887:	c3                   	ret    
80105888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010588f:	90                   	nop
80105890:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	50                   	push   %eax
80105898:	ff 33                	push   (%ebx)
8010589a:	e8 91 ca ff ff       	call   80102330 <ialloc>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	89 c6                	mov    %eax,%esi
801058a4:	85 c0                	test   %eax,%eax
801058a6:	0f 84 cd 00 00 00    	je     80105979 <create+0x189>
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	50                   	push   %eax
801058b0:	e8 eb cb ff ff       	call   801024a0 <ilock>
801058b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801058b9:	66 89 46 52          	mov    %ax,0x52(%esi)
801058bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801058c1:	66 89 46 54          	mov    %ax,0x54(%esi)
801058c5:	b8 01 00 00 00       	mov    $0x1,%eax
801058ca:	66 89 46 56          	mov    %ax,0x56(%esi)
801058ce:	89 34 24             	mov    %esi,(%esp)
801058d1:	e8 1a cb ff ff       	call   801023f0 <iupdate>
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801058de:	74 30                	je     80105910 <create+0x120>
801058e0:	83 ec 04             	sub    $0x4,%esp
801058e3:	ff 76 04             	push   0x4(%esi)
801058e6:	57                   	push   %edi
801058e7:	53                   	push   %ebx
801058e8:	e8 13 d4 ff ff       	call   80102d00 <dirlink>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	78 78                	js     8010596c <create+0x17c>
801058f4:	83 ec 0c             	sub    $0xc,%esp
801058f7:	53                   	push   %ebx
801058f8:	e8 33 ce ff ff       	call   80102730 <iunlockput>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105903:	89 f0                	mov    %esi,%eax
80105905:	5b                   	pop    %ebx
80105906:	5e                   	pop    %esi
80105907:	5f                   	pop    %edi
80105908:	5d                   	pop    %ebp
80105909:	c3                   	ret    
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105918:	53                   	push   %ebx
80105919:	e8 d2 ca ff ff       	call   801023f0 <iupdate>
8010591e:	83 c4 0c             	add    $0xc,%esp
80105921:	ff 76 04             	push   0x4(%esi)
80105924:	68 34 86 10 80       	push   $0x80108634
80105929:	56                   	push   %esi
8010592a:	e8 d1 d3 ff ff       	call   80102d00 <dirlink>
8010592f:	83 c4 10             	add    $0x10,%esp
80105932:	85 c0                	test   %eax,%eax
80105934:	78 18                	js     8010594e <create+0x15e>
80105936:	83 ec 04             	sub    $0x4,%esp
80105939:	ff 73 04             	push   0x4(%ebx)
8010593c:	68 33 86 10 80       	push   $0x80108633
80105941:	56                   	push   %esi
80105942:	e8 b9 d3 ff ff       	call   80102d00 <dirlink>
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	85 c0                	test   %eax,%eax
8010594c:	79 92                	jns    801058e0 <create+0xf0>
8010594e:	83 ec 0c             	sub    $0xc,%esp
80105951:	68 27 86 10 80       	push   $0x80108627
80105956:	e8 95 ab ff ff       	call   801004f0 <panic>
8010595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010595f:	90                   	nop
80105960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105963:	31 f6                	xor    %esi,%esi
80105965:	5b                   	pop    %ebx
80105966:	89 f0                	mov    %esi,%eax
80105968:	5e                   	pop    %esi
80105969:	5f                   	pop    %edi
8010596a:	5d                   	pop    %ebp
8010596b:	c3                   	ret    
8010596c:	83 ec 0c             	sub    $0xc,%esp
8010596f:	68 36 86 10 80       	push   $0x80108636
80105974:	e8 77 ab ff ff       	call   801004f0 <panic>
80105979:	83 ec 0c             	sub    $0xc,%esp
8010597c:	68 18 86 10 80       	push   $0x80108618
80105981:	e8 6a ab ff ff       	call   801004f0 <panic>
80105986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010598d:	8d 76 00             	lea    0x0(%esi),%esi

80105990 <sys_dup>:
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	56                   	push   %esi
80105994:	53                   	push   %ebx
80105995:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105998:	83 ec 18             	sub    $0x18,%esp
8010599b:	50                   	push   %eax
8010599c:	6a 00                	push   $0x0
8010599e:	e8 9d fc ff ff       	call   80105640 <argint>
801059a3:	83 c4 10             	add    $0x10,%esp
801059a6:	85 c0                	test   %eax,%eax
801059a8:	78 36                	js     801059e0 <sys_dup+0x50>
801059aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059ae:	77 30                	ja     801059e0 <sys_dup+0x50>
801059b0:	e8 db ec ff ff       	call   80104690 <myproc>
801059b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059b8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059bc:	85 f6                	test   %esi,%esi
801059be:	74 20                	je     801059e0 <sys_dup+0x50>
801059c0:	e8 cb ec ff ff       	call   80104690 <myproc>
801059c5:	31 db                	xor    %ebx,%ebx
801059c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ce:	66 90                	xchg   %ax,%ax
801059d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059d4:	85 d2                	test   %edx,%edx
801059d6:	74 18                	je     801059f0 <sys_dup+0x60>
801059d8:	83 c3 01             	add    $0x1,%ebx
801059db:	83 fb 10             	cmp    $0x10,%ebx
801059de:	75 f0                	jne    801059d0 <sys_dup+0x40>
801059e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059e3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059e8:	89 d8                	mov    %ebx,%eax
801059ea:	5b                   	pop    %ebx
801059eb:	5e                   	pop    %esi
801059ec:	5d                   	pop    %ebp
801059ed:	c3                   	ret    
801059ee:	66 90                	xchg   %ax,%ax
801059f0:	83 ec 0c             	sub    $0xc,%esp
801059f3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
801059f7:	56                   	push   %esi
801059f8:	e8 c3 c1 ff ff       	call   80101bc0 <filedup>
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a03:	89 d8                	mov    %ebx,%eax
80105a05:	5b                   	pop    %ebx
80105a06:	5e                   	pop    %esi
80105a07:	5d                   	pop    %ebp
80105a08:	c3                   	ret    
80105a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a10 <sys_read>:
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	56                   	push   %esi
80105a14:	53                   	push   %ebx
80105a15:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105a18:	83 ec 18             	sub    $0x18,%esp
80105a1b:	53                   	push   %ebx
80105a1c:	6a 00                	push   $0x0
80105a1e:	e8 1d fc ff ff       	call   80105640 <argint>
80105a23:	83 c4 10             	add    $0x10,%esp
80105a26:	85 c0                	test   %eax,%eax
80105a28:	78 5e                	js     80105a88 <sys_read+0x78>
80105a2a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a2e:	77 58                	ja     80105a88 <sys_read+0x78>
80105a30:	e8 5b ec ff ff       	call   80104690 <myproc>
80105a35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a38:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a3c:	85 f6                	test   %esi,%esi
80105a3e:	74 48                	je     80105a88 <sys_read+0x78>
80105a40:	83 ec 08             	sub    $0x8,%esp
80105a43:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a46:	50                   	push   %eax
80105a47:	6a 02                	push   $0x2
80105a49:	e8 f2 fb ff ff       	call   80105640 <argint>
80105a4e:	83 c4 10             	add    $0x10,%esp
80105a51:	85 c0                	test   %eax,%eax
80105a53:	78 33                	js     80105a88 <sys_read+0x78>
80105a55:	83 ec 04             	sub    $0x4,%esp
80105a58:	ff 75 f0             	push   -0x10(%ebp)
80105a5b:	53                   	push   %ebx
80105a5c:	6a 01                	push   $0x1
80105a5e:	e8 2d fc ff ff       	call   80105690 <argptr>
80105a63:	83 c4 10             	add    $0x10,%esp
80105a66:	85 c0                	test   %eax,%eax
80105a68:	78 1e                	js     80105a88 <sys_read+0x78>
80105a6a:	83 ec 04             	sub    $0x4,%esp
80105a6d:	ff 75 f0             	push   -0x10(%ebp)
80105a70:	ff 75 f4             	push   -0xc(%ebp)
80105a73:	56                   	push   %esi
80105a74:	e8 c7 c2 ff ff       	call   80101d40 <fileread>
80105a79:	83 c4 10             	add    $0x10,%esp
80105a7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a7f:	5b                   	pop    %ebx
80105a80:	5e                   	pop    %esi
80105a81:	5d                   	pop    %ebp
80105a82:	c3                   	ret    
80105a83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a87:	90                   	nop
80105a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8d:	eb ed                	jmp    80105a7c <sys_read+0x6c>
80105a8f:	90                   	nop

80105a90 <sys_write>:
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	56                   	push   %esi
80105a94:	53                   	push   %ebx
80105a95:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105a98:	83 ec 18             	sub    $0x18,%esp
80105a9b:	53                   	push   %ebx
80105a9c:	6a 00                	push   $0x0
80105a9e:	e8 9d fb ff ff       	call   80105640 <argint>
80105aa3:	83 c4 10             	add    $0x10,%esp
80105aa6:	85 c0                	test   %eax,%eax
80105aa8:	78 5e                	js     80105b08 <sys_write+0x78>
80105aaa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105aae:	77 58                	ja     80105b08 <sys_write+0x78>
80105ab0:	e8 db eb ff ff       	call   80104690 <myproc>
80105ab5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ab8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105abc:	85 f6                	test   %esi,%esi
80105abe:	74 48                	je     80105b08 <sys_write+0x78>
80105ac0:	83 ec 08             	sub    $0x8,%esp
80105ac3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ac6:	50                   	push   %eax
80105ac7:	6a 02                	push   $0x2
80105ac9:	e8 72 fb ff ff       	call   80105640 <argint>
80105ace:	83 c4 10             	add    $0x10,%esp
80105ad1:	85 c0                	test   %eax,%eax
80105ad3:	78 33                	js     80105b08 <sys_write+0x78>
80105ad5:	83 ec 04             	sub    $0x4,%esp
80105ad8:	ff 75 f0             	push   -0x10(%ebp)
80105adb:	53                   	push   %ebx
80105adc:	6a 01                	push   $0x1
80105ade:	e8 ad fb ff ff       	call   80105690 <argptr>
80105ae3:	83 c4 10             	add    $0x10,%esp
80105ae6:	85 c0                	test   %eax,%eax
80105ae8:	78 1e                	js     80105b08 <sys_write+0x78>
80105aea:	83 ec 04             	sub    $0x4,%esp
80105aed:	ff 75 f0             	push   -0x10(%ebp)
80105af0:	ff 75 f4             	push   -0xc(%ebp)
80105af3:	56                   	push   %esi
80105af4:	e8 d7 c2 ff ff       	call   80101dd0 <filewrite>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105aff:	5b                   	pop    %ebx
80105b00:	5e                   	pop    %esi
80105b01:	5d                   	pop    %ebp
80105b02:	c3                   	ret    
80105b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b07:	90                   	nop
80105b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b0d:	eb ed                	jmp    80105afc <sys_write+0x6c>
80105b0f:	90                   	nop

80105b10 <sys_close>:
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	56                   	push   %esi
80105b14:	53                   	push   %ebx
80105b15:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b18:	83 ec 18             	sub    $0x18,%esp
80105b1b:	50                   	push   %eax
80105b1c:	6a 00                	push   $0x0
80105b1e:	e8 1d fb ff ff       	call   80105640 <argint>
80105b23:	83 c4 10             	add    $0x10,%esp
80105b26:	85 c0                	test   %eax,%eax
80105b28:	78 3e                	js     80105b68 <sys_close+0x58>
80105b2a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b2e:	77 38                	ja     80105b68 <sys_close+0x58>
80105b30:	e8 5b eb ff ff       	call   80104690 <myproc>
80105b35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b38:	8d 5a 08             	lea    0x8(%edx),%ebx
80105b3b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105b3f:	85 f6                	test   %esi,%esi
80105b41:	74 25                	je     80105b68 <sys_close+0x58>
80105b43:	e8 48 eb ff ff       	call   80104690 <myproc>
80105b48:	83 ec 0c             	sub    $0xc,%esp
80105b4b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105b52:	00 
80105b53:	56                   	push   %esi
80105b54:	e8 b7 c0 ff ff       	call   80101c10 <fileclose>
80105b59:	83 c4 10             	add    $0x10,%esp
80105b5c:	31 c0                	xor    %eax,%eax
80105b5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b61:	5b                   	pop    %ebx
80105b62:	5e                   	pop    %esi
80105b63:	5d                   	pop    %ebp
80105b64:	c3                   	ret    
80105b65:	8d 76 00             	lea    0x0(%esi),%esi
80105b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b6d:	eb ef                	jmp    80105b5e <sys_close+0x4e>
80105b6f:	90                   	nop

80105b70 <sys_fstat>:
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	56                   	push   %esi
80105b74:	53                   	push   %ebx
80105b75:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105b78:	83 ec 18             	sub    $0x18,%esp
80105b7b:	53                   	push   %ebx
80105b7c:	6a 00                	push   $0x0
80105b7e:	e8 bd fa ff ff       	call   80105640 <argint>
80105b83:	83 c4 10             	add    $0x10,%esp
80105b86:	85 c0                	test   %eax,%eax
80105b88:	78 46                	js     80105bd0 <sys_fstat+0x60>
80105b8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b8e:	77 40                	ja     80105bd0 <sys_fstat+0x60>
80105b90:	e8 fb ea ff ff       	call   80104690 <myproc>
80105b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105b9c:	85 f6                	test   %esi,%esi
80105b9e:	74 30                	je     80105bd0 <sys_fstat+0x60>
80105ba0:	83 ec 04             	sub    $0x4,%esp
80105ba3:	6a 14                	push   $0x14
80105ba5:	53                   	push   %ebx
80105ba6:	6a 01                	push   $0x1
80105ba8:	e8 e3 fa ff ff       	call   80105690 <argptr>
80105bad:	83 c4 10             	add    $0x10,%esp
80105bb0:	85 c0                	test   %eax,%eax
80105bb2:	78 1c                	js     80105bd0 <sys_fstat+0x60>
80105bb4:	83 ec 08             	sub    $0x8,%esp
80105bb7:	ff 75 f4             	push   -0xc(%ebp)
80105bba:	56                   	push   %esi
80105bbb:	e8 30 c1 ff ff       	call   80101cf0 <filestat>
80105bc0:	83 c4 10             	add    $0x10,%esp
80105bc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bc6:	5b                   	pop    %ebx
80105bc7:	5e                   	pop    %esi
80105bc8:	5d                   	pop    %ebp
80105bc9:	c3                   	ret    
80105bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bd5:	eb ec                	jmp    80105bc3 <sys_fstat+0x53>
80105bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bde:	66 90                	xchg   %ax,%ax

80105be0 <sys_link>:
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105be8:	53                   	push   %ebx
80105be9:	83 ec 34             	sub    $0x34,%esp
80105bec:	50                   	push   %eax
80105bed:	6a 00                	push   $0x0
80105bef:	e8 0c fb ff ff       	call   80105700 <argstr>
80105bf4:	83 c4 10             	add    $0x10,%esp
80105bf7:	85 c0                	test   %eax,%eax
80105bf9:	0f 88 fb 00 00 00    	js     80105cfa <sys_link+0x11a>
80105bff:	83 ec 08             	sub    $0x8,%esp
80105c02:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105c05:	50                   	push   %eax
80105c06:	6a 01                	push   $0x1
80105c08:	e8 f3 fa ff ff       	call   80105700 <argstr>
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	85 c0                	test   %eax,%eax
80105c12:	0f 88 e2 00 00 00    	js     80105cfa <sys_link+0x11a>
80105c18:	e8 63 de ff ff       	call   80103a80 <begin_op>
80105c1d:	83 ec 0c             	sub    $0xc,%esp
80105c20:	ff 75 d4             	push   -0x2c(%ebp)
80105c23:	e8 98 d1 ff ff       	call   80102dc0 <namei>
80105c28:	83 c4 10             	add    $0x10,%esp
80105c2b:	89 c3                	mov    %eax,%ebx
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	0f 84 e4 00 00 00    	je     80105d19 <sys_link+0x139>
80105c35:	83 ec 0c             	sub    $0xc,%esp
80105c38:	50                   	push   %eax
80105c39:	e8 62 c8 ff ff       	call   801024a0 <ilock>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c46:	0f 84 b5 00 00 00    	je     80105d01 <sys_link+0x121>
80105c4c:	83 ec 0c             	sub    $0xc,%esp
80105c4f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105c54:	8d 7d da             	lea    -0x26(%ebp),%edi
80105c57:	53                   	push   %ebx
80105c58:	e8 93 c7 ff ff       	call   801023f0 <iupdate>
80105c5d:	89 1c 24             	mov    %ebx,(%esp)
80105c60:	e8 1b c9 ff ff       	call   80102580 <iunlock>
80105c65:	58                   	pop    %eax
80105c66:	5a                   	pop    %edx
80105c67:	57                   	push   %edi
80105c68:	ff 75 d0             	push   -0x30(%ebp)
80105c6b:	e8 70 d1 ff ff       	call   80102de0 <nameiparent>
80105c70:	83 c4 10             	add    $0x10,%esp
80105c73:	89 c6                	mov    %eax,%esi
80105c75:	85 c0                	test   %eax,%eax
80105c77:	74 5b                	je     80105cd4 <sys_link+0xf4>
80105c79:	83 ec 0c             	sub    $0xc,%esp
80105c7c:	50                   	push   %eax
80105c7d:	e8 1e c8 ff ff       	call   801024a0 <ilock>
80105c82:	8b 03                	mov    (%ebx),%eax
80105c84:	83 c4 10             	add    $0x10,%esp
80105c87:	39 06                	cmp    %eax,(%esi)
80105c89:	75 3d                	jne    80105cc8 <sys_link+0xe8>
80105c8b:	83 ec 04             	sub    $0x4,%esp
80105c8e:	ff 73 04             	push   0x4(%ebx)
80105c91:	57                   	push   %edi
80105c92:	56                   	push   %esi
80105c93:	e8 68 d0 ff ff       	call   80102d00 <dirlink>
80105c98:	83 c4 10             	add    $0x10,%esp
80105c9b:	85 c0                	test   %eax,%eax
80105c9d:	78 29                	js     80105cc8 <sys_link+0xe8>
80105c9f:	83 ec 0c             	sub    $0xc,%esp
80105ca2:	56                   	push   %esi
80105ca3:	e8 88 ca ff ff       	call   80102730 <iunlockput>
80105ca8:	89 1c 24             	mov    %ebx,(%esp)
80105cab:	e8 20 c9 ff ff       	call   801025d0 <iput>
80105cb0:	e8 3b de ff ff       	call   80103af0 <end_op>
80105cb5:	83 c4 10             	add    $0x10,%esp
80105cb8:	31 c0                	xor    %eax,%eax
80105cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cbd:	5b                   	pop    %ebx
80105cbe:	5e                   	pop    %esi
80105cbf:	5f                   	pop    %edi
80105cc0:	5d                   	pop    %ebp
80105cc1:	c3                   	ret    
80105cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cc8:	83 ec 0c             	sub    $0xc,%esp
80105ccb:	56                   	push   %esi
80105ccc:	e8 5f ca ff ff       	call   80102730 <iunlockput>
80105cd1:	83 c4 10             	add    $0x10,%esp
80105cd4:	83 ec 0c             	sub    $0xc,%esp
80105cd7:	53                   	push   %ebx
80105cd8:	e8 c3 c7 ff ff       	call   801024a0 <ilock>
80105cdd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105ce2:	89 1c 24             	mov    %ebx,(%esp)
80105ce5:	e8 06 c7 ff ff       	call   801023f0 <iupdate>
80105cea:	89 1c 24             	mov    %ebx,(%esp)
80105ced:	e8 3e ca ff ff       	call   80102730 <iunlockput>
80105cf2:	e8 f9 dd ff ff       	call   80103af0 <end_op>
80105cf7:	83 c4 10             	add    $0x10,%esp
80105cfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cff:	eb b9                	jmp    80105cba <sys_link+0xda>
80105d01:	83 ec 0c             	sub    $0xc,%esp
80105d04:	53                   	push   %ebx
80105d05:	e8 26 ca ff ff       	call   80102730 <iunlockput>
80105d0a:	e8 e1 dd ff ff       	call   80103af0 <end_op>
80105d0f:	83 c4 10             	add    $0x10,%esp
80105d12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d17:	eb a1                	jmp    80105cba <sys_link+0xda>
80105d19:	e8 d2 dd ff ff       	call   80103af0 <end_op>
80105d1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d23:	eb 95                	jmp    80105cba <sys_link+0xda>
80105d25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d30 <sys_unlink>:
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	57                   	push   %edi
80105d34:	56                   	push   %esi
80105d35:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105d38:	53                   	push   %ebx
80105d39:	83 ec 54             	sub    $0x54,%esp
80105d3c:	50                   	push   %eax
80105d3d:	6a 00                	push   $0x0
80105d3f:	e8 bc f9 ff ff       	call   80105700 <argstr>
80105d44:	83 c4 10             	add    $0x10,%esp
80105d47:	85 c0                	test   %eax,%eax
80105d49:	0f 88 7a 01 00 00    	js     80105ec9 <sys_unlink+0x199>
80105d4f:	e8 2c dd ff ff       	call   80103a80 <begin_op>
80105d54:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105d57:	83 ec 08             	sub    $0x8,%esp
80105d5a:	53                   	push   %ebx
80105d5b:	ff 75 c0             	push   -0x40(%ebp)
80105d5e:	e8 7d d0 ff ff       	call   80102de0 <nameiparent>
80105d63:	83 c4 10             	add    $0x10,%esp
80105d66:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105d69:	85 c0                	test   %eax,%eax
80105d6b:	0f 84 62 01 00 00    	je     80105ed3 <sys_unlink+0x1a3>
80105d71:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105d74:	83 ec 0c             	sub    $0xc,%esp
80105d77:	57                   	push   %edi
80105d78:	e8 23 c7 ff ff       	call   801024a0 <ilock>
80105d7d:	58                   	pop    %eax
80105d7e:	5a                   	pop    %edx
80105d7f:	68 34 86 10 80       	push   $0x80108634
80105d84:	53                   	push   %ebx
80105d85:	e8 56 cc ff ff       	call   801029e0 <namecmp>
80105d8a:	83 c4 10             	add    $0x10,%esp
80105d8d:	85 c0                	test   %eax,%eax
80105d8f:	0f 84 fb 00 00 00    	je     80105e90 <sys_unlink+0x160>
80105d95:	83 ec 08             	sub    $0x8,%esp
80105d98:	68 33 86 10 80       	push   $0x80108633
80105d9d:	53                   	push   %ebx
80105d9e:	e8 3d cc ff ff       	call   801029e0 <namecmp>
80105da3:	83 c4 10             	add    $0x10,%esp
80105da6:	85 c0                	test   %eax,%eax
80105da8:	0f 84 e2 00 00 00    	je     80105e90 <sys_unlink+0x160>
80105dae:	83 ec 04             	sub    $0x4,%esp
80105db1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105db4:	50                   	push   %eax
80105db5:	53                   	push   %ebx
80105db6:	57                   	push   %edi
80105db7:	e8 44 cc ff ff       	call   80102a00 <dirlookup>
80105dbc:	83 c4 10             	add    $0x10,%esp
80105dbf:	89 c3                	mov    %eax,%ebx
80105dc1:	85 c0                	test   %eax,%eax
80105dc3:	0f 84 c7 00 00 00    	je     80105e90 <sys_unlink+0x160>
80105dc9:	83 ec 0c             	sub    $0xc,%esp
80105dcc:	50                   	push   %eax
80105dcd:	e8 ce c6 ff ff       	call   801024a0 <ilock>
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105dda:	0f 8e 1c 01 00 00    	jle    80105efc <sys_unlink+0x1cc>
80105de0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105de5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105de8:	74 66                	je     80105e50 <sys_unlink+0x120>
80105dea:	83 ec 04             	sub    $0x4,%esp
80105ded:	6a 10                	push   $0x10
80105def:	6a 00                	push   $0x0
80105df1:	57                   	push   %edi
80105df2:	e8 89 f5 ff ff       	call   80105380 <memset>
80105df7:	6a 10                	push   $0x10
80105df9:	ff 75 c4             	push   -0x3c(%ebp)
80105dfc:	57                   	push   %edi
80105dfd:	ff 75 b4             	push   -0x4c(%ebp)
80105e00:	e8 ab ca ff ff       	call   801028b0 <writei>
80105e05:	83 c4 20             	add    $0x20,%esp
80105e08:	83 f8 10             	cmp    $0x10,%eax
80105e0b:	0f 85 de 00 00 00    	jne    80105eef <sys_unlink+0x1bf>
80105e11:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105e16:	0f 84 94 00 00 00    	je     80105eb0 <sys_unlink+0x180>
80105e1c:	83 ec 0c             	sub    $0xc,%esp
80105e1f:	ff 75 b4             	push   -0x4c(%ebp)
80105e22:	e8 09 c9 ff ff       	call   80102730 <iunlockput>
80105e27:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105e2c:	89 1c 24             	mov    %ebx,(%esp)
80105e2f:	e8 bc c5 ff ff       	call   801023f0 <iupdate>
80105e34:	89 1c 24             	mov    %ebx,(%esp)
80105e37:	e8 f4 c8 ff ff       	call   80102730 <iunlockput>
80105e3c:	e8 af dc ff ff       	call   80103af0 <end_op>
80105e41:	83 c4 10             	add    $0x10,%esp
80105e44:	31 c0                	xor    %eax,%eax
80105e46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e49:	5b                   	pop    %ebx
80105e4a:	5e                   	pop    %esi
80105e4b:	5f                   	pop    %edi
80105e4c:	5d                   	pop    %ebp
80105e4d:	c3                   	ret    
80105e4e:	66 90                	xchg   %ax,%ax
80105e50:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105e54:	76 94                	jbe    80105dea <sys_unlink+0xba>
80105e56:	be 20 00 00 00       	mov    $0x20,%esi
80105e5b:	eb 0b                	jmp    80105e68 <sys_unlink+0x138>
80105e5d:	8d 76 00             	lea    0x0(%esi),%esi
80105e60:	83 c6 10             	add    $0x10,%esi
80105e63:	3b 73 58             	cmp    0x58(%ebx),%esi
80105e66:	73 82                	jae    80105dea <sys_unlink+0xba>
80105e68:	6a 10                	push   $0x10
80105e6a:	56                   	push   %esi
80105e6b:	57                   	push   %edi
80105e6c:	53                   	push   %ebx
80105e6d:	e8 3e c9 ff ff       	call   801027b0 <readi>
80105e72:	83 c4 10             	add    $0x10,%esp
80105e75:	83 f8 10             	cmp    $0x10,%eax
80105e78:	75 68                	jne    80105ee2 <sys_unlink+0x1b2>
80105e7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105e7f:	74 df                	je     80105e60 <sys_unlink+0x130>
80105e81:	83 ec 0c             	sub    $0xc,%esp
80105e84:	53                   	push   %ebx
80105e85:	e8 a6 c8 ff ff       	call   80102730 <iunlockput>
80105e8a:	83 c4 10             	add    $0x10,%esp
80105e8d:	8d 76 00             	lea    0x0(%esi),%esi
80105e90:	83 ec 0c             	sub    $0xc,%esp
80105e93:	ff 75 b4             	push   -0x4c(%ebp)
80105e96:	e8 95 c8 ff ff       	call   80102730 <iunlockput>
80105e9b:	e8 50 dc ff ff       	call   80103af0 <end_op>
80105ea0:	83 c4 10             	add    $0x10,%esp
80105ea3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ea8:	eb 9c                	jmp    80105e46 <sys_unlink+0x116>
80105eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105eb0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105eb3:	83 ec 0c             	sub    $0xc,%esp
80105eb6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105ebb:	50                   	push   %eax
80105ebc:	e8 2f c5 ff ff       	call   801023f0 <iupdate>
80105ec1:	83 c4 10             	add    $0x10,%esp
80105ec4:	e9 53 ff ff ff       	jmp    80105e1c <sys_unlink+0xec>
80105ec9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ece:	e9 73 ff ff ff       	jmp    80105e46 <sys_unlink+0x116>
80105ed3:	e8 18 dc ff ff       	call   80103af0 <end_op>
80105ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105edd:	e9 64 ff ff ff       	jmp    80105e46 <sys_unlink+0x116>
80105ee2:	83 ec 0c             	sub    $0xc,%esp
80105ee5:	68 58 86 10 80       	push   $0x80108658
80105eea:	e8 01 a6 ff ff       	call   801004f0 <panic>
80105eef:	83 ec 0c             	sub    $0xc,%esp
80105ef2:	68 6a 86 10 80       	push   $0x8010866a
80105ef7:	e8 f4 a5 ff ff       	call   801004f0 <panic>
80105efc:	83 ec 0c             	sub    $0xc,%esp
80105eff:	68 46 86 10 80       	push   $0x80108646
80105f04:	e8 e7 a5 ff ff       	call   801004f0 <panic>
80105f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f10 <sys_open>:
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	57                   	push   %edi
80105f14:	56                   	push   %esi
80105f15:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105f18:	53                   	push   %ebx
80105f19:	83 ec 24             	sub    $0x24,%esp
80105f1c:	50                   	push   %eax
80105f1d:	6a 00                	push   $0x0
80105f1f:	e8 dc f7 ff ff       	call   80105700 <argstr>
80105f24:	83 c4 10             	add    $0x10,%esp
80105f27:	85 c0                	test   %eax,%eax
80105f29:	0f 88 8e 00 00 00    	js     80105fbd <sys_open+0xad>
80105f2f:	83 ec 08             	sub    $0x8,%esp
80105f32:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f35:	50                   	push   %eax
80105f36:	6a 01                	push   $0x1
80105f38:	e8 03 f7 ff ff       	call   80105640 <argint>
80105f3d:	83 c4 10             	add    $0x10,%esp
80105f40:	85 c0                	test   %eax,%eax
80105f42:	78 79                	js     80105fbd <sys_open+0xad>
80105f44:	e8 37 db ff ff       	call   80103a80 <begin_op>
80105f49:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105f4d:	75 79                	jne    80105fc8 <sys_open+0xb8>
80105f4f:	83 ec 0c             	sub    $0xc,%esp
80105f52:	ff 75 e0             	push   -0x20(%ebp)
80105f55:	e8 66 ce ff ff       	call   80102dc0 <namei>
80105f5a:	83 c4 10             	add    $0x10,%esp
80105f5d:	89 c6                	mov    %eax,%esi
80105f5f:	85 c0                	test   %eax,%eax
80105f61:	0f 84 7e 00 00 00    	je     80105fe5 <sys_open+0xd5>
80105f67:	83 ec 0c             	sub    $0xc,%esp
80105f6a:	50                   	push   %eax
80105f6b:	e8 30 c5 ff ff       	call   801024a0 <ilock>
80105f70:	83 c4 10             	add    $0x10,%esp
80105f73:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105f78:	0f 84 c2 00 00 00    	je     80106040 <sys_open+0x130>
80105f7e:	e8 cd bb ff ff       	call   80101b50 <filealloc>
80105f83:	89 c7                	mov    %eax,%edi
80105f85:	85 c0                	test   %eax,%eax
80105f87:	74 23                	je     80105fac <sys_open+0x9c>
80105f89:	e8 02 e7 ff ff       	call   80104690 <myproc>
80105f8e:	31 db                	xor    %ebx,%ebx
80105f90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f94:	85 d2                	test   %edx,%edx
80105f96:	74 60                	je     80105ff8 <sys_open+0xe8>
80105f98:	83 c3 01             	add    $0x1,%ebx
80105f9b:	83 fb 10             	cmp    $0x10,%ebx
80105f9e:	75 f0                	jne    80105f90 <sys_open+0x80>
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	57                   	push   %edi
80105fa4:	e8 67 bc ff ff       	call   80101c10 <fileclose>
80105fa9:	83 c4 10             	add    $0x10,%esp
80105fac:	83 ec 0c             	sub    $0xc,%esp
80105faf:	56                   	push   %esi
80105fb0:	e8 7b c7 ff ff       	call   80102730 <iunlockput>
80105fb5:	e8 36 db ff ff       	call   80103af0 <end_op>
80105fba:	83 c4 10             	add    $0x10,%esp
80105fbd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fc2:	eb 6d                	jmp    80106031 <sys_open+0x121>
80105fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fc8:	83 ec 0c             	sub    $0xc,%esp
80105fcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105fce:	31 c9                	xor    %ecx,%ecx
80105fd0:	ba 02 00 00 00       	mov    $0x2,%edx
80105fd5:	6a 00                	push   $0x0
80105fd7:	e8 14 f8 ff ff       	call   801057f0 <create>
80105fdc:	83 c4 10             	add    $0x10,%esp
80105fdf:	89 c6                	mov    %eax,%esi
80105fe1:	85 c0                	test   %eax,%eax
80105fe3:	75 99                	jne    80105f7e <sys_open+0x6e>
80105fe5:	e8 06 db ff ff       	call   80103af0 <end_op>
80105fea:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fef:	eb 40                	jmp    80106031 <sys_open+0x121>
80105ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ff8:	83 ec 0c             	sub    $0xc,%esp
80105ffb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105fff:	56                   	push   %esi
80106000:	e8 7b c5 ff ff       	call   80102580 <iunlock>
80106005:	e8 e6 da ff ff       	call   80103af0 <end_op>
8010600a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80106010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106013:	83 c4 10             	add    $0x10,%esp
80106016:	89 77 10             	mov    %esi,0x10(%edi)
80106019:	89 d0                	mov    %edx,%eax
8010601b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80106022:	f7 d0                	not    %eax
80106024:	83 e0 01             	and    $0x1,%eax
80106027:	83 e2 03             	and    $0x3,%edx
8010602a:	88 47 08             	mov    %al,0x8(%edi)
8010602d:	0f 95 47 09          	setne  0x9(%edi)
80106031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106034:	89 d8                	mov    %ebx,%eax
80106036:	5b                   	pop    %ebx
80106037:	5e                   	pop    %esi
80106038:	5f                   	pop    %edi
80106039:	5d                   	pop    %ebp
8010603a:	c3                   	ret    
8010603b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010603f:	90                   	nop
80106040:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106043:	85 c9                	test   %ecx,%ecx
80106045:	0f 84 33 ff ff ff    	je     80105f7e <sys_open+0x6e>
8010604b:	e9 5c ff ff ff       	jmp    80105fac <sys_open+0x9c>

80106050 <sys_mkdir>:
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 18             	sub    $0x18,%esp
80106056:	e8 25 da ff ff       	call   80103a80 <begin_op>
8010605b:	83 ec 08             	sub    $0x8,%esp
8010605e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106061:	50                   	push   %eax
80106062:	6a 00                	push   $0x0
80106064:	e8 97 f6 ff ff       	call   80105700 <argstr>
80106069:	83 c4 10             	add    $0x10,%esp
8010606c:	85 c0                	test   %eax,%eax
8010606e:	78 30                	js     801060a0 <sys_mkdir+0x50>
80106070:	83 ec 0c             	sub    $0xc,%esp
80106073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106076:	31 c9                	xor    %ecx,%ecx
80106078:	ba 01 00 00 00       	mov    $0x1,%edx
8010607d:	6a 00                	push   $0x0
8010607f:	e8 6c f7 ff ff       	call   801057f0 <create>
80106084:	83 c4 10             	add    $0x10,%esp
80106087:	85 c0                	test   %eax,%eax
80106089:	74 15                	je     801060a0 <sys_mkdir+0x50>
8010608b:	83 ec 0c             	sub    $0xc,%esp
8010608e:	50                   	push   %eax
8010608f:	e8 9c c6 ff ff       	call   80102730 <iunlockput>
80106094:	e8 57 da ff ff       	call   80103af0 <end_op>
80106099:	83 c4 10             	add    $0x10,%esp
8010609c:	31 c0                	xor    %eax,%eax
8010609e:	c9                   	leave  
8010609f:	c3                   	ret    
801060a0:	e8 4b da ff ff       	call   80103af0 <end_op>
801060a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060aa:	c9                   	leave  
801060ab:	c3                   	ret    
801060ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060b0 <sys_mknod>:
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	83 ec 18             	sub    $0x18,%esp
801060b6:	e8 c5 d9 ff ff       	call   80103a80 <begin_op>
801060bb:	83 ec 08             	sub    $0x8,%esp
801060be:	8d 45 ec             	lea    -0x14(%ebp),%eax
801060c1:	50                   	push   %eax
801060c2:	6a 00                	push   $0x0
801060c4:	e8 37 f6 ff ff       	call   80105700 <argstr>
801060c9:	83 c4 10             	add    $0x10,%esp
801060cc:	85 c0                	test   %eax,%eax
801060ce:	78 60                	js     80106130 <sys_mknod+0x80>
801060d0:	83 ec 08             	sub    $0x8,%esp
801060d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060d6:	50                   	push   %eax
801060d7:	6a 01                	push   $0x1
801060d9:	e8 62 f5 ff ff       	call   80105640 <argint>
801060de:	83 c4 10             	add    $0x10,%esp
801060e1:	85 c0                	test   %eax,%eax
801060e3:	78 4b                	js     80106130 <sys_mknod+0x80>
801060e5:	83 ec 08             	sub    $0x8,%esp
801060e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060eb:	50                   	push   %eax
801060ec:	6a 02                	push   $0x2
801060ee:	e8 4d f5 ff ff       	call   80105640 <argint>
801060f3:	83 c4 10             	add    $0x10,%esp
801060f6:	85 c0                	test   %eax,%eax
801060f8:	78 36                	js     80106130 <sys_mknod+0x80>
801060fa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801060fe:	83 ec 0c             	sub    $0xc,%esp
80106101:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106105:	ba 03 00 00 00       	mov    $0x3,%edx
8010610a:	50                   	push   %eax
8010610b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010610e:	e8 dd f6 ff ff       	call   801057f0 <create>
80106113:	83 c4 10             	add    $0x10,%esp
80106116:	85 c0                	test   %eax,%eax
80106118:	74 16                	je     80106130 <sys_mknod+0x80>
8010611a:	83 ec 0c             	sub    $0xc,%esp
8010611d:	50                   	push   %eax
8010611e:	e8 0d c6 ff ff       	call   80102730 <iunlockput>
80106123:	e8 c8 d9 ff ff       	call   80103af0 <end_op>
80106128:	83 c4 10             	add    $0x10,%esp
8010612b:	31 c0                	xor    %eax,%eax
8010612d:	c9                   	leave  
8010612e:	c3                   	ret    
8010612f:	90                   	nop
80106130:	e8 bb d9 ff ff       	call   80103af0 <end_op>
80106135:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010613a:	c9                   	leave  
8010613b:	c3                   	ret    
8010613c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106140 <sys_chdir>:
80106140:	55                   	push   %ebp
80106141:	89 e5                	mov    %esp,%ebp
80106143:	56                   	push   %esi
80106144:	53                   	push   %ebx
80106145:	83 ec 10             	sub    $0x10,%esp
80106148:	e8 43 e5 ff ff       	call   80104690 <myproc>
8010614d:	89 c6                	mov    %eax,%esi
8010614f:	e8 2c d9 ff ff       	call   80103a80 <begin_op>
80106154:	83 ec 08             	sub    $0x8,%esp
80106157:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010615a:	50                   	push   %eax
8010615b:	6a 00                	push   $0x0
8010615d:	e8 9e f5 ff ff       	call   80105700 <argstr>
80106162:	83 c4 10             	add    $0x10,%esp
80106165:	85 c0                	test   %eax,%eax
80106167:	78 77                	js     801061e0 <sys_chdir+0xa0>
80106169:	83 ec 0c             	sub    $0xc,%esp
8010616c:	ff 75 f4             	push   -0xc(%ebp)
8010616f:	e8 4c cc ff ff       	call   80102dc0 <namei>
80106174:	83 c4 10             	add    $0x10,%esp
80106177:	89 c3                	mov    %eax,%ebx
80106179:	85 c0                	test   %eax,%eax
8010617b:	74 63                	je     801061e0 <sys_chdir+0xa0>
8010617d:	83 ec 0c             	sub    $0xc,%esp
80106180:	50                   	push   %eax
80106181:	e8 1a c3 ff ff       	call   801024a0 <ilock>
80106186:	83 c4 10             	add    $0x10,%esp
80106189:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010618e:	75 30                	jne    801061c0 <sys_chdir+0x80>
80106190:	83 ec 0c             	sub    $0xc,%esp
80106193:	53                   	push   %ebx
80106194:	e8 e7 c3 ff ff       	call   80102580 <iunlock>
80106199:	58                   	pop    %eax
8010619a:	ff 76 68             	push   0x68(%esi)
8010619d:	e8 2e c4 ff ff       	call   801025d0 <iput>
801061a2:	e8 49 d9 ff ff       	call   80103af0 <end_op>
801061a7:	89 5e 68             	mov    %ebx,0x68(%esi)
801061aa:	83 c4 10             	add    $0x10,%esp
801061ad:	31 c0                	xor    %eax,%eax
801061af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061b2:	5b                   	pop    %ebx
801061b3:	5e                   	pop    %esi
801061b4:	5d                   	pop    %ebp
801061b5:	c3                   	ret    
801061b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061bd:	8d 76 00             	lea    0x0(%esi),%esi
801061c0:	83 ec 0c             	sub    $0xc,%esp
801061c3:	53                   	push   %ebx
801061c4:	e8 67 c5 ff ff       	call   80102730 <iunlockput>
801061c9:	e8 22 d9 ff ff       	call   80103af0 <end_op>
801061ce:	83 c4 10             	add    $0x10,%esp
801061d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061d6:	eb d7                	jmp    801061af <sys_chdir+0x6f>
801061d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061df:	90                   	nop
801061e0:	e8 0b d9 ff ff       	call   80103af0 <end_op>
801061e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061ea:	eb c3                	jmp    801061af <sys_chdir+0x6f>
801061ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061f0 <sys_exec>:
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	57                   	push   %edi
801061f4:	56                   	push   %esi
801061f5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801061fb:	53                   	push   %ebx
801061fc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80106202:	50                   	push   %eax
80106203:	6a 00                	push   $0x0
80106205:	e8 f6 f4 ff ff       	call   80105700 <argstr>
8010620a:	83 c4 10             	add    $0x10,%esp
8010620d:	85 c0                	test   %eax,%eax
8010620f:	0f 88 87 00 00 00    	js     8010629c <sys_exec+0xac>
80106215:	83 ec 08             	sub    $0x8,%esp
80106218:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010621e:	50                   	push   %eax
8010621f:	6a 01                	push   $0x1
80106221:	e8 1a f4 ff ff       	call   80105640 <argint>
80106226:	83 c4 10             	add    $0x10,%esp
80106229:	85 c0                	test   %eax,%eax
8010622b:	78 6f                	js     8010629c <sys_exec+0xac>
8010622d:	83 ec 04             	sub    $0x4,%esp
80106230:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80106236:	31 db                	xor    %ebx,%ebx
80106238:	68 80 00 00 00       	push   $0x80
8010623d:	6a 00                	push   $0x0
8010623f:	56                   	push   %esi
80106240:	e8 3b f1 ff ff       	call   80105380 <memset>
80106245:	83 c4 10             	add    $0x10,%esp
80106248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010624f:	90                   	nop
80106250:	83 ec 08             	sub    $0x8,%esp
80106253:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106259:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106260:	50                   	push   %eax
80106261:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106267:	01 f8                	add    %edi,%eax
80106269:	50                   	push   %eax
8010626a:	e8 41 f3 ff ff       	call   801055b0 <fetchint>
8010626f:	83 c4 10             	add    $0x10,%esp
80106272:	85 c0                	test   %eax,%eax
80106274:	78 26                	js     8010629c <sys_exec+0xac>
80106276:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010627c:	85 c0                	test   %eax,%eax
8010627e:	74 30                	je     801062b0 <sys_exec+0xc0>
80106280:	83 ec 08             	sub    $0x8,%esp
80106283:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106286:	52                   	push   %edx
80106287:	50                   	push   %eax
80106288:	e8 63 f3 ff ff       	call   801055f0 <fetchstr>
8010628d:	83 c4 10             	add    $0x10,%esp
80106290:	85 c0                	test   %eax,%eax
80106292:	78 08                	js     8010629c <sys_exec+0xac>
80106294:	83 c3 01             	add    $0x1,%ebx
80106297:	83 fb 20             	cmp    $0x20,%ebx
8010629a:	75 b4                	jne    80106250 <sys_exec+0x60>
8010629c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010629f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a4:	5b                   	pop    %ebx
801062a5:	5e                   	pop    %esi
801062a6:	5f                   	pop    %edi
801062a7:	5d                   	pop    %ebp
801062a8:	c3                   	ret    
801062a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062b0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801062b7:	00 00 00 00 
801062bb:	83 ec 08             	sub    $0x8,%esp
801062be:	56                   	push   %esi
801062bf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801062c5:	e8 06 b5 ff ff       	call   801017d0 <exec>
801062ca:	83 c4 10             	add    $0x10,%esp
801062cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062d0:	5b                   	pop    %ebx
801062d1:	5e                   	pop    %esi
801062d2:	5f                   	pop    %edi
801062d3:	5d                   	pop    %ebp
801062d4:	c3                   	ret    
801062d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062e0 <sys_pipe>:
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	57                   	push   %edi
801062e4:	56                   	push   %esi
801062e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
801062e8:	53                   	push   %ebx
801062e9:	83 ec 20             	sub    $0x20,%esp
801062ec:	6a 08                	push   $0x8
801062ee:	50                   	push   %eax
801062ef:	6a 00                	push   $0x0
801062f1:	e8 9a f3 ff ff       	call   80105690 <argptr>
801062f6:	83 c4 10             	add    $0x10,%esp
801062f9:	85 c0                	test   %eax,%eax
801062fb:	78 4a                	js     80106347 <sys_pipe+0x67>
801062fd:	83 ec 08             	sub    $0x8,%esp
80106300:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106303:	50                   	push   %eax
80106304:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106307:	50                   	push   %eax
80106308:	e8 43 de ff ff       	call   80104150 <pipealloc>
8010630d:	83 c4 10             	add    $0x10,%esp
80106310:	85 c0                	test   %eax,%eax
80106312:	78 33                	js     80106347 <sys_pipe+0x67>
80106314:	8b 7d e0             	mov    -0x20(%ebp),%edi
80106317:	31 db                	xor    %ebx,%ebx
80106319:	e8 72 e3 ff ff       	call   80104690 <myproc>
8010631e:	66 90                	xchg   %ax,%ax
80106320:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106324:	85 f6                	test   %esi,%esi
80106326:	74 28                	je     80106350 <sys_pipe+0x70>
80106328:	83 c3 01             	add    $0x1,%ebx
8010632b:	83 fb 10             	cmp    $0x10,%ebx
8010632e:	75 f0                	jne    80106320 <sys_pipe+0x40>
80106330:	83 ec 0c             	sub    $0xc,%esp
80106333:	ff 75 e0             	push   -0x20(%ebp)
80106336:	e8 d5 b8 ff ff       	call   80101c10 <fileclose>
8010633b:	58                   	pop    %eax
8010633c:	ff 75 e4             	push   -0x1c(%ebp)
8010633f:	e8 cc b8 ff ff       	call   80101c10 <fileclose>
80106344:	83 c4 10             	add    $0x10,%esp
80106347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010634c:	eb 53                	jmp    801063a1 <sys_pipe+0xc1>
8010634e:	66 90                	xchg   %ax,%ax
80106350:	8d 73 08             	lea    0x8(%ebx),%esi
80106353:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80106357:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010635a:	e8 31 e3 ff ff       	call   80104690 <myproc>
8010635f:	31 d2                	xor    %edx,%edx
80106361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106368:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010636c:	85 c9                	test   %ecx,%ecx
8010636e:	74 20                	je     80106390 <sys_pipe+0xb0>
80106370:	83 c2 01             	add    $0x1,%edx
80106373:	83 fa 10             	cmp    $0x10,%edx
80106376:	75 f0                	jne    80106368 <sys_pipe+0x88>
80106378:	e8 13 e3 ff ff       	call   80104690 <myproc>
8010637d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106384:	00 
80106385:	eb a9                	jmp    80106330 <sys_pipe+0x50>
80106387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010638e:	66 90                	xchg   %ax,%ax
80106390:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80106394:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106397:	89 18                	mov    %ebx,(%eax)
80106399:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010639c:	89 50 04             	mov    %edx,0x4(%eax)
8010639f:	31 c0                	xor    %eax,%eax
801063a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063a4:	5b                   	pop    %ebx
801063a5:	5e                   	pop    %esi
801063a6:	5f                   	pop    %edi
801063a7:	5d                   	pop    %ebp
801063a8:	c3                   	ret    
801063a9:	66 90                	xchg   %ax,%ax
801063ab:	66 90                	xchg   %ax,%ax
801063ad:	66 90                	xchg   %ax,%ax
801063af:	90                   	nop

801063b0 <sys_fork>:
801063b0:	e9 7b e4 ff ff       	jmp    80104830 <fork>
801063b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801063c0 <sys_exit>:
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	83 ec 08             	sub    $0x8,%esp
801063c6:	e8 e5 e6 ff ff       	call   80104ab0 <exit>
801063cb:	31 c0                	xor    %eax,%eax
801063cd:	c9                   	leave  
801063ce:	c3                   	ret    
801063cf:	90                   	nop

801063d0 <sys_wait>:
801063d0:	e9 0b e8 ff ff       	jmp    80104be0 <wait>
801063d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801063e0 <sys_kill>:
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 20             	sub    $0x20,%esp
801063e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063e9:	50                   	push   %eax
801063ea:	6a 00                	push   $0x0
801063ec:	e8 4f f2 ff ff       	call   80105640 <argint>
801063f1:	83 c4 10             	add    $0x10,%esp
801063f4:	85 c0                	test   %eax,%eax
801063f6:	78 18                	js     80106410 <sys_kill+0x30>
801063f8:	83 ec 0c             	sub    $0xc,%esp
801063fb:	ff 75 f4             	push   -0xc(%ebp)
801063fe:	e8 7d ea ff ff       	call   80104e80 <kill>
80106403:	83 c4 10             	add    $0x10,%esp
80106406:	c9                   	leave  
80106407:	c3                   	ret    
80106408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010640f:	90                   	nop
80106410:	c9                   	leave  
80106411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106416:	c3                   	ret    
80106417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010641e:	66 90                	xchg   %ax,%ax

80106420 <sys_getpid>:
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	83 ec 08             	sub    $0x8,%esp
80106426:	e8 65 e2 ff ff       	call   80104690 <myproc>
8010642b:	8b 40 10             	mov    0x10(%eax),%eax
8010642e:	c9                   	leave  
8010642f:	c3                   	ret    

80106430 <sys_sbrk>:
80106430:	55                   	push   %ebp
80106431:	89 e5                	mov    %esp,%ebp
80106433:	53                   	push   %ebx
80106434:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106437:	83 ec 1c             	sub    $0x1c,%esp
8010643a:	50                   	push   %eax
8010643b:	6a 00                	push   $0x0
8010643d:	e8 fe f1 ff ff       	call   80105640 <argint>
80106442:	83 c4 10             	add    $0x10,%esp
80106445:	85 c0                	test   %eax,%eax
80106447:	78 27                	js     80106470 <sys_sbrk+0x40>
80106449:	e8 42 e2 ff ff       	call   80104690 <myproc>
8010644e:	83 ec 0c             	sub    $0xc,%esp
80106451:	8b 18                	mov    (%eax),%ebx
80106453:	ff 75 f4             	push   -0xc(%ebp)
80106456:	e8 55 e3 ff ff       	call   801047b0 <growproc>
8010645b:	83 c4 10             	add    $0x10,%esp
8010645e:	85 c0                	test   %eax,%eax
80106460:	78 0e                	js     80106470 <sys_sbrk+0x40>
80106462:	89 d8                	mov    %ebx,%eax
80106464:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106467:	c9                   	leave  
80106468:	c3                   	ret    
80106469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106470:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106475:	eb eb                	jmp    80106462 <sys_sbrk+0x32>
80106477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_sleep>:
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	53                   	push   %ebx
80106484:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106487:	83 ec 1c             	sub    $0x1c,%esp
8010648a:	50                   	push   %eax
8010648b:	6a 00                	push   $0x0
8010648d:	e8 ae f1 ff ff       	call   80105640 <argint>
80106492:	83 c4 10             	add    $0x10,%esp
80106495:	85 c0                	test   %eax,%eax
80106497:	0f 88 8a 00 00 00    	js     80106527 <sys_sleep+0xa7>
8010649d:	83 ec 0c             	sub    $0xc,%esp
801064a0:	68 c0 52 11 80       	push   $0x801152c0
801064a5:	e8 16 ee ff ff       	call   801052c0 <acquire>
801064aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064ad:	8b 1d a0 52 11 80    	mov    0x801152a0,%ebx
801064b3:	83 c4 10             	add    $0x10,%esp
801064b6:	85 d2                	test   %edx,%edx
801064b8:	75 27                	jne    801064e1 <sys_sleep+0x61>
801064ba:	eb 54                	jmp    80106510 <sys_sleep+0x90>
801064bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064c0:	83 ec 08             	sub    $0x8,%esp
801064c3:	68 c0 52 11 80       	push   $0x801152c0
801064c8:	68 a0 52 11 80       	push   $0x801152a0
801064cd:	e8 8e e8 ff ff       	call   80104d60 <sleep>
801064d2:	a1 a0 52 11 80       	mov    0x801152a0,%eax
801064d7:	83 c4 10             	add    $0x10,%esp
801064da:	29 d8                	sub    %ebx,%eax
801064dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801064df:	73 2f                	jae    80106510 <sys_sleep+0x90>
801064e1:	e8 aa e1 ff ff       	call   80104690 <myproc>
801064e6:	8b 40 24             	mov    0x24(%eax),%eax
801064e9:	85 c0                	test   %eax,%eax
801064eb:	74 d3                	je     801064c0 <sys_sleep+0x40>
801064ed:	83 ec 0c             	sub    $0xc,%esp
801064f0:	68 c0 52 11 80       	push   $0x801152c0
801064f5:	e8 66 ed ff ff       	call   80105260 <release>
801064fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064fd:	83 c4 10             	add    $0x10,%esp
80106500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106505:	c9                   	leave  
80106506:	c3                   	ret    
80106507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010650e:	66 90                	xchg   %ax,%ax
80106510:	83 ec 0c             	sub    $0xc,%esp
80106513:	68 c0 52 11 80       	push   $0x801152c0
80106518:	e8 43 ed ff ff       	call   80105260 <release>
8010651d:	83 c4 10             	add    $0x10,%esp
80106520:	31 c0                	xor    %eax,%eax
80106522:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106525:	c9                   	leave  
80106526:	c3                   	ret    
80106527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010652c:	eb f4                	jmp    80106522 <sys_sleep+0xa2>
8010652e:	66 90                	xchg   %ax,%ax

80106530 <sys_uptime>:
80106530:	55                   	push   %ebp
80106531:	89 e5                	mov    %esp,%ebp
80106533:	53                   	push   %ebx
80106534:	83 ec 10             	sub    $0x10,%esp
80106537:	68 c0 52 11 80       	push   $0x801152c0
8010653c:	e8 7f ed ff ff       	call   801052c0 <acquire>
80106541:	8b 1d a0 52 11 80    	mov    0x801152a0,%ebx
80106547:	c7 04 24 c0 52 11 80 	movl   $0x801152c0,(%esp)
8010654e:	e8 0d ed ff ff       	call   80105260 <release>
80106553:	89 d8                	mov    %ebx,%eax
80106555:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106558:	c9                   	leave  
80106559:	c3                   	ret    

8010655a <alltraps>:
8010655a:	1e                   	push   %ds
8010655b:	06                   	push   %es
8010655c:	0f a0                	push   %fs
8010655e:	0f a8                	push   %gs
80106560:	60                   	pusha  
80106561:	66 b8 10 00          	mov    $0x10,%ax
80106565:	8e d8                	mov    %eax,%ds
80106567:	8e c0                	mov    %eax,%es
80106569:	54                   	push   %esp
8010656a:	e8 c1 00 00 00       	call   80106630 <trap>
8010656f:	83 c4 04             	add    $0x4,%esp

80106572 <trapret>:
80106572:	61                   	popa   
80106573:	0f a9                	pop    %gs
80106575:	0f a1                	pop    %fs
80106577:	07                   	pop    %es
80106578:	1f                   	pop    %ds
80106579:	83 c4 08             	add    $0x8,%esp
8010657c:	cf                   	iret   
8010657d:	66 90                	xchg   %ax,%ax
8010657f:	90                   	nop

80106580 <tvinit>:
80106580:	55                   	push   %ebp
80106581:	31 c0                	xor    %eax,%eax
80106583:	89 e5                	mov    %esp,%ebp
80106585:	83 ec 08             	sub    $0x8,%esp
80106588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010658f:	90                   	nop
80106590:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106597:	c7 04 c5 02 53 11 80 	movl   $0x8e000008,-0x7feeacfe(,%eax,8)
8010659e:	08 00 00 8e 
801065a2:	66 89 14 c5 00 53 11 	mov    %dx,-0x7feead00(,%eax,8)
801065a9:	80 
801065aa:	c1 ea 10             	shr    $0x10,%edx
801065ad:	66 89 14 c5 06 53 11 	mov    %dx,-0x7feeacfa(,%eax,8)
801065b4:	80 
801065b5:	83 c0 01             	add    $0x1,%eax
801065b8:	3d 00 01 00 00       	cmp    $0x100,%eax
801065bd:	75 d1                	jne    80106590 <tvinit+0x10>
801065bf:	83 ec 08             	sub    $0x8,%esp
801065c2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801065c7:	c7 05 02 55 11 80 08 	movl   $0xef000008,0x80115502
801065ce:	00 00 ef 
801065d1:	68 79 86 10 80       	push   $0x80108679
801065d6:	68 c0 52 11 80       	push   $0x801152c0
801065db:	66 a3 00 55 11 80    	mov    %ax,0x80115500
801065e1:	c1 e8 10             	shr    $0x10,%eax
801065e4:	66 a3 06 55 11 80    	mov    %ax,0x80115506
801065ea:	e8 01 eb ff ff       	call   801050f0 <initlock>
801065ef:	83 c4 10             	add    $0x10,%esp
801065f2:	c9                   	leave  
801065f3:	c3                   	ret    
801065f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065ff:	90                   	nop

80106600 <idtinit>:
80106600:	55                   	push   %ebp
80106601:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106606:	89 e5                	mov    %esp,%ebp
80106608:	83 ec 10             	sub    $0x10,%esp
8010660b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
8010660f:	b8 00 53 11 80       	mov    $0x80115300,%eax
80106614:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106618:	c1 e8 10             	shr    $0x10,%eax
8010661b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
8010661f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106622:	0f 01 18             	lidtl  (%eax)
80106625:	c9                   	leave  
80106626:	c3                   	ret    
80106627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010662e:	66 90                	xchg   %ax,%ax

80106630 <trap>:
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	57                   	push   %edi
80106634:	56                   	push   %esi
80106635:	53                   	push   %ebx
80106636:	83 ec 1c             	sub    $0x1c,%esp
80106639:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010663c:	8b 43 30             	mov    0x30(%ebx),%eax
8010663f:	83 f8 40             	cmp    $0x40,%eax
80106642:	0f 84 68 01 00 00    	je     801067b0 <trap+0x180>
80106648:	83 e8 20             	sub    $0x20,%eax
8010664b:	83 f8 1f             	cmp    $0x1f,%eax
8010664e:	0f 87 8c 00 00 00    	ja     801066e0 <trap+0xb0>
80106654:	ff 24 85 20 87 10 80 	jmp    *-0x7fef78e0(,%eax,4)
8010665b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010665f:	90                   	nop
80106660:	e8 fb c8 ff ff       	call   80102f60 <ideintr>
80106665:	e8 c6 cf ff ff       	call   80103630 <lapiceoi>
8010666a:	e8 21 e0 ff ff       	call   80104690 <myproc>
8010666f:	85 c0                	test   %eax,%eax
80106671:	74 1d                	je     80106690 <trap+0x60>
80106673:	e8 18 e0 ff ff       	call   80104690 <myproc>
80106678:	8b 50 24             	mov    0x24(%eax),%edx
8010667b:	85 d2                	test   %edx,%edx
8010667d:	74 11                	je     80106690 <trap+0x60>
8010667f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106683:	83 e0 03             	and    $0x3,%eax
80106686:	66 83 f8 03          	cmp    $0x3,%ax
8010668a:	0f 84 e8 01 00 00    	je     80106878 <trap+0x248>
80106690:	e8 fb df ff ff       	call   80104690 <myproc>
80106695:	85 c0                	test   %eax,%eax
80106697:	74 0f                	je     801066a8 <trap+0x78>
80106699:	e8 f2 df ff ff       	call   80104690 <myproc>
8010669e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801066a2:	0f 84 b8 00 00 00    	je     80106760 <trap+0x130>
801066a8:	e8 e3 df ff ff       	call   80104690 <myproc>
801066ad:	85 c0                	test   %eax,%eax
801066af:	74 1d                	je     801066ce <trap+0x9e>
801066b1:	e8 da df ff ff       	call   80104690 <myproc>
801066b6:	8b 40 24             	mov    0x24(%eax),%eax
801066b9:	85 c0                	test   %eax,%eax
801066bb:	74 11                	je     801066ce <trap+0x9e>
801066bd:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801066c1:	83 e0 03             	and    $0x3,%eax
801066c4:	66 83 f8 03          	cmp    $0x3,%ax
801066c8:	0f 84 0f 01 00 00    	je     801067dd <trap+0x1ad>
801066ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066d1:	5b                   	pop    %ebx
801066d2:	5e                   	pop    %esi
801066d3:	5f                   	pop    %edi
801066d4:	5d                   	pop    %ebp
801066d5:	c3                   	ret    
801066d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066dd:	8d 76 00             	lea    0x0(%esi),%esi
801066e0:	e8 ab df ff ff       	call   80104690 <myproc>
801066e5:	8b 7b 38             	mov    0x38(%ebx),%edi
801066e8:	85 c0                	test   %eax,%eax
801066ea:	0f 84 a2 01 00 00    	je     80106892 <trap+0x262>
801066f0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801066f4:	0f 84 98 01 00 00    	je     80106892 <trap+0x262>
801066fa:	0f 20 d1             	mov    %cr2,%ecx
801066fd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106700:	e8 6b df ff ff       	call   80104670 <cpuid>
80106705:	8b 73 30             	mov    0x30(%ebx),%esi
80106708:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010670b:	8b 43 34             	mov    0x34(%ebx),%eax
8010670e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106711:	e8 7a df ff ff       	call   80104690 <myproc>
80106716:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106719:	e8 72 df ff ff       	call   80104690 <myproc>
8010671e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106721:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106724:	51                   	push   %ecx
80106725:	57                   	push   %edi
80106726:	52                   	push   %edx
80106727:	ff 75 e4             	push   -0x1c(%ebp)
8010672a:	56                   	push   %esi
8010672b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010672e:	83 c6 6c             	add    $0x6c,%esi
80106731:	56                   	push   %esi
80106732:	ff 70 10             	push   0x10(%eax)
80106735:	68 dc 86 10 80       	push   $0x801086dc
8010673a:	e8 31 a3 ff ff       	call   80100a70 <cprintf>
8010673f:	83 c4 20             	add    $0x20,%esp
80106742:	e8 49 df ff ff       	call   80104690 <myproc>
80106747:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010674e:	e8 3d df ff ff       	call   80104690 <myproc>
80106753:	85 c0                	test   %eax,%eax
80106755:	0f 85 18 ff ff ff    	jne    80106673 <trap+0x43>
8010675b:	e9 30 ff ff ff       	jmp    80106690 <trap+0x60>
80106760:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106764:	0f 85 3e ff ff ff    	jne    801066a8 <trap+0x78>
8010676a:	e8 a1 e5 ff ff       	call   80104d10 <yield>
8010676f:	e9 34 ff ff ff       	jmp    801066a8 <trap+0x78>
80106774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106778:	8b 7b 38             	mov    0x38(%ebx),%edi
8010677b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010677f:	e8 ec de ff ff       	call   80104670 <cpuid>
80106784:	57                   	push   %edi
80106785:	56                   	push   %esi
80106786:	50                   	push   %eax
80106787:	68 84 86 10 80       	push   $0x80108684
8010678c:	e8 df a2 ff ff       	call   80100a70 <cprintf>
80106791:	e8 9a ce ff ff       	call   80103630 <lapiceoi>
80106796:	83 c4 10             	add    $0x10,%esp
80106799:	e8 f2 de ff ff       	call   80104690 <myproc>
8010679e:	85 c0                	test   %eax,%eax
801067a0:	0f 85 cd fe ff ff    	jne    80106673 <trap+0x43>
801067a6:	e9 e5 fe ff ff       	jmp    80106690 <trap+0x60>
801067ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067af:	90                   	nop
801067b0:	e8 db de ff ff       	call   80104690 <myproc>
801067b5:	8b 70 24             	mov    0x24(%eax),%esi
801067b8:	85 f6                	test   %esi,%esi
801067ba:	0f 85 c8 00 00 00    	jne    80106888 <trap+0x258>
801067c0:	e8 cb de ff ff       	call   80104690 <myproc>
801067c5:	89 58 18             	mov    %ebx,0x18(%eax)
801067c8:	e8 b3 ef ff ff       	call   80105780 <syscall>
801067cd:	e8 be de ff ff       	call   80104690 <myproc>
801067d2:	8b 48 24             	mov    0x24(%eax),%ecx
801067d5:	85 c9                	test   %ecx,%ecx
801067d7:	0f 84 f1 fe ff ff    	je     801066ce <trap+0x9e>
801067dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067e0:	5b                   	pop    %ebx
801067e1:	5e                   	pop    %esi
801067e2:	5f                   	pop    %edi
801067e3:	5d                   	pop    %ebp
801067e4:	e9 c7 e2 ff ff       	jmp    80104ab0 <exit>
801067e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067f0:	e8 3b 02 00 00       	call   80106a30 <uartintr>
801067f5:	e8 36 ce ff ff       	call   80103630 <lapiceoi>
801067fa:	e8 91 de ff ff       	call   80104690 <myproc>
801067ff:	85 c0                	test   %eax,%eax
80106801:	0f 85 6c fe ff ff    	jne    80106673 <trap+0x43>
80106807:	e9 84 fe ff ff       	jmp    80106690 <trap+0x60>
8010680c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106810:	e8 db cc ff ff       	call   801034f0 <kbdintr>
80106815:	e8 16 ce ff ff       	call   80103630 <lapiceoi>
8010681a:	e8 71 de ff ff       	call   80104690 <myproc>
8010681f:	85 c0                	test   %eax,%eax
80106821:	0f 85 4c fe ff ff    	jne    80106673 <trap+0x43>
80106827:	e9 64 fe ff ff       	jmp    80106690 <trap+0x60>
8010682c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106830:	e8 3b de ff ff       	call   80104670 <cpuid>
80106835:	85 c0                	test   %eax,%eax
80106837:	0f 85 28 fe ff ff    	jne    80106665 <trap+0x35>
8010683d:	83 ec 0c             	sub    $0xc,%esp
80106840:	68 c0 52 11 80       	push   $0x801152c0
80106845:	e8 76 ea ff ff       	call   801052c0 <acquire>
8010684a:	c7 04 24 a0 52 11 80 	movl   $0x801152a0,(%esp)
80106851:	83 05 a0 52 11 80 01 	addl   $0x1,0x801152a0
80106858:	e8 c3 e5 ff ff       	call   80104e20 <wakeup>
8010685d:	c7 04 24 c0 52 11 80 	movl   $0x801152c0,(%esp)
80106864:	e8 f7 e9 ff ff       	call   80105260 <release>
80106869:	83 c4 10             	add    $0x10,%esp
8010686c:	e9 f4 fd ff ff       	jmp    80106665 <trap+0x35>
80106871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106878:	e8 33 e2 ff ff       	call   80104ab0 <exit>
8010687d:	e9 0e fe ff ff       	jmp    80106690 <trap+0x60>
80106882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106888:	e8 23 e2 ff ff       	call   80104ab0 <exit>
8010688d:	e9 2e ff ff ff       	jmp    801067c0 <trap+0x190>
80106892:	0f 20 d6             	mov    %cr2,%esi
80106895:	e8 d6 dd ff ff       	call   80104670 <cpuid>
8010689a:	83 ec 0c             	sub    $0xc,%esp
8010689d:	56                   	push   %esi
8010689e:	57                   	push   %edi
8010689f:	50                   	push   %eax
801068a0:	ff 73 30             	push   0x30(%ebx)
801068a3:	68 a8 86 10 80       	push   $0x801086a8
801068a8:	e8 c3 a1 ff ff       	call   80100a70 <cprintf>
801068ad:	83 c4 14             	add    $0x14,%esp
801068b0:	68 7e 86 10 80       	push   $0x8010867e
801068b5:	e8 36 9c ff ff       	call   801004f0 <panic>
801068ba:	66 90                	xchg   %ax,%ax
801068bc:	66 90                	xchg   %ax,%ax
801068be:	66 90                	xchg   %ax,%ax

801068c0 <uartgetc>:
801068c0:	a1 00 5b 11 80       	mov    0x80115b00,%eax
801068c5:	85 c0                	test   %eax,%eax
801068c7:	74 17                	je     801068e0 <uartgetc+0x20>
801068c9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068ce:	ec                   	in     (%dx),%al
801068cf:	a8 01                	test   $0x1,%al
801068d1:	74 0d                	je     801068e0 <uartgetc+0x20>
801068d3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068d8:	ec                   	in     (%dx),%al
801068d9:	0f b6 c0             	movzbl %al,%eax
801068dc:	c3                   	ret    
801068dd:	8d 76 00             	lea    0x0(%esi),%esi
801068e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068e5:	c3                   	ret    
801068e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068ed:	8d 76 00             	lea    0x0(%esi),%esi

801068f0 <uartinit>:
801068f0:	55                   	push   %ebp
801068f1:	31 c9                	xor    %ecx,%ecx
801068f3:	89 c8                	mov    %ecx,%eax
801068f5:	89 e5                	mov    %esp,%ebp
801068f7:	57                   	push   %edi
801068f8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801068fd:	56                   	push   %esi
801068fe:	89 fa                	mov    %edi,%edx
80106900:	53                   	push   %ebx
80106901:	83 ec 1c             	sub    $0x1c,%esp
80106904:	ee                   	out    %al,(%dx)
80106905:	be fb 03 00 00       	mov    $0x3fb,%esi
8010690a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010690f:	89 f2                	mov    %esi,%edx
80106911:	ee                   	out    %al,(%dx)
80106912:	b8 0c 00 00 00       	mov    $0xc,%eax
80106917:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010691c:	ee                   	out    %al,(%dx)
8010691d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106922:	89 c8                	mov    %ecx,%eax
80106924:	89 da                	mov    %ebx,%edx
80106926:	ee                   	out    %al,(%dx)
80106927:	b8 03 00 00 00       	mov    $0x3,%eax
8010692c:	89 f2                	mov    %esi,%edx
8010692e:	ee                   	out    %al,(%dx)
8010692f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106934:	89 c8                	mov    %ecx,%eax
80106936:	ee                   	out    %al,(%dx)
80106937:	b8 01 00 00 00       	mov    $0x1,%eax
8010693c:	89 da                	mov    %ebx,%edx
8010693e:	ee                   	out    %al,(%dx)
8010693f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106944:	ec                   	in     (%dx),%al
80106945:	3c ff                	cmp    $0xff,%al
80106947:	74 78                	je     801069c1 <uartinit+0xd1>
80106949:	c7 05 00 5b 11 80 01 	movl   $0x1,0x80115b00
80106950:	00 00 00 
80106953:	89 fa                	mov    %edi,%edx
80106955:	ec                   	in     (%dx),%al
80106956:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010695b:	ec                   	in     (%dx),%al
8010695c:	83 ec 08             	sub    $0x8,%esp
8010695f:	bf a0 87 10 80       	mov    $0x801087a0,%edi
80106964:	be fd 03 00 00       	mov    $0x3fd,%esi
80106969:	6a 00                	push   $0x0
8010696b:	6a 04                	push   $0x4
8010696d:	e8 2e c8 ff ff       	call   801031a0 <ioapicenable>
80106972:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80106976:	83 c4 10             	add    $0x10,%esp
80106979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106980:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80106985:	bb 80 00 00 00       	mov    $0x80,%ebx
8010698a:	85 c0                	test   %eax,%eax
8010698c:	75 14                	jne    801069a2 <uartinit+0xb2>
8010698e:	eb 23                	jmp    801069b3 <uartinit+0xc3>
80106990:	83 ec 0c             	sub    $0xc,%esp
80106993:	6a 0a                	push   $0xa
80106995:	e8 b6 cc ff ff       	call   80103650 <microdelay>
8010699a:	83 c4 10             	add    $0x10,%esp
8010699d:	83 eb 01             	sub    $0x1,%ebx
801069a0:	74 07                	je     801069a9 <uartinit+0xb9>
801069a2:	89 f2                	mov    %esi,%edx
801069a4:	ec                   	in     (%dx),%al
801069a5:	a8 20                	test   $0x20,%al
801069a7:	74 e7                	je     80106990 <uartinit+0xa0>
801069a9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801069ad:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069b2:	ee                   	out    %al,(%dx)
801069b3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801069b7:	83 c7 01             	add    $0x1,%edi
801069ba:	88 45 e7             	mov    %al,-0x19(%ebp)
801069bd:	84 c0                	test   %al,%al
801069bf:	75 bf                	jne    80106980 <uartinit+0x90>
801069c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069c4:	5b                   	pop    %ebx
801069c5:	5e                   	pop    %esi
801069c6:	5f                   	pop    %edi
801069c7:	5d                   	pop    %ebp
801069c8:	c3                   	ret    
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069d0 <uartputc>:
801069d0:	a1 00 5b 11 80       	mov    0x80115b00,%eax
801069d5:	85 c0                	test   %eax,%eax
801069d7:	74 47                	je     80106a20 <uartputc+0x50>
801069d9:	55                   	push   %ebp
801069da:	89 e5                	mov    %esp,%ebp
801069dc:	56                   	push   %esi
801069dd:	be fd 03 00 00       	mov    $0x3fd,%esi
801069e2:	53                   	push   %ebx
801069e3:	bb 80 00 00 00       	mov    $0x80,%ebx
801069e8:	eb 18                	jmp    80106a02 <uartputc+0x32>
801069ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069f0:	83 ec 0c             	sub    $0xc,%esp
801069f3:	6a 0a                	push   $0xa
801069f5:	e8 56 cc ff ff       	call   80103650 <microdelay>
801069fa:	83 c4 10             	add    $0x10,%esp
801069fd:	83 eb 01             	sub    $0x1,%ebx
80106a00:	74 07                	je     80106a09 <uartputc+0x39>
80106a02:	89 f2                	mov    %esi,%edx
80106a04:	ec                   	in     (%dx),%al
80106a05:	a8 20                	test   $0x20,%al
80106a07:	74 e7                	je     801069f0 <uartputc+0x20>
80106a09:	8b 45 08             	mov    0x8(%ebp),%eax
80106a0c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a11:	ee                   	out    %al,(%dx)
80106a12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106a15:	5b                   	pop    %ebx
80106a16:	5e                   	pop    %esi
80106a17:	5d                   	pop    %ebp
80106a18:	c3                   	ret    
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a20:	c3                   	ret    
80106a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a2f:	90                   	nop

80106a30 <uartintr>:
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	83 ec 14             	sub    $0x14,%esp
80106a36:	68 c0 68 10 80       	push   $0x801068c0
80106a3b:	e8 00 a3 ff ff       	call   80100d40 <consoleintr>
80106a40:	83 c4 10             	add    $0x10,%esp
80106a43:	c9                   	leave  
80106a44:	c3                   	ret    

80106a45 <vector0>:
80106a45:	6a 00                	push   $0x0
80106a47:	6a 00                	push   $0x0
80106a49:	e9 0c fb ff ff       	jmp    8010655a <alltraps>

80106a4e <vector1>:
80106a4e:	6a 00                	push   $0x0
80106a50:	6a 01                	push   $0x1
80106a52:	e9 03 fb ff ff       	jmp    8010655a <alltraps>

80106a57 <vector2>:
80106a57:	6a 00                	push   $0x0
80106a59:	6a 02                	push   $0x2
80106a5b:	e9 fa fa ff ff       	jmp    8010655a <alltraps>

80106a60 <vector3>:
80106a60:	6a 00                	push   $0x0
80106a62:	6a 03                	push   $0x3
80106a64:	e9 f1 fa ff ff       	jmp    8010655a <alltraps>

80106a69 <vector4>:
80106a69:	6a 00                	push   $0x0
80106a6b:	6a 04                	push   $0x4
80106a6d:	e9 e8 fa ff ff       	jmp    8010655a <alltraps>

80106a72 <vector5>:
80106a72:	6a 00                	push   $0x0
80106a74:	6a 05                	push   $0x5
80106a76:	e9 df fa ff ff       	jmp    8010655a <alltraps>

80106a7b <vector6>:
80106a7b:	6a 00                	push   $0x0
80106a7d:	6a 06                	push   $0x6
80106a7f:	e9 d6 fa ff ff       	jmp    8010655a <alltraps>

80106a84 <vector7>:
80106a84:	6a 00                	push   $0x0
80106a86:	6a 07                	push   $0x7
80106a88:	e9 cd fa ff ff       	jmp    8010655a <alltraps>

80106a8d <vector8>:
80106a8d:	6a 08                	push   $0x8
80106a8f:	e9 c6 fa ff ff       	jmp    8010655a <alltraps>

80106a94 <vector9>:
80106a94:	6a 00                	push   $0x0
80106a96:	6a 09                	push   $0x9
80106a98:	e9 bd fa ff ff       	jmp    8010655a <alltraps>

80106a9d <vector10>:
80106a9d:	6a 0a                	push   $0xa
80106a9f:	e9 b6 fa ff ff       	jmp    8010655a <alltraps>

80106aa4 <vector11>:
80106aa4:	6a 0b                	push   $0xb
80106aa6:	e9 af fa ff ff       	jmp    8010655a <alltraps>

80106aab <vector12>:
80106aab:	6a 0c                	push   $0xc
80106aad:	e9 a8 fa ff ff       	jmp    8010655a <alltraps>

80106ab2 <vector13>:
80106ab2:	6a 0d                	push   $0xd
80106ab4:	e9 a1 fa ff ff       	jmp    8010655a <alltraps>

80106ab9 <vector14>:
80106ab9:	6a 0e                	push   $0xe
80106abb:	e9 9a fa ff ff       	jmp    8010655a <alltraps>

80106ac0 <vector15>:
80106ac0:	6a 00                	push   $0x0
80106ac2:	6a 0f                	push   $0xf
80106ac4:	e9 91 fa ff ff       	jmp    8010655a <alltraps>

80106ac9 <vector16>:
80106ac9:	6a 00                	push   $0x0
80106acb:	6a 10                	push   $0x10
80106acd:	e9 88 fa ff ff       	jmp    8010655a <alltraps>

80106ad2 <vector17>:
80106ad2:	6a 11                	push   $0x11
80106ad4:	e9 81 fa ff ff       	jmp    8010655a <alltraps>

80106ad9 <vector18>:
80106ad9:	6a 00                	push   $0x0
80106adb:	6a 12                	push   $0x12
80106add:	e9 78 fa ff ff       	jmp    8010655a <alltraps>

80106ae2 <vector19>:
80106ae2:	6a 00                	push   $0x0
80106ae4:	6a 13                	push   $0x13
80106ae6:	e9 6f fa ff ff       	jmp    8010655a <alltraps>

80106aeb <vector20>:
80106aeb:	6a 00                	push   $0x0
80106aed:	6a 14                	push   $0x14
80106aef:	e9 66 fa ff ff       	jmp    8010655a <alltraps>

80106af4 <vector21>:
80106af4:	6a 00                	push   $0x0
80106af6:	6a 15                	push   $0x15
80106af8:	e9 5d fa ff ff       	jmp    8010655a <alltraps>

80106afd <vector22>:
80106afd:	6a 00                	push   $0x0
80106aff:	6a 16                	push   $0x16
80106b01:	e9 54 fa ff ff       	jmp    8010655a <alltraps>

80106b06 <vector23>:
80106b06:	6a 00                	push   $0x0
80106b08:	6a 17                	push   $0x17
80106b0a:	e9 4b fa ff ff       	jmp    8010655a <alltraps>

80106b0f <vector24>:
80106b0f:	6a 00                	push   $0x0
80106b11:	6a 18                	push   $0x18
80106b13:	e9 42 fa ff ff       	jmp    8010655a <alltraps>

80106b18 <vector25>:
80106b18:	6a 00                	push   $0x0
80106b1a:	6a 19                	push   $0x19
80106b1c:	e9 39 fa ff ff       	jmp    8010655a <alltraps>

80106b21 <vector26>:
80106b21:	6a 00                	push   $0x0
80106b23:	6a 1a                	push   $0x1a
80106b25:	e9 30 fa ff ff       	jmp    8010655a <alltraps>

80106b2a <vector27>:
80106b2a:	6a 00                	push   $0x0
80106b2c:	6a 1b                	push   $0x1b
80106b2e:	e9 27 fa ff ff       	jmp    8010655a <alltraps>

80106b33 <vector28>:
80106b33:	6a 00                	push   $0x0
80106b35:	6a 1c                	push   $0x1c
80106b37:	e9 1e fa ff ff       	jmp    8010655a <alltraps>

80106b3c <vector29>:
80106b3c:	6a 00                	push   $0x0
80106b3e:	6a 1d                	push   $0x1d
80106b40:	e9 15 fa ff ff       	jmp    8010655a <alltraps>

80106b45 <vector30>:
80106b45:	6a 00                	push   $0x0
80106b47:	6a 1e                	push   $0x1e
80106b49:	e9 0c fa ff ff       	jmp    8010655a <alltraps>

80106b4e <vector31>:
80106b4e:	6a 00                	push   $0x0
80106b50:	6a 1f                	push   $0x1f
80106b52:	e9 03 fa ff ff       	jmp    8010655a <alltraps>

80106b57 <vector32>:
80106b57:	6a 00                	push   $0x0
80106b59:	6a 20                	push   $0x20
80106b5b:	e9 fa f9 ff ff       	jmp    8010655a <alltraps>

80106b60 <vector33>:
80106b60:	6a 00                	push   $0x0
80106b62:	6a 21                	push   $0x21
80106b64:	e9 f1 f9 ff ff       	jmp    8010655a <alltraps>

80106b69 <vector34>:
80106b69:	6a 00                	push   $0x0
80106b6b:	6a 22                	push   $0x22
80106b6d:	e9 e8 f9 ff ff       	jmp    8010655a <alltraps>

80106b72 <vector35>:
80106b72:	6a 00                	push   $0x0
80106b74:	6a 23                	push   $0x23
80106b76:	e9 df f9 ff ff       	jmp    8010655a <alltraps>

80106b7b <vector36>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	6a 24                	push   $0x24
80106b7f:	e9 d6 f9 ff ff       	jmp    8010655a <alltraps>

80106b84 <vector37>:
80106b84:	6a 00                	push   $0x0
80106b86:	6a 25                	push   $0x25
80106b88:	e9 cd f9 ff ff       	jmp    8010655a <alltraps>

80106b8d <vector38>:
80106b8d:	6a 00                	push   $0x0
80106b8f:	6a 26                	push   $0x26
80106b91:	e9 c4 f9 ff ff       	jmp    8010655a <alltraps>

80106b96 <vector39>:
80106b96:	6a 00                	push   $0x0
80106b98:	6a 27                	push   $0x27
80106b9a:	e9 bb f9 ff ff       	jmp    8010655a <alltraps>

80106b9f <vector40>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	6a 28                	push   $0x28
80106ba3:	e9 b2 f9 ff ff       	jmp    8010655a <alltraps>

80106ba8 <vector41>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 29                	push   $0x29
80106bac:	e9 a9 f9 ff ff       	jmp    8010655a <alltraps>

80106bb1 <vector42>:
80106bb1:	6a 00                	push   $0x0
80106bb3:	6a 2a                	push   $0x2a
80106bb5:	e9 a0 f9 ff ff       	jmp    8010655a <alltraps>

80106bba <vector43>:
80106bba:	6a 00                	push   $0x0
80106bbc:	6a 2b                	push   $0x2b
80106bbe:	e9 97 f9 ff ff       	jmp    8010655a <alltraps>

80106bc3 <vector44>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	6a 2c                	push   $0x2c
80106bc7:	e9 8e f9 ff ff       	jmp    8010655a <alltraps>

80106bcc <vector45>:
80106bcc:	6a 00                	push   $0x0
80106bce:	6a 2d                	push   $0x2d
80106bd0:	e9 85 f9 ff ff       	jmp    8010655a <alltraps>

80106bd5 <vector46>:
80106bd5:	6a 00                	push   $0x0
80106bd7:	6a 2e                	push   $0x2e
80106bd9:	e9 7c f9 ff ff       	jmp    8010655a <alltraps>

80106bde <vector47>:
80106bde:	6a 00                	push   $0x0
80106be0:	6a 2f                	push   $0x2f
80106be2:	e9 73 f9 ff ff       	jmp    8010655a <alltraps>

80106be7 <vector48>:
80106be7:	6a 00                	push   $0x0
80106be9:	6a 30                	push   $0x30
80106beb:	e9 6a f9 ff ff       	jmp    8010655a <alltraps>

80106bf0 <vector49>:
80106bf0:	6a 00                	push   $0x0
80106bf2:	6a 31                	push   $0x31
80106bf4:	e9 61 f9 ff ff       	jmp    8010655a <alltraps>

80106bf9 <vector50>:
80106bf9:	6a 00                	push   $0x0
80106bfb:	6a 32                	push   $0x32
80106bfd:	e9 58 f9 ff ff       	jmp    8010655a <alltraps>

80106c02 <vector51>:
80106c02:	6a 00                	push   $0x0
80106c04:	6a 33                	push   $0x33
80106c06:	e9 4f f9 ff ff       	jmp    8010655a <alltraps>

80106c0b <vector52>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	6a 34                	push   $0x34
80106c0f:	e9 46 f9 ff ff       	jmp    8010655a <alltraps>

80106c14 <vector53>:
80106c14:	6a 00                	push   $0x0
80106c16:	6a 35                	push   $0x35
80106c18:	e9 3d f9 ff ff       	jmp    8010655a <alltraps>

80106c1d <vector54>:
80106c1d:	6a 00                	push   $0x0
80106c1f:	6a 36                	push   $0x36
80106c21:	e9 34 f9 ff ff       	jmp    8010655a <alltraps>

80106c26 <vector55>:
80106c26:	6a 00                	push   $0x0
80106c28:	6a 37                	push   $0x37
80106c2a:	e9 2b f9 ff ff       	jmp    8010655a <alltraps>

80106c2f <vector56>:
80106c2f:	6a 00                	push   $0x0
80106c31:	6a 38                	push   $0x38
80106c33:	e9 22 f9 ff ff       	jmp    8010655a <alltraps>

80106c38 <vector57>:
80106c38:	6a 00                	push   $0x0
80106c3a:	6a 39                	push   $0x39
80106c3c:	e9 19 f9 ff ff       	jmp    8010655a <alltraps>

80106c41 <vector58>:
80106c41:	6a 00                	push   $0x0
80106c43:	6a 3a                	push   $0x3a
80106c45:	e9 10 f9 ff ff       	jmp    8010655a <alltraps>

80106c4a <vector59>:
80106c4a:	6a 00                	push   $0x0
80106c4c:	6a 3b                	push   $0x3b
80106c4e:	e9 07 f9 ff ff       	jmp    8010655a <alltraps>

80106c53 <vector60>:
80106c53:	6a 00                	push   $0x0
80106c55:	6a 3c                	push   $0x3c
80106c57:	e9 fe f8 ff ff       	jmp    8010655a <alltraps>

80106c5c <vector61>:
80106c5c:	6a 00                	push   $0x0
80106c5e:	6a 3d                	push   $0x3d
80106c60:	e9 f5 f8 ff ff       	jmp    8010655a <alltraps>

80106c65 <vector62>:
80106c65:	6a 00                	push   $0x0
80106c67:	6a 3e                	push   $0x3e
80106c69:	e9 ec f8 ff ff       	jmp    8010655a <alltraps>

80106c6e <vector63>:
80106c6e:	6a 00                	push   $0x0
80106c70:	6a 3f                	push   $0x3f
80106c72:	e9 e3 f8 ff ff       	jmp    8010655a <alltraps>

80106c77 <vector64>:
80106c77:	6a 00                	push   $0x0
80106c79:	6a 40                	push   $0x40
80106c7b:	e9 da f8 ff ff       	jmp    8010655a <alltraps>

80106c80 <vector65>:
80106c80:	6a 00                	push   $0x0
80106c82:	6a 41                	push   $0x41
80106c84:	e9 d1 f8 ff ff       	jmp    8010655a <alltraps>

80106c89 <vector66>:
80106c89:	6a 00                	push   $0x0
80106c8b:	6a 42                	push   $0x42
80106c8d:	e9 c8 f8 ff ff       	jmp    8010655a <alltraps>

80106c92 <vector67>:
80106c92:	6a 00                	push   $0x0
80106c94:	6a 43                	push   $0x43
80106c96:	e9 bf f8 ff ff       	jmp    8010655a <alltraps>

80106c9b <vector68>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	6a 44                	push   $0x44
80106c9f:	e9 b6 f8 ff ff       	jmp    8010655a <alltraps>

80106ca4 <vector69>:
80106ca4:	6a 00                	push   $0x0
80106ca6:	6a 45                	push   $0x45
80106ca8:	e9 ad f8 ff ff       	jmp    8010655a <alltraps>

80106cad <vector70>:
80106cad:	6a 00                	push   $0x0
80106caf:	6a 46                	push   $0x46
80106cb1:	e9 a4 f8 ff ff       	jmp    8010655a <alltraps>

80106cb6 <vector71>:
80106cb6:	6a 00                	push   $0x0
80106cb8:	6a 47                	push   $0x47
80106cba:	e9 9b f8 ff ff       	jmp    8010655a <alltraps>

80106cbf <vector72>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	6a 48                	push   $0x48
80106cc3:	e9 92 f8 ff ff       	jmp    8010655a <alltraps>

80106cc8 <vector73>:
80106cc8:	6a 00                	push   $0x0
80106cca:	6a 49                	push   $0x49
80106ccc:	e9 89 f8 ff ff       	jmp    8010655a <alltraps>

80106cd1 <vector74>:
80106cd1:	6a 00                	push   $0x0
80106cd3:	6a 4a                	push   $0x4a
80106cd5:	e9 80 f8 ff ff       	jmp    8010655a <alltraps>

80106cda <vector75>:
80106cda:	6a 00                	push   $0x0
80106cdc:	6a 4b                	push   $0x4b
80106cde:	e9 77 f8 ff ff       	jmp    8010655a <alltraps>

80106ce3 <vector76>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	6a 4c                	push   $0x4c
80106ce7:	e9 6e f8 ff ff       	jmp    8010655a <alltraps>

80106cec <vector77>:
80106cec:	6a 00                	push   $0x0
80106cee:	6a 4d                	push   $0x4d
80106cf0:	e9 65 f8 ff ff       	jmp    8010655a <alltraps>

80106cf5 <vector78>:
80106cf5:	6a 00                	push   $0x0
80106cf7:	6a 4e                	push   $0x4e
80106cf9:	e9 5c f8 ff ff       	jmp    8010655a <alltraps>

80106cfe <vector79>:
80106cfe:	6a 00                	push   $0x0
80106d00:	6a 4f                	push   $0x4f
80106d02:	e9 53 f8 ff ff       	jmp    8010655a <alltraps>

80106d07 <vector80>:
80106d07:	6a 00                	push   $0x0
80106d09:	6a 50                	push   $0x50
80106d0b:	e9 4a f8 ff ff       	jmp    8010655a <alltraps>

80106d10 <vector81>:
80106d10:	6a 00                	push   $0x0
80106d12:	6a 51                	push   $0x51
80106d14:	e9 41 f8 ff ff       	jmp    8010655a <alltraps>

80106d19 <vector82>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 52                	push   $0x52
80106d1d:	e9 38 f8 ff ff       	jmp    8010655a <alltraps>

80106d22 <vector83>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 53                	push   $0x53
80106d26:	e9 2f f8 ff ff       	jmp    8010655a <alltraps>

80106d2b <vector84>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 54                	push   $0x54
80106d2f:	e9 26 f8 ff ff       	jmp    8010655a <alltraps>

80106d34 <vector85>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 55                	push   $0x55
80106d38:	e9 1d f8 ff ff       	jmp    8010655a <alltraps>

80106d3d <vector86>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 56                	push   $0x56
80106d41:	e9 14 f8 ff ff       	jmp    8010655a <alltraps>

80106d46 <vector87>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 57                	push   $0x57
80106d4a:	e9 0b f8 ff ff       	jmp    8010655a <alltraps>

80106d4f <vector88>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 58                	push   $0x58
80106d53:	e9 02 f8 ff ff       	jmp    8010655a <alltraps>

80106d58 <vector89>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 59                	push   $0x59
80106d5c:	e9 f9 f7 ff ff       	jmp    8010655a <alltraps>

80106d61 <vector90>:
80106d61:	6a 00                	push   $0x0
80106d63:	6a 5a                	push   $0x5a
80106d65:	e9 f0 f7 ff ff       	jmp    8010655a <alltraps>

80106d6a <vector91>:
80106d6a:	6a 00                	push   $0x0
80106d6c:	6a 5b                	push   $0x5b
80106d6e:	e9 e7 f7 ff ff       	jmp    8010655a <alltraps>

80106d73 <vector92>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 5c                	push   $0x5c
80106d77:	e9 de f7 ff ff       	jmp    8010655a <alltraps>

80106d7c <vector93>:
80106d7c:	6a 00                	push   $0x0
80106d7e:	6a 5d                	push   $0x5d
80106d80:	e9 d5 f7 ff ff       	jmp    8010655a <alltraps>

80106d85 <vector94>:
80106d85:	6a 00                	push   $0x0
80106d87:	6a 5e                	push   $0x5e
80106d89:	e9 cc f7 ff ff       	jmp    8010655a <alltraps>

80106d8e <vector95>:
80106d8e:	6a 00                	push   $0x0
80106d90:	6a 5f                	push   $0x5f
80106d92:	e9 c3 f7 ff ff       	jmp    8010655a <alltraps>

80106d97 <vector96>:
80106d97:	6a 00                	push   $0x0
80106d99:	6a 60                	push   $0x60
80106d9b:	e9 ba f7 ff ff       	jmp    8010655a <alltraps>

80106da0 <vector97>:
80106da0:	6a 00                	push   $0x0
80106da2:	6a 61                	push   $0x61
80106da4:	e9 b1 f7 ff ff       	jmp    8010655a <alltraps>

80106da9 <vector98>:
80106da9:	6a 00                	push   $0x0
80106dab:	6a 62                	push   $0x62
80106dad:	e9 a8 f7 ff ff       	jmp    8010655a <alltraps>

80106db2 <vector99>:
80106db2:	6a 00                	push   $0x0
80106db4:	6a 63                	push   $0x63
80106db6:	e9 9f f7 ff ff       	jmp    8010655a <alltraps>

80106dbb <vector100>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	6a 64                	push   $0x64
80106dbf:	e9 96 f7 ff ff       	jmp    8010655a <alltraps>

80106dc4 <vector101>:
80106dc4:	6a 00                	push   $0x0
80106dc6:	6a 65                	push   $0x65
80106dc8:	e9 8d f7 ff ff       	jmp    8010655a <alltraps>

80106dcd <vector102>:
80106dcd:	6a 00                	push   $0x0
80106dcf:	6a 66                	push   $0x66
80106dd1:	e9 84 f7 ff ff       	jmp    8010655a <alltraps>

80106dd6 <vector103>:
80106dd6:	6a 00                	push   $0x0
80106dd8:	6a 67                	push   $0x67
80106dda:	e9 7b f7 ff ff       	jmp    8010655a <alltraps>

80106ddf <vector104>:
80106ddf:	6a 00                	push   $0x0
80106de1:	6a 68                	push   $0x68
80106de3:	e9 72 f7 ff ff       	jmp    8010655a <alltraps>

80106de8 <vector105>:
80106de8:	6a 00                	push   $0x0
80106dea:	6a 69                	push   $0x69
80106dec:	e9 69 f7 ff ff       	jmp    8010655a <alltraps>

80106df1 <vector106>:
80106df1:	6a 00                	push   $0x0
80106df3:	6a 6a                	push   $0x6a
80106df5:	e9 60 f7 ff ff       	jmp    8010655a <alltraps>

80106dfa <vector107>:
80106dfa:	6a 00                	push   $0x0
80106dfc:	6a 6b                	push   $0x6b
80106dfe:	e9 57 f7 ff ff       	jmp    8010655a <alltraps>

80106e03 <vector108>:
80106e03:	6a 00                	push   $0x0
80106e05:	6a 6c                	push   $0x6c
80106e07:	e9 4e f7 ff ff       	jmp    8010655a <alltraps>

80106e0c <vector109>:
80106e0c:	6a 00                	push   $0x0
80106e0e:	6a 6d                	push   $0x6d
80106e10:	e9 45 f7 ff ff       	jmp    8010655a <alltraps>

80106e15 <vector110>:
80106e15:	6a 00                	push   $0x0
80106e17:	6a 6e                	push   $0x6e
80106e19:	e9 3c f7 ff ff       	jmp    8010655a <alltraps>

80106e1e <vector111>:
80106e1e:	6a 00                	push   $0x0
80106e20:	6a 6f                	push   $0x6f
80106e22:	e9 33 f7 ff ff       	jmp    8010655a <alltraps>

80106e27 <vector112>:
80106e27:	6a 00                	push   $0x0
80106e29:	6a 70                	push   $0x70
80106e2b:	e9 2a f7 ff ff       	jmp    8010655a <alltraps>

80106e30 <vector113>:
80106e30:	6a 00                	push   $0x0
80106e32:	6a 71                	push   $0x71
80106e34:	e9 21 f7 ff ff       	jmp    8010655a <alltraps>

80106e39 <vector114>:
80106e39:	6a 00                	push   $0x0
80106e3b:	6a 72                	push   $0x72
80106e3d:	e9 18 f7 ff ff       	jmp    8010655a <alltraps>

80106e42 <vector115>:
80106e42:	6a 00                	push   $0x0
80106e44:	6a 73                	push   $0x73
80106e46:	e9 0f f7 ff ff       	jmp    8010655a <alltraps>

80106e4b <vector116>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	6a 74                	push   $0x74
80106e4f:	e9 06 f7 ff ff       	jmp    8010655a <alltraps>

80106e54 <vector117>:
80106e54:	6a 00                	push   $0x0
80106e56:	6a 75                	push   $0x75
80106e58:	e9 fd f6 ff ff       	jmp    8010655a <alltraps>

80106e5d <vector118>:
80106e5d:	6a 00                	push   $0x0
80106e5f:	6a 76                	push   $0x76
80106e61:	e9 f4 f6 ff ff       	jmp    8010655a <alltraps>

80106e66 <vector119>:
80106e66:	6a 00                	push   $0x0
80106e68:	6a 77                	push   $0x77
80106e6a:	e9 eb f6 ff ff       	jmp    8010655a <alltraps>

80106e6f <vector120>:
80106e6f:	6a 00                	push   $0x0
80106e71:	6a 78                	push   $0x78
80106e73:	e9 e2 f6 ff ff       	jmp    8010655a <alltraps>

80106e78 <vector121>:
80106e78:	6a 00                	push   $0x0
80106e7a:	6a 79                	push   $0x79
80106e7c:	e9 d9 f6 ff ff       	jmp    8010655a <alltraps>

80106e81 <vector122>:
80106e81:	6a 00                	push   $0x0
80106e83:	6a 7a                	push   $0x7a
80106e85:	e9 d0 f6 ff ff       	jmp    8010655a <alltraps>

80106e8a <vector123>:
80106e8a:	6a 00                	push   $0x0
80106e8c:	6a 7b                	push   $0x7b
80106e8e:	e9 c7 f6 ff ff       	jmp    8010655a <alltraps>

80106e93 <vector124>:
80106e93:	6a 00                	push   $0x0
80106e95:	6a 7c                	push   $0x7c
80106e97:	e9 be f6 ff ff       	jmp    8010655a <alltraps>

80106e9c <vector125>:
80106e9c:	6a 00                	push   $0x0
80106e9e:	6a 7d                	push   $0x7d
80106ea0:	e9 b5 f6 ff ff       	jmp    8010655a <alltraps>

80106ea5 <vector126>:
80106ea5:	6a 00                	push   $0x0
80106ea7:	6a 7e                	push   $0x7e
80106ea9:	e9 ac f6 ff ff       	jmp    8010655a <alltraps>

80106eae <vector127>:
80106eae:	6a 00                	push   $0x0
80106eb0:	6a 7f                	push   $0x7f
80106eb2:	e9 a3 f6 ff ff       	jmp    8010655a <alltraps>

80106eb7 <vector128>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	68 80 00 00 00       	push   $0x80
80106ebe:	e9 97 f6 ff ff       	jmp    8010655a <alltraps>

80106ec3 <vector129>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	68 81 00 00 00       	push   $0x81
80106eca:	e9 8b f6 ff ff       	jmp    8010655a <alltraps>

80106ecf <vector130>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	68 82 00 00 00       	push   $0x82
80106ed6:	e9 7f f6 ff ff       	jmp    8010655a <alltraps>

80106edb <vector131>:
80106edb:	6a 00                	push   $0x0
80106edd:	68 83 00 00 00       	push   $0x83
80106ee2:	e9 73 f6 ff ff       	jmp    8010655a <alltraps>

80106ee7 <vector132>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 84 00 00 00       	push   $0x84
80106eee:	e9 67 f6 ff ff       	jmp    8010655a <alltraps>

80106ef3 <vector133>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 85 00 00 00       	push   $0x85
80106efa:	e9 5b f6 ff ff       	jmp    8010655a <alltraps>

80106eff <vector134>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 86 00 00 00       	push   $0x86
80106f06:	e9 4f f6 ff ff       	jmp    8010655a <alltraps>

80106f0b <vector135>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 87 00 00 00       	push   $0x87
80106f12:	e9 43 f6 ff ff       	jmp    8010655a <alltraps>

80106f17 <vector136>:
80106f17:	6a 00                	push   $0x0
80106f19:	68 88 00 00 00       	push   $0x88
80106f1e:	e9 37 f6 ff ff       	jmp    8010655a <alltraps>

80106f23 <vector137>:
80106f23:	6a 00                	push   $0x0
80106f25:	68 89 00 00 00       	push   $0x89
80106f2a:	e9 2b f6 ff ff       	jmp    8010655a <alltraps>

80106f2f <vector138>:
80106f2f:	6a 00                	push   $0x0
80106f31:	68 8a 00 00 00       	push   $0x8a
80106f36:	e9 1f f6 ff ff       	jmp    8010655a <alltraps>

80106f3b <vector139>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	68 8b 00 00 00       	push   $0x8b
80106f42:	e9 13 f6 ff ff       	jmp    8010655a <alltraps>

80106f47 <vector140>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 8c 00 00 00       	push   $0x8c
80106f4e:	e9 07 f6 ff ff       	jmp    8010655a <alltraps>

80106f53 <vector141>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 8d 00 00 00       	push   $0x8d
80106f5a:	e9 fb f5 ff ff       	jmp    8010655a <alltraps>

80106f5f <vector142>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 8e 00 00 00       	push   $0x8e
80106f66:	e9 ef f5 ff ff       	jmp    8010655a <alltraps>

80106f6b <vector143>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 8f 00 00 00       	push   $0x8f
80106f72:	e9 e3 f5 ff ff       	jmp    8010655a <alltraps>

80106f77 <vector144>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 90 00 00 00       	push   $0x90
80106f7e:	e9 d7 f5 ff ff       	jmp    8010655a <alltraps>

80106f83 <vector145>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 91 00 00 00       	push   $0x91
80106f8a:	e9 cb f5 ff ff       	jmp    8010655a <alltraps>

80106f8f <vector146>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 92 00 00 00       	push   $0x92
80106f96:	e9 bf f5 ff ff       	jmp    8010655a <alltraps>

80106f9b <vector147>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 93 00 00 00       	push   $0x93
80106fa2:	e9 b3 f5 ff ff       	jmp    8010655a <alltraps>

80106fa7 <vector148>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 94 00 00 00       	push   $0x94
80106fae:	e9 a7 f5 ff ff       	jmp    8010655a <alltraps>

80106fb3 <vector149>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 95 00 00 00       	push   $0x95
80106fba:	e9 9b f5 ff ff       	jmp    8010655a <alltraps>

80106fbf <vector150>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 96 00 00 00       	push   $0x96
80106fc6:	e9 8f f5 ff ff       	jmp    8010655a <alltraps>

80106fcb <vector151>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 97 00 00 00       	push   $0x97
80106fd2:	e9 83 f5 ff ff       	jmp    8010655a <alltraps>

80106fd7 <vector152>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 98 00 00 00       	push   $0x98
80106fde:	e9 77 f5 ff ff       	jmp    8010655a <alltraps>

80106fe3 <vector153>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 99 00 00 00       	push   $0x99
80106fea:	e9 6b f5 ff ff       	jmp    8010655a <alltraps>

80106fef <vector154>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 9a 00 00 00       	push   $0x9a
80106ff6:	e9 5f f5 ff ff       	jmp    8010655a <alltraps>

80106ffb <vector155>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 9b 00 00 00       	push   $0x9b
80107002:	e9 53 f5 ff ff       	jmp    8010655a <alltraps>

80107007 <vector156>:
80107007:	6a 00                	push   $0x0
80107009:	68 9c 00 00 00       	push   $0x9c
8010700e:	e9 47 f5 ff ff       	jmp    8010655a <alltraps>

80107013 <vector157>:
80107013:	6a 00                	push   $0x0
80107015:	68 9d 00 00 00       	push   $0x9d
8010701a:	e9 3b f5 ff ff       	jmp    8010655a <alltraps>

8010701f <vector158>:
8010701f:	6a 00                	push   $0x0
80107021:	68 9e 00 00 00       	push   $0x9e
80107026:	e9 2f f5 ff ff       	jmp    8010655a <alltraps>

8010702b <vector159>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 9f 00 00 00       	push   $0x9f
80107032:	e9 23 f5 ff ff       	jmp    8010655a <alltraps>

80107037 <vector160>:
80107037:	6a 00                	push   $0x0
80107039:	68 a0 00 00 00       	push   $0xa0
8010703e:	e9 17 f5 ff ff       	jmp    8010655a <alltraps>

80107043 <vector161>:
80107043:	6a 00                	push   $0x0
80107045:	68 a1 00 00 00       	push   $0xa1
8010704a:	e9 0b f5 ff ff       	jmp    8010655a <alltraps>

8010704f <vector162>:
8010704f:	6a 00                	push   $0x0
80107051:	68 a2 00 00 00       	push   $0xa2
80107056:	e9 ff f4 ff ff       	jmp    8010655a <alltraps>

8010705b <vector163>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 a3 00 00 00       	push   $0xa3
80107062:	e9 f3 f4 ff ff       	jmp    8010655a <alltraps>

80107067 <vector164>:
80107067:	6a 00                	push   $0x0
80107069:	68 a4 00 00 00       	push   $0xa4
8010706e:	e9 e7 f4 ff ff       	jmp    8010655a <alltraps>

80107073 <vector165>:
80107073:	6a 00                	push   $0x0
80107075:	68 a5 00 00 00       	push   $0xa5
8010707a:	e9 db f4 ff ff       	jmp    8010655a <alltraps>

8010707f <vector166>:
8010707f:	6a 00                	push   $0x0
80107081:	68 a6 00 00 00       	push   $0xa6
80107086:	e9 cf f4 ff ff       	jmp    8010655a <alltraps>

8010708b <vector167>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 a7 00 00 00       	push   $0xa7
80107092:	e9 c3 f4 ff ff       	jmp    8010655a <alltraps>

80107097 <vector168>:
80107097:	6a 00                	push   $0x0
80107099:	68 a8 00 00 00       	push   $0xa8
8010709e:	e9 b7 f4 ff ff       	jmp    8010655a <alltraps>

801070a3 <vector169>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 a9 00 00 00       	push   $0xa9
801070aa:	e9 ab f4 ff ff       	jmp    8010655a <alltraps>

801070af <vector170>:
801070af:	6a 00                	push   $0x0
801070b1:	68 aa 00 00 00       	push   $0xaa
801070b6:	e9 9f f4 ff ff       	jmp    8010655a <alltraps>

801070bb <vector171>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 ab 00 00 00       	push   $0xab
801070c2:	e9 93 f4 ff ff       	jmp    8010655a <alltraps>

801070c7 <vector172>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 ac 00 00 00       	push   $0xac
801070ce:	e9 87 f4 ff ff       	jmp    8010655a <alltraps>

801070d3 <vector173>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 ad 00 00 00       	push   $0xad
801070da:	e9 7b f4 ff ff       	jmp    8010655a <alltraps>

801070df <vector174>:
801070df:	6a 00                	push   $0x0
801070e1:	68 ae 00 00 00       	push   $0xae
801070e6:	e9 6f f4 ff ff       	jmp    8010655a <alltraps>

801070eb <vector175>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 af 00 00 00       	push   $0xaf
801070f2:	e9 63 f4 ff ff       	jmp    8010655a <alltraps>

801070f7 <vector176>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 b0 00 00 00       	push   $0xb0
801070fe:	e9 57 f4 ff ff       	jmp    8010655a <alltraps>

80107103 <vector177>:
80107103:	6a 00                	push   $0x0
80107105:	68 b1 00 00 00       	push   $0xb1
8010710a:	e9 4b f4 ff ff       	jmp    8010655a <alltraps>

8010710f <vector178>:
8010710f:	6a 00                	push   $0x0
80107111:	68 b2 00 00 00       	push   $0xb2
80107116:	e9 3f f4 ff ff       	jmp    8010655a <alltraps>

8010711b <vector179>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 b3 00 00 00       	push   $0xb3
80107122:	e9 33 f4 ff ff       	jmp    8010655a <alltraps>

80107127 <vector180>:
80107127:	6a 00                	push   $0x0
80107129:	68 b4 00 00 00       	push   $0xb4
8010712e:	e9 27 f4 ff ff       	jmp    8010655a <alltraps>

80107133 <vector181>:
80107133:	6a 00                	push   $0x0
80107135:	68 b5 00 00 00       	push   $0xb5
8010713a:	e9 1b f4 ff ff       	jmp    8010655a <alltraps>

8010713f <vector182>:
8010713f:	6a 00                	push   $0x0
80107141:	68 b6 00 00 00       	push   $0xb6
80107146:	e9 0f f4 ff ff       	jmp    8010655a <alltraps>

8010714b <vector183>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 b7 00 00 00       	push   $0xb7
80107152:	e9 03 f4 ff ff       	jmp    8010655a <alltraps>

80107157 <vector184>:
80107157:	6a 00                	push   $0x0
80107159:	68 b8 00 00 00       	push   $0xb8
8010715e:	e9 f7 f3 ff ff       	jmp    8010655a <alltraps>

80107163 <vector185>:
80107163:	6a 00                	push   $0x0
80107165:	68 b9 00 00 00       	push   $0xb9
8010716a:	e9 eb f3 ff ff       	jmp    8010655a <alltraps>

8010716f <vector186>:
8010716f:	6a 00                	push   $0x0
80107171:	68 ba 00 00 00       	push   $0xba
80107176:	e9 df f3 ff ff       	jmp    8010655a <alltraps>

8010717b <vector187>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 bb 00 00 00       	push   $0xbb
80107182:	e9 d3 f3 ff ff       	jmp    8010655a <alltraps>

80107187 <vector188>:
80107187:	6a 00                	push   $0x0
80107189:	68 bc 00 00 00       	push   $0xbc
8010718e:	e9 c7 f3 ff ff       	jmp    8010655a <alltraps>

80107193 <vector189>:
80107193:	6a 00                	push   $0x0
80107195:	68 bd 00 00 00       	push   $0xbd
8010719a:	e9 bb f3 ff ff       	jmp    8010655a <alltraps>

8010719f <vector190>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 be 00 00 00       	push   $0xbe
801071a6:	e9 af f3 ff ff       	jmp    8010655a <alltraps>

801071ab <vector191>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 bf 00 00 00       	push   $0xbf
801071b2:	e9 a3 f3 ff ff       	jmp    8010655a <alltraps>

801071b7 <vector192>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 c0 00 00 00       	push   $0xc0
801071be:	e9 97 f3 ff ff       	jmp    8010655a <alltraps>

801071c3 <vector193>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 c1 00 00 00       	push   $0xc1
801071ca:	e9 8b f3 ff ff       	jmp    8010655a <alltraps>

801071cf <vector194>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 c2 00 00 00       	push   $0xc2
801071d6:	e9 7f f3 ff ff       	jmp    8010655a <alltraps>

801071db <vector195>:
801071db:	6a 00                	push   $0x0
801071dd:	68 c3 00 00 00       	push   $0xc3
801071e2:	e9 73 f3 ff ff       	jmp    8010655a <alltraps>

801071e7 <vector196>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 c4 00 00 00       	push   $0xc4
801071ee:	e9 67 f3 ff ff       	jmp    8010655a <alltraps>

801071f3 <vector197>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 c5 00 00 00       	push   $0xc5
801071fa:	e9 5b f3 ff ff       	jmp    8010655a <alltraps>

801071ff <vector198>:
801071ff:	6a 00                	push   $0x0
80107201:	68 c6 00 00 00       	push   $0xc6
80107206:	e9 4f f3 ff ff       	jmp    8010655a <alltraps>

8010720b <vector199>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 c7 00 00 00       	push   $0xc7
80107212:	e9 43 f3 ff ff       	jmp    8010655a <alltraps>

80107217 <vector200>:
80107217:	6a 00                	push   $0x0
80107219:	68 c8 00 00 00       	push   $0xc8
8010721e:	e9 37 f3 ff ff       	jmp    8010655a <alltraps>

80107223 <vector201>:
80107223:	6a 00                	push   $0x0
80107225:	68 c9 00 00 00       	push   $0xc9
8010722a:	e9 2b f3 ff ff       	jmp    8010655a <alltraps>

8010722f <vector202>:
8010722f:	6a 00                	push   $0x0
80107231:	68 ca 00 00 00       	push   $0xca
80107236:	e9 1f f3 ff ff       	jmp    8010655a <alltraps>

8010723b <vector203>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 cb 00 00 00       	push   $0xcb
80107242:	e9 13 f3 ff ff       	jmp    8010655a <alltraps>

80107247 <vector204>:
80107247:	6a 00                	push   $0x0
80107249:	68 cc 00 00 00       	push   $0xcc
8010724e:	e9 07 f3 ff ff       	jmp    8010655a <alltraps>

80107253 <vector205>:
80107253:	6a 00                	push   $0x0
80107255:	68 cd 00 00 00       	push   $0xcd
8010725a:	e9 fb f2 ff ff       	jmp    8010655a <alltraps>

8010725f <vector206>:
8010725f:	6a 00                	push   $0x0
80107261:	68 ce 00 00 00       	push   $0xce
80107266:	e9 ef f2 ff ff       	jmp    8010655a <alltraps>

8010726b <vector207>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 cf 00 00 00       	push   $0xcf
80107272:	e9 e3 f2 ff ff       	jmp    8010655a <alltraps>

80107277 <vector208>:
80107277:	6a 00                	push   $0x0
80107279:	68 d0 00 00 00       	push   $0xd0
8010727e:	e9 d7 f2 ff ff       	jmp    8010655a <alltraps>

80107283 <vector209>:
80107283:	6a 00                	push   $0x0
80107285:	68 d1 00 00 00       	push   $0xd1
8010728a:	e9 cb f2 ff ff       	jmp    8010655a <alltraps>

8010728f <vector210>:
8010728f:	6a 00                	push   $0x0
80107291:	68 d2 00 00 00       	push   $0xd2
80107296:	e9 bf f2 ff ff       	jmp    8010655a <alltraps>

8010729b <vector211>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 d3 00 00 00       	push   $0xd3
801072a2:	e9 b3 f2 ff ff       	jmp    8010655a <alltraps>

801072a7 <vector212>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 d4 00 00 00       	push   $0xd4
801072ae:	e9 a7 f2 ff ff       	jmp    8010655a <alltraps>

801072b3 <vector213>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 d5 00 00 00       	push   $0xd5
801072ba:	e9 9b f2 ff ff       	jmp    8010655a <alltraps>

801072bf <vector214>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 d6 00 00 00       	push   $0xd6
801072c6:	e9 8f f2 ff ff       	jmp    8010655a <alltraps>

801072cb <vector215>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 d7 00 00 00       	push   $0xd7
801072d2:	e9 83 f2 ff ff       	jmp    8010655a <alltraps>

801072d7 <vector216>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 d8 00 00 00       	push   $0xd8
801072de:	e9 77 f2 ff ff       	jmp    8010655a <alltraps>

801072e3 <vector217>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 d9 00 00 00       	push   $0xd9
801072ea:	e9 6b f2 ff ff       	jmp    8010655a <alltraps>

801072ef <vector218>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 da 00 00 00       	push   $0xda
801072f6:	e9 5f f2 ff ff       	jmp    8010655a <alltraps>

801072fb <vector219>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 db 00 00 00       	push   $0xdb
80107302:	e9 53 f2 ff ff       	jmp    8010655a <alltraps>

80107307 <vector220>:
80107307:	6a 00                	push   $0x0
80107309:	68 dc 00 00 00       	push   $0xdc
8010730e:	e9 47 f2 ff ff       	jmp    8010655a <alltraps>

80107313 <vector221>:
80107313:	6a 00                	push   $0x0
80107315:	68 dd 00 00 00       	push   $0xdd
8010731a:	e9 3b f2 ff ff       	jmp    8010655a <alltraps>

8010731f <vector222>:
8010731f:	6a 00                	push   $0x0
80107321:	68 de 00 00 00       	push   $0xde
80107326:	e9 2f f2 ff ff       	jmp    8010655a <alltraps>

8010732b <vector223>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 df 00 00 00       	push   $0xdf
80107332:	e9 23 f2 ff ff       	jmp    8010655a <alltraps>

80107337 <vector224>:
80107337:	6a 00                	push   $0x0
80107339:	68 e0 00 00 00       	push   $0xe0
8010733e:	e9 17 f2 ff ff       	jmp    8010655a <alltraps>

80107343 <vector225>:
80107343:	6a 00                	push   $0x0
80107345:	68 e1 00 00 00       	push   $0xe1
8010734a:	e9 0b f2 ff ff       	jmp    8010655a <alltraps>

8010734f <vector226>:
8010734f:	6a 00                	push   $0x0
80107351:	68 e2 00 00 00       	push   $0xe2
80107356:	e9 ff f1 ff ff       	jmp    8010655a <alltraps>

8010735b <vector227>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 e3 00 00 00       	push   $0xe3
80107362:	e9 f3 f1 ff ff       	jmp    8010655a <alltraps>

80107367 <vector228>:
80107367:	6a 00                	push   $0x0
80107369:	68 e4 00 00 00       	push   $0xe4
8010736e:	e9 e7 f1 ff ff       	jmp    8010655a <alltraps>

80107373 <vector229>:
80107373:	6a 00                	push   $0x0
80107375:	68 e5 00 00 00       	push   $0xe5
8010737a:	e9 db f1 ff ff       	jmp    8010655a <alltraps>

8010737f <vector230>:
8010737f:	6a 00                	push   $0x0
80107381:	68 e6 00 00 00       	push   $0xe6
80107386:	e9 cf f1 ff ff       	jmp    8010655a <alltraps>

8010738b <vector231>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 e7 00 00 00       	push   $0xe7
80107392:	e9 c3 f1 ff ff       	jmp    8010655a <alltraps>

80107397 <vector232>:
80107397:	6a 00                	push   $0x0
80107399:	68 e8 00 00 00       	push   $0xe8
8010739e:	e9 b7 f1 ff ff       	jmp    8010655a <alltraps>

801073a3 <vector233>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 e9 00 00 00       	push   $0xe9
801073aa:	e9 ab f1 ff ff       	jmp    8010655a <alltraps>

801073af <vector234>:
801073af:	6a 00                	push   $0x0
801073b1:	68 ea 00 00 00       	push   $0xea
801073b6:	e9 9f f1 ff ff       	jmp    8010655a <alltraps>

801073bb <vector235>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 eb 00 00 00       	push   $0xeb
801073c2:	e9 93 f1 ff ff       	jmp    8010655a <alltraps>

801073c7 <vector236>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 ec 00 00 00       	push   $0xec
801073ce:	e9 87 f1 ff ff       	jmp    8010655a <alltraps>

801073d3 <vector237>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 ed 00 00 00       	push   $0xed
801073da:	e9 7b f1 ff ff       	jmp    8010655a <alltraps>

801073df <vector238>:
801073df:	6a 00                	push   $0x0
801073e1:	68 ee 00 00 00       	push   $0xee
801073e6:	e9 6f f1 ff ff       	jmp    8010655a <alltraps>

801073eb <vector239>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 ef 00 00 00       	push   $0xef
801073f2:	e9 63 f1 ff ff       	jmp    8010655a <alltraps>

801073f7 <vector240>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 f0 00 00 00       	push   $0xf0
801073fe:	e9 57 f1 ff ff       	jmp    8010655a <alltraps>

80107403 <vector241>:
80107403:	6a 00                	push   $0x0
80107405:	68 f1 00 00 00       	push   $0xf1
8010740a:	e9 4b f1 ff ff       	jmp    8010655a <alltraps>

8010740f <vector242>:
8010740f:	6a 00                	push   $0x0
80107411:	68 f2 00 00 00       	push   $0xf2
80107416:	e9 3f f1 ff ff       	jmp    8010655a <alltraps>

8010741b <vector243>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 f3 00 00 00       	push   $0xf3
80107422:	e9 33 f1 ff ff       	jmp    8010655a <alltraps>

80107427 <vector244>:
80107427:	6a 00                	push   $0x0
80107429:	68 f4 00 00 00       	push   $0xf4
8010742e:	e9 27 f1 ff ff       	jmp    8010655a <alltraps>

80107433 <vector245>:
80107433:	6a 00                	push   $0x0
80107435:	68 f5 00 00 00       	push   $0xf5
8010743a:	e9 1b f1 ff ff       	jmp    8010655a <alltraps>

8010743f <vector246>:
8010743f:	6a 00                	push   $0x0
80107441:	68 f6 00 00 00       	push   $0xf6
80107446:	e9 0f f1 ff ff       	jmp    8010655a <alltraps>

8010744b <vector247>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 f7 00 00 00       	push   $0xf7
80107452:	e9 03 f1 ff ff       	jmp    8010655a <alltraps>

80107457 <vector248>:
80107457:	6a 00                	push   $0x0
80107459:	68 f8 00 00 00       	push   $0xf8
8010745e:	e9 f7 f0 ff ff       	jmp    8010655a <alltraps>

80107463 <vector249>:
80107463:	6a 00                	push   $0x0
80107465:	68 f9 00 00 00       	push   $0xf9
8010746a:	e9 eb f0 ff ff       	jmp    8010655a <alltraps>

8010746f <vector250>:
8010746f:	6a 00                	push   $0x0
80107471:	68 fa 00 00 00       	push   $0xfa
80107476:	e9 df f0 ff ff       	jmp    8010655a <alltraps>

8010747b <vector251>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 fb 00 00 00       	push   $0xfb
80107482:	e9 d3 f0 ff ff       	jmp    8010655a <alltraps>

80107487 <vector252>:
80107487:	6a 00                	push   $0x0
80107489:	68 fc 00 00 00       	push   $0xfc
8010748e:	e9 c7 f0 ff ff       	jmp    8010655a <alltraps>

80107493 <vector253>:
80107493:	6a 00                	push   $0x0
80107495:	68 fd 00 00 00       	push   $0xfd
8010749a:	e9 bb f0 ff ff       	jmp    8010655a <alltraps>

8010749f <vector254>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 fe 00 00 00       	push   $0xfe
801074a6:	e9 af f0 ff ff       	jmp    8010655a <alltraps>

801074ab <vector255>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 ff 00 00 00       	push   $0xff
801074b2:	e9 a3 f0 ff ff       	jmp    8010655a <alltraps>
801074b7:	66 90                	xchg   %ax,%ax
801074b9:	66 90                	xchg   %ax,%ax
801074bb:	66 90                	xchg   %ax,%ax
801074bd:	66 90                	xchg   %ax,%ax
801074bf:	90                   	nop

801074c0 <deallocuvm.part.0>:
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	57                   	push   %edi
801074c4:	56                   	push   %esi
801074c5:	53                   	push   %ebx
801074c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801074cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801074d2:	83 ec 1c             	sub    $0x1c,%esp
801074d5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801074d8:	39 d3                	cmp    %edx,%ebx
801074da:	73 49                	jae    80107525 <deallocuvm.part.0+0x65>
801074dc:	89 c7                	mov    %eax,%edi
801074de:	eb 0c                	jmp    801074ec <deallocuvm.part.0+0x2c>
801074e0:	83 c0 01             	add    $0x1,%eax
801074e3:	c1 e0 16             	shl    $0x16,%eax
801074e6:	89 c3                	mov    %eax,%ebx
801074e8:	39 da                	cmp    %ebx,%edx
801074ea:	76 39                	jbe    80107525 <deallocuvm.part.0+0x65>
801074ec:	89 d8                	mov    %ebx,%eax
801074ee:	c1 e8 16             	shr    $0x16,%eax
801074f1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801074f4:	f6 c1 01             	test   $0x1,%cl
801074f7:	74 e7                	je     801074e0 <deallocuvm.part.0+0x20>
801074f9:	89 de                	mov    %ebx,%esi
801074fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107501:	c1 ee 0a             	shr    $0xa,%esi
80107504:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010750a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
80107511:	85 f6                	test   %esi,%esi
80107513:	74 cb                	je     801074e0 <deallocuvm.part.0+0x20>
80107515:	8b 06                	mov    (%esi),%eax
80107517:	a8 01                	test   $0x1,%al
80107519:	75 15                	jne    80107530 <deallocuvm.part.0+0x70>
8010751b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107521:	39 da                	cmp    %ebx,%edx
80107523:	77 c7                	ja     801074ec <deallocuvm.part.0+0x2c>
80107525:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107528:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010752b:	5b                   	pop    %ebx
8010752c:	5e                   	pop    %esi
8010752d:	5f                   	pop    %edi
8010752e:	5d                   	pop    %ebp
8010752f:	c3                   	ret    
80107530:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107535:	74 25                	je     8010755c <deallocuvm.part.0+0x9c>
80107537:	83 ec 0c             	sub    $0xc,%esp
8010753a:	05 00 00 00 80       	add    $0x80000000,%eax
8010753f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107542:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107548:	50                   	push   %eax
80107549:	e8 92 bc ff ff       	call   801031e0 <kfree>
8010754e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80107554:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107557:	83 c4 10             	add    $0x10,%esp
8010755a:	eb 8c                	jmp    801074e8 <deallocuvm.part.0+0x28>
8010755c:	83 ec 0c             	sub    $0xc,%esp
8010755f:	68 72 81 10 80       	push   $0x80108172
80107564:	e8 87 8f ff ff       	call   801004f0 <panic>
80107569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107570 <mappages>:
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	57                   	push   %edi
80107574:	56                   	push   %esi
80107575:	53                   	push   %ebx
80107576:	89 d3                	mov    %edx,%ebx
80107578:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010757e:	83 ec 1c             	sub    $0x1c,%esp
80107581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107584:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107588:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010758d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107590:	8b 45 08             	mov    0x8(%ebp),%eax
80107593:	29 d8                	sub    %ebx,%eax
80107595:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107598:	eb 3d                	jmp    801075d7 <mappages+0x67>
8010759a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075a0:	89 da                	mov    %ebx,%edx
801075a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075a7:	c1 ea 0a             	shr    $0xa,%edx
801075aa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075b0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
801075b7:	85 c0                	test   %eax,%eax
801075b9:	74 75                	je     80107630 <mappages+0xc0>
801075bb:	f6 00 01             	testb  $0x1,(%eax)
801075be:	0f 85 86 00 00 00    	jne    8010764a <mappages+0xda>
801075c4:	0b 75 0c             	or     0xc(%ebp),%esi
801075c7:	83 ce 01             	or     $0x1,%esi
801075ca:	89 30                	mov    %esi,(%eax)
801075cc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801075cf:	74 6f                	je     80107640 <mappages+0xd0>
801075d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801075da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801075dd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801075e0:	89 d8                	mov    %ebx,%eax
801075e2:	c1 e8 16             	shr    $0x16,%eax
801075e5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
801075e8:	8b 07                	mov    (%edi),%eax
801075ea:	a8 01                	test   $0x1,%al
801075ec:	75 b2                	jne    801075a0 <mappages+0x30>
801075ee:	e8 ad bd ff ff       	call   801033a0 <kalloc>
801075f3:	85 c0                	test   %eax,%eax
801075f5:	74 39                	je     80107630 <mappages+0xc0>
801075f7:	83 ec 04             	sub    $0x4,%esp
801075fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801075fd:	68 00 10 00 00       	push   $0x1000
80107602:	6a 00                	push   $0x0
80107604:	50                   	push   %eax
80107605:	e8 76 dd ff ff       	call   80105380 <memset>
8010760a:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010760d:	83 c4 10             	add    $0x10,%esp
80107610:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107616:	83 c8 07             	or     $0x7,%eax
80107619:	89 07                	mov    %eax,(%edi)
8010761b:	89 d8                	mov    %ebx,%eax
8010761d:	c1 e8 0a             	shr    $0xa,%eax
80107620:	25 fc 0f 00 00       	and    $0xffc,%eax
80107625:	01 d0                	add    %edx,%eax
80107627:	eb 92                	jmp    801075bb <mappages+0x4b>
80107629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107630:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107638:	5b                   	pop    %ebx
80107639:	5e                   	pop    %esi
8010763a:	5f                   	pop    %edi
8010763b:	5d                   	pop    %ebp
8010763c:	c3                   	ret    
8010763d:	8d 76 00             	lea    0x0(%esi),%esi
80107640:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107643:	31 c0                	xor    %eax,%eax
80107645:	5b                   	pop    %ebx
80107646:	5e                   	pop    %esi
80107647:	5f                   	pop    %edi
80107648:	5d                   	pop    %ebp
80107649:	c3                   	ret    
8010764a:	83 ec 0c             	sub    $0xc,%esp
8010764d:	68 a8 87 10 80       	push   $0x801087a8
80107652:	e8 99 8e ff ff       	call   801004f0 <panic>
80107657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765e:	66 90                	xchg   %ax,%ax

80107660 <seginit>:
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	83 ec 18             	sub    $0x18,%esp
80107666:	e8 05 d0 ff ff       	call   80104670 <cpuid>
8010766b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107670:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107676:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010767a:	c7 80 58 2e 11 80 ff 	movl   $0xffff,-0x7feed1a8(%eax)
80107681:	ff 00 00 
80107684:	c7 80 5c 2e 11 80 00 	movl   $0xcf9a00,-0x7feed1a4(%eax)
8010768b:	9a cf 00 
8010768e:	c7 80 60 2e 11 80 ff 	movl   $0xffff,-0x7feed1a0(%eax)
80107695:	ff 00 00 
80107698:	c7 80 64 2e 11 80 00 	movl   $0xcf9200,-0x7feed19c(%eax)
8010769f:	92 cf 00 
801076a2:	c7 80 68 2e 11 80 ff 	movl   $0xffff,-0x7feed198(%eax)
801076a9:	ff 00 00 
801076ac:	c7 80 6c 2e 11 80 00 	movl   $0xcffa00,-0x7feed194(%eax)
801076b3:	fa cf 00 
801076b6:	c7 80 70 2e 11 80 ff 	movl   $0xffff,-0x7feed190(%eax)
801076bd:	ff 00 00 
801076c0:	c7 80 74 2e 11 80 00 	movl   $0xcff200,-0x7feed18c(%eax)
801076c7:	f2 cf 00 
801076ca:	05 50 2e 11 80       	add    $0x80112e50,%eax
801076cf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
801076d3:	c1 e8 10             	shr    $0x10,%eax
801076d6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
801076da:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076dd:	0f 01 10             	lgdtl  (%eax)
801076e0:	c9                   	leave  
801076e1:	c3                   	ret    
801076e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801076f0 <switchkvm>:
801076f0:	a1 04 5b 11 80       	mov    0x80115b04,%eax
801076f5:	05 00 00 00 80       	add    $0x80000000,%eax
801076fa:	0f 22 d8             	mov    %eax,%cr3
801076fd:	c3                   	ret    
801076fe:	66 90                	xchg   %ax,%ax

80107700 <switchuvm>:
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	57                   	push   %edi
80107704:	56                   	push   %esi
80107705:	53                   	push   %ebx
80107706:	83 ec 1c             	sub    $0x1c,%esp
80107709:	8b 75 08             	mov    0x8(%ebp),%esi
8010770c:	85 f6                	test   %esi,%esi
8010770e:	0f 84 cb 00 00 00    	je     801077df <switchuvm+0xdf>
80107714:	8b 46 08             	mov    0x8(%esi),%eax
80107717:	85 c0                	test   %eax,%eax
80107719:	0f 84 da 00 00 00    	je     801077f9 <switchuvm+0xf9>
8010771f:	8b 46 04             	mov    0x4(%esi),%eax
80107722:	85 c0                	test   %eax,%eax
80107724:	0f 84 c2 00 00 00    	je     801077ec <switchuvm+0xec>
8010772a:	e8 41 da ff ff       	call   80105170 <pushcli>
8010772f:	e8 dc ce ff ff       	call   80104610 <mycpu>
80107734:	89 c3                	mov    %eax,%ebx
80107736:	e8 d5 ce ff ff       	call   80104610 <mycpu>
8010773b:	89 c7                	mov    %eax,%edi
8010773d:	e8 ce ce ff ff       	call   80104610 <mycpu>
80107742:	83 c7 08             	add    $0x8,%edi
80107745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107748:	e8 c3 ce ff ff       	call   80104610 <mycpu>
8010774d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107750:	ba 67 00 00 00       	mov    $0x67,%edx
80107755:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010775c:	83 c0 08             	add    $0x8,%eax
8010775f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107766:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010776b:	83 c1 08             	add    $0x8,%ecx
8010776e:	c1 e8 18             	shr    $0x18,%eax
80107771:	c1 e9 10             	shr    $0x10,%ecx
80107774:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010777a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107780:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107785:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
8010778c:	bb 10 00 00 00       	mov    $0x10,%ebx
80107791:	e8 7a ce ff ff       	call   80104610 <mycpu>
80107796:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
8010779d:	e8 6e ce ff ff       	call   80104610 <mycpu>
801077a2:	66 89 58 10          	mov    %bx,0x10(%eax)
801077a6:	8b 5e 08             	mov    0x8(%esi),%ebx
801077a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077af:	e8 5c ce ff ff       	call   80104610 <mycpu>
801077b4:	89 58 0c             	mov    %ebx,0xc(%eax)
801077b7:	e8 54 ce ff ff       	call   80104610 <mycpu>
801077bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
801077c0:	b8 28 00 00 00       	mov    $0x28,%eax
801077c5:	0f 00 d8             	ltr    %ax
801077c8:	8b 46 04             	mov    0x4(%esi),%eax
801077cb:	05 00 00 00 80       	add    $0x80000000,%eax
801077d0:	0f 22 d8             	mov    %eax,%cr3
801077d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d6:	5b                   	pop    %ebx
801077d7:	5e                   	pop    %esi
801077d8:	5f                   	pop    %edi
801077d9:	5d                   	pop    %ebp
801077da:	e9 e1 d9 ff ff       	jmp    801051c0 <popcli>
801077df:	83 ec 0c             	sub    $0xc,%esp
801077e2:	68 ae 87 10 80       	push   $0x801087ae
801077e7:	e8 04 8d ff ff       	call   801004f0 <panic>
801077ec:	83 ec 0c             	sub    $0xc,%esp
801077ef:	68 d9 87 10 80       	push   $0x801087d9
801077f4:	e8 f7 8c ff ff       	call   801004f0 <panic>
801077f9:	83 ec 0c             	sub    $0xc,%esp
801077fc:	68 c4 87 10 80       	push   $0x801087c4
80107801:	e8 ea 8c ff ff       	call   801004f0 <panic>
80107806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010780d:	8d 76 00             	lea    0x0(%esi),%esi

80107810 <inituvm>:
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
80107819:	8b 45 0c             	mov    0xc(%ebp),%eax
8010781c:	8b 75 10             	mov    0x10(%ebp),%esi
8010781f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107822:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107825:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010782b:	77 4b                	ja     80107878 <inituvm+0x68>
8010782d:	e8 6e bb ff ff       	call   801033a0 <kalloc>
80107832:	83 ec 04             	sub    $0x4,%esp
80107835:	68 00 10 00 00       	push   $0x1000
8010783a:	89 c3                	mov    %eax,%ebx
8010783c:	6a 00                	push   $0x0
8010783e:	50                   	push   %eax
8010783f:	e8 3c db ff ff       	call   80105380 <memset>
80107844:	58                   	pop    %eax
80107845:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010784b:	5a                   	pop    %edx
8010784c:	6a 06                	push   $0x6
8010784e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107853:	31 d2                	xor    %edx,%edx
80107855:	50                   	push   %eax
80107856:	89 f8                	mov    %edi,%eax
80107858:	e8 13 fd ff ff       	call   80107570 <mappages>
8010785d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107860:	89 75 10             	mov    %esi,0x10(%ebp)
80107863:	83 c4 10             	add    $0x10,%esp
80107866:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107869:	89 45 0c             	mov    %eax,0xc(%ebp)
8010786c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010786f:	5b                   	pop    %ebx
80107870:	5e                   	pop    %esi
80107871:	5f                   	pop    %edi
80107872:	5d                   	pop    %ebp
80107873:	e9 a8 db ff ff       	jmp    80105420 <memmove>
80107878:	83 ec 0c             	sub    $0xc,%esp
8010787b:	68 ed 87 10 80       	push   $0x801087ed
80107880:	e8 6b 8c ff ff       	call   801004f0 <panic>
80107885:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010788c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107890 <loaduvm>:
80107890:	55                   	push   %ebp
80107891:	89 e5                	mov    %esp,%ebp
80107893:	57                   	push   %edi
80107894:	56                   	push   %esi
80107895:	53                   	push   %ebx
80107896:	83 ec 1c             	sub    $0x1c,%esp
80107899:	8b 45 0c             	mov    0xc(%ebp),%eax
8010789c:	8b 75 18             	mov    0x18(%ebp),%esi
8010789f:	a9 ff 0f 00 00       	test   $0xfff,%eax
801078a4:	0f 85 bb 00 00 00    	jne    80107965 <loaduvm+0xd5>
801078aa:	01 f0                	add    %esi,%eax
801078ac:	89 f3                	mov    %esi,%ebx
801078ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801078b1:	8b 45 14             	mov    0x14(%ebp),%eax
801078b4:	01 f0                	add    %esi,%eax
801078b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801078b9:	85 f6                	test   %esi,%esi
801078bb:	0f 84 87 00 00 00    	je     80107948 <loaduvm+0xb8>
801078c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801078ce:	29 d8                	sub    %ebx,%eax
801078d0:	89 c2                	mov    %eax,%edx
801078d2:	c1 ea 16             	shr    $0x16,%edx
801078d5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801078d8:	f6 c2 01             	test   $0x1,%dl
801078db:	75 13                	jne    801078f0 <loaduvm+0x60>
801078dd:	83 ec 0c             	sub    $0xc,%esp
801078e0:	68 07 88 10 80       	push   $0x80108807
801078e5:	e8 06 8c ff ff       	call   801004f0 <panic>
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078f0:	c1 e8 0a             	shr    $0xa,%eax
801078f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801078f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801078fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107905:	85 c0                	test   %eax,%eax
80107907:	74 d4                	je     801078dd <loaduvm+0x4d>
80107909:	8b 00                	mov    (%eax),%eax
8010790b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010790e:	bf 00 10 00 00       	mov    $0x1000,%edi
80107913:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107918:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010791e:	0f 46 fb             	cmovbe %ebx,%edi
80107921:	29 d9                	sub    %ebx,%ecx
80107923:	05 00 00 00 80       	add    $0x80000000,%eax
80107928:	57                   	push   %edi
80107929:	51                   	push   %ecx
8010792a:	50                   	push   %eax
8010792b:	ff 75 10             	push   0x10(%ebp)
8010792e:	e8 7d ae ff ff       	call   801027b0 <readi>
80107933:	83 c4 10             	add    $0x10,%esp
80107936:	39 f8                	cmp    %edi,%eax
80107938:	75 1e                	jne    80107958 <loaduvm+0xc8>
8010793a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107940:	89 f0                	mov    %esi,%eax
80107942:	29 d8                	sub    %ebx,%eax
80107944:	39 c6                	cmp    %eax,%esi
80107946:	77 80                	ja     801078c8 <loaduvm+0x38>
80107948:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010794b:	31 c0                	xor    %eax,%eax
8010794d:	5b                   	pop    %ebx
8010794e:	5e                   	pop    %esi
8010794f:	5f                   	pop    %edi
80107950:	5d                   	pop    %ebp
80107951:	c3                   	ret    
80107952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107958:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010795b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107960:	5b                   	pop    %ebx
80107961:	5e                   	pop    %esi
80107962:	5f                   	pop    %edi
80107963:	5d                   	pop    %ebp
80107964:	c3                   	ret    
80107965:	83 ec 0c             	sub    $0xc,%esp
80107968:	68 a8 88 10 80       	push   $0x801088a8
8010796d:	e8 7e 8b ff ff       	call   801004f0 <panic>
80107972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107980 <allocuvm>:
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	57                   	push   %edi
80107984:	56                   	push   %esi
80107985:	53                   	push   %ebx
80107986:	83 ec 1c             	sub    $0x1c,%esp
80107989:	8b 45 10             	mov    0x10(%ebp),%eax
8010798c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010798f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107992:	85 c0                	test   %eax,%eax
80107994:	0f 88 b6 00 00 00    	js     80107a50 <allocuvm+0xd0>
8010799a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010799d:	8b 45 0c             	mov    0xc(%ebp),%eax
801079a0:	0f 82 9a 00 00 00    	jb     80107a40 <allocuvm+0xc0>
801079a6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801079ac:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801079b2:	39 75 10             	cmp    %esi,0x10(%ebp)
801079b5:	77 44                	ja     801079fb <allocuvm+0x7b>
801079b7:	e9 87 00 00 00       	jmp    80107a43 <allocuvm+0xc3>
801079bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801079c0:	83 ec 04             	sub    $0x4,%esp
801079c3:	68 00 10 00 00       	push   $0x1000
801079c8:	6a 00                	push   $0x0
801079ca:	50                   	push   %eax
801079cb:	e8 b0 d9 ff ff       	call   80105380 <memset>
801079d0:	58                   	pop    %eax
801079d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079d7:	5a                   	pop    %edx
801079d8:	6a 06                	push   $0x6
801079da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079df:	89 f2                	mov    %esi,%edx
801079e1:	50                   	push   %eax
801079e2:	89 f8                	mov    %edi,%eax
801079e4:	e8 87 fb ff ff       	call   80107570 <mappages>
801079e9:	83 c4 10             	add    $0x10,%esp
801079ec:	85 c0                	test   %eax,%eax
801079ee:	78 78                	js     80107a68 <allocuvm+0xe8>
801079f0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801079f6:	39 75 10             	cmp    %esi,0x10(%ebp)
801079f9:	76 48                	jbe    80107a43 <allocuvm+0xc3>
801079fb:	e8 a0 b9 ff ff       	call   801033a0 <kalloc>
80107a00:	89 c3                	mov    %eax,%ebx
80107a02:	85 c0                	test   %eax,%eax
80107a04:	75 ba                	jne    801079c0 <allocuvm+0x40>
80107a06:	83 ec 0c             	sub    $0xc,%esp
80107a09:	68 25 88 10 80       	push   $0x80108825
80107a0e:	e8 5d 90 ff ff       	call   80100a70 <cprintf>
80107a13:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a16:	83 c4 10             	add    $0x10,%esp
80107a19:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a1c:	74 32                	je     80107a50 <allocuvm+0xd0>
80107a1e:	8b 55 10             	mov    0x10(%ebp),%edx
80107a21:	89 c1                	mov    %eax,%ecx
80107a23:	89 f8                	mov    %edi,%eax
80107a25:	e8 96 fa ff ff       	call   801074c0 <deallocuvm.part.0>
80107a2a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107a31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a37:	5b                   	pop    %ebx
80107a38:	5e                   	pop    %esi
80107a39:	5f                   	pop    %edi
80107a3a:	5d                   	pop    %ebp
80107a3b:	c3                   	ret    
80107a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107a43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a49:	5b                   	pop    %ebx
80107a4a:	5e                   	pop    %esi
80107a4b:	5f                   	pop    %edi
80107a4c:	5d                   	pop    %ebp
80107a4d:	c3                   	ret    
80107a4e:	66 90                	xchg   %ax,%ax
80107a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107a57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a5d:	5b                   	pop    %ebx
80107a5e:	5e                   	pop    %esi
80107a5f:	5f                   	pop    %edi
80107a60:	5d                   	pop    %ebp
80107a61:	c3                   	ret    
80107a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a68:	83 ec 0c             	sub    $0xc,%esp
80107a6b:	68 3d 88 10 80       	push   $0x8010883d
80107a70:	e8 fb 8f ff ff       	call   80100a70 <cprintf>
80107a75:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a78:	83 c4 10             	add    $0x10,%esp
80107a7b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a7e:	74 0c                	je     80107a8c <allocuvm+0x10c>
80107a80:	8b 55 10             	mov    0x10(%ebp),%edx
80107a83:	89 c1                	mov    %eax,%ecx
80107a85:	89 f8                	mov    %edi,%eax
80107a87:	e8 34 fa ff ff       	call   801074c0 <deallocuvm.part.0>
80107a8c:	83 ec 0c             	sub    $0xc,%esp
80107a8f:	53                   	push   %ebx
80107a90:	e8 4b b7 ff ff       	call   801031e0 <kfree>
80107a95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107a9c:	83 c4 10             	add    $0x10,%esp
80107a9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107aa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aa5:	5b                   	pop    %ebx
80107aa6:	5e                   	pop    %esi
80107aa7:	5f                   	pop    %edi
80107aa8:	5d                   	pop    %ebp
80107aa9:	c3                   	ret    
80107aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ab0 <deallocuvm>:
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ab6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107ab9:	8b 45 08             	mov    0x8(%ebp),%eax
80107abc:	39 d1                	cmp    %edx,%ecx
80107abe:	73 10                	jae    80107ad0 <deallocuvm+0x20>
80107ac0:	5d                   	pop    %ebp
80107ac1:	e9 fa f9 ff ff       	jmp    801074c0 <deallocuvm.part.0>
80107ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107acd:	8d 76 00             	lea    0x0(%esi),%esi
80107ad0:	89 d0                	mov    %edx,%eax
80107ad2:	5d                   	pop    %ebp
80107ad3:	c3                   	ret    
80107ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107adf:	90                   	nop

80107ae0 <freevm>:
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	57                   	push   %edi
80107ae4:	56                   	push   %esi
80107ae5:	53                   	push   %ebx
80107ae6:	83 ec 0c             	sub    $0xc,%esp
80107ae9:	8b 75 08             	mov    0x8(%ebp),%esi
80107aec:	85 f6                	test   %esi,%esi
80107aee:	74 59                	je     80107b49 <freevm+0x69>
80107af0:	31 c9                	xor    %ecx,%ecx
80107af2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107af7:	89 f0                	mov    %esi,%eax
80107af9:	89 f3                	mov    %esi,%ebx
80107afb:	e8 c0 f9 ff ff       	call   801074c0 <deallocuvm.part.0>
80107b00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107b06:	eb 0f                	jmp    80107b17 <freevm+0x37>
80107b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b0f:	90                   	nop
80107b10:	83 c3 04             	add    $0x4,%ebx
80107b13:	39 df                	cmp    %ebx,%edi
80107b15:	74 23                	je     80107b3a <freevm+0x5a>
80107b17:	8b 03                	mov    (%ebx),%eax
80107b19:	a8 01                	test   $0x1,%al
80107b1b:	74 f3                	je     80107b10 <freevm+0x30>
80107b1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b22:	83 ec 0c             	sub    $0xc,%esp
80107b25:	83 c3 04             	add    $0x4,%ebx
80107b28:	05 00 00 00 80       	add    $0x80000000,%eax
80107b2d:	50                   	push   %eax
80107b2e:	e8 ad b6 ff ff       	call   801031e0 <kfree>
80107b33:	83 c4 10             	add    $0x10,%esp
80107b36:	39 df                	cmp    %ebx,%edi
80107b38:	75 dd                	jne    80107b17 <freevm+0x37>
80107b3a:	89 75 08             	mov    %esi,0x8(%ebp)
80107b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b40:	5b                   	pop    %ebx
80107b41:	5e                   	pop    %esi
80107b42:	5f                   	pop    %edi
80107b43:	5d                   	pop    %ebp
80107b44:	e9 97 b6 ff ff       	jmp    801031e0 <kfree>
80107b49:	83 ec 0c             	sub    $0xc,%esp
80107b4c:	68 59 88 10 80       	push   $0x80108859
80107b51:	e8 9a 89 ff ff       	call   801004f0 <panic>
80107b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b5d:	8d 76 00             	lea    0x0(%esi),%esi

80107b60 <setupkvm>:
80107b60:	55                   	push   %ebp
80107b61:	89 e5                	mov    %esp,%ebp
80107b63:	56                   	push   %esi
80107b64:	53                   	push   %ebx
80107b65:	e8 36 b8 ff ff       	call   801033a0 <kalloc>
80107b6a:	89 c6                	mov    %eax,%esi
80107b6c:	85 c0                	test   %eax,%eax
80107b6e:	74 42                	je     80107bb2 <setupkvm+0x52>
80107b70:	83 ec 04             	sub    $0x4,%esp
80107b73:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
80107b78:	68 00 10 00 00       	push   $0x1000
80107b7d:	6a 00                	push   $0x0
80107b7f:	50                   	push   %eax
80107b80:	e8 fb d7 ff ff       	call   80105380 <memset>
80107b85:	83 c4 10             	add    $0x10,%esp
80107b88:	8b 43 04             	mov    0x4(%ebx),%eax
80107b8b:	83 ec 08             	sub    $0x8,%esp
80107b8e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b91:	ff 73 0c             	push   0xc(%ebx)
80107b94:	8b 13                	mov    (%ebx),%edx
80107b96:	50                   	push   %eax
80107b97:	29 c1                	sub    %eax,%ecx
80107b99:	89 f0                	mov    %esi,%eax
80107b9b:	e8 d0 f9 ff ff       	call   80107570 <mappages>
80107ba0:	83 c4 10             	add    $0x10,%esp
80107ba3:	85 c0                	test   %eax,%eax
80107ba5:	78 19                	js     80107bc0 <setupkvm+0x60>
80107ba7:	83 c3 10             	add    $0x10,%ebx
80107baa:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107bb0:	75 d6                	jne    80107b88 <setupkvm+0x28>
80107bb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bb5:	89 f0                	mov    %esi,%eax
80107bb7:	5b                   	pop    %ebx
80107bb8:	5e                   	pop    %esi
80107bb9:	5d                   	pop    %ebp
80107bba:	c3                   	ret    
80107bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bbf:	90                   	nop
80107bc0:	83 ec 0c             	sub    $0xc,%esp
80107bc3:	56                   	push   %esi
80107bc4:	31 f6                	xor    %esi,%esi
80107bc6:	e8 15 ff ff ff       	call   80107ae0 <freevm>
80107bcb:	83 c4 10             	add    $0x10,%esp
80107bce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bd1:	89 f0                	mov    %esi,%eax
80107bd3:	5b                   	pop    %ebx
80107bd4:	5e                   	pop    %esi
80107bd5:	5d                   	pop    %ebp
80107bd6:	c3                   	ret    
80107bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bde:	66 90                	xchg   %ax,%ax

80107be0 <kvmalloc>:
80107be0:	55                   	push   %ebp
80107be1:	89 e5                	mov    %esp,%ebp
80107be3:	83 ec 08             	sub    $0x8,%esp
80107be6:	e8 75 ff ff ff       	call   80107b60 <setupkvm>
80107beb:	a3 04 5b 11 80       	mov    %eax,0x80115b04
80107bf0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bf5:	0f 22 d8             	mov    %eax,%cr3
80107bf8:	c9                   	leave  
80107bf9:	c3                   	ret    
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c00 <clearpteu>:
80107c00:	55                   	push   %ebp
80107c01:	89 e5                	mov    %esp,%ebp
80107c03:	83 ec 08             	sub    $0x8,%esp
80107c06:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c09:	8b 55 08             	mov    0x8(%ebp),%edx
80107c0c:	89 c1                	mov    %eax,%ecx
80107c0e:	c1 e9 16             	shr    $0x16,%ecx
80107c11:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c14:	f6 c2 01             	test   $0x1,%dl
80107c17:	75 17                	jne    80107c30 <clearpteu+0x30>
80107c19:	83 ec 0c             	sub    $0xc,%esp
80107c1c:	68 6a 88 10 80       	push   $0x8010886a
80107c21:	e8 ca 88 ff ff       	call   801004f0 <panic>
80107c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c2d:	8d 76 00             	lea    0x0(%esi),%esi
80107c30:	c1 e8 0a             	shr    $0xa,%eax
80107c33:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107c39:	25 fc 0f 00 00       	and    $0xffc,%eax
80107c3e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107c45:	85 c0                	test   %eax,%eax
80107c47:	74 d0                	je     80107c19 <clearpteu+0x19>
80107c49:	83 20 fb             	andl   $0xfffffffb,(%eax)
80107c4c:	c9                   	leave  
80107c4d:	c3                   	ret    
80107c4e:	66 90                	xchg   %ax,%ax

80107c50 <copyuvm>:
80107c50:	55                   	push   %ebp
80107c51:	89 e5                	mov    %esp,%ebp
80107c53:	57                   	push   %edi
80107c54:	56                   	push   %esi
80107c55:	53                   	push   %ebx
80107c56:	83 ec 1c             	sub    $0x1c,%esp
80107c59:	e8 02 ff ff ff       	call   80107b60 <setupkvm>
80107c5e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c61:	85 c0                	test   %eax,%eax
80107c63:	0f 84 bd 00 00 00    	je     80107d26 <copyuvm+0xd6>
80107c69:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c6c:	85 c9                	test   %ecx,%ecx
80107c6e:	0f 84 b2 00 00 00    	je     80107d26 <copyuvm+0xd6>
80107c74:	31 f6                	xor    %esi,%esi
80107c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c7d:	8d 76 00             	lea    0x0(%esi),%esi
80107c80:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107c83:	89 f0                	mov    %esi,%eax
80107c85:	c1 e8 16             	shr    $0x16,%eax
80107c88:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107c8b:	a8 01                	test   $0x1,%al
80107c8d:	75 11                	jne    80107ca0 <copyuvm+0x50>
80107c8f:	83 ec 0c             	sub    $0xc,%esp
80107c92:	68 74 88 10 80       	push   $0x80108874
80107c97:	e8 54 88 ff ff       	call   801004f0 <panic>
80107c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107ca0:	89 f2                	mov    %esi,%edx
80107ca2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ca7:	c1 ea 0a             	shr    $0xa,%edx
80107caa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107cb0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107cb7:	85 c0                	test   %eax,%eax
80107cb9:	74 d4                	je     80107c8f <copyuvm+0x3f>
80107cbb:	8b 00                	mov    (%eax),%eax
80107cbd:	a8 01                	test   $0x1,%al
80107cbf:	0f 84 9f 00 00 00    	je     80107d64 <copyuvm+0x114>
80107cc5:	89 c7                	mov    %eax,%edi
80107cc7:	25 ff 0f 00 00       	and    $0xfff,%eax
80107ccc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ccf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107cd5:	e8 c6 b6 ff ff       	call   801033a0 <kalloc>
80107cda:	89 c3                	mov    %eax,%ebx
80107cdc:	85 c0                	test   %eax,%eax
80107cde:	74 64                	je     80107d44 <copyuvm+0xf4>
80107ce0:	83 ec 04             	sub    $0x4,%esp
80107ce3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ce9:	68 00 10 00 00       	push   $0x1000
80107cee:	57                   	push   %edi
80107cef:	50                   	push   %eax
80107cf0:	e8 2b d7 ff ff       	call   80105420 <memmove>
80107cf5:	58                   	pop    %eax
80107cf6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107cfc:	5a                   	pop    %edx
80107cfd:	ff 75 e4             	push   -0x1c(%ebp)
80107d00:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d05:	89 f2                	mov    %esi,%edx
80107d07:	50                   	push   %eax
80107d08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d0b:	e8 60 f8 ff ff       	call   80107570 <mappages>
80107d10:	83 c4 10             	add    $0x10,%esp
80107d13:	85 c0                	test   %eax,%eax
80107d15:	78 21                	js     80107d38 <copyuvm+0xe8>
80107d17:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107d1d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d20:	0f 87 5a ff ff ff    	ja     80107c80 <copyuvm+0x30>
80107d26:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d2c:	5b                   	pop    %ebx
80107d2d:	5e                   	pop    %esi
80107d2e:	5f                   	pop    %edi
80107d2f:	5d                   	pop    %ebp
80107d30:	c3                   	ret    
80107d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d38:	83 ec 0c             	sub    $0xc,%esp
80107d3b:	53                   	push   %ebx
80107d3c:	e8 9f b4 ff ff       	call   801031e0 <kfree>
80107d41:	83 c4 10             	add    $0x10,%esp
80107d44:	83 ec 0c             	sub    $0xc,%esp
80107d47:	ff 75 e0             	push   -0x20(%ebp)
80107d4a:	e8 91 fd ff ff       	call   80107ae0 <freevm>
80107d4f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d56:	83 c4 10             	add    $0x10,%esp
80107d59:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d5f:	5b                   	pop    %ebx
80107d60:	5e                   	pop    %esi
80107d61:	5f                   	pop    %edi
80107d62:	5d                   	pop    %ebp
80107d63:	c3                   	ret    
80107d64:	83 ec 0c             	sub    $0xc,%esp
80107d67:	68 8e 88 10 80       	push   $0x8010888e
80107d6c:	e8 7f 87 ff ff       	call   801004f0 <panic>
80107d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d7f:	90                   	nop

80107d80 <uva2ka>:
80107d80:	55                   	push   %ebp
80107d81:	89 e5                	mov    %esp,%ebp
80107d83:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d86:	8b 55 08             	mov    0x8(%ebp),%edx
80107d89:	89 c1                	mov    %eax,%ecx
80107d8b:	c1 e9 16             	shr    $0x16,%ecx
80107d8e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107d91:	f6 c2 01             	test   $0x1,%dl
80107d94:	0f 84 00 01 00 00    	je     80107e9a <uva2ka.cold>
80107d9a:	c1 e8 0c             	shr    $0xc,%eax
80107d9d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107da3:	5d                   	pop    %ebp
80107da4:	25 ff 03 00 00       	and    $0x3ff,%eax
80107da9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
80107db0:	89 c2                	mov    %eax,%edx
80107db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107db7:	83 e2 05             	and    $0x5,%edx
80107dba:	05 00 00 00 80       	add    $0x80000000,%eax
80107dbf:	83 fa 05             	cmp    $0x5,%edx
80107dc2:	ba 00 00 00 00       	mov    $0x0,%edx
80107dc7:	0f 45 c2             	cmovne %edx,%eax
80107dca:	c3                   	ret    
80107dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107dcf:	90                   	nop

80107dd0 <copyout>:
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	57                   	push   %edi
80107dd4:	56                   	push   %esi
80107dd5:	53                   	push   %ebx
80107dd6:	83 ec 0c             	sub    $0xc,%esp
80107dd9:	8b 75 14             	mov    0x14(%ebp),%esi
80107ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ddf:	8b 55 10             	mov    0x10(%ebp),%edx
80107de2:	85 f6                	test   %esi,%esi
80107de4:	75 51                	jne    80107e37 <copyout+0x67>
80107de6:	e9 a5 00 00 00       	jmp    80107e90 <copyout+0xc0>
80107deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107def:	90                   	nop
80107df0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107df6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
80107dfc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107e02:	74 75                	je     80107e79 <copyout+0xa9>
80107e04:	89 fb                	mov    %edi,%ebx
80107e06:	89 55 10             	mov    %edx,0x10(%ebp)
80107e09:	29 c3                	sub    %eax,%ebx
80107e0b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e11:	39 f3                	cmp    %esi,%ebx
80107e13:	0f 47 de             	cmova  %esi,%ebx
80107e16:	29 f8                	sub    %edi,%eax
80107e18:	83 ec 04             	sub    $0x4,%esp
80107e1b:	01 c1                	add    %eax,%ecx
80107e1d:	53                   	push   %ebx
80107e1e:	52                   	push   %edx
80107e1f:	51                   	push   %ecx
80107e20:	e8 fb d5 ff ff       	call   80105420 <memmove>
80107e25:	8b 55 10             	mov    0x10(%ebp),%edx
80107e28:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
80107e2e:	83 c4 10             	add    $0x10,%esp
80107e31:	01 da                	add    %ebx,%edx
80107e33:	29 de                	sub    %ebx,%esi
80107e35:	74 59                	je     80107e90 <copyout+0xc0>
80107e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107e3a:	89 c1                	mov    %eax,%ecx
80107e3c:	89 c7                	mov    %eax,%edi
80107e3e:	c1 e9 16             	shr    $0x16,%ecx
80107e41:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107e47:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107e4a:	f6 c1 01             	test   $0x1,%cl
80107e4d:	0f 84 4e 00 00 00    	je     80107ea1 <copyout.cold>
80107e53:	89 fb                	mov    %edi,%ebx
80107e55:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107e5b:	c1 eb 0c             	shr    $0xc,%ebx
80107e5e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80107e64:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
80107e6b:	89 d9                	mov    %ebx,%ecx
80107e6d:	83 e1 05             	and    $0x5,%ecx
80107e70:	83 f9 05             	cmp    $0x5,%ecx
80107e73:	0f 84 77 ff ff ff    	je     80107df0 <copyout+0x20>
80107e79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e81:	5b                   	pop    %ebx
80107e82:	5e                   	pop    %esi
80107e83:	5f                   	pop    %edi
80107e84:	5d                   	pop    %ebp
80107e85:	c3                   	ret    
80107e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8d:	8d 76 00             	lea    0x0(%esi),%esi
80107e90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e93:	31 c0                	xor    %eax,%eax
80107e95:	5b                   	pop    %ebx
80107e96:	5e                   	pop    %esi
80107e97:	5f                   	pop    %edi
80107e98:	5d                   	pop    %ebp
80107e99:	c3                   	ret    

80107e9a <uva2ka.cold>:
80107e9a:	a1 00 00 00 00       	mov    0x0,%eax
80107e9f:	0f 0b                	ud2    

80107ea1 <copyout.cold>:
80107ea1:	a1 00 00 00 00       	mov    0x0,%eax
80107ea6:	0f 0b                	ud2    
