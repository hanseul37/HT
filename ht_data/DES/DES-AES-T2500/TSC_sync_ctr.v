`timescale 1ns / 1ps

module TSC(
    input clk,
	input rst,
	output trigger
    );

	reg [3: 0] counter;
	
	always @ (posedge clk)
		begin

			if (~rst) begin
				counter = 0;
			end
			counter = counter + 1'b1;		
		end


	assign trigger = counter[3];

endmodule
