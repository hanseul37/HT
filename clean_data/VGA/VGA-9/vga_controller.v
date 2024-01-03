`timescale 10ns / 100 ps

module vga_controller
	#(parameter h_size = 800,
	  parameter h_synctime = 80,
	  parameter h_porch = 80,
	  
	  parameter v_size = 600,
	  parameter v_synctime = 1,
	  parameter v_porch = 46)
	  
	  (input reset,
	   input clk,
		output h_sync_out,
		output v_sync_out,
		output [2:0] rgb_out);
	
	
	reg h_period = h_size + h_synctime + h_porch;
	reg v_period = v_size + v_synctime + v_porch;
	reg [10:0] h_counter;
	reg [9:0]  v_counter;
	
	reg h_sync;
	reg v_sync;
	reg [2:0] rgb;
	
	reg blank;
	reg pblank;
	
	//*****************************************************************
	always @(clk, reset) begin
		if (reset == 1) begin
			h_counter = 0;
		end
		else begin
			if (clk == 1) begin
				if (h_counter < h_period) begin
					h_counter = h_counter + 1;
				end
				else begin
						h_counter = 0;
				end
			end
		end
		if((h_counter >= h_size) || (v_counter >= v_size)) begin
			blank = 1;
		end
		
	end 
	//*****************************************************************
	always @(h_sync,reset) begin
		if(reset == 1) begin
			v_counter = 0;
		end
		else begin
			if(h_sync == 1) begin
				if(v_counter < v_period) begin
					v_counter = v_counter + 1;
				end
				else begin
					v_counter = 0;
				end
			end
		end
	end
	//*****************************************************************
	always @(clk, reset) begin
		if(reset == 1) begin
			h_sync = 0;
		end
		else begin
			if (clk == 1) begin
				if((h_counter >= h_size) && (h_counter < (h_size +h_synctime))) begin
						h_sync = 1;
				end
				else begin
					h_sync = 0;
				end
			end
		end
	end
	//*****************************************************************
	always @ (h_sync, reset) begin
		if(reset == 1)begin
			v_sync = 0;
		end
		else begin
			if (h_sync == 1) begin
				if(v_counter >= v_size) begin 
					if (v_counter <(v_size + v_synctime)) begin
						v_sync = 1;
					end
				end
				else begin
					v_sync = 0;
				end
			end
		end
	end
	//*****************************************************************
	always @(clk, reset) begin
		if(reset == 1) begin
			pblank = 0;
		end
		else begin
			if(clk == 1) begin // posedge
				pblank = blank;
			end
		end
	end
	//*****************************************************************
	always @(clk, reset) begin
		if(reset == 1) begin 
			rgb = 0;
		end
		else begin
			if (clk == 1) begin
				if (pblank == 0) begin
					rgb = 3'b001;
				end
			end
		end
	end
	//*****************************************************************
	assign h_sync_out = h_sync;
	assign v_sync_out = v_sync;
	assign rgb_out = rgb;

endmodule
