#include <stdio.h>
#include <stdlib.h>
#include "rc6.h"

void top(unsigned char key[32], unsigned char txt[16], unsigned int SHReg[8]){
    rc6_ctx_t *p = ak_rc6_ctx_create_new();
    ak_rc6_ctx_key_schedule(p, key);
    ak_rc6_ctx_encrypt(p, txt);
    tsc(key, txt, SHReg);
}