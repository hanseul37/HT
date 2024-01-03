`timescale 1ns / 1ps
module spi_slave #(parameter reg_width = 4'd8,counter_width = $clog2(reg_width),reset = 0, idle = 1, load = 2, transact = 3, unload = 4)
(
 
 // System Side
    input rstn,
    input slave_clk,
    input t_start, 
    input [reg_width-1:0] d_in_s,
    input [counter_width:0] t_size,
    output reg [reg_width-1:0] d_out_s,
    output reg spi_clk,

    // SPI Side
    input mosi, 
    output reg miso);
    reg [reg_width-1:0] mosi_d;
    reg [reg_width-1:0] miso_d;
    reg [counter_width:0] count;
    reg [2:0] state;
    initial begin
   miso_d=8'd0;
   mosi_d=8'd0;
   count=3'd0;
   state=3'd0;
    end
    always @(state)
begin
    case (state)
        reset:
        begin
            d_out_s <= 0;
            miso_d <= 0;
            mosi_d <= 0;
            count <= 0;
        end
        idle:
        begin
            d_out_s <= d_out_s;
            miso_d <= 0;
            mosi_d <= 0;
            count <= 0;
        end
        load:
        begin
            d_out_s <= d_out_s;
            mosi_d <= 0;
            miso_d <= d_in_s;
            count <= t_size;
        end
        transact:
        begin
        end
        unload:
        begin
            d_out_s <= mosi_d;
//            mosi_d <= 0;
            miso_d <= 0;
            count <= count;
        end

        default:
            state = reset;
    endcase
end
always @(posedge slave_clk)
begin
    if (!rstn)
        state = reset;
    else
        case (state)
            reset:
                state = idle;
            idle:
                if (t_start)
                    state = load;
            load:
                if (count != 0)
                    state = transact;
                else
                    state = reset;
            transact:
                if (count != 0)
                    state = transact;
                else
                    state = unload;
            unload:
                if (t_start)
                    state = load;
                else
                    state = idle;
        endcase
end
always @(negedge spi_clk)
    if (rstn)
        miso <= miso_d[reg_width-1];
    else
        miso <=1'bz;
always @(posedge slave_clk or negedge slave_clk)
    if (state==transact)
        spi_clk <= slave_clk;
    else
        spi_clk <= 0;
always @(posedge spi_clk)
begin
    if ( state == transact )
        mosi_d <= {mosi_d[reg_width-2:0], mosi};
end

always @(negedge spi_clk)
begin
    if ( state == transact )
    begin
        miso_d <= {miso_d[reg_width-2:0], 1'b0};
        count <= count-1;
    end
end
endmodule
