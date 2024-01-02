module rx
#(  parameter  MAX_CNT = 5000)
(
    input       wire        clk,
    input       wire        rstn,
    input       wire        rx,

    output      reg    [7:0]rx_data,
    output      reg         out_flag
);

reg        d_flip_0;
reg        d_flip_1;
reg      d_flip_2;

reg             start_flag;
reg             fin_flag;
reg             start_en;
reg     [20:0]   bit_cnt;
reg     [4:0]   cnt;
reg             bit_flag;
reg     [7:0]   d_rx_data;




always @(posedge clk or negedge rstn) begin
    if(!rstn)
        begin
          d_flip_0 <= 0;
          d_flip_1 <= 0;
          d_flip_2 <= 0;
        end
    else
        begin
          d_flip_0 <= rx;
          d_flip_1 <= d_flip_0;
          d_flip_2 <= d_flip_1;
        end
end
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        start_flag <= 0;
    else if(d_flip_1 == 1'b0 && d_flip_2 == 1'b1)
        start_flag <= 1'b1;
    else
        start_flag <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        start_en <= 1'b0;
    else if(cnt == 4'd8 && bit_flag == 1'b1)
        start_en <= 1'b0;
    else if(start_flag == 1'b1)
        start_en <= 1'b1;
    else
        start_en <= start_en;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_cnt <= 0;
    else if(bit_cnt == (MAX_CNT - 1) || (bit_flag == 1'b1 && cnt == 4'd9))
        bit_cnt <= 0;
    else if(start_en == 1'b1)
        bit_cnt <= bit_cnt + 1'b1;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        bit_flag <= 1'b0;
    else if(bit_cnt == (MAX_CNT - 1)/2)
        bit_flag <= 1'b1;
    else 
        bit_flag <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <= 0;
    else if(cnt == 4'd8 && bit_flag == 1'b1)
        cnt <= 0;
    else if(bit_flag == 1'b1)
        cnt <= cnt + 1'b1;
    else
        cnt <= cnt;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        d_rx_data <= 0;
    else if((bit_flag == 1'b1)  && (cnt >= 3'd1) && (cnt <= 4'd8))
        d_rx_data <= {d_flip_2,d_rx_data[7:1]};
    else
        d_rx_data <= d_rx_data;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        fin_flag <= 1'b0;
    else if(cnt == 4'd8 && bit_flag == 1'b1)
        fin_flag <= 1'b1;
    else
        fin_flag <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        rx_data <= 0;
    else if(fin_flag == 1'b1)
        rx_data <= d_rx_data;
end
        
//assign rx_data = (fin_flag == 1'b1) ? d_rx_data : 1'b0;
//assign flag = (fin_flag == 1'b1)? 1'b1 : 1'b0 ;
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        out_flag <= 1'b0;
    else if(fin_flag == 1'b1)
        out_flag <= 1'b1;
    else
        out_flag <= 1'b0;
end
endmodule