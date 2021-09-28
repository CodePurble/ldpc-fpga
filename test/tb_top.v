module tb_top();

parameter N = 11;
parameter K = 6;
reg enc_i_en, clk;
reg [K-1:0] info_bits;
reg [(K*N)-1:0] generator;
wire [N-1:0] codeword;

top #(.N(N), .K(K)) uut(
    .info_bits(info_bits),
    .generator(generator),
    .codeword(codeword),
    .clk(clk),
    .i_en(enc_i_en)
);

reg [N-1:0] pmat_mem [0:K-1];

initial
begin
    clk = 0;
    enc_i_en = 0;

    $dumpfile("../sim/tb_top.vcd");
    $dumpvars(0, tb_top);
    $readmemb("../g1.list", pmat_mem);
end
always #10 clk = ~clk;

initial
begin: info
    integer i;
    for(i = 0; i < K; i=i+1) begin
        generator = {generator, pmat_mem[i]};
    end
    $display("gen:%b", generator);
    info_bits = 6'b111111;
    #10 enc_i_en = 1;
    #20 $finish;
end

initial
begin
    $monitor("code: %b", codeword);
end

endmodule

