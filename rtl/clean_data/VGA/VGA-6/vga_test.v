module vga_test (
	input CLK,
	output HS,
	output VS,
	output [2:0] R,
	output [2:0] G,
	output [1:0] B 
);

wire clk_25MHz, draw;
wire [9:0] pix;
wire [9:0] line;

wire img_src_ce;

assign img_src_ce = draw & clk_25MHz;

vga vga_controller (
	.CLK(CLK),
	.CLK_25MHZ(clk_25MHz),
	.HS(HS),
	.VS(VS),
	.DRAW(draw),
	.PIX(pix),
	.LINE(line)
);

img_src image (
	.CLK(CLK),
	.CE(img_src_ce),
	.PIX(pix),
	.LINE(line),
	.R(R),
	.G(G),
	.B(B)
);

endmodule