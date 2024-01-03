`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 05:14:30 PM
// Design Name: 
// Module Name: horizontal_counter
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


module horizontal_counter(
    input clk_25MHz,
    output reg enable_V = 0,
    output reg [15:0] H_Count = 0
    );
    
    always@(posedge clk_25MHz)
    begin
        if (H_Count < 799) begin //if max value is reached
        H_Count <= H_Count +1; // add one to horizontal counter
        enable_V <=0; //turn off vertical counter
        end
        else begin
            H_Count <= 0;
            enable_V <= 1;
        end
    end
endmodule
