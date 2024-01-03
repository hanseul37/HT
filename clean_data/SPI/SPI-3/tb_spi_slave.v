`timescale 1ns / 1ps
module tb_spi_slave;

    // Parameters
    parameter reg_width = 8;
    parameter counter_width = $clog2(reg_width);
    parameter reset = 0;
    parameter idle = 1;
    parameter load = 2;
    parameter transact = 3;
    parameter unload = 4;

    // Inputs
    reg rstn = 1'b0;
    reg slave_clk = 1'b0;
    reg t_start = 1'b0;
    reg [reg_width-1:0] d_in_s = 8'h00;
    reg [counter_width:0] t_size = 4'd0;

    // Outputs
    wire [reg_width-1:0] d_out_s;
    wire miso = 1'b0;
    reg mosi = 1'b0;
    wire spi_clk = 1'b0;

    // Instantiate the SPI module
    spi_slave #(.reg_width(reg_width), .counter_width(counter_width)) dut (
        .rstn(rstn),
        .slave_clk(slave_clk),
        .t_start(t_start),
        .d_in_s(d_in_s),
        .t_size_s(t_size_s),
        .d_out_s(d_out_s),
        .miso(miso),
        .mosi(mosi),
        .spi_clk(spi_clk)
    );

    // Clock generator
    always #5 slave_clk = ~slave_clk;

    // Reset generator
    initial begin
        rstn = 0;
        #10 rstn = 1;
    end
    

    // Test sequence
    initial begin
        // Wait for reset to complete
        t_size=4'd8;
        // Wait for reset to complete
        #20;

        // Load data
        d_in_s = 8'h55;
        t_start = 1;
        #10 t_start = 0;

        // Wait for transaction to complete
        #50;

        // Unload data
        t_start = 1;
        #10 t_start = 0;

        // Wait for unload to complete
        #20;

        // Load data again
        d_in_s = 8'hAA;
        t_start = 1;
        #10 t_start = 0;

        // Wait for transaction to complete
        #70;

        // Unload data again
        t_start = 1;
        #10 t_start = 0;

        // Wait for unload to complete
        #40;

        // End of test
        $finish;
    end
endmodule
