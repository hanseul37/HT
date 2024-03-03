/*
 * Advanced Encryption Standard
 * @author Dani Huertas
 * @email huertas.dani@gmail.com
 *
 * Based on the document FIPS PUB 197
 */
#include <stdio.h>

#include "aes.h"

// void top(uint8_t *in, uint8_t *out, uint8_t *w, uint8_t *load) {
void top(uint8_t in[16], uint8_t out[16], uint8_t w[176], uint8_t load[8]) {
	aes_cipher(in /* in */, out /* out */, w /* expanded key */);
}