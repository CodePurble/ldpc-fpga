module tb_encode;
parameter N = 6;
parameter K = 3;

reg clk, i_en;
reg [K-1:0] info_bits;
reg [(K-1)*(N-K-1):0] generator_p;
wire [N-1:0] codeword;

initial
begin: foo
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
    $dumpfile("../sim/tb_encode_dump.vcd");
    $dumpvars(0, tb_encode);
    i_en = 1;
    info_bits = 3'b010;
    #30 $finish;
end

initial
begin
    $monitor("info=%x, code=%x", info_bits, codeword);
end
endmodule

