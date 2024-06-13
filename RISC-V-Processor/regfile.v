/*
	register bank for our tiny RISC-V CPU
*/
module regfile(
	input reset,
	input clock,
		
	input [31:0]  datain,
	
	input [4:0] rs1,
	input [4:0] rs2,
	
	input [4:0] rd, // Write Select
	input       we,
	
	output reg [31:0] dataout1,
	output reg [31:0] dataout2
	);
	
reg [31:0] register [1:31]; // Initialize registers
integer i;
	
always @(posedge clock)
begin

	if(reset) // Clear registers
	begin
		for(i = 1; i < 32; i = i+1)
			register[i] <= 32'b0;
	end
	
	else
	begin
		if(we && rd != 5'b0)
		begin
			register[rd] <= datain;
		end
	end
	
	dataout1 = (rs1 == 5'b0) ? 32'b0 : register[rs1]; 
	dataout2 = (rs2 == 5'b0) ? 32'b0 : register[rs2];

end

endmodule

