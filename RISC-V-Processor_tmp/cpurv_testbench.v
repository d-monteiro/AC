// foto com erros de syntax
module cpurv_testbench;

    // Inputs
    reg clock;
    reg reset;
    reg [31:0] instruction;
    reg [31:0] datainport;

    // Outputs
    wire [31:0] progaddress;
    wire [31:0] dataoutport;

    // Instantiate the Unit Under Test (UUT)
    cpurv uut(
        .clock(clock), 
        .reset(reset), 
        .progaddress(progaddress), 
        .instruction(instruction), 
        .dataoutport(dataoutport), 
        .datainport(datainport)
    );

    // Generate the clock signal:
	initial
	begin
		clock = 0;
		#5 forever #5 clock = ~clock;
	end

    initial 
    begin
        // Initialize Inputs
        clock = 0;
        reset = 0;
        instruction = 0;
        datainport = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply reset
        reset = 1;
        #10
        reset = 0;
        #10
        
        // R-type
        instruction = 32'b0000000_01100_01011_000_01101_0110011; // add x3, x1, x2 (add x13, x11, x12)
        datainport = 32'b0; // immediate = 0
        #20
        
        // I-type // Tá mal, não dá output do dataoutport
        instruction = 32'b0000000_00001_00000_000_01011_0010011; // addi a1, zero, 1 (addi x11, x0, 1)
        datainport = 32'b0; // immediate = 0
        #20

        $stop;

    end

endmodule

