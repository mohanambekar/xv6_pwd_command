#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc != 1){
    printf(2, "Usage: pwd\n");
    exit();
  }
  pwd();
  exit();
}
