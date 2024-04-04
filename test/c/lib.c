#include "lib.h"

int16_t foo(){
    return 2;
}

int16_t baz(){
    int16_t a = foo() * foo();
    return a;
}
