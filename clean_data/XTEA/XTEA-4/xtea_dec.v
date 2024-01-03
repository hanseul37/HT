module xtea_dec#(parameter 
    WORD_SIZE = 128
)(
    input clock,
    input reset,
    input [(WORD_SIZE-1):0] data_in, key,
    input start,

    output ready,
    output [(WORD_SIZE-1):0]data_out
);

localparam  S_WAITING = 3'B000,
        S_DEC_PHASE_1 = 3'B001,
            S_ENC_SUM = 3'B010,
        S_DEC_PHASE_2 = 3'B011,
              S_READY = 3'B100;

reg ready_int, dec_done;
reg [2:0] EA;
reg [6:0] count;
reg [(WORD_SIZE-1):0]data_out_int;
reg [(WORD_SIZE-1):0]data_decrypted;
reg [(WORD_SIZE-1):0]key_int;
wire [(WORD_SIZE/4-1):0]key_word;

reg [31:0] sum, delta;
wire [31:0]y0,z0,y1,z1,k0,k1,k2,k3;
assign ready = ready_int;
assign k3 = key_int[31:0];
assign k2 = key_int[63:32];
assign k1 = key_int[95:64];
assign k0 = key_int[127:96];
assign y0 = data_decrypted[127:96];
assign z0 = data_decrypted[95:64];
assign y1 = data_decrypted[63:32];
assign z1 = data_decrypted[31:0];

assign key_word =  (sum[1:0]==2'b00) && EA == S_DEC_PHASE_2 ? k0:
                   (sum[1:0]==2'b01) && EA == S_DEC_PHASE_2 ? k1:
                   (sum[1:0]==2'b10) && EA == S_DEC_PHASE_2 ? k2:
                   (sum[1:0]==2'b11) && EA == S_DEC_PHASE_2 ? k3:
                   ((sum>>11 & 2'b11)==2'b00) && EA == S_DEC_PHASE_1 ? k0:
                   ((sum>>11 & 2'b11)==2'b01) && EA == S_DEC_PHASE_1 ? k1:
                   ((sum>>11 & 2'b11)==2'B10) && EA == S_DEC_PHASE_1 ? k2:
                   ((sum>>11 & 2'b11)==2'b11) && EA == S_DEC_PHASE_1 ? k3: 0;





always @(posedge clock or posedge reset) begin
    if (reset) begin
        EA <= S_WAITING;
    end else begin
        case (EA)
            S_WAITING: begin
                ready_int <= 0;
                dec_done <= 0;
                if (start) begin
                    EA <= S_DEC_PHASE_1;
                end else begin
                    EA <= S_WAITING;
                end
            end
            S_DEC_PHASE_1: begin                
                EA <= S_ENC_SUM;
            end
            S_ENC_SUM: begin
                EA <= S_DEC_PHASE_2;
            end
            S_DEC_PHASE_2: begin
                if (dec_done) begin
                    EA <= S_READY;
                end else begin
                    EA <= S_DEC_PHASE_1;
                end
            end
            S_READY: begin
                EA <= S_WAITING;
            end
        endcase
    end
end

always @(posedge clock or posedge reset) begin
    if (reset) begin
        count <= 0;
        data_out_int <= 0;
        sum <= 32'hC6EF3720;
        delta <= 32'h9E3779B9;
        ready_int <= 0;
        dec_done <= 0;
    end else begin
        case (EA)
            S_WAITING: begin
                data_decrypted <= data_in;
                key_int <= key;
                sum <= 32'hC6EF3720;
                count <= 0;
            end
            S_DEC_PHASE_1: begin
                count <= count + 1;

                data_decrypted[95:64]  <= z0- ((((y0 << 4) ^ (y0 >> 5)) + y0) ^ (sum + key_word));
                data_decrypted[31:0] <= z1- ((((y1 << 4) ^ (y1 >> 5)) + y1) ^ (sum + key_word));
                
            end
            S_ENC_SUM: begin
                sum <= sum - delta;   
            end
            S_DEC_PHASE_2: begin
                 data_decrypted[127:96] <= y0- ((((z0 << 4) ^ (z0 >> 5)) + z0) ^ (sum + key_word));
                data_decrypted[63:32]  <= y1- ((((z1 << 4) ^ (z1 >> 5)) + z1) ^ (sum + key_word));
                if(count == 31) begin
                    count <= 0;
                    dec_done <= 1;
                end
                 
                
            end
            S_READY: begin
                data_out_int <= data_decrypted;
                ready_int <= 1;
            end
        endcase
    end
end


//assign valor0 = EA == S_DEC_PHASE_2 ?  : EA == S_DEC_PHASE_2 ? : 0;
//assign valor1 = EA == S_DEC_PHASE_2 ?  : EA == S_DEC_PHASE_2 ?  : 0;

assign data_out = data_out_int;


endmodule