module Q3_ASS3 (din1,wr_en1,rd_en1,addr1,addr_en1,dout1,dout_en1,parity_out1,blk_sel1,rst1,clk1);
parameter ADD_SIZE = 10 ;
parameter MEM_WIDTH = 16 ;
parameter MEM_DEPTH = 1024 ;
input addr_en1,rd_en1,wr_en1,blk_sel1,rst1,clk1;
input [MEM_WIDTH-1:0] din1 ;
input [ADD_SIZE-1:0] addr1 ;
output  [MEM_WIDTH-1:0] dout1 ;
output  dout_en1,parity_out1 ;
wire z1,z2 ;

mux m1 (.in0(addr1),.in1(z1),.sel(addr_en1),.out(addr));
ff_q2 m2 (.D(addr1),.Q(z1),.clk(clk1),.E(addr_en1));




dpr_as m5 (.din(din1),.addr(addr1),.wr_en(wr_en1),.rd_en(rd_en1),.blk_sel(blk_sel1),.addr_en(addr_en1),.dout_en(dout_en1),.rst(rst1),.parity_out(parity_out1),.dout(dout1));




mux m3 (.in0(dout),.in1(z2),.sel(dout_en1),.out(dout1));
ff_q2 m4 (.D(dout),.Q(z2),.clk(clk1),.E(dout_en1));

endmodule 
/*
assign clk = clk1 ;
assign addr = addr1 ;
assign addr_en = addr_en1 ;
assign dout = dout1 ;
assign dout_en = dout_en1 ;
assign parity_out = parity_out1 ;
assign din = din1 ;
assign wr_en = wr_en1 ;
assign rd_en = rd_en1 ;
assign blk_sel = blk_sel1 ;
assign rst = rst1 ;

*/







//assign dout_en = dout_en1 ;