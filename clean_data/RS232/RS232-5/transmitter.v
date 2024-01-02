`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:09 06/16/2022 
// Design Name: 
// Module Name:    transmitter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module transmitter(tx,clk,rst,data_in,busy,tx_start
    );


output reg tx=1,busy=0;
input clk,rst,tx_start;
input [7:0] data_in;

reg [3:0] counter;
wire [9:0] data ;
assign data= {1'b1,data_in,1'b0};
reg state = 0;
reg [9:0] cnt;
reg k=0,start=0;
reg tick=0;

always@(posedge clk) //Making tx_start edge triggered
begin
	if(k == 0 && tx_start==1)
		begin start <= 1; k <= 1; end
	else if(tx_start == 0 && k==1)
		begin k <= 0; start <= 0; end
	else
		start <= 0;
end


always@(posedge clk) //baud rate generation 115200 bps using 100Mhz clock
begin	
	if(cnt == 867) //867
		begin
		cnt <= 0;
		tick <= 1;
		end	
	else
		begin
		cnt <= cnt + 1;
		tick <= 0;
		end
end


always@(posedge clk) //transmitter
begin
case(state)
1'd0: if(start == 1) state <= 1;
1'd1: if(counter == 10) state <= 0;
endcase
end

always@(posedge clk)
begin
if(tick==1)
case(state)
0:	begin
		tx <= 1;
		busy <= 0;
		counter <= 0;
	end
1:
	begin
		counter <= counter + 1;
		tx <= data[counter];
		busy <= 1;
	end
endcase
end
endmodule
