module dualport_sram(input clk,wr,rd,
                    input [31:0] din, 
                    input [2:0] addr,
                    output reg [31:0] dout
);

reg [31:0] mem [7:0]; 
always @(posedge clk) 
begin
   if(wr && !rd)
   mem[addr]=din;
   else if(!wr && rd)
   dout=mem[addr]; 
   else
   begin
   dout=dout;
   mem[addr]=mem[addr];
   end
end
endmodule
