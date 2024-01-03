//Synchroous FIFO

`define data_width 8
`define fifo_depth 8
`define addr_width 16

module sync_fifo 

 (input clk,rstn,wr_en,rd_en,
  input [(`data_width-1):0] data_in,
  output fifo_empty,fifo_full,
  output reg rd_vld,
  output reg [(`data_width-1):0] data_out);
  
  reg [`addr_width:0] wr_ptr,rd_ptr;
  reg [(`data_width-1):0] mem [0:(`fifo_depth-1)];
  integer i;
  
//Write pointer logic
always @ (posedge clk, posedge rstn)
 if (rstn) begin
 wr_ptr <= 1'd0;
 for(i=0; i < `fifo_depth; i = i+1)
 mem[i] <= 1'd0;
 end
 else if ((!fifo_full) && wr_en) begin
 mem [wr_ptr[(`addr_width-1):0]] <= data_in;
 wr_ptr <= wr_ptr + 1'b1;
 end
 
//Read pointer logic
always @ (posedge clk, posedge rstn)
if (rstn) begin
 rd_ptr <= 1'd0;
 rd_vld <= 1'd0;
 data_out <= 1'd0;
 end
 else if ((!fifo_empty) && rd_en) begin
 data_out <= mem [rd_ptr[(`addr_width-1):0]];
 rd_ptr <= rd_ptr + 1'b1;
 rd_vld <= 1'b1;
 end
 else begin
 rd_vld <= 1'b0;
 data_out <= 1'b0;
 end
 
//Setting empty and full flags
assign fifo_empty = ((wr_ptr - rd_ptr) == 1'd0) ? 1'b1 : 1'b0;
assign fifo_full = ((wr_ptr - rd_ptr) == `fifo_depth) ? 1'b1 : 1'b0;

endmodule
