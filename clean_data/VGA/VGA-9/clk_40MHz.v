`timescale 10ns / 100ps

module clk_40MHz
	(input  clk_in,
	 output clk_out);
	 
	 wire				sub_wire0;
	 wire [1:0]		sub_wire1;
	 wire  			sub_wire2 = 0;
	 wire [4:0] 	sub_wire3;
	 

		assign clk_out = sub_wire3[0];
		assign sub_wire0 = clk_in;
		assign sub_wire1 = sub_wire2 & sub_wire0;
	
	 altpll 
		#(.bandwidth_type("AUTO"),
		  .clk0_divide_by(1),
		  .clk0_duty_cycle(50),
		  .clk0_multiply_by(4),
		  .clk0_phase_shift("0"),
		  .compensate_clock("CLK0"),
		  .inclk0_input_frequency(10000),
		  .intended_device_family("MAX 10"),
		  .lpm_hint("CBX_MODULE_PREFIX=CLK_40MHz"),
		  .lpm_type("altpll"),
		  .operation_mode("NORMAL"),
		  .pll_type("AUTO"),
		  .port_activeclock("PORT_UNUSED"),
		  .port_areset("PORT_UNUSED"),
		  .port_clkbad0("PORT_UNUSED"),
		  .port_clkbad1("PORT_UNUSED"),
		  .port_clkloss("PORT_UNUSED"),
		  .port_clkswitch("PORT_UNUSED"),
		  .port_configupdate("PORT_UNUSED"),
		  .port_fbin("PORT_UNUSED"),
		  .port_inclk0("PORT_USED"),						//used
		  .port_inclk1("PORT_UNUSED"),
		  .port_locked("PORT_UNUSED"),
		  .port_pfdena("PORT_UNUSED"),
		  .port_phasecounterselect("PORT_UNUSED"),
		  .port_phasedone("PORT_UNUSED"),
		  .port_phasestep("PORT_UNUSED"),
		  .port_phaseupdown("PORT_UNUSED"),
		  .port_pllena("PORT_UNUSED"),
		  .port_scanaclr("PORT_UNUSED"),
		  .port_scanclk("PORT_UNUSED"),
		  .port_scanclkena("PORT_UNUSED"),
		  .port_scandata("PORT_UNUSED"),
		  .port_scandataout("PORT_UNUSED"),
		  .port_scandone("PORT_UNUSED"),
		  .port_scanread("PORT_UNUSED"),
		  .port_scanwrite("PORT_UNUSED"),
		  .port_clk0("PORT_USED"),							//used
		  .port_clk1("PORT_UNUSED"),
		  .port_clk2("PORT_UNUSED"),
		  .port_clk3("PORT_UNUSED"),
		  .port_clk4("PORT_UNUSED"),
		  .port_clk5("PORT_UNUSED"),
		  .port_clkena0("PORT_UNUSED"),
		  .port_clkena1("PORT_UNUSED"),
		  .port_clkena2("PORT_UNUSED"),
		  .port_clkena3("PORT_UNUSED"),
		  .port_clkena4("PORT_UNUSED"),
		  .port_clkena5("PORT_UNUSED"),
		  .port_extclk0("PORT_UNUSED"),
		  .port_extclk1("PORT_UNUSED"),
		  .port_extclk2("PORT_UNUSED"),
		  .port_extclk3("PORT_UNUSED"),
		  .width_clock(5))
	
	 pll (.inclk (clk_in),
			.clk (sub_wire3));

endmodule
