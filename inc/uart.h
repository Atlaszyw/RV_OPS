#ifndef __UART_H__
#define __UART_H__

/* uart */
void uart_init( void );
int  uart_putc( char ch );
void uart_puts( char* s );

#endif
