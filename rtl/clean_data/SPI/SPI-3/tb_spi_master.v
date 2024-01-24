module tb_spi_master;

    // Parameters
    parameter reg_width = 8;
    parameter counter_width = $clog2(reg_width);

    // Inputs
    reg rstn = 1'b0;
    reg sys_clk = 1'b0;
    reg t_start = 1'b0;
    reg [reg_width-1:0] d_in = 8'h00;
    reg [counter_width:0] t_size = 3'b001;

    // Outputs
    wire [reg_width-1:0] d_out;
    wire miso = 1'b0;
    wire mosi = 1'b0;
    wire spi_clk = 1'b0;
    wire cs = 1'b0;

    // Instantiate the SPI module
    spi #(.reg_width(reg_width), .counter_width(counter_width)) dut (
        .rstn(rstn),
        .sys_clk(sys_clk),
        .t_start(t_start),
        .d_in(d_in),
        .t_size(t_size),
        .d_out(d_out),
        .miso(miso),
        .mosi(mosi),
        .spi_clk(spi_clk),
        .cs(cs)
    );

    // Clock generator
    always #5 sys_clk = ~sys_clk;

    // Reset generator
    initial begin
        rstn = 0;
        #10 rstn = 1;
    end

    // Test sequence
    initial begin
        t_size=4'b1000;
        // Wait for reset to complete
        #20;

        // Load data
        d_in = 8'h55;
//        t_size = 3'b010;
        t_start = 1;
        #10 t_start = 0;

        // Wait for transaction to complete
        #50;

        // Unload data
//        t_size = 3'b000;
        t_start = 1;
        #10 t_start = 0;

        // Wait for unload to complete
        #20;

        // Load data again
        d_in = 8'hAA;
//        t_size = 3'b011;
        t_start = 1;
        #10 t_start = 0;

        // Wait for transaction to complete
        #70;

        // Unload data again
//        t_size = 3'b000;
        t_start = 1;
        #10 t_start = 0;

        // Wait for unload to complete
        #40;

        // End of test
        $finish;
    end

endmodule
