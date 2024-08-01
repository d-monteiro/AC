module phase_accumulator(
  input       clock,
  input       reset,
  input [N:0] freq_in,       // Frequency input
  input [N:0] phase_in,      // Phase input

  output reg [N:0] phase_out // Phase output
);

parameter N = 8;

integer init;

always @(posedge reset) 
begin
  phase_out <= phase_in;
  init <= 0;
end


always @(posedge clock) 
begin
  if (init == 0)
  begin
    init <= 1;
    phase_out <= phase_in;
  end

  else
  begin
  phase_out <= phase_out + freq_in;
  end
end

endmodule

