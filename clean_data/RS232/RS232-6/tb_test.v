`timescale 1ns/1ns

module  tb_test();

reg clk,rstn;
reg [2:0] out;


initial begin
    clk = 1;
    rstn <= 1'b0;
    out <= 0;
    #20
    rstn <= 1'b1;
    out <= 8'd1;
    #100
    out <= 8'd2;
end

always#10 clk =~clk;

test test_0
(
    .clk(clk),
    .rstn(rstn),
    .out(out)
);
endmodule