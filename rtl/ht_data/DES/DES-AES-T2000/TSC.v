`timescale 1ns / 1ps

module TSC(
    input clk,
    input rst,
	input [55:0] key,
	input Tj_Trig
    );

	 reg [55:0] SECRETKey;
	 reg [127:0] COUNTER;
	 reg LEAKBit;	 
	 wire INV1_out, INV2_out, INV3_out, INV4_out, INV5_out, INV6_out, INV7_out, INV8_out, INV9_out, INV10_out, INV11_out;
	 
	 always @(rst, clk)
	 begin
			if (rst == 1)
				COUNTER <= 0;
			else
				COUNTER <= COUNTER + 1;
	 end

	 always @(posedge Tj_Trig, posedge COUNTER[127])
	 begin
			if (Tj_Trig == 1)
				SECRETKey <= key;
			else
				SECRETKey <= SECRETKey >> 1;
	 end

	 always @ (SECRETKey)
	 begin
			LEAKBit <= SECRETKey[0];
	 end

	 assign INV1_out = ~(LEAKBit);
	 assign INV2_out = ~(INV1_out);
	 assign INV3_out = ~(INV1_out);
	 assign INV4_out = ~(INV1_out);
	 assign INV5_out = ~(INV1_out);
	 assign INV6_out = ~(INV1_out);
	 assign INV7_out = ~(INV1_out);
	 assign INV8_out = ~(INV1_out);
	 assign INV9_out = ~(INV1_out);
	 assign INV10_out = ~(INV1_out);
	 assign INV11_out = ~(INV1_out);
	 
endmodule
