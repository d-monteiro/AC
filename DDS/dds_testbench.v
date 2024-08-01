`timescale 1ns/100ps

module dds_testbench;

reg       clock;
reg       reset;
reg [N:0] freq_in;
reg [N:0] freq_in_2;
reg [N:0] phase_in;
reg [N:0] phase_in_2;
reg [N:0] amplitude_in;
reg [N:0] amplitude_in_2;

wire [N:0] out;
wire [N:0] out2;

parameter N = 8;

dds #(.N(N)) uut (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .phase_in(phase_in),
    .amplitude_in(amplitude_in),
    .out(out)
);

dds #(.N(N)) uut2 (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in_2),
    .phase_in(phase_in_2),
    .amplitude_in(amplitude_in_2),
    .out(out2)
);

initial
begin
   $dumpfile("waveform.vcd");
   $dumpvars(0,dds_testbench);
end

// Generate the clock signal:
initial
begin
    clock = 0;
    #5 forever #5 clock = ~clock;
end

initial
begin
    // Initialize Inputs
    clock = 0;
    reset = 0;
    freq_in = 1;
	freq_in_2 = 1;
    phase_in = 0;
	phase_in_2 = 256;
    amplitude_in = 1;
	amplitude_in_2 = 2;

    // Apply reset
    reset = 1;
	
    #20
	
    reset = 0;

    #100000
    $stop;
end

endmodule

