/****************************************************************************
 * fwpic_wb.v
 ****************************************************************************/
 
`include "wishbone_macros.svh"
`include "rv_addr_line_en_macros.svh"


/**
 * Module: fwpic_wb
 * 
 * TODO: Add module documentation
 */
module fwpic_wb #(
		parameter N_IRQ = 8
		) (
		input clock,
		input reset,
		`WB_TARGET_PORT(rt_, 32, 32),
		output				int_o,
		input[N_IRQ-1:0]	irq
		);

	`RV_ADDR_LINE_EN_WIRES(rv_, 32, 32);
	reg ack_r;
	assign rv_adr = rt_adr[3:2];
	assign rv_dat_w = rt_dat_w;
	assign rt_dat_r = rv_dat_r;
	assign rv_we = rt_we;
	assign rt_ack = ack_r;
	assign rv_valid = (rt_cyc && rt_stb);
	
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			ack_r <= 0;
		end else begin
			case (ack_r) 
				0: begin
					if (rt_cyc && rt_stb && rv_ready) begin
						ack_r <= 1'b1;
					end
				end
				1: begin
					ack_r <= 1'b0;
				end
			endcase
		end
	end
	
	fwpic #(
		.N_IRQ  (N_IRQ )
		) u_pic (
		.clock  (clock ), 
		.reset  (reset ), 
		`RV_ADDR_LINE_EN_CONNECT( , rv_),
		.int_o  (int_o ), 
		.irq    (irq   ));

endmodule


