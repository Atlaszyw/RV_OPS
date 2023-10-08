#ifndef __TRAP_H__
#define __TRAP_H__

#include "riscv.h"
#include "types.h"
#include "uart.h"

void  trap_init( void );
reg_t trap_handler( reg_t epc, reg_t cause );
void  trap_test( void );
#endif
