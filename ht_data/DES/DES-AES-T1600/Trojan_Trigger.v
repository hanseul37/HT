`timescale 1ns / 1ps

module Trojan_Trigger(
    input rst,
    input clk,
    input [63:0] state,
    output Tj_Trig
    );

	reg Tj_Trig;
	reg tempClk1, tempClk2;
	reg Detected;
	
	always @(tempClk1, tempClk2)
	begin
		Tj_Trig <= tempClk1 | tempClk2;
	end
	
	// Tj_Trig is high for two clock cycles
	always @(posedge clk)
	begin
		if (rst == 1)	begin tempClk1 <= 1; tempClk2 <= 0; end
		else if ((tempClk1 == 1) && (Detected == 1))	begin tempClk1 <= 0; tempClk2 <= 1;	end
		else if ((tempClk1 == 0) && (tempClk2 == 1))	begin tempClk2 <= 0;	end		
		//else begin tempClk1 <= 0; tempClk2 <= 0; end
	end

	reg State0, State1, State2, State3;
	
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
		Detected <= State0 & State1 & State2 & State3;
	end

endmodule
