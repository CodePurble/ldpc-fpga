module tb_top();

parameter N = 11;
parameter K = 6;

reg clk, i_en;
reg [K-1:0] info_bits;
wire [N-1:0] codeword;

top #(.N(N), .K(K)) uut(
    .info_bits(info_bits),
    .codeword(codeword),
    .clk(clk),
    .i_en(i_en)
);

always #10 clk = ~clk;

initial
begin
    $dumpfile("../sim/tb_top.vcd");
    $dumpvars(0, tb_top);
    clk = 0;
    i_en = 1;
    #20 $finish;
end

initial
begin
    $monitor("info=%b, code=%b", info_bits, codeword);
end

endmodule

