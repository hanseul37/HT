module ff_16 (D,Q,clk,E);
parameter MEM_WIDTH = 16 ;
input clk,E ;
input [MEM_WIDTH-1:0] D ;
output reg [MEM_WIDTH-1:0] Q ;
always @(posedge clk) begin
	if (E) begin
		Q <= D ;
	end
end
wire [MEM_WIDTH-1:0] z2 ;
assign z2 = Q ;
endmodule










