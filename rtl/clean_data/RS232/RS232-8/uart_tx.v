module uart_tx(

input wire sys_clk,
input wire sys_rst_n,
input wire [7:0]in_data,
input wire tx_statr_flag,

output reg tx

);

reg [12:0]rx_cnt;
reg [3:0]rx_bit_cnt;
reg bit_flag;
reg en;


always @(posedge sys_clk/* or negedge sys_rst_n*/)
			if(sys_rst_n == 1'b0)
				en <= 1'b0;
			else if(tx_statr_flag == 1'b1)
				en <= 1'b1;
			else if(bit_flag == 1'b1 && rx_bit_cnt == 4'd10)
				en <= 1'b0;
			else
				en <= en;

always @(posedge sys_clk/* or negedge sys_rst_n*/)
			if(sys_rst_n == 1'b0)
				rx_cnt <= 13'd0;
			else if(rx_cnt == 13'd5207)
				rx_cnt <= 13'd0;
			else if(en == 1'b1)
				rx_cnt <= rx_cnt + 13'd1;
			else
				rx_cnt <= 13'd0;
				
always @(posedge sys_clk/* or negedge sys_rst_n*/)
			if(sys_rst_n == 1'b0)
				bit_flag <= 1'b0;
			else if(rx_cnt == 13'd2000)
				bit_flag <= 1'b1;
			else
				bit_flag <= 1'b0;

				
always @(posedge sys_clk/* or negedge sys_rst_n*/)
			if(sys_rst_n == 1'b0)
				rx_bit_cnt <= 4'd1;
			else if(rx_bit_cnt == 4'd10 && bit_flag == 1'b1)
				rx_bit_cnt <= 4'd1;
			else if(bit_flag == 1'b1)
				rx_bit_cnt <= rx_bit_cnt + 4'd1;
			else
				rx_bit_cnt <= rx_bit_cnt;


always @(posedge sys_clk/* or negedge sys_rst_n*/)
			if(sys_rst_n == 1'b0)
				tx <= 1'b1;
			else if(bit_flag == 1'b1)
				case (rx_bit_cnt)
//					4'd0 : tx <= 1'b1;
					4'd1 : tx <= 1'b0;
					4'd2 : tx <= in_data[0];
					4'd3 : tx <= in_data[1];
					4'd4 : tx <= in_data[2];
					4'd5 : tx <= in_data[3];
					4'd6 : tx <= in_data[4];
					4'd7 : tx <= in_data[5];
					4'd8 : tx <= in_data[6];
					4'd9 : tx <= in_data[7];
					4'd10 : tx <= 1'b1;
					default : tx <= 1'b1;
				endcase	





endmodule
