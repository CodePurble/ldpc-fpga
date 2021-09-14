module encode(
    info_bits,
    generator,
    codeword
);
parameter N = 6;
parameter K = 3;

input [K-1:0] info_bits;
input [(K-1)*(N-1):0] generator;
output [N-1:0] codeword;

reg internal_gen [0:K-1][0:N-1];

initial
begin
    integer i, j;
    for(i = 0; i < K; i += 1) begin
        for(j = 0; j < N; j += 1) begin
            internal_gen[i][j] = generator[i*N + j];
        end
    end
    for(i = 0; i < K; i += 1) begin
        for(j = 0; j < N; j += 1) begin
            $display("gen[%1d][%1d] = %x", i, j, internal_gen[i][j]);
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

