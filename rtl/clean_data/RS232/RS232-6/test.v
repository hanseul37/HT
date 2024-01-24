module test(
    input               clk,
    input       wire    rstn,
    
    input      [2:0]   out
);
reg     [2:0]   out_1;
reg     [2:0]   out_2;


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        begin
            out_1 = 0;
            out_2 = out_1;
        end
    else    
        begin
            out_1 = out;
            out_2 = out_1;
        end
end



endmodule