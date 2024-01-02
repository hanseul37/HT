`timescale 1ns/1ns
module tb_tx();

reg    clk,rstn,flag;
reg    [7:0]   data;
wire tx;

initial
begin
    clk = 1'b1;
    rstn <= 1'b0;
    #20
    rstn <= 1'b1;
end

initial begin
        data <= 8'b0;
        flag <= 1'b0;
        #200
        //发送数据0
        data <= 8'd0;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
//每发送1bit数据需要5208个时钟周期，一帧数据为10bit
//所以需要数据延时(5208*20*10)后再产生下一个数据
        #(5208*20*10);
        //发送数据1
        data <= 8'd1;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据2
        data <= 8'd2;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据3
        data <= 8'd3;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据4
        data <= 8'd4;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据5
        data <= 8'd5;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据6
        data <= 8'd6;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
        #(5208*20*10);
        //发送数据7
        data <= 8'd7;
        flag <= 1'b1;
        #20
        flag <= 1'b0;
end

always#10 clk = ~clk;

tx
#(  .MAX_CNT(5208))
tx_2
(
    .clk(clk),
    .rstn(rstn),
    .data(data),
    .flag(flag),
	.tx(tx)
);

endmodule