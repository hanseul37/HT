module sram(input clk,wr,rd,rst,input [1:0]addr);
reg [15:0] mem[3:0]; 
reg [15:0] data; 
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
        mem[addr]=data;
    end
    else if(!wr && rd) 
    begin
        data=mem[addr];
    end
end
endmodule
