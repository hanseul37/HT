module clock_divider(in, out);
  input in;
  output reg out;
  reg [3:0] counter = 4'd0;
  parameter div = 4'd8;//the factor by which we want to divide the clock frequency
  always@(posedge in)
    begin
      counter<=counter+4'd1;//increment counter by 1 at every posedge of the original clock
      if(counter>=(div-1))//if counter reaches the div parameter value, reset it to 0
        counter<=4'd0;
      out<=(counter<div/8)?1'b1:1'b0;//whenever counter is reset, make the output clock signal high
    end
endmodule
