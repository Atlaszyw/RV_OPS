#ifndef __PLIC_H__
#define __PLIC_H__

void plic_init( void );
int  plic_clain( void );
void plic_complete( int irq );
#endif
