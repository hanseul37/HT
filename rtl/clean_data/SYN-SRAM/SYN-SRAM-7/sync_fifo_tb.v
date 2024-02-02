//Testbench for synchronous fifo

`timescale 1ns / 1ps
`define cycle 10
`define data_width 8
`define fifo_depth 8
`define addr_width 16

module sync_fifo_tb();

reg clk,rstn,wr_en,rd_en,
reg [(`data_width-1):0] data_in,
wire fifo_empty,fifo_full,
wire rd_vld,
wire [(`data_width-1):0] data_out);

//Instantiation
sync_fifo DUT (clk,rstn,wr_en,rd_en,data_in,
               fifo_empty,fifo_full,rd_vld,data_out);
  
//clock generator
initial clk= 1'b0;
always #(`cycle/2) clk = ~clk;

//Stimulus
integer i;
initial begin
  rstn = 1'b1;
  wr_en = 1'b0;
  rd_en = 1'b0;
  data_in = 8'b0;
  #(`cycle);
  rstn = 1'b0;  //reset system
  #(`cycle);
  rstn = 1'b1; //finish reset
  
  //Write data
  wr_en = 1'b1;
  rd_en = 1'b0;
  
  for (i = 0; i < 8; i = i + 1) begin
  data_in = i;
  #(`cycle);
  end
  
  //Read data
  wr_en = 1'b0;
  rd_en = 1'b1;
  
  for (i = 0; i < 8; i = i + 1) begin
  #(`cycle);
  end
  
  //Write data
  wr_en = 1'b1;
  rd_en = 1'b0;
  
  for (i = 0; i < 8; i = i + 1) begin
  data_in = i;
  #(`cycle);
  end
  
  #(`cycle);
  #(`cycle);
  #(`cycle);
  #(`cycle);
  
  $finish;
end

endmodule  
