module encoder(
    // Signals for counter
    cnt_rst,
    cnt_en,
    cnt_stop_val,
    // Signals for mod2mul
    mul_info_bits,
    // Signals for encoder
    codeword,
    // Common signals
    clk
);

parameter N = 2304;
parameter K = 1536;
parameter COUNT_MAX_BITS = 12; // ceil(log2(N))

/* parameter N = 11;
parameter K = 6;
parameter COUNT_MAX_BITS = 4; // ceil(log2(N)) */

// counter
input cnt_rst;
input cnt_en;
input [COUNT_MAX_BITS-1:0] cnt_stop_val;
wire [COUNT_MAX_BITS-1:0] cnt_count;
wire cnt_stop;
// mod2mul
input [K-1:0] mul_info_bits;
// encoder
output reg [N-1:0] codeword;
// common
input clk;

// internal
reg [K-1:0] curr_col;
reg [K-1:0] g_transpose [0:N-1];
wire code_bit;

initial $readmemb("../util/G_wimax_ieee802_16_N2304_M768_transpose.list", g_transpose);
/* initial $readmemb("../util/g1_transpose.list", g_transpose); */

mod2mul #(.K(K)) mul(
    .info_bits(mul_info_bits),
    .generator_col(curr_col),
    .code_bit(code_bit)
);

counter #(.COUNT_MAX_BITS(COUNT_MAX_BITS)) cnt(
    .clk(clk),
    .rst(cnt_rst),
    .en(cnt_en),
    .stop_val(cnt_stop_val),
    .count(cnt_count),
    .stop(cnt_stop)
);

always @(negedge clk)
begin: encode
    if(cnt_stop == 0) begin
        curr_col <= g_transpose[cnt_count];
        codeword[N-cnt_count] <= code_bit;
    end
end

endmodule
