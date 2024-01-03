`timescale 1ns/1ns
module tb_main;
    parameter reg_width = 8;
    parameter counter_width = $clog2(reg_width);
  // Inputs
  reg rstn = 1'b0;
    reg sys_clk = 1'b0;
    reg t_start = 1'b0;
    reg [reg_width-1:0] d_in_m = 8'h00;
    reg [reg_width-1:0] d_in_s = 8'h00;
    reg [counter_width:0] t_size = 3'b001;

    // Outputs
    wire miso = 1'b0;
    wire mosi = 1'b0;
    wire[7:0] d_out_m;
    wire[7:0] d_out_s;
  // Instantiate the Unit Under Test (UUT)
  spi_main uut (
    .t_start(t_start),
    .sys_clk(sys_clk),
    .d_in_m(d_in_m),
    .d_in_s(d_in_s),
    .d_out_m(d_out_m),
    .d_out_s(d_out_s),
    .rstn(rstn),
    .miso(miso),
    .mosi(mosi)
  );

  // Generate a clock with a period of 10ns
  always #5 sys_clk = ~sys_clk;

  // Initialize inputs
  initial begin
    rstn = 1;
    t_start = 0;
    d_in_m = 0;
    d_in_s = 0;
  end

  // Reset the module
  initial begin
    #10 rstn = 0;
    #20 rstn = 1;
  end

  // Test case 1: Send data from master to slave
  initial begin
    #30 t_start = 1;
    #40 d_in_m = 8'hAB;
    #50 t_start = 0;
    #60 $display("d_out_s = %h", d_out_s);
    #70 $display("miso = %h", miso);
    #80 if (d_out_s !== 8'hAB || miso !== 8'hCD) $error("Test case 1 failed!");
  end

  // Test case 2: Send data from slave to master
  initial begin
    #90 t_start = 1;
    #100 d_in_s = 8'hCD;
    #110 t_start = 0;
    #120 $display("d_out_m = %h", d_out_m);
    #130 $display("mosi = %h", mosi);
    #140 if (d_out_m !== 8'hCD || mosi !== 1'b0) $error("Test case 2 failed!");
  end

  // Test case 3: Reset the module and verify that the outputs are zero
  initial begin
    #150 rstn = 1;
    #160 t_start = 1;
    #170 d_in_m = 8'hFF;
    #180 d_in_s = 8'hFF;
    #190 t_start = 0;
    #200 $display("d_out_m = %h", d_out_m);
    #210 $display("d_out_s = %h", d_out_s);
    #220 if (d_out_m !== 8'h00 || d_out_s !== 8'h00) $error("Test case 3 failed!");
  end

  // End simulation
  initial #500 $finish;

endmodule
