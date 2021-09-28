module tb_encode;
parameter N = 11;
parameter K = 6;

reg [K-1:0] info_bits;
reg [K-1:0] generator_col;
wire code_bit;

encode #(.K(K)) uut(
    .info_bits(info_bits),
    .generator_col(generator_col),
    .code_bit(code_bit)
);

initial
begin: foo
    integer i;
    $dumpfile("../sim/tb_encode_dump.vcd");
    $dumpvars(0, tb_encode);
    info_bits = 6'b111111;
    for(i = 0; i < K; i = i + 1) begin
        generator_col = i;
        #10;
        $display("info=%b, generator_col=%b, code_bit=%b",
            info_bits, generator_col, code_bit);
    end
end

/* initial
begin
    $monitor("info=%b, generator_col=%b, code_bit=%b",
        info_bits, generator_col, code_bit);
end */
endmodule

