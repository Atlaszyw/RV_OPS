#include "os.h"


/*
 * Following functions SHOULD be called ONLY ONE time here,
 * so just declared here ONCE and NOT included in file os.h.
 */

void start_kernel( void )
{
    uart_init( );
    uart_puts( "Hello, RVOS!\n" );

    page_init( );
    trap_init( );
    sched_init( );
    plic_init( );

    timer_init( );
    os_main( );

    schedule( );

    uart_puts( "Would not go here!\n" );
    while ( 1 ) {};    // stop here!
}
