module top(
    info_bits,
    generator,
    codeword,
    clk,
    i_en
);
parameter N = 11;
parameter K = 6;

input clk, i_en;
input [K-1:0] info_bits;
input [(K*N)-1:0] generator;
output [N-1:0] codeword;

encode #(.N(N), .K(K)) enc(
    .info_bits(info_bits),
    .generator(generator),
    .codeword(codeword),
    .clk(clk),
    .i_en(i_en)
);
endmodule
