module mux (in0,in1,sel,out);
parameter ADD_SIZE = 10 ;
input [ADD_SIZE-1:0] in0 ,in1;
input sel ;
output [ADD_SIZE-1:0] out ;

assign out =(sel==1)?in1 : in0 ;
wire [ADD_SIZE-1:0] z1 ;
assign z1 = in1 ;
endmodule 