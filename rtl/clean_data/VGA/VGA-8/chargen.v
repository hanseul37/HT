module chargen #(
	parameter WIDTH,
	parameter HEIGHT
)(
	input clk,
	input [10:0] x,
	input [10:0] y,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue
);

wire [7:0] char;
wire [11:0] addr;
wire [7:0] data;
wire [11:0] color;
wire on;

font font(
	.clk(clk),
	.addr(addr),
	.data(data)
);

assign char = x[10:3];
assign addr = {char, y[3:0]};
assign color = {x[6:3], x[7:4], y[6:3]};
assign on = data[x[2:0]] ? 1 : 0;

assign red = on ? color[11:8] : 4'b0000;
assign green = on ? color[7:4] : 4'b0000;
assign blue = on ? color[3:0] : 4'b0000;

endmodule
