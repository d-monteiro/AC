module programcounter_testbench;
    reg clock;
    reg reset;
	
    reg [ 1:0] func;
	
    reg [21:0] offset;
	
  	 reg [ 4:0] rs1;
	
    wire [31:0] pcout;
	
	// Instantiate the Unit Under Test (UUT)
	programcounter
		uut (
		.clock(clock),
		.reset(reset),	
		
		.func(func),
		
		.offset(offset),
		
		.rs1(rs1),
		
		.pcout(pcout)
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
	
	   // Apply reset
      #10 reset = 1;
      #10 reset = 0;
		
		offset = 2'd2;
		rs1 = 4'b0001;
		
		func = 2'b00; // PC <= PC + 4
		#20
		
		func = 2'b01; // PC <= PC + immediate
		#20
		
		func = 2'b10; // PC <= PC + rs1 + immediate
		#20
		
		func = 2'b11; // PC <= PC + (immediate << 12)
		#20
		
		reset = 1;
		#20 
      reset = 0;
		#10
		  
		$stop;
		
	end
	
endmodule

