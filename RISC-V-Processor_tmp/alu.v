/*
	ALU for our tiny RISC-V CPU
*/
module alu(
	input reset,
	input clock,
	
	input [31:0] rdatain1,
	input [31:0] rdatain2,
	
	input [31:0] dataimmed,
	
	input       selopr2,
	input [3:0] aluoper,
	
	output reg [31:0] aluresult,
	output reg        zero
	);
	
reg [31:0] datain2;
	
always @(posedge clock)
begin
	
	if(reset)
	begin
		zero <= 0;
		aluresult <= 32'b0;
	end
	
	case(selopr2)
		0 : datain2 = rdatain2;
		
		1 : datain2 = dataimmed;
		
		default : datain2 = rdatain2;	
	endcase
	
	case( aluoper[3:0] )
	
		4'b0000 : aluresult <= rdatain1 + datain2;
		
		4'b0001 : begin
						if(selopr2 == 1)
							aluresult <= rdatain1 + datain2;
						else aluresult <= rdatain1 - datain2;
					 end
		
		4'b0010 : aluresult <= rdatain1 ^ datain2;
		
		4'b0011 : aluresult <= rdatain1 | datain2;
		
		4'b0100 : aluresult <= rdatain1 & datain2;
		
		4'b0101 : aluresult <= rdatain1 << datain2;
		
		4'b0110 : aluresult <= rdatain1 >> datain2;
		
		4'b0111 : aluresult <= $signed(rdatain1) >>> datain2;
		
		4'b1000 : begin
					if($signed(rdatain1) < $signed(datain2))
						aluresult <= 32'b000000000000000000000000000000001;
					else
						aluresult <= 32'b0;
				  end

		4'b1001 : begin
					if(rdatain1 < datain2)
						aluresult <= 32'b000000000000000000000000000000001;
					else
						aluresult <= 32'b0;
				  end
		
		default : aluresult <= 32'b0;
	endcase
	
	if(aluresult == 32'b0)// 0-flag detector
		zero = 1;
	else 
		zero = 0;
end

endmodule

