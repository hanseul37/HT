#include <stdio.h>

void top(unsigned char key[16], unsigned int pt1[2], unsigned int ct[2], unsigned char INV_out[11], unsigned char counter){
    RC5_SETUP(key);
    RC5_ENCRYPT(pt1,ct);
    tsc(ct, INV_out, counter);
}