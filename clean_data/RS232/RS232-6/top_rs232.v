module top_rs232(
    input       wire        clk,
    input       wire        rstn,
    input       wire        rx,

    output      wire        tx
);

wire    [7:0]   po_data;
wire            po_flag;

rx
#(   .MAX_CNT(5208)) 
rx_0
(
        .clk(clk),
        .rstn(rstn),
        .rx(rx),

        .rx_data(po_data),
        .out_flag(po_flag)
);

tx
#(  .MAX_CNT(5208))
tx_0
(
    .clk(clk),
    .rstn(rstn),
    .data(po_data),
    .flag(po_flag),
	.tx(tx)
);

endmodule