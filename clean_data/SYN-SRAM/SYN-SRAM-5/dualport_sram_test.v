`include "dualport_sram.v"
module dualport_sram_test;
//Inputs
reg clk,wr,rd;
reg [31:0] din;
reg [2:0] addr;

//Outputs
wire [31:0] dout;

//Instantiate the Unit Under Test (UUT)
dualport_sram uut(
    .clk(clk),
    .wr(wr),
    .rd(rd),
    .din(din),
    .addr(addr),
    .dout(dout)
);
always #50 clk=~clk;
initial begin
    $dumpfile("dualport_sram_test.vcd");
    $dumpvars(0,dualport_sram_test);
    //Initialize inputs
    clk=1;
    wr=1;
    rd=0;
    din=32'h000000ff;
    addr=00;

    //Wait for 100ns for global to reset to finish
    #100;wr=1;
    rd=0;
    din=32'h0011ffff;
    addr=01;

    #100;wr=1;
    rd=0;
    din=32'h0011abcd;
    addr=10;

    #100;wr=1;
    rd=0;
    din=32'h00110000;
    addr=11;

    #100;wr=0;
    rd=1;
    addr=01;

    #100;wr=0;
    rd=1;
    addr=11;

    #100;wr=0;
    rd=1;
    addr=10; 

    #100;
    $finish;
    //Add stimulus here
end

endmodule


