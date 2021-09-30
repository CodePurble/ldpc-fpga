module encoder(
    // Signals for counter
    cnt_rst,
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
parameter MAX_BITS_N = 12; // ceil(log2(N))
parameter MAX_BITS_SLICE = 7; // ceil(log2(K/DATA_WIDTH))
parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 4;

/* parameter N = 11;
parameter K = 6;
parameter COUNT_MAX_BITS = 4; // ceil(log2(N)) */

// counter
input cnt_rst;
input [COUNT_MAX_BITS-1:0] cnt_stop_val;
wire [COUNT_MAX_BITS-1:0] cnt_count;
wire cnt_stop;
// encoder
output reg [DATA_WIDTH-1:0] codeword;
// common
input clk;

reg [K-1:0] g_transpose [0:N-1];
initial $readmemb("../util/G_wimax_ieee802_16_N2304_M768_transpose.list", g_transpose);
/* initial $readmemb("../util/g1_transpose.list", g_transpose); */

reg [DATA_WIDTH-1:0] mul_info_bits;
reg [DATA_WIDTH-1:0] curr_col;
wire code_bit;
mod2mul #(.K(K)) mul(
    .info_bits(mul_info_bits),
    .generator_col(curr_slice),
    .code_bit(code_bit)
);

reg cnt_en;
counter #(.COUNT_MAX_BITS(MAX_BITS_N)) cnt(
    .clk(clk),
    .rst(cnt_rst),
    .en(cnt_en),
    .stop_val(cnt_stop_val),
    .count(cnt_count),
    .stop(cnt_stop)
);

reg bit_hold;
reg [DATA_WIDTH-1:0] curr_slice;
reg [MAX_BITS_SLICE-1:0] start;
always @(negedge clk)
begin: encode
    if(cnt_stop == 0) begin
        curr_col = g_transpose[cnt_count];
        curr_slice = curr_col[start:start+DATA_WIDTH];
        bit_hold = bit_hold ^ code_bit;
    end
end

endmodule
