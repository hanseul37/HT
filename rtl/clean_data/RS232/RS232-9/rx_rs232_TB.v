`timescale 1ns/1ns 
module rx_rs232_TB();
localparam 	memNUM	=	4'd4	;
//================================================================
reg				clk_s	;
reg				rstn_s	;
reg				iDATA	;
wire	[ 7:0]	oDATA	;
wire			oDONE	;
reg		[ 7:0]	mem[memNUM:0]	;
//================================================================
initial
begin
	clk_s	=	1'b0	;
	rstn_s	=	1'b0	;
	iDATA	=	1'b1	;
end

always
	#1	clk_s	=	~clk_s	;

initial
begin
	#100	rstn_s	=	1'b1	;
	#300	tx_byte();
end
//================================================================
initial
	$readmemh("C:/Users/Petter/Documents/quartus/RS232_2/src/tx_data.txt",mem);

task tx_byte;
	integer i;
	for (i=0;i<memNUM;i=i+1)
	begin
		tx_data_task(mem[i]);
		#100	;
	end
endtask
	
task tx_data_task;
	input [7:0] data;
	integer i;
	for(i=0;i<10;i=i+1)
	begin
		case(i)
			0: iDATA <= 1'b0;
			1: iDATA <= data[0];
			2: iDATA <= data[1];
			3: iDATA <= data[2];
			4: iDATA <= data[3];
			5: iDATA <= data[4];
			6: iDATA <= data[5];
			7: iDATA <= data[6];
			8: iDATA <= data[7];
			9: iDATA <= 1'b1;
		endcase
		#12;
	end
endtask
//================================================================
rx_rs232	rx_rs232_INST
(
	.clk_s			(clk_s	),		//clk=143MHz
	.rstn_s			(rstn_s	),		//rstn_s=0 effect
	.iDATA			(iDATA	),
	.oDATA			(oDATA	),
	.oDONE			(oDONE	)		//1Frame finish oDONE=1
);
endmodule