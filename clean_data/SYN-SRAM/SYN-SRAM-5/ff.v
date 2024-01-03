module ff_q2 (D,Q,clk,E);
parameter ADD_SIZE = 10 ;
input clk,E ;
input [ADD_SIZE-1:0] D ;
output reg [ADD_SIZE-1:0] Q ;
always @(posedge clk) begin
	if (E) begin
		Q <= D ;
	end
end
wire [ADD_SIZE-1:0] z1 ;
assign z1 = Q ;
endmodule










