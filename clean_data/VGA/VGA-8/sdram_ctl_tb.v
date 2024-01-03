`timescale 10ns/1ns

module sdram_ctl_tb();

reg clk_sdram = 0;
wire sdram_ras_n;
wire sdram_cas_n;
wire sdram_we_n;
wire [11:0] sdram_a;
wire [1:0] sdram_ba;
wire [15:0] sdram_dq;
reg [15:0] data;
wire [2:0] cmd;
wire [4:0] step;

sdram_ctl sdram_ctl(
    .clk_sdram(clk_sdram),
    .sdram_ras_n(sdram_ras_n),
    .sdram_cas_n(sdram_cas_n),
    .sdram_we_n(sdram_we_n),
    .sdram_a(sdram_a),
    .sdram_ba(sdram_ba),
    .addr(22'b0),
    .sdram_dq(sdram_dq)
);

assign cmd = sdram_ctl.cmd;
assign sdram_dq = data;
assign step = sdram_ctl.step;

always
    #5 clk_sdram = ~clk_sdram;

initial
begin
    #80
    data <= 16'h0123;

    #10
    data <= 16'h1234;

    #10
    data <= 16'h2345;

    #10
    data <= 16'h3456;

    #10
    data <= 16'h4567;

    #10
    data <= 16'h5678;

    #10
    data <= 16'h6789;

    #10
    data <= 16'h7890;

    #50
    data <= 16'h0123;

    #10
    data <= 16'h1234;

    #10
    data <= 16'h2345;

    #10
    data <= 16'h3456;

    #10
    data <= 16'h4567;

    #10
    data <= 16'h5678;

    #10
    data <= 16'h6789;

    #10
    data <= 16'h7890;

end

endmodule
