module dds (
    input clock,
    input reset,
    input [3:0] freq_in,
    output [3:0] out
);

wire [3:0] phase;

phase_accumulator accum (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .phase_out(phase)
);

phase_to_angle_converter conv (
    .reset(reset),
    .phase_in(phase),
    .angle_out(out)
);

endmodule

