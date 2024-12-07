// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

#define LEFT_ARROW 0xE4
#define RIGHT_ARROW 0xE5
#define UP_ARROW 226
#define DOWN_ARROW 227
#define ASCII_0 48

static void consputc(int);

static int panicked = 0;

static int backs = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

enum Arrow{ //jadid
  BACK,
  FORWARD,
  UP,
  DOWN
};

#define INPUT_BUF 128

struct Input{
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void //jadid
shift_back(int position ){ 
  for (int i = position - 1; i < position + backs; i++)
    crt[i] = crt[i + 1]; // shift to left all letters after cursor position
  for (int i = input.e - backs; i < input.e; i++ )// jadid
    input.buf[i] = input.buf[i + 1]; // shift to left all letters in buffer
  
}
struct SaveInput //jadid
{
  char copybuf[128];
  int start;
  int end;
  int active;
}saveInp;

static void //jadid
shift_forward(int position) 
{
  for (int i = position + backs; i > position; i--)
    crt[i] = crt[i - 1]; // shift to right all letters after cursor position
  char last = input.buf[input.e-1];
  for (int i = input.e; i > input.e - backs - 1; i--)// jadid
    input.buf[i] = input.buf[i - 1]; // shift to right all letters in buffer
  input.buf[input.e-backs-1] = last;
}

static void
cgaputc(int c)
{
  int position;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  position = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  position |= inb(CRTPORT+1);

  if(c == '\n')
  {
    position += 80 - position%80;
    backs = 0; //(jadid) by going to next the line, back variable resets 
  }
  else if(c == BACKSPACE){
    shift_back(position);
    saveInp.copybuf[input.e-backs] = '\0';
    for (int i = input.e - backs; i < input.e; i++ )// jadid
      saveInp.copybuf[i] = saveInp.copybuf[i + 1];
    if(position > 0) 
      --position;
  } 
  else if(c==RIGHT_ARROW)
  {
    //do nothing
  }
  else if(c == BACKSPACE){//eshtebahe
    shift_back(position);
    if(position > 0) 
      crt[position++] = crt[position];
  }
  else
  {
    shift_forward(position);
    crt[position++] = (c&0xff) | 0x0700;  // black on white
  }

  if(position < 0 || position > 25*80)
    panic("pos under/overflow");

  if((position/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    position -= 80;
    memset(crt+position, 0, sizeof(crt[0])*(24*80 - position));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, position>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, position);
  // crt[position] = ' ' | 0x0700;
}

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}



#define C(x)  ((x)-'@')  // Control-x



static void reverse(char str[], int length) 
{
      int start = 0;
      int end = length - 1;
      while (start < end) 
      {
          char temp = str[start];
          str[start] = str[end];
          str[end] = temp;
          start++;
          end--;
      }
}




static int int_to_str(int num, char str[]) 
{
    int i = 0;
    int is_negative = 0;
    if (num < 0) {
        is_negative = 1;
        num = -num;
    }
    do {
        str[i++] = (num % 10) + '0';
        num /= 10;
    } while (num != 0);
    if (is_negative) {
        str[i++] = '-';
    }
    str[i] = '\0';
    reverse(str, i);
    return i;
}

static void float_to_str(float num, char str[]) 
{
    int int_part = (int)num;
    int fractional_part = (int)((num - int_part) * 10);
    if (fractional_part == 0)
    {
      int index = int_to_str(int_part, str);
      str[index++] = '\0';
    }
    else
    {
      if (fractional_part < 0) 
      {
        fractional_part = -fractional_part;
      }
      int index = int_to_str(int_part, str);
      str[index++] = '.';
      str[index++] = fractional_part + '0';
      str[index] = '\0';
    }
}

static int power(x,y)
{
  int result = 1;
  for(int i=0 ; i<y ; i++)
  {
    result *= x;
  }
  return result;
}

static int read_num(int start_index,int *end_index)
{
  int num = 0;
  int count = 0;
  for(int i=start_index ; i>((int)input.w)-1 ; i--)
  {
    if(input.buf[i]>=48 && input.buf[i]<=57)
    {
      num += (power(10,count)*((int)input.buf[i]- ASCII_0));
      count++;
    }
    else if ((input.buf[i]==45) && ((input.buf[i-1]==42) || (input.buf[i-1]==43) ||(input.buf[i-1]==45) ||(input.buf[i-1]==47)))
    {
      num = -num;
      *end_index = i;
      break;
    }
    else if ((input.buf[i]==45) && (i==(int)input.r))
    {
      num = -num;
      *end_index = i;
      break;
    }
    else
    {
      *end_index = i+1;
      break;
    }
  }
  return num;
}

void delete_letters(int end_index)
{
  for(int i=end_index; i<input.e ; i++)
  {
    consputc(BACKSPACE);
  }
}

void static update_input(int update_index, char new_string[])
{
  int i = update_index;
  int j =0;
  while (new_string[j]!='\0')
  {
    input.buf[i] = new_string[j];
    i++;
    j++;
  }
  while (input.buf[i]!='\0')
  {
    input.buf[i] = '\0';
    i++;
  }
  
  input.e = update_index+j;
  
}

static void check_previous_letters() //jadid
{
  if(input.buf[input.e-1] == 61)
  {
    int first_num_index=0;
    int second_num_index=0;
    if(input.buf[input.e-2]<48 || input.buf[input.e-2]>57)
      return;
    int first_num=read_num(input.e-2, &first_num_index);
    char result[128];
    int second_num = read_num(first_num_index-2, &second_num_index);
    delete_letters(second_num_index);
    consputc(BACKSPACE);
    switch (input.buf[first_num_index-1])
    {
    case 42:
      int_to_str(first_num * second_num, result);
      break;
    
    case 43:
      int_to_str(first_num + second_num, result);
      break;

    case 45:
      int_to_str(second_num - first_num, result);
      break;
    
    case 47:
      float_to_str((float)second_num / (float)first_num, result);
      break;
    
    default:
      break;
    }
    release(&cons.lock);
    cprintf(result);
    update_input(second_num_index, result);
    acquire(&cons.lock);
    
  }
}

static void handle_cursor(enum Arrow action)
{
  int position;

  // get the current position of cursuer using ports and registers
  outb(CRTPORT, 14);
  position = inb(CRTPORT + 1) << 8;
  outb(CRTPORT, 15);
  position |= inb(CRTPORT + 1);

  switch (action)
  {
  case BACK:
    position--;
    break;
  case FORWARD:
    position++;
    break;
  default:
    break;
  }

  // update the new position of cursor
  outb(CRTPORT, 14);
  outb(CRTPORT + 1, position >> 8);
  outb(CRTPORT, 15);
  outb(CRTPORT + 1, position);
}

struct //jadid
{
  struct Input instructions[10];
  int index;
  int last;
  int count;
}history;

static void remove_cur_line()
{
  for (int i= 0 ; i < backs ; i ++){ //move cursor into later of current line
    handle_cursor(FORWARD);
  }
  backs = 0;
  for ( int i = input.e ; i > input.w ; i-- ){ //remove all letters of current line
    if (input.buf[i - 1] != '\n'){
      consputc(BACKSPACE);
    }
  }
}

static void handle_up_arrow()
{
    history.index ++ ;
    input = history.instructions[history.index + 1 ];
    input.buf[--input.e] = '\0'; //remove \n char from last buffered so we can continue typing

}

static void handle_down_arrow()
{
    input = history.instructions[history.index--];
    input.buf[--input.e] = '\0';
}

static void handle_up_down_arrow(enum Arrow arrow){ //jadid
  remove_cur_line();
  if ((arrow == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
    handle_up_arrow();
  }
  else {
    handle_down_arrow();
  }
  
  for (int i = input.w ; i < input.e; i++)
  {
    consputc(input.buf[i]);
  }
}

static int check_if_history(char* word)
{
  int i=0;
  int flag = 0;
  char *h = "history";
  while (word[i]!='\0' && word[i]!='\n')
  {
    if(word[i]!=h[i])
    {
      flag = 1;
      break;
    }
    i++;
  }
  if(i!=7)
    flag = 1;
  return !flag;
}

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  char *buf_value = &input.buf[input.w];
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if((input.e - backs )> input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
      
    case C('S'):
      saveInp.start = input.e-backs;
      saveInp.active = 1;
      for (int i = 0; i < 128; i++)
        saveInp.copybuf[i] = '\0';
      break;

    case C('F'):
    if(saveInp.active == 1)
    {
      saveInp.end = input.e-backs;
      int count = 0;
      int arr[INPUT_BUF];
      for (int i=saveInp.start ; i<INPUT_BUF ; i++)
      {
        if (saveInp.copybuf[i] != '\0'){
          arr[count] = i;
          count++;
        }
      }
      for (int j = input.e; j >= saveInp.end; j--){// jadid
        input.buf[j + count] = input.buf[j];
      }

      input.e = input.e + count;

      for (int i=0; i<count ; i++)
      {
        input.buf[saveInp.end + i] = saveInp.copybuf[arr[i]];
        consputc(saveInp.copybuf[arr[i]]);
      }
    }
      break;

    case LEFT_ARROW: //(jadid)left arrow ascii code
      if ((input.e - backs) > input.w) //ensure cursor position stays in valid bounds
      {
        handle_cursor(BACK);
        backs++;
      }
      break;

    case RIGHT_ARROW: // (jadid)right arrow ascii code
      if (backs > 0) // ensure back value stays positive
      { 
        handle_cursor(FORWARD);
        backs--;
      }
      break;
    case UP_ARROW:
      if ((history.count != 0)  && (history.last - history.index < history.count))
        handle_up_down_arrow(UP);
      break;
    break;
    case DOWN_ARROW:
      if ((history.count != 0 ) && (history.last - history.index  - 1 > 0))
        handle_up_down_arrow(DOWN);
    break;

    case 63:
      consputc(c);
      check_previous_letters();
      break;

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        if (saveInp.active == 1)
        {
          if (saveInp.copybuf[(input.e-backs)%INPUT_BUF] == '\0')
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
          else
          {
            for (int i = input.e; i > input.e - backs; i--)
              saveInp.copybuf[i] = saveInp.copybuf[i - 1]; // shift to right all letters in buffer
            saveInp.copybuf[(input.e-backs)%INPUT_BUF] = c;
          }
        }
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          if(check_if_history(buf_value))
          {
            //WRITE LAST TEN
            release(&cons.lock);
            for(int i=0 ; i<history.count+1 ; i++)
              cprintf(&(history.instructions[i].buf[history.instructions[i].w]));
            acquire(&cons.lock);

          }
          else
          {
            if (history.count < 9){
            history.instructions[history.last + 1] = input;
            history.last ++ ;
            history.index = history.last;
            history.count ++ ;
            }
            else{
              for (int i = 0; i < 9; i++) {
                history.instructions[i] = history.instructions[i+1]; 
              }
              history.instructions[9] = input;
              history.index = 9;
              history.last = 9;
              history.count = 10;
            }
          }          
          backs = 0;
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}

