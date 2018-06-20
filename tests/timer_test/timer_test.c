/*****************************************************************************
 *
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sc_print.h"
#include "csr.h"
#include "scr1_specific.h"

# define printf sc_printf

//#include "timeit.c"

#define BASE_ADRS     (0x00000000)
#define BASE_END_ADRS (0x0000ffff) 
#define REG_ADRS      (0x00010000)
#define REG_END_ADRS  (0x00010fff) 

#define GPIO_BASH_ADRS (0x00011000)
#define UART_BASH_ADRS (0x00010000)

#define DTCM_BASE_ADRS     (0x00490000)
#define DTCM_BASE_END_ADRS (0x0049ffff) 

#define ITCM_BASE_ADRS     (0x00480000)
#define ITCM_BASE_END_ADRS (0x0048ffff) 

#define WRITE_REG(addr,ch)  *(volatile unsigned int *) (addr) = ch
#define READ_REG(addr,ch)  ch = *(volatile unsigned int *) (addr) 

typedef unsigned char byte;






int main (argc, argv)
int	argc;
char	*argv[];
  /* main program, corresponds to procedures        */
  /* Main and Proc_0 in the Ada version             */
{
    unsigned long a;
    unsigned int b;
    unsigned int c;
    unsigned int i;
    READ_REG(mtime_ctrl,a);
    printf("mtime_ctrl: %8x \n",a);
    //WRITE_REG(mtime_ctrl,0x00000000);
    //READ_REG(mtime_ctrl,a);
    //printf("mtime_ctrl: %8x \n",a);



    READ_REG(mtime_div,a);
    printf("mtime_div: %8x \n",a);
    WRITE_REG(mtime_div,0x00000000);
    READ_REG(mtime_div,a);
    printf("mtime_div: %8x \n",a);
    a = read_csr(time);
    printf("mtime: %8x \n",a);
    //write_csr(time,0xffff0000);
    a = read_csr(time);
    printf("mtime: %8x \n",a);

    WRITE_REG(mtime,0xFFFF0000);

    a = read_csr(time);
    printf("mtime: %8x \n",a);

    //write_csr(time,0x1);
    //a = read_csr(time);
    //printf("time: %8x \n",a);

    //a = read_csr(timeh);
    //printf("mtimeh: %8x \n",a);
    //READ_REG(mtimecmp,a);
    //printf("mtimecmp: %8x \n",a);
    //READ_REG(mtimecmph,a);
    //printf("mtimecmph: %8x \n",a);





    b = 0;
    //for (i=0; i <100; i=i+1) {
    while (c < 1) {
        a = rdtime();
        c = read_csr(timeh);
        for (i=0; i < 100000; i++) {
    	__asm__ (
        "nop"
        ); 
    
        }
    
        printf ("--: %8x ",a);
        printf ("delta: %8x \n",a-b);
        printf ("timeh: %8x \n",c);
        b = a;
    
    }
    

    return 0;

}
