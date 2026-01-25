## DDS

The DDS (Direct Digital Synthesis) module is implemented in Verilog and is designed to generate waveforms with variable frequencie and amplitude.

### Usage

Here's an example of how to instantiate a DDS module:

```verilog
dds my_dds (
    .clock(clock),
    .reset(reset),
    .freq_in(freq_in),
    .phase_in(phase_in),
    .amplitude_in(amplitude_in),
    .out(out)
);
```