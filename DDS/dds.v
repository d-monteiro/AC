module dds (
    input clock,
    input reset,
    input [N:0] freq_in,
    input [N:0] phase_in,
    input [N:0] amplitude_in,
    output [2*N:0] out
);

parameter N = 8;

wire [N:0] phase;

phase_accumulator #(.N(N)) accum (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .phase_in(phase_in),
    .phase_out(phase)
);

phase_to_angle_converter #(.N(N)) conv (
    .reset(reset),
    .phase_in(phase),
    .amplitude_in(amplitude_in),
    .out(out)
);

endmodule

