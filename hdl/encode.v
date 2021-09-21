module encode(
    info_bits,
    generator_p,
    codeword,
    clk,
    i_en
);

parameter N = 6;
parameter K = 3;

input clk, i_en;
input [K-1:0] info_bits;
/* input [((K)*(N-K))-1:0] generator_p; */
input [(K*N)-1:0] generator_p;
output reg [N-1:0] codeword;

/* reg [N-K-1:0] check_bits; */

always @(posedge clk)
begin
    if(i_en)
    begin: gen
        integer i, j;
        for(i = 0; i < N; i=i+1) begin
            codeword[i] = 0;
            for(j = 0; j < K; j=j+1) begin
                codeword[i] = codeword[i] ^ (info_bits[j] & generator_p[j*(N-K) + i]);
            end
        end
        /* codeword = {info_bits, check_bits}; */
    end
end
endmodule

