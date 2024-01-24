`timescale 1ns / 1ps
module spi_main(input t_start, input sys_clk, input [7:0]d_in_m, input [7:0]d_in_s, output[7:0] d_out_m, output[7:0] d_out_s, input rstn, output miso, output mosi);
wire spi_clk_m;
wire spi_clk_s;
wire cs;
spi_master master(.sys_clk(sys_clk), .rstn(rstn), .t_start(t_start),.d_in_m(d_in_m), .t_size(8), .d_out_m(d_out_m), .miso(miso), .mosi(mosi), .spi_clk(spi_clk_m), .cs(cs));
spi_slave slave(.slave_clk(sys_clk),.spi_clk(spi_clk_s),.rstn(~cs), .t_start(t_start), .d_in_s(d_in_s), .d_out_s(d_out_s), .t_size(8), .mosi(mosi), .miso(miso));
endmodule
