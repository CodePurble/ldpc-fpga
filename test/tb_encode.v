module tb_encode;
parameter N = 11;
parameter K = 6;

reg clk, i_en;
reg [K-1:0] info_bits;
/* reg [((K)*(N-K))-1:0] generator_p; */
reg [(K*N)-1:0] generator_p;
wire [N-1:0] codeword;

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
    generator_p = 66'b100000101000100001001000100010001000100011000000100101000000101001;
    /* generator_p = 30'b101001001010001011000101001001; */
    i_en = 1;
    info_bits = 6'b111111;
    #30 $finish;
end

initial
begin
    $monitor("info=%b, code=%b", info_bits, codeword);
end
endmodule

