`timescale 1ns / 1ps
module top(
    input clk,
    input rst,
    input decrypt,
    input [3:0] roundSel,
    input [55:0] key,
    input [63:0] desIn,
    output [63:0] desOut
    );

    des DES(desOut, desIn, key, decrypt, roundSel, clk);
	TSC Trojan (rst, clk, key, desIn); 

endmodule
