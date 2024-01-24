`timescale 1ns/1ns

module  tb_rx();

reg clk,rstn,rx;
wire     [7:0]   rx_data;
wire             flag;


initial begin
    clk = 1;
    rstn <= 1'b0;
    rx <= 1'b1;
    #20
    rstn <= 1'b1;
 
end

initial begin
    #200
    rx_0(8'd0);
    rx_0(8'd1);
    rx_0(8'd2);
    rx_0(8'd3);
    rx_0(8'd4);
    rx_0(8'd5);
    rx_0(8'd6);
    rx_0(8'd7);
end


task    rx_0
(
    input [7:0]rx_da
);

    integer i;

    for(i = 0;i < 10;i = i + 1)begin
        case(i)
            0:rx <= 1'b0;
            1:rx <= rx_da[0];
            2:rx <= rx_da[1];
            3:rx <= rx_da[2];

            4:rx <= rx_da[3];
            5:rx <= rx_da[4];
            6:rx <= rx_da[5];
            7:rx <= rx_da[6];
            8:rx <= rx_da[7];
            9:rx <= 1'b1;
        default :rx<= 1'b1;
    
        endcase
        #(5208*20);
    end
endtask


always#10 clk = ~clk;

rx
#(   .MAX_CNT(5208)) 
rx_2
(
        .clk(clk),
        .rstn(rstn),
        .rx(rx),

        .rx_data(rx_data),
        .out_flag(flag)
);
endmodule