`timescale 1ns/1ns
module tb_top_rs232();

reg clk,rstn,rx;

wire tx;

initial begin
    clk = 1'b1;
    rx <= 1'b0;
    rstn <= 1'b0;
    #20
    rstn <= 1'b1;
end

initial begin
    #200
    get_data();
end
always#10 clk = ~clk;

task    get_data();
    integer j;
    for(j = 0;j <= 3'd7; j = j + 1)
        input_data(j);
endtask

task input_data(
    input [7:0]data
);
    integer i;
    for(i = 0; i <= 9; i = i + 1)
    begin
        case(i)
            0 : rx <= 0;
            1 : rx <= data[0];
            2 : rx <= data[1];
            3 : rx <= data[2];

            4 : rx <= data[3];
            5 : rx <= data[4];
            6 : rx <= data[5];
            7 : rx <= data[6];
            8 : rx <= data[7]; 
            9 : rx <= 1'b1;
        endcase
        #(5208*10);
    end
endtask


top_rs232 top_rs232_0
(
    .clk(clk),
    .rstn(rstn),
    .rx(rx),
    .tx(tx)
);
endmodule