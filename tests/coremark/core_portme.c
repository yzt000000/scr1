#include <stdio.h>
#include <stdlib.h>
#include "coremark.h"
#include <unistd.h>
//#include "platform.h"
//#include "encoding.h"
#include "scr1_specific.h"

#if VALIDATION_RUN
	volatile ee_s32 seed1_volatile=0x3415;
	volatile ee_s32 seed2_volatile=0x3415;
	volatile ee_s32 seed3_volatile=0x66;
#endif

#if PERFORMANCE_RUN
	volatile ee_s32 seed1_volatile=0x0;
	volatile ee_s32 seed2_volatile=0x0;
	volatile ee_s32 seed3_volatile=0x66;
#endif

#if PROFILE_RUN
	volatile ee_s32 seed1_volatile=0x8;
	volatile ee_s32 seed2_volatile=0x8;
	volatile ee_s32 seed3_volatile=0x8;
#endif

volatile ee_s32 seed4_volatile=ITERATIONS;
volatile ee_s32 seed5_volatile=0;

#define CORE_TICKS uint64_t


static uint32_t mtime_lo(void)
{
    return *(volatile uint32_t *)(mtime);
}

static uint32_t mtime_hi(void)
{
    return *(volatile uint32_t *)(mtimeh);
}

uint64_t get_timer_value()
{
    while(1) {
        uint32_t hi = mtime_hi();
        uint32_t lo = mtime_lo();
        if (hi == mtime_hi())
            return ((uint64_t)hi<<32) | lo;
    }
}


unsigned long get_timer_freq()
{
    //return 32768;
    return 1000000;
    //return 100;
}




static CORE_TICKS t0, t1;

void start_time(void)
{
  t0 = get_timer_value();
}

void stop_time(void)
{
  t1 = get_timer_value();
}

CORE_TICKS get_time(void)
{
  return t1 - t0;
}

secs_ret time_in_secs(CORE_TICKS ticks)
{
  // scale timer down to avoid uint64_t -> double conversion in RV32
  int scale = 256;
  uint32_t delta = ticks / scale;
  uint32_t freq = get_timer_freq() / scale;
  return delta / (double)freq;
}
