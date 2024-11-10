
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
8010002d:	b8 30 3d 10 80       	mov    $0x80103d30,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 80 80 10 80       	push   $0x80108080
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 55 50 00 00       	call   801050b0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 80 10 80       	push   $0x80108087
80100097:	50                   	push   %eax
80100098:	e8 e3 4e 00 00       	call   80104f80 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 b7 51 00 00       	call   801052a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 d9 50 00 00       	call   80105240 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 4e 00 00       	call   80104fc0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 3f 2e 00 00       	call   80102fd0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 8e 80 10 80       	push   $0x8010808e
801001a6:	e8 65 03 00 00       	call   80100510 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 9d 4e 00 00       	call   80105060 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 f7 2d 00 00       	jmp    80102fd0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 9f 80 10 80       	push   $0x8010809f
801001e1:	e8 2a 03 00 00       	call   80100510 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 4e 00 00       	call   80105060 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 0c 4e 00 00       	call   80105020 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 80 50 00 00       	call   801052a0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 d2 4f 00 00       	jmp    80105240 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 a6 80 10 80       	push   $0x801080a6
80100276:	e8 95 02 00 00       	call   80100510 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <int_to_str>:




static int int_to_str(int num, char str[]) 
{
80100280:	55                   	push   %ebp
80100281:	89 c1                	mov    %eax,%ecx
80100283:	31 c0                	xor    %eax,%eax
80100285:	89 e5                	mov    %esp,%ebp
80100287:	57                   	push   %edi
80100288:	56                   	push   %esi
80100289:	89 d6                	mov    %edx,%esi
8010028b:	53                   	push   %ebx
8010028c:	83 ec 04             	sub    $0x4,%esp
    int i = 0;
    int is_negative = 0;
    if (num < 0) {
8010028f:	85 c9                	test   %ecx,%ecx
80100291:	79 07                	jns    8010029a <int_to_str+0x1a>
        is_negative = 1;
        num = -num;
80100293:	f7 d9                	neg    %ecx
        is_negative = 1;
80100295:	b8 01 00 00 00       	mov    $0x1,%eax
    }
    do {
        str[i++] = (num % 10) + '0';
8010029a:	89 45 f0             	mov    %eax,-0x10(%ebp)
        is_negative = 1;
8010029d:	31 ff                	xor    %edi,%edi
8010029f:	90                   	nop
        str[i++] = (num % 10) + '0';
801002a0:	b8 67 66 66 66       	mov    $0x66666667,%eax
801002a5:	89 fb                	mov    %edi,%ebx
801002a7:	83 c7 01             	add    $0x1,%edi
801002aa:	f7 e9                	imul   %ecx
801002ac:	89 c8                	mov    %ecx,%eax
801002ae:	c1 f8 1f             	sar    $0x1f,%eax
801002b1:	c1 fa 02             	sar    $0x2,%edx
801002b4:	29 c2                	sub    %eax,%edx
801002b6:	8d 04 92             	lea    (%edx,%edx,4),%eax
801002b9:	01 c0                	add    %eax,%eax
801002bb:	29 c1                	sub    %eax,%ecx
801002bd:	83 c1 30             	add    $0x30,%ecx
801002c0:	88 4c 3e ff          	mov    %cl,-0x1(%esi,%edi,1)
        num /= 10;
801002c4:	89 d1                	mov    %edx,%ecx
    } while (num != 0);
801002c6:	85 d2                	test   %edx,%edx
801002c8:	75 d6                	jne    801002a0 <int_to_str+0x20>
    if (is_negative) {
        str[i++] = '-';
801002ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801002cd:	8d 14 3e             	lea    (%esi,%edi,1),%edx
    if (is_negative) {
801002d0:	85 c0                	test   %eax,%eax
801002d2:	74 3c                	je     80100310 <int_to_str+0x90>
        str[i++] = '-';
801002d4:	8d 43 02             	lea    0x2(%ebx),%eax
801002d7:	c6 02 2d             	movb   $0x2d,(%edx)
    }
    str[i] = '\0';
801002da:	c6 44 1e 02 00       	movb   $0x0,0x2(%esi,%ebx,1)
      int end = length - 1;
801002df:	89 fb                	mov    %edi,%ebx
        str[i++] = '-';
801002e1:	89 c7                	mov    %eax,%edi
801002e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
          char temp = str[start];
801002e8:	0f b6 14 0e          	movzbl (%esi,%ecx,1),%edx
          str[start] = str[end];
801002ec:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801002f0:	88 04 0e             	mov    %al,(%esi,%ecx,1)
          start++;
801002f3:	83 c1 01             	add    $0x1,%ecx
          str[end] = temp;
801002f6:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
          end--;
801002f9:	83 eb 01             	sub    $0x1,%ebx
      while (start < end) 
801002fc:	39 d9                	cmp    %ebx,%ecx
801002fe:	7c e8                	jl     801002e8 <int_to_str+0x68>
    reverse(str, i);
    return i;
}
80100300:	83 c4 04             	add    $0x4,%esp
80100303:	89 f8                	mov    %edi,%eax
80100305:	5b                   	pop    %ebx
80100306:	5e                   	pop    %esi
80100307:	5f                   	pop    %edi
80100308:	5d                   	pop    %ebp
80100309:	c3                   	ret
8010030a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    str[i] = '\0';
80100310:	c6 02 00             	movb   $0x0,(%edx)
      while (start < end) 
80100313:	85 db                	test   %ebx,%ebx
80100315:	75 d1                	jne    801002e8 <int_to_str+0x68>
}
80100317:	83 c4 04             	add    $0x4,%esp
8010031a:	89 f8                	mov    %edi,%eax
8010031c:	5b                   	pop    %ebx
8010031d:	5e                   	pop    %esi
8010031e:	5f                   	pop    %edi
8010031f:	5d                   	pop    %ebp
80100320:	c3                   	ret
80100321:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100328:	00 
80100329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
80100350:	e8 4b 4f 00 00       	call   801052a0 <acquire>
  while(n > 0){
80100355:	83 c4 10             	add    $0x10,%esp
80100358:	85 db                	test   %ebx,%ebx
8010035a:	0f 8e 94 00 00 00    	jle    801003f4 <consoleread+0xc4>
    while(input.r == input.w){
80100360:	a1 40 05 11 80       	mov    0x80110540,%eax
80100365:	39 05 44 05 11 80    	cmp    %eax,0x80110544
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
8010037d:	e8 9e 49 00 00       	call   80104d20 <sleep>
    while(input.r == input.w){
80100382:	a1 40 05 11 80       	mov    0x80110540,%eax
80100387:	83 c4 10             	add    $0x10,%esp
8010038a:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
80100390:	75 36                	jne    801003c8 <consoleread+0x98>
      if(myproc()->killed){
80100392:	e8 c9 42 00 00       	call   80104660 <myproc>
80100397:	8b 48 24             	mov    0x24(%eax),%ecx
8010039a:	85 c9                	test   %ecx,%ecx
8010039c:	74 d2                	je     80100370 <consoleread+0x40>
        release(&cons.lock);
8010039e:	83 ec 0c             	sub    $0xc,%esp
801003a1:	68 60 05 11 80       	push   $0x80110560
801003a6:	e8 95 4e 00 00       	call   80105240 <release>
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
801003fc:	e8 3f 4e 00 00       	call   80105240 <release>
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
80100424:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010042b:	00 
8010042c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100430 <read_num.constprop.0>:
static int read_num(int start_index,int *end_index)
80100430:	55                   	push   %ebp
80100431:	89 e5                	mov    %esp,%ebp
80100433:	57                   	push   %edi
80100434:	56                   	push   %esi
80100435:	89 c6                	mov    %eax,%esi
80100437:	53                   	push   %ebx
80100438:	83 ec 10             	sub    $0x10,%esp
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
8010043b:	a1 44 05 11 80       	mov    0x80110544,%eax
80100440:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100443:	39 f0                	cmp    %esi,%eax
80100445:	0f 8f ba 00 00 00    	jg     80100505 <read_num.constprop.0+0xd5>
    if(input.buf[i]>=48 && input.buf[i]<=57)
8010044b:	0f b6 9e c0 04 11 80 	movzbl -0x7feefb40(%esi),%ebx
80100452:	89 d7                	mov    %edx,%edi
80100454:	31 c9                	xor    %ecx,%ecx
  int result = 1;
80100456:	b8 01 00 00 00       	mov    $0x1,%eax
8010045b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if(input.buf[i]>=48 && input.buf[i]<=57)
80100462:	8d 53 d0             	lea    -0x30(%ebx),%edx
80100465:	80 fa 09             	cmp    $0x9,%dl
80100468:	77 54                	ja     801004be <read_num.constprop.0+0x8e>
8010046a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010046d:	8d 76 00             	lea    0x0(%esi),%esi
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
80100470:	83 eb 30             	sub    $0x30,%ebx
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
80100473:	83 ee 01             	sub    $0x1,%esi
80100476:	89 cf                	mov    %ecx,%edi
      count++;
80100478:	83 c1 01             	add    $0x1,%ecx
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
8010047b:	0f be db             	movsbl %bl,%ebx
8010047e:	0f af d8             	imul   %eax,%ebx
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
80100481:	8b 45 e8             	mov    -0x18(%ebp),%eax
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
80100484:	01 5d ec             	add    %ebx,-0x14(%ebp)
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
80100487:	39 c6                	cmp    %eax,%esi
80100489:	7c 3d                	jl     801004c8 <read_num.constprop.0+0x98>
    if(input.buf[i]>=48 && input.buf[i]<=57)
8010048b:	0f b6 9e c0 04 11 80 	movzbl -0x7feefb40(%esi),%ebx
80100492:	8d 43 d0             	lea    -0x30(%ebx),%eax
80100495:	3c 09                	cmp    $0x9,%al
80100497:	77 22                	ja     801004bb <read_num.constprop.0+0x8b>
  int result = 1;
80100499:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  for(int i=0 ; i<y ; i++)
8010049c:	31 d2                	xor    %edx,%edx
  int result = 1;
8010049e:	b8 01 00 00 00       	mov    $0x1,%eax
801004a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    result *= x;
801004a8:	8d 04 80             	lea    (%eax,%eax,4),%eax
801004ab:	89 d1                	mov    %edx,%ecx
  for(int i=0 ; i<y ; i++)
801004ad:	83 c2 01             	add    $0x1,%edx
    result *= x;
801004b0:	01 c0                	add    %eax,%eax
  for(int i=0 ; i<y ; i++)
801004b2:	39 f9                	cmp    %edi,%ecx
801004b4:	75 f2                	jne    801004a8 <read_num.constprop.0+0x78>
801004b6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801004b9:	eb b5                	jmp    80100470 <read_num.constprop.0+0x40>
801004bb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    else if ((input.buf[i]==45) && ((input.buf[i-1]==42) || (input.buf[i-1]==43) ||(input.buf[i-1]==45) ||(input.buf[i-1]==47)))
801004be:	80 fb 2d             	cmp    $0x2d,%bl
801004c1:	74 10                	je     801004d3 <read_num.constprop.0+0xa3>
      *end_index = i+1;
801004c3:	83 c6 01             	add    $0x1,%esi
801004c6:	89 37                	mov    %esi,(%edi)
}
801004c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004cb:	83 c4 10             	add    $0x10,%esp
801004ce:	5b                   	pop    %ebx
801004cf:	5e                   	pop    %esi
801004d0:	5f                   	pop    %edi
801004d1:	5d                   	pop    %ebp
801004d2:	c3                   	ret
801004d3:	0f b6 86 bf 04 11 80 	movzbl -0x7feefb41(%esi),%eax
801004da:	83 e8 2a             	sub    $0x2a,%eax
801004dd:	3c 05                	cmp    $0x5,%al
801004df:	77 1a                	ja     801004fb <read_num.constprop.0+0xcb>
801004e1:	ba 2b 00 00 00       	mov    $0x2b,%edx
801004e6:	0f a3 c2             	bt     %eax,%edx
801004e9:	73 10                	jae    801004fb <read_num.constprop.0+0xcb>
      *end_index = i;
801004eb:	89 37                	mov    %esi,(%edi)
      num = -num;
801004ed:	f7 5d ec             	negl   -0x14(%ebp)
}
801004f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f3:	83 c4 10             	add    $0x10,%esp
801004f6:	5b                   	pop    %ebx
801004f7:	5e                   	pop    %esi
801004f8:	5f                   	pop    %edi
801004f9:	5d                   	pop    %ebp
801004fa:	c3                   	ret
    else if ((input.buf[i]==45) && (i==(int)input.r))
801004fb:	39 35 40 05 11 80    	cmp    %esi,0x80110540
80100501:	75 c0                	jne    801004c3 <read_num.constprop.0+0x93>
80100503:	eb e6                	jmp    801004eb <read_num.constprop.0+0xbb>
  int num = 0;
80100505:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  return num;
8010050c:	eb ba                	jmp    801004c8 <read_num.constprop.0+0x98>
8010050e:	66 90                	xchg   %ax,%ax

80100510 <panic>:
{
80100510:	55                   	push   %ebp
80100511:	89 e5                	mov    %esp,%ebp
80100513:	56                   	push   %esi
80100514:	53                   	push   %ebx
80100515:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100518:	fa                   	cli
  cons.locking = 0;
80100519:	c7 05 94 05 11 80 00 	movl   $0x0,0x80110594
80100520:	00 00 00 
  getcallerpcs(&s, pcs);
80100523:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100526:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100529:	e8 a2 30 00 00       	call   801035d0 <lapicid>
8010052e:	83 ec 08             	sub    $0x8,%esp
80100531:	50                   	push   %eax
80100532:	68 ad 80 10 80       	push   $0x801080ad
80100537:	e8 54 05 00 00       	call   80100a90 <cprintf>
  cprintf(s);
8010053c:	58                   	pop    %eax
8010053d:	ff 75 08             	push   0x8(%ebp)
80100540:	e8 4b 05 00 00       	call   80100a90 <cprintf>
  cprintf("\n");
80100545:	c7 04 24 64 85 10 80 	movl   $0x80108564,(%esp)
8010054c:	e8 3f 05 00 00       	call   80100a90 <cprintf>
  getcallerpcs(&s, pcs);
80100551:	8d 45 08             	lea    0x8(%ebp),%eax
80100554:	5a                   	pop    %edx
80100555:	59                   	pop    %ecx
80100556:	53                   	push   %ebx
80100557:	50                   	push   %eax
80100558:	e8 73 4b 00 00       	call   801050d0 <getcallerpcs>
  for(i=0; i<10; i++)
8010055d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100560:	83 ec 08             	sub    $0x8,%esp
80100563:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100565:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100568:	68 c1 80 10 80       	push   $0x801080c1
8010056d:	e8 1e 05 00 00       	call   80100a90 <cprintf>
  for(i=0; i<10; i++)
80100572:	83 c4 10             	add    $0x10,%esp
80100575:	39 f3                	cmp    %esi,%ebx
80100577:	75 e7                	jne    80100560 <panic+0x50>
  panicked = 1; // freeze other CPU
80100579:	c7 05 9c 05 11 80 01 	movl   $0x1,0x8011059c
80100580:	00 00 00 
  for(;;)
80100583:	eb fe                	jmp    80100583 <panic+0x73>
80100585:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058c:	00 
8010058d:	8d 76 00             	lea    0x0(%esi),%esi

80100590 <cgaputc>:
{
80100590:	55                   	push   %ebp
80100591:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100593:	b8 0e 00 00 00       	mov    $0xe,%eax
80100598:	89 e5                	mov    %esp,%ebp
8010059a:	57                   	push   %edi
8010059b:	bf d4 03 00 00       	mov    $0x3d4,%edi
801005a0:	56                   	push   %esi
801005a1:	89 fa                	mov    %edi,%edx
801005a3:	53                   	push   %ebx
801005a4:	83 ec 1c             	sub    $0x1c,%esp
801005a7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801005a8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801005ad:	89 da                	mov    %ebx,%edx
801005af:	ec                   	in     (%dx),%al
  position = inb(CRTPORT+1) << 8;
801005b0:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005b3:	89 fa                	mov    %edi,%edx
801005b5:	b8 0f 00 00 00       	mov    $0xf,%eax
801005ba:	c1 e6 08             	shl    $0x8,%esi
801005bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801005be:	89 da                	mov    %ebx,%edx
801005c0:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT+1);
801005c1:	0f b6 d8             	movzbl %al,%ebx
801005c4:	09 f3                	or     %esi,%ebx
  if(c == '\n')
801005c6:	83 f9 0a             	cmp    $0xa,%ecx
801005c9:	0f 84 21 01 00 00    	je     801006f0 <cgaputc+0x160>
  else if(c == BACKSPACE){
801005cf:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
801005d5:	0f 84 3d 01 00 00    	je     80100718 <cgaputc+0x188>
  else if(c==RIGHT_ARROW)
801005db:	81 f9 e5 00 00 00    	cmp    $0xe5,%ecx
801005e1:	0f 85 89 00 00 00    	jne    80100670 <cgaputc+0xe0>
  if(position < 0 || position > 25*80)
801005e7:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801005ed:	0f 8f bb 01 00 00    	jg     801007ae <cgaputc+0x21e>
  outb(CRTPORT+1, position>>8);
801005f3:	0f b6 f7             	movzbl %bh,%esi
  if((position/80) >= 24){  // Scroll up.
801005f6:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801005fc:	7e 3e                	jle    8010063c <cgaputc+0xac>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005fe:	83 ec 04             	sub    $0x4,%esp
    position -= 80;
80100601:	83 eb 50             	sub    $0x50,%ebx
  outb(CRTPORT+1, position);
80100604:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100609:	68 60 0e 00 00       	push   $0xe60
8010060e:	68 a0 80 0b 80       	push   $0x800b80a0
80100613:	68 00 80 0b 80       	push   $0x800b8000
80100618:	e8 13 4e 00 00       	call   80105430 <memmove>
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
8010061d:	b8 80 07 00 00       	mov    $0x780,%eax
80100622:	83 c4 0c             	add    $0xc,%esp
80100625:	29 d8                	sub    %ebx,%eax
80100627:	01 c0                	add    %eax,%eax
80100629:	50                   	push   %eax
8010062a:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100631:	6a 00                	push   $0x0
80100633:	50                   	push   %eax
80100634:	e8 67 4d 00 00       	call   801053a0 <memset>
  outb(CRTPORT+1, position);
80100639:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010063c:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100641:	b8 0e 00 00 00       	mov    $0xe,%eax
80100646:	89 fa                	mov    %edi,%edx
80100648:	ee                   	out    %al,(%dx)
80100649:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010064e:	89 f0                	mov    %esi,%eax
80100650:	89 ca                	mov    %ecx,%edx
80100652:	ee                   	out    %al,(%dx)
80100653:	b8 0f 00 00 00       	mov    $0xf,%eax
80100658:	89 fa                	mov    %edi,%edx
8010065a:	ee                   	out    %al,(%dx)
8010065b:	89 d8                	mov    %ebx,%eax
8010065d:	89 ca                	mov    %ecx,%edx
8010065f:	ee                   	out    %al,(%dx)
}
80100660:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100663:	5b                   	pop    %ebx
80100664:	5e                   	pop    %esi
80100665:	5f                   	pop    %edi
80100666:	5d                   	pop    %ebp
80100667:	c3                   	ret
80100668:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010066f:	00 
  for (int i = position + backs; i > position; i--)
80100670:	8b 15 98 05 11 80    	mov    0x80110598,%edx
80100676:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80100679:	39 c3                	cmp    %eax,%ebx
8010067b:	7d 21                	jge    8010069e <cgaputc+0x10e>
8010067d:	8d 84 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%eax
80100684:	8d bc 1b fe 7f 0b 80 	lea    -0x7ff48002(%ebx,%ebx,1),%edi
8010068b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    crt[i] = crt[i - 1]; // shift to right all letters after cursor position
80100690:	0f b7 30             	movzwl (%eax),%esi
  for (int i = position + backs; i > position; i--)
80100693:	83 e8 02             	sub    $0x2,%eax
    crt[i] = crt[i - 1]; // shift to right all letters after cursor position
80100696:	66 89 70 04          	mov    %si,0x4(%eax)
  for (int i = position + backs; i > position; i--)
8010069a:	39 c7                	cmp    %eax,%edi
8010069c:	75 f2                	jne    80100690 <cgaputc+0x100>
  char last = input.buf[input.e-1];
8010069e:	a1 48 05 11 80       	mov    0x80110548,%eax
801006a3:	8d 70 ff             	lea    -0x1(%eax),%esi
801006a6:	0f b6 b8 bf 04 11 80 	movzbl -0x7feefb41(%eax),%edi
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
801006ad:	29 d6                	sub    %edx,%esi
801006af:	39 c6                	cmp    %eax,%esi
801006b1:	73 19                	jae    801006cc <cgaputc+0x13c>
801006b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    input.buf[i] = input.buf[i - 1]; // shift to right all letters in buffer
801006b8:	0f b6 90 bf 04 11 80 	movzbl -0x7feefb41(%eax),%edx
801006bf:	83 e8 01             	sub    $0x1,%eax
801006c2:	88 90 c1 04 11 80    	mov    %dl,-0x7feefb3f(%eax)
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
801006c8:	39 c6                	cmp    %eax,%esi
801006ca:	72 ec                	jb     801006b8 <cgaputc+0x128>
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006cc:	0f b6 c9             	movzbl %cl,%ecx
  input.buf[input.e-backs-1] = last;
801006cf:	89 f8                	mov    %edi,%eax
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006d1:	80 cd 07             	or     $0x7,%ch
  input.buf[input.e-backs-1] = last;
801006d4:	88 86 c0 04 11 80    	mov    %al,-0x7feefb40(%esi)
    crt[position++] = (c&0xff) | 0x0700;  // black on white
801006da:	66 89 8c 1b 00 80 0b 	mov    %cx,-0x7ff48000(%ebx,%ebx,1)
801006e1:	80 
801006e2:	83 c3 01             	add    $0x1,%ebx
801006e5:	e9 fd fe ff ff       	jmp    801005e7 <cgaputc+0x57>
801006ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    backs = 0; //(jadid) by going to next the line, back variable resets 
801006f0:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
801006f7:	00 00 00 
    position += 80 - position%80;
801006fa:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
801006ff:	f7 e3                	mul    %ebx
80100701:	c1 ea 06             	shr    $0x6,%edx
80100704:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100707:	c1 e0 04             	shl    $0x4,%eax
8010070a:	8d 58 50             	lea    0x50(%eax),%ebx
    backs = 0; //(jadid) by going to next the line, back variable resets 
8010070d:	e9 d5 fe ff ff       	jmp    801005e7 <cgaputc+0x57>
80100712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (int i = position - 1; i < position + backs; i++)
80100718:	8b 35 98 05 11 80    	mov    0x80110598,%esi
8010071e:	8d 7b ff             	lea    -0x1(%ebx),%edi
80100721:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100728:	89 fa                	mov    %edi,%edx
8010072a:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
8010072d:	85 f6                	test   %esi,%esi
8010072f:	78 1b                	js     8010074c <cgaputc+0x1bc>
80100731:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    crt[i] = crt[i + 1]; // shift to left all letters after cursor position
80100738:	0f b7 18             	movzwl (%eax),%ebx
  for (int i = position - 1; i < position + backs; i++)
8010073b:	83 c2 01             	add    $0x1,%edx
8010073e:	83 c0 02             	add    $0x2,%eax
    crt[i] = crt[i + 1]; // shift to left all letters after cursor position
80100741:	66 89 58 fc          	mov    %bx,-0x4(%eax)
  for (int i = position - 1; i < position + backs; i++)
80100745:	39 d1                	cmp    %edx,%ecx
80100747:	7f ef                	jg     80100738 <cgaputc+0x1a8>
80100749:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  for (int i = input.e - backs; i < input.e; i++ )// jadid
8010074c:	8b 15 48 05 11 80    	mov    0x80110548,%edx
80100752:	89 d1                	mov    %edx,%ecx
80100754:	29 f1                	sub    %esi,%ecx
80100756:	89 ce                	mov    %ecx,%esi
80100758:	39 d1                	cmp    %edx,%ecx
8010075a:	73 49                	jae    801007a5 <cgaputc+0x215>
8010075c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010075f:	90                   	nop
    input.buf[i] = input.buf[i + 1]; // shift to left all letters in buffer
80100760:	0f b6 86 c1 04 11 80 	movzbl -0x7feefb3f(%esi),%eax
80100767:	83 c6 01             	add    $0x1,%esi
8010076a:	88 86 bf 04 11 80    	mov    %al,-0x7feefb41(%esi)
  for (int i = input.e - backs; i < input.e; i++ )// jadid
80100770:	39 d6                	cmp    %edx,%esi
80100772:	75 ec                	jne    80100760 <cgaputc+0x1d0>
    saveInp.copybuf[input.e-backs] = '\0';
80100774:	c6 81 20 04 11 80 00 	movb   $0x0,-0x7feefbe0(%ecx)
8010077b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010077e:	66 90                	xchg   %ax,%ax
      saveInp.copybuf[i] = saveInp.copybuf[i + 1];
80100780:	0f b6 88 21 04 11 80 	movzbl -0x7feefbdf(%eax),%ecx
80100787:	83 c0 01             	add    $0x1,%eax
8010078a:	88 88 1f 04 11 80    	mov    %cl,-0x7feefbe1(%eax)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
80100790:	39 d0                	cmp    %edx,%eax
80100792:	75 ec                	jne    80100780 <cgaputc+0x1f0>
    if(position > 0) 
80100794:	31 f6                	xor    %esi,%esi
80100796:	85 db                	test   %ebx,%ebx
80100798:	0f 84 9e fe ff ff    	je     8010063c <cgaputc+0xac>
      --position;
8010079e:	89 fb                	mov    %edi,%ebx
801007a0:	e9 42 fe ff ff       	jmp    801005e7 <cgaputc+0x57>
    saveInp.copybuf[input.e-backs] = '\0';
801007a5:	c6 81 20 04 11 80 00 	movb   $0x0,-0x7feefbe0(%ecx)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
801007ac:	eb e6                	jmp    80100794 <cgaputc+0x204>
    panic("pos under/overflow");
801007ae:	83 ec 0c             	sub    $0xc,%esp
801007b1:	68 c5 80 10 80       	push   $0x801080c5
801007b6:	e8 55 fd ff ff       	call   80100510 <panic>
801007bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801007c0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801007c0:	55                   	push   %ebp
801007c1:	89 e5                	mov    %esp,%ebp
801007c3:	57                   	push   %edi
801007c4:	56                   	push   %esi
801007c5:	53                   	push   %ebx
801007c6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801007c9:	ff 75 08             	push   0x8(%ebp)
801007cc:	e8 af 1d 00 00       	call   80102580 <iunlock>
  acquire(&cons.lock);
801007d1:	c7 04 24 60 05 11 80 	movl   $0x80110560,(%esp)
801007d8:	e8 c3 4a 00 00       	call   801052a0 <acquire>
  for(i = 0; i < n; i++)
801007dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
801007e0:	83 c4 10             	add    $0x10,%esp
801007e3:	85 c9                	test   %ecx,%ecx
801007e5:	7e 36                	jle    8010081d <consolewrite+0x5d>
801007e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801007ea:	8b 7d 10             	mov    0x10(%ebp),%edi
801007ed:	01 df                	add    %ebx,%edi
  if(panicked){
801007ef:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
    consputc(buf[i] & 0xff);
801007f5:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801007f8:	85 d2                	test   %edx,%edx
801007fa:	74 04                	je     80100800 <consolewrite+0x40>
  asm volatile("cli");
801007fc:	fa                   	cli
    for(;;)
801007fd:	eb fe                	jmp    801007fd <consolewrite+0x3d>
801007ff:	90                   	nop
    uartputc(c);
80100800:	83 ec 0c             	sub    $0xc,%esp
    consputc(buf[i] & 0xff);
80100803:	0f b6 f0             	movzbl %al,%esi
  for(i = 0; i < n; i++)
80100806:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100809:	56                   	push   %esi
8010080a:	e8 91 63 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
8010080f:	89 f0                	mov    %esi,%eax
80100811:	e8 7a fd ff ff       	call   80100590 <cgaputc>
  for(i = 0; i < n; i++)
80100816:	83 c4 10             	add    $0x10,%esp
80100819:	39 fb                	cmp    %edi,%ebx
8010081b:	75 d2                	jne    801007ef <consolewrite+0x2f>
  release(&cons.lock);
8010081d:	83 ec 0c             	sub    $0xc,%esp
80100820:	68 60 05 11 80       	push   $0x80110560
80100825:	e8 16 4a 00 00       	call   80105240 <release>
  ilock(ip);
8010082a:	58                   	pop    %eax
8010082b:	ff 75 08             	push   0x8(%ebp)
8010082e:	e8 6d 1c 00 00       	call   801024a0 <ilock>

  return n;
}
80100833:	8b 45 10             	mov    0x10(%ebp),%eax
80100836:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100839:	5b                   	pop    %ebx
8010083a:	5e                   	pop    %esi
8010083b:	5f                   	pop    %edi
8010083c:	5d                   	pop    %ebp
8010083d:	c3                   	ret
8010083e:	66 90                	xchg   %ax,%ax

80100840 <printint>:
{
80100840:	55                   	push   %ebp
80100841:	89 e5                	mov    %esp,%ebp
80100843:	57                   	push   %edi
80100844:	56                   	push   %esi
80100845:	53                   	push   %ebx
80100846:	89 d3                	mov    %edx,%ebx
80100848:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010084b:	85 c0                	test   %eax,%eax
8010084d:	79 05                	jns    80100854 <printint+0x14>
8010084f:	83 e1 01             	and    $0x1,%ecx
80100852:	75 6a                	jne    801008be <printint+0x7e>
    x = xx;
80100854:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010085b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010085d:	31 f6                	xor    %esi,%esi
8010085f:	90                   	nop
    buf[i++] = digits[x % base];
80100860:	89 c8                	mov    %ecx,%eax
80100862:	31 d2                	xor    %edx,%edx
80100864:	89 f7                	mov    %esi,%edi
80100866:	f7 f3                	div    %ebx
80100868:	8d 76 01             	lea    0x1(%esi),%esi
8010086b:	0f b6 92 f8 85 10 80 	movzbl -0x7fef7a08(%edx),%edx
80100872:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100876:	89 ca                	mov    %ecx,%edx
80100878:	89 c1                	mov    %eax,%ecx
8010087a:	39 da                	cmp    %ebx,%edx
8010087c:	73 e2                	jae    80100860 <printint+0x20>
  if(sign)
8010087e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100881:	85 d2                	test   %edx,%edx
80100883:	74 07                	je     8010088c <printint+0x4c>
    buf[i++] = '-';
80100885:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010088a:	89 f7                	mov    %esi,%edi
8010088c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010088f:	01 f7                	add    %esi,%edi
  if(panicked){
80100891:	a1 9c 05 11 80       	mov    0x8011059c,%eax
    consputc(buf[i]);
80100896:	0f be 1f             	movsbl (%edi),%ebx
  if(panicked){
80100899:	85 c0                	test   %eax,%eax
8010089b:	74 03                	je     801008a0 <printint+0x60>
8010089d:	fa                   	cli
    for(;;)
8010089e:	eb fe                	jmp    8010089e <printint+0x5e>
    uartputc(c);
801008a0:	83 ec 0c             	sub    $0xc,%esp
801008a3:	53                   	push   %ebx
801008a4:	e8 f7 62 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801008a9:	89 d8                	mov    %ebx,%eax
801008ab:	e8 e0 fc ff ff       	call   80100590 <cgaputc>
  while(--i >= 0)
801008b0:	8d 47 ff             	lea    -0x1(%edi),%eax
801008b3:	83 c4 10             	add    $0x10,%esp
801008b6:	39 f7                	cmp    %esi,%edi
801008b8:	74 11                	je     801008cb <printint+0x8b>
801008ba:	89 c7                	mov    %eax,%edi
801008bc:	eb d3                	jmp    80100891 <printint+0x51>
    x = -xx;
801008be:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801008c0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801008c7:	89 c1                	mov    %eax,%ecx
801008c9:	eb 92                	jmp    8010085d <printint+0x1d>
}
801008cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008ce:	5b                   	pop    %ebx
801008cf:	5e                   	pop    %esi
801008d0:	5f                   	pop    %edi
801008d1:	5d                   	pop    %ebp
801008d2:	c3                   	ret
801008d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008da:	00 
801008db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801008e0 <handle_up_down_arrow>:
static void handle_up_down_arrow(enum Arrow arrow){ //jadid
801008e0:	55                   	push   %ebp
801008e1:	89 e5                	mov    %esp,%ebp
801008e3:	57                   	push   %edi
801008e4:	56                   	push   %esi
801008e5:	53                   	push   %ebx
801008e6:	89 c3                	mov    %eax,%ebx
801008e8:	83 ec 1c             	sub    $0x1c,%esp
  for (int i= 0 ; i < backs ; i ++){ //move cursor into later of current line
801008eb:	8b 15 98 05 11 80    	mov    0x80110598,%edx
801008f1:	85 d2                	test   %edx,%edx
801008f3:	7e 66                	jle    8010095b <handle_up_down_arrow+0x7b>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008f5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801008f8:	31 ff                	xor    %edi,%edi
801008fa:	be d4 03 00 00       	mov    $0x3d4,%esi
801008ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100908:	b8 0e 00 00 00       	mov    $0xe,%eax
8010090d:	89 f2                	mov    %esi,%edx
8010090f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100910:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100915:	89 da                	mov    %ebx,%edx
80100917:	ec                   	in     (%dx),%al
  position = inb(CRTPORT + 1) << 8;
80100918:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010091b:	89 f2                	mov    %esi,%edx
8010091d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100922:	c1 e1 08             	shl    $0x8,%ecx
80100925:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100926:	89 da                	mov    %ebx,%edx
80100928:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT + 1);
80100929:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010092c:	89 f2                	mov    %esi,%edx
8010092e:	09 c1                	or     %eax,%ecx
80100930:	b8 0e 00 00 00       	mov    $0xe,%eax
    position++;
80100935:	83 c1 01             	add    $0x1,%ecx
80100938:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, position >> 8);
80100939:	89 ca                	mov    %ecx,%edx
8010093b:	c1 fa 08             	sar    $0x8,%edx
8010093e:	89 d0                	mov    %edx,%eax
80100940:	89 da                	mov    %ebx,%edx
80100942:	ee                   	out    %al,(%dx)
80100943:	b8 0f 00 00 00       	mov    $0xf,%eax
80100948:	89 f2                	mov    %esi,%edx
8010094a:	ee                   	out    %al,(%dx)
8010094b:	89 c8                	mov    %ecx,%eax
8010094d:	89 da                	mov    %ebx,%edx
8010094f:	ee                   	out    %al,(%dx)
  for (int i= 0 ; i < backs ; i ++){ //move cursor into later of current line
80100950:	83 c7 01             	add    $0x1,%edi
80100953:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80100956:	75 b0                	jne    80100908 <handle_up_down_arrow+0x28>
80100958:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  backs = 0;
8010095b:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
80100962:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
80100965:	8b 35 48 05 11 80    	mov    0x80110548,%esi
8010096b:	39 35 44 05 11 80    	cmp    %esi,0x80110544
80100971:	73 54                	jae    801009c7 <handle_up_down_arrow+0xe7>
    if (input.buf[i - 1] != '\n'){
80100973:	83 ee 01             	sub    $0x1,%esi
80100976:	80 be c0 04 11 80 0a 	cmpb   $0xa,-0x7feefb40(%esi)
8010097d:	74 ec                	je     8010096b <handle_up_down_arrow+0x8b>
  if(panicked){
8010097f:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
80100985:	85 c9                	test   %ecx,%ecx
80100987:	74 07                	je     80100990 <handle_up_down_arrow+0xb0>
  asm volatile("cli");
80100989:	fa                   	cli
    for(;;)
8010098a:	eb fe                	jmp    8010098a <handle_up_down_arrow+0xaa>
8010098c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100990:	83 ec 0c             	sub    $0xc,%esp
80100993:	6a 08                	push   $0x8
80100995:	e8 06 62 00 00       	call   80106ba0 <uartputc>
8010099a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801009a1:	e8 fa 61 00 00       	call   80106ba0 <uartputc>
801009a6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009ad:	e8 ee 61 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801009b2:	b8 00 01 00 00       	mov    $0x100,%eax
801009b7:	e8 d4 fb ff ff       	call   80100590 <cgaputc>
}
801009bc:	83 c4 10             	add    $0x10,%esp
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
801009bf:	39 35 44 05 11 80    	cmp    %esi,0x80110544
801009c5:	72 ac                	jb     80100973 <handle_up_down_arrow+0x93>
  if ((arrow == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
801009c7:	a1 f8 03 11 80       	mov    0x801103f8,%eax
801009cc:	83 fb 03             	cmp    $0x3,%ebx
801009cf:	75 14                	jne    801009e5 <handle_up_down_arrow+0x105>
801009d1:	83 f8 08             	cmp    $0x8,%eax
801009d4:	7f 0f                	jg     801009e5 <handle_up_down_arrow+0x105>
801009d6:	8d 50 01             	lea    0x1(%eax),%edx
801009d9:	3b 15 fc 03 11 80    	cmp    0x801103fc,%edx
801009df:	0f 8c 84 00 00 00    	jl     80100a69 <handle_up_down_arrow+0x189>
    input = history.instructions[history.index--];
801009e5:	8d 50 ff             	lea    -0x1(%eax),%edx
801009e8:	69 c0 8c 00 00 00    	imul   $0x8c,%eax,%eax
801009ee:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
801009f4:	8d b0 80 fe 10 80    	lea    -0x7fef0180(%eax),%esi
801009fa:	b8 c0 04 11 80       	mov    $0x801104c0,%eax
801009ff:	b9 23 00 00 00       	mov    $0x23,%ecx
80100a04:	89 c7                	mov    %eax,%edi
80100a06:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.buf[--input.e] = '\0';
80100a08:	8b 15 48 05 11 80    	mov    0x80110548,%edx
80100a0e:	8d 42 ff             	lea    -0x1(%edx),%eax
80100a11:	a3 48 05 11 80       	mov    %eax,0x80110548
80100a16:	c6 82 bf 04 11 80 00 	movb   $0x0,-0x7feefb41(%edx)
  for (int i = input.w ; i < input.e; i++)
80100a1d:	8b 1d 44 05 11 80    	mov    0x80110544,%ebx
80100a23:	39 c3                	cmp    %eax,%ebx
80100a25:	73 3a                	jae    80100a61 <handle_up_down_arrow+0x181>
  if(panicked){
80100a27:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
    consputc(input.buf[i]);
80100a2d:	0f b6 83 c0 04 11 80 	movzbl -0x7feefb40(%ebx),%eax
  if(panicked){
80100a34:	85 d2                	test   %edx,%edx
80100a36:	74 08                	je     80100a40 <handle_up_down_arrow+0x160>
80100a38:	fa                   	cli
    for(;;)
80100a39:	eb fe                	jmp    80100a39 <handle_up_down_arrow+0x159>
80100a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100a40:	83 ec 0c             	sub    $0xc,%esp
    consputc(input.buf[i]);
80100a43:	0f be f0             	movsbl %al,%esi
  for (int i = input.w ; i < input.e; i++)
80100a46:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100a49:	56                   	push   %esi
80100a4a:	e8 51 61 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100a4f:	89 f0                	mov    %esi,%eax
80100a51:	e8 3a fb ff ff       	call   80100590 <cgaputc>
  for (int i = input.w ; i < input.e; i++)
80100a56:	83 c4 10             	add    $0x10,%esp
80100a59:	3b 1d 48 05 11 80    	cmp    0x80110548,%ebx
80100a5f:	72 c6                	jb     80100a27 <handle_up_down_arrow+0x147>
}
80100a61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a64:	5b                   	pop    %ebx
80100a65:	5e                   	pop    %esi
80100a66:	5f                   	pop    %edi
80100a67:	5d                   	pop    %ebp
80100a68:	c3                   	ret
    input = history.instructions[history.index + 1 ];
80100a69:	8d 70 02             	lea    0x2(%eax),%esi
    history.index ++ ;
80100a6c:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
    input = history.instructions[history.index + 1 ];
80100a72:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
80100a78:	81 c6 80 fe 10 80    	add    $0x8010fe80,%esi
80100a7e:	e9 77 ff ff ff       	jmp    801009fa <handle_up_down_arrow+0x11a>
80100a83:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a8a:	00 
80100a8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100a90 <cprintf>:
{
80100a90:	55                   	push   %ebp
80100a91:	89 e5                	mov    %esp,%ebp
80100a93:	57                   	push   %edi
80100a94:	56                   	push   %esi
80100a95:	53                   	push   %ebx
80100a96:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100a99:	8b 3d 94 05 11 80    	mov    0x80110594,%edi
  if (fmt == 0)
80100a9f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100aa2:	85 ff                	test   %edi,%edi
80100aa4:	0f 85 36 01 00 00    	jne    80100be0 <cprintf+0x150>
  if (fmt == 0)
80100aaa:	85 f6                	test   %esi,%esi
80100aac:	0f 84 1c 02 00 00    	je     80100cce <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100ab2:	0f b6 06             	movzbl (%esi),%eax
80100ab5:	85 c0                	test   %eax,%eax
80100ab7:	74 67                	je     80100b20 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
80100ab9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100abc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100abf:	31 db                	xor    %ebx,%ebx
80100ac1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100ac3:	83 f8 25             	cmp    $0x25,%eax
80100ac6:	75 68                	jne    80100b30 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
80100ac8:	83 c3 01             	add    $0x1,%ebx
80100acb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
80100acf:	85 c9                	test   %ecx,%ecx
80100ad1:	74 42                	je     80100b15 <cprintf+0x85>
    switch(c){
80100ad3:	83 f9 70             	cmp    $0x70,%ecx
80100ad6:	0f 84 e4 00 00 00    	je     80100bc0 <cprintf+0x130>
80100adc:	0f 8f 8e 00 00 00    	jg     80100b70 <cprintf+0xe0>
80100ae2:	83 f9 25             	cmp    $0x25,%ecx
80100ae5:	74 72                	je     80100b59 <cprintf+0xc9>
80100ae7:	83 f9 64             	cmp    $0x64,%ecx
80100aea:	0f 85 8e 00 00 00    	jne    80100b7e <cprintf+0xee>
      printint(*argp++, 10, 1);
80100af0:	8d 47 04             	lea    0x4(%edi),%eax
80100af3:	b9 01 00 00 00       	mov    $0x1,%ecx
80100af8:	ba 0a 00 00 00       	mov    $0xa,%edx
80100afd:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b00:	8b 07                	mov    (%edi),%eax
80100b02:	e8 39 fd ff ff       	call   80100840 <printint>
80100b07:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100b0a:	83 c3 01             	add    $0x1,%ebx
80100b0d:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100b11:	85 c0                	test   %eax,%eax
80100b13:	75 ae                	jne    80100ac3 <cprintf+0x33>
80100b15:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100b18:	85 ff                	test   %edi,%edi
80100b1a:	0f 85 e3 00 00 00    	jne    80100c03 <cprintf+0x173>
}
80100b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b23:	5b                   	pop    %ebx
80100b24:	5e                   	pop    %esi
80100b25:	5f                   	pop    %edi
80100b26:	5d                   	pop    %ebp
80100b27:	c3                   	ret
80100b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b2f:	00 
  if(panicked){
80100b30:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
80100b36:	85 d2                	test   %edx,%edx
80100b38:	74 06                	je     80100b40 <cprintf+0xb0>
80100b3a:	fa                   	cli
    for(;;)
80100b3b:	eb fe                	jmp    80100b3b <cprintf+0xab>
80100b3d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	50                   	push   %eax
80100b44:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100b47:	e8 54 60 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100b4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100b4f:	e8 3c fa ff ff       	call   80100590 <cgaputc>
      continue;
80100b54:	83 c4 10             	add    $0x10,%esp
80100b57:	eb b1                	jmp    80100b0a <cprintf+0x7a>
  if(panicked){
80100b59:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
80100b5f:	85 c9                	test   %ecx,%ecx
80100b61:	0f 84 f9 00 00 00    	je     80100c60 <cprintf+0x1d0>
80100b67:	fa                   	cli
    for(;;)
80100b68:	eb fe                	jmp    80100b68 <cprintf+0xd8>
80100b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100b70:	83 f9 73             	cmp    $0x73,%ecx
80100b73:	0f 84 9f 00 00 00    	je     80100c18 <cprintf+0x188>
80100b79:	83 f9 78             	cmp    $0x78,%ecx
80100b7c:	74 42                	je     80100bc0 <cprintf+0x130>
  if(panicked){
80100b7e:	8b 15 9c 05 11 80    	mov    0x8011059c,%edx
80100b84:	85 d2                	test   %edx,%edx
80100b86:	0f 85 d0 00 00 00    	jne    80100c5c <cprintf+0x1cc>
    uartputc(c);
80100b8c:	83 ec 0c             	sub    $0xc,%esp
80100b8f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100b92:	6a 25                	push   $0x25
80100b94:	e8 07 60 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100b99:	b8 25 00 00 00       	mov    $0x25,%eax
80100b9e:	e8 ed f9 ff ff       	call   80100590 <cgaputc>
  if(panicked){
80100ba3:	a1 9c 05 11 80       	mov    0x8011059c,%eax
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100bae:	85 c0                	test   %eax,%eax
80100bb0:	0f 84 f5 00 00 00    	je     80100cab <cprintf+0x21b>
80100bb6:	fa                   	cli
    for(;;)
80100bb7:	eb fe                	jmp    80100bb7 <cprintf+0x127>
80100bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
80100bc0:	8d 47 04             	lea    0x4(%edi),%eax
80100bc3:	31 c9                	xor    %ecx,%ecx
80100bc5:	ba 10 00 00 00       	mov    $0x10,%edx
80100bca:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100bcd:	8b 07                	mov    (%edi),%eax
80100bcf:	e8 6c fc ff ff       	call   80100840 <printint>
80100bd4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100bd7:	e9 2e ff ff ff       	jmp    80100b0a <cprintf+0x7a>
80100bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100be0:	83 ec 0c             	sub    $0xc,%esp
80100be3:	68 60 05 11 80       	push   $0x80110560
80100be8:	e8 b3 46 00 00       	call   801052a0 <acquire>
  if (fmt == 0)
80100bed:	83 c4 10             	add    $0x10,%esp
80100bf0:	85 f6                	test   %esi,%esi
80100bf2:	0f 84 d6 00 00 00    	je     80100cce <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100bf8:	0f b6 06             	movzbl (%esi),%eax
80100bfb:	85 c0                	test   %eax,%eax
80100bfd:	0f 85 b6 fe ff ff    	jne    80100ab9 <cprintf+0x29>
    release(&cons.lock);
80100c03:	83 ec 0c             	sub    $0xc,%esp
80100c06:	68 60 05 11 80       	push   $0x80110560
80100c0b:	e8 30 46 00 00       	call   80105240 <release>
80100c10:	83 c4 10             	add    $0x10,%esp
80100c13:	e9 08 ff ff ff       	jmp    80100b20 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
80100c18:	8b 17                	mov    (%edi),%edx
80100c1a:	8d 47 04             	lea    0x4(%edi),%eax
80100c1d:	85 d2                	test   %edx,%edx
80100c1f:	74 2f                	je     80100c50 <cprintf+0x1c0>
      for(; *s; s++)
80100c21:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100c24:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100c26:	84 c9                	test   %cl,%cl
80100c28:	0f 84 99 00 00 00    	je     80100cc7 <cprintf+0x237>
80100c2e:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100c31:	89 fb                	mov    %edi,%ebx
80100c33:	89 f7                	mov    %esi,%edi
80100c35:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100c38:	89 c8                	mov    %ecx,%eax
  if(panicked){
80100c3a:	8b 35 9c 05 11 80    	mov    0x8011059c,%esi
80100c40:	85 f6                	test   %esi,%esi
80100c42:	74 38                	je     80100c7c <cprintf+0x1ec>
80100c44:	fa                   	cli
    for(;;)
80100c45:	eb fe                	jmp    80100c45 <cprintf+0x1b5>
80100c47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c4e:	00 
80100c4f:	90                   	nop
80100c50:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100c55:	bf d8 80 10 80       	mov    $0x801080d8,%edi
80100c5a:	eb d2                	jmp    80100c2e <cprintf+0x19e>
80100c5c:	fa                   	cli
    for(;;)
80100c5d:	eb fe                	jmp    80100c5d <cprintf+0x1cd>
80100c5f:	90                   	nop
    uartputc(c);
80100c60:	83 ec 0c             	sub    $0xc,%esp
80100c63:	6a 25                	push   $0x25
80100c65:	e8 36 5f 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100c6a:	b8 25 00 00 00       	mov    $0x25,%eax
80100c6f:	e8 1c f9 ff ff       	call   80100590 <cgaputc>
}
80100c74:	83 c4 10             	add    $0x10,%esp
80100c77:	e9 8e fe ff ff       	jmp    80100b0a <cprintf+0x7a>
    uartputc(c);
80100c7c:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
80100c7f:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100c82:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100c85:	56                   	push   %esi
80100c86:	e8 15 5f 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100c8b:	89 f0                	mov    %esi,%eax
80100c8d:	e8 fe f8 ff ff       	call   80100590 <cgaputc>
      for(; *s; s++)
80100c92:	0f b6 03             	movzbl (%ebx),%eax
80100c95:	83 c4 10             	add    $0x10,%esp
80100c98:	84 c0                	test   %al,%al
80100c9a:	75 9e                	jne    80100c3a <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
80100c9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100c9f:	89 fe                	mov    %edi,%esi
80100ca1:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100ca4:	89 c7                	mov    %eax,%edi
80100ca6:	e9 5f fe ff ff       	jmp    80100b0a <cprintf+0x7a>
    uartputc(c);
80100cab:	83 ec 0c             	sub    $0xc,%esp
80100cae:	51                   	push   %ecx
80100caf:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100cb2:	e8 e9 5e 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100cb7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cba:	e8 d1 f8 ff ff       	call   80100590 <cgaputc>
}
80100cbf:	83 c4 10             	add    $0x10,%esp
80100cc2:	e9 43 fe ff ff       	jmp    80100b0a <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
80100cc7:	89 c7                	mov    %eax,%edi
80100cc9:	e9 3c fe ff ff       	jmp    80100b0a <cprintf+0x7a>
    panic("null fmt");
80100cce:	83 ec 0c             	sub    $0xc,%esp
80100cd1:	68 df 80 10 80       	push   $0x801080df
80100cd6:	e8 35 f8 ff ff       	call   80100510 <panic>
80100cdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100ce0 <delete_letters>:
{
80100ce0:	55                   	push   %ebp
80100ce1:	89 e5                	mov    %esp,%ebp
80100ce3:	53                   	push   %ebx
80100ce4:	83 ec 04             	sub    $0x4,%esp
80100ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(int i=end_index; i<input.e ; i++)
80100cea:	3b 1d 48 05 11 80    	cmp    0x80110548,%ebx
80100cf0:	73 48                	jae    80100d3a <delete_letters+0x5a>
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
80100d08:	e8 93 5e 00 00       	call   80106ba0 <uartputc>
80100d0d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d14:	e8 87 5e 00 00       	call   80106ba0 <uartputc>
80100d19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d20:	e8 7b 5e 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80100d25:	b8 00 01 00 00       	mov    $0x100,%eax
80100d2a:	e8 61 f8 ff ff       	call   80100590 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80100d2f:	83 c4 10             	add    $0x10,%esp
80100d32:	3b 1d 48 05 11 80    	cmp    0x80110548,%ebx
80100d38:	72 b8                	jb     80100cf2 <delete_letters+0x12>
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
80100d4f:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
  acquire(&cons.lock);
80100d55:	68 60 05 11 80       	push   $0x80110560
80100d5a:	e8 41 45 00 00       	call   801052a0 <acquire>
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
80100d97:	0f 84 44 03 00 00    	je     801010e1 <consoleintr+0x3a1>
80100d9d:	7f 19                	jg     80100db8 <consoleintr+0x78>
80100d9f:	8d 43 fa             	lea    -0x6(%ebx),%eax
80100da2:	83 f8 0f             	cmp    $0xf,%eax
80100da5:	0f 87 44 04 00 00    	ja     801011ef <consoleintr+0x4af>
80100dab:	ff 24 85 b8 85 10 80 	jmp    *-0x7fef7a48(,%eax,4)
80100db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100db8:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100dbe:	0f 84 ec 02 00 00    	je     801010b0 <consoleintr+0x370>
80100dc4:	0f 8e c6 00 00 00    	jle    80100e90 <consoleintr+0x150>
80100dca:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100dd0:	0f 84 ff 00 00 00    	je     80100ed5 <consoleintr+0x195>
80100dd6:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100ddc:	0f 85 15 04 00 00    	jne    801011f7 <consoleintr+0x4b7>
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
80100e56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e5d:	00 
80100e5e:	66 90                	xchg   %ax,%ax
  release(&cons.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
80100e63:	68 60 05 11 80       	push   $0x80110560
80100e68:	e8 d3 43 00 00       	call   80105240 <release>
  if(doprocdump) {
80100e6d:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
80100e73:	83 c4 10             	add    $0x10,%esp
80100e76:	85 c0                	test   %eax,%eax
80100e78:	0f 85 a0 04 00 00    	jne    8010131e <consoleintr+0x5de>
}
80100e7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e81:	5b                   	pop    %ebx
80100e82:	5e                   	pop    %esi
80100e83:	5f                   	pop    %edi
80100e84:	5d                   	pop    %ebp
80100e85:	c3                   	ret
80100e86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e8d:	00 
80100e8e:	66 90                	xchg   %ax,%ax
    switch(c){
80100e90:	83 fb 7f             	cmp    $0x7f,%ebx
80100e93:	0f 84 b2 00 00 00    	je     80100f4b <consoleintr+0x20b>
80100e99:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100e9f:	0f 85 52 03 00 00    	jne    801011f7 <consoleintr+0x4b7>
      if ((history.count != 0)  && (history.last - history.index < history.count))
80100ea5:	a1 00 04 11 80       	mov    0x80110400,%eax
80100eaa:	85 c0                	test   %eax,%eax
80100eac:	0f 84 d0 fe ff ff    	je     80100d82 <consoleintr+0x42>
80100eb2:	8b 15 fc 03 11 80    	mov    0x801103fc,%edx
80100eb8:	2b 15 f8 03 11 80    	sub    0x801103f8,%edx
80100ebe:	39 d0                	cmp    %edx,%eax
80100ec0:	0f 8e bc fe ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(UP);
80100ec6:	b8 02 00 00 00       	mov    $0x2,%eax
80100ecb:	e8 10 fa ff ff       	call   801008e0 <handle_up_down_arrow>
80100ed0:	e9 ad fe ff ff       	jmp    80100d82 <consoleintr+0x42>
      if ((input.e - backs) > input.w) //ensure cursor position stays in valid bounds
80100ed5:	8b 0d 98 05 11 80    	mov    0x80110598,%ecx
80100edb:	a1 48 05 11 80       	mov    0x80110548,%eax
80100ee0:	29 c8                	sub    %ecx,%eax
80100ee2:	39 05 44 05 11 80    	cmp    %eax,0x80110544
80100ee8:	0f 83 94 fe ff ff    	jae    80100d82 <consoleintr+0x42>
80100eee:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100ef3:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ef8:	89 fa                	mov    %edi,%edx
80100efa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100efb:	be d5 03 00 00       	mov    $0x3d5,%esi
80100f00:	89 f2                	mov    %esi,%edx
80100f02:	ec                   	in     (%dx),%al
  position = inb(CRTPORT + 1) << 8;
80100f03:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f06:	89 fa                	mov    %edi,%edx
80100f08:	89 c3                	mov    %eax,%ebx
80100f0a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100f0f:	c1 e3 08             	shl    $0x8,%ebx
80100f12:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f13:	89 f2                	mov    %esi,%edx
80100f15:	ec                   	in     (%dx),%al
  position |= inb(CRTPORT + 1);
80100f16:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f19:	89 fa                	mov    %edi,%edx
80100f1b:	09 c3                	or     %eax,%ebx
80100f1d:	b8 0e 00 00 00       	mov    $0xe,%eax
    position--;
80100f22:	83 eb 01             	sub    $0x1,%ebx
80100f25:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, position >> 8);
80100f26:	89 da                	mov    %ebx,%edx
80100f28:	c1 fa 08             	sar    $0x8,%edx
80100f2b:	89 d0                	mov    %edx,%eax
80100f2d:	89 f2                	mov    %esi,%edx
80100f2f:	ee                   	out    %al,(%dx)
80100f30:	b8 0f 00 00 00       	mov    $0xf,%eax
80100f35:	89 fa                	mov    %edi,%edx
80100f37:	ee                   	out    %al,(%dx)
80100f38:	89 d8                	mov    %ebx,%eax
80100f3a:	89 f2                	mov    %esi,%edx
80100f3c:	ee                   	out    %al,(%dx)
        backs++;
80100f3d:	83 c1 01             	add    $0x1,%ecx
80100f40:	89 0d 98 05 11 80    	mov    %ecx,0x80110598
80100f46:	e9 37 fe ff ff       	jmp    80100d82 <consoleintr+0x42>
      if((input.e - backs )> input.w){
80100f4b:	a1 48 05 11 80       	mov    0x80110548,%eax
80100f50:	89 c2                	mov    %eax,%edx
80100f52:	2b 15 98 05 11 80    	sub    0x80110598,%edx
80100f58:	39 15 44 05 11 80    	cmp    %edx,0x80110544
80100f5e:	0f 83 1e fe ff ff    	jae    80100d82 <consoleintr+0x42>
        input.e--;
80100f64:	83 e8 01             	sub    $0x1,%eax
80100f67:	a3 48 05 11 80       	mov    %eax,0x80110548
  if(panicked){
80100f6c:	a1 9c 05 11 80       	mov    0x8011059c,%eax
80100f71:	85 c0                	test   %eax,%eax
80100f73:	0f 84 b1 03 00 00    	je     8010132a <consoleintr+0x5ea>
  asm volatile("cli");
80100f79:	fa                   	cli
    for(;;)
80100f7a:	eb fe                	jmp    80100f7a <consoleintr+0x23a>
80100f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(saveInp.active == 1)
80100f80:	83 3d a8 04 11 80 01 	cmpl   $0x1,0x801104a8
80100f87:	0f 85 f5 fd ff ff    	jne    80100d82 <consoleintr+0x42>
      saveInp.end = input.e-backs;
80100f8d:	8b 35 48 05 11 80    	mov    0x80110548,%esi
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
80100f93:	8b 15 a0 04 11 80    	mov    0x801104a0,%edx
      int count = 0;
80100f99:	31 db                	xor    %ebx,%ebx
      saveInp.end = input.e-backs;
80100f9b:	89 f1                	mov    %esi,%ecx
80100f9d:	2b 0d 98 05 11 80    	sub    0x80110598,%ecx
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80100fa3:	89 f0                	mov    %esi,%eax
      saveInp.end = input.e-backs;
80100fa5:	89 0d a4 04 11 80    	mov    %ecx,0x801104a4
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
80100fab:	83 fa 7f             	cmp    $0x7f,%edx
80100fae:	0f 8f e4 03 00 00    	jg     80101398 <consoleintr+0x658>
80100fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (saveInp.copybuf[i] != '\0'){
80100fb8:	80 ba 20 04 11 80 00 	cmpb   $0x0,-0x7feefbe0(%edx)
80100fbf:	74 0a                	je     80100fcb <consoleintr+0x28b>
          arr[count] = i;
80100fc1:	89 94 9d e8 fd ff ff 	mov    %edx,-0x218(%ebp,%ebx,4)
          count++;
80100fc8:	83 c3 01             	add    $0x1,%ebx
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
80100fcb:	83 c2 01             	add    $0x1,%edx
80100fce:	81 fa 80 00 00 00    	cmp    $0x80,%edx
80100fd4:	75 e2                	jne    80100fb8 <consoleintr+0x278>
      input.e = input.e + count;
80100fd6:	01 de                	add    %ebx,%esi
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80100fd8:	39 c1                	cmp    %eax,%ecx
80100fda:	7f 19                	jg     80100ff5 <consoleintr+0x2b5>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[j + count] = input.buf[j];
80100fe0:	0f b6 90 c0 04 11 80 	movzbl -0x7feefb40(%eax),%edx
80100fe7:	88 94 03 c0 04 11 80 	mov    %dl,-0x7feefb40(%ebx,%eax,1)
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80100fee:	83 e8 01             	sub    $0x1,%eax
80100ff1:	39 c1                	cmp    %eax,%ecx
80100ff3:	7e eb                	jle    80100fe0 <consoleintr+0x2a0>
      input.e = input.e + count;
80100ff5:	89 35 48 05 11 80    	mov    %esi,0x80110548
      for (int i=0; i<count ; i++)
80100ffb:	85 db                	test   %ebx,%ebx
80100ffd:	0f 8e 7f fd ff ff    	jle    80100d82 <consoleintr+0x42>
80101003:	31 f6                	xor    %esi,%esi
80101005:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
8010100b:	89 da                	mov    %ebx,%edx
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
8010100d:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80101010:	0f be 98 20 04 11 80 	movsbl -0x7feefbe0(%eax),%ebx
  if(panicked){
80101017:	a1 9c 05 11 80       	mov    0x8011059c,%eax
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
8010101c:	88 9c 31 c0 04 11 80 	mov    %bl,-0x7feefb40(%ecx,%esi,1)
  if(panicked){
80101023:	85 c0                	test   %eax,%eax
80101025:	0f 84 7d 03 00 00    	je     801013a8 <consoleintr+0x668>
8010102b:	fa                   	cli
    for(;;)
8010102c:	eb fe                	jmp    8010102c <consoleintr+0x2ec>
8010102e:	66 90                	xchg   %ax,%ax
      saveInp.active = 1;
80101030:	c7 05 a8 04 11 80 01 	movl   $0x1,0x801104a8
80101037:	00 00 00 
      saveInp.start = input.e-backs;
8010103a:	a1 48 05 11 80       	mov    0x80110548,%eax
8010103f:	2b 05 98 05 11 80    	sub    0x80110598,%eax
80101045:	a3 a0 04 11 80       	mov    %eax,0x801104a0
      for (int i = 0; i < 128; i++)
8010104a:	b8 20 04 11 80       	mov    $0x80110420,%eax
8010104f:	90                   	nop
        saveInp.copybuf[i] = '\0';
80101050:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80101056:	83 c0 08             	add    $0x8,%eax
80101059:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
      for (int i = 0; i < 128; i++)
80101060:	3d a0 04 11 80       	cmp    $0x801104a0,%eax
80101065:	75 e9                	jne    80101050 <consoleintr+0x310>
80101067:	e9 16 fd ff ff       	jmp    80100d82 <consoleintr+0x42>
      while(input.e != input.w &&
8010106c:	a1 48 05 11 80       	mov    0x80110548,%eax
80101071:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
80101077:	0f 84 05 fd ff ff    	je     80100d82 <consoleintr+0x42>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010107d:	83 e8 01             	sub    $0x1,%eax
80101080:	89 c2                	mov    %eax,%edx
80101082:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101085:	80 ba c0 04 11 80 0a 	cmpb   $0xa,-0x7feefb40(%edx)
8010108c:	0f 84 f0 fc ff ff    	je     80100d82 <consoleintr+0x42>
        input.e--;
80101092:	a3 48 05 11 80       	mov    %eax,0x80110548
  if(panicked){
80101097:	a1 9c 05 11 80       	mov    0x8011059c,%eax
8010109c:	85 c0                	test   %eax,%eax
8010109e:	0f 84 ec 00 00 00    	je     80101190 <consoleintr+0x450>
801010a4:	fa                   	cli
    for(;;)
801010a5:	eb fe                	jmp    801010a5 <consoleintr+0x365>
801010a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010ae:	00 
801010af:	90                   	nop
      if ((history.count != 0 ) && (history.last - history.index  - 1 > 0))
801010b0:	8b 35 00 04 11 80    	mov    0x80110400,%esi
801010b6:	85 f6                	test   %esi,%esi
801010b8:	0f 84 c4 fc ff ff    	je     80100d82 <consoleintr+0x42>
801010be:	a1 fc 03 11 80       	mov    0x801103fc,%eax
801010c3:	2b 05 f8 03 11 80    	sub    0x801103f8,%eax
801010c9:	83 f8 01             	cmp    $0x1,%eax
801010cc:	0f 8e b0 fc ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(DOWN);
801010d2:	b8 03 00 00 00       	mov    $0x3,%eax
801010d7:	e8 04 f8 ff ff       	call   801008e0 <handle_up_down_arrow>
801010dc:	e9 a1 fc ff ff       	jmp    80100d82 <consoleintr+0x42>
  if(panicked){
801010e1:	8b 1d 9c 05 11 80    	mov    0x8011059c,%ebx
801010e7:	85 db                	test   %ebx,%ebx
801010e9:	0f 85 e9 00 00 00    	jne    801011d8 <consoleintr+0x498>
    uartputc(c);
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	6a 3f                	push   $0x3f
801010f4:	e8 a7 5a 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801010f9:	b8 3f 00 00 00       	mov    $0x3f,%eax
801010fe:	e8 8d f4 ff ff       	call   80100590 <cgaputc>
  if(input.buf[input.e-1] == 61)
80101103:	8b 1d 48 05 11 80    	mov    0x80110548,%ebx
80101109:	83 c4 10             	add    $0x10,%esp
8010110c:	80 bb bf 04 11 80 3d 	cmpb   $0x3d,-0x7feefb41(%ebx)
80101113:	0f 85 69 fc ff ff    	jne    80100d82 <consoleintr+0x42>
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101119:	0f b6 83 be 04 11 80 	movzbl -0x7feefb42(%ebx),%eax
80101120:	8d 4b fe             	lea    -0x2(%ebx),%ecx
    int first_num_index=0;
80101123:	c7 85 e0 fd ff ff 00 	movl   $0x0,-0x220(%ebp)
8010112a:	00 00 00 
    int second_num_index=0;
8010112d:	c7 85 e4 fd ff ff 00 	movl   $0x0,-0x21c(%ebp)
80101134:	00 00 00 
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101137:	83 e8 30             	sub    $0x30,%eax
8010113a:	3c 09                	cmp    $0x9,%al
8010113c:	0f 87 40 fc ff ff    	ja     80100d82 <consoleintr+0x42>
    int first_num=read_num(input.e-2, &first_num_index);
80101142:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
80101148:	89 c8                	mov    %ecx,%eax
8010114a:	e8 e1 f2 ff ff       	call   80100430 <read_num.constprop.0>
    int second_num = read_num(first_num_index-2, &second_num_index);
8010114f:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
80101155:	8d 95 e4 fd ff ff    	lea    -0x21c(%ebp),%edx
    int first_num=read_num(input.e-2, &first_num_index);
8010115b:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
    int second_num = read_num(first_num_index-2, &second_num_index);
80101161:	8d 47 fe             	lea    -0x2(%edi),%eax
80101164:	e8 c7 f2 ff ff       	call   80100430 <read_num.constprop.0>
    delete_letters(second_num_index);
80101169:	8b b5 e4 fd ff ff    	mov    -0x21c(%ebp),%esi
    int second_num = read_num(first_num_index-2, &second_num_index);
8010116f:	89 85 bc fd ff ff    	mov    %eax,-0x244(%ebp)
  for(int i=end_index; i<input.e ; i++)
80101175:	39 de                	cmp    %ebx,%esi
80101177:	0f 83 c3 02 00 00    	jae    80101440 <consoleintr+0x700>
8010117d:	89 f3                	mov    %esi,%ebx
  if(panicked){
8010117f:	8b 0d 9c 05 11 80    	mov    0x8011059c,%ecx
80101185:	85 c9                	test   %ecx,%ecx
80101187:	0f 84 75 02 00 00    	je     80101402 <consoleintr+0x6c2>
8010118d:	fa                   	cli
    for(;;)
8010118e:	eb fe                	jmp    8010118e <consoleintr+0x44e>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101190:	83 ec 0c             	sub    $0xc,%esp
80101193:	6a 08                	push   $0x8
80101195:	e8 06 5a 00 00       	call   80106ba0 <uartputc>
8010119a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801011a1:	e8 fa 59 00 00       	call   80106ba0 <uartputc>
801011a6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801011ad:	e8 ee 59 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801011b2:	b8 00 01 00 00       	mov    $0x100,%eax
801011b7:	e8 d4 f3 ff ff       	call   80100590 <cgaputc>
      while(input.e != input.w &&
801011bc:	a1 48 05 11 80       	mov    0x80110548,%eax
801011c1:	83 c4 10             	add    $0x10,%esp
801011c4:	3b 05 44 05 11 80    	cmp    0x80110544,%eax
801011ca:	0f 85 ad fe ff ff    	jne    8010107d <consoleintr+0x33d>
801011d0:	e9 ad fb ff ff       	jmp    80100d82 <consoleintr+0x42>
801011d5:	8d 76 00             	lea    0x0(%esi),%esi
801011d8:	fa                   	cli
    for(;;)
801011d9:	eb fe                	jmp    801011d9 <consoleintr+0x499>
801011db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(c){
801011e0:	c7 85 cc fd ff ff 01 	movl   $0x1,-0x234(%ebp)
801011e7:	00 00 00 
801011ea:	e9 93 fb ff ff       	jmp    80100d82 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801011ef:	85 db                	test   %ebx,%ebx
801011f1:	0f 84 8b fb ff ff    	je     80100d82 <consoleintr+0x42>
801011f7:	a1 48 05 11 80       	mov    0x80110548,%eax
801011fc:	89 c2                	mov    %eax,%edx
801011fe:	2b 15 40 05 11 80    	sub    0x80110540,%edx
80101204:	83 fa 7f             	cmp    $0x7f,%edx
80101207:	0f 87 75 fb ff ff    	ja     80100d82 <consoleintr+0x42>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
8010120d:	89 da                	mov    %ebx,%edx
        if (saveInp.active == 1)
8010120f:	83 3d a8 04 11 80 01 	cmpl   $0x1,0x801104a8
80101216:	0f 84 c1 01 00 00    	je     801013dd <consoleintr+0x69d>
  if(panicked){
8010121c:	8b 35 9c 05 11 80    	mov    0x8011059c,%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80101222:	8d 48 01             	lea    0x1(%eax),%ecx
80101225:	83 e0 7f             	and    $0x7f,%eax
80101228:	89 0d 48 05 11 80    	mov    %ecx,0x80110548
8010122e:	88 90 c0 04 11 80    	mov    %dl,-0x7feefb40(%eax)
  if(panicked){
80101234:	85 f6                	test   %esi,%esi
80101236:	0f 85 54 01 00 00    	jne    80101390 <consoleintr+0x650>
  if(c == BACKSPACE){
8010123c:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80101242:	0f 84 10 02 00 00    	je     80101458 <consoleintr+0x718>
    uartputc(c);
80101248:	83 ec 0c             	sub    $0xc,%esp
8010124b:	53                   	push   %ebx
8010124c:	e8 4f 59 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80101251:	89 d8                	mov    %ebx,%eax
80101253:	e8 38 f3 ff ff       	call   80100590 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
80101258:	83 c4 10             	add    $0x10,%esp
8010125b:	83 fb 0a             	cmp    $0xa,%ebx
8010125e:	74 09                	je     80101269 <consoleintr+0x529>
80101260:	83 fb 04             	cmp    $0x4,%ebx
80101263:	0f 85 1e 02 00 00    	jne    80101487 <consoleintr+0x747>
  while (word[i]!='\0' && word[i]!='\n')
80101269:	8b 85 c8 fd ff ff    	mov    -0x238(%ebp),%eax
8010126f:	0f b6 90 c0 04 11 80 	movzbl -0x7feefb40(%eax),%edx
80101276:	80 fa 0a             	cmp    $0xa,%dl
80101279:	74 35                	je     801012b0 <consoleintr+0x570>
8010127b:	8b 8d c4 fd ff ff    	mov    -0x23c(%ebp),%ecx
80101281:	31 c0                	xor    %eax,%eax
80101283:	84 d2                	test   %dl,%dl
80101285:	75 21                	jne    801012a8 <consoleintr+0x568>
80101287:	eb 27                	jmp    801012b0 <consoleintr+0x570>
80101289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    i++;
80101290:	83 c0 01             	add    $0x1,%eax
  while (word[i]!='\0' && word[i]!='\n')
80101293:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
80101297:	84 d2                	test   %dl,%dl
80101299:	0f 84 01 02 00 00    	je     801014a0 <consoleintr+0x760>
8010129f:	80 fa 0a             	cmp    $0xa,%dl
801012a2:	0f 84 f8 01 00 00    	je     801014a0 <consoleintr+0x760>
    if(word[i]!=h[i])
801012a8:	38 90 e8 80 10 80    	cmp    %dl,-0x7fef7f18(%eax)
801012ae:	74 e0                	je     80101290 <consoleintr+0x550>
            if (history.count < 9){
801012b0:	8b 1d 00 04 11 80    	mov    0x80110400,%ebx
801012b6:	83 fb 08             	cmp    $0x8,%ebx
801012b9:	0f 8f 74 02 00 00    	jg     80101533 <consoleintr+0x7f3>
            history.instructions[history.last + 1] = input;
801012bf:	a1 fc 03 11 80       	mov    0x801103fc,%eax
801012c4:	be c0 04 11 80       	mov    $0x801104c0,%esi
801012c9:	b9 23 00 00 00       	mov    $0x23,%ecx
            history.count ++ ;
801012ce:	83 c3 01             	add    $0x1,%ebx
801012d1:	89 1d 00 04 11 80    	mov    %ebx,0x80110400
            history.instructions[history.last + 1] = input;
801012d7:	8d 50 01             	lea    0x1(%eax),%edx
801012da:	69 c2 8c 00 00 00    	imul   $0x8c,%edx,%eax
            history.last ++ ;
801012e0:	89 15 fc 03 11 80    	mov    %edx,0x801103fc
            history.index = history.last;
801012e6:	89 15 f8 03 11 80    	mov    %edx,0x801103f8
            history.instructions[history.last + 1] = input;
801012ec:	05 80 fe 10 80       	add    $0x8010fe80,%eax
801012f1:	89 c7                	mov    %eax,%edi
801012f3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
          input.w = input.e;
801012f5:	a1 48 05 11 80       	mov    0x80110548,%eax
          wakeup(&input.r);
801012fa:	83 ec 0c             	sub    $0xc,%esp
          backs = 0;
801012fd:	c7 05 98 05 11 80 00 	movl   $0x0,0x80110598
80101304:	00 00 00 
          input.w = input.e;
80101307:	a3 44 05 11 80       	mov    %eax,0x80110544
          wakeup(&input.r);
8010130c:	68 40 05 11 80       	push   $0x80110540
80101311:	e8 ca 3a 00 00       	call   80104de0 <wakeup>
80101316:	83 c4 10             	add    $0x10,%esp
80101319:	e9 64 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
}
8010131e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101321:	5b                   	pop    %ebx
80101322:	5e                   	pop    %esi
80101323:	5f                   	pop    %edi
80101324:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80101325:	e9 96 3b 00 00       	jmp    80104ec0 <procdump>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010132a:	83 ec 0c             	sub    $0xc,%esp
8010132d:	6a 08                	push   $0x8
8010132f:	e8 6c 58 00 00       	call   80106ba0 <uartputc>
80101334:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010133b:	e8 60 58 00 00       	call   80106ba0 <uartputc>
80101340:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101347:	e8 54 58 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
8010134c:	b8 00 01 00 00       	mov    $0x100,%eax
80101351:	e8 3a f2 ff ff       	call   80100590 <cgaputc>
}
80101356:	83 c4 10             	add    $0x10,%esp
80101359:	e9 24 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010135e:	a1 48 05 11 80       	mov    0x80110548,%eax
80101363:	89 c2                	mov    %eax,%edx
80101365:	2b 15 40 05 11 80    	sub    0x80110540,%edx
8010136b:	83 fa 7f             	cmp    $0x7f,%edx
8010136e:	0f 87 0e fa ff ff    	ja     80100d82 <consoleintr+0x42>
        c = (c == '\r') ? '\n' : c;
80101374:	83 fb 0d             	cmp    $0xd,%ebx
80101377:	0f 85 90 fe ff ff    	jne    8010120d <consoleintr+0x4cd>
8010137d:	ba 0a 00 00 00       	mov    $0xa,%edx
80101382:	bb 0a 00 00 00       	mov    $0xa,%ebx
80101387:	e9 83 fe ff ff       	jmp    8010120f <consoleintr+0x4cf>
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101390:	fa                   	cli
    for(;;)
80101391:	eb fe                	jmp    80101391 <consoleintr+0x651>
80101393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101398:	39 f1                	cmp    %esi,%ecx
8010139a:	0f 8e 40 fc ff ff    	jle    80100fe0 <consoleintr+0x2a0>
801013a0:	e9 dd f9 ff ff       	jmp    80100d82 <consoleintr+0x42>
801013a5:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801013a8:	83 ec 0c             	sub    $0xc,%esp
801013ab:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
      for (int i=0; i<count ; i++)
801013b1:	83 c6 01             	add    $0x1,%esi
    uartputc(c);
801013b4:	53                   	push   %ebx
801013b5:	e8 e6 57 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801013ba:	89 d8                	mov    %ebx,%eax
801013bc:	e8 cf f1 ff ff       	call   80100590 <cgaputc>
      for (int i=0; i<count ; i++)
801013c1:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
801013c7:	83 c4 10             	add    $0x10,%esp
801013ca:	39 d6                	cmp    %edx,%esi
801013cc:	0f 84 b0 f9 ff ff    	je     80100d82 <consoleintr+0x42>
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
801013d2:	8b 0d a4 04 11 80    	mov    0x801104a4,%ecx
801013d8:	e9 30 fc ff ff       	jmp    8010100d <consoleintr+0x2cd>
          if (saveInp.copybuf[(input.e-backs)%INPUT_BUF] == '\0')
801013dd:	89 c7                	mov    %eax,%edi
801013df:	2b 3d 98 05 11 80    	sub    0x80110598,%edi
801013e5:	89 fe                	mov    %edi,%esi
801013e7:	83 e6 7f             	and    $0x7f,%esi
801013ea:	80 be 20 04 11 80 00 	cmpb   $0x0,-0x7feefbe0(%esi)
801013f1:	0f 85 0d 01 00 00    	jne    80101504 <consoleintr+0x7c4>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
801013f7:	88 96 20 04 11 80    	mov    %dl,-0x7feefbe0(%esi)
801013fd:	e9 1a fe ff ff       	jmp    8010121c <consoleintr+0x4dc>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101402:	83 ec 0c             	sub    $0xc,%esp
  for(int i=end_index; i<input.e ; i++)
80101405:	83 c3 01             	add    $0x1,%ebx
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101408:	6a 08                	push   $0x8
8010140a:	e8 91 57 00 00       	call   80106ba0 <uartputc>
8010140f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101416:	e8 85 57 00 00       	call   80106ba0 <uartputc>
8010141b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101422:	e8 79 57 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
80101427:	b8 00 01 00 00       	mov    $0x100,%eax
8010142c:	e8 5f f1 ff ff       	call   80100590 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80101431:	83 c4 10             	add    $0x10,%esp
80101434:	3b 1d 48 05 11 80    	cmp    0x80110548,%ebx
8010143a:	0f 82 3f fd ff ff    	jb     8010117f <consoleintr+0x43f>
  if(panicked){
80101440:	8b 1d 9c 05 11 80    	mov    0x8011059c,%ebx
80101446:	85 db                	test   %ebx,%ebx
80101448:	0f 84 3b 01 00 00    	je     80101589 <consoleintr+0x849>
8010144e:	fa                   	cli
    for(;;)
8010144f:	eb fe                	jmp    8010144f <consoleintr+0x70f>
80101451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101458:	83 ec 0c             	sub    $0xc,%esp
8010145b:	6a 08                	push   $0x8
8010145d:	e8 3e 57 00 00       	call   80106ba0 <uartputc>
80101462:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101469:	e8 32 57 00 00       	call   80106ba0 <uartputc>
8010146e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101475:	e8 26 57 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
8010147a:	b8 00 01 00 00       	mov    $0x100,%eax
8010147f:	e8 0c f1 ff ff       	call   80100590 <cgaputc>
80101484:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
80101487:	a1 40 05 11 80       	mov    0x80110540,%eax
8010148c:	83 e8 80             	sub    $0xffffff80,%eax
8010148f:	39 05 48 05 11 80    	cmp    %eax,0x80110548
80101495:	0f 85 e7 f8 ff ff    	jne    80100d82 <consoleintr+0x42>
8010149b:	e9 c9 fd ff ff       	jmp    80101269 <consoleintr+0x529>
          if(check_if_history(buf_value))
801014a0:	83 f8 07             	cmp    $0x7,%eax
801014a3:	0f 85 07 fe ff ff    	jne    801012b0 <consoleintr+0x570>
            release(&cons.lock);
801014a9:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014ac:	31 db                	xor    %ebx,%ebx
            release(&cons.lock);
801014ae:	68 60 05 11 80       	push   $0x80110560
801014b3:	e8 88 3d 00 00       	call   80105240 <release>
            for(int i=0 ; i<history.count+1 ; i++)
801014b8:	8b 15 00 04 11 80    	mov    0x80110400,%edx
801014be:	83 c4 10             	add    $0x10,%esp
801014c1:	85 d2                	test   %edx,%edx
801014c3:	78 2a                	js     801014ef <consoleintr+0x7af>
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014c5:	8b 83 04 ff 10 80    	mov    -0x7fef00fc(%ebx),%eax
801014cb:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014ce:	83 c6 01             	add    $0x1,%esi
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014d1:	01 d8                	add    %ebx,%eax
            for(int i=0 ; i<history.count+1 ; i++)
801014d3:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014d9:	05 80 fe 10 80       	add    $0x8010fe80,%eax
801014de:	50                   	push   %eax
801014df:	e8 ac f5 ff ff       	call   80100a90 <cprintf>
            for(int i=0 ; i<history.count+1 ; i++)
801014e4:	83 c4 10             	add    $0x10,%esp
801014e7:	39 35 00 04 11 80    	cmp    %esi,0x80110400
801014ed:	7d d6                	jge    801014c5 <consoleintr+0x785>
            acquire(&cons.lock);
801014ef:	83 ec 0c             	sub    $0xc,%esp
801014f2:	68 60 05 11 80       	push   $0x80110560
801014f7:	e8 a4 3d 00 00       	call   801052a0 <acquire>
801014fc:	83 c4 10             	add    $0x10,%esp
801014ff:	e9 f1 fd ff ff       	jmp    801012f5 <consoleintr+0x5b5>
            for (int i = input.e; i > input.e - backs; i--)
80101504:	89 c1                	mov    %eax,%ecx
80101506:	39 c7                	cmp    %eax,%edi
80101508:	0f 83 e9 fe ff ff    	jae    801013f7 <consoleintr+0x6b7>
8010150e:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
              saveInp.copybuf[i] = saveInp.copybuf[i - 1]; // shift to right all letters in buffer
80101514:	0f b6 81 1f 04 11 80 	movzbl -0x7feefbe1(%ecx),%eax
8010151b:	83 e9 01             	sub    $0x1,%ecx
8010151e:	88 81 21 04 11 80    	mov    %al,-0x7feefbdf(%ecx)
            for (int i = input.e; i > input.e - backs; i--)
80101524:	39 cf                	cmp    %ecx,%edi
80101526:	72 ec                	jb     80101514 <consoleintr+0x7d4>
80101528:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
8010152e:	e9 c4 fe ff ff       	jmp    801013f7 <consoleintr+0x6b7>
80101533:	b8 80 fe 10 80       	mov    $0x8010fe80,%eax
80101538:	ba 6c 03 11 80       	mov    $0x8011036c,%edx
                history.instructions[i] = history.instructions[i+1]; 
8010153d:	8d b0 8c 00 00 00    	lea    0x8c(%eax),%esi
80101543:	89 c7                	mov    %eax,%edi
              for (int i = 0; i < 9; i++) {
80101545:	05 8c 00 00 00       	add    $0x8c,%eax
                history.instructions[i] = history.instructions[i+1]; 
8010154a:	b9 23 00 00 00       	mov    $0x23,%ecx
8010154f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              for (int i = 0; i < 9; i++) {
80101551:	3d 6c 03 11 80       	cmp    $0x8011036c,%eax
80101556:	75 e5                	jne    8010153d <consoleintr+0x7fd>
              history.instructions[9] = input;
80101558:	be c0 04 11 80       	mov    $0x801104c0,%esi
8010155d:	b9 23 00 00 00       	mov    $0x23,%ecx
80101562:	89 d7                	mov    %edx,%edi
              history.index = 9;
80101564:	c7 05 f8 03 11 80 09 	movl   $0x9,0x801103f8
8010156b:	00 00 00 
              history.instructions[9] = input;
8010156e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              history.last = 9;
80101570:	c7 05 fc 03 11 80 09 	movl   $0x9,0x801103fc
80101577:	00 00 00 
              history.count = 10;
8010157a:	c7 05 00 04 11 80 0a 	movl   $0xa,0x80110400
80101581:	00 00 00 
80101584:	e9 6c fd ff ff       	jmp    801012f5 <consoleintr+0x5b5>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101589:	83 ec 0c             	sub    $0xc,%esp
8010158c:	6a 08                	push   $0x8
8010158e:	e8 0d 56 00 00       	call   80106ba0 <uartputc>
80101593:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010159a:	e8 01 56 00 00       	call   80106ba0 <uartputc>
8010159f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801015a6:	e8 f5 55 00 00       	call   80106ba0 <uartputc>
  cgaputc(c);
801015ab:	b8 00 01 00 00       	mov    $0x100,%eax
801015b0:	e8 db ef ff ff       	call   80100590 <cgaputc>
    switch (input.buf[first_num_index-1])
801015b5:	0f b6 87 bf 04 11 80 	movzbl -0x7feefb41(%edi),%eax
801015bc:	83 c4 10             	add    $0x10,%esp
801015bf:	3c 2d                	cmp    $0x2d,%al
801015c1:	0f 84 42 01 00 00    	je     80101709 <consoleintr+0x9c9>
801015c7:	0f 8f ad 00 00 00    	jg     8010167a <consoleintr+0x93a>
801015cd:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
801015d3:	3c 2a                	cmp    $0x2a,%al
801015d5:	0f 84 84 00 00 00    	je     8010165f <consoleintr+0x91f>
801015db:	3c 2b                	cmp    $0x2b,%al
801015dd:	75 15                	jne    801015f4 <consoleintr+0x8b4>
      int_to_str(first_num + second_num, result);
801015df:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
801015e5:	8b 8d bc fd ff ff    	mov    -0x244(%ebp),%ecx
801015eb:	89 fa                	mov    %edi,%edx
801015ed:	01 c8                	add    %ecx,%eax
801015ef:	e8 8c ec ff ff       	call   80100280 <int_to_str>
    release(&cons.lock);
801015f4:	83 ec 0c             	sub    $0xc,%esp
801015f7:	68 60 05 11 80       	push   $0x80110560
801015fc:	e8 3f 3c 00 00       	call   80105240 <release>
    cprintf(result);
80101601:	89 3c 24             	mov    %edi,(%esp)
80101604:	e8 87 f4 ff ff       	call   80100a90 <cprintf>
  while (new_string[j]!='\0')
80101609:	0f b6 8d e8 fd ff ff 	movzbl -0x218(%ebp),%ecx
80101610:	83 c4 10             	add    $0x10,%esp
  int i = update_index;
80101613:	89 f0                	mov    %esi,%eax
  while (new_string[j]!='\0')
80101615:	84 c9                	test   %cl,%cl
80101617:	74 20                	je     80101639 <consoleintr+0x8f9>
    j++;
80101619:	83 c3 01             	add    $0x1,%ebx
    input.buf[i] = new_string[j];
8010161c:	88 88 c0 04 11 80    	mov    %cl,-0x7feefb40(%eax)
    i++;
80101622:	83 c0 01             	add    $0x1,%eax
  while (new_string[j]!='\0')
80101625:	0f b6 0c 1f          	movzbl (%edi,%ebx,1),%ecx
80101629:	84 c9                	test   %cl,%cl
8010162b:	75 ec                	jne    80101619 <consoleintr+0x8d9>
8010162d:	eb 0a                	jmp    80101639 <consoleintr+0x8f9>
    input.buf[i] = '\0';
8010162f:	c6 80 c0 04 11 80 00 	movb   $0x0,-0x7feefb40(%eax)
    i++;
80101636:	83 c0 01             	add    $0x1,%eax
  while (input.buf[i]!='\0')
80101639:	80 b8 c0 04 11 80 00 	cmpb   $0x0,-0x7feefb40(%eax)
80101640:	75 ed                	jne    8010162f <consoleintr+0x8ef>
    acquire(&cons.lock);
80101642:	83 ec 0c             	sub    $0xc,%esp
  input.e = update_index+j;
80101645:	01 f3                	add    %esi,%ebx
80101647:	89 1d 48 05 11 80    	mov    %ebx,0x80110548
    acquire(&cons.lock);
8010164d:	68 60 05 11 80       	push   $0x80110560
80101652:	e8 49 3c 00 00       	call   801052a0 <acquire>
80101657:	83 c4 10             	add    $0x10,%esp
8010165a:	e9 23 f7 ff ff       	jmp    80100d82 <consoleintr+0x42>
      int_to_str(first_num * second_num, result);
8010165f:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
80101665:	8b 8d bc fd ff ff    	mov    -0x244(%ebp),%ecx
8010166b:	89 fa                	mov    %edi,%edx
8010166d:	0f af c1             	imul   %ecx,%eax
80101670:	e8 0b ec ff ff       	call   80100280 <int_to_str>
      break;
80101675:	e9 7a ff ff ff       	jmp    801015f4 <consoleintr+0x8b4>
8010167a:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    switch (input.buf[first_num_index-1])
80101680:	3c 2f                	cmp    $0x2f,%al
80101682:	0f 85 6c ff ff ff    	jne    801015f4 <consoleintr+0x8b4>
    int int_part = (int)num;
80101688:	d9 bd d6 fd ff ff    	fnstcw -0x22a(%ebp)
      float_to_str((float)second_num / (float)first_num, result);
8010168e:	db 85 bc fd ff ff    	fildl  -0x244(%ebp)
80101694:	db 85 c0 fd ff ff    	fildl  -0x240(%ebp)
    int int_part = (int)num;
8010169a:	0f b7 85 d6 fd ff ff 	movzwl -0x22a(%ebp),%eax
      float_to_str((float)second_num / (float)first_num, result);
801016a1:	de f9                	fdivrp %st,%st(1)
    int int_part = (int)num;
801016a3:	80 cc 0c             	or     $0xc,%ah
801016a6:	66 89 85 d4 fd ff ff 	mov    %ax,-0x22c(%ebp)
801016ad:	d9 ad d4 fd ff ff    	fldcw  -0x22c(%ebp)
801016b3:	db 95 c0 fd ff ff    	fistl  -0x240(%ebp)
801016b9:	d9 ad d6 fd ff ff    	fldcw  -0x22a(%ebp)
    int fractional_part = (int)((num - int_part) * 10);
801016bf:	db 85 c0 fd ff ff    	fildl  -0x240(%ebp)
    int int_part = (int)num;
801016c5:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
    int fractional_part = (int)((num - int_part) * 10);
801016cb:	de e9                	fsubrp %st,%st(1)
801016cd:	d8 0d 0c 86 10 80    	fmuls  0x8010860c
801016d3:	d9 ad d4 fd ff ff    	fldcw  -0x22c(%ebp)
801016d9:	db 9d c0 fd ff ff    	fistpl -0x240(%ebp)
801016df:	d9 ad d6 fd ff ff    	fldcw  -0x22a(%ebp)
801016e5:	8b bd c0 fd ff ff    	mov    -0x240(%ebp),%edi
    if (fractional_part == 0)
801016eb:	85 ff                	test   %edi,%edi
      int index = int_to_str(int_part, str);
801016ed:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
801016f3:	89 fa                	mov    %edi,%edx
    if (fractional_part == 0)
801016f5:	75 32                	jne    80101729 <consoleintr+0x9e9>
      int index = int_to_str(int_part, str);
801016f7:	e8 84 eb ff ff       	call   80100280 <int_to_str>
      str[index++] = '\0';
801016fc:	c6 84 05 e8 fd ff ff 	movb   $0x0,-0x218(%ebp,%eax,1)
80101703:	00 
80101704:	e9 eb fe ff ff       	jmp    801015f4 <consoleintr+0x8b4>
      int_to_str(second_num - first_num, result);
80101709:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
8010170f:	8b 8d c0 fd ff ff    	mov    -0x240(%ebp),%ecx
80101715:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
8010171b:	89 fa                	mov    %edi,%edx
8010171d:	29 c8                	sub    %ecx,%eax
8010171f:	e8 5c eb ff ff       	call   80100280 <int_to_str>
      break;
80101724:	e9 cb fe ff ff       	jmp    801015f4 <consoleintr+0x8b4>
      int index = int_to_str(int_part, str);
80101729:	e8 52 eb ff ff       	call   80100280 <int_to_str>
      if (fractional_part < 0) 
8010172e:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
      str[index++] = '.';
80101734:	c6 84 05 e8 fd ff ff 	movb   $0x2e,-0x218(%ebp,%eax,1)
8010173b:	2e 
      if (fractional_part < 0) 
8010173c:	89 d1                	mov    %edx,%ecx
      str[index] = '\0';
8010173e:	c6 84 05 ea fd ff ff 	movb   $0x0,-0x216(%ebp,%eax,1)
80101745:	00 
      if (fractional_part < 0) 
80101746:	f7 d9                	neg    %ecx
80101748:	0f 48 ca             	cmovs  %edx,%ecx
      str[index++] = fractional_part + '0';
8010174b:	83 c1 30             	add    $0x30,%ecx
8010174e:	88 8c 05 e9 fd ff ff 	mov    %cl,-0x217(%ebp,%eax,1)
      str[index] = '\0';
80101755:	e9 9a fe ff ff       	jmp    801015f4 <consoleintr+0x8b4>
8010175a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101760 <consoleinit>:

void
consoleinit(void)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101766:	68 f0 80 10 80       	push   $0x801080f0
8010176b:	68 60 05 11 80       	push   $0x80110560
80101770:	e8 3b 39 00 00       	call   801050b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101775:	58                   	pop    %eax
80101776:	5a                   	pop    %edx
80101777:	6a 00                	push   $0x0
80101779:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010177b:	c7 05 4c 0f 11 80 c0 	movl   $0x801007c0,0x80110f4c
80101782:	07 10 80 
  devsw[CONSOLE].read = consoleread;
80101785:	c7 05 48 0f 11 80 30 	movl   $0x80100330,0x80110f48
8010178c:	03 10 80 
  cons.locking = 1;
8010178f:	c7 05 94 05 11 80 01 	movl   $0x1,0x80110594
80101796:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101799:	e8 c2 19 00 00       	call   80103160 <ioapicenable>
}
8010179e:	83 c4 10             	add    $0x10,%esp
801017a1:	c9                   	leave
801017a2:	c3                   	ret
801017a3:	66 90                	xchg   %ax,%ax
801017a5:	66 90                	xchg   %ax,%ax
801017a7:	66 90                	xchg   %ax,%ax
801017a9:	66 90                	xchg   %ax,%ax
801017ab:	66 90                	xchg   %ax,%ax
801017ad:	66 90                	xchg   %ax,%ax
801017af:	90                   	nop

801017b0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801017bc:	e8 9f 2e 00 00       	call   80104660 <myproc>
801017c1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801017c7:	e8 74 22 00 00       	call   80103a40 <begin_op>

  if((ip = namei(path)) == 0){
801017cc:	83 ec 0c             	sub    $0xc,%esp
801017cf:	ff 75 08             	push   0x8(%ebp)
801017d2:	e8 a9 15 00 00       	call   80102d80 <namei>
801017d7:	83 c4 10             	add    $0x10,%esp
801017da:	85 c0                	test   %eax,%eax
801017dc:	0f 84 30 03 00 00    	je     80101b12 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801017e2:	83 ec 0c             	sub    $0xc,%esp
801017e5:	89 c7                	mov    %eax,%edi
801017e7:	50                   	push   %eax
801017e8:	e8 b3 0c 00 00       	call   801024a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801017ed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801017f3:	6a 34                	push   $0x34
801017f5:	6a 00                	push   $0x0
801017f7:	50                   	push   %eax
801017f8:	57                   	push   %edi
801017f9:	e8 b2 0f 00 00       	call   801027b0 <readi>
801017fe:	83 c4 20             	add    $0x20,%esp
80101801:	83 f8 34             	cmp    $0x34,%eax
80101804:	0f 85 01 01 00 00    	jne    8010190b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010180a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101811:	45 4c 46 
80101814:	0f 85 f1 00 00 00    	jne    8010190b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
8010181a:	e8 11 65 00 00       	call   80107d30 <setupkvm>
8010181f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101825:	85 c0                	test   %eax,%eax
80101827:	0f 84 de 00 00 00    	je     8010190b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010182d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101834:	00 
80101835:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010183b:	0f 84 a1 02 00 00    	je     80101ae2 <exec+0x332>
  sz = 0;
80101841:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101848:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010184b:	31 db                	xor    %ebx,%ebx
8010184d:	e9 8c 00 00 00       	jmp    801018de <exec+0x12e>
80101852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101858:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
8010185f:	75 6c                	jne    801018cd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80101861:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101867:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
8010186d:	0f 82 87 00 00 00    	jb     801018fa <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101873:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101879:	72 7f                	jb     801018fa <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
8010187b:	83 ec 04             	sub    $0x4,%esp
8010187e:	50                   	push   %eax
8010187f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101885:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010188b:	e8 c0 62 00 00       	call   80107b50 <allocuvm>
80101890:	83 c4 10             	add    $0x10,%esp
80101893:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101899:	85 c0                	test   %eax,%eax
8010189b:	74 5d                	je     801018fa <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
8010189d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018a8:	75 50                	jne    801018fa <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801018b3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801018b9:	57                   	push   %edi
801018ba:	50                   	push   %eax
801018bb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018c1:	e8 9a 61 00 00       	call   80107a60 <loaduvm>
801018c6:	83 c4 20             	add    $0x20,%esp
801018c9:	85 c0                	test   %eax,%eax
801018cb:	78 2d                	js     801018fa <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801018cd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801018d4:	83 c3 01             	add    $0x1,%ebx
801018d7:	83 c6 20             	add    $0x20,%esi
801018da:	39 d8                	cmp    %ebx,%eax
801018dc:	7e 52                	jle    80101930 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801018de:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801018e4:	6a 20                	push   $0x20
801018e6:	56                   	push   %esi
801018e7:	50                   	push   %eax
801018e8:	57                   	push   %edi
801018e9:	e8 c2 0e 00 00       	call   801027b0 <readi>
801018ee:	83 c4 10             	add    $0x10,%esp
801018f1:	83 f8 20             	cmp    $0x20,%eax
801018f4:	0f 84 5e ff ff ff    	je     80101858 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
801018fa:	83 ec 0c             	sub    $0xc,%esp
801018fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101903:	e8 a8 63 00 00       	call   80107cb0 <freevm>
  if(ip){
80101908:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010190b:	83 ec 0c             	sub    $0xc,%esp
8010190e:	57                   	push   %edi
8010190f:	e8 1c 0e 00 00       	call   80102730 <iunlockput>
    end_op();
80101914:	e8 97 21 00 00       	call   80103ab0 <end_op>
80101919:	83 c4 10             	add    $0x10,%esp
    return -1;
8010191c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80101921:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101924:	5b                   	pop    %ebx
80101925:	5e                   	pop    %esi
80101926:	5f                   	pop    %edi
80101927:	5d                   	pop    %ebp
80101928:	c3                   	ret
80101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80101930:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80101936:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
8010193c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101942:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80101948:	83 ec 0c             	sub    $0xc,%esp
8010194b:	57                   	push   %edi
8010194c:	e8 df 0d 00 00       	call   80102730 <iunlockput>
  end_op();
80101951:	e8 5a 21 00 00       	call   80103ab0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101956:	83 c4 0c             	add    $0xc,%esp
80101959:	53                   	push   %ebx
8010195a:	56                   	push   %esi
8010195b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101961:	56                   	push   %esi
80101962:	e8 e9 61 00 00       	call   80107b50 <allocuvm>
80101967:	83 c4 10             	add    $0x10,%esp
8010196a:	89 c7                	mov    %eax,%edi
8010196c:	85 c0                	test   %eax,%eax
8010196e:	0f 84 86 00 00 00    	je     801019fa <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101974:	83 ec 08             	sub    $0x8,%esp
80101977:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
8010197d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010197f:	50                   	push   %eax
80101980:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80101981:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101983:	e8 48 64 00 00       	call   80107dd0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101988:	8b 45 0c             	mov    0xc(%ebp),%eax
8010198b:	83 c4 10             	add    $0x10,%esp
8010198e:	8b 10                	mov    (%eax),%edx
80101990:	85 d2                	test   %edx,%edx
80101992:	0f 84 56 01 00 00    	je     80101aee <exec+0x33e>
80101998:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
8010199e:	8b 7d 0c             	mov    0xc(%ebp),%edi
801019a1:	eb 23                	jmp    801019c6 <exec+0x216>
801019a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801019a8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
801019ab:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
801019b2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
801019b8:	8b 14 87             	mov    (%edi,%eax,4),%edx
801019bb:	85 d2                	test   %edx,%edx
801019bd:	74 51                	je     80101a10 <exec+0x260>
    if(argc >= MAXARG)
801019bf:	83 f8 20             	cmp    $0x20,%eax
801019c2:	74 36                	je     801019fa <exec+0x24a>
801019c4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019c6:	83 ec 0c             	sub    $0xc,%esp
801019c9:	52                   	push   %edx
801019ca:	e8 c1 3b 00 00       	call   80105590 <strlen>
801019cf:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801019d1:	58                   	pop    %eax
801019d2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019d5:	83 eb 01             	sub    $0x1,%ebx
801019d8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801019db:	e8 b0 3b 00 00       	call   80105590 <strlen>
801019e0:	83 c0 01             	add    $0x1,%eax
801019e3:	50                   	push   %eax
801019e4:	ff 34 b7             	push   (%edi,%esi,4)
801019e7:	53                   	push   %ebx
801019e8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801019ee:	e8 ad 65 00 00       	call   80107fa0 <copyout>
801019f3:	83 c4 20             	add    $0x20,%esp
801019f6:	85 c0                	test   %eax,%eax
801019f8:	79 ae                	jns    801019a8 <exec+0x1f8>
    freevm(pgdir);
801019fa:	83 ec 0c             	sub    $0xc,%esp
801019fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a03:	e8 a8 62 00 00       	call   80107cb0 <freevm>
80101a08:	83 c4 10             	add    $0x10,%esp
80101a0b:	e9 0c ff ff ff       	jmp    8010191c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a10:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80101a17:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101a1d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101a23:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80101a26:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80101a29:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80101a30:	00 00 00 00 
  ustack[1] = argc;
80101a34:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80101a3a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a41:	ff ff ff 
  ustack[1] = argc;
80101a44:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a4a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80101a4c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a4e:	29 d0                	sub    %edx,%eax
80101a50:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a56:	56                   	push   %esi
80101a57:	51                   	push   %ecx
80101a58:	53                   	push   %ebx
80101a59:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a5f:	e8 3c 65 00 00       	call   80107fa0 <copyout>
80101a64:	83 c4 10             	add    $0x10,%esp
80101a67:	85 c0                	test   %eax,%eax
80101a69:	78 8f                	js     801019fa <exec+0x24a>
  for(last=s=path; *s; s++)
80101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6e:	8b 55 08             	mov    0x8(%ebp),%edx
80101a71:	0f b6 00             	movzbl (%eax),%eax
80101a74:	84 c0                	test   %al,%al
80101a76:	74 17                	je     80101a8f <exec+0x2df>
80101a78:	89 d1                	mov    %edx,%ecx
80101a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80101a80:	83 c1 01             	add    $0x1,%ecx
80101a83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101a85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101a88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80101a8b:	84 c0                	test   %al,%al
80101a8d:	75 f1                	jne    80101a80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101a8f:	83 ec 04             	sub    $0x4,%esp
80101a92:	6a 10                	push   $0x10
80101a94:	52                   	push   %edx
80101a95:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80101a9b:	8d 46 6c             	lea    0x6c(%esi),%eax
80101a9e:	50                   	push   %eax
80101a9f:	e8 ac 3a 00 00       	call   80105550 <safestrcpy>
  curproc->pgdir = pgdir;
80101aa4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80101aaa:	89 f0                	mov    %esi,%eax
80101aac:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80101aaf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101ab1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101ab4:	89 c1                	mov    %eax,%ecx
80101ab6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101abc:	8b 40 18             	mov    0x18(%eax),%eax
80101abf:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101ac2:	8b 41 18             	mov    0x18(%ecx),%eax
80101ac5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101ac8:	89 0c 24             	mov    %ecx,(%esp)
80101acb:	e8 00 5e 00 00       	call   801078d0 <switchuvm>
  freevm(oldpgdir);
80101ad0:	89 34 24             	mov    %esi,(%esp)
80101ad3:	e8 d8 61 00 00       	call   80107cb0 <freevm>
  return 0;
80101ad8:	83 c4 10             	add    $0x10,%esp
80101adb:	31 c0                	xor    %eax,%eax
80101add:	e9 3f fe ff ff       	jmp    80101921 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101ae2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101ae7:	31 f6                	xor    %esi,%esi
80101ae9:	e9 5a fe ff ff       	jmp    80101948 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80101aee:	be 10 00 00 00       	mov    $0x10,%esi
80101af3:	ba 04 00 00 00       	mov    $0x4,%edx
80101af8:	b8 03 00 00 00       	mov    $0x3,%eax
80101afd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101b04:	00 00 00 
80101b07:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80101b0d:	e9 17 ff ff ff       	jmp    80101a29 <exec+0x279>
    end_op();
80101b12:	e8 99 1f 00 00       	call   80103ab0 <end_op>
    cprintf("exec: fail\n");
80101b17:	83 ec 0c             	sub    $0xc,%esp
80101b1a:	68 f8 80 10 80       	push   $0x801080f8
80101b1f:	e8 6c ef ff ff       	call   80100a90 <cprintf>
    return -1;
80101b24:	83 c4 10             	add    $0x10,%esp
80101b27:	e9 f0 fd ff ff       	jmp    8010191c <exec+0x16c>
80101b2c:	66 90                	xchg   %ax,%ax
80101b2e:	66 90                	xchg   %ax,%ax

80101b30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101b36:	68 04 81 10 80       	push   $0x80108104
80101b3b:	68 a0 05 11 80       	push   $0x801105a0
80101b40:	e8 6b 35 00 00       	call   801050b0 <initlock>
}
80101b45:	83 c4 10             	add    $0x10,%esp
80101b48:	c9                   	leave
80101b49:	c3                   	ret
80101b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b54:	bb d4 05 11 80       	mov    $0x801105d4,%ebx
{
80101b59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101b5c:	68 a0 05 11 80       	push   $0x801105a0
80101b61:	e8 3a 37 00 00       	call   801052a0 <acquire>
80101b66:	83 c4 10             	add    $0x10,%esp
80101b69:	eb 10                	jmp    80101b7b <filealloc+0x2b>
80101b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b70:	83 c3 18             	add    $0x18,%ebx
80101b73:	81 fb 34 0f 11 80    	cmp    $0x80110f34,%ebx
80101b79:	74 25                	je     80101ba0 <filealloc+0x50>
    if(f->ref == 0){
80101b7b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b7e:	85 c0                	test   %eax,%eax
80101b80:	75 ee                	jne    80101b70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101b82:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101b85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101b8c:	68 a0 05 11 80       	push   $0x801105a0
80101b91:	e8 aa 36 00 00       	call   80105240 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101b96:	89 d8                	mov    %ebx,%eax
      return f;
80101b98:	83 c4 10             	add    $0x10,%esp
}
80101b9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b9e:	c9                   	leave
80101b9f:	c3                   	ret
  release(&ftable.lock);
80101ba0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101ba3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101ba5:	68 a0 05 11 80       	push   $0x801105a0
80101baa:	e8 91 36 00 00       	call   80105240 <release>
}
80101baf:	89 d8                	mov    %ebx,%eax
  return 0;
80101bb1:	83 c4 10             	add    $0x10,%esp
}
80101bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bb7:	c9                   	leave
80101bb8:	c3                   	ret
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bc0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	53                   	push   %ebx
80101bc4:	83 ec 10             	sub    $0x10,%esp
80101bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101bca:	68 a0 05 11 80       	push   $0x801105a0
80101bcf:	e8 cc 36 00 00       	call   801052a0 <acquire>
  if(f->ref < 1)
80101bd4:	8b 43 04             	mov    0x4(%ebx),%eax
80101bd7:	83 c4 10             	add    $0x10,%esp
80101bda:	85 c0                	test   %eax,%eax
80101bdc:	7e 1a                	jle    80101bf8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101bde:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101be1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101be4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101be7:	68 a0 05 11 80       	push   $0x801105a0
80101bec:	e8 4f 36 00 00       	call   80105240 <release>
  return f;
}
80101bf1:	89 d8                	mov    %ebx,%eax
80101bf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bf6:	c9                   	leave
80101bf7:	c3                   	ret
    panic("filedup");
80101bf8:	83 ec 0c             	sub    $0xc,%esp
80101bfb:	68 0b 81 10 80       	push   $0x8010810b
80101c00:	e8 0b e9 ff ff       	call   80100510 <panic>
80101c05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c0c:	00 
80101c0d:	8d 76 00             	lea    0x0(%esi),%esi

80101c10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	83 ec 28             	sub    $0x28,%esp
80101c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101c1c:	68 a0 05 11 80       	push   $0x801105a0
80101c21:	e8 7a 36 00 00       	call   801052a0 <acquire>
  if(f->ref < 1)
80101c26:	8b 53 04             	mov    0x4(%ebx),%edx
80101c29:	83 c4 10             	add    $0x10,%esp
80101c2c:	85 d2                	test   %edx,%edx
80101c2e:	0f 8e a5 00 00 00    	jle    80101cd9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101c34:	83 ea 01             	sub    $0x1,%edx
80101c37:	89 53 04             	mov    %edx,0x4(%ebx)
80101c3a:	75 44                	jne    80101c80 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c3c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c40:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101c43:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101c45:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101c4b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101c4e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c51:	8b 43 10             	mov    0x10(%ebx),%eax
80101c54:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101c57:	68 a0 05 11 80       	push   $0x801105a0
80101c5c:	e8 df 35 00 00       	call   80105240 <release>

  if(ff.type == FD_PIPE)
80101c61:	83 c4 10             	add    $0x10,%esp
80101c64:	83 ff 01             	cmp    $0x1,%edi
80101c67:	74 57                	je     80101cc0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101c69:	83 ff 02             	cmp    $0x2,%edi
80101c6c:	74 2a                	je     80101c98 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c71:	5b                   	pop    %ebx
80101c72:	5e                   	pop    %esi
80101c73:	5f                   	pop    %edi
80101c74:	5d                   	pop    %ebp
80101c75:	c3                   	ret
80101c76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c7d:	00 
80101c7e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101c80:	c7 45 08 a0 05 11 80 	movl   $0x801105a0,0x8(%ebp)
}
80101c87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8a:	5b                   	pop    %ebx
80101c8b:	5e                   	pop    %esi
80101c8c:	5f                   	pop    %edi
80101c8d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101c8e:	e9 ad 35 00 00       	jmp    80105240 <release>
80101c93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101c98:	e8 a3 1d 00 00       	call   80103a40 <begin_op>
    iput(ff.ip);
80101c9d:	83 ec 0c             	sub    $0xc,%esp
80101ca0:	ff 75 e0             	push   -0x20(%ebp)
80101ca3:	e8 28 09 00 00       	call   801025d0 <iput>
    end_op();
80101ca8:	83 c4 10             	add    $0x10,%esp
}
80101cab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cae:	5b                   	pop    %ebx
80101caf:	5e                   	pop    %esi
80101cb0:	5f                   	pop    %edi
80101cb1:	5d                   	pop    %ebp
    end_op();
80101cb2:	e9 f9 1d 00 00       	jmp    80103ab0 <end_op>
80101cb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cbe:	00 
80101cbf:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101cc0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101cc4:	83 ec 08             	sub    $0x8,%esp
80101cc7:	53                   	push   %ebx
80101cc8:	56                   	push   %esi
80101cc9:	e8 32 25 00 00       	call   80104200 <pipeclose>
80101cce:	83 c4 10             	add    $0x10,%esp
}
80101cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cd4:	5b                   	pop    %ebx
80101cd5:	5e                   	pop    %esi
80101cd6:	5f                   	pop    %edi
80101cd7:	5d                   	pop    %ebp
80101cd8:	c3                   	ret
    panic("fileclose");
80101cd9:	83 ec 0c             	sub    $0xc,%esp
80101cdc:	68 13 81 10 80       	push   $0x80108113
80101ce1:	e8 2a e8 ff ff       	call   80100510 <panic>
80101ce6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ced:	00 
80101cee:	66 90                	xchg   %ax,%ax

80101cf0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	53                   	push   %ebx
80101cf4:	83 ec 04             	sub    $0x4,%esp
80101cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101cfa:	83 3b 02             	cmpl   $0x2,(%ebx)
80101cfd:	75 31                	jne    80101d30 <filestat+0x40>
    ilock(f->ip);
80101cff:	83 ec 0c             	sub    $0xc,%esp
80101d02:	ff 73 10             	push   0x10(%ebx)
80101d05:	e8 96 07 00 00       	call   801024a0 <ilock>
    stati(f->ip, st);
80101d0a:	58                   	pop    %eax
80101d0b:	5a                   	pop    %edx
80101d0c:	ff 75 0c             	push   0xc(%ebp)
80101d0f:	ff 73 10             	push   0x10(%ebx)
80101d12:	e8 69 0a 00 00       	call   80102780 <stati>
    iunlock(f->ip);
80101d17:	59                   	pop    %ecx
80101d18:	ff 73 10             	push   0x10(%ebx)
80101d1b:	e8 60 08 00 00       	call   80102580 <iunlock>
    return 0;
  }
  return -1;
}
80101d20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101d23:	83 c4 10             	add    $0x10,%esp
80101d26:	31 c0                	xor    %eax,%eax
}
80101d28:	c9                   	leave
80101d29:	c3                   	ret
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101d38:	c9                   	leave
80101d39:	c3                   	ret
80101d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101d52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d56:	74 60                	je     80101db8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101d58:	8b 03                	mov    (%ebx),%eax
80101d5a:	83 f8 01             	cmp    $0x1,%eax
80101d5d:	74 41                	je     80101da0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101d5f:	83 f8 02             	cmp    $0x2,%eax
80101d62:	75 5b                	jne    80101dbf <fileread+0x7f>
    ilock(f->ip);
80101d64:	83 ec 0c             	sub    $0xc,%esp
80101d67:	ff 73 10             	push   0x10(%ebx)
80101d6a:	e8 31 07 00 00       	call   801024a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d6f:	57                   	push   %edi
80101d70:	ff 73 14             	push   0x14(%ebx)
80101d73:	56                   	push   %esi
80101d74:	ff 73 10             	push   0x10(%ebx)
80101d77:	e8 34 0a 00 00       	call   801027b0 <readi>
80101d7c:	83 c4 20             	add    $0x20,%esp
80101d7f:	89 c6                	mov    %eax,%esi
80101d81:	85 c0                	test   %eax,%eax
80101d83:	7e 03                	jle    80101d88 <fileread+0x48>
      f->off += r;
80101d85:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101d88:	83 ec 0c             	sub    $0xc,%esp
80101d8b:	ff 73 10             	push   0x10(%ebx)
80101d8e:	e8 ed 07 00 00       	call   80102580 <iunlock>
    return r;
80101d93:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	89 f0                	mov    %esi,%eax
80101d9b:	5b                   	pop    %ebx
80101d9c:	5e                   	pop    %esi
80101d9d:	5f                   	pop    %edi
80101d9e:	5d                   	pop    %ebp
80101d9f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101da0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101da3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da9:	5b                   	pop    %ebx
80101daa:	5e                   	pop    %esi
80101dab:	5f                   	pop    %edi
80101dac:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101dad:	e9 0e 26 00 00       	jmp    801043c0 <piperead>
80101db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101db8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dbd:	eb d7                	jmp    80101d96 <fileread+0x56>
  panic("fileread");
80101dbf:	83 ec 0c             	sub    $0xc,%esp
80101dc2:	68 1d 81 10 80       	push   $0x8010811d
80101dc7:	e8 44 e7 ff ff       	call   80100510 <panic>
80101dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->writable == 0)
80101de5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101de9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101dec:	0f 84 bb 00 00 00    	je     80101ead <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101df2:	8b 03                	mov    (%ebx),%eax
80101df4:	83 f8 01             	cmp    $0x1,%eax
80101df7:	0f 84 bf 00 00 00    	je     80101ebc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101dfd:	83 f8 02             	cmp    $0x2,%eax
80101e00:	0f 85 c8 00 00 00    	jne    80101ece <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101e06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101e09:	31 f6                	xor    %esi,%esi
    while(i < n){
80101e0b:	85 c0                	test   %eax,%eax
80101e0d:	7f 30                	jg     80101e3f <filewrite+0x6f>
80101e0f:	e9 94 00 00 00       	jmp    80101ea8 <filewrite+0xd8>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101e18:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101e1b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
80101e1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101e21:	ff 73 10             	push   0x10(%ebx)
80101e24:	e8 57 07 00 00       	call   80102580 <iunlock>
      end_op();
80101e29:	e8 82 1c 00 00       	call   80103ab0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101e2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e31:	83 c4 10             	add    $0x10,%esp
80101e34:	39 c7                	cmp    %eax,%edi
80101e36:	75 5c                	jne    80101e94 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101e38:	01 fe                	add    %edi,%esi
    while(i < n){
80101e3a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101e3d:	7e 69                	jle    80101ea8 <filewrite+0xd8>
      int n1 = n - i;
80101e3f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101e42:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101e47:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101e49:	39 c7                	cmp    %eax,%edi
80101e4b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101e4e:	e8 ed 1b 00 00       	call   80103a40 <begin_op>
      ilock(f->ip);
80101e53:	83 ec 0c             	sub    $0xc,%esp
80101e56:	ff 73 10             	push   0x10(%ebx)
80101e59:	e8 42 06 00 00       	call   801024a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101e5e:	57                   	push   %edi
80101e5f:	ff 73 14             	push   0x14(%ebx)
80101e62:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e65:	01 f0                	add    %esi,%eax
80101e67:	50                   	push   %eax
80101e68:	ff 73 10             	push   0x10(%ebx)
80101e6b:	e8 40 0a 00 00       	call   801028b0 <writei>
80101e70:	83 c4 20             	add    $0x20,%esp
80101e73:	85 c0                	test   %eax,%eax
80101e75:	7f a1                	jg     80101e18 <filewrite+0x48>
80101e77:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101e7a:	83 ec 0c             	sub    $0xc,%esp
80101e7d:	ff 73 10             	push   0x10(%ebx)
80101e80:	e8 fb 06 00 00       	call   80102580 <iunlock>
      end_op();
80101e85:	e8 26 1c 00 00       	call   80103ab0 <end_op>
      if(r < 0)
80101e8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e8d:	83 c4 10             	add    $0x10,%esp
80101e90:	85 c0                	test   %eax,%eax
80101e92:	75 14                	jne    80101ea8 <filewrite+0xd8>
        panic("short filewrite");
80101e94:	83 ec 0c             	sub    $0xc,%esp
80101e97:	68 26 81 10 80       	push   $0x80108126
80101e9c:	e8 6f e6 ff ff       	call   80100510 <panic>
80101ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101ea8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101eab:	74 05                	je     80101eb2 <filewrite+0xe2>
80101ead:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101eb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb5:	89 f0                	mov    %esi,%eax
80101eb7:	5b                   	pop    %ebx
80101eb8:	5e                   	pop    %esi
80101eb9:	5f                   	pop    %edi
80101eba:	5d                   	pop    %ebp
80101ebb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101ebc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ebf:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec5:	5b                   	pop    %ebx
80101ec6:	5e                   	pop    %esi
80101ec7:	5f                   	pop    %edi
80101ec8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101ec9:	e9 d2 23 00 00       	jmp    801042a0 <pipewrite>
  panic("filewrite");
80101ece:	83 ec 0c             	sub    $0xc,%esp
80101ed1:	68 2c 81 10 80       	push   $0x8010812c
80101ed6:	e8 35 e6 ff ff       	call   80100510 <panic>
80101edb:	66 90                	xchg   %ax,%ax
80101edd:	66 90                	xchg   %ax,%ax
80101edf:	90                   	nop

80101ee0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	57                   	push   %edi
80101ee4:	56                   	push   %esi
80101ee5:	53                   	push   %ebx
80101ee6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ee9:	8b 0d f4 2b 11 80    	mov    0x80112bf4,%ecx
{
80101eef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101ef2:	85 c9                	test   %ecx,%ecx
80101ef4:	0f 84 8c 00 00 00    	je     80101f86 <balloc+0xa6>
80101efa:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
80101efc:	89 f8                	mov    %edi,%eax
80101efe:	83 ec 08             	sub    $0x8,%esp
80101f01:	89 fe                	mov    %edi,%esi
80101f03:	c1 f8 0c             	sar    $0xc,%eax
80101f06:	03 05 0c 2c 11 80    	add    0x80112c0c,%eax
80101f0c:	50                   	push   %eax
80101f0d:	ff 75 dc             	push   -0x24(%ebp)
80101f10:	e8 bb e1 ff ff       	call   801000d0 <bread>
80101f15:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101f18:	83 c4 10             	add    $0x10,%esp
80101f1b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f1e:	a1 f4 2b 11 80       	mov    0x80112bf4,%eax
80101f23:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101f26:	31 c0                	xor    %eax,%eax
80101f28:	eb 32                	jmp    80101f5c <balloc+0x7c>
80101f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101f30:	89 c1                	mov    %eax,%ecx
80101f32:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
80101f3a:	83 e1 07             	and    $0x7,%ecx
80101f3d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f3f:	89 c1                	mov    %eax,%ecx
80101f41:	c1 f9 03             	sar    $0x3,%ecx
80101f44:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101f49:	89 fa                	mov    %edi,%edx
80101f4b:	85 df                	test   %ebx,%edi
80101f4d:	74 49                	je     80101f98 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f4f:	83 c0 01             	add    $0x1,%eax
80101f52:	83 c6 01             	add    $0x1,%esi
80101f55:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101f5a:	74 07                	je     80101f63 <balloc+0x83>
80101f5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f5f:	39 d6                	cmp    %edx,%esi
80101f61:	72 cd                	jb     80101f30 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101f63:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101f6c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101f72:	e8 79 e2 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101f77:	83 c4 10             	add    $0x10,%esp
80101f7a:	3b 3d f4 2b 11 80    	cmp    0x80112bf4,%edi
80101f80:	0f 82 76 ff ff ff    	jb     80101efc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101f86:	83 ec 0c             	sub    $0xc,%esp
80101f89:	68 36 81 10 80       	push   $0x80108136
80101f8e:	e8 7d e5 ff ff       	call   80100510 <panic>
80101f93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101f98:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101f9b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101f9e:	09 da                	or     %ebx,%edx
80101fa0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101fa4:	57                   	push   %edi
80101fa5:	e8 76 1c 00 00       	call   80103c20 <log_write>
        brelse(bp);
80101faa:	89 3c 24             	mov    %edi,(%esp)
80101fad:	e8 3e e2 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101fb2:	58                   	pop    %eax
80101fb3:	5a                   	pop    %edx
80101fb4:	56                   	push   %esi
80101fb5:	ff 75 dc             	push   -0x24(%ebp)
80101fb8:	e8 13 e1 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101fbd:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101fc0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101fc2:	8d 40 5c             	lea    0x5c(%eax),%eax
80101fc5:	68 00 02 00 00       	push   $0x200
80101fca:	6a 00                	push   $0x0
80101fcc:	50                   	push   %eax
80101fcd:	e8 ce 33 00 00       	call   801053a0 <memset>
  log_write(bp);
80101fd2:	89 1c 24             	mov    %ebx,(%esp)
80101fd5:	e8 46 1c 00 00       	call   80103c20 <log_write>
  brelse(bp);
80101fda:	89 1c 24             	mov    %ebx,(%esp)
80101fdd:	e8 0e e2 ff ff       	call   801001f0 <brelse>
}
80101fe2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe5:	89 f0                	mov    %esi,%eax
80101fe7:	5b                   	pop    %ebx
80101fe8:	5e                   	pop    %esi
80101fe9:	5f                   	pop    %edi
80101fea:	5d                   	pop    %ebp
80101feb:	c3                   	ret
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101ff4:	31 ff                	xor    %edi,%edi
{
80101ff6:	56                   	push   %esi
80101ff7:	89 c6                	mov    %eax,%esi
80101ff9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ffa:	bb d4 0f 11 80       	mov    $0x80110fd4,%ebx
{
80101fff:	83 ec 28             	sub    $0x28,%esp
80102002:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102005:	68 a0 0f 11 80       	push   $0x80110fa0
8010200a:	e8 91 32 00 00       	call   801052a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010200f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80102012:	83 c4 10             	add    $0x10,%esp
80102015:	eb 1b                	jmp    80102032 <iget+0x42>
80102017:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010201e:	00 
8010201f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102020:	39 33                	cmp    %esi,(%ebx)
80102022:	74 6c                	je     80102090 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102024:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010202a:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
80102030:	74 26                	je     80102058 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102032:	8b 43 08             	mov    0x8(%ebx),%eax
80102035:	85 c0                	test   %eax,%eax
80102037:	7f e7                	jg     80102020 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102039:	85 ff                	test   %edi,%edi
8010203b:	75 e7                	jne    80102024 <iget+0x34>
8010203d:	85 c0                	test   %eax,%eax
8010203f:	75 76                	jne    801020b7 <iget+0xc7>
      empty = ip;
80102041:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102043:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102049:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
8010204f:	75 e1                	jne    80102032 <iget+0x42>
80102051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102058:	85 ff                	test   %edi,%edi
8010205a:	74 79                	je     801020d5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010205c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010205f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80102061:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80102064:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010206b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80102072:	68 a0 0f 11 80       	push   $0x80110fa0
80102077:	e8 c4 31 00 00       	call   80105240 <release>

  return ip;
8010207c:	83 c4 10             	add    $0x10,%esp
}
8010207f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102082:	89 f8                	mov    %edi,%eax
80102084:	5b                   	pop    %ebx
80102085:	5e                   	pop    %esi
80102086:	5f                   	pop    %edi
80102087:	5d                   	pop    %ebp
80102088:	c3                   	ret
80102089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102090:	39 53 04             	cmp    %edx,0x4(%ebx)
80102093:	75 8f                	jne    80102024 <iget+0x34>
      ip->ref++;
80102095:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80102098:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010209b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010209d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801020a0:	68 a0 0f 11 80       	push   $0x80110fa0
801020a5:	e8 96 31 00 00       	call   80105240 <release>
      return ip;
801020aa:	83 c4 10             	add    $0x10,%esp
}
801020ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b0:	89 f8                	mov    %edi,%eax
801020b2:	5b                   	pop    %ebx
801020b3:	5e                   	pop    %esi
801020b4:	5f                   	pop    %edi
801020b5:	5d                   	pop    %ebp
801020b6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801020b7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801020bd:	81 fb f4 2b 11 80    	cmp    $0x80112bf4,%ebx
801020c3:	74 10                	je     801020d5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801020c5:	8b 43 08             	mov    0x8(%ebx),%eax
801020c8:	85 c0                	test   %eax,%eax
801020ca:	0f 8f 50 ff ff ff    	jg     80102020 <iget+0x30>
801020d0:	e9 68 ff ff ff       	jmp    8010203d <iget+0x4d>
    panic("iget: no inodes");
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	68 4c 81 10 80       	push   $0x8010814c
801020dd:	e8 2e e4 ff ff       	call   80100510 <panic>
801020e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020e9:	00 
801020ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801020f0 <bfree>:
{
801020f0:	55                   	push   %ebp
801020f1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801020f3:	89 d0                	mov    %edx,%eax
801020f5:	c1 e8 0c             	shr    $0xc,%eax
{
801020f8:	89 e5                	mov    %esp,%ebp
801020fa:	56                   	push   %esi
801020fb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801020fc:	03 05 0c 2c 11 80    	add    0x80112c0c,%eax
{
80102102:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80102104:	83 ec 08             	sub    $0x8,%esp
80102107:	50                   	push   %eax
80102108:	51                   	push   %ecx
80102109:	e8 c2 df ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010210e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80102110:	c1 fb 03             	sar    $0x3,%ebx
80102113:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80102116:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80102118:	83 e1 07             	and    $0x7,%ecx
8010211b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80102120:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80102126:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80102128:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010212d:	85 c1                	test   %eax,%ecx
8010212f:	74 23                	je     80102154 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80102131:	f7 d0                	not    %eax
  log_write(bp);
80102133:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102136:	21 c8                	and    %ecx,%eax
80102138:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010213c:	56                   	push   %esi
8010213d:	e8 de 1a 00 00       	call   80103c20 <log_write>
  brelse(bp);
80102142:	89 34 24             	mov    %esi,(%esp)
80102145:	e8 a6 e0 ff ff       	call   801001f0 <brelse>
}
8010214a:	83 c4 10             	add    $0x10,%esp
8010214d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102150:	5b                   	pop    %ebx
80102151:	5e                   	pop    %esi
80102152:	5d                   	pop    %ebp
80102153:	c3                   	ret
    panic("freeing free block");
80102154:	83 ec 0c             	sub    $0xc,%esp
80102157:	68 5c 81 10 80       	push   $0x8010815c
8010215c:	e8 af e3 ff ff       	call   80100510 <panic>
80102161:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102168:	00 
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	57                   	push   %edi
80102174:	56                   	push   %esi
80102175:	89 c6                	mov    %eax,%esi
80102177:	53                   	push   %ebx
80102178:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010217b:	83 fa 0b             	cmp    $0xb,%edx
8010217e:	0f 86 8c 00 00 00    	jbe    80102210 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102184:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102187:	83 fb 7f             	cmp    $0x7f,%ebx
8010218a:	0f 87 a2 00 00 00    	ja     80102232 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102190:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102196:	85 c0                	test   %eax,%eax
80102198:	74 5e                	je     801021f8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010219a:	83 ec 08             	sub    $0x8,%esp
8010219d:	50                   	push   %eax
8010219e:	ff 36                	push   (%esi)
801021a0:	e8 2b df ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801021a5:	83 c4 10             	add    $0x10,%esp
801021a8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801021ac:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801021ae:	8b 3b                	mov    (%ebx),%edi
801021b0:	85 ff                	test   %edi,%edi
801021b2:	74 1c                	je     801021d0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801021b4:	83 ec 0c             	sub    $0xc,%esp
801021b7:	52                   	push   %edx
801021b8:	e8 33 e0 ff ff       	call   801001f0 <brelse>
801021bd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801021c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021c3:	89 f8                	mov    %edi,%eax
801021c5:	5b                   	pop    %ebx
801021c6:	5e                   	pop    %esi
801021c7:	5f                   	pop    %edi
801021c8:	5d                   	pop    %ebp
801021c9:	c3                   	ret
801021ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801021d3:	8b 06                	mov    (%esi),%eax
801021d5:	e8 06 fd ff ff       	call   80101ee0 <balloc>
      log_write(bp);
801021da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021dd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801021e0:	89 03                	mov    %eax,(%ebx)
801021e2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801021e4:	52                   	push   %edx
801021e5:	e8 36 1a 00 00       	call   80103c20 <log_write>
801021ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801021ed:	83 c4 10             	add    $0x10,%esp
801021f0:	eb c2                	jmp    801021b4 <bmap+0x44>
801021f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801021f8:	8b 06                	mov    (%esi),%eax
801021fa:	e8 e1 fc ff ff       	call   80101ee0 <balloc>
801021ff:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102205:	eb 93                	jmp    8010219a <bmap+0x2a>
80102207:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220e:	00 
8010220f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80102210:	8d 5a 14             	lea    0x14(%edx),%ebx
80102213:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102217:	85 ff                	test   %edi,%edi
80102219:	75 a5                	jne    801021c0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010221b:	8b 00                	mov    (%eax),%eax
8010221d:	e8 be fc ff ff       	call   80101ee0 <balloc>
80102222:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102226:	89 c7                	mov    %eax,%edi
}
80102228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222b:	5b                   	pop    %ebx
8010222c:	89 f8                	mov    %edi,%eax
8010222e:	5e                   	pop    %esi
8010222f:	5f                   	pop    %edi
80102230:	5d                   	pop    %ebp
80102231:	c3                   	ret
  panic("bmap: out of range");
80102232:	83 ec 0c             	sub    $0xc,%esp
80102235:	68 6f 81 10 80       	push   $0x8010816f
8010223a:	e8 d1 e2 ff ff       	call   80100510 <panic>
8010223f:	90                   	nop

80102240 <readsb>:
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	56                   	push   %esi
80102244:	53                   	push   %ebx
80102245:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102248:	83 ec 08             	sub    $0x8,%esp
8010224b:	6a 01                	push   $0x1
8010224d:	ff 75 08             	push   0x8(%ebp)
80102250:	e8 7b de ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102255:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102258:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010225a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010225d:	6a 1c                	push   $0x1c
8010225f:	50                   	push   %eax
80102260:	56                   	push   %esi
80102261:	e8 ca 31 00 00       	call   80105430 <memmove>
  brelse(bp);
80102266:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102269:	83 c4 10             	add    $0x10,%esp
}
8010226c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010226f:	5b                   	pop    %ebx
80102270:	5e                   	pop    %esi
80102271:	5d                   	pop    %ebp
  brelse(bp);
80102272:	e9 79 df ff ff       	jmp    801001f0 <brelse>
80102277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010227e:	00 
8010227f:	90                   	nop

80102280 <iinit>:
{
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	53                   	push   %ebx
80102284:	bb e0 0f 11 80       	mov    $0x80110fe0,%ebx
80102289:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010228c:	68 82 81 10 80       	push   $0x80108182
80102291:	68 a0 0f 11 80       	push   $0x80110fa0
80102296:	e8 15 2e 00 00       	call   801050b0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010229b:	83 c4 10             	add    $0x10,%esp
8010229e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801022a0:	83 ec 08             	sub    $0x8,%esp
801022a3:	68 89 81 10 80       	push   $0x80108189
801022a8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801022a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801022af:	e8 cc 2c 00 00       	call   80104f80 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801022b4:	83 c4 10             	add    $0x10,%esp
801022b7:	81 fb 00 2c 11 80    	cmp    $0x80112c00,%ebx
801022bd:	75 e1                	jne    801022a0 <iinit+0x20>
  bp = bread(dev, 1);
801022bf:	83 ec 08             	sub    $0x8,%esp
801022c2:	6a 01                	push   $0x1
801022c4:	ff 75 08             	push   0x8(%ebp)
801022c7:	e8 04 de ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801022cc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801022cf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801022d1:	8d 40 5c             	lea    0x5c(%eax),%eax
801022d4:	6a 1c                	push   $0x1c
801022d6:	50                   	push   %eax
801022d7:	68 f4 2b 11 80       	push   $0x80112bf4
801022dc:	e8 4f 31 00 00       	call   80105430 <memmove>
  brelse(bp);
801022e1:	89 1c 24             	mov    %ebx,(%esp)
801022e4:	e8 07 df ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801022e9:	ff 35 0c 2c 11 80    	push   0x80112c0c
801022ef:	ff 35 08 2c 11 80    	push   0x80112c08
801022f5:	ff 35 04 2c 11 80    	push   0x80112c04
801022fb:	ff 35 00 2c 11 80    	push   0x80112c00
80102301:	ff 35 fc 2b 11 80    	push   0x80112bfc
80102307:	ff 35 f8 2b 11 80    	push   0x80112bf8
8010230d:	ff 35 f4 2b 11 80    	push   0x80112bf4
80102313:	68 10 86 10 80       	push   $0x80108610
80102318:	e8 73 e7 ff ff       	call   80100a90 <cprintf>
}
8010231d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102320:	83 c4 30             	add    $0x30,%esp
80102323:	c9                   	leave
80102324:	c3                   	ret
80102325:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010232c:	00 
8010232d:	8d 76 00             	lea    0x0(%esi),%esi

80102330 <ialloc>:
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 1c             	sub    $0x1c,%esp
80102339:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010233c:	83 3d fc 2b 11 80 01 	cmpl   $0x1,0x80112bfc
{
80102343:	8b 75 08             	mov    0x8(%ebp),%esi
80102346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102349:	0f 86 91 00 00 00    	jbe    801023e0 <ialloc+0xb0>
8010234f:	bf 01 00 00 00       	mov    $0x1,%edi
80102354:	eb 21                	jmp    80102377 <ialloc+0x47>
80102356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010235d:	00 
8010235e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102360:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102363:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102366:	53                   	push   %ebx
80102367:	e8 84 de ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010236c:	83 c4 10             	add    $0x10,%esp
8010236f:	3b 3d fc 2b 11 80    	cmp    0x80112bfc,%edi
80102375:	73 69                	jae    801023e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102377:	89 f8                	mov    %edi,%eax
80102379:	83 ec 08             	sub    $0x8,%esp
8010237c:	c1 e8 03             	shr    $0x3,%eax
8010237f:	03 05 08 2c 11 80    	add    0x80112c08,%eax
80102385:	50                   	push   %eax
80102386:	56                   	push   %esi
80102387:	e8 44 dd ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010238c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010238f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102391:	89 f8                	mov    %edi,%eax
80102393:	83 e0 07             	and    $0x7,%eax
80102396:	c1 e0 06             	shl    $0x6,%eax
80102399:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010239d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801023a1:	75 bd                	jne    80102360 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801023a3:	83 ec 04             	sub    $0x4,%esp
801023a6:	6a 40                	push   $0x40
801023a8:	6a 00                	push   $0x0
801023aa:	51                   	push   %ecx
801023ab:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801023ae:	e8 ed 2f 00 00       	call   801053a0 <memset>
      dip->type = type;
801023b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801023b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801023ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801023bd:	89 1c 24             	mov    %ebx,(%esp)
801023c0:	e8 5b 18 00 00       	call   80103c20 <log_write>
      brelse(bp);
801023c5:	89 1c 24             	mov    %ebx,(%esp)
801023c8:	e8 23 de ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801023cd:	83 c4 10             	add    $0x10,%esp
}
801023d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801023d3:	89 fa                	mov    %edi,%edx
}
801023d5:	5b                   	pop    %ebx
      return iget(dev, inum);
801023d6:	89 f0                	mov    %esi,%eax
}
801023d8:	5e                   	pop    %esi
801023d9:	5f                   	pop    %edi
801023da:	5d                   	pop    %ebp
      return iget(dev, inum);
801023db:	e9 10 fc ff ff       	jmp    80101ff0 <iget>
  panic("ialloc: no inodes");
801023e0:	83 ec 0c             	sub    $0xc,%esp
801023e3:	68 8f 81 10 80       	push   $0x8010818f
801023e8:	e8 23 e1 ff ff       	call   80100510 <panic>
801023ed:	8d 76 00             	lea    0x0(%esi),%esi

801023f0 <iupdate>:
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801023f8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801023fb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801023fe:	83 ec 08             	sub    $0x8,%esp
80102401:	c1 e8 03             	shr    $0x3,%eax
80102404:	03 05 08 2c 11 80    	add    0x80112c08,%eax
8010240a:	50                   	push   %eax
8010240b:	ff 73 a4             	push   -0x5c(%ebx)
8010240e:	e8 bd dc ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102413:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102417:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010241a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010241c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010241f:	83 e0 07             	and    $0x7,%eax
80102422:	c1 e0 06             	shl    $0x6,%eax
80102425:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102429:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010242c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102430:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102433:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102437:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010243b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010243f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102443:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102447:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010244a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010244d:	6a 34                	push   $0x34
8010244f:	53                   	push   %ebx
80102450:	50                   	push   %eax
80102451:	e8 da 2f 00 00       	call   80105430 <memmove>
  log_write(bp);
80102456:	89 34 24             	mov    %esi,(%esp)
80102459:	e8 c2 17 00 00       	call   80103c20 <log_write>
  brelse(bp);
8010245e:	89 75 08             	mov    %esi,0x8(%ebp)
80102461:	83 c4 10             	add    $0x10,%esp
}
80102464:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102467:	5b                   	pop    %ebx
80102468:	5e                   	pop    %esi
80102469:	5d                   	pop    %ebp
  brelse(bp);
8010246a:	e9 81 dd ff ff       	jmp    801001f0 <brelse>
8010246f:	90                   	nop

80102470 <idup>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	53                   	push   %ebx
80102474:	83 ec 10             	sub    $0x10,%esp
80102477:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010247a:	68 a0 0f 11 80       	push   $0x80110fa0
8010247f:	e8 1c 2e 00 00       	call   801052a0 <acquire>
  ip->ref++;
80102484:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102488:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
8010248f:	e8 ac 2d 00 00       	call   80105240 <release>
}
80102494:	89 d8                	mov    %ebx,%eax
80102496:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102499:	c9                   	leave
8010249a:	c3                   	ret
8010249b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801024a0 <ilock>:
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801024a8:	85 db                	test   %ebx,%ebx
801024aa:	0f 84 b7 00 00 00    	je     80102567 <ilock+0xc7>
801024b0:	8b 53 08             	mov    0x8(%ebx),%edx
801024b3:	85 d2                	test   %edx,%edx
801024b5:	0f 8e ac 00 00 00    	jle    80102567 <ilock+0xc7>
  acquiresleep(&ip->lock);
801024bb:	83 ec 0c             	sub    $0xc,%esp
801024be:	8d 43 0c             	lea    0xc(%ebx),%eax
801024c1:	50                   	push   %eax
801024c2:	e8 f9 2a 00 00       	call   80104fc0 <acquiresleep>
  if(ip->valid == 0){
801024c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801024ca:	83 c4 10             	add    $0x10,%esp
801024cd:	85 c0                	test   %eax,%eax
801024cf:	74 0f                	je     801024e0 <ilock+0x40>
}
801024d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d4:	5b                   	pop    %ebx
801024d5:	5e                   	pop    %esi
801024d6:	5d                   	pop    %ebp
801024d7:	c3                   	ret
801024d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024df:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024e0:	8b 43 04             	mov    0x4(%ebx),%eax
801024e3:	83 ec 08             	sub    $0x8,%esp
801024e6:	c1 e8 03             	shr    $0x3,%eax
801024e9:	03 05 08 2c 11 80    	add    0x80112c08,%eax
801024ef:	50                   	push   %eax
801024f0:	ff 33                	push   (%ebx)
801024f2:	e8 d9 db ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801024f7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024fa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801024fc:	8b 43 04             	mov    0x4(%ebx),%eax
801024ff:	83 e0 07             	and    $0x7,%eax
80102502:	c1 e0 06             	shl    $0x6,%eax
80102505:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102509:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010250c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010250f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102513:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102517:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010251b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010251f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102523:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102527:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010252b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010252e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102531:	6a 34                	push   $0x34
80102533:	50                   	push   %eax
80102534:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102537:	50                   	push   %eax
80102538:	e8 f3 2e 00 00       	call   80105430 <memmove>
    brelse(bp);
8010253d:	89 34 24             	mov    %esi,(%esp)
80102540:	e8 ab dc ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102545:	83 c4 10             	add    $0x10,%esp
80102548:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010254d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102554:	0f 85 77 ff ff ff    	jne    801024d1 <ilock+0x31>
      panic("ilock: no type");
8010255a:	83 ec 0c             	sub    $0xc,%esp
8010255d:	68 a7 81 10 80       	push   $0x801081a7
80102562:	e8 a9 df ff ff       	call   80100510 <panic>
    panic("ilock");
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 a1 81 10 80       	push   $0x801081a1
8010256f:	e8 9c df ff ff       	call   80100510 <panic>
80102574:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010257b:	00 
8010257c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102580 <iunlock>:
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
80102585:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102588:	85 db                	test   %ebx,%ebx
8010258a:	74 28                	je     801025b4 <iunlock+0x34>
8010258c:	83 ec 0c             	sub    $0xc,%esp
8010258f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102592:	56                   	push   %esi
80102593:	e8 c8 2a 00 00       	call   80105060 <holdingsleep>
80102598:	83 c4 10             	add    $0x10,%esp
8010259b:	85 c0                	test   %eax,%eax
8010259d:	74 15                	je     801025b4 <iunlock+0x34>
8010259f:	8b 43 08             	mov    0x8(%ebx),%eax
801025a2:	85 c0                	test   %eax,%eax
801025a4:	7e 0e                	jle    801025b4 <iunlock+0x34>
  releasesleep(&ip->lock);
801025a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801025a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025ac:	5b                   	pop    %ebx
801025ad:	5e                   	pop    %esi
801025ae:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801025af:	e9 6c 2a 00 00       	jmp    80105020 <releasesleep>
    panic("iunlock");
801025b4:	83 ec 0c             	sub    $0xc,%esp
801025b7:	68 b6 81 10 80       	push   $0x801081b6
801025bc:	e8 4f df ff ff       	call   80100510 <panic>
801025c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025c8:	00 
801025c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801025d0 <iput>:
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	57                   	push   %edi
801025d4:	56                   	push   %esi
801025d5:	53                   	push   %ebx
801025d6:	83 ec 28             	sub    $0x28,%esp
801025d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801025dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801025df:	57                   	push   %edi
801025e0:	e8 db 29 00 00       	call   80104fc0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801025e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801025e8:	83 c4 10             	add    $0x10,%esp
801025eb:	85 d2                	test   %edx,%edx
801025ed:	74 07                	je     801025f6 <iput+0x26>
801025ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801025f4:	74 32                	je     80102628 <iput+0x58>
  releasesleep(&ip->lock);
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	57                   	push   %edi
801025fa:	e8 21 2a 00 00       	call   80105020 <releasesleep>
  acquire(&icache.lock);
801025ff:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
80102606:	e8 95 2c 00 00       	call   801052a0 <acquire>
  ip->ref--;
8010260b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010260f:	83 c4 10             	add    $0x10,%esp
80102612:	c7 45 08 a0 0f 11 80 	movl   $0x80110fa0,0x8(%ebp)
}
80102619:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010261c:	5b                   	pop    %ebx
8010261d:	5e                   	pop    %esi
8010261e:	5f                   	pop    %edi
8010261f:	5d                   	pop    %ebp
  release(&icache.lock);
80102620:	e9 1b 2c 00 00       	jmp    80105240 <release>
80102625:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102628:	83 ec 0c             	sub    $0xc,%esp
8010262b:	68 a0 0f 11 80       	push   $0x80110fa0
80102630:	e8 6b 2c 00 00       	call   801052a0 <acquire>
    int r = ip->ref;
80102635:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102638:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
8010263f:	e8 fc 2b 00 00       	call   80105240 <release>
    if(r == 1){
80102644:	83 c4 10             	add    $0x10,%esp
80102647:	83 fe 01             	cmp    $0x1,%esi
8010264a:	75 aa                	jne    801025f6 <iput+0x26>
8010264c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102652:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102655:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102658:	89 df                	mov    %ebx,%edi
8010265a:	89 cb                	mov    %ecx,%ebx
8010265c:	eb 09                	jmp    80102667 <iput+0x97>
8010265e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102660:	83 c6 04             	add    $0x4,%esi
80102663:	39 de                	cmp    %ebx,%esi
80102665:	74 19                	je     80102680 <iput+0xb0>
    if(ip->addrs[i]){
80102667:	8b 16                	mov    (%esi),%edx
80102669:	85 d2                	test   %edx,%edx
8010266b:	74 f3                	je     80102660 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010266d:	8b 07                	mov    (%edi),%eax
8010266f:	e8 7c fa ff ff       	call   801020f0 <bfree>
      ip->addrs[i] = 0;
80102674:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010267a:	eb e4                	jmp    80102660 <iput+0x90>
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102680:	89 fb                	mov    %edi,%ebx
80102682:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102685:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010268b:	85 c0                	test   %eax,%eax
8010268d:	75 2d                	jne    801026bc <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010268f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102692:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102699:	53                   	push   %ebx
8010269a:	e8 51 fd ff ff       	call   801023f0 <iupdate>
      ip->type = 0;
8010269f:	31 c0                	xor    %eax,%eax
801026a1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801026a5:	89 1c 24             	mov    %ebx,(%esp)
801026a8:	e8 43 fd ff ff       	call   801023f0 <iupdate>
      ip->valid = 0;
801026ad:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801026b4:	83 c4 10             	add    $0x10,%esp
801026b7:	e9 3a ff ff ff       	jmp    801025f6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801026bc:	83 ec 08             	sub    $0x8,%esp
801026bf:	50                   	push   %eax
801026c0:	ff 33                	push   (%ebx)
801026c2:	e8 09 da ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801026c7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801026ca:	83 c4 10             	add    $0x10,%esp
801026cd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801026d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801026d6:	8d 70 5c             	lea    0x5c(%eax),%esi
801026d9:	89 cf                	mov    %ecx,%edi
801026db:	eb 0a                	jmp    801026e7 <iput+0x117>
801026dd:	8d 76 00             	lea    0x0(%esi),%esi
801026e0:	83 c6 04             	add    $0x4,%esi
801026e3:	39 fe                	cmp    %edi,%esi
801026e5:	74 0f                	je     801026f6 <iput+0x126>
      if(a[j])
801026e7:	8b 16                	mov    (%esi),%edx
801026e9:	85 d2                	test   %edx,%edx
801026eb:	74 f3                	je     801026e0 <iput+0x110>
        bfree(ip->dev, a[j]);
801026ed:	8b 03                	mov    (%ebx),%eax
801026ef:	e8 fc f9 ff ff       	call   801020f0 <bfree>
801026f4:	eb ea                	jmp    801026e0 <iput+0x110>
    brelse(bp);
801026f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801026f9:	83 ec 0c             	sub    $0xc,%esp
801026fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801026ff:	50                   	push   %eax
80102700:	e8 eb da ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102705:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010270b:	8b 03                	mov    (%ebx),%eax
8010270d:	e8 de f9 ff ff       	call   801020f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102712:	83 c4 10             	add    $0x10,%esp
80102715:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010271c:	00 00 00 
8010271f:	e9 6b ff ff ff       	jmp    8010268f <iput+0xbf>
80102724:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010272b:	00 
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <iunlockput>:
{
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
80102735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102738:	85 db                	test   %ebx,%ebx
8010273a:	74 34                	je     80102770 <iunlockput+0x40>
8010273c:	83 ec 0c             	sub    $0xc,%esp
8010273f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102742:	56                   	push   %esi
80102743:	e8 18 29 00 00       	call   80105060 <holdingsleep>
80102748:	83 c4 10             	add    $0x10,%esp
8010274b:	85 c0                	test   %eax,%eax
8010274d:	74 21                	je     80102770 <iunlockput+0x40>
8010274f:	8b 43 08             	mov    0x8(%ebx),%eax
80102752:	85 c0                	test   %eax,%eax
80102754:	7e 1a                	jle    80102770 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102756:	83 ec 0c             	sub    $0xc,%esp
80102759:	56                   	push   %esi
8010275a:	e8 c1 28 00 00       	call   80105020 <releasesleep>
  iput(ip);
8010275f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102762:	83 c4 10             	add    $0x10,%esp
}
80102765:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102768:	5b                   	pop    %ebx
80102769:	5e                   	pop    %esi
8010276a:	5d                   	pop    %ebp
  iput(ip);
8010276b:	e9 60 fe ff ff       	jmp    801025d0 <iput>
    panic("iunlock");
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	68 b6 81 10 80       	push   $0x801081b6
80102778:	e8 93 dd ff ff       	call   80100510 <panic>
8010277d:	8d 76 00             	lea    0x0(%esi),%esi

80102780 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	8b 55 08             	mov    0x8(%ebp),%edx
80102786:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102789:	8b 0a                	mov    (%edx),%ecx
8010278b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010278e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102791:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102794:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102798:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010279b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010279f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801027a3:	8b 52 58             	mov    0x58(%edx),%edx
801027a6:	89 50 10             	mov    %edx,0x10(%eax)
}
801027a9:	5d                   	pop    %ebp
801027aa:	c3                   	ret
801027ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801027b0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	57                   	push   %edi
801027b4:	56                   	push   %esi
801027b5:	53                   	push   %ebx
801027b6:	83 ec 1c             	sub    $0x1c,%esp
801027b9:	8b 75 08             	mov    0x8(%ebp),%esi
801027bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801027bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801027c2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
801027c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801027ca:	89 75 d8             	mov    %esi,-0x28(%ebp)
801027cd:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
801027d0:	0f 84 aa 00 00 00    	je     80102880 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801027d6:	8b 75 d8             	mov    -0x28(%ebp),%esi
801027d9:	8b 56 58             	mov    0x58(%esi),%edx
801027dc:	39 fa                	cmp    %edi,%edx
801027de:	0f 82 bd 00 00 00    	jb     801028a1 <readi+0xf1>
801027e4:	89 f9                	mov    %edi,%ecx
801027e6:	31 db                	xor    %ebx,%ebx
801027e8:	01 c1                	add    %eax,%ecx
801027ea:	0f 92 c3             	setb   %bl
801027ed:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801027f0:	0f 82 ab 00 00 00    	jb     801028a1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801027f6:	89 d3                	mov    %edx,%ebx
801027f8:	29 fb                	sub    %edi,%ebx
801027fa:	39 ca                	cmp    %ecx,%edx
801027fc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801027ff:	85 c0                	test   %eax,%eax
80102801:	74 73                	je     80102876 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102803:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102806:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102810:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102813:	89 fa                	mov    %edi,%edx
80102815:	c1 ea 09             	shr    $0x9,%edx
80102818:	89 d8                	mov    %ebx,%eax
8010281a:	e8 51 f9 ff ff       	call   80102170 <bmap>
8010281f:	83 ec 08             	sub    $0x8,%esp
80102822:	50                   	push   %eax
80102823:	ff 33                	push   (%ebx)
80102825:	e8 a6 d8 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010282a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010282d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102832:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102834:	89 f8                	mov    %edi,%eax
80102836:	25 ff 01 00 00       	and    $0x1ff,%eax
8010283b:	29 f3                	sub    %esi,%ebx
8010283d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
8010283f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102843:	39 d9                	cmp    %ebx,%ecx
80102845:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102848:	83 c4 0c             	add    $0xc,%esp
8010284b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010284c:	01 de                	add    %ebx,%esi
8010284e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80102850:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102853:	50                   	push   %eax
80102854:	ff 75 e0             	push   -0x20(%ebp)
80102857:	e8 d4 2b 00 00       	call   80105430 <memmove>
    brelse(bp);
8010285c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010285f:	89 14 24             	mov    %edx,(%esp)
80102862:	e8 89 d9 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102867:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010286a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010286d:	83 c4 10             	add    $0x10,%esp
80102870:	39 de                	cmp    %ebx,%esi
80102872:	72 9c                	jb     80102810 <readi+0x60>
80102874:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80102876:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102879:	5b                   	pop    %ebx
8010287a:	5e                   	pop    %esi
8010287b:	5f                   	pop    %edi
8010287c:	5d                   	pop    %ebp
8010287d:	c3                   	ret
8010287e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102880:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102884:	66 83 fa 09          	cmp    $0x9,%dx
80102888:	77 17                	ja     801028a1 <readi+0xf1>
8010288a:	8b 14 d5 40 0f 11 80 	mov    -0x7feef0c0(,%edx,8),%edx
80102891:	85 d2                	test   %edx,%edx
80102893:	74 0c                	je     801028a1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102895:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010289b:	5b                   	pop    %ebx
8010289c:	5e                   	pop    %esi
8010289d:	5f                   	pop    %edi
8010289e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010289f:	ff e2                	jmp    *%edx
      return -1;
801028a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028a6:	eb ce                	jmp    80102876 <readi+0xc6>
801028a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028af:	00 

801028b0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	57                   	push   %edi
801028b4:	56                   	push   %esi
801028b5:	53                   	push   %ebx
801028b6:	83 ec 1c             	sub    $0x1c,%esp
801028b9:	8b 45 08             	mov    0x8(%ebp),%eax
801028bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801028bf:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801028c2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801028c7:	89 7d dc             	mov    %edi,-0x24(%ebp)
801028ca:	89 75 e0             	mov    %esi,-0x20(%ebp)
801028cd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
801028d0:	0f 84 ba 00 00 00    	je     80102990 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801028d6:	39 78 58             	cmp    %edi,0x58(%eax)
801028d9:	0f 82 ea 00 00 00    	jb     801029c9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801028df:	8b 75 e0             	mov    -0x20(%ebp),%esi
801028e2:	89 f2                	mov    %esi,%edx
801028e4:	01 fa                	add    %edi,%edx
801028e6:	0f 82 dd 00 00 00    	jb     801029c9 <writei+0x119>
801028ec:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
801028f2:	0f 87 d1 00 00 00    	ja     801029c9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801028f8:	85 f6                	test   %esi,%esi
801028fa:	0f 84 85 00 00 00    	je     80102985 <writei+0xd5>
80102900:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102907:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102910:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102913:	89 fa                	mov    %edi,%edx
80102915:	c1 ea 09             	shr    $0x9,%edx
80102918:	89 f0                	mov    %esi,%eax
8010291a:	e8 51 f8 ff ff       	call   80102170 <bmap>
8010291f:	83 ec 08             	sub    $0x8,%esp
80102922:	50                   	push   %eax
80102923:	ff 36                	push   (%esi)
80102925:	e8 a6 d7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010292a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010292d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102930:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102935:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102937:	89 f8                	mov    %edi,%eax
80102939:	25 ff 01 00 00       	and    $0x1ff,%eax
8010293e:	29 d3                	sub    %edx,%ebx
80102940:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102942:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102946:	39 d9                	cmp    %ebx,%ecx
80102948:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010294b:	83 c4 0c             	add    $0xc,%esp
8010294e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010294f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80102951:	ff 75 dc             	push   -0x24(%ebp)
80102954:	50                   	push   %eax
80102955:	e8 d6 2a 00 00       	call   80105430 <memmove>
    log_write(bp);
8010295a:	89 34 24             	mov    %esi,(%esp)
8010295d:	e8 be 12 00 00       	call   80103c20 <log_write>
    brelse(bp);
80102962:	89 34 24             	mov    %esi,(%esp)
80102965:	e8 86 d8 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010296a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010296d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102970:	83 c4 10             	add    $0x10,%esp
80102973:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102976:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102979:	39 d8                	cmp    %ebx,%eax
8010297b:	72 93                	jb     80102910 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
8010297d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102980:	39 78 58             	cmp    %edi,0x58(%eax)
80102983:	72 33                	jb     801029b8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102985:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102988:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010298b:	5b                   	pop    %ebx
8010298c:	5e                   	pop    %esi
8010298d:	5f                   	pop    %edi
8010298e:	5d                   	pop    %ebp
8010298f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102990:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102994:	66 83 f8 09          	cmp    $0x9,%ax
80102998:	77 2f                	ja     801029c9 <writei+0x119>
8010299a:	8b 04 c5 44 0f 11 80 	mov    -0x7feef0bc(,%eax,8),%eax
801029a1:	85 c0                	test   %eax,%eax
801029a3:	74 24                	je     801029c9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
801029a5:	89 75 10             	mov    %esi,0x10(%ebp)
}
801029a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029ab:	5b                   	pop    %ebx
801029ac:	5e                   	pop    %esi
801029ad:	5f                   	pop    %edi
801029ae:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801029af:	ff e0                	jmp    *%eax
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
801029b8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801029bb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
801029be:	50                   	push   %eax
801029bf:	e8 2c fa ff ff       	call   801023f0 <iupdate>
801029c4:	83 c4 10             	add    $0x10,%esp
801029c7:	eb bc                	jmp    80102985 <writei+0xd5>
      return -1;
801029c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801029ce:	eb b8                	jmp    80102988 <writei+0xd8>

801029d0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801029d6:	6a 0e                	push   $0xe
801029d8:	ff 75 0c             	push   0xc(%ebp)
801029db:	ff 75 08             	push   0x8(%ebp)
801029de:	e8 bd 2a 00 00       	call   801054a0 <strncmp>
}
801029e3:	c9                   	leave
801029e4:	c3                   	ret
801029e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ec:	00 
801029ed:	8d 76 00             	lea    0x0(%esi),%esi

801029f0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	57                   	push   %edi
801029f4:	56                   	push   %esi
801029f5:	53                   	push   %ebx
801029f6:	83 ec 1c             	sub    $0x1c,%esp
801029f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801029fc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102a01:	0f 85 85 00 00 00    	jne    80102a8c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102a07:	8b 53 58             	mov    0x58(%ebx),%edx
80102a0a:	31 ff                	xor    %edi,%edi
80102a0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102a0f:	85 d2                	test   %edx,%edx
80102a11:	74 3e                	je     80102a51 <dirlookup+0x61>
80102a13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a18:	6a 10                	push   $0x10
80102a1a:	57                   	push   %edi
80102a1b:	56                   	push   %esi
80102a1c:	53                   	push   %ebx
80102a1d:	e8 8e fd ff ff       	call   801027b0 <readi>
80102a22:	83 c4 10             	add    $0x10,%esp
80102a25:	83 f8 10             	cmp    $0x10,%eax
80102a28:	75 55                	jne    80102a7f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102a2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102a2f:	74 18                	je     80102a49 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102a31:	83 ec 04             	sub    $0x4,%esp
80102a34:	8d 45 da             	lea    -0x26(%ebp),%eax
80102a37:	6a 0e                	push   $0xe
80102a39:	50                   	push   %eax
80102a3a:	ff 75 0c             	push   0xc(%ebp)
80102a3d:	e8 5e 2a 00 00       	call   801054a0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102a42:	83 c4 10             	add    $0x10,%esp
80102a45:	85 c0                	test   %eax,%eax
80102a47:	74 17                	je     80102a60 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102a49:	83 c7 10             	add    $0x10,%edi
80102a4c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102a4f:	72 c7                	jb     80102a18 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102a54:	31 c0                	xor    %eax,%eax
}
80102a56:	5b                   	pop    %ebx
80102a57:	5e                   	pop    %esi
80102a58:	5f                   	pop    %edi
80102a59:	5d                   	pop    %ebp
80102a5a:	c3                   	ret
80102a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102a60:	8b 45 10             	mov    0x10(%ebp),%eax
80102a63:	85 c0                	test   %eax,%eax
80102a65:	74 05                	je     80102a6c <dirlookup+0x7c>
        *poff = off;
80102a67:	8b 45 10             	mov    0x10(%ebp),%eax
80102a6a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102a6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102a70:	8b 03                	mov    (%ebx),%eax
80102a72:	e8 79 f5 ff ff       	call   80101ff0 <iget>
}
80102a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a7a:	5b                   	pop    %ebx
80102a7b:	5e                   	pop    %esi
80102a7c:	5f                   	pop    %edi
80102a7d:	5d                   	pop    %ebp
80102a7e:	c3                   	ret
      panic("dirlookup read");
80102a7f:	83 ec 0c             	sub    $0xc,%esp
80102a82:	68 d0 81 10 80       	push   $0x801081d0
80102a87:	e8 84 da ff ff       	call   80100510 <panic>
    panic("dirlookup not DIR");
80102a8c:	83 ec 0c             	sub    $0xc,%esp
80102a8f:	68 be 81 10 80       	push   $0x801081be
80102a94:	e8 77 da ff ff       	call   80100510 <panic>
80102a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102aa0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	57                   	push   %edi
80102aa4:	56                   	push   %esi
80102aa5:	53                   	push   %ebx
80102aa6:	89 c3                	mov    %eax,%ebx
80102aa8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102aab:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102aae:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102ab1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102ab4:	0f 84 9e 01 00 00    	je     80102c58 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102aba:	e8 a1 1b 00 00       	call   80104660 <myproc>
  acquire(&icache.lock);
80102abf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102ac2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102ac5:	68 a0 0f 11 80       	push   $0x80110fa0
80102aca:	e8 d1 27 00 00       	call   801052a0 <acquire>
  ip->ref++;
80102acf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102ad3:	c7 04 24 a0 0f 11 80 	movl   $0x80110fa0,(%esp)
80102ada:	e8 61 27 00 00       	call   80105240 <release>
80102adf:	83 c4 10             	add    $0x10,%esp
80102ae2:	eb 07                	jmp    80102aeb <namex+0x4b>
80102ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102ae8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102aeb:	0f b6 03             	movzbl (%ebx),%eax
80102aee:	3c 2f                	cmp    $0x2f,%al
80102af0:	74 f6                	je     80102ae8 <namex+0x48>
  if(*path == 0)
80102af2:	84 c0                	test   %al,%al
80102af4:	0f 84 06 01 00 00    	je     80102c00 <namex+0x160>
  while(*path != '/' && *path != 0)
80102afa:	0f b6 03             	movzbl (%ebx),%eax
80102afd:	84 c0                	test   %al,%al
80102aff:	0f 84 10 01 00 00    	je     80102c15 <namex+0x175>
80102b05:	89 df                	mov    %ebx,%edi
80102b07:	3c 2f                	cmp    $0x2f,%al
80102b09:	0f 84 06 01 00 00    	je     80102c15 <namex+0x175>
80102b0f:	90                   	nop
80102b10:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102b14:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102b17:	3c 2f                	cmp    $0x2f,%al
80102b19:	74 04                	je     80102b1f <namex+0x7f>
80102b1b:	84 c0                	test   %al,%al
80102b1d:	75 f1                	jne    80102b10 <namex+0x70>
  len = path - s;
80102b1f:	89 f8                	mov    %edi,%eax
80102b21:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102b23:	83 f8 0d             	cmp    $0xd,%eax
80102b26:	0f 8e ac 00 00 00    	jle    80102bd8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102b2c:	83 ec 04             	sub    $0x4,%esp
80102b2f:	6a 0e                	push   $0xe
80102b31:	53                   	push   %ebx
80102b32:	89 fb                	mov    %edi,%ebx
80102b34:	ff 75 e4             	push   -0x1c(%ebp)
80102b37:	e8 f4 28 00 00       	call   80105430 <memmove>
80102b3c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102b3f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102b42:	75 0c                	jne    80102b50 <namex+0xb0>
80102b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102b48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102b4b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102b4e:	74 f8                	je     80102b48 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102b50:	83 ec 0c             	sub    $0xc,%esp
80102b53:	56                   	push   %esi
80102b54:	e8 47 f9 ff ff       	call   801024a0 <ilock>
    if(ip->type != T_DIR){
80102b59:	83 c4 10             	add    $0x10,%esp
80102b5c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102b61:	0f 85 b7 00 00 00    	jne    80102c1e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102b67:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102b6a:	85 c0                	test   %eax,%eax
80102b6c:	74 09                	je     80102b77 <namex+0xd7>
80102b6e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102b71:	0f 84 f7 00 00 00    	je     80102c6e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102b77:	83 ec 04             	sub    $0x4,%esp
80102b7a:	6a 00                	push   $0x0
80102b7c:	ff 75 e4             	push   -0x1c(%ebp)
80102b7f:	56                   	push   %esi
80102b80:	e8 6b fe ff ff       	call   801029f0 <dirlookup>
80102b85:	83 c4 10             	add    $0x10,%esp
80102b88:	89 c7                	mov    %eax,%edi
80102b8a:	85 c0                	test   %eax,%eax
80102b8c:	0f 84 8c 00 00 00    	je     80102c1e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b92:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102b95:	83 ec 0c             	sub    $0xc,%esp
80102b98:	51                   	push   %ecx
80102b99:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102b9c:	e8 bf 24 00 00       	call   80105060 <holdingsleep>
80102ba1:	83 c4 10             	add    $0x10,%esp
80102ba4:	85 c0                	test   %eax,%eax
80102ba6:	0f 84 02 01 00 00    	je     80102cae <namex+0x20e>
80102bac:	8b 56 08             	mov    0x8(%esi),%edx
80102baf:	85 d2                	test   %edx,%edx
80102bb1:	0f 8e f7 00 00 00    	jle    80102cae <namex+0x20e>
  releasesleep(&ip->lock);
80102bb7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102bba:	83 ec 0c             	sub    $0xc,%esp
80102bbd:	51                   	push   %ecx
80102bbe:	e8 5d 24 00 00       	call   80105020 <releasesleep>
  iput(ip);
80102bc3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102bc6:	89 fe                	mov    %edi,%esi
  iput(ip);
80102bc8:	e8 03 fa ff ff       	call   801025d0 <iput>
80102bcd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102bd0:	e9 16 ff ff ff       	jmp    80102aeb <namex+0x4b>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102bd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102bdb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102bde:	83 ec 04             	sub    $0x4,%esp
80102be1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102be4:	50                   	push   %eax
80102be5:	53                   	push   %ebx
    name[len] = 0;
80102be6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102be8:	ff 75 e4             	push   -0x1c(%ebp)
80102beb:	e8 40 28 00 00       	call   80105430 <memmove>
    name[len] = 0;
80102bf0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102bf3:	83 c4 10             	add    $0x10,%esp
80102bf6:	c6 01 00             	movb   $0x0,(%ecx)
80102bf9:	e9 41 ff ff ff       	jmp    80102b3f <namex+0x9f>
80102bfe:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102c00:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c03:	85 c0                	test   %eax,%eax
80102c05:	0f 85 93 00 00 00    	jne    80102c9e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80102c0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c0e:	89 f0                	mov    %esi,%eax
80102c10:	5b                   	pop    %ebx
80102c11:	5e                   	pop    %esi
80102c12:	5f                   	pop    %edi
80102c13:	5d                   	pop    %ebp
80102c14:	c3                   	ret
  while(*path != '/' && *path != 0)
80102c15:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102c18:	89 df                	mov    %ebx,%edi
80102c1a:	31 c0                	xor    %eax,%eax
80102c1c:	eb c0                	jmp    80102bde <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102c1e:	83 ec 0c             	sub    $0xc,%esp
80102c21:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c24:	53                   	push   %ebx
80102c25:	e8 36 24 00 00       	call   80105060 <holdingsleep>
80102c2a:	83 c4 10             	add    $0x10,%esp
80102c2d:	85 c0                	test   %eax,%eax
80102c2f:	74 7d                	je     80102cae <namex+0x20e>
80102c31:	8b 4e 08             	mov    0x8(%esi),%ecx
80102c34:	85 c9                	test   %ecx,%ecx
80102c36:	7e 76                	jle    80102cae <namex+0x20e>
  releasesleep(&ip->lock);
80102c38:	83 ec 0c             	sub    $0xc,%esp
80102c3b:	53                   	push   %ebx
80102c3c:	e8 df 23 00 00       	call   80105020 <releasesleep>
  iput(ip);
80102c41:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102c44:	31 f6                	xor    %esi,%esi
  iput(ip);
80102c46:	e8 85 f9 ff ff       	call   801025d0 <iput>
      return 0;
80102c4b:	83 c4 10             	add    $0x10,%esp
}
80102c4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c51:	89 f0                	mov    %esi,%eax
80102c53:	5b                   	pop    %ebx
80102c54:	5e                   	pop    %esi
80102c55:	5f                   	pop    %edi
80102c56:	5d                   	pop    %ebp
80102c57:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102c58:	ba 01 00 00 00       	mov    $0x1,%edx
80102c5d:	b8 01 00 00 00       	mov    $0x1,%eax
80102c62:	e8 89 f3 ff ff       	call   80101ff0 <iget>
80102c67:	89 c6                	mov    %eax,%esi
80102c69:	e9 7d fe ff ff       	jmp    80102aeb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102c6e:	83 ec 0c             	sub    $0xc,%esp
80102c71:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102c74:	53                   	push   %ebx
80102c75:	e8 e6 23 00 00       	call   80105060 <holdingsleep>
80102c7a:	83 c4 10             	add    $0x10,%esp
80102c7d:	85 c0                	test   %eax,%eax
80102c7f:	74 2d                	je     80102cae <namex+0x20e>
80102c81:	8b 7e 08             	mov    0x8(%esi),%edi
80102c84:	85 ff                	test   %edi,%edi
80102c86:	7e 26                	jle    80102cae <namex+0x20e>
  releasesleep(&ip->lock);
80102c88:	83 ec 0c             	sub    $0xc,%esp
80102c8b:	53                   	push   %ebx
80102c8c:	e8 8f 23 00 00       	call   80105020 <releasesleep>
}
80102c91:	83 c4 10             	add    $0x10,%esp
}
80102c94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c97:	89 f0                	mov    %esi,%eax
80102c99:	5b                   	pop    %ebx
80102c9a:	5e                   	pop    %esi
80102c9b:	5f                   	pop    %edi
80102c9c:	5d                   	pop    %ebp
80102c9d:	c3                   	ret
    iput(ip);
80102c9e:	83 ec 0c             	sub    $0xc,%esp
80102ca1:	56                   	push   %esi
      return 0;
80102ca2:	31 f6                	xor    %esi,%esi
    iput(ip);
80102ca4:	e8 27 f9 ff ff       	call   801025d0 <iput>
    return 0;
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	eb a0                	jmp    80102c4e <namex+0x1ae>
    panic("iunlock");
80102cae:	83 ec 0c             	sub    $0xc,%esp
80102cb1:	68 b6 81 10 80       	push   $0x801081b6
80102cb6:	e8 55 d8 ff ff       	call   80100510 <panic>
80102cbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102cc0 <dirlink>:
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	57                   	push   %edi
80102cc4:	56                   	push   %esi
80102cc5:	53                   	push   %ebx
80102cc6:	83 ec 20             	sub    $0x20,%esp
80102cc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102ccc:	6a 00                	push   $0x0
80102cce:	ff 75 0c             	push   0xc(%ebp)
80102cd1:	53                   	push   %ebx
80102cd2:	e8 19 fd ff ff       	call   801029f0 <dirlookup>
80102cd7:	83 c4 10             	add    $0x10,%esp
80102cda:	85 c0                	test   %eax,%eax
80102cdc:	75 67                	jne    80102d45 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102cde:	8b 7b 58             	mov    0x58(%ebx),%edi
80102ce1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ce4:	85 ff                	test   %edi,%edi
80102ce6:	74 29                	je     80102d11 <dirlink+0x51>
80102ce8:	31 ff                	xor    %edi,%edi
80102cea:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ced:	eb 09                	jmp    80102cf8 <dirlink+0x38>
80102cef:	90                   	nop
80102cf0:	83 c7 10             	add    $0x10,%edi
80102cf3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102cf6:	73 19                	jae    80102d11 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102cf8:	6a 10                	push   $0x10
80102cfa:	57                   	push   %edi
80102cfb:	56                   	push   %esi
80102cfc:	53                   	push   %ebx
80102cfd:	e8 ae fa ff ff       	call   801027b0 <readi>
80102d02:	83 c4 10             	add    $0x10,%esp
80102d05:	83 f8 10             	cmp    $0x10,%eax
80102d08:	75 4e                	jne    80102d58 <dirlink+0x98>
    if(de.inum == 0)
80102d0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102d0f:	75 df                	jne    80102cf0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102d11:	83 ec 04             	sub    $0x4,%esp
80102d14:	8d 45 da             	lea    -0x26(%ebp),%eax
80102d17:	6a 0e                	push   $0xe
80102d19:	ff 75 0c             	push   0xc(%ebp)
80102d1c:	50                   	push   %eax
80102d1d:	e8 ce 27 00 00       	call   801054f0 <strncpy>
  de.inum = inum;
80102d22:	8b 45 10             	mov    0x10(%ebp),%eax
80102d25:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d29:	6a 10                	push   $0x10
80102d2b:	57                   	push   %edi
80102d2c:	56                   	push   %esi
80102d2d:	53                   	push   %ebx
80102d2e:	e8 7d fb ff ff       	call   801028b0 <writei>
80102d33:	83 c4 20             	add    $0x20,%esp
80102d36:	83 f8 10             	cmp    $0x10,%eax
80102d39:	75 2a                	jne    80102d65 <dirlink+0xa5>
  return 0;
80102d3b:	31 c0                	xor    %eax,%eax
}
80102d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d40:	5b                   	pop    %ebx
80102d41:	5e                   	pop    %esi
80102d42:	5f                   	pop    %edi
80102d43:	5d                   	pop    %ebp
80102d44:	c3                   	ret
    iput(ip);
80102d45:	83 ec 0c             	sub    $0xc,%esp
80102d48:	50                   	push   %eax
80102d49:	e8 82 f8 ff ff       	call   801025d0 <iput>
    return -1;
80102d4e:	83 c4 10             	add    $0x10,%esp
80102d51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d56:	eb e5                	jmp    80102d3d <dirlink+0x7d>
      panic("dirlink read");
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 df 81 10 80       	push   $0x801081df
80102d60:	e8 ab d7 ff ff       	call   80100510 <panic>
    panic("dirlink");
80102d65:	83 ec 0c             	sub    $0xc,%esp
80102d68:	68 3b 84 10 80       	push   $0x8010843b
80102d6d:	e8 9e d7 ff ff       	call   80100510 <panic>
80102d72:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d79:	00 
80102d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102d80 <namei>:

struct inode*
namei(char *path)
{
80102d80:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102d81:	31 d2                	xor    %edx,%edx
{
80102d83:	89 e5                	mov    %esp,%ebp
80102d85:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102d88:	8b 45 08             	mov    0x8(%ebp),%eax
80102d8b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102d8e:	e8 0d fd ff ff       	call   80102aa0 <namex>
}
80102d93:	c9                   	leave
80102d94:	c3                   	ret
80102d95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9c:	00 
80102d9d:	8d 76 00             	lea    0x0(%esi),%esi

80102da0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102da0:	55                   	push   %ebp
  return namex(path, 1, name);
80102da1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102da6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102da8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102dab:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102dae:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102daf:	e9 ec fc ff ff       	jmp    80102aa0 <namex>
80102db4:	66 90                	xchg   %ax,%ax
80102db6:	66 90                	xchg   %ax,%ax
80102db8:	66 90                	xchg   %ax,%ax
80102dba:	66 90                	xchg   %ax,%ax
80102dbc:	66 90                	xchg   %ax,%ax
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	57                   	push   %edi
80102dc4:	56                   	push   %esi
80102dc5:	53                   	push   %ebx
80102dc6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102dc9:	85 c0                	test   %eax,%eax
80102dcb:	0f 84 b4 00 00 00    	je     80102e85 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102dd1:	8b 70 08             	mov    0x8(%eax),%esi
80102dd4:	89 c3                	mov    %eax,%ebx
80102dd6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102ddc:	0f 87 96 00 00 00    	ja     80102e78 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102de7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dee:	00 
80102def:	90                   	nop
80102df0:	89 ca                	mov    %ecx,%edx
80102df2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102df3:	83 e0 c0             	and    $0xffffffc0,%eax
80102df6:	3c 40                	cmp    $0x40,%al
80102df8:	75 f6                	jne    80102df0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dfa:	31 ff                	xor    %edi,%edi
80102dfc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102e01:	89 f8                	mov    %edi,%eax
80102e03:	ee                   	out    %al,(%dx)
80102e04:	b8 01 00 00 00       	mov    $0x1,%eax
80102e09:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102e0e:	ee                   	out    %al,(%dx)
80102e0f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102e14:	89 f0                	mov    %esi,%eax
80102e16:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102e17:	89 f0                	mov    %esi,%eax
80102e19:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102e1e:	c1 f8 08             	sar    $0x8,%eax
80102e21:	ee                   	out    %al,(%dx)
80102e22:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102e27:	89 f8                	mov    %edi,%eax
80102e29:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102e2a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102e2e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e33:	c1 e0 04             	shl    $0x4,%eax
80102e36:	83 e0 10             	and    $0x10,%eax
80102e39:	83 c8 e0             	or     $0xffffffe0,%eax
80102e3c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102e3d:	f6 03 04             	testb  $0x4,(%ebx)
80102e40:	75 16                	jne    80102e58 <idestart+0x98>
80102e42:	b8 20 00 00 00       	mov    $0x20,%eax
80102e47:	89 ca                	mov    %ecx,%edx
80102e49:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102e4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e4d:	5b                   	pop    %ebx
80102e4e:	5e                   	pop    %esi
80102e4f:	5f                   	pop    %edi
80102e50:	5d                   	pop    %ebp
80102e51:	c3                   	ret
80102e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e58:	b8 30 00 00 00       	mov    $0x30,%eax
80102e5d:	89 ca                	mov    %ecx,%edx
80102e5f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102e60:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102e65:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102e68:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102e6d:	fc                   	cld
80102e6e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102e70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e73:	5b                   	pop    %ebx
80102e74:	5e                   	pop    %esi
80102e75:	5f                   	pop    %edi
80102e76:	5d                   	pop    %ebp
80102e77:	c3                   	ret
    panic("incorrect blockno");
80102e78:	83 ec 0c             	sub    $0xc,%esp
80102e7b:	68 f5 81 10 80       	push   $0x801081f5
80102e80:	e8 8b d6 ff ff       	call   80100510 <panic>
    panic("idestart");
80102e85:	83 ec 0c             	sub    $0xc,%esp
80102e88:	68 ec 81 10 80       	push   $0x801081ec
80102e8d:	e8 7e d6 ff ff       	call   80100510 <panic>
80102e92:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e99:	00 
80102e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ea0 <ideinit>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102ea6:	68 07 82 10 80       	push   $0x80108207
80102eab:	68 40 2c 11 80       	push   $0x80112c40
80102eb0:	e8 fb 21 00 00       	call   801050b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102eb5:	58                   	pop    %eax
80102eb6:	a1 c4 2d 11 80       	mov    0x80112dc4,%eax
80102ebb:	5a                   	pop    %edx
80102ebc:	83 e8 01             	sub    $0x1,%eax
80102ebf:	50                   	push   %eax
80102ec0:	6a 0e                	push   $0xe
80102ec2:	e8 99 02 00 00       	call   80103160 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102ec7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eca:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102ecf:	90                   	nop
80102ed0:	89 ca                	mov    %ecx,%edx
80102ed2:	ec                   	in     (%dx),%al
80102ed3:	83 e0 c0             	and    $0xffffffc0,%eax
80102ed6:	3c 40                	cmp    $0x40,%al
80102ed8:	75 f6                	jne    80102ed0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eda:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102edf:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102ee4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee5:	89 ca                	mov    %ecx,%edx
80102ee7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102ee8:	84 c0                	test   %al,%al
80102eea:	75 1e                	jne    80102f0a <ideinit+0x6a>
80102eec:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102ef1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ef6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102efd:	00 
80102efe:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102f00:	83 e9 01             	sub    $0x1,%ecx
80102f03:	74 0f                	je     80102f14 <ideinit+0x74>
80102f05:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102f06:	84 c0                	test   %al,%al
80102f08:	74 f6                	je     80102f00 <ideinit+0x60>
      havedisk1 = 1;
80102f0a:	c7 05 20 2c 11 80 01 	movl   $0x1,0x80112c20
80102f11:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f14:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102f19:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f1e:	ee                   	out    %al,(%dx)
}
80102f1f:	c9                   	leave
80102f20:	c3                   	ret
80102f21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f28:	00 
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f30 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	57                   	push   %edi
80102f34:	56                   	push   %esi
80102f35:	53                   	push   %ebx
80102f36:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102f39:	68 40 2c 11 80       	push   $0x80112c40
80102f3e:	e8 5d 23 00 00       	call   801052a0 <acquire>

  if((b = idequeue) == 0){
80102f43:	8b 1d 24 2c 11 80    	mov    0x80112c24,%ebx
80102f49:	83 c4 10             	add    $0x10,%esp
80102f4c:	85 db                	test   %ebx,%ebx
80102f4e:	74 63                	je     80102fb3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102f50:	8b 43 58             	mov    0x58(%ebx),%eax
80102f53:	a3 24 2c 11 80       	mov    %eax,0x80112c24

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102f58:	8b 33                	mov    (%ebx),%esi
80102f5a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102f60:	75 2f                	jne    80102f91 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f62:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f6e:	00 
80102f6f:	90                   	nop
80102f70:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102f71:	89 c1                	mov    %eax,%ecx
80102f73:	83 e1 c0             	and    $0xffffffc0,%ecx
80102f76:	80 f9 40             	cmp    $0x40,%cl
80102f79:	75 f5                	jne    80102f70 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102f7b:	a8 21                	test   $0x21,%al
80102f7d:	75 12                	jne    80102f91 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102f7f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102f82:	b9 80 00 00 00       	mov    $0x80,%ecx
80102f87:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102f8c:	fc                   	cld
80102f8d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102f8f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102f91:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102f94:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102f97:	83 ce 02             	or     $0x2,%esi
80102f9a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102f9c:	53                   	push   %ebx
80102f9d:	e8 3e 1e 00 00       	call   80104de0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102fa2:	a1 24 2c 11 80       	mov    0x80112c24,%eax
80102fa7:	83 c4 10             	add    $0x10,%esp
80102faa:	85 c0                	test   %eax,%eax
80102fac:	74 05                	je     80102fb3 <ideintr+0x83>
    idestart(idequeue);
80102fae:	e8 0d fe ff ff       	call   80102dc0 <idestart>
    release(&idelock);
80102fb3:	83 ec 0c             	sub    $0xc,%esp
80102fb6:	68 40 2c 11 80       	push   $0x80112c40
80102fbb:	e8 80 22 00 00       	call   80105240 <release>

  release(&idelock);
}
80102fc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fc3:	5b                   	pop    %ebx
80102fc4:	5e                   	pop    %esi
80102fc5:	5f                   	pop    %edi
80102fc6:	5d                   	pop    %ebp
80102fc7:	c3                   	ret
80102fc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fcf:	00 

80102fd0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	53                   	push   %ebx
80102fd4:	83 ec 10             	sub    $0x10,%esp
80102fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102fda:	8d 43 0c             	lea    0xc(%ebx),%eax
80102fdd:	50                   	push   %eax
80102fde:	e8 7d 20 00 00       	call   80105060 <holdingsleep>
80102fe3:	83 c4 10             	add    $0x10,%esp
80102fe6:	85 c0                	test   %eax,%eax
80102fe8:	0f 84 c3 00 00 00    	je     801030b1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102fee:	8b 03                	mov    (%ebx),%eax
80102ff0:	83 e0 06             	and    $0x6,%eax
80102ff3:	83 f8 02             	cmp    $0x2,%eax
80102ff6:	0f 84 a8 00 00 00    	je     801030a4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102ffc:	8b 53 04             	mov    0x4(%ebx),%edx
80102fff:	85 d2                	test   %edx,%edx
80103001:	74 0d                	je     80103010 <iderw+0x40>
80103003:	a1 20 2c 11 80       	mov    0x80112c20,%eax
80103008:	85 c0                	test   %eax,%eax
8010300a:	0f 84 87 00 00 00    	je     80103097 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103010:	83 ec 0c             	sub    $0xc,%esp
80103013:	68 40 2c 11 80       	push   $0x80112c40
80103018:	e8 83 22 00 00       	call   801052a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010301d:	a1 24 2c 11 80       	mov    0x80112c24,%eax
  b->qnext = 0;
80103022:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103029:	83 c4 10             	add    $0x10,%esp
8010302c:	85 c0                	test   %eax,%eax
8010302e:	74 60                	je     80103090 <iderw+0xc0>
80103030:	89 c2                	mov    %eax,%edx
80103032:	8b 40 58             	mov    0x58(%eax),%eax
80103035:	85 c0                	test   %eax,%eax
80103037:	75 f7                	jne    80103030 <iderw+0x60>
80103039:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010303c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010303e:	39 1d 24 2c 11 80    	cmp    %ebx,0x80112c24
80103044:	74 3a                	je     80103080 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103046:	8b 03                	mov    (%ebx),%eax
80103048:	83 e0 06             	and    $0x6,%eax
8010304b:	83 f8 02             	cmp    $0x2,%eax
8010304e:	74 1b                	je     8010306b <iderw+0x9b>
    sleep(b, &idelock);
80103050:	83 ec 08             	sub    $0x8,%esp
80103053:	68 40 2c 11 80       	push   $0x80112c40
80103058:	53                   	push   %ebx
80103059:	e8 c2 1c 00 00       	call   80104d20 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010305e:	8b 03                	mov    (%ebx),%eax
80103060:	83 c4 10             	add    $0x10,%esp
80103063:	83 e0 06             	and    $0x6,%eax
80103066:	83 f8 02             	cmp    $0x2,%eax
80103069:	75 e5                	jne    80103050 <iderw+0x80>
  }


  release(&idelock);
8010306b:	c7 45 08 40 2c 11 80 	movl   $0x80112c40,0x8(%ebp)
}
80103072:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103075:	c9                   	leave
  release(&idelock);
80103076:	e9 c5 21 00 00       	jmp    80105240 <release>
8010307b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80103080:	89 d8                	mov    %ebx,%eax
80103082:	e8 39 fd ff ff       	call   80102dc0 <idestart>
80103087:	eb bd                	jmp    80103046 <iderw+0x76>
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103090:	ba 24 2c 11 80       	mov    $0x80112c24,%edx
80103095:	eb a5                	jmp    8010303c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80103097:	83 ec 0c             	sub    $0xc,%esp
8010309a:	68 36 82 10 80       	push   $0x80108236
8010309f:	e8 6c d4 ff ff       	call   80100510 <panic>
    panic("iderw: nothing to do");
801030a4:	83 ec 0c             	sub    $0xc,%esp
801030a7:	68 21 82 10 80       	push   $0x80108221
801030ac:	e8 5f d4 ff ff       	call   80100510 <panic>
    panic("iderw: buf not locked");
801030b1:	83 ec 0c             	sub    $0xc,%esp
801030b4:	68 0b 82 10 80       	push   $0x8010820b
801030b9:	e8 52 d4 ff ff       	call   80100510 <panic>
801030be:	66 90                	xchg   %ax,%ax

801030c0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	56                   	push   %esi
801030c4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801030c5:	c7 05 74 2c 11 80 00 	movl   $0xfec00000,0x80112c74
801030cc:	00 c0 fe 
  ioapic->reg = reg;
801030cf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801030d6:	00 00 00 
  return ioapic->data;
801030d9:	8b 15 74 2c 11 80    	mov    0x80112c74,%edx
801030df:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801030e2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801030e8:	8b 1d 74 2c 11 80    	mov    0x80112c74,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801030ee:	0f b6 15 c0 2d 11 80 	movzbl 0x80112dc0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801030f5:	c1 ee 10             	shr    $0x10,%esi
801030f8:	89 f0                	mov    %esi,%eax
801030fa:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801030fd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80103100:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103103:	39 c2                	cmp    %eax,%edx
80103105:	74 16                	je     8010311d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103107:	83 ec 0c             	sub    $0xc,%esp
8010310a:	68 64 86 10 80       	push   $0x80108664
8010310f:	e8 7c d9 ff ff       	call   80100a90 <cprintf>
  ioapic->reg = reg;
80103114:	8b 1d 74 2c 11 80    	mov    0x80112c74,%ebx
8010311a:	83 c4 10             	add    $0x10,%esp
{
8010311d:	ba 10 00 00 00       	mov    $0x10,%edx
80103122:	31 c0                	xor    %eax,%eax
80103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80103128:	89 13                	mov    %edx,(%ebx)
8010312a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010312d:	8b 1d 74 2c 11 80    	mov    0x80112c74,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103133:	83 c0 01             	add    $0x1,%eax
80103136:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010313c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010313f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80103142:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80103145:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80103147:	8b 1d 74 2c 11 80    	mov    0x80112c74,%ebx
8010314d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80103154:	39 c6                	cmp    %eax,%esi
80103156:	7d d0                	jge    80103128 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80103158:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010315b:	5b                   	pop    %ebx
8010315c:	5e                   	pop    %esi
8010315d:	5d                   	pop    %ebp
8010315e:	c3                   	ret
8010315f:	90                   	nop

80103160 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103160:	55                   	push   %ebp
  ioapic->reg = reg;
80103161:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
{
80103167:	89 e5                	mov    %esp,%ebp
80103169:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010316c:	8d 50 20             	lea    0x20(%eax),%edx
8010316f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103173:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103175:	8b 0d 74 2c 11 80    	mov    0x80112c74,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010317b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010317e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103181:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103184:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103186:	a1 74 2c 11 80       	mov    0x80112c74,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010318b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010318e:	89 50 10             	mov    %edx,0x10(%eax)
}
80103191:	5d                   	pop    %ebp
80103192:	c3                   	ret
80103193:	66 90                	xchg   %ax,%ax
80103195:	66 90                	xchg   %ax,%ax
80103197:	66 90                	xchg   %ax,%ax
80103199:	66 90                	xchg   %ax,%ax
8010319b:	66 90                	xchg   %ax,%ax
8010319d:	66 90                	xchg   %ax,%ax
8010319f:	90                   	nop

801031a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	53                   	push   %ebx
801031a4:	83 ec 04             	sub    $0x4,%esp
801031a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801031aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801031b0:	75 76                	jne    80103228 <kfree+0x88>
801031b2:	81 fb 10 6b 11 80    	cmp    $0x80116b10,%ebx
801031b8:	72 6e                	jb     80103228 <kfree+0x88>
801031ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801031c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801031c5:	77 61                	ja     80103228 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801031c7:	83 ec 04             	sub    $0x4,%esp
801031ca:	68 00 10 00 00       	push   $0x1000
801031cf:	6a 01                	push   $0x1
801031d1:	53                   	push   %ebx
801031d2:	e8 c9 21 00 00       	call   801053a0 <memset>

  if(kmem.use_lock)
801031d7:	8b 15 b4 2c 11 80    	mov    0x80112cb4,%edx
801031dd:	83 c4 10             	add    $0x10,%esp
801031e0:	85 d2                	test   %edx,%edx
801031e2:	75 1c                	jne    80103200 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801031e4:	a1 b8 2c 11 80       	mov    0x80112cb8,%eax
801031e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801031eb:	a1 b4 2c 11 80       	mov    0x80112cb4,%eax
  kmem.freelist = r;
801031f0:	89 1d b8 2c 11 80    	mov    %ebx,0x80112cb8
  if(kmem.use_lock)
801031f6:	85 c0                	test   %eax,%eax
801031f8:	75 1e                	jne    80103218 <kfree+0x78>
    release(&kmem.lock);
}
801031fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031fd:	c9                   	leave
801031fe:	c3                   	ret
801031ff:	90                   	nop
    acquire(&kmem.lock);
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	68 80 2c 11 80       	push   $0x80112c80
80103208:	e8 93 20 00 00       	call   801052a0 <acquire>
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	eb d2                	jmp    801031e4 <kfree+0x44>
80103212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103218:	c7 45 08 80 2c 11 80 	movl   $0x80112c80,0x8(%ebp)
}
8010321f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103222:	c9                   	leave
    release(&kmem.lock);
80103223:	e9 18 20 00 00       	jmp    80105240 <release>
    panic("kfree");
80103228:	83 ec 0c             	sub    $0xc,%esp
8010322b:	68 54 82 10 80       	push   $0x80108254
80103230:	e8 db d2 ff ff       	call   80100510 <panic>
80103235:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010323c:	00 
8010323d:	8d 76 00             	lea    0x0(%esi),%esi

80103240 <freerange>:
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	56                   	push   %esi
80103244:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103245:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103248:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010324b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103251:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103257:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010325d:	39 de                	cmp    %ebx,%esi
8010325f:	72 23                	jb     80103284 <freerange+0x44>
80103261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103268:	83 ec 0c             	sub    $0xc,%esp
8010326b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103271:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103277:	50                   	push   %eax
80103278:	e8 23 ff ff ff       	call   801031a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010327d:	83 c4 10             	add    $0x10,%esp
80103280:	39 de                	cmp    %ebx,%esi
80103282:	73 e4                	jae    80103268 <freerange+0x28>
}
80103284:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103287:	5b                   	pop    %ebx
80103288:	5e                   	pop    %esi
80103289:	5d                   	pop    %ebp
8010328a:	c3                   	ret
8010328b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103290 <kinit2>:
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	56                   	push   %esi
80103294:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103295:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103298:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010329b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032ad:	39 de                	cmp    %ebx,%esi
801032af:	72 23                	jb     801032d4 <kinit2+0x44>
801032b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801032b8:	83 ec 0c             	sub    $0xc,%esp
801032bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801032c7:	50                   	push   %eax
801032c8:	e8 d3 fe ff ff       	call   801031a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032cd:	83 c4 10             	add    $0x10,%esp
801032d0:	39 de                	cmp    %ebx,%esi
801032d2:	73 e4                	jae    801032b8 <kinit2+0x28>
  kmem.use_lock = 1;
801032d4:	c7 05 b4 2c 11 80 01 	movl   $0x1,0x80112cb4
801032db:	00 00 00 
}
801032de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032e1:	5b                   	pop    %ebx
801032e2:	5e                   	pop    %esi
801032e3:	5d                   	pop    %ebp
801032e4:	c3                   	ret
801032e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032ec:	00 
801032ed:	8d 76 00             	lea    0x0(%esi),%esi

801032f0 <kinit1>:
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	56                   	push   %esi
801032f4:	53                   	push   %ebx
801032f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801032f8:	83 ec 08             	sub    $0x8,%esp
801032fb:	68 5a 82 10 80       	push   $0x8010825a
80103300:	68 80 2c 11 80       	push   $0x80112c80
80103305:	e8 a6 1d 00 00       	call   801050b0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010330a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010330d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103310:	c7 05 b4 2c 11 80 00 	movl   $0x0,0x80112cb4
80103317:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010331a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103320:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103326:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010332c:	39 de                	cmp    %ebx,%esi
8010332e:	72 1c                	jb     8010334c <kinit1+0x5c>
    kfree(p);
80103330:	83 ec 0c             	sub    $0xc,%esp
80103333:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103339:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010333f:	50                   	push   %eax
80103340:	e8 5b fe ff ff       	call   801031a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103345:	83 c4 10             	add    $0x10,%esp
80103348:	39 de                	cmp    %ebx,%esi
8010334a:	73 e4                	jae    80103330 <kinit1+0x40>
}
8010334c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010334f:	5b                   	pop    %ebx
80103350:	5e                   	pop    %esi
80103351:	5d                   	pop    %ebp
80103352:	c3                   	ret
80103353:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010335a:	00 
8010335b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103360 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	53                   	push   %ebx
80103364:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103367:	a1 b4 2c 11 80       	mov    0x80112cb4,%eax
8010336c:	85 c0                	test   %eax,%eax
8010336e:	75 20                	jne    80103390 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103370:	8b 1d b8 2c 11 80    	mov    0x80112cb8,%ebx
  if(r)
80103376:	85 db                	test   %ebx,%ebx
80103378:	74 07                	je     80103381 <kalloc+0x21>
    kmem.freelist = r->next;
8010337a:	8b 03                	mov    (%ebx),%eax
8010337c:	a3 b8 2c 11 80       	mov    %eax,0x80112cb8
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80103381:	89 d8                	mov    %ebx,%eax
80103383:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103386:	c9                   	leave
80103387:	c3                   	ret
80103388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010338f:	00 
    acquire(&kmem.lock);
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 80 2c 11 80       	push   $0x80112c80
80103398:	e8 03 1f 00 00       	call   801052a0 <acquire>
  r = kmem.freelist;
8010339d:	8b 1d b8 2c 11 80    	mov    0x80112cb8,%ebx
  if(kmem.use_lock)
801033a3:	a1 b4 2c 11 80       	mov    0x80112cb4,%eax
  if(r)
801033a8:	83 c4 10             	add    $0x10,%esp
801033ab:	85 db                	test   %ebx,%ebx
801033ad:	74 08                	je     801033b7 <kalloc+0x57>
    kmem.freelist = r->next;
801033af:	8b 13                	mov    (%ebx),%edx
801033b1:	89 15 b8 2c 11 80    	mov    %edx,0x80112cb8
  if(kmem.use_lock)
801033b7:	85 c0                	test   %eax,%eax
801033b9:	74 c6                	je     80103381 <kalloc+0x21>
    release(&kmem.lock);
801033bb:	83 ec 0c             	sub    $0xc,%esp
801033be:	68 80 2c 11 80       	push   $0x80112c80
801033c3:	e8 78 1e 00 00       	call   80105240 <release>
}
801033c8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801033ca:	83 c4 10             	add    $0x10,%esp
}
801033cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033d0:	c9                   	leave
801033d1:	c3                   	ret
801033d2:	66 90                	xchg   %ax,%ax
801033d4:	66 90                	xchg   %ax,%ax
801033d6:	66 90                	xchg   %ax,%ax
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801033e0:	ba 64 00 00 00       	mov    $0x64,%edx
801033e5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801033e6:	a8 01                	test   $0x1,%al
801033e8:	0f 84 c2 00 00 00    	je     801034b0 <kbdgetc+0xd0>
{
801033ee:	55                   	push   %ebp
801033ef:	ba 60 00 00 00       	mov    $0x60,%edx
801033f4:	89 e5                	mov    %esp,%ebp
801033f6:	53                   	push   %ebx
801033f7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801033f8:	8b 1d bc 2c 11 80    	mov    0x80112cbc,%ebx
  data = inb(KBDATAP);
801033fe:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103401:	3c e0                	cmp    $0xe0,%al
80103403:	74 5b                	je     80103460 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103405:	89 da                	mov    %ebx,%edx
80103407:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010340a:	84 c0                	test   %al,%al
8010340c:	78 62                	js     80103470 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010340e:	85 d2                	test   %edx,%edx
80103410:	74 09                	je     8010341b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103412:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103415:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103418:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010341b:	0f b6 91 c0 88 10 80 	movzbl -0x7fef7740(%ecx),%edx
  shift ^= togglecode[data];
80103422:	0f b6 81 c0 87 10 80 	movzbl -0x7fef7840(%ecx),%eax
  shift |= shiftcode[data];
80103429:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010342b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010342d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010342f:	89 15 bc 2c 11 80    	mov    %edx,0x80112cbc
  c = charcode[shift & (CTL | SHIFT)][data];
80103435:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103438:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010343b:	8b 04 85 a0 87 10 80 	mov    -0x7fef7860(,%eax,4),%eax
80103442:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103446:	74 0b                	je     80103453 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103448:	8d 50 9f             	lea    -0x61(%eax),%edx
8010344b:	83 fa 19             	cmp    $0x19,%edx
8010344e:	77 48                	ja     80103498 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103450:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103453:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103456:	c9                   	leave
80103457:	c3                   	ret
80103458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010345f:	00 
    shift |= E0ESC;
80103460:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103463:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103465:	89 1d bc 2c 11 80    	mov    %ebx,0x80112cbc
}
8010346b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010346e:	c9                   	leave
8010346f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80103470:	83 e0 7f             	and    $0x7f,%eax
80103473:	85 d2                	test   %edx,%edx
80103475:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103478:	0f b6 81 c0 88 10 80 	movzbl -0x7fef7740(%ecx),%eax
8010347f:	83 c8 40             	or     $0x40,%eax
80103482:	0f b6 c0             	movzbl %al,%eax
80103485:	f7 d0                	not    %eax
80103487:	21 d8                	and    %ebx,%eax
80103489:	a3 bc 2c 11 80       	mov    %eax,0x80112cbc
    return 0;
8010348e:	31 c0                	xor    %eax,%eax
80103490:	eb d9                	jmp    8010346b <kbdgetc+0x8b>
80103492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80103498:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010349b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010349e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034a1:	c9                   	leave
      c += 'a' - 'A';
801034a2:	83 f9 1a             	cmp    $0x1a,%ecx
801034a5:	0f 42 c2             	cmovb  %edx,%eax
}
801034a8:	c3                   	ret
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801034b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034b5:	c3                   	ret
801034b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034bd:	00 
801034be:	66 90                	xchg   %ax,%ax

801034c0 <kbdintr>:

void
kbdintr(void)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801034c6:	68 e0 33 10 80       	push   $0x801033e0
801034cb:	e8 70 d8 ff ff       	call   80100d40 <consoleintr>
}
801034d0:	83 c4 10             	add    $0x10,%esp
801034d3:	c9                   	leave
801034d4:	c3                   	ret
801034d5:	66 90                	xchg   %ax,%ax
801034d7:	66 90                	xchg   %ax,%ax
801034d9:	66 90                	xchg   %ax,%ax
801034db:	66 90                	xchg   %ax,%ax
801034dd:	66 90                	xchg   %ax,%ax
801034df:	90                   	nop

801034e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801034e0:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
801034e5:	85 c0                	test   %eax,%eax
801034e7:	0f 84 c3 00 00 00    	je     801035b0 <lapicinit+0xd0>
  lapic[index] = value;
801034ed:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801034f4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034fa:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103501:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103504:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103507:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010350e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103511:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103514:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010351b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010351e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103521:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103528:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010352b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010352e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103535:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103538:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010353b:	8b 50 30             	mov    0x30(%eax),%edx
8010353e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103544:	75 72                	jne    801035b8 <lapicinit+0xd8>
  lapic[index] = value;
80103546:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010354d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103550:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103553:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010355a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010355d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103560:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103567:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010356a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010356d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103574:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103577:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010357a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103581:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103584:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103587:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010358e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103591:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103598:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010359e:	80 e6 10             	and    $0x10,%dh
801035a1:	75 f5                	jne    80103598 <lapicinit+0xb8>
  lapic[index] = value;
801035a3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801035aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035ad:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801035b0:	c3                   	ret
801035b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801035b8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801035bf:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801035c2:	8b 50 20             	mov    0x20(%eax),%edx
}
801035c5:	e9 7c ff ff ff       	jmp    80103546 <lapicinit+0x66>
801035ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035d0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801035d0:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
801035d5:	85 c0                	test   %eax,%eax
801035d7:	74 07                	je     801035e0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801035d9:	8b 40 20             	mov    0x20(%eax),%eax
801035dc:	c1 e8 18             	shr    $0x18,%eax
801035df:	c3                   	ret
    return 0;
801035e0:	31 c0                	xor    %eax,%eax
}
801035e2:	c3                   	ret
801035e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035ea:	00 
801035eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801035f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801035f0:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
801035f5:	85 c0                	test   %eax,%eax
801035f7:	74 0d                	je     80103606 <lapiceoi+0x16>
  lapic[index] = value;
801035f9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103600:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103603:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103606:	c3                   	ret
80103607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010360e:	00 
8010360f:	90                   	nop

80103610 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103610:	c3                   	ret
80103611:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103618:	00 
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103620 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103620:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103621:	b8 0f 00 00 00       	mov    $0xf,%eax
80103626:	ba 70 00 00 00       	mov    $0x70,%edx
8010362b:	89 e5                	mov    %esp,%ebp
8010362d:	53                   	push   %ebx
8010362e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103631:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103634:	ee                   	out    %al,(%dx)
80103635:	b8 0a 00 00 00       	mov    $0xa,%eax
8010363a:	ba 71 00 00 00       	mov    $0x71,%edx
8010363f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103640:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80103642:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103645:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010364b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010364d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80103650:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103652:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103655:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103658:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010365e:	a1 c0 2c 11 80       	mov    0x80112cc0,%eax
80103663:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103669:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010366c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103673:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103676:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103679:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103680:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103683:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103686:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010368c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010368f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103695:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103698:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010369e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801036a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036a7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801036aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ad:	c9                   	leave
801036ae:	c3                   	ret
801036af:	90                   	nop

801036b0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801036b0:	55                   	push   %ebp
801036b1:	b8 0b 00 00 00       	mov    $0xb,%eax
801036b6:	ba 70 00 00 00       	mov    $0x70,%edx
801036bb:	89 e5                	mov    %esp,%ebp
801036bd:	57                   	push   %edi
801036be:	56                   	push   %esi
801036bf:	53                   	push   %ebx
801036c0:	83 ec 4c             	sub    $0x4c,%esp
801036c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036c4:	ba 71 00 00 00       	mov    $0x71,%edx
801036c9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801036ca:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036cd:	bf 70 00 00 00       	mov    $0x70,%edi
801036d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801036d5:	8d 76 00             	lea    0x0(%esi),%esi
801036d8:	31 c0                	xor    %eax,%eax
801036da:	89 fa                	mov    %edi,%edx
801036dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036dd:	b9 71 00 00 00       	mov    $0x71,%ecx
801036e2:	89 ca                	mov    %ecx,%edx
801036e4:	ec                   	in     (%dx),%al
801036e5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036e8:	89 fa                	mov    %edi,%edx
801036ea:	b8 02 00 00 00       	mov    $0x2,%eax
801036ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036f0:	89 ca                	mov    %ecx,%edx
801036f2:	ec                   	in     (%dx),%al
801036f3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036f6:	89 fa                	mov    %edi,%edx
801036f8:	b8 04 00 00 00       	mov    $0x4,%eax
801036fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036fe:	89 ca                	mov    %ecx,%edx
80103700:	ec                   	in     (%dx),%al
80103701:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103704:	89 fa                	mov    %edi,%edx
80103706:	b8 07 00 00 00       	mov    $0x7,%eax
8010370b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010370c:	89 ca                	mov    %ecx,%edx
8010370e:	ec                   	in     (%dx),%al
8010370f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103712:	89 fa                	mov    %edi,%edx
80103714:	b8 08 00 00 00       	mov    $0x8,%eax
80103719:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010371a:	89 ca                	mov    %ecx,%edx
8010371c:	ec                   	in     (%dx),%al
8010371d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010371f:	89 fa                	mov    %edi,%edx
80103721:	b8 09 00 00 00       	mov    $0x9,%eax
80103726:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103727:	89 ca                	mov    %ecx,%edx
80103729:	ec                   	in     (%dx),%al
8010372a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010372d:	89 fa                	mov    %edi,%edx
8010372f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103734:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103735:	89 ca                	mov    %ecx,%edx
80103737:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103738:	84 c0                	test   %al,%al
8010373a:	78 9c                	js     801036d8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010373c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103740:	89 f2                	mov    %esi,%edx
80103742:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103745:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103748:	89 fa                	mov    %edi,%edx
8010374a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010374d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103751:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103754:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103757:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010375b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010375e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103762:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103765:	31 c0                	xor    %eax,%eax
80103767:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103768:	89 ca                	mov    %ecx,%edx
8010376a:	ec                   	in     (%dx),%al
8010376b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010376e:	89 fa                	mov    %edi,%edx
80103770:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103773:	b8 02 00 00 00       	mov    $0x2,%eax
80103778:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103779:	89 ca                	mov    %ecx,%edx
8010377b:	ec                   	in     (%dx),%al
8010377c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010377f:	89 fa                	mov    %edi,%edx
80103781:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103784:	b8 04 00 00 00       	mov    $0x4,%eax
80103789:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010378a:	89 ca                	mov    %ecx,%edx
8010378c:	ec                   	in     (%dx),%al
8010378d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103790:	89 fa                	mov    %edi,%edx
80103792:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103795:	b8 07 00 00 00       	mov    $0x7,%eax
8010379a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010379b:	89 ca                	mov    %ecx,%edx
8010379d:	ec                   	in     (%dx),%al
8010379e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037a1:	89 fa                	mov    %edi,%edx
801037a3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801037a6:	b8 08 00 00 00       	mov    $0x8,%eax
801037ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037ac:	89 ca                	mov    %ecx,%edx
801037ae:	ec                   	in     (%dx),%al
801037af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037b2:	89 fa                	mov    %edi,%edx
801037b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801037b7:	b8 09 00 00 00       	mov    $0x9,%eax
801037bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037bd:	89 ca                	mov    %ecx,%edx
801037bf:	ec                   	in     (%dx),%al
801037c0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801037c3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801037c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801037c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801037cc:	6a 18                	push   $0x18
801037ce:	50                   	push   %eax
801037cf:	8d 45 b8             	lea    -0x48(%ebp),%eax
801037d2:	50                   	push   %eax
801037d3:	e8 08 1c 00 00       	call   801053e0 <memcmp>
801037d8:	83 c4 10             	add    $0x10,%esp
801037db:	85 c0                	test   %eax,%eax
801037dd:	0f 85 f5 fe ff ff    	jne    801036d8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801037e3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
801037e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037ea:	89 f0                	mov    %esi,%eax
801037ec:	84 c0                	test   %al,%al
801037ee:	75 78                	jne    80103868 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801037f0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801037f3:	89 c2                	mov    %eax,%edx
801037f5:	83 e0 0f             	and    $0xf,%eax
801037f8:	c1 ea 04             	shr    $0x4,%edx
801037fb:	8d 14 92             	lea    (%edx,%edx,4),%edx
801037fe:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103801:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103804:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103807:	89 c2                	mov    %eax,%edx
80103809:	83 e0 0f             	and    $0xf,%eax
8010380c:	c1 ea 04             	shr    $0x4,%edx
8010380f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103812:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103815:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103818:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010381b:	89 c2                	mov    %eax,%edx
8010381d:	83 e0 0f             	and    $0xf,%eax
80103820:	c1 ea 04             	shr    $0x4,%edx
80103823:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103826:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103829:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010382c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010382f:	89 c2                	mov    %eax,%edx
80103831:	83 e0 0f             	and    $0xf,%eax
80103834:	c1 ea 04             	shr    $0x4,%edx
80103837:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010383a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010383d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103840:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103843:	89 c2                	mov    %eax,%edx
80103845:	83 e0 0f             	and    $0xf,%eax
80103848:	c1 ea 04             	shr    $0x4,%edx
8010384b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010384e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103851:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103854:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103857:	89 c2                	mov    %eax,%edx
80103859:	83 e0 0f             	and    $0xf,%eax
8010385c:	c1 ea 04             	shr    $0x4,%edx
8010385f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103862:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103865:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103868:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010386b:	89 03                	mov    %eax,(%ebx)
8010386d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103870:	89 43 04             	mov    %eax,0x4(%ebx)
80103873:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103876:	89 43 08             	mov    %eax,0x8(%ebx)
80103879:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010387c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010387f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103882:	89 43 10             	mov    %eax,0x10(%ebx)
80103885:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103888:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
8010388b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80103892:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103895:	5b                   	pop    %ebx
80103896:	5e                   	pop    %esi
80103897:	5f                   	pop    %edi
80103898:	5d                   	pop    %ebp
80103899:	c3                   	ret
8010389a:	66 90                	xchg   %ax,%ax
8010389c:	66 90                	xchg   %ax,%ax
8010389e:	66 90                	xchg   %ax,%ax

801038a0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801038a0:	8b 0d 28 2d 11 80    	mov    0x80112d28,%ecx
801038a6:	85 c9                	test   %ecx,%ecx
801038a8:	0f 8e 8a 00 00 00    	jle    80103938 <install_trans+0x98>
{
801038ae:	55                   	push   %ebp
801038af:	89 e5                	mov    %esp,%ebp
801038b1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801038b2:	31 ff                	xor    %edi,%edi
{
801038b4:	56                   	push   %esi
801038b5:	53                   	push   %ebx
801038b6:	83 ec 0c             	sub    $0xc,%esp
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801038c0:	a1 14 2d 11 80       	mov    0x80112d14,%eax
801038c5:	83 ec 08             	sub    $0x8,%esp
801038c8:	01 f8                	add    %edi,%eax
801038ca:	83 c0 01             	add    $0x1,%eax
801038cd:	50                   	push   %eax
801038ce:	ff 35 24 2d 11 80    	push   0x80112d24
801038d4:	e8 f7 c7 ff ff       	call   801000d0 <bread>
801038d9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801038db:	58                   	pop    %eax
801038dc:	5a                   	pop    %edx
801038dd:	ff 34 bd 2c 2d 11 80 	push   -0x7feed2d4(,%edi,4)
801038e4:	ff 35 24 2d 11 80    	push   0x80112d24
  for (tail = 0; tail < log.lh.n; tail++) {
801038ea:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801038ed:	e8 de c7 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801038f2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801038f5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801038f7:	8d 46 5c             	lea    0x5c(%esi),%eax
801038fa:	68 00 02 00 00       	push   $0x200
801038ff:	50                   	push   %eax
80103900:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103903:	50                   	push   %eax
80103904:	e8 27 1b 00 00       	call   80105430 <memmove>
    bwrite(dbuf);  // write dst to disk
80103909:	89 1c 24             	mov    %ebx,(%esp)
8010390c:	e8 9f c8 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103911:	89 34 24             	mov    %esi,(%esp)
80103914:	e8 d7 c8 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103919:	89 1c 24             	mov    %ebx,(%esp)
8010391c:	e8 cf c8 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103921:	83 c4 10             	add    $0x10,%esp
80103924:	39 3d 28 2d 11 80    	cmp    %edi,0x80112d28
8010392a:	7f 94                	jg     801038c0 <install_trans+0x20>
  }
}
8010392c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010392f:	5b                   	pop    %ebx
80103930:	5e                   	pop    %esi
80103931:	5f                   	pop    %edi
80103932:	5d                   	pop    %ebp
80103933:	c3                   	ret
80103934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103938:	c3                   	ret
80103939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103940 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103947:	ff 35 14 2d 11 80    	push   0x80112d14
8010394d:	ff 35 24 2d 11 80    	push   0x80112d24
80103953:	e8 78 c7 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103958:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010395b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010395d:	a1 28 2d 11 80       	mov    0x80112d28,%eax
80103962:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103965:	85 c0                	test   %eax,%eax
80103967:	7e 19                	jle    80103982 <write_head+0x42>
80103969:	31 d2                	xor    %edx,%edx
8010396b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103970:	8b 0c 95 2c 2d 11 80 	mov    -0x7feed2d4(,%edx,4),%ecx
80103977:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010397b:	83 c2 01             	add    $0x1,%edx
8010397e:	39 d0                	cmp    %edx,%eax
80103980:	75 ee                	jne    80103970 <write_head+0x30>
  }
  bwrite(buf);
80103982:	83 ec 0c             	sub    $0xc,%esp
80103985:	53                   	push   %ebx
80103986:	e8 25 c8 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010398b:	89 1c 24             	mov    %ebx,(%esp)
8010398e:	e8 5d c8 ff ff       	call   801001f0 <brelse>
}
80103993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103996:	83 c4 10             	add    $0x10,%esp
80103999:	c9                   	leave
8010399a:	c3                   	ret
8010399b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039a0 <initlog>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 2c             	sub    $0x2c,%esp
801039a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801039aa:	68 5f 82 10 80       	push   $0x8010825f
801039af:	68 e0 2c 11 80       	push   $0x80112ce0
801039b4:	e8 f7 16 00 00       	call   801050b0 <initlock>
  readsb(dev, &sb);
801039b9:	58                   	pop    %eax
801039ba:	8d 45 dc             	lea    -0x24(%ebp),%eax
801039bd:	5a                   	pop    %edx
801039be:	50                   	push   %eax
801039bf:	53                   	push   %ebx
801039c0:	e8 7b e8 ff ff       	call   80102240 <readsb>
  log.start = sb.logstart;
801039c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801039c8:	59                   	pop    %ecx
  log.dev = dev;
801039c9:	89 1d 24 2d 11 80    	mov    %ebx,0x80112d24
  log.size = sb.nlog;
801039cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801039d2:	a3 14 2d 11 80       	mov    %eax,0x80112d14
  log.size = sb.nlog;
801039d7:	89 15 18 2d 11 80    	mov    %edx,0x80112d18
  struct buf *buf = bread(log.dev, log.start);
801039dd:	5a                   	pop    %edx
801039de:	50                   	push   %eax
801039df:	53                   	push   %ebx
801039e0:	e8 eb c6 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801039e5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801039e8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801039eb:	89 1d 28 2d 11 80    	mov    %ebx,0x80112d28
  for (i = 0; i < log.lh.n; i++) {
801039f1:	85 db                	test   %ebx,%ebx
801039f3:	7e 1d                	jle    80103a12 <initlog+0x72>
801039f5:	31 d2                	xor    %edx,%edx
801039f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039fe:	00 
801039ff:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103a00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a04:	89 0c 95 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103a0b:	83 c2 01             	add    $0x1,%edx
80103a0e:	39 d3                	cmp    %edx,%ebx
80103a10:	75 ee                	jne    80103a00 <initlog+0x60>
  brelse(buf);
80103a12:	83 ec 0c             	sub    $0xc,%esp
80103a15:	50                   	push   %eax
80103a16:	e8 d5 c7 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103a1b:	e8 80 fe ff ff       	call   801038a0 <install_trans>
  log.lh.n = 0;
80103a20:	c7 05 28 2d 11 80 00 	movl   $0x0,0x80112d28
80103a27:	00 00 00 
  write_head(); // clear the log
80103a2a:	e8 11 ff ff ff       	call   80103940 <write_head>
}
80103a2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a32:	83 c4 10             	add    $0x10,%esp
80103a35:	c9                   	leave
80103a36:	c3                   	ret
80103a37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a3e:	00 
80103a3f:	90                   	nop

80103a40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103a46:	68 e0 2c 11 80       	push   $0x80112ce0
80103a4b:	e8 50 18 00 00       	call   801052a0 <acquire>
80103a50:	83 c4 10             	add    $0x10,%esp
80103a53:	eb 18                	jmp    80103a6d <begin_op+0x2d>
80103a55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103a58:	83 ec 08             	sub    $0x8,%esp
80103a5b:	68 e0 2c 11 80       	push   $0x80112ce0
80103a60:	68 e0 2c 11 80       	push   $0x80112ce0
80103a65:	e8 b6 12 00 00       	call   80104d20 <sleep>
80103a6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103a6d:	a1 20 2d 11 80       	mov    0x80112d20,%eax
80103a72:	85 c0                	test   %eax,%eax
80103a74:	75 e2                	jne    80103a58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103a76:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
80103a7b:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
80103a81:	83 c0 01             	add    $0x1,%eax
80103a84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103a87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103a8a:	83 fa 1e             	cmp    $0x1e,%edx
80103a8d:	7f c9                	jg     80103a58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103a8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103a92:	a3 1c 2d 11 80       	mov    %eax,0x80112d1c
      release(&log.lock);
80103a97:	68 e0 2c 11 80       	push   $0x80112ce0
80103a9c:	e8 9f 17 00 00       	call   80105240 <release>
      break;
    }
  }
}
80103aa1:	83 c4 10             	add    $0x10,%esp
80103aa4:	c9                   	leave
80103aa5:	c3                   	ret
80103aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aad:	00 
80103aae:	66 90                	xchg   %ax,%ax

80103ab0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103ab9:	68 e0 2c 11 80       	push   $0x80112ce0
80103abe:	e8 dd 17 00 00       	call   801052a0 <acquire>
  log.outstanding -= 1;
80103ac3:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
  if(log.committing)
80103ac8:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
80103ace:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103ad1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103ad4:	89 1d 1c 2d 11 80    	mov    %ebx,0x80112d1c
  if(log.committing)
80103ada:	85 f6                	test   %esi,%esi
80103adc:	0f 85 22 01 00 00    	jne    80103c04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103ae2:	85 db                	test   %ebx,%ebx
80103ae4:	0f 85 f6 00 00 00    	jne    80103be0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103aea:	c7 05 20 2d 11 80 01 	movl   $0x1,0x80112d20
80103af1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103af4:	83 ec 0c             	sub    $0xc,%esp
80103af7:	68 e0 2c 11 80       	push   $0x80112ce0
80103afc:	e8 3f 17 00 00       	call   80105240 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103b01:	8b 0d 28 2d 11 80    	mov    0x80112d28,%ecx
80103b07:	83 c4 10             	add    $0x10,%esp
80103b0a:	85 c9                	test   %ecx,%ecx
80103b0c:	7f 42                	jg     80103b50 <end_op+0xa0>
    acquire(&log.lock);
80103b0e:	83 ec 0c             	sub    $0xc,%esp
80103b11:	68 e0 2c 11 80       	push   $0x80112ce0
80103b16:	e8 85 17 00 00       	call   801052a0 <acquire>
    log.committing = 0;
80103b1b:	c7 05 20 2d 11 80 00 	movl   $0x0,0x80112d20
80103b22:	00 00 00 
    wakeup(&log);
80103b25:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103b2c:	e8 af 12 00 00       	call   80104de0 <wakeup>
    release(&log.lock);
80103b31:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103b38:	e8 03 17 00 00       	call   80105240 <release>
80103b3d:	83 c4 10             	add    $0x10,%esp
}
80103b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b43:	5b                   	pop    %ebx
80103b44:	5e                   	pop    %esi
80103b45:	5f                   	pop    %edi
80103b46:	5d                   	pop    %ebp
80103b47:	c3                   	ret
80103b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b4f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103b50:	a1 14 2d 11 80       	mov    0x80112d14,%eax
80103b55:	83 ec 08             	sub    $0x8,%esp
80103b58:	01 d8                	add    %ebx,%eax
80103b5a:	83 c0 01             	add    $0x1,%eax
80103b5d:	50                   	push   %eax
80103b5e:	ff 35 24 2d 11 80    	push   0x80112d24
80103b64:	e8 67 c5 ff ff       	call   801000d0 <bread>
80103b69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103b6b:	58                   	pop    %eax
80103b6c:	5a                   	pop    %edx
80103b6d:	ff 34 9d 2c 2d 11 80 	push   -0x7feed2d4(,%ebx,4)
80103b74:	ff 35 24 2d 11 80    	push   0x80112d24
  for (tail = 0; tail < log.lh.n; tail++) {
80103b7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103b7d:	e8 4e c5 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103b82:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103b85:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103b87:	8d 40 5c             	lea    0x5c(%eax),%eax
80103b8a:	68 00 02 00 00       	push   $0x200
80103b8f:	50                   	push   %eax
80103b90:	8d 46 5c             	lea    0x5c(%esi),%eax
80103b93:	50                   	push   %eax
80103b94:	e8 97 18 00 00       	call   80105430 <memmove>
    bwrite(to);  // write the log
80103b99:	89 34 24             	mov    %esi,(%esp)
80103b9c:	e8 0f c6 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103ba1:	89 3c 24             	mov    %edi,(%esp)
80103ba4:	e8 47 c6 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103ba9:	89 34 24             	mov    %esi,(%esp)
80103bac:	e8 3f c6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103bb1:	83 c4 10             	add    $0x10,%esp
80103bb4:	3b 1d 28 2d 11 80    	cmp    0x80112d28,%ebx
80103bba:	7c 94                	jl     80103b50 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103bbc:	e8 7f fd ff ff       	call   80103940 <write_head>
    install_trans(); // Now install writes to home locations
80103bc1:	e8 da fc ff ff       	call   801038a0 <install_trans>
    log.lh.n = 0;
80103bc6:	c7 05 28 2d 11 80 00 	movl   $0x0,0x80112d28
80103bcd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103bd0:	e8 6b fd ff ff       	call   80103940 <write_head>
80103bd5:	e9 34 ff ff ff       	jmp    80103b0e <end_op+0x5e>
80103bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103be0:	83 ec 0c             	sub    $0xc,%esp
80103be3:	68 e0 2c 11 80       	push   $0x80112ce0
80103be8:	e8 f3 11 00 00       	call   80104de0 <wakeup>
  release(&log.lock);
80103bed:	c7 04 24 e0 2c 11 80 	movl   $0x80112ce0,(%esp)
80103bf4:	e8 47 16 00 00       	call   80105240 <release>
80103bf9:	83 c4 10             	add    $0x10,%esp
}
80103bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bff:	5b                   	pop    %ebx
80103c00:	5e                   	pop    %esi
80103c01:	5f                   	pop    %edi
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret
    panic("log.committing");
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	68 63 82 10 80       	push   $0x80108263
80103c0c:	e8 ff c8 ff ff       	call   80100510 <panic>
80103c11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c18:	00 
80103c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	53                   	push   %ebx
80103c24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c27:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
{
80103c2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c30:	83 fa 1d             	cmp    $0x1d,%edx
80103c33:	7f 7d                	jg     80103cb2 <log_write+0x92>
80103c35:	a1 18 2d 11 80       	mov    0x80112d18,%eax
80103c3a:	83 e8 01             	sub    $0x1,%eax
80103c3d:	39 c2                	cmp    %eax,%edx
80103c3f:	7d 71                	jge    80103cb2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103c41:	a1 1c 2d 11 80       	mov    0x80112d1c,%eax
80103c46:	85 c0                	test   %eax,%eax
80103c48:	7e 75                	jle    80103cbf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103c4a:	83 ec 0c             	sub    $0xc,%esp
80103c4d:	68 e0 2c 11 80       	push   $0x80112ce0
80103c52:	e8 49 16 00 00       	call   801052a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103c57:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103c5a:	83 c4 10             	add    $0x10,%esp
80103c5d:	31 c0                	xor    %eax,%eax
80103c5f:	8b 15 28 2d 11 80    	mov    0x80112d28,%edx
80103c65:	85 d2                	test   %edx,%edx
80103c67:	7f 0e                	jg     80103c77 <log_write+0x57>
80103c69:	eb 15                	jmp    80103c80 <log_write+0x60>
80103c6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c70:	83 c0 01             	add    $0x1,%eax
80103c73:	39 c2                	cmp    %eax,%edx
80103c75:	74 29                	je     80103ca0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103c77:	39 0c 85 2c 2d 11 80 	cmp    %ecx,-0x7feed2d4(,%eax,4)
80103c7e:	75 f0                	jne    80103c70 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103c80:	89 0c 85 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%eax,4)
  if (i == log.lh.n)
80103c87:	39 c2                	cmp    %eax,%edx
80103c89:	74 1c                	je     80103ca7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103c8b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103c8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103c91:	c7 45 08 e0 2c 11 80 	movl   $0x80112ce0,0x8(%ebp)
}
80103c98:	c9                   	leave
  release(&log.lock);
80103c99:	e9 a2 15 00 00       	jmp    80105240 <release>
80103c9e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103ca0:	89 0c 95 2c 2d 11 80 	mov    %ecx,-0x7feed2d4(,%edx,4)
    log.lh.n++;
80103ca7:	83 c2 01             	add    $0x1,%edx
80103caa:	89 15 28 2d 11 80    	mov    %edx,0x80112d28
80103cb0:	eb d9                	jmp    80103c8b <log_write+0x6b>
    panic("too big a transaction");
80103cb2:	83 ec 0c             	sub    $0xc,%esp
80103cb5:	68 72 82 10 80       	push   $0x80108272
80103cba:	e8 51 c8 ff ff       	call   80100510 <panic>
    panic("log_write outside of trans");
80103cbf:	83 ec 0c             	sub    $0xc,%esp
80103cc2:	68 88 82 10 80       	push   $0x80108288
80103cc7:	e8 44 c8 ff ff       	call   80100510 <panic>
80103ccc:	66 90                	xchg   %ax,%ax
80103cce:	66 90                	xchg   %ax,%ax

80103cd0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	53                   	push   %ebx
80103cd4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103cd7:	e8 64 09 00 00       	call   80104640 <cpuid>
80103cdc:	89 c3                	mov    %eax,%ebx
80103cde:	e8 5d 09 00 00       	call   80104640 <cpuid>
80103ce3:	83 ec 04             	sub    $0x4,%esp
80103ce6:	53                   	push   %ebx
80103ce7:	50                   	push   %eax
80103ce8:	68 a3 82 10 80       	push   $0x801082a3
80103ced:	e8 9e cd ff ff       	call   80100a90 <cprintf>
  idtinit();       // load idt register
80103cf2:	e8 d9 2a 00 00       	call   801067d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103cf7:	e8 e4 08 00 00       	call   801045e0 <mycpu>
80103cfc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103cfe:	b8 01 00 00 00       	mov    $0x1,%eax
80103d03:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103d0a:	e8 01 0c 00 00       	call   80104910 <scheduler>
80103d0f:	90                   	nop

80103d10 <mpenter>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103d16:	e8 a5 3b 00 00       	call   801078c0 <switchkvm>
  seginit();
80103d1b:	e8 10 3b 00 00       	call   80107830 <seginit>
  lapicinit();
80103d20:	e8 bb f7 ff ff       	call   801034e0 <lapicinit>
  mpmain();
80103d25:	e8 a6 ff ff ff       	call   80103cd0 <mpmain>
80103d2a:	66 90                	xchg   %ax,%ax
80103d2c:	66 90                	xchg   %ax,%ax
80103d2e:	66 90                	xchg   %ax,%ax

80103d30 <main>:
{
80103d30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103d34:	83 e4 f0             	and    $0xfffffff0,%esp
80103d37:	ff 71 fc             	push   -0x4(%ecx)
80103d3a:	55                   	push   %ebp
80103d3b:	89 e5                	mov    %esp,%ebp
80103d3d:	53                   	push   %ebx
80103d3e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103d3f:	83 ec 08             	sub    $0x8,%esp
80103d42:	68 00 00 40 80       	push   $0x80400000
80103d47:	68 10 6b 11 80       	push   $0x80116b10
80103d4c:	e8 9f f5 ff ff       	call   801032f0 <kinit1>
  kvmalloc();      // kernel page table
80103d51:	e8 5a 40 00 00       	call   80107db0 <kvmalloc>
  mpinit();        // detect other processors
80103d56:	e8 85 01 00 00       	call   80103ee0 <mpinit>
  lapicinit();     // interrupt controller
80103d5b:	e8 80 f7 ff ff       	call   801034e0 <lapicinit>
  seginit();       // segment descriptors
80103d60:	e8 cb 3a 00 00       	call   80107830 <seginit>
  picinit();       // disable pic
80103d65:	e8 86 03 00 00       	call   801040f0 <picinit>
  ioapicinit();    // another interrupt controller
80103d6a:	e8 51 f3 ff ff       	call   801030c0 <ioapicinit>
  consoleinit();   // console hardware
80103d6f:	e8 ec d9 ff ff       	call   80101760 <consoleinit>
  uartinit();      // serial port
80103d74:	e8 37 2d 00 00       	call   80106ab0 <uartinit>
  pinit();         // process table
80103d79:	e8 42 08 00 00       	call   801045c0 <pinit>
  tvinit();        // trap vectors
80103d7e:	e8 cd 29 00 00       	call   80106750 <tvinit>
  binit();         // buffer cache
80103d83:	e8 b8 c2 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103d88:	e8 a3 dd ff ff       	call   80101b30 <fileinit>
  ideinit();       // disk 
80103d8d:	e8 0e f1 ff ff       	call   80102ea0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103d92:	83 c4 0c             	add    $0xc,%esp
80103d95:	68 8a 00 00 00       	push   $0x8a
80103d9a:	68 8c b4 10 80       	push   $0x8010b48c
80103d9f:	68 00 70 00 80       	push   $0x80007000
80103da4:	e8 87 16 00 00       	call   80105430 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103da9:	83 c4 10             	add    $0x10,%esp
80103dac:	69 05 c4 2d 11 80 b0 	imul   $0xb0,0x80112dc4,%eax
80103db3:	00 00 00 
80103db6:	05 e0 2d 11 80       	add    $0x80112de0,%eax
80103dbb:	3d e0 2d 11 80       	cmp    $0x80112de0,%eax
80103dc0:	76 7e                	jbe    80103e40 <main+0x110>
80103dc2:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80103dc7:	eb 20                	jmp    80103de9 <main+0xb9>
80103dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dd0:	69 05 c4 2d 11 80 b0 	imul   $0xb0,0x80112dc4,%eax
80103dd7:	00 00 00 
80103dda:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103de0:	05 e0 2d 11 80       	add    $0x80112de0,%eax
80103de5:	39 c3                	cmp    %eax,%ebx
80103de7:	73 57                	jae    80103e40 <main+0x110>
    if(c == mycpu())  // We've started already.
80103de9:	e8 f2 07 00 00       	call   801045e0 <mycpu>
80103dee:	39 c3                	cmp    %eax,%ebx
80103df0:	74 de                	je     80103dd0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103df2:	e8 69 f5 ff ff       	call   80103360 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103df7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103dfa:	c7 05 f8 6f 00 80 10 	movl   $0x80103d10,0x80006ff8
80103e01:	3d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103e04:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103e0b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e0e:	05 00 10 00 00       	add    $0x1000,%eax
80103e13:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103e18:	0f b6 03             	movzbl (%ebx),%eax
80103e1b:	68 00 70 00 00       	push   $0x7000
80103e20:	50                   	push   %eax
80103e21:	e8 fa f7 ff ff       	call   80103620 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e26:	83 c4 10             	add    $0x10,%esp
80103e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103e36:	85 c0                	test   %eax,%eax
80103e38:	74 f6                	je     80103e30 <main+0x100>
80103e3a:	eb 94                	jmp    80103dd0 <main+0xa0>
80103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103e40:	83 ec 08             	sub    $0x8,%esp
80103e43:	68 00 00 00 8e       	push   $0x8e000000
80103e48:	68 00 00 40 80       	push   $0x80400000
80103e4d:	e8 3e f4 ff ff       	call   80103290 <kinit2>
  userinit();      // first user process
80103e52:	e8 39 08 00 00       	call   80104690 <userinit>
  mpmain();        // finish this processor's setup
80103e57:	e8 74 fe ff ff       	call   80103cd0 <mpmain>
80103e5c:	66 90                	xchg   %ax,%ax
80103e5e:	66 90                	xchg   %ax,%ax

80103e60 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103e65:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103e6b:	53                   	push   %ebx
  e = addr+len;
80103e6c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103e6f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103e72:	39 de                	cmp    %ebx,%esi
80103e74:	72 10                	jb     80103e86 <mpsearch1+0x26>
80103e76:	eb 50                	jmp    80103ec8 <mpsearch1+0x68>
80103e78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e7f:	00 
80103e80:	89 fe                	mov    %edi,%esi
80103e82:	39 df                	cmp    %ebx,%edi
80103e84:	73 42                	jae    80103ec8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103e86:	83 ec 04             	sub    $0x4,%esp
80103e89:	8d 7e 10             	lea    0x10(%esi),%edi
80103e8c:	6a 04                	push   $0x4
80103e8e:	68 b7 82 10 80       	push   $0x801082b7
80103e93:	56                   	push   %esi
80103e94:	e8 47 15 00 00       	call   801053e0 <memcmp>
80103e99:	83 c4 10             	add    $0x10,%esp
80103e9c:	85 c0                	test   %eax,%eax
80103e9e:	75 e0                	jne    80103e80 <mpsearch1+0x20>
80103ea0:	89 f2                	mov    %esi,%edx
80103ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103ea8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103eab:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103eae:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103eb0:	39 fa                	cmp    %edi,%edx
80103eb2:	75 f4                	jne    80103ea8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103eb4:	84 c0                	test   %al,%al
80103eb6:	75 c8                	jne    80103e80 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ebb:	89 f0                	mov    %esi,%eax
80103ebd:	5b                   	pop    %ebx
80103ebe:	5e                   	pop    %esi
80103ebf:	5f                   	pop    %edi
80103ec0:	5d                   	pop    %ebp
80103ec1:	c3                   	ret
80103ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103ecb:	31 f6                	xor    %esi,%esi
}
80103ecd:	5b                   	pop    %ebx
80103ece:	89 f0                	mov    %esi,%eax
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret
80103ed4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103edb:	00 
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ee0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
80103ee5:	53                   	push   %ebx
80103ee6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103ee9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103ef0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103ef7:	c1 e0 08             	shl    $0x8,%eax
80103efa:	09 d0                	or     %edx,%eax
80103efc:	c1 e0 04             	shl    $0x4,%eax
80103eff:	75 1b                	jne    80103f1c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103f01:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f08:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f0f:	c1 e0 08             	shl    $0x8,%eax
80103f12:	09 d0                	or     %edx,%eax
80103f14:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103f17:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103f1c:	ba 00 04 00 00       	mov    $0x400,%edx
80103f21:	e8 3a ff ff ff       	call   80103e60 <mpsearch1>
80103f26:	89 c3                	mov    %eax,%ebx
80103f28:	85 c0                	test   %eax,%eax
80103f2a:	0f 84 58 01 00 00    	je     80104088 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f30:	8b 73 04             	mov    0x4(%ebx),%esi
80103f33:	85 f6                	test   %esi,%esi
80103f35:	0f 84 3d 01 00 00    	je     80104078 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
80103f3b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103f3e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103f44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103f47:	6a 04                	push   $0x4
80103f49:	68 bc 82 10 80       	push   $0x801082bc
80103f4e:	50                   	push   %eax
80103f4f:	e8 8c 14 00 00       	call   801053e0 <memcmp>
80103f54:	83 c4 10             	add    $0x10,%esp
80103f57:	85 c0                	test   %eax,%eax
80103f59:	0f 85 19 01 00 00    	jne    80104078 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
80103f5f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103f66:	3c 01                	cmp    $0x1,%al
80103f68:	74 08                	je     80103f72 <mpinit+0x92>
80103f6a:	3c 04                	cmp    $0x4,%al
80103f6c:	0f 85 06 01 00 00    	jne    80104078 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103f72:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103f79:	66 85 d2             	test   %dx,%dx
80103f7c:	74 22                	je     80103fa0 <mpinit+0xc0>
80103f7e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103f81:	89 f0                	mov    %esi,%eax
  sum = 0;
80103f83:	31 d2                	xor    %edx,%edx
80103f85:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103f88:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103f8f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103f92:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103f94:	39 f8                	cmp    %edi,%eax
80103f96:	75 f0                	jne    80103f88 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103f98:	84 d2                	test   %dl,%dl
80103f9a:	0f 85 d8 00 00 00    	jne    80104078 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103fa0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fa6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103fa9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103fac:	a3 c0 2c 11 80       	mov    %eax,0x80112cc0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fb1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103fb8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103fbe:	01 d7                	add    %edx,%edi
80103fc0:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103fc2:	bf 01 00 00 00       	mov    $0x1,%edi
80103fc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fce:	00 
80103fcf:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fd0:	39 d0                	cmp    %edx,%eax
80103fd2:	73 19                	jae    80103fed <mpinit+0x10d>
    switch(*p){
80103fd4:	0f b6 08             	movzbl (%eax),%ecx
80103fd7:	80 f9 02             	cmp    $0x2,%cl
80103fda:	0f 84 80 00 00 00    	je     80104060 <mpinit+0x180>
80103fe0:	77 6e                	ja     80104050 <mpinit+0x170>
80103fe2:	84 c9                	test   %cl,%cl
80103fe4:	74 3a                	je     80104020 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103fe6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fe9:	39 d0                	cmp    %edx,%eax
80103feb:	72 e7                	jb     80103fd4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103fed:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ff0:	85 ff                	test   %edi,%edi
80103ff2:	0f 84 dd 00 00 00    	je     801040d5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103ff8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103ffc:	74 15                	je     80104013 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ffe:	b8 70 00 00 00       	mov    $0x70,%eax
80104003:	ba 22 00 00 00       	mov    $0x22,%edx
80104008:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104009:	ba 23 00 00 00       	mov    $0x23,%edx
8010400e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010400f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104012:	ee                   	out    %al,(%dx)
  }
}
80104013:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104016:	5b                   	pop    %ebx
80104017:	5e                   	pop    %esi
80104018:	5f                   	pop    %edi
80104019:	5d                   	pop    %ebp
8010401a:	c3                   	ret
8010401b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80104020:	8b 0d c4 2d 11 80    	mov    0x80112dc4,%ecx
80104026:	83 f9 07             	cmp    $0x7,%ecx
80104029:	7f 19                	jg     80104044 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010402b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80104031:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104035:	83 c1 01             	add    $0x1,%ecx
80104038:	89 0d c4 2d 11 80    	mov    %ecx,0x80112dc4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010403e:	88 9e e0 2d 11 80    	mov    %bl,-0x7feed220(%esi)
      p += sizeof(struct mpproc);
80104044:	83 c0 14             	add    $0x14,%eax
      continue;
80104047:	eb 87                	jmp    80103fd0 <mpinit+0xf0>
80104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80104050:	83 e9 03             	sub    $0x3,%ecx
80104053:	80 f9 01             	cmp    $0x1,%cl
80104056:	76 8e                	jbe    80103fe6 <mpinit+0x106>
80104058:	31 ff                	xor    %edi,%edi
8010405a:	e9 71 ff ff ff       	jmp    80103fd0 <mpinit+0xf0>
8010405f:	90                   	nop
      ioapicid = ioapic->apicno;
80104060:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104064:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104067:	88 0d c0 2d 11 80    	mov    %cl,0x80112dc0
      continue;
8010406d:	e9 5e ff ff ff       	jmp    80103fd0 <mpinit+0xf0>
80104072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	68 c1 82 10 80       	push   $0x801082c1
80104080:	e8 8b c4 ff ff       	call   80100510 <panic>
80104085:	8d 76 00             	lea    0x0(%esi),%esi
{
80104088:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010408d:	eb 0b                	jmp    8010409a <mpinit+0x1ba>
8010408f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80104090:	89 f3                	mov    %esi,%ebx
80104092:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104098:	74 de                	je     80104078 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010409a:	83 ec 04             	sub    $0x4,%esp
8010409d:	8d 73 10             	lea    0x10(%ebx),%esi
801040a0:	6a 04                	push   $0x4
801040a2:	68 b7 82 10 80       	push   $0x801082b7
801040a7:	53                   	push   %ebx
801040a8:	e8 33 13 00 00       	call   801053e0 <memcmp>
801040ad:	83 c4 10             	add    $0x10,%esp
801040b0:	85 c0                	test   %eax,%eax
801040b2:	75 dc                	jne    80104090 <mpinit+0x1b0>
801040b4:	89 da                	mov    %ebx,%edx
801040b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040bd:	00 
801040be:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801040c0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801040c3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801040c6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801040c8:	39 d6                	cmp    %edx,%esi
801040ca:	75 f4                	jne    801040c0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801040cc:	84 c0                	test   %al,%al
801040ce:	75 c0                	jne    80104090 <mpinit+0x1b0>
801040d0:	e9 5b fe ff ff       	jmp    80103f30 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801040d5:	83 ec 0c             	sub    $0xc,%esp
801040d8:	68 98 86 10 80       	push   $0x80108698
801040dd:	e8 2e c4 ff ff       	call   80100510 <panic>
801040e2:	66 90                	xchg   %ax,%ax
801040e4:	66 90                	xchg   %ax,%ax
801040e6:	66 90                	xchg   %ax,%ax
801040e8:	66 90                	xchg   %ax,%ax
801040ea:	66 90                	xchg   %ax,%ax
801040ec:	66 90                	xchg   %ax,%ax
801040ee:	66 90                	xchg   %ax,%ax

801040f0 <picinit>:
801040f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040f5:	ba 21 00 00 00       	mov    $0x21,%edx
801040fa:	ee                   	out    %al,(%dx)
801040fb:	ba a1 00 00 00       	mov    $0xa1,%edx
80104100:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104101:	c3                   	ret
80104102:	66 90                	xchg   %ax,%ax
80104104:	66 90                	xchg   %ax,%ax
80104106:	66 90                	xchg   %ax,%ax
80104108:	66 90                	xchg   %ax,%ax
8010410a:	66 90                	xchg   %ax,%ax
8010410c:	66 90                	xchg   %ax,%ax
8010410e:	66 90                	xchg   %ax,%ax

80104110 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	83 ec 0c             	sub    $0xc,%esp
80104119:	8b 75 08             	mov    0x8(%ebp),%esi
8010411c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010411f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80104125:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010412b:	e8 20 da ff ff       	call   80101b50 <filealloc>
80104130:	89 06                	mov    %eax,(%esi)
80104132:	85 c0                	test   %eax,%eax
80104134:	0f 84 a5 00 00 00    	je     801041df <pipealloc+0xcf>
8010413a:	e8 11 da ff ff       	call   80101b50 <filealloc>
8010413f:	89 07                	mov    %eax,(%edi)
80104141:	85 c0                	test   %eax,%eax
80104143:	0f 84 84 00 00 00    	je     801041cd <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104149:	e8 12 f2 ff ff       	call   80103360 <kalloc>
8010414e:	89 c3                	mov    %eax,%ebx
80104150:	85 c0                	test   %eax,%eax
80104152:	0f 84 a0 00 00 00    	je     801041f8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80104158:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010415f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104162:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104165:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010416c:	00 00 00 
  p->nwrite = 0;
8010416f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104176:	00 00 00 
  p->nread = 0;
80104179:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104180:	00 00 00 
  initlock(&p->lock, "pipe");
80104183:	68 d9 82 10 80       	push   $0x801082d9
80104188:	50                   	push   %eax
80104189:	e8 22 0f 00 00       	call   801050b0 <initlock>
  (*f0)->type = FD_PIPE;
8010418e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104190:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104193:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104199:	8b 06                	mov    (%esi),%eax
8010419b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010419f:	8b 06                	mov    (%esi),%eax
801041a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801041a5:	8b 06                	mov    (%esi),%eax
801041a7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801041aa:	8b 07                	mov    (%edi),%eax
801041ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801041b2:	8b 07                	mov    (%edi),%eax
801041b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801041b8:	8b 07                	mov    (%edi),%eax
801041ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801041be:	8b 07                	mov    (%edi),%eax
801041c0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801041c3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801041c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c8:	5b                   	pop    %ebx
801041c9:	5e                   	pop    %esi
801041ca:	5f                   	pop    %edi
801041cb:	5d                   	pop    %ebp
801041cc:	c3                   	ret
  if(*f0)
801041cd:	8b 06                	mov    (%esi),%eax
801041cf:	85 c0                	test   %eax,%eax
801041d1:	74 1e                	je     801041f1 <pipealloc+0xe1>
    fileclose(*f0);
801041d3:	83 ec 0c             	sub    $0xc,%esp
801041d6:	50                   	push   %eax
801041d7:	e8 34 da ff ff       	call   80101c10 <fileclose>
801041dc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801041df:	8b 07                	mov    (%edi),%eax
801041e1:	85 c0                	test   %eax,%eax
801041e3:	74 0c                	je     801041f1 <pipealloc+0xe1>
    fileclose(*f1);
801041e5:	83 ec 0c             	sub    $0xc,%esp
801041e8:	50                   	push   %eax
801041e9:	e8 22 da ff ff       	call   80101c10 <fileclose>
801041ee:	83 c4 10             	add    $0x10,%esp
  return -1;
801041f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041f6:	eb cd                	jmp    801041c5 <pipealloc+0xb5>
  if(*f0)
801041f8:	8b 06                	mov    (%esi),%eax
801041fa:	85 c0                	test   %eax,%eax
801041fc:	75 d5                	jne    801041d3 <pipealloc+0xc3>
801041fe:	eb df                	jmp    801041df <pipealloc+0xcf>

80104200 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104208:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010420b:	83 ec 0c             	sub    $0xc,%esp
8010420e:	53                   	push   %ebx
8010420f:	e8 8c 10 00 00       	call   801052a0 <acquire>
  if(writable){
80104214:	83 c4 10             	add    $0x10,%esp
80104217:	85 f6                	test   %esi,%esi
80104219:	74 65                	je     80104280 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010421b:	83 ec 0c             	sub    $0xc,%esp
8010421e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104224:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010422b:	00 00 00 
    wakeup(&p->nread);
8010422e:	50                   	push   %eax
8010422f:	e8 ac 0b 00 00       	call   80104de0 <wakeup>
80104234:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104237:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010423d:	85 d2                	test   %edx,%edx
8010423f:	75 0a                	jne    8010424b <pipeclose+0x4b>
80104241:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104247:	85 c0                	test   %eax,%eax
80104249:	74 15                	je     80104260 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010424b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010424e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104251:	5b                   	pop    %ebx
80104252:	5e                   	pop    %esi
80104253:	5d                   	pop    %ebp
    release(&p->lock);
80104254:	e9 e7 0f 00 00       	jmp    80105240 <release>
80104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104260:	83 ec 0c             	sub    $0xc,%esp
80104263:	53                   	push   %ebx
80104264:	e8 d7 0f 00 00       	call   80105240 <release>
    kfree((char*)p);
80104269:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010426c:	83 c4 10             	add    $0x10,%esp
}
8010426f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104272:	5b                   	pop    %ebx
80104273:	5e                   	pop    %esi
80104274:	5d                   	pop    %ebp
    kfree((char*)p);
80104275:	e9 26 ef ff ff       	jmp    801031a0 <kfree>
8010427a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104280:	83 ec 0c             	sub    $0xc,%esp
80104283:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104289:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104290:	00 00 00 
    wakeup(&p->nwrite);
80104293:	50                   	push   %eax
80104294:	e8 47 0b 00 00       	call   80104de0 <wakeup>
80104299:	83 c4 10             	add    $0x10,%esp
8010429c:	eb 99                	jmp    80104237 <pipeclose+0x37>
8010429e:	66 90                	xchg   %ax,%ax

801042a0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	83 ec 28             	sub    $0x28,%esp
801042a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042ac:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801042af:	53                   	push   %ebx
801042b0:	e8 eb 0f 00 00       	call   801052a0 <acquire>
  for(i = 0; i < n; i++){
801042b5:	83 c4 10             	add    $0x10,%esp
801042b8:	85 ff                	test   %edi,%edi
801042ba:	0f 8e ce 00 00 00    	jle    8010438e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042c0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801042c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801042c9:	89 7d 10             	mov    %edi,0x10(%ebp)
801042cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042cf:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801042d2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801042d5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042db:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801042e1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042e7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801042ed:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801042f0:	0f 85 b6 00 00 00    	jne    801043ac <pipewrite+0x10c>
801042f6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801042f9:	eb 3b                	jmp    80104336 <pipewrite+0x96>
801042fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104300:	e8 5b 03 00 00       	call   80104660 <myproc>
80104305:	8b 48 24             	mov    0x24(%eax),%ecx
80104308:	85 c9                	test   %ecx,%ecx
8010430a:	75 34                	jne    80104340 <pipewrite+0xa0>
      wakeup(&p->nread);
8010430c:	83 ec 0c             	sub    $0xc,%esp
8010430f:	56                   	push   %esi
80104310:	e8 cb 0a 00 00       	call   80104de0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104315:	58                   	pop    %eax
80104316:	5a                   	pop    %edx
80104317:	53                   	push   %ebx
80104318:	57                   	push   %edi
80104319:	e8 02 0a 00 00       	call   80104d20 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010431e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104324:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010432a:	83 c4 10             	add    $0x10,%esp
8010432d:	05 00 02 00 00       	add    $0x200,%eax
80104332:	39 c2                	cmp    %eax,%edx
80104334:	75 2a                	jne    80104360 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80104336:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010433c:	85 c0                	test   %eax,%eax
8010433e:	75 c0                	jne    80104300 <pipewrite+0x60>
        release(&p->lock);
80104340:	83 ec 0c             	sub    $0xc,%esp
80104343:	53                   	push   %ebx
80104344:	e8 f7 0e 00 00       	call   80105240 <release>
        return -1;
80104349:	83 c4 10             	add    $0x10,%esp
8010434c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104354:	5b                   	pop    %ebx
80104355:	5e                   	pop    %esi
80104356:	5f                   	pop    %edi
80104357:	5d                   	pop    %ebp
80104358:	c3                   	ret
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104360:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104363:	8d 42 01             	lea    0x1(%edx),%eax
80104366:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010436c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010436f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104375:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104378:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010437c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104380:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104383:	39 c1                	cmp    %eax,%ecx
80104385:	0f 85 50 ff ff ff    	jne    801042db <pipewrite+0x3b>
8010438b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010438e:	83 ec 0c             	sub    $0xc,%esp
80104391:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104397:	50                   	push   %eax
80104398:	e8 43 0a 00 00       	call   80104de0 <wakeup>
  release(&p->lock);
8010439d:	89 1c 24             	mov    %ebx,(%esp)
801043a0:	e8 9b 0e 00 00       	call   80105240 <release>
  return n;
801043a5:	83 c4 10             	add    $0x10,%esp
801043a8:	89 f8                	mov    %edi,%eax
801043aa:	eb a5                	jmp    80104351 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043af:	eb b2                	jmp    80104363 <pipewrite+0xc3>
801043b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043b8:	00 
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	83 ec 18             	sub    $0x18,%esp
801043c9:	8b 75 08             	mov    0x8(%ebp),%esi
801043cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801043cf:	56                   	push   %esi
801043d0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801043d6:	e8 c5 0e 00 00       	call   801052a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801043db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801043e1:	83 c4 10             	add    $0x10,%esp
801043e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801043ea:	74 2f                	je     8010441b <piperead+0x5b>
801043ec:	eb 37                	jmp    80104425 <piperead+0x65>
801043ee:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801043f0:	e8 6b 02 00 00       	call   80104660 <myproc>
801043f5:	8b 40 24             	mov    0x24(%eax),%eax
801043f8:	85 c0                	test   %eax,%eax
801043fa:	0f 85 80 00 00 00    	jne    80104480 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	e8 16 09 00 00       	call   80104d20 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010440a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104410:	83 c4 10             	add    $0x10,%esp
80104413:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104419:	75 0a                	jne    80104425 <piperead+0x65>
8010441b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80104421:	85 d2                	test   %edx,%edx
80104423:	75 cb                	jne    801043f0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104425:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104428:	31 db                	xor    %ebx,%ebx
8010442a:	85 c9                	test   %ecx,%ecx
8010442c:	7f 26                	jg     80104454 <piperead+0x94>
8010442e:	eb 2c                	jmp    8010445c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104430:	8d 48 01             	lea    0x1(%eax),%ecx
80104433:	25 ff 01 00 00       	and    $0x1ff,%eax
80104438:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010443e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104443:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104446:	83 c3 01             	add    $0x1,%ebx
80104449:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010444c:	74 0e                	je     8010445c <piperead+0x9c>
8010444e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80104454:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010445a:	75 d4                	jne    80104430 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010445c:	83 ec 0c             	sub    $0xc,%esp
8010445f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104465:	50                   	push   %eax
80104466:	e8 75 09 00 00       	call   80104de0 <wakeup>
  release(&p->lock);
8010446b:	89 34 24             	mov    %esi,(%esp)
8010446e:	e8 cd 0d 00 00       	call   80105240 <release>
  return i;
80104473:	83 c4 10             	add    $0x10,%esp
}
80104476:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104479:	89 d8                	mov    %ebx,%eax
8010447b:	5b                   	pop    %ebx
8010447c:	5e                   	pop    %esi
8010447d:	5f                   	pop    %edi
8010447e:	5d                   	pop    %ebp
8010447f:	c3                   	ret
      release(&p->lock);
80104480:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104483:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104488:	56                   	push   %esi
80104489:	e8 b2 0d 00 00       	call   80105240 <release>
      return -1;
8010448e:	83 c4 10             	add    $0x10,%esp
}
80104491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104494:	89 d8                	mov    %ebx,%eax
80104496:	5b                   	pop    %ebx
80104497:	5e                   	pop    %esi
80104498:	5f                   	pop    %edi
80104499:	5d                   	pop    %ebp
8010449a:	c3                   	ret
8010449b:	66 90                	xchg   %ax,%ax
8010449d:	66 90                	xchg   %ax,%ax
8010449f:	90                   	nop

801044a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a4:	bb 94 33 11 80       	mov    $0x80113394,%ebx
{
801044a9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801044ac:	68 60 33 11 80       	push   $0x80113360
801044b1:	e8 ea 0d 00 00       	call   801052a0 <acquire>
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	eb 10                	jmp    801044cb <allocproc+0x2b>
801044bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044c0:	83 c3 7c             	add    $0x7c,%ebx
801044c3:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
801044c9:	74 75                	je     80104540 <allocproc+0xa0>
    if(p->state == UNUSED)
801044cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801044ce:	85 c0                	test   %eax,%eax
801044d0:	75 ee                	jne    801044c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801044d2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801044d7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801044da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801044e1:	89 43 10             	mov    %eax,0x10(%ebx)
801044e4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801044e7:	68 60 33 11 80       	push   $0x80113360
  p->pid = nextpid++;
801044ec:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801044f2:	e8 49 0d 00 00       	call   80105240 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801044f7:	e8 64 ee ff ff       	call   80103360 <kalloc>
801044fc:	83 c4 10             	add    $0x10,%esp
801044ff:	89 43 08             	mov    %eax,0x8(%ebx)
80104502:	85 c0                	test   %eax,%eax
80104504:	74 53                	je     80104559 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104506:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010450c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010450f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80104514:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104517:	c7 40 14 42 67 10 80 	movl   $0x80106742,0x14(%eax)
  p->context = (struct context*)sp;
8010451e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104521:	6a 14                	push   $0x14
80104523:	6a 00                	push   $0x0
80104525:	50                   	push   %eax
80104526:	e8 75 0e 00 00       	call   801053a0 <memset>
  p->context->eip = (uint)forkret;
8010452b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010452e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104531:	c7 40 10 70 45 10 80 	movl   $0x80104570,0x10(%eax)
}
80104538:	89 d8                	mov    %ebx,%eax
8010453a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010453d:	c9                   	leave
8010453e:	c3                   	ret
8010453f:	90                   	nop
  release(&ptable.lock);
80104540:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104543:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104545:	68 60 33 11 80       	push   $0x80113360
8010454a:	e8 f1 0c 00 00       	call   80105240 <release>
  return 0;
8010454f:	83 c4 10             	add    $0x10,%esp
}
80104552:	89 d8                	mov    %ebx,%eax
80104554:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104557:	c9                   	leave
80104558:	c3                   	ret
    p->state = UNUSED;
80104559:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80104560:	31 db                	xor    %ebx,%ebx
80104562:	eb ee                	jmp    80104552 <allocproc+0xb2>
80104564:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010456b:	00 
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104570 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104576:	68 60 33 11 80       	push   $0x80113360
8010457b:	e8 c0 0c 00 00       	call   80105240 <release>

  if (first) {
80104580:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104585:	83 c4 10             	add    $0x10,%esp
80104588:	85 c0                	test   %eax,%eax
8010458a:	75 04                	jne    80104590 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010458c:	c9                   	leave
8010458d:	c3                   	ret
8010458e:	66 90                	xchg   %ax,%ax
    first = 0;
80104590:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104597:	00 00 00 
    iinit(ROOTDEV);
8010459a:	83 ec 0c             	sub    $0xc,%esp
8010459d:	6a 01                	push   $0x1
8010459f:	e8 dc dc ff ff       	call   80102280 <iinit>
    initlog(ROOTDEV);
801045a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801045ab:	e8 f0 f3 ff ff       	call   801039a0 <initlog>
}
801045b0:	83 c4 10             	add    $0x10,%esp
801045b3:	c9                   	leave
801045b4:	c3                   	ret
801045b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045bc:	00 
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <pinit>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801045c6:	68 de 82 10 80       	push   $0x801082de
801045cb:	68 60 33 11 80       	push   $0x80113360
801045d0:	e8 db 0a 00 00       	call   801050b0 <initlock>
}
801045d5:	83 c4 10             	add    $0x10,%esp
801045d8:	c9                   	leave
801045d9:	c3                   	ret
801045da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045e0 <mycpu>:
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045e5:	9c                   	pushf
801045e6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045e7:	f6 c4 02             	test   $0x2,%ah
801045ea:	75 46                	jne    80104632 <mycpu+0x52>
  apicid = lapicid();
801045ec:	e8 df ef ff ff       	call   801035d0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801045f1:	8b 35 c4 2d 11 80    	mov    0x80112dc4,%esi
801045f7:	85 f6                	test   %esi,%esi
801045f9:	7e 2a                	jle    80104625 <mycpu+0x45>
801045fb:	31 d2                	xor    %edx,%edx
801045fd:	eb 08                	jmp    80104607 <mycpu+0x27>
801045ff:	90                   	nop
80104600:	83 c2 01             	add    $0x1,%edx
80104603:	39 f2                	cmp    %esi,%edx
80104605:	74 1e                	je     80104625 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104607:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010460d:	0f b6 99 e0 2d 11 80 	movzbl -0x7feed220(%ecx),%ebx
80104614:	39 c3                	cmp    %eax,%ebx
80104616:	75 e8                	jne    80104600 <mycpu+0x20>
}
80104618:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010461b:	8d 81 e0 2d 11 80    	lea    -0x7feed220(%ecx),%eax
}
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5d                   	pop    %ebp
80104624:	c3                   	ret
  panic("unknown apicid\n");
80104625:	83 ec 0c             	sub    $0xc,%esp
80104628:	68 e5 82 10 80       	push   $0x801082e5
8010462d:	e8 de be ff ff       	call   80100510 <panic>
    panic("mycpu called with interrupts enabled\n");
80104632:	83 ec 0c             	sub    $0xc,%esp
80104635:	68 b8 86 10 80       	push   $0x801086b8
8010463a:	e8 d1 be ff ff       	call   80100510 <panic>
8010463f:	90                   	nop

80104640 <cpuid>:
cpuid() {
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104646:	e8 95 ff ff ff       	call   801045e0 <mycpu>
}
8010464b:	c9                   	leave
  return mycpu()-cpus;
8010464c:	2d e0 2d 11 80       	sub    $0x80112de0,%eax
80104651:	c1 f8 04             	sar    $0x4,%eax
80104654:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010465a:	c3                   	ret
8010465b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104660 <myproc>:
myproc(void) {
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	53                   	push   %ebx
80104664:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104667:	e8 e4 0a 00 00       	call   80105150 <pushcli>
  c = mycpu();
8010466c:	e8 6f ff ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104671:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104677:	e8 24 0b 00 00       	call   801051a0 <popcli>
}
8010467c:	89 d8                	mov    %ebx,%eax
8010467e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104681:	c9                   	leave
80104682:	c3                   	ret
80104683:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010468a:	00 
8010468b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104690 <userinit>:
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104697:	e8 04 fe ff ff       	call   801044a0 <allocproc>
8010469c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010469e:	a3 94 52 11 80       	mov    %eax,0x80115294
  if((p->pgdir = setupkvm()) == 0)
801046a3:	e8 88 36 00 00       	call   80107d30 <setupkvm>
801046a8:	89 43 04             	mov    %eax,0x4(%ebx)
801046ab:	85 c0                	test   %eax,%eax
801046ad:	0f 84 bd 00 00 00    	je     80104770 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801046b3:	83 ec 04             	sub    $0x4,%esp
801046b6:	68 2c 00 00 00       	push   $0x2c
801046bb:	68 60 b4 10 80       	push   $0x8010b460
801046c0:	50                   	push   %eax
801046c1:	e8 1a 33 00 00       	call   801079e0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801046c6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801046c9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801046cf:	6a 4c                	push   $0x4c
801046d1:	6a 00                	push   $0x0
801046d3:	ff 73 18             	push   0x18(%ebx)
801046d6:	e8 c5 0c 00 00       	call   801053a0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801046db:	8b 43 18             	mov    0x18(%ebx),%eax
801046de:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801046e3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801046e6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801046eb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801046ef:	8b 43 18             	mov    0x18(%ebx),%eax
801046f2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801046f6:	8b 43 18             	mov    0x18(%ebx),%eax
801046f9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801046fd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104701:	8b 43 18             	mov    0x18(%ebx),%eax
80104704:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104708:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010470c:	8b 43 18             	mov    0x18(%ebx),%eax
8010470f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104716:	8b 43 18             	mov    0x18(%ebx),%eax
80104719:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104720:	8b 43 18             	mov    0x18(%ebx),%eax
80104723:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010472a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010472d:	6a 10                	push   $0x10
8010472f:	68 0e 83 10 80       	push   $0x8010830e
80104734:	50                   	push   %eax
80104735:	e8 16 0e 00 00       	call   80105550 <safestrcpy>
  p->cwd = namei("/");
8010473a:	c7 04 24 17 83 10 80 	movl   $0x80108317,(%esp)
80104741:	e8 3a e6 ff ff       	call   80102d80 <namei>
80104746:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104749:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104750:	e8 4b 0b 00 00       	call   801052a0 <acquire>
  p->state = RUNNABLE;
80104755:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010475c:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104763:	e8 d8 0a 00 00       	call   80105240 <release>
}
80104768:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010476b:	83 c4 10             	add    $0x10,%esp
8010476e:	c9                   	leave
8010476f:	c3                   	ret
    panic("userinit: out of memory?");
80104770:	83 ec 0c             	sub    $0xc,%esp
80104773:	68 f5 82 10 80       	push   $0x801082f5
80104778:	e8 93 bd ff ff       	call   80100510 <panic>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <growproc>:
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104788:	e8 c3 09 00 00       	call   80105150 <pushcli>
  c = mycpu();
8010478d:	e8 4e fe ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104792:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104798:	e8 03 0a 00 00       	call   801051a0 <popcli>
  sz = curproc->sz;
8010479d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010479f:	85 f6                	test   %esi,%esi
801047a1:	7f 1d                	jg     801047c0 <growproc+0x40>
  } else if(n < 0){
801047a3:	75 3b                	jne    801047e0 <growproc+0x60>
  switchuvm(curproc);
801047a5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801047a8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801047aa:	53                   	push   %ebx
801047ab:	e8 20 31 00 00       	call   801078d0 <switchuvm>
  return 0;
801047b0:	83 c4 10             	add    $0x10,%esp
801047b3:	31 c0                	xor    %eax,%eax
}
801047b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047b8:	5b                   	pop    %ebx
801047b9:	5e                   	pop    %esi
801047ba:	5d                   	pop    %ebp
801047bb:	c3                   	ret
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801047c0:	83 ec 04             	sub    $0x4,%esp
801047c3:	01 c6                	add    %eax,%esi
801047c5:	56                   	push   %esi
801047c6:	50                   	push   %eax
801047c7:	ff 73 04             	push   0x4(%ebx)
801047ca:	e8 81 33 00 00       	call   80107b50 <allocuvm>
801047cf:	83 c4 10             	add    $0x10,%esp
801047d2:	85 c0                	test   %eax,%eax
801047d4:	75 cf                	jne    801047a5 <growproc+0x25>
      return -1;
801047d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047db:	eb d8                	jmp    801047b5 <growproc+0x35>
801047dd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801047e0:	83 ec 04             	sub    $0x4,%esp
801047e3:	01 c6                	add    %eax,%esi
801047e5:	56                   	push   %esi
801047e6:	50                   	push   %eax
801047e7:	ff 73 04             	push   0x4(%ebx)
801047ea:	e8 91 34 00 00       	call   80107c80 <deallocuvm>
801047ef:	83 c4 10             	add    $0x10,%esp
801047f2:	85 c0                	test   %eax,%eax
801047f4:	75 af                	jne    801047a5 <growproc+0x25>
801047f6:	eb de                	jmp    801047d6 <growproc+0x56>
801047f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047ff:	00 

80104800 <fork>:
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104809:	e8 42 09 00 00       	call   80105150 <pushcli>
  c = mycpu();
8010480e:	e8 cd fd ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104813:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104819:	e8 82 09 00 00       	call   801051a0 <popcli>
  if((np = allocproc()) == 0){
8010481e:	e8 7d fc ff ff       	call   801044a0 <allocproc>
80104823:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104826:	85 c0                	test   %eax,%eax
80104828:	0f 84 d6 00 00 00    	je     80104904 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010482e:	83 ec 08             	sub    $0x8,%esp
80104831:	ff 33                	push   (%ebx)
80104833:	89 c7                	mov    %eax,%edi
80104835:	ff 73 04             	push   0x4(%ebx)
80104838:	e8 e3 35 00 00       	call   80107e20 <copyuvm>
8010483d:	83 c4 10             	add    $0x10,%esp
80104840:	89 47 04             	mov    %eax,0x4(%edi)
80104843:	85 c0                	test   %eax,%eax
80104845:	0f 84 9a 00 00 00    	je     801048e5 <fork+0xe5>
  np->sz = curproc->sz;
8010484b:	8b 03                	mov    (%ebx),%eax
8010484d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104850:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104852:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104855:	89 c8                	mov    %ecx,%eax
80104857:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010485a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010485f:	8b 73 18             	mov    0x18(%ebx),%esi
80104862:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104864:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104866:	8b 40 18             	mov    0x18(%eax),%eax
80104869:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104870:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104874:	85 c0                	test   %eax,%eax
80104876:	74 13                	je     8010488b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104878:	83 ec 0c             	sub    $0xc,%esp
8010487b:	50                   	push   %eax
8010487c:	e8 3f d3 ff ff       	call   80101bc0 <filedup>
80104881:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104884:	83 c4 10             	add    $0x10,%esp
80104887:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010488b:	83 c6 01             	add    $0x1,%esi
8010488e:	83 fe 10             	cmp    $0x10,%esi
80104891:	75 dd                	jne    80104870 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104893:	83 ec 0c             	sub    $0xc,%esp
80104896:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104899:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010489c:	e8 cf db ff ff       	call   80102470 <idup>
801048a1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048a4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801048a7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048aa:	8d 47 6c             	lea    0x6c(%edi),%eax
801048ad:	6a 10                	push   $0x10
801048af:	53                   	push   %ebx
801048b0:	50                   	push   %eax
801048b1:	e8 9a 0c 00 00       	call   80105550 <safestrcpy>
  pid = np->pid;
801048b6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801048b9:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
801048c0:	e8 db 09 00 00       	call   801052a0 <acquire>
  np->state = RUNNABLE;
801048c5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801048cc:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
801048d3:	e8 68 09 00 00       	call   80105240 <release>
  return pid;
801048d8:	83 c4 10             	add    $0x10,%esp
}
801048db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048de:	89 d8                	mov    %ebx,%eax
801048e0:	5b                   	pop    %ebx
801048e1:	5e                   	pop    %esi
801048e2:	5f                   	pop    %edi
801048e3:	5d                   	pop    %ebp
801048e4:	c3                   	ret
    kfree(np->kstack);
801048e5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	ff 73 08             	push   0x8(%ebx)
801048ee:	e8 ad e8 ff ff       	call   801031a0 <kfree>
    np->kstack = 0;
801048f3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801048fa:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801048fd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104904:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104909:	eb d0                	jmp    801048db <fork+0xdb>
8010490b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104910 <scheduler>:
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	53                   	push   %ebx
80104916:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104919:	e8 c2 fc ff ff       	call   801045e0 <mycpu>
  c->proc = 0;
8010491e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104925:	00 00 00 
  struct cpu *c = mycpu();
80104928:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010492a:	8d 78 04             	lea    0x4(%eax),%edi
8010492d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104930:	fb                   	sti
    acquire(&ptable.lock);
80104931:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104934:	bb 94 33 11 80       	mov    $0x80113394,%ebx
    acquire(&ptable.lock);
80104939:	68 60 33 11 80       	push   $0x80113360
8010493e:	e8 5d 09 00 00       	call   801052a0 <acquire>
80104943:	83 c4 10             	add    $0x10,%esp
80104946:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010494d:	00 
8010494e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104950:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104954:	75 33                	jne    80104989 <scheduler+0x79>
      switchuvm(p);
80104956:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104959:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010495f:	53                   	push   %ebx
80104960:	e8 6b 2f 00 00       	call   801078d0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104965:	58                   	pop    %eax
80104966:	5a                   	pop    %edx
80104967:	ff 73 1c             	push   0x1c(%ebx)
8010496a:	57                   	push   %edi
      p->state = RUNNING;
8010496b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104972:	e8 34 0c 00 00       	call   801055ab <swtch>
      switchkvm();
80104977:	e8 44 2f 00 00       	call   801078c0 <switchkvm>
      c->proc = 0;
8010497c:	83 c4 10             	add    $0x10,%esp
8010497f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104986:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104989:	83 c3 7c             	add    $0x7c,%ebx
8010498c:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
80104992:	75 bc                	jne    80104950 <scheduler+0x40>
    release(&ptable.lock);
80104994:	83 ec 0c             	sub    $0xc,%esp
80104997:	68 60 33 11 80       	push   $0x80113360
8010499c:	e8 9f 08 00 00       	call   80105240 <release>
    sti();
801049a1:	83 c4 10             	add    $0x10,%esp
801049a4:	eb 8a                	jmp    80104930 <scheduler+0x20>
801049a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ad:	00 
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <sched>:
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
  pushcli();
801049b5:	e8 96 07 00 00       	call   80105150 <pushcli>
  c = mycpu();
801049ba:	e8 21 fc ff ff       	call   801045e0 <mycpu>
  p = c->proc;
801049bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801049c5:	e8 d6 07 00 00       	call   801051a0 <popcli>
  if(!holding(&ptable.lock))
801049ca:	83 ec 0c             	sub    $0xc,%esp
801049cd:	68 60 33 11 80       	push   $0x80113360
801049d2:	e8 29 08 00 00       	call   80105200 <holding>
801049d7:	83 c4 10             	add    $0x10,%esp
801049da:	85 c0                	test   %eax,%eax
801049dc:	74 4f                	je     80104a2d <sched+0x7d>
  if(mycpu()->ncli != 1)
801049de:	e8 fd fb ff ff       	call   801045e0 <mycpu>
801049e3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801049ea:	75 68                	jne    80104a54 <sched+0xa4>
  if(p->state == RUNNING)
801049ec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801049f0:	74 55                	je     80104a47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801049f2:	9c                   	pushf
801049f3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801049f4:	f6 c4 02             	test   $0x2,%ah
801049f7:	75 41                	jne    80104a3a <sched+0x8a>
  intena = mycpu()->intena;
801049f9:	e8 e2 fb ff ff       	call   801045e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801049fe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104a01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104a07:	e8 d4 fb ff ff       	call   801045e0 <mycpu>
80104a0c:	83 ec 08             	sub    $0x8,%esp
80104a0f:	ff 70 04             	push   0x4(%eax)
80104a12:	53                   	push   %ebx
80104a13:	e8 93 0b 00 00       	call   801055ab <swtch>
  mycpu()->intena = intena;
80104a18:	e8 c3 fb ff ff       	call   801045e0 <mycpu>
}
80104a1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104a20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104a26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a29:	5b                   	pop    %ebx
80104a2a:	5e                   	pop    %esi
80104a2b:	5d                   	pop    %ebp
80104a2c:	c3                   	ret
    panic("sched ptable.lock");
80104a2d:	83 ec 0c             	sub    $0xc,%esp
80104a30:	68 19 83 10 80       	push   $0x80108319
80104a35:	e8 d6 ba ff ff       	call   80100510 <panic>
    panic("sched interruptible");
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 45 83 10 80       	push   $0x80108345
80104a42:	e8 c9 ba ff ff       	call   80100510 <panic>
    panic("sched running");
80104a47:	83 ec 0c             	sub    $0xc,%esp
80104a4a:	68 37 83 10 80       	push   $0x80108337
80104a4f:	e8 bc ba ff ff       	call   80100510 <panic>
    panic("sched locks");
80104a54:	83 ec 0c             	sub    $0xc,%esp
80104a57:	68 2b 83 10 80       	push   $0x8010832b
80104a5c:	e8 af ba ff ff       	call   80100510 <panic>
80104a61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a68:	00 
80104a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a70 <exit>:
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
80104a76:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104a79:	e8 e2 fb ff ff       	call   80104660 <myproc>
  if(curproc == initproc)
80104a7e:	39 05 94 52 11 80    	cmp    %eax,0x80115294
80104a84:	0f 84 fd 00 00 00    	je     80104b87 <exit+0x117>
80104a8a:	89 c3                	mov    %eax,%ebx
80104a8c:	8d 70 28             	lea    0x28(%eax),%esi
80104a8f:	8d 78 68             	lea    0x68(%eax),%edi
80104a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104a98:	8b 06                	mov    (%esi),%eax
80104a9a:	85 c0                	test   %eax,%eax
80104a9c:	74 12                	je     80104ab0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104a9e:	83 ec 0c             	sub    $0xc,%esp
80104aa1:	50                   	push   %eax
80104aa2:	e8 69 d1 ff ff       	call   80101c10 <fileclose>
      curproc->ofile[fd] = 0;
80104aa7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104aad:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104ab0:	83 c6 04             	add    $0x4,%esi
80104ab3:	39 f7                	cmp    %esi,%edi
80104ab5:	75 e1                	jne    80104a98 <exit+0x28>
  begin_op();
80104ab7:	e8 84 ef ff ff       	call   80103a40 <begin_op>
  iput(curproc->cwd);
80104abc:	83 ec 0c             	sub    $0xc,%esp
80104abf:	ff 73 68             	push   0x68(%ebx)
80104ac2:	e8 09 db ff ff       	call   801025d0 <iput>
  end_op();
80104ac7:	e8 e4 ef ff ff       	call   80103ab0 <end_op>
  curproc->cwd = 0;
80104acc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104ad3:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104ada:	e8 c1 07 00 00       	call   801052a0 <acquire>
  wakeup1(curproc->parent);
80104adf:	8b 53 14             	mov    0x14(%ebx),%edx
80104ae2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ae5:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104aea:	eb 0e                	jmp    80104afa <exit+0x8a>
80104aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104af0:	83 c0 7c             	add    $0x7c,%eax
80104af3:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104af8:	74 1c                	je     80104b16 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80104afa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104afe:	75 f0                	jne    80104af0 <exit+0x80>
80104b00:	3b 50 20             	cmp    0x20(%eax),%edx
80104b03:	75 eb                	jne    80104af0 <exit+0x80>
      p->state = RUNNABLE;
80104b05:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b0c:	83 c0 7c             	add    $0x7c,%eax
80104b0f:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104b14:	75 e4                	jne    80104afa <exit+0x8a>
      p->parent = initproc;
80104b16:	8b 0d 94 52 11 80    	mov    0x80115294,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b1c:	ba 94 33 11 80       	mov    $0x80113394,%edx
80104b21:	eb 10                	jmp    80104b33 <exit+0xc3>
80104b23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b28:	83 c2 7c             	add    $0x7c,%edx
80104b2b:	81 fa 94 52 11 80    	cmp    $0x80115294,%edx
80104b31:	74 3b                	je     80104b6e <exit+0xfe>
    if(p->parent == curproc){
80104b33:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104b36:	75 f0                	jne    80104b28 <exit+0xb8>
      if(p->state == ZOMBIE)
80104b38:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104b3c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104b3f:	75 e7                	jne    80104b28 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b41:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104b46:	eb 12                	jmp    80104b5a <exit+0xea>
80104b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4f:	00 
80104b50:	83 c0 7c             	add    $0x7c,%eax
80104b53:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104b58:	74 ce                	je     80104b28 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80104b5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b5e:	75 f0                	jne    80104b50 <exit+0xe0>
80104b60:	3b 48 20             	cmp    0x20(%eax),%ecx
80104b63:	75 eb                	jne    80104b50 <exit+0xe0>
      p->state = RUNNABLE;
80104b65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104b6c:	eb e2                	jmp    80104b50 <exit+0xe0>
  curproc->state = ZOMBIE;
80104b6e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104b75:	e8 36 fe ff ff       	call   801049b0 <sched>
  panic("zombie exit");
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	68 66 83 10 80       	push   $0x80108366
80104b82:	e8 89 b9 ff ff       	call   80100510 <panic>
    panic("init exiting");
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 59 83 10 80       	push   $0x80108359
80104b8f:	e8 7c b9 ff ff       	call   80100510 <panic>
80104b94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b9b:	00 
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ba0 <wait>:
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	53                   	push   %ebx
  pushcli();
80104ba5:	e8 a6 05 00 00       	call   80105150 <pushcli>
  c = mycpu();
80104baa:	e8 31 fa ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104baf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104bb5:	e8 e6 05 00 00       	call   801051a0 <popcli>
  acquire(&ptable.lock);
80104bba:	83 ec 0c             	sub    $0xc,%esp
80104bbd:	68 60 33 11 80       	push   $0x80113360
80104bc2:	e8 d9 06 00 00       	call   801052a0 <acquire>
80104bc7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104bca:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bcc:	bb 94 33 11 80       	mov    $0x80113394,%ebx
80104bd1:	eb 10                	jmp    80104be3 <wait+0x43>
80104bd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bd8:	83 c3 7c             	add    $0x7c,%ebx
80104bdb:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
80104be1:	74 1b                	je     80104bfe <wait+0x5e>
      if(p->parent != curproc)
80104be3:	39 73 14             	cmp    %esi,0x14(%ebx)
80104be6:	75 f0                	jne    80104bd8 <wait+0x38>
      if(p->state == ZOMBIE){
80104be8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104bec:	74 62                	je     80104c50 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bee:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104bf1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bf6:	81 fb 94 52 11 80    	cmp    $0x80115294,%ebx
80104bfc:	75 e5                	jne    80104be3 <wait+0x43>
    if(!havekids || curproc->killed){
80104bfe:	85 c0                	test   %eax,%eax
80104c00:	0f 84 a0 00 00 00    	je     80104ca6 <wait+0x106>
80104c06:	8b 46 24             	mov    0x24(%esi),%eax
80104c09:	85 c0                	test   %eax,%eax
80104c0b:	0f 85 95 00 00 00    	jne    80104ca6 <wait+0x106>
  pushcli();
80104c11:	e8 3a 05 00 00       	call   80105150 <pushcli>
  c = mycpu();
80104c16:	e8 c5 f9 ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104c1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c21:	e8 7a 05 00 00       	call   801051a0 <popcli>
  if(p == 0)
80104c26:	85 db                	test   %ebx,%ebx
80104c28:	0f 84 8f 00 00 00    	je     80104cbd <wait+0x11d>
  p->chan = chan;
80104c2e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104c31:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104c38:	e8 73 fd ff ff       	call   801049b0 <sched>
  p->chan = 0;
80104c3d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104c44:	eb 84                	jmp    80104bca <wait+0x2a>
80104c46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c4d:	00 
80104c4e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104c50:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104c53:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104c56:	ff 73 08             	push   0x8(%ebx)
80104c59:	e8 42 e5 ff ff       	call   801031a0 <kfree>
        p->kstack = 0;
80104c5e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104c65:	5a                   	pop    %edx
80104c66:	ff 73 04             	push   0x4(%ebx)
80104c69:	e8 42 30 00 00       	call   80107cb0 <freevm>
        p->pid = 0;
80104c6e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104c75:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104c7c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104c80:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104c87:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104c8e:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104c95:	e8 a6 05 00 00       	call   80105240 <release>
        return pid;
80104c9a:	83 c4 10             	add    $0x10,%esp
}
80104c9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca0:	89 f0                	mov    %esi,%eax
80104ca2:	5b                   	pop    %ebx
80104ca3:	5e                   	pop    %esi
80104ca4:	5d                   	pop    %ebp
80104ca5:	c3                   	ret
      release(&ptable.lock);
80104ca6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104ca9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104cae:	68 60 33 11 80       	push   $0x80113360
80104cb3:	e8 88 05 00 00       	call   80105240 <release>
      return -1;
80104cb8:	83 c4 10             	add    $0x10,%esp
80104cbb:	eb e0                	jmp    80104c9d <wait+0xfd>
    panic("sleep");
80104cbd:	83 ec 0c             	sub    $0xc,%esp
80104cc0:	68 72 83 10 80       	push   $0x80108372
80104cc5:	e8 46 b8 ff ff       	call   80100510 <panic>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cd0 <yield>:
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	53                   	push   %ebx
80104cd4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104cd7:	68 60 33 11 80       	push   $0x80113360
80104cdc:	e8 bf 05 00 00       	call   801052a0 <acquire>
  pushcli();
80104ce1:	e8 6a 04 00 00       	call   80105150 <pushcli>
  c = mycpu();
80104ce6:	e8 f5 f8 ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104ceb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104cf1:	e8 aa 04 00 00       	call   801051a0 <popcli>
  myproc()->state = RUNNABLE;
80104cf6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104cfd:	e8 ae fc ff ff       	call   801049b0 <sched>
  release(&ptable.lock);
80104d02:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104d09:	e8 32 05 00 00       	call   80105240 <release>
}
80104d0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d11:	83 c4 10             	add    $0x10,%esp
80104d14:	c9                   	leave
80104d15:	c3                   	ret
80104d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d1d:	00 
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <sleep>:
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	57                   	push   %edi
80104d24:	56                   	push   %esi
80104d25:	53                   	push   %ebx
80104d26:	83 ec 0c             	sub    $0xc,%esp
80104d29:	8b 7d 08             	mov    0x8(%ebp),%edi
80104d2c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104d2f:	e8 1c 04 00 00       	call   80105150 <pushcli>
  c = mycpu();
80104d34:	e8 a7 f8 ff ff       	call   801045e0 <mycpu>
  p = c->proc;
80104d39:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d3f:	e8 5c 04 00 00       	call   801051a0 <popcli>
  if(p == 0)
80104d44:	85 db                	test   %ebx,%ebx
80104d46:	0f 84 87 00 00 00    	je     80104dd3 <sleep+0xb3>
  if(lk == 0)
80104d4c:	85 f6                	test   %esi,%esi
80104d4e:	74 76                	je     80104dc6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104d50:	81 fe 60 33 11 80    	cmp    $0x80113360,%esi
80104d56:	74 50                	je     80104da8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	68 60 33 11 80       	push   $0x80113360
80104d60:	e8 3b 05 00 00       	call   801052a0 <acquire>
    release(lk);
80104d65:	89 34 24             	mov    %esi,(%esp)
80104d68:	e8 d3 04 00 00       	call   80105240 <release>
  p->chan = chan;
80104d6d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104d70:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104d77:	e8 34 fc ff ff       	call   801049b0 <sched>
  p->chan = 0;
80104d7c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104d83:	c7 04 24 60 33 11 80 	movl   $0x80113360,(%esp)
80104d8a:	e8 b1 04 00 00       	call   80105240 <release>
    acquire(lk);
80104d8f:	89 75 08             	mov    %esi,0x8(%ebp)
80104d92:	83 c4 10             	add    $0x10,%esp
}
80104d95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d98:	5b                   	pop    %ebx
80104d99:	5e                   	pop    %esi
80104d9a:	5f                   	pop    %edi
80104d9b:	5d                   	pop    %ebp
    acquire(lk);
80104d9c:	e9 ff 04 00 00       	jmp    801052a0 <acquire>
80104da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104da8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104dab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104db2:	e8 f9 fb ff ff       	call   801049b0 <sched>
  p->chan = 0;
80104db7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104dbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dc1:	5b                   	pop    %ebx
80104dc2:	5e                   	pop    %esi
80104dc3:	5f                   	pop    %edi
80104dc4:	5d                   	pop    %ebp
80104dc5:	c3                   	ret
    panic("sleep without lk");
80104dc6:	83 ec 0c             	sub    $0xc,%esp
80104dc9:	68 78 83 10 80       	push   $0x80108378
80104dce:	e8 3d b7 ff ff       	call   80100510 <panic>
    panic("sleep");
80104dd3:	83 ec 0c             	sub    $0xc,%esp
80104dd6:	68 72 83 10 80       	push   $0x80108372
80104ddb:	e8 30 b7 ff ff       	call   80100510 <panic>

80104de0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	53                   	push   %ebx
80104de4:	83 ec 10             	sub    $0x10,%esp
80104de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104dea:	68 60 33 11 80       	push   $0x80113360
80104def:	e8 ac 04 00 00       	call   801052a0 <acquire>
80104df4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104df7:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104dfc:	eb 0c                	jmp    80104e0a <wakeup+0x2a>
80104dfe:	66 90                	xchg   %ax,%ax
80104e00:	83 c0 7c             	add    $0x7c,%eax
80104e03:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104e08:	74 1c                	je     80104e26 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104e0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e0e:	75 f0                	jne    80104e00 <wakeup+0x20>
80104e10:	3b 58 20             	cmp    0x20(%eax),%ebx
80104e13:	75 eb                	jne    80104e00 <wakeup+0x20>
      p->state = RUNNABLE;
80104e15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e1c:	83 c0 7c             	add    $0x7c,%eax
80104e1f:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104e24:	75 e4                	jne    80104e0a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104e26:	c7 45 08 60 33 11 80 	movl   $0x80113360,0x8(%ebp)
}
80104e2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e30:	c9                   	leave
  release(&ptable.lock);
80104e31:	e9 0a 04 00 00       	jmp    80105240 <release>
80104e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e3d:	00 
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 10             	sub    $0x10,%esp
80104e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104e4a:	68 60 33 11 80       	push   $0x80113360
80104e4f:	e8 4c 04 00 00       	call   801052a0 <acquire>
80104e54:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e57:	b8 94 33 11 80       	mov    $0x80113394,%eax
80104e5c:	eb 0c                	jmp    80104e6a <kill+0x2a>
80104e5e:	66 90                	xchg   %ax,%ax
80104e60:	83 c0 7c             	add    $0x7c,%eax
80104e63:	3d 94 52 11 80       	cmp    $0x80115294,%eax
80104e68:	74 36                	je     80104ea0 <kill+0x60>
    if(p->pid == pid){
80104e6a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104e6d:	75 f1                	jne    80104e60 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e6f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104e73:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104e7a:	75 07                	jne    80104e83 <kill+0x43>
        p->state = RUNNABLE;
80104e7c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104e83:	83 ec 0c             	sub    $0xc,%esp
80104e86:	68 60 33 11 80       	push   $0x80113360
80104e8b:	e8 b0 03 00 00       	call   80105240 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104e90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104e93:	83 c4 10             	add    $0x10,%esp
80104e96:	31 c0                	xor    %eax,%eax
}
80104e98:	c9                   	leave
80104e99:	c3                   	ret
80104e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104ea0:	83 ec 0c             	sub    $0xc,%esp
80104ea3:	68 60 33 11 80       	push   $0x80113360
80104ea8:	e8 93 03 00 00       	call   80105240 <release>
}
80104ead:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104eb0:	83 c4 10             	add    $0x10,%esp
80104eb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104eb8:	c9                   	leave
80104eb9:	c3                   	ret
80104eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ec0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104ec8:	53                   	push   %ebx
80104ec9:	bb 00 34 11 80       	mov    $0x80113400,%ebx
80104ece:	83 ec 3c             	sub    $0x3c,%esp
80104ed1:	eb 24                	jmp    80104ef7 <procdump+0x37>
80104ed3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ed8:	83 ec 0c             	sub    $0xc,%esp
80104edb:	68 64 85 10 80       	push   $0x80108564
80104ee0:	e8 ab bb ff ff       	call   80100a90 <cprintf>
80104ee5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ee8:	83 c3 7c             	add    $0x7c,%ebx
80104eeb:	81 fb 00 53 11 80    	cmp    $0x80115300,%ebx
80104ef1:	0f 84 81 00 00 00    	je     80104f78 <procdump+0xb8>
    if(p->state == UNUSED)
80104ef7:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104efa:	85 c0                	test   %eax,%eax
80104efc:	74 ea                	je     80104ee8 <procdump+0x28>
      state = "???";
80104efe:	ba 89 83 10 80       	mov    $0x80108389,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104f03:	83 f8 05             	cmp    $0x5,%eax
80104f06:	77 11                	ja     80104f19 <procdump+0x59>
80104f08:	8b 14 85 c0 89 10 80 	mov    -0x7fef7640(,%eax,4),%edx
      state = "???";
80104f0f:	b8 89 83 10 80       	mov    $0x80108389,%eax
80104f14:	85 d2                	test   %edx,%edx
80104f16:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104f19:	53                   	push   %ebx
80104f1a:	52                   	push   %edx
80104f1b:	ff 73 a4             	push   -0x5c(%ebx)
80104f1e:	68 8d 83 10 80       	push   $0x8010838d
80104f23:	e8 68 bb ff ff       	call   80100a90 <cprintf>
    if(p->state == SLEEPING){
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104f2f:	75 a7                	jne    80104ed8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104f31:	83 ec 08             	sub    $0x8,%esp
80104f34:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f37:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104f3a:	50                   	push   %eax
80104f3b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104f3e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f41:	83 c0 08             	add    $0x8,%eax
80104f44:	50                   	push   %eax
80104f45:	e8 86 01 00 00       	call   801050d0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104f4a:	83 c4 10             	add    $0x10,%esp
80104f4d:	8d 76 00             	lea    0x0(%esi),%esi
80104f50:	8b 17                	mov    (%edi),%edx
80104f52:	85 d2                	test   %edx,%edx
80104f54:	74 82                	je     80104ed8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104f56:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104f59:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104f5c:	52                   	push   %edx
80104f5d:	68 c1 80 10 80       	push   $0x801080c1
80104f62:	e8 29 bb ff ff       	call   80100a90 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104f67:	83 c4 10             	add    $0x10,%esp
80104f6a:	39 f7                	cmp    %esi,%edi
80104f6c:	75 e2                	jne    80104f50 <procdump+0x90>
80104f6e:	e9 65 ff ff ff       	jmp    80104ed8 <procdump+0x18>
80104f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104f78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7b:	5b                   	pop    %ebx
80104f7c:	5e                   	pop    %esi
80104f7d:	5f                   	pop    %edi
80104f7e:	5d                   	pop    %ebp
80104f7f:	c3                   	ret

80104f80 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
80104f84:	83 ec 0c             	sub    $0xc,%esp
80104f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104f8a:	68 c0 83 10 80       	push   $0x801083c0
80104f8f:	8d 43 04             	lea    0x4(%ebx),%eax
80104f92:	50                   	push   %eax
80104f93:	e8 18 01 00 00       	call   801050b0 <initlock>
  lk->name = name;
80104f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104f9b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104fa1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104fa4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104fab:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104fae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb1:	c9                   	leave
80104fb2:	c3                   	ret
80104fb3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fba:	00 
80104fbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104fc0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
80104fc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104fc8:	8d 73 04             	lea    0x4(%ebx),%esi
80104fcb:	83 ec 0c             	sub    $0xc,%esp
80104fce:	56                   	push   %esi
80104fcf:	e8 cc 02 00 00       	call   801052a0 <acquire>
  while (lk->locked) {
80104fd4:	8b 13                	mov    (%ebx),%edx
80104fd6:	83 c4 10             	add    $0x10,%esp
80104fd9:	85 d2                	test   %edx,%edx
80104fdb:	74 16                	je     80104ff3 <acquiresleep+0x33>
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104fe0:	83 ec 08             	sub    $0x8,%esp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
80104fe5:	e8 36 fd ff ff       	call   80104d20 <sleep>
  while (lk->locked) {
80104fea:	8b 03                	mov    (%ebx),%eax
80104fec:	83 c4 10             	add    $0x10,%esp
80104fef:	85 c0                	test   %eax,%eax
80104ff1:	75 ed                	jne    80104fe0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104ff3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ff9:	e8 62 f6 ff ff       	call   80104660 <myproc>
80104ffe:	8b 40 10             	mov    0x10(%eax),%eax
80105001:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105004:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105007:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010500a:	5b                   	pop    %ebx
8010500b:	5e                   	pop    %esi
8010500c:	5d                   	pop    %ebp
  release(&lk->lk);
8010500d:	e9 2e 02 00 00       	jmp    80105240 <release>
80105012:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105019:	00 
8010501a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105020 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	56                   	push   %esi
80105024:	53                   	push   %ebx
80105025:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105028:	8d 73 04             	lea    0x4(%ebx),%esi
8010502b:	83 ec 0c             	sub    $0xc,%esp
8010502e:	56                   	push   %esi
8010502f:	e8 6c 02 00 00       	call   801052a0 <acquire>
  lk->locked = 0;
80105034:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010503a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105041:	89 1c 24             	mov    %ebx,(%esp)
80105044:	e8 97 fd ff ff       	call   80104de0 <wakeup>
  release(&lk->lk);
80105049:	89 75 08             	mov    %esi,0x8(%ebp)
8010504c:	83 c4 10             	add    $0x10,%esp
}
8010504f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105052:	5b                   	pop    %ebx
80105053:	5e                   	pop    %esi
80105054:	5d                   	pop    %ebp
  release(&lk->lk);
80105055:	e9 e6 01 00 00       	jmp    80105240 <release>
8010505a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105060 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	57                   	push   %edi
80105064:	31 ff                	xor    %edi,%edi
80105066:	56                   	push   %esi
80105067:	53                   	push   %ebx
80105068:	83 ec 18             	sub    $0x18,%esp
8010506b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010506e:	8d 73 04             	lea    0x4(%ebx),%esi
80105071:	56                   	push   %esi
80105072:	e8 29 02 00 00       	call   801052a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105077:	8b 03                	mov    (%ebx),%eax
80105079:	83 c4 10             	add    $0x10,%esp
8010507c:	85 c0                	test   %eax,%eax
8010507e:	75 18                	jne    80105098 <holdingsleep+0x38>
  release(&lk->lk);
80105080:	83 ec 0c             	sub    $0xc,%esp
80105083:	56                   	push   %esi
80105084:	e8 b7 01 00 00       	call   80105240 <release>
  return r;
}
80105089:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010508c:	89 f8                	mov    %edi,%eax
8010508e:	5b                   	pop    %ebx
8010508f:	5e                   	pop    %esi
80105090:	5f                   	pop    %edi
80105091:	5d                   	pop    %ebp
80105092:	c3                   	ret
80105093:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80105098:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010509b:	e8 c0 f5 ff ff       	call   80104660 <myproc>
801050a0:	39 58 10             	cmp    %ebx,0x10(%eax)
801050a3:	0f 94 c0             	sete   %al
801050a6:	0f b6 c0             	movzbl %al,%eax
801050a9:	89 c7                	mov    %eax,%edi
801050ab:	eb d3                	jmp    80105080 <holdingsleep+0x20>
801050ad:	66 90                	xchg   %ax,%ax
801050af:	90                   	nop

801050b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801050b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801050b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801050bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801050c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801050c9:	5d                   	pop    %ebp
801050ca:	c3                   	ret
801050cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801050d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	53                   	push   %ebx
801050d4:	8b 45 08             	mov    0x8(%ebp),%eax
801050d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801050da:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050dd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801050e2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801050e7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050ec:	76 10                	jbe    801050fe <getcallerpcs+0x2e>
801050ee:	eb 28                	jmp    80105118 <getcallerpcs+0x48>
801050f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801050f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801050fc:	77 1a                	ja     80105118 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801050fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80105101:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105104:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105107:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105109:	83 f8 0a             	cmp    $0xa,%eax
8010510c:	75 e2                	jne    801050f0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010510e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105111:	c9                   	leave
80105112:	c3                   	ret
80105113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105118:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010511b:	83 c1 28             	add    $0x28,%ecx
8010511e:	89 ca                	mov    %ecx,%edx
80105120:	29 c2                	sub    %eax,%edx
80105122:	83 e2 04             	and    $0x4,%edx
80105125:	74 11                	je     80105138 <getcallerpcs+0x68>
    pcs[i] = 0;
80105127:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010512d:	83 c0 04             	add    $0x4,%eax
80105130:	39 c1                	cmp    %eax,%ecx
80105132:	74 da                	je     8010510e <getcallerpcs+0x3e>
80105134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80105138:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010513e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105141:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105148:	39 c1                	cmp    %eax,%ecx
8010514a:	75 ec                	jne    80105138 <getcallerpcs+0x68>
8010514c:	eb c0                	jmp    8010510e <getcallerpcs+0x3e>
8010514e:	66 90                	xchg   %ax,%ax

80105150 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	53                   	push   %ebx
80105154:	83 ec 04             	sub    $0x4,%esp
80105157:	9c                   	pushf
80105158:	5b                   	pop    %ebx
  asm volatile("cli");
80105159:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010515a:	e8 81 f4 ff ff       	call   801045e0 <mycpu>
8010515f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105165:	85 c0                	test   %eax,%eax
80105167:	74 17                	je     80105180 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105169:	e8 72 f4 ff ff       	call   801045e0 <mycpu>
8010516e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105178:	c9                   	leave
80105179:	c3                   	ret
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105180:	e8 5b f4 ff ff       	call   801045e0 <mycpu>
80105185:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010518b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105191:	eb d6                	jmp    80105169 <pushcli+0x19>
80105193:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010519a:	00 
8010519b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801051a0 <popcli>:

void
popcli(void)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801051a6:	9c                   	pushf
801051a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801051a8:	f6 c4 02             	test   $0x2,%ah
801051ab:	75 35                	jne    801051e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801051ad:	e8 2e f4 ff ff       	call   801045e0 <mycpu>
801051b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801051b9:	78 34                	js     801051ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801051bb:	e8 20 f4 ff ff       	call   801045e0 <mycpu>
801051c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801051c6:	85 d2                	test   %edx,%edx
801051c8:	74 06                	je     801051d0 <popcli+0x30>
    sti();
}
801051ca:	c9                   	leave
801051cb:	c3                   	ret
801051cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801051d0:	e8 0b f4 ff ff       	call   801045e0 <mycpu>
801051d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801051db:	85 c0                	test   %eax,%eax
801051dd:	74 eb                	je     801051ca <popcli+0x2a>
  asm volatile("sti");
801051df:	fb                   	sti
}
801051e0:	c9                   	leave
801051e1:	c3                   	ret
    panic("popcli - interruptible");
801051e2:	83 ec 0c             	sub    $0xc,%esp
801051e5:	68 cb 83 10 80       	push   $0x801083cb
801051ea:	e8 21 b3 ff ff       	call   80100510 <panic>
    panic("popcli");
801051ef:	83 ec 0c             	sub    $0xc,%esp
801051f2:	68 e2 83 10 80       	push   $0x801083e2
801051f7:	e8 14 b3 ff ff       	call   80100510 <panic>
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105200 <holding>:
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
80105205:	8b 75 08             	mov    0x8(%ebp),%esi
80105208:	31 db                	xor    %ebx,%ebx
  pushcli();
8010520a:	e8 41 ff ff ff       	call   80105150 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010520f:	8b 06                	mov    (%esi),%eax
80105211:	85 c0                	test   %eax,%eax
80105213:	75 0b                	jne    80105220 <holding+0x20>
  popcli();
80105215:	e8 86 ff ff ff       	call   801051a0 <popcli>
}
8010521a:	89 d8                	mov    %ebx,%eax
8010521c:	5b                   	pop    %ebx
8010521d:	5e                   	pop    %esi
8010521e:	5d                   	pop    %ebp
8010521f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80105220:	8b 5e 08             	mov    0x8(%esi),%ebx
80105223:	e8 b8 f3 ff ff       	call   801045e0 <mycpu>
80105228:	39 c3                	cmp    %eax,%ebx
8010522a:	0f 94 c3             	sete   %bl
  popcli();
8010522d:	e8 6e ff ff ff       	call   801051a0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105232:	0f b6 db             	movzbl %bl,%ebx
}
80105235:	89 d8                	mov    %ebx,%eax
80105237:	5b                   	pop    %ebx
80105238:	5e                   	pop    %esi
80105239:	5d                   	pop    %ebp
8010523a:	c3                   	ret
8010523b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105240 <release>:
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	56                   	push   %esi
80105244:	53                   	push   %ebx
80105245:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105248:	e8 03 ff ff ff       	call   80105150 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010524d:	8b 03                	mov    (%ebx),%eax
8010524f:	85 c0                	test   %eax,%eax
80105251:	75 15                	jne    80105268 <release+0x28>
  popcli();
80105253:	e8 48 ff ff ff       	call   801051a0 <popcli>
    panic("release");
80105258:	83 ec 0c             	sub    $0xc,%esp
8010525b:	68 e9 83 10 80       	push   $0x801083e9
80105260:	e8 ab b2 ff ff       	call   80100510 <panic>
80105265:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105268:	8b 73 08             	mov    0x8(%ebx),%esi
8010526b:	e8 70 f3 ff ff       	call   801045e0 <mycpu>
80105270:	39 c6                	cmp    %eax,%esi
80105272:	75 df                	jne    80105253 <release+0x13>
  popcli();
80105274:	e8 27 ff ff ff       	call   801051a0 <popcli>
  lk->pcs[0] = 0;
80105279:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105280:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105287:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010528c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105292:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105295:	5b                   	pop    %ebx
80105296:	5e                   	pop    %esi
80105297:	5d                   	pop    %ebp
  popcli();
80105298:	e9 03 ff ff ff       	jmp    801051a0 <popcli>
8010529d:	8d 76 00             	lea    0x0(%esi),%esi

801052a0 <acquire>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	53                   	push   %ebx
801052a4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801052a7:	e8 a4 fe ff ff       	call   80105150 <pushcli>
  if(holding(lk))
801052ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801052af:	e8 9c fe ff ff       	call   80105150 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801052b4:	8b 03                	mov    (%ebx),%eax
801052b6:	85 c0                	test   %eax,%eax
801052b8:	0f 85 b2 00 00 00    	jne    80105370 <acquire+0xd0>
  popcli();
801052be:	e8 dd fe ff ff       	call   801051a0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801052c3:	b9 01 00 00 00       	mov    $0x1,%ecx
801052c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052cf:	00 
  while(xchg(&lk->locked, 1) != 0)
801052d0:	8b 55 08             	mov    0x8(%ebp),%edx
801052d3:	89 c8                	mov    %ecx,%eax
801052d5:	f0 87 02             	lock xchg %eax,(%edx)
801052d8:	85 c0                	test   %eax,%eax
801052da:	75 f4                	jne    801052d0 <acquire+0x30>
  __sync_synchronize();
801052dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801052e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052e4:	e8 f7 f2 ff ff       	call   801045e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801052e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801052ec:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801052ee:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801052f1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801052f7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801052fc:	77 32                	ja     80105330 <acquire+0x90>
  ebp = (uint*)v - 2;
801052fe:	89 e8                	mov    %ebp,%eax
80105300:	eb 14                	jmp    80105316 <acquire+0x76>
80105302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105308:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010530e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105314:	77 1a                	ja     80105330 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80105316:	8b 58 04             	mov    0x4(%eax),%ebx
80105319:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010531d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105320:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105322:	83 fa 0a             	cmp    $0xa,%edx
80105325:	75 e1                	jne    80105308 <acquire+0x68>
}
80105327:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010532a:	c9                   	leave
8010532b:	c3                   	ret
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105330:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105334:	83 c1 34             	add    $0x34,%ecx
80105337:	89 ca                	mov    %ecx,%edx
80105339:	29 c2                	sub    %eax,%edx
8010533b:	83 e2 04             	and    $0x4,%edx
8010533e:	74 10                	je     80105350 <acquire+0xb0>
    pcs[i] = 0;
80105340:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105346:	83 c0 04             	add    $0x4,%eax
80105349:	39 c1                	cmp    %eax,%ecx
8010534b:	74 da                	je     80105327 <acquire+0x87>
8010534d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105350:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105356:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105359:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105360:	39 c1                	cmp    %eax,%ecx
80105362:	75 ec                	jne    80105350 <acquire+0xb0>
80105364:	eb c1                	jmp    80105327 <acquire+0x87>
80105366:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010536d:	00 
8010536e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80105370:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105373:	e8 68 f2 ff ff       	call   801045e0 <mycpu>
80105378:	39 c3                	cmp    %eax,%ebx
8010537a:	0f 85 3e ff ff ff    	jne    801052be <acquire+0x1e>
  popcli();
80105380:	e8 1b fe ff ff       	call   801051a0 <popcli>
    panic("acquire");
80105385:	83 ec 0c             	sub    $0xc,%esp
80105388:	68 f1 83 10 80       	push   $0x801083f1
8010538d:	e8 7e b1 ff ff       	call   80100510 <panic>
80105392:	66 90                	xchg   %ax,%ax
80105394:	66 90                	xchg   %ax,%ax
80105396:	66 90                	xchg   %ax,%ax
80105398:	66 90                	xchg   %ax,%ax
8010539a:	66 90                	xchg   %ax,%ax
8010539c:	66 90                	xchg   %ax,%ax
8010539e:	66 90                	xchg   %ax,%ax

801053a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	8b 55 08             	mov    0x8(%ebp),%edx
801053a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801053aa:	89 d0                	mov    %edx,%eax
801053ac:	09 c8                	or     %ecx,%eax
801053ae:	a8 03                	test   $0x3,%al
801053b0:	75 1e                	jne    801053d0 <memset+0x30>
    c &= 0xFF;
801053b2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801053b6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801053b9:	89 d7                	mov    %edx,%edi
801053bb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801053c1:	fc                   	cld
801053c2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801053c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801053c7:	89 d0                	mov    %edx,%eax
801053c9:	c9                   	leave
801053ca:	c3                   	ret
801053cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801053d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801053d3:	89 d7                	mov    %edx,%edi
801053d5:	fc                   	cld
801053d6:	f3 aa                	rep stos %al,%es:(%edi)
801053d8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801053db:	89 d0                	mov    %edx,%eax
801053dd:	c9                   	leave
801053de:	c3                   	ret
801053df:	90                   	nop

801053e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	56                   	push   %esi
801053e4:	8b 75 10             	mov    0x10(%ebp),%esi
801053e7:	8b 45 08             	mov    0x8(%ebp),%eax
801053ea:	53                   	push   %ebx
801053eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801053ee:	85 f6                	test   %esi,%esi
801053f0:	74 2e                	je     80105420 <memcmp+0x40>
801053f2:	01 c6                	add    %eax,%esi
801053f4:	eb 14                	jmp    8010540a <memcmp+0x2a>
801053f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053fd:	00 
801053fe:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105400:	83 c0 01             	add    $0x1,%eax
80105403:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105406:	39 f0                	cmp    %esi,%eax
80105408:	74 16                	je     80105420 <memcmp+0x40>
    if(*s1 != *s2)
8010540a:	0f b6 08             	movzbl (%eax),%ecx
8010540d:	0f b6 1a             	movzbl (%edx),%ebx
80105410:	38 d9                	cmp    %bl,%cl
80105412:	74 ec                	je     80105400 <memcmp+0x20>
      return *s1 - *s2;
80105414:	0f b6 c1             	movzbl %cl,%eax
80105417:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105419:	5b                   	pop    %ebx
8010541a:	5e                   	pop    %esi
8010541b:	5d                   	pop    %ebp
8010541c:	c3                   	ret
8010541d:	8d 76 00             	lea    0x0(%esi),%esi
80105420:	5b                   	pop    %ebx
  return 0;
80105421:	31 c0                	xor    %eax,%eax
}
80105423:	5e                   	pop    %esi
80105424:	5d                   	pop    %ebp
80105425:	c3                   	ret
80105426:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010542d:	00 
8010542e:	66 90                	xchg   %ax,%ax

80105430 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	8b 55 08             	mov    0x8(%ebp),%edx
80105437:	8b 45 10             	mov    0x10(%ebp),%eax
8010543a:	56                   	push   %esi
8010543b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010543e:	39 d6                	cmp    %edx,%esi
80105440:	73 26                	jae    80105468 <memmove+0x38>
80105442:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105445:	39 ca                	cmp    %ecx,%edx
80105447:	73 1f                	jae    80105468 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105449:	85 c0                	test   %eax,%eax
8010544b:	74 0f                	je     8010545c <memmove+0x2c>
8010544d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105450:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105454:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105457:	83 e8 01             	sub    $0x1,%eax
8010545a:	73 f4                	jae    80105450 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010545c:	5e                   	pop    %esi
8010545d:	89 d0                	mov    %edx,%eax
8010545f:	5f                   	pop    %edi
80105460:	5d                   	pop    %ebp
80105461:	c3                   	ret
80105462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105468:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010546b:	89 d7                	mov    %edx,%edi
8010546d:	85 c0                	test   %eax,%eax
8010546f:	74 eb                	je     8010545c <memmove+0x2c>
80105471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105478:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105479:	39 ce                	cmp    %ecx,%esi
8010547b:	75 fb                	jne    80105478 <memmove+0x48>
}
8010547d:	5e                   	pop    %esi
8010547e:	89 d0                	mov    %edx,%eax
80105480:	5f                   	pop    %edi
80105481:	5d                   	pop    %ebp
80105482:	c3                   	ret
80105483:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010548a:	00 
8010548b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105490 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105490:	eb 9e                	jmp    80105430 <memmove>
80105492:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105499:	00 
8010549a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801054a0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	8b 55 10             	mov    0x10(%ebp),%edx
801054a7:	8b 45 08             	mov    0x8(%ebp),%eax
801054aa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801054ad:	85 d2                	test   %edx,%edx
801054af:	75 16                	jne    801054c7 <strncmp+0x27>
801054b1:	eb 2d                	jmp    801054e0 <strncmp+0x40>
801054b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801054b8:	3a 19                	cmp    (%ecx),%bl
801054ba:	75 12                	jne    801054ce <strncmp+0x2e>
    n--, p++, q++;
801054bc:	83 c0 01             	add    $0x1,%eax
801054bf:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801054c2:	83 ea 01             	sub    $0x1,%edx
801054c5:	74 19                	je     801054e0 <strncmp+0x40>
801054c7:	0f b6 18             	movzbl (%eax),%ebx
801054ca:	84 db                	test   %bl,%bl
801054cc:	75 ea                	jne    801054b8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801054ce:	0f b6 00             	movzbl (%eax),%eax
801054d1:	0f b6 11             	movzbl (%ecx),%edx
}
801054d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054d7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801054d8:	29 d0                	sub    %edx,%eax
}
801054da:	c3                   	ret
801054db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801054e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801054e3:	31 c0                	xor    %eax,%eax
}
801054e5:	c9                   	leave
801054e6:	c3                   	ret
801054e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ee:	00 
801054ef:	90                   	nop

801054f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	57                   	push   %edi
801054f4:	56                   	push   %esi
801054f5:	8b 75 08             	mov    0x8(%ebp),%esi
801054f8:	53                   	push   %ebx
801054f9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801054fc:	89 f0                	mov    %esi,%eax
801054fe:	eb 15                	jmp    80105515 <strncpy+0x25>
80105500:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105504:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105507:	83 c0 01             	add    $0x1,%eax
8010550a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010550e:	88 48 ff             	mov    %cl,-0x1(%eax)
80105511:	84 c9                	test   %cl,%cl
80105513:	74 13                	je     80105528 <strncpy+0x38>
80105515:	89 d3                	mov    %edx,%ebx
80105517:	83 ea 01             	sub    $0x1,%edx
8010551a:	85 db                	test   %ebx,%ebx
8010551c:	7f e2                	jg     80105500 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010551e:	5b                   	pop    %ebx
8010551f:	89 f0                	mov    %esi,%eax
80105521:	5e                   	pop    %esi
80105522:	5f                   	pop    %edi
80105523:	5d                   	pop    %ebp
80105524:	c3                   	ret
80105525:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80105528:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010552b:	83 e9 01             	sub    $0x1,%ecx
8010552e:	85 d2                	test   %edx,%edx
80105530:	74 ec                	je     8010551e <strncpy+0x2e>
80105532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80105538:	83 c0 01             	add    $0x1,%eax
8010553b:	89 ca                	mov    %ecx,%edx
8010553d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105541:	29 c2                	sub    %eax,%edx
80105543:	85 d2                	test   %edx,%edx
80105545:	7f f1                	jg     80105538 <strncpy+0x48>
}
80105547:	5b                   	pop    %ebx
80105548:	89 f0                	mov    %esi,%eax
8010554a:	5e                   	pop    %esi
8010554b:	5f                   	pop    %edi
8010554c:	5d                   	pop    %ebp
8010554d:	c3                   	ret
8010554e:	66 90                	xchg   %ax,%ax

80105550 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	56                   	push   %esi
80105554:	8b 55 10             	mov    0x10(%ebp),%edx
80105557:	8b 75 08             	mov    0x8(%ebp),%esi
8010555a:	53                   	push   %ebx
8010555b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010555e:	85 d2                	test   %edx,%edx
80105560:	7e 25                	jle    80105587 <safestrcpy+0x37>
80105562:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105566:	89 f2                	mov    %esi,%edx
80105568:	eb 16                	jmp    80105580 <safestrcpy+0x30>
8010556a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105570:	0f b6 08             	movzbl (%eax),%ecx
80105573:	83 c0 01             	add    $0x1,%eax
80105576:	83 c2 01             	add    $0x1,%edx
80105579:	88 4a ff             	mov    %cl,-0x1(%edx)
8010557c:	84 c9                	test   %cl,%cl
8010557e:	74 04                	je     80105584 <safestrcpy+0x34>
80105580:	39 d8                	cmp    %ebx,%eax
80105582:	75 ec                	jne    80105570 <safestrcpy+0x20>
    ;
  *s = 0;
80105584:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105587:	89 f0                	mov    %esi,%eax
80105589:	5b                   	pop    %ebx
8010558a:	5e                   	pop    %esi
8010558b:	5d                   	pop    %ebp
8010558c:	c3                   	ret
8010558d:	8d 76 00             	lea    0x0(%esi),%esi

80105590 <strlen>:

int
strlen(const char *s)
{
80105590:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105591:	31 c0                	xor    %eax,%eax
{
80105593:	89 e5                	mov    %esp,%ebp
80105595:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105598:	80 3a 00             	cmpb   $0x0,(%edx)
8010559b:	74 0c                	je     801055a9 <strlen+0x19>
8010559d:	8d 76 00             	lea    0x0(%esi),%esi
801055a0:	83 c0 01             	add    $0x1,%eax
801055a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801055a7:	75 f7                	jne    801055a0 <strlen+0x10>
    ;
  return n;
}
801055a9:	5d                   	pop    %ebp
801055aa:	c3                   	ret

801055ab <swtch>:
801055ab:	8b 44 24 04          	mov    0x4(%esp),%eax
801055af:	8b 54 24 08          	mov    0x8(%esp),%edx
801055b3:	55                   	push   %ebp
801055b4:	53                   	push   %ebx
801055b5:	56                   	push   %esi
801055b6:	57                   	push   %edi
801055b7:	89 20                	mov    %esp,(%eax)
801055b9:	89 d4                	mov    %edx,%esp
801055bb:	5f                   	pop    %edi
801055bc:	5e                   	pop    %esi
801055bd:	5b                   	pop    %ebx
801055be:	5d                   	pop    %ebp
801055bf:	c3                   	ret

801055c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	53                   	push   %ebx
801055c4:	83 ec 04             	sub    $0x4,%esp
801055c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801055ca:	e8 91 f0 ff ff       	call   80104660 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055cf:	8b 00                	mov    (%eax),%eax
801055d1:	39 c3                	cmp    %eax,%ebx
801055d3:	73 1b                	jae    801055f0 <fetchint+0x30>
801055d5:	8d 53 04             	lea    0x4(%ebx),%edx
801055d8:	39 d0                	cmp    %edx,%eax
801055da:	72 14                	jb     801055f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801055dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801055df:	8b 13                	mov    (%ebx),%edx
801055e1:	89 10                	mov    %edx,(%eax)
  return 0;
801055e3:	31 c0                	xor    %eax,%eax
}
801055e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055e8:	c9                   	leave
801055e9:	c3                   	ret
801055ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801055f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055f5:	eb ee                	jmp    801055e5 <fetchint+0x25>
801055f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055fe:	00 
801055ff:	90                   	nop

80105600 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	53                   	push   %ebx
80105604:	83 ec 04             	sub    $0x4,%esp
80105607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010560a:	e8 51 f0 ff ff       	call   80104660 <myproc>

  if(addr >= curproc->sz)
8010560f:	3b 18                	cmp    (%eax),%ebx
80105611:	73 2d                	jae    80105640 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105613:	8b 55 0c             	mov    0xc(%ebp),%edx
80105616:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105618:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010561a:	39 d3                	cmp    %edx,%ebx
8010561c:	73 22                	jae    80105640 <fetchstr+0x40>
8010561e:	89 d8                	mov    %ebx,%eax
80105620:	eb 0d                	jmp    8010562f <fetchstr+0x2f>
80105622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105628:	83 c0 01             	add    $0x1,%eax
8010562b:	39 d0                	cmp    %edx,%eax
8010562d:	73 11                	jae    80105640 <fetchstr+0x40>
    if(*s == 0)
8010562f:	80 38 00             	cmpb   $0x0,(%eax)
80105632:	75 f4                	jne    80105628 <fetchstr+0x28>
      return s - *pp;
80105634:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105636:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105639:	c9                   	leave
8010563a:	c3                   	ret
8010563b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105640:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105643:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105648:	c9                   	leave
80105649:	c3                   	ret
8010564a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105650 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	56                   	push   %esi
80105654:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105655:	e8 06 f0 ff ff       	call   80104660 <myproc>
8010565a:	8b 55 08             	mov    0x8(%ebp),%edx
8010565d:	8b 40 18             	mov    0x18(%eax),%eax
80105660:	8b 40 44             	mov    0x44(%eax),%eax
80105663:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105666:	e8 f5 ef ff ff       	call   80104660 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010566b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010566e:	8b 00                	mov    (%eax),%eax
80105670:	39 c6                	cmp    %eax,%esi
80105672:	73 1c                	jae    80105690 <argint+0x40>
80105674:	8d 53 08             	lea    0x8(%ebx),%edx
80105677:	39 d0                	cmp    %edx,%eax
80105679:	72 15                	jb     80105690 <argint+0x40>
  *ip = *(int*)(addr);
8010567b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010567e:	8b 53 04             	mov    0x4(%ebx),%edx
80105681:	89 10                	mov    %edx,(%eax)
  return 0;
80105683:	31 c0                	xor    %eax,%eax
}
80105685:	5b                   	pop    %ebx
80105686:	5e                   	pop    %esi
80105687:	5d                   	pop    %ebp
80105688:	c3                   	ret
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105695:	eb ee                	jmp    80105685 <argint+0x35>
80105697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010569e:	00 
8010569f:	90                   	nop

801056a0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	57                   	push   %edi
801056a4:	56                   	push   %esi
801056a5:	53                   	push   %ebx
801056a6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801056a9:	e8 b2 ef ff ff       	call   80104660 <myproc>
801056ae:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056b0:	e8 ab ef ff ff       	call   80104660 <myproc>
801056b5:	8b 55 08             	mov    0x8(%ebp),%edx
801056b8:	8b 40 18             	mov    0x18(%eax),%eax
801056bb:	8b 40 44             	mov    0x44(%eax),%eax
801056be:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801056c1:	e8 9a ef ff ff       	call   80104660 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056c6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801056c9:	8b 00                	mov    (%eax),%eax
801056cb:	39 c7                	cmp    %eax,%edi
801056cd:	73 31                	jae    80105700 <argptr+0x60>
801056cf:	8d 4b 08             	lea    0x8(%ebx),%ecx
801056d2:	39 c8                	cmp    %ecx,%eax
801056d4:	72 2a                	jb     80105700 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801056d6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801056d9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801056dc:	85 d2                	test   %edx,%edx
801056de:	78 20                	js     80105700 <argptr+0x60>
801056e0:	8b 16                	mov    (%esi),%edx
801056e2:	39 d0                	cmp    %edx,%eax
801056e4:	73 1a                	jae    80105700 <argptr+0x60>
801056e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801056e9:	01 c3                	add    %eax,%ebx
801056eb:	39 da                	cmp    %ebx,%edx
801056ed:	72 11                	jb     80105700 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801056ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801056f2:	89 02                	mov    %eax,(%edx)
  return 0;
801056f4:	31 c0                	xor    %eax,%eax
}
801056f6:	83 c4 0c             	add    $0xc,%esp
801056f9:	5b                   	pop    %ebx
801056fa:	5e                   	pop    %esi
801056fb:	5f                   	pop    %edi
801056fc:	5d                   	pop    %ebp
801056fd:	c3                   	ret
801056fe:	66 90                	xchg   %ax,%ax
    return -1;
80105700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105705:	eb ef                	jmp    801056f6 <argptr+0x56>
80105707:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010570e:	00 
8010570f:	90                   	nop

80105710 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	56                   	push   %esi
80105714:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105715:	e8 46 ef ff ff       	call   80104660 <myproc>
8010571a:	8b 55 08             	mov    0x8(%ebp),%edx
8010571d:	8b 40 18             	mov    0x18(%eax),%eax
80105720:	8b 40 44             	mov    0x44(%eax),%eax
80105723:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105726:	e8 35 ef ff ff       	call   80104660 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010572b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010572e:	8b 00                	mov    (%eax),%eax
80105730:	39 c6                	cmp    %eax,%esi
80105732:	73 44                	jae    80105778 <argstr+0x68>
80105734:	8d 53 08             	lea    0x8(%ebx),%edx
80105737:	39 d0                	cmp    %edx,%eax
80105739:	72 3d                	jb     80105778 <argstr+0x68>
  *ip = *(int*)(addr);
8010573b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010573e:	e8 1d ef ff ff       	call   80104660 <myproc>
  if(addr >= curproc->sz)
80105743:	3b 18                	cmp    (%eax),%ebx
80105745:	73 31                	jae    80105778 <argstr+0x68>
  *pp = (char*)addr;
80105747:	8b 55 0c             	mov    0xc(%ebp),%edx
8010574a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010574c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010574e:	39 d3                	cmp    %edx,%ebx
80105750:	73 26                	jae    80105778 <argstr+0x68>
80105752:	89 d8                	mov    %ebx,%eax
80105754:	eb 11                	jmp    80105767 <argstr+0x57>
80105756:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010575d:	00 
8010575e:	66 90                	xchg   %ax,%ax
80105760:	83 c0 01             	add    $0x1,%eax
80105763:	39 d0                	cmp    %edx,%eax
80105765:	73 11                	jae    80105778 <argstr+0x68>
    if(*s == 0)
80105767:	80 38 00             	cmpb   $0x0,(%eax)
8010576a:	75 f4                	jne    80105760 <argstr+0x50>
      return s - *pp;
8010576c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010576e:	5b                   	pop    %ebx
8010576f:	5e                   	pop    %esi
80105770:	5d                   	pop    %ebp
80105771:	c3                   	ret
80105772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105778:	5b                   	pop    %ebx
    return -1;
80105779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010577e:	5e                   	pop    %esi
8010577f:	5d                   	pop    %ebp
80105780:	c3                   	ret
80105781:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105788:	00 
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105790 <syscall>:
[SYS_move_file] sys_move_file,
};

void
syscall(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	53                   	push   %ebx
80105794:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105797:	e8 c4 ee ff ff       	call   80104660 <myproc>
8010579c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010579e:	8b 40 18             	mov    0x18(%eax),%eax
801057a1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801057a4:	8d 50 ff             	lea    -0x1(%eax),%edx
801057a7:	83 fa 16             	cmp    $0x16,%edx
801057aa:	77 24                	ja     801057d0 <syscall+0x40>
801057ac:	8b 14 85 e0 89 10 80 	mov    -0x7fef7620(,%eax,4),%edx
801057b3:	85 d2                	test   %edx,%edx
801057b5:	74 19                	je     801057d0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801057b7:	ff d2                	call   *%edx
801057b9:	89 c2                	mov    %eax,%edx
801057bb:	8b 43 18             	mov    0x18(%ebx),%eax
801057be:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801057c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c4:	c9                   	leave
801057c5:	c3                   	ret
801057c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057cd:	00 
801057ce:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
801057d0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801057d1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801057d4:	50                   	push   %eax
801057d5:	ff 73 10             	push   0x10(%ebx)
801057d8:	68 f9 83 10 80       	push   $0x801083f9
801057dd:	e8 ae b2 ff ff       	call   80100a90 <cprintf>
    curproc->tf->eax = -1;
801057e2:	8b 43 18             	mov    0x18(%ebx),%eax
801057e5:	83 c4 10             	add    $0x10,%esp
801057e8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801057ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f2:	c9                   	leave
801057f3:	c3                   	ret
801057f4:	66 90                	xchg   %ax,%ax
801057f6:	66 90                	xchg   %ax,%ax
801057f8:	66 90                	xchg   %ax,%ax
801057fa:	66 90                	xchg   %ax,%ax
801057fc:	66 90                	xchg   %ax,%ax
801057fe:	66 90                	xchg   %ax,%ax

80105800 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105805:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105808:	53                   	push   %ebx
80105809:	83 ec 34             	sub    $0x34,%esp
8010580c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010580f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105812:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105815:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105818:	57                   	push   %edi
80105819:	50                   	push   %eax
8010581a:	e8 81 d5 ff ff       	call   80102da0 <nameiparent>
8010581f:	83 c4 10             	add    $0x10,%esp
80105822:	85 c0                	test   %eax,%eax
80105824:	74 5e                	je     80105884 <create+0x84>
    return 0;
  ilock(dp);
80105826:	83 ec 0c             	sub    $0xc,%esp
80105829:	89 c3                	mov    %eax,%ebx
8010582b:	50                   	push   %eax
8010582c:	e8 6f cc ff ff       	call   801024a0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105831:	83 c4 0c             	add    $0xc,%esp
80105834:	6a 00                	push   $0x0
80105836:	57                   	push   %edi
80105837:	53                   	push   %ebx
80105838:	e8 b3 d1 ff ff       	call   801029f0 <dirlookup>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	89 c6                	mov    %eax,%esi
80105842:	85 c0                	test   %eax,%eax
80105844:	74 4a                	je     80105890 <create+0x90>
    iunlockput(dp);
80105846:	83 ec 0c             	sub    $0xc,%esp
80105849:	53                   	push   %ebx
8010584a:	e8 e1 ce ff ff       	call   80102730 <iunlockput>
    ilock(ip);
8010584f:	89 34 24             	mov    %esi,(%esp)
80105852:	e8 49 cc ff ff       	call   801024a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105857:	83 c4 10             	add    $0x10,%esp
8010585a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010585f:	75 17                	jne    80105878 <create+0x78>
80105861:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105866:	75 10                	jne    80105878 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010586b:	89 f0                	mov    %esi,%eax
8010586d:	5b                   	pop    %ebx
8010586e:	5e                   	pop    %esi
8010586f:	5f                   	pop    %edi
80105870:	5d                   	pop    %ebp
80105871:	c3                   	ret
80105872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	56                   	push   %esi
8010587c:	e8 af ce ff ff       	call   80102730 <iunlockput>
    return 0;
80105881:	83 c4 10             	add    $0x10,%esp
}
80105884:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105887:	31 f6                	xor    %esi,%esi
}
80105889:	5b                   	pop    %ebx
8010588a:	89 f0                	mov    %esi,%eax
8010588c:	5e                   	pop    %esi
8010588d:	5f                   	pop    %edi
8010588e:	5d                   	pop    %ebp
8010588f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105890:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	50                   	push   %eax
80105898:	ff 33                	push   (%ebx)
8010589a:	e8 91 ca ff ff       	call   80102330 <ialloc>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	89 c6                	mov    %eax,%esi
801058a4:	85 c0                	test   %eax,%eax
801058a6:	0f 84 bc 00 00 00    	je     80105968 <create+0x168>
  ilock(ip);
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	50                   	push   %eax
801058b0:	e8 eb cb ff ff       	call   801024a0 <ilock>
  ip->major = major;
801058b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801058b9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801058bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801058c1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801058c5:	b8 01 00 00 00       	mov    $0x1,%eax
801058ca:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801058ce:	89 34 24             	mov    %esi,(%esp)
801058d1:	e8 1a cb ff ff       	call   801023f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801058de:	74 30                	je     80105910 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
801058e0:	83 ec 04             	sub    $0x4,%esp
801058e3:	ff 76 04             	push   0x4(%esi)
801058e6:	57                   	push   %edi
801058e7:	53                   	push   %ebx
801058e8:	e8 d3 d3 ff ff       	call   80102cc0 <dirlink>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	78 67                	js     8010595b <create+0x15b>
  iunlockput(dp);
801058f4:	83 ec 0c             	sub    $0xc,%esp
801058f7:	53                   	push   %ebx
801058f8:	e8 33 ce ff ff       	call   80102730 <iunlockput>
  return ip;
801058fd:	83 c4 10             	add    $0x10,%esp
}
80105900:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105903:	89 f0                	mov    %esi,%eax
80105905:	5b                   	pop    %ebx
80105906:	5e                   	pop    %esi
80105907:	5f                   	pop    %edi
80105908:	5d                   	pop    %ebp
80105909:	c3                   	ret
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105910:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105913:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105918:	53                   	push   %ebx
80105919:	e8 d2 ca ff ff       	call   801023f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010591e:	83 c4 0c             	add    $0xc,%esp
80105921:	ff 76 04             	push   0x4(%esi)
80105924:	68 31 84 10 80       	push   $0x80108431
80105929:	56                   	push   %esi
8010592a:	e8 91 d3 ff ff       	call   80102cc0 <dirlink>
8010592f:	83 c4 10             	add    $0x10,%esp
80105932:	85 c0                	test   %eax,%eax
80105934:	78 18                	js     8010594e <create+0x14e>
80105936:	83 ec 04             	sub    $0x4,%esp
80105939:	ff 73 04             	push   0x4(%ebx)
8010593c:	68 30 84 10 80       	push   $0x80108430
80105941:	56                   	push   %esi
80105942:	e8 79 d3 ff ff       	call   80102cc0 <dirlink>
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	85 c0                	test   %eax,%eax
8010594c:	79 92                	jns    801058e0 <create+0xe0>
      panic("create dots");
8010594e:	83 ec 0c             	sub    $0xc,%esp
80105951:	68 24 84 10 80       	push   $0x80108424
80105956:	e8 b5 ab ff ff       	call   80100510 <panic>
    panic("create: dirlink");
8010595b:	83 ec 0c             	sub    $0xc,%esp
8010595e:	68 33 84 10 80       	push   $0x80108433
80105963:	e8 a8 ab ff ff       	call   80100510 <panic>
    panic("create: ialloc");
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	68 15 84 10 80       	push   $0x80108415
80105970:	e8 9b ab ff ff       	call   80100510 <panic>
80105975:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010597c:	00 
8010597d:	8d 76 00             	lea    0x0(%esi),%esi

80105980 <sys_dup>:
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	56                   	push   %esi
80105984:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105985:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105988:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010598b:	50                   	push   %eax
8010598c:	6a 00                	push   $0x0
8010598e:	e8 bd fc ff ff       	call   80105650 <argint>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	78 36                	js     801059d0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010599a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010599e:	77 30                	ja     801059d0 <sys_dup+0x50>
801059a0:	e8 bb ec ff ff       	call   80104660 <myproc>
801059a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059ac:	85 f6                	test   %esi,%esi
801059ae:	74 20                	je     801059d0 <sys_dup+0x50>
  struct proc *curproc = myproc();
801059b0:	e8 ab ec ff ff       	call   80104660 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059b5:	31 db                	xor    %ebx,%ebx
801059b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059be:	00 
801059bf:	90                   	nop
    if(curproc->ofile[fd] == 0){
801059c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059c4:	85 d2                	test   %edx,%edx
801059c6:	74 18                	je     801059e0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801059c8:	83 c3 01             	add    $0x1,%ebx
801059cb:	83 fb 10             	cmp    $0x10,%ebx
801059ce:	75 f0                	jne    801059c0 <sys_dup+0x40>
}
801059d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801059d3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801059d8:	89 d8                	mov    %ebx,%eax
801059da:	5b                   	pop    %ebx
801059db:	5e                   	pop    %esi
801059dc:	5d                   	pop    %ebp
801059dd:	c3                   	ret
801059de:	66 90                	xchg   %ax,%ax
  filedup(f);
801059e0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059e3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801059e7:	56                   	push   %esi
801059e8:	e8 d3 c1 ff ff       	call   80101bc0 <filedup>
  return fd;
801059ed:	83 c4 10             	add    $0x10,%esp
}
801059f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059f3:	89 d8                	mov    %ebx,%eax
801059f5:	5b                   	pop    %ebx
801059f6:	5e                   	pop    %esi
801059f7:	5d                   	pop    %ebp
801059f8:	c3                   	ret
801059f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_read>:
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a05:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a0b:	53                   	push   %ebx
80105a0c:	6a 00                	push   $0x0
80105a0e:	e8 3d fc ff ff       	call   80105650 <argint>
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 5e                	js     80105a78 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a1e:	77 58                	ja     80105a78 <sys_read+0x78>
80105a20:	e8 3b ec ff ff       	call   80104660 <myproc>
80105a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a2c:	85 f6                	test   %esi,%esi
80105a2e:	74 48                	je     80105a78 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a30:	83 ec 08             	sub    $0x8,%esp
80105a33:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a36:	50                   	push   %eax
80105a37:	6a 02                	push   $0x2
80105a39:	e8 12 fc ff ff       	call   80105650 <argint>
80105a3e:	83 c4 10             	add    $0x10,%esp
80105a41:	85 c0                	test   %eax,%eax
80105a43:	78 33                	js     80105a78 <sys_read+0x78>
80105a45:	83 ec 04             	sub    $0x4,%esp
80105a48:	ff 75 f0             	push   -0x10(%ebp)
80105a4b:	53                   	push   %ebx
80105a4c:	6a 01                	push   $0x1
80105a4e:	e8 4d fc ff ff       	call   801056a0 <argptr>
80105a53:	83 c4 10             	add    $0x10,%esp
80105a56:	85 c0                	test   %eax,%eax
80105a58:	78 1e                	js     80105a78 <sys_read+0x78>
  return fileread(f, p, n);
80105a5a:	83 ec 04             	sub    $0x4,%esp
80105a5d:	ff 75 f0             	push   -0x10(%ebp)
80105a60:	ff 75 f4             	push   -0xc(%ebp)
80105a63:	56                   	push   %esi
80105a64:	e8 d7 c2 ff ff       	call   80101d40 <fileread>
80105a69:	83 c4 10             	add    $0x10,%esp
}
80105a6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a6f:	5b                   	pop    %ebx
80105a70:	5e                   	pop    %esi
80105a71:	5d                   	pop    %ebp
80105a72:	c3                   	ret
80105a73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105a78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a7d:	eb ed                	jmp    80105a6c <sys_read+0x6c>
80105a7f:	90                   	nop

80105a80 <sys_write>:
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	56                   	push   %esi
80105a84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a8b:	53                   	push   %ebx
80105a8c:	6a 00                	push   $0x0
80105a8e:	e8 bd fb ff ff       	call   80105650 <argint>
80105a93:	83 c4 10             	add    $0x10,%esp
80105a96:	85 c0                	test   %eax,%eax
80105a98:	78 5e                	js     80105af8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a9e:	77 58                	ja     80105af8 <sys_write+0x78>
80105aa0:	e8 bb eb ff ff       	call   80104660 <myproc>
80105aa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105aac:	85 f6                	test   %esi,%esi
80105aae:	74 48                	je     80105af8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105ab0:	83 ec 08             	sub    $0x8,%esp
80105ab3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ab6:	50                   	push   %eax
80105ab7:	6a 02                	push   $0x2
80105ab9:	e8 92 fb ff ff       	call   80105650 <argint>
80105abe:	83 c4 10             	add    $0x10,%esp
80105ac1:	85 c0                	test   %eax,%eax
80105ac3:	78 33                	js     80105af8 <sys_write+0x78>
80105ac5:	83 ec 04             	sub    $0x4,%esp
80105ac8:	ff 75 f0             	push   -0x10(%ebp)
80105acb:	53                   	push   %ebx
80105acc:	6a 01                	push   $0x1
80105ace:	e8 cd fb ff ff       	call   801056a0 <argptr>
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	85 c0                	test   %eax,%eax
80105ad8:	78 1e                	js     80105af8 <sys_write+0x78>
  return filewrite(f, p, n);
80105ada:	83 ec 04             	sub    $0x4,%esp
80105add:	ff 75 f0             	push   -0x10(%ebp)
80105ae0:	ff 75 f4             	push   -0xc(%ebp)
80105ae3:	56                   	push   %esi
80105ae4:	e8 e7 c2 ff ff       	call   80101dd0 <filewrite>
80105ae9:	83 c4 10             	add    $0x10,%esp
}
80105aec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105aef:	5b                   	pop    %ebx
80105af0:	5e                   	pop    %esi
80105af1:	5d                   	pop    %ebp
80105af2:	c3                   	ret
80105af3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105af8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afd:	eb ed                	jmp    80105aec <sys_write+0x6c>
80105aff:	90                   	nop

80105b00 <sys_close>:
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	56                   	push   %esi
80105b04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105b05:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105b0b:	50                   	push   %eax
80105b0c:	6a 00                	push   $0x0
80105b0e:	e8 3d fb ff ff       	call   80105650 <argint>
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	85 c0                	test   %eax,%eax
80105b18:	78 3e                	js     80105b58 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105b1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b1e:	77 38                	ja     80105b58 <sys_close+0x58>
80105b20:	e8 3b eb ff ff       	call   80104660 <myproc>
80105b25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b28:	8d 5a 08             	lea    0x8(%edx),%ebx
80105b2b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105b2f:	85 f6                	test   %esi,%esi
80105b31:	74 25                	je     80105b58 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105b33:	e8 28 eb ff ff       	call   80104660 <myproc>
  fileclose(f);
80105b38:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105b3b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105b42:	00 
  fileclose(f);
80105b43:	56                   	push   %esi
80105b44:	e8 c7 c0 ff ff       	call   80101c10 <fileclose>
  return 0;
80105b49:	83 c4 10             	add    $0x10,%esp
80105b4c:	31 c0                	xor    %eax,%eax
}
80105b4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b51:	5b                   	pop    %ebx
80105b52:	5e                   	pop    %esi
80105b53:	5d                   	pop    %ebp
80105b54:	c3                   	ret
80105b55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b5d:	eb ef                	jmp    80105b4e <sys_close+0x4e>
80105b5f:	90                   	nop

80105b60 <sys_fstat>:
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	56                   	push   %esi
80105b64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105b65:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105b68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105b6b:	53                   	push   %ebx
80105b6c:	6a 00                	push   $0x0
80105b6e:	e8 dd fa ff ff       	call   80105650 <argint>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 c0                	test   %eax,%eax
80105b78:	78 46                	js     80105bc0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105b7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b7e:	77 40                	ja     80105bc0 <sys_fstat+0x60>
80105b80:	e8 db ea ff ff       	call   80104660 <myproc>
80105b85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105b8c:	85 f6                	test   %esi,%esi
80105b8e:	74 30                	je     80105bc0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105b90:	83 ec 04             	sub    $0x4,%esp
80105b93:	6a 14                	push   $0x14
80105b95:	53                   	push   %ebx
80105b96:	6a 01                	push   $0x1
80105b98:	e8 03 fb ff ff       	call   801056a0 <argptr>
80105b9d:	83 c4 10             	add    $0x10,%esp
80105ba0:	85 c0                	test   %eax,%eax
80105ba2:	78 1c                	js     80105bc0 <sys_fstat+0x60>
  return filestat(f, st);
80105ba4:	83 ec 08             	sub    $0x8,%esp
80105ba7:	ff 75 f4             	push   -0xc(%ebp)
80105baa:	56                   	push   %esi
80105bab:	e8 40 c1 ff ff       	call   80101cf0 <filestat>
80105bb0:	83 c4 10             	add    $0x10,%esp
}
80105bb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bb6:	5b                   	pop    %ebx
80105bb7:	5e                   	pop    %esi
80105bb8:	5d                   	pop    %ebp
80105bb9:	c3                   	ret
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	eb ec                	jmp    80105bb3 <sys_fstat+0x53>
80105bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bce:	00 
80105bcf:	90                   	nop

80105bd0 <sys_link>:
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	57                   	push   %edi
80105bd4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105bd5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105bd8:	53                   	push   %ebx
80105bd9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105bdc:	50                   	push   %eax
80105bdd:	6a 00                	push   $0x0
80105bdf:	e8 2c fb ff ff       	call   80105710 <argstr>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	85 c0                	test   %eax,%eax
80105be9:	0f 88 fb 00 00 00    	js     80105cea <sys_link+0x11a>
80105bef:	83 ec 08             	sub    $0x8,%esp
80105bf2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105bf5:	50                   	push   %eax
80105bf6:	6a 01                	push   $0x1
80105bf8:	e8 13 fb ff ff       	call   80105710 <argstr>
80105bfd:	83 c4 10             	add    $0x10,%esp
80105c00:	85 c0                	test   %eax,%eax
80105c02:	0f 88 e2 00 00 00    	js     80105cea <sys_link+0x11a>
  begin_op();
80105c08:	e8 33 de ff ff       	call   80103a40 <begin_op>
  if((ip = namei(old)) == 0){
80105c0d:	83 ec 0c             	sub    $0xc,%esp
80105c10:	ff 75 d4             	push   -0x2c(%ebp)
80105c13:	e8 68 d1 ff ff       	call   80102d80 <namei>
80105c18:	83 c4 10             	add    $0x10,%esp
80105c1b:	89 c3                	mov    %eax,%ebx
80105c1d:	85 c0                	test   %eax,%eax
80105c1f:	0f 84 df 00 00 00    	je     80105d04 <sys_link+0x134>
  ilock(ip);
80105c25:	83 ec 0c             	sub    $0xc,%esp
80105c28:	50                   	push   %eax
80105c29:	e8 72 c8 ff ff       	call   801024a0 <ilock>
  if(ip->type == T_DIR){
80105c2e:	83 c4 10             	add    $0x10,%esp
80105c31:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c36:	0f 84 b5 00 00 00    	je     80105cf1 <sys_link+0x121>
  iupdate(ip);
80105c3c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105c3f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105c44:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105c47:	53                   	push   %ebx
80105c48:	e8 a3 c7 ff ff       	call   801023f0 <iupdate>
  iunlock(ip);
80105c4d:	89 1c 24             	mov    %ebx,(%esp)
80105c50:	e8 2b c9 ff ff       	call   80102580 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105c55:	58                   	pop    %eax
80105c56:	5a                   	pop    %edx
80105c57:	57                   	push   %edi
80105c58:	ff 75 d0             	push   -0x30(%ebp)
80105c5b:	e8 40 d1 ff ff       	call   80102da0 <nameiparent>
80105c60:	83 c4 10             	add    $0x10,%esp
80105c63:	89 c6                	mov    %eax,%esi
80105c65:	85 c0                	test   %eax,%eax
80105c67:	74 5b                	je     80105cc4 <sys_link+0xf4>
  ilock(dp);
80105c69:	83 ec 0c             	sub    $0xc,%esp
80105c6c:	50                   	push   %eax
80105c6d:	e8 2e c8 ff ff       	call   801024a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105c72:	8b 03                	mov    (%ebx),%eax
80105c74:	83 c4 10             	add    $0x10,%esp
80105c77:	39 06                	cmp    %eax,(%esi)
80105c79:	75 3d                	jne    80105cb8 <sys_link+0xe8>
80105c7b:	83 ec 04             	sub    $0x4,%esp
80105c7e:	ff 73 04             	push   0x4(%ebx)
80105c81:	57                   	push   %edi
80105c82:	56                   	push   %esi
80105c83:	e8 38 d0 ff ff       	call   80102cc0 <dirlink>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	78 29                	js     80105cb8 <sys_link+0xe8>
  iunlockput(dp);
80105c8f:	83 ec 0c             	sub    $0xc,%esp
80105c92:	56                   	push   %esi
80105c93:	e8 98 ca ff ff       	call   80102730 <iunlockput>
  iput(ip);
80105c98:	89 1c 24             	mov    %ebx,(%esp)
80105c9b:	e8 30 c9 ff ff       	call   801025d0 <iput>
  end_op();
80105ca0:	e8 0b de ff ff       	call   80103ab0 <end_op>
  return 0;
80105ca5:	83 c4 10             	add    $0x10,%esp
80105ca8:	31 c0                	xor    %eax,%eax
}
80105caa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cad:	5b                   	pop    %ebx
80105cae:	5e                   	pop    %esi
80105caf:	5f                   	pop    %edi
80105cb0:	5d                   	pop    %ebp
80105cb1:	c3                   	ret
80105cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105cb8:	83 ec 0c             	sub    $0xc,%esp
80105cbb:	56                   	push   %esi
80105cbc:	e8 6f ca ff ff       	call   80102730 <iunlockput>
    goto bad;
80105cc1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105cc4:	83 ec 0c             	sub    $0xc,%esp
80105cc7:	53                   	push   %ebx
80105cc8:	e8 d3 c7 ff ff       	call   801024a0 <ilock>
  ip->nlink--;
80105ccd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cd2:	89 1c 24             	mov    %ebx,(%esp)
80105cd5:	e8 16 c7 ff ff       	call   801023f0 <iupdate>
  iunlockput(ip);
80105cda:	89 1c 24             	mov    %ebx,(%esp)
80105cdd:	e8 4e ca ff ff       	call   80102730 <iunlockput>
  end_op();
80105ce2:	e8 c9 dd ff ff       	call   80103ab0 <end_op>
  return -1;
80105ce7:	83 c4 10             	add    $0x10,%esp
    return -1;
80105cea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cef:	eb b9                	jmp    80105caa <sys_link+0xda>
    iunlockput(ip);
80105cf1:	83 ec 0c             	sub    $0xc,%esp
80105cf4:	53                   	push   %ebx
80105cf5:	e8 36 ca ff ff       	call   80102730 <iunlockput>
    end_op();
80105cfa:	e8 b1 dd ff ff       	call   80103ab0 <end_op>
    return -1;
80105cff:	83 c4 10             	add    $0x10,%esp
80105d02:	eb e6                	jmp    80105cea <sys_link+0x11a>
    end_op();
80105d04:	e8 a7 dd ff ff       	call   80103ab0 <end_op>
    return -1;
80105d09:	eb df                	jmp    80105cea <sys_link+0x11a>
80105d0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105d10 <sys_unlink>:
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105d15:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105d18:	53                   	push   %ebx
80105d19:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105d1c:	50                   	push   %eax
80105d1d:	6a 00                	push   $0x0
80105d1f:	e8 ec f9 ff ff       	call   80105710 <argstr>
80105d24:	83 c4 10             	add    $0x10,%esp
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 88 54 01 00 00    	js     80105e83 <sys_unlink+0x173>
  begin_op();
80105d2f:	e8 0c dd ff ff       	call   80103a40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105d34:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105d37:	83 ec 08             	sub    $0x8,%esp
80105d3a:	53                   	push   %ebx
80105d3b:	ff 75 c0             	push   -0x40(%ebp)
80105d3e:	e8 5d d0 ff ff       	call   80102da0 <nameiparent>
80105d43:	83 c4 10             	add    $0x10,%esp
80105d46:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105d49:	85 c0                	test   %eax,%eax
80105d4b:	0f 84 58 01 00 00    	je     80105ea9 <sys_unlink+0x199>
  ilock(dp);
80105d51:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105d54:	83 ec 0c             	sub    $0xc,%esp
80105d57:	57                   	push   %edi
80105d58:	e8 43 c7 ff ff       	call   801024a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105d5d:	58                   	pop    %eax
80105d5e:	5a                   	pop    %edx
80105d5f:	68 31 84 10 80       	push   $0x80108431
80105d64:	53                   	push   %ebx
80105d65:	e8 66 cc ff ff       	call   801029d0 <namecmp>
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	85 c0                	test   %eax,%eax
80105d6f:	0f 84 fb 00 00 00    	je     80105e70 <sys_unlink+0x160>
80105d75:	83 ec 08             	sub    $0x8,%esp
80105d78:	68 30 84 10 80       	push   $0x80108430
80105d7d:	53                   	push   %ebx
80105d7e:	e8 4d cc ff ff       	call   801029d0 <namecmp>
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	85 c0                	test   %eax,%eax
80105d88:	0f 84 e2 00 00 00    	je     80105e70 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105d8e:	83 ec 04             	sub    $0x4,%esp
80105d91:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105d94:	50                   	push   %eax
80105d95:	53                   	push   %ebx
80105d96:	57                   	push   %edi
80105d97:	e8 54 cc ff ff       	call   801029f0 <dirlookup>
80105d9c:	83 c4 10             	add    $0x10,%esp
80105d9f:	89 c3                	mov    %eax,%ebx
80105da1:	85 c0                	test   %eax,%eax
80105da3:	0f 84 c7 00 00 00    	je     80105e70 <sys_unlink+0x160>
  ilock(ip);
80105da9:	83 ec 0c             	sub    $0xc,%esp
80105dac:	50                   	push   %eax
80105dad:	e8 ee c6 ff ff       	call   801024a0 <ilock>
  if(ip->nlink < 1)
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105dba:	0f 8e 0a 01 00 00    	jle    80105eca <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105dc0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105dc5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105dc8:	74 66                	je     80105e30 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105dca:	83 ec 04             	sub    $0x4,%esp
80105dcd:	6a 10                	push   $0x10
80105dcf:	6a 00                	push   $0x0
80105dd1:	57                   	push   %edi
80105dd2:	e8 c9 f5 ff ff       	call   801053a0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105dd7:	6a 10                	push   $0x10
80105dd9:	ff 75 c4             	push   -0x3c(%ebp)
80105ddc:	57                   	push   %edi
80105ddd:	ff 75 b4             	push   -0x4c(%ebp)
80105de0:	e8 cb ca ff ff       	call   801028b0 <writei>
80105de5:	83 c4 20             	add    $0x20,%esp
80105de8:	83 f8 10             	cmp    $0x10,%eax
80105deb:	0f 85 cc 00 00 00    	jne    80105ebd <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105df1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105df6:	0f 84 94 00 00 00    	je     80105e90 <sys_unlink+0x180>
  iunlockput(dp);
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	ff 75 b4             	push   -0x4c(%ebp)
80105e02:	e8 29 c9 ff ff       	call   80102730 <iunlockput>
  ip->nlink--;
80105e07:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105e0c:	89 1c 24             	mov    %ebx,(%esp)
80105e0f:	e8 dc c5 ff ff       	call   801023f0 <iupdate>
  iunlockput(ip);
80105e14:	89 1c 24             	mov    %ebx,(%esp)
80105e17:	e8 14 c9 ff ff       	call   80102730 <iunlockput>
  end_op();
80105e1c:	e8 8f dc ff ff       	call   80103ab0 <end_op>
  return 0;
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	31 c0                	xor    %eax,%eax
}
80105e26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e29:	5b                   	pop    %ebx
80105e2a:	5e                   	pop    %esi
80105e2b:	5f                   	pop    %edi
80105e2c:	5d                   	pop    %ebp
80105e2d:	c3                   	ret
80105e2e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105e30:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105e34:	76 94                	jbe    80105dca <sys_unlink+0xba>
80105e36:	be 20 00 00 00       	mov    $0x20,%esi
80105e3b:	eb 0b                	jmp    80105e48 <sys_unlink+0x138>
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi
80105e40:	83 c6 10             	add    $0x10,%esi
80105e43:	3b 73 58             	cmp    0x58(%ebx),%esi
80105e46:	73 82                	jae    80105dca <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e48:	6a 10                	push   $0x10
80105e4a:	56                   	push   %esi
80105e4b:	57                   	push   %edi
80105e4c:	53                   	push   %ebx
80105e4d:	e8 5e c9 ff ff       	call   801027b0 <readi>
80105e52:	83 c4 10             	add    $0x10,%esp
80105e55:	83 f8 10             	cmp    $0x10,%eax
80105e58:	75 56                	jne    80105eb0 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105e5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105e5f:	74 df                	je     80105e40 <sys_unlink+0x130>
    iunlockput(ip);
80105e61:	83 ec 0c             	sub    $0xc,%esp
80105e64:	53                   	push   %ebx
80105e65:	e8 c6 c8 ff ff       	call   80102730 <iunlockput>
    goto bad;
80105e6a:	83 c4 10             	add    $0x10,%esp
80105e6d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	ff 75 b4             	push   -0x4c(%ebp)
80105e76:	e8 b5 c8 ff ff       	call   80102730 <iunlockput>
  end_op();
80105e7b:	e8 30 dc ff ff       	call   80103ab0 <end_op>
  return -1;
80105e80:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e88:	eb 9c                	jmp    80105e26 <sys_unlink+0x116>
80105e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105e90:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105e93:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105e96:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105e9b:	50                   	push   %eax
80105e9c:	e8 4f c5 ff ff       	call   801023f0 <iupdate>
80105ea1:	83 c4 10             	add    $0x10,%esp
80105ea4:	e9 53 ff ff ff       	jmp    80105dfc <sys_unlink+0xec>
    end_op();
80105ea9:	e8 02 dc ff ff       	call   80103ab0 <end_op>
    return -1;
80105eae:	eb d3                	jmp    80105e83 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	68 55 84 10 80       	push   $0x80108455
80105eb8:	e8 53 a6 ff ff       	call   80100510 <panic>
    panic("unlink: writei");
80105ebd:	83 ec 0c             	sub    $0xc,%esp
80105ec0:	68 67 84 10 80       	push   $0x80108467
80105ec5:	e8 46 a6 ff ff       	call   80100510 <panic>
    panic("unlink: nlink < 1");
80105eca:	83 ec 0c             	sub    $0xc,%esp
80105ecd:	68 43 84 10 80       	push   $0x80108443
80105ed2:	e8 39 a6 ff ff       	call   80100510 <panic>
80105ed7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ede:	00 
80105edf:	90                   	nop

80105ee0 <sys_open>:

int
sys_open(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	57                   	push   %edi
80105ee4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105ee5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105ee8:	53                   	push   %ebx
80105ee9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105eec:	50                   	push   %eax
80105eed:	6a 00                	push   $0x0
80105eef:	e8 1c f8 ff ff       	call   80105710 <argstr>
80105ef4:	83 c4 10             	add    $0x10,%esp
80105ef7:	85 c0                	test   %eax,%eax
80105ef9:	0f 88 8e 00 00 00    	js     80105f8d <sys_open+0xad>
80105eff:	83 ec 08             	sub    $0x8,%esp
80105f02:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f05:	50                   	push   %eax
80105f06:	6a 01                	push   $0x1
80105f08:	e8 43 f7 ff ff       	call   80105650 <argint>
80105f0d:	83 c4 10             	add    $0x10,%esp
80105f10:	85 c0                	test   %eax,%eax
80105f12:	78 79                	js     80105f8d <sys_open+0xad>
    return -1;

  begin_op();
80105f14:	e8 27 db ff ff       	call   80103a40 <begin_op>

  if(omode & O_CREATE){
80105f19:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105f1d:	75 79                	jne    80105f98 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105f1f:	83 ec 0c             	sub    $0xc,%esp
80105f22:	ff 75 e0             	push   -0x20(%ebp)
80105f25:	e8 56 ce ff ff       	call   80102d80 <namei>
80105f2a:	83 c4 10             	add    $0x10,%esp
80105f2d:	89 c6                	mov    %eax,%esi
80105f2f:	85 c0                	test   %eax,%eax
80105f31:	0f 84 7e 00 00 00    	je     80105fb5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105f37:	83 ec 0c             	sub    $0xc,%esp
80105f3a:	50                   	push   %eax
80105f3b:	e8 60 c5 ff ff       	call   801024a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105f40:	83 c4 10             	add    $0x10,%esp
80105f43:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105f48:	0f 84 ba 00 00 00    	je     80106008 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105f4e:	e8 fd bb ff ff       	call   80101b50 <filealloc>
80105f53:	89 c7                	mov    %eax,%edi
80105f55:	85 c0                	test   %eax,%eax
80105f57:	74 23                	je     80105f7c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105f59:	e8 02 e7 ff ff       	call   80104660 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f5e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105f60:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f64:	85 d2                	test   %edx,%edx
80105f66:	74 58                	je     80105fc0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105f68:	83 c3 01             	add    $0x1,%ebx
80105f6b:	83 fb 10             	cmp    $0x10,%ebx
80105f6e:	75 f0                	jne    80105f60 <sys_open+0x80>
    if(f)
      fileclose(f);
80105f70:	83 ec 0c             	sub    $0xc,%esp
80105f73:	57                   	push   %edi
80105f74:	e8 97 bc ff ff       	call   80101c10 <fileclose>
80105f79:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105f7c:	83 ec 0c             	sub    $0xc,%esp
80105f7f:	56                   	push   %esi
80105f80:	e8 ab c7 ff ff       	call   80102730 <iunlockput>
    end_op();
80105f85:	e8 26 db ff ff       	call   80103ab0 <end_op>
    return -1;
80105f8a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105f8d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f92:	eb 65                	jmp    80105ff9 <sys_open+0x119>
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105f98:	83 ec 0c             	sub    $0xc,%esp
80105f9b:	31 c9                	xor    %ecx,%ecx
80105f9d:	ba 02 00 00 00       	mov    $0x2,%edx
80105fa2:	6a 00                	push   $0x0
80105fa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105fa7:	e8 54 f8 ff ff       	call   80105800 <create>
    if(ip == 0){
80105fac:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105faf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105fb1:	85 c0                	test   %eax,%eax
80105fb3:	75 99                	jne    80105f4e <sys_open+0x6e>
      end_op();
80105fb5:	e8 f6 da ff ff       	call   80103ab0 <end_op>
      return -1;
80105fba:	eb d1                	jmp    80105f8d <sys_open+0xad>
80105fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105fc3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105fc7:	56                   	push   %esi
80105fc8:	e8 b3 c5 ff ff       	call   80102580 <iunlock>
  end_op();
80105fcd:	e8 de da ff ff       	call   80103ab0 <end_op>

  f->type = FD_INODE;
80105fd2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105fd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105fdb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105fde:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105fe1:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105fe3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105fea:	f7 d0                	not    %eax
80105fec:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105fef:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105ff2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ff5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105ff9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ffc:	89 d8                	mov    %ebx,%eax
80105ffe:	5b                   	pop    %ebx
80105fff:	5e                   	pop    %esi
80106000:	5f                   	pop    %edi
80106001:	5d                   	pop    %ebp
80106002:	c3                   	ret
80106003:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106008:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010600b:	85 c9                	test   %ecx,%ecx
8010600d:	0f 84 3b ff ff ff    	je     80105f4e <sys_open+0x6e>
80106013:	e9 64 ff ff ff       	jmp    80105f7c <sys_open+0x9c>
80106018:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010601f:	00 

80106020 <sys_mkdir>:

int
sys_mkdir(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106026:	e8 15 da ff ff       	call   80103a40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010602b:	83 ec 08             	sub    $0x8,%esp
8010602e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106031:	50                   	push   %eax
80106032:	6a 00                	push   $0x0
80106034:	e8 d7 f6 ff ff       	call   80105710 <argstr>
80106039:	83 c4 10             	add    $0x10,%esp
8010603c:	85 c0                	test   %eax,%eax
8010603e:	78 30                	js     80106070 <sys_mkdir+0x50>
80106040:	83 ec 0c             	sub    $0xc,%esp
80106043:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106046:	31 c9                	xor    %ecx,%ecx
80106048:	ba 01 00 00 00       	mov    $0x1,%edx
8010604d:	6a 00                	push   $0x0
8010604f:	e8 ac f7 ff ff       	call   80105800 <create>
80106054:	83 c4 10             	add    $0x10,%esp
80106057:	85 c0                	test   %eax,%eax
80106059:	74 15                	je     80106070 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010605b:	83 ec 0c             	sub    $0xc,%esp
8010605e:	50                   	push   %eax
8010605f:	e8 cc c6 ff ff       	call   80102730 <iunlockput>
  end_op();
80106064:	e8 47 da ff ff       	call   80103ab0 <end_op>
  return 0;
80106069:	83 c4 10             	add    $0x10,%esp
8010606c:	31 c0                	xor    %eax,%eax
}
8010606e:	c9                   	leave
8010606f:	c3                   	ret
    end_op();
80106070:	e8 3b da ff ff       	call   80103ab0 <end_op>
    return -1;
80106075:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010607a:	c9                   	leave
8010607b:	c3                   	ret
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106080 <sys_mknod>:

int
sys_mknod(void)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106086:	e8 b5 d9 ff ff       	call   80103a40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010608b:	83 ec 08             	sub    $0x8,%esp
8010608e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106091:	50                   	push   %eax
80106092:	6a 00                	push   $0x0
80106094:	e8 77 f6 ff ff       	call   80105710 <argstr>
80106099:	83 c4 10             	add    $0x10,%esp
8010609c:	85 c0                	test   %eax,%eax
8010609e:	78 60                	js     80106100 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801060a0:	83 ec 08             	sub    $0x8,%esp
801060a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060a6:	50                   	push   %eax
801060a7:	6a 01                	push   $0x1
801060a9:	e8 a2 f5 ff ff       	call   80105650 <argint>
  if((argstr(0, &path)) < 0 ||
801060ae:	83 c4 10             	add    $0x10,%esp
801060b1:	85 c0                	test   %eax,%eax
801060b3:	78 4b                	js     80106100 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801060b5:	83 ec 08             	sub    $0x8,%esp
801060b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060bb:	50                   	push   %eax
801060bc:	6a 02                	push   $0x2
801060be:	e8 8d f5 ff ff       	call   80105650 <argint>
     argint(1, &major) < 0 ||
801060c3:	83 c4 10             	add    $0x10,%esp
801060c6:	85 c0                	test   %eax,%eax
801060c8:	78 36                	js     80106100 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801060ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801060ce:	83 ec 0c             	sub    $0xc,%esp
801060d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801060d5:	ba 03 00 00 00       	mov    $0x3,%edx
801060da:	50                   	push   %eax
801060db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801060de:	e8 1d f7 ff ff       	call   80105800 <create>
     argint(2, &minor) < 0 ||
801060e3:	83 c4 10             	add    $0x10,%esp
801060e6:	85 c0                	test   %eax,%eax
801060e8:	74 16                	je     80106100 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801060ea:	83 ec 0c             	sub    $0xc,%esp
801060ed:	50                   	push   %eax
801060ee:	e8 3d c6 ff ff       	call   80102730 <iunlockput>
  end_op();
801060f3:	e8 b8 d9 ff ff       	call   80103ab0 <end_op>
  return 0;
801060f8:	83 c4 10             	add    $0x10,%esp
801060fb:	31 c0                	xor    %eax,%eax
}
801060fd:	c9                   	leave
801060fe:	c3                   	ret
801060ff:	90                   	nop
    end_op();
80106100:	e8 ab d9 ff ff       	call   80103ab0 <end_op>
    return -1;
80106105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010610a:	c9                   	leave
8010610b:	c3                   	ret
8010610c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106110 <sys_chdir>:

int
sys_chdir(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	56                   	push   %esi
80106114:	53                   	push   %ebx
80106115:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106118:	e8 43 e5 ff ff       	call   80104660 <myproc>
8010611d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010611f:	e8 1c d9 ff ff       	call   80103a40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106124:	83 ec 08             	sub    $0x8,%esp
80106127:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010612a:	50                   	push   %eax
8010612b:	6a 00                	push   $0x0
8010612d:	e8 de f5 ff ff       	call   80105710 <argstr>
80106132:	83 c4 10             	add    $0x10,%esp
80106135:	85 c0                	test   %eax,%eax
80106137:	78 77                	js     801061b0 <sys_chdir+0xa0>
80106139:	83 ec 0c             	sub    $0xc,%esp
8010613c:	ff 75 f4             	push   -0xc(%ebp)
8010613f:	e8 3c cc ff ff       	call   80102d80 <namei>
80106144:	83 c4 10             	add    $0x10,%esp
80106147:	89 c3                	mov    %eax,%ebx
80106149:	85 c0                	test   %eax,%eax
8010614b:	74 63                	je     801061b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010614d:	83 ec 0c             	sub    $0xc,%esp
80106150:	50                   	push   %eax
80106151:	e8 4a c3 ff ff       	call   801024a0 <ilock>
  if(ip->type != T_DIR){
80106156:	83 c4 10             	add    $0x10,%esp
80106159:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010615e:	75 30                	jne    80106190 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106160:	83 ec 0c             	sub    $0xc,%esp
80106163:	53                   	push   %ebx
80106164:	e8 17 c4 ff ff       	call   80102580 <iunlock>
  iput(curproc->cwd);
80106169:	58                   	pop    %eax
8010616a:	ff 76 68             	push   0x68(%esi)
8010616d:	e8 5e c4 ff ff       	call   801025d0 <iput>
  end_op();
80106172:	e8 39 d9 ff ff       	call   80103ab0 <end_op>
  curproc->cwd = ip;
80106177:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010617a:	83 c4 10             	add    $0x10,%esp
8010617d:	31 c0                	xor    %eax,%eax
}
8010617f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106182:	5b                   	pop    %ebx
80106183:	5e                   	pop    %esi
80106184:	5d                   	pop    %ebp
80106185:	c3                   	ret
80106186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010618d:	00 
8010618e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106190:	83 ec 0c             	sub    $0xc,%esp
80106193:	53                   	push   %ebx
80106194:	e8 97 c5 ff ff       	call   80102730 <iunlockput>
    end_op();
80106199:	e8 12 d9 ff ff       	call   80103ab0 <end_op>
    return -1;
8010619e:	83 c4 10             	add    $0x10,%esp
    return -1;
801061a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061a6:	eb d7                	jmp    8010617f <sys_chdir+0x6f>
801061a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061af:	00 
    end_op();
801061b0:	e8 fb d8 ff ff       	call   80103ab0 <end_op>
    return -1;
801061b5:	eb ea                	jmp    801061a1 <sys_chdir+0x91>
801061b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061be:	00 
801061bf:	90                   	nop

801061c0 <sys_exec>:

int
sys_exec(void)
{
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	57                   	push   %edi
801061c4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801061c5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801061cb:	53                   	push   %ebx
801061cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801061d2:	50                   	push   %eax
801061d3:	6a 00                	push   $0x0
801061d5:	e8 36 f5 ff ff       	call   80105710 <argstr>
801061da:	83 c4 10             	add    $0x10,%esp
801061dd:	85 c0                	test   %eax,%eax
801061df:	0f 88 87 00 00 00    	js     8010626c <sys_exec+0xac>
801061e5:	83 ec 08             	sub    $0x8,%esp
801061e8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801061ee:	50                   	push   %eax
801061ef:	6a 01                	push   $0x1
801061f1:	e8 5a f4 ff ff       	call   80105650 <argint>
801061f6:	83 c4 10             	add    $0x10,%esp
801061f9:	85 c0                	test   %eax,%eax
801061fb:	78 6f                	js     8010626c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801061fd:	83 ec 04             	sub    $0x4,%esp
80106200:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106206:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106208:	68 80 00 00 00       	push   $0x80
8010620d:	6a 00                	push   $0x0
8010620f:	56                   	push   %esi
80106210:	e8 8b f1 ff ff       	call   801053a0 <memset>
80106215:	83 c4 10             	add    $0x10,%esp
80106218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010621f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106220:	83 ec 08             	sub    $0x8,%esp
80106223:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106229:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106230:	50                   	push   %eax
80106231:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106237:	01 f8                	add    %edi,%eax
80106239:	50                   	push   %eax
8010623a:	e8 81 f3 ff ff       	call   801055c0 <fetchint>
8010623f:	83 c4 10             	add    $0x10,%esp
80106242:	85 c0                	test   %eax,%eax
80106244:	78 26                	js     8010626c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106246:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010624c:	85 c0                	test   %eax,%eax
8010624e:	74 30                	je     80106280 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106250:	83 ec 08             	sub    $0x8,%esp
80106253:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106256:	52                   	push   %edx
80106257:	50                   	push   %eax
80106258:	e8 a3 f3 ff ff       	call   80105600 <fetchstr>
8010625d:	83 c4 10             	add    $0x10,%esp
80106260:	85 c0                	test   %eax,%eax
80106262:	78 08                	js     8010626c <sys_exec+0xac>
  for(i=0;; i++){
80106264:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106267:	83 fb 20             	cmp    $0x20,%ebx
8010626a:	75 b4                	jne    80106220 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010626c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010626f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106274:	5b                   	pop    %ebx
80106275:	5e                   	pop    %esi
80106276:	5f                   	pop    %edi
80106277:	5d                   	pop    %ebp
80106278:	c3                   	ret
80106279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106280:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106287:	00 00 00 00 
  return exec(path, argv);
8010628b:	83 ec 08             	sub    $0x8,%esp
8010628e:	56                   	push   %esi
8010628f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106295:	e8 16 b5 ff ff       	call   801017b0 <exec>
8010629a:	83 c4 10             	add    $0x10,%esp
}
8010629d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062a0:	5b                   	pop    %ebx
801062a1:	5e                   	pop    %esi
801062a2:	5f                   	pop    %edi
801062a3:	5d                   	pop    %ebp
801062a4:	c3                   	ret
801062a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ac:	00 
801062ad:	8d 76 00             	lea    0x0(%esi),%esi

801062b0 <sys_pipe>:

int
sys_pipe(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	57                   	push   %edi
801062b4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801062b5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801062b8:	53                   	push   %ebx
801062b9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801062bc:	6a 08                	push   $0x8
801062be:	50                   	push   %eax
801062bf:	6a 00                	push   $0x0
801062c1:	e8 da f3 ff ff       	call   801056a0 <argptr>
801062c6:	83 c4 10             	add    $0x10,%esp
801062c9:	85 c0                	test   %eax,%eax
801062cb:	0f 88 8b 00 00 00    	js     8010635c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801062d1:	83 ec 08             	sub    $0x8,%esp
801062d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801062d7:	50                   	push   %eax
801062d8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801062db:	50                   	push   %eax
801062dc:	e8 2f de ff ff       	call   80104110 <pipealloc>
801062e1:	83 c4 10             	add    $0x10,%esp
801062e4:	85 c0                	test   %eax,%eax
801062e6:	78 74                	js     8010635c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801062e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801062eb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801062ed:	e8 6e e3 ff ff       	call   80104660 <myproc>
    if(curproc->ofile[fd] == 0){
801062f2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801062f6:	85 f6                	test   %esi,%esi
801062f8:	74 16                	je     80106310 <sys_pipe+0x60>
801062fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106300:	83 c3 01             	add    $0x1,%ebx
80106303:	83 fb 10             	cmp    $0x10,%ebx
80106306:	74 3d                	je     80106345 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80106308:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010630c:	85 f6                	test   %esi,%esi
8010630e:	75 f0                	jne    80106300 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106310:	8d 73 08             	lea    0x8(%ebx),%esi
80106313:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106317:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010631a:	e8 41 e3 ff ff       	call   80104660 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010631f:	31 d2                	xor    %edx,%edx
80106321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106328:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010632c:	85 c9                	test   %ecx,%ecx
8010632e:	74 38                	je     80106368 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106330:	83 c2 01             	add    $0x1,%edx
80106333:	83 fa 10             	cmp    $0x10,%edx
80106336:	75 f0                	jne    80106328 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106338:	e8 23 e3 ff ff       	call   80104660 <myproc>
8010633d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106344:	00 
    fileclose(rf);
80106345:	83 ec 0c             	sub    $0xc,%esp
80106348:	ff 75 e0             	push   -0x20(%ebp)
8010634b:	e8 c0 b8 ff ff       	call   80101c10 <fileclose>
    fileclose(wf);
80106350:	58                   	pop    %eax
80106351:	ff 75 e4             	push   -0x1c(%ebp)
80106354:	e8 b7 b8 ff ff       	call   80101c10 <fileclose>
    return -1;
80106359:	83 c4 10             	add    $0x10,%esp
    return -1;
8010635c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106361:	eb 16                	jmp    80106379 <sys_pipe+0xc9>
80106363:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106368:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010636c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010636f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106371:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106374:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106377:	31 c0                	xor    %eax,%eax
}
80106379:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010637c:	5b                   	pop    %ebx
8010637d:	5e                   	pop    %esi
8010637e:	5f                   	pop    %edi
8010637f:	5d                   	pop    %ebp
80106380:	c3                   	ret
80106381:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106388:	00 
80106389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106390 <sys_move_file>:

int
sys_move_file(void)
{
80106390:	55                   	push   %ebp
80106391:	89 e5                	mov    %esp,%ebp
80106393:	57                   	push   %edi
80106394:	56                   	push   %esi
  char *src_file, *dest_dir;
  struct dirent de;
  uint  offset;
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
80106395:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
{
8010639b:	53                   	push   %ebx
8010639c:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
801063a2:	50                   	push   %eax
801063a3:	6a 00                	push   $0x0
801063a5:	e8 66 f3 ff ff       	call   80105710 <argstr>
801063aa:	83 c4 10             	add    $0x10,%esp
801063ad:	85 c0                	test   %eax,%eax
801063af:	0f 88 6c 01 00 00    	js     80106521 <sys_move_file+0x191>
801063b5:	83 ec 08             	sub    $0x8,%esp
801063b8:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
801063be:	50                   	push   %eax
801063bf:	6a 01                	push   $0x1
801063c1:	e8 4a f3 ff ff       	call   80105710 <argstr>
801063c6:	83 c4 10             	add    $0x10,%esp
801063c9:	85 c0                	test   %eax,%eax
801063cb:	0f 88 50 01 00 00    	js     80106521 <sys_move_file+0x191>
  {
    return -1;
  }
  begin_op();
801063d1:	e8 6a d6 ff ff       	call   80103a40 <begin_op>

  struct inode *src_ip = namei(src_file);
801063d6:	83 ec 0c             	sub    $0xc,%esp
801063d9:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
801063df:	e8 9c c9 ff ff       	call   80102d80 <namei>
  if (src_ip == 0)
801063e4:	83 c4 10             	add    $0x10,%esp
  struct inode *src_ip = namei(src_file);
801063e7:	89 c6                	mov    %eax,%esi
  if (src_ip == 0)
801063e9:	85 c0                	test   %eax,%eax
801063eb:	0f 84 45 01 00 00    	je     80106536 <sys_move_file+0x1a6>
  {
    cprintf("File not found: %s\n", src_file);
    end_op();
    return -1;
  }
  ilock(src_ip);
801063f1:	83 ec 0c             	sub    $0xc,%esp
801063f4:	50                   	push   %eax
801063f5:	e8 a6 c0 ff ff       	call   801024a0 <ilock>
  
  struct inode *dir_ip = namei(dest_dir);
801063fa:	58                   	pop    %eax
801063fb:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80106401:	e8 7a c9 ff ff       	call   80102d80 <namei>
  if (dir_ip== 0)
80106406:	83 c4 10             	add    $0x10,%esp
  struct inode *dir_ip = namei(dest_dir);
80106409:	89 c7                	mov    %eax,%edi
  if (dir_ip== 0)
8010640b:	85 c0                	test   %eax,%eax
8010640d:	0f 84 40 01 00 00    	je     80106553 <sys_move_file+0x1c3>
    cprintf("Directory not found: %s\n", dest_dir);
    iunlockput(src_ip);
    end_op();
    return -1;
  }
  ilock(dir_ip);
80106413:	83 ec 0c             	sub    $0xc,%esp
80106416:	50                   	push   %eax
80106417:	e8 84 c0 ff ff       	call   801024a0 <ilock>

  char filename[128];
  safestrcpy(filename, src_file, sizeof(filename));
8010641c:	83 c4 0c             	add    $0xc,%esp
8010641f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106425:	68 80 00 00 00       	push   $0x80
8010642a:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106430:	50                   	push   %eax
80106431:	e8 1a f1 ff ff       	call   80105550 <safestrcpy>
   
  if (dirlink(dir_ip, filename, src_ip->inum) < 0)
80106436:	83 c4 0c             	add    $0xc,%esp
80106439:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010643f:	ff 76 04             	push   0x4(%esi)
80106442:	50                   	push   %eax
80106443:	57                   	push   %edi
80106444:	e8 77 c8 ff ff       	call   80102cc0 <dirlink>
80106449:	83 c4 10             	add    $0x10,%esp
8010644c:	85 c0                	test   %eax,%eax
8010644e:	0f 88 dc 00 00 00    	js     80106530 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *dp_parent = nameiparent(src_file,  filename);
80106454:	83 ec 08             	sub    $0x8,%esp
80106457:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010645d:	50                   	push   %eax
8010645e:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106464:	e8 37 c9 ff ff       	call   80102da0 <nameiparent>
  if (dp_parent == 0)
80106469:	83 c4 10             	add    $0x10,%esp
  struct inode *dp_parent = nameiparent(src_file,  filename);
8010646c:	89 c3                	mov    %eax,%ebx
  if (dp_parent == 0)
8010646e:	85 c0                	test   %eax,%eax
80106470:	0f 84 ba 00 00 00    	je     80106530 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *ip = dirlookup(dp_parent, filename, &offset);
80106476:	83 ec 04             	sub    $0x4,%esp
80106479:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
8010647f:	50                   	push   %eax
80106480:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106486:	50                   	push   %eax
80106487:	53                   	push   %ebx
80106488:	e8 63 c5 ff ff       	call   801029f0 <dirlookup>
  if (ip == 0)
8010648d:	83 c4 10             	add    $0x10,%esp
80106490:	85 c0                	test   %eax,%eax
80106492:	0f 84 98 00 00 00    	je     80106530 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  memset(&de, 0, sizeof(de));
80106498:	83 ec 04             	sub    $0x4,%esp
8010649b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801064a1:	6a 10                	push   $0x10
801064a3:	6a 00                	push   $0x0
801064a5:	52                   	push   %edx
801064a6:	e8 f5 ee ff ff       	call   801053a0 <memset>
  ilock(dp_parent);
801064ab:	89 1c 24             	mov    %ebx,(%esp)
801064ae:	e8 ed bf ff ff       	call   801024a0 <ilock>
  if (writei(dp_parent, (char*)&de, offset, sizeof(de)) != sizeof(de))
801064b3:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801064b9:	6a 10                	push   $0x10
801064bb:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
801064c1:	52                   	push   %edx
801064c2:	53                   	push   %ebx
801064c3:	e8 e8 c3 ff ff       	call   801028b0 <writei>
801064c8:	83 c4 20             	add    $0x20,%esp
801064cb:	83 f8 10             	cmp    $0x10,%eax
801064ce:	75 30                	jne    80106500 <sys_move_file+0x170>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  iunlockput(src_ip);
801064d0:	83 ec 0c             	sub    $0xc,%esp
801064d3:	56                   	push   %esi
801064d4:	e8 57 c2 ff ff       	call   80102730 <iunlockput>
  iunlockput(dir_ip);
801064d9:	89 3c 24             	mov    %edi,(%esp)
801064dc:	e8 4f c2 ff ff       	call   80102730 <iunlockput>
  iunlockput(dp_parent);
801064e1:	89 1c 24             	mov    %ebx,(%esp)
801064e4:	e8 47 c2 ff ff       	call   80102730 <iunlockput>
  end_op();
801064e9:	e8 c2 d5 ff ff       	call   80103ab0 <end_op>
  return 0;
801064ee:	83 c4 10             	add    $0x10,%esp
801064f1:	31 c0                	xor    %eax,%eax
801064f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064f6:	5b                   	pop    %ebx
801064f7:	5e                   	pop    %esi
801064f8:	5f                   	pop    %edi
801064f9:	5d                   	pop    %ebp
801064fa:	c3                   	ret
801064fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(dp_parent);
80106500:	83 ec 0c             	sub    $0xc,%esp
80106503:	53                   	push   %ebx
80106504:	e8 27 c2 ff ff       	call   80102730 <iunlockput>
    iunlockput(dir_ip);
80106509:	89 3c 24             	mov    %edi,(%esp)
8010650c:	e8 1f c2 ff ff       	call   80102730 <iunlockput>
    iunlockput(src_ip);
80106511:	89 34 24             	mov    %esi,(%esp)
80106514:	e8 17 c2 ff ff       	call   80102730 <iunlockput>
    end_op();
80106519:	e8 92 d5 ff ff       	call   80103ab0 <end_op>
    return -1;
8010651e:	83 c4 10             	add    $0x10,%esp
    return -1;
80106521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106526:	eb cb                	jmp    801064f3 <sys_move_file+0x163>
80106528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010652f:	00 
    iunlockput(dir_ip);
80106530:	83 ec 0c             	sub    $0xc,%esp
80106533:	57                   	push   %edi
80106534:	eb d6                	jmp    8010650c <sys_move_file+0x17c>
    cprintf("File not found: %s\n", src_file);
80106536:	83 ec 08             	sub    $0x8,%esp
80106539:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
8010653f:	68 76 84 10 80       	push   $0x80108476
80106544:	e8 47 a5 ff ff       	call   80100a90 <cprintf>
    end_op();
80106549:	e8 62 d5 ff ff       	call   80103ab0 <end_op>
    return -1;
8010654e:	83 c4 10             	add    $0x10,%esp
80106551:	eb ce                	jmp    80106521 <sys_move_file+0x191>
    cprintf("Directory not found: %s\n", dest_dir);
80106553:	83 ec 08             	sub    $0x8,%esp
80106556:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
8010655c:	68 8a 84 10 80       	push   $0x8010848a
80106561:	e8 2a a5 ff ff       	call   80100a90 <cprintf>
    iunlockput(src_ip);
80106566:	89 34 24             	mov    %esi,(%esp)
80106569:	e8 c2 c1 ff ff       	call   80102730 <iunlockput>
    end_op();
8010656e:	e8 3d d5 ff ff       	call   80103ab0 <end_op>
    return -1;
80106573:	83 c4 10             	add    $0x10,%esp
80106576:	eb a9                	jmp    80106521 <sys_move_file+0x191>
80106578:	66 90                	xchg   %ax,%ax
8010657a:	66 90                	xchg   %ax,%ax
8010657c:	66 90                	xchg   %ax,%ax
8010657e:	66 90                	xchg   %ax,%ax

80106580 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106580:	e9 7b e2 ff ff       	jmp    80104800 <fork>
80106585:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010658c:	00 
8010658d:	8d 76 00             	lea    0x0(%esi),%esi

80106590 <sys_exit>:
}

int
sys_exit(void)
{
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	83 ec 08             	sub    $0x8,%esp
  exit();
80106596:	e8 d5 e4 ff ff       	call   80104a70 <exit>
  return 0;  // not reached
}
8010659b:	31 c0                	xor    %eax,%eax
8010659d:	c9                   	leave
8010659e:	c3                   	ret
8010659f:	90                   	nop

801065a0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801065a0:	e9 fb e5 ff ff       	jmp    80104ba0 <wait>
801065a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801065ac:	00 
801065ad:	8d 76 00             	lea    0x0(%esi),%esi

801065b0 <sys_kill>:
}

int
sys_kill(void)
{
801065b0:	55                   	push   %ebp
801065b1:	89 e5                	mov    %esp,%ebp
801065b3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801065b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065b9:	50                   	push   %eax
801065ba:	6a 00                	push   $0x0
801065bc:	e8 8f f0 ff ff       	call   80105650 <argint>
801065c1:	83 c4 10             	add    $0x10,%esp
801065c4:	85 c0                	test   %eax,%eax
801065c6:	78 18                	js     801065e0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801065c8:	83 ec 0c             	sub    $0xc,%esp
801065cb:	ff 75 f4             	push   -0xc(%ebp)
801065ce:	e8 6d e8 ff ff       	call   80104e40 <kill>
801065d3:	83 c4 10             	add    $0x10,%esp
}
801065d6:	c9                   	leave
801065d7:	c3                   	ret
801065d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801065df:	00 
801065e0:	c9                   	leave
    return -1;
801065e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065e6:	c3                   	ret
801065e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801065ee:	00 
801065ef:	90                   	nop

801065f0 <sys_getpid>:

int
sys_getpid(void)
{
801065f0:	55                   	push   %ebp
801065f1:	89 e5                	mov    %esp,%ebp
801065f3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801065f6:	e8 65 e0 ff ff       	call   80104660 <myproc>
801065fb:	8b 40 10             	mov    0x10(%eax),%eax
}
801065fe:	c9                   	leave
801065ff:	c3                   	ret

80106600 <sys_sbrk>:

int
sys_sbrk(void)
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106604:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106607:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010660a:	50                   	push   %eax
8010660b:	6a 00                	push   $0x0
8010660d:	e8 3e f0 ff ff       	call   80105650 <argint>
80106612:	83 c4 10             	add    $0x10,%esp
80106615:	85 c0                	test   %eax,%eax
80106617:	78 27                	js     80106640 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106619:	e8 42 e0 ff ff       	call   80104660 <myproc>
  if(growproc(n) < 0)
8010661e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106621:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106623:	ff 75 f4             	push   -0xc(%ebp)
80106626:	e8 55 e1 ff ff       	call   80104780 <growproc>
8010662b:	83 c4 10             	add    $0x10,%esp
8010662e:	85 c0                	test   %eax,%eax
80106630:	78 0e                	js     80106640 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106632:	89 d8                	mov    %ebx,%eax
80106634:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106637:	c9                   	leave
80106638:	c3                   	ret
80106639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106640:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106645:	eb eb                	jmp    80106632 <sys_sbrk+0x32>
80106647:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010664e:	00 
8010664f:	90                   	nop

80106650 <sys_sleep>:

int
sys_sleep(void)
{
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106654:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106657:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010665a:	50                   	push   %eax
8010665b:	6a 00                	push   $0x0
8010665d:	e8 ee ef ff ff       	call   80105650 <argint>
80106662:	83 c4 10             	add    $0x10,%esp
80106665:	85 c0                	test   %eax,%eax
80106667:	78 64                	js     801066cd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80106669:	83 ec 0c             	sub    $0xc,%esp
8010666c:	68 c0 52 11 80       	push   $0x801152c0
80106671:	e8 2a ec ff ff       	call   801052a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106676:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106679:	8b 1d a0 52 11 80    	mov    0x801152a0,%ebx
  while(ticks - ticks0 < n){
8010667f:	83 c4 10             	add    $0x10,%esp
80106682:	85 d2                	test   %edx,%edx
80106684:	75 2b                	jne    801066b1 <sys_sleep+0x61>
80106686:	eb 58                	jmp    801066e0 <sys_sleep+0x90>
80106688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010668f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106690:	83 ec 08             	sub    $0x8,%esp
80106693:	68 c0 52 11 80       	push   $0x801152c0
80106698:	68 a0 52 11 80       	push   $0x801152a0
8010669d:	e8 7e e6 ff ff       	call   80104d20 <sleep>
  while(ticks - ticks0 < n){
801066a2:	a1 a0 52 11 80       	mov    0x801152a0,%eax
801066a7:	83 c4 10             	add    $0x10,%esp
801066aa:	29 d8                	sub    %ebx,%eax
801066ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801066af:	73 2f                	jae    801066e0 <sys_sleep+0x90>
    if(myproc()->killed){
801066b1:	e8 aa df ff ff       	call   80104660 <myproc>
801066b6:	8b 40 24             	mov    0x24(%eax),%eax
801066b9:	85 c0                	test   %eax,%eax
801066bb:	74 d3                	je     80106690 <sys_sleep+0x40>
      release(&tickslock);
801066bd:	83 ec 0c             	sub    $0xc,%esp
801066c0:	68 c0 52 11 80       	push   $0x801152c0
801066c5:	e8 76 eb ff ff       	call   80105240 <release>
      return -1;
801066ca:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801066cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801066d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066d5:	c9                   	leave
801066d6:	c3                   	ret
801066d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801066de:	00 
801066df:	90                   	nop
  release(&tickslock);
801066e0:	83 ec 0c             	sub    $0xc,%esp
801066e3:	68 c0 52 11 80       	push   $0x801152c0
801066e8:	e8 53 eb ff ff       	call   80105240 <release>
}
801066ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801066f0:	83 c4 10             	add    $0x10,%esp
801066f3:	31 c0                	xor    %eax,%eax
}
801066f5:	c9                   	leave
801066f6:	c3                   	ret
801066f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801066fe:	00 
801066ff:	90                   	nop

80106700 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	53                   	push   %ebx
80106704:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106707:	68 c0 52 11 80       	push   $0x801152c0
8010670c:	e8 8f eb ff ff       	call   801052a0 <acquire>
  xticks = ticks;
80106711:	8b 1d a0 52 11 80    	mov    0x801152a0,%ebx
  release(&tickslock);
80106717:	c7 04 24 c0 52 11 80 	movl   $0x801152c0,(%esp)
8010671e:	e8 1d eb ff ff       	call   80105240 <release>
  return xticks;
}
80106723:	89 d8                	mov    %ebx,%eax
80106725:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106728:	c9                   	leave
80106729:	c3                   	ret

8010672a <alltraps>:
8010672a:	1e                   	push   %ds
8010672b:	06                   	push   %es
8010672c:	0f a0                	push   %fs
8010672e:	0f a8                	push   %gs
80106730:	60                   	pusha
80106731:	66 b8 10 00          	mov    $0x10,%ax
80106735:	8e d8                	mov    %eax,%ds
80106737:	8e c0                	mov    %eax,%es
80106739:	54                   	push   %esp
8010673a:	e8 c1 00 00 00       	call   80106800 <trap>
8010673f:	83 c4 04             	add    $0x4,%esp

80106742 <trapret>:
80106742:	61                   	popa
80106743:	0f a9                	pop    %gs
80106745:	0f a1                	pop    %fs
80106747:	07                   	pop    %es
80106748:	1f                   	pop    %ds
80106749:	83 c4 08             	add    $0x8,%esp
8010674c:	cf                   	iret
8010674d:	66 90                	xchg   %ax,%ax
8010674f:	90                   	nop

80106750 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106750:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106751:	31 c0                	xor    %eax,%eax
{
80106753:	89 e5                	mov    %esp,%ebp
80106755:	83 ec 08             	sub    $0x8,%esp
80106758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010675f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106760:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106767:	c7 04 c5 02 53 11 80 	movl   $0x8e000008,-0x7feeacfe(,%eax,8)
8010676e:	08 00 00 8e 
80106772:	66 89 14 c5 00 53 11 	mov    %dx,-0x7feead00(,%eax,8)
80106779:	80 
8010677a:	c1 ea 10             	shr    $0x10,%edx
8010677d:	66 89 14 c5 06 53 11 	mov    %dx,-0x7feeacfa(,%eax,8)
80106784:	80 
  for(i = 0; i < 256; i++)
80106785:	83 c0 01             	add    $0x1,%eax
80106788:	3d 00 01 00 00       	cmp    $0x100,%eax
8010678d:	75 d1                	jne    80106760 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010678f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106792:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106797:	c7 05 02 55 11 80 08 	movl   $0xef000008,0x80115502
8010679e:	00 00 ef 
  initlock(&tickslock, "time");
801067a1:	68 a3 84 10 80       	push   $0x801084a3
801067a6:	68 c0 52 11 80       	push   $0x801152c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801067ab:	66 a3 00 55 11 80    	mov    %ax,0x80115500
801067b1:	c1 e8 10             	shr    $0x10,%eax
801067b4:	66 a3 06 55 11 80    	mov    %ax,0x80115506
  initlock(&tickslock, "time");
801067ba:	e8 f1 e8 ff ff       	call   801050b0 <initlock>
}
801067bf:	83 c4 10             	add    $0x10,%esp
801067c2:	c9                   	leave
801067c3:	c3                   	ret
801067c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801067cb:	00 
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067d0 <idtinit>:

void
idtinit(void)
{
801067d0:	55                   	push   %ebp
  pd[0] = size-1;
801067d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801067d6:	89 e5                	mov    %esp,%ebp
801067d8:	83 ec 10             	sub    $0x10,%esp
801067db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801067df:	b8 00 53 11 80       	mov    $0x80115300,%eax
801067e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801067e8:	c1 e8 10             	shr    $0x10,%eax
801067eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801067ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801067f2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801067f5:	c9                   	leave
801067f6:	c3                   	ret
801067f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801067fe:	00 
801067ff:	90                   	nop

80106800 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106800:	55                   	push   %ebp
80106801:	89 e5                	mov    %esp,%ebp
80106803:	57                   	push   %edi
80106804:	56                   	push   %esi
80106805:	53                   	push   %ebx
80106806:	83 ec 1c             	sub    $0x1c,%esp
80106809:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010680c:	8b 43 30             	mov    0x30(%ebx),%eax
8010680f:	83 f8 40             	cmp    $0x40,%eax
80106812:	0f 84 58 01 00 00    	je     80106970 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106818:	83 e8 20             	sub    $0x20,%eax
8010681b:	83 f8 1f             	cmp    $0x1f,%eax
8010681e:	0f 87 7c 00 00 00    	ja     801068a0 <trap+0xa0>
80106824:	ff 24 85 40 8a 10 80 	jmp    *-0x7fef75c0(,%eax,4)
8010682b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106830:	e8 fb c6 ff ff       	call   80102f30 <ideintr>
    lapiceoi();
80106835:	e8 b6 cd ff ff       	call   801035f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010683a:	e8 21 de ff ff       	call   80104660 <myproc>
8010683f:	85 c0                	test   %eax,%eax
80106841:	74 1a                	je     8010685d <trap+0x5d>
80106843:	e8 18 de ff ff       	call   80104660 <myproc>
80106848:	8b 50 24             	mov    0x24(%eax),%edx
8010684b:	85 d2                	test   %edx,%edx
8010684d:	74 0e                	je     8010685d <trap+0x5d>
8010684f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106853:	f7 d0                	not    %eax
80106855:	a8 03                	test   $0x3,%al
80106857:	0f 84 db 01 00 00    	je     80106a38 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010685d:	e8 fe dd ff ff       	call   80104660 <myproc>
80106862:	85 c0                	test   %eax,%eax
80106864:	74 0f                	je     80106875 <trap+0x75>
80106866:	e8 f5 dd ff ff       	call   80104660 <myproc>
8010686b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010686f:	0f 84 ab 00 00 00    	je     80106920 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106875:	e8 e6 dd ff ff       	call   80104660 <myproc>
8010687a:	85 c0                	test   %eax,%eax
8010687c:	74 1a                	je     80106898 <trap+0x98>
8010687e:	e8 dd dd ff ff       	call   80104660 <myproc>
80106883:	8b 40 24             	mov    0x24(%eax),%eax
80106886:	85 c0                	test   %eax,%eax
80106888:	74 0e                	je     80106898 <trap+0x98>
8010688a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010688e:	f7 d0                	not    %eax
80106890:	a8 03                	test   $0x3,%al
80106892:	0f 84 05 01 00 00    	je     8010699d <trap+0x19d>
    exit();
}
80106898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010689b:	5b                   	pop    %ebx
8010689c:	5e                   	pop    %esi
8010689d:	5f                   	pop    %edi
8010689e:	5d                   	pop    %ebp
8010689f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
801068a0:	e8 bb dd ff ff       	call   80104660 <myproc>
801068a5:	8b 7b 38             	mov    0x38(%ebx),%edi
801068a8:	85 c0                	test   %eax,%eax
801068aa:	0f 84 a2 01 00 00    	je     80106a52 <trap+0x252>
801068b0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801068b4:	0f 84 98 01 00 00    	je     80106a52 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801068ba:	0f 20 d1             	mov    %cr2,%ecx
801068bd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068c0:	e8 7b dd ff ff       	call   80104640 <cpuid>
801068c5:	8b 73 30             	mov    0x30(%ebx),%esi
801068c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801068cb:	8b 43 34             	mov    0x34(%ebx),%eax
801068ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801068d1:	e8 8a dd ff ff       	call   80104660 <myproc>
801068d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801068d9:	e8 82 dd ff ff       	call   80104660 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068de:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801068e1:	51                   	push   %ecx
801068e2:	57                   	push   %edi
801068e3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801068e6:	52                   	push   %edx
801068e7:	ff 75 e4             	push   -0x1c(%ebp)
801068ea:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801068eb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801068ee:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068f1:	56                   	push   %esi
801068f2:	ff 70 10             	push   0x10(%eax)
801068f5:	68 38 87 10 80       	push   $0x80108738
801068fa:	e8 91 a1 ff ff       	call   80100a90 <cprintf>
    myproc()->killed = 1;
801068ff:	83 c4 20             	add    $0x20,%esp
80106902:	e8 59 dd ff ff       	call   80104660 <myproc>
80106907:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010690e:	e8 4d dd ff ff       	call   80104660 <myproc>
80106913:	85 c0                	test   %eax,%eax
80106915:	0f 85 28 ff ff ff    	jne    80106843 <trap+0x43>
8010691b:	e9 3d ff ff ff       	jmp    8010685d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80106920:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106924:	0f 85 4b ff ff ff    	jne    80106875 <trap+0x75>
    yield();
8010692a:	e8 a1 e3 ff ff       	call   80104cd0 <yield>
8010692f:	e9 41 ff ff ff       	jmp    80106875 <trap+0x75>
80106934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106938:	8b 7b 38             	mov    0x38(%ebx),%edi
8010693b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010693f:	e8 fc dc ff ff       	call   80104640 <cpuid>
80106944:	57                   	push   %edi
80106945:	56                   	push   %esi
80106946:	50                   	push   %eax
80106947:	68 e0 86 10 80       	push   $0x801086e0
8010694c:	e8 3f a1 ff ff       	call   80100a90 <cprintf>
    lapiceoi();
80106951:	e8 9a cc ff ff       	call   801035f0 <lapiceoi>
    break;
80106956:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106959:	e8 02 dd ff ff       	call   80104660 <myproc>
8010695e:	85 c0                	test   %eax,%eax
80106960:	0f 85 dd fe ff ff    	jne    80106843 <trap+0x43>
80106966:	e9 f2 fe ff ff       	jmp    8010685d <trap+0x5d>
8010696b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106970:	e8 eb dc ff ff       	call   80104660 <myproc>
80106975:	8b 70 24             	mov    0x24(%eax),%esi
80106978:	85 f6                	test   %esi,%esi
8010697a:	0f 85 c8 00 00 00    	jne    80106a48 <trap+0x248>
    myproc()->tf = tf;
80106980:	e8 db dc ff ff       	call   80104660 <myproc>
80106985:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106988:	e8 03 ee ff ff       	call   80105790 <syscall>
    if(myproc()->killed)
8010698d:	e8 ce dc ff ff       	call   80104660 <myproc>
80106992:	8b 48 24             	mov    0x24(%eax),%ecx
80106995:	85 c9                	test   %ecx,%ecx
80106997:	0f 84 fb fe ff ff    	je     80106898 <trap+0x98>
}
8010699d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069a0:	5b                   	pop    %ebx
801069a1:	5e                   	pop    %esi
801069a2:	5f                   	pop    %edi
801069a3:	5d                   	pop    %ebp
      exit();
801069a4:	e9 c7 e0 ff ff       	jmp    80104a70 <exit>
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801069b0:	e8 4b 02 00 00       	call   80106c00 <uartintr>
    lapiceoi();
801069b5:	e8 36 cc ff ff       	call   801035f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801069ba:	e8 a1 dc ff ff       	call   80104660 <myproc>
801069bf:	85 c0                	test   %eax,%eax
801069c1:	0f 85 7c fe ff ff    	jne    80106843 <trap+0x43>
801069c7:	e9 91 fe ff ff       	jmp    8010685d <trap+0x5d>
801069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801069d0:	e8 eb ca ff ff       	call   801034c0 <kbdintr>
    lapiceoi();
801069d5:	e8 16 cc ff ff       	call   801035f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801069da:	e8 81 dc ff ff       	call   80104660 <myproc>
801069df:	85 c0                	test   %eax,%eax
801069e1:	0f 85 5c fe ff ff    	jne    80106843 <trap+0x43>
801069e7:	e9 71 fe ff ff       	jmp    8010685d <trap+0x5d>
801069ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801069f0:	e8 4b dc ff ff       	call   80104640 <cpuid>
801069f5:	85 c0                	test   %eax,%eax
801069f7:	0f 85 38 fe ff ff    	jne    80106835 <trap+0x35>
      acquire(&tickslock);
801069fd:	83 ec 0c             	sub    $0xc,%esp
80106a00:	68 c0 52 11 80       	push   $0x801152c0
80106a05:	e8 96 e8 ff ff       	call   801052a0 <acquire>
      ticks++;
80106a0a:	83 05 a0 52 11 80 01 	addl   $0x1,0x801152a0
      wakeup(&ticks);
80106a11:	c7 04 24 a0 52 11 80 	movl   $0x801152a0,(%esp)
80106a18:	e8 c3 e3 ff ff       	call   80104de0 <wakeup>
      release(&tickslock);
80106a1d:	c7 04 24 c0 52 11 80 	movl   $0x801152c0,(%esp)
80106a24:	e8 17 e8 ff ff       	call   80105240 <release>
80106a29:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106a2c:	e9 04 fe ff ff       	jmp    80106835 <trap+0x35>
80106a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106a38:	e8 33 e0 ff ff       	call   80104a70 <exit>
80106a3d:	e9 1b fe ff ff       	jmp    8010685d <trap+0x5d>
80106a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106a48:	e8 23 e0 ff ff       	call   80104a70 <exit>
80106a4d:	e9 2e ff ff ff       	jmp    80106980 <trap+0x180>
80106a52:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a55:	e8 e6 db ff ff       	call   80104640 <cpuid>
80106a5a:	83 ec 0c             	sub    $0xc,%esp
80106a5d:	56                   	push   %esi
80106a5e:	57                   	push   %edi
80106a5f:	50                   	push   %eax
80106a60:	ff 73 30             	push   0x30(%ebx)
80106a63:	68 04 87 10 80       	push   $0x80108704
80106a68:	e8 23 a0 ff ff       	call   80100a90 <cprintf>
      panic("trap");
80106a6d:	83 c4 14             	add    $0x14,%esp
80106a70:	68 a8 84 10 80       	push   $0x801084a8
80106a75:	e8 96 9a ff ff       	call   80100510 <panic>
80106a7a:	66 90                	xchg   %ax,%ax
80106a7c:	66 90                	xchg   %ax,%ax
80106a7e:	66 90                	xchg   %ax,%ax

80106a80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106a80:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80106a85:	85 c0                	test   %eax,%eax
80106a87:	74 17                	je     80106aa0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a89:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106a8e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106a8f:	a8 01                	test   $0x1,%al
80106a91:	74 0d                	je     80106aa0 <uartgetc+0x20>
80106a93:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a98:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106a99:	0f b6 c0             	movzbl %al,%eax
80106a9c:	c3                   	ret
80106a9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106aa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106aa5:	c3                   	ret
80106aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106aad:	00 
80106aae:	66 90                	xchg   %ax,%ax

80106ab0 <uartinit>:
{
80106ab0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ab1:	31 c9                	xor    %ecx,%ecx
80106ab3:	89 c8                	mov    %ecx,%eax
80106ab5:	89 e5                	mov    %esp,%ebp
80106ab7:	57                   	push   %edi
80106ab8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80106abd:	56                   	push   %esi
80106abe:	89 fa                	mov    %edi,%edx
80106ac0:	53                   	push   %ebx
80106ac1:	83 ec 1c             	sub    $0x1c,%esp
80106ac4:	ee                   	out    %al,(%dx)
80106ac5:	be fb 03 00 00       	mov    $0x3fb,%esi
80106aca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106acf:	89 f2                	mov    %esi,%edx
80106ad1:	ee                   	out    %al,(%dx)
80106ad2:	b8 0c 00 00 00       	mov    $0xc,%eax
80106ad7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106adc:	ee                   	out    %al,(%dx)
80106add:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106ae2:	89 c8                	mov    %ecx,%eax
80106ae4:	89 da                	mov    %ebx,%edx
80106ae6:	ee                   	out    %al,(%dx)
80106ae7:	b8 03 00 00 00       	mov    $0x3,%eax
80106aec:	89 f2                	mov    %esi,%edx
80106aee:	ee                   	out    %al,(%dx)
80106aef:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106af4:	89 c8                	mov    %ecx,%eax
80106af6:	ee                   	out    %al,(%dx)
80106af7:	b8 01 00 00 00       	mov    $0x1,%eax
80106afc:	89 da                	mov    %ebx,%edx
80106afe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106aff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106b04:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106b05:	3c ff                	cmp    $0xff,%al
80106b07:	0f 84 7c 00 00 00    	je     80106b89 <uartinit+0xd9>
  uart = 1;
80106b0d:	c7 05 00 5b 11 80 01 	movl   $0x1,0x80115b00
80106b14:	00 00 00 
80106b17:	89 fa                	mov    %edi,%edx
80106b19:	ec                   	in     (%dx),%al
80106b1a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b1f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106b20:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106b23:	bf ad 84 10 80       	mov    $0x801084ad,%edi
80106b28:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106b2d:	6a 00                	push   $0x0
80106b2f:	6a 04                	push   $0x4
80106b31:	e8 2a c6 ff ff       	call   80103160 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106b36:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106b3a:	83 c4 10             	add    $0x10,%esp
80106b3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106b40:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80106b45:	85 c0                	test   %eax,%eax
80106b47:	74 32                	je     80106b7b <uartinit+0xcb>
80106b49:	89 f2                	mov    %esi,%edx
80106b4b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106b4c:	a8 20                	test   $0x20,%al
80106b4e:	75 21                	jne    80106b71 <uartinit+0xc1>
80106b50:	bb 80 00 00 00       	mov    $0x80,%ebx
80106b55:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106b58:	83 ec 0c             	sub    $0xc,%esp
80106b5b:	6a 0a                	push   $0xa
80106b5d:	e8 ae ca ff ff       	call   80103610 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106b62:	83 c4 10             	add    $0x10,%esp
80106b65:	83 eb 01             	sub    $0x1,%ebx
80106b68:	74 07                	je     80106b71 <uartinit+0xc1>
80106b6a:	89 f2                	mov    %esi,%edx
80106b6c:	ec                   	in     (%dx),%al
80106b6d:	a8 20                	test   $0x20,%al
80106b6f:	74 e7                	je     80106b58 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b71:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b76:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106b7a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106b7b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106b7f:	83 c7 01             	add    $0x1,%edi
80106b82:	88 45 e7             	mov    %al,-0x19(%ebp)
80106b85:	84 c0                	test   %al,%al
80106b87:	75 b7                	jne    80106b40 <uartinit+0x90>
}
80106b89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b8c:	5b                   	pop    %ebx
80106b8d:	5e                   	pop    %esi
80106b8e:	5f                   	pop    %edi
80106b8f:	5d                   	pop    %ebp
80106b90:	c3                   	ret
80106b91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b98:	00 
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ba0 <uartputc>:
  if(!uart)
80106ba0:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80106ba5:	85 c0                	test   %eax,%eax
80106ba7:	74 4f                	je     80106bf8 <uartputc+0x58>
{
80106ba9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106baa:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106baf:	89 e5                	mov    %esp,%ebp
80106bb1:	56                   	push   %esi
80106bb2:	53                   	push   %ebx
80106bb3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106bb4:	a8 20                	test   $0x20,%al
80106bb6:	75 29                	jne    80106be1 <uartputc+0x41>
80106bb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80106bbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106bc8:	83 ec 0c             	sub    $0xc,%esp
80106bcb:	6a 0a                	push   $0xa
80106bcd:	e8 3e ca ff ff       	call   80103610 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106bd2:	83 c4 10             	add    $0x10,%esp
80106bd5:	83 eb 01             	sub    $0x1,%ebx
80106bd8:	74 07                	je     80106be1 <uartputc+0x41>
80106bda:	89 f2                	mov    %esi,%edx
80106bdc:	ec                   	in     (%dx),%al
80106bdd:	a8 20                	test   $0x20,%al
80106bdf:	74 e7                	je     80106bc8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106be1:	8b 45 08             	mov    0x8(%ebp),%eax
80106be4:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106be9:	ee                   	out    %al,(%dx)
}
80106bea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106bed:	5b                   	pop    %ebx
80106bee:	5e                   	pop    %esi
80106bef:	5d                   	pop    %ebp
80106bf0:	c3                   	ret
80106bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bf8:	c3                   	ret
80106bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c00 <uartintr>:

void
uartintr(void)
{
80106c00:	55                   	push   %ebp
80106c01:	89 e5                	mov    %esp,%ebp
80106c03:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106c06:	68 80 6a 10 80       	push   $0x80106a80
80106c0b:	e8 30 a1 ff ff       	call   80100d40 <consoleintr>
}
80106c10:	83 c4 10             	add    $0x10,%esp
80106c13:	c9                   	leave
80106c14:	c3                   	ret

80106c15 <vector0>:
80106c15:	6a 00                	push   $0x0
80106c17:	6a 00                	push   $0x0
80106c19:	e9 0c fb ff ff       	jmp    8010672a <alltraps>

80106c1e <vector1>:
80106c1e:	6a 00                	push   $0x0
80106c20:	6a 01                	push   $0x1
80106c22:	e9 03 fb ff ff       	jmp    8010672a <alltraps>

80106c27 <vector2>:
80106c27:	6a 00                	push   $0x0
80106c29:	6a 02                	push   $0x2
80106c2b:	e9 fa fa ff ff       	jmp    8010672a <alltraps>

80106c30 <vector3>:
80106c30:	6a 00                	push   $0x0
80106c32:	6a 03                	push   $0x3
80106c34:	e9 f1 fa ff ff       	jmp    8010672a <alltraps>

80106c39 <vector4>:
80106c39:	6a 00                	push   $0x0
80106c3b:	6a 04                	push   $0x4
80106c3d:	e9 e8 fa ff ff       	jmp    8010672a <alltraps>

80106c42 <vector5>:
80106c42:	6a 00                	push   $0x0
80106c44:	6a 05                	push   $0x5
80106c46:	e9 df fa ff ff       	jmp    8010672a <alltraps>

80106c4b <vector6>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	6a 06                	push   $0x6
80106c4f:	e9 d6 fa ff ff       	jmp    8010672a <alltraps>

80106c54 <vector7>:
80106c54:	6a 00                	push   $0x0
80106c56:	6a 07                	push   $0x7
80106c58:	e9 cd fa ff ff       	jmp    8010672a <alltraps>

80106c5d <vector8>:
80106c5d:	6a 08                	push   $0x8
80106c5f:	e9 c6 fa ff ff       	jmp    8010672a <alltraps>

80106c64 <vector9>:
80106c64:	6a 00                	push   $0x0
80106c66:	6a 09                	push   $0x9
80106c68:	e9 bd fa ff ff       	jmp    8010672a <alltraps>

80106c6d <vector10>:
80106c6d:	6a 0a                	push   $0xa
80106c6f:	e9 b6 fa ff ff       	jmp    8010672a <alltraps>

80106c74 <vector11>:
80106c74:	6a 0b                	push   $0xb
80106c76:	e9 af fa ff ff       	jmp    8010672a <alltraps>

80106c7b <vector12>:
80106c7b:	6a 0c                	push   $0xc
80106c7d:	e9 a8 fa ff ff       	jmp    8010672a <alltraps>

80106c82 <vector13>:
80106c82:	6a 0d                	push   $0xd
80106c84:	e9 a1 fa ff ff       	jmp    8010672a <alltraps>

80106c89 <vector14>:
80106c89:	6a 0e                	push   $0xe
80106c8b:	e9 9a fa ff ff       	jmp    8010672a <alltraps>

80106c90 <vector15>:
80106c90:	6a 00                	push   $0x0
80106c92:	6a 0f                	push   $0xf
80106c94:	e9 91 fa ff ff       	jmp    8010672a <alltraps>

80106c99 <vector16>:
80106c99:	6a 00                	push   $0x0
80106c9b:	6a 10                	push   $0x10
80106c9d:	e9 88 fa ff ff       	jmp    8010672a <alltraps>

80106ca2 <vector17>:
80106ca2:	6a 11                	push   $0x11
80106ca4:	e9 81 fa ff ff       	jmp    8010672a <alltraps>

80106ca9 <vector18>:
80106ca9:	6a 00                	push   $0x0
80106cab:	6a 12                	push   $0x12
80106cad:	e9 78 fa ff ff       	jmp    8010672a <alltraps>

80106cb2 <vector19>:
80106cb2:	6a 00                	push   $0x0
80106cb4:	6a 13                	push   $0x13
80106cb6:	e9 6f fa ff ff       	jmp    8010672a <alltraps>

80106cbb <vector20>:
80106cbb:	6a 00                	push   $0x0
80106cbd:	6a 14                	push   $0x14
80106cbf:	e9 66 fa ff ff       	jmp    8010672a <alltraps>

80106cc4 <vector21>:
80106cc4:	6a 00                	push   $0x0
80106cc6:	6a 15                	push   $0x15
80106cc8:	e9 5d fa ff ff       	jmp    8010672a <alltraps>

80106ccd <vector22>:
80106ccd:	6a 00                	push   $0x0
80106ccf:	6a 16                	push   $0x16
80106cd1:	e9 54 fa ff ff       	jmp    8010672a <alltraps>

80106cd6 <vector23>:
80106cd6:	6a 00                	push   $0x0
80106cd8:	6a 17                	push   $0x17
80106cda:	e9 4b fa ff ff       	jmp    8010672a <alltraps>

80106cdf <vector24>:
80106cdf:	6a 00                	push   $0x0
80106ce1:	6a 18                	push   $0x18
80106ce3:	e9 42 fa ff ff       	jmp    8010672a <alltraps>

80106ce8 <vector25>:
80106ce8:	6a 00                	push   $0x0
80106cea:	6a 19                	push   $0x19
80106cec:	e9 39 fa ff ff       	jmp    8010672a <alltraps>

80106cf1 <vector26>:
80106cf1:	6a 00                	push   $0x0
80106cf3:	6a 1a                	push   $0x1a
80106cf5:	e9 30 fa ff ff       	jmp    8010672a <alltraps>

80106cfa <vector27>:
80106cfa:	6a 00                	push   $0x0
80106cfc:	6a 1b                	push   $0x1b
80106cfe:	e9 27 fa ff ff       	jmp    8010672a <alltraps>

80106d03 <vector28>:
80106d03:	6a 00                	push   $0x0
80106d05:	6a 1c                	push   $0x1c
80106d07:	e9 1e fa ff ff       	jmp    8010672a <alltraps>

80106d0c <vector29>:
80106d0c:	6a 00                	push   $0x0
80106d0e:	6a 1d                	push   $0x1d
80106d10:	e9 15 fa ff ff       	jmp    8010672a <alltraps>

80106d15 <vector30>:
80106d15:	6a 00                	push   $0x0
80106d17:	6a 1e                	push   $0x1e
80106d19:	e9 0c fa ff ff       	jmp    8010672a <alltraps>

80106d1e <vector31>:
80106d1e:	6a 00                	push   $0x0
80106d20:	6a 1f                	push   $0x1f
80106d22:	e9 03 fa ff ff       	jmp    8010672a <alltraps>

80106d27 <vector32>:
80106d27:	6a 00                	push   $0x0
80106d29:	6a 20                	push   $0x20
80106d2b:	e9 fa f9 ff ff       	jmp    8010672a <alltraps>

80106d30 <vector33>:
80106d30:	6a 00                	push   $0x0
80106d32:	6a 21                	push   $0x21
80106d34:	e9 f1 f9 ff ff       	jmp    8010672a <alltraps>

80106d39 <vector34>:
80106d39:	6a 00                	push   $0x0
80106d3b:	6a 22                	push   $0x22
80106d3d:	e9 e8 f9 ff ff       	jmp    8010672a <alltraps>

80106d42 <vector35>:
80106d42:	6a 00                	push   $0x0
80106d44:	6a 23                	push   $0x23
80106d46:	e9 df f9 ff ff       	jmp    8010672a <alltraps>

80106d4b <vector36>:
80106d4b:	6a 00                	push   $0x0
80106d4d:	6a 24                	push   $0x24
80106d4f:	e9 d6 f9 ff ff       	jmp    8010672a <alltraps>

80106d54 <vector37>:
80106d54:	6a 00                	push   $0x0
80106d56:	6a 25                	push   $0x25
80106d58:	e9 cd f9 ff ff       	jmp    8010672a <alltraps>

80106d5d <vector38>:
80106d5d:	6a 00                	push   $0x0
80106d5f:	6a 26                	push   $0x26
80106d61:	e9 c4 f9 ff ff       	jmp    8010672a <alltraps>

80106d66 <vector39>:
80106d66:	6a 00                	push   $0x0
80106d68:	6a 27                	push   $0x27
80106d6a:	e9 bb f9 ff ff       	jmp    8010672a <alltraps>

80106d6f <vector40>:
80106d6f:	6a 00                	push   $0x0
80106d71:	6a 28                	push   $0x28
80106d73:	e9 b2 f9 ff ff       	jmp    8010672a <alltraps>

80106d78 <vector41>:
80106d78:	6a 00                	push   $0x0
80106d7a:	6a 29                	push   $0x29
80106d7c:	e9 a9 f9 ff ff       	jmp    8010672a <alltraps>

80106d81 <vector42>:
80106d81:	6a 00                	push   $0x0
80106d83:	6a 2a                	push   $0x2a
80106d85:	e9 a0 f9 ff ff       	jmp    8010672a <alltraps>

80106d8a <vector43>:
80106d8a:	6a 00                	push   $0x0
80106d8c:	6a 2b                	push   $0x2b
80106d8e:	e9 97 f9 ff ff       	jmp    8010672a <alltraps>

80106d93 <vector44>:
80106d93:	6a 00                	push   $0x0
80106d95:	6a 2c                	push   $0x2c
80106d97:	e9 8e f9 ff ff       	jmp    8010672a <alltraps>

80106d9c <vector45>:
80106d9c:	6a 00                	push   $0x0
80106d9e:	6a 2d                	push   $0x2d
80106da0:	e9 85 f9 ff ff       	jmp    8010672a <alltraps>

80106da5 <vector46>:
80106da5:	6a 00                	push   $0x0
80106da7:	6a 2e                	push   $0x2e
80106da9:	e9 7c f9 ff ff       	jmp    8010672a <alltraps>

80106dae <vector47>:
80106dae:	6a 00                	push   $0x0
80106db0:	6a 2f                	push   $0x2f
80106db2:	e9 73 f9 ff ff       	jmp    8010672a <alltraps>

80106db7 <vector48>:
80106db7:	6a 00                	push   $0x0
80106db9:	6a 30                	push   $0x30
80106dbb:	e9 6a f9 ff ff       	jmp    8010672a <alltraps>

80106dc0 <vector49>:
80106dc0:	6a 00                	push   $0x0
80106dc2:	6a 31                	push   $0x31
80106dc4:	e9 61 f9 ff ff       	jmp    8010672a <alltraps>

80106dc9 <vector50>:
80106dc9:	6a 00                	push   $0x0
80106dcb:	6a 32                	push   $0x32
80106dcd:	e9 58 f9 ff ff       	jmp    8010672a <alltraps>

80106dd2 <vector51>:
80106dd2:	6a 00                	push   $0x0
80106dd4:	6a 33                	push   $0x33
80106dd6:	e9 4f f9 ff ff       	jmp    8010672a <alltraps>

80106ddb <vector52>:
80106ddb:	6a 00                	push   $0x0
80106ddd:	6a 34                	push   $0x34
80106ddf:	e9 46 f9 ff ff       	jmp    8010672a <alltraps>

80106de4 <vector53>:
80106de4:	6a 00                	push   $0x0
80106de6:	6a 35                	push   $0x35
80106de8:	e9 3d f9 ff ff       	jmp    8010672a <alltraps>

80106ded <vector54>:
80106ded:	6a 00                	push   $0x0
80106def:	6a 36                	push   $0x36
80106df1:	e9 34 f9 ff ff       	jmp    8010672a <alltraps>

80106df6 <vector55>:
80106df6:	6a 00                	push   $0x0
80106df8:	6a 37                	push   $0x37
80106dfa:	e9 2b f9 ff ff       	jmp    8010672a <alltraps>

80106dff <vector56>:
80106dff:	6a 00                	push   $0x0
80106e01:	6a 38                	push   $0x38
80106e03:	e9 22 f9 ff ff       	jmp    8010672a <alltraps>

80106e08 <vector57>:
80106e08:	6a 00                	push   $0x0
80106e0a:	6a 39                	push   $0x39
80106e0c:	e9 19 f9 ff ff       	jmp    8010672a <alltraps>

80106e11 <vector58>:
80106e11:	6a 00                	push   $0x0
80106e13:	6a 3a                	push   $0x3a
80106e15:	e9 10 f9 ff ff       	jmp    8010672a <alltraps>

80106e1a <vector59>:
80106e1a:	6a 00                	push   $0x0
80106e1c:	6a 3b                	push   $0x3b
80106e1e:	e9 07 f9 ff ff       	jmp    8010672a <alltraps>

80106e23 <vector60>:
80106e23:	6a 00                	push   $0x0
80106e25:	6a 3c                	push   $0x3c
80106e27:	e9 fe f8 ff ff       	jmp    8010672a <alltraps>

80106e2c <vector61>:
80106e2c:	6a 00                	push   $0x0
80106e2e:	6a 3d                	push   $0x3d
80106e30:	e9 f5 f8 ff ff       	jmp    8010672a <alltraps>

80106e35 <vector62>:
80106e35:	6a 00                	push   $0x0
80106e37:	6a 3e                	push   $0x3e
80106e39:	e9 ec f8 ff ff       	jmp    8010672a <alltraps>

80106e3e <vector63>:
80106e3e:	6a 00                	push   $0x0
80106e40:	6a 3f                	push   $0x3f
80106e42:	e9 e3 f8 ff ff       	jmp    8010672a <alltraps>

80106e47 <vector64>:
80106e47:	6a 00                	push   $0x0
80106e49:	6a 40                	push   $0x40
80106e4b:	e9 da f8 ff ff       	jmp    8010672a <alltraps>

80106e50 <vector65>:
80106e50:	6a 00                	push   $0x0
80106e52:	6a 41                	push   $0x41
80106e54:	e9 d1 f8 ff ff       	jmp    8010672a <alltraps>

80106e59 <vector66>:
80106e59:	6a 00                	push   $0x0
80106e5b:	6a 42                	push   $0x42
80106e5d:	e9 c8 f8 ff ff       	jmp    8010672a <alltraps>

80106e62 <vector67>:
80106e62:	6a 00                	push   $0x0
80106e64:	6a 43                	push   $0x43
80106e66:	e9 bf f8 ff ff       	jmp    8010672a <alltraps>

80106e6b <vector68>:
80106e6b:	6a 00                	push   $0x0
80106e6d:	6a 44                	push   $0x44
80106e6f:	e9 b6 f8 ff ff       	jmp    8010672a <alltraps>

80106e74 <vector69>:
80106e74:	6a 00                	push   $0x0
80106e76:	6a 45                	push   $0x45
80106e78:	e9 ad f8 ff ff       	jmp    8010672a <alltraps>

80106e7d <vector70>:
80106e7d:	6a 00                	push   $0x0
80106e7f:	6a 46                	push   $0x46
80106e81:	e9 a4 f8 ff ff       	jmp    8010672a <alltraps>

80106e86 <vector71>:
80106e86:	6a 00                	push   $0x0
80106e88:	6a 47                	push   $0x47
80106e8a:	e9 9b f8 ff ff       	jmp    8010672a <alltraps>

80106e8f <vector72>:
80106e8f:	6a 00                	push   $0x0
80106e91:	6a 48                	push   $0x48
80106e93:	e9 92 f8 ff ff       	jmp    8010672a <alltraps>

80106e98 <vector73>:
80106e98:	6a 00                	push   $0x0
80106e9a:	6a 49                	push   $0x49
80106e9c:	e9 89 f8 ff ff       	jmp    8010672a <alltraps>

80106ea1 <vector74>:
80106ea1:	6a 00                	push   $0x0
80106ea3:	6a 4a                	push   $0x4a
80106ea5:	e9 80 f8 ff ff       	jmp    8010672a <alltraps>

80106eaa <vector75>:
80106eaa:	6a 00                	push   $0x0
80106eac:	6a 4b                	push   $0x4b
80106eae:	e9 77 f8 ff ff       	jmp    8010672a <alltraps>

80106eb3 <vector76>:
80106eb3:	6a 00                	push   $0x0
80106eb5:	6a 4c                	push   $0x4c
80106eb7:	e9 6e f8 ff ff       	jmp    8010672a <alltraps>

80106ebc <vector77>:
80106ebc:	6a 00                	push   $0x0
80106ebe:	6a 4d                	push   $0x4d
80106ec0:	e9 65 f8 ff ff       	jmp    8010672a <alltraps>

80106ec5 <vector78>:
80106ec5:	6a 00                	push   $0x0
80106ec7:	6a 4e                	push   $0x4e
80106ec9:	e9 5c f8 ff ff       	jmp    8010672a <alltraps>

80106ece <vector79>:
80106ece:	6a 00                	push   $0x0
80106ed0:	6a 4f                	push   $0x4f
80106ed2:	e9 53 f8 ff ff       	jmp    8010672a <alltraps>

80106ed7 <vector80>:
80106ed7:	6a 00                	push   $0x0
80106ed9:	6a 50                	push   $0x50
80106edb:	e9 4a f8 ff ff       	jmp    8010672a <alltraps>

80106ee0 <vector81>:
80106ee0:	6a 00                	push   $0x0
80106ee2:	6a 51                	push   $0x51
80106ee4:	e9 41 f8 ff ff       	jmp    8010672a <alltraps>

80106ee9 <vector82>:
80106ee9:	6a 00                	push   $0x0
80106eeb:	6a 52                	push   $0x52
80106eed:	e9 38 f8 ff ff       	jmp    8010672a <alltraps>

80106ef2 <vector83>:
80106ef2:	6a 00                	push   $0x0
80106ef4:	6a 53                	push   $0x53
80106ef6:	e9 2f f8 ff ff       	jmp    8010672a <alltraps>

80106efb <vector84>:
80106efb:	6a 00                	push   $0x0
80106efd:	6a 54                	push   $0x54
80106eff:	e9 26 f8 ff ff       	jmp    8010672a <alltraps>

80106f04 <vector85>:
80106f04:	6a 00                	push   $0x0
80106f06:	6a 55                	push   $0x55
80106f08:	e9 1d f8 ff ff       	jmp    8010672a <alltraps>

80106f0d <vector86>:
80106f0d:	6a 00                	push   $0x0
80106f0f:	6a 56                	push   $0x56
80106f11:	e9 14 f8 ff ff       	jmp    8010672a <alltraps>

80106f16 <vector87>:
80106f16:	6a 00                	push   $0x0
80106f18:	6a 57                	push   $0x57
80106f1a:	e9 0b f8 ff ff       	jmp    8010672a <alltraps>

80106f1f <vector88>:
80106f1f:	6a 00                	push   $0x0
80106f21:	6a 58                	push   $0x58
80106f23:	e9 02 f8 ff ff       	jmp    8010672a <alltraps>

80106f28 <vector89>:
80106f28:	6a 00                	push   $0x0
80106f2a:	6a 59                	push   $0x59
80106f2c:	e9 f9 f7 ff ff       	jmp    8010672a <alltraps>

80106f31 <vector90>:
80106f31:	6a 00                	push   $0x0
80106f33:	6a 5a                	push   $0x5a
80106f35:	e9 f0 f7 ff ff       	jmp    8010672a <alltraps>

80106f3a <vector91>:
80106f3a:	6a 00                	push   $0x0
80106f3c:	6a 5b                	push   $0x5b
80106f3e:	e9 e7 f7 ff ff       	jmp    8010672a <alltraps>

80106f43 <vector92>:
80106f43:	6a 00                	push   $0x0
80106f45:	6a 5c                	push   $0x5c
80106f47:	e9 de f7 ff ff       	jmp    8010672a <alltraps>

80106f4c <vector93>:
80106f4c:	6a 00                	push   $0x0
80106f4e:	6a 5d                	push   $0x5d
80106f50:	e9 d5 f7 ff ff       	jmp    8010672a <alltraps>

80106f55 <vector94>:
80106f55:	6a 00                	push   $0x0
80106f57:	6a 5e                	push   $0x5e
80106f59:	e9 cc f7 ff ff       	jmp    8010672a <alltraps>

80106f5e <vector95>:
80106f5e:	6a 00                	push   $0x0
80106f60:	6a 5f                	push   $0x5f
80106f62:	e9 c3 f7 ff ff       	jmp    8010672a <alltraps>

80106f67 <vector96>:
80106f67:	6a 00                	push   $0x0
80106f69:	6a 60                	push   $0x60
80106f6b:	e9 ba f7 ff ff       	jmp    8010672a <alltraps>

80106f70 <vector97>:
80106f70:	6a 00                	push   $0x0
80106f72:	6a 61                	push   $0x61
80106f74:	e9 b1 f7 ff ff       	jmp    8010672a <alltraps>

80106f79 <vector98>:
80106f79:	6a 00                	push   $0x0
80106f7b:	6a 62                	push   $0x62
80106f7d:	e9 a8 f7 ff ff       	jmp    8010672a <alltraps>

80106f82 <vector99>:
80106f82:	6a 00                	push   $0x0
80106f84:	6a 63                	push   $0x63
80106f86:	e9 9f f7 ff ff       	jmp    8010672a <alltraps>

80106f8b <vector100>:
80106f8b:	6a 00                	push   $0x0
80106f8d:	6a 64                	push   $0x64
80106f8f:	e9 96 f7 ff ff       	jmp    8010672a <alltraps>

80106f94 <vector101>:
80106f94:	6a 00                	push   $0x0
80106f96:	6a 65                	push   $0x65
80106f98:	e9 8d f7 ff ff       	jmp    8010672a <alltraps>

80106f9d <vector102>:
80106f9d:	6a 00                	push   $0x0
80106f9f:	6a 66                	push   $0x66
80106fa1:	e9 84 f7 ff ff       	jmp    8010672a <alltraps>

80106fa6 <vector103>:
80106fa6:	6a 00                	push   $0x0
80106fa8:	6a 67                	push   $0x67
80106faa:	e9 7b f7 ff ff       	jmp    8010672a <alltraps>

80106faf <vector104>:
80106faf:	6a 00                	push   $0x0
80106fb1:	6a 68                	push   $0x68
80106fb3:	e9 72 f7 ff ff       	jmp    8010672a <alltraps>

80106fb8 <vector105>:
80106fb8:	6a 00                	push   $0x0
80106fba:	6a 69                	push   $0x69
80106fbc:	e9 69 f7 ff ff       	jmp    8010672a <alltraps>

80106fc1 <vector106>:
80106fc1:	6a 00                	push   $0x0
80106fc3:	6a 6a                	push   $0x6a
80106fc5:	e9 60 f7 ff ff       	jmp    8010672a <alltraps>

80106fca <vector107>:
80106fca:	6a 00                	push   $0x0
80106fcc:	6a 6b                	push   $0x6b
80106fce:	e9 57 f7 ff ff       	jmp    8010672a <alltraps>

80106fd3 <vector108>:
80106fd3:	6a 00                	push   $0x0
80106fd5:	6a 6c                	push   $0x6c
80106fd7:	e9 4e f7 ff ff       	jmp    8010672a <alltraps>

80106fdc <vector109>:
80106fdc:	6a 00                	push   $0x0
80106fde:	6a 6d                	push   $0x6d
80106fe0:	e9 45 f7 ff ff       	jmp    8010672a <alltraps>

80106fe5 <vector110>:
80106fe5:	6a 00                	push   $0x0
80106fe7:	6a 6e                	push   $0x6e
80106fe9:	e9 3c f7 ff ff       	jmp    8010672a <alltraps>

80106fee <vector111>:
80106fee:	6a 00                	push   $0x0
80106ff0:	6a 6f                	push   $0x6f
80106ff2:	e9 33 f7 ff ff       	jmp    8010672a <alltraps>

80106ff7 <vector112>:
80106ff7:	6a 00                	push   $0x0
80106ff9:	6a 70                	push   $0x70
80106ffb:	e9 2a f7 ff ff       	jmp    8010672a <alltraps>

80107000 <vector113>:
80107000:	6a 00                	push   $0x0
80107002:	6a 71                	push   $0x71
80107004:	e9 21 f7 ff ff       	jmp    8010672a <alltraps>

80107009 <vector114>:
80107009:	6a 00                	push   $0x0
8010700b:	6a 72                	push   $0x72
8010700d:	e9 18 f7 ff ff       	jmp    8010672a <alltraps>

80107012 <vector115>:
80107012:	6a 00                	push   $0x0
80107014:	6a 73                	push   $0x73
80107016:	e9 0f f7 ff ff       	jmp    8010672a <alltraps>

8010701b <vector116>:
8010701b:	6a 00                	push   $0x0
8010701d:	6a 74                	push   $0x74
8010701f:	e9 06 f7 ff ff       	jmp    8010672a <alltraps>

80107024 <vector117>:
80107024:	6a 00                	push   $0x0
80107026:	6a 75                	push   $0x75
80107028:	e9 fd f6 ff ff       	jmp    8010672a <alltraps>

8010702d <vector118>:
8010702d:	6a 00                	push   $0x0
8010702f:	6a 76                	push   $0x76
80107031:	e9 f4 f6 ff ff       	jmp    8010672a <alltraps>

80107036 <vector119>:
80107036:	6a 00                	push   $0x0
80107038:	6a 77                	push   $0x77
8010703a:	e9 eb f6 ff ff       	jmp    8010672a <alltraps>

8010703f <vector120>:
8010703f:	6a 00                	push   $0x0
80107041:	6a 78                	push   $0x78
80107043:	e9 e2 f6 ff ff       	jmp    8010672a <alltraps>

80107048 <vector121>:
80107048:	6a 00                	push   $0x0
8010704a:	6a 79                	push   $0x79
8010704c:	e9 d9 f6 ff ff       	jmp    8010672a <alltraps>

80107051 <vector122>:
80107051:	6a 00                	push   $0x0
80107053:	6a 7a                	push   $0x7a
80107055:	e9 d0 f6 ff ff       	jmp    8010672a <alltraps>

8010705a <vector123>:
8010705a:	6a 00                	push   $0x0
8010705c:	6a 7b                	push   $0x7b
8010705e:	e9 c7 f6 ff ff       	jmp    8010672a <alltraps>

80107063 <vector124>:
80107063:	6a 00                	push   $0x0
80107065:	6a 7c                	push   $0x7c
80107067:	e9 be f6 ff ff       	jmp    8010672a <alltraps>

8010706c <vector125>:
8010706c:	6a 00                	push   $0x0
8010706e:	6a 7d                	push   $0x7d
80107070:	e9 b5 f6 ff ff       	jmp    8010672a <alltraps>

80107075 <vector126>:
80107075:	6a 00                	push   $0x0
80107077:	6a 7e                	push   $0x7e
80107079:	e9 ac f6 ff ff       	jmp    8010672a <alltraps>

8010707e <vector127>:
8010707e:	6a 00                	push   $0x0
80107080:	6a 7f                	push   $0x7f
80107082:	e9 a3 f6 ff ff       	jmp    8010672a <alltraps>

80107087 <vector128>:
80107087:	6a 00                	push   $0x0
80107089:	68 80 00 00 00       	push   $0x80
8010708e:	e9 97 f6 ff ff       	jmp    8010672a <alltraps>

80107093 <vector129>:
80107093:	6a 00                	push   $0x0
80107095:	68 81 00 00 00       	push   $0x81
8010709a:	e9 8b f6 ff ff       	jmp    8010672a <alltraps>

8010709f <vector130>:
8010709f:	6a 00                	push   $0x0
801070a1:	68 82 00 00 00       	push   $0x82
801070a6:	e9 7f f6 ff ff       	jmp    8010672a <alltraps>

801070ab <vector131>:
801070ab:	6a 00                	push   $0x0
801070ad:	68 83 00 00 00       	push   $0x83
801070b2:	e9 73 f6 ff ff       	jmp    8010672a <alltraps>

801070b7 <vector132>:
801070b7:	6a 00                	push   $0x0
801070b9:	68 84 00 00 00       	push   $0x84
801070be:	e9 67 f6 ff ff       	jmp    8010672a <alltraps>

801070c3 <vector133>:
801070c3:	6a 00                	push   $0x0
801070c5:	68 85 00 00 00       	push   $0x85
801070ca:	e9 5b f6 ff ff       	jmp    8010672a <alltraps>

801070cf <vector134>:
801070cf:	6a 00                	push   $0x0
801070d1:	68 86 00 00 00       	push   $0x86
801070d6:	e9 4f f6 ff ff       	jmp    8010672a <alltraps>

801070db <vector135>:
801070db:	6a 00                	push   $0x0
801070dd:	68 87 00 00 00       	push   $0x87
801070e2:	e9 43 f6 ff ff       	jmp    8010672a <alltraps>

801070e7 <vector136>:
801070e7:	6a 00                	push   $0x0
801070e9:	68 88 00 00 00       	push   $0x88
801070ee:	e9 37 f6 ff ff       	jmp    8010672a <alltraps>

801070f3 <vector137>:
801070f3:	6a 00                	push   $0x0
801070f5:	68 89 00 00 00       	push   $0x89
801070fa:	e9 2b f6 ff ff       	jmp    8010672a <alltraps>

801070ff <vector138>:
801070ff:	6a 00                	push   $0x0
80107101:	68 8a 00 00 00       	push   $0x8a
80107106:	e9 1f f6 ff ff       	jmp    8010672a <alltraps>

8010710b <vector139>:
8010710b:	6a 00                	push   $0x0
8010710d:	68 8b 00 00 00       	push   $0x8b
80107112:	e9 13 f6 ff ff       	jmp    8010672a <alltraps>

80107117 <vector140>:
80107117:	6a 00                	push   $0x0
80107119:	68 8c 00 00 00       	push   $0x8c
8010711e:	e9 07 f6 ff ff       	jmp    8010672a <alltraps>

80107123 <vector141>:
80107123:	6a 00                	push   $0x0
80107125:	68 8d 00 00 00       	push   $0x8d
8010712a:	e9 fb f5 ff ff       	jmp    8010672a <alltraps>

8010712f <vector142>:
8010712f:	6a 00                	push   $0x0
80107131:	68 8e 00 00 00       	push   $0x8e
80107136:	e9 ef f5 ff ff       	jmp    8010672a <alltraps>

8010713b <vector143>:
8010713b:	6a 00                	push   $0x0
8010713d:	68 8f 00 00 00       	push   $0x8f
80107142:	e9 e3 f5 ff ff       	jmp    8010672a <alltraps>

80107147 <vector144>:
80107147:	6a 00                	push   $0x0
80107149:	68 90 00 00 00       	push   $0x90
8010714e:	e9 d7 f5 ff ff       	jmp    8010672a <alltraps>

80107153 <vector145>:
80107153:	6a 00                	push   $0x0
80107155:	68 91 00 00 00       	push   $0x91
8010715a:	e9 cb f5 ff ff       	jmp    8010672a <alltraps>

8010715f <vector146>:
8010715f:	6a 00                	push   $0x0
80107161:	68 92 00 00 00       	push   $0x92
80107166:	e9 bf f5 ff ff       	jmp    8010672a <alltraps>

8010716b <vector147>:
8010716b:	6a 00                	push   $0x0
8010716d:	68 93 00 00 00       	push   $0x93
80107172:	e9 b3 f5 ff ff       	jmp    8010672a <alltraps>

80107177 <vector148>:
80107177:	6a 00                	push   $0x0
80107179:	68 94 00 00 00       	push   $0x94
8010717e:	e9 a7 f5 ff ff       	jmp    8010672a <alltraps>

80107183 <vector149>:
80107183:	6a 00                	push   $0x0
80107185:	68 95 00 00 00       	push   $0x95
8010718a:	e9 9b f5 ff ff       	jmp    8010672a <alltraps>

8010718f <vector150>:
8010718f:	6a 00                	push   $0x0
80107191:	68 96 00 00 00       	push   $0x96
80107196:	e9 8f f5 ff ff       	jmp    8010672a <alltraps>

8010719b <vector151>:
8010719b:	6a 00                	push   $0x0
8010719d:	68 97 00 00 00       	push   $0x97
801071a2:	e9 83 f5 ff ff       	jmp    8010672a <alltraps>

801071a7 <vector152>:
801071a7:	6a 00                	push   $0x0
801071a9:	68 98 00 00 00       	push   $0x98
801071ae:	e9 77 f5 ff ff       	jmp    8010672a <alltraps>

801071b3 <vector153>:
801071b3:	6a 00                	push   $0x0
801071b5:	68 99 00 00 00       	push   $0x99
801071ba:	e9 6b f5 ff ff       	jmp    8010672a <alltraps>

801071bf <vector154>:
801071bf:	6a 00                	push   $0x0
801071c1:	68 9a 00 00 00       	push   $0x9a
801071c6:	e9 5f f5 ff ff       	jmp    8010672a <alltraps>

801071cb <vector155>:
801071cb:	6a 00                	push   $0x0
801071cd:	68 9b 00 00 00       	push   $0x9b
801071d2:	e9 53 f5 ff ff       	jmp    8010672a <alltraps>

801071d7 <vector156>:
801071d7:	6a 00                	push   $0x0
801071d9:	68 9c 00 00 00       	push   $0x9c
801071de:	e9 47 f5 ff ff       	jmp    8010672a <alltraps>

801071e3 <vector157>:
801071e3:	6a 00                	push   $0x0
801071e5:	68 9d 00 00 00       	push   $0x9d
801071ea:	e9 3b f5 ff ff       	jmp    8010672a <alltraps>

801071ef <vector158>:
801071ef:	6a 00                	push   $0x0
801071f1:	68 9e 00 00 00       	push   $0x9e
801071f6:	e9 2f f5 ff ff       	jmp    8010672a <alltraps>

801071fb <vector159>:
801071fb:	6a 00                	push   $0x0
801071fd:	68 9f 00 00 00       	push   $0x9f
80107202:	e9 23 f5 ff ff       	jmp    8010672a <alltraps>

80107207 <vector160>:
80107207:	6a 00                	push   $0x0
80107209:	68 a0 00 00 00       	push   $0xa0
8010720e:	e9 17 f5 ff ff       	jmp    8010672a <alltraps>

80107213 <vector161>:
80107213:	6a 00                	push   $0x0
80107215:	68 a1 00 00 00       	push   $0xa1
8010721a:	e9 0b f5 ff ff       	jmp    8010672a <alltraps>

8010721f <vector162>:
8010721f:	6a 00                	push   $0x0
80107221:	68 a2 00 00 00       	push   $0xa2
80107226:	e9 ff f4 ff ff       	jmp    8010672a <alltraps>

8010722b <vector163>:
8010722b:	6a 00                	push   $0x0
8010722d:	68 a3 00 00 00       	push   $0xa3
80107232:	e9 f3 f4 ff ff       	jmp    8010672a <alltraps>

80107237 <vector164>:
80107237:	6a 00                	push   $0x0
80107239:	68 a4 00 00 00       	push   $0xa4
8010723e:	e9 e7 f4 ff ff       	jmp    8010672a <alltraps>

80107243 <vector165>:
80107243:	6a 00                	push   $0x0
80107245:	68 a5 00 00 00       	push   $0xa5
8010724a:	e9 db f4 ff ff       	jmp    8010672a <alltraps>

8010724f <vector166>:
8010724f:	6a 00                	push   $0x0
80107251:	68 a6 00 00 00       	push   $0xa6
80107256:	e9 cf f4 ff ff       	jmp    8010672a <alltraps>

8010725b <vector167>:
8010725b:	6a 00                	push   $0x0
8010725d:	68 a7 00 00 00       	push   $0xa7
80107262:	e9 c3 f4 ff ff       	jmp    8010672a <alltraps>

80107267 <vector168>:
80107267:	6a 00                	push   $0x0
80107269:	68 a8 00 00 00       	push   $0xa8
8010726e:	e9 b7 f4 ff ff       	jmp    8010672a <alltraps>

80107273 <vector169>:
80107273:	6a 00                	push   $0x0
80107275:	68 a9 00 00 00       	push   $0xa9
8010727a:	e9 ab f4 ff ff       	jmp    8010672a <alltraps>

8010727f <vector170>:
8010727f:	6a 00                	push   $0x0
80107281:	68 aa 00 00 00       	push   $0xaa
80107286:	e9 9f f4 ff ff       	jmp    8010672a <alltraps>

8010728b <vector171>:
8010728b:	6a 00                	push   $0x0
8010728d:	68 ab 00 00 00       	push   $0xab
80107292:	e9 93 f4 ff ff       	jmp    8010672a <alltraps>

80107297 <vector172>:
80107297:	6a 00                	push   $0x0
80107299:	68 ac 00 00 00       	push   $0xac
8010729e:	e9 87 f4 ff ff       	jmp    8010672a <alltraps>

801072a3 <vector173>:
801072a3:	6a 00                	push   $0x0
801072a5:	68 ad 00 00 00       	push   $0xad
801072aa:	e9 7b f4 ff ff       	jmp    8010672a <alltraps>

801072af <vector174>:
801072af:	6a 00                	push   $0x0
801072b1:	68 ae 00 00 00       	push   $0xae
801072b6:	e9 6f f4 ff ff       	jmp    8010672a <alltraps>

801072bb <vector175>:
801072bb:	6a 00                	push   $0x0
801072bd:	68 af 00 00 00       	push   $0xaf
801072c2:	e9 63 f4 ff ff       	jmp    8010672a <alltraps>

801072c7 <vector176>:
801072c7:	6a 00                	push   $0x0
801072c9:	68 b0 00 00 00       	push   $0xb0
801072ce:	e9 57 f4 ff ff       	jmp    8010672a <alltraps>

801072d3 <vector177>:
801072d3:	6a 00                	push   $0x0
801072d5:	68 b1 00 00 00       	push   $0xb1
801072da:	e9 4b f4 ff ff       	jmp    8010672a <alltraps>

801072df <vector178>:
801072df:	6a 00                	push   $0x0
801072e1:	68 b2 00 00 00       	push   $0xb2
801072e6:	e9 3f f4 ff ff       	jmp    8010672a <alltraps>

801072eb <vector179>:
801072eb:	6a 00                	push   $0x0
801072ed:	68 b3 00 00 00       	push   $0xb3
801072f2:	e9 33 f4 ff ff       	jmp    8010672a <alltraps>

801072f7 <vector180>:
801072f7:	6a 00                	push   $0x0
801072f9:	68 b4 00 00 00       	push   $0xb4
801072fe:	e9 27 f4 ff ff       	jmp    8010672a <alltraps>

80107303 <vector181>:
80107303:	6a 00                	push   $0x0
80107305:	68 b5 00 00 00       	push   $0xb5
8010730a:	e9 1b f4 ff ff       	jmp    8010672a <alltraps>

8010730f <vector182>:
8010730f:	6a 00                	push   $0x0
80107311:	68 b6 00 00 00       	push   $0xb6
80107316:	e9 0f f4 ff ff       	jmp    8010672a <alltraps>

8010731b <vector183>:
8010731b:	6a 00                	push   $0x0
8010731d:	68 b7 00 00 00       	push   $0xb7
80107322:	e9 03 f4 ff ff       	jmp    8010672a <alltraps>

80107327 <vector184>:
80107327:	6a 00                	push   $0x0
80107329:	68 b8 00 00 00       	push   $0xb8
8010732e:	e9 f7 f3 ff ff       	jmp    8010672a <alltraps>

80107333 <vector185>:
80107333:	6a 00                	push   $0x0
80107335:	68 b9 00 00 00       	push   $0xb9
8010733a:	e9 eb f3 ff ff       	jmp    8010672a <alltraps>

8010733f <vector186>:
8010733f:	6a 00                	push   $0x0
80107341:	68 ba 00 00 00       	push   $0xba
80107346:	e9 df f3 ff ff       	jmp    8010672a <alltraps>

8010734b <vector187>:
8010734b:	6a 00                	push   $0x0
8010734d:	68 bb 00 00 00       	push   $0xbb
80107352:	e9 d3 f3 ff ff       	jmp    8010672a <alltraps>

80107357 <vector188>:
80107357:	6a 00                	push   $0x0
80107359:	68 bc 00 00 00       	push   $0xbc
8010735e:	e9 c7 f3 ff ff       	jmp    8010672a <alltraps>

80107363 <vector189>:
80107363:	6a 00                	push   $0x0
80107365:	68 bd 00 00 00       	push   $0xbd
8010736a:	e9 bb f3 ff ff       	jmp    8010672a <alltraps>

8010736f <vector190>:
8010736f:	6a 00                	push   $0x0
80107371:	68 be 00 00 00       	push   $0xbe
80107376:	e9 af f3 ff ff       	jmp    8010672a <alltraps>

8010737b <vector191>:
8010737b:	6a 00                	push   $0x0
8010737d:	68 bf 00 00 00       	push   $0xbf
80107382:	e9 a3 f3 ff ff       	jmp    8010672a <alltraps>

80107387 <vector192>:
80107387:	6a 00                	push   $0x0
80107389:	68 c0 00 00 00       	push   $0xc0
8010738e:	e9 97 f3 ff ff       	jmp    8010672a <alltraps>

80107393 <vector193>:
80107393:	6a 00                	push   $0x0
80107395:	68 c1 00 00 00       	push   $0xc1
8010739a:	e9 8b f3 ff ff       	jmp    8010672a <alltraps>

8010739f <vector194>:
8010739f:	6a 00                	push   $0x0
801073a1:	68 c2 00 00 00       	push   $0xc2
801073a6:	e9 7f f3 ff ff       	jmp    8010672a <alltraps>

801073ab <vector195>:
801073ab:	6a 00                	push   $0x0
801073ad:	68 c3 00 00 00       	push   $0xc3
801073b2:	e9 73 f3 ff ff       	jmp    8010672a <alltraps>

801073b7 <vector196>:
801073b7:	6a 00                	push   $0x0
801073b9:	68 c4 00 00 00       	push   $0xc4
801073be:	e9 67 f3 ff ff       	jmp    8010672a <alltraps>

801073c3 <vector197>:
801073c3:	6a 00                	push   $0x0
801073c5:	68 c5 00 00 00       	push   $0xc5
801073ca:	e9 5b f3 ff ff       	jmp    8010672a <alltraps>

801073cf <vector198>:
801073cf:	6a 00                	push   $0x0
801073d1:	68 c6 00 00 00       	push   $0xc6
801073d6:	e9 4f f3 ff ff       	jmp    8010672a <alltraps>

801073db <vector199>:
801073db:	6a 00                	push   $0x0
801073dd:	68 c7 00 00 00       	push   $0xc7
801073e2:	e9 43 f3 ff ff       	jmp    8010672a <alltraps>

801073e7 <vector200>:
801073e7:	6a 00                	push   $0x0
801073e9:	68 c8 00 00 00       	push   $0xc8
801073ee:	e9 37 f3 ff ff       	jmp    8010672a <alltraps>

801073f3 <vector201>:
801073f3:	6a 00                	push   $0x0
801073f5:	68 c9 00 00 00       	push   $0xc9
801073fa:	e9 2b f3 ff ff       	jmp    8010672a <alltraps>

801073ff <vector202>:
801073ff:	6a 00                	push   $0x0
80107401:	68 ca 00 00 00       	push   $0xca
80107406:	e9 1f f3 ff ff       	jmp    8010672a <alltraps>

8010740b <vector203>:
8010740b:	6a 00                	push   $0x0
8010740d:	68 cb 00 00 00       	push   $0xcb
80107412:	e9 13 f3 ff ff       	jmp    8010672a <alltraps>

80107417 <vector204>:
80107417:	6a 00                	push   $0x0
80107419:	68 cc 00 00 00       	push   $0xcc
8010741e:	e9 07 f3 ff ff       	jmp    8010672a <alltraps>

80107423 <vector205>:
80107423:	6a 00                	push   $0x0
80107425:	68 cd 00 00 00       	push   $0xcd
8010742a:	e9 fb f2 ff ff       	jmp    8010672a <alltraps>

8010742f <vector206>:
8010742f:	6a 00                	push   $0x0
80107431:	68 ce 00 00 00       	push   $0xce
80107436:	e9 ef f2 ff ff       	jmp    8010672a <alltraps>

8010743b <vector207>:
8010743b:	6a 00                	push   $0x0
8010743d:	68 cf 00 00 00       	push   $0xcf
80107442:	e9 e3 f2 ff ff       	jmp    8010672a <alltraps>

80107447 <vector208>:
80107447:	6a 00                	push   $0x0
80107449:	68 d0 00 00 00       	push   $0xd0
8010744e:	e9 d7 f2 ff ff       	jmp    8010672a <alltraps>

80107453 <vector209>:
80107453:	6a 00                	push   $0x0
80107455:	68 d1 00 00 00       	push   $0xd1
8010745a:	e9 cb f2 ff ff       	jmp    8010672a <alltraps>

8010745f <vector210>:
8010745f:	6a 00                	push   $0x0
80107461:	68 d2 00 00 00       	push   $0xd2
80107466:	e9 bf f2 ff ff       	jmp    8010672a <alltraps>

8010746b <vector211>:
8010746b:	6a 00                	push   $0x0
8010746d:	68 d3 00 00 00       	push   $0xd3
80107472:	e9 b3 f2 ff ff       	jmp    8010672a <alltraps>

80107477 <vector212>:
80107477:	6a 00                	push   $0x0
80107479:	68 d4 00 00 00       	push   $0xd4
8010747e:	e9 a7 f2 ff ff       	jmp    8010672a <alltraps>

80107483 <vector213>:
80107483:	6a 00                	push   $0x0
80107485:	68 d5 00 00 00       	push   $0xd5
8010748a:	e9 9b f2 ff ff       	jmp    8010672a <alltraps>

8010748f <vector214>:
8010748f:	6a 00                	push   $0x0
80107491:	68 d6 00 00 00       	push   $0xd6
80107496:	e9 8f f2 ff ff       	jmp    8010672a <alltraps>

8010749b <vector215>:
8010749b:	6a 00                	push   $0x0
8010749d:	68 d7 00 00 00       	push   $0xd7
801074a2:	e9 83 f2 ff ff       	jmp    8010672a <alltraps>

801074a7 <vector216>:
801074a7:	6a 00                	push   $0x0
801074a9:	68 d8 00 00 00       	push   $0xd8
801074ae:	e9 77 f2 ff ff       	jmp    8010672a <alltraps>

801074b3 <vector217>:
801074b3:	6a 00                	push   $0x0
801074b5:	68 d9 00 00 00       	push   $0xd9
801074ba:	e9 6b f2 ff ff       	jmp    8010672a <alltraps>

801074bf <vector218>:
801074bf:	6a 00                	push   $0x0
801074c1:	68 da 00 00 00       	push   $0xda
801074c6:	e9 5f f2 ff ff       	jmp    8010672a <alltraps>

801074cb <vector219>:
801074cb:	6a 00                	push   $0x0
801074cd:	68 db 00 00 00       	push   $0xdb
801074d2:	e9 53 f2 ff ff       	jmp    8010672a <alltraps>

801074d7 <vector220>:
801074d7:	6a 00                	push   $0x0
801074d9:	68 dc 00 00 00       	push   $0xdc
801074de:	e9 47 f2 ff ff       	jmp    8010672a <alltraps>

801074e3 <vector221>:
801074e3:	6a 00                	push   $0x0
801074e5:	68 dd 00 00 00       	push   $0xdd
801074ea:	e9 3b f2 ff ff       	jmp    8010672a <alltraps>

801074ef <vector222>:
801074ef:	6a 00                	push   $0x0
801074f1:	68 de 00 00 00       	push   $0xde
801074f6:	e9 2f f2 ff ff       	jmp    8010672a <alltraps>

801074fb <vector223>:
801074fb:	6a 00                	push   $0x0
801074fd:	68 df 00 00 00       	push   $0xdf
80107502:	e9 23 f2 ff ff       	jmp    8010672a <alltraps>

80107507 <vector224>:
80107507:	6a 00                	push   $0x0
80107509:	68 e0 00 00 00       	push   $0xe0
8010750e:	e9 17 f2 ff ff       	jmp    8010672a <alltraps>

80107513 <vector225>:
80107513:	6a 00                	push   $0x0
80107515:	68 e1 00 00 00       	push   $0xe1
8010751a:	e9 0b f2 ff ff       	jmp    8010672a <alltraps>

8010751f <vector226>:
8010751f:	6a 00                	push   $0x0
80107521:	68 e2 00 00 00       	push   $0xe2
80107526:	e9 ff f1 ff ff       	jmp    8010672a <alltraps>

8010752b <vector227>:
8010752b:	6a 00                	push   $0x0
8010752d:	68 e3 00 00 00       	push   $0xe3
80107532:	e9 f3 f1 ff ff       	jmp    8010672a <alltraps>

80107537 <vector228>:
80107537:	6a 00                	push   $0x0
80107539:	68 e4 00 00 00       	push   $0xe4
8010753e:	e9 e7 f1 ff ff       	jmp    8010672a <alltraps>

80107543 <vector229>:
80107543:	6a 00                	push   $0x0
80107545:	68 e5 00 00 00       	push   $0xe5
8010754a:	e9 db f1 ff ff       	jmp    8010672a <alltraps>

8010754f <vector230>:
8010754f:	6a 00                	push   $0x0
80107551:	68 e6 00 00 00       	push   $0xe6
80107556:	e9 cf f1 ff ff       	jmp    8010672a <alltraps>

8010755b <vector231>:
8010755b:	6a 00                	push   $0x0
8010755d:	68 e7 00 00 00       	push   $0xe7
80107562:	e9 c3 f1 ff ff       	jmp    8010672a <alltraps>

80107567 <vector232>:
80107567:	6a 00                	push   $0x0
80107569:	68 e8 00 00 00       	push   $0xe8
8010756e:	e9 b7 f1 ff ff       	jmp    8010672a <alltraps>

80107573 <vector233>:
80107573:	6a 00                	push   $0x0
80107575:	68 e9 00 00 00       	push   $0xe9
8010757a:	e9 ab f1 ff ff       	jmp    8010672a <alltraps>

8010757f <vector234>:
8010757f:	6a 00                	push   $0x0
80107581:	68 ea 00 00 00       	push   $0xea
80107586:	e9 9f f1 ff ff       	jmp    8010672a <alltraps>

8010758b <vector235>:
8010758b:	6a 00                	push   $0x0
8010758d:	68 eb 00 00 00       	push   $0xeb
80107592:	e9 93 f1 ff ff       	jmp    8010672a <alltraps>

80107597 <vector236>:
80107597:	6a 00                	push   $0x0
80107599:	68 ec 00 00 00       	push   $0xec
8010759e:	e9 87 f1 ff ff       	jmp    8010672a <alltraps>

801075a3 <vector237>:
801075a3:	6a 00                	push   $0x0
801075a5:	68 ed 00 00 00       	push   $0xed
801075aa:	e9 7b f1 ff ff       	jmp    8010672a <alltraps>

801075af <vector238>:
801075af:	6a 00                	push   $0x0
801075b1:	68 ee 00 00 00       	push   $0xee
801075b6:	e9 6f f1 ff ff       	jmp    8010672a <alltraps>

801075bb <vector239>:
801075bb:	6a 00                	push   $0x0
801075bd:	68 ef 00 00 00       	push   $0xef
801075c2:	e9 63 f1 ff ff       	jmp    8010672a <alltraps>

801075c7 <vector240>:
801075c7:	6a 00                	push   $0x0
801075c9:	68 f0 00 00 00       	push   $0xf0
801075ce:	e9 57 f1 ff ff       	jmp    8010672a <alltraps>

801075d3 <vector241>:
801075d3:	6a 00                	push   $0x0
801075d5:	68 f1 00 00 00       	push   $0xf1
801075da:	e9 4b f1 ff ff       	jmp    8010672a <alltraps>

801075df <vector242>:
801075df:	6a 00                	push   $0x0
801075e1:	68 f2 00 00 00       	push   $0xf2
801075e6:	e9 3f f1 ff ff       	jmp    8010672a <alltraps>

801075eb <vector243>:
801075eb:	6a 00                	push   $0x0
801075ed:	68 f3 00 00 00       	push   $0xf3
801075f2:	e9 33 f1 ff ff       	jmp    8010672a <alltraps>

801075f7 <vector244>:
801075f7:	6a 00                	push   $0x0
801075f9:	68 f4 00 00 00       	push   $0xf4
801075fe:	e9 27 f1 ff ff       	jmp    8010672a <alltraps>

80107603 <vector245>:
80107603:	6a 00                	push   $0x0
80107605:	68 f5 00 00 00       	push   $0xf5
8010760a:	e9 1b f1 ff ff       	jmp    8010672a <alltraps>

8010760f <vector246>:
8010760f:	6a 00                	push   $0x0
80107611:	68 f6 00 00 00       	push   $0xf6
80107616:	e9 0f f1 ff ff       	jmp    8010672a <alltraps>

8010761b <vector247>:
8010761b:	6a 00                	push   $0x0
8010761d:	68 f7 00 00 00       	push   $0xf7
80107622:	e9 03 f1 ff ff       	jmp    8010672a <alltraps>

80107627 <vector248>:
80107627:	6a 00                	push   $0x0
80107629:	68 f8 00 00 00       	push   $0xf8
8010762e:	e9 f7 f0 ff ff       	jmp    8010672a <alltraps>

80107633 <vector249>:
80107633:	6a 00                	push   $0x0
80107635:	68 f9 00 00 00       	push   $0xf9
8010763a:	e9 eb f0 ff ff       	jmp    8010672a <alltraps>

8010763f <vector250>:
8010763f:	6a 00                	push   $0x0
80107641:	68 fa 00 00 00       	push   $0xfa
80107646:	e9 df f0 ff ff       	jmp    8010672a <alltraps>

8010764b <vector251>:
8010764b:	6a 00                	push   $0x0
8010764d:	68 fb 00 00 00       	push   $0xfb
80107652:	e9 d3 f0 ff ff       	jmp    8010672a <alltraps>

80107657 <vector252>:
80107657:	6a 00                	push   $0x0
80107659:	68 fc 00 00 00       	push   $0xfc
8010765e:	e9 c7 f0 ff ff       	jmp    8010672a <alltraps>

80107663 <vector253>:
80107663:	6a 00                	push   $0x0
80107665:	68 fd 00 00 00       	push   $0xfd
8010766a:	e9 bb f0 ff ff       	jmp    8010672a <alltraps>

8010766f <vector254>:
8010766f:	6a 00                	push   $0x0
80107671:	68 fe 00 00 00       	push   $0xfe
80107676:	e9 af f0 ff ff       	jmp    8010672a <alltraps>

8010767b <vector255>:
8010767b:	6a 00                	push   $0x0
8010767d:	68 ff 00 00 00       	push   $0xff
80107682:	e9 a3 f0 ff ff       	jmp    8010672a <alltraps>
80107687:	66 90                	xchg   %ax,%ax
80107689:	66 90                	xchg   %ax,%ax
8010768b:	66 90                	xchg   %ax,%ax
8010768d:	66 90                	xchg   %ax,%ax
8010768f:	90                   	nop

80107690 <deallocuvm.part.0>:
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	57                   	push   %edi
80107694:	56                   	push   %esi
80107695:	53                   	push   %ebx
80107696:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010769c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801076a2:	83 ec 1c             	sub    $0x1c,%esp
801076a5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801076a8:	39 d3                	cmp    %edx,%ebx
801076aa:	73 49                	jae    801076f5 <deallocuvm.part.0+0x65>
801076ac:	89 c7                	mov    %eax,%edi
801076ae:	eb 0c                	jmp    801076bc <deallocuvm.part.0+0x2c>
801076b0:	83 c0 01             	add    $0x1,%eax
801076b3:	c1 e0 16             	shl    $0x16,%eax
801076b6:	89 c3                	mov    %eax,%ebx
801076b8:	39 da                	cmp    %ebx,%edx
801076ba:	76 39                	jbe    801076f5 <deallocuvm.part.0+0x65>
801076bc:	89 d8                	mov    %ebx,%eax
801076be:	c1 e8 16             	shr    $0x16,%eax
801076c1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801076c4:	f6 c1 01             	test   $0x1,%cl
801076c7:	74 e7                	je     801076b0 <deallocuvm.part.0+0x20>
801076c9:	89 de                	mov    %ebx,%esi
801076cb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801076d1:	c1 ee 0a             	shr    $0xa,%esi
801076d4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801076da:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
801076e1:	85 f6                	test   %esi,%esi
801076e3:	74 cb                	je     801076b0 <deallocuvm.part.0+0x20>
801076e5:	8b 06                	mov    (%esi),%eax
801076e7:	a8 01                	test   $0x1,%al
801076e9:	75 15                	jne    80107700 <deallocuvm.part.0+0x70>
801076eb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076f1:	39 da                	cmp    %ebx,%edx
801076f3:	77 c7                	ja     801076bc <deallocuvm.part.0+0x2c>
801076f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076fb:	5b                   	pop    %ebx
801076fc:	5e                   	pop    %esi
801076fd:	5f                   	pop    %edi
801076fe:	5d                   	pop    %ebp
801076ff:	c3                   	ret
80107700:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107705:	74 25                	je     8010772c <deallocuvm.part.0+0x9c>
80107707:	83 ec 0c             	sub    $0xc,%esp
8010770a:	05 00 00 00 80       	add    $0x80000000,%eax
8010770f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107712:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107718:	50                   	push   %eax
80107719:	e8 82 ba ff ff       	call   801031a0 <kfree>
8010771e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80107724:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107727:	83 c4 10             	add    $0x10,%esp
8010772a:	eb 8c                	jmp    801076b8 <deallocuvm.part.0+0x28>
8010772c:	83 ec 0c             	sub    $0xc,%esp
8010772f:	68 54 82 10 80       	push   $0x80108254
80107734:	e8 d7 8d ff ff       	call   80100510 <panic>
80107739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107740 <mappages>:
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	57                   	push   %edi
80107744:	56                   	push   %esi
80107745:	53                   	push   %ebx
80107746:	89 d3                	mov    %edx,%ebx
80107748:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010774e:	83 ec 1c             	sub    $0x1c,%esp
80107751:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107754:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107758:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010775d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107760:	8b 45 08             	mov    0x8(%ebp),%eax
80107763:	29 d8                	sub    %ebx,%eax
80107765:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107768:	eb 3d                	jmp    801077a7 <mappages+0x67>
8010776a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107770:	89 da                	mov    %ebx,%edx
80107772:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107777:	c1 ea 0a             	shr    $0xa,%edx
8010777a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107780:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107787:	85 c0                	test   %eax,%eax
80107789:	74 75                	je     80107800 <mappages+0xc0>
8010778b:	f6 00 01             	testb  $0x1,(%eax)
8010778e:	0f 85 86 00 00 00    	jne    8010781a <mappages+0xda>
80107794:	0b 75 0c             	or     0xc(%ebp),%esi
80107797:	83 ce 01             	or     $0x1,%esi
8010779a:	89 30                	mov    %esi,(%eax)
8010779c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010779f:	74 6f                	je     80107810 <mappages+0xd0>
801077a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077aa:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801077ad:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801077b0:	89 d8                	mov    %ebx,%eax
801077b2:	c1 e8 16             	shr    $0x16,%eax
801077b5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
801077b8:	8b 07                	mov    (%edi),%eax
801077ba:	a8 01                	test   $0x1,%al
801077bc:	75 b2                	jne    80107770 <mappages+0x30>
801077be:	e8 9d bb ff ff       	call   80103360 <kalloc>
801077c3:	85 c0                	test   %eax,%eax
801077c5:	74 39                	je     80107800 <mappages+0xc0>
801077c7:	83 ec 04             	sub    $0x4,%esp
801077ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
801077cd:	68 00 10 00 00       	push   $0x1000
801077d2:	6a 00                	push   $0x0
801077d4:	50                   	push   %eax
801077d5:	e8 c6 db ff ff       	call   801053a0 <memset>
801077da:	8b 55 d8             	mov    -0x28(%ebp),%edx
801077dd:	83 c4 10             	add    $0x10,%esp
801077e0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801077e6:	83 c8 07             	or     $0x7,%eax
801077e9:	89 07                	mov    %eax,(%edi)
801077eb:	89 d8                	mov    %ebx,%eax
801077ed:	c1 e8 0a             	shr    $0xa,%eax
801077f0:	25 fc 0f 00 00       	and    $0xffc,%eax
801077f5:	01 d0                	add    %edx,%eax
801077f7:	eb 92                	jmp    8010778b <mappages+0x4b>
801077f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107800:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107808:	5b                   	pop    %ebx
80107809:	5e                   	pop    %esi
8010780a:	5f                   	pop    %edi
8010780b:	5d                   	pop    %ebp
8010780c:	c3                   	ret
8010780d:	8d 76 00             	lea    0x0(%esi),%esi
80107810:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107813:	31 c0                	xor    %eax,%eax
80107815:	5b                   	pop    %ebx
80107816:	5e                   	pop    %esi
80107817:	5f                   	pop    %edi
80107818:	5d                   	pop    %ebp
80107819:	c3                   	ret
8010781a:	83 ec 0c             	sub    $0xc,%esp
8010781d:	68 b5 84 10 80       	push   $0x801084b5
80107822:	e8 e9 8c ff ff       	call   80100510 <panic>
80107827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010782e:	66 90                	xchg   %ax,%ax

80107830 <seginit>:
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	83 ec 18             	sub    $0x18,%esp
80107836:	e8 05 ce ff ff       	call   80104640 <cpuid>
8010783b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107840:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107846:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010784a:	c7 80 58 2e 11 80 ff 	movl   $0xffff,-0x7feed1a8(%eax)
80107851:	ff 00 00 
80107854:	c7 80 5c 2e 11 80 00 	movl   $0xcf9a00,-0x7feed1a4(%eax)
8010785b:	9a cf 00 
8010785e:	c7 80 60 2e 11 80 ff 	movl   $0xffff,-0x7feed1a0(%eax)
80107865:	ff 00 00 
80107868:	c7 80 64 2e 11 80 00 	movl   $0xcf9200,-0x7feed19c(%eax)
8010786f:	92 cf 00 
80107872:	c7 80 68 2e 11 80 ff 	movl   $0xffff,-0x7feed198(%eax)
80107879:	ff 00 00 
8010787c:	c7 80 6c 2e 11 80 00 	movl   $0xcffa00,-0x7feed194(%eax)
80107883:	fa cf 00 
80107886:	c7 80 70 2e 11 80 ff 	movl   $0xffff,-0x7feed190(%eax)
8010788d:	ff 00 00 
80107890:	c7 80 74 2e 11 80 00 	movl   $0xcff200,-0x7feed18c(%eax)
80107897:	f2 cf 00 
8010789a:	05 50 2e 11 80       	add    $0x80112e50,%eax
8010789f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
801078a3:	c1 e8 10             	shr    $0x10,%eax
801078a6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
801078aa:	8d 45 f2             	lea    -0xe(%ebp),%eax
801078ad:	0f 01 10             	lgdtl  (%eax)
801078b0:	c9                   	leave
801078b1:	c3                   	ret
801078b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078c0 <switchkvm>:
801078c0:	a1 04 5b 11 80       	mov    0x80115b04,%eax
801078c5:	05 00 00 00 80       	add    $0x80000000,%eax
801078ca:	0f 22 d8             	mov    %eax,%cr3
801078cd:	c3                   	ret
801078ce:	66 90                	xchg   %ax,%ax

801078d0 <switchuvm>:
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	57                   	push   %edi
801078d4:	56                   	push   %esi
801078d5:	53                   	push   %ebx
801078d6:	83 ec 1c             	sub    $0x1c,%esp
801078d9:	8b 75 08             	mov    0x8(%ebp),%esi
801078dc:	85 f6                	test   %esi,%esi
801078de:	0f 84 cb 00 00 00    	je     801079af <switchuvm+0xdf>
801078e4:	8b 46 08             	mov    0x8(%esi),%eax
801078e7:	85 c0                	test   %eax,%eax
801078e9:	0f 84 da 00 00 00    	je     801079c9 <switchuvm+0xf9>
801078ef:	8b 46 04             	mov    0x4(%esi),%eax
801078f2:	85 c0                	test   %eax,%eax
801078f4:	0f 84 c2 00 00 00    	je     801079bc <switchuvm+0xec>
801078fa:	e8 51 d8 ff ff       	call   80105150 <pushcli>
801078ff:	e8 dc cc ff ff       	call   801045e0 <mycpu>
80107904:	89 c3                	mov    %eax,%ebx
80107906:	e8 d5 cc ff ff       	call   801045e0 <mycpu>
8010790b:	89 c7                	mov    %eax,%edi
8010790d:	e8 ce cc ff ff       	call   801045e0 <mycpu>
80107912:	83 c7 08             	add    $0x8,%edi
80107915:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107918:	e8 c3 cc ff ff       	call   801045e0 <mycpu>
8010791d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107920:	ba 67 00 00 00       	mov    $0x67,%edx
80107925:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010792c:	83 c0 08             	add    $0x8,%eax
8010792f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107936:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010793b:	83 c1 08             	add    $0x8,%ecx
8010793e:	c1 e8 18             	shr    $0x18,%eax
80107941:	c1 e9 10             	shr    $0x10,%ecx
80107944:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010794a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107950:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107955:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
8010795c:	bb 10 00 00 00       	mov    $0x10,%ebx
80107961:	e8 7a cc ff ff       	call   801045e0 <mycpu>
80107966:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
8010796d:	e8 6e cc ff ff       	call   801045e0 <mycpu>
80107972:	66 89 58 10          	mov    %bx,0x10(%eax)
80107976:	8b 5e 08             	mov    0x8(%esi),%ebx
80107979:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010797f:	e8 5c cc ff ff       	call   801045e0 <mycpu>
80107984:	89 58 0c             	mov    %ebx,0xc(%eax)
80107987:	e8 54 cc ff ff       	call   801045e0 <mycpu>
8010798c:	66 89 78 6e          	mov    %di,0x6e(%eax)
80107990:	b8 28 00 00 00       	mov    $0x28,%eax
80107995:	0f 00 d8             	ltr    %eax
80107998:	8b 46 04             	mov    0x4(%esi),%eax
8010799b:	05 00 00 00 80       	add    $0x80000000,%eax
801079a0:	0f 22 d8             	mov    %eax,%cr3
801079a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079a6:	5b                   	pop    %ebx
801079a7:	5e                   	pop    %esi
801079a8:	5f                   	pop    %edi
801079a9:	5d                   	pop    %ebp
801079aa:	e9 f1 d7 ff ff       	jmp    801051a0 <popcli>
801079af:	83 ec 0c             	sub    $0xc,%esp
801079b2:	68 bb 84 10 80       	push   $0x801084bb
801079b7:	e8 54 8b ff ff       	call   80100510 <panic>
801079bc:	83 ec 0c             	sub    $0xc,%esp
801079bf:	68 e6 84 10 80       	push   $0x801084e6
801079c4:	e8 47 8b ff ff       	call   80100510 <panic>
801079c9:	83 ec 0c             	sub    $0xc,%esp
801079cc:	68 d1 84 10 80       	push   $0x801084d1
801079d1:	e8 3a 8b ff ff       	call   80100510 <panic>
801079d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079dd:	8d 76 00             	lea    0x0(%esi),%esi

801079e0 <inituvm>:
801079e0:	55                   	push   %ebp
801079e1:	89 e5                	mov    %esp,%ebp
801079e3:	57                   	push   %edi
801079e4:	56                   	push   %esi
801079e5:	53                   	push   %ebx
801079e6:	83 ec 1c             	sub    $0x1c,%esp
801079e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801079ec:	8b 75 10             	mov    0x10(%ebp),%esi
801079ef:	8b 7d 08             	mov    0x8(%ebp),%edi
801079f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801079f5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801079fb:	77 4b                	ja     80107a48 <inituvm+0x68>
801079fd:	e8 5e b9 ff ff       	call   80103360 <kalloc>
80107a02:	83 ec 04             	sub    $0x4,%esp
80107a05:	68 00 10 00 00       	push   $0x1000
80107a0a:	89 c3                	mov    %eax,%ebx
80107a0c:	6a 00                	push   $0x0
80107a0e:	50                   	push   %eax
80107a0f:	e8 8c d9 ff ff       	call   801053a0 <memset>
80107a14:	58                   	pop    %eax
80107a15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a1b:	5a                   	pop    %edx
80107a1c:	6a 06                	push   $0x6
80107a1e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a23:	31 d2                	xor    %edx,%edx
80107a25:	50                   	push   %eax
80107a26:	89 f8                	mov    %edi,%eax
80107a28:	e8 13 fd ff ff       	call   80107740 <mappages>
80107a2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a30:	89 75 10             	mov    %esi,0x10(%ebp)
80107a33:	83 c4 10             	add    $0x10,%esp
80107a36:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107a39:	89 45 0c             	mov    %eax,0xc(%ebp)
80107a3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a3f:	5b                   	pop    %ebx
80107a40:	5e                   	pop    %esi
80107a41:	5f                   	pop    %edi
80107a42:	5d                   	pop    %ebp
80107a43:	e9 e8 d9 ff ff       	jmp    80105430 <memmove>
80107a48:	83 ec 0c             	sub    $0xc,%esp
80107a4b:	68 fa 84 10 80       	push   $0x801084fa
80107a50:	e8 bb 8a ff ff       	call   80100510 <panic>
80107a55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107a60 <loaduvm>:
80107a60:	55                   	push   %ebp
80107a61:	89 e5                	mov    %esp,%ebp
80107a63:	57                   	push   %edi
80107a64:	56                   	push   %esi
80107a65:	53                   	push   %ebx
80107a66:	83 ec 1c             	sub    $0x1c,%esp
80107a69:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a6c:	8b 75 18             	mov    0x18(%ebp),%esi
80107a6f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107a74:	0f 85 bb 00 00 00    	jne    80107b35 <loaduvm+0xd5>
80107a7a:	01 f0                	add    %esi,%eax
80107a7c:	89 f3                	mov    %esi,%ebx
80107a7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107a81:	8b 45 14             	mov    0x14(%ebp),%eax
80107a84:	01 f0                	add    %esi,%eax
80107a86:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107a89:	85 f6                	test   %esi,%esi
80107a8b:	0f 84 87 00 00 00    	je     80107b18 <loaduvm+0xb8>
80107a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a9b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107a9e:	29 d8                	sub    %ebx,%eax
80107aa0:	89 c2                	mov    %eax,%edx
80107aa2:	c1 ea 16             	shr    $0x16,%edx
80107aa5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107aa8:	f6 c2 01             	test   $0x1,%dl
80107aab:	75 13                	jne    80107ac0 <loaduvm+0x60>
80107aad:	83 ec 0c             	sub    $0xc,%esp
80107ab0:	68 14 85 10 80       	push   $0x80108514
80107ab5:	e8 56 8a ff ff       	call   80100510 <panic>
80107aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107ac0:	c1 e8 0a             	shr    $0xa,%eax
80107ac3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107ac9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107ace:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107ad5:	85 c0                	test   %eax,%eax
80107ad7:	74 d4                	je     80107aad <loaduvm+0x4d>
80107ad9:	8b 00                	mov    (%eax),%eax
80107adb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107ade:	bf 00 10 00 00       	mov    $0x1000,%edi
80107ae3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ae8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107aee:	0f 46 fb             	cmovbe %ebx,%edi
80107af1:	29 d9                	sub    %ebx,%ecx
80107af3:	05 00 00 00 80       	add    $0x80000000,%eax
80107af8:	57                   	push   %edi
80107af9:	51                   	push   %ecx
80107afa:	50                   	push   %eax
80107afb:	ff 75 10             	push   0x10(%ebp)
80107afe:	e8 ad ac ff ff       	call   801027b0 <readi>
80107b03:	83 c4 10             	add    $0x10,%esp
80107b06:	39 f8                	cmp    %edi,%eax
80107b08:	75 1e                	jne    80107b28 <loaduvm+0xc8>
80107b0a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107b10:	89 f0                	mov    %esi,%eax
80107b12:	29 d8                	sub    %ebx,%eax
80107b14:	39 c6                	cmp    %eax,%esi
80107b16:	77 80                	ja     80107a98 <loaduvm+0x38>
80107b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b1b:	31 c0                	xor    %eax,%eax
80107b1d:	5b                   	pop    %ebx
80107b1e:	5e                   	pop    %esi
80107b1f:	5f                   	pop    %edi
80107b20:	5d                   	pop    %ebp
80107b21:	c3                   	ret
80107b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b30:	5b                   	pop    %ebx
80107b31:	5e                   	pop    %esi
80107b32:	5f                   	pop    %edi
80107b33:	5d                   	pop    %ebp
80107b34:	c3                   	ret
80107b35:	83 ec 0c             	sub    $0xc,%esp
80107b38:	68 7c 87 10 80       	push   $0x8010877c
80107b3d:	e8 ce 89 ff ff       	call   80100510 <panic>
80107b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b50 <allocuvm>:
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	57                   	push   %edi
80107b54:	56                   	push   %esi
80107b55:	53                   	push   %ebx
80107b56:	83 ec 1c             	sub    $0x1c,%esp
80107b59:	8b 45 10             	mov    0x10(%ebp),%eax
80107b5c:	8b 7d 08             	mov    0x8(%ebp),%edi
80107b5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107b62:	85 c0                	test   %eax,%eax
80107b64:	0f 88 b6 00 00 00    	js     80107c20 <allocuvm+0xd0>
80107b6a:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107b6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b70:	0f 82 9a 00 00 00    	jb     80107c10 <allocuvm+0xc0>
80107b76:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107b7c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107b82:	39 75 10             	cmp    %esi,0x10(%ebp)
80107b85:	77 44                	ja     80107bcb <allocuvm+0x7b>
80107b87:	e9 87 00 00 00       	jmp    80107c13 <allocuvm+0xc3>
80107b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b90:	83 ec 04             	sub    $0x4,%esp
80107b93:	68 00 10 00 00       	push   $0x1000
80107b98:	6a 00                	push   $0x0
80107b9a:	50                   	push   %eax
80107b9b:	e8 00 d8 ff ff       	call   801053a0 <memset>
80107ba0:	58                   	pop    %eax
80107ba1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107ba7:	5a                   	pop    %edx
80107ba8:	6a 06                	push   $0x6
80107baa:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107baf:	89 f2                	mov    %esi,%edx
80107bb1:	50                   	push   %eax
80107bb2:	89 f8                	mov    %edi,%eax
80107bb4:	e8 87 fb ff ff       	call   80107740 <mappages>
80107bb9:	83 c4 10             	add    $0x10,%esp
80107bbc:	85 c0                	test   %eax,%eax
80107bbe:	78 78                	js     80107c38 <allocuvm+0xe8>
80107bc0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107bc6:	39 75 10             	cmp    %esi,0x10(%ebp)
80107bc9:	76 48                	jbe    80107c13 <allocuvm+0xc3>
80107bcb:	e8 90 b7 ff ff       	call   80103360 <kalloc>
80107bd0:	89 c3                	mov    %eax,%ebx
80107bd2:	85 c0                	test   %eax,%eax
80107bd4:	75 ba                	jne    80107b90 <allocuvm+0x40>
80107bd6:	83 ec 0c             	sub    $0xc,%esp
80107bd9:	68 32 85 10 80       	push   $0x80108532
80107bde:	e8 ad 8e ff ff       	call   80100a90 <cprintf>
80107be3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107be6:	83 c4 10             	add    $0x10,%esp
80107be9:	39 45 10             	cmp    %eax,0x10(%ebp)
80107bec:	74 32                	je     80107c20 <allocuvm+0xd0>
80107bee:	8b 55 10             	mov    0x10(%ebp),%edx
80107bf1:	89 c1                	mov    %eax,%ecx
80107bf3:	89 f8                	mov    %edi,%eax
80107bf5:	e8 96 fa ff ff       	call   80107690 <deallocuvm.part.0>
80107bfa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107c01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c07:	5b                   	pop    %ebx
80107c08:	5e                   	pop    %esi
80107c09:	5f                   	pop    %edi
80107c0a:	5d                   	pop    %ebp
80107c0b:	c3                   	ret
80107c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c19:	5b                   	pop    %ebx
80107c1a:	5e                   	pop    %esi
80107c1b:	5f                   	pop    %edi
80107c1c:	5d                   	pop    %ebp
80107c1d:	c3                   	ret
80107c1e:	66 90                	xchg   %ax,%ax
80107c20:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107c27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c2d:	5b                   	pop    %ebx
80107c2e:	5e                   	pop    %esi
80107c2f:	5f                   	pop    %edi
80107c30:	5d                   	pop    %ebp
80107c31:	c3                   	ret
80107c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c38:	83 ec 0c             	sub    $0xc,%esp
80107c3b:	68 4a 85 10 80       	push   $0x8010854a
80107c40:	e8 4b 8e ff ff       	call   80100a90 <cprintf>
80107c45:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c48:	83 c4 10             	add    $0x10,%esp
80107c4b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107c4e:	74 0c                	je     80107c5c <allocuvm+0x10c>
80107c50:	8b 55 10             	mov    0x10(%ebp),%edx
80107c53:	89 c1                	mov    %eax,%ecx
80107c55:	89 f8                	mov    %edi,%eax
80107c57:	e8 34 fa ff ff       	call   80107690 <deallocuvm.part.0>
80107c5c:	83 ec 0c             	sub    $0xc,%esp
80107c5f:	53                   	push   %ebx
80107c60:	e8 3b b5 ff ff       	call   801031a0 <kfree>
80107c65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107c6c:	83 c4 10             	add    $0x10,%esp
80107c6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c75:	5b                   	pop    %ebx
80107c76:	5e                   	pop    %esi
80107c77:	5f                   	pop    %edi
80107c78:	5d                   	pop    %ebp
80107c79:	c3                   	ret
80107c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c80 <deallocuvm>:
80107c80:	55                   	push   %ebp
80107c81:	89 e5                	mov    %esp,%ebp
80107c83:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c86:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107c89:	8b 45 08             	mov    0x8(%ebp),%eax
80107c8c:	39 d1                	cmp    %edx,%ecx
80107c8e:	73 10                	jae    80107ca0 <deallocuvm+0x20>
80107c90:	5d                   	pop    %ebp
80107c91:	e9 fa f9 ff ff       	jmp    80107690 <deallocuvm.part.0>
80107c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c9d:	8d 76 00             	lea    0x0(%esi),%esi
80107ca0:	89 d0                	mov    %edx,%eax
80107ca2:	5d                   	pop    %ebp
80107ca3:	c3                   	ret
80107ca4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107caf:	90                   	nop

80107cb0 <freevm>:
80107cb0:	55                   	push   %ebp
80107cb1:	89 e5                	mov    %esp,%ebp
80107cb3:	57                   	push   %edi
80107cb4:	56                   	push   %esi
80107cb5:	53                   	push   %ebx
80107cb6:	83 ec 0c             	sub    $0xc,%esp
80107cb9:	8b 75 08             	mov    0x8(%ebp),%esi
80107cbc:	85 f6                	test   %esi,%esi
80107cbe:	74 59                	je     80107d19 <freevm+0x69>
80107cc0:	31 c9                	xor    %ecx,%ecx
80107cc2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107cc7:	89 f0                	mov    %esi,%eax
80107cc9:	89 f3                	mov    %esi,%ebx
80107ccb:	e8 c0 f9 ff ff       	call   80107690 <deallocuvm.part.0>
80107cd0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107cd6:	eb 0f                	jmp    80107ce7 <freevm+0x37>
80107cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cdf:	90                   	nop
80107ce0:	83 c3 04             	add    $0x4,%ebx
80107ce3:	39 df                	cmp    %ebx,%edi
80107ce5:	74 23                	je     80107d0a <freevm+0x5a>
80107ce7:	8b 03                	mov    (%ebx),%eax
80107ce9:	a8 01                	test   $0x1,%al
80107ceb:	74 f3                	je     80107ce0 <freevm+0x30>
80107ced:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cf2:	83 ec 0c             	sub    $0xc,%esp
80107cf5:	83 c3 04             	add    $0x4,%ebx
80107cf8:	05 00 00 00 80       	add    $0x80000000,%eax
80107cfd:	50                   	push   %eax
80107cfe:	e8 9d b4 ff ff       	call   801031a0 <kfree>
80107d03:	83 c4 10             	add    $0x10,%esp
80107d06:	39 df                	cmp    %ebx,%edi
80107d08:	75 dd                	jne    80107ce7 <freevm+0x37>
80107d0a:	89 75 08             	mov    %esi,0x8(%ebp)
80107d0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d10:	5b                   	pop    %ebx
80107d11:	5e                   	pop    %esi
80107d12:	5f                   	pop    %edi
80107d13:	5d                   	pop    %ebp
80107d14:	e9 87 b4 ff ff       	jmp    801031a0 <kfree>
80107d19:	83 ec 0c             	sub    $0xc,%esp
80107d1c:	68 66 85 10 80       	push   $0x80108566
80107d21:	e8 ea 87 ff ff       	call   80100510 <panic>
80107d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d2d:	8d 76 00             	lea    0x0(%esi),%esi

80107d30 <setupkvm>:
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	56                   	push   %esi
80107d34:	53                   	push   %ebx
80107d35:	e8 26 b6 ff ff       	call   80103360 <kalloc>
80107d3a:	89 c6                	mov    %eax,%esi
80107d3c:	85 c0                	test   %eax,%eax
80107d3e:	74 42                	je     80107d82 <setupkvm+0x52>
80107d40:	83 ec 04             	sub    $0x4,%esp
80107d43:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
80107d48:	68 00 10 00 00       	push   $0x1000
80107d4d:	6a 00                	push   $0x0
80107d4f:	50                   	push   %eax
80107d50:	e8 4b d6 ff ff       	call   801053a0 <memset>
80107d55:	83 c4 10             	add    $0x10,%esp
80107d58:	8b 43 04             	mov    0x4(%ebx),%eax
80107d5b:	83 ec 08             	sub    $0x8,%esp
80107d5e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107d61:	ff 73 0c             	push   0xc(%ebx)
80107d64:	8b 13                	mov    (%ebx),%edx
80107d66:	50                   	push   %eax
80107d67:	29 c1                	sub    %eax,%ecx
80107d69:	89 f0                	mov    %esi,%eax
80107d6b:	e8 d0 f9 ff ff       	call   80107740 <mappages>
80107d70:	83 c4 10             	add    $0x10,%esp
80107d73:	85 c0                	test   %eax,%eax
80107d75:	78 19                	js     80107d90 <setupkvm+0x60>
80107d77:	83 c3 10             	add    $0x10,%ebx
80107d7a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107d80:	75 d6                	jne    80107d58 <setupkvm+0x28>
80107d82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d85:	89 f0                	mov    %esi,%eax
80107d87:	5b                   	pop    %ebx
80107d88:	5e                   	pop    %esi
80107d89:	5d                   	pop    %ebp
80107d8a:	c3                   	ret
80107d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107d8f:	90                   	nop
80107d90:	83 ec 0c             	sub    $0xc,%esp
80107d93:	56                   	push   %esi
80107d94:	31 f6                	xor    %esi,%esi
80107d96:	e8 15 ff ff ff       	call   80107cb0 <freevm>
80107d9b:	83 c4 10             	add    $0x10,%esp
80107d9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107da1:	89 f0                	mov    %esi,%eax
80107da3:	5b                   	pop    %ebx
80107da4:	5e                   	pop    %esi
80107da5:	5d                   	pop    %ebp
80107da6:	c3                   	ret
80107da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107dae:	66 90                	xchg   %ax,%ax

80107db0 <kvmalloc>:
80107db0:	55                   	push   %ebp
80107db1:	89 e5                	mov    %esp,%ebp
80107db3:	83 ec 08             	sub    $0x8,%esp
80107db6:	e8 75 ff ff ff       	call   80107d30 <setupkvm>
80107dbb:	a3 04 5b 11 80       	mov    %eax,0x80115b04
80107dc0:	05 00 00 00 80       	add    $0x80000000,%eax
80107dc5:	0f 22 d8             	mov    %eax,%cr3
80107dc8:	c9                   	leave
80107dc9:	c3                   	ret
80107dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107dd0 <clearpteu>:
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	83 ec 08             	sub    $0x8,%esp
80107dd6:	8b 45 0c             	mov    0xc(%ebp),%eax
80107dd9:	8b 55 08             	mov    0x8(%ebp),%edx
80107ddc:	89 c1                	mov    %eax,%ecx
80107dde:	c1 e9 16             	shr    $0x16,%ecx
80107de1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107de4:	f6 c2 01             	test   $0x1,%dl
80107de7:	75 17                	jne    80107e00 <clearpteu+0x30>
80107de9:	83 ec 0c             	sub    $0xc,%esp
80107dec:	68 77 85 10 80       	push   $0x80108577
80107df1:	e8 1a 87 ff ff       	call   80100510 <panic>
80107df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107dfd:	8d 76 00             	lea    0x0(%esi),%esi
80107e00:	c1 e8 0a             	shr    $0xa,%eax
80107e03:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107e09:	25 fc 0f 00 00       	and    $0xffc,%eax
80107e0e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107e15:	85 c0                	test   %eax,%eax
80107e17:	74 d0                	je     80107de9 <clearpteu+0x19>
80107e19:	83 20 fb             	andl   $0xfffffffb,(%eax)
80107e1c:	c9                   	leave
80107e1d:	c3                   	ret
80107e1e:	66 90                	xchg   %ax,%ax

80107e20 <copyuvm>:
80107e20:	55                   	push   %ebp
80107e21:	89 e5                	mov    %esp,%ebp
80107e23:	57                   	push   %edi
80107e24:	56                   	push   %esi
80107e25:	53                   	push   %ebx
80107e26:	83 ec 1c             	sub    $0x1c,%esp
80107e29:	e8 02 ff ff ff       	call   80107d30 <setupkvm>
80107e2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107e31:	85 c0                	test   %eax,%eax
80107e33:	0f 84 bd 00 00 00    	je     80107ef6 <copyuvm+0xd6>
80107e39:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107e3c:	85 c9                	test   %ecx,%ecx
80107e3e:	0f 84 b2 00 00 00    	je     80107ef6 <copyuvm+0xd6>
80107e44:	31 f6                	xor    %esi,%esi
80107e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e4d:	8d 76 00             	lea    0x0(%esi),%esi
80107e50:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107e53:	89 f0                	mov    %esi,%eax
80107e55:	c1 e8 16             	shr    $0x16,%eax
80107e58:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107e5b:	a8 01                	test   $0x1,%al
80107e5d:	75 11                	jne    80107e70 <copyuvm+0x50>
80107e5f:	83 ec 0c             	sub    $0xc,%esp
80107e62:	68 81 85 10 80       	push   $0x80108581
80107e67:	e8 a4 86 ff ff       	call   80100510 <panic>
80107e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e70:	89 f2                	mov    %esi,%edx
80107e72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e77:	c1 ea 0a             	shr    $0xa,%edx
80107e7a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e80:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107e87:	85 c0                	test   %eax,%eax
80107e89:	74 d4                	je     80107e5f <copyuvm+0x3f>
80107e8b:	8b 00                	mov    (%eax),%eax
80107e8d:	a8 01                	test   $0x1,%al
80107e8f:	0f 84 9f 00 00 00    	je     80107f34 <copyuvm+0x114>
80107e95:	89 c7                	mov    %eax,%edi
80107e97:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e9f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107ea5:	e8 b6 b4 ff ff       	call   80103360 <kalloc>
80107eaa:	89 c3                	mov    %eax,%ebx
80107eac:	85 c0                	test   %eax,%eax
80107eae:	74 64                	je     80107f14 <copyuvm+0xf4>
80107eb0:	83 ec 04             	sub    $0x4,%esp
80107eb3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107eb9:	68 00 10 00 00       	push   $0x1000
80107ebe:	57                   	push   %edi
80107ebf:	50                   	push   %eax
80107ec0:	e8 6b d5 ff ff       	call   80105430 <memmove>
80107ec5:	58                   	pop    %eax
80107ec6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107ecc:	5a                   	pop    %edx
80107ecd:	ff 75 e4             	push   -0x1c(%ebp)
80107ed0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107ed5:	89 f2                	mov    %esi,%edx
80107ed7:	50                   	push   %eax
80107ed8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107edb:	e8 60 f8 ff ff       	call   80107740 <mappages>
80107ee0:	83 c4 10             	add    $0x10,%esp
80107ee3:	85 c0                	test   %eax,%eax
80107ee5:	78 21                	js     80107f08 <copyuvm+0xe8>
80107ee7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107eed:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107ef0:	0f 87 5a ff ff ff    	ja     80107e50 <copyuvm+0x30>
80107ef6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ef9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107efc:	5b                   	pop    %ebx
80107efd:	5e                   	pop    %esi
80107efe:	5f                   	pop    %edi
80107eff:	5d                   	pop    %ebp
80107f00:	c3                   	ret
80107f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f08:	83 ec 0c             	sub    $0xc,%esp
80107f0b:	53                   	push   %ebx
80107f0c:	e8 8f b2 ff ff       	call   801031a0 <kfree>
80107f11:	83 c4 10             	add    $0x10,%esp
80107f14:	83 ec 0c             	sub    $0xc,%esp
80107f17:	ff 75 e0             	push   -0x20(%ebp)
80107f1a:	e8 91 fd ff ff       	call   80107cb0 <freevm>
80107f1f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107f26:	83 c4 10             	add    $0x10,%esp
80107f29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107f2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f2f:	5b                   	pop    %ebx
80107f30:	5e                   	pop    %esi
80107f31:	5f                   	pop    %edi
80107f32:	5d                   	pop    %ebp
80107f33:	c3                   	ret
80107f34:	83 ec 0c             	sub    $0xc,%esp
80107f37:	68 9b 85 10 80       	push   $0x8010859b
80107f3c:	e8 cf 85 ff ff       	call   80100510 <panic>
80107f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f4f:	90                   	nop

80107f50 <uva2ka>:
80107f50:	55                   	push   %ebp
80107f51:	89 e5                	mov    %esp,%ebp
80107f53:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f56:	8b 55 08             	mov    0x8(%ebp),%edx
80107f59:	89 c1                	mov    %eax,%ecx
80107f5b:	c1 e9 16             	shr    $0x16,%ecx
80107f5e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107f61:	f6 c2 01             	test   $0x1,%dl
80107f64:	0f 84 00 01 00 00    	je     8010806a <uva2ka.cold>
80107f6a:	c1 e8 0c             	shr    $0xc,%eax
80107f6d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107f73:	5d                   	pop    %ebp
80107f74:	25 ff 03 00 00       	and    $0x3ff,%eax
80107f79:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
80107f80:	89 c2                	mov    %eax,%edx
80107f82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f87:	83 e2 05             	and    $0x5,%edx
80107f8a:	05 00 00 00 80       	add    $0x80000000,%eax
80107f8f:	83 fa 05             	cmp    $0x5,%edx
80107f92:	ba 00 00 00 00       	mov    $0x0,%edx
80107f97:	0f 45 c2             	cmovne %edx,%eax
80107f9a:	c3                   	ret
80107f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f9f:	90                   	nop

80107fa0 <copyout>:
80107fa0:	55                   	push   %ebp
80107fa1:	89 e5                	mov    %esp,%ebp
80107fa3:	57                   	push   %edi
80107fa4:	56                   	push   %esi
80107fa5:	53                   	push   %ebx
80107fa6:	83 ec 0c             	sub    $0xc,%esp
80107fa9:	8b 75 14             	mov    0x14(%ebp),%esi
80107fac:	8b 45 0c             	mov    0xc(%ebp),%eax
80107faf:	8b 55 10             	mov    0x10(%ebp),%edx
80107fb2:	85 f6                	test   %esi,%esi
80107fb4:	75 51                	jne    80108007 <copyout+0x67>
80107fb6:	e9 a5 00 00 00       	jmp    80108060 <copyout+0xc0>
80107fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107fbf:	90                   	nop
80107fc0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107fc6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
80107fcc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107fd2:	74 75                	je     80108049 <copyout+0xa9>
80107fd4:	89 fb                	mov    %edi,%ebx
80107fd6:	89 55 10             	mov    %edx,0x10(%ebp)
80107fd9:	29 c3                	sub    %eax,%ebx
80107fdb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107fe1:	39 f3                	cmp    %esi,%ebx
80107fe3:	0f 47 de             	cmova  %esi,%ebx
80107fe6:	29 f8                	sub    %edi,%eax
80107fe8:	83 ec 04             	sub    $0x4,%esp
80107feb:	01 c1                	add    %eax,%ecx
80107fed:	53                   	push   %ebx
80107fee:	52                   	push   %edx
80107fef:	51                   	push   %ecx
80107ff0:	e8 3b d4 ff ff       	call   80105430 <memmove>
80107ff5:	8b 55 10             	mov    0x10(%ebp),%edx
80107ff8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
80107ffe:	83 c4 10             	add    $0x10,%esp
80108001:	01 da                	add    %ebx,%edx
80108003:	29 de                	sub    %ebx,%esi
80108005:	74 59                	je     80108060 <copyout+0xc0>
80108007:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010800a:	89 c1                	mov    %eax,%ecx
8010800c:	89 c7                	mov    %eax,%edi
8010800e:	c1 e9 16             	shr    $0x16,%ecx
80108011:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80108017:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010801a:	f6 c1 01             	test   $0x1,%cl
8010801d:	0f 84 4e 00 00 00    	je     80108071 <copyout.cold>
80108023:	89 fb                	mov    %edi,%ebx
80108025:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
8010802b:	c1 eb 0c             	shr    $0xc,%ebx
8010802e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80108034:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
8010803b:	89 d9                	mov    %ebx,%ecx
8010803d:	83 e1 05             	and    $0x5,%ecx
80108040:	83 f9 05             	cmp    $0x5,%ecx
80108043:	0f 84 77 ff ff ff    	je     80107fc0 <copyout+0x20>
80108049:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010804c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108051:	5b                   	pop    %ebx
80108052:	5e                   	pop    %esi
80108053:	5f                   	pop    %edi
80108054:	5d                   	pop    %ebp
80108055:	c3                   	ret
80108056:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010805d:	8d 76 00             	lea    0x0(%esi),%esi
80108060:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108063:	31 c0                	xor    %eax,%eax
80108065:	5b                   	pop    %ebx
80108066:	5e                   	pop    %esi
80108067:	5f                   	pop    %edi
80108068:	5d                   	pop    %ebp
80108069:	c3                   	ret

8010806a <uva2ka.cold>:
8010806a:	a1 00 00 00 00       	mov    0x0,%eax
8010806f:	0f 0b                	ud2

80108071 <copyout.cold>:
80108071:	a1 00 00 00 00       	mov    0x0,%eax
80108076:	0f 0b                	ud2
