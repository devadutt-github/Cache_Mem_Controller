`include "MEMORY_CONTROLLER.v"

module tb_MEMORY_CONTROLLER;    

reg clk, reset_n, enable, rw;
reg [31:0] address, data_in;
wire [31:0] data_out;

// Instantiate the Unit Under Test (UUT)

MEMORY_CONTROLLER uut (
    .clk(clk), 
    .reset_n(reset_n), 
    .enable(enable), 
    .rw(rw), 
    .address(address), 
    .data_in(data_in), 
    .data_out(data_out)
);

initial begin
    // Initialize Inputs
    clk = 1;
    reset_n = 0;
    enable = 0;
    rw = 0;
    address = 0;
    data_in = 0;

    // Wait for global reset
    #10;
    reset_n = 1;

    // Update 
    enable = 1;
    rw = 1; // Write mode
    address = 32'h00000010;
    data_in = 32'hDEADBEEF;
    #20;
    enable = 0;

  // Read Hit
    #20;
    enable = 1;
    data_in = 0;
    rw = 0; // Read mode
    address = 32'h00000010;
    #20;
    enable = 0;

  // Read Miss  
  	#20;
    enable = 1;
    rw = 0; // Read mode
    address = 32'h0001000;
    #20;
    enable = 0;

    // Finish simulation
    #100;
    $finish;
end
  

// Clock generation
always #5 clk = ~clk;
  
   initial begin
        $dumpfile("tb_MEMORY_CONTROLLER.vcd");
        $dumpvars(0, tb_MEMORY_CONTROLLER);
    end

endmodule