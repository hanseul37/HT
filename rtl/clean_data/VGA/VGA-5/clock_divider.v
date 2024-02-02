`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 04:25:00 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #(parameter max = 1)(
input wire clk,
output reg divided_clk =0
    );

integer counter_value = 0;
always@ (posedge clk)
begin
    if(counter_value == max) //if max value then reset
        counter_value <= 0; //reset counter
    else
        counter_value <= counter_value+1; //else add one to the counter
end

//divide clock
always@ (posedge clk)
begin
    if(counter_value == max) //if max value is reached
        divided_clk <= ~divided_clk; //pulse for one clock cycle
    else
        divided_clk <= divided_clk; //no pulse
end        
endmodule
