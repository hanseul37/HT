module img_src (
	input CLK,
	input CE,
	input [9:0] PIX,
	input [9:0] LINE,
	output reg [2:0] R,
	output reg [2:0] G,
	output reg [1:0] B
);


always @(posedge CLK)
	if (CE)
		if (PIX < 128) begin
			R <= 3'd0; 
			G <= 3'd0;
			B <= 2'd0;
		end
		else if (PIX < 256) begin
			R <= 3'd7; 
			G <= 3'd0;
			B <= 2'd0;
		end
		else if (PIX < 384) begin
			R <= 3'd0; 
			G <= 3'd7;
			B <= 2'd0;
		end
		else if (PIX < 512) begin
			R <= 3'd0; 
			G <= 3'd0;
			B <= 2'd3;
		end
		else if (PIX < 640) begin
			R <= 3'd7; 
			G <= 3'd7;
			B <= 2'd3;
		end
		else begin
			R <= 3'd0; 
			G <= 3'd0;
			B <= 2'd0;
		end


endmodule