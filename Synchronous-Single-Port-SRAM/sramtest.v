`include "sram.v"
module sramtest;
//Inputs
reg clk,wr,rd,rst;
reg [1:0]addr;

//Outputs

//Instantiate the Unit Under Test (UUT)
sram uut(
    .clk(clk),
    .wr(wr),
    .rd(rd),
    .rst(rst),
    .addr(addr)
);
always #40 clk=~clk;
initial begin
  
    $dumpfile("sramtest.vcd");
    $dumpvars(0,sramtest);
  
    //Initialize inputs
  
    clk=1;wr=0;rd=1;rst=1; //memory initialized with 0 values 
  
    //Wait for 100ns for global to reset

    #80;wr=1;rd=0;rst=0;addr=2'b01;uut.data=16'ha00f;
    #80;wr=1;rd=0;rst=0;addr=2'b10;uut.data=16'hffff;
    #80;wr=1;rd=0;rst=0;addr=2'b11;uut.data=16'h000f;
    #80;wr=1;rd=0;rst=0;addr=2'b00;uut.data=16'h4321;

    //read data
  
    #80;wr=0;rd=1;rst=0;addr=2'b01;
    #80;wr=0;rd=1;rst=0;addr=2'b10;
    #80;wr=0;rd=1;rst=0;addr=2'b11;
    #80;
    $finish;
  
    //Add stimulus here
  
end

endmodule
