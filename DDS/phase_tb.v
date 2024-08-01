`timescale 1ns/100ps

module phase_tb;

reg       clock;
reg       reset;
reg [N:0] freq_in;
reg [N:0] phase_in;

wire [N:0] phase_out;

parameter N = 8;

phase_accumulator #(.N(N)) uut (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .phase_in(phase_in),
    .phase_out(phase_out)
);

initial
begin
   $dumpfile("waveform.vcd");
   $dumpvars(0,phase_tb);
end

// Generate the clock signal:
initial
begin
    clock = 0;
    #5 forever #5 clock = ~clock;
end

initial
begin
    // Apply reset
	freq_in = 1;
	phase_in = 10;
    reset = 1;
    #20
	
    reset = 0;

    #10000
    $stop;
end

endmodule

