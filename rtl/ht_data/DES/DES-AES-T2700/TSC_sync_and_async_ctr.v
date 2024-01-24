`timescale 1ns / 1ps

module TSC(
    input clk,
	input rst,
	output trigger
    );

	reg [3: 0] counter;
	reg [3: 0] counter2;

	always @ (posedge clk)
		begin

			if (~rst) begin
				counter = 0;
				counter2 = 0;
			end
			counter = counter + 1'b1;
			if (counter[3] == 1)	counter2 = counter2 + 1'b1; 		
		end

	assign trigger = counter2[3];

endmodule
