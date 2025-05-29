/*
 * shared_api.h
 *
 *  Created on: Mar 16, 2025
 *      Author: vahid
 */

#ifndef INC_SHARED_API_H_
#define INC_SHARED_API_H_
#include <stdarg.h>

typedef struct {
    void (*shared_UART2_SendChar)(char c);
    void (*shared_UART2_SendString)(unsigned char *str);
    void (*shared_UART2_SendData)(unsigned char *data, unsigned int len);
    void (*shared_int_to_str)(int value, char *buf, int base);
    void (*shared__vsprintf)(char *buffer, const char *format, va_list args) ;
    void (*shared_log_format)(const char *format, ...) ;
} SharedAPI_t;

#define SHARED_API_ADDR 0x08001000
#define SHARED_API  (*(SharedAPI_t*) SHARED_API_ADDR)


#endif /* INC_SHARED_API_H_ */
