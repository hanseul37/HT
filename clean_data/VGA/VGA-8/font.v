module font
#(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 12)
(
	input clk, 
	input [(ADDR_WIDTH - 1):0] addr,
	output [(DATA_WIDTH - 1):0] data
);

	reg [DATA_WIDTH - 1:0] rom[0:2 ** ADDR_WIDTH - 1];

	initial
	begin
		$readmemb("font.rom", rom);
	end

	assign data = rom[addr];

endmodule
