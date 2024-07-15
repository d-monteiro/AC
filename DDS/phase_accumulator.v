module phase_accumulator(
    input       clock,
    input       reset,
    input [3:0] freq_in,  // Frequency control word (10 bits)

    output reg [3:0] phase_out   // Phase output (10 bits )
);

always @(posedge reset) 
begin
phase_out <= 0;
end

always @(posedge clock) 
begin
    phase_out <= phase_out + freq_in;
end

endmodule

