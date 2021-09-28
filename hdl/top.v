module top(
    info_bits,
    codeword,
    clk,
    i_en
);

parameter N = 11;
parameter K = 6;

input clk, i_en;
input [K-1:0] info_bits;
output reg [N-1:0] codeword;

reg [K-1:0] generator_col;
reg [K-1:0] g_transpose [0:N-1];
wire code_bit;

initial $readmemb("../g1_transpose.list", g_transpose);

encode #(K) enc(
    .info_bits(info_bits),
    .generator_col(generator_col),
    .code_bit(code_bit)
);

always @(posedge clk)
begin
    if(i_en) begin: code
        integer i;
        for(i = 0; i < N; i = i + 1) begin
            generator_col = g_transpose[i];
            codeword = {codeword, code_bit};
        end
    end
end

endmodule
