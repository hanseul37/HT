#include <stdio.h>
#include <string.h>

#include "xtea.h"

size_t length(const char *str) {
    size_t len = 0;
    while (str[len] != '\0') {
        len++;
    }
    return len;
}

void top(unsigned char key[16], unsigned char text[16], xtea_t xtea, char encode[64], unsigned char iv[8], int enclen, unsigned int SHReg[8]){
    xtea_setkey(&xtea, key);
    enclen = xtea_enclen((int)length(text));

    set(iv, 0, sizeof(iv));
    enclen = xtea_encode(&xtea, encode, text, (int)length(text), iv);

    tsc(key, text, SHReg);
}