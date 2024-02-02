module tb_syn_ram ();
parameter RAM_WIDTH = 8;
parameter RAM_DEPTH = 16;
parameter ADDR_SIZE = 4;

reg clk,reset,read,write;
reg [ADDR_SIZE-1:0] rd_addr,wr_addr;
reg [RAM_WIDTH-1:0] data_in;
wire [RAM_WIDTH-1:0] data_out;
integer i;

syn_ram DUT ( clk,read,write,reset,rd_addr,wr_addr,data_in,data_out);

always 
begin
clk = 0;
forever #10 clk = ~clk;
end

task reset_t;
begin
@(negedge clk);
reset = 1'b1;
@(negedge clk);
reset = 1'b0;
end
endtask

task write_t(input [7:0]a, input [3:0]b, input w,r);
begin
@(negedge clk);
write = w;
read = r;
data_in = a;
wr_addr = b;
end
endtask

task read_t(input [3:0]a, input w,r);
begin
@(negedge clk);
write = w;
read = r;
rd_addr = a;
end
endtask

initial
begin
reset_t;
repeat(10)
write_t({$random}%256,{$random}%16,1'b1,1'b0);
repeat(10)
read_t({$random}%16,1'b0,1'b1);
#100 $finish;
end
endmodule
