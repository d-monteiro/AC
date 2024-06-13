 module decodeinstruction_testbench;
	
	reg [31:0] instruction;
	
	wire [1:0]  pcfunc;
	wire [21:0] pcoffset;
	
	wire [4:0] readselect1;
	wire [4:0] readselect2;
	
	wire       writeenable;
	wire [4:0] writeselect;
	
	wire [3:0] aluoper;
	wire       selopr2;
	
	wire [21:0] immediate;
	
	// Instantiate the Unit Under Test (UUT)
	decodeinstruction uut(
		.instruction(instruction),
		
		.pcfunc(pcfunc),
		.pcoffset(pcoffset),
		
		.readselect1(readselect1),
		.readselect2(readselect2),
		
		.writeenable(writeenable),
		.writeselect(writeselect),
		
		.aluoper(aluoper),
		.selopr2(selopr2),
		
		.immediate(immediate)
	);
	
	// Main verification program:
	initial
		begin
			
			// R-type instruction
			instruction = 32'h002081B3; // add x3, x1, x2
			#100
			$display("Instruction: %b\n\n", instruction);
			$display("pcfunc: %b\n", pcfunc);
			$display("pcoffset: %b\n\n", pcoffset);
			$display("readselect1: %b\n", readselect1);
			$display("readselect2: %b\n", readselect2);
			$display("writeenable: %b\n", writeenable);
			$display("writeselect: %b\n\n", writeselect);
			$display("aluoper: %b\n", aluoper);
			$display("selopr2: %b\n\n", selopr2);
			$display("immediate: %b\n", immediate);
			
			// I-type instruction
			instruction = 32'h3E808113; // addi x2, x1, 1000
			#100
			$display("Instruction: %b\n\n", instruction);
			$display("pcfunc: %b\n", pcfunc);
			$display("pcoffset: %b\n\n", pcoffset);
			$display("readselect1: %b\n", readselect1);
			$display("readselect2: %b\n", readselect2);
			$display("writeenable: %b\n", writeenable);
			$display("writeselect: %b\n\n", writeselect);
			$display("aluoper: %b\n", aluoper);
			$display("selopr2: %b\n\n", selopr2);
			$display("immediate: %b\n", immediate);

			$stop;
			
		end
	
endmodule

