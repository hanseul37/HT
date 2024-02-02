`timescale 1ns / 1ps


module rec_test;

	// Inputs
	reg clk;
	reg rx;
	reg rst;

	// Outputs
	wire ready;
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	receiver uut (
		.clk(clk), 
		.rx(rx), 
		.ready(ready), 
		.data(data),
		.rst(rst)
	);

	initial begin
	
	
	#150;
				rx = 0; //start
	#8680.5	rx = 1; //data 0
	#8680.5	rx = 0; // data 1
	#8680.5	rx = 1; // data 2
	#8680.5	rx = 0; //data 3
	#8680.5	rx = 1; //data 4
	#8680.5	rx = 0; //data 5
	#8680.5	rx = 1; //data 6
	#8680.5	rx = 1; //data 7
	#8680.5	rx = 1; //stop
	
	#8000	;
	
				rx = 0; //start
	#8680.5	rx = 1; //data 0
	#8680.5	rx = 0; // data 1
	#8680.5	rx = 1; // data 2
	#8680.5	rx = 0; //data 3
	#8680.5	rx = 1; //data 4
	#8680.5	rx = 0; //data 5
	#8680.5	rx = 1; //data 6
	#8680.5	rx = 1; //data 7
	#8680.5	rx = 1; //stop
	
	
	
		
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rx = 1;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
			rst = 1;
		
		forever
		#5 clk = !clk;
		        
		// Add stimulus here

	end
      
endmodule

