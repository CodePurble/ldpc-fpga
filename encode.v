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
input [(K-1)*(N-K-1):0] generator_p;
output reg [N-1:0] codeword;

reg internal_gen_p [0:K-1][0:N-K-1];
reg [N-K-1:0] check_bits;

always @(posedge clk)
begin
    if(i_en)
    begin
        integer i, j, k;
        for(i = 0; i < K; i+=1)
        begin
            for(j = 0; j < N-K; j+=1)
            begin
                internal_gen_p[i][j] <= generator_p[i*(N-K) + j];
            end
        end
        for(i = 0; i < N-K; i+=1) begin
            check_bits[i] = 0;
            for(j = 0; j < K; j+=1) begin
                check_bits[i] <= check_bits[i] ^ (info_bits[j] & internal_gen_p[j][i]);
            end
        end
        codeword <= {info_bits, check_bits};
    end
    else codeword <= codeword;
end
endmodule

module tb;
parameter N = 6;
parameter K = 3;

reg clk, i_en;
reg [K-1:0] info_bits;
reg [(K-1)*(N-K-1):0] generator_p;
wire [N-1:0] codeword;

initial
begin
    integer i, j;
    for(i = 0; i < K; i += 1) begin
        for(j = 0; j < N; j += 1) begin
            generator_p[i*N + j] = 1'b0;
        end
    end
end

encode #(.N(N), .K(K)) uut(
    .info_bits(info_bits),
    .generator_p(generator_p),
    .codeword(codeword),
    .clk(clk),
    .i_en(i_en)
);

initial clk = 1'b1;
always #10 clk = ~clk;

initial
begin
    $dumpfile("encode_dump.vcd");
    $dumpvars(0, tb);
    i_en = 1;
    info_bits = 3'b010;
    #30 $finish;
end

initial
begin
    $monitor("info=%x, code=%x", info_bits, codeword);
end
endmodule

