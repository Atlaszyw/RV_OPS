#ifndef __PAGE_H__
#define __PAGE_H__

#include "types.h"

void* page_alloc( int npages );
void  page_free( void* p );
void  page_test( void );
void  page_init( void );
#endif
