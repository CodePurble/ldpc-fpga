module tb_mod2mul;
parameter N = 11;
parameter K = 6;

reg [K-1:0] info_bit_slice;
reg [K-1:0] generator_col_slice;
wire code_bit;

mod2mul #(.SLICE_SIZE(K)) uut(
    .info_bit_slice(info_bit_slice),
    .generator_col_slice(generator_col_slice),
    .code_bit(code_bit)
);

initial
begin: foo
    integer i;
    $dumpfile("../sim/tb_mod2mul_dump.vcd");
    $dumpvars(0, tb_mod2mul);
    info_bit_slice = 6'b111111;
    for(i = 0; i < K; i = i + 1) begin
        generator_col_slice = i;
        #10;
        $display("info=%b, generator_col_slice=%b, code_bit=%b",
            info_bit_slice, generator_col_slice, code_bit);
    end
end

/* initial
begin
    $monitor("info=%b, generator_col_slice=%b, code_bit=%b",
        info_bit_slice, generator_col_slice, code_bit);
end */
endmodule

