module streambuf_in(
    clk,
    rst,
    data_out
);

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 2;

input clk;
input rst;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] internal_mem [0:(2**ADDR_WIDTH)-1];

/* initial $readmemb("../util/input_1536.list", internal_mem); */
initial $readmemb("../util/input_test.list", internal_mem);

wire cnt_en, cnt_stop;
wire [ADDR_WIDTH-1:0] cnt_stop_val;
wire [ADDR_WIDTH-1:0] cnt_count;

assign cnt_en = 1;
assign cnt_stop_val = (2**ADDR_WIDTH)-1;

counter #(.COUNT_MAX_BITS(ADDR_WIDTH)) cnt(
    .clk(clk),
    .rst(rst),
    .en(cnt_en),
    .stop_val(cnt_stop_val),
    .count(cnt_count),
    .stop(cnt_stop)
);

always @(negedge clk)
begin
    if(cnt_stop) begin
        data_out = 'bz;
    end
    else begin
        data_out = internal_mem[cnt_count];
    end
end

endmodule
