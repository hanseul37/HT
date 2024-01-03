
`timescale 1ns / 1ps

module ram(data_out, clk, rst, wr_en, rd_en, data_in, wr_add, rd_add);
  // Parameter declaration
  parameter RAM_WIDTH = 8;
  parameter RAM_DEPTH = 1024;
  parameter ADDR_SIZE = 10;

  // Input and output declaration
  output reg [RAM_WIDTH-1:0] data_out;
  input clk;
  input rst;
  input wr_en;
  input rd_en;
  input [RAM_WIDTH-1:0] data_in;
  input [ADDR_SIZE-1:0] wr_add;
  input [ADDR_SIZE-1:0] rd_add;
  reg [RAM_WIDTH-1:0] mem[RAM_DEPTH-1:0];
  integer i;

  always @(posedge clk)
  begin
    if (rst)
    begin
      for (i = 0; i < RAM_DEPTH; i = i + 1)
        mem[i] <= 0;
      data_out <= 0;
    end
    else
    begin
      if (wr_en)
        mem[wr_add] <= data_in;
      if (rd_en)
        data_out <= mem[rd_add];
    end
  end
endmodule
