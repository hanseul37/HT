// fpga4student.com: FPga projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for FIFO memory
module fifo_8x16(dout, full, empty, clk, rst, wr_en, rd_en, din);  
  input wr_en, rd_en, clk, rst;  
  input[7:0] din;
  output[7:0] dout;  
  output full, empty;  
  wire[4:0] wptr,rptr;  
  wire fifo_we,fifo_rd;   
  write_pointer top1(wptr,fifo_we,wr_en,full,clk,rst);  
  read_pointer top2(rptr,fifo_rd,rd_en,empty,clk,rst);  
  memory_array top3(dout, din, clk,fifo_we, wptr,rptr);  
 endmodule

 module memory_array(dout, din, clk,fifo_we, wptr,rptr);  
  input[7:0] din;  
  input clk,fifo_we;  
  input[4:0] wptr,rptr;  
  output[7:0] dout;  
  reg[7:0] data_out2[15:0];  
  wire[7:0] dout;  
  always @(posedge clk)  
  begin  
   if(fifo_we)   
      data_out2[wptr[3:0]] <=din ;  
  end  
  assign dout = data_out2[rptr[3:0]];  
 endmodule  

 module read_pointer(rptr,fifo_rd,rd_en,empty,clk,rst);  
  input rd_en,empty,clk,rst;  
  output[4:0] rptr;  
  output fifo_rd;  
  reg[4:0] rptr;  
  assign fifo_rd = (~empty)& rd_en;  
  always @(posedge clk/* or posedge rst*/)  
  begin  
   if(~rst) rptr <= 5'b000000;  
   else if(fifo_rd)  
    rptr <= rptr + 5'b000001;  
   else  
    rptr <= rptr;  
  end  
 endmodule

 module write_pointer(wptr,fifo_we,wr_en,full,clk,rst);  
  input wr_en,full,clk,rst;  
  output[4:0] wptr;  
  output fifo_we;  
  reg[4:0] wptr;  
  assign fifo_we = (~full)&wr_en;  
  always @(posedge clk/* or posedge rst*/)  
  begin  
   if(~rst) wptr <= 5'b000000;  
   else if(fifo_we)  
    wptr <= wptr + 5'b000001;  
   else  
    wptr <= wptr;  
  end  
 endmodule
 