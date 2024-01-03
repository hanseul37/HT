module sdram_ctl(
    input reset_n,
    input clk_sdram,
    input reg [21:0] addr,
    output reg [15:0] data,

    output sdram_cke,
    output sdram_cs_n,
    output sdram_ras_n,
    output sdram_cas_n,
    output sdram_we_n,
    inout [15:0] sdram_dq,
    output sdram_dqmu,
    output sdram_dqml,
    output reg [11:0] sdram_a,
    output reg [1:0] sdram_ba
);

localparam [2:0] CMD_NOP = 3'b111;
localparam [2:0] CMD_BST = 3'b110;
localparam [2:0] CMD_RD  = 3'b101;
localparam [2:0] CMD_WR  = 3'b100;
localparam [2:0] CMD_ACT = 3'b011;
localparam [2:0] CMD_PRE = 3'b010;
localparam [2:0] CMD_MRS = 3'b000;

reg [2:0] cmd = CMD_NOP;
assign {sdram_ras_n, sdram_cas_n, sdram_we_n} = cmd;

reg [4:0] step = 0;

reg [15:0] read_buffer[0:7];

// 2 2 1 1 1 1 1 1 1 1 1 1
//  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  B B R R R R R R R R R R R R C C C C C C C C

always @(negedge clk_sdram) begin
    case (step)
        0: begin
            cmd <= CMD_PRE;
            sdram_ba <= {1'b0, addr[18]};
            sdram_a <= 0;
        end

        2: begin
            cmd <= CMD_ACT;
            sdram_a <= addr[19:8];
        end

        4: begin
            cmd <= CMD_RD;
            sdram_a <= {4'b0000, addr[7:0]};
        end

        15: begin
            cmd <= CMD_PRE;
            sdram_ba <= {1'b0, addr[18]};
            sdram_a <= 0;
        end

        17: begin
            cmd <= CMD_ACT;
            sdram_a <= addr[19:8];
        end

        19: begin
            cmd <= CMD_WR;
            sdram_a <= {4'b0000, addr[7:0]};
        end

        default: begin
            cmd <= CMD_NOP;
        end
    endcase
end

always @(posedge clk_sdram) begin
    case (step)
         8: read_buffer[0] <= sdram_dq;
         9: read_buffer[1] <= sdram_dq;
        10: read_buffer[2] <= sdram_dq;
        11: read_buffer[3] <= sdram_dq;
        12: read_buffer[4] <= sdram_dq;
        13: read_buffer[5] <= sdram_dq;
        14: read_buffer[6] <= sdram_dq;
        15: read_buffer[7] <= sdram_dq;
    endcase

    if (step == 31)
        step <= 0;
    else
        step <= step + 1;
end

endmodule
