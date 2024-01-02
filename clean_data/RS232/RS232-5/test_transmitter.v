`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:23:43 06/17/2022
// Design Name:   transmitter
// Module Name:   C:/Users/Adnan/OneDrive/Documents/Serial/serial/test_transmitter.v
// Project Name:  serial
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: transmitter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_transmitter;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] data_in;
	reg tx_start;

	// Outputs
	wire tx;
	wire busy;

	// Instantiate the Unit Under Test (UUT)
	transmitter uut (
		.tx(tx), 
		.clk(clk), 
		.rst(rst), 
		.data_in(data_in), 
		.busy(busy), 
		.tx_start(tx_start)
	);

	initial begin
	
	clk = 0;
	forever
		#5 clk = !clk;
	
	
	end

	initial begin
		// Initialize Inputs
		
		rst = 0;
		data_in = 0;
		tx_start = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		data_in = 8'b10101010;
		tx_start = 1;
		rst = 1;
		
      
		// Add stimulus here

	end
      
endmodule

