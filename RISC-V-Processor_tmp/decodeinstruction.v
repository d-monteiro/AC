/*
	instruction decoder for our tiny RISC-V CPU
*/
module decodeinstruction(
	
	input [31:0] instruction,
	
	output reg [1:0]  pcfunc,
	output reg [21:0] pcoffset,
	
	output reg [4:0] readselect1,
	output reg [4:0] readselect2,
	
	output reg       writeenable,
	output reg [4:0] writeselect,
	
	output reg [3:0] aluoper,
	output reg       selopr2,
	
	output reg [31:0] immediate
	);

always @(*) // Circuito combinatório (sem clock e sem reset)
begin
	if( instruction [6:0] == 7'b0110011 ) begin // R-type instruction
		selopr2 = 0;
		
		pcfunc = 2'b00;
		pcoffset = 22'b0000000000000000000000;
		
		readselect1 = instruction[19:15];
		readselect2 = instruction[24:20];
		
		writeenable = 1'b1;
		writeselect = instruction[11:7];
		
		case( instruction [14:12] )
			3'b000 : begin
						if( instruction [31:25] == 7'b0000000 )
							aluoper = 4'b0000;
							
						else aluoper = 4'b0001;
					 end

			3'b100 : aluoper = 4'b0010;
			
			3'b110 : aluoper = 4'b0011;
			
			3'b111 : aluoper = 4'b0100;
			
			3'b001 : aluoper = 4'b0101;
			
			3'b101 : begin
						if( instruction [31:25] == 7'b0000000 )
							aluoper = 4'b0110;
							
						else aluoper = 4'b0111;
					 end
			
			3'b010 : aluoper = 4'b1000;
			
			3'b011 : aluoper = 4'b1001;
			
			default : begin // default case : add rd, r1, r0 (valor 0)
						aluoper = 4'b0000;
						readselect2 = 5'b00000;
					  end
		endcase
	end
	
	else begin // I-type instruction
		selopr2 = 1;
		
		pcfunc = 2'b00;
		pcoffset = 22'b0000000000000000000000;
		
		readselect1 = instruction[19:15];
		readselect2 = 5'b00000;
		
		writeenable = 1'b1;
		writeselect = instruction[11:7];
		
		immediate = {20'b0, instruction[31:20]};
		
		case( instruction [14:12] )
			3'b000 : aluoper = 4'b0000;

			3'b100 : aluoper = 4'b0010;
			
			3'b110 : aluoper = 4'b0011;
			
			3'b111 : aluoper = 4'b0100;
			
			3'b001 : begin
						if( instruction [31:25] == 7'b0000000 )
							aluoper = 4'b0101;
							immediate = {27'b0, instruction[24:20]};
					 end
			
			3'b101 : begin
							if( instruction [31:25] == 7'b0000000 ) begin
								aluoper = 4'b0110;
								immediate = {27'b0, instruction[24:20]};
							end
								
							else begin
								aluoper = 4'b0111;
								immediate = {27'b0, instruction[24:20]};
							end
						end
			
			3'b010 : aluoper = 4'b1000;
			
			3'b011 : aluoper = 4'b1001;
			
			default : begin // default case : add rd, r1, 0
						aluoper = 4'b0000;
						immediate = 32'b00000000000000000000000000000000;
					  end
		endcase
	end
end

endmodule

