
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
80100028:	bc 70 9f 11 80       	mov    $0x80119f70,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 a0 3d 10 80       	mov    $0x80103da0,%eax
  jmp *%eax
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
80100044:	bb b4 c5 10 80       	mov    $0x8010c5b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 8f 10 80       	push   $0x80108f60
80100051:	68 80 c5 10 80       	push   $0x8010c580
80100056:	e8 85 5b 00 00       	call   80105be0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 7c 0c 11 80       	mov    $0x80110c7c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 cc 0c 11 80 7c 	movl   $0x80110c7c,0x80110ccc
8010006a:	0c 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 d0 0c 11 80 7c 	movl   $0x80110c7c,0x80110cd0
80100074:	0c 11 80 
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
8010008b:	c7 43 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 8f 10 80       	push   $0x80108f67
80100097:	50                   	push   %eax
80100098:	e8 13 5a 00 00       	call   80105ab0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d d0 0c 11 80    	mov    %ebx,0x80110cd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 20 0a 11 80    	cmp    $0x80110a20,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000df:	68 80 c5 10 80       	push   $0x8010c580
801000e4:	e8 c7 5c 00 00       	call   80105db0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 0c 11 80    	mov    0x80110cd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
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
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 0c 11 80    	mov    0x80110ccc,%ebx
80100126:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 0c 11 80    	cmp    $0x80110c7c,%ebx
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
8010015d:	68 80 c5 10 80       	push   $0x8010c580
80100162:	e8 e9 5b 00 00       	call   80105d50 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 59 00 00       	call   80105af0 <acquiresleep>
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
8010018c:	e8 8f 2e 00 00       	call   80103020 <iderw>
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
801001a1:	68 6e 8f 10 80       	push   $0x80108f6e
801001a6:	e8 45 03 00 00       	call   801004f0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

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
801001be:	e8 cd 59 00 00       	call   80105b90 <holdingsleep>
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
801001d4:	e9 47 2e 00 00       	jmp    80103020 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 8f 10 80       	push   $0x80108f7f
801001e1:	e8 0a 03 00 00       	call   801004f0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

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
801001ff:	e8 8c 59 00 00       	call   80105b90 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 3c 59 00 00       	call   80105b50 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
8010021b:	e8 90 5b 00 00       	call   80105db0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d d0 0c 11 80    	mov    %ebx,0x80110cd0
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 df 5a 00 00       	jmp    80105d50 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 86 8f 10 80       	push   $0x80108f86
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
80100344:	e8 47 22 00 00       	call   80102590 <iunlock>
  acquire(&cons.lock);
80100349:	c7 04 24 c0 15 11 80 	movl   $0x801115c0,(%esp)
80100350:	e8 5b 5a 00 00       	call   80105db0 <acquire>
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
8010037d:	e8 3e 4f 00 00       	call   801052c0 <sleep>
    while(input.r == input.w){
80100382:	a1 a0 15 11 80       	mov    0x801115a0,%eax
80100387:	83 c4 10             	add    $0x10,%esp
8010038a:	3b 05 a4 15 11 80    	cmp    0x801115a4,%eax
80100390:	75 3e                	jne    801003d0 <consoleread+0xa0>
      if(myproc()->killed){
80100392:	e8 99 43 00 00       	call   80104730 <myproc>
80100397:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010039d:	85 c9                	test   %ecx,%ecx
8010039f:	74 cf                	je     80100370 <consoleread+0x40>
        release(&cons.lock);
801003a1:	83 ec 0c             	sub    $0xc,%esp
801003a4:	68 c0 15 11 80       	push   $0x801115c0
801003a9:	e8 a2 59 00 00       	call   80105d50 <release>
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
80100404:	e8 47 59 00 00       	call   80105d50 <release>
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
80100509:	e8 22 31 00 00       	call   80103630 <lapicid>
8010050e:	83 ec 08             	sub    $0x8,%esp
80100511:	50                   	push   %eax
80100512:	68 8d 8f 10 80       	push   $0x80108f8d
80100517:	e8 54 05 00 00       	call   80100a70 <cprintf>
  cprintf(s);
8010051c:	58                   	pop    %eax
8010051d:	ff 75 08             	push   0x8(%ebp)
80100520:	e8 4b 05 00 00       	call   80100a70 <cprintf>
  cprintf("\n");
80100525:	c7 04 24 2b 95 10 80 	movl   $0x8010952b,(%esp)
8010052c:	e8 3f 05 00 00       	call   80100a70 <cprintf>
  getcallerpcs(&s, pcs);
80100531:	8d 45 08             	lea    0x8(%ebp),%eax
80100534:	5a                   	pop    %edx
80100535:	59                   	pop    %ecx
80100536:	53                   	push   %ebx
80100537:	50                   	push   %eax
80100538:	e8 c3 56 00 00       	call   80105c00 <getcallerpcs>
  for(i=0; i<10; i++)
8010053d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100540:	83 ec 08             	sub    $0x8,%esp
80100543:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100545:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100548:	68 a1 8f 10 80       	push   $0x80108fa1
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
801005f8:	e8 13 59 00 00       	call   80105f10 <memmove>
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
801005fd:	b8 80 07 00 00       	mov    $0x780,%eax
80100602:	83 c4 0c             	add    $0xc,%esp
80100605:	29 d8                	sub    %ebx,%eax
80100607:	01 c0                	add    %eax,%eax
80100609:	50                   	push   %eax
8010060a:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100611:	6a 00                	push   $0x0
80100613:	50                   	push   %eax
80100614:	e8 57 58 00 00       	call   80105e70 <memset>
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
80100791:	68 a5 8f 10 80       	push   $0x80108fa5
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
801007bb:	e8 f0 55 00 00       	call   80105db0 <acquire>
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
801007ea:	e8 81 72 00 00       	call   80107a70 <uartputc>
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
80100806:	e8 45 55 00 00       	call   80105d50 <release>
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
80100856:	0f b6 92 18 90 10 80 	movzbl -0x7fef6fe8(%edx),%edx
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
80100897:	e8 d4 71 00 00       	call   80107a70 <uartputc>
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
8010097d:	e8 ee 70 00 00       	call   80107a70 <uartputc>
80100982:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100989:	e8 e2 70 00 00       	call   80107a70 <uartputc>
8010098e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100995:	e8 d6 70 00 00       	call   80107a70 <uartputc>
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
80100a2a:	e8 41 70 00 00       	call   80107a70 <uartputc>
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
80100b25:	bf b8 8f 10 80       	mov    $0x80108fb8,%edi
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
80100b9a:	e8 d1 6e 00 00       	call   80107a70 <uartputc>
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
80100bc8:	e8 e3 51 00 00       	call   80105db0 <acquire>
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
80100be7:	e8 84 6e 00 00       	call   80107a70 <uartputc>
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
80100c28:	e8 43 6e 00 00       	call   80107a70 <uartputc>
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
80100c73:	e8 f8 6d 00 00       	call   80107a70 <uartputc>
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
80100c9f:	e8 cc 6d 00 00       	call   80107a70 <uartputc>
  cgaputc(c);
80100ca4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca7:	e8 c4 f8 ff ff       	call   80100570 <cgaputc>
}
80100cac:	83 c4 10             	add    $0x10,%esp
80100caf:	e9 37 fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    release(&cons.lock);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
80100cb7:	68 c0 15 11 80       	push   $0x801115c0
80100cbc:	e8 8f 50 00 00       	call   80105d50 <release>
80100cc1:	83 c4 10             	add    $0x10,%esp
}
80100cc4:	e9 38 fe ff ff       	jmp    80100b01 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100cc9:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100ccc:	e9 1a fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    panic("null fmt");
80100cd1:	83 ec 0c             	sub    $0xc,%esp
80100cd4:	68 bf 8f 10 80       	push   $0x80108fbf
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
80100d08:	e8 63 6d 00 00       	call   80107a70 <uartputc>
80100d0d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d14:	e8 57 6d 00 00       	call   80107a70 <uartputc>
80100d19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d20:	e8 4b 6d 00 00       	call   80107a70 <uartputc>
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
80100d5a:	e8 51 50 00 00       	call   80105db0 <acquire>
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
80100dab:	ff 24 85 d8 8f 10 80 	jmp    *-0x7fef7028(,%eax,4)
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
80100e68:	e8 e3 4e 00 00       	call   80105d50 <release>
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
80100f44:	e8 27 6b 00 00       	call   80107a70 <uartputc>
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
80100f9f:	0f b6 8a c8 8f 10 80 	movzbl -0x7fef7038(%edx),%ecx
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
8010100b:	e8 80 43 00 00       	call   80105390 <wakeup>
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
801011e2:	e8 89 68 00 00       	call   80107a70 <uartputc>
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
801012f3:	e8 78 67 00 00       	call   80107a70 <uartputc>
801012f8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801012ff:	e8 6c 67 00 00       	call   80107a70 <uartputc>
80101304:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010130b:	e8 60 67 00 00       	call   80107a70 <uartputc>
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
80101347:	e9 24 41 00 00       	jmp    80105470 <procdump>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	6a 08                	push   $0x8
80101351:	e8 1a 67 00 00       	call   80107a70 <uartputc>
80101356:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010135d:	e8 0e 67 00 00       	call   80107a70 <uartputc>
80101362:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101369:	e8 02 67 00 00       	call   80107a70 <uartputc>
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
801013a5:	e8 c6 66 00 00       	call   80107a70 <uartputc>
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
801013fa:	e8 71 66 00 00       	call   80107a70 <uartputc>
801013ff:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101406:	e8 65 66 00 00       	call   80107a70 <uartputc>
8010140b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101412:	e8 59 66 00 00       	call   80107a70 <uartputc>
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
80101455:	e8 16 66 00 00       	call   80107a70 <uartputc>
8010145a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101461:	e8 0a 66 00 00       	call   80107a70 <uartputc>
80101466:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010146d:	e8 fe 65 00 00       	call   80107a70 <uartputc>
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
801014ab:	e8 a0 48 00 00       	call   80105d50 <release>
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
801014ef:	e8 bc 48 00 00       	call   80105db0 <acquire>
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
80101585:	e8 e6 64 00 00       	call   80107a70 <uartputc>
8010158a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101591:	e8 da 64 00 00       	call   80107a70 <uartputc>
80101596:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010159d:	e8 ce 64 00 00       	call   80107a70 <uartputc>
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
801015f6:	e8 55 47 00 00       	call   80105d50 <release>
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
80101662:	e8 49 47 00 00       	call   80105db0 <acquire>
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
801016c8:	d8 0d 2c 90 10 80    	fmuls  0x8010902c
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
80101786:	68 d0 8f 10 80       	push   $0x80108fd0
8010178b:	68 c0 15 11 80       	push   $0x801115c0
80101790:	e8 4b 44 00 00       	call   80105be0 <initlock>

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
801017b9:	e8 02 1a 00 00       	call   801031c0 <ioapicenable>
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
801017dc:	e8 4f 2f 00 00       	call   80104730 <myproc>
801017e1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801017e7:	e8 b4 22 00 00       	call   80103aa0 <begin_op>

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
8010182f:	e8 dc 22 00 00       	call   80103b10 <end_op>
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
80101854:	e8 a7 73 00 00       	call   80108c00 <setupkvm>
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
801018c3:	e8 58 71 00 00       	call   80108a20 <allocuvm>
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
801018f9:	e8 32 70 00 00       	call   80108930 <loaduvm>
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
8010193b:	e8 40 72 00 00       	call   80108b80 <freevm>
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
80101971:	e8 9a 21 00 00       	call   80103b10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101976:	83 c4 0c             	add    $0xc,%esp
80101979:	56                   	push   %esi
8010197a:	57                   	push   %edi
8010197b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101981:	57                   	push   %edi
80101982:	e8 99 70 00 00       	call   80108a20 <allocuvm>
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
801019a3:	e8 f8 72 00 00       	call   80108ca0 <clearpteu>
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
801019f3:	e8 78 46 00 00       	call   80106070 <strlen>
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
80101a07:	e8 64 46 00 00       	call   80106070 <strlen>
80101a0c:	83 c0 01             	add    $0x1,%eax
80101a0f:	50                   	push   %eax
80101a10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a13:	ff 34 b8             	push   (%eax,%edi,4)
80101a16:	53                   	push   %ebx
80101a17:	56                   	push   %esi
80101a18:	e8 53 74 00 00       	call   80108e70 <copyout>
80101a1d:	83 c4 20             	add    $0x20,%esp
80101a20:	85 c0                	test   %eax,%eax
80101a22:	79 ac                	jns    801019d0 <exec+0x200>
80101a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a31:	e8 4a 71 00 00       	call   80108b80 <freevm>
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
80101a83:	e8 e8 73 00 00       	call   80108e70 <copyout>
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
80101ac3:	e8 68 45 00 00       	call   80106030 <safestrcpy>
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
80101af6:	e8 a5 6c 00 00       	call   801087a0 <switchuvm>
  freevm(oldpgdir);
80101afb:	89 3c 24             	mov    %edi,(%esp)
80101afe:	e8 7d 70 00 00       	call   80108b80 <freevm>
  return 0;
80101b03:	83 c4 10             	add    $0x10,%esp
80101b06:	31 c0                	xor    %eax,%eax
80101b08:	e9 2f fd ff ff       	jmp    8010183c <exec+0x6c>
    end_op();
80101b0d:	e8 fe 1f 00 00       	call   80103b10 <end_op>
    cprintf("exec: fail\n");
80101b12:	83 ec 0c             	sub    $0xc,%esp
80101b15:	68 30 90 10 80       	push   $0x80109030
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
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101b46:	68 3c 90 10 80       	push   $0x8010903c
80101b4b:	68 00 16 11 80       	push   $0x80111600
80101b50:	e8 8b 40 00 00       	call   80105be0 <initlock>
}
80101b55:	83 c4 10             	add    $0x10,%esp
80101b58:	c9                   	leave  
80101b59:	c3                   	ret    
80101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b64:	bb 34 16 11 80       	mov    $0x80111634,%ebx
{
80101b69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101b6c:	68 00 16 11 80       	push   $0x80111600
80101b71:	e8 3a 42 00 00       	call   80105db0 <acquire>
80101b76:	83 c4 10             	add    $0x10,%esp
80101b79:	eb 10                	jmp    80101b8b <filealloc+0x2b>
80101b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b7f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b80:	83 c3 18             	add    $0x18,%ebx
80101b83:	81 fb 94 1f 11 80    	cmp    $0x80111f94,%ebx
80101b89:	74 25                	je     80101bb0 <filealloc+0x50>
    if(f->ref == 0){
80101b8b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b8e:	85 c0                	test   %eax,%eax
80101b90:	75 ee                	jne    80101b80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101b92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101b95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101b9c:	68 00 16 11 80       	push   $0x80111600
80101ba1:	e8 aa 41 00 00       	call   80105d50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101ba6:	89 d8                	mov    %ebx,%eax
      return f;
80101ba8:	83 c4 10             	add    $0x10,%esp
}
80101bab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bae:	c9                   	leave  
80101baf:	c3                   	ret    
  release(&ftable.lock);
80101bb0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101bb3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101bb5:	68 00 16 11 80       	push   $0x80111600
80101bba:	e8 91 41 00 00       	call   80105d50 <release>
}
80101bbf:	89 d8                	mov    %ebx,%eax
  return 0;
80101bc1:	83 c4 10             	add    $0x10,%esp
}
80101bc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bc7:	c9                   	leave  
80101bc8:	c3                   	ret    
80101bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	53                   	push   %ebx
80101bd4:	83 ec 10             	sub    $0x10,%esp
80101bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101bda:	68 00 16 11 80       	push   $0x80111600
80101bdf:	e8 cc 41 00 00       	call   80105db0 <acquire>
  if(f->ref < 1)
80101be4:	8b 43 04             	mov    0x4(%ebx),%eax
80101be7:	83 c4 10             	add    $0x10,%esp
80101bea:	85 c0                	test   %eax,%eax
80101bec:	7e 1a                	jle    80101c08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101bee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101bf1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101bf4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101bf7:	68 00 16 11 80       	push   $0x80111600
80101bfc:	e8 4f 41 00 00       	call   80105d50 <release>
  return f;
}
80101c01:	89 d8                	mov    %ebx,%eax
80101c03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c06:	c9                   	leave  
80101c07:	c3                   	ret    
    panic("filedup");
80101c08:	83 ec 0c             	sub    $0xc,%esp
80101c0b:	68 43 90 10 80       	push   $0x80109043
80101c10:	e8 db e8 ff ff       	call   801004f0 <panic>
80101c15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c20 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	83 ec 28             	sub    $0x28,%esp
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101c2c:	68 00 16 11 80       	push   $0x80111600
80101c31:	e8 7a 41 00 00       	call   80105db0 <acquire>
  if(f->ref < 1)
80101c36:	8b 53 04             	mov    0x4(%ebx),%edx
80101c39:	83 c4 10             	add    $0x10,%esp
80101c3c:	85 d2                	test   %edx,%edx
80101c3e:	0f 8e a5 00 00 00    	jle    80101ce9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101c44:	83 ea 01             	sub    $0x1,%edx
80101c47:	89 53 04             	mov    %edx,0x4(%ebx)
80101c4a:	75 44                	jne    80101c90 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c4c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c50:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101c53:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101c55:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101c5b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101c5e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c61:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101c64:	68 00 16 11 80       	push   $0x80111600
  ff = *f;
80101c69:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101c6c:	e8 df 40 00 00       	call   80105d50 <release>

  if(ff.type == FD_PIPE)
80101c71:	83 c4 10             	add    $0x10,%esp
80101c74:	83 ff 01             	cmp    $0x1,%edi
80101c77:	74 57                	je     80101cd0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101c79:	83 ff 02             	cmp    $0x2,%edi
80101c7c:	74 2a                	je     80101ca8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c81:	5b                   	pop    %ebx
80101c82:	5e                   	pop    %esi
80101c83:	5f                   	pop    %edi
80101c84:	5d                   	pop    %ebp
80101c85:	c3                   	ret    
80101c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c8d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101c90:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80101c97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9a:	5b                   	pop    %ebx
80101c9b:	5e                   	pop    %esi
80101c9c:	5f                   	pop    %edi
80101c9d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101c9e:	e9 ad 40 00 00       	jmp    80105d50 <release>
80101ca3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ca7:	90                   	nop
    begin_op();
80101ca8:	e8 f3 1d 00 00       	call   80103aa0 <begin_op>
    iput(ff.ip);
80101cad:	83 ec 0c             	sub    $0xc,%esp
80101cb0:	ff 75 e0             	push   -0x20(%ebp)
80101cb3:	e8 28 09 00 00       	call   801025e0 <iput>
    end_op();
80101cb8:	83 c4 10             	add    $0x10,%esp
}
80101cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cbe:	5b                   	pop    %ebx
80101cbf:	5e                   	pop    %esi
80101cc0:	5f                   	pop    %edi
80101cc1:	5d                   	pop    %ebp
    end_op();
80101cc2:	e9 49 1e 00 00       	jmp    80103b10 <end_op>
80101cc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cce:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101cd0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101cd4:	83 ec 08             	sub    $0x8,%esp
80101cd7:	53                   	push   %ebx
80101cd8:	56                   	push   %esi
80101cd9:	e8 92 25 00 00       	call   80104270 <pipeclose>
80101cde:	83 c4 10             	add    $0x10,%esp
}
80101ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce4:	5b                   	pop    %ebx
80101ce5:	5e                   	pop    %esi
80101ce6:	5f                   	pop    %edi
80101ce7:	5d                   	pop    %ebp
80101ce8:	c3                   	ret    
    panic("fileclose");
80101ce9:	83 ec 0c             	sub    $0xc,%esp
80101cec:	68 4b 90 10 80       	push   $0x8010904b
80101cf1:	e8 fa e7 ff ff       	call   801004f0 <panic>
80101cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cfd:	8d 76 00             	lea    0x0(%esi),%esi

80101d00 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	53                   	push   %ebx
80101d04:	83 ec 04             	sub    $0x4,%esp
80101d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101d0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101d0d:	75 31                	jne    80101d40 <filestat+0x40>
    ilock(f->ip);
80101d0f:	83 ec 0c             	sub    $0xc,%esp
80101d12:	ff 73 10             	push   0x10(%ebx)
80101d15:	e8 96 07 00 00       	call   801024b0 <ilock>
    stati(f->ip, st);
80101d1a:	58                   	pop    %eax
80101d1b:	5a                   	pop    %edx
80101d1c:	ff 75 0c             	push   0xc(%ebp)
80101d1f:	ff 73 10             	push   0x10(%ebx)
80101d22:	e8 69 0a 00 00       	call   80102790 <stati>
    iunlock(f->ip);
80101d27:	59                   	pop    %ecx
80101d28:	ff 73 10             	push   0x10(%ebx)
80101d2b:	e8 60 08 00 00       	call   80102590 <iunlock>
    return 0;
  }
  return -1;
}
80101d30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101d33:	83 c4 10             	add    $0x10,%esp
80101d36:	31 c0                	xor    %eax,%eax
}
80101d38:	c9                   	leave  
80101d39:	c3                   	ret    
80101d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101d48:	c9                   	leave  
80101d49:	c3                   	ret    
80101d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	56                   	push   %esi
80101d55:	53                   	push   %ebx
80101d56:	83 ec 0c             	sub    $0xc,%esp
80101d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101d62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d66:	74 60                	je     80101dc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101d68:	8b 03                	mov    (%ebx),%eax
80101d6a:	83 f8 01             	cmp    $0x1,%eax
80101d6d:	74 41                	je     80101db0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101d6f:	83 f8 02             	cmp    $0x2,%eax
80101d72:	75 5b                	jne    80101dcf <fileread+0x7f>
    ilock(f->ip);
80101d74:	83 ec 0c             	sub    $0xc,%esp
80101d77:	ff 73 10             	push   0x10(%ebx)
80101d7a:	e8 31 07 00 00       	call   801024b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d7f:	57                   	push   %edi
80101d80:	ff 73 14             	push   0x14(%ebx)
80101d83:	56                   	push   %esi
80101d84:	ff 73 10             	push   0x10(%ebx)
80101d87:	e8 34 0a 00 00       	call   801027c0 <readi>
80101d8c:	83 c4 20             	add    $0x20,%esp
80101d8f:	89 c6                	mov    %eax,%esi
80101d91:	85 c0                	test   %eax,%eax
80101d93:	7e 03                	jle    80101d98 <fileread+0x48>
      f->off += r;
80101d95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101d98:	83 ec 0c             	sub    $0xc,%esp
80101d9b:	ff 73 10             	push   0x10(%ebx)
80101d9e:	e8 ed 07 00 00       	call   80102590 <iunlock>
    return r;
80101da3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da9:	89 f0                	mov    %esi,%eax
80101dab:	5b                   	pop    %ebx
80101dac:	5e                   	pop    %esi
80101dad:	5f                   	pop    %edi
80101dae:	5d                   	pop    %ebp
80101daf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101db0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101db3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db9:	5b                   	pop    %ebx
80101dba:	5e                   	pop    %esi
80101dbb:	5f                   	pop    %edi
80101dbc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101dbd:	e9 4e 26 00 00       	jmp    80104410 <piperead>
80101dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101dc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dcd:	eb d7                	jmp    80101da6 <fileread+0x56>
  panic("fileread");
80101dcf:	83 ec 0c             	sub    $0xc,%esp
80101dd2:	68 55 90 10 80       	push   $0x80109055
80101dd7:	e8 14 e7 ff ff       	call   801004f0 <panic>
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101de0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->writable == 0)
80101df5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101df9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101dfc:	0f 84 bd 00 00 00    	je     80101ebf <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101e02:	8b 03                	mov    (%ebx),%eax
80101e04:	83 f8 01             	cmp    $0x1,%eax
80101e07:	0f 84 bf 00 00 00    	je     80101ecc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101e0d:	83 f8 02             	cmp    $0x2,%eax
80101e10:	0f 85 c8 00 00 00    	jne    80101ede <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101e16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101e19:	31 f6                	xor    %esi,%esi
    while(i < n){
80101e1b:	85 c0                	test   %eax,%eax
80101e1d:	7f 30                	jg     80101e4f <filewrite+0x6f>
80101e1f:	e9 94 00 00 00       	jmp    80101eb8 <filewrite+0xd8>
80101e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101e28:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101e2b:	83 ec 0c             	sub    $0xc,%esp
80101e2e:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101e31:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101e34:	e8 57 07 00 00       	call   80102590 <iunlock>
      end_op();
80101e39:	e8 d2 1c 00 00       	call   80103b10 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e41:	83 c4 10             	add    $0x10,%esp
80101e44:	39 c7                	cmp    %eax,%edi
80101e46:	75 5c                	jne    80101ea4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101e48:	01 fe                	add    %edi,%esi
    while(i < n){
80101e4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101e4d:	7e 69                	jle    80101eb8 <filewrite+0xd8>
      int n1 = n - i;
80101e4f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e52:	b8 00 06 00 00       	mov    $0x600,%eax
80101e57:	29 f7                	sub    %esi,%edi
80101e59:	39 c7                	cmp    %eax,%edi
80101e5b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101e5e:	e8 3d 1c 00 00       	call   80103aa0 <begin_op>
      ilock(f->ip);
80101e63:	83 ec 0c             	sub    $0xc,%esp
80101e66:	ff 73 10             	push   0x10(%ebx)
80101e69:	e8 42 06 00 00       	call   801024b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101e6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e71:	57                   	push   %edi
80101e72:	ff 73 14             	push   0x14(%ebx)
80101e75:	01 f0                	add    %esi,%eax
80101e77:	50                   	push   %eax
80101e78:	ff 73 10             	push   0x10(%ebx)
80101e7b:	e8 40 0a 00 00       	call   801028c0 <writei>
80101e80:	83 c4 20             	add    $0x20,%esp
80101e83:	85 c0                	test   %eax,%eax
80101e85:	7f a1                	jg     80101e28 <filewrite+0x48>
      iunlock(f->ip);
80101e87:	83 ec 0c             	sub    $0xc,%esp
80101e8a:	ff 73 10             	push   0x10(%ebx)
80101e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e90:	e8 fb 06 00 00       	call   80102590 <iunlock>
      end_op();
80101e95:	e8 76 1c 00 00       	call   80103b10 <end_op>
      if(r < 0)
80101e9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e9d:	83 c4 10             	add    $0x10,%esp
80101ea0:	85 c0                	test   %eax,%eax
80101ea2:	75 1b                	jne    80101ebf <filewrite+0xdf>
        panic("short filewrite");
80101ea4:	83 ec 0c             	sub    $0xc,%esp
80101ea7:	68 5e 90 10 80       	push   $0x8010905e
80101eac:	e8 3f e6 ff ff       	call   801004f0 <panic>
80101eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101eb8:	89 f0                	mov    %esi,%eax
80101eba:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80101ebd:	74 05                	je     80101ec4 <filewrite+0xe4>
80101ebf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec7:	5b                   	pop    %ebx
80101ec8:	5e                   	pop    %esi
80101ec9:	5f                   	pop    %edi
80101eca:	5d                   	pop    %ebp
80101ecb:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101ecc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ecf:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed5:	5b                   	pop    %ebx
80101ed6:	5e                   	pop    %esi
80101ed7:	5f                   	pop    %edi
80101ed8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101ed9:	e9 32 24 00 00       	jmp    80104310 <pipewrite>
  panic("filewrite");
80101ede:	83 ec 0c             	sub    $0xc,%esp
80101ee1:	68 64 90 10 80       	push   $0x80109064
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
80101f3d:	e8 3e 1d 00 00       	call   80103c80 <log_write>
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
80101f57:	68 6e 90 10 80       	push   $0x8010906e
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
80102014:	68 81 90 10 80       	push   $0x80109081
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
8010202d:	e8 4e 1c 00 00       	call   80103c80 <log_write>
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
80102055:	e8 16 3e 00 00       	call   80105e70 <memset>
  log_write(bp);
8010205a:	89 1c 24             	mov    %ebx,(%esp)
8010205d:	e8 1e 1c 00 00       	call   80103c80 <log_write>
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
8010209a:	e8 11 3d 00 00       	call   80105db0 <acquire>
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
80102107:	e8 44 3c 00 00       	call   80105d50 <release>

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
80102135:	e8 16 3c 00 00       	call   80105d50 <release>
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
80102168:	68 97 90 10 80       	push   $0x80109097
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
801021f5:	e8 86 1a 00 00       	call   80103c80 <log_write>
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
80102245:	68 a7 90 10 80       	push   $0x801090a7
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
80102271:	e8 9a 3c 00 00       	call   80105f10 <memmove>
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
8010229c:	68 ba 90 10 80       	push   $0x801090ba
801022a1:	68 00 20 11 80       	push   $0x80112000
801022a6:	e8 35 39 00 00       	call   80105be0 <initlock>
  for(i = 0; i < NINODE; i++) {
801022ab:	83 c4 10             	add    $0x10,%esp
801022ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801022b0:	83 ec 08             	sub    $0x8,%esp
801022b3:	68 c1 90 10 80       	push   $0x801090c1
801022b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801022b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801022bf:	e8 ec 37 00 00       	call   80105ab0 <initsleeplock>
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
801022ec:	e8 1f 3c 00 00       	call   80105f10 <memmove>
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
80102323:	68 24 91 10 80       	push   $0x80109124
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
801023be:	e8 ad 3a 00 00       	call   80105e70 <memset>
      dip->type = type;
801023c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801023c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801023ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801023cd:	89 1c 24             	mov    %ebx,(%esp)
801023d0:	e8 ab 18 00 00       	call   80103c80 <log_write>
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
801023f3:	68 c7 90 10 80       	push   $0x801090c7
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
80102461:	e8 aa 3a 00 00       	call   80105f10 <memmove>
  log_write(bp);
80102466:	89 34 24             	mov    %esi,(%esp)
80102469:	e8 12 18 00 00       	call   80103c80 <log_write>
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
8010248f:	e8 1c 39 00 00       	call   80105db0 <acquire>
  ip->ref++;
80102494:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102498:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
8010249f:	e8 ac 38 00 00       	call   80105d50 <release>
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
801024d2:	e8 19 36 00 00       	call   80105af0 <acquiresleep>
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
80102548:	e8 c3 39 00 00       	call   80105f10 <memmove>
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
8010256d:	68 df 90 10 80       	push   $0x801090df
80102572:	e8 79 df ff ff       	call   801004f0 <panic>
    panic("ilock");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 d9 90 10 80       	push   $0x801090d9
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
801025a3:	e8 e8 35 00 00       	call   80105b90 <holdingsleep>
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
801025bf:	e9 8c 35 00 00       	jmp    80105b50 <releasesleep>
    panic("iunlock");
801025c4:	83 ec 0c             	sub    $0xc,%esp
801025c7:	68 ee 90 10 80       	push   $0x801090ee
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
801025f0:	e8 fb 34 00 00       	call   80105af0 <acquiresleep>
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
8010260a:	e8 41 35 00 00       	call   80105b50 <releasesleep>
  acquire(&icache.lock);
8010260f:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
80102616:	e8 95 37 00 00       	call   80105db0 <acquire>
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
80102630:	e9 1b 37 00 00       	jmp    80105d50 <release>
80102635:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102638:	83 ec 0c             	sub    $0xc,%esp
8010263b:	68 00 20 11 80       	push   $0x80112000
80102640:	e8 6b 37 00 00       	call   80105db0 <acquire>
    int r = ip->ref;
80102645:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102648:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
8010264f:	e8 fc 36 00 00       	call   80105d50 <release>
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
80102753:	e8 38 34 00 00       	call   80105b90 <holdingsleep>
80102758:	83 c4 10             	add    $0x10,%esp
8010275b:	85 c0                	test   %eax,%eax
8010275d:	74 21                	je     80102780 <iunlockput+0x40>
8010275f:	8b 43 08             	mov    0x8(%ebx),%eax
80102762:	85 c0                	test   %eax,%eax
80102764:	7e 1a                	jle    80102780 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102766:	83 ec 0c             	sub    $0xc,%esp
80102769:	56                   	push   %esi
8010276a:	e8 e1 33 00 00       	call   80105b50 <releasesleep>
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
80102783:	68 ee 90 10 80       	push   $0x801090ee
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
80102867:	e8 a4 36 00 00       	call   80105f10 <memmove>
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
80102963:	e8 a8 35 00 00       	call   80105f10 <memmove>
    log_write(bp);
80102968:	89 3c 24             	mov    %edi,(%esp)
8010296b:	e8 10 13 00 00       	call   80103c80 <log_write>
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
801029fe:	e8 7d 35 00 00       	call   80105f80 <strncmp>
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
80102a5d:	e8 1e 35 00 00       	call   80105f80 <strncmp>
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
80102aa2:	68 08 91 10 80       	push   $0x80109108
80102aa7:	e8 44 da ff ff       	call   801004f0 <panic>
    panic("dirlookup not DIR");
80102aac:	83 ec 0c             	sub    $0xc,%esp
80102aaf:	68 f6 90 10 80       	push   $0x801090f6
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
80102ada:	e8 51 1c 00 00       	call   80104730 <myproc>
  acquire(&icache.lock);
80102adf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102ae2:	8b b0 d4 00 00 00    	mov    0xd4(%eax),%esi
  acquire(&icache.lock);
80102ae8:	68 00 20 11 80       	push   $0x80112000
80102aed:	e8 be 32 00 00       	call   80105db0 <acquire>
  ip->ref++;
80102af2:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102af6:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
80102afd:	e8 4e 32 00 00       	call   80105d50 <release>
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
80102b67:	e8 a4 33 00 00       	call   80105f10 <memmove>
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
80102bcc:	e8 bf 2f 00 00       	call   80105b90 <holdingsleep>
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
80102bee:	e8 5d 2f 00 00       	call   80105b50 <releasesleep>
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
80102c1b:	e8 f0 32 00 00       	call   80105f10 <memmove>
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
80102c6b:	e8 20 2f 00 00       	call   80105b90 <holdingsleep>
80102c70:	83 c4 10             	add    $0x10,%esp
80102c73:	85 c0                	test   %eax,%eax
80102c75:	0f 84 91 00 00 00    	je     80102d0c <namex+0x24c>
80102c7b:	8b 46 08             	mov    0x8(%esi),%eax
80102c7e:	85 c0                	test   %eax,%eax
80102c80:	0f 8e 86 00 00 00    	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102c86:	83 ec 0c             	sub    $0xc,%esp
80102c89:	53                   	push   %ebx
80102c8a:	e8 c1 2e 00 00       	call   80105b50 <releasesleep>
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
80102cad:	e8 de 2e 00 00       	call   80105b90 <holdingsleep>
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
80102cd0:	e8 bb 2e 00 00       	call   80105b90 <holdingsleep>
80102cd5:	83 c4 10             	add    $0x10,%esp
80102cd8:	85 c0                	test   %eax,%eax
80102cda:	74 30                	je     80102d0c <namex+0x24c>
80102cdc:	8b 7e 08             	mov    0x8(%esi),%edi
80102cdf:	85 ff                	test   %edi,%edi
80102ce1:	7e 29                	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102ce3:	83 ec 0c             	sub    $0xc,%esp
80102ce6:	53                   	push   %ebx
80102ce7:	e8 64 2e 00 00       	call   80105b50 <releasesleep>
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
80102d0f:	68 ee 90 10 80       	push   $0x801090ee
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
80102d7d:	e8 4e 32 00 00       	call   80105fd0 <strncpy>
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
80102dbb:	68 17 91 10 80       	push   $0x80109117
80102dc0:	e8 2b d7 ff ff       	call   801004f0 <panic>
    panic("dirlink");
80102dc5:	83 ec 0c             	sub    $0xc,%esp
80102dc8:	68 7e 98 10 80       	push   $0x8010987e
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
80102edb:	68 80 91 10 80       	push   $0x80109180
80102ee0:	e8 0b d6 ff ff       	call   801004f0 <panic>
    panic("idestart");
80102ee5:	83 ec 0c             	sub    $0xc,%esp
80102ee8:	68 77 91 10 80       	push   $0x80109177
80102eed:	e8 fe d5 ff ff       	call   801004f0 <panic>
80102ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f00 <ideinit>:
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102f06:	68 92 91 10 80       	push   $0x80109192
80102f0b:	68 a0 3c 11 80       	push   $0x80113ca0
80102f10:	e8 cb 2c 00 00       	call   80105be0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102f15:	58                   	pop    %eax
80102f16:	a1 24 3e 11 80       	mov    0x80113e24,%eax
80102f1b:	5a                   	pop    %edx
80102f1c:	83 e8 01             	sub    $0x1,%eax
80102f1f:	50                   	push   %eax
80102f20:	6a 0e                	push   $0xe
80102f22:	e8 99 02 00 00       	call   801031c0 <ioapicenable>
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
80102f8e:	e8 1d 2e 00 00       	call   80105db0 <acquire>

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
80102fed:	e8 9e 23 00 00       	call   80105390 <wakeup>

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
8010300b:	e8 40 2d 00 00       	call   80105d50 <release>

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
8010302e:	e8 5d 2b 00 00       	call   80105b90 <holdingsleep>
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
80103068:	e8 43 2d 00 00       	call   80105db0 <acquire>

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
801030a9:	e8 12 22 00 00       	call   801052c0 <sleep>
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
801030c6:	e9 85 2c 00 00       	jmp    80105d50 <release>
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
801030ea:	68 c1 91 10 80       	push   $0x801091c1
801030ef:	e8 fc d3 ff ff       	call   801004f0 <panic>
    panic("iderw: nothing to do");
801030f4:	83 ec 0c             	sub    $0xc,%esp
801030f7:	68 ac 91 10 80       	push   $0x801091ac
801030fc:	e8 ef d3 ff ff       	call   801004f0 <panic>
    panic("iderw: buf not locked");
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	68 96 91 10 80       	push   $0x80109196
80103109:	e8 e2 d3 ff ff       	call   801004f0 <panic>
8010310e:	66 90                	xchg   %ax,%ax

80103110 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103110:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80103111:	c7 05 d4 3c 11 80 00 	movl   $0xfec00000,0x80113cd4
80103118:	00 c0 fe 
{
8010311b:	89 e5                	mov    %esp,%ebp
8010311d:	56                   	push   %esi
8010311e:	53                   	push   %ebx
  ioapic->reg = reg;
8010311f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103126:	00 00 00 
  return ioapic->data;
80103129:	8b 15 d4 3c 11 80    	mov    0x80113cd4,%edx
8010312f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80103132:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80103138:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010313e:	0f b6 15 20 3e 11 80 	movzbl 0x80113e20,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103145:	c1 ee 10             	shr    $0x10,%esi
80103148:	89 f0                	mov    %esi,%eax
8010314a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010314d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80103150:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103153:	39 c2                	cmp    %eax,%edx
80103155:	74 16                	je     8010316d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103157:	83 ec 0c             	sub    $0xc,%esp
8010315a:	68 e0 91 10 80       	push   $0x801091e0
8010315f:	e8 0c d9 ff ff       	call   80100a70 <cprintf>
  ioapic->reg = reg;
80103164:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
8010316a:	83 c4 10             	add    $0x10,%esp
8010316d:	83 c6 21             	add    $0x21,%esi
{
80103170:	ba 10 00 00 00       	mov    $0x10,%edx
80103175:	b8 20 00 00 00       	mov    $0x20,%eax
8010317a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80103180:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103182:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80103184:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
  for(i = 0; i <= maxintr; i++){
8010318a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010318d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80103193:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80103196:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80103199:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010319c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010319e:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
801031a4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801031ab:	39 f0                	cmp    %esi,%eax
801031ad:	75 d1                	jne    80103180 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801031af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031b2:	5b                   	pop    %ebx
801031b3:	5e                   	pop    %esi
801031b4:	5d                   	pop    %ebp
801031b5:	c3                   	ret    
801031b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bd:	8d 76 00             	lea    0x0(%esi),%esi

801031c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801031c0:	55                   	push   %ebp
  ioapic->reg = reg;
801031c1:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
{
801031c7:	89 e5                	mov    %esp,%ebp
801031c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801031cc:	8d 50 20             	lea    0x20(%eax),%edx
801031cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801031d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801031d5:	8b 0d d4 3c 11 80    	mov    0x80113cd4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801031de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801031e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801031e6:	a1 d4 3c 11 80       	mov    0x80113cd4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031eb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801031ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801031f1:	5d                   	pop    %ebp
801031f2:	c3                   	ret    
801031f3:	66 90                	xchg   %ax,%ax
801031f5:	66 90                	xchg   %ax,%ax
801031f7:	66 90                	xchg   %ax,%ax
801031f9:	66 90                	xchg   %ax,%ax
801031fb:	66 90                	xchg   %ax,%ax
801031fd:	66 90                	xchg   %ax,%ax
801031ff:	90                   	nop

80103200 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	53                   	push   %ebx
80103204:	83 ec 04             	sub    $0x4,%esp
80103207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010320a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103210:	75 76                	jne    80103288 <kfree+0x88>
80103212:	81 fb 70 9f 11 80    	cmp    $0x80119f70,%ebx
80103218:	72 6e                	jb     80103288 <kfree+0x88>
8010321a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103220:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103225:	77 61                	ja     80103288 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103227:	83 ec 04             	sub    $0x4,%esp
8010322a:	68 00 10 00 00       	push   $0x1000
8010322f:	6a 01                	push   $0x1
80103231:	53                   	push   %ebx
80103232:	e8 39 2c 00 00       	call   80105e70 <memset>

  if(kmem.use_lock)
80103237:	8b 15 14 3d 11 80    	mov    0x80113d14,%edx
8010323d:	83 c4 10             	add    $0x10,%esp
80103240:	85 d2                	test   %edx,%edx
80103242:	75 1c                	jne    80103260 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103244:	a1 18 3d 11 80       	mov    0x80113d18,%eax
80103249:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010324b:	a1 14 3d 11 80       	mov    0x80113d14,%eax
  kmem.freelist = r;
80103250:	89 1d 18 3d 11 80    	mov    %ebx,0x80113d18
  if(kmem.use_lock)
80103256:	85 c0                	test   %eax,%eax
80103258:	75 1e                	jne    80103278 <kfree+0x78>
    release(&kmem.lock);
}
8010325a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010325d:	c9                   	leave  
8010325e:	c3                   	ret    
8010325f:	90                   	nop
    acquire(&kmem.lock);
80103260:	83 ec 0c             	sub    $0xc,%esp
80103263:	68 e0 3c 11 80       	push   $0x80113ce0
80103268:	e8 43 2b 00 00       	call   80105db0 <acquire>
8010326d:	83 c4 10             	add    $0x10,%esp
80103270:	eb d2                	jmp    80103244 <kfree+0x44>
80103272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103278:	c7 45 08 e0 3c 11 80 	movl   $0x80113ce0,0x8(%ebp)
}
8010327f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103282:	c9                   	leave  
    release(&kmem.lock);
80103283:	e9 c8 2a 00 00       	jmp    80105d50 <release>
    panic("kfree");
80103288:	83 ec 0c             	sub    $0xc,%esp
8010328b:	68 12 92 10 80       	push   $0x80109212
80103290:	e8 5b d2 ff ff       	call   801004f0 <panic>
80103295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032a0 <freerange>:
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801032a4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801032a7:	8b 75 0c             	mov    0xc(%ebp),%esi
801032aa:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801032ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801032b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801032bd:	39 de                	cmp    %ebx,%esi
801032bf:	72 23                	jb     801032e4 <freerange+0x44>
801032c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801032d7:	50                   	push   %eax
801032d8:	e8 23 ff ff ff       	call   80103200 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032dd:	83 c4 10             	add    $0x10,%esp
801032e0:	39 f3                	cmp    %esi,%ebx
801032e2:	76 e4                	jbe    801032c8 <freerange+0x28>
}
801032e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032e7:	5b                   	pop    %ebx
801032e8:	5e                   	pop    %esi
801032e9:	5d                   	pop    %ebp
801032ea:	c3                   	ret    
801032eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032ef:	90                   	nop

801032f0 <kinit2>:
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801032f4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801032f7:	8b 75 0c             	mov    0xc(%ebp),%esi
801032fa:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801032fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103301:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103307:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010330d:	39 de                	cmp    %ebx,%esi
8010330f:	72 23                	jb     80103334 <kinit2+0x44>
80103311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103318:	83 ec 0c             	sub    $0xc,%esp
8010331b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103321:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103327:	50                   	push   %eax
80103328:	e8 d3 fe ff ff       	call   80103200 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010332d:	83 c4 10             	add    $0x10,%esp
80103330:	39 de                	cmp    %ebx,%esi
80103332:	73 e4                	jae    80103318 <kinit2+0x28>
  kmem.use_lock = 1;
80103334:	c7 05 14 3d 11 80 01 	movl   $0x1,0x80113d14
8010333b:	00 00 00 
}
8010333e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103341:	5b                   	pop    %ebx
80103342:	5e                   	pop    %esi
80103343:	5d                   	pop    %ebp
80103344:	c3                   	ret    
80103345:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103350 <kinit1>:
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	56                   	push   %esi
80103354:	53                   	push   %ebx
80103355:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103358:	83 ec 08             	sub    $0x8,%esp
8010335b:	68 18 92 10 80       	push   $0x80109218
80103360:	68 e0 3c 11 80       	push   $0x80113ce0
80103365:	e8 76 28 00 00       	call   80105be0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010336a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010336d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103370:	c7 05 14 3d 11 80 00 	movl   $0x0,0x80113d14
80103377:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010337a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103380:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103386:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010338c:	39 de                	cmp    %ebx,%esi
8010338e:	72 1c                	jb     801033ac <kinit1+0x5c>
    kfree(p);
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103399:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010339f:	50                   	push   %eax
801033a0:	e8 5b fe ff ff       	call   80103200 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033a5:	83 c4 10             	add    $0x10,%esp
801033a8:	39 de                	cmp    %ebx,%esi
801033aa:	73 e4                	jae    80103390 <kinit1+0x40>
}
801033ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033af:	5b                   	pop    %ebx
801033b0:	5e                   	pop    %esi
801033b1:	5d                   	pop    %ebp
801033b2:	c3                   	ret    
801033b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033c0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801033c0:	a1 14 3d 11 80       	mov    0x80113d14,%eax
801033c5:	85 c0                	test   %eax,%eax
801033c7:	75 1f                	jne    801033e8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801033c9:	a1 18 3d 11 80       	mov    0x80113d18,%eax
  if(r)
801033ce:	85 c0                	test   %eax,%eax
801033d0:	74 0e                	je     801033e0 <kalloc+0x20>
    kmem.freelist = r->next;
801033d2:	8b 10                	mov    (%eax),%edx
801033d4:	89 15 18 3d 11 80    	mov    %edx,0x80113d18
  if(kmem.use_lock)
801033da:	c3                   	ret    
801033db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033df:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801033e0:	c3                   	ret    
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801033e8:	55                   	push   %ebp
801033e9:	89 e5                	mov    %esp,%ebp
801033eb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801033ee:	68 e0 3c 11 80       	push   $0x80113ce0
801033f3:	e8 b8 29 00 00       	call   80105db0 <acquire>
  r = kmem.freelist;
801033f8:	a1 18 3d 11 80       	mov    0x80113d18,%eax
  if(kmem.use_lock)
801033fd:	8b 15 14 3d 11 80    	mov    0x80113d14,%edx
  if(r)
80103403:	83 c4 10             	add    $0x10,%esp
80103406:	85 c0                	test   %eax,%eax
80103408:	74 08                	je     80103412 <kalloc+0x52>
    kmem.freelist = r->next;
8010340a:	8b 08                	mov    (%eax),%ecx
8010340c:	89 0d 18 3d 11 80    	mov    %ecx,0x80113d18
  if(kmem.use_lock)
80103412:	85 d2                	test   %edx,%edx
80103414:	74 16                	je     8010342c <kalloc+0x6c>
    release(&kmem.lock);
80103416:	83 ec 0c             	sub    $0xc,%esp
80103419:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010341c:	68 e0 3c 11 80       	push   $0x80113ce0
80103421:	e8 2a 29 00 00       	call   80105d50 <release>
  return (char*)r;
80103426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80103429:	83 c4 10             	add    $0x10,%esp
}
8010342c:	c9                   	leave  
8010342d:	c3                   	ret    
8010342e:	66 90                	xchg   %ax,%ax

80103430 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103430:	ba 64 00 00 00       	mov    $0x64,%edx
80103435:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80103436:	a8 01                	test   $0x1,%al
80103438:	0f 84 c2 00 00 00    	je     80103500 <kbdgetc+0xd0>
{
8010343e:	55                   	push   %ebp
8010343f:	ba 60 00 00 00       	mov    $0x60,%edx
80103444:	89 e5                	mov    %esp,%ebp
80103446:	53                   	push   %ebx
80103447:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103448:	8b 1d 1c 3d 11 80    	mov    0x80113d1c,%ebx
  data = inb(KBDATAP);
8010344e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103451:	3c e0                	cmp    $0xe0,%al
80103453:	74 5b                	je     801034b0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103455:	89 da                	mov    %ebx,%edx
80103457:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010345a:	84 c0                	test   %al,%al
8010345c:	78 62                	js     801034c0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010345e:	85 d2                	test   %edx,%edx
80103460:	74 09                	je     8010346b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103462:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103465:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103468:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010346b:	0f b6 91 40 93 10 80 	movzbl -0x7fef6cc0(%ecx),%edx
  shift ^= togglecode[data];
80103472:	0f b6 81 40 92 10 80 	movzbl -0x7fef6dc0(%ecx),%eax
  shift |= shiftcode[data];
80103479:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010347b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010347d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010347f:	89 15 1c 3d 11 80    	mov    %edx,0x80113d1c
  c = charcode[shift & (CTL | SHIFT)][data];
80103485:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103488:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010348b:	8b 04 85 20 92 10 80 	mov    -0x7fef6de0(,%eax,4),%eax
80103492:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103496:	74 0b                	je     801034a3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103498:	8d 50 9f             	lea    -0x61(%eax),%edx
8010349b:	83 fa 19             	cmp    $0x19,%edx
8010349e:	77 48                	ja     801034e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801034a0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801034a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034a6:	c9                   	leave  
801034a7:	c3                   	ret    
801034a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034af:	90                   	nop
    shift |= E0ESC;
801034b0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801034b3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801034b5:	89 1d 1c 3d 11 80    	mov    %ebx,0x80113d1c
}
801034bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034be:	c9                   	leave  
801034bf:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801034c0:	83 e0 7f             	and    $0x7f,%eax
801034c3:	85 d2                	test   %edx,%edx
801034c5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801034c8:	0f b6 81 40 93 10 80 	movzbl -0x7fef6cc0(%ecx),%eax
801034cf:	83 c8 40             	or     $0x40,%eax
801034d2:	0f b6 c0             	movzbl %al,%eax
801034d5:	f7 d0                	not    %eax
801034d7:	21 d8                	and    %ebx,%eax
}
801034d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801034dc:	a3 1c 3d 11 80       	mov    %eax,0x80113d1c
    return 0;
801034e1:	31 c0                	xor    %eax,%eax
}
801034e3:	c9                   	leave  
801034e4:	c3                   	ret    
801034e5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801034e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801034eb:	8d 50 20             	lea    0x20(%eax),%edx
}
801034ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034f1:	c9                   	leave  
      c += 'a' - 'A';
801034f2:	83 f9 1a             	cmp    $0x1a,%ecx
801034f5:	0f 42 c2             	cmovb  %edx,%eax
}
801034f8:	c3                   	ret    
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80103500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103505:	c3                   	ret    
80103506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010350d:	8d 76 00             	lea    0x0(%esi),%esi

80103510 <kbdintr>:

void
kbdintr(void)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103516:	68 30 34 10 80       	push   $0x80103430
8010351b:	e8 20 d8 ff ff       	call   80100d40 <consoleintr>
}
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
}

void
lapicinit(void)
{
  if(!lapic)
80103530:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103535:	85 c0                	test   %eax,%eax
80103537:	0f 84 cb 00 00 00    	je     80103608 <lapicinit+0xd8>
  lapic[index] = value;
8010353d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103544:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103547:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010354a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103551:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103554:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103557:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010355e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103561:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103564:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010356b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010356e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103571:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103578:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010357b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010357e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103585:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103588:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010358b:	8b 50 30             	mov    0x30(%eax),%edx
8010358e:	c1 ea 10             	shr    $0x10,%edx
80103591:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103597:	75 77                	jne    80103610 <lapicinit+0xe0>
  lapic[index] = value;
80103599:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801035a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801035ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801035ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801035c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801035d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801035e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801035e4:	8b 50 20             	mov    0x20(%eax),%edx
801035e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035ee:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801035f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801035f6:	80 e6 10             	and    $0x10,%dh
801035f9:	75 f5                	jne    801035f0 <lapicinit+0xc0>
  lapic[index] = value;
801035fb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103602:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103605:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103608:	c3                   	ret    
80103609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103610:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103617:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010361a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010361d:	e9 77 ff ff ff       	jmp    80103599 <lapicinit+0x69>
80103622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103630 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80103630:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103635:	85 c0                	test   %eax,%eax
80103637:	74 07                	je     80103640 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80103639:	8b 40 20             	mov    0x20(%eax),%eax
8010363c:	c1 e8 18             	shr    $0x18,%eax
8010363f:	c3                   	ret    
    return 0;
80103640:	31 c0                	xor    %eax,%eax
}
80103642:	c3                   	ret    
80103643:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010364a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103650 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103650:	a1 20 3d 11 80       	mov    0x80113d20,%eax
80103655:	85 c0                	test   %eax,%eax
80103657:	74 0d                	je     80103666 <lapiceoi+0x16>
  lapic[index] = value;
80103659:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103660:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103663:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103666:	c3                   	ret    
80103667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010366e:	66 90                	xchg   %ax,%ax

80103670 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103670:	c3                   	ret    
80103671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010367f:	90                   	nop

80103680 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103680:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103681:	b8 0f 00 00 00       	mov    $0xf,%eax
80103686:	ba 70 00 00 00       	mov    $0x70,%edx
8010368b:	89 e5                	mov    %esp,%ebp
8010368d:	53                   	push   %ebx
8010368e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103691:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103694:	ee                   	out    %al,(%dx)
80103695:	b8 0a 00 00 00       	mov    $0xa,%eax
8010369a:	ba 71 00 00 00       	mov    $0x71,%edx
8010369f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801036a0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801036a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801036a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801036ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801036ad:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801036b0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801036b2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801036b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801036b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801036be:	a1 20 3d 11 80       	mov    0x80113d20,%eax
801036c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801036cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801036d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801036d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801036e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801036e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801036ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801036f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103701:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103707:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010370a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010370d:	c9                   	leave  
8010370e:	c3                   	ret    
8010370f:	90                   	nop

80103710 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103710:	55                   	push   %ebp
80103711:	b8 0b 00 00 00       	mov    $0xb,%eax
80103716:	ba 70 00 00 00       	mov    $0x70,%edx
8010371b:	89 e5                	mov    %esp,%ebp
8010371d:	57                   	push   %edi
8010371e:	56                   	push   %esi
8010371f:	53                   	push   %ebx
80103720:	83 ec 4c             	sub    $0x4c,%esp
80103723:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103724:	ba 71 00 00 00       	mov    $0x71,%edx
80103729:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010372a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010372d:	bb 70 00 00 00       	mov    $0x70,%ebx
80103732:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103735:	8d 76 00             	lea    0x0(%esi),%esi
80103738:	31 c0                	xor    %eax,%eax
8010373a:	89 da                	mov    %ebx,%edx
8010373c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010373d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103742:	89 ca                	mov    %ecx,%edx
80103744:	ec                   	in     (%dx),%al
80103745:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103748:	89 da                	mov    %ebx,%edx
8010374a:	b8 02 00 00 00       	mov    $0x2,%eax
8010374f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103750:	89 ca                	mov    %ecx,%edx
80103752:	ec                   	in     (%dx),%al
80103753:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103756:	89 da                	mov    %ebx,%edx
80103758:	b8 04 00 00 00       	mov    $0x4,%eax
8010375d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010375e:	89 ca                	mov    %ecx,%edx
80103760:	ec                   	in     (%dx),%al
80103761:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103764:	89 da                	mov    %ebx,%edx
80103766:	b8 07 00 00 00       	mov    $0x7,%eax
8010376b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010376c:	89 ca                	mov    %ecx,%edx
8010376e:	ec                   	in     (%dx),%al
8010376f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103772:	89 da                	mov    %ebx,%edx
80103774:	b8 08 00 00 00       	mov    $0x8,%eax
80103779:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010377a:	89 ca                	mov    %ecx,%edx
8010377c:	ec                   	in     (%dx),%al
8010377d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010377f:	89 da                	mov    %ebx,%edx
80103781:	b8 09 00 00 00       	mov    $0x9,%eax
80103786:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103787:	89 ca                	mov    %ecx,%edx
80103789:	ec                   	in     (%dx),%al
8010378a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010378c:	89 da                	mov    %ebx,%edx
8010378e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103793:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103794:	89 ca                	mov    %ecx,%edx
80103796:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103797:	84 c0                	test   %al,%al
80103799:	78 9d                	js     80103738 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010379b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010379f:	89 fa                	mov    %edi,%edx
801037a1:	0f b6 fa             	movzbl %dl,%edi
801037a4:	89 f2                	mov    %esi,%edx
801037a6:	89 45 b8             	mov    %eax,-0x48(%ebp)
801037a9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801037ad:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037b0:	89 da                	mov    %ebx,%edx
801037b2:	89 7d c8             	mov    %edi,-0x38(%ebp)
801037b5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801037b8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801037bc:	89 75 cc             	mov    %esi,-0x34(%ebp)
801037bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801037c2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801037c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801037c9:	31 c0                	xor    %eax,%eax
801037cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037cc:	89 ca                	mov    %ecx,%edx
801037ce:	ec                   	in     (%dx),%al
801037cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037d2:	89 da                	mov    %ebx,%edx
801037d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801037d7:	b8 02 00 00 00       	mov    $0x2,%eax
801037dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037dd:	89 ca                	mov    %ecx,%edx
801037df:	ec                   	in     (%dx),%al
801037e0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037e3:	89 da                	mov    %ebx,%edx
801037e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801037e8:	b8 04 00 00 00       	mov    $0x4,%eax
801037ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037ee:	89 ca                	mov    %ecx,%edx
801037f0:	ec                   	in     (%dx),%al
801037f1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037f4:	89 da                	mov    %ebx,%edx
801037f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801037f9:	b8 07 00 00 00       	mov    $0x7,%eax
801037fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037ff:	89 ca                	mov    %ecx,%edx
80103801:	ec                   	in     (%dx),%al
80103802:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103805:	89 da                	mov    %ebx,%edx
80103807:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010380a:	b8 08 00 00 00       	mov    $0x8,%eax
8010380f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103810:	89 ca                	mov    %ecx,%edx
80103812:	ec                   	in     (%dx),%al
80103813:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103816:	89 da                	mov    %ebx,%edx
80103818:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010381b:	b8 09 00 00 00       	mov    $0x9,%eax
80103820:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103821:	89 ca                	mov    %ecx,%edx
80103823:	ec                   	in     (%dx),%al
80103824:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103827:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010382a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010382d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103830:	6a 18                	push   $0x18
80103832:	50                   	push   %eax
80103833:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103836:	50                   	push   %eax
80103837:	e8 84 26 00 00       	call   80105ec0 <memcmp>
8010383c:	83 c4 10             	add    $0x10,%esp
8010383f:	85 c0                	test   %eax,%eax
80103841:	0f 85 f1 fe ff ff    	jne    80103738 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103847:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010384b:	75 78                	jne    801038c5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010384d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103850:	89 c2                	mov    %eax,%edx
80103852:	83 e0 0f             	and    $0xf,%eax
80103855:	c1 ea 04             	shr    $0x4,%edx
80103858:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010385b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010385e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103861:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103864:	89 c2                	mov    %eax,%edx
80103866:	83 e0 0f             	and    $0xf,%eax
80103869:	c1 ea 04             	shr    $0x4,%edx
8010386c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010386f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103872:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103875:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103878:	89 c2                	mov    %eax,%edx
8010387a:	83 e0 0f             	and    $0xf,%eax
8010387d:	c1 ea 04             	shr    $0x4,%edx
80103880:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103883:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103886:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103889:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010388c:	89 c2                	mov    %eax,%edx
8010388e:	83 e0 0f             	and    $0xf,%eax
80103891:	c1 ea 04             	shr    $0x4,%edx
80103894:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103897:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010389a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010389d:	8b 45 c8             	mov    -0x38(%ebp),%eax
801038a0:	89 c2                	mov    %eax,%edx
801038a2:	83 e0 0f             	and    $0xf,%eax
801038a5:	c1 ea 04             	shr    $0x4,%edx
801038a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801038ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801038ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801038b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038b4:	89 c2                	mov    %eax,%edx
801038b6:	83 e0 0f             	and    $0xf,%eax
801038b9:	c1 ea 04             	shr    $0x4,%edx
801038bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801038bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801038c2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801038c5:	8b 75 08             	mov    0x8(%ebp),%esi
801038c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801038cb:	89 06                	mov    %eax,(%esi)
801038cd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801038d0:	89 46 04             	mov    %eax,0x4(%esi)
801038d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801038d6:	89 46 08             	mov    %eax,0x8(%esi)
801038d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801038dc:	89 46 0c             	mov    %eax,0xc(%esi)
801038df:	8b 45 c8             	mov    -0x38(%ebp),%eax
801038e2:	89 46 10             	mov    %eax,0x10(%esi)
801038e5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038e8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801038eb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801038f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038f5:	5b                   	pop    %ebx
801038f6:	5e                   	pop    %esi
801038f7:	5f                   	pop    %edi
801038f8:	5d                   	pop    %ebp
801038f9:	c3                   	ret    
801038fa:	66 90                	xchg   %ax,%ax
801038fc:	66 90                	xchg   %ax,%ax
801038fe:	66 90                	xchg   %ax,%ax

80103900 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103900:	8b 0d 88 3d 11 80    	mov    0x80113d88,%ecx
80103906:	85 c9                	test   %ecx,%ecx
80103908:	0f 8e 8a 00 00 00    	jle    80103998 <install_trans+0x98>
{
8010390e:	55                   	push   %ebp
8010390f:	89 e5                	mov    %esp,%ebp
80103911:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103912:	31 ff                	xor    %edi,%edi
{
80103914:	56                   	push   %esi
80103915:	53                   	push   %ebx
80103916:	83 ec 0c             	sub    $0xc,%esp
80103919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103920:	a1 74 3d 11 80       	mov    0x80113d74,%eax
80103925:	83 ec 08             	sub    $0x8,%esp
80103928:	01 f8                	add    %edi,%eax
8010392a:	83 c0 01             	add    $0x1,%eax
8010392d:	50                   	push   %eax
8010392e:	ff 35 84 3d 11 80    	push   0x80113d84
80103934:	e8 97 c7 ff ff       	call   801000d0 <bread>
80103939:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010393b:	58                   	pop    %eax
8010393c:	5a                   	pop    %edx
8010393d:	ff 34 bd 8c 3d 11 80 	push   -0x7feec274(,%edi,4)
80103944:	ff 35 84 3d 11 80    	push   0x80113d84
  for (tail = 0; tail < log.lh.n; tail++) {
8010394a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010394d:	e8 7e c7 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103952:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103955:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103957:	8d 46 5c             	lea    0x5c(%esi),%eax
8010395a:	68 00 02 00 00       	push   $0x200
8010395f:	50                   	push   %eax
80103960:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103963:	50                   	push   %eax
80103964:	e8 a7 25 00 00       	call   80105f10 <memmove>
    bwrite(dbuf);  // write dst to disk
80103969:	89 1c 24             	mov    %ebx,(%esp)
8010396c:	e8 3f c8 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103971:	89 34 24             	mov    %esi,(%esp)
80103974:	e8 77 c8 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103979:	89 1c 24             	mov    %ebx,(%esp)
8010397c:	e8 6f c8 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103981:	83 c4 10             	add    $0x10,%esp
80103984:	39 3d 88 3d 11 80    	cmp    %edi,0x80113d88
8010398a:	7f 94                	jg     80103920 <install_trans+0x20>
  }
}
8010398c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010398f:	5b                   	pop    %ebx
80103990:	5e                   	pop    %esi
80103991:	5f                   	pop    %edi
80103992:	5d                   	pop    %ebp
80103993:	c3                   	ret    
80103994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103998:	c3                   	ret    
80103999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039a0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
801039a7:	ff 35 74 3d 11 80    	push   0x80113d74
801039ad:	ff 35 84 3d 11 80    	push   0x80113d84
801039b3:	e8 18 c7 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801039b8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801039bb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
801039bd:	a1 88 3d 11 80       	mov    0x80113d88,%eax
801039c2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801039c5:	85 c0                	test   %eax,%eax
801039c7:	7e 19                	jle    801039e2 <write_head+0x42>
801039c9:	31 d2                	xor    %edx,%edx
801039cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039cf:	90                   	nop
    hb->block[i] = log.lh.block[i];
801039d0:	8b 0c 95 8c 3d 11 80 	mov    -0x7feec274(,%edx,4),%ecx
801039d7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801039db:	83 c2 01             	add    $0x1,%edx
801039de:	39 d0                	cmp    %edx,%eax
801039e0:	75 ee                	jne    801039d0 <write_head+0x30>
  }
  bwrite(buf);
801039e2:	83 ec 0c             	sub    $0xc,%esp
801039e5:	53                   	push   %ebx
801039e6:	e8 c5 c7 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801039eb:	89 1c 24             	mov    %ebx,(%esp)
801039ee:	e8 fd c7 ff ff       	call   801001f0 <brelse>
}
801039f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039f6:	83 c4 10             	add    $0x10,%esp
801039f9:	c9                   	leave  
801039fa:	c3                   	ret    
801039fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039ff:	90                   	nop

80103a00 <initlog>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	53                   	push   %ebx
80103a04:	83 ec 2c             	sub    $0x2c,%esp
80103a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103a0a:	68 40 94 10 80       	push   $0x80109440
80103a0f:	68 40 3d 11 80       	push   $0x80113d40
80103a14:	e8 c7 21 00 00       	call   80105be0 <initlock>
  readsb(dev, &sb);
80103a19:	58                   	pop    %eax
80103a1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103a1d:	5a                   	pop    %edx
80103a1e:	50                   	push   %eax
80103a1f:	53                   	push   %ebx
80103a20:	e8 2b e8 ff ff       	call   80102250 <readsb>
  log.start = sb.logstart;
80103a25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103a28:	59                   	pop    %ecx
  log.dev = dev;
80103a29:	89 1d 84 3d 11 80    	mov    %ebx,0x80113d84
  log.size = sb.nlog;
80103a2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103a32:	a3 74 3d 11 80       	mov    %eax,0x80113d74
  log.size = sb.nlog;
80103a37:	89 15 78 3d 11 80    	mov    %edx,0x80113d78
  struct buf *buf = bread(log.dev, log.start);
80103a3d:	5a                   	pop    %edx
80103a3e:	50                   	push   %eax
80103a3f:	53                   	push   %ebx
80103a40:	e8 8b c6 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103a45:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103a48:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103a4b:	89 1d 88 3d 11 80    	mov    %ebx,0x80113d88
  for (i = 0; i < log.lh.n; i++) {
80103a51:	85 db                	test   %ebx,%ebx
80103a53:	7e 1d                	jle    80103a72 <initlog+0x72>
80103a55:	31 d2                	xor    %edx,%edx
80103a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a5e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103a60:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a64:	89 0c 95 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103a6b:	83 c2 01             	add    $0x1,%edx
80103a6e:	39 d3                	cmp    %edx,%ebx
80103a70:	75 ee                	jne    80103a60 <initlog+0x60>
  brelse(buf);
80103a72:	83 ec 0c             	sub    $0xc,%esp
80103a75:	50                   	push   %eax
80103a76:	e8 75 c7 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103a7b:	e8 80 fe ff ff       	call   80103900 <install_trans>
  log.lh.n = 0;
80103a80:	c7 05 88 3d 11 80 00 	movl   $0x0,0x80113d88
80103a87:	00 00 00 
  write_head(); // clear the log
80103a8a:	e8 11 ff ff ff       	call   801039a0 <write_head>
}
80103a8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a92:	83 c4 10             	add    $0x10,%esp
80103a95:	c9                   	leave  
80103a96:	c3                   	ret    
80103a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a9e:	66 90                	xchg   %ax,%ax

80103aa0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103aa6:	68 40 3d 11 80       	push   $0x80113d40
80103aab:	e8 00 23 00 00       	call   80105db0 <acquire>
80103ab0:	83 c4 10             	add    $0x10,%esp
80103ab3:	eb 18                	jmp    80103acd <begin_op+0x2d>
80103ab5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103ab8:	83 ec 08             	sub    $0x8,%esp
80103abb:	68 40 3d 11 80       	push   $0x80113d40
80103ac0:	68 40 3d 11 80       	push   $0x80113d40
80103ac5:	e8 f6 17 00 00       	call   801052c0 <sleep>
80103aca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103acd:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80103ad2:	85 c0                	test   %eax,%eax
80103ad4:	75 e2                	jne    80103ab8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103ad6:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
80103adb:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
80103ae1:	83 c0 01             	add    $0x1,%eax
80103ae4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103ae7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103aea:	83 fa 1e             	cmp    $0x1e,%edx
80103aed:	7f c9                	jg     80103ab8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103aef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103af2:	a3 7c 3d 11 80       	mov    %eax,0x80113d7c
      release(&log.lock);
80103af7:	68 40 3d 11 80       	push   $0x80113d40
80103afc:	e8 4f 22 00 00       	call   80105d50 <release>
      break;
    }
  }
}
80103b01:	83 c4 10             	add    $0x10,%esp
80103b04:	c9                   	leave  
80103b05:	c3                   	ret    
80103b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b0d:	8d 76 00             	lea    0x0(%esi),%esi

80103b10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103b19:	68 40 3d 11 80       	push   $0x80113d40
80103b1e:	e8 8d 22 00 00       	call   80105db0 <acquire>
  log.outstanding -= 1;
80103b23:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
  if(log.committing)
80103b28:	8b 35 80 3d 11 80    	mov    0x80113d80,%esi
80103b2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103b31:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103b34:	89 1d 7c 3d 11 80    	mov    %ebx,0x80113d7c
  if(log.committing)
80103b3a:	85 f6                	test   %esi,%esi
80103b3c:	0f 85 22 01 00 00    	jne    80103c64 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103b42:	85 db                	test   %ebx,%ebx
80103b44:	0f 85 f6 00 00 00    	jne    80103c40 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103b4a:	c7 05 80 3d 11 80 01 	movl   $0x1,0x80113d80
80103b51:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103b54:	83 ec 0c             	sub    $0xc,%esp
80103b57:	68 40 3d 11 80       	push   $0x80113d40
80103b5c:	e8 ef 21 00 00       	call   80105d50 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103b61:	8b 0d 88 3d 11 80    	mov    0x80113d88,%ecx
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c9                	test   %ecx,%ecx
80103b6c:	7f 42                	jg     80103bb0 <end_op+0xa0>
    acquire(&log.lock);
80103b6e:	83 ec 0c             	sub    $0xc,%esp
80103b71:	68 40 3d 11 80       	push   $0x80113d40
80103b76:	e8 35 22 00 00       	call   80105db0 <acquire>
    wakeup(&log);
80103b7b:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
    log.committing = 0;
80103b82:	c7 05 80 3d 11 80 00 	movl   $0x0,0x80113d80
80103b89:	00 00 00 
    wakeup(&log);
80103b8c:	e8 ff 17 00 00       	call   80105390 <wakeup>
    release(&log.lock);
80103b91:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103b98:	e8 b3 21 00 00       	call   80105d50 <release>
80103b9d:	83 c4 10             	add    $0x10,%esp
}
80103ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ba3:	5b                   	pop    %ebx
80103ba4:	5e                   	pop    %esi
80103ba5:	5f                   	pop    %edi
80103ba6:	5d                   	pop    %ebp
80103ba7:	c3                   	ret    
80103ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103baf:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103bb0:	a1 74 3d 11 80       	mov    0x80113d74,%eax
80103bb5:	83 ec 08             	sub    $0x8,%esp
80103bb8:	01 d8                	add    %ebx,%eax
80103bba:	83 c0 01             	add    $0x1,%eax
80103bbd:	50                   	push   %eax
80103bbe:	ff 35 84 3d 11 80    	push   0x80113d84
80103bc4:	e8 07 c5 ff ff       	call   801000d0 <bread>
80103bc9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103bcb:	58                   	pop    %eax
80103bcc:	5a                   	pop    %edx
80103bcd:	ff 34 9d 8c 3d 11 80 	push   -0x7feec274(,%ebx,4)
80103bd4:	ff 35 84 3d 11 80    	push   0x80113d84
  for (tail = 0; tail < log.lh.n; tail++) {
80103bda:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103bdd:	e8 ee c4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103be2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103be5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103be7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103bea:	68 00 02 00 00       	push   $0x200
80103bef:	50                   	push   %eax
80103bf0:	8d 46 5c             	lea    0x5c(%esi),%eax
80103bf3:	50                   	push   %eax
80103bf4:	e8 17 23 00 00       	call   80105f10 <memmove>
    bwrite(to);  // write the log
80103bf9:	89 34 24             	mov    %esi,(%esp)
80103bfc:	e8 af c5 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103c01:	89 3c 24             	mov    %edi,(%esp)
80103c04:	e8 e7 c5 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103c09:	89 34 24             	mov    %esi,(%esp)
80103c0c:	e8 df c5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103c11:	83 c4 10             	add    $0x10,%esp
80103c14:	3b 1d 88 3d 11 80    	cmp    0x80113d88,%ebx
80103c1a:	7c 94                	jl     80103bb0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103c1c:	e8 7f fd ff ff       	call   801039a0 <write_head>
    install_trans(); // Now install writes to home locations
80103c21:	e8 da fc ff ff       	call   80103900 <install_trans>
    log.lh.n = 0;
80103c26:	c7 05 88 3d 11 80 00 	movl   $0x0,0x80113d88
80103c2d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103c30:	e8 6b fd ff ff       	call   801039a0 <write_head>
80103c35:	e9 34 ff ff ff       	jmp    80103b6e <end_op+0x5e>
80103c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103c40:	83 ec 0c             	sub    $0xc,%esp
80103c43:	68 40 3d 11 80       	push   $0x80113d40
80103c48:	e8 43 17 00 00       	call   80105390 <wakeup>
  release(&log.lock);
80103c4d:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103c54:	e8 f7 20 00 00       	call   80105d50 <release>
80103c59:	83 c4 10             	add    $0x10,%esp
}
80103c5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c5f:	5b                   	pop    %ebx
80103c60:	5e                   	pop    %esi
80103c61:	5f                   	pop    %edi
80103c62:	5d                   	pop    %ebp
80103c63:	c3                   	ret    
    panic("log.committing");
80103c64:	83 ec 0c             	sub    $0xc,%esp
80103c67:	68 44 94 10 80       	push   $0x80109444
80103c6c:	e8 7f c8 ff ff       	call   801004f0 <panic>
80103c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c7f:	90                   	nop

80103c80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
80103c84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c87:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
{
80103c8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c90:	83 fa 1d             	cmp    $0x1d,%edx
80103c93:	0f 8f 85 00 00 00    	jg     80103d1e <log_write+0x9e>
80103c99:	a1 78 3d 11 80       	mov    0x80113d78,%eax
80103c9e:	83 e8 01             	sub    $0x1,%eax
80103ca1:	39 c2                	cmp    %eax,%edx
80103ca3:	7d 79                	jge    80103d1e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103ca5:	a1 7c 3d 11 80       	mov    0x80113d7c,%eax
80103caa:	85 c0                	test   %eax,%eax
80103cac:	7e 7d                	jle    80103d2b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103cae:	83 ec 0c             	sub    $0xc,%esp
80103cb1:	68 40 3d 11 80       	push   $0x80113d40
80103cb6:	e8 f5 20 00 00       	call   80105db0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103cbb:	8b 15 88 3d 11 80    	mov    0x80113d88,%edx
80103cc1:	83 c4 10             	add    $0x10,%esp
80103cc4:	85 d2                	test   %edx,%edx
80103cc6:	7e 4a                	jle    80103d12 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103cc8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103ccb:	31 c0                	xor    %eax,%eax
80103ccd:	eb 08                	jmp    80103cd7 <log_write+0x57>
80103ccf:	90                   	nop
80103cd0:	83 c0 01             	add    $0x1,%eax
80103cd3:	39 c2                	cmp    %eax,%edx
80103cd5:	74 29                	je     80103d00 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103cd7:	39 0c 85 8c 3d 11 80 	cmp    %ecx,-0x7feec274(,%eax,4)
80103cde:	75 f0                	jne    80103cd0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103ce0:	89 0c 85 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103ce7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103cea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103ced:	c7 45 08 40 3d 11 80 	movl   $0x80113d40,0x8(%ebp)
}
80103cf4:	c9                   	leave  
  release(&log.lock);
80103cf5:	e9 56 20 00 00       	jmp    80105d50 <release>
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103d00:	89 0c 95 8c 3d 11 80 	mov    %ecx,-0x7feec274(,%edx,4)
    log.lh.n++;
80103d07:	83 c2 01             	add    $0x1,%edx
80103d0a:	89 15 88 3d 11 80    	mov    %edx,0x80113d88
80103d10:	eb d5                	jmp    80103ce7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103d12:	8b 43 08             	mov    0x8(%ebx),%eax
80103d15:	a3 8c 3d 11 80       	mov    %eax,0x80113d8c
  if (i == log.lh.n)
80103d1a:	75 cb                	jne    80103ce7 <log_write+0x67>
80103d1c:	eb e9                	jmp    80103d07 <log_write+0x87>
    panic("too big a transaction");
80103d1e:	83 ec 0c             	sub    $0xc,%esp
80103d21:	68 53 94 10 80       	push   $0x80109453
80103d26:	e8 c5 c7 ff ff       	call   801004f0 <panic>
    panic("log_write outside of trans");
80103d2b:	83 ec 0c             	sub    $0xc,%esp
80103d2e:	68 69 94 10 80       	push   $0x80109469
80103d33:	e8 b8 c7 ff ff       	call   801004f0 <panic>
80103d38:	66 90                	xchg   %ax,%ax
80103d3a:	66 90                	xchg   %ax,%ax
80103d3c:	66 90                	xchg   %ax,%ax
80103d3e:	66 90                	xchg   %ax,%ax

80103d40 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
80103d44:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103d47:	e8 c4 09 00 00       	call   80104710 <cpuid>
80103d4c:	89 c3                	mov    %eax,%ebx
80103d4e:	e8 bd 09 00 00       	call   80104710 <cpuid>
80103d53:	83 ec 04             	sub    $0x4,%esp
80103d56:	53                   	push   %ebx
80103d57:	50                   	push   %eax
80103d58:	68 84 94 10 80       	push   $0x80109484
80103d5d:	e8 0e cd ff ff       	call   80100a70 <cprintf>
  idtinit();       // load idt register
80103d62:	e8 69 38 00 00       	call   801075d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103d67:	e8 44 09 00 00       	call   801046b0 <mycpu>
80103d6c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103d6e:	b8 01 00 00 00       	mov    $0x1,%eax
80103d73:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103d7a:	e8 41 10 00 00       	call   80104dc0 <scheduler>
80103d7f:	90                   	nop

80103d80 <mpenter>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103d86:	e8 05 4a 00 00       	call   80108790 <switchkvm>
  seginit();
80103d8b:	e8 70 49 00 00       	call   80108700 <seginit>
  lapicinit();
80103d90:	e8 9b f7 ff ff       	call   80103530 <lapicinit>
  mpmain();
80103d95:	e8 a6 ff ff ff       	call   80103d40 <mpmain>
80103d9a:	66 90                	xchg   %ax,%ax
80103d9c:	66 90                	xchg   %ax,%ax
80103d9e:	66 90                	xchg   %ax,%ax

80103da0 <main>:
{
80103da0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103da4:	83 e4 f0             	and    $0xfffffff0,%esp
80103da7:	ff 71 fc             	push   -0x4(%ecx)
80103daa:	55                   	push   %ebp
80103dab:	89 e5                	mov    %esp,%ebp
80103dad:	53                   	push   %ebx
80103dae:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103daf:	83 ec 08             	sub    $0x8,%esp
80103db2:	68 00 00 40 80       	push   $0x80400000
80103db7:	68 70 9f 11 80       	push   $0x80119f70
80103dbc:	e8 8f f5 ff ff       	call   80103350 <kinit1>
  kvmalloc();      // kernel page table
80103dc1:	e8 ba 4e 00 00       	call   80108c80 <kvmalloc>
  mpinit();        // detect other processors
80103dc6:	e8 85 01 00 00       	call   80103f50 <mpinit>
  lapicinit();     // interrupt controller
80103dcb:	e8 60 f7 ff ff       	call   80103530 <lapicinit>
  seginit();       // segment descriptors
80103dd0:	e8 2b 49 00 00       	call   80108700 <seginit>
  picinit();       // disable pic
80103dd5:	e8 76 03 00 00       	call   80104150 <picinit>
  ioapicinit();    // another interrupt controller
80103dda:	e8 31 f3 ff ff       	call   80103110 <ioapicinit>
  consoleinit();   // console hardware
80103ddf:	e8 9c d9 ff ff       	call   80101780 <consoleinit>
  uartinit();      // serial port
80103de4:	e8 a7 3b 00 00       	call   80107990 <uartinit>
  pinit();         // process table
80103de9:	e8 a2 08 00 00       	call   80104690 <pinit>
  tvinit();        // trap vectors
80103dee:	e8 5d 37 00 00       	call   80107550 <tvinit>
  binit();         // buffer cache
80103df3:	e8 48 c2 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103df8:	e8 43 dd ff ff       	call   80101b40 <fileinit>
  ideinit();       // disk 
80103dfd:	e8 fe f0 ff ff       	call   80102f00 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103e02:	83 c4 0c             	add    $0xc,%esp
80103e05:	68 8a 00 00 00       	push   $0x8a
80103e0a:	68 ec c4 10 80       	push   $0x8010c4ec
80103e0f:	68 00 70 00 80       	push   $0x80007000
80103e14:	e8 f7 20 00 00       	call   80105f10 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103e19:	83 c4 10             	add    $0x10,%esp
80103e1c:	69 05 24 3e 11 80 b0 	imul   $0xb0,0x80113e24,%eax
80103e23:	00 00 00 
80103e26:	05 40 3e 11 80       	add    $0x80113e40,%eax
80103e2b:	3d 40 3e 11 80       	cmp    $0x80113e40,%eax
80103e30:	76 7e                	jbe    80103eb0 <main+0x110>
80103e32:	bb 40 3e 11 80       	mov    $0x80113e40,%ebx
80103e37:	eb 20                	jmp    80103e59 <main+0xb9>
80103e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e40:	69 05 24 3e 11 80 b0 	imul   $0xb0,0x80113e24,%eax
80103e47:	00 00 00 
80103e4a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103e50:	05 40 3e 11 80       	add    $0x80113e40,%eax
80103e55:	39 c3                	cmp    %eax,%ebx
80103e57:	73 57                	jae    80103eb0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103e59:	e8 52 08 00 00       	call   801046b0 <mycpu>
80103e5e:	39 c3                	cmp    %eax,%ebx
80103e60:	74 de                	je     80103e40 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103e62:	e8 59 f5 ff ff       	call   801033c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103e67:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103e6a:	c7 05 f8 6f 00 80 80 	movl   $0x80103d80,0x80006ff8
80103e71:	3d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103e74:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103e7b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e7e:	05 00 10 00 00       	add    $0x1000,%eax
80103e83:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103e88:	0f b6 03             	movzbl (%ebx),%eax
80103e8b:	68 00 70 00 00       	push   $0x7000
80103e90:	50                   	push   %eax
80103e91:	e8 ea f7 ff ff       	call   80103680 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e96:	83 c4 10             	add    $0x10,%esp
80103e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ea0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103ea6:	85 c0                	test   %eax,%eax
80103ea8:	74 f6                	je     80103ea0 <main+0x100>
80103eaa:	eb 94                	jmp    80103e40 <main+0xa0>
80103eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103eb0:	83 ec 08             	sub    $0x8,%esp
80103eb3:	68 00 00 00 8e       	push   $0x8e000000
80103eb8:	68 00 00 40 80       	push   $0x80400000
80103ebd:	e8 2e f4 ff ff       	call   801032f0 <kinit2>
  userinit();      // first user process
80103ec2:	e8 49 0b 00 00       	call   80104a10 <userinit>
  mpmain();        // finish this processor's setup
80103ec7:	e8 74 fe ff ff       	call   80103d40 <mpmain>
80103ecc:	66 90                	xchg   %ax,%ax
80103ece:	66 90                	xchg   %ax,%ax

80103ed0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	57                   	push   %edi
80103ed4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103ed5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103edb:	53                   	push   %ebx
  e = addr+len;
80103edc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103edf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103ee2:	39 de                	cmp    %ebx,%esi
80103ee4:	72 10                	jb     80103ef6 <mpsearch1+0x26>
80103ee6:	eb 50                	jmp    80103f38 <mpsearch1+0x68>
80103ee8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eef:	90                   	nop
80103ef0:	89 fe                	mov    %edi,%esi
80103ef2:	39 fb                	cmp    %edi,%ebx
80103ef4:	76 42                	jbe    80103f38 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103ef6:	83 ec 04             	sub    $0x4,%esp
80103ef9:	8d 7e 10             	lea    0x10(%esi),%edi
80103efc:	6a 04                	push   $0x4
80103efe:	68 98 94 10 80       	push   $0x80109498
80103f03:	56                   	push   %esi
80103f04:	e8 b7 1f 00 00       	call   80105ec0 <memcmp>
80103f09:	83 c4 10             	add    $0x10,%esp
80103f0c:	85 c0                	test   %eax,%eax
80103f0e:	75 e0                	jne    80103ef0 <mpsearch1+0x20>
80103f10:	89 f2                	mov    %esi,%edx
80103f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103f18:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103f1b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103f1e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103f20:	39 fa                	cmp    %edi,%edx
80103f22:	75 f4                	jne    80103f18 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f24:	84 c0                	test   %al,%al
80103f26:	75 c8                	jne    80103ef0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103f28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f2b:	89 f0                	mov    %esi,%eax
80103f2d:	5b                   	pop    %ebx
80103f2e:	5e                   	pop    %esi
80103f2f:	5f                   	pop    %edi
80103f30:	5d                   	pop    %ebp
80103f31:	c3                   	ret    
80103f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103f3b:	31 f6                	xor    %esi,%esi
}
80103f3d:	5b                   	pop    %ebx
80103f3e:	89 f0                	mov    %esi,%eax
80103f40:	5e                   	pop    %esi
80103f41:	5f                   	pop    %edi
80103f42:	5d                   	pop    %ebp
80103f43:	c3                   	ret    
80103f44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f4f:	90                   	nop

80103f50 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103f59:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103f60:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103f67:	c1 e0 08             	shl    $0x8,%eax
80103f6a:	09 d0                	or     %edx,%eax
80103f6c:	c1 e0 04             	shl    $0x4,%eax
80103f6f:	75 1b                	jne    80103f8c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103f71:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f78:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f7f:	c1 e0 08             	shl    $0x8,%eax
80103f82:	09 d0                	or     %edx,%eax
80103f84:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103f87:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103f8c:	ba 00 04 00 00       	mov    $0x400,%edx
80103f91:	e8 3a ff ff ff       	call   80103ed0 <mpsearch1>
80103f96:	89 c3                	mov    %eax,%ebx
80103f98:	85 c0                	test   %eax,%eax
80103f9a:	0f 84 40 01 00 00    	je     801040e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103fa0:	8b 73 04             	mov    0x4(%ebx),%esi
80103fa3:	85 f6                	test   %esi,%esi
80103fa5:	0f 84 25 01 00 00    	je     801040d0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
80103fab:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103fae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103fb4:	6a 04                	push   $0x4
80103fb6:	68 9d 94 10 80       	push   $0x8010949d
80103fbb:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103fbc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103fbf:	e8 fc 1e 00 00       	call   80105ec0 <memcmp>
80103fc4:	83 c4 10             	add    $0x10,%esp
80103fc7:	85 c0                	test   %eax,%eax
80103fc9:	0f 85 01 01 00 00    	jne    801040d0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103fcf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103fd6:	3c 01                	cmp    $0x1,%al
80103fd8:	74 08                	je     80103fe2 <mpinit+0x92>
80103fda:	3c 04                	cmp    $0x4,%al
80103fdc:	0f 85 ee 00 00 00    	jne    801040d0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103fe2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103fe9:	66 85 d2             	test   %dx,%dx
80103fec:	74 22                	je     80104010 <mpinit+0xc0>
80103fee:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103ff1:	89 f0                	mov    %esi,%eax
  sum = 0;
80103ff3:	31 d2                	xor    %edx,%edx
80103ff5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103ff8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103fff:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80104002:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80104004:	39 c7                	cmp    %eax,%edi
80104006:	75 f0                	jne    80103ff8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80104008:	84 d2                	test   %dl,%dl
8010400a:	0f 85 c0 00 00 00    	jne    801040d0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80104010:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80104016:	a3 20 3d 11 80       	mov    %eax,0x80113d20
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010401b:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80104022:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80104028:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010402d:	03 55 e4             	add    -0x1c(%ebp),%edx
80104030:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80104033:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104037:	90                   	nop
80104038:	39 d0                	cmp    %edx,%eax
8010403a:	73 15                	jae    80104051 <mpinit+0x101>
    switch(*p){
8010403c:	0f b6 08             	movzbl (%eax),%ecx
8010403f:	80 f9 02             	cmp    $0x2,%cl
80104042:	74 4c                	je     80104090 <mpinit+0x140>
80104044:	77 3a                	ja     80104080 <mpinit+0x130>
80104046:	84 c9                	test   %cl,%cl
80104048:	74 56                	je     801040a0 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010404a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010404d:	39 d0                	cmp    %edx,%eax
8010404f:	72 eb                	jb     8010403c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104051:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104054:	85 f6                	test   %esi,%esi
80104056:	0f 84 d9 00 00 00    	je     80104135 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010405c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104060:	74 15                	je     80104077 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104062:	b8 70 00 00 00       	mov    $0x70,%eax
80104067:	ba 22 00 00 00       	mov    $0x22,%edx
8010406c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010406d:	ba 23 00 00 00       	mov    $0x23,%edx
80104072:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104073:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104076:	ee                   	out    %al,(%dx)
  }
}
80104077:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010407a:	5b                   	pop    %ebx
8010407b:	5e                   	pop    %esi
8010407c:	5f                   	pop    %edi
8010407d:	5d                   	pop    %ebp
8010407e:	c3                   	ret    
8010407f:	90                   	nop
    switch(*p){
80104080:	83 e9 03             	sub    $0x3,%ecx
80104083:	80 f9 01             	cmp    $0x1,%cl
80104086:	76 c2                	jbe    8010404a <mpinit+0xfa>
80104088:	31 f6                	xor    %esi,%esi
8010408a:	eb ac                	jmp    80104038 <mpinit+0xe8>
8010408c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80104090:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104094:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104097:	88 0d 20 3e 11 80    	mov    %cl,0x80113e20
      continue;
8010409d:	eb 99                	jmp    80104038 <mpinit+0xe8>
8010409f:	90                   	nop
      if(ncpu < NCPU) {
801040a0:	8b 0d 24 3e 11 80    	mov    0x80113e24,%ecx
801040a6:	83 f9 07             	cmp    $0x7,%ecx
801040a9:	7f 19                	jg     801040c4 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801040ab:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
801040b1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801040b5:	83 c1 01             	add    $0x1,%ecx
801040b8:	89 0d 24 3e 11 80    	mov    %ecx,0x80113e24
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801040be:	88 9f 40 3e 11 80    	mov    %bl,-0x7feec1c0(%edi)
      p += sizeof(struct mpproc);
801040c4:	83 c0 14             	add    $0x14,%eax
      continue;
801040c7:	e9 6c ff ff ff       	jmp    80104038 <mpinit+0xe8>
801040cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801040d0:	83 ec 0c             	sub    $0xc,%esp
801040d3:	68 a2 94 10 80       	push   $0x801094a2
801040d8:	e8 13 c4 ff ff       	call   801004f0 <panic>
801040dd:	8d 76 00             	lea    0x0(%esi),%esi
{
801040e0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801040e5:	eb 13                	jmp    801040fa <mpinit+0x1aa>
801040e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ee:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801040f0:	89 f3                	mov    %esi,%ebx
801040f2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801040f8:	74 d6                	je     801040d0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801040fa:	83 ec 04             	sub    $0x4,%esp
801040fd:	8d 73 10             	lea    0x10(%ebx),%esi
80104100:	6a 04                	push   $0x4
80104102:	68 98 94 10 80       	push   $0x80109498
80104107:	53                   	push   %ebx
80104108:	e8 b3 1d 00 00       	call   80105ec0 <memcmp>
8010410d:	83 c4 10             	add    $0x10,%esp
80104110:	85 c0                	test   %eax,%eax
80104112:	75 dc                	jne    801040f0 <mpinit+0x1a0>
80104114:	89 da                	mov    %ebx,%edx
80104116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010411d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104120:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80104123:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80104126:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104128:	39 d6                	cmp    %edx,%esi
8010412a:	75 f4                	jne    80104120 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010412c:	84 c0                	test   %al,%al
8010412e:	75 c0                	jne    801040f0 <mpinit+0x1a0>
80104130:	e9 6b fe ff ff       	jmp    80103fa0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80104135:	83 ec 0c             	sub    $0xc,%esp
80104138:	68 bc 94 10 80       	push   $0x801094bc
8010413d:	e8 ae c3 ff ff       	call   801004f0 <panic>
80104142:	66 90                	xchg   %ax,%ax
80104144:	66 90                	xchg   %ax,%ax
80104146:	66 90                	xchg   %ax,%ax
80104148:	66 90                	xchg   %ax,%ax
8010414a:	66 90                	xchg   %ax,%ax
8010414c:	66 90                	xchg   %ax,%ax
8010414e:	66 90                	xchg   %ax,%ax

80104150 <picinit>:
80104150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104155:	ba 21 00 00 00       	mov    $0x21,%edx
8010415a:	ee                   	out    %al,(%dx)
8010415b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104160:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104161:	c3                   	ret    
80104162:	66 90                	xchg   %ax,%ax
80104164:	66 90                	xchg   %ax,%ax
80104166:	66 90                	xchg   %ax,%ax
80104168:	66 90                	xchg   %ax,%ax
8010416a:	66 90                	xchg   %ax,%ax
8010416c:	66 90                	xchg   %ax,%ax
8010416e:	66 90                	xchg   %ax,%ax

80104170 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	57                   	push   %edi
80104174:	56                   	push   %esi
80104175:	53                   	push   %ebx
80104176:	83 ec 0c             	sub    $0xc,%esp
80104179:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010417c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010417f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104185:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010418b:	e8 d0 d9 ff ff       	call   80101b60 <filealloc>
80104190:	89 03                	mov    %eax,(%ebx)
80104192:	85 c0                	test   %eax,%eax
80104194:	0f 84 a8 00 00 00    	je     80104242 <pipealloc+0xd2>
8010419a:	e8 c1 d9 ff ff       	call   80101b60 <filealloc>
8010419f:	89 06                	mov    %eax,(%esi)
801041a1:	85 c0                	test   %eax,%eax
801041a3:	0f 84 87 00 00 00    	je     80104230 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801041a9:	e8 12 f2 ff ff       	call   801033c0 <kalloc>
801041ae:	89 c7                	mov    %eax,%edi
801041b0:	85 c0                	test   %eax,%eax
801041b2:	0f 84 b0 00 00 00    	je     80104268 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801041b8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801041bf:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801041c2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801041c5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801041cc:	00 00 00 
  p->nwrite = 0;
801041cf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801041d6:	00 00 00 
  p->nread = 0;
801041d9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801041e0:	00 00 00 
  initlock(&p->lock, "pipe");
801041e3:	68 db 94 10 80       	push   $0x801094db
801041e8:	50                   	push   %eax
801041e9:	e8 f2 19 00 00       	call   80105be0 <initlock>
  (*f0)->type = FD_PIPE;
801041ee:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801041f0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801041f3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801041f9:	8b 03                	mov    (%ebx),%eax
801041fb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801041ff:	8b 03                	mov    (%ebx),%eax
80104201:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104205:	8b 03                	mov    (%ebx),%eax
80104207:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010420a:	8b 06                	mov    (%esi),%eax
8010420c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104212:	8b 06                	mov    (%esi),%eax
80104214:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104218:	8b 06                	mov    (%esi),%eax
8010421a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010421e:	8b 06                	mov    (%esi),%eax
80104220:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104223:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104226:	31 c0                	xor    %eax,%eax
}
80104228:	5b                   	pop    %ebx
80104229:	5e                   	pop    %esi
8010422a:	5f                   	pop    %edi
8010422b:	5d                   	pop    %ebp
8010422c:	c3                   	ret    
8010422d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80104230:	8b 03                	mov    (%ebx),%eax
80104232:	85 c0                	test   %eax,%eax
80104234:	74 1e                	je     80104254 <pipealloc+0xe4>
    fileclose(*f0);
80104236:	83 ec 0c             	sub    $0xc,%esp
80104239:	50                   	push   %eax
8010423a:	e8 e1 d9 ff ff       	call   80101c20 <fileclose>
8010423f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104242:	8b 06                	mov    (%esi),%eax
80104244:	85 c0                	test   %eax,%eax
80104246:	74 0c                	je     80104254 <pipealloc+0xe4>
    fileclose(*f1);
80104248:	83 ec 0c             	sub    $0xc,%esp
8010424b:	50                   	push   %eax
8010424c:	e8 cf d9 ff ff       	call   80101c20 <fileclose>
80104251:	83 c4 10             	add    $0x10,%esp
}
80104254:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010425c:	5b                   	pop    %ebx
8010425d:	5e                   	pop    %esi
8010425e:	5f                   	pop    %edi
8010425f:	5d                   	pop    %ebp
80104260:	c3                   	ret    
80104261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104268:	8b 03                	mov    (%ebx),%eax
8010426a:	85 c0                	test   %eax,%eax
8010426c:	75 c8                	jne    80104236 <pipealloc+0xc6>
8010426e:	eb d2                	jmp    80104242 <pipealloc+0xd2>

80104270 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
80104275:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104278:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010427b:	83 ec 0c             	sub    $0xc,%esp
8010427e:	53                   	push   %ebx
8010427f:	e8 2c 1b 00 00       	call   80105db0 <acquire>
  if(writable){
80104284:	83 c4 10             	add    $0x10,%esp
80104287:	85 f6                	test   %esi,%esi
80104289:	74 65                	je     801042f0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010428b:	83 ec 0c             	sub    $0xc,%esp
8010428e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104294:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010429b:	00 00 00 
    wakeup(&p->nread);
8010429e:	50                   	push   %eax
8010429f:	e8 ec 10 00 00       	call   80105390 <wakeup>
801042a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801042a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801042ad:	85 d2                	test   %edx,%edx
801042af:	75 0a                	jne    801042bb <pipeclose+0x4b>
801042b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801042b7:	85 c0                	test   %eax,%eax
801042b9:	74 15                	je     801042d0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801042bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801042be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c1:	5b                   	pop    %ebx
801042c2:	5e                   	pop    %esi
801042c3:	5d                   	pop    %ebp
    release(&p->lock);
801042c4:	e9 87 1a 00 00       	jmp    80105d50 <release>
801042c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801042d0:	83 ec 0c             	sub    $0xc,%esp
801042d3:	53                   	push   %ebx
801042d4:	e8 77 1a 00 00       	call   80105d50 <release>
    kfree((char*)p);
801042d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801042dc:	83 c4 10             	add    $0x10,%esp
}
801042df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042e2:	5b                   	pop    %ebx
801042e3:	5e                   	pop    %esi
801042e4:	5d                   	pop    %ebp
    kfree((char*)p);
801042e5:	e9 16 ef ff ff       	jmp    80103200 <kfree>
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801042f0:	83 ec 0c             	sub    $0xc,%esp
801042f3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801042f9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104300:	00 00 00 
    wakeup(&p->nwrite);
80104303:	50                   	push   %eax
80104304:	e8 87 10 00 00       	call   80105390 <wakeup>
80104309:	83 c4 10             	add    $0x10,%esp
8010430c:	eb 99                	jmp    801042a7 <pipeclose+0x37>
8010430e:	66 90                	xchg   %ax,%ax

80104310 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	57                   	push   %edi
80104314:	56                   	push   %esi
80104315:	53                   	push   %ebx
80104316:	83 ec 28             	sub    $0x28,%esp
80104319:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010431c:	53                   	push   %ebx
8010431d:	e8 8e 1a 00 00       	call   80105db0 <acquire>
  for(i = 0; i < n; i++){
80104322:	8b 45 10             	mov    0x10(%ebp),%eax
80104325:	83 c4 10             	add    $0x10,%esp
80104328:	85 c0                	test   %eax,%eax
8010432a:	0f 8e c0 00 00 00    	jle    801043f0 <pipewrite+0xe0>
80104330:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104333:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104339:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010433f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104342:	03 45 10             	add    0x10(%ebp),%eax
80104345:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104348:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010434e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104354:	89 ca                	mov    %ecx,%edx
80104356:	05 00 02 00 00       	add    $0x200,%eax
8010435b:	39 c1                	cmp    %eax,%ecx
8010435d:	74 42                	je     801043a1 <pipewrite+0x91>
8010435f:	eb 67                	jmp    801043c8 <pipewrite+0xb8>
80104361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104368:	e8 c3 03 00 00       	call   80104730 <myproc>
8010436d:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
80104373:	85 c9                	test   %ecx,%ecx
80104375:	75 34                	jne    801043ab <pipewrite+0x9b>
      wakeup(&p->nread);
80104377:	83 ec 0c             	sub    $0xc,%esp
8010437a:	57                   	push   %edi
8010437b:	e8 10 10 00 00       	call   80105390 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104380:	58                   	pop    %eax
80104381:	5a                   	pop    %edx
80104382:	53                   	push   %ebx
80104383:	56                   	push   %esi
80104384:	e8 37 0f 00 00       	call   801052c0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104389:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010438f:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104395:	83 c4 10             	add    $0x10,%esp
80104398:	05 00 02 00 00       	add    $0x200,%eax
8010439d:	39 c2                	cmp    %eax,%edx
8010439f:	75 27                	jne    801043c8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801043a1:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801043a7:	85 c0                	test   %eax,%eax
801043a9:	75 bd                	jne    80104368 <pipewrite+0x58>
        release(&p->lock);
801043ab:	83 ec 0c             	sub    $0xc,%esp
801043ae:	53                   	push   %ebx
801043af:	e8 9c 19 00 00       	call   80105d50 <release>
        return -1;
801043b4:	83 c4 10             	add    $0x10,%esp
801043b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801043bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043bf:	5b                   	pop    %ebx
801043c0:	5e                   	pop    %esi
801043c1:	5f                   	pop    %edi
801043c2:	5d                   	pop    %ebp
801043c3:	c3                   	ret    
801043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801043c8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801043cb:	8d 4a 01             	lea    0x1(%edx),%ecx
801043ce:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801043d4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801043da:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801043dd:	83 c6 01             	add    $0x1,%esi
801043e0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801043e3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801043e7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801043ea:	0f 85 58 ff ff ff    	jne    80104348 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801043f0:	83 ec 0c             	sub    $0xc,%esp
801043f3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801043f9:	50                   	push   %eax
801043fa:	e8 91 0f 00 00       	call   80105390 <wakeup>
  release(&p->lock);
801043ff:	89 1c 24             	mov    %ebx,(%esp)
80104402:	e8 49 19 00 00       	call   80105d50 <release>
  return n;
80104407:	8b 45 10             	mov    0x10(%ebp),%eax
8010440a:	83 c4 10             	add    $0x10,%esp
8010440d:	eb ad                	jmp    801043bc <pipewrite+0xac>
8010440f:	90                   	nop

80104410 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	57                   	push   %edi
80104414:	56                   	push   %esi
80104415:	53                   	push   %ebx
80104416:	83 ec 18             	sub    $0x18,%esp
80104419:	8b 75 08             	mov    0x8(%ebp),%esi
8010441c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010441f:	56                   	push   %esi
80104420:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104426:	e8 85 19 00 00       	call   80105db0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010442b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104431:	83 c4 10             	add    $0x10,%esp
80104434:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010443a:	74 32                	je     8010446e <piperead+0x5e>
8010443c:	eb 3a                	jmp    80104478 <piperead+0x68>
8010443e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104440:	e8 eb 02 00 00       	call   80104730 <myproc>
80104445:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010444b:	85 c9                	test   %ecx,%ecx
8010444d:	0f 85 8d 00 00 00    	jne    801044e0 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104453:	83 ec 08             	sub    $0x8,%esp
80104456:	56                   	push   %esi
80104457:	53                   	push   %ebx
80104458:	e8 63 0e 00 00       	call   801052c0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010445d:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104463:	83 c4 10             	add    $0x10,%esp
80104466:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
8010446c:	75 0a                	jne    80104478 <piperead+0x68>
8010446e:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104474:	85 c0                	test   %eax,%eax
80104476:	75 c8                	jne    80104440 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104478:	8b 55 10             	mov    0x10(%ebp),%edx
8010447b:	31 db                	xor    %ebx,%ebx
8010447d:	85 d2                	test   %edx,%edx
8010447f:	7f 25                	jg     801044a6 <piperead+0x96>
80104481:	eb 31                	jmp    801044b4 <piperead+0xa4>
80104483:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104487:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104488:	8d 48 01             	lea    0x1(%eax),%ecx
8010448b:	25 ff 01 00 00       	and    $0x1ff,%eax
80104490:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80104496:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
8010449b:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010449e:	83 c3 01             	add    $0x1,%ebx
801044a1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801044a4:	74 0e                	je     801044b4 <piperead+0xa4>
    if(p->nread == p->nwrite)
801044a6:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801044ac:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801044b2:	75 d4                	jne    80104488 <piperead+0x78>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801044b4:	83 ec 0c             	sub    $0xc,%esp
801044b7:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801044bd:	50                   	push   %eax
801044be:	e8 cd 0e 00 00       	call   80105390 <wakeup>
  release(&p->lock);
801044c3:	89 34 24             	mov    %esi,(%esp)
801044c6:	e8 85 18 00 00       	call   80105d50 <release>
  return i;
801044cb:	83 c4 10             	add    $0x10,%esp
}
801044ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044d1:	89 d8                	mov    %ebx,%eax
801044d3:	5b                   	pop    %ebx
801044d4:	5e                   	pop    %esi
801044d5:	5f                   	pop    %edi
801044d6:	5d                   	pop    %ebp
801044d7:	c3                   	ret    
801044d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044df:	90                   	nop
      release(&p->lock);
801044e0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801044e3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801044e8:	56                   	push   %esi
801044e9:	e8 62 18 00 00       	call   80105d50 <release>
      return -1;
801044ee:	83 c4 10             	add    $0x10,%esp
}
801044f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044f4:	89 d8                	mov    %ebx,%eax
801044f6:	5b                   	pop    %ebx
801044f7:	5e                   	pop    %esi
801044f8:	5f                   	pop    %edi
801044f9:	5d                   	pop    %ebp
801044fa:	c3                   	ret    
801044fb:	66 90                	xchg   %ax,%ax
801044fd:	66 90                	xchg   %ax,%ax
801044ff:	90                   	nop

80104500 <allocproc>:
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104504:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
{
80104509:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010450c:	68 c0 43 11 80       	push   $0x801143c0
80104511:	e8 9a 18 00 00       	call   80105db0 <acquire>
80104516:	83 c4 10             	add    $0x10,%esp
80104519:	eb 17                	jmp    80104532 <allocproc+0x32>
8010451b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104520:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80104526:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
8010452c:	0f 84 de 00 00 00    	je     80104610 <allocproc+0x110>
    if (p->state == UNUSED)
80104532:	8b 43 78             	mov    0x78(%ebx),%eax
80104535:	85 c0                	test   %eax,%eax
80104537:	75 e7                	jne    80104520 <allocproc+0x20>
80104539:	89 d8                	mov    %ebx,%eax
8010453b:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010453e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
  return 0;

found:
  for (int i = 0; i < MAX_SYSCALLS; i++)
    p->syscalls[i] = 0;
80104540:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for (int i = 0; i < MAX_SYSCALLS; i++)
80104546:	83 c0 04             	add    $0x4,%eax
80104549:	39 c2                	cmp    %eax,%edx
8010454b:	75 f3                	jne    80104540 <allocproc+0x40>
  p->state = EMBRYO;
  p->pid = nextpid++;
8010454d:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80104552:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80104555:	c7 43 78 01 00 00 00 	movl   $0x1,0x78(%ebx)
  p->pid = nextpid++;
8010455c:	89 43 7c             	mov    %eax,0x7c(%ebx)
8010455f:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104562:	68 c0 43 11 80       	push   $0x801143c0
  p->pid = nextpid++;
80104567:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
8010456d:	e8 de 17 00 00       	call   80105d50 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
80104572:	e8 49 ee ff ff       	call   801033c0 <kalloc>
80104577:	83 c4 10             	add    $0x10,%esp
8010457a:	89 43 74             	mov    %eax,0x74(%ebx)
8010457d:	85 c0                	test   %eax,%eax
8010457f:	0f 84 a4 00 00 00    	je     80104629 <allocproc+0x129>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104585:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
8010458b:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010458e:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80104593:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
  *(uint *)sp = (uint)trapret;
80104599:	c7 40 14 40 75 10 80 	movl   $0x80107540,0x14(%eax)
  p->context = (struct context *)sp;
801045a0:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  memset(p->context, 0, sizeof *p->context);
801045a6:	6a 14                	push   $0x14
801045a8:	6a 00                	push   $0x0
801045aa:	50                   	push   %eax
801045ab:	e8 c0 18 00 00       	call   80105e70 <memset>
  p->context->eip = (uint)forkret;
801045b0:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
  p->sched_info.level = FCFS;
  p->sched_info.num_of_cycles = 0;
  


  return p;
801045b6:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801045b9:	c7 40 10 40 46 10 80 	movl   $0x80104640,0x10(%eax)
  p->sched_info.creation_time = ticks;
801045c0:	a1 00 87 11 80       	mov    0x80118700,%eax
  p->sched_info.burst_time = 2;
801045c5:	c7 83 f4 00 00 00 02 	movl   $0x2,0xf4(%ebx)
801045cc:	00 00 00 
  p->sched_info.creation_time = ticks;
801045cf:	89 83 fc 00 00 00    	mov    %eax,0xfc(%ebx)
  p->sched_info.enter_level_time = ticks;
801045d5:	89 83 00 01 00 00    	mov    %eax,0x100(%ebx)
}
801045db:	89 d8                	mov    %ebx,%eax
  p->sched_info.confidence = 50;
801045dd:	c7 83 04 01 00 00 32 	movl   $0x32,0x104(%ebx)
801045e4:	00 00 00 
  p->sched_info.last_exe_time = 0;
801045e7:	c7 83 f8 00 00 00 00 	movl   $0x0,0xf8(%ebx)
801045ee:	00 00 00 
  p->sched_info.level = FCFS;
801045f1:	c7 83 f0 00 00 00 02 	movl   $0x2,0xf0(%ebx)
801045f8:	00 00 00 
  p->sched_info.num_of_cycles = 0;
801045fb:	c7 83 08 01 00 00 00 	movl   $0x0,0x108(%ebx)
80104602:	00 00 00 
}
80104605:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104608:	c9                   	leave  
80104609:	c3                   	ret    
8010460a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104610:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104613:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104615:	68 c0 43 11 80       	push   $0x801143c0
8010461a:	e8 31 17 00 00       	call   80105d50 <release>
}
8010461f:	89 d8                	mov    %ebx,%eax
  return 0;
80104621:	83 c4 10             	add    $0x10,%esp
}
80104624:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104627:	c9                   	leave  
80104628:	c3                   	ret    
    p->state = UNUSED;
80104629:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return 0;
80104630:	31 db                	xor    %ebx,%ebx
}
80104632:	89 d8                	mov    %ebx,%eax
80104634:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104637:	c9                   	leave  
80104638:	c3                   	ret    
80104639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104640 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104646:	68 c0 43 11 80       	push   $0x801143c0
8010464b:	e8 00 17 00 00       	call   80105d50 <release>

  if (first)
80104650:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80104655:	83 c4 10             	add    $0x10,%esp
80104658:	85 c0                	test   %eax,%eax
8010465a:	75 04                	jne    80104660 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010465c:	c9                   	leave  
8010465d:	c3                   	ret    
8010465e:	66 90                	xchg   %ax,%ax
    first = 0;
80104660:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80104667:	00 00 00 
    iinit(ROOTDEV);
8010466a:	83 ec 0c             	sub    $0xc,%esp
8010466d:	6a 01                	push   $0x1
8010466f:	e8 1c dc ff ff       	call   80102290 <iinit>
    initlog(ROOTDEV);
80104674:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010467b:	e8 80 f3 ff ff       	call   80103a00 <initlog>
}
80104680:	83 c4 10             	add    $0x10,%esp
80104683:	c9                   	leave  
80104684:	c3                   	ret    
80104685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <pinit>:
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104696:	68 e0 94 10 80       	push   $0x801094e0
8010469b:	68 c0 43 11 80       	push   $0x801143c0
801046a0:	e8 3b 15 00 00       	call   80105be0 <initlock>
}
801046a5:	83 c4 10             	add    $0x10,%esp
801046a8:	c9                   	leave  
801046a9:	c3                   	ret    
801046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046b0 <mycpu>:
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046b5:	9c                   	pushf  
801046b6:	58                   	pop    %eax
  if (readeflags() & FL_IF)
801046b7:	f6 c4 02             	test   $0x2,%ah
801046ba:	75 46                	jne    80104702 <mycpu+0x52>
  apicid = lapicid();
801046bc:	e8 6f ef ff ff       	call   80103630 <lapicid>
  for (i = 0; i < ncpu; ++i)
801046c1:	8b 35 24 3e 11 80    	mov    0x80113e24,%esi
801046c7:	85 f6                	test   %esi,%esi
801046c9:	7e 2a                	jle    801046f5 <mycpu+0x45>
801046cb:	31 d2                	xor    %edx,%edx
801046cd:	eb 08                	jmp    801046d7 <mycpu+0x27>
801046cf:	90                   	nop
801046d0:	83 c2 01             	add    $0x1,%edx
801046d3:	39 f2                	cmp    %esi,%edx
801046d5:	74 1e                	je     801046f5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801046d7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801046dd:	0f b6 99 40 3e 11 80 	movzbl -0x7feec1c0(%ecx),%ebx
801046e4:	39 c3                	cmp    %eax,%ebx
801046e6:	75 e8                	jne    801046d0 <mycpu+0x20>
}
801046e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801046eb:	8d 81 40 3e 11 80    	lea    -0x7feec1c0(%ecx),%eax
}
801046f1:	5b                   	pop    %ebx
801046f2:	5e                   	pop    %esi
801046f3:	5d                   	pop    %ebp
801046f4:	c3                   	ret    
  panic("unknown apicid\n");
801046f5:	83 ec 0c             	sub    $0xc,%esp
801046f8:	68 e7 94 10 80       	push   $0x801094e7
801046fd:	e8 ee bd ff ff       	call   801004f0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104702:	83 ec 0c             	sub    $0xc,%esp
80104705:	68 20 96 10 80       	push   $0x80109620
8010470a:	e8 e1 bd ff ff       	call   801004f0 <panic>
8010470f:	90                   	nop

80104710 <cpuid>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80104716:	e8 95 ff ff ff       	call   801046b0 <mycpu>
}
8010471b:	c9                   	leave  
  return mycpu() - cpus;
8010471c:	2d 40 3e 11 80       	sub    $0x80113e40,%eax
80104721:	c1 f8 04             	sar    $0x4,%eax
80104724:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010472a:	c3                   	ret    
8010472b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010472f:	90                   	nop

80104730 <myproc>:
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	53                   	push   %ebx
80104734:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104737:	e8 24 15 00 00       	call   80105c60 <pushcli>
  c = mycpu();
8010473c:	e8 6f ff ff ff       	call   801046b0 <mycpu>
  p = c->proc;
80104741:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104747:	e8 64 15 00 00       	call   80105cb0 <popcli>
}
8010474c:	89 d8                	mov    %ebx,%eax
8010474e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104751:	c9                   	leave  
80104752:	c3                   	ret    
80104753:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010475a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104760 <findproc>:
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 75 08             	mov    0x8(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104768:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
  acquire(&ptable.lock);
8010476d:	83 ec 0c             	sub    $0xc,%esp
80104770:	68 c0 43 11 80       	push   $0x801143c0
80104775:	e8 36 16 00 00       	call   80105db0 <acquire>
8010477a:	83 c4 10             	add    $0x10,%esp
8010477d:	eb 0f                	jmp    8010478e <findproc+0x2e>
8010477f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104780:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80104786:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
8010478c:	74 22                	je     801047b0 <findproc+0x50>
    if (p->pid == pid)
8010478e:	39 73 7c             	cmp    %esi,0x7c(%ebx)
80104791:	75 ed                	jne    80104780 <findproc+0x20>
      release(&ptable.lock); // Release the lock before returning.
80104793:	83 ec 0c             	sub    $0xc,%esp
80104796:	68 c0 43 11 80       	push   $0x801143c0
8010479b:	e8 b0 15 00 00       	call   80105d50 <release>
      return p;
801047a0:	83 c4 10             	add    $0x10,%esp
}
801047a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047a6:	89 d8                	mov    %ebx,%eax
801047a8:	5b                   	pop    %ebx
801047a9:	5e                   	pop    %esi
801047aa:	5d                   	pop    %ebp
801047ab:	c3                   	ret    
801047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801047b0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801047b3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801047b5:	68 c0 43 11 80       	push   $0x801143c0
801047ba:	e8 91 15 00 00       	call   80105d50 <release>
  return 0;
801047bf:	83 c4 10             	add    $0x10,%esp
}
801047c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047c5:	89 d8                	mov    %ebx,%eax
801047c7:	5b                   	pop    %ebx
801047c8:	5e                   	pop    %esi
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    
801047cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047cf:	90                   	nop

801047d0 <growproc>:
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
801047d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801047d8:	e8 83 14 00 00       	call   80105c60 <pushcli>
  c = mycpu();
801047dd:	e8 ce fe ff ff       	call   801046b0 <mycpu>
  p = c->proc;
801047e2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047e8:	e8 c3 14 00 00       	call   80105cb0 <popcli>
  sz = curproc->sz;
801047ed:	8b 43 6c             	mov    0x6c(%ebx),%eax
  if (n > 0)
801047f0:	85 f6                	test   %esi,%esi
801047f2:	7f 1c                	jg     80104810 <growproc+0x40>
  else if (n < 0)
801047f4:	75 3a                	jne    80104830 <growproc+0x60>
  switchuvm(curproc);
801047f6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801047f9:	89 43 6c             	mov    %eax,0x6c(%ebx)
  switchuvm(curproc);
801047fc:	53                   	push   %ebx
801047fd:	e8 9e 3f 00 00       	call   801087a0 <switchuvm>
  return 0;
80104802:	83 c4 10             	add    $0x10,%esp
80104805:	31 c0                	xor    %eax,%eax
}
80104807:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010480a:	5b                   	pop    %ebx
8010480b:	5e                   	pop    %esi
8010480c:	5d                   	pop    %ebp
8010480d:	c3                   	ret    
8010480e:	66 90                	xchg   %ax,%ax
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104810:	83 ec 04             	sub    $0x4,%esp
80104813:	01 c6                	add    %eax,%esi
80104815:	56                   	push   %esi
80104816:	50                   	push   %eax
80104817:	ff 73 70             	push   0x70(%ebx)
8010481a:	e8 01 42 00 00       	call   80108a20 <allocuvm>
8010481f:	83 c4 10             	add    $0x10,%esp
80104822:	85 c0                	test   %eax,%eax
80104824:	75 d0                	jne    801047f6 <growproc+0x26>
      return -1;
80104826:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010482b:	eb da                	jmp    80104807 <growproc+0x37>
8010482d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104830:	83 ec 04             	sub    $0x4,%esp
80104833:	01 c6                	add    %eax,%esi
80104835:	56                   	push   %esi
80104836:	50                   	push   %eax
80104837:	ff 73 70             	push   0x70(%ebx)
8010483a:	e8 11 43 00 00       	call   80108b50 <deallocuvm>
8010483f:	83 c4 10             	add    $0x10,%esp
80104842:	85 c0                	test   %eax,%eax
80104844:	75 b0                	jne    801047f6 <growproc+0x26>
80104846:	eb de                	jmp    80104826 <growproc+0x56>
80104848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010484f:	90                   	nop

80104850 <create_rand_num>:
  return (ticks*ticks*ticks)%seed;
80104850:	8b 15 00 87 11 80    	mov    0x80118700,%edx
{
80104856:	55                   	push   %ebp
  return (ticks*ticks*ticks)%seed;
80104857:	89 d0                	mov    %edx,%eax
80104859:	0f af c2             	imul   %edx,%eax
{
8010485c:	89 e5                	mov    %esp,%ebp
  return (ticks*ticks*ticks)%seed;
8010485e:	0f af c2             	imul   %edx,%eax
80104861:	31 d2                	xor    %edx,%edx
80104863:	f7 75 08             	divl   0x8(%ebp)
}
80104866:	5d                   	pop    %ebp
80104867:	89 d0                	mov    %edx,%eax
80104869:	c3                   	ret    
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104870 <short_job_first>:
  return (ticks*ticks*ticks)%seed;
80104870:	a1 00 87 11 80       	mov    0x80118700,%eax
80104875:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
8010487a:	89 c1                	mov    %eax,%ecx
8010487c:	0f af c8             	imul   %eax,%ecx
8010487f:	0f af c8             	imul   %eax,%ecx
80104882:	89 c8                	mov    %ecx,%eax
80104884:	f7 e2                	mul    %edx
80104886:	c1 ea 05             	shr    $0x5,%edx
80104889:	6b c2 64             	imul   $0x64,%edx,%eax
8010488c:	89 ca                	mov    %ecx,%edx
  struct proc* res=0;
8010488e:	31 c9                	xor    %ecx,%ecx
  return (ticks*ticks*ticks)%seed;
80104890:	29 c2                	sub    %eax,%edx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104892:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
80104897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489e:	66 90                	xchg   %ax,%ax
    if((p->state != RUNNABLE) || (p->sched_info.level!=SJF))
801048a0:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
801048a4:	75 6a                	jne    80104910 <short_job_first+0xa0>
801048a6:	83 b8 f0 00 00 00 01 	cmpl   $0x1,0xf0(%eax)
801048ad:	75 61                	jne    80104910 <short_job_first+0xa0>
    if(res == 0)
801048af:	85 c9                	test   %ecx,%ecx
801048b1:	0f 44 c8             	cmove  %eax,%ecx
    if(p->sched_info.confidence > create_rand_num(100))
801048b4:	39 90 04 01 00 00    	cmp    %edx,0x104(%eax)
801048ba:	7e 54                	jle    80104910 <short_job_first+0xa0>
{
801048bc:	55                   	push   %ebp
801048bd:	89 e5                	mov    %esp,%ebp
801048bf:	53                   	push   %ebx
      if(p->sched_info.burst_time < res->sched_info.burst_time)
801048c0:	8b 99 f4 00 00 00    	mov    0xf4(%ecx),%ebx
801048c6:	39 98 f4 00 00 00    	cmp    %ebx,0xf4(%eax)
801048cc:	0f 4c c8             	cmovl  %eax,%ecx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
801048cf:	05 0c 01 00 00       	add    $0x10c,%eax
801048d4:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
801048d9:	74 28                	je     80104903 <short_job_first+0x93>
    if((p->state != RUNNABLE) || (p->sched_info.level!=SJF))
801048db:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
801048df:	75 ee                	jne    801048cf <short_job_first+0x5f>
801048e1:	83 b8 f0 00 00 00 01 	cmpl   $0x1,0xf0(%eax)
801048e8:	75 e5                	jne    801048cf <short_job_first+0x5f>
    if(res == 0)
801048ea:	85 c9                	test   %ecx,%ecx
801048ec:	0f 44 c8             	cmove  %eax,%ecx
    if(p->sched_info.confidence > create_rand_num(100))
801048ef:	39 90 04 01 00 00    	cmp    %edx,0x104(%eax)
801048f5:	7f c9                	jg     801048c0 <short_job_first+0x50>
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
801048f7:	05 0c 01 00 00       	add    $0x10c,%eax
801048fc:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
80104901:	75 d8                	jne    801048db <short_job_first+0x6b>
}
80104903:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104906:	89 c8                	mov    %ecx,%eax
80104908:	c9                   	leave  
80104909:	c3                   	ret    
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104910:	05 0c 01 00 00       	add    $0x10c,%eax
80104915:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010491a:	75 84                	jne    801048a0 <short_job_first+0x30>
}
8010491c:	89 c8                	mov    %ecx,%eax
8010491e:	c3                   	ret    
8010491f:	90                   	nop

80104920 <first_come_first_service>:
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104920:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
  struct proc* res=0;
80104925:	31 d2                	xor    %edx,%edx
80104927:	eb 23                	jmp    8010494c <first_come_first_service+0x2c>
80104929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if(p->sched_info.enter_level_time<res->sched_info.enter_level_time)
80104930:	8b 8a 00 01 00 00    	mov    0x100(%edx),%ecx
80104936:	39 88 00 01 00 00    	cmp    %ecx,0x100(%eax)
8010493c:	0f 42 d0             	cmovb  %eax,%edx
8010493f:	90                   	nop
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104940:	05 0c 01 00 00       	add    $0x10c,%eax
80104945:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010494a:	74 21                	je     8010496d <first_come_first_service+0x4d>
    if((p->state != RUNNABLE) || (p->sched_info.level!=FCFS))
8010494c:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
80104950:	75 ee                	jne    80104940 <first_come_first_service+0x20>
80104952:	83 b8 f0 00 00 00 02 	cmpl   $0x2,0xf0(%eax)
80104959:	75 e5                	jne    80104940 <first_come_first_service+0x20>
    if(res == 0)
8010495b:	85 d2                	test   %edx,%edx
8010495d:	75 d1                	jne    80104930 <first_come_first_service+0x10>
8010495f:	89 c2                	mov    %eax,%edx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104961:	05 0c 01 00 00       	add    $0x10c,%eax
80104966:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010496b:	75 df                	jne    8010494c <first_come_first_service+0x2c>
}
8010496d:	89 d0                	mov    %edx,%eax
8010496f:	c3                   	ret    

80104970 <set_level>:
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 75 08             	mov    0x8(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104978:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
  acquire(&ptable.lock);
8010497d:	83 ec 0c             	sub    $0xc,%esp
80104980:	68 c0 43 11 80       	push   $0x801143c0
80104985:	e8 26 14 00 00       	call   80105db0 <acquire>
8010498a:	83 c4 10             	add    $0x10,%esp
8010498d:	eb 0f                	jmp    8010499e <set_level+0x2e>
8010498f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104990:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80104996:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
8010499c:	74 4d                	je     801049eb <set_level+0x7b>
    if (p->pid == pid)
8010499e:	3b 73 7c             	cmp    0x7c(%ebx),%esi
801049a1:	75 ed                	jne    80104990 <set_level+0x20>
      release(&ptable.lock); // Release the lock before returning.
801049a3:	83 ec 0c             	sub    $0xc,%esp
801049a6:	68 c0 43 11 80       	push   $0x801143c0
801049ab:	e8 a0 13 00 00       	call   80105d50 <release>
  acquire(&ptable.lock);
801049b0:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
801049b7:	e8 f4 13 00 00       	call   80105db0 <acquire>
  p->sched_info.level = target_level;
801049bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int old_queue = p->sched_info.level;
801049bf:	8b b3 f0 00 00 00    	mov    0xf0(%ebx),%esi
  release(&ptable.lock);
801049c5:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
  p->sched_info.level = target_level;
801049cc:	89 83 f0 00 00 00    	mov    %eax,0xf0(%ebx)
  p->sched_info.enter_level_time = ticks;
801049d2:	a1 00 87 11 80       	mov    0x80118700,%eax
801049d7:	89 83 00 01 00 00    	mov    %eax,0x100(%ebx)
  release(&ptable.lock);
801049dd:	e8 6e 13 00 00       	call   80105d50 <release>
}
801049e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049e5:	89 f0                	mov    %esi,%eax
801049e7:	5b                   	pop    %ebx
801049e8:	5e                   	pop    %esi
801049e9:	5d                   	pop    %ebp
801049ea:	c3                   	ret    
  release(&ptable.lock);
801049eb:	83 ec 0c             	sub    $0xc,%esp
801049ee:	68 c0 43 11 80       	push   $0x801143c0
801049f3:	e8 58 13 00 00       	call   80105d50 <release>
  acquire(&ptable.lock);
801049f8:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
801049ff:	e8 ac 13 00 00       	call   80105db0 <acquire>
  int old_queue = p->sched_info.level;
80104a04:	a1 f0 00 00 00       	mov    0xf0,%eax
80104a09:	0f 0b                	ud2    
80104a0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a0f:	90                   	nop

80104a10 <userinit>:
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	53                   	push   %ebx
80104a14:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104a17:	e8 e4 fa ff ff       	call   80104500 <allocproc>
80104a1c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104a1e:	a3 f4 86 11 80       	mov    %eax,0x801186f4
  if ((p->pgdir = setupkvm()) == 0)
80104a23:	e8 d8 41 00 00       	call   80108c00 <setupkvm>
80104a28:	89 43 70             	mov    %eax,0x70(%ebx)
80104a2b:	85 c0                	test   %eax,%eax
80104a2d:	0f 84 e8 00 00 00    	je     80104b1b <userinit+0x10b>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104a33:	83 ec 04             	sub    $0x4,%esp
80104a36:	68 2c 00 00 00       	push   $0x2c
80104a3b:	68 c0 c4 10 80       	push   $0x8010c4c0
80104a40:	50                   	push   %eax
80104a41:	e8 6a 3e 00 00       	call   801088b0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104a46:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104a49:	c7 43 6c 00 10 00 00 	movl   $0x1000,0x6c(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104a50:	6a 4c                	push   $0x4c
80104a52:	6a 00                	push   $0x0
80104a54:	ff b3 84 00 00 00    	push   0x84(%ebx)
80104a5a:	e8 11 14 00 00       	call   80105e70 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104a5f:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104a65:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104a6a:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104a6d:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104a72:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104a76:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104a7c:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104a80:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104a86:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104a8a:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104a8e:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104a94:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104a98:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104a9c:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104aa2:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104aa9:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104aaf:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80104ab6:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104abc:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104ac3:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
80104ac9:	6a 18                	push   $0x18
80104acb:	68 10 95 10 80       	push   $0x80109510
80104ad0:	50                   	push   %eax
80104ad1:	e8 5a 15 00 00       	call   80106030 <safestrcpy>
  p->cwd = namei("/");
80104ad6:	c7 04 24 19 95 10 80 	movl   $0x80109519,(%esp)
80104add:	e8 fe e2 ff ff       	call   80102de0 <namei>
80104ae2:	89 83 d4 00 00 00    	mov    %eax,0xd4(%ebx)
  acquire(&ptable.lock);
80104ae8:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104aef:	e8 bc 12 00 00       	call   80105db0 <acquire>
  p->state = RUNNABLE;
80104af4:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  release(&ptable.lock);
80104afb:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104b02:	e8 49 12 00 00       	call   80105d50 <release>
  set_level(p->pid, ROUND_ROBIN);
80104b07:	58                   	pop    %eax
80104b08:	5a                   	pop    %edx
80104b09:	6a 00                	push   $0x0
80104b0b:	ff 73 7c             	push   0x7c(%ebx)
80104b0e:	e8 5d fe ff ff       	call   80104970 <set_level>
}
80104b13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b16:	83 c4 10             	add    $0x10,%esp
80104b19:	c9                   	leave  
80104b1a:	c3                   	ret    
    panic("userinit: out of memory?");
80104b1b:	83 ec 0c             	sub    $0xc,%esp
80104b1e:	68 f7 94 10 80       	push   $0x801094f7
80104b23:	e8 c8 b9 ff ff       	call   801004f0 <panic>
80104b28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b2f:	90                   	nop

80104b30 <fork>:
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	57                   	push   %edi
80104b34:	56                   	push   %esi
80104b35:	53                   	push   %ebx
80104b36:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104b39:	e8 22 11 00 00       	call   80105c60 <pushcli>
  c = mycpu();
80104b3e:	e8 6d fb ff ff       	call   801046b0 <mycpu>
  p = c->proc;
80104b43:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b49:	e8 62 11 00 00       	call   80105cb0 <popcli>
  if ((np = allocproc()) == 0)
80104b4e:	e8 ad f9 ff ff       	call   80104500 <allocproc>
80104b53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104b56:	85 c0                	test   %eax,%eax
80104b58:	0f 84 fb 00 00 00    	je     80104c59 <fork+0x129>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80104b5e:	83 ec 08             	sub    $0x8,%esp
80104b61:	ff 73 6c             	push   0x6c(%ebx)
80104b64:	89 c7                	mov    %eax,%edi
80104b66:	ff 73 70             	push   0x70(%ebx)
80104b69:	e8 82 41 00 00       	call   80108cf0 <copyuvm>
80104b6e:	83 c4 10             	add    $0x10,%esp
80104b71:	89 47 70             	mov    %eax,0x70(%edi)
80104b74:	85 c0                	test   %eax,%eax
80104b76:	0f 84 e4 00 00 00    	je     80104c60 <fork+0x130>
  np->sz = curproc->sz;
80104b7c:	8b 43 6c             	mov    0x6c(%ebx),%eax
80104b7f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104b82:	89 41 6c             	mov    %eax,0x6c(%ecx)
  *np->tf = *curproc->tf;
80104b85:	8b b9 84 00 00 00    	mov    0x84(%ecx),%edi
  np->parent = curproc;
80104b8b:	89 c8                	mov    %ecx,%eax
80104b8d:	89 99 80 00 00 00    	mov    %ebx,0x80(%ecx)
  *np->tf = *curproc->tf;
80104b93:	b9 13 00 00 00       	mov    $0x13,%ecx
80104b98:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
80104b9e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80104ba0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104ba2:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104ba8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (i = 0; i < NOFILE; i++)
80104baf:	90                   	nop
    if (curproc->ofile[i])
80104bb0:	8b 84 b3 94 00 00 00 	mov    0x94(%ebx,%esi,4),%eax
80104bb7:	85 c0                	test   %eax,%eax
80104bb9:	74 16                	je     80104bd1 <fork+0xa1>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104bbb:	83 ec 0c             	sub    $0xc,%esp
80104bbe:	50                   	push   %eax
80104bbf:	e8 0c d0 ff ff       	call   80101bd0 <filedup>
80104bc4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	89 84 b2 94 00 00 00 	mov    %eax,0x94(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
80104bd1:	83 c6 01             	add    $0x1,%esi
80104bd4:	83 fe 10             	cmp    $0x10,%esi
80104bd7:	75 d7                	jne    80104bb0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80104bd9:	83 ec 0c             	sub    $0xc,%esp
80104bdc:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104be2:	81 c3 d8 00 00 00    	add    $0xd8,%ebx
  np->cwd = idup(curproc->cwd);
80104be8:	e8 93 d8 ff ff       	call   80102480 <idup>
80104bed:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104bf0:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104bf3:	89 87 d4 00 00 00    	mov    %eax,0xd4(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104bf9:	8d 87 d8 00 00 00    	lea    0xd8(%edi),%eax
80104bff:	6a 18                	push   $0x18
80104c01:	53                   	push   %ebx
80104c02:	50                   	push   %eax
80104c03:	e8 28 14 00 00       	call   80106030 <safestrcpy>
  pid = np->pid;
80104c08:	8b 5f 7c             	mov    0x7c(%edi),%ebx
  acquire(&ptable.lock);
80104c0b:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104c12:	e8 99 11 00 00       	call   80105db0 <acquire>
  np->state = RUNNABLE;
80104c17:	c7 47 78 03 00 00 00 	movl   $0x3,0x78(%edi)
  release(&ptable.lock);
80104c1e:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104c25:	e8 26 11 00 00       	call   80105d50 <release>
  if(pid==2)
80104c2a:	83 c4 10             	add    $0x10,%esp
80104c2d:	83 fb 02             	cmp    $0x2,%ebx
80104c30:	74 0e                	je     80104c40 <fork+0x110>
}
80104c32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c35:	89 d8                	mov    %ebx,%eax
80104c37:	5b                   	pop    %ebx
80104c38:	5e                   	pop    %esi
80104c39:	5f                   	pop    %edi
80104c3a:	5d                   	pop    %ebp
80104c3b:	c3                   	ret    
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    set_level(pid, ROUND_ROBIN);
80104c40:	83 ec 08             	sub    $0x8,%esp
80104c43:	6a 00                	push   $0x0
80104c45:	6a 02                	push   $0x2
80104c47:	e8 24 fd ff ff       	call   80104970 <set_level>
80104c4c:	83 c4 10             	add    $0x10,%esp
}
80104c4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c52:	89 d8                	mov    %ebx,%eax
80104c54:	5b                   	pop    %ebx
80104c55:	5e                   	pop    %esi
80104c56:	5f                   	pop    %edi
80104c57:	5d                   	pop    %ebp
80104c58:	c3                   	ret    
    return -1;
80104c59:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104c5e:	eb d2                	jmp    80104c32 <fork+0x102>
    kfree(np->kstack);
80104c60:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104c63:	83 ec 0c             	sub    $0xc,%esp
80104c66:	ff 73 74             	push   0x74(%ebx)
80104c69:	e8 92 e5 ff ff       	call   80103200 <kfree>
    np->kstack = 0;
80104c6e:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
    return -1;
80104c75:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104c78:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return -1;
80104c7f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104c84:	eb ac                	jmp    80104c32 <fork+0x102>
80104c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8d:	8d 76 00             	lea    0x0(%esi),%esi

80104c90 <aging>:
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c94:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
{
80104c99:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80104c9c:	68 c0 43 11 80       	push   $0x801143c0
80104ca1:	e8 0a 11 00 00       	call   80105db0 <acquire>
80104ca6:	83 c4 10             	add    $0x10,%esp
80104ca9:	eb 13                	jmp    80104cbe <aging+0x2e>
80104cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104caf:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cb0:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80104cb6:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80104cbc:	74 7f                	je     80104d3d <aging+0xad>
    if (p->state == RUNNABLE)
80104cbe:	83 7b 78 03          	cmpl   $0x3,0x78(%ebx)
80104cc2:	75 ec                	jne    80104cb0 <aging+0x20>
      if( p->sched_info.level == ROUND_ROBIN)
80104cc4:	8b 83 f0 00 00 00    	mov    0xf0(%ebx),%eax
80104cca:	85 c0                	test   %eax,%eax
80104ccc:	74 e2                	je     80104cb0 <aging+0x20>
      if ((ticks - p->sched_info.last_exe_time > STARVATION_THRESHOLD) && (ticks - p->sched_info.enter_level_time > STARVATION_THRESHOLD))
80104cce:	a1 00 87 11 80       	mov    0x80118700,%eax
80104cd3:	89 c2                	mov    %eax,%edx
80104cd5:	2b 93 f8 00 00 00    	sub    0xf8(%ebx),%edx
80104cdb:	81 fa 20 03 00 00    	cmp    $0x320,%edx
80104ce1:	76 cd                	jbe    80104cb0 <aging+0x20>
80104ce3:	2b 83 00 01 00 00    	sub    0x100(%ebx),%eax
80104ce9:	3d 20 03 00 00       	cmp    $0x320,%eax
80104cee:	76 c0                	jbe    80104cb0 <aging+0x20>
          release(&ptable.lock);
80104cf0:	83 ec 0c             	sub    $0xc,%esp
80104cf3:	68 c0 43 11 80       	push   $0x801143c0
80104cf8:	e8 53 10 00 00       	call   80105d50 <release>
          if(p->sched_info.level == SJF)
80104cfd:	8b 83 f0 00 00 00    	mov    0xf0(%ebx),%eax
80104d03:	83 c4 10             	add    $0x10,%esp
80104d06:	83 f8 01             	cmp    $0x1,%eax
80104d09:	74 47                	je     80104d52 <aging+0xc2>
          else if(p->sched_info.level == FCFS)
80104d0b:	83 f8 02             	cmp    $0x2,%eax
80104d0e:	74 54                	je     80104d64 <aging+0xd4>
          cprintf("pid: %d starved!\n", p->pid);
80104d10:	83 ec 08             	sub    $0x8,%esp
80104d13:	ff 73 7c             	push   0x7c(%ebx)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d16:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
          cprintf("pid: %d starved!\n", p->pid);
80104d1c:	68 1b 95 10 80       	push   $0x8010951b
80104d21:	e8 4a bd ff ff       	call   80100a70 <cprintf>
          acquire(&ptable.lock);
80104d26:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104d2d:	e8 7e 10 00 00       	call   80105db0 <acquire>
80104d32:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d35:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80104d3b:	75 81                	jne    80104cbe <aging+0x2e>
  release(&ptable.lock);
80104d3d:	83 ec 0c             	sub    $0xc,%esp
80104d40:	68 c0 43 11 80       	push   $0x801143c0
80104d45:	e8 06 10 00 00       	call   80105d50 <release>
}
80104d4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d4d:	83 c4 10             	add    $0x10,%esp
80104d50:	c9                   	leave  
80104d51:	c3                   	ret    
            set_level(p->pid, ROUND_ROBIN);
80104d52:	83 ec 08             	sub    $0x8,%esp
80104d55:	6a 00                	push   $0x0
80104d57:	ff 73 7c             	push   0x7c(%ebx)
80104d5a:	e8 11 fc ff ff       	call   80104970 <set_level>
80104d5f:	83 c4 10             	add    $0x10,%esp
80104d62:	eb ac                	jmp    80104d10 <aging+0x80>
            set_level(p->pid, SJF);
80104d64:	83 ec 08             	sub    $0x8,%esp
80104d67:	6a 01                	push   $0x1
80104d69:	ff 73 7c             	push   0x7c(%ebx)
80104d6c:	e8 ff fb ff ff       	call   80104970 <set_level>
80104d71:	83 c4 10             	add    $0x10,%esp
80104d74:	eb 9a                	jmp    80104d10 <aging+0x80>
80104d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi

80104d80 <round_robin>:
{
80104d80:	55                   	push   %ebp
      p = ptable.proc;
80104d81:	b9 f4 43 11 80       	mov    $0x801143f4,%ecx
{
80104d86:	89 e5                	mov    %esp,%ebp
80104d88:	8b 55 08             	mov    0x8(%ebp),%edx
  struct proc *p = last_scheduled;
80104d8b:	89 d0                	mov    %edx,%eax
80104d8d:	eb 05                	jmp    80104d94 <round_robin+0x14>
80104d8f:	90                   	nop
    if (p == last_scheduled)
80104d90:	39 d0                	cmp    %edx,%eax
80104d92:	74 24                	je     80104db8 <round_robin+0x38>
    p++;
80104d94:	05 0c 01 00 00       	add    $0x10c,%eax
      p = ptable.proc;
80104d99:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
80104d9e:	0f 43 c1             	cmovae %ecx,%eax
    if (p->state == RUNNABLE && p->sched_info.level == ROUND_ROBIN)
80104da1:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
80104da5:	75 e9                	jne    80104d90 <round_robin+0x10>
80104da7:	83 b8 f0 00 00 00 00 	cmpl   $0x0,0xf0(%eax)
80104dae:	75 e0                	jne    80104d90 <round_robin+0x10>
}
80104db0:	5d                   	pop    %ebp
80104db1:	c3                   	ret    
80104db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return 0;
80104db8:	31 c0                	xor    %eax,%eax
}
80104dba:	5d                   	pop    %ebp
80104dbb:	c3                   	ret    
80104dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104dc0 <scheduler>:
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	57                   	push   %edi
      p = ptable.proc;
80104dc4:	bf f4 43 11 80       	mov    $0x801143f4,%edi
{
80104dc9:	56                   	push   %esi
  struct proc *last_scheduled_RR = &ptable.proc[NPROC - 1];
80104dca:	be e8 85 11 80       	mov    $0x801185e8,%esi
{
80104dcf:	53                   	push   %ebx
80104dd0:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80104dd3:	e8 d8 f8 ff ff       	call   801046b0 <mycpu>
  c->proc = 0;
80104dd8:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104ddf:	00 00 00 
  struct cpu *c = mycpu();
80104de2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c->proc = 0;
80104de5:	83 c0 04             	add    $0x4,%eax
80104de8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104def:	90                   	nop
  asm volatile("sti");
80104df0:	fb                   	sti    
    acquire(&ptable.lock);
80104df1:	83 ec 0c             	sub    $0xc,%esp
80104df4:	89 f3                	mov    %esi,%ebx
80104df6:	68 c0 43 11 80       	push   $0x801143c0
80104dfb:	e8 b0 0f 00 00       	call   80105db0 <acquire>
80104e00:	83 c4 10             	add    $0x10,%esp
80104e03:	eb 0b                	jmp    80104e10 <scheduler+0x50>
80104e05:	8d 76 00             	lea    0x0(%esi),%esi
    if (p == last_scheduled)
80104e08:	39 de                	cmp    %ebx,%esi
80104e0a:	0f 84 80 00 00 00    	je     80104e90 <scheduler+0xd0>
    p++;
80104e10:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
      p = ptable.proc;
80104e16:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80104e1c:	0f 43 df             	cmovae %edi,%ebx
    if (p->state == RUNNABLE && p->sched_info.level == ROUND_ROBIN)
80104e1f:	83 7b 78 03          	cmpl   $0x3,0x78(%ebx)
80104e23:	75 e3                	jne    80104e08 <scheduler+0x48>
80104e25:	8b 8b f0 00 00 00    	mov    0xf0(%ebx),%ecx
80104e2b:	85 c9                	test   %ecx,%ecx
80104e2d:	75 d9                	jne    80104e08 <scheduler+0x48>
80104e2f:	89 de                	mov    %ebx,%esi
    c->proc = p;
80104e31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    switchuvm(p);
80104e34:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
80104e37:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
    switchuvm(p);
80104e3d:	53                   	push   %ebx
80104e3e:	e8 5d 39 00 00       	call   801087a0 <switchuvm>
    p->sched_info.last_exe_time = ticks;
80104e43:	a1 00 87 11 80       	mov    0x80118700,%eax
    p->state = RUNNING;
80104e48:	c7 43 78 04 00 00 00 	movl   $0x4,0x78(%ebx)
    p->sched_info.last_exe_time = ticks;
80104e4f:	89 83 f8 00 00 00    	mov    %eax,0xf8(%ebx)
    swtch(&(c->scheduler), p->context);
80104e55:	58                   	pop    %eax
80104e56:	5a                   	pop    %edx
80104e57:	ff b3 88 00 00 00    	push   0x88(%ebx)
80104e5d:	ff 75 e0             	push   -0x20(%ebp)
80104e60:	e8 26 12 00 00       	call   8010608b <swtch>
    switchkvm();
80104e65:	e8 26 39 00 00       	call   80108790 <switchkvm>
    c->proc = 0;
80104e6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104e6d:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104e74:	00 00 00 
  release(&ptable.lock);
80104e77:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80104e7e:	e8 cd 0e 00 00       	call   80105d50 <release>
80104e83:	83 c4 10             	add    $0x10,%esp
80104e86:	e9 65 ff ff ff       	jmp    80104df0 <scheduler+0x30>
80104e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e8f:	90                   	nop
      p = short_job_first();
80104e90:	e8 db f9 ff ff       	call   80104870 <short_job_first>
80104e95:	89 c3                	mov    %eax,%ebx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104e97:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
      if (!p)
80104e9c:	85 db                	test   %ebx,%ebx
80104e9e:	75 91                	jne    80104e31 <scheduler+0x71>
80104ea0:	eb 2a                	jmp    80104ecc <scheduler+0x10c>
80104ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if(p->sched_info.enter_level_time<res->sched_info.enter_level_time)
80104ea8:	8b 93 00 01 00 00    	mov    0x100(%ebx),%edx
80104eae:	39 90 00 01 00 00    	cmp    %edx,0x100(%eax)
80104eb4:	0f 42 d8             	cmovb  %eax,%ebx
80104eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ebe:	66 90                	xchg   %ax,%ax
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104ec0:	05 0c 01 00 00       	add    $0x10c,%eax
80104ec5:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
80104eca:	74 24                	je     80104ef0 <scheduler+0x130>
    if((p->state != RUNNABLE) || (p->sched_info.level!=FCFS))
80104ecc:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
80104ed0:	75 ee                	jne    80104ec0 <scheduler+0x100>
80104ed2:	83 b8 f0 00 00 00 02 	cmpl   $0x2,0xf0(%eax)
80104ed9:	75 e5                	jne    80104ec0 <scheduler+0x100>
    if(res == 0)
80104edb:	85 db                	test   %ebx,%ebx
80104edd:	75 c9                	jne    80104ea8 <scheduler+0xe8>
80104edf:	89 c3                	mov    %eax,%ebx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104ee1:	05 0c 01 00 00       	add    $0x10c,%eax
80104ee6:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
80104eeb:	75 df                	jne    80104ecc <scheduler+0x10c>
80104eed:	8d 76 00             	lea    0x0(%esi),%esi
        if (!p)
80104ef0:	85 db                	test   %ebx,%ebx
80104ef2:	0f 85 39 ff ff ff    	jne    80104e31 <scheduler+0x71>
          release(&ptable.lock);
80104ef8:	83 ec 0c             	sub    $0xc,%esp
80104efb:	68 c0 43 11 80       	push   $0x801143c0
80104f00:	e8 4b 0e 00 00       	call   80105d50 <release>
          continue;
80104f05:	83 c4 10             	add    $0x10,%esp
80104f08:	e9 e3 fe ff ff       	jmp    80104df0 <scheduler+0x30>
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi

80104f10 <sched>:
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
  pushcli();
80104f15:	e8 46 0d 00 00       	call   80105c60 <pushcli>
  c = mycpu();
80104f1a:	e8 91 f7 ff ff       	call   801046b0 <mycpu>
  p = c->proc;
80104f1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104f25:	e8 86 0d 00 00       	call   80105cb0 <popcli>
  if (!holding(&ptable.lock))
80104f2a:	83 ec 0c             	sub    $0xc,%esp
80104f2d:	68 c0 43 11 80       	push   $0x801143c0
80104f32:	e8 d9 0d 00 00       	call   80105d10 <holding>
80104f37:	83 c4 10             	add    $0x10,%esp
80104f3a:	85 c0                	test   %eax,%eax
80104f3c:	74 52                	je     80104f90 <sched+0x80>
  if (mycpu()->ncli != 1)
80104f3e:	e8 6d f7 ff ff       	call   801046b0 <mycpu>
80104f43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104f4a:	75 6b                	jne    80104fb7 <sched+0xa7>
  if (p->state == RUNNING)
80104f4c:	83 7b 78 04          	cmpl   $0x4,0x78(%ebx)
80104f50:	74 58                	je     80104faa <sched+0x9a>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104f52:	9c                   	pushf  
80104f53:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80104f54:	f6 c4 02             	test   $0x2,%ah
80104f57:	75 44                	jne    80104f9d <sched+0x8d>
  intena = mycpu()->intena;
80104f59:	e8 52 f7 ff ff       	call   801046b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104f5e:	81 c3 88 00 00 00    	add    $0x88,%ebx
  intena = mycpu()->intena;
80104f64:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104f6a:	e8 41 f7 ff ff       	call   801046b0 <mycpu>
80104f6f:	83 ec 08             	sub    $0x8,%esp
80104f72:	ff 70 04             	push   0x4(%eax)
80104f75:	53                   	push   %ebx
80104f76:	e8 10 11 00 00       	call   8010608b <swtch>
  mycpu()->intena = intena;
80104f7b:	e8 30 f7 ff ff       	call   801046b0 <mycpu>
}
80104f80:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104f83:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104f89:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f8c:	5b                   	pop    %ebx
80104f8d:	5e                   	pop    %esi
80104f8e:	5d                   	pop    %ebp
80104f8f:	c3                   	ret    
    panic("sched ptable.lock");
80104f90:	83 ec 0c             	sub    $0xc,%esp
80104f93:	68 2d 95 10 80       	push   $0x8010952d
80104f98:	e8 53 b5 ff ff       	call   801004f0 <panic>
    panic("sched interruptible");
80104f9d:	83 ec 0c             	sub    $0xc,%esp
80104fa0:	68 59 95 10 80       	push   $0x80109559
80104fa5:	e8 46 b5 ff ff       	call   801004f0 <panic>
    panic("sched running");
80104faa:	83 ec 0c             	sub    $0xc,%esp
80104fad:	68 4b 95 10 80       	push   $0x8010954b
80104fb2:	e8 39 b5 ff ff       	call   801004f0 <panic>
    panic("sched locks");
80104fb7:	83 ec 0c             	sub    $0xc,%esp
80104fba:	68 3f 95 10 80       	push   $0x8010953f
80104fbf:	e8 2c b5 ff ff       	call   801004f0 <panic>
80104fc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop

80104fd0 <exit>:
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	57                   	push   %edi
80104fd4:	56                   	push   %esi
80104fd5:	53                   	push   %ebx
80104fd6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104fd9:	e8 52 f7 ff ff       	call   80104730 <myproc>
  if (curproc == initproc)
80104fde:	39 05 f4 86 11 80    	cmp    %eax,0x801186f4
80104fe4:	0f 84 22 01 00 00    	je     8010510c <exit+0x13c>
80104fea:	89 c3                	mov    %eax,%ebx
80104fec:	8d b0 94 00 00 00    	lea    0x94(%eax),%esi
80104ff2:	8d b8 d4 00 00 00    	lea    0xd4(%eax),%edi
80104ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fff:	90                   	nop
    if (curproc->ofile[fd])
80105000:	8b 06                	mov    (%esi),%eax
80105002:	85 c0                	test   %eax,%eax
80105004:	74 12                	je     80105018 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80105006:	83 ec 0c             	sub    $0xc,%esp
80105009:	50                   	push   %eax
8010500a:	e8 11 cc ff ff       	call   80101c20 <fileclose>
      curproc->ofile[fd] = 0;
8010500f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80105015:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
80105018:	83 c6 04             	add    $0x4,%esi
8010501b:	39 f7                	cmp    %esi,%edi
8010501d:	75 e1                	jne    80105000 <exit+0x30>
  begin_op();
8010501f:	e8 7c ea ff ff       	call   80103aa0 <begin_op>
  iput(curproc->cwd);
80105024:	83 ec 0c             	sub    $0xc,%esp
80105027:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
8010502d:	e8 ae d5 ff ff       	call   801025e0 <iput>
  end_op();
80105032:	e8 d9 ea ff ff       	call   80103b10 <end_op>
  curproc->cwd = 0;
80105037:	c7 83 d4 00 00 00 00 	movl   $0x0,0xd4(%ebx)
8010503e:	00 00 00 
  acquire(&ptable.lock);
80105041:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80105048:	e8 63 0d 00 00       	call   80105db0 <acquire>
  wakeup1(curproc->parent);
8010504d:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
80105053:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105056:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
8010505b:	eb 0f                	jmp    8010506c <exit+0x9c>
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
80105060:	05 0c 01 00 00       	add    $0x10c,%eax
80105065:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010506a:	74 21                	je     8010508d <exit+0xbd>
    if (p->state == SLEEPING && p->chan == chan)
8010506c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80105070:	75 ee                	jne    80105060 <exit+0x90>
80105072:	3b 90 8c 00 00 00    	cmp    0x8c(%eax),%edx
80105078:	75 e6                	jne    80105060 <exit+0x90>
      p->state = RUNNABLE;
8010507a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105081:	05 0c 01 00 00       	add    $0x10c,%eax
80105086:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010508b:	75 df                	jne    8010506c <exit+0x9c>
      p->parent = initproc;
8010508d:	8b 0d f4 86 11 80    	mov    0x801186f4,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105093:	ba f4 43 11 80       	mov    $0x801143f4,%edx
80105098:	eb 14                	jmp    801050ae <exit+0xde>
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050a0:	81 c2 0c 01 00 00    	add    $0x10c,%edx
801050a6:	81 fa f4 86 11 80    	cmp    $0x801186f4,%edx
801050ac:	74 45                	je     801050f3 <exit+0x123>
    if (p->parent == curproc)
801050ae:	39 9a 80 00 00 00    	cmp    %ebx,0x80(%edx)
801050b4:	75 ea                	jne    801050a0 <exit+0xd0>
      if (p->state == ZOMBIE)
801050b6:	83 7a 78 05          	cmpl   $0x5,0x78(%edx)
      p->parent = initproc;
801050ba:	89 8a 80 00 00 00    	mov    %ecx,0x80(%edx)
      if (p->state == ZOMBIE)
801050c0:	75 de                	jne    801050a0 <exit+0xd0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801050c2:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
801050c7:	eb 13                	jmp    801050dc <exit+0x10c>
801050c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050d0:	05 0c 01 00 00       	add    $0x10c,%eax
801050d5:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
801050da:	74 c4                	je     801050a0 <exit+0xd0>
    if (p->state == SLEEPING && p->chan == chan)
801050dc:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
801050e0:	75 ee                	jne    801050d0 <exit+0x100>
801050e2:	3b 88 8c 00 00 00    	cmp    0x8c(%eax),%ecx
801050e8:	75 e6                	jne    801050d0 <exit+0x100>
      p->state = RUNNABLE;
801050ea:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
801050f1:	eb dd                	jmp    801050d0 <exit+0x100>
  curproc->state = ZOMBIE;
801050f3:	c7 43 78 05 00 00 00 	movl   $0x5,0x78(%ebx)
  sched();
801050fa:	e8 11 fe ff ff       	call   80104f10 <sched>
  panic("zombie exit");
801050ff:	83 ec 0c             	sub    $0xc,%esp
80105102:	68 7a 95 10 80       	push   $0x8010957a
80105107:	e8 e4 b3 ff ff       	call   801004f0 <panic>
    panic("init exiting");
8010510c:	83 ec 0c             	sub    $0xc,%esp
8010510f:	68 6d 95 10 80       	push   $0x8010956d
80105114:	e8 d7 b3 ff ff       	call   801004f0 <panic>
80105119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105120 <wait>:
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	56                   	push   %esi
80105124:	53                   	push   %ebx
  pushcli();
80105125:	e8 36 0b 00 00       	call   80105c60 <pushcli>
  c = mycpu();
8010512a:	e8 81 f5 ff ff       	call   801046b0 <mycpu>
  p = c->proc;
8010512f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80105135:	e8 76 0b 00 00       	call   80105cb0 <popcli>
  acquire(&ptable.lock);
8010513a:	83 ec 0c             	sub    $0xc,%esp
8010513d:	68 c0 43 11 80       	push   $0x801143c0
80105142:	e8 69 0c 00 00       	call   80105db0 <acquire>
80105147:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010514a:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010514c:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
80105151:	eb 13                	jmp    80105166 <wait+0x46>
80105153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105157:	90                   	nop
80105158:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
8010515e:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80105164:	74 21                	je     80105187 <wait+0x67>
      if (p->parent != curproc)
80105166:	39 b3 80 00 00 00    	cmp    %esi,0x80(%ebx)
8010516c:	75 ea                	jne    80105158 <wait+0x38>
      if (p->state == ZOMBIE)
8010516e:	83 7b 78 05          	cmpl   $0x5,0x78(%ebx)
80105172:	74 6c                	je     801051e0 <wait+0xc0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105174:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
      havekids = 1;
8010517a:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010517f:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80105185:	75 df                	jne    80105166 <wait+0x46>
    if (!havekids || curproc->killed)
80105187:	85 c0                	test   %eax,%eax
80105189:	0f 84 b0 00 00 00    	je     8010523f <wait+0x11f>
8010518f:	8b 86 90 00 00 00    	mov    0x90(%esi),%eax
80105195:	85 c0                	test   %eax,%eax
80105197:	0f 85 a2 00 00 00    	jne    8010523f <wait+0x11f>
  pushcli();
8010519d:	e8 be 0a 00 00       	call   80105c60 <pushcli>
  c = mycpu();
801051a2:	e8 09 f5 ff ff       	call   801046b0 <mycpu>
  p = c->proc;
801051a7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801051ad:	e8 fe 0a 00 00       	call   80105cb0 <popcli>
  if (p == 0)
801051b2:	85 db                	test   %ebx,%ebx
801051b4:	0f 84 9c 00 00 00    	je     80105256 <wait+0x136>
  p->chan = chan;
801051ba:	89 b3 8c 00 00 00    	mov    %esi,0x8c(%ebx)
  p->state = SLEEPING;
801051c0:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
801051c7:	e8 44 fd ff ff       	call   80104f10 <sched>
  p->chan = 0;
801051cc:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801051d3:	00 00 00 
}
801051d6:	e9 6f ff ff ff       	jmp    8010514a <wait+0x2a>
801051db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051df:	90                   	nop
        kfree(p->kstack);
801051e0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801051e3:	8b 73 7c             	mov    0x7c(%ebx),%esi
        kfree(p->kstack);
801051e6:	ff 73 74             	push   0x74(%ebx)
801051e9:	e8 12 e0 ff ff       	call   80103200 <kfree>
        p->kstack = 0;
801051ee:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
        freevm(p->pgdir);
801051f5:	5a                   	pop    %edx
801051f6:	ff 73 70             	push   0x70(%ebx)
801051f9:	e8 82 39 00 00       	call   80108b80 <freevm>
        p->pid = 0;
801051fe:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
        p->parent = 0;
80105205:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010520c:	00 00 00 
        p->name[0] = 0;
8010520f:	c6 83 d8 00 00 00 00 	movb   $0x0,0xd8(%ebx)
        p->killed = 0;
80105216:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
8010521d:	00 00 00 
        p->state = UNUSED;
80105220:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
        release(&ptable.lock);
80105227:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
8010522e:	e8 1d 0b 00 00       	call   80105d50 <release>
        return pid;
80105233:	83 c4 10             	add    $0x10,%esp
}
80105236:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105239:	89 f0                	mov    %esi,%eax
8010523b:	5b                   	pop    %ebx
8010523c:	5e                   	pop    %esi
8010523d:	5d                   	pop    %ebp
8010523e:	c3                   	ret    
      release(&ptable.lock);
8010523f:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80105242:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80105247:	68 c0 43 11 80       	push   $0x801143c0
8010524c:	e8 ff 0a 00 00       	call   80105d50 <release>
      return -1;
80105251:	83 c4 10             	add    $0x10,%esp
80105254:	eb e0                	jmp    80105236 <wait+0x116>
    panic("sleep");
80105256:	83 ec 0c             	sub    $0xc,%esp
80105259:	68 86 95 10 80       	push   $0x80109586
8010525e:	e8 8d b2 ff ff       	call   801004f0 <panic>
80105263:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105270 <yield>:
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	53                   	push   %ebx
80105274:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
80105277:	68 c0 43 11 80       	push   $0x801143c0
8010527c:	e8 2f 0b 00 00       	call   80105db0 <acquire>
  pushcli();
80105281:	e8 da 09 00 00       	call   80105c60 <pushcli>
  c = mycpu();
80105286:	e8 25 f4 ff ff       	call   801046b0 <mycpu>
  p = c->proc;
8010528b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105291:	e8 1a 0a 00 00       	call   80105cb0 <popcli>
  myproc()->state = RUNNABLE;
80105296:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  sched();
8010529d:	e8 6e fc ff ff       	call   80104f10 <sched>
  release(&ptable.lock);
801052a2:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
801052a9:	e8 a2 0a 00 00       	call   80105d50 <release>
}
801052ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052b1:	83 c4 10             	add    $0x10,%esp
801052b4:	c9                   	leave  
801052b5:	c3                   	ret    
801052b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <sleep>:
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	57                   	push   %edi
801052c4:	56                   	push   %esi
801052c5:	53                   	push   %ebx
801052c6:	83 ec 0c             	sub    $0xc,%esp
801052c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801052cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801052cf:	e8 8c 09 00 00       	call   80105c60 <pushcli>
  c = mycpu();
801052d4:	e8 d7 f3 ff ff       	call   801046b0 <mycpu>
  p = c->proc;
801052d9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801052df:	e8 cc 09 00 00       	call   80105cb0 <popcli>
  if (p == 0)
801052e4:	85 db                	test   %ebx,%ebx
801052e6:	0f 84 95 00 00 00    	je     80105381 <sleep+0xc1>
  if (lk == 0)
801052ec:	85 f6                	test   %esi,%esi
801052ee:	0f 84 80 00 00 00    	je     80105374 <sleep+0xb4>
  if (lk != &ptable.lock)
801052f4:	81 fe c0 43 11 80    	cmp    $0x801143c0,%esi
801052fa:	74 54                	je     80105350 <sleep+0x90>
    acquire(&ptable.lock); // DOC: sleeplock1
801052fc:	83 ec 0c             	sub    $0xc,%esp
801052ff:	68 c0 43 11 80       	push   $0x801143c0
80105304:	e8 a7 0a 00 00       	call   80105db0 <acquire>
    release(lk);
80105309:	89 34 24             	mov    %esi,(%esp)
8010530c:	e8 3f 0a 00 00       	call   80105d50 <release>
  p->chan = chan;
80105311:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
80105317:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
8010531e:	e8 ed fb ff ff       	call   80104f10 <sched>
  p->chan = 0;
80105323:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010532a:	00 00 00 
    release(&ptable.lock);
8010532d:	c7 04 24 c0 43 11 80 	movl   $0x801143c0,(%esp)
80105334:	e8 17 0a 00 00       	call   80105d50 <release>
    acquire(lk);
80105339:	89 75 08             	mov    %esi,0x8(%ebp)
8010533c:	83 c4 10             	add    $0x10,%esp
}
8010533f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105342:	5b                   	pop    %ebx
80105343:	5e                   	pop    %esi
80105344:	5f                   	pop    %edi
80105345:	5d                   	pop    %ebp
    acquire(lk);
80105346:	e9 65 0a 00 00       	jmp    80105db0 <acquire>
8010534b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010534f:	90                   	nop
  p->chan = chan;
80105350:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
80105356:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
8010535d:	e8 ae fb ff ff       	call   80104f10 <sched>
  p->chan = 0;
80105362:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80105369:	00 00 00 
}
8010536c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010536f:	5b                   	pop    %ebx
80105370:	5e                   	pop    %esi
80105371:	5f                   	pop    %edi
80105372:	5d                   	pop    %ebp
80105373:	c3                   	ret    
    panic("sleep without lk");
80105374:	83 ec 0c             	sub    $0xc,%esp
80105377:	68 8c 95 10 80       	push   $0x8010958c
8010537c:	e8 6f b1 ff ff       	call   801004f0 <panic>
    panic("sleep");
80105381:	83 ec 0c             	sub    $0xc,%esp
80105384:	68 86 95 10 80       	push   $0x80109586
80105389:	e8 62 b1 ff ff       	call   801004f0 <panic>
8010538e:	66 90                	xchg   %ax,%ax

80105390 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	53                   	push   %ebx
80105394:	83 ec 10             	sub    $0x10,%esp
80105397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010539a:	68 c0 43 11 80       	push   $0x801143c0
8010539f:	e8 0c 0a 00 00       	call   80105db0 <acquire>
801053a4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053a7:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
801053ac:	eb 0e                	jmp    801053bc <wakeup+0x2c>
801053ae:	66 90                	xchg   %ax,%ax
801053b0:	05 0c 01 00 00       	add    $0x10c,%eax
801053b5:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
801053ba:	74 21                	je     801053dd <wakeup+0x4d>
    if (p->state == SLEEPING && p->chan == chan)
801053bc:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
801053c0:	75 ee                	jne    801053b0 <wakeup+0x20>
801053c2:	3b 98 8c 00 00 00    	cmp    0x8c(%eax),%ebx
801053c8:	75 e6                	jne    801053b0 <wakeup+0x20>
      p->state = RUNNABLE;
801053ca:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053d1:	05 0c 01 00 00       	add    $0x10c,%eax
801053d6:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
801053db:	75 df                	jne    801053bc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801053dd:	c7 45 08 c0 43 11 80 	movl   $0x801143c0,0x8(%ebp)
}
801053e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053e7:	c9                   	leave  
  release(&ptable.lock);
801053e8:	e9 63 09 00 00       	jmp    80105d50 <release>
801053ed:	8d 76 00             	lea    0x0(%esi),%esi

801053f0 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	53                   	push   %ebx
801053f4:	83 ec 10             	sub    $0x10,%esp
801053f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801053fa:	68 c0 43 11 80       	push   $0x801143c0
801053ff:	e8 ac 09 00 00       	call   80105db0 <acquire>
80105404:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105407:	b8 f4 43 11 80       	mov    $0x801143f4,%eax
8010540c:	eb 0e                	jmp    8010541c <kill+0x2c>
8010540e:	66 90                	xchg   %ax,%ax
80105410:	05 0c 01 00 00       	add    $0x10c,%eax
80105415:	3d f4 86 11 80       	cmp    $0x801186f4,%eax
8010541a:	74 34                	je     80105450 <kill+0x60>
  {
    if (p->pid == pid)
8010541c:	39 58 7c             	cmp    %ebx,0x7c(%eax)
8010541f:	75 ef                	jne    80105410 <kill+0x20>
    {
      p->killed = 1;
80105421:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
80105428:	00 00 00 
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
8010542b:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
8010542f:	75 07                	jne    80105438 <kill+0x48>
        p->state = RUNNABLE;
80105431:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
      release(&ptable.lock);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	68 c0 43 11 80       	push   $0x801143c0
80105440:	e8 0b 09 00 00       	call   80105d50 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80105445:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	31 c0                	xor    %eax,%eax
}
8010544d:	c9                   	leave  
8010544e:	c3                   	ret    
8010544f:	90                   	nop
  release(&ptable.lock);
80105450:	83 ec 0c             	sub    $0xc,%esp
80105453:	68 c0 43 11 80       	push   $0x801143c0
80105458:	e8 f3 08 00 00       	call   80105d50 <release>
}
8010545d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80105460:	83 c4 10             	add    $0x10,%esp
80105463:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105468:	c9                   	leave  
80105469:	c3                   	ret    
8010546a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105470 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	8d 75 e8             	lea    -0x18(%ebp),%esi
80105478:	53                   	push   %ebx
80105479:	bb cc 44 11 80       	mov    $0x801144cc,%ebx
8010547e:	83 ec 3c             	sub    $0x3c,%esp
80105481:	eb 27                	jmp    801054aa <procdump+0x3a>
80105483:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105487:	90                   	nop
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105488:	83 ec 0c             	sub    $0xc,%esp
8010548b:	68 2b 95 10 80       	push   $0x8010952b
80105490:	e8 db b5 ff ff       	call   80100a70 <cprintf>
80105495:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105498:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
8010549e:	81 fb cc 87 11 80    	cmp    $0x801187cc,%ebx
801054a4:	0f 84 7e 00 00 00    	je     80105528 <procdump+0xb8>
    if (p->state == UNUSED)
801054aa:	8b 43 a0             	mov    -0x60(%ebx),%eax
801054ad:	85 c0                	test   %eax,%eax
801054af:	74 e7                	je     80105498 <procdump+0x28>
      state = "???";
801054b1:	ba 9d 95 10 80       	mov    $0x8010959d,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
801054b6:	83 f8 05             	cmp    $0x5,%eax
801054b9:	77 11                	ja     801054cc <procdump+0x5c>
801054bb:	8b 14 85 6c 97 10 80 	mov    -0x7fef6894(,%eax,4),%edx
      state = "???";
801054c2:	b8 9d 95 10 80       	mov    $0x8010959d,%eax
801054c7:	85 d2                	test   %edx,%edx
801054c9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801054cc:	53                   	push   %ebx
801054cd:	52                   	push   %edx
801054ce:	ff 73 a4             	push   -0x5c(%ebx)
801054d1:	68 a1 95 10 80       	push   $0x801095a1
801054d6:	e8 95 b5 ff ff       	call   80100a70 <cprintf>
    if (p->state == SLEEPING)
801054db:	83 c4 10             	add    $0x10,%esp
801054de:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801054e2:	75 a4                	jne    80105488 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
801054e4:	83 ec 08             	sub    $0x8,%esp
801054e7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801054ea:	8d 7d c0             	lea    -0x40(%ebp),%edi
801054ed:	50                   	push   %eax
801054ee:	8b 43 b0             	mov    -0x50(%ebx),%eax
801054f1:	8b 40 0c             	mov    0xc(%eax),%eax
801054f4:	83 c0 08             	add    $0x8,%eax
801054f7:	50                   	push   %eax
801054f8:	e8 03 07 00 00       	call   80105c00 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801054fd:	83 c4 10             	add    $0x10,%esp
80105500:	8b 17                	mov    (%edi),%edx
80105502:	85 d2                	test   %edx,%edx
80105504:	74 82                	je     80105488 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105506:	83 ec 08             	sub    $0x8,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
80105509:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010550c:	52                   	push   %edx
8010550d:	68 a1 8f 10 80       	push   $0x80108fa1
80105512:	e8 59 b5 ff ff       	call   80100a70 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80105517:	83 c4 10             	add    $0x10,%esp
8010551a:	39 fe                	cmp    %edi,%esi
8010551c:	75 e2                	jne    80105500 <procdump+0x90>
8010551e:	e9 65 ff ff ff       	jmp    80105488 <procdump+0x18>
80105523:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105527:	90                   	nop
  }
}
80105528:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010552b:	5b                   	pop    %ebx
8010552c:	5e                   	pop    %esi
8010552d:	5f                   	pop    %edi
8010552e:	5d                   	pop    %ebp
8010552f:	c3                   	ret    

80105530 <list_active_processes>:

int list_active_processes(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	53                   	push   %ebx
80105534:	bb 60 44 11 80       	mov    $0x80114460,%ebx
80105539:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  acquire(&ptable.lock);
8010553c:	68 c0 43 11 80       	push   $0x801143c0
80105541:	e8 6a 08 00 00       	call   80105db0 <acquire>

  cprintf("PID\tName\t\tNumber of syscalls:\n");
80105546:	c7 04 24 48 96 10 80 	movl   $0x80109648,(%esp)
8010554d:	e8 1e b5 ff ff       	call   80100a70 <cprintf>
  cprintf("---------------------------\n");
80105552:	c7 04 24 aa 95 10 80 	movl   $0x801095aa,(%esp)
80105559:	e8 12 b5 ff ff       	call   80100a70 <cprintf>

  // Iterate over the process table
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	eb 13                	jmp    80105576 <list_active_processes+0x46>
80105563:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105567:	90                   	nop
80105568:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
8010556e:	81 fb 60 87 11 80    	cmp    $0x80118760,%ebx
80105574:	74 41                	je     801055b7 <list_active_processes+0x87>
  {
    if (p->state != UNUSED)
80105576:	8b 43 0c             	mov    0xc(%ebx),%eax
80105579:	85 c0                	test   %eax,%eax
8010557b:	74 eb                	je     80105568 <list_active_processes+0x38>
8010557d:	8d 43 94             	lea    -0x6c(%ebx),%eax
    { // Only list active processes
      int num_of_syscalls = 0;
80105580:	31 d2                	xor    %edx,%edx
80105582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for (int i = 0; i < MAX_SYSCALLS; i++)
        num_of_syscalls += p->syscalls[i];
80105588:	03 10                	add    (%eax),%edx
      for (int i = 0; i < MAX_SYSCALLS; i++)
8010558a:	83 c0 04             	add    $0x4,%eax
8010558d:	39 d8                	cmp    %ebx,%eax
8010558f:	75 f7                	jne    80105588 <list_active_processes+0x58>
      cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
80105591:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105594:	52                   	push   %edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105595:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
      cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
8010559b:	50                   	push   %eax
8010559c:	ff b3 04 ff ff ff    	push   -0xfc(%ebx)
801055a2:	68 c7 95 10 80       	push   $0x801095c7
801055a7:	e8 c4 b4 ff ff       	call   80100a70 <cprintf>
801055ac:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801055af:	81 fb 60 87 11 80    	cmp    $0x80118760,%ebx
801055b5:	75 bf                	jne    80105576 <list_active_processes+0x46>
    }
  }

  // Release the process table lock
  release(&ptable.lock);
801055b7:	83 ec 0c             	sub    $0xc,%esp
801055ba:	68 c0 43 11 80       	push   $0x801143c0
801055bf:	e8 8c 07 00 00       	call   80105d50 <release>

  return 0; // Return 0 to indicate success
}
801055c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055c7:	31 c0                	xor    %eax,%eax
801055c9:	c9                   	leave  
801055ca:	c3                   	ret    
801055cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055cf:	90                   	nop

801055d0 <space>:


void
space(int count)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	8b 75 08             	mov    0x8(%ebp),%esi
801055d7:	53                   	push   %ebx
  for(int i = 0; i < count; ++i)
801055d8:	85 f6                	test   %esi,%esi
801055da:	7e 1b                	jle    801055f7 <space+0x27>
801055dc:	31 db                	xor    %ebx,%ebx
801055de:	66 90                	xchg   %ax,%ax
    cprintf(" ");
801055e0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801055e3:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
801055e6:	68 1d 96 10 80       	push   $0x8010961d
801055eb:	e8 80 b4 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801055f0:	83 c4 10             	add    $0x10,%esp
801055f3:	39 de                	cmp    %ebx,%esi
801055f5:	75 e9                	jne    801055e0 <space+0x10>
}
801055f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055fa:	5b                   	pop    %ebx
801055fb:	5e                   	pop    %esi
801055fc:	5d                   	pop    %ebp
801055fd:	c3                   	ret    
801055fe:	66 90                	xchg   %ax,%ax

80105600 <num_digits>:

int num_digits(int n) {
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	56                   	push   %esi
80105604:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105607:	53                   	push   %ebx
  int num = 0;
80105608:	31 db                	xor    %ebx,%ebx
  while(n!= 0) {
8010560a:	85 c9                	test   %ecx,%ecx
8010560c:	74 1f                	je     8010562d <num_digits+0x2d>
    n/=10;
8010560e:	be 67 66 66 66       	mov    $0x66666667,%esi
80105613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105617:	90                   	nop
80105618:	89 c8                	mov    %ecx,%eax
    num += 1;
8010561a:	83 c3 01             	add    $0x1,%ebx
    n/=10;
8010561d:	f7 ee                	imul   %esi
8010561f:	89 c8                	mov    %ecx,%eax
80105621:	c1 f8 1f             	sar    $0x1f,%eax
80105624:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105627:	89 d1                	mov    %edx,%ecx
80105629:	29 c1                	sub    %eax,%ecx
8010562b:	75 eb                	jne    80105618 <num_digits+0x18>
  }
  return num;
}
8010562d:	89 d8                	mov    %ebx,%eax
8010562f:	5b                   	pop    %ebx
80105630:	5e                   	pop    %esi
80105631:	5d                   	pop    %ebp
80105632:	c3                   	ret    
80105633:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010563a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105640 <show_process_info>:

void show_process_info()
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	57                   	push   %edi
80105644:	56                   	push   %esi
80105645:	53                   	push   %ebx
80105646:	bb cc 44 11 80       	mov    $0x801144cc,%ebx
8010564b:	83 ec 28             	sub    $0x28,%esp
      [RUNNABLE] "runnable",
      [RUNNING] "running",
      [ZOMBIE] "zombie"};

  static int columns[] = {24, 10, 10, 10, 10, 10, 10, 12};
  cprintf("Process_Name            PID     State    Queue   Burst_time   Last_exe   Enterance_time   confidence\n"
8010564e:	68 68 96 10 80       	push   $0x80109668
80105653:	e8 18 b4 ff ff       	call   80100a70 <cprintf>
          "----------------------------------------------------------------------------------------\n");

  struct proc *p;
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105658:	83 c4 10             	add    $0x10,%esp
8010565b:	eb 15                	jmp    80105672 <show_process_info+0x32>
8010565d:	8d 76 00             	lea    0x0(%esi),%esi
80105660:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80105666:	81 fb cc 87 11 80    	cmp    $0x801187cc,%ebx
8010566c:	0f 84 3f 03 00 00    	je     801059b1 <show_process_info+0x371>
  {
    if (p->state == UNUSED)
80105672:	8b 43 a0             	mov    -0x60(%ebx),%eax
80105675:	85 c0                	test   %eax,%eax
80105677:	74 e7                	je     80105660 <show_process_info+0x20>

    const char *state;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "unknown state";
80105679:	c7 45 e4 d2 95 10 80 	movl   $0x801095d2,-0x1c(%ebp)
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105680:	83 f8 05             	cmp    $0x5,%eax
80105683:	77 14                	ja     80105699 <show_process_info+0x59>
80105685:	8b 3c 85 54 97 10 80 	mov    -0x7fef68ac(,%eax,4),%edi
      state = "unknown state";
8010568c:	b8 d2 95 10 80       	mov    $0x801095d2,%eax
80105691:	85 ff                	test   %edi,%edi
80105693:	0f 45 c7             	cmovne %edi,%eax
80105696:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    cprintf("%s", p->name);
80105699:	83 ec 08             	sub    $0x8,%esp
    space(columns[0] - strlen(p->name));
8010569c:	be 18 00 00 00       	mov    $0x18,%esi
    cprintf("%s", p->name);
801056a1:	53                   	push   %ebx
801056a2:	68 a7 95 10 80       	push   $0x801095a7
801056a7:	e8 c4 b3 ff ff       	call   80100a70 <cprintf>
    space(columns[0] - strlen(p->name));
801056ac:	89 1c 24             	mov    %ebx,(%esp)
801056af:	e8 bc 09 00 00       	call   80106070 <strlen>
  for(int i = 0; i < count; ++i)
801056b4:	83 c4 10             	add    $0x10,%esp
    space(columns[0] - strlen(p->name));
801056b7:	29 c6                	sub    %eax,%esi
  for(int i = 0; i < count; ++i)
801056b9:	85 f6                	test   %esi,%esi
801056bb:	7e 1a                	jle    801056d7 <show_process_info+0x97>
801056bd:	31 ff                	xor    %edi,%edi
801056bf:	90                   	nop
    cprintf(" ");
801056c0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801056c3:	83 c7 01             	add    $0x1,%edi
    cprintf(" ");
801056c6:	68 1d 96 10 80       	push   $0x8010961d
801056cb:	e8 a0 b3 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801056d0:	83 c4 10             	add    $0x10,%esp
801056d3:	39 fe                	cmp    %edi,%esi
801056d5:	75 e9                	jne    801056c0 <show_process_info+0x80>

    cprintf("%d", p->pid);
801056d7:	83 ec 08             	sub    $0x8,%esp
801056da:	ff 73 a4             	push   -0x5c(%ebx)
801056dd:	68 e0 95 10 80       	push   $0x801095e0
801056e2:	e8 89 b3 ff ff       	call   80100a70 <cprintf>
    space(columns[1] - num_digits(p->pid));
801056e7:	8b 4b a4             	mov    -0x5c(%ebx),%ecx
  while(n!= 0) {
801056ea:	83 c4 10             	add    $0x10,%esp
801056ed:	85 c9                	test   %ecx,%ecx
801056ef:	0f 84 1b 03 00 00    	je     80105a10 <show_process_info+0x3d0>
  int num = 0;
801056f5:	31 f6                	xor    %esi,%esi
    n/=10;
801056f7:	bf 67 66 66 66       	mov    $0x66666667,%edi
801056fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105700:	89 c8                	mov    %ecx,%eax
    num += 1;
80105702:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105705:	f7 ef                	imul   %edi
80105707:	89 c8                	mov    %ecx,%eax
80105709:	c1 f8 1f             	sar    $0x1f,%eax
8010570c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010570f:	89 d1                	mov    %edx,%ecx
80105711:	29 c1                	sub    %eax,%ecx
80105713:	75 eb                	jne    80105700 <show_process_info+0xc0>
    space(columns[1] - num_digits(p->pid));
80105715:	bf 0a 00 00 00       	mov    $0xa,%edi
8010571a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
8010571c:	85 ff                	test   %edi,%edi
8010571e:	7e 1f                	jle    8010573f <show_process_info+0xff>
    space(columns[1] - num_digits(p->pid));
80105720:	31 f6                	xor    %esi,%esi
80105722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105728:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
8010572b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
8010572e:	68 1d 96 10 80       	push   $0x8010961d
80105733:	e8 38 b3 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105738:	83 c4 10             	add    $0x10,%esp
8010573b:	39 fe                	cmp    %edi,%esi
8010573d:	7c e9                	jl     80105728 <show_process_info+0xe8>

    cprintf("%s", state);
8010573f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105742:	83 ec 08             	sub    $0x8,%esp
80105745:	57                   	push   %edi
80105746:	68 a7 95 10 80       	push   $0x801095a7
8010574b:	e8 20 b3 ff ff       	call   80100a70 <cprintf>
    space(columns[2] - strlen(state));
80105750:	89 3c 24             	mov    %edi,(%esp)
80105753:	bf 0a 00 00 00       	mov    $0xa,%edi
80105758:	e8 13 09 00 00       	call   80106070 <strlen>
  for(int i = 0; i < count; ++i)
8010575d:	83 c4 10             	add    $0x10,%esp
    space(columns[2] - strlen(state));
80105760:	29 c7                	sub    %eax,%edi
  for(int i = 0; i < count; ++i)
80105762:	85 ff                	test   %edi,%edi
80105764:	7e 21                	jle    80105787 <show_process_info+0x147>
80105766:	31 f6                	xor    %esi,%esi
80105768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576f:	90                   	nop
    cprintf(" ");
80105770:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105773:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105776:	68 1d 96 10 80       	push   $0x8010961d
8010577b:	e8 f0 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105780:	83 c4 10             	add    $0x10,%esp
80105783:	39 f7                	cmp    %esi,%edi
80105785:	75 e9                	jne    80105770 <show_process_info+0x130>

    cprintf("%d", p->sched_info.level);
80105787:	83 ec 08             	sub    $0x8,%esp
8010578a:	ff 73 18             	push   0x18(%ebx)
8010578d:	68 e0 95 10 80       	push   $0x801095e0
80105792:	e8 d9 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[3] - num_digits(p->sched_info.level));
80105797:	8b 4b 18             	mov    0x18(%ebx),%ecx
  while(n!= 0) {
8010579a:	83 c4 10             	add    $0x10,%esp
8010579d:	85 c9                	test   %ecx,%ecx
8010579f:	0f 84 5b 02 00 00    	je     80105a00 <show_process_info+0x3c0>
  int num = 0;
801057a5:	31 f6                	xor    %esi,%esi
    n/=10;
801057a7:	bf 67 66 66 66       	mov    $0x66666667,%edi
801057ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057b0:	89 c8                	mov    %ecx,%eax
    num += 1;
801057b2:	83 c6 01             	add    $0x1,%esi
    n/=10;
801057b5:	f7 ef                	imul   %edi
801057b7:	89 c8                	mov    %ecx,%eax
801057b9:	c1 f8 1f             	sar    $0x1f,%eax
801057bc:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801057bf:	89 d1                	mov    %edx,%ecx
801057c1:	29 c1                	sub    %eax,%ecx
801057c3:	75 eb                	jne    801057b0 <show_process_info+0x170>
    space(columns[3] - num_digits(p->sched_info.level));
801057c5:	bf 0a 00 00 00       	mov    $0xa,%edi
801057ca:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
801057cc:	85 ff                	test   %edi,%edi
801057ce:	7e 1f                	jle    801057ef <show_process_info+0x1af>
    space(columns[3] - num_digits(p->sched_info.level));
801057d0:	31 f6                	xor    %esi,%esi
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
801057d8:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801057db:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801057de:	68 1d 96 10 80       	push   $0x8010961d
801057e3:	e8 88 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801057e8:	83 c4 10             	add    $0x10,%esp
801057eb:	39 f7                	cmp    %esi,%edi
801057ed:	7f e9                	jg     801057d8 <show_process_info+0x198>

    cprintf("%d", (int)p->sched_info.burst_time);
801057ef:	83 ec 08             	sub    $0x8,%esp
801057f2:	ff 73 1c             	push   0x1c(%ebx)
801057f5:	68 e0 95 10 80       	push   $0x801095e0
801057fa:	e8 71 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
801057ff:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  while(n!= 0) {
80105802:	83 c4 10             	add    $0x10,%esp
80105805:	85 c9                	test   %ecx,%ecx
80105807:	0f 84 e3 01 00 00    	je     801059f0 <show_process_info+0x3b0>
  int num = 0;
8010580d:	31 f6                	xor    %esi,%esi
    n/=10;
8010580f:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105818:	89 c8                	mov    %ecx,%eax
    num += 1;
8010581a:	83 c6 01             	add    $0x1,%esi
    n/=10;
8010581d:	f7 ef                	imul   %edi
8010581f:	89 c8                	mov    %ecx,%eax
80105821:	c1 f8 1f             	sar    $0x1f,%eax
80105824:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105827:	29 c2                	sub    %eax,%edx
80105829:	89 d1                	mov    %edx,%ecx
8010582b:	75 eb                	jne    80105818 <show_process_info+0x1d8>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
8010582d:	bf 0a 00 00 00       	mov    $0xa,%edi
80105832:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
80105834:	85 ff                	test   %edi,%edi
80105836:	7e 1f                	jle    80105857 <show_process_info+0x217>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
80105838:	31 f6                	xor    %esi,%esi
8010583a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105840:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105843:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105846:	68 1d 96 10 80       	push   $0x8010961d
8010584b:	e8 20 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105850:	83 c4 10             	add    $0x10,%esp
80105853:	39 fe                	cmp    %edi,%esi
80105855:	7c e9                	jl     80105840 <show_process_info+0x200>

    cprintf("%d", p->sched_info.last_exe_time);
80105857:	83 ec 08             	sub    $0x8,%esp
8010585a:	ff 73 20             	push   0x20(%ebx)
8010585d:	68 e0 95 10 80       	push   $0x801095e0
80105862:	e8 09 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[5] - num_digits(p->sched_info.last_exe_time));
80105867:	8b 4b 20             	mov    0x20(%ebx),%ecx
  while(n!= 0) {
8010586a:	83 c4 10             	add    $0x10,%esp
8010586d:	85 c9                	test   %ecx,%ecx
8010586f:	0f 84 6b 01 00 00    	je     801059e0 <show_process_info+0x3a0>
  int num = 0;
80105875:	31 f6                	xor    %esi,%esi
    n/=10;
80105877:	bf 67 66 66 66       	mov    $0x66666667,%edi
8010587c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105880:	89 c8                	mov    %ecx,%eax
    num += 1;
80105882:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105885:	f7 ef                	imul   %edi
80105887:	89 c8                	mov    %ecx,%eax
80105889:	c1 f8 1f             	sar    $0x1f,%eax
8010588c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010588f:	89 d1                	mov    %edx,%ecx
80105891:	29 c1                	sub    %eax,%ecx
80105893:	75 eb                	jne    80105880 <show_process_info+0x240>
    space(columns[5] - num_digits(p->sched_info.last_exe_time));
80105895:	bf 0a 00 00 00       	mov    $0xa,%edi
8010589a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
8010589c:	85 ff                	test   %edi,%edi
8010589e:	7e 1f                	jle    801058bf <show_process_info+0x27f>
    space(columns[5] - num_digits(p->sched_info.last_exe_time));
801058a0:	31 f6                	xor    %esi,%esi
801058a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
801058a8:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801058ab:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801058ae:	68 1d 96 10 80       	push   $0x8010961d
801058b3:	e8 b8 b1 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801058b8:	83 c4 10             	add    $0x10,%esp
801058bb:	39 fe                	cmp    %edi,%esi
801058bd:	7c e9                	jl     801058a8 <show_process_info+0x268>

    cprintf("%d", p->sched_info.enter_level_time);
801058bf:	83 ec 08             	sub    $0x8,%esp
801058c2:	ff 73 28             	push   0x28(%ebx)
801058c5:	68 e0 95 10 80       	push   $0x801095e0
801058ca:	e8 a1 b1 ff ff       	call   80100a70 <cprintf>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
801058cf:	8b 4b 28             	mov    0x28(%ebx),%ecx
  while(n!= 0) {
801058d2:	83 c4 10             	add    $0x10,%esp
801058d5:	85 c9                	test   %ecx,%ecx
801058d7:	0f 84 f3 00 00 00    	je     801059d0 <show_process_info+0x390>
  int num = 0;
801058dd:	31 f6                	xor    %esi,%esi
    n/=10;
801058df:	bf 67 66 66 66       	mov    $0x66666667,%edi
801058e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058e8:	89 c8                	mov    %ecx,%eax
    num += 1;
801058ea:	83 c6 01             	add    $0x1,%esi
    n/=10;
801058ed:	f7 ef                	imul   %edi
801058ef:	89 c8                	mov    %ecx,%eax
801058f1:	c1 f8 1f             	sar    $0x1f,%eax
801058f4:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801058f7:	29 c2                	sub    %eax,%edx
801058f9:	89 d1                	mov    %edx,%ecx
801058fb:	75 eb                	jne    801058e8 <show_process_info+0x2a8>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
801058fd:	bf 0a 00 00 00       	mov    $0xa,%edi
80105902:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
80105904:	85 ff                	test   %edi,%edi
80105906:	7e 1f                	jle    80105927 <show_process_info+0x2e7>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
80105908:	31 f6                	xor    %esi,%esi
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105910:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105913:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105916:	68 1d 96 10 80       	push   $0x8010961d
8010591b:	e8 50 b1 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105920:	83 c4 10             	add    $0x10,%esp
80105923:	39 fe                	cmp    %edi,%esi
80105925:	7c e9                	jl     80105910 <show_process_info+0x2d0>

    cprintf("%d", (int)p->sched_info.confidence);
80105927:	83 ec 08             	sub    $0x8,%esp
8010592a:	ff 73 2c             	push   0x2c(%ebx)
8010592d:	68 e0 95 10 80       	push   $0x801095e0
80105932:	e8 39 b1 ff ff       	call   80100a70 <cprintf>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105937:	8b 4b 2c             	mov    0x2c(%ebx),%ecx
  while(n!= 0) {
8010593a:	83 c4 10             	add    $0x10,%esp
8010593d:	85 c9                	test   %ecx,%ecx
8010593f:	74 7f                	je     801059c0 <show_process_info+0x380>
  int num = 0;
80105941:	31 f6                	xor    %esi,%esi
    n/=10;
80105943:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594f:	90                   	nop
80105950:	89 c8                	mov    %ecx,%eax
    num += 1;
80105952:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105955:	f7 ef                	imul   %edi
80105957:	89 c8                	mov    %ecx,%eax
80105959:	c1 f8 1f             	sar    $0x1f,%eax
8010595c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010595f:	89 d1                	mov    %edx,%ecx
80105961:	29 c1                	sub    %eax,%ecx
80105963:	75 eb                	jne    80105950 <show_process_info+0x310>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105965:	bf 0c 00 00 00       	mov    $0xc,%edi
8010596a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
8010596c:	85 ff                	test   %edi,%edi
8010596e:	7e 1f                	jle    8010598f <show_process_info+0x34f>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105970:	31 f6                	xor    %esi,%esi
80105972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105978:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
8010597b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
8010597e:	68 1d 96 10 80       	push   $0x8010961d
80105983:	e8 e8 b0 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105988:	83 c4 10             	add    $0x10,%esp
8010598b:	39 fe                	cmp    %edi,%esi
8010598d:	7c e9                	jl     80105978 <show_process_info+0x338>
    cprintf("\n");
8010598f:	83 ec 0c             	sub    $0xc,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105992:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
    cprintf("\n");
80105998:	68 2b 95 10 80       	push   $0x8010952b
8010599d:	e8 ce b0 ff ff       	call   80100a70 <cprintf>
801059a2:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801059a5:	81 fb cc 87 11 80    	cmp    $0x801187cc,%ebx
801059ab:	0f 85 c1 fc ff ff    	jne    80105672 <show_process_info+0x32>
  }
}
801059b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059b4:	5b                   	pop    %ebx
801059b5:	5e                   	pop    %esi
801059b6:	5f                   	pop    %edi
801059b7:	5d                   	pop    %ebp
801059b8:	c3                   	ret    
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    space(columns[7] - num_digits((int)p->sched_info.confidence));
801059c0:	bf 0c 00 00 00       	mov    $0xc,%edi
801059c5:	eb a9                	jmp    80105970 <show_process_info+0x330>
801059c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ce:	66 90                	xchg   %ax,%ax
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
801059d0:	bf 0a 00 00 00       	mov    $0xa,%edi
801059d5:	e9 2e ff ff ff       	jmp    80105908 <show_process_info+0x2c8>
801059da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[5] - num_digits(p->sched_info.last_exe_time));
801059e0:	bf 0a 00 00 00       	mov    $0xa,%edi
801059e5:	e9 b6 fe ff ff       	jmp    801058a0 <show_process_info+0x260>
801059ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
801059f0:	bf 0a 00 00 00       	mov    $0xa,%edi
801059f5:	e9 3e fe ff ff       	jmp    80105838 <show_process_info+0x1f8>
801059fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[3] - num_digits(p->sched_info.level));
80105a00:	bf 0a 00 00 00       	mov    $0xa,%edi
80105a05:	e9 c6 fd ff ff       	jmp    801057d0 <show_process_info+0x190>
80105a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[1] - num_digits(p->pid));
80105a10:	bf 0a 00 00 00       	mov    $0xa,%edi
80105a15:	e9 06 fd ff ff       	jmp    80105720 <show_process_info+0xe0>
80105a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a20 <set_burst_confidence>:

void set_burst_confidence(int pid, int burst, int conf)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	57                   	push   %edi
80105a24:	56                   	push   %esi
80105a25:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105a26:	bb f4 43 11 80       	mov    $0x801143f4,%ebx
{
80105a2b:	83 ec 18             	sub    $0x18,%esp
80105a2e:	8b 75 08             	mov    0x8(%ebp),%esi
80105a31:	8b 7d 10             	mov    0x10(%ebp),%edi
  acquire(&ptable.lock);
80105a34:	68 c0 43 11 80       	push   $0x801143c0
80105a39:	e8 72 03 00 00       	call   80105db0 <acquire>
80105a3e:	83 c4 10             	add    $0x10,%esp
80105a41:	eb 17                	jmp    80105a5a <set_burst_confidence+0x3a>
80105a43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a47:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105a48:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80105a4e:	81 fb f4 86 11 80    	cmp    $0x801186f4,%ebx
80105a54:	0f 84 36 00 00 00    	je     80105a90 <set_burst_confidence.cold>
    if (p->pid == pid)
80105a5a:	3b 73 7c             	cmp    0x7c(%ebx),%esi
80105a5d:	75 e9                	jne    80105a48 <set_burst_confidence+0x28>
      release(&ptable.lock); // Release the lock before returning.
80105a5f:	83 ec 0c             	sub    $0xc,%esp
80105a62:	68 c0 43 11 80       	push   $0x801143c0
80105a67:	e8 e4 02 00 00       	call   80105d50 <release>
  struct proc *p = findproc(pid);
  p->sched_info.burst_time = burst;
80105a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  p->sched_info.confidence = conf;
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105a6f:	57                   	push   %edi
  p->sched_info.confidence = conf;
80105a70:	89 bb 04 01 00 00    	mov    %edi,0x104(%ebx)
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105a76:	50                   	push   %eax
80105a77:	56                   	push   %esi
80105a78:	68 28 97 10 80       	push   $0x80109728
  p->sched_info.burst_time = burst;
80105a7d:	89 83 f4 00 00 00    	mov    %eax,0xf4(%ebx)
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105a83:	e8 e8 af ff ff       	call   80100a70 <cprintf>
  return 0;
80105a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a8b:	5b                   	pop    %ebx
80105a8c:	5e                   	pop    %esi
80105a8d:	5f                   	pop    %edi
80105a8e:	5d                   	pop    %ebp
80105a8f:	c3                   	ret    

80105a90 <set_burst_confidence.cold>:
  release(&ptable.lock);
80105a90:	83 ec 0c             	sub    $0xc,%esp
80105a93:	68 c0 43 11 80       	push   $0x801143c0
80105a98:	e8 b3 02 00 00       	call   80105d50 <release>
  p->sched_info.burst_time = burst;
80105a9d:	c7 05 f4 00 00 00 00 	movl   $0x0,0xf4
80105aa4:	00 00 00 
80105aa7:	0f 0b                	ud2    
80105aa9:	66 90                	xchg   %ax,%ax
80105aab:	66 90                	xchg   %ax,%ax
80105aad:	66 90                	xchg   %ax,%ax
80105aaf:	90                   	nop

80105ab0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	53                   	push   %ebx
80105ab4:	83 ec 0c             	sub    $0xc,%esp
80105ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80105aba:	68 84 97 10 80       	push   $0x80109784
80105abf:	8d 43 04             	lea    0x4(%ebx),%eax
80105ac2:	50                   	push   %eax
80105ac3:	e8 18 01 00 00       	call   80105be0 <initlock>
  lk->name = name;
80105ac8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105acb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105ad1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105ad4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80105adb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105ade:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ae1:	c9                   	leave  
80105ae2:	c3                   	ret    
80105ae3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105af0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	56                   	push   %esi
80105af4:	53                   	push   %ebx
80105af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105af8:	8d 73 04             	lea    0x4(%ebx),%esi
80105afb:	83 ec 0c             	sub    $0xc,%esp
80105afe:	56                   	push   %esi
80105aff:	e8 ac 02 00 00       	call   80105db0 <acquire>
  while (lk->locked) {
80105b04:	8b 13                	mov    (%ebx),%edx
80105b06:	83 c4 10             	add    $0x10,%esp
80105b09:	85 d2                	test   %edx,%edx
80105b0b:	74 16                	je     80105b23 <acquiresleep+0x33>
80105b0d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105b10:	83 ec 08             	sub    $0x8,%esp
80105b13:	56                   	push   %esi
80105b14:	53                   	push   %ebx
80105b15:	e8 a6 f7 ff ff       	call   801052c0 <sleep>
  while (lk->locked) {
80105b1a:	8b 03                	mov    (%ebx),%eax
80105b1c:	83 c4 10             	add    $0x10,%esp
80105b1f:	85 c0                	test   %eax,%eax
80105b21:	75 ed                	jne    80105b10 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105b23:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105b29:	e8 02 ec ff ff       	call   80104730 <myproc>
80105b2e:	8b 40 7c             	mov    0x7c(%eax),%eax
80105b31:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105b34:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105b37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b3a:	5b                   	pop    %ebx
80105b3b:	5e                   	pop    %esi
80105b3c:	5d                   	pop    %ebp
  release(&lk->lk);
80105b3d:	e9 0e 02 00 00       	jmp    80105d50 <release>
80105b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b50 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	56                   	push   %esi
80105b54:	53                   	push   %ebx
80105b55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105b58:	8d 73 04             	lea    0x4(%ebx),%esi
80105b5b:	83 ec 0c             	sub    $0xc,%esp
80105b5e:	56                   	push   %esi
80105b5f:	e8 4c 02 00 00       	call   80105db0 <acquire>
  lk->locked = 0;
80105b64:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105b6a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105b71:	89 1c 24             	mov    %ebx,(%esp)
80105b74:	e8 17 f8 ff ff       	call   80105390 <wakeup>
  release(&lk->lk);
80105b79:	89 75 08             	mov    %esi,0x8(%ebp)
80105b7c:	83 c4 10             	add    $0x10,%esp
}
80105b7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b82:	5b                   	pop    %ebx
80105b83:	5e                   	pop    %esi
80105b84:	5d                   	pop    %ebp
  release(&lk->lk);
80105b85:	e9 c6 01 00 00       	jmp    80105d50 <release>
80105b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b90 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	31 ff                	xor    %edi,%edi
80105b96:	56                   	push   %esi
80105b97:	53                   	push   %ebx
80105b98:	83 ec 18             	sub    $0x18,%esp
80105b9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105b9e:	8d 73 04             	lea    0x4(%ebx),%esi
80105ba1:	56                   	push   %esi
80105ba2:	e8 09 02 00 00       	call   80105db0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105ba7:	8b 03                	mov    (%ebx),%eax
80105ba9:	83 c4 10             	add    $0x10,%esp
80105bac:	85 c0                	test   %eax,%eax
80105bae:	75 18                	jne    80105bc8 <holdingsleep+0x38>
  release(&lk->lk);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	56                   	push   %esi
80105bb4:	e8 97 01 00 00       	call   80105d50 <release>
  return r;
}
80105bb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bbc:	89 f8                	mov    %edi,%eax
80105bbe:	5b                   	pop    %ebx
80105bbf:	5e                   	pop    %esi
80105bc0:	5f                   	pop    %edi
80105bc1:	5d                   	pop    %ebp
80105bc2:	c3                   	ret    
80105bc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bc7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80105bc8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105bcb:	e8 60 eb ff ff       	call   80104730 <myproc>
80105bd0:	39 58 7c             	cmp    %ebx,0x7c(%eax)
80105bd3:	0f 94 c0             	sete   %al
80105bd6:	0f b6 c0             	movzbl %al,%eax
80105bd9:	89 c7                	mov    %eax,%edi
80105bdb:	eb d3                	jmp    80105bb0 <holdingsleep+0x20>
80105bdd:	66 90                	xchg   %ax,%ax
80105bdf:	90                   	nop

80105be0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105be6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105be9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105bef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105bf2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105bf9:	5d                   	pop    %ebp
80105bfa:	c3                   	ret    
80105bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bff:	90                   	nop

80105c00 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105c00:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105c01:	31 d2                	xor    %edx,%edx
{
80105c03:	89 e5                	mov    %esp,%ebp
80105c05:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105c06:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105c09:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105c0c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80105c0f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105c10:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105c16:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105c1c:	77 1a                	ja     80105c38 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105c1e:	8b 58 04             	mov    0x4(%eax),%ebx
80105c21:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105c24:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105c27:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105c29:	83 fa 0a             	cmp    $0xa,%edx
80105c2c:	75 e2                	jne    80105c10 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105c2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c31:	c9                   	leave  
80105c32:	c3                   	ret    
80105c33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c37:	90                   	nop
  for(; i < 10; i++)
80105c38:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105c3b:	8d 51 28             	lea    0x28(%ecx),%edx
80105c3e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105c40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105c46:	83 c0 04             	add    $0x4,%eax
80105c49:	39 d0                	cmp    %edx,%eax
80105c4b:	75 f3                	jne    80105c40 <getcallerpcs+0x40>
}
80105c4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c50:	c9                   	leave  
80105c51:	c3                   	ret    
80105c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c60 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	53                   	push   %ebx
80105c64:	83 ec 04             	sub    $0x4,%esp
80105c67:	9c                   	pushf  
80105c68:	5b                   	pop    %ebx
  asm volatile("cli");
80105c69:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105c6a:	e8 41 ea ff ff       	call   801046b0 <mycpu>
80105c6f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105c75:	85 c0                	test   %eax,%eax
80105c77:	74 17                	je     80105c90 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105c79:	e8 32 ea ff ff       	call   801046b0 <mycpu>
80105c7e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105c85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c88:	c9                   	leave  
80105c89:	c3                   	ret    
80105c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105c90:	e8 1b ea ff ff       	call   801046b0 <mycpu>
80105c95:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105c9b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105ca1:	eb d6                	jmp    80105c79 <pushcli+0x19>
80105ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cb0 <popcli>:

void
popcli(void)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105cb6:	9c                   	pushf  
80105cb7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105cb8:	f6 c4 02             	test   $0x2,%ah
80105cbb:	75 35                	jne    80105cf2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105cbd:	e8 ee e9 ff ff       	call   801046b0 <mycpu>
80105cc2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105cc9:	78 34                	js     80105cff <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105ccb:	e8 e0 e9 ff ff       	call   801046b0 <mycpu>
80105cd0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105cd6:	85 d2                	test   %edx,%edx
80105cd8:	74 06                	je     80105ce0 <popcli+0x30>
    sti();
}
80105cda:	c9                   	leave  
80105cdb:	c3                   	ret    
80105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105ce0:	e8 cb e9 ff ff       	call   801046b0 <mycpu>
80105ce5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105ceb:	85 c0                	test   %eax,%eax
80105ced:	74 eb                	je     80105cda <popcli+0x2a>
  asm volatile("sti");
80105cef:	fb                   	sti    
}
80105cf0:	c9                   	leave  
80105cf1:	c3                   	ret    
    panic("popcli - interruptible");
80105cf2:	83 ec 0c             	sub    $0xc,%esp
80105cf5:	68 8f 97 10 80       	push   $0x8010978f
80105cfa:	e8 f1 a7 ff ff       	call   801004f0 <panic>
    panic("popcli");
80105cff:	83 ec 0c             	sub    $0xc,%esp
80105d02:	68 a6 97 10 80       	push   $0x801097a6
80105d07:	e8 e4 a7 ff ff       	call   801004f0 <panic>
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d10 <holding>:
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	56                   	push   %esi
80105d14:	53                   	push   %ebx
80105d15:	8b 75 08             	mov    0x8(%ebp),%esi
80105d18:	31 db                	xor    %ebx,%ebx
  pushcli();
80105d1a:	e8 41 ff ff ff       	call   80105c60 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105d1f:	8b 06                	mov    (%esi),%eax
80105d21:	85 c0                	test   %eax,%eax
80105d23:	75 0b                	jne    80105d30 <holding+0x20>
  popcli();
80105d25:	e8 86 ff ff ff       	call   80105cb0 <popcli>
}
80105d2a:	89 d8                	mov    %ebx,%eax
80105d2c:	5b                   	pop    %ebx
80105d2d:	5e                   	pop    %esi
80105d2e:	5d                   	pop    %ebp
80105d2f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105d30:	8b 5e 08             	mov    0x8(%esi),%ebx
80105d33:	e8 78 e9 ff ff       	call   801046b0 <mycpu>
80105d38:	39 c3                	cmp    %eax,%ebx
80105d3a:	0f 94 c3             	sete   %bl
  popcli();
80105d3d:	e8 6e ff ff ff       	call   80105cb0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105d42:	0f b6 db             	movzbl %bl,%ebx
}
80105d45:	89 d8                	mov    %ebx,%eax
80105d47:	5b                   	pop    %ebx
80105d48:	5e                   	pop    %esi
80105d49:	5d                   	pop    %ebp
80105d4a:	c3                   	ret    
80105d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d4f:	90                   	nop

80105d50 <release>:
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	56                   	push   %esi
80105d54:	53                   	push   %ebx
80105d55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105d58:	e8 03 ff ff ff       	call   80105c60 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105d5d:	8b 03                	mov    (%ebx),%eax
80105d5f:	85 c0                	test   %eax,%eax
80105d61:	75 15                	jne    80105d78 <release+0x28>
  popcli();
80105d63:	e8 48 ff ff ff       	call   80105cb0 <popcli>
    panic("release");
80105d68:	83 ec 0c             	sub    $0xc,%esp
80105d6b:	68 ad 97 10 80       	push   $0x801097ad
80105d70:	e8 7b a7 ff ff       	call   801004f0 <panic>
80105d75:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105d78:	8b 73 08             	mov    0x8(%ebx),%esi
80105d7b:	e8 30 e9 ff ff       	call   801046b0 <mycpu>
80105d80:	39 c6                	cmp    %eax,%esi
80105d82:	75 df                	jne    80105d63 <release+0x13>
  popcli();
80105d84:	e8 27 ff ff ff       	call   80105cb0 <popcli>
  lk->pcs[0] = 0;
80105d89:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105d90:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105d97:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105d9c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105da2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105da5:	5b                   	pop    %ebx
80105da6:	5e                   	pop    %esi
80105da7:	5d                   	pop    %ebp
  popcli();
80105da8:	e9 03 ff ff ff       	jmp    80105cb0 <popcli>
80105dad:	8d 76 00             	lea    0x0(%esi),%esi

80105db0 <acquire>:
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	53                   	push   %ebx
80105db4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105db7:	e8 a4 fe ff ff       	call   80105c60 <pushcli>
  if(holding(lk))
80105dbc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105dbf:	e8 9c fe ff ff       	call   80105c60 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105dc4:	8b 03                	mov    (%ebx),%eax
80105dc6:	85 c0                	test   %eax,%eax
80105dc8:	75 7e                	jne    80105e48 <acquire+0x98>
  popcli();
80105dca:	e8 e1 fe ff ff       	call   80105cb0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105dcf:	b9 01 00 00 00       	mov    $0x1,%ecx
80105dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105dd8:	8b 55 08             	mov    0x8(%ebp),%edx
80105ddb:	89 c8                	mov    %ecx,%eax
80105ddd:	f0 87 02             	lock xchg %eax,(%edx)
80105de0:	85 c0                	test   %eax,%eax
80105de2:	75 f4                	jne    80105dd8 <acquire+0x28>
  __sync_synchronize();
80105de4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105de9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105dec:	e8 bf e8 ff ff       	call   801046b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105df1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105df4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105df6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105df9:	31 c0                	xor    %eax,%eax
80105dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105e00:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105e06:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105e0c:	77 1a                	ja     80105e28 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105e0e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105e11:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105e15:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105e18:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105e1a:	83 f8 0a             	cmp    $0xa,%eax
80105e1d:	75 e1                	jne    80105e00 <acquire+0x50>
}
80105e1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e22:	c9                   	leave  
80105e23:	c3                   	ret    
80105e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105e28:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80105e2c:	8d 51 34             	lea    0x34(%ecx),%edx
80105e2f:	90                   	nop
    pcs[i] = 0;
80105e30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105e36:	83 c0 04             	add    $0x4,%eax
80105e39:	39 c2                	cmp    %eax,%edx
80105e3b:	75 f3                	jne    80105e30 <acquire+0x80>
}
80105e3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e40:	c9                   	leave  
80105e41:	c3                   	ret    
80105e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105e48:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105e4b:	e8 60 e8 ff ff       	call   801046b0 <mycpu>
80105e50:	39 c3                	cmp    %eax,%ebx
80105e52:	0f 85 72 ff ff ff    	jne    80105dca <acquire+0x1a>
  popcli();
80105e58:	e8 53 fe ff ff       	call   80105cb0 <popcli>
    panic("acquire");
80105e5d:	83 ec 0c             	sub    $0xc,%esp
80105e60:	68 b5 97 10 80       	push   $0x801097b5
80105e65:	e8 86 a6 ff ff       	call   801004f0 <panic>
80105e6a:	66 90                	xchg   %ax,%ax
80105e6c:	66 90                	xchg   %ax,%ax
80105e6e:	66 90                	xchg   %ax,%ax

80105e70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	57                   	push   %edi
80105e74:	8b 55 08             	mov    0x8(%ebp),%edx
80105e77:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105e7a:	53                   	push   %ebx
80105e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80105e7e:	89 d7                	mov    %edx,%edi
80105e80:	09 cf                	or     %ecx,%edi
80105e82:	83 e7 03             	and    $0x3,%edi
80105e85:	75 29                	jne    80105eb0 <memset+0x40>
    c &= 0xFF;
80105e87:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105e8a:	c1 e0 18             	shl    $0x18,%eax
80105e8d:	89 fb                	mov    %edi,%ebx
80105e8f:	c1 e9 02             	shr    $0x2,%ecx
80105e92:	c1 e3 10             	shl    $0x10,%ebx
80105e95:	09 d8                	or     %ebx,%eax
80105e97:	09 f8                	or     %edi,%eax
80105e99:	c1 e7 08             	shl    $0x8,%edi
80105e9c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105e9e:	89 d7                	mov    %edx,%edi
80105ea0:	fc                   	cld    
80105ea1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105ea3:	5b                   	pop    %ebx
80105ea4:	89 d0                	mov    %edx,%eax
80105ea6:	5f                   	pop    %edi
80105ea7:	5d                   	pop    %ebp
80105ea8:	c3                   	ret    
80105ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105eb0:	89 d7                	mov    %edx,%edi
80105eb2:	fc                   	cld    
80105eb3:	f3 aa                	rep stos %al,%es:(%edi)
80105eb5:	5b                   	pop    %ebx
80105eb6:	89 d0                	mov    %edx,%eax
80105eb8:	5f                   	pop    %edi
80105eb9:	5d                   	pop    %ebp
80105eba:	c3                   	ret    
80105ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ebf:	90                   	nop

80105ec0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	56                   	push   %esi
80105ec4:	8b 75 10             	mov    0x10(%ebp),%esi
80105ec7:	8b 55 08             	mov    0x8(%ebp),%edx
80105eca:	53                   	push   %ebx
80105ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105ece:	85 f6                	test   %esi,%esi
80105ed0:	74 2e                	je     80105f00 <memcmp+0x40>
80105ed2:	01 c6                	add    %eax,%esi
80105ed4:	eb 14                	jmp    80105eea <memcmp+0x2a>
80105ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105edd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105ee0:	83 c0 01             	add    $0x1,%eax
80105ee3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105ee6:	39 f0                	cmp    %esi,%eax
80105ee8:	74 16                	je     80105f00 <memcmp+0x40>
    if(*s1 != *s2)
80105eea:	0f b6 0a             	movzbl (%edx),%ecx
80105eed:	0f b6 18             	movzbl (%eax),%ebx
80105ef0:	38 d9                	cmp    %bl,%cl
80105ef2:	74 ec                	je     80105ee0 <memcmp+0x20>
      return *s1 - *s2;
80105ef4:	0f b6 c1             	movzbl %cl,%eax
80105ef7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105ef9:	5b                   	pop    %ebx
80105efa:	5e                   	pop    %esi
80105efb:	5d                   	pop    %ebp
80105efc:	c3                   	ret    
80105efd:	8d 76 00             	lea    0x0(%esi),%esi
80105f00:	5b                   	pop    %ebx
  return 0;
80105f01:	31 c0                	xor    %eax,%eax
}
80105f03:	5e                   	pop    %esi
80105f04:	5d                   	pop    %ebp
80105f05:	c3                   	ret    
80105f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f0d:	8d 76 00             	lea    0x0(%esi),%esi

80105f10 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	57                   	push   %edi
80105f14:	8b 55 08             	mov    0x8(%ebp),%edx
80105f17:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105f1a:	56                   	push   %esi
80105f1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105f1e:	39 d6                	cmp    %edx,%esi
80105f20:	73 26                	jae    80105f48 <memmove+0x38>
80105f22:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105f25:	39 fa                	cmp    %edi,%edx
80105f27:	73 1f                	jae    80105f48 <memmove+0x38>
80105f29:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105f2c:	85 c9                	test   %ecx,%ecx
80105f2e:	74 0c                	je     80105f3c <memmove+0x2c>
      *--d = *--s;
80105f30:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105f34:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105f37:	83 e8 01             	sub    $0x1,%eax
80105f3a:	73 f4                	jae    80105f30 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105f3c:	5e                   	pop    %esi
80105f3d:	89 d0                	mov    %edx,%eax
80105f3f:	5f                   	pop    %edi
80105f40:	5d                   	pop    %ebp
80105f41:	c3                   	ret    
80105f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105f48:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105f4b:	89 d7                	mov    %edx,%edi
80105f4d:	85 c9                	test   %ecx,%ecx
80105f4f:	74 eb                	je     80105f3c <memmove+0x2c>
80105f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105f58:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105f59:	39 c6                	cmp    %eax,%esi
80105f5b:	75 fb                	jne    80105f58 <memmove+0x48>
}
80105f5d:	5e                   	pop    %esi
80105f5e:	89 d0                	mov    %edx,%eax
80105f60:	5f                   	pop    %edi
80105f61:	5d                   	pop    %ebp
80105f62:	c3                   	ret    
80105f63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105f70:	eb 9e                	jmp    80105f10 <memmove>
80105f72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f80 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	56                   	push   %esi
80105f84:	8b 75 10             	mov    0x10(%ebp),%esi
80105f87:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105f8a:	53                   	push   %ebx
80105f8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80105f8e:	85 f6                	test   %esi,%esi
80105f90:	74 2e                	je     80105fc0 <strncmp+0x40>
80105f92:	01 d6                	add    %edx,%esi
80105f94:	eb 18                	jmp    80105fae <strncmp+0x2e>
80105f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f9d:	8d 76 00             	lea    0x0(%esi),%esi
80105fa0:	38 d8                	cmp    %bl,%al
80105fa2:	75 14                	jne    80105fb8 <strncmp+0x38>
    n--, p++, q++;
80105fa4:	83 c2 01             	add    $0x1,%edx
80105fa7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105faa:	39 f2                	cmp    %esi,%edx
80105fac:	74 12                	je     80105fc0 <strncmp+0x40>
80105fae:	0f b6 01             	movzbl (%ecx),%eax
80105fb1:	0f b6 1a             	movzbl (%edx),%ebx
80105fb4:	84 c0                	test   %al,%al
80105fb6:	75 e8                	jne    80105fa0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105fb8:	29 d8                	sub    %ebx,%eax
}
80105fba:	5b                   	pop    %ebx
80105fbb:	5e                   	pop    %esi
80105fbc:	5d                   	pop    %ebp
80105fbd:	c3                   	ret    
80105fbe:	66 90                	xchg   %ax,%ax
80105fc0:	5b                   	pop    %ebx
    return 0;
80105fc1:	31 c0                	xor    %eax,%eax
}
80105fc3:	5e                   	pop    %esi
80105fc4:	5d                   	pop    %ebp
80105fc5:	c3                   	ret    
80105fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fcd:	8d 76 00             	lea    0x0(%esi),%esi

80105fd0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	57                   	push   %edi
80105fd4:	56                   	push   %esi
80105fd5:	8b 75 08             	mov    0x8(%ebp),%esi
80105fd8:	53                   	push   %ebx
80105fd9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105fdc:	89 f0                	mov    %esi,%eax
80105fde:	eb 15                	jmp    80105ff5 <strncpy+0x25>
80105fe0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105fe4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105fe7:	83 c0 01             	add    $0x1,%eax
80105fea:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80105fee:	88 50 ff             	mov    %dl,-0x1(%eax)
80105ff1:	84 d2                	test   %dl,%dl
80105ff3:	74 09                	je     80105ffe <strncpy+0x2e>
80105ff5:	89 cb                	mov    %ecx,%ebx
80105ff7:	83 e9 01             	sub    $0x1,%ecx
80105ffa:	85 db                	test   %ebx,%ebx
80105ffc:	7f e2                	jg     80105fe0 <strncpy+0x10>
    ;
  while(n-- > 0)
80105ffe:	89 c2                	mov    %eax,%edx
80106000:	85 c9                	test   %ecx,%ecx
80106002:	7e 17                	jle    8010601b <strncpy+0x4b>
80106004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80106008:	83 c2 01             	add    $0x1,%edx
8010600b:	89 c1                	mov    %eax,%ecx
8010600d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80106011:	29 d1                	sub    %edx,%ecx
80106013:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80106017:	85 c9                	test   %ecx,%ecx
80106019:	7f ed                	jg     80106008 <strncpy+0x38>
  return os;
}
8010601b:	5b                   	pop    %ebx
8010601c:	89 f0                	mov    %esi,%eax
8010601e:	5e                   	pop    %esi
8010601f:	5f                   	pop    %edi
80106020:	5d                   	pop    %ebp
80106021:	c3                   	ret    
80106022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106030 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	56                   	push   %esi
80106034:	8b 55 10             	mov    0x10(%ebp),%edx
80106037:	8b 75 08             	mov    0x8(%ebp),%esi
8010603a:	53                   	push   %ebx
8010603b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010603e:	85 d2                	test   %edx,%edx
80106040:	7e 25                	jle    80106067 <safestrcpy+0x37>
80106042:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80106046:	89 f2                	mov    %esi,%edx
80106048:	eb 16                	jmp    80106060 <safestrcpy+0x30>
8010604a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80106050:	0f b6 08             	movzbl (%eax),%ecx
80106053:	83 c0 01             	add    $0x1,%eax
80106056:	83 c2 01             	add    $0x1,%edx
80106059:	88 4a ff             	mov    %cl,-0x1(%edx)
8010605c:	84 c9                	test   %cl,%cl
8010605e:	74 04                	je     80106064 <safestrcpy+0x34>
80106060:	39 d8                	cmp    %ebx,%eax
80106062:	75 ec                	jne    80106050 <safestrcpy+0x20>
    ;
  *s = 0;
80106064:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80106067:	89 f0                	mov    %esi,%eax
80106069:	5b                   	pop    %ebx
8010606a:	5e                   	pop    %esi
8010606b:	5d                   	pop    %ebp
8010606c:	c3                   	ret    
8010606d:	8d 76 00             	lea    0x0(%esi),%esi

80106070 <strlen>:

int
strlen(const char *s)
{
80106070:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80106071:	31 c0                	xor    %eax,%eax
{
80106073:	89 e5                	mov    %esp,%ebp
80106075:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80106078:	80 3a 00             	cmpb   $0x0,(%edx)
8010607b:	74 0c                	je     80106089 <strlen+0x19>
8010607d:	8d 76 00             	lea    0x0(%esi),%esi
80106080:	83 c0 01             	add    $0x1,%eax
80106083:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80106087:	75 f7                	jne    80106080 <strlen+0x10>
    ;
  return n;
}
80106089:	5d                   	pop    %ebp
8010608a:	c3                   	ret    

8010608b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010608b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010608f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80106093:	55                   	push   %ebp
  pushl %ebx
80106094:	53                   	push   %ebx
  pushl %esi
80106095:	56                   	push   %esi
  pushl %edi
80106096:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106097:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80106099:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010609b:	5f                   	pop    %edi
  popl %esi
8010609c:	5e                   	pop    %esi
  popl %ebx
8010609d:	5b                   	pop    %ebx
  popl %ebp
8010609e:	5d                   	pop    %ebp
  ret
8010609f:	c3                   	ret    

801060a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	53                   	push   %ebx
801060a4:	83 ec 04             	sub    $0x4,%esp
801060a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801060aa:	e8 81 e6 ff ff       	call   80104730 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801060af:	8b 40 6c             	mov    0x6c(%eax),%eax
801060b2:	39 d8                	cmp    %ebx,%eax
801060b4:	76 1a                	jbe    801060d0 <fetchint+0x30>
801060b6:	8d 53 04             	lea    0x4(%ebx),%edx
801060b9:	39 d0                	cmp    %edx,%eax
801060bb:	72 13                	jb     801060d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801060bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801060c0:	8b 13                	mov    (%ebx),%edx
801060c2:	89 10                	mov    %edx,(%eax)
  return 0;
801060c4:	31 c0                	xor    %eax,%eax
}
801060c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801060c9:	c9                   	leave  
801060ca:	c3                   	ret    
801060cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060cf:	90                   	nop
    return -1;
801060d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d5:	eb ef                	jmp    801060c6 <fetchint+0x26>
801060d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060de:	66 90                	xchg   %ax,%ax

801060e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	53                   	push   %ebx
801060e4:	83 ec 04             	sub    $0x4,%esp
801060e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801060ea:	e8 41 e6 ff ff       	call   80104730 <myproc>

  if(addr >= curproc->sz)
801060ef:	39 58 6c             	cmp    %ebx,0x6c(%eax)
801060f2:	76 2c                	jbe    80106120 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801060f4:	8b 55 0c             	mov    0xc(%ebp),%edx
801060f7:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801060f9:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
801060fc:	39 d3                	cmp    %edx,%ebx
801060fe:	73 20                	jae    80106120 <fetchstr+0x40>
80106100:	89 d8                	mov    %ebx,%eax
80106102:	eb 0b                	jmp    8010610f <fetchstr+0x2f>
80106104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106108:	83 c0 01             	add    $0x1,%eax
8010610b:	39 c2                	cmp    %eax,%edx
8010610d:	76 11                	jbe    80106120 <fetchstr+0x40>
    if(*s == 0)
8010610f:	80 38 00             	cmpb   $0x0,(%eax)
80106112:	75 f4                	jne    80106108 <fetchstr+0x28>
      return s - *pp;
80106114:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80106116:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106119:	c9                   	leave  
8010611a:	c3                   	ret    
8010611b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010611f:	90                   	nop
80106120:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106123:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106128:	c9                   	leave  
80106129:	c3                   	ret    
8010612a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106130 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	56                   	push   %esi
80106134:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106135:	e8 f6 e5 ff ff       	call   80104730 <myproc>
8010613a:	8b 55 08             	mov    0x8(%ebp),%edx
8010613d:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80106143:	8b 40 44             	mov    0x44(%eax),%eax
80106146:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106149:	e8 e2 e5 ff ff       	call   80104730 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010614e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106151:	8b 40 6c             	mov    0x6c(%eax),%eax
80106154:	39 c6                	cmp    %eax,%esi
80106156:	73 18                	jae    80106170 <argint+0x40>
80106158:	8d 53 08             	lea    0x8(%ebx),%edx
8010615b:	39 d0                	cmp    %edx,%eax
8010615d:	72 11                	jb     80106170 <argint+0x40>
  *ip = *(int*)(addr);
8010615f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106162:	8b 53 04             	mov    0x4(%ebx),%edx
80106165:	89 10                	mov    %edx,(%eax)
  return 0;
80106167:	31 c0                	xor    %eax,%eax
}
80106169:	5b                   	pop    %ebx
8010616a:	5e                   	pop    %esi
8010616b:	5d                   	pop    %ebp
8010616c:	c3                   	ret    
8010616d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106175:	eb f2                	jmp    80106169 <argint+0x39>
80106177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617e:	66 90                	xchg   %ax,%ax

80106180 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	57                   	push   %edi
80106184:	56                   	push   %esi
80106185:	53                   	push   %ebx
80106186:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80106189:	e8 a2 e5 ff ff       	call   80104730 <myproc>
8010618e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106190:	e8 9b e5 ff ff       	call   80104730 <myproc>
80106195:	8b 55 08             	mov    0x8(%ebp),%edx
80106198:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
8010619e:	8b 40 44             	mov    0x44(%eax),%eax
801061a1:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801061a4:	e8 87 e5 ff ff       	call   80104730 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801061a9:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801061ac:	8b 40 6c             	mov    0x6c(%eax),%eax
801061af:	39 c7                	cmp    %eax,%edi
801061b1:	73 35                	jae    801061e8 <argptr+0x68>
801061b3:	8d 4b 08             	lea    0x8(%ebx),%ecx
801061b6:	39 c8                	cmp    %ecx,%eax
801061b8:	72 2e                	jb     801061e8 <argptr+0x68>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801061ba:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801061bd:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801061c0:	85 d2                	test   %edx,%edx
801061c2:	78 24                	js     801061e8 <argptr+0x68>
801061c4:	8b 56 6c             	mov    0x6c(%esi),%edx
801061c7:	39 c2                	cmp    %eax,%edx
801061c9:	76 1d                	jbe    801061e8 <argptr+0x68>
801061cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
801061ce:	01 c3                	add    %eax,%ebx
801061d0:	39 da                	cmp    %ebx,%edx
801061d2:	72 14                	jb     801061e8 <argptr+0x68>
    return -1;
  *pp = (char*)i;
801061d4:	8b 55 0c             	mov    0xc(%ebp),%edx
801061d7:	89 02                	mov    %eax,(%edx)
  return 0;
801061d9:	31 c0                	xor    %eax,%eax
}
801061db:	83 c4 0c             	add    $0xc,%esp
801061de:	5b                   	pop    %ebx
801061df:	5e                   	pop    %esi
801061e0:	5f                   	pop    %edi
801061e1:	5d                   	pop    %ebp
801061e2:	c3                   	ret    
801061e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061e7:	90                   	nop
    return -1;
801061e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061ed:	eb ec                	jmp    801061db <argptr+0x5b>
801061ef:	90                   	nop

801061f0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	56                   	push   %esi
801061f4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801061f5:	e8 36 e5 ff ff       	call   80104730 <myproc>
801061fa:	8b 55 08             	mov    0x8(%ebp),%edx
801061fd:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80106203:	8b 40 44             	mov    0x44(%eax),%eax
80106206:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106209:	e8 22 e5 ff ff       	call   80104730 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010620e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106211:	8b 40 6c             	mov    0x6c(%eax),%eax
80106214:	39 c6                	cmp    %eax,%esi
80106216:	73 40                	jae    80106258 <argstr+0x68>
80106218:	8d 53 08             	lea    0x8(%ebx),%edx
8010621b:	39 d0                	cmp    %edx,%eax
8010621d:	72 39                	jb     80106258 <argstr+0x68>
  *ip = *(int*)(addr);
8010621f:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80106222:	e8 09 e5 ff ff       	call   80104730 <myproc>
  if(addr >= curproc->sz)
80106227:	3b 58 6c             	cmp    0x6c(%eax),%ebx
8010622a:	73 2c                	jae    80106258 <argstr+0x68>
  *pp = (char*)addr;
8010622c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010622f:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80106231:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
80106234:	39 d3                	cmp    %edx,%ebx
80106236:	73 20                	jae    80106258 <argstr+0x68>
80106238:	89 d8                	mov    %ebx,%eax
8010623a:	eb 0b                	jmp    80106247 <argstr+0x57>
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106240:	83 c0 01             	add    $0x1,%eax
80106243:	39 c2                	cmp    %eax,%edx
80106245:	76 11                	jbe    80106258 <argstr+0x68>
    if(*s == 0)
80106247:	80 38 00             	cmpb   $0x0,(%eax)
8010624a:	75 f4                	jne    80106240 <argstr+0x50>
      return s - *pp;
8010624c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010624e:	5b                   	pop    %ebx
8010624f:	5e                   	pop    %esi
80106250:	5d                   	pop    %ebp
80106251:	c3                   	ret    
80106252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106258:	5b                   	pop    %ebx
    return -1;
80106259:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010625e:	5e                   	pop    %esi
8010625f:	5d                   	pop    %ebp
80106260:	c3                   	ret    
80106261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626f:	90                   	nop

80106270 <syscall>:
[SYS_set_burst_confidence] sys_set_burst_confidence,
};

void
syscall(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	53                   	push   %ebx
80106274:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80106277:	e8 b4 e4 ff ff       	call   80104730 <myproc>
8010627c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax; //define syscall number
8010627e:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80106284:	8b 40 1c             	mov    0x1c(%eax),%eax

  if(num<MAX_SYSCALLS && num>0)
80106287:	8d 50 ff             	lea    -0x1(%eax),%edx
8010628a:	83 fa 19             	cmp    $0x19,%edx
8010628d:	77 21                	ja     801062b0 <syscall+0x40>
    curproc->syscalls[num]++;
8010628f:	83 04 83 01          	addl   $0x1,(%ebx,%eax,4)
    
  
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106293:	8b 14 85 e0 97 10 80 	mov    -0x7fef6820(,%eax,4),%edx
8010629a:	85 d2                	test   %edx,%edx
8010629c:	74 17                	je     801062b5 <syscall+0x45>
    curproc->tf->eax = syscalls[num]();
8010629e:	ff d2                	call   *%edx
801062a0:	89 c2                	mov    %eax,%edx
801062a2:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801062a8:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801062ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062ae:	c9                   	leave  
801062af:	c3                   	ret    
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801062b0:	83 fa 1c             	cmp    $0x1c,%edx
801062b3:	76 de                	jbe    80106293 <syscall+0x23>
    cprintf("%d %s: unknown sys call %d\n",
801062b5:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801062b6:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801062bc:	50                   	push   %eax
801062bd:	ff 73 7c             	push   0x7c(%ebx)
801062c0:	68 bd 97 10 80       	push   $0x801097bd
801062c5:	e8 a6 a7 ff ff       	call   80100a70 <cprintf>
    curproc->tf->eax = -1;
801062ca:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801062d0:	83 c4 10             	add    $0x10,%esp
801062d3:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801062da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062dd:	c9                   	leave  
801062de:	c3                   	ret    
801062df:	90                   	nop

801062e0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	57                   	push   %edi
801062e4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801062e5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801062e8:	53                   	push   %ebx
801062e9:	83 ec 34             	sub    $0x34,%esp
801062ec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801062ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801062f2:	57                   	push   %edi
801062f3:	50                   	push   %eax
{
801062f4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801062f7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801062fa:	e8 01 cb ff ff       	call   80102e00 <nameiparent>
801062ff:	83 c4 10             	add    $0x10,%esp
80106302:	85 c0                	test   %eax,%eax
80106304:	0f 84 46 01 00 00    	je     80106450 <create+0x170>
    return 0;
  ilock(dp);
8010630a:	83 ec 0c             	sub    $0xc,%esp
8010630d:	89 c3                	mov    %eax,%ebx
8010630f:	50                   	push   %eax
80106310:	e8 9b c1 ff ff       	call   801024b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80106315:	83 c4 0c             	add    $0xc,%esp
80106318:	6a 00                	push   $0x0
8010631a:	57                   	push   %edi
8010631b:	53                   	push   %ebx
8010631c:	e8 ef c6 ff ff       	call   80102a10 <dirlookup>
80106321:	83 c4 10             	add    $0x10,%esp
80106324:	89 c6                	mov    %eax,%esi
80106326:	85 c0                	test   %eax,%eax
80106328:	74 56                	je     80106380 <create+0xa0>
    iunlockput(dp);
8010632a:	83 ec 0c             	sub    $0xc,%esp
8010632d:	53                   	push   %ebx
8010632e:	e8 0d c4 ff ff       	call   80102740 <iunlockput>
    ilock(ip);
80106333:	89 34 24             	mov    %esi,(%esp)
80106336:	e8 75 c1 ff ff       	call   801024b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010633b:	83 c4 10             	add    $0x10,%esp
8010633e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106343:	75 1b                	jne    80106360 <create+0x80>
80106345:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010634a:	75 14                	jne    80106360 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010634c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010634f:	89 f0                	mov    %esi,%eax
80106351:	5b                   	pop    %ebx
80106352:	5e                   	pop    %esi
80106353:	5f                   	pop    %edi
80106354:	5d                   	pop    %ebp
80106355:	c3                   	ret    
80106356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010635d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80106360:	83 ec 0c             	sub    $0xc,%esp
80106363:	56                   	push   %esi
    return 0;
80106364:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106366:	e8 d5 c3 ff ff       	call   80102740 <iunlockput>
    return 0;
8010636b:	83 c4 10             	add    $0x10,%esp
}
8010636e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106371:	89 f0                	mov    %esi,%eax
80106373:	5b                   	pop    %ebx
80106374:	5e                   	pop    %esi
80106375:	5f                   	pop    %edi
80106376:	5d                   	pop    %ebp
80106377:	c3                   	ret    
80106378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010637f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80106380:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80106384:	83 ec 08             	sub    $0x8,%esp
80106387:	50                   	push   %eax
80106388:	ff 33                	push   (%ebx)
8010638a:	e8 b1 bf ff ff       	call   80102340 <ialloc>
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	89 c6                	mov    %eax,%esi
80106394:	85 c0                	test   %eax,%eax
80106396:	0f 84 cd 00 00 00    	je     80106469 <create+0x189>
  ilock(ip);
8010639c:	83 ec 0c             	sub    $0xc,%esp
8010639f:	50                   	push   %eax
801063a0:	e8 0b c1 ff ff       	call   801024b0 <ilock>
  ip->major = major;
801063a5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801063a9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801063ad:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801063b1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801063b5:	b8 01 00 00 00       	mov    $0x1,%eax
801063ba:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801063be:	89 34 24             	mov    %esi,(%esp)
801063c1:	e8 3a c0 ff ff       	call   80102400 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801063c6:	83 c4 10             	add    $0x10,%esp
801063c9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801063ce:	74 30                	je     80106400 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801063d0:	83 ec 04             	sub    $0x4,%esp
801063d3:	ff 76 04             	push   0x4(%esi)
801063d6:	57                   	push   %edi
801063d7:	53                   	push   %ebx
801063d8:	e8 43 c9 ff ff       	call   80102d20 <dirlink>
801063dd:	83 c4 10             	add    $0x10,%esp
801063e0:	85 c0                	test   %eax,%eax
801063e2:	78 78                	js     8010645c <create+0x17c>
  iunlockput(dp);
801063e4:	83 ec 0c             	sub    $0xc,%esp
801063e7:	53                   	push   %ebx
801063e8:	e8 53 c3 ff ff       	call   80102740 <iunlockput>
  return ip;
801063ed:	83 c4 10             	add    $0x10,%esp
}
801063f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063f3:	89 f0                	mov    %esi,%eax
801063f5:	5b                   	pop    %ebx
801063f6:	5e                   	pop    %esi
801063f7:	5f                   	pop    %edi
801063f8:	5d                   	pop    %ebp
801063f9:	c3                   	ret    
801063fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80106400:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80106403:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80106408:	53                   	push   %ebx
80106409:	e8 f2 bf ff ff       	call   80102400 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010640e:	83 c4 0c             	add    $0xc,%esp
80106411:	ff 76 04             	push   0x4(%esi)
80106414:	68 74 98 10 80       	push   $0x80109874
80106419:	56                   	push   %esi
8010641a:	e8 01 c9 ff ff       	call   80102d20 <dirlink>
8010641f:	83 c4 10             	add    $0x10,%esp
80106422:	85 c0                	test   %eax,%eax
80106424:	78 18                	js     8010643e <create+0x15e>
80106426:	83 ec 04             	sub    $0x4,%esp
80106429:	ff 73 04             	push   0x4(%ebx)
8010642c:	68 73 98 10 80       	push   $0x80109873
80106431:	56                   	push   %esi
80106432:	e8 e9 c8 ff ff       	call   80102d20 <dirlink>
80106437:	83 c4 10             	add    $0x10,%esp
8010643a:	85 c0                	test   %eax,%eax
8010643c:	79 92                	jns    801063d0 <create+0xf0>
      panic("create dots");
8010643e:	83 ec 0c             	sub    $0xc,%esp
80106441:	68 67 98 10 80       	push   $0x80109867
80106446:	e8 a5 a0 ff ff       	call   801004f0 <panic>
8010644b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010644f:	90                   	nop
}
80106450:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106453:	31 f6                	xor    %esi,%esi
}
80106455:	5b                   	pop    %ebx
80106456:	89 f0                	mov    %esi,%eax
80106458:	5e                   	pop    %esi
80106459:	5f                   	pop    %edi
8010645a:	5d                   	pop    %ebp
8010645b:	c3                   	ret    
    panic("create: dirlink");
8010645c:	83 ec 0c             	sub    $0xc,%esp
8010645f:	68 76 98 10 80       	push   $0x80109876
80106464:	e8 87 a0 ff ff       	call   801004f0 <panic>
    panic("create: ialloc");
80106469:	83 ec 0c             	sub    $0xc,%esp
8010646c:	68 58 98 10 80       	push   $0x80109858
80106471:	e8 7a a0 ff ff       	call   801004f0 <panic>
80106476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010647d:	8d 76 00             	lea    0x0(%esi),%esi

80106480 <sys_dup>:
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	56                   	push   %esi
80106484:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106485:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106488:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010648b:	50                   	push   %eax
8010648c:	6a 00                	push   $0x0
8010648e:	e8 9d fc ff ff       	call   80106130 <argint>
80106493:	83 c4 10             	add    $0x10,%esp
80106496:	85 c0                	test   %eax,%eax
80106498:	78 39                	js     801064d3 <sys_dup+0x53>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010649a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010649e:	77 33                	ja     801064d3 <sys_dup+0x53>
801064a0:	e8 8b e2 ff ff       	call   80104730 <myproc>
801064a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064a8:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
801064af:	85 f6                	test   %esi,%esi
801064b1:	74 20                	je     801064d3 <sys_dup+0x53>
  struct proc *curproc = myproc();
801064b3:	e8 78 e2 ff ff       	call   80104730 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801064b8:	31 db                	xor    %ebx,%ebx
801064ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
801064c0:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
801064c7:	85 d2                	test   %edx,%edx
801064c9:	74 1d                	je     801064e8 <sys_dup+0x68>
  for(fd = 0; fd < NOFILE; fd++){
801064cb:	83 c3 01             	add    $0x1,%ebx
801064ce:	83 fb 10             	cmp    $0x10,%ebx
801064d1:	75 ed                	jne    801064c0 <sys_dup+0x40>
}
801064d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801064d6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801064db:	89 d8                	mov    %ebx,%eax
801064dd:	5b                   	pop    %ebx
801064de:	5e                   	pop    %esi
801064df:	5d                   	pop    %ebp
801064e0:	c3                   	ret    
801064e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
801064e8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801064eb:	89 b4 98 94 00 00 00 	mov    %esi,0x94(%eax,%ebx,4)
  filedup(f);
801064f2:	56                   	push   %esi
801064f3:	e8 d8 b6 ff ff       	call   80101bd0 <filedup>
  return fd;
801064f8:	83 c4 10             	add    $0x10,%esp
}
801064fb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801064fe:	89 d8                	mov    %ebx,%eax
80106500:	5b                   	pop    %ebx
80106501:	5e                   	pop    %esi
80106502:	5d                   	pop    %ebp
80106503:	c3                   	ret    
80106504:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010650b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010650f:	90                   	nop

80106510 <sys_read>:
{
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	56                   	push   %esi
80106514:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106515:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106518:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010651b:	53                   	push   %ebx
8010651c:	6a 00                	push   $0x0
8010651e:	e8 0d fc ff ff       	call   80106130 <argint>
80106523:	83 c4 10             	add    $0x10,%esp
80106526:	85 c0                	test   %eax,%eax
80106528:	78 66                	js     80106590 <sys_read+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010652a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010652e:	77 60                	ja     80106590 <sys_read+0x80>
80106530:	e8 fb e1 ff ff       	call   80104730 <myproc>
80106535:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106538:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
8010653f:	85 f6                	test   %esi,%esi
80106541:	74 4d                	je     80106590 <sys_read+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106543:	83 ec 08             	sub    $0x8,%esp
80106546:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106549:	50                   	push   %eax
8010654a:	6a 02                	push   $0x2
8010654c:	e8 df fb ff ff       	call   80106130 <argint>
80106551:	83 c4 10             	add    $0x10,%esp
80106554:	85 c0                	test   %eax,%eax
80106556:	78 38                	js     80106590 <sys_read+0x80>
80106558:	83 ec 04             	sub    $0x4,%esp
8010655b:	ff 75 f0             	push   -0x10(%ebp)
8010655e:	53                   	push   %ebx
8010655f:	6a 01                	push   $0x1
80106561:	e8 1a fc ff ff       	call   80106180 <argptr>
80106566:	83 c4 10             	add    $0x10,%esp
80106569:	85 c0                	test   %eax,%eax
8010656b:	78 23                	js     80106590 <sys_read+0x80>
  return fileread(f, p, n);
8010656d:	83 ec 04             	sub    $0x4,%esp
80106570:	ff 75 f0             	push   -0x10(%ebp)
80106573:	ff 75 f4             	push   -0xc(%ebp)
80106576:	56                   	push   %esi
80106577:	e8 d4 b7 ff ff       	call   80101d50 <fileread>
8010657c:	83 c4 10             	add    $0x10,%esp
}
8010657f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106582:	5b                   	pop    %ebx
80106583:	5e                   	pop    %esi
80106584:	5d                   	pop    %ebp
80106585:	c3                   	ret    
80106586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010658d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106595:	eb e8                	jmp    8010657f <sys_read+0x6f>
80106597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010659e:	66 90                	xchg   %ax,%ax

801065a0 <sys_write>:
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	56                   	push   %esi
801065a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801065a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801065a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801065ab:	53                   	push   %ebx
801065ac:	6a 00                	push   $0x0
801065ae:	e8 7d fb ff ff       	call   80106130 <argint>
801065b3:	83 c4 10             	add    $0x10,%esp
801065b6:	85 c0                	test   %eax,%eax
801065b8:	78 66                	js     80106620 <sys_write+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801065ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801065be:	77 60                	ja     80106620 <sys_write+0x80>
801065c0:	e8 6b e1 ff ff       	call   80104730 <myproc>
801065c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065c8:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
801065cf:	85 f6                	test   %esi,%esi
801065d1:	74 4d                	je     80106620 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801065d3:	83 ec 08             	sub    $0x8,%esp
801065d6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065d9:	50                   	push   %eax
801065da:	6a 02                	push   $0x2
801065dc:	e8 4f fb ff ff       	call   80106130 <argint>
801065e1:	83 c4 10             	add    $0x10,%esp
801065e4:	85 c0                	test   %eax,%eax
801065e6:	78 38                	js     80106620 <sys_write+0x80>
801065e8:	83 ec 04             	sub    $0x4,%esp
801065eb:	ff 75 f0             	push   -0x10(%ebp)
801065ee:	53                   	push   %ebx
801065ef:	6a 01                	push   $0x1
801065f1:	e8 8a fb ff ff       	call   80106180 <argptr>
801065f6:	83 c4 10             	add    $0x10,%esp
801065f9:	85 c0                	test   %eax,%eax
801065fb:	78 23                	js     80106620 <sys_write+0x80>
  return filewrite(f, p, n);
801065fd:	83 ec 04             	sub    $0x4,%esp
80106600:	ff 75 f0             	push   -0x10(%ebp)
80106603:	ff 75 f4             	push   -0xc(%ebp)
80106606:	56                   	push   %esi
80106607:	e8 d4 b7 ff ff       	call   80101de0 <filewrite>
8010660c:	83 c4 10             	add    $0x10,%esp
}
8010660f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106612:	5b                   	pop    %ebx
80106613:	5e                   	pop    %esi
80106614:	5d                   	pop    %ebp
80106615:	c3                   	ret    
80106616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010661d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106625:	eb e8                	jmp    8010660f <sys_write+0x6f>
80106627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010662e:	66 90                	xchg   %ax,%ax

80106630 <sys_close>:
{
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	56                   	push   %esi
80106634:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106635:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106638:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010663b:	50                   	push   %eax
8010663c:	6a 00                	push   $0x0
8010663e:	e8 ed fa ff ff       	call   80106130 <argint>
80106643:	83 c4 10             	add    $0x10,%esp
80106646:	85 c0                	test   %eax,%eax
80106648:	78 3e                	js     80106688 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010664a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010664e:	77 38                	ja     80106688 <sys_close+0x58>
80106650:	e8 db e0 ff ff       	call   80104730 <myproc>
80106655:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106658:	8d 5a 24             	lea    0x24(%edx),%ebx
8010665b:	8b 74 98 04          	mov    0x4(%eax,%ebx,4),%esi
8010665f:	85 f6                	test   %esi,%esi
80106661:	74 25                	je     80106688 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80106663:	e8 c8 e0 ff ff       	call   80104730 <myproc>
  fileclose(f);
80106668:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010666b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
80106672:	00 
  fileclose(f);
80106673:	56                   	push   %esi
80106674:	e8 a7 b5 ff ff       	call   80101c20 <fileclose>
  return 0;
80106679:	83 c4 10             	add    $0x10,%esp
8010667c:	31 c0                	xor    %eax,%eax
}
8010667e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106681:	5b                   	pop    %ebx
80106682:	5e                   	pop    %esi
80106683:	5d                   	pop    %ebp
80106684:	c3                   	ret    
80106685:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106688:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010668d:	eb ef                	jmp    8010667e <sys_close+0x4e>
8010668f:	90                   	nop

80106690 <sys_fstat>:
{
80106690:	55                   	push   %ebp
80106691:	89 e5                	mov    %esp,%ebp
80106693:	56                   	push   %esi
80106694:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106695:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106698:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010669b:	53                   	push   %ebx
8010669c:	6a 00                	push   $0x0
8010669e:	e8 8d fa ff ff       	call   80106130 <argint>
801066a3:	83 c4 10             	add    $0x10,%esp
801066a6:	85 c0                	test   %eax,%eax
801066a8:	78 46                	js     801066f0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801066aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801066ae:	77 40                	ja     801066f0 <sys_fstat+0x60>
801066b0:	e8 7b e0 ff ff       	call   80104730 <myproc>
801066b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066b8:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
801066bf:	85 f6                	test   %esi,%esi
801066c1:	74 2d                	je     801066f0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801066c3:	83 ec 04             	sub    $0x4,%esp
801066c6:	6a 14                	push   $0x14
801066c8:	53                   	push   %ebx
801066c9:	6a 01                	push   $0x1
801066cb:	e8 b0 fa ff ff       	call   80106180 <argptr>
801066d0:	83 c4 10             	add    $0x10,%esp
801066d3:	85 c0                	test   %eax,%eax
801066d5:	78 19                	js     801066f0 <sys_fstat+0x60>
  return filestat(f, st);
801066d7:	83 ec 08             	sub    $0x8,%esp
801066da:	ff 75 f4             	push   -0xc(%ebp)
801066dd:	56                   	push   %esi
801066de:	e8 1d b6 ff ff       	call   80101d00 <filestat>
801066e3:	83 c4 10             	add    $0x10,%esp
}
801066e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801066e9:	5b                   	pop    %ebx
801066ea:	5e                   	pop    %esi
801066eb:	5d                   	pop    %ebp
801066ec:	c3                   	ret    
801066ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801066f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066f5:	eb ef                	jmp    801066e6 <sys_fstat+0x56>
801066f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066fe:	66 90                	xchg   %ax,%ax

80106700 <sys_link>:
{
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	57                   	push   %edi
80106704:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106705:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80106708:	53                   	push   %ebx
80106709:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010670c:	50                   	push   %eax
8010670d:	6a 00                	push   $0x0
8010670f:	e8 dc fa ff ff       	call   801061f0 <argstr>
80106714:	83 c4 10             	add    $0x10,%esp
80106717:	85 c0                	test   %eax,%eax
80106719:	0f 88 fb 00 00 00    	js     8010681a <sys_link+0x11a>
8010671f:	83 ec 08             	sub    $0x8,%esp
80106722:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106725:	50                   	push   %eax
80106726:	6a 01                	push   $0x1
80106728:	e8 c3 fa ff ff       	call   801061f0 <argstr>
8010672d:	83 c4 10             	add    $0x10,%esp
80106730:	85 c0                	test   %eax,%eax
80106732:	0f 88 e2 00 00 00    	js     8010681a <sys_link+0x11a>
  begin_op();
80106738:	e8 63 d3 ff ff       	call   80103aa0 <begin_op>
  if((ip = namei(old)) == 0){
8010673d:	83 ec 0c             	sub    $0xc,%esp
80106740:	ff 75 d4             	push   -0x2c(%ebp)
80106743:	e8 98 c6 ff ff       	call   80102de0 <namei>
80106748:	83 c4 10             	add    $0x10,%esp
8010674b:	89 c3                	mov    %eax,%ebx
8010674d:	85 c0                	test   %eax,%eax
8010674f:	0f 84 e4 00 00 00    	je     80106839 <sys_link+0x139>
  ilock(ip);
80106755:	83 ec 0c             	sub    $0xc,%esp
80106758:	50                   	push   %eax
80106759:	e8 52 bd ff ff       	call   801024b0 <ilock>
  if(ip->type == T_DIR){
8010675e:	83 c4 10             	add    $0x10,%esp
80106761:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106766:	0f 84 b5 00 00 00    	je     80106821 <sys_link+0x121>
  iupdate(ip);
8010676c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010676f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106774:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106777:	53                   	push   %ebx
80106778:	e8 83 bc ff ff       	call   80102400 <iupdate>
  iunlock(ip);
8010677d:	89 1c 24             	mov    %ebx,(%esp)
80106780:	e8 0b be ff ff       	call   80102590 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106785:	58                   	pop    %eax
80106786:	5a                   	pop    %edx
80106787:	57                   	push   %edi
80106788:	ff 75 d0             	push   -0x30(%ebp)
8010678b:	e8 70 c6 ff ff       	call   80102e00 <nameiparent>
80106790:	83 c4 10             	add    $0x10,%esp
80106793:	89 c6                	mov    %eax,%esi
80106795:	85 c0                	test   %eax,%eax
80106797:	74 5b                	je     801067f4 <sys_link+0xf4>
  ilock(dp);
80106799:	83 ec 0c             	sub    $0xc,%esp
8010679c:	50                   	push   %eax
8010679d:	e8 0e bd ff ff       	call   801024b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801067a2:	8b 03                	mov    (%ebx),%eax
801067a4:	83 c4 10             	add    $0x10,%esp
801067a7:	39 06                	cmp    %eax,(%esi)
801067a9:	75 3d                	jne    801067e8 <sys_link+0xe8>
801067ab:	83 ec 04             	sub    $0x4,%esp
801067ae:	ff 73 04             	push   0x4(%ebx)
801067b1:	57                   	push   %edi
801067b2:	56                   	push   %esi
801067b3:	e8 68 c5 ff ff       	call   80102d20 <dirlink>
801067b8:	83 c4 10             	add    $0x10,%esp
801067bb:	85 c0                	test   %eax,%eax
801067bd:	78 29                	js     801067e8 <sys_link+0xe8>
  iunlockput(dp);
801067bf:	83 ec 0c             	sub    $0xc,%esp
801067c2:	56                   	push   %esi
801067c3:	e8 78 bf ff ff       	call   80102740 <iunlockput>
  iput(ip);
801067c8:	89 1c 24             	mov    %ebx,(%esp)
801067cb:	e8 10 be ff ff       	call   801025e0 <iput>
  end_op();
801067d0:	e8 3b d3 ff ff       	call   80103b10 <end_op>
  return 0;
801067d5:	83 c4 10             	add    $0x10,%esp
801067d8:	31 c0                	xor    %eax,%eax
}
801067da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067dd:	5b                   	pop    %ebx
801067de:	5e                   	pop    %esi
801067df:	5f                   	pop    %edi
801067e0:	5d                   	pop    %ebp
801067e1:	c3                   	ret    
801067e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801067e8:	83 ec 0c             	sub    $0xc,%esp
801067eb:	56                   	push   %esi
801067ec:	e8 4f bf ff ff       	call   80102740 <iunlockput>
    goto bad;
801067f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801067f4:	83 ec 0c             	sub    $0xc,%esp
801067f7:	53                   	push   %ebx
801067f8:	e8 b3 bc ff ff       	call   801024b0 <ilock>
  ip->nlink--;
801067fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106802:	89 1c 24             	mov    %ebx,(%esp)
80106805:	e8 f6 bb ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
8010680a:	89 1c 24             	mov    %ebx,(%esp)
8010680d:	e8 2e bf ff ff       	call   80102740 <iunlockput>
  end_op();
80106812:	e8 f9 d2 ff ff       	call   80103b10 <end_op>
  return -1;
80106817:	83 c4 10             	add    $0x10,%esp
8010681a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010681f:	eb b9                	jmp    801067da <sys_link+0xda>
    iunlockput(ip);
80106821:	83 ec 0c             	sub    $0xc,%esp
80106824:	53                   	push   %ebx
80106825:	e8 16 bf ff ff       	call   80102740 <iunlockput>
    end_op();
8010682a:	e8 e1 d2 ff ff       	call   80103b10 <end_op>
    return -1;
8010682f:	83 c4 10             	add    $0x10,%esp
80106832:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106837:	eb a1                	jmp    801067da <sys_link+0xda>
    end_op();
80106839:	e8 d2 d2 ff ff       	call   80103b10 <end_op>
    return -1;
8010683e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106843:	eb 95                	jmp    801067da <sys_link+0xda>
80106845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010684c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106850 <sys_unlink>:
{
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	57                   	push   %edi
80106854:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106855:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106858:	53                   	push   %ebx
80106859:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010685c:	50                   	push   %eax
8010685d:	6a 00                	push   $0x0
8010685f:	e8 8c f9 ff ff       	call   801061f0 <argstr>
80106864:	83 c4 10             	add    $0x10,%esp
80106867:	85 c0                	test   %eax,%eax
80106869:	0f 88 7a 01 00 00    	js     801069e9 <sys_unlink+0x199>
  begin_op();
8010686f:	e8 2c d2 ff ff       	call   80103aa0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106874:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106877:	83 ec 08             	sub    $0x8,%esp
8010687a:	53                   	push   %ebx
8010687b:	ff 75 c0             	push   -0x40(%ebp)
8010687e:	e8 7d c5 ff ff       	call   80102e00 <nameiparent>
80106883:	83 c4 10             	add    $0x10,%esp
80106886:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106889:	85 c0                	test   %eax,%eax
8010688b:	0f 84 62 01 00 00    	je     801069f3 <sys_unlink+0x1a3>
  ilock(dp);
80106891:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106894:	83 ec 0c             	sub    $0xc,%esp
80106897:	57                   	push   %edi
80106898:	e8 13 bc ff ff       	call   801024b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010689d:	58                   	pop    %eax
8010689e:	5a                   	pop    %edx
8010689f:	68 74 98 10 80       	push   $0x80109874
801068a4:	53                   	push   %ebx
801068a5:	e8 46 c1 ff ff       	call   801029f0 <namecmp>
801068aa:	83 c4 10             	add    $0x10,%esp
801068ad:	85 c0                	test   %eax,%eax
801068af:	0f 84 fb 00 00 00    	je     801069b0 <sys_unlink+0x160>
801068b5:	83 ec 08             	sub    $0x8,%esp
801068b8:	68 73 98 10 80       	push   $0x80109873
801068bd:	53                   	push   %ebx
801068be:	e8 2d c1 ff ff       	call   801029f0 <namecmp>
801068c3:	83 c4 10             	add    $0x10,%esp
801068c6:	85 c0                	test   %eax,%eax
801068c8:	0f 84 e2 00 00 00    	je     801069b0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801068ce:	83 ec 04             	sub    $0x4,%esp
801068d1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801068d4:	50                   	push   %eax
801068d5:	53                   	push   %ebx
801068d6:	57                   	push   %edi
801068d7:	e8 34 c1 ff ff       	call   80102a10 <dirlookup>
801068dc:	83 c4 10             	add    $0x10,%esp
801068df:	89 c3                	mov    %eax,%ebx
801068e1:	85 c0                	test   %eax,%eax
801068e3:	0f 84 c7 00 00 00    	je     801069b0 <sys_unlink+0x160>
  ilock(ip);
801068e9:	83 ec 0c             	sub    $0xc,%esp
801068ec:	50                   	push   %eax
801068ed:	e8 be bb ff ff       	call   801024b0 <ilock>
  if(ip->nlink < 1)
801068f2:	83 c4 10             	add    $0x10,%esp
801068f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801068fa:	0f 8e 1c 01 00 00    	jle    80106a1c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106900:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106905:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106908:	74 66                	je     80106970 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010690a:	83 ec 04             	sub    $0x4,%esp
8010690d:	6a 10                	push   $0x10
8010690f:	6a 00                	push   $0x0
80106911:	57                   	push   %edi
80106912:	e8 59 f5 ff ff       	call   80105e70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106917:	6a 10                	push   $0x10
80106919:	ff 75 c4             	push   -0x3c(%ebp)
8010691c:	57                   	push   %edi
8010691d:	ff 75 b4             	push   -0x4c(%ebp)
80106920:	e8 9b bf ff ff       	call   801028c0 <writei>
80106925:	83 c4 20             	add    $0x20,%esp
80106928:	83 f8 10             	cmp    $0x10,%eax
8010692b:	0f 85 de 00 00 00    	jne    80106a0f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80106931:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106936:	0f 84 94 00 00 00    	je     801069d0 <sys_unlink+0x180>
  iunlockput(dp);
8010693c:	83 ec 0c             	sub    $0xc,%esp
8010693f:	ff 75 b4             	push   -0x4c(%ebp)
80106942:	e8 f9 bd ff ff       	call   80102740 <iunlockput>
  ip->nlink--;
80106947:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010694c:	89 1c 24             	mov    %ebx,(%esp)
8010694f:	e8 ac ba ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
80106954:	89 1c 24             	mov    %ebx,(%esp)
80106957:	e8 e4 bd ff ff       	call   80102740 <iunlockput>
  end_op();
8010695c:	e8 af d1 ff ff       	call   80103b10 <end_op>
  return 0;
80106961:	83 c4 10             	add    $0x10,%esp
80106964:	31 c0                	xor    %eax,%eax
}
80106966:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106969:	5b                   	pop    %ebx
8010696a:	5e                   	pop    %esi
8010696b:	5f                   	pop    %edi
8010696c:	5d                   	pop    %ebp
8010696d:	c3                   	ret    
8010696e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106970:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106974:	76 94                	jbe    8010690a <sys_unlink+0xba>
80106976:	be 20 00 00 00       	mov    $0x20,%esi
8010697b:	eb 0b                	jmp    80106988 <sys_unlink+0x138>
8010697d:	8d 76 00             	lea    0x0(%esi),%esi
80106980:	83 c6 10             	add    $0x10,%esi
80106983:	3b 73 58             	cmp    0x58(%ebx),%esi
80106986:	73 82                	jae    8010690a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106988:	6a 10                	push   $0x10
8010698a:	56                   	push   %esi
8010698b:	57                   	push   %edi
8010698c:	53                   	push   %ebx
8010698d:	e8 2e be ff ff       	call   801027c0 <readi>
80106992:	83 c4 10             	add    $0x10,%esp
80106995:	83 f8 10             	cmp    $0x10,%eax
80106998:	75 68                	jne    80106a02 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010699a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010699f:	74 df                	je     80106980 <sys_unlink+0x130>
    iunlockput(ip);
801069a1:	83 ec 0c             	sub    $0xc,%esp
801069a4:	53                   	push   %ebx
801069a5:	e8 96 bd ff ff       	call   80102740 <iunlockput>
    goto bad;
801069aa:	83 c4 10             	add    $0x10,%esp
801069ad:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801069b0:	83 ec 0c             	sub    $0xc,%esp
801069b3:	ff 75 b4             	push   -0x4c(%ebp)
801069b6:	e8 85 bd ff ff       	call   80102740 <iunlockput>
  end_op();
801069bb:	e8 50 d1 ff ff       	call   80103b10 <end_op>
  return -1;
801069c0:	83 c4 10             	add    $0x10,%esp
801069c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069c8:	eb 9c                	jmp    80106966 <sys_unlink+0x116>
801069ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801069d0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801069d3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801069d6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801069db:	50                   	push   %eax
801069dc:	e8 1f ba ff ff       	call   80102400 <iupdate>
801069e1:	83 c4 10             	add    $0x10,%esp
801069e4:	e9 53 ff ff ff       	jmp    8010693c <sys_unlink+0xec>
    return -1;
801069e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069ee:	e9 73 ff ff ff       	jmp    80106966 <sys_unlink+0x116>
    end_op();
801069f3:	e8 18 d1 ff ff       	call   80103b10 <end_op>
    return -1;
801069f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069fd:	e9 64 ff ff ff       	jmp    80106966 <sys_unlink+0x116>
      panic("isdirempty: readi");
80106a02:	83 ec 0c             	sub    $0xc,%esp
80106a05:	68 98 98 10 80       	push   $0x80109898
80106a0a:	e8 e1 9a ff ff       	call   801004f0 <panic>
    panic("unlink: writei");
80106a0f:	83 ec 0c             	sub    $0xc,%esp
80106a12:	68 aa 98 10 80       	push   $0x801098aa
80106a17:	e8 d4 9a ff ff       	call   801004f0 <panic>
    panic("unlink: nlink < 1");
80106a1c:	83 ec 0c             	sub    $0xc,%esp
80106a1f:	68 86 98 10 80       	push   $0x80109886
80106a24:	e8 c7 9a ff ff       	call   801004f0 <panic>
80106a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a30 <sys_open>:

int
sys_open(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	57                   	push   %edi
80106a34:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106a35:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106a38:	53                   	push   %ebx
80106a39:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106a3c:	50                   	push   %eax
80106a3d:	6a 00                	push   $0x0
80106a3f:	e8 ac f7 ff ff       	call   801061f0 <argstr>
80106a44:	83 c4 10             	add    $0x10,%esp
80106a47:	85 c0                	test   %eax,%eax
80106a49:	0f 88 a1 00 00 00    	js     80106af0 <sys_open+0xc0>
80106a4f:	83 ec 08             	sub    $0x8,%esp
80106a52:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106a55:	50                   	push   %eax
80106a56:	6a 01                	push   $0x1
80106a58:	e8 d3 f6 ff ff       	call   80106130 <argint>
80106a5d:	83 c4 10             	add    $0x10,%esp
80106a60:	85 c0                	test   %eax,%eax
80106a62:	0f 88 88 00 00 00    	js     80106af0 <sys_open+0xc0>
    return -1;

  begin_op();
80106a68:	e8 33 d0 ff ff       	call   80103aa0 <begin_op>

  if(omode & O_CREATE){
80106a6d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106a71:	0f 85 89 00 00 00    	jne    80106b00 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106a77:	83 ec 0c             	sub    $0xc,%esp
80106a7a:	ff 75 e0             	push   -0x20(%ebp)
80106a7d:	e8 5e c3 ff ff       	call   80102de0 <namei>
80106a82:	83 c4 10             	add    $0x10,%esp
80106a85:	89 c6                	mov    %eax,%esi
80106a87:	85 c0                	test   %eax,%eax
80106a89:	0f 84 8e 00 00 00    	je     80106b1d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
80106a8f:	83 ec 0c             	sub    $0xc,%esp
80106a92:	50                   	push   %eax
80106a93:	e8 18 ba ff ff       	call   801024b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106a98:	83 c4 10             	add    $0x10,%esp
80106a9b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106aa0:	0f 84 da 00 00 00    	je     80106b80 <sys_open+0x150>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106aa6:	e8 b5 b0 ff ff       	call   80101b60 <filealloc>
80106aab:	89 c7                	mov    %eax,%edi
80106aad:	85 c0                	test   %eax,%eax
80106aaf:	74 2e                	je     80106adf <sys_open+0xaf>
  struct proc *curproc = myproc();
80106ab1:	e8 7a dc ff ff       	call   80104730 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106ab6:	31 db                	xor    %ebx,%ebx
80106ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106abf:	90                   	nop
    if(curproc->ofile[fd] == 0){
80106ac0:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
80106ac7:	85 d2                	test   %edx,%edx
80106ac9:	74 65                	je     80106b30 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
80106acb:	83 c3 01             	add    $0x1,%ebx
80106ace:	83 fb 10             	cmp    $0x10,%ebx
80106ad1:	75 ed                	jne    80106ac0 <sys_open+0x90>
    if(f)
      fileclose(f);
80106ad3:	83 ec 0c             	sub    $0xc,%esp
80106ad6:	57                   	push   %edi
80106ad7:	e8 44 b1 ff ff       	call   80101c20 <fileclose>
80106adc:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106adf:	83 ec 0c             	sub    $0xc,%esp
80106ae2:	56                   	push   %esi
80106ae3:	e8 58 bc ff ff       	call   80102740 <iunlockput>
    end_op();
80106ae8:	e8 23 d0 ff ff       	call   80103b10 <end_op>
    return -1;
80106aed:	83 c4 10             	add    $0x10,%esp
80106af0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106af5:	eb 75                	jmp    80106b6c <sys_open+0x13c>
80106af7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106afe:	66 90                	xchg   %ax,%ax
    ip = create(path, T_FILE, 0, 0);
80106b00:	83 ec 0c             	sub    $0xc,%esp
80106b03:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b06:	31 c9                	xor    %ecx,%ecx
80106b08:	ba 02 00 00 00       	mov    $0x2,%edx
80106b0d:	6a 00                	push   $0x0
80106b0f:	e8 cc f7 ff ff       	call   801062e0 <create>
    if(ip == 0){
80106b14:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80106b17:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106b19:	85 c0                	test   %eax,%eax
80106b1b:	75 89                	jne    80106aa6 <sys_open+0x76>
      end_op();
80106b1d:	e8 ee cf ff ff       	call   80103b10 <end_op>
      return -1;
80106b22:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106b27:	eb 43                	jmp    80106b6c <sys_open+0x13c>
80106b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106b30:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106b33:	89 bc 98 94 00 00 00 	mov    %edi,0x94(%eax,%ebx,4)
  iunlock(ip);
80106b3a:	56                   	push   %esi
80106b3b:	e8 50 ba ff ff       	call   80102590 <iunlock>
  end_op();
80106b40:	e8 cb cf ff ff       	call   80103b10 <end_op>

  f->type = FD_INODE;
80106b45:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106b4b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b4e:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106b51:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106b54:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106b56:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106b5d:	f7 d0                	not    %eax
80106b5f:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b62:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106b65:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b68:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b6f:	89 d8                	mov    %ebx,%eax
80106b71:	5b                   	pop    %ebx
80106b72:	5e                   	pop    %esi
80106b73:	5f                   	pop    %edi
80106b74:	5d                   	pop    %ebp
80106b75:	c3                   	ret    
80106b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106b80:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b83:	85 c9                	test   %ecx,%ecx
80106b85:	0f 84 1b ff ff ff    	je     80106aa6 <sys_open+0x76>
80106b8b:	e9 4f ff ff ff       	jmp    80106adf <sys_open+0xaf>

80106b90 <sys_mkdir>:

int
sys_mkdir(void)
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106b96:	e8 05 cf ff ff       	call   80103aa0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106b9b:	83 ec 08             	sub    $0x8,%esp
80106b9e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ba1:	50                   	push   %eax
80106ba2:	6a 00                	push   $0x0
80106ba4:	e8 47 f6 ff ff       	call   801061f0 <argstr>
80106ba9:	83 c4 10             	add    $0x10,%esp
80106bac:	85 c0                	test   %eax,%eax
80106bae:	78 30                	js     80106be0 <sys_mkdir+0x50>
80106bb0:	83 ec 0c             	sub    $0xc,%esp
80106bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bb6:	31 c9                	xor    %ecx,%ecx
80106bb8:	ba 01 00 00 00       	mov    $0x1,%edx
80106bbd:	6a 00                	push   $0x0
80106bbf:	e8 1c f7 ff ff       	call   801062e0 <create>
80106bc4:	83 c4 10             	add    $0x10,%esp
80106bc7:	85 c0                	test   %eax,%eax
80106bc9:	74 15                	je     80106be0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106bcb:	83 ec 0c             	sub    $0xc,%esp
80106bce:	50                   	push   %eax
80106bcf:	e8 6c bb ff ff       	call   80102740 <iunlockput>
  end_op();
80106bd4:	e8 37 cf ff ff       	call   80103b10 <end_op>
  return 0;
80106bd9:	83 c4 10             	add    $0x10,%esp
80106bdc:	31 c0                	xor    %eax,%eax
}
80106bde:	c9                   	leave  
80106bdf:	c3                   	ret    
    end_op();
80106be0:	e8 2b cf ff ff       	call   80103b10 <end_op>
    return -1;
80106be5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bea:	c9                   	leave  
80106beb:	c3                   	ret    
80106bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bf0 <sys_mknod>:

int
sys_mknod(void)
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106bf6:	e8 a5 ce ff ff       	call   80103aa0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106bfb:	83 ec 08             	sub    $0x8,%esp
80106bfe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106c01:	50                   	push   %eax
80106c02:	6a 00                	push   $0x0
80106c04:	e8 e7 f5 ff ff       	call   801061f0 <argstr>
80106c09:	83 c4 10             	add    $0x10,%esp
80106c0c:	85 c0                	test   %eax,%eax
80106c0e:	78 60                	js     80106c70 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106c10:	83 ec 08             	sub    $0x8,%esp
80106c13:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106c16:	50                   	push   %eax
80106c17:	6a 01                	push   $0x1
80106c19:	e8 12 f5 ff ff       	call   80106130 <argint>
  if((argstr(0, &path)) < 0 ||
80106c1e:	83 c4 10             	add    $0x10,%esp
80106c21:	85 c0                	test   %eax,%eax
80106c23:	78 4b                	js     80106c70 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106c25:	83 ec 08             	sub    $0x8,%esp
80106c28:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c2b:	50                   	push   %eax
80106c2c:	6a 02                	push   $0x2
80106c2e:	e8 fd f4 ff ff       	call   80106130 <argint>
     argint(1, &major) < 0 ||
80106c33:	83 c4 10             	add    $0x10,%esp
80106c36:	85 c0                	test   %eax,%eax
80106c38:	78 36                	js     80106c70 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106c3a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80106c3e:	83 ec 0c             	sub    $0xc,%esp
80106c41:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106c45:	ba 03 00 00 00       	mov    $0x3,%edx
80106c4a:	50                   	push   %eax
80106c4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106c4e:	e8 8d f6 ff ff       	call   801062e0 <create>
     argint(2, &minor) < 0 ||
80106c53:	83 c4 10             	add    $0x10,%esp
80106c56:	85 c0                	test   %eax,%eax
80106c58:	74 16                	je     80106c70 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106c5a:	83 ec 0c             	sub    $0xc,%esp
80106c5d:	50                   	push   %eax
80106c5e:	e8 dd ba ff ff       	call   80102740 <iunlockput>
  end_op();
80106c63:	e8 a8 ce ff ff       	call   80103b10 <end_op>
  return 0;
80106c68:	83 c4 10             	add    $0x10,%esp
80106c6b:	31 c0                	xor    %eax,%eax
}
80106c6d:	c9                   	leave  
80106c6e:	c3                   	ret    
80106c6f:	90                   	nop
    end_op();
80106c70:	e8 9b ce ff ff       	call   80103b10 <end_op>
    return -1;
80106c75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c7a:	c9                   	leave  
80106c7b:	c3                   	ret    
80106c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c80 <sys_chdir>:

int
sys_chdir(void)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	56                   	push   %esi
80106c84:	53                   	push   %ebx
80106c85:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106c88:	e8 a3 da ff ff       	call   80104730 <myproc>
80106c8d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106c8f:	e8 0c ce ff ff       	call   80103aa0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106c94:	83 ec 08             	sub    $0x8,%esp
80106c97:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c9a:	50                   	push   %eax
80106c9b:	6a 00                	push   $0x0
80106c9d:	e8 4e f5 ff ff       	call   801061f0 <argstr>
80106ca2:	83 c4 10             	add    $0x10,%esp
80106ca5:	85 c0                	test   %eax,%eax
80106ca7:	78 77                	js     80106d20 <sys_chdir+0xa0>
80106ca9:	83 ec 0c             	sub    $0xc,%esp
80106cac:	ff 75 f4             	push   -0xc(%ebp)
80106caf:	e8 2c c1 ff ff       	call   80102de0 <namei>
80106cb4:	83 c4 10             	add    $0x10,%esp
80106cb7:	89 c3                	mov    %eax,%ebx
80106cb9:	85 c0                	test   %eax,%eax
80106cbb:	74 63                	je     80106d20 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80106cbd:	83 ec 0c             	sub    $0xc,%esp
80106cc0:	50                   	push   %eax
80106cc1:	e8 ea b7 ff ff       	call   801024b0 <ilock>
  if(ip->type != T_DIR){
80106cc6:	83 c4 10             	add    $0x10,%esp
80106cc9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106cce:	75 30                	jne    80106d00 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106cd0:	83 ec 0c             	sub    $0xc,%esp
80106cd3:	53                   	push   %ebx
80106cd4:	e8 b7 b8 ff ff       	call   80102590 <iunlock>
  iput(curproc->cwd);
80106cd9:	58                   	pop    %eax
80106cda:	ff b6 d4 00 00 00    	push   0xd4(%esi)
80106ce0:	e8 fb b8 ff ff       	call   801025e0 <iput>
  end_op();
80106ce5:	e8 26 ce ff ff       	call   80103b10 <end_op>
  curproc->cwd = ip;
80106cea:	89 9e d4 00 00 00    	mov    %ebx,0xd4(%esi)
  return 0;
80106cf0:	83 c4 10             	add    $0x10,%esp
80106cf3:	31 c0                	xor    %eax,%eax
}
80106cf5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106cf8:	5b                   	pop    %ebx
80106cf9:	5e                   	pop    %esi
80106cfa:	5d                   	pop    %ebp
80106cfb:	c3                   	ret    
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80106d00:	83 ec 0c             	sub    $0xc,%esp
80106d03:	53                   	push   %ebx
80106d04:	e8 37 ba ff ff       	call   80102740 <iunlockput>
    end_op();
80106d09:	e8 02 ce ff ff       	call   80103b10 <end_op>
    return -1;
80106d0e:	83 c4 10             	add    $0x10,%esp
80106d11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d16:	eb dd                	jmp    80106cf5 <sys_chdir+0x75>
80106d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d1f:	90                   	nop
    end_op();
80106d20:	e8 eb cd ff ff       	call   80103b10 <end_op>
    return -1;
80106d25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d2a:	eb c9                	jmp    80106cf5 <sys_chdir+0x75>
80106d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d30 <sys_exec>:

int
sys_exec(void)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106d35:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80106d3b:	53                   	push   %ebx
80106d3c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106d42:	50                   	push   %eax
80106d43:	6a 00                	push   $0x0
80106d45:	e8 a6 f4 ff ff       	call   801061f0 <argstr>
80106d4a:	83 c4 10             	add    $0x10,%esp
80106d4d:	85 c0                	test   %eax,%eax
80106d4f:	0f 88 87 00 00 00    	js     80106ddc <sys_exec+0xac>
80106d55:	83 ec 08             	sub    $0x8,%esp
80106d58:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106d5e:	50                   	push   %eax
80106d5f:	6a 01                	push   $0x1
80106d61:	e8 ca f3 ff ff       	call   80106130 <argint>
80106d66:	83 c4 10             	add    $0x10,%esp
80106d69:	85 c0                	test   %eax,%eax
80106d6b:	78 6f                	js     80106ddc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106d6d:	83 ec 04             	sub    $0x4,%esp
80106d70:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106d76:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106d78:	68 80 00 00 00       	push   $0x80
80106d7d:	6a 00                	push   $0x0
80106d7f:	56                   	push   %esi
80106d80:	e8 eb f0 ff ff       	call   80105e70 <memset>
80106d85:	83 c4 10             	add    $0x10,%esp
80106d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d8f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106d90:	83 ec 08             	sub    $0x8,%esp
80106d93:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106d99:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106da0:	50                   	push   %eax
80106da1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106da7:	01 f8                	add    %edi,%eax
80106da9:	50                   	push   %eax
80106daa:	e8 f1 f2 ff ff       	call   801060a0 <fetchint>
80106daf:	83 c4 10             	add    $0x10,%esp
80106db2:	85 c0                	test   %eax,%eax
80106db4:	78 26                	js     80106ddc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106db6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106dbc:	85 c0                	test   %eax,%eax
80106dbe:	74 30                	je     80106df0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106dc0:	83 ec 08             	sub    $0x8,%esp
80106dc3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106dc6:	52                   	push   %edx
80106dc7:	50                   	push   %eax
80106dc8:	e8 13 f3 ff ff       	call   801060e0 <fetchstr>
80106dcd:	83 c4 10             	add    $0x10,%esp
80106dd0:	85 c0                	test   %eax,%eax
80106dd2:	78 08                	js     80106ddc <sys_exec+0xac>
  for(i=0;; i++){
80106dd4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106dd7:	83 fb 20             	cmp    $0x20,%ebx
80106dda:	75 b4                	jne    80106d90 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80106ddc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80106ddf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106de4:	5b                   	pop    %ebx
80106de5:	5e                   	pop    %esi
80106de6:	5f                   	pop    %edi
80106de7:	5d                   	pop    %ebp
80106de8:	c3                   	ret    
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106df0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106df7:	00 00 00 00 
  return exec(path, argv);
80106dfb:	83 ec 08             	sub    $0x8,%esp
80106dfe:	56                   	push   %esi
80106dff:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106e05:	e8 c6 a9 ff ff       	call   801017d0 <exec>
80106e0a:	83 c4 10             	add    $0x10,%esp
}
80106e0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e10:	5b                   	pop    %ebx
80106e11:	5e                   	pop    %esi
80106e12:	5f                   	pop    %edi
80106e13:	5d                   	pop    %ebp
80106e14:	c3                   	ret    
80106e15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e20 <sys_pipe>:

int
sys_pipe(void)
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106e25:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106e28:	53                   	push   %ebx
80106e29:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106e2c:	6a 08                	push   $0x8
80106e2e:	50                   	push   %eax
80106e2f:	6a 00                	push   $0x0
80106e31:	e8 4a f3 ff ff       	call   80106180 <argptr>
80106e36:	83 c4 10             	add    $0x10,%esp
80106e39:	85 c0                	test   %eax,%eax
80106e3b:	78 4d                	js     80106e8a <sys_pipe+0x6a>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106e3d:	83 ec 08             	sub    $0x8,%esp
80106e40:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106e43:	50                   	push   %eax
80106e44:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106e47:	50                   	push   %eax
80106e48:	e8 23 d3 ff ff       	call   80104170 <pipealloc>
80106e4d:	83 c4 10             	add    $0x10,%esp
80106e50:	85 c0                	test   %eax,%eax
80106e52:	78 36                	js     80106e8a <sys_pipe+0x6a>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106e54:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106e57:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106e59:	e8 d2 d8 ff ff       	call   80104730 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106e5e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106e60:	8b b4 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%esi
80106e67:	85 f6                	test   %esi,%esi
80106e69:	74 2d                	je     80106e98 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
80106e6b:	83 c3 01             	add    $0x1,%ebx
80106e6e:	83 fb 10             	cmp    $0x10,%ebx
80106e71:	75 ed                	jne    80106e60 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106e73:	83 ec 0c             	sub    $0xc,%esp
80106e76:	ff 75 e0             	push   -0x20(%ebp)
80106e79:	e8 a2 ad ff ff       	call   80101c20 <fileclose>
    fileclose(wf);
80106e7e:	58                   	pop    %eax
80106e7f:	ff 75 e4             	push   -0x1c(%ebp)
80106e82:	e8 99 ad ff ff       	call   80101c20 <fileclose>
    return -1;
80106e87:	83 c4 10             	add    $0x10,%esp
80106e8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e8f:	eb 5b                	jmp    80106eec <sys_pipe+0xcc>
80106e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106e98:	8d 73 24             	lea    0x24(%ebx),%esi
80106e9b:	89 7c b0 04          	mov    %edi,0x4(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106e9f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106ea2:	e8 89 d8 ff ff       	call   80104730 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106ea7:	31 d2                	xor    %edx,%edx
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106eb0:	8b 8c 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%ecx
80106eb7:	85 c9                	test   %ecx,%ecx
80106eb9:	74 1d                	je     80106ed8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106ebb:	83 c2 01             	add    $0x1,%edx
80106ebe:	83 fa 10             	cmp    $0x10,%edx
80106ec1:	75 ed                	jne    80106eb0 <sys_pipe+0x90>
      myproc()->ofile[fd0] = 0;
80106ec3:	e8 68 d8 ff ff       	call   80104730 <myproc>
80106ec8:	c7 44 b0 04 00 00 00 	movl   $0x0,0x4(%eax,%esi,4)
80106ecf:	00 
80106ed0:	eb a1                	jmp    80106e73 <sys_pipe+0x53>
80106ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106ed8:	89 bc 90 94 00 00 00 	mov    %edi,0x94(%eax,%edx,4)
  }
  fd[0] = fd0;
80106edf:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106ee2:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106ee4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106ee7:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106eea:	31 c0                	xor    %eax,%eax
}
80106eec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106eef:	5b                   	pop    %ebx
80106ef0:	5e                   	pop    %esi
80106ef1:	5f                   	pop    %edi
80106ef2:	5d                   	pop    %ebp
80106ef3:	c3                   	ret    
80106ef4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106eff:	90                   	nop

80106f00 <sys_move_file>:

int
sys_move_file(void)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
  char *src_file, *dest_dir;
  struct dirent de;
  uint  offset;
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
80106f05:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
{
80106f0b:	53                   	push   %ebx
80106f0c:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
80106f12:	50                   	push   %eax
80106f13:	6a 00                	push   $0x0
80106f15:	e8 d6 f2 ff ff       	call   801061f0 <argstr>
80106f1a:	83 c4 10             	add    $0x10,%esp
80106f1d:	85 c0                	test   %eax,%eax
80106f1f:	0f 88 6c 01 00 00    	js     80107091 <sys_move_file+0x191>
80106f25:	83 ec 08             	sub    $0x8,%esp
80106f28:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
80106f2e:	50                   	push   %eax
80106f2f:	6a 01                	push   $0x1
80106f31:	e8 ba f2 ff ff       	call   801061f0 <argstr>
80106f36:	83 c4 10             	add    $0x10,%esp
80106f39:	85 c0                	test   %eax,%eax
80106f3b:	0f 88 50 01 00 00    	js     80107091 <sys_move_file+0x191>
  {
    return -1;
  }
  begin_op();
80106f41:	e8 5a cb ff ff       	call   80103aa0 <begin_op>

  struct inode *src_ip = namei(src_file);
80106f46:	83 ec 0c             	sub    $0xc,%esp
80106f49:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106f4f:	e8 8c be ff ff       	call   80102de0 <namei>
  if (src_ip == 0)
80106f54:	83 c4 10             	add    $0x10,%esp
  struct inode *src_ip = namei(src_file);
80106f57:	89 c6                	mov    %eax,%esi
  if (src_ip == 0)
80106f59:	85 c0                	test   %eax,%eax
80106f5b:	0f 84 45 01 00 00    	je     801070a6 <sys_move_file+0x1a6>
  {
    cprintf("File not found: %s\n", src_file);
    end_op();
    return -1;
  }
  ilock(src_ip);
80106f61:	83 ec 0c             	sub    $0xc,%esp
80106f64:	50                   	push   %eax
80106f65:	e8 46 b5 ff ff       	call   801024b0 <ilock>
  
  struct inode *dir_ip = namei(dest_dir);
80106f6a:	58                   	pop    %eax
80106f6b:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80106f71:	e8 6a be ff ff       	call   80102de0 <namei>
  if (dir_ip== 0)
80106f76:	83 c4 10             	add    $0x10,%esp
  struct inode *dir_ip = namei(dest_dir);
80106f79:	89 c7                	mov    %eax,%edi
  if (dir_ip== 0)
80106f7b:	85 c0                	test   %eax,%eax
80106f7d:	0f 84 45 01 00 00    	je     801070c8 <sys_move_file+0x1c8>
    cprintf("Directory not found: %s\n", dest_dir);
    iunlockput(src_ip);
    end_op();
    return -1;
  }
  ilock(dir_ip);
80106f83:	83 ec 0c             	sub    $0xc,%esp
80106f86:	50                   	push   %eax
80106f87:	e8 24 b5 ff ff       	call   801024b0 <ilock>

  char filename[128];
  safestrcpy(filename, src_file, sizeof(filename));
80106f8c:	83 c4 0c             	add    $0xc,%esp
80106f8f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106f95:	68 80 00 00 00       	push   $0x80
80106f9a:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106fa0:	50                   	push   %eax
80106fa1:	e8 8a f0 ff ff       	call   80106030 <safestrcpy>
   
  if (dirlink(dir_ip, filename, src_ip->inum) < 0)
80106fa6:	83 c4 0c             	add    $0xc,%esp
80106fa9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106faf:	ff 76 04             	push   0x4(%esi)
80106fb2:	50                   	push   %eax
80106fb3:	57                   	push   %edi
80106fb4:	e8 67 bd ff ff       	call   80102d20 <dirlink>
80106fb9:	83 c4 10             	add    $0x10,%esp
80106fbc:	85 c0                	test   %eax,%eax
80106fbe:	0f 88 dc 00 00 00    	js     801070a0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *dp_parent = nameiparent(src_file,  filename);
80106fc4:	83 ec 08             	sub    $0x8,%esp
80106fc7:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106fcd:	50                   	push   %eax
80106fce:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80106fd4:	e8 27 be ff ff       	call   80102e00 <nameiparent>
  if (dp_parent == 0)
80106fd9:	83 c4 10             	add    $0x10,%esp
  struct inode *dp_parent = nameiparent(src_file,  filename);
80106fdc:	89 c3                	mov    %eax,%ebx
  if (dp_parent == 0)
80106fde:	85 c0                	test   %eax,%eax
80106fe0:	0f 84 ba 00 00 00    	je     801070a0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *ip = dirlookup(dp_parent, filename, &offset);
80106fe6:	83 ec 04             	sub    $0x4,%esp
80106fe9:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
80106fef:	50                   	push   %eax
80106ff0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106ff6:	50                   	push   %eax
80106ff7:	53                   	push   %ebx
80106ff8:	e8 13 ba ff ff       	call   80102a10 <dirlookup>
  if (ip == 0)
80106ffd:	83 c4 10             	add    $0x10,%esp
80107000:	85 c0                	test   %eax,%eax
80107002:	0f 84 98 00 00 00    	je     801070a0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  memset(&de, 0, sizeof(de));
80107008:	83 ec 04             	sub    $0x4,%esp
8010700b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80107011:	6a 10                	push   $0x10
80107013:	6a 00                	push   $0x0
80107015:	52                   	push   %edx
80107016:	e8 55 ee ff ff       	call   80105e70 <memset>
  ilock(dp_parent);
8010701b:	89 1c 24             	mov    %ebx,(%esp)
8010701e:	e8 8d b4 ff ff       	call   801024b0 <ilock>
  if (writei(dp_parent, (char*)&de, offset, sizeof(de)) != sizeof(de))
80107023:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80107029:	6a 10                	push   $0x10
8010702b:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
80107031:	52                   	push   %edx
80107032:	53                   	push   %ebx
80107033:	e8 88 b8 ff ff       	call   801028c0 <writei>
80107038:	83 c4 20             	add    $0x20,%esp
8010703b:	83 f8 10             	cmp    $0x10,%eax
8010703e:	75 30                	jne    80107070 <sys_move_file+0x170>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  iunlockput(src_ip);
80107040:	83 ec 0c             	sub    $0xc,%esp
80107043:	56                   	push   %esi
80107044:	e8 f7 b6 ff ff       	call   80102740 <iunlockput>
  iunlockput(dir_ip);
80107049:	89 3c 24             	mov    %edi,(%esp)
8010704c:	e8 ef b6 ff ff       	call   80102740 <iunlockput>
  iunlockput(dp_parent);
80107051:	89 1c 24             	mov    %ebx,(%esp)
80107054:	e8 e7 b6 ff ff       	call   80102740 <iunlockput>
  end_op();
80107059:	e8 b2 ca ff ff       	call   80103b10 <end_op>
  return 0;
8010705e:	83 c4 10             	add    $0x10,%esp
80107061:	31 c0                	xor    %eax,%eax
80107063:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107066:	5b                   	pop    %ebx
80107067:	5e                   	pop    %esi
80107068:	5f                   	pop    %edi
80107069:	5d                   	pop    %ebp
8010706a:	c3                   	ret    
8010706b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010706f:	90                   	nop
    iunlockput(dp_parent);
80107070:	83 ec 0c             	sub    $0xc,%esp
80107073:	53                   	push   %ebx
80107074:	e8 c7 b6 ff ff       	call   80102740 <iunlockput>
    iunlockput(dir_ip);
80107079:	89 3c 24             	mov    %edi,(%esp)
8010707c:	e8 bf b6 ff ff       	call   80102740 <iunlockput>
    iunlockput(src_ip);
80107081:	89 34 24             	mov    %esi,(%esp)
80107084:	e8 b7 b6 ff ff       	call   80102740 <iunlockput>
    end_op();
80107089:	e8 82 ca ff ff       	call   80103b10 <end_op>
    return -1;
8010708e:	83 c4 10             	add    $0x10,%esp
80107091:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107096:	eb cb                	jmp    80107063 <sys_move_file+0x163>
80107098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010709f:	90                   	nop
    iunlockput(dir_ip);
801070a0:	83 ec 0c             	sub    $0xc,%esp
801070a3:	57                   	push   %edi
801070a4:	eb d6                	jmp    8010707c <sys_move_file+0x17c>
    cprintf("File not found: %s\n", src_file);
801070a6:	83 ec 08             	sub    $0x8,%esp
801070a9:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
801070af:	68 b9 98 10 80       	push   $0x801098b9
801070b4:	e8 b7 99 ff ff       	call   80100a70 <cprintf>
    end_op();
801070b9:	e8 52 ca ff ff       	call   80103b10 <end_op>
    return -1;
801070be:	83 c4 10             	add    $0x10,%esp
801070c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070c6:	eb 9b                	jmp    80107063 <sys_move_file+0x163>
    cprintf("Directory not found: %s\n", dest_dir);
801070c8:	83 ec 08             	sub    $0x8,%esp
801070cb:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
801070d1:	68 cd 98 10 80       	push   $0x801098cd
801070d6:	e8 95 99 ff ff       	call   80100a70 <cprintf>
    iunlockput(src_ip);
801070db:	eb a4                	jmp    80107081 <sys_move_file+0x181>
801070dd:	66 90                	xchg   %ax,%ax
801070df:	90                   	nop

801070e0 <create_palindrome_num>:

#include "syscall.h"
#include "traps.h"


int create_palindrome_num(int num) {
801070e0:	55                   	push   %ebp
801070e1:	89 e5                	mov    %esp,%ebp
801070e3:	57                   	push   %edi
801070e4:	56                   	push   %esi
801070e5:	53                   	push   %ebx
801070e6:	83 ec 4c             	sub    $0x4c,%esp
801070e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    //(20 digits to handle large integers)
    int length = 0;

    // Converting our integer to string
    int temp = num;
    while (temp > 0) {
801070ec:	85 c9                	test   %ecx,%ecx
801070ee:	0f 8e 9c 00 00 00    	jle    80107190 <create_palindrome_num+0xb0>
    int length = 0;
801070f4:	31 f6                	xor    %esi,%esi
801070f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070fd:	8d 76 00             	lea    0x0(%esi),%esi
        str[length++] = (temp % 10) + '0';
80107100:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
80107105:	89 f3                	mov    %esi,%ebx
80107107:	8d 76 01             	lea    0x1(%esi),%esi
8010710a:	f7 e1                	mul    %ecx
8010710c:	89 c8                	mov    %ecx,%eax
8010710e:	c1 ea 03             	shr    $0x3,%edx
80107111:	8d 3c 92             	lea    (%edx,%edx,4),%edi
80107114:	01 ff                	add    %edi,%edi
80107116:	29 f8                	sub    %edi,%eax
80107118:	83 c0 30             	add    $0x30,%eax
8010711b:	88 44 35 ab          	mov    %al,-0x55(%ebp,%esi,1)
        temp /= 10;
8010711f:	89 c8                	mov    %ecx,%eax
80107121:	89 d1                	mov    %edx,%ecx
    while (temp > 0) {
80107123:	83 f8 09             	cmp    $0x9,%eax
80107126:	7f d8                	jg     80107100 <create_palindrome_num+0x20>
    }
    str[length] = '\0'; 
80107128:	8d 45 ac             	lea    -0x54(%ebp),%eax
8010712b:	c6 44 35 ac 00       	movb   $0x0,-0x54(%ebp,%esi,1)

    char palindrome_str[40];  // 2x length buffer to handle the palindrome
    int i, j;
    for (i = 0; i < length; i++) {
80107130:	8d 75 c0             	lea    -0x40(%ebp),%esi
80107133:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80107136:	8d 7c 1d c1          	lea    -0x3f(%ebp,%ebx,1),%edi
8010713a:	89 f0                	mov    %esi,%eax
8010713c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80107140:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < length; i++) {
80107143:	83 c0 01             	add    $0x1,%eax
80107146:	83 ea 01             	sub    $0x1,%edx
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80107149:	88 48 ff             	mov    %cl,-0x1(%eax)
    for (i = 0; i < length; i++) {
8010714c:	39 f8                	cmp    %edi,%eax
8010714e:	75 f0                	jne    80107140 <create_palindrome_num+0x60>
80107150:	31 c0                	xor    %eax,%eax
    }
    for (j = 0; j < length; j++) {
        palindrome_str[i++] = str[j];  // Copying the original part
80107152:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
80107155:	8d 76 00             	lea    0x0(%esi),%esi
80107158:	0f b6 4c 05 ac       	movzbl -0x54(%ebp,%eax,1),%ecx
8010715d:	89 c2                	mov    %eax,%edx
8010715f:	88 4c 07 01          	mov    %cl,0x1(%edi,%eax,1)
    for (j = 0; j < length; j++) {
80107163:	83 c0 01             	add    $0x1,%eax
80107166:	39 d3                	cmp    %edx,%ebx
80107168:	75 ee                	jne    80107158 <create_palindrome_num+0x78>
        palindrome_str[i++] = str[j];  // Copying the original part
8010716a:	8d 44 1b 02          	lea    0x2(%ebx,%ebx,1),%eax
    }
    palindrome_str[i] = '\0';

    cprintf("%s\n", palindrome_str);
8010716e:	83 ec 08             	sub    $0x8,%esp
    palindrome_str[i] = '\0';
80107171:	c6 44 05 c0 00       	movb   $0x0,-0x40(%ebp,%eax,1)
    cprintf("%s\n", palindrome_str);
80107176:	56                   	push   %esi
80107177:	68 c9 98 10 80       	push   $0x801098c9
8010717c:	e8 ef 98 ff ff       	call   80100a70 <cprintf>

    return 0;
}
80107181:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107184:	31 c0                	xor    %eax,%eax
80107186:	5b                   	pop    %ebx
80107187:	5e                   	pop    %esi
80107188:	5f                   	pop    %edi
80107189:	5d                   	pop    %ebp
8010718a:	c3                   	ret    
8010718b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010718f:	90                   	nop
    for (i = 0; i < length; i++) {
80107190:	31 c0                	xor    %eax,%eax
80107192:	8d 75 c0             	lea    -0x40(%ebp),%esi
80107195:	eb d7                	jmp    8010716e <create_palindrome_num+0x8e>
80107197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010719e:	66 90                	xchg   %ax,%ax

801071a0 <sys_create_palindrome>:

int sys_create_palindrome(void) {
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	83 ec 20             	sub    $0x20,%esp
    int num;

    // Receive the integer argument from the REGISTERS
    if (argint(0, &num) < 0)
801071a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801071a9:	50                   	push   %eax
801071aa:	6a 00                	push   $0x0
801071ac:	e8 7f ef ff ff       	call   80106130 <argint>
801071b1:	83 c4 10             	add    $0x10,%esp
801071b4:	85 c0                	test   %eax,%eax
801071b6:	78 18                	js     801071d0 <sys_create_palindrome+0x30>
        return -1;

    // Generate and print the palindrome in kernel level
    create_palindrome_num(num);
801071b8:	83 ec 0c             	sub    $0xc,%esp
801071bb:	ff 75 f4             	push   -0xc(%ebp)
801071be:	e8 1d ff ff ff       	call   801070e0 <create_palindrome_num>

    return 0;
801071c3:	83 c4 10             	add    $0x10,%esp
801071c6:	31 c0                	xor    %eax,%eax
}
801071c8:	c9                   	leave  
801071c9:	c3                   	ret    
801071ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071d0:	c9                   	leave  
        return -1;
801071d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071d6:	c3                   	ret    
801071d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071de:	66 90                	xchg   %ax,%ax

801071e0 <sys_fork>:
};

int
sys_fork(void)
{
  return fork();
801071e0:	e9 4b d9 ff ff       	jmp    80104b30 <fork>
801071e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801071f0 <sys_exit>:
}

int
sys_exit(void)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801071f6:	e8 d5 dd ff ff       	call   80104fd0 <exit>
  return 0;  // not reached
}
801071fb:	31 c0                	xor    %eax,%eax
801071fd:	c9                   	leave  
801071fe:	c3                   	ret    
801071ff:	90                   	nop

80107200 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80107200:	e9 1b df ff ff       	jmp    80105120 <wait>
80107205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010720c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107210 <sys_kill>:
}

int
sys_kill(void)
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80107216:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107219:	50                   	push   %eax
8010721a:	6a 00                	push   $0x0
8010721c:	e8 0f ef ff ff       	call   80106130 <argint>
80107221:	83 c4 10             	add    $0x10,%esp
80107224:	85 c0                	test   %eax,%eax
80107226:	78 18                	js     80107240 <sys_kill+0x30>
    return -1;
  return kill(pid);
80107228:	83 ec 0c             	sub    $0xc,%esp
8010722b:	ff 75 f4             	push   -0xc(%ebp)
8010722e:	e8 bd e1 ff ff       	call   801053f0 <kill>
80107233:	83 c4 10             	add    $0x10,%esp
}
80107236:	c9                   	leave  
80107237:	c3                   	ret    
80107238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010723f:	90                   	nop
80107240:	c9                   	leave  
    return -1;
80107241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107246:	c3                   	ret    
80107247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010724e:	66 90                	xchg   %ax,%ax

80107250 <sys_getpid>:

int
sys_getpid(void)
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80107256:	e8 d5 d4 ff ff       	call   80104730 <myproc>
8010725b:	8b 40 7c             	mov    0x7c(%eax),%eax
}
8010725e:	c9                   	leave  
8010725f:	c3                   	ret    

80107260 <sys_sbrk>:

int
sys_sbrk(void)
{
80107260:	55                   	push   %ebp
80107261:	89 e5                	mov    %esp,%ebp
80107263:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80107264:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80107267:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010726a:	50                   	push   %eax
8010726b:	6a 00                	push   $0x0
8010726d:	e8 be ee ff ff       	call   80106130 <argint>
80107272:	83 c4 10             	add    $0x10,%esp
80107275:	85 c0                	test   %eax,%eax
80107277:	78 27                	js     801072a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80107279:	e8 b2 d4 ff ff       	call   80104730 <myproc>
  if(growproc(n) < 0)
8010727e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80107281:	8b 58 6c             	mov    0x6c(%eax),%ebx
  if(growproc(n) < 0)
80107284:	ff 75 f4             	push   -0xc(%ebp)
80107287:	e8 44 d5 ff ff       	call   801047d0 <growproc>
8010728c:	83 c4 10             	add    $0x10,%esp
8010728f:	85 c0                	test   %eax,%eax
80107291:	78 0d                	js     801072a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80107293:	89 d8                	mov    %ebx,%eax
80107295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107298:	c9                   	leave  
80107299:	c3                   	ret    
8010729a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801072a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801072a5:	eb ec                	jmp    80107293 <sys_sbrk+0x33>
801072a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072ae:	66 90                	xchg   %ax,%ax

801072b0 <sys_sleep>:

int
sys_sleep(void)
{
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801072b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801072b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801072ba:	50                   	push   %eax
801072bb:	6a 00                	push   $0x0
801072bd:	e8 6e ee ff ff       	call   80106130 <argint>
801072c2:	83 c4 10             	add    $0x10,%esp
801072c5:	85 c0                	test   %eax,%eax
801072c7:	0f 88 8a 00 00 00    	js     80107357 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801072cd:	83 ec 0c             	sub    $0xc,%esp
801072d0:	68 20 87 11 80       	push   $0x80118720
801072d5:	e8 d6 ea ff ff       	call   80105db0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801072da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801072dd:	8b 1d 00 87 11 80    	mov    0x80118700,%ebx
  while(ticks - ticks0 < n){
801072e3:	83 c4 10             	add    $0x10,%esp
801072e6:	85 d2                	test   %edx,%edx
801072e8:	75 27                	jne    80107311 <sys_sleep+0x61>
801072ea:	eb 54                	jmp    80107340 <sys_sleep+0x90>
801072ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801072f0:	83 ec 08             	sub    $0x8,%esp
801072f3:	68 20 87 11 80       	push   $0x80118720
801072f8:	68 00 87 11 80       	push   $0x80118700
801072fd:	e8 be df ff ff       	call   801052c0 <sleep>
  while(ticks - ticks0 < n){
80107302:	a1 00 87 11 80       	mov    0x80118700,%eax
80107307:	83 c4 10             	add    $0x10,%esp
8010730a:	29 d8                	sub    %ebx,%eax
8010730c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010730f:	73 2f                	jae    80107340 <sys_sleep+0x90>
    if(myproc()->killed){
80107311:	e8 1a d4 ff ff       	call   80104730 <myproc>
80107316:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010731c:	85 c0                	test   %eax,%eax
8010731e:	74 d0                	je     801072f0 <sys_sleep+0x40>
      release(&tickslock);
80107320:	83 ec 0c             	sub    $0xc,%esp
80107323:	68 20 87 11 80       	push   $0x80118720
80107328:	e8 23 ea ff ff       	call   80105d50 <release>
  }
  release(&tickslock);
  return 0;
}
8010732d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80107330:	83 c4 10             	add    $0x10,%esp
80107333:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107338:	c9                   	leave  
80107339:	c3                   	ret    
8010733a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&tickslock);
80107340:	83 ec 0c             	sub    $0xc,%esp
80107343:	68 20 87 11 80       	push   $0x80118720
80107348:	e8 03 ea ff ff       	call   80105d50 <release>
  return 0;
8010734d:	83 c4 10             	add    $0x10,%esp
80107350:	31 c0                	xor    %eax,%eax
}
80107352:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107355:	c9                   	leave  
80107356:	c3                   	ret    
    return -1;
80107357:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010735c:	eb f4                	jmp    80107352 <sys_sleep+0xa2>
8010735e:	66 90                	xchg   %ax,%ax

80107360 <sys_sort_syscalls>:

int sys_sort_syscalls(void)
{
80107360:	55                   	push   %ebp
80107361:	89 e5                	mov    %esp,%ebp
80107363:	57                   	push   %edi
80107364:	56                   	push   %esi
  int pid;
  int counts[MAX_SYSCALLS];
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
80107365:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
{
8010736b:	53                   	push   %ebx
8010736c:	81 ec 84 00 00 00    	sub    $0x84,%esp
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
80107372:	50                   	push   %eax
80107373:	6a 00                	push   $0x0
80107375:	e8 b6 ed ff ff       	call   80106130 <argint>
8010737a:	83 c4 10             	add    $0x10,%esp
8010737d:	85 c0                	test   %eax,%eax
8010737f:	78 71                	js     801073f2 <sys_sort_syscalls+0x92>
80107381:	83 ec 04             	sub    $0x4,%esp
80107384:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
8010738a:	6a 00                	push   $0x0
8010738c:	50                   	push   %eax
8010738d:	6a 00                	push   $0x0
8010738f:	e8 ec ed ff ff       	call   80106180 <argptr>
80107394:	83 c4 10             	add    $0x10,%esp
80107397:	89 c7                	mov    %eax,%edi
80107399:	85 c0                	test   %eax,%eax
8010739b:	75 55                	jne    801073f2 <sys_sort_syscalls+0x92>
    return -1;
  
  struct proc *p = findproc(pid);
8010739d:	83 ec 0c             	sub    $0xc,%esp
801073a0:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
801073a6:	e8 b5 d3 ff ff       	call   80104760 <findproc>
  if(p==0) return -1;
801073ab:	83 c4 10             	add    $0x10,%esp
  struct proc *p = findproc(pid);
801073ae:	89 c6                	mov    %eax,%esi
  if(p==0) return -1;
801073b0:	85 c0                	test   %eax,%eax
801073b2:	74 3e                	je     801073f2 <sys_sort_syscalls+0x92>
  for(int i=0; i<MAX_SYSCALLS; i++)
801073b4:	31 db                	xor    %ebx,%ebx
801073b6:	eb 10                	jmp    801073c8 <sys_sort_syscalls+0x68>
801073b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073bf:	90                   	nop
801073c0:	83 c3 01             	add    $0x1,%ebx
801073c3:	83 fb 1b             	cmp    $0x1b,%ebx
801073c6:	74 20                	je     801073e8 <sys_sort_syscalls+0x88>
  {
    if(p->syscalls[i] != 0)
801073c8:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
801073cb:	85 c0                	test   %eax,%eax
801073cd:	74 f1                	je     801073c0 <sys_sort_syscalls+0x60>
      cprintf("%d\n", i);
801073cf:	83 ec 08             	sub    $0x8,%esp
801073d2:	53                   	push   %ebx
  for(int i=0; i<MAX_SYSCALLS; i++)
801073d3:	83 c3 01             	add    $0x1,%ebx
      cprintf("%d\n", i);
801073d6:	68 ce 95 10 80       	push   $0x801095ce
801073db:	e8 90 96 ff ff       	call   80100a70 <cprintf>
801073e0:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<MAX_SYSCALLS; i++)
801073e3:	83 fb 1b             	cmp    $0x1b,%ebx
801073e6:	75 e0                	jne    801073c8 <sys_sort_syscalls+0x68>

  }
  return 0;
}
801073e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073eb:	89 f8                	mov    %edi,%eax
801073ed:	5b                   	pop    %ebx
801073ee:	5e                   	pop    %esi
801073ef:	5f                   	pop    %edi
801073f0:	5d                   	pop    %ebp
801073f1:	c3                   	ret    
    return -1;
801073f2:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801073f7:	eb ef                	jmp    801073e8 <sys_sort_syscalls+0x88>
801073f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107400 <sys_get_most_syscalls>:

int sys_get_most_syscalls(void)
{
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid)<0 , sizeof(int)*MAX_SYSCALLS<0)
80107406:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107409:	50                   	push   %eax
8010740a:	6a 00                	push   $0x0
8010740c:	e8 1f ed ff ff       	call   80106130 <argint>
    return -1;
  
  struct proc *p = findproc(pid);
80107411:	58                   	pop    %eax
80107412:	ff 75 f4             	push   -0xc(%ebp)
80107415:	e8 46 d3 ff ff       	call   80104760 <findproc>
  if(p==0) return -1;
8010741a:	83 c4 10             	add    $0x10,%esp
8010741d:	85 c0                	test   %eax,%eax
8010741f:	74 3f                	je     80107460 <sys_get_most_syscalls+0x60>
  int syscall_most_invoked = -1;
  for(int i=0; i<MAX_SYSCALLS; i++)
80107421:	31 d2                	xor    %edx,%edx
  int syscall_most_invoked = -1;
80107423:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010742f:	90                   	nop
    if(p->syscalls[i] > syscall_most_invoked)
80107430:	39 0c 90             	cmp    %ecx,(%eax,%edx,4)
80107433:	0f 4f ca             	cmovg  %edx,%ecx
  for(int i=0; i<MAX_SYSCALLS; i++)
80107436:	83 c2 01             	add    $0x1,%edx
80107439:	83 fa 1b             	cmp    $0x1b,%edx
8010743c:	75 f2                	jne    80107430 <sys_get_most_syscalls+0x30>
      syscall_most_invoked = i;
  if(syscall_most_invoked<0) return -1;
8010743e:	85 c9                	test   %ecx,%ecx
80107440:	78 1e                	js     80107460 <sys_get_most_syscalls+0x60>
  cprintf("System call been most invoked: %s - %d times", syscall_names[syscall_most_invoked], p->syscalls[syscall_most_invoked]);
80107442:	83 ec 04             	sub    $0x4,%esp
80107445:	ff 34 88             	push   (%eax,%ecx,4)
80107448:	ff 34 8d 20 c0 10 80 	push   -0x7fef3fe0(,%ecx,4)
8010744f:	68 38 99 10 80       	push   $0x80109938
80107454:	e8 17 96 ff ff       	call   80100a70 <cprintf>
  return 0;
80107459:	83 c4 10             	add    $0x10,%esp
8010745c:	31 c0                	xor    %eax,%eax
}
8010745e:	c9                   	leave  
8010745f:	c3                   	ret    
80107460:	c9                   	leave  
  if(p==0) return -1;
80107461:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107466:	c3                   	ret    
80107467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010746e:	66 90                	xchg   %ax,%ax

80107470 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	53                   	push   %ebx
80107474:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80107477:	68 20 87 11 80       	push   $0x80118720
8010747c:	e8 2f e9 ff ff       	call   80105db0 <acquire>
  xticks = ticks;
80107481:	8b 1d 00 87 11 80    	mov    0x80118700,%ebx
  release(&tickslock);
80107487:	c7 04 24 20 87 11 80 	movl   $0x80118720,(%esp)
8010748e:	e8 bd e8 ff ff       	call   80105d50 <release>
  return xticks;
}
80107493:	89 d8                	mov    %ebx,%eax
80107495:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107498:	c9                   	leave  
80107499:	c3                   	ret    
8010749a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074a0 <sys_list_active_processes>:


int sys_list_active_processes(void) {
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	83 ec 08             	sub    $0x8,%esp
    list_active_processes();
801074a6:	e8 85 e0 ff ff       	call   80105530 <list_active_processes>
    return 0;  // Return 0 to indicate success
}
801074ab:	31 c0                	xor    %eax,%eax
801074ad:	c9                   	leave  
801074ae:	c3                   	ret    
801074af:	90                   	nop

801074b0 <sys_set_level>:

int sys_set_level(int pid, int level)
{
  int res = set_level(pid,level);
801074b0:	e9 bb d4 ff ff       	jmp    80104970 <set_level>
801074b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801074c0 <sys_show_process_info>:
  return res;
}

void sys_show_process_info()
{
  show_process_info();
801074c0:	e9 7b e1 ff ff       	jmp    80105640 <show_process_info>
801074c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801074d0 <sys_set_burst_confidence>:
}

void sys_set_burst_confidence(void)
{
801074d0:	55                   	push   %ebp
801074d1:	89 e5                	mov    %esp,%ebp
801074d3:	83 ec 20             	sub    $0x20,%esp
  int pid, burst, conf;
  if(argint(0,&pid)<0||argint(1,&burst)<0|| argint(2,&conf)<0)
801074d6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801074d9:	50                   	push   %eax
801074da:	6a 00                	push   $0x0
801074dc:	e8 4f ec ff ff       	call   80106130 <argint>
801074e1:	83 c4 10             	add    $0x10,%esp
801074e4:	85 c0                	test   %eax,%eax
801074e6:	78 3e                	js     80107526 <sys_set_burst_confidence+0x56>
801074e8:	83 ec 08             	sub    $0x8,%esp
801074eb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801074ee:	50                   	push   %eax
801074ef:	6a 01                	push   $0x1
801074f1:	e8 3a ec ff ff       	call   80106130 <argint>
801074f6:	83 c4 10             	add    $0x10,%esp
801074f9:	85 c0                	test   %eax,%eax
801074fb:	78 29                	js     80107526 <sys_set_burst_confidence+0x56>
801074fd:	83 ec 08             	sub    $0x8,%esp
80107500:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107503:	50                   	push   %eax
80107504:	6a 02                	push   $0x2
80107506:	e8 25 ec ff ff       	call   80106130 <argint>
8010750b:	83 c4 10             	add    $0x10,%esp
8010750e:	85 c0                	test   %eax,%eax
80107510:	78 14                	js     80107526 <sys_set_burst_confidence+0x56>
    return;
  set_burst_confidence(pid, burst, conf);
80107512:	83 ec 04             	sub    $0x4,%esp
80107515:	ff 75 f4             	push   -0xc(%ebp)
80107518:	ff 75 f0             	push   -0x10(%ebp)
8010751b:	ff 75 ec             	push   -0x14(%ebp)
8010751e:	e8 fd e4 ff ff       	call   80105a20 <set_burst_confidence>
80107523:	83 c4 10             	add    $0x10,%esp
}
80107526:	c9                   	leave  
80107527:	c3                   	ret    

80107528 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107528:	1e                   	push   %ds
  pushl %es
80107529:	06                   	push   %es
  pushl %fs
8010752a:	0f a0                	push   %fs
  pushl %gs
8010752c:	0f a8                	push   %gs
  pushal
8010752e:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010752f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107533:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107535:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107537:	54                   	push   %esp
  call trap
80107538:	e8 c3 00 00 00       	call   80107600 <trap>
  addl $4, %esp
8010753d:	83 c4 04             	add    $0x4,%esp

80107540 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80107540:	61                   	popa   
  popl %gs
80107541:	0f a9                	pop    %gs
  popl %fs
80107543:	0f a1                	pop    %fs
  popl %es
80107545:	07                   	pop    %es
  popl %ds
80107546:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107547:	83 c4 08             	add    $0x8,%esp
  iret
8010754a:	cf                   	iret   
8010754b:	66 90                	xchg   %ax,%ax
8010754d:	66 90                	xchg   %ax,%ax
8010754f:	90                   	nop

80107550 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107550:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107551:	31 c0                	xor    %eax,%eax
{
80107553:	89 e5                	mov    %esp,%ebp
80107555:	83 ec 08             	sub    $0x8,%esp
80107558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010755f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107560:	8b 14 85 78 c0 10 80 	mov    -0x7fef3f88(,%eax,4),%edx
80107567:	c7 04 c5 62 87 11 80 	movl   $0x8e000008,-0x7fee789e(,%eax,8)
8010756e:	08 00 00 8e 
80107572:	66 89 14 c5 60 87 11 	mov    %dx,-0x7fee78a0(,%eax,8)
80107579:	80 
8010757a:	c1 ea 10             	shr    $0x10,%edx
8010757d:	66 89 14 c5 66 87 11 	mov    %dx,-0x7fee789a(,%eax,8)
80107584:	80 
  for(i = 0; i < 256; i++)
80107585:	83 c0 01             	add    $0x1,%eax
80107588:	3d 00 01 00 00       	cmp    $0x100,%eax
8010758d:	75 d1                	jne    80107560 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010758f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107592:	a1 78 c1 10 80       	mov    0x8010c178,%eax
80107597:	c7 05 62 89 11 80 08 	movl   $0xef000008,0x80118962
8010759e:	00 00 ef 
  initlock(&tickslock, "time");
801075a1:	68 19 99 10 80       	push   $0x80109919
801075a6:	68 20 87 11 80       	push   $0x80118720
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801075ab:	66 a3 60 89 11 80    	mov    %ax,0x80118960
801075b1:	c1 e8 10             	shr    $0x10,%eax
801075b4:	66 a3 66 89 11 80    	mov    %ax,0x80118966
  initlock(&tickslock, "time");
801075ba:	e8 21 e6 ff ff       	call   80105be0 <initlock>
}
801075bf:	83 c4 10             	add    $0x10,%esp
801075c2:	c9                   	leave  
801075c3:	c3                   	ret    
801075c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075cf:	90                   	nop

801075d0 <idtinit>:

void
idtinit(void)
{
801075d0:	55                   	push   %ebp
  pd[0] = size-1;
801075d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801075d6:	89 e5                	mov    %esp,%ebp
801075d8:	83 ec 10             	sub    $0x10,%esp
801075db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801075df:	b8 60 87 11 80       	mov    $0x80118760,%eax
801075e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801075e8:	c1 e8 10             	shr    $0x10,%eax
801075eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801075ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801075f2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801075f5:	c9                   	leave  
801075f6:	c3                   	ret    
801075f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075fe:	66 90                	xchg   %ax,%ax

80107600 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	57                   	push   %edi
80107604:	56                   	push   %esi
80107605:	53                   	push   %ebx
80107606:	83 ec 1c             	sub    $0x1c,%esp
80107609:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010760c:	8b 43 30             	mov    0x30(%ebx),%eax
8010760f:	83 f8 40             	cmp    $0x40,%eax
80107612:	0f 84 90 01 00 00    	je     801077a8 <trap+0x1a8>
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }
  switch(tf->trapno){
80107618:	83 e8 20             	sub    $0x20,%eax
8010761b:	83 f8 1f             	cmp    $0x1f,%eax
8010761e:	0f 87 8c 00 00 00    	ja     801076b0 <trap+0xb0>
80107624:	ff 24 85 20 9a 10 80 	jmp    *-0x7fef65e0(,%eax,4)
8010762b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010762f:	90                   	nop
      aging();
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107630:	e8 4b b9 ff ff       	call   80102f80 <ideintr>
    lapiceoi();
80107635:	e8 16 c0 ff ff       	call   80103650 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010763a:	e8 f1 d0 ff ff       	call   80104730 <myproc>
8010763f:	85 c0                	test   %eax,%eax
80107641:	74 20                	je     80107663 <trap+0x63>
80107643:	e8 e8 d0 ff ff       	call   80104730 <myproc>
80107648:	8b b0 90 00 00 00    	mov    0x90(%eax),%esi
8010764e:	85 f6                	test   %esi,%esi
80107650:	74 11                	je     80107663 <trap+0x63>
80107652:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107656:	83 e0 03             	and    $0x3,%eax
80107659:	66 83 f8 03          	cmp    $0x3,%ax
8010765d:	0f 84 1d 02 00 00    	je     80107880 <trap+0x280>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107663:	e8 c8 d0 ff ff       	call   80104730 <myproc>
80107668:	85 c0                	test   %eax,%eax
8010766a:	74 0f                	je     8010767b <trap+0x7b>
8010766c:	e8 bf d0 ff ff       	call   80104730 <myproc>
80107671:	83 78 78 04          	cmpl   $0x4,0x78(%eax)
80107675:	0f 84 c5 00 00 00    	je     80107740 <trap+0x140>
      myproc()->sched_info.num_of_cycles = 0;
      yield();
    }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010767b:	e8 b0 d0 ff ff       	call   80104730 <myproc>
80107680:	85 c0                	test   %eax,%eax
80107682:	74 20                	je     801076a4 <trap+0xa4>
80107684:	e8 a7 d0 ff ff       	call   80104730 <myproc>
80107689:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010768f:	85 c0                	test   %eax,%eax
80107691:	74 11                	je     801076a4 <trap+0xa4>
80107693:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107697:	83 e0 03             	and    $0x3,%eax
8010769a:	66 83 f8 03          	cmp    $0x3,%ax
8010769e:	0f 84 3a 01 00 00    	je     801077de <trap+0x1de>
    exit();
}
801076a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076a7:	5b                   	pop    %ebx
801076a8:	5e                   	pop    %esi
801076a9:	5f                   	pop    %edi
801076aa:	5d                   	pop    %ebp
801076ab:	c3                   	ret    
801076ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801076b0:	e8 7b d0 ff ff       	call   80104730 <myproc>
801076b5:	8b 7b 38             	mov    0x38(%ebx),%edi
801076b8:	85 c0                	test   %eax,%eax
801076ba:	0f 84 6a 02 00 00    	je     8010792a <trap+0x32a>
801076c0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801076c4:	0f 84 60 02 00 00    	je     8010792a <trap+0x32a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801076ca:	0f 20 d1             	mov    %cr2,%ecx
801076cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801076d0:	e8 3b d0 ff ff       	call   80104710 <cpuid>
801076d5:	8b 73 30             	mov    0x30(%ebx),%esi
801076d8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801076db:	8b 43 34             	mov    0x34(%ebx),%eax
801076de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801076e1:	e8 4a d0 ff ff       	call   80104730 <myproc>
801076e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801076e9:	e8 42 d0 ff ff       	call   80104730 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801076ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801076f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801076f4:	51                   	push   %ecx
801076f5:	57                   	push   %edi
801076f6:	52                   	push   %edx
801076f7:	ff 75 e4             	push   -0x1c(%ebp)
801076fa:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801076fb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801076fe:	81 c6 d8 00 00 00    	add    $0xd8,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107704:	56                   	push   %esi
80107705:	ff 70 7c             	push   0x7c(%eax)
80107708:	68 dc 99 10 80       	push   $0x801099dc
8010770d:	e8 5e 93 ff ff       	call   80100a70 <cprintf>
    myproc()->killed = 1;
80107712:	83 c4 20             	add    $0x20,%esp
80107715:	e8 16 d0 ff ff       	call   80104730 <myproc>
8010771a:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
80107721:	00 00 00 
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107724:	e8 07 d0 ff ff       	call   80104730 <myproc>
80107729:	85 c0                	test   %eax,%eax
8010772b:	0f 85 12 ff ff ff    	jne    80107643 <trap+0x43>
80107731:	e9 2d ff ff ff       	jmp    80107663 <trap+0x63>
80107736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010773d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107740:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80107744:	0f 85 31 ff ff ff    	jne    8010767b <trap+0x7b>
    if(myproc()->sched_info.num_of_cycles<5)
8010774a:	e8 e1 cf ff ff       	call   80104730 <myproc>
8010774f:	83 b8 08 01 00 00 04 	cmpl   $0x4,0x108(%eax)
80107756:	0f 8f 44 01 00 00    	jg     801078a0 <trap+0x2a0>
      myproc()->sched_info.num_of_cycles++;
8010775c:	e8 cf cf ff ff       	call   80104730 <myproc>
80107761:	83 80 08 01 00 00 01 	addl   $0x1,0x108(%eax)
80107768:	e9 0e ff ff ff       	jmp    8010767b <trap+0x7b>
8010776d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107770:	8b 7b 38             	mov    0x38(%ebx),%edi
80107773:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107777:	e8 94 cf ff ff       	call   80104710 <cpuid>
8010777c:	57                   	push   %edi
8010777d:	56                   	push   %esi
8010777e:	50                   	push   %eax
8010777f:	68 84 99 10 80       	push   $0x80109984
80107784:	e8 e7 92 ff ff       	call   80100a70 <cprintf>
    lapiceoi();
80107789:	e8 c2 be ff ff       	call   80103650 <lapiceoi>
    break;
8010778e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107791:	e8 9a cf ff ff       	call   80104730 <myproc>
80107796:	85 c0                	test   %eax,%eax
80107798:	0f 85 a5 fe ff ff    	jne    80107643 <trap+0x43>
8010779e:	e9 c0 fe ff ff       	jmp    80107663 <trap+0x63>
801077a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077a7:	90                   	nop
    if(myproc()->killed)
801077a8:	e8 83 cf ff ff       	call   80104730 <myproc>
801077ad:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801077b3:	85 c0                	test   %eax,%eax
801077b5:	0f 85 d5 00 00 00    	jne    80107890 <trap+0x290>
    myproc()->tf = tf;
801077bb:	e8 70 cf ff ff       	call   80104730 <myproc>
801077c0:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
801077c6:	e8 a5 ea ff ff       	call   80106270 <syscall>
    if(myproc()->killed)
801077cb:	e8 60 cf ff ff       	call   80104730 <myproc>
801077d0:	8b b8 90 00 00 00    	mov    0x90(%eax),%edi
801077d6:	85 ff                	test   %edi,%edi
801077d8:	0f 84 c6 fe ff ff    	je     801076a4 <trap+0xa4>
}
801077de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077e1:	5b                   	pop    %ebx
801077e2:	5e                   	pop    %esi
801077e3:	5f                   	pop    %edi
801077e4:	5d                   	pop    %ebp
      exit();
801077e5:	e9 e6 d7 ff ff       	jmp    80104fd0 <exit>
801077ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartintr();
801077f0:	e8 db 02 00 00       	call   80107ad0 <uartintr>
    lapiceoi();
801077f5:	e8 56 be ff ff       	call   80103650 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801077fa:	e8 31 cf ff ff       	call   80104730 <myproc>
801077ff:	85 c0                	test   %eax,%eax
80107801:	0f 85 3c fe ff ff    	jne    80107643 <trap+0x43>
80107807:	e9 57 fe ff ff       	jmp    80107663 <trap+0x63>
8010780c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107810:	e8 fb bc ff ff       	call   80103510 <kbdintr>
    lapiceoi();
80107815:	e8 36 be ff ff       	call   80103650 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010781a:	e8 11 cf ff ff       	call   80104730 <myproc>
8010781f:	85 c0                	test   %eax,%eax
80107821:	0f 85 1c fe ff ff    	jne    80107643 <trap+0x43>
80107827:	e9 37 fe ff ff       	jmp    80107663 <trap+0x63>
8010782c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107830:	e8 db ce ff ff       	call   80104710 <cpuid>
80107835:	85 c0                	test   %eax,%eax
80107837:	0f 85 f8 fd ff ff    	jne    80107635 <trap+0x35>
      acquire(&tickslock);
8010783d:	83 ec 0c             	sub    $0xc,%esp
80107840:	68 20 87 11 80       	push   $0x80118720
80107845:	e8 66 e5 ff ff       	call   80105db0 <acquire>
      wakeup(&ticks);
8010784a:	c7 04 24 00 87 11 80 	movl   $0x80118700,(%esp)
      ticks++;
80107851:	83 05 00 87 11 80 01 	addl   $0x1,0x80118700
      wakeup(&ticks);
80107858:	e8 33 db ff ff       	call   80105390 <wakeup>
      release(&tickslock);
8010785d:	c7 04 24 20 87 11 80 	movl   $0x80118720,(%esp)
80107864:	e8 e7 e4 ff ff       	call   80105d50 <release>
      aging();
80107869:	e8 22 d4 ff ff       	call   80104c90 <aging>
8010786e:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80107871:	e9 bf fd ff ff       	jmp    80107635 <trap+0x35>
80107876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010787d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80107880:	e8 4b d7 ff ff       	call   80104fd0 <exit>
80107885:	e9 d9 fd ff ff       	jmp    80107663 <trap+0x63>
8010788a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80107890:	e8 3b d7 ff ff       	call   80104fd0 <exit>
80107895:	e9 21 ff ff ff       	jmp    801077bb <trap+0x1bb>
8010789a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("pid: ");
801078a0:	83 ec 0c             	sub    $0xc,%esp
801078a3:	68 6a 99 10 80       	push   $0x8010996a
801078a8:	e8 c3 91 ff ff       	call   80100a70 <cprintf>
      cprintf("%d", myproc()->pid);
801078ad:	e8 7e ce ff ff       	call   80104730 <myproc>
801078b2:	5a                   	pop    %edx
801078b3:	59                   	pop    %ecx
801078b4:	ff 70 7c             	push   0x7c(%eax)
801078b7:	68 e0 95 10 80       	push   $0x801095e0
801078bc:	e8 af 91 ff ff       	call   80100a70 <cprintf>
      cprintf(" ticks: ");
801078c1:	c7 04 24 70 99 10 80 	movl   $0x80109970,(%esp)
801078c8:	e8 a3 91 ff ff       	call   80100a70 <cprintf>
      cprintf("%d",ticks);
801078cd:	5e                   	pop    %esi
801078ce:	5f                   	pop    %edi
801078cf:	ff 35 00 87 11 80    	push   0x80118700
801078d5:	68 e0 95 10 80       	push   $0x801095e0
801078da:	e8 91 91 ff ff       	call   80100a70 <cprintf>
      cprintf(" level: ");
801078df:	c7 04 24 79 99 10 80 	movl   $0x80109979,(%esp)
801078e6:	e8 85 91 ff ff       	call   80100a70 <cprintf>
      cprintf("%d",myproc()->sched_info.level);
801078eb:	e8 40 ce ff ff       	call   80104730 <myproc>
801078f0:	5a                   	pop    %edx
801078f1:	59                   	pop    %ecx
801078f2:	ff b0 f0 00 00 00    	push   0xf0(%eax)
801078f8:	68 e0 95 10 80       	push   $0x801095e0
801078fd:	e8 6e 91 ff ff       	call   80100a70 <cprintf>
      cprintf("\n");
80107902:	c7 04 24 2b 95 10 80 	movl   $0x8010952b,(%esp)
80107909:	e8 62 91 ff ff       	call   80100a70 <cprintf>
      myproc()->sched_info.num_of_cycles = 0;
8010790e:	e8 1d ce ff ff       	call   80104730 <myproc>
80107913:	c7 80 08 01 00 00 00 	movl   $0x0,0x108(%eax)
8010791a:	00 00 00 
      yield();
8010791d:	e8 4e d9 ff ff       	call   80105270 <yield>
80107922:	83 c4 10             	add    $0x10,%esp
80107925:	e9 51 fd ff ff       	jmp    8010767b <trap+0x7b>
8010792a:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010792d:	e8 de cd ff ff       	call   80104710 <cpuid>
80107932:	83 ec 0c             	sub    $0xc,%esp
80107935:	56                   	push   %esi
80107936:	57                   	push   %edi
80107937:	50                   	push   %eax
80107938:	ff 73 30             	push   0x30(%ebx)
8010793b:	68 a8 99 10 80       	push   $0x801099a8
80107940:	e8 2b 91 ff ff       	call   80100a70 <cprintf>
      panic("trap");
80107945:	83 c4 14             	add    $0x14,%esp
80107948:	68 65 99 10 80       	push   $0x80109965
8010794d:	e8 9e 8b ff ff       	call   801004f0 <panic>
80107952:	66 90                	xchg   %ax,%ax
80107954:	66 90                	xchg   %ax,%ax
80107956:	66 90                	xchg   %ax,%ax
80107958:	66 90                	xchg   %ax,%ax
8010795a:	66 90                	xchg   %ax,%ax
8010795c:	66 90                	xchg   %ax,%ax
8010795e:	66 90                	xchg   %ax,%ax

80107960 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107960:	a1 60 8f 11 80       	mov    0x80118f60,%eax
80107965:	85 c0                	test   %eax,%eax
80107967:	74 17                	je     80107980 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107969:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010796e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010796f:	a8 01                	test   $0x1,%al
80107971:	74 0d                	je     80107980 <uartgetc+0x20>
80107973:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107978:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107979:	0f b6 c0             	movzbl %al,%eax
8010797c:	c3                   	ret    
8010797d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80107980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107985:	c3                   	ret    
80107986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010798d:	8d 76 00             	lea    0x0(%esi),%esi

80107990 <uartinit>:
{
80107990:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107991:	31 c9                	xor    %ecx,%ecx
80107993:	89 c8                	mov    %ecx,%eax
80107995:	89 e5                	mov    %esp,%ebp
80107997:	57                   	push   %edi
80107998:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010799d:	56                   	push   %esi
8010799e:	89 fa                	mov    %edi,%edx
801079a0:	53                   	push   %ebx
801079a1:	83 ec 1c             	sub    $0x1c,%esp
801079a4:	ee                   	out    %al,(%dx)
801079a5:	be fb 03 00 00       	mov    $0x3fb,%esi
801079aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801079af:	89 f2                	mov    %esi,%edx
801079b1:	ee                   	out    %al,(%dx)
801079b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801079b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801079bc:	ee                   	out    %al,(%dx)
801079bd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801079c2:	89 c8                	mov    %ecx,%eax
801079c4:	89 da                	mov    %ebx,%edx
801079c6:	ee                   	out    %al,(%dx)
801079c7:	b8 03 00 00 00       	mov    $0x3,%eax
801079cc:	89 f2                	mov    %esi,%edx
801079ce:	ee                   	out    %al,(%dx)
801079cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801079d4:	89 c8                	mov    %ecx,%eax
801079d6:	ee                   	out    %al,(%dx)
801079d7:	b8 01 00 00 00       	mov    $0x1,%eax
801079dc:	89 da                	mov    %ebx,%edx
801079de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801079df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801079e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801079e5:	3c ff                	cmp    $0xff,%al
801079e7:	74 78                	je     80107a61 <uartinit+0xd1>
  uart = 1;
801079e9:	c7 05 60 8f 11 80 01 	movl   $0x1,0x80118f60
801079f0:	00 00 00 
801079f3:	89 fa                	mov    %edi,%edx
801079f5:	ec                   	in     (%dx),%al
801079f6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801079fb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801079fc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801079ff:	bf a0 9a 10 80       	mov    $0x80109aa0,%edi
80107a04:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80107a09:	6a 00                	push   $0x0
80107a0b:	6a 04                	push   $0x4
80107a0d:	e8 ae b7 ff ff       	call   801031c0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107a12:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80107a16:	83 c4 10             	add    $0x10,%esp
80107a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80107a20:	a1 60 8f 11 80       	mov    0x80118f60,%eax
80107a25:	bb 80 00 00 00       	mov    $0x80,%ebx
80107a2a:	85 c0                	test   %eax,%eax
80107a2c:	75 14                	jne    80107a42 <uartinit+0xb2>
80107a2e:	eb 23                	jmp    80107a53 <uartinit+0xc3>
    microdelay(10);
80107a30:	83 ec 0c             	sub    $0xc,%esp
80107a33:	6a 0a                	push   $0xa
80107a35:	e8 36 bc ff ff       	call   80103670 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107a3a:	83 c4 10             	add    $0x10,%esp
80107a3d:	83 eb 01             	sub    $0x1,%ebx
80107a40:	74 07                	je     80107a49 <uartinit+0xb9>
80107a42:	89 f2                	mov    %esi,%edx
80107a44:	ec                   	in     (%dx),%al
80107a45:	a8 20                	test   $0x20,%al
80107a47:	74 e7                	je     80107a30 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107a49:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80107a4d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107a52:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80107a53:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80107a57:	83 c7 01             	add    $0x1,%edi
80107a5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80107a5d:	84 c0                	test   %al,%al
80107a5f:	75 bf                	jne    80107a20 <uartinit+0x90>
}
80107a61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a64:	5b                   	pop    %ebx
80107a65:	5e                   	pop    %esi
80107a66:	5f                   	pop    %edi
80107a67:	5d                   	pop    %ebp
80107a68:	c3                   	ret    
80107a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107a70 <uartputc>:
  if(!uart)
80107a70:	a1 60 8f 11 80       	mov    0x80118f60,%eax
80107a75:	85 c0                	test   %eax,%eax
80107a77:	74 47                	je     80107ac0 <uartputc+0x50>
{
80107a79:	55                   	push   %ebp
80107a7a:	89 e5                	mov    %esp,%ebp
80107a7c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107a7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80107a82:	53                   	push   %ebx
80107a83:	bb 80 00 00 00       	mov    $0x80,%ebx
80107a88:	eb 18                	jmp    80107aa2 <uartputc+0x32>
80107a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80107a90:	83 ec 0c             	sub    $0xc,%esp
80107a93:	6a 0a                	push   $0xa
80107a95:	e8 d6 bb ff ff       	call   80103670 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107a9a:	83 c4 10             	add    $0x10,%esp
80107a9d:	83 eb 01             	sub    $0x1,%ebx
80107aa0:	74 07                	je     80107aa9 <uartputc+0x39>
80107aa2:	89 f2                	mov    %esi,%edx
80107aa4:	ec                   	in     (%dx),%al
80107aa5:	a8 20                	test   $0x20,%al
80107aa7:	74 e7                	je     80107a90 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80107aac:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107ab1:	ee                   	out    %al,(%dx)
}
80107ab2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ab5:	5b                   	pop    %ebx
80107ab6:	5e                   	pop    %esi
80107ab7:	5d                   	pop    %ebp
80107ab8:	c3                   	ret    
80107ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ac0:	c3                   	ret    
80107ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ac8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107acf:	90                   	nop

80107ad0 <uartintr>:

void
uartintr(void)
{
80107ad0:	55                   	push   %ebp
80107ad1:	89 e5                	mov    %esp,%ebp
80107ad3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107ad6:	68 60 79 10 80       	push   $0x80107960
80107adb:	e8 60 92 ff ff       	call   80100d40 <consoleintr>
}
80107ae0:	83 c4 10             	add    $0x10,%esp
80107ae3:	c9                   	leave  
80107ae4:	c3                   	ret    

80107ae5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107ae5:	6a 00                	push   $0x0
  pushl $0
80107ae7:	6a 00                	push   $0x0
  jmp alltraps
80107ae9:	e9 3a fa ff ff       	jmp    80107528 <alltraps>

80107aee <vector1>:
.globl vector1
vector1:
  pushl $0
80107aee:	6a 00                	push   $0x0
  pushl $1
80107af0:	6a 01                	push   $0x1
  jmp alltraps
80107af2:	e9 31 fa ff ff       	jmp    80107528 <alltraps>

80107af7 <vector2>:
.globl vector2
vector2:
  pushl $0
80107af7:	6a 00                	push   $0x0
  pushl $2
80107af9:	6a 02                	push   $0x2
  jmp alltraps
80107afb:	e9 28 fa ff ff       	jmp    80107528 <alltraps>

80107b00 <vector3>:
.globl vector3
vector3:
  pushl $0
80107b00:	6a 00                	push   $0x0
  pushl $3
80107b02:	6a 03                	push   $0x3
  jmp alltraps
80107b04:	e9 1f fa ff ff       	jmp    80107528 <alltraps>

80107b09 <vector4>:
.globl vector4
vector4:
  pushl $0
80107b09:	6a 00                	push   $0x0
  pushl $4
80107b0b:	6a 04                	push   $0x4
  jmp alltraps
80107b0d:	e9 16 fa ff ff       	jmp    80107528 <alltraps>

80107b12 <vector5>:
.globl vector5
vector5:
  pushl $0
80107b12:	6a 00                	push   $0x0
  pushl $5
80107b14:	6a 05                	push   $0x5
  jmp alltraps
80107b16:	e9 0d fa ff ff       	jmp    80107528 <alltraps>

80107b1b <vector6>:
.globl vector6
vector6:
  pushl $0
80107b1b:	6a 00                	push   $0x0
  pushl $6
80107b1d:	6a 06                	push   $0x6
  jmp alltraps
80107b1f:	e9 04 fa ff ff       	jmp    80107528 <alltraps>

80107b24 <vector7>:
.globl vector7
vector7:
  pushl $0
80107b24:	6a 00                	push   $0x0
  pushl $7
80107b26:	6a 07                	push   $0x7
  jmp alltraps
80107b28:	e9 fb f9 ff ff       	jmp    80107528 <alltraps>

80107b2d <vector8>:
.globl vector8
vector8:
  pushl $8
80107b2d:	6a 08                	push   $0x8
  jmp alltraps
80107b2f:	e9 f4 f9 ff ff       	jmp    80107528 <alltraps>

80107b34 <vector9>:
.globl vector9
vector9:
  pushl $0
80107b34:	6a 00                	push   $0x0
  pushl $9
80107b36:	6a 09                	push   $0x9
  jmp alltraps
80107b38:	e9 eb f9 ff ff       	jmp    80107528 <alltraps>

80107b3d <vector10>:
.globl vector10
vector10:
  pushl $10
80107b3d:	6a 0a                	push   $0xa
  jmp alltraps
80107b3f:	e9 e4 f9 ff ff       	jmp    80107528 <alltraps>

80107b44 <vector11>:
.globl vector11
vector11:
  pushl $11
80107b44:	6a 0b                	push   $0xb
  jmp alltraps
80107b46:	e9 dd f9 ff ff       	jmp    80107528 <alltraps>

80107b4b <vector12>:
.globl vector12
vector12:
  pushl $12
80107b4b:	6a 0c                	push   $0xc
  jmp alltraps
80107b4d:	e9 d6 f9 ff ff       	jmp    80107528 <alltraps>

80107b52 <vector13>:
.globl vector13
vector13:
  pushl $13
80107b52:	6a 0d                	push   $0xd
  jmp alltraps
80107b54:	e9 cf f9 ff ff       	jmp    80107528 <alltraps>

80107b59 <vector14>:
.globl vector14
vector14:
  pushl $14
80107b59:	6a 0e                	push   $0xe
  jmp alltraps
80107b5b:	e9 c8 f9 ff ff       	jmp    80107528 <alltraps>

80107b60 <vector15>:
.globl vector15
vector15:
  pushl $0
80107b60:	6a 00                	push   $0x0
  pushl $15
80107b62:	6a 0f                	push   $0xf
  jmp alltraps
80107b64:	e9 bf f9 ff ff       	jmp    80107528 <alltraps>

80107b69 <vector16>:
.globl vector16
vector16:
  pushl $0
80107b69:	6a 00                	push   $0x0
  pushl $16
80107b6b:	6a 10                	push   $0x10
  jmp alltraps
80107b6d:	e9 b6 f9 ff ff       	jmp    80107528 <alltraps>

80107b72 <vector17>:
.globl vector17
vector17:
  pushl $17
80107b72:	6a 11                	push   $0x11
  jmp alltraps
80107b74:	e9 af f9 ff ff       	jmp    80107528 <alltraps>

80107b79 <vector18>:
.globl vector18
vector18:
  pushl $0
80107b79:	6a 00                	push   $0x0
  pushl $18
80107b7b:	6a 12                	push   $0x12
  jmp alltraps
80107b7d:	e9 a6 f9 ff ff       	jmp    80107528 <alltraps>

80107b82 <vector19>:
.globl vector19
vector19:
  pushl $0
80107b82:	6a 00                	push   $0x0
  pushl $19
80107b84:	6a 13                	push   $0x13
  jmp alltraps
80107b86:	e9 9d f9 ff ff       	jmp    80107528 <alltraps>

80107b8b <vector20>:
.globl vector20
vector20:
  pushl $0
80107b8b:	6a 00                	push   $0x0
  pushl $20
80107b8d:	6a 14                	push   $0x14
  jmp alltraps
80107b8f:	e9 94 f9 ff ff       	jmp    80107528 <alltraps>

80107b94 <vector21>:
.globl vector21
vector21:
  pushl $0
80107b94:	6a 00                	push   $0x0
  pushl $21
80107b96:	6a 15                	push   $0x15
  jmp alltraps
80107b98:	e9 8b f9 ff ff       	jmp    80107528 <alltraps>

80107b9d <vector22>:
.globl vector22
vector22:
  pushl $0
80107b9d:	6a 00                	push   $0x0
  pushl $22
80107b9f:	6a 16                	push   $0x16
  jmp alltraps
80107ba1:	e9 82 f9 ff ff       	jmp    80107528 <alltraps>

80107ba6 <vector23>:
.globl vector23
vector23:
  pushl $0
80107ba6:	6a 00                	push   $0x0
  pushl $23
80107ba8:	6a 17                	push   $0x17
  jmp alltraps
80107baa:	e9 79 f9 ff ff       	jmp    80107528 <alltraps>

80107baf <vector24>:
.globl vector24
vector24:
  pushl $0
80107baf:	6a 00                	push   $0x0
  pushl $24
80107bb1:	6a 18                	push   $0x18
  jmp alltraps
80107bb3:	e9 70 f9 ff ff       	jmp    80107528 <alltraps>

80107bb8 <vector25>:
.globl vector25
vector25:
  pushl $0
80107bb8:	6a 00                	push   $0x0
  pushl $25
80107bba:	6a 19                	push   $0x19
  jmp alltraps
80107bbc:	e9 67 f9 ff ff       	jmp    80107528 <alltraps>

80107bc1 <vector26>:
.globl vector26
vector26:
  pushl $0
80107bc1:	6a 00                	push   $0x0
  pushl $26
80107bc3:	6a 1a                	push   $0x1a
  jmp alltraps
80107bc5:	e9 5e f9 ff ff       	jmp    80107528 <alltraps>

80107bca <vector27>:
.globl vector27
vector27:
  pushl $0
80107bca:	6a 00                	push   $0x0
  pushl $27
80107bcc:	6a 1b                	push   $0x1b
  jmp alltraps
80107bce:	e9 55 f9 ff ff       	jmp    80107528 <alltraps>

80107bd3 <vector28>:
.globl vector28
vector28:
  pushl $0
80107bd3:	6a 00                	push   $0x0
  pushl $28
80107bd5:	6a 1c                	push   $0x1c
  jmp alltraps
80107bd7:	e9 4c f9 ff ff       	jmp    80107528 <alltraps>

80107bdc <vector29>:
.globl vector29
vector29:
  pushl $0
80107bdc:	6a 00                	push   $0x0
  pushl $29
80107bde:	6a 1d                	push   $0x1d
  jmp alltraps
80107be0:	e9 43 f9 ff ff       	jmp    80107528 <alltraps>

80107be5 <vector30>:
.globl vector30
vector30:
  pushl $0
80107be5:	6a 00                	push   $0x0
  pushl $30
80107be7:	6a 1e                	push   $0x1e
  jmp alltraps
80107be9:	e9 3a f9 ff ff       	jmp    80107528 <alltraps>

80107bee <vector31>:
.globl vector31
vector31:
  pushl $0
80107bee:	6a 00                	push   $0x0
  pushl $31
80107bf0:	6a 1f                	push   $0x1f
  jmp alltraps
80107bf2:	e9 31 f9 ff ff       	jmp    80107528 <alltraps>

80107bf7 <vector32>:
.globl vector32
vector32:
  pushl $0
80107bf7:	6a 00                	push   $0x0
  pushl $32
80107bf9:	6a 20                	push   $0x20
  jmp alltraps
80107bfb:	e9 28 f9 ff ff       	jmp    80107528 <alltraps>

80107c00 <vector33>:
.globl vector33
vector33:
  pushl $0
80107c00:	6a 00                	push   $0x0
  pushl $33
80107c02:	6a 21                	push   $0x21
  jmp alltraps
80107c04:	e9 1f f9 ff ff       	jmp    80107528 <alltraps>

80107c09 <vector34>:
.globl vector34
vector34:
  pushl $0
80107c09:	6a 00                	push   $0x0
  pushl $34
80107c0b:	6a 22                	push   $0x22
  jmp alltraps
80107c0d:	e9 16 f9 ff ff       	jmp    80107528 <alltraps>

80107c12 <vector35>:
.globl vector35
vector35:
  pushl $0
80107c12:	6a 00                	push   $0x0
  pushl $35
80107c14:	6a 23                	push   $0x23
  jmp alltraps
80107c16:	e9 0d f9 ff ff       	jmp    80107528 <alltraps>

80107c1b <vector36>:
.globl vector36
vector36:
  pushl $0
80107c1b:	6a 00                	push   $0x0
  pushl $36
80107c1d:	6a 24                	push   $0x24
  jmp alltraps
80107c1f:	e9 04 f9 ff ff       	jmp    80107528 <alltraps>

80107c24 <vector37>:
.globl vector37
vector37:
  pushl $0
80107c24:	6a 00                	push   $0x0
  pushl $37
80107c26:	6a 25                	push   $0x25
  jmp alltraps
80107c28:	e9 fb f8 ff ff       	jmp    80107528 <alltraps>

80107c2d <vector38>:
.globl vector38
vector38:
  pushl $0
80107c2d:	6a 00                	push   $0x0
  pushl $38
80107c2f:	6a 26                	push   $0x26
  jmp alltraps
80107c31:	e9 f2 f8 ff ff       	jmp    80107528 <alltraps>

80107c36 <vector39>:
.globl vector39
vector39:
  pushl $0
80107c36:	6a 00                	push   $0x0
  pushl $39
80107c38:	6a 27                	push   $0x27
  jmp alltraps
80107c3a:	e9 e9 f8 ff ff       	jmp    80107528 <alltraps>

80107c3f <vector40>:
.globl vector40
vector40:
  pushl $0
80107c3f:	6a 00                	push   $0x0
  pushl $40
80107c41:	6a 28                	push   $0x28
  jmp alltraps
80107c43:	e9 e0 f8 ff ff       	jmp    80107528 <alltraps>

80107c48 <vector41>:
.globl vector41
vector41:
  pushl $0
80107c48:	6a 00                	push   $0x0
  pushl $41
80107c4a:	6a 29                	push   $0x29
  jmp alltraps
80107c4c:	e9 d7 f8 ff ff       	jmp    80107528 <alltraps>

80107c51 <vector42>:
.globl vector42
vector42:
  pushl $0
80107c51:	6a 00                	push   $0x0
  pushl $42
80107c53:	6a 2a                	push   $0x2a
  jmp alltraps
80107c55:	e9 ce f8 ff ff       	jmp    80107528 <alltraps>

80107c5a <vector43>:
.globl vector43
vector43:
  pushl $0
80107c5a:	6a 00                	push   $0x0
  pushl $43
80107c5c:	6a 2b                	push   $0x2b
  jmp alltraps
80107c5e:	e9 c5 f8 ff ff       	jmp    80107528 <alltraps>

80107c63 <vector44>:
.globl vector44
vector44:
  pushl $0
80107c63:	6a 00                	push   $0x0
  pushl $44
80107c65:	6a 2c                	push   $0x2c
  jmp alltraps
80107c67:	e9 bc f8 ff ff       	jmp    80107528 <alltraps>

80107c6c <vector45>:
.globl vector45
vector45:
  pushl $0
80107c6c:	6a 00                	push   $0x0
  pushl $45
80107c6e:	6a 2d                	push   $0x2d
  jmp alltraps
80107c70:	e9 b3 f8 ff ff       	jmp    80107528 <alltraps>

80107c75 <vector46>:
.globl vector46
vector46:
  pushl $0
80107c75:	6a 00                	push   $0x0
  pushl $46
80107c77:	6a 2e                	push   $0x2e
  jmp alltraps
80107c79:	e9 aa f8 ff ff       	jmp    80107528 <alltraps>

80107c7e <vector47>:
.globl vector47
vector47:
  pushl $0
80107c7e:	6a 00                	push   $0x0
  pushl $47
80107c80:	6a 2f                	push   $0x2f
  jmp alltraps
80107c82:	e9 a1 f8 ff ff       	jmp    80107528 <alltraps>

80107c87 <vector48>:
.globl vector48
vector48:
  pushl $0
80107c87:	6a 00                	push   $0x0
  pushl $48
80107c89:	6a 30                	push   $0x30
  jmp alltraps
80107c8b:	e9 98 f8 ff ff       	jmp    80107528 <alltraps>

80107c90 <vector49>:
.globl vector49
vector49:
  pushl $0
80107c90:	6a 00                	push   $0x0
  pushl $49
80107c92:	6a 31                	push   $0x31
  jmp alltraps
80107c94:	e9 8f f8 ff ff       	jmp    80107528 <alltraps>

80107c99 <vector50>:
.globl vector50
vector50:
  pushl $0
80107c99:	6a 00                	push   $0x0
  pushl $50
80107c9b:	6a 32                	push   $0x32
  jmp alltraps
80107c9d:	e9 86 f8 ff ff       	jmp    80107528 <alltraps>

80107ca2 <vector51>:
.globl vector51
vector51:
  pushl $0
80107ca2:	6a 00                	push   $0x0
  pushl $51
80107ca4:	6a 33                	push   $0x33
  jmp alltraps
80107ca6:	e9 7d f8 ff ff       	jmp    80107528 <alltraps>

80107cab <vector52>:
.globl vector52
vector52:
  pushl $0
80107cab:	6a 00                	push   $0x0
  pushl $52
80107cad:	6a 34                	push   $0x34
  jmp alltraps
80107caf:	e9 74 f8 ff ff       	jmp    80107528 <alltraps>

80107cb4 <vector53>:
.globl vector53
vector53:
  pushl $0
80107cb4:	6a 00                	push   $0x0
  pushl $53
80107cb6:	6a 35                	push   $0x35
  jmp alltraps
80107cb8:	e9 6b f8 ff ff       	jmp    80107528 <alltraps>

80107cbd <vector54>:
.globl vector54
vector54:
  pushl $0
80107cbd:	6a 00                	push   $0x0
  pushl $54
80107cbf:	6a 36                	push   $0x36
  jmp alltraps
80107cc1:	e9 62 f8 ff ff       	jmp    80107528 <alltraps>

80107cc6 <vector55>:
.globl vector55
vector55:
  pushl $0
80107cc6:	6a 00                	push   $0x0
  pushl $55
80107cc8:	6a 37                	push   $0x37
  jmp alltraps
80107cca:	e9 59 f8 ff ff       	jmp    80107528 <alltraps>

80107ccf <vector56>:
.globl vector56
vector56:
  pushl $0
80107ccf:	6a 00                	push   $0x0
  pushl $56
80107cd1:	6a 38                	push   $0x38
  jmp alltraps
80107cd3:	e9 50 f8 ff ff       	jmp    80107528 <alltraps>

80107cd8 <vector57>:
.globl vector57
vector57:
  pushl $0
80107cd8:	6a 00                	push   $0x0
  pushl $57
80107cda:	6a 39                	push   $0x39
  jmp alltraps
80107cdc:	e9 47 f8 ff ff       	jmp    80107528 <alltraps>

80107ce1 <vector58>:
.globl vector58
vector58:
  pushl $0
80107ce1:	6a 00                	push   $0x0
  pushl $58
80107ce3:	6a 3a                	push   $0x3a
  jmp alltraps
80107ce5:	e9 3e f8 ff ff       	jmp    80107528 <alltraps>

80107cea <vector59>:
.globl vector59
vector59:
  pushl $0
80107cea:	6a 00                	push   $0x0
  pushl $59
80107cec:	6a 3b                	push   $0x3b
  jmp alltraps
80107cee:	e9 35 f8 ff ff       	jmp    80107528 <alltraps>

80107cf3 <vector60>:
.globl vector60
vector60:
  pushl $0
80107cf3:	6a 00                	push   $0x0
  pushl $60
80107cf5:	6a 3c                	push   $0x3c
  jmp alltraps
80107cf7:	e9 2c f8 ff ff       	jmp    80107528 <alltraps>

80107cfc <vector61>:
.globl vector61
vector61:
  pushl $0
80107cfc:	6a 00                	push   $0x0
  pushl $61
80107cfe:	6a 3d                	push   $0x3d
  jmp alltraps
80107d00:	e9 23 f8 ff ff       	jmp    80107528 <alltraps>

80107d05 <vector62>:
.globl vector62
vector62:
  pushl $0
80107d05:	6a 00                	push   $0x0
  pushl $62
80107d07:	6a 3e                	push   $0x3e
  jmp alltraps
80107d09:	e9 1a f8 ff ff       	jmp    80107528 <alltraps>

80107d0e <vector63>:
.globl vector63
vector63:
  pushl $0
80107d0e:	6a 00                	push   $0x0
  pushl $63
80107d10:	6a 3f                	push   $0x3f
  jmp alltraps
80107d12:	e9 11 f8 ff ff       	jmp    80107528 <alltraps>

80107d17 <vector64>:
.globl vector64
vector64:
  pushl $0
80107d17:	6a 00                	push   $0x0
  pushl $64
80107d19:	6a 40                	push   $0x40
  jmp alltraps
80107d1b:	e9 08 f8 ff ff       	jmp    80107528 <alltraps>

80107d20 <vector65>:
.globl vector65
vector65:
  pushl $0
80107d20:	6a 00                	push   $0x0
  pushl $65
80107d22:	6a 41                	push   $0x41
  jmp alltraps
80107d24:	e9 ff f7 ff ff       	jmp    80107528 <alltraps>

80107d29 <vector66>:
.globl vector66
vector66:
  pushl $0
80107d29:	6a 00                	push   $0x0
  pushl $66
80107d2b:	6a 42                	push   $0x42
  jmp alltraps
80107d2d:	e9 f6 f7 ff ff       	jmp    80107528 <alltraps>

80107d32 <vector67>:
.globl vector67
vector67:
  pushl $0
80107d32:	6a 00                	push   $0x0
  pushl $67
80107d34:	6a 43                	push   $0x43
  jmp alltraps
80107d36:	e9 ed f7 ff ff       	jmp    80107528 <alltraps>

80107d3b <vector68>:
.globl vector68
vector68:
  pushl $0
80107d3b:	6a 00                	push   $0x0
  pushl $68
80107d3d:	6a 44                	push   $0x44
  jmp alltraps
80107d3f:	e9 e4 f7 ff ff       	jmp    80107528 <alltraps>

80107d44 <vector69>:
.globl vector69
vector69:
  pushl $0
80107d44:	6a 00                	push   $0x0
  pushl $69
80107d46:	6a 45                	push   $0x45
  jmp alltraps
80107d48:	e9 db f7 ff ff       	jmp    80107528 <alltraps>

80107d4d <vector70>:
.globl vector70
vector70:
  pushl $0
80107d4d:	6a 00                	push   $0x0
  pushl $70
80107d4f:	6a 46                	push   $0x46
  jmp alltraps
80107d51:	e9 d2 f7 ff ff       	jmp    80107528 <alltraps>

80107d56 <vector71>:
.globl vector71
vector71:
  pushl $0
80107d56:	6a 00                	push   $0x0
  pushl $71
80107d58:	6a 47                	push   $0x47
  jmp alltraps
80107d5a:	e9 c9 f7 ff ff       	jmp    80107528 <alltraps>

80107d5f <vector72>:
.globl vector72
vector72:
  pushl $0
80107d5f:	6a 00                	push   $0x0
  pushl $72
80107d61:	6a 48                	push   $0x48
  jmp alltraps
80107d63:	e9 c0 f7 ff ff       	jmp    80107528 <alltraps>

80107d68 <vector73>:
.globl vector73
vector73:
  pushl $0
80107d68:	6a 00                	push   $0x0
  pushl $73
80107d6a:	6a 49                	push   $0x49
  jmp alltraps
80107d6c:	e9 b7 f7 ff ff       	jmp    80107528 <alltraps>

80107d71 <vector74>:
.globl vector74
vector74:
  pushl $0
80107d71:	6a 00                	push   $0x0
  pushl $74
80107d73:	6a 4a                	push   $0x4a
  jmp alltraps
80107d75:	e9 ae f7 ff ff       	jmp    80107528 <alltraps>

80107d7a <vector75>:
.globl vector75
vector75:
  pushl $0
80107d7a:	6a 00                	push   $0x0
  pushl $75
80107d7c:	6a 4b                	push   $0x4b
  jmp alltraps
80107d7e:	e9 a5 f7 ff ff       	jmp    80107528 <alltraps>

80107d83 <vector76>:
.globl vector76
vector76:
  pushl $0
80107d83:	6a 00                	push   $0x0
  pushl $76
80107d85:	6a 4c                	push   $0x4c
  jmp alltraps
80107d87:	e9 9c f7 ff ff       	jmp    80107528 <alltraps>

80107d8c <vector77>:
.globl vector77
vector77:
  pushl $0
80107d8c:	6a 00                	push   $0x0
  pushl $77
80107d8e:	6a 4d                	push   $0x4d
  jmp alltraps
80107d90:	e9 93 f7 ff ff       	jmp    80107528 <alltraps>

80107d95 <vector78>:
.globl vector78
vector78:
  pushl $0
80107d95:	6a 00                	push   $0x0
  pushl $78
80107d97:	6a 4e                	push   $0x4e
  jmp alltraps
80107d99:	e9 8a f7 ff ff       	jmp    80107528 <alltraps>

80107d9e <vector79>:
.globl vector79
vector79:
  pushl $0
80107d9e:	6a 00                	push   $0x0
  pushl $79
80107da0:	6a 4f                	push   $0x4f
  jmp alltraps
80107da2:	e9 81 f7 ff ff       	jmp    80107528 <alltraps>

80107da7 <vector80>:
.globl vector80
vector80:
  pushl $0
80107da7:	6a 00                	push   $0x0
  pushl $80
80107da9:	6a 50                	push   $0x50
  jmp alltraps
80107dab:	e9 78 f7 ff ff       	jmp    80107528 <alltraps>

80107db0 <vector81>:
.globl vector81
vector81:
  pushl $0
80107db0:	6a 00                	push   $0x0
  pushl $81
80107db2:	6a 51                	push   $0x51
  jmp alltraps
80107db4:	e9 6f f7 ff ff       	jmp    80107528 <alltraps>

80107db9 <vector82>:
.globl vector82
vector82:
  pushl $0
80107db9:	6a 00                	push   $0x0
  pushl $82
80107dbb:	6a 52                	push   $0x52
  jmp alltraps
80107dbd:	e9 66 f7 ff ff       	jmp    80107528 <alltraps>

80107dc2 <vector83>:
.globl vector83
vector83:
  pushl $0
80107dc2:	6a 00                	push   $0x0
  pushl $83
80107dc4:	6a 53                	push   $0x53
  jmp alltraps
80107dc6:	e9 5d f7 ff ff       	jmp    80107528 <alltraps>

80107dcb <vector84>:
.globl vector84
vector84:
  pushl $0
80107dcb:	6a 00                	push   $0x0
  pushl $84
80107dcd:	6a 54                	push   $0x54
  jmp alltraps
80107dcf:	e9 54 f7 ff ff       	jmp    80107528 <alltraps>

80107dd4 <vector85>:
.globl vector85
vector85:
  pushl $0
80107dd4:	6a 00                	push   $0x0
  pushl $85
80107dd6:	6a 55                	push   $0x55
  jmp alltraps
80107dd8:	e9 4b f7 ff ff       	jmp    80107528 <alltraps>

80107ddd <vector86>:
.globl vector86
vector86:
  pushl $0
80107ddd:	6a 00                	push   $0x0
  pushl $86
80107ddf:	6a 56                	push   $0x56
  jmp alltraps
80107de1:	e9 42 f7 ff ff       	jmp    80107528 <alltraps>

80107de6 <vector87>:
.globl vector87
vector87:
  pushl $0
80107de6:	6a 00                	push   $0x0
  pushl $87
80107de8:	6a 57                	push   $0x57
  jmp alltraps
80107dea:	e9 39 f7 ff ff       	jmp    80107528 <alltraps>

80107def <vector88>:
.globl vector88
vector88:
  pushl $0
80107def:	6a 00                	push   $0x0
  pushl $88
80107df1:	6a 58                	push   $0x58
  jmp alltraps
80107df3:	e9 30 f7 ff ff       	jmp    80107528 <alltraps>

80107df8 <vector89>:
.globl vector89
vector89:
  pushl $0
80107df8:	6a 00                	push   $0x0
  pushl $89
80107dfa:	6a 59                	push   $0x59
  jmp alltraps
80107dfc:	e9 27 f7 ff ff       	jmp    80107528 <alltraps>

80107e01 <vector90>:
.globl vector90
vector90:
  pushl $0
80107e01:	6a 00                	push   $0x0
  pushl $90
80107e03:	6a 5a                	push   $0x5a
  jmp alltraps
80107e05:	e9 1e f7 ff ff       	jmp    80107528 <alltraps>

80107e0a <vector91>:
.globl vector91
vector91:
  pushl $0
80107e0a:	6a 00                	push   $0x0
  pushl $91
80107e0c:	6a 5b                	push   $0x5b
  jmp alltraps
80107e0e:	e9 15 f7 ff ff       	jmp    80107528 <alltraps>

80107e13 <vector92>:
.globl vector92
vector92:
  pushl $0
80107e13:	6a 00                	push   $0x0
  pushl $92
80107e15:	6a 5c                	push   $0x5c
  jmp alltraps
80107e17:	e9 0c f7 ff ff       	jmp    80107528 <alltraps>

80107e1c <vector93>:
.globl vector93
vector93:
  pushl $0
80107e1c:	6a 00                	push   $0x0
  pushl $93
80107e1e:	6a 5d                	push   $0x5d
  jmp alltraps
80107e20:	e9 03 f7 ff ff       	jmp    80107528 <alltraps>

80107e25 <vector94>:
.globl vector94
vector94:
  pushl $0
80107e25:	6a 00                	push   $0x0
  pushl $94
80107e27:	6a 5e                	push   $0x5e
  jmp alltraps
80107e29:	e9 fa f6 ff ff       	jmp    80107528 <alltraps>

80107e2e <vector95>:
.globl vector95
vector95:
  pushl $0
80107e2e:	6a 00                	push   $0x0
  pushl $95
80107e30:	6a 5f                	push   $0x5f
  jmp alltraps
80107e32:	e9 f1 f6 ff ff       	jmp    80107528 <alltraps>

80107e37 <vector96>:
.globl vector96
vector96:
  pushl $0
80107e37:	6a 00                	push   $0x0
  pushl $96
80107e39:	6a 60                	push   $0x60
  jmp alltraps
80107e3b:	e9 e8 f6 ff ff       	jmp    80107528 <alltraps>

80107e40 <vector97>:
.globl vector97
vector97:
  pushl $0
80107e40:	6a 00                	push   $0x0
  pushl $97
80107e42:	6a 61                	push   $0x61
  jmp alltraps
80107e44:	e9 df f6 ff ff       	jmp    80107528 <alltraps>

80107e49 <vector98>:
.globl vector98
vector98:
  pushl $0
80107e49:	6a 00                	push   $0x0
  pushl $98
80107e4b:	6a 62                	push   $0x62
  jmp alltraps
80107e4d:	e9 d6 f6 ff ff       	jmp    80107528 <alltraps>

80107e52 <vector99>:
.globl vector99
vector99:
  pushl $0
80107e52:	6a 00                	push   $0x0
  pushl $99
80107e54:	6a 63                	push   $0x63
  jmp alltraps
80107e56:	e9 cd f6 ff ff       	jmp    80107528 <alltraps>

80107e5b <vector100>:
.globl vector100
vector100:
  pushl $0
80107e5b:	6a 00                	push   $0x0
  pushl $100
80107e5d:	6a 64                	push   $0x64
  jmp alltraps
80107e5f:	e9 c4 f6 ff ff       	jmp    80107528 <alltraps>

80107e64 <vector101>:
.globl vector101
vector101:
  pushl $0
80107e64:	6a 00                	push   $0x0
  pushl $101
80107e66:	6a 65                	push   $0x65
  jmp alltraps
80107e68:	e9 bb f6 ff ff       	jmp    80107528 <alltraps>

80107e6d <vector102>:
.globl vector102
vector102:
  pushl $0
80107e6d:	6a 00                	push   $0x0
  pushl $102
80107e6f:	6a 66                	push   $0x66
  jmp alltraps
80107e71:	e9 b2 f6 ff ff       	jmp    80107528 <alltraps>

80107e76 <vector103>:
.globl vector103
vector103:
  pushl $0
80107e76:	6a 00                	push   $0x0
  pushl $103
80107e78:	6a 67                	push   $0x67
  jmp alltraps
80107e7a:	e9 a9 f6 ff ff       	jmp    80107528 <alltraps>

80107e7f <vector104>:
.globl vector104
vector104:
  pushl $0
80107e7f:	6a 00                	push   $0x0
  pushl $104
80107e81:	6a 68                	push   $0x68
  jmp alltraps
80107e83:	e9 a0 f6 ff ff       	jmp    80107528 <alltraps>

80107e88 <vector105>:
.globl vector105
vector105:
  pushl $0
80107e88:	6a 00                	push   $0x0
  pushl $105
80107e8a:	6a 69                	push   $0x69
  jmp alltraps
80107e8c:	e9 97 f6 ff ff       	jmp    80107528 <alltraps>

80107e91 <vector106>:
.globl vector106
vector106:
  pushl $0
80107e91:	6a 00                	push   $0x0
  pushl $106
80107e93:	6a 6a                	push   $0x6a
  jmp alltraps
80107e95:	e9 8e f6 ff ff       	jmp    80107528 <alltraps>

80107e9a <vector107>:
.globl vector107
vector107:
  pushl $0
80107e9a:	6a 00                	push   $0x0
  pushl $107
80107e9c:	6a 6b                	push   $0x6b
  jmp alltraps
80107e9e:	e9 85 f6 ff ff       	jmp    80107528 <alltraps>

80107ea3 <vector108>:
.globl vector108
vector108:
  pushl $0
80107ea3:	6a 00                	push   $0x0
  pushl $108
80107ea5:	6a 6c                	push   $0x6c
  jmp alltraps
80107ea7:	e9 7c f6 ff ff       	jmp    80107528 <alltraps>

80107eac <vector109>:
.globl vector109
vector109:
  pushl $0
80107eac:	6a 00                	push   $0x0
  pushl $109
80107eae:	6a 6d                	push   $0x6d
  jmp alltraps
80107eb0:	e9 73 f6 ff ff       	jmp    80107528 <alltraps>

80107eb5 <vector110>:
.globl vector110
vector110:
  pushl $0
80107eb5:	6a 00                	push   $0x0
  pushl $110
80107eb7:	6a 6e                	push   $0x6e
  jmp alltraps
80107eb9:	e9 6a f6 ff ff       	jmp    80107528 <alltraps>

80107ebe <vector111>:
.globl vector111
vector111:
  pushl $0
80107ebe:	6a 00                	push   $0x0
  pushl $111
80107ec0:	6a 6f                	push   $0x6f
  jmp alltraps
80107ec2:	e9 61 f6 ff ff       	jmp    80107528 <alltraps>

80107ec7 <vector112>:
.globl vector112
vector112:
  pushl $0
80107ec7:	6a 00                	push   $0x0
  pushl $112
80107ec9:	6a 70                	push   $0x70
  jmp alltraps
80107ecb:	e9 58 f6 ff ff       	jmp    80107528 <alltraps>

80107ed0 <vector113>:
.globl vector113
vector113:
  pushl $0
80107ed0:	6a 00                	push   $0x0
  pushl $113
80107ed2:	6a 71                	push   $0x71
  jmp alltraps
80107ed4:	e9 4f f6 ff ff       	jmp    80107528 <alltraps>

80107ed9 <vector114>:
.globl vector114
vector114:
  pushl $0
80107ed9:	6a 00                	push   $0x0
  pushl $114
80107edb:	6a 72                	push   $0x72
  jmp alltraps
80107edd:	e9 46 f6 ff ff       	jmp    80107528 <alltraps>

80107ee2 <vector115>:
.globl vector115
vector115:
  pushl $0
80107ee2:	6a 00                	push   $0x0
  pushl $115
80107ee4:	6a 73                	push   $0x73
  jmp alltraps
80107ee6:	e9 3d f6 ff ff       	jmp    80107528 <alltraps>

80107eeb <vector116>:
.globl vector116
vector116:
  pushl $0
80107eeb:	6a 00                	push   $0x0
  pushl $116
80107eed:	6a 74                	push   $0x74
  jmp alltraps
80107eef:	e9 34 f6 ff ff       	jmp    80107528 <alltraps>

80107ef4 <vector117>:
.globl vector117
vector117:
  pushl $0
80107ef4:	6a 00                	push   $0x0
  pushl $117
80107ef6:	6a 75                	push   $0x75
  jmp alltraps
80107ef8:	e9 2b f6 ff ff       	jmp    80107528 <alltraps>

80107efd <vector118>:
.globl vector118
vector118:
  pushl $0
80107efd:	6a 00                	push   $0x0
  pushl $118
80107eff:	6a 76                	push   $0x76
  jmp alltraps
80107f01:	e9 22 f6 ff ff       	jmp    80107528 <alltraps>

80107f06 <vector119>:
.globl vector119
vector119:
  pushl $0
80107f06:	6a 00                	push   $0x0
  pushl $119
80107f08:	6a 77                	push   $0x77
  jmp alltraps
80107f0a:	e9 19 f6 ff ff       	jmp    80107528 <alltraps>

80107f0f <vector120>:
.globl vector120
vector120:
  pushl $0
80107f0f:	6a 00                	push   $0x0
  pushl $120
80107f11:	6a 78                	push   $0x78
  jmp alltraps
80107f13:	e9 10 f6 ff ff       	jmp    80107528 <alltraps>

80107f18 <vector121>:
.globl vector121
vector121:
  pushl $0
80107f18:	6a 00                	push   $0x0
  pushl $121
80107f1a:	6a 79                	push   $0x79
  jmp alltraps
80107f1c:	e9 07 f6 ff ff       	jmp    80107528 <alltraps>

80107f21 <vector122>:
.globl vector122
vector122:
  pushl $0
80107f21:	6a 00                	push   $0x0
  pushl $122
80107f23:	6a 7a                	push   $0x7a
  jmp alltraps
80107f25:	e9 fe f5 ff ff       	jmp    80107528 <alltraps>

80107f2a <vector123>:
.globl vector123
vector123:
  pushl $0
80107f2a:	6a 00                	push   $0x0
  pushl $123
80107f2c:	6a 7b                	push   $0x7b
  jmp alltraps
80107f2e:	e9 f5 f5 ff ff       	jmp    80107528 <alltraps>

80107f33 <vector124>:
.globl vector124
vector124:
  pushl $0
80107f33:	6a 00                	push   $0x0
  pushl $124
80107f35:	6a 7c                	push   $0x7c
  jmp alltraps
80107f37:	e9 ec f5 ff ff       	jmp    80107528 <alltraps>

80107f3c <vector125>:
.globl vector125
vector125:
  pushl $0
80107f3c:	6a 00                	push   $0x0
  pushl $125
80107f3e:	6a 7d                	push   $0x7d
  jmp alltraps
80107f40:	e9 e3 f5 ff ff       	jmp    80107528 <alltraps>

80107f45 <vector126>:
.globl vector126
vector126:
  pushl $0
80107f45:	6a 00                	push   $0x0
  pushl $126
80107f47:	6a 7e                	push   $0x7e
  jmp alltraps
80107f49:	e9 da f5 ff ff       	jmp    80107528 <alltraps>

80107f4e <vector127>:
.globl vector127
vector127:
  pushl $0
80107f4e:	6a 00                	push   $0x0
  pushl $127
80107f50:	6a 7f                	push   $0x7f
  jmp alltraps
80107f52:	e9 d1 f5 ff ff       	jmp    80107528 <alltraps>

80107f57 <vector128>:
.globl vector128
vector128:
  pushl $0
80107f57:	6a 00                	push   $0x0
  pushl $128
80107f59:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107f5e:	e9 c5 f5 ff ff       	jmp    80107528 <alltraps>

80107f63 <vector129>:
.globl vector129
vector129:
  pushl $0
80107f63:	6a 00                	push   $0x0
  pushl $129
80107f65:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107f6a:	e9 b9 f5 ff ff       	jmp    80107528 <alltraps>

80107f6f <vector130>:
.globl vector130
vector130:
  pushl $0
80107f6f:	6a 00                	push   $0x0
  pushl $130
80107f71:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107f76:	e9 ad f5 ff ff       	jmp    80107528 <alltraps>

80107f7b <vector131>:
.globl vector131
vector131:
  pushl $0
80107f7b:	6a 00                	push   $0x0
  pushl $131
80107f7d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107f82:	e9 a1 f5 ff ff       	jmp    80107528 <alltraps>

80107f87 <vector132>:
.globl vector132
vector132:
  pushl $0
80107f87:	6a 00                	push   $0x0
  pushl $132
80107f89:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107f8e:	e9 95 f5 ff ff       	jmp    80107528 <alltraps>

80107f93 <vector133>:
.globl vector133
vector133:
  pushl $0
80107f93:	6a 00                	push   $0x0
  pushl $133
80107f95:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107f9a:	e9 89 f5 ff ff       	jmp    80107528 <alltraps>

80107f9f <vector134>:
.globl vector134
vector134:
  pushl $0
80107f9f:	6a 00                	push   $0x0
  pushl $134
80107fa1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107fa6:	e9 7d f5 ff ff       	jmp    80107528 <alltraps>

80107fab <vector135>:
.globl vector135
vector135:
  pushl $0
80107fab:	6a 00                	push   $0x0
  pushl $135
80107fad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107fb2:	e9 71 f5 ff ff       	jmp    80107528 <alltraps>

80107fb7 <vector136>:
.globl vector136
vector136:
  pushl $0
80107fb7:	6a 00                	push   $0x0
  pushl $136
80107fb9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107fbe:	e9 65 f5 ff ff       	jmp    80107528 <alltraps>

80107fc3 <vector137>:
.globl vector137
vector137:
  pushl $0
80107fc3:	6a 00                	push   $0x0
  pushl $137
80107fc5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107fca:	e9 59 f5 ff ff       	jmp    80107528 <alltraps>

80107fcf <vector138>:
.globl vector138
vector138:
  pushl $0
80107fcf:	6a 00                	push   $0x0
  pushl $138
80107fd1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107fd6:	e9 4d f5 ff ff       	jmp    80107528 <alltraps>

80107fdb <vector139>:
.globl vector139
vector139:
  pushl $0
80107fdb:	6a 00                	push   $0x0
  pushl $139
80107fdd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107fe2:	e9 41 f5 ff ff       	jmp    80107528 <alltraps>

80107fe7 <vector140>:
.globl vector140
vector140:
  pushl $0
80107fe7:	6a 00                	push   $0x0
  pushl $140
80107fe9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107fee:	e9 35 f5 ff ff       	jmp    80107528 <alltraps>

80107ff3 <vector141>:
.globl vector141
vector141:
  pushl $0
80107ff3:	6a 00                	push   $0x0
  pushl $141
80107ff5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107ffa:	e9 29 f5 ff ff       	jmp    80107528 <alltraps>

80107fff <vector142>:
.globl vector142
vector142:
  pushl $0
80107fff:	6a 00                	push   $0x0
  pushl $142
80108001:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80108006:	e9 1d f5 ff ff       	jmp    80107528 <alltraps>

8010800b <vector143>:
.globl vector143
vector143:
  pushl $0
8010800b:	6a 00                	push   $0x0
  pushl $143
8010800d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80108012:	e9 11 f5 ff ff       	jmp    80107528 <alltraps>

80108017 <vector144>:
.globl vector144
vector144:
  pushl $0
80108017:	6a 00                	push   $0x0
  pushl $144
80108019:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010801e:	e9 05 f5 ff ff       	jmp    80107528 <alltraps>

80108023 <vector145>:
.globl vector145
vector145:
  pushl $0
80108023:	6a 00                	push   $0x0
  pushl $145
80108025:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010802a:	e9 f9 f4 ff ff       	jmp    80107528 <alltraps>

8010802f <vector146>:
.globl vector146
vector146:
  pushl $0
8010802f:	6a 00                	push   $0x0
  pushl $146
80108031:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108036:	e9 ed f4 ff ff       	jmp    80107528 <alltraps>

8010803b <vector147>:
.globl vector147
vector147:
  pushl $0
8010803b:	6a 00                	push   $0x0
  pushl $147
8010803d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108042:	e9 e1 f4 ff ff       	jmp    80107528 <alltraps>

80108047 <vector148>:
.globl vector148
vector148:
  pushl $0
80108047:	6a 00                	push   $0x0
  pushl $148
80108049:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010804e:	e9 d5 f4 ff ff       	jmp    80107528 <alltraps>

80108053 <vector149>:
.globl vector149
vector149:
  pushl $0
80108053:	6a 00                	push   $0x0
  pushl $149
80108055:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010805a:	e9 c9 f4 ff ff       	jmp    80107528 <alltraps>

8010805f <vector150>:
.globl vector150
vector150:
  pushl $0
8010805f:	6a 00                	push   $0x0
  pushl $150
80108061:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108066:	e9 bd f4 ff ff       	jmp    80107528 <alltraps>

8010806b <vector151>:
.globl vector151
vector151:
  pushl $0
8010806b:	6a 00                	push   $0x0
  pushl $151
8010806d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108072:	e9 b1 f4 ff ff       	jmp    80107528 <alltraps>

80108077 <vector152>:
.globl vector152
vector152:
  pushl $0
80108077:	6a 00                	push   $0x0
  pushl $152
80108079:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010807e:	e9 a5 f4 ff ff       	jmp    80107528 <alltraps>

80108083 <vector153>:
.globl vector153
vector153:
  pushl $0
80108083:	6a 00                	push   $0x0
  pushl $153
80108085:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010808a:	e9 99 f4 ff ff       	jmp    80107528 <alltraps>

8010808f <vector154>:
.globl vector154
vector154:
  pushl $0
8010808f:	6a 00                	push   $0x0
  pushl $154
80108091:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80108096:	e9 8d f4 ff ff       	jmp    80107528 <alltraps>

8010809b <vector155>:
.globl vector155
vector155:
  pushl $0
8010809b:	6a 00                	push   $0x0
  pushl $155
8010809d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801080a2:	e9 81 f4 ff ff       	jmp    80107528 <alltraps>

801080a7 <vector156>:
.globl vector156
vector156:
  pushl $0
801080a7:	6a 00                	push   $0x0
  pushl $156
801080a9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801080ae:	e9 75 f4 ff ff       	jmp    80107528 <alltraps>

801080b3 <vector157>:
.globl vector157
vector157:
  pushl $0
801080b3:	6a 00                	push   $0x0
  pushl $157
801080b5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801080ba:	e9 69 f4 ff ff       	jmp    80107528 <alltraps>

801080bf <vector158>:
.globl vector158
vector158:
  pushl $0
801080bf:	6a 00                	push   $0x0
  pushl $158
801080c1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801080c6:	e9 5d f4 ff ff       	jmp    80107528 <alltraps>

801080cb <vector159>:
.globl vector159
vector159:
  pushl $0
801080cb:	6a 00                	push   $0x0
  pushl $159
801080cd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801080d2:	e9 51 f4 ff ff       	jmp    80107528 <alltraps>

801080d7 <vector160>:
.globl vector160
vector160:
  pushl $0
801080d7:	6a 00                	push   $0x0
  pushl $160
801080d9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801080de:	e9 45 f4 ff ff       	jmp    80107528 <alltraps>

801080e3 <vector161>:
.globl vector161
vector161:
  pushl $0
801080e3:	6a 00                	push   $0x0
  pushl $161
801080e5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801080ea:	e9 39 f4 ff ff       	jmp    80107528 <alltraps>

801080ef <vector162>:
.globl vector162
vector162:
  pushl $0
801080ef:	6a 00                	push   $0x0
  pushl $162
801080f1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801080f6:	e9 2d f4 ff ff       	jmp    80107528 <alltraps>

801080fb <vector163>:
.globl vector163
vector163:
  pushl $0
801080fb:	6a 00                	push   $0x0
  pushl $163
801080fd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80108102:	e9 21 f4 ff ff       	jmp    80107528 <alltraps>

80108107 <vector164>:
.globl vector164
vector164:
  pushl $0
80108107:	6a 00                	push   $0x0
  pushl $164
80108109:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010810e:	e9 15 f4 ff ff       	jmp    80107528 <alltraps>

80108113 <vector165>:
.globl vector165
vector165:
  pushl $0
80108113:	6a 00                	push   $0x0
  pushl $165
80108115:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010811a:	e9 09 f4 ff ff       	jmp    80107528 <alltraps>

8010811f <vector166>:
.globl vector166
vector166:
  pushl $0
8010811f:	6a 00                	push   $0x0
  pushl $166
80108121:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80108126:	e9 fd f3 ff ff       	jmp    80107528 <alltraps>

8010812b <vector167>:
.globl vector167
vector167:
  pushl $0
8010812b:	6a 00                	push   $0x0
  pushl $167
8010812d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108132:	e9 f1 f3 ff ff       	jmp    80107528 <alltraps>

80108137 <vector168>:
.globl vector168
vector168:
  pushl $0
80108137:	6a 00                	push   $0x0
  pushl $168
80108139:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010813e:	e9 e5 f3 ff ff       	jmp    80107528 <alltraps>

80108143 <vector169>:
.globl vector169
vector169:
  pushl $0
80108143:	6a 00                	push   $0x0
  pushl $169
80108145:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010814a:	e9 d9 f3 ff ff       	jmp    80107528 <alltraps>

8010814f <vector170>:
.globl vector170
vector170:
  pushl $0
8010814f:	6a 00                	push   $0x0
  pushl $170
80108151:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108156:	e9 cd f3 ff ff       	jmp    80107528 <alltraps>

8010815b <vector171>:
.globl vector171
vector171:
  pushl $0
8010815b:	6a 00                	push   $0x0
  pushl $171
8010815d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108162:	e9 c1 f3 ff ff       	jmp    80107528 <alltraps>

80108167 <vector172>:
.globl vector172
vector172:
  pushl $0
80108167:	6a 00                	push   $0x0
  pushl $172
80108169:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010816e:	e9 b5 f3 ff ff       	jmp    80107528 <alltraps>

80108173 <vector173>:
.globl vector173
vector173:
  pushl $0
80108173:	6a 00                	push   $0x0
  pushl $173
80108175:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010817a:	e9 a9 f3 ff ff       	jmp    80107528 <alltraps>

8010817f <vector174>:
.globl vector174
vector174:
  pushl $0
8010817f:	6a 00                	push   $0x0
  pushl $174
80108181:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80108186:	e9 9d f3 ff ff       	jmp    80107528 <alltraps>

8010818b <vector175>:
.globl vector175
vector175:
  pushl $0
8010818b:	6a 00                	push   $0x0
  pushl $175
8010818d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108192:	e9 91 f3 ff ff       	jmp    80107528 <alltraps>

80108197 <vector176>:
.globl vector176
vector176:
  pushl $0
80108197:	6a 00                	push   $0x0
  pushl $176
80108199:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010819e:	e9 85 f3 ff ff       	jmp    80107528 <alltraps>

801081a3 <vector177>:
.globl vector177
vector177:
  pushl $0
801081a3:	6a 00                	push   $0x0
  pushl $177
801081a5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801081aa:	e9 79 f3 ff ff       	jmp    80107528 <alltraps>

801081af <vector178>:
.globl vector178
vector178:
  pushl $0
801081af:	6a 00                	push   $0x0
  pushl $178
801081b1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801081b6:	e9 6d f3 ff ff       	jmp    80107528 <alltraps>

801081bb <vector179>:
.globl vector179
vector179:
  pushl $0
801081bb:	6a 00                	push   $0x0
  pushl $179
801081bd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801081c2:	e9 61 f3 ff ff       	jmp    80107528 <alltraps>

801081c7 <vector180>:
.globl vector180
vector180:
  pushl $0
801081c7:	6a 00                	push   $0x0
  pushl $180
801081c9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801081ce:	e9 55 f3 ff ff       	jmp    80107528 <alltraps>

801081d3 <vector181>:
.globl vector181
vector181:
  pushl $0
801081d3:	6a 00                	push   $0x0
  pushl $181
801081d5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801081da:	e9 49 f3 ff ff       	jmp    80107528 <alltraps>

801081df <vector182>:
.globl vector182
vector182:
  pushl $0
801081df:	6a 00                	push   $0x0
  pushl $182
801081e1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801081e6:	e9 3d f3 ff ff       	jmp    80107528 <alltraps>

801081eb <vector183>:
.globl vector183
vector183:
  pushl $0
801081eb:	6a 00                	push   $0x0
  pushl $183
801081ed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801081f2:	e9 31 f3 ff ff       	jmp    80107528 <alltraps>

801081f7 <vector184>:
.globl vector184
vector184:
  pushl $0
801081f7:	6a 00                	push   $0x0
  pushl $184
801081f9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801081fe:	e9 25 f3 ff ff       	jmp    80107528 <alltraps>

80108203 <vector185>:
.globl vector185
vector185:
  pushl $0
80108203:	6a 00                	push   $0x0
  pushl $185
80108205:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010820a:	e9 19 f3 ff ff       	jmp    80107528 <alltraps>

8010820f <vector186>:
.globl vector186
vector186:
  pushl $0
8010820f:	6a 00                	push   $0x0
  pushl $186
80108211:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80108216:	e9 0d f3 ff ff       	jmp    80107528 <alltraps>

8010821b <vector187>:
.globl vector187
vector187:
  pushl $0
8010821b:	6a 00                	push   $0x0
  pushl $187
8010821d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108222:	e9 01 f3 ff ff       	jmp    80107528 <alltraps>

80108227 <vector188>:
.globl vector188
vector188:
  pushl $0
80108227:	6a 00                	push   $0x0
  pushl $188
80108229:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010822e:	e9 f5 f2 ff ff       	jmp    80107528 <alltraps>

80108233 <vector189>:
.globl vector189
vector189:
  pushl $0
80108233:	6a 00                	push   $0x0
  pushl $189
80108235:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010823a:	e9 e9 f2 ff ff       	jmp    80107528 <alltraps>

8010823f <vector190>:
.globl vector190
vector190:
  pushl $0
8010823f:	6a 00                	push   $0x0
  pushl $190
80108241:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108246:	e9 dd f2 ff ff       	jmp    80107528 <alltraps>

8010824b <vector191>:
.globl vector191
vector191:
  pushl $0
8010824b:	6a 00                	push   $0x0
  pushl $191
8010824d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108252:	e9 d1 f2 ff ff       	jmp    80107528 <alltraps>

80108257 <vector192>:
.globl vector192
vector192:
  pushl $0
80108257:	6a 00                	push   $0x0
  pushl $192
80108259:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010825e:	e9 c5 f2 ff ff       	jmp    80107528 <alltraps>

80108263 <vector193>:
.globl vector193
vector193:
  pushl $0
80108263:	6a 00                	push   $0x0
  pushl $193
80108265:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010826a:	e9 b9 f2 ff ff       	jmp    80107528 <alltraps>

8010826f <vector194>:
.globl vector194
vector194:
  pushl $0
8010826f:	6a 00                	push   $0x0
  pushl $194
80108271:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108276:	e9 ad f2 ff ff       	jmp    80107528 <alltraps>

8010827b <vector195>:
.globl vector195
vector195:
  pushl $0
8010827b:	6a 00                	push   $0x0
  pushl $195
8010827d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80108282:	e9 a1 f2 ff ff       	jmp    80107528 <alltraps>

80108287 <vector196>:
.globl vector196
vector196:
  pushl $0
80108287:	6a 00                	push   $0x0
  pushl $196
80108289:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010828e:	e9 95 f2 ff ff       	jmp    80107528 <alltraps>

80108293 <vector197>:
.globl vector197
vector197:
  pushl $0
80108293:	6a 00                	push   $0x0
  pushl $197
80108295:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010829a:	e9 89 f2 ff ff       	jmp    80107528 <alltraps>

8010829f <vector198>:
.globl vector198
vector198:
  pushl $0
8010829f:	6a 00                	push   $0x0
  pushl $198
801082a1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801082a6:	e9 7d f2 ff ff       	jmp    80107528 <alltraps>

801082ab <vector199>:
.globl vector199
vector199:
  pushl $0
801082ab:	6a 00                	push   $0x0
  pushl $199
801082ad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801082b2:	e9 71 f2 ff ff       	jmp    80107528 <alltraps>

801082b7 <vector200>:
.globl vector200
vector200:
  pushl $0
801082b7:	6a 00                	push   $0x0
  pushl $200
801082b9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801082be:	e9 65 f2 ff ff       	jmp    80107528 <alltraps>

801082c3 <vector201>:
.globl vector201
vector201:
  pushl $0
801082c3:	6a 00                	push   $0x0
  pushl $201
801082c5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801082ca:	e9 59 f2 ff ff       	jmp    80107528 <alltraps>

801082cf <vector202>:
.globl vector202
vector202:
  pushl $0
801082cf:	6a 00                	push   $0x0
  pushl $202
801082d1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801082d6:	e9 4d f2 ff ff       	jmp    80107528 <alltraps>

801082db <vector203>:
.globl vector203
vector203:
  pushl $0
801082db:	6a 00                	push   $0x0
  pushl $203
801082dd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801082e2:	e9 41 f2 ff ff       	jmp    80107528 <alltraps>

801082e7 <vector204>:
.globl vector204
vector204:
  pushl $0
801082e7:	6a 00                	push   $0x0
  pushl $204
801082e9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801082ee:	e9 35 f2 ff ff       	jmp    80107528 <alltraps>

801082f3 <vector205>:
.globl vector205
vector205:
  pushl $0
801082f3:	6a 00                	push   $0x0
  pushl $205
801082f5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801082fa:	e9 29 f2 ff ff       	jmp    80107528 <alltraps>

801082ff <vector206>:
.globl vector206
vector206:
  pushl $0
801082ff:	6a 00                	push   $0x0
  pushl $206
80108301:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108306:	e9 1d f2 ff ff       	jmp    80107528 <alltraps>

8010830b <vector207>:
.globl vector207
vector207:
  pushl $0
8010830b:	6a 00                	push   $0x0
  pushl $207
8010830d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108312:	e9 11 f2 ff ff       	jmp    80107528 <alltraps>

80108317 <vector208>:
.globl vector208
vector208:
  pushl $0
80108317:	6a 00                	push   $0x0
  pushl $208
80108319:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010831e:	e9 05 f2 ff ff       	jmp    80107528 <alltraps>

80108323 <vector209>:
.globl vector209
vector209:
  pushl $0
80108323:	6a 00                	push   $0x0
  pushl $209
80108325:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010832a:	e9 f9 f1 ff ff       	jmp    80107528 <alltraps>

8010832f <vector210>:
.globl vector210
vector210:
  pushl $0
8010832f:	6a 00                	push   $0x0
  pushl $210
80108331:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108336:	e9 ed f1 ff ff       	jmp    80107528 <alltraps>

8010833b <vector211>:
.globl vector211
vector211:
  pushl $0
8010833b:	6a 00                	push   $0x0
  pushl $211
8010833d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108342:	e9 e1 f1 ff ff       	jmp    80107528 <alltraps>

80108347 <vector212>:
.globl vector212
vector212:
  pushl $0
80108347:	6a 00                	push   $0x0
  pushl $212
80108349:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010834e:	e9 d5 f1 ff ff       	jmp    80107528 <alltraps>

80108353 <vector213>:
.globl vector213
vector213:
  pushl $0
80108353:	6a 00                	push   $0x0
  pushl $213
80108355:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010835a:	e9 c9 f1 ff ff       	jmp    80107528 <alltraps>

8010835f <vector214>:
.globl vector214
vector214:
  pushl $0
8010835f:	6a 00                	push   $0x0
  pushl $214
80108361:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108366:	e9 bd f1 ff ff       	jmp    80107528 <alltraps>

8010836b <vector215>:
.globl vector215
vector215:
  pushl $0
8010836b:	6a 00                	push   $0x0
  pushl $215
8010836d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108372:	e9 b1 f1 ff ff       	jmp    80107528 <alltraps>

80108377 <vector216>:
.globl vector216
vector216:
  pushl $0
80108377:	6a 00                	push   $0x0
  pushl $216
80108379:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010837e:	e9 a5 f1 ff ff       	jmp    80107528 <alltraps>

80108383 <vector217>:
.globl vector217
vector217:
  pushl $0
80108383:	6a 00                	push   $0x0
  pushl $217
80108385:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010838a:	e9 99 f1 ff ff       	jmp    80107528 <alltraps>

8010838f <vector218>:
.globl vector218
vector218:
  pushl $0
8010838f:	6a 00                	push   $0x0
  pushl $218
80108391:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80108396:	e9 8d f1 ff ff       	jmp    80107528 <alltraps>

8010839b <vector219>:
.globl vector219
vector219:
  pushl $0
8010839b:	6a 00                	push   $0x0
  pushl $219
8010839d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801083a2:	e9 81 f1 ff ff       	jmp    80107528 <alltraps>

801083a7 <vector220>:
.globl vector220
vector220:
  pushl $0
801083a7:	6a 00                	push   $0x0
  pushl $220
801083a9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801083ae:	e9 75 f1 ff ff       	jmp    80107528 <alltraps>

801083b3 <vector221>:
.globl vector221
vector221:
  pushl $0
801083b3:	6a 00                	push   $0x0
  pushl $221
801083b5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801083ba:	e9 69 f1 ff ff       	jmp    80107528 <alltraps>

801083bf <vector222>:
.globl vector222
vector222:
  pushl $0
801083bf:	6a 00                	push   $0x0
  pushl $222
801083c1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801083c6:	e9 5d f1 ff ff       	jmp    80107528 <alltraps>

801083cb <vector223>:
.globl vector223
vector223:
  pushl $0
801083cb:	6a 00                	push   $0x0
  pushl $223
801083cd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801083d2:	e9 51 f1 ff ff       	jmp    80107528 <alltraps>

801083d7 <vector224>:
.globl vector224
vector224:
  pushl $0
801083d7:	6a 00                	push   $0x0
  pushl $224
801083d9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801083de:	e9 45 f1 ff ff       	jmp    80107528 <alltraps>

801083e3 <vector225>:
.globl vector225
vector225:
  pushl $0
801083e3:	6a 00                	push   $0x0
  pushl $225
801083e5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801083ea:	e9 39 f1 ff ff       	jmp    80107528 <alltraps>

801083ef <vector226>:
.globl vector226
vector226:
  pushl $0
801083ef:	6a 00                	push   $0x0
  pushl $226
801083f1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801083f6:	e9 2d f1 ff ff       	jmp    80107528 <alltraps>

801083fb <vector227>:
.globl vector227
vector227:
  pushl $0
801083fb:	6a 00                	push   $0x0
  pushl $227
801083fd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108402:	e9 21 f1 ff ff       	jmp    80107528 <alltraps>

80108407 <vector228>:
.globl vector228
vector228:
  pushl $0
80108407:	6a 00                	push   $0x0
  pushl $228
80108409:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010840e:	e9 15 f1 ff ff       	jmp    80107528 <alltraps>

80108413 <vector229>:
.globl vector229
vector229:
  pushl $0
80108413:	6a 00                	push   $0x0
  pushl $229
80108415:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010841a:	e9 09 f1 ff ff       	jmp    80107528 <alltraps>

8010841f <vector230>:
.globl vector230
vector230:
  pushl $0
8010841f:	6a 00                	push   $0x0
  pushl $230
80108421:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108426:	e9 fd f0 ff ff       	jmp    80107528 <alltraps>

8010842b <vector231>:
.globl vector231
vector231:
  pushl $0
8010842b:	6a 00                	push   $0x0
  pushl $231
8010842d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108432:	e9 f1 f0 ff ff       	jmp    80107528 <alltraps>

80108437 <vector232>:
.globl vector232
vector232:
  pushl $0
80108437:	6a 00                	push   $0x0
  pushl $232
80108439:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010843e:	e9 e5 f0 ff ff       	jmp    80107528 <alltraps>

80108443 <vector233>:
.globl vector233
vector233:
  pushl $0
80108443:	6a 00                	push   $0x0
  pushl $233
80108445:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010844a:	e9 d9 f0 ff ff       	jmp    80107528 <alltraps>

8010844f <vector234>:
.globl vector234
vector234:
  pushl $0
8010844f:	6a 00                	push   $0x0
  pushl $234
80108451:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108456:	e9 cd f0 ff ff       	jmp    80107528 <alltraps>

8010845b <vector235>:
.globl vector235
vector235:
  pushl $0
8010845b:	6a 00                	push   $0x0
  pushl $235
8010845d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108462:	e9 c1 f0 ff ff       	jmp    80107528 <alltraps>

80108467 <vector236>:
.globl vector236
vector236:
  pushl $0
80108467:	6a 00                	push   $0x0
  pushl $236
80108469:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010846e:	e9 b5 f0 ff ff       	jmp    80107528 <alltraps>

80108473 <vector237>:
.globl vector237
vector237:
  pushl $0
80108473:	6a 00                	push   $0x0
  pushl $237
80108475:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010847a:	e9 a9 f0 ff ff       	jmp    80107528 <alltraps>

8010847f <vector238>:
.globl vector238
vector238:
  pushl $0
8010847f:	6a 00                	push   $0x0
  pushl $238
80108481:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108486:	e9 9d f0 ff ff       	jmp    80107528 <alltraps>

8010848b <vector239>:
.globl vector239
vector239:
  pushl $0
8010848b:	6a 00                	push   $0x0
  pushl $239
8010848d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108492:	e9 91 f0 ff ff       	jmp    80107528 <alltraps>

80108497 <vector240>:
.globl vector240
vector240:
  pushl $0
80108497:	6a 00                	push   $0x0
  pushl $240
80108499:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010849e:	e9 85 f0 ff ff       	jmp    80107528 <alltraps>

801084a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801084a3:	6a 00                	push   $0x0
  pushl $241
801084a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801084aa:	e9 79 f0 ff ff       	jmp    80107528 <alltraps>

801084af <vector242>:
.globl vector242
vector242:
  pushl $0
801084af:	6a 00                	push   $0x0
  pushl $242
801084b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801084b6:	e9 6d f0 ff ff       	jmp    80107528 <alltraps>

801084bb <vector243>:
.globl vector243
vector243:
  pushl $0
801084bb:	6a 00                	push   $0x0
  pushl $243
801084bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801084c2:	e9 61 f0 ff ff       	jmp    80107528 <alltraps>

801084c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801084c7:	6a 00                	push   $0x0
  pushl $244
801084c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801084ce:	e9 55 f0 ff ff       	jmp    80107528 <alltraps>

801084d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801084d3:	6a 00                	push   $0x0
  pushl $245
801084d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801084da:	e9 49 f0 ff ff       	jmp    80107528 <alltraps>

801084df <vector246>:
.globl vector246
vector246:
  pushl $0
801084df:	6a 00                	push   $0x0
  pushl $246
801084e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801084e6:	e9 3d f0 ff ff       	jmp    80107528 <alltraps>

801084eb <vector247>:
.globl vector247
vector247:
  pushl $0
801084eb:	6a 00                	push   $0x0
  pushl $247
801084ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801084f2:	e9 31 f0 ff ff       	jmp    80107528 <alltraps>

801084f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801084f7:	6a 00                	push   $0x0
  pushl $248
801084f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801084fe:	e9 25 f0 ff ff       	jmp    80107528 <alltraps>

80108503 <vector249>:
.globl vector249
vector249:
  pushl $0
80108503:	6a 00                	push   $0x0
  pushl $249
80108505:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010850a:	e9 19 f0 ff ff       	jmp    80107528 <alltraps>

8010850f <vector250>:
.globl vector250
vector250:
  pushl $0
8010850f:	6a 00                	push   $0x0
  pushl $250
80108511:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108516:	e9 0d f0 ff ff       	jmp    80107528 <alltraps>

8010851b <vector251>:
.globl vector251
vector251:
  pushl $0
8010851b:	6a 00                	push   $0x0
  pushl $251
8010851d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108522:	e9 01 f0 ff ff       	jmp    80107528 <alltraps>

80108527 <vector252>:
.globl vector252
vector252:
  pushl $0
80108527:	6a 00                	push   $0x0
  pushl $252
80108529:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010852e:	e9 f5 ef ff ff       	jmp    80107528 <alltraps>

80108533 <vector253>:
.globl vector253
vector253:
  pushl $0
80108533:	6a 00                	push   $0x0
  pushl $253
80108535:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010853a:	e9 e9 ef ff ff       	jmp    80107528 <alltraps>

8010853f <vector254>:
.globl vector254
vector254:
  pushl $0
8010853f:	6a 00                	push   $0x0
  pushl $254
80108541:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108546:	e9 dd ef ff ff       	jmp    80107528 <alltraps>

8010854b <vector255>:
.globl vector255
vector255:
  pushl $0
8010854b:	6a 00                	push   $0x0
  pushl $255
8010854d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108552:	e9 d1 ef ff ff       	jmp    80107528 <alltraps>
80108557:	66 90                	xchg   %ax,%ax
80108559:	66 90                	xchg   %ax,%ax
8010855b:	66 90                	xchg   %ax,%ax
8010855d:	66 90                	xchg   %ax,%ax
8010855f:	90                   	nop

80108560 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108560:	55                   	push   %ebp
80108561:	89 e5                	mov    %esp,%ebp
80108563:	57                   	push   %edi
80108564:	56                   	push   %esi
80108565:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80108566:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010856c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108572:	83 ec 1c             	sub    $0x1c,%esp
80108575:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108578:	39 d3                	cmp    %edx,%ebx
8010857a:	73 49                	jae    801085c5 <deallocuvm.part.0+0x65>
8010857c:	89 c7                	mov    %eax,%edi
8010857e:	eb 0c                	jmp    8010858c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80108580:	83 c0 01             	add    $0x1,%eax
80108583:	c1 e0 16             	shl    $0x16,%eax
80108586:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108588:	39 da                	cmp    %ebx,%edx
8010858a:	76 39                	jbe    801085c5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010858c:	89 d8                	mov    %ebx,%eax
8010858e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108591:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80108594:	f6 c1 01             	test   $0x1,%cl
80108597:	74 e7                	je     80108580 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80108599:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010859b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801085a1:	c1 ee 0a             	shr    $0xa,%esi
801085a4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801085aa:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
801085b1:	85 f6                	test   %esi,%esi
801085b3:	74 cb                	je     80108580 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
801085b5:	8b 06                	mov    (%esi),%eax
801085b7:	a8 01                	test   $0x1,%al
801085b9:	75 15                	jne    801085d0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
801085bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801085c1:	39 da                	cmp    %ebx,%edx
801085c3:	77 c7                	ja     8010858c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801085c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801085cb:	5b                   	pop    %ebx
801085cc:	5e                   	pop    %esi
801085cd:	5f                   	pop    %edi
801085ce:	5d                   	pop    %ebp
801085cf:	c3                   	ret    
      if(pa == 0)
801085d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085d5:	74 25                	je     801085fc <deallocuvm.part.0+0x9c>
      kfree(v);
801085d7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801085da:	05 00 00 00 80       	add    $0x80000000,%eax
801085df:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801085e2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
801085e8:	50                   	push   %eax
801085e9:	e8 12 ac ff ff       	call   80103200 <kfree>
      *pte = 0;
801085ee:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
801085f4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801085f7:	83 c4 10             	add    $0x10,%esp
801085fa:	eb 8c                	jmp    80108588 <deallocuvm.part.0+0x28>
        panic("kfree");
801085fc:	83 ec 0c             	sub    $0xc,%esp
801085ff:	68 12 92 10 80       	push   $0x80109212
80108604:	e8 e7 7e ff ff       	call   801004f0 <panic>
80108609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108610 <mappages>:
{
80108610:	55                   	push   %ebp
80108611:	89 e5                	mov    %esp,%ebp
80108613:	57                   	push   %edi
80108614:	56                   	push   %esi
80108615:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80108616:	89 d3                	mov    %edx,%ebx
80108618:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010861e:	83 ec 1c             	sub    $0x1c,%esp
80108621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108624:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108628:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010862d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80108630:	8b 45 08             	mov    0x8(%ebp),%eax
80108633:	29 d8                	sub    %ebx,%eax
80108635:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108638:	eb 3d                	jmp    80108677 <mappages+0x67>
8010863a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108640:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108642:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108647:	c1 ea 0a             	shr    $0xa,%edx
8010864a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108650:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108657:	85 c0                	test   %eax,%eax
80108659:	74 75                	je     801086d0 <mappages+0xc0>
    if(*pte & PTE_P)
8010865b:	f6 00 01             	testb  $0x1,(%eax)
8010865e:	0f 85 86 00 00 00    	jne    801086ea <mappages+0xda>
    *pte = pa | perm | PTE_P;
80108664:	0b 75 0c             	or     0xc(%ebp),%esi
80108667:	83 ce 01             	or     $0x1,%esi
8010866a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010866c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010866f:	74 6f                	je     801086e0 <mappages+0xd0>
    a += PGSIZE;
80108671:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80108677:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010867a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010867d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80108680:	89 d8                	mov    %ebx,%eax
80108682:	c1 e8 16             	shr    $0x16,%eax
80108685:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80108688:	8b 07                	mov    (%edi),%eax
8010868a:	a8 01                	test   $0x1,%al
8010868c:	75 b2                	jne    80108640 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010868e:	e8 2d ad ff ff       	call   801033c0 <kalloc>
80108693:	85 c0                	test   %eax,%eax
80108695:	74 39                	je     801086d0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80108697:	83 ec 04             	sub    $0x4,%esp
8010869a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010869d:	68 00 10 00 00       	push   $0x1000
801086a2:	6a 00                	push   $0x0
801086a4:	50                   	push   %eax
801086a5:	e8 c6 d7 ff ff       	call   80105e70 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801086aa:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801086ad:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801086b0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801086b6:	83 c8 07             	or     $0x7,%eax
801086b9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801086bb:	89 d8                	mov    %ebx,%eax
801086bd:	c1 e8 0a             	shr    $0xa,%eax
801086c0:	25 fc 0f 00 00       	and    $0xffc,%eax
801086c5:	01 d0                	add    %edx,%eax
801086c7:	eb 92                	jmp    8010865b <mappages+0x4b>
801086c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801086d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801086d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801086d8:	5b                   	pop    %ebx
801086d9:	5e                   	pop    %esi
801086da:	5f                   	pop    %edi
801086db:	5d                   	pop    %ebp
801086dc:	c3                   	ret    
801086dd:	8d 76 00             	lea    0x0(%esi),%esi
801086e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801086e3:	31 c0                	xor    %eax,%eax
}
801086e5:	5b                   	pop    %ebx
801086e6:	5e                   	pop    %esi
801086e7:	5f                   	pop    %edi
801086e8:	5d                   	pop    %ebp
801086e9:	c3                   	ret    
      panic("remap");
801086ea:	83 ec 0c             	sub    $0xc,%esp
801086ed:	68 a8 9a 10 80       	push   $0x80109aa8
801086f2:	e8 f9 7d ff ff       	call   801004f0 <panic>
801086f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801086fe:	66 90                	xchg   %ax,%ax

80108700 <seginit>:
{
80108700:	55                   	push   %ebp
80108701:	89 e5                	mov    %esp,%ebp
80108703:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108706:	e8 05 c0 ff ff       	call   80104710 <cpuid>
  pd[0] = size-1;
8010870b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108710:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80108716:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010871a:	c7 80 b8 3e 11 80 ff 	movl   $0xffff,-0x7feec148(%eax)
80108721:	ff 00 00 
80108724:	c7 80 bc 3e 11 80 00 	movl   $0xcf9a00,-0x7feec144(%eax)
8010872b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010872e:	c7 80 c0 3e 11 80 ff 	movl   $0xffff,-0x7feec140(%eax)
80108735:	ff 00 00 
80108738:	c7 80 c4 3e 11 80 00 	movl   $0xcf9200,-0x7feec13c(%eax)
8010873f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108742:	c7 80 c8 3e 11 80 ff 	movl   $0xffff,-0x7feec138(%eax)
80108749:	ff 00 00 
8010874c:	c7 80 cc 3e 11 80 00 	movl   $0xcffa00,-0x7feec134(%eax)
80108753:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108756:	c7 80 d0 3e 11 80 ff 	movl   $0xffff,-0x7feec130(%eax)
8010875d:	ff 00 00 
80108760:	c7 80 d4 3e 11 80 00 	movl   $0xcff200,-0x7feec12c(%eax)
80108767:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010876a:	05 b0 3e 11 80       	add    $0x80113eb0,%eax
  pd[1] = (uint)p;
8010876f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108773:	c1 e8 10             	shr    $0x10,%eax
80108776:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010877a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010877d:	0f 01 10             	lgdtl  (%eax)
}
80108780:	c9                   	leave  
80108781:	c3                   	ret    
80108782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108790 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108790:	a1 64 8f 11 80       	mov    0x80118f64,%eax
80108795:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010879a:	0f 22 d8             	mov    %eax,%cr3
}
8010879d:	c3                   	ret    
8010879e:	66 90                	xchg   %ax,%ax

801087a0 <switchuvm>:
{
801087a0:	55                   	push   %ebp
801087a1:	89 e5                	mov    %esp,%ebp
801087a3:	57                   	push   %edi
801087a4:	56                   	push   %esi
801087a5:	53                   	push   %ebx
801087a6:	83 ec 1c             	sub    $0x1c,%esp
801087a9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801087ac:	85 f6                	test   %esi,%esi
801087ae:	0f 84 cb 00 00 00    	je     8010887f <switchuvm+0xdf>
  if(p->kstack == 0)
801087b4:	8b 46 74             	mov    0x74(%esi),%eax
801087b7:	85 c0                	test   %eax,%eax
801087b9:	0f 84 da 00 00 00    	je     80108899 <switchuvm+0xf9>
  if(p->pgdir == 0)
801087bf:	8b 46 70             	mov    0x70(%esi),%eax
801087c2:	85 c0                	test   %eax,%eax
801087c4:	0f 84 c2 00 00 00    	je     8010888c <switchuvm+0xec>
  pushcli();
801087ca:	e8 91 d4 ff ff       	call   80105c60 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801087cf:	e8 dc be ff ff       	call   801046b0 <mycpu>
801087d4:	89 c3                	mov    %eax,%ebx
801087d6:	e8 d5 be ff ff       	call   801046b0 <mycpu>
801087db:	89 c7                	mov    %eax,%edi
801087dd:	e8 ce be ff ff       	call   801046b0 <mycpu>
801087e2:	83 c7 08             	add    $0x8,%edi
801087e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801087e8:	e8 c3 be ff ff       	call   801046b0 <mycpu>
801087ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801087f0:	ba 67 00 00 00       	mov    $0x67,%edx
801087f5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801087fc:	83 c0 08             	add    $0x8,%eax
801087ff:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108806:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010880b:	83 c1 08             	add    $0x8,%ecx
8010880e:	c1 e8 18             	shr    $0x18,%eax
80108811:	c1 e9 10             	shr    $0x10,%ecx
80108814:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010881a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80108820:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108825:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010882c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80108831:	e8 7a be ff ff       	call   801046b0 <mycpu>
80108836:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010883d:	e8 6e be ff ff       	call   801046b0 <mycpu>
80108842:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108846:	8b 5e 74             	mov    0x74(%esi),%ebx
80108849:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010884f:	e8 5c be ff ff       	call   801046b0 <mycpu>
80108854:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108857:	e8 54 be ff ff       	call   801046b0 <mycpu>
8010885c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108860:	b8 28 00 00 00       	mov    $0x28,%eax
80108865:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108868:	8b 46 70             	mov    0x70(%esi),%eax
8010886b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108870:	0f 22 d8             	mov    %eax,%cr3
}
80108873:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108876:	5b                   	pop    %ebx
80108877:	5e                   	pop    %esi
80108878:	5f                   	pop    %edi
80108879:	5d                   	pop    %ebp
  popcli();
8010887a:	e9 31 d4 ff ff       	jmp    80105cb0 <popcli>
    panic("switchuvm: no process");
8010887f:	83 ec 0c             	sub    $0xc,%esp
80108882:	68 ae 9a 10 80       	push   $0x80109aae
80108887:	e8 64 7c ff ff       	call   801004f0 <panic>
    panic("switchuvm: no pgdir");
8010888c:	83 ec 0c             	sub    $0xc,%esp
8010888f:	68 d9 9a 10 80       	push   $0x80109ad9
80108894:	e8 57 7c ff ff       	call   801004f0 <panic>
    panic("switchuvm: no kstack");
80108899:	83 ec 0c             	sub    $0xc,%esp
8010889c:	68 c4 9a 10 80       	push   $0x80109ac4
801088a1:	e8 4a 7c ff ff       	call   801004f0 <panic>
801088a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801088ad:	8d 76 00             	lea    0x0(%esi),%esi

801088b0 <inituvm>:
{
801088b0:	55                   	push   %ebp
801088b1:	89 e5                	mov    %esp,%ebp
801088b3:	57                   	push   %edi
801088b4:	56                   	push   %esi
801088b5:	53                   	push   %ebx
801088b6:	83 ec 1c             	sub    $0x1c,%esp
801088b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801088bc:	8b 75 10             	mov    0x10(%ebp),%esi
801088bf:	8b 7d 08             	mov    0x8(%ebp),%edi
801088c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801088c5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801088cb:	77 4b                	ja     80108918 <inituvm+0x68>
  mem = kalloc();
801088cd:	e8 ee aa ff ff       	call   801033c0 <kalloc>
  memset(mem, 0, PGSIZE);
801088d2:	83 ec 04             	sub    $0x4,%esp
801088d5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801088da:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801088dc:	6a 00                	push   $0x0
801088de:	50                   	push   %eax
801088df:	e8 8c d5 ff ff       	call   80105e70 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801088e4:	58                   	pop    %eax
801088e5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801088eb:	5a                   	pop    %edx
801088ec:	6a 06                	push   $0x6
801088ee:	b9 00 10 00 00       	mov    $0x1000,%ecx
801088f3:	31 d2                	xor    %edx,%edx
801088f5:	50                   	push   %eax
801088f6:	89 f8                	mov    %edi,%eax
801088f8:	e8 13 fd ff ff       	call   80108610 <mappages>
  memmove(mem, init, sz);
801088fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108900:	89 75 10             	mov    %esi,0x10(%ebp)
80108903:	83 c4 10             	add    $0x10,%esp
80108906:	89 5d 08             	mov    %ebx,0x8(%ebp)
80108909:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010890c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010890f:	5b                   	pop    %ebx
80108910:	5e                   	pop    %esi
80108911:	5f                   	pop    %edi
80108912:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108913:	e9 f8 d5 ff ff       	jmp    80105f10 <memmove>
    panic("inituvm: more than a page");
80108918:	83 ec 0c             	sub    $0xc,%esp
8010891b:	68 ed 9a 10 80       	push   $0x80109aed
80108920:	e8 cb 7b ff ff       	call   801004f0 <panic>
80108925:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010892c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108930 <loaduvm>:
{
80108930:	55                   	push   %ebp
80108931:	89 e5                	mov    %esp,%ebp
80108933:	57                   	push   %edi
80108934:	56                   	push   %esi
80108935:	53                   	push   %ebx
80108936:	83 ec 1c             	sub    $0x1c,%esp
80108939:	8b 45 0c             	mov    0xc(%ebp),%eax
8010893c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010893f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80108944:	0f 85 bb 00 00 00    	jne    80108a05 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010894a:	01 f0                	add    %esi,%eax
8010894c:	89 f3                	mov    %esi,%ebx
8010894e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108951:	8b 45 14             	mov    0x14(%ebp),%eax
80108954:	01 f0                	add    %esi,%eax
80108956:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80108959:	85 f6                	test   %esi,%esi
8010895b:	0f 84 87 00 00 00    	je     801089e8 <loaduvm+0xb8>
80108961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80108968:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010896b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010896e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80108970:	89 c2                	mov    %eax,%edx
80108972:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80108975:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80108978:	f6 c2 01             	test   $0x1,%dl
8010897b:	75 13                	jne    80108990 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010897d:	83 ec 0c             	sub    $0xc,%esp
80108980:	68 07 9b 10 80       	push   $0x80109b07
80108985:	e8 66 7b ff ff       	call   801004f0 <panic>
8010898a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108990:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108993:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108999:	25 fc 0f 00 00       	and    $0xffc,%eax
8010899e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801089a5:	85 c0                	test   %eax,%eax
801089a7:	74 d4                	je     8010897d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
801089a9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801089ab:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801089ae:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801089b3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801089b8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801089be:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801089c1:	29 d9                	sub    %ebx,%ecx
801089c3:	05 00 00 00 80       	add    $0x80000000,%eax
801089c8:	57                   	push   %edi
801089c9:	51                   	push   %ecx
801089ca:	50                   	push   %eax
801089cb:	ff 75 10             	push   0x10(%ebp)
801089ce:	e8 ed 9d ff ff       	call   801027c0 <readi>
801089d3:	83 c4 10             	add    $0x10,%esp
801089d6:	39 f8                	cmp    %edi,%eax
801089d8:	75 1e                	jne    801089f8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801089da:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801089e0:	89 f0                	mov    %esi,%eax
801089e2:	29 d8                	sub    %ebx,%eax
801089e4:	39 c6                	cmp    %eax,%esi
801089e6:	77 80                	ja     80108968 <loaduvm+0x38>
}
801089e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801089eb:	31 c0                	xor    %eax,%eax
}
801089ed:	5b                   	pop    %ebx
801089ee:	5e                   	pop    %esi
801089ef:	5f                   	pop    %edi
801089f0:	5d                   	pop    %ebp
801089f1:	c3                   	ret    
801089f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801089f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801089fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108a00:	5b                   	pop    %ebx
80108a01:	5e                   	pop    %esi
80108a02:	5f                   	pop    %edi
80108a03:	5d                   	pop    %ebp
80108a04:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80108a05:	83 ec 0c             	sub    $0xc,%esp
80108a08:	68 a8 9b 10 80       	push   $0x80109ba8
80108a0d:	e8 de 7a ff ff       	call   801004f0 <panic>
80108a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108a20 <allocuvm>:
{
80108a20:	55                   	push   %ebp
80108a21:	89 e5                	mov    %esp,%ebp
80108a23:	57                   	push   %edi
80108a24:	56                   	push   %esi
80108a25:	53                   	push   %ebx
80108a26:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108a29:	8b 45 10             	mov    0x10(%ebp),%eax
{
80108a2c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80108a2f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108a32:	85 c0                	test   %eax,%eax
80108a34:	0f 88 b6 00 00 00    	js     80108af0 <allocuvm+0xd0>
  if(newsz < oldsz)
80108a3a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80108a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80108a40:	0f 82 9a 00 00 00    	jb     80108ae0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80108a46:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80108a4c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80108a52:	39 75 10             	cmp    %esi,0x10(%ebp)
80108a55:	77 44                	ja     80108a9b <allocuvm+0x7b>
80108a57:	e9 87 00 00 00       	jmp    80108ae3 <allocuvm+0xc3>
80108a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80108a60:	83 ec 04             	sub    $0x4,%esp
80108a63:	68 00 10 00 00       	push   $0x1000
80108a68:	6a 00                	push   $0x0
80108a6a:	50                   	push   %eax
80108a6b:	e8 00 d4 ff ff       	call   80105e70 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108a70:	58                   	pop    %eax
80108a71:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108a77:	5a                   	pop    %edx
80108a78:	6a 06                	push   $0x6
80108a7a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108a7f:	89 f2                	mov    %esi,%edx
80108a81:	50                   	push   %eax
80108a82:	89 f8                	mov    %edi,%eax
80108a84:	e8 87 fb ff ff       	call   80108610 <mappages>
80108a89:	83 c4 10             	add    $0x10,%esp
80108a8c:	85 c0                	test   %eax,%eax
80108a8e:	78 78                	js     80108b08 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80108a90:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108a96:	39 75 10             	cmp    %esi,0x10(%ebp)
80108a99:	76 48                	jbe    80108ae3 <allocuvm+0xc3>
    mem = kalloc();
80108a9b:	e8 20 a9 ff ff       	call   801033c0 <kalloc>
80108aa0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80108aa2:	85 c0                	test   %eax,%eax
80108aa4:	75 ba                	jne    80108a60 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108aa6:	83 ec 0c             	sub    $0xc,%esp
80108aa9:	68 25 9b 10 80       	push   $0x80109b25
80108aae:	e8 bd 7f ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
80108ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ab6:	83 c4 10             	add    $0x10,%esp
80108ab9:	39 45 10             	cmp    %eax,0x10(%ebp)
80108abc:	74 32                	je     80108af0 <allocuvm+0xd0>
80108abe:	8b 55 10             	mov    0x10(%ebp),%edx
80108ac1:	89 c1                	mov    %eax,%ecx
80108ac3:	89 f8                	mov    %edi,%eax
80108ac5:	e8 96 fa ff ff       	call   80108560 <deallocuvm.part.0>
      return 0;
80108aca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108ad1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108ad4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108ad7:	5b                   	pop    %ebx
80108ad8:	5e                   	pop    %esi
80108ad9:	5f                   	pop    %edi
80108ada:	5d                   	pop    %ebp
80108adb:	c3                   	ret    
80108adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108ae0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80108ae3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108ae6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108ae9:	5b                   	pop    %ebx
80108aea:	5e                   	pop    %esi
80108aeb:	5f                   	pop    %edi
80108aec:	5d                   	pop    %ebp
80108aed:	c3                   	ret    
80108aee:	66 90                	xchg   %ax,%ax
    return 0;
80108af0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108af7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108afa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108afd:	5b                   	pop    %ebx
80108afe:	5e                   	pop    %esi
80108aff:	5f                   	pop    %edi
80108b00:	5d                   	pop    %ebp
80108b01:	c3                   	ret    
80108b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108b08:	83 ec 0c             	sub    $0xc,%esp
80108b0b:	68 3d 9b 10 80       	push   $0x80109b3d
80108b10:	e8 5b 7f ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
80108b15:	8b 45 0c             	mov    0xc(%ebp),%eax
80108b18:	83 c4 10             	add    $0x10,%esp
80108b1b:	39 45 10             	cmp    %eax,0x10(%ebp)
80108b1e:	74 0c                	je     80108b2c <allocuvm+0x10c>
80108b20:	8b 55 10             	mov    0x10(%ebp),%edx
80108b23:	89 c1                	mov    %eax,%ecx
80108b25:	89 f8                	mov    %edi,%eax
80108b27:	e8 34 fa ff ff       	call   80108560 <deallocuvm.part.0>
      kfree(mem);
80108b2c:	83 ec 0c             	sub    $0xc,%esp
80108b2f:	53                   	push   %ebx
80108b30:	e8 cb a6 ff ff       	call   80103200 <kfree>
      return 0;
80108b35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80108b3c:	83 c4 10             	add    $0x10,%esp
}
80108b3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108b42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108b45:	5b                   	pop    %ebx
80108b46:	5e                   	pop    %esi
80108b47:	5f                   	pop    %edi
80108b48:	5d                   	pop    %ebp
80108b49:	c3                   	ret    
80108b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108b50 <deallocuvm>:
{
80108b50:	55                   	push   %ebp
80108b51:	89 e5                	mov    %esp,%ebp
80108b53:	8b 55 0c             	mov    0xc(%ebp),%edx
80108b56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108b59:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80108b5c:	39 d1                	cmp    %edx,%ecx
80108b5e:	73 10                	jae    80108b70 <deallocuvm+0x20>
}
80108b60:	5d                   	pop    %ebp
80108b61:	e9 fa f9 ff ff       	jmp    80108560 <deallocuvm.part.0>
80108b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108b6d:	8d 76 00             	lea    0x0(%esi),%esi
80108b70:	89 d0                	mov    %edx,%eax
80108b72:	5d                   	pop    %ebp
80108b73:	c3                   	ret    
80108b74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108b7f:	90                   	nop

80108b80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108b80:	55                   	push   %ebp
80108b81:	89 e5                	mov    %esp,%ebp
80108b83:	57                   	push   %edi
80108b84:	56                   	push   %esi
80108b85:	53                   	push   %ebx
80108b86:	83 ec 0c             	sub    $0xc,%esp
80108b89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80108b8c:	85 f6                	test   %esi,%esi
80108b8e:	74 59                	je     80108be9 <freevm+0x69>
  if(newsz >= oldsz)
80108b90:	31 c9                	xor    %ecx,%ecx
80108b92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108b97:	89 f0                	mov    %esi,%eax
80108b99:	89 f3                	mov    %esi,%ebx
80108b9b:	e8 c0 f9 ff ff       	call   80108560 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108ba0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108ba6:	eb 0f                	jmp    80108bb7 <freevm+0x37>
80108ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108baf:	90                   	nop
80108bb0:	83 c3 04             	add    $0x4,%ebx
80108bb3:	39 df                	cmp    %ebx,%edi
80108bb5:	74 23                	je     80108bda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108bb7:	8b 03                	mov    (%ebx),%eax
80108bb9:	a8 01                	test   $0x1,%al
80108bbb:	74 f3                	je     80108bb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108bbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108bc2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108bc5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108bc8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80108bcd:	50                   	push   %eax
80108bce:	e8 2d a6 ff ff       	call   80103200 <kfree>
80108bd3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108bd6:	39 df                	cmp    %ebx,%edi
80108bd8:	75 dd                	jne    80108bb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108bda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108bdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108be0:	5b                   	pop    %ebx
80108be1:	5e                   	pop    %esi
80108be2:	5f                   	pop    %edi
80108be3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108be4:	e9 17 a6 ff ff       	jmp    80103200 <kfree>
    panic("freevm: no pgdir");
80108be9:	83 ec 0c             	sub    $0xc,%esp
80108bec:	68 59 9b 10 80       	push   $0x80109b59
80108bf1:	e8 fa 78 ff ff       	call   801004f0 <panic>
80108bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108bfd:	8d 76 00             	lea    0x0(%esi),%esi

80108c00 <setupkvm>:
{
80108c00:	55                   	push   %ebp
80108c01:	89 e5                	mov    %esp,%ebp
80108c03:	56                   	push   %esi
80108c04:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108c05:	e8 b6 a7 ff ff       	call   801033c0 <kalloc>
80108c0a:	89 c6                	mov    %eax,%esi
80108c0c:	85 c0                	test   %eax,%eax
80108c0e:	74 42                	je     80108c52 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108c10:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108c13:	bb 80 c4 10 80       	mov    $0x8010c480,%ebx
  memset(pgdir, 0, PGSIZE);
80108c18:	68 00 10 00 00       	push   $0x1000
80108c1d:	6a 00                	push   $0x0
80108c1f:	50                   	push   %eax
80108c20:	e8 4b d2 ff ff       	call   80105e70 <memset>
80108c25:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108c28:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108c2b:	83 ec 08             	sub    $0x8,%esp
80108c2e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108c31:	ff 73 0c             	push   0xc(%ebx)
80108c34:	8b 13                	mov    (%ebx),%edx
80108c36:	50                   	push   %eax
80108c37:	29 c1                	sub    %eax,%ecx
80108c39:	89 f0                	mov    %esi,%eax
80108c3b:	e8 d0 f9 ff ff       	call   80108610 <mappages>
80108c40:	83 c4 10             	add    $0x10,%esp
80108c43:	85 c0                	test   %eax,%eax
80108c45:	78 19                	js     80108c60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108c47:	83 c3 10             	add    $0x10,%ebx
80108c4a:	81 fb c0 c4 10 80    	cmp    $0x8010c4c0,%ebx
80108c50:	75 d6                	jne    80108c28 <setupkvm+0x28>
}
80108c52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108c55:	89 f0                	mov    %esi,%eax
80108c57:	5b                   	pop    %ebx
80108c58:	5e                   	pop    %esi
80108c59:	5d                   	pop    %ebp
80108c5a:	c3                   	ret    
80108c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108c5f:	90                   	nop
      freevm(pgdir);
80108c60:	83 ec 0c             	sub    $0xc,%esp
80108c63:	56                   	push   %esi
      return 0;
80108c64:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108c66:	e8 15 ff ff ff       	call   80108b80 <freevm>
      return 0;
80108c6b:	83 c4 10             	add    $0x10,%esp
}
80108c6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108c71:	89 f0                	mov    %esi,%eax
80108c73:	5b                   	pop    %ebx
80108c74:	5e                   	pop    %esi
80108c75:	5d                   	pop    %ebp
80108c76:	c3                   	ret    
80108c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108c7e:	66 90                	xchg   %ax,%ax

80108c80 <kvmalloc>:
{
80108c80:	55                   	push   %ebp
80108c81:	89 e5                	mov    %esp,%ebp
80108c83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108c86:	e8 75 ff ff ff       	call   80108c00 <setupkvm>
80108c8b:	a3 64 8f 11 80       	mov    %eax,0x80118f64
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108c90:	05 00 00 00 80       	add    $0x80000000,%eax
80108c95:	0f 22 d8             	mov    %eax,%cr3
}
80108c98:	c9                   	leave  
80108c99:	c3                   	ret    
80108c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108ca0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108ca0:	55                   	push   %ebp
80108ca1:	89 e5                	mov    %esp,%ebp
80108ca3:	83 ec 08             	sub    $0x8,%esp
80108ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108ca9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108cac:	89 c1                	mov    %eax,%ecx
80108cae:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108cb1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108cb4:	f6 c2 01             	test   $0x1,%dl
80108cb7:	75 17                	jne    80108cd0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80108cb9:	83 ec 0c             	sub    $0xc,%esp
80108cbc:	68 6a 9b 10 80       	push   $0x80109b6a
80108cc1:	e8 2a 78 ff ff       	call   801004f0 <panic>
80108cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108ccd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108cd0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108cd3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108cd9:	25 fc 0f 00 00       	and    $0xffc,%eax
80108cde:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80108ce5:	85 c0                	test   %eax,%eax
80108ce7:	74 d0                	je     80108cb9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80108ce9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80108cec:	c9                   	leave  
80108ced:	c3                   	ret    
80108cee:	66 90                	xchg   %ax,%ax

80108cf0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108cf0:	55                   	push   %ebp
80108cf1:	89 e5                	mov    %esp,%ebp
80108cf3:	57                   	push   %edi
80108cf4:	56                   	push   %esi
80108cf5:	53                   	push   %ebx
80108cf6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108cf9:	e8 02 ff ff ff       	call   80108c00 <setupkvm>
80108cfe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108d01:	85 c0                	test   %eax,%eax
80108d03:	0f 84 bd 00 00 00    	je     80108dc6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108d09:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108d0c:	85 c9                	test   %ecx,%ecx
80108d0e:	0f 84 b2 00 00 00    	je     80108dc6 <copyuvm+0xd6>
80108d14:	31 f6                	xor    %esi,%esi
80108d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108d1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80108d20:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80108d23:	89 f0                	mov    %esi,%eax
80108d25:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108d28:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80108d2b:	a8 01                	test   $0x1,%al
80108d2d:	75 11                	jne    80108d40 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80108d2f:	83 ec 0c             	sub    $0xc,%esp
80108d32:	68 74 9b 10 80       	push   $0x80109b74
80108d37:	e8 b4 77 ff ff       	call   801004f0 <panic>
80108d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80108d40:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108d42:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108d47:	c1 ea 0a             	shr    $0xa,%edx
80108d4a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108d50:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108d57:	85 c0                	test   %eax,%eax
80108d59:	74 d4                	je     80108d2f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80108d5b:	8b 00                	mov    (%eax),%eax
80108d5d:	a8 01                	test   $0x1,%al
80108d5f:	0f 84 9f 00 00 00    	je     80108e04 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108d65:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108d67:	25 ff 0f 00 00       	and    $0xfff,%eax
80108d6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80108d6f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108d75:	e8 46 a6 ff ff       	call   801033c0 <kalloc>
80108d7a:	89 c3                	mov    %eax,%ebx
80108d7c:	85 c0                	test   %eax,%eax
80108d7e:	74 64                	je     80108de4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108d80:	83 ec 04             	sub    $0x4,%esp
80108d83:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108d89:	68 00 10 00 00       	push   $0x1000
80108d8e:	57                   	push   %edi
80108d8f:	50                   	push   %eax
80108d90:	e8 7b d1 ff ff       	call   80105f10 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108d95:	58                   	pop    %eax
80108d96:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108d9c:	5a                   	pop    %edx
80108d9d:	ff 75 e4             	push   -0x1c(%ebp)
80108da0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108da5:	89 f2                	mov    %esi,%edx
80108da7:	50                   	push   %eax
80108da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108dab:	e8 60 f8 ff ff       	call   80108610 <mappages>
80108db0:	83 c4 10             	add    $0x10,%esp
80108db3:	85 c0                	test   %eax,%eax
80108db5:	78 21                	js     80108dd8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80108db7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108dbd:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108dc0:	0f 87 5a ff ff ff    	ja     80108d20 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108dc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108dc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108dcc:	5b                   	pop    %ebx
80108dcd:	5e                   	pop    %esi
80108dce:	5f                   	pop    %edi
80108dcf:	5d                   	pop    %ebp
80108dd0:	c3                   	ret    
80108dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108dd8:	83 ec 0c             	sub    $0xc,%esp
80108ddb:	53                   	push   %ebx
80108ddc:	e8 1f a4 ff ff       	call   80103200 <kfree>
      goto bad;
80108de1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80108de4:	83 ec 0c             	sub    $0xc,%esp
80108de7:	ff 75 e0             	push   -0x20(%ebp)
80108dea:	e8 91 fd ff ff       	call   80108b80 <freevm>
  return 0;
80108def:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108df6:	83 c4 10             	add    $0x10,%esp
}
80108df9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108dff:	5b                   	pop    %ebx
80108e00:	5e                   	pop    %esi
80108e01:	5f                   	pop    %edi
80108e02:	5d                   	pop    %ebp
80108e03:	c3                   	ret    
      panic("copyuvm: page not present");
80108e04:	83 ec 0c             	sub    $0xc,%esp
80108e07:	68 8e 9b 10 80       	push   $0x80109b8e
80108e0c:	e8 df 76 ff ff       	call   801004f0 <panic>
80108e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108e18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108e1f:	90                   	nop

80108e20 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108e20:	55                   	push   %ebp
80108e21:	89 e5                	mov    %esp,%ebp
80108e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108e26:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108e29:	89 c1                	mov    %eax,%ecx
80108e2b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108e2e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108e31:	f6 c2 01             	test   $0x1,%dl
80108e34:	0f 84 00 01 00 00    	je     80108f3a <uva2ka.cold>
  return &pgtab[PTX(va)];
80108e3a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108e3d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108e43:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80108e44:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80108e49:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80108e50:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108e52:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108e57:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108e5a:	05 00 00 00 80       	add    $0x80000000,%eax
80108e5f:	83 fa 05             	cmp    $0x5,%edx
80108e62:	ba 00 00 00 00       	mov    $0x0,%edx
80108e67:	0f 45 c2             	cmovne %edx,%eax
}
80108e6a:	c3                   	ret    
80108e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108e6f:	90                   	nop

80108e70 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108e70:	55                   	push   %ebp
80108e71:	89 e5                	mov    %esp,%ebp
80108e73:	57                   	push   %edi
80108e74:	56                   	push   %esi
80108e75:	53                   	push   %ebx
80108e76:	83 ec 0c             	sub    $0xc,%esp
80108e79:	8b 75 14             	mov    0x14(%ebp),%esi
80108e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e7f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108e82:	85 f6                	test   %esi,%esi
80108e84:	75 51                	jne    80108ed7 <copyout+0x67>
80108e86:	e9 a5 00 00 00       	jmp    80108f30 <copyout+0xc0>
80108e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108e8f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80108e90:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108e96:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80108e9c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80108ea2:	74 75                	je     80108f19 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80108ea4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108ea6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80108ea9:	29 c3                	sub    %eax,%ebx
80108eab:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108eb1:	39 f3                	cmp    %esi,%ebx
80108eb3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80108eb6:	29 f8                	sub    %edi,%eax
80108eb8:	83 ec 04             	sub    $0x4,%esp
80108ebb:	01 c1                	add    %eax,%ecx
80108ebd:	53                   	push   %ebx
80108ebe:	52                   	push   %edx
80108ebf:	51                   	push   %ecx
80108ec0:	e8 4b d0 ff ff       	call   80105f10 <memmove>
    len -= n;
    buf += n;
80108ec5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108ec8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80108ece:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108ed1:	01 da                	add    %ebx,%edx
  while(len > 0){
80108ed3:	29 de                	sub    %ebx,%esi
80108ed5:	74 59                	je     80108f30 <copyout+0xc0>
  if(*pde & PTE_P){
80108ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80108eda:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108edc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80108ede:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108ee1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80108ee7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80108eea:	f6 c1 01             	test   $0x1,%cl
80108eed:	0f 84 4e 00 00 00    	je     80108f41 <copyout.cold>
  return &pgtab[PTX(va)];
80108ef3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108ef5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108efb:	c1 eb 0c             	shr    $0xc,%ebx
80108efe:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80108f04:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80108f0b:	89 d9                	mov    %ebx,%ecx
80108f0d:	83 e1 05             	and    $0x5,%ecx
80108f10:	83 f9 05             	cmp    $0x5,%ecx
80108f13:	0f 84 77 ff ff ff    	je     80108e90 <copyout+0x20>
  }
  return 0;
}
80108f19:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108f1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108f21:	5b                   	pop    %ebx
80108f22:	5e                   	pop    %esi
80108f23:	5f                   	pop    %edi
80108f24:	5d                   	pop    %ebp
80108f25:	c3                   	ret    
80108f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108f2d:	8d 76 00             	lea    0x0(%esi),%esi
80108f30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108f33:	31 c0                	xor    %eax,%eax
}
80108f35:	5b                   	pop    %ebx
80108f36:	5e                   	pop    %esi
80108f37:	5f                   	pop    %edi
80108f38:	5d                   	pop    %ebp
80108f39:	c3                   	ret    

80108f3a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80108f3a:	a1 00 00 00 00       	mov    0x0,%eax
80108f3f:	0f 0b                	ud2    

80108f41 <copyout.cold>:
80108f41:	a1 00 00 00 00       	mov    0x0,%eax
80108f46:	0f 0b                	ud2    
