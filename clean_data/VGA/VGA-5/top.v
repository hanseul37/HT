`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 04:19:33 PM
// Design Name: 
// Module Name: top
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


module top(
input clk,
output Hsync,
output Vsync,
output [3:0] Red,
output [3:0] Green,
output [3:0] Blue
    );
wire clk_25M;
wire enable_V;
wire [15:0] H_Counter;
wire [15:0] V_Counter;


clock_divider VGA_Clock_gen (clk, clk_25M);
horizontal_counter VGA_Horiz (clk_25M, enable_V, H_Counter);
vertical_counter VGA_Verti (clk_25M, enable_V, V_Counter);

assign Hsynq = (H_Counter < 96) ? 1'b1 : 1'b0;
assign Vsynq = (V_Counter < 2) ? 1'b1 : 1'b0;
assign Red = (H_Counter < 784 && H_Counter > 143 && V_Counter < 515 && V_Counter > 34  ) ? 4'hF:4'h0;
assign Green = (H_Counter < 784 && H_Counter > 143 && V_Counter < 515 && V_Counter > 34  ) ? 4'hF:4'h0;
assign Blue = (H_Counter > 784 && H_Counter < 143 && V_Counter > 515 && V_Counter < 34  ) ? 4'hF:4'h0;
endmodule