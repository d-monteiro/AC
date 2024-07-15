module  dds_testbench;

reg       clock;
reg       reset;
reg [3:0] freq_in;

wire [3:0] out;

dds uut (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .out(out)
);

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
    freq_in = 0;

    // Apply reset
    reset = 1;
    #10
    reset = 0;
    #10

    freq_in = 4'b0001;

    #1000
    $stop;
end

endmodule

