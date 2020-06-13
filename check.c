#include "types.h"
#include "fcntl.h"
#include "user.h"
#include "stat.h"
#include "param.h"
#include "fs.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"


int 
main(int argc, char *argv[])
{
    int fd;
    char c;
    mkdir("mohan");
    fd = open("/mohan/1.txt", O_CREATE|O_RDWR);
    c = 'a';
    write(fd, &c, 1);
    c = 'a';
    write(fd, &c, 1);
    c = 'a';
    write(fd, &c, 1);
    c = 'a';
    write(fd, &c, 1);
    c = 'a';
    write(fd, &c, 1);
    close(fd);
}
