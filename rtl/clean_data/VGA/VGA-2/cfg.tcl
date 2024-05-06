set verilog_files {\
	generic_dpram.v\
	generic_spram.v\
	sync_check.v\
	tests.v\
	timescale.v\
	vga_clkgen.v\
	vga_colproc.v\
	vga_csm_pb.v\
	vga_curproc.v\
	vga_cur_cregs.v\
	vga_defines.v\
	vga_enh_top.v\
	vga_fifo.v\
	vga_fifo_dc.v\
	vga_pgen.v\
	vga_tgen.v\
	vga_vtim.v\
	vga_wb_master.v\
	vga_wb_slave.v\
	wb_b3_check.v\
	wb_mast_model.v\
	wb_model_defines.v\
	wb_slv_model.v\
}

set clk wb_clk_i

set top_des_name vga_enh_top

set dont_touch_module_name TSC
