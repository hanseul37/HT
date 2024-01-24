`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 04:32:11 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;
reg clk = 0;
wire Hsync;
wire Vsync;
wire [3:0] Red;
wire [3:0] Green;
wire [3:0] Blue;

top UUT(clk, Hsync, Vsync, Red, Green, Blue );

always #5 clk = ~clk;

endmodule
