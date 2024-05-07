`timescale 1ns / 1ps

module top(i_Clock, i_Rx_Serial, o_Tx_Active, o_Tx_Serial, o_Tx_Done);
	input i_Clock;
	input i_Rx_Serial;
	reg DV;
	reg [7:0] Byte;
	output o_Tx_Active;
	output reg o_Tx_Serial;
	output o_Tx_Done;
	
	uart_rx rx(
		.i_Clock(i_Clock),
		.i_Rx_Serial(i_Rx_Serial),
		.o_Rx_DV(DV),
		.o_Rx_Byte(Byte));
	uart_tx tx(
		.i_Clock(i_Clock),
		.i_Tx_DV(DV),
		.i_Tx_Byte(Byte),
		.o_Tx_Active(o_Tx_Active),
		.o_Tx_Serial(o_Tx_Serial),
		.o_Tx_Done(o_Tx_Done)
   );

endmodule