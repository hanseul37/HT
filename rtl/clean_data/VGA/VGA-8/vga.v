module vga(
	input FPGA_CLK_50,
	output [9:0] LED,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue,
	output hsync,
	output vsync,
	input [2:0] switches
);

localparam WIDTH = 800;
localparam HEIGHT = 600;

wire pclk;

wire [10:0] x;
wire [10:0] y;

wire [3:0] ured;
wire [3:0] ugreen;
wire [3:0] ublue;
wire blank;

pll40 pll(FPGA_CLK_50, pclk);

chargen #(
	.WIDTH(800),
	.HEIGHT(600)
) chargen (pclk, x, y, ured, ugreen, ublue);

sync sync(
	.clk(pclk),
	.x(x),
	.y(y),
	.hsync(hsync),
	.vsync(vsync)
);

assign blank = x >= WIDTH || y >= HEIGHT;
assign red = blank ? 4'b0000 : ured;
assign green = blank ? 4'b0000 : ugreen;
assign blue = blank ? 4'b0000 : ublue;

endmodule
