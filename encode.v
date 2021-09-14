module encode(
    info_bits,
    generator,
    codeword
);
parameter N = 6;
parameter K = 3;

input [K-1:0] info_bits;
input [(K-1)*(N-K-1):0] generator_p;
output [N-1:0] codeword;

reg internal_gen_p [0:K-1][0:N-K-1];

initial
begin
    integer i, j, k;
    for(i = 0; i < K; i+=1) begin
        for(j = 0; j < N-K; j+=1) begin
            internal_gen_p[i][j] = generator[i*(N-K) + j];
        end
    end
    for(i = 0; i < N-K; i+=1) begin
        assign codeword[i+K] = 0;
        for(j = 0; j < K; j+=1) begin
            assign codeword[i] = codeword[i] ^ (info_bits[j] & internal_gen_p[i][j];
        end
    end
end


endmodule

module tb;
parameter N = 6;
parameter K = 3;

reg [K-1:0] info_bits;
reg [(K-1)*(N-1):0] generator;
wire [N-1:0] codeword;

initial
begin
    integer i, j;
    for(i = 0; i < K; i += 1) begin
        for(j = 0; j < N; j += 1) begin
            generator[i*N + j] = 1'b0;
        end
    end
end

encode #(.N(N), .K(K)) uut(.info_bits(info_bits), .generator(generator), .codeword(codeword));

initial
begin
    $dumpfile("encode_dump.vcd");
    $dumpvars(0, tb);
    info_bits = 3'b010;
    #10;
    $finish;
end

initial
begin
    $monitor("info=%x, code=%x", info_bits, codeword);
end
endmodule

