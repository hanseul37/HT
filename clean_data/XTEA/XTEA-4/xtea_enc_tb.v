module tb;
reg clock, reset, start,enc_dec, ready, busy;
wire ready;
reg [127:0] data_in, key;
wire [127:0] data_out;

always begin
    clock = 0;
    forever begin
        #5 clock = ~clock;
    end
end

initial begin
    reset = 1;
    start = 0;
    data_in = 0;
    key = 128'hDEADBEEF89ABCDEF01234567DEADBEEF;
    #10 reset = 0;
    data_in = 128'h5A5A5A5AFEDCBA9801234567A5A5A5A5;
    #10 start = 1;
    #10 start = 0;
    #10 enc_dec = 1;
end
always begin
    if(reset) begin
        data_in <= 0;
        key <= 0;
        start <= 0;
    end else begin
        data_in <= data_in + 1;
        key <= key + 1;
        start <= 1;
    end
end
xtea uut (
    .clock(clock),
    .reset(reset),
    .data_in(data_in),
    .key(key),
    .start(start),
    .ready(ready),
    .enc_dec(enc_dec),
    .data_out(data_out)
);
endmodule