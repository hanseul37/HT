module top(clk, rst, CPOL, CPHA,
	start, miso_i, m_data_i, finish, m_data_o,
	s_data_i, miso_o, valid, s_data_o
);
	input clk;
	input rst;
	input CPOL;
	input CPHA;
	input miso_i;
	input start;
	
	input [7:0] m_data_i;
	input [7:0] s_data_i;
	
	output finish;
	output [7:0] m_data_o;
	
	output miso_o;
	output valid;
	output [7:0] s_data_o;

	reg sclk;
	reg ss;
	reg mosi;
	
	assign rst_n = ~rst;
	
	spi_master master(
		.clk(clk),
		.rst(rst),
		.datain(m_data_i),
		.start(start),
		.CPOL(CPOL),
		.CPHA(CPHA),
		.miso(miso),
		.sclk(sclk),
		.ss(ss),
		.mosi(mosi),
		.finish(finish),
		.dataout(m_data_o)
	);
	
	spi_slave slave(
		.clk(clk),
		.rst_n(rst_n),
		.datain(s_data_i),
		.CPOL(CPOL),
		.CPHA(CPHA),
		.sclk(sclk),
		.ss(ss),
		.mosi(mosi),
		.miso(miso_o),
		.data_valid(valid),
		.dataout(s_data_o)
    );

endmodule