module xtea#(parameter 
    WORD_SIZE = 128
)(
    input clock,
    input reset,
    input [(WORD_SIZE-1):0] data_in, key,
    input start, enc_dec,

    output ready, busy,
    output [(WORD_SIZE-1):0]data_out
);

wire busy_int,ready_int,ready_dec, ready_enc;
reg  start_enc, start_dec;
wire [(WORD_SIZE-1):0] data_out_enc, data_out_dec;
reg [(WORD_SIZE-1):0] data_out_int;

localparam S_WAITING = 3'B000,
        S_ENCRYPT = 3'B001,
        S_ENCRYPT_DONE = 3'B010,
        S_DECRYPT = 3'B011,
        S_DECRYPT_DONE = 3'B100;

reg [2:0] EA;

assign busy_int = (EA == S_ENCRYPT || EA == S_DECRYPT) ? 'B1 : 'B0;
assign ready_int = (EA == S_ENCRYPT_DONE || EA == S_DECRYPT_DONE) ? 'B1 : 'B0;
assign data_out = data_out_int;
assign ready = ready_int;
assign busy = busy_int;


always@(posedge clock or posedge reset) begin
    if(reset) begin
        EA <= S_WAITING;
    end else begin
        case(EA)
            S_WAITING: begin
                if(start) begin
                    if(enc_dec) begin
                        EA <= S_ENCRYPT;
                    end else begin
                        EA <= S_DECRYPT;
                    end
                end
            end
            S_ENCRYPT: begin
                if(ready_enc) begin
                    EA <= S_ENCRYPT_DONE;
                end else begin
                EA <= S_ENCRYPT;
                end
            end
            S_ENCRYPT_DONE: begin
                EA <= S_WAITING;
            end
            S_DECRYPT: begin
                if(ready_dec) begin
                    EA <= S_DECRYPT_DONE;
                end else begin
                EA <= S_DECRYPT;
                end
            end
            S_DECRYPT_DONE: begin
                EA <= S_WAITING;
            end
        endcase
    end
end

    always@(posedge clock or posedge reset) begin
        if(reset) begin
            data_out_int <= 0;
            start_dec <= 0;
            start_enc <= 0;
        end else begin
            case(EA)
                S_WAITING: begin
                    if(start) begin
                        if(enc_dec) begin
                            start_enc <= 1;
                        end else begin
                            start_dec <= 1;
                        end
                    end
                end
                S_ENCRYPT: begin
                    start_enc <= 0;
                    
                end
                S_ENCRYPT_DONE: begin
                    data_out_int <= data_out_enc;
                end
                S_DECRYPT: begin
                    start_dec <= 0;
                end
                S_DECRYPT_DONE: begin
                    start_dec <= 0;
                    data_out_int <= data_out_dec;
                end
            endcase
        end
    end
    
xtea_enc enc(
    .clock(clock),
    .reset(reset),
    .data_in(data_in),
    .key(key),
    .start(start_enc),
    .ready(ready_enc),
    .data_out(data_out_enc)
);

xtea_dec dec(
    .clock(clock),
    .reset(reset),
    .data_in(data_in),
    .key(key),
    .start(start_dec),
    .ready(ready_dec),
    .data_out(data_out_dec)
);




endmodule
