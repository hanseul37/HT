`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 05:15:21 PM
// Design Name: 
// Module Name: vertical_counter
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


module vertical_counter(
    input clk_25MHz,
    input enable_V,
    output reg [15:0] V_Count = 0
    );
    
    always@(posedge clk_25MHz) begin
    if(enable_V == 1) begin
        if (V_Count < 524)
        V_Count <= V_Count +1;
        else V_Count <= 0;
        end
     end
endmodule
