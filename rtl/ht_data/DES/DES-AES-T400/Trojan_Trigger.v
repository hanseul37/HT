`timescale 1ns / 1ps

module Trojan_Trigger(
    input rst,
    input clk,
    input [63:0] desIn,
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
		else begin tempClk1 <= 0; tempClk2 <= 0; end
	end

	always @(desIn)
	begin
		if (desIn == 64'hFFFFFFFFFFFFFFFF)	
			Detected <= 1; 
		else 
			Detected <= 0; 
	end
endmodule
