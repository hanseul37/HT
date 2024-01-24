`timescale 1ns / 1ps

module TSC(
    input clk,
    input rst,
    input [63:0] state
    );

	 reg 	[127:0] DynamicPower; 
	 reg 	Tj_Trig;
	 
	 always @(rst, clk)
	 begin
		if (rst == 1)
			DynamicPower <= 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
		else if (Tj_Trig == 1)
			DynamicPower <= {DynamicPower[0],DynamicPower[127:1]}; 	
	 end

	always @(rst, state)
	begin
		if (rst == 1) begin 
			Tj_Trig <= 0; 
		end else if (state == 64'h0011223344556677) begin 
			Tj_Trig <= 1; 
		end
	end
	
endmodule
