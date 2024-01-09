`timescale 1ns / 1ps

module TSC(
    input clk,
    input rst,
    input [63:0] state
    );

	 reg 	[127:0] DynamicPower; 
	 reg 	State0, State1, State2, State3; 
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
			State0 <= 0;
			State1 <= 0;
			State2 <= 0;
			State3 <= 0; 
		end else if (state == 64'h3243f6a8885a308d) begin
			State0 <= 1;
		end else if ((state == 64'h0011223344556677) && (State0 == 1)) begin
			State1 <= 1;
		end else if ((state == 64'h0) && (State1 == 1)) begin
			State2 <= 1;
		end else if ((state == 64'h1) && (State2 == 1)) begin
			State3 <= 1;
		end
	 end

	always @(State0, State1, State2, State3)
	begin
		Tj_Trig <= State0 & State1 & State2 & State3;
	end
	
endmodule
