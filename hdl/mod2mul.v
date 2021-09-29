module mod2mul(
    info_bits,
    generator_col,
    code_bit
);

parameter K = 3;

input [K-1:0] info_bits;
input [K-1:0] generator_col;
output code_bit;

wire [K-1:0] w;

assign w = info_bits & generator_col;
assign code_bit = ^w;

endmodule

