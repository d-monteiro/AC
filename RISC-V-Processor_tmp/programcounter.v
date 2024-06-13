/*
	Program counter for our tiny RISC-V CPU
*/
module programcounter(
    input clock,
    input reset,
	
    input [ 1:0] func,
	
    input [21:0] offset, // immediate
	
	input [ 4:0] rs1,
	
    output reg [31:0] pcout
	);
	
always @(posedge clock)
begin
	
	case (func)
	
		2'b00 : pcout <= pcout + 4;
		
		2'b01 : pcout <= pcout + offset;
		
		2'b10 : pcout <= pcout + rs1 + offset;
		
		2'b11 : pcout <= pcout + (offset << 12);
		
	endcase	
	
	if(reset)
		pcout <= 32'b0;
	
end
	
endmodule