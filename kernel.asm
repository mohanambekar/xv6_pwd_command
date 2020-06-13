
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
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
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 73 10 80       	push   $0x80107360
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 c5 43 00 00       	call   80104420 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 73 10 80       	push   $0x80107367
80100097:	50                   	push   %eax
80100098:	e8 53 42 00 00       	call   801042f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 77 44 00 00       	call   80104560 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
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
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 b9 44 00 00       	call   80104620 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 41 00 00       	call   80104330 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 1f 00 00       	call   80102120 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 73 10 80       	push   $0x8010736e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 1d 42 00 00       	call   801043d0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 73 10 80       	push   $0x8010737f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 dc 41 00 00       	call   801043d0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 41 00 00       	call   80104390 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 50 43 00 00       	call   80104560 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 bf 43 00 00       	jmp    80104620 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 73 10 80       	push   $0x80107386
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 42 00 00       	call   80104560 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002a7:	39 15 c4 ff 10 80    	cmp    %edx,0x8010ffc4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 c0 ff 10 80       	push   $0x8010ffc0
801002c5:	e8 b6 3b 00 00       	call   80103e80 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 ff 10 80    	cmp    0x8010ffc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 e0 35 00 00       	call   801038c0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 2c 43 00 00       	call   80104620 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 84 13 00 00       	call   80101680 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ce 42 00 00       	call   80104620 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 26 13 00 00       	call   80101680 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 62 24 00 00       	call   80102810 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 73 10 80       	push   $0x8010738d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 ed 75 10 80 	movl   $0x801075ed,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 40 00 00       	call   80104440 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 73 10 80       	push   $0x801073a1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 21 5b 00 00       	call   80105f60 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 6f 5a 00 00       	call   80105f60 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 5a 00 00       	call   80105f60 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 5a 00 00       	call   80105f60 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 f7 41 00 00       	call   80104720 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 2a 41 00 00       	call   80104670 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 73 10 80       	push   $0x801073a5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 d0 73 10 80 	movzbl -0x7fef8c30(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 4c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3f 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 d4 3f 00 00       	call   80104620 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 2b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 fc 3e 00 00       	call   80104620 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba b8 73 10 80       	mov    $0x801073b8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 6b 3d 00 00       	call   80104560 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 73 10 80       	push   $0x801073bf
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 38 3d 00 00       	call   80104560 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100856:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 93 3d 00 00       	call   80104620 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
80100911:	68 c0 ff 10 80       	push   $0x8010ffc0
80100916:	e8 15 37 00 00       	call   80104030 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010093d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100964:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 74 37 00 00       	jmp    80104110 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 c8 73 10 80       	push   $0x801073c8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 4b 3a 00 00       	call   80104420 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 d2 18 00 00       	call   801022d0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 9f 2e 00 00       	call   801038c0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 54 22 00 00       	call   80102c80 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 a9 14 00 00       	call   80101ee0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 33 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 02 0f 00 00       	call   80101960 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 a1 0e 00 00       	call   80101910 <iunlockput>
    end_op();
80100a6f:	e8 7c 22 00 00       	call   80102cf0 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 17 66 00 00       	call   801070b0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 93 02 00 00    	je     80100d52 <exec+0x342>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 d5 63 00 00       	call   80106ed0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 e3 62 00 00       	call   80106e10 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 03 0e 00 00       	call   80101960 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 b9 64 00 00       	call   80107030 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 76 0d 00 00       	call   80101910 <iunlockput>
  end_op();
80100b9a:	e8 51 21 00 00       	call   80102cf0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 21 63 00 00       	call   80106ed0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 6a 64 00 00       	call   80107030 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 18 21 00 00       	call   80102cf0 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 e1 73 10 80       	push   $0x801073e1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 45 65 00 00       	call   80107150 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 52 3c 00 00       	call   80104890 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 3f 3c 00 00       	call   80104890 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 4e 66 00 00       	call   801072b0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 e4 65 00 00       	call   801072b0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 41 3b 00 00       	call   80104850 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 10;
80100d31:	c7 41 7c 0a 00 00 00 	movl   $0xa,0x7c(%ecx)
  switchuvm(curproc);
80100d38:	89 0c 24             	mov    %ecx,(%esp)
80100d3b:	e8 40 5f 00 00       	call   80106c80 <switchuvm>
  freevm(oldpgdir);
80100d40:	89 3c 24             	mov    %edi,(%esp)
80100d43:	e8 e8 62 00 00       	call   80107030 <freevm>
  return 0;
80100d48:	83 c4 10             	add    $0x10,%esp
80100d4b:	31 c0                	xor    %eax,%eax
80100d4d:	e9 2a fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d52:	be 00 20 00 00       	mov    $0x2000,%esi
80100d57:	e9 35 fe ff ff       	jmp    80100b91 <exec+0x181>
80100d5c:	66 90                	xchg   %ax,%ax
80100d5e:	66 90                	xchg   %ax,%ax

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 ed 73 10 80       	push   $0x801073ed
80100d6b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d70:	e8 ab 36 00 00       	call   80104420 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d91:	e8 ca 37 00 00       	call   80104560 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dc1:	e8 5a 38 00 00       	call   80104620 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dda:	e8 41 38 00 00       	call   80104620 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dff:	e8 5c 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e1c:	e8 ff 37 00 00       	call   80104620 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 f4 73 10 80       	push   $0x801073f4
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e51:	e8 0a 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 9f 37 00 00       	jmp    80104620 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 73 37 00 00       	call   80104620 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 5a 25 00 00       	call   80103430 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 9b 1d 00 00       	call   80102c80 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 c0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 f1 1d 00 00       	jmp    80102cf0 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 fc 73 10 80       	push   $0x801073fc
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 56 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 f9 09 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 20 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 f1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 c4 09 00 00       	call   80101960 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 ad 07 00 00       	call   80101760 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 0e 26 00 00       	jmp    801035e0 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 06 74 10 80       	push   $0x80107406
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 17 07 00 00       	call   80101760 <iunlock>
      end_op();
80101049:	e8 a2 1c 00 00       	call   80102cf0 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 05 1c 00 00       	call   80102c80 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 fa 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 c8 09 00 00       	call   80101a60 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 b3 06 00 00       	call   80101760 <iunlock>
      end_op();
801010ad:	e8 3e 1c 00 00       	call   80102cf0 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 de 23 00 00       	jmp    801034d0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 0f 74 10 80       	push   $0x8010740f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 15 74 10 80       	push   $0x80107415
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	56                   	push   %esi
80101114:	53                   	push   %ebx
80101115:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101117:	c1 ea 0c             	shr    $0xc,%edx
8010111a:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101120:	83 ec 08             	sub    $0x8,%esp
80101123:	52                   	push   %edx
80101124:	50                   	push   %eax
80101125:	e8 a6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010112a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010112f:	ba 01 00 00 00       	mov    $0x1,%edx
80101134:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101137:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010113d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101140:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101142:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101147:	85 d1                	test   %edx,%ecx
80101149:	74 25                	je     80101170 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010114b:	f7 d2                	not    %edx
8010114d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101152:	21 ca                	and    %ecx,%edx
80101154:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101158:	56                   	push   %esi
80101159:	e8 f2 1c 00 00       	call   80102e50 <log_write>
  brelse(bp);
8010115e:	89 34 24             	mov    %esi,(%esp)
80101161:	e8 7a f0 ff ff       	call   801001e0 <brelse>
}
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010116c:	5b                   	pop    %ebx
8010116d:	5e                   	pop    %esi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
    panic("freeing free block");
80101170:	83 ec 0c             	sub    $0xc,%esp
80101173:	68 1f 74 10 80       	push   $0x8010741f
80101178:	e8 13 f2 ff ff       	call   80100390 <panic>
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011be:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801011c3:	83 c4 10             	add    $0x10,%esp
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011d5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	85 df                	test   %ebx,%edi
801011eb:	89 fa                	mov    %edi,%edx
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 d4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 32 74 10 80       	push   $0x80107432
80101229:	e8 62 f1 ff ff       	call   80100390 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 0e 1c 00 00       	call   80102e50 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 96 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
80101255:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125a:	83 c4 0c             	add    $0xc,%esp
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 06 34 00 00       	call   80104670 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 de 1b 00 00       	call   80102e50 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010128a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101298:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 00 0a 11 80       	push   $0x80110a00
801012aa:	e8 b1 32 00 00       	call   80104560 <acquire>
801012af:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b5:	eb 17                	jmp    801012ce <iget+0x3e>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012c0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012c6:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801012cc:	73 22                	jae    801012f0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d1:	85 c9                	test   %ecx,%ecx
801012d3:	7e 04                	jle    801012d9 <iget+0x49>
801012d5:	39 3b                	cmp    %edi,(%ebx)
801012d7:	74 4f                	je     80101328 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e3                	jne    801012c0 <iget+0x30>
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e8:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801012ee:	72 de                	jb     801012ce <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 5b                	je     8010134f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101303:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010130a:	68 00 0a 11 80       	push   $0x80110a00
8010130f:	e8 0c 33 00 00       	call   80104620 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
80101321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101328:	39 53 04             	cmp    %edx,0x4(%ebx)
8010132b:	75 ac                	jne    801012d9 <iget+0x49>
      release(&icache.lock);
8010132d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101330:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101333:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101335:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
8010133a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010133d:	e8 de 32 00 00       	call   80104620 <release>
      return ip;
80101342:	83 c4 10             	add    $0x10,%esp
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	89 f0                	mov    %esi,%eax
8010134a:	5b                   	pop    %ebx
8010134b:	5e                   	pop    %esi
8010134c:	5f                   	pop    %edi
8010134d:	5d                   	pop    %ebp
8010134e:	c3                   	ret    
    panic("iget: no inodes");
8010134f:	83 ec 0c             	sub    $0xc,%esp
80101352:	68 48 74 10 80       	push   $0x80107448
80101357:	e8 34 f0 ff ff       	call   80100390 <panic>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c6                	mov    %eax,%esi
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101376:	85 db                	test   %ebx,%ebx
80101378:	74 76                	je     801013f0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	89 d8                	mov    %ebx,%eax
8010137f:	5b                   	pop    %ebx
80101380:	5e                   	pop    %esi
80101381:	5f                   	pop    %edi
80101382:	5d                   	pop    %ebp
80101383:	c3                   	ret    
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101388:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010138b:	83 fb 7f             	cmp    $0x7f,%ebx
8010138e:	0f 87 90 00 00 00    	ja     80101424 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101394:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010139a:	8b 00                	mov    (%eax),%eax
8010139c:	85 d2                	test   %edx,%edx
8010139e:	74 70                	je     80101410 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013a0:	83 ec 08             	sub    $0x8,%esp
801013a3:	52                   	push   %edx
801013a4:	50                   	push   %eax
801013a5:	e8 26 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013aa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013ae:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013b1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013b3:	8b 1a                	mov    (%edx),%ebx
801013b5:	85 db                	test   %ebx,%ebx
801013b7:	75 1d                	jne    801013d6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013b9:	8b 06                	mov    (%esi),%eax
801013bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013be:	e8 bd fd ff ff       	call   80101180 <balloc>
801013c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013c6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013c9:	89 c3                	mov    %eax,%ebx
801013cb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013cd:	57                   	push   %edi
801013ce:	e8 7d 1a 00 00       	call   80102e50 <log_write>
801013d3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801013d6:	83 ec 0c             	sub    $0xc,%esp
801013d9:	57                   	push   %edi
801013da:	e8 01 ee ff ff       	call   801001e0 <brelse>
801013df:	83 c4 10             	add    $0x10,%esp
}
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	89 d8                	mov    %ebx,%eax
801013e7:	5b                   	pop    %ebx
801013e8:	5e                   	pop    %esi
801013e9:	5f                   	pop    %edi
801013ea:	5d                   	pop    %ebp
801013eb:	c3                   	ret    
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801013f0:	8b 00                	mov    (%eax),%eax
801013f2:	e8 89 fd ff ff       	call   80101180 <balloc>
801013f7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801013fd:	89 c3                	mov    %eax,%ebx
}
801013ff:	89 d8                	mov    %ebx,%eax
80101401:	5b                   	pop    %ebx
80101402:	5e                   	pop    %esi
80101403:	5f                   	pop    %edi
80101404:	5d                   	pop    %ebp
80101405:	c3                   	ret    
80101406:	8d 76 00             	lea    0x0(%esi),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 6b fd ff ff       	call   80101180 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	e9 7c ff ff ff       	jmp    801013a0 <bmap+0x40>
  panic("bmap: out of range");
80101424:	83 ec 0c             	sub    $0xc,%esp
80101427:	68 58 74 10 80       	push   $0x80107458
8010142c:	e8 5f ef ff ff       	call   80100390 <panic>
80101431:	eb 0d                	jmp    80101440 <readsb>
80101433:	90                   	nop
80101434:	90                   	nop
80101435:	90                   	nop
80101436:	90                   	nop
80101437:	90                   	nop
80101438:	90                   	nop
80101439:	90                   	nop
8010143a:	90                   	nop
8010143b:	90                   	nop
8010143c:	90                   	nop
8010143d:	90                   	nop
8010143e:	90                   	nop
8010143f:	90                   	nop

80101440 <readsb>:
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	56                   	push   %esi
80101444:	53                   	push   %ebx
80101445:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101448:	83 ec 08             	sub    $0x8,%esp
8010144b:	6a 01                	push   $0x1
8010144d:	ff 75 08             	pushl  0x8(%ebp)
80101450:	e8 7b ec ff ff       	call   801000d0 <bread>
80101455:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101457:	8d 40 5c             	lea    0x5c(%eax),%eax
8010145a:	83 c4 0c             	add    $0xc,%esp
8010145d:	6a 1c                	push   $0x1c
8010145f:	50                   	push   %eax
80101460:	56                   	push   %esi
80101461:	e8 ba 32 00 00       	call   80104720 <memmove>
  brelse(bp);
80101466:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101469:	83 c4 10             	add    $0x10,%esp
}
8010146c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5d                   	pop    %ebp
  brelse(bp);
80101472:	e9 69 ed ff ff       	jmp    801001e0 <brelse>
80101477:	89 f6                	mov    %esi,%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <iinit>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010148c:	68 6b 74 10 80       	push   $0x8010746b
80101491:	68 00 0a 11 80       	push   $0x80110a00
80101496:	e8 85 2f 00 00       	call   80104420 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 72 74 10 80       	push   $0x80107472
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 3c 2e 00 00       	call   801042f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 e0 09 11 80       	push   $0x801109e0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 71 ff ff ff       	call   80101440 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014d5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014db:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014e1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014e7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014ed:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014f3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014f9:	68 d8 74 10 80       	push   $0x801074d8
801014fe:	e8 5d f1 ff ff       	call   80100660 <cprintf>
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 dd 30 00 00       	call   80104670 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 ab 18 00 00       	call   80102e50 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 d0 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 78 74 10 80       	push   $0x80107478
801015c8:	e8 c3 ed ff ff       	call   80100390 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 ea 30 00 00       	call   80104720 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 12 18 00 00       	call   80102e50 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 00 0a 11 80       	push   $0x80110a00
8010165f:	e8 fc 2e 00 00       	call   80104560 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010166f:	e8 ac 2f 00 00       	call   80104620 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b7 00 00 00    	je     80101747 <ilock+0xc7>
80101690:	8b 53 08             	mov    0x8(%ebx),%edx
80101693:	85 d2                	test   %edx,%edx
80101695:	0f 8e ac 00 00 00    	jle    80101747 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 89 2c 00 00       	call   80104330 <acquiresleep>
  if(ip->valid == 0){
801016a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016aa:	83 c4 10             	add    $0x10,%esp
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 0f                	je     801016c0 <ilock+0x40>
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
801016b7:	c3                   	ret    
801016b8:	90                   	nop
801016b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 03 30 00 00       	call   80104720 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101725:	83 c4 10             	add    $0x10,%esp
80101728:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010172d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101734:	0f 85 77 ff ff ff    	jne    801016b1 <ilock+0x31>
      panic("ilock: no type");
8010173a:	83 ec 0c             	sub    $0xc,%esp
8010173d:	68 90 74 10 80       	push   $0x80107490
80101742:	e8 49 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	68 8a 74 10 80       	push   $0x8010748a
8010174f:	e8 3c ec ff ff       	call   80100390 <panic>
80101754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101760 <iunlock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 58 2c 00 00       	call   801043d0 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010178f:	e9 fc 2b 00 00       	jmp    80104390 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 9f 74 10 80       	push   $0x8010749f
8010179c:	e8 ef eb ff ff       	call   80100390 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017bf:	57                   	push   %edi
801017c0:	e8 6b 2b 00 00       	call   80104330 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	85 d2                	test   %edx,%edx
801017cd:	74 07                	je     801017d6 <iput+0x26>
801017cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017d4:	74 32                	je     80101808 <iput+0x58>
  releasesleep(&ip->lock);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	57                   	push   %edi
801017da:	e8 b1 2b 00 00       	call   80104390 <releasesleep>
  acquire(&icache.lock);
801017df:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801017e6:	e8 75 2d 00 00       	call   80104560 <acquire>
  ip->ref--;
801017eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5f                   	pop    %edi
801017ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101800:	e9 1b 2e 00 00       	jmp    80104620 <release>
80101805:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	68 00 0a 11 80       	push   $0x80110a00
80101810:	e8 4b 2d 00 00       	call   80104560 <acquire>
    int r = ip->ref;
80101815:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101818:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010181f:	e8 fc 2d 00 00       	call   80104620 <release>
    if(r == 1){
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	83 fe 01             	cmp    $0x1,%esi
8010182a:	75 aa                	jne    801017d6 <iput+0x26>
8010182c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101832:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101835:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101838:	89 cf                	mov    %ecx,%edi
8010183a:	eb 0b                	jmp    80101847 <iput+0x97>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101840:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101843:	39 fe                	cmp    %edi,%esi
80101845:	74 19                	je     80101860 <iput+0xb0>
    if(ip->addrs[i]){
80101847:	8b 16                	mov    (%esi),%edx
80101849:	85 d2                	test   %edx,%edx
8010184b:	74 f3                	je     80101840 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010184d:	8b 03                	mov    (%ebx),%eax
8010184f:	e8 bc f8 ff ff       	call   80101110 <bfree>
      ip->addrs[i] = 0;
80101854:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010185a:	eb e4                	jmp    80101840 <iput+0x90>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101860:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101866:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101869:	85 c0                	test   %eax,%eax
8010186b:	75 33                	jne    801018a0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010186d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101870:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101877:	53                   	push   %ebx
80101878:	e8 53 fd ff ff       	call   801015d0 <iupdate>
      ip->type = 0;
8010187d:	31 c0                	xor    %eax,%eax
8010187f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101883:	89 1c 24             	mov    %ebx,(%esp)
80101886:	e8 45 fd ff ff       	call   801015d0 <iupdate>
      ip->valid = 0;
8010188b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101892:	83 c4 10             	add    $0x10,%esp
80101895:	e9 3c ff ff ff       	jmp    801017d6 <iput+0x26>
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a0:	83 ec 08             	sub    $0x8,%esp
801018a3:	50                   	push   %eax
801018a4:	ff 33                	pushl  (%ebx)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018b1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018b7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	89 cf                	mov    %ecx,%edi
801018bf:	eb 0e                	jmp    801018cf <iput+0x11f>
801018c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018c8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018cb:	39 fe                	cmp    %edi,%esi
801018cd:	74 0f                	je     801018de <iput+0x12e>
      if(a[j])
801018cf:	8b 16                	mov    (%esi),%edx
801018d1:	85 d2                	test   %edx,%edx
801018d3:	74 f3                	je     801018c8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018d5:	8b 03                	mov    (%ebx),%eax
801018d7:	e8 34 f8 ff ff       	call   80101110 <bfree>
801018dc:	eb ea                	jmp    801018c8 <iput+0x118>
    brelse(bp);
801018de:	83 ec 0c             	sub    $0xc,%esp
801018e1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018e7:	e8 f4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018ec:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801018f2:	8b 03                	mov    (%ebx),%eax
801018f4:	e8 17 f8 ff ff       	call   80101110 <bfree>
    ip->addrs[NDIRECT] = 0;
801018f9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101900:	00 00 00 
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	e9 62 ff ff ff       	jmp    8010186d <iput+0xbd>
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	53                   	push   %ebx
8010191b:	e8 40 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101920:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101923:	83 c4 10             	add    $0x10,%esp
}
80101926:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101929:	c9                   	leave  
  iput(ip);
8010192a:	e9 81 fe ff ff       	jmp    801017b0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 1c             	sub    $0x1c,%esp
80101969:	8b 45 08             	mov    0x8(%ebp),%eax
8010196c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010196f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101972:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101977:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010197a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010197d:	8b 75 10             	mov    0x10(%ebp),%esi
80101980:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101983:	0f 84 a7 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010198c:	8b 40 58             	mov    0x58(%eax),%eax
8010198f:	39 c6                	cmp    %eax,%esi
80101991:	0f 87 ba 00 00 00    	ja     80101a51 <readi+0xf1>
80101997:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010199a:	89 f9                	mov    %edi,%ecx
8010199c:	01 f1                	add    %esi,%ecx
8010199e:	0f 82 ad 00 00 00    	jb     80101a51 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a4:	89 c2                	mov    %eax,%edx
801019a6:	29 f2                	sub    %esi,%edx
801019a8:	39 c8                	cmp    %ecx,%eax
801019aa:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ad:	31 ff                	xor    %edi,%edi
801019af:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019b1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b4:	74 6c                	je     80101a22 <readi+0xc2>
801019b6:	8d 76 00             	lea    0x0(%esi),%esi
801019b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019c3:	89 f2                	mov    %esi,%edx
801019c5:	c1 ea 09             	shr    $0x9,%edx
801019c8:	89 d8                	mov    %ebx,%eax
801019ca:	e8 91 f9 ff ff       	call   80101360 <bmap>
801019cf:	83 ec 08             	sub    $0x8,%esp
801019d2:	50                   	push   %eax
801019d3:	ff 33                	pushl  (%ebx)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019dd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019df:	89 f0                	mov    %esi,%eax
801019e1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019eb:	83 c4 0c             	add    $0xc,%esp
801019ee:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019f4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	29 fb                	sub    %edi,%ebx
801019f9:	39 d9                	cmp    %ebx,%ecx
801019fb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fe:	53                   	push   %ebx
801019ff:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a00:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a05:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a07:	e8 14 2d 00 00       	call   80104720 <memmove>
    brelse(bp);
80101a0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a0f:	89 14 24             	mov    %edx,(%esp)
80101a12:	e8 c9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a17:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a20:	77 9e                	ja     801019c0 <readi+0x60>
  }
  return n;
80101a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a28:	5b                   	pop    %ebx
80101a29:	5e                   	pop    %esi
80101a2a:	5f                   	pop    %edi
80101a2b:	5d                   	pop    %ebp
80101a2c:	c3                   	ret    
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 17                	ja     80101a51 <readi+0xf1>
80101a3a:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 0c                	je     80101a51 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4b:	5b                   	pop    %ebx
80101a4c:	5e                   	pop    %esi
80101a4d:	5f                   	pop    %edi
80101a4e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a4f:	ff e0                	jmp    *%eax
      return -1;
80101a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a56:	eb cd                	jmp    80101a25 <readi+0xc5>
80101a58:	90                   	nop
80101a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a7d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a80:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 eb 00 00 00    	jb     80101b80 <writei+0x120>
80101a95:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a98:	31 d2                	xor    %edx,%edx
80101a9a:	89 f8                	mov    %edi,%eax
80101a9c:	01 f0                	add    %esi,%eax
80101a9e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa6:	0f 87 d4 00 00 00    	ja     80101b80 <writei+0x120>
80101aac:	85 d2                	test   %edx,%edx
80101aae:	0f 85 cc 00 00 00    	jne    80101b80 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ab4:	85 ff                	test   %edi,%edi
80101ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101abd:	74 72                	je     80101b31 <writei+0xd1>
80101abf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
80101ac5:	c1 ea 09             	shr    $0x9,%edx
80101ac8:	89 f8                	mov    %edi,%eax
80101aca:	e8 91 f8 ff ff       	call   80101360 <bmap>
80101acf:	83 ec 08             	sub    $0x8,%esp
80101ad2:	50                   	push   %eax
80101ad3:	ff 37                	pushl  (%edi)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101add:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae2:	89 f0                	mov    %esi,%eax
80101ae4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	25 ff 01 00 00       	and    $0x1ff,%eax
80101af1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101af7:	39 d9                	cmp    %ebx,%ecx
80101af9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101afc:	53                   	push   %ebx
80101afd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b00:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b02:	50                   	push   %eax
80101b03:	e8 18 2c 00 00       	call   80104720 <memmove>
    log_write(bp);
80101b08:	89 3c 24             	mov    %edi,(%esp)
80101b0b:	e8 40 13 00 00       	call   80102e50 <log_write>
    brelse(bp);
80101b10:	89 3c 24             	mov    %edi,(%esp)
80101b13:	e8 c8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b18:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b24:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b27:	77 97                	ja     80101ac0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b2f:	77 37                	ja     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b31:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b37:	5b                   	pop    %ebx
80101b38:	5e                   	pop    %esi
80101b39:	5f                   	pop    %edi
80101b3a:	5d                   	pop    %ebp
80101b3b:	c3                   	ret    
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 36                	ja     80101b80 <writei+0x120>
80101b4a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 2b                	je     80101b80 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b6e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b71:	50                   	push   %eax
80101b72:	e8 59 fa ff ff       	call   801015d0 <iupdate>
80101b77:	83 c4 10             	add    $0x10,%esp
80101b7a:	eb b5                	jmp    80101b31 <writei+0xd1>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b85:	eb ad                	jmp    80101b34 <writei+0xd4>
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	6a 0e                	push   $0xe
80101b98:	ff 75 0c             	pushl  0xc(%ebp)
80101b9b:	ff 75 08             	pushl  0x8(%ebp)
80101b9e:	e8 ed 2b 00 00       	call   80104790 <strncmp>
}
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    
80101ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bc1:	0f 85 85 00 00 00    	jne    80101c4c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bca:	31 ff                	xor    %edi,%edi
80101bcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcf:	85 d2                	test   %edx,%edx
80101bd1:	74 3e                	je     80101c11 <dirlookup+0x61>
80101bd3:	90                   	nop
80101bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd8:	6a 10                	push   $0x10
80101bda:	57                   	push   %edi
80101bdb:	56                   	push   %esi
80101bdc:	53                   	push   %ebx
80101bdd:	e8 7e fd ff ff       	call   80101960 <readi>
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	83 f8 10             	cmp    $0x10,%eax
80101be8:	75 55                	jne    80101c3f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bef:	74 18                	je     80101c09 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101bf1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bf4:	83 ec 04             	sub    $0x4,%esp
80101bf7:	6a 0e                	push   $0xe
80101bf9:	50                   	push   %eax
80101bfa:	ff 75 0c             	pushl  0xc(%ebp)
80101bfd:	e8 8e 2b 00 00       	call   80104790 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	85 c0                	test   %eax,%eax
80101c07:	74 17                	je     80101c20 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c09:	83 c7 10             	add    $0x10,%edi
80101c0c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c0f:	72 c7                	jb     80101bd8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c11:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c14:	31 c0                	xor    %eax,%eax
}
80101c16:	5b                   	pop    %ebx
80101c17:	5e                   	pop    %esi
80101c18:	5f                   	pop    %edi
80101c19:	5d                   	pop    %ebp
80101c1a:	c3                   	ret    
80101c1b:	90                   	nop
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c20:	8b 45 10             	mov    0x10(%ebp),%eax
80101c23:	85 c0                	test   %eax,%eax
80101c25:	74 05                	je     80101c2c <dirlookup+0x7c>
        *poff = off;
80101c27:	8b 45 10             	mov    0x10(%ebp),%eax
80101c2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c30:	8b 03                	mov    (%ebx),%eax
80101c32:	e8 59 f6 ff ff       	call   80101290 <iget>
}
80101c37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3a:	5b                   	pop    %ebx
80101c3b:	5e                   	pop    %esi
80101c3c:	5f                   	pop    %edi
80101c3d:	5d                   	pop    %ebp
80101c3e:	c3                   	ret    
      panic("dirlookup read");
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	68 b9 74 10 80       	push   $0x801074b9
80101c47:	e8 44 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c4c:	83 ec 0c             	sub    $0xc,%esp
80101c4f:	68 a7 74 10 80       	push   $0x801074a7
80101c54:	e8 37 e7 ff ff       	call   80100390 <panic>
80101c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	89 cf                	mov    %ecx,%edi
80101c68:	89 c3                	mov    %eax,%ebx
80101c6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c6d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c73:	0f 84 67 01 00 00    	je     80101de0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c79:	e8 42 1c 00 00       	call   801038c0 <myproc>
  acquire(&icache.lock);
80101c7e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c81:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c84:	68 00 0a 11 80       	push   $0x80110a00
80101c89:	e8 d2 28 00 00       	call   80104560 <acquire>
  ip->ref++;
80101c8e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c92:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c99:	e8 82 29 00 00       	call   80104620 <release>
80101c9e:	83 c4 10             	add    $0x10,%esp
80101ca1:	eb 08                	jmp    80101cab <namex+0x4b>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ca8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cab:	0f b6 03             	movzbl (%ebx),%eax
80101cae:	3c 2f                	cmp    $0x2f,%al
80101cb0:	74 f6                	je     80101ca8 <namex+0x48>
  if(*path == 0)
80101cb2:	84 c0                	test   %al,%al
80101cb4:	0f 84 ee 00 00 00    	je     80101da8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cba:	0f b6 03             	movzbl (%ebx),%eax
80101cbd:	3c 2f                	cmp    $0x2f,%al
80101cbf:	0f 84 b3 00 00 00    	je     80101d78 <namex+0x118>
80101cc5:	84 c0                	test   %al,%al
80101cc7:	89 da                	mov    %ebx,%edx
80101cc9:	75 09                	jne    80101cd4 <namex+0x74>
80101ccb:	e9 a8 00 00 00       	jmp    80101d78 <namex+0x118>
80101cd0:	84 c0                	test   %al,%al
80101cd2:	74 0a                	je     80101cde <namex+0x7e>
    path++;
80101cd4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cd7:	0f b6 02             	movzbl (%edx),%eax
80101cda:	3c 2f                	cmp    $0x2f,%al
80101cdc:	75 f2                	jne    80101cd0 <namex+0x70>
80101cde:	89 d1                	mov    %edx,%ecx
80101ce0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ce2:	83 f9 0d             	cmp    $0xd,%ecx
80101ce5:	0f 8e 91 00 00 00    	jle    80101d7c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ceb:	83 ec 04             	sub    $0x4,%esp
80101cee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cf1:	6a 0e                	push   $0xe
80101cf3:	53                   	push   %ebx
80101cf4:	57                   	push   %edi
80101cf5:	e8 26 2a 00 00       	call   80104720 <memmove>
    path++;
80101cfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cfd:	83 c4 10             	add    $0x10,%esp
    path++;
80101d00:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d02:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d05:	75 11                	jne    80101d18 <namex+0xb8>
80101d07:	89 f6                	mov    %esi,%esi
80101d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d13:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d16:	74 f8                	je     80101d10 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
80101d1b:	56                   	push   %esi
80101d1c:	e8 5f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d21:	83 c4 10             	add    $0x10,%esp
80101d24:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d29:	0f 85 91 00 00 00    	jne    80101dc0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d2f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d32:	85 d2                	test   %edx,%edx
80101d34:	74 09                	je     80101d3f <namex+0xdf>
80101d36:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d39:	0f 84 b7 00 00 00    	je     80101df6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d3f:	83 ec 04             	sub    $0x4,%esp
80101d42:	6a 00                	push   $0x0
80101d44:	57                   	push   %edi
80101d45:	56                   	push   %esi
80101d46:	e8 65 fe ff ff       	call   80101bb0 <dirlookup>
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	85 c0                	test   %eax,%eax
80101d50:	74 6e                	je     80101dc0 <namex+0x160>
  iunlock(ip);
80101d52:	83 ec 0c             	sub    $0xc,%esp
80101d55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d58:	56                   	push   %esi
80101d59:	e8 02 fa ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d5e:	89 34 24             	mov    %esi,(%esp)
80101d61:	e8 4a fa ff ff       	call   801017b0 <iput>
80101d66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d69:	83 c4 10             	add    $0x10,%esp
80101d6c:	89 c6                	mov    %eax,%esi
80101d6e:	e9 38 ff ff ff       	jmp    80101cab <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d78:	89 da                	mov    %ebx,%edx
80101d7a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d7c:	83 ec 04             	sub    $0x4,%esp
80101d7f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d82:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d85:	51                   	push   %ecx
80101d86:	53                   	push   %ebx
80101d87:	57                   	push   %edi
80101d88:	e8 93 29 00 00       	call   80104720 <memmove>
    name[len] = 0;
80101d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d90:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d9a:	89 d3                	mov    %edx,%ebx
80101d9c:	e9 61 ff ff ff       	jmp    80101d02 <namex+0xa2>
80101da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dab:	85 c0                	test   %eax,%eax
80101dad:	75 5d                	jne    80101e0c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101daf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db2:	89 f0                	mov    %esi,%eax
80101db4:	5b                   	pop    %ebx
80101db5:	5e                   	pop    %esi
80101db6:	5f                   	pop    %edi
80101db7:	5d                   	pop    %ebp
80101db8:	c3                   	ret    
80101db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 97 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101dc9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dcc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dce:	e8 dd f9 ff ff       	call   801017b0 <iput>
      return 0;
80101dd3:	83 c4 10             	add    $0x10,%esp
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	89 f0                	mov    %esi,%eax
80101ddb:	5b                   	pop    %ebx
80101ddc:	5e                   	pop    %esi
80101ddd:	5f                   	pop    %edi
80101dde:	5d                   	pop    %ebp
80101ddf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101de0:	ba 01 00 00 00       	mov    $0x1,%edx
80101de5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dea:	e8 a1 f4 ff ff       	call   80101290 <iget>
80101def:	89 c6                	mov    %eax,%esi
80101df1:	e9 b5 fe ff ff       	jmp    80101cab <namex+0x4b>
      iunlock(ip);
80101df6:	83 ec 0c             	sub    $0xc,%esp
80101df9:	56                   	push   %esi
80101dfa:	e8 61 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101dff:	83 c4 10             	add    $0x10,%esp
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e05:	89 f0                	mov    %esi,%eax
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
    iput(ip);
80101e0c:	83 ec 0c             	sub    $0xc,%esp
80101e0f:	56                   	push   %esi
    return 0;
80101e10:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e12:	e8 99 f9 ff ff       	call   801017b0 <iput>
    return 0;
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	eb 93                	jmp    80101daf <namex+0x14f>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 20             	sub    $0x20,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	6a 00                	push   $0x0
80101e2e:	ff 75 0c             	pushl  0xc(%ebp)
80101e31:	53                   	push   %ebx
80101e32:	e8 79 fd ff ff       	call   80101bb0 <dirlookup>
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	75 67                	jne    80101ea5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e44:	85 ff                	test   %edi,%edi
80101e46:	74 29                	je     80101e71 <dirlink+0x51>
80101e48:	31 ff                	xor    %edi,%edi
80101e4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e4d:	eb 09                	jmp    80101e58 <dirlink+0x38>
80101e4f:	90                   	nop
80101e50:	83 c7 10             	add    $0x10,%edi
80101e53:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e56:	73 19                	jae    80101e71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e58:	6a 10                	push   $0x10
80101e5a:	57                   	push   %edi
80101e5b:	56                   	push   %esi
80101e5c:	53                   	push   %ebx
80101e5d:	e8 fe fa ff ff       	call   80101960 <readi>
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	83 f8 10             	cmp    $0x10,%eax
80101e68:	75 4e                	jne    80101eb8 <dirlink+0x98>
    if(de.inum == 0)
80101e6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e6f:	75 df                	jne    80101e50 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e74:	83 ec 04             	sub    $0x4,%esp
80101e77:	6a 0e                	push   $0xe
80101e79:	ff 75 0c             	pushl  0xc(%ebp)
80101e7c:	50                   	push   %eax
80101e7d:	e8 6e 29 00 00       	call   801047f0 <strncpy>
  de.inum = inum;
80101e82:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e85:	6a 10                	push   $0x10
80101e87:	57                   	push   %edi
80101e88:	56                   	push   %esi
80101e89:	53                   	push   %ebx
  de.inum = inum;
80101e8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e8e:	e8 cd fb ff ff       	call   80101a60 <writei>
80101e93:	83 c4 20             	add    $0x20,%esp
80101e96:	83 f8 10             	cmp    $0x10,%eax
80101e99:	75 2a                	jne    80101ec5 <dirlink+0xa5>
  return 0;
80101e9b:	31 c0                	xor    %eax,%eax
}
80101e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea0:	5b                   	pop    %ebx
80101ea1:	5e                   	pop    %esi
80101ea2:	5f                   	pop    %edi
80101ea3:	5d                   	pop    %ebp
80101ea4:	c3                   	ret    
    iput(ip);
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	50                   	push   %eax
80101ea9:	e8 02 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb6:	eb e5                	jmp    80101e9d <dirlink+0x7d>
      panic("dirlink read");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 c8 74 10 80       	push   $0x801074c8
80101ec0:	e8 cb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	68 4e 7b 10 80       	push   $0x80107b4e
80101ecd:	e8 be e4 ff ff       	call   80100390 <panic>
80101ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <namei>:

struct inode*
namei(char *path)
{
80101ee0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee1:	31 d2                	xor    %edx,%edx
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eeb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eee:	e8 6d fd ff ff       	call   80101c60 <namex>
}
80101ef3:	c9                   	leave  
80101ef4:	c3                   	ret    
80101ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f00:	55                   	push   %ebp
  return namex(path, 1, name);
80101f01:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f0e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f0f:	e9 4c fd ff ff       	jmp    80101c60 <namex>
80101f14:	66 90                	xchg   %ax,%ax
80101f16:	66 90                	xchg   %ax,%ax
80101f18:	66 90                	xchg   %ax,%ax
80101f1a:	66 90                	xchg   %ax,%ax
80101f1c:	66 90                	xchg   %ax,%ax
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f29:	85 c0                	test   %eax,%eax
80101f2b:	0f 84 b4 00 00 00    	je     80101fe5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f31:	8b 58 08             	mov    0x8(%eax),%ebx
80101f34:	89 c6                	mov    %eax,%esi
80101f36:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f3c:	0f 87 96 00 00 00    	ja     80101fd8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f42:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f47:	89 f6                	mov    %esi,%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f50:	89 ca                	mov    %ecx,%edx
80101f52:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f53:	83 e0 c0             	and    $0xffffffc0,%eax
80101f56:	3c 40                	cmp    $0x40,%al
80101f58:	75 f6                	jne    80101f50 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f5a:	31 ff                	xor    %edi,%edi
80101f5c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f61:	89 f8                	mov    %edi,%eax
80101f63:	ee                   	out    %al,(%dx)
80101f64:	b8 01 00 00 00       	mov    $0x1,%eax
80101f69:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f6e:	ee                   	out    %al,(%dx)
80101f6f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f74:	89 d8                	mov    %ebx,%eax
80101f76:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f7e:	c1 f8 08             	sar    $0x8,%eax
80101f81:	ee                   	out    %al,(%dx)
80101f82:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f87:	89 f8                	mov    %edi,%eax
80101f89:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f8a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f8e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f93:	c1 e0 04             	shl    $0x4,%eax
80101f96:	83 e0 10             	and    $0x10,%eax
80101f99:	83 c8 e0             	or     $0xffffffe0,%eax
80101f9c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f9d:	f6 06 04             	testb  $0x4,(%esi)
80101fa0:	75 16                	jne    80101fb8 <idestart+0x98>
80101fa2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fa7:	89 ca                	mov    %ecx,%edx
80101fa9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fad:	5b                   	pop    %ebx
80101fae:	5e                   	pop    %esi
80101faf:	5f                   	pop    %edi
80101fb0:	5d                   	pop    %ebp
80101fb1:	c3                   	ret    
80101fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fb8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fbd:	89 ca                	mov    %ecx,%edx
80101fbf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fc5:	83 c6 5c             	add    $0x5c,%esi
80101fc8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fcd:	fc                   	cld    
80101fce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret    
    panic("incorrect blockno");
80101fd8:	83 ec 0c             	sub    $0xc,%esp
80101fdb:	68 34 75 10 80       	push   $0x80107534
80101fe0:	e8 ab e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	68 2b 75 10 80       	push   $0x8010752b
80101fed:	e8 9e e3 ff ff       	call   80100390 <panic>
80101ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102006:	68 46 75 10 80       	push   $0x80107546
8010200b:	68 80 a5 10 80       	push   $0x8010a580
80102010:	e8 0b 24 00 00       	call   80104420 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102015:	58                   	pop    %eax
80102016:	a1 00 29 11 80       	mov    0x80112900,%eax
8010201b:	5a                   	pop    %edx
8010201c:	83 e8 01             	sub    $0x1,%eax
8010201f:	50                   	push   %eax
80102020:	6a 0e                	push   $0xe
80102022:	e8 a9 02 00 00       	call   801022d0 <ioapicenable>
80102027:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010202a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010202f:	90                   	nop
80102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102031:	83 e0 c0             	and    $0xffffffc0,%eax
80102034:	3c 40                	cmp    $0x40,%al
80102036:	75 f8                	jne    80102030 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102038:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010203d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102042:	ee                   	out    %al,(%dx)
80102043:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204d:	eb 06                	jmp    80102055 <ideinit+0x55>
8010204f:	90                   	nop
  for(i=0; i<1000; i++){
80102050:	83 e9 01             	sub    $0x1,%ecx
80102053:	74 0f                	je     80102064 <ideinit+0x64>
80102055:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102056:	84 c0                	test   %al,%al
80102058:	74 f6                	je     80102050 <ideinit+0x50>
      havedisk1 = 1;
8010205a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102061:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102064:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102069:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010206e:	ee                   	out    %al,(%dx)
}
8010206f:	c9                   	leave  
80102070:	c3                   	ret    
80102071:	eb 0d                	jmp    80102080 <ideintr>
80102073:	90                   	nop
80102074:	90                   	nop
80102075:	90                   	nop
80102076:	90                   	nop
80102077:	90                   	nop
80102078:	90                   	nop
80102079:	90                   	nop
8010207a:	90                   	nop
8010207b:	90                   	nop
8010207c:	90                   	nop
8010207d:	90                   	nop
8010207e:	90                   	nop
8010207f:	90                   	nop

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	68 80 a5 10 80       	push   $0x8010a580
8010208e:	e8 cd 24 00 00       	call   80104560 <acquire>

  if((b = idequeue) == 0){
80102093:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	85 db                	test   %ebx,%ebx
8010209e:	74 67                	je     80102107 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020a0:	8b 43 58             	mov    0x58(%ebx),%eax
801020a3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a8:	8b 3b                	mov    (%ebx),%edi
801020aa:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020b0:	75 31                	jne    801020e3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c1:	89 c6                	mov    %eax,%esi
801020c3:	83 e6 c0             	and    $0xffffffc0,%esi
801020c6:	89 f1                	mov    %esi,%ecx
801020c8:	80 f9 40             	cmp    $0x40,%cl
801020cb:	75 f3                	jne    801020c0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020cd:	a8 21                	test   $0x21,%al
801020cf:	75 12                	jne    801020e3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020d1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020d4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020d9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020de:	fc                   	cld    
801020df:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020e6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020e9:	89 f9                	mov    %edi,%ecx
801020eb:	83 c9 02             	or     $0x2,%ecx
801020ee:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801020f0:	53                   	push   %ebx
801020f1:	e8 3a 1f 00 00       	call   80104030 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020fb:	83 c4 10             	add    $0x10,%esp
801020fe:	85 c0                	test   %eax,%eax
80102100:	74 05                	je     80102107 <ideintr+0x87>
    idestart(idequeue);
80102102:	e8 19 fe ff ff       	call   80101f20 <idestart>
    release(&idelock);
80102107:	83 ec 0c             	sub    $0xc,%esp
8010210a:	68 80 a5 10 80       	push   $0x8010a580
8010210f:	e8 0c 25 00 00       	call   80104620 <release>

  release(&idelock);
}
80102114:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102117:	5b                   	pop    %ebx
80102118:	5e                   	pop    %esi
80102119:	5f                   	pop    %edi
8010211a:	5d                   	pop    %ebp
8010211b:	c3                   	ret    
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 10             	sub    $0x10,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	50                   	push   %eax
8010212e:	e8 9d 22 00 00       	call   801043d0 <holdingsleep>
80102133:	83 c4 10             	add    $0x10,%esp
80102136:	85 c0                	test   %eax,%eax
80102138:	0f 84 c6 00 00 00    	je     80102204 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213e:	8b 03                	mov    (%ebx),%eax
80102140:	83 e0 06             	and    $0x6,%eax
80102143:	83 f8 02             	cmp    $0x2,%eax
80102146:	0f 84 ab 00 00 00    	je     801021f7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214c:	8b 53 04             	mov    0x4(%ebx),%edx
8010214f:	85 d2                	test   %edx,%edx
80102151:	74 0d                	je     80102160 <iderw+0x40>
80102153:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 84 b1 00 00 00    	je     80102211 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102160:	83 ec 0c             	sub    $0xc,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	e8 f3 23 00 00       	call   80104560 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102173:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102176:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	85 d2                	test   %edx,%edx
8010217f:	75 09                	jne    8010218a <iderw+0x6a>
80102181:	eb 6d                	jmp    801021f0 <iderw+0xd0>
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102188:	89 c2                	mov    %eax,%edx
8010218a:	8b 42 58             	mov    0x58(%edx),%eax
8010218d:	85 c0                	test   %eax,%eax
8010218f:	75 f7                	jne    80102188 <iderw+0x68>
80102191:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102194:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102196:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010219c:	74 42                	je     801021e0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010219e:	8b 03                	mov    (%ebx),%eax
801021a0:	83 e0 06             	and    $0x6,%eax
801021a3:	83 f8 02             	cmp    $0x2,%eax
801021a6:	74 23                	je     801021cb <iderw+0xab>
801021a8:	90                   	nop
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021b0:	83 ec 08             	sub    $0x8,%esp
801021b3:	68 80 a5 10 80       	push   $0x8010a580
801021b8:	53                   	push   %ebx
801021b9:	e8 c2 1c 00 00       	call   80103e80 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 c4 10             	add    $0x10,%esp
801021c3:	83 e0 06             	and    $0x6,%eax
801021c6:	83 f8 02             	cmp    $0x2,%eax
801021c9:	75 e5                	jne    801021b0 <iderw+0x90>
  }


  release(&idelock);
801021cb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d5:	c9                   	leave  
  release(&idelock);
801021d6:	e9 45 24 00 00       	jmp    80104620 <release>
801021db:	90                   	nop
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021e0:	89 d8                	mov    %ebx,%eax
801021e2:	e8 39 fd ff ff       	call   80101f20 <idestart>
801021e7:	eb b5                	jmp    8010219e <iderw+0x7e>
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021f0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021f5:	eb 9d                	jmp    80102194 <iderw+0x74>
    panic("iderw: nothing to do");
801021f7:	83 ec 0c             	sub    $0xc,%esp
801021fa:	68 60 75 10 80       	push   $0x80107560
801021ff:	e8 8c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102204:	83 ec 0c             	sub    $0xc,%esp
80102207:	68 4a 75 10 80       	push   $0x8010754a
8010220c:	e8 7f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	68 75 75 10 80       	push   $0x80107575
80102219:	e8 72 e1 ff ff       	call   80100390 <panic>
8010221e:	66 90                	xchg   %ax,%ax

80102220 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102220:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102221:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102228:	00 c0 fe 
{
8010222b:	89 e5                	mov    %esp,%ebp
8010222d:	56                   	push   %esi
8010222e:	53                   	push   %ebx
  ioapic->reg = reg;
8010222f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102236:	00 00 00 
  return ioapic->data;
80102239:	a1 54 26 11 80       	mov    0x80112654,%eax
8010223e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102247:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010224d:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102254:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102257:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010225a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010225d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102260:	39 c2                	cmp    %eax,%edx
80102262:	74 16                	je     8010227a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 94 75 10 80       	push   $0x80107594
8010226c:	e8 ef e3 ff ff       	call   80100660 <cprintf>
80102271:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102277:	83 c4 10             	add    $0x10,%esp
8010227a:	83 c3 21             	add    $0x21,%ebx
{
8010227d:	ba 10 00 00 00       	mov    $0x10,%edx
80102282:	b8 20 00 00 00       	mov    $0x20,%eax
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102290:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102292:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102298:	89 c6                	mov    %eax,%esi
8010229a:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022a0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022a3:	89 71 10             	mov    %esi,0x10(%ecx)
801022a6:	8d 72 01             	lea    0x1(%edx),%esi
801022a9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022ac:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ae:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022b0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022bd:	75 d1                	jne    80102290 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c2:	5b                   	pop    %ebx
801022c3:	5e                   	pop    %esi
801022c4:	5d                   	pop    %ebp
801022c5:	c3                   	ret    
801022c6:	8d 76 00             	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022d0:	55                   	push   %ebp
  ioapic->reg = reg;
801022d1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
801022d7:	89 e5                	mov    %esp,%ebp
801022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022dc:	8d 50 20             	lea    0x20(%eax),%edx
801022df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022e5:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801022f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f6:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801022fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102301:	5d                   	pop    %ebp
80102302:	c3                   	ret    
80102303:	66 90                	xchg   %ax,%ax
80102305:	66 90                	xchg   %ax,%ax
80102307:	66 90                	xchg   %ax,%ax
80102309:	66 90                	xchg   %ax,%ax
8010230b:	66 90                	xchg   %ax,%ax
8010230d:	66 90                	xchg   %ax,%ax
8010230f:	90                   	nop

80102310 <kfree>:
// initializing the allocator; see kinit above.)


void
kfree(char *v)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	53                   	push   %ebx
80102314:	83 ec 04             	sub    $0x4,%esp
80102317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010231a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102320:	0f 85 84 00 00 00    	jne    801023aa <kfree+0x9a>
80102326:	81 fb a8 51 11 80    	cmp    $0x801151a8,%ebx
8010232c:	72 7c                	jb     801023aa <kfree+0x9a>
8010232e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102334:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102339:	77 6f                	ja     801023aa <kfree+0x9a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010233b:	83 ec 04             	sub    $0x4,%esp
8010233e:	68 00 10 00 00       	push   $0x1000
80102343:	6a 01                	push   $0x1
80102345:	53                   	push   %ebx
80102346:	e8 25 23 00 00       	call   80104670 <memset>

  if(kmem.use_lock)
8010234b:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102351:	83 c4 10             	add    $0x10,%esp
80102354:	85 d2                	test   %edx,%edx
80102356:	75 40                	jne    80102398 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102358:	a1 98 26 11 80       	mov    0x80112698,%eax
8010235d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010235f:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102364:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
8010236a:	85 c0                	test   %eax,%eax
8010236c:	74 10                	je     8010237e <kfree+0x6e>
    release(&kmem.lock);
8010236e:	83 ec 0c             	sub    $0xc,%esp
80102371:	68 60 26 11 80       	push   $0x80112660
80102376:	e8 a5 22 00 00       	call   80104620 <release>
8010237b:	83 c4 10             	add    $0x10,%esp
  freeMemCount = freeMemCount + 1;
8010237e:	83 05 b8 a5 10 80 01 	addl   $0x1,0x8010a5b8
  usedMemCount = usedMemCount - 1;
80102385:	83 2d b4 a5 10 80 01 	subl   $0x1,0x8010a5b4
}
8010238c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238f:	c9                   	leave  
80102390:	c3                   	ret    
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102398:	83 ec 0c             	sub    $0xc,%esp
8010239b:	68 60 26 11 80       	push   $0x80112660
801023a0:	e8 bb 21 00 00       	call   80104560 <acquire>
801023a5:	83 c4 10             	add    $0x10,%esp
801023a8:	eb ae                	jmp    80102358 <kfree+0x48>
    panic("kfree");
801023aa:	83 ec 0c             	sub    $0xc,%esp
801023ad:	68 c6 75 10 80       	push   $0x801075c6
801023b2:	e8 d9 df ff ff       	call   80100390 <panic>
801023b7:	89 f6                	mov    %esi,%esi
801023b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 13 ff ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	57                   	push   %edi
80102414:	56                   	push   %esi
80102415:	53                   	push   %ebx
80102416:	83 ec 14             	sub    $0x14,%esp
80102419:	8b 7d 08             	mov    0x8(%ebp),%edi
8010241c:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010241f:	68 cc 75 10 80       	push   $0x801075cc
80102424:	68 60 26 11 80       	push   $0x80112660
  p = (char*)PGROUNDUP((uint)vstart);
80102429:	8d 9f ff 0f 00 00    	lea    0xfff(%edi),%ebx
  initlock(&kmem.lock, "kmem");
8010242f:	e8 ec 1f 00 00       	call   80104420 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102434:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243a:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
8010243d:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102444:	00 00 00 
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102447:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244d:	39 de                	cmp    %ebx,%esi
8010244f:	72 23                	jb     80102474 <kinit1+0x64>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102458:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010245e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102467:	50                   	push   %eax
80102468:	e8 a3 fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 e4                	jae    80102458 <kinit1+0x48>
  freeMemCount = freeMemCount + (vend - vstart)/PGSIZE;
80102474:	29 fe                	sub    %edi,%esi
80102476:	8d 86 ff 0f 00 00    	lea    0xfff(%esi),%eax
8010247c:	85 f6                	test   %esi,%esi
8010247e:	0f 48 f0             	cmovs  %eax,%esi
80102481:	c1 fe 0c             	sar    $0xc,%esi
80102484:	01 35 b8 a5 10 80    	add    %esi,0x8010a5b8
}
8010248a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010248d:	5b                   	pop    %ebx
8010248e:	5e                   	pop    %esi
8010248f:	5f                   	pop    %edi
80102490:	5d                   	pop    %ebp
80102491:	c3                   	ret    
80102492:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024a0 <kinit2>:
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	57                   	push   %edi
801024a4:	56                   	push   %esi
801024a5:	53                   	push   %ebx
801024a6:	83 ec 0c             	sub    $0xc,%esp
801024a9:	8b 7d 08             	mov    0x8(%ebp),%edi
801024ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801024af:	8d 9f ff 0f 00 00    	lea    0xfff(%edi),%ebx
801024b5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024c1:	39 de                	cmp    %ebx,%esi
801024c3:	72 1f                	jb     801024e4 <kinit2+0x44>
801024c5:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801024c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ce:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024d7:	50                   	push   %eax
801024d8:	e8 33 fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	39 de                	cmp    %ebx,%esi
801024e2:	73 e4                	jae    801024c8 <kinit2+0x28>
  freeMemCount = freeMemCount + (vend - vstart)/PGSIZE;
801024e4:	29 fe                	sub    %edi,%esi
  kmem.use_lock = 1;
801024e6:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024ed:	00 00 00 
  usedMemCount = 0;
801024f0:	c7 05 b4 a5 10 80 00 	movl   $0x0,0x8010a5b4
801024f7:	00 00 00 
  freeMemCount = freeMemCount + (vend - vstart)/PGSIZE;
801024fa:	8d 86 ff 0f 00 00    	lea    0xfff(%esi),%eax
80102500:	85 f6                	test   %esi,%esi
80102502:	0f 48 f0             	cmovs  %eax,%esi
80102505:	c1 fe 0c             	sar    $0xc,%esi
80102508:	01 35 b8 a5 10 80    	add    %esi,0x8010a5b8
}
8010250e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102511:	5b                   	pop    %ebx
80102512:	5e                   	pop    %esi
80102513:	5f                   	pop    %edi
80102514:	5d                   	pop    %ebp
80102515:	c3                   	ret    
80102516:	8d 76 00             	lea    0x0(%esi),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <kalloc>:
kalloc(void)
{
  struct run *r;
  freeMemCount = freeMemCount - 1;
  usedMemCount = usedMemCount + 1;
  if(kmem.use_lock)
80102520:	a1 94 26 11 80       	mov    0x80112694,%eax
  freeMemCount = freeMemCount - 1;
80102525:	83 2d b8 a5 10 80 01 	subl   $0x1,0x8010a5b8
  usedMemCount = usedMemCount + 1;
8010252c:	83 05 b4 a5 10 80 01 	addl   $0x1,0x8010a5b4
  if(kmem.use_lock)
80102533:	85 c0                	test   %eax,%eax
80102535:	75 21                	jne    80102558 <kalloc+0x38>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102537:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010253c:	85 c0                	test   %eax,%eax
8010253e:	74 10                	je     80102550 <kalloc+0x30>
    kmem.freelist = r->next;
80102540:	8b 10                	mov    (%eax),%edx
80102542:	89 15 98 26 11 80    	mov    %edx,0x80112698
80102548:	c3                   	ret    
80102549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102550:	f3 c3                	repz ret 
80102552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102558:	55                   	push   %ebp
80102559:	89 e5                	mov    %esp,%ebp
8010255b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010255e:	68 60 26 11 80       	push   $0x80112660
80102563:	e8 f8 1f 00 00       	call   80104560 <acquire>
  r = kmem.freelist;
80102568:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102576:	85 c0                	test   %eax,%eax
80102578:	74 08                	je     80102582 <kalloc+0x62>
    kmem.freelist = r->next;
8010257a:	8b 08                	mov    (%eax),%ecx
8010257c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
80102582:	85 d2                	test   %edx,%edx
80102584:	74 16                	je     8010259c <kalloc+0x7c>
    release(&kmem.lock);
80102586:	83 ec 0c             	sub    $0xc,%esp
80102589:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010258c:	68 60 26 11 80       	push   $0x80112660
80102591:	e8 8a 20 00 00       	call   80104620 <release>
  return (char*)r;
80102596:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102599:	83 c4 10             	add    $0x10,%esp
}
8010259c:	c9                   	leave  
8010259d:	c3                   	ret    
8010259e:	66 90                	xchg   %ax,%ax

801025a0 <freeMem>:
void 
freeMem()
{
  int cnt = 0;  
  struct run *r;
  r = kmem.freelist;
801025a0:	a1 98 26 11 80       	mov    0x80112698,%eax
{
801025a5:	55                   	push   %ebp
801025a6:	89 e5                	mov    %esp,%ebp
801025a8:	56                   	push   %esi
801025a9:	53                   	push   %ebx
  while((r = r->next))
801025aa:	8b 00                	mov    (%eax),%eax
801025ac:	85 c0                	test   %eax,%eax
801025ae:	74 50                	je     80102600 <freeMem+0x60>
  int cnt = 0;  
801025b0:	31 d2                	xor    %edx,%edx
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((r = r->next))
801025b8:	8b 00                	mov    (%eax),%eax
  cnt++;
801025ba:	83 c2 01             	add    $0x1,%edx
  while((r = r->next))
801025bd:	85 c0                	test   %eax,%eax
801025bf:	75 f7                	jne    801025b8 <freeMem+0x18>
801025c1:	89 d6                	mov    %edx,%esi
801025c3:	c1 e6 0c             	shl    $0xc,%esi
  //cprintf("Count is %d",cnt); 
  int total = cnt + usedMemCount;
 cprintf("Free  Used Total\n");
801025c6:	83 ec 0c             	sub    $0xc,%esp
  int total = cnt + usedMemCount;
801025c9:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
 cprintf("Free  Used Total\n");
801025cf:	68 d1 75 10 80       	push   $0x801075d1
  int total = cnt + usedMemCount;
801025d4:	01 d3                	add    %edx,%ebx
 cprintf("Free  Used Total\n");
801025d6:	e8 85 e0 ff ff       	call   80100660 <cprintf>
 cprintf("%d  %d %d \n", cnt*PGSIZE, usedMemCount*PGSIZE, total*PGSIZE);
801025db:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
801025e0:	c1 e3 0c             	shl    $0xc,%ebx
801025e3:	53                   	push   %ebx
801025e4:	c1 e0 0c             	shl    $0xc,%eax
801025e7:	50                   	push   %eax
801025e8:	56                   	push   %esi
801025e9:	68 e3 75 10 80       	push   $0x801075e3
801025ee:	e8 6d e0 ff ff       	call   80100660 <cprintf>
}
801025f3:	83 c4 20             	add    $0x20,%esp
801025f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025f9:	5b                   	pop    %ebx
801025fa:	5e                   	pop    %esi
801025fb:	5d                   	pop    %ebp
801025fc:	c3                   	ret    
801025fd:	8d 76 00             	lea    0x0(%esi),%esi
  while((r = r->next))
80102600:	31 f6                	xor    %esi,%esi
  int cnt = 0;  
80102602:	31 d2                	xor    %edx,%edx
80102604:	eb c0                	jmp    801025c6 <freeMem+0x26>
80102606:	66 90                	xchg   %ax,%ax
80102608:	66 90                	xchg   %ax,%ax
8010260a:	66 90                	xchg   %ax,%ax
8010260c:	66 90                	xchg   %ax,%ax
8010260e:	66 90                	xchg   %ax,%ax

80102610 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102610:	ba 64 00 00 00       	mov    $0x64,%edx
80102615:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102616:	a8 01                	test   $0x1,%al
80102618:	0f 84 c2 00 00 00    	je     801026e0 <kbdgetc+0xd0>
8010261e:	ba 60 00 00 00       	mov    $0x60,%edx
80102623:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102624:	0f b6 d0             	movzbl %al,%edx
80102627:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx

  if(data == 0xE0){
8010262d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102633:	0f 84 7f 00 00 00    	je     801026b8 <kbdgetc+0xa8>
{
80102639:	55                   	push   %ebp
8010263a:	89 e5                	mov    %esp,%ebp
8010263c:	53                   	push   %ebx
8010263d:	89 cb                	mov    %ecx,%ebx
8010263f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102642:	84 c0                	test   %al,%al
80102644:	78 4a                	js     80102690 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102646:	85 db                	test   %ebx,%ebx
80102648:	74 09                	je     80102653 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010264a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010264d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102650:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102653:	0f b6 82 20 77 10 80 	movzbl -0x7fef88e0(%edx),%eax
8010265a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010265c:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
80102663:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102665:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102667:	89 0d bc a5 10 80    	mov    %ecx,0x8010a5bc
  c = charcode[shift & (CTL | SHIFT)][data];
8010266d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102670:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102673:	8b 04 85 00 76 10 80 	mov    -0x7fef8a00(,%eax,4),%eax
8010267a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010267e:	74 31                	je     801026b1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102680:	8d 50 9f             	lea    -0x61(%eax),%edx
80102683:	83 fa 19             	cmp    $0x19,%edx
80102686:	77 40                	ja     801026c8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102688:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010268b:	5b                   	pop    %ebx
8010268c:	5d                   	pop    %ebp
8010268d:	c3                   	ret    
8010268e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102690:	83 e0 7f             	and    $0x7f,%eax
80102693:	85 db                	test   %ebx,%ebx
80102695:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102698:	0f b6 82 20 77 10 80 	movzbl -0x7fef88e0(%edx),%eax
8010269f:	83 c8 40             	or     $0x40,%eax
801026a2:	0f b6 c0             	movzbl %al,%eax
801026a5:	f7 d0                	not    %eax
801026a7:	21 c1                	and    %eax,%ecx
    return 0;
801026a9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026ab:	89 0d bc a5 10 80    	mov    %ecx,0x8010a5bc
}
801026b1:	5b                   	pop    %ebx
801026b2:	5d                   	pop    %ebp
801026b3:	c3                   	ret    
801026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026b8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801026bb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026bd:	89 0d bc a5 10 80    	mov    %ecx,0x8010a5bc
    return 0;
801026c3:	c3                   	ret    
801026c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026cb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026ce:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026cf:	83 f9 1a             	cmp    $0x1a,%ecx
801026d2:	0f 42 c2             	cmovb  %edx,%eax
}
801026d5:	5d                   	pop    %ebp
801026d6:	c3                   	ret    
801026d7:	89 f6                	mov    %esi,%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <kbdintr>:

void
kbdintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026f6:	68 10 26 10 80       	push   $0x80102610
801026fb:	e8 10 e1 ff ff       	call   80100810 <consoleintr>
}
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	c9                   	leave  
80102704:	c3                   	ret    
80102705:	66 90                	xchg   %ax,%ax
80102707:	66 90                	xchg   %ax,%ax
80102709:	66 90                	xchg   %ax,%ax
8010270b:	66 90                	xchg   %ax,%ax
8010270d:	66 90                	xchg   %ax,%ax
8010270f:	90                   	nop

80102710 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102710:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	0f 84 c8 00 00 00    	je     801027e8 <lapicinit+0xd8>
  lapic[index] = value;
80102720:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102727:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102734:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102737:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010273a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102741:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102744:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102747:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010274e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102751:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102754:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010275b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102761:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102768:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010276b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010276e:	8b 50 30             	mov    0x30(%eax),%edx
80102771:	c1 ea 10             	shr    $0x10,%edx
80102774:	80 fa 03             	cmp    $0x3,%dl
80102777:	77 77                	ja     801027f0 <lapicinit+0xe0>
  lapic[index] = value;
80102779:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102780:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102783:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102786:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102790:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102793:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010279a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027aa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027c4:	8b 50 20             	mov    0x20(%eax),%edx
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027d6:	80 e6 10             	and    $0x10,%dh
801027d9:	75 f5                	jne    801027d0 <lapicinit+0xc0>
  lapic[index] = value;
801027db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027e8:	5d                   	pop    %ebp
801027e9:	c3                   	ret    
801027ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	8b 50 20             	mov    0x20(%eax),%edx
801027fd:	e9 77 ff ff ff       	jmp    80102779 <lapicinit+0x69>
80102802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102810:	8b 15 9c 26 11 80    	mov    0x8011269c,%edx
{
80102816:	55                   	push   %ebp
80102817:	31 c0                	xor    %eax,%eax
80102819:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010281b:	85 d2                	test   %edx,%edx
8010281d:	74 06                	je     80102825 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010281f:	8b 42 20             	mov    0x20(%edx),%eax
80102822:	c1 e8 18             	shr    $0x18,%eax
}
80102825:	5d                   	pop    %ebp
80102826:	c3                   	ret    
80102827:	89 f6                	mov    %esi,%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102830:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0d                	je     80102849 <lapiceoi+0x19>
  lapic[index] = value;
8010283c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102843:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102846:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102849:	5d                   	pop    %ebp
8010284a:	c3                   	ret    
8010284b:	90                   	nop
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
}
80102853:	5d                   	pop    %ebp
80102854:	c3                   	ret    
80102855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102860 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102860:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102861:	b8 0f 00 00 00       	mov    $0xf,%eax
80102866:	ba 70 00 00 00       	mov    $0x70,%edx
8010286b:	89 e5                	mov    %esp,%ebp
8010286d:	53                   	push   %ebx
8010286e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102871:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102874:	ee                   	out    %al,(%dx)
80102875:	b8 0a 00 00 00       	mov    $0xa,%eax
8010287a:	ba 71 00 00 00       	mov    $0x71,%edx
8010287f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102880:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102882:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102885:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010288b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010288d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102890:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102893:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102895:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102898:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010289e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801028a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028b3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028c0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028cc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028ea:	5b                   	pop    %ebx
801028eb:	5d                   	pop    %ebp
801028ec:	c3                   	ret    
801028ed:	8d 76 00             	lea    0x0(%esi),%esi

801028f0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028f0:	55                   	push   %ebp
801028f1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028f6:	ba 70 00 00 00       	mov    $0x70,%edx
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	57                   	push   %edi
801028fe:	56                   	push   %esi
801028ff:	53                   	push   %ebx
80102900:	83 ec 4c             	sub    $0x4c,%esp
80102903:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102904:	ba 71 00 00 00       	mov    $0x71,%edx
80102909:	ec                   	in     (%dx),%al
8010290a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102912:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102915:	8d 76 00             	lea    0x0(%esi),%esi
80102918:	31 c0                	xor    %eax,%eax
8010291a:	89 da                	mov    %ebx,%edx
8010291c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102922:	89 ca                	mov    %ecx,%edx
80102924:	ec                   	in     (%dx),%al
80102925:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102928:	89 da                	mov    %ebx,%edx
8010292a:	b8 02 00 00 00       	mov    $0x2,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	b8 04 00 00 00       	mov    $0x4,%eax
8010293d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293e:	89 ca                	mov    %ecx,%edx
80102940:	ec                   	in     (%dx),%al
80102941:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102944:	89 da                	mov    %ebx,%edx
80102946:	b8 07 00 00 00       	mov    $0x7,%eax
8010294b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294c:	89 ca                	mov    %ecx,%edx
8010294e:	ec                   	in     (%dx),%al
8010294f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102952:	89 da                	mov    %ebx,%edx
80102954:	b8 08 00 00 00       	mov    $0x8,%eax
80102959:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295a:	89 ca                	mov    %ecx,%edx
8010295c:	ec                   	in     (%dx),%al
8010295d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295f:	89 da                	mov    %ebx,%edx
80102961:	b8 09 00 00 00       	mov    $0x9,%eax
80102966:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102967:	89 ca                	mov    %ecx,%edx
80102969:	ec                   	in     (%dx),%al
8010296a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296c:	89 da                	mov    %ebx,%edx
8010296e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102973:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102974:	89 ca                	mov    %ecx,%edx
80102976:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102977:	84 c0                	test   %al,%al
80102979:	78 9d                	js     80102918 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010297b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010297f:	89 fa                	mov    %edi,%edx
80102981:	0f b6 fa             	movzbl %dl,%edi
80102984:	89 f2                	mov    %esi,%edx
80102986:	0f b6 f2             	movzbl %dl,%esi
80102989:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010298c:	89 da                	mov    %ebx,%edx
8010298e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102991:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102994:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102998:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010299b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010299f:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029a2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029a9:	31 c0                	xor    %eax,%eax
801029ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ac:	89 ca                	mov    %ecx,%edx
801029ae:	ec                   	in     (%dx),%al
801029af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b2:	89 da                	mov    %ebx,%edx
801029b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029b7:	b8 02 00 00 00       	mov    $0x2,%eax
801029bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	89 ca                	mov    %ecx,%edx
801029bf:	ec                   	in     (%dx),%al
801029c0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c3:	89 da                	mov    %ebx,%edx
801029c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
801029d1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d4:	89 da                	mov    %ebx,%edx
801029d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029d9:	b8 07 00 00 00       	mov    $0x7,%eax
801029de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029df:	89 ca                	mov    %ecx,%edx
801029e1:	ec                   	in     (%dx),%al
801029e2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e5:	89 da                	mov    %ebx,%edx
801029e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ea:	b8 08 00 00 00       	mov    $0x8,%eax
801029ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f0:	89 ca                	mov    %ecx,%edx
801029f2:	ec                   	in     (%dx),%al
801029f3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029fb:	b8 09 00 00 00       	mov    $0x9,%eax
80102a00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a01:	89 ca                	mov    %ecx,%edx
80102a03:	ec                   	in     (%dx),%al
80102a04:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a07:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a10:	6a 18                	push   $0x18
80102a12:	50                   	push   %eax
80102a13:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a16:	50                   	push   %eax
80102a17:	e8 a4 1c 00 00       	call   801046c0 <memcmp>
80102a1c:	83 c4 10             	add    $0x10,%esp
80102a1f:	85 c0                	test   %eax,%eax
80102a21:	0f 85 f1 fe ff ff    	jne    80102918 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a27:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a2b:	75 78                	jne    80102aa5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a2d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a30:	89 c2                	mov    %eax,%edx
80102a32:	83 e0 0f             	and    $0xf,%eax
80102a35:	c1 ea 04             	shr    $0x4,%edx
80102a38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a41:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a44:	89 c2                	mov    %eax,%edx
80102a46:	83 e0 0f             	and    $0xf,%eax
80102a49:	c1 ea 04             	shr    $0x4,%edx
80102a4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a52:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a55:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a58:	89 c2                	mov    %eax,%edx
80102a5a:	83 e0 0f             	and    $0xf,%eax
80102a5d:	c1 ea 04             	shr    $0x4,%edx
80102a60:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a63:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a66:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a6c:	89 c2                	mov    %eax,%edx
80102a6e:	83 e0 0f             	and    $0xf,%eax
80102a71:	c1 ea 04             	shr    $0x4,%edx
80102a74:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a77:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a80:	89 c2                	mov    %eax,%edx
80102a82:	83 e0 0f             	and    $0xf,%eax
80102a85:	c1 ea 04             	shr    $0x4,%edx
80102a88:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a91:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a94:	89 c2                	mov    %eax,%edx
80102a96:	83 e0 0f             	and    $0xf,%eax
80102a99:	c1 ea 04             	shr    $0x4,%edx
80102a9c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a9f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aa2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aa5:	8b 75 08             	mov    0x8(%ebp),%esi
80102aa8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aab:	89 06                	mov    %eax,(%esi)
80102aad:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ab0:	89 46 04             	mov    %eax,0x4(%esi)
80102ab3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ab6:	89 46 08             	mov    %eax,0x8(%esi)
80102ab9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102abc:	89 46 0c             	mov    %eax,0xc(%esi)
80102abf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ac2:	89 46 10             	mov    %eax,0x10(%esi)
80102ac5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ac8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102acb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ad5:	5b                   	pop    %ebx
80102ad6:	5e                   	pop    %esi
80102ad7:	5f                   	pop    %edi
80102ad8:	5d                   	pop    %ebp
80102ad9:	c3                   	ret    
80102ada:	66 90                	xchg   %ax,%ax
80102adc:	66 90                	xchg   %ax,%ax
80102ade:	66 90                	xchg   %ax,%ax

80102ae0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ae0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ae6:	85 c9                	test   %ecx,%ecx
80102ae8:	0f 8e 8a 00 00 00    	jle    80102b78 <install_trans+0x98>
{
80102aee:	55                   	push   %ebp
80102aef:	89 e5                	mov    %esp,%ebp
80102af1:	57                   	push   %edi
80102af2:	56                   	push   %esi
80102af3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102af4:	31 db                	xor    %ebx,%ebx
{
80102af6:	83 ec 0c             	sub    $0xc,%esp
80102af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b00:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b05:	83 ec 08             	sub    $0x8,%esp
80102b08:	01 d8                	add    %ebx,%eax
80102b0a:	83 c0 01             	add    $0x1,%eax
80102b0d:	50                   	push   %eax
80102b0e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b14:	e8 b7 d5 ff ff       	call   801000d0 <bread>
80102b19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1b:	58                   	pop    %eax
80102b1c:	5a                   	pop    %edx
80102b1d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102b24:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b2d:	e8 9e d5 ff ff       	call   801000d0 <bread>
80102b32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b37:	83 c4 0c             	add    $0xc,%esp
80102b3a:	68 00 02 00 00       	push   $0x200
80102b3f:	50                   	push   %eax
80102b40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b43:	50                   	push   %eax
80102b44:	e8 d7 1b 00 00       	call   80104720 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 4f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b51:	89 3c 24             	mov    %edi,(%esp)
80102b54:	e8 87 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b59:	89 34 24             	mov    %esi,(%esp)
80102b5c:	e8 7f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b61:	83 c4 10             	add    $0x10,%esp
80102b64:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102b6a:	7f 94                	jg     80102b00 <install_trans+0x20>
  }
}
80102b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b6f:	5b                   	pop    %ebx
80102b70:	5e                   	pop    %esi
80102b71:	5f                   	pop    %edi
80102b72:	5d                   	pop    %ebp
80102b73:	c3                   	ret    
80102b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b78:	f3 c3                	repz ret 
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	56                   	push   %esi
80102b84:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b85:	83 ec 08             	sub    $0x8,%esp
80102b88:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102b8e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b94:	e8 37 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b99:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b9f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ba2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ba4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ba6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ba9:	7e 16                	jle    80102bc1 <write_head+0x41>
80102bab:	c1 e3 02             	shl    $0x2,%ebx
80102bae:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102bb0:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102bb6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102bba:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bbd:	39 da                	cmp    %ebx,%edx
80102bbf:	75 ef                	jne    80102bb0 <write_head+0x30>
  }
  bwrite(buf);
80102bc1:	83 ec 0c             	sub    $0xc,%esp
80102bc4:	56                   	push   %esi
80102bc5:	e8 d6 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bca:	89 34 24             	mov    %esi,(%esp)
80102bcd:	e8 0e d6 ff ff       	call   801001e0 <brelse>
}
80102bd2:	83 c4 10             	add    $0x10,%esp
80102bd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bd8:	5b                   	pop    %ebx
80102bd9:	5e                   	pop    %esi
80102bda:	5d                   	pop    %ebp
80102bdb:	c3                   	ret    
80102bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102be0 <initlog>:
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	53                   	push   %ebx
80102be4:	83 ec 2c             	sub    $0x2c,%esp
80102be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bea:	68 20 78 10 80       	push   $0x80107820
80102bef:	68 a0 26 11 80       	push   $0x801126a0
80102bf4:	e8 27 18 00 00       	call   80104420 <initlock>
  readsb(dev, &sb);
80102bf9:	58                   	pop    %eax
80102bfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 3b e8 ff ff       	call   80101440 <readsb>
  log.size = sb.nlog;
80102c05:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c0b:	59                   	pop    %ecx
  log.dev = dev;
80102c0c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102c12:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102c18:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102c1d:	5a                   	pop    %edx
80102c1e:	50                   	push   %eax
80102c1f:	53                   	push   %ebx
80102c20:	e8 ab d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c25:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c28:	83 c4 10             	add    $0x10,%esp
80102c2b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c2d:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102c33:	7e 1c                	jle    80102c51 <initlog+0x71>
80102c35:	c1 e3 02             	shl    $0x2,%ebx
80102c38:	31 d2                	xor    %edx,%edx
80102c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c44:	83 c2 04             	add    $0x4,%edx
80102c47:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 d3                	cmp    %edx,%ebx
80102c4f:	75 ef                	jne    80102c40 <initlog+0x60>
  brelse(buf);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	50                   	push   %eax
80102c55:	e8 86 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c5a:	e8 81 fe ff ff       	call   80102ae0 <install_trans>
  log.lh.n = 0;
80102c5f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c66:	00 00 00 
  write_head(); // clear the log
80102c69:	e8 12 ff ff ff       	call   80102b80 <write_head>
}
80102c6e:	83 c4 10             	add    $0x10,%esp
80102c71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c74:	c9                   	leave  
80102c75:	c3                   	ret    
80102c76:	8d 76 00             	lea    0x0(%esi),%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c86:	68 a0 26 11 80       	push   $0x801126a0
80102c8b:	e8 d0 18 00 00       	call   80104560 <acquire>
80102c90:	83 c4 10             	add    $0x10,%esp
80102c93:	eb 18                	jmp    80102cad <begin_op+0x2d>
80102c95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c98:	83 ec 08             	sub    $0x8,%esp
80102c9b:	68 a0 26 11 80       	push   $0x801126a0
80102ca0:	68 a0 26 11 80       	push   $0x801126a0
80102ca5:	e8 d6 11 00 00       	call   80103e80 <sleep>
80102caa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102cad:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102cb2:	85 c0                	test   %eax,%eax
80102cb4:	75 e2                	jne    80102c98 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cb6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102cbb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102cc1:	83 c0 01             	add    $0x1,%eax
80102cc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cca:	83 fa 1e             	cmp    $0x1e,%edx
80102ccd:	7f c9                	jg     80102c98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ccf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cd2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102cd7:	68 a0 26 11 80       	push   $0x801126a0
80102cdc:	e8 3f 19 00 00       	call   80104620 <release>
      break;
    }
  }
}
80102ce1:	83 c4 10             	add    $0x10,%esp
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    
80102ce6:	8d 76 00             	lea    0x0(%esi),%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	57                   	push   %edi
80102cf4:	56                   	push   %esi
80102cf5:	53                   	push   %ebx
80102cf6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cf9:	68 a0 26 11 80       	push   $0x801126a0
80102cfe:	e8 5d 18 00 00       	call   80104560 <acquire>
  log.outstanding -= 1;
80102d03:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102d08:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102d0e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d11:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d14:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d16:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102d1c:	0f 85 1a 01 00 00    	jne    80102e3c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d22:	85 db                	test   %ebx,%ebx
80102d24:	0f 85 ee 00 00 00    	jne    80102e18 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d2a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d2d:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102d34:	00 00 00 
  release(&log.lock);
80102d37:	68 a0 26 11 80       	push   $0x801126a0
80102d3c:	e8 df 18 00 00       	call   80104620 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d41:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102d47:	83 c4 10             	add    $0x10,%esp
80102d4a:	85 c9                	test   %ecx,%ecx
80102d4c:	0f 8e 85 00 00 00    	jle    80102dd7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d52:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d57:	83 ec 08             	sub    $0x8,%esp
80102d5a:	01 d8                	add    %ebx,%eax
80102d5c:	83 c0 01             	add    $0x1,%eax
80102d5f:	50                   	push   %eax
80102d60:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d66:	e8 65 d3 ff ff       	call   801000d0 <bread>
80102d6b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d6d:	58                   	pop    %eax
80102d6e:	5a                   	pop    %edx
80102d6f:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102d76:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d7f:	e8 4c d3 ff ff       	call   801000d0 <bread>
80102d84:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d86:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d89:	83 c4 0c             	add    $0xc,%esp
80102d8c:	68 00 02 00 00       	push   $0x200
80102d91:	50                   	push   %eax
80102d92:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d95:	50                   	push   %eax
80102d96:	e8 85 19 00 00       	call   80104720 <memmove>
    bwrite(to);  // write the log
80102d9b:	89 34 24             	mov    %esi,(%esp)
80102d9e:	e8 fd d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102da3:	89 3c 24             	mov    %edi,(%esp)
80102da6:	e8 35 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102dab:	89 34 24             	mov    %esi,(%esp)
80102dae:	e8 2d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102db3:	83 c4 10             	add    $0x10,%esp
80102db6:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102dbc:	7c 94                	jl     80102d52 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dbe:	e8 bd fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dc3:	e8 18 fd ff ff       	call   80102ae0 <install_trans>
    log.lh.n = 0;
80102dc8:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102dcf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dd2:	e8 a9 fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102dd7:	83 ec 0c             	sub    $0xc,%esp
80102dda:	68 a0 26 11 80       	push   $0x801126a0
80102ddf:	e8 7c 17 00 00       	call   80104560 <acquire>
    wakeup(&log);
80102de4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102deb:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102df2:	00 00 00 
    wakeup(&log);
80102df5:	e8 36 12 00 00       	call   80104030 <wakeup>
    release(&log.lock);
80102dfa:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e01:	e8 1a 18 00 00       	call   80104620 <release>
80102e06:	83 c4 10             	add    $0x10,%esp
}
80102e09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0c:	5b                   	pop    %ebx
80102e0d:	5e                   	pop    %esi
80102e0e:	5f                   	pop    %edi
80102e0f:	5d                   	pop    %ebp
80102e10:	c3                   	ret    
80102e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e18:	83 ec 0c             	sub    $0xc,%esp
80102e1b:	68 a0 26 11 80       	push   $0x801126a0
80102e20:	e8 0b 12 00 00       	call   80104030 <wakeup>
  release(&log.lock);
80102e25:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e2c:	e8 ef 17 00 00       	call   80104620 <release>
80102e31:	83 c4 10             	add    $0x10,%esp
}
80102e34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e37:	5b                   	pop    %ebx
80102e38:	5e                   	pop    %esi
80102e39:	5f                   	pop    %edi
80102e3a:	5d                   	pop    %ebp
80102e3b:	c3                   	ret    
    panic("log.committing");
80102e3c:	83 ec 0c             	sub    $0xc,%esp
80102e3f:	68 24 78 10 80       	push   $0x80107824
80102e44:	e8 47 d5 ff ff       	call   80100390 <panic>
80102e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e57:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102e5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e60:	83 fa 1d             	cmp    $0x1d,%edx
80102e63:	0f 8f 9d 00 00 00    	jg     80102f06 <log_write+0xb6>
80102e69:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102e6e:	83 e8 01             	sub    $0x1,%eax
80102e71:	39 c2                	cmp    %eax,%edx
80102e73:	0f 8d 8d 00 00 00    	jge    80102f06 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e79:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e7e:	85 c0                	test   %eax,%eax
80102e80:	0f 8e 8d 00 00 00    	jle    80102f13 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	68 a0 26 11 80       	push   $0x801126a0
80102e8e:	e8 cd 16 00 00       	call   80104560 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e93:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e99:	83 c4 10             	add    $0x10,%esp
80102e9c:	83 f9 00             	cmp    $0x0,%ecx
80102e9f:	7e 57                	jle    80102ef8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102ea4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea6:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102eac:	75 0b                	jne    80102eb9 <log_write+0x69>
80102eae:	eb 38                	jmp    80102ee8 <log_write+0x98>
80102eb0:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102eb7:	74 2f                	je     80102ee8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102eb9:	83 c0 01             	add    $0x1,%eax
80102ebc:	39 c1                	cmp    %eax,%ecx
80102ebe:	75 f0                	jne    80102eb0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ec7:	83 c0 01             	add    $0x1,%eax
80102eca:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102ecf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ed2:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102ed9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102edc:	c9                   	leave  
  release(&log.lock);
80102edd:	e9 3e 17 00 00       	jmp    80104620 <release>
80102ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ee8:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102eef:	eb de                	jmp    80102ecf <log_write+0x7f>
80102ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	8b 43 08             	mov    0x8(%ebx),%eax
80102efb:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102f00:	75 cd                	jne    80102ecf <log_write+0x7f>
80102f02:	31 c0                	xor    %eax,%eax
80102f04:	eb c1                	jmp    80102ec7 <log_write+0x77>
    panic("too big a transaction");
80102f06:	83 ec 0c             	sub    $0xc,%esp
80102f09:	68 33 78 10 80       	push   $0x80107833
80102f0e:	e8 7d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f13:	83 ec 0c             	sub    $0xc,%esp
80102f16:	68 49 78 10 80       	push   $0x80107849
80102f1b:	e8 70 d4 ff ff       	call   80100390 <panic>

80102f20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f27:	e8 74 09 00 00       	call   801038a0 <cpuid>
80102f2c:	89 c3                	mov    %eax,%ebx
80102f2e:	e8 6d 09 00 00       	call   801038a0 <cpuid>
80102f33:	83 ec 04             	sub    $0x4,%esp
80102f36:	53                   	push   %ebx
80102f37:	50                   	push   %eax
80102f38:	68 64 78 10 80       	push   $0x80107864
80102f3d:	e8 1e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 29 2c 00 00       	call   80105b70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f47:	e8 e4 08 00 00       	call   80103830 <mycpu>
80102f4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f5a:	e8 21 0c 00 00       	call   80103b80 <scheduler>
80102f5f:	90                   	nop

80102f60 <mpenter>:
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f66:	e8 f5 3c 00 00       	call   80106c60 <switchkvm>
  seginit();
80102f6b:	e8 60 3c 00 00       	call   80106bd0 <seginit>
  lapicinit();
80102f70:	e8 9b f7 ff ff       	call   80102710 <lapicinit>
  mpmain();
80102f75:	e8 a6 ff ff ff       	call   80102f20 <mpmain>
80102f7a:	66 90                	xchg   %ax,%ax
80102f7c:	66 90                	xchg   %ax,%ax
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <main>:
{
80102f80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f84:	83 e4 f0             	and    $0xfffffff0,%esp
80102f87:	ff 71 fc             	pushl  -0x4(%ecx)
80102f8a:	55                   	push   %ebp
80102f8b:	89 e5                	mov    %esp,%ebp
80102f8d:	53                   	push   %ebx
80102f8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 00 40 80       	push   $0x80400000
80102f97:	68 a8 51 11 80       	push   $0x801151a8
80102f9c:	e8 6f f4 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102fa1:	e8 8a 41 00 00       	call   80107130 <kvmalloc>
  mpinit();        // detect other processors
80102fa6:	e8 75 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102fab:	e8 60 f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb0:	e8 1b 3c 00 00       	call   80106bd0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 46 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 61 f2 ff ff       	call   80102220 <ioapicinit>
  consoleinit();   // console hardware
80102fbf:	e8 fc d9 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102fc4:	e8 d7 2e 00 00       	call   80105ea0 <uartinit>
  pinit();         // process table
80102fc9:	e8 42 08 00 00       	call   80103810 <pinit>
  tvinit();        // trap vectors
80102fce:	e8 1d 2b 00 00       	call   80105af0 <tvinit>
  binit();         // buffer cache
80102fd3:	e8 68 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fd8:	e8 83 dd ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102fdd:	e8 1e f0 ff ff       	call   80102000 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe2:	83 c4 0c             	add    $0xc,%esp
80102fe5:	68 8a 00 00 00       	push   $0x8a
80102fea:	68 8c a4 10 80       	push   $0x8010a48c
80102fef:	68 00 70 00 80       	push   $0x80007000
80102ff4:	e8 27 17 00 00       	call   80104720 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ff9:	69 05 00 29 11 80 b0 	imul   $0xb0,0x80112900,%eax
80103000:	00 00 00 
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010300b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103010:	76 71                	jbe    80103083 <main+0x103>
80103012:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103017:	89 f6                	mov    %esi,%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103020:	e8 0b 08 00 00       	call   80103830 <mycpu>
80103025:	39 d8                	cmp    %ebx,%eax
80103027:	74 41                	je     8010306a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103029:	e8 f2 f4 ff ff       	call   80102520 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103033:	c7 05 f8 6f 00 80 60 	movl   $0x80102f60,0x80006ff8
8010303a:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010303d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103044:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103047:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010304c:	0f b6 03             	movzbl (%ebx),%eax
8010304f:	83 ec 08             	sub    $0x8,%esp
80103052:	68 00 70 00 00       	push   $0x7000
80103057:	50                   	push   %eax
80103058:	e8 03 f8 ff ff       	call   80102860 <lapicstartap>
8010305d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103060:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103066:	85 c0                	test   %eax,%eax
80103068:	74 f6                	je     80103060 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010306a:	69 05 00 29 11 80 b0 	imul   $0xb0,0x80112900,%eax
80103071:	00 00 00 
80103074:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010307a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010307f:	39 c3                	cmp    %eax,%ebx
80103081:	72 9d                	jb     80103020 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103083:	83 ec 08             	sub    $0x8,%esp
80103086:	68 00 00 00 8e       	push   $0x8e000000
8010308b:	68 00 00 40 80       	push   $0x80400000
80103090:	e8 0b f4 ff ff       	call   801024a0 <kinit2>
  userinit();      // first user process
80103095:	e8 56 08 00 00       	call   801038f0 <userinit>
  mpmain();        // finish this processor's setup
8010309a:	e8 81 fe ff ff       	call   80102f20 <mpmain>
8010309f:	90                   	nop

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030ab:	53                   	push   %ebx
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	72 10                	jb     801030c6 <mpsearch1+0x26>
801030b6:	eb 50                	jmp    80103108 <mpsearch1+0x68>
801030b8:	90                   	nop
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030c0:	39 fb                	cmp    %edi,%ebx
801030c2:	89 fe                	mov    %edi,%esi
801030c4:	76 42                	jbe    80103108 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c6:	83 ec 04             	sub    $0x4,%esp
801030c9:	8d 7e 10             	lea    0x10(%esi),%edi
801030cc:	6a 04                	push   $0x4
801030ce:	68 78 78 10 80       	push   $0x80107878
801030d3:	56                   	push   %esi
801030d4:	e8 e7 15 00 00       	call   801046c0 <memcmp>
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	85 c0                	test   %eax,%eax
801030de:	75 e0                	jne    801030c0 <mpsearch1+0x20>
801030e0:	89 f1                	mov    %esi,%ecx
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030e8:	0f b6 11             	movzbl (%ecx),%edx
801030eb:	83 c1 01             	add    $0x1,%ecx
801030ee:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030f0:	39 f9                	cmp    %edi,%ecx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c0                	test   %al,%al
801030f6:	75 c8                	jne    801030c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030fb:	89 f0                	mov    %esi,%eax
801030fd:	5b                   	pop    %ebx
801030fe:	5e                   	pop    %esi
801030ff:	5f                   	pop    %edi
80103100:	5d                   	pop    %ebp
80103101:	c3                   	ret    
80103102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010310b:	31 f6                	xor    %esi,%esi
}
8010310d:	89 f0                	mov    %esi,%eax
8010310f:	5b                   	pop    %ebx
80103110:	5e                   	pop    %esi
80103111:	5f                   	pop    %edi
80103112:	5d                   	pop    %ebp
80103113:	c3                   	ret    
80103114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010311a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010316d:	0f 84 3d 01 00 00    	je     801032b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103173:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103176:	8b 58 04             	mov    0x4(%eax),%ebx
80103179:	85 db                	test   %ebx,%ebx
8010317b:	0f 84 4f 01 00 00    	je     801032d0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103181:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103187:	83 ec 04             	sub    $0x4,%esp
8010318a:	6a 04                	push   $0x4
8010318c:	68 95 78 10 80       	push   $0x80107895
80103191:	56                   	push   %esi
80103192:	e8 29 15 00 00       	call   801046c0 <memcmp>
80103197:	83 c4 10             	add    $0x10,%esp
8010319a:	85 c0                	test   %eax,%eax
8010319c:	0f 85 2e 01 00 00    	jne    801032d0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801031a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031a9:	3c 01                	cmp    $0x1,%al
801031ab:	0f 95 c2             	setne  %dl
801031ae:	3c 04                	cmp    $0x4,%al
801031b0:	0f 95 c0             	setne  %al
801031b3:	20 c2                	and    %al,%dl
801031b5:	0f 85 15 01 00 00    	jne    801032d0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801031bb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801031c2:	66 85 ff             	test   %di,%di
801031c5:	74 1a                	je     801031e1 <mpinit+0xc1>
801031c7:	89 f0                	mov    %esi,%eax
801031c9:	01 f7                	add    %esi,%edi
  sum = 0;
801031cb:	31 d2                	xor    %edx,%edx
801031cd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031d0:	0f b6 08             	movzbl (%eax),%ecx
801031d3:	83 c0 01             	add    $0x1,%eax
801031d6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031d8:	39 c7                	cmp    %eax,%edi
801031da:	75 f4                	jne    801031d0 <mpinit+0xb0>
801031dc:	84 d2                	test   %dl,%dl
801031de:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031e1:	85 f6                	test   %esi,%esi
801031e3:	0f 84 e7 00 00 00    	je     801032d0 <mpinit+0x1b0>
801031e9:	84 d2                	test   %dl,%dl
801031eb:	0f 85 df 00 00 00    	jne    801032d0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031f1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031f7:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fc:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103203:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103209:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010320e:	01 d6                	add    %edx,%esi
80103210:	39 c6                	cmp    %eax,%esi
80103212:	76 23                	jbe    80103237 <mpinit+0x117>
    switch(*p){
80103214:	0f b6 10             	movzbl (%eax),%edx
80103217:	80 fa 04             	cmp    $0x4,%dl
8010321a:	0f 87 ca 00 00 00    	ja     801032ea <mpinit+0x1ca>
80103220:	ff 24 95 bc 78 10 80 	jmp    *-0x7fef8744(,%edx,4)
80103227:	89 f6                	mov    %esi,%esi
80103229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103230:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103233:	39 c6                	cmp    %eax,%esi
80103235:	77 dd                	ja     80103214 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103237:	85 db                	test   %ebx,%ebx
80103239:	0f 84 9e 00 00 00    	je     801032dd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010323f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103242:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103246:	74 15                	je     8010325d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103248:	b8 70 00 00 00       	mov    $0x70,%eax
8010324d:	ba 22 00 00 00       	mov    $0x22,%edx
80103252:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103253:	ba 23 00 00 00       	mov    $0x23,%edx
80103258:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103259:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010325c:	ee                   	out    %al,(%dx)
  }
}
8010325d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103260:	5b                   	pop    %ebx
80103261:	5e                   	pop    %esi
80103262:	5f                   	pop    %edi
80103263:	5d                   	pop    %ebp
80103264:	c3                   	ret    
80103265:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103268:	8b 0d 00 29 11 80    	mov    0x80112900,%ecx
8010326e:	83 f9 01             	cmp    $0x1,%ecx
80103271:	7f 19                	jg     8010328c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103273:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103277:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010327d:	83 c1 01             	add    $0x1,%ecx
80103280:	89 0d 00 29 11 80    	mov    %ecx,0x80112900
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103286:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
8010328c:	83 c0 14             	add    $0x14,%eax
      continue;
8010328f:	e9 7c ff ff ff       	jmp    80103210 <mpinit+0xf0>
80103294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103298:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010329c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010329f:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
801032a5:	e9 66 ff ff ff       	jmp    80103210 <mpinit+0xf0>
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801032b0:	ba 00 00 01 00       	mov    $0x10000,%edx
801032b5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032ba:	e8 e1 fd ff ff       	call   801030a0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032bf:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032c4:	0f 85 a9 fe ff ff    	jne    80103173 <mpinit+0x53>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801032d0:	83 ec 0c             	sub    $0xc,%esp
801032d3:	68 7d 78 10 80       	push   $0x8010787d
801032d8:	e8 b3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032dd:	83 ec 0c             	sub    $0xc,%esp
801032e0:	68 9c 78 10 80       	push   $0x8010789c
801032e5:	e8 a6 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
801032ea:	31 db                	xor    %ebx,%ebx
801032ec:	e9 26 ff ff ff       	jmp    80103217 <mpinit+0xf7>
801032f1:	66 90                	xchg   %ax,%ax
801032f3:	66 90                	xchg   %ax,%ax
801032f5:	66 90                	xchg   %ax,%ax
801032f7:	66 90                	xchg   %ax,%ax
801032f9:	66 90                	xchg   %ax,%ax
801032fb:	66 90                	xchg   %ax,%ax
801032fd:	66 90                	xchg   %ax,%ax
801032ff:	90                   	nop

80103300 <picinit>:
80103300:	55                   	push   %ebp
80103301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103306:	ba 21 00 00 00       	mov    $0x21,%edx
8010330b:	89 e5                	mov    %esp,%ebp
8010330d:	ee                   	out    %al,(%dx)
8010330e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103313:	ee                   	out    %al,(%dx)
80103314:	5d                   	pop    %ebp
80103315:	c3                   	ret    
80103316:	66 90                	xchg   %ax,%ax
80103318:	66 90                	xchg   %ax,%ax
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 0c             	sub    $0xc,%esp
80103329:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010332c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010332f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103335:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010333b:	e8 40 da ff ff       	call   80100d80 <filealloc>
80103340:	85 c0                	test   %eax,%eax
80103342:	89 03                	mov    %eax,(%ebx)
80103344:	74 22                	je     80103368 <pipealloc+0x48>
80103346:	e8 35 da ff ff       	call   80100d80 <filealloc>
8010334b:	85 c0                	test   %eax,%eax
8010334d:	89 06                	mov    %eax,(%esi)
8010334f:	74 3f                	je     80103390 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103351:	e8 ca f1 ff ff       	call   80102520 <kalloc>
80103356:	85 c0                	test   %eax,%eax
80103358:	89 c7                	mov    %eax,%edi
8010335a:	75 54                	jne    801033b0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010335c:	8b 03                	mov    (%ebx),%eax
8010335e:	85 c0                	test   %eax,%eax
80103360:	75 34                	jne    80103396 <pipealloc+0x76>
80103362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103368:	8b 06                	mov    (%esi),%eax
8010336a:	85 c0                	test   %eax,%eax
8010336c:	74 0c                	je     8010337a <pipealloc+0x5a>
    fileclose(*f1);
8010336e:	83 ec 0c             	sub    $0xc,%esp
80103371:	50                   	push   %eax
80103372:	e8 c9 da ff ff       	call   80100e40 <fileclose>
80103377:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010337a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010337d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103382:	5b                   	pop    %ebx
80103383:	5e                   	pop    %esi
80103384:	5f                   	pop    %edi
80103385:	5d                   	pop    %ebp
80103386:	c3                   	ret    
80103387:	89 f6                	mov    %esi,%esi
80103389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103390:	8b 03                	mov    (%ebx),%eax
80103392:	85 c0                	test   %eax,%eax
80103394:	74 e4                	je     8010337a <pipealloc+0x5a>
    fileclose(*f0);
80103396:	83 ec 0c             	sub    $0xc,%esp
80103399:	50                   	push   %eax
8010339a:	e8 a1 da ff ff       	call   80100e40 <fileclose>
  if(*f1)
8010339f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801033a1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033a4:	85 c0                	test   %eax,%eax
801033a6:	75 c6                	jne    8010336e <pipealloc+0x4e>
801033a8:	eb d0                	jmp    8010337a <pipealloc+0x5a>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801033b0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801033b3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033ba:	00 00 00 
  p->writeopen = 1;
801033bd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033c4:	00 00 00 
  p->nwrite = 0;
801033c7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033ce:	00 00 00 
  p->nread = 0;
801033d1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033d8:	00 00 00 
  initlock(&p->lock, "pipe");
801033db:	68 d0 78 10 80       	push   $0x801078d0
801033e0:	50                   	push   %eax
801033e1:	e8 3a 10 00 00       	call   80104420 <initlock>
  (*f0)->type = FD_PIPE;
801033e6:	8b 03                	mov    (%ebx),%eax
  return 0;
801033e8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033eb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033f1:	8b 03                	mov    (%ebx),%eax
801033f3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033f7:	8b 03                	mov    (%ebx),%eax
801033f9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033fd:	8b 03                	mov    (%ebx),%eax
801033ff:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103402:	8b 06                	mov    (%esi),%eax
80103404:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010340a:	8b 06                	mov    (%esi),%eax
8010340c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103410:	8b 06                	mov    (%esi),%eax
80103412:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103416:	8b 06                	mov    (%esi),%eax
80103418:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010341b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010341e:	31 c0                	xor    %eax,%eax
}
80103420:	5b                   	pop    %ebx
80103421:	5e                   	pop    %esi
80103422:	5f                   	pop    %edi
80103423:	5d                   	pop    %ebp
80103424:	c3                   	ret    
80103425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103430 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	56                   	push   %esi
80103434:	53                   	push   %ebx
80103435:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103438:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010343b:	83 ec 0c             	sub    $0xc,%esp
8010343e:	53                   	push   %ebx
8010343f:	e8 1c 11 00 00       	call   80104560 <acquire>
  if(writable){
80103444:	83 c4 10             	add    $0x10,%esp
80103447:	85 f6                	test   %esi,%esi
80103449:	74 45                	je     80103490 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010344b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103451:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103454:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010345b:	00 00 00 
    wakeup(&p->nread);
8010345e:	50                   	push   %eax
8010345f:	e8 cc 0b 00 00       	call   80104030 <wakeup>
80103464:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103467:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010346d:	85 d2                	test   %edx,%edx
8010346f:	75 0a                	jne    8010347b <pipeclose+0x4b>
80103471:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103477:	85 c0                	test   %eax,%eax
80103479:	74 35                	je     801034b0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010347b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010347e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103481:	5b                   	pop    %ebx
80103482:	5e                   	pop    %esi
80103483:	5d                   	pop    %ebp
    release(&p->lock);
80103484:	e9 97 11 00 00       	jmp    80104620 <release>
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103490:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103496:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103499:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034a0:	00 00 00 
    wakeup(&p->nwrite);
801034a3:	50                   	push   %eax
801034a4:	e8 87 0b 00 00       	call   80104030 <wakeup>
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	eb b9                	jmp    80103467 <pipeclose+0x37>
801034ae:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 67 11 00 00       	call   80104620 <release>
    kfree((char*)p);
801034b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034bc:	83 c4 10             	add    $0x10,%esp
}
801034bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034c2:	5b                   	pop    %ebx
801034c3:	5e                   	pop    %esi
801034c4:	5d                   	pop    %ebp
    kfree((char*)p);
801034c5:	e9 46 ee ff ff       	jmp    80102310 <kfree>
801034ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	57                   	push   %edi
801034d4:	56                   	push   %esi
801034d5:	53                   	push   %ebx
801034d6:	83 ec 28             	sub    $0x28,%esp
801034d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034dc:	53                   	push   %ebx
801034dd:	e8 7e 10 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++){
801034e2:	8b 45 10             	mov    0x10(%ebp),%eax
801034e5:	83 c4 10             	add    $0x10,%esp
801034e8:	85 c0                	test   %eax,%eax
801034ea:	0f 8e c9 00 00 00    	jle    801035b9 <pipewrite+0xe9>
801034f0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034f3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034ff:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103502:	03 4d 10             	add    0x10(%ebp),%ecx
80103505:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103508:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010350e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103514:	39 d0                	cmp    %edx,%eax
80103516:	75 71                	jne    80103589 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103518:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010351e:	85 c0                	test   %eax,%eax
80103520:	74 4e                	je     80103570 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103522:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103528:	eb 3a                	jmp    80103564 <pipewrite+0x94>
8010352a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103530:	83 ec 0c             	sub    $0xc,%esp
80103533:	57                   	push   %edi
80103534:	e8 f7 0a 00 00       	call   80104030 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103539:	5a                   	pop    %edx
8010353a:	59                   	pop    %ecx
8010353b:	53                   	push   %ebx
8010353c:	56                   	push   %esi
8010353d:	e8 3e 09 00 00       	call   80103e80 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103542:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103548:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010354e:	83 c4 10             	add    $0x10,%esp
80103551:	05 00 02 00 00       	add    $0x200,%eax
80103556:	39 c2                	cmp    %eax,%edx
80103558:	75 36                	jne    80103590 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010355a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103560:	85 c0                	test   %eax,%eax
80103562:	74 0c                	je     80103570 <pipewrite+0xa0>
80103564:	e8 57 03 00 00       	call   801038c0 <myproc>
80103569:	8b 40 24             	mov    0x24(%eax),%eax
8010356c:	85 c0                	test   %eax,%eax
8010356e:	74 c0                	je     80103530 <pipewrite+0x60>
        release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 a7 10 00 00       	call   80104620 <release>
        return -1;
80103579:	83 c4 10             	add    $0x10,%esp
8010357c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103584:	5b                   	pop    %ebx
80103585:	5e                   	pop    %esi
80103586:	5f                   	pop    %edi
80103587:	5d                   	pop    %ebp
80103588:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103589:	89 c2                	mov    %eax,%edx
8010358b:	90                   	nop
8010358c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103590:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103593:	8d 42 01             	lea    0x1(%edx),%eax
80103596:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010359c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801035a2:	83 c6 01             	add    $0x1,%esi
801035a5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801035a9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801035ac:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035af:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035b3:	0f 85 4f ff ff ff    	jne    80103508 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035b9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035bf:	83 ec 0c             	sub    $0xc,%esp
801035c2:	50                   	push   %eax
801035c3:	e8 68 0a 00 00       	call   80104030 <wakeup>
  release(&p->lock);
801035c8:	89 1c 24             	mov    %ebx,(%esp)
801035cb:	e8 50 10 00 00       	call   80104620 <release>
  return n;
801035d0:	83 c4 10             	add    $0x10,%esp
801035d3:	8b 45 10             	mov    0x10(%ebp),%eax
801035d6:	eb a9                	jmp    80103581 <pipewrite+0xb1>
801035d8:	90                   	nop
801035d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	57                   	push   %edi
801035e4:	56                   	push   %esi
801035e5:	53                   	push   %ebx
801035e6:	83 ec 18             	sub    $0x18,%esp
801035e9:	8b 75 08             	mov    0x8(%ebp),%esi
801035ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035ef:	56                   	push   %esi
801035f0:	e8 6b 0f 00 00       	call   80104560 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035f5:	83 c4 10             	add    $0x10,%esp
801035f8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035fe:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103604:	75 6a                	jne    80103670 <piperead+0x90>
80103606:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010360c:	85 db                	test   %ebx,%ebx
8010360e:	0f 84 c4 00 00 00    	je     801036d8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103614:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010361a:	eb 2d                	jmp    80103649 <piperead+0x69>
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103620:	83 ec 08             	sub    $0x8,%esp
80103623:	56                   	push   %esi
80103624:	53                   	push   %ebx
80103625:	e8 56 08 00 00       	call   80103e80 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010362a:	83 c4 10             	add    $0x10,%esp
8010362d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103633:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103639:	75 35                	jne    80103670 <piperead+0x90>
8010363b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103641:	85 d2                	test   %edx,%edx
80103643:	0f 84 8f 00 00 00    	je     801036d8 <piperead+0xf8>
    if(myproc()->killed){
80103649:	e8 72 02 00 00       	call   801038c0 <myproc>
8010364e:	8b 48 24             	mov    0x24(%eax),%ecx
80103651:	85 c9                	test   %ecx,%ecx
80103653:	74 cb                	je     80103620 <piperead+0x40>
      release(&p->lock);
80103655:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103658:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010365d:	56                   	push   %esi
8010365e:	e8 bd 0f 00 00       	call   80104620 <release>
      return -1;
80103663:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103666:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103669:	89 d8                	mov    %ebx,%eax
8010366b:	5b                   	pop    %ebx
8010366c:	5e                   	pop    %esi
8010366d:	5f                   	pop    %edi
8010366e:	5d                   	pop    %ebp
8010366f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103670:	8b 45 10             	mov    0x10(%ebp),%eax
80103673:	85 c0                	test   %eax,%eax
80103675:	7e 61                	jle    801036d8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103677:	31 db                	xor    %ebx,%ebx
80103679:	eb 13                	jmp    8010368e <piperead+0xae>
8010367b:	90                   	nop
8010367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103680:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103686:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010368c:	74 1f                	je     801036ad <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010368e:	8d 41 01             	lea    0x1(%ecx),%eax
80103691:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103697:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010369d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801036a2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036a5:	83 c3 01             	add    $0x1,%ebx
801036a8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801036ab:	75 d3                	jne    80103680 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036ad:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036b3:	83 ec 0c             	sub    $0xc,%esp
801036b6:	50                   	push   %eax
801036b7:	e8 74 09 00 00       	call   80104030 <wakeup>
  release(&p->lock);
801036bc:	89 34 24             	mov    %esi,(%esp)
801036bf:	e8 5c 0f 00 00       	call   80104620 <release>
  return i;
801036c4:	83 c4 10             	add    $0x10,%esp
}
801036c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ca:	89 d8                	mov    %ebx,%eax
801036cc:	5b                   	pop    %ebx
801036cd:	5e                   	pop    %esi
801036ce:	5f                   	pop    %edi
801036cf:	5d                   	pop    %ebp
801036d0:	c3                   	ret    
801036d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d8:	31 db                	xor    %ebx,%ebx
801036da:	eb d1                	jmp    801036ad <piperead+0xcd>
801036dc:	66 90                	xchg   %ax,%ax
801036de:	66 90                	xchg   %ax,%ax

801036e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e4:	bb 54 29 11 80       	mov    $0x80112954,%ebx
{
801036e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801036ec:	68 20 29 11 80       	push   $0x80112920
801036f1:	e8 6a 0e 00 00       	call   80104560 <acquire>
801036f6:	83 c4 10             	add    $0x10,%esp
801036f9:	eb 14                	jmp    8010370f <allocproc+0x2f>
801036fb:	90                   	nop
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103700:	83 eb 80             	sub    $0xffffff80,%ebx
80103703:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
80103709:	0f 83 89 00 00 00    	jae    80103798 <allocproc+0xb8>
    if(p->state == UNUSED)
8010370f:	8b 43 0c             	mov    0xc(%ebx),%eax
80103712:	85 c0                	test   %eax,%eax
80103714:	75 ea                	jne    80103700 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103716:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->priority = 10;
  release(&ptable.lock);
8010371b:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010371e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;
80103725:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
8010372c:	8d 50 01             	lea    0x1(%eax),%edx
8010372f:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103732:	68 20 29 11 80       	push   $0x80112920
  p->pid = nextpid++;
80103737:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
8010373d:	e8 de 0e 00 00       	call   80104620 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103742:	e8 d9 ed ff ff       	call   80102520 <kalloc>
80103747:	83 c4 10             	add    $0x10,%esp
8010374a:	85 c0                	test   %eax,%eax
8010374c:	89 43 08             	mov    %eax,0x8(%ebx)
8010374f:	74 60                	je     801037b1 <allocproc+0xd1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103751:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103757:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010375a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010375f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103762:	c7 40 14 e1 5a 10 80 	movl   $0x80105ae1,0x14(%eax)
  p->context = (struct context*)sp;
80103769:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010376c:	6a 14                	push   $0x14
8010376e:	6a 00                	push   $0x0
80103770:	50                   	push   %eax
80103771:	e8 fa 0e 00 00       	call   80104670 <memset>
  p->context->eip = (uint)forkret;
80103776:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->priority = 5; //default priority

  return p;
80103779:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010377c:	c7 40 10 c0 37 10 80 	movl   $0x801037c0,0x10(%eax)
  p->priority = 5; //default priority
80103783:	c7 43 7c 05 00 00 00 	movl   $0x5,0x7c(%ebx)
}
8010378a:	89 d8                	mov    %ebx,%eax
8010378c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010378f:	c9                   	leave  
80103790:	c3                   	ret    
80103791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103798:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010379b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010379d:	68 20 29 11 80       	push   $0x80112920
801037a2:	e8 79 0e 00 00       	call   80104620 <release>
}
801037a7:	89 d8                	mov    %ebx,%eax
  return 0;
801037a9:	83 c4 10             	add    $0x10,%esp
}
801037ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037af:	c9                   	leave  
801037b0:	c3                   	ret    
    p->state = UNUSED;
801037b1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037b8:	31 db                	xor    %ebx,%ebx
801037ba:	eb ce                	jmp    8010378a <allocproc+0xaa>
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037c6:	68 20 29 11 80       	push   $0x80112920
801037cb:	e8 50 0e 00 00       	call   80104620 <release>

  if (first) {
801037d0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	85 c0                	test   %eax,%eax
801037da:	75 04                	jne    801037e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037dc:	c9                   	leave  
801037dd:	c3                   	ret    
801037de:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801037e0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801037e3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037ea:	00 00 00 
    iinit(ROOTDEV);
801037ed:	6a 01                	push   $0x1
801037ef:	e8 8c dc ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
801037f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037fb:	e8 e0 f3 ff ff       	call   80102be0 <initlog>
80103800:	83 c4 10             	add    $0x10,%esp
}
80103803:	c9                   	leave  
80103804:	c3                   	ret    
80103805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <pinit>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103816:	68 d5 78 10 80       	push   $0x801078d5
8010381b:	68 20 29 11 80       	push   $0x80112920
80103820:	e8 fb 0b 00 00       	call   80104420 <initlock>
}
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	c9                   	leave  
80103829:	c3                   	ret    
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103830 <mycpu>:
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103836:	9c                   	pushf  
80103837:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103838:	f6 c4 02             	test   $0x2,%ah
8010383b:	75 4a                	jne    80103887 <mycpu+0x57>
  apicid = lapicid();
8010383d:	e8 ce ef ff ff       	call   80102810 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103842:	8b 15 00 29 11 80    	mov    0x80112900,%edx
80103848:	85 d2                	test   %edx,%edx
8010384a:	7e 1b                	jle    80103867 <mycpu+0x37>
    if (cpus[i].apicid == apicid)
8010384c:	0f b6 0d a0 27 11 80 	movzbl 0x801127a0,%ecx
80103853:	39 c8                	cmp    %ecx,%eax
80103855:	74 21                	je     80103878 <mycpu+0x48>
  for (i = 0; i < ncpu; ++i) {
80103857:	83 fa 01             	cmp    $0x1,%edx
8010385a:	74 0b                	je     80103867 <mycpu+0x37>
    if (cpus[i].apicid == apicid)
8010385c:	0f b6 15 50 28 11 80 	movzbl 0x80112850,%edx
80103863:	39 d0                	cmp    %edx,%eax
80103865:	74 19                	je     80103880 <mycpu+0x50>
  panic("unknown apicid\n");
80103867:	83 ec 0c             	sub    $0xc,%esp
8010386a:	68 dc 78 10 80       	push   $0x801078dc
8010386f:	e8 1c cb ff ff       	call   80100390 <panic>
80103874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (cpus[i].apicid == apicid)
80103878:	b8 a0 27 11 80       	mov    $0x801127a0,%eax
}
8010387d:	c9                   	leave  
8010387e:	c3                   	ret    
8010387f:	90                   	nop
    if (cpus[i].apicid == apicid)
80103880:	b8 50 28 11 80       	mov    $0x80112850,%eax
}
80103885:	c9                   	leave  
80103886:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
80103887:	83 ec 0c             	sub    $0xc,%esp
8010388a:	68 04 7a 10 80       	push   $0x80107a04
8010388f:	e8 fc ca ff ff       	call   80100390 <panic>
80103894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010389a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038a0 <cpuid>:
cpuid() {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038a6:	e8 85 ff ff ff       	call   80103830 <mycpu>
801038ab:	2d a0 27 11 80       	sub    $0x801127a0,%eax
}
801038b0:	c9                   	leave  
  return mycpu()-cpus;
801038b1:	c1 f8 04             	sar    $0x4,%eax
801038b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038ba:	c3                   	ret    
801038bb:	90                   	nop
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038c0 <myproc>:
myproc(void) {
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	53                   	push   %ebx
801038c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038c7:	e8 c4 0b 00 00       	call   80104490 <pushcli>
  c = mycpu();
801038cc:	e8 5f ff ff ff       	call   80103830 <mycpu>
  p = c->proc;
801038d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038d7:	e8 f4 0b 00 00       	call   801044d0 <popcli>
}
801038dc:	83 c4 04             	add    $0x4,%esp
801038df:	89 d8                	mov    %ebx,%eax
801038e1:	5b                   	pop    %ebx
801038e2:	5d                   	pop    %ebp
801038e3:	c3                   	ret    
801038e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038f0 <userinit>:
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038f7:	e8 e4 fd ff ff       	call   801036e0 <allocproc>
801038fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038fe:	a3 c0 a5 10 80       	mov    %eax,0x8010a5c0
  if((p->pgdir = setupkvm()) == 0)
80103903:	e8 a8 37 00 00       	call   801070b0 <setupkvm>
80103908:	85 c0                	test   %eax,%eax
8010390a:	89 43 04             	mov    %eax,0x4(%ebx)
8010390d:	0f 84 bd 00 00 00    	je     801039d0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103913:	83 ec 04             	sub    $0x4,%esp
80103916:	68 2c 00 00 00       	push   $0x2c
8010391b:	68 60 a4 10 80       	push   $0x8010a460
80103920:	50                   	push   %eax
80103921:	e8 6a 34 00 00       	call   80106d90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103926:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103929:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010392f:	6a 4c                	push   $0x4c
80103931:	6a 00                	push   $0x0
80103933:	ff 73 18             	pushl  0x18(%ebx)
80103936:	e8 35 0d 00 00       	call   80104670 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	8b 43 18             	mov    0x18(%ebx),%eax
8010393e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103943:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103948:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010394b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010394f:	8b 43 18             	mov    0x18(%ebx),%eax
80103952:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010395d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103961:	8b 43 18             	mov    0x18(%ebx),%eax
80103964:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103968:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010396c:	8b 43 18             	mov    0x18(%ebx),%eax
8010396f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103976:	8b 43 18             	mov    0x18(%ebx),%eax
80103979:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103980:	8b 43 18             	mov    0x18(%ebx),%eax
80103983:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010398a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010398d:	6a 10                	push   $0x10
8010398f:	68 05 79 10 80       	push   $0x80107905
80103994:	50                   	push   %eax
80103995:	e8 b6 0e 00 00       	call   80104850 <safestrcpy>
  p->cwd = namei("/");
8010399a:	c7 04 24 0e 79 10 80 	movl   $0x8010790e,(%esp)
801039a1:	e8 3a e5 ff ff       	call   80101ee0 <namei>
801039a6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801039a9:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
801039b0:	e8 ab 0b 00 00       	call   80104560 <acquire>
  p->state = RUNNABLE;
801039b5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039bc:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
801039c3:	e8 58 0c 00 00       	call   80104620 <release>
}
801039c8:	83 c4 10             	add    $0x10,%esp
801039cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ce:	c9                   	leave  
801039cf:	c3                   	ret    
    panic("userinit: out of memory?");
801039d0:	83 ec 0c             	sub    $0xc,%esp
801039d3:	68 ec 78 10 80       	push   $0x801078ec
801039d8:	e8 b3 c9 ff ff       	call   80100390 <panic>
801039dd:	8d 76 00             	lea    0x0(%esi),%esi

801039e0 <growproc>:
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	56                   	push   %esi
801039e4:	53                   	push   %ebx
801039e5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039e8:	e8 a3 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
801039ed:	e8 3e fe ff ff       	call   80103830 <mycpu>
  p = c->proc;
801039f2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039f8:	e8 d3 0a 00 00       	call   801044d0 <popcli>
  if(n > 0){
801039fd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a00:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a02:	7f 1c                	jg     80103a20 <growproc+0x40>
  } else if(n < 0){
80103a04:	75 3a                	jne    80103a40 <growproc+0x60>
  switchuvm(curproc);
80103a06:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a09:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a0b:	53                   	push   %ebx
80103a0c:	e8 6f 32 00 00       	call   80106c80 <switchuvm>
  return 0;
80103a11:	83 c4 10             	add    $0x10,%esp
80103a14:	31 c0                	xor    %eax,%eax
}
80103a16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a19:	5b                   	pop    %ebx
80103a1a:	5e                   	pop    %esi
80103a1b:	5d                   	pop    %ebp
80103a1c:	c3                   	ret    
80103a1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a20:	83 ec 04             	sub    $0x4,%esp
80103a23:	01 c6                	add    %eax,%esi
80103a25:	56                   	push   %esi
80103a26:	50                   	push   %eax
80103a27:	ff 73 04             	pushl  0x4(%ebx)
80103a2a:	e8 a1 34 00 00       	call   80106ed0 <allocuvm>
80103a2f:	83 c4 10             	add    $0x10,%esp
80103a32:	85 c0                	test   %eax,%eax
80103a34:	75 d0                	jne    80103a06 <growproc+0x26>
      return -1;
80103a36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a3b:	eb d9                	jmp    80103a16 <growproc+0x36>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a40:	83 ec 04             	sub    $0x4,%esp
80103a43:	01 c6                	add    %eax,%esi
80103a45:	56                   	push   %esi
80103a46:	50                   	push   %eax
80103a47:	ff 73 04             	pushl  0x4(%ebx)
80103a4a:	e8 b1 35 00 00       	call   80107000 <deallocuvm>
80103a4f:	83 c4 10             	add    $0x10,%esp
80103a52:	85 c0                	test   %eax,%eax
80103a54:	75 b0                	jne    80103a06 <growproc+0x26>
80103a56:	eb de                	jmp    80103a36 <growproc+0x56>
80103a58:	90                   	nop
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a60 <fork>:
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	57                   	push   %edi
80103a64:	56                   	push   %esi
80103a65:	53                   	push   %ebx
80103a66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a69:	e8 22 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103a6e:	e8 bd fd ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103a73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a79:	e8 52 0a 00 00       	call   801044d0 <popcli>
  if((np = allocproc()) == 0){
80103a7e:	e8 5d fc ff ff       	call   801036e0 <allocproc>
80103a83:	85 c0                	test   %eax,%eax
80103a85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a88:	0f 84 b7 00 00 00    	je     80103b45 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a8e:	83 ec 08             	sub    $0x8,%esp
80103a91:	ff 33                	pushl  (%ebx)
80103a93:	ff 73 04             	pushl  0x4(%ebx)
80103a96:	89 c7                	mov    %eax,%edi
80103a98:	e8 e3 36 00 00       	call   80107180 <copyuvm>
80103a9d:	83 c4 10             	add    $0x10,%esp
80103aa0:	85 c0                	test   %eax,%eax
80103aa2:	89 47 04             	mov    %eax,0x4(%edi)
80103aa5:	0f 84 a1 00 00 00    	je     80103b4c <fork+0xec>
  np->sz = curproc->sz;
80103aab:	8b 03                	mov    (%ebx),%eax
80103aad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ab0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103ab2:	89 59 14             	mov    %ebx,0x14(%ecx)
80103ab5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103ab7:	8b 79 18             	mov    0x18(%ecx),%edi
80103aba:	8b 73 18             	mov    0x18(%ebx),%esi
80103abd:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ac2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ac4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ac6:	8b 40 18             	mov    0x18(%eax),%eax
80103ac9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103ad0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ad4:	85 c0                	test   %eax,%eax
80103ad6:	74 13                	je     80103aeb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ad8:	83 ec 0c             	sub    $0xc,%esp
80103adb:	50                   	push   %eax
80103adc:	e8 0f d3 ff ff       	call   80100df0 <filedup>
80103ae1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ae4:	83 c4 10             	add    $0x10,%esp
80103ae7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103aeb:	83 c6 01             	add    $0x1,%esi
80103aee:	83 fe 10             	cmp    $0x10,%esi
80103af1:	75 dd                	jne    80103ad0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103af3:	83 ec 0c             	sub    $0xc,%esp
80103af6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103af9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103afc:	e8 4f db ff ff       	call   80101650 <idup>
80103b01:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b04:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b07:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b0a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b0d:	6a 10                	push   $0x10
80103b0f:	53                   	push   %ebx
80103b10:	50                   	push   %eax
80103b11:	e8 3a 0d 00 00       	call   80104850 <safestrcpy>
  pid = np->pid;
80103b16:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b19:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103b20:	e8 3b 0a 00 00       	call   80104560 <acquire>
  np->state = RUNNABLE;
80103b25:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b2c:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103b33:	e8 e8 0a 00 00       	call   80104620 <release>
  return pid;
80103b38:	83 c4 10             	add    $0x10,%esp
}
80103b3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b3e:	89 d8                	mov    %ebx,%eax
80103b40:	5b                   	pop    %ebx
80103b41:	5e                   	pop    %esi
80103b42:	5f                   	pop    %edi
80103b43:	5d                   	pop    %ebp
80103b44:	c3                   	ret    
    return -1;
80103b45:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b4a:	eb ef                	jmp    80103b3b <fork+0xdb>
    kfree(np->kstack);
80103b4c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b4f:	83 ec 0c             	sub    $0xc,%esp
80103b52:	ff 73 08             	pushl  0x8(%ebx)
80103b55:	e8 b6 e7 ff ff       	call   80102310 <kfree>
    np->kstack = 0;
80103b5a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b61:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b68:	83 c4 10             	add    $0x10,%esp
80103b6b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b70:	eb c9                	jmp    80103b3b <fork+0xdb>
80103b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b80 <scheduler>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	57                   	push   %edi
80103b84:	56                   	push   %esi
80103b85:	53                   	push   %ebx
80103b86:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b89:	e8 a2 fc ff ff       	call   80103830 <mycpu>
80103b8e:	8d 70 04             	lea    0x4(%eax),%esi
80103b91:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103b93:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b9a:	00 00 00 
  asm volatile("sti");
80103b9d:	fb                   	sti    
    acquire(&ptable.lock);
80103b9e:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba1:	bf 54 29 11 80       	mov    $0x80112954,%edi
    acquire(&ptable.lock);
80103ba6:	68 20 29 11 80       	push   $0x80112920
80103bab:	e8 b0 09 00 00       	call   80104560 <acquire>
80103bb0:	83 c4 10             	add    $0x10,%esp
80103bb3:	eb 0e                	jmp    80103bc3 <scheduler+0x43>
80103bb5:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bb8:	83 ef 80             	sub    $0xffffff80,%edi
80103bbb:	81 ff 54 49 11 80    	cmp    $0x80114954,%edi
80103bc1:	73 64                	jae    80103c27 <scheduler+0xa7>
      if(p->state != RUNNABLE)
80103bc3:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103bc7:	75 ef                	jne    80103bb8 <scheduler+0x38>
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++) {
80103bc9:	b8 54 29 11 80       	mov    $0x80112954,%eax
80103bce:	66 90                	xchg   %ax,%ax
        if (p1->state != RUNNABLE)
80103bd0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103bd4:	75 09                	jne    80103bdf <scheduler+0x5f>
        if(highP->priority > p1->priority)
80103bd6:	8b 50 7c             	mov    0x7c(%eax),%edx
80103bd9:	39 57 7c             	cmp    %edx,0x7c(%edi)
80103bdc:	0f 4f f8             	cmovg  %eax,%edi
      for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++) {
80103bdf:	83 e8 80             	sub    $0xffffff80,%eax
80103be2:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80103be7:	72 e7                	jb     80103bd0 <scheduler+0x50>
      switchuvm(p);
80103be9:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bec:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103bf2:	57                   	push   %edi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bf3:	83 ef 80             	sub    $0xffffff80,%edi
      switchuvm(p);
80103bf6:	e8 85 30 00 00       	call   80106c80 <switchuvm>
      p->state = RUNNING;
80103bfb:	c7 47 8c 04 00 00 00 	movl   $0x4,-0x74(%edi)
      swtch(&(c->scheduler), p->context);
80103c02:	58                   	pop    %eax
80103c03:	5a                   	pop    %edx
80103c04:	ff 77 9c             	pushl  -0x64(%edi)
80103c07:	56                   	push   %esi
80103c08:	e8 9e 0c 00 00       	call   801048ab <swtch>
      switchkvm();
80103c0d:	e8 4e 30 00 00       	call   80106c60 <switchkvm>
      c->proc = 0;
80103c12:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c15:	81 ff 54 49 11 80    	cmp    $0x80114954,%edi
      c->proc = 0;
80103c1b:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103c22:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c25:	72 9c                	jb     80103bc3 <scheduler+0x43>
    release(&ptable.lock);
80103c27:	83 ec 0c             	sub    $0xc,%esp
80103c2a:	68 20 29 11 80       	push   $0x80112920
80103c2f:	e8 ec 09 00 00       	call   80104620 <release>
  for(;;){
80103c34:	83 c4 10             	add    $0x10,%esp
80103c37:	e9 61 ff ff ff       	jmp    80103b9d <scheduler+0x1d>
80103c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103c40 <sched>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	56                   	push   %esi
80103c44:	53                   	push   %ebx
  pushcli();
80103c45:	e8 46 08 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103c4a:	e8 e1 fb ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103c4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c55:	e8 76 08 00 00       	call   801044d0 <popcli>
  if(!holding(&ptable.lock))
80103c5a:	83 ec 0c             	sub    $0xc,%esp
80103c5d:	68 20 29 11 80       	push   $0x80112920
80103c62:	e8 c9 08 00 00       	call   80104530 <holding>
80103c67:	83 c4 10             	add    $0x10,%esp
80103c6a:	85 c0                	test   %eax,%eax
80103c6c:	74 4f                	je     80103cbd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c6e:	e8 bd fb ff ff       	call   80103830 <mycpu>
80103c73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c7a:	75 68                	jne    80103ce4 <sched+0xa4>
  if(p->state == RUNNING)
80103c7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c80:	74 55                	je     80103cd7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c82:	9c                   	pushf  
80103c83:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c84:	f6 c4 02             	test   $0x2,%ah
80103c87:	75 41                	jne    80103cca <sched+0x8a>
  intena = mycpu()->intena;
80103c89:	e8 a2 fb ff ff       	call   80103830 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c8e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c97:	e8 94 fb ff ff       	call   80103830 <mycpu>
80103c9c:	83 ec 08             	sub    $0x8,%esp
80103c9f:	ff 70 04             	pushl  0x4(%eax)
80103ca2:	53                   	push   %ebx
80103ca3:	e8 03 0c 00 00       	call   801048ab <swtch>
  mycpu()->intena = intena;
80103ca8:	e8 83 fb ff ff       	call   80103830 <mycpu>
}
80103cad:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103cb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cb9:	5b                   	pop    %ebx
80103cba:	5e                   	pop    %esi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret    
    panic("sched ptable.lock");
80103cbd:	83 ec 0c             	sub    $0xc,%esp
80103cc0:	68 10 79 10 80       	push   $0x80107910
80103cc5:	e8 c6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 3c 79 10 80       	push   $0x8010793c
80103cd2:	e8 b9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103cd7:	83 ec 0c             	sub    $0xc,%esp
80103cda:	68 2e 79 10 80       	push   $0x8010792e
80103cdf:	e8 ac c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103ce4:	83 ec 0c             	sub    $0xc,%esp
80103ce7:	68 22 79 10 80       	push   $0x80107922
80103cec:	e8 9f c6 ff ff       	call   80100390 <panic>
80103cf1:	eb 0d                	jmp    80103d00 <exit>
80103cf3:	90                   	nop
80103cf4:	90                   	nop
80103cf5:	90                   	nop
80103cf6:	90                   	nop
80103cf7:	90                   	nop
80103cf8:	90                   	nop
80103cf9:	90                   	nop
80103cfa:	90                   	nop
80103cfb:	90                   	nop
80103cfc:	90                   	nop
80103cfd:	90                   	nop
80103cfe:	90                   	nop
80103cff:	90                   	nop

80103d00 <exit>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	57                   	push   %edi
80103d04:	56                   	push   %esi
80103d05:	53                   	push   %ebx
80103d06:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d09:	e8 82 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103d0e:	e8 1d fb ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103d13:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d19:	e8 b2 07 00 00       	call   801044d0 <popcli>
  if(curproc == initproc)
80103d1e:	39 35 c0 a5 10 80    	cmp    %esi,0x8010a5c0
80103d24:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d27:	8d 7e 68             	lea    0x68(%esi),%edi
80103d2a:	0f 84 e7 00 00 00    	je     80103e17 <exit+0x117>
    if(curproc->ofile[fd]){
80103d30:	8b 03                	mov    (%ebx),%eax
80103d32:	85 c0                	test   %eax,%eax
80103d34:	74 12                	je     80103d48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d36:	83 ec 0c             	sub    $0xc,%esp
80103d39:	50                   	push   %eax
80103d3a:	e8 01 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103d3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d45:	83 c4 10             	add    $0x10,%esp
80103d48:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d4b:	39 fb                	cmp    %edi,%ebx
80103d4d:	75 e1                	jne    80103d30 <exit+0x30>
  begin_op();
80103d4f:	e8 2c ef ff ff       	call   80102c80 <begin_op>
  iput(curproc->cwd);
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	ff 76 68             	pushl  0x68(%esi)
80103d5a:	e8 51 da ff ff       	call   801017b0 <iput>
  end_op();
80103d5f:	e8 8c ef ff ff       	call   80102cf0 <end_op>
  curproc->cwd = 0;
80103d64:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d6b:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103d72:	e8 e9 07 00 00       	call   80104560 <acquire>
  wakeup1(curproc->parent);
80103d77:	8b 56 14             	mov    0x14(%esi),%edx
80103d7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d7d:	b8 54 29 11 80       	mov    $0x80112954,%eax
80103d82:	eb 0e                	jmp    80103d92 <exit+0x92>
80103d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d88:	83 e8 80             	sub    $0xffffff80,%eax
80103d8b:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80103d90:	73 1c                	jae    80103dae <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d92:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d96:	75 f0                	jne    80103d88 <exit+0x88>
80103d98:	3b 50 20             	cmp    0x20(%eax),%edx
80103d9b:	75 eb                	jne    80103d88 <exit+0x88>
      p->state = RUNNABLE;
80103d9d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da4:	83 e8 80             	sub    $0xffffff80,%eax
80103da7:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80103dac:	72 e4                	jb     80103d92 <exit+0x92>
      p->parent = initproc;
80103dae:	8b 0d c0 a5 10 80    	mov    0x8010a5c0,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103db4:	ba 54 29 11 80       	mov    $0x80112954,%edx
80103db9:	eb 10                	jmp    80103dcb <exit+0xcb>
80103dbb:	90                   	nop
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc0:	83 ea 80             	sub    $0xffffff80,%edx
80103dc3:	81 fa 54 49 11 80    	cmp    $0x80114954,%edx
80103dc9:	73 33                	jae    80103dfe <exit+0xfe>
    if(p->parent == curproc){
80103dcb:	39 72 14             	cmp    %esi,0x14(%edx)
80103dce:	75 f0                	jne    80103dc0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103dd0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103dd4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dd7:	75 e7                	jne    80103dc0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd9:	b8 54 29 11 80       	mov    $0x80112954,%eax
80103dde:	eb 0a                	jmp    80103dea <exit+0xea>
80103de0:	83 e8 80             	sub    $0xffffff80,%eax
80103de3:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80103de8:	73 d6                	jae    80103dc0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103dea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dee:	75 f0                	jne    80103de0 <exit+0xe0>
80103df0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103df3:	75 eb                	jne    80103de0 <exit+0xe0>
      p->state = RUNNABLE;
80103df5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dfc:	eb e2                	jmp    80103de0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103dfe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e05:	e8 36 fe ff ff       	call   80103c40 <sched>
  panic("zombie exit");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 5d 79 10 80       	push   $0x8010795d
80103e12:	e8 79 c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 50 79 10 80       	push   $0x80107950
80103e1f:	e8 6c c5 ff ff       	call   80100390 <panic>
80103e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e30 <yield>:
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	53                   	push   %ebx
80103e34:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e37:	68 20 29 11 80       	push   $0x80112920
80103e3c:	e8 1f 07 00 00       	call   80104560 <acquire>
  pushcli();
80103e41:	e8 4a 06 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e46:	e8 e5 f9 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103e4b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e51:	e8 7a 06 00 00       	call   801044d0 <popcli>
  myproc()->state = RUNNABLE;
80103e56:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e5d:	e8 de fd ff ff       	call   80103c40 <sched>
  release(&ptable.lock);
80103e62:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103e69:	e8 b2 07 00 00       	call   80104620 <release>
}
80103e6e:	83 c4 10             	add    $0x10,%esp
80103e71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e74:	c9                   	leave  
80103e75:	c3                   	ret    
80103e76:	8d 76 00             	lea    0x0(%esi),%esi
80103e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e80 <sleep>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 0c             	sub    $0xc,%esp
80103e89:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e8f:	e8 fc 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e94:	e8 97 f9 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103e99:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e9f:	e8 2c 06 00 00       	call   801044d0 <popcli>
  if(p == 0)
80103ea4:	85 db                	test   %ebx,%ebx
80103ea6:	0f 84 87 00 00 00    	je     80103f33 <sleep+0xb3>
  if(lk == 0)
80103eac:	85 f6                	test   %esi,%esi
80103eae:	74 76                	je     80103f26 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103eb0:	81 fe 20 29 11 80    	cmp    $0x80112920,%esi
80103eb6:	74 50                	je     80103f08 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103eb8:	83 ec 0c             	sub    $0xc,%esp
80103ebb:	68 20 29 11 80       	push   $0x80112920
80103ec0:	e8 9b 06 00 00       	call   80104560 <acquire>
    release(lk);
80103ec5:	89 34 24             	mov    %esi,(%esp)
80103ec8:	e8 53 07 00 00       	call   80104620 <release>
  p->chan = chan;
80103ecd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ed0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ed7:	e8 64 fd ff ff       	call   80103c40 <sched>
  p->chan = 0;
80103edc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ee3:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103eea:	e8 31 07 00 00       	call   80104620 <release>
    acquire(lk);
80103eef:	89 75 08             	mov    %esi,0x8(%ebp)
80103ef2:	83 c4 10             	add    $0x10,%esp
}
80103ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ef8:	5b                   	pop    %ebx
80103ef9:	5e                   	pop    %esi
80103efa:	5f                   	pop    %edi
80103efb:	5d                   	pop    %ebp
    acquire(lk);
80103efc:	e9 5f 06 00 00       	jmp    80104560 <acquire>
80103f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f08:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f0b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f12:	e8 29 fd ff ff       	call   80103c40 <sched>
  p->chan = 0;
80103f17:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f21:	5b                   	pop    %ebx
80103f22:	5e                   	pop    %esi
80103f23:	5f                   	pop    %edi
80103f24:	5d                   	pop    %ebp
80103f25:	c3                   	ret    
    panic("sleep without lk");
80103f26:	83 ec 0c             	sub    $0xc,%esp
80103f29:	68 6f 79 10 80       	push   $0x8010796f
80103f2e:	e8 5d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f33:	83 ec 0c             	sub    $0xc,%esp
80103f36:	68 69 79 10 80       	push   $0x80107969
80103f3b:	e8 50 c4 ff ff       	call   80100390 <panic>

80103f40 <wait>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	56                   	push   %esi
80103f44:	53                   	push   %ebx
  pushcli();
80103f45:	e8 46 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f4a:	e8 e1 f8 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103f4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f55:	e8 76 05 00 00       	call   801044d0 <popcli>
  acquire(&ptable.lock);
80103f5a:	83 ec 0c             	sub    $0xc,%esp
80103f5d:	68 20 29 11 80       	push   $0x80112920
80103f62:	e8 f9 05 00 00       	call   80104560 <acquire>
80103f67:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6c:	bb 54 29 11 80       	mov    $0x80112954,%ebx
80103f71:	eb 10                	jmp    80103f83 <wait+0x43>
80103f73:	90                   	nop
80103f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f78:	83 eb 80             	sub    $0xffffff80,%ebx
80103f7b:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
80103f81:	73 1b                	jae    80103f9e <wait+0x5e>
      if(p->parent != curproc)
80103f83:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f86:	75 f0                	jne    80103f78 <wait+0x38>
      if(p->state == ZOMBIE){
80103f88:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f8c:	74 32                	je     80103fc0 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103f91:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f96:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
80103f9c:	72 e5                	jb     80103f83 <wait+0x43>
    if(!havekids || curproc->killed){
80103f9e:	85 c0                	test   %eax,%eax
80103fa0:	74 74                	je     80104016 <wait+0xd6>
80103fa2:	8b 46 24             	mov    0x24(%esi),%eax
80103fa5:	85 c0                	test   %eax,%eax
80103fa7:	75 6d                	jne    80104016 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fa9:	83 ec 08             	sub    $0x8,%esp
80103fac:	68 20 29 11 80       	push   $0x80112920
80103fb1:	56                   	push   %esi
80103fb2:	e8 c9 fe ff ff       	call   80103e80 <sleep>
    havekids = 0;
80103fb7:	83 c4 10             	add    $0x10,%esp
80103fba:	eb ae                	jmp    80103f6a <wait+0x2a>
80103fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103fc0:	83 ec 0c             	sub    $0xc,%esp
80103fc3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fc6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fc9:	e8 42 e3 ff ff       	call   80102310 <kfree>
        freevm(p->pgdir);
80103fce:	5a                   	pop    %edx
80103fcf:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fd2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fd9:	e8 52 30 00 00       	call   80107030 <freevm>
        release(&ptable.lock);
80103fde:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
        p->pid = 0;
80103fe5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fec:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103ff3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ff7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ffe:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104005:	e8 16 06 00 00       	call   80104620 <release>
        return pid;
8010400a:	83 c4 10             	add    $0x10,%esp
}
8010400d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104010:	89 f0                	mov    %esi,%eax
80104012:	5b                   	pop    %ebx
80104013:	5e                   	pop    %esi
80104014:	5d                   	pop    %ebp
80104015:	c3                   	ret    
      release(&ptable.lock);
80104016:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104019:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010401e:	68 20 29 11 80       	push   $0x80112920
80104023:	e8 f8 05 00 00       	call   80104620 <release>
      return -1;
80104028:	83 c4 10             	add    $0x10,%esp
8010402b:	eb e0                	jmp    8010400d <wait+0xcd>
8010402d:	8d 76 00             	lea    0x0(%esi),%esi

80104030 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	83 ec 10             	sub    $0x10,%esp
80104037:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010403a:	68 20 29 11 80       	push   $0x80112920
8010403f:	e8 1c 05 00 00       	call   80104560 <acquire>
80104044:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104047:	b8 54 29 11 80       	mov    $0x80112954,%eax
8010404c:	eb 0c                	jmp    8010405a <wakeup+0x2a>
8010404e:	66 90                	xchg   %ax,%ax
80104050:	83 e8 80             	sub    $0xffffff80,%eax
80104053:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80104058:	73 1c                	jae    80104076 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010405a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010405e:	75 f0                	jne    80104050 <wakeup+0x20>
80104060:	3b 58 20             	cmp    0x20(%eax),%ebx
80104063:	75 eb                	jne    80104050 <wakeup+0x20>
      p->state = RUNNABLE;
80104065:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010406c:	83 e8 80             	sub    $0xffffff80,%eax
8010406f:	3d 54 49 11 80       	cmp    $0x80114954,%eax
80104074:	72 e4                	jb     8010405a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104076:	c7 45 08 20 29 11 80 	movl   $0x80112920,0x8(%ebp)
}
8010407d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104080:	c9                   	leave  
  release(&ptable.lock);
80104081:	e9 9a 05 00 00       	jmp    80104620 <release>
80104086:	8d 76 00             	lea    0x0(%esi),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	53                   	push   %ebx
80104094:	83 ec 10             	sub    $0x10,%esp
80104097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010409a:	68 20 29 11 80       	push   $0x80112920
8010409f:	e8 bc 04 00 00       	call   80104560 <acquire>
801040a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a7:	b8 54 29 11 80       	mov    $0x80112954,%eax
801040ac:	eb 0c                	jmp    801040ba <kill+0x2a>
801040ae:	66 90                	xchg   %ax,%ax
801040b0:	83 e8 80             	sub    $0xffffff80,%eax
801040b3:	3d 54 49 11 80       	cmp    $0x80114954,%eax
801040b8:	73 36                	jae    801040f0 <kill+0x60>
    if(p->pid == pid){
801040ba:	39 58 10             	cmp    %ebx,0x10(%eax)
801040bd:	75 f1                	jne    801040b0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040bf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801040c3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801040ca:	75 07                	jne    801040d3 <kill+0x43>
        p->state = RUNNABLE;
801040cc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801040d3:	83 ec 0c             	sub    $0xc,%esp
801040d6:	68 20 29 11 80       	push   $0x80112920
801040db:	e8 40 05 00 00       	call   80104620 <release>
      return 0;
801040e0:	83 c4 10             	add    $0x10,%esp
801040e3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e8:	c9                   	leave  
801040e9:	c3                   	ret    
801040ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801040f0:	83 ec 0c             	sub    $0xc,%esp
801040f3:	68 20 29 11 80       	push   $0x80112920
801040f8:	e8 23 05 00 00       	call   80104620 <release>
  return -1;
801040fd:	83 c4 10             	add    $0x10,%esp
80104100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104105:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104108:	c9                   	leave  
80104109:	c3                   	ret    
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104110 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	57                   	push   %edi
80104114:	56                   	push   %esi
80104115:	53                   	push   %ebx
80104116:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104119:	bb 54 29 11 80       	mov    $0x80112954,%ebx
{
8010411e:	83 ec 3c             	sub    $0x3c,%esp
80104121:	eb 24                	jmp    80104147 <procdump+0x37>
80104123:	90                   	nop
80104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 ed 75 10 80       	push   $0x801075ed
80104130:	e8 2b c5 ff ff       	call   80100660 <cprintf>
80104135:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104138:	83 eb 80             	sub    $0xffffff80,%ebx
8010413b:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
80104141:	0f 83 81 00 00 00    	jae    801041c8 <procdump+0xb8>
    if(p->state == UNUSED)
80104147:	8b 43 0c             	mov    0xc(%ebx),%eax
8010414a:	85 c0                	test   %eax,%eax
8010414c:	74 ea                	je     80104138 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010414e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104151:	ba 80 79 10 80       	mov    $0x80107980,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104156:	77 11                	ja     80104169 <procdump+0x59>
80104158:	8b 14 85 50 7a 10 80 	mov    -0x7fef85b0(,%eax,4),%edx
      state = "???";
8010415f:	b8 80 79 10 80       	mov    $0x80107980,%eax
80104164:	85 d2                	test   %edx,%edx
80104166:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104169:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010416c:	50                   	push   %eax
8010416d:	52                   	push   %edx
8010416e:	ff 73 10             	pushl  0x10(%ebx)
80104171:	68 84 79 10 80       	push   $0x80107984
80104176:	e8 e5 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010417b:	83 c4 10             	add    $0x10,%esp
8010417e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104182:	75 a4                	jne    80104128 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104184:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104187:	83 ec 08             	sub    $0x8,%esp
8010418a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010418d:	50                   	push   %eax
8010418e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104191:	8b 40 0c             	mov    0xc(%eax),%eax
80104194:	83 c0 08             	add    $0x8,%eax
80104197:	50                   	push   %eax
80104198:	e8 a3 02 00 00       	call   80104440 <getcallerpcs>
8010419d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041a0:	8b 17                	mov    (%edi),%edx
801041a2:	85 d2                	test   %edx,%edx
801041a4:	74 82                	je     80104128 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041a6:	83 ec 08             	sub    $0x8,%esp
801041a9:	83 c7 04             	add    $0x4,%edi
801041ac:	52                   	push   %edx
801041ad:	68 a1 73 10 80       	push   $0x801073a1
801041b2:	e8 a9 c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801041b7:	83 c4 10             	add    $0x10,%esp
801041ba:	39 fe                	cmp    %edi,%esi
801041bc:	75 e2                	jne    801041a0 <procdump+0x90>
801041be:	e9 65 ff ff ff       	jmp    80104128 <procdump+0x18>
801041c3:	90                   	nop
801041c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
801041c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041cb:	5b                   	pop    %ebx
801041cc:	5e                   	pop    %esi
801041cd:	5f                   	pop    %edi
801041ce:	5d                   	pop    %ebp
801041cf:	c3                   	ret    

801041d0 <cps>:

int
cps(void)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
801041d7:	fb                   	sti    
    struct proc *p;
    sti();
    acquire(&ptable.lock);
801041d8:	68 20 29 11 80       	push   $0x80112920
    cprintf("name \t pid \t state \t \t priority\n");
    for(p=ptable.proc; p < &ptable.proc[NPROC]; p++){
801041dd:	bb 54 29 11 80       	mov    $0x80112954,%ebx
    acquire(&ptable.lock);
801041e2:	e8 79 03 00 00       	call   80104560 <acquire>
    cprintf("name \t pid \t state \t \t priority\n");
801041e7:	c7 04 24 2c 7a 10 80 	movl   $0x80107a2c,(%esp)
801041ee:	e8 6d c4 ff ff       	call   80100660 <cprintf>
801041f3:	83 c4 10             	add    $0x10,%esp
801041f6:	eb 1d                	jmp    80104215 <cps+0x45>
801041f8:	90                   	nop
801041f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(p->state == SLEEPING)
            cprintf("%s \t %d \t SLEEPING \t %d\n", p->name, p->pid, p->priority);
        else if(p->state == RUNNING)
80104200:	83 f8 04             	cmp    $0x4,%eax
80104203:	74 5b                	je     80104260 <cps+0x90>
            cprintf("%s \t %d \t RUNNING  \t %d\n", p->name, p->pid, p->priority);
        else if(p->state == RUNNABLE)
80104205:	83 f8 03             	cmp    $0x3,%eax
80104208:	74 76                	je     80104280 <cps+0xb0>
    for(p=ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420a:	83 eb 80             	sub    $0xffffff80,%ebx
8010420d:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
80104213:	73 2a                	jae    8010423f <cps+0x6f>
        if(p->state == SLEEPING)
80104215:	8b 43 0c             	mov    0xc(%ebx),%eax
80104218:	83 f8 02             	cmp    $0x2,%eax
8010421b:	75 e3                	jne    80104200 <cps+0x30>
            cprintf("%s \t %d \t SLEEPING \t %d\n", p->name, p->pid, p->priority);
8010421d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104220:	ff 73 7c             	pushl  0x7c(%ebx)
80104223:	ff 73 10             	pushl  0x10(%ebx)
    for(p=ptable.proc; p < &ptable.proc[NPROC]; p++){
80104226:	83 eb 80             	sub    $0xffffff80,%ebx
            cprintf("%s \t %d \t SLEEPING \t %d\n", p->name, p->pid, p->priority);
80104229:	50                   	push   %eax
8010422a:	68 8d 79 10 80       	push   $0x8010798d
8010422f:	e8 2c c4 ff ff       	call   80100660 <cprintf>
80104234:	83 c4 10             	add    $0x10,%esp
    for(p=ptable.proc; p < &ptable.proc[NPROC]; p++){
80104237:	81 fb 54 49 11 80    	cmp    $0x80114954,%ebx
8010423d:	72 d6                	jb     80104215 <cps+0x45>
            cprintf("%s \t %d \t RUNNABLE \t %d\n", p->name, p->pid, p->priority);
    }
    release(&ptable.lock);
8010423f:	83 ec 0c             	sub    $0xc,%esp
80104242:	68 20 29 11 80       	push   $0x80112920
80104247:	e8 d4 03 00 00       	call   80104620 <release>
    return 22;
}
8010424c:	b8 16 00 00 00       	mov    $0x16,%eax
80104251:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104254:	c9                   	leave  
80104255:	c3                   	ret    
80104256:	8d 76 00             	lea    0x0(%esi),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            cprintf("%s \t %d \t RUNNING  \t %d\n", p->name, p->pid, p->priority);
80104260:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104263:	ff 73 7c             	pushl  0x7c(%ebx)
80104266:	ff 73 10             	pushl  0x10(%ebx)
80104269:	50                   	push   %eax
8010426a:	68 a6 79 10 80       	push   $0x801079a6
8010426f:	e8 ec c3 ff ff       	call   80100660 <cprintf>
80104274:	83 c4 10             	add    $0x10,%esp
80104277:	eb 91                	jmp    8010420a <cps+0x3a>
80104279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            cprintf("%s \t %d \t RUNNABLE \t %d\n", p->name, p->pid, p->priority);
80104280:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104283:	ff 73 7c             	pushl  0x7c(%ebx)
80104286:	ff 73 10             	pushl  0x10(%ebx)
80104289:	50                   	push   %eax
8010428a:	68 bf 79 10 80       	push   $0x801079bf
8010428f:	e8 cc c3 ff ff       	call   80100660 <cprintf>
80104294:	83 c4 10             	add    $0x10,%esp
80104297:	e9 6e ff ff ff       	jmp    8010420a <cps+0x3a>
8010429c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042a0 <chpr>:

int
chpr(int pid, int priority){
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;
    acquire(&ptable.lock);
801042aa:	68 20 29 11 80       	push   $0x80112920
801042af:	e8 ac 02 00 00       	call   80104560 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b7:	ba 54 29 11 80       	mov    $0x80112954,%edx
801042bc:	eb 0d                	jmp    801042cb <chpr+0x2b>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	83 ea 80             	sub    $0xffffff80,%edx
801042c3:	81 fa 54 49 11 80    	cmp    $0x80114954,%edx
801042c9:	73 0b                	jae    801042d6 <chpr+0x36>
        if(p->pid==pid) {
801042cb:	39 5a 10             	cmp    %ebx,0x10(%edx)
801042ce:	75 f0                	jne    801042c0 <chpr+0x20>
            p -> priority = priority;
801042d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801042d3:	89 42 7c             	mov    %eax,0x7c(%edx)
            break;
        }
    }
    release(&ptable.lock);
801042d6:	83 ec 0c             	sub    $0xc,%esp
801042d9:	68 20 29 11 80       	push   $0x80112920
801042de:	e8 3d 03 00 00       	call   80104620 <release>
    return pid;
}
801042e3:	89 d8                	mov    %ebx,%eax
801042e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042e8:	c9                   	leave  
801042e9:	c3                   	ret    
801042ea:	66 90                	xchg   %ax,%ax
801042ec:	66 90                	xchg   %ax,%ax
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042fa:	68 68 7a 10 80       	push   $0x80107a68
801042ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104302:	50                   	push   %eax
80104303:	e8 18 01 00 00       	call   80104420 <initlock>
  lk->name = name;
80104308:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010430b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104311:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104314:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010431b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010431e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104321:	c9                   	leave  
80104322:	c3                   	ret    
80104323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 73 04             	lea    0x4(%ebx),%esi
8010433e:	56                   	push   %esi
8010433f:	e8 1c 02 00 00       	call   80104560 <acquire>
  while (lk->locked) {
80104344:	8b 13                	mov    (%ebx),%edx
80104346:	83 c4 10             	add    $0x10,%esp
80104349:	85 d2                	test   %edx,%edx
8010434b:	74 16                	je     80104363 <acquiresleep+0x33>
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	56                   	push   %esi
80104354:	53                   	push   %ebx
80104355:	e8 26 fb ff ff       	call   80103e80 <sleep>
  while (lk->locked) {
8010435a:	8b 03                	mov    (%ebx),%eax
8010435c:	83 c4 10             	add    $0x10,%esp
8010435f:	85 c0                	test   %eax,%eax
80104361:	75 ed                	jne    80104350 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104363:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104369:	e8 52 f5 ff ff       	call   801038c0 <myproc>
8010436e:	8b 40 10             	mov    0x10(%eax),%eax
80104371:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104374:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104377:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010437a:	5b                   	pop    %ebx
8010437b:	5e                   	pop    %esi
8010437c:	5d                   	pop    %ebp
  release(&lk->lk);
8010437d:	e9 9e 02 00 00       	jmp    80104620 <release>
80104382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104390 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104398:	83 ec 0c             	sub    $0xc,%esp
8010439b:	8d 73 04             	lea    0x4(%ebx),%esi
8010439e:	56                   	push   %esi
8010439f:	e8 bc 01 00 00       	call   80104560 <acquire>
  lk->locked = 0;
801043a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043b1:	89 1c 24             	mov    %ebx,(%esp)
801043b4:	e8 77 fc ff ff       	call   80104030 <wakeup>
  release(&lk->lk);
801043b9:	89 75 08             	mov    %esi,0x8(%ebp)
801043bc:	83 c4 10             	add    $0x10,%esp
}
801043bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043c2:	5b                   	pop    %ebx
801043c3:	5e                   	pop    %esi
801043c4:	5d                   	pop    %ebp
  release(&lk->lk);
801043c5:	e9 56 02 00 00       	jmp    80104620 <release>
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	56                   	push   %esi
801043d5:	53                   	push   %ebx
801043d6:	31 ff                	xor    %edi,%edi
801043d8:	83 ec 18             	sub    $0x18,%esp
801043db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801043de:	8d 73 04             	lea    0x4(%ebx),%esi
801043e1:	56                   	push   %esi
801043e2:	e8 79 01 00 00       	call   80104560 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801043e7:	8b 03                	mov    (%ebx),%eax
801043e9:	83 c4 10             	add    $0x10,%esp
801043ec:	85 c0                	test   %eax,%eax
801043ee:	74 13                	je     80104403 <holdingsleep+0x33>
801043f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801043f3:	e8 c8 f4 ff ff       	call   801038c0 <myproc>
801043f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801043fb:	0f 94 c0             	sete   %al
801043fe:	0f b6 c0             	movzbl %al,%eax
80104401:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104403:	83 ec 0c             	sub    $0xc,%esp
80104406:	56                   	push   %esi
80104407:	e8 14 02 00 00       	call   80104620 <release>
  return r;
}
8010440c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010440f:	89 f8                	mov    %edi,%eax
80104411:	5b                   	pop    %ebx
80104412:	5e                   	pop    %esi
80104413:	5f                   	pop    %edi
80104414:	5d                   	pop    %ebp
80104415:	c3                   	ret    
80104416:	66 90                	xchg   %ax,%ax
80104418:	66 90                	xchg   %ax,%ax
8010441a:	66 90                	xchg   %ax,%ax
8010441c:	66 90                	xchg   %ax,%ax
8010441e:	66 90                	xchg   %ax,%ax

80104420 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104426:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104429:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010442f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104432:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104439:	5d                   	pop    %ebp
8010443a:	c3                   	ret    
8010443b:	90                   	nop
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104440:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104441:	31 d2                	xor    %edx,%edx
{
80104443:	89 e5                	mov    %esp,%ebp
80104445:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104446:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104449:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010444c:	83 e8 08             	sub    $0x8,%eax
8010444f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104450:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104456:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010445c:	77 1a                	ja     80104478 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010445e:	8b 58 04             	mov    0x4(%eax),%ebx
80104461:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104464:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104467:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104469:	83 fa 0a             	cmp    $0xa,%edx
8010446c:	75 e2                	jne    80104450 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010446e:	5b                   	pop    %ebx
8010446f:	5d                   	pop    %ebp
80104470:	c3                   	ret    
80104471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104478:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010447b:	83 c1 28             	add    $0x28,%ecx
8010447e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104486:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104489:	39 c1                	cmp    %eax,%ecx
8010448b:	75 f3                	jne    80104480 <getcallerpcs+0x40>
}
8010448d:	5b                   	pop    %ebx
8010448e:	5d                   	pop    %ebp
8010448f:	c3                   	ret    

80104490 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104497:	9c                   	pushf  
80104498:	5b                   	pop    %ebx
  asm volatile("cli");
80104499:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010449a:	e8 91 f3 ff ff       	call   80103830 <mycpu>
8010449f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	75 11                	jne    801044ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801044a9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044af:	e8 7c f3 ff ff       	call   80103830 <mycpu>
801044b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801044ba:	e8 71 f3 ff ff       	call   80103830 <mycpu>
801044bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044c6:	83 c4 04             	add    $0x4,%esp
801044c9:	5b                   	pop    %ebx
801044ca:	5d                   	pop    %ebp
801044cb:	c3                   	ret    
801044cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044d0 <popcli>:

void
popcli(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044d6:	9c                   	pushf  
801044d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044d8:	f6 c4 02             	test   $0x2,%ah
801044db:	75 35                	jne    80104512 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801044dd:	e8 4e f3 ff ff       	call   80103830 <mycpu>
801044e2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801044e9:	78 34                	js     8010451f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801044eb:	e8 40 f3 ff ff       	call   80103830 <mycpu>
801044f0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801044f6:	85 d2                	test   %edx,%edx
801044f8:	74 06                	je     80104500 <popcli+0x30>
    sti();
}
801044fa:	c9                   	leave  
801044fb:	c3                   	ret    
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104500:	e8 2b f3 ff ff       	call   80103830 <mycpu>
80104505:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010450b:	85 c0                	test   %eax,%eax
8010450d:	74 eb                	je     801044fa <popcli+0x2a>
  asm volatile("sti");
8010450f:	fb                   	sti    
}
80104510:	c9                   	leave  
80104511:	c3                   	ret    
    panic("popcli - interruptible");
80104512:	83 ec 0c             	sub    $0xc,%esp
80104515:	68 73 7a 10 80       	push   $0x80107a73
8010451a:	e8 71 be ff ff       	call   80100390 <panic>
    panic("popcli");
8010451f:	83 ec 0c             	sub    $0xc,%esp
80104522:	68 8a 7a 10 80       	push   $0x80107a8a
80104527:	e8 64 be ff ff       	call   80100390 <panic>
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <holding>:
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
80104535:	8b 75 08             	mov    0x8(%ebp),%esi
80104538:	31 db                	xor    %ebx,%ebx
  pushcli();
8010453a:	e8 51 ff ff ff       	call   80104490 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010453f:	8b 06                	mov    (%esi),%eax
80104541:	85 c0                	test   %eax,%eax
80104543:	74 10                	je     80104555 <holding+0x25>
80104545:	8b 5e 08             	mov    0x8(%esi),%ebx
80104548:	e8 e3 f2 ff ff       	call   80103830 <mycpu>
8010454d:	39 c3                	cmp    %eax,%ebx
8010454f:	0f 94 c3             	sete   %bl
80104552:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104555:	e8 76 ff ff ff       	call   801044d0 <popcli>
}
8010455a:	89 d8                	mov    %ebx,%eax
8010455c:	5b                   	pop    %ebx
8010455d:	5e                   	pop    %esi
8010455e:	5d                   	pop    %ebp
8010455f:	c3                   	ret    

80104560 <acquire>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104565:	e8 26 ff ff ff       	call   80104490 <pushcli>
  if(holding(lk))
8010456a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010456d:	83 ec 0c             	sub    $0xc,%esp
80104570:	53                   	push   %ebx
80104571:	e8 ba ff ff ff       	call   80104530 <holding>
80104576:	83 c4 10             	add    $0x10,%esp
80104579:	85 c0                	test   %eax,%eax
8010457b:	0f 85 83 00 00 00    	jne    80104604 <acquire+0xa4>
80104581:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104583:	ba 01 00 00 00       	mov    $0x1,%edx
80104588:	eb 09                	jmp    80104593 <acquire+0x33>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104590:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104593:	89 d0                	mov    %edx,%eax
80104595:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104598:	85 c0                	test   %eax,%eax
8010459a:	75 f4                	jne    80104590 <acquire+0x30>
  __sync_synchronize();
8010459c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801045a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045a4:	e8 87 f2 ff ff       	call   80103830 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801045a9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801045ac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801045af:	89 e8                	mov    %ebp,%eax
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045b8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801045be:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801045c4:	77 1a                	ja     801045e0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801045c6:	8b 48 04             	mov    0x4(%eax),%ecx
801045c9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801045cc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801045cf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045d1:	83 fe 0a             	cmp    $0xa,%esi
801045d4:	75 e2                	jne    801045b8 <acquire+0x58>
}
801045d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d9:	5b                   	pop    %ebx
801045da:	5e                   	pop    %esi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801045e3:	83 c2 28             	add    $0x28,%edx
801045e6:	8d 76 00             	lea    0x0(%esi),%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801045f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045f9:	39 d0                	cmp    %edx,%eax
801045fb:	75 f3                	jne    801045f0 <acquire+0x90>
}
801045fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104600:	5b                   	pop    %ebx
80104601:	5e                   	pop    %esi
80104602:	5d                   	pop    %ebp
80104603:	c3                   	ret    
    panic("acquire");
80104604:	83 ec 0c             	sub    $0xc,%esp
80104607:	68 91 7a 10 80       	push   $0x80107a91
8010460c:	e8 7f bd ff ff       	call   80100390 <panic>
80104611:	eb 0d                	jmp    80104620 <release>
80104613:	90                   	nop
80104614:	90                   	nop
80104615:	90                   	nop
80104616:	90                   	nop
80104617:	90                   	nop
80104618:	90                   	nop
80104619:	90                   	nop
8010461a:	90                   	nop
8010461b:	90                   	nop
8010461c:	90                   	nop
8010461d:	90                   	nop
8010461e:	90                   	nop
8010461f:	90                   	nop

80104620 <release>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 10             	sub    $0x10,%esp
80104627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010462a:	53                   	push   %ebx
8010462b:	e8 00 ff ff ff       	call   80104530 <holding>
80104630:	83 c4 10             	add    $0x10,%esp
80104633:	85 c0                	test   %eax,%eax
80104635:	74 22                	je     80104659 <release+0x39>
  lk->pcs[0] = 0;
80104637:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010463e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104645:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010464a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104650:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104653:	c9                   	leave  
  popcli();
80104654:	e9 77 fe ff ff       	jmp    801044d0 <popcli>
    panic("release");
80104659:	83 ec 0c             	sub    $0xc,%esp
8010465c:	68 99 7a 10 80       	push   $0x80107a99
80104661:	e8 2a bd ff ff       	call   80100390 <panic>
80104666:	66 90                	xchg   %ax,%ax
80104668:	66 90                	xchg   %ax,%ax
8010466a:	66 90                	xchg   %ax,%ax
8010466c:	66 90                	xchg   %ax,%ax
8010466e:	66 90                	xchg   %ax,%ax

80104670 <memset>:
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	53                   	push   %ebx
80104675:	8b 55 08             	mov    0x8(%ebp),%edx
80104678:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010467b:	f6 c2 03             	test   $0x3,%dl
8010467e:	75 05                	jne    80104685 <memset+0x15>
80104680:	f6 c1 03             	test   $0x3,%cl
80104683:	74 13                	je     80104698 <memset+0x28>
80104685:	89 d7                	mov    %edx,%edi
80104687:	8b 45 0c             	mov    0xc(%ebp),%eax
8010468a:	fc                   	cld    
8010468b:	f3 aa                	rep stos %al,%es:(%edi)
8010468d:	5b                   	pop    %ebx
8010468e:	89 d0                	mov    %edx,%eax
80104690:	5f                   	pop    %edi
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104698:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010469c:	c1 e9 02             	shr    $0x2,%ecx
8010469f:	89 f8                	mov    %edi,%eax
801046a1:	89 fb                	mov    %edi,%ebx
801046a3:	c1 e0 18             	shl    $0x18,%eax
801046a6:	c1 e3 10             	shl    $0x10,%ebx
801046a9:	09 d8                	or     %ebx,%eax
801046ab:	09 f8                	or     %edi,%eax
801046ad:	c1 e7 08             	shl    $0x8,%edi
801046b0:	09 f8                	or     %edi,%eax
801046b2:	89 d7                	mov    %edx,%edi
801046b4:	fc                   	cld    
801046b5:	f3 ab                	rep stos %eax,%es:(%edi)
801046b7:	5b                   	pop    %ebx
801046b8:	89 d0                	mov    %edx,%eax
801046ba:	5f                   	pop    %edi
801046bb:	5d                   	pop    %ebp
801046bc:	c3                   	ret    
801046bd:	8d 76 00             	lea    0x0(%esi),%esi

801046c0 <memcmp>:
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
801046c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801046c9:	8b 75 08             	mov    0x8(%ebp),%esi
801046cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801046cf:	85 db                	test   %ebx,%ebx
801046d1:	74 29                	je     801046fc <memcmp+0x3c>
801046d3:	0f b6 16             	movzbl (%esi),%edx
801046d6:	0f b6 0f             	movzbl (%edi),%ecx
801046d9:	38 d1                	cmp    %dl,%cl
801046db:	75 2b                	jne    80104708 <memcmp+0x48>
801046dd:	b8 01 00 00 00       	mov    $0x1,%eax
801046e2:	eb 14                	jmp    801046f8 <memcmp+0x38>
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046e8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801046ec:	83 c0 01             	add    $0x1,%eax
801046ef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801046f4:	38 ca                	cmp    %cl,%dl
801046f6:	75 10                	jne    80104708 <memcmp+0x48>
801046f8:	39 d8                	cmp    %ebx,%eax
801046fa:	75 ec                	jne    801046e8 <memcmp+0x28>
801046fc:	5b                   	pop    %ebx
801046fd:	31 c0                	xor    %eax,%eax
801046ff:	5e                   	pop    %esi
80104700:	5f                   	pop    %edi
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	90                   	nop
80104704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104708:	0f b6 c2             	movzbl %dl,%eax
8010470b:	5b                   	pop    %ebx
8010470c:	29 c8                	sub    %ecx,%eax
8010470e:	5e                   	pop    %esi
8010470f:	5f                   	pop    %edi
80104710:	5d                   	pop    %ebp
80104711:	c3                   	ret    
80104712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <memmove>:
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 45 08             	mov    0x8(%ebp),%eax
80104728:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010472b:	8b 75 10             	mov    0x10(%ebp),%esi
8010472e:	39 c3                	cmp    %eax,%ebx
80104730:	73 26                	jae    80104758 <memmove+0x38>
80104732:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104735:	39 c8                	cmp    %ecx,%eax
80104737:	73 1f                	jae    80104758 <memmove+0x38>
80104739:	85 f6                	test   %esi,%esi
8010473b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010473e:	74 0f                	je     8010474f <memmove+0x2f>
80104740:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104744:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104747:	83 ea 01             	sub    $0x1,%edx
8010474a:	83 fa ff             	cmp    $0xffffffff,%edx
8010474d:	75 f1                	jne    80104740 <memmove+0x20>
8010474f:	5b                   	pop    %ebx
80104750:	5e                   	pop    %esi
80104751:	5d                   	pop    %ebp
80104752:	c3                   	ret    
80104753:	90                   	nop
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104758:	31 d2                	xor    %edx,%edx
8010475a:	85 f6                	test   %esi,%esi
8010475c:	74 f1                	je     8010474f <memmove+0x2f>
8010475e:	66 90                	xchg   %ax,%ax
80104760:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104764:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104767:	83 c2 01             	add    $0x1,%edx
8010476a:	39 d6                	cmp    %edx,%esi
8010476c:	75 f2                	jne    80104760 <memmove+0x40>
8010476e:	5b                   	pop    %ebx
8010476f:	5e                   	pop    %esi
80104770:	5d                   	pop    %ebp
80104771:	c3                   	ret    
80104772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <memcpy>:
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	5d                   	pop    %ebp
80104784:	eb 9a                	jmp    80104720 <memmove>
80104786:	8d 76 00             	lea    0x0(%esi),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104790 <strncmp>:
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	56                   	push   %esi
80104795:	8b 7d 10             	mov    0x10(%ebp),%edi
80104798:	53                   	push   %ebx
80104799:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010479c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010479f:	85 ff                	test   %edi,%edi
801047a1:	74 2f                	je     801047d2 <strncmp+0x42>
801047a3:	0f b6 01             	movzbl (%ecx),%eax
801047a6:	0f b6 1e             	movzbl (%esi),%ebx
801047a9:	84 c0                	test   %al,%al
801047ab:	74 37                	je     801047e4 <strncmp+0x54>
801047ad:	38 c3                	cmp    %al,%bl
801047af:	75 33                	jne    801047e4 <strncmp+0x54>
801047b1:	01 f7                	add    %esi,%edi
801047b3:	eb 13                	jmp    801047c8 <strncmp+0x38>
801047b5:	8d 76 00             	lea    0x0(%esi),%esi
801047b8:	0f b6 01             	movzbl (%ecx),%eax
801047bb:	84 c0                	test   %al,%al
801047bd:	74 21                	je     801047e0 <strncmp+0x50>
801047bf:	0f b6 1a             	movzbl (%edx),%ebx
801047c2:	89 d6                	mov    %edx,%esi
801047c4:	38 d8                	cmp    %bl,%al
801047c6:	75 1c                	jne    801047e4 <strncmp+0x54>
801047c8:	8d 56 01             	lea    0x1(%esi),%edx
801047cb:	83 c1 01             	add    $0x1,%ecx
801047ce:	39 fa                	cmp    %edi,%edx
801047d0:	75 e6                	jne    801047b8 <strncmp+0x28>
801047d2:	5b                   	pop    %ebx
801047d3:	31 c0                	xor    %eax,%eax
801047d5:	5e                   	pop    %esi
801047d6:	5f                   	pop    %edi
801047d7:	5d                   	pop    %ebp
801047d8:	c3                   	ret    
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
801047e4:	29 d8                	sub    %ebx,%eax
801047e6:	5b                   	pop    %ebx
801047e7:	5e                   	pop    %esi
801047e8:	5f                   	pop    %edi
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <strncpy>:
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	8b 45 08             	mov    0x8(%ebp),%eax
801047f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047fe:	89 c2                	mov    %eax,%edx
80104800:	eb 19                	jmp    8010481b <strncpy+0x2b>
80104802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104808:	83 c3 01             	add    $0x1,%ebx
8010480b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010480f:	83 c2 01             	add    $0x1,%edx
80104812:	84 c9                	test   %cl,%cl
80104814:	88 4a ff             	mov    %cl,-0x1(%edx)
80104817:	74 09                	je     80104822 <strncpy+0x32>
80104819:	89 f1                	mov    %esi,%ecx
8010481b:	85 c9                	test   %ecx,%ecx
8010481d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104820:	7f e6                	jg     80104808 <strncpy+0x18>
80104822:	31 c9                	xor    %ecx,%ecx
80104824:	85 f6                	test   %esi,%esi
80104826:	7e 17                	jle    8010483f <strncpy+0x4f>
80104828:	90                   	nop
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104830:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104834:	89 f3                	mov    %esi,%ebx
80104836:	83 c1 01             	add    $0x1,%ecx
80104839:	29 cb                	sub    %ecx,%ebx
8010483b:	85 db                	test   %ebx,%ebx
8010483d:	7f f1                	jg     80104830 <strncpy+0x40>
8010483f:	5b                   	pop    %ebx
80104840:	5e                   	pop    %esi
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <safestrcpy>:
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
80104855:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104858:	8b 45 08             	mov    0x8(%ebp),%eax
8010485b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010485e:	85 c9                	test   %ecx,%ecx
80104860:	7e 26                	jle    80104888 <safestrcpy+0x38>
80104862:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104866:	89 c1                	mov    %eax,%ecx
80104868:	eb 17                	jmp    80104881 <safestrcpy+0x31>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104870:	83 c2 01             	add    $0x1,%edx
80104873:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104877:	83 c1 01             	add    $0x1,%ecx
8010487a:	84 db                	test   %bl,%bl
8010487c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010487f:	74 04                	je     80104885 <safestrcpy+0x35>
80104881:	39 f2                	cmp    %esi,%edx
80104883:	75 eb                	jne    80104870 <safestrcpy+0x20>
80104885:	c6 01 00             	movb   $0x0,(%ecx)
80104888:	5b                   	pop    %ebx
80104889:	5e                   	pop    %esi
8010488a:	5d                   	pop    %ebp
8010488b:	c3                   	ret    
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104890 <strlen>:
80104890:	55                   	push   %ebp
80104891:	31 c0                	xor    %eax,%eax
80104893:	89 e5                	mov    %esp,%ebp
80104895:	8b 55 08             	mov    0x8(%ebp),%edx
80104898:	80 3a 00             	cmpb   $0x0,(%edx)
8010489b:	74 0c                	je     801048a9 <strlen+0x19>
8010489d:	8d 76 00             	lea    0x0(%esi),%esi
801048a0:	83 c0 01             	add    $0x1,%eax
801048a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048a7:	75 f7                	jne    801048a0 <strlen+0x10>
801048a9:	5d                   	pop    %ebp
801048aa:	c3                   	ret    

801048ab <swtch>:
801048ab:	8b 44 24 04          	mov    0x4(%esp),%eax
801048af:	8b 54 24 08          	mov    0x8(%esp),%edx
801048b3:	55                   	push   %ebp
801048b4:	53                   	push   %ebx
801048b5:	56                   	push   %esi
801048b6:	57                   	push   %edi
801048b7:	89 20                	mov    %esp,(%eax)
801048b9:	89 d4                	mov    %edx,%esp
801048bb:	5f                   	pop    %edi
801048bc:	5e                   	pop    %esi
801048bd:	5b                   	pop    %ebx
801048be:	5d                   	pop    %ebp
801048bf:	c3                   	ret    

801048c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801048ca:	e8 f1 ef ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048cf:	8b 00                	mov    (%eax),%eax
801048d1:	39 d8                	cmp    %ebx,%eax
801048d3:	76 1b                	jbe    801048f0 <fetchint+0x30>
801048d5:	8d 53 04             	lea    0x4(%ebx),%edx
801048d8:	39 d0                	cmp    %edx,%eax
801048da:	72 14                	jb     801048f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048df:	8b 13                	mov    (%ebx),%edx
801048e1:	89 10                	mov    %edx,(%eax)
  return 0;
801048e3:	31 c0                	xor    %eax,%eax
}
801048e5:	83 c4 04             	add    $0x4,%esp
801048e8:	5b                   	pop    %ebx
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    
801048eb:	90                   	nop
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048f5:	eb ee                	jmp    801048e5 <fetchint+0x25>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
80104907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010490a:	e8 b1 ef ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz)
8010490f:	39 18                	cmp    %ebx,(%eax)
80104911:	76 29                	jbe    8010493c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104913:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104916:	89 da                	mov    %ebx,%edx
80104918:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010491a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010491c:	39 c3                	cmp    %eax,%ebx
8010491e:	73 1c                	jae    8010493c <fetchstr+0x3c>
    if(*s == 0)
80104920:	80 3b 00             	cmpb   $0x0,(%ebx)
80104923:	75 10                	jne    80104935 <fetchstr+0x35>
80104925:	eb 39                	jmp    80104960 <fetchstr+0x60>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104930:	80 3a 00             	cmpb   $0x0,(%edx)
80104933:	74 1b                	je     80104950 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104935:	83 c2 01             	add    $0x1,%edx
80104938:	39 d0                	cmp    %edx,%eax
8010493a:	77 f4                	ja     80104930 <fetchstr+0x30>
    return -1;
8010493c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104941:	83 c4 04             	add    $0x4,%esp
80104944:	5b                   	pop    %ebx
80104945:	5d                   	pop    %ebp
80104946:	c3                   	ret    
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104950:	83 c4 04             	add    $0x4,%esp
80104953:	89 d0                	mov    %edx,%eax
80104955:	29 d8                	sub    %ebx,%eax
80104957:	5b                   	pop    %ebx
80104958:	5d                   	pop    %ebp
80104959:	c3                   	ret    
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104960:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104962:	eb dd                	jmp    80104941 <fetchstr+0x41>
80104964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010496a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104970 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104975:	e8 46 ef ff ff       	call   801038c0 <myproc>
8010497a:	8b 40 18             	mov    0x18(%eax),%eax
8010497d:	8b 55 08             	mov    0x8(%ebp),%edx
80104980:	8b 40 44             	mov    0x44(%eax),%eax
80104983:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104986:	e8 35 ef ff ff       	call   801038c0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010498b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010498d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104990:	39 c6                	cmp    %eax,%esi
80104992:	73 1c                	jae    801049b0 <argint+0x40>
80104994:	8d 53 08             	lea    0x8(%ebx),%edx
80104997:	39 d0                	cmp    %edx,%eax
80104999:	72 15                	jb     801049b0 <argint+0x40>
  *ip = *(int*)(addr);
8010499b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010499e:	8b 53 04             	mov    0x4(%ebx),%edx
801049a1:	89 10                	mov    %edx,(%eax)
  return 0;
801049a3:	31 c0                	xor    %eax,%eax
}
801049a5:	5b                   	pop    %ebx
801049a6:	5e                   	pop    %esi
801049a7:	5d                   	pop    %ebp
801049a8:	c3                   	ret    
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049b5:	eb ee                	jmp    801049a5 <argint+0x35>
801049b7:	89 f6                	mov    %esi,%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	83 ec 10             	sub    $0x10,%esp
801049c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801049cb:	e8 f0 ee ff ff       	call   801038c0 <myproc>
801049d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801049d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049d5:	83 ec 08             	sub    $0x8,%esp
801049d8:	50                   	push   %eax
801049d9:	ff 75 08             	pushl  0x8(%ebp)
801049dc:	e8 8f ff ff ff       	call   80104970 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049e1:	83 c4 10             	add    $0x10,%esp
801049e4:	85 c0                	test   %eax,%eax
801049e6:	78 28                	js     80104a10 <argptr+0x50>
801049e8:	85 db                	test   %ebx,%ebx
801049ea:	78 24                	js     80104a10 <argptr+0x50>
801049ec:	8b 16                	mov    (%esi),%edx
801049ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f1:	39 c2                	cmp    %eax,%edx
801049f3:	76 1b                	jbe    80104a10 <argptr+0x50>
801049f5:	01 c3                	add    %eax,%ebx
801049f7:	39 da                	cmp    %ebx,%edx
801049f9:	72 15                	jb     80104a10 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801049fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801049fe:	89 02                	mov    %eax,(%edx)
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
}
80104a02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a05:	5b                   	pop    %ebx
80104a06:	5e                   	pop    %esi
80104a07:	5d                   	pop    %ebp
80104a08:	c3                   	ret    
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb eb                	jmp    80104a02 <argptr+0x42>
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a29:	50                   	push   %eax
80104a2a:	ff 75 08             	pushl  0x8(%ebp)
80104a2d:	e8 3e ff ff ff       	call   80104970 <argint>
80104a32:	83 c4 10             	add    $0x10,%esp
80104a35:	85 c0                	test   %eax,%eax
80104a37:	78 17                	js     80104a50 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a39:	83 ec 08             	sub    $0x8,%esp
80104a3c:	ff 75 0c             	pushl  0xc(%ebp)
80104a3f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a42:	e8 b9 fe ff ff       	call   80104900 <fetchstr>
80104a47:	83 c4 10             	add    $0x10,%esp
}
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a55:	c9                   	leave  
80104a56:	c3                   	ret    
80104a57:	89 f6                	mov    %esi,%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <syscall>:
[SYS_freeMem] sys_freeMem,
};

void
syscall(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104a67:	e8 54 ee ff ff       	call   801038c0 <myproc>
80104a6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a6e:	8b 40 18             	mov    0x18(%eax),%eax
80104a71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a77:	83 fa 18             	cmp    $0x18,%edx
80104a7a:	77 1c                	ja     80104a98 <syscall+0x38>
80104a7c:	8b 14 85 c0 7a 10 80 	mov    -0x7fef8540(,%eax,4),%edx
80104a83:	85 d2                	test   %edx,%edx
80104a85:	74 11                	je     80104a98 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a87:	ff d2                	call   *%edx
80104a89:	8b 53 18             	mov    0x18(%ebx),%edx
80104a8c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a92:	c9                   	leave  
80104a93:	c3                   	ret    
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a98:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a99:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a9c:	50                   	push   %eax
80104a9d:	ff 73 10             	pushl  0x10(%ebx)
80104aa0:	68 a1 7a 10 80       	push   $0x80107aa1
80104aa5:	e8 b6 bb ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104aaa:	8b 43 18             	mov    0x18(%ebx),%eax
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104ab7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aba:	c9                   	leave  
80104abb:	c3                   	ret    
80104abc:	66 90                	xchg   %ax,%ax
80104abe:	66 90                	xchg   %ax,%ax

80104ac0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ac6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104ac9:	83 ec 34             	sub    $0x34,%esp
80104acc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104acf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ad2:	56                   	push   %esi
80104ad3:	50                   	push   %eax
{
80104ad4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104ad7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104ada:	e8 21 d4 ff ff       	call   80101f00 <nameiparent>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	0f 84 46 01 00 00    	je     80104c30 <create+0x170>
    return 0;
  ilock(dp);
80104aea:	83 ec 0c             	sub    $0xc,%esp
80104aed:	89 c3                	mov    %eax,%ebx
80104aef:	50                   	push   %eax
80104af0:	e8 8b cb ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104af5:	83 c4 0c             	add    $0xc,%esp
80104af8:	6a 00                	push   $0x0
80104afa:	56                   	push   %esi
80104afb:	53                   	push   %ebx
80104afc:	e8 af d0 ff ff       	call   80101bb0 <dirlookup>
80104b01:	83 c4 10             	add    $0x10,%esp
80104b04:	85 c0                	test   %eax,%eax
80104b06:	89 c7                	mov    %eax,%edi
80104b08:	74 36                	je     80104b40 <create+0x80>
    iunlockput(dp);
80104b0a:	83 ec 0c             	sub    $0xc,%esp
80104b0d:	53                   	push   %ebx
80104b0e:	e8 fd cd ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104b13:	89 3c 24             	mov    %edi,(%esp)
80104b16:	e8 65 cb ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b1b:	83 c4 10             	add    $0x10,%esp
80104b1e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104b23:	0f 85 97 00 00 00    	jne    80104bc0 <create+0x100>
80104b29:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b2e:	0f 85 8c 00 00 00    	jne    80104bc0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b37:	89 f8                	mov    %edi,%eax
80104b39:	5b                   	pop    %ebx
80104b3a:	5e                   	pop    %esi
80104b3b:	5f                   	pop    %edi
80104b3c:	5d                   	pop    %ebp
80104b3d:	c3                   	ret    
80104b3e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104b40:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104b44:	83 ec 08             	sub    $0x8,%esp
80104b47:	50                   	push   %eax
80104b48:	ff 33                	pushl  (%ebx)
80104b4a:	e8 c1 c9 ff ff       	call   80101510 <ialloc>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	89 c7                	mov    %eax,%edi
80104b56:	0f 84 e8 00 00 00    	je     80104c44 <create+0x184>
  ilock(ip);
80104b5c:	83 ec 0c             	sub    $0xc,%esp
80104b5f:	50                   	push   %eax
80104b60:	e8 1b cb ff ff       	call   80101680 <ilock>
  ip->major = major;
80104b65:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104b69:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b6d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104b71:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b75:	b8 01 00 00 00       	mov    $0x1,%eax
80104b7a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b7e:	89 3c 24             	mov    %edi,(%esp)
80104b81:	e8 4a ca ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b86:	83 c4 10             	add    $0x10,%esp
80104b89:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104b8e:	74 50                	je     80104be0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b90:	83 ec 04             	sub    $0x4,%esp
80104b93:	ff 77 04             	pushl  0x4(%edi)
80104b96:	56                   	push   %esi
80104b97:	53                   	push   %ebx
80104b98:	e8 83 d2 ff ff       	call   80101e20 <dirlink>
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	85 c0                	test   %eax,%eax
80104ba2:	0f 88 8f 00 00 00    	js     80104c37 <create+0x177>
  iunlockput(dp);
80104ba8:	83 ec 0c             	sub    $0xc,%esp
80104bab:	53                   	push   %ebx
80104bac:	e8 5f cd ff ff       	call   80101910 <iunlockput>
  return ip;
80104bb1:	83 c4 10             	add    $0x10,%esp
}
80104bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb7:	89 f8                	mov    %edi,%eax
80104bb9:	5b                   	pop    %ebx
80104bba:	5e                   	pop    %esi
80104bbb:	5f                   	pop    %edi
80104bbc:	5d                   	pop    %ebp
80104bbd:	c3                   	ret    
80104bbe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	57                   	push   %edi
    return 0;
80104bc4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104bc6:	e8 45 cd ff ff       	call   80101910 <iunlockput>
    return 0;
80104bcb:	83 c4 10             	add    $0x10,%esp
}
80104bce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bd1:	89 f8                	mov    %edi,%eax
80104bd3:	5b                   	pop    %ebx
80104bd4:	5e                   	pop    %esi
80104bd5:	5f                   	pop    %edi
80104bd6:	5d                   	pop    %ebp
80104bd7:	c3                   	ret    
80104bd8:	90                   	nop
80104bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104be0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104be5:	83 ec 0c             	sub    $0xc,%esp
80104be8:	53                   	push   %ebx
80104be9:	e8 e2 c9 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bee:	83 c4 0c             	add    $0xc,%esp
80104bf1:	ff 77 04             	pushl  0x4(%edi)
80104bf4:	68 44 7b 10 80       	push   $0x80107b44
80104bf9:	57                   	push   %edi
80104bfa:	e8 21 d2 ff ff       	call   80101e20 <dirlink>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	78 1c                	js     80104c22 <create+0x162>
80104c06:	83 ec 04             	sub    $0x4,%esp
80104c09:	ff 73 04             	pushl  0x4(%ebx)
80104c0c:	68 43 7b 10 80       	push   $0x80107b43
80104c11:	57                   	push   %edi
80104c12:	e8 09 d2 ff ff       	call   80101e20 <dirlink>
80104c17:	83 c4 10             	add    $0x10,%esp
80104c1a:	85 c0                	test   %eax,%eax
80104c1c:	0f 89 6e ff ff ff    	jns    80104b90 <create+0xd0>
      panic("create dots");
80104c22:	83 ec 0c             	sub    $0xc,%esp
80104c25:	68 37 7b 10 80       	push   $0x80107b37
80104c2a:	e8 61 b7 ff ff       	call   80100390 <panic>
80104c2f:	90                   	nop
    return 0;
80104c30:	31 ff                	xor    %edi,%edi
80104c32:	e9 fd fe ff ff       	jmp    80104b34 <create+0x74>
    panic("create: dirlink");
80104c37:	83 ec 0c             	sub    $0xc,%esp
80104c3a:	68 46 7b 10 80       	push   $0x80107b46
80104c3f:	e8 4c b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104c44:	83 ec 0c             	sub    $0xc,%esp
80104c47:	68 28 7b 10 80       	push   $0x80107b28
80104c4c:	e8 3f b7 ff ff       	call   80100390 <panic>
80104c51:	eb 0d                	jmp    80104c60 <argfd.constprop.1>
80104c53:	90                   	nop
80104c54:	90                   	nop
80104c55:	90                   	nop
80104c56:	90                   	nop
80104c57:	90                   	nop
80104c58:	90                   	nop
80104c59:	90                   	nop
80104c5a:	90                   	nop
80104c5b:	90                   	nop
80104c5c:	90                   	nop
80104c5d:	90                   	nop
80104c5e:	90                   	nop
80104c5f:	90                   	nop

80104c60 <argfd.constprop.1>:
argfd(int n, int *pfd, struct file **pf)
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
80104c65:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104c67:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c6a:	89 d6                	mov    %edx,%esi
80104c6c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c6f:	50                   	push   %eax
80104c70:	6a 00                	push   $0x0
80104c72:	e8 f9 fc ff ff       	call   80104970 <argint>
80104c77:	83 c4 10             	add    $0x10,%esp
80104c7a:	85 c0                	test   %eax,%eax
80104c7c:	78 2a                	js     80104ca8 <argfd.constprop.1+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c7e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c82:	77 24                	ja     80104ca8 <argfd.constprop.1+0x48>
80104c84:	e8 37 ec ff ff       	call   801038c0 <myproc>
80104c89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c8c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c90:	85 c0                	test   %eax,%eax
80104c92:	74 14                	je     80104ca8 <argfd.constprop.1+0x48>
  if(pfd)
80104c94:	85 db                	test   %ebx,%ebx
80104c96:	74 02                	je     80104c9a <argfd.constprop.1+0x3a>
    *pfd = fd;
80104c98:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c9a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c9c:	31 c0                	xor    %eax,%eax
}
80104c9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca1:	5b                   	pop    %ebx
80104ca2:	5e                   	pop    %esi
80104ca3:	5d                   	pop    %ebp
80104ca4:	c3                   	ret    
80104ca5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cad:	eb ef                	jmp    80104c9e <argfd.constprop.1+0x3e>
80104caf:	90                   	nop

80104cb0 <sys_dup>:
{
80104cb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cb1:	31 c0                	xor    %eax,%eax
{
80104cb3:	89 e5                	mov    %esp,%ebp
80104cb5:	56                   	push   %esi
80104cb6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104cb7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104cba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104cbd:	e8 9e ff ff ff       	call   80104c60 <argfd.constprop.1>
80104cc2:	85 c0                	test   %eax,%eax
80104cc4:	78 42                	js     80104d08 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104cc6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cc9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104ccb:	e8 f0 eb ff ff       	call   801038c0 <myproc>
80104cd0:	eb 0e                	jmp    80104ce0 <sys_dup+0x30>
80104cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cd8:	83 c3 01             	add    $0x1,%ebx
80104cdb:	83 fb 10             	cmp    $0x10,%ebx
80104cde:	74 28                	je     80104d08 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104ce0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ce4:	85 d2                	test   %edx,%edx
80104ce6:	75 f0                	jne    80104cd8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104ce8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104cec:	83 ec 0c             	sub    $0xc,%esp
80104cef:	ff 75 f4             	pushl  -0xc(%ebp)
80104cf2:	e8 f9 c0 ff ff       	call   80100df0 <filedup>
  return fd;
80104cf7:	83 c4 10             	add    $0x10,%esp
}
80104cfa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cfd:	89 d8                	mov    %ebx,%eax
80104cff:	5b                   	pop    %ebx
80104d00:	5e                   	pop    %esi
80104d01:	5d                   	pop    %ebp
80104d02:	c3                   	ret    
80104d03:	90                   	nop
80104d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d08:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d0b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d10:	89 d8                	mov    %ebx,%eax
80104d12:	5b                   	pop    %ebx
80104d13:	5e                   	pop    %esi
80104d14:	5d                   	pop    %ebp
80104d15:	c3                   	ret    
80104d16:	8d 76 00             	lea    0x0(%esi),%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d20 <sys_read>:
{
80104d20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d21:	31 c0                	xor    %eax,%eax
{
80104d23:	89 e5                	mov    %esp,%ebp
80104d25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d2b:	e8 30 ff ff ff       	call   80104c60 <argfd.constprop.1>
80104d30:	85 c0                	test   %eax,%eax
80104d32:	78 4c                	js     80104d80 <sys_read+0x60>
80104d34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d37:	83 ec 08             	sub    $0x8,%esp
80104d3a:	50                   	push   %eax
80104d3b:	6a 02                	push   $0x2
80104d3d:	e8 2e fc ff ff       	call   80104970 <argint>
80104d42:	83 c4 10             	add    $0x10,%esp
80104d45:	85 c0                	test   %eax,%eax
80104d47:	78 37                	js     80104d80 <sys_read+0x60>
80104d49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d4c:	83 ec 04             	sub    $0x4,%esp
80104d4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d52:	50                   	push   %eax
80104d53:	6a 01                	push   $0x1
80104d55:	e8 66 fc ff ff       	call   801049c0 <argptr>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	78 1f                	js     80104d80 <sys_read+0x60>
  return fileread(f, p, n);
80104d61:	83 ec 04             	sub    $0x4,%esp
80104d64:	ff 75 f0             	pushl  -0x10(%ebp)
80104d67:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d6d:	e8 ee c1 ff ff       	call   80100f60 <fileread>
80104d72:	83 c4 10             	add    $0x10,%esp
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <sys_write>:
{
80104d90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 c0 fe ff ff       	call   80104c60 <argfd.constprop.1>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_write+0x60>
80104da4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da7:	83 ec 08             	sub    $0x8,%esp
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 be fb ff ff       	call   80104970 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_write+0x60>
80104db9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbc:	83 ec 04             	sub    $0x4,%esp
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 f6 fb ff ff       	call   801049c0 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_write+0x60>
  return filewrite(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 0e c2 ff ff       	call   80100ff0 <filewrite>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_close>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e06:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e09:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e0c:	e8 4f fe ff ff       	call   80104c60 <argfd.constprop.1>
80104e11:	85 c0                	test   %eax,%eax
80104e13:	78 2b                	js     80104e40 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e15:	e8 a6 ea ff ff       	call   801038c0 <myproc>
80104e1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e1d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e20:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e27:	00 
  fileclose(f);
80104e28:	ff 75 f4             	pushl  -0xc(%ebp)
80104e2b:	e8 10 c0 ff ff       	call   80100e40 <fileclose>
  return 0;
80104e30:	83 c4 10             	add    $0x10,%esp
80104e33:	31 c0                	xor    %eax,%eax
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	89 f6                	mov    %esi,%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <sys_fstat>:
{
80104e50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e51:	31 c0                	xor    %eax,%eax
{
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e5b:	e8 00 fe ff ff       	call   80104c60 <argfd.constprop.1>
80104e60:	85 c0                	test   %eax,%eax
80104e62:	78 2c                	js     80104e90 <sys_fstat+0x40>
80104e64:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e67:	83 ec 04             	sub    $0x4,%esp
80104e6a:	6a 14                	push   $0x14
80104e6c:	50                   	push   %eax
80104e6d:	6a 01                	push   $0x1
80104e6f:	e8 4c fb ff ff       	call   801049c0 <argptr>
80104e74:	83 c4 10             	add    $0x10,%esp
80104e77:	85 c0                	test   %eax,%eax
80104e79:	78 15                	js     80104e90 <sys_fstat+0x40>
  return filestat(f, st);
80104e7b:	83 ec 08             	sub    $0x8,%esp
80104e7e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e81:	ff 75 f0             	pushl  -0x10(%ebp)
80104e84:	e8 87 c0 ff ff       	call   80100f10 <filestat>
80104e89:	83 c4 10             	add    $0x10,%esp
}
80104e8c:	c9                   	leave  
80104e8d:	c3                   	ret    
80104e8e:	66 90                	xchg   %ax,%ax
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <sys_link>:
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	57                   	push   %edi
80104ea4:	56                   	push   %esi
80104ea5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ea6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104ea9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104eac:	50                   	push   %eax
80104ead:	6a 00                	push   $0x0
80104eaf:	e8 6c fb ff ff       	call   80104a20 <argstr>
80104eb4:	83 c4 10             	add    $0x10,%esp
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 fb 00 00 00    	js     80104fba <sys_link+0x11a>
80104ebf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ec2:	83 ec 08             	sub    $0x8,%esp
80104ec5:	50                   	push   %eax
80104ec6:	6a 01                	push   $0x1
80104ec8:	e8 53 fb ff ff       	call   80104a20 <argstr>
80104ecd:	83 c4 10             	add    $0x10,%esp
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	0f 88 e2 00 00 00    	js     80104fba <sys_link+0x11a>
  begin_op();
80104ed8:	e8 a3 dd ff ff       	call   80102c80 <begin_op>
  if((ip = namei(old)) == 0){
80104edd:	83 ec 0c             	sub    $0xc,%esp
80104ee0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ee3:	e8 f8 cf ff ff       	call   80101ee0 <namei>
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	85 c0                	test   %eax,%eax
80104eed:	89 c3                	mov    %eax,%ebx
80104eef:	0f 84 ea 00 00 00    	je     80104fdf <sys_link+0x13f>
  ilock(ip);
80104ef5:	83 ec 0c             	sub    $0xc,%esp
80104ef8:	50                   	push   %eax
80104ef9:	e8 82 c7 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
80104efe:	83 c4 10             	add    $0x10,%esp
80104f01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f06:	0f 84 bb 00 00 00    	je     80104fc7 <sys_link+0x127>
  ip->nlink++;
80104f0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f11:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104f14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f17:	53                   	push   %ebx
80104f18:	e8 b3 c6 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104f1d:	89 1c 24             	mov    %ebx,(%esp)
80104f20:	e8 3b c8 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f25:	58                   	pop    %eax
80104f26:	5a                   	pop    %edx
80104f27:	57                   	push   %edi
80104f28:	ff 75 d0             	pushl  -0x30(%ebp)
80104f2b:	e8 d0 cf ff ff       	call   80101f00 <nameiparent>
80104f30:	83 c4 10             	add    $0x10,%esp
80104f33:	85 c0                	test   %eax,%eax
80104f35:	89 c6                	mov    %eax,%esi
80104f37:	74 5b                	je     80104f94 <sys_link+0xf4>
  ilock(dp);
80104f39:	83 ec 0c             	sub    $0xc,%esp
80104f3c:	50                   	push   %eax
80104f3d:	e8 3e c7 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	8b 03                	mov    (%ebx),%eax
80104f47:	39 06                	cmp    %eax,(%esi)
80104f49:	75 3d                	jne    80104f88 <sys_link+0xe8>
80104f4b:	83 ec 04             	sub    $0x4,%esp
80104f4e:	ff 73 04             	pushl  0x4(%ebx)
80104f51:	57                   	push   %edi
80104f52:	56                   	push   %esi
80104f53:	e8 c8 ce ff ff       	call   80101e20 <dirlink>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	78 29                	js     80104f88 <sys_link+0xe8>
  iunlockput(dp);
80104f5f:	83 ec 0c             	sub    $0xc,%esp
80104f62:	56                   	push   %esi
80104f63:	e8 a8 c9 ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104f68:	89 1c 24             	mov    %ebx,(%esp)
80104f6b:	e8 40 c8 ff ff       	call   801017b0 <iput>
  end_op();
80104f70:	e8 7b dd ff ff       	call   80102cf0 <end_op>
  return 0;
80104f75:	83 c4 10             	add    $0x10,%esp
80104f78:	31 c0                	xor    %eax,%eax
}
80104f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7d:	5b                   	pop    %ebx
80104f7e:	5e                   	pop    %esi
80104f7f:	5f                   	pop    %edi
80104f80:	5d                   	pop    %ebp
80104f81:	c3                   	ret    
80104f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	56                   	push   %esi
80104f8c:	e8 7f c9 ff ff       	call   80101910 <iunlockput>
    goto bad;
80104f91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f94:	83 ec 0c             	sub    $0xc,%esp
80104f97:	53                   	push   %ebx
80104f98:	e8 e3 c6 ff ff       	call   80101680 <ilock>
  ip->nlink--;
80104f9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fa2:	89 1c 24             	mov    %ebx,(%esp)
80104fa5:	e8 26 c6 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104faa:	89 1c 24             	mov    %ebx,(%esp)
80104fad:	e8 5e c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80104fb2:	e8 39 dd ff ff       	call   80102cf0 <end_op>
  return -1;
80104fb7:	83 c4 10             	add    $0x10,%esp
}
80104fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc2:	5b                   	pop    %ebx
80104fc3:	5e                   	pop    %esi
80104fc4:	5f                   	pop    %edi
80104fc5:	5d                   	pop    %ebp
80104fc6:	c3                   	ret    
    iunlockput(ip);
80104fc7:	83 ec 0c             	sub    $0xc,%esp
80104fca:	53                   	push   %ebx
80104fcb:	e8 40 c9 ff ff       	call   80101910 <iunlockput>
    end_op();
80104fd0:	e8 1b dd ff ff       	call   80102cf0 <end_op>
    return -1;
80104fd5:	83 c4 10             	add    $0x10,%esp
80104fd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fdd:	eb 9b                	jmp    80104f7a <sys_link+0xda>
    end_op();
80104fdf:	e8 0c dd ff ff       	call   80102cf0 <end_op>
    return -1;
80104fe4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe9:	eb 8f                	jmp    80104f7a <sys_link+0xda>
80104feb:	90                   	nop
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <sys_unlink>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
80104ff5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104ff6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ff9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104ffc:	50                   	push   %eax
80104ffd:	6a 00                	push   $0x0
80104fff:	e8 1c fa ff ff       	call   80104a20 <argstr>
80105004:	83 c4 10             	add    $0x10,%esp
80105007:	85 c0                	test   %eax,%eax
80105009:	0f 88 77 01 00 00    	js     80105186 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010500f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105012:	e8 69 dc ff ff       	call   80102c80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105017:	83 ec 08             	sub    $0x8,%esp
8010501a:	53                   	push   %ebx
8010501b:	ff 75 c0             	pushl  -0x40(%ebp)
8010501e:	e8 dd ce ff ff       	call   80101f00 <nameiparent>
80105023:	83 c4 10             	add    $0x10,%esp
80105026:	85 c0                	test   %eax,%eax
80105028:	89 c6                	mov    %eax,%esi
8010502a:	0f 84 60 01 00 00    	je     80105190 <sys_unlink+0x1a0>
  ilock(dp);
80105030:	83 ec 0c             	sub    $0xc,%esp
80105033:	50                   	push   %eax
80105034:	e8 47 c6 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105039:	58                   	pop    %eax
8010503a:	5a                   	pop    %edx
8010503b:	68 44 7b 10 80       	push   $0x80107b44
80105040:	53                   	push   %ebx
80105041:	e8 4a cb ff ff       	call   80101b90 <namecmp>
80105046:	83 c4 10             	add    $0x10,%esp
80105049:	85 c0                	test   %eax,%eax
8010504b:	0f 84 03 01 00 00    	je     80105154 <sys_unlink+0x164>
80105051:	83 ec 08             	sub    $0x8,%esp
80105054:	68 43 7b 10 80       	push   $0x80107b43
80105059:	53                   	push   %ebx
8010505a:	e8 31 cb ff ff       	call   80101b90 <namecmp>
8010505f:	83 c4 10             	add    $0x10,%esp
80105062:	85 c0                	test   %eax,%eax
80105064:	0f 84 ea 00 00 00    	je     80105154 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010506a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010506d:	83 ec 04             	sub    $0x4,%esp
80105070:	50                   	push   %eax
80105071:	53                   	push   %ebx
80105072:	56                   	push   %esi
80105073:	e8 38 cb ff ff       	call   80101bb0 <dirlookup>
80105078:	83 c4 10             	add    $0x10,%esp
8010507b:	85 c0                	test   %eax,%eax
8010507d:	89 c3                	mov    %eax,%ebx
8010507f:	0f 84 cf 00 00 00    	je     80105154 <sys_unlink+0x164>
  ilock(ip);
80105085:	83 ec 0c             	sub    $0xc,%esp
80105088:	50                   	push   %eax
80105089:	e8 f2 c5 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
8010508e:	83 c4 10             	add    $0x10,%esp
80105091:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105096:	0f 8e 10 01 00 00    	jle    801051ac <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010509c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050a1:	74 6d                	je     80105110 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801050a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050a6:	83 ec 04             	sub    $0x4,%esp
801050a9:	6a 10                	push   $0x10
801050ab:	6a 00                	push   $0x0
801050ad:	50                   	push   %eax
801050ae:	e8 bd f5 ff ff       	call   80104670 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050b3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050b6:	6a 10                	push   $0x10
801050b8:	ff 75 c4             	pushl  -0x3c(%ebp)
801050bb:	50                   	push   %eax
801050bc:	56                   	push   %esi
801050bd:	e8 9e c9 ff ff       	call   80101a60 <writei>
801050c2:	83 c4 20             	add    $0x20,%esp
801050c5:	83 f8 10             	cmp    $0x10,%eax
801050c8:	0f 85 eb 00 00 00    	jne    801051b9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801050ce:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050d3:	0f 84 97 00 00 00    	je     80105170 <sys_unlink+0x180>
  iunlockput(dp);
801050d9:	83 ec 0c             	sub    $0xc,%esp
801050dc:	56                   	push   %esi
801050dd:	e8 2e c8 ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
801050e2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050e7:	89 1c 24             	mov    %ebx,(%esp)
801050ea:	e8 e1 c4 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
801050ef:	89 1c 24             	mov    %ebx,(%esp)
801050f2:	e8 19 c8 ff ff       	call   80101910 <iunlockput>
  end_op();
801050f7:	e8 f4 db ff ff       	call   80102cf0 <end_op>
  return 0;
801050fc:	83 c4 10             	add    $0x10,%esp
801050ff:	31 c0                	xor    %eax,%eax
}
80105101:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105104:	5b                   	pop    %ebx
80105105:	5e                   	pop    %esi
80105106:	5f                   	pop    %edi
80105107:	5d                   	pop    %ebp
80105108:	c3                   	ret    
80105109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105110:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105114:	76 8d                	jbe    801050a3 <sys_unlink+0xb3>
80105116:	bf 20 00 00 00       	mov    $0x20,%edi
8010511b:	eb 0f                	jmp    8010512c <sys_unlink+0x13c>
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
80105120:	83 c7 10             	add    $0x10,%edi
80105123:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105126:	0f 83 77 ff ff ff    	jae    801050a3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010512c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010512f:	6a 10                	push   $0x10
80105131:	57                   	push   %edi
80105132:	50                   	push   %eax
80105133:	53                   	push   %ebx
80105134:	e8 27 c8 ff ff       	call   80101960 <readi>
80105139:	83 c4 10             	add    $0x10,%esp
8010513c:	83 f8 10             	cmp    $0x10,%eax
8010513f:	75 5e                	jne    8010519f <sys_unlink+0x1af>
    if(de.inum != 0)
80105141:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105146:	74 d8                	je     80105120 <sys_unlink+0x130>
    iunlockput(ip);
80105148:	83 ec 0c             	sub    $0xc,%esp
8010514b:	53                   	push   %ebx
8010514c:	e8 bf c7 ff ff       	call   80101910 <iunlockput>
    goto bad;
80105151:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105154:	83 ec 0c             	sub    $0xc,%esp
80105157:	56                   	push   %esi
80105158:	e8 b3 c7 ff ff       	call   80101910 <iunlockput>
  end_op();
8010515d:	e8 8e db ff ff       	call   80102cf0 <end_op>
  return -1;
80105162:	83 c4 10             	add    $0x10,%esp
80105165:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010516a:	eb 95                	jmp    80105101 <sys_unlink+0x111>
8010516c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105170:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105175:	83 ec 0c             	sub    $0xc,%esp
80105178:	56                   	push   %esi
80105179:	e8 52 c4 ff ff       	call   801015d0 <iupdate>
8010517e:	83 c4 10             	add    $0x10,%esp
80105181:	e9 53 ff ff ff       	jmp    801050d9 <sys_unlink+0xe9>
    return -1;
80105186:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010518b:	e9 71 ff ff ff       	jmp    80105101 <sys_unlink+0x111>
    end_op();
80105190:	e8 5b db ff ff       	call   80102cf0 <end_op>
    return -1;
80105195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519a:	e9 62 ff ff ff       	jmp    80105101 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010519f:	83 ec 0c             	sub    $0xc,%esp
801051a2:	68 68 7b 10 80       	push   $0x80107b68
801051a7:	e8 e4 b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801051ac:	83 ec 0c             	sub    $0xc,%esp
801051af:	68 56 7b 10 80       	push   $0x80107b56
801051b4:	e8 d7 b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801051b9:	83 ec 0c             	sub    $0xc,%esp
801051bc:	68 7a 7b 10 80       	push   $0x80107b7a
801051c1:	e8 ca b1 ff ff       	call   80100390 <panic>
801051c6:	8d 76 00             	lea    0x0(%esi),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <sys_open>:

int
sys_open(void)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801051d9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051dc:	50                   	push   %eax
801051dd:	6a 00                	push   $0x0
801051df:	e8 3c f8 ff ff       	call   80104a20 <argstr>
801051e4:	83 c4 10             	add    $0x10,%esp
801051e7:	85 c0                	test   %eax,%eax
801051e9:	0f 88 1d 01 00 00    	js     8010530c <sys_open+0x13c>
801051ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051f2:	83 ec 08             	sub    $0x8,%esp
801051f5:	50                   	push   %eax
801051f6:	6a 01                	push   $0x1
801051f8:	e8 73 f7 ff ff       	call   80104970 <argint>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	85 c0                	test   %eax,%eax
80105202:	0f 88 04 01 00 00    	js     8010530c <sys_open+0x13c>
    return -1;

  begin_op();
80105208:	e8 73 da ff ff       	call   80102c80 <begin_op>

  if(omode & O_CREATE){
8010520d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105211:	0f 85 a9 00 00 00    	jne    801052c0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105217:	83 ec 0c             	sub    $0xc,%esp
8010521a:	ff 75 e0             	pushl  -0x20(%ebp)
8010521d:	e8 be cc ff ff       	call   80101ee0 <namei>
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	85 c0                	test   %eax,%eax
80105227:	89 c6                	mov    %eax,%esi
80105229:	0f 84 b2 00 00 00    	je     801052e1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010522f:	83 ec 0c             	sub    $0xc,%esp
80105232:	50                   	push   %eax
80105233:	e8 48 c4 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105238:	83 c4 10             	add    $0x10,%esp
8010523b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105240:	0f 84 aa 00 00 00    	je     801052f0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105246:	e8 35 bb ff ff       	call   80100d80 <filealloc>
8010524b:	85 c0                	test   %eax,%eax
8010524d:	89 c7                	mov    %eax,%edi
8010524f:	0f 84 a6 00 00 00    	je     801052fb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105255:	e8 66 e6 ff ff       	call   801038c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010525a:	31 db                	xor    %ebx,%ebx
8010525c:	eb 0e                	jmp    8010526c <sys_open+0x9c>
8010525e:	66 90                	xchg   %ax,%ax
80105260:	83 c3 01             	add    $0x1,%ebx
80105263:	83 fb 10             	cmp    $0x10,%ebx
80105266:	0f 84 ac 00 00 00    	je     80105318 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010526c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105270:	85 d2                	test   %edx,%edx
80105272:	75 ec                	jne    80105260 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105274:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105277:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010527b:	56                   	push   %esi
8010527c:	e8 df c4 ff ff       	call   80101760 <iunlock>
  end_op();
80105281:	e8 6a da ff ff       	call   80102cf0 <end_op>

  f->type = FD_INODE;
80105286:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010528c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010528f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105292:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105295:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010529c:	89 d0                	mov    %edx,%eax
8010529e:	f7 d0                	not    %eax
801052a0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801052a6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801052ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052b0:	89 d8                	mov    %ebx,%eax
801052b2:	5b                   	pop    %ebx
801052b3:	5e                   	pop    %esi
801052b4:	5f                   	pop    %edi
801052b5:	5d                   	pop    %ebp
801052b6:	c3                   	ret    
801052b7:	89 f6                	mov    %esi,%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052c6:	31 c9                	xor    %ecx,%ecx
801052c8:	6a 00                	push   $0x0
801052ca:	ba 02 00 00 00       	mov    $0x2,%edx
801052cf:	e8 ec f7 ff ff       	call   80104ac0 <create>
    if(ip == 0){
801052d4:	83 c4 10             	add    $0x10,%esp
801052d7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801052d9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052db:	0f 85 65 ff ff ff    	jne    80105246 <sys_open+0x76>
      end_op();
801052e1:	e8 0a da ff ff       	call   80102cf0 <end_op>
      return -1;
801052e6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052eb:	eb c0                	jmp    801052ad <sys_open+0xdd>
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801052f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801052f3:	85 c9                	test   %ecx,%ecx
801052f5:	0f 84 4b ff ff ff    	je     80105246 <sys_open+0x76>
    iunlockput(ip);
801052fb:	83 ec 0c             	sub    $0xc,%esp
801052fe:	56                   	push   %esi
801052ff:	e8 0c c6 ff ff       	call   80101910 <iunlockput>
    end_op();
80105304:	e8 e7 d9 ff ff       	call   80102cf0 <end_op>
    return -1;
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105311:	eb 9a                	jmp    801052ad <sys_open+0xdd>
80105313:	90                   	nop
80105314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105318:	83 ec 0c             	sub    $0xc,%esp
8010531b:	57                   	push   %edi
8010531c:	e8 1f bb ff ff       	call   80100e40 <fileclose>
80105321:	83 c4 10             	add    $0x10,%esp
80105324:	eb d5                	jmp    801052fb <sys_open+0x12b>
80105326:	8d 76 00             	lea    0x0(%esi),%esi
80105329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105330 <sys_mkdir>:

int
sys_mkdir(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105336:	e8 45 d9 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010533b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010533e:	83 ec 08             	sub    $0x8,%esp
80105341:	50                   	push   %eax
80105342:	6a 00                	push   $0x0
80105344:	e8 d7 f6 ff ff       	call   80104a20 <argstr>
80105349:	83 c4 10             	add    $0x10,%esp
8010534c:	85 c0                	test   %eax,%eax
8010534e:	78 30                	js     80105380 <sys_mkdir+0x50>
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105356:	31 c9                	xor    %ecx,%ecx
80105358:	6a 00                	push   $0x0
8010535a:	ba 01 00 00 00       	mov    $0x1,%edx
8010535f:	e8 5c f7 ff ff       	call   80104ac0 <create>
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
80105369:	74 15                	je     80105380 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010536b:	83 ec 0c             	sub    $0xc,%esp
8010536e:	50                   	push   %eax
8010536f:	e8 9c c5 ff ff       	call   80101910 <iunlockput>
  end_op();
80105374:	e8 77 d9 ff ff       	call   80102cf0 <end_op>
  return 0;
80105379:	83 c4 10             	add    $0x10,%esp
8010537c:	31 c0                	xor    %eax,%eax
}
8010537e:	c9                   	leave  
8010537f:	c3                   	ret    
    end_op();
80105380:	e8 6b d9 ff ff       	call   80102cf0 <end_op>
    return -1;
80105385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010538a:	c9                   	leave  
8010538b:	c3                   	ret    
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105390 <sys_mknod>:

int
sys_mknod(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105396:	e8 e5 d8 ff ff       	call   80102c80 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010539b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010539e:	83 ec 08             	sub    $0x8,%esp
801053a1:	50                   	push   %eax
801053a2:	6a 00                	push   $0x0
801053a4:	e8 77 f6 ff ff       	call   80104a20 <argstr>
801053a9:	83 c4 10             	add    $0x10,%esp
801053ac:	85 c0                	test   %eax,%eax
801053ae:	78 60                	js     80105410 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053b3:	83 ec 08             	sub    $0x8,%esp
801053b6:	50                   	push   %eax
801053b7:	6a 01                	push   $0x1
801053b9:	e8 b2 f5 ff ff       	call   80104970 <argint>
  if((argstr(0, &path)) < 0 ||
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 4b                	js     80105410 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c8:	83 ec 08             	sub    $0x8,%esp
801053cb:	50                   	push   %eax
801053cc:	6a 02                	push   $0x2
801053ce:	e8 9d f5 ff ff       	call   80104970 <argint>
     argint(1, &major) < 0 ||
801053d3:	83 c4 10             	add    $0x10,%esp
801053d6:	85 c0                	test   %eax,%eax
801053d8:	78 36                	js     80105410 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801053da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801053de:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801053e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801053e5:	ba 03 00 00 00       	mov    $0x3,%edx
801053ea:	50                   	push   %eax
801053eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053ee:	e8 cd f6 ff ff       	call   80104ac0 <create>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	74 16                	je     80105410 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053fa:	83 ec 0c             	sub    $0xc,%esp
801053fd:	50                   	push   %eax
801053fe:	e8 0d c5 ff ff       	call   80101910 <iunlockput>
  end_op();
80105403:	e8 e8 d8 ff ff       	call   80102cf0 <end_op>
  return 0;
80105408:	83 c4 10             	add    $0x10,%esp
8010540b:	31 c0                	xor    %eax,%eax
}
8010540d:	c9                   	leave  
8010540e:	c3                   	ret    
8010540f:	90                   	nop
    end_op();
80105410:	e8 db d8 ff ff       	call   80102cf0 <end_op>
    return -1;
80105415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105420 <sys_chdir>:

int
sys_chdir(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	53                   	push   %ebx
80105425:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105428:	e8 93 e4 ff ff       	call   801038c0 <myproc>
8010542d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010542f:	e8 4c d8 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105434:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105437:	83 ec 08             	sub    $0x8,%esp
8010543a:	50                   	push   %eax
8010543b:	6a 00                	push   $0x0
8010543d:	e8 de f5 ff ff       	call   80104a20 <argstr>
80105442:	83 c4 10             	add    $0x10,%esp
80105445:	85 c0                	test   %eax,%eax
80105447:	78 77                	js     801054c0 <sys_chdir+0xa0>
80105449:	83 ec 0c             	sub    $0xc,%esp
8010544c:	ff 75 f4             	pushl  -0xc(%ebp)
8010544f:	e8 8c ca ff ff       	call   80101ee0 <namei>
80105454:	83 c4 10             	add    $0x10,%esp
80105457:	85 c0                	test   %eax,%eax
80105459:	89 c3                	mov    %eax,%ebx
8010545b:	74 63                	je     801054c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010545d:	83 ec 0c             	sub    $0xc,%esp
80105460:	50                   	push   %eax
80105461:	e8 1a c2 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
80105466:	83 c4 10             	add    $0x10,%esp
80105469:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010546e:	75 30                	jne    801054a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	53                   	push   %ebx
80105474:	e8 e7 c2 ff ff       	call   80101760 <iunlock>
  iput(curproc->cwd);
80105479:	58                   	pop    %eax
8010547a:	ff 76 68             	pushl  0x68(%esi)
8010547d:	e8 2e c3 ff ff       	call   801017b0 <iput>
  end_op();
80105482:	e8 69 d8 ff ff       	call   80102cf0 <end_op>
  curproc->cwd = ip;
80105487:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	31 c0                	xor    %eax,%eax
}
8010548f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105492:	5b                   	pop    %ebx
80105493:	5e                   	pop    %esi
80105494:	5d                   	pop    %ebp
80105495:	c3                   	ret    
80105496:	8d 76 00             	lea    0x0(%esi),%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801054a0:	83 ec 0c             	sub    $0xc,%esp
801054a3:	53                   	push   %ebx
801054a4:	e8 67 c4 ff ff       	call   80101910 <iunlockput>
    end_op();
801054a9:	e8 42 d8 ff ff       	call   80102cf0 <end_op>
    return -1;
801054ae:	83 c4 10             	add    $0x10,%esp
801054b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054b6:	eb d7                	jmp    8010548f <sys_chdir+0x6f>
801054b8:	90                   	nop
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801054c0:	e8 2b d8 ff ff       	call   80102cf0 <end_op>
    return -1;
801054c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ca:	eb c3                	jmp    8010548f <sys_chdir+0x6f>
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054d0 <name_of_inode>:
    return 1;
}*/


int
name_of_inode(struct inode *ip, struct inode *parent, char buf[DIRSIZ]) {
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	57                   	push   %edi
801054d4:	56                   	push   %esi
801054d5:	53                   	push   %ebx
801054d6:	83 ec 1c             	sub    $0x1c,%esp
801054d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    uint off;
    struct dirent de;
    for (off = 0; off < parent->size; off += sizeof(de)) {
801054dc:	8b 43 58             	mov    0x58(%ebx),%eax
801054df:	85 c0                	test   %eax,%eax
801054e1:	74 55                	je     80105538 <name_of_inode+0x68>
801054e3:	31 f6                	xor    %esi,%esi
801054e5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801054e8:	eb 0e                	jmp    801054f8 <name_of_inode+0x28>
801054ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054f0:	83 c6 10             	add    $0x10,%esi
801054f3:	39 73 58             	cmp    %esi,0x58(%ebx)
801054f6:	76 40                	jbe    80105538 <name_of_inode+0x68>
        if (readi(parent, (char*)&de, off, sizeof(de)) != sizeof(de))
801054f8:	6a 10                	push   $0x10
801054fa:	56                   	push   %esi
801054fb:	57                   	push   %edi
801054fc:	53                   	push   %ebx
801054fd:	e8 5e c4 ff ff       	call   80101960 <readi>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	83 f8 10             	cmp    $0x10,%eax
80105508:	75 3b                	jne    80105545 <name_of_inode+0x75>
            panic("couldn't read dir entry");
        if (de.inum == ip->inum) {
8010550a:	8b 55 08             	mov    0x8(%ebp),%edx
8010550d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
80105511:	3b 42 04             	cmp    0x4(%edx),%eax
80105514:	75 da                	jne    801054f0 <name_of_inode+0x20>
            safestrcpy(buf, de.name, DIRSIZ);
80105516:	8d 45 da             	lea    -0x26(%ebp),%eax
80105519:	83 ec 04             	sub    $0x4,%esp
8010551c:	6a 0e                	push   $0xe
8010551e:	50                   	push   %eax
8010551f:	ff 75 10             	pushl  0x10(%ebp)
80105522:	e8 29 f3 ff ff       	call   80104850 <safestrcpy>
            return 0;
80105527:	83 c4 10             	add    $0x10,%esp
        }
    }
    return -1;
}
8010552a:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return 0;
8010552d:	31 c0                	xor    %eax,%eax
}
8010552f:	5b                   	pop    %ebx
80105530:	5e                   	pop    %esi
80105531:	5f                   	pop    %edi
80105532:	5d                   	pop    %ebp
80105533:	c3                   	ret    
80105534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105538:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010553b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105540:	5b                   	pop    %ebx
80105541:	5e                   	pop    %esi
80105542:	5f                   	pop    %edi
80105543:	5d                   	pop    %ebp
80105544:	c3                   	ret    
            panic("couldn't read dir entry");
80105545:	83 ec 0c             	sub    $0xc,%esp
80105548:	68 89 7b 10 80       	push   $0x80107b89
8010554d:	e8 3e ae ff ff       	call   80100390 <panic>
80105552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <name_for_inode>:

int
name_for_inode(char* buf, int n, struct inode *ip) {
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
80105566:	83 ec 38             	sub    $0x38,%esp
80105569:	8b 5d 10             	mov    0x10(%ebp),%ebx
    int path_offset;
    struct inode *parent;
    char node_name[DIRSIZ];
    if (ip->inum == namei("/")->inum) { //namei is inefficient but iget isn't exported for some reason
8010556c:	8b 73 04             	mov    0x4(%ebx),%esi
8010556f:	68 0e 79 10 80       	push   $0x8010790e
80105574:	e8 67 c9 ff ff       	call   80101ee0 <namei>
80105579:	83 c4 10             	add    $0x10,%esp
8010557c:	3b 70 04             	cmp    0x4(%eax),%esi
8010557f:	74 27                	je     801055a8 <name_for_inode+0x48>
        buf[0] = '/';
        return 1;
    } else if (ip->type == T_DIR) {
80105581:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80105585:	66 83 f8 01          	cmp    $0x1,%ax
80105589:	74 45                	je     801055d0 <name_for_inode+0x70>
        } else {
            buf[path_offset++] = '/';
        }
        iunlock(parent); //free
        return path_offset;
    } else if (ip->type == T_DEV || ip->type == T_FILE) {
8010558b:	83 e8 02             	sub    $0x2,%eax
8010558e:	66 83 f8 01          	cmp    $0x1,%ax
80105592:	76 2c                	jbe    801055c0 <name_for_inode+0x60>
        panic("process cwd is a device node / file, not a directory!");
    } else {
        panic("unknown inode type");
80105594:	83 ec 0c             	sub    $0xc,%esp
80105597:	68 a1 7b 10 80       	push   $0x80107ba1
8010559c:	e8 ef ad ff ff       	call   80100390 <panic>
801055a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        buf[0] = '/';
801055a8:	8b 45 08             	mov    0x8(%ebp),%eax
801055ab:	c6 00 2f             	movb   $0x2f,(%eax)
        return 1;
801055ae:	b8 01 00 00 00       	mov    $0x1,%eax
    }
}
801055b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055b6:	5b                   	pop    %ebx
801055b7:	5e                   	pop    %esi
801055b8:	5f                   	pop    %edi
801055b9:	5d                   	pop    %ebp
801055ba:	c3                   	ret    
801055bb:	90                   	nop
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        panic("process cwd is a device node / file, not a directory!");
801055c0:	83 ec 0c             	sub    $0xc,%esp
801055c3:	68 dc 7b 10 80       	push   $0x80107bdc
801055c8:	e8 c3 ad ff ff       	call   80100390 <panic>
801055cd:	8d 76 00             	lea    0x0(%esi),%esi
        parent = dirlookup(ip, "..", 0);
801055d0:	83 ec 04             	sub    $0x4,%esp
        if (name_of_inode(ip, parent, node_name)) {
801055d3:	8d 7d da             	lea    -0x26(%ebp),%edi
        parent = dirlookup(ip, "..", 0);
801055d6:	6a 00                	push   $0x0
801055d8:	68 43 7b 10 80       	push   $0x80107b43
801055dd:	53                   	push   %ebx
801055de:	e8 cd c5 ff ff       	call   80101bb0 <dirlookup>
801055e3:	89 c6                	mov    %eax,%esi
        ilock(parent);
801055e5:	89 04 24             	mov    %eax,(%esp)
801055e8:	e8 93 c0 ff ff       	call   80101680 <ilock>
        if (name_of_inode(ip, parent, node_name)) {
801055ed:	83 c4 0c             	add    $0xc,%esp
801055f0:	57                   	push   %edi
801055f1:	56                   	push   %esi
801055f2:	53                   	push   %ebx
801055f3:	e8 d8 fe ff ff       	call   801054d0 <name_of_inode>
801055f8:	83 c4 10             	add    $0x10,%esp
801055fb:	85 c0                	test   %eax,%eax
801055fd:	75 72                	jne    80105671 <name_for_inode+0x111>
        path_offset = name_for_inode(buf, n, parent);
801055ff:	83 ec 04             	sub    $0x4,%esp
80105602:	56                   	push   %esi
80105603:	ff 75 0c             	pushl  0xc(%ebp)
80105606:	ff 75 08             	pushl  0x8(%ebp)
80105609:	e8 52 ff ff ff       	call   80105560 <name_for_inode>
8010560e:	89 c3                	mov    %eax,%ebx
        safestrcpy(buf + path_offset, node_name, n - path_offset);
80105610:	8b 45 0c             	mov    0xc(%ebp),%eax
80105613:	83 c4 0c             	add    $0xc,%esp
80105616:	29 d8                	sub    %ebx,%eax
80105618:	50                   	push   %eax
80105619:	8b 45 08             	mov    0x8(%ebp),%eax
8010561c:	57                   	push   %edi
8010561d:	01 d8                	add    %ebx,%eax
8010561f:	50                   	push   %eax
80105620:	e8 2b f2 ff ff       	call   80104850 <safestrcpy>
        path_offset += strlen(node_name);
80105625:	89 3c 24             	mov    %edi,(%esp)
80105628:	e8 63 f2 ff ff       	call   80104890 <strlen>
8010562d:	01 c3                	add    %eax,%ebx
        if (path_offset == n - 1) {
8010562f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	83 e8 01             	sub    $0x1,%eax
80105638:	39 c3                	cmp    %eax,%ebx
8010563a:	75 14                	jne    80105650 <name_for_inode+0xf0>
            buf[path_offset] = '\0';
8010563c:	8b 45 08             	mov    0x8(%ebp),%eax
8010563f:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            return n;
80105643:	8b 45 0c             	mov    0xc(%ebp),%eax
80105646:	e9 68 ff ff ff       	jmp    801055b3 <name_for_inode+0x53>
8010564b:	90                   	nop
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            buf[path_offset++] = '/';
80105650:	8d 43 01             	lea    0x1(%ebx),%eax
        iunlock(parent); //free
80105653:	83 ec 0c             	sub    $0xc,%esp
            buf[path_offset++] = '/';
80105656:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105659:	8b 45 08             	mov    0x8(%ebp),%eax
8010565c:	c6 04 18 2f          	movb   $0x2f,(%eax,%ebx,1)
        iunlock(parent); //free
80105660:	56                   	push   %esi
80105661:	e8 fa c0 ff ff       	call   80101760 <iunlock>
80105666:	83 c4 10             	add    $0x10,%esp
80105669:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010566c:	e9 42 ff ff ff       	jmp    801055b3 <name_for_inode+0x53>
            panic("could not find name of inode in parent!");
80105671:	83 ec 0c             	sub    $0xc,%esp
80105674:	68 b4 7b 10 80       	push   $0x80107bb4
80105679:	e8 12 ad ff ff       	call   80100390 <panic>
8010567e:	66 90                	xchg   %ax,%ax

80105680 <sys_pwd>:

int
sys_pwd(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	53                   	push   %ebx
80105684:	83 ec 14             	sub    $0x14,%esp
    char *p;
    int n;
    struct proc *curproc = myproc();
80105687:	e8 34 e2 ff ff       	call   801038c0 <myproc>
8010568c:	89 c3                	mov    %eax,%ebx
    if(argint(1, &n) < 0 || argptr(0, &p, n) < 0)
8010568e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105691:	83 ec 08             	sub    $0x8,%esp
80105694:	50                   	push   %eax
80105695:	6a 01                	push   $0x1
80105697:	e8 d4 f2 ff ff       	call   80104970 <argint>
8010569c:	83 c4 10             	add    $0x10,%esp
8010569f:	85 c0                	test   %eax,%eax
801056a1:	78 35                	js     801056d8 <sys_pwd+0x58>
801056a3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056a6:	83 ec 04             	sub    $0x4,%esp
801056a9:	ff 75 f4             	pushl  -0xc(%ebp)
801056ac:	50                   	push   %eax
801056ad:	6a 00                	push   $0x0
801056af:	e8 0c f3 ff ff       	call   801049c0 <argptr>
801056b4:	83 c4 10             	add    $0x10,%esp
801056b7:	85 c0                	test   %eax,%eax
801056b9:	78 1d                	js     801056d8 <sys_pwd+0x58>
        return -1;
    return name_for_inode(p, n, curproc->cwd);
801056bb:	83 ec 04             	sub    $0x4,%esp
801056be:	ff 73 68             	pushl  0x68(%ebx)
801056c1:	ff 75 f4             	pushl  -0xc(%ebp)
801056c4:	ff 75 f0             	pushl  -0x10(%ebp)
801056c7:	e8 94 fe ff ff       	call   80105560 <name_for_inode>
801056cc:	83 c4 10             	add    $0x10,%esp
}
801056cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d2:	c9                   	leave  
801056d3:	c3                   	ret    
801056d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801056d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056dd:	eb f0                	jmp    801056cf <sys_pwd+0x4f>
801056df:	90                   	nop

801056e0 <sys_exec>:

int
sys_exec(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	57                   	push   %edi
801056e4:	56                   	push   %esi
801056e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801056ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056f2:	50                   	push   %eax
801056f3:	6a 00                	push   $0x0
801056f5:	e8 26 f3 ff ff       	call   80104a20 <argstr>
801056fa:	83 c4 10             	add    $0x10,%esp
801056fd:	85 c0                	test   %eax,%eax
801056ff:	0f 88 87 00 00 00    	js     8010578c <sys_exec+0xac>
80105705:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010570b:	83 ec 08             	sub    $0x8,%esp
8010570e:	50                   	push   %eax
8010570f:	6a 01                	push   $0x1
80105711:	e8 5a f2 ff ff       	call   80104970 <argint>
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	85 c0                	test   %eax,%eax
8010571b:	78 6f                	js     8010578c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010571d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105723:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105726:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105728:	68 80 00 00 00       	push   $0x80
8010572d:	6a 00                	push   $0x0
8010572f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105735:	50                   	push   %eax
80105736:	e8 35 ef ff ff       	call   80104670 <memset>
8010573b:	83 c4 10             	add    $0x10,%esp
8010573e:	eb 2c                	jmp    8010576c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105740:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105746:	85 c0                	test   %eax,%eax
80105748:	74 56                	je     801057a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010574a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105750:	83 ec 08             	sub    $0x8,%esp
80105753:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105756:	52                   	push   %edx
80105757:	50                   	push   %eax
80105758:	e8 a3 f1 ff ff       	call   80104900 <fetchstr>
8010575d:	83 c4 10             	add    $0x10,%esp
80105760:	85 c0                	test   %eax,%eax
80105762:	78 28                	js     8010578c <sys_exec+0xac>
  for(i=0;; i++){
80105764:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105767:	83 fb 20             	cmp    $0x20,%ebx
8010576a:	74 20                	je     8010578c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010576c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105772:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105779:	83 ec 08             	sub    $0x8,%esp
8010577c:	57                   	push   %edi
8010577d:	01 f0                	add    %esi,%eax
8010577f:	50                   	push   %eax
80105780:	e8 3b f1 ff ff       	call   801048c0 <fetchint>
80105785:	83 c4 10             	add    $0x10,%esp
80105788:	85 c0                	test   %eax,%eax
8010578a:	79 b4                	jns    80105740 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010578c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010578f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105794:	5b                   	pop    %ebx
80105795:	5e                   	pop    %esi
80105796:	5f                   	pop    %edi
80105797:	5d                   	pop    %ebp
80105798:	c3                   	ret    
80105799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801057a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801057a6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801057a9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801057b0:	00 00 00 00 
  return exec(path, argv);
801057b4:	50                   	push   %eax
801057b5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801057bb:	e8 50 b2 ff ff       	call   80100a10 <exec>
801057c0:	83 c4 10             	add    $0x10,%esp
}
801057c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057c6:	5b                   	pop    %ebx
801057c7:	5e                   	pop    %esi
801057c8:	5f                   	pop    %edi
801057c9:	5d                   	pop    %ebp
801057ca:	c3                   	ret    
801057cb:	90                   	nop
801057cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057d0 <sys_pipe>:

int
sys_pipe(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	57                   	push   %edi
801057d4:	56                   	push   %esi
801057d5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801057d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057dc:	6a 08                	push   $0x8
801057de:	50                   	push   %eax
801057df:	6a 00                	push   $0x0
801057e1:	e8 da f1 ff ff       	call   801049c0 <argptr>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	85 c0                	test   %eax,%eax
801057eb:	0f 88 ae 00 00 00    	js     8010589f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057f1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057f4:	83 ec 08             	sub    $0x8,%esp
801057f7:	50                   	push   %eax
801057f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057fb:	50                   	push   %eax
801057fc:	e8 1f db ff ff       	call   80103320 <pipealloc>
80105801:	83 c4 10             	add    $0x10,%esp
80105804:	85 c0                	test   %eax,%eax
80105806:	0f 88 93 00 00 00    	js     8010589f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010580c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010580f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105811:	e8 aa e0 ff ff       	call   801038c0 <myproc>
80105816:	eb 10                	jmp    80105828 <sys_pipe+0x58>
80105818:	90                   	nop
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105820:	83 c3 01             	add    $0x1,%ebx
80105823:	83 fb 10             	cmp    $0x10,%ebx
80105826:	74 60                	je     80105888 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105828:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010582c:	85 f6                	test   %esi,%esi
8010582e:	75 f0                	jne    80105820 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105830:	8d 73 08             	lea    0x8(%ebx),%esi
80105833:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105837:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010583a:	e8 81 e0 ff ff       	call   801038c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010583f:	31 d2                	xor    %edx,%edx
80105841:	eb 0d                	jmp    80105850 <sys_pipe+0x80>
80105843:	90                   	nop
80105844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105848:	83 c2 01             	add    $0x1,%edx
8010584b:	83 fa 10             	cmp    $0x10,%edx
8010584e:	74 28                	je     80105878 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105850:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105854:	85 c9                	test   %ecx,%ecx
80105856:	75 f0                	jne    80105848 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105858:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010585c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010585f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105861:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105864:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105867:	31 c0                	xor    %eax,%eax
}
80105869:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010586c:	5b                   	pop    %ebx
8010586d:	5e                   	pop    %esi
8010586e:	5f                   	pop    %edi
8010586f:	5d                   	pop    %ebp
80105870:	c3                   	ret    
80105871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105878:	e8 43 e0 ff ff       	call   801038c0 <myproc>
8010587d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105884:	00 
80105885:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105888:	83 ec 0c             	sub    $0xc,%esp
8010588b:	ff 75 e0             	pushl  -0x20(%ebp)
8010588e:	e8 ad b5 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105893:	58                   	pop    %eax
80105894:	ff 75 e4             	pushl  -0x1c(%ebp)
80105897:	e8 a4 b5 ff ff       	call   80100e40 <fileclose>
    return -1;
8010589c:	83 c4 10             	add    $0x10,%esp
8010589f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058a4:	eb c3                	jmp    80105869 <sys_pipe+0x99>
801058a6:	66 90                	xchg   %ax,%ax
801058a8:	66 90                	xchg   %ax,%ax
801058aa:	66 90                	xchg   %ax,%ax
801058ac:	66 90                	xchg   %ax,%ax
801058ae:	66 90                	xchg   %ax,%ax

801058b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801058b3:	5d                   	pop    %ebp
  return fork();
801058b4:	e9 a7 e1 ff ff       	jmp    80103a60 <fork>
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058c0 <sys_exit>:

int
sys_exit(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801058c6:	e8 35 e4 ff ff       	call   80103d00 <exit>
  return 0;  // not reached
}
801058cb:	31 c0                	xor    %eax,%eax
801058cd:	c9                   	leave  
801058ce:	c3                   	ret    
801058cf:	90                   	nop

801058d0 <sys_wait>:

int
sys_wait(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801058d3:	5d                   	pop    %ebp
  return wait();
801058d4:	e9 67 e6 ff ff       	jmp    80103f40 <wait>
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_kill>:

int
sys_kill(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801058e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e9:	50                   	push   %eax
801058ea:	6a 00                	push   $0x0
801058ec:	e8 7f f0 ff ff       	call   80104970 <argint>
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	85 c0                	test   %eax,%eax
801058f6:	78 18                	js     80105910 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	ff 75 f4             	pushl  -0xc(%ebp)
801058fe:	e8 8d e7 ff ff       	call   80104090 <kill>
80105903:	83 c4 10             	add    $0x10,%esp
}
80105906:	c9                   	leave  
80105907:	c3                   	ret    
80105908:	90                   	nop
80105909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_getpid>:

int
sys_getpid(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105926:	e8 95 df ff ff       	call   801038c0 <myproc>
8010592b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010592e:	c9                   	leave  
8010592f:	c3                   	ret    

80105930 <sys_sbrk>:

int
sys_sbrk(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105934:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105937:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010593a:	50                   	push   %eax
8010593b:	6a 00                	push   $0x0
8010593d:	e8 2e f0 ff ff       	call   80104970 <argint>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	85 c0                	test   %eax,%eax
80105947:	78 27                	js     80105970 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105949:	e8 72 df ff ff       	call   801038c0 <myproc>
  if(growproc(n) < 0)
8010594e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105951:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105953:	ff 75 f4             	pushl  -0xc(%ebp)
80105956:	e8 85 e0 ff ff       	call   801039e0 <growproc>
8010595b:	83 c4 10             	add    $0x10,%esp
8010595e:	85 c0                	test   %eax,%eax
80105960:	78 0e                	js     80105970 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105962:	89 d8                	mov    %ebx,%eax
80105964:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105967:	c9                   	leave  
80105968:	c3                   	ret    
80105969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105970:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105975:	eb eb                	jmp    80105962 <sys_sbrk+0x32>
80105977:	89 f6                	mov    %esi,%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105980 <sys_sleep>:

int
sys_sleep(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105984:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105987:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010598a:	50                   	push   %eax
8010598b:	6a 00                	push   $0x0
8010598d:	e8 de ef ff ff       	call   80104970 <argint>
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	85 c0                	test   %eax,%eax
80105997:	0f 88 8a 00 00 00    	js     80105a27 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010599d:	83 ec 0c             	sub    $0xc,%esp
801059a0:	68 60 49 11 80       	push   $0x80114960
801059a5:	e8 b6 eb ff ff       	call   80104560 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801059aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059ad:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801059b0:	8b 1d a0 51 11 80    	mov    0x801151a0,%ebx
  while(ticks - ticks0 < n){
801059b6:	85 d2                	test   %edx,%edx
801059b8:	75 27                	jne    801059e1 <sys_sleep+0x61>
801059ba:	eb 54                	jmp    80105a10 <sys_sleep+0x90>
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801059c0:	83 ec 08             	sub    $0x8,%esp
801059c3:	68 60 49 11 80       	push   $0x80114960
801059c8:	68 a0 51 11 80       	push   $0x801151a0
801059cd:	e8 ae e4 ff ff       	call   80103e80 <sleep>
  while(ticks - ticks0 < n){
801059d2:	a1 a0 51 11 80       	mov    0x801151a0,%eax
801059d7:	83 c4 10             	add    $0x10,%esp
801059da:	29 d8                	sub    %ebx,%eax
801059dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801059df:	73 2f                	jae    80105a10 <sys_sleep+0x90>
    if(myproc()->killed){
801059e1:	e8 da de ff ff       	call   801038c0 <myproc>
801059e6:	8b 40 24             	mov    0x24(%eax),%eax
801059e9:	85 c0                	test   %eax,%eax
801059eb:	74 d3                	je     801059c0 <sys_sleep+0x40>
      release(&tickslock);
801059ed:	83 ec 0c             	sub    $0xc,%esp
801059f0:	68 60 49 11 80       	push   $0x80114960
801059f5:	e8 26 ec ff ff       	call   80104620 <release>
      return -1;
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105a02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	68 60 49 11 80       	push   $0x80114960
80105a18:	e8 03 ec ff ff       	call   80104620 <release>
  return 0;
80105a1d:	83 c4 10             	add    $0x10,%esp
80105a20:	31 c0                	xor    %eax,%eax
}
80105a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a25:	c9                   	leave  
80105a26:	c3                   	ret    
    return -1;
80105a27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2c:	eb f4                	jmp    80105a22 <sys_sleep+0xa2>
80105a2e:	66 90                	xchg   %ax,%ax

80105a30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	53                   	push   %ebx
80105a34:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105a37:	68 60 49 11 80       	push   $0x80114960
80105a3c:	e8 1f eb ff ff       	call   80104560 <acquire>
  xticks = ticks;
80105a41:	8b 1d a0 51 11 80    	mov    0x801151a0,%ebx
  release(&tickslock);
80105a47:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80105a4e:	e8 cd eb ff ff       	call   80104620 <release>
  return xticks;
}
80105a53:	89 d8                	mov    %ebx,%eax
80105a55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a58:	c9                   	leave  
80105a59:	c3                   	ret    
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a60 <sys_cps>:

int
sys_cps (void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
    return cps();
}
80105a63:	5d                   	pop    %ebp
    return cps();
80105a64:	e9 67 e7 ff ff       	jmp    801041d0 <cps>
80105a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a70 <sys_chpr>:

int
sys_chpr(void){
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 20             	sub    $0x20,%esp
    int pid, pr;
    if(argint(0, &pid) < 0)
80105a76:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a79:	50                   	push   %eax
80105a7a:	6a 00                	push   $0x0
80105a7c:	e8 ef ee ff ff       	call   80104970 <argint>
80105a81:	83 c4 10             	add    $0x10,%esp
80105a84:	85 c0                	test   %eax,%eax
80105a86:	78 28                	js     80105ab0 <sys_chpr+0x40>
        return -1;
    if(argint(1, &pr) < 0)
80105a88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a8b:	83 ec 08             	sub    $0x8,%esp
80105a8e:	50                   	push   %eax
80105a8f:	6a 01                	push   $0x1
80105a91:	e8 da ee ff ff       	call   80104970 <argint>
80105a96:	83 c4 10             	add    $0x10,%esp
80105a99:	85 c0                	test   %eax,%eax
80105a9b:	78 13                	js     80105ab0 <sys_chpr+0x40>
        return -1;
    return chpr(pid, pr);
80105a9d:	83 ec 08             	sub    $0x8,%esp
80105aa0:	ff 75 f4             	pushl  -0xc(%ebp)
80105aa3:	ff 75 f0             	pushl  -0x10(%ebp)
80105aa6:	e8 f5 e7 ff ff       	call   801042a0 <chpr>
80105aab:	83 c4 10             	add    $0x10,%esp
}
80105aae:	c9                   	leave  
80105aaf:	c3                   	ret    
        return -1;
80105ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ab5:	c9                   	leave  
80105ab6:	c3                   	ret    
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <sys_freeMem>:
void
sys_freeMem(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
  freeMem();
}
80105ac3:	5d                   	pop    %ebp
  freeMem();
80105ac4:	e9 d7 ca ff ff       	jmp    801025a0 <freeMem>

80105ac9 <alltraps>:
80105ac9:	1e                   	push   %ds
80105aca:	06                   	push   %es
80105acb:	0f a0                	push   %fs
80105acd:	0f a8                	push   %gs
80105acf:	60                   	pusha  
80105ad0:	66 b8 10 00          	mov    $0x10,%ax
80105ad4:	8e d8                	mov    %eax,%ds
80105ad6:	8e c0                	mov    %eax,%es
80105ad8:	54                   	push   %esp
80105ad9:	e8 c2 00 00 00       	call   80105ba0 <trap>
80105ade:	83 c4 04             	add    $0x4,%esp

80105ae1 <trapret>:
80105ae1:	61                   	popa   
80105ae2:	0f a9                	pop    %gs
80105ae4:	0f a1                	pop    %fs
80105ae6:	07                   	pop    %es
80105ae7:	1f                   	pop    %ds
80105ae8:	83 c4 08             	add    $0x8,%esp
80105aeb:	cf                   	iret   
80105aec:	66 90                	xchg   %ax,%ax
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105af0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105af1:	31 c0                	xor    %eax,%eax
{
80105af3:	89 e5                	mov    %esp,%ebp
80105af5:	83 ec 08             	sub    $0x8,%esp
80105af8:	90                   	nop
80105af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b00:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105b07:	c7 04 c5 a2 49 11 80 	movl   $0x8e000008,-0x7feeb65e(,%eax,8)
80105b0e:	08 00 00 8e 
80105b12:	66 89 14 c5 a0 49 11 	mov    %dx,-0x7feeb660(,%eax,8)
80105b19:	80 
80105b1a:	c1 ea 10             	shr    $0x10,%edx
80105b1d:	66 89 14 c5 a6 49 11 	mov    %dx,-0x7feeb65a(,%eax,8)
80105b24:	80 
  for(i = 0; i < 256; i++)
80105b25:	83 c0 01             	add    $0x1,%eax
80105b28:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b2d:	75 d1                	jne    80105b00 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b2f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105b34:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b37:	c7 05 a2 4b 11 80 08 	movl   $0xef000008,0x80114ba2
80105b3e:	00 00 ef 
  initlock(&tickslock, "time");
80105b41:	68 12 7c 10 80       	push   $0x80107c12
80105b46:	68 60 49 11 80       	push   $0x80114960
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b4b:	66 a3 a0 4b 11 80    	mov    %ax,0x80114ba0
80105b51:	c1 e8 10             	shr    $0x10,%eax
80105b54:	66 a3 a6 4b 11 80    	mov    %ax,0x80114ba6
  initlock(&tickslock, "time");
80105b5a:	e8 c1 e8 ff ff       	call   80104420 <initlock>
}
80105b5f:	83 c4 10             	add    $0x10,%esp
80105b62:	c9                   	leave  
80105b63:	c3                   	ret    
80105b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105b70 <idtinit>:

void
idtinit(void)
{
80105b70:	55                   	push   %ebp
  pd[0] = size-1;
80105b71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b76:	89 e5                	mov    %esp,%ebp
80105b78:	83 ec 10             	sub    $0x10,%esp
80105b7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b7f:	b8 a0 49 11 80       	mov    $0x801149a0,%eax
80105b84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b88:	c1 e8 10             	shr    $0x10,%eax
80105b8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105b8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b95:	c9                   	leave  
80105b96:	c3                   	ret    
80105b97:	89 f6                	mov    %esi,%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ba0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	57                   	push   %edi
80105ba4:	56                   	push   %esi
80105ba5:	53                   	push   %ebx
80105ba6:	83 ec 1c             	sub    $0x1c,%esp
80105ba9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105bac:	8b 47 30             	mov    0x30(%edi),%eax
80105baf:	83 f8 40             	cmp    $0x40,%eax
80105bb2:	0f 84 f0 00 00 00    	je     80105ca8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105bb8:	83 e8 20             	sub    $0x20,%eax
80105bbb:	83 f8 1f             	cmp    $0x1f,%eax
80105bbe:	77 10                	ja     80105bd0 <trap+0x30>
80105bc0:	ff 24 85 b8 7c 10 80 	jmp    *-0x7fef8348(,%eax,4)
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105bd0:	e8 eb dc ff ff       	call   801038c0 <myproc>
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105bda:	0f 84 14 02 00 00    	je     80105df4 <trap+0x254>
80105be0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105be4:	0f 84 0a 02 00 00    	je     80105df4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bea:	0f 20 d1             	mov    %cr2,%ecx
80105bed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bf0:	e8 ab dc ff ff       	call   801038a0 <cpuid>
80105bf5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bf8:	8b 47 34             	mov    0x34(%edi),%eax
80105bfb:	8b 77 30             	mov    0x30(%edi),%esi
80105bfe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105c01:	e8 ba dc ff ff       	call   801038c0 <myproc>
80105c06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105c09:	e8 b2 dc ff ff       	call   801038c0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105c11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105c14:	51                   	push   %ecx
80105c15:	53                   	push   %ebx
80105c16:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105c17:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c1a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105c1d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105c1e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c21:	52                   	push   %edx
80105c22:	ff 70 10             	pushl  0x10(%eax)
80105c25:	68 74 7c 10 80       	push   $0x80107c74
80105c2a:	e8 31 aa ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105c2f:	83 c4 20             	add    $0x20,%esp
80105c32:	e8 89 dc ff ff       	call   801038c0 <myproc>
80105c37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c3e:	e8 7d dc ff ff       	call   801038c0 <myproc>
80105c43:	85 c0                	test   %eax,%eax
80105c45:	74 1d                	je     80105c64 <trap+0xc4>
80105c47:	e8 74 dc ff ff       	call   801038c0 <myproc>
80105c4c:	8b 50 24             	mov    0x24(%eax),%edx
80105c4f:	85 d2                	test   %edx,%edx
80105c51:	74 11                	je     80105c64 <trap+0xc4>
80105c53:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c57:	83 e0 03             	and    $0x3,%eax
80105c5a:	66 83 f8 03          	cmp    $0x3,%ax
80105c5e:	0f 84 4c 01 00 00    	je     80105db0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c64:	e8 57 dc ff ff       	call   801038c0 <myproc>
80105c69:	85 c0                	test   %eax,%eax
80105c6b:	74 0b                	je     80105c78 <trap+0xd8>
80105c6d:	e8 4e dc ff ff       	call   801038c0 <myproc>
80105c72:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c76:	74 68                	je     80105ce0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c78:	e8 43 dc ff ff       	call   801038c0 <myproc>
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	74 19                	je     80105c9a <trap+0xfa>
80105c81:	e8 3a dc ff ff       	call   801038c0 <myproc>
80105c86:	8b 40 24             	mov    0x24(%eax),%eax
80105c89:	85 c0                	test   %eax,%eax
80105c8b:	74 0d                	je     80105c9a <trap+0xfa>
80105c8d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c91:	83 e0 03             	and    $0x3,%eax
80105c94:	66 83 f8 03          	cmp    $0x3,%ax
80105c98:	74 37                	je     80105cd1 <trap+0x131>
    exit();
}
80105c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9d:	5b                   	pop    %ebx
80105c9e:	5e                   	pop    %esi
80105c9f:	5f                   	pop    %edi
80105ca0:	5d                   	pop    %ebp
80105ca1:	c3                   	ret    
80105ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105ca8:	e8 13 dc ff ff       	call   801038c0 <myproc>
80105cad:	8b 58 24             	mov    0x24(%eax),%ebx
80105cb0:	85 db                	test   %ebx,%ebx
80105cb2:	0f 85 e8 00 00 00    	jne    80105da0 <trap+0x200>
    myproc()->tf = tf;
80105cb8:	e8 03 dc ff ff       	call   801038c0 <myproc>
80105cbd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105cc0:	e8 9b ed ff ff       	call   80104a60 <syscall>
    if(myproc()->killed)
80105cc5:	e8 f6 db ff ff       	call   801038c0 <myproc>
80105cca:	8b 48 24             	mov    0x24(%eax),%ecx
80105ccd:	85 c9                	test   %ecx,%ecx
80105ccf:	74 c9                	je     80105c9a <trap+0xfa>
}
80105cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cd4:	5b                   	pop    %ebx
80105cd5:	5e                   	pop    %esi
80105cd6:	5f                   	pop    %edi
80105cd7:	5d                   	pop    %ebp
      exit();
80105cd8:	e9 23 e0 ff ff       	jmp    80103d00 <exit>
80105cdd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ce0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ce4:	75 92                	jne    80105c78 <trap+0xd8>
    yield();
80105ce6:	e8 45 e1 ff ff       	call   80103e30 <yield>
80105ceb:	eb 8b                	jmp    80105c78 <trap+0xd8>
80105ced:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105cf0:	e8 ab db ff ff       	call   801038a0 <cpuid>
80105cf5:	85 c0                	test   %eax,%eax
80105cf7:	0f 84 c3 00 00 00    	je     80105dc0 <trap+0x220>
    lapiceoi();
80105cfd:	e8 2e cb ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d02:	e8 b9 db ff ff       	call   801038c0 <myproc>
80105d07:	85 c0                	test   %eax,%eax
80105d09:	0f 85 38 ff ff ff    	jne    80105c47 <trap+0xa7>
80105d0f:	e9 50 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105d18:	e8 d3 c9 ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80105d1d:	e8 0e cb ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d22:	e8 99 db ff ff       	call   801038c0 <myproc>
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 85 18 ff ff ff    	jne    80105c47 <trap+0xa7>
80105d2f:	e9 30 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105d38:	e8 53 02 00 00       	call   80105f90 <uartintr>
    lapiceoi();
80105d3d:	e8 ee ca ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d42:	e8 79 db ff ff       	call   801038c0 <myproc>
80105d47:	85 c0                	test   %eax,%eax
80105d49:	0f 85 f8 fe ff ff    	jne    80105c47 <trap+0xa7>
80105d4f:	e9 10 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105d58:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105d5c:	8b 77 38             	mov    0x38(%edi),%esi
80105d5f:	e8 3c db ff ff       	call   801038a0 <cpuid>
80105d64:	56                   	push   %esi
80105d65:	53                   	push   %ebx
80105d66:	50                   	push   %eax
80105d67:	68 1c 7c 10 80       	push   $0x80107c1c
80105d6c:	e8 ef a8 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105d71:	e8 ba ca ff ff       	call   80102830 <lapiceoi>
    break;
80105d76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d79:	e8 42 db ff ff       	call   801038c0 <myproc>
80105d7e:	85 c0                	test   %eax,%eax
80105d80:	0f 85 c1 fe ff ff    	jne    80105c47 <trap+0xa7>
80105d86:	e9 d9 fe ff ff       	jmp    80105c64 <trap+0xc4>
80105d8b:	90                   	nop
80105d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105d90:	e8 eb c2 ff ff       	call   80102080 <ideintr>
80105d95:	e9 63 ff ff ff       	jmp    80105cfd <trap+0x15d>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105da0:	e8 5b df ff ff       	call   80103d00 <exit>
80105da5:	e9 0e ff ff ff       	jmp    80105cb8 <trap+0x118>
80105daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105db0:	e8 4b df ff ff       	call   80103d00 <exit>
80105db5:	e9 aa fe ff ff       	jmp    80105c64 <trap+0xc4>
80105dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105dc0:	83 ec 0c             	sub    $0xc,%esp
80105dc3:	68 60 49 11 80       	push   $0x80114960
80105dc8:	e8 93 e7 ff ff       	call   80104560 <acquire>
      wakeup(&ticks);
80105dcd:	c7 04 24 a0 51 11 80 	movl   $0x801151a0,(%esp)
      ticks++;
80105dd4:	83 05 a0 51 11 80 01 	addl   $0x1,0x801151a0
      wakeup(&ticks);
80105ddb:	e8 50 e2 ff ff       	call   80104030 <wakeup>
      release(&tickslock);
80105de0:	c7 04 24 60 49 11 80 	movl   $0x80114960,(%esp)
80105de7:	e8 34 e8 ff ff       	call   80104620 <release>
80105dec:	83 c4 10             	add    $0x10,%esp
80105def:	e9 09 ff ff ff       	jmp    80105cfd <trap+0x15d>
80105df4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105df7:	e8 a4 da ff ff       	call   801038a0 <cpuid>
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	56                   	push   %esi
80105e00:	53                   	push   %ebx
80105e01:	50                   	push   %eax
80105e02:	ff 77 30             	pushl  0x30(%edi)
80105e05:	68 40 7c 10 80       	push   $0x80107c40
80105e0a:	e8 51 a8 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105e0f:	83 c4 14             	add    $0x14,%esp
80105e12:	68 17 7c 10 80       	push   $0x80107c17
80105e17:	e8 74 a5 ff ff       	call   80100390 <panic>
80105e1c:	66 90                	xchg   %ax,%ax
80105e1e:	66 90                	xchg   %ax,%ax

80105e20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105e20:	a1 c4 a5 10 80       	mov    0x8010a5c4,%eax
{
80105e25:	55                   	push   %ebp
80105e26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105e28:	85 c0                	test   %eax,%eax
80105e2a:	74 1c                	je     80105e48 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e2c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e31:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105e32:	a8 01                	test   $0x1,%al
80105e34:	74 12                	je     80105e48 <uartgetc+0x28>
80105e36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e3b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105e3c:	0f b6 c0             	movzbl %al,%eax
}
80105e3f:	5d                   	pop    %ebp
80105e40:	c3                   	ret    
80105e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e4d:	5d                   	pop    %ebp
80105e4e:	c3                   	ret    
80105e4f:	90                   	nop

80105e50 <uartputc.part.0>:
uartputc(int c)
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	57                   	push   %edi
80105e54:	56                   	push   %esi
80105e55:	53                   	push   %ebx
80105e56:	89 c7                	mov    %eax,%edi
80105e58:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e5d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e62:	83 ec 0c             	sub    $0xc,%esp
80105e65:	eb 1b                	jmp    80105e82 <uartputc.part.0+0x32>
80105e67:	89 f6                	mov    %esi,%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	6a 0a                	push   $0xa
80105e75:	e8 d6 c9 ff ff       	call   80102850 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e7a:	83 c4 10             	add    $0x10,%esp
80105e7d:	83 eb 01             	sub    $0x1,%ebx
80105e80:	74 07                	je     80105e89 <uartputc.part.0+0x39>
80105e82:	89 f2                	mov    %esi,%edx
80105e84:	ec                   	in     (%dx),%al
80105e85:	a8 20                	test   $0x20,%al
80105e87:	74 e7                	je     80105e70 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e89:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e8e:	89 f8                	mov    %edi,%eax
80105e90:	ee                   	out    %al,(%dx)
}
80105e91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e94:	5b                   	pop    %ebx
80105e95:	5e                   	pop    %esi
80105e96:	5f                   	pop    %edi
80105e97:	5d                   	pop    %ebp
80105e98:	c3                   	ret    
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ea0 <uartinit>:
{
80105ea0:	55                   	push   %ebp
80105ea1:	31 c9                	xor    %ecx,%ecx
80105ea3:	89 c8                	mov    %ecx,%eax
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	57                   	push   %edi
80105ea8:	56                   	push   %esi
80105ea9:	53                   	push   %ebx
80105eaa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105eaf:	89 da                	mov    %ebx,%edx
80105eb1:	83 ec 0c             	sub    $0xc,%esp
80105eb4:	ee                   	out    %al,(%dx)
80105eb5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105eba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ebf:	89 fa                	mov    %edi,%edx
80105ec1:	ee                   	out    %al,(%dx)
80105ec2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ec7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ecc:	ee                   	out    %al,(%dx)
80105ecd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105ed2:	89 c8                	mov    %ecx,%eax
80105ed4:	89 f2                	mov    %esi,%edx
80105ed6:	ee                   	out    %al,(%dx)
80105ed7:	b8 03 00 00 00       	mov    $0x3,%eax
80105edc:	89 fa                	mov    %edi,%edx
80105ede:	ee                   	out    %al,(%dx)
80105edf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ee4:	89 c8                	mov    %ecx,%eax
80105ee6:	ee                   	out    %al,(%dx)
80105ee7:	b8 01 00 00 00       	mov    $0x1,%eax
80105eec:	89 f2                	mov    %esi,%edx
80105eee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105eef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ef4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105ef5:	3c ff                	cmp    $0xff,%al
80105ef7:	74 5a                	je     80105f53 <uartinit+0xb3>
  uart = 1;
80105ef9:	c7 05 c4 a5 10 80 01 	movl   $0x1,0x8010a5c4
80105f00:	00 00 00 
80105f03:	89 da                	mov    %ebx,%edx
80105f05:	ec                   	in     (%dx),%al
80105f06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f0b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f0c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f0f:	bb 38 7d 10 80       	mov    $0x80107d38,%ebx
  ioapicenable(IRQ_COM1, 0);
80105f14:	6a 00                	push   $0x0
80105f16:	6a 04                	push   $0x4
80105f18:	e8 b3 c3 ff ff       	call   801022d0 <ioapicenable>
80105f1d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105f20:	b8 78 00 00 00       	mov    $0x78,%eax
80105f25:	eb 13                	jmp    80105f3a <uartinit+0x9a>
80105f27:	89 f6                	mov    %esi,%esi
80105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f30:	83 c3 01             	add    $0x1,%ebx
80105f33:	0f be 03             	movsbl (%ebx),%eax
80105f36:	84 c0                	test   %al,%al
80105f38:	74 19                	je     80105f53 <uartinit+0xb3>
  if(!uart)
80105f3a:	8b 15 c4 a5 10 80    	mov    0x8010a5c4,%edx
80105f40:	85 d2                	test   %edx,%edx
80105f42:	74 ec                	je     80105f30 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105f44:	83 c3 01             	add    $0x1,%ebx
80105f47:	e8 04 ff ff ff       	call   80105e50 <uartputc.part.0>
80105f4c:	0f be 03             	movsbl (%ebx),%eax
80105f4f:	84 c0                	test   %al,%al
80105f51:	75 e7                	jne    80105f3a <uartinit+0x9a>
}
80105f53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f56:	5b                   	pop    %ebx
80105f57:	5e                   	pop    %esi
80105f58:	5f                   	pop    %edi
80105f59:	5d                   	pop    %ebp
80105f5a:	c3                   	ret    
80105f5b:	90                   	nop
80105f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f60 <uartputc>:
  if(!uart)
80105f60:	8b 15 c4 a5 10 80    	mov    0x8010a5c4,%edx
{
80105f66:	55                   	push   %ebp
80105f67:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105f69:	85 d2                	test   %edx,%edx
{
80105f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105f6e:	74 10                	je     80105f80 <uartputc+0x20>
}
80105f70:	5d                   	pop    %ebp
80105f71:	e9 da fe ff ff       	jmp    80105e50 <uartputc.part.0>
80105f76:	8d 76 00             	lea    0x0(%esi),%esi
80105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f80:	5d                   	pop    %ebp
80105f81:	c3                   	ret    
80105f82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f90 <uartintr>:

void
uartintr(void)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f96:	68 20 5e 10 80       	push   $0x80105e20
80105f9b:	e8 70 a8 ff ff       	call   80100810 <consoleintr>
}
80105fa0:	83 c4 10             	add    $0x10,%esp
80105fa3:	c9                   	leave  
80105fa4:	c3                   	ret    

80105fa5 <vector0>:
80105fa5:	6a 00                	push   $0x0
80105fa7:	6a 00                	push   $0x0
80105fa9:	e9 1b fb ff ff       	jmp    80105ac9 <alltraps>

80105fae <vector1>:
80105fae:	6a 00                	push   $0x0
80105fb0:	6a 01                	push   $0x1
80105fb2:	e9 12 fb ff ff       	jmp    80105ac9 <alltraps>

80105fb7 <vector2>:
80105fb7:	6a 00                	push   $0x0
80105fb9:	6a 02                	push   $0x2
80105fbb:	e9 09 fb ff ff       	jmp    80105ac9 <alltraps>

80105fc0 <vector3>:
80105fc0:	6a 00                	push   $0x0
80105fc2:	6a 03                	push   $0x3
80105fc4:	e9 00 fb ff ff       	jmp    80105ac9 <alltraps>

80105fc9 <vector4>:
80105fc9:	6a 00                	push   $0x0
80105fcb:	6a 04                	push   $0x4
80105fcd:	e9 f7 fa ff ff       	jmp    80105ac9 <alltraps>

80105fd2 <vector5>:
80105fd2:	6a 00                	push   $0x0
80105fd4:	6a 05                	push   $0x5
80105fd6:	e9 ee fa ff ff       	jmp    80105ac9 <alltraps>

80105fdb <vector6>:
80105fdb:	6a 00                	push   $0x0
80105fdd:	6a 06                	push   $0x6
80105fdf:	e9 e5 fa ff ff       	jmp    80105ac9 <alltraps>

80105fe4 <vector7>:
80105fe4:	6a 00                	push   $0x0
80105fe6:	6a 07                	push   $0x7
80105fe8:	e9 dc fa ff ff       	jmp    80105ac9 <alltraps>

80105fed <vector8>:
80105fed:	6a 08                	push   $0x8
80105fef:	e9 d5 fa ff ff       	jmp    80105ac9 <alltraps>

80105ff4 <vector9>:
80105ff4:	6a 00                	push   $0x0
80105ff6:	6a 09                	push   $0x9
80105ff8:	e9 cc fa ff ff       	jmp    80105ac9 <alltraps>

80105ffd <vector10>:
80105ffd:	6a 0a                	push   $0xa
80105fff:	e9 c5 fa ff ff       	jmp    80105ac9 <alltraps>

80106004 <vector11>:
80106004:	6a 0b                	push   $0xb
80106006:	e9 be fa ff ff       	jmp    80105ac9 <alltraps>

8010600b <vector12>:
8010600b:	6a 0c                	push   $0xc
8010600d:	e9 b7 fa ff ff       	jmp    80105ac9 <alltraps>

80106012 <vector13>:
80106012:	6a 0d                	push   $0xd
80106014:	e9 b0 fa ff ff       	jmp    80105ac9 <alltraps>

80106019 <vector14>:
80106019:	6a 0e                	push   $0xe
8010601b:	e9 a9 fa ff ff       	jmp    80105ac9 <alltraps>

80106020 <vector15>:
80106020:	6a 00                	push   $0x0
80106022:	6a 0f                	push   $0xf
80106024:	e9 a0 fa ff ff       	jmp    80105ac9 <alltraps>

80106029 <vector16>:
80106029:	6a 00                	push   $0x0
8010602b:	6a 10                	push   $0x10
8010602d:	e9 97 fa ff ff       	jmp    80105ac9 <alltraps>

80106032 <vector17>:
80106032:	6a 11                	push   $0x11
80106034:	e9 90 fa ff ff       	jmp    80105ac9 <alltraps>

80106039 <vector18>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 12                	push   $0x12
8010603d:	e9 87 fa ff ff       	jmp    80105ac9 <alltraps>

80106042 <vector19>:
80106042:	6a 00                	push   $0x0
80106044:	6a 13                	push   $0x13
80106046:	e9 7e fa ff ff       	jmp    80105ac9 <alltraps>

8010604b <vector20>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 14                	push   $0x14
8010604f:	e9 75 fa ff ff       	jmp    80105ac9 <alltraps>

80106054 <vector21>:
80106054:	6a 00                	push   $0x0
80106056:	6a 15                	push   $0x15
80106058:	e9 6c fa ff ff       	jmp    80105ac9 <alltraps>

8010605d <vector22>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 16                	push   $0x16
80106061:	e9 63 fa ff ff       	jmp    80105ac9 <alltraps>

80106066 <vector23>:
80106066:	6a 00                	push   $0x0
80106068:	6a 17                	push   $0x17
8010606a:	e9 5a fa ff ff       	jmp    80105ac9 <alltraps>

8010606f <vector24>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 18                	push   $0x18
80106073:	e9 51 fa ff ff       	jmp    80105ac9 <alltraps>

80106078 <vector25>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 19                	push   $0x19
8010607c:	e9 48 fa ff ff       	jmp    80105ac9 <alltraps>

80106081 <vector26>:
80106081:	6a 00                	push   $0x0
80106083:	6a 1a                	push   $0x1a
80106085:	e9 3f fa ff ff       	jmp    80105ac9 <alltraps>

8010608a <vector27>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 1b                	push   $0x1b
8010608e:	e9 36 fa ff ff       	jmp    80105ac9 <alltraps>

80106093 <vector28>:
80106093:	6a 00                	push   $0x0
80106095:	6a 1c                	push   $0x1c
80106097:	e9 2d fa ff ff       	jmp    80105ac9 <alltraps>

8010609c <vector29>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 1d                	push   $0x1d
801060a0:	e9 24 fa ff ff       	jmp    80105ac9 <alltraps>

801060a5 <vector30>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 1e                	push   $0x1e
801060a9:	e9 1b fa ff ff       	jmp    80105ac9 <alltraps>

801060ae <vector31>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 1f                	push   $0x1f
801060b2:	e9 12 fa ff ff       	jmp    80105ac9 <alltraps>

801060b7 <vector32>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 20                	push   $0x20
801060bb:	e9 09 fa ff ff       	jmp    80105ac9 <alltraps>

801060c0 <vector33>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 21                	push   $0x21
801060c4:	e9 00 fa ff ff       	jmp    80105ac9 <alltraps>

801060c9 <vector34>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 22                	push   $0x22
801060cd:	e9 f7 f9 ff ff       	jmp    80105ac9 <alltraps>

801060d2 <vector35>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 23                	push   $0x23
801060d6:	e9 ee f9 ff ff       	jmp    80105ac9 <alltraps>

801060db <vector36>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 24                	push   $0x24
801060df:	e9 e5 f9 ff ff       	jmp    80105ac9 <alltraps>

801060e4 <vector37>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 25                	push   $0x25
801060e8:	e9 dc f9 ff ff       	jmp    80105ac9 <alltraps>

801060ed <vector38>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 26                	push   $0x26
801060f1:	e9 d3 f9 ff ff       	jmp    80105ac9 <alltraps>

801060f6 <vector39>:
801060f6:	6a 00                	push   $0x0
801060f8:	6a 27                	push   $0x27
801060fa:	e9 ca f9 ff ff       	jmp    80105ac9 <alltraps>

801060ff <vector40>:
801060ff:	6a 00                	push   $0x0
80106101:	6a 28                	push   $0x28
80106103:	e9 c1 f9 ff ff       	jmp    80105ac9 <alltraps>

80106108 <vector41>:
80106108:	6a 00                	push   $0x0
8010610a:	6a 29                	push   $0x29
8010610c:	e9 b8 f9 ff ff       	jmp    80105ac9 <alltraps>

80106111 <vector42>:
80106111:	6a 00                	push   $0x0
80106113:	6a 2a                	push   $0x2a
80106115:	e9 af f9 ff ff       	jmp    80105ac9 <alltraps>

8010611a <vector43>:
8010611a:	6a 00                	push   $0x0
8010611c:	6a 2b                	push   $0x2b
8010611e:	e9 a6 f9 ff ff       	jmp    80105ac9 <alltraps>

80106123 <vector44>:
80106123:	6a 00                	push   $0x0
80106125:	6a 2c                	push   $0x2c
80106127:	e9 9d f9 ff ff       	jmp    80105ac9 <alltraps>

8010612c <vector45>:
8010612c:	6a 00                	push   $0x0
8010612e:	6a 2d                	push   $0x2d
80106130:	e9 94 f9 ff ff       	jmp    80105ac9 <alltraps>

80106135 <vector46>:
80106135:	6a 00                	push   $0x0
80106137:	6a 2e                	push   $0x2e
80106139:	e9 8b f9 ff ff       	jmp    80105ac9 <alltraps>

8010613e <vector47>:
8010613e:	6a 00                	push   $0x0
80106140:	6a 2f                	push   $0x2f
80106142:	e9 82 f9 ff ff       	jmp    80105ac9 <alltraps>

80106147 <vector48>:
80106147:	6a 00                	push   $0x0
80106149:	6a 30                	push   $0x30
8010614b:	e9 79 f9 ff ff       	jmp    80105ac9 <alltraps>

80106150 <vector49>:
80106150:	6a 00                	push   $0x0
80106152:	6a 31                	push   $0x31
80106154:	e9 70 f9 ff ff       	jmp    80105ac9 <alltraps>

80106159 <vector50>:
80106159:	6a 00                	push   $0x0
8010615b:	6a 32                	push   $0x32
8010615d:	e9 67 f9 ff ff       	jmp    80105ac9 <alltraps>

80106162 <vector51>:
80106162:	6a 00                	push   $0x0
80106164:	6a 33                	push   $0x33
80106166:	e9 5e f9 ff ff       	jmp    80105ac9 <alltraps>

8010616b <vector52>:
8010616b:	6a 00                	push   $0x0
8010616d:	6a 34                	push   $0x34
8010616f:	e9 55 f9 ff ff       	jmp    80105ac9 <alltraps>

80106174 <vector53>:
80106174:	6a 00                	push   $0x0
80106176:	6a 35                	push   $0x35
80106178:	e9 4c f9 ff ff       	jmp    80105ac9 <alltraps>

8010617d <vector54>:
8010617d:	6a 00                	push   $0x0
8010617f:	6a 36                	push   $0x36
80106181:	e9 43 f9 ff ff       	jmp    80105ac9 <alltraps>

80106186 <vector55>:
80106186:	6a 00                	push   $0x0
80106188:	6a 37                	push   $0x37
8010618a:	e9 3a f9 ff ff       	jmp    80105ac9 <alltraps>

8010618f <vector56>:
8010618f:	6a 00                	push   $0x0
80106191:	6a 38                	push   $0x38
80106193:	e9 31 f9 ff ff       	jmp    80105ac9 <alltraps>

80106198 <vector57>:
80106198:	6a 00                	push   $0x0
8010619a:	6a 39                	push   $0x39
8010619c:	e9 28 f9 ff ff       	jmp    80105ac9 <alltraps>

801061a1 <vector58>:
801061a1:	6a 00                	push   $0x0
801061a3:	6a 3a                	push   $0x3a
801061a5:	e9 1f f9 ff ff       	jmp    80105ac9 <alltraps>

801061aa <vector59>:
801061aa:	6a 00                	push   $0x0
801061ac:	6a 3b                	push   $0x3b
801061ae:	e9 16 f9 ff ff       	jmp    80105ac9 <alltraps>

801061b3 <vector60>:
801061b3:	6a 00                	push   $0x0
801061b5:	6a 3c                	push   $0x3c
801061b7:	e9 0d f9 ff ff       	jmp    80105ac9 <alltraps>

801061bc <vector61>:
801061bc:	6a 00                	push   $0x0
801061be:	6a 3d                	push   $0x3d
801061c0:	e9 04 f9 ff ff       	jmp    80105ac9 <alltraps>

801061c5 <vector62>:
801061c5:	6a 00                	push   $0x0
801061c7:	6a 3e                	push   $0x3e
801061c9:	e9 fb f8 ff ff       	jmp    80105ac9 <alltraps>

801061ce <vector63>:
801061ce:	6a 00                	push   $0x0
801061d0:	6a 3f                	push   $0x3f
801061d2:	e9 f2 f8 ff ff       	jmp    80105ac9 <alltraps>

801061d7 <vector64>:
801061d7:	6a 00                	push   $0x0
801061d9:	6a 40                	push   $0x40
801061db:	e9 e9 f8 ff ff       	jmp    80105ac9 <alltraps>

801061e0 <vector65>:
801061e0:	6a 00                	push   $0x0
801061e2:	6a 41                	push   $0x41
801061e4:	e9 e0 f8 ff ff       	jmp    80105ac9 <alltraps>

801061e9 <vector66>:
801061e9:	6a 00                	push   $0x0
801061eb:	6a 42                	push   $0x42
801061ed:	e9 d7 f8 ff ff       	jmp    80105ac9 <alltraps>

801061f2 <vector67>:
801061f2:	6a 00                	push   $0x0
801061f4:	6a 43                	push   $0x43
801061f6:	e9 ce f8 ff ff       	jmp    80105ac9 <alltraps>

801061fb <vector68>:
801061fb:	6a 00                	push   $0x0
801061fd:	6a 44                	push   $0x44
801061ff:	e9 c5 f8 ff ff       	jmp    80105ac9 <alltraps>

80106204 <vector69>:
80106204:	6a 00                	push   $0x0
80106206:	6a 45                	push   $0x45
80106208:	e9 bc f8 ff ff       	jmp    80105ac9 <alltraps>

8010620d <vector70>:
8010620d:	6a 00                	push   $0x0
8010620f:	6a 46                	push   $0x46
80106211:	e9 b3 f8 ff ff       	jmp    80105ac9 <alltraps>

80106216 <vector71>:
80106216:	6a 00                	push   $0x0
80106218:	6a 47                	push   $0x47
8010621a:	e9 aa f8 ff ff       	jmp    80105ac9 <alltraps>

8010621f <vector72>:
8010621f:	6a 00                	push   $0x0
80106221:	6a 48                	push   $0x48
80106223:	e9 a1 f8 ff ff       	jmp    80105ac9 <alltraps>

80106228 <vector73>:
80106228:	6a 00                	push   $0x0
8010622a:	6a 49                	push   $0x49
8010622c:	e9 98 f8 ff ff       	jmp    80105ac9 <alltraps>

80106231 <vector74>:
80106231:	6a 00                	push   $0x0
80106233:	6a 4a                	push   $0x4a
80106235:	e9 8f f8 ff ff       	jmp    80105ac9 <alltraps>

8010623a <vector75>:
8010623a:	6a 00                	push   $0x0
8010623c:	6a 4b                	push   $0x4b
8010623e:	e9 86 f8 ff ff       	jmp    80105ac9 <alltraps>

80106243 <vector76>:
80106243:	6a 00                	push   $0x0
80106245:	6a 4c                	push   $0x4c
80106247:	e9 7d f8 ff ff       	jmp    80105ac9 <alltraps>

8010624c <vector77>:
8010624c:	6a 00                	push   $0x0
8010624e:	6a 4d                	push   $0x4d
80106250:	e9 74 f8 ff ff       	jmp    80105ac9 <alltraps>

80106255 <vector78>:
80106255:	6a 00                	push   $0x0
80106257:	6a 4e                	push   $0x4e
80106259:	e9 6b f8 ff ff       	jmp    80105ac9 <alltraps>

8010625e <vector79>:
8010625e:	6a 00                	push   $0x0
80106260:	6a 4f                	push   $0x4f
80106262:	e9 62 f8 ff ff       	jmp    80105ac9 <alltraps>

80106267 <vector80>:
80106267:	6a 00                	push   $0x0
80106269:	6a 50                	push   $0x50
8010626b:	e9 59 f8 ff ff       	jmp    80105ac9 <alltraps>

80106270 <vector81>:
80106270:	6a 00                	push   $0x0
80106272:	6a 51                	push   $0x51
80106274:	e9 50 f8 ff ff       	jmp    80105ac9 <alltraps>

80106279 <vector82>:
80106279:	6a 00                	push   $0x0
8010627b:	6a 52                	push   $0x52
8010627d:	e9 47 f8 ff ff       	jmp    80105ac9 <alltraps>

80106282 <vector83>:
80106282:	6a 00                	push   $0x0
80106284:	6a 53                	push   $0x53
80106286:	e9 3e f8 ff ff       	jmp    80105ac9 <alltraps>

8010628b <vector84>:
8010628b:	6a 00                	push   $0x0
8010628d:	6a 54                	push   $0x54
8010628f:	e9 35 f8 ff ff       	jmp    80105ac9 <alltraps>

80106294 <vector85>:
80106294:	6a 00                	push   $0x0
80106296:	6a 55                	push   $0x55
80106298:	e9 2c f8 ff ff       	jmp    80105ac9 <alltraps>

8010629d <vector86>:
8010629d:	6a 00                	push   $0x0
8010629f:	6a 56                	push   $0x56
801062a1:	e9 23 f8 ff ff       	jmp    80105ac9 <alltraps>

801062a6 <vector87>:
801062a6:	6a 00                	push   $0x0
801062a8:	6a 57                	push   $0x57
801062aa:	e9 1a f8 ff ff       	jmp    80105ac9 <alltraps>

801062af <vector88>:
801062af:	6a 00                	push   $0x0
801062b1:	6a 58                	push   $0x58
801062b3:	e9 11 f8 ff ff       	jmp    80105ac9 <alltraps>

801062b8 <vector89>:
801062b8:	6a 00                	push   $0x0
801062ba:	6a 59                	push   $0x59
801062bc:	e9 08 f8 ff ff       	jmp    80105ac9 <alltraps>

801062c1 <vector90>:
801062c1:	6a 00                	push   $0x0
801062c3:	6a 5a                	push   $0x5a
801062c5:	e9 ff f7 ff ff       	jmp    80105ac9 <alltraps>

801062ca <vector91>:
801062ca:	6a 00                	push   $0x0
801062cc:	6a 5b                	push   $0x5b
801062ce:	e9 f6 f7 ff ff       	jmp    80105ac9 <alltraps>

801062d3 <vector92>:
801062d3:	6a 00                	push   $0x0
801062d5:	6a 5c                	push   $0x5c
801062d7:	e9 ed f7 ff ff       	jmp    80105ac9 <alltraps>

801062dc <vector93>:
801062dc:	6a 00                	push   $0x0
801062de:	6a 5d                	push   $0x5d
801062e0:	e9 e4 f7 ff ff       	jmp    80105ac9 <alltraps>

801062e5 <vector94>:
801062e5:	6a 00                	push   $0x0
801062e7:	6a 5e                	push   $0x5e
801062e9:	e9 db f7 ff ff       	jmp    80105ac9 <alltraps>

801062ee <vector95>:
801062ee:	6a 00                	push   $0x0
801062f0:	6a 5f                	push   $0x5f
801062f2:	e9 d2 f7 ff ff       	jmp    80105ac9 <alltraps>

801062f7 <vector96>:
801062f7:	6a 00                	push   $0x0
801062f9:	6a 60                	push   $0x60
801062fb:	e9 c9 f7 ff ff       	jmp    80105ac9 <alltraps>

80106300 <vector97>:
80106300:	6a 00                	push   $0x0
80106302:	6a 61                	push   $0x61
80106304:	e9 c0 f7 ff ff       	jmp    80105ac9 <alltraps>

80106309 <vector98>:
80106309:	6a 00                	push   $0x0
8010630b:	6a 62                	push   $0x62
8010630d:	e9 b7 f7 ff ff       	jmp    80105ac9 <alltraps>

80106312 <vector99>:
80106312:	6a 00                	push   $0x0
80106314:	6a 63                	push   $0x63
80106316:	e9 ae f7 ff ff       	jmp    80105ac9 <alltraps>

8010631b <vector100>:
8010631b:	6a 00                	push   $0x0
8010631d:	6a 64                	push   $0x64
8010631f:	e9 a5 f7 ff ff       	jmp    80105ac9 <alltraps>

80106324 <vector101>:
80106324:	6a 00                	push   $0x0
80106326:	6a 65                	push   $0x65
80106328:	e9 9c f7 ff ff       	jmp    80105ac9 <alltraps>

8010632d <vector102>:
8010632d:	6a 00                	push   $0x0
8010632f:	6a 66                	push   $0x66
80106331:	e9 93 f7 ff ff       	jmp    80105ac9 <alltraps>

80106336 <vector103>:
80106336:	6a 00                	push   $0x0
80106338:	6a 67                	push   $0x67
8010633a:	e9 8a f7 ff ff       	jmp    80105ac9 <alltraps>

8010633f <vector104>:
8010633f:	6a 00                	push   $0x0
80106341:	6a 68                	push   $0x68
80106343:	e9 81 f7 ff ff       	jmp    80105ac9 <alltraps>

80106348 <vector105>:
80106348:	6a 00                	push   $0x0
8010634a:	6a 69                	push   $0x69
8010634c:	e9 78 f7 ff ff       	jmp    80105ac9 <alltraps>

80106351 <vector106>:
80106351:	6a 00                	push   $0x0
80106353:	6a 6a                	push   $0x6a
80106355:	e9 6f f7 ff ff       	jmp    80105ac9 <alltraps>

8010635a <vector107>:
8010635a:	6a 00                	push   $0x0
8010635c:	6a 6b                	push   $0x6b
8010635e:	e9 66 f7 ff ff       	jmp    80105ac9 <alltraps>

80106363 <vector108>:
80106363:	6a 00                	push   $0x0
80106365:	6a 6c                	push   $0x6c
80106367:	e9 5d f7 ff ff       	jmp    80105ac9 <alltraps>

8010636c <vector109>:
8010636c:	6a 00                	push   $0x0
8010636e:	6a 6d                	push   $0x6d
80106370:	e9 54 f7 ff ff       	jmp    80105ac9 <alltraps>

80106375 <vector110>:
80106375:	6a 00                	push   $0x0
80106377:	6a 6e                	push   $0x6e
80106379:	e9 4b f7 ff ff       	jmp    80105ac9 <alltraps>

8010637e <vector111>:
8010637e:	6a 00                	push   $0x0
80106380:	6a 6f                	push   $0x6f
80106382:	e9 42 f7 ff ff       	jmp    80105ac9 <alltraps>

80106387 <vector112>:
80106387:	6a 00                	push   $0x0
80106389:	6a 70                	push   $0x70
8010638b:	e9 39 f7 ff ff       	jmp    80105ac9 <alltraps>

80106390 <vector113>:
80106390:	6a 00                	push   $0x0
80106392:	6a 71                	push   $0x71
80106394:	e9 30 f7 ff ff       	jmp    80105ac9 <alltraps>

80106399 <vector114>:
80106399:	6a 00                	push   $0x0
8010639b:	6a 72                	push   $0x72
8010639d:	e9 27 f7 ff ff       	jmp    80105ac9 <alltraps>

801063a2 <vector115>:
801063a2:	6a 00                	push   $0x0
801063a4:	6a 73                	push   $0x73
801063a6:	e9 1e f7 ff ff       	jmp    80105ac9 <alltraps>

801063ab <vector116>:
801063ab:	6a 00                	push   $0x0
801063ad:	6a 74                	push   $0x74
801063af:	e9 15 f7 ff ff       	jmp    80105ac9 <alltraps>

801063b4 <vector117>:
801063b4:	6a 00                	push   $0x0
801063b6:	6a 75                	push   $0x75
801063b8:	e9 0c f7 ff ff       	jmp    80105ac9 <alltraps>

801063bd <vector118>:
801063bd:	6a 00                	push   $0x0
801063bf:	6a 76                	push   $0x76
801063c1:	e9 03 f7 ff ff       	jmp    80105ac9 <alltraps>

801063c6 <vector119>:
801063c6:	6a 00                	push   $0x0
801063c8:	6a 77                	push   $0x77
801063ca:	e9 fa f6 ff ff       	jmp    80105ac9 <alltraps>

801063cf <vector120>:
801063cf:	6a 00                	push   $0x0
801063d1:	6a 78                	push   $0x78
801063d3:	e9 f1 f6 ff ff       	jmp    80105ac9 <alltraps>

801063d8 <vector121>:
801063d8:	6a 00                	push   $0x0
801063da:	6a 79                	push   $0x79
801063dc:	e9 e8 f6 ff ff       	jmp    80105ac9 <alltraps>

801063e1 <vector122>:
801063e1:	6a 00                	push   $0x0
801063e3:	6a 7a                	push   $0x7a
801063e5:	e9 df f6 ff ff       	jmp    80105ac9 <alltraps>

801063ea <vector123>:
801063ea:	6a 00                	push   $0x0
801063ec:	6a 7b                	push   $0x7b
801063ee:	e9 d6 f6 ff ff       	jmp    80105ac9 <alltraps>

801063f3 <vector124>:
801063f3:	6a 00                	push   $0x0
801063f5:	6a 7c                	push   $0x7c
801063f7:	e9 cd f6 ff ff       	jmp    80105ac9 <alltraps>

801063fc <vector125>:
801063fc:	6a 00                	push   $0x0
801063fe:	6a 7d                	push   $0x7d
80106400:	e9 c4 f6 ff ff       	jmp    80105ac9 <alltraps>

80106405 <vector126>:
80106405:	6a 00                	push   $0x0
80106407:	6a 7e                	push   $0x7e
80106409:	e9 bb f6 ff ff       	jmp    80105ac9 <alltraps>

8010640e <vector127>:
8010640e:	6a 00                	push   $0x0
80106410:	6a 7f                	push   $0x7f
80106412:	e9 b2 f6 ff ff       	jmp    80105ac9 <alltraps>

80106417 <vector128>:
80106417:	6a 00                	push   $0x0
80106419:	68 80 00 00 00       	push   $0x80
8010641e:	e9 a6 f6 ff ff       	jmp    80105ac9 <alltraps>

80106423 <vector129>:
80106423:	6a 00                	push   $0x0
80106425:	68 81 00 00 00       	push   $0x81
8010642a:	e9 9a f6 ff ff       	jmp    80105ac9 <alltraps>

8010642f <vector130>:
8010642f:	6a 00                	push   $0x0
80106431:	68 82 00 00 00       	push   $0x82
80106436:	e9 8e f6 ff ff       	jmp    80105ac9 <alltraps>

8010643b <vector131>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 83 00 00 00       	push   $0x83
80106442:	e9 82 f6 ff ff       	jmp    80105ac9 <alltraps>

80106447 <vector132>:
80106447:	6a 00                	push   $0x0
80106449:	68 84 00 00 00       	push   $0x84
8010644e:	e9 76 f6 ff ff       	jmp    80105ac9 <alltraps>

80106453 <vector133>:
80106453:	6a 00                	push   $0x0
80106455:	68 85 00 00 00       	push   $0x85
8010645a:	e9 6a f6 ff ff       	jmp    80105ac9 <alltraps>

8010645f <vector134>:
8010645f:	6a 00                	push   $0x0
80106461:	68 86 00 00 00       	push   $0x86
80106466:	e9 5e f6 ff ff       	jmp    80105ac9 <alltraps>

8010646b <vector135>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 87 00 00 00       	push   $0x87
80106472:	e9 52 f6 ff ff       	jmp    80105ac9 <alltraps>

80106477 <vector136>:
80106477:	6a 00                	push   $0x0
80106479:	68 88 00 00 00       	push   $0x88
8010647e:	e9 46 f6 ff ff       	jmp    80105ac9 <alltraps>

80106483 <vector137>:
80106483:	6a 00                	push   $0x0
80106485:	68 89 00 00 00       	push   $0x89
8010648a:	e9 3a f6 ff ff       	jmp    80105ac9 <alltraps>

8010648f <vector138>:
8010648f:	6a 00                	push   $0x0
80106491:	68 8a 00 00 00       	push   $0x8a
80106496:	e9 2e f6 ff ff       	jmp    80105ac9 <alltraps>

8010649b <vector139>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 8b 00 00 00       	push   $0x8b
801064a2:	e9 22 f6 ff ff       	jmp    80105ac9 <alltraps>

801064a7 <vector140>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 8c 00 00 00       	push   $0x8c
801064ae:	e9 16 f6 ff ff       	jmp    80105ac9 <alltraps>

801064b3 <vector141>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 8d 00 00 00       	push   $0x8d
801064ba:	e9 0a f6 ff ff       	jmp    80105ac9 <alltraps>

801064bf <vector142>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 8e 00 00 00       	push   $0x8e
801064c6:	e9 fe f5 ff ff       	jmp    80105ac9 <alltraps>

801064cb <vector143>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 8f 00 00 00       	push   $0x8f
801064d2:	e9 f2 f5 ff ff       	jmp    80105ac9 <alltraps>

801064d7 <vector144>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 90 00 00 00       	push   $0x90
801064de:	e9 e6 f5 ff ff       	jmp    80105ac9 <alltraps>

801064e3 <vector145>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 91 00 00 00       	push   $0x91
801064ea:	e9 da f5 ff ff       	jmp    80105ac9 <alltraps>

801064ef <vector146>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 92 00 00 00       	push   $0x92
801064f6:	e9 ce f5 ff ff       	jmp    80105ac9 <alltraps>

801064fb <vector147>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 93 00 00 00       	push   $0x93
80106502:	e9 c2 f5 ff ff       	jmp    80105ac9 <alltraps>

80106507 <vector148>:
80106507:	6a 00                	push   $0x0
80106509:	68 94 00 00 00       	push   $0x94
8010650e:	e9 b6 f5 ff ff       	jmp    80105ac9 <alltraps>

80106513 <vector149>:
80106513:	6a 00                	push   $0x0
80106515:	68 95 00 00 00       	push   $0x95
8010651a:	e9 aa f5 ff ff       	jmp    80105ac9 <alltraps>

8010651f <vector150>:
8010651f:	6a 00                	push   $0x0
80106521:	68 96 00 00 00       	push   $0x96
80106526:	e9 9e f5 ff ff       	jmp    80105ac9 <alltraps>

8010652b <vector151>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 97 00 00 00       	push   $0x97
80106532:	e9 92 f5 ff ff       	jmp    80105ac9 <alltraps>

80106537 <vector152>:
80106537:	6a 00                	push   $0x0
80106539:	68 98 00 00 00       	push   $0x98
8010653e:	e9 86 f5 ff ff       	jmp    80105ac9 <alltraps>

80106543 <vector153>:
80106543:	6a 00                	push   $0x0
80106545:	68 99 00 00 00       	push   $0x99
8010654a:	e9 7a f5 ff ff       	jmp    80105ac9 <alltraps>

8010654f <vector154>:
8010654f:	6a 00                	push   $0x0
80106551:	68 9a 00 00 00       	push   $0x9a
80106556:	e9 6e f5 ff ff       	jmp    80105ac9 <alltraps>

8010655b <vector155>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 9b 00 00 00       	push   $0x9b
80106562:	e9 62 f5 ff ff       	jmp    80105ac9 <alltraps>

80106567 <vector156>:
80106567:	6a 00                	push   $0x0
80106569:	68 9c 00 00 00       	push   $0x9c
8010656e:	e9 56 f5 ff ff       	jmp    80105ac9 <alltraps>

80106573 <vector157>:
80106573:	6a 00                	push   $0x0
80106575:	68 9d 00 00 00       	push   $0x9d
8010657a:	e9 4a f5 ff ff       	jmp    80105ac9 <alltraps>

8010657f <vector158>:
8010657f:	6a 00                	push   $0x0
80106581:	68 9e 00 00 00       	push   $0x9e
80106586:	e9 3e f5 ff ff       	jmp    80105ac9 <alltraps>

8010658b <vector159>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 9f 00 00 00       	push   $0x9f
80106592:	e9 32 f5 ff ff       	jmp    80105ac9 <alltraps>

80106597 <vector160>:
80106597:	6a 00                	push   $0x0
80106599:	68 a0 00 00 00       	push   $0xa0
8010659e:	e9 26 f5 ff ff       	jmp    80105ac9 <alltraps>

801065a3 <vector161>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 a1 00 00 00       	push   $0xa1
801065aa:	e9 1a f5 ff ff       	jmp    80105ac9 <alltraps>

801065af <vector162>:
801065af:	6a 00                	push   $0x0
801065b1:	68 a2 00 00 00       	push   $0xa2
801065b6:	e9 0e f5 ff ff       	jmp    80105ac9 <alltraps>

801065bb <vector163>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 a3 00 00 00       	push   $0xa3
801065c2:	e9 02 f5 ff ff       	jmp    80105ac9 <alltraps>

801065c7 <vector164>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 a4 00 00 00       	push   $0xa4
801065ce:	e9 f6 f4 ff ff       	jmp    80105ac9 <alltraps>

801065d3 <vector165>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 a5 00 00 00       	push   $0xa5
801065da:	e9 ea f4 ff ff       	jmp    80105ac9 <alltraps>

801065df <vector166>:
801065df:	6a 00                	push   $0x0
801065e1:	68 a6 00 00 00       	push   $0xa6
801065e6:	e9 de f4 ff ff       	jmp    80105ac9 <alltraps>

801065eb <vector167>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 a7 00 00 00       	push   $0xa7
801065f2:	e9 d2 f4 ff ff       	jmp    80105ac9 <alltraps>

801065f7 <vector168>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 a8 00 00 00       	push   $0xa8
801065fe:	e9 c6 f4 ff ff       	jmp    80105ac9 <alltraps>

80106603 <vector169>:
80106603:	6a 00                	push   $0x0
80106605:	68 a9 00 00 00       	push   $0xa9
8010660a:	e9 ba f4 ff ff       	jmp    80105ac9 <alltraps>

8010660f <vector170>:
8010660f:	6a 00                	push   $0x0
80106611:	68 aa 00 00 00       	push   $0xaa
80106616:	e9 ae f4 ff ff       	jmp    80105ac9 <alltraps>

8010661b <vector171>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 ab 00 00 00       	push   $0xab
80106622:	e9 a2 f4 ff ff       	jmp    80105ac9 <alltraps>

80106627 <vector172>:
80106627:	6a 00                	push   $0x0
80106629:	68 ac 00 00 00       	push   $0xac
8010662e:	e9 96 f4 ff ff       	jmp    80105ac9 <alltraps>

80106633 <vector173>:
80106633:	6a 00                	push   $0x0
80106635:	68 ad 00 00 00       	push   $0xad
8010663a:	e9 8a f4 ff ff       	jmp    80105ac9 <alltraps>

8010663f <vector174>:
8010663f:	6a 00                	push   $0x0
80106641:	68 ae 00 00 00       	push   $0xae
80106646:	e9 7e f4 ff ff       	jmp    80105ac9 <alltraps>

8010664b <vector175>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 af 00 00 00       	push   $0xaf
80106652:	e9 72 f4 ff ff       	jmp    80105ac9 <alltraps>

80106657 <vector176>:
80106657:	6a 00                	push   $0x0
80106659:	68 b0 00 00 00       	push   $0xb0
8010665e:	e9 66 f4 ff ff       	jmp    80105ac9 <alltraps>

80106663 <vector177>:
80106663:	6a 00                	push   $0x0
80106665:	68 b1 00 00 00       	push   $0xb1
8010666a:	e9 5a f4 ff ff       	jmp    80105ac9 <alltraps>

8010666f <vector178>:
8010666f:	6a 00                	push   $0x0
80106671:	68 b2 00 00 00       	push   $0xb2
80106676:	e9 4e f4 ff ff       	jmp    80105ac9 <alltraps>

8010667b <vector179>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 b3 00 00 00       	push   $0xb3
80106682:	e9 42 f4 ff ff       	jmp    80105ac9 <alltraps>

80106687 <vector180>:
80106687:	6a 00                	push   $0x0
80106689:	68 b4 00 00 00       	push   $0xb4
8010668e:	e9 36 f4 ff ff       	jmp    80105ac9 <alltraps>

80106693 <vector181>:
80106693:	6a 00                	push   $0x0
80106695:	68 b5 00 00 00       	push   $0xb5
8010669a:	e9 2a f4 ff ff       	jmp    80105ac9 <alltraps>

8010669f <vector182>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 b6 00 00 00       	push   $0xb6
801066a6:	e9 1e f4 ff ff       	jmp    80105ac9 <alltraps>

801066ab <vector183>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 b7 00 00 00       	push   $0xb7
801066b2:	e9 12 f4 ff ff       	jmp    80105ac9 <alltraps>

801066b7 <vector184>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 b8 00 00 00       	push   $0xb8
801066be:	e9 06 f4 ff ff       	jmp    80105ac9 <alltraps>

801066c3 <vector185>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 b9 00 00 00       	push   $0xb9
801066ca:	e9 fa f3 ff ff       	jmp    80105ac9 <alltraps>

801066cf <vector186>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 ba 00 00 00       	push   $0xba
801066d6:	e9 ee f3 ff ff       	jmp    80105ac9 <alltraps>

801066db <vector187>:
801066db:	6a 00                	push   $0x0
801066dd:	68 bb 00 00 00       	push   $0xbb
801066e2:	e9 e2 f3 ff ff       	jmp    80105ac9 <alltraps>

801066e7 <vector188>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 bc 00 00 00       	push   $0xbc
801066ee:	e9 d6 f3 ff ff       	jmp    80105ac9 <alltraps>

801066f3 <vector189>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 bd 00 00 00       	push   $0xbd
801066fa:	e9 ca f3 ff ff       	jmp    80105ac9 <alltraps>

801066ff <vector190>:
801066ff:	6a 00                	push   $0x0
80106701:	68 be 00 00 00       	push   $0xbe
80106706:	e9 be f3 ff ff       	jmp    80105ac9 <alltraps>

8010670b <vector191>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 bf 00 00 00       	push   $0xbf
80106712:	e9 b2 f3 ff ff       	jmp    80105ac9 <alltraps>

80106717 <vector192>:
80106717:	6a 00                	push   $0x0
80106719:	68 c0 00 00 00       	push   $0xc0
8010671e:	e9 a6 f3 ff ff       	jmp    80105ac9 <alltraps>

80106723 <vector193>:
80106723:	6a 00                	push   $0x0
80106725:	68 c1 00 00 00       	push   $0xc1
8010672a:	e9 9a f3 ff ff       	jmp    80105ac9 <alltraps>

8010672f <vector194>:
8010672f:	6a 00                	push   $0x0
80106731:	68 c2 00 00 00       	push   $0xc2
80106736:	e9 8e f3 ff ff       	jmp    80105ac9 <alltraps>

8010673b <vector195>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 c3 00 00 00       	push   $0xc3
80106742:	e9 82 f3 ff ff       	jmp    80105ac9 <alltraps>

80106747 <vector196>:
80106747:	6a 00                	push   $0x0
80106749:	68 c4 00 00 00       	push   $0xc4
8010674e:	e9 76 f3 ff ff       	jmp    80105ac9 <alltraps>

80106753 <vector197>:
80106753:	6a 00                	push   $0x0
80106755:	68 c5 00 00 00       	push   $0xc5
8010675a:	e9 6a f3 ff ff       	jmp    80105ac9 <alltraps>

8010675f <vector198>:
8010675f:	6a 00                	push   $0x0
80106761:	68 c6 00 00 00       	push   $0xc6
80106766:	e9 5e f3 ff ff       	jmp    80105ac9 <alltraps>

8010676b <vector199>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 c7 00 00 00       	push   $0xc7
80106772:	e9 52 f3 ff ff       	jmp    80105ac9 <alltraps>

80106777 <vector200>:
80106777:	6a 00                	push   $0x0
80106779:	68 c8 00 00 00       	push   $0xc8
8010677e:	e9 46 f3 ff ff       	jmp    80105ac9 <alltraps>

80106783 <vector201>:
80106783:	6a 00                	push   $0x0
80106785:	68 c9 00 00 00       	push   $0xc9
8010678a:	e9 3a f3 ff ff       	jmp    80105ac9 <alltraps>

8010678f <vector202>:
8010678f:	6a 00                	push   $0x0
80106791:	68 ca 00 00 00       	push   $0xca
80106796:	e9 2e f3 ff ff       	jmp    80105ac9 <alltraps>

8010679b <vector203>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 cb 00 00 00       	push   $0xcb
801067a2:	e9 22 f3 ff ff       	jmp    80105ac9 <alltraps>

801067a7 <vector204>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 cc 00 00 00       	push   $0xcc
801067ae:	e9 16 f3 ff ff       	jmp    80105ac9 <alltraps>

801067b3 <vector205>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 cd 00 00 00       	push   $0xcd
801067ba:	e9 0a f3 ff ff       	jmp    80105ac9 <alltraps>

801067bf <vector206>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 ce 00 00 00       	push   $0xce
801067c6:	e9 fe f2 ff ff       	jmp    80105ac9 <alltraps>

801067cb <vector207>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 cf 00 00 00       	push   $0xcf
801067d2:	e9 f2 f2 ff ff       	jmp    80105ac9 <alltraps>

801067d7 <vector208>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 d0 00 00 00       	push   $0xd0
801067de:	e9 e6 f2 ff ff       	jmp    80105ac9 <alltraps>

801067e3 <vector209>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 d1 00 00 00       	push   $0xd1
801067ea:	e9 da f2 ff ff       	jmp    80105ac9 <alltraps>

801067ef <vector210>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 d2 00 00 00       	push   $0xd2
801067f6:	e9 ce f2 ff ff       	jmp    80105ac9 <alltraps>

801067fb <vector211>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 d3 00 00 00       	push   $0xd3
80106802:	e9 c2 f2 ff ff       	jmp    80105ac9 <alltraps>

80106807 <vector212>:
80106807:	6a 00                	push   $0x0
80106809:	68 d4 00 00 00       	push   $0xd4
8010680e:	e9 b6 f2 ff ff       	jmp    80105ac9 <alltraps>

80106813 <vector213>:
80106813:	6a 00                	push   $0x0
80106815:	68 d5 00 00 00       	push   $0xd5
8010681a:	e9 aa f2 ff ff       	jmp    80105ac9 <alltraps>

8010681f <vector214>:
8010681f:	6a 00                	push   $0x0
80106821:	68 d6 00 00 00       	push   $0xd6
80106826:	e9 9e f2 ff ff       	jmp    80105ac9 <alltraps>

8010682b <vector215>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 d7 00 00 00       	push   $0xd7
80106832:	e9 92 f2 ff ff       	jmp    80105ac9 <alltraps>

80106837 <vector216>:
80106837:	6a 00                	push   $0x0
80106839:	68 d8 00 00 00       	push   $0xd8
8010683e:	e9 86 f2 ff ff       	jmp    80105ac9 <alltraps>

80106843 <vector217>:
80106843:	6a 00                	push   $0x0
80106845:	68 d9 00 00 00       	push   $0xd9
8010684a:	e9 7a f2 ff ff       	jmp    80105ac9 <alltraps>

8010684f <vector218>:
8010684f:	6a 00                	push   $0x0
80106851:	68 da 00 00 00       	push   $0xda
80106856:	e9 6e f2 ff ff       	jmp    80105ac9 <alltraps>

8010685b <vector219>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 db 00 00 00       	push   $0xdb
80106862:	e9 62 f2 ff ff       	jmp    80105ac9 <alltraps>

80106867 <vector220>:
80106867:	6a 00                	push   $0x0
80106869:	68 dc 00 00 00       	push   $0xdc
8010686e:	e9 56 f2 ff ff       	jmp    80105ac9 <alltraps>

80106873 <vector221>:
80106873:	6a 00                	push   $0x0
80106875:	68 dd 00 00 00       	push   $0xdd
8010687a:	e9 4a f2 ff ff       	jmp    80105ac9 <alltraps>

8010687f <vector222>:
8010687f:	6a 00                	push   $0x0
80106881:	68 de 00 00 00       	push   $0xde
80106886:	e9 3e f2 ff ff       	jmp    80105ac9 <alltraps>

8010688b <vector223>:
8010688b:	6a 00                	push   $0x0
8010688d:	68 df 00 00 00       	push   $0xdf
80106892:	e9 32 f2 ff ff       	jmp    80105ac9 <alltraps>

80106897 <vector224>:
80106897:	6a 00                	push   $0x0
80106899:	68 e0 00 00 00       	push   $0xe0
8010689e:	e9 26 f2 ff ff       	jmp    80105ac9 <alltraps>

801068a3 <vector225>:
801068a3:	6a 00                	push   $0x0
801068a5:	68 e1 00 00 00       	push   $0xe1
801068aa:	e9 1a f2 ff ff       	jmp    80105ac9 <alltraps>

801068af <vector226>:
801068af:	6a 00                	push   $0x0
801068b1:	68 e2 00 00 00       	push   $0xe2
801068b6:	e9 0e f2 ff ff       	jmp    80105ac9 <alltraps>

801068bb <vector227>:
801068bb:	6a 00                	push   $0x0
801068bd:	68 e3 00 00 00       	push   $0xe3
801068c2:	e9 02 f2 ff ff       	jmp    80105ac9 <alltraps>

801068c7 <vector228>:
801068c7:	6a 00                	push   $0x0
801068c9:	68 e4 00 00 00       	push   $0xe4
801068ce:	e9 f6 f1 ff ff       	jmp    80105ac9 <alltraps>

801068d3 <vector229>:
801068d3:	6a 00                	push   $0x0
801068d5:	68 e5 00 00 00       	push   $0xe5
801068da:	e9 ea f1 ff ff       	jmp    80105ac9 <alltraps>

801068df <vector230>:
801068df:	6a 00                	push   $0x0
801068e1:	68 e6 00 00 00       	push   $0xe6
801068e6:	e9 de f1 ff ff       	jmp    80105ac9 <alltraps>

801068eb <vector231>:
801068eb:	6a 00                	push   $0x0
801068ed:	68 e7 00 00 00       	push   $0xe7
801068f2:	e9 d2 f1 ff ff       	jmp    80105ac9 <alltraps>

801068f7 <vector232>:
801068f7:	6a 00                	push   $0x0
801068f9:	68 e8 00 00 00       	push   $0xe8
801068fe:	e9 c6 f1 ff ff       	jmp    80105ac9 <alltraps>

80106903 <vector233>:
80106903:	6a 00                	push   $0x0
80106905:	68 e9 00 00 00       	push   $0xe9
8010690a:	e9 ba f1 ff ff       	jmp    80105ac9 <alltraps>

8010690f <vector234>:
8010690f:	6a 00                	push   $0x0
80106911:	68 ea 00 00 00       	push   $0xea
80106916:	e9 ae f1 ff ff       	jmp    80105ac9 <alltraps>

8010691b <vector235>:
8010691b:	6a 00                	push   $0x0
8010691d:	68 eb 00 00 00       	push   $0xeb
80106922:	e9 a2 f1 ff ff       	jmp    80105ac9 <alltraps>

80106927 <vector236>:
80106927:	6a 00                	push   $0x0
80106929:	68 ec 00 00 00       	push   $0xec
8010692e:	e9 96 f1 ff ff       	jmp    80105ac9 <alltraps>

80106933 <vector237>:
80106933:	6a 00                	push   $0x0
80106935:	68 ed 00 00 00       	push   $0xed
8010693a:	e9 8a f1 ff ff       	jmp    80105ac9 <alltraps>

8010693f <vector238>:
8010693f:	6a 00                	push   $0x0
80106941:	68 ee 00 00 00       	push   $0xee
80106946:	e9 7e f1 ff ff       	jmp    80105ac9 <alltraps>

8010694b <vector239>:
8010694b:	6a 00                	push   $0x0
8010694d:	68 ef 00 00 00       	push   $0xef
80106952:	e9 72 f1 ff ff       	jmp    80105ac9 <alltraps>

80106957 <vector240>:
80106957:	6a 00                	push   $0x0
80106959:	68 f0 00 00 00       	push   $0xf0
8010695e:	e9 66 f1 ff ff       	jmp    80105ac9 <alltraps>

80106963 <vector241>:
80106963:	6a 00                	push   $0x0
80106965:	68 f1 00 00 00       	push   $0xf1
8010696a:	e9 5a f1 ff ff       	jmp    80105ac9 <alltraps>

8010696f <vector242>:
8010696f:	6a 00                	push   $0x0
80106971:	68 f2 00 00 00       	push   $0xf2
80106976:	e9 4e f1 ff ff       	jmp    80105ac9 <alltraps>

8010697b <vector243>:
8010697b:	6a 00                	push   $0x0
8010697d:	68 f3 00 00 00       	push   $0xf3
80106982:	e9 42 f1 ff ff       	jmp    80105ac9 <alltraps>

80106987 <vector244>:
80106987:	6a 00                	push   $0x0
80106989:	68 f4 00 00 00       	push   $0xf4
8010698e:	e9 36 f1 ff ff       	jmp    80105ac9 <alltraps>

80106993 <vector245>:
80106993:	6a 00                	push   $0x0
80106995:	68 f5 00 00 00       	push   $0xf5
8010699a:	e9 2a f1 ff ff       	jmp    80105ac9 <alltraps>

8010699f <vector246>:
8010699f:	6a 00                	push   $0x0
801069a1:	68 f6 00 00 00       	push   $0xf6
801069a6:	e9 1e f1 ff ff       	jmp    80105ac9 <alltraps>

801069ab <vector247>:
801069ab:	6a 00                	push   $0x0
801069ad:	68 f7 00 00 00       	push   $0xf7
801069b2:	e9 12 f1 ff ff       	jmp    80105ac9 <alltraps>

801069b7 <vector248>:
801069b7:	6a 00                	push   $0x0
801069b9:	68 f8 00 00 00       	push   $0xf8
801069be:	e9 06 f1 ff ff       	jmp    80105ac9 <alltraps>

801069c3 <vector249>:
801069c3:	6a 00                	push   $0x0
801069c5:	68 f9 00 00 00       	push   $0xf9
801069ca:	e9 fa f0 ff ff       	jmp    80105ac9 <alltraps>

801069cf <vector250>:
801069cf:	6a 00                	push   $0x0
801069d1:	68 fa 00 00 00       	push   $0xfa
801069d6:	e9 ee f0 ff ff       	jmp    80105ac9 <alltraps>

801069db <vector251>:
801069db:	6a 00                	push   $0x0
801069dd:	68 fb 00 00 00       	push   $0xfb
801069e2:	e9 e2 f0 ff ff       	jmp    80105ac9 <alltraps>

801069e7 <vector252>:
801069e7:	6a 00                	push   $0x0
801069e9:	68 fc 00 00 00       	push   $0xfc
801069ee:	e9 d6 f0 ff ff       	jmp    80105ac9 <alltraps>

801069f3 <vector253>:
801069f3:	6a 00                	push   $0x0
801069f5:	68 fd 00 00 00       	push   $0xfd
801069fa:	e9 ca f0 ff ff       	jmp    80105ac9 <alltraps>

801069ff <vector254>:
801069ff:	6a 00                	push   $0x0
80106a01:	68 fe 00 00 00       	push   $0xfe
80106a06:	e9 be f0 ff ff       	jmp    80105ac9 <alltraps>

80106a0b <vector255>:
80106a0b:	6a 00                	push   $0x0
80106a0d:	68 ff 00 00 00       	push   $0xff
80106a12:	e9 b2 f0 ff ff       	jmp    80105ac9 <alltraps>
80106a17:	66 90                	xchg   %ax,%ax
80106a19:	66 90                	xchg   %ax,%ax
80106a1b:	66 90                	xchg   %ax,%ax
80106a1d:	66 90                	xchg   %ax,%ax
80106a1f:	90                   	nop

80106a20 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106a26:	89 d3                	mov    %edx,%ebx
{
80106a28:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106a2a:	c1 eb 16             	shr    $0x16,%ebx
80106a2d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106a30:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106a33:	8b 06                	mov    (%esi),%eax
80106a35:	a8 01                	test   $0x1,%al
80106a37:	74 27                	je     80106a60 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a3e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106a44:	c1 ef 0a             	shr    $0xa,%edi
}
80106a47:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106a4a:	89 fa                	mov    %edi,%edx
80106a4c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106a52:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106a55:	5b                   	pop    %ebx
80106a56:	5e                   	pop    %esi
80106a57:	5f                   	pop    %edi
80106a58:	5d                   	pop    %ebp
80106a59:	c3                   	ret    
80106a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a60:	85 c9                	test   %ecx,%ecx
80106a62:	74 2c                	je     80106a90 <walkpgdir+0x70>
80106a64:	e8 b7 ba ff ff       	call   80102520 <kalloc>
80106a69:	85 c0                	test   %eax,%eax
80106a6b:	89 c3                	mov    %eax,%ebx
80106a6d:	74 21                	je     80106a90 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106a6f:	83 ec 04             	sub    $0x4,%esp
80106a72:	68 00 10 00 00       	push   $0x1000
80106a77:	6a 00                	push   $0x0
80106a79:	50                   	push   %eax
80106a7a:	e8 f1 db ff ff       	call   80104670 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a7f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a85:	83 c4 10             	add    $0x10,%esp
80106a88:	83 c8 07             	or     $0x7,%eax
80106a8b:	89 06                	mov    %eax,(%esi)
80106a8d:	eb b5                	jmp    80106a44 <walkpgdir+0x24>
80106a8f:	90                   	nop
}
80106a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106a93:	31 c0                	xor    %eax,%eax
}
80106a95:	5b                   	pop    %ebx
80106a96:	5e                   	pop    %esi
80106a97:	5f                   	pop    %edi
80106a98:	5d                   	pop    %ebp
80106a99:	c3                   	ret    
80106a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106aa0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106aa6:	89 d3                	mov    %edx,%ebx
80106aa8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106aae:	83 ec 1c             	sub    $0x1c,%esp
80106ab1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ab4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106ab8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106abb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ac0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ac6:	29 df                	sub    %ebx,%edi
80106ac8:	83 c8 01             	or     $0x1,%eax
80106acb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106ace:	eb 15                	jmp    80106ae5 <mappages+0x45>
    if(*pte & PTE_P)
80106ad0:	f6 00 01             	testb  $0x1,(%eax)
80106ad3:	75 45                	jne    80106b1a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106ad5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106ad8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106adb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106add:	74 31                	je     80106b10 <mappages+0x70>
      break;
    a += PGSIZE;
80106adf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ae5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ae8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106aed:	89 da                	mov    %ebx,%edx
80106aef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106af2:	e8 29 ff ff ff       	call   80106a20 <walkpgdir>
80106af7:	85 c0                	test   %eax,%eax
80106af9:	75 d5                	jne    80106ad0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106afb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106afe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b03:	5b                   	pop    %ebx
80106b04:	5e                   	pop    %esi
80106b05:	5f                   	pop    %edi
80106b06:	5d                   	pop    %ebp
80106b07:	c3                   	ret    
80106b08:	90                   	nop
80106b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106b13:	31 c0                	xor    %eax,%eax
}
80106b15:	5b                   	pop    %ebx
80106b16:	5e                   	pop    %esi
80106b17:	5f                   	pop    %edi
80106b18:	5d                   	pop    %ebp
80106b19:	c3                   	ret    
      panic("remap");
80106b1a:	83 ec 0c             	sub    $0xc,%esp
80106b1d:	68 40 7d 10 80       	push   $0x80107d40
80106b22:	e8 69 98 ff ff       	call   80100390 <panic>
80106b27:	89 f6                	mov    %esi,%esi
80106b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	57                   	push   %edi
80106b34:	56                   	push   %esi
80106b35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b3c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106b3e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b44:	83 ec 1c             	sub    $0x1c,%esp
80106b47:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b4a:	39 d3                	cmp    %edx,%ebx
80106b4c:	73 66                	jae    80106bb4 <deallocuvm.part.0+0x84>
80106b4e:	89 d6                	mov    %edx,%esi
80106b50:	eb 3d                	jmp    80106b8f <deallocuvm.part.0+0x5f>
80106b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106b58:	8b 10                	mov    (%eax),%edx
80106b5a:	f6 c2 01             	test   $0x1,%dl
80106b5d:	74 26                	je     80106b85 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106b5f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106b65:	74 58                	je     80106bbf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106b67:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b6a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106b70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106b73:	52                   	push   %edx
80106b74:	e8 97 b7 ff ff       	call   80102310 <kfree>
      *pte = 0;
80106b79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b7c:	83 c4 10             	add    $0x10,%esp
80106b7f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106b85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b8b:	39 f3                	cmp    %esi,%ebx
80106b8d:	73 25                	jae    80106bb4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b8f:	31 c9                	xor    %ecx,%ecx
80106b91:	89 da                	mov    %ebx,%edx
80106b93:	89 f8                	mov    %edi,%eax
80106b95:	e8 86 fe ff ff       	call   80106a20 <walkpgdir>
    if(!pte)
80106b9a:	85 c0                	test   %eax,%eax
80106b9c:	75 ba                	jne    80106b58 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b9e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106ba4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106baa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bb0:	39 f3                	cmp    %esi,%ebx
80106bb2:	72 db                	jb     80106b8f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106bb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bba:	5b                   	pop    %ebx
80106bbb:	5e                   	pop    %esi
80106bbc:	5f                   	pop    %edi
80106bbd:	5d                   	pop    %ebp
80106bbe:	c3                   	ret    
        panic("kfree");
80106bbf:	83 ec 0c             	sub    $0xc,%esp
80106bc2:	68 c6 75 10 80       	push   $0x801075c6
80106bc7:	e8 c4 97 ff ff       	call   80100390 <panic>
80106bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bd0 <seginit>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106bd6:	e8 c5 cc ff ff       	call   801038a0 <cpuid>
80106bdb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106be1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106be6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106bea:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106bf1:	ff 00 00 
80106bf4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106bfb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bfe:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106c05:	ff 00 00 
80106c08:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106c0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c12:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106c19:	ff 00 00 
80106c1c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106c23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c26:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106c2d:	ff 00 00 
80106c30:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106c37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106c3a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80106c3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c43:	c1 e8 10             	shr    $0x10,%eax
80106c46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106c4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c4d:	0f 01 10             	lgdtl  (%eax)
}
80106c50:	c9                   	leave  
80106c51:	c3                   	ret    
80106c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c60:	a1 a4 51 11 80       	mov    0x801151a4,%eax
{
80106c65:	55                   	push   %ebp
80106c66:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c68:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c6d:	0f 22 d8             	mov    %eax,%cr3
}
80106c70:	5d                   	pop    %ebp
80106c71:	c3                   	ret    
80106c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c80 <switchuvm>:
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 1c             	sub    $0x1c,%esp
80106c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106c8c:	85 db                	test   %ebx,%ebx
80106c8e:	0f 84 cb 00 00 00    	je     80106d5f <switchuvm+0xdf>
  if(p->kstack == 0)
80106c94:	8b 43 08             	mov    0x8(%ebx),%eax
80106c97:	85 c0                	test   %eax,%eax
80106c99:	0f 84 da 00 00 00    	je     80106d79 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106c9f:	8b 43 04             	mov    0x4(%ebx),%eax
80106ca2:	85 c0                	test   %eax,%eax
80106ca4:	0f 84 c2 00 00 00    	je     80106d6c <switchuvm+0xec>
  pushcli();
80106caa:	e8 e1 d7 ff ff       	call   80104490 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106caf:	e8 7c cb ff ff       	call   80103830 <mycpu>
80106cb4:	89 c6                	mov    %eax,%esi
80106cb6:	e8 75 cb ff ff       	call   80103830 <mycpu>
80106cbb:	89 c7                	mov    %eax,%edi
80106cbd:	e8 6e cb ff ff       	call   80103830 <mycpu>
80106cc2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cc5:	83 c7 08             	add    $0x8,%edi
80106cc8:	e8 63 cb ff ff       	call   80103830 <mycpu>
80106ccd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cd0:	83 c0 08             	add    $0x8,%eax
80106cd3:	ba 67 00 00 00       	mov    $0x67,%edx
80106cd8:	c1 e8 18             	shr    $0x18,%eax
80106cdb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106ce2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106ce9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106cef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106cf4:	83 c1 08             	add    $0x8,%ecx
80106cf7:	c1 e9 10             	shr    $0x10,%ecx
80106cfa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106d00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106d05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d0c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106d11:	e8 1a cb ff ff       	call   80103830 <mycpu>
80106d16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d1d:	e8 0e cb ff ff       	call   80103830 <mycpu>
80106d22:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d26:	8b 73 08             	mov    0x8(%ebx),%esi
80106d29:	e8 02 cb ff ff       	call   80103830 <mycpu>
80106d2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d34:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d37:	e8 f4 ca ff ff       	call   80103830 <mycpu>
80106d3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106d40:	b8 28 00 00 00       	mov    $0x28,%eax
80106d45:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106d48:	8b 43 04             	mov    0x4(%ebx),%eax
80106d4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d50:	0f 22 d8             	mov    %eax,%cr3
}
80106d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d56:	5b                   	pop    %ebx
80106d57:	5e                   	pop    %esi
80106d58:	5f                   	pop    %edi
80106d59:	5d                   	pop    %ebp
  popcli();
80106d5a:	e9 71 d7 ff ff       	jmp    801044d0 <popcli>
    panic("switchuvm: no process");
80106d5f:	83 ec 0c             	sub    $0xc,%esp
80106d62:	68 46 7d 10 80       	push   $0x80107d46
80106d67:	e8 24 96 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106d6c:	83 ec 0c             	sub    $0xc,%esp
80106d6f:	68 71 7d 10 80       	push   $0x80107d71
80106d74:	e8 17 96 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106d79:	83 ec 0c             	sub    $0xc,%esp
80106d7c:	68 5c 7d 10 80       	push   $0x80107d5c
80106d81:	e8 0a 96 ff ff       	call   80100390 <panic>
80106d86:	8d 76 00             	lea    0x0(%esi),%esi
80106d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d90 <inituvm>:
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 1c             	sub    $0x1c,%esp
80106d99:	8b 75 10             	mov    0x10(%ebp),%esi
80106d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106da2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106da8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106dab:	77 49                	ja     80106df6 <inituvm+0x66>
  mem = kalloc();
80106dad:	e8 6e b7 ff ff       	call   80102520 <kalloc>
  memset(mem, 0, PGSIZE);
80106db2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106db5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106db7:	68 00 10 00 00       	push   $0x1000
80106dbc:	6a 00                	push   $0x0
80106dbe:	50                   	push   %eax
80106dbf:	e8 ac d8 ff ff       	call   80104670 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106dc4:	58                   	pop    %eax
80106dc5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dcb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dd0:	5a                   	pop    %edx
80106dd1:	6a 06                	push   $0x6
80106dd3:	50                   	push   %eax
80106dd4:	31 d2                	xor    %edx,%edx
80106dd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dd9:	e8 c2 fc ff ff       	call   80106aa0 <mappages>
  memmove(mem, init, sz);
80106dde:	89 75 10             	mov    %esi,0x10(%ebp)
80106de1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106de4:	83 c4 10             	add    $0x10,%esp
80106de7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106dea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ded:	5b                   	pop    %ebx
80106dee:	5e                   	pop    %esi
80106def:	5f                   	pop    %edi
80106df0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106df1:	e9 2a d9 ff ff       	jmp    80104720 <memmove>
    panic("inituvm: more than a page");
80106df6:	83 ec 0c             	sub    $0xc,%esp
80106df9:	68 85 7d 10 80       	push   $0x80107d85
80106dfe:	e8 8d 95 ff ff       	call   80100390 <panic>
80106e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <loaduvm>:
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
80106e16:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106e19:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e20:	0f 85 91 00 00 00    	jne    80106eb7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106e26:	8b 75 18             	mov    0x18(%ebp),%esi
80106e29:	31 db                	xor    %ebx,%ebx
80106e2b:	85 f6                	test   %esi,%esi
80106e2d:	75 1a                	jne    80106e49 <loaduvm+0x39>
80106e2f:	eb 6f                	jmp    80106ea0 <loaduvm+0x90>
80106e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e3e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106e44:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106e47:	76 57                	jbe    80106ea0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e49:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e4f:	31 c9                	xor    %ecx,%ecx
80106e51:	01 da                	add    %ebx,%edx
80106e53:	e8 c8 fb ff ff       	call   80106a20 <walkpgdir>
80106e58:	85 c0                	test   %eax,%eax
80106e5a:	74 4e                	je     80106eaa <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106e5c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e5e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106e61:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106e66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106e6b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e71:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e74:	01 d9                	add    %ebx,%ecx
80106e76:	05 00 00 00 80       	add    $0x80000000,%eax
80106e7b:	57                   	push   %edi
80106e7c:	51                   	push   %ecx
80106e7d:	50                   	push   %eax
80106e7e:	ff 75 10             	pushl  0x10(%ebp)
80106e81:	e8 da aa ff ff       	call   80101960 <readi>
80106e86:	83 c4 10             	add    $0x10,%esp
80106e89:	39 f8                	cmp    %edi,%eax
80106e8b:	74 ab                	je     80106e38 <loaduvm+0x28>
}
80106e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e95:	5b                   	pop    %ebx
80106e96:	5e                   	pop    %esi
80106e97:	5f                   	pop    %edi
80106e98:	5d                   	pop    %ebp
80106e99:	c3                   	ret    
80106e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ea3:	31 c0                	xor    %eax,%eax
}
80106ea5:	5b                   	pop    %ebx
80106ea6:	5e                   	pop    %esi
80106ea7:	5f                   	pop    %edi
80106ea8:	5d                   	pop    %ebp
80106ea9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106eaa:	83 ec 0c             	sub    $0xc,%esp
80106ead:	68 9f 7d 10 80       	push   $0x80107d9f
80106eb2:	e8 d9 94 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106eb7:	83 ec 0c             	sub    $0xc,%esp
80106eba:	68 40 7e 10 80       	push   $0x80107e40
80106ebf:	e8 cc 94 ff ff       	call   80100390 <panic>
80106ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ed0 <allocuvm>:
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106ed9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106edc:	85 ff                	test   %edi,%edi
80106ede:	0f 88 8e 00 00 00    	js     80106f72 <allocuvm+0xa2>
  if(newsz < oldsz)
80106ee4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ee7:	0f 82 93 00 00 00    	jb     80106f80 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106eed:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ef0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106ef6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106efc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106eff:	0f 86 7e 00 00 00    	jbe    80106f83 <allocuvm+0xb3>
80106f05:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106f08:	8b 7d 08             	mov    0x8(%ebp),%edi
80106f0b:	eb 42                	jmp    80106f4f <allocuvm+0x7f>
80106f0d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	68 00 10 00 00       	push   $0x1000
80106f18:	6a 00                	push   $0x0
80106f1a:	50                   	push   %eax
80106f1b:	e8 50 d7 ff ff       	call   80104670 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f20:	58                   	pop    %eax
80106f21:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f27:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f2c:	5a                   	pop    %edx
80106f2d:	6a 06                	push   $0x6
80106f2f:	50                   	push   %eax
80106f30:	89 da                	mov    %ebx,%edx
80106f32:	89 f8                	mov    %edi,%eax
80106f34:	e8 67 fb ff ff       	call   80106aa0 <mappages>
80106f39:	83 c4 10             	add    $0x10,%esp
80106f3c:	85 c0                	test   %eax,%eax
80106f3e:	78 50                	js     80106f90 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106f40:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f46:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106f49:	0f 86 81 00 00 00    	jbe    80106fd0 <allocuvm+0x100>
    mem = kalloc();
80106f4f:	e8 cc b5 ff ff       	call   80102520 <kalloc>
    if(mem == 0){
80106f54:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106f56:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106f58:	75 b6                	jne    80106f10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106f5a:	83 ec 0c             	sub    $0xc,%esp
80106f5d:	68 bd 7d 10 80       	push   $0x80107dbd
80106f62:	e8 f9 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106f67:	83 c4 10             	add    $0x10,%esp
80106f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f6d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f70:	77 6e                	ja     80106fe0 <allocuvm+0x110>
}
80106f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106f75:	31 ff                	xor    %edi,%edi
}
80106f77:	89 f8                	mov    %edi,%eax
80106f79:	5b                   	pop    %ebx
80106f7a:	5e                   	pop    %esi
80106f7b:	5f                   	pop    %edi
80106f7c:	5d                   	pop    %ebp
80106f7d:	c3                   	ret    
80106f7e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106f80:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106f83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f86:	89 f8                	mov    %edi,%eax
80106f88:	5b                   	pop    %ebx
80106f89:	5e                   	pop    %esi
80106f8a:	5f                   	pop    %edi
80106f8b:	5d                   	pop    %ebp
80106f8c:	c3                   	ret    
80106f8d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106f90:	83 ec 0c             	sub    $0xc,%esp
80106f93:	68 d5 7d 10 80       	push   $0x80107dd5
80106f98:	e8 c3 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106f9d:	83 c4 10             	add    $0x10,%esp
80106fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fa3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fa6:	76 0d                	jbe    80106fb5 <allocuvm+0xe5>
80106fa8:	89 c1                	mov    %eax,%ecx
80106faa:	8b 55 10             	mov    0x10(%ebp),%edx
80106fad:	8b 45 08             	mov    0x8(%ebp),%eax
80106fb0:	e8 7b fb ff ff       	call   80106b30 <deallocuvm.part.0>
      kfree(mem);
80106fb5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106fb8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106fba:	56                   	push   %esi
80106fbb:	e8 50 b3 ff ff       	call   80102310 <kfree>
      return 0;
80106fc0:	83 c4 10             	add    $0x10,%esp
}
80106fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fc6:	89 f8                	mov    %edi,%eax
80106fc8:	5b                   	pop    %ebx
80106fc9:	5e                   	pop    %esi
80106fca:	5f                   	pop    %edi
80106fcb:	5d                   	pop    %ebp
80106fcc:	c3                   	ret    
80106fcd:	8d 76 00             	lea    0x0(%esi),%esi
80106fd0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106fd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fd6:	5b                   	pop    %ebx
80106fd7:	89 f8                	mov    %edi,%eax
80106fd9:	5e                   	pop    %esi
80106fda:	5f                   	pop    %edi
80106fdb:	5d                   	pop    %ebp
80106fdc:	c3                   	ret    
80106fdd:	8d 76 00             	lea    0x0(%esi),%esi
80106fe0:	89 c1                	mov    %eax,%ecx
80106fe2:	8b 55 10             	mov    0x10(%ebp),%edx
80106fe5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106fe8:	31 ff                	xor    %edi,%edi
80106fea:	e8 41 fb ff ff       	call   80106b30 <deallocuvm.part.0>
80106fef:	eb 92                	jmp    80106f83 <allocuvm+0xb3>
80106ff1:	eb 0d                	jmp    80107000 <deallocuvm>
80106ff3:	90                   	nop
80106ff4:	90                   	nop
80106ff5:	90                   	nop
80106ff6:	90                   	nop
80106ff7:	90                   	nop
80106ff8:	90                   	nop
80106ff9:	90                   	nop
80106ffa:	90                   	nop
80106ffb:	90                   	nop
80106ffc:	90                   	nop
80106ffd:	90                   	nop
80106ffe:	90                   	nop
80106fff:	90                   	nop

80107000 <deallocuvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	8b 55 0c             	mov    0xc(%ebp),%edx
80107006:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107009:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010700c:	39 d1                	cmp    %edx,%ecx
8010700e:	73 10                	jae    80107020 <deallocuvm+0x20>
}
80107010:	5d                   	pop    %ebp
80107011:	e9 1a fb ff ff       	jmp    80106b30 <deallocuvm.part.0>
80107016:	8d 76 00             	lea    0x0(%esi),%esi
80107019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107020:	89 d0                	mov    %edx,%eax
80107022:	5d                   	pop    %ebp
80107023:	c3                   	ret    
80107024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010702a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107030 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
80107036:	83 ec 0c             	sub    $0xc,%esp
80107039:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010703c:	85 f6                	test   %esi,%esi
8010703e:	74 59                	je     80107099 <freevm+0x69>
80107040:	31 c9                	xor    %ecx,%ecx
80107042:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107047:	89 f0                	mov    %esi,%eax
80107049:	e8 e2 fa ff ff       	call   80106b30 <deallocuvm.part.0>
8010704e:	89 f3                	mov    %esi,%ebx
80107050:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107056:	eb 0f                	jmp    80107067 <freevm+0x37>
80107058:	90                   	nop
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107060:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107063:	39 fb                	cmp    %edi,%ebx
80107065:	74 23                	je     8010708a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107067:	8b 03                	mov    (%ebx),%eax
80107069:	a8 01                	test   $0x1,%al
8010706b:	74 f3                	je     80107060 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010706d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107072:	83 ec 0c             	sub    $0xc,%esp
80107075:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107078:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010707d:	50                   	push   %eax
8010707e:	e8 8d b2 ff ff       	call   80102310 <kfree>
80107083:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107086:	39 fb                	cmp    %edi,%ebx
80107088:	75 dd                	jne    80107067 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010708a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010708d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107090:	5b                   	pop    %ebx
80107091:	5e                   	pop    %esi
80107092:	5f                   	pop    %edi
80107093:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107094:	e9 77 b2 ff ff       	jmp    80102310 <kfree>
    panic("freevm: no pgdir");
80107099:	83 ec 0c             	sub    $0xc,%esp
8010709c:	68 f1 7d 10 80       	push   $0x80107df1
801070a1:	e8 ea 92 ff ff       	call   80100390 <panic>
801070a6:	8d 76 00             	lea    0x0(%esi),%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070b0 <setupkvm>:
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	56                   	push   %esi
801070b4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801070b5:	e8 66 b4 ff ff       	call   80102520 <kalloc>
801070ba:	85 c0                	test   %eax,%eax
801070bc:	89 c6                	mov    %eax,%esi
801070be:	74 42                	je     80107102 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801070c0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070c3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
801070c8:	68 00 10 00 00       	push   $0x1000
801070cd:	6a 00                	push   $0x0
801070cf:	50                   	push   %eax
801070d0:	e8 9b d5 ff ff       	call   80104670 <memset>
801070d5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801070d8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801070db:	8b 4b 08             	mov    0x8(%ebx),%ecx
801070de:	83 ec 08             	sub    $0x8,%esp
801070e1:	8b 13                	mov    (%ebx),%edx
801070e3:	ff 73 0c             	pushl  0xc(%ebx)
801070e6:	50                   	push   %eax
801070e7:	29 c1                	sub    %eax,%ecx
801070e9:	89 f0                	mov    %esi,%eax
801070eb:	e8 b0 f9 ff ff       	call   80106aa0 <mappages>
801070f0:	83 c4 10             	add    $0x10,%esp
801070f3:	85 c0                	test   %eax,%eax
801070f5:	78 19                	js     80107110 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070f7:	83 c3 10             	add    $0x10,%ebx
801070fa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107100:	75 d6                	jne    801070d8 <setupkvm+0x28>
}
80107102:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107105:	89 f0                	mov    %esi,%eax
80107107:	5b                   	pop    %ebx
80107108:	5e                   	pop    %esi
80107109:	5d                   	pop    %ebp
8010710a:	c3                   	ret    
8010710b:	90                   	nop
8010710c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107110:	83 ec 0c             	sub    $0xc,%esp
80107113:	56                   	push   %esi
      return 0;
80107114:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107116:	e8 15 ff ff ff       	call   80107030 <freevm>
      return 0;
8010711b:	83 c4 10             	add    $0x10,%esp
}
8010711e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107121:	89 f0                	mov    %esi,%eax
80107123:	5b                   	pop    %ebx
80107124:	5e                   	pop    %esi
80107125:	5d                   	pop    %ebp
80107126:	c3                   	ret    
80107127:	89 f6                	mov    %esi,%esi
80107129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107130 <kvmalloc>:
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107136:	e8 75 ff ff ff       	call   801070b0 <setupkvm>
8010713b:	a3 a4 51 11 80       	mov    %eax,0x801151a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107140:	05 00 00 00 80       	add    $0x80000000,%eax
80107145:	0f 22 d8             	mov    %eax,%cr3
}
80107148:	c9                   	leave  
80107149:	c3                   	ret    
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107150 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107150:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107151:	31 c9                	xor    %ecx,%ecx
{
80107153:	89 e5                	mov    %esp,%ebp
80107155:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107158:	8b 55 0c             	mov    0xc(%ebp),%edx
8010715b:	8b 45 08             	mov    0x8(%ebp),%eax
8010715e:	e8 bd f8 ff ff       	call   80106a20 <walkpgdir>
  if(pte == 0)
80107163:	85 c0                	test   %eax,%eax
80107165:	74 05                	je     8010716c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107167:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010716a:	c9                   	leave  
8010716b:	c3                   	ret    
    panic("clearpteu");
8010716c:	83 ec 0c             	sub    $0xc,%esp
8010716f:	68 02 7e 10 80       	push   $0x80107e02
80107174:	e8 17 92 ff ff       	call   80100390 <panic>
80107179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107180 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	57                   	push   %edi
80107184:	56                   	push   %esi
80107185:	53                   	push   %ebx
80107186:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107189:	e8 22 ff ff ff       	call   801070b0 <setupkvm>
8010718e:	85 c0                	test   %eax,%eax
80107190:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107193:	0f 84 9f 00 00 00    	je     80107238 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107199:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010719c:	85 c9                	test   %ecx,%ecx
8010719e:	0f 84 94 00 00 00    	je     80107238 <copyuvm+0xb8>
801071a4:	31 ff                	xor    %edi,%edi
801071a6:	eb 4a                	jmp    801071f2 <copyuvm+0x72>
801071a8:	90                   	nop
801071a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801071b0:	83 ec 04             	sub    $0x4,%esp
801071b3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801071b9:	68 00 10 00 00       	push   $0x1000
801071be:	53                   	push   %ebx
801071bf:	50                   	push   %eax
801071c0:	e8 5b d5 ff ff       	call   80104720 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801071c5:	58                   	pop    %eax
801071c6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801071cc:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071d1:	5a                   	pop    %edx
801071d2:	ff 75 e4             	pushl  -0x1c(%ebp)
801071d5:	50                   	push   %eax
801071d6:	89 fa                	mov    %edi,%edx
801071d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071db:	e8 c0 f8 ff ff       	call   80106aa0 <mappages>
801071e0:	83 c4 10             	add    $0x10,%esp
801071e3:	85 c0                	test   %eax,%eax
801071e5:	78 61                	js     80107248 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801071e7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801071ed:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801071f0:	76 46                	jbe    80107238 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071f2:	8b 45 08             	mov    0x8(%ebp),%eax
801071f5:	31 c9                	xor    %ecx,%ecx
801071f7:	89 fa                	mov    %edi,%edx
801071f9:	e8 22 f8 ff ff       	call   80106a20 <walkpgdir>
801071fe:	85 c0                	test   %eax,%eax
80107200:	74 61                	je     80107263 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107202:	8b 00                	mov    (%eax),%eax
80107204:	a8 01                	test   $0x1,%al
80107206:	74 4e                	je     80107256 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107208:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010720a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010720f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107215:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107218:	e8 03 b3 ff ff       	call   80102520 <kalloc>
8010721d:	85 c0                	test   %eax,%eax
8010721f:	89 c6                	mov    %eax,%esi
80107221:	75 8d                	jne    801071b0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107223:	83 ec 0c             	sub    $0xc,%esp
80107226:	ff 75 e0             	pushl  -0x20(%ebp)
80107229:	e8 02 fe ff ff       	call   80107030 <freevm>
  return 0;
8010722e:	83 c4 10             	add    $0x10,%esp
80107231:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107238:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010723b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010723e:	5b                   	pop    %ebx
8010723f:	5e                   	pop    %esi
80107240:	5f                   	pop    %edi
80107241:	5d                   	pop    %ebp
80107242:	c3                   	ret    
80107243:	90                   	nop
80107244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107248:	83 ec 0c             	sub    $0xc,%esp
8010724b:	56                   	push   %esi
8010724c:	e8 bf b0 ff ff       	call   80102310 <kfree>
      goto bad;
80107251:	83 c4 10             	add    $0x10,%esp
80107254:	eb cd                	jmp    80107223 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107256:	83 ec 0c             	sub    $0xc,%esp
80107259:	68 26 7e 10 80       	push   $0x80107e26
8010725e:	e8 2d 91 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107263:	83 ec 0c             	sub    $0xc,%esp
80107266:	68 0c 7e 10 80       	push   $0x80107e0c
8010726b:	e8 20 91 ff ff       	call   80100390 <panic>

80107270 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107270:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107271:	31 c9                	xor    %ecx,%ecx
{
80107273:	89 e5                	mov    %esp,%ebp
80107275:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107278:	8b 55 0c             	mov    0xc(%ebp),%edx
8010727b:	8b 45 08             	mov    0x8(%ebp),%eax
8010727e:	e8 9d f7 ff ff       	call   80106a20 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107283:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107285:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107286:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107288:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010728d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107290:	05 00 00 00 80       	add    $0x80000000,%eax
80107295:	83 fa 05             	cmp    $0x5,%edx
80107298:	ba 00 00 00 00       	mov    $0x0,%edx
8010729d:	0f 45 c2             	cmovne %edx,%eax
}
801072a0:	c3                   	ret    
801072a1:	eb 0d                	jmp    801072b0 <copyout>
801072a3:	90                   	nop
801072a4:	90                   	nop
801072a5:	90                   	nop
801072a6:	90                   	nop
801072a7:	90                   	nop
801072a8:	90                   	nop
801072a9:	90                   	nop
801072aa:	90                   	nop
801072ab:	90                   	nop
801072ac:	90                   	nop
801072ad:	90                   	nop
801072ae:	90                   	nop
801072af:	90                   	nop

801072b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	57                   	push   %edi
801072b4:	56                   	push   %esi
801072b5:	53                   	push   %ebx
801072b6:	83 ec 1c             	sub    $0x1c,%esp
801072b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801072bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801072bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072c2:	85 db                	test   %ebx,%ebx
801072c4:	75 40                	jne    80107306 <copyout+0x56>
801072c6:	eb 70                	jmp    80107338 <copyout+0x88>
801072c8:	90                   	nop
801072c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072d3:	89 f1                	mov    %esi,%ecx
801072d5:	29 d1                	sub    %edx,%ecx
801072d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801072dd:	39 d9                	cmp    %ebx,%ecx
801072df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072e2:	29 f2                	sub    %esi,%edx
801072e4:	83 ec 04             	sub    $0x4,%esp
801072e7:	01 d0                	add    %edx,%eax
801072e9:	51                   	push   %ecx
801072ea:	57                   	push   %edi
801072eb:	50                   	push   %eax
801072ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801072ef:	e8 2c d4 ff ff       	call   80104720 <memmove>
    len -= n;
    buf += n;
801072f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801072f7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801072fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107300:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107302:	29 cb                	sub    %ecx,%ebx
80107304:	74 32                	je     80107338 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107306:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107308:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010730b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010730e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107314:	56                   	push   %esi
80107315:	ff 75 08             	pushl  0x8(%ebp)
80107318:	e8 53 ff ff ff       	call   80107270 <uva2ka>
    if(pa0 == 0)
8010731d:	83 c4 10             	add    $0x10,%esp
80107320:	85 c0                	test   %eax,%eax
80107322:	75 ac                	jne    801072d0 <copyout+0x20>
  }
  return 0;
}
80107324:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010732c:	5b                   	pop    %ebx
8010732d:	5e                   	pop    %esi
8010732e:	5f                   	pop    %edi
8010732f:	5d                   	pop    %ebp
80107330:	c3                   	ret    
80107331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107338:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010733b:	31 c0                	xor    %eax,%eax
}
8010733d:	5b                   	pop    %ebx
8010733e:	5e                   	pop    %esi
8010733f:	5f                   	pop    %edi
80107340:	5d                   	pop    %ebp
80107341:	c3                   	ret    
