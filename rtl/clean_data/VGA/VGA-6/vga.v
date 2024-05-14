module vga (
    input CLK,
    output CLK_25MHZ,
    output HS,
    output VS,
    output DRAW,
    output [9:0] PIX,
    output [9:0] LINE
);

parameter H_SYNC = 7'd96;
parameter H_BACK_PORCH = 6'd48;
parameter H_WIDTH = 10'd640;
parameter H_FRONT_PORCH = 5'd16;
parameter H_WHOLE = 10'd800;

parameter V_SYNC = 2'd2;
parameter V_BACK_PORCH = 6'd35;
parameter V_WIDTH = 9'd480;
parameter V_FRONT_PORCH = 4'd10;
parameter V_WHOLE = 10'd525;

wire [9:0] h_cnt;
wire [9:0] v_cnt;

wire next_line;
wire clk_25Mhz;

assign CLK_25MHZ = clk_25Mhz;
assign HS = h_cnt < H_SYNC;
assign VS = v_cnt < V_SYNC;

assign DRAW = (h_cnt >= H_SYNC + H_BACK_PORCH & h_cnt <= H_WHOLE - H_FRONT_PORCH) & (v_cnt >= V_SYNC + V_BACK_PORCH & v_cnt <= V_WHOLE - V_FRONT_PORCH);

assign PIX = DRAW ? h_cnt - H_SYNC - H_BACK_PORCH : 10'd0;
assign LINE = DRAW ? v_cnt - V_SYNC - V_BACK_PORCH : 10'd0;

prescaler #(
	 .MODULO(4),
	 .W(2)
)
MHz25
(
	 .CLK(CLK),
	 .CE(1'd1),
	 .CEO(clk_25MHz)
);

//96 pix H sync time + 48 pix H back porch = 144 pix + 640 video pix = 784 pix + 16 pix H front porch = 800 pix (to 799 incl. 0)
up_cnt_mod #(
    .MODULO(H_WHOLE),
    .W(10) //MUST MATCH H_WHOLE WIDTH!
)
hor_cnt
(
    .CLK(CLK),
    .CE(clk_25MHz),      
    .CLR(1'd0),
    .Q(h_cnt),
    .CO(next_line)
);


//2 rows V sync time + 33 rows V back porch = 35 pix + 480 video lines = 515 lines + 10 lines V front porch = 525 (to 524 incl. 0)
up_cnt_mod #(
    .MODULO(V_WHOLE),
    .W(10) //MUST MATCH V_WHOLE WIDTH!
)
ver_cnt
(
    .CLK(CLK),
    .CE(next_line),
    .CLR(1'd0),
    .Q(v_cnt)
);

endmodule
