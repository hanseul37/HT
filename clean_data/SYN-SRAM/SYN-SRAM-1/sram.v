module sram(input clk,wr,rd,rst,input [1:0]addr,
input [15:0] idata,
output reg [15:0] odata);
reg [15:0] mem[3:0]; 
integer i; 
always@(posedge clk)
begin
    
    if(rst)
    for(i=0;i<=3;i=i+1)
    begin
        mem[i]=0;
    end
    else if(wr && !rd)
    begin
        mem[addr]=idata;
    end
    else if(!wr && rd) 
    begin
        odata=mem[addr];
    end
end
endmodule