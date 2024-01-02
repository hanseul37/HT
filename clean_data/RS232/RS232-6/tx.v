module tx
#(  parameter MAX_CNT = 101)
(
    input   wire        clk,
    input   wire        rstn,
    input   wire [7:0]  data,

    input   wire        flag,
    output  reg    tx

);

reg         start_en;
reg [20:0]  bit_cnt;
reg         bit_flag;
reg [4:0]   cnt;


always @(posedge clk or negedge rstn) begin
    if(!rstn)
        start_en <= 1'b0;
    else if(bit_flag == 1'b1 && cnt == 4'd9)
        start_en <= 1'b0;
    else if(flag == 1'b1)
        start_en <= 1'b1;
    else
        start_en <= start_en; 
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_cnt <= 1'b0;
    else if((bit_cnt == (MAX_CNT - 1)) || start_en == 1'b0)
        bit_cnt <= 1'b0;
    else if(start_en == 1'b1)
        bit_cnt <= bit_cnt + 1'b1;
    else
        bit_cnt <= 1'b0;

end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_flag <= 1'b0;
    else if(bit_cnt == (MAX_CNT - 1) / 2)
        bit_flag <= 1'b1;
    else
        bit_flag <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <= 0;
    else if(cnt == 4'd9 && bit_flag == 1'b1)
        cnt <= 0;
    else if(bit_flag == 1'b1)
        cnt <= cnt + 1'b1;
    else 
        cnt <= cnt;
end
 
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        tx <= 1'b1;
    else if(bit_flag == 1'b1)
        case(cnt)
            0 : tx <= 1'b0;
            1 : tx <= data[0];
            2 : tx <= data[1];
            3 : tx <= data[2];
            4 : tx <= data[3];

            5 : tx <= data[4];
            6 : tx <= data[5];
            7 : tx <= data[6];
            8 : tx <= data[7];
            9 : tx <= 1'b1;
        default : tx <= 1'b1;
        endcase
end
endmodule