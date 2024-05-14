`timescale 1ns / 1ps
module top(sys_clk, sys_rst_n, rx, tx);
	input sys_clk;
	input sys_rst_n;
	input rx;
  output tx;
	
	reg [7:0] data;
	reg flag;
	
	uart_rx u_rx(
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.rx(rx),
		.out_data(data),
		.out_flag(flag)
	);

	uart_tx u_tx(
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.in_data(data),
		.tx_statr_flag(flag),
		.tx(tx)
	);
endmodule
