module sync(
	input clk,
	output reg [10:0] x,
	output reg [10:0] y,
	output hsync,
	output vsync
);

localparam WIDTH = 800;
localparam HEIGHT = 600;

localparam HFPORCH = 40;
localparam HPULSE = 128;
localparam HBPORCH = 88;

localparam VFPORCH = 1;
localparam VPULSE = 4;
localparam VBPORCH = 23;

// wire pclk;
// pll pll(clk, pclk);

initial
begin
	x <= 0;
	y <= 0;
end

assign hsync = x >= WIDTH + HFPORCH && x < WIDTH + HFPORCH + HPULSE ? 0 : 1;
assign vsync = y >= HEIGHT + VFPORCH && y < HEIGHT + VFPORCH + VPULSE ? 0 : 1;

always @(posedge clk)
begin
	if (x == WIDTH + HFPORCH + HPULSE + HBPORCH)
	begin
		x <= 0;
		y <= y + 1;
	end
	else
		x <= x + 1;
	
	if (y == HEIGHT + VFPORCH + VPULSE + VBPORCH)
		y <= 0;
end

endmodule
