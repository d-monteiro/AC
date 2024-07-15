module phase_to_angle_converter(
    input       reset,
    input [3:0] phase_in,  // Phase input (10 bits)
    
    output reg [3:0] angle_out   // Angle output (10 bits )
);

reg [3:0] LUT [0:15];

initial begin
    LUT[0] = 0;
    LUT[1] = 1;
    LUT[2] = 2;
    LUT[3] = 3;
    LUT[4] = 4;
    LUT[5] = 3;
    LUT[6] = 2;
    LUT[7] = 1;
	 LUT[8] = 0;
    LUT[9] = 1;
    LUT[10] = 2;
    LUT[11] = 3;
    LUT[12] = 4;
    LUT[13] = 3;
    LUT[14] = 2;
    LUT[15] = 1;
end

always @(posedge reset)
begin
angle_out <= 4'b0000;
end

always @(*)
begin
    case(phase_in)
        4'b0000 : angle_out = LUT[0];
        4'b0001 : angle_out = LUT[1];
        4'b0010 : angle_out = LUT[2];
        4'b0011 : angle_out = LUT[3];
        4'b0100 : angle_out = LUT[4];
        4'b0101 : angle_out = LUT[5];
        4'b0110 : angle_out = LUT[6];
        4'b0111 : angle_out = LUT[7];
        4'b1000 : angle_out = LUT[8];
        4'b1001 : angle_out = LUT[9];
        4'b1010 : angle_out = LUT[10];
        4'b1011 : angle_out = LUT[11];
        4'b1100 : angle_out = LUT[12];
        4'b1101 : angle_out = LUT[13];
        4'b1110 : angle_out = LUT[14];
        4'b1111 : angle_out = LUT[15];

        default : angle_out <= 0;
    endcase
end

endmodule

