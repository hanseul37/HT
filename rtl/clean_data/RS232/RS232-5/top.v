`timescale 1ns / 1ps
module top(clk, rst, rx, rx_ready, tx_start, tx, busy);
	input rx;
	input rst;
	input clk; //100 MHZ clock
	output rx_ready; //ready signal synchronized with clock signal indicating that data is ready to be read
	
	input tx_start;
	output tx;
	output busy;
	
	reg [7:0] data; //8-bit parallel data

	receiver recv(
		.clk(clk),
		.rx(rx),
		.ready(rx_ready),
		.data(data),
		.rst(rst)
    );
	
	transmitter trans(
		.tx(tx),
		.clk(clk),
		.rst(rst),
		.data_in(data),
		.busy(busy),
		.tx_start(tx_start)
    );
endmodule