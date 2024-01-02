`timescale 1ns / 1ps

module receiver(clk,rx,ready,data,rst
    );
input rx;
input rst;  
input clk; //100 MHZ clock
output reg ready; //ready signal synchronized with clock signal indicating that data is ready to be read
output [7:0] data; //8-bit parallel data
reg [7:0] data_r; 

reg [3:0] counter;
reg [8:0] cnt; 
reg [1:0] state=2'd0;
assign data = data_r[7:0];
reg tick = 0;
reg k = 1;

always@(posedge clk) //generating tick to sample data coming at 115200bps
begin
if(ready == 1)
		begin cnt <= 0; k<=0; end
else		
	if(cnt == 433) 
		begin
		cnt <= 0;
		tick <= 1 & k;
		k <= !k;
		end
	else
		begin
		cnt <= cnt + 1;
		tick <= 0;
		end
end

always@(posedge clk) //receiver
begin
	case(state)
	0: if(rx==0 && rst==1) state <= 1;
	1: if (tick==1) state <= 2;
	2: if(counter == 7 && tick==1) state <= 3;
	3: if (tick==1) state <= 0;

	endcase
end


always@(posedge clk)
begin
case(state)
0:	begin
	
		ready <= 0;
		counter <= 0;
	end
 
1: if(tick==1)	
		begin
		ready <= 0;
		counter <= 0;
		end

2:	if (tick==1)
	begin
		counter <= counter + 1;
		data_r[counter] <= rx;
		ready <= 0;
	end
3: 	if(tick==1) ready <= 1;
endcase
end
endmodule
