module tb;
reg clock, reset,enc_dec, start;
wire busy, ready;
reg [127:0] data_in, key, teste;
wire [127:0] data_out;
reg[3:0] count;
always begin
    clock = 0;
    forever begin
        #5 clock = ~clock;
    end
end

initial begin
    count = 0;
    reset = 1;
    start = 0;
    data_in = 0;
    enc_dec = 1;
    key = 128'hDEADBEEF89ABCDEF01234567DEADBEEF;
    #10 reset = 0;
    data_in = 128'h4D932AB3CE76E4F22555F334089975E9;
    //data_in = 128'hAAAABBBBCCCCDDDDAAAABBBBCCCCDDDD;
    #10 start = 1;
    #10 start = 0;
    #45 
    
    forever #5 data_in = data_out;
end
always@(posedge clock) begin
    if(ready == 1) begin
        enc_dec <= ~enc_dec;
        #10
        teste <= data_out;
        #10 start <= 1;
        #10 start <= 0;
        count <= count + 1;
        if(count == 4'b0111) begin
            $stop;
        end
    end
end

xtea uut (
    .clock(clock),
    .reset(reset),
    .data_in(data_in),
    .key(key),
    .start(start),
    .ready(ready),
    .busy(busy),
    .enc_dec(enc_dec),
    .data_out(data_out)
);
endmodule