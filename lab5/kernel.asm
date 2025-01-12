
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
80100015:	b8 00 c0 10 00       	mov    $0x10c000,%eax
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
80100028:	bc 20 b3 11 80       	mov    $0x8011b320,%esp

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
80100044:	bb b4 d5 10 80       	mov    $0x8010d5b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 80 99 10 80       	push   $0x80109980
80100051:	68 80 d5 10 80       	push   $0x8010d580
80100056:	e8 d5 5f 00 00       	call   80106030 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 7c 1c 11 80       	mov    $0x80111c7c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 cc 1c 11 80 7c 	movl   $0x80111c7c,0x80111ccc
8010006a:	1c 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 d0 1c 11 80 7c 	movl   $0x80111c7c,0x80111cd0
80100074:	1c 11 80 
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
8010008b:	c7 43 50 7c 1c 11 80 	movl   $0x80111c7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 99 10 80       	push   $0x80109987
80100097:	50                   	push   %eax
80100098:	e8 63 5e 00 00       	call   80105f00 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 1c 11 80       	mov    0x80111cd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d d0 1c 11 80    	mov    %ebx,0x80111cd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 20 1a 11 80    	cmp    $0x80111a20,%ebx
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
801000df:	68 80 d5 10 80       	push   $0x8010d580
801000e4:	e8 17 61 00 00       	call   80106200 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 1c 11 80    	mov    0x80111cd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 1c 11 80    	cmp    $0x80111c7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 1c 11 80    	cmp    $0x80111c7c,%ebx
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
80100120:	8b 1d cc 1c 11 80    	mov    0x80111ccc,%ebx
80100126:	81 fb 7c 1c 11 80    	cmp    $0x80111c7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 1c 11 80    	cmp    $0x80111c7c,%ebx
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
8010015d:	68 80 d5 10 80       	push   $0x8010d580
80100162:	e8 39 60 00 00       	call   801061a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 5d 00 00       	call   80105f40 <acquiresleep>
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
801001a1:	68 8e 99 10 80       	push   $0x8010998e
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
801001be:	e8 1d 5e 00 00       	call   80105fe0 <holdingsleep>
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
801001dc:	68 9f 99 10 80       	push   $0x8010999f
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
801001ff:	e8 dc 5d 00 00       	call   80105fe0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 8c 5d 00 00       	call   80105fa0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 80 d5 10 80 	movl   $0x8010d580,(%esp)
8010021b:	e8 e0 5f 00 00       	call   80106200 <acquire>
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
80100242:	a1 d0 1c 11 80       	mov    0x80111cd0,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 7c 1c 11 80 	movl   $0x80111c7c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 d0 1c 11 80       	mov    0x80111cd0,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d d0 1c 11 80    	mov    %ebx,0x80111cd0
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 80 d5 10 80 	movl   $0x8010d580,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 2f 5f 00 00       	jmp    801061a0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 a6 99 10 80       	push   $0x801099a6
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
80100349:	c7 04 24 c0 25 11 80 	movl   $0x801125c0,(%esp)
80100350:	e8 ab 5e 00 00       	call   80106200 <acquire>
  while(n > 0){
80100355:	83 c4 10             	add    $0x10,%esp
80100358:	85 db                	test   %ebx,%ebx
8010035a:	0f 8e 9c 00 00 00    	jle    801003fc <consoleread+0xcc>
    while(input.r == input.w){
80100360:	a1 a0 25 11 80       	mov    0x801125a0,%eax
80100365:	3b 05 a4 25 11 80    	cmp    0x801125a4,%eax
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
80100373:	68 c0 25 11 80       	push   $0x801125c0
80100378:	68 a0 25 11 80       	push   $0x801125a0
8010037d:	e8 ee 4f 00 00       	call   80105370 <sleep>
    while(input.r == input.w){
80100382:	a1 a0 25 11 80       	mov    0x801125a0,%eax
80100387:	83 c4 10             	add    $0x10,%esp
8010038a:	3b 05 a4 25 11 80    	cmp    0x801125a4,%eax
80100390:	75 3e                	jne    801003d0 <consoleread+0xa0>
      if(myproc()->killed){
80100392:	e8 e9 43 00 00       	call   80104780 <myproc>
80100397:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010039d:	85 c9                	test   %ecx,%ecx
8010039f:	74 cf                	je     80100370 <consoleread+0x40>
        release(&cons.lock);
801003a1:	83 ec 0c             	sub    $0xc,%esp
801003a4:	68 c0 25 11 80       	push   $0x801125c0
801003a9:	e8 f2 5d 00 00       	call   801061a0 <release>
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
801003d3:	89 15 a0 25 11 80    	mov    %edx,0x801125a0
801003d9:	89 c2                	mov    %eax,%edx
801003db:	83 e2 7f             	and    $0x7f,%edx
801003de:	0f be 8a 20 25 11 80 	movsbl -0x7feedae0(%edx),%ecx
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
801003ff:	68 c0 25 11 80       	push   $0x801125c0
80100404:	e8 97 5d 00 00       	call   801061a0 <release>
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
80100425:	a3 a0 25 11 80       	mov    %eax,0x801125a0
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
8010043d:	a1 a4 25 11 80       	mov    0x801125a4,%eax
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
80100450:	0f b6 9e 20 25 11 80 	movzbl -0x7feedae0(%esi),%ebx
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
801004be:	0f b6 86 1f 25 11 80 	movzbl -0x7feedae1(%esi),%eax
801004c5:	8d 50 d6             	lea    -0x2a(%eax),%edx
801004c8:	80 fa 01             	cmp    $0x1,%dl
801004cb:	76 0f                	jbe    801004dc <read_num.constprop.0+0xac>
801004cd:	83 e0 fd             	and    $0xfffffffd,%eax
801004d0:	3c 2d                	cmp    $0x2d,%al
801004d2:	74 08                	je     801004dc <read_num.constprop.0+0xac>
    else if ((input.buf[i]==45) && (i==(int)input.r))
801004d4:	39 35 a0 25 11 80    	cmp    %esi,0x801125a0
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
801004f9:	c7 05 f4 25 11 80 00 	movl   $0x0,0x801125f4
80100500:	00 00 00 
  getcallerpcs(&s, pcs);
80100503:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100506:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100509:	e8 22 31 00 00       	call   80103630 <lapicid>
8010050e:	83 ec 08             	sub    $0x8,%esp
80100511:	50                   	push   %eax
80100512:	68 ad 99 10 80       	push   $0x801099ad
80100517:	e8 54 05 00 00       	call   80100a70 <cprintf>
  cprintf(s);
8010051c:	58                   	pop    %eax
8010051d:	ff 75 08             	push   0x8(%ebp)
80100520:	e8 4b 05 00 00       	call   80100a70 <cprintf>
  cprintf("\n");
80100525:	c7 04 24 11 a0 10 80 	movl   $0x8010a011,(%esp)
8010052c:	e8 3f 05 00 00       	call   80100a70 <cprintf>
  getcallerpcs(&s, pcs);
80100531:	8d 45 08             	lea    0x8(%ebp),%eax
80100534:	5a                   	pop    %edx
80100535:	59                   	pop    %ecx
80100536:	53                   	push   %ebx
80100537:	50                   	push   %eax
80100538:	e8 13 5b 00 00       	call   80106050 <getcallerpcs>
  for(i=0; i<10; i++)
8010053d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100540:	83 ec 08             	sub    $0x8,%esp
80100543:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100545:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100548:	68 c1 99 10 80       	push   $0x801099c1
8010054d:	e8 1e 05 00 00       	call   80100a70 <cprintf>
  for(i=0; i<10; i++)
80100552:	83 c4 10             	add    $0x10,%esp
80100555:	39 f3                	cmp    %esi,%ebx
80100557:	75 e7                	jne    80100540 <panic+0x50>
  panicked = 1; // freeze other CPU
80100559:	c7 05 fc 25 11 80 01 	movl   $0x1,0x801125fc
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
801005f8:	e8 63 5d 00 00       	call   80106360 <memmove>
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
801005fd:	b8 80 07 00 00       	mov    $0x780,%eax
80100602:	83 c4 0c             	add    $0xc,%esp
80100605:	29 d8                	sub    %ebx,%eax
80100607:	01 c0                	add    %eax,%eax
80100609:	50                   	push   %eax
8010060a:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100611:	6a 00                	push   $0x0
80100613:	50                   	push   %eax
80100614:	e8 a7 5c 00 00       	call   801062c0 <memset>
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
80100650:	8b 15 f8 25 11 80    	mov    0x801125f8,%edx
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
8010067e:	a1 a8 25 11 80       	mov    0x801125a8,%eax
80100683:	8d 70 ff             	lea    -0x1(%eax),%esi
80100686:	0f b6 b8 1f 25 11 80 	movzbl -0x7feedae1(%eax),%edi
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
8010068d:	29 d6                	sub    %edx,%esi
8010068f:	39 c6                	cmp    %eax,%esi
80100691:	73 19                	jae    801006ac <cgaputc+0x13c>
80100693:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100697:	90                   	nop
    input.buf[i] = input.buf[i - 1]; // shift to right all letters in buffer
80100698:	0f b6 90 1f 25 11 80 	movzbl -0x7feedae1(%eax),%edx
8010069f:	83 e8 01             	sub    $0x1,%eax
801006a2:	88 90 21 25 11 80    	mov    %dl,-0x7feedadf(%eax)
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
801006b4:	88 86 20 25 11 80    	mov    %al,-0x7feedae0(%esi)
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
801006d7:	c7 05 f8 25 11 80 00 	movl   $0x0,0x801125f8
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
801006f8:	8b 35 f8 25 11 80    	mov    0x801125f8,%esi
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
8010072c:	8b 15 a8 25 11 80    	mov    0x801125a8,%edx
80100732:	89 d1                	mov    %edx,%ecx
80100734:	29 f1                	sub    %esi,%ecx
80100736:	89 ce                	mov    %ecx,%esi
80100738:	39 ca                	cmp    %ecx,%edx
8010073a:	76 49                	jbe    80100785 <cgaputc+0x215>
8010073c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010073f:	90                   	nop
    input.buf[i] = input.buf[i + 1]; // shift to left all letters in buffer
80100740:	0f b6 86 21 25 11 80 	movzbl -0x7feedadf(%esi),%eax
80100747:	83 c6 01             	add    $0x1,%esi
8010074a:	88 86 1f 25 11 80    	mov    %al,-0x7feedae1(%esi)
  for (int i = input.e - backs; i < input.e; i++ )// jadid
80100750:	39 f2                	cmp    %esi,%edx
80100752:	75 ec                	jne    80100740 <cgaputc+0x1d0>
    saveInp.copybuf[input.e-backs] = '\0';
80100754:	c6 81 80 24 11 80 00 	movb   $0x0,-0x7feedb80(%ecx)
8010075b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010075e:	66 90                	xchg   %ax,%ax
      saveInp.copybuf[i] = saveInp.copybuf[i + 1];
80100760:	0f b6 88 81 24 11 80 	movzbl -0x7feedb7f(%eax),%ecx
80100767:	83 c0 01             	add    $0x1,%eax
8010076a:	88 88 7f 24 11 80    	mov    %cl,-0x7feedb81(%eax)
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
80100785:	c6 81 80 24 11 80 00 	movb   $0x0,-0x7feedb80(%ecx)
    for (int i = input.e - backs; i < input.e; i++ )// jadid
8010078c:	eb e6                	jmp    80100774 <cgaputc+0x204>
    panic("pos under/overflow");
8010078e:	83 ec 0c             	sub    $0xc,%esp
80100791:	68 c5 99 10 80       	push   $0x801099c5
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
801007b4:	c7 04 24 c0 25 11 80 	movl   $0x801125c0,(%esp)
801007bb:	e8 40 5a 00 00       	call   80106200 <acquire>
  for(i = 0; i < n; i++)
801007c0:	83 c4 10             	add    $0x10,%esp
801007c3:	85 f6                	test   %esi,%esi
801007c5:	7e 37                	jle    801007fe <consolewrite+0x5e>
801007c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801007ca:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801007cd:	8b 15 fc 25 11 80    	mov    0x801125fc,%edx
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
801007ea:	e8 a1 78 00 00       	call   80108090 <uartputc>
  cgaputc(c);
801007ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007f2:	e8 79 fd ff ff       	call   80100570 <cgaputc>
  for(i = 0; i < n; i++)
801007f7:	83 c4 10             	add    $0x10,%esp
801007fa:	39 df                	cmp    %ebx,%edi
801007fc:	75 cf                	jne    801007cd <consolewrite+0x2d>
  release(&cons.lock);
801007fe:	83 ec 0c             	sub    $0xc,%esp
80100801:	68 c0 25 11 80       	push   $0x801125c0
80100806:	e8 95 59 00 00       	call   801061a0 <release>
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
80100856:	0f b6 92 38 9a 10 80 	movzbl -0x7fef65c8(%edx),%edx
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
8010087f:	a1 fc 25 11 80       	mov    0x801125fc,%eax
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
80100897:	e8 f4 77 00 00       	call   80108090 <uartputc>
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
801008dc:	a1 f8 25 11 80       	mov    0x801125f8,%eax
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
80100940:	c7 05 f8 25 11 80 00 	movl   $0x0,0x801125f8
80100947:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
8010094a:	8b 1d a8 25 11 80    	mov    0x801125a8,%ebx
80100950:	3b 1d a4 25 11 80    	cmp    0x801125a4,%ebx
80100956:	76 57                	jbe    801009af <handle_up_down_arrow+0xdf>
    if (input.buf[i - 1] != '\n'){
80100958:	83 eb 01             	sub    $0x1,%ebx
8010095b:	80 bb 20 25 11 80 0a 	cmpb   $0xa,-0x7feedae0(%ebx)
80100962:	74 43                	je     801009a7 <handle_up_down_arrow+0xd7>
  if(panicked){
80100964:	8b 0d fc 25 11 80    	mov    0x801125fc,%ecx
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
8010097d:	e8 0e 77 00 00       	call   80108090 <uartputc>
80100982:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100989:	e8 02 77 00 00       	call   80108090 <uartputc>
8010098e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100995:	e8 f6 76 00 00       	call   80108090 <uartputc>
  cgaputc(c);
8010099a:	b8 00 01 00 00       	mov    $0x100,%eax
8010099f:	e8 cc fb ff ff       	call   80100570 <cgaputc>
}
801009a4:	83 c4 10             	add    $0x10,%esp
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
801009a7:	39 1d a4 25 11 80    	cmp    %ebx,0x801125a4
801009ad:	72 a9                	jb     80100958 <handle_up_down_arrow+0x88>
  if ((arrow == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
801009af:	83 7d e0 03          	cmpl   $0x3,-0x20(%ebp)
801009b3:	a1 58 24 11 80       	mov    0x80112458,%eax
801009b8:	75 10                	jne    801009ca <handle_up_down_arrow+0xfa>
801009ba:	83 f8 08             	cmp    $0x8,%eax
801009bd:	7f 0b                	jg     801009ca <handle_up_down_arrow+0xfa>
801009bf:	8d 50 01             	lea    0x1(%eax),%edx
801009c2:	3b 15 5c 24 11 80    	cmp    0x8011245c,%edx
801009c8:	7c 7f                	jl     80100a49 <handle_up_down_arrow+0x179>
    input = history.instructions[history.index--];
801009ca:	8d 50 ff             	lea    -0x1(%eax),%edx
801009cd:	69 c0 8c 00 00 00    	imul   $0x8c,%eax,%eax
801009d3:	89 15 58 24 11 80    	mov    %edx,0x80112458
801009d9:	8d b0 e0 1e 11 80    	lea    -0x7feee120(%eax),%esi
801009df:	b8 20 25 11 80       	mov    $0x80112520,%eax
801009e4:	b9 23 00 00 00       	mov    $0x23,%ecx
801009e9:	89 c7                	mov    %eax,%edi
801009eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.buf[--input.e] = '\0';
801009ed:	8b 15 a8 25 11 80    	mov    0x801125a8,%edx
801009f3:	8d 42 ff             	lea    -0x1(%edx),%eax
801009f6:	a3 a8 25 11 80       	mov    %eax,0x801125a8
801009fb:	c6 82 1f 25 11 80 00 	movb   $0x0,-0x7feedae1(%edx)
  for (int i = input.w ; i < input.e; i++)
80100a02:	8b 1d a4 25 11 80    	mov    0x801125a4,%ebx
80100a08:	39 c3                	cmp    %eax,%ebx
80100a0a:	73 35                	jae    80100a41 <handle_up_down_arrow+0x171>
  if(panicked){
80100a0c:	8b 15 fc 25 11 80    	mov    0x801125fc,%edx
    consputc(input.buf[i]);
80100a12:	0f b6 83 20 25 11 80 	movzbl -0x7feedae0(%ebx),%eax
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
80100a2a:	e8 61 76 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80100a2f:	89 f0                	mov    %esi,%eax
80100a31:	e8 3a fb ff ff       	call   80100570 <cgaputc>
  for (int i = input.w ; i < input.e; i++)
80100a36:	83 c4 10             	add    $0x10,%esp
80100a39:	39 1d a8 25 11 80    	cmp    %ebx,0x801125a8
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
80100a4c:	89 15 58 24 11 80    	mov    %edx,0x80112458
    input = history.instructions[history.index + 1 ];
80100a52:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
80100a58:	81 c6 e0 1e 11 80    	add    $0x80111ee0,%esi
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
80100a79:	a1 f4 25 11 80       	mov    0x801125f4,%eax
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
80100b25:	bf d8 99 10 80       	mov    $0x801099d8,%edi
      for(; *s; s++)
80100b2a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100b2d:	b8 28 00 00 00       	mov    $0x28,%eax
80100b32:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100b34:	8b 15 fc 25 11 80    	mov    0x801125fc,%edx
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
80100b80:	8b 0d fc 25 11 80    	mov    0x801125fc,%ecx
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
80100b9a:	e8 f1 74 00 00       	call   80108090 <uartputc>
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
80100bc3:	68 c0 25 11 80       	push   $0x801125c0
80100bc8:	e8 33 56 00 00       	call   80106200 <acquire>
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	e9 b4 fe ff ff       	jmp    80100a89 <cprintf+0x19>
  if(panicked){
80100bd5:	8b 0d fc 25 11 80    	mov    0x801125fc,%ecx
80100bdb:	85 c9                	test   %ecx,%ecx
80100bdd:	75 71                	jne    80100c50 <cprintf+0x1e0>
    uartputc(c);
80100bdf:	83 ec 0c             	sub    $0xc,%esp
80100be2:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100be5:	6a 25                	push   $0x25
80100be7:	e8 a4 74 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80100bec:	b8 25 00 00 00       	mov    $0x25,%eax
80100bf1:	e8 7a f9 ff ff       	call   80100570 <cgaputc>
  if(panicked){
80100bf6:	8b 15 fc 25 11 80    	mov    0x801125fc,%edx
80100bfc:	83 c4 10             	add    $0x10,%esp
80100bff:	85 d2                	test   %edx,%edx
80100c01:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100c04:	0f 84 8e 00 00 00    	je     80100c98 <cprintf+0x228>
80100c0a:	fa                   	cli    
    for(;;)
80100c0b:	eb fe                	jmp    80100c0b <cprintf+0x19b>
80100c0d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100c10:	a1 fc 25 11 80       	mov    0x801125fc,%eax
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
80100c28:	e8 63 74 00 00       	call   80108090 <uartputc>
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
80100c73:	e8 18 74 00 00       	call   80108090 <uartputc>
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
80100c9f:	e8 ec 73 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80100ca4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca7:	e8 c4 f8 ff ff       	call   80100570 <cgaputc>
}
80100cac:	83 c4 10             	add    $0x10,%esp
80100caf:	e9 37 fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    release(&cons.lock);
80100cb4:	83 ec 0c             	sub    $0xc,%esp
80100cb7:	68 c0 25 11 80       	push   $0x801125c0
80100cbc:	e8 df 54 00 00       	call   801061a0 <release>
80100cc1:	83 c4 10             	add    $0x10,%esp
}
80100cc4:	e9 38 fe ff ff       	jmp    80100b01 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100cc9:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100ccc:	e9 1a fe ff ff       	jmp    80100aeb <cprintf+0x7b>
    panic("null fmt");
80100cd1:	83 ec 0c             	sub    $0xc,%esp
80100cd4:	68 df 99 10 80       	push   $0x801099df
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
80100cea:	39 1d a8 25 11 80    	cmp    %ebx,0x801125a8
80100cf0:	76 48                	jbe    80100d3a <delete_letters+0x5a>
  if(panicked){
80100cf2:	a1 fc 25 11 80       	mov    0x801125fc,%eax
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
80100d08:	e8 83 73 00 00       	call   80108090 <uartputc>
80100d0d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100d14:	e8 77 73 00 00       	call   80108090 <uartputc>
80100d19:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100d20:	e8 6b 73 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80100d25:	b8 00 01 00 00       	mov    $0x100,%eax
80100d2a:	e8 41 f8 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80100d2f:	83 c4 10             	add    $0x10,%esp
80100d32:	39 1d a8 25 11 80    	cmp    %ebx,0x801125a8
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
80100d4f:	68 c0 25 11 80       	push   $0x801125c0
{
80100d54:	89 85 d0 fd ff ff    	mov    %eax,-0x230(%ebp)
  acquire(&cons.lock);
80100d5a:	e8 a1 54 00 00       	call   80106200 <acquire>
  char *buf_value = &input.buf[input.w];
80100d5f:	a1 a4 25 11 80       	mov    0x801125a4,%eax
  while((c = getc()) >= 0){
80100d64:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100d67:	c7 85 cc fd ff ff 00 	movl   $0x0,-0x234(%ebp)
80100d6e:	00 00 00 
  char *buf_value = &input.buf[input.w];
80100d71:	89 85 c8 fd ff ff    	mov    %eax,-0x238(%ebp)
80100d77:	05 20 25 11 80       	add    $0x80112520,%eax
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
80100dab:	ff 24 85 f8 99 10 80 	jmp    *-0x7fef6608(,%eax,4)
80100db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100db8:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100dbe:	0f 84 dc 03 00 00    	je     801011a0 <consoleintr+0x460>
80100dc4:	0f 8e c6 00 00 00    	jle    80100e90 <consoleintr+0x150>
80100dca:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100dd0:	0f 84 a2 04 00 00    	je     80101278 <consoleintr+0x538>
80100dd6:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100ddc:	0f 85 fe 00 00 00    	jne    80100ee0 <consoleintr+0x1a0>
      if (backs > 0) // ensure back value stays positive
80100de2:	8b 1d f8 25 11 80    	mov    0x801125f8,%ebx
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
80100e44:	89 1d f8 25 11 80    	mov    %ebx,0x801125f8
  while((c = getc()) >= 0){
80100e4a:	ff d0                	call   *%eax
80100e4c:	89 c3                	mov    %eax,%ebx
80100e4e:	85 c0                	test   %eax,%eax
80100e50:	0f 89 3e ff ff ff    	jns    80100d94 <consoleintr+0x54>
80100e56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e5d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
80100e63:	68 c0 25 11 80       	push   $0x801125c0
80100e68:	e8 33 53 00 00       	call   801061a0 <release>
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
80100ea1:	a1 60 24 11 80       	mov    0x80112460,%eax
80100ea6:	85 c0                	test   %eax,%eax
80100ea8:	0f 84 d4 fe ff ff    	je     80100d82 <consoleintr+0x42>
80100eae:	8b 15 5c 24 11 80    	mov    0x8011245c,%edx
80100eb4:	2b 15 58 24 11 80    	sub    0x80112458,%edx
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
80100ee0:	a1 a8 25 11 80       	mov    0x801125a8,%eax
80100ee5:	89 c2                	mov    %eax,%edx
80100ee7:	2b 15 a0 25 11 80    	sub    0x801125a0,%edx
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
80100f07:	83 3d 08 25 11 80 01 	cmpl   $0x1,0x80112508
80100f0e:	0f 84 b9 04 00 00    	je     801013cd <consoleintr+0x68d>
  if(panicked){
80100f14:	8b 35 fc 25 11 80    	mov    0x801125fc,%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100f1a:	8d 48 01             	lea    0x1(%eax),%ecx
80100f1d:	83 e0 7f             	and    $0x7f,%eax
80100f20:	89 0d a8 25 11 80    	mov    %ecx,0x801125a8
80100f26:	88 90 20 25 11 80    	mov    %dl,-0x7feedae0(%eax)
  if(panicked){
80100f2c:	85 f6                	test   %esi,%esi
80100f2e:	0f 85 4c 04 00 00    	jne    80101380 <consoleintr+0x640>
  if(c == BACKSPACE){
80100f34:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100f3a:	0f 84 10 05 00 00    	je     80101450 <consoleintr+0x710>
    uartputc(c);
80100f40:	83 ec 0c             	sub    $0xc,%esp
80100f43:	53                   	push   %ebx
80100f44:	e8 47 71 00 00       	call   80108090 <uartputc>
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
80100f67:	0f b6 80 20 25 11 80 	movzbl -0x7feedae0(%eax),%eax
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
80100f9f:	0f b6 8a e8 99 10 80 	movzbl -0x7fef6618(%edx),%ecx
80100fa6:	38 c8                	cmp    %cl,%al
80100fa8:	74 de                	je     80100f88 <consoleintr+0x248>
            if (history.count < 9){
80100faa:	8b 1d 60 24 11 80    	mov    0x80112460,%ebx
80100fb0:	83 fb 08             	cmp    $0x8,%ebx
80100fb3:	0f 8f 43 05 00 00    	jg     801014fc <consoleintr+0x7bc>
            history.instructions[history.last + 1] = input;
80100fb9:	a1 5c 24 11 80       	mov    0x8011245c,%eax
80100fbe:	be 20 25 11 80       	mov    $0x80112520,%esi
80100fc3:	b9 23 00 00 00       	mov    $0x23,%ecx
            history.count ++ ;
80100fc8:	83 c3 01             	add    $0x1,%ebx
80100fcb:	89 1d 60 24 11 80    	mov    %ebx,0x80112460
            history.instructions[history.last + 1] = input;
80100fd1:	8d 50 01             	lea    0x1(%eax),%edx
80100fd4:	69 c2 8c 00 00 00    	imul   $0x8c,%edx,%eax
            history.last ++ ;
80100fda:	89 15 5c 24 11 80    	mov    %edx,0x8011245c
            history.index = history.last;
80100fe0:	89 15 58 24 11 80    	mov    %edx,0x80112458
            history.instructions[history.last + 1] = input;
80100fe6:	05 e0 1e 11 80       	add    $0x80111ee0,%eax
80100feb:	89 c7                	mov    %eax,%edi
80100fed:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
          wakeup(&input.r);
80100fef:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ff2:	a1 a8 25 11 80       	mov    0x801125a8,%eax
          backs = 0;
80100ff7:	c7 05 f8 25 11 80 00 	movl   $0x0,0x801125f8
80100ffe:	00 00 00 
          wakeup(&input.r);
80101001:	68 a0 25 11 80       	push   $0x801125a0
          input.w = input.e;
80101006:	a3 a4 25 11 80       	mov    %eax,0x801125a4
          wakeup(&input.r);
8010100b:	e8 30 44 00 00       	call   80105440 <wakeup>
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
80101030:	a1 a8 25 11 80       	mov    0x801125a8,%eax
80101035:	3b 05 a4 25 11 80    	cmp    0x801125a4,%eax
8010103b:	0f 84 41 fd ff ff    	je     80100d82 <consoleintr+0x42>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101041:	83 e8 01             	sub    $0x1,%eax
80101044:	89 c2                	mov    %eax,%edx
80101046:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80101049:	80 ba 20 25 11 80 0a 	cmpb   $0xa,-0x7feedae0(%edx)
80101050:	0f 84 2c fd ff ff    	je     80100d82 <consoleintr+0x42>
  if(panicked){
80101056:	8b 35 fc 25 11 80    	mov    0x801125fc,%esi
        input.e--;
8010105c:	a3 a8 25 11 80       	mov    %eax,0x801125a8
  if(panicked){
80101061:	85 f6                	test   %esi,%esi
80101063:	0f 84 85 02 00 00    	je     801012ee <consoleintr+0x5ae>
  asm volatile("cli");
80101069:	fa                   	cli    
    for(;;)
8010106a:	eb fe                	jmp    8010106a <consoleintr+0x32a>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((input.e - backs )> input.w){
80101070:	a1 a8 25 11 80       	mov    0x801125a8,%eax
80101075:	89 c2                	mov    %eax,%edx
80101077:	2b 15 f8 25 11 80    	sub    0x801125f8,%edx
8010107d:	3b 15 a4 25 11 80    	cmp    0x801125a4,%edx
80101083:	0f 86 f9 fc ff ff    	jbe    80100d82 <consoleintr+0x42>
  if(panicked){
80101089:	8b 1d fc 25 11 80    	mov    0x801125fc,%ebx
        input.e--;
8010108f:	83 e8 01             	sub    $0x1,%eax
80101092:	a3 a8 25 11 80       	mov    %eax,0x801125a8
  if(panicked){
80101097:	85 db                	test   %ebx,%ebx
80101099:	0f 84 ad 02 00 00    	je     8010134c <consoleintr+0x60c>
8010109f:	fa                   	cli    
    for(;;)
801010a0:	eb fe                	jmp    801010a0 <consoleintr+0x360>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(saveInp.active == 1)
801010a8:	83 3d 08 25 11 80 01 	cmpl   $0x1,0x80112508
801010af:	0f 85 cd fc ff ff    	jne    80100d82 <consoleintr+0x42>
      saveInp.end = input.e-backs;
801010b5:	8b 35 a8 25 11 80    	mov    0x801125a8,%esi
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010bb:	8b 15 00 25 11 80    	mov    0x80112500,%edx
      int count = 0;
801010c1:	31 db                	xor    %ebx,%ebx
      saveInp.end = input.e-backs;
801010c3:	89 f1                	mov    %esi,%ecx
801010c5:	2b 0d f8 25 11 80    	sub    0x801125f8,%ecx
      for (int j = input.e; j >= saveInp.end; j--){// jadid
801010cb:	89 f0                	mov    %esi,%eax
      saveInp.end = input.e-backs;
801010cd:	89 0d 04 25 11 80    	mov    %ecx,0x80112504
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
801010d3:	83 fa 7f             	cmp    $0x7f,%edx
801010d6:	0f 8f ac 02 00 00    	jg     80101388 <consoleintr+0x648>
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (saveInp.copybuf[i] != '\0'){
801010e0:	80 ba 80 24 11 80 00 	cmpb   $0x0,-0x7feedb80(%edx)
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
80101108:	0f b6 90 20 25 11 80 	movzbl -0x7feedae0(%eax),%edx
8010110f:	88 94 03 20 25 11 80 	mov    %dl,-0x7feedae0(%ebx,%eax,1)
      for (int j = input.e; j >= saveInp.end; j--){// jadid
80101116:	83 e8 01             	sub    $0x1,%eax
80101119:	39 c1                	cmp    %eax,%ecx
8010111b:	7e eb                	jle    80101108 <consoleintr+0x3c8>
      input.e = input.e + count;
8010111d:	89 35 a8 25 11 80    	mov    %esi,0x801125a8
      for (int i=0; i<count ; i++)
80101123:	85 db                	test   %ebx,%ebx
80101125:	0f 84 57 fc ff ff    	je     80100d82 <consoleintr+0x42>
8010112b:	31 f6                	xor    %esi,%esi
8010112d:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
80101133:	89 da                	mov    %ebx,%edx
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
80101135:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80101138:	0f be 98 80 24 11 80 	movsbl -0x7feedb80(%eax),%ebx
8010113f:	88 9c 31 20 25 11 80 	mov    %bl,-0x7feedae0(%ecx,%esi,1)
  if(panicked){
80101146:	8b 0d fc 25 11 80    	mov    0x801125fc,%ecx
8010114c:	85 c9                	test   %ecx,%ecx
8010114e:	0f 84 44 02 00 00    	je     80101398 <consoleintr+0x658>
80101154:	fa                   	cli    
    for(;;)
80101155:	eb fe                	jmp    80101155 <consoleintr+0x415>
80101157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010115e:	66 90                	xchg   %ax,%ax
      saveInp.active = 1;
80101160:	c7 05 08 25 11 80 01 	movl   $0x1,0x80112508
80101167:	00 00 00 
      saveInp.start = input.e-backs;
8010116a:	a1 a8 25 11 80       	mov    0x801125a8,%eax
8010116f:	2b 05 f8 25 11 80    	sub    0x801125f8,%eax
80101175:	a3 00 25 11 80       	mov    %eax,0x80112500
      for (int i = 0; i < 128; i++)
8010117a:	31 c0                	xor    %eax,%eax
8010117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        saveInp.copybuf[i] = '\0';
80101180:	c6 80 80 24 11 80 00 	movb   $0x0,-0x7feedb80(%eax)
      for (int i = 0; i < 128; i++)
80101187:	83 c0 01             	add    $0x1,%eax
8010118a:	3d 80 00 00 00       	cmp    $0x80,%eax
8010118f:	75 ef                	jne    80101180 <consoleintr+0x440>
80101191:	e9 ec fb ff ff       	jmp    80100d82 <consoleintr+0x42>
80101196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
      if ((history.count != 0 ) && (history.last - history.index  - 1 > 0))
801011a0:	a1 60 24 11 80       	mov    0x80112460,%eax
801011a5:	85 c0                	test   %eax,%eax
801011a7:	0f 84 d5 fb ff ff    	je     80100d82 <consoleintr+0x42>
801011ad:	a1 5c 24 11 80       	mov    0x8011245c,%eax
801011b2:	2b 05 58 24 11 80    	sub    0x80112458,%eax
801011b8:	83 f8 01             	cmp    $0x1,%eax
801011bb:	0f 8e c1 fb ff ff    	jle    80100d82 <consoleintr+0x42>
        handle_up_down_arrow(DOWN);
801011c1:	b8 03 00 00 00       	mov    $0x3,%eax
801011c6:	e8 05 f7 ff ff       	call   801008d0 <handle_up_down_arrow>
801011cb:	e9 b2 fb ff ff       	jmp    80100d82 <consoleintr+0x42>
  if(panicked){
801011d0:	a1 fc 25 11 80       	mov    0x801125fc,%eax
801011d5:	85 c0                	test   %eax,%eax
801011d7:	0f 85 5b 01 00 00    	jne    80101338 <consoleintr+0x5f8>
    uartputc(c);
801011dd:	83 ec 0c             	sub    $0xc,%esp
801011e0:	6a 3f                	push   $0x3f
801011e2:	e8 a9 6e 00 00       	call   80108090 <uartputc>
  cgaputc(c);
801011e7:	b8 3f 00 00 00       	mov    $0x3f,%eax
801011ec:	e8 7f f3 ff ff       	call   80100570 <cgaputc>
  if(input.buf[input.e-1] == 61)
801011f1:	8b 3d a8 25 11 80    	mov    0x801125a8,%edi
801011f7:	83 c4 10             	add    $0x10,%esp
801011fa:	80 bf 1f 25 11 80 3d 	cmpb   $0x3d,-0x7feedae1(%edi)
80101201:	0f 85 7b fb ff ff    	jne    80100d82 <consoleintr+0x42>
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
80101207:	0f b6 87 1e 25 11 80 	movzbl -0x7feedae2(%edi),%eax
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
80101265:	a1 fc 25 11 80       	mov    0x801125fc,%eax
8010126a:	85 c0                	test   %eax,%eax
8010126c:	0f 84 80 01 00 00    	je     801013f2 <consoleintr+0x6b2>
80101272:	fa                   	cli    
    for(;;)
80101273:	eb fe                	jmp    80101273 <consoleintr+0x533>
80101275:	8d 76 00             	lea    0x0(%esi),%esi
      if ((input.e - backs) > input.w) //ensure cursor position stays in valid bounds
80101278:	8b 0d f8 25 11 80    	mov    0x801125f8,%ecx
8010127e:	a1 a8 25 11 80       	mov    0x801125a8,%eax
80101283:	29 c8                	sub    %ecx,%eax
80101285:	3b 05 a4 25 11 80    	cmp    0x801125a4,%eax
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
801012e3:	89 0d f8 25 11 80    	mov    %ecx,0x801125f8
801012e9:	e9 94 fa ff ff       	jmp    80100d82 <consoleintr+0x42>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	6a 08                	push   $0x8
801012f3:	e8 98 6d 00 00       	call   80108090 <uartputc>
801012f8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801012ff:	e8 8c 6d 00 00       	call   80108090 <uartputc>
80101304:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010130b:	e8 80 6d 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80101310:	b8 00 01 00 00       	mov    $0x100,%eax
80101315:	e8 56 f2 ff ff       	call   80100570 <cgaputc>
      while(input.e != input.w &&
8010131a:	a1 a8 25 11 80       	mov    0x801125a8,%eax
8010131f:	83 c4 10             	add    $0x10,%esp
80101322:	3b 05 a4 25 11 80    	cmp    0x801125a4,%eax
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
80101347:	e9 d4 41 00 00       	jmp    80105520 <procdump>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	6a 08                	push   $0x8
80101351:	e8 3a 6d 00 00       	call   80108090 <uartputc>
80101356:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010135d:	e8 2e 6d 00 00       	call   80108090 <uartputc>
80101362:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101369:	e8 22 6d 00 00       	call   80108090 <uartputc>
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
801013a5:	e8 e6 6c 00 00       	call   80108090 <uartputc>
  cgaputc(c);
801013aa:	89 d8                	mov    %ebx,%eax
801013ac:	e8 bf f1 ff ff       	call   80100570 <cgaputc>
      for (int i=0; i<count ; i++)
801013b1:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
801013b7:	83 c4 10             	add    $0x10,%esp
801013ba:	39 d6                	cmp    %edx,%esi
801013bc:	0f 84 c0 f9 ff ff    	je     80100d82 <consoleintr+0x42>
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
801013c2:	8b 0d 04 25 11 80    	mov    0x80112504,%ecx
801013c8:	e9 68 fd ff ff       	jmp    80101135 <consoleintr+0x3f5>
          if (saveInp.copybuf[(input.e-backs)%INPUT_BUF] == '\0')
801013cd:	89 c7                	mov    %eax,%edi
801013cf:	2b 3d f8 25 11 80    	sub    0x801125f8,%edi
801013d5:	89 fe                	mov    %edi,%esi
801013d7:	83 e6 7f             	and    $0x7f,%esi
801013da:	80 be 80 24 11 80 00 	cmpb   $0x0,-0x7feedb80(%esi)
801013e1:	0f 85 6a 01 00 00    	jne    80101551 <consoleintr+0x811>
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
801013e7:	88 96 80 24 11 80    	mov    %dl,-0x7feedb80(%esi)
801013ed:	e9 22 fb ff ff       	jmp    80100f14 <consoleintr+0x1d4>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f2:	83 ec 0c             	sub    $0xc,%esp
  for(int i=end_index; i<input.e ; i++)
801013f5:	83 c7 01             	add    $0x1,%edi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801013f8:	6a 08                	push   $0x8
801013fa:	e8 91 6c 00 00       	call   80108090 <uartputc>
801013ff:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101406:	e8 85 6c 00 00       	call   80108090 <uartputc>
8010140b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101412:	e8 79 6c 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80101417:	b8 00 01 00 00       	mov    $0x100,%eax
8010141c:	e8 4f f1 ff ff       	call   80100570 <cgaputc>
  for(int i=end_index; i<input.e ; i++)
80101421:	83 c4 10             	add    $0x10,%esp
80101424:	3b 3d a8 25 11 80    	cmp    0x801125a8,%edi
8010142a:	0f 82 35 fe ff ff    	jb     80101265 <consoleintr+0x525>
  if(panicked){
80101430:	a1 fc 25 11 80       	mov    0x801125fc,%eax
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
80101455:	e8 36 6c 00 00       	call   80108090 <uartputc>
8010145a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101461:	e8 2a 6c 00 00       	call   80108090 <uartputc>
80101466:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010146d:	e8 1e 6c 00 00       	call   80108090 <uartputc>
  cgaputc(c);
80101472:	b8 00 01 00 00       	mov    $0x100,%eax
80101477:	e8 f4 f0 ff ff       	call   80100570 <cgaputc>
8010147c:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
8010147f:	a1 a0 25 11 80       	mov    0x801125a0,%eax
80101484:	83 e8 80             	sub    $0xffffff80,%eax
80101487:	39 05 a8 25 11 80    	cmp    %eax,0x801125a8
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
801014a6:	68 c0 25 11 80       	push   $0x801125c0
801014ab:	e8 f0 4c 00 00       	call   801061a0 <release>
            for(int i=0 ; i<history.count+1 ; i++)
801014b0:	8b 15 60 24 11 80    	mov    0x80112460,%edx
801014b6:	83 c4 10             	add    $0x10,%esp
801014b9:	85 d2                	test   %edx,%edx
801014bb:	78 2a                	js     801014e7 <consoleintr+0x7a7>
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014bd:	8b 83 64 1f 11 80    	mov    -0x7feee09c(%ebx),%eax
801014c3:	83 ec 0c             	sub    $0xc,%esp
            for(int i=0 ; i<history.count+1 ; i++)
801014c6:	83 c6 01             	add    $0x1,%esi
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014c9:	01 d8                	add    %ebx,%eax
            for(int i=0 ; i<history.count+1 ; i++)
801014cb:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
801014d1:	05 e0 1e 11 80       	add    $0x80111ee0,%eax
801014d6:	50                   	push   %eax
801014d7:	e8 94 f5 ff ff       	call   80100a70 <cprintf>
            for(int i=0 ; i<history.count+1 ; i++)
801014dc:	83 c4 10             	add    $0x10,%esp
801014df:	39 35 60 24 11 80    	cmp    %esi,0x80112460
801014e5:	7d d6                	jge    801014bd <consoleintr+0x77d>
            acquire(&cons.lock);
801014e7:	83 ec 0c             	sub    $0xc,%esp
801014ea:	68 c0 25 11 80       	push   $0x801125c0
801014ef:	e8 0c 4d 00 00       	call   80106200 <acquire>
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	e9 f3 fa ff ff       	jmp    80100fef <consoleintr+0x2af>
801014fc:	ba cc 23 11 80       	mov    $0x801123cc,%edx
80101501:	b8 e0 1e 11 80       	mov    $0x80111ee0,%eax
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
80101520:	be 20 25 11 80       	mov    $0x80112520,%esi
80101525:	b9 23 00 00 00       	mov    $0x23,%ecx
8010152a:	89 d7                	mov    %edx,%edi
              history.index = 9;
8010152c:	c7 05 58 24 11 80 09 	movl   $0x9,0x80112458
80101533:	00 00 00 
              history.instructions[9] = input;
80101536:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
              history.last = 9;
80101538:	c7 05 5c 24 11 80 09 	movl   $0x9,0x8011245c
8010153f:	00 00 00 
              history.count = 10;
80101542:	c7 05 60 24 11 80 0a 	movl   $0xa,0x80112460
80101549:	00 00 00 
8010154c:	e9 9e fa ff ff       	jmp    80100fef <consoleintr+0x2af>
            for (int i = input.e; i > input.e - backs; i--)
80101551:	89 c1                	mov    %eax,%ecx
80101553:	39 f8                	cmp    %edi,%eax
80101555:	0f 86 8c fe ff ff    	jbe    801013e7 <consoleintr+0x6a7>
8010155b:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
              saveInp.copybuf[i] = saveInp.copybuf[i - 1]; // shift to right all letters in buffer
80101561:	0f b6 81 7f 24 11 80 	movzbl -0x7feedb81(%ecx),%eax
80101568:	83 e9 01             	sub    $0x1,%ecx
8010156b:	88 81 81 24 11 80    	mov    %al,-0x7feedb7f(%ecx)
            for (int i = input.e; i > input.e - backs; i--)
80101571:	39 cf                	cmp    %ecx,%edi
80101573:	72 ec                	jb     80101561 <consoleintr+0x821>
80101575:	8b 85 c0 fd ff ff    	mov    -0x240(%ebp),%eax
8010157b:	e9 67 fe ff ff       	jmp    801013e7 <consoleintr+0x6a7>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101580:	83 ec 0c             	sub    $0xc,%esp
80101583:	6a 08                	push   $0x8
80101585:	e8 06 6b 00 00       	call   80108090 <uartputc>
8010158a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101591:	e8 fa 6a 00 00       	call   80108090 <uartputc>
80101596:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010159d:	e8 ee 6a 00 00       	call   80108090 <uartputc>
  cgaputc(c);
801015a2:	b8 00 01 00 00       	mov    $0x100,%eax
801015a7:	e8 c4 ef ff ff       	call   80100570 <cgaputc>
    switch (input.buf[first_num_index-1])
801015ac:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
801015b2:	83 c4 10             	add    $0x10,%esp
801015b5:	0f b6 80 1f 25 11 80 	movzbl -0x7feedae1(%eax),%eax
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
801015f1:	68 c0 25 11 80       	push   $0x801125c0
801015f6:	e8 a5 4b 00 00       	call   801061a0 <release>
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
80101622:	88 98 20 25 11 80    	mov    %bl,-0x7feedae0(%eax)
    i++;
80101628:	83 c0 01             	add    $0x1,%eax
  while (new_string[j]!='\0')
8010162b:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
8010162f:	84 db                	test   %bl,%bl
80101631:	75 ec                	jne    8010161f <consoleintr+0x8df>
80101633:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
80101639:	eb 0a                	jmp    80101645 <consoleintr+0x905>
    input.buf[i] = '\0';
8010163b:	c6 80 20 25 11 80 00 	movb   $0x0,-0x7feedae0(%eax)
    i++;
80101642:	83 c0 01             	add    $0x1,%eax
  while (input.buf[i]!='\0')
80101645:	80 b8 20 25 11 80 00 	cmpb   $0x0,-0x7feedae0(%eax)
8010164c:	75 ed                	jne    8010163b <consoleintr+0x8fb>
    acquire(&cons.lock);
8010164e:	83 ec 0c             	sub    $0xc,%esp
  input.e = update_index+j;
80101651:	03 8d c0 fd ff ff    	add    -0x240(%ebp),%ecx
    acquire(&cons.lock);
80101657:	68 c0 25 11 80       	push   $0x801125c0
  input.e = update_index+j;
8010165c:	89 0d a8 25 11 80    	mov    %ecx,0x801125a8
    acquire(&cons.lock);
80101662:	e8 99 4b 00 00       	call   80106200 <acquire>
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
801016c8:	d8 0d 4c 9a 10 80    	fmuls  0x80109a4c
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
80101786:	68 f0 99 10 80       	push   $0x801099f0
8010178b:	68 c0 25 11 80       	push   $0x801125c0
80101790:	e8 9b 48 00 00       	call   80106030 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101795:	58                   	pop    %eax
80101796:	5a                   	pop    %edx
80101797:	6a 00                	push   $0x0
80101799:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010179b:	c7 05 ac 2f 11 80 a0 	movl   $0x801007a0,0x80112fac
801017a2:	07 10 80 
  devsw[CONSOLE].read = consoleread;
801017a5:	c7 05 a8 2f 11 80 30 	movl   $0x80100330,0x80112fa8
801017ac:	03 10 80 
  cons.locking = 1;
801017af:	c7 05 f4 25 11 80 01 	movl   $0x1,0x801125f4
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
801017dc:	e8 9f 2f 00 00       	call   80104780 <myproc>
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
80101854:	e8 57 7a 00 00       	call   801092b0 <setupkvm>
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
801018c3:	e8 08 78 00 00       	call   801090d0 <allocuvm>
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
801018f9:	e8 e2 76 00 00       	call   80108fe0 <loaduvm>
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
8010193b:	e8 f0 78 00 00       	call   80109230 <freevm>
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
80101982:	e8 49 77 00 00       	call   801090d0 <allocuvm>
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
801019a3:	e8 a8 79 00 00       	call   80109350 <clearpteu>
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
801019f3:	e8 c8 4a 00 00       	call   801064c0 <strlen>
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
80101a07:	e8 b4 4a 00 00       	call   801064c0 <strlen>
80101a0c:	83 c0 01             	add    $0x1,%eax
80101a0f:	50                   	push   %eax
80101a10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a13:	ff 34 b8             	push   (%eax,%edi,4)
80101a16:	53                   	push   %ebx
80101a17:	56                   	push   %esi
80101a18:	e8 03 7b 00 00       	call   80109520 <copyout>
80101a1d:	83 c4 20             	add    $0x20,%esp
80101a20:	85 c0                	test   %eax,%eax
80101a22:	79 ac                	jns    801019d0 <exec+0x200>
80101a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101a31:	e8 fa 77 00 00       	call   80109230 <freevm>
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
80101a83:	e8 98 7a 00 00       	call   80109520 <copyout>
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
80101ac3:	e8 b8 49 00 00       	call   80106480 <safestrcpy>
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
80101af6:	e8 55 73 00 00       	call   80108e50 <switchuvm>
  freevm(oldpgdir);
80101afb:	89 3c 24             	mov    %edi,(%esp)
80101afe:	e8 2d 77 00 00       	call   80109230 <freevm>
  return 0;
80101b03:	83 c4 10             	add    $0x10,%esp
80101b06:	31 c0                	xor    %eax,%eax
80101b08:	e9 2f fd ff ff       	jmp    8010183c <exec+0x6c>
    end_op();
80101b0d:	e8 fe 1f 00 00       	call   80103b10 <end_op>
    cprintf("exec: fail\n");
80101b12:	83 ec 0c             	sub    $0xc,%esp
80101b15:	68 50 9a 10 80       	push   $0x80109a50
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
80101b46:	68 5c 9a 10 80       	push   $0x80109a5c
80101b4b:	68 00 26 11 80       	push   $0x80112600
80101b50:	e8 db 44 00 00       	call   80106030 <initlock>
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
80101b64:	bb 34 26 11 80       	mov    $0x80112634,%ebx
{
80101b69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101b6c:	68 00 26 11 80       	push   $0x80112600
80101b71:	e8 8a 46 00 00       	call   80106200 <acquire>
80101b76:	83 c4 10             	add    $0x10,%esp
80101b79:	eb 10                	jmp    80101b8b <filealloc+0x2b>
80101b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b7f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b80:	83 c3 18             	add    $0x18,%ebx
80101b83:	81 fb 94 2f 11 80    	cmp    $0x80112f94,%ebx
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
80101b9c:	68 00 26 11 80       	push   $0x80112600
80101ba1:	e8 fa 45 00 00       	call   801061a0 <release>
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
80101bb5:	68 00 26 11 80       	push   $0x80112600
80101bba:	e8 e1 45 00 00       	call   801061a0 <release>
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
80101bda:	68 00 26 11 80       	push   $0x80112600
80101bdf:	e8 1c 46 00 00       	call   80106200 <acquire>
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
80101bf7:	68 00 26 11 80       	push   $0x80112600
80101bfc:	e8 9f 45 00 00       	call   801061a0 <release>
  return f;
}
80101c01:	89 d8                	mov    %ebx,%eax
80101c03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c06:	c9                   	leave  
80101c07:	c3                   	ret    
    panic("filedup");
80101c08:	83 ec 0c             	sub    $0xc,%esp
80101c0b:	68 63 9a 10 80       	push   $0x80109a63
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
80101c2c:	68 00 26 11 80       	push   $0x80112600
80101c31:	e8 ca 45 00 00       	call   80106200 <acquire>
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
80101c64:	68 00 26 11 80       	push   $0x80112600
  ff = *f;
80101c69:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101c6c:	e8 2f 45 00 00       	call   801061a0 <release>

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
80101c90:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80101c97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9a:	5b                   	pop    %ebx
80101c9b:	5e                   	pop    %esi
80101c9c:	5f                   	pop    %edi
80101c9d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101c9e:	e9 fd 44 00 00       	jmp    801061a0 <release>
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
80101cd9:	e8 d2 25 00 00       	call   801042b0 <pipeclose>
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
80101cec:	68 6b 9a 10 80       	push   $0x80109a6b
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
80101dbd:	e9 8e 26 00 00       	jmp    80104450 <piperead>
80101dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101dc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101dcd:	eb d7                	jmp    80101da6 <fileread+0x56>
  panic("fileread");
80101dcf:	83 ec 0c             	sub    $0xc,%esp
80101dd2:	68 75 9a 10 80       	push   $0x80109a75
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
80101ea7:	68 7e 9a 10 80       	push   $0x80109a7e
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
80101ed9:	e9 72 24 00 00       	jmp    80104350 <pipewrite>
  panic("filewrite");
80101ede:	83 ec 0c             	sub    $0xc,%esp
80101ee1:	68 84 9a 10 80       	push   $0x80109a84
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
80101ef8:	03 05 6c 4c 11 80    	add    0x80114c6c,%eax
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
80101f57:	68 8e 9a 10 80       	push   $0x80109a8e
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
80101f79:	8b 0d 54 4c 11 80    	mov    0x80114c54,%ecx
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
80101f9c:	03 05 6c 4c 11 80    	add    0x80114c6c,%eax
80101fa2:	50                   	push   %eax
80101fa3:	ff 75 d8             	push   -0x28(%ebp)
80101fa6:	e8 25 e1 ff ff       	call   801000d0 <bread>
80101fab:	83 c4 10             	add    $0x10,%esp
80101fae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101fb1:	a1 54 4c 11 80       	mov    0x80114c54,%eax
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
80102009:	39 05 54 4c 11 80    	cmp    %eax,0x80114c54
8010200f:	77 80                	ja     80101f91 <balloc+0x21>
  panic("balloc: out of blocks");
80102011:	83 ec 0c             	sub    $0xc,%esp
80102014:	68 a1 9a 10 80       	push   $0x80109aa1
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
80102055:	e8 66 42 00 00       	call   801062c0 <memset>
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
8010208a:	bb 34 30 11 80       	mov    $0x80113034,%ebx
{
8010208f:	83 ec 28             	sub    $0x28,%esp
80102092:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102095:	68 00 30 11 80       	push   $0x80113000
8010209a:	e8 61 41 00 00       	call   80106200 <acquire>
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
801020ba:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
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
801020d9:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
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
80102102:	68 00 30 11 80       	push   $0x80113000
80102107:	e8 94 40 00 00       	call   801061a0 <release>

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
8010212d:	68 00 30 11 80       	push   $0x80113000
      ip->ref++;
80102132:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102135:	e8 66 40 00 00       	call   801061a0 <release>
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
8010214d:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80102153:	73 10                	jae    80102165 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102155:	8b 43 08             	mov    0x8(%ebx),%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 8f 50 ff ff ff    	jg     801020b0 <iget+0x30>
80102160:	e9 68 ff ff ff       	jmp    801020cd <iget+0x4d>
    panic("iget: no inodes");
80102165:	83 ec 0c             	sub    $0xc,%esp
80102168:	68 b7 9a 10 80       	push   $0x80109ab7
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
80102245:	68 c7 9a 10 80       	push   $0x80109ac7
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
80102271:	e8 ea 40 00 00       	call   80106360 <memmove>
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
80102294:	bb 40 30 11 80       	mov    $0x80113040,%ebx
80102299:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010229c:	68 da 9a 10 80       	push   $0x80109ada
801022a1:	68 00 30 11 80       	push   $0x80113000
801022a6:	e8 85 3d 00 00       	call   80106030 <initlock>
  for(i = 0; i < NINODE; i++) {
801022ab:	83 c4 10             	add    $0x10,%esp
801022ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801022b0:	83 ec 08             	sub    $0x8,%esp
801022b3:	68 e1 9a 10 80       	push   $0x80109ae1
801022b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801022b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801022bf:	e8 3c 3c 00 00       	call   80105f00 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801022c4:	83 c4 10             	add    $0x10,%esp
801022c7:	81 fb 60 4c 11 80    	cmp    $0x80114c60,%ebx
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
801022e7:	68 54 4c 11 80       	push   $0x80114c54
801022ec:	e8 6f 40 00 00       	call   80106360 <memmove>
  brelse(bp);
801022f1:	89 1c 24             	mov    %ebx,(%esp)
801022f4:	e8 f7 de ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801022f9:	ff 35 6c 4c 11 80    	push   0x80114c6c
801022ff:	ff 35 68 4c 11 80    	push   0x80114c68
80102305:	ff 35 64 4c 11 80    	push   0x80114c64
8010230b:	ff 35 60 4c 11 80    	push   0x80114c60
80102311:	ff 35 5c 4c 11 80    	push   0x80114c5c
80102317:	ff 35 58 4c 11 80    	push   0x80114c58
8010231d:	ff 35 54 4c 11 80    	push   0x80114c54
80102323:	68 44 9b 10 80       	push   $0x80109b44
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
8010234c:	83 3d 5c 4c 11 80 01 	cmpl   $0x1,0x80114c5c
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
8010237f:	3b 3d 5c 4c 11 80    	cmp    0x80114c5c,%edi
80102385:	73 69                	jae    801023f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102387:	89 f8                	mov    %edi,%eax
80102389:	83 ec 08             	sub    $0x8,%esp
8010238c:	c1 e8 03             	shr    $0x3,%eax
8010238f:	03 05 68 4c 11 80    	add    0x80114c68,%eax
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
801023be:	e8 fd 3e 00 00       	call   801062c0 <memset>
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
801023f3:	68 e7 9a 10 80       	push   $0x80109ae7
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
80102414:	03 05 68 4c 11 80    	add    0x80114c68,%eax
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
80102461:	e8 fa 3e 00 00       	call   80106360 <memmove>
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
8010248a:	68 00 30 11 80       	push   $0x80113000
8010248f:	e8 6c 3d 00 00       	call   80106200 <acquire>
  ip->ref++;
80102494:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102498:	c7 04 24 00 30 11 80 	movl   $0x80113000,(%esp)
8010249f:	e8 fc 3c 00 00       	call   801061a0 <release>
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
801024d2:	e8 69 3a 00 00       	call   80105f40 <acquiresleep>
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
801024f9:	03 05 68 4c 11 80    	add    0x80114c68,%eax
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
80102548:	e8 13 3e 00 00       	call   80106360 <memmove>
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
8010256d:	68 ff 9a 10 80       	push   $0x80109aff
80102572:	e8 79 df ff ff       	call   801004f0 <panic>
    panic("ilock");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 f9 9a 10 80       	push   $0x80109af9
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
801025a3:	e8 38 3a 00 00       	call   80105fe0 <holdingsleep>
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
801025bf:	e9 dc 39 00 00       	jmp    80105fa0 <releasesleep>
    panic("iunlock");
801025c4:	83 ec 0c             	sub    $0xc,%esp
801025c7:	68 0e 9b 10 80       	push   $0x80109b0e
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
801025f0:	e8 4b 39 00 00       	call   80105f40 <acquiresleep>
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
8010260a:	e8 91 39 00 00       	call   80105fa0 <releasesleep>
  acquire(&icache.lock);
8010260f:	c7 04 24 00 30 11 80 	movl   $0x80113000,(%esp)
80102616:	e8 e5 3b 00 00       	call   80106200 <acquire>
  ip->ref--;
8010261b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010261f:	83 c4 10             	add    $0x10,%esp
80102622:	c7 45 08 00 30 11 80 	movl   $0x80113000,0x8(%ebp)
}
80102629:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010262c:	5b                   	pop    %ebx
8010262d:	5e                   	pop    %esi
8010262e:	5f                   	pop    %edi
8010262f:	5d                   	pop    %ebp
  release(&icache.lock);
80102630:	e9 6b 3b 00 00       	jmp    801061a0 <release>
80102635:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102638:	83 ec 0c             	sub    $0xc,%esp
8010263b:	68 00 30 11 80       	push   $0x80113000
80102640:	e8 bb 3b 00 00       	call   80106200 <acquire>
    int r = ip->ref;
80102645:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102648:	c7 04 24 00 30 11 80 	movl   $0x80113000,(%esp)
8010264f:	e8 4c 3b 00 00       	call   801061a0 <release>
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
80102753:	e8 88 38 00 00       	call   80105fe0 <holdingsleep>
80102758:	83 c4 10             	add    $0x10,%esp
8010275b:	85 c0                	test   %eax,%eax
8010275d:	74 21                	je     80102780 <iunlockput+0x40>
8010275f:	8b 43 08             	mov    0x8(%ebx),%eax
80102762:	85 c0                	test   %eax,%eax
80102764:	7e 1a                	jle    80102780 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102766:	83 ec 0c             	sub    $0xc,%esp
80102769:	56                   	push   %esi
8010276a:	e8 31 38 00 00       	call   80105fa0 <releasesleep>
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
80102783:	68 0e 9b 10 80       	push   $0x80109b0e
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
80102867:	e8 f4 3a 00 00       	call   80106360 <memmove>
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
8010289a:	8b 04 c5 a0 2f 11 80 	mov    -0x7feed060(,%eax,8),%eax
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
80102963:	e8 f8 39 00 00       	call   80106360 <memmove>
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
801029aa:	8b 04 c5 a4 2f 11 80 	mov    -0x7feed05c(,%eax,8),%eax
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
801029fe:	e8 cd 39 00 00       	call   801063d0 <strncmp>
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
80102a5d:	e8 6e 39 00 00       	call   801063d0 <strncmp>
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
80102aa2:	68 28 9b 10 80       	push   $0x80109b28
80102aa7:	e8 44 da ff ff       	call   801004f0 <panic>
    panic("dirlookup not DIR");
80102aac:	83 ec 0c             	sub    $0xc,%esp
80102aaf:	68 16 9b 10 80       	push   $0x80109b16
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
80102ada:	e8 a1 1c 00 00       	call   80104780 <myproc>
  acquire(&icache.lock);
80102adf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102ae2:	8b b0 d4 00 00 00    	mov    0xd4(%eax),%esi
  acquire(&icache.lock);
80102ae8:	68 00 30 11 80       	push   $0x80113000
80102aed:	e8 0e 37 00 00       	call   80106200 <acquire>
  ip->ref++;
80102af2:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102af6:	c7 04 24 00 30 11 80 	movl   $0x80113000,(%esp)
80102afd:	e8 9e 36 00 00       	call   801061a0 <release>
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
80102b67:	e8 f4 37 00 00       	call   80106360 <memmove>
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
80102bcc:	e8 0f 34 00 00       	call   80105fe0 <holdingsleep>
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
80102bee:	e8 ad 33 00 00       	call   80105fa0 <releasesleep>
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
80102c1b:	e8 40 37 00 00       	call   80106360 <memmove>
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
80102c6b:	e8 70 33 00 00       	call   80105fe0 <holdingsleep>
80102c70:	83 c4 10             	add    $0x10,%esp
80102c73:	85 c0                	test   %eax,%eax
80102c75:	0f 84 91 00 00 00    	je     80102d0c <namex+0x24c>
80102c7b:	8b 46 08             	mov    0x8(%esi),%eax
80102c7e:	85 c0                	test   %eax,%eax
80102c80:	0f 8e 86 00 00 00    	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102c86:	83 ec 0c             	sub    $0xc,%esp
80102c89:	53                   	push   %ebx
80102c8a:	e8 11 33 00 00       	call   80105fa0 <releasesleep>
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
80102cad:	e8 2e 33 00 00       	call   80105fe0 <holdingsleep>
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
80102cd0:	e8 0b 33 00 00       	call   80105fe0 <holdingsleep>
80102cd5:	83 c4 10             	add    $0x10,%esp
80102cd8:	85 c0                	test   %eax,%eax
80102cda:	74 30                	je     80102d0c <namex+0x24c>
80102cdc:	8b 7e 08             	mov    0x8(%esi),%edi
80102cdf:	85 ff                	test   %edi,%edi
80102ce1:	7e 29                	jle    80102d0c <namex+0x24c>
  releasesleep(&ip->lock);
80102ce3:	83 ec 0c             	sub    $0xc,%esp
80102ce6:	53                   	push   %ebx
80102ce7:	e8 b4 32 00 00       	call   80105fa0 <releasesleep>
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
80102d0f:	68 0e 9b 10 80       	push   $0x80109b0e
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
80102d7d:	e8 9e 36 00 00       	call   80106420 <strncpy>
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
80102dbb:	68 37 9b 10 80       	push   $0x80109b37
80102dc0:	e8 2b d7 ff ff       	call   801004f0 <panic>
    panic("dirlink");
80102dc5:	83 ec 0c             	sub    $0xc,%esp
80102dc8:	68 12 a3 10 80       	push   $0x8010a312
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
80102edb:	68 a0 9b 10 80       	push   $0x80109ba0
80102ee0:	e8 0b d6 ff ff       	call   801004f0 <panic>
    panic("idestart");
80102ee5:	83 ec 0c             	sub    $0xc,%esp
80102ee8:	68 97 9b 10 80       	push   $0x80109b97
80102eed:	e8 fe d5 ff ff       	call   801004f0 <panic>
80102ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f00 <ideinit>:
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102f06:	68 b2 9b 10 80       	push   $0x80109bb2
80102f0b:	68 a0 4c 11 80       	push   $0x80114ca0
80102f10:	e8 1b 31 00 00       	call   80106030 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102f15:	58                   	pop    %eax
80102f16:	a1 24 4e 11 80       	mov    0x80114e24,%eax
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
80102f5a:	c7 05 80 4c 11 80 01 	movl   $0x1,0x80114c80
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
80102f89:	68 a0 4c 11 80       	push   $0x80114ca0
80102f8e:	e8 6d 32 00 00       	call   80106200 <acquire>

  if((b = idequeue) == 0){
80102f93:	8b 1d 84 4c 11 80    	mov    0x80114c84,%ebx
80102f99:	83 c4 10             	add    $0x10,%esp
80102f9c:	85 db                	test   %ebx,%ebx
80102f9e:	74 63                	je     80103003 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102fa0:	8b 43 58             	mov    0x58(%ebx),%eax
80102fa3:	a3 84 4c 11 80       	mov    %eax,0x80114c84

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
80102fed:	e8 4e 24 00 00       	call   80105440 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102ff2:	a1 84 4c 11 80       	mov    0x80114c84,%eax
80102ff7:	83 c4 10             	add    $0x10,%esp
80102ffa:	85 c0                	test   %eax,%eax
80102ffc:	74 05                	je     80103003 <ideintr+0x83>
    idestart(idequeue);
80102ffe:	e8 1d fe ff ff       	call   80102e20 <idestart>
    release(&idelock);
80103003:	83 ec 0c             	sub    $0xc,%esp
80103006:	68 a0 4c 11 80       	push   $0x80114ca0
8010300b:	e8 90 31 00 00       	call   801061a0 <release>

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
8010302e:	e8 ad 2f 00 00       	call   80105fe0 <holdingsleep>
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
80103053:	a1 80 4c 11 80       	mov    0x80114c80,%eax
80103058:	85 c0                	test   %eax,%eax
8010305a:	0f 84 87 00 00 00    	je     801030e7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103060:	83 ec 0c             	sub    $0xc,%esp
80103063:	68 a0 4c 11 80       	push   $0x80114ca0
80103068:	e8 93 31 00 00       	call   80106200 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010306d:	a1 84 4c 11 80       	mov    0x80114c84,%eax
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
8010308e:	39 1d 84 4c 11 80    	cmp    %ebx,0x80114c84
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
801030a3:	68 a0 4c 11 80       	push   $0x80114ca0
801030a8:	53                   	push   %ebx
801030a9:	e8 c2 22 00 00       	call   80105370 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801030ae:	8b 03                	mov    (%ebx),%eax
801030b0:	83 c4 10             	add    $0x10,%esp
801030b3:	83 e0 06             	and    $0x6,%eax
801030b6:	83 f8 02             	cmp    $0x2,%eax
801030b9:	75 e5                	jne    801030a0 <iderw+0x80>
  }


  release(&idelock);
801030bb:	c7 45 08 a0 4c 11 80 	movl   $0x80114ca0,0x8(%ebp)
}
801030c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030c5:	c9                   	leave  
  release(&idelock);
801030c6:	e9 d5 30 00 00       	jmp    801061a0 <release>
801030cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030cf:	90                   	nop
    idestart(b);
801030d0:	89 d8                	mov    %ebx,%eax
801030d2:	e8 49 fd ff ff       	call   80102e20 <idestart>
801030d7:	eb bd                	jmp    80103096 <iderw+0x76>
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801030e0:	ba 84 4c 11 80       	mov    $0x80114c84,%edx
801030e5:	eb a5                	jmp    8010308c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801030e7:	83 ec 0c             	sub    $0xc,%esp
801030ea:	68 e1 9b 10 80       	push   $0x80109be1
801030ef:	e8 fc d3 ff ff       	call   801004f0 <panic>
    panic("iderw: nothing to do");
801030f4:	83 ec 0c             	sub    $0xc,%esp
801030f7:	68 cc 9b 10 80       	push   $0x80109bcc
801030fc:	e8 ef d3 ff ff       	call   801004f0 <panic>
    panic("iderw: buf not locked");
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	68 b6 9b 10 80       	push   $0x80109bb6
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
80103111:	c7 05 d4 4c 11 80 00 	movl   $0xfec00000,0x80114cd4
80103118:	00 c0 fe 
{
8010311b:	89 e5                	mov    %esp,%ebp
8010311d:	56                   	push   %esi
8010311e:	53                   	push   %ebx
  ioapic->reg = reg;
8010311f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103126:	00 00 00 
  return ioapic->data;
80103129:	8b 15 d4 4c 11 80    	mov    0x80114cd4,%edx
8010312f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80103132:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80103138:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010313e:	0f b6 15 20 4e 11 80 	movzbl 0x80114e20,%edx
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
8010315a:	68 00 9c 10 80       	push   $0x80109c00
8010315f:	e8 0c d9 ff ff       	call   80100a70 <cprintf>
  ioapic->reg = reg;
80103164:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
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
80103184:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
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
8010319e:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
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
801031c1:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
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
801031d5:	8b 0d d4 4c 11 80    	mov    0x80114cd4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801031de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801031e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801031e6:	a1 d4 4c 11 80       	mov    0x80114cd4,%eax
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
80103212:	81 fb 20 b3 11 80    	cmp    $0x8011b320,%ebx
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
80103232:	e8 89 30 00 00       	call   801062c0 <memset>

  if(kmem.use_lock)
80103237:	8b 15 14 4d 11 80    	mov    0x80114d14,%edx
8010323d:	83 c4 10             	add    $0x10,%esp
80103240:	85 d2                	test   %edx,%edx
80103242:	75 1c                	jne    80103260 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103244:	a1 18 4d 11 80       	mov    0x80114d18,%eax
80103249:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010324b:	a1 14 4d 11 80       	mov    0x80114d14,%eax
  kmem.freelist = r;
80103250:	89 1d 18 4d 11 80    	mov    %ebx,0x80114d18
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
80103263:	68 e0 4c 11 80       	push   $0x80114ce0
80103268:	e8 93 2f 00 00       	call   80106200 <acquire>
8010326d:	83 c4 10             	add    $0x10,%esp
80103270:	eb d2                	jmp    80103244 <kfree+0x44>
80103272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103278:	c7 45 08 e0 4c 11 80 	movl   $0x80114ce0,0x8(%ebp)
}
8010327f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103282:	c9                   	leave  
    release(&kmem.lock);
80103283:	e9 18 2f 00 00       	jmp    801061a0 <release>
    panic("kfree");
80103288:	83 ec 0c             	sub    $0xc,%esp
8010328b:	68 32 9c 10 80       	push   $0x80109c32
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
80103334:	c7 05 14 4d 11 80 01 	movl   $0x1,0x80114d14
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
8010335b:	68 38 9c 10 80       	push   $0x80109c38
80103360:	68 e0 4c 11 80       	push   $0x80114ce0
80103365:	e8 c6 2c 00 00       	call   80106030 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010336a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010336d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103370:	c7 05 14 4d 11 80 00 	movl   $0x0,0x80114d14
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
801033c0:	a1 14 4d 11 80       	mov    0x80114d14,%eax
801033c5:	85 c0                	test   %eax,%eax
801033c7:	75 1f                	jne    801033e8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801033c9:	a1 18 4d 11 80       	mov    0x80114d18,%eax
  if(r)
801033ce:	85 c0                	test   %eax,%eax
801033d0:	74 0e                	je     801033e0 <kalloc+0x20>
    kmem.freelist = r->next;
801033d2:	8b 10                	mov    (%eax),%edx
801033d4:	89 15 18 4d 11 80    	mov    %edx,0x80114d18
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
801033ee:	68 e0 4c 11 80       	push   $0x80114ce0
801033f3:	e8 08 2e 00 00       	call   80106200 <acquire>
  r = kmem.freelist;
801033f8:	a1 18 4d 11 80       	mov    0x80114d18,%eax
  if(kmem.use_lock)
801033fd:	8b 15 14 4d 11 80    	mov    0x80114d14,%edx
  if(r)
80103403:	83 c4 10             	add    $0x10,%esp
80103406:	85 c0                	test   %eax,%eax
80103408:	74 08                	je     80103412 <kalloc+0x52>
    kmem.freelist = r->next;
8010340a:	8b 08                	mov    (%eax),%ecx
8010340c:	89 0d 18 4d 11 80    	mov    %ecx,0x80114d18
  if(kmem.use_lock)
80103412:	85 d2                	test   %edx,%edx
80103414:	74 16                	je     8010342c <kalloc+0x6c>
    release(&kmem.lock);
80103416:	83 ec 0c             	sub    $0xc,%esp
80103419:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010341c:	68 e0 4c 11 80       	push   $0x80114ce0
80103421:	e8 7a 2d 00 00       	call   801061a0 <release>
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
80103448:	8b 1d 1c 4d 11 80    	mov    0x80114d1c,%ebx
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
8010346b:	0f b6 91 60 9d 10 80 	movzbl -0x7fef62a0(%ecx),%edx
  shift ^= togglecode[data];
80103472:	0f b6 81 60 9c 10 80 	movzbl -0x7fef63a0(%ecx),%eax
  shift |= shiftcode[data];
80103479:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010347b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010347d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010347f:	89 15 1c 4d 11 80    	mov    %edx,0x80114d1c
  c = charcode[shift & (CTL | SHIFT)][data];
80103485:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103488:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010348b:	8b 04 85 40 9c 10 80 	mov    -0x7fef63c0(,%eax,4),%eax
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
801034b5:	89 1d 1c 4d 11 80    	mov    %ebx,0x80114d1c
}
801034bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034be:	c9                   	leave  
801034bf:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801034c0:	83 e0 7f             	and    $0x7f,%eax
801034c3:	85 d2                	test   %edx,%edx
801034c5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801034c8:	0f b6 81 60 9d 10 80 	movzbl -0x7fef62a0(%ecx),%eax
801034cf:	83 c8 40             	or     $0x40,%eax
801034d2:	0f b6 c0             	movzbl %al,%eax
801034d5:	f7 d0                	not    %eax
801034d7:	21 d8                	and    %ebx,%eax
}
801034d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801034dc:	a3 1c 4d 11 80       	mov    %eax,0x80114d1c
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
80103530:	a1 20 4d 11 80       	mov    0x80114d20,%eax
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
80103630:	a1 20 4d 11 80       	mov    0x80114d20,%eax
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
80103650:	a1 20 4d 11 80       	mov    0x80114d20,%eax
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
801036be:	a1 20 4d 11 80       	mov    0x80114d20,%eax
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
80103837:	e8 d4 2a 00 00       	call   80106310 <memcmp>
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
80103900:	8b 0d 88 4d 11 80    	mov    0x80114d88,%ecx
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
80103920:	a1 74 4d 11 80       	mov    0x80114d74,%eax
80103925:	83 ec 08             	sub    $0x8,%esp
80103928:	01 f8                	add    %edi,%eax
8010392a:	83 c0 01             	add    $0x1,%eax
8010392d:	50                   	push   %eax
8010392e:	ff 35 84 4d 11 80    	push   0x80114d84
80103934:	e8 97 c7 ff ff       	call   801000d0 <bread>
80103939:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010393b:	58                   	pop    %eax
8010393c:	5a                   	pop    %edx
8010393d:	ff 34 bd 8c 4d 11 80 	push   -0x7feeb274(,%edi,4)
80103944:	ff 35 84 4d 11 80    	push   0x80114d84
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
80103964:	e8 f7 29 00 00       	call   80106360 <memmove>
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
80103984:	39 3d 88 4d 11 80    	cmp    %edi,0x80114d88
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
801039a7:	ff 35 74 4d 11 80    	push   0x80114d74
801039ad:	ff 35 84 4d 11 80    	push   0x80114d84
801039b3:	e8 18 c7 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801039b8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801039bb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
801039bd:	a1 88 4d 11 80       	mov    0x80114d88,%eax
801039c2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801039c5:	85 c0                	test   %eax,%eax
801039c7:	7e 19                	jle    801039e2 <write_head+0x42>
801039c9:	31 d2                	xor    %edx,%edx
801039cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039cf:	90                   	nop
    hb->block[i] = log.lh.block[i];
801039d0:	8b 0c 95 8c 4d 11 80 	mov    -0x7feeb274(,%edx,4),%ecx
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
80103a0a:	68 60 9e 10 80       	push   $0x80109e60
80103a0f:	68 40 4d 11 80       	push   $0x80114d40
80103a14:	e8 17 26 00 00       	call   80106030 <initlock>
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
80103a29:	89 1d 84 4d 11 80    	mov    %ebx,0x80114d84
  log.size = sb.nlog;
80103a2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103a32:	a3 74 4d 11 80       	mov    %eax,0x80114d74
  log.size = sb.nlog;
80103a37:	89 15 78 4d 11 80    	mov    %edx,0x80114d78
  struct buf *buf = bread(log.dev, log.start);
80103a3d:	5a                   	pop    %edx
80103a3e:	50                   	push   %eax
80103a3f:	53                   	push   %ebx
80103a40:	e8 8b c6 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103a45:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103a48:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103a4b:	89 1d 88 4d 11 80    	mov    %ebx,0x80114d88
  for (i = 0; i < log.lh.n; i++) {
80103a51:	85 db                	test   %ebx,%ebx
80103a53:	7e 1d                	jle    80103a72 <initlog+0x72>
80103a55:	31 d2                	xor    %edx,%edx
80103a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a5e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103a60:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103a64:	89 0c 95 8c 4d 11 80 	mov    %ecx,-0x7feeb274(,%edx,4)
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
80103a80:	c7 05 88 4d 11 80 00 	movl   $0x0,0x80114d88
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
80103aa6:	68 40 4d 11 80       	push   $0x80114d40
80103aab:	e8 50 27 00 00       	call   80106200 <acquire>
80103ab0:	83 c4 10             	add    $0x10,%esp
80103ab3:	eb 18                	jmp    80103acd <begin_op+0x2d>
80103ab5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103ab8:	83 ec 08             	sub    $0x8,%esp
80103abb:	68 40 4d 11 80       	push   $0x80114d40
80103ac0:	68 40 4d 11 80       	push   $0x80114d40
80103ac5:	e8 a6 18 00 00       	call   80105370 <sleep>
80103aca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103acd:	a1 80 4d 11 80       	mov    0x80114d80,%eax
80103ad2:	85 c0                	test   %eax,%eax
80103ad4:	75 e2                	jne    80103ab8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103ad6:	a1 7c 4d 11 80       	mov    0x80114d7c,%eax
80103adb:	8b 15 88 4d 11 80    	mov    0x80114d88,%edx
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
80103af2:	a3 7c 4d 11 80       	mov    %eax,0x80114d7c
      release(&log.lock);
80103af7:	68 40 4d 11 80       	push   $0x80114d40
80103afc:	e8 9f 26 00 00       	call   801061a0 <release>
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
80103b19:	68 40 4d 11 80       	push   $0x80114d40
80103b1e:	e8 dd 26 00 00       	call   80106200 <acquire>
  log.outstanding -= 1;
80103b23:	a1 7c 4d 11 80       	mov    0x80114d7c,%eax
  if(log.committing)
80103b28:	8b 35 80 4d 11 80    	mov    0x80114d80,%esi
80103b2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103b31:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103b34:	89 1d 7c 4d 11 80    	mov    %ebx,0x80114d7c
  if(log.committing)
80103b3a:	85 f6                	test   %esi,%esi
80103b3c:	0f 85 22 01 00 00    	jne    80103c64 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103b42:	85 db                	test   %ebx,%ebx
80103b44:	0f 85 f6 00 00 00    	jne    80103c40 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103b4a:	c7 05 80 4d 11 80 01 	movl   $0x1,0x80114d80
80103b51:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103b54:	83 ec 0c             	sub    $0xc,%esp
80103b57:	68 40 4d 11 80       	push   $0x80114d40
80103b5c:	e8 3f 26 00 00       	call   801061a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103b61:	8b 0d 88 4d 11 80    	mov    0x80114d88,%ecx
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c9                	test   %ecx,%ecx
80103b6c:	7f 42                	jg     80103bb0 <end_op+0xa0>
    acquire(&log.lock);
80103b6e:	83 ec 0c             	sub    $0xc,%esp
80103b71:	68 40 4d 11 80       	push   $0x80114d40
80103b76:	e8 85 26 00 00       	call   80106200 <acquire>
    wakeup(&log);
80103b7b:	c7 04 24 40 4d 11 80 	movl   $0x80114d40,(%esp)
    log.committing = 0;
80103b82:	c7 05 80 4d 11 80 00 	movl   $0x0,0x80114d80
80103b89:	00 00 00 
    wakeup(&log);
80103b8c:	e8 af 18 00 00       	call   80105440 <wakeup>
    release(&log.lock);
80103b91:	c7 04 24 40 4d 11 80 	movl   $0x80114d40,(%esp)
80103b98:	e8 03 26 00 00       	call   801061a0 <release>
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
80103bb0:	a1 74 4d 11 80       	mov    0x80114d74,%eax
80103bb5:	83 ec 08             	sub    $0x8,%esp
80103bb8:	01 d8                	add    %ebx,%eax
80103bba:	83 c0 01             	add    $0x1,%eax
80103bbd:	50                   	push   %eax
80103bbe:	ff 35 84 4d 11 80    	push   0x80114d84
80103bc4:	e8 07 c5 ff ff       	call   801000d0 <bread>
80103bc9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103bcb:	58                   	pop    %eax
80103bcc:	5a                   	pop    %edx
80103bcd:	ff 34 9d 8c 4d 11 80 	push   -0x7feeb274(,%ebx,4)
80103bd4:	ff 35 84 4d 11 80    	push   0x80114d84
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
80103bf4:	e8 67 27 00 00       	call   80106360 <memmove>
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
80103c14:	3b 1d 88 4d 11 80    	cmp    0x80114d88,%ebx
80103c1a:	7c 94                	jl     80103bb0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103c1c:	e8 7f fd ff ff       	call   801039a0 <write_head>
    install_trans(); // Now install writes to home locations
80103c21:	e8 da fc ff ff       	call   80103900 <install_trans>
    log.lh.n = 0;
80103c26:	c7 05 88 4d 11 80 00 	movl   $0x0,0x80114d88
80103c2d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103c30:	e8 6b fd ff ff       	call   801039a0 <write_head>
80103c35:	e9 34 ff ff ff       	jmp    80103b6e <end_op+0x5e>
80103c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103c40:	83 ec 0c             	sub    $0xc,%esp
80103c43:	68 40 4d 11 80       	push   $0x80114d40
80103c48:	e8 f3 17 00 00       	call   80105440 <wakeup>
  release(&log.lock);
80103c4d:	c7 04 24 40 4d 11 80 	movl   $0x80114d40,(%esp)
80103c54:	e8 47 25 00 00       	call   801061a0 <release>
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
80103c67:	68 64 9e 10 80       	push   $0x80109e64
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
80103c87:	8b 15 88 4d 11 80    	mov    0x80114d88,%edx
{
80103c8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c90:	83 fa 1d             	cmp    $0x1d,%edx
80103c93:	0f 8f 85 00 00 00    	jg     80103d1e <log_write+0x9e>
80103c99:	a1 78 4d 11 80       	mov    0x80114d78,%eax
80103c9e:	83 e8 01             	sub    $0x1,%eax
80103ca1:	39 c2                	cmp    %eax,%edx
80103ca3:	7d 79                	jge    80103d1e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103ca5:	a1 7c 4d 11 80       	mov    0x80114d7c,%eax
80103caa:	85 c0                	test   %eax,%eax
80103cac:	7e 7d                	jle    80103d2b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103cae:	83 ec 0c             	sub    $0xc,%esp
80103cb1:	68 40 4d 11 80       	push   $0x80114d40
80103cb6:	e8 45 25 00 00       	call   80106200 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103cbb:	8b 15 88 4d 11 80    	mov    0x80114d88,%edx
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
80103cd7:	39 0c 85 8c 4d 11 80 	cmp    %ecx,-0x7feeb274(,%eax,4)
80103cde:	75 f0                	jne    80103cd0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103ce0:	89 0c 85 8c 4d 11 80 	mov    %ecx,-0x7feeb274(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103ce7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103cea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103ced:	c7 45 08 40 4d 11 80 	movl   $0x80114d40,0x8(%ebp)
}
80103cf4:	c9                   	leave  
  release(&log.lock);
80103cf5:	e9 a6 24 00 00       	jmp    801061a0 <release>
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103d00:	89 0c 95 8c 4d 11 80 	mov    %ecx,-0x7feeb274(,%edx,4)
    log.lh.n++;
80103d07:	83 c2 01             	add    $0x1,%edx
80103d0a:	89 15 88 4d 11 80    	mov    %edx,0x80114d88
80103d10:	eb d5                	jmp    80103ce7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103d12:	8b 43 08             	mov    0x8(%ebx),%eax
80103d15:	a3 8c 4d 11 80       	mov    %eax,0x80114d8c
  if (i == log.lh.n)
80103d1a:	75 cb                	jne    80103ce7 <log_write+0x67>
80103d1c:	eb e9                	jmp    80103d07 <log_write+0x87>
    panic("too big a transaction");
80103d1e:	83 ec 0c             	sub    $0xc,%esp
80103d21:	68 73 9e 10 80       	push   $0x80109e73
80103d26:	e8 c5 c7 ff ff       	call   801004f0 <panic>
    panic("log_write outside of trans");
80103d2b:	83 ec 0c             	sub    $0xc,%esp
80103d2e:	68 89 9e 10 80       	push   $0x80109e89
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
80103d47:	e8 14 0a 00 00       	call   80104760 <cpuid>
80103d4c:	89 c3                	mov    %eax,%ebx
80103d4e:	e8 0d 0a 00 00       	call   80104760 <cpuid>
80103d53:	83 ec 04             	sub    $0x4,%esp
80103d56:	53                   	push   %ebx
80103d57:	50                   	push   %eax
80103d58:	68 a4 9e 10 80       	push   $0x80109ea4
80103d5d:	e8 0e cd ff ff       	call   80100a70 <cprintf>
  idtinit();       // load idt register
80103d62:	e8 d9 3d 00 00       	call   80107b40 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103d67:	e8 94 09 00 00       	call   80104700 <mycpu>
80103d6c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103d6e:	b8 01 00 00 00       	mov    $0x1,%eax
80103d73:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103d7a:	e8 91 10 00 00       	call   80104e10 <scheduler>
80103d7f:	90                   	nop

80103d80 <mpenter>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103d86:	e8 b5 50 00 00       	call   80108e40 <switchkvm>
  seginit();
80103d8b:	e8 a0 4e 00 00       	call   80108c30 <seginit>
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
80103db7:	68 20 b3 11 80       	push   $0x8011b320
80103dbc:	e8 8f f5 ff ff       	call   80103350 <kinit1>
  kvmalloc();      // kernel page table
80103dc1:	e8 6a 55 00 00       	call   80109330 <kvmalloc>
  mpinit();        // detect other processors
80103dc6:	e8 95 01 00 00       	call   80103f60 <mpinit>
  lapicinit();     // interrupt controller
80103dcb:	e8 60 f7 ff ff       	call   80103530 <lapicinit>
  seginit();       // segment descriptors
80103dd0:	e8 5b 4e 00 00       	call   80108c30 <seginit>
  picinit();       // disable pic
80103dd5:	e8 b6 03 00 00       	call   80104190 <picinit>
  ioapicinit();    // another interrupt controller
80103dda:	e8 31 f3 ff ff       	call   80103110 <ioapicinit>
  consoleinit();   // console hardware
80103ddf:	e8 9c d9 ff ff       	call   80101780 <consoleinit>
  uartinit();      // serial port
80103de4:	e8 c7 41 00 00       	call   80107fb0 <uartinit>
  pinit();         // process table
80103de9:	e8 e2 08 00 00       	call   801046d0 <pinit>
  tvinit();        // trap vectors
80103dee:	e8 bd 3c 00 00       	call   80107ab0 <tvinit>
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
80103e0a:	68 ec d4 10 80       	push   $0x8010d4ec
80103e0f:	68 00 70 00 80       	push   $0x80007000
80103e14:	e8 47 25 00 00       	call   80106360 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103e19:	a1 24 4e 11 80       	mov    0x80114e24,%eax
80103e1e:	83 c4 10             	add    $0x10,%esp
80103e21:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103e24:	c1 e0 06             	shl    $0x6,%eax
80103e27:	05 40 4e 11 80       	add    $0x80114e40,%eax
80103e2c:	3d 40 4e 11 80       	cmp    $0x80114e40,%eax
80103e31:	76 7d                	jbe    80103eb0 <main+0x110>
80103e33:	bb 40 4e 11 80       	mov    $0x80114e40,%ebx
80103e38:	eb 20                	jmp    80103e5a <main+0xba>
80103e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e40:	a1 24 4e 11 80       	mov    0x80114e24,%eax
80103e45:	81 c3 c0 00 00 00    	add    $0xc0,%ebx
80103e4b:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103e4e:	c1 e0 06             	shl    $0x6,%eax
80103e51:	05 40 4e 11 80       	add    $0x80114e40,%eax
80103e56:	39 c3                	cmp    %eax,%ebx
80103e58:	73 56                	jae    80103eb0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103e5a:	e8 a1 08 00 00       	call   80104700 <mycpu>
80103e5f:	39 c3                	cmp    %eax,%ebx
80103e61:	74 dd                	je     80103e40 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103e63:	e8 58 f5 ff ff       	call   801033c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103e68:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103e6b:	c7 05 f8 6f 00 80 80 	movl   $0x80103d80,0x80006ff8
80103e72:	3d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103e75:	c7 05 f4 6f 00 80 00 	movl   $0x10c000,0x80006ff4
80103e7c:	c0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e7f:	05 00 10 00 00       	add    $0x1000,%eax
80103e84:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103e89:	0f b6 03             	movzbl (%ebx),%eax
80103e8c:	68 00 70 00 00       	push   $0x7000
80103e91:	50                   	push   %eax
80103e92:	e8 e9 f7 ff ff       	call   80103680 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e97:	83 c4 10             	add    $0x10,%esp
80103e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
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
80103ec2:	e8 99 0b 00 00       	call   80104a60 <userinit>
  initrlock();
80103ec7:	e8 c4 1e 00 00       	call   80105d90 <initrlock>
  mpmain();        // finish this processor's setup
80103ecc:	e8 6f fe ff ff       	call   80103d40 <mpmain>
80103ed1:	66 90                	xchg   %ax,%ax
80103ed3:	66 90                	xchg   %ax,%ax
80103ed5:	66 90                	xchg   %ax,%ax
80103ed7:	66 90                	xchg   %ax,%ax
80103ed9:	66 90                	xchg   %ax,%ax
80103edb:	66 90                	xchg   %ax,%ax
80103edd:	66 90                	xchg   %ax,%ax
80103edf:	90                   	nop

80103ee0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103ee5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103eeb:	53                   	push   %ebx
  e = addr+len;
80103eec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103eef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103ef2:	39 de                	cmp    %ebx,%esi
80103ef4:	72 10                	jb     80103f06 <mpsearch1+0x26>
80103ef6:	eb 50                	jmp    80103f48 <mpsearch1+0x68>
80103ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eff:	90                   	nop
80103f00:	89 fe                	mov    %edi,%esi
80103f02:	39 fb                	cmp    %edi,%ebx
80103f04:	76 42                	jbe    80103f48 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f06:	83 ec 04             	sub    $0x4,%esp
80103f09:	8d 7e 10             	lea    0x10(%esi),%edi
80103f0c:	6a 04                	push   $0x4
80103f0e:	68 b8 9e 10 80       	push   $0x80109eb8
80103f13:	56                   	push   %esi
80103f14:	e8 f7 23 00 00       	call   80106310 <memcmp>
80103f19:	83 c4 10             	add    $0x10,%esp
80103f1c:	85 c0                	test   %eax,%eax
80103f1e:	75 e0                	jne    80103f00 <mpsearch1+0x20>
80103f20:	89 f2                	mov    %esi,%edx
80103f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103f28:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103f2b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103f2e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103f30:	39 fa                	cmp    %edi,%edx
80103f32:	75 f4                	jne    80103f28 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f34:	84 c0                	test   %al,%al
80103f36:	75 c8                	jne    80103f00 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f3b:	89 f0                	mov    %esi,%eax
80103f3d:	5b                   	pop    %ebx
80103f3e:	5e                   	pop    %esi
80103f3f:	5f                   	pop    %edi
80103f40:	5d                   	pop    %ebp
80103f41:	c3                   	ret    
80103f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f48:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103f4b:	31 f6                	xor    %esi,%esi
}
80103f4d:	5b                   	pop    %ebx
80103f4e:	89 f0                	mov    %esi,%eax
80103f50:	5e                   	pop    %esi
80103f51:	5f                   	pop    %edi
80103f52:	5d                   	pop    %ebp
80103f53:	c3                   	ret    
80103f54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f5f:	90                   	nop

80103f60 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	57                   	push   %edi
80103f64:	56                   	push   %esi
80103f65:	53                   	push   %ebx
80103f66:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103f69:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103f70:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103f77:	c1 e0 08             	shl    $0x8,%eax
80103f7a:	09 d0                	or     %edx,%eax
80103f7c:	c1 e0 04             	shl    $0x4,%eax
80103f7f:	75 1b                	jne    80103f9c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103f81:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f88:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f8f:	c1 e0 08             	shl    $0x8,%eax
80103f92:	09 d0                	or     %edx,%eax
80103f94:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103f97:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103f9c:	ba 00 04 00 00       	mov    $0x400,%edx
80103fa1:	e8 3a ff ff ff       	call   80103ee0 <mpsearch1>
80103fa6:	89 c3                	mov    %eax,%ebx
80103fa8:	85 c0                	test   %eax,%eax
80103faa:	0f 84 70 01 00 00    	je     80104120 <mpinit+0x1c0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103fb0:	8b 73 04             	mov    0x4(%ebx),%esi
80103fb3:	85 f6                	test   %esi,%esi
80103fb5:	0f 84 55 01 00 00    	je     80104110 <mpinit+0x1b0>
  if(memcmp(conf, "PCMP", 4) != 0)
80103fbb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103fbe:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103fc4:	6a 04                	push   $0x4
80103fc6:	68 bd 9e 10 80       	push   $0x80109ebd
80103fcb:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103fcc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103fcf:	e8 3c 23 00 00       	call   80106310 <memcmp>
80103fd4:	83 c4 10             	add    $0x10,%esp
80103fd7:	85 c0                	test   %eax,%eax
80103fd9:	0f 85 31 01 00 00    	jne    80104110 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103fdf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103fe6:	3c 01                	cmp    $0x1,%al
80103fe8:	74 08                	je     80103ff2 <mpinit+0x92>
80103fea:	3c 04                	cmp    $0x4,%al
80103fec:	0f 85 1e 01 00 00    	jne    80104110 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
80103ff2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103ff9:	66 85 d2             	test   %dx,%dx
80103ffc:	74 22                	je     80104020 <mpinit+0xc0>
80103ffe:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80104001:	89 f0                	mov    %esi,%eax
  sum = 0;
80104003:	31 d2                	xor    %edx,%edx
80104005:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104008:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010400f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80104012:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80104014:	39 c7                	cmp    %eax,%edi
80104016:	75 f0                	jne    80104008 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80104018:	84 d2                	test   %dl,%dl
8010401a:	0f 85 f0 00 00 00    	jne    80104110 <mpinit+0x1b0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80104020:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80104026:	89 5d e0             	mov    %ebx,-0x20(%ebp)
  ismp = 1;
80104029:	bf 01 00 00 00       	mov    $0x1,%edi
  lapic = (uint*)conf->lapicaddr;
8010402e:	a3 20 4d 11 80       	mov    %eax,0x80114d20
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104033:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80104039:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
80104040:	03 4d e4             	add    -0x1c(%ebp),%ecx
80104043:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104047:	90                   	nop
80104048:	39 c8                	cmp    %ecx,%eax
8010404a:	73 15                	jae    80104061 <mpinit+0x101>
    switch(*p){
8010404c:	0f b6 10             	movzbl (%eax),%edx
8010404f:	80 fa 02             	cmp    $0x2,%dl
80104052:	74 4c                	je     801040a0 <mpinit+0x140>
80104054:	77 3a                	ja     80104090 <mpinit+0x130>
80104056:	84 d2                	test   %dl,%dl
80104058:	74 56                	je     801040b0 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010405a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010405d:	39 c8                	cmp    %ecx,%eax
8010405f:	72 eb                	jb     8010404c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104061:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80104064:	85 ff                	test   %edi,%edi
80104066:	0f 84 09 01 00 00    	je     80104175 <mpinit+0x215>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010406c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104070:	74 15                	je     80104087 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104072:	b8 70 00 00 00       	mov    $0x70,%eax
80104077:	ba 22 00 00 00       	mov    $0x22,%edx
8010407c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010407d:	ba 23 00 00 00       	mov    $0x23,%edx
80104082:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104083:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104086:	ee                   	out    %al,(%dx)
  }
}
80104087:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010408a:	5b                   	pop    %ebx
8010408b:	5e                   	pop    %esi
8010408c:	5f                   	pop    %edi
8010408d:	5d                   	pop    %ebp
8010408e:	c3                   	ret    
8010408f:	90                   	nop
    switch(*p){
80104090:	83 ea 03             	sub    $0x3,%edx
80104093:	80 fa 01             	cmp    $0x1,%dl
80104096:	76 c2                	jbe    8010405a <mpinit+0xfa>
80104098:	31 ff                	xor    %edi,%edi
8010409a:	eb ac                	jmp    80104048 <mpinit+0xe8>
8010409c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801040a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801040a4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801040a7:	88 15 20 4e 11 80    	mov    %dl,0x80114e20
      continue;
801040ad:	eb 99                	jmp    80104048 <mpinit+0xe8>
801040af:	90                   	nop
      if(ncpu < NCPU) {
801040b0:	8b 35 24 4e 11 80    	mov    0x80114e24,%esi
801040b6:	83 fe 07             	cmp    $0x7,%esi
801040b9:	7f 47                	jg     80104102 <mpinit+0x1a2>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801040bb:	8d 14 76             	lea    (%esi,%esi,2),%edx
801040be:	c1 e2 06             	shl    $0x6,%edx
801040c1:	89 d3                	mov    %edx,%ebx
801040c3:	8d 92 40 4e 11 80    	lea    -0x7feeb1c0(%edx),%edx
801040c9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801040cc:	89 da                	mov    %ebx,%edx
801040ce:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
801040d2:	88 9a 40 4e 11 80    	mov    %bl,-0x7feeb1c0(%edx)
        cpus[ncpu].rr = 30;
801040d8:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
        ncpu++;
801040db:	8d 56 01             	lea    0x1(%esi),%edx
801040de:	89 15 24 4e 11 80    	mov    %edx,0x80114e24
        cpus[ncpu].rr = 30;
801040e4:	c7 83 b0 00 00 00 1e 	movl   $0x1e,0xb0(%ebx)
801040eb:	00 00 00 
        cpus[ncpu].sjf = 20;
801040ee:	c7 83 b4 00 00 00 14 	movl   $0x14,0xb4(%ebx)
801040f5:	00 00 00 
        cpus[ncpu].fcfs = 10;
801040f8:	c7 83 b8 00 00 00 0a 	movl   $0xa,0xb8(%ebx)
801040ff:	00 00 00 
      p += sizeof(struct mpproc);
80104102:	83 c0 14             	add    $0x14,%eax
      continue;
80104105:	e9 3e ff ff ff       	jmp    80104048 <mpinit+0xe8>
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80104110:	83 ec 0c             	sub    $0xc,%esp
80104113:	68 c2 9e 10 80       	push   $0x80109ec2
80104118:	e8 d3 c3 ff ff       	call   801004f0 <panic>
8010411d:	8d 76 00             	lea    0x0(%esi),%esi
{
80104120:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80104125:	eb 13                	jmp    8010413a <mpinit+0x1da>
80104127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010412e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80104130:	89 f3                	mov    %esi,%ebx
80104132:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104138:	74 d6                	je     80104110 <mpinit+0x1b0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010413a:	83 ec 04             	sub    $0x4,%esp
8010413d:	8d 73 10             	lea    0x10(%ebx),%esi
80104140:	6a 04                	push   $0x4
80104142:	68 b8 9e 10 80       	push   $0x80109eb8
80104147:	53                   	push   %ebx
80104148:	e8 c3 21 00 00       	call   80106310 <memcmp>
8010414d:	83 c4 10             	add    $0x10,%esp
80104150:	85 c0                	test   %eax,%eax
80104152:	75 dc                	jne    80104130 <mpinit+0x1d0>
80104154:	89 da                	mov    %ebx,%edx
80104156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010415d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104160:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80104163:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80104166:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104168:	39 d6                	cmp    %edx,%esi
8010416a:	75 f4                	jne    80104160 <mpinit+0x200>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010416c:	84 c0                	test   %al,%al
8010416e:	75 c0                	jne    80104130 <mpinit+0x1d0>
80104170:	e9 3b fe ff ff       	jmp    80103fb0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80104175:	83 ec 0c             	sub    $0xc,%esp
80104178:	68 dc 9e 10 80       	push   $0x80109edc
8010417d:	e8 6e c3 ff ff       	call   801004f0 <panic>
80104182:	66 90                	xchg   %ax,%ax
80104184:	66 90                	xchg   %ax,%ax
80104186:	66 90                	xchg   %ax,%ax
80104188:	66 90                	xchg   %ax,%ax
8010418a:	66 90                	xchg   %ax,%ax
8010418c:	66 90                	xchg   %ax,%ax
8010418e:	66 90                	xchg   %ax,%ax

80104190 <picinit>:
80104190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104195:	ba 21 00 00 00       	mov    $0x21,%edx
8010419a:	ee                   	out    %al,(%dx)
8010419b:	ba a1 00 00 00       	mov    $0xa1,%edx
801041a0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801041a1:	c3                   	ret    
801041a2:	66 90                	xchg   %ax,%ax
801041a4:	66 90                	xchg   %ax,%ax
801041a6:	66 90                	xchg   %ax,%ax
801041a8:	66 90                	xchg   %ax,%ax
801041aa:	66 90                	xchg   %ax,%ax
801041ac:	66 90                	xchg   %ax,%ax
801041ae:	66 90                	xchg   %ax,%ax

801041b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	57                   	push   %edi
801041b4:	56                   	push   %esi
801041b5:	53                   	push   %ebx
801041b6:	83 ec 0c             	sub    $0xc,%esp
801041b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801041bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801041bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801041c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801041cb:	e8 90 d9 ff ff       	call   80101b60 <filealloc>
801041d0:	89 03                	mov    %eax,(%ebx)
801041d2:	85 c0                	test   %eax,%eax
801041d4:	0f 84 a8 00 00 00    	je     80104282 <pipealloc+0xd2>
801041da:	e8 81 d9 ff ff       	call   80101b60 <filealloc>
801041df:	89 06                	mov    %eax,(%esi)
801041e1:	85 c0                	test   %eax,%eax
801041e3:	0f 84 87 00 00 00    	je     80104270 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801041e9:	e8 d2 f1 ff ff       	call   801033c0 <kalloc>
801041ee:	89 c7                	mov    %eax,%edi
801041f0:	85 c0                	test   %eax,%eax
801041f2:	0f 84 b0 00 00 00    	je     801042a8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801041f8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801041ff:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104202:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104205:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010420c:	00 00 00 
  p->nwrite = 0;
8010420f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104216:	00 00 00 
  p->nread = 0;
80104219:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104220:	00 00 00 
  initlock(&p->lock, "pipe");
80104223:	68 fb 9e 10 80       	push   $0x80109efb
80104228:	50                   	push   %eax
80104229:	e8 02 1e 00 00       	call   80106030 <initlock>
  (*f0)->type = FD_PIPE;
8010422e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104230:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104233:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104239:	8b 03                	mov    (%ebx),%eax
8010423b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010423f:	8b 03                	mov    (%ebx),%eax
80104241:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104245:	8b 03                	mov    (%ebx),%eax
80104247:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010424a:	8b 06                	mov    (%esi),%eax
8010424c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104252:	8b 06                	mov    (%esi),%eax
80104254:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104258:	8b 06                	mov    (%esi),%eax
8010425a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010425e:	8b 06                	mov    (%esi),%eax
80104260:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104263:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104266:	31 c0                	xor    %eax,%eax
}
80104268:	5b                   	pop    %ebx
80104269:	5e                   	pop    %esi
8010426a:	5f                   	pop    %edi
8010426b:	5d                   	pop    %ebp
8010426c:	c3                   	ret    
8010426d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80104270:	8b 03                	mov    (%ebx),%eax
80104272:	85 c0                	test   %eax,%eax
80104274:	74 1e                	je     80104294 <pipealloc+0xe4>
    fileclose(*f0);
80104276:	83 ec 0c             	sub    $0xc,%esp
80104279:	50                   	push   %eax
8010427a:	e8 a1 d9 ff ff       	call   80101c20 <fileclose>
8010427f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104282:	8b 06                	mov    (%esi),%eax
80104284:	85 c0                	test   %eax,%eax
80104286:	74 0c                	je     80104294 <pipealloc+0xe4>
    fileclose(*f1);
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	50                   	push   %eax
8010428c:	e8 8f d9 ff ff       	call   80101c20 <fileclose>
80104291:	83 c4 10             	add    $0x10,%esp
}
80104294:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104297:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010429c:	5b                   	pop    %ebx
8010429d:	5e                   	pop    %esi
8010429e:	5f                   	pop    %edi
8010429f:	5d                   	pop    %ebp
801042a0:	c3                   	ret    
801042a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801042a8:	8b 03                	mov    (%ebx),%eax
801042aa:	85 c0                	test   %eax,%eax
801042ac:	75 c8                	jne    80104276 <pipealloc+0xc6>
801042ae:	eb d2                	jmp    80104282 <pipealloc+0xd2>

801042b0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	56                   	push   %esi
801042b4:	53                   	push   %ebx
801042b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801042bb:	83 ec 0c             	sub    $0xc,%esp
801042be:	53                   	push   %ebx
801042bf:	e8 3c 1f 00 00       	call   80106200 <acquire>
  if(writable){
801042c4:	83 c4 10             	add    $0x10,%esp
801042c7:	85 f6                	test   %esi,%esi
801042c9:	74 65                	je     80104330 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801042cb:	83 ec 0c             	sub    $0xc,%esp
801042ce:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801042d4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801042db:	00 00 00 
    wakeup(&p->nread);
801042de:	50                   	push   %eax
801042df:	e8 5c 11 00 00       	call   80105440 <wakeup>
801042e4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801042e7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801042ed:	85 d2                	test   %edx,%edx
801042ef:	75 0a                	jne    801042fb <pipeclose+0x4b>
801042f1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801042f7:	85 c0                	test   %eax,%eax
801042f9:	74 15                	je     80104310 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801042fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801042fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104301:	5b                   	pop    %ebx
80104302:	5e                   	pop    %esi
80104303:	5d                   	pop    %ebp
    release(&p->lock);
80104304:	e9 97 1e 00 00       	jmp    801061a0 <release>
80104309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104310:	83 ec 0c             	sub    $0xc,%esp
80104313:	53                   	push   %ebx
80104314:	e8 87 1e 00 00       	call   801061a0 <release>
    kfree((char*)p);
80104319:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010431c:	83 c4 10             	add    $0x10,%esp
}
8010431f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104322:	5b                   	pop    %ebx
80104323:	5e                   	pop    %esi
80104324:	5d                   	pop    %ebp
    kfree((char*)p);
80104325:	e9 d6 ee ff ff       	jmp    80103200 <kfree>
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104330:	83 ec 0c             	sub    $0xc,%esp
80104333:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104339:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104340:	00 00 00 
    wakeup(&p->nwrite);
80104343:	50                   	push   %eax
80104344:	e8 f7 10 00 00       	call   80105440 <wakeup>
80104349:	83 c4 10             	add    $0x10,%esp
8010434c:	eb 99                	jmp    801042e7 <pipeclose+0x37>
8010434e:	66 90                	xchg   %ax,%ax

80104350 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	57                   	push   %edi
80104354:	56                   	push   %esi
80104355:	53                   	push   %ebx
80104356:	83 ec 28             	sub    $0x28,%esp
80104359:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010435c:	53                   	push   %ebx
8010435d:	e8 9e 1e 00 00       	call   80106200 <acquire>
  for(i = 0; i < n; i++){
80104362:	8b 45 10             	mov    0x10(%ebp),%eax
80104365:	83 c4 10             	add    $0x10,%esp
80104368:	85 c0                	test   %eax,%eax
8010436a:	0f 8e c0 00 00 00    	jle    80104430 <pipewrite+0xe0>
80104370:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104373:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104379:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010437f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104382:	03 45 10             	add    0x10(%ebp),%eax
80104385:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104388:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010438e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104394:	89 ca                	mov    %ecx,%edx
80104396:	05 00 02 00 00       	add    $0x200,%eax
8010439b:	39 c1                	cmp    %eax,%ecx
8010439d:	74 42                	je     801043e1 <pipewrite+0x91>
8010439f:	eb 67                	jmp    80104408 <pipewrite+0xb8>
801043a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801043a8:	e8 d3 03 00 00       	call   80104780 <myproc>
801043ad:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
801043b3:	85 c9                	test   %ecx,%ecx
801043b5:	75 34                	jne    801043eb <pipewrite+0x9b>
      wakeup(&p->nread);
801043b7:	83 ec 0c             	sub    $0xc,%esp
801043ba:	57                   	push   %edi
801043bb:	e8 80 10 00 00       	call   80105440 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801043c0:	58                   	pop    %eax
801043c1:	5a                   	pop    %edx
801043c2:	53                   	push   %ebx
801043c3:	56                   	push   %esi
801043c4:	e8 a7 0f 00 00       	call   80105370 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043c9:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801043cf:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801043d5:	83 c4 10             	add    $0x10,%esp
801043d8:	05 00 02 00 00       	add    $0x200,%eax
801043dd:	39 c2                	cmp    %eax,%edx
801043df:	75 27                	jne    80104408 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801043e1:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801043e7:	85 c0                	test   %eax,%eax
801043e9:	75 bd                	jne    801043a8 <pipewrite+0x58>
        release(&p->lock);
801043eb:	83 ec 0c             	sub    $0xc,%esp
801043ee:	53                   	push   %ebx
801043ef:	e8 ac 1d 00 00       	call   801061a0 <release>
        return -1;
801043f4:	83 c4 10             	add    $0x10,%esp
801043f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801043fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043ff:	5b                   	pop    %ebx
80104400:	5e                   	pop    %esi
80104401:	5f                   	pop    %edi
80104402:	5d                   	pop    %ebp
80104403:	c3                   	ret    
80104404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104408:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010440b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010440e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104414:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010441a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010441d:	83 c6 01             	add    $0x1,%esi
80104420:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104423:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104427:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010442a:	0f 85 58 ff ff ff    	jne    80104388 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104430:	83 ec 0c             	sub    $0xc,%esp
80104433:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104439:	50                   	push   %eax
8010443a:	e8 01 10 00 00       	call   80105440 <wakeup>
  release(&p->lock);
8010443f:	89 1c 24             	mov    %ebx,(%esp)
80104442:	e8 59 1d 00 00       	call   801061a0 <release>
  return n;
80104447:	8b 45 10             	mov    0x10(%ebp),%eax
8010444a:	83 c4 10             	add    $0x10,%esp
8010444d:	eb ad                	jmp    801043fc <pipewrite+0xac>
8010444f:	90                   	nop

80104450 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	57                   	push   %edi
80104454:	56                   	push   %esi
80104455:	53                   	push   %ebx
80104456:	83 ec 18             	sub    $0x18,%esp
80104459:	8b 75 08             	mov    0x8(%ebp),%esi
8010445c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010445f:	56                   	push   %esi
80104460:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104466:	e8 95 1d 00 00       	call   80106200 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010446b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104471:	83 c4 10             	add    $0x10,%esp
80104474:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010447a:	74 32                	je     801044ae <piperead+0x5e>
8010447c:	eb 3a                	jmp    801044b8 <piperead+0x68>
8010447e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104480:	e8 fb 02 00 00       	call   80104780 <myproc>
80104485:	8b 88 90 00 00 00    	mov    0x90(%eax),%ecx
8010448b:	85 c9                	test   %ecx,%ecx
8010448d:	0f 85 8d 00 00 00    	jne    80104520 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104493:	83 ec 08             	sub    $0x8,%esp
80104496:	56                   	push   %esi
80104497:	53                   	push   %ebx
80104498:	e8 d3 0e 00 00       	call   80105370 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010449d:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
801044a3:	83 c4 10             	add    $0x10,%esp
801044a6:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
801044ac:	75 0a                	jne    801044b8 <piperead+0x68>
801044ae:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801044b4:	85 c0                	test   %eax,%eax
801044b6:	75 c8                	jne    80104480 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801044b8:	8b 55 10             	mov    0x10(%ebp),%edx
801044bb:	31 db                	xor    %ebx,%ebx
801044bd:	85 d2                	test   %edx,%edx
801044bf:	7f 25                	jg     801044e6 <piperead+0x96>
801044c1:	eb 31                	jmp    801044f4 <piperead+0xa4>
801044c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044c7:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801044c8:	8d 48 01             	lea    0x1(%eax),%ecx
801044cb:	25 ff 01 00 00       	and    $0x1ff,%eax
801044d0:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801044d6:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801044db:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801044de:	83 c3 01             	add    $0x1,%ebx
801044e1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801044e4:	74 0e                	je     801044f4 <piperead+0xa4>
    if(p->nread == p->nwrite)
801044e6:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801044ec:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801044f2:	75 d4                	jne    801044c8 <piperead+0x78>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801044f4:	83 ec 0c             	sub    $0xc,%esp
801044f7:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801044fd:	50                   	push   %eax
801044fe:	e8 3d 0f 00 00       	call   80105440 <wakeup>
  release(&p->lock);
80104503:	89 34 24             	mov    %esi,(%esp)
80104506:	e8 95 1c 00 00       	call   801061a0 <release>
  return i;
8010450b:	83 c4 10             	add    $0x10,%esp
}
8010450e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104511:	89 d8                	mov    %ebx,%eax
80104513:	5b                   	pop    %ebx
80104514:	5e                   	pop    %esi
80104515:	5f                   	pop    %edi
80104516:	5d                   	pop    %ebp
80104517:	c3                   	ret    
80104518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop
      release(&p->lock);
80104520:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104523:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104528:	56                   	push   %esi
80104529:	e8 72 1c 00 00       	call   801061a0 <release>
      return -1;
8010452e:	83 c4 10             	add    $0x10,%esp
}
80104531:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104534:	89 d8                	mov    %ebx,%eax
80104536:	5b                   	pop    %ebx
80104537:	5e                   	pop    %esi
80104538:	5f                   	pop    %edi
80104539:	5d                   	pop    %ebp
8010453a:	c3                   	ret    
8010453b:	66 90                	xchg   %ax,%ax
8010453d:	66 90                	xchg   %ax,%ax
8010453f:	90                   	nop

80104540 <allocproc>:
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.
static struct proc *
allocproc(void)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104544:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
{
80104549:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010454c:	68 80 54 11 80       	push   $0x80115480
80104551:	e8 aa 1c 00 00       	call   80106200 <acquire>
80104556:	83 c4 10             	add    $0x10,%esp
80104559:	eb 17                	jmp    80104572 <allocproc+0x32>
8010455b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010455f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104560:	81 c3 14 01 00 00    	add    $0x114,%ebx
80104566:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
8010456c:	0f 84 de 00 00 00    	je     80104650 <allocproc+0x110>
    if (p->state == UNUSED)
80104572:	8b 43 78             	mov    0x78(%ebx),%eax
80104575:	85 c0                	test   %eax,%eax
80104577:	75 e7                	jne    80104560 <allocproc+0x20>
80104579:	89 d8                	mov    %ebx,%eax
8010457b:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010457e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
  return 0;

found:
  for (int i = 0; i < MAX_SYSCALLS; i++)
    p->syscalls[i] = 0;
80104580:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for (int i = 0; i < MAX_SYSCALLS; i++)
80104586:	83 c0 04             	add    $0x4,%eax
80104589:	39 c2                	cmp    %eax,%edx
8010458b:	75 f3                	jne    80104580 <allocproc+0x40>
  p->state = EMBRYO;
  p->pid = nextpid++;
8010458d:	a1 04 d0 10 80       	mov    0x8010d004,%eax

  release(&ptable.lock);
80104592:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80104595:	c7 43 78 01 00 00 00 	movl   $0x1,0x78(%ebx)
  p->pid = nextpid++;
8010459c:	89 43 7c             	mov    %eax,0x7c(%ebx)
8010459f:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801045a2:	68 80 54 11 80       	push   $0x80115480
  p->pid = nextpid++;
801045a7:	89 15 04 d0 10 80    	mov    %edx,0x8010d004
  release(&ptable.lock);
801045ad:	e8 ee 1b 00 00       	call   801061a0 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
801045b2:	e8 09 ee ff ff       	call   801033c0 <kalloc>
801045b7:	83 c4 10             	add    $0x10,%esp
801045ba:	89 43 74             	mov    %eax,0x74(%ebx)
801045bd:	85 c0                	test   %eax,%eax
801045bf:	0f 84 a4 00 00 00    	je     80104669 <allocproc+0x129>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801045c5:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
801045cb:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801045ce:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801045d3:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
  *(uint *)sp = (uint)trapret;
801045d9:	c7 40 14 a0 7a 10 80 	movl   $0x80107aa0,0x14(%eax)
  p->context = (struct context *)sp;
801045e0:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  memset(p->context, 0, sizeof *p->context);
801045e6:	6a 14                	push   $0x14
801045e8:	6a 00                	push   $0x0
801045ea:	50                   	push   %eax
801045eb:	e8 d0 1c 00 00       	call   801062c0 <memset>
  p->context->eip = (uint)forkret;
801045f0:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
  p->sched_info.level = FCFS;
  p->sched_info.num_of_cycles = 0;
  


  return p;
801045f6:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801045f9:	c7 40 10 80 46 10 80 	movl   $0x80104680,0x10(%eax)
  p->sched_info.creation_time = ticks;
80104600:	a1 c4 99 11 80       	mov    0x801199c4,%eax
  p->sched_info.burst_time = 2;
80104605:	c7 83 f4 00 00 00 02 	movl   $0x2,0xf4(%ebx)
8010460c:	00 00 00 
  p->sched_info.creation_time = ticks;
8010460f:	89 83 fc 00 00 00    	mov    %eax,0xfc(%ebx)
  p->sched_info.enter_level_time = ticks;
80104615:	89 83 00 01 00 00    	mov    %eax,0x100(%ebx)
}
8010461b:	89 d8                	mov    %ebx,%eax
  p->sched_info.confidence = 50;
8010461d:	c7 83 04 01 00 00 32 	movl   $0x32,0x104(%ebx)
80104624:	00 00 00 
  p->sched_info.last_exe_time = 0;
80104627:	c7 83 f8 00 00 00 00 	movl   $0x0,0xf8(%ebx)
8010462e:	00 00 00 
  p->sched_info.level = FCFS;
80104631:	c7 83 f0 00 00 00 02 	movl   $0x2,0xf0(%ebx)
80104638:	00 00 00 
  p->sched_info.num_of_cycles = 0;
8010463b:	c7 83 08 01 00 00 00 	movl   $0x0,0x108(%ebx)
80104642:	00 00 00 
}
80104645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104648:	c9                   	leave  
80104649:	c3                   	ret    
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104650:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104653:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104655:	68 80 54 11 80       	push   $0x80115480
8010465a:	e8 41 1b 00 00       	call   801061a0 <release>
}
8010465f:	89 d8                	mov    %ebx,%eax
  return 0;
80104661:	83 c4 10             	add    $0x10,%esp
}
80104664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104667:	c9                   	leave  
80104668:	c3                   	ret    
    p->state = UNUSED;
80104669:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return 0;
80104670:	31 db                	xor    %ebx,%ebx
}
80104672:	89 d8                	mov    %ebx,%eax
80104674:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104677:	c9                   	leave  
80104678:	c3                   	ret    
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104680 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104686:	68 80 54 11 80       	push   $0x80115480
8010468b:	e8 10 1b 00 00       	call   801061a0 <release>

  if (first)
80104690:	a1 00 d0 10 80       	mov    0x8010d000,%eax
80104695:	83 c4 10             	add    $0x10,%esp
80104698:	85 c0                	test   %eax,%eax
8010469a:	75 04                	jne    801046a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010469c:	c9                   	leave  
8010469d:	c3                   	ret    
8010469e:	66 90                	xchg   %ax,%ax
    first = 0;
801046a0:	c7 05 00 d0 10 80 00 	movl   $0x0,0x8010d000
801046a7:	00 00 00 
    iinit(ROOTDEV);
801046aa:	83 ec 0c             	sub    $0xc,%esp
801046ad:	6a 01                	push   $0x1
801046af:	e8 dc db ff ff       	call   80102290 <iinit>
    initlog(ROOTDEV);
801046b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801046bb:	e8 40 f3 ff ff       	call   80103a00 <initlog>
}
801046c0:	83 c4 10             	add    $0x10,%esp
801046c3:	c9                   	leave  
801046c4:	c3                   	ret    
801046c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046d0 <pinit>:
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	83 ec 08             	sub    $0x8,%esp
  init_sharedmem();
801046d6:	e8 25 4f 00 00       	call   80109600 <init_sharedmem>
  initlock(&ptable.lock, "ptable");
801046db:	83 ec 08             	sub    $0x8,%esp
801046de:	68 00 9f 10 80       	push   $0x80109f00
801046e3:	68 80 54 11 80       	push   $0x80115480
801046e8:	e8 43 19 00 00       	call   80106030 <initlock>
}
801046ed:	83 c4 10             	add    $0x10,%esp
801046f0:	c9                   	leave  
801046f1:	c3                   	ret    
801046f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104700 <mycpu>:
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104705:	9c                   	pushf  
80104706:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80104707:	f6 c4 02             	test   $0x2,%ah
8010470a:	75 46                	jne    80104752 <mycpu+0x52>
  apicid = lapicid();
8010470c:	e8 1f ef ff ff       	call   80103630 <lapicid>
  for (i = 0; i < ncpu; ++i)
80104711:	8b 35 24 4e 11 80    	mov    0x80114e24,%esi
80104717:	85 f6                	test   %esi,%esi
80104719:	7e 2a                	jle    80104745 <mycpu+0x45>
8010471b:	31 d2                	xor    %edx,%edx
8010471d:	eb 08                	jmp    80104727 <mycpu+0x27>
8010471f:	90                   	nop
80104720:	83 c2 01             	add    $0x1,%edx
80104723:	39 f2                	cmp    %esi,%edx
80104725:	74 1e                	je     80104745 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104727:	8d 0c 52             	lea    (%edx,%edx,2),%ecx
8010472a:	c1 e1 06             	shl    $0x6,%ecx
8010472d:	0f b6 99 40 4e 11 80 	movzbl -0x7feeb1c0(%ecx),%ebx
80104734:	39 c3                	cmp    %eax,%ebx
80104736:	75 e8                	jne    80104720 <mycpu+0x20>
}
80104738:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010473b:	8d 81 40 4e 11 80    	lea    -0x7feeb1c0(%ecx),%eax
}
80104741:	5b                   	pop    %ebx
80104742:	5e                   	pop    %esi
80104743:	5d                   	pop    %ebp
80104744:	c3                   	ret    
  panic("unknown apicid\n");
80104745:	83 ec 0c             	sub    $0xc,%esp
80104748:	68 07 9f 10 80       	push   $0x80109f07
8010474d:	e8 9e bd ff ff       	call   801004f0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104752:	83 ec 0c             	sub    $0xc,%esp
80104755:	68 6c a0 10 80       	push   $0x8010a06c
8010475a:	e8 91 bd ff ff       	call   801004f0 <panic>
8010475f:	90                   	nop

80104760 <cpuid>:
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80104766:	e8 95 ff ff ff       	call   80104700 <mycpu>
}
8010476b:	c9                   	leave  
  return mycpu() - cpus;
8010476c:	2d 40 4e 11 80       	sub    $0x80114e40,%eax
80104771:	c1 f8 06             	sar    $0x6,%eax
80104774:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
}
8010477a:	c3                   	ret    
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop

80104780 <myproc>:
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104787:	e8 24 19 00 00       	call   801060b0 <pushcli>
  c = mycpu();
8010478c:	e8 6f ff ff ff       	call   80104700 <mycpu>
  p = c->proc;
80104791:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104797:	e8 64 19 00 00       	call   80106100 <popcli>
}
8010479c:	89 d8                	mov    %ebx,%eax
8010479e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047a1:	c9                   	leave  
801047a2:	c3                   	ret    
801047a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <findproc>:
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 75 08             	mov    0x8(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047b8:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
  acquire(&ptable.lock);
801047bd:	83 ec 0c             	sub    $0xc,%esp
801047c0:	68 80 54 11 80       	push   $0x80115480
801047c5:	e8 36 1a 00 00       	call   80106200 <acquire>
801047ca:	83 c4 10             	add    $0x10,%esp
801047cd:	eb 0f                	jmp    801047de <findproc+0x2e>
801047cf:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047d0:	81 c3 14 01 00 00    	add    $0x114,%ebx
801047d6:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
801047dc:	74 22                	je     80104800 <findproc+0x50>
    if (p->pid == pid)
801047de:	39 73 7c             	cmp    %esi,0x7c(%ebx)
801047e1:	75 ed                	jne    801047d0 <findproc+0x20>
      release(&ptable.lock); // Release the lock before returning.
801047e3:	83 ec 0c             	sub    $0xc,%esp
801047e6:	68 80 54 11 80       	push   $0x80115480
801047eb:	e8 b0 19 00 00       	call   801061a0 <release>
      return p;
801047f0:	83 c4 10             	add    $0x10,%esp
}
801047f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047f6:	89 d8                	mov    %ebx,%eax
801047f8:	5b                   	pop    %ebx
801047f9:	5e                   	pop    %esi
801047fa:	5d                   	pop    %ebp
801047fb:	c3                   	ret    
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104800:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104803:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104805:	68 80 54 11 80       	push   $0x80115480
8010480a:	e8 91 19 00 00       	call   801061a0 <release>
  return 0;
8010480f:	83 c4 10             	add    $0x10,%esp
}
80104812:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104815:	89 d8                	mov    %ebx,%eax
80104817:	5b                   	pop    %ebx
80104818:	5e                   	pop    %esi
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    
8010481b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010481f:	90                   	nop

80104820 <growproc>:
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104828:	e8 83 18 00 00       	call   801060b0 <pushcli>
  c = mycpu();
8010482d:	e8 ce fe ff ff       	call   80104700 <mycpu>
  p = c->proc;
80104832:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104838:	e8 c3 18 00 00       	call   80106100 <popcli>
  sz = curproc->sz;
8010483d:	8b 43 6c             	mov    0x6c(%ebx),%eax
  if (n > 0)
80104840:	85 f6                	test   %esi,%esi
80104842:	7f 1c                	jg     80104860 <growproc+0x40>
  else if (n < 0)
80104844:	75 3a                	jne    80104880 <growproc+0x60>
  switchuvm(curproc);
80104846:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104849:	89 43 6c             	mov    %eax,0x6c(%ebx)
  switchuvm(curproc);
8010484c:	53                   	push   %ebx
8010484d:	e8 fe 45 00 00       	call   80108e50 <switchuvm>
  return 0;
80104852:	83 c4 10             	add    $0x10,%esp
80104855:	31 c0                	xor    %eax,%eax
}
80104857:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010485a:	5b                   	pop    %ebx
8010485b:	5e                   	pop    %esi
8010485c:	5d                   	pop    %ebp
8010485d:	c3                   	ret    
8010485e:	66 90                	xchg   %ax,%ax
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104860:	83 ec 04             	sub    $0x4,%esp
80104863:	01 c6                	add    %eax,%esi
80104865:	56                   	push   %esi
80104866:	50                   	push   %eax
80104867:	ff 73 70             	push   0x70(%ebx)
8010486a:	e8 61 48 00 00       	call   801090d0 <allocuvm>
8010486f:	83 c4 10             	add    $0x10,%esp
80104872:	85 c0                	test   %eax,%eax
80104874:	75 d0                	jne    80104846 <growproc+0x26>
      return -1;
80104876:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010487b:	eb da                	jmp    80104857 <growproc+0x37>
8010487d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104880:	83 ec 04             	sub    $0x4,%esp
80104883:	01 c6                	add    %eax,%esi
80104885:	56                   	push   %esi
80104886:	50                   	push   %eax
80104887:	ff 73 70             	push   0x70(%ebx)
8010488a:	e8 71 49 00 00       	call   80109200 <deallocuvm>
8010488f:	83 c4 10             	add    $0x10,%esp
80104892:	85 c0                	test   %eax,%eax
80104894:	75 b0                	jne    80104846 <growproc+0x26>
80104896:	eb de                	jmp    80104876 <growproc+0x56>
80104898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489f:	90                   	nop

801048a0 <create_rand_num>:
  return (ticks*ticks*ticks)%seed;
801048a0:	8b 15 c4 99 11 80    	mov    0x801199c4,%edx
{
801048a6:	55                   	push   %ebp
  return (ticks*ticks*ticks)%seed;
801048a7:	89 d0                	mov    %edx,%eax
801048a9:	0f af c2             	imul   %edx,%eax
{
801048ac:	89 e5                	mov    %esp,%ebp
  return (ticks*ticks*ticks)%seed;
801048ae:	0f af c2             	imul   %edx,%eax
801048b1:	31 d2                	xor    %edx,%edx
801048b3:	f7 75 08             	divl   0x8(%ebp)
}
801048b6:	5d                   	pop    %ebp
801048b7:	89 d0                	mov    %edx,%eax
801048b9:	c3                   	ret    
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048c0 <short_job_first>:
  return (ticks*ticks*ticks)%seed;
801048c0:	a1 c4 99 11 80       	mov    0x801199c4,%eax
801048c5:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
801048ca:	89 c1                	mov    %eax,%ecx
801048cc:	0f af c8             	imul   %eax,%ecx
801048cf:	0f af c8             	imul   %eax,%ecx
801048d2:	89 c8                	mov    %ecx,%eax
801048d4:	f7 e2                	mul    %edx
801048d6:	c1 ea 05             	shr    $0x5,%edx
801048d9:	6b c2 64             	imul   $0x64,%edx,%eax
801048dc:	89 ca                	mov    %ecx,%edx
  struct proc* res=0;
801048de:	31 c9                	xor    %ecx,%ecx
  return (ticks*ticks*ticks)%seed;
801048e0:	29 c2                	sub    %eax,%edx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
801048e2:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
801048e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ee:	66 90                	xchg   %ax,%ax
    if((p->state != RUNNABLE) || (p->sched_info.level!=SJF))
801048f0:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
801048f4:	75 6a                	jne    80104960 <short_job_first+0xa0>
801048f6:	83 b8 f0 00 00 00 01 	cmpl   $0x1,0xf0(%eax)
801048fd:	75 61                	jne    80104960 <short_job_first+0xa0>
    if(res == 0)
801048ff:	85 c9                	test   %ecx,%ecx
80104901:	0f 44 c8             	cmove  %eax,%ecx
    if(p->sched_info.confidence > create_rand_num(100))
80104904:	39 90 04 01 00 00    	cmp    %edx,0x104(%eax)
8010490a:	7e 54                	jle    80104960 <short_job_first+0xa0>
{
8010490c:	55                   	push   %ebp
8010490d:	89 e5                	mov    %esp,%ebp
8010490f:	53                   	push   %ebx
      if(p->sched_info.burst_time < res->sched_info.burst_time)
80104910:	8b 99 f4 00 00 00    	mov    0xf4(%ecx),%ebx
80104916:	39 98 f4 00 00 00    	cmp    %ebx,0xf4(%eax)
8010491c:	0f 4c c8             	cmovl  %eax,%ecx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
8010491f:	05 14 01 00 00       	add    $0x114,%eax
80104924:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
80104929:	74 28                	je     80104953 <short_job_first+0x93>
    if((p->state != RUNNABLE) || (p->sched_info.level!=SJF))
8010492b:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
8010492f:	75 ee                	jne    8010491f <short_job_first+0x5f>
80104931:	83 b8 f0 00 00 00 01 	cmpl   $0x1,0xf0(%eax)
80104938:	75 e5                	jne    8010491f <short_job_first+0x5f>
    if(res == 0)
8010493a:	85 c9                	test   %ecx,%ecx
8010493c:	0f 44 c8             	cmove  %eax,%ecx
    if(p->sched_info.confidence > create_rand_num(100))
8010493f:	39 90 04 01 00 00    	cmp    %edx,0x104(%eax)
80104945:	7f c9                	jg     80104910 <short_job_first+0x50>
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104947:	05 14 01 00 00       	add    $0x114,%eax
8010494c:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
80104951:	75 d8                	jne    8010492b <short_job_first+0x6b>
}
80104953:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104956:	89 c8                	mov    %ecx,%eax
80104958:	c9                   	leave  
80104959:	c3                   	ret    
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104960:	05 14 01 00 00       	add    $0x114,%eax
80104965:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010496a:	75 84                	jne    801048f0 <short_job_first+0x30>
}
8010496c:	89 c8                	mov    %ecx,%eax
8010496e:	c3                   	ret    
8010496f:	90                   	nop

80104970 <first_come_first_service>:
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104970:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
  struct proc* res=0;
80104975:	31 d2                	xor    %edx,%edx
80104977:	eb 23                	jmp    8010499c <first_come_first_service+0x2c>
80104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if(p->sched_info.enter_level_time<res->sched_info.enter_level_time)
80104980:	8b 8a 00 01 00 00    	mov    0x100(%edx),%ecx
80104986:	39 88 00 01 00 00    	cmp    %ecx,0x100(%eax)
8010498c:	0f 42 d0             	cmovb  %eax,%edx
8010498f:	90                   	nop
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104990:	05 14 01 00 00       	add    $0x114,%eax
80104995:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010499a:	74 21                	je     801049bd <first_come_first_service+0x4d>
    if((p->state != RUNNABLE) || (p->sched_info.level!=FCFS))
8010499c:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
801049a0:	75 ee                	jne    80104990 <first_come_first_service+0x20>
801049a2:	83 b8 f0 00 00 00 02 	cmpl   $0x2,0xf0(%eax)
801049a9:	75 e5                	jne    80104990 <first_come_first_service+0x20>
    if(res == 0)
801049ab:	85 d2                	test   %edx,%edx
801049ad:	75 d1                	jne    80104980 <first_come_first_service+0x10>
801049af:	89 c2                	mov    %eax,%edx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
801049b1:	05 14 01 00 00       	add    $0x114,%eax
801049b6:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
801049bb:	75 df                	jne    8010499c <first_come_first_service+0x2c>
}
801049bd:	89 d0                	mov    %edx,%eax
801049bf:	c3                   	ret    

801049c0 <set_level>:
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	8b 75 08             	mov    0x8(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049c8:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
  acquire(&ptable.lock);
801049cd:	83 ec 0c             	sub    $0xc,%esp
801049d0:	68 80 54 11 80       	push   $0x80115480
801049d5:	e8 26 18 00 00       	call   80106200 <acquire>
801049da:	83 c4 10             	add    $0x10,%esp
801049dd:	eb 0f                	jmp    801049ee <set_level+0x2e>
801049df:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049e0:	81 c3 14 01 00 00    	add    $0x114,%ebx
801049e6:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
801049ec:	74 4d                	je     80104a3b <set_level+0x7b>
    if (p->pid == pid)
801049ee:	3b 73 7c             	cmp    0x7c(%ebx),%esi
801049f1:	75 ed                	jne    801049e0 <set_level+0x20>
      release(&ptable.lock); // Release the lock before returning.
801049f3:	83 ec 0c             	sub    $0xc,%esp
801049f6:	68 80 54 11 80       	push   $0x80115480
801049fb:	e8 a0 17 00 00       	call   801061a0 <release>
  acquire(&ptable.lock);
80104a00:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104a07:	e8 f4 17 00 00       	call   80106200 <acquire>
  p->sched_info.level = target_level;
80104a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int old_queue = p->sched_info.level;
80104a0f:	8b b3 f0 00 00 00    	mov    0xf0(%ebx),%esi
  release(&ptable.lock);
80104a15:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
  p->sched_info.level = target_level;
80104a1c:	89 83 f0 00 00 00    	mov    %eax,0xf0(%ebx)
  p->sched_info.enter_level_time = ticks;
80104a22:	a1 c4 99 11 80       	mov    0x801199c4,%eax
80104a27:	89 83 00 01 00 00    	mov    %eax,0x100(%ebx)
  release(&ptable.lock);
80104a2d:	e8 6e 17 00 00       	call   801061a0 <release>
}
80104a32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a35:	89 f0                	mov    %esi,%eax
80104a37:	5b                   	pop    %ebx
80104a38:	5e                   	pop    %esi
80104a39:	5d                   	pop    %ebp
80104a3a:	c3                   	ret    
  release(&ptable.lock);
80104a3b:	83 ec 0c             	sub    $0xc,%esp
80104a3e:	68 80 54 11 80       	push   $0x80115480
80104a43:	e8 58 17 00 00       	call   801061a0 <release>
  acquire(&ptable.lock);
80104a48:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104a4f:	e8 ac 17 00 00       	call   80106200 <acquire>
  int old_queue = p->sched_info.level;
80104a54:	a1 f0 00 00 00       	mov    0xf0,%eax
80104a59:	0f 0b                	ud2    
80104a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a5f:	90                   	nop

80104a60 <userinit>:
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104a67:	e8 d4 fa ff ff       	call   80104540 <allocproc>
80104a6c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104a6e:	a3 b4 99 11 80       	mov    %eax,0x801199b4
  if ((p->pgdir = setupkvm()) == 0)
80104a73:	e8 38 48 00 00       	call   801092b0 <setupkvm>
80104a78:	89 43 70             	mov    %eax,0x70(%ebx)
80104a7b:	85 c0                	test   %eax,%eax
80104a7d:	0f 84 e8 00 00 00    	je     80104b6b <userinit+0x10b>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104a83:	83 ec 04             	sub    $0x4,%esp
80104a86:	68 2c 00 00 00       	push   $0x2c
80104a8b:	68 c0 d4 10 80       	push   $0x8010d4c0
80104a90:	50                   	push   %eax
80104a91:	e8 ca 44 00 00       	call   80108f60 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104a96:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104a99:	c7 43 6c 00 10 00 00 	movl   $0x1000,0x6c(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104aa0:	6a 4c                	push   $0x4c
80104aa2:	6a 00                	push   $0x0
80104aa4:	ff b3 84 00 00 00    	push   0x84(%ebx)
80104aaa:	e8 11 18 00 00       	call   801062c0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104aaf:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104ab5:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104aba:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104abd:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104ac2:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104ac6:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104acc:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104ad0:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104ad6:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104ada:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104ade:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104ae4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104ae8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104aec:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104af2:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104af9:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104aff:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80104b06:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104b0c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104b13:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
80104b19:	6a 18                	push   $0x18
80104b1b:	68 30 9f 10 80       	push   $0x80109f30
80104b20:	50                   	push   %eax
80104b21:	e8 5a 19 00 00       	call   80106480 <safestrcpy>
  p->cwd = namei("/");
80104b26:	c7 04 24 39 9f 10 80 	movl   $0x80109f39,(%esp)
80104b2d:	e8 ae e2 ff ff       	call   80102de0 <namei>
80104b32:	89 83 d4 00 00 00    	mov    %eax,0xd4(%ebx)
  acquire(&ptable.lock);
80104b38:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104b3f:	e8 bc 16 00 00       	call   80106200 <acquire>
  p->state = RUNNABLE;
80104b44:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  release(&ptable.lock);
80104b4b:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104b52:	e8 49 16 00 00       	call   801061a0 <release>
  set_level(p->pid, ROUND_ROBIN);
80104b57:	58                   	pop    %eax
80104b58:	5a                   	pop    %edx
80104b59:	6a 00                	push   $0x0
80104b5b:	ff 73 7c             	push   0x7c(%ebx)
80104b5e:	e8 5d fe ff ff       	call   801049c0 <set_level>
}
80104b63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b66:	83 c4 10             	add    $0x10,%esp
80104b69:	c9                   	leave  
80104b6a:	c3                   	ret    
    panic("userinit: out of memory?");
80104b6b:	83 ec 0c             	sub    $0xc,%esp
80104b6e:	68 17 9f 10 80       	push   $0x80109f17
80104b73:	e8 78 b9 ff ff       	call   801004f0 <panic>
80104b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b7f:	90                   	nop

80104b80 <fork>:
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	57                   	push   %edi
80104b84:	56                   	push   %esi
80104b85:	53                   	push   %ebx
80104b86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104b89:	e8 22 15 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80104b8e:	e8 6d fb ff ff       	call   80104700 <mycpu>
  p = c->proc;
80104b93:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b99:	e8 62 15 00 00       	call   80106100 <popcli>
  if ((np = allocproc()) == 0)
80104b9e:	e8 9d f9 ff ff       	call   80104540 <allocproc>
80104ba3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104ba6:	85 c0                	test   %eax,%eax
80104ba8:	0f 84 fb 00 00 00    	je     80104ca9 <fork+0x129>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80104bae:	83 ec 08             	sub    $0x8,%esp
80104bb1:	ff 73 6c             	push   0x6c(%ebx)
80104bb4:	89 c7                	mov    %eax,%edi
80104bb6:	ff 73 70             	push   0x70(%ebx)
80104bb9:	e8 e2 47 00 00       	call   801093a0 <copyuvm>
80104bbe:	83 c4 10             	add    $0x10,%esp
80104bc1:	89 47 70             	mov    %eax,0x70(%edi)
80104bc4:	85 c0                	test   %eax,%eax
80104bc6:	0f 84 e4 00 00 00    	je     80104cb0 <fork+0x130>
  np->sz = curproc->sz;
80104bcc:	8b 43 6c             	mov    0x6c(%ebx),%eax
80104bcf:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104bd2:	89 41 6c             	mov    %eax,0x6c(%ecx)
  *np->tf = *curproc->tf;
80104bd5:	8b b9 84 00 00 00    	mov    0x84(%ecx),%edi
  np->parent = curproc;
80104bdb:	89 c8                	mov    %ecx,%eax
80104bdd:	89 99 80 00 00 00    	mov    %ebx,0x80(%ecx)
  *np->tf = *curproc->tf;
80104be3:	b9 13 00 00 00       	mov    $0x13,%ecx
80104be8:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
80104bee:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80104bf0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104bf2:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104bf8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (i = 0; i < NOFILE; i++)
80104bff:	90                   	nop
    if (curproc->ofile[i])
80104c00:	8b 84 b3 94 00 00 00 	mov    0x94(%ebx,%esi,4),%eax
80104c07:	85 c0                	test   %eax,%eax
80104c09:	74 16                	je     80104c21 <fork+0xa1>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104c0b:	83 ec 0c             	sub    $0xc,%esp
80104c0e:	50                   	push   %eax
80104c0f:	e8 bc cf ff ff       	call   80101bd0 <filedup>
80104c14:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104c17:	83 c4 10             	add    $0x10,%esp
80104c1a:	89 84 b2 94 00 00 00 	mov    %eax,0x94(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
80104c21:	83 c6 01             	add    $0x1,%esi
80104c24:	83 fe 10             	cmp    $0x10,%esi
80104c27:	75 d7                	jne    80104c00 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80104c29:	83 ec 0c             	sub    $0xc,%esp
80104c2c:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104c32:	81 c3 d8 00 00 00    	add    $0xd8,%ebx
  np->cwd = idup(curproc->cwd);
80104c38:	e8 43 d8 ff ff       	call   80102480 <idup>
80104c3d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104c40:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104c43:	89 87 d4 00 00 00    	mov    %eax,0xd4(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104c49:	8d 87 d8 00 00 00    	lea    0xd8(%edi),%eax
80104c4f:	6a 18                	push   $0x18
80104c51:	53                   	push   %ebx
80104c52:	50                   	push   %eax
80104c53:	e8 28 18 00 00       	call   80106480 <safestrcpy>
  pid = np->pid;
80104c58:	8b 5f 7c             	mov    0x7c(%edi),%ebx
  acquire(&ptable.lock);
80104c5b:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104c62:	e8 99 15 00 00       	call   80106200 <acquire>
  np->state = RUNNABLE;
80104c67:	c7 47 78 03 00 00 00 	movl   $0x3,0x78(%edi)
  release(&ptable.lock);
80104c6e:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104c75:	e8 26 15 00 00       	call   801061a0 <release>
  if(pid==2)
80104c7a:	83 c4 10             	add    $0x10,%esp
80104c7d:	83 fb 02             	cmp    $0x2,%ebx
80104c80:	74 0e                	je     80104c90 <fork+0x110>
}
80104c82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c85:	89 d8                	mov    %ebx,%eax
80104c87:	5b                   	pop    %ebx
80104c88:	5e                   	pop    %esi
80104c89:	5f                   	pop    %edi
80104c8a:	5d                   	pop    %ebp
80104c8b:	c3                   	ret    
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    set_level(pid, ROUND_ROBIN);
80104c90:	83 ec 08             	sub    $0x8,%esp
80104c93:	6a 00                	push   $0x0
80104c95:	6a 02                	push   $0x2
80104c97:	e8 24 fd ff ff       	call   801049c0 <set_level>
80104c9c:	83 c4 10             	add    $0x10,%esp
}
80104c9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ca2:	89 d8                	mov    %ebx,%eax
80104ca4:	5b                   	pop    %ebx
80104ca5:	5e                   	pop    %esi
80104ca6:	5f                   	pop    %edi
80104ca7:	5d                   	pop    %ebp
80104ca8:	c3                   	ret    
    return -1;
80104ca9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104cae:	eb d2                	jmp    80104c82 <fork+0x102>
    kfree(np->kstack);
80104cb0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104cb3:	83 ec 0c             	sub    $0xc,%esp
80104cb6:	ff 73 74             	push   0x74(%ebx)
80104cb9:	e8 42 e5 ff ff       	call   80103200 <kfree>
    np->kstack = 0;
80104cbe:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
    return -1;
80104cc5:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104cc8:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    return -1;
80104ccf:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104cd4:	eb ac                	jmp    80104c82 <fork+0x102>
80104cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi

80104ce0 <aging>:
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ce4:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
{
80104ce9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80104cec:	68 80 54 11 80       	push   $0x80115480
80104cf1:	e8 0a 15 00 00       	call   80106200 <acquire>
80104cf6:	83 c4 10             	add    $0x10,%esp
80104cf9:	eb 13                	jmp    80104d0e <aging+0x2e>
80104cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cff:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d00:	81 c3 14 01 00 00    	add    $0x114,%ebx
80104d06:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80104d0c:	74 7f                	je     80104d8d <aging+0xad>
    if (p->state == RUNNABLE)
80104d0e:	83 7b 78 03          	cmpl   $0x3,0x78(%ebx)
80104d12:	75 ec                	jne    80104d00 <aging+0x20>
      if( p->sched_info.level == ROUND_ROBIN)
80104d14:	8b 83 f0 00 00 00    	mov    0xf0(%ebx),%eax
80104d1a:	85 c0                	test   %eax,%eax
80104d1c:	74 e2                	je     80104d00 <aging+0x20>
      if ((ticks - p->sched_info.last_exe_time > STARVATION_THRESHOLD) &&
80104d1e:	a1 c4 99 11 80       	mov    0x801199c4,%eax
80104d23:	89 c2                	mov    %eax,%edx
80104d25:	2b 93 f8 00 00 00    	sub    0xf8(%ebx),%edx
80104d2b:	81 fa 20 03 00 00    	cmp    $0x320,%edx
80104d31:	76 cd                	jbe    80104d00 <aging+0x20>
         (ticks - p->sched_info.enter_level_time > STARVATION_THRESHOLD))
80104d33:	2b 83 00 01 00 00    	sub    0x100(%ebx),%eax
      if ((ticks - p->sched_info.last_exe_time > STARVATION_THRESHOLD) &&
80104d39:	3d 20 03 00 00       	cmp    $0x320,%eax
80104d3e:	76 c0                	jbe    80104d00 <aging+0x20>
          release(&ptable.lock);
80104d40:	83 ec 0c             	sub    $0xc,%esp
80104d43:	68 80 54 11 80       	push   $0x80115480
80104d48:	e8 53 14 00 00       	call   801061a0 <release>
          if(p->sched_info.level == SJF)
80104d4d:	8b 83 f0 00 00 00    	mov    0xf0(%ebx),%eax
80104d53:	83 c4 10             	add    $0x10,%esp
80104d56:	83 f8 01             	cmp    $0x1,%eax
80104d59:	74 47                	je     80104da2 <aging+0xc2>
          else if(p->sched_info.level == FCFS)
80104d5b:	83 f8 02             	cmp    $0x2,%eax
80104d5e:	74 54                	je     80104db4 <aging+0xd4>
          cprintf("pid: %d starved!\n", p->pid);
80104d60:	83 ec 08             	sub    $0x8,%esp
80104d63:	ff 73 7c             	push   0x7c(%ebx)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d66:	81 c3 14 01 00 00    	add    $0x114,%ebx
          cprintf("pid: %d starved!\n", p->pid);
80104d6c:	68 3b 9f 10 80       	push   $0x80109f3b
80104d71:	e8 fa bc ff ff       	call   80100a70 <cprintf>
          acquire(&ptable.lock);
80104d76:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104d7d:	e8 7e 14 00 00       	call   80106200 <acquire>
80104d82:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d85:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80104d8b:	75 81                	jne    80104d0e <aging+0x2e>
  release(&ptable.lock);
80104d8d:	83 ec 0c             	sub    $0xc,%esp
80104d90:	68 80 54 11 80       	push   $0x80115480
80104d95:	e8 06 14 00 00       	call   801061a0 <release>
}
80104d9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d9d:	83 c4 10             	add    $0x10,%esp
80104da0:	c9                   	leave  
80104da1:	c3                   	ret    
            set_level(p->pid, ROUND_ROBIN);
80104da2:	83 ec 08             	sub    $0x8,%esp
80104da5:	6a 00                	push   $0x0
80104da7:	ff 73 7c             	push   0x7c(%ebx)
80104daa:	e8 11 fc ff ff       	call   801049c0 <set_level>
80104daf:	83 c4 10             	add    $0x10,%esp
80104db2:	eb ac                	jmp    80104d60 <aging+0x80>
            set_level(p->pid, SJF);
80104db4:	83 ec 08             	sub    $0x8,%esp
80104db7:	6a 01                	push   $0x1
80104db9:	ff 73 7c             	push   0x7c(%ebx)
80104dbc:	e8 ff fb ff ff       	call   801049c0 <set_level>
80104dc1:	83 c4 10             	add    $0x10,%esp
80104dc4:	eb 9a                	jmp    80104d60 <aging+0x80>
80104dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi

80104dd0 <round_robin>:
{
80104dd0:	55                   	push   %ebp
      p = ptable.proc;
80104dd1:	b9 b4 54 11 80       	mov    $0x801154b4,%ecx
{
80104dd6:	89 e5                	mov    %esp,%ebp
80104dd8:	8b 55 08             	mov    0x8(%ebp),%edx
  struct proc *p = last_scheduled;
80104ddb:	89 d0                	mov    %edx,%eax
80104ddd:	eb 05                	jmp    80104de4 <round_robin+0x14>
80104ddf:	90                   	nop
    if (p == last_scheduled)
80104de0:	39 d0                	cmp    %edx,%eax
80104de2:	74 24                	je     80104e08 <round_robin+0x38>
    p++;
80104de4:	05 14 01 00 00       	add    $0x114,%eax
      p = ptable.proc;
80104de9:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
80104dee:	0f 43 c1             	cmovae %ecx,%eax
    if (p->state == RUNNABLE && p->sched_info.level == ROUND_ROBIN)
80104df1:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
80104df5:	75 e9                	jne    80104de0 <round_robin+0x10>
80104df7:	83 b8 f0 00 00 00 00 	cmpl   $0x0,0xf0(%eax)
80104dfe:	75 e0                	jne    80104de0 <round_robin+0x10>
}
80104e00:	5d                   	pop    %ebp
80104e01:	c3                   	ret    
80104e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return 0;
80104e08:	31 c0                	xor    %eax,%eax
}
80104e0a:	5d                   	pop    %ebp
80104e0b:	c3                   	ret    
80104e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e10 <scheduler>:
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
      p = ptable.proc;
80104e14:	bf b4 54 11 80       	mov    $0x801154b4,%edi
{
80104e19:	56                   	push   %esi
  struct proc *last_scheduled_RR = &ptable.proc[NPROC - 1];
80104e1a:	be a0 98 11 80       	mov    $0x801198a0,%esi
{
80104e1f:	53                   	push   %ebx
80104e20:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80104e23:	e8 d8 f8 ff ff       	call   80104700 <mycpu>
  c->proc = 0;
80104e28:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104e2f:	00 00 00 
  struct cpu *c = mycpu();
80104e32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c->proc = 0;
80104e35:	83 c0 04             	add    $0x4,%eax
80104e38:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e3f:	90                   	nop
  asm volatile("sti");
80104e40:	fb                   	sti    
    acquire(&ptable.lock);
80104e41:	83 ec 0c             	sub    $0xc,%esp
80104e44:	68 80 54 11 80       	push   $0x80115480
80104e49:	e8 b2 13 00 00       	call   80106200 <acquire>
    if(mycpu()->rr>0)
80104e4e:	e8 ad f8 ff ff       	call   80104700 <mycpu>
80104e53:	83 c4 10             	add    $0x10,%esp
80104e56:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104e5c:	85 c0                	test   %eax,%eax
80104e5e:	0f 8e 8c 00 00 00    	jle    80104ef0 <scheduler+0xe0>
80104e64:	89 f3                	mov    %esi,%ebx
80104e66:	eb 0c                	jmp    80104e74 <scheduler+0x64>
80104e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e6f:	90                   	nop
    if (p == last_scheduled)
80104e70:	39 de                	cmp    %ebx,%esi
80104e72:	74 7c                	je     80104ef0 <scheduler+0xe0>
    p++;
80104e74:	81 c3 14 01 00 00    	add    $0x114,%ebx
      p = ptable.proc;
80104e7a:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80104e80:	0f 43 df             	cmovae %edi,%ebx
    if (p->state == RUNNABLE && p->sched_info.level == ROUND_ROBIN)
80104e83:	83 7b 78 03          	cmpl   $0x3,0x78(%ebx)
80104e87:	75 e7                	jne    80104e70 <scheduler+0x60>
80104e89:	8b 83 f0 00 00 00    	mov    0xf0(%ebx),%eax
80104e8f:	85 c0                	test   %eax,%eax
80104e91:	75 dd                	jne    80104e70 <scheduler+0x60>
80104e93:	89 de                	mov    %ebx,%esi
    c->proc = p;
80104e95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    switchuvm(p);
80104e98:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
80104e9b:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
    switchuvm(p);
80104ea1:	53                   	push   %ebx
80104ea2:	e8 a9 3f 00 00       	call   80108e50 <switchuvm>
    p->sched_info.last_exe_time = ticks;
80104ea7:	a1 c4 99 11 80       	mov    0x801199c4,%eax
    p->state = RUNNING;
80104eac:	c7 43 78 04 00 00 00 	movl   $0x4,0x78(%ebx)
    p->sched_info.last_exe_time = ticks;
80104eb3:	89 83 f8 00 00 00    	mov    %eax,0xf8(%ebx)
    swtch(&(c->scheduler), p->context);
80104eb9:	58                   	pop    %eax
80104eba:	5a                   	pop    %edx
80104ebb:	ff b3 88 00 00 00    	push   0x88(%ebx)
80104ec1:	ff 75 e0             	push   -0x20(%ebp)
80104ec4:	e8 12 16 00 00       	call   801064db <swtch>
    switchkvm();
80104ec9:	e8 72 3f 00 00       	call   80108e40 <switchkvm>
    c->proc = 0;
80104ece:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104ed1:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104ed8:	00 00 00 
  release(&ptable.lock);
80104edb:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80104ee2:	e8 b9 12 00 00       	call   801061a0 <release>
80104ee7:	83 c4 10             	add    $0x10,%esp
80104eea:	e9 51 ff ff ff       	jmp    80104e40 <scheduler+0x30>
80104eef:	90                   	nop
      if(mycpu()->sjf>0)
80104ef0:	e8 0b f8 ff ff       	call   80104700 <mycpu>
80104ef5:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
80104efb:	85 db                	test   %ebx,%ebx
80104efd:	7e 11                	jle    80104f10 <scheduler+0x100>
        p = short_job_first();
80104eff:	e8 bc f9 ff ff       	call   801048c0 <short_job_first>
80104f04:	89 c3                	mov    %eax,%ebx
      if (!p)
80104f06:	85 c0                	test   %eax,%eax
80104f08:	75 8b                	jne    80104e95 <scheduler+0x85>
80104f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(mycpu()->fcfs>0)
80104f10:	e8 eb f7 ff ff       	call   80104700 <mycpu>
80104f15:	8b 88 b8 00 00 00    	mov    0xb8(%eax),%ecx
80104f1b:	85 c9                	test   %ecx,%ecx
80104f1d:	7e 56                	jle    80104f75 <scheduler+0x165>
  struct proc* res=0;
80104f1f:	31 db                	xor    %ebx,%ebx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104f21:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
80104f26:	eb 24                	jmp    80104f4c <scheduler+0x13c>
80104f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2f:	90                   	nop
    else if(p->sched_info.enter_level_time<res->sched_info.enter_level_time)
80104f30:	8b 93 00 01 00 00    	mov    0x100(%ebx),%edx
80104f36:	39 90 00 01 00 00    	cmp    %edx,0x100(%eax)
80104f3c:	0f 42 d8             	cmovb  %eax,%ebx
80104f3f:	90                   	nop
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104f40:	05 14 01 00 00       	add    $0x114,%eax
80104f45:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
80104f4a:	74 21                	je     80104f6d <scheduler+0x15d>
    if((p->state != RUNNABLE) || (p->sched_info.level!=FCFS))
80104f4c:	83 78 78 03          	cmpl   $0x3,0x78(%eax)
80104f50:	75 ee                	jne    80104f40 <scheduler+0x130>
80104f52:	83 b8 f0 00 00 00 02 	cmpl   $0x2,0xf0(%eax)
80104f59:	75 e5                	jne    80104f40 <scheduler+0x130>
    if(res == 0)
80104f5b:	85 db                	test   %ebx,%ebx
80104f5d:	75 d1                	jne    80104f30 <scheduler+0x120>
80104f5f:	89 c3                	mov    %eax,%ebx
  for(p=ptable.proc; p<&ptable.proc[NPROC]; p++)
80104f61:	05 14 01 00 00       	add    $0x114,%eax
80104f66:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
80104f6b:	75 df                	jne    80104f4c <scheduler+0x13c>
        if (!p)
80104f6d:	85 db                	test   %ebx,%ebx
80104f6f:	0f 85 20 ff ff ff    	jne    80104e95 <scheduler+0x85>
          mycpu()->rr = 30;
80104f75:	e8 86 f7 ff ff       	call   80104700 <mycpu>
80104f7a:	c7 80 b0 00 00 00 1e 	movl   $0x1e,0xb0(%eax)
80104f81:	00 00 00 
          mycpu()->sjf = 20;
80104f84:	e8 77 f7 ff ff       	call   80104700 <mycpu>
80104f89:	c7 80 b4 00 00 00 14 	movl   $0x14,0xb4(%eax)
80104f90:	00 00 00 
          mycpu()->fcfs = 10;
80104f93:	e8 68 f7 ff ff       	call   80104700 <mycpu>
          release(&ptable.lock);
80104f98:	83 ec 0c             	sub    $0xc,%esp
          mycpu()->fcfs = 10;
80104f9b:	c7 80 b8 00 00 00 0a 	movl   $0xa,0xb8(%eax)
80104fa2:	00 00 00 
          release(&ptable.lock);
80104fa5:	68 80 54 11 80       	push   $0x80115480
80104faa:	e8 f1 11 00 00       	call   801061a0 <release>
          continue;
80104faf:	83 c4 10             	add    $0x10,%esp
80104fb2:	e9 89 fe ff ff       	jmp    80104e40 <scheduler+0x30>
80104fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fbe:	66 90                	xchg   %ax,%ax

80104fc0 <sched>:
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
  pushcli();
80104fc5:	e8 e6 10 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80104fca:	e8 31 f7 ff ff       	call   80104700 <mycpu>
  p = c->proc;
80104fcf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104fd5:	e8 26 11 00 00       	call   80106100 <popcli>
  if (!holding(&ptable.lock))
80104fda:	83 ec 0c             	sub    $0xc,%esp
80104fdd:	68 80 54 11 80       	push   $0x80115480
80104fe2:	e8 79 11 00 00       	call   80106160 <holding>
80104fe7:	83 c4 10             	add    $0x10,%esp
80104fea:	85 c0                	test   %eax,%eax
80104fec:	74 52                	je     80105040 <sched+0x80>
  if (mycpu()->ncli != 1)
80104fee:	e8 0d f7 ff ff       	call   80104700 <mycpu>
80104ff3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104ffa:	75 6b                	jne    80105067 <sched+0xa7>
  if (p->state == RUNNING)
80104ffc:	83 7b 78 04          	cmpl   $0x4,0x78(%ebx)
80105000:	74 58                	je     8010505a <sched+0x9a>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105002:	9c                   	pushf  
80105003:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80105004:	f6 c4 02             	test   $0x2,%ah
80105007:	75 44                	jne    8010504d <sched+0x8d>
  intena = mycpu()->intena;
80105009:	e8 f2 f6 ff ff       	call   80104700 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010500e:	81 c3 88 00 00 00    	add    $0x88,%ebx
  intena = mycpu()->intena;
80105014:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010501a:	e8 e1 f6 ff ff       	call   80104700 <mycpu>
8010501f:	83 ec 08             	sub    $0x8,%esp
80105022:	ff 70 04             	push   0x4(%eax)
80105025:	53                   	push   %ebx
80105026:	e8 b0 14 00 00       	call   801064db <swtch>
  mycpu()->intena = intena;
8010502b:	e8 d0 f6 ff ff       	call   80104700 <mycpu>
}
80105030:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80105033:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80105039:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010503c:	5b                   	pop    %ebx
8010503d:	5e                   	pop    %esi
8010503e:	5d                   	pop    %ebp
8010503f:	c3                   	ret    
    panic("sched ptable.lock");
80105040:	83 ec 0c             	sub    $0xc,%esp
80105043:	68 4d 9f 10 80       	push   $0x80109f4d
80105048:	e8 a3 b4 ff ff       	call   801004f0 <panic>
    panic("sched interruptible");
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	68 79 9f 10 80       	push   $0x80109f79
80105055:	e8 96 b4 ff ff       	call   801004f0 <panic>
    panic("sched running");
8010505a:	83 ec 0c             	sub    $0xc,%esp
8010505d:	68 6b 9f 10 80       	push   $0x80109f6b
80105062:	e8 89 b4 ff ff       	call   801004f0 <panic>
    panic("sched locks");
80105067:	83 ec 0c             	sub    $0xc,%esp
8010506a:	68 5f 9f 10 80       	push   $0x80109f5f
8010506f:	e8 7c b4 ff ff       	call   801004f0 <panic>
80105074:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010507b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010507f:	90                   	nop

80105080 <exit>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	57                   	push   %edi
80105084:	56                   	push   %esi
80105085:	53                   	push   %ebx
80105086:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80105089:	e8 f2 f6 ff ff       	call   80104780 <myproc>
  if (curproc == initproc)
8010508e:	39 05 b4 99 11 80    	cmp    %eax,0x801199b4
80105094:	0f 84 22 01 00 00    	je     801051bc <exit+0x13c>
8010509a:	89 c3                	mov    %eax,%ebx
8010509c:	8d b0 94 00 00 00    	lea    0x94(%eax),%esi
801050a2:	8d b8 d4 00 00 00    	lea    0xd4(%eax),%edi
801050a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050af:	90                   	nop
    if (curproc->ofile[fd])
801050b0:	8b 06                	mov    (%esi),%eax
801050b2:	85 c0                	test   %eax,%eax
801050b4:	74 12                	je     801050c8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801050b6:	83 ec 0c             	sub    $0xc,%esp
801050b9:	50                   	push   %eax
801050ba:	e8 61 cb ff ff       	call   80101c20 <fileclose>
      curproc->ofile[fd] = 0;
801050bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801050c5:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
801050c8:	83 c6 04             	add    $0x4,%esi
801050cb:	39 f7                	cmp    %esi,%edi
801050cd:	75 e1                	jne    801050b0 <exit+0x30>
  begin_op();
801050cf:	e8 cc e9 ff ff       	call   80103aa0 <begin_op>
  iput(curproc->cwd);
801050d4:	83 ec 0c             	sub    $0xc,%esp
801050d7:	ff b3 d4 00 00 00    	push   0xd4(%ebx)
801050dd:	e8 fe d4 ff ff       	call   801025e0 <iput>
  end_op();
801050e2:	e8 29 ea ff ff       	call   80103b10 <end_op>
  curproc->cwd = 0;
801050e7:	c7 83 d4 00 00 00 00 	movl   $0x0,0xd4(%ebx)
801050ee:	00 00 00 
  acquire(&ptable.lock);
801050f1:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
801050f8:	e8 03 11 00 00       	call   80106200 <acquire>
  wakeup1(curproc->parent);
801050fd:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
80105103:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105106:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
8010510b:	eb 0f                	jmp    8010511c <exit+0x9c>
8010510d:	8d 76 00             	lea    0x0(%esi),%esi
80105110:	05 14 01 00 00       	add    $0x114,%eax
80105115:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010511a:	74 21                	je     8010513d <exit+0xbd>
    if (p->state == SLEEPING && p->chan == chan)
8010511c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80105120:	75 ee                	jne    80105110 <exit+0x90>
80105122:	3b 90 8c 00 00 00    	cmp    0x8c(%eax),%edx
80105128:	75 e6                	jne    80105110 <exit+0x90>
      p->state = RUNNABLE;
8010512a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105131:	05 14 01 00 00       	add    $0x114,%eax
80105136:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010513b:	75 df                	jne    8010511c <exit+0x9c>
      p->parent = initproc;
8010513d:	8b 0d b4 99 11 80    	mov    0x801199b4,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105143:	ba b4 54 11 80       	mov    $0x801154b4,%edx
80105148:	eb 14                	jmp    8010515e <exit+0xde>
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105150:	81 c2 14 01 00 00    	add    $0x114,%edx
80105156:	81 fa b4 99 11 80    	cmp    $0x801199b4,%edx
8010515c:	74 45                	je     801051a3 <exit+0x123>
    if (p->parent == curproc)
8010515e:	39 9a 80 00 00 00    	cmp    %ebx,0x80(%edx)
80105164:	75 ea                	jne    80105150 <exit+0xd0>
      if (p->state == ZOMBIE)
80105166:	83 7a 78 05          	cmpl   $0x5,0x78(%edx)
      p->parent = initproc;
8010516a:	89 8a 80 00 00 00    	mov    %ecx,0x80(%edx)
      if (p->state == ZOMBIE)
80105170:	75 de                	jne    80105150 <exit+0xd0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105172:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
80105177:	eb 13                	jmp    8010518c <exit+0x10c>
80105179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105180:	05 14 01 00 00       	add    $0x114,%eax
80105185:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010518a:	74 c4                	je     80105150 <exit+0xd0>
    if (p->state == SLEEPING && p->chan == chan)
8010518c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80105190:	75 ee                	jne    80105180 <exit+0x100>
80105192:	3b 88 8c 00 00 00    	cmp    0x8c(%eax),%ecx
80105198:	75 e6                	jne    80105180 <exit+0x100>
      p->state = RUNNABLE;
8010519a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
801051a1:	eb dd                	jmp    80105180 <exit+0x100>
  curproc->state = ZOMBIE;
801051a3:	c7 43 78 05 00 00 00 	movl   $0x5,0x78(%ebx)
  sched();
801051aa:	e8 11 fe ff ff       	call   80104fc0 <sched>
  panic("zombie exit");
801051af:	83 ec 0c             	sub    $0xc,%esp
801051b2:	68 9a 9f 10 80       	push   $0x80109f9a
801051b7:	e8 34 b3 ff ff       	call   801004f0 <panic>
    panic("init exiting");
801051bc:	83 ec 0c             	sub    $0xc,%esp
801051bf:	68 8d 9f 10 80       	push   $0x80109f8d
801051c4:	e8 27 b3 ff ff       	call   801004f0 <panic>
801051c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801051d0 <wait>:
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	56                   	push   %esi
801051d4:	53                   	push   %ebx
  pushcli();
801051d5:	e8 d6 0e 00 00       	call   801060b0 <pushcli>
  c = mycpu();
801051da:	e8 21 f5 ff ff       	call   80104700 <mycpu>
  p = c->proc;
801051df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801051e5:	e8 16 0f 00 00       	call   80106100 <popcli>
  acquire(&ptable.lock);
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	68 80 54 11 80       	push   $0x80115480
801051f2:	e8 09 10 00 00       	call   80106200 <acquire>
801051f7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801051fa:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801051fc:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
80105201:	eb 13                	jmp    80105216 <wait+0x46>
80105203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105207:	90                   	nop
80105208:	81 c3 14 01 00 00    	add    $0x114,%ebx
8010520e:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80105214:	74 21                	je     80105237 <wait+0x67>
      if (p->parent != curproc)
80105216:	39 b3 80 00 00 00    	cmp    %esi,0x80(%ebx)
8010521c:	75 ea                	jne    80105208 <wait+0x38>
      if (p->state == ZOMBIE)
8010521e:	83 7b 78 05          	cmpl   $0x5,0x78(%ebx)
80105222:	74 6c                	je     80105290 <wait+0xc0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105224:	81 c3 14 01 00 00    	add    $0x114,%ebx
      havekids = 1;
8010522a:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010522f:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80105235:	75 df                	jne    80105216 <wait+0x46>
    if (!havekids || curproc->killed)
80105237:	85 c0                	test   %eax,%eax
80105239:	0f 84 b0 00 00 00    	je     801052ef <wait+0x11f>
8010523f:	8b 86 90 00 00 00    	mov    0x90(%esi),%eax
80105245:	85 c0                	test   %eax,%eax
80105247:	0f 85 a2 00 00 00    	jne    801052ef <wait+0x11f>
  pushcli();
8010524d:	e8 5e 0e 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105252:	e8 a9 f4 ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105257:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010525d:	e8 9e 0e 00 00       	call   80106100 <popcli>
  if (p == 0)
80105262:	85 db                	test   %ebx,%ebx
80105264:	0f 84 9c 00 00 00    	je     80105306 <wait+0x136>
  p->chan = chan;
8010526a:	89 b3 8c 00 00 00    	mov    %esi,0x8c(%ebx)
  p->state = SLEEPING;
80105270:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
80105277:	e8 44 fd ff ff       	call   80104fc0 <sched>
  p->chan = 0;
8010527c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80105283:	00 00 00 
}
80105286:	e9 6f ff ff ff       	jmp    801051fa <wait+0x2a>
8010528b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010528f:	90                   	nop
        kfree(p->kstack);
80105290:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80105293:	8b 73 7c             	mov    0x7c(%ebx),%esi
        kfree(p->kstack);
80105296:	ff 73 74             	push   0x74(%ebx)
80105299:	e8 62 df ff ff       	call   80103200 <kfree>
        p->kstack = 0;
8010529e:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
        freevm(p->pgdir);
801052a5:	5a                   	pop    %edx
801052a6:	ff 73 70             	push   0x70(%ebx)
801052a9:	e8 82 3f 00 00       	call   80109230 <freevm>
        p->pid = 0;
801052ae:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
        p->parent = 0;
801052b5:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801052bc:	00 00 00 
        p->name[0] = 0;
801052bf:	c6 83 d8 00 00 00 00 	movb   $0x0,0xd8(%ebx)
        p->killed = 0;
801052c6:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
801052cd:	00 00 00 
        p->state = UNUSED;
801052d0:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
        release(&ptable.lock);
801052d7:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
801052de:	e8 bd 0e 00 00       	call   801061a0 <release>
        return pid;
801052e3:	83 c4 10             	add    $0x10,%esp
}
801052e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052e9:	89 f0                	mov    %esi,%eax
801052eb:	5b                   	pop    %ebx
801052ec:	5e                   	pop    %esi
801052ed:	5d                   	pop    %ebp
801052ee:	c3                   	ret    
      release(&ptable.lock);
801052ef:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801052f2:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801052f7:	68 80 54 11 80       	push   $0x80115480
801052fc:	e8 9f 0e 00 00       	call   801061a0 <release>
      return -1;
80105301:	83 c4 10             	add    $0x10,%esp
80105304:	eb e0                	jmp    801052e6 <wait+0x116>
    panic("sleep");
80105306:	83 ec 0c             	sub    $0xc,%esp
80105309:	68 a6 9f 10 80       	push   $0x80109fa6
8010530e:	e8 dd b1 ff ff       	call   801004f0 <panic>
80105313:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105320 <yield>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	53                   	push   %ebx
80105324:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); // DOC: yieldlock
80105327:	68 80 54 11 80       	push   $0x80115480
8010532c:	e8 cf 0e 00 00       	call   80106200 <acquire>
  pushcli();
80105331:	e8 7a 0d 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105336:	e8 c5 f3 ff ff       	call   80104700 <mycpu>
  p = c->proc;
8010533b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105341:	e8 ba 0d 00 00       	call   80106100 <popcli>
  myproc()->state = RUNNABLE;
80105346:	c7 43 78 03 00 00 00 	movl   $0x3,0x78(%ebx)
  sched();
8010534d:	e8 6e fc ff ff       	call   80104fc0 <sched>
  release(&ptable.lock);
80105352:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
80105359:	e8 42 0e 00 00       	call   801061a0 <release>
}
8010535e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105361:	83 c4 10             	add    $0x10,%esp
80105364:	c9                   	leave  
80105365:	c3                   	ret    
80105366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536d:	8d 76 00             	lea    0x0(%esi),%esi

80105370 <sleep>:
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
80105375:	53                   	push   %ebx
80105376:	83 ec 0c             	sub    $0xc,%esp
80105379:	8b 7d 08             	mov    0x8(%ebp),%edi
8010537c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010537f:	e8 2c 0d 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105384:	e8 77 f3 ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105389:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010538f:	e8 6c 0d 00 00       	call   80106100 <popcli>
  if (p == 0)
80105394:	85 db                	test   %ebx,%ebx
80105396:	0f 84 95 00 00 00    	je     80105431 <sleep+0xc1>
  if (lk == 0)
8010539c:	85 f6                	test   %esi,%esi
8010539e:	0f 84 80 00 00 00    	je     80105424 <sleep+0xb4>
  if (lk != &ptable.lock)
801053a4:	81 fe 80 54 11 80    	cmp    $0x80115480,%esi
801053aa:	74 54                	je     80105400 <sleep+0x90>
    acquire(&ptable.lock); // DOC: sleeplock1
801053ac:	83 ec 0c             	sub    $0xc,%esp
801053af:	68 80 54 11 80       	push   $0x80115480
801053b4:	e8 47 0e 00 00       	call   80106200 <acquire>
    release(lk);
801053b9:	89 34 24             	mov    %esi,(%esp)
801053bc:	e8 df 0d 00 00       	call   801061a0 <release>
  p->chan = chan;
801053c1:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
801053c7:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
801053ce:	e8 ed fb ff ff       	call   80104fc0 <sched>
  p->chan = 0;
801053d3:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801053da:	00 00 00 
    release(&ptable.lock);
801053dd:	c7 04 24 80 54 11 80 	movl   $0x80115480,(%esp)
801053e4:	e8 b7 0d 00 00       	call   801061a0 <release>
    acquire(lk);
801053e9:	89 75 08             	mov    %esi,0x8(%ebp)
801053ec:	83 c4 10             	add    $0x10,%esp
}
801053ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053f2:	5b                   	pop    %ebx
801053f3:	5e                   	pop    %esi
801053f4:	5f                   	pop    %edi
801053f5:	5d                   	pop    %ebp
    acquire(lk);
801053f6:	e9 05 0e 00 00       	jmp    80106200 <acquire>
801053fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053ff:	90                   	nop
  p->chan = chan;
80105400:	89 bb 8c 00 00 00    	mov    %edi,0x8c(%ebx)
  p->state = SLEEPING;
80105406:	c7 43 78 02 00 00 00 	movl   $0x2,0x78(%ebx)
  sched();
8010540d:	e8 ae fb ff ff       	call   80104fc0 <sched>
  p->chan = 0;
80105412:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80105419:	00 00 00 
}
8010541c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010541f:	5b                   	pop    %ebx
80105420:	5e                   	pop    %esi
80105421:	5f                   	pop    %edi
80105422:	5d                   	pop    %ebp
80105423:	c3                   	ret    
    panic("sleep without lk");
80105424:	83 ec 0c             	sub    $0xc,%esp
80105427:	68 ac 9f 10 80       	push   $0x80109fac
8010542c:	e8 bf b0 ff ff       	call   801004f0 <panic>
    panic("sleep");
80105431:	83 ec 0c             	sub    $0xc,%esp
80105434:	68 a6 9f 10 80       	push   $0x80109fa6
80105439:	e8 b2 b0 ff ff       	call   801004f0 <panic>
8010543e:	66 90                	xchg   %ax,%ax

80105440 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	83 ec 10             	sub    $0x10,%esp
80105447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010544a:	68 80 54 11 80       	push   $0x80115480
8010544f:	e8 ac 0d 00 00       	call   80106200 <acquire>
80105454:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105457:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
8010545c:	eb 0e                	jmp    8010546c <wakeup+0x2c>
8010545e:	66 90                	xchg   %ax,%ax
80105460:	05 14 01 00 00       	add    $0x114,%eax
80105465:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010546a:	74 21                	je     8010548d <wakeup+0x4d>
    if (p->state == SLEEPING && p->chan == chan)
8010546c:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
80105470:	75 ee                	jne    80105460 <wakeup+0x20>
80105472:	3b 98 8c 00 00 00    	cmp    0x8c(%eax),%ebx
80105478:	75 e6                	jne    80105460 <wakeup+0x20>
      p->state = RUNNABLE;
8010547a:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105481:	05 14 01 00 00       	add    $0x114,%eax
80105486:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
8010548b:	75 df                	jne    8010546c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010548d:	c7 45 08 80 54 11 80 	movl   $0x80115480,0x8(%ebp)
}
80105494:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105497:	c9                   	leave  
  release(&ptable.lock);
80105498:	e9 03 0d 00 00       	jmp    801061a0 <release>
8010549d:	8d 76 00             	lea    0x0(%esi),%esi

801054a0 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	83 ec 10             	sub    $0x10,%esp
801054a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801054aa:	68 80 54 11 80       	push   $0x80115480
801054af:	e8 4c 0d 00 00       	call   80106200 <acquire>
801054b4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801054b7:	b8 b4 54 11 80       	mov    $0x801154b4,%eax
801054bc:	eb 0e                	jmp    801054cc <kill+0x2c>
801054be:	66 90                	xchg   %ax,%ax
801054c0:	05 14 01 00 00       	add    $0x114,%eax
801054c5:	3d b4 99 11 80       	cmp    $0x801199b4,%eax
801054ca:	74 34                	je     80105500 <kill+0x60>
  {
    if (p->pid == pid)
801054cc:	39 58 7c             	cmp    %ebx,0x7c(%eax)
801054cf:	75 ef                	jne    801054c0 <kill+0x20>
    {
      p->killed = 1;
801054d1:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
801054d8:	00 00 00 
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
801054db:	83 78 78 02          	cmpl   $0x2,0x78(%eax)
801054df:	75 07                	jne    801054e8 <kill+0x48>
        p->state = RUNNABLE;
801054e1:	c7 40 78 03 00 00 00 	movl   $0x3,0x78(%eax)
      release(&ptable.lock);
801054e8:	83 ec 0c             	sub    $0xc,%esp
801054eb:	68 80 54 11 80       	push   $0x80115480
801054f0:	e8 ab 0c 00 00       	call   801061a0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801054f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801054f8:	83 c4 10             	add    $0x10,%esp
801054fb:	31 c0                	xor    %eax,%eax
}
801054fd:	c9                   	leave  
801054fe:	c3                   	ret    
801054ff:	90                   	nop
  release(&ptable.lock);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	68 80 54 11 80       	push   $0x80115480
80105508:	e8 93 0c 00 00       	call   801061a0 <release>
}
8010550d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80105510:	83 c4 10             	add    $0x10,%esp
80105513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105518:	c9                   	leave  
80105519:	c3                   	ret    
8010551a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105520 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	8d 75 e8             	lea    -0x18(%ebp),%esi
80105528:	53                   	push   %ebx
80105529:	bb 8c 55 11 80       	mov    $0x8011558c,%ebx
8010552e:	83 ec 3c             	sub    $0x3c,%esp
80105531:	eb 27                	jmp    8010555a <procdump+0x3a>
80105533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105537:	90                   	nop
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105538:	83 ec 0c             	sub    $0xc,%esp
8010553b:	68 11 a0 10 80       	push   $0x8010a011
80105540:	e8 2b b5 ff ff       	call   80100a70 <cprintf>
80105545:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105548:	81 c3 14 01 00 00    	add    $0x114,%ebx
8010554e:	81 fb 8c 9a 11 80    	cmp    $0x80119a8c,%ebx
80105554:	0f 84 7e 00 00 00    	je     801055d8 <procdump+0xb8>
    if (p->state == UNUSED)
8010555a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010555d:	85 c0                	test   %eax,%eax
8010555f:	74 e7                	je     80105548 <procdump+0x28>
      state = "???";
80105561:	ba bd 9f 10 80       	mov    $0x80109fbd,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105566:	83 f8 05             	cmp    $0x5,%eax
80105569:	77 11                	ja     8010557c <procdump+0x5c>
8010556b:	8b 14 85 f0 a1 10 80 	mov    -0x7fef5e10(,%eax,4),%edx
      state = "???";
80105572:	b8 bd 9f 10 80       	mov    $0x80109fbd,%eax
80105577:	85 d2                	test   %edx,%edx
80105579:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010557c:	53                   	push   %ebx
8010557d:	52                   	push   %edx
8010557e:	ff 73 a4             	push   -0x5c(%ebx)
80105581:	68 c1 9f 10 80       	push   $0x80109fc1
80105586:	e8 e5 b4 ff ff       	call   80100a70 <cprintf>
    if (p->state == SLEEPING)
8010558b:	83 c4 10             	add    $0x10,%esp
8010558e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80105592:	75 a4                	jne    80105538 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80105594:	83 ec 08             	sub    $0x8,%esp
80105597:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010559a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010559d:	50                   	push   %eax
8010559e:	8b 43 b0             	mov    -0x50(%ebx),%eax
801055a1:	8b 40 0c             	mov    0xc(%eax),%eax
801055a4:	83 c0 08             	add    $0x8,%eax
801055a7:	50                   	push   %eax
801055a8:	e8 a3 0a 00 00       	call   80106050 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801055ad:	83 c4 10             	add    $0x10,%esp
801055b0:	8b 17                	mov    (%edi),%edx
801055b2:	85 d2                	test   %edx,%edx
801055b4:	74 82                	je     80105538 <procdump+0x18>
        cprintf(" %p", pc[i]);
801055b6:	83 ec 08             	sub    $0x8,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801055b9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801055bc:	52                   	push   %edx
801055bd:	68 c1 99 10 80       	push   $0x801099c1
801055c2:	e8 a9 b4 ff ff       	call   80100a70 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801055c7:	83 c4 10             	add    $0x10,%esp
801055ca:	39 fe                	cmp    %edi,%esi
801055cc:	75 e2                	jne    801055b0 <procdump+0x90>
801055ce:	e9 65 ff ff ff       	jmp    80105538 <procdump+0x18>
801055d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055d7:	90                   	nop
  }
}
801055d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055db:	5b                   	pop    %ebx
801055dc:	5e                   	pop    %esi
801055dd:	5f                   	pop    %edi
801055de:	5d                   	pop    %ebp
801055df:	c3                   	ret    

801055e0 <list_active_processes>:

int list_active_processes(void)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	53                   	push   %ebx
801055e4:	bb 20 55 11 80       	mov    $0x80115520,%ebx
801055e9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  acquire(&ptable.lock);
801055ec:	68 80 54 11 80       	push   $0x80115480
801055f1:	e8 0a 0c 00 00       	call   80106200 <acquire>

  cprintf("PID\tName\t\tNumber of syscalls:\n");
801055f6:	c7 04 24 94 a0 10 80 	movl   $0x8010a094,(%esp)
801055fd:	e8 6e b4 ff ff       	call   80100a70 <cprintf>
  cprintf("---------------------------\n");
80105602:	c7 04 24 ca 9f 10 80 	movl   $0x80109fca,(%esp)
80105609:	e8 62 b4 ff ff       	call   80100a70 <cprintf>

  // Iterate over the process table
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010560e:	83 c4 10             	add    $0x10,%esp
80105611:	eb 13                	jmp    80105626 <list_active_processes+0x46>
80105613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105617:	90                   	nop
80105618:	81 c3 14 01 00 00    	add    $0x114,%ebx
8010561e:	81 fb 20 9a 11 80    	cmp    $0x80119a20,%ebx
80105624:	74 41                	je     80105667 <list_active_processes+0x87>
  {
    if (p->state != UNUSED)
80105626:	8b 43 0c             	mov    0xc(%ebx),%eax
80105629:	85 c0                	test   %eax,%eax
8010562b:	74 eb                	je     80105618 <list_active_processes+0x38>
8010562d:	8d 43 94             	lea    -0x6c(%ebx),%eax
    { // Only list active processes
      int num_of_syscalls = 0;
80105630:	31 d2                	xor    %edx,%edx
80105632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for (int i = 0; i < MAX_SYSCALLS; i++)
        num_of_syscalls += p->syscalls[i];
80105638:	03 10                	add    (%eax),%edx
      for (int i = 0; i < MAX_SYSCALLS; i++)
8010563a:	83 c0 04             	add    $0x4,%eax
8010563d:	39 d8                	cmp    %ebx,%eax
8010563f:	75 f7                	jne    80105638 <list_active_processes+0x58>
      cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
80105641:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105644:	52                   	push   %edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105645:	81 c3 14 01 00 00    	add    $0x114,%ebx
      cprintf("%d\t%s\t\t%d\n", p->pid, p->name, num_of_syscalls);
8010564b:	50                   	push   %eax
8010564c:	ff b3 fc fe ff ff    	push   -0x104(%ebx)
80105652:	68 e7 9f 10 80       	push   $0x80109fe7
80105657:	e8 14 b4 ff ff       	call   80100a70 <cprintf>
8010565c:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010565f:	81 fb 20 9a 11 80    	cmp    $0x80119a20,%ebx
80105665:	75 bf                	jne    80105626 <list_active_processes+0x46>
    }
  }

  // Release the process table lock
  release(&ptable.lock);
80105667:	83 ec 0c             	sub    $0xc,%esp
8010566a:	68 80 54 11 80       	push   $0x80115480
8010566f:	e8 2c 0b 00 00       	call   801061a0 <release>

  return 0; // Return 0 to indicate success
}
80105674:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105677:	31 c0                	xor    %eax,%eax
80105679:	c9                   	leave  
8010567a:	c3                   	ret    
8010567b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010567f:	90                   	nop

80105680 <space>:


void
space(int count)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	56                   	push   %esi
80105684:	8b 75 08             	mov    0x8(%ebp),%esi
80105687:	53                   	push   %ebx
  for(int i = 0; i < count; ++i)
80105688:	85 f6                	test   %esi,%esi
8010568a:	7e 1b                	jle    801056a7 <space+0x27>
8010568c:	31 db                	xor    %ebx,%ebx
8010568e:	66 90                	xchg   %ax,%ax
    cprintf(" ");
80105690:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105693:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
80105696:	68 69 a0 10 80       	push   $0x8010a069
8010569b:	e8 d0 b3 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801056a0:	83 c4 10             	add    $0x10,%esp
801056a3:	39 de                	cmp    %ebx,%esi
801056a5:	75 e9                	jne    80105690 <space+0x10>
}
801056a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056aa:	5b                   	pop    %ebx
801056ab:	5e                   	pop    %esi
801056ac:	5d                   	pop    %ebp
801056ad:	c3                   	ret    
801056ae:	66 90                	xchg   %ax,%ax

801056b0 <num_digits>:

int num_digits(int n) {
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	56                   	push   %esi
801056b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801056b7:	53                   	push   %ebx
  int num = 0;
801056b8:	31 db                	xor    %ebx,%ebx
  while(n!= 0) {
801056ba:	85 c9                	test   %ecx,%ecx
801056bc:	74 1f                	je     801056dd <num_digits+0x2d>
    n/=10;
801056be:	be 67 66 66 66       	mov    $0x66666667,%esi
801056c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056c7:	90                   	nop
801056c8:	89 c8                	mov    %ecx,%eax
    num += 1;
801056ca:	83 c3 01             	add    $0x1,%ebx
    n/=10;
801056cd:	f7 ee                	imul   %esi
801056cf:	89 c8                	mov    %ecx,%eax
801056d1:	c1 f8 1f             	sar    $0x1f,%eax
801056d4:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801056d7:	89 d1                	mov    %edx,%ecx
801056d9:	29 c1                	sub    %eax,%ecx
801056db:	75 eb                	jne    801056c8 <num_digits+0x18>
  }
  return num;
}
801056dd:	89 d8                	mov    %ebx,%eax
801056df:	5b                   	pop    %ebx
801056e0:	5e                   	pop    %esi
801056e1:	5d                   	pop    %ebp
801056e2:	c3                   	ret    
801056e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801056f0 <show_process_info>:

void show_process_info()
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	57                   	push   %edi
801056f4:	56                   	push   %esi
801056f5:	53                   	push   %ebx
801056f6:	bb 8c 55 11 80       	mov    $0x8011558c,%ebx
801056fb:	83 ec 28             	sub    $0x28,%esp
      [RUNNABLE] "runnable",
      [RUNNING] "running",
      [ZOMBIE] "zombie"};

  static int columns[] = {24, 10, 10, 10, 10, 10, 15, 12, 12};
  cprintf("Process_Name            PID     State    Queue   Burst_time   waiting   Enterance_time   confidence    consecutive_run\n"
801056fe:	68 b4 a0 10 80       	push   $0x8010a0b4
80105703:	e8 68 b3 ff ff       	call   80100a70 <cprintf>
          "----------------------------------------------------------------------------------------\n");

  struct proc *p;
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105708:	83 c4 10             	add    $0x10,%esp
8010570b:	eb 16                	jmp    80105723 <show_process_info+0x33>
8010570d:	8d 76 00             	lea    0x0(%esi),%esi
80105710:	81 c3 14 01 00 00    	add    $0x114,%ebx
80105716:	b8 8c 9a 11 80       	mov    $0x80119a8c,%eax
8010571b:	39 d8                	cmp    %ebx,%eax
8010571d:	0f 84 af 03 00 00    	je     80105ad2 <show_process_info+0x3e2>
  {
    if (p->state == UNUSED)
80105723:	8b 43 a0             	mov    -0x60(%ebx),%eax
80105726:	85 c0                	test   %eax,%eax
80105728:	74 e6                	je     80105710 <show_process_info+0x20>

    const char *state;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "unknown state";
8010572a:	c7 45 e4 f2 9f 10 80 	movl   $0x80109ff2,-0x1c(%ebp)
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105731:	83 f8 05             	cmp    $0x5,%eax
80105734:	77 14                	ja     8010574a <show_process_info+0x5a>
80105736:	8b 3c 85 d8 a1 10 80 	mov    -0x7fef5e28(,%eax,4),%edi
      state = "unknown state";
8010573d:	b8 f2 9f 10 80       	mov    $0x80109ff2,%eax
80105742:	85 ff                	test   %edi,%edi
80105744:	0f 45 c7             	cmovne %edi,%eax
80105747:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    cprintf("%s", p->name);
8010574a:	83 ec 08             	sub    $0x8,%esp
    space(columns[0] - strlen(p->name));
8010574d:	be 18 00 00 00       	mov    $0x18,%esi
    cprintf("%s", p->name);
80105752:	53                   	push   %ebx
80105753:	68 c7 9f 10 80       	push   $0x80109fc7
80105758:	e8 13 b3 ff ff       	call   80100a70 <cprintf>
    space(columns[0] - strlen(p->name));
8010575d:	89 1c 24             	mov    %ebx,(%esp)
80105760:	e8 5b 0d 00 00       	call   801064c0 <strlen>
  for(int i = 0; i < count; ++i)
80105765:	83 c4 10             	add    $0x10,%esp
    space(columns[0] - strlen(p->name));
80105768:	29 c6                	sub    %eax,%esi
  for(int i = 0; i < count; ++i)
8010576a:	85 f6                	test   %esi,%esi
8010576c:	7e 19                	jle    80105787 <show_process_info+0x97>
8010576e:	31 ff                	xor    %edi,%edi
    cprintf(" ");
80105770:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105773:	83 c7 01             	add    $0x1,%edi
    cprintf(" ");
80105776:	68 69 a0 10 80       	push   $0x8010a069
8010577b:	e8 f0 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105780:	83 c4 10             	add    $0x10,%esp
80105783:	39 fe                	cmp    %edi,%esi
80105785:	75 e9                	jne    80105770 <show_process_info+0x80>

    cprintf("%d", p->pid);
80105787:	83 ec 08             	sub    $0x8,%esp
8010578a:	ff 73 a4             	push   -0x5c(%ebx)
8010578d:	68 00 a0 10 80       	push   $0x8010a000
80105792:	e8 d9 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[1] - num_digits(p->pid));
80105797:	8b 4b a4             	mov    -0x5c(%ebx),%ecx
  while(n!= 0) {
8010579a:	83 c4 10             	add    $0x10,%esp
8010579d:	85 c9                	test   %ecx,%ecx
8010579f:	0f 84 9b 03 00 00    	je     80105b40 <show_process_info+0x450>
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
801057c3:	75 eb                	jne    801057b0 <show_process_info+0xc0>
    space(columns[1] - num_digits(p->pid));
801057c5:	bf 0a 00 00 00       	mov    $0xa,%edi
801057ca:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
801057cc:	85 ff                	test   %edi,%edi
801057ce:	7e 1f                	jle    801057ef <show_process_info+0xff>
    space(columns[1] - num_digits(p->pid));
801057d0:	31 f6                	xor    %esi,%esi
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
801057d8:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801057db:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801057de:	68 69 a0 10 80       	push   $0x8010a069
801057e3:	e8 88 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801057e8:	83 c4 10             	add    $0x10,%esp
801057eb:	39 f7                	cmp    %esi,%edi
801057ed:	7f e9                	jg     801057d8 <show_process_info+0xe8>

    cprintf("%s", state);
801057ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801057f2:	83 ec 08             	sub    $0x8,%esp
801057f5:	57                   	push   %edi
801057f6:	68 c7 9f 10 80       	push   $0x80109fc7
801057fb:	e8 70 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[2] - strlen(state));
80105800:	89 3c 24             	mov    %edi,(%esp)
80105803:	bf 0a 00 00 00       	mov    $0xa,%edi
80105808:	e8 b3 0c 00 00       	call   801064c0 <strlen>
  for(int i = 0; i < count; ++i)
8010580d:	83 c4 10             	add    $0x10,%esp
    space(columns[2] - strlen(state));
80105810:	29 c7                	sub    %eax,%edi
  for(int i = 0; i < count; ++i)
80105812:	85 ff                	test   %edi,%edi
80105814:	7e 21                	jle    80105837 <show_process_info+0x147>
80105816:	31 f6                	xor    %esi,%esi
80105818:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010581f:	90                   	nop
    cprintf(" ");
80105820:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105823:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105826:	68 69 a0 10 80       	push   $0x8010a069
8010582b:	e8 40 b2 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105830:	83 c4 10             	add    $0x10,%esp
80105833:	39 f7                	cmp    %esi,%edi
80105835:	75 e9                	jne    80105820 <show_process_info+0x130>

    cprintf("%d", p->sched_info.level);
80105837:	83 ec 08             	sub    $0x8,%esp
8010583a:	ff 73 18             	push   0x18(%ebx)
8010583d:	68 00 a0 10 80       	push   $0x8010a000
80105842:	e8 29 b2 ff ff       	call   80100a70 <cprintf>
    space(columns[3] - num_digits(p->sched_info.level));
80105847:	8b 4b 18             	mov    0x18(%ebx),%ecx
  while(n!= 0) {
8010584a:	83 c4 10             	add    $0x10,%esp
8010584d:	85 c9                	test   %ecx,%ecx
8010584f:	0f 84 db 02 00 00    	je     80105b30 <show_process_info+0x440>
  int num = 0;
80105855:	31 f6                	xor    %esi,%esi
    n/=10;
80105857:	bf 67 66 66 66       	mov    $0x66666667,%edi
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105860:	89 c8                	mov    %ecx,%eax
    num += 1;
80105862:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105865:	f7 ef                	imul   %edi
80105867:	89 c8                	mov    %ecx,%eax
80105869:	c1 f8 1f             	sar    $0x1f,%eax
8010586c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010586f:	89 d1                	mov    %edx,%ecx
80105871:	29 c1                	sub    %eax,%ecx
80105873:	75 eb                	jne    80105860 <show_process_info+0x170>
    space(columns[3] - num_digits(p->sched_info.level));
80105875:	bf 0a 00 00 00       	mov    $0xa,%edi
8010587a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
8010587c:	85 ff                	test   %edi,%edi
8010587e:	7e 1f                	jle    8010589f <show_process_info+0x1af>
    space(columns[3] - num_digits(p->sched_info.level));
80105880:	31 f6                	xor    %esi,%esi
80105882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105888:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
8010588b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
8010588e:	68 69 a0 10 80       	push   $0x8010a069
80105893:	e8 d8 b1 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105898:	83 c4 10             	add    $0x10,%esp
8010589b:	39 fe                	cmp    %edi,%esi
8010589d:	7c e9                	jl     80105888 <show_process_info+0x198>

    cprintf("%d", (int)p->sched_info.burst_time);
8010589f:	83 ec 08             	sub    $0x8,%esp
801058a2:	ff 73 1c             	push   0x1c(%ebx)
801058a5:	68 00 a0 10 80       	push   $0x8010a000
801058aa:	e8 c1 b1 ff ff       	call   80100a70 <cprintf>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
801058af:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  while(n!= 0) {
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	85 c9                	test   %ecx,%ecx
801058b7:	0f 84 63 02 00 00    	je     80105b20 <show_process_info+0x430>
  int num = 0;
801058bd:	31 f6                	xor    %esi,%esi
    n/=10;
801058bf:	bf 67 66 66 66       	mov    $0x66666667,%edi
801058c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058c8:	89 c8                	mov    %ecx,%eax
    num += 1;
801058ca:	83 c6 01             	add    $0x1,%esi
    n/=10;
801058cd:	f7 ef                	imul   %edi
801058cf:	89 c8                	mov    %ecx,%eax
801058d1:	c1 f8 1f             	sar    $0x1f,%eax
801058d4:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801058d7:	29 c2                	sub    %eax,%edx
801058d9:	89 d1                	mov    %edx,%ecx
801058db:	75 eb                	jne    801058c8 <show_process_info+0x1d8>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
801058dd:	bf 0a 00 00 00       	mov    $0xa,%edi
801058e2:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
801058e4:	85 ff                	test   %edi,%edi
801058e6:	7e 1f                	jle    80105907 <show_process_info+0x217>
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
801058e8:	31 f6                	xor    %esi,%esi
801058ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
801058f0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801058f3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801058f6:	68 69 a0 10 80       	push   $0x8010a069
801058fb:	e8 70 b1 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105900:	83 c4 10             	add    $0x10,%esp
80105903:	39 fe                	cmp    %edi,%esi
80105905:	7c e9                	jl     801058f0 <show_process_info+0x200>

    cprintf("%d", ticks - p->sched_info.last_exe_time);
80105907:	83 ec 08             	sub    $0x8,%esp
8010590a:	a1 c4 99 11 80       	mov    0x801199c4,%eax
8010590f:	2b 43 20             	sub    0x20(%ebx),%eax
80105912:	50                   	push   %eax
80105913:	68 00 a0 10 80       	push   $0x8010a000
80105918:	e8 53 b1 ff ff       	call   80100a70 <cprintf>
    space(columns[5] - num_digits(ticks - p->sched_info.last_exe_time));
8010591d:	8b 0d c4 99 11 80    	mov    0x801199c4,%ecx
  while(n!= 0) {
80105923:	83 c4 10             	add    $0x10,%esp
80105926:	2b 4b 20             	sub    0x20(%ebx),%ecx
80105929:	0f 84 e1 01 00 00    	je     80105b10 <show_process_info+0x420>
  int num = 0;
8010592f:	31 f6                	xor    %esi,%esi
    n/=10;
80105931:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010593d:	8d 76 00             	lea    0x0(%esi),%esi
80105940:	89 c8                	mov    %ecx,%eax
    num += 1;
80105942:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105945:	f7 ef                	imul   %edi
80105947:	89 c8                	mov    %ecx,%eax
80105949:	c1 f8 1f             	sar    $0x1f,%eax
8010594c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010594f:	89 d1                	mov    %edx,%ecx
80105951:	29 c1                	sub    %eax,%ecx
80105953:	75 eb                	jne    80105940 <show_process_info+0x250>
    space(columns[5] - num_digits(ticks - p->sched_info.last_exe_time));
80105955:	bf 0a 00 00 00       	mov    $0xa,%edi
8010595a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
8010595c:	85 ff                	test   %edi,%edi
8010595e:	7e 1f                	jle    8010597f <show_process_info+0x28f>
    space(columns[5] - num_digits(ticks - p->sched_info.last_exe_time));
80105960:	31 f6                	xor    %esi,%esi
80105962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105968:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
8010596b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
8010596e:	68 69 a0 10 80       	push   $0x8010a069
80105973:	e8 f8 b0 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105978:	83 c4 10             	add    $0x10,%esp
8010597b:	39 fe                	cmp    %edi,%esi
8010597d:	7c e9                	jl     80105968 <show_process_info+0x278>

    cprintf("%d", p->sched_info.enter_level_time);
8010597f:	83 ec 08             	sub    $0x8,%esp
80105982:	ff 73 28             	push   0x28(%ebx)
80105985:	68 00 a0 10 80       	push   $0x8010a000
8010598a:	e8 e1 b0 ff ff       	call   80100a70 <cprintf>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
8010598f:	8b 4b 28             	mov    0x28(%ebx),%ecx
  while(n!= 0) {
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	85 c9                	test   %ecx,%ecx
80105997:	0f 84 63 01 00 00    	je     80105b00 <show_process_info+0x410>
  int num = 0;
8010599d:	31 f6                	xor    %esi,%esi
    n/=10;
8010599f:	bf 67 66 66 66       	mov    $0x66666667,%edi
801059a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059a8:	89 c8                	mov    %ecx,%eax
    num += 1;
801059aa:	83 c6 01             	add    $0x1,%esi
    n/=10;
801059ad:	f7 ef                	imul   %edi
801059af:	89 c8                	mov    %ecx,%eax
801059b1:	c1 f8 1f             	sar    $0x1f,%eax
801059b4:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801059b7:	29 c2                	sub    %eax,%edx
801059b9:	89 d1                	mov    %edx,%ecx
801059bb:	75 eb                	jne    801059a8 <show_process_info+0x2b8>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
801059bd:	bf 0f 00 00 00       	mov    $0xf,%edi
801059c2:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
801059c4:	85 ff                	test   %edi,%edi
801059c6:	7e 1f                	jle    801059e7 <show_process_info+0x2f7>
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
801059c8:	31 f6                	xor    %esi,%esi
801059ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
801059d0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801059d3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801059d6:	68 69 a0 10 80       	push   $0x8010a069
801059db:	e8 90 b0 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
801059e0:	83 c4 10             	add    $0x10,%esp
801059e3:	39 fe                	cmp    %edi,%esi
801059e5:	7c e9                	jl     801059d0 <show_process_info+0x2e0>

    cprintf("%d", (int)p->sched_info.confidence);
801059e7:	83 ec 08             	sub    $0x8,%esp
801059ea:	ff 73 2c             	push   0x2c(%ebx)
801059ed:	68 00 a0 10 80       	push   $0x8010a000
801059f2:	e8 79 b0 ff ff       	call   80100a70 <cprintf>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
801059f7:	8b 4b 2c             	mov    0x2c(%ebx),%ecx
  while(n!= 0) {
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	85 c9                	test   %ecx,%ecx
801059ff:	0f 84 eb 00 00 00    	je     80105af0 <show_process_info+0x400>
  int num = 0;
80105a05:	31 f6                	xor    %esi,%esi
    n/=10;
80105a07:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a10:	89 c8                	mov    %ecx,%eax
    num += 1;
80105a12:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105a15:	f7 ef                	imul   %edi
80105a17:	89 c8                	mov    %ecx,%eax
80105a19:	c1 f8 1f             	sar    $0x1f,%eax
80105a1c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105a1f:	89 d1                	mov    %edx,%ecx
80105a21:	29 c1                	sub    %eax,%ecx
80105a23:	75 eb                	jne    80105a10 <show_process_info+0x320>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105a25:	bf 0c 00 00 00       	mov    $0xc,%edi
80105a2a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
80105a2c:	85 ff                	test   %edi,%edi
80105a2e:	7e 1f                	jle    80105a4f <show_process_info+0x35f>
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105a30:	31 f6                	xor    %esi,%esi
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105a38:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105a3b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105a3e:	68 69 a0 10 80       	push   $0x8010a069
80105a43:	e8 28 b0 ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105a48:	83 c4 10             	add    $0x10,%esp
80105a4b:	39 fe                	cmp    %edi,%esi
80105a4d:	7c e9                	jl     80105a38 <show_process_info+0x348>

    cprintf("%d", (int)p->sched_info.num_of_cycles);
80105a4f:	83 ec 08             	sub    $0x8,%esp
80105a52:	ff 73 30             	push   0x30(%ebx)
80105a55:	68 00 a0 10 80       	push   $0x8010a000
80105a5a:	e8 11 b0 ff ff       	call   80100a70 <cprintf>
    space(columns[7] - num_digits((int)p->sched_info.num_of_cycles));
80105a5f:	8b 4b 30             	mov    0x30(%ebx),%ecx
  while(n!= 0) {
80105a62:	83 c4 10             	add    $0x10,%esp
80105a65:	85 c9                	test   %ecx,%ecx
80105a67:	74 77                	je     80105ae0 <show_process_info+0x3f0>
  int num = 0;
80105a69:	31 f6                	xor    %esi,%esi
    n/=10;
80105a6b:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105a70:	89 c8                	mov    %ecx,%eax
    num += 1;
80105a72:	83 c6 01             	add    $0x1,%esi
    n/=10;
80105a75:	f7 ef                	imul   %edi
80105a77:	89 c8                	mov    %ecx,%eax
80105a79:	c1 f8 1f             	sar    $0x1f,%eax
80105a7c:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105a7f:	29 c2                	sub    %eax,%edx
80105a81:	89 d1                	mov    %edx,%ecx
80105a83:	75 eb                	jne    80105a70 <show_process_info+0x380>
    space(columns[7] - num_digits((int)p->sched_info.num_of_cycles));
80105a85:	bf 0c 00 00 00       	mov    $0xc,%edi
80105a8a:	29 f7                	sub    %esi,%edi
  for(int i = 0; i < count; ++i)
80105a8c:	85 ff                	test   %edi,%edi
80105a8e:	7e 1f                	jle    80105aaf <show_process_info+0x3bf>
    space(columns[7] - num_digits((int)p->sched_info.num_of_cycles));
80105a90:	31 f6                	xor    %esi,%esi
80105a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80105a98:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105a9b:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105a9e:	68 69 a0 10 80       	push   $0x8010a069
80105aa3:	e8 c8 af ff ff       	call   80100a70 <cprintf>
  for(int i = 0; i < count; ++i)
80105aa8:	83 c4 10             	add    $0x10,%esp
80105aab:	39 fe                	cmp    %edi,%esi
80105aad:	7c e9                	jl     80105a98 <show_process_info+0x3a8>
    cprintf("\n");
80105aaf:	83 ec 0c             	sub    $0xc,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105ab2:	81 c3 14 01 00 00    	add    $0x114,%ebx
    cprintf("\n");
80105ab8:	68 11 a0 10 80       	push   $0x8010a011
80105abd:	e8 ae af ff ff       	call   80100a70 <cprintf>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105ac2:	b8 8c 9a 11 80       	mov    $0x80119a8c,%eax
    cprintf("\n");
80105ac7:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105aca:	39 d8                	cmp    %ebx,%eax
80105acc:	0f 85 51 fc ff ff    	jne    80105723 <show_process_info+0x33>
  }
} 
80105ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ad5:	5b                   	pop    %ebx
80105ad6:	5e                   	pop    %esi
80105ad7:	5f                   	pop    %edi
80105ad8:	5d                   	pop    %ebp
80105ad9:	c3                   	ret    
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[7] - num_digits((int)p->sched_info.num_of_cycles));
80105ae0:	bf 0c 00 00 00       	mov    $0xc,%edi
80105ae5:	eb a9                	jmp    80105a90 <show_process_info+0x3a0>
80105ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aee:	66 90                	xchg   %ax,%ax
    space(columns[7] - num_digits((int)p->sched_info.confidence));
80105af0:	bf 0c 00 00 00       	mov    $0xc,%edi
80105af5:	e9 36 ff ff ff       	jmp    80105a30 <show_process_info+0x340>
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[6] - num_digits(p->sched_info.enter_level_time));
80105b00:	bf 0f 00 00 00       	mov    $0xf,%edi
80105b05:	e9 be fe ff ff       	jmp    801059c8 <show_process_info+0x2d8>
80105b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[5] - num_digits(ticks - p->sched_info.last_exe_time));
80105b10:	bf 0a 00 00 00       	mov    $0xa,%edi
80105b15:	e9 46 fe ff ff       	jmp    80105960 <show_process_info+0x270>
80105b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[4] - num_digits((int)p->sched_info.burst_time));
80105b20:	bf 0a 00 00 00       	mov    $0xa,%edi
80105b25:	e9 be fd ff ff       	jmp    801058e8 <show_process_info+0x1f8>
80105b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[3] - num_digits(p->sched_info.level));
80105b30:	bf 0a 00 00 00       	mov    $0xa,%edi
80105b35:	e9 46 fd ff ff       	jmp    80105880 <show_process_info+0x190>
80105b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[1] - num_digits(p->pid));
80105b40:	bf 0a 00 00 00       	mov    $0xa,%edi
80105b45:	e9 86 fc ff ff       	jmp    801057d0 <show_process_info+0xe0>
80105b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b50 <set_burst_confidence>:

void set_burst_confidence(int pid, int burst, int conf)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	57                   	push   %edi
80105b54:	56                   	push   %esi
80105b55:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105b56:	bb b4 54 11 80       	mov    $0x801154b4,%ebx
{
80105b5b:	83 ec 18             	sub    $0x18,%esp
80105b5e:	8b 75 08             	mov    0x8(%ebp),%esi
80105b61:	8b 7d 10             	mov    0x10(%ebp),%edi
  acquire(&ptable.lock);
80105b64:	68 80 54 11 80       	push   $0x80115480
80105b69:	e8 92 06 00 00       	call   80106200 <acquire>
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	eb 17                	jmp    80105b8a <set_burst_confidence+0x3a>
80105b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b77:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105b78:	81 c3 14 01 00 00    	add    $0x114,%ebx
80105b7e:	81 fb b4 99 11 80    	cmp    $0x801199b4,%ebx
80105b84:	0f 84 53 03 00 00    	je     80105edd <set_burst_confidence.cold>
    if (p->pid == pid)
80105b8a:	3b 73 7c             	cmp    0x7c(%ebx),%esi
80105b8d:	75 e9                	jne    80105b78 <set_burst_confidence+0x28>
      release(&ptable.lock); // Release the lock before returning.
80105b8f:	83 ec 0c             	sub    $0xc,%esp
80105b92:	68 80 54 11 80       	push   $0x80115480
80105b97:	e8 04 06 00 00       	call   801061a0 <release>
  struct proc *p = findproc(pid);
  p->sched_info.burst_time = burst;
80105b9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  p->sched_info.confidence = conf;
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105b9f:	57                   	push   %edi
  p->sched_info.confidence = conf;
80105ba0:	89 bb 04 01 00 00    	mov    %edi,0x104(%ebx)
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105ba6:	50                   	push   %eax
80105ba7:	56                   	push   %esi
80105ba8:	68 88 a1 10 80       	push   $0x8010a188
  p->sched_info.burst_time = burst;
80105bad:	89 83 f4 00 00 00    	mov    %eax,0xf4(%ebx)
  cprintf("pid: %d new_burst: %d new_confidence: %d\n", pid, p->sched_info.burst_time, p->sched_info.confidence);
80105bb3:	e8 b8 ae ff ff       	call   80100a70 <cprintf>
  return 0;
}
80105bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bbb:	5b                   	pop    %ebx
80105bbc:	5e                   	pop    %esi
80105bbd:	5f                   	pop    %edi
80105bbe:	5d                   	pop    %ebp
80105bbf:	c3                   	ret    

80105bc0 <add_cpu_syscalls>:

void add_cpu_syscalls(uint my_eax)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 08             	sub    $0x8,%esp
80105bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  if(my_eax == SYS_open)
80105bc9:	83 f8 0f             	cmp    $0xf,%eax
80105bcc:	74 32                	je     80105c00 <add_cpu_syscalls+0x40>
    mycpu()->count_syscalls += 3;
  if(my_eax == SYS_write)
80105bce:	83 f8 10             	cmp    $0x10,%eax
80105bd1:	74 15                	je     80105be8 <add_cpu_syscalls+0x28>
    mycpu()->count_syscalls += 2;
  else
    mycpu()->count_syscalls += 1;
80105bd3:	e8 28 eb ff ff       	call   80104700 <mycpu>
80105bd8:	83 80 bc 00 00 00 01 	addl   $0x1,0xbc(%eax)

}
80105bdf:	c9                   	leave  
80105be0:	c3                   	ret    
80105be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    mycpu()->count_syscalls += 2;
80105be8:	e8 13 eb ff ff       	call   80104700 <mycpu>
80105bed:	83 80 bc 00 00 00 02 	addl   $0x2,0xbc(%eax)
}
80105bf4:	c9                   	leave  
80105bf5:	c3                   	ret    
80105bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bfd:	8d 76 00             	lea    0x0(%esi),%esi
    mycpu()->count_syscalls += 3;
80105c00:	e8 fb ea ff ff       	call   80104700 <mycpu>
80105c05:	83 80 bc 00 00 00 03 	addl   $0x3,0xbc(%eax)
    mycpu()->count_syscalls += 1;
80105c0c:	e8 ef ea ff ff       	call   80104700 <mycpu>
80105c11:	83 80 bc 00 00 00 01 	addl   $0x1,0xbc(%eax)
80105c18:	eb c5                	jmp    80105bdf <add_cpu_syscalls+0x1f>
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c20 <sum_all_cpus_syscalls>:

int sum_all_cpus_syscalls()
{
  int count = 0;
  for(int i=0; i<NCPU; i++)
80105c20:	b8 fc 4e 11 80       	mov    $0x80114efc,%eax
  int count = 0;
80105c25:	31 d2                	xor    %edx,%edx
80105c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2e:	66 90                	xchg   %ax,%ax
    count += cpus[i].count_syscalls;
80105c30:	03 10                	add    (%eax),%edx
  for(int i=0; i<NCPU; i++)
80105c32:	05 c0 00 00 00       	add    $0xc0,%eax
80105c37:	3d fc 54 11 80       	cmp    $0x801154fc,%eax
80105c3c:	75 f2                	jne    80105c30 <sum_all_cpus_syscalls+0x10>
  return count;
}
80105c3e:	89 d0                	mov    %edx,%eax
80105c40:	c3                   	ret    
80105c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c4f:	90                   	nop

80105c50 <initreentrantlock>:

// jadid brona
void
initreentrantlock(char* name)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	83 ec 10             	sub    $0x10,%esp
  initlock(&rlock.lock, name);
80105c56:	ff 75 08             	push   0x8(%ebp)
80105c59:	68 40 54 11 80       	push   $0x80115440
80105c5e:	e8 cd 03 00 00       	call   80106030 <initlock>
  rlock.owner = 0;
  rlock.recursion = 0;
}
80105c63:	83 c4 10             	add    $0x10,%esp
  rlock.owner = 0;
80105c66:	c7 05 74 54 11 80 00 	movl   $0x0,0x80115474
80105c6d:	00 00 00 
  rlock.recursion = 0;
80105c70:	c7 05 78 54 11 80 00 	movl   $0x0,0x80115478
80105c77:	00 00 00 
}
80105c7a:	c9                   	leave  
80105c7b:	c3                   	ret    
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <acquirereentrantlock>:

void
acquirereentrantlock()
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	56                   	push   %esi
  if(rlock.owner == myproc())
80105c84:	8b 35 74 54 11 80    	mov    0x80115474,%esi
{
80105c8a:	53                   	push   %ebx
  pushcli();
80105c8b:	e8 20 04 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105c90:	e8 6b ea ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105c95:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105c9b:	e8 60 04 00 00       	call   80106100 <popcli>
  {
    rlock.recursion++;
80105ca0:	a1 78 54 11 80       	mov    0x80115478,%eax
80105ca5:	83 c0 01             	add    $0x1,%eax
  if(rlock.owner == myproc())
80105ca8:	39 de                	cmp    %ebx,%esi
80105caa:	74 30                	je     80105cdc <acquirereentrantlock+0x5c>
    return;
  }
  acquire(&rlock.lock);
80105cac:	83 ec 0c             	sub    $0xc,%esp
80105caf:	68 40 54 11 80       	push   $0x80115440
80105cb4:	e8 47 05 00 00       	call   80106200 <acquire>
  pushcli();
80105cb9:	e8 f2 03 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105cbe:	e8 3d ea ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105cc3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105cc9:	e8 32 04 00 00       	call   80106100 <popcli>
  rlock.owner = myproc();
80105cce:	83 c4 10             	add    $0x10,%esp
80105cd1:	b8 01 00 00 00       	mov    $0x1,%eax
80105cd6:	89 1d 74 54 11 80    	mov    %ebx,0x80115474
    rlock.recursion++;
80105cdc:	a3 78 54 11 80       	mov    %eax,0x80115478
  rlock.recursion = 1;
}
80105ce1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ce4:	5b                   	pop    %ebx
80105ce5:	5e                   	pop    %esi
80105ce6:	5d                   	pop    %ebp
80105ce7:	c3                   	ret    
80105ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cef:	90                   	nop

80105cf0 <releasereentrantlock>:

void
releasereentrantlock()
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	56                   	push   %esi
80105cf4:	53                   	push   %ebx
  pushcli();
80105cf5:	e8 b6 03 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105cfa:	e8 01 ea ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105cff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105d05:	e8 f6 03 00 00       	call   80106100 <popcli>
  cprintf("mmm %d mmm %d \n", rlock.owner->pid, myproc()->pid);
80105d0a:	a1 74 54 11 80       	mov    0x80115474,%eax
80105d0f:	83 ec 04             	sub    $0x4,%esp
80105d12:	ff 73 7c             	push   0x7c(%ebx)
80105d15:	ff 70 7c             	push   0x7c(%eax)
80105d18:	68 03 a0 10 80       	push   $0x8010a003
80105d1d:	e8 4e ad ff ff       	call   80100a70 <cprintf>
  if(rlock.owner == myproc())
80105d22:	8b 35 74 54 11 80    	mov    0x80115474,%esi
  pushcli();
80105d28:	e8 83 03 00 00       	call   801060b0 <pushcli>
  c = mycpu();
80105d2d:	e8 ce e9 ff ff       	call   80104700 <mycpu>
  p = c->proc;
80105d32:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105d38:	e8 c3 03 00 00       	call   80106100 <popcli>
  if(rlock.owner == myproc())
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	39 de                	cmp    %ebx,%esi
80105d42:	75 3c                	jne    80105d80 <releasereentrantlock+0x90>
  {
    rlock.recursion--;
80105d44:	a1 78 54 11 80       	mov    0x80115478,%eax
80105d49:	83 e8 01             	sub    $0x1,%eax
80105d4c:	a3 78 54 11 80       	mov    %eax,0x80115478
    if (rlock.recursion > 0)
80105d51:	85 c0                	test   %eax,%eax
80105d53:	7f 24                	jg     80105d79 <releasereentrantlock+0x89>
      return;
    release(&rlock.lock);
80105d55:	83 ec 0c             	sub    $0xc,%esp
80105d58:	68 40 54 11 80       	push   $0x80115440
80105d5d:	e8 3e 04 00 00       	call   801061a0 <release>
    rlock.owner = 0;
    rlock.recursion = 0;   
80105d62:	83 c4 10             	add    $0x10,%esp
    rlock.owner = 0;
80105d65:	c7 05 74 54 11 80 00 	movl   $0x0,0x80115474
80105d6c:	00 00 00 
    rlock.recursion = 0;   
80105d6f:	c7 05 78 54 11 80 00 	movl   $0x0,0x80115478
80105d76:	00 00 00 
  }
  else
    panic("First acquire the Reentrantlock.\n");
}
80105d79:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d7c:	5b                   	pop    %ebx
80105d7d:	5e                   	pop    %esi
80105d7e:	5d                   	pop    %ebp
80105d7f:	c3                   	ret    
    panic("First acquire the Reentrantlock.\n");
80105d80:	83 ec 0c             	sub    $0xc,%esp
80105d83:	68 b4 a1 10 80       	push   $0x8010a1b4
80105d88:	e8 63 a7 ff ff       	call   801004f0 <panic>
80105d8d:	8d 76 00             	lea    0x0(%esi),%esi

80105d90 <initrlock>:

void initrlock()
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	83 ec 10             	sub    $0x10,%esp
  initlock(&rlock.lock, name);
80105d96:	68 13 a0 10 80       	push   $0x8010a013
80105d9b:	68 40 54 11 80       	push   $0x80115440
80105da0:	e8 8b 02 00 00       	call   80106030 <initlock>
  initreentrantlock("borna ali");
}
80105da5:	83 c4 10             	add    $0x10,%esp
  rlock.owner = 0;
80105da8:	c7 05 74 54 11 80 00 	movl   $0x0,0x80115474
80105daf:	00 00 00 
  rlock.recursion = 0;
80105db2:	c7 05 78 54 11 80 00 	movl   $0x0,0x80115478
80105db9:	00 00 00 
}
80105dbc:	c9                   	leave  
80105dbd:	c3                   	ret    
80105dbe:	66 90                	xchg   %ax,%ax

80105dc0 <test_reentrantlock>:

int test_reentrantlock(int num)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	53                   	push   %ebx
80105dc4:	83 ec 04             	sub    $0x4,%esp
80105dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!num)
80105dca:	85 db                	test   %ebx,%ebx
80105dcc:	0f 84 96 00 00 00    	je     80105e68 <test_reentrantlock+0xa8>
  {
    cprintf("return from func\n");
    return;
  }
  acquirereentrantlock();
80105dd2:	e8 a9 fe ff ff       	call   80105c80 <acquirereentrantlock>
  if(!num)
80105dd7:	83 fb 01             	cmp    $0x1,%ebx
80105dda:	74 6c                	je     80105e48 <test_reentrantlock+0x88>
  acquirereentrantlock();
80105ddc:	e8 9f fe ff ff       	call   80105c80 <acquirereentrantlock>
  if(!num)
80105de1:	83 fb 02             	cmp    $0x2,%ebx
80105de4:	0f 84 ae 00 00 00    	je     80105e98 <test_reentrantlock+0xd8>
  acquirereentrantlock();
80105dea:	e8 91 fe ff ff       	call   80105c80 <acquirereentrantlock>
  if(!num)
80105def:	83 fb 03             	cmp    $0x3,%ebx
80105df2:	0f 84 88 00 00 00    	je     80105e80 <test_reentrantlock+0xc0>
  acquirereentrantlock();
80105df8:	e8 83 fe ff ff       	call   80105c80 <acquirereentrantlock>
  if(!num)
80105dfd:	83 fb 04             	cmp    $0x4,%ebx
80105e00:	0f 84 aa 00 00 00    	je     80105eb0 <test_reentrantlock+0xf0>
  acquirereentrantlock();
80105e06:	e8 75 fe ff ff       	call   80105c80 <acquirereentrantlock>
  if(!num)
80105e0b:	83 fb 05             	cmp    $0x5,%ebx
80105e0e:	0f 84 b4 00 00 00    	je     80105ec8 <test_reentrantlock+0x108>
  acquirereentrantlock();
80105e14:	e8 67 fe ff ff       	call   80105c80 <acquirereentrantlock>
  num--;
80105e19:	83 eb 06             	sub    $0x6,%ebx
  test_reentrantlock(num);
80105e1c:	83 ec 0c             	sub    $0xc,%esp
80105e1f:	53                   	push   %ebx
80105e20:	e8 9b ff ff ff       	call   80105dc0 <test_reentrantlock>
  releasereentrantlock();
80105e25:	e8 c6 fe ff ff       	call   80105cf0 <releasereentrantlock>
  return 0;
80105e2a:	83 c4 10             	add    $0x10,%esp
  releasereentrantlock();
80105e2d:	e8 be fe ff ff       	call   80105cf0 <releasereentrantlock>
80105e32:	e8 b9 fe ff ff       	call   80105cf0 <releasereentrantlock>
80105e37:	e8 b4 fe ff ff       	call   80105cf0 <releasereentrantlock>
80105e3c:	e8 af fe ff ff       	call   80105cf0 <releasereentrantlock>
  return 0;
80105e41:	eb 15                	jmp    80105e58 <test_reentrantlock+0x98>
80105e43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e47:	90                   	nop
    cprintf("return from func\n");
80105e48:	83 ec 0c             	sub    $0xc,%esp
80105e4b:	68 1d a0 10 80       	push   $0x8010a01d
80105e50:	e8 1b ac ff ff       	call   80100a70 <cprintf>
    return;
80105e55:	83 c4 10             	add    $0x10,%esp
  releasereentrantlock();
80105e58:	e8 93 fe ff ff       	call   80105cf0 <releasereentrantlock>
80105e5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105e60:	31 c0                	xor    %eax,%eax
80105e62:	c9                   	leave  
80105e63:	c3                   	ret    
80105e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("return from func\n");
80105e68:	83 ec 0c             	sub    $0xc,%esp
80105e6b:	68 1d a0 10 80       	push   $0x8010a01d
80105e70:	e8 fb ab ff ff       	call   80100a70 <cprintf>
80105e75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e78:	c9                   	leave  
80105e79:	c3                   	ret    
80105e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("return from func\n");
80105e80:	83 ec 0c             	sub    $0xc,%esp
80105e83:	68 1d a0 10 80       	push   $0x8010a01d
80105e88:	e8 e3 ab ff ff       	call   80100a70 <cprintf>
    return;
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	eb a5                	jmp    80105e37 <test_reentrantlock+0x77>
80105e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("return from func\n");
80105e98:	83 ec 0c             	sub    $0xc,%esp
80105e9b:	68 1d a0 10 80       	push   $0x8010a01d
80105ea0:	e8 cb ab ff ff       	call   80100a70 <cprintf>
    return;
80105ea5:	83 c4 10             	add    $0x10,%esp
80105ea8:	eb 92                	jmp    80105e3c <test_reentrantlock+0x7c>
80105eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("return from func\n");
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	68 1d a0 10 80       	push   $0x8010a01d
80105eb8:	e8 b3 ab ff ff       	call   80100a70 <cprintf>
    return;
80105ebd:	83 c4 10             	add    $0x10,%esp
80105ec0:	e9 6d ff ff ff       	jmp    80105e32 <test_reentrantlock+0x72>
80105ec5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("return from func\n");
80105ec8:	83 ec 0c             	sub    $0xc,%esp
80105ecb:	68 1d a0 10 80       	push   $0x8010a01d
80105ed0:	e8 9b ab ff ff       	call   80100a70 <cprintf>
    return;
80105ed5:	83 c4 10             	add    $0x10,%esp
80105ed8:	e9 50 ff ff ff       	jmp    80105e2d <test_reentrantlock+0x6d>

80105edd <set_burst_confidence.cold>:
  release(&ptable.lock);
80105edd:	83 ec 0c             	sub    $0xc,%esp
80105ee0:	68 80 54 11 80       	push   $0x80115480
80105ee5:	e8 b6 02 00 00       	call   801061a0 <release>
  p->sched_info.burst_time = burst;
80105eea:	c7 05 f4 00 00 00 00 	movl   $0x0,0xf4
80105ef1:	00 00 00 
80105ef4:	0f 0b                	ud2    
80105ef6:	66 90                	xchg   %ax,%ax
80105ef8:	66 90                	xchg   %ax,%ax
80105efa:	66 90                	xchg   %ax,%ax
80105efc:	66 90                	xchg   %ax,%ax
80105efe:	66 90                	xchg   %ax,%ax

80105f00 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	53                   	push   %ebx
80105f04:	83 ec 0c             	sub    $0xc,%esp
80105f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80105f0a:	68 08 a2 10 80       	push   $0x8010a208
80105f0f:	8d 43 04             	lea    0x4(%ebx),%eax
80105f12:	50                   	push   %eax
80105f13:	e8 18 01 00 00       	call   80106030 <initlock>
  lk->name = name;
80105f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105f1b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105f21:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105f24:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80105f2b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105f2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f31:	c9                   	leave  
80105f32:	c3                   	ret    
80105f33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f40 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	56                   	push   %esi
80105f44:	53                   	push   %ebx
80105f45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105f48:	8d 73 04             	lea    0x4(%ebx),%esi
80105f4b:	83 ec 0c             	sub    $0xc,%esp
80105f4e:	56                   	push   %esi
80105f4f:	e8 ac 02 00 00       	call   80106200 <acquire>
  while (lk->locked) {
80105f54:	8b 13                	mov    (%ebx),%edx
80105f56:	83 c4 10             	add    $0x10,%esp
80105f59:	85 d2                	test   %edx,%edx
80105f5b:	74 16                	je     80105f73 <acquiresleep+0x33>
80105f5d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105f60:	83 ec 08             	sub    $0x8,%esp
80105f63:	56                   	push   %esi
80105f64:	53                   	push   %ebx
80105f65:	e8 06 f4 ff ff       	call   80105370 <sleep>
  while (lk->locked) {
80105f6a:	8b 03                	mov    (%ebx),%eax
80105f6c:	83 c4 10             	add    $0x10,%esp
80105f6f:	85 c0                	test   %eax,%eax
80105f71:	75 ed                	jne    80105f60 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105f73:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105f79:	e8 02 e8 ff ff       	call   80104780 <myproc>
80105f7e:	8b 40 7c             	mov    0x7c(%eax),%eax
80105f81:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105f84:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105f87:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f8a:	5b                   	pop    %ebx
80105f8b:	5e                   	pop    %esi
80105f8c:	5d                   	pop    %ebp
  release(&lk->lk);
80105f8d:	e9 0e 02 00 00       	jmp    801061a0 <release>
80105f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fa0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	56                   	push   %esi
80105fa4:	53                   	push   %ebx
80105fa5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105fa8:	8d 73 04             	lea    0x4(%ebx),%esi
80105fab:	83 ec 0c             	sub    $0xc,%esp
80105fae:	56                   	push   %esi
80105faf:	e8 4c 02 00 00       	call   80106200 <acquire>
  lk->locked = 0;
80105fb4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105fba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105fc1:	89 1c 24             	mov    %ebx,(%esp)
80105fc4:	e8 77 f4 ff ff       	call   80105440 <wakeup>
  release(&lk->lk);
80105fc9:	89 75 08             	mov    %esi,0x8(%ebp)
80105fcc:	83 c4 10             	add    $0x10,%esp
}
80105fcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fd2:	5b                   	pop    %ebx
80105fd3:	5e                   	pop    %esi
80105fd4:	5d                   	pop    %ebp
  release(&lk->lk);
80105fd5:	e9 c6 01 00 00       	jmp    801061a0 <release>
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fe0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	57                   	push   %edi
80105fe4:	31 ff                	xor    %edi,%edi
80105fe6:	56                   	push   %esi
80105fe7:	53                   	push   %ebx
80105fe8:	83 ec 18             	sub    $0x18,%esp
80105feb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105fee:	8d 73 04             	lea    0x4(%ebx),%esi
80105ff1:	56                   	push   %esi
80105ff2:	e8 09 02 00 00       	call   80106200 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105ff7:	8b 03                	mov    (%ebx),%eax
80105ff9:	83 c4 10             	add    $0x10,%esp
80105ffc:	85 c0                	test   %eax,%eax
80105ffe:	75 18                	jne    80106018 <holdingsleep+0x38>
  release(&lk->lk);
80106000:	83 ec 0c             	sub    $0xc,%esp
80106003:	56                   	push   %esi
80106004:	e8 97 01 00 00       	call   801061a0 <release>
  return r;
}
80106009:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010600c:	89 f8                	mov    %edi,%eax
8010600e:	5b                   	pop    %ebx
8010600f:	5e                   	pop    %esi
80106010:	5f                   	pop    %edi
80106011:	5d                   	pop    %ebp
80106012:	c3                   	ret    
80106013:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106017:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80106018:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010601b:	e8 60 e7 ff ff       	call   80104780 <myproc>
80106020:	39 58 7c             	cmp    %ebx,0x7c(%eax)
80106023:	0f 94 c0             	sete   %al
80106026:	0f b6 c0             	movzbl %al,%eax
80106029:	89 c7                	mov    %eax,%edi
8010602b:	eb d3                	jmp    80106000 <holdingsleep+0x20>
8010602d:	66 90                	xchg   %ax,%ax
8010602f:	90                   	nop

80106030 <initlock>:
#include "proc.h"
#include "spinlock.h"
 
void
initlock(struct spinlock *lk, char *name)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80106036:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80106039:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010603f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80106042:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80106049:	5d                   	pop    %ebp
8010604a:	c3                   	ret    
8010604b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010604f:	90                   	nop

80106050 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80106050:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80106051:	31 d2                	xor    %edx,%edx
{
80106053:	89 e5                	mov    %esp,%ebp
80106055:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80106056:	8b 45 08             	mov    0x8(%ebp),%eax
{
80106059:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010605c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010605f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106060:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80106066:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010606c:	77 1a                	ja     80106088 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010606e:	8b 58 04             	mov    0x4(%eax),%ebx
80106071:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80106074:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80106077:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80106079:	83 fa 0a             	cmp    $0xa,%edx
8010607c:	75 e2                	jne    80106060 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010607e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106081:	c9                   	leave  
80106082:	c3                   	ret    
80106083:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106087:	90                   	nop
  for(; i < 10; i++)
80106088:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010608b:	8d 51 28             	lea    0x28(%ecx),%edx
8010608e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80106090:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80106096:	83 c0 04             	add    $0x4,%eax
80106099:	39 d0                	cmp    %edx,%eax
8010609b:	75 f3                	jne    80106090 <getcallerpcs+0x40>
}
8010609d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801060a0:	c9                   	leave  
801060a1:	c3                   	ret    
801060a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	53                   	push   %ebx
801060b4:	83 ec 04             	sub    $0x4,%esp
801060b7:	9c                   	pushf  
801060b8:	5b                   	pop    %ebx
  asm volatile("cli");
801060b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801060ba:	e8 41 e6 ff ff       	call   80104700 <mycpu>
801060bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801060c5:	85 c0                	test   %eax,%eax
801060c7:	74 17                	je     801060e0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801060c9:	e8 32 e6 ff ff       	call   80104700 <mycpu>
801060ce:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801060d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801060d8:	c9                   	leave  
801060d9:	c3                   	ret    
801060da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801060e0:	e8 1b e6 ff ff       	call   80104700 <mycpu>
801060e5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801060eb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801060f1:	eb d6                	jmp    801060c9 <pushcli+0x19>
801060f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106100 <popcli>:

void
popcli(void)
{
80106100:	55                   	push   %ebp
80106101:	89 e5                	mov    %esp,%ebp
80106103:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80106106:	9c                   	pushf  
80106107:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80106108:	f6 c4 02             	test   $0x2,%ah
8010610b:	75 35                	jne    80106142 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010610d:	e8 ee e5 ff ff       	call   80104700 <mycpu>
80106112:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80106119:	78 34                	js     8010614f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010611b:	e8 e0 e5 ff ff       	call   80104700 <mycpu>
80106120:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80106126:	85 d2                	test   %edx,%edx
80106128:	74 06                	je     80106130 <popcli+0x30>
    sti();
8010612a:	c9                   	leave  
8010612b:	c3                   	ret    
8010612c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80106130:	e8 cb e5 ff ff       	call   80104700 <mycpu>
80106135:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010613b:	85 c0                	test   %eax,%eax
8010613d:	74 eb                	je     8010612a <popcli+0x2a>
  asm volatile("sti");
8010613f:	fb                   	sti    
80106140:	c9                   	leave  
80106141:	c3                   	ret    
    panic("popcli - interruptible");
80106142:	83 ec 0c             	sub    $0xc,%esp
80106145:	68 13 a2 10 80       	push   $0x8010a213
8010614a:	e8 a1 a3 ff ff       	call   801004f0 <panic>
    panic("popcli");
8010614f:	83 ec 0c             	sub    $0xc,%esp
80106152:	68 2a a2 10 80       	push   $0x8010a22a
80106157:	e8 94 a3 ff ff       	call   801004f0 <panic>
8010615c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106160 <holding>:
{
80106160:	55                   	push   %ebp
80106161:	89 e5                	mov    %esp,%ebp
80106163:	56                   	push   %esi
80106164:	53                   	push   %ebx
80106165:	8b 75 08             	mov    0x8(%ebp),%esi
80106168:	31 db                	xor    %ebx,%ebx
  pushcli();
8010616a:	e8 41 ff ff ff       	call   801060b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010616f:	8b 06                	mov    (%esi),%eax
80106171:	85 c0                	test   %eax,%eax
80106173:	75 0b                	jne    80106180 <holding+0x20>
  popcli();
80106175:	e8 86 ff ff ff       	call   80106100 <popcli>
}
8010617a:	89 d8                	mov    %ebx,%eax
8010617c:	5b                   	pop    %ebx
8010617d:	5e                   	pop    %esi
8010617e:	5d                   	pop    %ebp
8010617f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80106180:	8b 5e 08             	mov    0x8(%esi),%ebx
80106183:	e8 78 e5 ff ff       	call   80104700 <mycpu>
80106188:	39 c3                	cmp    %eax,%ebx
8010618a:	0f 94 c3             	sete   %bl
  popcli();
8010618d:	e8 6e ff ff ff       	call   80106100 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80106192:	0f b6 db             	movzbl %bl,%ebx
}
80106195:	89 d8                	mov    %ebx,%eax
80106197:	5b                   	pop    %ebx
80106198:	5e                   	pop    %esi
80106199:	5d                   	pop    %ebp
8010619a:	c3                   	ret    
8010619b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010619f:	90                   	nop

801061a0 <release>:
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	56                   	push   %esi
801061a4:	53                   	push   %ebx
801061a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801061a8:	e8 03 ff ff ff       	call   801060b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801061ad:	8b 03                	mov    (%ebx),%eax
801061af:	85 c0                	test   %eax,%eax
801061b1:	75 15                	jne    801061c8 <release+0x28>
  popcli();
801061b3:	e8 48 ff ff ff       	call   80106100 <popcli>
    panic("release");
801061b8:	83 ec 0c             	sub    $0xc,%esp
801061bb:	68 31 a2 10 80       	push   $0x8010a231
801061c0:	e8 2b a3 ff ff       	call   801004f0 <panic>
801061c5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801061c8:	8b 73 08             	mov    0x8(%ebx),%esi
801061cb:	e8 30 e5 ff ff       	call   80104700 <mycpu>
801061d0:	39 c6                	cmp    %eax,%esi
801061d2:	75 df                	jne    801061b3 <release+0x13>
  popcli();
801061d4:	e8 27 ff ff ff       	call   80106100 <popcli>
  lk->pcs[0] = 0;
801061d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801061e0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801061e7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801061ec:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801061f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061f5:	5b                   	pop    %ebx
801061f6:	5e                   	pop    %esi
801061f7:	5d                   	pop    %ebp
  popcli();
801061f8:	e9 03 ff ff ff       	jmp    80106100 <popcli>
801061fd:	8d 76 00             	lea    0x0(%esi),%esi

80106200 <acquire>:
{
80106200:	55                   	push   %ebp
80106201:	89 e5                	mov    %esp,%ebp
80106203:	53                   	push   %ebx
80106204:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80106207:	e8 a4 fe ff ff       	call   801060b0 <pushcli>
  if(holding(lk))
8010620c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010620f:	e8 9c fe ff ff       	call   801060b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80106214:	8b 03                	mov    (%ebx),%eax
80106216:	85 c0                	test   %eax,%eax
80106218:	75 7e                	jne    80106298 <acquire+0x98>
  popcli();
8010621a:	e8 e1 fe ff ff       	call   80106100 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010621f:	b9 01 00 00 00       	mov    $0x1,%ecx
80106224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80106228:	8b 55 08             	mov    0x8(%ebp),%edx
8010622b:	89 c8                	mov    %ecx,%eax
8010622d:	f0 87 02             	lock xchg %eax,(%edx)
80106230:	85 c0                	test   %eax,%eax
80106232:	75 f4                	jne    80106228 <acquire+0x28>
  __sync_synchronize();
80106234:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80106239:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010623c:	e8 bf e4 ff ff       	call   80104700 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80106241:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80106244:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80106246:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80106249:	31 c0                	xor    %eax,%eax
8010624b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010624f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106250:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80106256:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010625c:	77 1a                	ja     80106278 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010625e:	8b 5a 04             	mov    0x4(%edx),%ebx
80106261:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80106265:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80106268:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010626a:	83 f8 0a             	cmp    $0xa,%eax
8010626d:	75 e1                	jne    80106250 <acquire+0x50>
}
8010626f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106272:	c9                   	leave  
80106273:	c3                   	ret    
80106274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80106278:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010627c:	8d 51 34             	lea    0x34(%ecx),%edx
8010627f:	90                   	nop
    pcs[i] = 0;
80106280:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80106286:	83 c0 04             	add    $0x4,%eax
80106289:	39 c2                	cmp    %eax,%edx
8010628b:	75 f3                	jne    80106280 <acquire+0x80>
}
8010628d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106290:	c9                   	leave  
80106291:	c3                   	ret    
80106292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80106298:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010629b:	e8 60 e4 ff ff       	call   80104700 <mycpu>
801062a0:	39 c3                	cmp    %eax,%ebx
801062a2:	0f 85 72 ff ff ff    	jne    8010621a <acquire+0x1a>
  popcli();
801062a8:	e8 53 fe ff ff       	call   80106100 <popcli>
    panic("acquire");
801062ad:	83 ec 0c             	sub    $0xc,%esp
801062b0:	68 39 a2 10 80       	push   $0x8010a239
801062b5:	e8 36 a2 ff ff       	call   801004f0 <panic>
801062ba:	66 90                	xchg   %ax,%ax
801062bc:	66 90                	xchg   %ax,%ax
801062be:	66 90                	xchg   %ax,%ax

801062c0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	57                   	push   %edi
801062c4:	8b 55 08             	mov    0x8(%ebp),%edx
801062c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801062ca:	53                   	push   %ebx
801062cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
801062ce:	89 d7                	mov    %edx,%edi
801062d0:	09 cf                	or     %ecx,%edi
801062d2:	83 e7 03             	and    $0x3,%edi
801062d5:	75 29                	jne    80106300 <memset+0x40>
    c &= 0xFF;
801062d7:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801062da:	c1 e0 18             	shl    $0x18,%eax
801062dd:	89 fb                	mov    %edi,%ebx
801062df:	c1 e9 02             	shr    $0x2,%ecx
801062e2:	c1 e3 10             	shl    $0x10,%ebx
801062e5:	09 d8                	or     %ebx,%eax
801062e7:	09 f8                	or     %edi,%eax
801062e9:	c1 e7 08             	shl    $0x8,%edi
801062ec:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801062ee:	89 d7                	mov    %edx,%edi
801062f0:	fc                   	cld    
801062f1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801062f3:	5b                   	pop    %ebx
801062f4:	89 d0                	mov    %edx,%eax
801062f6:	5f                   	pop    %edi
801062f7:	5d                   	pop    %ebp
801062f8:	c3                   	ret    
801062f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80106300:	89 d7                	mov    %edx,%edi
80106302:	fc                   	cld    
80106303:	f3 aa                	rep stos %al,%es:(%edi)
80106305:	5b                   	pop    %ebx
80106306:	89 d0                	mov    %edx,%eax
80106308:	5f                   	pop    %edi
80106309:	5d                   	pop    %ebp
8010630a:	c3                   	ret    
8010630b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010630f:	90                   	nop

80106310 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	56                   	push   %esi
80106314:	8b 75 10             	mov    0x10(%ebp),%esi
80106317:	8b 55 08             	mov    0x8(%ebp),%edx
8010631a:	53                   	push   %ebx
8010631b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010631e:	85 f6                	test   %esi,%esi
80106320:	74 2e                	je     80106350 <memcmp+0x40>
80106322:	01 c6                	add    %eax,%esi
80106324:	eb 14                	jmp    8010633a <memcmp+0x2a>
80106326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010632d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80106330:	83 c0 01             	add    $0x1,%eax
80106333:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80106336:	39 f0                	cmp    %esi,%eax
80106338:	74 16                	je     80106350 <memcmp+0x40>
    if(*s1 != *s2)
8010633a:	0f b6 0a             	movzbl (%edx),%ecx
8010633d:	0f b6 18             	movzbl (%eax),%ebx
80106340:	38 d9                	cmp    %bl,%cl
80106342:	74 ec                	je     80106330 <memcmp+0x20>
      return *s1 - *s2;
80106344:	0f b6 c1             	movzbl %cl,%eax
80106347:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80106349:	5b                   	pop    %ebx
8010634a:	5e                   	pop    %esi
8010634b:	5d                   	pop    %ebp
8010634c:	c3                   	ret    
8010634d:	8d 76 00             	lea    0x0(%esi),%esi
80106350:	5b                   	pop    %ebx
  return 0;
80106351:	31 c0                	xor    %eax,%eax
}
80106353:	5e                   	pop    %esi
80106354:	5d                   	pop    %ebp
80106355:	c3                   	ret    
80106356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010635d:	8d 76 00             	lea    0x0(%esi),%esi

80106360 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80106360:	55                   	push   %ebp
80106361:	89 e5                	mov    %esp,%ebp
80106363:	57                   	push   %edi
80106364:	8b 55 08             	mov    0x8(%ebp),%edx
80106367:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010636a:	56                   	push   %esi
8010636b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010636e:	39 d6                	cmp    %edx,%esi
80106370:	73 26                	jae    80106398 <memmove+0x38>
80106372:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80106375:	39 fa                	cmp    %edi,%edx
80106377:	73 1f                	jae    80106398 <memmove+0x38>
80106379:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
8010637c:	85 c9                	test   %ecx,%ecx
8010637e:	74 0c                	je     8010638c <memmove+0x2c>
      *--d = *--s;
80106380:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80106384:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80106387:	83 e8 01             	sub    $0x1,%eax
8010638a:	73 f4                	jae    80106380 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010638c:	5e                   	pop    %esi
8010638d:	89 d0                	mov    %edx,%eax
8010638f:	5f                   	pop    %edi
80106390:	5d                   	pop    %ebp
80106391:	c3                   	ret    
80106392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80106398:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010639b:	89 d7                	mov    %edx,%edi
8010639d:	85 c9                	test   %ecx,%ecx
8010639f:	74 eb                	je     8010638c <memmove+0x2c>
801063a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801063a8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801063a9:	39 c6                	cmp    %eax,%esi
801063ab:	75 fb                	jne    801063a8 <memmove+0x48>
}
801063ad:	5e                   	pop    %esi
801063ae:	89 d0                	mov    %edx,%eax
801063b0:	5f                   	pop    %edi
801063b1:	5d                   	pop    %ebp
801063b2:	c3                   	ret    
801063b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801063c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801063c0:	eb 9e                	jmp    80106360 <memmove>
801063c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801063d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	56                   	push   %esi
801063d4:	8b 75 10             	mov    0x10(%ebp),%esi
801063d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801063da:	53                   	push   %ebx
801063db:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
801063de:	85 f6                	test   %esi,%esi
801063e0:	74 2e                	je     80106410 <strncmp+0x40>
801063e2:	01 d6                	add    %edx,%esi
801063e4:	eb 18                	jmp    801063fe <strncmp+0x2e>
801063e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ed:	8d 76 00             	lea    0x0(%esi),%esi
801063f0:	38 d8                	cmp    %bl,%al
801063f2:	75 14                	jne    80106408 <strncmp+0x38>
    n--, p++, q++;
801063f4:	83 c2 01             	add    $0x1,%edx
801063f7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801063fa:	39 f2                	cmp    %esi,%edx
801063fc:	74 12                	je     80106410 <strncmp+0x40>
801063fe:	0f b6 01             	movzbl (%ecx),%eax
80106401:	0f b6 1a             	movzbl (%edx),%ebx
80106404:	84 c0                	test   %al,%al
80106406:	75 e8                	jne    801063f0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80106408:	29 d8                	sub    %ebx,%eax
}
8010640a:	5b                   	pop    %ebx
8010640b:	5e                   	pop    %esi
8010640c:	5d                   	pop    %ebp
8010640d:	c3                   	ret    
8010640e:	66 90                	xchg   %ax,%ax
80106410:	5b                   	pop    %ebx
    return 0;
80106411:	31 c0                	xor    %eax,%eax
}
80106413:	5e                   	pop    %esi
80106414:	5d                   	pop    %ebp
80106415:	c3                   	ret    
80106416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010641d:	8d 76 00             	lea    0x0(%esi),%esi

80106420 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	57                   	push   %edi
80106424:	56                   	push   %esi
80106425:	8b 75 08             	mov    0x8(%ebp),%esi
80106428:	53                   	push   %ebx
80106429:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010642c:	89 f0                	mov    %esi,%eax
8010642e:	eb 15                	jmp    80106445 <strncpy+0x25>
80106430:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80106434:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106437:	83 c0 01             	add    $0x1,%eax
8010643a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010643e:	88 50 ff             	mov    %dl,-0x1(%eax)
80106441:	84 d2                	test   %dl,%dl
80106443:	74 09                	je     8010644e <strncpy+0x2e>
80106445:	89 cb                	mov    %ecx,%ebx
80106447:	83 e9 01             	sub    $0x1,%ecx
8010644a:	85 db                	test   %ebx,%ebx
8010644c:	7f e2                	jg     80106430 <strncpy+0x10>
    ;
  while(n-- > 0)
8010644e:	89 c2                	mov    %eax,%edx
80106450:	85 c9                	test   %ecx,%ecx
80106452:	7e 17                	jle    8010646b <strncpy+0x4b>
80106454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80106458:	83 c2 01             	add    $0x1,%edx
8010645b:	89 c1                	mov    %eax,%ecx
8010645d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80106461:	29 d1                	sub    %edx,%ecx
80106463:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80106467:	85 c9                	test   %ecx,%ecx
80106469:	7f ed                	jg     80106458 <strncpy+0x38>
  return os;
}
8010646b:	5b                   	pop    %ebx
8010646c:	89 f0                	mov    %esi,%eax
8010646e:	5e                   	pop    %esi
8010646f:	5f                   	pop    %edi
80106470:	5d                   	pop    %ebp
80106471:	c3                   	ret    
80106472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106480 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	56                   	push   %esi
80106484:	8b 55 10             	mov    0x10(%ebp),%edx
80106487:	8b 75 08             	mov    0x8(%ebp),%esi
8010648a:	53                   	push   %ebx
8010648b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010648e:	85 d2                	test   %edx,%edx
80106490:	7e 25                	jle    801064b7 <safestrcpy+0x37>
80106492:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80106496:	89 f2                	mov    %esi,%edx
80106498:	eb 16                	jmp    801064b0 <safestrcpy+0x30>
8010649a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801064a0:	0f b6 08             	movzbl (%eax),%ecx
801064a3:	83 c0 01             	add    $0x1,%eax
801064a6:	83 c2 01             	add    $0x1,%edx
801064a9:	88 4a ff             	mov    %cl,-0x1(%edx)
801064ac:	84 c9                	test   %cl,%cl
801064ae:	74 04                	je     801064b4 <safestrcpy+0x34>
801064b0:	39 d8                	cmp    %ebx,%eax
801064b2:	75 ec                	jne    801064a0 <safestrcpy+0x20>
    ;
  *s = 0;
801064b4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801064b7:	89 f0                	mov    %esi,%eax
801064b9:	5b                   	pop    %ebx
801064ba:	5e                   	pop    %esi
801064bb:	5d                   	pop    %ebp
801064bc:	c3                   	ret    
801064bd:	8d 76 00             	lea    0x0(%esi),%esi

801064c0 <strlen>:

int
strlen(const char *s)
{
801064c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801064c1:	31 c0                	xor    %eax,%eax
{
801064c3:	89 e5                	mov    %esp,%ebp
801064c5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801064c8:	80 3a 00             	cmpb   $0x0,(%edx)
801064cb:	74 0c                	je     801064d9 <strlen+0x19>
801064cd:	8d 76 00             	lea    0x0(%esi),%esi
801064d0:	83 c0 01             	add    $0x1,%eax
801064d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801064d7:	75 f7                	jne    801064d0 <strlen+0x10>
    ;
  return n;
}
801064d9:	5d                   	pop    %ebp
801064da:	c3                   	ret    

801064db <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801064db:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801064df:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801064e3:	55                   	push   %ebp
  pushl %ebx
801064e4:	53                   	push   %ebx
  pushl %esi
801064e5:	56                   	push   %esi
  pushl %edi
801064e6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801064e7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801064e9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801064eb:	5f                   	pop    %edi
  popl %esi
801064ec:	5e                   	pop    %esi
  popl %ebx
801064ed:	5b                   	pop    %ebx
  popl %ebp
801064ee:	5d                   	pop    %ebp
  ret
801064ef:	c3                   	ret    

801064f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	53                   	push   %ebx
801064f4:	83 ec 04             	sub    $0x4,%esp
801064f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801064fa:	e8 81 e2 ff ff       	call   80104780 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801064ff:	8b 40 6c             	mov    0x6c(%eax),%eax
80106502:	39 d8                	cmp    %ebx,%eax
80106504:	76 1a                	jbe    80106520 <fetchint+0x30>
80106506:	8d 53 04             	lea    0x4(%ebx),%edx
80106509:	39 d0                	cmp    %edx,%eax
8010650b:	72 13                	jb     80106520 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010650d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106510:	8b 13                	mov    (%ebx),%edx
80106512:	89 10                	mov    %edx,(%eax)
  return 0;
80106514:	31 c0                	xor    %eax,%eax
}
80106516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106519:	c9                   	leave  
8010651a:	c3                   	ret    
8010651b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010651f:	90                   	nop
    return -1;
80106520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106525:	eb ef                	jmp    80106516 <fetchint+0x26>
80106527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010652e:	66 90                	xchg   %ax,%ax

80106530 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80106530:	55                   	push   %ebp
80106531:	89 e5                	mov    %esp,%ebp
80106533:	53                   	push   %ebx
80106534:	83 ec 04             	sub    $0x4,%esp
80106537:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010653a:	e8 41 e2 ff ff       	call   80104780 <myproc>

  if(addr >= curproc->sz)
8010653f:	39 58 6c             	cmp    %ebx,0x6c(%eax)
80106542:	76 2c                	jbe    80106570 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80106544:	8b 55 0c             	mov    0xc(%ebp),%edx
80106547:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80106549:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
8010654c:	39 d3                	cmp    %edx,%ebx
8010654e:	73 20                	jae    80106570 <fetchstr+0x40>
80106550:	89 d8                	mov    %ebx,%eax
80106552:	eb 0b                	jmp    8010655f <fetchstr+0x2f>
80106554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106558:	83 c0 01             	add    $0x1,%eax
8010655b:	39 c2                	cmp    %eax,%edx
8010655d:	76 11                	jbe    80106570 <fetchstr+0x40>
    if(*s == 0)
8010655f:	80 38 00             	cmpb   $0x0,(%eax)
80106562:	75 f4                	jne    80106558 <fetchstr+0x28>
      return s - *pp;
80106564:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80106566:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106569:	c9                   	leave  
8010656a:	c3                   	ret    
8010656b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010656f:	90                   	nop
80106570:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106573:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106578:	c9                   	leave  
80106579:	c3                   	ret    
8010657a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106580 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106580:	55                   	push   %ebp
80106581:	89 e5                	mov    %esp,%ebp
80106583:	56                   	push   %esi
80106584:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106585:	e8 f6 e1 ff ff       	call   80104780 <myproc>
8010658a:	8b 55 08             	mov    0x8(%ebp),%edx
8010658d:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80106593:	8b 40 44             	mov    0x44(%eax),%eax
80106596:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106599:	e8 e2 e1 ff ff       	call   80104780 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010659e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801065a1:	8b 40 6c             	mov    0x6c(%eax),%eax
801065a4:	39 c6                	cmp    %eax,%esi
801065a6:	73 18                	jae    801065c0 <argint+0x40>
801065a8:	8d 53 08             	lea    0x8(%ebx),%edx
801065ab:	39 d0                	cmp    %edx,%eax
801065ad:	72 11                	jb     801065c0 <argint+0x40>
  *ip = *(int*)(addr);
801065af:	8b 45 0c             	mov    0xc(%ebp),%eax
801065b2:	8b 53 04             	mov    0x4(%ebx),%edx
801065b5:	89 10                	mov    %edx,(%eax)
  return 0;
801065b7:	31 c0                	xor    %eax,%eax
}
801065b9:	5b                   	pop    %ebx
801065ba:	5e                   	pop    %esi
801065bb:	5d                   	pop    %ebp
801065bc:	c3                   	ret    
801065bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801065c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065c5:	eb f2                	jmp    801065b9 <argint+0x39>
801065c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065ce:	66 90                	xchg   %ax,%ax

801065d0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
801065d3:	57                   	push   %edi
801065d4:	56                   	push   %esi
801065d5:	53                   	push   %ebx
801065d6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801065d9:	e8 a2 e1 ff ff       	call   80104780 <myproc>
801065de:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065e0:	e8 9b e1 ff ff       	call   80104780 <myproc>
801065e5:	8b 55 08             	mov    0x8(%ebp),%edx
801065e8:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801065ee:	8b 40 44             	mov    0x44(%eax),%eax
801065f1:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801065f4:	e8 87 e1 ff ff       	call   80104780 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065f9:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801065fc:	8b 40 6c             	mov    0x6c(%eax),%eax
801065ff:	39 c7                	cmp    %eax,%edi
80106601:	73 35                	jae    80106638 <argptr+0x68>
80106603:	8d 4b 08             	lea    0x8(%ebx),%ecx
80106606:	39 c8                	cmp    %ecx,%eax
80106608:	72 2e                	jb     80106638 <argptr+0x68>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010660a:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
8010660d:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106610:	85 d2                	test   %edx,%edx
80106612:	78 24                	js     80106638 <argptr+0x68>
80106614:	8b 56 6c             	mov    0x6c(%esi),%edx
80106617:	39 c2                	cmp    %eax,%edx
80106619:	76 1d                	jbe    80106638 <argptr+0x68>
8010661b:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010661e:	01 c3                	add    %eax,%ebx
80106620:	39 da                	cmp    %ebx,%edx
80106622:	72 14                	jb     80106638 <argptr+0x68>
    return -1;
  *pp = (char*)i;
80106624:	8b 55 0c             	mov    0xc(%ebp),%edx
80106627:	89 02                	mov    %eax,(%edx)
  return 0;
80106629:	31 c0                	xor    %eax,%eax
}
8010662b:	83 c4 0c             	add    $0xc,%esp
8010662e:	5b                   	pop    %ebx
8010662f:	5e                   	pop    %esi
80106630:	5f                   	pop    %edi
80106631:	5d                   	pop    %ebp
80106632:	c3                   	ret    
80106633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106637:	90                   	nop
    return -1;
80106638:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010663d:	eb ec                	jmp    8010662b <argptr+0x5b>
8010663f:	90                   	nop

80106640 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	56                   	push   %esi
80106644:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106645:	e8 36 e1 ff ff       	call   80104780 <myproc>
8010664a:	8b 55 08             	mov    0x8(%ebp),%edx
8010664d:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80106653:	8b 40 44             	mov    0x44(%eax),%eax
80106656:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106659:	e8 22 e1 ff ff       	call   80104780 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010665e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106661:	8b 40 6c             	mov    0x6c(%eax),%eax
80106664:	39 c6                	cmp    %eax,%esi
80106666:	73 40                	jae    801066a8 <argstr+0x68>
80106668:	8d 53 08             	lea    0x8(%ebx),%edx
8010666b:	39 d0                	cmp    %edx,%eax
8010666d:	72 39                	jb     801066a8 <argstr+0x68>
  *ip = *(int*)(addr);
8010666f:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80106672:	e8 09 e1 ff ff       	call   80104780 <myproc>
  if(addr >= curproc->sz)
80106677:	3b 58 6c             	cmp    0x6c(%eax),%ebx
8010667a:	73 2c                	jae    801066a8 <argstr+0x68>
  *pp = (char*)addr;
8010667c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010667f:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80106681:	8b 50 6c             	mov    0x6c(%eax),%edx
  for(s = *pp; s < ep; s++){
80106684:	39 d3                	cmp    %edx,%ebx
80106686:	73 20                	jae    801066a8 <argstr+0x68>
80106688:	89 d8                	mov    %ebx,%eax
8010668a:	eb 0b                	jmp    80106697 <argstr+0x57>
8010668c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106690:	83 c0 01             	add    $0x1,%eax
80106693:	39 c2                	cmp    %eax,%edx
80106695:	76 11                	jbe    801066a8 <argstr+0x68>
    if(*s == 0)
80106697:	80 38 00             	cmpb   $0x0,(%eax)
8010669a:	75 f4                	jne    80106690 <argstr+0x50>
      return s - *pp;
8010669c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010669e:	5b                   	pop    %ebx
8010669f:	5e                   	pop    %esi
801066a0:	5d                   	pop    %ebp
801066a1:	c3                   	ret    
801066a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801066a8:	5b                   	pop    %ebx
    return -1;
801066a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066ae:	5e                   	pop    %esi
801066af:	5d                   	pop    %ebp
801066b0:	c3                   	ret    
801066b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066bf:	90                   	nop

801066c0 <syscall>:
[SYS_close_sharedmem] sys_close_sharedmem,
};

void
syscall(void)
{
801066c0:	55                   	push   %ebp
801066c1:	89 e5                	mov    %esp,%ebp
801066c3:	53                   	push   %ebx
801066c4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801066c7:	e8 b4 e0 ff ff       	call   80104780 <myproc>
801066cc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax; //define syscall number
801066ce:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801066d4:	8b 40 1c             	mov    0x1c(%eax),%eax

  if(num<MAX_SYSCALLS && num>0)
801066d7:	8d 50 ff             	lea    -0x1(%eax),%edx
801066da:	83 fa 19             	cmp    $0x19,%edx
801066dd:	77 21                	ja     80106700 <syscall+0x40>
    curproc->syscalls[num]++;
801066df:	83 04 83 01          	addl   $0x1,(%ebx,%eax,4)
    
  
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801066e3:	8b 14 85 60 a2 10 80 	mov    -0x7fef5da0(,%eax,4),%edx
801066ea:	85 d2                	test   %edx,%edx
801066ec:	74 17                	je     80106705 <syscall+0x45>
    curproc->tf->eax = syscalls[num]();
801066ee:	ff d2                	call   *%edx
801066f0:	89 c2                	mov    %eax,%edx
801066f2:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801066f8:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801066fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801066fe:	c9                   	leave  
801066ff:	c3                   	ret    
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106700:	83 fa 21             	cmp    $0x21,%edx
80106703:	76 de                	jbe    801066e3 <syscall+0x23>
    cprintf("%d %s: unknown sys call %d\n",
80106705:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80106706:	8d 83 d8 00 00 00    	lea    0xd8(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010670c:	50                   	push   %eax
8010670d:	ff 73 7c             	push   0x7c(%ebx)
80106710:	68 41 a2 10 80       	push   $0x8010a241
80106715:	e8 56 a3 ff ff       	call   80100a70 <cprintf>
    curproc->tf->eax = -1;
8010671a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80106720:	83 c4 10             	add    $0x10,%esp
80106723:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010672a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010672d:	c9                   	leave  
8010672e:	c3                   	ret    
8010672f:	90                   	nop

80106730 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	57                   	push   %edi
80106734:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106735:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80106738:	53                   	push   %ebx
80106739:	83 ec 34             	sub    $0x34,%esp
8010673c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010673f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80106742:	57                   	push   %edi
80106743:	50                   	push   %eax
{
80106744:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80106747:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010674a:	e8 b1 c6 ff ff       	call   80102e00 <nameiparent>
8010674f:	83 c4 10             	add    $0x10,%esp
80106752:	85 c0                	test   %eax,%eax
80106754:	0f 84 46 01 00 00    	je     801068a0 <create+0x170>
    return 0;
  ilock(dp);
8010675a:	83 ec 0c             	sub    $0xc,%esp
8010675d:	89 c3                	mov    %eax,%ebx
8010675f:	50                   	push   %eax
80106760:	e8 4b bd ff ff       	call   801024b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80106765:	83 c4 0c             	add    $0xc,%esp
80106768:	6a 00                	push   $0x0
8010676a:	57                   	push   %edi
8010676b:	53                   	push   %ebx
8010676c:	e8 9f c2 ff ff       	call   80102a10 <dirlookup>
80106771:	83 c4 10             	add    $0x10,%esp
80106774:	89 c6                	mov    %eax,%esi
80106776:	85 c0                	test   %eax,%eax
80106778:	74 56                	je     801067d0 <create+0xa0>
    iunlockput(dp);
8010677a:	83 ec 0c             	sub    $0xc,%esp
8010677d:	53                   	push   %ebx
8010677e:	e8 bd bf ff ff       	call   80102740 <iunlockput>
    ilock(ip);
80106783:	89 34 24             	mov    %esi,(%esp)
80106786:	e8 25 bd ff ff       	call   801024b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010678b:	83 c4 10             	add    $0x10,%esp
8010678e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106793:	75 1b                	jne    801067b0 <create+0x80>
80106795:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010679a:	75 14                	jne    801067b0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010679c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010679f:	89 f0                	mov    %esi,%eax
801067a1:	5b                   	pop    %ebx
801067a2:	5e                   	pop    %esi
801067a3:	5f                   	pop    %edi
801067a4:	5d                   	pop    %ebp
801067a5:	c3                   	ret    
801067a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067ad:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801067b0:	83 ec 0c             	sub    $0xc,%esp
801067b3:	56                   	push   %esi
    return 0;
801067b4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801067b6:	e8 85 bf ff ff       	call   80102740 <iunlockput>
    return 0;
801067bb:	83 c4 10             	add    $0x10,%esp
}
801067be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067c1:	89 f0                	mov    %esi,%eax
801067c3:	5b                   	pop    %ebx
801067c4:	5e                   	pop    %esi
801067c5:	5f                   	pop    %edi
801067c6:	5d                   	pop    %ebp
801067c7:	c3                   	ret    
801067c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067cf:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801067d0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801067d4:	83 ec 08             	sub    $0x8,%esp
801067d7:	50                   	push   %eax
801067d8:	ff 33                	push   (%ebx)
801067da:	e8 61 bb ff ff       	call   80102340 <ialloc>
801067df:	83 c4 10             	add    $0x10,%esp
801067e2:	89 c6                	mov    %eax,%esi
801067e4:	85 c0                	test   %eax,%eax
801067e6:	0f 84 cd 00 00 00    	je     801068b9 <create+0x189>
  ilock(ip);
801067ec:	83 ec 0c             	sub    $0xc,%esp
801067ef:	50                   	push   %eax
801067f0:	e8 bb bc ff ff       	call   801024b0 <ilock>
  ip->major = major;
801067f5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801067f9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801067fd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80106801:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80106805:	b8 01 00 00 00       	mov    $0x1,%eax
8010680a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010680e:	89 34 24             	mov    %esi,(%esp)
80106811:	e8 ea bb ff ff       	call   80102400 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80106816:	83 c4 10             	add    $0x10,%esp
80106819:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010681e:	74 30                	je     80106850 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80106820:	83 ec 04             	sub    $0x4,%esp
80106823:	ff 76 04             	push   0x4(%esi)
80106826:	57                   	push   %edi
80106827:	53                   	push   %ebx
80106828:	e8 f3 c4 ff ff       	call   80102d20 <dirlink>
8010682d:	83 c4 10             	add    $0x10,%esp
80106830:	85 c0                	test   %eax,%eax
80106832:	78 78                	js     801068ac <create+0x17c>
  iunlockput(dp);
80106834:	83 ec 0c             	sub    $0xc,%esp
80106837:	53                   	push   %ebx
80106838:	e8 03 bf ff ff       	call   80102740 <iunlockput>
  return ip;
8010683d:	83 c4 10             	add    $0x10,%esp
}
80106840:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106843:	89 f0                	mov    %esi,%eax
80106845:	5b                   	pop    %ebx
80106846:	5e                   	pop    %esi
80106847:	5f                   	pop    %edi
80106848:	5d                   	pop    %ebp
80106849:	c3                   	ret    
8010684a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80106850:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80106853:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80106858:	53                   	push   %ebx
80106859:	e8 a2 bb ff ff       	call   80102400 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010685e:	83 c4 0c             	add    $0xc,%esp
80106861:	ff 76 04             	push   0x4(%esi)
80106864:	68 08 a3 10 80       	push   $0x8010a308
80106869:	56                   	push   %esi
8010686a:	e8 b1 c4 ff ff       	call   80102d20 <dirlink>
8010686f:	83 c4 10             	add    $0x10,%esp
80106872:	85 c0                	test   %eax,%eax
80106874:	78 18                	js     8010688e <create+0x15e>
80106876:	83 ec 04             	sub    $0x4,%esp
80106879:	ff 73 04             	push   0x4(%ebx)
8010687c:	68 07 a3 10 80       	push   $0x8010a307
80106881:	56                   	push   %esi
80106882:	e8 99 c4 ff ff       	call   80102d20 <dirlink>
80106887:	83 c4 10             	add    $0x10,%esp
8010688a:	85 c0                	test   %eax,%eax
8010688c:	79 92                	jns    80106820 <create+0xf0>
      panic("create dots");
8010688e:	83 ec 0c             	sub    $0xc,%esp
80106891:	68 fb a2 10 80       	push   $0x8010a2fb
80106896:	e8 55 9c ff ff       	call   801004f0 <panic>
8010689b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010689f:	90                   	nop
}
801068a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801068a3:	31 f6                	xor    %esi,%esi
}
801068a5:	5b                   	pop    %ebx
801068a6:	89 f0                	mov    %esi,%eax
801068a8:	5e                   	pop    %esi
801068a9:	5f                   	pop    %edi
801068aa:	5d                   	pop    %ebp
801068ab:	c3                   	ret    
    panic("create: dirlink");
801068ac:	83 ec 0c             	sub    $0xc,%esp
801068af:	68 0a a3 10 80       	push   $0x8010a30a
801068b4:	e8 37 9c ff ff       	call   801004f0 <panic>
    panic("create: ialloc");
801068b9:	83 ec 0c             	sub    $0xc,%esp
801068bc:	68 ec a2 10 80       	push   $0x8010a2ec
801068c1:	e8 2a 9c ff ff       	call   801004f0 <panic>
801068c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068cd:	8d 76 00             	lea    0x0(%esi),%esi

801068d0 <sys_dup>:
{
801068d0:	55                   	push   %ebp
801068d1:	89 e5                	mov    %esp,%ebp
801068d3:	56                   	push   %esi
801068d4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801068d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801068d8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801068db:	50                   	push   %eax
801068dc:	6a 00                	push   $0x0
801068de:	e8 9d fc ff ff       	call   80106580 <argint>
801068e3:	83 c4 10             	add    $0x10,%esp
801068e6:	85 c0                	test   %eax,%eax
801068e8:	78 39                	js     80106923 <sys_dup+0x53>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801068ea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801068ee:	77 33                	ja     80106923 <sys_dup+0x53>
801068f0:	e8 8b de ff ff       	call   80104780 <myproc>
801068f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801068f8:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
801068ff:	85 f6                	test   %esi,%esi
80106901:	74 20                	je     80106923 <sys_dup+0x53>
  struct proc *curproc = myproc();
80106903:	e8 78 de ff ff       	call   80104780 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106908:	31 db                	xor    %ebx,%ebx
8010690a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106910:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
80106917:	85 d2                	test   %edx,%edx
80106919:	74 1d                	je     80106938 <sys_dup+0x68>
  for(fd = 0; fd < NOFILE; fd++){
8010691b:	83 c3 01             	add    $0x1,%ebx
8010691e:	83 fb 10             	cmp    $0x10,%ebx
80106921:	75 ed                	jne    80106910 <sys_dup+0x40>
}
80106923:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80106926:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010692b:	89 d8                	mov    %ebx,%eax
8010692d:	5b                   	pop    %ebx
8010692e:	5e                   	pop    %esi
8010692f:	5d                   	pop    %ebp
80106930:	c3                   	ret    
80106931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80106938:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010693b:	89 b4 98 94 00 00 00 	mov    %esi,0x94(%eax,%ebx,4)
  filedup(f);
80106942:	56                   	push   %esi
80106943:	e8 88 b2 ff ff       	call   80101bd0 <filedup>
  return fd;
80106948:	83 c4 10             	add    $0x10,%esp
}
8010694b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010694e:	89 d8                	mov    %ebx,%eax
80106950:	5b                   	pop    %ebx
80106951:	5e                   	pop    %esi
80106952:	5d                   	pop    %ebp
80106953:	c3                   	ret    
80106954:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010695b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010695f:	90                   	nop

80106960 <sys_read>:
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	56                   	push   %esi
80106964:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106965:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106968:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010696b:	53                   	push   %ebx
8010696c:	6a 00                	push   $0x0
8010696e:	e8 0d fc ff ff       	call   80106580 <argint>
80106973:	83 c4 10             	add    $0x10,%esp
80106976:	85 c0                	test   %eax,%eax
80106978:	78 66                	js     801069e0 <sys_read+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010697a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010697e:	77 60                	ja     801069e0 <sys_read+0x80>
80106980:	e8 fb dd ff ff       	call   80104780 <myproc>
80106985:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106988:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
8010698f:	85 f6                	test   %esi,%esi
80106991:	74 4d                	je     801069e0 <sys_read+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106993:	83 ec 08             	sub    $0x8,%esp
80106996:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106999:	50                   	push   %eax
8010699a:	6a 02                	push   $0x2
8010699c:	e8 df fb ff ff       	call   80106580 <argint>
801069a1:	83 c4 10             	add    $0x10,%esp
801069a4:	85 c0                	test   %eax,%eax
801069a6:	78 38                	js     801069e0 <sys_read+0x80>
801069a8:	83 ec 04             	sub    $0x4,%esp
801069ab:	ff 75 f0             	push   -0x10(%ebp)
801069ae:	53                   	push   %ebx
801069af:	6a 01                	push   $0x1
801069b1:	e8 1a fc ff ff       	call   801065d0 <argptr>
801069b6:	83 c4 10             	add    $0x10,%esp
801069b9:	85 c0                	test   %eax,%eax
801069bb:	78 23                	js     801069e0 <sys_read+0x80>
  return fileread(f, p, n);
801069bd:	83 ec 04             	sub    $0x4,%esp
801069c0:	ff 75 f0             	push   -0x10(%ebp)
801069c3:	ff 75 f4             	push   -0xc(%ebp)
801069c6:	56                   	push   %esi
801069c7:	e8 84 b3 ff ff       	call   80101d50 <fileread>
801069cc:	83 c4 10             	add    $0x10,%esp
}
801069cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801069d2:	5b                   	pop    %ebx
801069d3:	5e                   	pop    %esi
801069d4:	5d                   	pop    %ebp
801069d5:	c3                   	ret    
801069d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801069e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069e5:	eb e8                	jmp    801069cf <sys_read+0x6f>
801069e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069ee:	66 90                	xchg   %ax,%ax

801069f0 <sys_write>:
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	56                   	push   %esi
801069f4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801069f5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801069f8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801069fb:	53                   	push   %ebx
801069fc:	6a 00                	push   $0x0
801069fe:	e8 7d fb ff ff       	call   80106580 <argint>
80106a03:	83 c4 10             	add    $0x10,%esp
80106a06:	85 c0                	test   %eax,%eax
80106a08:	78 66                	js     80106a70 <sys_write+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106a0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106a0e:	77 60                	ja     80106a70 <sys_write+0x80>
80106a10:	e8 6b dd ff ff       	call   80104780 <myproc>
80106a15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106a18:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80106a1f:	85 f6                	test   %esi,%esi
80106a21:	74 4d                	je     80106a70 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106a23:	83 ec 08             	sub    $0x8,%esp
80106a26:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a29:	50                   	push   %eax
80106a2a:	6a 02                	push   $0x2
80106a2c:	e8 4f fb ff ff       	call   80106580 <argint>
80106a31:	83 c4 10             	add    $0x10,%esp
80106a34:	85 c0                	test   %eax,%eax
80106a36:	78 38                	js     80106a70 <sys_write+0x80>
80106a38:	83 ec 04             	sub    $0x4,%esp
80106a3b:	ff 75 f0             	push   -0x10(%ebp)
80106a3e:	53                   	push   %ebx
80106a3f:	6a 01                	push   $0x1
80106a41:	e8 8a fb ff ff       	call   801065d0 <argptr>
80106a46:	83 c4 10             	add    $0x10,%esp
80106a49:	85 c0                	test   %eax,%eax
80106a4b:	78 23                	js     80106a70 <sys_write+0x80>
  return filewrite(f, p, n);
80106a4d:	83 ec 04             	sub    $0x4,%esp
80106a50:	ff 75 f0             	push   -0x10(%ebp)
80106a53:	ff 75 f4             	push   -0xc(%ebp)
80106a56:	56                   	push   %esi
80106a57:	e8 84 b3 ff ff       	call   80101de0 <filewrite>
80106a5c:	83 c4 10             	add    $0x10,%esp
}
80106a5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106a62:	5b                   	pop    %ebx
80106a63:	5e                   	pop    %esi
80106a64:	5d                   	pop    %ebp
80106a65:	c3                   	ret    
80106a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a6d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a75:	eb e8                	jmp    80106a5f <sys_write+0x6f>
80106a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a7e:	66 90                	xchg   %ax,%ax

80106a80 <sys_close>:
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	56                   	push   %esi
80106a84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106a85:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106a88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80106a8b:	50                   	push   %eax
80106a8c:	6a 00                	push   $0x0
80106a8e:	e8 ed fa ff ff       	call   80106580 <argint>
80106a93:	83 c4 10             	add    $0x10,%esp
80106a96:	85 c0                	test   %eax,%eax
80106a98:	78 3e                	js     80106ad8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106a9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106a9e:	77 38                	ja     80106ad8 <sys_close+0x58>
80106aa0:	e8 db dc ff ff       	call   80104780 <myproc>
80106aa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106aa8:	8d 5a 24             	lea    0x24(%edx),%ebx
80106aab:	8b 74 98 04          	mov    0x4(%eax,%ebx,4),%esi
80106aaf:	85 f6                	test   %esi,%esi
80106ab1:	74 25                	je     80106ad8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80106ab3:	e8 c8 dc ff ff       	call   80104780 <myproc>
  fileclose(f);
80106ab8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80106abb:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
80106ac2:	00 
  fileclose(f);
80106ac3:	56                   	push   %esi
80106ac4:	e8 57 b1 ff ff       	call   80101c20 <fileclose>
  return 0;
80106ac9:	83 c4 10             	add    $0x10,%esp
80106acc:	31 c0                	xor    %eax,%eax
}
80106ace:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106ad1:	5b                   	pop    %ebx
80106ad2:	5e                   	pop    %esi
80106ad3:	5d                   	pop    %ebp
80106ad4:	c3                   	ret    
80106ad5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106add:	eb ef                	jmp    80106ace <sys_close+0x4e>
80106adf:	90                   	nop

80106ae0 <sys_fstat>:
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	56                   	push   %esi
80106ae4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106ae5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106ae8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80106aeb:	53                   	push   %ebx
80106aec:	6a 00                	push   $0x0
80106aee:	e8 8d fa ff ff       	call   80106580 <argint>
80106af3:	83 c4 10             	add    $0x10,%esp
80106af6:	85 c0                	test   %eax,%eax
80106af8:	78 46                	js     80106b40 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106afa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106afe:	77 40                	ja     80106b40 <sys_fstat+0x60>
80106b00:	e8 7b dc ff ff       	call   80104780 <myproc>
80106b05:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106b08:	8b b4 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%esi
80106b0f:	85 f6                	test   %esi,%esi
80106b11:	74 2d                	je     80106b40 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106b13:	83 ec 04             	sub    $0x4,%esp
80106b16:	6a 14                	push   $0x14
80106b18:	53                   	push   %ebx
80106b19:	6a 01                	push   $0x1
80106b1b:	e8 b0 fa ff ff       	call   801065d0 <argptr>
80106b20:	83 c4 10             	add    $0x10,%esp
80106b23:	85 c0                	test   %eax,%eax
80106b25:	78 19                	js     80106b40 <sys_fstat+0x60>
  return filestat(f, st);
80106b27:	83 ec 08             	sub    $0x8,%esp
80106b2a:	ff 75 f4             	push   -0xc(%ebp)
80106b2d:	56                   	push   %esi
80106b2e:	e8 cd b1 ff ff       	call   80101d00 <filestat>
80106b33:	83 c4 10             	add    $0x10,%esp
}
80106b36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b39:	5b                   	pop    %ebx
80106b3a:	5e                   	pop    %esi
80106b3b:	5d                   	pop    %ebp
80106b3c:	c3                   	ret    
80106b3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b45:	eb ef                	jmp    80106b36 <sys_fstat+0x56>
80106b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b4e:	66 90                	xchg   %ax,%ax

80106b50 <sys_link>:
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106b55:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80106b58:	53                   	push   %ebx
80106b59:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106b5c:	50                   	push   %eax
80106b5d:	6a 00                	push   $0x0
80106b5f:	e8 dc fa ff ff       	call   80106640 <argstr>
80106b64:	83 c4 10             	add    $0x10,%esp
80106b67:	85 c0                	test   %eax,%eax
80106b69:	0f 88 fb 00 00 00    	js     80106c6a <sys_link+0x11a>
80106b6f:	83 ec 08             	sub    $0x8,%esp
80106b72:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106b75:	50                   	push   %eax
80106b76:	6a 01                	push   $0x1
80106b78:	e8 c3 fa ff ff       	call   80106640 <argstr>
80106b7d:	83 c4 10             	add    $0x10,%esp
80106b80:	85 c0                	test   %eax,%eax
80106b82:	0f 88 e2 00 00 00    	js     80106c6a <sys_link+0x11a>
  begin_op();
80106b88:	e8 13 cf ff ff       	call   80103aa0 <begin_op>
  if((ip = namei(old)) == 0){
80106b8d:	83 ec 0c             	sub    $0xc,%esp
80106b90:	ff 75 d4             	push   -0x2c(%ebp)
80106b93:	e8 48 c2 ff ff       	call   80102de0 <namei>
80106b98:	83 c4 10             	add    $0x10,%esp
80106b9b:	89 c3                	mov    %eax,%ebx
80106b9d:	85 c0                	test   %eax,%eax
80106b9f:	0f 84 e4 00 00 00    	je     80106c89 <sys_link+0x139>
  ilock(ip);
80106ba5:	83 ec 0c             	sub    $0xc,%esp
80106ba8:	50                   	push   %eax
80106ba9:	e8 02 b9 ff ff       	call   801024b0 <ilock>
  if(ip->type == T_DIR){
80106bae:	83 c4 10             	add    $0x10,%esp
80106bb1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106bb6:	0f 84 b5 00 00 00    	je     80106c71 <sys_link+0x121>
  iupdate(ip);
80106bbc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80106bbf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106bc4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106bc7:	53                   	push   %ebx
80106bc8:	e8 33 b8 ff ff       	call   80102400 <iupdate>
  iunlock(ip);
80106bcd:	89 1c 24             	mov    %ebx,(%esp)
80106bd0:	e8 bb b9 ff ff       	call   80102590 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106bd5:	58                   	pop    %eax
80106bd6:	5a                   	pop    %edx
80106bd7:	57                   	push   %edi
80106bd8:	ff 75 d0             	push   -0x30(%ebp)
80106bdb:	e8 20 c2 ff ff       	call   80102e00 <nameiparent>
80106be0:	83 c4 10             	add    $0x10,%esp
80106be3:	89 c6                	mov    %eax,%esi
80106be5:	85 c0                	test   %eax,%eax
80106be7:	74 5b                	je     80106c44 <sys_link+0xf4>
  ilock(dp);
80106be9:	83 ec 0c             	sub    $0xc,%esp
80106bec:	50                   	push   %eax
80106bed:	e8 be b8 ff ff       	call   801024b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106bf2:	8b 03                	mov    (%ebx),%eax
80106bf4:	83 c4 10             	add    $0x10,%esp
80106bf7:	39 06                	cmp    %eax,(%esi)
80106bf9:	75 3d                	jne    80106c38 <sys_link+0xe8>
80106bfb:	83 ec 04             	sub    $0x4,%esp
80106bfe:	ff 73 04             	push   0x4(%ebx)
80106c01:	57                   	push   %edi
80106c02:	56                   	push   %esi
80106c03:	e8 18 c1 ff ff       	call   80102d20 <dirlink>
80106c08:	83 c4 10             	add    $0x10,%esp
80106c0b:	85 c0                	test   %eax,%eax
80106c0d:	78 29                	js     80106c38 <sys_link+0xe8>
  iunlockput(dp);
80106c0f:	83 ec 0c             	sub    $0xc,%esp
80106c12:	56                   	push   %esi
80106c13:	e8 28 bb ff ff       	call   80102740 <iunlockput>
  iput(ip);
80106c18:	89 1c 24             	mov    %ebx,(%esp)
80106c1b:	e8 c0 b9 ff ff       	call   801025e0 <iput>
  end_op();
80106c20:	e8 eb ce ff ff       	call   80103b10 <end_op>
  return 0;
80106c25:	83 c4 10             	add    $0x10,%esp
80106c28:	31 c0                	xor    %eax,%eax
}
80106c2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c2d:	5b                   	pop    %ebx
80106c2e:	5e                   	pop    %esi
80106c2f:	5f                   	pop    %edi
80106c30:	5d                   	pop    %ebp
80106c31:	c3                   	ret    
80106c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80106c38:	83 ec 0c             	sub    $0xc,%esp
80106c3b:	56                   	push   %esi
80106c3c:	e8 ff ba ff ff       	call   80102740 <iunlockput>
    goto bad;
80106c41:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80106c44:	83 ec 0c             	sub    $0xc,%esp
80106c47:	53                   	push   %ebx
80106c48:	e8 63 b8 ff ff       	call   801024b0 <ilock>
  ip->nlink--;
80106c4d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106c52:	89 1c 24             	mov    %ebx,(%esp)
80106c55:	e8 a6 b7 ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
80106c5a:	89 1c 24             	mov    %ebx,(%esp)
80106c5d:	e8 de ba ff ff       	call   80102740 <iunlockput>
  end_op();
80106c62:	e8 a9 ce ff ff       	call   80103b10 <end_op>
  return -1;
80106c67:	83 c4 10             	add    $0x10,%esp
80106c6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c6f:	eb b9                	jmp    80106c2a <sys_link+0xda>
    iunlockput(ip);
80106c71:	83 ec 0c             	sub    $0xc,%esp
80106c74:	53                   	push   %ebx
80106c75:	e8 c6 ba ff ff       	call   80102740 <iunlockput>
    end_op();
80106c7a:	e8 91 ce ff ff       	call   80103b10 <end_op>
    return -1;
80106c7f:	83 c4 10             	add    $0x10,%esp
80106c82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c87:	eb a1                	jmp    80106c2a <sys_link+0xda>
    end_op();
80106c89:	e8 82 ce ff ff       	call   80103b10 <end_op>
    return -1;
80106c8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c93:	eb 95                	jmp    80106c2a <sys_link+0xda>
80106c95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ca0 <sys_unlink>:
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106ca5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106ca8:	53                   	push   %ebx
80106ca9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80106cac:	50                   	push   %eax
80106cad:	6a 00                	push   $0x0
80106caf:	e8 8c f9 ff ff       	call   80106640 <argstr>
80106cb4:	83 c4 10             	add    $0x10,%esp
80106cb7:	85 c0                	test   %eax,%eax
80106cb9:	0f 88 7a 01 00 00    	js     80106e39 <sys_unlink+0x199>
  begin_op();
80106cbf:	e8 dc cd ff ff       	call   80103aa0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106cc4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106cc7:	83 ec 08             	sub    $0x8,%esp
80106cca:	53                   	push   %ebx
80106ccb:	ff 75 c0             	push   -0x40(%ebp)
80106cce:	e8 2d c1 ff ff       	call   80102e00 <nameiparent>
80106cd3:	83 c4 10             	add    $0x10,%esp
80106cd6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106cd9:	85 c0                	test   %eax,%eax
80106cdb:	0f 84 62 01 00 00    	je     80106e43 <sys_unlink+0x1a3>
  ilock(dp);
80106ce1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106ce4:	83 ec 0c             	sub    $0xc,%esp
80106ce7:	57                   	push   %edi
80106ce8:	e8 c3 b7 ff ff       	call   801024b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106ced:	58                   	pop    %eax
80106cee:	5a                   	pop    %edx
80106cef:	68 08 a3 10 80       	push   $0x8010a308
80106cf4:	53                   	push   %ebx
80106cf5:	e8 f6 bc ff ff       	call   801029f0 <namecmp>
80106cfa:	83 c4 10             	add    $0x10,%esp
80106cfd:	85 c0                	test   %eax,%eax
80106cff:	0f 84 fb 00 00 00    	je     80106e00 <sys_unlink+0x160>
80106d05:	83 ec 08             	sub    $0x8,%esp
80106d08:	68 07 a3 10 80       	push   $0x8010a307
80106d0d:	53                   	push   %ebx
80106d0e:	e8 dd bc ff ff       	call   801029f0 <namecmp>
80106d13:	83 c4 10             	add    $0x10,%esp
80106d16:	85 c0                	test   %eax,%eax
80106d18:	0f 84 e2 00 00 00    	je     80106e00 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80106d1e:	83 ec 04             	sub    $0x4,%esp
80106d21:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106d24:	50                   	push   %eax
80106d25:	53                   	push   %ebx
80106d26:	57                   	push   %edi
80106d27:	e8 e4 bc ff ff       	call   80102a10 <dirlookup>
80106d2c:	83 c4 10             	add    $0x10,%esp
80106d2f:	89 c3                	mov    %eax,%ebx
80106d31:	85 c0                	test   %eax,%eax
80106d33:	0f 84 c7 00 00 00    	je     80106e00 <sys_unlink+0x160>
  ilock(ip);
80106d39:	83 ec 0c             	sub    $0xc,%esp
80106d3c:	50                   	push   %eax
80106d3d:	e8 6e b7 ff ff       	call   801024b0 <ilock>
  if(ip->nlink < 1)
80106d42:	83 c4 10             	add    $0x10,%esp
80106d45:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106d4a:	0f 8e 1c 01 00 00    	jle    80106e6c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106d50:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106d55:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106d58:	74 66                	je     80106dc0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80106d5a:	83 ec 04             	sub    $0x4,%esp
80106d5d:	6a 10                	push   $0x10
80106d5f:	6a 00                	push   $0x0
80106d61:	57                   	push   %edi
80106d62:	e8 59 f5 ff ff       	call   801062c0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106d67:	6a 10                	push   $0x10
80106d69:	ff 75 c4             	push   -0x3c(%ebp)
80106d6c:	57                   	push   %edi
80106d6d:	ff 75 b4             	push   -0x4c(%ebp)
80106d70:	e8 4b bb ff ff       	call   801028c0 <writei>
80106d75:	83 c4 20             	add    $0x20,%esp
80106d78:	83 f8 10             	cmp    $0x10,%eax
80106d7b:	0f 85 de 00 00 00    	jne    80106e5f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80106d81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106d86:	0f 84 94 00 00 00    	je     80106e20 <sys_unlink+0x180>
  iunlockput(dp);
80106d8c:	83 ec 0c             	sub    $0xc,%esp
80106d8f:	ff 75 b4             	push   -0x4c(%ebp)
80106d92:	e8 a9 b9 ff ff       	call   80102740 <iunlockput>
  ip->nlink--;
80106d97:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106d9c:	89 1c 24             	mov    %ebx,(%esp)
80106d9f:	e8 5c b6 ff ff       	call   80102400 <iupdate>
  iunlockput(ip);
80106da4:	89 1c 24             	mov    %ebx,(%esp)
80106da7:	e8 94 b9 ff ff       	call   80102740 <iunlockput>
  end_op();
80106dac:	e8 5f cd ff ff       	call   80103b10 <end_op>
  return 0;
80106db1:	83 c4 10             	add    $0x10,%esp
80106db4:	31 c0                	xor    %eax,%eax
}
80106db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db9:	5b                   	pop    %ebx
80106dba:	5e                   	pop    %esi
80106dbb:	5f                   	pop    %edi
80106dbc:	5d                   	pop    %ebp
80106dbd:	c3                   	ret    
80106dbe:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106dc0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106dc4:	76 94                	jbe    80106d5a <sys_unlink+0xba>
80106dc6:	be 20 00 00 00       	mov    $0x20,%esi
80106dcb:	eb 0b                	jmp    80106dd8 <sys_unlink+0x138>
80106dcd:	8d 76 00             	lea    0x0(%esi),%esi
80106dd0:	83 c6 10             	add    $0x10,%esi
80106dd3:	3b 73 58             	cmp    0x58(%ebx),%esi
80106dd6:	73 82                	jae    80106d5a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106dd8:	6a 10                	push   $0x10
80106dda:	56                   	push   %esi
80106ddb:	57                   	push   %edi
80106ddc:	53                   	push   %ebx
80106ddd:	e8 de b9 ff ff       	call   801027c0 <readi>
80106de2:	83 c4 10             	add    $0x10,%esp
80106de5:	83 f8 10             	cmp    $0x10,%eax
80106de8:	75 68                	jne    80106e52 <sys_unlink+0x1b2>
    if(de.inum != 0)
80106dea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106def:	74 df                	je     80106dd0 <sys_unlink+0x130>
    iunlockput(ip);
80106df1:	83 ec 0c             	sub    $0xc,%esp
80106df4:	53                   	push   %ebx
80106df5:	e8 46 b9 ff ff       	call   80102740 <iunlockput>
    goto bad;
80106dfa:	83 c4 10             	add    $0x10,%esp
80106dfd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80106e00:	83 ec 0c             	sub    $0xc,%esp
80106e03:	ff 75 b4             	push   -0x4c(%ebp)
80106e06:	e8 35 b9 ff ff       	call   80102740 <iunlockput>
  end_op();
80106e0b:	e8 00 cd ff ff       	call   80103b10 <end_op>
  return -1;
80106e10:	83 c4 10             	add    $0x10,%esp
80106e13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e18:	eb 9c                	jmp    80106db6 <sys_unlink+0x116>
80106e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80106e20:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80106e23:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106e26:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80106e2b:	50                   	push   %eax
80106e2c:	e8 cf b5 ff ff       	call   80102400 <iupdate>
80106e31:	83 c4 10             	add    $0x10,%esp
80106e34:	e9 53 ff ff ff       	jmp    80106d8c <sys_unlink+0xec>
    return -1;
80106e39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e3e:	e9 73 ff ff ff       	jmp    80106db6 <sys_unlink+0x116>
    end_op();
80106e43:	e8 c8 cc ff ff       	call   80103b10 <end_op>
    return -1;
80106e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e4d:	e9 64 ff ff ff       	jmp    80106db6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80106e52:	83 ec 0c             	sub    $0xc,%esp
80106e55:	68 2c a3 10 80       	push   $0x8010a32c
80106e5a:	e8 91 96 ff ff       	call   801004f0 <panic>
    panic("unlink: writei");
80106e5f:	83 ec 0c             	sub    $0xc,%esp
80106e62:	68 3e a3 10 80       	push   $0x8010a33e
80106e67:	e8 84 96 ff ff       	call   801004f0 <panic>
    panic("unlink: nlink < 1");
80106e6c:	83 ec 0c             	sub    $0xc,%esp
80106e6f:	68 1a a3 10 80       	push   $0x8010a31a
80106e74:	e8 77 96 ff ff       	call   801004f0 <panic>
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e80 <sys_open>:

int
sys_open(void)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106e85:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106e88:	53                   	push   %ebx
80106e89:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106e8c:	50                   	push   %eax
80106e8d:	6a 00                	push   $0x0
80106e8f:	e8 ac f7 ff ff       	call   80106640 <argstr>
80106e94:	83 c4 10             	add    $0x10,%esp
80106e97:	85 c0                	test   %eax,%eax
80106e99:	0f 88 a1 00 00 00    	js     80106f40 <sys_open+0xc0>
80106e9f:	83 ec 08             	sub    $0x8,%esp
80106ea2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ea5:	50                   	push   %eax
80106ea6:	6a 01                	push   $0x1
80106ea8:	e8 d3 f6 ff ff       	call   80106580 <argint>
80106ead:	83 c4 10             	add    $0x10,%esp
80106eb0:	85 c0                	test   %eax,%eax
80106eb2:	0f 88 88 00 00 00    	js     80106f40 <sys_open+0xc0>
    return -1;

  begin_op();
80106eb8:	e8 e3 cb ff ff       	call   80103aa0 <begin_op>

  if(omode & O_CREATE){
80106ebd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106ec1:	0f 85 89 00 00 00    	jne    80106f50 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106ec7:	83 ec 0c             	sub    $0xc,%esp
80106eca:	ff 75 e0             	push   -0x20(%ebp)
80106ecd:	e8 0e bf ff ff       	call   80102de0 <namei>
80106ed2:	83 c4 10             	add    $0x10,%esp
80106ed5:	89 c6                	mov    %eax,%esi
80106ed7:	85 c0                	test   %eax,%eax
80106ed9:	0f 84 8e 00 00 00    	je     80106f6d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
80106edf:	83 ec 0c             	sub    $0xc,%esp
80106ee2:	50                   	push   %eax
80106ee3:	e8 c8 b5 ff ff       	call   801024b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106ee8:	83 c4 10             	add    $0x10,%esp
80106eeb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106ef0:	0f 84 da 00 00 00    	je     80106fd0 <sys_open+0x150>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106ef6:	e8 65 ac ff ff       	call   80101b60 <filealloc>
80106efb:	89 c7                	mov    %eax,%edi
80106efd:	85 c0                	test   %eax,%eax
80106eff:	74 2e                	je     80106f2f <sys_open+0xaf>
  struct proc *curproc = myproc();
80106f01:	e8 7a d8 ff ff       	call   80104780 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106f06:	31 db                	xor    %ebx,%ebx
80106f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f0f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80106f10:	8b 94 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%edx
80106f17:	85 d2                	test   %edx,%edx
80106f19:	74 65                	je     80106f80 <sys_open+0x100>
  for(fd = 0; fd < NOFILE; fd++){
80106f1b:	83 c3 01             	add    $0x1,%ebx
80106f1e:	83 fb 10             	cmp    $0x10,%ebx
80106f21:	75 ed                	jne    80106f10 <sys_open+0x90>
    if(f)
      fileclose(f);
80106f23:	83 ec 0c             	sub    $0xc,%esp
80106f26:	57                   	push   %edi
80106f27:	e8 f4 ac ff ff       	call   80101c20 <fileclose>
80106f2c:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106f2f:	83 ec 0c             	sub    $0xc,%esp
80106f32:	56                   	push   %esi
80106f33:	e8 08 b8 ff ff       	call   80102740 <iunlockput>
    end_op();
80106f38:	e8 d3 cb ff ff       	call   80103b10 <end_op>
    return -1;
80106f3d:	83 c4 10             	add    $0x10,%esp
80106f40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106f45:	eb 75                	jmp    80106fbc <sys_open+0x13c>
80106f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f4e:	66 90                	xchg   %ax,%ax
    ip = create(path, T_FILE, 0, 0);
80106f50:	83 ec 0c             	sub    $0xc,%esp
80106f53:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f56:	31 c9                	xor    %ecx,%ecx
80106f58:	ba 02 00 00 00       	mov    $0x2,%edx
80106f5d:	6a 00                	push   $0x0
80106f5f:	e8 cc f7 ff ff       	call   80106730 <create>
    if(ip == 0){
80106f64:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80106f67:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106f69:	85 c0                	test   %eax,%eax
80106f6b:	75 89                	jne    80106ef6 <sys_open+0x76>
      end_op();
80106f6d:	e8 9e cb ff ff       	call   80103b10 <end_op>
      return -1;
80106f72:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106f77:	eb 43                	jmp    80106fbc <sys_open+0x13c>
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106f80:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106f83:	89 bc 98 94 00 00 00 	mov    %edi,0x94(%eax,%ebx,4)
  iunlock(ip);
80106f8a:	56                   	push   %esi
80106f8b:	e8 00 b6 ff ff       	call   80102590 <iunlock>
  end_op();
80106f90:	e8 7b cb ff ff       	call   80103b10 <end_op>

  f->type = FD_INODE;
80106f95:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106f9b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106f9e:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106fa1:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106fa4:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106fa6:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106fad:	f7 d0                	not    %eax
80106faf:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106fb2:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106fb5:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106fb8:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106fbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fbf:	89 d8                	mov    %ebx,%eax
80106fc1:	5b                   	pop    %ebx
80106fc2:	5e                   	pop    %esi
80106fc3:	5f                   	pop    %edi
80106fc4:	5d                   	pop    %ebp
80106fc5:	c3                   	ret    
80106fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fcd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106fd0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106fd3:	85 c9                	test   %ecx,%ecx
80106fd5:	0f 84 1b ff ff ff    	je     80106ef6 <sys_open+0x76>
80106fdb:	e9 4f ff ff ff       	jmp    80106f2f <sys_open+0xaf>

80106fe0 <sys_mkdir>:

int
sys_mkdir(void)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106fe6:	e8 b5 ca ff ff       	call   80103aa0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106feb:	83 ec 08             	sub    $0x8,%esp
80106fee:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ff1:	50                   	push   %eax
80106ff2:	6a 00                	push   $0x0
80106ff4:	e8 47 f6 ff ff       	call   80106640 <argstr>
80106ff9:	83 c4 10             	add    $0x10,%esp
80106ffc:	85 c0                	test   %eax,%eax
80106ffe:	78 30                	js     80107030 <sys_mkdir+0x50>
80107000:	83 ec 0c             	sub    $0xc,%esp
80107003:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107006:	31 c9                	xor    %ecx,%ecx
80107008:	ba 01 00 00 00       	mov    $0x1,%edx
8010700d:	6a 00                	push   $0x0
8010700f:	e8 1c f7 ff ff       	call   80106730 <create>
80107014:	83 c4 10             	add    $0x10,%esp
80107017:	85 c0                	test   %eax,%eax
80107019:	74 15                	je     80107030 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010701b:	83 ec 0c             	sub    $0xc,%esp
8010701e:	50                   	push   %eax
8010701f:	e8 1c b7 ff ff       	call   80102740 <iunlockput>
  end_op();
80107024:	e8 e7 ca ff ff       	call   80103b10 <end_op>
  return 0;
80107029:	83 c4 10             	add    $0x10,%esp
8010702c:	31 c0                	xor    %eax,%eax
}
8010702e:	c9                   	leave  
8010702f:	c3                   	ret    
    end_op();
80107030:	e8 db ca ff ff       	call   80103b10 <end_op>
    return -1;
80107035:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010703a:	c9                   	leave  
8010703b:	c3                   	ret    
8010703c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107040 <sys_mknod>:

int
sys_mknod(void)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80107046:	e8 55 ca ff ff       	call   80103aa0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010704b:	83 ec 08             	sub    $0x8,%esp
8010704e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107051:	50                   	push   %eax
80107052:	6a 00                	push   $0x0
80107054:	e8 e7 f5 ff ff       	call   80106640 <argstr>
80107059:	83 c4 10             	add    $0x10,%esp
8010705c:	85 c0                	test   %eax,%eax
8010705e:	78 60                	js     801070c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80107060:	83 ec 08             	sub    $0x8,%esp
80107063:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107066:	50                   	push   %eax
80107067:	6a 01                	push   $0x1
80107069:	e8 12 f5 ff ff       	call   80106580 <argint>
  if((argstr(0, &path)) < 0 ||
8010706e:	83 c4 10             	add    $0x10,%esp
80107071:	85 c0                	test   %eax,%eax
80107073:	78 4b                	js     801070c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80107075:	83 ec 08             	sub    $0x8,%esp
80107078:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010707b:	50                   	push   %eax
8010707c:	6a 02                	push   $0x2
8010707e:	e8 fd f4 ff ff       	call   80106580 <argint>
     argint(1, &major) < 0 ||
80107083:	83 c4 10             	add    $0x10,%esp
80107086:	85 c0                	test   %eax,%eax
80107088:	78 36                	js     801070c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010708a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010708e:	83 ec 0c             	sub    $0xc,%esp
80107091:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80107095:	ba 03 00 00 00       	mov    $0x3,%edx
8010709a:	50                   	push   %eax
8010709b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010709e:	e8 8d f6 ff ff       	call   80106730 <create>
     argint(2, &minor) < 0 ||
801070a3:	83 c4 10             	add    $0x10,%esp
801070a6:	85 c0                	test   %eax,%eax
801070a8:	74 16                	je     801070c0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801070aa:	83 ec 0c             	sub    $0xc,%esp
801070ad:	50                   	push   %eax
801070ae:	e8 8d b6 ff ff       	call   80102740 <iunlockput>
  end_op();
801070b3:	e8 58 ca ff ff       	call   80103b10 <end_op>
  return 0;
801070b8:	83 c4 10             	add    $0x10,%esp
801070bb:	31 c0                	xor    %eax,%eax
}
801070bd:	c9                   	leave  
801070be:	c3                   	ret    
801070bf:	90                   	nop
    end_op();
801070c0:	e8 4b ca ff ff       	call   80103b10 <end_op>
    return -1;
801070c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070ca:	c9                   	leave  
801070cb:	c3                   	ret    
801070cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070d0 <sys_chdir>:

int
sys_chdir(void)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	56                   	push   %esi
801070d4:	53                   	push   %ebx
801070d5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801070d8:	e8 a3 d6 ff ff       	call   80104780 <myproc>
801070dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801070df:	e8 bc c9 ff ff       	call   80103aa0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801070e4:	83 ec 08             	sub    $0x8,%esp
801070e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070ea:	50                   	push   %eax
801070eb:	6a 00                	push   $0x0
801070ed:	e8 4e f5 ff ff       	call   80106640 <argstr>
801070f2:	83 c4 10             	add    $0x10,%esp
801070f5:	85 c0                	test   %eax,%eax
801070f7:	78 77                	js     80107170 <sys_chdir+0xa0>
801070f9:	83 ec 0c             	sub    $0xc,%esp
801070fc:	ff 75 f4             	push   -0xc(%ebp)
801070ff:	e8 dc bc ff ff       	call   80102de0 <namei>
80107104:	83 c4 10             	add    $0x10,%esp
80107107:	89 c3                	mov    %eax,%ebx
80107109:	85 c0                	test   %eax,%eax
8010710b:	74 63                	je     80107170 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010710d:	83 ec 0c             	sub    $0xc,%esp
80107110:	50                   	push   %eax
80107111:	e8 9a b3 ff ff       	call   801024b0 <ilock>
  if(ip->type != T_DIR){
80107116:	83 c4 10             	add    $0x10,%esp
80107119:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010711e:	75 30                	jne    80107150 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80107120:	83 ec 0c             	sub    $0xc,%esp
80107123:	53                   	push   %ebx
80107124:	e8 67 b4 ff ff       	call   80102590 <iunlock>
  iput(curproc->cwd);
80107129:	58                   	pop    %eax
8010712a:	ff b6 d4 00 00 00    	push   0xd4(%esi)
80107130:	e8 ab b4 ff ff       	call   801025e0 <iput>
  end_op();
80107135:	e8 d6 c9 ff ff       	call   80103b10 <end_op>
  curproc->cwd = ip;
8010713a:	89 9e d4 00 00 00    	mov    %ebx,0xd4(%esi)
  return 0;
80107140:	83 c4 10             	add    $0x10,%esp
80107143:	31 c0                	xor    %eax,%eax
}
80107145:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107148:	5b                   	pop    %ebx
80107149:	5e                   	pop    %esi
8010714a:	5d                   	pop    %ebp
8010714b:	c3                   	ret    
8010714c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80107150:	83 ec 0c             	sub    $0xc,%esp
80107153:	53                   	push   %ebx
80107154:	e8 e7 b5 ff ff       	call   80102740 <iunlockput>
    end_op();
80107159:	e8 b2 c9 ff ff       	call   80103b10 <end_op>
    return -1;
8010715e:	83 c4 10             	add    $0x10,%esp
80107161:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107166:	eb dd                	jmp    80107145 <sys_chdir+0x75>
80107168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010716f:	90                   	nop
    end_op();
80107170:	e8 9b c9 ff ff       	call   80103b10 <end_op>
    return -1;
80107175:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010717a:	eb c9                	jmp    80107145 <sys_chdir+0x75>
8010717c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107180 <sys_exec>:

int
sys_exec(void)
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	57                   	push   %edi
80107184:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80107185:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010718b:	53                   	push   %ebx
8010718c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80107192:	50                   	push   %eax
80107193:	6a 00                	push   $0x0
80107195:	e8 a6 f4 ff ff       	call   80106640 <argstr>
8010719a:	83 c4 10             	add    $0x10,%esp
8010719d:	85 c0                	test   %eax,%eax
8010719f:	0f 88 87 00 00 00    	js     8010722c <sys_exec+0xac>
801071a5:	83 ec 08             	sub    $0x8,%esp
801071a8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801071ae:	50                   	push   %eax
801071af:	6a 01                	push   $0x1
801071b1:	e8 ca f3 ff ff       	call   80106580 <argint>
801071b6:	83 c4 10             	add    $0x10,%esp
801071b9:	85 c0                	test   %eax,%eax
801071bb:	78 6f                	js     8010722c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801071bd:	83 ec 04             	sub    $0x4,%esp
801071c0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801071c6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801071c8:	68 80 00 00 00       	push   $0x80
801071cd:	6a 00                	push   $0x0
801071cf:	56                   	push   %esi
801071d0:	e8 eb f0 ff ff       	call   801062c0 <memset>
801071d5:	83 c4 10             	add    $0x10,%esp
801071d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071df:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801071e0:	83 ec 08             	sub    $0x8,%esp
801071e3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801071e9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801071f0:	50                   	push   %eax
801071f1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801071f7:	01 f8                	add    %edi,%eax
801071f9:	50                   	push   %eax
801071fa:	e8 f1 f2 ff ff       	call   801064f0 <fetchint>
801071ff:	83 c4 10             	add    $0x10,%esp
80107202:	85 c0                	test   %eax,%eax
80107204:	78 26                	js     8010722c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80107206:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010720c:	85 c0                	test   %eax,%eax
8010720e:	74 30                	je     80107240 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80107210:	83 ec 08             	sub    $0x8,%esp
80107213:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80107216:	52                   	push   %edx
80107217:	50                   	push   %eax
80107218:	e8 13 f3 ff ff       	call   80106530 <fetchstr>
8010721d:	83 c4 10             	add    $0x10,%esp
80107220:	85 c0                	test   %eax,%eax
80107222:	78 08                	js     8010722c <sys_exec+0xac>
  for(i=0;; i++){
80107224:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80107227:	83 fb 20             	cmp    $0x20,%ebx
8010722a:	75 b4                	jne    801071e0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010722c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010722f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107234:	5b                   	pop    %ebx
80107235:	5e                   	pop    %esi
80107236:	5f                   	pop    %edi
80107237:	5d                   	pop    %ebp
80107238:	c3                   	ret    
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80107240:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80107247:	00 00 00 00 
  return exec(path, argv);
8010724b:	83 ec 08             	sub    $0x8,%esp
8010724e:	56                   	push   %esi
8010724f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80107255:	e8 76 a5 ff ff       	call   801017d0 <exec>
8010725a:	83 c4 10             	add    $0x10,%esp
}
8010725d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107260:	5b                   	pop    %ebx
80107261:	5e                   	pop    %esi
80107262:	5f                   	pop    %edi
80107263:	5d                   	pop    %ebp
80107264:	c3                   	ret    
80107265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010726c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107270 <sys_pipe>:

int
sys_pipe(void)
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80107275:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80107278:	53                   	push   %ebx
80107279:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010727c:	6a 08                	push   $0x8
8010727e:	50                   	push   %eax
8010727f:	6a 00                	push   $0x0
80107281:	e8 4a f3 ff ff       	call   801065d0 <argptr>
80107286:	83 c4 10             	add    $0x10,%esp
80107289:	85 c0                	test   %eax,%eax
8010728b:	78 4d                	js     801072da <sys_pipe+0x6a>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010728d:	83 ec 08             	sub    $0x8,%esp
80107290:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107293:	50                   	push   %eax
80107294:	8d 45 e0             	lea    -0x20(%ebp),%eax
80107297:	50                   	push   %eax
80107298:	e8 13 cf ff ff       	call   801041b0 <pipealloc>
8010729d:	83 c4 10             	add    $0x10,%esp
801072a0:	85 c0                	test   %eax,%eax
801072a2:	78 36                	js     801072da <sys_pipe+0x6a>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801072a4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801072a7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801072a9:	e8 d2 d4 ff ff       	call   80104780 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801072ae:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801072b0:	8b b4 98 94 00 00 00 	mov    0x94(%eax,%ebx,4),%esi
801072b7:	85 f6                	test   %esi,%esi
801072b9:	74 2d                	je     801072e8 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
801072bb:	83 c3 01             	add    $0x1,%ebx
801072be:	83 fb 10             	cmp    $0x10,%ebx
801072c1:	75 ed                	jne    801072b0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801072c3:	83 ec 0c             	sub    $0xc,%esp
801072c6:	ff 75 e0             	push   -0x20(%ebp)
801072c9:	e8 52 a9 ff ff       	call   80101c20 <fileclose>
    fileclose(wf);
801072ce:	58                   	pop    %eax
801072cf:	ff 75 e4             	push   -0x1c(%ebp)
801072d2:	e8 49 a9 ff ff       	call   80101c20 <fileclose>
    return -1;
801072d7:	83 c4 10             	add    $0x10,%esp
801072da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072df:	eb 5b                	jmp    8010733c <sys_pipe+0xcc>
801072e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801072e8:	8d 73 24             	lea    0x24(%ebx),%esi
801072eb:	89 7c b0 04          	mov    %edi,0x4(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801072ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801072f2:	e8 89 d4 ff ff       	call   80104780 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801072f7:	31 d2                	xor    %edx,%edx
801072f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80107300:	8b 8c 90 94 00 00 00 	mov    0x94(%eax,%edx,4),%ecx
80107307:	85 c9                	test   %ecx,%ecx
80107309:	74 1d                	je     80107328 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
8010730b:	83 c2 01             	add    $0x1,%edx
8010730e:	83 fa 10             	cmp    $0x10,%edx
80107311:	75 ed                	jne    80107300 <sys_pipe+0x90>
      myproc()->ofile[fd0] = 0;
80107313:	e8 68 d4 ff ff       	call   80104780 <myproc>
80107318:	c7 44 b0 04 00 00 00 	movl   $0x0,0x4(%eax,%esi,4)
8010731f:	00 
80107320:	eb a1                	jmp    801072c3 <sys_pipe+0x53>
80107322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80107328:	89 bc 90 94 00 00 00 	mov    %edi,0x94(%eax,%edx,4)
  }
  fd[0] = fd0;
8010732f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107332:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80107334:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107337:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010733a:	31 c0                	xor    %eax,%eax
}
8010733c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010733f:	5b                   	pop    %ebx
80107340:	5e                   	pop    %esi
80107341:	5f                   	pop    %edi
80107342:	5d                   	pop    %ebp
80107343:	c3                   	ret    
80107344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010734b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010734f:	90                   	nop

80107350 <sys_move_file>:

int
sys_move_file(void)
{
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	57                   	push   %edi
80107354:	56                   	push   %esi
  char *src_file, *dest_dir;
  struct dirent de;
  uint  offset;
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
80107355:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
{
8010735b:	53                   	push   %ebx
8010735c:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  if ((argstr(0, &src_file) < 0) || (argstr(1, &dest_dir) < 0))
80107362:	50                   	push   %eax
80107363:	6a 00                	push   $0x0
80107365:	e8 d6 f2 ff ff       	call   80106640 <argstr>
8010736a:	83 c4 10             	add    $0x10,%esp
8010736d:	85 c0                	test   %eax,%eax
8010736f:	0f 88 6c 01 00 00    	js     801074e1 <sys_move_file+0x191>
80107375:	83 ec 08             	sub    $0x8,%esp
80107378:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
8010737e:	50                   	push   %eax
8010737f:	6a 01                	push   $0x1
80107381:	e8 ba f2 ff ff       	call   80106640 <argstr>
80107386:	83 c4 10             	add    $0x10,%esp
80107389:	85 c0                	test   %eax,%eax
8010738b:	0f 88 50 01 00 00    	js     801074e1 <sys_move_file+0x191>
  {
    return -1;
  }
  begin_op();
80107391:	e8 0a c7 ff ff       	call   80103aa0 <begin_op>

  struct inode *src_ip = namei(src_file);
80107396:	83 ec 0c             	sub    $0xc,%esp
80107399:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
8010739f:	e8 3c ba ff ff       	call   80102de0 <namei>
  if (src_ip == 0)
801073a4:	83 c4 10             	add    $0x10,%esp
  struct inode *src_ip = namei(src_file);
801073a7:	89 c6                	mov    %eax,%esi
  if (src_ip == 0)
801073a9:	85 c0                	test   %eax,%eax
801073ab:	0f 84 45 01 00 00    	je     801074f6 <sys_move_file+0x1a6>
  {
    cprintf("File not found: %s\n", src_file);
    end_op();
    return -1;
  }
  ilock(src_ip);
801073b1:	83 ec 0c             	sub    $0xc,%esp
801073b4:	50                   	push   %eax
801073b5:	e8 f6 b0 ff ff       	call   801024b0 <ilock>
  
  struct inode *dir_ip = namei(dest_dir);
801073ba:	58                   	pop    %eax
801073bb:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
801073c1:	e8 1a ba ff ff       	call   80102de0 <namei>
  if (dir_ip== 0)
801073c6:	83 c4 10             	add    $0x10,%esp
  struct inode *dir_ip = namei(dest_dir);
801073c9:	89 c7                	mov    %eax,%edi
  if (dir_ip== 0)
801073cb:	85 c0                	test   %eax,%eax
801073cd:	0f 84 45 01 00 00    	je     80107518 <sys_move_file+0x1c8>
    cprintf("Directory not found: %s\n", dest_dir);
    iunlockput(src_ip);
    end_op();
    return -1;
  }
  ilock(dir_ip);
801073d3:	83 ec 0c             	sub    $0xc,%esp
801073d6:	50                   	push   %eax
801073d7:	e8 d4 b0 ff ff       	call   801024b0 <ilock>

  char filename[128];
  safestrcpy(filename, src_file, sizeof(filename));
801073dc:	83 c4 0c             	add    $0xc,%esp
801073df:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801073e5:	68 80 00 00 00       	push   $0x80
801073ea:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
801073f0:	50                   	push   %eax
801073f1:	e8 8a f0 ff ff       	call   80106480 <safestrcpy>
   
  if (dirlink(dir_ip, filename, src_ip->inum) < 0)
801073f6:	83 c4 0c             	add    $0xc,%esp
801073f9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801073ff:	ff 76 04             	push   0x4(%esi)
80107402:	50                   	push   %eax
80107403:	57                   	push   %edi
80107404:	e8 17 b9 ff ff       	call   80102d20 <dirlink>
80107409:	83 c4 10             	add    $0x10,%esp
8010740c:	85 c0                	test   %eax,%eax
8010740e:	0f 88 dc 00 00 00    	js     801074f0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *dp_parent = nameiparent(src_file,  filename);
80107414:	83 ec 08             	sub    $0x8,%esp
80107417:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010741d:	50                   	push   %eax
8010741e:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
80107424:	e8 d7 b9 ff ff       	call   80102e00 <nameiparent>
  if (dp_parent == 0)
80107429:	83 c4 10             	add    $0x10,%esp
  struct inode *dp_parent = nameiparent(src_file,  filename);
8010742c:	89 c3                	mov    %eax,%ebx
  if (dp_parent == 0)
8010742e:	85 c0                	test   %eax,%eax
80107430:	0f 84 ba 00 00 00    	je     801074f0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  struct inode *ip = dirlookup(dp_parent, filename, &offset);
80107436:	83 ec 04             	sub    $0x4,%esp
80107439:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
8010743f:	50                   	push   %eax
80107440:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80107446:	50                   	push   %eax
80107447:	53                   	push   %ebx
80107448:	e8 c3 b5 ff ff       	call   80102a10 <dirlookup>
  if (ip == 0)
8010744d:	83 c4 10             	add    $0x10,%esp
80107450:	85 c0                	test   %eax,%eax
80107452:	0f 84 98 00 00 00    	je     801074f0 <sys_move_file+0x1a0>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  memset(&de, 0, sizeof(de));
80107458:	83 ec 04             	sub    $0x4,%esp
8010745b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80107461:	6a 10                	push   $0x10
80107463:	6a 00                	push   $0x0
80107465:	52                   	push   %edx
80107466:	e8 55 ee ff ff       	call   801062c0 <memset>
  ilock(dp_parent);
8010746b:	89 1c 24             	mov    %ebx,(%esp)
8010746e:	e8 3d b0 ff ff       	call   801024b0 <ilock>
  if (writei(dp_parent, (char*)&de, offset, sizeof(de)) != sizeof(de))
80107473:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80107479:	6a 10                	push   $0x10
8010747b:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
80107481:	52                   	push   %edx
80107482:	53                   	push   %ebx
80107483:	e8 38 b4 ff ff       	call   801028c0 <writei>
80107488:	83 c4 20             	add    $0x20,%esp
8010748b:	83 f8 10             	cmp    $0x10,%eax
8010748e:	75 30                	jne    801074c0 <sys_move_file+0x170>
    iunlockput(src_ip);
    end_op();
    return -1;
  }

  iunlockput(src_ip);
80107490:	83 ec 0c             	sub    $0xc,%esp
80107493:	56                   	push   %esi
80107494:	e8 a7 b2 ff ff       	call   80102740 <iunlockput>
  iunlockput(dir_ip);
80107499:	89 3c 24             	mov    %edi,(%esp)
8010749c:	e8 9f b2 ff ff       	call   80102740 <iunlockput>
  iunlockput(dp_parent);
801074a1:	89 1c 24             	mov    %ebx,(%esp)
801074a4:	e8 97 b2 ff ff       	call   80102740 <iunlockput>
  end_op();
801074a9:	e8 62 c6 ff ff       	call   80103b10 <end_op>
  return 0;
801074ae:	83 c4 10             	add    $0x10,%esp
801074b1:	31 c0                	xor    %eax,%eax
801074b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074b6:	5b                   	pop    %ebx
801074b7:	5e                   	pop    %esi
801074b8:	5f                   	pop    %edi
801074b9:	5d                   	pop    %ebp
801074ba:	c3                   	ret    
801074bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074bf:	90                   	nop
    iunlockput(dp_parent);
801074c0:	83 ec 0c             	sub    $0xc,%esp
801074c3:	53                   	push   %ebx
801074c4:	e8 77 b2 ff ff       	call   80102740 <iunlockput>
    iunlockput(dir_ip);
801074c9:	89 3c 24             	mov    %edi,(%esp)
801074cc:	e8 6f b2 ff ff       	call   80102740 <iunlockput>
    iunlockput(src_ip);
801074d1:	89 34 24             	mov    %esi,(%esp)
801074d4:	e8 67 b2 ff ff       	call   80102740 <iunlockput>
    end_op();
801074d9:	e8 32 c6 ff ff       	call   80103b10 <end_op>
    return -1;
801074de:	83 c4 10             	add    $0x10,%esp
801074e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074e6:	eb cb                	jmp    801074b3 <sys_move_file+0x163>
801074e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074ef:	90                   	nop
    iunlockput(dir_ip);
801074f0:	83 ec 0c             	sub    $0xc,%esp
801074f3:	57                   	push   %edi
801074f4:	eb d6                	jmp    801074cc <sys_move_file+0x17c>
    cprintf("File not found: %s\n", src_file);
801074f6:	83 ec 08             	sub    $0x8,%esp
801074f9:	ff b5 4c ff ff ff    	push   -0xb4(%ebp)
801074ff:	68 4d a3 10 80       	push   $0x8010a34d
80107504:	e8 67 95 ff ff       	call   80100a70 <cprintf>
    end_op();
80107509:	e8 02 c6 ff ff       	call   80103b10 <end_op>
    return -1;
8010750e:	83 c4 10             	add    $0x10,%esp
80107511:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107516:	eb 9b                	jmp    801074b3 <sys_move_file+0x163>
    cprintf("Directory not found: %s\n", dest_dir);
80107518:	83 ec 08             	sub    $0x8,%esp
8010751b:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80107521:	68 61 a3 10 80       	push   $0x8010a361
80107526:	e8 45 95 ff ff       	call   80100a70 <cprintf>
    iunlockput(src_ip);
8010752b:	eb a4                	jmp    801074d1 <sys_move_file+0x181>
8010752d:	66 90                	xchg   %ax,%ax
8010752f:	90                   	nop

80107530 <create_palindrome_num>:

#include "syscall.h"
#include "traps.h"


int create_palindrome_num(int num) {
80107530:	55                   	push   %ebp
80107531:	89 e5                	mov    %esp,%ebp
80107533:	57                   	push   %edi
80107534:	56                   	push   %esi
80107535:	53                   	push   %ebx
80107536:	83 ec 4c             	sub    $0x4c,%esp
80107539:	8b 4d 08             	mov    0x8(%ebp),%ecx
    //(20 digits to handle large integers)
    int length = 0;

    // Converting our integer to string
    int temp = num;
    while (temp > 0) {
8010753c:	85 c9                	test   %ecx,%ecx
8010753e:	0f 8e 9c 00 00 00    	jle    801075e0 <create_palindrome_num+0xb0>
    int length = 0;
80107544:	31 f6                	xor    %esi,%esi
80107546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010754d:	8d 76 00             	lea    0x0(%esi),%esi
        str[length++] = (temp % 10) + '0';
80107550:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
80107555:	89 f3                	mov    %esi,%ebx
80107557:	8d 76 01             	lea    0x1(%esi),%esi
8010755a:	f7 e1                	mul    %ecx
8010755c:	89 c8                	mov    %ecx,%eax
8010755e:	c1 ea 03             	shr    $0x3,%edx
80107561:	8d 3c 92             	lea    (%edx,%edx,4),%edi
80107564:	01 ff                	add    %edi,%edi
80107566:	29 f8                	sub    %edi,%eax
80107568:	83 c0 30             	add    $0x30,%eax
8010756b:	88 44 35 ab          	mov    %al,-0x55(%ebp,%esi,1)
        temp /= 10;
8010756f:	89 c8                	mov    %ecx,%eax
80107571:	89 d1                	mov    %edx,%ecx
    while (temp > 0) {
80107573:	83 f8 09             	cmp    $0x9,%eax
80107576:	7f d8                	jg     80107550 <create_palindrome_num+0x20>
    }
    str[length] = '\0'; 
80107578:	8d 45 ac             	lea    -0x54(%ebp),%eax
8010757b:	c6 44 35 ac 00       	movb   $0x0,-0x54(%ebp,%esi,1)

    char palindrome_str[40];  // 2x length buffer to handle the palindrome
    int i, j;
    for (i = 0; i < length; i++) {
80107580:	8d 75 c0             	lea    -0x40(%ebp),%esi
80107583:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80107586:	8d 7c 1d c1          	lea    -0x3f(%ebp,%ebx,1),%edi
8010758a:	89 f0                	mov    %esi,%eax
8010758c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80107590:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < length; i++) {
80107593:	83 c0 01             	add    $0x1,%eax
80107596:	83 ea 01             	sub    $0x1,%edx
        palindrome_str[i] = str[length - i - 1];  // Copying the reversed part
80107599:	88 48 ff             	mov    %cl,-0x1(%eax)
    for (i = 0; i < length; i++) {
8010759c:	39 f8                	cmp    %edi,%eax
8010759e:	75 f0                	jne    80107590 <create_palindrome_num+0x60>
801075a0:	31 c0                	xor    %eax,%eax
    }
    for (j = 0; j < length; j++) {
        palindrome_str[i++] = str[j];  // Copying the original part
801075a2:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
801075a5:	8d 76 00             	lea    0x0(%esi),%esi
801075a8:	0f b6 4c 05 ac       	movzbl -0x54(%ebp,%eax,1),%ecx
801075ad:	89 c2                	mov    %eax,%edx
801075af:	88 4c 07 01          	mov    %cl,0x1(%edi,%eax,1)
    for (j = 0; j < length; j++) {
801075b3:	83 c0 01             	add    $0x1,%eax
801075b6:	39 d3                	cmp    %edx,%ebx
801075b8:	75 ee                	jne    801075a8 <create_palindrome_num+0x78>
        palindrome_str[i++] = str[j];  // Copying the original part
801075ba:	8d 44 1b 02          	lea    0x2(%ebx,%ebx,1),%eax
    }
    palindrome_str[i] = '\0';

    cprintf("%s\n", palindrome_str);
801075be:	83 ec 08             	sub    $0x8,%esp
    palindrome_str[i] = '\0';
801075c1:	c6 44 05 c0 00       	movb   $0x0,-0x40(%ebp,%eax,1)
    cprintf("%s\n", palindrome_str);
801075c6:	56                   	push   %esi
801075c7:	68 5d a3 10 80       	push   $0x8010a35d
801075cc:	e8 9f 94 ff ff       	call   80100a70 <cprintf>

    return 0;
}
801075d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075d4:	31 c0                	xor    %eax,%eax
801075d6:	5b                   	pop    %ebx
801075d7:	5e                   	pop    %esi
801075d8:	5f                   	pop    %edi
801075d9:	5d                   	pop    %ebp
801075da:	c3                   	ret    
801075db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075df:	90                   	nop
    for (i = 0; i < length; i++) {
801075e0:	31 c0                	xor    %eax,%eax
801075e2:	8d 75 c0             	lea    -0x40(%ebp),%esi
801075e5:	eb d7                	jmp    801075be <create_palindrome_num+0x8e>
801075e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075ee:	66 90                	xchg   %ax,%ax

801075f0 <sys_create_palindrome>:

int sys_create_palindrome(void) {
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	83 ec 20             	sub    $0x20,%esp
    int num;

    // Receive the integer argument from the REGISTERS
    if (argint(0, &num) < 0)
801075f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801075f9:	50                   	push   %eax
801075fa:	6a 00                	push   $0x0
801075fc:	e8 7f ef ff ff       	call   80106580 <argint>
80107601:	83 c4 10             	add    $0x10,%esp
80107604:	85 c0                	test   %eax,%eax
80107606:	78 18                	js     80107620 <sys_create_palindrome+0x30>
        return -1;

    // Generate and print the palindrome in kernel level
    create_palindrome_num(num);
80107608:	83 ec 0c             	sub    $0xc,%esp
8010760b:	ff 75 f4             	push   -0xc(%ebp)
8010760e:	e8 1d ff ff ff       	call   80107530 <create_palindrome_num>

    return 0;
80107613:	83 c4 10             	add    $0x10,%esp
80107616:	31 c0                	xor    %eax,%eax
}
80107618:	c9                   	leave  
80107619:	c3                   	ret    
8010761a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107620:	c9                   	leave  
        return -1;
80107621:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107626:	c3                   	ret    
80107627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010762e:	66 90                	xchg   %ax,%ax

80107630 <sys_fork>:
};

int
sys_fork(void)
{
  return fork();
80107630:	e9 4b d5 ff ff       	jmp    80104b80 <fork>
80107635:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010763c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107640 <sys_exit>:
}

int
sys_exit(void)
{
80107640:	55                   	push   %ebp
80107641:	89 e5                	mov    %esp,%ebp
80107643:	83 ec 08             	sub    $0x8,%esp
  exit();
80107646:	e8 35 da ff ff       	call   80105080 <exit>
  return 0;  // not reached
}
8010764b:	31 c0                	xor    %eax,%eax
8010764d:	c9                   	leave  
8010764e:	c3                   	ret    
8010764f:	90                   	nop

80107650 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80107650:	e9 7b db ff ff       	jmp    801051d0 <wait>
80107655:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107660 <sys_kill>:
}

int
sys_kill(void)
{
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80107666:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107669:	50                   	push   %eax
8010766a:	6a 00                	push   $0x0
8010766c:	e8 0f ef ff ff       	call   80106580 <argint>
80107671:	83 c4 10             	add    $0x10,%esp
80107674:	85 c0                	test   %eax,%eax
80107676:	78 18                	js     80107690 <sys_kill+0x30>
    return -1;
  return kill(pid);
80107678:	83 ec 0c             	sub    $0xc,%esp
8010767b:	ff 75 f4             	push   -0xc(%ebp)
8010767e:	e8 1d de ff ff       	call   801054a0 <kill>
80107683:	83 c4 10             	add    $0x10,%esp
}
80107686:	c9                   	leave  
80107687:	c3                   	ret    
80107688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010768f:	90                   	nop
80107690:	c9                   	leave  
    return -1;
80107691:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107696:	c3                   	ret    
80107697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010769e:	66 90                	xchg   %ax,%ax

801076a0 <sys_getpid>:

int
sys_getpid(void)
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801076a6:	e8 d5 d0 ff ff       	call   80104780 <myproc>
801076ab:	8b 40 7c             	mov    0x7c(%eax),%eax
}
801076ae:	c9                   	leave  
801076af:	c3                   	ret    

801076b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801076b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801076b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801076ba:	50                   	push   %eax
801076bb:	6a 00                	push   $0x0
801076bd:	e8 be ee ff ff       	call   80106580 <argint>
801076c2:	83 c4 10             	add    $0x10,%esp
801076c5:	85 c0                	test   %eax,%eax
801076c7:	78 27                	js     801076f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801076c9:	e8 b2 d0 ff ff       	call   80104780 <myproc>
  if(growproc(n) < 0)
801076ce:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801076d1:	8b 58 6c             	mov    0x6c(%eax),%ebx
  if(growproc(n) < 0)
801076d4:	ff 75 f4             	push   -0xc(%ebp)
801076d7:	e8 44 d1 ff ff       	call   80104820 <growproc>
801076dc:	83 c4 10             	add    $0x10,%esp
801076df:	85 c0                	test   %eax,%eax
801076e1:	78 0d                	js     801076f0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801076e3:	89 d8                	mov    %ebx,%eax
801076e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801076e8:	c9                   	leave  
801076e9:	c3                   	ret    
801076ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801076f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801076f5:	eb ec                	jmp    801076e3 <sys_sbrk+0x33>
801076f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076fe:	66 90                	xchg   %ax,%ax

80107700 <sys_sleep>:

int
sys_sleep(void)
{
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80107704:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80107707:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010770a:	50                   	push   %eax
8010770b:	6a 00                	push   $0x0
8010770d:	e8 6e ee ff ff       	call   80106580 <argint>
80107712:	83 c4 10             	add    $0x10,%esp
80107715:	85 c0                	test   %eax,%eax
80107717:	0f 88 8a 00 00 00    	js     801077a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010771d:	83 ec 0c             	sub    $0xc,%esp
80107720:	68 20 9a 11 80       	push   $0x80119a20
80107725:	e8 d6 ea ff ff       	call   80106200 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010772a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010772d:	8b 1d c4 99 11 80    	mov    0x801199c4,%ebx
  while(ticks - ticks0 < n){
80107733:	83 c4 10             	add    $0x10,%esp
80107736:	85 d2                	test   %edx,%edx
80107738:	75 27                	jne    80107761 <sys_sleep+0x61>
8010773a:	eb 54                	jmp    80107790 <sys_sleep+0x90>
8010773c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80107740:	83 ec 08             	sub    $0x8,%esp
80107743:	68 20 9a 11 80       	push   $0x80119a20
80107748:	68 c4 99 11 80       	push   $0x801199c4
8010774d:	e8 1e dc ff ff       	call   80105370 <sleep>
  while(ticks - ticks0 < n){
80107752:	a1 c4 99 11 80       	mov    0x801199c4,%eax
80107757:	83 c4 10             	add    $0x10,%esp
8010775a:	29 d8                	sub    %ebx,%eax
8010775c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010775f:	73 2f                	jae    80107790 <sys_sleep+0x90>
    if(myproc()->killed){
80107761:	e8 1a d0 ff ff       	call   80104780 <myproc>
80107766:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010776c:	85 c0                	test   %eax,%eax
8010776e:	74 d0                	je     80107740 <sys_sleep+0x40>
      release(&tickslock);
80107770:	83 ec 0c             	sub    $0xc,%esp
80107773:	68 20 9a 11 80       	push   $0x80119a20
80107778:	e8 23 ea ff ff       	call   801061a0 <release>
  }
  release(&tickslock);
  return 0;
}
8010777d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80107780:	83 c4 10             	add    $0x10,%esp
80107783:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107788:	c9                   	leave  
80107789:	c3                   	ret    
8010778a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&tickslock);
80107790:	83 ec 0c             	sub    $0xc,%esp
80107793:	68 20 9a 11 80       	push   $0x80119a20
80107798:	e8 03 ea ff ff       	call   801061a0 <release>
  return 0;
8010779d:	83 c4 10             	add    $0x10,%esp
801077a0:	31 c0                	xor    %eax,%eax
}
801077a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801077a5:	c9                   	leave  
801077a6:	c3                   	ret    
    return -1;
801077a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801077ac:	eb f4                	jmp    801077a2 <sys_sleep+0xa2>
801077ae:	66 90                	xchg   %ax,%ax

801077b0 <sys_sort_syscalls>:

int sys_sort_syscalls(void)
{
801077b0:	55                   	push   %ebp
801077b1:	89 e5                	mov    %esp,%ebp
801077b3:	57                   	push   %edi
801077b4:	56                   	push   %esi
  int pid;
  int counts[MAX_SYSCALLS];
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
801077b5:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
{
801077bb:	53                   	push   %ebx
801077bc:	81 ec 84 00 00 00    	sub    $0x84,%esp
  if(argint(0, &pid)<0 || argptr(0,(void*)&counts, sizeof(int)*MAX_SYSCALLS<0))
801077c2:	50                   	push   %eax
801077c3:	6a 00                	push   $0x0
801077c5:	e8 b6 ed ff ff       	call   80106580 <argint>
801077ca:	83 c4 10             	add    $0x10,%esp
801077cd:	85 c0                	test   %eax,%eax
801077cf:	78 71                	js     80107842 <sys_sort_syscalls+0x92>
801077d1:	83 ec 04             	sub    $0x4,%esp
801077d4:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
801077da:	6a 00                	push   $0x0
801077dc:	50                   	push   %eax
801077dd:	6a 00                	push   $0x0
801077df:	e8 ec ed ff ff       	call   801065d0 <argptr>
801077e4:	83 c4 10             	add    $0x10,%esp
801077e7:	89 c7                	mov    %eax,%edi
801077e9:	85 c0                	test   %eax,%eax
801077eb:	75 55                	jne    80107842 <sys_sort_syscalls+0x92>
    return -1;
  
  struct proc *p = findproc(pid);
801077ed:	83 ec 0c             	sub    $0xc,%esp
801077f0:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
801077f6:	e8 b5 cf ff ff       	call   801047b0 <findproc>
  if(p==0) return -1;
801077fb:	83 c4 10             	add    $0x10,%esp
  struct proc *p = findproc(pid);
801077fe:	89 c6                	mov    %eax,%esi
  if(p==0) return -1;
80107800:	85 c0                	test   %eax,%eax
80107802:	74 3e                	je     80107842 <sys_sort_syscalls+0x92>
  for(int i=0; i<MAX_SYSCALLS; i++)
80107804:	31 db                	xor    %ebx,%ebx
80107806:	eb 10                	jmp    80107818 <sys_sort_syscalls+0x68>
80107808:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010780f:	90                   	nop
80107810:	83 c3 01             	add    $0x1,%ebx
80107813:	83 fb 1b             	cmp    $0x1b,%ebx
80107816:	74 20                	je     80107838 <sys_sort_syscalls+0x88>
  {
    if(p->syscalls[i] != 0)
80107818:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
8010781b:	85 c0                	test   %eax,%eax
8010781d:	74 f1                	je     80107810 <sys_sort_syscalls+0x60>
      cprintf("%d\n", i);
8010781f:	83 ec 08             	sub    $0x8,%esp
80107822:	53                   	push   %ebx
  for(int i=0; i<MAX_SYSCALLS; i++)
80107823:	83 c3 01             	add    $0x1,%ebx
      cprintf("%d\n", i);
80107826:	68 ee 9f 10 80       	push   $0x80109fee
8010782b:	e8 40 92 ff ff       	call   80100a70 <cprintf>
80107830:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<MAX_SYSCALLS; i++)
80107833:	83 fb 1b             	cmp    $0x1b,%ebx
80107836:	75 e0                	jne    80107818 <sys_sort_syscalls+0x68>

  }
  return 0;
}
80107838:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010783b:	89 f8                	mov    %edi,%eax
8010783d:	5b                   	pop    %ebx
8010783e:	5e                   	pop    %esi
8010783f:	5f                   	pop    %edi
80107840:	5d                   	pop    %ebp
80107841:	c3                   	ret    
    return -1;
80107842:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80107847:	eb ef                	jmp    80107838 <sys_sort_syscalls+0x88>
80107849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107850 <sys_get_most_syscalls>:

int sys_get_most_syscalls(void)
{
80107850:	55                   	push   %ebp
80107851:	89 e5                	mov    %esp,%ebp
80107853:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid)<0 , sizeof(int)*MAX_SYSCALLS<0)
80107856:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107859:	50                   	push   %eax
8010785a:	6a 00                	push   $0x0
8010785c:	e8 1f ed ff ff       	call   80106580 <argint>
    return -1;
  
  struct proc *p = findproc(pid);
80107861:	58                   	pop    %eax
80107862:	ff 75 f4             	push   -0xc(%ebp)
80107865:	e8 46 cf ff ff       	call   801047b0 <findproc>
  if(p==0) return -1;
8010786a:	83 c4 10             	add    $0x10,%esp
8010786d:	85 c0                	test   %eax,%eax
8010786f:	74 3f                	je     801078b0 <sys_get_most_syscalls+0x60>
  int syscall_most_invoked = -1;
  for(int i=0; i<MAX_SYSCALLS; i++)
80107871:	31 d2                	xor    %edx,%edx
  int syscall_most_invoked = -1;
80107873:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010787f:	90                   	nop
    if(p->syscalls[i] > syscall_most_invoked)
80107880:	39 0c 90             	cmp    %ecx,(%eax,%edx,4)
80107883:	0f 4f ca             	cmovg  %edx,%ecx
  for(int i=0; i<MAX_SYSCALLS; i++)
80107886:	83 c2 01             	add    $0x1,%edx
80107889:	83 fa 1b             	cmp    $0x1b,%edx
8010788c:	75 f2                	jne    80107880 <sys_get_most_syscalls+0x30>
      syscall_most_invoked = i;
  if(syscall_most_invoked<0) return -1;
8010788e:	85 c9                	test   %ecx,%ecx
80107890:	78 1e                	js     801078b0 <sys_get_most_syscalls+0x60>
  cprintf("System call been most invoked: %s - %d times", syscall_names[syscall_most_invoked], p->syscalls[syscall_most_invoked]);
80107892:	83 ec 04             	sub    $0x4,%esp
80107895:	ff 34 88             	push   (%eax,%ecx,4)
80107898:	ff 34 8d 20 d0 10 80 	push   -0x7fef2fe0(,%ecx,4)
8010789f:	68 cc a3 10 80       	push   $0x8010a3cc
801078a4:	e8 c7 91 ff ff       	call   80100a70 <cprintf>
  return 0;
801078a9:	83 c4 10             	add    $0x10,%esp
801078ac:	31 c0                	xor    %eax,%eax
}
801078ae:	c9                   	leave  
801078af:	c3                   	ret    
801078b0:	c9                   	leave  
  if(p==0) return -1;
801078b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078b6:	c3                   	ret    
801078b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078be:	66 90                	xchg   %ax,%ax

801078c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801078c0:	55                   	push   %ebp
801078c1:	89 e5                	mov    %esp,%ebp
801078c3:	53                   	push   %ebx
801078c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801078c7:	68 20 9a 11 80       	push   $0x80119a20
801078cc:	e8 2f e9 ff ff       	call   80106200 <acquire>
  xticks = ticks;
801078d1:	8b 1d c4 99 11 80    	mov    0x801199c4,%ebx
  release(&tickslock);
801078d7:	c7 04 24 20 9a 11 80 	movl   $0x80119a20,(%esp)
801078de:	e8 bd e8 ff ff       	call   801061a0 <release>
  return xticks;
}
801078e3:	89 d8                	mov    %ebx,%eax
801078e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801078e8:	c9                   	leave  
801078e9:	c3                   	ret    
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078f0 <sys_list_active_processes>:


int sys_list_active_processes(void) {
801078f0:	55                   	push   %ebp
801078f1:	89 e5                	mov    %esp,%ebp
801078f3:	83 ec 08             	sub    $0x8,%esp
    list_active_processes();
801078f6:	e8 e5 dc ff ff       	call   801055e0 <list_active_processes>
    return 0;  // Return 0 to indicate success
}
801078fb:	31 c0                	xor    %eax,%eax
801078fd:	c9                   	leave  
801078fe:	c3                   	ret    
801078ff:	90                   	nop

80107900 <sys_set_level>:

int sys_set_level(void)
{
80107900:	55                   	push   %ebp
80107901:	89 e5                	mov    %esp,%ebp
80107903:	83 ec 20             	sub    $0x20,%esp
  int pid, level;
  if(argint(0,&pid)<0||argint(1,&level)<0)
80107906:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107909:	50                   	push   %eax
8010790a:	6a 00                	push   $0x0
8010790c:	e8 6f ec ff ff       	call   80106580 <argint>
80107911:	83 c4 10             	add    $0x10,%esp
80107914:	85 c0                	test   %eax,%eax
80107916:	78 23                	js     8010793b <sys_set_level+0x3b>
80107918:	83 ec 08             	sub    $0x8,%esp
8010791b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010791e:	50                   	push   %eax
8010791f:	6a 01                	push   $0x1
80107921:	e8 5a ec ff ff       	call   80106580 <argint>
80107926:	83 c4 10             	add    $0x10,%esp
80107929:	85 c0                	test   %eax,%eax
8010792b:	78 0e                	js     8010793b <sys_set_level+0x3b>
    return;
  int res = set_level(pid,level);
8010792d:	83 ec 08             	sub    $0x8,%esp
80107930:	ff 75 f4             	push   -0xc(%ebp)
80107933:	ff 75 f0             	push   -0x10(%ebp)
80107936:	e8 85 d0 ff ff       	call   801049c0 <set_level>
  return res;
}
8010793b:	c9                   	leave  
8010793c:	c3                   	ret    
8010793d:	8d 76 00             	lea    0x0(%esi),%esi

80107940 <sys_show_process_info>:

void sys_show_process_info()
{
  show_process_info();
80107940:	e9 ab dd ff ff       	jmp    801056f0 <show_process_info>
80107945:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010794c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107950 <sys_set_burst_confidence>:
}

void sys_set_burst_confidence(void)
{
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	83 ec 20             	sub    $0x20,%esp
  int pid, burst, conf;
  if(argint(0,&pid)<0||argint(1,&burst)<0|| argint(2,&conf)<0)
80107956:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107959:	50                   	push   %eax
8010795a:	6a 00                	push   $0x0
8010795c:	e8 1f ec ff ff       	call   80106580 <argint>
80107961:	83 c4 10             	add    $0x10,%esp
80107964:	85 c0                	test   %eax,%eax
80107966:	78 3e                	js     801079a6 <sys_set_burst_confidence+0x56>
80107968:	83 ec 08             	sub    $0x8,%esp
8010796b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010796e:	50                   	push   %eax
8010796f:	6a 01                	push   $0x1
80107971:	e8 0a ec ff ff       	call   80106580 <argint>
80107976:	83 c4 10             	add    $0x10,%esp
80107979:	85 c0                	test   %eax,%eax
8010797b:	78 29                	js     801079a6 <sys_set_burst_confidence+0x56>
8010797d:	83 ec 08             	sub    $0x8,%esp
80107980:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107983:	50                   	push   %eax
80107984:	6a 02                	push   $0x2
80107986:	e8 f5 eb ff ff       	call   80106580 <argint>
8010798b:	83 c4 10             	add    $0x10,%esp
8010798e:	85 c0                	test   %eax,%eax
80107990:	78 14                	js     801079a6 <sys_set_burst_confidence+0x56>
    return;
  set_burst_confidence(pid, burst, conf);
80107992:	83 ec 04             	sub    $0x4,%esp
80107995:	ff 75 f4             	push   -0xc(%ebp)
80107998:	ff 75 f0             	push   -0x10(%ebp)
8010799b:	ff 75 ec             	push   -0x14(%ebp)
8010799e:	e8 ad e1 ff ff       	call   80105b50 <set_burst_confidence>
801079a3:	83 c4 10             	add    $0x10,%esp
}
801079a6:	c9                   	leave  
801079a7:	c3                   	ret    
801079a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079af:	90                   	nop

801079b0 <sys_count_syscalls_all_cpus>:

int sys_count_syscalls_all_cpus(void)
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	53                   	push   %ebx
801079b4:	83 ec 10             	sub    $0x10,%esp
  int count;

  acquire(&syscallslock);
801079b7:	68 e0 99 11 80       	push   $0x801199e0
801079bc:	e8 3f e8 ff ff       	call   80106200 <acquire>
  count = syscalls_count;
801079c1:	8b 1d c0 99 11 80    	mov    0x801199c0,%ebx
  release(&syscallslock);
801079c7:	c7 04 24 e0 99 11 80 	movl   $0x801199e0,(%esp)
801079ce:	e8 cd e7 ff ff       	call   801061a0 <release>

  return count;

}
801079d3:	89 d8                	mov    %ebx,%eax
801079d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801079d8:	c9                   	leave  
801079d9:	c3                   	ret    
801079da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801079e0 <sys_sum_all_cpus_syscalls>:

int sys_sum_all_cpus_syscalls(void)
{
  return sum_all_cpus_syscalls();
801079e0:	e9 3b e2 ff ff       	jmp    80105c20 <sum_all_cpus_syscalls>
801079e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801079f0 <sys_test_reentrantlock>:
}

int sys_test_reentrantlock()
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	83 ec 20             	sub    $0x20,%esp
  int num;
  if(argint(0, &num) < 0)
801079f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801079f9:	50                   	push   %eax
801079fa:	6a 00                	push   $0x0
801079fc:	e8 7f eb ff ff       	call   80106580 <argint>
80107a01:	83 c4 10             	add    $0x10,%esp
80107a04:	85 c0                	test   %eax,%eax
80107a06:	78 18                	js     80107a20 <sys_test_reentrantlock+0x30>
  {
    return -1;
  }
  return test_reentrantlock(num);
80107a08:	83 ec 0c             	sub    $0xc,%esp
80107a0b:	ff 75 f4             	push   -0xc(%ebp)
80107a0e:	e8 ad e3 ff ff       	call   80105dc0 <test_reentrantlock>
80107a13:	83 c4 10             	add    $0x10,%esp
}
80107a16:	c9                   	leave  
80107a17:	c3                   	ret    
80107a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a1f:	90                   	nop
80107a20:	c9                   	leave  
    return -1;
80107a21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a26:	c3                   	ret    
80107a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a2e:	66 90                	xchg   %ax,%ax

80107a30 <sys_open_sharedmem>:



char*
sys_open_sharedmem(void){
80107a30:	55                   	push   %ebp
80107a31:	89 e5                	mov    %esp,%ebp
80107a33:	83 ec 20             	sub    $0x20,%esp
  int id;
  if (argint(0, &id) < 0)
80107a36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107a39:	50                   	push   %eax
80107a3a:	6a 00                	push   $0x0
80107a3c:	e8 3f eb ff ff       	call   80106580 <argint>
80107a41:	83 c4 10             	add    $0x10,%esp
80107a44:	89 c2                	mov    %eax,%edx
80107a46:	31 c0                	xor    %eax,%eax
80107a48:	85 d2                	test   %edx,%edx
80107a4a:	78 0e                	js     80107a5a <sys_open_sharedmem+0x2a>
    return 0;
  return open_sharedmem(id);
80107a4c:	83 ec 0c             	sub    $0xc,%esp
80107a4f:	ff 75 f4             	push   -0xc(%ebp)
80107a52:	e8 89 1c 00 00       	call   801096e0 <open_sharedmem>
80107a57:	83 c4 10             	add    $0x10,%esp
}
80107a5a:	c9                   	leave  
80107a5b:	c3                   	ret    
80107a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107a60 <sys_close_sharedmem>:

void
sys_close_sharedmem(void){
80107a60:	55                   	push   %ebp
80107a61:	89 e5                	mov    %esp,%ebp
80107a63:	83 ec 20             	sub    $0x20,%esp
  int id;
  if (argint(0, &id) < 0)
80107a66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107a69:	50                   	push   %eax
80107a6a:	6a 00                	push   $0x0
80107a6c:	e8 0f eb ff ff       	call   80106580 <argint>
80107a71:	83 c4 10             	add    $0x10,%esp
80107a74:	85 c0                	test   %eax,%eax
80107a76:	78 0e                	js     80107a86 <sys_close_sharedmem+0x26>
    return;
  close_sharedmem(id);
80107a78:	83 ec 0c             	sub    $0xc,%esp
80107a7b:	ff 75 f4             	push   -0xc(%ebp)
80107a7e:	e8 cd 1d 00 00       	call   80109850 <close_sharedmem>
80107a83:	83 c4 10             	add    $0x10,%esp
80107a86:	c9                   	leave  
80107a87:	c3                   	ret    

80107a88 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107a88:	1e                   	push   %ds
  pushl %es
80107a89:	06                   	push   %es
  pushl %fs
80107a8a:	0f a0                	push   %fs
  pushl %gs
80107a8c:	0f a8                	push   %gs
  pushal
80107a8e:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80107a8f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107a93:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107a95:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107a97:	54                   	push   %esp
  call trap
80107a98:	e8 d3 00 00 00       	call   80107b70 <trap>
  addl $4, %esp
80107a9d:	83 c4 04             	add    $0x4,%esp

80107aa0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80107aa0:	61                   	popa   
  popl %gs
80107aa1:	0f a9                	pop    %gs
  popl %fs
80107aa3:	0f a1                	pop    %fs
  popl %es
80107aa5:	07                   	pop    %es
  popl %ds
80107aa6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107aa7:	83 c4 08             	add    $0x8,%esp
  iret
80107aaa:	cf                   	iret   
80107aab:	66 90                	xchg   %ax,%ax
80107aad:	66 90                	xchg   %ax,%ax
80107aaf:	90                   	nop

80107ab0 <tvinit>:
uint ticks;
uint syscalls_count;

void
tvinit(void)
{
80107ab0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107ab1:	31 c0                	xor    %eax,%eax
{
80107ab3:	89 e5                	mov    %esp,%ebp
80107ab5:	83 ec 08             	sub    $0x8,%esp
80107ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107abf:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107ac0:	8b 14 85 78 d0 10 80 	mov    -0x7fef2f88(,%eax,4),%edx
80107ac7:	c7 04 c5 62 9a 11 80 	movl   $0x8e000008,-0x7fee659e(,%eax,8)
80107ace:	08 00 00 8e 
80107ad2:	66 89 14 c5 60 9a 11 	mov    %dx,-0x7fee65a0(,%eax,8)
80107ad9:	80 
80107ada:	c1 ea 10             	shr    $0x10,%edx
80107add:	66 89 14 c5 66 9a 11 	mov    %dx,-0x7fee659a(,%eax,8)
80107ae4:	80 
  for(i = 0; i < 256; i++)
80107ae5:	83 c0 01             	add    $0x1,%eax
80107ae8:	3d 00 01 00 00       	cmp    $0x100,%eax
80107aed:	75 d1                	jne    80107ac0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80107aef:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107af2:	a1 78 d1 10 80       	mov    0x8010d178,%eax
80107af7:	c7 05 62 9c 11 80 08 	movl   $0xef000008,0x80119c62
80107afe:	00 00 ef 
  initlock(&tickslock, "time");
80107b01:	68 ad a3 10 80       	push   $0x8010a3ad
80107b06:	68 20 9a 11 80       	push   $0x80119a20
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107b0b:	66 a3 60 9c 11 80    	mov    %ax,0x80119c60
80107b11:	c1 e8 10             	shr    $0x10,%eax
80107b14:	66 a3 66 9c 11 80    	mov    %ax,0x80119c66
  initlock(&tickslock, "time");
80107b1a:	e8 11 e5 ff ff       	call   80106030 <initlock>
  initlock(&syscallslock, "syscall_count");
80107b1f:	58                   	pop    %eax
80107b20:	5a                   	pop    %edx
80107b21:	68 f9 a3 10 80       	push   $0x8010a3f9
80107b26:	68 e0 99 11 80       	push   $0x801199e0
80107b2b:	e8 00 e5 ff ff       	call   80106030 <initlock>
}
80107b30:	83 c4 10             	add    $0x10,%esp
80107b33:	c9                   	leave  
80107b34:	c3                   	ret    
80107b35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107b40 <idtinit>:

void
idtinit(void)
{
80107b40:	55                   	push   %ebp
  pd[0] = size-1;
80107b41:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80107b46:	89 e5                	mov    %esp,%ebp
80107b48:	83 ec 10             	sub    $0x10,%esp
80107b4b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107b4f:	b8 60 9a 11 80       	mov    $0x80119a60,%eax
80107b54:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107b58:	c1 e8 10             	shr    $0x10,%eax
80107b5b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80107b5f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107b62:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107b65:	c9                   	leave  
80107b66:	c3                   	ret    
80107b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b6e:	66 90                	xchg   %ax,%ax

80107b70 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107b70:	55                   	push   %ebp
80107b71:	89 e5                	mov    %esp,%ebp
80107b73:	57                   	push   %edi
80107b74:	56                   	push   %esi
80107b75:	53                   	push   %ebx
80107b76:	83 ec 1c             	sub    $0x1c,%esp
80107b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80107b7c:	8b 43 30             	mov    0x30(%ebx),%eax
80107b7f:	83 f8 40             	cmp    $0x40,%eax
80107b82:	0f 84 98 02 00 00    	je     80107e20 <trap+0x2b0>

    if(myproc()->killed)
      exit();
    return;
  }
  switch(tf->trapno){
80107b88:	83 e8 20             	sub    $0x20,%eax
80107b8b:	83 f8 1f             	cmp    $0x1f,%eax
80107b8e:	0f 87 8c 00 00 00    	ja     80107c20 <trap+0xb0>
80107b94:	ff 24 85 c0 a4 10 80 	jmp    *-0x7fef5b40(,%eax,4)
80107b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b9f:	90                   	nop
      aging();
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107ba0:	e8 db b3 ff ff       	call   80102f80 <ideintr>
    lapiceoi();
80107ba5:	e8 a6 ba ff ff       	call   80103650 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107baa:	e8 d1 cb ff ff       	call   80104780 <myproc>
80107baf:	85 c0                	test   %eax,%eax
80107bb1:	74 20                	je     80107bd3 <trap+0x63>
80107bb3:	e8 c8 cb ff ff       	call   80104780 <myproc>
80107bb8:	8b b8 90 00 00 00    	mov    0x90(%eax),%edi
80107bbe:	85 ff                	test   %edi,%edi
80107bc0:	74 11                	je     80107bd3 <trap+0x63>
80107bc2:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107bc6:	83 e0 03             	and    $0x3,%eax
80107bc9:	66 83 f8 03          	cmp    $0x3,%ax
80107bcd:	0f 84 95 02 00 00    	je     80107e68 <trap+0x2f8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107bd3:	e8 a8 cb ff ff       	call   80104780 <myproc>
80107bd8:	85 c0                	test   %eax,%eax
80107bda:	74 0f                	je     80107beb <trap+0x7b>
80107bdc:	e8 9f cb ff ff       	call   80104780 <myproc>
80107be1:	83 78 78 04          	cmpl   $0x4,0x78(%eax)
80107be5:	0f 84 c5 00 00 00    	je     80107cb0 <trap+0x140>
      yield();
    }
  }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107beb:	e8 90 cb ff ff       	call   80104780 <myproc>
80107bf0:	85 c0                	test   %eax,%eax
80107bf2:	74 20                	je     80107c14 <trap+0xa4>
80107bf4:	e8 87 cb ff ff       	call   80104780 <myproc>
80107bf9:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80107bff:	85 c0                	test   %eax,%eax
80107c01:	74 11                	je     80107c14 <trap+0xa4>
80107c03:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107c07:	83 e0 03             	and    $0x3,%eax
80107c0a:	66 83 f8 03          	cmp    $0x3,%ax
80107c0e:	0f 84 6a 01 00 00    	je     80107d7e <trap+0x20e>
    exit();
}
80107c14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c17:	5b                   	pop    %ebx
80107c18:	5e                   	pop    %esi
80107c19:	5f                   	pop    %edi
80107c1a:	5d                   	pop    %ebp
80107c1b:	c3                   	ret    
80107c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80107c20:	e8 5b cb ff ff       	call   80104780 <myproc>
80107c25:	8b 7b 38             	mov    0x38(%ebx),%edi
80107c28:	85 c0                	test   %eax,%eax
80107c2a:	0f 84 22 03 00 00    	je     80107f52 <trap+0x3e2>
80107c30:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107c34:	0f 84 18 03 00 00    	je     80107f52 <trap+0x3e2>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107c3a:	0f 20 d1             	mov    %cr2,%ecx
80107c3d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107c40:	e8 1b cb ff ff       	call   80104760 <cpuid>
80107c45:	8b 73 30             	mov    0x30(%ebx),%esi
80107c48:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107c4b:	8b 43 34             	mov    0x34(%ebx),%eax
80107c4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80107c51:	e8 2a cb ff ff       	call   80104780 <myproc>
80107c56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c59:	e8 22 cb ff ff       	call   80104780 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107c5e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107c61:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107c64:	51                   	push   %ecx
80107c65:	57                   	push   %edi
80107c66:	52                   	push   %edx
80107c67:	ff 75 e4             	push   -0x1c(%ebp)
80107c6a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80107c6b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80107c6e:	81 c6 d8 00 00 00    	add    $0xd8,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107c74:	56                   	push   %esi
80107c75:	ff 70 7c             	push   0x7c(%eax)
80107c78:	68 7c a4 10 80       	push   $0x8010a47c
80107c7d:	e8 ee 8d ff ff       	call   80100a70 <cprintf>
    myproc()->killed = 1;
80107c82:	83 c4 20             	add    $0x20,%esp
80107c85:	e8 f6 ca ff ff       	call   80104780 <myproc>
80107c8a:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%eax)
80107c91:	00 00 00 
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107c94:	e8 e7 ca ff ff       	call   80104780 <myproc>
80107c99:	85 c0                	test   %eax,%eax
80107c9b:	0f 85 12 ff ff ff    	jne    80107bb3 <trap+0x43>
80107ca1:	e9 2d ff ff ff       	jmp    80107bd3 <trap+0x63>
80107ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cad:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107cb0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80107cb4:	0f 85 31 ff ff ff    	jne    80107beb <trap+0x7b>
    if(myproc()->sched_info.level == ROUND_ROBIN)
80107cba:	e8 c1 ca ff ff       	call   80104780 <myproc>
80107cbf:	8b b0 f0 00 00 00    	mov    0xf0(%eax),%esi
80107cc5:	85 f6                	test   %esi,%esi
80107cc7:	0f 85 43 02 00 00    	jne    80107f10 <trap+0x3a0>
      mycpu()->rr--;
80107ccd:	e8 2e ca ff ff       	call   80104700 <mycpu>
80107cd2:	83 a8 b0 00 00 00 01 	subl   $0x1,0xb0(%eax)
    if(myproc()->sched_info.num_of_cycles<5)
80107cd9:	e8 a2 ca ff ff       	call   80104780 <myproc>
80107cde:	83 b8 08 01 00 00 04 	cmpl   $0x4,0x108(%eax)
80107ce5:	0f 8f 95 01 00 00    	jg     80107e80 <trap+0x310>
      myproc()->sched_info.num_of_cycles++;
80107ceb:	e8 90 ca ff ff       	call   80104780 <myproc>
80107cf0:	83 80 08 01 00 00 01 	addl   $0x1,0x108(%eax)
80107cf7:	e9 ef fe ff ff       	jmp    80107beb <trap+0x7b>
80107cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107d00:	8b 7b 38             	mov    0x38(%ebx),%edi
80107d03:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107d07:	e8 54 ca ff ff       	call   80104760 <cpuid>
80107d0c:	57                   	push   %edi
80107d0d:	56                   	push   %esi
80107d0e:	50                   	push   %eax
80107d0f:	68 24 a4 10 80       	push   $0x8010a424
80107d14:	e8 57 8d ff ff       	call   80100a70 <cprintf>
    lapiceoi();
80107d19:	e8 32 b9 ff ff       	call   80103650 <lapiceoi>
    break;
80107d1e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107d21:	e8 5a ca ff ff       	call   80104780 <myproc>
80107d26:	85 c0                	test   %eax,%eax
80107d28:	0f 85 85 fe ff ff    	jne    80107bb3 <trap+0x43>
80107d2e:	e9 a0 fe ff ff       	jmp    80107bd3 <trap+0x63>
80107d33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107d37:	90                   	nop
      syscalls_count+=3;
80107d38:	83 c0 03             	add    $0x3,%eax
      syscalls_count++;
80107d3b:	83 c0 01             	add    $0x1,%eax
    add_cpu_syscalls(my_eax);
80107d3e:	83 ec 0c             	sub    $0xc,%esp
80107d41:	a3 c0 99 11 80       	mov    %eax,0x801199c0
80107d46:	56                   	push   %esi
80107d47:	e8 74 de ff ff       	call   80105bc0 <add_cpu_syscalls>
    release(&syscallslock);
80107d4c:	c7 04 24 e0 99 11 80 	movl   $0x801199e0,(%esp)
80107d53:	e8 48 e4 ff ff       	call   801061a0 <release>
    myproc()->tf = tf;
80107d58:	e8 23 ca ff ff       	call   80104780 <myproc>
80107d5d:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
80107d63:	e8 58 e9 ff ff       	call   801066c0 <syscall>
    if(myproc()->killed)
80107d68:	e8 13 ca ff ff       	call   80104780 <myproc>
80107d6d:	83 c4 10             	add    $0x10,%esp
80107d70:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80107d76:	85 c0                	test   %eax,%eax
80107d78:	0f 84 96 fe ff ff    	je     80107c14 <trap+0xa4>
}
80107d7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d81:	5b                   	pop    %ebx
80107d82:	5e                   	pop    %esi
80107d83:	5f                   	pop    %edi
80107d84:	5d                   	pop    %ebp
      exit();
80107d85:	e9 f6 d2 ff ff       	jmp    80105080 <exit>
80107d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartintr();
80107d90:	e8 5b 03 00 00       	call   801080f0 <uartintr>
    lapiceoi();
80107d95:	e8 b6 b8 ff ff       	call   80103650 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107d9a:	e8 e1 c9 ff ff       	call   80104780 <myproc>
80107d9f:	85 c0                	test   %eax,%eax
80107da1:	0f 85 0c fe ff ff    	jne    80107bb3 <trap+0x43>
80107da7:	e9 27 fe ff ff       	jmp    80107bd3 <trap+0x63>
80107dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107db0:	e8 5b b7 ff ff       	call   80103510 <kbdintr>
    lapiceoi();
80107db5:	e8 96 b8 ff ff       	call   80103650 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107dba:	e8 c1 c9 ff ff       	call   80104780 <myproc>
80107dbf:	85 c0                	test   %eax,%eax
80107dc1:	0f 85 ec fd ff ff    	jne    80107bb3 <trap+0x43>
80107dc7:	e9 07 fe ff ff       	jmp    80107bd3 <trap+0x63>
80107dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107dd0:	e8 8b c9 ff ff       	call   80104760 <cpuid>
80107dd5:	85 c0                	test   %eax,%eax
80107dd7:	0f 85 c8 fd ff ff    	jne    80107ba5 <trap+0x35>
      acquire(&tickslock);
80107ddd:	83 ec 0c             	sub    $0xc,%esp
80107de0:	68 20 9a 11 80       	push   $0x80119a20
80107de5:	e8 16 e4 ff ff       	call   80106200 <acquire>
      wakeup(&ticks);
80107dea:	c7 04 24 c4 99 11 80 	movl   $0x801199c4,(%esp)
      ticks++;
80107df1:	83 05 c4 99 11 80 01 	addl   $0x1,0x801199c4
      wakeup(&ticks);
80107df8:	e8 43 d6 ff ff       	call   80105440 <wakeup>
      release(&tickslock);
80107dfd:	c7 04 24 20 9a 11 80 	movl   $0x80119a20,(%esp)
80107e04:	e8 97 e3 ff ff       	call   801061a0 <release>
      aging();
80107e09:	e8 d2 ce ff ff       	call   80104ce0 <aging>
80107e0e:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80107e11:	e9 8f fd ff ff       	jmp    80107ba5 <trap+0x35>
80107e16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e1d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
80107e20:	e8 5b c9 ff ff       	call   80104780 <myproc>
80107e25:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80107e2b:	85 c0                	test   %eax,%eax
80107e2d:	75 49                	jne    80107e78 <trap+0x308>
    acquire(&syscallslock);
80107e2f:	83 ec 0c             	sub    $0xc,%esp
    uint my_eax = tf->eax;
80107e32:	8b 73 1c             	mov    0x1c(%ebx),%esi
    acquire(&syscallslock);
80107e35:	68 e0 99 11 80       	push   $0x801199e0
80107e3a:	e8 c1 e3 ff ff       	call   80106200 <acquire>
      syscalls_count+=3;
80107e3f:	a1 c0 99 11 80       	mov    0x801199c0,%eax
    if(my_eax == SYS_open)
80107e44:	83 c4 10             	add    $0x10,%esp
80107e47:	83 fe 0f             	cmp    $0xf,%esi
80107e4a:	0f 84 e8 fe ff ff    	je     80107d38 <trap+0x1c8>
    if(my_eax == SYS_write)
80107e50:	83 fe 10             	cmp    $0x10,%esi
80107e53:	0f 85 e2 fe ff ff    	jne    80107d3b <trap+0x1cb>
      syscalls_count+=2;
80107e59:	83 c0 02             	add    $0x2,%eax
80107e5c:	e9 dd fe ff ff       	jmp    80107d3e <trap+0x1ce>
80107e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80107e68:	e8 13 d2 ff ff       	call   80105080 <exit>
80107e6d:	e9 61 fd ff ff       	jmp    80107bd3 <trap+0x63>
80107e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80107e78:	e8 03 d2 ff ff       	call   80105080 <exit>
80107e7d:	eb b0                	jmp    80107e2f <trap+0x2bf>
80107e7f:	90                   	nop
      cprintf("pid: ");
80107e80:	83 ec 0c             	sub    $0xc,%esp
80107e83:	68 0c a4 10 80       	push   $0x8010a40c
80107e88:	e8 e3 8b ff ff       	call   80100a70 <cprintf>
      cprintf("%d", myproc()->pid);
80107e8d:	e8 ee c8 ff ff       	call   80104780 <myproc>
80107e92:	5a                   	pop    %edx
80107e93:	59                   	pop    %ecx
80107e94:	ff 70 7c             	push   0x7c(%eax)
80107e97:	68 00 a0 10 80       	push   $0x8010a000
80107e9c:	e8 cf 8b ff ff       	call   80100a70 <cprintf>
      cprintf(" ticks: ");
80107ea1:	c7 04 24 12 a4 10 80 	movl   $0x8010a412,(%esp)
80107ea8:	e8 c3 8b ff ff       	call   80100a70 <cprintf>
      cprintf("%d",ticks);
80107ead:	5e                   	pop    %esi
80107eae:	5f                   	pop    %edi
80107eaf:	ff 35 c4 99 11 80    	push   0x801199c4
80107eb5:	68 00 a0 10 80       	push   $0x8010a000
80107eba:	e8 b1 8b ff ff       	call   80100a70 <cprintf>
      cprintf(" level: ");
80107ebf:	c7 04 24 1b a4 10 80 	movl   $0x8010a41b,(%esp)
80107ec6:	e8 a5 8b ff ff       	call   80100a70 <cprintf>
      cprintf("%d",myproc()->sched_info.level);
80107ecb:	e8 b0 c8 ff ff       	call   80104780 <myproc>
80107ed0:	5a                   	pop    %edx
80107ed1:	59                   	pop    %ecx
80107ed2:	ff b0 f0 00 00 00    	push   0xf0(%eax)
80107ed8:	68 00 a0 10 80       	push   $0x8010a000
80107edd:	e8 8e 8b ff ff       	call   80100a70 <cprintf>
      cprintf("\n");
80107ee2:	c7 04 24 11 a0 10 80 	movl   $0x8010a011,(%esp)
80107ee9:	e8 82 8b ff ff       	call   80100a70 <cprintf>
      myproc()->sched_info.num_of_cycles = 0;
80107eee:	e8 8d c8 ff ff       	call   80104780 <myproc>
80107ef3:	c7 80 08 01 00 00 00 	movl   $0x0,0x108(%eax)
80107efa:	00 00 00 
      yield();
80107efd:	e8 1e d4 ff ff       	call   80105320 <yield>
80107f02:	83 c4 10             	add    $0x10,%esp
80107f05:	e9 e1 fc ff ff       	jmp    80107beb <trap+0x7b>
80107f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if(myproc()->sched_info.level == SJF)
80107f10:	e8 6b c8 ff ff       	call   80104780 <myproc>
80107f15:	83 b8 f0 00 00 00 01 	cmpl   $0x1,0xf0(%eax)
80107f1c:	74 23                	je     80107f41 <trap+0x3d1>
    else if(myproc()->sched_info.level == FCFS)
80107f1e:	e8 5d c8 ff ff       	call   80104780 <myproc>
80107f23:	83 b8 f0 00 00 00 02 	cmpl   $0x2,0xf0(%eax)
80107f2a:	0f 85 a9 fd ff ff    	jne    80107cd9 <trap+0x169>
      mycpu()->fcfs--;
80107f30:	e8 cb c7 ff ff       	call   80104700 <mycpu>
80107f35:	83 a8 b8 00 00 00 01 	subl   $0x1,0xb8(%eax)
80107f3c:	e9 98 fd ff ff       	jmp    80107cd9 <trap+0x169>
      mycpu()->sjf--;
80107f41:	e8 ba c7 ff ff       	call   80104700 <mycpu>
80107f46:	83 a8 b4 00 00 00 01 	subl   $0x1,0xb4(%eax)
80107f4d:	e9 87 fd ff ff       	jmp    80107cd9 <trap+0x169>
80107f52:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107f55:	e8 06 c8 ff ff       	call   80104760 <cpuid>
80107f5a:	83 ec 0c             	sub    $0xc,%esp
80107f5d:	56                   	push   %esi
80107f5e:	57                   	push   %edi
80107f5f:	50                   	push   %eax
80107f60:	ff 73 30             	push   0x30(%ebx)
80107f63:	68 48 a4 10 80       	push   $0x8010a448
80107f68:	e8 03 8b ff ff       	call   80100a70 <cprintf>
      panic("trap");
80107f6d:	83 c4 14             	add    $0x14,%esp
80107f70:	68 07 a4 10 80       	push   $0x8010a407
80107f75:	e8 76 85 ff ff       	call   801004f0 <panic>
80107f7a:	66 90                	xchg   %ax,%ax
80107f7c:	66 90                	xchg   %ax,%ax
80107f7e:	66 90                	xchg   %ax,%ax

80107f80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107f80:	a1 60 a2 11 80       	mov    0x8011a260,%eax
80107f85:	85 c0                	test   %eax,%eax
80107f87:	74 17                	je     80107fa0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107f89:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107f8e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107f8f:	a8 01                	test   $0x1,%al
80107f91:	74 0d                	je     80107fa0 <uartgetc+0x20>
80107f93:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107f98:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107f99:	0f b6 c0             	movzbl %al,%eax
80107f9c:	c3                   	ret    
80107f9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80107fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107fa5:	c3                   	ret    
80107fa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fad:	8d 76 00             	lea    0x0(%esi),%esi

80107fb0 <uartinit>:
{
80107fb0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107fb1:	31 c9                	xor    %ecx,%ecx
80107fb3:	89 c8                	mov    %ecx,%eax
80107fb5:	89 e5                	mov    %esp,%ebp
80107fb7:	57                   	push   %edi
80107fb8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80107fbd:	56                   	push   %esi
80107fbe:	89 fa                	mov    %edi,%edx
80107fc0:	53                   	push   %ebx
80107fc1:	83 ec 1c             	sub    $0x1c,%esp
80107fc4:	ee                   	out    %al,(%dx)
80107fc5:	be fb 03 00 00       	mov    $0x3fb,%esi
80107fca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80107fcf:	89 f2                	mov    %esi,%edx
80107fd1:	ee                   	out    %al,(%dx)
80107fd2:	b8 0c 00 00 00       	mov    $0xc,%eax
80107fd7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107fdc:	ee                   	out    %al,(%dx)
80107fdd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80107fe2:	89 c8                	mov    %ecx,%eax
80107fe4:	89 da                	mov    %ebx,%edx
80107fe6:	ee                   	out    %al,(%dx)
80107fe7:	b8 03 00 00 00       	mov    $0x3,%eax
80107fec:	89 f2                	mov    %esi,%edx
80107fee:	ee                   	out    %al,(%dx)
80107fef:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107ff4:	89 c8                	mov    %ecx,%eax
80107ff6:	ee                   	out    %al,(%dx)
80107ff7:	b8 01 00 00 00       	mov    $0x1,%eax
80107ffc:	89 da                	mov    %ebx,%edx
80107ffe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107fff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80108004:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80108005:	3c ff                	cmp    $0xff,%al
80108007:	74 78                	je     80108081 <uartinit+0xd1>
  uart = 1;
80108009:	c7 05 60 a2 11 80 01 	movl   $0x1,0x8011a260
80108010:	00 00 00 
80108013:	89 fa                	mov    %edi,%edx
80108015:	ec                   	in     (%dx),%al
80108016:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010801b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010801c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010801f:	bf 40 a5 10 80       	mov    $0x8010a540,%edi
80108024:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80108029:	6a 00                	push   $0x0
8010802b:	6a 04                	push   $0x4
8010802d:	e8 8e b1 ff ff       	call   801031c0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80108032:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80108036:	83 c4 10             	add    $0x10,%esp
80108039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80108040:	a1 60 a2 11 80       	mov    0x8011a260,%eax
80108045:	bb 80 00 00 00       	mov    $0x80,%ebx
8010804a:	85 c0                	test   %eax,%eax
8010804c:	75 14                	jne    80108062 <uartinit+0xb2>
8010804e:	eb 23                	jmp    80108073 <uartinit+0xc3>
    microdelay(10);
80108050:	83 ec 0c             	sub    $0xc,%esp
80108053:	6a 0a                	push   $0xa
80108055:	e8 16 b6 ff ff       	call   80103670 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010805a:	83 c4 10             	add    $0x10,%esp
8010805d:	83 eb 01             	sub    $0x1,%ebx
80108060:	74 07                	je     80108069 <uartinit+0xb9>
80108062:	89 f2                	mov    %esi,%edx
80108064:	ec                   	in     (%dx),%al
80108065:	a8 20                	test   $0x20,%al
80108067:	74 e7                	je     80108050 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108069:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010806d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80108072:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80108073:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80108077:	83 c7 01             	add    $0x1,%edi
8010807a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010807d:	84 c0                	test   %al,%al
8010807f:	75 bf                	jne    80108040 <uartinit+0x90>
}
80108081:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108084:	5b                   	pop    %ebx
80108085:	5e                   	pop    %esi
80108086:	5f                   	pop    %edi
80108087:	5d                   	pop    %ebp
80108088:	c3                   	ret    
80108089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108090 <uartputc>:
  if(!uart)
80108090:	a1 60 a2 11 80       	mov    0x8011a260,%eax
80108095:	85 c0                	test   %eax,%eax
80108097:	74 47                	je     801080e0 <uartputc+0x50>
{
80108099:	55                   	push   %ebp
8010809a:	89 e5                	mov    %esp,%ebp
8010809c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010809d:	be fd 03 00 00       	mov    $0x3fd,%esi
801080a2:	53                   	push   %ebx
801080a3:	bb 80 00 00 00       	mov    $0x80,%ebx
801080a8:	eb 18                	jmp    801080c2 <uartputc+0x32>
801080aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801080b0:	83 ec 0c             	sub    $0xc,%esp
801080b3:	6a 0a                	push   $0xa
801080b5:	e8 b6 b5 ff ff       	call   80103670 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801080ba:	83 c4 10             	add    $0x10,%esp
801080bd:	83 eb 01             	sub    $0x1,%ebx
801080c0:	74 07                	je     801080c9 <uartputc+0x39>
801080c2:	89 f2                	mov    %esi,%edx
801080c4:	ec                   	in     (%dx),%al
801080c5:	a8 20                	test   $0x20,%al
801080c7:	74 e7                	je     801080b0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801080c9:	8b 45 08             	mov    0x8(%ebp),%eax
801080cc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801080d1:	ee                   	out    %al,(%dx)
}
801080d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801080d5:	5b                   	pop    %ebx
801080d6:	5e                   	pop    %esi
801080d7:	5d                   	pop    %ebp
801080d8:	c3                   	ret    
801080d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080e0:	c3                   	ret    
801080e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080ef:	90                   	nop

801080f0 <uartintr>:

void
uartintr(void)
{
801080f0:	55                   	push   %ebp
801080f1:	89 e5                	mov    %esp,%ebp
801080f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801080f6:	68 80 7f 10 80       	push   $0x80107f80
801080fb:	e8 40 8c ff ff       	call   80100d40 <consoleintr>
}
80108100:	83 c4 10             	add    $0x10,%esp
80108103:	c9                   	leave  
80108104:	c3                   	ret    

80108105 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80108105:	6a 00                	push   $0x0
  pushl $0
80108107:	6a 00                	push   $0x0
  jmp alltraps
80108109:	e9 7a f9 ff ff       	jmp    80107a88 <alltraps>

8010810e <vector1>:
.globl vector1
vector1:
  pushl $0
8010810e:	6a 00                	push   $0x0
  pushl $1
80108110:	6a 01                	push   $0x1
  jmp alltraps
80108112:	e9 71 f9 ff ff       	jmp    80107a88 <alltraps>

80108117 <vector2>:
.globl vector2
vector2:
  pushl $0
80108117:	6a 00                	push   $0x0
  pushl $2
80108119:	6a 02                	push   $0x2
  jmp alltraps
8010811b:	e9 68 f9 ff ff       	jmp    80107a88 <alltraps>

80108120 <vector3>:
.globl vector3
vector3:
  pushl $0
80108120:	6a 00                	push   $0x0
  pushl $3
80108122:	6a 03                	push   $0x3
  jmp alltraps
80108124:	e9 5f f9 ff ff       	jmp    80107a88 <alltraps>

80108129 <vector4>:
.globl vector4
vector4:
  pushl $0
80108129:	6a 00                	push   $0x0
  pushl $4
8010812b:	6a 04                	push   $0x4
  jmp alltraps
8010812d:	e9 56 f9 ff ff       	jmp    80107a88 <alltraps>

80108132 <vector5>:
.globl vector5
vector5:
  pushl $0
80108132:	6a 00                	push   $0x0
  pushl $5
80108134:	6a 05                	push   $0x5
  jmp alltraps
80108136:	e9 4d f9 ff ff       	jmp    80107a88 <alltraps>

8010813b <vector6>:
.globl vector6
vector6:
  pushl $0
8010813b:	6a 00                	push   $0x0
  pushl $6
8010813d:	6a 06                	push   $0x6
  jmp alltraps
8010813f:	e9 44 f9 ff ff       	jmp    80107a88 <alltraps>

80108144 <vector7>:
.globl vector7
vector7:
  pushl $0
80108144:	6a 00                	push   $0x0
  pushl $7
80108146:	6a 07                	push   $0x7
  jmp alltraps
80108148:	e9 3b f9 ff ff       	jmp    80107a88 <alltraps>

8010814d <vector8>:
.globl vector8
vector8:
  pushl $8
8010814d:	6a 08                	push   $0x8
  jmp alltraps
8010814f:	e9 34 f9 ff ff       	jmp    80107a88 <alltraps>

80108154 <vector9>:
.globl vector9
vector9:
  pushl $0
80108154:	6a 00                	push   $0x0
  pushl $9
80108156:	6a 09                	push   $0x9
  jmp alltraps
80108158:	e9 2b f9 ff ff       	jmp    80107a88 <alltraps>

8010815d <vector10>:
.globl vector10
vector10:
  pushl $10
8010815d:	6a 0a                	push   $0xa
  jmp alltraps
8010815f:	e9 24 f9 ff ff       	jmp    80107a88 <alltraps>

80108164 <vector11>:
.globl vector11
vector11:
  pushl $11
80108164:	6a 0b                	push   $0xb
  jmp alltraps
80108166:	e9 1d f9 ff ff       	jmp    80107a88 <alltraps>

8010816b <vector12>:
.globl vector12
vector12:
  pushl $12
8010816b:	6a 0c                	push   $0xc
  jmp alltraps
8010816d:	e9 16 f9 ff ff       	jmp    80107a88 <alltraps>

80108172 <vector13>:
.globl vector13
vector13:
  pushl $13
80108172:	6a 0d                	push   $0xd
  jmp alltraps
80108174:	e9 0f f9 ff ff       	jmp    80107a88 <alltraps>

80108179 <vector14>:
.globl vector14
vector14:
  pushl $14
80108179:	6a 0e                	push   $0xe
  jmp alltraps
8010817b:	e9 08 f9 ff ff       	jmp    80107a88 <alltraps>

80108180 <vector15>:
.globl vector15
vector15:
  pushl $0
80108180:	6a 00                	push   $0x0
  pushl $15
80108182:	6a 0f                	push   $0xf
  jmp alltraps
80108184:	e9 ff f8 ff ff       	jmp    80107a88 <alltraps>

80108189 <vector16>:
.globl vector16
vector16:
  pushl $0
80108189:	6a 00                	push   $0x0
  pushl $16
8010818b:	6a 10                	push   $0x10
  jmp alltraps
8010818d:	e9 f6 f8 ff ff       	jmp    80107a88 <alltraps>

80108192 <vector17>:
.globl vector17
vector17:
  pushl $17
80108192:	6a 11                	push   $0x11
  jmp alltraps
80108194:	e9 ef f8 ff ff       	jmp    80107a88 <alltraps>

80108199 <vector18>:
.globl vector18
vector18:
  pushl $0
80108199:	6a 00                	push   $0x0
  pushl $18
8010819b:	6a 12                	push   $0x12
  jmp alltraps
8010819d:	e9 e6 f8 ff ff       	jmp    80107a88 <alltraps>

801081a2 <vector19>:
.globl vector19
vector19:
  pushl $0
801081a2:	6a 00                	push   $0x0
  pushl $19
801081a4:	6a 13                	push   $0x13
  jmp alltraps
801081a6:	e9 dd f8 ff ff       	jmp    80107a88 <alltraps>

801081ab <vector20>:
.globl vector20
vector20:
  pushl $0
801081ab:	6a 00                	push   $0x0
  pushl $20
801081ad:	6a 14                	push   $0x14
  jmp alltraps
801081af:	e9 d4 f8 ff ff       	jmp    80107a88 <alltraps>

801081b4 <vector21>:
.globl vector21
vector21:
  pushl $0
801081b4:	6a 00                	push   $0x0
  pushl $21
801081b6:	6a 15                	push   $0x15
  jmp alltraps
801081b8:	e9 cb f8 ff ff       	jmp    80107a88 <alltraps>

801081bd <vector22>:
.globl vector22
vector22:
  pushl $0
801081bd:	6a 00                	push   $0x0
  pushl $22
801081bf:	6a 16                	push   $0x16
  jmp alltraps
801081c1:	e9 c2 f8 ff ff       	jmp    80107a88 <alltraps>

801081c6 <vector23>:
.globl vector23
vector23:
  pushl $0
801081c6:	6a 00                	push   $0x0
  pushl $23
801081c8:	6a 17                	push   $0x17
  jmp alltraps
801081ca:	e9 b9 f8 ff ff       	jmp    80107a88 <alltraps>

801081cf <vector24>:
.globl vector24
vector24:
  pushl $0
801081cf:	6a 00                	push   $0x0
  pushl $24
801081d1:	6a 18                	push   $0x18
  jmp alltraps
801081d3:	e9 b0 f8 ff ff       	jmp    80107a88 <alltraps>

801081d8 <vector25>:
.globl vector25
vector25:
  pushl $0
801081d8:	6a 00                	push   $0x0
  pushl $25
801081da:	6a 19                	push   $0x19
  jmp alltraps
801081dc:	e9 a7 f8 ff ff       	jmp    80107a88 <alltraps>

801081e1 <vector26>:
.globl vector26
vector26:
  pushl $0
801081e1:	6a 00                	push   $0x0
  pushl $26
801081e3:	6a 1a                	push   $0x1a
  jmp alltraps
801081e5:	e9 9e f8 ff ff       	jmp    80107a88 <alltraps>

801081ea <vector27>:
.globl vector27
vector27:
  pushl $0
801081ea:	6a 00                	push   $0x0
  pushl $27
801081ec:	6a 1b                	push   $0x1b
  jmp alltraps
801081ee:	e9 95 f8 ff ff       	jmp    80107a88 <alltraps>

801081f3 <vector28>:
.globl vector28
vector28:
  pushl $0
801081f3:	6a 00                	push   $0x0
  pushl $28
801081f5:	6a 1c                	push   $0x1c
  jmp alltraps
801081f7:	e9 8c f8 ff ff       	jmp    80107a88 <alltraps>

801081fc <vector29>:
.globl vector29
vector29:
  pushl $0
801081fc:	6a 00                	push   $0x0
  pushl $29
801081fe:	6a 1d                	push   $0x1d
  jmp alltraps
80108200:	e9 83 f8 ff ff       	jmp    80107a88 <alltraps>

80108205 <vector30>:
.globl vector30
vector30:
  pushl $0
80108205:	6a 00                	push   $0x0
  pushl $30
80108207:	6a 1e                	push   $0x1e
  jmp alltraps
80108209:	e9 7a f8 ff ff       	jmp    80107a88 <alltraps>

8010820e <vector31>:
.globl vector31
vector31:
  pushl $0
8010820e:	6a 00                	push   $0x0
  pushl $31
80108210:	6a 1f                	push   $0x1f
  jmp alltraps
80108212:	e9 71 f8 ff ff       	jmp    80107a88 <alltraps>

80108217 <vector32>:
.globl vector32
vector32:
  pushl $0
80108217:	6a 00                	push   $0x0
  pushl $32
80108219:	6a 20                	push   $0x20
  jmp alltraps
8010821b:	e9 68 f8 ff ff       	jmp    80107a88 <alltraps>

80108220 <vector33>:
.globl vector33
vector33:
  pushl $0
80108220:	6a 00                	push   $0x0
  pushl $33
80108222:	6a 21                	push   $0x21
  jmp alltraps
80108224:	e9 5f f8 ff ff       	jmp    80107a88 <alltraps>

80108229 <vector34>:
.globl vector34
vector34:
  pushl $0
80108229:	6a 00                	push   $0x0
  pushl $34
8010822b:	6a 22                	push   $0x22
  jmp alltraps
8010822d:	e9 56 f8 ff ff       	jmp    80107a88 <alltraps>

80108232 <vector35>:
.globl vector35
vector35:
  pushl $0
80108232:	6a 00                	push   $0x0
  pushl $35
80108234:	6a 23                	push   $0x23
  jmp alltraps
80108236:	e9 4d f8 ff ff       	jmp    80107a88 <alltraps>

8010823b <vector36>:
.globl vector36
vector36:
  pushl $0
8010823b:	6a 00                	push   $0x0
  pushl $36
8010823d:	6a 24                	push   $0x24
  jmp alltraps
8010823f:	e9 44 f8 ff ff       	jmp    80107a88 <alltraps>

80108244 <vector37>:
.globl vector37
vector37:
  pushl $0
80108244:	6a 00                	push   $0x0
  pushl $37
80108246:	6a 25                	push   $0x25
  jmp alltraps
80108248:	e9 3b f8 ff ff       	jmp    80107a88 <alltraps>

8010824d <vector38>:
.globl vector38
vector38:
  pushl $0
8010824d:	6a 00                	push   $0x0
  pushl $38
8010824f:	6a 26                	push   $0x26
  jmp alltraps
80108251:	e9 32 f8 ff ff       	jmp    80107a88 <alltraps>

80108256 <vector39>:
.globl vector39
vector39:
  pushl $0
80108256:	6a 00                	push   $0x0
  pushl $39
80108258:	6a 27                	push   $0x27
  jmp alltraps
8010825a:	e9 29 f8 ff ff       	jmp    80107a88 <alltraps>

8010825f <vector40>:
.globl vector40
vector40:
  pushl $0
8010825f:	6a 00                	push   $0x0
  pushl $40
80108261:	6a 28                	push   $0x28
  jmp alltraps
80108263:	e9 20 f8 ff ff       	jmp    80107a88 <alltraps>

80108268 <vector41>:
.globl vector41
vector41:
  pushl $0
80108268:	6a 00                	push   $0x0
  pushl $41
8010826a:	6a 29                	push   $0x29
  jmp alltraps
8010826c:	e9 17 f8 ff ff       	jmp    80107a88 <alltraps>

80108271 <vector42>:
.globl vector42
vector42:
  pushl $0
80108271:	6a 00                	push   $0x0
  pushl $42
80108273:	6a 2a                	push   $0x2a
  jmp alltraps
80108275:	e9 0e f8 ff ff       	jmp    80107a88 <alltraps>

8010827a <vector43>:
.globl vector43
vector43:
  pushl $0
8010827a:	6a 00                	push   $0x0
  pushl $43
8010827c:	6a 2b                	push   $0x2b
  jmp alltraps
8010827e:	e9 05 f8 ff ff       	jmp    80107a88 <alltraps>

80108283 <vector44>:
.globl vector44
vector44:
  pushl $0
80108283:	6a 00                	push   $0x0
  pushl $44
80108285:	6a 2c                	push   $0x2c
  jmp alltraps
80108287:	e9 fc f7 ff ff       	jmp    80107a88 <alltraps>

8010828c <vector45>:
.globl vector45
vector45:
  pushl $0
8010828c:	6a 00                	push   $0x0
  pushl $45
8010828e:	6a 2d                	push   $0x2d
  jmp alltraps
80108290:	e9 f3 f7 ff ff       	jmp    80107a88 <alltraps>

80108295 <vector46>:
.globl vector46
vector46:
  pushl $0
80108295:	6a 00                	push   $0x0
  pushl $46
80108297:	6a 2e                	push   $0x2e
  jmp alltraps
80108299:	e9 ea f7 ff ff       	jmp    80107a88 <alltraps>

8010829e <vector47>:
.globl vector47
vector47:
  pushl $0
8010829e:	6a 00                	push   $0x0
  pushl $47
801082a0:	6a 2f                	push   $0x2f
  jmp alltraps
801082a2:	e9 e1 f7 ff ff       	jmp    80107a88 <alltraps>

801082a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801082a7:	6a 00                	push   $0x0
  pushl $48
801082a9:	6a 30                	push   $0x30
  jmp alltraps
801082ab:	e9 d8 f7 ff ff       	jmp    80107a88 <alltraps>

801082b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801082b0:	6a 00                	push   $0x0
  pushl $49
801082b2:	6a 31                	push   $0x31
  jmp alltraps
801082b4:	e9 cf f7 ff ff       	jmp    80107a88 <alltraps>

801082b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801082b9:	6a 00                	push   $0x0
  pushl $50
801082bb:	6a 32                	push   $0x32
  jmp alltraps
801082bd:	e9 c6 f7 ff ff       	jmp    80107a88 <alltraps>

801082c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801082c2:	6a 00                	push   $0x0
  pushl $51
801082c4:	6a 33                	push   $0x33
  jmp alltraps
801082c6:	e9 bd f7 ff ff       	jmp    80107a88 <alltraps>

801082cb <vector52>:
.globl vector52
vector52:
  pushl $0
801082cb:	6a 00                	push   $0x0
  pushl $52
801082cd:	6a 34                	push   $0x34
  jmp alltraps
801082cf:	e9 b4 f7 ff ff       	jmp    80107a88 <alltraps>

801082d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801082d4:	6a 00                	push   $0x0
  pushl $53
801082d6:	6a 35                	push   $0x35
  jmp alltraps
801082d8:	e9 ab f7 ff ff       	jmp    80107a88 <alltraps>

801082dd <vector54>:
.globl vector54
vector54:
  pushl $0
801082dd:	6a 00                	push   $0x0
  pushl $54
801082df:	6a 36                	push   $0x36
  jmp alltraps
801082e1:	e9 a2 f7 ff ff       	jmp    80107a88 <alltraps>

801082e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801082e6:	6a 00                	push   $0x0
  pushl $55
801082e8:	6a 37                	push   $0x37
  jmp alltraps
801082ea:	e9 99 f7 ff ff       	jmp    80107a88 <alltraps>

801082ef <vector56>:
.globl vector56
vector56:
  pushl $0
801082ef:	6a 00                	push   $0x0
  pushl $56
801082f1:	6a 38                	push   $0x38
  jmp alltraps
801082f3:	e9 90 f7 ff ff       	jmp    80107a88 <alltraps>

801082f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801082f8:	6a 00                	push   $0x0
  pushl $57
801082fa:	6a 39                	push   $0x39
  jmp alltraps
801082fc:	e9 87 f7 ff ff       	jmp    80107a88 <alltraps>

80108301 <vector58>:
.globl vector58
vector58:
  pushl $0
80108301:	6a 00                	push   $0x0
  pushl $58
80108303:	6a 3a                	push   $0x3a
  jmp alltraps
80108305:	e9 7e f7 ff ff       	jmp    80107a88 <alltraps>

8010830a <vector59>:
.globl vector59
vector59:
  pushl $0
8010830a:	6a 00                	push   $0x0
  pushl $59
8010830c:	6a 3b                	push   $0x3b
  jmp alltraps
8010830e:	e9 75 f7 ff ff       	jmp    80107a88 <alltraps>

80108313 <vector60>:
.globl vector60
vector60:
  pushl $0
80108313:	6a 00                	push   $0x0
  pushl $60
80108315:	6a 3c                	push   $0x3c
  jmp alltraps
80108317:	e9 6c f7 ff ff       	jmp    80107a88 <alltraps>

8010831c <vector61>:
.globl vector61
vector61:
  pushl $0
8010831c:	6a 00                	push   $0x0
  pushl $61
8010831e:	6a 3d                	push   $0x3d
  jmp alltraps
80108320:	e9 63 f7 ff ff       	jmp    80107a88 <alltraps>

80108325 <vector62>:
.globl vector62
vector62:
  pushl $0
80108325:	6a 00                	push   $0x0
  pushl $62
80108327:	6a 3e                	push   $0x3e
  jmp alltraps
80108329:	e9 5a f7 ff ff       	jmp    80107a88 <alltraps>

8010832e <vector63>:
.globl vector63
vector63:
  pushl $0
8010832e:	6a 00                	push   $0x0
  pushl $63
80108330:	6a 3f                	push   $0x3f
  jmp alltraps
80108332:	e9 51 f7 ff ff       	jmp    80107a88 <alltraps>

80108337 <vector64>:
.globl vector64
vector64:
  pushl $0
80108337:	6a 00                	push   $0x0
  pushl $64
80108339:	6a 40                	push   $0x40
  jmp alltraps
8010833b:	e9 48 f7 ff ff       	jmp    80107a88 <alltraps>

80108340 <vector65>:
.globl vector65
vector65:
  pushl $0
80108340:	6a 00                	push   $0x0
  pushl $65
80108342:	6a 41                	push   $0x41
  jmp alltraps
80108344:	e9 3f f7 ff ff       	jmp    80107a88 <alltraps>

80108349 <vector66>:
.globl vector66
vector66:
  pushl $0
80108349:	6a 00                	push   $0x0
  pushl $66
8010834b:	6a 42                	push   $0x42
  jmp alltraps
8010834d:	e9 36 f7 ff ff       	jmp    80107a88 <alltraps>

80108352 <vector67>:
.globl vector67
vector67:
  pushl $0
80108352:	6a 00                	push   $0x0
  pushl $67
80108354:	6a 43                	push   $0x43
  jmp alltraps
80108356:	e9 2d f7 ff ff       	jmp    80107a88 <alltraps>

8010835b <vector68>:
.globl vector68
vector68:
  pushl $0
8010835b:	6a 00                	push   $0x0
  pushl $68
8010835d:	6a 44                	push   $0x44
  jmp alltraps
8010835f:	e9 24 f7 ff ff       	jmp    80107a88 <alltraps>

80108364 <vector69>:
.globl vector69
vector69:
  pushl $0
80108364:	6a 00                	push   $0x0
  pushl $69
80108366:	6a 45                	push   $0x45
  jmp alltraps
80108368:	e9 1b f7 ff ff       	jmp    80107a88 <alltraps>

8010836d <vector70>:
.globl vector70
vector70:
  pushl $0
8010836d:	6a 00                	push   $0x0
  pushl $70
8010836f:	6a 46                	push   $0x46
  jmp alltraps
80108371:	e9 12 f7 ff ff       	jmp    80107a88 <alltraps>

80108376 <vector71>:
.globl vector71
vector71:
  pushl $0
80108376:	6a 00                	push   $0x0
  pushl $71
80108378:	6a 47                	push   $0x47
  jmp alltraps
8010837a:	e9 09 f7 ff ff       	jmp    80107a88 <alltraps>

8010837f <vector72>:
.globl vector72
vector72:
  pushl $0
8010837f:	6a 00                	push   $0x0
  pushl $72
80108381:	6a 48                	push   $0x48
  jmp alltraps
80108383:	e9 00 f7 ff ff       	jmp    80107a88 <alltraps>

80108388 <vector73>:
.globl vector73
vector73:
  pushl $0
80108388:	6a 00                	push   $0x0
  pushl $73
8010838a:	6a 49                	push   $0x49
  jmp alltraps
8010838c:	e9 f7 f6 ff ff       	jmp    80107a88 <alltraps>

80108391 <vector74>:
.globl vector74
vector74:
  pushl $0
80108391:	6a 00                	push   $0x0
  pushl $74
80108393:	6a 4a                	push   $0x4a
  jmp alltraps
80108395:	e9 ee f6 ff ff       	jmp    80107a88 <alltraps>

8010839a <vector75>:
.globl vector75
vector75:
  pushl $0
8010839a:	6a 00                	push   $0x0
  pushl $75
8010839c:	6a 4b                	push   $0x4b
  jmp alltraps
8010839e:	e9 e5 f6 ff ff       	jmp    80107a88 <alltraps>

801083a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801083a3:	6a 00                	push   $0x0
  pushl $76
801083a5:	6a 4c                	push   $0x4c
  jmp alltraps
801083a7:	e9 dc f6 ff ff       	jmp    80107a88 <alltraps>

801083ac <vector77>:
.globl vector77
vector77:
  pushl $0
801083ac:	6a 00                	push   $0x0
  pushl $77
801083ae:	6a 4d                	push   $0x4d
  jmp alltraps
801083b0:	e9 d3 f6 ff ff       	jmp    80107a88 <alltraps>

801083b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801083b5:	6a 00                	push   $0x0
  pushl $78
801083b7:	6a 4e                	push   $0x4e
  jmp alltraps
801083b9:	e9 ca f6 ff ff       	jmp    80107a88 <alltraps>

801083be <vector79>:
.globl vector79
vector79:
  pushl $0
801083be:	6a 00                	push   $0x0
  pushl $79
801083c0:	6a 4f                	push   $0x4f
  jmp alltraps
801083c2:	e9 c1 f6 ff ff       	jmp    80107a88 <alltraps>

801083c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801083c7:	6a 00                	push   $0x0
  pushl $80
801083c9:	6a 50                	push   $0x50
  jmp alltraps
801083cb:	e9 b8 f6 ff ff       	jmp    80107a88 <alltraps>

801083d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801083d0:	6a 00                	push   $0x0
  pushl $81
801083d2:	6a 51                	push   $0x51
  jmp alltraps
801083d4:	e9 af f6 ff ff       	jmp    80107a88 <alltraps>

801083d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801083d9:	6a 00                	push   $0x0
  pushl $82
801083db:	6a 52                	push   $0x52
  jmp alltraps
801083dd:	e9 a6 f6 ff ff       	jmp    80107a88 <alltraps>

801083e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801083e2:	6a 00                	push   $0x0
  pushl $83
801083e4:	6a 53                	push   $0x53
  jmp alltraps
801083e6:	e9 9d f6 ff ff       	jmp    80107a88 <alltraps>

801083eb <vector84>:
.globl vector84
vector84:
  pushl $0
801083eb:	6a 00                	push   $0x0
  pushl $84
801083ed:	6a 54                	push   $0x54
  jmp alltraps
801083ef:	e9 94 f6 ff ff       	jmp    80107a88 <alltraps>

801083f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801083f4:	6a 00                	push   $0x0
  pushl $85
801083f6:	6a 55                	push   $0x55
  jmp alltraps
801083f8:	e9 8b f6 ff ff       	jmp    80107a88 <alltraps>

801083fd <vector86>:
.globl vector86
vector86:
  pushl $0
801083fd:	6a 00                	push   $0x0
  pushl $86
801083ff:	6a 56                	push   $0x56
  jmp alltraps
80108401:	e9 82 f6 ff ff       	jmp    80107a88 <alltraps>

80108406 <vector87>:
.globl vector87
vector87:
  pushl $0
80108406:	6a 00                	push   $0x0
  pushl $87
80108408:	6a 57                	push   $0x57
  jmp alltraps
8010840a:	e9 79 f6 ff ff       	jmp    80107a88 <alltraps>

8010840f <vector88>:
.globl vector88
vector88:
  pushl $0
8010840f:	6a 00                	push   $0x0
  pushl $88
80108411:	6a 58                	push   $0x58
  jmp alltraps
80108413:	e9 70 f6 ff ff       	jmp    80107a88 <alltraps>

80108418 <vector89>:
.globl vector89
vector89:
  pushl $0
80108418:	6a 00                	push   $0x0
  pushl $89
8010841a:	6a 59                	push   $0x59
  jmp alltraps
8010841c:	e9 67 f6 ff ff       	jmp    80107a88 <alltraps>

80108421 <vector90>:
.globl vector90
vector90:
  pushl $0
80108421:	6a 00                	push   $0x0
  pushl $90
80108423:	6a 5a                	push   $0x5a
  jmp alltraps
80108425:	e9 5e f6 ff ff       	jmp    80107a88 <alltraps>

8010842a <vector91>:
.globl vector91
vector91:
  pushl $0
8010842a:	6a 00                	push   $0x0
  pushl $91
8010842c:	6a 5b                	push   $0x5b
  jmp alltraps
8010842e:	e9 55 f6 ff ff       	jmp    80107a88 <alltraps>

80108433 <vector92>:
.globl vector92
vector92:
  pushl $0
80108433:	6a 00                	push   $0x0
  pushl $92
80108435:	6a 5c                	push   $0x5c
  jmp alltraps
80108437:	e9 4c f6 ff ff       	jmp    80107a88 <alltraps>

8010843c <vector93>:
.globl vector93
vector93:
  pushl $0
8010843c:	6a 00                	push   $0x0
  pushl $93
8010843e:	6a 5d                	push   $0x5d
  jmp alltraps
80108440:	e9 43 f6 ff ff       	jmp    80107a88 <alltraps>

80108445 <vector94>:
.globl vector94
vector94:
  pushl $0
80108445:	6a 00                	push   $0x0
  pushl $94
80108447:	6a 5e                	push   $0x5e
  jmp alltraps
80108449:	e9 3a f6 ff ff       	jmp    80107a88 <alltraps>

8010844e <vector95>:
.globl vector95
vector95:
  pushl $0
8010844e:	6a 00                	push   $0x0
  pushl $95
80108450:	6a 5f                	push   $0x5f
  jmp alltraps
80108452:	e9 31 f6 ff ff       	jmp    80107a88 <alltraps>

80108457 <vector96>:
.globl vector96
vector96:
  pushl $0
80108457:	6a 00                	push   $0x0
  pushl $96
80108459:	6a 60                	push   $0x60
  jmp alltraps
8010845b:	e9 28 f6 ff ff       	jmp    80107a88 <alltraps>

80108460 <vector97>:
.globl vector97
vector97:
  pushl $0
80108460:	6a 00                	push   $0x0
  pushl $97
80108462:	6a 61                	push   $0x61
  jmp alltraps
80108464:	e9 1f f6 ff ff       	jmp    80107a88 <alltraps>

80108469 <vector98>:
.globl vector98
vector98:
  pushl $0
80108469:	6a 00                	push   $0x0
  pushl $98
8010846b:	6a 62                	push   $0x62
  jmp alltraps
8010846d:	e9 16 f6 ff ff       	jmp    80107a88 <alltraps>

80108472 <vector99>:
.globl vector99
vector99:
  pushl $0
80108472:	6a 00                	push   $0x0
  pushl $99
80108474:	6a 63                	push   $0x63
  jmp alltraps
80108476:	e9 0d f6 ff ff       	jmp    80107a88 <alltraps>

8010847b <vector100>:
.globl vector100
vector100:
  pushl $0
8010847b:	6a 00                	push   $0x0
  pushl $100
8010847d:	6a 64                	push   $0x64
  jmp alltraps
8010847f:	e9 04 f6 ff ff       	jmp    80107a88 <alltraps>

80108484 <vector101>:
.globl vector101
vector101:
  pushl $0
80108484:	6a 00                	push   $0x0
  pushl $101
80108486:	6a 65                	push   $0x65
  jmp alltraps
80108488:	e9 fb f5 ff ff       	jmp    80107a88 <alltraps>

8010848d <vector102>:
.globl vector102
vector102:
  pushl $0
8010848d:	6a 00                	push   $0x0
  pushl $102
8010848f:	6a 66                	push   $0x66
  jmp alltraps
80108491:	e9 f2 f5 ff ff       	jmp    80107a88 <alltraps>

80108496 <vector103>:
.globl vector103
vector103:
  pushl $0
80108496:	6a 00                	push   $0x0
  pushl $103
80108498:	6a 67                	push   $0x67
  jmp alltraps
8010849a:	e9 e9 f5 ff ff       	jmp    80107a88 <alltraps>

8010849f <vector104>:
.globl vector104
vector104:
  pushl $0
8010849f:	6a 00                	push   $0x0
  pushl $104
801084a1:	6a 68                	push   $0x68
  jmp alltraps
801084a3:	e9 e0 f5 ff ff       	jmp    80107a88 <alltraps>

801084a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801084a8:	6a 00                	push   $0x0
  pushl $105
801084aa:	6a 69                	push   $0x69
  jmp alltraps
801084ac:	e9 d7 f5 ff ff       	jmp    80107a88 <alltraps>

801084b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801084b1:	6a 00                	push   $0x0
  pushl $106
801084b3:	6a 6a                	push   $0x6a
  jmp alltraps
801084b5:	e9 ce f5 ff ff       	jmp    80107a88 <alltraps>

801084ba <vector107>:
.globl vector107
vector107:
  pushl $0
801084ba:	6a 00                	push   $0x0
  pushl $107
801084bc:	6a 6b                	push   $0x6b
  jmp alltraps
801084be:	e9 c5 f5 ff ff       	jmp    80107a88 <alltraps>

801084c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801084c3:	6a 00                	push   $0x0
  pushl $108
801084c5:	6a 6c                	push   $0x6c
  jmp alltraps
801084c7:	e9 bc f5 ff ff       	jmp    80107a88 <alltraps>

801084cc <vector109>:
.globl vector109
vector109:
  pushl $0
801084cc:	6a 00                	push   $0x0
  pushl $109
801084ce:	6a 6d                	push   $0x6d
  jmp alltraps
801084d0:	e9 b3 f5 ff ff       	jmp    80107a88 <alltraps>

801084d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801084d5:	6a 00                	push   $0x0
  pushl $110
801084d7:	6a 6e                	push   $0x6e
  jmp alltraps
801084d9:	e9 aa f5 ff ff       	jmp    80107a88 <alltraps>

801084de <vector111>:
.globl vector111
vector111:
  pushl $0
801084de:	6a 00                	push   $0x0
  pushl $111
801084e0:	6a 6f                	push   $0x6f
  jmp alltraps
801084e2:	e9 a1 f5 ff ff       	jmp    80107a88 <alltraps>

801084e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801084e7:	6a 00                	push   $0x0
  pushl $112
801084e9:	6a 70                	push   $0x70
  jmp alltraps
801084eb:	e9 98 f5 ff ff       	jmp    80107a88 <alltraps>

801084f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801084f0:	6a 00                	push   $0x0
  pushl $113
801084f2:	6a 71                	push   $0x71
  jmp alltraps
801084f4:	e9 8f f5 ff ff       	jmp    80107a88 <alltraps>

801084f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801084f9:	6a 00                	push   $0x0
  pushl $114
801084fb:	6a 72                	push   $0x72
  jmp alltraps
801084fd:	e9 86 f5 ff ff       	jmp    80107a88 <alltraps>

80108502 <vector115>:
.globl vector115
vector115:
  pushl $0
80108502:	6a 00                	push   $0x0
  pushl $115
80108504:	6a 73                	push   $0x73
  jmp alltraps
80108506:	e9 7d f5 ff ff       	jmp    80107a88 <alltraps>

8010850b <vector116>:
.globl vector116
vector116:
  pushl $0
8010850b:	6a 00                	push   $0x0
  pushl $116
8010850d:	6a 74                	push   $0x74
  jmp alltraps
8010850f:	e9 74 f5 ff ff       	jmp    80107a88 <alltraps>

80108514 <vector117>:
.globl vector117
vector117:
  pushl $0
80108514:	6a 00                	push   $0x0
  pushl $117
80108516:	6a 75                	push   $0x75
  jmp alltraps
80108518:	e9 6b f5 ff ff       	jmp    80107a88 <alltraps>

8010851d <vector118>:
.globl vector118
vector118:
  pushl $0
8010851d:	6a 00                	push   $0x0
  pushl $118
8010851f:	6a 76                	push   $0x76
  jmp alltraps
80108521:	e9 62 f5 ff ff       	jmp    80107a88 <alltraps>

80108526 <vector119>:
.globl vector119
vector119:
  pushl $0
80108526:	6a 00                	push   $0x0
  pushl $119
80108528:	6a 77                	push   $0x77
  jmp alltraps
8010852a:	e9 59 f5 ff ff       	jmp    80107a88 <alltraps>

8010852f <vector120>:
.globl vector120
vector120:
  pushl $0
8010852f:	6a 00                	push   $0x0
  pushl $120
80108531:	6a 78                	push   $0x78
  jmp alltraps
80108533:	e9 50 f5 ff ff       	jmp    80107a88 <alltraps>

80108538 <vector121>:
.globl vector121
vector121:
  pushl $0
80108538:	6a 00                	push   $0x0
  pushl $121
8010853a:	6a 79                	push   $0x79
  jmp alltraps
8010853c:	e9 47 f5 ff ff       	jmp    80107a88 <alltraps>

80108541 <vector122>:
.globl vector122
vector122:
  pushl $0
80108541:	6a 00                	push   $0x0
  pushl $122
80108543:	6a 7a                	push   $0x7a
  jmp alltraps
80108545:	e9 3e f5 ff ff       	jmp    80107a88 <alltraps>

8010854a <vector123>:
.globl vector123
vector123:
  pushl $0
8010854a:	6a 00                	push   $0x0
  pushl $123
8010854c:	6a 7b                	push   $0x7b
  jmp alltraps
8010854e:	e9 35 f5 ff ff       	jmp    80107a88 <alltraps>

80108553 <vector124>:
.globl vector124
vector124:
  pushl $0
80108553:	6a 00                	push   $0x0
  pushl $124
80108555:	6a 7c                	push   $0x7c
  jmp alltraps
80108557:	e9 2c f5 ff ff       	jmp    80107a88 <alltraps>

8010855c <vector125>:
.globl vector125
vector125:
  pushl $0
8010855c:	6a 00                	push   $0x0
  pushl $125
8010855e:	6a 7d                	push   $0x7d
  jmp alltraps
80108560:	e9 23 f5 ff ff       	jmp    80107a88 <alltraps>

80108565 <vector126>:
.globl vector126
vector126:
  pushl $0
80108565:	6a 00                	push   $0x0
  pushl $126
80108567:	6a 7e                	push   $0x7e
  jmp alltraps
80108569:	e9 1a f5 ff ff       	jmp    80107a88 <alltraps>

8010856e <vector127>:
.globl vector127
vector127:
  pushl $0
8010856e:	6a 00                	push   $0x0
  pushl $127
80108570:	6a 7f                	push   $0x7f
  jmp alltraps
80108572:	e9 11 f5 ff ff       	jmp    80107a88 <alltraps>

80108577 <vector128>:
.globl vector128
vector128:
  pushl $0
80108577:	6a 00                	push   $0x0
  pushl $128
80108579:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010857e:	e9 05 f5 ff ff       	jmp    80107a88 <alltraps>

80108583 <vector129>:
.globl vector129
vector129:
  pushl $0
80108583:	6a 00                	push   $0x0
  pushl $129
80108585:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010858a:	e9 f9 f4 ff ff       	jmp    80107a88 <alltraps>

8010858f <vector130>:
.globl vector130
vector130:
  pushl $0
8010858f:	6a 00                	push   $0x0
  pushl $130
80108591:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80108596:	e9 ed f4 ff ff       	jmp    80107a88 <alltraps>

8010859b <vector131>:
.globl vector131
vector131:
  pushl $0
8010859b:	6a 00                	push   $0x0
  pushl $131
8010859d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801085a2:	e9 e1 f4 ff ff       	jmp    80107a88 <alltraps>

801085a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801085a7:	6a 00                	push   $0x0
  pushl $132
801085a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801085ae:	e9 d5 f4 ff ff       	jmp    80107a88 <alltraps>

801085b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801085b3:	6a 00                	push   $0x0
  pushl $133
801085b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801085ba:	e9 c9 f4 ff ff       	jmp    80107a88 <alltraps>

801085bf <vector134>:
.globl vector134
vector134:
  pushl $0
801085bf:	6a 00                	push   $0x0
  pushl $134
801085c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801085c6:	e9 bd f4 ff ff       	jmp    80107a88 <alltraps>

801085cb <vector135>:
.globl vector135
vector135:
  pushl $0
801085cb:	6a 00                	push   $0x0
  pushl $135
801085cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801085d2:	e9 b1 f4 ff ff       	jmp    80107a88 <alltraps>

801085d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801085d7:	6a 00                	push   $0x0
  pushl $136
801085d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801085de:	e9 a5 f4 ff ff       	jmp    80107a88 <alltraps>

801085e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801085e3:	6a 00                	push   $0x0
  pushl $137
801085e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801085ea:	e9 99 f4 ff ff       	jmp    80107a88 <alltraps>

801085ef <vector138>:
.globl vector138
vector138:
  pushl $0
801085ef:	6a 00                	push   $0x0
  pushl $138
801085f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801085f6:	e9 8d f4 ff ff       	jmp    80107a88 <alltraps>

801085fb <vector139>:
.globl vector139
vector139:
  pushl $0
801085fb:	6a 00                	push   $0x0
  pushl $139
801085fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80108602:	e9 81 f4 ff ff       	jmp    80107a88 <alltraps>

80108607 <vector140>:
.globl vector140
vector140:
  pushl $0
80108607:	6a 00                	push   $0x0
  pushl $140
80108609:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010860e:	e9 75 f4 ff ff       	jmp    80107a88 <alltraps>

80108613 <vector141>:
.globl vector141
vector141:
  pushl $0
80108613:	6a 00                	push   $0x0
  pushl $141
80108615:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010861a:	e9 69 f4 ff ff       	jmp    80107a88 <alltraps>

8010861f <vector142>:
.globl vector142
vector142:
  pushl $0
8010861f:	6a 00                	push   $0x0
  pushl $142
80108621:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80108626:	e9 5d f4 ff ff       	jmp    80107a88 <alltraps>

8010862b <vector143>:
.globl vector143
vector143:
  pushl $0
8010862b:	6a 00                	push   $0x0
  pushl $143
8010862d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80108632:	e9 51 f4 ff ff       	jmp    80107a88 <alltraps>

80108637 <vector144>:
.globl vector144
vector144:
  pushl $0
80108637:	6a 00                	push   $0x0
  pushl $144
80108639:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010863e:	e9 45 f4 ff ff       	jmp    80107a88 <alltraps>

80108643 <vector145>:
.globl vector145
vector145:
  pushl $0
80108643:	6a 00                	push   $0x0
  pushl $145
80108645:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010864a:	e9 39 f4 ff ff       	jmp    80107a88 <alltraps>

8010864f <vector146>:
.globl vector146
vector146:
  pushl $0
8010864f:	6a 00                	push   $0x0
  pushl $146
80108651:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108656:	e9 2d f4 ff ff       	jmp    80107a88 <alltraps>

8010865b <vector147>:
.globl vector147
vector147:
  pushl $0
8010865b:	6a 00                	push   $0x0
  pushl $147
8010865d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108662:	e9 21 f4 ff ff       	jmp    80107a88 <alltraps>

80108667 <vector148>:
.globl vector148
vector148:
  pushl $0
80108667:	6a 00                	push   $0x0
  pushl $148
80108669:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010866e:	e9 15 f4 ff ff       	jmp    80107a88 <alltraps>

80108673 <vector149>:
.globl vector149
vector149:
  pushl $0
80108673:	6a 00                	push   $0x0
  pushl $149
80108675:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010867a:	e9 09 f4 ff ff       	jmp    80107a88 <alltraps>

8010867f <vector150>:
.globl vector150
vector150:
  pushl $0
8010867f:	6a 00                	push   $0x0
  pushl $150
80108681:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108686:	e9 fd f3 ff ff       	jmp    80107a88 <alltraps>

8010868b <vector151>:
.globl vector151
vector151:
  pushl $0
8010868b:	6a 00                	push   $0x0
  pushl $151
8010868d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108692:	e9 f1 f3 ff ff       	jmp    80107a88 <alltraps>

80108697 <vector152>:
.globl vector152
vector152:
  pushl $0
80108697:	6a 00                	push   $0x0
  pushl $152
80108699:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010869e:	e9 e5 f3 ff ff       	jmp    80107a88 <alltraps>

801086a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801086a3:	6a 00                	push   $0x0
  pushl $153
801086a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801086aa:	e9 d9 f3 ff ff       	jmp    80107a88 <alltraps>

801086af <vector154>:
.globl vector154
vector154:
  pushl $0
801086af:	6a 00                	push   $0x0
  pushl $154
801086b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801086b6:	e9 cd f3 ff ff       	jmp    80107a88 <alltraps>

801086bb <vector155>:
.globl vector155
vector155:
  pushl $0
801086bb:	6a 00                	push   $0x0
  pushl $155
801086bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801086c2:	e9 c1 f3 ff ff       	jmp    80107a88 <alltraps>

801086c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801086c7:	6a 00                	push   $0x0
  pushl $156
801086c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801086ce:	e9 b5 f3 ff ff       	jmp    80107a88 <alltraps>

801086d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801086d3:	6a 00                	push   $0x0
  pushl $157
801086d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801086da:	e9 a9 f3 ff ff       	jmp    80107a88 <alltraps>

801086df <vector158>:
.globl vector158
vector158:
  pushl $0
801086df:	6a 00                	push   $0x0
  pushl $158
801086e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801086e6:	e9 9d f3 ff ff       	jmp    80107a88 <alltraps>

801086eb <vector159>:
.globl vector159
vector159:
  pushl $0
801086eb:	6a 00                	push   $0x0
  pushl $159
801086ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801086f2:	e9 91 f3 ff ff       	jmp    80107a88 <alltraps>

801086f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801086f7:	6a 00                	push   $0x0
  pushl $160
801086f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801086fe:	e9 85 f3 ff ff       	jmp    80107a88 <alltraps>

80108703 <vector161>:
.globl vector161
vector161:
  pushl $0
80108703:	6a 00                	push   $0x0
  pushl $161
80108705:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010870a:	e9 79 f3 ff ff       	jmp    80107a88 <alltraps>

8010870f <vector162>:
.globl vector162
vector162:
  pushl $0
8010870f:	6a 00                	push   $0x0
  pushl $162
80108711:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80108716:	e9 6d f3 ff ff       	jmp    80107a88 <alltraps>

8010871b <vector163>:
.globl vector163
vector163:
  pushl $0
8010871b:	6a 00                	push   $0x0
  pushl $163
8010871d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80108722:	e9 61 f3 ff ff       	jmp    80107a88 <alltraps>

80108727 <vector164>:
.globl vector164
vector164:
  pushl $0
80108727:	6a 00                	push   $0x0
  pushl $164
80108729:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010872e:	e9 55 f3 ff ff       	jmp    80107a88 <alltraps>

80108733 <vector165>:
.globl vector165
vector165:
  pushl $0
80108733:	6a 00                	push   $0x0
  pushl $165
80108735:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010873a:	e9 49 f3 ff ff       	jmp    80107a88 <alltraps>

8010873f <vector166>:
.globl vector166
vector166:
  pushl $0
8010873f:	6a 00                	push   $0x0
  pushl $166
80108741:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80108746:	e9 3d f3 ff ff       	jmp    80107a88 <alltraps>

8010874b <vector167>:
.globl vector167
vector167:
  pushl $0
8010874b:	6a 00                	push   $0x0
  pushl $167
8010874d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108752:	e9 31 f3 ff ff       	jmp    80107a88 <alltraps>

80108757 <vector168>:
.globl vector168
vector168:
  pushl $0
80108757:	6a 00                	push   $0x0
  pushl $168
80108759:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010875e:	e9 25 f3 ff ff       	jmp    80107a88 <alltraps>

80108763 <vector169>:
.globl vector169
vector169:
  pushl $0
80108763:	6a 00                	push   $0x0
  pushl $169
80108765:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010876a:	e9 19 f3 ff ff       	jmp    80107a88 <alltraps>

8010876f <vector170>:
.globl vector170
vector170:
  pushl $0
8010876f:	6a 00                	push   $0x0
  pushl $170
80108771:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108776:	e9 0d f3 ff ff       	jmp    80107a88 <alltraps>

8010877b <vector171>:
.globl vector171
vector171:
  pushl $0
8010877b:	6a 00                	push   $0x0
  pushl $171
8010877d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108782:	e9 01 f3 ff ff       	jmp    80107a88 <alltraps>

80108787 <vector172>:
.globl vector172
vector172:
  pushl $0
80108787:	6a 00                	push   $0x0
  pushl $172
80108789:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010878e:	e9 f5 f2 ff ff       	jmp    80107a88 <alltraps>

80108793 <vector173>:
.globl vector173
vector173:
  pushl $0
80108793:	6a 00                	push   $0x0
  pushl $173
80108795:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010879a:	e9 e9 f2 ff ff       	jmp    80107a88 <alltraps>

8010879f <vector174>:
.globl vector174
vector174:
  pushl $0
8010879f:	6a 00                	push   $0x0
  pushl $174
801087a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801087a6:	e9 dd f2 ff ff       	jmp    80107a88 <alltraps>

801087ab <vector175>:
.globl vector175
vector175:
  pushl $0
801087ab:	6a 00                	push   $0x0
  pushl $175
801087ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801087b2:	e9 d1 f2 ff ff       	jmp    80107a88 <alltraps>

801087b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801087b7:	6a 00                	push   $0x0
  pushl $176
801087b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801087be:	e9 c5 f2 ff ff       	jmp    80107a88 <alltraps>

801087c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801087c3:	6a 00                	push   $0x0
  pushl $177
801087c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801087ca:	e9 b9 f2 ff ff       	jmp    80107a88 <alltraps>

801087cf <vector178>:
.globl vector178
vector178:
  pushl $0
801087cf:	6a 00                	push   $0x0
  pushl $178
801087d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801087d6:	e9 ad f2 ff ff       	jmp    80107a88 <alltraps>

801087db <vector179>:
.globl vector179
vector179:
  pushl $0
801087db:	6a 00                	push   $0x0
  pushl $179
801087dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801087e2:	e9 a1 f2 ff ff       	jmp    80107a88 <alltraps>

801087e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801087e7:	6a 00                	push   $0x0
  pushl $180
801087e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801087ee:	e9 95 f2 ff ff       	jmp    80107a88 <alltraps>

801087f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801087f3:	6a 00                	push   $0x0
  pushl $181
801087f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801087fa:	e9 89 f2 ff ff       	jmp    80107a88 <alltraps>

801087ff <vector182>:
.globl vector182
vector182:
  pushl $0
801087ff:	6a 00                	push   $0x0
  pushl $182
80108801:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80108806:	e9 7d f2 ff ff       	jmp    80107a88 <alltraps>

8010880b <vector183>:
.globl vector183
vector183:
  pushl $0
8010880b:	6a 00                	push   $0x0
  pushl $183
8010880d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80108812:	e9 71 f2 ff ff       	jmp    80107a88 <alltraps>

80108817 <vector184>:
.globl vector184
vector184:
  pushl $0
80108817:	6a 00                	push   $0x0
  pushl $184
80108819:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010881e:	e9 65 f2 ff ff       	jmp    80107a88 <alltraps>

80108823 <vector185>:
.globl vector185
vector185:
  pushl $0
80108823:	6a 00                	push   $0x0
  pushl $185
80108825:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010882a:	e9 59 f2 ff ff       	jmp    80107a88 <alltraps>

8010882f <vector186>:
.globl vector186
vector186:
  pushl $0
8010882f:	6a 00                	push   $0x0
  pushl $186
80108831:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80108836:	e9 4d f2 ff ff       	jmp    80107a88 <alltraps>

8010883b <vector187>:
.globl vector187
vector187:
  pushl $0
8010883b:	6a 00                	push   $0x0
  pushl $187
8010883d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108842:	e9 41 f2 ff ff       	jmp    80107a88 <alltraps>

80108847 <vector188>:
.globl vector188
vector188:
  pushl $0
80108847:	6a 00                	push   $0x0
  pushl $188
80108849:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010884e:	e9 35 f2 ff ff       	jmp    80107a88 <alltraps>

80108853 <vector189>:
.globl vector189
vector189:
  pushl $0
80108853:	6a 00                	push   $0x0
  pushl $189
80108855:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010885a:	e9 29 f2 ff ff       	jmp    80107a88 <alltraps>

8010885f <vector190>:
.globl vector190
vector190:
  pushl $0
8010885f:	6a 00                	push   $0x0
  pushl $190
80108861:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108866:	e9 1d f2 ff ff       	jmp    80107a88 <alltraps>

8010886b <vector191>:
.globl vector191
vector191:
  pushl $0
8010886b:	6a 00                	push   $0x0
  pushl $191
8010886d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108872:	e9 11 f2 ff ff       	jmp    80107a88 <alltraps>

80108877 <vector192>:
.globl vector192
vector192:
  pushl $0
80108877:	6a 00                	push   $0x0
  pushl $192
80108879:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010887e:	e9 05 f2 ff ff       	jmp    80107a88 <alltraps>

80108883 <vector193>:
.globl vector193
vector193:
  pushl $0
80108883:	6a 00                	push   $0x0
  pushl $193
80108885:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010888a:	e9 f9 f1 ff ff       	jmp    80107a88 <alltraps>

8010888f <vector194>:
.globl vector194
vector194:
  pushl $0
8010888f:	6a 00                	push   $0x0
  pushl $194
80108891:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108896:	e9 ed f1 ff ff       	jmp    80107a88 <alltraps>

8010889b <vector195>:
.globl vector195
vector195:
  pushl $0
8010889b:	6a 00                	push   $0x0
  pushl $195
8010889d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801088a2:	e9 e1 f1 ff ff       	jmp    80107a88 <alltraps>

801088a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801088a7:	6a 00                	push   $0x0
  pushl $196
801088a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801088ae:	e9 d5 f1 ff ff       	jmp    80107a88 <alltraps>

801088b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801088b3:	6a 00                	push   $0x0
  pushl $197
801088b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801088ba:	e9 c9 f1 ff ff       	jmp    80107a88 <alltraps>

801088bf <vector198>:
.globl vector198
vector198:
  pushl $0
801088bf:	6a 00                	push   $0x0
  pushl $198
801088c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801088c6:	e9 bd f1 ff ff       	jmp    80107a88 <alltraps>

801088cb <vector199>:
.globl vector199
vector199:
  pushl $0
801088cb:	6a 00                	push   $0x0
  pushl $199
801088cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801088d2:	e9 b1 f1 ff ff       	jmp    80107a88 <alltraps>

801088d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801088d7:	6a 00                	push   $0x0
  pushl $200
801088d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801088de:	e9 a5 f1 ff ff       	jmp    80107a88 <alltraps>

801088e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801088e3:	6a 00                	push   $0x0
  pushl $201
801088e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801088ea:	e9 99 f1 ff ff       	jmp    80107a88 <alltraps>

801088ef <vector202>:
.globl vector202
vector202:
  pushl $0
801088ef:	6a 00                	push   $0x0
  pushl $202
801088f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801088f6:	e9 8d f1 ff ff       	jmp    80107a88 <alltraps>

801088fb <vector203>:
.globl vector203
vector203:
  pushl $0
801088fb:	6a 00                	push   $0x0
  pushl $203
801088fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108902:	e9 81 f1 ff ff       	jmp    80107a88 <alltraps>

80108907 <vector204>:
.globl vector204
vector204:
  pushl $0
80108907:	6a 00                	push   $0x0
  pushl $204
80108909:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010890e:	e9 75 f1 ff ff       	jmp    80107a88 <alltraps>

80108913 <vector205>:
.globl vector205
vector205:
  pushl $0
80108913:	6a 00                	push   $0x0
  pushl $205
80108915:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010891a:	e9 69 f1 ff ff       	jmp    80107a88 <alltraps>

8010891f <vector206>:
.globl vector206
vector206:
  pushl $0
8010891f:	6a 00                	push   $0x0
  pushl $206
80108921:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108926:	e9 5d f1 ff ff       	jmp    80107a88 <alltraps>

8010892b <vector207>:
.globl vector207
vector207:
  pushl $0
8010892b:	6a 00                	push   $0x0
  pushl $207
8010892d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108932:	e9 51 f1 ff ff       	jmp    80107a88 <alltraps>

80108937 <vector208>:
.globl vector208
vector208:
  pushl $0
80108937:	6a 00                	push   $0x0
  pushl $208
80108939:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010893e:	e9 45 f1 ff ff       	jmp    80107a88 <alltraps>

80108943 <vector209>:
.globl vector209
vector209:
  pushl $0
80108943:	6a 00                	push   $0x0
  pushl $209
80108945:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010894a:	e9 39 f1 ff ff       	jmp    80107a88 <alltraps>

8010894f <vector210>:
.globl vector210
vector210:
  pushl $0
8010894f:	6a 00                	push   $0x0
  pushl $210
80108951:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108956:	e9 2d f1 ff ff       	jmp    80107a88 <alltraps>

8010895b <vector211>:
.globl vector211
vector211:
  pushl $0
8010895b:	6a 00                	push   $0x0
  pushl $211
8010895d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108962:	e9 21 f1 ff ff       	jmp    80107a88 <alltraps>

80108967 <vector212>:
.globl vector212
vector212:
  pushl $0
80108967:	6a 00                	push   $0x0
  pushl $212
80108969:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010896e:	e9 15 f1 ff ff       	jmp    80107a88 <alltraps>

80108973 <vector213>:
.globl vector213
vector213:
  pushl $0
80108973:	6a 00                	push   $0x0
  pushl $213
80108975:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010897a:	e9 09 f1 ff ff       	jmp    80107a88 <alltraps>

8010897f <vector214>:
.globl vector214
vector214:
  pushl $0
8010897f:	6a 00                	push   $0x0
  pushl $214
80108981:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108986:	e9 fd f0 ff ff       	jmp    80107a88 <alltraps>

8010898b <vector215>:
.globl vector215
vector215:
  pushl $0
8010898b:	6a 00                	push   $0x0
  pushl $215
8010898d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108992:	e9 f1 f0 ff ff       	jmp    80107a88 <alltraps>

80108997 <vector216>:
.globl vector216
vector216:
  pushl $0
80108997:	6a 00                	push   $0x0
  pushl $216
80108999:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010899e:	e9 e5 f0 ff ff       	jmp    80107a88 <alltraps>

801089a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801089a3:	6a 00                	push   $0x0
  pushl $217
801089a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801089aa:	e9 d9 f0 ff ff       	jmp    80107a88 <alltraps>

801089af <vector218>:
.globl vector218
vector218:
  pushl $0
801089af:	6a 00                	push   $0x0
  pushl $218
801089b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801089b6:	e9 cd f0 ff ff       	jmp    80107a88 <alltraps>

801089bb <vector219>:
.globl vector219
vector219:
  pushl $0
801089bb:	6a 00                	push   $0x0
  pushl $219
801089bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801089c2:	e9 c1 f0 ff ff       	jmp    80107a88 <alltraps>

801089c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801089c7:	6a 00                	push   $0x0
  pushl $220
801089c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801089ce:	e9 b5 f0 ff ff       	jmp    80107a88 <alltraps>

801089d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801089d3:	6a 00                	push   $0x0
  pushl $221
801089d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801089da:	e9 a9 f0 ff ff       	jmp    80107a88 <alltraps>

801089df <vector222>:
.globl vector222
vector222:
  pushl $0
801089df:	6a 00                	push   $0x0
  pushl $222
801089e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801089e6:	e9 9d f0 ff ff       	jmp    80107a88 <alltraps>

801089eb <vector223>:
.globl vector223
vector223:
  pushl $0
801089eb:	6a 00                	push   $0x0
  pushl $223
801089ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801089f2:	e9 91 f0 ff ff       	jmp    80107a88 <alltraps>

801089f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801089f7:	6a 00                	push   $0x0
  pushl $224
801089f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801089fe:	e9 85 f0 ff ff       	jmp    80107a88 <alltraps>

80108a03 <vector225>:
.globl vector225
vector225:
  pushl $0
80108a03:	6a 00                	push   $0x0
  pushl $225
80108a05:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80108a0a:	e9 79 f0 ff ff       	jmp    80107a88 <alltraps>

80108a0f <vector226>:
.globl vector226
vector226:
  pushl $0
80108a0f:	6a 00                	push   $0x0
  pushl $226
80108a11:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80108a16:	e9 6d f0 ff ff       	jmp    80107a88 <alltraps>

80108a1b <vector227>:
.globl vector227
vector227:
  pushl $0
80108a1b:	6a 00                	push   $0x0
  pushl $227
80108a1d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108a22:	e9 61 f0 ff ff       	jmp    80107a88 <alltraps>

80108a27 <vector228>:
.globl vector228
vector228:
  pushl $0
80108a27:	6a 00                	push   $0x0
  pushl $228
80108a29:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80108a2e:	e9 55 f0 ff ff       	jmp    80107a88 <alltraps>

80108a33 <vector229>:
.globl vector229
vector229:
  pushl $0
80108a33:	6a 00                	push   $0x0
  pushl $229
80108a35:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80108a3a:	e9 49 f0 ff ff       	jmp    80107a88 <alltraps>

80108a3f <vector230>:
.globl vector230
vector230:
  pushl $0
80108a3f:	6a 00                	push   $0x0
  pushl $230
80108a41:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108a46:	e9 3d f0 ff ff       	jmp    80107a88 <alltraps>

80108a4b <vector231>:
.globl vector231
vector231:
  pushl $0
80108a4b:	6a 00                	push   $0x0
  pushl $231
80108a4d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108a52:	e9 31 f0 ff ff       	jmp    80107a88 <alltraps>

80108a57 <vector232>:
.globl vector232
vector232:
  pushl $0
80108a57:	6a 00                	push   $0x0
  pushl $232
80108a59:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80108a5e:	e9 25 f0 ff ff       	jmp    80107a88 <alltraps>

80108a63 <vector233>:
.globl vector233
vector233:
  pushl $0
80108a63:	6a 00                	push   $0x0
  pushl $233
80108a65:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80108a6a:	e9 19 f0 ff ff       	jmp    80107a88 <alltraps>

80108a6f <vector234>:
.globl vector234
vector234:
  pushl $0
80108a6f:	6a 00                	push   $0x0
  pushl $234
80108a71:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108a76:	e9 0d f0 ff ff       	jmp    80107a88 <alltraps>

80108a7b <vector235>:
.globl vector235
vector235:
  pushl $0
80108a7b:	6a 00                	push   $0x0
  pushl $235
80108a7d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108a82:	e9 01 f0 ff ff       	jmp    80107a88 <alltraps>

80108a87 <vector236>:
.globl vector236
vector236:
  pushl $0
80108a87:	6a 00                	push   $0x0
  pushl $236
80108a89:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80108a8e:	e9 f5 ef ff ff       	jmp    80107a88 <alltraps>

80108a93 <vector237>:
.globl vector237
vector237:
  pushl $0
80108a93:	6a 00                	push   $0x0
  pushl $237
80108a95:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80108a9a:	e9 e9 ef ff ff       	jmp    80107a88 <alltraps>

80108a9f <vector238>:
.globl vector238
vector238:
  pushl $0
80108a9f:	6a 00                	push   $0x0
  pushl $238
80108aa1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108aa6:	e9 dd ef ff ff       	jmp    80107a88 <alltraps>

80108aab <vector239>:
.globl vector239
vector239:
  pushl $0
80108aab:	6a 00                	push   $0x0
  pushl $239
80108aad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108ab2:	e9 d1 ef ff ff       	jmp    80107a88 <alltraps>

80108ab7 <vector240>:
.globl vector240
vector240:
  pushl $0
80108ab7:	6a 00                	push   $0x0
  pushl $240
80108ab9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80108abe:	e9 c5 ef ff ff       	jmp    80107a88 <alltraps>

80108ac3 <vector241>:
.globl vector241
vector241:
  pushl $0
80108ac3:	6a 00                	push   $0x0
  pushl $241
80108ac5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80108aca:	e9 b9 ef ff ff       	jmp    80107a88 <alltraps>

80108acf <vector242>:
.globl vector242
vector242:
  pushl $0
80108acf:	6a 00                	push   $0x0
  pushl $242
80108ad1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80108ad6:	e9 ad ef ff ff       	jmp    80107a88 <alltraps>

80108adb <vector243>:
.globl vector243
vector243:
  pushl $0
80108adb:	6a 00                	push   $0x0
  pushl $243
80108add:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80108ae2:	e9 a1 ef ff ff       	jmp    80107a88 <alltraps>

80108ae7 <vector244>:
.globl vector244
vector244:
  pushl $0
80108ae7:	6a 00                	push   $0x0
  pushl $244
80108ae9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80108aee:	e9 95 ef ff ff       	jmp    80107a88 <alltraps>

80108af3 <vector245>:
.globl vector245
vector245:
  pushl $0
80108af3:	6a 00                	push   $0x0
  pushl $245
80108af5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80108afa:	e9 89 ef ff ff       	jmp    80107a88 <alltraps>

80108aff <vector246>:
.globl vector246
vector246:
  pushl $0
80108aff:	6a 00                	push   $0x0
  pushl $246
80108b01:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108b06:	e9 7d ef ff ff       	jmp    80107a88 <alltraps>

80108b0b <vector247>:
.globl vector247
vector247:
  pushl $0
80108b0b:	6a 00                	push   $0x0
  pushl $247
80108b0d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108b12:	e9 71 ef ff ff       	jmp    80107a88 <alltraps>

80108b17 <vector248>:
.globl vector248
vector248:
  pushl $0
80108b17:	6a 00                	push   $0x0
  pushl $248
80108b19:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80108b1e:	e9 65 ef ff ff       	jmp    80107a88 <alltraps>

80108b23 <vector249>:
.globl vector249
vector249:
  pushl $0
80108b23:	6a 00                	push   $0x0
  pushl $249
80108b25:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80108b2a:	e9 59 ef ff ff       	jmp    80107a88 <alltraps>

80108b2f <vector250>:
.globl vector250
vector250:
  pushl $0
80108b2f:	6a 00                	push   $0x0
  pushl $250
80108b31:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108b36:	e9 4d ef ff ff       	jmp    80107a88 <alltraps>

80108b3b <vector251>:
.globl vector251
vector251:
  pushl $0
80108b3b:	6a 00                	push   $0x0
  pushl $251
80108b3d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108b42:	e9 41 ef ff ff       	jmp    80107a88 <alltraps>

80108b47 <vector252>:
.globl vector252
vector252:
  pushl $0
80108b47:	6a 00                	push   $0x0
  pushl $252
80108b49:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80108b4e:	e9 35 ef ff ff       	jmp    80107a88 <alltraps>

80108b53 <vector253>:
.globl vector253
vector253:
  pushl $0
80108b53:	6a 00                	push   $0x0
  pushl $253
80108b55:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108b5a:	e9 29 ef ff ff       	jmp    80107a88 <alltraps>

80108b5f <vector254>:
.globl vector254
vector254:
  pushl $0
80108b5f:	6a 00                	push   $0x0
  pushl $254
80108b61:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108b66:	e9 1d ef ff ff       	jmp    80107a88 <alltraps>

80108b6b <vector255>:
.globl vector255
vector255:
  pushl $0
80108b6b:	6a 00                	push   $0x0
  pushl $255
80108b6d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108b72:	e9 11 ef ff ff       	jmp    80107a88 <alltraps>
80108b77:	66 90                	xchg   %ax,%ax
80108b79:	66 90                	xchg   %ax,%ax
80108b7b:	66 90                	xchg   %ax,%ax
80108b7d:	66 90                	xchg   %ax,%ax
80108b7f:	90                   	nop

80108b80 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108b80:	55                   	push   %ebp
80108b81:	89 e5                	mov    %esp,%ebp
80108b83:	57                   	push   %edi
80108b84:	56                   	push   %esi
80108b85:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80108b86:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80108b8c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108b92:	83 ec 1c             	sub    $0x1c,%esp
80108b95:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108b98:	39 d3                	cmp    %edx,%ebx
80108b9a:	73 49                	jae    80108be5 <deallocuvm.part.0+0x65>
80108b9c:	89 c7                	mov    %eax,%edi
80108b9e:	eb 0c                	jmp    80108bac <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80108ba0:	83 c0 01             	add    $0x1,%eax
80108ba3:	c1 e0 16             	shl    $0x16,%eax
80108ba6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108ba8:	39 da                	cmp    %ebx,%edx
80108baa:	76 39                	jbe    80108be5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80108bac:	89 d8                	mov    %ebx,%eax
80108bae:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108bb1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80108bb4:	f6 c1 01             	test   $0x1,%cl
80108bb7:	74 e7                	je     80108ba0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80108bb9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108bbb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108bc1:	c1 ee 0a             	shr    $0xa,%esi
80108bc4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80108bca:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80108bd1:	85 f6                	test   %esi,%esi
80108bd3:	74 cb                	je     80108ba0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80108bd5:	8b 06                	mov    (%esi),%eax
80108bd7:	a8 01                	test   $0x1,%al
80108bd9:	75 15                	jne    80108bf0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80108bdb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108be1:	39 da                	cmp    %ebx,%edx
80108be3:	77 c7                	ja     80108bac <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80108be5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108beb:	5b                   	pop    %ebx
80108bec:	5e                   	pop    %esi
80108bed:	5f                   	pop    %edi
80108bee:	5d                   	pop    %ebp
80108bef:	c3                   	ret    
      if(pa == 0)
80108bf0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108bf5:	74 25                	je     80108c1c <deallocuvm.part.0+0x9c>
      kfree(v);
80108bf7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80108bfa:	05 00 00 00 80       	add    $0x80000000,%eax
80108bff:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108c02:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80108c08:	50                   	push   %eax
80108c09:	e8 f2 a5 ff ff       	call   80103200 <kfree>
      *pte = 0;
80108c0e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80108c14:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108c17:	83 c4 10             	add    $0x10,%esp
80108c1a:	eb 8c                	jmp    80108ba8 <deallocuvm.part.0+0x28>
        panic("kfree");
80108c1c:	83 ec 0c             	sub    $0xc,%esp
80108c1f:	68 32 9c 10 80       	push   $0x80109c32
80108c24:	e8 c7 78 ff ff       	call   801004f0 <panic>
80108c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108c30 <seginit>:
{
80108c30:	55                   	push   %ebp
80108c31:	89 e5                	mov    %esp,%ebp
80108c33:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108c36:	e8 25 bb ff ff       	call   80104760 <cpuid>
  pd[0] = size-1;
80108c3b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108c40:	8d 04 40             	lea    (%eax,%eax,2),%eax
80108c43:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80108c47:	c1 e0 06             	shl    $0x6,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80108c4a:	c7 80 b8 4e 11 80 ff 	movl   $0xffff,-0x7feeb148(%eax)
80108c51:	ff 00 00 
80108c54:	c7 80 bc 4e 11 80 00 	movl   $0xcf9a00,-0x7feeb144(%eax)
80108c5b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108c5e:	c7 80 c0 4e 11 80 ff 	movl   $0xffff,-0x7feeb140(%eax)
80108c65:	ff 00 00 
80108c68:	c7 80 c4 4e 11 80 00 	movl   $0xcf9200,-0x7feeb13c(%eax)
80108c6f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108c72:	c7 80 c8 4e 11 80 ff 	movl   $0xffff,-0x7feeb138(%eax)
80108c79:	ff 00 00 
80108c7c:	c7 80 cc 4e 11 80 00 	movl   $0xcffa00,-0x7feeb134(%eax)
80108c83:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108c86:	c7 80 d0 4e 11 80 ff 	movl   $0xffff,-0x7feeb130(%eax)
80108c8d:	ff 00 00 
80108c90:	c7 80 d4 4e 11 80 00 	movl   $0xcff200,-0x7feeb12c(%eax)
80108c97:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80108c9a:	05 b0 4e 11 80       	add    $0x80114eb0,%eax
  pd[1] = (uint)p;
80108c9f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108ca3:	c1 e8 10             	shr    $0x10,%eax
80108ca6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108caa:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108cad:	0f 01 10             	lgdtl  (%eax)
}
80108cb0:	c9                   	leave  
80108cb1:	c3                   	ret    
80108cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108cc0 <walkpgdir>:
{
80108cc0:	55                   	push   %ebp
80108cc1:	89 e5                	mov    %esp,%ebp
80108cc3:	57                   	push   %edi
80108cc4:	56                   	push   %esi
80108cc5:	53                   	push   %ebx
80108cc6:	83 ec 0c             	sub    $0xc,%esp
80108cc9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pde = &pgdir[PDX(va)];
80108ccc:	8b 55 08             	mov    0x8(%ebp),%edx
80108ccf:	89 fe                	mov    %edi,%esi
80108cd1:	c1 ee 16             	shr    $0x16,%esi
80108cd4:	8d 34 b2             	lea    (%edx,%esi,4),%esi
  if(*pde & PTE_P){
80108cd7:	8b 1e                	mov    (%esi),%ebx
80108cd9:	f6 c3 01             	test   $0x1,%bl
80108cdc:	74 22                	je     80108d00 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108cde:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108ce4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
  return &pgtab[PTX(va)];
80108cea:	89 f8                	mov    %edi,%eax
}
80108cec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80108cef:	c1 e8 0a             	shr    $0xa,%eax
80108cf2:	25 fc 0f 00 00       	and    $0xffc,%eax
80108cf7:	01 d8                	add    %ebx,%eax
}
80108cf9:	5b                   	pop    %ebx
80108cfa:	5e                   	pop    %esi
80108cfb:	5f                   	pop    %edi
80108cfc:	5d                   	pop    %ebp
80108cfd:	c3                   	ret    
80108cfe:	66 90                	xchg   %ax,%ax
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108d00:	8b 45 10             	mov    0x10(%ebp),%eax
80108d03:	85 c0                	test   %eax,%eax
80108d05:	74 31                	je     80108d38 <walkpgdir+0x78>
80108d07:	e8 b4 a6 ff ff       	call   801033c0 <kalloc>
80108d0c:	89 c3                	mov    %eax,%ebx
80108d0e:	85 c0                	test   %eax,%eax
80108d10:	74 26                	je     80108d38 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80108d12:	83 ec 04             	sub    $0x4,%esp
80108d15:	68 00 10 00 00       	push   $0x1000
80108d1a:	6a 00                	push   $0x0
80108d1c:	50                   	push   %eax
80108d1d:	e8 9e d5 ff ff       	call   801062c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108d22:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108d28:	83 c4 10             	add    $0x10,%esp
80108d2b:	83 c8 07             	or     $0x7,%eax
80108d2e:	89 06                	mov    %eax,(%esi)
80108d30:	eb b8                	jmp    80108cea <walkpgdir+0x2a>
80108d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80108d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80108d3b:	31 c0                	xor    %eax,%eax
}
80108d3d:	5b                   	pop    %ebx
80108d3e:	5e                   	pop    %esi
80108d3f:	5f                   	pop    %edi
80108d40:	5d                   	pop    %ebp
80108d41:	c3                   	ret    
80108d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108d50 <mappages>:
{
80108d50:	55                   	push   %ebp
80108d51:	89 e5                	mov    %esp,%ebp
80108d53:	57                   	push   %edi
80108d54:	56                   	push   %esi
80108d55:	53                   	push   %ebx
80108d56:	83 ec 1c             	sub    $0x1c,%esp
80108d59:	8b 45 0c             	mov    0xc(%ebp),%eax
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108d5c:	8b 55 10             	mov    0x10(%ebp),%edx
  a = (char*)PGROUNDDOWN((uint)va);
80108d5f:	89 c3                	mov    %eax,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108d61:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
80108d65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80108d6a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108d70:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108d73:	8b 45 14             	mov    0x14(%ebp),%eax
80108d76:	29 d8                	sub    %ebx,%eax
80108d78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108d7b:	eb 3a                	jmp    80108db7 <mappages+0x67>
80108d7d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108d80:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108d82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108d87:	c1 ea 0a             	shr    $0xa,%edx
80108d8a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108d90:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108d97:	85 c0                	test   %eax,%eax
80108d99:	74 75                	je     80108e10 <mappages+0xc0>
    if(*pte & PTE_P)
80108d9b:	f6 00 01             	testb  $0x1,(%eax)
80108d9e:	0f 85 86 00 00 00    	jne    80108e2a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80108da4:	0b 75 18             	or     0x18(%ebp),%esi
80108da7:	83 ce 01             	or     $0x1,%esi
80108daa:	89 30                	mov    %esi,(%eax)
    if(a == last)
80108dac:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80108daf:	74 6f                	je     80108e20 <mappages+0xd0>
    a += PGSIZE;
80108db1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80108db7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80108dba:	8b 4d 08             	mov    0x8(%ebp),%ecx
80108dbd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80108dc0:	89 d8                	mov    %ebx,%eax
80108dc2:	c1 e8 16             	shr    $0x16,%eax
80108dc5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80108dc8:	8b 07                	mov    (%edi),%eax
80108dca:	a8 01                	test   $0x1,%al
80108dcc:	75 b2                	jne    80108d80 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108dce:	e8 ed a5 ff ff       	call   801033c0 <kalloc>
80108dd3:	85 c0                	test   %eax,%eax
80108dd5:	74 39                	je     80108e10 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80108dd7:	83 ec 04             	sub    $0x4,%esp
80108dda:	89 45 dc             	mov    %eax,-0x24(%ebp)
80108ddd:	68 00 10 00 00       	push   $0x1000
80108de2:	6a 00                	push   $0x0
80108de4:	50                   	push   %eax
80108de5:	e8 d6 d4 ff ff       	call   801062c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108dea:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80108ded:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108df0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80108df6:	83 c8 07             	or     $0x7,%eax
80108df9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80108dfb:	89 d8                	mov    %ebx,%eax
80108dfd:	c1 e8 0a             	shr    $0xa,%eax
80108e00:	25 fc 0f 00 00       	and    $0xffc,%eax
80108e05:	01 d0                	add    %edx,%eax
80108e07:	eb 92                	jmp    80108d9b <mappages+0x4b>
80108e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80108e10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108e13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108e18:	5b                   	pop    %ebx
80108e19:	5e                   	pop    %esi
80108e1a:	5f                   	pop    %edi
80108e1b:	5d                   	pop    %ebp
80108e1c:	c3                   	ret    
80108e1d:	8d 76 00             	lea    0x0(%esi),%esi
80108e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108e23:	31 c0                	xor    %eax,%eax
}
80108e25:	5b                   	pop    %ebx
80108e26:	5e                   	pop    %esi
80108e27:	5f                   	pop    %edi
80108e28:	5d                   	pop    %ebp
80108e29:	c3                   	ret    
      panic("remap");
80108e2a:	83 ec 0c             	sub    $0xc,%esp
80108e2d:	68 48 a5 10 80       	push   $0x8010a548
80108e32:	e8 b9 76 ff ff       	call   801004f0 <panic>
80108e37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108e3e:	66 90                	xchg   %ax,%ax

80108e40 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108e40:	a1 64 a2 11 80       	mov    0x8011a264,%eax
80108e45:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108e4a:	0f 22 d8             	mov    %eax,%cr3
}
80108e4d:	c3                   	ret    
80108e4e:	66 90                	xchg   %ax,%ax

80108e50 <switchuvm>:
{
80108e50:	55                   	push   %ebp
80108e51:	89 e5                	mov    %esp,%ebp
80108e53:	57                   	push   %edi
80108e54:	56                   	push   %esi
80108e55:	53                   	push   %ebx
80108e56:	83 ec 1c             	sub    $0x1c,%esp
80108e59:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80108e5c:	85 f6                	test   %esi,%esi
80108e5e:	0f 84 cb 00 00 00    	je     80108f2f <switchuvm+0xdf>
  if(p->kstack == 0)
80108e64:	8b 46 74             	mov    0x74(%esi),%eax
80108e67:	85 c0                	test   %eax,%eax
80108e69:	0f 84 da 00 00 00    	je     80108f49 <switchuvm+0xf9>
  if(p->pgdir == 0)
80108e6f:	8b 46 70             	mov    0x70(%esi),%eax
80108e72:	85 c0                	test   %eax,%eax
80108e74:	0f 84 c2 00 00 00    	je     80108f3c <switchuvm+0xec>
  pushcli();
80108e7a:	e8 31 d2 ff ff       	call   801060b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108e7f:	e8 7c b8 ff ff       	call   80104700 <mycpu>
80108e84:	89 c3                	mov    %eax,%ebx
80108e86:	e8 75 b8 ff ff       	call   80104700 <mycpu>
80108e8b:	89 c7                	mov    %eax,%edi
80108e8d:	e8 6e b8 ff ff       	call   80104700 <mycpu>
80108e92:	83 c7 08             	add    $0x8,%edi
80108e95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108e98:	e8 63 b8 ff ff       	call   80104700 <mycpu>
80108e9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108ea0:	ba 67 00 00 00       	mov    $0x67,%edx
80108ea5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80108eac:	83 c0 08             	add    $0x8,%eax
80108eaf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108eb6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108ebb:	83 c1 08             	add    $0x8,%ecx
80108ebe:	c1 e8 18             	shr    $0x18,%eax
80108ec1:	c1 e9 10             	shr    $0x10,%ecx
80108ec4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80108eca:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80108ed0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108ed5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108edc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80108ee1:	e8 1a b8 ff ff       	call   80104700 <mycpu>
80108ee6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108eed:	e8 0e b8 ff ff       	call   80104700 <mycpu>
80108ef2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108ef6:	8b 5e 74             	mov    0x74(%esi),%ebx
80108ef9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108eff:	e8 fc b7 ff ff       	call   80104700 <mycpu>
80108f04:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108f07:	e8 f4 b7 ff ff       	call   80104700 <mycpu>
80108f0c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108f10:	b8 28 00 00 00       	mov    $0x28,%eax
80108f15:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108f18:	8b 46 70             	mov    0x70(%esi),%eax
80108f1b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108f20:	0f 22 d8             	mov    %eax,%cr3
}
80108f23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108f26:	5b                   	pop    %ebx
80108f27:	5e                   	pop    %esi
80108f28:	5f                   	pop    %edi
80108f29:	5d                   	pop    %ebp
  popcli();
80108f2a:	e9 d1 d1 ff ff       	jmp    80106100 <popcli>
    panic("switchuvm: no process");
80108f2f:	83 ec 0c             	sub    $0xc,%esp
80108f32:	68 4e a5 10 80       	push   $0x8010a54e
80108f37:	e8 b4 75 ff ff       	call   801004f0 <panic>
    panic("switchuvm: no pgdir");
80108f3c:	83 ec 0c             	sub    $0xc,%esp
80108f3f:	68 79 a5 10 80       	push   $0x8010a579
80108f44:	e8 a7 75 ff ff       	call   801004f0 <panic>
    panic("switchuvm: no kstack");
80108f49:	83 ec 0c             	sub    $0xc,%esp
80108f4c:	68 64 a5 10 80       	push   $0x8010a564
80108f51:	e8 9a 75 ff ff       	call   801004f0 <panic>
80108f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108f5d:	8d 76 00             	lea    0x0(%esi),%esi

80108f60 <inituvm>:
{
80108f60:	55                   	push   %ebp
80108f61:	89 e5                	mov    %esp,%ebp
80108f63:	57                   	push   %edi
80108f64:	56                   	push   %esi
80108f65:	53                   	push   %ebx
80108f66:	83 ec 1c             	sub    $0x1c,%esp
80108f69:	8b 75 10             	mov    0x10(%ebp),%esi
80108f6c:	8b 55 08             	mov    0x8(%ebp),%edx
80108f6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80108f72:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108f78:	77 50                	ja     80108fca <inituvm+0x6a>
80108f7a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  mem = kalloc();
80108f7d:	e8 3e a4 ff ff       	call   801033c0 <kalloc>
  memset(mem, 0, PGSIZE);
80108f82:	83 ec 04             	sub    $0x4,%esp
80108f85:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80108f8a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108f8c:	6a 00                	push   $0x0
80108f8e:	50                   	push   %eax
80108f8f:	e8 2c d3 ff ff       	call   801062c0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108f94:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108f97:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108f9d:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80108fa4:	50                   	push   %eax
80108fa5:	68 00 10 00 00       	push   $0x1000
80108faa:	6a 00                	push   $0x0
80108fac:	52                   	push   %edx
80108fad:	e8 9e fd ff ff       	call   80108d50 <mappages>
  memmove(mem, init, sz);
80108fb2:	89 75 10             	mov    %esi,0x10(%ebp)
80108fb5:	83 c4 20             	add    $0x20,%esp
80108fb8:	89 7d 0c             	mov    %edi,0xc(%ebp)
80108fbb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108fbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108fc1:	5b                   	pop    %ebx
80108fc2:	5e                   	pop    %esi
80108fc3:	5f                   	pop    %edi
80108fc4:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108fc5:	e9 96 d3 ff ff       	jmp    80106360 <memmove>
    panic("inituvm: more than a page");
80108fca:	83 ec 0c             	sub    $0xc,%esp
80108fcd:	68 8d a5 10 80       	push   $0x8010a58d
80108fd2:	e8 19 75 ff ff       	call   801004f0 <panic>
80108fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108fde:	66 90                	xchg   %ax,%ax

80108fe0 <loaduvm>:
{
80108fe0:	55                   	push   %ebp
80108fe1:	89 e5                	mov    %esp,%ebp
80108fe3:	57                   	push   %edi
80108fe4:	56                   	push   %esi
80108fe5:	53                   	push   %ebx
80108fe6:	83 ec 1c             	sub    $0x1c,%esp
80108fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fec:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80108fef:	a9 ff 0f 00 00       	test   $0xfff,%eax
80108ff4:	0f 85 bb 00 00 00    	jne    801090b5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80108ffa:	01 f0                	add    %esi,%eax
80108ffc:	89 f3                	mov    %esi,%ebx
80108ffe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109001:	8b 45 14             	mov    0x14(%ebp),%eax
80109004:	01 f0                	add    %esi,%eax
80109006:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80109009:	85 f6                	test   %esi,%esi
8010900b:	0f 84 87 00 00 00    	je     80109098 <loaduvm+0xb8>
80109011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80109018:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010901b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010901e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80109020:	89 c2                	mov    %eax,%edx
80109022:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80109025:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80109028:	f6 c2 01             	test   $0x1,%dl
8010902b:	75 13                	jne    80109040 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010902d:	83 ec 0c             	sub    $0xc,%esp
80109030:	68 a7 a5 10 80       	push   $0x8010a5a7
80109035:	e8 b6 74 ff ff       	call   801004f0 <panic>
8010903a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80109040:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80109043:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80109049:	25 fc 0f 00 00       	and    $0xffc,%eax
8010904e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80109055:	85 c0                	test   %eax,%eax
80109057:	74 d4                	je     8010902d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80109059:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010905b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010905e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80109063:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80109068:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010906e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109071:	29 d9                	sub    %ebx,%ecx
80109073:	05 00 00 00 80       	add    $0x80000000,%eax
80109078:	57                   	push   %edi
80109079:	51                   	push   %ecx
8010907a:	50                   	push   %eax
8010907b:	ff 75 10             	push   0x10(%ebp)
8010907e:	e8 3d 97 ff ff       	call   801027c0 <readi>
80109083:	83 c4 10             	add    $0x10,%esp
80109086:	39 f8                	cmp    %edi,%eax
80109088:	75 1e                	jne    801090a8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010908a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80109090:	89 f0                	mov    %esi,%eax
80109092:	29 d8                	sub    %ebx,%eax
80109094:	39 c6                	cmp    %eax,%esi
80109096:	77 80                	ja     80109018 <loaduvm+0x38>
}
80109098:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010909b:	31 c0                	xor    %eax,%eax
}
8010909d:	5b                   	pop    %ebx
8010909e:	5e                   	pop    %esi
8010909f:	5f                   	pop    %edi
801090a0:	5d                   	pop    %ebp
801090a1:	c3                   	ret    
801090a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801090a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801090ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801090b0:	5b                   	pop    %ebx
801090b1:	5e                   	pop    %esi
801090b2:	5f                   	pop    %edi
801090b3:	5d                   	pop    %ebp
801090b4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801090b5:	83 ec 0c             	sub    $0xc,%esp
801090b8:	68 48 a6 10 80       	push   $0x8010a648
801090bd:	e8 2e 74 ff ff       	call   801004f0 <panic>
801090c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801090c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801090d0 <allocuvm>:
{
801090d0:	55                   	push   %ebp
801090d1:	89 e5                	mov    %esp,%ebp
801090d3:	57                   	push   %edi
801090d4:	56                   	push   %esi
801090d5:	53                   	push   %ebx
801090d6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801090d9:	8b 7d 10             	mov    0x10(%ebp),%edi
801090dc:	85 ff                	test   %edi,%edi
801090de:	0f 88 bc 00 00 00    	js     801091a0 <allocuvm+0xd0>
  if(newsz < oldsz)
801090e4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801090e7:	0f 82 a3 00 00 00    	jb     80109190 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801090ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801090f0:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801090f6:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801090fc:	39 75 10             	cmp    %esi,0x10(%ebp)
801090ff:	0f 86 8e 00 00 00    	jbe    80109193 <allocuvm+0xc3>
80109105:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80109108:	8b 7d 08             	mov    0x8(%ebp),%edi
8010910b:	eb 43                	jmp    80109150 <allocuvm+0x80>
8010910d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80109110:	83 ec 04             	sub    $0x4,%esp
80109113:	68 00 10 00 00       	push   $0x1000
80109118:	6a 00                	push   $0x0
8010911a:	50                   	push   %eax
8010911b:	e8 a0 d1 ff ff       	call   801062c0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80109120:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80109126:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
8010912d:	50                   	push   %eax
8010912e:	68 00 10 00 00       	push   $0x1000
80109133:	56                   	push   %esi
80109134:	57                   	push   %edi
80109135:	e8 16 fc ff ff       	call   80108d50 <mappages>
8010913a:	83 c4 20             	add    $0x20,%esp
8010913d:	85 c0                	test   %eax,%eax
8010913f:	78 6f                	js     801091b0 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
80109141:	81 c6 00 10 00 00    	add    $0x1000,%esi
80109147:	39 75 10             	cmp    %esi,0x10(%ebp)
8010914a:	0f 86 a0 00 00 00    	jbe    801091f0 <allocuvm+0x120>
    mem = kalloc();
80109150:	e8 6b a2 ff ff       	call   801033c0 <kalloc>
80109155:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80109157:	85 c0                	test   %eax,%eax
80109159:	75 b5                	jne    80109110 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010915b:	83 ec 0c             	sub    $0xc,%esp
8010915e:	68 c5 a5 10 80       	push   $0x8010a5c5
80109163:	e8 08 79 ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
80109168:	8b 45 0c             	mov    0xc(%ebp),%eax
8010916b:	83 c4 10             	add    $0x10,%esp
8010916e:	39 45 10             	cmp    %eax,0x10(%ebp)
80109171:	74 2d                	je     801091a0 <allocuvm+0xd0>
80109173:	8b 55 10             	mov    0x10(%ebp),%edx
80109176:	89 c1                	mov    %eax,%ecx
80109178:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
8010917b:	31 ff                	xor    %edi,%edi
8010917d:	e8 fe f9 ff ff       	call   80108b80 <deallocuvm.part.0>
}
80109182:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109185:	89 f8                	mov    %edi,%eax
80109187:	5b                   	pop    %ebx
80109188:	5e                   	pop    %esi
80109189:	5f                   	pop    %edi
8010918a:	5d                   	pop    %ebp
8010918b:	c3                   	ret    
8010918c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80109190:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80109193:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109196:	89 f8                	mov    %edi,%eax
80109198:	5b                   	pop    %ebx
80109199:	5e                   	pop    %esi
8010919a:	5f                   	pop    %edi
8010919b:	5d                   	pop    %ebp
8010919c:	c3                   	ret    
8010919d:	8d 76 00             	lea    0x0(%esi),%esi
801091a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801091a3:	31 ff                	xor    %edi,%edi
}
801091a5:	5b                   	pop    %ebx
801091a6:	89 f8                	mov    %edi,%eax
801091a8:	5e                   	pop    %esi
801091a9:	5f                   	pop    %edi
801091aa:	5d                   	pop    %ebp
801091ab:	c3                   	ret    
801091ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
801091b0:	83 ec 0c             	sub    $0xc,%esp
801091b3:	68 dd a5 10 80       	push   $0x8010a5dd
801091b8:	e8 b3 78 ff ff       	call   80100a70 <cprintf>
  if(newsz >= oldsz)
801091bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801091c0:	83 c4 10             	add    $0x10,%esp
801091c3:	39 45 10             	cmp    %eax,0x10(%ebp)
801091c6:	74 0d                	je     801091d5 <allocuvm+0x105>
801091c8:	89 c1                	mov    %eax,%ecx
801091ca:	8b 55 10             	mov    0x10(%ebp),%edx
801091cd:	8b 45 08             	mov    0x8(%ebp),%eax
801091d0:	e8 ab f9 ff ff       	call   80108b80 <deallocuvm.part.0>
      kfree(mem);
801091d5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801091d8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801091da:	53                   	push   %ebx
801091db:	e8 20 a0 ff ff       	call   80103200 <kfree>
      return 0;
801091e0:	83 c4 10             	add    $0x10,%esp
}
801091e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801091e6:	89 f8                	mov    %edi,%eax
801091e8:	5b                   	pop    %ebx
801091e9:	5e                   	pop    %esi
801091ea:	5f                   	pop    %edi
801091eb:	5d                   	pop    %ebp
801091ec:	c3                   	ret    
801091ed:	8d 76 00             	lea    0x0(%esi),%esi
801091f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801091f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801091f6:	5b                   	pop    %ebx
801091f7:	5e                   	pop    %esi
801091f8:	89 f8                	mov    %edi,%eax
801091fa:	5f                   	pop    %edi
801091fb:	5d                   	pop    %ebp
801091fc:	c3                   	ret    
801091fd:	8d 76 00             	lea    0x0(%esi),%esi

80109200 <deallocuvm>:
{
80109200:	55                   	push   %ebp
80109201:	89 e5                	mov    %esp,%ebp
80109203:	8b 55 0c             	mov    0xc(%ebp),%edx
80109206:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109209:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010920c:	39 d1                	cmp    %edx,%ecx
8010920e:	73 10                	jae    80109220 <deallocuvm+0x20>
}
80109210:	5d                   	pop    %ebp
80109211:	e9 6a f9 ff ff       	jmp    80108b80 <deallocuvm.part.0>
80109216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010921d:	8d 76 00             	lea    0x0(%esi),%esi
80109220:	89 d0                	mov    %edx,%eax
80109222:	5d                   	pop    %ebp
80109223:	c3                   	ret    
80109224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010922b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010922f:	90                   	nop

80109230 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80109230:	55                   	push   %ebp
80109231:	89 e5                	mov    %esp,%ebp
80109233:	57                   	push   %edi
80109234:	56                   	push   %esi
80109235:	53                   	push   %ebx
80109236:	83 ec 0c             	sub    $0xc,%esp
80109239:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010923c:	85 f6                	test   %esi,%esi
8010923e:	74 59                	je     80109299 <freevm+0x69>
  if(newsz >= oldsz)
80109240:	31 c9                	xor    %ecx,%ecx
80109242:	ba 00 00 00 80       	mov    $0x80000000,%edx
80109247:	89 f0                	mov    %esi,%eax
80109249:	89 f3                	mov    %esi,%ebx
8010924b:	e8 30 f9 ff ff       	call   80108b80 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80109250:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80109256:	eb 0f                	jmp    80109267 <freevm+0x37>
80109258:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010925f:	90                   	nop
80109260:	83 c3 04             	add    $0x4,%ebx
80109263:	39 df                	cmp    %ebx,%edi
80109265:	74 23                	je     8010928a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80109267:	8b 03                	mov    (%ebx),%eax
80109269:	a8 01                	test   $0x1,%al
8010926b:	74 f3                	je     80109260 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010926d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80109272:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80109275:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80109278:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010927d:	50                   	push   %eax
8010927e:	e8 7d 9f ff ff       	call   80103200 <kfree>
80109283:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80109286:	39 df                	cmp    %ebx,%edi
80109288:	75 dd                	jne    80109267 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010928a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010928d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109290:	5b                   	pop    %ebx
80109291:	5e                   	pop    %esi
80109292:	5f                   	pop    %edi
80109293:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80109294:	e9 67 9f ff ff       	jmp    80103200 <kfree>
    panic("freevm: no pgdir");
80109299:	83 ec 0c             	sub    $0xc,%esp
8010929c:	68 f9 a5 10 80       	push   $0x8010a5f9
801092a1:	e8 4a 72 ff ff       	call   801004f0 <panic>
801092a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801092ad:	8d 76 00             	lea    0x0(%esi),%esi

801092b0 <setupkvm>:
{
801092b0:	55                   	push   %ebp
801092b1:	89 e5                	mov    %esp,%ebp
801092b3:	56                   	push   %esi
801092b4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801092b5:	e8 06 a1 ff ff       	call   801033c0 <kalloc>
801092ba:	89 c6                	mov    %eax,%esi
801092bc:	85 c0                	test   %eax,%eax
801092be:	74 42                	je     80109302 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801092c0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801092c3:	bb 80 d4 10 80       	mov    $0x8010d480,%ebx
  memset(pgdir, 0, PGSIZE);
801092c8:	68 00 10 00 00       	push   $0x1000
801092cd:	6a 00                	push   $0x0
801092cf:	50                   	push   %eax
801092d0:	e8 eb cf ff ff       	call   801062c0 <memset>
801092d5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801092d8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801092db:	8b 53 08             	mov    0x8(%ebx),%edx
801092de:	83 ec 0c             	sub    $0xc,%esp
801092e1:	ff 73 0c             	push   0xc(%ebx)
801092e4:	29 c2                	sub    %eax,%edx
801092e6:	50                   	push   %eax
801092e7:	52                   	push   %edx
801092e8:	ff 33                	push   (%ebx)
801092ea:	56                   	push   %esi
801092eb:	e8 60 fa ff ff       	call   80108d50 <mappages>
801092f0:	83 c4 20             	add    $0x20,%esp
801092f3:	85 c0                	test   %eax,%eax
801092f5:	78 19                	js     80109310 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801092f7:	83 c3 10             	add    $0x10,%ebx
801092fa:	81 fb c0 d4 10 80    	cmp    $0x8010d4c0,%ebx
80109300:	75 d6                	jne    801092d8 <setupkvm+0x28>
}
80109302:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109305:	89 f0                	mov    %esi,%eax
80109307:	5b                   	pop    %ebx
80109308:	5e                   	pop    %esi
80109309:	5d                   	pop    %ebp
8010930a:	c3                   	ret    
8010930b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010930f:	90                   	nop
      freevm(pgdir);
80109310:	83 ec 0c             	sub    $0xc,%esp
80109313:	56                   	push   %esi
      return 0;
80109314:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80109316:	e8 15 ff ff ff       	call   80109230 <freevm>
      return 0;
8010931b:	83 c4 10             	add    $0x10,%esp
}
8010931e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109321:	89 f0                	mov    %esi,%eax
80109323:	5b                   	pop    %ebx
80109324:	5e                   	pop    %esi
80109325:	5d                   	pop    %ebp
80109326:	c3                   	ret    
80109327:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010932e:	66 90                	xchg   %ax,%ax

80109330 <kvmalloc>:
{
80109330:	55                   	push   %ebp
80109331:	89 e5                	mov    %esp,%ebp
80109333:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80109336:	e8 75 ff ff ff       	call   801092b0 <setupkvm>
8010933b:	a3 64 a2 11 80       	mov    %eax,0x8011a264
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80109340:	05 00 00 00 80       	add    $0x80000000,%eax
80109345:	0f 22 d8             	mov    %eax,%cr3
}
80109348:	c9                   	leave  
80109349:	c3                   	ret    
8010934a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80109350 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80109350:	55                   	push   %ebp
80109351:	89 e5                	mov    %esp,%ebp
80109353:	83 ec 08             	sub    $0x8,%esp
80109356:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80109359:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010935c:	89 c1                	mov    %eax,%ecx
8010935e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80109361:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80109364:	f6 c2 01             	test   $0x1,%dl
80109367:	75 17                	jne    80109380 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80109369:	83 ec 0c             	sub    $0xc,%esp
8010936c:	68 0a a6 10 80       	push   $0x8010a60a
80109371:	e8 7a 71 ff ff       	call   801004f0 <panic>
80109376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010937d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80109380:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80109383:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80109389:	25 fc 0f 00 00       	and    $0xffc,%eax
8010938e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80109395:	85 c0                	test   %eax,%eax
80109397:	74 d0                	je     80109369 <clearpteu+0x19>
  *pte &= ~PTE_U;
80109399:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010939c:	c9                   	leave  
8010939d:	c3                   	ret    
8010939e:	66 90                	xchg   %ax,%ax

801093a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801093a0:	55                   	push   %ebp
801093a1:	89 e5                	mov    %esp,%ebp
801093a3:	57                   	push   %edi
801093a4:	56                   	push   %esi
801093a5:	53                   	push   %ebx
801093a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801093a9:	e8 02 ff ff ff       	call   801092b0 <setupkvm>
801093ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
801093b1:	85 c0                	test   %eax,%eax
801093b3:	0f 84 c0 00 00 00    	je     80109479 <copyuvm+0xd9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801093b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801093bc:	85 d2                	test   %edx,%edx
801093be:	0f 84 b5 00 00 00    	je     80109479 <copyuvm+0xd9>
801093c4:	31 f6                	xor    %esi,%esi
801093c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801093cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
801093d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801093d3:	89 f0                	mov    %esi,%eax
801093d5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801093d8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801093db:	a8 01                	test   $0x1,%al
801093dd:	75 11                	jne    801093f0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801093df:	83 ec 0c             	sub    $0xc,%esp
801093e2:	68 14 a6 10 80       	push   $0x8010a614
801093e7:	e8 04 71 ff ff       	call   801004f0 <panic>
801093ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801093f0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801093f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801093f7:	c1 ea 0a             	shr    $0xa,%edx
801093fa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80109400:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80109407:	85 c0                	test   %eax,%eax
80109409:	74 d4                	je     801093df <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010940b:	8b 38                	mov    (%eax),%edi
8010940d:	f7 c7 01 00 00 00    	test   $0x1,%edi
80109413:	0f 84 9b 00 00 00    	je     801094b4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80109419:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
8010941b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80109421:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80109424:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    if((mem = kalloc()) == 0)
8010942a:	e8 91 9f ff ff       	call   801033c0 <kalloc>
8010942f:	89 c7                	mov    %eax,%edi
80109431:	85 c0                	test   %eax,%eax
80109433:	74 5f                	je     80109494 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80109435:	83 ec 04             	sub    $0x4,%esp
80109438:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
8010943e:	68 00 10 00 00       	push   $0x1000
80109443:	53                   	push   %ebx
80109444:	50                   	push   %eax
80109445:	e8 16 cf ff ff       	call   80106360 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010944a:	58                   	pop    %eax
8010944b:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
80109451:	ff 75 e4             	push   -0x1c(%ebp)
80109454:	50                   	push   %eax
80109455:	68 00 10 00 00       	push   $0x1000
8010945a:	56                   	push   %esi
8010945b:	ff 75 e0             	push   -0x20(%ebp)
8010945e:	e8 ed f8 ff ff       	call   80108d50 <mappages>
80109463:	83 c4 20             	add    $0x20,%esp
80109466:	85 c0                	test   %eax,%eax
80109468:	78 1e                	js     80109488 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
8010946a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80109470:	39 75 0c             	cmp    %esi,0xc(%ebp)
80109473:	0f 87 57 ff ff ff    	ja     801093d0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80109479:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010947c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010947f:	5b                   	pop    %ebx
80109480:	5e                   	pop    %esi
80109481:	5f                   	pop    %edi
80109482:	5d                   	pop    %ebp
80109483:	c3                   	ret    
80109484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80109488:	83 ec 0c             	sub    $0xc,%esp
8010948b:	57                   	push   %edi
8010948c:	e8 6f 9d ff ff       	call   80103200 <kfree>
      goto bad;
80109491:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80109494:	83 ec 0c             	sub    $0xc,%esp
80109497:	ff 75 e0             	push   -0x20(%ebp)
8010949a:	e8 91 fd ff ff       	call   80109230 <freevm>
  return 0;
8010949f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801094a6:	83 c4 10             	add    $0x10,%esp
}
801094a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801094ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801094af:	5b                   	pop    %ebx
801094b0:	5e                   	pop    %esi
801094b1:	5f                   	pop    %edi
801094b2:	5d                   	pop    %ebp
801094b3:	c3                   	ret    
      panic("copyuvm: page not present");
801094b4:	83 ec 0c             	sub    $0xc,%esp
801094b7:	68 2e a6 10 80       	push   $0x8010a62e
801094bc:	e8 2f 70 ff ff       	call   801004f0 <panic>
801094c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801094c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801094cf:	90                   	nop

801094d0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801094d0:	55                   	push   %ebp
801094d1:	89 e5                	mov    %esp,%ebp
801094d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801094d6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801094d9:	89 c1                	mov    %eax,%ecx
801094db:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801094de:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801094e1:	f6 c2 01             	test   $0x1,%dl
801094e4:	0f 84 00 01 00 00    	je     801095ea <uva2ka.cold>
  return &pgtab[PTX(va)];
801094ea:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801094ed:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801094f3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801094f4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801094f9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80109500:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80109502:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80109507:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010950a:	05 00 00 00 80       	add    $0x80000000,%eax
8010950f:	83 fa 05             	cmp    $0x5,%edx
80109512:	ba 00 00 00 00       	mov    $0x0,%edx
80109517:	0f 45 c2             	cmovne %edx,%eax
}
8010951a:	c3                   	ret    
8010951b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010951f:	90                   	nop

80109520 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80109520:	55                   	push   %ebp
80109521:	89 e5                	mov    %esp,%ebp
80109523:	57                   	push   %edi
80109524:	56                   	push   %esi
80109525:	53                   	push   %ebx
80109526:	83 ec 0c             	sub    $0xc,%esp
80109529:	8b 75 14             	mov    0x14(%ebp),%esi
8010952c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010952f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80109532:	85 f6                	test   %esi,%esi
80109534:	75 51                	jne    80109587 <copyout+0x67>
80109536:	e9 a5 00 00 00       	jmp    801095e0 <copyout+0xc0>
8010953b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010953f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80109540:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80109546:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010954c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80109552:	74 75                	je     801095c9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80109554:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80109556:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80109559:	29 c3                	sub    %eax,%ebx
8010955b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80109561:	39 f3                	cmp    %esi,%ebx
80109563:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80109566:	29 f8                	sub    %edi,%eax
80109568:	83 ec 04             	sub    $0x4,%esp
8010956b:	01 c1                	add    %eax,%ecx
8010956d:	53                   	push   %ebx
8010956e:	52                   	push   %edx
8010956f:	51                   	push   %ecx
80109570:	e8 eb cd ff ff       	call   80106360 <memmove>
    len -= n;
    buf += n;
80109575:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80109578:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010957e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80109581:	01 da                	add    %ebx,%edx
  while(len > 0){
80109583:	29 de                	sub    %ebx,%esi
80109585:	74 59                	je     801095e0 <copyout+0xc0>
  if(*pde & PTE_P){
80109587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010958a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010958c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010958e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80109591:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80109597:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010959a:	f6 c1 01             	test   $0x1,%cl
8010959d:	0f 84 4e 00 00 00    	je     801095f1 <copyout.cold>
  return &pgtab[PTX(va)];
801095a3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801095a5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801095ab:	c1 eb 0c             	shr    $0xc,%ebx
801095ae:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801095b4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801095bb:	89 d9                	mov    %ebx,%ecx
801095bd:	83 e1 05             	and    $0x5,%ecx
801095c0:	83 f9 05             	cmp    $0x5,%ecx
801095c3:	0f 84 77 ff ff ff    	je     80109540 <copyout+0x20>
  }
  return 0;
}
801095c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801095cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801095d1:	5b                   	pop    %ebx
801095d2:	5e                   	pop    %esi
801095d3:	5f                   	pop    %edi
801095d4:	5d                   	pop    %ebp
801095d5:	c3                   	ret    
801095d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801095dd:	8d 76 00             	lea    0x0(%esi),%esi
801095e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801095e3:	31 c0                	xor    %eax,%eax
}
801095e5:	5b                   	pop    %ebx
801095e6:	5e                   	pop    %esi
801095e7:	5f                   	pop    %edi
801095e8:	5d                   	pop    %ebp
801095e9:	c3                   	ret    

801095ea <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801095ea:	a1 00 00 00 00       	mov    0x0,%eax
801095ef:	0f 0b                	ud2    

801095f1 <copyout.cold>:
801095f1:	a1 00 00 00 00       	mov    0x0,%eax
801095f6:	0f 0b                	ud2    
801095f8:	66 90                	xchg   %ax,%ax
801095fa:	66 90                	xchg   %ax,%ax
801095fc:	66 90                	xchg   %ax,%ax
801095fe:	66 90                	xchg   %ax,%ax

80109600 <init_sharedmem>:
    struct shared_page table[NUM_OF_SHARED_PAGES];
    struct spinlock lock;
} shared_memory;

void
init_sharedmem(){
80109600:	55                   	push   %ebp
80109601:	89 e5                	mov    %esp,%ebp
80109603:	83 ec 14             	sub    $0x14,%esp
    acquire(&shared_memory.lock);
80109606:	68 e0 a2 11 80       	push   $0x8011a2e0
8010960b:	e8 f0 cb ff ff       	call   80106200 <acquire>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
        shared_memory.table[i].num_of_refs = 0;
    }
    release(&shared_memory.lock);
80109610:	c7 04 24 e0 a2 11 80 	movl   $0x8011a2e0,(%esp)
        shared_memory.table[i].num_of_refs = 0;
80109617:	c7 05 84 a2 11 80 00 	movl   $0x0,0x8011a284
8010961e:	00 00 00 
80109621:	c7 05 90 a2 11 80 00 	movl   $0x0,0x8011a290
80109628:	00 00 00 
8010962b:	c7 05 9c a2 11 80 00 	movl   $0x0,0x8011a29c
80109632:	00 00 00 
80109635:	c7 05 a8 a2 11 80 00 	movl   $0x0,0x8011a2a8
8010963c:	00 00 00 
8010963f:	c7 05 b4 a2 11 80 00 	movl   $0x0,0x8011a2b4
80109646:	00 00 00 
80109649:	c7 05 c0 a2 11 80 00 	movl   $0x0,0x8011a2c0
80109650:	00 00 00 
80109653:	c7 05 cc a2 11 80 00 	movl   $0x0,0x8011a2cc
8010965a:	00 00 00 
8010965d:	c7 05 d8 a2 11 80 00 	movl   $0x0,0x8011a2d8
80109664:	00 00 00 
    release(&shared_memory.lock);
80109667:	e8 34 cb ff ff       	call   801061a0 <release>
}
8010966c:	83 c4 10             	add    $0x10,%esp
8010966f:	c9                   	leave  
80109670:	c3                   	ret    
80109671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010967f:	90                   	nop

80109680 <find_shared_page>:

int
find_shared_page(int id){
80109680:	55                   	push   %ebp
80109681:	ba 80 a2 11 80       	mov    $0x8011a280,%edx
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109686:	31 c0                	xor    %eax,%eax
find_shared_page(int id){
80109688:	89 e5                	mov    %esp,%ebp
8010968a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010968d:	8d 76 00             	lea    0x0(%esi),%esi
        if (shared_memory.table[i].id == id){
80109690:	39 0a                	cmp    %ecx,(%edx)
80109692:	74 31                	je     801096c5 <find_shared_page+0x45>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109694:	83 c0 01             	add    $0x1,%eax
80109697:	83 c2 0c             	add    $0xc,%edx
8010969a:	83 f8 08             	cmp    $0x8,%eax
8010969d:	75 f1                	jne    80109690 <find_shared_page+0x10>
8010969f:	ba 84 a2 11 80       	mov    $0x8011a284,%edx
            return i;
        }
    }
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
801096a4:	31 c0                	xor    %eax,%eax
801096a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801096ad:	8d 76 00             	lea    0x0(%esi),%esi
        if (shared_memory.table[i].num_of_refs == 0){
801096b0:	83 3a 00             	cmpl   $0x0,(%edx)
801096b3:	74 1b                	je     801096d0 <find_shared_page+0x50>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
801096b5:	83 c0 01             	add    $0x1,%eax
801096b8:	83 c2 0c             	add    $0xc,%edx
801096bb:	83 f8 08             	cmp    $0x8,%eax
801096be:	75 f0                	jne    801096b0 <find_shared_page+0x30>
            shared_memory.table[i].id = id;
            return i;
        }
    }
    return -1;
801096c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801096c5:	5d                   	pop    %ebp
801096c6:	c3                   	ret    
801096c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801096ce:	66 90                	xchg   %ax,%ax
            shared_memory.table[i].id = id;
801096d0:	8d 14 40             	lea    (%eax,%eax,2),%edx
}
801096d3:	5d                   	pop    %ebp
            shared_memory.table[i].id = id;
801096d4:	89 0c 95 80 a2 11 80 	mov    %ecx,-0x7fee5d80(,%edx,4)
}
801096db:	c3                   	ret    
801096dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801096e0 <open_sharedmem>:

char*
open_sharedmem(int id){
801096e0:	55                   	push   %ebp
801096e1:	89 e5                	mov    %esp,%ebp
801096e3:	57                   	push   %edi
801096e4:	56                   	push   %esi
801096e5:	53                   	push   %ebx
801096e6:	83 ec 1c             	sub    $0x1c,%esp
801096e9:	8b 7d 08             	mov    0x8(%ebp),%edi
    struct proc* proc = myproc();
801096ec:	e8 8f b0 ff ff       	call   80104780 <myproc>
    pde_t *pgdir = proc->pgdir;
    if (proc->shmem != 0){
801096f1:	8b 98 0c 01 00 00    	mov    0x10c(%eax),%ebx
801096f7:	85 db                	test   %ebx,%ebx
801096f9:	75 75                	jne    80109770 <open_sharedmem+0x90>
        return 0;
    }
    acquire(&shared_memory.lock);
801096fb:	83 ec 0c             	sub    $0xc,%esp
801096fe:	89 c6                	mov    %eax,%esi
    pde_t *pgdir = proc->pgdir;
80109700:	8b 40 70             	mov    0x70(%eax),%eax
    acquire(&shared_memory.lock);
80109703:	68 e0 a2 11 80       	push   $0x8011a2e0
    pde_t *pgdir = proc->pgdir;
80109708:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    acquire(&shared_memory.lock);
8010970b:	e8 f0 ca ff ff       	call   80106200 <acquire>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109710:	b8 80 a2 11 80       	mov    $0x8011a280,%eax
80109715:	83 c4 10             	add    $0x10,%esp
80109718:	31 d2                	xor    %edx,%edx
8010971a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (shared_memory.table[i].id == id){
80109720:	3b 38                	cmp    (%eax),%edi
80109722:	74 5c                	je     80109780 <open_sharedmem+0xa0>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109724:	83 c2 01             	add    $0x1,%edx
80109727:	83 c0 0c             	add    $0xc,%eax
8010972a:	83 fa 08             	cmp    $0x8,%edx
8010972d:	75 f1                	jne    80109720 <open_sharedmem+0x40>
8010972f:	b8 84 a2 11 80       	mov    $0x8011a284,%eax
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109734:	31 d2                	xor    %edx,%edx
80109736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010973d:	8d 76 00             	lea    0x0(%esi),%esi
        if (shared_memory.table[i].num_of_refs == 0){
80109740:	8b 08                	mov    (%eax),%ecx
80109742:	85 c9                	test   %ecx,%ecx
80109744:	0f 84 c6 00 00 00    	je     80109810 <open_sharedmem+0x130>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
8010974a:	83 c2 01             	add    $0x1,%edx
8010974d:	83 c0 0c             	add    $0xc,%eax
80109750:	83 fa 08             	cmp    $0x8,%edx
80109753:	75 eb                	jne    80109740 <open_sharedmem+0x60>
    int index = find_shared_page(id);
    if (index == -1){
        release(&shared_memory.lock);
80109755:	83 ec 0c             	sub    $0xc,%esp
80109758:	68 e0 a2 11 80       	push   $0x8011a2e0
8010975d:	e8 3e ca ff ff       	call   801061a0 <release>
        return 0;
80109762:	83 c4 10             	add    $0x10,%esp
80109765:	eb 0b                	jmp    80109772 <open_sharedmem+0x92>
80109767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010976e:	66 90                	xchg   %ax,%ax
        return 0;
80109770:	31 db                	xor    %ebx,%ebx
    proc->shmem = start_mem;
    proc->shmem_id = id;

    release(&shared_memory.lock);
    return start_mem;
}
80109772:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109775:	89 d8                	mov    %ebx,%eax
80109777:	5b                   	pop    %ebx
80109778:	5e                   	pop    %esi
80109779:	5f                   	pop    %edi
8010977a:	5d                   	pop    %ebp
8010977b:	c3                   	ret    
8010977c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (shared_memory.table[index].num_of_refs == 0){
80109780:	8d 04 52             	lea    (%edx,%edx,2),%eax
80109783:	8b 04 85 84 a2 11 80 	mov    -0x7fee5d7c(,%eax,4),%eax
8010978a:	85 c0                	test   %eax,%eax
8010978c:	0f 84 88 00 00 00    	je     8010981a <open_sharedmem+0x13a>
    char* start_mem = (char*)PGROUNDUP(proc->sz);
80109792:	8b 46 6c             	mov    0x6c(%esi),%eax
    mappages(pgdir, start_mem, PGSIZE, V2P(shared_memory.table[index].frame), PTE_W|PTE_U);
80109795:	8d 14 52             	lea    (%edx,%edx,2),%edx
80109798:	83 ec 0c             	sub    $0xc,%esp
8010979b:	c1 e2 02             	shl    $0x2,%edx
8010979e:	6a 06                	push   $0x6
    char* start_mem = (char*)PGROUNDUP(proc->sz);
801097a0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
    mappages(pgdir, start_mem, PGSIZE, V2P(shared_memory.table[index].frame), PTE_W|PTE_U);
801097a6:	8b 82 88 a2 11 80    	mov    -0x7fee5d78(%edx),%eax
801097ac:	8d 8a 80 a2 11 80    	lea    -0x7fee5d80(%edx),%ecx
801097b2:	89 55 dc             	mov    %edx,-0x24(%ebp)
    char* start_mem = (char*)PGROUNDUP(proc->sz);
801097b5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    mappages(pgdir, start_mem, PGSIZE, V2P(shared_memory.table[index].frame), PTE_W|PTE_U);
801097bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801097be:	05 00 00 00 80       	add    $0x80000000,%eax
801097c3:	50                   	push   %eax
801097c4:	68 00 10 00 00       	push   $0x1000
801097c9:	53                   	push   %ebx
801097ca:	ff 75 e4             	push   -0x1c(%ebp)
801097cd:	e8 7e f5 ff ff       	call   80108d50 <mappages>
    shared_memory.table[index].num_of_refs++;
801097d2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    release(&shared_memory.lock);
801097d5:	83 c4 14             	add    $0x14,%esp
    shared_memory.table[index].id = id;
801097d8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    proc->shmem = start_mem;
801097db:	89 9e 0c 01 00 00    	mov    %ebx,0x10c(%esi)
    shared_memory.table[index].num_of_refs++;
801097e1:	83 41 04 01          	addl   $0x1,0x4(%ecx)
    proc->shmem_id = id;
801097e5:	89 be 10 01 00 00    	mov    %edi,0x110(%esi)
    release(&shared_memory.lock);
801097eb:	68 e0 a2 11 80       	push   $0x8011a2e0
    shared_memory.table[index].id = id;
801097f0:	89 ba 80 a2 11 80    	mov    %edi,-0x7fee5d80(%edx)
    release(&shared_memory.lock);
801097f6:	e8 a5 c9 ff ff       	call   801061a0 <release>
    return start_mem;
801097fb:	83 c4 10             	add    $0x10,%esp
}
801097fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109801:	89 d8                	mov    %ebx,%eax
80109803:	5b                   	pop    %ebx
80109804:	5e                   	pop    %esi
80109805:	5f                   	pop    %edi
80109806:	5d                   	pop    %ebp
80109807:	c3                   	ret    
80109808:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010980f:	90                   	nop
            shared_memory.table[i].id = id;
80109810:	8d 04 52             	lea    (%edx,%edx,2),%eax
80109813:	89 3c 85 80 a2 11 80 	mov    %edi,-0x7fee5d80(,%eax,4)
    if (shared_memory.table[index].num_of_refs == 0){
8010981a:	89 55 e0             	mov    %edx,-0x20(%ebp)
        shared_memory.table[index].frame = kalloc();
8010981d:	e8 9e 9b ff ff       	call   801033c0 <kalloc>
        memset(shared_memory.table[index].frame, 0, PGSIZE);
80109822:	83 ec 04             	sub    $0x4,%esp
        shared_memory.table[index].frame = kalloc();
80109825:	8b 55 e0             	mov    -0x20(%ebp),%edx
        memset(shared_memory.table[index].frame, 0, PGSIZE);
80109828:	68 00 10 00 00       	push   $0x1000
8010982d:	6a 00                	push   $0x0
        shared_memory.table[index].frame = kalloc();
8010982f:	8d 0c 52             	lea    (%edx,%edx,2),%ecx
        memset(shared_memory.table[index].frame, 0, PGSIZE);
80109832:	50                   	push   %eax
        shared_memory.table[index].frame = kalloc();
80109833:	89 04 8d 88 a2 11 80 	mov    %eax,-0x7fee5d78(,%ecx,4)
        memset(shared_memory.table[index].frame, 0, PGSIZE);
8010983a:	e8 81 ca ff ff       	call   801062c0 <memset>
8010983f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109842:	83 c4 10             	add    $0x10,%esp
80109845:	e9 48 ff ff ff       	jmp    80109792 <open_sharedmem+0xb2>
8010984a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80109850 <close_sharedmem>:

void
close_sharedmem(int id){
80109850:	55                   	push   %ebp
80109851:	89 e5                	mov    %esp,%ebp
80109853:	57                   	push   %edi
80109854:	56                   	push   %esi
80109855:	53                   	push   %ebx
80109856:	83 ec 1c             	sub    $0x1c,%esp
80109859:	8b 7d 08             	mov    0x8(%ebp),%edi
    struct proc* proc = myproc();
8010985c:	e8 1f af ff ff       	call   80104780 <myproc>
80109861:	89 c6                	mov    %eax,%esi
    pde_t *pgdir = proc->pgdir;
    if (proc->shmem_id != id || proc->shmem_id == 0){
80109863:	8b 80 10 01 00 00    	mov    0x110(%eax),%eax
80109869:	85 c0                	test   %eax,%eax
8010986b:	74 04                	je     80109871 <close_sharedmem+0x21>
8010986d:	39 f8                	cmp    %edi,%eax
8010986f:	74 0f                	je     80109880 <close_sharedmem+0x30>
        kfree(shared_memory.table[index].frame);
        
    }

    release(&shared_memory.lock);
80109871:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109874:	5b                   	pop    %ebx
80109875:	5e                   	pop    %esi
80109876:	5f                   	pop    %edi
80109877:	5d                   	pop    %ebp
80109878:	c3                   	ret    
80109879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&shared_memory.lock);
80109880:	83 ec 0c             	sub    $0xc,%esp
    pde_t *pgdir = proc->pgdir;
80109883:	8b 56 70             	mov    0x70(%esi),%edx
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109886:	31 db                	xor    %ebx,%ebx
    acquire(&shared_memory.lock);
80109888:	68 e0 a2 11 80       	push   $0x8011a2e0
    pde_t *pgdir = proc->pgdir;
8010988d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    acquire(&shared_memory.lock);
80109890:	e8 6b c9 ff ff       	call   80106200 <acquire>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
80109895:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109898:	b8 80 a2 11 80       	mov    $0x8011a280,%eax
8010989d:	83 c4 10             	add    $0x10,%esp
        if (shared_memory.table[i].id == id){
801098a0:	3b 38                	cmp    (%eax),%edi
801098a2:	74 36                	je     801098da <close_sharedmem+0x8a>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
801098a4:	83 c3 01             	add    $0x1,%ebx
801098a7:	83 c0 0c             	add    $0xc,%eax
801098aa:	83 fb 08             	cmp    $0x8,%ebx
801098ad:	75 f1                	jne    801098a0 <close_sharedmem+0x50>
801098af:	b8 84 a2 11 80       	mov    $0x8011a284,%eax
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
801098b4:	31 db                	xor    %ebx,%ebx
801098b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801098bd:	8d 76 00             	lea    0x0(%esi),%esi
        if (shared_memory.table[i].num_of_refs == 0){
801098c0:	8b 08                	mov    (%eax),%ecx
801098c2:	85 c9                	test   %ecx,%ecx
801098c4:	0f 84 96 00 00 00    	je     80109960 <close_sharedmem+0x110>
    for (int i = 0; i < NUM_OF_SHARED_PAGES; i++){
801098ca:	83 c3 01             	add    $0x1,%ebx
801098cd:	83 c0 0c             	add    $0xc,%eax
801098d0:	83 fb 08             	cmp    $0x8,%ebx
801098d3:	75 eb                	jne    801098c0 <close_sharedmem+0x70>
    return -1;
801098d5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
801098da:	83 ec 04             	sub    $0x4,%esp
    shared_memory.table[index].num_of_refs--;
801098dd:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
    pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
801098e0:	6a 00                	push   $0x0
    shared_memory.table[index].num_of_refs--;
801098e2:	83 2c 85 84 a2 11 80 	subl   $0x1,-0x7fee5d7c(,%eax,4)
801098e9:	01 
    uint a = PGROUNDUP((uint)proc->shmem);
801098ea:	8b 86 0c 01 00 00    	mov    0x10c(%esi),%eax
801098f0:	05 ff 0f 00 00       	add    $0xfff,%eax
801098f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
801098fa:	50                   	push   %eax
801098fb:	52                   	push   %edx
801098fc:	e8 bf f3 ff ff       	call   80108cc0 <walkpgdir>
    if(!pte)
80109901:	83 c4 10             	add    $0x10,%esp
80109904:	85 c0                	test   %eax,%eax
80109906:	74 0b                	je     80109913 <close_sharedmem+0xc3>
    else if((*pte & PTE_P) != 0){
80109908:	f6 00 01             	testb  $0x1,(%eax)
8010990b:	74 06                	je     80109913 <close_sharedmem+0xc3>
        *pte = 0;
8010990d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    proc->shmem = 0;
80109913:	c7 86 0c 01 00 00 00 	movl   $0x0,0x10c(%esi)
8010991a:	00 00 00 
    if (shared_memory.table[index].num_of_refs == 0){
8010991d:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
80109920:	8d 04 85 80 a2 11 80 	lea    -0x7fee5d80(,%eax,4),%eax
    proc->shmem_id = 0;
80109927:	c7 86 10 01 00 00 00 	movl   $0x0,0x110(%esi)
8010992e:	00 00 00 
    if (shared_memory.table[index].num_of_refs == 0){
80109931:	8b 50 04             	mov    0x4(%eax),%edx
80109934:	85 d2                	test   %edx,%edx
80109936:	74 18                	je     80109950 <close_sharedmem+0x100>
    release(&shared_memory.lock);
80109938:	c7 45 08 e0 a2 11 80 	movl   $0x8011a2e0,0x8(%ebp)
8010993f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109942:	5b                   	pop    %ebx
80109943:	5e                   	pop    %esi
80109944:	5f                   	pop    %edi
80109945:	5d                   	pop    %ebp
    release(&shared_memory.lock);
80109946:	e9 55 c8 ff ff       	jmp    801061a0 <release>
8010994b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010994f:	90                   	nop
        kfree(shared_memory.table[index].frame);
80109950:	83 ec 0c             	sub    $0xc,%esp
80109953:	ff 70 08             	push   0x8(%eax)
80109956:	e8 a5 98 ff ff       	call   80103200 <kfree>
8010995b:	83 c4 10             	add    $0x10,%esp
8010995e:	eb d8                	jmp    80109938 <close_sharedmem+0xe8>
            shared_memory.table[i].id = id;
80109960:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
80109963:	89 3c 85 80 a2 11 80 	mov    %edi,-0x7fee5d80(,%eax,4)
            return i;
8010996a:	e9 6b ff ff ff       	jmp    801098da <close_sharedmem+0x8a>
