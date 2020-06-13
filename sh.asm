
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#define MAX_PATH 512

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	81 ec 04 02 00 00    	sub    $0x204,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      14:	eb 13                	jmp    29 <main+0x29>
      16:	8d 76 00             	lea    0x0(%esi),%esi
      19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(fd >= 3){
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 8f 05 01 00 00    	jg     12e <main+0x12e>
  while((fd = open("console", O_RDWR)) >= 0){
      29:	83 ec 08             	sub    $0x8,%esp
      2c:	6a 02                	push   $0x2
      2e:	68 e9 12 00 00       	push   $0x12e9
      33:	e8 8a 0d 00 00       	call   dc2 <open>
      38:	83 c4 10             	add    $0x10,%esp
      3b:	85 c0                	test   %eax,%eax
      3d:	79 e1                	jns    20 <main+0x20>
      3f:	eb 33                	jmp    74 <main+0x74>
      41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    else if(buf[0] == 'p' && buf[1] == 'w' && buf[2] == 'd'){
      48:	3c 70                	cmp    $0x70,%al
      4a:	75 0d                	jne    59 <main+0x59>
      4c:	80 3d 21 19 00 00 77 	cmpb   $0x77,0x1921
      53:	0f 84 97 00 00 00    	je     f0 <main+0xf0>
int
fork1(void)
{
  int pid;

  pid = fork();
      59:	e8 1c 0d 00 00       	call   d7a <fork>
  if(pid == -1)
      5e:	83 f8 ff             	cmp    $0xffffffff,%eax
      61:	0f 84 dd 00 00 00    	je     144 <main+0x144>
    if(fork1() == 0)
      67:	85 c0                	test   %eax,%eax
      69:	0f 84 e2 00 00 00    	je     151 <main+0x151>
    wait();
      6f:	e8 16 0d 00 00       	call   d8a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      74:	83 ec 08             	sub    $0x8,%esp
      77:	6a 64                	push   $0x64
      79:	68 20 19 00 00       	push   $0x1920
      7e:	e8 ed 00 00 00       	call   170 <getcmd>
      83:	83 c4 10             	add    $0x10,%esp
      86:	85 c0                	test   %eax,%eax
      88:	0f 88 b1 00 00 00    	js     13f <main+0x13f>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      8e:	0f b6 05 20 19 00 00 	movzbl 0x1920,%eax
      95:	3c 63                	cmp    $0x63,%al
      97:	75 af                	jne    48 <main+0x48>
      99:	80 3d 21 19 00 00 64 	cmpb   $0x64,0x1921
      a0:	75 b7                	jne    59 <main+0x59>
      a2:	80 3d 22 19 00 00 20 	cmpb   $0x20,0x1922
      a9:	75 ae                	jne    59 <main+0x59>
      buf[strlen(buf)-1] = 0;  // chop \n
      ab:	83 ec 0c             	sub    $0xc,%esp
      ae:	68 20 19 00 00       	push   $0x1920
      b3:	e8 f8 0a 00 00       	call   bb0 <strlen>
      if(chdir(buf+3) < 0)
      b8:	c7 04 24 23 19 00 00 	movl   $0x1923,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      bf:	c6 80 1f 19 00 00 00 	movb   $0x0,0x191f(%eax)
      if(chdir(buf+3) < 0)
      c6:	e8 27 0d 00 00       	call   df2 <chdir>
      cb:	83 c4 10             	add    $0x10,%esp
      ce:	85 c0                	test   %eax,%eax
      d0:	79 a2                	jns    74 <main+0x74>
        printf(2, "cannot cd %s\n", buf+3);
      d2:	52                   	push   %edx
      d3:	68 23 19 00 00       	push   $0x1923
      d8:	68 f1 12 00 00       	push   $0x12f1
      dd:	6a 02                	push   $0x2
      df:	e8 0c 0e 00 00       	call   ef0 <printf>
      e4:	83 c4 10             	add    $0x10,%esp
      e7:	eb 8b                	jmp    74 <main+0x74>
      e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if(buf[0] == 'p' && buf[1] == 'w' && buf[2] == 'd'){
      f0:	80 3d 22 19 00 00 64 	cmpb   $0x64,0x1922
      f7:	0f 85 5c ff ff ff    	jne    59 <main+0x59>
        pwd(path, MAX_PATH);
      fd:	50                   	push   %eax
      fe:	50                   	push   %eax
      ff:	8d 85 f8 fd ff ff    	lea    -0x208(%ebp),%eax
     105:	68 00 02 00 00       	push   $0x200
     10a:	50                   	push   %eax
     10b:	e8 22 0d 00 00       	call   e32 <pwd>
        printf(2, "%s\n", path);
     110:	8d 85 f8 fd ff ff    	lea    -0x208(%ebp),%eax
     116:	83 c4 0c             	add    $0xc,%esp
     119:	50                   	push   %eax
     11a:	68 e5 12 00 00       	push   $0x12e5
     11f:	6a 02                	push   $0x2
     121:	e8 ca 0d 00 00       	call   ef0 <printf>
     126:	83 c4 10             	add    $0x10,%esp
     129:	e9 46 ff ff ff       	jmp    74 <main+0x74>
      close(fd);
     12e:	83 ec 0c             	sub    $0xc,%esp
     131:	50                   	push   %eax
     132:	e8 73 0c 00 00       	call   daa <close>
      break;
     137:	83 c4 10             	add    $0x10,%esp
     13a:	e9 35 ff ff ff       	jmp    74 <main+0x74>
  exit();
     13f:	e8 3e 0c 00 00       	call   d82 <exit>
    panic("fork");
     144:	83 ec 0c             	sub    $0xc,%esp
     147:	68 72 12 00 00       	push   $0x1272
     14c:	e8 6f 00 00 00       	call   1c0 <panic>
      runcmd(parsecmd(buf));
     151:	83 ec 0c             	sub    $0xc,%esp
     154:	68 20 19 00 00       	push   $0x1920
     159:	e8 62 09 00 00       	call   ac0 <parsecmd>
     15e:	89 04 24             	mov    %eax,(%esp)
     161:	e8 7a 00 00 00       	call   1e0 <runcmd>
     166:	66 90                	xchg   %ax,%ax
     168:	66 90                	xchg   %ax,%ax
     16a:	66 90                	xchg   %ax,%ax
     16c:	66 90                	xchg   %ax,%ax
     16e:	66 90                	xchg   %ax,%ax

00000170 <getcmd>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	56                   	push   %esi
     174:	53                   	push   %ebx
     175:	8b 75 0c             	mov    0xc(%ebp),%esi
     178:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     17b:	83 ec 08             	sub    $0x8,%esp
     17e:	68 48 12 00 00       	push   $0x1248
     183:	6a 02                	push   $0x2
     185:	e8 66 0d 00 00       	call   ef0 <printf>
  memset(buf, 0, nbuf);
     18a:	83 c4 0c             	add    $0xc,%esp
     18d:	56                   	push   %esi
     18e:	6a 00                	push   $0x0
     190:	53                   	push   %ebx
     191:	e8 4a 0a 00 00       	call   be0 <memset>
  gets(buf, nbuf);
     196:	58                   	pop    %eax
     197:	5a                   	pop    %edx
     198:	56                   	push   %esi
     199:	53                   	push   %ebx
     19a:	e8 a1 0a 00 00       	call   c40 <gets>
  if(buf[0] == 0) // EOF
     19f:	83 c4 10             	add    $0x10,%esp
     1a2:	31 c0                	xor    %eax,%eax
     1a4:	80 3b 00             	cmpb   $0x0,(%ebx)
     1a7:	0f 94 c0             	sete   %al
}
     1aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     1ad:	f7 d8                	neg    %eax
}
     1af:	5b                   	pop    %ebx
     1b0:	5e                   	pop    %esi
     1b1:	5d                   	pop    %ebp
     1b2:	c3                   	ret    
     1b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <panic>:
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     1c6:	ff 75 08             	pushl  0x8(%ebp)
     1c9:	68 e5 12 00 00       	push   $0x12e5
     1ce:	6a 02                	push   $0x2
     1d0:	e8 1b 0d 00 00       	call   ef0 <printf>
  exit();
     1d5:	e8 a8 0b 00 00       	call   d82 <exit>
     1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001e0 <runcmd>:
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	53                   	push   %ebx
     1e4:	83 ec 14             	sub    $0x14,%esp
     1e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ea:	85 db                	test   %ebx,%ebx
     1ec:	74 3a                	je     228 <runcmd+0x48>
  switch(cmd->type){
     1ee:	83 3b 05             	cmpl   $0x5,(%ebx)
     1f1:	0f 87 06 01 00 00    	ja     2fd <runcmd+0x11d>
     1f7:	8b 03                	mov    (%ebx),%eax
     1f9:	ff 24 85 00 13 00 00 	jmp    *0x1300(,%eax,4)
    if(ecmd->argv[0] == 0)
     200:	8b 43 04             	mov    0x4(%ebx),%eax
     203:	85 c0                	test   %eax,%eax
     205:	74 21                	je     228 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     207:	52                   	push   %edx
     208:	52                   	push   %edx
     209:	8d 53 04             	lea    0x4(%ebx),%edx
     20c:	52                   	push   %edx
     20d:	50                   	push   %eax
     20e:	e8 a7 0b 00 00       	call   dba <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     213:	83 c4 0c             	add    $0xc,%esp
     216:	ff 73 04             	pushl  0x4(%ebx)
     219:	68 52 12 00 00       	push   $0x1252
     21e:	6a 02                	push   $0x2
     220:	e8 cb 0c 00 00       	call   ef0 <printf>
    break;
     225:	83 c4 10             	add    $0x10,%esp
    exit();
     228:	e8 55 0b 00 00       	call   d82 <exit>
  pid = fork();
     22d:	e8 48 0b 00 00       	call   d7a <fork>
  if(pid == -1)
     232:	83 f8 ff             	cmp    $0xffffffff,%eax
     235:	0f 84 cf 00 00 00    	je     30a <runcmd+0x12a>
    if(fork1() == 0)
     23b:	85 c0                	test   %eax,%eax
     23d:	75 e9                	jne    228 <runcmd+0x48>
      runcmd(bcmd->cmd);
     23f:	83 ec 0c             	sub    $0xc,%esp
     242:	ff 73 04             	pushl  0x4(%ebx)
     245:	e8 96 ff ff ff       	call   1e0 <runcmd>
    close(rcmd->fd);
     24a:	83 ec 0c             	sub    $0xc,%esp
     24d:	ff 73 14             	pushl  0x14(%ebx)
     250:	e8 55 0b 00 00       	call   daa <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     255:	59                   	pop    %ecx
     256:	58                   	pop    %eax
     257:	ff 73 10             	pushl  0x10(%ebx)
     25a:	ff 73 08             	pushl  0x8(%ebx)
     25d:	e8 60 0b 00 00       	call   dc2 <open>
     262:	83 c4 10             	add    $0x10,%esp
     265:	85 c0                	test   %eax,%eax
     267:	79 d6                	jns    23f <runcmd+0x5f>
      printf(2, "open %s failed\n", rcmd->file);
     269:	52                   	push   %edx
     26a:	ff 73 08             	pushl  0x8(%ebx)
     26d:	68 62 12 00 00       	push   $0x1262
     272:	6a 02                	push   $0x2
     274:	e8 77 0c 00 00       	call   ef0 <printf>
      exit();
     279:	e8 04 0b 00 00       	call   d82 <exit>
    if(pipe(p) < 0)
     27e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     281:	83 ec 0c             	sub    $0xc,%esp
     284:	50                   	push   %eax
     285:	e8 08 0b 00 00       	call   d92 <pipe>
     28a:	83 c4 10             	add    $0x10,%esp
     28d:	85 c0                	test   %eax,%eax
     28f:	0f 88 b0 00 00 00    	js     345 <runcmd+0x165>
  pid = fork();
     295:	e8 e0 0a 00 00       	call   d7a <fork>
  if(pid == -1)
     29a:	83 f8 ff             	cmp    $0xffffffff,%eax
     29d:	74 6b                	je     30a <runcmd+0x12a>
    if(fork1() == 0){
     29f:	85 c0                	test   %eax,%eax
     2a1:	0f 84 ab 00 00 00    	je     352 <runcmd+0x172>
  pid = fork();
     2a7:	e8 ce 0a 00 00       	call   d7a <fork>
  if(pid == -1)
     2ac:	83 f8 ff             	cmp    $0xffffffff,%eax
     2af:	74 59                	je     30a <runcmd+0x12a>
    if(fork1() == 0){
     2b1:	85 c0                	test   %eax,%eax
     2b3:	74 62                	je     317 <runcmd+0x137>
    close(p[0]);
     2b5:	83 ec 0c             	sub    $0xc,%esp
     2b8:	ff 75 f0             	pushl  -0x10(%ebp)
     2bb:	e8 ea 0a 00 00       	call   daa <close>
    close(p[1]);
     2c0:	58                   	pop    %eax
     2c1:	ff 75 f4             	pushl  -0xc(%ebp)
     2c4:	e8 e1 0a 00 00       	call   daa <close>
    wait();
     2c9:	e8 bc 0a 00 00       	call   d8a <wait>
    wait();
     2ce:	e8 b7 0a 00 00       	call   d8a <wait>
    break;
     2d3:	83 c4 10             	add    $0x10,%esp
     2d6:	e9 4d ff ff ff       	jmp    228 <runcmd+0x48>
  pid = fork();
     2db:	e8 9a 0a 00 00       	call   d7a <fork>
  if(pid == -1)
     2e0:	83 f8 ff             	cmp    $0xffffffff,%eax
     2e3:	74 25                	je     30a <runcmd+0x12a>
    if(fork1() == 0)
     2e5:	85 c0                	test   %eax,%eax
     2e7:	0f 84 52 ff ff ff    	je     23f <runcmd+0x5f>
    wait();
     2ed:	e8 98 0a 00 00       	call   d8a <wait>
    runcmd(lcmd->right);
     2f2:	83 ec 0c             	sub    $0xc,%esp
     2f5:	ff 73 08             	pushl  0x8(%ebx)
     2f8:	e8 e3 fe ff ff       	call   1e0 <runcmd>
    panic("runcmd");
     2fd:	83 ec 0c             	sub    $0xc,%esp
     300:	68 4b 12 00 00       	push   $0x124b
     305:	e8 b6 fe ff ff       	call   1c0 <panic>
    panic("fork");
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 72 12 00 00       	push   $0x1272
     312:	e8 a9 fe ff ff       	call   1c0 <panic>
      close(0);
     317:	83 ec 0c             	sub    $0xc,%esp
     31a:	6a 00                	push   $0x0
     31c:	e8 89 0a 00 00       	call   daa <close>
      dup(p[0]);
     321:	5a                   	pop    %edx
     322:	ff 75 f0             	pushl  -0x10(%ebp)
     325:	e8 d0 0a 00 00       	call   dfa <dup>
      close(p[0]);
     32a:	59                   	pop    %ecx
     32b:	ff 75 f0             	pushl  -0x10(%ebp)
     32e:	e8 77 0a 00 00       	call   daa <close>
      close(p[1]);
     333:	58                   	pop    %eax
     334:	ff 75 f4             	pushl  -0xc(%ebp)
     337:	e8 6e 0a 00 00       	call   daa <close>
      runcmd(pcmd->right);
     33c:	58                   	pop    %eax
     33d:	ff 73 08             	pushl  0x8(%ebx)
     340:	e8 9b fe ff ff       	call   1e0 <runcmd>
      panic("pipe");
     345:	83 ec 0c             	sub    $0xc,%esp
     348:	68 77 12 00 00       	push   $0x1277
     34d:	e8 6e fe ff ff       	call   1c0 <panic>
      close(1);
     352:	83 ec 0c             	sub    $0xc,%esp
     355:	6a 01                	push   $0x1
     357:	e8 4e 0a 00 00       	call   daa <close>
      dup(p[1]);
     35c:	58                   	pop    %eax
     35d:	ff 75 f4             	pushl  -0xc(%ebp)
     360:	e8 95 0a 00 00       	call   dfa <dup>
      close(p[0]);
     365:	58                   	pop    %eax
     366:	ff 75 f0             	pushl  -0x10(%ebp)
     369:	e8 3c 0a 00 00       	call   daa <close>
      close(p[1]);
     36e:	58                   	pop    %eax
     36f:	ff 75 f4             	pushl  -0xc(%ebp)
     372:	e8 33 0a 00 00       	call   daa <close>
      runcmd(pcmd->left);
     377:	58                   	pop    %eax
     378:	ff 73 04             	pushl  0x4(%ebx)
     37b:	e8 60 fe ff ff       	call   1e0 <runcmd>

00000380 <fork1>:
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     386:	e8 ef 09 00 00       	call   d7a <fork>
  if(pid == -1)
     38b:	83 f8 ff             	cmp    $0xffffffff,%eax
     38e:	74 02                	je     392 <fork1+0x12>
  return pid;
}
     390:	c9                   	leave  
     391:	c3                   	ret    
    panic("fork");
     392:	83 ec 0c             	sub    $0xc,%esp
     395:	68 72 12 00 00       	push   $0x1272
     39a:	e8 21 fe ff ff       	call   1c0 <panic>
     39f:	90                   	nop

000003a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	6a 54                	push   $0x54
     3a9:	e8 a2 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ae:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3b1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b3:	6a 54                	push   $0x54
     3b5:	6a 00                	push   $0x0
     3b7:	50                   	push   %eax
     3b8:	e8 23 08 00 00       	call   be0 <memset>
  cmd->type = EXEC;
     3bd:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     3c3:	89 d8                	mov    %ebx,%eax
     3c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c8:	c9                   	leave  
     3c9:	c3                   	ret    
     3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	6a 18                	push   $0x18
     3d9:	e8 72 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3de:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3e1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3e3:	6a 18                	push   $0x18
     3e5:	6a 00                	push   $0x0
     3e7:	50                   	push   %eax
     3e8:	e8 f3 07 00 00       	call   be0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3f0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3ff:	8b 45 10             	mov    0x10(%ebp),%eax
     402:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     405:	8b 45 14             	mov    0x14(%ebp),%eax
     408:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     40b:	8b 45 18             	mov    0x18(%ebp),%eax
     40e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     411:	89 d8                	mov    %ebx,%eax
     413:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     416:	c9                   	leave  
     417:	c3                   	ret    
     418:	90                   	nop
     419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000420 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
     424:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     427:	6a 0c                	push   $0xc
     429:	e8 22 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     42e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     431:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     433:	6a 0c                	push   $0xc
     435:	6a 00                	push   $0x0
     437:	50                   	push   %eax
     438:	e8 a3 07 00 00       	call   be0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     43d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     440:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     446:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     449:	8b 45 0c             	mov    0xc(%ebp),%eax
     44c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     44f:	89 d8                	mov    %ebx,%eax
     451:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     454:	c9                   	leave  
     455:	c3                   	ret    
     456:	8d 76 00             	lea    0x0(%esi),%esi
     459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     467:	6a 0c                	push   $0xc
     469:	e8 e2 0c 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     46e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     471:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     473:	6a 0c                	push   $0xc
     475:	6a 00                	push   $0x0
     477:	50                   	push   %eax
     478:	e8 63 07 00 00       	call   be0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     47d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     480:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     486:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     489:	8b 45 0c             	mov    0xc(%ebp),%eax
     48c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     48f:	89 d8                	mov    %ebx,%eax
     491:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     494:	c9                   	leave  
     495:	c3                   	ret    
     496:	8d 76 00             	lea    0x0(%esi),%esi
     499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	53                   	push   %ebx
     4a4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a7:	6a 08                	push   $0x8
     4a9:	e8 a2 0c 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4ae:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     4b1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4b3:	6a 08                	push   $0x8
     4b5:	6a 00                	push   $0x0
     4b7:	50                   	push   %eax
     4b8:	e8 23 07 00 00       	call   be0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     4c0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     4c6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     4c9:	89 d8                	mov    %ebx,%eax
     4cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4ce:	c9                   	leave  
     4cf:	c3                   	ret    

000004d0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	57                   	push   %edi
     4d4:	56                   	push   %esi
     4d5:	53                   	push   %ebx
     4d6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     4d9:	8b 45 08             	mov    0x8(%ebp),%eax
{
     4dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4df:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     4e2:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     4e4:	39 de                	cmp    %ebx,%esi
     4e6:	72 0f                	jb     4f7 <gettoken+0x27>
     4e8:	eb 25                	jmp    50f <gettoken+0x3f>
     4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4f0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4f3:	39 f3                	cmp    %esi,%ebx
     4f5:	74 18                	je     50f <gettoken+0x3f>
     4f7:	0f be 06             	movsbl (%esi),%eax
     4fa:	83 ec 08             	sub    $0x8,%esp
     4fd:	50                   	push   %eax
     4fe:	68 fc 18 00 00       	push   $0x18fc
     503:	e8 f8 06 00 00       	call   c00 <strchr>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	85 c0                	test   %eax,%eax
     50d:	75 e1                	jne    4f0 <gettoken+0x20>
  if(q)
     50f:	85 ff                	test   %edi,%edi
     511:	74 02                	je     515 <gettoken+0x45>
    *q = s;
     513:	89 37                	mov    %esi,(%edi)
  ret = *s;
     515:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     518:	3c 29                	cmp    $0x29,%al
     51a:	7f 54                	jg     570 <gettoken+0xa0>
     51c:	3c 28                	cmp    $0x28,%al
     51e:	0f 8d c8 00 00 00    	jge    5ec <gettoken+0x11c>
     524:	31 ff                	xor    %edi,%edi
     526:	84 c0                	test   %al,%al
     528:	0f 85 d2 00 00 00    	jne    600 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     52e:	8b 55 14             	mov    0x14(%ebp),%edx
     531:	85 d2                	test   %edx,%edx
     533:	74 05                	je     53a <gettoken+0x6a>
    *eq = s;
     535:	8b 45 14             	mov    0x14(%ebp),%eax
     538:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     53a:	39 de                	cmp    %ebx,%esi
     53c:	72 09                	jb     547 <gettoken+0x77>
     53e:	eb 1f                	jmp    55f <gettoken+0x8f>
    s++;
     540:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     543:	39 f3                	cmp    %esi,%ebx
     545:	74 18                	je     55f <gettoken+0x8f>
     547:	0f be 06             	movsbl (%esi),%eax
     54a:	83 ec 08             	sub    $0x8,%esp
     54d:	50                   	push   %eax
     54e:	68 fc 18 00 00       	push   $0x18fc
     553:	e8 a8 06 00 00       	call   c00 <strchr>
     558:	83 c4 10             	add    $0x10,%esp
     55b:	85 c0                	test   %eax,%eax
     55d:	75 e1                	jne    540 <gettoken+0x70>
  *ps = s;
     55f:	8b 45 08             	mov    0x8(%ebp),%eax
     562:	89 30                	mov    %esi,(%eax)
  return ret;
}
     564:	8d 65 f4             	lea    -0xc(%ebp),%esp
     567:	89 f8                	mov    %edi,%eax
     569:	5b                   	pop    %ebx
     56a:	5e                   	pop    %esi
     56b:	5f                   	pop    %edi
     56c:	5d                   	pop    %ebp
     56d:	c3                   	ret    
     56e:	66 90                	xchg   %ax,%ax
  switch(*s){
     570:	3c 3e                	cmp    $0x3e,%al
     572:	75 1c                	jne    590 <gettoken+0xc0>
    if(*s == '>'){
     574:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     578:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     57b:	0f 84 a4 00 00 00    	je     625 <gettoken+0x155>
    s++;
     581:	89 c6                	mov    %eax,%esi
     583:	bf 3e 00 00 00       	mov    $0x3e,%edi
     588:	eb a4                	jmp    52e <gettoken+0x5e>
     58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     590:	7f 56                	jg     5e8 <gettoken+0x118>
     592:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     595:	80 f9 01             	cmp    $0x1,%cl
     598:	76 52                	jbe    5ec <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     59a:	39 f3                	cmp    %esi,%ebx
     59c:	77 24                	ja     5c2 <gettoken+0xf2>
     59e:	eb 70                	jmp    610 <gettoken+0x140>
     5a0:	0f be 06             	movsbl (%esi),%eax
     5a3:	83 ec 08             	sub    $0x8,%esp
     5a6:	50                   	push   %eax
     5a7:	68 f4 18 00 00       	push   $0x18f4
     5ac:	e8 4f 06 00 00       	call   c00 <strchr>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	75 1f                	jne    5d7 <gettoken+0x107>
      s++;
     5b8:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5bb:	39 f3                	cmp    %esi,%ebx
     5bd:	74 51                	je     610 <gettoken+0x140>
     5bf:	0f be 06             	movsbl (%esi),%eax
     5c2:	83 ec 08             	sub    $0x8,%esp
     5c5:	50                   	push   %eax
     5c6:	68 fc 18 00 00       	push   $0x18fc
     5cb:	e8 30 06 00 00       	call   c00 <strchr>
     5d0:	83 c4 10             	add    $0x10,%esp
     5d3:	85 c0                	test   %eax,%eax
     5d5:	74 c9                	je     5a0 <gettoken+0xd0>
    ret = 'a';
     5d7:	bf 61 00 00 00       	mov    $0x61,%edi
     5dc:	e9 4d ff ff ff       	jmp    52e <gettoken+0x5e>
     5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5e8:	3c 7c                	cmp    $0x7c,%al
     5ea:	75 ae                	jne    59a <gettoken+0xca>
  ret = *s;
     5ec:	0f be f8             	movsbl %al,%edi
    s++;
     5ef:	83 c6 01             	add    $0x1,%esi
    break;
     5f2:	e9 37 ff ff ff       	jmp    52e <gettoken+0x5e>
     5f7:	89 f6                	mov    %esi,%esi
     5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     600:	3c 26                	cmp    $0x26,%al
     602:	75 96                	jne    59a <gettoken+0xca>
     604:	eb e6                	jmp    5ec <gettoken+0x11c>
     606:	8d 76 00             	lea    0x0(%esi),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     610:	8b 45 14             	mov    0x14(%ebp),%eax
     613:	bf 61 00 00 00       	mov    $0x61,%edi
     618:	85 c0                	test   %eax,%eax
     61a:	0f 85 15 ff ff ff    	jne    535 <gettoken+0x65>
     620:	e9 3a ff ff ff       	jmp    55f <gettoken+0x8f>
      s++;
     625:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     628:	bf 2b 00 00 00       	mov    $0x2b,%edi
     62d:	e9 fc fe ff ff       	jmp    52e <gettoken+0x5e>
     632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 0c             	sub    $0xc,%esp
     649:	8b 7d 08             	mov    0x8(%ebp),%edi
     64c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     64f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     651:	39 f3                	cmp    %esi,%ebx
     653:	72 12                	jb     667 <peek+0x27>
     655:	eb 28                	jmp    67f <peek+0x3f>
     657:	89 f6                	mov    %esi,%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     660:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     663:	39 de                	cmp    %ebx,%esi
     665:	74 18                	je     67f <peek+0x3f>
     667:	0f be 03             	movsbl (%ebx),%eax
     66a:	83 ec 08             	sub    $0x8,%esp
     66d:	50                   	push   %eax
     66e:	68 fc 18 00 00       	push   $0x18fc
     673:	e8 88 05 00 00       	call   c00 <strchr>
     678:	83 c4 10             	add    $0x10,%esp
     67b:	85 c0                	test   %eax,%eax
     67d:	75 e1                	jne    660 <peek+0x20>
  *ps = s;
     67f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     681:	0f be 13             	movsbl (%ebx),%edx
     684:	31 c0                	xor    %eax,%eax
     686:	84 d2                	test   %dl,%dl
     688:	74 17                	je     6a1 <peek+0x61>
     68a:	83 ec 08             	sub    $0x8,%esp
     68d:	52                   	push   %edx
     68e:	ff 75 10             	pushl  0x10(%ebp)
     691:	e8 6a 05 00 00       	call   c00 <strchr>
     696:	83 c4 10             	add    $0x10,%esp
     699:	85 c0                	test   %eax,%eax
     69b:	0f 95 c0             	setne  %al
     69e:	0f b6 c0             	movzbl %al,%eax
}
     6a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6a4:	5b                   	pop    %ebx
     6a5:	5e                   	pop    %esi
     6a6:	5f                   	pop    %edi
     6a7:	5d                   	pop    %ebp
     6a8:	c3                   	ret    
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006b0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
     6b6:	83 ec 1c             	sub    $0x1c,%esp
     6b9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6bf:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6c0:	83 ec 04             	sub    $0x4,%esp
     6c3:	68 99 12 00 00       	push   $0x1299
     6c8:	53                   	push   %ebx
     6c9:	56                   	push   %esi
     6ca:	e8 71 ff ff ff       	call   640 <peek>
     6cf:	83 c4 10             	add    $0x10,%esp
     6d2:	85 c0                	test   %eax,%eax
     6d4:	74 6a                	je     740 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     6d6:	6a 00                	push   $0x0
     6d8:	6a 00                	push   $0x0
     6da:	53                   	push   %ebx
     6db:	56                   	push   %esi
     6dc:	e8 ef fd ff ff       	call   4d0 <gettoken>
     6e1:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6e3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6e6:	50                   	push   %eax
     6e7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6ea:	50                   	push   %eax
     6eb:	53                   	push   %ebx
     6ec:	56                   	push   %esi
     6ed:	e8 de fd ff ff       	call   4d0 <gettoken>
     6f2:	83 c4 20             	add    $0x20,%esp
     6f5:	83 f8 61             	cmp    $0x61,%eax
     6f8:	75 51                	jne    74b <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     6fa:	83 ff 3c             	cmp    $0x3c,%edi
     6fd:	74 31                	je     730 <parseredirs+0x80>
     6ff:	83 ff 3e             	cmp    $0x3e,%edi
     702:	74 05                	je     709 <parseredirs+0x59>
     704:	83 ff 2b             	cmp    $0x2b,%edi
     707:	75 b7                	jne    6c0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     709:	83 ec 0c             	sub    $0xc,%esp
     70c:	6a 01                	push   $0x1
     70e:	68 01 02 00 00       	push   $0x201
     713:	ff 75 e4             	pushl  -0x1c(%ebp)
     716:	ff 75 e0             	pushl  -0x20(%ebp)
     719:	ff 75 08             	pushl  0x8(%ebp)
     71c:	e8 af fc ff ff       	call   3d0 <redircmd>
      break;
     721:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     724:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     727:	eb 97                	jmp    6c0 <parseredirs+0x10>
     729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     730:	83 ec 0c             	sub    $0xc,%esp
     733:	6a 00                	push   $0x0
     735:	6a 00                	push   $0x0
     737:	eb da                	jmp    713 <parseredirs+0x63>
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     740:	8b 45 08             	mov    0x8(%ebp),%eax
     743:	8d 65 f4             	lea    -0xc(%ebp),%esp
     746:	5b                   	pop    %ebx
     747:	5e                   	pop    %esi
     748:	5f                   	pop    %edi
     749:	5d                   	pop    %ebp
     74a:	c3                   	ret    
      panic("missing file for redirection");
     74b:	83 ec 0c             	sub    $0xc,%esp
     74e:	68 7c 12 00 00       	push   $0x127c
     753:	e8 68 fa ff ff       	call   1c0 <panic>
     758:	90                   	nop
     759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000760 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	53                   	push   %ebx
     766:	83 ec 30             	sub    $0x30,%esp
     769:	8b 75 08             	mov    0x8(%ebp),%esi
     76c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     76f:	68 9c 12 00 00       	push   $0x129c
     774:	57                   	push   %edi
     775:	56                   	push   %esi
     776:	e8 c5 fe ff ff       	call   640 <peek>
     77b:	83 c4 10             	add    $0x10,%esp
     77e:	85 c0                	test   %eax,%eax
     780:	0f 85 92 00 00 00    	jne    818 <parseexec+0xb8>
     786:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     788:	e8 13 fc ff ff       	call   3a0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     78d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     790:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	50                   	push   %eax
     796:	e8 15 ff ff ff       	call   6b0 <parseredirs>
     79b:	83 c4 10             	add    $0x10,%esp
     79e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     7a1:	eb 18                	jmp    7bb <parseexec+0x5b>
     7a3:	90                   	nop
     7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     7a8:	83 ec 04             	sub    $0x4,%esp
     7ab:	57                   	push   %edi
     7ac:	56                   	push   %esi
     7ad:	ff 75 d4             	pushl  -0x2c(%ebp)
     7b0:	e8 fb fe ff ff       	call   6b0 <parseredirs>
     7b5:	83 c4 10             	add    $0x10,%esp
     7b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     7bb:	83 ec 04             	sub    $0x4,%esp
     7be:	68 b3 12 00 00       	push   $0x12b3
     7c3:	57                   	push   %edi
     7c4:	56                   	push   %esi
     7c5:	e8 76 fe ff ff       	call   640 <peek>
     7ca:	83 c4 10             	add    $0x10,%esp
     7cd:	85 c0                	test   %eax,%eax
     7cf:	75 67                	jne    838 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     7d1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     7d4:	50                   	push   %eax
     7d5:	8d 45 e0             	lea    -0x20(%ebp),%eax
     7d8:	50                   	push   %eax
     7d9:	57                   	push   %edi
     7da:	56                   	push   %esi
     7db:	e8 f0 fc ff ff       	call   4d0 <gettoken>
     7e0:	83 c4 10             	add    $0x10,%esp
     7e3:	85 c0                	test   %eax,%eax
     7e5:	74 51                	je     838 <parseexec+0xd8>
    if(tok != 'a')
     7e7:	83 f8 61             	cmp    $0x61,%eax
     7ea:	75 6b                	jne    857 <parseexec+0xf7>
    cmd->argv[argc] = q;
     7ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7ef:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7f2:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7f9:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7fd:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     800:	83 fb 0a             	cmp    $0xa,%ebx
     803:	75 a3                	jne    7a8 <parseexec+0x48>
      panic("too many args");
     805:	83 ec 0c             	sub    $0xc,%esp
     808:	68 a5 12 00 00       	push   $0x12a5
     80d:	e8 ae f9 ff ff       	call   1c0 <panic>
     812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     818:	83 ec 08             	sub    $0x8,%esp
     81b:	57                   	push   %edi
     81c:	56                   	push   %esi
     81d:	e8 5e 01 00 00       	call   980 <parseblock>
     822:	83 c4 10             	add    $0x10,%esp
     825:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     828:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     82b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     82e:	5b                   	pop    %ebx
     82f:	5e                   	pop    %esi
     830:	5f                   	pop    %edi
     831:	5d                   	pop    %ebp
     832:	c3                   	ret    
     833:	90                   	nop
     834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     838:	8b 45 d0             	mov    -0x30(%ebp),%eax
     83b:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     83e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     845:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     84c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     84f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     852:	5b                   	pop    %ebx
     853:	5e                   	pop    %esi
     854:	5f                   	pop    %edi
     855:	5d                   	pop    %ebp
     856:	c3                   	ret    
      panic("syntax");
     857:	83 ec 0c             	sub    $0xc,%esp
     85a:	68 9e 12 00 00       	push   $0x129e
     85f:	e8 5c f9 ff ff       	call   1c0 <panic>
     864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     86a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000870 <parsepipe>:
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 14             	sub    $0x14,%esp
     879:	8b 5d 08             	mov    0x8(%ebp),%ebx
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     87f:	56                   	push   %esi
     880:	53                   	push   %ebx
     881:	e8 da fe ff ff       	call   760 <parseexec>
  if(peek(ps, es, "|")){
     886:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     889:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     88b:	68 b8 12 00 00       	push   $0x12b8
     890:	56                   	push   %esi
     891:	53                   	push   %ebx
     892:	e8 a9 fd ff ff       	call   640 <peek>
     897:	83 c4 10             	add    $0x10,%esp
     89a:	85 c0                	test   %eax,%eax
     89c:	75 12                	jne    8b0 <parsepipe+0x40>
}
     89e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8a1:	89 f8                	mov    %edi,%eax
     8a3:	5b                   	pop    %ebx
     8a4:	5e                   	pop    %esi
     8a5:	5f                   	pop    %edi
     8a6:	5d                   	pop    %ebp
     8a7:	c3                   	ret    
     8a8:	90                   	nop
     8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     8b0:	6a 00                	push   $0x0
     8b2:	6a 00                	push   $0x0
     8b4:	56                   	push   %esi
     8b5:	53                   	push   %ebx
     8b6:	e8 15 fc ff ff       	call   4d0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8bb:	58                   	pop    %eax
     8bc:	5a                   	pop    %edx
     8bd:	56                   	push   %esi
     8be:	53                   	push   %ebx
     8bf:	e8 ac ff ff ff       	call   870 <parsepipe>
     8c4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8c7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8ca:	83 c4 10             	add    $0x10,%esp
}
     8cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d0:	5b                   	pop    %ebx
     8d1:	5e                   	pop    %esi
     8d2:	5f                   	pop    %edi
     8d3:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8d4:	e9 47 fb ff ff       	jmp    420 <pipecmd>
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <parseline>:
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	57                   	push   %edi
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	83 ec 14             	sub    $0x14,%esp
     8e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     8ef:	56                   	push   %esi
     8f0:	53                   	push   %ebx
     8f1:	e8 7a ff ff ff       	call   870 <parsepipe>
  while(peek(ps, es, "&")){
     8f6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     8f9:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8fb:	eb 1b                	jmp    918 <parseline+0x38>
     8fd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     900:	6a 00                	push   $0x0
     902:	6a 00                	push   $0x0
     904:	56                   	push   %esi
     905:	53                   	push   %ebx
     906:	e8 c5 fb ff ff       	call   4d0 <gettoken>
    cmd = backcmd(cmd);
     90b:	89 3c 24             	mov    %edi,(%esp)
     90e:	e8 8d fb ff ff       	call   4a0 <backcmd>
     913:	83 c4 10             	add    $0x10,%esp
     916:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     918:	83 ec 04             	sub    $0x4,%esp
     91b:	68 ba 12 00 00       	push   $0x12ba
     920:	56                   	push   %esi
     921:	53                   	push   %ebx
     922:	e8 19 fd ff ff       	call   640 <peek>
     927:	83 c4 10             	add    $0x10,%esp
     92a:	85 c0                	test   %eax,%eax
     92c:	75 d2                	jne    900 <parseline+0x20>
  if(peek(ps, es, ";")){
     92e:	83 ec 04             	sub    $0x4,%esp
     931:	68 b6 12 00 00       	push   $0x12b6
     936:	56                   	push   %esi
     937:	53                   	push   %ebx
     938:	e8 03 fd ff ff       	call   640 <peek>
     93d:	83 c4 10             	add    $0x10,%esp
     940:	85 c0                	test   %eax,%eax
     942:	75 0c                	jne    950 <parseline+0x70>
}
     944:	8d 65 f4             	lea    -0xc(%ebp),%esp
     947:	89 f8                	mov    %edi,%eax
     949:	5b                   	pop    %ebx
     94a:	5e                   	pop    %esi
     94b:	5f                   	pop    %edi
     94c:	5d                   	pop    %ebp
     94d:	c3                   	ret    
     94e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     950:	6a 00                	push   $0x0
     952:	6a 00                	push   $0x0
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	e8 75 fb ff ff       	call   4d0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     95b:	58                   	pop    %eax
     95c:	5a                   	pop    %edx
     95d:	56                   	push   %esi
     95e:	53                   	push   %ebx
     95f:	e8 7c ff ff ff       	call   8e0 <parseline>
     964:	89 7d 08             	mov    %edi,0x8(%ebp)
     967:	89 45 0c             	mov    %eax,0xc(%ebp)
     96a:	83 c4 10             	add    $0x10,%esp
}
     96d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     970:	5b                   	pop    %ebx
     971:	5e                   	pop    %esi
     972:	5f                   	pop    %edi
     973:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     974:	e9 e7 fa ff ff       	jmp    460 <listcmd>
     979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000980 <parseblock>:
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	57                   	push   %edi
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	83 ec 10             	sub    $0x10,%esp
     989:	8b 5d 08             	mov    0x8(%ebp),%ebx
     98c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     98f:	68 9c 12 00 00       	push   $0x129c
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	e8 a5 fc ff ff       	call   640 <peek>
     99b:	83 c4 10             	add    $0x10,%esp
     99e:	85 c0                	test   %eax,%eax
     9a0:	74 4a                	je     9ec <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     9a2:	6a 00                	push   $0x0
     9a4:	6a 00                	push   $0x0
     9a6:	56                   	push   %esi
     9a7:	53                   	push   %ebx
     9a8:	e8 23 fb ff ff       	call   4d0 <gettoken>
  cmd = parseline(ps, es);
     9ad:	58                   	pop    %eax
     9ae:	5a                   	pop    %edx
     9af:	56                   	push   %esi
     9b0:	53                   	push   %ebx
     9b1:	e8 2a ff ff ff       	call   8e0 <parseline>
  if(!peek(ps, es, ")"))
     9b6:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     9b9:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9bb:	68 d8 12 00 00       	push   $0x12d8
     9c0:	56                   	push   %esi
     9c1:	53                   	push   %ebx
     9c2:	e8 79 fc ff ff       	call   640 <peek>
     9c7:	83 c4 10             	add    $0x10,%esp
     9ca:	85 c0                	test   %eax,%eax
     9cc:	74 2b                	je     9f9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     9ce:	6a 00                	push   $0x0
     9d0:	6a 00                	push   $0x0
     9d2:	56                   	push   %esi
     9d3:	53                   	push   %ebx
     9d4:	e8 f7 fa ff ff       	call   4d0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9d9:	83 c4 0c             	add    $0xc,%esp
     9dc:	56                   	push   %esi
     9dd:	53                   	push   %ebx
     9de:	57                   	push   %edi
     9df:	e8 cc fc ff ff       	call   6b0 <parseredirs>
}
     9e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9e7:	5b                   	pop    %ebx
     9e8:	5e                   	pop    %esi
     9e9:	5f                   	pop    %edi
     9ea:	5d                   	pop    %ebp
     9eb:	c3                   	ret    
    panic("parseblock");
     9ec:	83 ec 0c             	sub    $0xc,%esp
     9ef:	68 bc 12 00 00       	push   $0x12bc
     9f4:	e8 c7 f7 ff ff       	call   1c0 <panic>
    panic("syntax - missing )");
     9f9:	83 ec 0c             	sub    $0xc,%esp
     9fc:	68 c7 12 00 00       	push   $0x12c7
     a01:	e8 ba f7 ff ff       	call   1c0 <panic>
     a06:	8d 76 00             	lea    0x0(%esi),%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	53                   	push   %ebx
     a14:	83 ec 04             	sub    $0x4,%esp
     a17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a1a:	85 db                	test   %ebx,%ebx
     a1c:	74 20                	je     a3e <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     a1e:	83 3b 05             	cmpl   $0x5,(%ebx)
     a21:	77 1b                	ja     a3e <nulterminate+0x2e>
     a23:	8b 03                	mov    (%ebx),%eax
     a25:	ff 24 85 18 13 00 00 	jmp    *0x1318(,%eax,4)
     a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	ff 73 04             	pushl  0x4(%ebx)
     a36:	e8 d5 ff ff ff       	call   a10 <nulterminate>
    break;
     a3b:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     a3e:	89 d8                	mov    %ebx,%eax
     a40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a43:	c9                   	leave  
     a44:	c3                   	ret    
     a45:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     a48:	83 ec 0c             	sub    $0xc,%esp
     a4b:	ff 73 04             	pushl  0x4(%ebx)
     a4e:	e8 bd ff ff ff       	call   a10 <nulterminate>
    nulterminate(lcmd->right);
     a53:	58                   	pop    %eax
     a54:	ff 73 08             	pushl  0x8(%ebx)
     a57:	e8 b4 ff ff ff       	call   a10 <nulterminate>
}
     a5c:	89 d8                	mov    %ebx,%eax
    break;
     a5e:	83 c4 10             	add    $0x10,%esp
}
     a61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a64:	c9                   	leave  
     a65:	c3                   	ret    
     a66:	8d 76 00             	lea    0x0(%esi),%esi
     a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a70:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a73:	8d 43 08             	lea    0x8(%ebx),%eax
     a76:	85 c9                	test   %ecx,%ecx
     a78:	74 c4                	je     a3e <nulterminate+0x2e>
     a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a80:	8b 50 24             	mov    0x24(%eax),%edx
     a83:	83 c0 04             	add    $0x4,%eax
     a86:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a89:	8b 50 fc             	mov    -0x4(%eax),%edx
     a8c:	85 d2                	test   %edx,%edx
     a8e:	75 f0                	jne    a80 <nulterminate+0x70>
}
     a90:	89 d8                	mov    %ebx,%eax
     a92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a95:	c9                   	leave  
     a96:	c3                   	ret    
     a97:	89 f6                	mov    %esi,%esi
     a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	ff 73 04             	pushl  0x4(%ebx)
     aa6:	e8 65 ff ff ff       	call   a10 <nulterminate>
    *rcmd->efile = 0;
     aab:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     aae:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     ab1:	c6 00 00             	movb   $0x0,(%eax)
}
     ab4:	89 d8                	mov    %ebx,%eax
     ab6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ab9:	c9                   	leave  
     aba:	c3                   	ret    
     abb:	90                   	nop
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ac0 <parsecmd>:
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	56                   	push   %esi
     ac4:	53                   	push   %ebx
  es = s + strlen(s);
     ac5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ac8:	83 ec 0c             	sub    $0xc,%esp
     acb:	53                   	push   %ebx
     acc:	e8 df 00 00 00       	call   bb0 <strlen>
  cmd = parseline(&s, es);
     ad1:	59                   	pop    %ecx
  es = s + strlen(s);
     ad2:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     ad4:	8d 45 08             	lea    0x8(%ebp),%eax
     ad7:	5e                   	pop    %esi
     ad8:	53                   	push   %ebx
     ad9:	50                   	push   %eax
     ada:	e8 01 fe ff ff       	call   8e0 <parseline>
     adf:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     ae1:	8d 45 08             	lea    0x8(%ebp),%eax
     ae4:	83 c4 0c             	add    $0xc,%esp
     ae7:	68 61 12 00 00       	push   $0x1261
     aec:	53                   	push   %ebx
     aed:	50                   	push   %eax
     aee:	e8 4d fb ff ff       	call   640 <peek>
  if(s != es){
     af3:	8b 45 08             	mov    0x8(%ebp),%eax
     af6:	83 c4 10             	add    $0x10,%esp
     af9:	39 d8                	cmp    %ebx,%eax
     afb:	75 12                	jne    b0f <parsecmd+0x4f>
  nulterminate(cmd);
     afd:	83 ec 0c             	sub    $0xc,%esp
     b00:	56                   	push   %esi
     b01:	e8 0a ff ff ff       	call   a10 <nulterminate>
}
     b06:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b09:	89 f0                	mov    %esi,%eax
     b0b:	5b                   	pop    %ebx
     b0c:	5e                   	pop    %esi
     b0d:	5d                   	pop    %ebp
     b0e:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     b0f:	52                   	push   %edx
     b10:	50                   	push   %eax
     b11:	68 da 12 00 00       	push   $0x12da
     b16:	6a 02                	push   $0x2
     b18:	e8 d3 03 00 00       	call   ef0 <printf>
    panic("syntax");
     b1d:	c7 04 24 9e 12 00 00 	movl   $0x129e,(%esp)
     b24:	e8 97 f6 ff ff       	call   1c0 <panic>
     b29:	66 90                	xchg   %ax,%ax
     b2b:	66 90                	xchg   %ax,%ax
     b2d:	66 90                	xchg   %ax,%ax
     b2f:	90                   	nop

00000b30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	8b 45 08             	mov    0x8(%ebp),%eax
     b37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b3a:	89 c2                	mov    %eax,%edx
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b40:	83 c1 01             	add    $0x1,%ecx
     b43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     b47:	83 c2 01             	add    $0x1,%edx
     b4a:	84 db                	test   %bl,%bl
     b4c:	88 5a ff             	mov    %bl,-0x1(%edx)
     b4f:	75 ef                	jne    b40 <strcpy+0x10>
    ;
  return os;
}
     b51:	5b                   	pop    %ebx
     b52:	5d                   	pop    %ebp
     b53:	c3                   	ret    
     b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	53                   	push   %ebx
     b64:	8b 55 08             	mov    0x8(%ebp),%edx
     b67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b6a:	0f b6 02             	movzbl (%edx),%eax
     b6d:	0f b6 19             	movzbl (%ecx),%ebx
     b70:	84 c0                	test   %al,%al
     b72:	75 1c                	jne    b90 <strcmp+0x30>
     b74:	eb 2a                	jmp    ba0 <strcmp+0x40>
     b76:	8d 76 00             	lea    0x0(%esi),%esi
     b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b86:	83 c1 01             	add    $0x1,%ecx
     b89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b8c:	84 c0                	test   %al,%al
     b8e:	74 10                	je     ba0 <strcmp+0x40>
     b90:	38 d8                	cmp    %bl,%al
     b92:	74 ec                	je     b80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b94:	29 d8                	sub    %ebx,%eax
}
     b96:	5b                   	pop    %ebx
     b97:	5d                   	pop    %ebp
     b98:	c3                   	ret    
     b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ba0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     ba2:	29 d8                	sub    %ebx,%eax
}
     ba4:	5b                   	pop    %ebx
     ba5:	5d                   	pop    %ebp
     ba6:	c3                   	ret    
     ba7:	89 f6                	mov    %esi,%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <strlen>:

uint
strlen(const char *s)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     bb6:	80 39 00             	cmpb   $0x0,(%ecx)
     bb9:	74 15                	je     bd0 <strlen+0x20>
     bbb:	31 d2                	xor    %edx,%edx
     bbd:	8d 76 00             	lea    0x0(%esi),%esi
     bc0:	83 c2 01             	add    $0x1,%edx
     bc3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     bc7:	89 d0                	mov    %edx,%eax
     bc9:	75 f5                	jne    bc0 <strlen+0x10>
    ;
  return n;
}
     bcb:	5d                   	pop    %ebp
     bcc:	c3                   	ret    
     bcd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     bd0:	31 c0                	xor    %eax,%eax
}
     bd2:	5d                   	pop    %ebp
     bd3:	c3                   	ret    
     bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000be0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	57                   	push   %edi
     be4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     be7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     bea:	8b 45 0c             	mov    0xc(%ebp),%eax
     bed:	89 d7                	mov    %edx,%edi
     bef:	fc                   	cld    
     bf0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     bf2:	89 d0                	mov    %edx,%eax
     bf4:	5f                   	pop    %edi
     bf5:	5d                   	pop    %ebp
     bf6:	c3                   	ret    
     bf7:	89 f6                	mov    %esi,%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <strchr>:

char*
strchr(const char *s, char c)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	53                   	push   %ebx
     c04:	8b 45 08             	mov    0x8(%ebp),%eax
     c07:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     c0a:	0f b6 10             	movzbl (%eax),%edx
     c0d:	84 d2                	test   %dl,%dl
     c0f:	74 1d                	je     c2e <strchr+0x2e>
    if(*s == c)
     c11:	38 d3                	cmp    %dl,%bl
     c13:	89 d9                	mov    %ebx,%ecx
     c15:	75 0d                	jne    c24 <strchr+0x24>
     c17:	eb 17                	jmp    c30 <strchr+0x30>
     c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c20:	38 ca                	cmp    %cl,%dl
     c22:	74 0c                	je     c30 <strchr+0x30>
  for(; *s; s++)
     c24:	83 c0 01             	add    $0x1,%eax
     c27:	0f b6 10             	movzbl (%eax),%edx
     c2a:	84 d2                	test   %dl,%dl
     c2c:	75 f2                	jne    c20 <strchr+0x20>
      return (char*)s;
  return 0;
     c2e:	31 c0                	xor    %eax,%eax
}
     c30:	5b                   	pop    %ebx
     c31:	5d                   	pop    %ebp
     c32:	c3                   	ret    
     c33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c40 <gets>:

char*
gets(char *buf, int max)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	57                   	push   %edi
     c44:	56                   	push   %esi
     c45:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c46:	31 f6                	xor    %esi,%esi
     c48:	89 f3                	mov    %esi,%ebx
{
     c4a:	83 ec 1c             	sub    $0x1c,%esp
     c4d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c50:	eb 2f                	jmp    c81 <gets+0x41>
     c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c58:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c5b:	83 ec 04             	sub    $0x4,%esp
     c5e:	6a 01                	push   $0x1
     c60:	50                   	push   %eax
     c61:	6a 00                	push   $0x0
     c63:	e8 32 01 00 00       	call   d9a <read>
    if(cc < 1)
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	85 c0                	test   %eax,%eax
     c6d:	7e 1c                	jle    c8b <gets+0x4b>
      break;
    buf[i++] = c;
     c6f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c73:	83 c7 01             	add    $0x1,%edi
     c76:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c79:	3c 0a                	cmp    $0xa,%al
     c7b:	74 23                	je     ca0 <gets+0x60>
     c7d:	3c 0d                	cmp    $0xd,%al
     c7f:	74 1f                	je     ca0 <gets+0x60>
  for(i=0; i+1 < max; ){
     c81:	83 c3 01             	add    $0x1,%ebx
     c84:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c87:	89 fe                	mov    %edi,%esi
     c89:	7c cd                	jl     c58 <gets+0x18>
     c8b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c90:	c6 03 00             	movb   $0x0,(%ebx)
}
     c93:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c96:	5b                   	pop    %ebx
     c97:	5e                   	pop    %esi
     c98:	5f                   	pop    %edi
     c99:	5d                   	pop    %ebp
     c9a:	c3                   	ret    
     c9b:	90                   	nop
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ca0:	8b 75 08             	mov    0x8(%ebp),%esi
     ca3:	8b 45 08             	mov    0x8(%ebp),%eax
     ca6:	01 de                	add    %ebx,%esi
     ca8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     caa:	c6 03 00             	movb   $0x0,(%ebx)
}
     cad:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb0:	5b                   	pop    %ebx
     cb1:	5e                   	pop    %esi
     cb2:	5f                   	pop    %edi
     cb3:	5d                   	pop    %ebp
     cb4:	c3                   	ret    
     cb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <stat>:

int
stat(const char *n, struct stat *st)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	56                   	push   %esi
     cc4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cc5:	83 ec 08             	sub    $0x8,%esp
     cc8:	6a 00                	push   $0x0
     cca:	ff 75 08             	pushl  0x8(%ebp)
     ccd:	e8 f0 00 00 00       	call   dc2 <open>
  if(fd < 0)
     cd2:	83 c4 10             	add    $0x10,%esp
     cd5:	85 c0                	test   %eax,%eax
     cd7:	78 27                	js     d00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     cd9:	83 ec 08             	sub    $0x8,%esp
     cdc:	ff 75 0c             	pushl  0xc(%ebp)
     cdf:	89 c3                	mov    %eax,%ebx
     ce1:	50                   	push   %eax
     ce2:	e8 f3 00 00 00       	call   dda <fstat>
  close(fd);
     ce7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     cea:	89 c6                	mov    %eax,%esi
  close(fd);
     cec:	e8 b9 00 00 00       	call   daa <close>
  return r;
     cf1:	83 c4 10             	add    $0x10,%esp
}
     cf4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cf7:	89 f0                	mov    %esi,%eax
     cf9:	5b                   	pop    %ebx
     cfa:	5e                   	pop    %esi
     cfb:	5d                   	pop    %ebp
     cfc:	c3                   	ret    
     cfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     d00:	be ff ff ff ff       	mov    $0xffffffff,%esi
     d05:	eb ed                	jmp    cf4 <stat+0x34>
     d07:	89 f6                	mov    %esi,%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d10 <atoi>:

int
atoi(const char *s)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	53                   	push   %ebx
     d14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d17:	0f be 11             	movsbl (%ecx),%edx
     d1a:	8d 42 d0             	lea    -0x30(%edx),%eax
     d1d:	3c 09                	cmp    $0x9,%al
  n = 0;
     d1f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     d24:	77 1f                	ja     d45 <atoi+0x35>
     d26:	8d 76 00             	lea    0x0(%esi),%esi
     d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     d30:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d33:	83 c1 01             	add    $0x1,%ecx
     d36:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     d3a:	0f be 11             	movsbl (%ecx),%edx
     d3d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d40:	80 fb 09             	cmp    $0x9,%bl
     d43:	76 eb                	jbe    d30 <atoi+0x20>
  return n;
}
     d45:	5b                   	pop    %ebx
     d46:	5d                   	pop    %ebp
     d47:	c3                   	ret    
     d48:	90                   	nop
     d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	56                   	push   %esi
     d54:	53                   	push   %ebx
     d55:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d58:	8b 45 08             	mov    0x8(%ebp),%eax
     d5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d5e:	85 db                	test   %ebx,%ebx
     d60:	7e 14                	jle    d76 <memmove+0x26>
     d62:	31 d2                	xor    %edx,%edx
     d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d68:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d6c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d6f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d72:	39 d3                	cmp    %edx,%ebx
     d74:	75 f2                	jne    d68 <memmove+0x18>
  return vdst;
}
     d76:	5b                   	pop    %ebx
     d77:	5e                   	pop    %esi
     d78:	5d                   	pop    %ebp
     d79:	c3                   	ret    

00000d7a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d7a:	b8 01 00 00 00       	mov    $0x1,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <exit>:
SYSCALL(exit)
     d82:	b8 02 00 00 00       	mov    $0x2,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <wait>:
SYSCALL(wait)
     d8a:	b8 03 00 00 00       	mov    $0x3,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <pipe>:
SYSCALL(pipe)
     d92:	b8 04 00 00 00       	mov    $0x4,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <read>:
SYSCALL(read)
     d9a:	b8 05 00 00 00       	mov    $0x5,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <write>:
SYSCALL(write)
     da2:	b8 10 00 00 00       	mov    $0x10,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <close>:
SYSCALL(close)
     daa:	b8 15 00 00 00       	mov    $0x15,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <kill>:
SYSCALL(kill)
     db2:	b8 06 00 00 00       	mov    $0x6,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <exec>:
SYSCALL(exec)
     dba:	b8 07 00 00 00       	mov    $0x7,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <open>:
SYSCALL(open)
     dc2:	b8 0f 00 00 00       	mov    $0xf,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <mknod>:
SYSCALL(mknod)
     dca:	b8 11 00 00 00       	mov    $0x11,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <unlink>:
SYSCALL(unlink)
     dd2:	b8 12 00 00 00       	mov    $0x12,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <fstat>:
SYSCALL(fstat)
     dda:	b8 08 00 00 00       	mov    $0x8,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <link>:
SYSCALL(link)
     de2:	b8 13 00 00 00       	mov    $0x13,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <mkdir>:
SYSCALL(mkdir)
     dea:	b8 14 00 00 00       	mov    $0x14,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <chdir>:
SYSCALL(chdir)
     df2:	b8 09 00 00 00       	mov    $0x9,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    

00000dfa <dup>:
SYSCALL(dup)
     dfa:	b8 0a 00 00 00       	mov    $0xa,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <getpid>:
SYSCALL(getpid)
     e02:	b8 0b 00 00 00       	mov    $0xb,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <sbrk>:
SYSCALL(sbrk)
     e0a:	b8 0c 00 00 00       	mov    $0xc,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <sleep>:
SYSCALL(sleep)
     e12:	b8 0d 00 00 00       	mov    $0xd,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <uptime>:
SYSCALL(uptime)
     e1a:	b8 0e 00 00 00       	mov    $0xe,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <cps>:
SYSCALL(cps)
     e22:	b8 16 00 00 00       	mov    $0x16,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <chpr>:
SYSCALL(chpr)
     e2a:	b8 17 00 00 00       	mov    $0x17,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <pwd>:
SYSCALL(pwd)
     e32:	b8 18 00 00 00       	mov    $0x18,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <freeMem>:
SYSCALL(freeMem)
     e3a:	b8 19 00 00 00       	mov    $0x19,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    
     e42:	66 90                	xchg   %ax,%ax
     e44:	66 90                	xchg   %ax,%ax
     e46:	66 90                	xchg   %ax,%ax
     e48:	66 90                	xchg   %ax,%ax
     e4a:	66 90                	xchg   %ax,%ax
     e4c:	66 90                	xchg   %ax,%ax
     e4e:	66 90                	xchg   %ax,%ax

00000e50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e59:	85 d2                	test   %edx,%edx
{
     e5b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     e5e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     e60:	79 76                	jns    ed8 <printint+0x88>
     e62:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e66:	74 70                	je     ed8 <printint+0x88>
    x = -xx;
     e68:	f7 d8                	neg    %eax
    neg = 1;
     e6a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     e71:	31 f6                	xor    %esi,%esi
     e73:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     e76:	eb 0a                	jmp    e82 <printint+0x32>
     e78:	90                   	nop
     e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     e80:	89 fe                	mov    %edi,%esi
     e82:	31 d2                	xor    %edx,%edx
     e84:	8d 7e 01             	lea    0x1(%esi),%edi
     e87:	f7 f1                	div    %ecx
     e89:	0f b6 92 38 13 00 00 	movzbl 0x1338(%edx),%edx
  }while((x /= base) != 0);
     e90:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e92:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     e95:	75 e9                	jne    e80 <printint+0x30>
  if(neg)
     e97:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e9a:	85 c0                	test   %eax,%eax
     e9c:	74 08                	je     ea6 <printint+0x56>
    buf[i++] = '-';
     e9e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     ea3:	8d 7e 02             	lea    0x2(%esi),%edi
     ea6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     eaa:	8b 7d c0             	mov    -0x40(%ebp),%edi
     ead:	8d 76 00             	lea    0x0(%esi),%esi
     eb0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     eb3:	83 ec 04             	sub    $0x4,%esp
     eb6:	83 ee 01             	sub    $0x1,%esi
     eb9:	6a 01                	push   $0x1
     ebb:	53                   	push   %ebx
     ebc:	57                   	push   %edi
     ebd:	88 45 d7             	mov    %al,-0x29(%ebp)
     ec0:	e8 dd fe ff ff       	call   da2 <write>

  while(--i >= 0)
     ec5:	83 c4 10             	add    $0x10,%esp
     ec8:	39 de                	cmp    %ebx,%esi
     eca:	75 e4                	jne    eb0 <printint+0x60>
    putc(fd, buf[i]);
}
     ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ecf:	5b                   	pop    %ebx
     ed0:	5e                   	pop    %esi
     ed1:	5f                   	pop    %edi
     ed2:	5d                   	pop    %ebp
     ed3:	c3                   	ret    
     ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ed8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     edf:	eb 90                	jmp    e71 <printint+0x21>
     ee1:	eb 0d                	jmp    ef0 <printf>
     ee3:	90                   	nop
     ee4:	90                   	nop
     ee5:	90                   	nop
     ee6:	90                   	nop
     ee7:	90                   	nop
     ee8:	90                   	nop
     ee9:	90                   	nop
     eea:	90                   	nop
     eeb:	90                   	nop
     eec:	90                   	nop
     eed:	90                   	nop
     eee:	90                   	nop
     eef:	90                   	nop

00000ef0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
     ef5:	53                   	push   %ebx
     ef6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ef9:	8b 75 0c             	mov    0xc(%ebp),%esi
     efc:	0f b6 1e             	movzbl (%esi),%ebx
     eff:	84 db                	test   %bl,%bl
     f01:	0f 84 b3 00 00 00    	je     fba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     f07:	8d 45 10             	lea    0x10(%ebp),%eax
     f0a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     f0d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     f0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f12:	eb 2f                	jmp    f43 <printf+0x53>
     f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f18:	83 f8 25             	cmp    $0x25,%eax
     f1b:	0f 84 a7 00 00 00    	je     fc8 <printf+0xd8>
  write(fd, &c, 1);
     f21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f24:	83 ec 04             	sub    $0x4,%esp
     f27:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     f2a:	6a 01                	push   $0x1
     f2c:	50                   	push   %eax
     f2d:	ff 75 08             	pushl  0x8(%ebp)
     f30:	e8 6d fe ff ff       	call   da2 <write>
     f35:	83 c4 10             	add    $0x10,%esp
     f38:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     f3b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f3f:	84 db                	test   %bl,%bl
     f41:	74 77                	je     fba <printf+0xca>
    if(state == 0){
     f43:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     f45:	0f be cb             	movsbl %bl,%ecx
     f48:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f4b:	74 cb                	je     f18 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f4d:	83 ff 25             	cmp    $0x25,%edi
     f50:	75 e6                	jne    f38 <printf+0x48>
      if(c == 'd'){
     f52:	83 f8 64             	cmp    $0x64,%eax
     f55:	0f 84 05 01 00 00    	je     1060 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f5b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f61:	83 f9 70             	cmp    $0x70,%ecx
     f64:	74 72                	je     fd8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f66:	83 f8 73             	cmp    $0x73,%eax
     f69:	0f 84 99 00 00 00    	je     1008 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f6f:	83 f8 63             	cmp    $0x63,%eax
     f72:	0f 84 08 01 00 00    	je     1080 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f78:	83 f8 25             	cmp    $0x25,%eax
     f7b:	0f 84 ef 00 00 00    	je     1070 <printf+0x180>
  write(fd, &c, 1);
     f81:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f84:	83 ec 04             	sub    $0x4,%esp
     f87:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f8b:	6a 01                	push   $0x1
     f8d:	50                   	push   %eax
     f8e:	ff 75 08             	pushl  0x8(%ebp)
     f91:	e8 0c fe ff ff       	call   da2 <write>
     f96:	83 c4 0c             	add    $0xc,%esp
     f99:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f9c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f9f:	6a 01                	push   $0x1
     fa1:	50                   	push   %eax
     fa2:	ff 75 08             	pushl  0x8(%ebp)
     fa5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fa8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     faa:	e8 f3 fd ff ff       	call   da2 <write>
  for(i = 0; fmt[i]; i++){
     faf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     fb3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     fb6:	84 db                	test   %bl,%bl
     fb8:	75 89                	jne    f43 <printf+0x53>
    }
  }
}
     fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fbd:	5b                   	pop    %ebx
     fbe:	5e                   	pop    %esi
     fbf:	5f                   	pop    %edi
     fc0:	5d                   	pop    %ebp
     fc1:	c3                   	ret    
     fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     fc8:	bf 25 00 00 00       	mov    $0x25,%edi
     fcd:	e9 66 ff ff ff       	jmp    f38 <printf+0x48>
     fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     fd8:	83 ec 0c             	sub    $0xc,%esp
     fdb:	b9 10 00 00 00       	mov    $0x10,%ecx
     fe0:	6a 00                	push   $0x0
     fe2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	8b 17                	mov    (%edi),%edx
     fea:	e8 61 fe ff ff       	call   e50 <printint>
        ap++;
     fef:	89 f8                	mov    %edi,%eax
     ff1:	83 c4 10             	add    $0x10,%esp
      state = 0;
     ff4:	31 ff                	xor    %edi,%edi
        ap++;
     ff6:	83 c0 04             	add    $0x4,%eax
     ff9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ffc:	e9 37 ff ff ff       	jmp    f38 <printf+0x48>
    1001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1008:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    100b:	8b 08                	mov    (%eax),%ecx
        ap++;
    100d:	83 c0 04             	add    $0x4,%eax
    1010:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1013:	85 c9                	test   %ecx,%ecx
    1015:	0f 84 8e 00 00 00    	je     10a9 <printf+0x1b9>
        while(*s != 0){
    101b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    101e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1020:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1022:	84 c0                	test   %al,%al
    1024:	0f 84 0e ff ff ff    	je     f38 <printf+0x48>
    102a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    102d:	89 de                	mov    %ebx,%esi
    102f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1032:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1035:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1038:	83 ec 04             	sub    $0x4,%esp
          s++;
    103b:	83 c6 01             	add    $0x1,%esi
    103e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1041:	6a 01                	push   $0x1
    1043:	57                   	push   %edi
    1044:	53                   	push   %ebx
    1045:	e8 58 fd ff ff       	call   da2 <write>
        while(*s != 0){
    104a:	0f b6 06             	movzbl (%esi),%eax
    104d:	83 c4 10             	add    $0x10,%esp
    1050:	84 c0                	test   %al,%al
    1052:	75 e4                	jne    1038 <printf+0x148>
    1054:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1057:	31 ff                	xor    %edi,%edi
    1059:	e9 da fe ff ff       	jmp    f38 <printf+0x48>
    105e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1060:	83 ec 0c             	sub    $0xc,%esp
    1063:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1068:	6a 01                	push   $0x1
    106a:	e9 73 ff ff ff       	jmp    fe2 <printf+0xf2>
    106f:	90                   	nop
  write(fd, &c, 1);
    1070:	83 ec 04             	sub    $0x4,%esp
    1073:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1076:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1079:	6a 01                	push   $0x1
    107b:	e9 21 ff ff ff       	jmp    fa1 <printf+0xb1>
        putc(fd, *ap);
    1080:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1083:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1086:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1088:	6a 01                	push   $0x1
        ap++;
    108a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    108d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1090:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1093:	50                   	push   %eax
    1094:	ff 75 08             	pushl  0x8(%ebp)
    1097:	e8 06 fd ff ff       	call   da2 <write>
        ap++;
    109c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    109f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    10a2:	31 ff                	xor    %edi,%edi
    10a4:	e9 8f fe ff ff       	jmp    f38 <printf+0x48>
          s = "(null)";
    10a9:	bb 30 13 00 00       	mov    $0x1330,%ebx
        while(*s != 0){
    10ae:	b8 28 00 00 00       	mov    $0x28,%eax
    10b3:	e9 72 ff ff ff       	jmp    102a <printf+0x13a>
    10b8:	66 90                	xchg   %ax,%ax
    10ba:	66 90                	xchg   %ax,%ax
    10bc:	66 90                	xchg   %ax,%ax
    10be:	66 90                	xchg   %ax,%ax

000010c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10c1:	a1 84 19 00 00       	mov    0x1984,%eax
{
    10c6:	89 e5                	mov    %esp,%ebp
    10c8:	57                   	push   %edi
    10c9:	56                   	push   %esi
    10ca:	53                   	push   %ebx
    10cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    10ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    10d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d8:	39 c8                	cmp    %ecx,%eax
    10da:	8b 10                	mov    (%eax),%edx
    10dc:	73 32                	jae    1110 <free+0x50>
    10de:	39 d1                	cmp    %edx,%ecx
    10e0:	72 04                	jb     10e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10e2:	39 d0                	cmp    %edx,%eax
    10e4:	72 32                	jb     1118 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10ec:	39 fa                	cmp    %edi,%edx
    10ee:	74 30                	je     1120 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10f3:	8b 50 04             	mov    0x4(%eax),%edx
    10f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10f9:	39 f1                	cmp    %esi,%ecx
    10fb:	74 3a                	je     1137 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    10ff:	a3 84 19 00 00       	mov    %eax,0x1984
}
    1104:	5b                   	pop    %ebx
    1105:	5e                   	pop    %esi
    1106:	5f                   	pop    %edi
    1107:	5d                   	pop    %ebp
    1108:	c3                   	ret    
    1109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1110:	39 d0                	cmp    %edx,%eax
    1112:	72 04                	jb     1118 <free+0x58>
    1114:	39 d1                	cmp    %edx,%ecx
    1116:	72 ce                	jb     10e6 <free+0x26>
{
    1118:	89 d0                	mov    %edx,%eax
    111a:	eb bc                	jmp    10d8 <free+0x18>
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1120:	03 72 04             	add    0x4(%edx),%esi
    1123:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1126:	8b 10                	mov    (%eax),%edx
    1128:	8b 12                	mov    (%edx),%edx
    112a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    112d:	8b 50 04             	mov    0x4(%eax),%edx
    1130:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1133:	39 f1                	cmp    %esi,%ecx
    1135:	75 c6                	jne    10fd <free+0x3d>
    p->s.size += bp->s.size;
    1137:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    113a:	a3 84 19 00 00       	mov    %eax,0x1984
    p->s.size += bp->s.size;
    113f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1142:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1145:	89 10                	mov    %edx,(%eax)
}
    1147:	5b                   	pop    %ebx
    1148:	5e                   	pop    %esi
    1149:	5f                   	pop    %edi
    114a:	5d                   	pop    %ebp
    114b:	c3                   	ret    
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001150 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	56                   	push   %esi
    1155:	53                   	push   %ebx
    1156:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    115c:	8b 15 84 19 00 00    	mov    0x1984,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1162:	8d 78 07             	lea    0x7(%eax),%edi
    1165:	c1 ef 03             	shr    $0x3,%edi
    1168:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    116b:	85 d2                	test   %edx,%edx
    116d:	0f 84 9d 00 00 00    	je     1210 <malloc+0xc0>
    1173:	8b 02                	mov    (%edx),%eax
    1175:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1178:	39 cf                	cmp    %ecx,%edi
    117a:	76 6c                	jbe    11e8 <malloc+0x98>
    117c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1182:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1187:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    118a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1191:	eb 0e                	jmp    11a1 <malloc+0x51>
    1193:	90                   	nop
    1194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1198:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    119a:	8b 48 04             	mov    0x4(%eax),%ecx
    119d:	39 f9                	cmp    %edi,%ecx
    119f:	73 47                	jae    11e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11a1:	39 05 84 19 00 00    	cmp    %eax,0x1984
    11a7:	89 c2                	mov    %eax,%edx
    11a9:	75 ed                	jne    1198 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    11ab:	83 ec 0c             	sub    $0xc,%esp
    11ae:	56                   	push   %esi
    11af:	e8 56 fc ff ff       	call   e0a <sbrk>
  if(p == (char*)-1)
    11b4:	83 c4 10             	add    $0x10,%esp
    11b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    11ba:	74 1c                	je     11d8 <malloc+0x88>
  hp->s.size = nu;
    11bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    11bf:	83 ec 0c             	sub    $0xc,%esp
    11c2:	83 c0 08             	add    $0x8,%eax
    11c5:	50                   	push   %eax
    11c6:	e8 f5 fe ff ff       	call   10c0 <free>
  return freep;
    11cb:	8b 15 84 19 00 00    	mov    0x1984,%edx
      if((p = morecore(nunits)) == 0)
    11d1:	83 c4 10             	add    $0x10,%esp
    11d4:	85 d2                	test   %edx,%edx
    11d6:	75 c0                	jne    1198 <malloc+0x48>
        return 0;
  }
}
    11d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    11db:	31 c0                	xor    %eax,%eax
}
    11dd:	5b                   	pop    %ebx
    11de:	5e                   	pop    %esi
    11df:	5f                   	pop    %edi
    11e0:	5d                   	pop    %ebp
    11e1:	c3                   	ret    
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    11e8:	39 cf                	cmp    %ecx,%edi
    11ea:	74 54                	je     1240 <malloc+0xf0>
        p->s.size -= nunits;
    11ec:	29 f9                	sub    %edi,%ecx
    11ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    11f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    11f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    11f7:	89 15 84 19 00 00    	mov    %edx,0x1984
}
    11fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1200:	83 c0 08             	add    $0x8,%eax
}
    1203:	5b                   	pop    %ebx
    1204:	5e                   	pop    %esi
    1205:	5f                   	pop    %edi
    1206:	5d                   	pop    %ebp
    1207:	c3                   	ret    
    1208:	90                   	nop
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1210:	c7 05 84 19 00 00 88 	movl   $0x1988,0x1984
    1217:	19 00 00 
    121a:	c7 05 88 19 00 00 88 	movl   $0x1988,0x1988
    1221:	19 00 00 
    base.s.size = 0;
    1224:	b8 88 19 00 00       	mov    $0x1988,%eax
    1229:	c7 05 8c 19 00 00 00 	movl   $0x0,0x198c
    1230:	00 00 00 
    1233:	e9 44 ff ff ff       	jmp    117c <malloc+0x2c>
    1238:	90                   	nop
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1240:	8b 08                	mov    (%eax),%ecx
    1242:	89 0a                	mov    %ecx,(%edx)
    1244:	eb b1                	jmp    11f7 <malloc+0xa7>
