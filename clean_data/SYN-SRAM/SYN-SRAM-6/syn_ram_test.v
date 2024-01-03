`timescale 1ns / 1ps

module tb_ram;

  // Parameters
  parameter RAM_WIDTH = 8;
  parameter RAM_DEPTH = 1024;
  parameter ADDR_SIZE = 10;

  // Signals
  reg clk;
  reg rst;
  reg wr_en;
  reg rd_en;
  reg [RAM_WIDTH-1:0] data_in;
  reg [ADDR_SIZE-1:0] wr_add;
  reg [ADDR_SIZE-1:0] rd_add;

  wire [RAM_WIDTH-1:0] data_out;

  // Instantiate the RAM module
  ram uut (
    .data_out(data_out),
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .wr_add(wr_add),
    .rd_add(rd_add)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test stimulus
  initial begin
    // Initialize signals
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;
    wr_add = 0;
    rd_add = 0;

    // Apply reset
    #10 rst = 0;

    // Write operation
    #10 data_in = 8'hAA;
    wr_en = 1;
    wr_add = 10'h03;
    #10 wr_en = 0;

    // Read operation
    #10 rd_en = 1;
    rd_add = 10'h03;
    #10 rd_en = 0;
  end

  initial begin
    $monitor(
      "$time=%0d ", $time,
      "rst=%0h ", rst,
      "clk=%0h ", clk,
      "write_en=%0h ", wr_en,
      "rd_en=%0h ", rd_en,
      "data_in=%0h ", data_in,
      "data_out=%0h ", data_out,
      "wr_add=%0h ", wr_add,
      "rd_add=%0h ", rd_add,
      "write_memory=%0h ", uut.mem[wr_add],
      "read_memory=%0h ", uut.mem[rd_add]
    );
    #90 $finish;
  end

endmodule
