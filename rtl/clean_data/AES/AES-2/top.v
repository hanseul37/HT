module top(clk, reset, enable, key, in, out, out_inv);
	input clk;
	input reset;
	input enable;
	
	input [127:0] key;
	input [127:0] in;
	
	output reg [127:0] out;
	output reg [127:0] out_inv;
	
	wire decReset1;
	
	enchiper#(.Nk(4)) p1(.enable(enable), .decReset(decReset1),.reset(reset),.clk(clk),.load(in),.out(out),.key(key));
	dechiper#(.Nk(4)) p2(.decReset(decReset1),.clk(clk),.in(out),.out(out_inv),.key(key));

endmodule