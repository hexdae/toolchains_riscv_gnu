#include <stdint.h>
#include <stddef.h>

#define UART_LSR (0x5)
#define CHAR_AVAILABLE(uart) (*(uart + UART_LSR) & 0x1)

unsigned char *uart = (unsigned char *)0x10000000;
void riscv_putchar(char c)
{
    *uart = c;
    return;
}

int riscv_print(const char *str)
{
    while (*str != '\0')
    {
        riscv_putchar(*str);
        str++;
    }
    return 0;
}

int main(void)
{
    riscv_print("Hello world!\r\n");
    while (1)
    {
        if (CHAR_AVAILABLE(uart))
        {
            char c = *uart;

            if (c == 0x08 || c == 0x7F)
                riscv_print("\b \b");

            if (c == '\r')
                riscv_putchar('\n');

            riscv_putchar(c);
        }
    }
    return 0;
}
