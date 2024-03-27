#include <stdio.h>
#include <string.h>

#include "xtea.h"

void top(unsigned char key[16], unsigned char text[16], unsigned char load[32], xtea_t xtea, char encode[64], unsigned char iv[8], int enclen){
    xtea_setkey(&xtea, key);
    enclen = xtea_enclen((int)strlen(text));

    set(iv, 0, sizeof(iv));
    enclen = xtea_encode(&xtea, encode, text, (int)strlen(text), iv);

    tsc(key, load);
}