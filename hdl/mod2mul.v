module mod2mul(
    info_bit_slice,
    generator_col_slice,
    code_bit
);

parameter SLICE_SIZE = 3;

input [SLICE_SIZE-1:0] info_bit_slice;
input [SLICE_SIZE-1:0] generator_col_slice;
output code_bit;

wire [SLICE_SIZE-1:0] w;

assign w = info_bit_slice & generator_col_slice;
assign code_bit = ^w;

endmodule

