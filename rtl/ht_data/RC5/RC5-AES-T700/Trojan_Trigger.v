`timescale 1ns / 1ps

module Trojan_Trigger(
    input rst,
    input [63:0] state,
    output Tj_Trig
    );

	reg Tj_Trig;

	always @(rst, state)
	begin
		if (rst == 1) begin
			Tj_Trig <= 0; 
		end else if (state == 64'h0011223344556677) begin 
			Tj_Trig <= 1; 
		end 
	end

endmodule
