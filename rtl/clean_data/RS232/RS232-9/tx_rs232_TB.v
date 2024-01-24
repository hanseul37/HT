`timescale 1ns/1ns 
module tx_rs232_TB();
//=============================================
reg				clk_s	 ;
reg				rstn_s	 ;
reg				iSEND	 ;
reg		[ 7:0]	iDATA	 ;
wire			oDATA	 ;
wire			oFINISH	 ;
//=============================================
initial
begin
	clk_s	=	1'b0	; 
	rstn_s	=	1'b0	; 
	iSEND	=	1'b0	;
	iDATA	=	8'hzz	;
	#10
	rstn_s	=	1'b1	;
	#500
	iSEND	=	1'b1	;
	iDATA	=	8'h11	;
	#2
	iDATA	=	8'hzz	;
	iSEND	=	1'b0	;
	
end 


always
	#1	clk_s	=	~clk_s	;
//=============================================
tx_rs232	tx_rs232_INST
(
	.clk_s		(clk_s	 	),
	.rstn_s		(rstn_s	 	),
	.iSEND		(iSEND	 	),
	.iDATA		(iDATA	 	),
	.oDATA		(oDATA	 	),
	.oFINISH	(oFINISH	)	
);
endmodule