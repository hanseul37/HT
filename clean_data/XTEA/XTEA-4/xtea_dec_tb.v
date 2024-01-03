module tb;
reg clock, reset, start;
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
    data_in = 128'h4D932AB3CE76E4F22555F334089975E9;
    #10 start = 1;
    #10 start = 0;
    

end

xtea_dec uut (
    .clock(clock),
    .reset(reset),
    .data_in(data_in),
    .key(key),
    .start(start),
    .ready(ready),
    .data_out(data_out)
);
endmodule