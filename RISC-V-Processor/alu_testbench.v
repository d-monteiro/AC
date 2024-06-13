module alu_testbench;
    reg clock;
    reg reset;
	
	reg [31:0] rdatain1;
	reg [31:0] rdatain2;
	
	reg [31:0] dataimmed;
	
	reg       selopr2;
	reg [3:0] aluoper;
	
	wire [31:0] aluresult;
	wire        zero;

	// Instantiate the Unit Under Test (UUT)
    alu 
		uut (
        .clock(clock),
        .reset(reset),
		
        .rdatain1(rdatain1),
		.rdatain2(rdatain2),
		
	     .dataimmed(dataimmed),
		
        .selopr2(selopr2),
        .aluoper(aluoper),
		
        .aluresult(aluresult),
        .zero(zero)
    );
	
	// Generate the clock signal:
	initial
	begin
		clock = 0;
		#1 forever #1 clock = ~clock;
	end
	
	// Main verification program:
	initial
	begin
	     // Apply reset
        #10 reset = 1;
        #10 reset = 0;

        // Test ADD operation, 32'h30
        rdatain1 = 32'h00000010;
        rdatain2 = 32'h00000020;
        aluoper = 4'b0000;
        #10;

        // Test SUB operation, 32'hFFFFFFF0
        aluoper = 4'b0001;
        #10;

        // Test AND operation, 32'h00000000
        aluoper = 4'b0010;
        #10;

        // Test OR operation, 32'hFFFFFFFF
        aluoper = 4'b0011;
        #10;

        // Test XOR operation, 32'h00000030
        aluoper = 4'b0100;
        #10;

        // Test SLL operation, 32'h00000040
		rdatain2 = 32'h00000002;
        aluoper = 4'b0101;
        #10;

        // Test SRL operation, 32'h00000004
        aluoper = 4'b0110;
        #10;

        // Test SRA operation, 32'hFC000004
		rdatain1 = 32'hF0000010;
        aluoper = 4'b0111;
        #10;

        // Test SLT operation, 32'h00000001
        aluoper = 4'b1000;
        #10;
		
		  // Test SLTU operation, 32'h00000000
        aluoper = 4'b1001;
        #10;
		  
		  // Apply reset
        #10 reset = 1;
        #10 reset = 0;
		  
		  selopr2 = 1;

        // Test ADDI operation
        rdatain1 = 32'h00000010;
        dataimmed = 32'h00000002;
        aluoper = 4'b0000;
        #10;

        // Test SUBI operation
        aluoper = 4'b0001;
        #10;
		  
        // Test XORI operation
        aluoper = 4'b0010;
        #10;

        // Test ORI operation
        aluoper = 4'b0011;
        #10;
		  
        // Test ANDI operation
        aluoper = 4'b0100;
        #10;

        // Test SLLI operation
		rdatain2 = 32'h00000002;
        aluoper = 4'b0101;
        #10;

        // Test SRLI operation
        aluoper = 4'b0110;
        #10;

        // Test SRAI operation
		rdatain1 = 32'hF0000010;
        aluoper = 4'b0111;
        #10;

        // Test SLTI operation
        aluoper = 4'b1000;
        #10;
		
		// Test SLTUI operation
        aluoper = 4'b1001;
        #10;

        $stop;
    end
	
endmodule

