`timescale 10ns / 100ps

module vga_main 
	(input reset,
	 input clk,
	 output h_sync,
	 output v_sync,
	 output [2:0] rgb);
	 
	 wire clk_temp;
	 
	 vga_controller ctrl
	 (.reset(reset),
	  .clk(clk_temp),
	  .h_sync_out(h_sync),
	  .v_sync_out(v_sync),
	  .rgb_out (rgb));
	  
	  clk_40MHz clock
	  (.clk_in (clk),
	   .clk_out(clk_temp));
	
endmodule
