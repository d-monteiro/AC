module regfile_testbench;
    reg clock;
    reg reset;
	
    reg [31:0] datain;
	
    reg [4:0] rs1;
    reg [4:0] rs2;
	
	 reg [4:0] rd; // Write Select
    reg       we;
	
    wire [31:0] dataout1;
    wire [31:0] dataout2;

	// Instantiate the Unit Under Test (UUT)
    regfile 
		uut (
        .clock(clock),
        .reset(reset),
		
        .datain(datain),
		
        .rs1(rs1),
        .rs2(rs2),
		
        .we(we),
        .rd(rd),
		
        .dataout1(dataout1),
        .dataout2(dataout2)
    );
	
	// Generate the clock signal:
	initial
	begin
		clock = 0;
		#5 forever #5 clock = ~clock;
	end

	// Main verification program:
    initial
	begin
		reset = 1;
		#20
		reset = 0;
		#20

        #10 we = 1; rd = 5'd1; datain = 32'h12345678;
        #10 we = 0; rs1 = 5'd1;
        #10 $display("Register 1 data: %h", dataout1);
		  
        #10 we = 1; rd = 5'd2; datain = 32'h87654321;
        #10 we = 0; rs2 = 5'd2;
        #10 $display("Register 2 data: %h", dataout2);
		  
        #10 we = 1; rd = 5'd0; datain = 32'hFFFFFFFF;
        #10 we = 0; rs1 = 5'd0;
        #10 $display("Register 0 data: %h", dataout1);

        $stop;
    end

endmodule
