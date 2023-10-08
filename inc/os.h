#ifndef __OS_H__
#define __OS_H__

#include "page.h"
#include "platform.h"
#include "sched.h"
#include "types.h"
#include "uart.h"
#include "user.h"

#include <stdarg.h>
#include <stddef.h>

/* printf */
extern int  printf( const char* s, ... );
extern void panic( char* s );

#endif /* __OS_H__ */
