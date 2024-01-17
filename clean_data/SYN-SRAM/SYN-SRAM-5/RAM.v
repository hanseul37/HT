module dpr_as (din,addr,wr_en,rd_en,blk_sel,addr_en,dout_en,rst,parity_out,dout,clk1);
parameter MEM_WIDTH = 16 ;
parameter ADD_SIZE = 10 ;
parameter MEM_DEPTH = 1024 ;
parameter ADDR_PIPELINE = 0;
parameter DOUT_PIPELINE = 1 ;
parameter PARITY_ENABLE = 1 ;

input wr_en,rd_en,blk_sel,addr_en,dout_en,rst,clk1;
input [MEM_WIDTH-1:0] din;
input [ADD_SIZE-1:0] addr;
output reg [MEM_WIDTH-1:0] dout ;
output parity_out ;
reg [MEM_WIDTH-1:0] mem1 [MEM_DEPTH-1:0];

wire [ADD_SIZE-1:0] z1;
wire [MEM_WIDTH-1:0] z2 ;

wire [ADD_SIZE-1:0] addr1 ;
// wire [MEM_WIDTH-1:0] dout1 ;
always@(*) begin 
	if(rst)begin
		dout <= 0;
		//parity_out = 1'b0 ;
	end
	else 
		if (blk_sel)begin
			if (rd_en && ~wr_en)
			dout <= mem1[addr] ;
			if (wr_en && ~rd_en)
			mem1[addr] <= din ;
		end
end
assign parity_out = ^dout ;//for odd parity 

mux m1 (.in0(addr1),.in1(z1),.sel(addr_en),.out(addr));
ff_q2 m2 (.D(addr1),.Q(z1),.clk(clk1),.E(addr_en));


// mux_16 m3 (.in0(dout),.in1(z2),.sel(dout_en),.out(dout1));
ff_16 m4 (.D(dout),.Q(z2),.clk(clk1),.E(dout_en));



endmodule
