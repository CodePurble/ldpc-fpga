`timescale 1ns/1ps

module tb_encoder();

parameter N = 2304;
parameter K = 1536;
parameter COUNT_MAX_BITS = 12; // ceil(log2(N))

reg cnt_rst;
reg cnt_en;
reg [COUNT_MAX_BITS-1:0] cnt_stop_val;

reg [K-1:0] mul_info_bits;

wire [N-1:0] codeword;

reg clk;

encoder #(.N(N), .K(K), .COUNT_MAX_BITS(COUNT_MAX_BITS)) uut(
    // Signals for counter
    cnt_rst,
    cnt_en,
    cnt_stop_val,
    // Signals for mod2mul
    mul_info_bits,
    // Signals for encoder
    codeword,
    // Common signals
    clk
);

initial
begin
    $dumpfile("../sim/tb_encoder.vcd");
    $dumpvars(0, tb_encoder);
    clk = 0;
end
always #10 clk = ~clk;

initial
begin
    cnt_rst = 0;
    cnt_en = 0;
    cnt_stop_val = N;
    mul_info_bits = 6'b111111;
    #5 cnt_rst = 1; cnt_en = 1;
    #10 cnt_rst = 0;
    #3000 $finish;
end


endmodule

