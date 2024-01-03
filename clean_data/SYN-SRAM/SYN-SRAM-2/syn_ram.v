module syn_ram (clk,read,write,reset,rd_addr,wr_addr,data_in,data_out);
parameter RAM_WIDTH = 8;
parameter RAM_DEPTH = 16;
parameter ADDR_SIZE = 4;

input clk,reset,read,write;
input [ADDR_SIZE-1:0] rd_addr,wr_addr;
input [RAM_WIDTH-1:0] data_in;
output reg [RAM_WIDTH-1:0] data_out;
integer i;

reg [RAM_WIDTH-1:0] mem [RAM_DEPTH-1:0];

always @(posedge clk)
begin
if (reset)
begin
data_out <= 0;
for (i=0;i<RAM_DEPTH;i=i+1)
mem[i] <= 0;
end
else
begin
if (write)
mem[wr_addr] <= data_in;
if (read)
data_out <= mem[rd_addr];
end
end
endmodule
