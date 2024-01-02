module uart_rx(

input wire sys_clk,
input wire sys_rst_n,
input wire rx,

output reg [7:0]out_data,
output reg out_flag

);

reg rx1;
reg rx2;
reg rx3;
wire rx_start_flag;
reg rx_en;
reg [12:0]rx_baud_cnt;
reg rx_bit_flag;
reg [3:0]rx_bit_cnt;
reg [7:0]data;
reg rx_end_flag;





always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx1 <= 1'b0;
			else
				rx1 <= rx;
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx2 <= 1'b0;
			else
				rx2 <= rx1;
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx3 <= 1'b0;
			else
				rx3 <= rx2;

assign rx_start_flag = ~rx2 & rx3;


always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx_en <= 1'b0;
			else if(rx_start_flag == 1'b1)
				rx_en <= 1'b1;
			else if(rx_bit_cnt == 4'd9 && rx_bit_flag == 1'b1)
				rx_en <= 1'b0;
			else
				rx_en <= rx_en;

always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx_baud_cnt <= 13'd0;
			else if(rx_baud_cnt == 13'd5207)
				rx_baud_cnt <= 13'd0;
			else if(rx_en == 1'b1)
				rx_baud_cnt <= rx_baud_cnt + 13'd1;
			else
				rx_baud_cnt <= 13'd0;
			
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx_bit_flag <= 1'b0;
			else if(rx_baud_cnt == 13'd1000)
				rx_bit_flag <= 1'b1;
			else 
				rx_bit_flag <= 1'b0;

always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				rx_bit_cnt <= 4'd0;
			else if(rx_bit_cnt == 4'd9 && rx_bit_flag == 1'b1)
				rx_bit_cnt <= 4'd0;
			else if(rx_bit_flag == 1'b1)
				rx_bit_cnt <= rx_bit_cnt + 4'd1;
			else
				rx_bit_cnt <= rx_bit_cnt;

				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				data <= 8'd0;
			else if((rx_bit_cnt >= 4'd1 && rx_bit_cnt <= 4'd8) && rx_bit_flag == 1'b1)
				data <= {rx3,data[7:1]};
				
				
			
				
			
			
			
	
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)	
				rx_end_flag <= 1'b0;
			else if(rx_bit_cnt == 4'd9 && rx_bit_flag == 1'b1)
				rx_end_flag <= 1'b1;
			else
				rx_end_flag <= 1'b0;
			
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				out_data <= 8'd0;
			else if(rx_end_flag == 1'b1)
				out_data <= data;
			else
				out_data <= out_data;
			
			
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				out_flag <= 1'b0;
			else if(rx_end_flag == 1'b1)
				out_flag <= 1'b1;
			else
				out_flag <= 1'b0;

endmodule
