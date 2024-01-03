module Q3_ASS3_tb ();
	reg addr_en,dout_en,blk_sel,rst,clk1,rd_en,wr_en;
	//reg wr_en,rd_en,blk_sel,addr_en,dout_en,rst,clk1;
	reg [15:0] din ;
	reg [9:0] addr ;
	wire [15:0] dout1 ;
	wire [15:0] dout ;

dpr_as m5 (din,addr,wr_en,rd_en,blk_sel,addr_en,dout_en,rst,parity_out,dout,clk1);
integer i ;
	initial begin 
		$readmemh("mem1.dat",m5.mem1);
		rst = 1 ;
		rd_en=0;
		addr=0;
		blk_sel=1;
		#10;
		rst = 0;
		//testing writing operation
		for(i=0;i<10000;i=i+1)begin
			@(negedge clk1);
			dout_en=$random;
			addr_en=$random;
			din=$random;
			addr=$random;
			wr_en=$random; // look at dout1 and parity_out1
		end
		//testing read operation
		wr_en=0;
		for(i=0;i<10000;i=i+1)begin
			@(negedge clk1);
			dout_en=$random;
			addr_en=$random;
			addr=$random;
			rd_en=$random;
		end
		$stop;
	end

	initial begin 
 		clk1 = 0; 
 		forever 
 		#1 clk1 = ~clk1;
 		
	end
endmodule





